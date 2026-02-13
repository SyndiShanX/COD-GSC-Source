/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_hq.gsc
*************************************************/

main() {
  _id_D795();
  _id_27F3();
}

_id_27F3() {
  _id_D774();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_27F4;
  level._id_279D["should_start_cautious_approach"] = ::_id_DADD;
}

_id_D774() {
  scripts\mp\bots\bots_util::_id_291B();
  var_0 = 0;

  foreach(var_2 in level._id_A8E8) {
    var_2 thread scripts\mp\bots\bots_gametype_common::_id_A0F0();
    var_3 = 0;

    if(istrue(var_2.trigger._id_F5E0)) {
      var_2.trigger scripts\engine\utility::_id_F5E2();
      var_3 = 1;
    }

    var_2._id_A578 = scripts\mp\bots\bots_gametype_common::_id_27D8(var_2.trigger);

    if(var_3) {
      var_2.trigger scripts\engine\utility::_id_F5E0();
    }
  }

  level._id_28CB = 1;

  if(!var_0) {
    var_5 = _id_5ABF();

    if(!isDefined(var_5)) {
      var_5 = scripts\engine\utility::random(level._id_A8E8);
    }

    scripts\mp\bots\bots_gametype_common::_id_2714([var_5]);
    level._id_27B1[var_5.trigger getentitynumber()] = 1;
    level._id_27B0 = 1;
    thread _id_2712(var_5);
  }
}

_id_2712(var_0) {
  for(var_1 = scripts\engine\utility::array_remove(level._id_A8E8, var_0); var_1.size > 0; var_1 = scripts\engine\utility::array_remove(var_1, var_2)) {
    var_2 = undefined;
    var_3 = _id_5ABF();

    if(isDefined(var_3) && scripts\engine\utility::array_contains(var_1, var_3)) {
      var_2 = var_3;
    } else {
      var_2 = scripts\engine\utility::random(var_1);
    }

    scripts\mp\bots\bots_gametype_common::_id_2714([var_2]);
    level._id_27B1[var_2.trigger getentitynumber()] = 1;
  }
}

_id_27F4() {
  self notify("bot_hq_think");
  self endon("bot_hq_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level._id_27B0)) {
    wait 0.05;
  }

  self _meth_8054("separation", 0);
  self _meth_8054("grenade_objectives", 1);

  for(;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }
    var_0 = _id_5ABF();

    if(!isDefined(var_0) || !var_0._id_0026 || !isDefined(level._id_27B1[var_0.trigger getentitynumber()])) {
      _id_2736();
      self[[self._id_B025]]();
      continue;
    }

    var_1 = level._id_110CF _id_07D6::_id_6C02();

    if(self.team != var_1) {
      if(!_id_2803(var_0)) {
        _id_2727(var_0);
      }

      continue;
    }

    var_2 = scripts\engine\utility::_id_647F(self.team);
    var_3 = level._id_110CF._id_F396[var_2].size > 0;

    if(var_3) {
      if(!_id_2803(var_0)) {
        _id_2727(var_0);
      }

      continue;
    }

    if(!_id_280D(var_0)) {
      if(_id_2803(var_0)) {
        wait(randomfloat(2));
        _id_2736();
        continue;
      }

      _id_2898(var_0);
    }
  }
}

_id_5ABF() {
  foreach(var_1 in level._id_A8E8) {
    if(isDefined(level._id_110CF) && var_1.trigger == level._id_110CF.trigger) {
      return var_1;
    }
  }
}

_id_2803(var_0) {
  if(!scripts\mp\bots\bots_util::_id_2801()) {
    return 0;
  }

  return isDefined(self._id_41AD) && self._id_41AD == var_0;
}

_id_280D(var_0) {
  if(!scripts\mp\bots\bots_util::_id_280B()) {
    return 0;
  }

  return isDefined(self._id_41AD) && self._id_41AD == var_0;
}

_id_2727(var_0) {
  self._id_41AD = var_0;
  var_1["entrance_points_index"] = var_0._id_551A;
  var_1["override_origin_node"] = var_0._id_338B;
  _id_09F9::_id_272A(var_0.trigger.origin, var_0._id_A578, var_0.trigger, var_1);
}

_id_2898(var_0) {
  self._id_41AD = var_0;
  var_1 = length(var_0._id_110D0._id_73B7) * 2;
  var_2["override_origin_node"] = var_0._id_338B;
  _id_09F9::_id_2899(var_0._id_338B.origin, var_1, var_2);
}

_id_2736() {
  if(scripts\mp\bots\bots_util::_id_2805()) {
    _id_09F9::_id_2766();
  }

  self._id_41AD = undefined;
}

_id_DADD(var_0) {
  if(var_0) {
    var_1 = level._id_110CF _id_07D6::_id_6C02();

    if(var_1 == "neutral" || var_1 == self.team) {
      return 0;
    }
  }

  return _id_09F9::_id_DADB(var_0);
}