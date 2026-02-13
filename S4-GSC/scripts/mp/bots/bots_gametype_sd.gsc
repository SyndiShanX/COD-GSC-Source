/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_sd.gsc
*************************************************/

main() {
  _id_D795();
  _id_28B0();
}

_id_D795() {
  level._id_279D["crate_can_use"] = ::_id_3E6F;
  level._id_279D["gametype_think"] = ::_id_28B1;
  level._id_279D["should_start_cautious_approach"] = ::_id_DADF;
  level._id_279D["know_enemies_on_start"] = undefined;
  level._id_279D["notify_enemy_bots_bomb_used"] = ::_id_A66E;
}

_id_28B0() {
  _id_D77D();
}

_id_3E6F(var_0) {
  if(isagent(self) && !isDefined(var_0._id_2991)) {
    return 0;
  }

  if(isDefined(var_0.cratetype) && !_id_09F4::_id_2809(var_0.cratetype)) {
    return 0;
  }

  if(!scripts\mp\utility\entity::_id_8A94(self)) {
    return 1;
  }

  if(!isDefined(self._id_C8C5)) {
    return 0;
  }

  switch (self._id_C8C5) {
    case "defuser":
    case "investigate_someone_using_bomb":
    case "atk_bomber":
      return 0;
  }

  return 1;
}

_id_D77D() {
  level._id_2941 = 1;
  level._id_81BD = 3000;
  scripts\mp\bots\bots_gametype_common::_id_28D0();
  scripts\mp\bots\bots_util::_id_291B();
  level._id_28AF = [];
  level._id_28AF["axis"] = [];
  level._id_28AF["allies"] = [];
  level._id_2760["atk_bomber"] = ::_id_1D5A;
  level._id_2760["clear_target_zone"] = ::_id_390B;
  level._id_2760["defend_planted_bomb"] = ::_id_45E1;
  level._id_2760["defuser"] = ::_id_25FE;
  level._id_2760["investigate_someone_using_bomb"] = ::_id_8519;
  level._id_2760["camp_bomb"] = ::_id_30AA;
  level._id_2760["defender"] = ::_id_461B;
  level._id_2760["backstabber"] = ::_id_20B1;
  level._id_2760["random_killer"] = ::_id_BFE9;
  var_0 = scripts\mp\bots\bots_gametype_common::_id_2917(["_a", "_b"]);

  if(var_0) {
    foreach(var_2 in level._id_A8E8) {
      var_2 thread scripts\mp\bots\bots_gametype_common::_id_A0BF();
    }

    thread _id_28AE();
    level._id_27B0 = 1;
  }
}

