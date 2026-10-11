/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_45f403e1732217d3.gsc
*************************************************/

#using script_2892a7e13357d95b;
#using script_3aacf02225ca0da5;
#using script_3e784a4247cea64b;
#using script_3f8889c16399185c;
#using script_4a6760982b403bad;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\weapon;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\equipment;
#using scripts\mp\hud_util;
#using scripts\mp\persistence;
#using scripts\mp\playerstats_interface;
#using scripts\mp\rank;
#using scripts\mp\supers;
#using scripts\mp\teams;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weaponrank;
#using scripts\mp\weapons;
#namespace namespace_3a38da80071a2614;

function init() {
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_match_start", &function_393baf20db478c0d);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_match_end", &function_f5f91665fe4dba94);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_round_start", &on_round_start);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_round_end", &on_round_end);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_server_exit_level", &function_69ddf7a3e512a18a);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_server_post_exit_level", &function_9b064138ff8c311b);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_on_player_first_connect", &on_player_connect);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_on_player_spawned", &on_player_spawned);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_player_death", &on_player_death);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_on_player_disconnect", &on_player_disconnect);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_player_new_loadout_used", &function_60912f12edbae676);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_update_weapon_stats", &update_weapon_stats);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_player_score_event", &function_ac6b649326f4b17e);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_on_game_event", &on_game_event);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_on_player_armor_auto_apply", &on_player_armor_auto_apply);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_on_reload_cancel", &on_reload_cancel);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_operator_vo", &function_83e5e7d28c56eef1);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_dmz_on_exfil", &dmz_on_exfil);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_dmz_on_reinforce", &dmz_on_reinforce);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_dmz_on_lpcon_alert", &function_532119a556885727);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_dmz_on_container", &dmz_on_container);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_dmz_contract", &dmz_contract);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_the_hunt_eom", &function_42db4e92349e1fee);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_countdown_eom", &function_ecf05f99fb2be7a2);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_altered_strain_eom", &function_35a349228b74abc3);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_countdown_eom_match", &function_cf6a68bcdfd1f403);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_altered_strain_eom_match", &function_c97fa4f697e7e8b4);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_trt_eom_player", &function_938463ee126f54fb);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_trt_eom_match", &function_107edbf02a7ccd23);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_example", &function_234528691f62628b);
  level callback::add("on_ai_killed", &on_ai_killed);

  if(!isDefined(level.mp_ai_killed_telemetry_throttle)) {
    level.mp_ai_killed_telemetry_throttle = throttle_initialize("mp_ai_killed_telemetry_throttle", 1, level.framedurationseconds);
  }

  setdvarifuninitialized(@ "hash_817f686503ccdecf", 5);
}

function function_393baf20db478c0d() {
  utc_start_time_s = getsystemtime();
  setmatchdata("commonMatchData", "utc_start_time_s", utc_start_time_s);
  setmatchdata("commonMatchData", "player_count_start", level.players.size);

  if(isDefined(game["telemetry"])) {
    game["telemetry"].utc_start_time_s = utc_start_time_s;
  }

  game_type = getgametype();

  if(scripts\cp_mp\utility\game_utility::function_21322da268e71c19()) {
    game_type += " hc";
  }

  sub_game_type = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();
  playlist_id = 0;
  playlist_name = "";

  if(matchmakinggame()) {
    playlist_id = getplaylistid();
    playlist_name = getplaylistname();
  }

  is_ranked = 0;

  if(istrue(level.leagueplaymatch) || istrue(level.var_77907d733abe8b63)) {
    is_ranked = 1;
  }

  max_players_allowed = getdvarint(@ "party_maxplayers", -1);
  frame_duration = getframeduration();
  dlog_recordevent("dlog_event_mp_server_match_start", ["utc_start_time_s", utc_start_time_s, "map", level.script, "game_type", game_type, "is_playtest", getdvarint(@ "hash_2e58447fa1ca4f20") && getdvarint(@ "hash_51f11c2e135abc7"), "experiment_name", getDvar(@ "experiment_name"), "dedi_server_guid", getdediserverguid(), "sub_game_type", sub_game_type, "playlist_id", playlist_id, "playlist_name", playlist_name, "is_offline", !level.onlinegame, "max_players_allowed", max_players_allowed, "frame_duration", frame_duration, "is_ranked", is_ranked]);
  var_37aab353fe84a505 = "{\"game_type\":\"" + game_type + "\",\"sub_game_type\":\"" + sub_game_type + "\",\"map\":\"" + level.script + "\"}";
  recordeventforsreparser("server_match_start", var_37aab353fe84a505);

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    utility::trycall(level.matchdata_br_onmatchstart);
  }

  onmatchbegin();
}

function function_f5f91665fe4dba94(data) {
  utc_start_time_s = 0;
  total_player_connections = 0;
  life_count = 0;
  game_type = getgametype();
  game_event_count = 0;

  if(isDefined(game["telemetry"].utc_start_time_s)) {
    utc_start_time_s = game["telemetry"].utc_start_time_s;
  }

  if(isDefined(game["telemetry"].total_player_connections)) {
    total_player_connections = game["telemetry"].total_player_connections;
  }

  if(isDefined(game["telemetry"].life_count)) {
    life_count = game["telemetry"].life_count;
  }

  if(isDefined(game["telemetry"].game_event_count)) {
    game_event_count = game["telemetry"].game_event_count;
  }

  if(scripts\cp_mp\utility\game_utility::function_21322da268e71c19()) {
    game_type += " hc";
  }

  playlist_id = 0;
  playlist_name = "";

  if(matchmakinggame()) {
    playlist_id = getplaylistid();
    playlist_name = getplaylistname();
  }

  allies_score = 0;
  axis_score = 0;
  team_three_score = 0;

  if(level.teambased) {
    allies_score = getteamscore("allies");
    axis_score = getteamscore("axis");

    if(isgameplayteam("team_three")) {
      team_three_score = getteamscore("team_three");
    }
  }

  max_players_allowed = getdvarint(@ "party_maxplayers", -1);
  is_ranked = 0;

  if(istrue(level.leagueplaymatch) || istrue(level.var_77907d733abe8b63)) {
    is_ranked = 1;
  }

  var_d4687bb3ed2b03b3 = function_6b9f8406e6153597();
  dlog_recordevent("dlog_event_mp_server_match_end", ["utc_start_time_s", utc_start_time_s, "utc_end_time_s", getsystemtime(), "total_player_connections", total_player_connections, "life_count", life_count, "playlist_id", playlist_id, "playlist_name", playlist_name, "game_type", game_type, "map", level.script, "is_offline", !level.onlinegame, "allies_score", allies_score, "axis_score", axis_score, "team_three_score", team_three_score, "game_event_count", game_event_count, "weapon_map_watermark", function_949690bfcbcdc8cf(), "max_players_allowed", max_players_allowed, "is_ranked", is_ranked, "is_archive_replay_recorded", var_d4687bb3ed2b03b3]);
}

function on_round_start(data) {
  if(isDefined(game["telemetry"])) {
    game["telemetry"].round_start_time_ms = namespace_de6e6777b0937bd7::function_1b15450e092933cf(gettime());
  }
}

function on_round_end(data) {
  round_start_time_ms = 0;

  if(isDefined(game["telemetry"].round_start_time_ms)) {
    round_start_time_ms = game["telemetry"].round_start_time_ms;
  }

  allies_score = 0;
  axis_score = 0;

  if(level.teambased) {
    allies_score = getteamscore("allies");
    axis_score = getteamscore("axis");
  }

  round_end_time_ms = namespace_de6e6777b0937bd7::function_1b15450e092933cf(gettime());
  dlog_recordevent("dlog_event_mp_server_round_end", ["round_start_time_ms", round_start_time_ms, "round_end_time_ms", round_end_time_ms, "allies_score", allies_score, "axis_score", axis_score]);
}

function on_player_connect(player) {
  if(!namespace_de6e6777b0937bd7::is_valid_client(player)) {
    return;
  }

  if(!isDefined(player.pers["telemetry"]) || !isDefined(player.pers["telemetry"].connected)) {
    if(!isDefined(player.pers["telemetry"])) {
      player.pers["telemetry"] = spawnStruct();
    }

    if(isDefined(game["telemetry"]) && isDefined(game["telemetry"].total_player_connections)) {
      player.pers["telemetry"].connect_index = game["telemetry"].total_player_connections;
      game["telemetry"].total_player_connections++;
    } else {
      println("<dev string:x1c>");
      return;
    }

    player.pers["telemetry"].utc_connect_time_s = getsystemtime();
    player.pers["telemetry"].connected = 1;
    player.pers["telemetry"].shots = 0;
    player.pers["telemetry"].hits = 0;

    if(player rankingenabled() && player hasplayerdata()) {
      xp_at_start = player getplayerdata("common", "mpProgression", "playerLevel", "xp");
      player.pers["telemetry"].xp_at_start = xp_at_start;
      player.pers["telemetry"].rank_at_start = player getrankforxp(xp_at_start);
      player.pers["telemetry"].score_at_start = player getplayerdata(level.progressiongroup, "playerStats", "matchStats", "score");
      player.pers["telemetry"].prestige_at_start = player getplayerdata(level.loadoutsgroup, "squadMembers", "season_rank");
    } else {
      player.pers["telemetry"].xp_at_start = 0;
      player.pers["telemetry"].rank_at_start = 0;
      player.pers["telemetry"].score_at_start = 0;
      player.pers["telemetry"].prestige_at_start = 0;
    }

    is_party_host = 0;

    if(level.onlinegame) {
      is_party_host = player isfireteamleader();
    }

    operator_allies = "";
    operator_axis = "";
    operator_allies_skin = -1;
    operator_axis_skin = -1;
    operator_allies_execution_ref = "none";
    operator_axis_execution_ref = "none";
    game_type = getgametype();

    if(scripts\cp_mp\utility\game_utility::function_21322da268e71c19()) {
      game_type += " hc";
    }

    sub_game_type = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();
    playlist_id = 0;
    playlist_name = "";

    if(matchmakinggame()) {
      playlist_id = getplaylistid();
      playlist_name = getplaylistname();
    }

    connect_index = 0;

    if(isDefined(player.pers["telemetry"].connect_index)) {
      connect_index = player.pers["telemetry"].connect_index;
    }

    lobby_id = function_4f9373a1227db35c();

    if(!isDefined(lobby_id)) {
      lobby_id = "";
    }

    current_team = "unset";

    if(isDefined(player.sessionteam)) {
      current_team = player.sessionteam;
    }

    if(isDefined(player.team)) {
      current_team = player.team;
    }

    is_ranked = 0;
    ranked_skill_rating = 0;

    if(istrue(level.leagueplaymatch)) {
      is_ranked = 1;
      xuid = player getxuid();
      ranked_skill_rating = function_904672268eb8e3fe(xuid);
    } else if(istrue(level.var_77907d733abe8b63)) {
      is_ranked = 1;
    }

    is_controller = player usinggamepad();
    player dlog_recordplayerevent("dlog_event_mp_player_match_start", ["utc_connect_time_s", player.pers["telemetry"].utc_connect_time_s, "team", current_team, "join_type", player getjointype(), "skill", player getskill(), "party_id", player getpartyid(), "is_party_host", is_party_host, "was_keyboardmouse", player function_989faa3e2f2d8c47() != 1, "operator_allies", operator_allies, "operator_axis", operator_axis, "operator_allies_skin", operator_allies_skin, "operator_axis_skin", operator_axis_skin, "operator_allies_execution_ref", operator_allies_execution_ref, "operator_axis_execution_ref", operator_axis_execution_ref, "map", level.script, "playlist_id", playlist_id, "playlist_name", playlist_name, "game_type", game_type, "sub_game_type", sub_game_type, "connect_index", connect_index, "lobby_id", lobby_id, "is_ranked", is_ranked, "ranked_skill_rating", ranked_skill_rating, "map_voting_options", player function_d5eb9e0d720451d2(), "map_voted_for", player function_2e4d79c3a2ff19f1(), "mode_voting_options", player function_c0efdb4dd083127f(), "mode_voted_for", player function_fd9ddaae72038754(), "is_controller", is_controller]);
    recordeventforsreparser("player_match_start", "");

    if(!isDefined(player.pers["telemetry"].player_score_event_count)) {
      player.pers["telemetry"].player_score_event_count = 0;
    }

    if(!isDefined(player.pers["telemetry"].player_weapon_stats_count)) {
      player.pers["telemetry"].player_weapon_stats_count = 0;
    }

    if(!isDefined(player.pers["telemetry"].kill_streak_expired_count)) {
      player.pers["telemetry"].kill_streak_expired_count = 0;
    }

    if(!isDefined(player.pers["telemetry"].player_loadout_count)) {
      player.pers["telemetry"].player_loadout_count = 0;
    }

    if(!isDefined(player.pers["telemetry"].ai_agent_kills)) {
      player.pers["telemetry"].ai_agent_kills = 0;
    }

    if(!isDefined(player.pers["telemetry"].armor_collected)) {
      player.pers["telemetry"].armor_collected = 0;
    }

    if(!isDefined(player.pers["telemetry"].armor_equipped)) {
      player.pers["telemetry"].armor_equipped = 0;
    }

    if(!isDefined(player.pers["telemetry"].armor_destroyed)) {
      player.pers["telemetry"].armor_destroyed = 0;
    }

    if(!isDefined(player.pers["telemetry"].vehicle_autofwd_count)) {
      player.pers["telemetry"].vehicle_autofwd_count = 0;
    }

    if(!isDefined(player.pers["telemetry"].ground_vehicle_used_count)) {
      player.pers["telemetry"].ground_vehicle_used_count = 0;
    }

    if(!isDefined(player.pers["telemetry"].air_vehicle_used_count)) {
      player.pers["telemetry"].air_vehicle_used_count = 0;
    }

    if(!isDefined(player.pers["telemetry"].var_a3ef8d971ec61fc7)) {
      player.pers["telemetry"].var_a3ef8d971ec61fc7 = 0;
    }
  }
}

function on_player_spawned(player) {
  if(!namespace_de6e6777b0937bd7::is_valid_client(player)) {
    return;
  }

  if(!isDefined(player scripts\mp\utility\stats::getpersstat("telemetry"))) {
    player.pers["telemetry"] = spawnStruct();
  }

  if(!isDefined(player scripts\mp\utility\stats::getpersstat("telemetry").life)) {
    player.pers["telemetry"].life = spawnStruct();
  }

  if(isDefined(game["telemetry"]) && isDefined(game["telemetry"].life_count)) {
    player.pers["telemetry"].life.life_index = game["telemetry"].life_count;
    game["telemetry"].life_count++;
  }

  if(isDefined(player scripts\mp\utility\stats::getpersstat("summary")["xp"])) {
    player.pers["telemetry"].life.var_2148fb703835ec1f = player scripts\mp\utility\stats::getpersstat("summary")["xp"];
  } else {
    player.pers["telemetry"].life.var_2148fb703835ec1f = 0;
  }

  if(isDefined(player.score)) {
    player.pers["telemetry"].life.var_7e5250b5700df037 = player.score;
    return;
  }

  player.pers["telemetry"].life.var_7e5250b5700df037 = 0;
}

function function_69ddf7a3e512a18a() {
  foreach(player in level.players) {
    data = spawnStruct();
    data.player = player;
    function_6447f24addc0137e(data);
  }
}

