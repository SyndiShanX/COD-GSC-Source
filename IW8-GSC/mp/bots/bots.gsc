/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots.gsc
***********************************************/

main() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }
  if(getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF") == 1) {
    return;
  }
  setup_callbacks();
  scripts\mp\bots\bots_personality::setup_personalities();
  level.badplace_cylinder_func = ::badplace_cylinder;
  level.badplace_delete_func = ::badplace_delete;

  if(isDefined(level.deactivate_laser_trap))
    [[level.deactivate_laser_trap]]();
  else
    scripts\mp\bots\bots_killstreaks::bot_killstreak_setup();

  scripts\mp\bots\bots_loadout::init();
  level thread init();
  load_gametype_scripts_for_scriptdev();
}

setup_callbacks() {
  level.bot_funcs = [];
  level.bot_funcs["_encstr_95D20BE6C869B3D7E3101F7FD8"] = ::spawn_bots;
  level.bot_funcs["_encstr_9ADC1726DE8EB9BEB04646EB9B6C163BB273EC59277D98B0EC"] = ::bot_add_scavenger_bag;
  level.bot_funcs["_encstr_84491A98DE3A37FA2C3246AFE87BD78D95CE2B63BE1D1693D9CAA39B"] = scripts\mp\bots\bots_util::bot_add_to_bot_level_targets;
  level.bot_funcs["_encstr_B2381F42885DA7B9E0B3EDE77DB0712B86200A1970BDFB6F28DF0CF14DF8872BAE"] = scripts\mp\bots\bots_util::bot_remove_from_bot_level_targets;
  level.bot_funcs["_encstr_B672066D30FF90B7"] = ::bot_think;
  level.bot_funcs["_encstr_96330A95DD7FB43840C92ACD"] = ::on_bot_killed;
  level.bot_funcs["_encstr_920612633BE0DF1DC901B21A190F94733816F9E5"] = ::bot_should_do_killcam;
  level.bot_funcs["_encstr_8ABD11AAA9893FC76098B0A3C31AC33F8D93B1"] = scripts\mp\bots\bots_util::bot_get_known_attacker;
  level.bot_funcs["_encstr_8252168E297F97F00D3748CB8040537BE0831F5F11D0E6B7"] = ::bot_should_pickup_weapons;
  level.bot_funcs["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::bot_damage_callback;
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::default_gametype_think;
  level.bot_funcs["_encstr_92C10E1BAC8546599CBE8C2D0B8DEDCE"] = scripts\mp\bots\bots_util::bot_leader_dialog;
  level.bot_funcs["_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23"] = ::bot_player_spawned;
  level.bot_funcs["_encstr_AA071F6E347B5DD832FA6E4716C9D1EB36B05D3A4BB7EAE6BE16070EE4DBB0D80D"] = scripts\mp\bots\bots_strategy::should_start_cautious_approach_default;
  level.bot_funcs["_encstr_952F16EAC5AAB7BE35F36850974D73AFF26D486EDBA24503"] = ::bot_know_enemies_on_start;
  level.bot_funcs["_encstr_A143108E65FB0759D57B590817E610CFE34A"] = ::bot_get_rank_xp;
  level.bot_funcs["_encstr_876615B0A5AFCC32FACD4BD9D03AD2DCECD76BDEC856B1"] = ::bot_3d_sighting_model;
  level.bot_funcs["_encstr_AB45151102CF209FFA23072F5FC2E79096D19B286C265B"] = ::bot_think_seek_dropped_weapons;
  level.bot_funcs["_encstr_8E6C1675DAB2A1335DA3D1988F710B270A097E0F35AA43F8"] = ::should_stop_seeking_weapon;
  level.bot_funcs["_encstr_99EB0E12DB5279E596CEBBD2C11B30F8"] = ::crate_can_use_always;
  level.bot_funcs["_encstr_91C915D84EB08E2BEBD8DBBBAF2CB5B5ED7D8D1AAC6CD6"] = ::crate_low_ammo_check;
  level.bot_funcs["_encstr_B2A713E34651AB2FCFF0E2AAF891274F4921699151"] = ::crate_should_claim;
  level.bot_funcs["_encstr_9B600F8B0DE0F3675813129A9BB0FFEA68"] = ::crate_wait_use;
  level.bot_funcs["_encstr_B8430FFED25AA1E91F9F40D1EB79C0CFA2"] = ::crate_in_range;
  level.bot_funcs["_encstr_955B0E33D88EEBE9E0833C3D8110EA53"] = ::bot_post_teleport;
  level.bot_funcs["_encstr_A9CD1331F68E7DE6CA1DAF2396CCCC961BEA368E2F"] = scripts\mp\bots\bots_util::bot_set_difficulty;
  level.bot_funcs["_encstr_997614993511FE57531319632F28EBA8B8A2D2488D63"] = scripts\mp\bots\bots_util::bot_set_personality;
  level.bot_funcs["_encstr_8DA21631F63AFA47D09637D67DEEB08E6CD0EB599B56B5BC"] = ::bot_think_watch_enemy;
  level.bot_funcs["_encstr_9B84194CDB1DBE471A5ACD5B7D47166C8E5AB10B63EBB3DE2CB1DC"] = scripts\mp\bots\bots_strategy::bot_think_tactical_goals;
  level.bot_funcs["_encstr_AD5A1A31DBA3D7C4EDA36ED7CA9B5898635919EBDB9CD75823915919"] = scripts\mp\bots\bots_util::bot_bots_enabled_or_added;
  level.bot_funcs["_encstr_9AEC0D0AB3C8245B3566D31A889817"] = ::bot_think_revive;
  level.bot_random_path_function = scripts\mp\bots\bots_personality::bot_random_path_default;
  level.bot_find_defend_node_func["_encstr_95EB0866891B23FB85B3"] = scripts\mp\bots\bots_strategy::find_defend_node_capture;
  level.bot_find_defend_node_func["_encstr_9B6F0DD8B0078E5739567DD3BD37CA"] = scripts\mp\bots\bots_strategy::find_defend_node_capture_zone;
  level.bot_find_defend_node_func["_encstr_AF08083BAA57988D729B"] = scripts\mp\bots\bots_strategy::find_defend_node_protect;
  level.bot_find_defend_node_func["_encstr_860B0DE1722558457FAB0E9222730D"] = scripts\mp\bots\bots_strategy::find_defend_node_protect_zone;
  level.bot_find_defend_node_func["_encstr_ADA30A13DE32CB76572CE432"] = scripts\mp\bots\bots_strategy::find_defend_node_bodyguard;
  level.bot_find_defend_node_func["_encstr_96080730D8534E0A28"] = scripts\mp\bots\bots_strategy::find_defend_node_patrol;
  _encstr_9615268BD18667DA6837F78D098A66B72D4BC662B85DB759987BBD8DE9D02AC7C063BAEB28BCFF8E::setup_callbacks();
}

codecallback_leaderdialog(var_0, var_1) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_92C10E1BAC8546599CBE8C2D0B8DEDCE"]))
    self[[level.bot_funcs["_encstr_92C10E1BAC8546599CBE8C2D0B8DEDCE"]]](var_0, var_1);
}

init() {
  thread monitor_smoke_grenades();
  thread bot_triggers();
  initbotlevelvariables();

  if(!shouldspawnbots()) {
    return;
  }
  refresh_existing_bots();
  var_0 = botsystemstatus();

  if(var_0 == "_encstr_AA0412F063B999099ADF1084F4624166EFB34820" || var_0 == "_encstr_A24D16A3181F43C03BCBFE59974065802D53273009AA9763") {
    setmatchdata("_encstr_99350889DF6B7E181CB2", 1);

    if(istrue(level.multiteambased))
      level thread bot_connect_monitor_multiteam();
    else
      level thread bot_connect_monitor();
  } else
    level thread bot_monitor_team_limits();
}

initbotlevelvariables() {
  if(!isDefined(level.crateownerusetime))
    level.crateownerusetime = 500;

  if(!isDefined(level.cratenonownerusetime))
    level.cratenonownerusetime = 3000;

  level.bot_out_of_combat_time = 3000;
  level.bot_respawn_launcher_name = "_encstr_811711E4574BDFB32988839993C0A8C7800B0E";
  level.bot_fallback_weapon = "_encstr_87610AB4EE83FAD6374B3395";
  level.zonecount = getzonecount();
  level.bot_light_volumes = getEntArray("_encstr_A58E0F3A22E9DFE3E0B428631FF3D3C550", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.bot_dark_volumes = getEntArray("_encstr_826F0E8A506B9FC71B407A31B055FF1F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  initbotmapextents();
  level.bot_variables_initialized = 1;
}

initbotmapextents() {
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

  foreach(var_1 in level.players) {
    if(isbot(var_1)) {
      if(isalive(var_1)) {
        var_1.equipment_enabled = 1;
        var_1.bot_team = var_1.team;
        var_1.debug_ai_aggro = 1;
        var_1 thread[[level.bot_funcs["_encstr_B672066D30FF90B7"]]]();
        continue;
      }
    }
  }
}

bot_player_spawned() {
  bot_set_loadout_class();
}

bot_set_loadout_class() {
  if(!isDefined(self.bot_class)) {
    if(!bot_gametype_chooses_class()) {
      while(!isDefined(level.bot_loadouts_initialized))
        wait 0.05;

      if(isDefined(self.override_class_function))
        self.bot_class = [[self.override_class_function]]();
      else
        self.bot_class = scripts\mp\bots\bots_personality::bot_setup_callback_class();
    } else
      self.bot_class = self.class;
  }
}

watch_players_connecting() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    if(!isai(var_0) && level.players.size > 0) {
      level.players_waiting_to_join = scripts\engine\utility::array_add(level.players_waiting_to_join, var_0);
      childthread bots_notify_on_spawn(var_0);
      childthread bots_notify_on_disconnect(var_0);
      childthread bots_remove_from_array_on_notify(var_0);
    }
  }
}

