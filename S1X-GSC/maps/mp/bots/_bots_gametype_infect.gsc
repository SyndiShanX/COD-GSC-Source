/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_infect.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\bots\_bots_personality;
#include maps\mp\bots\_bots_gametype_common;

INFECTED_BOT_MELEE_DESPERATION_TIME = 3000;
INFECTED_BOT_MAX_NODE_DIST_SQ = (96 * 96);
INFECTED_BOT_MELEE_MIN_DIST_SQ = (48 * 48);

main() {
  setup_callbacks();
  setup_bot_infect();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_infect_think;
  level.bot_funcs["should_pickup_weapons"] = ::bot_should_pickup_weapons_infect;
}

setup_bot_infect() {
  level.bots_gametype_handles_class_choice = true;
  level.bots_ignore_team_balance = true;
  level.bots_gametype_handles_team_choice = true;
  level.infected_knife_name = "exoknife_mp";
  Assert(maps\mp\gametypes\_class::isValidEquipment(level.infected_knife_name, false));

  thread bot_infect_ai_director_update();
}

bot_should_pickup_weapons_infect() {
  if(level.infect_choseFirstInfected && self.team == "axis") {
    return false;
  }

  return maps\mp\bots\_bots::bot_should_pickup_weapons();
}

bot_infect_think() {
  self notify("bot_infect_think");
  self endon("bot_infect_think");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self childthread bot_infect_retrieve_knife();

  while(true) {
    if(level.infect_choseFirstInfected) {
      if(self.team == "axis" && self BotGetPersonality() != "run_and_gun") {
        self bot_set_personality("run_and_gun");
      }
    }

    if(self.bot_team != self.team) {
      self.bot_team = self.team;
    }

    if(self.team == "axis") {
      result = self bot_melee_tactical_insertion_check();
      if(!isDefined(result) || result) {
        self BotClearScriptGoal();
      }
    }

    self[[self.personality_update_function]]();

    wait(0.05);
  }
}

SCR_CONST_INFECT_HIDING_CHECK_TIME = 5000;

bot_infect_ai_director_update() {
  level notify("bot_infect_ai_director_update");
  level endon("bot_infect_ai_director_update");
  level endon("game_ended");

  while(1) {
    infected_players = [];
    non_infected_players = [];
    foreach(player in level.players) {
      if(!isDefined(player.initial_spawn_time) && player.health > 0 && isDefined(player.team) && (player.team == "allies" || player.team == "axis")) {
        player.initial_spawn_time = GetTime();
      }

      if(isDefined(player.initial_spawn_time) && GetTime() - player.initial_spawn_time > 5000) {
        if(!isDefined(player.team)) {
          continue;
        }

        if(player.team == "axis") {
          infected_players[infected_players.size] = player;
        } else if(player.team == "allies") {
          non_infected_players[non_infected_players.size] = player;
        }
      }
    }

    if(infected_players.size > 0 && non_infected_players.size > 0) {
      all_bots_are_infected = true;
      foreach(non_infected_player in non_infected_players) {
        if(IsBot(non_infected_player)) {
          all_bots_are_infected = false;
        }
      }

      if(all_bots_are_infected) {
        foreach(player in non_infected_players) {
          if(!isDefined(player.last_infected_hiding_time)) {
            player.last_infected_hiding_time = GetTime();
            player.last_infected_hiding_loc = player.origin;
            player.time_spent_hiding = 0;
          }

          if(GetTime() >= player.last_infected_hiding_time + SCR_CONST_INFECT_HIDING_CHECK_TIME) {
            player.last_infected_hiding_time = GetTime();
            dist_to_last_hiding_loc_sq = DistanceSquared(player.origin, player.last_infected_hiding_loc);
            player.last_infected_hiding_loc = player.origin;
            if(dist_to_last_hiding_loc_sq < 300 * 300) {
              player.time_spent_hiding += SCR_CONST_INFECT_HIDING_CHECK_TIME;
              if(player.time_spent_hiding >= 20000) {
                infected_players_sorted = get_array_of_closest(player.origin, infected_players);
                foreach(infected_player in infected_players_sorted) {
                  if(IsBot(infected_player)) {
                    goal_type = infected_player BotGetScriptGoalType();
                    if(goal_type != "tactical" && goal_type != "critical") {
                      infected_player thread hunt_human(player);
                      break;
                    }
                  }
                }
              }
            } else {
              player.time_spent_hiding = 0;
              player.last_infected_hiding_loc = player.origin;
            }
          }
        }
      }
    }

    wait(1.0);
  }
}

