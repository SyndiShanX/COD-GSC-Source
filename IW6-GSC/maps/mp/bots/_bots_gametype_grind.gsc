/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_grind.gsc
*************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\bots\_bots_personality;

MAX_MELEE_CHARGE_DIST = 500;

main() {
  setup_callbacks();
  maps\mp\bots\_bots_gametype_conf::setup_bot_conf();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_grind_think;
}

bot_grind_think() {
  self notify("bot_grind_think");
  self endon("bot_grind_think");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self.grind_waiting_to_bank = false;
  self.goal_zone = undefined;
  self.conf_camping_zone = false;
  self.additional_tactical_logic_func = ::bot_grind_extra_think;
  if(self BotGetDifficultySetting("strategyLevel") > 0) {
    self childthread enemy_watcher();
  }

  maps\mp\bots\_bots_gametype_conf::bot_conf_think();
}

bot_grind_extra_think() {
  if(!isDefined(self.tag_getting)) {
    if(self.tagsCarried > 0) {
      bestDistSq = squared(500 + self.tagsCarried * 250);
      if(game["teamScores"][self.team] + self.tagsCarried >= getWatchedDvar("scorelimit")) {
        bestDistSq = squared(5000);
      } else if(!isDefined(self.enemy) && !self bot_in_combat()) {
        bestDistSq = squared(1500 + self.tagsCarried * 250);
      }
      bestZone = undefined;
      foreach(zone in level.zoneList) {
        distSq = DistanceSquared(self.origin, zone.origin);
        if(distSq < bestDistSq) {
          bestDistSq = distSq;
          bestZone = zone;
        }
      }

      if(isDefined(bestZone)) {
        set_new_goal = true;
        if(self.grind_waiting_to_bank) {
          if(isDefined(self.goal_zone) && self.goal_zone == bestZone) {
            set_new_goal = false;
          }
        }

        if(set_new_goal) {
          self.grind_waiting_to_bank = true;
          self.goal_zone = bestZone;

          self BotClearScriptGoal();

          self notify("stop_going_to_zone");

          self notify("stop_camping_zone");
          self.conf_camping_zone = false;
          self clear_camper_data();

          self bot_abort_tactical_goal("kill_tag");

          self childthread bot_goto_zone(bestZone, "tactical");
        }
      }

      if(self.grind_waiting_to_bank) {
        if(game["teamScores"][self.team] + self.tagsCarried >= getWatchedDvar("scorelimit")) {
          self BotSetFlag("force_sprint", true);
        }
      }
    } else if(self.grind_waiting_to_bank) {
      self.grind_waiting_to_bank = false;
      self.goal_zone = undefined;
      self notify("stop_going_to_zone");
      self BotClearScriptGoal();
    }

    if(self.personality == "camper" && !self.conf_camping_tag && !self.grind_waiting_to_bank) {
      bestDistSq = undefined;
      bestZone = undefined;
      foreach(zone in level.zoneList) {
        distSq = DistanceSquared(self.origin, zone.origin);
        if(!isDefined(bestDistSq) || distSq < bestDistSq) {
          bestDistSq = distSq;
          bestZone = zone;
        }
      }

      if(isDefined(bestZone)) {
        if(self should_select_new_ambush_point()) {
          if(find_ambush_node(bestZone.origin)) {
            self.conf_camping_zone = true;
            self notify("stop_going_to_zone");
            self.grind_waiting_to_bank = false;
            self BotClearScriptGoal();
            self childthread bot_camp_zone(bestZone, "camp");
          } else {
            self notify("stop_camping_zone");
            self.conf_camping_zone = false;
            self clear_camper_data();
          }
        }
      } else {
        self.conf_camping_zone = true;
      }
    }
  } else {
    self notify("stop_going_to_zone");
    self.grind_waiting_to_bank = false;
    self.goal_zone = undefined;
    self notify("stop_camping_zone");
    self.conf_camping_zone = false;
  }

  return (self.grind_waiting_to_bank || self.conf_camping_zone);
}

bot_goto_zone(zone, goal_type) {
  self endon("stop_going_to_zone");

  if(!isDefined(zone.calculated_nearest_node)) {
    zone.nearest_node = GetClosestNodeInSight(zone.origin);
    zone.calculated_nearest_node = true;
  }
  nearest_node_to_zone = zone.nearest_node;

  self BotSetScriptGoal(nearest_node_to_zone.origin, 32, goal_type);
  result = self bot_waittill_goal_or_fail();
}

bot_camp_zone(zone, goal_type) {
  self endon("stop_camping_zone");

  self BotSetScriptGoalNode(self.node_ambushing_from, goal_type, self.ambush_yaw);
  result = self bot_waittill_goal_or_fail();

  if(result == "goal") {
    if(!isDefined(zone.calculated_nearest_node)) {
      zone.nearest_node = GetClosestNodeInSight(zone.origin);
      zone.calculated_nearest_node = true;
    }
    nearest_node_to_zone = zone.nearest_node;
    if(isDefined(nearest_node_to_zone)) {
      nodes_to_watch = FindEntrances(self.origin);
      nodes_to_watch = array_add(nodes_to_watch, nearest_node_to_zone);
      self childthread bot_watch_nodes(nodes_to_watch);
    }
  }
}

enemy_watcher() {
  self.default_meleeChargeDist = self BotGetDifficultySetting("meleeChargeDist");

  while(1) {
    if(self BotGetDifficultySetting("strategyLevel") < 2) {
      wait(0.5);
    } else {
      wait(0.2);
    }

    if(isDefined(self.enemy) && IsPlayer(self.enemy) && isDefined(self.enemy.tagsCarried) && self.enemy.tagsCarried >= 3 && self BotCanSeeEntity(self.enemy) && Distance(self.origin, self.enemy.origin) <= MAX_MELEE_CHARGE_DIST) {
      self BotSetDifficultySetting("meleeChargeDist", MAX_MELEE_CHARGE_DIST);
      self BotSetFlag("prefer_melee", true);
    } else {
      self BotSetDifficultySetting("meleeChargeDist", self.default_meleeChargeDist);
      self BotSetFlag("prefer_melee", false);
    }
  }
}