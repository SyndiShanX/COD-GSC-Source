/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots.gsc
***********************************************/

function main() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }

  if(getdvarint("LLQQOPKTKM") == 1) {
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

function codecallback_leaderdialog(var0, var1) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["leader_dialog"])) {
    self[[level.bot_funcs["leader_dialog"]]](var0, var1);
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
  var0 = botsystemstatus();

  if(var0 == "enabled_fill_open" || var0 == "enabled_fill_open_dev") {
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
    var0 = [[level.teleportgetactivenodesfunc]]();
    level.bot_map_min_x = 0;
    level.bot_map_max_x = 0;
    level.bot_map_min_y = 0;
    level.bot_map_max_y = 0;
    level.bot_map_min_z = 0;
    level.bot_map_max_z = 0;

    if(var0.size > 1) {
      level.bot_map_min_x = var0[0].origin[0];
      level.bot_map_max_x = var0[0].origin[0];
      level.bot_map_min_y = var0[0].origin[1];
      level.bot_map_max_y = var0[0].origin[1];
      level.bot_map_min_z = var0[0].origin[2];
      level.bot_map_max_z = var0[0].origin[2];

      for(var1 = 1; var1 < var0.size; var1++) {
        var2 = var0[var1].origin;

        if(var2[0] < level.bot_map_min_x) {
          level.bot_map_min_x = var2[0];
        }

        if(var2[0] > level.bot_map_max_x) {
          level.bot_map_max_x = var2[0];
        }

        if(var2[1] < level.bot_map_min_y) {
          level.bot_map_min_y = var2[1];
        }

        if(var2[1] > level.bot_map_max_y) {
          level.bot_map_max_y = var2[1];
        }

        if(var2[2] < level.bot_map_min_z) {
          level.bot_map_min_z = var2[2];
        }

        if(var2[2] > level.bot_map_max_z) {
          level.bot_map_max_z = var2[2];
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

  foreach(var1 in level.players) {
    if(isbot(var1)) {
      if(isalive(var1)) {
        var1.equipment_enabled = 1;
        var1.bot_team = var1.team;
        var1.debug_ai_aggro = 1;
        var1 thread[[level.bot_funcs["think"]]]();
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
    level waittill("connected", var0);

    if(!isai(var0) && level.players.size > 0) {
      level.players_waiting_to_join = scripts\engine\utility::array_add(level.players_waiting_to_join, var0);
      GscBinSkip4(0x35, var0);
    }
  }
}

function bots_notify_on_spawn(var0) {
  var0 endon("bots_human_disconnected");

  while(!scripts\engine\utility::array_contains(level.players, var0)) {
    wait 0.05;
  }

  var0 notify("bots_human_spawned");
}

function bots_notify_on_disconnect(var0) {
  var0 endon("bots_human_spawned");
  var0 waittill("disconnect");
  var0 notify("bots_human_disconnected");
}

function bots_remove_from_array_on_notify(var0) {
  var0 scripts\engine\utility::ref_143a5("bots_human_spawned", "bots_human_disconnected");
  level.players_waiting_to_join = scripts\engine\utility::array_remove(level.players_waiting_to_join, var0);
}

function monitor_pause_spawning() {
  level.players_waiting_to_join = [];
  GscBinSkip4(0x35);
}

function bot_can_join_team(var0) {
  if(scripts\mp\utility\game::matchmakinggame()) {
    return true;
  }

  if(!level.teambased) {
    return true;
  }

  if(scripts\mp\teams::getjointeampermissions(var0)) {
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
  var0 = 1.5;

  for(;;) {
    level.bot_max_players_on_team["allies"] = 0;
    level.bot_max_players_on_team["axis"] = 0;

    foreach(var2 in level.players) {
      if(isDefined(var2.team) && (var2.team == "allies" || var2.team == "axis")) {
        level.bot_max_players_on_team[var2.team]++;
      }
    }

    update_max_players_from_team_agents();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var0);
  }
}

function update_max_players_from_team_agents() {
  if(isDefined(level.agentarray)) {
    foreach(var1 in level.agentarray) {
      if(isDefined(var1.isactive) && var1.isactive) {
        if(scripts\mp\utility\entity::isteamparticipant(var1) && isDefined(var1.team) && (var1.team == "allies" || var1.team == "axis")) {
          level.bot_max_players_on_team[var1.team]++;
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
  foreach(var1 in level.players) {
    if(!isai(var1) && var1 ishost()) {
      return bot_get_player_team(var1);
    }
  }

  return "spectator";
}

function bot_get_human_picked_team() {
  var0 = 0;
  var1 = 0;
  var2 = 0;

  foreach(var4 in level.players) {
    if(!isai(var4)) {
      if(var4 ishost()) {
        var0 = 1;
      }

      if(player_picked_team(var4)) {
        var1 = 1;

        if(var4 ishost()) {
          var2 = 1;
        }
      }
    }
  }

  return var2 || var1 && !var0;
}

function player_picked_team(var0) {
  if(isDefined(var0.team) && var0.team != "spectator") {
    return true;
  }

  if(isDefined(var0.spectating_actively) && var0.spectating_actively) {
    return true;
  }

  if(var0 ismlgspectator() && isDefined(var0.team) && var0.team == "spectator") {
    return true;
  }

  return false;
}

function damageskipburndownlow() {
  var0 = 0;
  var1 = 0;
  var2 = 0;

  foreach(var4 in level.players) {
    if(!isai(var4)) {
      if(var4 ishost()) {
        var0 = 1;
      }

      if(isDefined(var4.class)) {
        var1 = 1;

        if(var4 ishost()) {
          var2 = 1;
        }
      }
    }
  }

  return var2 || var1 && !var0;
}

function bot_client_counts() {
  var0 = [];

  for(var1 = 0; var1 < level.players.size; var1++) {
    var2 = level.players[var1];

    if(isDefined(var2) && isDefined(var2.team)) {
      var0 = cat_array_add(var0, "all");
      var0 = cat_array_add(var0, var2.team);

      if(isbot(var2)) {
        var0 = cat_array_add(var0, "bots");
        var0 = cat_array_add(var0, "bots_" + var2.team);
        continue;
      }

      var0 = cat_array_add(var0, "humans");
      var0 = cat_array_add(var0, "humans_" + var2.team);
    }
  }

  return var0;
}

function cat_array_add(var0, var1) {
  if(!isDefined(var0)) {
    var0 = [];
  }

  if(!isDefined(var0[var1])) {
    var0 = 0;
  }

  var0 = var0[var1] + 1;
  return var0;
}

function cat_array_get(var0, var1) {
  if(!isDefined(var0)) {
    return 0;
  }

  if(!isDefined(var0[var1])) {
    return 0;
  }

  return var0[var1];
}

function move_bots_from_team_to_team(var0, var1, var2, var3) {
  foreach(var5 in level.players) {
    if(!isDefined(var5.team)) {
      continue;
    }

    if(isDefined(var5.connected) && var5.connected && isbot(var5) && var5.team == var1) {
      var5.bot_team = var2;

      if(isDefined(var3)) {
        var5 scripts\mp\bots\bots_util::bot_set_difficulty(var3);
      }

      var5 notify("luinotifyserver", "team_select", bot_lui_convert_team_to_int(var2));
      wait 0.05;
      var5 notify("loadout_class_selected", var5.bot_class);
      var0--;

      if(var0 <= 0) {
        break;
      }

      wait 0.1;
    }
  }
}

function bots_update_difficulty(var0, var1) {
  foreach(var3 in level.players) {
    if(!isDefined(var3.team)) {
      continue;
    }

    if(isDefined(var3.connected) && var3.connected && isbot(var3) && var3.team == var0) {
      if(var1 != var3 botgetdifficulty()) {
        var3 scripts\mp\bots\bots_util::bot_set_difficulty(var1);
      }
    }
  }
}

function bot_drop() {
  kick(self.entity_number, "EXE/PLAYERKICKED_BOT_BALANCE");
  wait 0.1;
}

function drop_bots(var0, var1) {
  var2 = [];

  foreach(var4 in level.players) {
    if(isDefined(var4.connected) && var4.connected && isbot(var4) && (!isDefined(var1) || isDefined(var4.team) && var4.team == var1)) {
      var2 = var4;
    }
  }

  for(var6 = var2.size - 1; var6 >= 0; var6--) {
    if(var0 <= 0) {
      break;
    }

    if(!var2[var6] scripts\cp_mp\utility\player_utility::_isalive()) {
      bot_drop(var2[var6]);
      var2 = scripts\engine\utility::array_remove(var2, var2[var6]);
      var0--;
    }
  }

  for(var6 = var2.size - 1; var6 >= 0; var6--) {
    if(var0 <= 0) {
      break;
    }

    bot_drop(var2[var6]);
    var0--;
  }
}

function bot_lui_convert_team_to_int(var0) {
  if(var0 == "axis") {
    return 0;
  }

  if(var0 == "allies") {
    return 1;
  }

  if(var0 == "autoassign" || var0 == "random") {
    return 2;
  }

  return 3;
}

function spawn_bot_latent(var0, var1, var2) {
  var3 = gettime() + 60000;

  while(!self canspawnbotortestclient()) {
    if(gettime() >= var3) {
      kick(self.entity_number, "EXE/PLAYERKICKED_BOT_BALANCE");
      var2.abort = 1;
      return;
    }

    wait 0.05;

    if(!isDefined(self)) {
      var2.abort = 1;
      return;
    }
  }

  if(!scripts\mp\bots\bots_util::dev_spawning_bots()) {
    var4 = randomfloatrange(0.25, 2);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var4);
  }

  if(!isDefined(self)) {
    var2.abort = 1;
    return;
  }

  self spawnbotortestclient();
  self.equipment_enabled = 1;
  self.bot_team = var0;

  if(isDefined(var2.difficulty)) {
    scripts\mp\bots\bots_util::bot_set_difficulty(var2.difficulty);
  }

  if(isDefined(var1)) {
    self[[var1]]();
  }

  self thread[[level.bot_funcs["think"]]]();
  var2.ready = 1;
}

function spawn_bots(var0, var1, var2, var3, var4, var5) {
  var6 = gettime() + 15000;
  var7 = [];

  for(var8 = var7.size; level.players.size < scripts\mp\bots\bots_util::bot_get_client_limit() && var7.size < var0 && gettime() < var6; var8++) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.05);
    var9 = undefined;

    if(isbotmatchmakingenabled()) {
      if(level.teambased) {
        var9 = addmpbottoteam(var1);
      } else {
        var9 = addmpbottoteam("none");
      }
    } else {
      var9 = addbot("");
    }

    if(!isDefined(var9)) {
      if(isDefined(var3) && var3) {
        if(isDefined(var4)) {
          self notify(var4);
        }

        return;
      }

      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
      continue;
    }

    var10 = spawnStruct();
    var10.bot = var9;
    var10.ready = 0;
    var10.abort = 0;
    var10.index = var8;
    var10.difficulty = var5;
    var7 = var10;
    thread spawn_bot_latent(var10.bot, var1, var2);
  }

  var11 = 0;
  var6 = gettime() + 60000;

  while(var11 < var7.size && gettime() < var6) {
    var11 = 0;

    foreach(var10 in var7) {
      if(var10.ready || var10.abort) {
        var11++;
      }
    }

    wait 0.05;
  }

  if(isDefined(var4)) {
    self notify(var4);
    return;
  }
}

function bot_gametype_chooses_team() {
  if(scripts\mp\utility\game::matchmakinggame() && self.sessionteam != "none") {
    var0 = 0;
  } else if(!scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::denysystemicteamchoice() && scripts\mp\utility\game::doesmodesupportplayerteamchoice()) {
    var0 = 1;
  } else {
    var0 = 0;
  }

  return !var0;
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

  var0 = self.bot_team;

  if(!isDefined(var0)) {
    var0 = self.pers["team"];
  }

  self.entity_number = self getentitynumber();
  var1 = 0;
  jumpiftrue(isDefined(self.debug_ai_aggro)) LOC_00000103;
  var1 = 1;
  self.debug_ai_aggro = 1;
  jumpiftrue(bot_gametype_chooses_team()) LOC_00000103;
  var2 = self.pers["team"] != "spectator" && !isDefined(self.bot_team);

  if(!var2) {
    var3 = isDefined(self.bot_team) && self.bot_team != self.pers["team"];

    if(var3) {
      self notify("luinotifyserver", "team_select", bot_lui_convert_team_to_int(var0));
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
    var4 = self botgetdifficultysetting("advancedPersonality");

    if(var1 && isDefined(var4) && var4 != 0) {
      scripts\mp\bots\bots_personality::bot_balance_personality();
    }

    scripts\mp\bots\bots_personality::bot_assign_personality_functions();

    if(var1) {
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
        self.bot_team = var0;
      }

      if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["know_enemies_on_start"])) {
        self thread[[level.bot_funcs["know_enemies_on_start"]]]();
      }

      var1 = 0;
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

  var0 = self botgetdifficulty();
  var1 = "bot_rank_" + var0;

  if(isDefined(self.pers[var1]) && self.pers[var1] > 0) {
    return self.pers[var1];
  }

  var2 = bot_random_ranks_for_difficulty(var0);
  var3 = var2["rank"];
  var4 = var2["prestige"];
  var5 = scripts\mp\rank::getrankinfominxp(var3);
  var6 = var5 + scripts\mp\rank::getrankinfoxpamt(var3);
  var7 = randomintrange(var5, var6 + 1);
  self.pers[var1] = var7;
  return var7;
}

function bot_3d_sighting_model(var0) {
  thread bot_3d_sighting_model_thread(var0);
}

function bot_3d_sighting_model_thread(var0) {
  var0 endon("disconnect");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(isalive(self) && !self botcanseeentity(var0) && scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var0.origin, self botgetfovdot())) {
      self botgetimperfectenemyinfo(var0, var0.origin);
    }

    wait 0.1;
  }
}

function bot_random_ranks_for_difficulty(var0) {
  var1 = [];
  GscBinSkip0(0x2e, "rank", 0);
}

function crate_can_use_always(var0) {
  if(isagent(self) && !isDefined(var0.boxtype)) {
    return false;
  }

  if(isDefined(var0.cratetype) && !scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var0.cratetype)) {
    return false;
  }

  return true;
}

function get_human_player() {
  var0 = undefined;
  var1 = getEntArray("player", "classname");

  if(isDefined(var1)) {
    for(var2 = 0; var2 < var1.size; var2++) {
      if(isDefined(var1[var2]) && isDefined(var1[var2].connected) && var1[var2].connected && !isai(var1[var2]) && (!isDefined(var0) || var0.team == "spectator")) {
        var0 = var1[var2];
      }
    }
  }

  return var0;
}

function bot_damage_callback(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(var2 == "MOD_FALLING" || var2 == "MOD_SUICIDE") {
    return;
  }

  if(var1 <= 0) {
    return;
  }

  if(!isDefined(var4)) {
    if(!isDefined(var0)) {
      return;
    }

    var4 = var0;
  }

  if(isDefined(var4)) {
    if(isDefined(self.fnbotdamagecallback)) {
      self[[self.fnbotdamagecallback]](var0, var1, var2, var3, var4, var5);
    }

    if(level.teambased) {
      if(isDefined(var4.team) && var4.team == self.team) {
        return;
      } else if(isDefined(var0) && isDefined(var0.team) && var0.team == self.team) {
        return;
      }
    }

    var6 = scripts\mp\bots\bots_util::bot_get_known_attacker(var0, var4);

    if(isDefined(var6)) {
      self botsetattacker(var6);
    }
  }

  if(isagent(self)) {
    self notify("agentDamage");
    return;
  }
}

function on_bot_killed(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  self botclearscriptenemy();
  self botclearscriptgoal();
  var10 = scripts\mp\bots\bots_util::bot_get_known_attacker(var1, var0);

  if(isDefined(var10) && (var10.classname == "script_vehicle" || var10.classname == "script_model") && isDefined(var10.helitype)) {
    var11 = self botgetdifficultysetting("launcherRespawnChance");

    if(randomfloat(1) < var11) {
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

  var5 = 0;
  var6 = self botgetdifficulty();

  if(var6 == "recruit") {
    var5 = 0.1;
  } else if(var6 == "regular") {
    var5 = 0.4;
  } else if(var6 == "hardened") {
    var5 = 0.7;
  } else if(var6 == "veteran") {
    var5 = 1;
  }

  return randomfloat(1) < 1 - var5;
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

function sortdoorsbydistance(var0, var1) {
  return distancesquared(var0.origin, self.closestdoorpos) < distancesquared(var1.origin, self.closestdoorpos);
}

function bot_think_dynamic_doors() {
  self notify("bot_think_dynamic_doors");
  self endon("bot_think_dynamic_doors");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var0 = self getmodifierlocationonpath("door", 64);

    if(isDefined(var0)) {
      self.closestdoorpos = var0;
      var1 = getentarrayinradius("dynamic_door", "targetname", var0, 64);

      if(var1.size > 0) {
        var1 = scripts\engine\utility::array_sort_with_func(var1, &sortdoorsbydistance);
        var2 = var1[0];

        if(isDefined(var2.state) && var2 scripts\mp\door::door_can_open_check()) {
          var2 thread scripts\mp\door::cheapopen(self);
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
  var0 = scripts\cp_mp\utility\game_utility::isnightmap();

  for(;;) {
    var1 = 0;
    var2 = 0;

    if(isDefined(level.bot_light_volumes)) {
      foreach(var4 in level.bot_light_volumes) {
        if(self istouching(var4)) {
          var2 = 1;
          break;
        }
      }
    }

    if(isDefined(level.bot_dark_volumes)) {
      foreach(var4 in level.bot_dark_volumes) {
        if(self istouching(var4)) {
          var1 = 1;
          break;
        }
      }
    }

    if(istrue(self.inmotionlight)) {
      var2 = 1;
    }

    if(var1 || var0 && !var2) {
      self botsetflag("dark_area", 1);
      self.indarkarea = 1;
    } else if(!var1 && istrue(self.indarkarea)) {
      self botsetflag("dark_area", 0);
      self.indarkarea = 0;
    }

    wait 0.25;
  }
}

function bot_think_watch_enemy(var0) {
  var1 = "spawned_player";

  if(isDefined(var0) && var0) {
    var1 = "death";
  }

  self notify("bot_think_watch_enemy");
  self endon("bot_think_watch_enemy");
  self endon(var1);
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
  var0 = "throwingknife_mp";

  for(;;) {
    var1 = 0;

    if(scripts\mp\bots\bots_util::damagestatedata(0.33)) {
      if(self[[level.bot_funcs["should_pickup_weapons"]]]() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
        var2 = getEntArray("dropped_weapon", "targetname");
        var3 = scripts\engine\utility::get_array_of_closest(self.origin, var2);

        if(var3.size > 0) {
          var4 = var3[0];
          bot_seek_dropped_weapon(var4);
        }
      }
    }

    if(!scripts\mp\bots\bots_util::bot_in_combat() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked() && self botgetdifficultysetting("strategyLevel") > 0) {
      var5 = self hasweapon(var0);
      var6 = var5 && self getammocount(var0) == 0;

      if(var6) {
        if(isDefined(self.going_for_knife)) {
          wait 5;
          continue;
        }

        var7 = getEntArray("dropped_knife", "targetname");
        var8 = scripts\engine\utility::get_array_of_closest(self.origin, var7);

        foreach(var10 in var8) {
          if(!isDefined(var10)) {
            continue;
          }

          if(!isDefined(var10.calculated_closest_point)) {
            var11 = scripts\mp\bots\bots_util::bot_queued_process("BotGetClosestNavigablePoint", &scripts\mp\bots\bots_util::func_bot_get_closest_navigable_point, var10.origin, 32, self);

            if(isDefined(var10)) {
              var10.closest_point_on_grid = var11;
              var10.calculated_closest_point = 1;
            } else {
              continue;
            }
          }

          if(isDefined(var10.closest_point_on_grid)) {
            self.going_for_knife = 1;
            bot_seek_dropped_weapon(var10);
          }
        }
      } else if(var5) {
        self.going_for_knife = undefined;
      }
    }

    wait randomfloatrange(0.25, 0.75);
  }
}

function bot_seek_dropped_weapon(var0) {
  if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("seek_dropped_weapon", var0) == 0) {
    var1 = undefined;

    if(var0.targetname == "dropped_weapon") {
      var2 = 1;
      var3 = self getweaponslistprimaries();

      foreach(var5 in var3) {
        if(var0.model == getweaponmodel(var5)) {
          var2 = 0;
        }
      }

      if(var2) {
        var1 = &bot_pickup_weapon;
      }
    }

    var7 = spawnStruct();
    var7.object = var0;
    var7.script_goal_radius = 12;
    var7.should_abort = level.bot_funcs["dropped_weapon_cancel"];
    var7.action_thread = var1;
    scripts\mp\bots\bots_strategy::bot_new_tactical_goal("seek_dropped_weapon", var0.origin, 100, var7);
    return;
  }
}

function bot_pickup_weapon(var0) {
  self botpressbutton("use", 2);
  wait 2;
}

function should_stop_seeking_weapon(var0) {
  if(!isDefined(var0.object)) {
    return true;
  }

  if(var0.object.targetname == "dropped_weapon") {
    if(scripts\mp\bots\bots_util::bot_get_total_gun_ammo() > 0) {
      return true;
    }
  } else if(var0.object.targetname == "dropped_knife") {
    if(scripts\mp\bots\bots_util::bot_in_combat()) {
      self.going_for_knife = undefined;
      return true;
    }
  }

  return false;
}

function crate_in_range(var0) {
  if(!isDefined(var0.owner) || var0.owner != self) {
    if(distancesquared(self.origin, var0.origin) > 4194304) {
      return false;
    }
  }

  return true;
}

function bot_crate_valid(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  var1 = self[[level.bot_funcs["crate_can_use"]]](var0);

  if(!var1) {
    if(scripts\mp\utility\game::getgametype() == "grnd") {
      var1 = 1;
    }
  }

  if(!var1) {
    return false;
  }

  if(!crate_landed_and_on_path_grid(var0)) {
    return false;
  }

  if(level.teambased && isDefined(var0.bomb) && isDefined(var0.team) && var0.team == self.team) {
    return false;
  }

  if(!self[[level.bot_funcs["crate_in_range"]]](var0)) {
    return false;
  }

  if(!isDefined(level.bot_can_use_box_by_type)) {
    return false;
  }

  if(isDefined(var0.boxtype)) {
    if(isDefined(level.boxsettings) && isDefined(level.boxsettings[var0.boxtype]) && ![[level.boxsettings[var0.boxtype].canusecallback]]()) {
      return false;
    }

    if(isDefined(var0.disabled_use_for) && isDefined(var0.disabled_use_for[self getentitynumber()]) && var0.disabled_use_for[self getentitynumber()]) {
      return false;
    }

    if(!self[[level.bot_can_use_box_by_type[var0.boxtype]]](var0)) {
      return false;
    }
  } else if(datakey(var0)) {
    return false;
  }

  return isDefined(var0);
}

function datakey(var0) {
  return false;
}

function crate_landed_and_on_path_grid(var0) {
  if(!crate_has_landed(var0)) {
    return false;
  }

  if(!crate_is_on_path_grid(var0)) {
    return false;
  }

  return isDefined(var0);
}

function crate_has_landed(var0) {
  if(isDefined(var0.boxtype)) {
    return (gettime() > var0.birthtime + 1000);
  }

  return isDefined(var0.droppingtoground) && !var0.droppingtoground;
}

function crate_is_on_path_grid(var0) {
  if(!isDefined(var0.on_path_grid)) {
    crate_calculate_on_path_grid(var0);
  }

  return isDefined(var0) && var0.on_path_grid;
}

function node_within_use_radius_of_crate(var0, var1) {
  if(isDefined(var1.boxtype) && var1.boxtype == "scavenger_bag") {
    return (abs(var0.origin[0] - var1.origin[0]) < 36 && abs(var0.origin[0] - var1.origin[0]) < 36 && abs(var0.origin[0] - var1.origin[0]) < 18);
  }

  var2 = getdvarfloat("MTOQQKKRPS");
  var3 = distancesquared(var1.origin, var0.origin + (0, 0, 40));
  return var3 <= var2 * var2;
}

function crate_calculate_on_path_grid(var0) {
  thread crate_monitor_position();
  var0.on_path_grid = 0;
  var1 = undefined;
  var2 = undefined;

  if(isDefined(var0.forcedisconnectuntil)) {
    var1 = var0.forcedisconnectuntil;
    var2 = gettime() + 30000;
    var0.forcedisconnectuntil = var2;
    var0 notify("path_disconnect");
  }

  wait 0.05;

  if(!isDefined(var0)) {
    return;
  }

  var3 = crate_get_nearest_valid_nodes(var0);

  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var3) && var3.size > 0) {
    var0.nearest_nodes = var3;
    var0.on_path_grid = 1;
  } else {
    var4 = getdvarfloat("MTOQQKKRPS");
    var5 = getnodesinradiussorted(var0.origin, var4 * 2, 0)[0];
    var6 = var0 getpointinbounds(0, 0, -1);
    var7 = undefined;

    if(isDefined(var0.boxtype) && var0.boxtype == "scavenger_bag") {
      if(scripts\mp\bots\bots_util::bot_point_is_on_pathgrid(var0.origin, var4)) {
        var7 = var0.origin;
      }
    } else {
      var7 = botgetclosestnavigablepoint(var0.origin, var4);
    }

    if(isDefined(var5) && !var5 nodeisdisconnected() && isDefined(var7) && abs(var5.origin[2] - var6[2]) < 30) {
      var0.nearest_points = [var7];
      var0.nearest_nodes = [var5];
      var0.on_path_grid = 1;
    }
  }

  if(isDefined(var0.forcedisconnectuntil)) {
    if(var0.forcedisconnectuntil == var2) {
      var0.forcedisconnectuntil = var1;
      return;
    }

    return;
  }
}

function crate_get_nearest_valid_nodes(var0) {
  var1 = getnodesinradiussorted(var0.origin, 256, 0);

  for(var2 = var1.size; var2 > 0; var2--) {
    var1 = var1[var2 - 1];
  }

  var1 = getclosestnodeinsight(var0.origin);
  var3 = undefined;

  if(isDefined(var0.forcedisconnectuntil)) {
    var3 = getsentientcounts();
  }

  var4 = [];
  var5 = 1;

  if(!isDefined(var0.boxtype)) {
    var5 = 2;
  }

  for(var2 = 0; var2 < var1.size; var2++) {
    var6 = var1[var2];

    if(!isDefined(var6) || !isDefined(var0)) {
      continue;
    }

    if(var6 nodeisdisconnected()) {
      continue;
    }

    if(!node_within_use_radius_of_crate(var6, var0)) {
      if(var2 == 0) {
        continue;
      } else {
        break;
      }
    }

    wait 0.05;

    if(!isDefined(var0)) {
      break;
    }

    if(sighttracepassed(var0.origin, var6.origin + (0, 0, 55), 0, var0)) {
      wait 0.05;

      if(!isDefined(var0)) {
        break;
      }

      if(!isDefined(var0.forcedisconnectuntil)) {
        var4 = var6;

        if(var4.size == var5) {
          return var4;
        } else {
          continue;
        }
      }

      var7 = undefined;
      var8 = 0;

      while(!isDefined(var7) && var8 < 100) {
        var8++;
        var9 = randomint(var3);
        var10 = nvidiahighlightsrequestpermissions(var9);

        if(isDefined(var10) && distancesquared(var6.origin, var10.origin) > 250000) {
          var7 = var10;
        }
      }

      if(isDefined(var7)) {
        var11 = scripts\mp\bots\bots_util::bot_queued_process("GetNodesOnPathCrate", &scripts\mp\bots\bots_util::func_get_nodes_on_path, var6.origin, var7.origin);

        if(isDefined(var11)) {
          var4 = var6;

          if(var4.size == var5) {
            return var4;
          }
        }
      }
    }
  }

  return undefined;
}

function crate_get_bot_target(var0) {
  if(isDefined(var0.nearest_points)) {
    return var0.nearest_points[0];
  }

  if(isDefined(var0.nearest_nodes) && var0.nearest_nodes.size > 0) {
    if(var0.nearest_nodes.size > 1) {
      var1 = scripts\engine\utility::array_reverse(self botnodescoremultiple(var0.nearest_nodes, "node_exposed"));
      return scripts\engine\utility::random_weight_sorted(var1).origin;
    }

    return var1.nearest_nodes[0].origin;
  }
}

function crate_get_bot_target_check_distance(var0, var1) {
  var2 = crate_get_bot_target(var0);
  var2 = getclosestpointonnavmesh(var2, self);
  var3 = var1 * 0.9;
  var3 *= var3;

  if(distancesquared(var0.origin, var2) <= var3) {
    return var2;
  }

  return undefined;
}

function bot_think_crate() {
  self notify("bot_think_crate");
  self endon("bot_think_crate");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var0 = getdvarfloat("MTOQQKKRPS");

  for(;;) {
    var1 = randomfloatrange(2, 4);
    scripts\engine\utility::waittill_notify_or_timeout("new_crate_to_take", var1);

    if(isDefined(self.boxes) && self.boxes.size == 0) {
      self.boxes = undefined;
    }

    var2 = level.carepackages;

    if(!scripts\mp\bots\bots_util::bot_in_combat() && isDefined(self.boxes)) {
      var2 = scripts\engine\utility::array_combine(var2, self.boxes);
    }

    if(isDefined(level.bot_scavenger_bags) && scripts\mp\utility\perk::_hasperk("specialty_scavenger")) {
      var2 = scripts\engine\utility::array_combine(var2, level.bot_scavenger_bags);
    }

    var2 = scripts\engine\utility::array_removeundefined(var2);

    if(var2.size == 0) {
      continue;
    }

    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("airdrop_crate") || self botgetscriptgoaltype() == "tactical" || scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
      continue;
    }

    var3 = [];

    foreach(var6, var5 in var2) {
      if(bot_crate_valid(var5)) {
        var3 = var5;
      }
    }

    var3 = scripts\engine\utility::array_remove_duplicates(var3);

    if(var3.size == 0) {
      continue;
    }

    var3 = scripts\engine\utility::get_array_of_closest(self.origin, var3);
    var7 = self getnearestnode();

    if(!isDefined(var7)) {
      continue;
    }

    var8 = self[[level.bot_funcs["crate_low_ammo_check"]]]();
    var9 = (var8 || randomint(100) < 50) && !scripts\cp_mp\emp_debuff::is_empd();
    var10 = undefined;

    foreach(var5 in var3) {
      var12 = 0;

      if((!isDefined(var5.owner) || var5.owner != self) && !isDefined(var5.boxtype)) {
        var13 = [];

        foreach(var15 in level.players) {
          if(!isDefined(var15.team)) {
            continue;
          }

          if(!isai(var15) && level.teambased && var15.team == self.team) {
            if(distancesquared(var15.origin, var5.origin) < 490000) {
              var13 = var15;
            }
          }
        }

        if(var13.size > 0) {
          var17 = var13[0] getnearestnode();

          if(isDefined(var17)) {
            var12 = 0;

            foreach(var19 in var5.nearest_nodes) {
              var12 |= nodesvisible(var17, var19, 1);
            }
          }
        }
      }

      if(!var12) {
        var21 = isDefined(var5.bots) && isDefined(var5.bots[self.team]) && var5.bots[self.team] > 0;
        var22 = 0;

        foreach(var19 in var5.nearest_nodes) {
          var22 |= nodesvisible(var7, var19, 1);
        }

        if(var22 || var9 && !var21) {
          var10 = var5;
          break;
        }
      }
    }

    var6 = undefined;
    var8 = undefined;

    if(isDefined(var5)) {
      if(self[[level.bot_funcs["crate_should_claim"]]]()) {
        if(!isDefined(var5.boxtype)) {
          if(!isDefined(var5.bots)) {
            var5.bots = [];
          }

          var5.bots[self.team] = 1;
        }
      }

      var9 = spawnStruct();
      var9.object = var5;
      var9.start_thread = &watch_bot_died_during_crate;
      var9.should_abort = &crate_picked_up;
      var10 = undefined;

      if(isDefined(var5.boxtype)) {
        if(isDefined(var5.boxtouchonly) && var5.boxtouchonly) {
          var9.script_goal_radius = 16;
          var9.action_thread = undefined;
          var10 = var5.origin;
        } else {
          var9.script_goal_radius = 50;
          var9.action_thread = &use_box;
          var11 = crate_get_bot_target_check_distance(var5, < error > );

          if(!isDefined(var11)) {
            continue;
          }

          var11 -= var5.origin;
          var29 = length(var11) * randomfloat(1);
          var10 = var5.origin + vectorNormalize(var11) * var29 + (0, 0, 12);
        }
      } else {
        var9.action_thread = &use_crate;
        var9.end_thread = &stop_using_crate;
        var10 = crate_get_bot_target_check_distance(var5, < error > );

        if(!isDefined(var10)) {
          continue;
        }

        var9.script_goal_radius = < error > -distance(var5.origin, var10 + (0, 0, 40));
        var10 += (0, 0, 24);
      }

      if(isDefined(var9.script_goal_radius)) {}

      var5 notify("path_disconnect");
      wait 0.05;

      if(!isDefined(var5)) {
        continue;
      }

      scripts\mp\bots\bots_strategy::bot_new_tactical_goal("airdrop_crate", var10, 30, var9);
    }
  }
}

function bot_should_use_ballistic_vest_crate(var0) {
  return true;
}

function crate_should_claim() {
  return true;
}

function crate_low_ammo_check() {
  return false;
}

function bot_should_use_ammo_crate(var0) {
  if(createheadicon(self getcurrentweapon()) == level.boxsettings[var0.boxtype].minigunweapon) {
    return false;
  }

  return true;
}

function bot_pre_use_ammo_crate(var0) {
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.secondaryweapon);
  wait 1;
}

function bot_post_use_ammo_crate(var0) {
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(isundefinedweapon());
  self.secondaryweapon = self getcurrentweapon();
}

function bot_should_use_scavenger_bag(var0) {
  if(scripts\mp\bots\bots_util::bot_get_low_on_ammo(0.66)) {
    var1 = self getnearestnode();

    if(isDefined(var0.nearest_nodes) && isDefined(var0.nearest_nodes[0]) && isDefined(var1)) {
      if(nodesvisible(var1, var0.nearest_nodes[0], 1)) {
        if(scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var0.origin, self botgetfovdot())) {
          return true;
        }
      }
    }
  }

  return false;
}

function bot_should_use_grenade_crate(var0) {
  var1 = self getweaponslistoffhands();

  foreach(var3 in var1) {
    if(self getweaponammostock(var3) == 0) {
      return true;
    }
  }

  return false;
}

function bot_should_use_juicebox_crate(var0) {
  return true;
}

function crate_monitor_position() {
  self notify("crate_monitor_position");
  self endon("crate_monitor_position");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    var0 = self.origin;
    wait 0.5;

    if(!isDefined(self)) {
      return;
    }

    if(!scripts\mp\bots\bots_util::bot_vectors_are_equal(self.origin, var0)) {
      self.on_path_grid = undefined;
      self.nearest_nodes = undefined;
      self.nearest_points = undefined;
    }
  }
}

function crate_wait_use() {}

function crate_picked_up(var0) {
  if(!isDefined(var0.object)) {
    return true;
  }

  return false;
}

function use_crate(var0) {
  if(isagent(self)) {
    scripts\common\utility::allow_usability(1);
    var0.object enableplayeruse(self);
    wait 0.05;
  }

  self[[level.bot_funcs["crate_wait_use"]]]();

  if(isDefined(var0.object.owner) && var0.object.owner == self) {
    var1 = level.crateownerusetime / 1000 + 0.5;
  } else {
    var1 = level.cratenonownerusetime / 1000 + 1;
  }

  self botpressbutton("use", var1);

  while(var1 > 0 && isDefined(var1.object)) {
    wait 0.05;
    var1 -= 0.05;
  }

  if(var1 > 0) {
    wait randomfloatrange(0.05, 0.5);
  }

  if(isagent(self)) {
    scripts\common\utility::allow_usability(0);

    if(isDefined(var1.object)) {
      var1.object disableplayeruse(self);
    }
  }

  if(isDefined(var1.object)) {
    if(!isDefined(var1.object.bots_used)) {
      var1.object.bots_used = [];
    }

    var1.object.bots_used[var1.object.bots_used.size] = self;
    return;
  }
}

function use_box(var0) {
  if(isagent(self)) {
    scripts\common\utility::allow_usability(1);
    var0.object enableplayeruse(self);
    wait 0.05;
  }

  if(isDefined(var0.object) && isDefined(var0.object.boxtype)) {
    var1 = var0.object.boxtype;

    if(isDefined(level.bot_pre_use_box_of_type[var1])) {
      self[[level.bot_pre_use_box_of_type[var1]]](var0.object);
    }

    if(isDefined(var0.object)) {
      var2 = level.boxsettings[var0.object.boxtype].usetime / 1000 + 0.5;
      self botpressbutton("use", var2);
      wait var2;

      if(isDefined(level.bot_post_use_box_of_type[var1])) {
        self[[level.bot_post_use_box_of_type[var1]]](var0.object);
      }
    }
  }

  if(isagent(self)) {
    scripts\common\utility::allow_usability(0);

    if(isDefined(var0.object)) {
      var0.object disableplayeruse(self);
      return;
    }

    return;
  }
}

function watch_bot_died_during_crate(var0) {
  thread bot_watch_for_death(var0.object);
}

function stop_using_crate(var0) {
  if(isDefined(var0.object)) {
    var0.object.bots[self.team] = 0;
    return;
  }
}

function bot_watch_for_death(var0) {
  var0 endon("death_or_disconnect");
  var0 endon("revived");
  level endon("game_ended");
  var1 = self.team;
  self waittill("death_or_disconnect");

  if(isDefined(var0)) {
    var0.bots[var1] = 0;
    return;
  }
}

function bot_think_crate_blocking_path() {
  self notify("bot_think_crate_blocking_path");
  self endon("bot_think_crate_blocking_path");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var0 = getdvarfloat("MTOQQKKRPS");

  for(;;) {
    wait 3;

    if(self useButtonPressed()) {
      continue;
    }

    if(scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    var1 = level.carepackages;

    for(var2 = 0; var2 < var1.size; var2++) {
      var3 = var1[var2];

      if(!isDefined(var3)) {
        continue;
      }

      var4 = self getplayeruseentity();

      if(!isDefined(var4) || var4 != var3) {
        continue;
      }

      if(distancesquared(self.origin, var3.origin) < var0 * var0) {
        if(!datakey(var3)) {
          if(isDefined(var3.owner) && var3.owner == self) {
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

function watch_bot_died_during_revive(var0) {
  if(scripts\mp\utility\game::islaststandenabled()) {
    thread bot_watch_for_death(var0.object.owner);
    return;
  }
}

function stop_reviving(var0) {
  if(isDefined(var0.object.owner)) {
    var0.object.owner.bots[self.team] = 0;
    return;
  }
}

function player_revived_or_dead(var0) {
  if(scripts\mp\utility\game::islaststandenabled()) {
    if(!isDefined(var0.object.owner) || var0.object.owner.health <= 0) {
      return true;
    }

    if(!isDefined(var0.object.owner.inlaststand) || !var0.object.owner.inlaststand) {
      return true;
    }
  } else if(!isDefined(var0.object.owner) || var0.object.owner.health > 0) {
    return true;
  }

  return false;
}

function revive_player(var0) {
  if(isDefined(var0.object.owner)) {
    var0.object.owner.bots[self.team] = 1;
  }

  if(scripts\mp\utility\game::islaststandenabled()) {
    var1 = var0.object.owner.origin;
  } else {
    var1 = var1.object.origin;
  }

  if(distancesquared(self.origin, var1) > 4096) {
    self.last_revive_fail_time = gettime();
    return;
  }

  if(isagent(self)) {
    scripts\common\utility::allow_usability(1);
    var1.object enableplayeruse(self);
    wait 0.05;
  }

  var2 = self.team;
  self botpressbutton("use", level.laststandrevivetimer + 0.5);
  wait level.laststandrevivetimer + 1.5;

  if(isDefined(var1.object.owner)) {
    var1.object.owner.bots[var2] = 0;
  }

  if(isagent(self)) {
    scripts\common\utility::allow_usability(0);

    if(isDefined(var1.object)) {
      var1.object disableplayeruse(self);
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
    var0 = self[[level.bot_funcs["tactical_revive_override"]]]();

    if(var0) {
      self.tutorial_lead_collected = 0;
      return true;
    }
  }

  var1 = self botgetscriptgoaltype();

  if(var1 == "none" || var1 == "hunt" || var1 == "guard") {
    return true;
  }

  return false;
}

function revive_watch_for_finished(var0) {
  self endon("death_or_disconnect");
  self endon("bad_path");
  self endon("goal");
  var0 scripts\engine\utility::ref_143a5("death", "revived");
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

  var0 = undefined;
  var1 = undefined;

  for(var2 = 0; var2 < level.players.size; var2++) {
    var3 = level.players[var2];

    if(isDefined(var3) && isDefined(self.team) && isDefined(var3.team) && !istestclient(self, var3)) {
      if(!isDefined(var3.bot_start_known_by_enemy)) {
        var0 = var3;
      }

      if(isai(var3) && !isDefined(var3.bot_start_know_enemy)) {
        var1 = var3;
      }
    }
  }

  if(isDefined(var0)) {
    self.bot_start_know_enemy = 1;
    var0.bot_start_known_by_enemy = 1;
    self getenemyinfo(var0);
  }

  if(isDefined(var1)) {
    var1.bot_start_know_enemy = 1;
    self.bot_start_known_by_enemy = 1;
    var1 getenemyinfo(self);
    return;
  }
}

function bot_think_gametype() {
  self notify("bot_think_gametype");
  self endon("bot_think_gametype");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var0 = 0;

  if(level.gametype == "br") {
    var0 = 1;
  }

  if(!var0) {
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
  self waittill("explode", var0);
  thread init_leave_cave(var0);
}

function init_leave_cave(var0) {
  var1 = spawn("script_model", var0);
  var1 show();
  wait 1;
  var1 clonebrushmodeltoscriptmodel(level.bot_smoke_sight_clip_large);
  var1 setmovertransparentvolume();
  wait 8.75;
  var1 delete();
}

function smoke_grenade_late_death() {
  self endon("explode");
  self waittill("death");
  waittillframeend();
  self notify("late_death");
}

function bot_add_scavenger_bag(var0) {
  var1 = 0;
  var0.boxtype = "scavenger_bag";
  var0.boxtouchonly = 1;

  if(!isDefined(level.bot_scavenger_bags)) {
    level.bot_scavenger_bags = [];
  }

  foreach(var3 in level.bot_scavenger_bags) {
    if(!isDefined(var3)) {
      var1 = 1;
      level.bot_scavenger_bags[var4] = var0;
      break;
    }
  }

  if(!var1) {
    level.bot_scavenger_bags[level.bot_scavenger_bags.size] = var0;
  }

  foreach(var6 in level.participants) {
    if(isai(var6) && var6 scripts\mp\utility\perk::_hasperk("specialty_scavenger")) {
      var6 notify("new_crate_to_take");
    }
  }
}

function bot_triggers() {
  var0 = getEntArray("bot_flag_set", "targetname");

  foreach(var2 in var0) {
    if(!isDefined(var2.script_noteworthy)) {
      continue;
    }

    thread bot_flag_trigger(var2);
  }
}

function bot_flag_trigger(var0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var1);

    if(scripts\mp\utility\entity::isaigameparticipant(var1)) {
      var1 notify("flag_trigger_set_" + var0);
      var1 botsetflag(var0, 1);
      thread bot_flag_trigger_clear(var1);
    }
  }
}

function bot_flag_trigger_clear(var0) {
  self endon("flag_trigger_set_" + var0);
  self endon("death_or_disconnect");
  level endon("game_ended");
  waitframe();
  waittillframeend();
  self botsetflag(var0, 0);
}

function load_gametype_scripts_for_scriptdev() {}