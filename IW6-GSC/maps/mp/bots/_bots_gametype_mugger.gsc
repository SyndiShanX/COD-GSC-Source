/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_mugger.gsc
**************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\bots\_bots_personality;

MAX_TAG_PILE_TIME = 7500;
MAX_MELEE_CHARGE_DIST = 500;
MAX_TAG_AWARE_DIST_SQ = (350 * 350);
MAX_TAG_SIGHT_DIST_SQ = (1000 * 1000);

main() {
  level.bot_tag_obj_radius = 200;

  setup_callbacks();
}

empty_function_to_force_script_dev_compile() {}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_mugger_think;
  level.bot_funcs["gametype_loadout_modify"] = ::bot_mugger_loadout_modify;
}

bot_mugger_think() {
  self notify("bot_mugger_think");
  self endon("bot_mugger_think");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self.last_killtag_tactical_goal_pos = (0, 0, 0);
  self.tag_getting = undefined;

  self.heading_for_tag_pile = false;

  self.hiding_until_bank = false;

  self.default_meleeChargeDist = self BotGetDifficultySetting("meleeChargeDist");

  self childthread tag_watcher();
  if(self BotGetDifficultySetting("strategyLevel") > 0) {
    self childthread tag_pile_watcher();
  }
  if(self BotGetDifficultySetting("strategyLevel") > 0) {
    self childthread enemy_watcher();
  }

  while(true) {
    if(self BotGetDifficultySetting("strategyLevel") > 1) {
      if(isDefined(self.tags_carried) && level.mugger_bank_limit <= self.tags_carried) {
        if(!self.hiding_until_bank) {
          hide_nodes = GetNodesInRadius(self.origin, 1000, 0, 500, "node_hide");
          best_hide_node = self BotNodePick(hide_nodes, 3, "node_hide");
          if(isDefined(best_hide_node)) {
            self BotSetScriptGoalNode(best_hide_node, "critical");
            self.hiding_until_bank = true;
          }
        }
      } else if(self.hiding_until_bank) {
        self BotClearScriptGoal();
        self.hiding_until_bank = false;
      }
    }

    if(!self.hiding_until_bank) {
      if(!isDefined(self.tag_getting) && !self.heading_for_tag_pile) {
        self[[self.personality_update_function]]();
      }
    }
    wait(0.05);
  }
}

enemy_watcher() {
  while(1) {
    if(self BotGetDifficultySetting("strategyLevel") < 2) {
      wait(0.5);
    } else {
      wait(0.2);
    }

    if(isDefined(self.enemy) && isPlayer(self.enemy) && isDefined(self.enemy.tags_carried) && self.enemy.tags_carried >= 3 && self BotCanSeeEntity(self.enemy) && Distance(self.origin, self.enemy.origin) <= MAX_MELEE_CHARGE_DIST) {
      self BotSetDifficultySetting("meleeChargeDist", MAX_MELEE_CHARGE_DIST);
      self BotSetFlag("prefer_melee", true);
      self BotSetFlag("throw_knife_melee", (level.mugger_throwing_knife_mug_frac > 0));
    } else {
      self BotSetDifficultySetting("meleeChargeDist", self.default_meleeChargeDist);
      self BotSetFlag("prefer_melee", false);
      self BotSetFlag("throw_knife_melee", false);
    }
  }
}

tag_pile_watcher() {
  while(1) {
    level waittill("mugger_tag_pile", pos);

    if(self.health <= 0) {
      continue;
    }
    if(self.hiding_until_bank) {
      continue;
    }
    if(!isDefined(self.last_tag_pile_time) || GetTime() - self.last_tag_pile_time > MAX_TAG_PILE_TIME) {
      self.last_tag_pile_time = undefined;
      self.last_tag_pile_location = undefined;
      self.heading_for_tag_pile = false;
    }

    if(!isDefined(self.last_tag_pile_location) || DistanceSquared(self.origin, self.last_tag_pile_location) > DistanceSquared(self.origin, pos)) {
      self.last_tag_pile_time = GetTime();
      self.last_tag_pile_location = pos;
    }
  }
}

bot_find_closest_tag() {
  nearest_node_self = self GetNearestNode();
  best_tag = undefined;
  if(isDefined(nearest_node_self)) {
    best_dist_sq = MAX_TAG_SIGHT_DIST_SQ;
    all_tags = array_combine(level.dogtags, level.mugger_extra_tags);
    foreach(tag in all_tags) {
      if(tag maps\mp\gametypes\_gameobjects::canInteractWith(self.team)) {
        distSq = DistanceSquared(self.origin, tag.curorigin);
        if(!isDefined(best_tag) || distSq < best_dist_sq) {
          if((self BotGetDifficultySetting("strategyLevel") > 0 && distSq < MAX_TAG_AWARE_DIST_SQ) || (distSq < MAX_TAG_SIGHT_DIST_SQ && self maps\mp\bots\_bots_gametype_conf::bot_is_tag_visible(tag, nearest_node_self, self BotGetFovDot()))) {
            best_dist_sq = distSq;
            best_tag = tag;
          }
        }
      }
    }
  }
  return best_tag;
}

