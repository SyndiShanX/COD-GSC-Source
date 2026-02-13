/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_dd.gsc
*************************************************/

main() {
  _id_D795();
  _id_275D();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_275E;
  level._id_279D["notify_enemy_bots_bomb_used"] = ::_id_A66E;
}

_id_275D() {
  _id_D76D();
}

_id_D76D() {
  scripts\mp\bots\bots_gametype_common::_id_28D0();
  scripts\mp\bots\bots_util::_id_291B();
  var_0 = scripts\mp\bots\bots_gametype_common::_id_2917(["_a", "_b"]);

  if(var_0) {
    foreach(var_2 in level._id_A8E8) {
      var_2 thread scripts\mp\bots\bots_gametype_common::_id_A0BF();
    }

    thread _id_275A();
    level._id_27B0 = 1;
  }
}

_id_275E() {
  self notify("bot_dd_think");
  self endon("bot_dd_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level._id_27B0)) {
    wait 0.05;
  }

  self _meth_8054("separation", 0);
  self _meth_8054("grenade_objectives", 1);
  self._id_4154 = undefined;
  self._id_4641 = 0;

  for(;;) {
    wait 0.05;

    if(isDefined(self._id_4154) && !_id_2687(self._id_4154)) {
      self._id_4154 = undefined;
      _id_275B();
    }

    if(scripts\mp\utility\game::_id_82D1()) {
      var_0 = level._id_A8E8["_a"]._id_ADAE != self.team;
    } else {
      var_0 = self.team == game["attackers"];
    }

    if(var_0) {
      _id_2888("attack");

      if(!isDefined(self._id_4154)) {
        continue;
      }
      _id_2909();
      _id_272E();

      if(self._id_C8C5 == "sweep_zone") {
        if(!scripts\mp\bots\bots_util::_id_2806(self._id_4154._id_4140)) {
          var_1["min_goal_time"] = 2;
          var_1["max_goal_time"] = 4;
          var_1["override_origin_node"] = ::scripts\engine\utility::random(self._id_4154._id_2952);
          _id_09F9::_id_2899(self._id_4154._id_4140, level._id_BDBF, var_1);
        }
      } else if(self._id_C8C5 == "defend_zone") {
        if(!scripts\mp\bots\bots_util::_id_2806(level._id_436B[self._id_4154._id_A8E1].origin)) {
          var_1["score_flags"] = "strongly_avoid_center";
          _id_09F9::_id_2899(level._id_436B[self._id_4154._id_A8E1].origin, level._id_BDBF, var_1);
        }
      } else if(self._id_C8C5 == "investigate_someone_using_bomb")
        _id_8518();
      else if(self._id_C8C5 == "atk_bomber") {
        _id_B19B();
      }

      continue;
    }

    _id_2888("defend");

    if(!isDefined(self._id_4154)) {
      continue;
    }
    _id_2730();

    if(self._id_C8C5 == "defend_zone") {
      if(!scripts\mp\bots\bots_util::_id_2806(self._id_4154._id_4140)) {
        var_1["score_flags"] = "strict_los";
        var_1["override_origin_node"] = ::scripts\engine\utility::random(self._id_4154._id_2952);
        _id_09F9::_id_2899(self._id_4154._id_4140, level._id_BDBF, var_1);
      }

      continue;
    }

    if(self._id_C8C5 == "investigate_someone_using_bomb") {
      _id_8518();
      continue;
    }

    if(self._id_C8C5 == "defuser") {
      _id_4639();
    }
  }
}

_id_A66E(var_0) {
  var_1 = scripts\mp\bots\bots_gametype_common::_id_5ABA(self);
  var_2 = scripts\mp\bots\bots_gametype_common::_id_6310(var_0);

  foreach(var_4 in var_2) {
    if(isDefined(var_4._id_4154) && var_1 == var_4._id_4154) {
      var_4 _id_275C("investigate_someone_using_bomb");
    }
  }
}

