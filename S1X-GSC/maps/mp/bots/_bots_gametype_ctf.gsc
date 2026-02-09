/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_ctf.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\bots\_bots_personality;
#include maps\mp\bots\_bots_gametype_common;

SCR_CONST_CTF_BOTS_IGNORE_HUMAN_PLAYER_ROLES = false;

main() {
  setup_callbacks();
  setup_bot_ctf();
}

empty_function_to_force_script_dev_compile() {}

setup_callbacks() {
  level.bot_funcs["crate_can_use"] = ::crate_can_use;
  level.bot_funcs["gametype_think"] = ::bot_ctf_think;
  level.bot_funcs["get_watch_node_chance"] = ::bot_ctf_get_node_chance;
}

setup_bot_ctf() {
  if(SCR_CONST_CTF_BOTS_IGNORE_HUMAN_PLAYER_ROLES) {
    level.bot_gametype_ignore_human_player_roles = true;
  }

  level.bot_gametype_attacker_limit_for_team = ::ctf_bot_attacker_limit_for_team;
  level.bot_gametype_defender_limit_for_team = ::ctf_bot_defender_limit_for_team;
  level.bot_gametype_allied_attackers_for_team = ::get_allied_attackers_for_team;
  level.bot_gametype_allied_defenders_for_team = ::get_allied_defenders_for_team;

  bot_waittill_bots_enabled();

  while(!isDefined(level.teamFlags)) {
    wait(0.05);
  }

  level.teamFlags["allies"].script_label = "allies";
  level.teamFlags["axis"].script_label = "axis";

  bot_cache_entrances_to_gametype_array(level.teamFlags, "flag_");

  zone = GetZoneNearest(level.teamFlags["allies"].origin);
  if(isDefined(zone)) {
    BotZoneSetTeam(zone, "allies");
  }

  zone = GetZoneNearest(level.teamFlags["axis"].origin);
  if(isDefined(zone)) {
    BotZoneSetTeam(zone, "axis");
  }

  level.capZones["allies"].nearest_node = level.teamFlags["allies"].nearest_node;
  level.capZones["axis"].nearest_node = level.teamFlags["axis"].nearest_node;

  thread bot_ctf_ai_director_update();

  level.bot_gametype_precaching_done = true;
}

crate_can_use(crate) {
  if(IsAgent(self) && !isDefined(crate.boxType)) {
    return false;
  }

  if(isDefined(self.carryFlag)) {
    return false;
  }

  return (level.teamFlags[self.team] maps\mp\gametypes\_gameobjects::isHome());
}

bot_ctf_think() {
  self notify("bot_ctf_think");
  self endon("bot_ctf_think");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  self.next_time_hunt_carrier = 0;
  self.next_flag_hide_time = 0;
  self BotSetFlag("separation", 0);
  self BotSetFlag("use_obj_path_style", true);

  set_scripted_pathing_style = false;
  wants_scripted_pathing_style = false;

  for(;;) {
    wait(0.05);

    if(self.health <= 0) {
      continue;
    }

    if(!isDefined(self.role)) {
      self bot_gametype_initialize_attacker_defender_role();
    }

    sprint_desired = false;
    if(self.role == "attacker") {
      if(isDefined(self.carryFlag)) {
        sprint_desired = true;
      } else if(!isDefined(level.flag_carriers[self.team])) {
        sprint_desired = DistanceSquared(self.origin, level.teamFlags[level.otherTeam[self.team]].curorigin) < squared(get_flag_protect_radius());
      }
    } else {
      if(!level.teamFlags[self.team] maps\mp\gametypes\_gameobjects::isHome()) {
        sprint_desired = !isDefined(level.flag_carriers[level.otherTeam[self.team]]);
      }
    }
    self BotSetFlag("force_sprint", sprint_desired);

    wants_scripted_pathing_style = false;
    if(isDefined(self.carryFlag)) {
      self clear_defend();
      if(!isDefined(level.flag_carriers[level.otherTeam[self.team]])) {
        wants_scripted_pathing_style = true;

        if(!set_scripted_pathing_style) {
          set_scripted_pathing_style = true;
          self BotSetPathingStyle("scripted");
        }

        self BotSetScriptGoal(level.capZones[self.team].curorigin, 16, "critical");
      } else if(GetTime() > self.next_flag_hide_time) {
        nodes = GetNodesInRadius(level.capZones[self.team].curorigin, 900, 0, 300);
        hide_node = self BotNodePick(nodes, nodes.size * 0.15, "node_hide_anywhere");
        if(!isDefined(hide_node)) {
          hide_node = level.capZones[self.team].nearest_node;
        }

        Assert(isDefined(hide_node));
        success = self BotSetScriptGoalNode(hide_node, "critical");
        if(success) {
          self.next_flag_hide_time = GetTime() + 15000;
        }
      }
    } else if(self.role == "attacker") {
      if(isDefined(level.flag_carriers[self.team])) {
        if(!self bot_is_bodyguarding()) {
          self clear_defend();
          self BotClearScriptGoal();
          self bot_guard_player(level.flag_carriers[self.team], 500);
        }
      } else {
        self clear_defend();
        if(self BotGetScriptGoalType() == "critical") {
          self BotClearScriptGoal();
        }
        self BotSetScriptGoal(level.teamFlags[level.otherTeam[self.team]].curorigin, 16, "objective", undefined, 300);
      }
    } else {
      Assert(self.role == "defender");

      if(!level.teamFlags[self.team] maps\mp\gametypes\_gameobjects::isHome()) {
        if(!isDefined(level.flag_carriers[level.otherTeam[self.team]])) {
          self clear_defend();
          self BotSetScriptGoal(level.teamFlags[self.team].curorigin, 16, "critical");
        } else {
          flag_carrier = level.flag_carriers[level.otherTeam[self.team]];
          if(GetTime() > self.next_time_hunt_carrier || self BotCanSeeEntity(flag_carrier)) {
            self clear_defend();
            self BotSetScriptGoal(flag_carrier.origin, 16, "critical");
            self.next_time_hunt_carrier = GetTime() + RandomIntRange(4500, 5500);
          }
        }
      } else if(!self is_protecting_flag()) {
        self BotClearScriptGoal();
        optional_params["score_flags"] = "strict_los";
        optional_params["entrance_points_index"] = "flag_" + level.teamFlags[self.team].script_label;
        optional_params["nearest_node_to_center"] = level.teamFlags[self.team].nearest_node;
        self bot_protect_point(level.teamFlags[self.team].curorigin, get_flag_protect_radius(), optional_params);
      }
    }

    if(set_scripted_pathing_style && !wants_scripted_pathing_style) {
      set_scripted_pathing_style = false;
      self BotSetPathingStyle(undefined);
    }
  }
}