function function_6447f24addc0137e(data) {
  player = data.player;

  if(!isDefined(player.pers["telemetry"].var_d6caa636bc3fce32)) {
    if(!namespace_de6e6777b0937bd7::is_valid_client(player)) {
      return;
    }

    if(istrue(player.var_6a91d0e80cc504e) && !istrue(level.gameended)) {
      return;
    }

    utc_connect_time = 0;

    if(isDefined(player.pers["telemetry"].utc_connect_time_s)) {
      utc_connect_time = player.pers["telemetry"].utc_connect_time_s;
    }

    disconnect_reason = #"";

    if(isDefined(data.disconnectreason)) {
      disconnect_reason = data.disconnectreason;
    }

    team_xp_modifier = 0;

    if(level.teambased) {
      team_xp_modifier = int(player scripts\mp\rank::getteamrankxpmultiplier(player.team));
    }

    connect_index = 0;

    if(isDefined(player.pers["telemetry"].connect_index)) {
      connect_index = player.pers["telemetry"].connect_index;
    }

    total_xp = 0;
    score_xp = 0;
    challenge_xp = 0;
    match_xp = 0;
    medal_xp = 0;
    bonus_xp = 0;
    misc_xp = 0;
    accolade_xp = 0;
    weapon_xp = 0;
    operator_xp = 0;
    clan_xp = 0;
    battlepass_xp = 0;

    if(player onlinestatsenabled()) {
      if(isDefined(player.pers["summary"]["xp"])) {
        total_xp = player.pers["summary"]["xp"];
      }

      if(isDefined(player.pers["summary"]["score"])) {
        score_xp = player.pers["summary"]["score"];
      }

      if(isDefined(player.pers["summary"]["challenge"])) {
        challenge_xp = player.pers["summary"]["challenge"];
      }

      if(isDefined(player.pers["summary"]["match"])) {
        match_xp = player.pers["summary"]["match"];
      }

      if(isDefined(player.pers["summary"]["medal"])) {
        medal_xp = player.pers["summary"]["medal"];
      }

      if(isDefined(player.pers["summary"]["bonusXP"])) {
        bonus_xp = player.pers["summary"]["bonusXP"];
      }

      if(isDefined(player.pers["summary"]["misc"])) {
        misc_xp = player.pers["summary"]["misc"];
      }

      if(isDefined(player.pers["summary"]["accolade"])) {
        accolade_xp = player.pers["summary"]["accolade"];
      }

      if(isDefined(player.pers["summary"]["weaponXP"])) {
        weapon_xp = player.pers["summary"]["weaponXP"];
      }

      if(isDefined(player.pers["summary"]["operatorXP"])) {
        operator_xp = player.pers["summary"]["operatorXP"];
      }

      if(isDefined(player.pers["summary"]["clanXP"])) {
        clan_xp = player.pers["summary"]["clanXP"];
      }

      if(isDefined(player.pers["summary"]["battlepassXP"])) {
        battlepass_xp = int(player.pers["summary"]["battlepassXP"]);
      }
    }

    lifetimedata = spawnStruct();
    lifetimedata.rank_at_start = 0;

    if(isDefined(player.pers["telemetry"].rank_at_start)) {
      lifetimedata.rank_at_start = player.pers["telemetry"].rank_at_start;
    }

    lifetimedata.xp_at_start = 0;

    if(isDefined(player.pers["telemetry"].xp_at_start)) {
      lifetimedata.xp_at_start = player.pers["telemetry"].xp_at_start;
    }

    lifetimedata.score_at_start = 0;

    if(isDefined(player.pers["telemetry"].score_at_start)) {
      lifetimedata.score_at_start = player.pers["telemetry"].score_at_start;
    }

    lifetimedata.prestige_at_start = 0;

    if(isDefined(player.pers["telemetry"].prestige_at_start)) {
      lifetimedata.prestige_at_start = player.pers["telemetry"].prestige_at_start;
    }

    if(player rankingenabled() && player hasplayerdata()) {
      lifetimedata.xp_at_end = player getplayerdata("common", "mpProgression", "playerLevel", "xp");
      lifetimedata.rank_at_end = player getrankforxp(lifetimedata.xp_at_end);
      lifetimedata.score_at_end = player getplayerdata(level.progressiongroup, "playerStats", "matchStats", "score");
      lifetimedata.prestige_at_end = player getplayerdata(level.loadoutsgroup, "squadMembers", "season_rank");
      lifetimedata.lifetime_kills = player getplayerdata(level.progressiongroup, "playerStats", "combatStats", "kills");
      lifetimedata.lifetime_deaths = player getplayerdata(level.progressiongroup, "playerStats", "combatStats", "deaths");
      lifetimedata.lifetime_wins = player getplayerdata(level.progressiongroup, "playerStats", "matchStats", "wins");
      lifetimedata.lifetime_losses = player getplayerdata(level.progressiongroup, "playerStats", "matchStats", "losses");
      lifetimedata.lifetime_hits = player getplayerdata(level.progressiongroup, "playerStats", "combatStats", "hits");
      lifetimedata.lifetime_misses = player getplayerdata(level.progressiongroup, "playerStats", "combatStats", "misses");
      lifetimedata.lifetime_wall_bangs = player getplayerdata(level.progressiongroup, "playerStats", "combatStats", "wallbangs");
      lifetimedata.lifetime_near_misses = player getplayerdata(level.progressiongroup, "playerStats", "combatStats", "nearMisses");
      lifetimedata.lifetime_games_played = player getplayerdata(level.progressiongroup, "playerStats", "matchStats", "gamesPlayed");
      lifetimedata.lifetime_time_played_total = player getplayerdata(level.progressiongroup, "playerStats", "matchStats", "timePlayedTotal");
    } else {
      lifetimedata.xp_at_end = 0;
      lifetimedata.rank_at_end = 0;
      lifetimedata.score_at_end = 0;
      lifetimedata.prestige_at_end = 0;
      lifetimedata.lifetime_kills = 0;
      lifetimedata.lifetime_deaths = 0;
      lifetimedata.lifetime_wins = 0;
      lifetimedata.lifetime_losses = 0;
      lifetimedata.lifetime_hits = 0;
      lifetimedata.lifetime_misses = 0;
      lifetimedata.lifetime_wall_bangs = 0;
      lifetimedata.lifetime_near_misses = 0;
      lifetimedata.lifetime_games_played = 0;
      lifetimedata.lifetime_time_played_total = 0;
    }

    player_quit_round_number = -1;
    player_quit_team_score = 0;
    player_quit_opposing_team_score = 0;

    if(isDefined(data.disconnectreason)) {
      if(isroundbased()) {
        player_quit_round_number = game["roundsPlayed"];
      }

      if(level.teambased) {
        if(isDefined(player.team)) {
          if(player.team == "allies") {
            player_quit_team_score = getteamscore("allies");
            player_quit_opposing_team_score = getteamscore("axis");
          } else if(player.team == "axis") {
            player_quit_team_score = getteamscore("axis");
            player_quit_opposing_team_score = getteamscore("allies");
          }
        }
      }
    }

    percent_time_moving = 0;
    average_speed_during_match = 0;

    if(isDefined(player.pers["movementUpdateCount"]) && player.pers["movementUpdateCount"] >= 30) {
      percent_time_moving = player.pers["movingTotal"] / player.pers["movementUpdateCount"] / 5 * 100;
      average_speed_during_match = player.pers["distanceTotal"] / player.pers["movementUpdateCount"];
    }

    damage_done = player getpersstat("damage");

    if(!isDefined(damage_done)) {
      damage_done = 0;
    }

    damage_taken = player getpersstat("damageTaken");

    if(!isDefined(damage_taken)) {
      damage_taken = 0;
    }

    distance_traveled = 0;

    if(isDefined(player.pers["totalDistTraveled"])) {
      distance_traveled = float(player.pers["totalDistTraveled"]);
    }

    weapon_accuracy = 0;
    totalshots = player scripts\mp\playerstats_interface::getplayerstat("combatStats", "totalShots");
    totalhits = player scripts\mp\playerstats_interface::getplayerstat("combatStats", "hits");

    if(isDefined(totalshots) && isDefined(totalhits) && totalshots > 0) {
      weapon_accuracy = float(totalhits / totalshots * 100);
    }

    suicides = 0;

    if(isDefined(player.pers["suicides"])) {
      suicides = player getpersstat("suicides");
    }

    gw_spawn_method_press_rclick = 0;
    gw_spawn_method_press_lclick = 0;
    gw_spawn_method_press_activate = 0;
    gw_spawn_method_press_gostand = 0;

    if((getgametype() == "arm" || getgametype() == "conflict") && isDefined(player.gwinputtypesused)) {
      gw_spawn_method_press_rclick = istrue(player.gwinputtypesused["rightmouseup"]);
      gw_spawn_method_press_lclick = istrue(player.gwinputtypesused["leftmouseup"]);
      gw_spawn_method_press_activate = istrue(player.gwinputtypesused["activate"]);
      gw_spawn_method_press_gostand = istrue(player.gwinputtypesused["gostand"]);
    }

    game_type = getgametype();

    if(scripts\cp_mp\utility\game_utility::function_21322da268e71c19()) {
      game_type += " hc";
    }

    playlist_id = 0;
    playlist_name = "";

    if(matchmakinggame()) {
      playlist_id = getplaylistid();
      playlist_name = getplaylistname();
    }

    match_outcome = "loss";

    if(isDefined(player.pers["match_outcome"])) {
      match_outcome = player.pers["match_outcome"];
    }

    shots = 0;

    if(isDefined(player.pers["telemetry"].shots)) {
      shots = player.pers["telemetry"].shots;
    }

    hits = 0;

    if(isDefined(player.pers["telemetry"].hits)) {
      hits = player.pers["telemetry"].hits;
    }

    countstruct = spawnStruct();
    countstruct.player_score_event_count = 0;

    if(isDefined(player.pers["telemetry"].player_score_event_count)) {
      countstruct.player_score_event_count = player.pers["telemetry"].player_score_event_count;
    }

    player scripts\mp\weapons::function_c49a0d832ace8e5e();
    player scripts\mp\persistence::updateweaponbufferedstats();
    function_8076b5556f48a6cd(player);
    countstruct.player_weapon_stats_count = 0;

    if(isDefined(player.pers["telemetry"].player_weapon_stats_count)) {
      countstruct.player_weapon_stats_count = player.pers["telemetry"].player_weapon_stats_count;
    }

    countstruct.kill_streak_expired_count = 0;

    if(isDefined(player.pers["telemetry"].kill_streak_expired_count)) {
      countstruct.kill_streak_expired_count = player.pers["telemetry"].kill_streak_expired_count;
    }

    countstruct.player_loadout_count = 0;

    if(isDefined(player.pers["telemetry"].player_loadout_count)) {
      countstruct.player_loadout_count = player.pers["telemetry"].player_loadout_count;
    }

    countstruct.ai_agent_kills = 0;

    if(isDefined(player.pers["telemetry"].ai_agent_kills)) {
      countstruct.ai_agent_kills = player.pers["telemetry"].ai_agent_kills;
    }

    operatorstruct = spawnStruct();
    operatorstruct.operator = "";
    operatorstruct.operator_skin = "";
    operatorstruct.operator_execution_ref = "none";

    if(isDefined(player) && !isbot(player) && isDefined(player.team)) {
      operatorstruct.operator = player scripts\mp\teams::lookupcurrentoperator(player.team);
      operatorstruct.operator_skin = player scripts\mp\teams::function_ed273e317490cb02(operatorstruct.operator);
      operatorstruct.execution = player scripts\mp\teams::getoperatorexecution(operatorstruct.operator);

      if(isDefined(operatorstruct.execution)) {
        operatorstruct.operator_execution_ref = operatorstruct.execution;
      }
    }

    lobby_id = function_4f9373a1227db35c();

    if(!isDefined(lobby_id)) {
      lobby_id = "";
    }

    current_season = getdvarint(@ "current_season", -1);
    current_team = "unset";

    if(isDefined(player.sessionteam)) {
      current_team = player.sessionteam;
    }

    if(isDefined(player.team)) {
      current_team = player.team;
    }

    player_placement = -1;

    if(isDefined(player.pers["telemetry"].teamplacement)) {
      player_placement = player.pers["telemetry"].teamplacement;
    }

    is_ranked = 0;

    if(istrue(level.leagueplaymatch) || istrue(level.var_77907d733abe8b63)) {
      is_ranked = 1;
    }

    armor_collected = 0;

    if(isDefined(player.pers["telemetry"].armor_collected)) {
      armor_collected = player.pers["telemetry"].armor_collected;
    }

    armor_equipped = 0;

    if(isDefined(player.pers["telemetry"].armor_equipped)) {
      armor_equipped = player.pers["telemetry"].armor_equipped;
    }

    armor_destroyed = 0;

    if(isDefined(player.pers["telemetry"].armor_destroyed)) {
      armor_destroyed = player.pers["telemetry"].armor_destroyed;
    }

    var_8069c698315a4e16 = 0;

    if(isDefined(player.pers["telemetry"].var_8069c698315a4e16)) {
      var_8069c698315a4e16 = player.pers["telemetry"].var_8069c698315a4e16;
    }

    vehicle_autofwd_count = 0;

    if(isDefined(player.pers["telemetry"].vehicle_autofwd_count)) {
      vehicle_autofwd_count = player.pers["telemetry"].vehicle_autofwd_count;
    }

    ground_vehicle_used_count = 0;

    if(isDefined(player.pers["telemetry"].ground_vehicle_used_count)) {
      ground_vehicle_used_count = player.pers["telemetry"].ground_vehicle_used_count;
    }

    air_vehicle_used_count = 0;

    if(isDefined(player.pers["telemetry"].air_vehicle_used_count)) {
      air_vehicle_used_count = player.pers["telemetry"].air_vehicle_used_count;
    }

    is_controller = player usinggamepad();
    secondary_victory = istrue(player.extracted);
    holding_weapon_case = namespace_a8b2b88699fc40fb::didextractwithweaponcase(player);
    best_squad_wipe_streak = 0;

    if(isDefined(player.team) && scripts\mp\utility\teams::function_ef7cf07ba921200e(player.team, "best_squad_wipes")) {
      best_squad_wipe_streak = scripts\mp\utility\teams::getteamdata(player.team, "best_squad_wipes");
    }

    player dlog_recordplayerevent("dlog_event_mp_player_match_end", ["utc_connect_time_s", utc_connect_time, "utc_disconnect_time_s", getsystemtime(), "team", current_team, "score", player getpersstat("score"), "placement", player_placement, "assists", player getpersstat("assists"), "longest_streak", player getpersstat("longestStreak"), "kills", player getpersstat("kills"), "ai_agent_kills", countstruct.ai_agent_kills, "deaths", player getpersstat("deaths"), "headshots", player getpersstat("headshots"), "executions", player getpersstat("executions"), "player_xp_modifier", int(player scripts\mp\rank::getrankxpmultiplier()), "team_xp_modifier", team_xp_modifier, "weapon_xp_modifier", int(player scripts\mp\weaponrank::getweaponrankxpmultiplier()), "disconnect_reason", disconnect_reason, "player_quit_round_number", player_quit_round_number, "player_quit_team_score", player_quit_team_score, "player_quit_opposing_team_score", player_quit_opposing_team_score, "average_speed_during_match", average_speed_during_match, "percent_time_moving", percent_time_moving, "damage_done", damage_done, "damage_taken", damage_taken, "distance_traveled", distance_traveled, "weapon_accuracy", weapon_accuracy, "suicides", suicides, "game_type", game_type, "gw_spawn_method_press_activate", gw_spawn_method_press_activate, "gw_spawn_method_press_gostand", gw_spawn_method_press_gostand, "gw_spawn_method_press_lclick", gw_spawn_method_press_lclick, "gw_spawn_method_press_rclick", gw_spawn_method_press_rclick, "playlist_id", playlist_id, "playlist_name", playlist_name, "map", level.script, "connect_index", connect_index, "match_outcome", match_outcome, "rank_at_start", lifetimedata.rank_at_start, "rank_at_end", lifetimedata.rank_at_end, "xp_at_start", lifetimedata.xp_at_start, "xp_at_end", lifetimedata.xp_at_end, "score_at_start", lifetimedata.score_at_start, "score_at_end", lifetimedata.score_at_end, "prestige_at_start", lifetimedata.prestige_at_start, "prestige_at_end", lifetimedata.prestige_at_end, "lifetime_kills", lifetimedata.lifetime_kills, "lifetime_deaths", lifetimedata.lifetime_deaths, "lifetime_wins", lifetimedata.lifetime_wins, "lifetime_losses", lifetimedata.lifetime_losses, "lifetime_hits", lifetimedata.lifetime_hits, "lifetime_misses", lifetimedata.lifetime_misses, "lifetime_wall_bangs", lifetimedata.lifetime_wall_bangs, "lifetime_near_misses", lifetimedata.lifetime_near_misses, "lifetime_games_played", lifetimedata.lifetime_games_played, "lifetime_time_played_total", lifetimedata.lifetime_time_played_total, "total_xp", total_xp, "score_xp", score_xp, "challenge_xp", challenge_xp, "match_xp", match_xp, "medal_xp", medal_xp, "bonus_xp", bonus_xp, "misc_xp", misc_xp, "accolade_xp", accolade_xp, "weapon_xp", weapon_xp, "operator_xp", operator_xp, "clan_xp", clan_xp, "battlepass_xp", battlepass_xp, "shots", shots, "hits", hits, "player_score_event_count", countstruct.player_score_event_count, "player_weapon_stats_count", countstruct.player_weapon_stats_count, "kill_streak_expired_count", countstruct.kill_streak_expired_count, "player_loadout_count", countstruct.player_loadout_count, "operator", operatorstruct.operator, "operator_skin", operatorstruct.operator_skin, "operator_execution_ref", operatorstruct.operator_execution_ref, "lobby_id", lobby_id, "current_season", current_season, "voice_chat_used", player function_5fe468c5d49ce7c(), "is_ranked", is_ranked, "armor_collected", armor_collected, "armor_equipped", armor_equipped, "armor_destroyed", armor_destroyed, "win_challenge_points_earned", var_8069c698315a4e16, "vehicle_autofwd_count", vehicle_autofwd_count, "ground_vehicle_used_count", ground_vehicle_used_count, "air_vehicle_used_count", air_vehicle_used_count, "is_controller", is_controller, "secondary_victory", secondary_victory, "holding_weapon_case", holding_weapon_case, "wall_bangs", player getpersstat("wallbangs"), "best_squad_wipe_streak", best_squad_wipe_streak, "has_bounty_royal_played", istrue(level.var_b631261462e3ab3c)]);
    var_d45168df05638abc = "";

    if(isDefined(data.disconnectreason)) {
      if(isxhash(data.disconnectreason) || isxhashasset(data.disconnectreason) || function_28eeffcb2337321e(data.disconnectreason)) {
        var_d45168df05638abc = getxhashhexname(data.disconnectreason);
      } else {
        var_d45168df05638abc = data.disconnectreason;
      }
    }

    var_37aab353fe84a505 = "{\"disconnect_reason\":\"" + var_d45168df05638abc + "\"}";
    recordeventforsreparser("player_match_end", var_37aab353fe84a505);
    player.pers["telemetry"].var_d6caa636bc3fce32 = 1;
  }
}

function function_9b064138ff8c311b() {
  foreach(player in level.players) {
    function_e2db44d4086cdd23(player);
  }
}

function function_e2db44d4086cdd23(player) {
  if(!isDefined(player.pers["telemetry"].var_3dd9e60f3eee6883)) {
    if(!namespace_de6e6777b0937bd7::is_valid_client(player)) {
      return;
    }

    if(istrue(player.var_6a91d0e80cc504e) && !istrue(level.gameended)) {
      return;
    }

    if(isDefined(level.var_84c0c9d11311a95d) && level.var_84c0c9d11311a95d) {
      var_491f8ce567ba233c = "OPTED_OUT";

      if(player function_d097b8cbb9e70d9f()) {
        var_491f8ce567ba233c = "OPTED_IN";
      }

      is_party_host = 0;

      if(level.onlinegame) {
        is_party_host = player isfireteamleader();
      }

      player dlog_recordplayerevent("dlog_event_mp_player_rematch_opt_in", ["selection", var_491f8ce567ba233c, "party_id", player getpartyid(), "is_party_host", is_party_host, "timed_out", 0]);
    }

    player.pers["telemetry"].var_3dd9e60f3eee6883 = 1;
  }
}

