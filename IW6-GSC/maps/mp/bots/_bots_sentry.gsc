/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_sentry.gsc
*****************************************/

#include common_scripts\utility;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\bots\_bots_ks;
#include maps\mp\bots\_bots_util;

bot_killstreak_sentry(killstreak_info, killstreaks_array, can_use, targetType) {
  self endon("bot_sentry_exited");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  wait(RandomIntRange(3, 5));

  while(isDefined(self.sentry_place_delay) && GetTime() < self.sentry_place_delay) {
    wait 1;
  }

  if(isDefined(self.enemy) && (self.enemy.health > 0) && (self BotCanSeeEntity(self.enemy))) {
    return true;
  }

  targetPoint = self.origin;
  if(targetType != "hide_nonlethal") {
    targetPoint = bot_sentry_choose_target(targetType);

    if(!isDefined(targetPoint)) {
      return true;
    }
  }

  self bot_sentry_add_goal(killstreak_info, targetPoint, targetType, killstreaks_array);

  while(self bot_has_tactical_goal("sentry_placement")) {
    wait(0.5);
  }

  return true;
}

bot_sentry_add_goal(killstreak_info, targetOrigin, targetType, killstreaks_array) {
  placement = self bot_sentry_choose_placement(killstreak_info, targetOrigin, targetType, killstreaks_array);

  if(isDefined(placement)) {
    self bot_abort_tactical_goal("sentry_placement");

    extra_params = spawnStruct();
    extra_params.object = placement;
    extra_params.script_goal_yaw = placement.yaw;
    extra_params.script_goal_radius = 10;
    extra_params.start_thread = ::bot_sentry_path_start;
    extra_params.end_thread = ::bot_sentry_cancel;
    extra_params.should_abort = ::bot_sentry_should_abort;
    extra_params.action_thread = ::bot_sentry_activate;

    self.placingItemStreakName = killstreak_info.streakName;

    self bot_new_tactical_goal("sentry_placement", placement.node.origin, 0, extra_params);
  }
}

bot_sentry_should_abort(tactical_goal) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(self.enemy) && (self.enemy.health > 0) && (self BotCanSeeEntity(self.enemy))) {
    return true;
  }

  self.sentry_place_delay = GetTime() + 1000;

  return false;
}

bot_sentry_cancel_failsafe() {
  self endon("death");
  self endon("disconnect");
  self endon("bot_sentry_canceled");
  self endon("bot_sentry_ensure_exit");

  level endon("game_ended");

  while(1) {
    if(isDefined(self.enemy) && (self.enemy.health > 0) && (self BotCanSeeEntity(self.enemy))) {
      self thread bot_sentry_cancel();
    }

    wait 0.05;
  }
}

bot_sentry_path_start(tactical_goal) {
  self thread bot_sentry_path_thread(tactical_goal);
}

bot_sentry_path_thread(tactical_goal) {
  self endon("stop_tactical_goal");
  self endon("stop_goal_aborted_watch");
  self endon("bot_sentry_canceled");
  self endon("bot_sentry_exited");
  self endon("death");
  self endon("disconnect");

  level endon("game_ended");

  while(isDefined(tactical_goal.object) && isDefined(tactical_goal.object.weapon)) {
    if(Distance2D(self.origin, tactical_goal.object.node.origin) < 400) {
      self thread bot_force_stance_for_time("stand", 5.0);
      self thread bot_sentry_cancel_failsafe();
      self bot_switch_to_killstreak_weapon(tactical_goal.object.killstreak_info, tactical_goal.object.killstreaks_array, tactical_goal.object.weapon);
      return;
    }
    wait 0.05;
  }
}

bot_sentry_choose_target(targetType) {
  defend_center = self defend_valid_center();
  if(isDefined(defend_center)) {
    return defend_center;
  }

  if(isDefined(self.node_ambushing_from)) {
    return self.node_ambushing_from.origin;
  }

  nodes = GetNodesInRadius(self.origin, 1000, 0, 512);
  nodes_to_select_from = 5;
  if(targetType != "turret") {
    if(self BotGetDifficultySetting("strategyLevel") == 1) {
      nodes_to_select_from = 10;
    }
    else if(self BotGetDifficultySetting("strategyLevel") == 0) {
      nodes_to_select_from = 15;
    }
  }

  if(targetType == "turret_air") {
    targetNode = self BotNodePick(nodes, nodes_to_select_from, "node_traffic", "ignore_no_sky");
  }
  else {
    targetNode = self BotNodePick(nodes, nodes_to_select_from, "node_traffic");
  }
  if(isDefined(targetNode)) {
    return targetNode.origin;
  }
}

