/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots.gsc
***********************************************/

main() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }
  if(getdvarint("r_reflectionprobegenerate")) {
    return;
  }
  if(getdvarint("dvar_742CAA13B3C2E685")) {
    return;
  }
  setup_callbacks();
  scripts\mp\bots\bots_personality::setup_personalities();
  level.badplace_cylinder_func = ::badplace_cylinder;
  level.badplace_delete_func = ::badplace_delete;

  if(isDefined(level.bot_killstreak_setup_func))
    [[level.bot_killstreak_setup_func]]();
  else
    scripts\mp\bots\bots_killstreaks::bot_killstreak_setup();

  level thread init();
  load_gametype_scripts_for_scriptdev();
}

setup_callbacks() {
  level.bot_funcs = [];
  level.bot_funcs["bots_spawn"] = ::spawn_bots;
  level.bot_funcs["bots_add_scavenger_bag"] = ::bot_add_scavenger_bag;
  level.bot_funcs["bots_add_to_level_targets"] = scripts\mp\bots\bots_util::bot_add_to_bot_level_targets;
  level.bot_funcs["bots_remove_from_level_targets"] = scripts\mp\bots\bots_util::bot_remove_from_bot_level_targets;
  level.bot_funcs["think"] = ::bot_think;
  level.bot_funcs["on_killed"] = ::on_bot_killed;
  level.bot_funcs["should_do_killcam"] = ::bot_should_do_killcam;
  level.bot_funcs["get_attacker_ent"] = scripts\mp\bots\bots_util::bot_get_known_attacker;
  level.bot_funcs["should_pickup_weapons"] = ::bot_should_pickup_weapons;
  level.bot_funcs["on_damaged"] = ::bot_damage_callback;
  level.bot_funcs["gametype_think"] = ::default_gametype_think;
  level.bot_funcs["leader_dialog"] = scripts\mp\bots\bots_util::bot_leader_dialog;
  level.bot_funcs["player_spawned"] = ::bot_player_spawned;
  level.bot_funcs["should_start_cautious_approach"] = scripts\mp\bots\bots_strategy::should_start_cautious_approach_default;
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
  level.bot_funcs["bot_set_difficulty"] = scripts\mp\bots\bots_util::bot_set_difficulty;
  level.bot_funcs["bot_set_personality"] = scripts\mp\bots\bots_util::bot_set_personality;
  level.bot_funcs["bot_think_watch_enemy"] = ::bot_think_watch_enemy;
  level.bot_funcs["bot_think_tactical_goals"] = scripts\mp\bots\bots_strategy::bot_think_tactical_goals;
  level.bot_funcs["bot_bots_enabled_or_added"] = scripts\mp\bots\bots_util::bot_bots_enabled_or_added;
  level.bot_funcs["revive_think"] = ::bot_think_revive;
  level.bot_random_path_function = scripts\mp\bots\bots_personality::bot_random_path_default;
  level.bot_find_defend_node_func["capture"] = scripts\mp\bots\bots_strategy::find_defend_node_capture;
  level.bot_find_defend_node_func["capture_zone"] = scripts\mp\bots\bots_strategy::find_defend_node_capture_zone;
  level.bot_find_defend_node_func["protect"] = scripts\mp\bots\bots_strategy::find_defend_node_protect;
  level.bot_find_defend_node_func["protect_zone"] = scripts\mp\bots\bots_strategy::find_defend_node_protect_zone;
  level.bot_find_defend_node_func["bodyguard"] = scripts\mp\bots\bots_strategy::find_defend_node_bodyguard;
  level.bot_find_defend_node_func["patrol"] = scripts\mp\bots\bots_strategy::find_defend_node_patrol;
  _id_0E494DD5DEBDA9C7::setup_callbacks();
}

codecallback_leaderdialog(dialog, location) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["leader_dialog"]))
    self[[level.bot_funcs["leader_dialog"]]](dialog, location);
}

init() {
  if(getdvarint("dvar_ABE45E35EF030A56") == 0)
    thread monitor_smoke_grenades();

  thread bot_triggers();
  initbotlevelvariables();

  if(!shouldspawnbots()) {
    return;
  }
  refresh_existing_bots();
  setmatchdata("hasBots", 1);
  level thread bot_connect_monitor();
}

initbotlevelvariables() {
  if(!isDefined(level.crateownerusetime))
    level.crateownerusetime = 500;

  if(!isDefined(level.cratenonownerusetime))
    level.cratenonownerusetime = 3000;

  level.bot_out_of_combat_time = 3000;
  level.bot_respawn_launcher_name = "iw6_panzerfaust3";
  level.bot_fallback_weapon = "iw9_me_knife";
  level.zonecount = getzonecount();
  level.bot_light_volumes = getEntArray("bot_light_area", "targetname");
  level.bot_dark_volumes = getEntArray("bot_dark_area", "targetname");
  initbotmapextents();
  level.bot_variables_initialized = 1;
}

initbotmapextents() {
  if(isDefined(level.teleportgetactivenodesfunc)) {
    _id_C6736586AE30F7EA = [[level.teleportgetactivenodesfunc]]();
    level.bot_map_min_x = 0;
    level.bot_map_max_x = 0;
    level.bot_map_min_y = 0;
    level.bot_map_max_y = 0;
    level.bot_map_min_z = 0;
    level.bot_map_max_z = 0;

    if(_id_C6736586AE30F7EA.size > 1) {
      level.bot_map_min_x = _id_C6736586AE30F7EA[0].origin[0];
      level.bot_map_max_x = _id_C6736586AE30F7EA[0].origin[0];
      level.bot_map_min_y = _id_C6736586AE30F7EA[0].origin[1];
      level.bot_map_max_y = _id_C6736586AE30F7EA[0].origin[1];
      level.bot_map_min_z = _id_C6736586AE30F7EA[0].origin[2];
      level.bot_map_max_z = _id_C6736586AE30F7EA[0].origin[2];

      for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_C6736586AE30F7EA.size; _id_AC0E594AC96AA3A8++) {
        _id_CA5534A90F13A4D4 = _id_C6736586AE30F7EA[_id_AC0E594AC96AA3A8].origin;

        if(_id_CA5534A90F13A4D4[0] < level.bot_map_min_x)
          level.bot_map_min_x = _id_CA5534A90F13A4D4[0];

        if(_id_CA5534A90F13A4D4[0] > level.bot_map_max_x)
          level.bot_map_max_x = _id_CA5534A90F13A4D4[0];

        if(_id_CA5534A90F13A4D4[1] < level.bot_map_min_y)
          level.bot_map_min_y = _id_CA5534A90F13A4D4[1];

        if(_id_CA5534A90F13A4D4[1] > level.bot_map_max_y)
          level.bot_map_max_y = _id_CA5534A90F13A4D4[1];

        if(_id_CA5534A90F13A4D4[2] < level.bot_map_min_z)
          level.bot_map_min_z = _id_CA5534A90F13A4D4[2];

        if(_id_CA5534A90F13A4D4[2] > level.bot_map_max_z)
          level.bot_map_max_z = _id_CA5534A90F13A4D4[2];
      }
    }

    level.bot_map_center = ((level.bot_map_min_x + level.bot_map_max_x) / 2, (level.bot_map_min_y + level.bot_map_max_y) / 2, (level.bot_map_min_z + level.bot_map_max_z) / 2);
  }
}

bot_post_teleport() {
  level.bot_variables_initialized = undefined;
  level.bot_initialized_remote_vehicles = undefined;
  initbotmapextents();
  level.bot_variables_initialized = 1;
}

shouldspawnbots() {
  return 1;
}

refresh_existing_bots() {
  wait 1;

  foreach(player in level.players) {
    if(isbot(player)) {
      if(isalive(player)) {
        player.equipment_enabled = 1;
        player.bot_team = player.team;
        player.bot_spawned_this_round = 1;
        player thread[[level.bot_funcs["think"]]]();
        continue;
      }
    }
  }
}

bot_player_spawned() {
  if(isDefined(level.bot_funcs["player_spawned_gamemode"]))
    self[[level.bot_funcs["player_spawned_gamemode"]]]();

  bot_set_loadout_class();
}

bot_set_loadout_class() {
  if(!isDefined(self.bot_class)) {
    if(!bot_gametype_chooses_class()) {
      while(!isDefined(level._id_0CEBC8CC0640FE57) || !isDefined(level._id_0CEBC8CC0640FE57.initialized))
        wait 0.05;

      if(isDefined(self.override_class_function))
        self.bot_class = [[self.override_class_function]]();
      else
        self.bot_class = scripts\mp\bots\bots_personality::bot_setup_callback_class();
    } else
      self.bot_class = self.class;
  }

  self.class = self.bot_class;
}

watch_players_connecting() {
  for(;;) {
    level waittill("connected", player);

    if(!isai(player) && level.players.size > 0) {
      level.players_waiting_to_join = scripts\engine\utility::array_add(level.players_waiting_to_join, player);
      childthread bots_notify_on_spawn(player);
      childthread bots_notify_on_disconnect(player);
      childthread bots_remove_from_array_on_notify(player);
    }
  }
}

bots_notify_on_spawn(player) {
  player endon("bots_human_disconnected");

  while(!scripts\engine\utility::array_contains(level.players, player))
    wait 0.05;

  player notify("bots_human_spawned");
}

bots_notify_on_disconnect(player) {
  player endon("bots_human_spawned");
  player waittill("disconnect");
  player notify("bots_human_disconnected");
}

bots_remove_from_array_on_notify(player) {
  player scripts\engine\utility::waittill_any_2("bots_human_spawned", "bots_human_disconnected");
  level.players_waiting_to_join = scripts\engine\utility::array_remove(level.players_waiting_to_join, player);
}

monitor_pause_spawning() {
  level.players_waiting_to_join = [];
  childthread watch_players_connecting();

  for(;;) {
    if(level.players_waiting_to_join.size > 0)
      level.pausing_bot_connect_monitor = 1;
    else
      level.pausing_bot_connect_monitor = 0;

    wait 0.5;
  }
}

bot_can_join_team(team) {
  if(scripts\mp\utility\game::matchmakinggame())
    return 1;

  if(!level.teambased)
    return 1;

  if(scripts\mp\teams::getjointeampermissions(team))
    return 1;

  return 0;
}

bot_allowed_to_switch_teams() {
  if(isDefined(level.bots_disable_team_switching) && level.bots_disable_team_switching)
    return 0;

  if(isDefined(level.matchrules_switchteamdisabled) && level.matchrules_switchteamdisabled)
    return 0;

  return 1;
}