bots_notify_on_spawn(var_0) {
  var_0 endon("_encstr_88411828CA23A7AEEB25E1EF060FF15B4A92C8B032BF3F83B75C");

  while(!scripts\engine\utility::array_contains(level.players, var_0))
    wait 0.05;

  var_0 notify("_encstr_A28F1313DE1DCD7D34ABB685B9BEB93816DDDCB291");
}

bots_notify_on_disconnect(var_0) {
  var_0 endon("_encstr_A28F1313DE1DCD7D34ABB685B9BEB93816DDDCB291");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_88411828CA23A7AEEB25E1EF060FF15B4A92C8B032BF3F83B75C");
}

bots_remove_from_array_on_notify(var_0) {
  var_0 scripts\engine\utility::_id_143A5("_encstr_A28F1313DE1DCD7D34ABB685B9BEB93816DDDCB291", "_encstr_88411828CA23A7AEEB25E1EF060FF15B4A92C8B032BF3F83B75C");
  level.players_waiting_to_join = scripts\engine\utility::array_remove(level.players_waiting_to_join, var_0);
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

bot_can_join_team(var_0) {
  if(scripts\mp\utility\game::matchmakinggame())
    return 1;

  if(!level.teambased)
    return 1;

  if(scripts\mp\teams::getjointeampermissions(var_0))
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

bot_connect_monitor_multiteam() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_B6CD1426B78EF51BBDDC9BCAB11D7DD6B773A58EB793");
  self endon("_encstr_B6CD1426B78EF51BBDDC9BCAB11D7DD6B773A58EB793");
  level.pausing_bot_connect_monitor = 0;
  childthread monitor_pause_spawning();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  var_0 = 1.5;

  if(!isDefined(level.bot_cm_spawned_bots))
    level.bot_cm_spawned_bots = 0;

  if(!isDefined(level.bot_cm_waited_players_time))
    level.bot_cm_waited_players_time = 0;

  if(!isDefined(level.bot_cm_human_picked))
    level.bot_cm_human_picked = 0;

  for(;;) {
    if(level.pausing_bot_connect_monitor) {
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
      continue;
    }

    var_1 = isDefined(level.bots_ignore_team_balance) || !level.teambased;
    var_2 = botgetteamlimit(0);
    var_3 = botgetteamlimit(1);
    var_4 = botgetteamdifficulty(0);
    var_5 = botgetteamdifficulty(1);
    var_9 = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8C040BBEA3CAB0B5C6B7D5373A", -1);
    var_10 = var_3 + var_2;
    var_11 = "_encstr_9A8507BA4040188D08";

    if(isDefined(level.bot_last_team_ally))
      var_11 = level.bot_last_team_ally;

    var_12 = "_encstr_8E8405EA382B2A";

    if(isDefined(level.bot_last_team_enemy))
      var_12 = level.bot_last_team_enemy;

    var_13 = bot_client_counts();
    var_14 = cat_array_get(var_13, "_encstr_8B44074A6379574D40");

    if(var_14 > 1) {
      var_15 = bot_get_host_team();

      if(!scripts\mp\utility\game::matchmakinggame() && isDefined(var_15) && var_15 != "_encstr_AF8C0A1B6A1D6045925B4F7D")
        var_11 = var_15;
      else {
        var_16 = cat_array_get(var_13, "_encstr_A1440E8BE36A7B78C3D7A8F823E1D197");
        var_17 = cat_array_get(var_13, "_encstr_872F0C6833D7EF288A0F8BB151F2");

        if(var_17 > var_16)
          var_11 = "_encstr_8E8405EA382B2A";
      }
    } else {
      var_18 = get_human_player();

      if(isDefined(var_18)) {
        var_19 = var_18 bot_get_player_team();

        if(isDefined(var_19) && var_19 != "_encstr_AF8C0A1B6A1D6045925B4F7D")
          var_11 = var_19;
      }
    }

    level.bot_last_team_ally = var_11;
    var_20 = 0;

    foreach(var_22 in level.allteamnamelist)
    var_20 = var_20 + cat_array_get(var_13, "_encstr_B8B206062084DB89" + var_22);

    if(var_20 > 0)
      level.bot_cm_spawned_bots = 1;

    var_24 = 0;

    if(!level.bot_cm_human_picked)
      var_24 = !bot_get_human_picked_team();

    if(var_24) {
      var_25 = !getdvarint("_encstr_BE9C0BD1E3C16D64B9DB4989F7");
      var_26 = 0;

      if(var_25 || var_26) {
        level.bot_cm_waited_players_time = level.bot_cm_waited_players_time + var_0;
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
        continue;
      }
    }

    var_27 = var_10 - var_20;
    var_28 = var_27;
    var_29 = var_28 > 0;

    if(var_29) {
      if(var_9 <= 6) {
        for(var_30 = []; var_28 > 0; var_28--) {
          var_31 = undefined;
          var_32 = undefined;

          foreach(var_22 in level.teamnamelist) {
            var_34 = level.teamdata[var_22]["_encstr_AB580A05672AE35D5FFF50B8"];

            if(!isDefined(var_31) || var_32 > var_34) {
              var_31 = var_22;
              var_32 = var_34;
            }
          }

          if(!isDefined(var_30[var_31]))
            var_30[var_31] = 0;

          var_30[var_31]++;
        }

        foreach(var_22, var_37 in var_30) {
          level thread spawn_bots(var_30[var_22], var_22, undefined, undefined, "_encstr_A20D10F7D987435E2BA9C94FC028957A6D37", var_5);
          level waittill("_encstr_A20D10F7D987435E2BA9C94FC028957A6D37");
        }
      } else {
        foreach(var_22 in level.teamnamelist) {
          var_34 = level.teamdata[var_22]["_encstr_AB580A05672AE35D5FFF50B8"];
          var_39 = level.maxteamsize - var_34;

          if(var_39 == 0) {
            continue;
          }
          var_40 = int(min(var_28, var_39));
          var_28 = var_28 - var_40;
          level thread spawn_bots(var_40, var_22, undefined, undefined, "_encstr_A20D10F7D987435E2BA9C94FC028957A6D37", var_5);
          level waittill("_encstr_A20D10F7D987435E2BA9C94FC028957A6D37");

          if(var_28 == 0) {
            break;
          }
        }
      }
    }

    if(var_5 != var_4) {
      bots_update_difficulty(var_12, var_5);
      bots_update_difficulty(var_11, var_4);
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  }
}

bot_connect_monitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_B6CD1426B78EF51BBDDC9BCAB11D7DD6B773A58EB793");
  self endon("_encstr_B6CD1426B78EF51BBDDC9BCAB11D7DD6B773A58EB793");
  level.pausing_bot_connect_monitor = 0;
  childthread monitor_pause_spawning();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  var_0 = 1.5;

  if(!isDefined(level.bot_cm_spawned_bots))
    level.bot_cm_spawned_bots = 0;

  if(!isDefined(level.bot_cm_waited_players_time))
    level.bot_cm_waited_players_time = 0;

  if(!isDefined(level.bot_cm_human_picked))
    level.bot_cm_human_picked = 0;

  for(;;) {
    if(level.pausing_bot_connect_monitor) {
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
      continue;
    }

    var_1 = isDefined(level.bots_ignore_team_balance) || !level.teambased;
    var_2 = botgetteamlimit(0);
    var_3 = botgetteamlimit(1);
    var_4 = botgetteamdifficulty(0);
    var_5 = botgetteamdifficulty(1);
    var_9 = "_encstr_9A8507BA4040188D08";

    if(isDefined(level.bot_last_team_ally))
      var_9 = level.bot_last_team_ally;

    var_10 = "_encstr_8E8405EA382B2A";

    if(isDefined(level.bot_last_team_enemy))
      var_10 = level.bot_last_team_enemy;

    var_11 = bot_client_counts();
    var_12 = cat_array_get(var_11, "_encstr_8B44074A6379574D40");

    if(var_12 > 1) {
      var_13 = bot_get_host_team();

      if(!scripts\mp\utility\game::matchmakinggame() && isDefined(var_13) && var_13 != "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_13 != "_encstr_933E090A10B17DDFB3E522") {
        var_9 = var_13;
        var_10 = scripts\mp\utility\game::getotherteam(var_13)[0];
      } else {
        var_14 = cat_array_get(var_11, "_encstr_A1440E8BE36A7B78C3D7A8F823E1D197");
        var_15 = cat_array_get(var_11, "_encstr_872F0C6833D7EF288A0F8BB151F2");

        if(var_15 > var_14) {
          var_9 = "_encstr_8E8405EA382B2A";
          var_10 = "_encstr_9A8507BA4040188D08";
        }
      }
    } else {
      var_16 = get_human_player();

      if(isDefined(var_16)) {
        var_17 = var_16 bot_get_player_team();

        if(isDefined(var_17) && var_17 != "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_17 != "_encstr_933E090A10B17DDFB3E522") {
          var_9 = var_17;
          var_10 = scripts\mp\utility\game::getotherteam(var_17)[0];
        }
      }
    }

    level.bot_last_team_ally = var_9;
    level.bot_last_team_enemy = var_10;
    var_18 = scripts\mp\bots\bots_util::bot_get_team_limit();
    var_19 = scripts\mp\bots\bots_util::bot_get_team_limit();
    var_20 = scripts\mp\bots\bots_util::bot_get_client_limit();

    if(var_18 + var_19 < var_20) {
      if(var_18 < var_2)
        var_18++;
      else if(var_19 < var_3)
        var_19++;
    }

    var_21 = cat_array_get(var_11, "_encstr_A6C20868F7B74EABBFA8" + var_9);
    var_22 = cat_array_get(var_11, "_encstr_A6C20868F7B74EABBFA8" + var_10);
    var_23 = var_21 + var_22;
    var_24 = cat_array_get(var_11, "_encstr_AF8C0A1B6A1D6045925B4F7D");
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

    var_29 = cat_array_get(var_11, "_encstr_B8B206062084DB89" + var_9);
    var_30 = cat_array_get(var_11, "_encstr_B8B206062084DB89" + var_10);
    var_31 = var_29 + var_30;

    if(var_31 > 0)
      level.bot_cm_spawned_bots = 1;

    var_32 = 0;

    if(!level.bot_cm_human_picked) {
      var_32 = !bot_get_human_picked_team();

      if(!var_32)
        level.bot_cm_human_picked = 1;
    }

    if(var_32) {
      var_33 = !getdvarint("_encstr_BE9C0BD1E3C16D64B9DB4989F7");
      var_34 = var_3 != var_2;
      var_35 = !bot_get_human_picked_team() && !var_1 && var_34 && !level.bot_cm_spawned_bots && (level.bot_cm_waited_players_time < 10 || !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"));
      var_36 = 0;

      if(var_33 || var_35 || var_36) {
        level.bot_cm_waited_players_time = level.bot_cm_waited_players_time + var_0;
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
        continue;
      }
    }

    var_37 = int(min(var_18 - var_21 - var_25, var_2));
    var_38 = int(min(var_19 - var_22 - var_26, var_3));
    var_39 = 1;
    var_40 = var_37 + var_38 + var_12;
    var_41 = var_2 + var_3 + var_12;

    for(var_42 = [-1, -1]; var_40 < var_20 && var_40 < var_41; var_39 = !var_39) {
      if(var_39 && var_37 < var_2 && bot_can_join_team(var_9))
        var_37++;
      else if(!var_39 && var_38 < var_3 && bot_can_join_team(var_10))
        var_38++;

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
      if(!isDefined(level.bot_prematchdonetime) && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
        level.bot_prematchdonetime = gettime();

      if(var_32 && (!isDefined(level.bot_prematchdonetime) || gettime() - level.bot_prematchdonetime < 10000))
        var_38--;
    }

    var_44 = var_37 - var_29;
    var_45 = var_38 - var_30;
    var_46 = 1;

    if(var_1) {
      var_47 = var_18 + var_19;
      var_48 = var_2 + var_3;
      var_49 = var_21 + var_22;
      var_50 = var_29 + var_30;
      var_51 = int(min(var_47 - var_49, var_48));
      var_52 = var_51 - var_50;

      if(var_52 == 0)
        var_46 = 0;
      else if(var_52 > 0) {
        var_44 = int(var_52 / 2) + var_52 % 2;
        var_45 = int(var_52 / 2);
      } else if(var_52 < 0) {
        var_53 = var_52 * -1;
        var_44 = -1 * int(min(var_53, var_29));
        var_45 = -1 * (var_53 + var_44);
      }
    } else if(!scripts\mp\utility\game::matchmakinggame() && (var_44 * var_45 < 0 && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && bot_allowed_to_switch_teams())) {
      var_54 = int(min(abs(var_44), abs(var_45)));

      if(var_44 > 0)
        move_bots_from_team_to_team(var_54, var_10, var_9, var_4);
      else if(var_45 > 0)
        move_bots_from_team_to_team(var_54, var_9, var_10, var_5);

      var_46 = 0;
    }

    if(istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]) && istrue(level.launchchunkfreespawn)) {
      var_45 = 2 - var_30;
      var_44 = 1 - var_29;
    }

    if(var_46) {
      if(var_45 < 0)
        drop_bots(var_45 * -1, var_10);

      if(var_44 < 0)
        drop_bots(var_44 * -1, var_9);

      if(var_45 > 0)
        level thread spawn_bots(var_45, var_10, undefined, undefined, "_encstr_A20D10F7D987435E2BA9C94FC028957A6D37", var_5);

      if(var_44 > 0)
        level thread spawn_bots(var_44, var_9, undefined, undefined, "_encstr_8EC50F5F713FFBE6A8F1A136E83839128E", var_4);

      if(var_45 > 0 && var_44 > 0)
        level scripts\engine\utility::_id_1439F("_encstr_A20D10F7D987435E2BA9C94FC028957A6D37", "_encstr_8EC50F5F713FFBE6A8F1A136E83839128E");
      else if(var_45 > 0)
        level waittill("_encstr_A20D10F7D987435E2BA9C94FC028957A6D37");
      else if(var_44 > 0)
        level waittill("_encstr_8EC50F5F713FFBE6A8F1A136E83839128E");
    }

    if(var_5 != var_4) {
      bots_update_difficulty(var_10, var_5);
      bots_update_difficulty(var_9, var_4);
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  }
}

bot_monitor_team_limits() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_9A3B18E5C01B6905BD9DF2B5F796B18335A2CA46F0BB8060737B");
  self endon("_encstr_9A3B18E5C01B6905BD9DF2B5F796B18335A2CA46F0BB8060737B");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  var_0 = 1.5;

  for(;;) {
    level.bot_max_players_on_team["_encstr_9A8507BA4040188D08"] = 0;
    level.bot_max_players_on_team["_encstr_8E8405EA382B2A"] = 0;

    foreach(var_2 in level.players) {
      if(isDefined(var_2.team) && (var_2.team == "_encstr_9A8507BA4040188D08" || var_2.team == "_encstr_8E8405EA382B2A"))
        level.bot_max_players_on_team[var_2.team]++;
    }

    update_max_players_from_team_agents();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  }
}

update_max_players_from_team_agents() {
  if(isDefined(level.agentarray)) {
    foreach(var_1 in level.agentarray) {
      if(isDefined(var_1.isactive) && var_1.isactive) {
        if(scripts\mp\utility\entity::isteamparticipant(var_1) && isDefined(var_1.team) && (var_1.team == "_encstr_9A8507BA4040188D08" || var_1.team == "_encstr_8E8405EA382B2A"))
          level.bot_max_players_on_team[var_1.team]++;
      }
    }
  }
}

bot_get_player_team() {
  if(isDefined(self.team))
    return self.team;

  if(isDefined(self.pers["_encstr_8AEF05472BC2D6"]))
    return self.pers["_encstr_8AEF05472BC2D6"];

  return undefined;
}

bot_get_host_team() {
  foreach(var_1 in level.players) {
    if(!isai(var_1) && var_1 ishost())
      return var_1 bot_get_player_team();
  }

  return "_encstr_AF8C0A1B6A1D6045925B4F7D";
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
  if(isDefined(var_0.team) && var_0.team != "_encstr_AF8C0A1B6A1D6045925B4F7D")
    return 1;

  if(isDefined(var_0.spectating_actively) && var_0.spectating_actively)
    return 1;

  if(var_0 ismlgspectator() && isDefined(var_0.team) && var_0.team == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    return 1;

  return 0;
}

damageskipburndownlow() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(!isai(var_4)) {
      if(var_4 ishost())
        var_0 = 1;

      if(isDefined(var_4.class)) {
        var_1 = 1;

        if(var_4 ishost())
          var_2 = 1;
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
      var_0 = cat_array_add(var_0, "_encstr_AF1904A7F929");
      var_0 = cat_array_add(var_0, var_2.team);

      if(isbot(var_2)) {
        var_0 = cat_array_add(var_0, "_encstr_9B9B05A21F601A");
        var_0 = cat_array_add(var_0, "_encstr_B8B206062084DB89" + var_2.team);
        continue;
      }

      var_0 = cat_array_add(var_0, "_encstr_8B44074A6379574D40");
      var_0 = cat_array_add(var_0, "_encstr_A6C20868F7B74EABBFA8" + var_2.team);
    }
  }

  return var_0;
}

cat_array_add(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = [];

  if(!isDefined(var_0[var_1]))
    var_0[var_1] = 0;

  var_0[var_1] = var_0[var_1] + 1;
  return var_0;
}

cat_array_get(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(!isDefined(var_0[var_1]))
    return 0;

  return var_0[var_1];
}

move_bots_from_team_to_team(var_0, var_1, var_2, var_3) {
  foreach(var_5 in level.players) {
    if(!isDefined(var_5.team)) {
      continue;
    }
    if(isDefined(var_5.connected) && var_5.connected && isbot(var_5) && var_5.team == var_1) {
      var_5.bot_team = var_2;

      if(isDefined(var_3))
        var_5 scripts\mp\bots\bots_util::bot_set_difficulty(var_3);

      var_5 notify("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", "_encstr_B1AC0C6340CF52777A284B638019", bot_lui_convert_team_to_int(var_2));
      wait 0.05;
      var_5 notify("_encstr_B4C617593F92B5F0E58B76C9B5D95876292733D18F1A05780C", var_5.bot_class);
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
      if(var_1 != var_3 botgetdifficulty())
        var_3 scripts\mp\bots\bots_util::bot_set_difficulty(var_1);
    }
  }
}

bot_drop() {
  kick(self.entity_number, "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
  wait 0.1;
}

drop_bots(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    if(isDefined(var_4.connected) && var_4.connected && isbot(var_4) && (!isDefined(var_1) || isDefined(var_4.team) && var_4.team == var_1))
      var_2[var_2.size] = var_4;
  }

  for(var_6 = var_2.size - 1; var_6 >= 0; var_6--) {
    if(var_0 <= 0) {
      break;
    }

    if(!var_2[var_6] scripts\cp_mp\utility\player_utility::_isalive()) {
      var_2[var_6] bot_drop();
      var_2 = scripts\engine\utility::array_remove(var_2, var_2[var_6]);
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
  if(var_0 == "_encstr_8E8405EA382B2A")
    return 0;
  else if(var_0 == "_encstr_9A8507BA4040188D08")
    return 1;
  else if(var_0 == "_encstr_8F4B0BD00FAC3813FB1A0B0435" || var_0 == "_encstr_A31207CBF788523281")
    return 2;
  else
    return 3;
}

spawn_bot_latent(var_0, var_1, var_2) {
  var_3 = gettime() + 60000;

  while(!self canspawnbotortestclient()) {
    if(gettime() >= var_3) {
      kick(self.entity_number, "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
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
    var_4 = randomfloatrange(0.25, 2.0);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_4);
  }

  if(!isDefined(self)) {
    var_2.abort = 1;
    return;
  }

  self spawnbotortestclient();
  self.equipment_enabled = 1;
  self.bot_team = var_0;

  if(isDefined(var_2.difficulty))
    scripts\mp\bots\bots_util::bot_set_difficulty(var_2.difficulty);

  if(isDefined(var_1))
    self[[var_1]]();

  self thread[[level.bot_funcs["_encstr_B672066D30FF90B7"]]]();
  var_2.ready = 1;
}

spawn_bots(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = gettime() + 15000;
  var_7 = [];
  var_8 = var_7.size;

  while(level.players.size < scripts\mp\bots\bots_util::bot_get_client_limit() && var_7.size < var_0 && gettime() < var_6) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.05);
    var_9 = undefined;

    if(isbotmatchmakingenabled()) {
      if(level.teambased)
        var_9 = addmpbottoteam(var_1);
      else
        var_9 = addmpbottoteam("_encstr_8BBA05185F8B99");
    } else
      var_9 = addbot("_encstr_B40101");

    if(!isDefined(var_9)) {
      if(isDefined(var_3) && var_3) {
        if(isDefined(var_4))
          self notify(var_4);

        return;
      }

      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
      continue;
    } else {
      var_10 = spawnStruct();
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

  while(var_11 < var_7.size && gettime() < var_6) {
    var_11 = 0;

    foreach(var_10 in var_7) {
      if(var_10.ready || var_10.abort)
        var_11++;
    }

    wait 0.05;
  }

  if(isDefined(var_4))
    self notify(var_4);
}

bot_gametype_chooses_team() {
  if(scripts\mp\utility\game::matchmakinggame() && self.sessionteam != "_encstr_8BBA05185F8B99")
    var_0 = 0;
  else if(!scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::denysystemicteamchoice() && scripts\mp\utility\game::doesmodesupportplayerteamchoice())
    var_0 = 1;
  else
    var_0 = 0;

  return !var_0;
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
  self notify("_encstr_85510AAE45DB271BF82FF020");
  self endon("_encstr_85510AAE45DB271BF82FF020");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(!isDefined(self.pers["_encstr_8AEF05472BC2D6"]))
    wait 0.05;

  level.hasbots = 1;

  if(bot_gametype_chooses_team())
    self.bot_team = self.pers["_encstr_8AEF05472BC2D6"];

  var_0 = self.bot_team;

  if(!isDefined(var_0))
    var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  self.entity_number = self getentitynumber();
  var_1 = 0;

  if(!isDefined(self.debug_ai_aggro)) {
    var_1 = 1;
    self.debug_ai_aggro = 1;

    if(!bot_gametype_chooses_team()) {
      var_2 = self.pers["_encstr_8AEF05472BC2D6"] != "_encstr_AF8C0A1B6A1D6045925B4F7D" && !isDefined(self.bot_team);

      if(!var_2) {
        var_3 = isDefined(self.bot_team) && self.bot_team != self.pers["_encstr_8AEF05472BC2D6"];

        if(var_3)
          self notify("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", "_encstr_B1AC0C6340CF52777A284B638019", bot_lui_convert_team_to_int(var_0));

        wait 0.5;

        if(self.pers["_encstr_8AEF05472BC2D6"] == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
          bot_drop();
          return;
        }
      }
    }
  }

  for(;;) {
    scripts\mp\bots\bots_util::bot_set_difficulty(self botgetdifficulty());
    self.difficulty = self botgetdifficulty();
    var_4 = self botgetdifficultysetting("_encstr_82711489D52B67451FF88AC190557A2740CF1C097512");

    if(var_1 && isDefined(var_4) && var_4 != 0)
      scripts\mp\bots\bots_personality::bot_balance_personality();

    scripts\mp\bots\bots_personality::bot_assign_personality_functions();

    if(var_1) {
      if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_BD40166CD8B0DCCDBE6EACB1B21B3A7DDED9593939A54656"]))
        self[[level.bot_funcs["_encstr_BD40166CD8B0DCCDBE6EACB1B21B3A7DDED9593939A54656"]]]();
      else {
        bot_set_loadout_class();

        if(!bot_gametype_chooses_class()) {
          if(isDefined(self.connecttime) && self.connecttime == gettime()) {
            waittillframeend;
            waittillframeend;
          }

          self notify("_encstr_B4C617593F92B5F0E58B76C9B5D95876292733D18F1A05780C", self.bot_class);
        }
      }

      if(self.health == 0) {
        self.bwaitingforteamselect = 1;
        self notify("_encstr_BDEA1396B8F9E16AB128BBD7C1CB3FA98F4FDE4B90");
        self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
        self.bwaitingforteamselect = undefined;
        self.bot_team = var_0;
      }

      if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_952F16EAC5AAB7BE35F36850974D73AFF26D486EDBA24503"]))
        self thread[[level.bot_funcs["_encstr_952F16EAC5AAB7BE35F36850974D73AFF26D486EDBA24503"]]]();

      var_1 = 0;
    }

    scripts\mp\bots\bots_loadout::deactive_trophy_protection();
    dead_target_count();
    bot_restart_think_threads();
    wait 0.1;
    self waittill("_encstr_AD75063D571AE108");

    if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_B1C410837BE6D1F5322B588E34EB66EAB9B1"]))
      self[[level.bot_funcs["_encstr_B1C410837BE6D1F5322B588E34EB66EAB9B1"]]]();

    respawn_watcher();
    self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  }
}

dead_target_count() {
  if(scripts\mp\tweakables::gettweakablevalue("_encstr_B472054FE12550", "_encstr_8DEF0E30E63BA241CF8A8030326521BB"))
    self botsetflag("_encstr_99290F88FD04A0C0F2EF43415F1A1010B3", 1);
}

respawn_watcher() {
  self endon("_encstr_8716143EFC0FC379CFDA5930B3E62718A39C4FB345FB");

  while(!self.waitingtospawn)
    wait 0.05;

  if(scripts\mp\playerlogic::needsbuttontorespawn()) {
    while(self.waitingtospawn) {
      if(self.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
        if(getdvarint("_encstr_AAAE09A03BDF5128C33DB7") == 0 || self.pers["_encstr_8CAA06DB20A31543"] > 0)
          self botpressbutton("_encstr_AB19049D0FC0", 0.5);
      }

      wait 1.0;
    }
  }
}

bot_get_rank_xp() {
  if(scripts\mp\bots\bots_util::bot_israndom() == 0) {
    if(!isDefined(self.pers["_encstr_851207B317B203FA5A"]))
      self.pers["_encstr_851207B317B203FA5A"] = 0;

    return self.pers["_encstr_851207B317B203FA5A"];
  }

  var_0 = self botgetdifficulty();
  var_1 = "_encstr_9B340A96702C1FEE02FB6876" + var_0;

  if(isDefined(self.pers[var_1]) && self.pers[var_1] > 0)
    return self.pers[var_1];

  var_2 = bot_random_ranks_for_difficulty(var_0);
  var_3 = var_2["_encstr_A51F05CB11A052"];
  var_4 = var_2["_encstr_A1ED09400BA5D351227715"];
  var_5 = scripts\mp\rank::getrankinfominxp(var_3);
  var_6 = var_5 + scripts\mp\rank::getrankinfoxpamt(var_3);
  var_7 = randomintrange(var_5, var_6 + 1);
  self.pers[var_1] = var_7;
  return var_7;
}

bot_3d_sighting_model(var_0) {
  thread bot_3d_sighting_model_thread(var_0);
}

bot_3d_sighting_model_thread(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(isalive(self) && !self botcanseeentity(var_0) && scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var_0.origin, self botgetfovdot()))
      self botgetimperfectenemyinfo(var_0, var_0.origin);

    wait 0.1;
  }
}

bot_random_ranks_for_difficulty(var_0) {
  var_1 = [];
  var_1["_encstr_A51F05CB11A052"] = 0;
  var_1["_encstr_A1ED09400BA5D351227715"] = 0;

  if(var_0 == "_encstr_8B1608EC43B8D647A113")
    return var_1;

  if(!isDefined(level.bot_rnd_rank)) {
    level.bot_rnd_rank = [];
    level.bot_rnd_rank["_encstr_889F0893CA6CC9BA2D8E"][0] = 0;
    level.bot_rnd_rank["_encstr_889F0893CA6CC9BA2D8E"][1] = 1;
    level.bot_rnd_rank["_encstr_813008928DA89D31A8CA"][0] = 3;
    level.bot_rnd_rank["_encstr_813008928DA89D31A8CA"][1] = 18;
    level.bot_rnd_rank["_encstr_A7D409342C272359DC59C8"][0] = 22;
    level.bot_rnd_rank["_encstr_A7D409342C272359DC59C8"][1] = 38;
    level.bot_rnd_rank["_encstr_BAAF081BD348D7E299C8"][0] = 40;
    level.bot_rnd_rank["_encstr_BAAF081BD348D7E299C8"][1] = 54;
  }

  if(!isDefined(level.bot_rnd_prestige)) {
    level.bot_rnd_prestige = [];
    level.bot_rnd_prestige["_encstr_889F0893CA6CC9BA2D8E"][0] = 0;
    level.bot_rnd_prestige["_encstr_889F0893CA6CC9BA2D8E"][1] = 0;
    level.bot_rnd_prestige["_encstr_813008928DA89D31A8CA"][0] = 0;
    level.bot_rnd_prestige["_encstr_813008928DA89D31A8CA"][1] = 0;
    level.bot_rnd_prestige["_encstr_A7D409342C272359DC59C8"][0] = 0;
    level.bot_rnd_prestige["_encstr_A7D409342C272359DC59C8"][1] = 0;
    level.bot_rnd_prestige["_encstr_BAAF081BD348D7E299C8"][0] = 0;
    level.bot_rnd_prestige["_encstr_BAAF081BD348D7E299C8"][1] = 9;
  }

  var_1["_encstr_A51F05CB11A052"] = randomintrange(level.bot_rnd_rank[var_0][0], level.bot_rnd_rank[var_0][1] + 1);
  var_1["_encstr_A1ED09400BA5D351227715"] = randomintrange(level.bot_rnd_prestige[var_0][0], level.bot_rnd_prestige[var_0][1] + 1);
  return var_1;
}

crate_can_use_always(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype))
    return 0;

  if(isDefined(var_0.cratetype) && !scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var_0.cratetype))
    return 0;

  return 1;
}

