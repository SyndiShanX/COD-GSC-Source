/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_sentry.gsc
***********************************************/

bot_killstreak_sentry(var_0, var_1, var_2, var_3) {
  self endon("_encstr_8E101216FD639F737DABA8901FAF49295AA31DAD");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(randomintrange(3, 5));

  while(isDefined(self.sentry_place_delay) && gettime() < self.sentry_place_delay)
    wait 1;

  if(isDefined(self.enemy) && self.enemy.health > 0 && self botcanseeentity(self.enemy))
    return 1;

  var_4 = self.origin;

  if(var_3 != "_encstr_93C00FAC0371EA9F08B06B6BC8639012C9") {
    var_4 = bot_sentry_choose_target(var_3);

    if(!isDefined(var_4))
      return 1;
  }

  bot_sentry_add_goal(var_0, var_4, var_3, var_1);

  while(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("_encstr_A6A1116B45C6E412EF6F4F1B7F9EC13525D0FB"))
    wait 0.5;

  return 1;
}

bot_sentry_add_goal(var_0, var_1, var_2, var_3) {
  var_4 = bot_sentry_choose_placement(var_0, var_1, var_2, var_3);

  if(isDefined(var_4)) {
    scripts\mp\bots\bots_strategy::bot_abort_tactical_goal("_encstr_A6A1116B45C6E412EF6F4F1B7F9EC13525D0FB");
    var_5 = spawnStruct();
    var_5.object = var_4;
    var_5.script_goal_yaw = var_4.yaw;
    var_5.script_goal_radius = 10;
    var_5.start_thread = ::bot_sentry_path_start;
    var_5.end_thread = ::bot_sentry_cancel;
    var_5.should_abort = ::bot_sentry_should_abort;
    var_5.action_thread = ::bot_sentry_activate;
    self.placingitemstreakname = var_0.streakname;
    scripts\mp\bots\bots_strategy::bot_new_tactical_goal("_encstr_A6A1116B45C6E412EF6F4F1B7F9EC13525D0FB", var_4.node.origin, 0, var_5);
  }
}

bot_sentry_should_abort(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self.enemy) && self.enemy.health > 0 && self botcanseeentity(self.enemy))
    return 1;

  self.sentry_place_delay = gettime() + 1000;
  return 0;
}

bot_sentry_cancel_failsafe() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A6B31486E0A3892E409DEC2B21E70807755E77BC59F4");
  self endon("_encstr_A3CD17B340B31F7383784BC2DBCF2AE6FB087B572949809AC9");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(isDefined(self.enemy) && self.enemy.health > 0 && self botcanseeentity(self.enemy))
      thread bot_sentry_cancel();

    wait 0.05;
  }
}

bot_sentry_path_start(var_0) {
  thread bot_sentry_path_thread(var_0);
}

bot_sentry_path_thread(var_0) {
  self endon("_encstr_8F9F13C3502FF2976B6FBBA473D137BD27B08A7A38");
  self endon("_encstr_A1B31847BD5DAF9EFA088F5371084AC84A294FB5BF404A35AE9C");
  self endon("_encstr_A6B31486E0A3892E409DEC2B21E70807755E77BC59F4");
  self endon("_encstr_8E101216FD639F737DABA8901FAF49295AA31DAD");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(isDefined(var_0.object) && isDefined(var_0.object.weapon)) {
    if(distance2d(self.origin, var_0.object.node.origin) < 400) {
      thread scripts\mp\bots\bots_util::bot_force_stance_for_time("_encstr_A5AD069B231F0BAF", 5.0);
      thread bot_sentry_cancel_failsafe();
      scripts\mp\bots\bots_killstreaks::bot_switch_to_killstreak_weapon(var_0.object.killstreak_info, var_0.object.killstreaks_array, var_0.object.weapon);
      return;
    }

    wait 0.05;
  }
}

bot_sentry_choose_target(var_0) {
  var_1 = scripts\mp\bots\bots_util::defend_valid_center();

  if(isDefined(var_1))
    return var_1;

  if(isDefined(self.node_ambushing_from))
    return self.node_ambushing_from.origin;

  var_2 = getnodesinradius(self.origin, 1000, 0, 512);
  var_3 = 5;

  if(var_0 != "_encstr_A7AF07D1EF1B06683C") {
    if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") == 1)
      var_3 = 10;
    else if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") == 0)
      var_3 = 15;
  }

  if(var_0 == "_encstr_A6140B118D6A605D3B11F1F8EB")
    var_4 = self botnodepick(var_2, var_3, "_encstr_BE280DC67788F7CF8DF3D2AA196B67", "_encstr_83A80EDB6436DA626807B605A9C058C3");
  else
    var_4 = self botnodepick(var_2, var_3, "_encstr_BE280DC67788F7CF8DF3D2AA196B67");

  if(isDefined(var_4))
    return var_4.origin;
}

