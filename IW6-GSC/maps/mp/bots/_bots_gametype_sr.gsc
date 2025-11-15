/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_sr.gsc
**********************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\bots\_bots_personality;

main() {
  maps\mp\bots\_bots_gametype_sd::setup_callbacks();
  setup_callbacks();
  maps\mp\bots\_bots_gametype_conf::setup_bot_conf();
  maps\mp\bots\_bots_gametype_sd::bot_sd_start();

  thread bot_sr_debug();
}

empty_function_to_force_script_dev_compile() {}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_sr_think;
}

bot_sr_debug() {
  while(1) {
    if(GetDvar("bot_DrawDebugGametype") == "sr") {
      foreach(tag in level.dogtags) {
        if(tag maps\mp\gametypes\_gameobjects::canInteractWith("allies") || tag maps\mp\gametypes\_gameobjects::canInteractWith("axis")) {
          if(isDefined(tag.bot_picking_up)) {
            if(isDefined(tag.bot_picking_up["allies"]) && IsAlive(tag.bot_picking_up["allies"]))
              line(tag.curorigin, tag.bot_picking_up["allies"].origin + (0, 0, 20), (0, 1, 0), 1.0, true);
            if(isDefined(tag.bot_picking_up["axis"]) && IsAlive(tag.bot_picking_up["axis"]))
              line(tag.curorigin, tag.bot_picking_up["axis"].origin + (0, 0, 20), (0, 1, 0), 1.0, true);
          }

          if(isDefined(tag.bot_camping)) {
            if(isDefined(tag.bot_camping["allies"]) && IsAlive(tag.bot_camping["allies"]))
              line(tag.curorigin, tag.bot_camping["allies"].origin + (0, 0, 20), (0, 1, 0), 1.0, true);
            if(isDefined(tag.bot_camping["axis"]) && IsAlive(tag.bot_camping["axis"]))
              line(tag.curorigin, tag.bot_camping["axis"].origin + (0, 0, 20), (0, 1, 0), 1.0, true);
          }
        }
      }
    }

    wait(0.05);
  }
}

bot_sr_think() {
  self notify("bot_sr_think");
  self endon("bot_sr_think");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait(0.05);

  self.suspend_sd_role = undefined;

  self childthread tag_watcher();

  maps\mp\bots\_bots_gametype_sd::bot_sd_think();
}

tag_watcher() {
  while(1) {
    wait(0.05);

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(self.role)) {
      continue;
    }
    visible_tags = maps\mp\bots\_bots_gametype_conf::bot_find_visible_tags(false);
    if(visible_tags.size > 0) {
      tag_chosen = Random(visible_tags);
      if(DistanceSquared(self.origin, tag_chosen.tag.curorigin) < 100 * 100) {
        self sr_pick_up_tag(tag_chosen.tag);
      } else if(self.team == game["attackers"]) {
        if(self.role != "atk_bomber") {
          self sr_pick_up_tag(tag_chosen.tag);
        }
      } else {
        if(self.role != "bomb_defuser") {
          self sr_pick_up_tag(tag_chosen.tag);
        }
      }
    }
  }
}

sr_pick_up_tag(tag) {
  if(isDefined(tag.bot_picking_up) && isDefined(tag.bot_picking_up[self.team]) && IsAlive(tag.bot_picking_up[self.team]) && tag.bot_picking_up[self.team] != self) {
    return;
  }
  if(self sr_ally_near_tag(tag)) {
    return;
  }
  if(!isDefined(self.role)) {
    return;
  }
  if(self bot_is_defending())
    self bot_defend_stop();

  tag.bot_picking_up[self.team] = self;
  tag thread clear_bot_on_reset();
  tag thread clear_bot_on_bot_death(self);
  self.suspend_sd_role = true;

  self childthread notify_when_tag_picked_up_or_unavailable(tag, "tag_picked_up");
  tag_goal = tag.curorigin;
  self BotSetScriptGoal(tag_goal, 0, "tactical");
  self childthread watch_tag_destination(tag);

  result = self bot_waittill_goal_or_fail(undefined, "tag_picked_up", "new_role");
  self notify("stop_watch_tag_destination");
  if(result == "no_path") {
    tag_goal = tag_goal + (16 * rand_pos_or_neg(), 16 * rand_pos_or_neg(), 0);
    self BotSetScriptGoal(tag_goal, 0, "tactical");

    result = self bot_waittill_goal_or_fail(undefined, "tag_picked_up", "new_role");
    if(result == "no_path") {
      tag_goal = bot_queued_process("BotGetClosestNavigablePoint", ::func_bot_get_closest_navigable_point, tag.curorigin, 32, self);
      if(isDefined(tag_goal)) {
        self BotSetScriptGoal(tag_goal, 0, "tactical");
        result = self bot_waittill_goal_or_fail(undefined, "tag_picked_up", "new_role");
      }
    }
  } else if(result == "bad_path") {
    nodes = GetNodesInRadiusSorted(tag.curorigin, 256, 0, level.bot_tag_allowable_jump_height + 55);
    if(nodes.size > 0) {
      new_goal = (tag.curorigin[0], tag.curorigin[1], (nodes[0].origin[2] + tag.curorigin[2]) * 0.5);
      self BotSetScriptGoal(new_goal, 0, "tactical");
      result = self bot_waittill_goal_or_fail(undefined, "tag_picked_up", "new_role");
    }
  }

  if(result == "goal" && tag maps\mp\gametypes\_gameobjects::canInteractWith(self.team)) {
    wait(3.0);
  }

  if(self BotHasScriptGoal() && isDefined(tag_goal)) {
    script_goal = self BotGetScriptGoal();
    if(bot_vectors_are_equal(script_goal, tag_goal))
      self BotClearScriptGoal();
  }

  self notify("stop_tag_watcher");
  tag.bot_picking_up[self.team] = undefined;

  self.suspend_sd_role = undefined;
}