get_human_player() {
  var_0 = undefined;
  var_1 = getEntArray("_encstr_8BB007E03658CBCAE4", "_encstr_AC110A7F14873B5B3D073009");

  if(isDefined(var_1)) {
    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      if(isDefined(var_1[var_2]) && isDefined(var_1[var_2].connected) && var_1[var_2].connected && !isai(var_1[var_2]) && (!isDefined(var_0) || var_0.team == "_encstr_AF8C0A1B6A1D6045925B4F7D"))
        var_0 = var_1[var_2];
    }
  }

  return var_0;
}

bot_damage_callback(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(var_2 == "_encstr_87A10C9D24E997A01F21838F3D34" || var_2 == "_encstr_AB590C99ED78875F650F3951034D") {
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
    if(isDefined(self.fnbotdamagecallback))
      self[[self.fnbotdamagecallback]](var_0, var_1, var_2, var_3, var_4, var_5);

    if(level.teambased) {
      if(isDefined(var_4.team) && var_4.team == self.team)
        return;
      else if(isDefined(var_0) && isDefined(var_0.team) && var_0.team == self.team)
        return;
    }

    var_6 = scripts\mp\bots\bots_util::bot_get_known_attacker(var_0, var_4);

    if(isDefined(var_6))
      self botsetattacker(var_6);
  }

  if(isagent(self))
    self notify("_encstr_8AC40C09FF4D581570BF9B8BCF0A");
}