bot_sentry_choose_placement(killstreak_info, targetOrigin, targetType, killstreaks_array) {
  placement = undefined;

  nodes = GetNodesInRadius(targetOrigin, 1000, 0, 512);
  nodes_to_select_from = 5;
  if(targetType != "turret") {
    if(self BotGetDifficultySetting("strategyLevel") == 1) {
      nodes_to_select_from = 10;
    }
    else if(self BotGetDifficultySetting("strategyLevel") == 0) {
      nodes_to_select_from = 15;
    }
  }

  if(targetType == "turret_air") {
    placeNode = self BotNodePick(nodes, nodes_to_select_from, "node_sentry", targetOrigin, "ignore_no_sky");
  }
  else if(targetType == "trap") {
    placeNode = self BotNodePick(nodes, nodes_to_select_from, "node_traffic");
  }
  else if(targetType == "hide_nonlethal") {
    placeNode = self BotNodePick(nodes, nodes_to_select_from, "node_hide");
  }
  else {
    placeNode = self BotNodePick(nodes, nodes_to_select_from, "node_sentry", targetOrigin);
  }

  if(isDefined(placeNode)) {
    placement = spawnStruct();
    placement.node = placeNode;
    if(targetOrigin != placeNode.origin && targetType != "hide_nonlethal") {
      placement.yaw = VectorToYaw(targetOrigin - placeNode.origin);
    }
    else {
      placement.yaw = undefined;
    }
    placement.weapon = killstreak_info.weapon;
    placement.killstreak_info = killstreak_info;
    placement.killstreaks_array = killstreaks_array;
  }

  return placement;
}

bot_sentry_carried_obj() {
  if(isDefined(self.carriedsentry)) {
    return self.carriedsentry;
  }

  if(isDefined(self.carriedIMS)) {
    return self.carriedIMS;
  }

  if(isDefined(self.carriedItem)) {
    return self.carriedItem;
  }
}

bot_sentry_activate(tactical_goal) {
  result = false;

  carried_obj = self bot_sentry_carried_obj();

  if(isDefined(carried_obj)) {
    abort = false;

    if(!carried_obj.canBePlaced) {
      time_to_try = 0.75;
      start_time = GetTime();

      placementYaw = self.angles[1];
      if(isDefined(tactical_goal.object.yaw)) {
        placementYaw = tactical_goal.object.yaw;
      }

      moveYaws = [];
      moveYaws[0] = placementYaw + 180;
      moveYaws[1] = placementYaw + 135;
      moveYaws[2] = placementYaw - 135;

      minDist = 1000;
      foreach(moveYaw in moveYaws) {
        hitPos = PlayerPhysicsTrace(tactical_goal.object.node.origin, tactical_goal.object.node.origin + anglesToForward((0, moveYaw + 180, 0)) * 100);
        dist = Distance2D(hitpos, tactical_goal.object.node.origin);
        if(dist < minDist) {
          minDist = dist;
          self BotSetScriptMove(moveYaw, time_to_try);
          self BotLookAtPoint(tactical_goal.object.node.origin, time_to_try, "script_forced");
        }
      }

      while(!abort && isDefined(carried_obj) && !carried_obj.canBePlaced) {
        time_waited = float(GetTime() - start_time) / 1000.0;
        if(!carried_obj.canBePlaced && (time_waited > time_to_try)) {
          abort = true;

          self.sentry_place_delay = GetTime() + 30000;
        }

        wait 0.05;
      }
    }

    if(isDefined(carried_obj) && carried_obj.canBePlaced) {
      self bot_send_place_notify();
      result = true;
    }
  }

  wait 0.25;
  self bot_sentry_ensure_exit();

  return result;
}

bot_send_place_notify() {
  self notify("place_sentry");
  self notify("place_ims");
  self notify("placePlaceable");
}

bot_send_cancel_notify() {
  self SwitchToWeapon("none");
  self enableWeapons();
  self enableWeaponSwitch();
  self notify("cancel_sentry");
  self notify("cancel_ims");
  self notify("cancelPlaceable");
}

bot_sentry_cancel(tactical_goal) {
  self notify("bot_sentry_canceled");

  self bot_send_cancel_notify();

  self bot_sentry_ensure_exit();
}

bot_sentry_ensure_exit() {
  self notify("bot_sentry_abort_goal_think");
  self notify("bot_sentry_ensure_exit");

  self endon("bot_sentry_ensure_exit");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self SwitchToWeapon("none");
  self BotClearScriptGoal();
  self BotSetStance("none");
  self enableWeapons();
  self enableWeaponSwitch();
  wait 0.25;

  attempts = 0;
  while(isDefined(self bot_sentry_carried_obj())) {
    attempts++;

    self bot_send_cancel_notify();
    wait 0.25;

    if(attempts > 2) {
      self bot_sentry_force_cancel();
    }
  }

  self notify("bot_sentry_exited");
}

bot_sentry_force_cancel() {
  if(isDefined(self.carriedsentry)) {
    self.carriedsentry maps\mp\killstreaks\_autosentry::sentry_setCancelled();
  }

  if(isDefined(self.carriedIMS)) {
    self.carriedIMS maps\mp\killstreaks\_ims::ims_setCancelled();
  }

  if(isDefined(self.carriedItem)) {
    self.carriedItem maps\mp\killstreaks\_placeable::onCancel(self.placingItemStreakName, false);
  }

  self.carriedsentry = undefined;
  self.carriedIMS = undefined;
  self.carriedItem = undefined;

  self SwitchToWeapon("none");
  self enableWeapons();
  self enableWeaponSwitch();
}