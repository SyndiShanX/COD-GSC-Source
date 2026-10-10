/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\bots\bots_sentry.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_killstreaks;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\killstreaks\autosentry;
#using scripts\mp\killstreaks\placeable;
#namespace bots_sentry;

function bot_killstreak_sentry(killstreak_info, killstreaks_array, can_use, targettype) {
  self endon("bot_sentry_exited");
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait randomintrange(3, 5);

  while(isDefined(self.sentry_place_delay) && gettime() < self.sentry_place_delay) {
    wait 1;
  }

  if(isDefined(self.enemy) && self.enemy.health > 0 && self botcanseeentity(self.enemy)) {
    return true;
  }

  targetpoint = self.origin;

  if(targettype != "hide_nonlethal") {
    targetpoint = bot_sentry_choose_target(targettype);

    if(!isDefined(targetpoint)) {
      return true;
    }
  }

  bot_sentry_add_goal(killstreak_info, targetpoint, targettype, killstreaks_array);

  while(bot_has_tactical_goal("sentry_placement")) {
    wait 0.5;
  }

  return true;
}

function bot_sentry_add_goal(killstreak_info, targetorigin, targettype, killstreaks_array) {
  placement = bot_sentry_choose_placement(killstreak_info, targetorigin, targettype, killstreaks_array);

  if(isDefined(placement)) {
    bot_abort_tactical_goal("sentry_placement");
    extra_params = spawnStruct();
    extra_params.object = placement;
    extra_params.script_goal_yaw = placement.yaw;
    extra_params.script_goal_radius = 10;
    extra_params.start_thread = &bot_sentry_path_start;
    extra_params.end_thread = &bot_sentry_cancel;
    extra_params.should_abort = &bot_sentry_should_abort;
    extra_params.action_thread = &bot_sentry_activate;
    self.placingitemstreakname = killstreak_info.streakname;
    bot_new_tactical_goal("sentry_placement", placement.node.origin, 0, extra_params);
  }
}

function bot_sentry_should_abort(tactical_goal) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self.enemy) && self.enemy.health > 0 && self botcanseeentity(self.enemy)) {
    return true;
  }

  self.sentry_place_delay = gettime() + 1000;
  return false;
}

function bot_sentry_cancel_failsafe() {
  self endon("death_or_disconnect");
  self endon("bot_sentry_canceled");
  self endon("bot_sentry_ensure_exit");
  level endon("game_ended");

  while(true) {
    if(isDefined(self.enemy) && self.enemy.health > 0 && self botcanseeentity(self.enemy)) {
      thread bot_sentry_cancel();
    }

    wait 0.05;
  }
}

function bot_sentry_path_start(tactical_goal) {
  thread bot_sentry_path_thread(tactical_goal);
}

function bot_sentry_path_thread(tactical_goal) {
  self endon("stop_tactical_goal");
  self endon("stop_goal_aborted_watch");
  self endon("bot_sentry_canceled");
  self endon("bot_sentry_exited");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(isDefined(tactical_goal.object) && isDefined(tactical_goal.object.weapon)) {
    if(distance2d(self.origin, tactical_goal.object.node.origin) < 400) {
      thread bot_force_stance_for_time("stand", 5);
      thread bot_sentry_cancel_failsafe();
      bot_switch_to_killstreak_weapon(tactical_goal.object.killstreak_info, tactical_goal.object.killstreaks_array, tactical_goal.object.weapon);
      return;
    }

    wait 0.05;
  }
}

function bot_sentry_choose_target(targettype) {
  defend_center = defend_valid_center();

  if(isDefined(defend_center)) {
    return defend_center;
  }

  if(isDefined(self.node_ambushing_from)) {
    return self.node_ambushing_from.origin;
  }

  nodes = getnodesinradius(self.origin, 1000, 0, 512);
  var_def8cd540eab8dc = 5;

  if(targettype != "turret") {
    if(self botgetdifficultysetting("strategyLevel") == 1) {
      var_def8cd540eab8dc = 10;
    } else if(self botgetdifficultysetting("strategyLevel") == 0) {
      var_def8cd540eab8dc = 15;
    }
  }

  if(targettype == "turret_air") {
    targetnode = self botnodepick(nodes, var_def8cd540eab8dc, "node_exposed", "ignore_no_sky");
  } else {
    targetnode = self botnodepick(nodes, var_def8cd540eab8dc, "node_exposed");
  }

  if(isDefined(targetnode)) {
    return targetnode.origin;
  }
}