on_bot_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self botclearscriptenemy();
  self botclearscriptgoal();
  var_10 = scripts\mp\bots\bots_util::bot_get_known_attacker(var_1, var_0);

  if(isDefined(var_10) && (var_10.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" || var_10.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") && isDefined(var_10.helitype)) {
    var_11 = self botgetdifficultysetting("_encstr_AAE216C81E3D38FED2CF85CDE74BBF98D735D5C0869E18A5");

    if(randomfloat(1.0) < var_11)
      self.respawn_with_launcher = 1;
  }
}

bot_should_do_killcam() {
  if(istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]))
    return 1;

  var_5 = 0.0;
  var_6 = self botgetdifficulty();

  if(var_6 == "_encstr_889F0893CA6CC9BA2D8E")
    var_5 = 0.1;
  else if(var_6 == "_encstr_813008928DA89D31A8CA")
    var_5 = 0.4;
  else if(var_6 == "_encstr_A7D409342C272359DC59C8")
    var_5 = 0.7;
  else if(var_6 == "_encstr_BAAF081BD348D7E299C8")
    var_5 = 1.0;

  return randomfloat(1.0) < 1.0 - var_5;
}

bot_should_pickup_weapons() {
  return 1;
}

bot_restart_think_threads() {
  self thread[[level.bot_funcs["_encstr_8DA21631F63AFA47D09637D67DEEB08E6CD0EB599B56B5BC"]]]();
  self thread[[level.bot_funcs["_encstr_9B84194CDB1DBE471A5ACD5B7D47166C8E5AB10B63EBB3DE2CB1DC"]]]();
  self thread[[level.bot_funcs["_encstr_AB45151102CF209FFA23072F5FC2E79096D19B286C265B"]]]();
  self thread[[level.bot_funcs["_encstr_9AEC0D0AB3C8245B3566D31A889817"]]]();
  thread bot_think_crate();
  thread bot_think_crate_blocking_path();
  thread scripts\mp\bots\bots_killstreaks::bot_think_killstreak();
  thread scripts\mp\bots\bots_killstreaks::bot_think_watch_aerial_killstreak();
  thread bot_think_gametype();
  thread bot_think_dynamic_doors();
  thread bot_think_nvg();
}