bot_connect_monitor() {
  level endon("game_ended");
  self notify("bot_connect_monitor");
  self endon("bot_connect_monitor");
  level.pausing_bot_connect_monitor = 0;
  childthread monitor_pause_spawning();
  childthread bot_monitor_team_limits();
  _id_41E7DC4FA58EE542 = 1.5;
  _id_29E1CB7568F77E66 = isDefined(level._id_7B37B2193F163B9B);
  _func_9241A75CB048508D();

  for(;;) {
    if(level.pausing_bot_connect_monitor) {
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(_id_41E7DC4FA58EE542);
      continue;
    }

    level.bot_max_players_on_team["allies"] = 0;
    level.bot_max_players_on_team["axis"] = 0;
    _func_824881E424DA15B4();
    _id_4C9BD9A3BF3F8CF7::_id_CDE96C5B28CC69F6();
    _id_1A2D84A633E11E8C = _func_2CE39E65A48D5EC0(_id_29E1CB7568F77E66);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1A2D84A633E11E8C.size; _id_AC0E594AC96AA3A8++) {
      if(_id_1A2D84A633E11E8C[_id_AC0E594AC96AA3A8].team == "free")
        _id_1A2D84A633E11E8C[_id_AC0E594AC96AA3A8].bot.bot_team = "autoassign";
      else
        _id_1A2D84A633E11E8C[_id_AC0E594AC96AA3A8].bot.bot_team = _id_1A2D84A633E11E8C[_id_AC0E594AC96AA3A8].team;

      if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
        _id_5BE31BBF808E8D4C = _id_1A2D84A633E11E8C[_id_AC0E594AC96AA3A8].squad;
        _id_1A2D84A633E11E8C[_id_AC0E594AC96AA3A8].bot._id_B5517A8D74ED63A3 = _id_5BE31BBF808E8D4C;
      }

      if(_id_1A2D84A633E11E8C[_id_AC0E594AC96AA3A8].istestclient) {
        _id_1A2D84A633E11E8C[_id_AC0E594AC96AA3A8].bot scripts\mp\playerlogic::spawnspectator();
        _id_1A2D84A633E11E8C[_id_AC0E594AC96AA3A8].bot.btestclient = 1;
        _id_1A2D84A633E11E8C[_id_AC0E594AC96AA3A8].bot scripts\mp\menus::autoassign();
        class = "class" + randomint(3);
        _id_1A2D84A633E11E8C[_id_AC0E594AC96AA3A8].bot notify("loadout_class_selected", class);
        _id_1A2D84A633E11E8C[_id_AC0E594AC96AA3A8].bot notify("luinotifyserver", "class_select", class);
      } else {
        _id_1A2D84A633E11E8C[_id_AC0E594AC96AA3A8].bot.equipment_enabled = 1;
        _id_1A2D84A633E11E8C[_id_AC0E594AC96AA3A8].bot thread[[level.bot_funcs["think"]]]();
      }

      _id_1A2D84A633E11E8C[_id_AC0E594AC96AA3A8].bot _id_72AF5A878A9D3397::_id_03283FDAC29887DE();
      _id_1A2D84A633E11E8C[_id_AC0E594AC96AA3A8].bot _id_81C6C4218188E7D8();
    }

    if(_id_1A2D84A633E11E8C.size > 0)
      level notify("spawned_bots");

    update_max_players_from_team_agents();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(_id_41E7DC4FA58EE542);
  }
}

_id_81C6C4218188E7D8() {
  if(isDefined(self.xuid) && self.xuid != "") {
    return;
  }
  if(isDefined(self._id_5876CD9FC14AF731) && isDefined(self._id_5876CD9FC14AF731.xuid) && self._id_5876CD9FC14AF731.xuid != "")
    self.xuid = self._id_5876CD9FC14AF731.xuid;
  else
    self.xuid = self _meth_7A32B0201993D7F7();
}

bot_monitor_team_limits() {
  level endon("game_ended");
  self notify("bot_monitor_team_limits");
  self endon("bot_monitor_team_limits");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  _id_41E7DC4FA58EE542 = 1.5;

  for(;;) {
    level.bot_max_players_on_team["allies"] = 0;
    level.bot_max_players_on_team["axis"] = 0;

    foreach(player in level.players) {
      if(isDefined(player.team) && (player.team == "allies" || player.team == "axis"))
        level.bot_max_players_on_team[player.team]++;
    }

    update_max_players_from_team_agents();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(_id_41E7DC4FA58EE542);
  }
}

update_max_players_from_team_agents() {
  if(isDefined(level.agentarray)) {
    foreach(agent in level.agentarray) {
      if(isDefined(agent.isactive) && agent.isactive) {
        if(scripts\mp\utility\entity::isteamparticipant(agent) && isDefined(agent.team) && (agent.team == "allies" || agent.team == "axis"))
          level.bot_max_players_on_team[agent.team]++;
      }
    }
  }
}

bot_get_player_team() {
  if(isDefined(self.team))
    return self.team;

  if(isDefined(self.pers["team"]))
    return self.pers["team"];

  return undefined;
}

bot_get_host_team() {
  foreach(player in level.players) {
    if(!isai(player) && player ishost())
      return player bot_get_player_team();
  }

  return "spectator";
}

bot_get_human_picked_team() {
  _id_E4A4F27E84B49281 = 0;
  _id_3B278E62E61B9EC6 = 0;
  _id_7CD77EEC8870208D = 0;

  foreach(player in level.players) {
    if(!isai(player)) {
      if(player ishost())
        _id_E4A4F27E84B49281 = 1;

      if(player_picked_team(player)) {
        _id_3B278E62E61B9EC6 = 1;

        if(player ishost())
          _id_7CD77EEC8870208D = 1;
      }
    }
  }

  return _id_7CD77EEC8870208D || _id_3B278E62E61B9EC6 && !_id_E4A4F27E84B49281;
}

player_picked_team(player) {
  if(isDefined(player.team) && player.team != "spectator")
    return 1;

  if(isDefined(player.spectating_actively) && player.spectating_actively)
    return 1;

  if(player _meth_8420670EAFC8D391() && isDefined(player.team) && player.team == "spectator")
    return 1;

  return 0;
}

bot_get_human_picked_class() {
  _id_E4A4F27E84B49281 = 0;
  _id_3B278E62E61B9EC6 = 0;
  _id_7CD77EEC8870208D = 0;

  foreach(player in level.players) {
    if(!isai(player)) {
      if(player ishost())
        _id_E4A4F27E84B49281 = 1;

      if(isDefined(player.class)) {
        _id_3B278E62E61B9EC6 = 1;

        if(player ishost())
          _id_7CD77EEC8870208D = 1;
      }
    }
  }

  return _id_7CD77EEC8870208D || _id_3B278E62E61B9EC6 && !_id_E4A4F27E84B49281;
}

bot_client_counts() {
  _id_490F043A11393F46 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];

    if(isDefined(player) && isDefined(player.team)) {
      _id_490F043A11393F46 = cat_array_add(_id_490F043A11393F46, "all");
      _id_490F043A11393F46 = cat_array_add(_id_490F043A11393F46, player.team);

      if(isbot(player)) {
        _id_490F043A11393F46 = cat_array_add(_id_490F043A11393F46, "bots");
        _id_490F043A11393F46 = cat_array_add(_id_490F043A11393F46, "bots_" + player.team);
        continue;
      }

      _id_490F043A11393F46 = cat_array_add(_id_490F043A11393F46, "humans");
      _id_490F043A11393F46 = cat_array_add(_id_490F043A11393F46, "humans_" + player.team);
    }
  }

  return _id_490F043A11393F46;
}

cat_array_add(_id_A743A347C001CA06, category) {
  if(!isDefined(_id_A743A347C001CA06))
    _id_A743A347C001CA06 = [];

  if(!isDefined(_id_A743A347C001CA06[category]))
    _id_A743A347C001CA06[category] = 0;

  _id_A743A347C001CA06[category] = _id_A743A347C001CA06[category] + 1;
  return _id_A743A347C001CA06;
}

cat_array_get(_id_A743A347C001CA06, category) {
  if(!isDefined(_id_A743A347C001CA06))
    return 0;

  if(!isDefined(_id_A743A347C001CA06[category]))
    return 0;

  return _id_A743A347C001CA06[category];
}

move_bots_from_team_to_team(count, _id_5A1EF08A70766E60, _id_0616570B6419A659, difficulty) {
  foreach(player in level.players) {
    if(!isDefined(player.team)) {
      continue;
    }
    if(isDefined(player.connected) && player.connected && isbot(player) && player.team == _id_5A1EF08A70766E60) {
      player.bot_team = _id_0616570B6419A659;

      if(isDefined(difficulty))
        player scripts\mp\bots\bots_util::bot_set_difficulty(difficulty);

      player notify("luinotifyserver", "team_select", bot_lui_convert_team_to_int(_id_0616570B6419A659));
      wait 0.05;
      player notify("loadout_class_selected", player.bot_class);
      count--;

      if(count <= 0) {
        break;
      } else
        wait 0.1;
    }
  }
}

bots_update_difficulty(team, difficulty) {
  foreach(player in level.players) {
    if(!isDefined(player.team)) {
      continue;
    }
    if(isDefined(player.connected) && player.connected && isbot(player) && player.team == team) {
      if(difficulty != player botgetdifficulty())
        player scripts\mp\bots\bots_util::bot_set_difficulty(difficulty);
    }
  }
}

bot_drop() {
  kick(self.entity_number, "EXE/PLAYERKICKED_BOT_BALANCE");
  wait 0.1;
}

drop_bots(count, team) {
  bots = [];

  foreach(player in level.players) {
    if(isDefined(player.connected) && player.connected && isbot(player) && (!isDefined(team) || isDefined(player.team) && player.team == team))
      bots[bots.size] = player;
  }

  for(_id_AC0E594AC96AA3A8 = bots.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    if(count <= 0) {
      break;
    }

    if(!bots[_id_AC0E594AC96AA3A8] scripts\cp_mp\utility\player_utility::_isalive()) {
      bots[_id_AC0E594AC96AA3A8] bot_drop();
      bots = scripts\engine\utility::array_remove(bots, bots[_id_AC0E594AC96AA3A8]);
      count--;
    }
  }

  for(_id_AC0E594AC96AA3A8 = bots.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    if(count <= 0) {
      break;
    }

    bots[_id_AC0E594AC96AA3A8] bot_drop();
    count--;
  }
}