hunt_human(player_hunting) {
  self endon("disconnect");
  self endon("death");

  self BotSetScriptGoal(player_hunting.origin, 0, "critical");
  self bot_waittill_goal_or_fail();
  self BotClearScriptGoal();
}

bot_infect_retrieve_knife() {
  if(self.team == "axis") {
    self.can_melee_enemy_time = 0;
    self.melee_enemy = undefined;
    self.melee_enemy_node = undefined;
    self.melee_enemy_new_node_time = 0;
    self.melee_self_node = undefined;
    self.melee_self_new_node_time = 0;

    throwKnifeChance = self BotGetDifficultySetting("throwKnifeChance");
    if(throwKnifeChance < 0.25) {
      self BotSetDifficultySetting("throwKnifeChance", 0.25);
    }
    self BotSetDifficultySetting("allowGrenades", 1);

    while(true) {
      if(self HasWeapon(level.infected_knife_name)) {
        if(IsGameParticipant(self.enemy)) {
          time = GetTime();
          if(!isDefined(self.melee_enemy) || self.melee_enemy != self.enemy) {
            self.melee_enemy = self.enemy;
            self.melee_enemy_node = self.enemy GetNearestNode();
            self.melee_enemy_new_node_time = time;
          } else {
            meleeDistSq = squared(self BotGetDifficultySetting("meleeDist"));

            if(DistanceSquared(self.enemy.origin, self.origin) <= meleeDistSq) {
              self.can_melee_enemy_time = time;
            }

            melee_enemy_node = self.enemy GetNearestNode();
            melee_self_node = self GetNearestNode();

            if(!isDefined(self.melee_enemy_node) || self.melee_enemy_node != melee_enemy_node) {
              self.melee_enemy_new_node_time = time;
              self.melee_enemy_node = melee_enemy_node;
            }
            if(!isDefined(self.melee_self_node) || self.melee_self_node != melee_self_node) {
              self.melee_self_new_node_time = time;
              self.melee_self_node = melee_self_node;
            } else if(DistanceSquared(self.origin, self.melee_self_node.origin) > INFECTED_BOT_MAX_NODE_DIST_SQ) {
              self.melee_self_at_same_node_time = time;
            }

            if(self.can_melee_enemy_time + INFECTED_BOT_MELEE_DESPERATION_TIME < time) {
              if(self.melee_self_new_node_time + INFECTED_BOT_MELEE_DESPERATION_TIME < time) {
                if(self.melee_enemy_new_node_time + INFECTED_BOT_MELEE_DESPERATION_TIME < time) {
                  if(bot_infect_angle_too_steep_for_knife_throw(self.origin, self.enemy.origin)) {
                    self bot_queued_process("find_node_can_see_ent", ::bot_infect_find_node_can_see_ent, self.enemy, self.melee_self_node);
                  }
                  if(!(self GetAmmoCount(level.infected_knife_name))) {
                    self SetWeaponAmmoClip(level.infected_knife_name, 1);
                  }

                  self waitForTimeOrNotify(30, "enemy");
                  self BotClearScriptGoal();
                }
              }
            }
          }
        }
      }
      wait(0.25);
    }
  }
}

bot_infect_angle_too_steep_for_knife_throw(testOrigin, testDest) {
  if(abs(testOrigin[2] - testDest[2]) > 56.0 && Distance2DSquared(testOrigin, testDest) < INFECTED_BOT_MELEE_MIN_DIST_SQ) {
    return true;
  }

  return false;
}

bot_infect_find_node_can_see_ent(targetEnt, startNode) {
  if(!isDefined(targetEnt) || !isDefined(startNode)) {
    return;
  }

  at_begin_node = false;
  if(IsSubStr(startNode.type, "Begin")) {
    at_begin_node = true;
  }

  neighborNodes = GetLinkedNodes(startNode);
  if(isDefined(neighborNodes) && neighborNodes.size) {
    neighborNodesRandom = array_randomize(neighborNodes);
    foreach(nNode in neighborNodesRandom) {
      if(at_begin_node && IsSubStr(nNode.type, "End")) {
        continue;
      }

      if(bot_infect_angle_too_steep_for_knife_throw(nNode.origin, targetEnt.origin)) {
        continue;
      }

      eyeOfs = self getEye() - self.origin;
      start = nNode.origin + eyeOfs;

      end = targetEnt.origin;
      if(IsPlayer(targetEnt)) {
        end = targetEnt getStanceCenter();
      }

      if(SightTracePassed(start, end, false, self, targetEnt)) {
        yaw = VectorToYaw(end - start);
        self BotSetScriptGoalNode(nNode, "critical", yaw);
        self bot_waittill_goal_or_fail(3.0);
        return;
      }
      wait(0.05);
    }
  }
}