bot_sentry_choose_placement(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = getnodesinradius(var_1, 1000, 0, 512);
  var_6 = 5;

  if(var_2 != "_encstr_A7AF07D1EF1B06683C") {
    if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") == 1)
      var_6 = 10;
    else if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") == 0)
      var_6 = 15;
  }

  if(var_2 == "_encstr_A6140B118D6A605D3B11F1F8EB")
    var_7 = self botnodepick(var_5, var_6, "_encstr_92E10C15DAAB697F5625688B0258", var_1, "_encstr_83A80EDB6436DA626807B605A9C058C3");
  else if(var_2 == "_encstr_85EF050C9D7062")
    var_7 = self botnodepick(var_5, var_6, "_encstr_BE280DC67788F7CF8DF3D2AA196B67");
  else if(var_2 == "_encstr_93C00FAC0371EA9F08B06B6BC8639012C9")
    var_7 = self botnodepick(var_5, var_6, "_encstr_8E210AB9ED8C56F51AA53259");
  else
    var_7 = self botnodepick(var_5, var_6, "_encstr_92E10C15DAAB697F5625688B0258", var_1);

  if(isDefined(var_7)) {
    var_4 = spawnStruct();
    var_4.node = var_7;

    if(var_1 != var_7.origin && var_2 != "_encstr_93C00FAC0371EA9F08B06B6BC8639012C9")
      var_4.yaw = vectortoyaw(var_1 - var_7.origin);
    else
      var_4.yaw = undefined;

    var_4.weapon = var_0.weapon;
    var_4.killstreak_info = var_0;
    var_4.killstreaks_array = var_3;
  }

  return var_4;
}

bot_sentry_carried_obj() {
  if(isDefined(self.carriedsentry))
    return self.carriedsentry;

  if(isDefined(self.carriedims))
    return self.carriedims;

  if(isDefined(self.carrieditem))
    return self.carrieditem;
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

      if(isDefined(var_0.object.yaw))
        var_6 = var_0.object.yaw;

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
          self botlookatpoint(var_0.object.node.origin, var_4, "_encstr_A7300E08584D77DBA497CF3FC5432757");
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
  self notify("_encstr_BE8C0D62A1DA2EC351D8A50D0363DA");
  self notify("_encstr_95DE0A0ED80BD8CAD7D2B69B");
  self notify("_encstr_96860F1C36851BAC4163C2C656B04CC695");
}

bot_send_cancel_notify() {
  self switchtoweapon("_encstr_8BBA05185F8B99");
  self enableweapons();
  self enableweaponswitch();
  self notify("_encstr_88E60E81D22801BF13B062A8CBEBB31F");
  self notify("_encstr_8CF70B707AF5B7D9CBDF3339EB");
  self notify("_encstr_ABB1108D1673C656368263B0B1950B896356");
}

bot_sentry_cancel(var_0) {
  self notify("_encstr_A6B31486E0A3892E409DEC2B21E70807755E77BC59F4");
  bot_send_cancel_notify();
  bot_sentry_ensure_exit();
}

bot_sentry_ensure_exit() {
  self notify("_encstr_9ACB1CADE025C76761A08B0B41A991DE0823CD917FEFAFC18FD304F1DDC0");
  self notify("_encstr_A3CD17B340B31F7383784BC2DBCF2AE6FB087B572949809AC9");
  self endon("_encstr_A3CD17B340B31F7383784BC2DBCF2AE6FB087B572949809AC9");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self switchtoweapon("_encstr_8BBA05185F8B99");
  self botclearscriptgoal();
  self botsetstance("_encstr_8BBA05185F8B99");
  self enableweapons();
  self enableweaponswitch();
  wait 0.25;
  var_0 = 0;

  while(isDefined(bot_sentry_carried_obj())) {
    var_0++;
    bot_send_cancel_notify();
    wait 0.25;

    if(var_0 > 2)
      bot_sentry_force_cancel();
  }

  self notify("_encstr_8E101216FD639F737DABA8901FAF49295AA31DAD");
}

bot_sentry_force_cancel() {
  if(isDefined(self.carriedsentry))
    self.carriedsentry scripts\mp\killstreaks\autosentry::sentry_setcancelled();

  if(isDefined(self.carrieditem))
    self.carrieditem scripts\mp\killstreaks\placeable::oncancel(self.placingitemstreakname, 0);

  self.carriedsentry = undefined;
  self.carriedims = undefined;
  self.carrieditem = undefined;
  self switchtoweapon("_encstr_8BBA05185F8B99");
  self enableweapons();
  self enableweaponswitch();
}