_id_28B1() {
  self notify("bot_sd_think");
  self endon("bot_sd_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self._id_7522 = undefined;

  while(!isDefined(level._id_27B0)) {
    wait 0.05;
  }

  self _meth_8054("separation", 0);
  self _meth_8054("grenade_objectives", 1);
  self _meth_8054("use_obj_path_style", 1);
  var_0 = game["attackers"];
  var_1 = 1;

  if(isDefined(level._id_CFA2) && isDefined(level._id_CFA2._id_32D5) && level._id_CFA2._id_32D5 == self && isDefined(self._id_C8C5) && self._id_C8C5 == "atk_bomber") {
    var_1 = 0;
  }

  if(var_1) {
    self._id_C8C5 = undefined;

    if(isDefined(level._id_1D58) && level._id_1D58 == self) {
      level._id_1D58 = undefined;
    }
  }

  self._id_EBE1 = undefined;
  self._id_7522 = 0;
  self._id_1D59 = 0;
  self._id_CF50 = undefined;
  self._id_461A = undefined;
  self._id_4641 = 0;

  if(!isDefined(level._id_81B3) && !level._id_A2F7) {
    level._id_81B3 = level._id_CFA2._id_4140;
    level._id_81B4 = _func_0080(level._id_CFA2._id_4140);
  }

  if(self.team == var_0 && !isDefined(level._id_30D8)) {
    var_2 = 0;

    if(!level._id_A2F7) {
      var_3 = scripts\mp\bots\bots_gametype_common::_id_656A(var_0);

      foreach(var_5 in var_3) {
        if(!isai(var_5)) {
          var_2 = 1;
        }
      }
    }

    if(var_2) {
      var_7 = 6000;
      level._id_30D8 = gettime() + var_7;
      _func_0018("bomb", var_7 / 1000, level._id_CFA2._id_4140, 75, 300, var_0);
    }
  }

  for(;;) {
    wait(randomintrange(1, 3) * 0.05);

    if(self.health <= 0) {
      continue;
    }
    self._id_7522 = 1;

    if(!isDefined(self._id_C8C5)) {
      _id_81D8();
    }

    if(isDefined(self._id_EBE1)) {
      continue;
    }
    if(self.team == var_0) {
      if(!level._id_A2F7 && isDefined(level._id_30D8) && gettime() < level._id_30D8 && !isDefined(level._id_CFA2._id_32D5)) {
        if(!scripts\mp\bots\bots_util::_id_2806(level._id_CFA2._id_4140)) {
          var_8 = _func_0080(level._id_CFA2._id_4140);

          if(isDefined(var_8)) {
            var_9["nearest_node_to_center"] = var_8;
            _id_09F9::_id_2899(level._id_CFA2._id_4140, 900, var_9);
          } else
            level._id_30D8 = gettime();
        }
      } else
        self[[level._id_2760[self._id_C8C5]]]();

      continue;
    }

    if(level._id_2663) {
      if(isDefined(level._id_CFA3) && distancesquared(self.origin, level._id_CFA3.origin) > _func_0219(level._id_BDBF * 2)) {
        if(!isDefined(self._id_461A)) {
          self._id_461A = 1;
          self _meth_8055("scripted");
        }
      } else if(isDefined(self._id_461A) && !isDefined(self._id_CF50)) {
        self._id_461A = undefined;
        self _meth_8055(undefined);
      }
    }

    if(level._id_2663 && isDefined(level._id_CFA3) && isDefined(level._id_25FD) && self._id_C8C5 != "defuser") {
      if(!scripts\mp\bots\bots_util::_id_2806(level._id_CFA3.origin)) {
        self _meth_802B();
        _id_09F9::_id_2899(level._id_CFA3.origin, level._id_BDBF);
      }

      continue;
    }

    self[[level._id_2760[self._id_C8C5]]]();
  }
}

_id_263B(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self _meth_8054("disable_movement", 1);
  self _meth_805B("stand");
  wait(var_0);
  self _meth_8054("disable_movement", 0);
  self _meth_805B("none");
}

_id_1D5A() {
  self endon("new_role");

  if(scripts\mp\bots\bots_util::_id_2805()) {
    _id_09F9::_id_2766();
  }

  if(isDefined(level._id_CFA2) && isDefined(level._id_CFA2._id_32D5) && isalive(level._id_CFA2._id_32D5) && level._id_CFA2._id_32D5 != self) {
    wait 0.7;
  }

  if(!self._id_8783 && !level._id_A2F7) {
    if(isDefined(level._id_CFA2)) {
      if(!isDefined(self._id_8F0D)) {
        self._id_8F0D = level._id_CFA2._id_4140;
      }

      if(distancesquared(self._id_8F0D, level._id_CFA2._id_4140) > 4) {
        self _meth_802B();
        self._id_8F0D = level._id_CFA2._id_4140;
      }
    }

    if(self._id_1D59 >= 2) {
      var_1 = _func_00B5(level._id_CFA2._id_4140, 512, 0);
      var_2 = undefined;

      foreach(var_4 in var_1) {
        if(!var_4 _meth_824A()) {
          var_2 = var_4;
          break;
        }
      }

      if(isDefined(var_2)) {
        self _meth_8058(var_2.origin, 20, "critical");
        scripts\mp\bots\bots_util::_id_291C();

        if(isDefined(level._id_CFA2) && !isDefined(level._id_CFA2._id_32D5)) {
          level._id_CFA2 _id_07D6::_id_D650(self);
        }
      } else {}

      return;
    }

    if(!self _meth_8042()) {
      var_6 = 15;
      var_7 = 32;
      var_8 = scripts\mp\bots\bots_util::_id_289B("BotGetClosestNavigablePoint", scripts\mp\bots\bots_util::_id_6019, level._id_CFA2._id_4140, var_6 + var_7, self);

      if(isDefined(var_8)) {
        var_9 = self _meth_8058(level._id_CFA2._id_4140, 0, "critical");

        if(var_9) {
          childthread _id_2640();
          return;
        }
      } else {
        var_1 = _func_00B5(level._id_CFA2._id_4140, 512, 0);

        if(var_1.size > 0) {
          self _meth_8058(var_1[0].origin, 0, "critical");
          scripts\mp\bots\bots_util::_id_291C();
        }

        if(isDefined(level._id_CFA2) && !isDefined(level._id_CFA2._id_32D5)) {
          var_8 = scripts\mp\bots\bots_util::_id_289B("BotGetClosestNavigablePoint", scripts\mp\bots\bots_util::_id_6019, level._id_CFA2._id_4140, var_6 + var_7, self);

          if(!isDefined(var_8)) {
            level._id_CFA2 _id_07D6::_id_D650(self);
          }
        }
      }
    }
  } else {
    if(isDefined(self._id_4D8A) && gettime() < self._id_4D8A) {
      return;
    }
    if(!isDefined(level._id_262C)) {
      level._id_262C = scripts\engine\utility::random(level._id_A8E8);
    }

    var_10 = level._id_262C;
    self._id_2696 = var_10;

    if(!isDefined(level._id_81B5) || gettime() - level._id_81B5 < level._id_81BD) {
      level._id_81B5 = gettime() + level._id_81BD;
      thread _id_263B(level._id_81BD / 1000);
      wait(level._id_81BD / 1000);
    }

    self _meth_802B();

    if(level._id_1DBF == "rush") {
      self _meth_8055("scripted");
      var_11 = scripts\mp\bots\bots_gametype_common::_id_639E(var_10, 1);
      self _meth_8058(var_11.origin, 0, "critical");
    }

    var_12 = scripts\mp\bots\bots_util::_id_291C();

    if(var_12 == "goal") {
      var_13 = _id_6710() - gettime();
      var_14 = var_13 - level._id_B1DA * 2 * 1000;
      var_15 = gettime() + var_14;

      if(var_14 > 0) {
        scripts\mp\bots\bots_util::_id_291D(var_14);
      }

      var_16 = gettime() >= var_15;
      var_17 = scripts\mp\bots\bots_gametype_common::_id_2693(level._id_B1DA + 2, "bomb_planted", var_16);
      self _meth_802B();

      if(var_17) {
        _id_09F9::_id_2782();
        _id_28C9("defend_planted_bomb");
      } else if(var_14 > 5000)
        self._id_4D8A = gettime() + 5000;
    }
  }
}

_id_6710() {
  if(level._id_2663) {
    return level._id_463F;
  } else {
    return gettime() + scripts\mp\gamelogic::_id_6DE8();
  }
}

_id_2640() {
  self notify("bomber_monitor_no_path");
  self endon("death_or_disconnect");
  self endon("goal");
  self endon("bomber_monitor_no_path");
  level._id_CFA2 endon("pickup_object");

  for(;;) {
    self waittill("no_path");
    self._id_1D59++;
  }
}

_id_390B() {
  self endon("new_role");

  if(isDefined(level._id_1D58)) {
    if(level._id_1DBF == "rush") {
      if(!isDefined(self._id_D25D)) {
        if(!level._id_A2F7) {
          var_0["nearest_node_to_center"] = level._id_81B4;
          _id_09F9::_id_2899(level._id_81B3, 900, var_0);
          wait(randomfloatrange(0.0, 4.0));
          _id_09F9::_id_2766();
        }

        self._id_D25D = 1;
      }

      if(self _meth_8030("strategyLevel") > 0) {
        _id_D213();
      }

      if(isai(level._id_1D58) && isDefined(level._id_1D58._id_2696)) {
        var_1 = level._id_1D58._id_2696;
      } else if(isDefined(level._id_262C)) {
        var_1 = level._id_262C;
      } else {
        var_1 = scripts\mp\bots\bots_gametype_common::_id_5ABA(level._id_1D58);
      }

      if(!scripts\mp\bots\bots_util::_id_2806(var_1._id_4140)) {
        var_0["min_goal_time"] = 2;
        var_0["max_goal_time"] = 4;
        var_0["override_origin_node"] = ::scripts\engine\utility::random(var_1._id_2952);
        _id_09F9::_id_2899(var_1._id_4140, level._id_BDBF, var_0);
      }
    }
  }
}

_id_45E1() {
  self endon("new_role");

  if(level._id_2663 && isDefined(level._id_CFA3)) {
    if(level._id_1DBF == "rush") {
      _id_4A02();
    }

    if(!scripts\mp\bots\bots_util::_id_2806(level._id_CFA3.origin)) {
      var_0["score_flags"] = "strongly_avoid_center";
      _id_09F9::_id_2899(level._id_CFA3.origin, level._id_BDBF, var_0);
    }
  }
}

_id_25FE() {
  self endon("new_role");

  if(level._id_2635 || !isDefined(level._id_CFA3)) {
    return;
  }
  var_0 = _id_5AD6();

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = scripts\engine\utility::_id_6369(level._id_CFA3.origin, var_0._id_2952);
  var_2 = (level._id_CFA3.origin[0], level._id_CFA3.origin[1], var_1[0].origin[2]);

  if(self._id_4641 <= 1) {
    var_3 = _id_334B(var_2, undefined);
  } else {
    self _meth_802B();
    var_3 = self _meth_8058(var_2, 20, "critical");
  }

  if(!var_3) {
    return;
  }
  var_4 = scripts\mp\bots\bots_util::_id_291C();

  if(var_4 == "bad_path") {
    self._id_4641++;

    if(self._id_4641 >= 4) {
      for(;;) {
        var_5 = _func_00B5(var_2, 50, 0);
        var_6 = self._id_4641 - 4;

        if(var_5.size <= var_6) {
          var_7 = _func_0020(var_2, 50, self);

          if(isDefined(var_7)) {
            self _meth_8058(var_7, 20, "critical");
          } else {
            break;
          }
        } else
          self _meth_8058(var_5[var_6].origin, 20, "critical");

        var_4 = scripts\mp\bots\bots_util::_id_291C();

        if(var_4 == "bad_path") {
          self._id_4641++;
          continue;
        }

        break;
      }
    }
  }

  if(var_4 == "goal") {
    var_8 = _id_6710() - gettime();
    var_9 = var_8 - level._id_4644 * 2 * 1000;
    var_10 = gettime() + var_9;

    if(var_9 > 0) {
      scripts\mp\bots\bots_util::_id_291D(var_9);
    }

    var_11 = gettime() >= var_10;
    var_12 = level._id_CFA3.origin[2] - self.origin[2];
    var_13 = scripts\mp\bots\bots_gametype_common::_id_2693(level._id_4644 + 2, "bomb_defused", var_11, var_12 > 40);

    if(!var_13 && self._id_4641 >= 4) {
      self._id_4641++;
    }

    self _meth_802B();
    _id_09F9::_id_2782();
  }
}

_id_8519() {
  self endon("new_role");

  if(scripts\mp\bots\bots_util::_id_2805()) {
    _id_09F9::_id_2766();
  }

  var_0 = scripts\mp\bots\bots_gametype_common::_id_5ABA(self);
  self _meth_8059(scripts\engine\utility::random(var_0._id_2952), "critical");
  var_1 = scripts\mp\bots\bots_util::_id_291C();

  if(var_1 == "goal") {
    wait 2;
    _id_28C9(self._id_BC0A);
  }
}

_id_30AA() {
  self endon("new_role");

  if(isDefined(level._id_CFA2._id_32D5)) {
    if(self._id_BC0A == "defender") {
      self._id_4618 = scripts\mp\bots\bots_gametype_common::_id_5ABA(self);
    }

    _id_28C9(self._id_BC0A);
  } else if(!scripts\mp\bots\bots_util::_id_2806(level._id_CFA2._id_4140)) {
    var_0["nearest_node_to_center"] = level._id_CFA2._id_A3F9;
    _id_09F9::_id_2899(level._id_CFA2._id_4140, level._id_BDBF, var_0);
  }
}

_id_461B() {
  self endon("new_role");

  if(!scripts\mp\bots\bots_util::_id_2806(self._id_4618._id_4140)) {
    var_0["score_flags"] = "strict_los";
    var_0["override_origin_node"] = ::scripts\engine\utility::random(self._id_4618._id_2952);
    _id_09F9::_id_2899(self._id_4618._id_4140, level._id_BDBF, var_0);
  }
}

_id_20B1() {
  self endon("new_role");

  if(scripts\mp\bots\bots_util::_id_2805()) {
    _id_09F9::_id_2766();
  }

  if(!isDefined(self._id_20B0)) {
    self._id_20B0 = "1_move_to_midpoint";
  }

  if(self._id_20B0 == "1_move_to_midpoint") {
    var_0 = level._id_A8E8["_a"]._id_4140;
    var_1 = level._id_A8E8["_b"]._id_4140;
    var_2 = ((var_0[0] + var_1[0]) * 0.5, (var_0[1] + var_1[1]) * 0.5, (var_0[2] + var_1[2]) * 0.5);
    var_3 = _func_00B5(var_2, 512, 0);

    if(var_3.size == 0) {
      _id_28C9("random_killer");
      return;
    }

    var_4 = undefined;
    var_5 = int(var_3.size * (var_3.size + 1) * 0.5);
    var_6 = randomint(var_5);

    for(var_7 = 0; var_7 < var_3.size; var_7++) {
      var_8 = var_3.size - var_7;

      if(var_6 < var_8) {
        var_4 = var_3[var_7];
        break;
      }

      var_6 = var_6 - var_8;
    }

    self _meth_8055("scripted");
    var_9 = self _meth_8059(var_4, "guard");

    if(var_9) {
      var_10 = scripts\mp\bots\bots_util::_id_291C();

      if(var_10 == "goal") {
        wait(randomfloatrange(1.0, 4.0));
        self._id_20B0 = "2_move_to_enemy_spawn";
      }
    }
  }

  if(self._id_20B0 == "2_move_to_enemy_spawn") {
    var_11 = _id_0817::_id_6D4E("mp_sd_spawn_attacker");
    var_12 = scripts\engine\utility::random(var_11);
    self _meth_8055("scripted");
    var_9 = self _meth_8058(var_12.origin, 250, "guard");

    if(var_9) {
      var_10 = scripts\mp\bots\bots_util::_id_291C();

      if(var_10 == "goal") {
        self._id_20B0 = "3_move_to_bombzone";
      }
    }
  }

  if(self._id_20B0 == "3_move_to_bombzone") {
    if(!isDefined(self._id_2692)) {
      self._id_2692 = scripts\engine\utility::random(level._id_A8E8);
    }

    self _meth_8055(undefined);
    var_9 = self _meth_8058(scripts\engine\utility::random(self._id_2692._id_2952).origin, 160, "objective");

    if(var_9) {
      var_10 = scripts\mp\bots\bots_util::_id_291C();

      if(var_10 == "goal") {
        self _meth_802B();
        self._id_20B0 = "2_move_to_enemy_spawn";

        foreach(var_14 in level._id_A8E8) {
          if(var_14 != self._id_2692) {
            self._id_2692 = var_14;
            break;
          }
        }
      }
    }
  }
}

_id_BFE9() {
  self endon("new_role");

  if(scripts\mp\bots\bots_util::_id_2805()) {
    _id_09F9::_id_2766();
  }

  self[[self._id_B025]]();
}

_id_D213() {
  if(!isDefined(self._id_1656)) {
    self _meth_8054("force_sprint", 1);
    self._id_1656 = 1;
  }
}

_id_4A02() {
  if(isDefined(self._id_1656)) {
    self _meth_8054("force_sprint", 0);
    self._id_1656 = undefined;
  }
}

_id_D39B() {
  if(!isDefined(self._id_CF50)) {
    self _meth_8055("scripted");
    self._id_CF50 = 1;
  }
}

_id_334B(var_0, var_1) {
  var_2 = level._id_3222;
  var_3["entrance_points_index"] = var_1;
  _id_09F9::_id_2729(var_0, var_2, var_3);
  wait 0.05;

  while(distancesquared(self.origin, var_0) > var_2 * var_2 && scripts\mp\bots\bots_util::_id_2805()) {
    if(_id_6710() - gettime() < 20000) {
      _id_D39B();
      _id_D213();
      break;
    }

    wait 0.05;
  }

  if(scripts\mp\bots\bots_util::_id_2805()) {
    _id_09F9::_id_2766();
  }

  return self _meth_8058(var_0, 20, "critical");
}

_id_A66E(var_0) {
  var_1 = scripts\mp\bots\bots_gametype_common::_id_6310(var_0);

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_C8C5)) {
      var_3 _id_28C9("investigate_someone_using_bomb");
    }
  }
}

