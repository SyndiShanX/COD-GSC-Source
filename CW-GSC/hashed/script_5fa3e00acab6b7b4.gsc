/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5fa3e00acab6b7b4.gsc
***********************************************/

#using script_7a8059ca02b7b09e;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\spawning_squad;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\overtime;
#namespace namespace_a77a81df;

function private autoexec __init__system__() {
  system::register(#"hash_ac6037cb01da0d4", &preinit, undefined, undefined, #"hash_53528dbbf6cd15c4");
}

function private preinit() {
  level.var_46821767 = getdvarint(#"hash_661461deeee00da6", 0);
  telemetry::add_callback(#"on_game_playing", &function_72c32279);
  telemetry::function_98df8818(#"hash_711212b10739dcce", &function_d519e318);
  telemetry::add_callback(#"on_end_game", &function_f0ffff28);
  telemetry::add_callback(#"on_player_connect", &on_player_connect);
  telemetry::add_callback(#"on_player_disconnect", &on_player_disconnect);
  telemetry::add_callback(#"on_player_spawned", &on_player_spawned);
  telemetry::function_98df8818(#"hash_6602db5bc859fcd9", &function_55a7ded6);
  telemetry::function_98df8818(#"hash_fc0d1250fc48d49", &function_607901f4);
  telemetry::function_98df8818(#"hash_b88b6d2e0028e13", &update_weapon_stats);
  telemetry::add_callback(#"on_loadout", &function_e2162733);
  telemetry::function_98df8818(#"hash_540cddd637f71a5e", &on_game_event);
  telemetry::function_98df8818(#"hash_37f96a1d3c57a089", &function_6c95006e);
  telemetry::add_callback(#"flourish_start", &function_9cac835e);
}

function function_72c32279() {
  if(util::isfirstround()) {
    println("<dev string:x38>" + getutc());
    println("<dev string:x63>" + util::get_map_name());
    println("<dev string:x8e>" + level.gametype);
    println("<dev string:xbe>" + sessionmodeisprivateonlinegame());
    println("<dev string:xf4>" + sessionmodeissystemlink());
    println("<dev string:x127>" + isdedicated());
    println("<dev string:x15b>");

    utc = getutc();

    if(isDefined(game.telemetry)) {
      game.telemetry.utc_start_time_s = utc;
    }

    matchstart = {};
    matchstart.utc_start_time_s = utc;
    matchstart.map = hash(util::get_map_name());
    matchstart.game_type = hash(level.gametype);
    matchstart.var_c8019fa4 = sessionmodeisprivateonlinegame();
    matchstart.var_137fea24 = sessionmodeissystemlink();
    matchstart.is_dedicated = isdedicated();
    matchstart.playlist_id = currentplaylistid();
    matchstart.playlist_name = hash(function_970f37d1());
    matchstart.var_65dcfd4a = getdvarint(#"hash_4c63a0806012e032", 0);
    matchstart.var_a14949d8 = getdvarstring(#"hash_164a9a28628343ef", "");
    matchstart.var_ffa674c = gamemodeisarena();
    function_92d1707f(#"hash_2d8b6733f192c69b", matchstart);
  }

  if(util::isroundbased()) {
    if(isDefined(game.telemetry)) {
      game.telemetry.var_29d0de09 = function_f8d53445();
    }
  }
}

function function_d519e318() {
  if(util::isoneround() || util::waslastround()) {
    util::function_64ebd94d();

    println("<dev string:x197>" + function_f8d53445());
    println("<dev string:x1cb>" + gettime());
    println("<dev string:x1f9>" + util::get_map_name());
    println("<dev string:x222>" + level.gametype);
    println("<dev string:x250>" + getutc());

    utc = getutc();
    matchend = {};
    matchend.utc_start_time_s = 0;
    matchend.utc_end_time_s = utc;
    matchend.map = hash(util::get_map_name());
    matchend.game_type = hash(level.gametype);
    matchend.var_c8019fa4 = sessionmodeisprivateonlinegame();
    matchend.var_137fea24 = sessionmodeissystemlink();
    matchend.is_dedicated = isdedicated();
    matchend.player_count = 0;
    matchend.life_count = 0;
    matchend.playlist_id = currentplaylistid();
    matchend.playlist_name = hash(function_970f37d1());
    matchend.var_65dcfd4a = getdvarint(#"hash_4c63a0806012e032", 0);
    matchend.var_a14949d8 = getdvarstring(#"hash_164a9a28628343ef", "");
    matchend.team_scores = isDefined(game.stat[# "teamscores"]) ? game.stat[# "teamscores"] : [];
    matchend.var_ffa674c = gamemodeisarena();
    teams = [];

    foreach(var_3ac79a83, teamstring in level.teams) {
      teams[teams.size] = var_3ac79a83;
    }

    matchend.teams = teams;

    if(isDefined(game.telemetry.utc_start_time_s)) {
      time_seconds = utc - game.telemetry.utc_start_time_s;
      println("<dev string:x279>" + time_seconds);
      matchend.utc_start_time_s = game.telemetry.utc_start_time_s;
    }

    match_duration = function_f8d53445() / 1000;
    println("<dev string:x2b3>" + match_duration);

    if(isDefined(game.telemetry.player_count)) {
      println("<dev string:x2f0>" + game.telemetry.player_count);
      matchend.player_count = game.telemetry.player_count;
    }

    if(isDefined(game.telemetry.life_count)) {
      println("<dev string:x322>" + game.telemetry.life_count);
      matchend.life_count = game.telemetry.life_count;
    }

    if(function_feface0c()) {
      var_3b7c8f8c = function_6997ae82();

      if(isDefined(var_3b7c8f8c)) {
        matchend.var_c517822c = isDefined(var_3b7c8f8c.votesforprev) ? var_3b7c8f8c.votesforprev : 0;
        matchend.var_5bdd51ff = isDefined(var_3b7c8f8c.votesfornext) ? var_3b7c8f8c.votesfornext : 0;
        matchend.var_b1f1e8df = isDefined(var_3b7c8f8c.votesforrandom) ? var_3b7c8f8c.votesforrandom : 0;
        matchend.var_33f196e0 = isDefined(var_3b7c8f8c.didntvote) ? var_3b7c8f8c.didntvote : 0;
        matchend.var_c35af8bc = isDefined(var_3b7c8f8c.var_f6de7b09) ? var_3b7c8f8c.var_f6de7b09 : 0;
        matchend.var_cc8e62ce = isDefined(var_3b7c8f8c.var_6441c8d) ? var_3b7c8f8c.var_6441c8d : 0;
        matchend.var_467db155 = isDefined(var_3b7c8f8c.var_d6c36da7) ? var_3b7c8f8c.var_d6c36da7 : 0;
        matchend.var_362eb7a8 = isDefined(var_3b7c8f8c.var_a138ab88) ? var_3b7c8f8c.var_a138ab88 : 0;
      }
    }

    matchend.server_frame_msec = function_60d95f53();
    function_92d1707f(#"hash_1b52f03009c8c97e", matchend);
    println("<dev string:x352>");
  }

  if(util::isroundbased()) {
    if(isDefined(game.telemetry.var_29d0de09)) {
      roundend = {};
      roundend.var_29d0de09 = game.telemetry.var_29d0de09;
      roundend.var_b0ab3472 = function_f8d53445();
      roundend.team_scores = isDefined(game.stat[# "teamscores"]) ? game.stat[# "teamscores"] : [];
      roundend.var_e394d7c0 = util::getroundsplayed();
      roundend.overtime_round = overtime::is_overtime_round();
      function_92d1707f(#"hash_4aeb25514c599057", roundend);
    }
  }
}

function on_player_connect() {
  if(!is_true(self.pers[# "telemetry"].connected)) {
    println("<dev string:x38c>" + gettime());
    println("<dev string:x3bf>" + getutc());
    println("<dev string:x3f5>" + self.name);

    self.pers[# "weaponstats"] = [];

    if(!isDefined(self.pers[# "telemetry"])) {
      self.pers[# "telemetry"] = {};
    }

    self.pers[# "telemetry"].utc_connect_time_s = getutc();
    self.pers[# "telemetry"].connected = 1;
    self.pers[# "telemetry"].xp_at_start = self rank::getrankxp();
    self.pers[# "telemetry"].var_a1938c60 = self rank::function_5b197def(0);
    self.pers[# "telemetry"].var_970f034c = self rank::function_5b197def(1);
    self.pers[# "telemetry"].var_43ab3c14 = self rank::function_5b197def(2);
    self.pers[# "telemetry"].var_9c4d3f78 = self rank::function_5b197def(3);
    self.pers[# "telemetry"].var_12173831 = self rank::function_5b197def(5);
    self.pers[# "telemetry"].var_9f177532 = self rank::getrank();
    self.pers[# "telemetry"].var_af870172 = self rank::getprestige();

    if(isDefined(game.telemetry.player_count)) {
      self.pers[# "telemetry"].var_6ba64843 = game.telemetry.player_count;
      game.telemetry.player_count++;
      println("<dev string:x425>" + game.telemetry.player_count);
    } else {
      println("<dev string:x45d>");
      return;
    }

    println("<dev string:x4bb>");
    playerdata = {};
    playerdata.utc_connect_time_s = self.pers[# "telemetry"].utc_connect_time_s;
    playerdata.var_6ba64843 = isDefined(self.pers[# "telemetry"].var_6ba64843) ? self.pers[# "telemetry"].var_6ba64843 : 0;
    playerdata.var_524ab934 = self function_d40f1a0e();
    playerdata.var_504e19f4 = self function_21f71ac8();
    playerdata.var_68441d6f = self function_325dc923();
    self function_678f57c8(#"hash_2d1a41c5bbfe18dd", playerdata);
  }
}

function on_player_disconnect() {
  if(!is_true(self.pers[# "telemetry"].connected)) {
    return;
  }

  self.pers[# "telemetry"].connected = 0;
  playerdata = {};

  println("<dev string:x500>" + self.name);
  println("<dev string:x533>" + gettime());

  playerdata.utc_connect_time_s = 0;
  playerdata.utc_disconnect_time_s = 0;
  playerdata.var_37b8e421 = 0;
  utc = getutc();

  if(isDefined(self.pers[# "telemetry"].utc_connect_time_s)) {
    playerdata.utc_connect_time_s = self.pers[# "telemetry"].utc_connect_time_s;
    playerdata.utc_disconnect_time_s = utc;
    playerdata.var_37b8e421 = utc - playerdata.utc_connect_time_s;
  }

  playerdata.var_6ba64843 = isDefined(self.pers[# "telemetry"].var_6ba64843) ? self.pers[# "telemetry"].var_6ba64843 : 0;

  if(isDefined(self.pers)) {
    playerdata.score = isDefined(self.pers[# "score"]) ? self.pers[# "score"] : 0;
    playerdata.kills = isDefined(self.pers[# "kills"]) ? self.pers[# "kills"] : 0;
    playerdata.deaths = isDefined(self.pers[# "deaths"]) ? self.pers[# "deaths"] : 0;
    playerdata.headshots = isDefined(self.pers[# "headshots"]) ? self.pers[# "headshots"] : 0;
    playerdata.assists = isDefined(self.pers[# "assists"]) ? self.pers[# "assists"] : 0;
    playerdata.damage_dealt = isDefined(self.pers[# "damagedone"]) ? self.pers[# "damagedone"] : 0;
    playerdata.suicides = isDefined(self.pers[# "suicides"]) ? self.pers[# "suicides"] : 0;
    playerdata.shots = isDefined(self.pers[# "shotsfired"]) ? self.pers[# "shotsfired"] : 0;
    playerdata.hits = isDefined(self.pers[# "shotshit"]) ? self.pers[# "shotshit"] : 0;
    playerdata.time_played_alive = isDefined(self.pers[# "time_played_alive"]) ? self.pers[# "time_played_alive"] : 0;
    playerdata.var_ef5017c7 = isDefined(self.pers[# "best_kill_streak"]) ? self.pers[# "best_kill_streak"] : 0;
    playerdata.multikills = isDefined(self.pers[# "hash_104ec9727c3d4ef7"]) ? self.pers[# "hash_104ec9727c3d4ef7"] : 0;
    playerdata.var_fc1e4ef3 = isDefined(self.pers[# "highestmultikill"]) ? self.pers[# "highestmultikill"] : 0;
    playerdata.ekia = isDefined(self.pers[# "ekia"]) ? self.pers[# "ekia"] : 0;
    playerdata.team = hash(isDefined(self.pers[# "team"]) ? self.pers[# "team"] : "");
    playerdata.var_b0689e83 = isDefined(self.pers[# "hash_766a818213440d53"]) ? self.pers[# "hash_766a818213440d53"] : 0;
    timeplayed = isDefined(self.timeplayed[# "total"]) ? self.timeplayed[# "total"] : 0;

    if(timeplayed >= 120) {
      playerdata.var_4f85ae57 = int(float(1000) * float(playerdata.var_b0689e83 - playerdata.deaths - playerdata.suicides) / float(timeplayed) / float(60));
      playerdata.var_60e624ae = int(float(1000) * float(playerdata.kills - playerdata.deaths - playerdata.suicides) / float(timeplayed) / float(60));
      playerdata.var_664364c7 = int(int(playerdata.score) / int(timeplayed / 60));
    } else {
      playerdata.var_4f85ae57 = 0;
      playerdata.var_60e624ae = 0;
      playerdata.var_664364c7 = 0;
    }

    playerdata.var_62eb1d70 = isDefined(self.pers[# "hash_26948141ff5e29a3"]) ? self.pers[# "hash_26948141ff5e29a3"] : 0;
    println("<dev string:x569>" + playerdata.var_b0689e83);
  }

  playerdata.xp_at_start = isDefined(self.pers[# "telemetry"].xp_at_start) ? self.pers[# "telemetry"].xp_at_start : 0;
  playerdata.xp_at_end = self rank::getrankxp();
  playerdata.var_a1938c60 = isDefined(self.pers[# "telemetry"].var_a1938c60) ? self.pers[# "telemetry"].var_a1938c60 : 0;
  playerdata.var_7ddf8420 = self rank::function_5b197def(0);
  playerdata.var_970f034c = isDefined(self.pers[# "telemetry"].var_970f034c) ? self.pers[# "telemetry"].var_970f034c : 0;
  playerdata.var_b7d93a80 = self rank::function_5b197def(1);
  playerdata.var_43ab3c14 = isDefined(self.pers[# "telemetry"].var_43ab3c14) ? self.pers[# "telemetry"].var_43ab3c14 : 0;
  playerdata.var_460c9ce = self rank::function_5b197def(2);
  playerdata.var_9c4d3f78 = isDefined(self.pers[# "telemetry"].var_9c4d3f78) ? self.pers[# "telemetry"].var_9c4d3f78 : 0;
  playerdata.var_5f67b464 = self rank::function_5b197def(3);
  playerdata.var_12173831 = isDefined(self.pers[# "telemetry"].var_12173831) ? self.pers[# "telemetry"].var_12173831 : 0;
  playerdata.var_c4d676ee = self rank::function_5b197def(5);
  playerdata.var_9f177532 = isDefined(self.pers[# "telemetry"].var_9f177532) ? self.pers[# "telemetry"].var_9f177532 : 0;
  playerdata.var_735f5996 = self rank::getrank();
  playerdata.var_af870172 = isDefined(self.pers[# "telemetry"].var_af870172) ? self.pers[# "telemetry"].var_af870172 : 0;
  playerdata.var_7d032a98 = self rank::getprestige();
  playerdata.objectives = isDefined(self.objectives) ? self.objectives : 0;

  if(!is_true(level.disablestattracking)) {
    playerdata.var_9ffd4086 = self stats::get_stat_global(#"kills");
    playerdata.var_56c22769 = self stats::get_stat_global(#"deaths");
    playerdata.var_3c57e59 = self stats::get_stat_global(#"wins");
    playerdata.var_e42ad7c9 = self stats::get_stat_global(#"losses");
    playerdata.var_270e8e42 = self stats::get_stat_global(#"ties");
    playerdata.var_4c4d425a = self stats::get_stat_global(#"hits");
    playerdata.var_5197016d = self stats::get_stat_global(#"misses");
    playerdata.var_359ee86a = self stats::get_stat_global(#"time_played_total");
    playerdata.var_4ab9220a = self stats::get_stat_global(#"score");
  }

  playerdata.operator = 0;
  role = self player_role::get();

  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    currentoperator = function_b14806c6(role, currentsessionmode());
    playerdata.operator = isDefined(currentoperator) ? currentoperator : 0;
    playerdata.operator_skin = self getcharacterlootid();
  }

  playerdata.var_161a9fc9 = 0;
  playerdata.var_a3ba1678 = # "tie";

  if(!match::get_flag("tie")) {
    if(match::function_a2b53e17(self)) {
      playerdata.var_a3ba1678 = # "win";
    } else {
      playerdata.var_a3ba1678 = # "loss";
    }
  }

  var_a38b89a4 = isDefined(self.pers[# "telemetry"].life.var_4f7ff485) ? self.pers[# "telemetry"].life.var_4f7ff485 : -1;
  lifeindex = isDefined(self.pers[# "telemetry"].life.life_index) ? self.pers[# "telemetry"].life.life_index : -1;

  if(var_a38b89a4 != lifeindex) {
    data = {};
    data.victim = self;
    data.attacker = undefined;
    data.weapon = undefined;
    data.victimweapon = self.currentweapon;
    data.var_d18366fd = 1;
    playerdata.var_161a9fc9 = 1;

    if(isalive(self)) {
      data.died = 0;
    } else {
      data.died = 1;
    }

    if(isDefined(self.pers[# "telemetry"].life)) {
      self.pers[# "telemetry"].life.var_75cd3884 = function_f8d53445();
    }

    function_607901f4(data);
  }

  self function_678f57c8(#"hash_4a80e3ea4f031ba4", playerdata);
  self function_21b451d5(playerdata.score, playerdata.kills, playerdata.deaths, playerdata.headshots, playerdata.assists, playerdata.suicides, playerdata.xp_at_start, playerdata.xp_at_end, playerdata.var_9f177532, playerdata.var_735f5996, playerdata.time_played_alive);
  self function_792e6d18();
}

function on_player_spawned() {
  if(!isDefined(self.pers[# "telemetry"])) {
    self.pers[# "telemetry"] = {};
  }

  self.pers[# "telemetry"].life = {};
  self.pers[# "telemetry"].life.var_62c7b24e = function_f8d53445();
  self.pers[# "telemetry"].life.spawn_origin = self.origin;
  self.pers[# "telemetry"].life.var_cc189f4f = isDefined(self.pers[# "score"]) ? self.pers[# "score"] : 0;
  self.pers[# "telemetry"].life.var_a04d3223 = isDefined(self.pers[# "assists"]) ? self.pers[# "assists"] : 0;
  self.pers[# "telemetry"].life.var_75f84f99 = isDefined(self.pers[# "kills"]) ? self.pers[# "kills"] : 0;
  self.pers[# "telemetry"].life.deathmodifiers = [];

  if(isDefined(game.telemetry.life_count)) {
    self.pers[# "telemetry"].life.life_index = game.telemetry.life_count;
    game.telemetry.life_count++;

    println("<dev string:x5aa>" + self.name);
    println("<dev string:x5da>" + game.telemetry.life_count);
  }

  println("<dev string:x610>");

  if(!isDefined(self.pers[# "telemetry"].var_9c9223d5)) {
    var_234012ff = {
      #operator: "", #operator_skin: ""};
    var_8efad2ca = self player_role::get();

    if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
      currentoperator = function_b14806c6(isDefined(var_8efad2ca) ? var_8efad2ca : 0, currentsessionmode());
      var_234012ff.operator = isDefined(currentoperator) ? currentoperator : "";
      var_234012ff.operator_skin = self getcharacterlootid();
    }

    self function_678f57c8(#"hash_2858113be21419d2", var_234012ff);
    self.pers[# "telemetry"].var_9c9223d5 = 1;
  }
}

function function_f0ffff28() {
  if(util::isoneround() || util::waslastround()) {}

  var_87e50fa8 = function_f8d53445();
  var_a7dd086f = isalive(self);
  telemetry::function_f397069a();

  if(var_a7dd086f && isDefined(self)) {
    var_a38b89a4 = isDefined(self.pers[# "telemetry"].life.var_4f7ff485) ? self.pers[# "telemetry"].life.var_4f7ff485 : -1;
    lifeindex = isDefined(self.pers[# "telemetry"].life.life_index) ? self.pers[# "telemetry"].life.life_index : -1;

    if(var_a38b89a4 != lifeindex) {
      data = {};
      data.victim = self;
      data.attacker = undefined;
      data.weapon = undefined;
      data.victimweapon = self.currentweapon;
      data.died = 0;

      if(isDefined(self.pers[# "telemetry"].life)) {
        self.pers[# "telemetry"].life.var_75cd3884 = var_87e50fa8;
      }

      function_607901f4(data);
    }
  }

  if(isDefined(self)) {
    self killstreaks::function_ef1303ba(var_87e50fa8, #"game_ended");
  }
}

function function_55a7ded6(data) {
  if(!isPlayer(data.victim)) {
    return;
  }

  if(isDefined(data.victim.pers[# "telemetry"].life)) {
    data.victim.pers[# "telemetry"].life.var_75cd3884 = function_f8d53445();
  }

  if(isDefined(data.victim.var_c8836f02)) {
    data.var_cc4bc1dd = arraycopy(data.victim.var_c8836f02);
  }

  println("<dev string:x656>" + data.victim.name);
  println("<dev string:x656>" + function_f8d53445());
}

function function_607901f4(data) {
  if(!isDefined(data.victim) || !isPlayer(data.victim)) {
    return;
  }

  println("<dev string:x688>" + data.victim.name);
  println("<dev string:x6b9>" + function_f8d53445());

  died = 1;

  if(isDefined(data.died)) {
    died = data.died;
  }

  deathdata = {};
  deathdata.died = died;
  deathdata.var_161a9fc9 = isDefined(data.var_d18366fd) ? data.var_d18366fd : 0;
  deathdata.var_62c7b24e = 0;
  deathdata.var_75cd3884 = 0;
  deathdata.var_39872854 = 0;

  if(isDefined(data.victim.pers[# "telemetry"].life.var_62c7b24e)) {
    deathdata.var_62c7b24e = data.victim.pers[# "telemetry"].life.var_62c7b24e;

    if(isDefined(data.victim.pers[# "telemetry"].life.var_75cd3884)) {
      deathdata.var_75cd3884 = data.victim.pers[# "telemetry"].life.var_75cd3884;
      deathdata.var_39872854 = deathdata.var_75cd3884 - deathdata.var_62c7b24e;
    }
  }

  deathdata.var_5b58152b = isDefined(data.victim.var_6fd69072) ? data.victim.var_6fd69072 : 0;
  deathdata.var_41d1b088 = isDefined(data.victim.var_8cb03411) ? data.victim.var_8cb03411 : 0;
  deathdata.var_f079a94e = 0;

  if(squad_spawn::function_d072f205()) {
    deathdata.var_f079a94e = 1;
  }

  deathdata.spawn_type = isDefined(data.victim.spawn.var_a9914487) ? data.victim.spawn.var_a9914487 : 0;
  deathdata.var_d5eb9cb8 = isDefined(data.victim.spawn.var_4db23b) ? data.victim.spawn.var_4db23b : 0;
  deathdata.team = data.victim.team;
  deathdata.life_index = -1;

  if(isDefined(data.victim.pers[# "telemetry"].life.life_index)) {
    deathdata.life_index = data.victim.pers[# "telemetry"].life.life_index;
  }

  if(isDefined(data.victim.pers[# "telemetry"].life.spawn_origin)) {
    deathdata.var_8b82b087 = data.victim.pers[# "telemetry"].life.spawn_origin[0];
    deathdata.var_9d3f5400 = data.victim.pers[# "telemetry"].life.spawn_origin[1];
    deathdata.var_ab1e6fbe = data.victim.pers[# "telemetry"].life.spawn_origin[2];
  }

  deathdata.var_e399fbd4 = !data.victim gamepadusedlast();
  deathdata.var_915c82d0 = -1;

  if(died) {
    victimorigin = isDefined(data.victimorigin) ? data.victimorigin : data.victim.origin;
    deathdata.var_a8ffa14f = victimorigin[0];
    deathdata.var_e6a11c91 = victimorigin[1];
    deathdata.var_d4717832 = victimorigin[2];
    victimangles = isDefined(data.victimangles) ? data.victimangles : data.victim getplayerangles();
    deathdata.var_7c125af5 = victimangles[0];
    deathdata.var_8d9bfe08 = victimangles[1];
    deathdata.var_506d83ac = victimangles[2];
    deathdata.var_873aa898 = hash(isDefined(data.victimstance) ? data.victimstance : data.victim getstance());
    deathdata.means_of_death = hash(isDefined(data.smeansofdeath) ? data.smeansofdeath : "");
    deathdata.hit_location = hash(isDefined(data.shitloc) ? data.shitloc : "");
    deathdata.var_144a7f3 = data.var_f0b3c772;

    if(isDefined(data.victimweapon)) {
      deathdata.victim_weapon = data.victimweapon.name;
      deathdata.var_fcdf958f = function_8d2c5f27(isDefined(data.victimweapon.attachments) ? data.victimweapon.attachments : []);
    }

    if(isDefined(data.attacker) && isPlayer(data.attacker)) {
      attackerpos = isDefined(data.attackerorigin) ? data.attackerorigin : data.attacker.origin;
      attackerangles = isDefined(data.attackerangles) ? data.attackerangles : data.attacker getplayerangles();
      deathdata.var_47f53c15 = attackerpos[0];
      deathdata.var_1a44e0b5 = attackerpos[1];
      deathdata.var_ed820730 = attackerpos[2];
      deathdata.var_f202c401 = attackerangles[0];
      deathdata.var_72c6458a = attackerangles[1];
      deathdata.var_840c6816 = attackerangles[2];
      deathdata.var_4d858e3d = hash(isDefined(data.attackerstance) ? data.attackerstance : "");
      deathdata.var_1ec9deac = data.attacker playerads();
      deathdata.var_11737fc2 = util::within_fov(attackerpos, attackerangles, data.victimorigin, 0.5);
      deathdata.var_cc3e142b = util::within_fov(data.victimorigin, victimangles, attackerpos, 0.5);
      deathdata.var_67fadda6 = !data.attacker gamepadusedlast();
      deathdata.var_915c82d0 = isDefined(data.attacker.pers[# "telemetry"].life.life_index) ? data.attacker.pers[# "telemetry"].life.life_index : -1;
      deathdata.var_8e368e7c = isDefined(data.attacker.pers[# "telemetry"].var_ee8d3324) ? data.attacker.pers[# "telemetry"].var_ee8d3324 : 0;
    }

    if(isDefined(data.weapon)) {
      deathdata.attacker_weapon = data.weapon.name;
      weapon_attachments = data.weapon.attachments;

      if(weapon_attachments.size > 0) {
        var_4e00795d = [];

        for(i = 0; i < weapon_attachments.size; i++) {
          var_4e00795d[i] = hash(weapon_attachments[i]);
        }

        deathdata.var_f5205237 = var_4e00795d;
      }
    }
  }

  deathdata.var_5bf208a0 = 0;

  if(isDefined(data.victim.class_num)) {
    if(!isDefined(data.victim.pers[# "telemetry"].var_728f5d7d)) {
      data.victim.pers[# "telemetry"].var_728f5d7d = [];
    }

    var_6165a2d8 = data.victim.pers[# "telemetry"].var_ee8d3324;

    if(isDefined(var_6165a2d8)) {
      var_75000956 = data.victim.pers[# "telemetry"].var_728f5d7d;
      sent = 0;

      for(i = 0; i < var_75000956.size; i++) {
        if(var_75000956[i] == var_6165a2d8) {
          sent = 1;
          break;
        }
      }

      if(!sent) {
        var_75000956[var_75000956.size] = var_6165a2d8;
        println("<dev string:x6f8>" + var_6165a2d8);
        function_6d57b52a(data.victim, var_6165a2d8, data.var_cc4bc1dd);
      }

      deathdata.var_5bf208a0 = var_6165a2d8;
    }
  }

  deathdata.var_123cae71 = isDefined(data.victim.pickedupweapons[data.victimweapon]);
  deathdata.var_8c6afa1f = isDefined(data.attacker.pickedupweapons[data.weapon]);

  if(!isDefined(data.victim.pers[# "score"])) {
    data.victim.pers[# "score"] = 0;
  }

  deathdata.score_earned = data.victim.pers[# "score"] - data.victim.pers[# "telemetry"].life.var_cc189f4f;

  if(!isDefined(data.victim.pers[# "assists"])) {
    data.victim.pers[# "assists"] = 0;
  }

  deathdata.assists = data.victim.pers[# "assists"] - data.victim.pers[# "telemetry"].life.var_a04d3223;

  if(!isDefined(data.victim.pers[# "kills"])) {
    data.victim.pers[# "kills"] = 0;
  }

  deathdata.kills = data.victim.pers[# "kills"] - data.victim.pers[# "telemetry"].life.var_75f84f99;
  deathdata.var_1af2a81e = data.victim.pers[# "telemetry"].life.deathmodifiers;
  println("<dev string:x737>" + deathdata.life_index);

  if(isDefined(data.attacker) && isPlayer(data.attacker)) {
    data.victim function_678f57c8(#"hash_56b3bb4a34717783", deathdata, #"attacker", data.attacker);
  } else {
    data.victim function_678f57c8(#"hash_56b3bb4a34717783", deathdata);
  }

  data.victim.pers[# "telemetry"].life.var_4f7ff485 = deathdata.life_index;
}

function function_6d57b52a(player, var_6165a2d8, var_cc4bc1dd) {
  loadoutdata = {};
  loadoutdata.var_5bf208a0 = var_6165a2d8;
  primaryweapon = player loadout::function_18a77b37("primary");

  if(isDefined(primaryweapon)) {
    loadoutdata.primary_weapon = primaryweapon.name;
    loadoutdata.var_70eb2c9d = function_8d2c5f27(isDefined(primaryweapon.attachments) ? primaryweapon.attachments : []);
    var_df9e1af5 = player function_e601ff48(player.class_num, 0);
    var_ff1e2369 = function_69031255(primaryweapon, var_df9e1af5);
    loadoutdata.var_4be85015 = isDefined(var_ff1e2369.weaponblueprint) ? var_ff1e2369.weaponblueprint : 0;
    primaryweaponoptions = player function_ade49959(primaryweapon);
    var_6df37b82 = getcamoindex(primaryweaponoptions);
    var_cc073e42 = function_6f89999e(var_6df37b82);
    loadoutdata.var_5eb8cc7c = isDefined(var_cc073e42) ? var_cc073e42 : 0;
  }

  secondaryweapon = player loadout::function_18a77b37("secondary");

  if(isDefined(secondaryweapon)) {
    loadoutdata.secondary_weapon = secondaryweapon.name;
    loadoutdata.var_85aac3ff = function_8d2c5f27(isDefined(secondaryweapon.attachments) ? secondaryweapon.attachments : []);
    var_48d617f1 = player function_e601ff48(player.class_num, 14);
    var_96a1671e = function_69031255(secondaryweapon, var_48d617f1);
    loadoutdata.var_61e93312 = isDefined(var_96a1671e.weaponblueprint) ? var_96a1671e.weaponblueprint : 0;
    secondaryweaponoptions = player function_ade49959(secondaryweapon);
    var_b65500f8 = getcamoindex(secondaryweaponoptions);
    var_e1e3c149 = function_6f89999e(var_b65500f8);
    loadoutdata.var_a656d9c6 = isDefined(var_e1e3c149) ? var_e1e3c149 : 0;
  }

  primarygrenade = player loadout::function_18a77b37("primarygrenade");

  if(isDefined(primarygrenade)) {
    loadoutdata.primary_grenade = primarygrenade.name;
  }

  secondarygrenade = player loadout::function_18a77b37("secondarygrenade");

  if(isDefined(secondarygrenade)) {
    loadoutdata.var_68f5c0ed = secondarygrenade.name;
  }

  fieldupgrade = player loadout::function_18a77b37("specialgrenade");

  if(isDefined(fieldupgrade)) {
    loadoutdata.field_upgrade = fieldupgrade.name;
  }

  if(isDefined(var_cc4bc1dd)) {
    loadoutdata.perks = [];

    switch (var_cc4bc1dd.size) {
      case 6:
      default:
        loadoutdata.perks[5] = var_cc4bc1dd[5].namehash;
      case 5:
        loadoutdata.perks[4] = var_cc4bc1dd[4].namehash;
      case 4:
        loadoutdata.perks[3] = var_cc4bc1dd[3].namehash;
      case 3:
        loadoutdata.perks[2] = var_cc4bc1dd[2].namehash;
      case 2:
        loadoutdata.perks[1] = var_cc4bc1dd[1].namehash;
      case 1:
        loadoutdata.perks[0] = var_cc4bc1dd[0].namehash;
      case 0:
        break;
    }
  }

  wildcards = player function_6f2c0492(player.class_num);

  if(isDefined(wildcards)) {
    loadoutdata.wildcards = [];

    switch (wildcards.size) {
      case 3:
      default:
        loadoutdata.wildcards[2] = wildcards[2];
      case 2:
        loadoutdata.wildcards[1] = wildcards[1];
      case 1:
        loadoutdata.wildcards[0] = wildcards[0];
      case 0:
        break;
    }
  }

  killstreaks = player.killstreak;

  if(isDefined(killstreaks)) {
    loadoutdata.killstreaks = [];

    switch (killstreaks.size) {
      case 3:
      default:
        loadoutdata.killstreaks[2] = killstreaks[2];
      case 2:
        loadoutdata.killstreaks[1] = killstreaks[1];
      case 1:
        loadoutdata.killstreaks[0] = killstreaks[0];
      case 0:
        break;
    }
  }

  player function_678f57c8(#"hash_46722c5c0abe049f", loadoutdata);
}

function update_weapon_stats(data) {
  if(level.var_46821767 === 1) {
    return;
  }

  if(!data.weaponpickedup) {
    if(!isDefined(data.player.pers[# "telemetry"].var_68ef7250)) {
      return;
    }

    key = data.weapon.name + data.player.pers[# "telemetry"].var_68ef7250;

    if(!isDefined(data.player.pers[# "weaponstats"][key])) {
      if(data.player.pers[# "weaponstats"].size >= 5) {
        data.player function_792e6d18();
        data.player.pers[# "weaponstats"] = [];
      }

      data.player.pers[# "weaponstats"][key] = {
        #stats: [], #weapon: data.weapon, #var_6165a2d8: data.player.pers[# "telemetry"].var_ee8d3324
      };
    }

    statscache = data.player.pers[# "weaponstats"][key].stats;

    if(!isDefined(statscache[data.statname])) {
      statscache[data.statname] = 0;
    }

    statscache[data.statname] += data.value;
  }
}

function function_792e6d18() {
  foreach(weaponinfo in self.pers[# "weaponstats"]) {
    weaponitemindex = getbaseweaponitemindex(weaponinfo.weapon);
    weaponstats = {
      #weapon_name: weaponinfo.weapon.name, #var_5bf208a0: weaponinfo.var_6165a2d8, #shots: isDefined(weaponinfo.stats[# "shots"]) ? weaponinfo.stats[# "shots"] : 0, #hits: isDefined(weaponinfo.stats[# "hits"]) ? weaponinfo.stats[# "hits"] : 0, #kills: isDefined(weaponinfo.stats[# "kills"]) ? weaponinfo.stats[# "kills"] : 0, #headshots: isDefined(weaponinfo.stats[# "headshots"]) ? weaponinfo.stats[# "headshots"] : 0, #var_7e2968cc: isDefined(weaponinfo.stats[# "deathsduringuse"]) ? weaponinfo.stats[# "deathsduringuse"] : 0, #time_used_s: isDefined(weaponinfo.stats[# "timeused"]) ? weaponinfo.stats[# "timeused"] : 0, #xp_earned: isDefined(weaponinfo.stats[# "xpearned"]) ? weaponinfo.stats[# "xpearned"] : 0, #end_level: (isDefined(self getcurrentgunrank(weaponitemindex)) ? self getcurrentgunrank(weaponitemindex) : 0) + 1, #flourish_count: isDefined(weaponinfo.stats[# "flourish_count"]) ? weaponinfo.stats[# "flourish_count"] : 0
    };
    self function_678f57c8(#"hash_71e24083d5b3f555", weaponstats);
  }
}

function function_e2162733() {
  var_ee8d3324 = self function_13f24803(self.class_num);
  self.pers[# "telemetry"].var_ee8d3324 = var_ee8d3324;

  if(isDefined(var_ee8d3324)) {
    self.pers[# "telemetry"].var_68ef7250 = "+loadoutChecksum" + string(var_ee8d3324);
    return;
  }

  self.pers[# "telemetry"].var_68ef7250 = undefined;
}

function on_game_event(data) {
  var_e3b99e34 = {};
  var_e3b99e34.event_type = data.eventtype;
  var_e3b99e34.var_87a3e584 = isDefined(data.var_51b1d48e) ? data.var_51b1d48e : function_f8d53445();

  if(isDefined(data.player.origin)) {
    var_e3b99e34.var_39c6001a = data.player.origin[0];
    var_e3b99e34.var_71986fbe = data.player.origin[1];
    var_e3b99e34.var_efd8ec65 = data.player.origin[2];
  }

  if(isDefined(data.player)) {
    function_92d1707f(#"hash_16b85b3fe51a7bd4", var_e3b99e34, #"player", data.player);
    return;
  }

  function_92d1707f(#"hash_16b85b3fe51a7bd4", var_e3b99e34);
}

function function_6c95006e(data) {
  if(isDefined(data.var_bdc4bbd2)) {
    deathmodifiers = data.player.pers[# "telemetry"].life.deathmodifiers;
    deathmodifiers[deathmodifiers.size] = data.var_bdc4bbd2;
  }
}

function function_9cac835e(data) {
  if(isDefined(data.weapon)) {
    update_weapon_stats({
      #player: self, #weapon: data.weapon, #statname: # "flourish_count", #value: 1, #weaponpickedup: 0
    });
  }
}

function function_8d2c5f27(array) {
  new_array = [];

  for(i = 0; i < array.size; i++) {
    new_array[i] = hash(array[i]);
  }

  return new_array;
}