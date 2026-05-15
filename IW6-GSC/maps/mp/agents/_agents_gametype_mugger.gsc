/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\_agents_gametype_mugger.gsc
******************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\bots\_bots_personality;

main() {
  setup_callbacks();
}

setup_callbacks() {
  level.agent_funcs["squadmate"]["gametype_update"] = ::agent_squadmember_mugger_think;
  level.agent_funcs["player"]["think"] = ::agent_player_mugger_think;
}

agent_player_mugger_think() {
  self thread maps\mp\bots\_bots_gametype_mugger::bot_mugger_think();
}

agent_squadmember_mugger_think() {
  if(!isDefined(self.tags_seen_by_owner)) {
    self.tags_seen_by_owner = [];
  }

  if(!isDefined(self.next_time_check_tags)) {
    self.next_time_check_tags = GetTime() + 500;
  }

  if(GetTime() > self.next_time_check_tags) {
    self.next_time_check_tags = GetTime() + 500;

    current_player_fov = 0.78;
    if(IsBot(self.owner)) {
      current_player_fov = self BotGetFovDot();
    }
    nearest_node_to_player = self.owner GetNearestNode();
    if(isDefined(nearest_node_to_player)) {
      new_visible_tags_to_player = self.owner maps\mp\bots\_bots_gametype_mugger::bot_find_visible_tags_mugger(nearest_node_to_player, current_player_fov);
      self.tags_seen_by_owner = maps\mp\bots\_bots_gametype_conf::bot_combine_tag_seen_arrays(new_visible_tags_to_player, self.tags_seen_by_owner);
    }
  }

  self.tags_seen_by_owner = self maps\mp\bots\_bots_gametype_conf::bot_remove_invalid_tags(self.tags_seen_by_owner);
  best_tag = self maps\mp\bots\_bots_gametype_conf::bot_find_best_tag_from_array(self.tags_seen_by_owner, false);

  if(isDefined(best_tag)) {
    if(!isDefined(self.tag_getting) || DistanceSquared(best_tag.curorigin, self.tag_getting.curorigin) > 1) {
      self.tag_getting = best_tag;
      self bot_defend_stop();
      self BotSetScriptGoal(self.tag_getting.curorigin, 0, "objective", undefined, level.bot_tag_obj_radius);
    }

    return true;
  } else if(isDefined(self.tag_getting)) {
    self BotClearScriptGoal();
    self.tag_getting = undefined;
  }

  return false;
}