sortdoorsbydistance(var_0, var_1) {
  return distancesquared(var_0.origin, self.closestdoorpos) < distancesquared(var_1.origin, self.closestdoorpos);
}

bot_think_dynamic_doors() {
  self notify("_encstr_BAAE184BC74859E4B84B351051D82F2001187B30572F2FD07303");
  self endon("_encstr_BAAE184BC74859E4B84B351051D82F2001187B30572F2FD07303");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = self getmodifierlocationonpath("_encstr_B16705D9AFE22E", 64);

    if(isDefined(var_0)) {
      self.closestdoorpos = var_0;
      var_1 = getentarrayinradius("_encstr_964E0D322F73B0B6961BBE19BDDB27", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_0, 64);

      if(var_1.size > 0) {
        var_1 = scripts\engine\utility::array_sort_with_func(var_1, ::sortdoorsbydistance);
        var_2 = var_1[0];

        if(isDefined(var_2.state) && var_2 scripts\mp\door::door_can_open_check())
          var_2 thread scripts\mp\door::cheapopen(self);
      }

      self.closestdoorpos = undefined;
    }

    wait 0.05;
  }
}

bot_think_nvg() {
  self notify("_encstr_B4CE0EC4BDA3BE8E86D2B9B5FA9BCEEC");
  self endon("_encstr_B4CE0EC4BDA3BE8E86D2B9B5FA9BCEEC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
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

    if(istrue(self.inmotionlight))
      var_2 = 1;

    if(var_1 || var_0 && !var_2) {
      self botsetflag("_encstr_8F1D0ACC17EB0F495B93DA92", 1);
      self.indarkarea = 1;
    } else if(!var_1 && istrue(self.indarkarea)) {
      self botsetflag("_encstr_8F1D0ACC17EB0F495B93DA92", 0);
      self.indarkarea = 0;
    }

    wait 0.25;
  }
}