function bot_sentry_choose_placement(killstreak_info, targetorigin, targettype, killstreaks_array) {
  placement = undefined;
  nodes = getnodesinradius(targetorigin, 1000, 0, 512);
  var_def8cd540eab8dc = 5;

  if(targettype != "turret") {
    if(self botgetdifficultysetting("strategyLevel") == 1) {
      var_def8cd540eab8dc = 10;
    } else if(self botgetdifficultysetting("strategyLevel") == 0) {
      var_def8cd540eab8dc = 15;
    }
  }

  if(targettype == "turret_air") {
    placenode = self botnodepick(nodes, var_def8cd540eab8dc, "node_sentry", targetorigin, "ignore_no_sky");
  } else if(targettype == "trap") {
    placenode = self botnodepick(nodes, var_def8cd540eab8dc, "node_exposed");
  } else if(targettype == "hide_nonlethal") {
    placenode = self botnodepick(nodes, var_def8cd540eab8dc, "node_hide");
  } else {
    placenode = self botnodepick(nodes, var_def8cd540eab8dc, "node_sentry", targetorigin);
  }

  if(isDefined(placenode)) {
    placement = spawnStruct();
    placement.node = placenode;

    if(targetorigin != placenode.origin && targettype != "hide_nonlethal") {
      placement.yaw = vectortoyaw(targetorigin - placenode.origin);
    } else {
      placement.yaw = undefined;
    }

    placement.weapon = killstreak_info.weapon;
    placement.killstreak_info = killstreak_info;
    placement.killstreaks_array = killstreaks_array;
  }

  return placement;
}

function bot_sentry_carried_obj() {
  if(isDefined(self.carriedsentry)) {
    return self.carriedsentry;
  }

  if(isDefined(self.carriedims)) {
    return self.carriedims;
  }

  if(isDefined(self.carrieditem)) {
    return self.carrieditem;
  }
}

function bot_sentry_activate(tactical_goal) {
  result = 0;
  carried_obj = bot_sentry_carried_obj();

  if(isDefined(carried_obj)) {
    abort = 0;

    if(!carried_obj.canbeplaced) {
      var_199798d5fd510aea = 0.75;
      start_time = gettime();
      placementyaw = self.angles[1];

      if(isDefined(tactical_goal.object.yaw)) {
        placementyaw = tactical_goal.object.yaw;
      }

      var_b039ace808558a68 = [];
      var_b039ace808558a68[0] = placementyaw + 180;
      var_b039ace808558a68[1] = placementyaw + 135;
      var_b039ace808558a68[2] = placementyaw - 135;
      mindist = 1000;

      foreach(moveyaw in var_b039ace808558a68) {
        hitpos = playerphysicstrace(tactical_goal.object.node.origin, tactical_goal.object.node.origin + anglesToForward((0, moveyaw + 180, 0)) * 100);
        dist = distance2d(hitpos, tactical_goal.object.node.origin);

        if(dist < mindist) {
          mindist = dist;
          self botsetscriptmove(moveyaw, var_199798d5fd510aea);
          self botlookatpoint(tactical_goal.object.node.origin, var_199798d5fd510aea, "script_forced");
        }
      }

      while(!abort && isDefined(carried_obj) && !carried_obj.canbeplaced) {
        time_waited = float(gettime() - start_time) / 1000;

        if(!carried_obj.canbeplaced && time_waited > var_199798d5fd510aea) {
          abort = 1;
          self.sentry_place_delay = gettime() + 30000;
        }

        wait 0.05;
      }
    }

    if(isDefined(carried_obj) && carried_obj.canbeplaced) {
      bot_send_place_notify();
      result = 1;
    }
  }

  wait 0.25;
  bot_sentry_ensure_exit();
  return result;
}

function bot_send_place_notify() {
  self notify("place_sentry");
  self notify("place_ims");
  self notify("placePlaceable");
}

function bot_send_cancel_notify() {
  self switchtoweapon("none");
  self enableweapons();
  self enableweaponswitch();
  self notify("cancel_sentry");
  self notify("cancel_ims");
  self notify("cancelPlaceable");
}

function bot_sentry_cancel(tactical_goal) {
  self notify("bot_sentry_canceled");
  bot_send_cancel_notify();
  bot_sentry_ensure_exit();
}

function bot_sentry_ensure_exit() {
  self notify("bot_sentry_abort_goal_think");
  self notify("bot_sentry_ensure_exit");
  self endon("bot_sentry_ensure_exit");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self switchtoweapon("none");
  self botclearscriptgoal();
  self botsetstance("none");
  self enableweapons();
  self enableweaponswitch();
  wait 0.25;
  attempts = 0;

  while(isDefined(bot_sentry_carried_obj())) {
    attempts++;
    bot_send_cancel_notify();
    wait 0.25;

    if(attempts > 2) {
      bot_sentry_force_cancel();
    }
  }

  self notify("bot_sentry_exited");
}

function bot_sentry_force_cancel() {
  if(isDefined(self.carriedsentry)) {
    self.carriedsentry scripts\mp\killstreaks\autosentry::sentry_setcancelled();
  }

  if(isDefined(self.carrieditem)) {
    self.carrieditem scripts\mp\killstreaks\placeable::oncancel(self.placingitemstreakname, 0);
  }

  self.carriedsentry = undefined;
  self.carriedims = undefined;
  self.carrieditem = undefined;
  self switchtoweapon("none");
  self enableweapons();
  self enableweaponswitch();
}