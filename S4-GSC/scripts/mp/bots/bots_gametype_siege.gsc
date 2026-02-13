/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_siege.gsc
***************************************************/

main() {
  _id_D795();
  thread _id_28E0();
  _id_D77E();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_28E1;
}

_id_D77E() {
  level._id_27B0 = 1;
}

_id_28E0() {
  level._id_DD25 = [];
  _id_07D1::_id_60C2("prematch_done");
  level._id_DD26 = [];
  level._id_DD24 = [];

  for(;;) {
    level._id_DD25 = [];

    foreach(var_1 in level.players) {
      if(!scripts\mp\utility\player::isreallyalive(var_1) && var_1._id_75B4) {
        if(var_1.team != "spectator" && var_1.team != "neutral") {
          level._id_DD25[var_1.team] = 1;
        }
      }
    }

    var_3 = [];

    foreach(var_5 in level._id_A8E8) {
      var_6 = var_5 _id_07D6::_id_6C02();

      if(var_6 != "neutral") {
        if(!isDefined(var_3[var_6])) {
          var_3[var_6] = 1;
          continue;
        }

        var_3[var_6]++;
      }
    }

    foreach(var_6, var_9 in var_3) {
      if(var_9 >= 2) {
        var_10 = scripts\mp\utility\game::_id_6BE2(var_6)[0];
        level._id_DD25[var_10] = 1;

        if(var_9 == 2 && !istrue(level._id_DD26[var_6])) {
          if(randomint(100) > 75) {
            level._id_DD25[var_6] = 1;
          } else {
            level._id_DD26[var_6] = 0;
          }

          level._id_DD24[var_6] = 1;
        }

        continue;
      }

      if(var_9 < 2 && istrue(level._id_DD24[var_6])) {
        level._id_DD24[var_6] = 0;
        level._id_DD26[var_6] = 0;
      }
    }

    wait 1.0;
  }
}

_id_28E1() {
  self notify("bot_siege_think");
  self endon("bot_siege_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level._id_27B0)) {
    wait 0.05;
  }

  while(!isDefined(level._id_DD25)) {
    wait 0.05;
  }

  self _meth_8054("separation", 0);
  self _meth_8054("use_obj_path_style", 1);

  for(;;) {
    if(isDefined(level._id_DD25[self.team]) && level._id_DD25[self.team]) {
      _id_2733();
    } else if(isDefined(self._id_7088)) {
      if(scripts\mp\bots\bots_util::_id_2805()) {
        _id_09F9::_id_2766();
      }

      self._id_7088 = undefined;
    }

    wait 1.0;
  }
}

_id_2733() {
  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in level._id_A8E8) {
    var_4 = var_3 _id_07D6::_id_6C02();

    if(var_4 != self.team) {
      var_5 = distancesquared(self.origin, var_3.trigger.origin);

      if(!isDefined(var_1) || var_5 < var_1) {
        var_1 = var_5;
        var_0 = var_3;
      }
    }
  }

  if(isDefined(var_0)) {
    if(!isDefined(self._id_7088) || self._id_7088 != var_0) {
      self._id_7088 = var_0;
      _id_09F9::_id_2729(var_0.trigger.origin, 100);
    }
  }
}