bot_think_watch_enemy(var_0) {
  var_1 = "_encstr_A76F0F9B1C16BB37B246FAC1C616E59527";

  if(isDefined(var_0) && var_0)
    var_1 = "_encstr_AD75063D571AE108";

  self notify("_encstr_8DA21631F63AFA47D09637D67DEEB08E6CD0EB599B56B5BC");
  self endon("_encstr_8DA21631F63AFA47D09637D67DEEB08E6CD0EB599B56B5BC");
  self endon(var_1);
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
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
  self notify("_encstr_BEF81F651FE30808D8EC70A819ABC85D4A77D1CD874B6758EC495B61BE70603763");
  self endon("_encstr_BEF81F651FE30808D8EC70A819ABC85D4A77D1CD874B6758EC495B61BE70603763");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83";

  for(;;) {
    var_1 = 0;

    if(scripts\mp\bots\bots_util::damagestatedata(0.33)) {
      if(self[[level.bot_funcs["_encstr_8252168E297F97F00D3748CB8040537BE0831F5F11D0E6B7"]]]() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
        var_2 = getEntArray("_encstr_AD580F5F2388E9EB57322E3069A1074090", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_3 = scripts\engine\utility::get_array_of_closest(self.origin, var_2);

        if(var_3.size > 0) {
          var_4 = var_3[0];
          bot_seek_dropped_weapon(var_4);
        }
      }
    }

    if(!scripts\mp\bots\bots_util::bot_in_combat() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked() && self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") > 0) {
      var_5 = self hasweapon(var_0);
      var_6 = var_5 && self getammocount(var_0) == 0;

      if(var_6) {
        if(isDefined(self.going_for_knife)) {
          wait 5.0;
          continue;
        }

        var_7 = getEntArray("_encstr_8BB40EE803A7CB21EAAFAF12050245D1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_8 = scripts\engine\utility::get_array_of_closest(self.origin, var_7);

        foreach(var_10 in var_8) {
          if(!isDefined(var_10)) {
            continue;
          }
          if(!isDefined(var_10.calculated_closest_point)) {
            var_11 = scripts\mp\bots\bots_util::bot_queued_process("_encstr_B8D91C321703FF17891F78A2525B18637DC74BF027E6D2C1F94B8FC170A3", scripts\mp\bots\bots_util::func_bot_get_closest_navigable_point, var_10.origin, 32, self);

            if(isDefined(var_10)) {
              var_10.closest_point_on_grid = var_11;
              var_10.calculated_closest_point = 1;
            } else
              continue;
          }

          if(isDefined(var_10.closest_point_on_grid)) {
            self.going_for_knife = 1;
            bot_seek_dropped_weapon(var_10);
          }
        }
      } else if(var_5)
        self.going_for_knife = undefined;
    }

    wait(randomfloatrange(0.25, 0.75));
  }
}

bot_seek_dropped_weapon(var_0) {
  if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("_encstr_B608149BDA686C4938BE7FEA3BC3F35FAFDAC6EF8D53", var_0) == 0) {
    var_1 = undefined;

    if(var_0.targetname == "_encstr_AD580F5F2388E9EB57322E3069A1074090") {
      var_2 = 1;
      var_3 = self getweaponslistprimaries();

      foreach(var_5 in var_3) {
        if(var_0.model == getweaponmodel(var_5))
          var_2 = 0;
      }

      if(var_2)
        var_1 = ::bot_pickup_weapon;
    }

    var_7 = spawnStruct();
    var_7.object = var_0;
    var_7.script_goal_radius = 12;
    var_7.should_abort = level.bot_funcs["_encstr_8E6C1675DAB2A1335DA3D1988F710B270A097E0F35AA43F8"];
    var_7.action_thread = var_1;
    scripts\mp\bots\bots_strategy::bot_new_tactical_goal("_encstr_B608149BDA686C4938BE7FEA3BC3F35FAFDAC6EF8D53", var_0.origin, 100, var_7);
  }
}

bot_pickup_weapon(var_0) {
  self botpressbutton("_encstr_AB19049D0FC0", 2);
  wait 2;
}

should_stop_seeking_weapon(var_0) {
  if(!isDefined(var_0.object))
    return 1;

  if(var_0.object.targetname == "_encstr_AD580F5F2388E9EB57322E3069A1074090") {
    if(scripts\mp\bots\bots_util::bot_get_total_gun_ammo() > 0)
      return 1;
  } else if(var_0.object.targetname == "_encstr_8BB40EE803A7CB21EAAFAF12050245D1") {
    if(scripts\mp\bots\bots_util::bot_in_combat()) {
      self.going_for_knife = undefined;
      return 1;
    }
  }

  return 0;
}

crate_in_range(var_0) {
  if(!isDefined(var_0.owner) || var_0.owner != self) {
    if(distancesquared(self.origin, var_0.origin) > 4194304)
      return 0;
  }

  return 1;
}

bot_crate_valid(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = self[[level.bot_funcs["_encstr_99EB0E12DB5279E596CEBBD2C11B30F8"]]](var_0);

  if(!var_1) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_9A7205B39CB919")
      var_1 = 1;
  }

  if(!var_1)
    return 0;

  if(!crate_landed_and_on_path_grid(var_0))
    return 0;

  if(level.teambased && isDefined(var_0.bomb) && isDefined(var_0.team) && var_0.team == self.team)
    return 0;

  if(!self[[level.bot_funcs["_encstr_B8430FFED25AA1E91F9F40D1EB79C0CFA2"]]](var_0))
    return 0;

  if(!isDefined(level.bot_can_use_box_by_type))
    return 0;

  if(isDefined(var_0.boxtype)) {
    if(isDefined(level.boxsettings) && isDefined(level.boxsettings[var_0.boxtype]) && ![[level.boxsettings[var_0.boxtype].canusecallback]]())
      return 0;

    if(isDefined(var_0.disabled_use_for) && isDefined(var_0.disabled_use_for[self getentitynumber()]) && var_0.disabled_use_for[self getentitynumber()])
      return 0;

    if(!self[[level.bot_can_use_box_by_type[var_0.boxtype]]](var_0))
      return 0;
  } else if(datakey(var_0))
    return 0;

  return isDefined(var_0);
}

datakey(var_0) {
  return 0;
}

crate_landed_and_on_path_grid(var_0) {
  if(!crate_has_landed(var_0))
    return 0;

  if(!crate_is_on_path_grid(var_0))
    return 0;

  return isDefined(var_0);
}

crate_has_landed(var_0) {
  if(isDefined(var_0.boxtype))
    return gettime() > var_0.birthtime + 1000;
  else
    return isDefined(var_0.droppingtoground) && !var_0.droppingtoground;
}

crate_is_on_path_grid(var_0) {
  if(!isDefined(var_0.on_path_grid))
    crate_calculate_on_path_grid(var_0);

  return isDefined(var_0) && var_0.on_path_grid;
}

node_within_use_radius_of_crate(var_0, var_1) {
  if(isDefined(var_1.boxtype) && var_1.boxtype == "_encstr_B87F0E40AE4F033DD8A2479AB8696E72")
    return abs(var_0.origin[0] - var_1.origin[0]) < 36 && abs(var_0.origin[0] - var_1.origin[0]) < 36 && abs(var_0.origin[0] - var_1.origin[0]) < 18;
  else {
    var_2 = getdvarfloat("_encstr_96AE0B45D5A027733C0C5D10F7");
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
    var_0 notify("_encstr_B8151050D76BF23E79B83FDFE728E37752F9");
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
    var_4 = getdvarfloat("_encstr_96AE0B45D5A027733C0C5D10F7");
    var_5 = getnodesinradiussorted(var_0.origin, var_4 * 2, 0)[0];
    var_6 = var_0 getpointinbounds(0, 0, -1);
    var_7 = undefined;

    if(isDefined(var_0.boxtype) && var_0.boxtype == "_encstr_B87F0E40AE4F033DD8A2479AB8696E72") {
      if(scripts\mp\bots\bots_util::bot_point_is_on_pathgrid(var_0.origin, var_4))
        var_7 = var_0.origin;
    } else
      var_7 = botgetclosestnavigablepoint(var_0.origin, var_4);

    if(isDefined(var_5) && !var_5 nodeisdisconnected() && isDefined(var_7) && abs(var_5.origin[2] - var_6[2]) < 30) {
      var_0.nearest_points = [var_7];
      var_0.nearest_nodes = [var_5];
      var_0.on_path_grid = 1;
    }
  }

  if(isDefined(var_0.forcedisconnectuntil)) {
    if(var_0.forcedisconnectuntil == var_2)
      var_0.forcedisconnectuntil = var_1;
  }
}

crate_get_nearest_valid_nodes(var_0) {
  var_1 = getnodesinradiussorted(var_0.origin, 256, 0);

  for(var_2 = var_1.size; var_2 > 0; var_2--)
    var_1[var_2] = var_1[var_2 - 1];

  var_1[0] = getclosestnodeinsight(var_0.origin);
  var_3 = undefined;

  if(isDefined(var_0.forcedisconnectuntil))
    var_3 = getsentientcounts();

  var_4 = [];
  var_5 = 1;

  if(!isDefined(var_0.boxtype))
    var_5 = 2;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_6 = var_1[var_2];

    if(!isDefined(var_6) || !isDefined(var_0)) {
      continue;
    }
    if(var_6 nodeisdisconnected()) {
      continue;
    }
    if(!node_within_use_radius_of_crate(var_6, var_0)) {
      if(var_2 == 0)
        continue;
      else
        break;
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
        var_4[var_4.size] = var_6;

        if(var_4.size == var_5)
          return var_4;
        else
          continue;
      }

      var_7 = undefined;
      var_8 = 0;

      while(!isDefined(var_7) && var_8 < 100) {
        var_8++;
        var_9 = randomint(var_3);
        var_10 = nvidiahighlightsrequestpermissions(var_9);

        if(isDefined(var_10) && distancesquared(var_6.origin, var_10.origin) > 250000)
          var_7 = var_10;
      }

      if(isDefined(var_7)) {
        var_11 = scripts\mp\bots\bots_util::bot_queued_process("_encstr_AA7C14547B84133F530F2B80C587F2D30A753A7A532B", scripts\mp\bots\bots_util::func_get_nodes_on_path, var_6.origin, var_7.origin);

        if(isDefined(var_11)) {
          var_4[var_4.size] = var_6;

          if(var_4.size == var_5)
            return var_4;
          else
            continue;
        }
      }
    }
  }

  return undefined;
}

crate_get_bot_target(var_0) {
  if(isDefined(var_0.nearest_points))
    return var_0.nearest_points[0];

  if(isDefined(var_0.nearest_nodes) && var_0.nearest_nodes.size > 0) {
    if(var_0.nearest_nodes.size > 1) {
      var_1 = scripts\engine\utility::array_reverse(self botnodescoremultiple(var_0.nearest_nodes, "_encstr_81D70DCDED23B2F556E183DB9BB28C"));
      return scripts\engine\utility::random_weight_sorted(var_1).origin;
    } else
      return var_0.nearest_nodes[0].origin;
  }
}

crate_get_bot_target_check_distance(var_0, var_1) {
  var_2 = crate_get_bot_target(var_0);
  var_2 = getclosestpointonnavmesh(var_2, self);
  var_3 = var_1 * 0.9;
  var_3 = var_3 * var_3;

  if(distancesquared(var_0.origin, var_2) <= var_3)
    return var_2;
  else
    return undefined;
}

