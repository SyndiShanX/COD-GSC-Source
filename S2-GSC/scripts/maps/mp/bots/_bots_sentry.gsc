/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_sentry.gsc
*************************************************/

_id_1A4D(var_0, var_1, var_2, var_3) {
  self endon("bot_sentry_exited");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(_randomintrange(3, 5));

  while(isDefined(self.getlookaheaddir) && gettime() < self.getlookaheaddir)
    wait 1;

  if(isDefined(self._id_0088) && self._id_0088.health > 0 && self botcanseeentity(self._id_0088))
    return 1;

  var_4 = self.origin;

  if(var_3 != "hide_nonlethal") {
    var_4 = _id_1ACA(var_3);

    if(!isDefined(var_4))
      return 1;
  }

  _id_1AC5(var_0, var_4, var_3, var_1);

  while(maps\mp\bots\_bots_strategy::_id_1A14("sentry_placement"))
    wait 0.5;

  return 1;
}

_id_1967(var_0) {
  return 0;
}

_id_1AC5(var_0, var_1, var_2, var_3) {
  var_4 = _id_1AC9(var_0, var_1, var_2, var_3);

  if(isDefined(var_4)) {
    maps\mp\bots\_bots_strategy::_id_192C("sentry_placement");
    var_5 = spawnStruct();
    var_5._id_68FB = var_4;
    var_5.issuppressionwaiting = var_4._id_AAE8;
    var_5._id_81C8 = 10;
    var_5._id_9296 = ::_id_1ACD;
    var_5._id_36AC = ::_id_1AC6;
    var_5._id_8B3E = ::_id_1ACF;
    var_5._id_087F = ::_id_1AC4;
    self._id_7009 = var_0._id_944C;
    maps\mp\bots\_bots_strategy::_id_1A85("sentry_placement", var_4._id_010D.origin, 0, var_5);
  }
}

_id_1ACF(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(self._id_0088) && self._id_0088.health > 0 && self botcanseeentity(self._id_0088))
    return 1;

  self.getlookaheaddir = gettime() + 1000;
  return 0;
}

_id_1AC7() {
  self endon("death");
  self endon("disconnect");
  self endon("bot_sentry_canceled");
  self endon("bot_sentry_ensure_exit");
  level endon("game_ended");

  for(;;) {
    if(isDefined(self._id_0088) && self._id_0088.health > 0 && self botcanseeentity(self._id_0088))
      thread _id_1AC6();

    waitframe();
  }
}

_id_1ACD(var_0) {
  thread _id_1ACE(var_0);
}

_id_1ACE(var_0) {
  self endon("stop_tactical_goal");
  self endon("stop_goal_aborted_watch");
  self endon("bot_sentry_canceled");
  self endon("bot_sentry_exited");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(isDefined(var_0._id_68FB) && isDefined(var_0._id_68FB._id_01D0)) {
    if(_distance2d(self.origin, var_0._id_68FB._id_010D.origin) < 400) {
      thread maps\mp\bots\_bots_util::_id_19D4("stand", 5.0);
      thread _id_1AC7();
      maps\mp\bots\_bots_ks::_id_1AF4(var_0._id_68FB._id_5A5C, var_0._id_68FB._id_5A72, var_0._id_68FB._id_01D0);
      return;
    }

    waitframe();
  }
}

_id_1ACA(var_0) {
  var_1 = maps\mp\bots\_bots_util::_id_2C6C();

  if(isDefined(var_1))
    return var_1;

  if(isDefined(self._id_6708))
    return self._id_6708.origin;

  var_2 = _getnodesinradius(self.origin, 1000, 0, 512);
  var_3 = 5;

  if(var_0 != "turret") {
    if(self botgetdifficultysetting("strategyLevel") == 1)
      var_3 = 10;
    else if(self botgetdifficultysetting("strategyLevel") == 0)
      var_3 = 15;
  }

  if(var_0 == "turret_air")
    var_4 = self botnodepick(var_2, var_3, "node_traffic", "ignore_no_sky");
  else
    var_4 = self botnodepick(var_2, var_3, "node_traffic");

  if(isDefined(var_4))
    return var_4.origin;
}