function on_ai_killed(params) {
  if(!istrue(level.disablestattracking)) {
    if(!namespace_de6e6777b0937bd7::is_valid_client(params.eattacker)) {
      return;
    }

    var_c11d6c177d7ab5a2 = spawnStruct();
    function_f632348cbb773537(level.mp_ai_killed_telemetry_throttle, var_c11d6c177d7ab5a2);

    if(!isDefined(params.eattacker)) {
      return;
    }

    if(isDefined(params.eattacker scripts\mp\utility\stats::getpersstat("telemetry").ai_agent_kills)) {
      params.eattacker.pers["telemetry"].ai_agent_kills++;
    }

    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.weaponname = scripts\cp_mp\weapon::getweaponrootname(params.sweapon);
    var_7e2c53b0bcf117d9.fullweaponname = getcompleteweaponname(params.sweapon);
    var_7e2c53b0bcf117d9.statname = "ai_agent_kills";
    var_7e2c53b0bcf117d9.incvalue = 1;
    var_7e2c53b0bcf117d9.variantid = getweaponvariantindex(params.sweapon);
    var_7e2c53b0bcf117d9.weaponobj = params.sweapon;
    assertex(level.telemetry_callbacks["<dev string:x89>"].size == 1, "<dev string:xa9>");
    params.eattacker update_weapon_stats(var_7e2c53b0bcf117d9);
  }
}

function on_player_death(data) {
  attacker = data.attacker;
  victim = data.victim;

  if(!namespace_de6e6777b0937bd7::is_valid_client(victim)) {
    return;
  }

  weapon_string = "";

  if(isDefined(data.weaponfullstring)) {
    weapon_string = data.weaponfullstring;
  }

  means_of_death = "";

  if(isDefined(data.meansofdeath)) {
    means_of_death = data.meansofdeath;
  }

  if(weapon_string == "agent_mp") {
    attacker_weapon_attachments = [];
  } else {
    var_ba6f272fe15ef31b = getweaponattachments(weapon_string);
    attacker_weapon_attachments = attachmentsfilterforstats(var_ba6f272fe15ef31b, weapon_string);
  }

  spawntime = 0;

  if(isDefined(victim.spawntime)) {
    spawntime = victim.spawntime;
  }

  spawn_time_from_match_start_ms = namespace_de6e6777b0937bd7::function_1b15450e092933cf(spawntime);
  death_time_from_match_start_ms = namespace_de6e6777b0937bd7::function_1b15450e092933cf(gettime());
  life_index = -1;

  if(isDefined(victim scripts\mp\utility\stats::getpersstat("telemetry").life.life_index)) {
    life_index = victim scripts\mp\utility\stats::getpersstat("telemetry").life.life_index;
  }

  if(isDefined(victim scripts\mp\utility\stats::getpersstat("telemetry").life.var_d8bae1f0e4d5e27e) && victim scripts\mp\utility\stats::getpersstat("telemetry").life.var_d8bae1f0e4d5e27e == life_index) {
    return;
  }

  attacker_life_index = -1;
  attacker_loadout_index = -1;
  attacker_death_modifiers = [];
  attacker_was_ai = 0;
  ai_tier = "";

  if(namespace_de6e6777b0937bd7::is_valid_client(attacker)) {
    attacker_weapon = getweaponbasename(weapon_string);
    var_41fb323b39c88db5 = attacker;
    attacker_weapon_picked_up = attacker ispickedupweapon(weapon_string);
    attacker_weapon_alt_mode = attacker isalternatemode(weapon_string);
    attacker_ads_value = 0;

    if(iscacprimaryorsecondary(weapon_string)) {
      attacker_ads_value = attacker playerads();
    }

    attacker_was_in_victim_fov = within_fov(victim.origin, victim.angles, attacker.origin, 0.4226);
    victim_was_in_attacker_fov = within_fov(attacker.origin, attacker.angles, victim.origin, 0.4226);
    attacker_mount_type = attacker namespace_de6e6777b0937bd7::function_50989a55805a440b();
    attacker_pos = attacker.origin;
    attacker_angles = attacker.angles;

    if(isDefined(attacker scripts\mp\utility\stats::getpersstat("telemetry").life.life_index)) {
      attacker_life_index = attacker scripts\mp\utility\stats::getpersstat("telemetry").life.life_index;
    }

    if(isDefined(attacker.loadoutindex)) {
      attacker_loadout_index = attacker.loadoutindex;
    }

    attacker_death_modifiers = attacker namespace_7349d2dcd492da87::function_1c355f42faf7f4bb();
  } else {
    var_41fb323b39c88db5 = undefined;

    if(isDefined(attacker) && isagent(attacker)) {
      attacker_was_ai = 1;
      ai_tier = attacker.agent_type;
      attacker_weapon = "";
      attacker_weapon_picked_up = 0;
      attacker_weapon_alt_mode = 0;
      attacker_ads_value = 0;
      attacker_was_in_victim_fov = within_fov(victim.origin, victim.angles, attacker.origin, 0.4226);
      victim_was_in_attacker_fov = within_fov(attacker.origin, attacker.angles, victim.origin, 0.4226);
      attacker_mount_type = "MOUNT_NONE";
      attacker_pos = attacker.origin;
      attacker_angles = attacker.angles;
    } else {
      attacker_weapon = "";
      attacker_weapon_picked_up = 0;
      attacker_weapon_alt_mode = 0;
      attacker_ads_value = 0;
      attacker_was_in_victim_fov = 0;
      victim_was_in_attacker_fov = 0;
      attacker_mount_type = "MOUNT_NONE";
      attacker_pos = (0, 0, 0);
      attacker_angles = (0, 0, 0);
    }
  }

  victim_death_modifiers = victim namespace_7349d2dcd492da87::function_1c355f42faf7f4bb();
  victim_weapon_attachments = [];
  victim_weapon = "";
  victimcurrentweapon = ter_op(scripts\mp\utility\player::isinlaststand(victim) && isDefined(victim.laststandoldweaponobj), victim.laststandoldweaponobj, victim.lastweaponused);

  if(isDefined(victimcurrentweapon)) {
    var_fb475ef768b518c0 = getweaponattachments(victimcurrentweapon);
    victim_weapon_attachments = attachmentsfilterforstats(var_fb475ef768b518c0, victimcurrentweapon);
    victim_weapon = getweaponbasename(victimcurrentweapon);

    if(victim_weapon == "iw8_gunless") {
      DevOp(0x2);
    }

    victim_weapon_picked_up = victim ispickedupweapon(victimcurrentweapon);
    victim_weapon_alt_mode = victim isalternatemode(victimcurrentweapon, 0, 1);
    victim_ads_value = victim playerads();
  } else {
    victim_weapon_picked_up = 0;
    victim_weapon_alt_mode = 0;
    victim_ads_value = 0;
  }

  victim_mount_type = victim namespace_de6e6777b0937bd7::function_50989a55805a440b();
  victim_loadout_index = -1;

  if(isDefined(victim.loadoutindex)) {
    victim_loadout_index = victim.loadoutindex;
  }

  xp_earned = 0;

  if(isDefined(victim scripts\mp\utility\stats::getpersstat("summary")["xp"])) {
    currentxp = victim scripts\mp\utility\stats::getpersstat("summary")["xp"];
    xp_earned = currentxp - victim scripts\mp\utility\stats::getpersstat("telemetry").life.var_2148fb703835ec1f;
  }

  score_earned = victim.score - victim scripts\mp\utility\stats::getpersstat("telemetry").life.var_7e5250b5700df037;
  round = -1;

  if(isroundbased()) {
    round = game["roundsPlayed"];

    if(means_of_death == "MOD_GAME_ENDED" || means_of_death == "MOD_ROUND_ENDED") {
      round--;

      if(round < 0) {
        round = 0;
      }
    }
  }

  is_hipfire = 0;

  if(isDefined(attacker) && isDefined(attacker.modifiers)) {
    is_hipfire = istrue(attacker.modifiers["hipfire"]);
  }

  spawn_pos = (0, 0, 0);

  if(isDefined(victim.spawnpos)) {
    spawn_pos = victim.spawnpos;
  }

  was_tactical_insertion = 0;

  if(isDefined(victim.wasti)) {
    was_tactical_insertion = victim.wasti;
  }

  spawn_evaluation_id = 0;

  if(isDefined(victim.spawndata) && isDefined(victim.spawndata.spawnpoint) && isDefined(victim.spawndata.spawnpoint.evaluationid)) {
    spawn_evaluation_id = victim.spawndata.spawnpoint.evaluationid;
  }

  attacker_shooting_mode = "1st";

  if(isDefined(attacker) && isDefined(attacker.pers) && isDefined(attacker scripts\mp\utility\stats::getpersstat("shootingMode"))) {
    attacker_shooting_mode = attacker scripts\mp\utility\stats::getpersstat("shootingMode");
  }

  victim_shooting_mode = "1st";

  if(isDefined(victim scripts\mp\utility\stats::getpersstat("shootingMode"))) {
    victim_shooting_mode = victim scripts\mp\utility\stats::getpersstat("shootingMode");
  }

  first_damage_delivered_time_ms = 0;

  if(isDefined(victim.var_198b774c93c48891)) {
    first_damage_delivered_time_ms = namespace_de6e6777b0937bd7::function_1b15450e092933cf(victim.var_198b774c93c48891);
  }

  first_damage_received_time_ms = 0;

  if(isDefined(victim.var_9691e7d8cde294f2)) {
    first_damage_received_time_ms = namespace_de6e6777b0937bd7::function_1b15450e092933cf(victim.var_9691e7d8cde294f2);
  }

  if(isstring(means_of_death)) {
    var_20e794ee21ccc0c3 = getxhash(means_of_death);
  } else {
    var_20e794ee21ccc0c3 = means_of_death;
  }

  incomingdamage = -1;
  var_51334e7082b98cbe = -1;

  if(isDefined(victim.var_489f22c08f63bc0f)) {
    incomingdamage = victim.var_489f22c08f63bc0f;
  }

  if(isDefined(victim.lifetimedamage)) {
    var_51334e7082b98cbe = victim.lifetimedamage;
  }

  var_b94cd1b61321122a = 0;

  if(isDefined(victim.var_ddae1352e36165f6)) {
    var_b94cd1b61321122a = victim.var_ddae1352e36165f6;
  }

  var_99ec0e0e7687c243 = 0;

  if(isDefined(attacker) && isDefined(attacker.currentprimaryweapon)) {
    var_99ec0e0e7687c243 = attacker function_c603bed3b1c8d11(attacker.currentprimaryweapon, 0);
  }

  victim dlog_recordplayerevent("dlog_event_mp_life", ["attacker", var_41fb323b39c88db5, "spawn_time_from_match_start_ms", spawn_time_from_match_start_ms, "life_index", life_index, "spawn_evaluation_id", spawn_evaluation_id, "spawn_pos_x", spawn_pos[0], "spawn_pos_y", spawn_pos[1], "spawn_pos_z", spawn_pos[2], "team", victim.team, "is_host", victim ishost(), "was_tactical_insertion", was_tactical_insertion, "death_time_from_match_start_ms", death_time_from_match_start_ms, "victim_weapon", victim_weapon, "victim_weapon_attachments", victim_weapon_attachments, "attacker_weapon", attacker_weapon, "attacker_weapon_attachments", attacker_weapon_attachments, "victim_death_modifiers", victim_death_modifiers, "attacker_death_modifiers", attacker_death_modifiers, "death_pos_x", victim.origin[0], "death_pos_y", victim.origin[1], "death_pos_z", victim.origin[2], "death_angle_x", victim.angles[0], "death_angle_y", victim.angles[1], "death_angle_z", victim.angles[2], "attacker_pos_x", attacker_pos[0], "attacker_pos_y", attacker_pos[1], "attacker_pos_z", attacker_pos[2], "attacker_angle_x", attacker_angles[0], "attacker_angle_y", attacker_angles[1], "attacker_angle_z", attacker_angles[2], "means_of_death", var_20e794ee21ccc0c3, "attacker_weapon_alt_mode", attacker_weapon_alt_mode, "attacker_weapon_picked_up", attacker_weapon_picked_up, "victim_weapon_alt_mode", victim_weapon_alt_mode, "victim_weapon_picked_up", victim_weapon_picked_up, "attacker_ads_value", attacker_ads_value, "victim_ads_value", victim_ads_value, "attacker_was_in_victim_fov", attacker_was_in_victim_fov, "victim_was_in_attacker_fov", victim_was_in_attacker_fov, "attacker_mount_type", attacker_mount_type, "victim_mount_type", victim_mount_type, "xp_earned", xp_earned, "score_earned", score_earned, "victim_loadout_index", victim_loadout_index, "attacker_life_index", attacker_life_index, "attacker_loadout_index", attacker_loadout_index, "victim_was_reloading", victim isreloading(), "victim_was_executing", victim isinexecutionattack(), "round", round, "is_hipfire", is_hipfire, "attacker_shooting_mode", attacker_shooting_mode, "victim_shooting_mode", victim_shooting_mode, "first_damage_delivered_time_ms", first_damage_delivered_time_ms, "first_damage_received_time_ms", first_damage_received_time_ms, "attacker_was_ai", attacker_was_ai, "lifetime_damage_dealt", float(var_51334e7082b98cbe), "lifetime_damage_received", float(incomingdamage), "ai_tier", ai_tier, "victim_in_tac_stance", var_b94cd1b61321122a, "attacker_in_tac_stance", var_99ec0e0e7687c243]);
  victim.pers["telemetry"].life.var_d8bae1f0e4d5e27e = life_index;

  if(namespace_de6e6777b0937bd7::is_valid_client(attacker)) {
    logtournamentdeath(victim getxuid(), attacker getxuid(), weapon_string, means_of_death == "MOD_HEAD_SHOT");

    if(isDefined(level.matchrecording_logevent)) {
      time = gettime();
      [[level.matchrecording_logevent]](victim.clientid, victim.team, "DEATH", victim.origin[0], victim.origin[1], time);

      if(issubstr(tolower(means_of_death), "bullet") && isDefined(weapon_string) && !iskillstreakweapon(weapon_string)) {
        [[level.matchrecording_logevent]](attacker.clientid, attacker.team, "BULLET", attacker.origin[0], attacker.origin[1], time, undefined, victim.origin[0], victim.origin[1]);
      }
    }
  }
}

function on_player_disconnect(data) {
  function_6447f24addc0137e(data);
  var_a4772a08b422271f = -1;

  if(namespace_de6e6777b0937bd7::function_4b974d822d418a06(data) && isDefined(data.player.pers["telemetry"].life.var_d8bae1f0e4d5e27e)) {
    var_a4772a08b422271f = data.player.pers["telemetry"].life.var_d8bae1f0e4d5e27e;
  }

  lifeindex = -1;

  if(namespace_de6e6777b0937bd7::function_4b974d822d418a06(data) && isDefined(data.player.pers["telemetry"].life.life_index)) {
    lifeindex = data.player.pers["telemetry"].life.life_index;
  }

  if(var_a4772a08b422271f != lifeindex) {
    lifedata = spawnStruct();
    lifedata.victim = data.player;
    lifedata.attacker = undefined;
    lifedata.weaponfullstring = "none";
    lifedata.meansofdeath = "";

    if(isDefined(data.disconnectreason)) {
      lifedata.meansofdeath = "MOD_DISCONNECTED";
    }

    on_player_death(lifedata);
  }
}