_id_B19B() {
  self endon("change_role");
  var_0 = scripts\mp\bots\bots_gametype_common::_id_639E(self._id_4154, 0);
  self _meth_8058(var_0.origin, 0, "critical");
  var_1 = scripts\mp\bots\bots_util::_id_291C(undefined, "change_role");

  if(var_1 == "goal") {
    var_2 = scripts\mp\gamelogic::_id_6DE8();
    var_3 = var_2 - level._id_B1DA * 2 * 1000;
    var_4 = gettime() + var_3;

    if(var_3 > 0) {
      scripts\mp\bots\bots_util::_id_291D(var_3);
    }

    var_5 = var_4 > 0 && gettime() >= var_4;
    var_6 = scripts\mp\bots\bots_gametype_common::_id_2693(level._id_B1DA + 2, "bomb_planted", var_5);
    self _meth_802B();

    if(var_6) {
      _id_275B();
    }
  }
}

_id_4639() {
  self endon("change_role");
  self _meth_8055("scripted");
  var_0 = scripts\mp\bots\bots_gametype_common::_id_639D(self._id_4154).origin;
  self _meth_8058(var_0, 20, "critical");
  var_1 = scripts\mp\bots\bots_util::_id_291C(undefined, "change_role");

  if(var_1 == "bad_path") {
    self._id_4641++;

    if(self._id_4641 >= 4) {
      for(;;) {
        var_2 = _func_00B5(var_0, 50, 0);
        var_3 = self._id_4641 - 4;

        if(var_2.size <= var_3) {
          var_4 = _func_0020(var_0, 50, self);

          if(isDefined(var_4)) {
            self _meth_8058(var_4, 20, "critical");
          } else {
            break;
          }
        } else
          self _meth_8058(var_2[var_3].origin, 20, "critical");

        var_1 = scripts\mp\bots\bots_util::_id_291C(undefined, "change_role");

        if(var_1 == "bad_path") {
          self._id_4641++;
          continue;
        }

        break;
      }
    }
  }

  if(var_1 == "goal") {
    var_5 = gettime() - self._id_4154._id_E683;
    var_6 = level._id_2682 * 1000 - var_5;
    var_7 = var_6 - level._id_4644 * 2 * 1000;
    var_8 = gettime() + var_7;

    if(var_7 > 0) {
      scripts\mp\bots\bots_util::_id_291D(var_7);
    }

    var_9 = var_8 > 0 && gettime() >= var_8;
    var_10 = scripts\mp\bots\bots_gametype_common::_id_2693(level._id_4644 + 2, "bomb_defused", var_9);

    if(!var_10 && self._id_4641 >= 4) {
      self._id_4641++;
    }

    self _meth_802B();

    if(var_10) {
      _id_275B();
    }
  }
}

_id_8518() {
  self endon("change_role");

  if(scripts\mp\bots\bots_util::_id_2805()) {
    _id_09F9::_id_2766();
  }

  self _meth_8059(scripts\engine\utility::random(self._id_4154._id_2952), "critical");
  var_0 = scripts\mp\bots\bots_util::_id_291C();

  if(var_0 == "goal") {
    wait 2;
    _id_275B();
  }
}

_id_666C(var_0) {
  var_1 = _id_669F(var_0, self.team);

  foreach(var_3 in var_1) {
    if(!isai(var_3)) {
      if(var_3._id_87F7) {
        return var_3;
      }
    }
  }

  foreach(var_3 in var_1) {
    if(isai(var_3)) {
      if(isDefined(var_3._id_C8C5) && var_3._id_C8C5 == "defuser") {
        return var_3;
      }
    }
  }

  return undefined;
}

