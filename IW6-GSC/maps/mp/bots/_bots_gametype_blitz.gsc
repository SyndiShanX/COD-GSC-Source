/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_blitz.gsc
*************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;

main() {
  setup_callbacks();
  setup_bot_blitz();
}

empty_function_to_force_script_dev_compile() {}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_blitz_think;
}

setup_bot_blitz() {
  bot_waittill_bots_enabled(true);

  level.protect_radius = 600;
  thread bot_blitz_ai_director_update();
  level.bot_gametype_precaching_done = true;
}

bot_blitz_think() {
  self notify("bot_blitz_think");
  self endon("bot_blitz_think");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  self BotSetFlag("separation", 0);

  while(true) {
    wait(0.05);

    if(!isDefined(self.role)) {
      self initialize_blitz_role();
    }

    if(bot_has_tactical_goal()) {
      continue;
    }
    if(self.role == "attacker") {
      target_portal = level.portalList[get_enemy_team(self.team)];
      if(target_portal.open) {
        if(self bot_is_defending()) {
          self bot_defend_stop();
        }

        if(!self BotHasScriptGoal()) {
          self BotSetScriptGoal(target_portal.origin, 0, "objective");
        }
      } else {
        if(!bot_is_defending()) {
          self BotClearScriptGoal();
          self bot_protect_point(target_portal.origin, level.protect_radius);
        }
      }
    } else if(self.role == "defender") {
      target_portal = level.portalList[self.team];
      if(!self bot_is_defending_point(target_portal.origin)) {
        optional_params["min_goal_time"] = 20;
        optional_params["max_goal_time"] = 30;
        optional_params["score_flags"] = "strict_los";
        self bot_protect_point(target_portal.origin, level.protect_radius, optional_params);
      }
    }
  }
}

initialize_blitz_role() {
  attackers = get_allied_attackers_for_team(self.team);
  defenders = get_allied_defenders_for_team(self.team);
  attacker_limit = blitz_bot_attacker_limit_for_team(self.team);
  defender_limit = blitz_bot_defender_limit_for_team(self.team);

  personality_type = level.bot_personality_type[self.personality];
  if(personality_type == "active") {
    if(attackers.size >= attacker_limit) {
      kicked_out_bot = false;
      foreach(attacker in attackers) {
        if(IsAI(attacker) && level.bot_personality_type[attacker.personality] == "stationary") {
          attacker.role = undefined;
          kicked_out_bot = true;
          break;
        }
      }

      if(kicked_out_bot) {
        self blitz_set_role("attacker");
      }
      else {
        self blitz_set_role("defender");
      }
    } else {
      self blitz_set_role("attacker");
    }
  } else if(personality_type == "stationary") {
    if(defenders.size >= defender_limit) {
      kicked_out_bot = false;
      foreach(defender in defenders) {
        if(IsAI(defender) && level.bot_personality_type[defender.personality] == "active") {
          defender.role = undefined;
          kicked_out_bot = true;
          break;
        }
      }

      if(kicked_out_bot) {
        self blitz_set_role("defender");
      }
      else {
        self blitz_set_role("attacker");
      }
    } else {
      self blitz_set_role("defender");
    }
  }
}

bot_blitz_ai_director_update() {
  level notify("bot_blitz_ai_director_update");
  level endon("bot_blitz_ai_director_update");
  level endon("game_ended");

  teams[0] = "allies";
  teams[1] = "axis";

  while(1) {
    foreach(team in teams) {
      attacker_limit = blitz_bot_attacker_limit_for_team(team);
      defender_limit = blitz_bot_defender_limit_for_team(team);

      attackers = get_allied_attackers_for_team(team);
      defenders = get_allied_defenders_for_team(team);

      if(attackers.size > attacker_limit) {
        ai_attackers = [];
        removed_attacker = false;
        foreach(attacker in attackers) {
          if(IsAI(attacker)) {
            if(level.bot_personality_type[attacker.personality] == "stationary") {
              attacker blitz_set_role("defender");
              removed_attacker = true;
              break;
            } else {
              ai_attackers = array_add(ai_attackers, attacker);
            }
          }
        }

        if(!removed_attacker && ai_attackers.size > 0) {
          Random(ai_attackers) blitz_set_role("defender");
        }
      }

      if(defenders.size > defender_limit) {
        ai_defenders = [];
        removed_defender = false;
        foreach(defender in defenders) {
          if(IsAI(defender)) {
            if(level.bot_personality_type[defender.personality] == "active") {
              defender blitz_set_role("attacker");
              removed_defender = true;
              break;
            } else {
              ai_defenders = array_add(ai_defenders, defender);
            }
          }
        }

        if(!removed_defender && ai_defenders.size > 0) {
          Random(ai_defenders) blitz_set_role("attacker");
        }
      }
    }

    wait(1.0);
  }
}

blitz_bot_attacker_limit_for_team(team) {
  team_limit = blitz_get_num_players_on_team(team);
  return int(int(team_limit) / 2) + 1 + (int(team_limit) % 2);
}

blitz_bot_defender_limit_for_team(team) {
  team_limit = blitz_get_num_players_on_team(team);
  return max(int(int(team_limit) / 2) - 1, 0);
}

blitz_get_num_players_on_team(team) {
  num_on_team = 0;
  foreach(player in level.participants) {
    if(IsTeamParticipant(player) && isDefined(player.team) && player.team == team) {
      num_on_team++;
    }
  }

  return num_on_team;
}

get_allied_attackers_for_team(team) {
  attackers = get_players_by_role("attacker", team);

  foreach(player in level.players) {
    if(!IsAI(player) && isDefined(player.team) && player.team == team) {
      if(DistanceSquared(level.portalList[team].origin, player.origin) > level.protect_radius * level.protect_radius) {
        attackers = array_add(attackers, player);
      }
    }
  }

  return attackers;
}

get_allied_defenders_for_team(team) {
  defenders = get_players_by_role("defender", team);

  foreach(player in level.players) {
    if(!IsAI(player) && isDefined(player.team) && player.team == team) {
      if(DistanceSquared(level.portalList[team].origin, player.origin) <= level.protect_radius * level.protect_radius) {
        defenders = array_add(defenders, player);
      }
    }
  }

  return defenders;
}

blitz_set_role(new_role) {
  self.role = new_role;
  self BotClearScriptGoal();
  self bot_defend_stop();
}

get_players_by_role(role, team) {
  players = [];
  foreach(player in level.participants) {
    if(!isDefined(player.team)) {
      continue;
    }
    if(IsAlive(player) && IsTeamParticipant(player) && player.team == team && isDefined(player.role) && player.role == role) {
      players[players.size] = player;
    }
  }

  return players;
}