bot_find_visible_tags_mugger(nearest_node_self, fov_self) {
  visible_tags = [];
  if(isDefined(nearest_node_self)) {
    all_tags = array_combine(level.dogtags, level.mugger_extra_tags);
    foreach(tag in all_tags) {
      if(tag maps\mp\gametypes\_gameobjects::canInteractWith(self.team)) {
        if((isPlayer(self) || DistanceSquared(self.origin, tag.curorigin) < MAX_TAG_SIGHT_DIST_SQ)) {
          if(self maps\mp\bots\_bots_gametype_conf::bot_is_tag_visible(tag, nearest_node_self, fov_self)) {
            new_tag_struct = spawnStruct();
            new_tag_struct.origin = tag.curorigin;
            new_tag_struct.tag = tag;
            visible_tags[visible_tags.size] = new_tag_struct;
          }
        }
      }
    }
  }
  return visible_tags;
}

tag_watcher() {
  wait(RandomFloatRange(0, 0.5));
  while(1) {
    if(self BotGetDifficultySetting("strategyLevel") == 0) {
      wait(3.0);
    } else if(self BotGetDifficultySetting("strategyLevel") == 1) {
      wait(1.5);
    } else {
      wait(0.5);
    }

    if(self.health <= 0) {
      continue;
    }
    if(self.hiding_until_bank) {
      continue;
    }
    if(isDefined(self.enemy) && isPlayer(self.enemy) && self BotCanSeeEntity(self.enemy)) {
      continue;
    }
    closest_tag = bot_find_closest_tag();
    if(isDefined(closest_tag)) {
      self mugger_pick_up_tag(closest_tag);
    } else if(!self.heading_for_tag_pile) {
      if(isDefined(self.last_tag_pile_location) && isDefined(self.last_tag_pile_time) && GetTime() - self.last_tag_pile_time <= MAX_TAG_PILE_TIME) {
        self thread mugger_go_to_tag_pile(self.last_tag_pile_location);
      }
    }
  }
}

mugger_go_to_tag_pile(pos) {
  self endon("disconnect");
  level endon("game_ended");

  self.heading_for_tag_pile = true;

  extra_params = spawnStruct();
  extra_params.script_goal_type = "objective";
  extra_params.objective_radius = level.bot_tag_obj_radius;
  self bot_new_tactical_goal("kill_tag_pile", pos, 25, extra_params);

  result = self waittill_any_return("death", "tag_spotted");
  self BotClearScriptGoal();
  self.heading_for_tag_pile = false;
  self bot_abort_tactical_goal("kill_tag_pile");
}

mugger_pick_up_tag(tag) {
  self endon("disconnect");
  level endon("game_ended");

  self.tag_getting = tag;

  self notify("tag_spotted");

  self childthread notify_when_tag_picked_up(tag, "tag_picked_up");

  self bot_abort_tactical_goal("kill_tag");
  tag_origin = tag.curorigin;
  if(bot_vectors_are_equal(self.last_killtag_tactical_goal_pos, tag.curorigin)) {
    nearest_node_to_tag = tag.nearest_node;
    if(isDefined(nearest_node_to_tag)) {
      dir_to_nearest_node = nearest_node_to_tag.origin - tag_origin;
      tag_origin = tag_origin + (VectorNormalize(dir_to_nearest_node) * Length(dir_to_nearest_node) * 0.5);
    }
  }

  self.last_killtag_tactical_goal_pos = tag.curorigin;

  extra_params = spawnStruct();
  extra_params.script_goal_type = "objective";
  extra_params.objective_radius = level.bot_tag_obj_radius;
  self bot_new_tactical_goal("kill_tag", tag_origin, 25, extra_params);

  self thread notify_when_tag_aborted("tag_aborted");

  result = self waittill_any_return("death", "tag_picked_up");
  self notify("tag_watch_stop");
  self.tag_getting = undefined;
  self BotClearScriptGoal();
  self bot_abort_tactical_goal("kill_tag");
}

notify_when_tag_aborted(tag_notify) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("tag_watch_stop");

  while(self bot_has_tactical_goal("kill_tag")) {
    wait(0.05);
  }

  self notify(tag_notify);
}

notify_when_tag_picked_up(tag, tag_notify) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("tag_watch_stop");

  while(tag maps\mp\gametypes\_gameobjects::canInteractWith(self.team)) {
    wait(0.05);
  }

  self notify(tag_notify);
}