watch_tag_destination(tag) {
  self endon("stop_watch_tag_destination");

  while(1) {
    Assert(self BotHasScriptGoal());
    if(!tag maps\mp\gametypes\_gameobjects::canInteractWith(self.team)) {
      wait(0.05);
      Assert(tag maps\mp\gametypes\_gameobjects::canInteractWith(self.team));
    }

    goal = self BotGetScriptGoal();
    Assert(bot_vectors_are_equal(goal, tag.curorigin));

    wait(0.05);
  }
}

sr_ally_near_tag(tag) {
  my_dist_to_tag = Distance(self.origin, tag.curorigin);

  allies = maps\mp\bots\_bots_gametype_sd::get_living_players_on_team(self.team, true);
  foreach(ally in allies) {
    if(ally != self && isDefined(ally.role) && ally.role != "atk_bomber" && ally.role != "bomb_defuser") {
      ally_dist = Distance(ally.origin, tag.curorigin);
      if(ally_dist < my_dist_to_tag * 0.5)
        return true;
    }
  }

  return false;
}

rand_pos_or_neg() {
  return (RandomIntRange(0, 2) * 2) - 1;
}

clear_bot_on_reset() {
  self waittill("reset");
  self.bot_picking_up = [];
}

clear_bot_on_bot_death(bot) {
  self endon("reset");

  botTeam = bot.team;
  bot waittill_any("death", "disconnect");
  self.bot_picking_up[botTeam] = undefined;
}

notify_when_tag_picked_up_or_unavailable(tag, tag_notify) {
  self endon("stop_tag_watcher");

  while(tag maps\mp\gametypes\_gameobjects::canInteractWith(self.team) && !self maps\mp\bots\_bots_gametype_conf::bot_check_tag_above_head(tag)) {
    wait(0.05);
  }

  self notify(tag_notify);
}

sr_camp_tag(tag) {
  if(isDefined(tag.bot_camping) && isDefined(tag.bot_camping[self.team]) && IsAlive(tag.bot_camping[self.team]) && tag.bot_camping[self.team] != self) {
    return;
  }
  if(!isDefined(self.role)) {
    return;
  }
  if(self bot_is_defending())
    self bot_defend_stop();

  tag.bot_camping[self.team] = self;
  tag thread clear_bot_camping_on_reset();
  tag thread clear_bot_camping_on_bot_death(self);
  self.suspend_sd_role = true;

  self clear_camper_data();

  role_started = self.role;
  while(tag maps\mp\gametypes\_gameobjects::canInteractWith(self.team) && self.role == role_started) {
    Assert(!self bot_is_defending());
    if(self should_select_new_ambush_point()) {
      if(find_ambush_node(tag.curorigin, 1000)) {
        self childthread maps\mp\bots\_bots_gametype_conf::bot_camp_tag(tag, "tactical", "new_role");
      }
    }

    wait(0.05);
  }

  self notify("stop_camping_tag");
  self BotClearScriptGoal();
  tag.bot_camping[self.team] = undefined;
  self.suspend_sd_role = undefined;
}

clear_bot_camping_on_reset() {
  self waittill("reset");
  self.bot_camping = [];
}

clear_bot_camping_on_bot_death(bot) {
  self endon("reset");

  botTeam = bot.team;
  bot waittill_any("death", "disconnect");
  self.bot_camping[botTeam] = undefined;
}