function function_60912f12edbae676(data) {
  if(isDefined(data.lifeindex)) {
    var_8f7e680ac270abc2 = data.lifeindex;
  } else {
    var_8f7e680ac270abc2 = -1;
  }

  timemsfrommatchstart = namespace_de6e6777b0937bd7::function_1b15450e092933cf(gettime());
  classstruct = data.classstruct;
  var_b98a554f5fc058c2 = classstruct.loadoutprimary;
  primaryweaponobj = classstruct.loadoutprimaryobject;
  var_7da5c09e8cc677d1 = [];
  maxprimaryattachments = scripts\mp\class::getmaxprimaryattachments();
  loadoutprimaryattachments = classstruct.loadoutprimaryattachments;

  for(attachmentindex = 0; attachmentindex < maxprimaryattachments; attachmentindex++) {
    primaryattach = loadoutprimaryattachments[attachmentindex];

    if(isDefined(primaryattach)) {
      var_c130cd8c126c9aad = getxhash(primaryattach);
    } else {
      var_c130cd8c126c9aad = #"";
    }

    var_7da5c09e8cc677d1[attachmentindex] = var_c130cd8c126c9aad;
  }

  var_d4d89beaf7dcfa0a = classstruct.loadoutprimarycamo;

  if(!isDefined(var_d4d89beaf7dcfa0a)) {
    var_d4d89beaf7dcfa0a = #"";
  }

  var_684a28861c742b36 = classstruct.loadoutprimaryreticle;
  var_267cee921deab64e = classstruct.loadoutprimarylootitemid;
  var_3a7820a8ca123ece = classstruct.loadoutprimaryvariantid;
  var_e86b5ff35057c02 = classstruct.loadoutsecondary;
  secondaryweaponobj = classstruct.loadoutsecondaryobject;
  var_f67a501a2ba8c411 = [];
  maxsecondaryattachments = scripts\mp\class::getmaxsecondaryattachments();
  loadoutsecondaryattachments = classstruct.loadoutsecondaryattachments;

  for(attachmentindex = 0; attachmentindex < maxsecondaryattachments; attachmentindex++) {
    secondaryattach = loadoutsecondaryattachments[attachmentindex];

    if(isDefined(secondaryattach)) {
      var_3595c5a4bef8f5ed = getxhash(secondaryattach);
    } else {
      var_3595c5a4bef8f5ed = #"";
    }

    var_f67a501a2ba8c411[attachmentindex] = var_3595c5a4bef8f5ed;
  }

  var_9b18f02999b23b4a = classstruct.loadoutsecondarycamo;

  if(!isDefined(var_9b18f02999b23b4a)) {
    var_9b18f02999b23b4a = #"";
  }

  var_f3f8fd2658d0a576 = classstruct.loadoutsecondaryreticle;
  var_d063e05308a9da8e = classstruct.loadoutsecondarylootitemid;
  var_dd47d5b37f1b770e = classstruct.loadoutsecondaryvariantid;
  primarygrenade = classstruct.loadoutequipmentprimary;

  if(!isDefined(primarygrenade)) {
    primarygrenade = #"";
  }

  tacticalgear = classstruct.loadoutequipmentsecondary;

  if(!isDefined(tacticalgear)) {
    tacticalgear = #"";
  }

  var_cda5f3d036862ee = classstruct.loadoutstandardperks.size;
  var_5e16b98fc67f9d0a = #"specialty_null";
  var_1135208ed2c7cb70 = #"specialty_null";
  vest_perk = #"specialty_null";
  glove_perk = #"specialty_null";
  boot_perk = #"specialty_null";
  var_15434209a30e5984 = #"specialty_null";
  var_5db02909d819dafa = #"specialty_null";

  foreach(perk in classstruct.loadoutstandardperks) {
    perkbundle = level.perkbundles[perk];

    if(isDefined(perkbundle)) {
      switch (perkbundle.var_70774aeb81261100) {
        case #"hash_8cbf71797441f513":
          vest_perk = perk;
          break;
        case #"hash_6fb5d66c124bebf7":
          glove_perk = perk;
          break;
        case #"hash_998e90e64af76252":
          boot_perk = perk;
          break;
        case #"hash_60a8910f025fc58e":
          if(var_15434209a30e5984 == #"specialty_null") {
            var_15434209a30e5984 = perk;
          } else {
            var_5db02909d819dafa = perk;
          }

          break;
      }
    }
  }

  if(isDefined(classstruct.var_15f3e6df722fb1cf)) {
    bonusperk = classstruct.var_15f3e6df722fb1cf;
  } else {
    bonusperk = #"specialty_null";
  }

  if(isDefined(classstruct.var_15f3e5df722faf9c)) {
    ultimateperk = classstruct.var_15f3e5df722faf9c;
  } else {
    ultimateperk = #"specialty_null";
  }

  extra_loadout_perk_2 = #"speciality_null";

  if(isDefined(classstruct.loadoutextraperks[0])) {
    extra_loadout_perk_1 = classstruct.loadoutextraperks[0];
  } else {
    extra_loadout_perk_1 = #"speciality_null";
  }

  if(isDefined(classstruct.loadoutextraperks[1])) {
    extra_loadout_perk_2 = classstruct.loadoutextraperks[1];
  } else {
    extra_loadout_perk_2 = #"speciality_null";
  }

  if(isDefined(data.player.loadoutfieldupgrade1)) {
    var_8ecf289c70dd61eb = data.player.loadoutfieldupgrade1;
  } else {
    var_8ecf289c70dd61eb = #"none";
  }

  if(isDefined(data.player.loadoutfieldupgrade2)) {
    var_f5bb419cbccebbe5 = data.player.loadoutfieldupgrade2;
  } else {
    var_f5bb419cbccebbe5 = #"none";
  }

  if(isDefined(self.pers["shootingMode"])) {
    shooting_mode = self.pers["shootingMode"];
  } else {
    shooting_mode = "1st";
  }

  primarytuning = function_b4ed203552f83bca(primaryweaponobj);
  secondarytuning = function_b4ed203552f83bca(secondaryweaponobj);

  if(isDefined(data.primaryblueprint)) {
    primary_blueprint = data.primaryblueprint.blueprintname;
    primaryblueprintname = primary_blueprint;
    primaryblueprintid = data.primaryblueprint.lootid;
    var_7a6106e50e8ed5e7 = 1;
  } else {
    primary_blueprint = #"";
    primaryblueprintid = 0;
    primaryblueprintname = #"";
    var_7a6106e50e8ed5e7 = 0;
  }

  if(isDefined(data.secondaryblueprint)) {
    secondary_blueprint = data.secondaryblueprint.blueprintname;
    secondaryblueprintname = secondary_blueprint;
    secondaryblueprintid = data.secondaryblueprint.lootid;
    var_35bc7057db6ba727 = 1;
  } else {
    secondary_blueprint = #"";
    secondaryblueprintid = 0;
    secondaryblueprintname = #"";
    var_35bc7057db6ba727 = 0;
  }

  if(isDefined(self.loadoutclass)) {
    isdefaultloadout = getsubstr(self.loadoutclass, 0, 7) == "default";
  } else {
    isdefaultloadout = 0;
  }

  var_8a4ffee432ca8d5e = 0;
  var_6dfa4cce4ce056b6 = 0;

  if(isDefined(primaryweaponobj)) {
    if(isDefined(primaryweaponobj.var_75a7008e426d90db)) {
      if(primaryweaponobj.var_75a7008e426d90db.size > 0) {
        var_8a4ffee432ca8d5e = 1;
      }
    }

    if(isDefined(primaryweaponobj.blueprinttuned)) {
      var_6dfa4cce4ce056b6 = 1;
    }
  }

  var_dc067331d5eee29e = 0;
  var_d5539868aaef02f6 = 0;

  if(isDefined(secondaryweaponobj)) {
    if(isDefined(secondaryweaponobj.var_75a7008e426d90db)) {
      if(secondaryweaponobj.var_75a7008e426d90db.size > 0) {
        var_dc067331d5eee29e = 1;
      }
    }

    if(isDefined(secondaryweaponobj.blueprinttuned)) {
      var_d5539868aaef02f6 = 1;
    }
  }

  streaktype = "Killstreaks";

  if(istrue(self.scorestreaktype)) {
    streaktype = "Points";
  }

  primaryampdata = function_deef6a4f7fbec3b8(primaryweaponobj);
  secondaryampdata = function_deef6a4f7fbec3b8(secondaryweaponobj);
  var_d3cf11436c80a43e = data.player dlog_recordplayerevent("dlog_event_mp_player_loadout", ["loadout_index", data.loadoutindex, "class_type", getxhash(data.classtype), "mid_match_edit_count", data.var_15bab3eaa5df4c14, "first_use_life_index", var_8f7e680ac270abc2, "time_from_match_start_ms", timemsfrommatchstart, "primary_weapon_setup_camo", getxhash(var_d4d89beaf7dcfa0a), "primary_weapon_setup_reticle", var_684a28861c742b36, "primary_weapon_setup_loot_item_id", var_267cee921deab64e, "primary_weapon_setup_variant_id", var_3a7820a8ca123ece, "secondary_weapon_setup_camo", getxhash(var_9b18f02999b23b4a), "secondary_weapon_setup_reticle", var_f3f8fd2658d0a576, "secondary_weapon_setup_loot_item_id", var_d063e05308a9da8e, "secondary_weapon_setup_variant_id", var_dd47d5b37f1b770e, "primary_grenade", getxhash(primarygrenade), "tactical_gear", getxhash(tacticalgear), "base_perk_1", getxhash(var_5e16b98fc67f9d0a), "base_perk_2", getxhash(var_1135208ed2c7cb70), "bonus_perk", getxhash(bonusperk), "ultimate_perk", getxhash(ultimateperk), "extra_loadout_perk_1", getxhash(extra_loadout_perk_1), "extra_loadout_perk_2", getxhash(extra_loadout_perk_2), "killstreak_0", getxhash(classstruct.loadoutkillstreak1), "killstreak_1", getxhash(classstruct.loadoutkillstreak2), "killstreak_2", getxhash(classstruct.loadoutkillstreak3), "field_upgrade_0", getxhash(var_8ecf289c70dd61eb), "field_upgrade_1", getxhash(var_f5bb419cbccebbe5), "shooting_mode", getxhash(shooting_mode), "primary_blueprint", getxhash(primary_blueprint), "secondary_blueprint", getxhash(secondary_blueprint), "primary_weapon_receiver", getxhash(primarytuning.weapon_receiver), "primary_weapon_front_piece", getxhash(primarytuning.weapon_front_piece), "primary_weapon_back_piece", getxhash(primarytuning.weapon_back_piece), "primary_weapon_magazine", getxhash(primarytuning.weapon_magazine), "primary_weapon_optic", getxhash(primarytuning.weapon_optic), "primary_weapon_underbarrel", getxhash(primarytuning.weapon_underbarrel), "primary_weapon_modifier", getxhash(primarytuning.weapon_modifier), "primary_weapon_muzzle", getxhash(primarytuning.weapon_muzzle), "primary_weapon_rear_grip", getxhash(primarytuning.weapon_rear_grip), "primary_weapon_trigger", getxhash(primarytuning.weapon_trigger), "primary_weapon_extra", getxhash(primarytuning.weapon_extra), "primary_lid_receiver", primarytuning.lid_receiver, "primary_lid_front_piece", primarytuning.lid_front_piece, "primary_lid_back_piece", primarytuning.lid_back_piece, "primary_lid_magazine", primarytuning.lid_magazine, "primary_lid_optic", primarytuning.lid_optic, "primary_lid_underbarrel", primarytuning.lid_underbarrel, "primary_lid_modifier", primarytuning.lid_modifier, "primary_lid_muzzle", primarytuning.lid_muzzle, "primary_lid_rear_grip", primarytuning.lid_rear_grip, "primary_lid_trigger", primarytuning.lid_trigger, "primary_lid_extra", primarytuning.lid_extra, "primary_tv_receiver", primarytuning.tv_receiver, "primary_tv_front_piece", primarytuning.tv_front_piece, "primary_tv_back_piece", primarytuning.tv_back_piece, "primary_tv_magazine", primarytuning.tv_magazine, "primary_tv_optic", primarytuning.tv_optic, "primary_tv_underbarrel", primarytuning.tv_underbarrel, "primary_tv_modifier", primarytuning.tv_modifier, "primary_tv_muzzle", primarytuning.tv_muzzle, "primary_tv_rear_grip", primarytuning.tv_rear_grip, "primary_tv_trigger", primarytuning.tv_trigger, "primary_tv_extra", primarytuning.tv_extra, "primary_is_bp_tuned", primarytuning.tuned, "secondary_weapon_receiver", getxhash(secondarytuning.weapon_receiver), "secondary_weapon_front_piece", getxhash(secondarytuning.weapon_front_piece), "secondary_weapon_back_piece", getxhash(secondarytuning.weapon_back_piece), "secondary_weapon_magazine", getxhash(secondarytuning.weapon_magazine), "secondary_weapon_optic", getxhash(secondarytuning.weapon_optic), "secondary_weapon_underbarrel", getxhash(secondarytuning.weapon_underbarrel), "secondary_weapon_modifier", getxhash(secondarytuning.weapon_modifier), "secondary_weapon_muzzle", getxhash(secondarytuning.weapon_muzzle), "secondary_weapon_rear_grip", getxhash(secondarytuning.weapon_rear_grip), "secondary_weapon_trigger", getxhash(secondarytuning.weapon_trigger), "secondary_weapon_extra", getxhash(secondarytuning.weapon_extra), "secondary_lid_receiver", secondarytuning.lid_receiver, "secondary_lid_front_piece", secondarytuning.lid_front_piece, "secondary_lid_back_piece", secondarytuning.lid_back_piece, "secondary_lid_magazine", secondarytuning.lid_magazine, "secondary_lid_optic", secondarytuning.lid_optic, "secondary_lid_underbarrel", secondarytuning.lid_underbarrel, "secondary_lid_modifier", secondarytuning.lid_modifier, "secondary_lid_muzzle", secondarytuning.lid_muzzle, "secondary_lid_rear_grip", secondarytuning.lid_rear_grip, "secondary_lid_trigger", secondarytuning.lid_trigger, "secondary_lid_extra", secondarytuning.lid_extra, "secondary_tv_receiver", secondarytuning.tv_receiver, "secondary_tv_front_piece", secondarytuning.tv_front_piece, "secondary_tv_back_piece", secondarytuning.tv_back_piece, "secondary_tv_magazine", secondarytuning.tv_magazine, "secondary_tv_optic", secondarytuning.tv_optic, "secondary_tv_underbarrel", secondarytuning.tv_underbarrel, "secondary_tv_modifier", secondarytuning.tv_modifier, "secondary_tv_muzzle", secondarytuning.tv_muzzle, "secondary_tv_rear_grip", secondarytuning.tv_rear_grip, "secondary_tv_trigger", secondarytuning.tv_trigger, "secondary_tv_extra", secondarytuning.tv_extra, "secondary_is_bp_tuned", secondarytuning.tuned, "is_default_loadout", isdefaultloadout, "primary_is_a_blueprint_weapon", var_7a6106e50e8ed5e7, "primary_blueprint_name", getxhash(primaryblueprintname), "primary_blueprint_id", primaryblueprintid, "primary_is_pro_tuned", var_6dfa4cce4ce056b6, "primary_is_player_tuned", var_8a4ffee432ca8d5e, "primary_weapon_setup_attachment_0", var_7da5c09e8cc677d1[0], "primary_weapon_setup_attachment_1", var_7da5c09e8cc677d1[1], "primary_weapon_setup_attachment_2", var_7da5c09e8cc677d1[2], "primary_weapon_setup_attachment_3", var_7da5c09e8cc677d1[3], "primary_weapon_setup_attachment_4", var_7da5c09e8cc677d1[4], "secondary_is_a_blueprint_weapon", var_35bc7057db6ba727, "secondary_blueprint_name", getxhash(secondaryblueprintname), "secondary_blueprint_id", secondaryblueprintid, "secondary_is_pro_tuned", var_d5539868aaef02f6, "secondary_is_player_tuned", var_dc067331d5eee29e, "secondary_weapon_setup_attachment_0", var_f67a501a2ba8c411[0], "secondary_weapon_setup_attachment_1", var_f67a501a2ba8c411[1], "secondary_weapon_setup_attachment_2", var_f67a501a2ba8c411[2], "secondary_weapon_setup_attachment_3", var_f67a501a2ba8c411[3], "secondary_weapon_setup_attachment_4", var_f67a501a2ba8c411[4], "streak_type", getxhash(streaktype), "vest_perk", getxhash(vest_perk), "glove_perk", getxhash(glove_perk), "boot_perk", getxhash(boot_perk), "gear_perk_1", getxhash(var_15434209a30e5984), "gear_perk_2", getxhash(var_5db02909d819dafa), "primary_amp_data", primaryampdata, "secondary_amp_data", secondaryampdata, "primary_weapon_name", var_b98a554f5fc058c2, "secondary_weapon_name", var_e86b5ff35057c02]);

  if(isDefined(data.player.pers["telemetry"].player_loadout_count) && istrue(var_d3cf11436c80a43e)) {
    data.player.pers["telemetry"].player_loadout_count++;
  }
}