bot_lui_convert_team_to_int(_id_A3BF560B25C4A33E) {
  if(_id_A3BF560B25C4A33E == "axis")
    return 0;
  else if(_id_A3BF560B25C4A33E == "allies")
    return 1;
  else if(_id_A3BF560B25C4A33E == "autoassign" || _id_A3BF560B25C4A33E == "random")
    return 2;
  else
    return 3;
}

spawn_bot_latent(team, _id_46C357E31A65AF85, _id_F4842A7333F0853B) {
  _id_F1B03FFE289C1025 = gettime() + 60000;

  while(!self canspawnbotortestclient()) {
    if(gettime() >= _id_F1B03FFE289C1025) {
      kick(self.entity_number, "EXE/PLAYERKICKED_BOT_BALANCE");
      _id_F4842A7333F0853B.abort = 1;
      return;
    }

    wait 0.05;

    if(!isDefined(self)) {
      _id_F4842A7333F0853B.abort = 1;
      return;
    }
  }

  if(!scripts\mp\bots\bots_util::dev_spawning_bots()) {
    time = randomfloatrange(0.25, 2.0);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(time);
  }

  if(!isDefined(self)) {
    _id_F4842A7333F0853B.abort = 1;
    return;
  }

  self spawnbotortestclient();
  self.equipment_enabled = 1;
  self.bot_team = team;
  self._id_B5517A8D74ED63A3 = _id_F4842A7333F0853B._id_B5517A8D74ED63A3;

  if(isDefined(_id_F4842A7333F0853B.difficulty))
    scripts\mp\bots\bots_util::bot_set_difficulty(_id_F4842A7333F0853B.difficulty);

  if(isDefined(_id_F4842A7333F0853B._id_E2055BF088954E86))
    self._id_E2055BF088954E86 = _id_F4842A7333F0853B._id_E2055BF088954E86;

  if(isDefined(_id_46C357E31A65AF85))
    self[[_id_46C357E31A65AF85]]();

  self thread[[level.bot_funcs["think"]]]();
  _id_F4842A7333F0853B.ready = 1;
}

spawn_bots(_id_0103A2009F383A1A, team, _id_46C357E31A65AF85, _id_A018DF45312BA50F, _id_00DFC67EAAF62BC0, difficulty, _id_4F9EFD61ABF87FB0) {
  _id_F1B03FFE289C1025 = gettime() + 15000;
  _id_821516DC10EC00F0 = [];
  _id_A29729DA6B538C22 = _id_821516DC10EC00F0.size;

  while(level.players.size < scripts\mp\bots\bots_util::bot_get_client_limit() && _id_821516DC10EC00F0.size < _id_0103A2009F383A1A && gettime() < _id_F1B03FFE289C1025) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.05);
    bot = undefined;

    if(isbotmatchmakingenabled()) {
      if(level.teambased)
        bot = addmpbottoteam(team);
      else
        bot = addmpbottoteam("none");
    } else
      bot = addbot("");

    if(!isDefined(bot)) {
      if(isDefined(_id_A018DF45312BA50F) && _id_A018DF45312BA50F) {
        if(isDefined(_id_00DFC67EAAF62BC0))
          self notify(_id_00DFC67EAAF62BC0);

        return;
      }

      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
      continue;
    } else {
      _id_F4842A7333F0853B = spawnStruct();
      _id_F4842A7333F0853B.bot = bot;
      _id_F4842A7333F0853B.ready = 0;
      _id_F4842A7333F0853B.abort = 0;
      _id_F4842A7333F0853B.index = _id_A29729DA6B538C22;
      _id_F4842A7333F0853B.difficulty = difficulty;
      _id_821516DC10EC00F0[_id_821516DC10EC00F0.size] = _id_F4842A7333F0853B;

      if(isDefined(_id_4F9EFD61ABF87FB0)) {
        bot.pers["stat_B4E62D7CAAFAD3BE"] = _id_4F9EFD61ABF87FB0.origin;
        bot.pers["stat_36E3A9FA37A8B454"] = _id_4F9EFD61ABF87FB0.angles;
      }

      _id_F4842A7333F0853B.bot thread spawn_bot_latent(team, _id_46C357E31A65AF85, _id_F4842A7333F0853B);
      _id_A29729DA6B538C22++;
    }
  }

  _id_65C7BCBB8685EFC3 = 0;
  _id_F1B03FFE289C1025 = gettime() + 60000;

  while(_id_65C7BCBB8685EFC3 < _id_821516DC10EC00F0.size && gettime() < _id_F1B03FFE289C1025) {
    _id_65C7BCBB8685EFC3 = 0;

    foreach(_id_F4842A7333F0853B in _id_821516DC10EC00F0) {
      if(_id_F4842A7333F0853B.ready || _id_F4842A7333F0853B.abort)
        _id_65C7BCBB8685EFC3++;
    }

    wait 0.05;
  }

  if(isDefined(_id_00DFC67EAAF62BC0))
    self notify(_id_00DFC67EAAF62BC0);
}

bot_gametype_chooses_team() {
  if(scripts\mp\utility\game::matchmakinggame() && self.sessionteam != "none")
    _id_74703AA01E7C9B48 = 0;
  else if(!scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::denysystemicteamchoice() && scripts\mp\utility\game::doesmodesupportplayerteamchoice())
    _id_74703AA01E7C9B48 = 1;
  else
    _id_74703AA01E7C9B48 = 0;

  return !_id_74703AA01E7C9B48;
}

bot_gametype_chooses_class() {
  return istrue(level.bots_gametype_handles_class_choice);
}

bot_is_ready_to_spawn() {
  if(!isDefined(self.classcallback)) {
    if(!bot_gametype_chooses_class())
      return 0;
  }

  return 1;
}

bot_think() {
  self notify("bot_think");
  self endon("bot_think");
  self endon("disconnect");

  while(!isDefined(self.pers["team"]))
    wait 0.05;

  level.hasbots = 1;

  if(bot_gametype_chooses_team())
    self.bot_team = self.pers["team"];

  team = self.bot_team;

  if(!isDefined(team))
    team = self.pers["team"];

  self.entity_number = self getentitynumber();
  _id_63366D9D88CE51F8 = 0;

  if(!isDefined(self.bot_spawned_this_round)) {
    _id_63366D9D88CE51F8 = 1;
    self.bot_spawned_this_round = 1;

    if(!bot_gametype_chooses_team()) {
      _id_4EC7F123B211E7BE = self.pers["team"] != "spectator" && !isDefined(self.bot_team);

      if(!_id_4EC7F123B211E7BE) {
        _id_E7FE0E101285E7E2 = isDefined(self.bot_team) && self.bot_team != self.pers["team"];

        if(_id_E7FE0E101285E7E2)
          self notify("luinotifyserver", "team_select", bot_lui_convert_team_to_int(team));

        wait 0.5;

        if(self.pers["team"] == "spectator") {
          bot_drop();
          return;
        }
      }
    }
  }

  for(;;) {
    scripts\mp\bots\bots_util::bot_set_difficulty(self botgetdifficulty());
    self.difficulty = self botgetdifficulty();
    _id_631A8DEAB6AB2901 = self botgetdifficultysetting("advancedPersonality");

    if(_id_63366D9D88CE51F8 && isDefined(_id_631A8DEAB6AB2901) && _id_631A8DEAB6AB2901 != 0)
      scripts\mp\bots\bots_personality::bot_balance_personality();

    scripts\mp\bots\bots_personality::bot_assign_personality_functions();
    self.enemyselector = "enemyselector_bot";

    if(_id_63366D9D88CE51F8) {
      if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["class_select_override"]))
        self[[level.bot_funcs["class_select_override"]]]();
      else {
        bot_set_loadout_class();

        if(!bot_gametype_chooses_class()) {
          if(isDefined(self.connecttime) && self.connecttime == gettime()) {
            waittillframeend;
            waittillframeend;
          }

          self notify("loadout_class_selected", self.bot_class);
        }
      }

      if(self.health == 0) {
        self.bwaitingforteamselect = 1;
        self notify("bot_ready_to_spawn");
        self waittill("spawned_player");
        self.bwaitingforteamselect = undefined;
        self.bot_team = team;
      }

      if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
        _id_27EB9F95564A944D = "botsight_mgl_br";
      else
        _id_27EB9F95564A944D = "botsight";

      self _meth_95D5375059C2A022(_id_27EB9F95564A944D, 1);

      if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["know_enemies_on_start"]))
        self thread[[level.bot_funcs["know_enemies_on_start"]]]();

      _id_63366D9D88CE51F8 = 0;
    }

    bot_modify_behavior_from_tweakables();
    bot_restart_think_threads();
    wait 0.1;

    if(isalive(self))
      self waittill("death");

    if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["post_death_func"]))
      self[[level.bot_funcs["post_death_func"]]]();

    respawn_watcher();
    self waittill("spawned_player");
  }
}

bot_modify_behavior_from_tweakables() {
  if(scripts\mp\tweakables::gettweakablevalue("game", "onlyheadshots"))
    self botsetflag("only_headshots", 1);
}

respawn_watcher() {
  self endon("started_spawnPlayer");

  while(!self.waitingtospawn)
    wait 0.05;

  if(scripts\mp\playerlogic::needsbuttontorespawn()) {
    while(self.waitingtospawn) {
      if(self.sessionstate == "spectator") {
        if(getdvarint("numlives") == 0 || self.pers["lives"] > 0)
          self botpressbutton("use", 0.5);
      }

      wait 1.0;
    }
  }
}

bot_get_rank_xp() {
  if(scripts\mp\bots\bots_util::bot_israndom() == 0) {
    if(!isDefined(self.pers["rankxp"]))
      self.pers["rankxp"] = 0;

    return self.pers["rankxp"];
  }

  difficulty = self botgetdifficulty();
  _id_D37B56802AC19D52 = "bot_rank_" + difficulty;

  if(isDefined(self.pers[_id_D37B56802AC19D52]) && self.pers[_id_D37B56802AC19D52] > 0)
    return self.pers[_id_D37B56802AC19D52];

  _id_D65CCFCB7C5CA290 = bot_random_ranks_for_difficulty(difficulty);
  _id_00AE17C5A8B1BC1B = _id_D65CCFCB7C5CA290["rank"];
  _id_C52868E86C820DE4 = _id_D65CCFCB7C5CA290["prestige"];
  minxp = scripts\mp\rank::getrankinfominxp(_id_00AE17C5A8B1BC1B);
  maxxp = minxp + scripts\mp\rank::getrankinfoxpamt(_id_00AE17C5A8B1BC1B);
  _id_C5732E73897E110B = randomintrange(minxp, maxxp + 1);
  self.pers[_id_D37B56802AC19D52] = _id_C5732E73897E110B;
  return _id_C5732E73897E110B;
}

