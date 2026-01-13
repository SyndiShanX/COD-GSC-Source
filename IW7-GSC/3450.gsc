/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3450.gsc
**************************************/

bot_killstreak_sentry(var_0, var_1, var_2, var_3) {
  self endon("bot_sentry_exited");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(randomintrange(3, 5));

  while(isDefined(self.sentry_place_delay) && gettime() < self.sentry_place_delay) {
    wait 1;
  }

  if(isDefined(self.enemy) && self.enemy.health > 0 && self botcanseeentity(self.enemy)) {
    return 1;
  }

  var_4 = self.origin;

  if(var_3 != "hide_nonlethal") {
    var_4 = bot_sentry_choose_target(var_3);

    if(!isDefined(var_4)) {
      return 1;
    }
  }

  bot_sentry_add_goal(var_0, var_4, var_3, var_1);

  while(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("sentry_placement")) {
    wait 0.5;
  }

  return 1;
}

bot_sentry_add_goal(var_0, var_1, var_2, var_3) {
  var_4 = bot_sentry_choose_placement(var_0, var_1, var_2, var_3);

  if(isDefined(var_4)) {
    scripts\mp\bots\bots_strategy::bot_abort_tactical_goal("sentry_placement");
    var_5 = spawnStruct();
    var_5.object = var_4;
    var_5.script_goal_yaw = var_4.yaw;
    var_5.script_goal_radius = 10;
    var_5.start_thread = ::bot_sentry_path_start;
    var_5.end_thread = ::bot_sentry_cancel;
    var_5.should_abort = ::bot_sentry_should_abort;
    var_5.action_thread = ::bot_sentry_activate;
    self.placingitemstreakname = var_0.streakname;
    scripts\mp\bots\bots_strategy::bot_new_tactical_goal("sentry_placement", var_4.node.origin, 0, var_5);
  }
}

bot_sentry_should_abort(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(self.enemy) && self.enemy.health > 0 && self botcanseeentity(self.enemy)) {
    return 1;
  }

  self.sentry_place_delay = gettime() + 1000;
  return 0;
}

bot_sentry_cancel_failsafe() {
  self endon("death");
  self endon("disconnect");
  self endon("bot_sentry_canceled");
  self endon("bot_sentry_ensure_exit");
  level endon("game_ended");

  for(;;) {
    if(isDefined(self.enemy) && self.enemy.health > 0 && self botcanseeentity(self.enemy)) {
      thread bot_sentry_cancel();
    }

    wait 0.05;
  }
}

bot_sentry_path_start(var_0) {
  thread bot_sentry_path_thread(var_0);
}

bot_sentry_path_thread(var_0) {
  self endon("stop_tactical_goal");
  self endon("stop_goal_aborted_watch");
  self endon("bot_sentry_canceled");
  self endon("bot_sentry_exited");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(isDefined(var_0.object) && isDefined(var_0.object.weapon)) {
    if(distance2d(self.origin, var_0.object.node.origin) < 400) {
      thread scripts\mp\bots\bots_util::bot_force_stance_for_time("stand", 5.0);
      thread bot_sentry_cancel_failsafe();
      scripts\mp\bots\bots_killstreaks::bot_switch_to_killstreak_weapon(var_0.object.killstreak_info, var_0.object.killstreaks_array, var_0.object.weapon);
      return;
    }

    wait 0.05;
  }
}

bot_sentry_choose_target(var_0) {
  var_1 = scripts\mp\bots\bots_util::defend_valid_center();

  if(isDefined(var_1)) {
    return var_1;
  }

  if(isDefined(self.node_ambushing_from)) {
    return self.node_ambushing_from.origin;
  }

  var_2 = getnodesinradius(self.origin, 1000, 0, 512);
  var_3 = 5;

  if(var_0 != "turret") {
    if(self botgetdifficultysetting("strategyLevel") == 1) {
      var_3 = 10;
    } else if(self botgetdifficultysetting("strategyLevel") == 0) {
      var_3 = 15;
    }
  }

  if(var_0 == "turret_air") {
    var_4 = self botnodepick(var_2, var_3, "node_traffic", "ignore_no_sky");
  } else {
    var_4 = self botnodepick(var_2, var_3, "node_traffic");
  }

  if(isDefined(var_4)) {
    return var_4.origin;
  }
}

