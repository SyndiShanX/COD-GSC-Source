/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_ctf.gsc
*******************************************************/

main() {
  _id_87A7();
  _id_8791();
}

_id_87A7() {
  level.bot_funcs["crate_can_use"] = ::_id_2734;
  level.bot_funcs["gametype_think"] = ::_id_1993;
  level.bot_funcs["get_watch_node_chance"] = ::_id_1988;
}

_id_8791() {
  level._id_19DB = ::_id_2897;
  level._id_19DE = ::_id_2898;
  level._id_19D6 = ::_id_4091;
  level._id_19D7 = ::_id_4092;
  level._id_19D9 = ::_id_1984;
  level._id_19E3 = ::_id_1990;
  maps\mp\bots\_bots_util::_id_1B20();

  while(!isDefined(level._id_9853))
    waitframe();

  level._id_9853["allies"].shootblank = "allies";
  level._id_9853["axis"].shootblank = "axis";
  maps\mp\bots\_bots_gametype_common::_id_194F(level._id_9853, "flag_");
  var_0 = _getzonenearest(level._id_9853["allies"].origin);

  if(isDefined(var_0))
    _botzonesetteam(var_0, "allies");

  var_0 = _getzonenearest(level._id_9853["axis"].origin);

  if(isDefined(var_0))
    _botzonesetteam(var_0, "axis");

  level._id_1FC6["allies"]._id_6638 = level._id_9853["allies"]._id_6638;
  level._id_1FC6["axis"]._id_6638 = level._id_9853["axis"]._id_6638;
  thread _id_1983();
  level._id_19E8 = 1;
}

_id_2734(var_0) {
  if(_isagent(self) && !isDefined(var_0._id_1B7B))
    return 0;

  if(_id_1991())
    return 0;

  return _id_1986(self.team);
}

_id_1993() {
  self notify("bot_ctf_think");
  self endon("bot_ctf_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!isDefined(level._id_19E8))
    waitframe();

  self._id_66A7 = 0;
  self botsetflag("separation", 0);
  self botsetflag("use_obj_path_style", 1);
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    waitframe();

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(self._id_7ECA))
      maps\mp\bots\_bots_gametype_common::_id_19E7();

    if(_id_1986(self.team)) {
      if(isDefined(level._id_1A53) && isDefined(level._id_1A53[level._id_6C63[self.team]]))
        level._id_1A53[level._id_6C63[self.team]] = undefined;
    }

    var_2 = 0;

    if(self._id_7ECA == "attacker") {
      if(_id_1991())
        var_2 = 1;
      else if(!_id_1985())
        var_2 = distancesquared(self.origin, level._id_9853[level._id_6C63[self.team]]._id_28D4) < _squared(_id_4195());
    } else if(!_id_1986(self.team))
      var_2 = !_id_1989();

    self botsetflag("force_sprint", var_2);
    var_1 = 0;

    if(_id_1991()) {
      if(_id_1986(self.team)) {
        _id_23B2();
        var_1 = 1;

        if(!var_0) {
          var_0 = 1;
          self botsetpathingstyle("scripted");
        }

        self botsetscriptgoal(level._id_1FC6[self.team]._id_28D4, 16, "critical");
      } else if(maps\mp\bots\_bots_gametype_common::_id_19E1(self.team) == 1)
        _id_1992();
      else if(gettime() > self._id_66A7) {
        _id_23B2();
        var_3 = _getnodesinradius(level._id_1FC6[self.team]._id_28D4, 900, 0, 300);
        var_4 = self botnodepick(var_3, var_3.size * 0.15, "node_hide_anywhere");

        if(!isDefined(var_4))
          var_4 = level._id_1FC6[self.team]._id_6638;

        var_5 = self botsetscriptgoalnode(var_4, "critical");

        if(var_5)
          self._id_66A7 = gettime() + 15000;
      }
    } else if(self._id_7ECA == "attacker") {
      if(_id_1985()) {
        if(!maps\mp\bots\_bots_util::_id_1A27()) {
          _id_23B2();
          self botclearscriptgoal();
          var_6 = level._id_9853[level._id_6C63[self.team]].carrier;
          maps\mp\bots\_bots_strategy::_id_1A0C(var_6, 500);
        }
      } else {
        _id_23B2();

        if(self botgetscriptgoaltype() == "critical")
          self botclearscriptgoal();

        self botsetscriptgoal(level._id_9853[level._id_6C63[self.team]]._id_28D4, 16, "objective", undefined, 300);
      }
    } else if(!_id_1986(self.team))
      _id_1992();
    else if(!_id_55F2()) {
      self botclearscriptgoal();
      var_7["score_flags"] = "strict_los";
      var_7["entrance_points_index"] = "flag_" + level._id_9853[self.team].shootblank;
      var_7["nearest_node_to_center"] = level._id_9853[self.team]._id_6638;
      maps\mp\bots\_bots_strategy::_id_1AA6(level._id_9853[self.team]._id_28D4, _id_4195(), var_7);
    }

    if(var_0 && !var_1) {
      var_0 = 0;
      self botsetpathingstyle(undefined);
    }
  }
}

