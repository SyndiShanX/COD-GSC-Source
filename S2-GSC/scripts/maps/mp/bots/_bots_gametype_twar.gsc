/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_twar.gsc
********************************************************/

main() {
  level._id_1A1B = 0;
  _id_87A7();
  _id_879A();
}

_id_87A7() {
  level._id_19D5["gametype_think"] = ::_id_1B12;
  level._id_19D5["should_start_cautious_approach"] = ::_id_1B11;

  if(!level._id_1A1B)
    level._id_19D5["get_watch_node_chance"] = ::_id_1B0D;
}

_id_879A() {
  maps\mp\bots\_bots_util::_id_1B20();

  for(var_0 = 0; var_0 < level._id_9FC2.size; var_0++)
    level._id_9FC2[var_0]._id_81E8 = "_" + var_0;

  maps\mp\bots\_bots_gametype_common::_id_194F(level._id_9FC2, "zone", level._id_1A1B);
  var_1 = 55;
  var_2 = 0;

  foreach(var_4 in level._id_9FC2) {
    if(!isDefined(var_4._id_6638)) {
      return;
    }
    var_4 thread _id_6358();
    var_5 = (var_4.origin - (0, 0, var_1) + (var_4.origin + (0, 0, level._id_AC87))) / 2.0;
    var_6 = (level._id_AC87 + var_1) / 2.0;
    var_4._id_671A = _func_0B8(var_5, level._id_AC8B, 0, var_6);

    if(var_4._id_671A.size < 6) {
      var_2++;

      if(var_2 == 1) {
        wait 5;
        continue;
      }

      wait 1;
    }
  }

  level._id_19E8 = 1;
}

_id_6358() {
  self notify("monitor_twar_zone_control");
  self endon("monitor_twar_zone_control");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 1.0;
    var_0 = self._id_0117;

    if(var_0 == "none" && level._id_9FC0._id_A22B > 0)
      var_0 = level._id_9FC0._id_230F;

    if(var_0 != "none") {
      var_1 = _func_1F7(self.origin);

      if(isDefined(var_1))
        _func_1E8(var_1, var_0);
    }
  }
}

_id_1B12() {
  self notify("bot_twar_think");
  self endon("bot_twar_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  while(!isDefined(level._id_19E8))
    waitframe();

  self _meth_8353("separation", 0);
  self _meth_837B("beeline");
  self _meth_8353("force_sprint", 1);

  for(;;) {
    if(!_id_1B10(level._id_9FC0._id_AC7C))
      _id_1B0C(level._id_9FC0._id_AC7C);

    waitframe();
  }
}

_id_1B0C(var_0) {
  self._id_291F = var_0;
  var_1["entrance_points_index"] = _id_1B0E(var_0);
  var_1["nearest_node_to_center"] = var_0._id_6638;
  var_1["objective_radius"] = 500;
  maps\mp\bots\_bots_strategy::_id_196A(var_0.origin, level._id_AC8B, var_1);
}

_id_1B10(var_0) {
  if(maps\mp\bots\_bots_util::_id_1A28()) {
    if(self._id_291F == var_0)
      return 1;
  }

  return 0;
}

_id_1B0D(var_0) {
  var_1 = 0;
  var_2 = _id_1B0E(level._id_9FC0._id_AC7C);
  var_3 = _id_1B0F(self.team);
  var_1 = 0;

  foreach(var_5 in var_3) {
    if(var_0 maps\mp\bots\_bots_util::_id_670D(var_2, _id_1B0E(var_5))) {
      var_1 = 1;
      break;
    }
  }

  if(var_1) {
    var_7 = _id_1B0F(common_scripts\utility::_id_416F(self.team));

    foreach(var_9 in var_7) {
      if(var_0 maps\mp\bots\_bots_util::_id_670D(var_2, _id_1B0E(var_9))) {
        var_1 = 0;
        break;
      }
    }
  }

  if(var_1)
    return 0.2;

  return 1.0;
}

_id_1B0F(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_9FC2) {
    if(var_3._id_0117 == var_0)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_1B0E(var_0) {
  return "zone" + var_0._id_81E8;
}

_id_1B11(var_0) {
  return 0;
}