_id_DADF(var_0) {
  var_1 = 2000;
  var_2 = var_1 * var_1;

  if(var_0) {
    if(_id_6710() - gettime() < 15000) {
      return 0;
    }

    var_3 = 0;
    var_4 = scripts\engine\utility::_id_647F(self.team);

    foreach(var_6 in level.players) {
      if(!isDefined(var_6.team)) {
        continue;
      }
      if(isalive(var_6) && var_6.team == var_4) {
        var_3 = 1;
      }
    }

    return var_3;
  } else
    return distancesquared(self.origin, self._id_276A) <= var_2 && self _meth_804F();
}

_id_66A2(var_0) {
  var_1 = [];
  var_2 = scripts\mp\bots\bots_gametype_common::_id_656A(game["defenders"]);

  foreach(var_4 in var_2) {
    if(isai(var_4) && isDefined(var_4._id_C8C5) && var_4._id_C8C5 == "defender") {
      if(isDefined(var_4._id_4618) && var_4._id_4618 == var_0) {
        var_1 = scripts\engine\utility::array_add(var_1, var_4);
      }

      continue;
    }

    if(distancesquared(var_4.origin, var_0._id_4140) < level._id_BDBF * level._id_BDBF) {
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
    }
  }

  return var_1;
}

_id_5AD6() {
  if(isDefined(level._id_F1DE)) {
    foreach(var_1 in level._id_A8E8) {
      if(distancesquared(level._id_F1DE.origin, var_1._id_4140) < 90000) {
        return var_1;
      }
    }
  }

  return undefined;
}