bot_3d_sighting_model(_id_F297583B09B3D29C) {
  thread bot_3d_sighting_model_thread(_id_F297583B09B3D29C);
}

bot_3d_sighting_model_thread(_id_F297583B09B3D29C) {
  _id_F297583B09B3D29C endon("disconnect");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(isalive(self) && !self botcanseeentity(_id_F297583B09B3D29C) && scripts\engine\utility::within_fov(self.origin, self getplayerangles(), _id_F297583B09B3D29C.origin, self botgetfovdot()))
      self botgetimperfectenemyinfo(_id_F297583B09B3D29C, _id_F297583B09B3D29C.origin);

    wait 0.1;
  }
}

bot_random_ranks_for_difficulty(difficulty) {
  result = [];
  result["rank"] = 0;
  result["prestige"] = 0;

  if(difficulty == "default")
    return result;

  if(!isDefined(level.bot_rnd_rank)) {
    level.bot_rnd_rank = [];
    level.bot_rnd_rank["recruit"][0] = 0;
    level.bot_rnd_rank["recruit"][1] = 1;
    level.bot_rnd_rank["regular"][0] = 3;
    level.bot_rnd_rank["regular"][1] = 18;
    level.bot_rnd_rank["hardened"][0] = 22;
    level.bot_rnd_rank["hardened"][1] = 38;
    level.bot_rnd_rank["veteran"][0] = 40;
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

  result["rank"] = randomintrange(level.bot_rnd_rank[difficulty][0], level.bot_rnd_rank[difficulty][1] + 1);
  result["prestige"] = randomintrange(level.bot_rnd_prestige[difficulty][0], level.bot_rnd_prestige[difficulty][1] + 1);
  return result;
}

_id_9BD84CEDE4FE8F24(crate) {
  return 1;
}

crate_can_use_always(crate) {
  if(isagent(self) && !isDefined(crate.boxtype))
    return 0;

  if(!_id_9BD84CEDE4FE8F24(crate))
    return 0;

  return 1;
}

get_human_player() {
  result = undefined;
  players = getEntArray("player", "classname");

  if(isDefined(players)) {
    for(index = 0; index < players.size; index++) {
      if(isDefined(players[index]) && isDefined(players[index].connected) && players[index].connected && !isai(players[index]) && (!isDefined(result) || result.team == "spectator"))
        result = players[index];
    }
  }

  return result;
}

bot_damage_callback(eattacker, idamage, smeansofdeath, sweapon, einflictor, shitloc, vpoint) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_SUICIDE") {
    return;
  }
  if(idamage <= 0) {
    return;
  }
  if(!isDefined(einflictor)) {
    if(!isDefined(eattacker)) {
      return;
    }
    einflictor = eattacker;
  }

  if(isDefined(einflictor)) {
    if(isDefined(self.fnbotdamagecallback))
      self[[self.fnbotdamagecallback]](eattacker, idamage, smeansofdeath, sweapon, einflictor, shitloc, vpoint);

    if(level.teambased) {
      if(isDefined(einflictor.team) && einflictor.team == self.team)
        return;
      else if(isDefined(eattacker) && isDefined(eattacker.team) && eattacker.team == self.team)
        return;
    }

    _id_E57F2AA2D1C68284 = scripts\mp\bots\bots_util::bot_get_known_attacker(eattacker, einflictor);

    if(isDefined(_id_E57F2AA2D1C68284))
      self botsetattacker(_id_E57F2AA2D1C68284);
  }

  if(isagent(self))
    self notify("agentDamage");
}

on_bot_killed(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  self botclearscriptenemy();
  self botclearscriptgoal();
  _id_E57F2AA2D1C68284 = scripts\mp\bots\bots_util::bot_get_known_attacker(attacker, einflictor);

  if(isDefined(_id_E57F2AA2D1C68284) && (_id_E57F2AA2D1C68284.classname == "script_vehicle" || _id_E57F2AA2D1C68284.classname == "script_model") && isDefined(_id_E57F2AA2D1C68284.helitype)) {
    _id_848EB2BAF17F6E78 = self botgetdifficultysetting("launcherRespawnChance");

    if(randomfloat(1.0) < _id_848EB2BAF17F6E78)
      self.respawn_with_launcher = 1;
  }
}

bot_should_do_killcam() {
  if(istrue(game["isLaunchChunk"]))
    return 1;

  _id_6E08093B6FFE655F = 0.0;
  _id_501F7F9E330F28B6 = self botgetdifficulty();

  if(_id_501F7F9E330F28B6 == "recruit")
    _id_6E08093B6FFE655F = 0.1;
  else if(_id_501F7F9E330F28B6 == "regular")
    _id_6E08093B6FFE655F = 0.4;
  else if(_id_501F7F9E330F28B6 == "hardened")
    _id_6E08093B6FFE655F = 0.7;
  else if(_id_501F7F9E330F28B6 == "veteran")
    _id_6E08093B6FFE655F = 1.0;

  return randomfloat(1.0) < 1.0 - _id_6E08093B6FFE655F;
}

bot_should_pickup_weapons() {
  return 1;
}

bot_restart_think_threads() {
  self thread[[level.bot_funcs["bot_think_watch_enemy"]]]();
  self thread[[level.bot_funcs["bot_think_tactical_goals"]]]();
  self thread[[level.bot_funcs["dropped_weapon_think"]]]();
  self thread[[level.bot_funcs["revive_think"]]]();
  thread bot_think_crate();
  thread bot_think_crate_blocking_path();
  thread _id_7604844B6A583A71();
  thread scripts\mp\bots\bots_killstreaks::bot_think_killstreak();
  thread scripts\mp\bots\bots_killstreaks::bot_think_watch_aerial_killstreak();
  thread bot_think_gametype();
  thread bot_think_dynamic_doors();
  thread bot_think_nvg();
}

sortdoorsbydistance(_id_A74F7EFB3166D264, door2) {
  return distancesquared(_id_A74F7EFB3166D264.origin, self.closestdoorpos) < distancesquared(door2.origin, self.closestdoorpos);
}

bot_think_dynamic_doors() {
  self notify("bot_think_dynamic_doors");
  self endon("bot_think_dynamic_doors");
  self endon("bot_suspended");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    doorpos = self getmodifierlocationonpath("door", 64);

    if(isDefined(doorpos)) {
      self.closestdoorpos = doorpos;
      _id_2A1BD16B401BCC79 = getentarrayinradius("dynamic_door", "targetname", doorpos, 64);

      if(_id_2A1BD16B401BCC79.size > 0) {
        _id_2A1BD16B401BCC79 = scripts\engine\utility::array_sort_with_func(_id_2A1BD16B401BCC79, ::sortdoorsbydistance);
        door = _id_2A1BD16B401BCC79[0];

        if(isDefined(door.state) && door scripts\mp\door::door_can_open_check())
          door thread scripts\mp\door::cheapopen(self);
      }

      self.closestdoorpos = undefined;
    }

    wait 0.05;
  }
}

bot_think_nvg() {
  self notify("bot_think_nvg");
  self endon("bot_think_nvg");
  self endon("bot_suspended");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  isnightmap = scripts\cp_mp\utility\game_utility::isnightmap();

  for(;;) {
    indarkvolume = 0;
    _id_9D8167BEDFF899C8 = 0;

    if(isDefined(level.bot_light_volumes)) {
      foreach(vol in level.bot_light_volumes) {
        if(self istouching(vol)) {
          _id_9D8167BEDFF899C8 = 1;
          break;
        }
      }
    }

    if(isDefined(level.bot_dark_volumes)) {
      foreach(vol in level.bot_dark_volumes) {
        if(self istouching(vol)) {
          indarkvolume = 1;
          break;
        }
      }
    }

    if(istrue(self.inmotionlight))
      _id_9D8167BEDFF899C8 = 1;

    if(indarkvolume || isnightmap && !_id_9D8167BEDFF899C8) {
      self botsetflag("dark_area", 1);
      self.indarkarea = 1;
    } else if(!indarkvolume && istrue(self.indarkarea)) {
      self botsetflag("dark_area", 0);
      self.indarkarea = 0;
    }

    wait 0.25;
  }
}

bot_think_watch_enemy(_id_AC75E1599D0C626B) {
  _id_33942F6950BF3F15 = "spawned_player";

  if(isDefined(_id_AC75E1599D0C626B) && _id_AC75E1599D0C626B)
    _id_33942F6950BF3F15 = "death";

  self notify("bot_think_watch_enemy");
  self endon("bot_think_watch_enemy");
  self endon("bot_suspended");
  self endon(_id_33942F6950BF3F15);
  self endon("disconnect");
  level endon("game_ended");
  self.last_enemy_sight_time = 0;

  for(;;) {
    if(isDefined(self.enemy)) {
      if(self botcanseeentity(self.enemy))
        self.last_enemy_sight_time = gettime();
    }

    wait 0.05;
  }
}

