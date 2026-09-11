/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_sentry.gsc
***********************************************/

function bot_killstreak_sentry(var0, var1, var2, var3) {
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

  var4 = self.origin;

  if(var3 != "hide_nonlethal") {
    var4 = bot_sentry_choose_target(var3);

    if(!isDefined(var4)) {
      return true;
    }
  }

  bot_sentry_add_goal(var0, var4, var3, var1);

  while(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("sentry_placement")) {
    wait 0.5;
  }

  return true;
}

function bot_sentry_add_goal(var0, var1, var2, var3) {
  var4 = bot_sentry_choose_placement(var0, var1, var2, var3);

  if(isDefined(var4)) {
    scripts\mp\bots\bots_strategy::bot_abort_tactical_goal("sentry_placement");
    var5 = spawnStruct();
    var5.object = var4;
    var5.script_goal_yaw = var4.yaw;
    var5.script_goal_radius = 10;
    var5.start_thread = &bot_sentry_path_start;
    var5.end_thread = &bot_sentry_cancel;
    var5.should_abort = &bot_sentry_should_abort;
    var5.action_thread = &bot_sentry_activate;
    self.placingitemstreakname = var0.streakname;
    scripts\mp\bots\bots_strategy::bot_new_tactical_goal("sentry_placement", var4.node.origin, 0, var5);
    return;
  }
}

function bot_sentry_should_abort(var0) {
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

  for(;;) {
    if(isDefined(self.enemy) && self.enemy.health > 0 && self botcanseeentity(self.enemy)) {
      thread bot_sentry_cancel();
    }

    wait 0.05;
  }
}

function bot_sentry_path_start(var0) {
  thread bot_sentry_path_thread(var0);
}

function bot_sentry_path_thread(var0) {
  self endon("stop_tactical_goal");
  self endon("stop_goal_aborted_watch");
  self endon("bot_sentry_canceled");
  self endon("bot_sentry_exited");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(isDefined(var0.object) && isDefined(var0.object.weapon)) {
    if(distance2d(self.origin, var0.object.node.origin) < 400) {
      thread scripts\mp\bots\bots_util::bot_force_stance_for_time("stand", 5);
      thread bot_sentry_cancel_failsafe();
      scripts\mp\bots\bots_killstreaks::bot_switch_to_killstreak_weapon(var0.object.killstreak_info, var0.object.killstreaks_array, var0.object.weapon);
      return;
    }

    wait 0.05;
  }
}

function bot_sentry_choose_target(var0) {
  var1 = scripts\mp\bots\bots_util::defend_valid_center();

  if(isDefined(var1)) {
    return var1;
  }

  if(isDefined(self.node_ambushing_from)) {
    return self.node_ambushing_from.origin;
  }

  var2 = getnodesinradius(self.origin, 1000, 0, 512);
  var3 = 5;

  if(var0 != "turret") {
    if(self botgetdifficultysetting("strategyLevel") == 1) {
      var3 = 10;
    } else if(self botgetdifficultysetting("strategyLevel") == 0) {
      var3 = 15;
    }
  }

  if(var0 == "turret_air") {
    var4 = self botnodepick(var2, var3, "node_traffic", "ignore_no_sky");
  } else {
    var4 = self botnodepick(var3, var4, "node_traffic");
  }

  if(isDefined(var4)) {
    return var4.origin;
  }
}

function bot_sentry_choose_placement(var0, var1, var2, var3) {
  var4 = undefined;
  var5 = getnodesinradius(var1, 1000, 0, 512);
  var6 = 5;

  if(var2 != "turret") {
    if(self botgetdifficultysetting("strategyLevel") == 1) {
      var6 = 10;
    } else if(self botgetdifficultysetting("strategyLevel") == 0) {
      var6 = 15;
    }
  }

  if(var2 == "turret_air") {
    var7 = self botnodepick(var5, var6, "node_sentry", var1, "ignore_no_sky");
  } else if(var3 == "trap") {
    var7 = self botnodepick(var6, var7, "node_traffic");
  } else if(var4 == "hide_nonlethal") {
    var7 = self botnodepick(var7, var7, "node_hide");
  } else {
    var7 = self botnodepick(var7, var7, "node_sentry", var4);
  }

  if(isDefined(var7)) {
    var7 = spawnStruct();
    var7.node = var7;

    if(var4 != var7.origin && var5 != "hide_nonlethal") {
      var7.yaw = vectortoyaw(var4 - var7.origin);
    } else {
      var7.yaw = undefined;
    }

    var7.weapon = var3.weapon;
    var7.killstreak_info = var3;
    var7.killstreaks_array = var6;
  }

  return var7;
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

function bot_sentry_activate(var0) {
  var1 = 0;
  var2 = bot_sentry_carried_obj();

  if(isDefined(var2)) {
    var3 = 0;

    if(!var2.canbeplaced) {
      var4 = 0.75;
      var5 = gettime();
      var6 = self.angles[1];

      if(isDefined(var0.object.yaw)) {
        var6 = var0.object.yaw;
      }

      var7 = [];
      GscBinSkip0(0x2e, 0, var6 + 180);
    }

    if(isDefined(var6) && var6.canbeplaced) {
      bot_send_place_notify();
      var5 = 1;
    }
  }

  wait 0.25;
  bot_sentry_ensure_exit();
  return var5;
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

function bot_sentry_cancel(var0) {
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
  var0 = 0;

  while(isDefined(bot_sentry_carried_obj())) {
    var0++;
    bot_send_cancel_notify();
    wait 0.25;

    if(var0 > 2) {
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