bot_mugger_loadout_modify(loadoutValueArray) {
  chance = 0;
  difficulty = self BotGetDifficulty();
  if(difficulty == "recruit") {
    chance = 0.1;
  } else if(difficulty == "regular") {
    chance = 0.25;
  } else if(difficulty == "hardened") {
    chance = 0.6;
  } else if(difficulty == "veteran") {
    chance = 0.9;
  }

  has_throwing_knife = (loadoutValueArray["loadoutEquipment"] == "throwingknife_mp");
  if(!has_throwing_knife) {
    if(chance >= RandomFloat(1)) {
      loadoutValueArray["loadoutEquipment"] = "throwingknife_mp";
      has_throwing_knife = true;
    }
  }

  if(chance >= RandomFloat(1)) {
    if(loadoutValueArray["loadoutOffhand"] != "concussion_grenade_mp") {
      loadoutValueArray["loadoutOffhand"] = "concussion_grenade_mp";
    }
  }

  if(chance >= RandomFloat(1)) {
    if(loadoutValueArray["loadoutPrimaryAttachment"] != "tactical" && loadoutValueArray["loadoutPrimaryAttachment2"] != "tactical") {
      valid = self maps\mp\bots\_bots_loadout::bot_validate_weapon(loadoutValueArray["loadoutPrimary"], loadoutValueArray["loadoutPrimaryAttachment"], "tactical");
      if(valid) {
        loadoutValueArray["loadoutPrimaryAttachment2"] = "tactical";
      } else {
        valid = self maps\mp\bots\_bots_loadout::bot_validate_weapon(loadoutValueArray["loadoutPrimary"], "tactical", loadoutValueArray["loadoutPrimaryAttachment2"]);
        if(valid) {
          loadoutValueArray["loadoutPrimaryAttachment"] = "tactical";
        }
      }
    }
  }

  if(chance >= RandomFloat(1)) {
    if(loadoutValueArray["loadoutSecondaryAttachment"] != "tactical" && loadoutValueArray["loadoutSecondaryAttachment2"] != "tactical") {
      valid = self maps\mp\bots\_bots_loadout::bot_validate_weapon(loadoutValueArray["loadoutSecondary"], loadoutValueArray["loadoutSecondaryAttachment"], "tactical");
      if(valid) {
        loadoutValueArray["loadoutSecondaryAttachment2"] = "tactical";
      } else {
        valid = self maps\mp\bots\_bots_loadout::bot_validate_weapon(loadoutValueArray["loadoutSecondary"], "tactical", loadoutValueArray["loadoutSecondaryAttachment2"]);
        if(valid) {
          loadoutValueArray["loadoutSecondaryAttachment"] = "tactical";
        }
      }
    }
  }

  perks = [];
  available_perk_indices = [];
  empty_perk_indices = [];
  desired_perks = [];
  if(has_throwing_knife)
    desired_perks[desired_perks.size] = "specialty_extra_deadly";
  desired_perks[desired_perks.size] = "specialty_lightweight";
  desired_perks[desired_perks.size] = "specialty_marathon";
  desired_perks[desired_perks.size] = "specialty_fastsprintrecovery";

  desired_perks[desired_perks.size] = "specialty_stun_resistance";

  for(i = 1; i < 9; i++) {
    if(isDefined(loadoutValueArray["loadoutPerk" + i])) {
      if(loadoutValueArray["loadoutPerk" + i] != "none") {
        perks[perks.size] = loadoutValueArray["loadoutPerk" + i];
        available_perk_indices[available_perk_indices.size] = i;
      } else {
        empty_perk_indices[empty_perk_indices.size] = i;
      }
    }
  }

  foreach(des_perk in desired_perks) {
    if(chance >= RandomFloat(1)) {
      if(!array_contains(perks, des_perk)) {
        index = -1;
        if(empty_perk_indices.size) {
          index = empty_perk_indices[0];
          empty_perk_indices = array_remove(empty_perk_indices, index);
        } else if(available_perk_indices.size) {
          index = random(available_perk_indices);
          available_perk_indices = array_remove(available_perk_indices, index);
        }
        if(index != -1) {
          loadoutValueArray["loadoutPerk" + index] = des_perk;
        }
      }
    }
  }

  if(chance >= RandomFloat(1)) {
    if(loadoutValueArray["loadoutStreakType"] == "streaktype_assault" && loadoutValueArray["loadoutStreak1"] != "airdrop_juggernaut_maniac" && loadoutValueArray["loadoutStreak2"] != "airdrop_juggernaut_maniac" && loadoutValueArray["loadoutStreak3"] != "airdrop_juggernaut_maniac") {
      loadoutValueArray["loadoutStreak3"] = "airdrop_juggernaut_maniac";
    }
  }

  return loadoutValueArray;
}