bot_think_seek_dropped_weapons() {
  self notify("bot_think_seek_dropped_weapons");
  self endon("bot_think_seek_dropped_weapons");
  self endon("bot_suspended");
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_7BA262CC7AB5E283 = "throwingknife_mp";

  for(;;) {
    _id_6FE7E4707CD33327 = 0;

    if(scripts\mp\bots\bots_util::bot_out_of_ammo()) {
      if(self[[level.bot_funcs["should_pickup_weapons"]]]() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
        dropped_weapons = getEntArray("dropped_weapon", "targetname");
        _id_6AC6EE221E4D7361 = scripts\engine\utility::get_array_of_closest(self.origin, dropped_weapons);

        if(_id_6AC6EE221E4D7361.size > 0) {
          dropped_weapon = _id_6AC6EE221E4D7361[0];
          bot_seek_dropped_weapon(dropped_weapon);
        }
      }
    }

    if(!scripts\mp\bots\bots_util::bot_in_combat() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked() && self botgetdifficultysetting("strategyLevel") > 0) {
      _id_4B40839AD49E4F31 = self hasweapon(_id_7BA262CC7AB5E283);
      _id_82086A598C0CE6F9 = _id_4B40839AD49E4F31 && self getammocount(_id_7BA262CC7AB5E283) == 0;

      if(_id_82086A598C0CE6F9) {
        if(isDefined(self.going_for_knife)) {
          wait 5.0;
          continue;
        }

        _id_908F2E093410EE48 = getEntArray("dropped_knife", "targetname");
        _id_D22A29017F63AE78 = scripts\engine\utility::get_array_of_closest(self.origin, _id_908F2E093410EE48);

        foreach(knife in _id_D22A29017F63AE78) {
          if(!isDefined(knife)) {
            continue;
          }
          if(!isDefined(knife.calculated_closest_point)) {
            result = scripts\mp\bots\bots_util::bot_queued_process("BotGetClosestNavigablePoint", scripts\mp\bots\bots_util::func_bot_get_closest_navigable_point, knife.origin, 32, self);

            if(isDefined(knife)) {
              knife.closest_point_on_grid = result;
              knife.calculated_closest_point = 1;
            } else
              continue;
          }

          if(isDefined(knife.closest_point_on_grid)) {
            self.going_for_knife = 1;
            bot_seek_dropped_weapon(knife);
          }
        }
      } else if(_id_4B40839AD49E4F31)
        self.going_for_knife = undefined;
    }

    wait(randomfloatrange(0.25, 0.75));
  }
}

bot_seek_dropped_weapon(dropped_weapon) {
  if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("seek_dropped_weapon", dropped_weapon) == 0) {
    action_thread = undefined;

    if(dropped_weapon.targetname == "dropped_weapon") {
      _id_00661C34EC270A10 = 1;
      _id_BCA88BEB35879353 = self getweaponslistprimaries();

      foreach(_id_CE408E508DCC5197 in _id_BCA88BEB35879353) {
        if(dropped_weapon.model == getweaponmodel(_id_CE408E508DCC5197))
          _id_00661C34EC270A10 = 0;
      }

      if(_id_00661C34EC270A10)
        action_thread = ::bot_pickup_weapon;
    }

    _id_4F3B05E382BB8C7C = spawnStruct();
    _id_4F3B05E382BB8C7C.object = dropped_weapon;
    _id_4F3B05E382BB8C7C.script_goal_radius = 12;
    _id_4F3B05E382BB8C7C.should_abort = level.bot_funcs["dropped_weapon_cancel"];
    _id_4F3B05E382BB8C7C.action_thread = action_thread;
    scripts\mp\bots\bots_strategy::bot_new_tactical_goal("seek_dropped_weapon", dropped_weapon.origin, 100, _id_4F3B05E382BB8C7C);
  }
}

bot_pickup_weapon(goal) {
  self botpressbutton("use", 2);
  wait 2;
}

should_stop_seeking_weapon(goal) {
  if(!isDefined(goal.object))
    return 1;

  if(goal.object.targetname == "dropped_weapon") {
    if(!scripts\mp\bots\bots_util::bot_out_of_ammo())
      return 1;
  } else if(goal.object.targetname == "dropped_knife") {
    if(scripts\mp\bots\bots_util::bot_in_combat()) {
      self.going_for_knife = undefined;
      return 1;
    }
  }

  return 0;
}

crate_in_range(crate) {
  if(!isDefined(crate.owner) || crate.owner != self) {
    if(distancesquared(self.origin, crate.origin) > 4194304)
      return 0;
  }

  return 1;
}

bot_crate_valid(crate) {
  if(!isDefined(crate))
    return 0;

  _id_16D0E355715FAD81 = self[[level.bot_funcs["crate_can_use"]]](crate);

  if(!_id_16D0E355715FAD81) {
    if(scripts\mp\utility\game::getgametype() == "grnd")
      _id_16D0E355715FAD81 = 1;
  }

  if(!_id_16D0E355715FAD81)
    return 0;

  if(!crate_landed_and_on_path_grid(crate))
    return 0;

  if(level.teambased && isDefined(crate.bomb) && isDefined(crate.team) && crate.team == self.team)
    return 0;

  if(!self[[level.bot_funcs["crate_in_range"]]](crate))
    return 0;

  if(isDefined(crate.boxtype)) {
    if(isDefined(level.boxsettings) && isDefined(level.boxsettings[crate.boxtype]) && ![[level.boxsettings[crate.boxtype].canusecallback]]())
      return 0;

    if(isDefined(crate.disabled_use_for) && isDefined(crate.disabled_use_for[self getentitynumber()]) && crate.disabled_use_for[self getentitynumber()])
      return 0;

    if(!isDefined(level.bot_can_use_box_by_type) || !self[[level.bot_can_use_box_by_type[crate.boxtype]]](crate))
      return 0;
  } else if(bot_has_streak_in_crate(crate))
    return 0;

  return isDefined(crate);
}

bot_has_streak_in_crate(crate) {
  return 0;
}

crate_landed_and_on_path_grid(crate) {
  if(!crate_has_landed(crate))
    return 0;

  if(!crate_is_on_path_grid(crate))
    return 0;

  return isDefined(crate);
}

crate_has_landed(crate) {
  if(isDefined(crate.boxtype))
    return gettime() > crate.birthtime + 1000;
  else {
    if(isDefined(crate.droppingtoground))
      return !crate.droppingtoground;

    if(isDefined(crate.animname))
      return 0;

    if(isDefined(crate.avlinvel))
      return crate.avlinvel < 0.001;
  }

  return 0;
}

crate_is_on_path_grid(crate) {
  if(!isDefined(crate.on_path_grid))
    crate_calculate_on_path_grid(crate);

  return isDefined(crate) && crate.on_path_grid;
}

node_within_use_radius_of_crate(node, crate) {
  if(isDefined(crate.boxtype) && crate.boxtype == "scavenger_bag")
    return abs(node.origin[0] - crate.origin[0]) < 36 && abs(node.origin[0] - crate.origin[0]) < 36 && abs(node.origin[0] - crate.origin[0]) < 18;
  else {
    _id_EBD58F81541D9EFB = getdvarfloat("dvar_A62BADF83A03D925");
    _id_E9B1F8E9E674C72C = distancesquared(crate.origin, node.origin + (0, 0, 40));
    return _id_E9B1F8E9E674C72C <= _id_EBD58F81541D9EFB * _id_EBD58F81541D9EFB;
  }
}

crate_calculate_on_path_grid(crate) {
  crate thread crate_monitor_position();
  crate.on_path_grid = 0;
  _id_BC2FB8699D6785AA = undefined;
  _id_C6100808B5487220 = undefined;

  if(isDefined(crate.forcedisconnectuntil)) {
    _id_BC2FB8699D6785AA = crate.forcedisconnectuntil;
    _id_C6100808B5487220 = gettime() + 30000;
    crate.forcedisconnectuntil = _id_C6100808B5487220;
    crate notify("path_disconnect");
  }

  wait 0.05;

  if(!isDefined(crate)) {
    return;
  }
  nearest_nodes = crate_get_nearest_valid_nodes(crate);

  if(!isDefined(crate)) {
    return;
  }
  if(isDefined(nearest_nodes) && nearest_nodes.size > 0) {
    crate.nearest_nodes = nearest_nodes;
    crate.on_path_grid = 1;
  } else {
    _id_EBD58F81541D9EFB = getdvarfloat("dvar_A62BADF83A03D925");
    _id_9BDE6CEB27BC4985 = getnodesinradiussorted(crate.origin, _id_EBD58F81541D9EFB * 2, 0)[0];
    _id_46DE623FB65654B7 = crate getpointinbounds(0, 0, -1);
    _id_D00B3F12E88AEE18 = undefined;

    if(isDefined(crate.boxtype) && crate.boxtype == "scavenger_bag") {
      if(scripts\mp\bots\bots_util::bot_point_is_on_pathgrid(crate.origin, _id_EBD58F81541D9EFB))
        _id_D00B3F12E88AEE18 = crate.origin;
    } else
      _id_D00B3F12E88AEE18 = botgetclosestnavigablepoint(crate.origin, _id_EBD58F81541D9EFB);

    if(isDefined(_id_9BDE6CEB27BC4985) && !_id_9BDE6CEB27BC4985 nodeisdisconnected() && isDefined(_id_D00B3F12E88AEE18) && abs(_id_9BDE6CEB27BC4985.origin[2] - _id_46DE623FB65654B7[2]) < 30) {
      crate.nearest_points = [_id_D00B3F12E88AEE18];
      crate.nearest_nodes = [_id_9BDE6CEB27BC4985];
      crate.on_path_grid = 1;
    }
  }

  if(isDefined(crate.forcedisconnectuntil)) {
    if(crate.forcedisconnectuntil == _id_C6100808B5487220)
      crate.forcedisconnectuntil = _id_BC2FB8699D6785AA;
  }
}

crate_get_nearest_valid_nodes(crate) {
  nodes = getnodesinradiussorted(crate.origin, 256, 0);

  for(_id_AC0E594AC96AA3A8 = nodes.size; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--)
    nodes[_id_AC0E594AC96AA3A8] = nodes[_id_AC0E594AC96AA3A8 - 1];

  nodes[0] = getclosestnodeinsight(crate.origin);
  _id_F0C46916118D97CD = undefined;

  if(isDefined(crate.forcedisconnectuntil))
    _id_F0C46916118D97CD = getnodecount();

  _id_A4A22899C4C3C751 = [];
  _id_6AE00CCCC4C48924 = 1;

  if(!isDefined(crate.boxtype))
    _id_6AE00CCCC4C48924 = 2;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < nodes.size; _id_AC0E594AC96AA3A8++) {
    node = nodes[_id_AC0E594AC96AA3A8];

    if(!isDefined(node) || !isDefined(crate)) {
      continue;
    }
    if(node nodeisdisconnected()) {
      continue;
    }
    if(!node_within_use_radius_of_crate(node, crate)) {
      if(_id_AC0E594AC96AA3A8 == 0)
        continue;
      else
        break;
    }

    wait 0.05;

    if(!isDefined(crate)) {
      break;
    }

    if(sighttracepassed(crate.origin, node.origin + (0, 0, 55), 0, crate)) {
      wait 0.05;

      if(!isDefined(crate)) {
        break;
      }

      if(!isDefined(crate.forcedisconnectuntil)) {
        _id_A4A22899C4C3C751[_id_A4A22899C4C3C751.size] = node;

        if(_id_A4A22899C4C3C751.size == _id_6AE00CCCC4C48924)
          return _id_A4A22899C4C3C751;
        else
          continue;
      }

      _id_B4A4E2C4F49B95DF = undefined;
      _id_AC2425641A3964F5 = 0;

      while(!isDefined(_id_B4A4E2C4F49B95DF) && _id_AC2425641A3964F5 < 100) {
        _id_AC2425641A3964F5++;
        _id_498ACC2540D38C2C = randomint(_id_F0C46916118D97CD);
        _id_1B82B6F689A2283D = getnodebyindex(_id_498ACC2540D38C2C);

        if(isDefined(_id_1B82B6F689A2283D) && distancesquared(node.origin, _id_1B82B6F689A2283D.origin) > 250000)
          _id_B4A4E2C4F49B95DF = _id_1B82B6F689A2283D;
      }

      if(isDefined(_id_B4A4E2C4F49B95DF)) {
        path = scripts\mp\bots\bots_util::bot_queued_process("GetNodesOnPathCrate", scripts\mp\bots\bots_util::func_get_nodes_on_path, node.origin, _id_B4A4E2C4F49B95DF.origin);

        if(isDefined(path)) {
          _id_A4A22899C4C3C751[_id_A4A22899C4C3C751.size] = node;

          if(_id_A4A22899C4C3C751.size == _id_6AE00CCCC4C48924)
            return _id_A4A22899C4C3C751;
          else
            continue;
        }
      }
    }
  }

  return undefined;
}