_id_1AC9(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = _getnodesinradius(var_1, 1000, 0, 512);
  var_6 = 5;

  if(var_2 != "turret") {
    if(self botgetdifficultysetting("strategyLevel") == 1)
      var_6 = 10;
    else if(self botgetdifficultysetting("strategyLevel") == 0)
      var_6 = 15;
  }

  if(var_2 == "turret_air")
    var_7 = self botnodepick(var_5, var_6, "node_sentry", var_1, "ignore_no_sky");
  else if(var_2 == "trap")
    var_7 = self botnodepick(var_5, var_6, "node_traffic");
  else if(var_2 == "hide_nonlethal")
    var_7 = self botnodepick(var_5, var_6, "node_hide");
  else
    var_7 = self botnodepick(var_5, var_6, "node_sentry", var_1);

  if(isDefined(var_7)) {
    var_4 = spawnStruct();
    var_4._id_010D = var_7;

    if(var_1 != var_7.origin && var_2 != "hide_nonlethal")
      var_4._id_AAE8 = _vectortoyaw(var_1 - var_7.origin);
    else
      var_4._id_AAE8 = undefined;

    var_4._id_01D0 = var_0._id_01D0;
    var_4._id_5A5C = var_0;
    var_4._id_5A72 = var_3;
  }

  return var_4;
}

_id_1AC8() {
  if(isDefined(self._id_2004))
    return self._id_2004;

  if(isDefined(self._id_2005))
    return self._id_2005;

  if(isDefined(self._id_2003))
    return self._id_2003;
}

_id_1AC4(var_0) {
  var_1 = 0;
  var_2 = _id_1AC8();

  if(isDefined(var_2)) {
    var_3 = 0;

    if(!var_2._id_1F2F) {
      var_4 = 0.75;
      var_5 = gettime();
      var_6 = self getplayerangles()[1];

      if(isDefined(var_0._id_68FB._id_AAE8))
        var_6 = var_0._id_68FB._id_AAE8;

      var_7 = [];
      var_7[0] = var_6 + 180;
      var_7[1] = var_6 + 135;
      var_7[2] = var_6 - 135;
      var_8 = 1000;

      foreach(var_10 in var_7) {
        var_11 = _playerphysicstrace(var_0._id_68FB._id_010D.origin, var_0._id_68FB._id_010D.origin + anglesToForward((0, var_10 + 180, 0)) * 100);
        var_12 = _distance2d(var_11, var_0._id_68FB._id_010D.origin);

        if(var_12 < var_8) {
          var_8 = var_12;
          self botsetscriptmove(var_10, var_4);
          self botlookatpoint(var_0._id_68FB._id_010D.origin, var_4, "script_forced");
        }
      }

      while(!var_3 && isDefined(var_2) && !var_2._id_1F2F) {
        var_14 = _float(gettime() - var_5) / 1000.0;

        if(!var_2._id_1F2F && var_14 > var_4) {
          var_3 = 1;
          self.getlookaheaddir = gettime() + 30000;
        }

        waitframe();
      }
    }

    if(isDefined(var_2) && var_2._id_1F2F) {
      _id_1AC3();
      var_1 = 1;
    }
  }

  wait 0.25;
  _id_1ACB();
  return var_1;
}

_id_1AC3() {
  self notify("place_sentry");
  self notify("place_turret");
  self notify("placePlaceable");
}

_id_1AC2() {
  self switchtoweapon("none");
  self enableweapons();
  self enableweaponswitch();
  self notify("cancel_sentry");
  self notify("cancel_turret");
  self notify("cancelPlaceable");
}

_id_1AC6(var_0) {
  self notify("bot_sentry_canceled");
  _id_1AC2();
  _id_1ACB();
}

_id_1ACB() {
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

  while(isDefined(_id_1AC8())) {
    var_0++;
    _id_1AC2();
    wait 0.25;

    if(var_0 > 2)
      _id_1ACC();
  }

  self notify("bot_sentry_exited");
}

_id_1ACC() {
  self._id_2004 = undefined;
  self._id_2005 = undefined;
  self._id_2003 = undefined;
  self switchtoweapon("none");
  self enableweapons();
  self enableweaponswitch();
}