function function_8076b5556f48a6cd(player) {
  if(!namespace_de6e6777b0937bd7::is_valid_client(player)) {
    return;
  }

  if(isbot(player) || istestclient(player) || isai(player)) {
    return;
  }

  player_xp = player getplayerdata(level.loadoutsgroup, "squadMembers", "player_xp");
  weaponstats = player.pers["weaponStats"];

  foreach(datastruct in weaponstats) {
    startingweaponxp = 0;
    earnedxp = 0;
    deaths = 0;
    ai_deaths = 0;
    player_deaths = 0;
    headshots = 0;
    ai_headshots = 0;
    player_headshots = 0;
    hits = 0;
    ai_hits = 0;
    player_hits = 0;
    kills = 0;
    ai_agent_kills = 0;
    ads_kills = 0;
    ai_ads_kills = 0;
    player_ads_kills = 0;
    shots = 0;
    timeused = 0;
    damage = 0;
    ai_damage = 0;
    player_damage = 0;
    startweaponrank = 0;
    weapon_normal_zombie_kills = 0;
    weapon_special_zombie_kills = 0;
    weapon_elite_zombie_kills = 0;
    weapon_boss_zombie_kills = 0;
    weapon_pack_a_punch_kills = 0;
    weapon_critical_kills = 0;
    weapon_soldier_kills = 0;
    weapon_white_rarity_kills = 0;
    weapon_green_rarity_kills = 0;
    weapon_blue_rarity_kills = 0;
    weapon_purple_rarity_kills = 0;
    weapon_orange_rarity_kills = 0;

    if(isenumvaluevalid("common", "LoadoutWeapon", datastruct.weapon)) {
      startingweaponxp = player getplayerdata(level.loadoutsgroup, "squadMembers", "weapon_xp", datastruct.weapon);
      startweaponrank = scripts\mp\weaponrank::getweaponrankforxp(startingweaponxp);
    }

    if(isDefined(datastruct.stats["xp_earned"])) {
      earnedxp += datastruct.stats["xp_earned"];
    }

    if(isDefined(datastruct.stats["deaths"])) {
      deaths += datastruct.stats["deaths"];
    }

    if(isDefined(datastruct.stats["ai_deaths"])) {
      ai_deaths += datastruct.stats["ai_deaths"];
    }

    if(isDefined(datastruct.stats["player_deaths"])) {
      player_deaths += datastruct.stats["player_deaths"];
    }

    if(isDefined(datastruct.stats["headshots"])) {
      headshots += datastruct.stats["headshots"];
    }

    if(isDefined(datastruct.stats["ai_headshots"])) {
      ai_headshots += datastruct.stats["ai_headshots"];
    }

    if(isDefined(datastruct.stats["player_headshots"])) {
      player_headshots += datastruct.stats["player_headshots"];
    }

    if(isDefined(datastruct.stats["hits"])) {
      hits += datastruct.stats["hits"];
    }

    if(isDefined(datastruct.stats["ai_hits"])) {
      ai_hits += datastruct.stats["ai_hits"];
    }

    if(isDefined(datastruct.stats["player_hits"])) {
      player_hits += datastruct.stats["player_hits"];
    }

    if(isDefined(datastruct.stats["kills"])) {
      kills += datastruct.stats["kills"];
    }

    if(isDefined(datastruct.stats["ads_kills"])) {
      ads_kills += datastruct.stats["ads_kills"];
    }

    if(isDefined(datastruct.stats["ai_ads_kills"])) {
      ai_ads_kills += datastruct.stats["ai_ads_kills"];
    }

    if(isDefined(datastruct.stats["player_ads_kills"])) {
      player_ads_kills += datastruct.stats["player_ads_kills"];
    }

    if(isDefined(datastruct.stats["shots"])) {
      shots += datastruct.stats["shots"];
    }

    if(isDefined(datastruct.stats["timeUsed"])) {
      timeused += datastruct.stats["timeUsed"];
    }

    if(isDefined(datastruct.stats["damage"])) {
      damage += datastruct.stats["damage"];
    }

    if(isDefined(datastruct.stats["ai_damage"])) {
      ai_damage += datastruct.stats["ai_damage"];
    }

    if(isDefined(datastruct.stats["player_damage"])) {
      player_damage += datastruct.stats["player_damage"];
    }

    if(isDefined(datastruct.stats["ai_agent_kills"])) {
      ai_agent_kills += datastruct.stats["ai_agent_kills"];
    }

    if(isDefined(datastruct.stats["weapon_normal_zombie_kills"])) {
      weapon_normal_zombie_kills += datastruct.stats["weapon_normal_zombie_kills"];
    }

    if(isDefined(datastruct.stats["weapon_special_zombie_kills"])) {
      weapon_special_zombie_kills += datastruct.stats["weapon_special_zombie_kills"];
    }

    if(isDefined(datastruct.stats["weapon_elite_zombie_kills"])) {
      weapon_elite_zombie_kills += datastruct.stats["weapon_elite_zombie_kills"];
    }

    if(isDefined(datastruct.stats["weapon_boss_zombie_kills"])) {
      weapon_boss_zombie_kills += datastruct.stats["weapon_boss_zombie_kills"];
    }

    if(isDefined(datastruct.stats["weapon_pack_a_punch_kills"])) {
      weapon_pack_a_punch_kills += datastruct.stats["weapon_pack_a_punch_kills"];
    }

    if(isDefined(datastruct.stats["weapon_critical_kills"])) {
      weapon_critical_kills += datastruct.stats["weapon_critical_kills"];
    }

    if(isDefined(datastruct.stats["weapon_soldier_kills"])) {
      weapon_soldier_kills += datastruct.stats["weapon_soldier_kills"];
    }

    if(isDefined(datastruct.stats["weapon_white_rarity_kills"])) {
      weapon_white_rarity_kills += datastruct.stats["weapon_white_rarity_kills"];
    }

    if(isDefined(datastruct.stats["weapon_green_rarity_kills"])) {
      weapon_green_rarity_kills += datastruct.stats["weapon_green_rarity_kills"];
    }

    if(isDefined(datastruct.stats["weapon_blue_rarity_kills"])) {
      weapon_blue_rarity_kills += datastruct.stats["weapon_blue_rarity_kills"];
    }

    if(isDefined(datastruct.stats["weapon_purple_rarity_kills"])) {
      weapon_purple_rarity_kills += datastruct.stats["weapon_purple_rarity_kills"];
    }

    if(isDefined(datastruct.stats["weapon_orange_rarity_kills"])) {
      weapon_orange_rarity_kills += datastruct.stats["weapon_orange_rarity_kills"];
    }

    tuningdata = function_b4ed203552f83bca(datastruct.weaponobj);
    weaponlootid = function_ccb453b7ef932cea(datastruct.weaponobj);
    weapongroup = weapon::getweapongroup(datastruct.weapon);
    var_e96a2497012e529b = 0;
    blueprintid = 0;
    blueprintname = "";
    isplayertuned = 0;
    isprotuned = 0;
    camoidequipped = "none";

    if(isDefined(datastruct.weaponobj)) {
      if(isDefined(datastruct.weaponobj.camo)) {
        camoidequipped = datastruct.weaponobj.camo;
      }

      if(isDefined(datastruct.weaponobj.var_75a7008e426d90db)) {
        if(datastruct.weaponobj.var_75a7008e426d90db.size > 0) {
          isplayertuned = 1;
        }
      }

      isprotuned = istrue(datastruct.weaponobj.blueprinttuned);
      weaponvariantid = getweaponvariantindex(datastruct.weaponobj);

      if(isDefined(weaponvariantid)) {
        variantkey = getweaponrootname(datastruct.weaponobj) + "|" + weaponvariantid;

        if(isDefined(variantkey)) {
          blueprint = level.weaponlootmapdata[variantkey];

          if(isDefined(blueprint)) {
            var_e96a2497012e529b = 1;
            blueprintid = blueprint.lootid;
            blueprintname = variantkey;
          }
        }
      }
    }

    weaponattachmentsetup = [];

    for(attachmentindex = 0; attachmentindex < scripts\mp\class::getmaxprimaryattachments(); attachmentindex++) {
      weaponattachmentsetup[attachmentindex] = "";

      if(isDefined(datastruct.weaponobj)) {
        if(isDefined(datastruct.weaponobj.attachments[attachmentindex])) {
          weaponattachmentsetup[attachmentindex] = datastruct.weaponobj.attachments[attachmentindex];
        }
      }
    }

    endweaponrank = 0;

    if(isDefined(datastruct.stats) && isDefined(datastruct.stats["xp_earned"])) {
      if(isenumvaluevalid("common", "LoadoutWeapon", datastruct.weapon)) {
        startingweaponxp = player getplayerdata(level.loadoutsgroup, "squadMembers", "weapon_xp", datastruct.weapon);
        weaponearnedxp = datastruct.stats["xp_earned"];
        var_63a461789fca386a = startingweaponxp + weaponearnedxp;
        endweaponrank = scripts\mp\weaponrank::getweaponrankforxp(var_63a461789fca386a);
      }

      if(!isDefined(endweaponrank) && !isint(endweaponrank)) {
        endweaponrank = 0;
      }
    }

    var_7249f84dc6294efa = isDefined(player.pers["telemetry"].var_a3ef8d971ec61fc7) ? player.pers["telemetry"].var_a3ef8d971ec61fc7 : 0;
    primaryampdata = [];
    secondaryampdata = [];

    if(isDefined(self.primaryweapons)) {
      if(isDefined(self.primaryweapons[0])) {
        primaryampdata = function_deef6a4f7fbec3b8(self.primaryweapons[0]);
      }

      if(isDefined(self.primaryweapons[1])) {
        secondaryampdata = function_deef6a4f7fbec3b8(self.primaryweapons[1]);
      }
    }

    var_d3cf11436c80a43e = player dlog_recordplayerevent("dlog_event_mp_player_weapon_stats", ["weapon", datastruct.weapon, "variant_id", datastruct.variantid, "attachments", datastruct.weaponattachments, "loadout_index", datastruct.loadoutindex, "is_picked_up", datastruct.ispickedup, "starting_weapon_xp", startingweaponxp, "xp_earned", earnedxp, "deaths", deaths, "ai_deaths", ai_deaths, "player_deaths", player_deaths, "headshots", headshots, "ai_headshots", ai_headshots, "player_headshots", player_headshots, "hits", hits, "ai_hits", ai_hits, "player_hits", player_hits, "kills", kills, "ai_agent_kills", ai_agent_kills, "ads_kills", ads_kills, "ai_ads_kills", ai_ads_kills, "player_ads_kills", player_ads_kills, "shots", shots, "time_used_s", float(timeused), "damage", damage, "ai_damage", ai_damage, "player_damage", player_damage, "weapon_receiver", tuningdata.weapon_receiver, "weapon_front_piece", tuningdata.weapon_front_piece, "weapon_back_piece", tuningdata.weapon_back_piece, "weapon_magazine", tuningdata.weapon_magazine, "weapon_optic", tuningdata.weapon_optic, "weapon_underbarrel", tuningdata.weapon_underbarrel, "weapon_modifier", tuningdata.weapon_modifier, "weapon_muzzle", tuningdata.weapon_muzzle, "weapon_rear_grip", tuningdata.weapon_rear_grip, "weapon_trigger", tuningdata.weapon_trigger, "weapon_extra", tuningdata.weapon_extra, "lid_receiver", tuningdata.lid_receiver, "lid_front_piece", tuningdata.lid_front_piece, "lid_back_piece", tuningdata.lid_back_piece, "lid_magazine", tuningdata.lid_magazine, "lid_optic", tuningdata.lid_optic, "lid_underbarrel", tuningdata.lid_underbarrel, "lid_modifier", tuningdata.lid_modifier, "lid_muzzle", tuningdata.lid_muzzle, "lid_rear_grip", tuningdata.lid_rear_grip, "lid_trigger", tuningdata.lid_trigger, "lid_extra", tuningdata.lid_extra, "tv_receiver", tuningdata.tv_receiver, "tv_front_piece", tuningdata.tv_front_piece, "tv_back_piece", tuningdata.tv_back_piece, "tv_magazine", tuningdata.tv_magazine, "tv_optic", tuningdata.tv_optic, "tv_underbarrel", tuningdata.tv_underbarrel, "tv_modifier", tuningdata.tv_modifier, "tv_muzzle", tuningdata.tv_muzzle, "tv_rear_grip", tuningdata.tv_rear_grip, "tv_trigger", tuningdata.tv_trigger, "tv_extra", tuningdata.tv_extra, "is_bp_tuned", tuningdata.tuned, "weapon_lootid", weaponlootid, "is_a_blueprint_weapon", var_e96a2497012e529b, "blueprint_id", blueprintid, "blueprint_name", blueprintname, "is_player_tuned", isplayertuned, "is_pro_tuned", isprotuned, "camo_equipped_id", camoidequipped, "weapon_setup_attachment_0", weaponattachmentsetup[0], "weapon_setup_attachment_1", weaponattachmentsetup[1], "weapon_setup_attachment_2", weaponattachmentsetup[2], "weapon_setup_attachment_3", weaponattachmentsetup[3], "weapon_setup_attachment_4", weaponattachmentsetup[4], "weapon_rank_start", startweaponrank, "weapon_rank_end", endweaponrank, "weapon_unique_session_event_id", var_7249f84dc6294efa, "primary_amp_data", primaryampdata, "secondary_amp_data", secondaryampdata, "wall_bangs", player getpersstat("wallbangs"), "weapon_group", weapongroup]);

    if(getgametype() == "ob" || getgametype() == "ob_rift_run") {
      player dlog_recordplayerevent("dlog_event_ob_player_weapon_stats", ["weapon", datastruct.weapon, "weapon_normal_zombie_kills", weapon_normal_zombie_kills, "weapon_special_zombie_kills", weapon_special_zombie_kills, "weapon_elite_zombie_kills", weapon_elite_zombie_kills, "weapon_boss_zombie_kills", weapon_boss_zombie_kills, "weapon_pack_a_punch_kills", weapon_pack_a_punch_kills, "weapon_critical_kills", weapon_critical_kills, "weapon_soldier_kills", weapon_soldier_kills, "weapon_white_rarity_kills", weapon_white_rarity_kills, "weapon_green_rarity_kills", weapon_green_rarity_kills, "weapon_blue_rarity_kills", weapon_blue_rarity_kills, "weapon_purple_rarity_kills", weapon_purple_rarity_kills, "weapon_orange_rarity_kills", weapon_orange_rarity_kills, "weapon_unique_session_event_id", var_7249f84dc6294efa]);
    }

    if(isDefined(player.pers["telemetry"].player_weapon_stats_count) && istrue(var_d3cf11436c80a43e)) {
      player.pers["telemetry"].player_weapon_stats_count++;
    }

    if(isDefined(player.pers["telemetry"].var_a3ef8d971ec61fc7)) {
      player.pers["telemetry"].var_a3ef8d971ec61fc7++;
    }
  }
}

function function_b4ed203552f83bca(weapon) {
  data = spawnStruct();
  data.tuned = 0;
  data.weapon_receiver = "";
  data.lid_receiver = 0;
  data.tv_receiver = [0, 0];
  data.weapon_front_piece = "";
  data.lid_front_piece = 0;
  data.tv_front_piece = [0, 0];
  data.weapon_back_piece = "";
  data.lid_back_piece = 0;
  data.tv_back_piece = [0, 0];
  data.weapon_magazine = "";
  data.lid_magazine = 0;
  data.tv_magazine = [0, 0];
  data.weapon_optic = "";
  data.lid_optic = 0;
  data.tv_optic = [0, 0];
  data.weapon_underbarrel = "";
  data.lid_underbarrel = 0;
  data.tv_underbarrel = [0, 0];
  data.weapon_modifier = "";
  data.lid_modifier = 0;
  data.tv_modifier = [0, 0];
  data.weapon_muzzle = "";
  data.lid_muzzle = 0;
  data.tv_muzzle = [0, 0];
  data.weapon_rear_grip = "";
  data.lid_rear_grip = 0;
  data.tv_rear_grip = [0, 0];
  data.weapon_trigger = "";
  data.lid_trigger = 0;
  data.tv_trigger = [0, 0];
  data.weapon_extra = "";
  data.lid_extra = 0;
  data.tv_extra = [0, 0];

  if(!isDefined(weapon)) {
    return data;
  }

  if(isDefined(weapon.blueprinttuned)) {
    data.tuned = weapon.blueprinttuned;
  }

  basename = weapon.basename;
  var_75a7008e426d90db = weapon.var_75a7008e426d90db;
  receiver = weapon.receiver;

  if(isDefined(receiver)) {
    data.weapon_receiver = receiver;
    data.lid_receiver = getattachmentlootid(basename, receiver);
    var_91508dc8cd30163e = var_75a7008e426d90db[receiver];

    if(isDefined(var_91508dc8cd30163e)) {
      var_47681252dc0d55dd = var_91508dc8cd30163e[0];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_receiver[0] = -1e+06;
      } else {
        data.tv_receiver[0] = var_47681252dc0d55dd;
      }

      var_47681252dc0d55dd = var_91508dc8cd30163e[1];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_receiver[1] = -1e+06;
      } else {
        data.tv_receiver[1] = var_47681252dc0d55dd;
      }
    }
  }

  frontpiece = weapon.frontpiece;

  if(isDefined(frontpiece)) {
    data.weapon_front_piece = frontpiece;
    data.lid_front_piece = getattachmentlootid(basename, frontpiece);
    var_91508dc8cd30163e = var_75a7008e426d90db[frontpiece];

    if(isDefined(var_91508dc8cd30163e)) {
      var_47681252dc0d55dd = var_91508dc8cd30163e[0];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_front_piece[0] = -1e+06;
      } else {
        data.tv_front_piece[0] = var_47681252dc0d55dd;
      }

      var_47681252dc0d55dd = var_91508dc8cd30163e[1];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_front_piece[1] = -1e+06;
      } else {
        data.tv_front_piece[1] = var_47681252dc0d55dd;
      }
    }
  }

  backpiece = weapon.backpiece;

  if(isDefined(backpiece)) {
    data.weapon_back_piece = backpiece;
    data.lid_back_piece = getattachmentlootid(basename, backpiece);
    var_91508dc8cd30163e = var_75a7008e426d90db[backpiece];

    if(isDefined(var_91508dc8cd30163e)) {
      var_47681252dc0d55dd = var_91508dc8cd30163e[0];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_back_piece[0] = -1e+06;
      } else {
        data.tv_back_piece[0] = var_47681252dc0d55dd;
      }

      var_47681252dc0d55dd = var_91508dc8cd30163e[1];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_back_piece[1] = -1e+06;
      } else {
        data.tv_back_piece[1] = var_47681252dc0d55dd;
      }
    }
  }

  magazine = weapon.magazine;

  if(isDefined(magazine)) {
    data.weapon_magazine = magazine;
    data.lid_magazine = getattachmentlootid(basename, magazine);
    var_91508dc8cd30163e = var_75a7008e426d90db[magazine];

    if(isDefined(var_91508dc8cd30163e)) {
      var_47681252dc0d55dd = var_91508dc8cd30163e[0];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_magazine[0] = -1e+06;
      } else {
        data.tv_magazine[0] = var_47681252dc0d55dd;
      }

      var_47681252dc0d55dd = var_91508dc8cd30163e[1];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_magazine[1] = -1e+06;
      } else {
        data.tv_magazine[1] = var_47681252dc0d55dd;
      }
    }
  }

  scope = weapon.scope;

  if(isDefined(scope)) {
    data.weapon_optic = scope;
    data.lid_optic = getattachmentlootid(basename, scope);
    var_91508dc8cd30163e = var_75a7008e426d90db[scope];

    if(isDefined(var_91508dc8cd30163e)) {
      var_47681252dc0d55dd = var_91508dc8cd30163e[0];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_optic[0] = -1e+06;
      } else {
        data.tv_optic[0] = var_47681252dc0d55dd;
      }

      var_47681252dc0d55dd = var_91508dc8cd30163e[1];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_optic[1] = -1e+06;
      } else {
        data.tv_optic[1] = var_47681252dc0d55dd;
      }
    }
  }

  underbarrel = weapon.underbarrel;

  if(isDefined(underbarrel)) {
    data.weapon_underbarrel = underbarrel;
    data.lid_underbarrel = getattachmentlootid(basename, underbarrel);
    var_91508dc8cd30163e = var_75a7008e426d90db[underbarrel];

    if(isDefined(var_91508dc8cd30163e)) {
      var_47681252dc0d55dd = var_91508dc8cd30163e[0];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_underbarrel[0] = -1e+06;
      } else {
        data.tv_underbarrel[0] = var_47681252dc0d55dd;
      }

      var_47681252dc0d55dd = var_91508dc8cd30163e[1];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_underbarrel[1] = -1e+06;
      } else {
        data.tv_underbarrel[1] = var_47681252dc0d55dd;
      }
    }
  }

  modifier = weapon.modifier;

  if(isDefined(modifier)) {
    data.weapon_modifier = modifier;
    data.lid_modifier = getattachmentlootid(basename, modifier);
    var_91508dc8cd30163e = var_75a7008e426d90db[modifier];

    if(isDefined(var_91508dc8cd30163e)) {
      var_47681252dc0d55dd = var_91508dc8cd30163e[0];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_modifier[0] = -1e+06;
      } else {
        data.tv_modifier[0] = var_47681252dc0d55dd;
      }

      var_47681252dc0d55dd = var_91508dc8cd30163e[1];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_modifier[1] = -1e+06;
      } else {
        data.tv_modifier[1] = var_47681252dc0d55dd;
      }
    }
  }

  muzzle = weapon.muzzle;

  if(isDefined(muzzle)) {
    data.weapon_muzzle = muzzle;
    data.lid_muzzle = getattachmentlootid(basename, muzzle);
    var_91508dc8cd30163e = var_75a7008e426d90db[muzzle];

    if(isDefined(var_91508dc8cd30163e)) {
      var_47681252dc0d55dd = var_91508dc8cd30163e[0];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_muzzle[0] = -1e+06;
      } else {
        data.tv_muzzle[0] = var_47681252dc0d55dd;
      }

      var_47681252dc0d55dd = var_91508dc8cd30163e[1];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_muzzle[1] = -1e+06;
      } else {
        data.tv_muzzle[1] = var_47681252dc0d55dd;
      }
    }
  }

  reargrip = weapon.reargrip;

  if(isDefined(reargrip)) {
    data.weapon_reargrip = reargrip;
    data.lid_reargrip = getattachmentlootid(basename, reargrip);
    var_91508dc8cd30163e = var_75a7008e426d90db[reargrip];

    if(isDefined(var_91508dc8cd30163e)) {
      var_47681252dc0d55dd = var_91508dc8cd30163e[0];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_reargrip[0] = -1e+06;
      } else {
        data.tv_reargrip[0] = var_47681252dc0d55dd;
      }

      var_47681252dc0d55dd = var_91508dc8cd30163e[1];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_reargrip[1] = -1e+06;
      } else {
        data.tv_reargrip[1] = var_47681252dc0d55dd;
      }
    }
  }

  trigger = weapon.trigger;

  if(isDefined(trigger)) {
    data.weapon_trigger = trigger;
    data.lid_trigger = getattachmentlootid(basename, trigger);

    if(isDefined(var_75a7008e426d90db[trigger])) {
      var_47681252dc0d55dd = var_91508dc8cd30163e[0];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_trigger[0] = -1e+06;
      } else {
        data.tv_trigger[0] = var_47681252dc0d55dd;
      }

      var_47681252dc0d55dd = var_91508dc8cd30163e[1];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_trigger[1] = -1e+06;
      } else {
        data.tv_trigger[1] = var_47681252dc0d55dd;
      }
    }
  }

  extra = weapon.extra;

  if(isDefined(extra)) {
    data.weapon_extra = extra;
    data.lid_extra = getattachmentlootid(basename, extra);
    var_91508dc8cd30163e = var_75a7008e426d90db[extra];

    if(isDefined(var_91508dc8cd30163e)) {
      var_47681252dc0d55dd = var_91508dc8cd30163e[0];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_extra[0] = -1e+06;
      } else {
        data.tv_extra[0] = var_47681252dc0d55dd;
      }

      var_47681252dc0d55dd = var_91508dc8cd30163e[1];

      if(!isDefined(var_47681252dc0d55dd) || !isfloat(var_47681252dc0d55dd)) {
        assert("<dev string:xe2>");
        data.tv_extra[1] = -1e+06;
      } else {
        data.tv_extra[1] = var_47681252dc0d55dd;
      }
    }
  }

  return data;
}