_id_6774(var_0) {
  var_0 = "_" + tolower(var_0);
  return level._id_A8E8[var_0];
}

_id_264C() {
  self endon("stopped_being_bomb_carrier");
  self endon("new_role");
  self waittill("death_or_disconnect");
  level._id_1D58 = undefined;
  level._id_8F0A = gettime();

  if(isDefined(self)) {
    self._id_C8C5 = undefined;
  }

  var_0 = scripts\mp\bots\bots_gametype_common::_id_656A(game["attackers"], 1);
  _id_5E43(var_0, undefined);
}

_id_264B() {
  self endon("death_or_disconnect");
  self endon("stopped_being_bomb_carrier");
  level._id_CFA2 endon("pickup_object");
  level._id_CFA2 waittill("reset");

  if(scripts\mp\utility\entity::_id_8744(self)) {
    self _meth_802B();
  }

  _id_28C9("atk_bomber");
}

_id_D29A() {
  level._id_1D58 = self;
  _id_28C9("atk_bomber");
  thread _id_264C();

  if(!level._id_A2F7) {
    thread _id_264B();
  }

  if(isai(self)) {
    _id_09F9::_id_2775();

    if(level._id_1DBF == "rush" && self _meth_8030("strategyLevel") > 0) {
      _id_D213();
    }
  }
}

