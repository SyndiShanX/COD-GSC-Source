/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_sentry.gsc
***********************************************/

bot_killstreak_sentry(killstreak_info, killstreaks_array, can_use, _id_39E02A8A79B6BA4C) {
  self endon("bot_sentry_exited");
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait(randomintrange(3, 5));

  while(isDefined(self.sentry_place_delay) && gettime() < self.sentry_place_delay)
    wait 1;

  if(isDefined(self.enemy) && self.enemy.health > 0 && self botcanseeentity(self.enemy))
    return 1;

  _id_91BE2B7482F940BA = self.origin;

  if(_id_39E02A8A79B6BA4C != "hide_nonlethal") {
    _id_91BE2B7482F940BA = bot_sentry_choose_target(_id_39E02A8A79B6BA4C);

    if(!isDefined(_id_91BE2B7482F940BA))
      return 1;
  }

  bot_sentry_add_goal(killstreak_info, _id_91BE2B7482F940BA, _id_39E02A8A79B6BA4C, killstreaks_array);

  while(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("sentry_placement"))
    wait 0.5;

  return 1;
}

bot_sentry_add_goal(killstreak_info, targetorigin, _id_39E02A8A79B6BA4C, killstreaks_array) {
  placement = bot_sentry_choose_placement(killstreak_info, targetorigin, _id_39E02A8A79B6BA4C, killstreaks_array);

  if(isDefined(placement)) {
    scripts\mp\bots\bots_strategy::bot_abort_tactical_goal("sentry_placement");
    _id_4F3B05E382BB8C7C = spawnStruct();
    _id_4F3B05E382BB8C7C.object = placement;
    _id_4F3B05E382BB8C7C.script_goal_yaw = placement.yaw;
    _id_4F3B05E382BB8C7C.script_goal_radius = 10;
    _id_4F3B05E382BB8C7C.start_thread = ::bot_sentry_path_start;
    _id_4F3B05E382BB8C7C.end_thread = ::bot_sentry_cancel;
    _id_4F3B05E382BB8C7C.should_abort = ::bot_sentry_should_abort;
    _id_4F3B05E382BB8C7C.action_thread = ::bot_sentry_activate;
    self.placingitemstreakname = killstreak_info.streakname;
    scripts\mp\bots\bots_strategy::bot_new_tactical_goal("sentry_placement", placement.node.origin, 0, _id_4F3B05E382BB8C7C);
  }
}

bot_sentry_should_abort(_id_F37A20EF92906796) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self.enemy) && self.enemy.health > 0 && self botcanseeentity(self.enemy))
    return 1;

  self.sentry_place_delay = gettime() + 1000;
  return 0;
}

bot_sentry_cancel_failsafe() {
  self endon("death_or_disconnect");
  self endon("bot_sentry_canceled");
  self endon("bot_sentry_ensure_exit");
  level endon("game_ended");

  for(;;) {
    if(isDefined(self.enemy) && self.enemy.health > 0 && self botcanseeentity(self.enemy))
      thread bot_sentry_cancel();

    wait 0.05;
  }
}

bot_sentry_path_start(_id_F37A20EF92906796) {
  thread bot_sentry_path_thread(_id_F37A20EF92906796);
}

bot_sentry_path_thread(_id_F37A20EF92906796) {
  self endon("stop_tactical_goal");
  self endon("stop_goal_aborted_watch");
  self endon("bot_sentry_canceled");
  self endon("bot_sentry_exited");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(isDefined(_id_F37A20EF92906796.object) && isDefined(_id_F37A20EF92906796.object.weapon)) {
    if(distance2d(self.origin, _id_F37A20EF92906796.object.node.origin) < 400) {
      thread scripts\mp\bots\bots_util::bot_force_stance_for_time("stand", 5.0);
      thread bot_sentry_cancel_failsafe();
      scripts\mp\bots\bots_killstreaks::bot_switch_to_killstreak_weapon(_id_F37A20EF92906796.object.killstreak_info, _id_F37A20EF92906796.object.killstreaks_array, _id_F37A20EF92906796.object.weapon);
      return;
    }

    wait 0.05;
  }
}

bot_sentry_choose_target(_id_39E02A8A79B6BA4C) {
  _id_1D14FF4F8B8E125B = scripts\mp\bots\bots_util::defend_valid_center();

  if(isDefined(_id_1D14FF4F8B8E125B))
    return _id_1D14FF4F8B8E125B;

  if(isDefined(self.node_ambushing_from))
    return self.node_ambushing_from.origin;

  nodes = getnodesinradius(self.origin, 1000, 0, 512);
  _id_0DEF8CD540EAB8DC = 5;

  if(_id_39E02A8A79B6BA4C != "turret") {
    if(self botgetdifficultysetting("strategyLevel") == 1)
      _id_0DEF8CD540EAB8DC = 10;
    else if(self botgetdifficultysetting("strategyLevel") == 0)
      _id_0DEF8CD540EAB8DC = 15;
  }

  if(_id_39E02A8A79B6BA4C == "turret_air")
    targetnode = self botnodepick(nodes, _id_0DEF8CD540EAB8DC, "node_traffic", "ignore_no_sky");
  else
    targetnode = self botnodepick(nodes, _id_0DEF8CD540EAB8DC, "node_traffic");

  if(isDefined(targetnode))
    return targetnode.origin;
}

