/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\_agents_gametype_raid.gsc
************************************************************/

main() {
  _id_87A7();
}

_id_87A7() {
  level._id_0A41["squadmate"]["spawn"] = ::_id_90A6;
  level._id_0A41["squadmate"]["think"] = ::_id_0C6D;
  level._id_0A41["squadmate"]["onAIConnect"] = ::_id_6BAE;
  level._id_0A41["squadmate"]["on_damaged_finished"] = maps\mp\agents\_agents::_id_0A40;
  level._id_0A41["squadmate"]["on_damaged"] = maps\mp\agents\_agents::_id_6A74;
  level._id_0A41["squadmate"]["on_killed"] = maps\mp\agents\_agents::_id_6A75;
  level._id_0A41["minion"]["spawn"] = ::_id_9079;
  level._id_0A41["minion"]["think"] = ::_id_621A;
  level._id_0A41["minion"]["on_damaged_finished"] = maps\mp\agents\_agents::_id_0A40;
  level._id_0A41["minion"]["on_damaged"] = maps\mp\agents\_agents::_id_6A74;
  level._id_0A41["minion"]["on_killed"] = maps\mp\agents\_agents::_id_6A75;
  level._id_0A41["beach_ally"]["spawn"] = ::_id_9079;
  level._id_0A41["beach_ally"]["think"] = ::_id_621A;
  level._id_0A41["beach_ally"]["on_damaged_finished"] = maps\mp\agents\_agents::_id_0A40;
  level._id_0A41["beach_ally"]["on_damaged"] = maps\mp\agents\_agents::_id_6A74;
  level._id_0A41["beach_ally"]["on_killed"] = ::_id_6A79;
  level._id_0A41["player"]["think"] = ::agent_player_raid_think;
  level._id_17C8 = ::_id_17C8;
}

agent_player_raid_think() {
  thread maps\mp\bots\_bots_gametype_raid::_id_1AAD();
}

_id_9079(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(level._id_0A41[self._id_0A4B]["onAIConnect"]))
    [[maps\mp\agents\_agent_utility::_id_0A59("onAIConnect")]]();

  maps\mp\agents\_agents::_id_8F70(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  maps\mp\agents\_agent_utility::_id_83FE(self.team);
  self._id_0009 = &"RAIDS_SQUADMATE";
  self _meth_8528(1, self.team);
  self._id_2F05 = "veteran";
  _id_8727();
  _id_04C2::_id_2F72(self);
  self._id_6734 = 1;
  self._id_672C = 1;
  thread _id_6BA4();
}

_id_621A() {}

_id_90A6(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(level._id_0A41[self._id_0A4B]["onAIConnect"]))
    [[maps\mp\agents\_agent_utility::_id_0A59("onAIConnect")]]();

  maps\mp\agents\_agents::_id_8F70(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  maps\mp\agents\_agent_utility::_id_83FE(self.team);
  self._id_0009 = &"RAIDS_SQUADMATE";
  self _meth_8528(1, self.team);
  self._id_2F05 = "veteran";
  _id_8727();
  _id_04C2::_id_2F72(self);
  self._id_6734 = 1;
  self._id_672C = 1;
  thread _id_6BA4();
}

_id_6BAE() {}

_id_8727() {
  maps\mp\bots\_bots_util::_id_1AD5("run_and_gun");

  if(isDefined(self._id_2F05))
    maps\mp\bots\_bots_util::_id_1AD3(self._id_2F05);
  else
    maps\mp\bots\_bots_util::_id_1AD3("regular");

  self._id_2F05 = self _meth_836D();
}

_id_6BA4(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("applyLoadout");
  self _meth_8543(1);
  self _meth_8353("no_enemy_search", 1);
}

_id_0C6D() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  self _meth_8353("force_sprint", 1);
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    if(!isDefined(self._id_0117)) {
      maps\mp\_utility::_suicide();
      return;
    }

    if(_func_0AD(self._id_0117.health) / self._id_0117.maxhealth < 0.5 && gettime() > var_1) {
      var_2 = _func_0B9(self._id_0117.origin, 256, 0);

      if(var_2.size >= 2) {
        self._id_2C85 = var_2[1];
        self notify("defend_force_node_recalculation");
        var_1 = gettime() + 1000;
      }
    } else if(_func_0AD(self.health) / self.maxhealth >= 0.6)
      var_0 = 0;
    else if(!var_0) {
      var_3 = maps\mp\bots\_bots_util::_id_19CE(self._id_0117.origin, 350, 1);

      if(isDefined(var_3)) {
        self._id_2C85 = var_3;
        self notify("defend_force_node_recalculation");
        var_0 = 1;
      }
    }

    if(!maps\mp\bots\_bots_util::_id_1A30(self._id_0117)) {
      var_4["override_goal_type"] = "critical";
      var_4["min_goal_time"] = 20;
      var_4["max_goal_time"] = 30;
      maps\mp\bots\_bots_strategy::_id_1A0C(self._id_0117, 350, var_4);
    }

    waitframe();
  }
}

_id_17C8(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_791B))
    level._id_791B = [];

  if(level._id_791B.size > 6)
    level._id_791B[0] _meth_8059(level._id_791B[0].health + 100, level._id_791B[0].origin);

  var_5 = [[level._id_0A4D]]("minion", var_3, undefined, var_0, var_1, undefined, 0, 0, "recruit");
  level._id_791B[level._id_791B.size] = var_5;
  var_5 _meth_8354(var_2);
  var_5 thread _id_0A5F();
}

_id_0A5F() {
  level endon("game_ended");
  self endon("death");
  _id_0A5E();
  thread _id_0A60();
  maps\mp\bots\_bots_strategy::_id_1A8D(self.origin, 512, []);
  wait 15;
  self _meth_8059(self.health + 100, self.origin);
}

_id_0A5E() {
  var_0 = self getweaponlistprimaries();
  var_1 = self _meth_834A();
  var_2 = self getoffhandsecondaryclass();
  var_0[var_0.size] = var_1;
  var_0[var_0.size] = var_2;

  foreach(var_4 in var_0) {
    if(var_4 == "none") {
      continue;
    }
    self givestartammo(var_4);

    if(var_4 == var_1)
      var_5 = 0;
    else if(var_4 == var_2)
      var_5 = 0;
    else if(var_4 == "panzerschreck_mp")
      var_5 = 0;
    else if(var_4 == "bazooka_mp")
      var_5 = 0;
    else
      var_5 = _func_1A3(var_4, self);

    self setweaponammoclip(var_4, var_5);
  }

  self _meth_82AB();
}

_id_0A60() {
  level endon("game_ended");
  self waittill("death");
  level._id_791B = common_scripts\utility::_id_0F93(level._id_791B, self);
}

_id_6A79(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self[[level._id_0A5D]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
  level thread maps\mp\gametypes\_rank::_id_1457("raids_npc_kill", var_1, var_4, self, var_3);

  if(isDefined(level._id_6A75))
    [[level._id_6A75]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(self._id_565F) {
    self._id_4B60 = 1;

    if(maps\mp\_utility::getgametypenumlives() != 1 && (isDefined(self._id_7DAD) && self._id_7DAD))
      self thread[[maps\mp\agents\_agent_utility::_id_0A59("spawn")]]();
    else
      maps\mp\agents\_agent_utility::_id_2A73();
  }
}