function update_weapon_stats(data) {
  currenttime = namespace_de6e6777b0937bd7::function_1b15450e092933cf(gettime());

  if(currenttime <= 0 && (!isDefined(self.loadoutindex) || self.loadoutindex == -1)) {
    return;
  }

  if(!isDefined(self.pers) || !isDefined(scripts\mp\utility\stats::getpersstat("weaponStats"))) {
    return;
  }

  if(iskillstreakweapon(data.weaponname) || isvehicleweapon(data.weaponname) || isfistsonly(data.weaponname)) {
    return;
  }

  key = data.fullweaponname;

  if(!isDefined(scripts\mp\utility\stats::getpersstat("weaponStats")[key])) {
    var_fc0c136f54847d43 = getdvarint(@ "hash_817f686503ccdecf", 5);

    if(scripts\mp\utility\stats::getpersstat("weaponStats").size >= var_fc0c136f54847d43) {
      function_8076b5556f48a6cd(self);
      self.pers["weaponStats"] = [];
    }

    if(data.fullweaponname == "agent_mp") {
      weaponattachments = [];
    } else {
      var_2ba4a91944e009e8 = getweaponattachments(data.fullweaponname);
      weaponattachments = attachmentsfilterforstats(var_2ba4a91944e009e8, data.fullweaponname);
    }

    ispickedup = -1;

    if(namespace_de6e6777b0937bd7::is_valid_client(self)) {
      ispickedup = ispickedupweapon(data.fullweaponname);
    }

    loadoutindex = -1;

    if(isDefined(self.loadoutindex) && !ispickedup) {
      loadoutindex = self.loadoutindex;
    }

    newentry = spawnStruct();
    newentry.stats = [];
    newentry.weapon = data.weaponname;
    newentry.weaponattachments = weaponattachments;
    newentry.loadoutindex = loadoutindex;
    newentry.ispickedup = ispickedup;
    newentry.weaponobj = data.weaponobj;

    if(isDefined(data.variantid)) {
      newentry.variantid = data.variantid;
    } else {
      newentry.variantid = -1;
    }

    self.pers["weaponStats"][key] = newentry;
  }

  if(!isDefined(scripts\mp\utility\stats::getpersstat("weaponStats")[key].stats[data.statname])) {
    self.pers["weaponStats"][key].stats[data.statname] = data.incvalue;
  } else {
    self.pers["weaponStats"][key].stats[data.statname] = self.pers["weaponStats"][key].stats[data.statname] + data.incvalue;
  }

  if(data.statname == "shots") {
    self.pers["telemetry"].shots = self.pers["telemetry"].shots + data.incvalue;
    return;
  }

  if(data.statname == "hits") {
    self.pers["telemetry"].hits = self.pers["telemetry"].hits + data.incvalue;
  }
}

function function_ac6b649326f4b17e(data) {
  assertex(scripts\cp_mp\utility\game_utility::isgameparticipant(data.player), "<dev string:x151>" + data.player.code_classname);
  player = data.player;

  if(scripts\cp_mp\utility\game_utility::isgameparticipant(player) == 0) {
    return;
  }

  if(!namespace_de6e6777b0937bd7::is_valid_client(player)) {
    return;
  }

  if(isbot(player) || istestclient(player) || isai(player)) {
    return;
  }

  timefrommatchstart = namespace_de6e6777b0937bd7::function_1b15450e092933cf(gettime());
  scoreevent = data.scoreevent;

  if(isxhash(scoreevent)) {
    scoreevent = getxhashhexname(scoreevent);
  }

  var_d3cf11436c80a43e = player dlog_recordplayerevent("dlog_event_mp_player_score_event", ["time_from_match_start_ms", timefrommatchstart, "score_event", scoreevent]);

  if(isDefined(player scripts\mp\utility\stats::getpersstat("telemetry").player_score_event_count) && istrue(var_d3cf11436c80a43e)) {
    player.pers["telemetry"].player_score_event_count++;
  }
}

function on_reload_cancel(data) {
  player = data.player;
  cancelreason = data.cancelreason;
  reloadtimestart = data.reloadcanceltime;
  var_f325fe524d4336b = player function_3b6bbfec65cc4ee3();

  if(!var_f325fe524d4336b) {
    return;
  }

  if(!namespace_de6e6777b0937bd7::is_valid_client(player)) {
    return;
  }

  if(isbot(player) || istestclient(player) || isai(player)) {
    return;
  }

  if(!isDefined(cancelreason)) {
    cancelreason = "DEFAULT";
  }

  player dlog_recordplayerevent("dlog_event_reload_cancel_reason", ["reload_cancel_time", reloadtimestart, "reload_canceled", 1, "reload_cancel_type", cancelreason]);
}

function on_game_event(data) {
  player = undefined;
  lifeindex = -1;

  if(isDefined(data.player) && namespace_de6e6777b0937bd7::is_valid_client(data.player) && scripts\cp_mp\utility\game_utility::isgameparticipant(data.player)) {
    player = data.player;

    if(isDefined(data.player scripts\mp\utility\stats::getpersstat("telemetry").life.life_index)) {
      lifeindex = data.player scripts\mp\utility\stats::getpersstat("telemetry").life.life_index;
    }
  }

  timefrommatchstart = namespace_de6e6777b0937bd7::function_1b15450e092933cf(gettime());
  dlog_recordevent("dlog_event_mp_game_event", ["client", player, "event_name", data.eventname, "time_from_match_start_ms", timefrommatchstart, "player_life_index", lifeindex, "pos_x", data.position[0], "pos_y", data.position[1], "pos_z", data.position[2]]);

  if(isDefined(game["telemetry"]) && isDefined(game["telemetry"].game_event_count)) {
    game["telemetry"].game_event_count++;
  }
}

function private function_1a88d4daa0cb7e1f(mainreason, specificreason) {
  var_57549abbd404feb4 = [];
  var_57549abbd404feb4["armor_plate_done"] = "NONE";
  var_57549abbd404feb4["death"] = "DEATH";
  var_57549abbd404feb4["mantle_start"] = "MANTLE_STARTED";
  var_57549abbd404feb4["last_stand_start"] = "LAST_STAND_STARTED";
  var_57549abbd404feb4["scr_change_swim_state"] = "SWIM_STATE_CHANGED";
  var_57549abbd404feb4["special_weapon_fired"] = "SPECIAL_WEAPON_FIRED";
  var_57549abbd404feb4["try_armor_cancel"] = [];
  var_57549abbd404feb4["try_armor_cancel"]["damage_received"] = "DAMAGE_RECEIVED";
  var_57549abbd404feb4["try_armor_cancel"]["parachuting"] = "PARACHUTING";
  var_57549abbd404feb4["try_armor_cancel"]["last_stand_reviver_start"] = "LAST_STAND_REVIVER_STARTED";
  var_57549abbd404feb4["try_armor_cancel"]["armory_kiosk_used"] = "ARMORY_KIOSK_USED";
  var_57549abbd404feb4["try_armor_cancel"]["interrogation_interrogator_start"] = "INTERROGATION_INTERROGATOR_STARTED";
  var_57549abbd404feb4["try_armor_cancel"]["vehicle_enter"] = "VEHICLE_ENTER";
  var_57549abbd404feb4["try_armor_cancel"]["game_end"] = "GAME_END";
  var_57549abbd404feb4["try_armor_cancel"]["all_armor_plates_dropped"] = "ALL_ARMOR_PLATES_DROPPED";
  var_57549abbd404feb4["try_armor_cancel"]["loadout_open"] = "LOADOUT_OPEN";
  var_57549abbd404feb4["try_armor_cancel"]["ladder_used"] = "LADDER_USED";
  var_57549abbd404feb4["try_armor_cancel"]["player_switched_weapon"] = "PLAYER_SWITCHED_WEAPON";
  var_57549abbd404feb4["try_armor_cancel"]["player_switched_to_grenade"] = "PLAYER_SWITCHED_TO_GRENADE";
  var_57549abbd404feb4["try_armor_cancel"]["player_interaction"] = "PLAYER_DIRECT_ACTION";
  var_57549abbd404feb4["try_armor_cancel"]["armor_unselected"] = "OTHER_ARMOR_UNSELECTED";
  var_6058620ee3a64145 = var_57549abbd404feb4[mainreason];

  if(isDefined(var_6058620ee3a64145) && isarray(var_6058620ee3a64145)) {
    var_6058620ee3a64145 = var_57549abbd404feb4[mainreason][specificreason];
  }

  if(!isDefined(var_6058620ee3a64145)) {
    var_6058620ee3a64145 = "OTHER";
  }

  return var_6058620ee3a64145;
}

function on_player_armor_auto_apply(data) {
  if(!namespace_de6e6777b0937bd7::is_valid_client(data.player)) {
    return;
  }

  data.player dlog_recordplayerevent("dlog_event_player_armor_auto_equip_cancel", ["cancel_reason", function_1a88d4daa0cb7e1f(data.mainreason, data.specificreason)]);
}

function dmz_on_exfil(data) {
  data.player dlog_recordplayerevent("dlog_event_dmz_player_extraction_complete", ["team", data.current_team, "player_x", data.x, "player_y", data.y, "player_z", data.z, "player_pitch", data.xrot, "player_yaw", data.yrot, "player_roll", data.zrot, "lpcon_level", data.lpconlevel, "match_time_elapsed", data.matchtimeelapsed, "extraction_type", data.extractiontype, "cash_total", data.cashtotal, "backpack_items", data.backpackitems, "stowed_weapon", data.stowedweapon, "loadout_items", data.loadoutitems, "mission_1_status", data.mission1status, "mission_2_status", data.mission2status, "mission_3_status", data.mission3status, "new_items_unlocked", data.newitemsunlocked, "exfilstreak", data.exfilstreak]);
}

function dmz_on_container(data) {
  data.player dlog_recordplayerevent("dlog_event_dmz_container_open", ["team", data.current_team, "player_x", data.x, "player_y", data.y, "player_z", data.z, "player_pitch", data.xrot, "player_yaw", data.yrot, "player_roll", data.zrot, "lpcon_level", data.lpconlevel, "match_time_elapsed", data.matchtimeelapsed, "item_ids", data.itemids, "item_counts", data.itemcounts, "container_type", data.container_type]);
}

function dmz_contract(data) {
  data.player dlog_recordplayerevent("dlog_event_dmz_contract_complete", ["contract_name", data.activity_name, "result", data.result, "team", data.teamid, "endx", data.x, "endy", data.y, "endz", data.z, "startx", data.contractoriginx, "starty", data.contractoriginy, "startz", data.contractoriginz, "poi", data.poi]);
}

function function_260df5ddbfebac5f(player) {
  current_team = "unset";

  if(isDefined(player.sessionteam)) {
    current_team = player.sessionteam;
  }

  if(isDefined(player.team)) {
    current_team = player.team;
  }

  return current_team;
}

function function_1ef65d2654424502(activity, result, var_5e671fc71e72d5e8) {
  if(!isDefined(activity)) {
    return;
  }

  if(!isDefined(activity.name)) {
    return;
  }

  if(!isDefined(result)) {
    result = "fail";
  }

  players = scripts\mp\utility\teams::getteamdata(var_5e671fc71e72d5e8, "players");

  foreach(player in players) {
    current_team = function_260df5ddbfebac5f(player);
    data = spawnStruct();
    data.activity_name = activity.name;
    data.player = player;
    data.result = result;
    data.teamid = current_team;
    data.x = player.origin[0];
    data.y = player.origin[1];
    data.z = player.origin[2];
    data.contractoriginx = activity.origin[0];
    data.contractoriginy = activity.origin[1];
    data.contractoriginz = activity.origin[2];
    data.poi = activity.poi;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_dmz_contract", data);
  }
}

function dmz_on_reinforce(data) {
  if(!isDefined(data)) {
    return;
  }

  if(!isDefined(data.agents)) {
    return;
  }

  matchtime = int(getsecondspassed());
  location = data.reinforceorigin;

  if(!isDefined(location)) {
    location = (0, 0, 0);
  }

  poi = data.poi;

  if(!isDefined(poi)) {
    poi = "none";
  }

  agentlist = [];

  foreach(agent in data.agents) {
    if(isDefined(agent.agent_type)) {
      agentlist[agentlist.size] = agent.agent_type;
    }
  }

  lpconlevel = "0";

  if(isDefined(level.var_a7b62649c81b481a) && isDefined(level.var_a7b62649c81b481a.var_acc161de36707de2)) {
    lpconlevel = scripts\engine\utility::string(level.var_a7b62649c81b481a.var_acc161de36707de2);
  }

  dlog_recordevent("dlog_event_dmz_reinforcement_triggered", ["time_elapsed", matchtime, "lpcon_level", lpconlevel, "pos_x", location[0], "pos_y", location[1], "pos_z", location[2], "poi", poi, "agents", agentlist]);
}

function function_532119a556885727(data) {
  matchtimeelapsed = -1;

  if(isDefined(data.matchtimeelapsed)) {
    matchtimeelapsed = data.matchtimeelapsed;
  }

  teamsremaining = -1;

  if(isDefined(data.teamsremaining)) {
    teamsremaining = data.teamsremaining;
  }

  agentskilled = -1;

  if(isDefined(data.agentskilled)) {
    agentskilled = data.agentskilled;
  }

  lpconlevel = #"undefined";

  if(isDefined(data.lpconlevel)) {
    lpconlevel = namespace_500325c20d920621::function_c43f9411e4146fbd();
  }

  dlog_recordevent("dlog_event_dmz_biolab_lpcon", ["match_time_elapsed", matchtimeelapsed, "teams_remaining", teamsremaining, "agents_killed", agentskilled, "lpcon_level", lpconlevel]);
}

function function_ccb453b7ef932cea(weaponobj) {
  if(!isDefined(weaponobj)) {
    return "invalid";
  }

  if(isDefined(weaponobj.weaponblueprint) && isDefined(weaponobj.weaponblueprint.lootid)) {
    return utility::string(weaponobj.weaponblueprint.lootid);
  }

  weaponref = weapon::function_23defc57f8da7fbc(weaponobj.basename);
  lootid = loot::getlootidfromref(weaponref);

  if(isDefined(lootid) && lootid != 0) {
    return utility::string(lootid);
  }

  if(isDefined(level.killstreakweaponmap) && isDefined(level.killstreakweaponmap[weaponobj.basename])) {
    lootid = loot::getlootidfromref(level.killstreakweaponmap[weaponobj.basename]);

    if(isDefined(lootid) && lootid != 0) {
      return utility::string(lootid);
    }
  }

  superref = supers::getsuperrefforsuperweapon(weaponobj);
  lootid = loot::getlootidfromref(superref);

  if(isDefined(lootid) && lootid != 0) {
    return utility::string(lootid);
  }

  equipmentref = equipment::getequipmentreffromweapon(weaponobj);
  lootid = loot::getlootidfromref(equipmentref);

  if(isDefined(lootid) && lootid != 0) {
    return utility::string(lootid);
  }

  weaponref = weapon::getweaponrootname(weaponobj);
  lootid = loot::getlootidfromref(weaponref);

  if(isDefined(lootid) && lootid != 0) {
    return utility::string(lootid);
  }

  return "invalid";
}