bot_sentry_choose_placement(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = getnodesinradius(var_1, 1000, 0, 512);
  var_6 = 5;

  if(var_2 != "turret") {
    if(self botgetdifficultysetting("strategyLevel") == 1) {
      var_6 = 10;
    } else if(self botgetdifficultysetting("strategyLevel") == 0) {
      var_6 = 15;
    }
  }

  if(var_2 == "turret_air") {
    var_7 = self botnodepick(var_5, var_6, "node_sentry", var_1, "ignore_no_sky");
  } else if(var_2 == "trap") {
    var_7 = self botnodepick(var_5, var_6, "node_traffic");
  } else if(var_2 == "hide_nonlethal") {
    var_7 = self botnodepick(var_5, var_6, "node_hide");
  } else {
    var_7 = self botnodepick(var_5, var_6, "node_sentry", var_1);
  }

  if(isDefined(var_7)) {
    var_4 = spawnStruct();
    var_4.node = var_7;

    if(var_1 != var_7.origin && var_2 != "hide_nonlethal") {
      var_4.yaw = vectortoyaw(var_1 - var_7.origin);
    } else {
      var_4.yaw = undefined;
    }

    var_4.weapon = var_0.weapon;
    var_4.killstreak_info = var_0;
    var_4.killstreaks_array = var_3;
  }

  return var_4;
}

bot_sentry_carried_obj() {
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

bot_sentry_activate(var_0) {
  var_1 = 0;
  var_2 = bot_sentry_carried_obj();

  if(isDefined(var_2)) {
    var_3 = 0;

    if(!var_2.canbeplaced) {
      var_4 = 0.75;
      var_5 = gettime();
      var_6 = self.angles[1];

      if(isDefined(var_0.object.yaw)) {
        var_6 = var_0.object.yaw;
      }

      var_7 = [];
      var_7[0] = var_6 + 180;
      var_7[1] = var_6 + 135;
      var_7[2] = var_6 - 135;
      var_8 = 1000;

      foreach(var_10 in var_7) {
        var_11 = playerphysicstrace(var_0.object.node.origin, var_0.object.node.origin + anglesToForward((0, var_10 + 180, 0)) * 100);
        var_12 = distance2d(var_11, var_0.object.node.origin);

        if(var_12 < var_8) {
          var_8 = var_12;
          self botsetscriptmove(var_10, var_4);
          self botlookatpoint(var_0.object.node.origin, var_4, "script_forced");
        }
      }

      while(!var_3 && isDefined(var_2) && !var_2.canbeplaced) {
        var_14 = float(gettime() - var_5) / 1000.0;

        if(!var_2.canbeplaced && var_14 > var_4) {
          var_3 = 1;
          self.sentry_place_delay = gettime() + 30000;
        }

        wait 0.05;
      }
    }

    if(isDefined(var_2) && var_2.canbeplaced) {
      bot_send_place_notify();
      var_1 = 1;
    }
  }

  wait 0.25;
  bot_sentry_ensure_exit();
  return var_1;
}

bot_send_place_notify() {
  self notify("place_sentry");
  self notify("place_ims");
  self notify("placePlaceable");
}

bot_send_cancel_notify() {
  self switchtoweapon("none");
  self enableweapons();
  self enableweaponswitch();
  self notify("cancel_sentry");
  self notify("cancel_ims");
  self notify("cancelPlaceable");
}

bot_sentry_cancel(var_0) {
  self notify("bot_sentry_canceled");
  bot_send_cancel_notify();
  bot_sentry_ensure_exit();
}

bot_sentry_ensure_exit() {
  self notify("bot_sentry_abort_goal_think");
  self notify("bot_sentry_ensure_exit");
  self endon("bot_sentry_ensure_exit");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self switchtoweapon("none");
  self botclearscriptgoal();
  self botsetstance("none");
  self enableweapons();
  self enableweaponswitch();
  wait 0.25;
  var_0 = 0;

  while(isDefined(bot_sentry_carried_obj())) {
    var_0++;
    bot_send_cancel_notify();
    wait 0.25;

    if(var_0 > 2) {
      bot_sentry_force_cancel();
    }
  }

  self notify("bot_sentry_exited");
}

bot_sentry_force_cancel() {
  if(isDefined(self.carriedsentry)) {
    self.carriedsentry scripts\mp\killstreaks\autosentry::sentry_setcancelled();
  }

  if(isDefined(self.carriedims)) {
    self.carriedims scripts\mp\killstreaks\ims::ims_setcancelled();
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