crate_get_bot_target(crate) {
  if(isDefined(crate.nearest_points))
    return crate.nearest_points[0];

  if(isDefined(crate.nearest_nodes) && crate.nearest_nodes.size > 0) {
    if(crate.nearest_nodes.size > 1) {
      _id_3AF344E52179F70A = scripts\engine\utility::array_reverse(self botnodescoremultiple(crate.nearest_nodes, "node_exposed"));
      return scripts\engine\utility::random_weight_sorted(_id_3AF344E52179F70A).origin;
    } else
      return crate.nearest_nodes[0].origin;
  }
}

crate_get_bot_target_check_distance(crate, _id_8C96767F296D03F3) {
  _id_DBE8B001DDD1337E = crate_get_bot_target(crate);
  _id_DBE8B001DDD1337E = getclosestpointonnavmesh(_id_DBE8B001DDD1337E, self);
  _id_D12FABBDD91EC827 = _id_8C96767F296D03F3 * 0.9;
  _id_D12FABBDD91EC827 = _id_D12FABBDD91EC827 * _id_D12FABBDD91EC827;

  if(distancesquared(crate.origin, _id_DBE8B001DDD1337E) <= _id_D12FABBDD91EC827)
    return _id_DBE8B001DDD1337E;
  else
    return undefined;
}

bot_think_crate() {
  self notify("bot_think_crate");
  self endon("bot_think_crate");
  self endon("bot_suspended");
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_EBD58F81541D9EFB = getdvarfloat("dvar_A62BADF83A03D925");

  for(;;) {
    wait_time = randomfloatrange(2, 4);
    scripts\engine\utility::waittill_notify_or_timeout("new_crate_to_take", wait_time);

    if(isDefined(self.boxes) && self.boxes.size == 0)
      self.boxes = undefined;

    _id_DC8533E12089B719 = level.carepackages;

    if(!scripts\mp\bots\bots_util::bot_in_combat() && isDefined(self.boxes))
      _id_DC8533E12089B719 = scripts\engine\utility::array_combine(_id_DC8533E12089B719, self.boxes);

    if(isDefined(level.bot_scavenger_bags) && scripts\mp\utility\perk::_hasperk("specialty_scavenger"))
      _id_DC8533E12089B719 = scripts\engine\utility::array_combine(_id_DC8533E12089B719, level.bot_scavenger_bags);

    if(isDefined(level.cratedata)) {
      foreach(crate in level.cratedata.crates) {
        if(isDefined(crate))
          _id_DC8533E12089B719[_id_DC8533E12089B719.size] = crate;
      }
    }

    _id_DC8533E12089B719 = scripts\engine\utility::array_removeundefined(_id_DC8533E12089B719);

    if(_id_DC8533E12089B719.size == 0) {
      continue;
    }
    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("airdrop_crate") || self botgetscriptgoaltype() == "tactical" || scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
      continue;
    }
    _id_9E543BDE5D2A2496 = [];

    foreach(crate in _id_DC8533E12089B719) {
      if(bot_crate_valid(crate))
        _id_9E543BDE5D2A2496[_id_9E543BDE5D2A2496.size] = crate;
    }

    _id_9E543BDE5D2A2496 = scripts\engine\utility::array_remove_duplicates(_id_9E543BDE5D2A2496);

    if(_id_9E543BDE5D2A2496.size == 0) {
      continue;
    }
    _id_9E543BDE5D2A2496 = scripts\engine\utility::get_array_of_closest(self.origin, _id_9E543BDE5D2A2496);
    _id_B6F1DEB8E946E67C = self getnearestnode();

    if(!isDefined(_id_B6F1DEB8E946E67C)) {
      continue;
    }
    _id_F249D87F5AD73653 = self[[level.bot_funcs["crate_low_ammo_check"]]]();
    _id_EC5D6613E0B30AB7 = (_id_F249D87F5AD73653 || randomint(100) < 50) && !scripts\cp_mp\emp_debuff::is_empd();
    _id_AFA0F45BB9027FDE = undefined;

    foreach(crate in _id_9E543BDE5D2A2496) {
      _id_10256E13FB6F7945 = 0;

      if((!isDefined(crate.owner) || crate.owner != self) && !isDefined(crate.boxtype)) {
        _id_2DF5BAD592BA26AC = [];

        foreach(player in level.players) {
          if(!isDefined(player.team)) {
            continue;
          }
          if(!isai(player) && level.teambased && player.team == self.team) {
            if(distancesquared(player.origin, crate.origin) < 490000)
              _id_2DF5BAD592BA26AC[_id_2DF5BAD592BA26AC.size] = player;
          }
        }

        if(_id_2DF5BAD592BA26AC.size > 0) {
          _id_F8B50191AF8C5B3C = _id_2DF5BAD592BA26AC[0] getnearestnode();

          if(isDefined(_id_F8B50191AF8C5B3C)) {
            _id_10256E13FB6F7945 = 0;

            foreach(node in crate.nearest_nodes)
            _id_10256E13FB6F7945 = _id_10256E13FB6F7945 || nodesvisible(_id_F8B50191AF8C5B3C, node, 1);
          }
        }
      }

      if(!_id_10256E13FB6F7945) {
        _id_1CDEA334D6287F87 = isDefined(crate.bots) && isDefined(crate.bots[self.team]) && crate.bots[self.team] > 0;
        _id_0539C5E6B72FB319 = 0;

        foreach(node in crate.nearest_nodes)
        _id_0539C5E6B72FB319 = _id_0539C5E6B72FB319 || nodesvisible(_id_B6F1DEB8E946E67C, node, 1);

        if(_id_0539C5E6B72FB319 || _id_EC5D6613E0B30AB7 && !_id_1CDEA334D6287F87) {
          _id_AFA0F45BB9027FDE = crate;
          break;
        }
      }
    }

    if(isDefined(_id_AFA0F45BB9027FDE)) {
      if(self[[level.bot_funcs["crate_should_claim"]]]()) {
        if(!isDefined(_id_AFA0F45BB9027FDE.boxtype)) {
          if(!isDefined(_id_AFA0F45BB9027FDE.bots))
            _id_AFA0F45BB9027FDE.bots = [];

          _id_AFA0F45BB9027FDE.bots[self.team] = 1;
        }
      }

      _id_4F3B05E382BB8C7C = spawnStruct();
      _id_4F3B05E382BB8C7C.object = _id_AFA0F45BB9027FDE;
      _id_4F3B05E382BB8C7C.start_thread = ::watch_bot_died_during_crate;
      _id_4F3B05E382BB8C7C.should_abort = ::crate_picked_up;
      _id_0B91AF5AF9F61959 = undefined;

      if(isDefined(_id_AFA0F45BB9027FDE.boxtype)) {
        if(isDefined(_id_AFA0F45BB9027FDE.boxtouchonly) && _id_AFA0F45BB9027FDE.boxtouchonly) {
          _id_4F3B05E382BB8C7C.script_goal_radius = 16;
          _id_4F3B05E382BB8C7C.action_thread = undefined;
          _id_0B91AF5AF9F61959 = _id_AFA0F45BB9027FDE.origin;
        } else {
          _id_4F3B05E382BB8C7C.script_goal_radius = 50;
          _id_4F3B05E382BB8C7C.action_thread = ::use_box;
          _id_E1FE7EE9B032B76F = crate_get_bot_target_check_distance(_id_AFA0F45BB9027FDE, _id_EBD58F81541D9EFB);

          if(!isDefined(_id_E1FE7EE9B032B76F)) {
            continue;
          }
          _id_E1FE7EE9B032B76F = _id_E1FE7EE9B032B76F - _id_AFA0F45BB9027FDE.origin;
          scale = length(_id_E1FE7EE9B032B76F) * randomfloat(1.0);
          _id_0B91AF5AF9F61959 = _id_AFA0F45BB9027FDE.origin + vectorNormalize(_id_E1FE7EE9B032B76F) * scale + (0, 0, 12);
        }
      } else {
        _id_4F3B05E382BB8C7C.action_thread = ::use_crate;
        _id_4F3B05E382BB8C7C.end_thread = ::stop_using_crate;
        _id_0B91AF5AF9F61959 = crate_get_bot_target_check_distance(_id_AFA0F45BB9027FDE, _id_EBD58F81541D9EFB);

        if(!isDefined(_id_0B91AF5AF9F61959)) {
          continue;
        }
        _id_4F3B05E382BB8C7C.script_goal_radius = _id_EBD58F81541D9EFB - distance(_id_AFA0F45BB9027FDE.origin, _id_0B91AF5AF9F61959 + (0, 0, 40));
        _id_0B91AF5AF9F61959 = _id_0B91AF5AF9F61959 + (0, 0, 24);
      }

      if(isDefined(_id_4F3B05E382BB8C7C.script_goal_radius)) {}

      _id_AFA0F45BB9027FDE notify("path_disconnect");
      wait 0.05;

      if(!isDefined(_id_AFA0F45BB9027FDE)) {
        continue;
      }
      scripts\mp\bots\bots_strategy::bot_new_tactical_goal("airdrop_crate", _id_0B91AF5AF9F61959, 30, _id_4F3B05E382BB8C7C);
    }
  }
}