_id_81D8() {
  if(self.team == game["attackers"]) {
    if(level._id_2663) {
      _id_28C9("defend_planted_bomb");
    } else if(!isDefined(level._id_1D58)) {
      _id_D29A();
    } else if(level._id_1DBF == "rush") {
      _id_28C9("clear_target_zone");
    }
  } else {
    var_0 = _id_66A0("backstabber");
    var_1 = _id_66A0("defender");
    var_2 = level._id_2884[self._id_B023];
    var_3 = self _meth_8030("strategyLevel");

    if(var_2 == "active") {
      if(!isDefined(self._id_C8C5) && level._id_1526 && var_3 > 0) {
        if(var_0.size == 0) {
          _id_28C9("backstabber");
        } else {
          var_4 = 1;

          foreach(var_6 in var_0) {
            var_7 = level._id_2884[var_6._id_B023];

            if(var_7 == "active") {
              var_4 = 0;
              break;
            }
          }

          if(var_4) {
            _id_28C9("backstabber");
            var_0[0] _id_28C9(undefined);
          }
        }
      }

      if(!isDefined(self._id_C8C5)) {
        if(var_1.size < 4) {
          _id_28C9("defender");
        }
      }

      if(!isDefined(self._id_C8C5)) {
        var_9 = randomint(4);

        if(var_9 == 3 && level._id_1571 && var_3 > 0) {
          _id_28C9("random_killer");
        } else if(var_9 == 2 && level._id_1526 && var_3 > 0) {
          _id_28C9("backstabber");
        } else {
          _id_28C9("defender");
        }
      }
    } else if(var_2 == "stationary") {
      if(!isDefined(self._id_C8C5)) {
        if(var_1.size < 4) {
          _id_28C9("defender");
        } else {
          foreach(var_11 in var_1) {
            var_12 = level._id_2884[var_11._id_B023];

            if(var_12 == "active") {
              _id_28C9("defender");
              var_11 _id_28C9(undefined);
              break;
            }
          }
        }
      }

      if(!isDefined(self._id_C8C5) && level._id_1526 && var_3 > 0) {
        if(var_0.size == 0) {
          _id_28C9("backstabber");
        }
      }

      if(!isDefined(self._id_C8C5)) {
        _id_28C9("defender");
      }
    }

    if(self._id_C8C5 == "defender") {
      var_14 = level._id_A8E8;

      if(_id_750A(self.team)) {
        var_14 = _id_6632(self.team);
      }

      if(var_14.size == 1) {
        self._id_4618 = var_14["_a"];
      } else {
        var_15 = _id_66A2(var_14["_a"]);
        var_16 = _id_66A2(var_14["_b"]);

        if(var_15.size < var_16.size) {
          self._id_4618 = var_14["_a"];
        } else if(var_16.size < var_15.size) {
          self._id_4618 = var_14["_b"];
        } else {
          self._id_4618 = scripts\engine\utility::random(var_14);
        }
      }
    }
  }
}

