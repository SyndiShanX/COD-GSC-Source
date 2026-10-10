/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_404f1aef8aea990.gsc
************************************************/

#using script_4a6760982b403bad;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\hud_util;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;
#namespace namespace_36cfc486ea2fec3b;

function init() {
  if(!scripts\cp_mp\utility\game_utility::function_ba5574c7f287c587()) {
    return;
  }

  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_server_exit_level", &function_69ddf7a3e512a18a);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_on_player_disconnect", &on_player_disconnect);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_on_player_spawned", &on_player_spawned);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_update_weapon_stats", &update_weapon_stats);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_prematch_over", &function_37f53cf222f43271);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_on_bot_set_difficulty", &on_bot_set_difficulty);
}

function function_69ddf7a3e512a18a() {
  foreach(player in level.players) {
    data = spawnStruct();
    data.player = player;
    function_ce976ee0200475a2(data);
  }
}

function function_ce976ee0200475a2(data) {
  player = data.player;

  if(!isDefined(player.pers["telemetry"].var_c804fa67733b8ef5)) {
    if(!namespace_de6e6777b0937bd7::function_892570944f6b6a2(player)) {
      return;
    }

    if(istrue(player.var_6a91d0e80cc504e) && !istrue(level.gameended)) {
      return;
    }

    place = -1;
    survival_time = 0;

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      if(isDefined(player.pers["br_place"])) {
        place = player.pers["br_place"];
      }

      if(!isDefined(player.pers["br_survival_time"]) && isDefined(level.starttime)) {
        gameendtime = level.gameendtime;

        if(!isDefined(gameendtime)) {
          gameendtime = gettime();
        }

        player.pers["br_survival_time"] = gameendtime - level.starttime;
        survival_time = player.pers["br_survival_time"];
      }
    }

    bot_difficulty = "";
    bot_mind_personality = "";

    if(isbot(player)) {
      bot_difficulty = player botgetdifficulty();

      if(isDefined(player.mind_personality)) {
        bot_mind_personality = player.mind_personality;
      }
    }

    player dlog_recordplayerevent("dlog_event_mobile_player_match_end", ["place", place, "survival_time", survival_time, "bot_difficulty", bot_difficulty, "bot_mind_personality", bot_mind_personality]);
    player.pers["telemetry"].var_c804fa67733b8ef5 = 1;
  }
}

function on_player_disconnect(data) {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    function_6b12cc412aa6ea91(data);
  }

  function_ce976ee0200475a2(data);
}

function on_player_spawned(player) {
  if(!namespace_de6e6777b0937bd7::function_892570944f6b6a2(player)) {
    return;
  }

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    prematch = player.pers["telemetry"].prematch;

    if(!isDefined(prematch)) {
      prematch = spawnStruct();
      player.pers["telemetry"].prematch = prematch;
      prematch.spawns = 0;
      return;
    }

    prematch.spawns++;
  }
}

function function_37f53cf222f43271() {
  if(istrue(getdvarint(@ "hash_b46c28f676772bd2", 0)) || istrue(level.skipprematch)) {
    return;
  }

  foreach(player in level.players) {
    data = spawnStruct();
    data.player = player;
    function_6b12cc412aa6ea91(data);
  }
}

function on_bot_set_difficulty(data) {
  bot = data.bot;

  if(!isbot(bot)) {
    return;
  }

  bot dlog_recordplayerevent("dlog_event_mobile_bot_set_difficulty", ["difficulty", data.difficulty]);
}

function function_522ebd007aa28658(data) {
  prematch = self.pers["telemetry"].prematch;

  if(!isDefined(prematch)) {
    return;
  }

  if(data.statname == "shots") {
    if(!isDefined(prematch.shots)) {
      prematch.shots = data.incvalue;
    } else {
      prematch.shots += data.incvalue;
    }

    return;
  }

  if(data.statname == "hits") {
    if(!isDefined(prematch.hits)) {
      prematch.hits = data.incvalue;
    } else {
      prematch.hits += data.incvalue;
    }

    return;
  }

  if(data.statname == "kills") {
    if(!isDefined(prematch.kills)) {
      prematch.kills = data.incvalue;
      return;
    }

    prematch.kills += data.incvalue;
  }
}

function update_weapon_stats(data) {
  currenttime = namespace_de6e6777b0937bd7::function_1b15450e092933cf(gettime());

  if(currenttime <= 0) {
    function_522ebd007aa28658(data);
  }
}

function function_6b12cc412aa6ea91(data) {
  player = data.player;

  if(!isDefined(player.pers["telemetry"].var_c0e398db99db74ed)) {
    if(!namespace_de6e6777b0937bd7::function_892570944f6b6a2(player)) {
      return;
    }

    if(istrue(player.var_6a91d0e80cc504e)) {
      return;
    }

    prematch = player.pers["telemetry"].prematch;

    if(!isDefined(prematch)) {
      return;
    }

    utc_connect_time = 0;

    if(isDefined(player.pers["telemetry"].utc_connect_time_s)) {
      utc_connect_time = player.pers["telemetry"].utc_connect_time_s;
    }

    spawns = default_to(prematch.spawns, 0);
    hits = player.trackingweaponhits;

    if(isDefined(prematch.hits)) {
      hits += prematch.hits;
    }

    shots = default_to(player.trackingweaponshots, 0);

    if(isDefined(prematch.shots)) {
      shots += prematch.shots;
    }

    kills = default_to(player.trackingweaponkills, 0);

    if(isDefined(prematch.kills)) {
      kills += prematch.kills;
    }

    distancetotal = default_to(player.pers["distanceTotal"], 0);
    var_b92c01f350d85fe3 = 0;

    if(isDefined(player.pers["movementUpdateCount"]) && player.pers["movementUpdateCount"] >= 30) {
      var_b92c01f350d85fe3 = player.pers["distanceTotal"] / player.pers["movementUpdateCount"];
    }

    currentweapon = player getcurrentweapon();
    weaponname = currentweapon.basename;
    player dlog_recordplayerevent("dlog_event_mobile_prematch_end", ["spawns", spawns, "kills", kills, "distance_moved", distancetotal, "speed", var_b92c01f350d85fe3, "shots", shots, "hits", hits, "last_weapon_at_hand", weaponname, "connect_time", utc_connect_time, "disconnect_time", getsystemtime()]);
    player.pers["telemetry"].var_c0e398db99db74ed = 1;
  }
}