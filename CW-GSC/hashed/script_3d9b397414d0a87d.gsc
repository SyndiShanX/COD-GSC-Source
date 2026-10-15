/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3d9b397414d0a87d.gsc
***********************************************/

#using script_7a8059ca02b7b09e;
#using scripts\core_common\array_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\scoreevents;

#namespace namespace_4b798cb0;

function private autoexec __init__system__() {
  system::register(#"hash_4b859fe530bf291d", &preinit, undefined, undefined, #"hash_53528dbbf6cd15c4");
}

function private preinit() {
  if(getdvarint(#"hash_43b642374f5b1f22", 0) == 0) {
    return;
  }

  level.esports = {};
  level.esports.teams = [];
  level.var_268c70a7 = 1;
  level.map_name = util::get_map_name();
  level.esports.var_49d3ced6 = getdvarint(#"hash_61fde65a22e1f290", 5);
  telemetry::add_callback(#"on_start_gametype", &on_start_gametype);
  telemetry::add_callback(#"on_game_playing", &function_e2603d58);
  telemetry::add_callback(#"hash_3ca80e35288a78d0", &function_84b3ab79);
  telemetry::add_callback(#"on_end_game", &function_a6efe6c9);
  telemetry::add_callback(#"on_player_connect", &function_5a676b2c);
  telemetry::add_callback(#"on_player_disconnect", &function_42fa3a5c);
  telemetry::add_callback(#"on_player_spawned", &on_player_spawned);
  telemetry::function_98df8818(#"hash_fc0d1250fc48d49", &on_player_killed);
  telemetry::add_callback(#"on_loadout", &function_e2162733);
  telemetry::add_callback(#"hash_7de173a0523c27c9", &function_d5aacfd7);

  switch (level.basegametype) {
    case #"koth":
      level.var_ab8dd45a = {
        #var_284ea17f: #"hash_75fa0382e49cdd2f", #data_function: &function_99b4929d
      };
      level.var_86d47028 = {
        #var_284ea17f: #"hash_4f85fe047c18a6f2", #data_function: &function_6607b43f
      };
      level.var_8d67cbd8 = {
        #var_284ea17f: #"hash_57af555874ed0050", #data_function: &function_712f816a
      };
      level.var_46fc4fdb = &function_4dc75f1b;
      level.var_e1206cfc = &function_f2282b8b;
      break;
    case #"sd":
      level.var_ab8dd45a = {
        #var_284ea17f: #"hash_d9870c3e6c1e3c5", #data_function: &function_39e8afcf
      };
      level.var_86d47028 = {
        #var_284ea17f: #"hash_63c6c30aa3ff880", #data_function: &function_9555b8d2
      };
      level.var_8d67cbd8 = {
        #var_284ea17f: #"hash_628978e8b4daa872", #data_function: &function_150786f3
      };
      level.var_46fc4fdb = &function_86398c9c;
      level.var_e1206cfc = &function_ceb40ef4;
      break;
    case #"control":
      level.var_ab8dd45a = {
        #var_284ea17f: #"dlog_event_esports_player_match_end_control", #data_function: &function_91a0716f
      };
      level.var_86d47028 = {
        #var_284ea17f: #"dlog_event_esports_player_round_end_control", #data_function: &function_b16086a1
      };
      level.var_8d67cbd8 = {
        #var_284ea17f: #"hash_145e373d3b0196c4", #data_function: &function_cdce904b
      };
      level.var_88531f89 = {
        #var_284ea17f: #"dlog_event_esports_match_interval_info_control", #data_function: &function_2b1314ec
      };
      level.var_46fc4fdb = &function_979f0cb4;
      level.var_e1206cfc = &function_a9b19a49;
      break;
  }
}

function function_8d2c5f27(array) {
  new_array = [];

  for(i = 0; i < array.size; i++) {
    new_array[i] = hash(array[i]);
  }

  return new_array;
}

function function_4dc75f1b(var_a504287b, persistent_data) {
  var_a504287b.objective1_time = isDefined(persistent_data[#"hash_15d08ee09ca7c219"]) ? persistent_data[#"hash_15d08ee09ca7c219"] : 0;
  var_a504287b.objective2_time = isDefined(persistent_data[#"hash_15d08be09ca7bd00"]) ? persistent_data[#"hash_15d08be09ca7bd00"] : 0;
  var_a504287b.objective3_time = isDefined(persistent_data[#"hash_15d08ce09ca7beb3"]) ? persistent_data[#"hash_15d08ce09ca7beb3"] : 0;
  var_a504287b.objective4_time = isDefined(persistent_data[#"hash_15d091e09ca7c732"]) ? persistent_data[#"hash_15d091e09ca7c732"] : 0;
  var_a504287b.objective5_time = isDefined(persistent_data[#"hash_15d092e09ca7c8e5"]) ? persistent_data[#"hash_15d092e09ca7c8e5"] : 0;
}

function function_86398c9c(var_a504287b, persistent_data) {
  var_a504287b.bombs_planted = isDefined(persistent_data[#"bombplanted"]) ? persistent_data[#"bombplanted"] : 0;
  var_a504287b.bombs_defused = isDefined(persistent_data[#"bombdefused"]) ? persistent_data[#"bombdefused"] : 0;
}

function function_979f0cb4(var_a504287b, persistent_data) {
  var_a504287b.tiers_captured = persistent_data[#"hash_156cd38474282f8d"];
}

function function_9f07d120() {
  foreach(player in self.players) {
    if(player.team != #"spectator") {
      persistent_data = player.pers;
      var_a504287b = {};
      var_a504287b.kills = persistent_data[#"kills"];
      var_a504287b.deaths = persistent_data[#"deaths"];
      var_a504287b.assists = persistent_data[#"assists"];
      var_a504287b.damage_done = persistent_data[#"damagedone"];
      var_a504287b.highest_killstreak = 0;
      var_a504287b.multikills = persistent_data[#"totalmultikills"];
      var_a504287b.highest_multikill = 0;
      var_a504287b.time_alive = persistent_data[#"time_played_alive"];
      var_a504287b.score = persistent_data[#"score"];
      var_a504287b.shots_hit = persistent_data[#"shotshit"];
      var_a504287b.shots_fired = persistent_data[#"shotsfired"];
      var_a504287b.shots_head = persistent_data[#"headshothits"];
      var_a504287b.objective_time = persistent_data[#"objtime"];

      if(isDefined(level.var_46fc4fdb)) {
        self[[level.var_46fc4fdb]](var_a504287b, persistent_data);
      }

      player.var_a504287b = var_a504287b;
    }
  }
}

function function_1674a96a(team_id) {
  if(!isDefined(level.esports.teams[team_id]) || level.esports.teams[team_id] == "") {
    level.esports.teams[team_id] = function_638671f1(team_id);
  }

  return level.esports.teams[team_id];
}

function function_ce7dd3eb() {
  var_64e8f5a4 = 0;

  while(!isDefined(self.var_b2ca7b2b)) {
    wait 0.1;
    var_64e8f5a4++;

    if(var_64e8f5a4 >= 10) {
      break;
    }
  }
}

function function_3d01c1b3() {
  var_c1e98979 = round::function_3624d032();

  switch (var_c1e98979) {
    case 0:
      return "dnf";
    case 1:
      return "completed";
    case 2:
      return "time limit";
    case 3:
      return "scorelimit";
    case 4:
      return "roundscorelimit";
    case 5:
      return "roundlimit";
    case 6:
      return "team eliminated";
    case 7:
      return "forfeit";
    case 8:
      return "ended game";
    case 9:
      return "host ended game";
    case 10:
      return "host ended sucks";
    case 12:
      return "gamemode-specific";
    case 11:
      return "canceled";
  }
}

function function_d757edb5() {
  winning_team = round::get_winning_team();

  if(winning_team == game.attackers) {
    return {
      #side: #"attack", #win_team: winning_team, #loss_team: game.defenders
    };
  } else if(winning_team == game.defenders) {
    return {
      #side: #"defense", #win_team: winning_team, #loss_team: game.attackers
    };
  }

  return {
    #side: #"none", #win_team: winning_team, #loss_team: #"none"};
}

function function_ddf02547() {
  zoneindex = array::find(level.zones, level.active_zones[0]) + 1;
  return "point_" + zoneindex;
}

function function_a6f108b5() {
  if(isDefined(self.label)) {
    if(self.label == "_a") {
      return "point_a";
    } else if(self.label == "_b") {
      return "point_b";
    }
  }

  return "bomb";
}

function function_d4ad62c7() {
  if(self.var_f23c87bd == "control_0") {
    return "point_a";
  } else if(self.var_f23c87bd == "control_1") {
    return "point_b";
  }

  return self.var_f23c87bd;
}

function function_9ad755c5() {
  var_c6af8b83 = float(self.pers[#"hash_20464b40eeb9b465"]);
  time_played_moving = float(self.pers[#"time_played_moving"]);
  return time_played_moving != 0 ? var_c6af8b83 / time_played_moving : 0;
}

function function_a3384e() {
  var_e4d08367 = "A";

  if(isDefined(level.defuseobject) && isDefined(level.defuseobject.label)) {
    objective_label = level.defuseobject.label;
    var_e4d08367 = toupper(objective_label[1]);
  }

  currenttime = gettime();
  objective_time = function_4c27be22(var_e4d08367);
  return currenttime > objective_time ? 0 : objective_time - currenttime;
}

function function_e2603d58() {
  self function_9f07d120();

  if(util::isfirstround()) {
    self function_72c32279();

    if(isDefined(level.var_e1206cfc)) {
      self[[level.var_e1206cfc]]();
    }
  }

  level thread function_1296760e();
  self on_round_start();
}

function function_84b3ab79() {
  util::function_64ebd94d();
  waittillframeend();
  self on_round_end();

  if(util::isoneround() || util::waslastround()) {
    self function_d519e318();
  }
}

function function_a6efe6c9() {
  if(self.team == #"spectator") {
    return;
  }

  util::function_64ebd94d();
  waittillframeend();
  self function_2d28a3b3();

  if(util::isoneround() || util::waslastround()) {
    self function_f0ffff28();
  }
}

function private function_5a676b2c() {
  self endon(#"disconnect");
  player_team = self.pers[#"team"];
  var_64e8f5a4 = 0;

  while(!isDefined(player_team) || isDefined(self.pers[#"needteam"])) {
    wait 0.1;
    player_team = self.pers[#"team"];

    if(player_team == #"spectator") {
      return;
    }

    var_64e8f5a4++;

    if(var_64e8f5a4 >= 10) {
      break;
    }
  }

  self.var_7a967a71 = {};
  self.var_b2ca7b2b = function_1674a96a(player_team);
}

function private function_42fa3a5c() {
  if(self.team == #"spectator" || !isDefined(self.var_7a967a71) || game.state == #"pregame") {
    return;
  }

  var_66e1aeea = self.var_7a967a71;

  if(var_66e1aeea.round_end !== 1) {
    self function_2d28a3b3();
  }

  if(var_66e1aeea.match_end !== 1) {
    self function_f0ffff28();
  }

  self on_player_disconnect();
}

function function_2b1314ec(esports_event) {
  esports_event.var_34f440e5 = isDefined(level.var_1cb1e802[0]) ? level.var_1cb1e802[0] : 0;
  esports_event.var_e428312f = isDefined(level.var_1cb1e802[1]) ? level.var_1cb1e802[1] : 0;
}

function function_3651a831() {
  team_scores = game.stat[#"teamscores"];
  esports_event = {
    #game_timer: isDefined(int(float(globallogic_utils::gettimeremaining()) / 1000)) ? int(float(globallogic_utils::gettimeremaining()) / 1000) : 0, #objective_timer: isDefined(int(float(function_a3384e()) / 1000)) ? int(float(function_a3384e()) / 1000) : 0, #team1_score: isDefined(team_scores[#"allies"]) ? team_scores[#"allies"] : 0, #team2_score: isDefined(team_scores[#"axis"]) ? team_scores[#"axis"] : 0
  };
  var_284ea17f = #"dlog_event_esports_match_interval_info";

  if(isDefined(level.var_88531f89)) {
    var_284ea17f = level.var_88531f89.var_284ea17f;
    self[[level.var_88531f89.data_function]](esports_event);
  }

  function_92d1707f(var_284ea17f, esports_event);
}

function function_a8ccfb6() {
  all_events = [];

  foreach(player in level.players) {
    if(!isDefined(player) || player.team == #"spectator") {
      continue;
    }

    telemetry = player function_28d70fb8();
    player.pers[#"hash_c9752eb3c681b24"] += telemetry.var_c3f958f5;
    player.pers[#"hash_567d2891c00748f7"] += 1;
    origin = player.origin;
    esports_event = {
      #damage_dealt: player.pers[#"damagedone"], #assists: player.pers[#"assists"], #deaths: player.pers[#"deaths"], #kills: player.pers[#"kills"], #current_killstreak: player.pers[#"cur_kill_streak"], #highest_killstreak: player.pers[#"best_kill_streak"], #multikills: player.pers[#"totalmultikills"], #highest_multikill: player.pers[#"highestmultikill"], #score: player.pers[#"score"], #shots_fired: player.pers[#"shotsfired"], #shots_hit: player.pers[#"shotshit"], #shots_head: player.pers[#"headshothits"], #objective_time: player.pers[#"objtime"], #player: player.name, #var_c3f958f5: telemetry.var_c3f958f5, #origin_x: origin[0], #origin_y: origin[1], #origin_z: origin[2], #latency: telemetry.latency, #ping: telemetry.ping
    };
    player_event = {
      #player: player, #event: esports_event
    };

    if(!isDefined(all_events)) {
      all_events = [];
    } else if(!isarray(all_events)) {
      all_events = array(all_events);
    }

    all_events[all_events.size] = player_event;
  }

  foreach(player_event in all_events) {
    player = player_event.player;

    if(!isDefined(player)) {
      continue;
    }

    player function_678f57c8(#"dlog_event_esports_player_interval_info", player_event.event);
    waitframe(1);
  }
}

function private function_1296760e() {
  self endon(#"death");
  level endon(#"game_ended");
  var_49d3ced6 = level.esports.var_49d3ced6;

  while(true) {
    function_3651a831();
    function_a8ccfb6();
    wait var_49d3ced6;
  }
}

function on_start_gametype() {
  if(util::isfirstround()) {
    esports_event = {
      #game_type: level.gametype, #map_name: level.map_name, #team1_name: function_1674a96a(#"allies"), #team2_name: function_1674a96a(#"axis")
    };
    function_92d1707f(#"dlog_event_esports_server_start", esports_event);
  }
}

function function_72c32279() {
  esports_event = {
    #game_type: level.gametype, #map_name: level.map_name, #team1_name: function_1674a96a(#"allies"), #team2_name: function_1674a96a(#"axis")
  };
  function_92d1707f(#"dlog_event_esports_match_start", esports_event);
}

function function_d519e318() {
  team_scores = game.stat[#"teamscores"];
  win_team = function_1674a96a(round::get_winning_team());
  esports_event = {
    #match_time: function_f8d53445(), #rounds_played: game.roundsplayed, #team1_name: function_1674a96a(#"allies"), #team1_score: team_scores[#"allies"], #team2_name: function_1674a96a(#"axis"), #team2_score: team_scores[#"axis"], #win_team: isDefined(win_team) ? win_team : "draw", #game_type: level.gametype, #map_name: level.map_name
  };
  function_92d1707f(#"dlog_event_esports_match_end", esports_event);
}

function function_99b4929d(esports_event) {
  esports_event.var_5fb8d45b = self.pers[#"objtime"];
  esports_event.objective1_time = self.pers[#"hash_15d08ee09ca7c219"];
  esports_event.objective2_time = self.pers[#"hash_15d08be09ca7bd00"];
  esports_event.objective3_time = self.pers[#"hash_15d08ce09ca7beb3"];
  esports_event.objective4_time = self.pers[#"hash_15d091e09ca7c732"];
  esports_event.objective5_time = self.pers[#"hash_15d092e09ca7c8e5"];
}

function function_39e8afcf(esports_event) {
  esports_event.var_5fb8d45b = self.pers[#"objtime"];
  esports_event.bombs_planted = self.pers[#"bombplanted"];
  esports_event.bombs_defused = self.pers[#"bombdefused"];
}

function function_91a0716f(esports_event) {
  esports_event.total_objectives_captured = self.pers[#"captures"];
  esports_event.objective_tiers_contributed = self.pers[#"hash_156cd38474282f8d"];
}

function function_f0ffff28() {
  persistent_data = self.pers;
  var_1bed336c = 0;
  var_f5a2d10c = persistent_data[#"hash_567d2891c00748f7"];

  if(var_f5a2d10c > 0) {
    var_1bed336c = persistent_data[#"hash_c9752eb3c681b24"] / var_f5a2d10c;
  }

  esports_event = {
    #player: self.name, #total_score: persistent_data[#"score"], #total_assists: persistent_data[#"assists"], #total_kills: persistent_data[#"kills"], #highest_streak: persistent_data[#"best_kill_streak"], #total_deaths: persistent_data[#"deaths"], #total_headshots: persistent_data[#"headshots"], #total_time_alive: persistent_data[#"time_played_alive"], #total_distance_traveled: persistent_data[#"hash_20464b40eeb9b465"], #total_damage_dealt: persistent_data[#"damagedone"], #average_speed_during_match: self function_9ad755c5(), #time_spent_moving: persistent_data[#"time_played_moving"], #total_suicides: persistent_data[#"suicides"], #total_shots_fired: persistent_data[#"shotsfired"], #total_shots_head: persistent_data[#"headshothits"], #total_shots_hit: persistent_data[#"shotshit"], #total_multikills: persistent_data[#"totalmultikills"], #highest_multikill: persistent_data[#"highestmultikill"], #rounds_played: game.roundsplayed, #var_4ac15e1d: var_1bed336c
  };
  var_284ea17f = #"dlog_event_esports_player_match_end";

  if(isDefined(level.var_ab8dd45a)) {
    var_284ea17f = level.var_ab8dd45a.var_284ea17f;
    self[[level.var_ab8dd45a.data_function]](esports_event);
  }

  self function_678f57c8(var_284ea17f, esports_event);
  self.var_7a967a71.match_end = 1;
}

function on_player_spawned() {
  player_position = self.origin;
  player_angles = self getplayerangles();
  esports_event = {
    #player: self.name, #match_time: function_f8d53445(), #origin_x: player_position[0], #origin_y: player_position[1], #origin_z: player_position[2], #var_231262ec: player_angles[0], #var_c91e5a: player_angles[1], #var_e88b9d9: player_angles[2]
  };

  if(!isDefined(self.var_b2ca7b2b)) {
    self function_ce7dd3eb();
  }

  esports_event.player_team = self.var_b2ca7b2b;
  self function_678f57c8(#"dlog_event_esports_player_spawned", esports_event);
}

function on_player_killed(data) {
  attacker = data.attacker;
  victim = data.victim;
  results = data.results;

  if(isPlayer(attacker)) {
    attackerposition = data.attackerorigin;
    attackerangles = data.attackerangles;
    attackerweapon = data.weapon;
    attacker_info = {
      #name: attacker.name, #team: attacker.var_b2ca7b2b, #origin_x: attackerposition[0], #origin_y: attackerposition[1], #origin_z: attackerposition[2], #var_231262ec: attackerangles[0], #var_c91e5a: attackerangles[1], #var_e88b9d9: attackerangles[2], #weapon: attackerweapon.name, #weapon_attachments: function_8d2c5f27(attackerweapon.attachments)
    };
    var_ebf88f4 = {
      #is_ads: data.var_4c540e11 > 0.5, #is_flashed: data.attackerwasflashed, #is_interacting_objective: data.var_91610392
    };
    kill_context = {
      #is_longshot_kill: results.is_longshot_kill === 1, #is_first_blood: results.is_first_blood === 1, #is_revenge_kill: results.is_revenge_kill === 1
    };
  } else {
    attacker_info = {};
    var_ebf88f4 = {};
    kill_context = {};
  }

  var_48dd40c2 = data.victimorigin;
  victimangles = data.victimangles;
  victimweapon = data.victimweapon;
  victim_info = {
    #name: victim.name, #team: victim.var_b2ca7b2b, #origin_x: var_48dd40c2[0], #origin_y: var_48dd40c2[1], #origin_z: var_48dd40c2[2], #var_231262ec: victimangles[0], #var_c91e5a: victimangles[1], #var_e88b9d9: victimangles[2], #weapon: victimweapon.name, #weapon_attachments: function_8d2c5f27(victimweapon.attachments)
  };
  var_61e89f84 = {
    #is_ads: data.var_f0b3c772 > 0.5, #is_flashed: data.var_e020b97e, #is_interacting_objective: data.var_30db4425
  };
  kill_info = {
    #match_time: function_f8d53445(), #means_of_death: data.smeansofdeath, #players_distance: isDefined(results.kill_distance) ? results.kill_distance : 0
  };
  victim function_678f57c8(#"dlog_event_esports_player_killed", #"info", kill_info, #"attacker", attacker_info, #"attacker_status", var_ebf88f4, #"victim", victim_info, #"victim_status", var_61e89f84, #"kill_context", kill_context);
}

function on_player_disconnect() {
  esports_event = {
    #player: self.name
  };
  self function_678f57c8(#"dlog_event_esports_player_disconnect", esports_event);
}

function function_e2162733() {
  if(isDefined(self.lastclass) && self.curclass == self.lastclass) {
    return;
  }

  self.lastclass = self.curclass;
  primary_weapon = self loadout::function_18a77b37("primary");
  secondary_weapon = self loadout::function_18a77b37("secondary");
  primary_grenade = self loadout::function_18a77b37("primarygrenade");
  secondary_grenade = self loadout::function_18a77b37("secondarygrenade");
  field_upgrade = self loadout::function_18a77b37("specialgrenade");
  var_992d253 = self loadout::function_18a77b37("herogadget");
  var_7078908d = self loadout::function_18a77b37("ultimate");
  class_num = self.class_num;
  tactical_gear = self function_d78e0e04(class_num);
  scorestreaks = self.killstreak;
  perks = self function_4a9f1384(class_num);
  wildcards = self function_6f2c0492(class_num);
  esports_event = {
    #player: self.name, #match_time: function_f8d53445(), #primary_weapon: primary_weapon.name, #primary_weapon_attachments: function_8d2c5f27(isDefined(primary_weapon.attachments) ? primary_weapon.attachments : []), #secondary_weapon: secondary_weapon.name, #secondary_weapon_attachments: function_8d2c5f27(isDefined(secondary_weapon.attachments) ? secondary_weapon.attachments : []), #primary_grenade: primary_grenade.name, #secondary_grenade: secondary_grenade.name, #field_upgrade: field_upgrade.name, #var_992d253: var_992d253.name, #var_7078908d: var_7078908d.name, #tactical_gear: tactical_gear, #scorestreaks: scorestreaks, #perks: perks, #wildcards: wildcards
  };
  self function_678f57c8(#"dlog_event_esports_player_loadout_changed", esports_event);
}

function on_round_start() {
  team1_side = #"none";
  team2_side = #"none";

  if(util::isroundbased()) {
    if(game.attackers == #"allies") {
      team1_side = #"attack";
      team2_side = #"defense";
    } else {
      team1_side = #"defense";
      team2_side = #"attack";
    }
  }

  esports_event = {
    #team1_side: team1_side, #team2_side: team2_side
  };
  function_92d1707f(#"dlog_event_esports_round_start", esports_event);
}

function on_round_end() {
  round_info = function_d757edb5();
  esports_event = {
    #result: function_3d01c1b3(), #win_side: round_info.side, #match_time: function_f8d53445(), #game_type: level.gametype, #map_name: level.map_name, #win_team: function_1674a96a(round_info.win_team), #loss_team: function_1674a96a(round_info.loss_team)
  };
  function_92d1707f(#"dlog_event_esports_round_end", esports_event);
}

function function_6607b43f(esports_event) {
  var_a504287b = self.var_a504287b;
  persistent_data = self.pers;
  objective_time = persistent_data[#"objtime"];
  objective1_time = persistent_data[#"hash_15d08ee09ca7c219"];
  objective2_time = persistent_data[#"hash_15d08be09ca7bd00"];
  objective3_time = persistent_data[#"hash_15d08ce09ca7beb3"];
  objective4_time = persistent_data[#"hash_15d091e09ca7c732"];
  objective5_time = persistent_data[#"hash_15d092e09ca7c8e5"];
  esports_event.objective_time = isDefined(objective_time) ? objective_time - var_a504287b.objective_time : 0;
  esports_event.objective1_time = isDefined(objective1_time) ? objective1_time - var_a504287b.objective1_time : 0;
  esports_event.objective2_time = isDefined(objective2_time) ? objective2_time - var_a504287b.objective2_time : 0;
  esports_event.objective3_time = isDefined(objective3_time) ? objective3_time - var_a504287b.objective3_time : 0;
  esports_event.objective4_time = isDefined(objective4_time) ? objective4_time - var_a504287b.objective4_time : 0;
  esports_event.objective5_time = isDefined(objective5_time) ? objective5_time - var_a504287b.objective5_time : 0;
}

function function_9555b8d2(esports_event) {
  var_a504287b = self.var_a504287b;
  persistent_data = self.pers;
  objective_time = persistent_data[#"objtime"];
  bombs_planted = persistent_data[#"bombplanted"];
  bombs_defused = persistent_data[#"bombdefused"];
  esports_event.objective_time = isDefined(objective_time) ? objective_time - var_a504287b.objective_time : 0;
  esports_event.bombs_planted = isDefined(bombs_planted) ? bombs_planted - var_a504287b.bombs_planted : 0;
  esports_event.bombs_defused = isDefined(bombs_defused) ? bombs_defused - var_a504287b.bombs_defused : 0;
}

function function_b16086a1(esports_event) {
  var_a504287b = self.var_a504287b;
  objective_time = self.pers[#"objtime"];
  tiers_captured = self.pers[#"hash_156cd38474282f8d"];
  esports_event.objective_time = isDefined(objective_time) ? objective_time - var_a504287b.objective_time : 0;
  esports_event.tiers_captured = isDefined(tiers_captured) ? tiers_captured - var_a504287b.tiers_captured : 0;
}

function function_2d28a3b3() {
  var_a504287b = self.var_a504287b;
  persistent_data = self.pers;
  rounds_won = util::getroundswon(self.team);

  if(!isDefined(var_a504287b)) {
    return;
  }

  esports_event = {
    #kills: persistent_data[#"kills"] - var_a504287b.kills, #deaths: persistent_data[#"deaths"] - var_a504287b.deaths, #assists: persistent_data[#"assists"] - var_a504287b.assists, #damage_dealt: persistent_data[#"damagedone"] - var_a504287b.damage_done, #highest_killstreak: var_a504287b.highest_killstreak, #time_alive: persistent_data[#"time_played_alive"] - var_a504287b.time_alive, #rounds_played: game.roundsplayed, #rounds_won: isDefined(rounds_won) ? rounds_won : 0, #score: persistent_data[#"score"] - var_a504287b.score, #shots_fired: persistent_data[#"shotsfired"] - var_a504287b.shots_fired, #shots_hit: persistent_data[#"shotshit"] - var_a504287b.shots_hit, #shots_head: persistent_data[#"headshothits"] - var_a504287b.shots_head, #player: self.name
  };
  var_284ea17f = #"dlog_event_esports_player_round_end";

  if(isDefined(level.var_86d47028)) {
    var_284ea17f = level.var_86d47028.var_284ea17f;
    self[[level.var_86d47028.data_function]](esports_event);
  }

  self function_678f57c8(var_284ea17f, esports_event);
  self.var_7a967a71.round_end = 1;
}

function function_712f816a(esports_event, player) {
  esports_event.is_captured = self.claimant != #"none";
  esports_event.is_contested = self.iscontested;
  esports_event.obj_name = function_ddf02547();

  if(!isDefined(player)) {
    esports_event.player = "none";
    return;
  }

  esports_event.player = player.name;
}

function function_150786f3(esports_event, player) {
  if(!isDefined(player)) {
    esports_event.player = "none";
    esports_event.is_bomb_picked_up = 0;
  } else {
    esports_event.player = player.name;
    esports_event.is_bomb_picked_up = player.isbombcarrier;
  }

  esports_event.obj_name = function_a6f108b5();
  esports_event.is_bomb_planted = level.bombplanted;
  esports_event.is_bomb_defused = level.bombdefused;
}

function function_cdce904b(esports_event, player) {
  var_1cb1e802 = level.var_1cb1e802;
  esports_event.player = player.name;
  esports_event.obj_name = function_d4ad62c7();
  esports_event.is_captured = self.claimant != #"none";
  esports_event.is_contested = self.contested;
  esports_event.team1_remaining_lives = game.lives[#"allies"];
  esports_event.team2_remaining_lives = game.lives[#"axis"];
  esports_event.var_34f440e5 = isDefined(var_1cb1e802[0]) ? var_1cb1e802[0] : 0;
  esports_event.var_e428312f = isDefined(var_1cb1e802[1]) ? var_1cb1e802[1] : 0;
}

function function_d5aacfd7(credit_player) {
  if(!is_true(self.var_3517bb1)) {
    return;
  }

  origin = self.origin;
  esports_event = {
    #var_94e96e7d: origin[0], #var_830acac0: origin[1], #var_94d1ee7a: origin[2], #obj_team: function_1674a96a(isDefined(credit_player.team) ? credit_player.team : self.claimant), #match_time: function_f8d53445()
  };
  var_284ea17f = #"dlog_event_esports_objective_state_changed";

  if(isDefined(level.var_8d67cbd8)) {
    var_284ea17f = level.var_8d67cbd8.var_284ea17f;
    self[[level.var_8d67cbd8.data_function]](esports_event, credit_player);
  }

  function_92d1707f(var_284ea17f, esports_event);
}

function function_48541d37(zones) {
  objectives_info = [];

  for(zone_index = 0; zone_index < zones.size; zone_index++) {
    origin = zones[zone_index].origin;
    objective_info = {
      #obj_name: "point_" + zone_index + 1, #origin_x: origin[0], #origin_y: origin[1], #origin_z: origin[2]
    };

    if(!isDefined(objectives_info)) {
      objectives_info = [];
    } else if(!isarray(objectives_info)) {
      objectives_info = array(objectives_info);
    }

    objectives_info[objectives_info.size] = objective_info;
  }

  return objectives_info;
}

function function_f2282b8b() {
  objectives_info = function_48541d37(level.zones);
  function_92d1707f(#"hash_728e50d0434b4a22", #"objective1_info", isDefined(objectives_info[0]) ? objectives_info[0] : {}, #"objective2_info", isDefined(objectives_info[1]) ? objectives_info[1] : {}, #"objective3_info", isDefined(objectives_info[2]) ? objectives_info[2] : {}, #"hash_63c1781e1881c679", isDefined(objectives_info[3]) ? objectives_info[3] : {}, #"hash_85376cdd236d6e4", isDefined(objectives_info[4]) ? objectives_info[4] : {});
}

function function_ceb40ef4() {
  objectives_info = function_48541d37(level.bombzones);
  function_92d1707f(#"hash_3f1baae52561df70", #"objective1_info", isDefined(objectives_info[0]) ? objectives_info[0] : {}, #"objective2_info", isDefined(objectives_info[1]) ? objectives_info[1] : {});
}

function function_a9b19a49() {
  objectives_info = function_48541d37(level.zones);
  control_info = {
    #team1_lives: game.lives[#"allies"], #team2_lives: game.lives[#"axis"]
  };
  function_92d1707f(#"dlog_event_esports_objective_info_control", #"objective1_info", isDefined(objectives_info[0]) ? objectives_info[0] : {}, #"objective2_info", isDefined(objectives_info[1]) ? objectives_info[1] : {}, #"control_info", control_info);
}