_id_6685(var_0) {
  var_1 = _id_669F(var_0, self.team);

  foreach(var_3 in var_1) {
    if(!isai(var_3)) {
      if(var_3._id_8986) {
        return var_3;
      }
    }
  }

  foreach(var_3 in var_1) {
    if(isai(var_3)) {
      if(isDefined(var_3._id_C8C5) && var_3._id_C8C5 == "atk_bomber") {
        return var_3;
      }
    }
  }

  return undefined;
}

_id_2687(var_0) {
  if(var_0._id_1041A == "any") {
    return 1;
  }

  return 0;
}

_id_62F4() {
  var_0 = [];

  foreach(var_2 in level._id_A8E8) {
    if(_id_2687(var_2)) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

_id_669F(var_0, var_1) {
  var_2 = [];
  var_3 = scripts\mp\bots\bots_gametype_common::_id_656A(var_1);

  foreach(var_5 in var_3) {
    if(isai(var_5)) {
      if(isDefined(var_5._id_4154) && var_5._id_4154 == var_0) {
        var_2 = scripts\engine\utility::array_add(var_2, var_5);
      }

      continue;
    }

    if(distancesquared(var_5.origin, var_0._id_4140) < level._id_BDBF * level._id_BDBF) {
      var_2 = scripts\engine\utility::array_add(var_2, var_5);
    }
  }

  return var_2;
}

_id_2886(var_0, var_1) {
  var_2[0] = _id_669F(var_0[0], game["defenders"]).size;
  var_2[1] = _id_669F(var_0[1], game["defenders"]).size;

  if(var_2[0] > var_2[1] + var_1) {
    return var_0[1];
  } else if(var_2[0] + var_1 < var_2[1]) {
    return var_0[0];
  }
}

_id_2888(var_0) {
  var_1 = undefined;

  if(var_0 == "attack") {
    var_1 = _id_272F();
  } else if(var_0 == "defend") {
    var_1 = _id_2731();
  }

  if(isDefined(var_1) && (!isDefined(self._id_4154) || self._id_4154 != var_1)) {
    self._id_4154 = var_1;
    _id_275B();
  }
}

_id_2731() {
  var_0 = _id_62F4();
  var_1 = undefined;

  if(var_0.size == 1) {
    var_1 = var_0[0];
  } else if(var_0.size == 2) {
    var_2[0] = _id_669F(var_0[0], game["defenders"]).size;
    var_2[1] = _id_669F(var_0[1], game["defenders"]).size;
    var_3[0] = _id_8568(var_0[0]);
    var_3[1] = _id_8568(var_0[1]);

    if(var_3[0] && var_3[1] || !var_3[0] && !var_3[1]) {
      var_4 = 0;

      if(isDefined(self._id_4154)) {
        var_4 = 1;
      }

      var_1 = _id_2886(var_0, var_4);

      if(!isDefined(var_1) && !isDefined(self._id_4154)) {
        var_1 = scripts\engine\utility::random(var_0);
      }
    } else if(var_3[0] || var_3[1]) {
      var_5 = scripts\engine\utility::ter_op(var_3[0], 0, 1);
      var_6 = scripts\engine\utility::ter_op(!var_3[0], 0, 1);

      if(var_2[var_5] > var_2[var_6] + 2) {
        var_1 = var_0[var_6];
      } else if(var_2[var_5] <= var_2[var_6]) {
        var_1 = var_0[var_5];
      } else if(!isDefined(self._id_4154)) {
        if(var_2[var_5] >= var_2[var_6] + 2) {
          var_1 = var_0[var_6];
        } else if(var_2[var_5] < var_2[var_6] + 2) {
          var_1 = var_0[var_5];
        }
      }
    }
  }

  return var_1;
}

_id_6621(var_0) {
  var_1 = _id_62F4();

  foreach(var_3 in var_1) {
    if(var_3 != var_0) {
      return var_3;
    }
  }
}

_id_272F() {
  if(isDefined(self._id_4154)) {
    return;
  }
  if(!isDefined(level._id_41AE) || !_id_2687(level._id_41AE) || gettime() > level._id_A485) {
    level._id_A485 = gettime() + 1000 * randomintrange(30, 45);
    level._id_41AE = scripts\engine\utility::random(_id_62F4());
  }

  if(!isDefined(level._id_41AE)) {
    return;
  }
  var_0 = level._id_41AE;
  var_1 = _id_6621(var_0);
  self._id_4154 = undefined;

  if(isDefined(var_1)) {
    if(randomfloat(1.0) < 0.25) {
      return var_1;
    }
  }

  return var_0;
}

_id_2909() {
  var_0 = _id_6621(self._id_4154);

  if(isDefined(var_0)) {
    var_1 = distance(self.origin, self._id_4154._id_4140);
    var_2 = distance(self.origin, var_0._id_4140);

    if(var_2 < var_1 * 0.6) {
      self._id_4154 = var_0;
    }
  }
}

_id_272E() {
  if(isDefined(self._id_C8C5)) {
    if(self._id_C8C5 == "investigate_someone_using_bomb") {
      return;
    }
  }

  var_0 = undefined;

  if(_id_8568(self._id_4154)) {
    var_0 = "defend_zone";
  } else {
    var_1 = _id_6685(self._id_4154);

    if(!isDefined(var_1) || var_1 == self) {
      var_0 = "atk_bomber";
    } else if(isai(var_1)) {
      var_2 = distance(self.origin, self._id_4154._id_4140);
      var_3 = distance(var_1.origin, self._id_4154._id_4140);

      if(var_2 < var_3 * 0.9) {
        var_0 = "atk_bomber";
        var_1 _id_275B();
      }
    }
  }

  if(!isDefined(var_0)) {
    var_0 = "sweep_zone";
  }

  _id_275C(var_0);
}

_id_2730() {
  if(isDefined(self._id_C8C5)) {
    if(self._id_C8C5 == "investigate_someone_using_bomb") {
      return;
    }
  }

  var_0 = undefined;

  if(_id_8568(self._id_4154)) {
    var_1 = _id_666C(self._id_4154);

    if(!isDefined(var_1) || var_1 == self) {
      var_0 = "defuser";
    } else if(isai(var_1)) {
      var_2 = distance(self.origin, self._id_4154._id_4140);
      var_3 = distance(var_1.origin, self._id_4154._id_4140);

      if(var_2 < var_3 * 0.9) {
        var_0 = "defuser";
        var_1 _id_275B();
      }
    }
  }

  if(!isDefined(var_0)) {
    var_0 = "defend_zone";
  }

  _id_275C(var_0);
}

_id_275C(var_0) {
  if(!isDefined(self._id_C8C5) || self._id_C8C5 != var_0) {
    _id_275B();
    self._id_C8C5 = var_0;
  }
}

_id_275B() {
  self._id_C8C5 = undefined;
  self _meth_802B();
  self _meth_8055(undefined);
  _id_09F9::_id_2766();
  self notify("change_role");
  self._id_4641 = 0;
}

_id_275A() {
  level notify("bot_dd_ai_director_update");
  level endon("bot_dd_ai_director_update");
  level endon("game_ended");
  level._id_BDBF = 725;

  for(;;) {
    foreach(var_1 in level._id_A8E8) {
      foreach(var_3 in level.players) {
        if(isDefined(var_3._id_C8C5) && isDefined(var_3._id_4154) && var_3._id_4154 == var_1) {
          if(!_id_2687(var_1)) {
            if(var_3._id_C8C5 == "atk_bomber" || var_3._id_C8C5 == "defuser") {
              var_3 _id_275B();
            }

            continue;
          }

          if(_id_8568(var_1)) {
            if(var_3._id_C8C5 == "atk_bomber") {
              var_3 _id_275B();
            }
          }
        }
      }
    }

    wait 0.5;
  }
}

_id_8568(var_0) {
  return istrue(var_0._id_2663);
}