function function_deef6a4f7fbec3b8(weaponobj) {
  ampdata = [];
  ampdata[0] = "";
  ampdata[1] = "";
  ampdata[2] = "";
  ampdata[3] = "";
  ampdata[4] = "";
  ampdata[5] = "";
  ampdata[6] = "";
  ampdata[7] = "";
  ampdata[8] = "";
  ampdata[9] = "";
  ampdata[10] = "";
  ampdata[11] = "";
  ampdata[12] = "";

  if(isDefined(weaponobj)) {
    if(weaponobj hasattachment("jup_jp12_pi_mike93_bar_hvyconvert")) {
      ampdata[11] = "jup_jp12_pi_mike93_bar_hvyconvert";
      ampdata[1] = "jup_jp12_pi_mike93_bar_hvyconvert";
      ampdata[5] = "jup_jp12_mike93_grip_amp_vert";
      ampdata[2] = "jup_jp12_pi_mike93_stock";
      ampdata[4] = "jup_mike93_ironsdefault_stockp";
    } else if(weaponobj hasattachment("jup_bromeo2m_amp")) {
      ampdata[11] = "jup_bromeo2m_amp";
      ampdata[0] = "jup_bromeo2m_rec";
      ampdata[6] = "ammo_762s";
      ampdata[1] = "jup_jp02_ar_bromeo2m_bar_heavy_short";
      ampdata[2] = "jup_jp02_br_bromeo2_stock_folding";
      ampdata[3] = "jup_jp02_ar_bromeo2m_mag_30_762s";
      ampdata[4] = "jup_bromeo2m_ironsdefault";
      ampdata[8] = "jup_jp02_br_bromeo2_pgrip_ass";
    } else if(weaponobj hasattachment("jup_cp24_sm_glima21_bar_convert")) {
      ampdata[11] = "jup_cp24_sm_glima21_bar_convert";
      ampdata[1] = "jup_cp24_sm_glima21_bar_convert";
    } else if(weaponobj hasattachment("jup_pkilop_amp_bull")) {
      ampdata[11] = "jup_pkilop_amp_bull";
      ampdata[1] = "jup_jp06_lm_pkilob_bar_bullshort";
      ampdata[2] = "jup_jp06_lm_pkilob_stock_pad";
      ampdata[3] = "jup_jp06_lm_pkilob_belt_100_762n";
      ampdata[4] = "jup_pkilob_ironsdefault";
      ampdata[0] = "jup_pkilob_rec";
    } else if(weaponobj hasattachment("jup_jp07_sm_uzulu_22_45acp")) {
      ampdata[11] = "jup_jp07_sm_uzulu_22_45acp";
      ampdata[1] = "jup_jp07_sm_uzulu_bar_amp_45";
      ampdata[2] = "jup_jp07_sm_uzulu_stock_amp_45";
      ampdata[3] = "jup_jp07_sm_uzulu_22_45acp";
      ampdata[6] = "ammo_45acp";
      ampdata[0] = "jup_uzulu_rec_amp";
      ampdata[5] = "jup_grip_uzulup1_amp";
    } else if(weaponobj hasattachment("jup_jp07_sm_uzulup_stock_brace")) {
      ampdata[11] = "jup_jp07_sm_uzulup_stock_brace";
      ampdata[2] = "jup_jp07_sm_uzulup_stock_brace";
      ampdata[12] = "jup_uzulup_akimbo";
    } else if(weaponobj hasattachment("jup_acharlie_amp_300blk")) {
      ampdata[11] = "jup_acharlie_amp_300blk";
      ampdata[0] = "jup_acharlie300_rec";
      ampdata[6] = "ammo_blk";
      ampdata[1] = "jup_jp19_ar_acharlie300_bar_lgtlong";
      ampdata[2] = "jup_jp19_ar_acharlie300_stockno";
      ampdata[3] = "jup_jp19_ar_acharlie300_mag_30_blk";
      ampdata[4] = "jup_acharlie300_ironsdefault";
      ampdata[8] = "jup_jp19_ar_acharlie300_pgrip_ass";
    } else if(weaponobj hasattachment("jup_jp08_ar_qbravo95_amp_t95")) {
      ampdata[11] = "jup_jp08_ar_qbravo95_amp_t95";
      ampdata[0] = "jup_qbravo95_rec";
      ampdata[1] = "jup_jp08_ar_qbravo95_bar";
      ampdata[3] = "jup_jp08_ar_qbravo95_mag_30_58";
      ampdata[4] = "jup_qbravo95_ironsdefault";
      ampdata[8] = "jup_jp08_ar_qbravo95_pgrip";
    } else if(weaponobj hasattachment("jup_jp19_dm_acharlied_mag_20_68r_amp")) {
      ampdata[11] = "jup_jp19_dm_acharlied_mag_20_68r_amp";
      ampdata[0] = "jup_acharlied_amp_rec";
      ampdata[2] = "jup_jp19_dm_acharlied_stock_tacheavy";
      ampdata[12] = "jup_acharlied_selectauto";
    } else if(weaponobj hasattachment("jup_jp14_pi_rsierra12_bar_amp")) {
      ampdata[11] = "jup_jp14_pi_rsierra12_bar_amp";
      ampdata[0] = "jup_rsierra12_convert_rec";
      ampdata[2] = "jup_jp14_pi_rsierra12_stock_amp";
      ampdata[8] = "jup_jp14_pi_rsierra12_pgrip_amp";
      ampdata[4] = "jup_rsierra12_irons_stock";
    } else if(weaponobj hasattachment("jup_jp19_br_acharlie450_drum_50_450b")) {
      ampdata[11] = "jup_jp19_br_acharlie450_drum_50_450b";
      ampdata[0] = "jup_acharlie450_rec_amp";
    } else if(weaponobj hasattachment("jup_jp02_sm_scharlie3_bar_amp")) {
      ampdata[11] = "jup_jp02_sm_scharlie3_bar_amp";
      ampdata[0] = "jup_scharlie3_rec_amp";
      ampdata[7] = "jup_comp_sm_14_amp";
    } else if(weaponobj hasattachment("jup_jp01_ar_golf36_bar_amp")) {
      ampdata[11] = "jup_jp01_ar_golf36_bar_amp";
      ampdata[0] = "jup_golf36_rec_amp";
      ampdata[4] = "jup_reflex08_tall_amp";
    } else if(weaponobj hasattachment("jup_jp01_dm_slima8_bar_amp")) {
      ampdata[11] = "jup_jp01_dm_slima8_bar_amp";
      ampdata[0] = "jup_slima8_rec_amp";
      ampdata[4] = "jup_reflex08_tall_amp";
    } else if(weaponobj hasattachment("jup_cp01_sm_coscar635_bar_amp")) {
      ampdata[11] = "jup_cp01_sm_coscar635_bar_amp";
      ampdata[0] = "jup_coscar635_amp_rec";
    }
  }

  return ampdata;
}

function function_42db4e92349e1fee(data) {
  data.player dlog_recordplayerevent("dlog_event_player_the_hunt_report", ["playlist_id", data.playlistid, "mode", data.mode, "sub_mode", data.sub_mode, "bones_zombies", data.bones_zombies, "skulls_armored_zombies", data.skulls_armored_zombies, "skulls_hellhounds", data.skulls_hellhounds, "skulls_mimics", data.skulls_mimics]);
}

function function_ecf05f99fb2be7a2(data) {
  if(getdvarint(@ "scr_countdown", 0)) {
    foreach(player in level.players) {
      if(isDefined(player) && !isbot(player) && isDefined(player.team) && player.team != "spectator" && player.team != "codcaster") {
        if(isDefined(player scripts\mp\utility\stats::getpersstat("telemetry")) && istrue(player scripts\mp\utility\stats::getpersstat("telemetry").var_f4c9967fb9b314f2)) {
          return;
        }

        playlistid = -1;
        mode = "undefined";
        sub_mode = "undefined";
        map = "undefined";
        items_collected_type_0 = 0;
        items_collected_type_1 = 0;
        items_collected_type_2 = 0;
        items_collected_type_3 = 0;
        items_collected_total = 0;
        playlistid = getplaylistid();
        mode = scripts\mp\utility\game::getgametype();
        sub_mode = scripts\mp\utility\game::getsubgametype();
        map = scripts\cp_mp\utility\game_utility::getmapname();

        if(isDefined(player.var_b982ceb2ab8a2f94)) {
          items_collected_type_0 = player.var_b982ceb2ab8a2f94;
        }

        if(isDefined(player.var_67439179191b54a3)) {
          items_collected_type_1 = player.var_67439179191b54a3;
        }

        if(isDefined(player.var_4fc80c2800aff392)) {
          items_collected_type_2 = player.var_4fc80c2800aff392;
        }

        if(isDefined(player.var_fc45de226f41cf01)) {
          items_collected_type_3 = player.var_fc45de226f41cf01;
        }

        items_collected_total = items_collected_type_0 + items_collected_type_1 + items_collected_type_2 + items_collected_type_3;
        player.pers["telemetry"].var_f4c9967fb9b314f2 = 1;
        player dlog_recordplayerevent("dlog_event_player_countdown", ["playlist_id", playlistid, "mode", mode, "sub_mode", sub_mode, "map", map, "items_collected_type_0", items_collected_type_0, "items_collected_type_1", items_collected_type_1, "items_collected_type_2", items_collected_type_2, "items_collected_type_3", items_collected_type_3, "items_collected_total", items_collected_total]);
      }
    }
  }
}

function function_cf6a68bcdfd1f403(data) {
  if(getdvarint(@ "scr_countdown", 0)) {
    playlistid = -1;
    mode = "undefined";
    sub_mode = "undefined";
    map = "undefined";
    var_ef292cdf29d2d088 = 0;
    var_ef292ddf29d2d2bb = 0;
    var_ef292edf29d2d4ee = 0;
    var_ef292fdf29d2d721 = 0;
    var_3f65f47f472febaf = 0;
    var_3f65f37f472fe97c = 0;
    var_3f65f67f472ff015 = 0;
    var_3f65f57f472fede2 = 0;
    playlistid = getplaylistid();
    mode = scripts\mp\utility\game::getgametype();
    sub_mode = scripts\mp\utility\game::getsubgametype();
    map = scripts\cp_mp\utility\game_utility::getmapname();

    if(isDefined(level.var_ea10260a5b2419f9)) {
      var_ef292cdf29d2d088 = level.var_ea10260a5b2419f9;
    }

    if(isDefined(level.var_3125ff37539a8b02)) {
      var_ef292ddf29d2d2bb = level.var_3125ff37539a8b02;
    }

    if(isDefined(level.var_7fbee291ee102c6b)) {
      var_ef292edf29d2d4ee = level.var_7fbee291ee102c6b;
    }

    if(isDefined(level.var_6141ba5646bcb9c4)) {
      var_ef292fdf29d2d721 = level.var_6141ba5646bcb9c4;
    }

    if(isDefined(level.var_73dbc3b2132b4b04)) {
      var_3f65f47f472febaf = level.var_73dbc3b2132b4b04;
    }

    if(isDefined(level.var_b6930f6a626cecb7)) {
      var_3f65f37f472fe97c = level.var_b6930f6a626cecb7;
    }

    if(isDefined(level.var_1337e1a54678ffc2)) {
      var_3f65f67f472ff015 = level.var_1337e1a54678ffc2;
    }

    if(isDefined(level.var_d01465a3daf800ed)) {
      var_3f65f57f472fede2 = level.var_d01465a3daf800ed;
    }

    dlog_recordevent("dlog_event_match_countdown", ["playlist_id", playlistid, "mode", mode, "sub_mode", sub_mode, "map", map, "items_dropped_type_0", var_ef292cdf29d2d088, "items_dropped_type_1", var_ef292ddf29d2d2bb, "items_dropped_type_2", var_ef292edf29d2d4ee, "items_dropped_type_3", var_ef292fdf29d2d721, "items_collected_type_0", var_3f65f47f472febaf, "items_collected_type_1", var_3f65f37f472fe97c, "items_collected_type_2", var_3f65f67f472ff015, "items_collected_type_3", var_3f65f57f472fede2]);
  }
}

function function_35a349228b74abc3(data) {
  if(getdvarint(@ "hash_b3da5c3cd4713168", 0)) {
    foreach(player in level.players) {
      if(isDefined(player) && !isbot(player) && isDefined(player.team) && player.team != "spectator" && player.team != "codcaster") {
        if(isDefined(player scripts\mp\utility\stats::getpersstat("telemetry")) && istrue(player scripts\mp\utility\stats::getpersstat("telemetry").var_2f7390b430deae3c)) {
          return;
        }

        playlistid = -1;
        mode = "undefined";
        sub_mode = "undefined";
        map = "undefined";
        items_collected_type_1 = 0;
        items_collected_type_2 = 0;
        items_collected_type_3 = 0;
        items_collected_type_4 = 0;
        items_collected_total = 0;
        playlistid = getplaylistid();
        mode = scripts\mp\utility\game::getgametype();
        sub_mode = scripts\mp\utility\game::getsubgametype();
        map = scripts\cp_mp\utility\game_utility::getmapname();

        if(isDefined(player.var_a626037fc1135883)) {
          items_collected_type_1 = player.var_a626037fc1135883;
        }

        if(isDefined(player.var_9e87abcf9e7e4df2)) {
          items_collected_type_2 = player.var_9e87abcf9e7e4df2;
        }

        if(isDefined(player.var_72620be67f8f3c61)) {
          items_collected_type_3 = player.var_72620be67f8f3c61;
        }

        if(isDefined(player.var_b6cf555814d1e58)) {
          items_collected_type_4 = player.var_b6cf555814d1e58;
        }

        items_collected_total = items_collected_type_1 + items_collected_type_2 + items_collected_type_3 + items_collected_type_4;
        player.pers["telemetry"].var_2f7390b430deae3c = 1;
        player dlog_recordplayerevent("dlog_event_player_altered_strain", ["playlist_id", playlistid, "mode", mode, "sub_mode", sub_mode, "map", map, "items_collected_type_1", items_collected_type_1, "items_collected_type_2", items_collected_type_2, "items_collected_type_3", items_collected_type_3, "items_collected_type_4", items_collected_type_4, "items_collected_total", items_collected_total]);
      }
    }
  }
}

function function_c97fa4f697e7e8b4(data) {
  if(getdvarint(@ "hash_b3da5c3cd4713168", 0)) {
    playlistid = -1;
    mode = "undefined";
    sub_mode = "undefined";
    map = "undefined";
    var_7101b826ffb065c9 = 0;
    var_7101b526ffb05f30 = 0;
    var_7101b626ffb06163 = 0;
    var_7101bb26ffb06c62 = 0;
    var_3c43348b455b969e = 0;
    var_3c43338b455b946b = 0;
    var_3c43328b455b9238 = 0;
    var_3c43398b455ba19d = 0;
    playlistid = getplaylistid();
    mode = scripts\mp\utility\game::getgametype();
    sub_mode = scripts\mp\utility\game::getsubgametype();
    map = scripts\cp_mp\utility\game_utility::getmapname();

    if(isDefined(level.var_bda7b509e0070322)) {
      var_7101b826ffb065c9 = level.var_bda7b509e0070322;
    }

    if(isDefined(level.var_4c8a9411af3d9e8b)) {
      var_7101b526ffb05f30 = level.var_4c8a9411af3d9e8b;
    }

    if(isDefined(level.var_6bef474a253283e4)) {
      var_7101b626ffb06163 = level.var_6bef474a253283e4;
    }

    if(isDefined(level.var_b63c2e64bc31f205)) {
      var_7101bb26ffb06c62 = level.var_b63c2e64bc31f205;
    }

    if(isDefined(level.var_83038e43b07056d7)) {
      var_3c43348b455b969e = level.var_83038e43b07056d7;
    }

    if(isDefined(level.var_cf161f4cfb70efe2)) {
      var_3c43338b455b946b = level.var_cf161f4cfb70efe2;
    }

    if(isDefined(level.var_15bdc538172e950d)) {
      var_3c43328b455b9238 = level.var_15bdc538172e950d;
    }

    if(isDefined(level.var_c38b6521a52c79c8)) {
      var_3c43398b455ba19d = level.var_c38b6521a52c79c8;
    }

    dlog_recordevent("dlog_event_match_altered_strain", ["playlist_id", playlistid, "mode", mode, "sub_mode", sub_mode, "map", map, "items_dropped_type_1", var_7101b826ffb065c9, "items_dropped_type_2", var_7101b526ffb05f30, "items_dropped_type_3", var_7101b626ffb06163, "items_dropped_type_4", var_7101bb26ffb06c62, "items_collected_type_1", var_3c43348b455b969e, "items_collected_type_2", var_3c43338b455b946b, "items_collected_type_3", var_3c43328b455b9238, "items_collected_type_4", var_3c43398b455ba19d]);
  }
}