bot_should_use_ballistic_vest_crate(crate) {
  return 1;
}

crate_should_claim() {
  return 1;
}

crate_low_ammo_check() {
  return 0;
}

bot_should_use_ammo_crate(crate) {
  if(getcompleteweaponname(self getcurrentweapon()) == level.boxsettings[crate.boxtype].minigunweapon)
    return 0;

  return 1;
}

bot_pre_use_ammo_crate(crate) {
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.secondaryweapon);
  wait 1.0;
}

bot_post_use_ammo_crate(crate) {
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(nullweapon());
  self.secondaryweapon = self getcurrentweapon();
}

bot_should_use_scavenger_bag(crate) {
  if(scripts\mp\bots\bots_util::bot_get_low_on_ammo(0.66)) {
    _id_B6F1DEB8E946E67C = self getnearestnode();

    if(isDefined(crate.nearest_nodes) && isDefined(crate.nearest_nodes[0]) && isDefined(_id_B6F1DEB8E946E67C)) {
      if(nodesvisible(_id_B6F1DEB8E946E67C, crate.nearest_nodes[0], 1)) {
        if(scripts\engine\utility::within_fov(self.origin, self getplayerangles(), crate.origin, self botgetfovdot()))
          return 1;
      }
    }
  }

  return 0;
}

bot_should_use_grenade_crate(crate) {
  _id_E45D691F05EAA114 = self getweaponslistoffhands();

  foreach(weapon in _id_E45D691F05EAA114) {
    if(self getweaponammostock(weapon) == 0)
      return 1;
  }

  return 0;
}

bot_should_use_juicebox_crate(crate) {
  return 1;
}

crate_monitor_position() {
  self notify("crate_monitor_position");
  self endon("crate_monitor_position");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    _id_23C058E984C5A869 = self.origin;
    wait 0.5;

    if(!isDefined(self)) {
      return;
    }
    if(!scripts\mp\bots\bots_util::bot_vectors_are_equal(self.origin, _id_23C058E984C5A869)) {
      self.on_path_grid = undefined;
      self.nearest_nodes = undefined;
      self.nearest_points = undefined;
    }
  }
}

crate_wait_use() {
  wait 0.5;
}

crate_picked_up(goal) {
  if(!isDefined(goal.object))
    return 1;

  return 0;
}

use_crate(goal) {
  if(isagent(self)) {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("agent_use");
    goal.object enableplayeruse(self);
    wait 0.05;
  }

  self[[level.bot_funcs["crate_wait_use"]]]();

  if(isDefined(goal.object.owner) && goal.object.owner == self)
    time = level.crateownerusetime / 1000 + 0.5;
  else
    time = level.cratenonownerusetime / 1000 + 1.0;

  self botpressbutton("use", time);

  while(time > 0 && isDefined(goal.object)) {
    wait 0.05;
    time = time - 0.05;
  }

  if(time > 0)
    wait(randomfloatrange(0.05, 0.5));

  if(isagent(self)) {
    _id_3B64EB40368C1450::set("agent_use", "usability", 0);

    if(isDefined(goal.object))
      goal.object disableplayeruse(self);
  }

  if(isDefined(goal.object)) {
    if(!isDefined(goal.object.bots_used))
      goal.object.bots_used = [];

    goal.object.bots_used[goal.object.bots_used.size] = self;
  }
}

use_box(goal) {
  if(isagent(self)) {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("agent_use");
    goal.object enableplayeruse(self);
    wait 0.05;
  }

  if(isDefined(goal.object) && isDefined(goal.object.boxtype)) {
    boxtype = goal.object.boxtype;

    if(isDefined(level.bot_pre_use_box_of_type[boxtype]))
      self[[level.bot_pre_use_box_of_type[boxtype]]](goal.object);

    if(isDefined(goal.object)) {
      time = level.boxsettings[goal.object.boxtype].usetime / 1000 + 0.5;
      self botpressbutton("use", time);
      wait(time);

      if(isDefined(level.bot_post_use_box_of_type[boxtype]))
        self[[level.bot_post_use_box_of_type[boxtype]]](goal.object);
    }
  }

  if(isagent(self)) {
    _id_3B64EB40368C1450::set("agent_use", "usability", 0);

    if(isDefined(goal.object))
      goal.object disableplayeruse(self);
  }
}

watch_bot_died_during_crate(goal) {
  thread bot_watch_for_death(goal.object);
}

stop_using_crate(goal) {
  if(isDefined(goal.object))
    goal.object.bots[self.team] = 0;
}

bot_watch_for_death(object) {
  object endon("death_or_disconnect");
  object endon("revived");
  level endon("game_ended");
  _id_D0C86817AD6633C8 = self.team;
  self waittill("death_or_disconnect");

  if(isDefined(object))
    object.bots[_id_D0C86817AD6633C8] = 0;
}

bot_think_crate_blocking_path() {
  self notify("bot_think_crate_blocking_path");
  self endon("bot_think_crate_blocking_path");
  self endon("bot_suspended");
  self endon("death_or_disconnect");
  level endon("game_ended");
  radius = getdvarfloat("dvar_A62BADF83A03D925");

  for(;;) {
    wait 3;

    if(self useButtonPressed()) {
      continue;
    }
    if(scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    crates = level.carepackages;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < crates.size; _id_AC0E594AC96AA3A8++) {
      crate = crates[_id_AC0E594AC96AA3A8];

      if(!isDefined(crate)) {
        continue;
      }
      _id_C5D3D8FF129F88BA = self getplayeruseentity();

      if(!isDefined(_id_C5D3D8FF129F88BA) || _id_C5D3D8FF129F88BA != crate) {
        continue;
      }
      if(distancesquared(self.origin, crate.origin) < radius * radius) {
        if(!bot_has_streak_in_crate(crate)) {
          if(isDefined(crate.owner) && crate.owner == self) {
            self botpressbutton("use", level.crateownerusetime / 1000 + 0.5);
            continue;
          }

          self botpressbutton("use", level.cratenonownerusetime / 1000 + 0.5);
        }
      }
    }
  }
}

_id_7604844B6A583A71() {
  self notify("bot_think_usable_objects");
  self endon("bot_think_usable_objects");
  self endon("bot_suspended");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    wait 2.0;

    if(self useButtonPressed()) {
      continue;
    }
    if(scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    _id_C5D3D8FF129F88BA = self getplayeruseentity();

    if(isDefined(_id_C5D3D8FF129F88BA)) {
      if(isDefined(_id_C5D3D8FF129F88BA.equipmentref) && _id_C5D3D8FF129F88BA.equipmentref == "equip_tac_insert")
        self botpressbutton("use", 1.0);
    }
  }
}

bot_think_revive() {
  self notify("bot_think_revive");
  self endon("bot_think_revive");
  self endon("bot_suspended");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!level.teambased) {
    return;
  }
  if(!scripts\mp\utility\game::islaststandenabled() && !scripts\mp\utility\game::isteamreviveenabled()) {
    return;
  }
  for(;;) {
    waittime = 2.0;
    _id_199A5EBBB9CA9FA2 = getEntArray("revive_trigger", "targetname");
    _id_2B6486BBC80874AD = level.revivetriggers;
    _id_6EF961EEA0A186A4 = scripts\engine\utility::array_combine(_id_199A5EBBB9CA9FA2, _id_2B6486BBC80874AD);

    if(_id_6EF961EEA0A186A4.size > 0)
      waittime = 0.05;

    level scripts\engine\utility::waittill_notify_or_timeout("player_last_stand", waittime);

    if(!bot_can_revive()) {
      self.isbotmedicrole = 0;
      continue;
    }

    _id_199A5EBBB9CA9FA2 = getEntArray("revive_trigger", "targetname");
    _id_2B6486BBC80874AD = level.revivetriggers;
    _id_6EF961EEA0A186A4 = scripts\engine\utility::array_combine(_id_199A5EBBB9CA9FA2, _id_2B6486BBC80874AD);

    if(_id_6EF961EEA0A186A4.size == 0) {
      continue;
    }
    _id_010F56A3597F09AE = 1;
    _id_557D59EBFF7D41B2 = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");

    if(_id_557D59EBFF7D41B2 < 4)
      _id_010F56A3597F09AE = 0;

    if(_id_6EF961EEA0A186A4.size > _id_010F56A3597F09AE) {
      _id_6EF961EEA0A186A4 = sortbydistance(_id_6EF961EEA0A186A4, self.origin);

      if(isDefined(self.owner)) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6EF961EEA0A186A4.size; _id_AC0E594AC96AA3A8++) {
          if(_id_6EF961EEA0A186A4[_id_AC0E594AC96AA3A8].owner != self.owner) {
            continue;
          }
          if(_id_AC0E594AC96AA3A8 == 0) {
            break;
          }

          _id_65A9DCF5E2E9FC21 = _id_6EF961EEA0A186A4[_id_AC0E594AC96AA3A8];
          _id_6EF961EEA0A186A4[_id_AC0E594AC96AA3A8] = _id_6EF961EEA0A186A4[0];
          _id_6EF961EEA0A186A4[0] = _id_65A9DCF5E2E9FC21;
          break;
        }
      }
    }

    foreach(_id_DA4D3A039B5722BF in _id_6EF961EEA0A186A4) {
      player = _id_DA4D3A039B5722BF.owner;

      if(!isDefined(player)) {
        continue;
      }
      if(player == self) {
        continue;
      }
      if(scripts\mp\utility\game::islaststandenabled() && (!isalive(player) || isDefined(player.fauxdead) || istrue(player.delayedspawnedplayernotify))) {
        continue;
      }
      if(player.team != self.team) {
        continue;
      }
      if(scripts\mp\utility\game::islaststandenabled() && (!isDefined(player.inlaststand) || !player.inlaststand) && !scripts\mp\utility\game::isteamreviveenabled()) {
        continue;
      }
      if(isDefined(player.bots) && isDefined(player.bots[self.team]) && player.bots[self.team] > 0) {
        continue;
      }
      if(scripts\mp\utility\game::islaststandenabled())
        _id_9C78936FDF29BD66 = player.origin;
      else
        _id_9C78936FDF29BD66 = _id_DA4D3A039B5722BF.origin;

      if(distancesquared(self.origin, _id_9C78936FDF29BD66) < 4194304) {
        _id_4F3B05E382BB8C7C = spawnStruct();
        _id_4F3B05E382BB8C7C.object = _id_DA4D3A039B5722BF;
        _id_4F3B05E382BB8C7C.script_goal_radius = 64;

        if(isDefined(self.last_revive_fail_time) && gettime() - self.last_revive_fail_time < 1000)
          _id_4F3B05E382BB8C7C.script_goal_radius = 32;

        _id_4F3B05E382BB8C7C.start_thread = ::watch_bot_died_during_revive;
        _id_4F3B05E382BB8C7C.end_thread = ::stop_reviving;
        _id_4F3B05E382BB8C7C.should_abort = ::player_revived_or_dead;
        _id_4F3B05E382BB8C7C.action_thread = ::revive_player;
        _id_8669BEC9AA3B0FC4 = 60;

        if(scripts\mp\utility\teams::getteamdata(self.team, "aliveCount") == 1)
          _id_8669BEC9AA3B0FC4 = 100;

        scripts\mp\bots\bots_strategy::bot_new_tactical_goal("revive", _id_9C78936FDF29BD66, _id_8669BEC9AA3B0FC4, _id_4F3B05E382BB8C7C);
        self.isbotmedicrole = 1;
        player.bots[self.team] = 1;
        break;
      }
    }
  }
}

