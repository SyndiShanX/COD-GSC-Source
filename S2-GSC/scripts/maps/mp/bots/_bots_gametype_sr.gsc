/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_sr.gsc
******************************************************/

main() {
  maps\mp\bots\_bots_gametype_sd::_id_87A7();
  _id_87A7();
  maps\mp\bots\_bots_gametype_conf::_id_8790();
  maps\mp\bots\_bots_gametype_sd::_id_1ABF();
}

_id_87A7() {
  level.bot_funcs["gametype_think"] = ::_id_1AF0;
}

_id_1AF0() {
  self notify("bot_sr_think");
  self endon("bot_sr_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self._id_4B44 = undefined;

  while(!isDefined(level._id_19E8)) {
    waitframe();
  }

  self._id_9526 = undefined;
  childthread _id_95B3();
  maps\mp\bots\_bots_gametype_sd::_id_1AC0();
}

_id_95B3() {
  for(;;) {
    waitframe();

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(self._id_7ECA)) {
      continue;
    }
    var_0 = maps\mp\bots\_bots_gametype_conf::_id_19D1(0);

    if(var_0.size > 0) {
      var_1 = common_scripts\utility::random(var_0);

      if(distancesquared(self.origin, var_1._id_95A6._id_28D4) < 10000) {
        _id_913E(var_1._id_95A6);
      } else if(self.team == game["attackers"]) {
        if(self._id_7ECA != "atk_bomber") {
          _id_913E(var_1._id_95A6);
        }
      } else if(self._id_7ECA != "defuser")
        _id_913E(var_1._id_95A6);
    }
  }
}

_id_913E(var_0) {
  if(isDefined(var_0._id_1A9A) && isDefined(var_0._id_1A9A[self.team]) && isalive(var_0._id_1A9A[self.team]) && var_0._id_1A9A[self.team] != self) {
    return;
  }
  if(_id_913C(var_0)) {
    return;
  }
  if(!isDefined(self._id_7ECA)) {
    return;
  }
  if(maps\mp\bots\_bots_util::_id_1A2D()) {
    maps\mp\bots\_bots_strategy::_id_19A3();
  }

  var_0._id_1A9A[self.team] = self;
  var_0 thread _id_23A9();
  var_0 thread _id_23A8(self);
  self._id_9526 = 1;
  childthread _id_6804(var_0, "tag_picked_up");
  var_1 = var_0._id_28D4;
  self botsetscriptgoal(var_1, 0, "tactical");
  childthread _id_A8E2(var_0);
  var_2 = maps\mp\bots\_bots_util::_id_1B21(undefined, "tag_picked_up", "new_role");
  self notify("stop_watch_tag_destination");

  if(var_2 == "no_path") {
    var_1 = var_1 + (16 * _id_7A32(), 16 * _id_7A32(), 0);
    self botsetscriptgoal(var_1, 0, "tactical");
    var_2 = maps\mp\bots\_bots_util::_id_1B21(undefined, "tag_picked_up", "new_role");

    if(var_2 == "no_path") {
      var_1 = maps\mp\bots\_bots_util::_id_1AA8("BotGetClosestNavigablePoint", maps\mp\bots\_bots_util::_id_3F03, var_0._id_28D4, 32, self);

      if(isDefined(var_1)) {
        self botsetscriptgoal(var_1, 0, "tactical");
        var_2 = maps\mp\bots\_bots_util::_id_1B21(undefined, "tag_picked_up", "new_role");
      }
    }
  } else if(var_2 == "bad_path") {
    var_3 = _getnodesinradiussorted(var_0._id_28D4, 256, 0, level._id_1AF5 + 55);

    if(var_3.size > 0) {
      var_4 = (var_0._id_28D4[0], var_0._id_28D4[1], (var_3[0].origin[2] + var_0._id_28D4[2]) * 0.5);
      self botsetscriptgoal(var_4, 0, "tactical");
      var_2 = maps\mp\bots\_bots_util::_id_1B21(undefined, "tag_picked_up", "new_role");
    }
  }

  if(var_2 == "goal" && var_0 _id_04D1::_id_1F53(self.team)) {
    wait 3.0;
  }

  if(self bothasscriptgoal() && isDefined(var_1)) {
    var_5 = self botgetscriptgoal();

    if(maps\mp\bots\_bots_util::_id_1B1C(var_5, var_1)) {
      self botclearscriptgoal();
    }
  }

  self notify("stop_tag_watcher");
  var_0._id_1A9A[self.team] = undefined;
  self._id_9526 = undefined;
}

_id_A8E2(var_0) {
  self endon("stop_watch_tag_destination");

  for(;;) {
    if(!var_0 _id_04D1::_id_1F53(self.team)) {
      waitframe();
    }

    var_1 = self botgetscriptgoal();
    waitframe();
  }
}

_id_913C(var_0) {
  var_1 = distance(self.origin, var_0._id_28D4);
  var_2 = maps\mp\bots\_bots_gametype_common::_id_41FB(self.team, 1);

  foreach(var_4 in var_2) {
    if(var_4 != self && isDefined(var_4._id_7ECA) && var_4._id_7ECA != "atk_bomber" && var_4._id_7ECA != "defuser") {
      var_5 = distance(var_4.origin, var_0._id_28D4);

      if(var_5 < var_1 * 0.5) {
        return 1;
      }
    }
  }

  return 0;
}

_id_7A32() {
  return _randomintrange(0, 2) * 2 - 1;
}

_id_23A9() {
  self waittill("reset");
  self._id_1A9A = [];
}

_id_23A8(var_0) {
  self endon("reset");
  var_1 = var_0.team;
  var_0 common_scripts\utility::_id_A70A("death", "disconnect");
  self._id_1A9A[var_1] = undefined;
}

_id_6804(var_0, var_1) {
  self endon("stop_tag_watcher");

  while(var_0 _id_04D1::_id_1F53(self.team) && !maps\mp\bots\_bots_gametype_conf::_id_196E(var_0)) {
    waitframe();
  }

  self notify(var_1);
}

_id_913D(var_0) {
  if(isDefined(var_0._id_1955) && isDefined(var_0._id_1955[self.team]) && isalive(var_0._id_1955[self.team]) && var_0._id_1955[self.team] != self) {
    return;
  }
  if(!isDefined(self._id_7ECA)) {
    return;
  }
  if(maps\mp\bots\_bots_util::_id_1A2D()) {
    maps\mp\bots\_bots_strategy::_id_19A3();
  }

  var_0._id_1955[self.team] = self;
  var_0 thread _id_23A7();
  var_0 thread _id_23A6(self);
  self._id_9526 = 1;
  maps\mp\bots\_bots_personality::_id_23AB();
  var_1 = self._id_7ECA;

  while(var_0 _id_04D1::_id_1F53(self.team) && self._id_7ECA == var_1) {
    if(maps\mp\bots\_bots_personality::_id_8B73()) {
      if(maps\mp\bots\_bots_personality::_id_3B64(var_0._id_28D4, 1000)) {
        childthread maps\mp\bots\_bots_gametype_conf::_id_1954(var_0, "tactical", "new_role");
      }
    }

    waitframe();
  }

  self notify("stop_camping_tag");
  self botclearscriptgoal();
  var_0._id_1955[self.team] = undefined;
  self._id_9526 = undefined;
}

_id_23A7() {
  self waittill("reset");
  self._id_1955 = [];
}

_id_23A6(var_0) {
  self endon("reset");
  var_1 = var_0.team;
  var_0 common_scripts\utility::_id_A70A("death", "disconnect");
  self._id_1955[var_1] = undefined;
}