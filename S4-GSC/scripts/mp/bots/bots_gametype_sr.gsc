/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_sr.gsc
*************************************************/

main() {
  scripts\mp\bots\bots_gametype_sd::_id_D795();
  _id_D795();
  scripts\mp\bots\bots_gametype_conf::_id_D769();
  scripts\mp\bots\bots_gametype_sd::_id_28B0();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_28EB;
}

_id_28EB() {
  self notify("bot_sr_think");
  self endon("bot_sr_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self._id_7522 = undefined;

  while(!isDefined(level._id_27B0)) {
    wait 0.05;
  }

  self._id_EBE1 = undefined;
  childthread _id_ED48();
  scripts\mp\bots\bots_gametype_sd::_id_28B1();
}

_id_ED48() {
  for(;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(self._id_C8C5)) {
      continue;
    }
    var_0 = scripts\mp\bots\bots_gametype_conf::_id_2796(0);

    if(var_0.size > 0) {
      var_1 = scripts\engine\utility::random(var_0);

      if(distancesquared(self.origin, var_1._id_0427._id_4140) < 10000) {
        _id_E4D8(var_1._id_0427);
      } else if(self.team == game["attackers"]) {
        if(self._id_C8C5 != "atk_bomber") {
          _id_E4D8(var_1._id_0427);
        }
      } else if(self._id_C8C5 != "defuser")
        _id_E4D8(var_1._id_0427);
    }
  }
}

_id_E4D8(var_0) {
  if(isDefined(var_0._id_288C) && isDefined(var_0._id_288C[self.team]) && isalive(var_0._id_288C[self.team]) && var_0._id_288C[self.team] != self) {
    return;
  }
  if(_id_E4D3(var_0)) {
    return;
  }
  if(!isDefined(self._id_C8C5)) {
    return;
  }
  if(scripts\mp\bots\bots_util::_id_2805()) {
    _id_09F9::_id_2766();
  }

  var_0._id_288C[self.team] = self;
  var_0 thread _id_38BD();
  var_0 thread _id_38BC(self);
  self._id_EBE1 = 1;
  childthread _id_A68F(var_0, "tag_picked_up");
  var_1 = var_0._id_4140;
  self _meth_8058(var_1, 0, "tactical");
  childthread _id_10A82(var_0);
  var_2 = scripts\mp\bots\bots_util::_id_291C(undefined, "tag_picked_up", "new_role");
  self notify("stop_watch_tag_destination");

  if(var_2 == "no_path") {
    var_1 = var_1 + (16 * _id_BFD2(), 16 * _id_BFD2(), 0);
    self _meth_8058(var_1, 0, "tactical");
    var_2 = scripts\mp\bots\bots_util::_id_291C(undefined, "tag_picked_up", "new_role");

    if(var_2 == "no_path") {
      var_1 = scripts\mp\bots\bots_util::_id_289B("BotGetClosestNavigablePoint", scripts\mp\bots\bots_util::_id_6019, var_0._id_4140, 32, self);

      if(isDefined(var_1)) {
        self _meth_8058(var_1, 0, "tactical");
        var_2 = scripts\mp\bots\bots_util::_id_291C(undefined, "tag_picked_up", "new_role");
      }
    }
  } else if(var_2 == "bad_path") {
    var_3 = _func_00B5(var_0._id_4140, 256, 0, level._id_28F2 + 55);

    if(var_3.size > 0) {
      var_4 = (var_0._id_4140[0], var_0._id_4140[1], (var_3[0].origin[2] + var_0._id_4140[2]) * 0.5);
      self _meth_8058(var_4, 0, "tactical");
      var_2 = scripts\mp\bots\bots_util::_id_291C(undefined, "tag_picked_up", "new_role");
    }
  }

  if(var_2 == "goal" && var_0 scripts\mp\bots\bots_gametype_conf::_id_271F(self.team)) {
    wait 3.0;
  }

  if(self _meth_8042() && isDefined(var_1)) {
    var_5 = self _meth_803B();

    if(scripts\mp\bots\bots_util::_id_2916(var_5, var_1)) {
      self _meth_802B();
    }
  }

  self notify("stop_tag_watcher");
  var_0._id_288C[self.team] = undefined;
  self._id_EBE1 = undefined;
}

_id_10A82(var_0) {
  self endon("stop_watch_tag_destination");

  for(;;) {
    if(!var_0 scripts\mp\bots\bots_gametype_conf::_id_271F(self.team)) {
      wait 0.05;
    }

    var_1 = self _meth_803B();
    wait 0.05;
  }
}

_id_E4D3(var_0) {
  var_1 = distance(self.origin, var_0._id_4140);
  var_2 = scripts\mp\bots\bots_gametype_common::_id_656A(self.team, 1);

  foreach(var_4 in var_2) {
    if(var_4 != self && isDefined(var_4._id_C8C5) && var_4._id_C8C5 != "atk_bomber" && var_4._id_C8C5 != "defuser") {
      var_5 = distance(var_4.origin, var_0._id_4140);

      if(var_5 < var_1 * 0.5) {
        return 1;
      }
    }
  }

  return 0;
}

_id_BFD2() {
  return randomintrange(0, 2) * 2 - 1;
}

_id_38BD() {
  self waittill("reset");
  self._id_288C = [];
}

_id_38BC(var_0) {
  self endon("reset");
  var_1 = var_0.team;
  var_0 waittill("death_or_disconnect");
  self._id_288C[var_1] = undefined;
}

_id_A68F(var_0, var_1) {
  self endon("stop_tag_watcher");

  while(var_0 scripts\mp\bots\bots_gametype_conf::_id_271F(self.team) && !scripts\mp\bots\bots_gametype_conf::_id_272C(var_0)) {
    wait 0.05;
  }

  self notify(var_1);
}

_id_E4D4(var_0) {
  if(isDefined(var_0._id_2719) && isDefined(var_0._id_2719[self.team]) && isalive(var_0._id_2719[self.team]) && var_0._id_2719[self.team] != self) {
    return;
  }
  if(!isDefined(self._id_C8C5)) {
    return;
  }
  if(scripts\mp\bots\bots_util::_id_2805()) {
    _id_09F9::_id_2766();
  }

  var_0._id_2719[self.team] = self;
  var_0 thread _id_38BB();
  var_0 thread _id_38BA(self);
  self._id_EBE1 = 1;
  _id_09F7::_id_38BF();
  var_1 = self._id_C8C5;

  while(var_0 scripts\mp\bots\bots_gametype_conf::_id_271F(self.team) && self._id_C8C5 == var_1) {
    if(_id_09F7::_id_DACD()) {
      if(_id_09F7::_id_5AB1(var_0._id_4140, 1000)) {
        childthread scripts\mp\bots\bots_gametype_conf::_id_2717(var_0, "tactical", "new_role");
      }
    }

    wait 0.05;
  }

  self notify("stop_camping_tag");
  self _meth_802B();
  var_0._id_2719[self.team] = undefined;
  self._id_EBE1 = undefined;
}

_id_38BB() {
  self waittill("reset");
  self._id_2719 = [];
}

_id_38BA(var_0) {
  self endon("reset");
  var_1 = var_0.team;
  var_0 waittill("death_or_disconnect");
  self._id_2719[var_1] = undefined;
}