watch_bot_died_during_revive(goal) {
  if(scripts\mp\utility\game::islaststandenabled())
    thread bot_watch_for_death(goal.object.owner);
}

stop_reviving(goal) {
  if(isDefined(goal.object.owner))
    goal.object.owner.bots[self.team] = 0;
}

player_revived_or_dead(goal) {
  if(scripts\mp\utility\game::islaststandenabled()) {
    if(!isDefined(goal.object.owner) || goal.object.owner.health <= 0)
      return 1;

    if(!isDefined(goal.object.owner.inlaststand) || !goal.object.owner.inlaststand)
      return 1;
  } else if(!isDefined(goal.object.owner) || scripts\mp\utility\player::isreallyalive(goal.object.owner))
    return 1;

  return 0;
}

revive_player(goal) {
  if(isDefined(goal.object.owner))
    goal.object.owner.bots[self.team] = 1;

  if(scripts\mp\utility\game::islaststandenabled())
    _id_E7072356F2FBFC24 = goal.object.owner.origin;
  else
    _id_E7072356F2FBFC24 = goal.object.origin;

  if(distancesquared(self.origin, _id_E7072356F2FBFC24) > 4900) {
    self.last_revive_fail_time = gettime();
    return;
  }

  if(isagent(self)) {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("agent_use");
    goal.object enableplayeruse(self);
    wait 0.05;
  }

  _id_D0C86817AD6633C8 = self.team;

  if(scripts\mp\utility\game::islaststandenabled())
    use_time = level.laststandrevivetimer;
  else if(isDefined(goal.object.usetime))
    use_time = goal.object.usetime / 1000;
  else
    use_time = 3;

  self botlookatpoint(goal.object.origin, use_time + 1, "script_forced");
  wait 0.5;
  self botpressbutton("use", use_time + 0.5);
  wait(use_time + 1.5);

  if(isDefined(goal.object.owner))
    goal.object.owner.bots[_id_D0C86817AD6633C8] = 0;

  if(isagent(self)) {
    _id_3B64EB40368C1450::set("agent_use", "usability", 0);

    if(isDefined(goal.object))
      goal.object disableplayeruse(self);
  }
}

bot_can_revive() {
  if(isDefined(self.laststand) && self.laststand == 1)
    return 0;

  if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("revive"))
    return 0;

  if(scripts\mp\bots\bots_util::bot_is_remote_or_linked())
    return 0;

  if(scripts\mp\bots\bots_util::bot_is_bodyguarding())
    return 1;

  if(isDefined(level.bot_funcs["tactical_revive_override"])) {
    result = self[[level.bot_funcs["tactical_revive_override"]]]();

    if(result) {
      self.isbotmedicrole = 0;
      return 1;
    }
  }

  _id_8635A138F0BA2A2A = self botgetscriptgoaltype();

  if(_id_8635A138F0BA2A2A == "none" || _id_8635A138F0BA2A2A == "hunt" || _id_8635A138F0BA2A2A == "guard")
    return 1;

  if(_id_8635A138F0BA2A2A == "objective") {
    goal = self botgetscriptgoal();

    if(distance(self.origin, goal) > 500)
      return 1;
  }

  return 0;
}

revive_watch_for_finished(player) {
  self endon("death_or_disconnect");
  self endon("bad_path");
  self endon("goal");
  player scripts\engine\utility::waittill_any_2("death", "revived");
  self notify("bad_path");
}

bot_know_enemies_on_start() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(gettime() > 15000) {
    return;
  }
  while(!scripts\mp\utility\game::gamehasstarted() || !scripts\mp\flags::gameflag("prematch_done"))
    wait 0.05;

  _id_5FF5B48FD903F4F5 = undefined;
  _id_EA273C648AE678DC = undefined;

  for(_id_6B22D0E7BBDC2DEE = 0; _id_6B22D0E7BBDC2DEE < level.players.size; _id_6B22D0E7BBDC2DEE++) {
    _id_6EE5484560EC747C = level.players[_id_6B22D0E7BBDC2DEE];

    if(isDefined(_id_6EE5484560EC747C) && isDefined(self.team) && isDefined(_id_6EE5484560EC747C.team) && !isalliedsentient(self, _id_6EE5484560EC747C)) {
      if(!isDefined(_id_6EE5484560EC747C.bot_start_known_by_enemy))
        _id_5FF5B48FD903F4F5 = _id_6EE5484560EC747C;

      if(isai(_id_6EE5484560EC747C) && !isDefined(_id_6EE5484560EC747C.bot_start_know_enemy))
        _id_EA273C648AE678DC = _id_6EE5484560EC747C;
    }
  }

  if(isDefined(_id_5FF5B48FD903F4F5)) {
    self.bot_start_know_enemy = 1;
    _id_5FF5B48FD903F4F5.bot_start_known_by_enemy = 1;
    self getenemyinfo(_id_5FF5B48FD903F4F5);
  }

  if(isDefined(_id_EA273C648AE678DC)) {
    _id_EA273C648AE678DC.bot_start_know_enemy = 1;
    self.bot_start_known_by_enemy = 1;
    _id_EA273C648AE678DC getenemyinfo(self);
  }
}

bot_think_gametype() {
  self notify("bot_think_gametype");
  self endon("bot_think_gametype");
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_5076DB025CBED16E = 0;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_5076DB025CBED16E = 1;

  if(!_id_5076DB025CBED16E)
    scripts\mp\flags::gameflagwait("prematch_done");

  self thread[[level.bot_funcs["gametype_think"]]]();
}

default_gametype_think() {}

monitor_smoke_grenades() {
  level.bot_smoke_sight_clip_large = getEnt("smoke_grenade_sight_clip_256", "targetname");

  if(!isDefined(level.bot_smoke_sight_clip_large)) {
    return;
  }
  for(;;) {
    level waittill("smoke", grenade, objweapon);

    if(objweapon.basename == "smoke_grenade_mp")
      grenade thread handle_smoke();
  }
}

handle_smoke() {
  self endon("late_death");
  thread smoke_grenade_late_death();
  self waittill("explode", _id_7CA9D4EE7D70F3E2);
  thread create_smoke_occluder(_id_7CA9D4EE7D70F3E2);
}

create_smoke_occluder(origin, _id_7AFDE3D639286931) {
  occluder = spawn("script_model", origin);
  occluder show();
  wait 1;
  occluder clonebrushmodeltoscriptmodel(level.bot_smoke_sight_clip_large);
  occluder setmovertransparentvolume();
  duration = 8.75;

  if(isDefined(_id_7AFDE3D639286931))
    duration = _id_7AFDE3D639286931;

  wait(duration);
  occluder delete();
}

smoke_grenade_late_death() {
  self endon("explode");
  self waittill("death");
  waittillframeend;
  self notify("late_death");
}

bot_add_scavenger_bag(_id_600FE02C99AEFBAE) {
  _id_96EBD880107E64E9 = 0;
  _id_600FE02C99AEFBAE.boxtype = "scavenger_bag";
  _id_600FE02C99AEFBAE.boxtouchonly = 1;

  if(!isDefined(level.bot_scavenger_bags))
    level.bot_scavenger_bags = [];

  foreach(index, _id_D5D33EF6554B62CE in level.bot_scavenger_bags) {
    if(!isDefined(_id_D5D33EF6554B62CE)) {
      _id_96EBD880107E64E9 = 1;
      level.bot_scavenger_bags[index] = _id_600FE02C99AEFBAE;
      break;
    }
  }

  if(!_id_96EBD880107E64E9)
    level.bot_scavenger_bags[level.bot_scavenger_bags.size] = _id_600FE02C99AEFBAE;

  foreach(_id_D7836AB41DCA3E4A in level.participants) {
    if(isai(_id_D7836AB41DCA3E4A) && _id_D7836AB41DCA3E4A scripts\mp\utility\perk::_hasperk("specialty_scavenger"))
      _id_D7836AB41DCA3E4A notify("new_crate_to_take");
  }
}

bot_triggers() {
  _id_750831CEDCD7F13E = getEntArray("bot_flag_set", "targetname");

  foreach(trigger in _id_750831CEDCD7F13E) {
    if(!isDefined(trigger.script_noteworthy)) {
      continue;
    }
    trigger thread bot_flag_trigger(trigger.script_noteworthy);
  }
}

bot_flag_trigger(_id_2827615D475F0477) {
  self endon("death");

  for(;;) {
    self waittill("trigger", bot);

    if(scripts\cp_mp\utility\game_utility::isaigameparticipant(bot)) {
      bot notify("flag_trigger_set_" + _id_2827615D475F0477);
      bot botsetflag(_id_2827615D475F0477, 1);
      bot thread bot_flag_trigger_clear(_id_2827615D475F0477);
    }
  }
}

bot_flag_trigger_clear(_id_2827615D475F0477) {
  self endon("flag_trigger_set_" + _id_2827615D475F0477);
  self endon("death_or_disconnect");
  level endon("game_ended");
  waitframe();
  waittillframeend;
  self botsetflag(_id_2827615D475F0477, 0);
}

load_gametype_scripts_for_scriptdev() {}