_id_1992() {
  var_0 = undefined;
  var_1 = level._id_9853[self.team];
  var_2 = var_1.carrier;

  if(!isDefined(var_2))
    var_0 = var_1._id_28D4;
  else if(self botcanseeentity(var_2)) {
    var_0 = var_2.origin;

    if(self botgetdifficultysetting("strategyLevel") > 0 && !_id_1986(self.team)) {
      if(!isDefined(level._id_1A53))
        level._id_1A53 = [];

      if(!isDefined(level._id_1A53[var_2.team]))
        level._id_1A53[var_2.team] = [];

      level._id_1A53[var_2.team]["origin"] = var_0;
      level._id_1A53[var_2.team]["time"] = gettime();
    }
  } else if(isDefined(var_1._id_28CF)) {
    if(isDefined(var_1._id_2562["friendly"])) {
      if(var_1._id_6990)
        var_0 = var_1._id_28CF;
      else
        var_0 = var_2.origin;
    }
  } else
    var_0 = var_1._id_28D4;

  if(isDefined(var_0)) {
    _id_23B2();
    self botsetscriptgoal(var_0, 16, "critical");
  } else {
    var_3 = undefined;
    var_4 = undefined;

    if(self botgetdifficultysetting("strategyLevel") > 0) {
      if(isDefined(level._id_1A53) && isDefined(level._id_1A53[var_2.team])) {
        var_4 = gettime() - level._id_1A53[var_2.team]["time"];

        if(var_4 < 10000)
          var_3 = level._id_1A53[var_2.team]["origin"];
      }
    }

    if(isDefined(var_3)) {
      if(var_4 < 5000) {
        _id_23B2();
        self botsetscriptgoal(var_3, 16, "critical");
      } else if(!maps\mp\bots\_bots_util::_id_1A32()) {
        maps\mp\bots\_bots_strategy::_id_19A3();
        maps\mp\bots\_bots_strategy::_id_1A8D(var_3, 400);
      }
    } else {
      _id_23B2();
      var_5 = self botgetscriptgoaltype();

      if(var_5 == "objective" || var_5 == "critical")
        self botclearscriptgoal();

      maps\mp\bots\_bots_personality::_id_A0C0();
    }
  }
}

_id_23B2() {
  if(maps\mp\bots\_bots_util::_id_1A2D())
    maps\mp\bots\_bots_strategy::_id_19A3();
}

_id_55F2() {
  return maps\mp\bots\_bots_util::_id_1A33();
}

_id_4195() {
  if(isalive(self) && !isDefined(level._id_7790)) {
    var_0 = self botgetworldsize();
    var_1 = (var_0[0] + var_0[1]) / 2;
    level._id_7790 = _min(800, var_1 / 5.5);
  }

  if(!isDefined(level._id_7790))
    return 900;

  return level._id_7790;
}

_id_2897(var_0) {
  var_1 = maps\mp\bots\_bots_gametype_common::_id_19E1(var_0);

  if(var_1 == 1)
    return 1;

  if(_id_1986(var_0))
    var_2 = var_1 * 0.67;
  else if(_id_1986(level._id_6C63[var_0]))
    var_2 = var_1 * 0.5;
  else
    var_2 = var_1 * 0.4;

  var_3 = int(_round(var_2));
  var_4 = game["teamScores"][var_0];
  var_5 = game["teamScores"][common_scripts\utility::_id_416F(var_0)];

  if(var_4 + 1 < var_5)
    var_3 = int(_min(var_3 + 1, var_1));

  return var_3;
}

_id_2898(var_0) {
  var_1 = maps\mp\bots\_bots_gametype_common::_id_19E1(var_0);
  return var_1 - _id_2897(var_0);
}

_id_4091(var_0) {
  return maps\mp\bots\_bots_gametype_common::_id_19DF(var_0, level._id_1FC6[var_0]._id_28D4, _id_4195());
}

_id_4092(var_0) {
  return maps\mp\bots\_bots_gametype_common::_id_19E0(var_0, level._id_1FC6[var_0]._id_28D4, _id_4195());
}

_id_1983() {
  level notify("bot_ctf_ai_director_update");
  level endon("bot_ctf_ai_director_update");
  level endon("game_ended");
  thread maps\mp\bots\_bots_gametype_common::_id_19DA();
}

_id_1988(var_0) {
  if(var_0 == self._id_6709)
    return 1.0;

  if(!_id_55F2())
    return 1.0;

  var_1 = var_0 maps\mp\bots\_bots_util::_id_670D("flag_allies", "flag_axis");

  if(var_1)
    return 1.0;

  return 0.2;
}

_id_1986(var_0) {
  return level._id_9853[var_0] _id_04D1::_id_5715();
}

_id_1987(var_0) {
  return isDefined(level._id_9853[var_0].carrier);
}

_id_1989() {
  return _id_1987(self.team);
}

_id_1985() {
  return _id_1987(level._id_6C63[self.team]);
}

_id_1991() {
  return isDefined(self._id_2013);
}

_id_1984() {
  if(_id_1991())
    return 0;

  return 1;
}

_id_1990() {
  if(_id_1991())
    return 1;

  return 0;
}