_id_28C9(var_0) {
  if(isai(self)) {
    _id_09F9::_id_2766();
    self _meth_8055(undefined);
  }

  self._id_BC0A = self._id_C8C5;
  self._id_C8C5 = var_0;
  self notify("new_role");
}

_id_28CA(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("new_role");
  wait(var_1);
  _id_28C9(var_0);
}

_id_5E43(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(isDefined(var_2)) {
      var_4 thread _id_28CA(var_1, randomfloatrange(0.0, var_2));
      continue;
    }

    var_4 thread _id_28C9(var_1);
  }
}

_id_6632(var_0) {
  return level._id_28AF[var_0];
}

_id_750A(var_0) {
  var_1 = _id_6632(var_0);
  return var_1.size > 0;
}

_id_66A0(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_AE7C) {
    if(isalive(var_3) && scripts\mp\utility\entity::_id_8A94(var_3) && isDefined(var_3._id_C8C5) && var_3._id_C8C5 == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_28AE() {
  level notify("bot_sd_ai_director_update");
  level endon("bot_sd_ai_director_update");
  level endon("game_ended");
  level._id_1526 = randomint(3) <= 1;
  level._id_1571 = randomint(3) <= 1;
  level._id_1DBF = "rush";
  level._id_BDBF = 725;
  level._id_3222 = 140;

  for(;;) {
    if(isDefined(level._id_CFA2) && isDefined(level._id_CFA2._id_32D5) && !isai(level._id_CFA2._id_32D5)) {
      level._id_262C = scripts\mp\bots\bots_gametype_common::_id_5ABA(level._id_CFA2._id_32D5);
    }

    var_0 = 0;

    if(!level._id_2663) {
      var_1 = scripts\mp\bots\bots_gametype_common::_id_656A(game["attackers"]);

      foreach(var_3 in var_1) {
        if(var_3._id_8783) {
          level._id_30D8 = gettime();

          if(!isDefined(level._id_1D58) || var_3 != level._id_1D58) {
            if(isDefined(level._id_1D58) && isalive(level._id_1D58)) {
              level._id_1D58 _id_28C9(undefined);
              level._id_1D58 notify("stopped_being_bomb_carrier");
            }

            var_0 = 1;
            var_3 _id_D29A();
          }
        }
      }

      if(!level._id_A2F7 && !isDefined(level._id_CFA2._id_32D5)) {
        var_5 = _func_0080(level._id_CFA2._id_4140);

        if(isDefined(var_5)) {
          level._id_CFA2._id_A3F9 = var_5;
          var_6 = 0;
          var_7 = scripts\mp\bots\bots_gametype_common::_id_656A(game["defenders"], 1);

          foreach(var_9 in var_7) {
            var_10 = var_9 _meth_815E();
            var_11 = var_9 _meth_8030("strategyLevel");

            if(var_11 > 0 && var_9._id_C8C5 != "camp_bomb" && isDefined(var_10) && _func_0158(var_5, var_10, 1)) {
              var_12 = var_9 _meth_8032();

              if(scripts\engine\utility::_id_10E76(var_9.origin, var_9 getplayerangles(), level._id_CFA2._id_4140, var_12)) {
                if(var_11 >= 2 || distancesquared(var_9.origin, level._id_CFA2._id_4140) < _func_0219(700)) {
                  var_6 = 1;
                  break;
                }
              }
            }
          }

          if(var_6) {
            foreach(var_9 in var_7) {
              if(var_9._id_C8C5 != "camp_bomb" && var_9 _meth_8030("strategyLevel") > 0) {
                var_9 _id_28C9("camp_bomb");
              }
            }
          }
        }
      }

      var_16 = level._id_A8E8;

      if(_id_750A(game["defenders"])) {
        var_16 = _id_6632(game["defenders"]);
      }

      foreach(var_18 in var_16) {
        foreach(var_20 in var_16) {
          var_21 = _id_66A2(var_18);
          var_22 = _id_66A2(var_20);

          if(var_21.size > var_22.size + 1) {
            var_23 = [];

            foreach(var_3 in var_21) {
              if(isai(var_3)) {
                var_23 = scripts\engine\utility::array_add(var_23, var_3);
              }
            }

            if(var_23.size > 0) {
              var_26 = scripts\engine\utility::random(var_23);
              var_26 _id_09F9::_id_2766();
              var_26._id_4618 = var_20;
            }
          }
        }
      }
    } else {
      if(isDefined(level._id_1D58)) {
        level._id_1D58 = undefined;
      }

      if(!isDefined(level._id_25FD) || !isalive(level._id_25FD)) {
        var_29 = [];
        var_30 = _id_66A0("defender");
        var_31 = _id_66A0("backstabber");
        var_32 = _id_66A0("random_killer");

        if(var_30.size > 0) {
          var_29 = var_30;
        } else if(var_31.size > 0) {
          var_29 = var_31;
        } else if(var_32.size > 0) {
          var_29 = var_32;
        }

        if(var_29.size > 0 && isDefined(level._id_CFA3)) {
          var_33 = scripts\engine\utility::_id_6369(level._id_CFA3.origin, var_29);
          level._id_25FD = var_33[0];
          level._id_25FD _id_28C9("defuser");
          level._id_25FD _id_09F9::_id_2775();
          level._id_25FD thread _id_4642();
        }
      }

      if(!isDefined(level._id_CF9C)) {
        level._id_CF9C = 1;
        var_34 = scripts\mp\bots\bots_gametype_common::_id_656A(game["attackers"]);

        foreach(var_3 in var_34) {
          if(isDefined(var_3._id_C8C5)) {
            if(var_3._id_C8C5 == "atk_bomber") {
              var_3 thread _id_28C9(undefined);
              continue;
            }

            if(var_3._id_C8C5 != "defend_planted_bomb") {
              var_3 thread _id_28CA("defend_planted_bomb", randomfloatrange(0.0, 3.0));
            }
          }
        }
      }
    }

    wait 0.5;
  }
}

_id_4642() {
  self waittill("death_or_disconnect");
  level._id_25FD = undefined;
}