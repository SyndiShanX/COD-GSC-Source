/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_undead.gsc
**********************************************************/

main() {
  _id_87A7();
  _id_8796();
}

_id_87A7() {
  level._id_19D5["gametype_think"] = ::_id_1A1A;
  level._id_19D5["should_start_cautious_approach"] = ::_id_8B7C;
}

_id_8796() {
  maps\mp\bots\_bots_util::_id_1B20();
  var_0 = 0;

  for(var_1 = 0; var_1 < level._id_0BCF.size; var_1++) {
    var_2 = level._id_0BCF[var_1];
    var_2._id_81E8 = "zone_" + var_1;
    var_2 thread maps\mp\bots\_bots_gametype_common::_id_6361();
    var_3 = 0;

    if(isDefined(var_2._id_9D5E._id_9D9F) && var_2._id_9D5E._id_9D9F) {
      var_2._id_9D5E common_scripts\utility::_id_9DA3();
      var_3 = 1;
    }

    var_2._id_671A = maps\mp\bots\_bots_gametype_common::_id_1A08(var_2._id_9D5E);

    if(var_3)
      var_2._id_9D5E common_scripts\utility::_id_9D9F();
  }

  level._id_1AD9 = 1;

  if(!var_0) {
    level._id_1A19 = 1;
    var_4 = level._id_AC7C;

    if(!isDefined(var_4))
      var_4 = common_scripts\utility::random(level._id_0BCF);

    maps\mp\bots\_bots_gametype_common::_id_1951([var_4]);
    level._id_19EA[var_4 getentitynumber()] = 1;
    level._id_19E8 = 1;
    thread _id_1950(var_4);
  }
}

_id_1950(var_0) {
  for(var_1 = common_scripts\utility::_id_0F93(level._id_0BCF, var_0); var_1.size > 0; var_1 = common_scripts\utility::_id_0F93(var_1, var_2)) {
    var_2 = undefined;
    var_3 = level._id_AC7C;

    if(isDefined(var_3) && common_scripts\utility::_id_0F79(var_1, var_3))
      var_2 = var_3;
    else
      var_2 = common_scripts\utility::random(var_1);

    maps\mp\bots\_bots_gametype_common::_id_1951([var_2]);
    level._id_19EA[var_2 getentitynumber()] = 1;
  }
}

_id_1A1A() {
  self notify("bot_hp_think");
  self endon("bot_hp_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!isDefined(level._id_19E8))
    waitframe();

  self _meth_8353("separation", 0);
  self _meth_8353("grenade_objectives", 1);
  var_0 = undefined;
  var_1 = level._id_AC7C;

  for(;;) {
    waitframe();

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(level._id_AC7C) || !isDefined(level._id_19EA[level._id_AC7C getentitynumber()])) {
      if(maps\mp\bots\_bots_util::_id_1A2D())
        maps\mp\bots\_bots_strategy::_id_19A3();

      self._id_291F = undefined;
      self[[self._id_6F7F]]();
      continue;
    }

    if(var_1 != level._id_AC7C) {
      var_0 = undefined;
      var_1 = level._id_AC7C;
    }

    if(isDefined(level._id_ACAF) && !isDefined(var_0) && level._id_7A62 == 0 && level._id_1A19) {
      var_2 = level._id_ACAF - gettime();

      if(var_2 > 0 && var_2 < 10000) {
        var_3 = level._id_AC7C._id_3FCA _id_04D1::_id_45F7() == self.team;

        if(!var_3) {
          var_4 = level._id_AC7C._id_AC7F.radius * 6;

          if(var_2 < 5000)
            var_4 = level._id_AC7C._id_AC7F.radius * 3;

          var_5 = distance(level._id_AC7C._id_AC7F._id_206B, self.origin);

          if(var_5 > var_4)
            var_0 = _id_1ADF();
        } else {
          var_6 = maps\mp\bots\_bots_util::_id_19F9(self.team);
          var_7 = _func_0D5(var_6 / 2);

          if(var_2 < 5000)
            var_7 = _func_0D5(var_6 / 3);

          var_8 = _id_19FB(level._id_AC7C);

          if(var_8 + 1 > var_7)
            var_0 = _id_1ADF();
        }
      }
    }

    var_9 = level._id_AC7C;

    if(isDefined(var_0) && var_0)
      var_9 = level._id_ACB3[(level._id_76EE + 1) % level._id_ACB3.size];

    if(!_id_1A2B(var_9))
      _id_1969(var_9);
  }
}

_id_1ADF() {
  if(level._id_7A62)
    return 0;
  else {
    var_0 = self _meth_837D("strategyLevel");
    var_1 = 0;

    if(var_0 == 1)
      var_1 = 0.1;
    else if(var_0 == 2)
      var_1 = 0.5;
    else if(var_0 == 3)
      var_1 = 0.8;

    return _func_0A3(1.0) < var_1;
  }
}

_id_19FB(var_0) {
  return _id_1A03(var_0).size;
}

_id_1A03(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_6E97) {
    if(var_3 != self && maps\mp\_utility::_id_5800(var_3) && _func_26C(self, var_3)) {
      if(var_3 istouching(level._id_AC7C._id_9D5E)) {
        if(!_func_0C1(var_3) || var_3 _id_1A2B(var_0))
          var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

_id_1A2B(var_0) {
  if(!maps\mp\bots\_bots_util::_id_1A28())
    return 0;

  return self._id_291F == var_0;
}

_id_1969(var_0) {
  self._id_291F = var_0;
  var_1["entrance_points_index"] = var_0._id_37DA;
  var_1["override_origin_node"] = var_0._id_206D;
  maps\mp\bots\_bots_strategy::_id_196B(var_0.origin, var_0._id_671A, var_0._id_9D5E, var_1);
}

_id_8B7C(var_0) {
  if(var_0) {
    var_1 = level._id_AC7C._id_3FCA _id_04D1::_id_45F7();

    if(var_1 == "neutral" || var_1 == self.team)
      return 0;
  }

  return maps\mp\bots\_bots_strategy::_id_8B7A(var_0);
}