clear_defend() {
  if(self bot_is_defending()) {
    self bot_defend_stop();
  }
}

is_protecting_flag() {
  return (self bot_is_protecting());
}

get_flag_protect_radius() {
  if(IsAlive(self) && !isDefined(level.protect_radius)) {
    worldBounds = self BotGetWorldSize();
    average_side = (worldBounds[0] + worldBounds[1]) / 2;
    level.protect_radius = min(800, average_side / 5.5);
  }

  if(!isDefined(level.protect_radius)) {
    return 900;
  }

  return level.protect_radius;
}

ctf_bot_attacker_limit_for_team(team) {
  team_limit = bot_gametype_get_num_players_on_team(team);
  num_attackers_wanted_raw = team_limit * 0.67;

  floor_num = floor(num_attackers_wanted_raw);
  ceil_num = ceil(num_attackers_wanted_raw);
  dist_to_floor = num_attackers_wanted_raw - floor_num;
  dist_to_ceil = ceil_num - num_attackers_wanted_raw;

  if(dist_to_floor < dist_to_ceil) {
    num_attackers_wanted = int(floor_num);
  } else {
    num_attackers_wanted = int(ceil_num);
  }

  my_score = game["teamScores"][team];
  enemy_score = game["teamScores"][get_enemy_team(team)];

  if(my_score + 1 < enemy_score) {
    num_attackers_wanted = int(min(num_attackers_wanted + 1, team_limit));
  }

  return num_attackers_wanted;
}

ctf_bot_defender_limit_for_team(team) {
  team_limit = bot_gametype_get_num_players_on_team(team);
  return (team_limit - ctf_bot_attacker_limit_for_team(team));
}

get_allied_attackers_for_team(team) {
  return bot_gametype_get_allied_attackers_for_team(team, level.capZones[team].curorigin, get_flag_protect_radius());
}

get_allied_defenders_for_team(team) {
  return bot_gametype_get_allied_defenders_for_team(team, level.capZones[team].curorigin, get_flag_protect_radius());
}

bot_ctf_ai_director_update() {
  level notify("bot_ctf_ai_director_update");
  level endon("bot_ctf_ai_director_update");
  level endon("game_ended");

  level.flag_carriers = [];
  thread bot_gametype_attacker_defender_ai_director_update();

  while(1) {
    level.flag_carriers["allies"] = undefined;
    level.flag_carriers["axis"] = undefined;
    foreach(player in level.participants) {
      if(IsAlive(player) && isDefined(player.carryFlag)) {
        assert(IsTeamParticipant(player));
        level.flag_carriers[player.team] = player;
      }
    }

    wait(0.05);
  }
}

bot_ctf_get_node_chance(node) {
  if(node == self.node_closest_to_defend_center) {
    return 1.0;
  }

  if(!self is_protecting_flag()) {
    return 1.0;
  }

  node_on_path_to_enemy_flag = node node_is_on_path_from_labels("flag_allies", "flag_axis");

  if(node_on_path_to_enemy_flag) {
    return 1.0;
  }

  return 0.2;
}