bot_sentry_choose_placement(killstreak_info, targetorigin, _id_39E02A8A79B6BA4C, killstreaks_array) {
  placement = undefined;
  nodes = getnodesinradius(targetorigin, 1000, 0, 512);
  _id_0DEF8CD540EAB8DC = 5;

  if(_id_39E02A8A79B6BA4C != "turret") {
    if(self botgetdifficultysetting("strategyLevel") == 1)
      _id_0DEF8CD540EAB8DC = 10;
    else if(self botgetdifficultysetting("strategyLevel") == 0)
      _id_0DEF8CD540EAB8DC = 15;
  }

  if(_id_39E02A8A79B6BA4C == "turret_air")
    _id_E9C28ADB2AED652C = self botnodepick(nodes, _id_0DEF8CD540EAB8DC, "node_sentry", targetorigin, "ignore_no_sky");
  else if(_id_39E02A8A79B6BA4C == "trap")
    _id_E9C28ADB2AED652C = self botnodepick(nodes, _id_0DEF8CD540EAB8DC, "node_traffic");
  else if(_id_39E02A8A79B6BA4C == "hide_nonlethal")
    _id_E9C28ADB2AED652C = self botnodepick(nodes, _id_0DEF8CD540EAB8DC, "node_hide");
  else
    _id_E9C28ADB2AED652C = self botnodepick(nodes, _id_0DEF8CD540EAB8DC, "node_sentry", targetorigin);

  if(isDefined(_id_E9C28ADB2AED652C)) {
    placement = spawnStruct();
    placement.node = _id_E9C28ADB2AED652C;

    if(targetorigin != _id_E9C28ADB2AED652C.origin && _id_39E02A8A79B6BA4C != "hide_nonlethal")
      placement.yaw = vectortoyaw(targetorigin - _id_E9C28ADB2AED652C.origin);
    else
      placement.yaw = undefined;

    placement.weapon = killstreak_info.weapon;
    placement.killstreak_info = killstreak_info;
    placement.killstreaks_array = killstreaks_array;
  }

  return placement;
}

bot_sentry_carried_obj() {
  if(isDefined(self.carriedsentry))
    return self.carriedsentry;

  if(isDefined(self.carriedims))
    return self.carriedims;

  if(isDefined(self.carrieditem))
    return self.carrieditem;
}

bot_sentry_activate(_id_F37A20EF92906796) {
  result = 0;
  _id_E3BC187F22497ECB = bot_sentry_carried_obj();

  if(isDefined(_id_E3BC187F22497ECB)) {
    abort = 0;

    if(!_id_E3BC187F22497ECB.canbeplaced) {
      _id_199798D5FD510AEA = 0.75;
      start_time = gettime();
      _id_2A3D6A9F19C6B30F = self.angles[1];

      if(isDefined(_id_F37A20EF92906796.object.yaw))
        _id_2A3D6A9F19C6B30F = _id_F37A20EF92906796.object.yaw;

      _id_B039ACE808558A68 = [];
      _id_B039ACE808558A68[0] = _id_2A3D6A9F19C6B30F + 180;
      _id_B039ACE808558A68[1] = _id_2A3D6A9F19C6B30F + 135;
      _id_B039ACE808558A68[2] = _id_2A3D6A9F19C6B30F - 135;
      _id_636C8575D7A7768B = 1000;

      foreach(_id_55E21CF7C5CFF38B in _id_B039ACE808558A68) {
        _id_2E3BC21C15E7AB6C = playerphysicstrace(_id_F37A20EF92906796.object.node.origin, _id_F37A20EF92906796.object.node.origin + anglesToForward((0, _id_55E21CF7C5CFF38B + 180, 0)) * 100);
        dist = distance2d(_id_2E3BC21C15E7AB6C, _id_F37A20EF92906796.object.node.origin);

        if(dist < _id_636C8575D7A7768B) {
          _id_636C8575D7A7768B = dist;
          self botsetscriptmove(_id_55E21CF7C5CFF38B, _id_199798D5FD510AEA);
          self botlookatpoint(_id_F37A20EF92906796.object.node.origin, _id_199798D5FD510AEA, "script_forced");
        }
      }

      while(!abort && isDefined(_id_E3BC187F22497ECB) && !_id_E3BC187F22497ECB.canbeplaced) {
        _id_3E7539402EE4D0F1 = float(gettime() - start_time) / 1000.0;

        if(!_id_E3BC187F22497ECB.canbeplaced && _id_3E7539402EE4D0F1 > _id_199798D5FD510AEA) {
          abort = 1;
          self.sentry_place_delay = gettime() + 30000;
        }

        wait 0.05;
      }
    }

    if(isDefined(_id_E3BC187F22497ECB) && _id_E3BC187F22497ECB.canbeplaced) {
      bot_send_place_notify();
      result = 1;
    }
  }

  wait 0.25;
  bot_sentry_ensure_exit();
  return result;
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

bot_sentry_cancel(_id_F37A20EF92906796) {
  self notify("bot_sentry_canceled");
  bot_send_cancel_notify();
  bot_sentry_ensure_exit();
}

bot_sentry_ensure_exit() {
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
  _id_C4B448E975A0779B = 0;

  while(isDefined(bot_sentry_carried_obj())) {
    _id_C4B448E975A0779B++;
    bot_send_cancel_notify();
    wait 0.25;

    if(_id_C4B448E975A0779B > 2)
      bot_sentry_force_cancel();
  }

  self notify("bot_sentry_exited");
}

bot_sentry_force_cancel() {
  if(isDefined(self.carriedsentry))
    self.carriedsentry scripts\mp\killstreaks\autosentry::sentry_setcancelled();

  if(isDefined(self.carrieditem))
    self.carrieditem scripts\mp\killstreaks\placeable::oncancel(self.placingitemstreakname, 0);

  self.carriedsentry = undefined;
  self.carriedims = undefined;
  self.carrieditem = undefined;
  self switchtoweapon("none");
  self enableweapons();
  self enableweaponswitch();
}