bot_think_crate() {
  self notify("_encstr_A52C1011E02371044363383266F7EB6791A0");
  self endon("_encstr_A52C1011E02371044363383266F7EB6791A0");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getdvarfloat("_encstr_96AE0B45D5A027733C0C5D10F7");

  for(;;) {
    var_1 = randomfloatrange(2, 4);
    scripts\engine\utility::waittill_notify_or_timeout("_encstr_95FF1273ACBBD71B9CC24756D7D1B77D3A85B695", var_1);

    if(isDefined(self.boxes) && self.boxes.size == 0)
      self.boxes = undefined;

    var_2 = level.carepackages;

    if(!scripts\mp\bots\bots_util::bot_in_combat() && isDefined(self.boxes))
      var_2 = scripts\engine\utility::array_combine(var_2, self.boxes);

    if(isDefined(level.bot_scavenger_bags) && scripts\mp\utility\perk::_hasperk("_encstr_95571436E007F94BC6620878491A17F1339D30A44DF3"))
      var_2 = scripts\engine\utility::array_combine(var_2, level.bot_scavenger_bags);

    var_2 = scripts\engine\utility::array_removeundefined(var_2);

    if(var_2.size == 0) {
      continue;
    }
    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("_encstr_B4DA0E56BBF5526AF0A057BFA869240A") || self botgetscriptgoaltype() == "_encstr_99C209E34FC743616118AB" || scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
      continue;
    }
    var_3 = [];

    foreach(var_5 in var_2) {
      if(bot_crate_valid(var_5))
        var_3[var_3.size] = var_5;
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
    var_8 = self[[level.bot_funcs["_encstr_91C915D84EB08E2BEBD8DBBBAF2CB5B5ED7D8D1AAC6CD6"]]]();
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
            if(distancesquared(var_15.origin, var_5.origin) < 490000)
              var_13[var_13.size] = var_15;
          }
        }

        if(var_13.size > 0) {
          var_17 = var_13[0] getnearestnode();

          if(isDefined(var_17)) {
            var_12 = 0;

            foreach(var_19 in var_5.nearest_nodes)
            var_12 = var_12 | nodesvisible(var_17, var_19, 1);
          }
        }
      }

      if(!var_12) {
        var_21 = isDefined(var_5.bots) && isDefined(var_5.bots[self.team]) && var_5.bots[self.team] > 0;
        var_22 = 0;

        foreach(var_19 in var_5.nearest_nodes)
        var_22 = var_22 | nodesvisible(var_7, var_19, 1);

        if(var_22 || var_9 && !var_21) {
          var_10 = var_5;
          break;
        }
      }
    }

    if(isDefined(var_10)) {
      if(self[[level.bot_funcs["_encstr_B2A713E34651AB2FCFF0E2AAF891274F4921699151"]]]()) {
        if(!isDefined(var_10.boxtype)) {
          if(!isDefined(var_10.bots))
            var_10.bots = [];

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
          var_26.action_thread = undefined;
          var_27 = var_10.origin;
        } else {
          var_26.script_goal_radius = 50;
          var_26.action_thread = ::use_box;
          var_28 = crate_get_bot_target_check_distance(var_10, var_0);

          if(!isDefined(var_28)) {
            continue;
          }
          var_28 = var_28 - var_10.origin;
          var_29 = length(var_28) * randomfloat(1.0);
          var_27 = var_10.origin + vectorNormalize(var_28) * var_29 + (0, 0, 12);
        }
      } else {
        var_26.action_thread = ::use_crate;
        var_26.end_thread = ::stop_using_crate;
        var_27 = crate_get_bot_target_check_distance(var_10, var_0);

        if(!isDefined(var_27)) {
          continue;
        }
        var_26.script_goal_radius = var_0 - distance(var_10.origin, var_27 + (0, 0, 40));
        var_27 = var_27 + (0, 0, 24);
      }

      if(isDefined(var_26.script_goal_radius)) {}

      var_10 notify("_encstr_B8151050D76BF23E79B83FDFE728E37752F9");
      wait 0.05;

      if(!isDefined(var_10)) {
        continue;
      }
      scripts\mp\bots\bots_strategy::bot_new_tactical_goal("_encstr_B4DA0E56BBF5526AF0A057BFA869240A", var_27, 30, var_26);
    }
  }
}

bot_should_use_ballistic_vest_crate(var_0) {
  return 1;
}

crate_should_claim() {
  return 1;
}

crate_low_ammo_check() {
  return 0;
}

bot_should_use_ammo_crate(var_0) {
  if(createheadicon(self getcurrentweapon()) == level.boxsettings[var_0.boxtype].minigunweapon)
    return 0;

  return 1;
}

bot_pre_use_ammo_crate(var_0) {
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.secondaryweapon);
  wait 1.0;
}

bot_post_use_ammo_crate(var_0) {
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(isundefinedweapon());
  self.secondaryweapon = self getcurrentweapon();
}

bot_should_use_scavenger_bag(var_0) {
  if(scripts\mp\bots\bots_util::bot_get_low_on_ammo(0.66)) {
    var_1 = self getnearestnode();

    if(isDefined(var_0.nearest_nodes) && isDefined(var_0.nearest_nodes[0]) && isDefined(var_1)) {
      if(nodesvisible(var_1, var_0.nearest_nodes[0], 1)) {
        if(scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var_0.origin, self botgetfovdot()))
          return 1;
      }
    }
  }

  return 0;
}

bot_should_use_grenade_crate(var_0) {
  var_1 = self getweaponslistoffhands();

  foreach(var_3 in var_1) {
    if(self getweaponammostock(var_3) == 0)
      return 1;
  }

  return 0;
}

bot_should_use_juicebox_crate(var_0) {
  return 1;
}

crate_monitor_position() {
  self notify("_encstr_86D51729DA29E8FDA1EFBFB5D73B3093FFB250A3848448A0CA");
  self endon("_encstr_86D51729DA29E8FDA1EFBFB5D73B3093FFB250A3848448A0CA");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

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

crate_wait_use() {}

crate_picked_up(var_0) {
  if(!isDefined(var_0.object))
    return 1;

  return 0;
}

use_crate(var_0) {
  if(isagent(self)) {
    scripts\common\utility::allow_usability(1);
    var_0.object enableplayeruse(self);
    wait 0.05;
  }

  self[[level.bot_funcs["_encstr_9B600F8B0DE0F3675813129A9BB0FFEA68"]]]();

  if(isDefined(var_0.object.owner) && var_0.object.owner == self)
    var_1 = level.crateownerusetime / 1000 + 0.5;
  else
    var_1 = level.cratenonownerusetime / 1000 + 1.0;

  self botpressbutton("_encstr_AB19049D0FC0", var_1);

  while(var_1 > 0 && isDefined(var_0.object)) {
    wait 0.05;
    var_1 = var_1 - 0.05;
  }

  if(var_1 > 0)
    wait(randomfloatrange(0.05, 0.5));

  if(isagent(self)) {
    scripts\common\utility::allow_usability(0);

    if(isDefined(var_0.object))
      var_0.object disableplayeruse(self);
  }

  if(isDefined(var_0.object)) {
    if(!isDefined(var_0.object.bots_used))
      var_0.object.bots_used = [];

    var_0.object.bots_used[var_0.object.bots_used.size] = self;
  }
}

use_box(var_0) {
  if(isagent(self)) {
    scripts\common\utility::allow_usability(1);
    var_0.object enableplayeruse(self);
    wait 0.05;
  }

  if(isDefined(var_0.object) && isDefined(var_0.object.boxtype)) {
    var_1 = var_0.object.boxtype;

    if(isDefined(level.bot_pre_use_box_of_type[var_1]))
      self[[level.bot_pre_use_box_of_type[var_1]]](var_0.object);

    if(isDefined(var_0.object)) {
      var_2 = level.boxsettings[var_0.object.boxtype].usetime / 1000 + 0.5;
      self botpressbutton("_encstr_AB19049D0FC0", var_2);
      wait(var_2);

      if(isDefined(level.bot_post_use_box_of_type[var_1]))
        self[[level.bot_post_use_box_of_type[var_1]]](var_0.object);
    }
  }

  if(isagent(self)) {
    scripts\common\utility::allow_usability(0);

    if(isDefined(var_0.object))
      var_0.object disableplayeruse(self);
  }
}

watch_bot_died_during_crate(var_0) {
  thread bot_watch_for_death(var_0.object);
}

stop_using_crate(var_0) {
  if(isDefined(var_0.object))
    var_0.object.bots[self.team] = 0;
}

bot_watch_for_death(var_0) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_8E4208C9ACEC5A3BAC46");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self.team;
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(var_0))
    var_0.bots[var_1] = 0;
}

bot_think_crate_blocking_path() {
  self notify("_encstr_BD931E02BFC0B1BB5B589A3266266BF61803878A2170C69FF3900279AB0F0BEC");
  self endon("_encstr_BD931E02BFC0B1BB5B589A3266266BF61803878A2170C69FF3900279AB0F0BEC");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getdvarfloat("_encstr_96AE0B45D5A027733C0C5D10F7");

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
            self botpressbutton("_encstr_AB19049D0FC0", level.crateownerusetime / 1000 + 0.5);
            continue;
          }

          self botpressbutton("_encstr_AB19049D0FC0", level.cratenonownerusetime / 1000 + 0.5);
        }
      }
    }
  }
}