function function_938463ee126f54fb(data) {
  if(function_966592fd716d49c7()) {
    foreach(player in level.players) {
      if(isDefined(player) && !isbot(player) && isDefined(player.team) && player.team != "spectator" && player.team != "codcaster") {
        if(isDefined(player scripts\mp\utility\stats::getpersstat("telemetry")) && istrue(player scripts\mp\utility\stats::getpersstat("telemetry").var_961b60ed894fc925)) {
          return;
        }

        playlistid = -1;
        mode = "undefined";
        sub_mode = "undefined";
        map = "undefined";
        pickups_collected_size_1 = 0;
        pickups_collected_size_2 = 0;
        pickups_collected_size_3 = 0;
        pickups_collected_size_undefined = 0;
        pickups_collected_combined = 0;
        pickups_collected_total_value_size_1 = 0;
        pickups_collected_total_value_size_2 = 0;
        pickups_collected_total_value_size_3 = 0;
        pickups_collected_total_value_size_undefined = 0;
        pickups_collected_total_value_combined = 0;
        playlistid = getplaylistid();
        mode = scripts\mp\utility\game::getgametype();
        sub_mode = scripts\mp\utility\game::getsubgametype();
        map = scripts\cp_mp\utility\game_utility::getmapname();

        if(isDefined(player.var_ee9bfea6c204ee1b)) {
          pickups_collected_size_1 = player.var_ee9bfea6c204ee1b;
        }

        if(isDefined(player.var_35f93f47b6c8e7d6)) {
          pickups_collected_size_2 = player.var_35f93f47b6c8e7d6;
        }

        if(isDefined(player.var_de86cab269eaee61)) {
          pickups_collected_size_3 = player.var_de86cab269eaee61;
        }

        if(isDefined(player.var_bdb2fe85c37c51c0)) {
          pickups_collected_size_undefined = player.var_bdb2fe85c37c51c0;
        }

        pickups_collected_combined = pickups_collected_size_1 + pickups_collected_size_2 + pickups_collected_size_3 + pickups_collected_size_undefined;

        if(isDefined(player.var_bc629c5fff0af845)) {
          pickups_collected_total_value_size_1 = player.var_bc629c5fff0af845;
        }

        if(isDefined(player.var_64479d98631b7f44)) {
          pickups_collected_total_value_size_2 = player.var_64479d98631b7f44;
        }

        if(isDefined(player.var_ea4ec8e5a8b097ab)) {
          pickups_collected_total_value_size_3 = player.var_ea4ec8e5a8b097ab;
        }

        if(isDefined(player.var_b812d573a696f26)) {
          pickups_collected_total_value_size_undefined = player.var_b812d573a696f26;
        }

        pickups_collected_total_value_combined = pickups_collected_total_value_size_1 + pickups_collected_total_value_size_2 + pickups_collected_total_value_size_3 + pickups_collected_total_value_size_undefined;
        player.pers["telemetry"].var_961b60ed894fc925 = 1;
        player dlog_recordplayerevent("dlog_event_player_trt", ["playlist_id", playlistid, "mode", mode, "sub_mode", sub_mode, "map", map, "pickups_collected_size_1", pickups_collected_size_1, "pickups_collected_size_2", pickups_collected_size_2, "pickups_collected_size_3", pickups_collected_size_3, "pickups_collected_size_undefined", pickups_collected_size_undefined, "pickups_collected_combined", pickups_collected_combined, "pickups_collected_total_value_size_1", pickups_collected_total_value_size_1, "pickups_collected_total_value_size_2", pickups_collected_total_value_size_2, "pickups_collected_total_value_size_3", pickups_collected_total_value_size_3, "pickups_collected_total_value_size_undefined", pickups_collected_total_value_size_undefined, "pickups_collected_total_value_combined", pickups_collected_total_value_combined]);
      }
    }
  }
}

function function_107edbf02a7ccd23(data) {
  if(function_966592fd716d49c7()) {
    playlistid = -1;
    mode = "undefined";
    sub_mode = "undefined";
    map = "undefined";
    pickups_dropped_size_1 = 0;
    pickups_dropped_size_2 = 0;
    pickups_dropped_size_3 = 0;
    pickups_dropped_size_undefined = 0;
    pickups_dropped_combined = 0;
    pickups_dropped_value_size_1 = 0;
    pickups_dropped_value_size_2 = 0;
    pickups_dropped_value_size_3 = 0;
    pickups_dropped_value_size_undefined = 0;
    pickups_dropped_value_combined = 0;
    pickups_collected_size_1 = 0;
    pickups_collected_size_2 = 0;
    pickups_collected_size_3 = 0;
    pickups_collected_size_undefined = 0;
    pickups_collected_combined = 0;
    pickups_collected_total_value_size_1 = 0;
    pickups_collected_total_value_size_2 = 0;
    pickups_collected_total_value_size_3 = 0;
    pickups_collected_total_value_size_undefined = 0;
    pickups_collected_total_value_combined = 0;
    playlistid = getplaylistid();
    mode = scripts\mp\utility\game::getgametype();
    sub_mode = scripts\mp\utility\game::getsubgametype();
    map = scripts\cp_mp\utility\game_utility::getmapname();

    if(isDefined(level.var_509a4e442b1026ae)) {
      pickups_dropped_size_1 = level.var_509a4e442b1026ae;
    }

    if(isDefined(level.var_ef645306c7d37997)) {
      pickups_dropped_size_2 = level.var_ef645306c7d37997;
    }

    if(isDefined(level.var_f32504269cbbbe30)) {
      pickups_dropped_size_3 = level.var_f32504269cbbbe30;
    }

    if(isDefined(level.var_ec8144a5f732f17d)) {
      pickups_dropped_size_undefined = level.var_ec8144a5f732f17d;
    }

    pickups_dropped_combined = pickups_dropped_size_1 + pickups_dropped_size_2 + pickups_dropped_size_3 + pickups_dropped_size_undefined;

    if(isDefined(level.var_3d9321fad7de61fc)) {
      pickups_dropped_value_size_1 = level.var_3d9321fad7de61fc;
    }

    if(isDefined(level.var_a57db3076bd3b939)) {
      pickups_dropped_value_size_2 = level.var_a57db3076bd3b939;
    }

    if(isDefined(level.var_4870c7ef3543bfe)) {
      pickups_dropped_value_size_3 = level.var_4870c7ef3543bfe;
    }

    if(isDefined(level.var_e4ccbbc61262c427)) {
      pickups_dropped_value_size_undefined = level.var_e4ccbbc61262c427;
    }

    pickups_dropped_value_combined = pickups_dropped_value_size_1 + pickups_dropped_value_size_2 + pickups_dropped_value_size_3 + pickups_dropped_value_size_undefined;

    if(isDefined(level.var_ee9bfea6c204ee1b)) {
      pickups_collected_size_1 = level.var_ee9bfea6c204ee1b;
    }

    if(isDefined(level.var_35f93f47b6c8e7d6)) {
      pickups_collected_size_2 = level.var_35f93f47b6c8e7d6;
    }

    if(isDefined(level.var_de86cab269eaee61)) {
      pickups_collected_size_3 = level.var_de86cab269eaee61;
    }

    if(isDefined(level.var_bdb2fe85c37c51c0)) {
      pickups_collected_size_undefined = level.var_bdb2fe85c37c51c0;
    }

    pickups_collected_combined = pickups_collected_size_1 + pickups_collected_size_2 + pickups_collected_size_3 + pickups_collected_size_undefined;

    if(isDefined(level.var_bc629c5fff0af845)) {
      pickups_collected_total_value_size_1 = level.var_bc629c5fff0af845;
    }

    if(isDefined(level.var_64479d98631b7f44)) {
      pickups_collected_total_value_size_2 = level.var_64479d98631b7f44;
    }

    if(isDefined(level.var_ea4ec8e5a8b097ab)) {
      pickups_collected_total_value_size_3 = level.var_ea4ec8e5a8b097ab;
    }

    if(isDefined(level.var_b812d573a696f26)) {
      pickups_collected_total_value_size_undefined = level.var_b812d573a696f26;
    }

    pickups_collected_total_value_combined = pickups_collected_total_value_size_1 + pickups_collected_total_value_size_2 + pickups_collected_total_value_size_3 + pickups_collected_total_value_size_undefined;
    dlog_recordevent("dlog_event_match_trt", ["playlist_id", playlistid, "mode", mode, "sub_mode", sub_mode, "map", map, "pickups_dropped_size_1", pickups_dropped_size_1, "pickups_dropped_size_2", pickups_dropped_size_2, "pickups_dropped_size_3", pickups_dropped_size_3, "pickups_dropped_size_undefined", pickups_dropped_size_undefined, "pickups_dropped_combined", pickups_dropped_combined, "pickups_dropped_value_size_1", pickups_dropped_value_size_1, "pickups_dropped_value_size_2", pickups_dropped_value_size_2, "pickups_dropped_value_size_3", pickups_dropped_value_size_3, "pickups_dropped_value_size_undefined", pickups_dropped_value_size_undefined, "pickups_dropped_value_combined", pickups_dropped_value_combined, "pickups_collected_size_1", pickups_collected_size_1, "pickups_collected_size_2", pickups_collected_size_2, "pickups_collected_size_3", pickups_collected_size_3, "pickups_collected_size_undefined", pickups_collected_size_undefined, "pickups_collected_combined", pickups_collected_combined, "pickups_collected_total_value_size_1", pickups_collected_total_value_size_1, "pickups_collected_total_value_size_2", pickups_collected_total_value_size_2, "pickups_collected_total_value_size_3", pickups_collected_total_value_size_3, "pickups_collected_total_value_size_undefined", pickups_collected_total_value_size_undefined, "pickups_collected_total_value_combined", pickups_collected_total_value_combined]);
  }
}

function private function_968a17536a9b61d3(origin, angles) {
  [map_name, game_type, sub_game_type, playlist_id, playlist_name, round_num] = namespace_7349d2dcd492da87::function_45d01d27e99f49d7();

  if(!isDefined(origin)) {
    origin[0] = -1;
    origin[1] = -1;
    origin[2] = -1;
  }

  if(!isDefined(angles)) {
    angles[0] = -1;
    angles[1] = -1;
    angles[2] = -1;
  }

  header = ["map", map_name, "game_type", game_type, "sub_game_type", sub_game_type, "playlist_id", playlist_id, "playlist_name", playlist_name, "round_num", round_num, "gametime", gettime(), "originx", origin[0], "originy", origin[1], "originz", origin[2], "angleyaw", angles[1], "anglepitch", angles[0]];
  return header;
}

function private function_97114a0080982e86(param) {
  if(!isDefined(param)) {
    param = "";
  } else if(isint(param) || isfloat(param)) {
    param = "" + param;
  }

  return param;
}

function function_b250bbe5574864ea(subevent, param0, param1, param2) {
  mp_header = function_968a17536a9b61d3();
  param0 = function_97114a0080982e86(param0);
  param1 = function_97114a0080982e86(param1);
  param2 = function_97114a0080982e86(param2);
  dlog_recordevent("dlog_event_mp_notifications", ["mp_header", mp_header, "sub_event", subevent, "param0", param0, "param1", param1, "param2", param2]);
}

function function_24a800e2ee3154e(subevent, param0, param1, param2) {
  mp_header = function_968a17536a9b61d3();
  param0 = function_97114a0080982e86(param0);
  param1 = function_97114a0080982e86(param1);
  param2 = function_97114a0080982e86(param2);
  self dlog_recordplayerevent("dlog_event_mp_notifications_player", ["mp_header", mp_header, "sub_event", subevent, "param0", param0, "param1", param1, "param2", param2]);
}

function function_f72669d7b1ecfba2() {
  wait 5;

  while(true) {
    level.players[0] scripts\common\debug::function_f9304b74bdeafdb0("DPAD_LEFT", "send_example_array_of_rows()");
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_example", {
      #my_string: "regular string example BBB", #my_int: 123456, #my_xhash_string: #"hash_21372455c009c541"});
    data = spawnStruct();
    data.my_xhash_string = #"hash_2b903a55c66076f6";
    data.my_int = -98765;
    data.my_string = "regular string example BBB";
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_example", data);
    level.players[0] function_24a800e2ee3154e("test player event");
    function_b250bbe5574864ea("test server event");
  }
}

function private function_234528691f62628b(data) {
  [map_name, game_type, sub_game_type, playlist_id, playlist_name, round_num] = namespace_7349d2dcd492da87::function_45d01d27e99f49d7();
  var_e04c0b7a3136ea2d = 0;
  row_array = [];

  foreach(player in level.players) {
    row_array[row_array.size] = ["player_name", default_to(player.name, player.classname), "health", player.health, "suit", default_to(player.suit, ""), "voice", default_to(player.operatorcustomization.voice, "")];
  }

  if(row_array.size > 100) {
    var_e04c0b7a3136ea2d = row_array.size - 100;
  }

  dlog_recordevent("dlog_event_example_with_array_of_rows", ["example_rows", row_array, "map", map_name, "game_type", game_type, "sub_game_type", sub_game_type, "playlist_id", playlist_id, "playlist_name", playlist_name, "round_num", round_num, "num_entries_total", row_array.size, "num_entries_unlogged", var_e04c0b7a3136ea2d, "my_xhash_string", default_to(data.my_xhash_string, ""), "my_int", default_to(data.my_int, 0), "my_string", default_to(data.my_string, "")]);
}

function function_83e5e7d28c56eef1(data) {
  speaker_name = "";
  speaker_team = "";
  speaker_voice = "";
  speaker_sessionstate = "";
  speaker_origin_x = -1;
  speaker_origin_y = -1;
  speaker_origin_z = -1;
  speaker_is_player = 0;
  target_name = "";
  target_team = "";
  target_voice = "";
  target_sessionstate = "";
  target_origin_x = -1;
  target_origin_y = -1;
  target_origin_z = -1;
  target_is_player = 0;

  if(isDefined(data.speaker)) {
    speaker_name = data.speaker.suit;
    speaker_team = data.speaker.team;
    speaker_sessionstate = data.speaker.sessionstate;

    if(isDefined(data.speaker.origin)) {
      speaker_origin_x = data.speaker.origin[0];
      speaker_origin_y = data.speaker.origin[1];
      speaker_origin_z = data.speaker.origin[2];
    }

    if(!isbot(data.speaker) && isPlayer(data.speaker)) {
      speaker_is_player = 1;
    }

    if(isDefined(data.speaker.operatorcustomization)) {
      speaker_voice = data.speaker.operatorcustomization.voice;
    }
  }

  if(isDefined(data.target)) {
    if(isDefined(data.target.suit)) {
      target_name = data.target.suit;
    } else {
      target_name = data.target.classname;
    }

    target_team = data.target.team;
    target_sessionstate = data.target.sessionstate;

    if(isDefined(data.target.origin)) {
      target_origin_x = data.target.origin[0];
      target_origin_y = data.target.origin[1];
      target_origin_z = data.target.origin[2];
    }

    if(isent(data.target) && !isbot(data.target) && isPlayer(data.target)) {
      target_is_player = 1;
    }

    if(isDefined(data.target.operatorcustomization)) {
      target_voice = data.target.operatorcustomization.voice;
    }
  }

  [map_name, game_type, sub_game_type, playlist_id, playlist_name, round_num] = namespace_7349d2dcd492da87::function_45d01d27e99f49d7();
  dlog_recordevent("dlog_event_mp_operator_vo", ["map", map_name, "game_type", game_type, "sub_game_type", sub_game_type, "playlist_id", playlist_id, "playlist_name", playlist_name, "round_num", round_num, "script_func_name", data.script_func_name, "sound_type", default_to(data.sound_type, ""), "sound_event", data.sound_event, "speaker_name", default_to(speaker_name, ""), "speaker_voice", default_to(speaker_voice, ""), "speaker_team", default_to(speaker_team, ""), "speaker_origin_x", speaker_origin_x, "speaker_origin_y", speaker_origin_y, "speaker_origin_z", speaker_origin_z, "speaker_sessionstate", default_to(speaker_sessionstate, ""), "speaker_is_player", speaker_is_player, "target_name", default_to(target_name, ""), "target_voice", default_to(target_voice, ""), "target_origin_x", target_origin_x, "target_origin_y", target_origin_y, "target_origin_z", target_origin_z, "target_sessionstate", default_to(target_sessionstate, ""), "target_is_player", target_is_player]);

  if(!isDefined(level.var_bd4371ae4a24cdb2)) {
    level.var_bd4371ae4a24cdb2 = [];
  }

  if(!isDefined(data.sound_event)) {
    data.sound_event = "undefined";
  }

  if(!isDefined(level.var_bd4371ae4a24cdb2[data.sound_event])) {
    level.var_bd4371ae4a24cdb2[data.sound_event] = spawnStruct();
    level.var_bd4371ae4a24cdb2[data.sound_event].count = 1;
    level.var_bd4371ae4a24cdb2[data.sound_event].player_only_count = 1;
    level.var_bd4371ae4a24cdb2[data.sound_event].name = data.sound_event;
    return;
  }

  level.var_bd4371ae4a24cdb2[data.sound_event].count++;

  if(speaker_is_player) {
    level.var_bd4371ae4a24cdb2[data.sound_event].player_only_count++;
  }
}

function private function_b1f212085efe7a8f(left, right) {
  return left.count >= right.count;
}

function private function_b06acd6b01e90383(round_start_time_ms, round_end_time_ms) {
  [map_name, game_type, sub_game_type, playlist_id, playlist_name, round_num] = namespace_7349d2dcd492da87::function_45d01d27e99f49d7();
  var_30f62a948ffe4b8a = [];
  num_unique_entries_total = 0;
  num_unique_entries_unlogged = 0;

  if(isDefined(level.var_bd4371ae4a24cdb2)) {
    num_unique_entries_total = level.var_bd4371ae4a24cdb2.size;
    sorted = [];

    foreach(var_1791acd58d5d11e4 in level.var_bd4371ae4a24cdb2) {
      sorted[sorted.size] = var_1791acd58d5d11e4;
    }

    sorted = scripts\engine\utility::array_sort_with_func(sorted, &function_b1f212085efe7a8f);

    if(sorted.size > 500) {
      num_unique_entries_unlogged = num_unique_entries_total - 500;
      var_16f3a42cbe30dcd0 = int(num_unique_entries_total * 0.5);
      var_ba265a5c037691c6 = var_16f3a42cbe30dcd0 - int(num_unique_entries_unlogged * 0.5);
      var_306a11faa4bdc91b = var_ba265a5c037691c6 + var_16f3a42cbe30dcd0 - 1;

      for(i = var_ba265a5c037691c6; i <= var_306a11faa4bdc91b; i++) {
        sorted[i] = undefined;
      }

      assertmsg("<dev string:x172>" + num_unique_entries_unlogged + "<dev string:x19b>" + 500 + "<dev string:x20d>");
    }

    for(i = 0; i < sorted.size; i++) {
      if(isDefined(sorted[i])) {
        var_30f62a948ffe4b8a[var_30f62a948ffe4b8a.size] = ["sound_event", sorted[i].name, "count", sorted[i].count, "player_only_count", sorted[i].player_only_count];
      }
    }
  }

  dlog_recordevent("dlog_event_mp_operator_vo_accumulated", ["events", var_30f62a948ffe4b8a, "map", map_name, "game_type", game_type, "sub_game_type", sub_game_type, "playlist_id", playlist_id, "playlist_name", playlist_name, "round_start_time_ms", round_start_time_ms, "round_end_time_ms", round_end_time_ms, "round_num", round_num, "num_unique_entries_total", num_unique_entries_total, "num_unique_entries_unlogged", num_unique_entries_unlogged]);
}