bot_think_revive() {
  self notify("_encstr_8A0911F94263AF08BCC94547D7E2585CFF2B91");
  self endon("_encstr_8A0911F94263AF08BCC94547D7E2585CFF2B91");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!level.teambased) {
    return;
  }
  if(!scripts\mp\utility\game::islaststandenabled() && !scripts\mp\utility\game::isteamreviveenabled()) {
    return;
  }
  for(;;) {
    var_0 = 2.0;
    var_1 = getEntArray("_encstr_81C90FCAF9E0392BF5FFEBFBFBAC626D68", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(var_1.size > 0)
      var_0 = 0.05;

    level scripts\engine\utility::waittill_notify_or_timeout("_encstr_ACBE12F049519F2F9591A24AC8A1E9FFABA7669C", var_0);

    if(!bot_can_revive()) {
      self.tutorial_lead_collected = 0;
      continue;
    }

    var_1 = getEntArray("_encstr_81C90FCAF9E0392BF5FFEBFBFBAC626D68", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = 1;
    var_3 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_AB580A05672AE35D5FFF50B8");

    if(var_3 < 4)
      var_2 = 0;

    if(var_1.size > var_2) {
      var_1 = sortbydistance(var_1, self.origin);

      if(isDefined(self.owner)) {
        for(var_4 = 0; var_4 < var_1.size; var_4++) {
          if(var_1[var_4].owner != self.owner) {
            continue;
          }
          if(var_4 == 0) {
            break;
          }

          var_5 = var_1[var_4];
          var_1[var_4] = var_1[0];
          var_1[0] = var_5;
          break;
        }
      }
    }

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      var_6 = var_1[var_4];
      var_7 = var_6.owner;

      if(!isDefined(var_7)) {
        continue;
      }
      if(var_7 == self) {
        continue;
      }
      if(scripts\mp\utility\game::islaststandenabled() && !scripts\mp\utility\player::isreallyalive(var_7)) {
        continue;
      }
      if(var_7.team != self.team) {
        continue;
      }
      if(scripts\mp\utility\game::islaststandenabled() && (!isDefined(var_7.inlaststand) || !var_7.inlaststand)) {
        continue;
      }
      if(isDefined(var_7.bots) && isDefined(var_7.bots[self.team]) && var_7.bots[self.team] > 0) {
        continue;
      }
      if(scripts\mp\utility\game::islaststandenabled())
        var_8 = var_7.origin;
      else
        var_8 = var_6.origin;

      if(distancesquared(self.origin, var_8) < 4194304) {
        var_9 = spawnStruct();
        var_9.object = var_6;
        var_9.script_goal_radius = 64;

        if(isDefined(self.last_revive_fail_time) && gettime() - self.last_revive_fail_time < 1000)
          var_9.script_goal_radius = 32;

        var_9.start_thread = ::watch_bot_died_during_revive;
        var_9.end_thread = ::stop_reviving;
        var_9.should_abort = ::player_revived_or_dead;
        var_9.action_thread = ::revive_player;
        var_10 = 60;

        if(scripts\mp\utility\teams::getteamdata(self.team, "_encstr_8A2A0B936CCCC3078547970A8B") == 1)
          var_10 = 100;

        scripts\mp\bots\bots_strategy::bot_new_tactical_goal("_encstr_9695073995D94BD959", var_8, var_10, var_9);
        self.tutorial_lead_collected = 1;
        var_7.bots[self.team] = 1;
        break;
      }
    }
  }
}

watch_bot_died_during_revive(var_0) {
  if(scripts\mp\utility\game::islaststandenabled())
    thread bot_watch_for_death(var_0.object.owner);
}

stop_reviving(var_0) {
  if(isDefined(var_0.object.owner))
    var_0.object.owner.bots[self.team] = 0;
}

player_revived_or_dead(var_0) {
  if(scripts\mp\utility\game::islaststandenabled()) {
    if(!isDefined(var_0.object.owner) || var_0.object.owner.health <= 0)
      return 1;

    if(!isDefined(var_0.object.owner.inlaststand) || !var_0.object.owner.inlaststand)
      return 1;
  } else if(!isDefined(var_0.object.owner) || var_0.object.owner.health > 0)
    return 1;

  return 0;
}

revive_player(var_0) {
  if(isDefined(var_0.object.owner))
    var_0.object.owner.bots[self.team] = 1;

  if(scripts\mp\utility\game::islaststandenabled())
    var_1 = var_0.object.owner.origin;
  else
    var_1 = var_0.object.origin;

  if(distancesquared(self.origin, var_1) > 4096) {
    self.last_revive_fail_time = gettime();
    return;
  }

  if(isagent(self)) {
    scripts\common\utility::allow_usability(1);
    var_0.object enableplayeruse(self);
    wait 0.05;
  }

  var_2 = self.team;
  self botpressbutton("_encstr_AB19049D0FC0", level.laststandrevivetimer + 0.5);
  wait(level.laststandrevivetimer + 1.5);

  if(isDefined(var_0.object.owner))
    var_0.object.owner.bots[var_2] = 0;

  if(isagent(self)) {
    scripts\common\utility::allow_usability(0);

    if(isDefined(var_0.object))
      var_0.object disableplayeruse(self);
  }
}

bot_can_revive() {
  if(isDefined(self.laststand) && self.laststand == 1)
    return 0;

  if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("_encstr_9695073995D94BD959"))
    return 0;

  if(scripts\mp\bots\bots_util::bot_is_remote_or_linked())
    return 0;

  if(scripts\mp\bots\bots_util::bot_is_bodyguarding())
    return 1;

  if(isDefined(level.bot_funcs["_encstr_BA301954E3383B8F9E19FAB103E5BB34C843C7C755E0423BB39162"])) {
    var_0 = self[[level.bot_funcs["_encstr_BA301954E3383B8F9E19FAB103E5BB34C843C7C755E0423BB39162"]]]();

    if(var_0) {
      self.tutorial_lead_collected = 0;
      return 1;
    }
  }

  var_1 = self botgetscriptgoaltype();

  if(var_1 == "_encstr_8BBA05185F8B99" || var_1 == "_encstr_9ACC05B4156DF3" || var_1 == "_encstr_AF2206AF7DE90BA7")
    return 1;

  return 0;
}

revive_watch_for_finished(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_86E5092BA829F7AB738DA4");
  self endon("_encstr_8B7205D9ED5958");
  var_0 scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8E4208C9ACEC5A3BAC46");
  self notify("_encstr_86E5092BA829F7AB738DA4");
}

bot_know_enemies_on_start() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(gettime() > 15000) {
    return;
  }
  while(!scripts\mp\utility\game::gamehasstarted() || !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    wait 0.05;

  var_0 = undefined;
  var_1 = undefined;

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];

    if(isDefined(var_3) && isDefined(self.team) && isDefined(var_3.team) && !istestclient(self, var_3)) {
      if(!isDefined(var_3.bot_start_known_by_enemy))
        var_0 = var_3;

      if(isai(var_3) && !isDefined(var_3.bot_start_know_enemy))
        var_1 = var_3;
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

bot_think_gametype() {
  self notify("_encstr_88F41326BDA3BEE8A1B4B9B6D73B2C5BB21D5E83CA");
  self endon("_encstr_88F41326BDA3BEE8A1B4B9B6D73B2C5BB21D5E83CA");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0;

  if(level.gametype == "_encstr_B607038AAB")
    var_0 = 1;

  if(!var_0)
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  self thread[[level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"]]]();
}

default_gametype_think() {}

monitor_smoke_grenades() {
  level.bot_smoke_sight_clip_large = getEnt("_encstr_B1601D97C782C250DF5FC33905C9900D39173B37AB5B805834348B763AE55A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(level.bot_smoke_sight_clip_large)) {
    return;
  }
  for(;;) {
    level waittill("_encstr_BE7206A2D07B1322", var_0, var_1);

    if(var_1.basename == "_encstr_8823119675DAFF897F878020BB99612B219D8F")
      var_0 thread handle_smoke();
  }
}

handle_smoke() {
  self endon("_encstr_B8A00B1B161D59D723AC58A334");
  thread smoke_grenade_late_death();
  self waittill("_encstr_860808CB78E2984063BA", var_0);
  thread init_leave_cave(var_0);
}

init_leave_cave(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_1 show();
  wait 1;
  var_1 clonebrushmodeltoscriptmodel(level.bot_smoke_sight_clip_large);
  var_1 setmovertransparentvolume();
  wait 8.75;
  var_1 delete();
}

smoke_grenade_late_death() {
  self endon("_encstr_860808CB78E2984063BA");
  self waittill("_encstr_AD75063D571AE108");
  waittillframeend;
  self notify("_encstr_B8A00B1B161D59D723AC58A334");
}

bot_add_scavenger_bag(var_0) {
  var_1 = 0;
  var_0.boxtype = "_encstr_B87F0E40AE4F033DD8A2479AB8696E72";
  var_0.boxtouchonly = 1;

  if(!isDefined(level.bot_scavenger_bags))
    level.bot_scavenger_bags = [];

  foreach(var_4, var_3 in level.bot_scavenger_bags) {
    if(!isDefined(var_3)) {
      var_1 = 1;
      level.bot_scavenger_bags[var_4] = var_0;
      break;
    }
  }

  if(!var_1)
    level.bot_scavenger_bags[level.bot_scavenger_bags.size] = var_0;

  foreach(var_6 in level.participants) {
    if(isai(var_6) && var_6 scripts\mp\utility\perk::_hasperk("_encstr_95571436E007F94BC6620878491A17F1339D30A44DF3"))
      var_6 notify("_encstr_95FF1273ACBBD71B9CC24756D7D1B77D3A85B695");
  }
}

bot_triggers() {
  var_0 = getEntArray("_encstr_8BC40D02BFC0B1F359590A71E32573", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_noteworthy)) {
      continue;
    }
    var_2 thread bot_flag_trigger(var_2.script_noteworthy);
  }
}

bot_flag_trigger(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(scripts\mp\utility\entity::isaigameparticipant(var_1)) {
      var_1 notify("_encstr_97BB1233C60BD97D1DC95AEC3B5639D737951DEB" + var_0);
      var_1 botsetflag(var_0, 1);
      var_1 thread bot_flag_trigger_clear(var_0);
    }
  }
}

bot_flag_trigger_clear(var_0) {
  self endon("_encstr_97BB1233C60BD97D1DC95AEC3B5639D737951DEB" + var_0);
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  waitframe();
  waittillframeend;
  self botsetflag(var_0, 0);
}

load_gametype_scripts_for_scriptdev() {}