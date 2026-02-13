/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2553.gsc
*************************************************/

_id_2763() {
  var_0 = _id_2762(self._id_412E);

  if(isDefined(var_0) && var_0.size > 0) {
    return scripts\engine\utility::random(var_0).origin;
  }

  return undefined;
}

_id_2762(var_0, var_1) {
  if(isDefined(self._id_45DB)) {
    return scripts\mp\bots\bots_util::_id_27BD(var_0, self._id_45DB, var_1);
  }

  return [];
}

_id_27B6(var_0, var_1, var_2) {
  if(self _meth_8030("allowGrenades") == 0) {
    return undefined;
  }

  var_3 = [];
  var_3[var_3.size] = var_0;

  if(isDefined(var_1)) {
    var_3[var_3.size] = var_1;
  }

  if(isDefined(var_1)) {
    var_3[var_3.size] = var_2;
  }

  if(var_3.size == 0) {
    return undefined;
  }

  var_4 = self getweaponslistall();
  var_5 = [];

  foreach(var_7 in var_4) {
    if(self getweaponammoclip(var_7) > 0 || self getweaponammostock(var_7) > 0) {
      var_5[var_5.size] = var_7;
    }
  }

  if(var_5.size <= 0) {
    return undefined;
  }

  foreach(var_10 in var_3) {
    foreach(var_7 in var_5) {
      if(scripts\mp\bots\bots_util::_id_2812(var_10, var_7)) {
        var_12["purpose"] = var_10;
        var_13 = self _meth_802D("lethal");

        if(isDefined(var_13) && var_7 == var_13) {
          var_12["item_action"] = "lethal";
        }

        var_14 = self _meth_802D("tactical");

        if(isDefined(var_14) && var_7 == var_14) {
          var_12["item_action"] = "tactical";
        }

        var_12["weap_name"] = var_7;
        return var_12;
      }
    }
  }
}

_id_28C1(var_0, var_1, var_2, var_3, var_4) {
  self notify("bot_set_ambush_trap");
  self endon("bot_set_ambush_trap");

  if(!isDefined(var_0)) {
    return 0;
  }

  var_5 = undefined;

  if(!isDefined(var_4) && isDefined(var_1) && var_1.size > 0) {
    if(!isDefined(var_2)) {
      return 0;
    }

    var_6 = [];
    var_7 = undefined;

    if(isDefined(var_3)) {
      var_7 = anglesToForward((0, var_3, 0));
    }

    foreach(var_9 in var_1) {
      if(!isDefined(var_7)) {
        var_6[var_6.size] = var_9;
        continue;
      }

      if(distancesquared(var_9.origin, var_2.origin) > 90000) {
        if(vectordot(var_7, vectornormalize(var_9.origin - var_2.origin)) < 0.4) {
          var_6[var_6.size] = var_9;
        }
      }
    }

    if(var_6.size > 0) {
      var_5 = scripts\engine\utility::random(var_6);
      var_11 = _func_00B4(var_5.origin, 300, 50);
      var_12 = [];

      foreach(var_14 in var_11) {
        if(!isDefined(var_14._id_26FE)) {
          var_12[var_12.size] = var_14;
        }
      }

      var_11 = var_12;
      var_4 = self _meth_8049(var_11, min(var_11.size, 3), "node_trap", var_2, var_5);
    }
  }

  if(isDefined(var_4)) {
    var_16 = undefined;

    if(var_0["purpose"] == "trap_directional" && isDefined(var_5)) {
      var_17 = vectortoangles(var_5.origin - var_4.origin);
      var_16 = var_17[1];
    }

    if(self _meth_8042() && self _meth_803E() != "critical" && self _meth_803E() != "tactical") {
      self _meth_802B();
    }

    var_18 = self _meth_8059(var_4, "guard", var_16);

    if(var_18) {
      var_19 = scripts\mp\bots\bots_util::_id_291C();

      if(var_19 == "goal") {
        thread scripts\mp\bots\bots_util::_id_279B("stand", 4.0);

        if(!isDefined(self._id_0192) || !self _meth_8028(self._id_0192)) {
          thread scripts\mp\bots\bots_util::_id_2774(4.0);
          var_20 = (0, 0, 0);

          if(issubstr(var_0["weap_name"].basename, "claymore")) {
            var_20 = (0, 0, 55);
          }

          if(isDefined(var_16)) {
            self _meth_8045(var_5.origin + var_20, 3.0, "script_forced");
          } else {
            self _meth_8045(self.origin + var_20 + anglesToForward(self getplayerangles()) * 50, 3.0, "script_forced");
          }

          if(!isDefined(var_0["item_action"])) {
            var_0 = _id_27B6("trap_directional", "trap");
          }

          if(isDefined(var_0) && isDefined(var_0["item_action"])) {
            _id_290B(var_0["item_action"]);
          }

          self._id_16BD = undefined;
          thread _id_28C2("grenade_fire");
          thread _id_28C2("missile_fire");

          if(!isDefined(var_0)) {
            return 0;
          }

          var_21 = scripts\engine\utility::ter_op(isDefined(var_0["purpose"]) && var_0["purpose"] == "tacticalinsertion", 6.0, 3.0);
          scripts\engine\utility::_id_108A8(var_21, "missile_fire", "grenade_fire");
          wait 0.05;
          self notify("ambush_trap_ent");

          if(isDefined(self._id_16BD) && isDefined(var_0["purpose"]) && var_0["purpose"] == "c4") {
            thread _id_2923(self._id_16BD, 300);
          }

          self._id_16BD = undefined;
          wait(randomfloat(0.25));
          self notify("bot_force_stance_for_time");
          self _meth_805B("none");
          self switchtoweapon("none");
          self notify("bot_disable_movement_for_time");
          self _meth_8054("disable_movement", 0);
          self _meth_8045(undefined);
        }
      }

      return 1;
    }
  }

  return 0;
}

_id_290B(var_0) {
  self endon("grenade_pullback");

  for(;;) {
    self _meth_804E(var_0);
    wait 0.5;
  }
}

_id_28C2(var_0) {
  self endon("death_or_disconnect");
  self endon("bot_set_ambush_trap");
  self endon("ambush_trap_ent");
  level endon("game_ended");
  self waittill(var_0, var_1);
  self._id_16BD = var_1;
}

_id_2923(var_0, var_1) {
  self endon("death_or_disconnect");
  var_0 endon("death");
  level endon("game_ended");
  var_2 = var_1 * var_1;

  for(;;) {
    if(distancesquared(self.origin, var_0.origin) > var_2) {
      var_3 = self _meth_8120(var_0.origin, 1.0);

      if(var_3 < var_2) {
        self _meth_804E("use", 0.25);
        wait 0.5;
        self _meth_804E("use", 0.25);
        return;
      }
    }

    wait(randomfloatrange(0.25, 1.0));
  }
}

_id_2729(var_0, var_1, var_2) {
  thread _id_2767(var_0, var_1, "capture", var_2);
}

_id_272A(var_0, var_1, var_2, var_3) {
  var_3["capture_trigger"] = var_2;
  thread _id_2767(var_0, var_1, "capture_zone", var_3);
}

_id_2899(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !isDefined(var_2["min_goal_time"])) {
    var_2["min_goal_time"] = 12;
  }

  if(!isDefined(var_2) || !isDefined(var_2["max_goal_time"])) {
    var_2["max_goal_time"] = 18;
  }

  thread _id_2767(var_0, var_1, "protect", var_2);
}

_id_289A(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3) || !isDefined(var_3["min_goal_time"])) {
    var_3["min_goal_time"] = 12;
  }

  if(!isDefined(var_3) || !isDefined(var_3["max_goal_time"])) {
    var_3["max_goal_time"] = 18;
  }

  if(!isDefined(var_3) || !isDefined(var_3["random_stance"])) {
    var_3["random_stance"] = 1;
  }

  var_3["uniqueID"] = var_2;
  thread _id_2767(var_1, var_0, "protect_zone", var_3);
}

_id_287A(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !isDefined(var_2["min_goal_time"])) {
    var_2["min_goal_time"] = 0.0;
  }

  if(!isDefined(var_2) || !isDefined(var_2["max_goal_time"])) {
    var_2["max_goal_time"] = 0.01;
  }

  thread _id_2767(var_0, var_1, "patrol", var_2);
}

_id_27E3(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !isDefined(var_2["min_goal_time"])) {
    var_2["min_goal_time"] = 15;
  }

  if(!isDefined(var_2) || !isDefined(var_2["max_goal_time"])) {
    var_2["max_goal_time"] = 20;
  }

  thread _id_2767(var_0, var_1, "bodyguard", var_2);
}

_id_2765(var_0) {
  if(var_0 == "protect_zone") {
    return 0;
  }

  return 1;
}

_id_2767(var_0, var_1, var_2, var_3) {
  self notify("started_bot_defend_think");
  self endon("started_bot_defend_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("defend_stop");
  thread _id_4622();

  if(isDefined(self._id_2769) || self _meth_803E() == "camp") {
    self _meth_802B();
  }

  self._id_2769 = 1;
  self._id_276F = var_2;

  if(var_2 == "capture_zone") {
    self._id_276D = undefined;
    self._id_276B = var_1;
    self._id_276E = var_3["capture_trigger"];
  } else if(var_2 == "protect_zone") {
    self._id_276D = undefined;
    self._id_276B = var_1;
    self._id_2770 = var_3["uniqueID"];
  } else {
    self._id_276D = var_1;
    self._id_276B = undefined;
    self._id_276E = undefined;
  }

  if(scripts\mp\utility\entity::_id_8877(var_0)) {
    self._id_2764 = var_0;
    childthread _id_A0C6();
  } else {
    self._id_2764 = undefined;
    self._id_276A = var_0;
  }

  self _meth_805B("none");
  var_4 = undefined;
  var_5 = 6;
  var_6 = 10;
  self._id_4628 = [];

  if(isDefined(var_3)) {
    self._id_45DB = var_3["entrance_points_index"];
    self._id_276C = var_3["override_origin_node"];

    if(isDefined(var_3["score_flags"])) {
      if(_func_0107(var_3["score_flags"])) {
        self._id_4628 = var_3["score_flags"];
      } else {
        self._id_4628[0] = var_3["score_flags"];
      }
    }

    if(isDefined(var_3["override_goal_type"])) {
      var_4 = var_3["override_goal_type"];
    }

    if(isDefined(var_3["min_goal_time"])) {
      var_5 = var_3["min_goal_time"];
    }

    if(isDefined(var_3["max_goal_time"])) {
      var_6 = var_3["max_goal_time"];
    }

    if(isDefined(var_3["override_watch_nodes"]) && var_3["override_watch_nodes"].size > 0) {
      self._id_4627 = var_3["override_watch_nodes"];
    }

    self._id_45E0 = var_3["objective_radius"];
  }

  if(!isDefined(self._id_2764) && _id_2765(var_2)) {
    var_7 = undefined;

    if(isDefined(var_3) && isDefined(var_3["nearest_node_to_center"])) {
      var_7 = var_3["nearest_node_to_center"];
    }

    if(!isDefined(var_7) && isDefined(self._id_276C)) {
      var_7 = self._id_276C;
    }

    if(!isDefined(var_7) && isDefined(self._id_276E) && isDefined(self._id_276E._id_A3F8)) {
      var_7 = self._id_276E._id_A3F8;
    }

    if(!isDefined(var_7)) {
      var_7 = _func_0080(scripts\mp\bots\bots_util::_id_45E3());
    }

    if(!isDefined(var_7)) {
      var_8 = scripts\mp\bots\bots_util::_id_45E3();
      var_9 = _func_00B5(var_8, 256, 0);

      for(var_10 = 0; var_10 < var_9.size; var_10++) {
        var_11 = vectornormalize(var_9[var_10].origin - var_8);
        var_12 = var_8 + var_11 * 15;

        if(_func_0202(var_12, var_9[var_10].origin, 0, undefined)) {
          var_7 = var_9[var_10];
          break;
        }

        wait 0.05;

        if(_func_0202(var_12 + (0, 0, 55), var_9[var_10].origin + (0, 0, 55), 0, undefined)) {
          var_7 = var_9[var_10];
          break;
        }

        wait 0.05;
      }
    }

    self._id_A550 = var_7;
  } else if(isDefined(var_3) && isDefined(var_3["nearest_node_to_center"]))
    self._id_A550 = var_3["nearest_node_to_center"];

  var_13 = level._id_278F[var_2];

  if(!isDefined(var_4)) {
    var_4 = "guard";

    if(var_2 == "capture" || var_2 == "capture_zone") {
      var_4 = "objective";
    }
  }

  var_14 = 0;
  var_15 = 0;

  if(scripts\mp\bots\bots_util::_id_2801()) {
    var_14 = 1;
    var_15 = isDefined(var_3) && isDefined(var_3["entrance_points_index"]) && _func_0107(var_3["entrance_points_index"]);
  } else if(isDefined(var_3) && istrue(var_3["random_stance"])) {
    var_14 = 1;
    var_15 = 1;
  }

  var_16 = 1;

  if(isDefined(var_3) && istrue(var_3["dont_leave_goal_during_combat"])) {
    var_16 = 0;
  }

  if(var_2 == "protect") {
    childthread _id_BDC0();
  }

  for(;;) {
    self._id_BC06 = self._id_412C;
    self._id_412C = undefined;
    self._id_412B = undefined;
    self._id_412D = undefined;
    self._id_412E = _id_2ECF(var_14, var_15);
    var_17 = self _meth_803E();
    var_18 = scripts\mp\bots\bots_util::_id_27DD(var_4, var_17);

    if(!var_18) {
      wait 0.25;
      continue;
    }

    var_19 = var_5;
    var_20 = var_6;
    var_21 = 1;

    if(isDefined(self._id_4625)) {
      self._id_412D = self._id_4625;
      self._id_4625 = undefined;
      var_21 = 0;
      var_19 = 1.0;
      var_20 = 2.0;
    } else if(isDefined(self._id_4623)) {
      self._id_412C = self._id_4623;
      self._id_4623 = undefined;
    } else {
      if(isDefined(level._id_11DE) && level._id_11DE[self.team]) {
        if(!scripts\engine\utility::array_contains(self._id_4628, "avoid_aerial_enemies")) {
          self._id_4628[self._id_4628.size] = "avoid_aerial_enemies";
        }
      }

      self[[var_13]]();
    }

    self _meth_802B();
    var_22 = "";

    if(isDefined(self._id_412C) || isDefined(self._id_412D)) {
      if(var_21 && scripts\mp\bots\bots_util::_id_280B() && !isPlayer(var_0) && isDefined(self._id_45DB)) {
        var_23 = _id_27B6("trap_directional", "trap", "c4");

        if(isDefined(var_23)) {
          var_24 = scripts\mp\bots\bots_util::_id_27BD(undefined, self._id_45DB);
          _id_28C1(var_23, var_24, self._id_A550);
        }
      }

      if(isDefined(self._id_412D)) {
        var_25 = undefined;

        if(isDefined(self._id_412B)) {
          var_25 = self._id_412B[1];
        }

        self _meth_8058(self._id_412D, 0, var_4, var_25, self._id_45E0);
      } else if(!isDefined(self._id_412B))
        self _meth_8059(self._id_412C, var_4, undefined, self._id_45E0);
      else {
        self _meth_8059(self._id_412C, var_4, self._id_412B[1], self._id_45E0);
      }

      if(var_14) {
        if(!isDefined(self._id_BC06) || !isDefined(self._id_412C) || self._id_BC06 != self._id_412C) {
          self _meth_805B("none");
        }
      }

      var_26 = self _meth_803B();
      self notify("new_defend_goal");
      scripts\mp\bots\bots_util::_id_10A79();

      if(var_4 == "objective") {
        _id_4621();
        self _meth_8051(1.0);
        self _meth_8054("cautious", 0);
      }

      if(self _meth_8042()) {
        var_27 = self _meth_803B();

        if(scripts\mp\bots\bots_util::_id_2916(var_27, var_26)) {
          var_22 = scripts\mp\bots\bots_util::_id_291C(20, "defend_force_node_recalculation");
        }
      }

      if(var_22 == "goal") {
        if(var_14) {
          self _meth_805B(self._id_412E);
        }

        childthread _id_462A();

        if(var_21 && scripts\mp\bots\bots_util::_id_280B() && !isPlayer(var_0) && isDefined(self._id_45DB)) {
          _id_09F7::_id_290A();
        }
      }
    }

    if(var_22 != "goal") {
      var_28 = 0.25;

      if(var_22 == "no_path" && isDefined(self._id_45E4)) {
        var_28 = self._id_45E4;
      }

      wait(var_28);
      continue;
    }

    var_29 = randomfloatrange(var_19, var_20);
    var_22 = scripts\engine\utility::_id_108AB(var_29, "node_relinquished", "goal_changed", "script_goal_changed", "defend_force_node_recalculation", "bad_path");

    if((var_22 == "node_relinquished" || var_22 == "bad_path" || var_22 == "goal_changed" || var_22 == "script_goal_changed") && (self._id_412E == "crouch" || self._id_412E == "prone")) {
      self _meth_805B("none");
    }

    if(var_22 == "timeout" && !var_16) {
      scripts\mp\bots\bots_util::_id_291D();
    }
  }
}

_id_2ECF(var_0, var_1) {
  var_2 = "stand";

  if(var_0) {
    var_3 = 100;
    var_4 = 0;
    var_5 = 0;
    var_6 = self _meth_8030("strategyLevel");

    if(var_6 == 1) {
      var_3 = 20;
      var_4 = 25;
      var_5 = 55;
    } else if(var_6 >= 2) {
      var_3 = 10;
      var_4 = 20;
      var_5 = 70;
    }

    var_7 = randomint(100);

    if(var_7 < var_4) {
      var_2 = "crouch";
    } else if(var_7 < var_4 + var_5) {
      var_2 = "prone";
    }

    var_8 = !isDefined(var_1) || !var_1;

    if(var_8 && var_2 == "prone") {
      var_9 = _id_2762("prone");
      var_10 = _id_45DD("prone");

      if(var_10.size >= var_9.size) {
        var_2 = "crouch";
      }
    }

    if(var_8 && var_2 == "crouch") {
      var_11 = _id_2762("crouch");
      var_12 = _id_45DD("crouch");

      if(var_12.size >= var_11.size) {
        var_2 = "stand";
      }
    }
  }

  return var_2;
}

_id_DADB(var_0) {
  var_1 = 1250;
  var_2 = var_1 * var_1;

  if(var_0) {
    if(self _meth_8030("strategyLevel") == 0) {
      return 0;
    }

    if(self._id_276F == "capture_zone" && isDefined(self._id_276E) && self istouching(self._id_276E)) {
      return 0;
    }

    return distancesquared(self.origin, self._id_276A) > var_2 * 0.75 * 0.75;
  } else if(self _meth_804F() && distancesquared(self.origin, self._id_276A) < var_2) {
    var_3 = self _meth_8039();
    return 0 <= var_3 && var_3 <= var_1;
  } else
    return 0;
}

_id_D7D6(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_1)) {
    var_2.origin = var_1;
  } else {
    var_2.origin = var_0.origin;
  }

  var_2._id_02ED = var_0;
  var_2._id_5F3B = 0;
  return var_2;
}

_id_4621() {
  self notify("defense_cautious_approach");
  self endon("defense_cautious_approach");
  level endon("game_ended");
  self endon("defend_force_node_recalculation");
  self endon("death_or_disconnect");
  self endon("defend_stop");
  self endon("started_bot_defend_think");

  if(![[level._id_279D["should_start_cautious_approach"]]](1)) {
    return;
  }
  var_0 = self _meth_803B();
  var_1 = self _meth_803C();
  var_2 = 1;
  var_3 = 0.2;
  var_4 = 0;

  while(var_2) {
    wait 0.25;
    var_4 = var_4 + 0.25;

    if(!self _meth_8042()) {
      return;
    }
    var_5 = self _meth_803B();

    if(!scripts\mp\bots\bots_util::_id_2916(var_0, var_5)) {
      return;
    }
    if(var_4 >= 1.0) {
      var_6 = self _meth_8037();

      if(var_6.size == 0) {
        self _meth_802B();
        return;
      }
    }

    var_3 = var_3 + 0.25;

    if(var_3 >= 0.5) {
      var_3 = 0.0;

      if([[level._id_279D["should_start_cautious_approach"]]](0)) {
        var_2 = 0;
      }
    }
  }

  self _meth_8051(1.8);
  self _meth_8054("cautious", 1);
  var_7 = self _meth_8037();

  if(!isDefined(var_7) || var_7.size <= 2) {
    return;
  }
  self._id_96DF = [];
  var_8 = 1000;

  if(isDefined(level._id_BDBF)) {
    var_8 = level._id_BDBF;
  }

  var_9 = var_8 * var_8;
  var_10 = _func_00B4(self._id_276A, var_8, 0, 500);

  if(var_10.size <= 0) {
    return;
  }
  var_11 = 5 + self _meth_8030("strategyLevel") * 2;
  var_12 = int(min(var_11, var_10.size));
  var_13 = self _meth_804A(var_10, 15, var_12, "node_protect", scripts\mp\bots\bots_util::_id_45E3(), "ignore_occupancy");

  for(var_14 = 0; var_14 < var_13.size; var_14++) {
    var_15 = _id_D7D6(var_13[var_14]);
    self._id_96DF = scripts\engine\utility::array_add(self._id_96DF, var_15);
  }

  var_16 = _func_0021(0, gettime() - 60000, 1, "death", 0, self);

  foreach(var_18 in var_16) {
    if(distancesquared(var_18, self._id_276A) < var_9) {
      var_19 = _func_0080(var_18);

      if(isDefined(var_19)) {
        var_15 = _id_D7D6(var_19, var_18);
        self._id_96DF = scripts\engine\utility::array_add(self._id_96DF, var_15);
      }
    }
  }

  if(isDefined(self._id_45DB)) {
    var_21 = scripts\mp\bots\bots_util::_id_27BD("stand", self._id_45DB);

    for(var_14 = 0; var_14 < var_21.size; var_14++) {
      var_15 = _id_D7D6(var_21[var_14]);
      self._id_96DF = scripts\engine\utility::array_add(self._id_96DF, var_15);
    }
  }

  if(self._id_96DF.size == 0) {
    return;
  }
  childthread _id_A0C2();
  var_22 = self _meth_803E();
  var_23 = self _meth_803D();
  var_24 = self _meth_803F();
  wait 0.05;

  for(var_25 = 1; var_25 < var_7.size - 2; var_25++) {
    scripts\mp\bots\bots_util::_id_291D();
    var_26 = _func_00A6(var_7[var_25]);

    if(var_26.size == 0) {
      continue;
    }
    var_27 = [];

    for(var_14 = 0; var_14 < var_26.size; var_14++) {
      if(!scripts\engine\utility::_id_10E76(self.origin, self getplayerangles(), var_26[var_14].origin, 0)) {
        continue;
      }
      for(var_28 = 0; var_28 < self._id_96DF.size; var_28++) {
        var_18 = self._id_96DF[var_28];

        if(_func_0158(var_18._id_02ED, var_26[var_14], 1)) {
          var_27 = scripts\engine\utility::array_add(var_27, var_26[var_14]);
          var_28 = self._id_96DF.size;
        }
      }
    }

    if(var_27.size == 0) {
      continue;
    }
    var_29 = self _meth_8049(var_27, 1 + var_27.size * 0.15, "node_hide");

    if(isDefined(var_29)) {
      var_30 = [];

      for(var_14 = 0; var_14 < self._id_96DF.size; var_14++) {
        if(_func_0158(self._id_96DF[var_14]._id_02ED, var_29, 1)) {
          if(distance2dsquared(self._id_96DF[var_14].origin, var_29.origin) > 3600) {
            var_30 = scripts\engine\utility::array_add(var_30, self._id_96DF[var_14]);
          }
        }
      }

      self _meth_802B();
      self _meth_8059(var_29, "critical");
      childthread _id_A0C3();
      var_31 = scripts\mp\bots\bots_util::_id_291C(undefined, "cautious_approach_early_out");
      self notify("stop_cautious_approach_early_out_monitor");

      if(var_31 == "cautious_approach_early_out") {
        break;
      }

      if(var_31 == "goal") {
        for(var_14 = 0; var_14 < var_30.size; var_14++) {
          if(distance2dsquared(self.origin, var_30[var_14].origin) < 1600) {
            continue;
          }
          for(var_4 = 0; var_30[var_14]._id_5F3B < 18 && var_4 < 3.6; var_4 = var_4 + 0.25) {
            self _meth_8045(var_30[var_14].origin + (0, 0, self _meth_8172()), 0.25, "script_search");
            wait 0.25;
          }
        }
      }
    }

    wait 0.05;
  }

  self notify("stop_location_monitoring");
  self _meth_802B();

  if(isDefined(var_1)) {
    self _meth_8059(var_1, var_22, var_24);
  } else {
    self _meth_8058(self._id_412D, var_23, var_22, var_24);
  }
}

_id_A0C3() {
  self endon("cautious_approach_early_out");
  self endon("stop_cautious_approach_early_out_monitor");
  var_0 = undefined;

  if(isDefined(self._id_276D)) {
    var_0 = self._id_276D * self._id_276D;
  } else if(isDefined(self._id_276B)) {
    var_1 = _id_272B();
    var_0 = var_1 * var_1;
  }

  wait 0.05;

  for(;;) {
    if(distancesquared(self.origin, self._id_276A) < var_0) {
      self notify("cautious_approach_early_out");
    }

    wait 0.05;
  }
}

_id_A0C2() {
  self endon("stop_location_monitoring");
  var_0 = 10000;

  for(;;) {
    var_1 = self _meth_815E();

    if(isDefined(var_1)) {
      var_2 = self _meth_8032();

      for(var_3 = 0; var_3 < self._id_96DF.size; var_3++) {
        if(_func_0158(var_1, self._id_96DF[var_3]._id_02ED, 1)) {
          var_4 = scripts\engine\utility::_id_10E76(self.origin, self getplayerangles(), self._id_96DF[var_3].origin, var_2);
          var_5 = !var_4 || self._id_96DF[var_3]._id_5F3B < 17;

          if(var_5 && distancesquared(self.origin, self._id_96DF[var_3].origin) < var_0) {
            var_4 = 1;
            self._id_96DF[var_3]._id_5F3B = 18;
          }

          if(var_4) {
            self._id_96DF[var_3]._id_5F3B++;

            if(self._id_96DF[var_3]._id_5F3B >= 18) {
              self._id_96DF[var_3] = self._id_96DF[self._id_96DF.size - 1];
              self._id_96DF[self._id_96DF.size - 1] = undefined;
              var_3--;
            }
          }
        }
      }
    }

    wait 0.05;
  }
}

_id_BDC0() {
  self notify("protect_watch_allies");
  self endon("protect_watch_allies");
  var_0 = [];
  var_1 = 1050;
  var_2 = var_1 * var_1;
  var_3 = 900;

  if(isDefined(level._id_BDBF)) {
    var_3 = level._id_BDBF;
  }

  for(;;) {
    var_4 = gettime();
    var_5 = _id_27D6(self._id_276A, var_3);

    foreach(var_7 in var_5) {
      var_8 = var_7._id_5501;

      if(!isDefined(var_8)) {
        var_8 = var_7 getentitynumber();
      }

      if(!isDefined(var_0[var_8])) {
        var_0[var_8] = var_4 - 1;
      }

      if(!isDefined(var_7._id_8F33)) {
        var_7._id_8F33 = var_4 - 10001;
      }

      if(var_7.health == 0 && isDefined(var_7._id_441F) && var_4 - var_7._id_441F < 5000) {
        if(var_4 - var_7._id_8F33 > 10000 && var_4 > var_0[var_8]) {
          if(isDefined(var_7._id_026E) && isDefined(var_7._id_026E.team) && var_7._id_026E.team == scripts\engine\utility::_id_647F(self.team)) {
            if(distancesquared(var_7._id_25CA.origin, self.origin) < var_2) {
              self _meth_8034(var_7._id_026E, var_7._id_25CA.origin);
              var_9 = _func_0080(var_7._id_25CA.origin);

              if(isDefined(var_9)) {
                self._id_4625 = var_9.origin;
                self notify("defend_force_node_recalculation");
              }

              var_7._id_8F33 = var_4;
            }

            var_0[var_8] = var_4 + 10000;
          }
        }
      }
    }

    wait((randomint(5) + 1) * 0.05);
  }
}

_id_4624() {
  if(isDefined(self._id_4627)) {
    return self._id_4627;
  } else if(scripts\mp\bots\bots_util::_id_2801()) {
    return _id_2762(self._id_412E, 1);
  } else if(scripts\mp\bots\bots_util::_id_280B() || scripts\mp\bots\bots_util::_id_2800()) {
    var_0 = _func_0066(self.origin);
    return var_0;
  }
}

_id_462A() {
  self notify("defense_watch_entrances_at_goal");
  self endon("defense_watch_entrances_at_goal");
  self endon("new_defend_goal");
  self endon("script_goal_changed");
  var_0 = self _meth_815E();
  var_1 = undefined;

  if(scripts\mp\bots\bots_util::_id_2801()) {
    var_2 = _id_4624();
    var_1 = [];

    if(isDefined(var_0)) {
      foreach(var_4 in var_2) {
        if(_func_0158(var_0, var_4, 1)) {
          var_1 = scripts\engine\utility::array_add(var_1, var_4);
        }
      }
    }

    if(var_1.size == 0) {
      var_1 = _func_0066(self.origin);
    }
  } else if(scripts\mp\bots\bots_util::_id_280B() || scripts\mp\bots\bots_util::_id_2800()) {
    var_1 = _id_4624();
    var_6 = self getcurrentweapon();

    if(isDefined(var_0) && !issubstr(var_6.basename, "riotshield") && isDefined(self._id_A550)) {
      if(_func_0158(var_0, self._id_A550, 1)) {
        var_1 = scripts\engine\utility::array_add(var_1, self._id_A550);
      }
    }
  }

  if(isDefined(var_1)) {
    childthread scripts\mp\bots\bots_util::_id_2925(var_1);

    if(scripts\mp\bots\bots_util::_id_2800()) {
      childthread _id_285D();
    } else if(isDefined(level._id_279D["bot_entrance_update"])) {
      self childthread[[level._id_279D["bot_entrance_update"]]]();
    } else {
      childthread _id_285C();
    }
  }
}

_id_285C() {
  self notify("bot_monitor_watch_entrances_at_goal");
  self endon("bot_monitor_watch_entrances_at_goal");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");
  self endon("bot_watch_nodes_stop");

  while(!isDefined(self._id_10A77)) {
    wait 0.05;
  }

  var_0 = level._id_279D["get_watch_node_chance"];

  for(;;) {
    var_1 = 0.8;
    var_2 = 1.0;

    if(scripts\engine\utility::array_contains(self._id_4628, "strict_los")) {
      var_1 = 1.0;
      var_2 = 0.5;
    }

    if(isDefined(self._id_A550)) {
      foreach(var_4 in self._id_10A77) {
        if(var_4 == self._id_A550) {
          var_4._id_10A75[self._id_5501] = var_4._id_10A74[self._id_5501] * var_1;
          continue;
        }

        var_4._id_10A75[self._id_5501] = var_4._id_10A74[self._id_5501] * var_2;
      }
    }

    var_6 = isDefined(var_0);

    if(!var_6) {
      _id_BD26(0.5);
    }

    foreach(var_4 in self._id_10A77) {
      if(var_6) {
        var_8 = self[[var_0]](var_4);
        var_4._id_10A75[self._id_5501] = var_4._id_10A75[self._id_5501] * var_8;
      }

      if(_id_5521(var_4)) {
        var_4._id_10A75[self._id_5501] = var_4._id_10A75[self._id_5501] * 0.5;
      }
    }

    wait(randomfloatrange(0.5, 0.75));
  }
}

_id_285D() {
  self notify("bot_monitor_watch_entrances_bodyguard");
  self endon("bot_monitor_watch_entrances_bodyguard");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");

  while(!isDefined(self._id_10A77)) {
    wait 0.05;
  }

  for(;;) {
    var_0 = anglesToForward(self._id_2764 getplayerangles()) * (1, 1, 0);
    var_0 = vectornormalize(var_0);

    foreach(var_2 in self._id_10A77) {
      var_2._id_10A75[self._id_5501] = var_2._id_10A74[self._id_5501];
      var_3 = var_2.origin - self._id_2764.origin;
      var_3 = vectornormalize(var_3);
      var_4 = vectordot(var_0, var_3);

      if(var_4 > 0.6) {
        var_2._id_10A75[self._id_5501] = var_2._id_10A75[self._id_5501] * 0.33;
      } else if(var_4 > 0) {
        var_2._id_10A75[self._id_5501] = var_2._id_10A75[self._id_5501] * 0.66;
      }

      if(!_id_551F(var_2)) {
        var_2._id_10A75[self._id_5501] = var_2._id_10A75[self._id_5501] * 0.5;
      }
    }

    wait(randomfloatrange(0.4, 0.6));
  }
}

_id_551F(var_0) {
  var_1 = _func_00B8(var_0);
  var_2 = vectornormalize(var_0.origin - self.origin);

  for(var_3 = 0; var_3 < level._id_110E1; var_3++) {
    if(_func_0029(var_3, self.team, "enemy_predict") > 0) {
      if(isDefined(var_1) && var_3 == var_1) {
        return 1;
      } else {
        var_4 = vectornormalize(_func_00F9(var_3) - self.origin);
        var_5 = vectordot(var_2, var_4);

        if(var_5 > 0.2) {
          return 1;
        }
      }
    }
  }

  return 0;
}

_id_BD26(var_0) {
  if(self._id_10A77.size <= 0) {
    return;
  }
  var_1 = self._id_10A77;

  for(var_2 = 0; var_2 < level._id_110E1; var_2++) {
    if(_func_0029(var_2, self.team, "enemy_predict") <= 0) {
      continue;
    }
    if(var_1.size == 0) {
      break;
    }

    var_3 = vectornormalize(_func_00F9(var_2) - self.origin);

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      var_5 = _func_00B8(var_1[var_4]);
      var_6 = 0;

      if(isDefined(var_5) && var_2 == var_5) {
        var_6 = 1;
      } else {
        var_7 = vectornormalize(var_1[var_4].origin - self.origin);
        var_8 = vectordot(var_7, var_3);

        if(var_8 > 0.2) {
          var_6 = 1;
        }
      }

      if(var_6) {
        var_1[var_4]._id_10A75[self._id_5501] = var_1[var_4]._id_10A75[self._id_5501] * var_0;
        var_1[var_4] = var_1[var_1.size - 1];
        var_1[var_1.size - 1] = undefined;
        var_4--;
      }
    }
  }
}

_id_5521(var_0) {
  if(self._id_276F == "protect_zone") {
    var_1 = _id_27D5(self._id_2770);
  } else {
    var_1 = _id_27D4(self._id_276A);
  }

  foreach(var_3 in var_1) {
    if(_id_5522(var_3, var_0)) {
      return 1;
    }
  }

  return 0;
}

_id_5522(var_0, var_1) {
  var_2 = anglesToForward(var_0 getplayerangles());
  var_3 = vectornormalize(var_1.origin - var_0.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 > 0.6) {
    return 1;
  }

  return 0;
}

_id_27D5(var_0) {
  var_1 = [];
  var_2 = _id_27D6(self.origin, 1000);

  foreach(var_4 in var_2) {
    if(!isai(var_4) || var_4 scripts\mp\bots\bots_util::_id_2805() && var_4._id_2770 == var_0) {
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
    }
  }

  return var_1;
}

_id_27D4(var_0, var_1) {
  if(!isDefined(var_1)) {
    if(isDefined(level._id_BDBF)) {
      var_1 = level._id_BDBF;
    } else {
      var_1 = 900;
    }
  }

  var_2 = [];
  var_3 = _id_27D6(var_0, var_1);

  foreach(var_5 in var_3) {
    if(!isai(var_5) || var_5 scripts\mp\bots\bots_util::_id_2806(var_0)) {
      var_2 = scripts\engine\utility::array_add(var_2, var_5);
    }
  }

  return var_2;
}

_id_27D6(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = [];

  for(var_4 = 0; var_4 < level._id_AE7C.size; var_4++) {
    var_5 = level._id_AE7C[var_4];

    if(var_5 != self && isDefined(var_5.team) && var_5.team == self.team && scripts\mp\utility\entity::_id_8A94(var_5)) {
      if(distancesquared(var_0, var_5.origin) < var_2) {
        var_3 = scripts\engine\utility::array_add(var_3, var_5);
      }
    }
  }

  return var_3;
}

_id_4622() {
  level endon("game_ended");
  self endon("started_bot_defend_think");
  self endon("defend_stop");
  self endon("disconnect");
  self waittill("death");

  if(isDefined(self)) {
    thread _id_2766();
  }
}

_id_2766() {
  self notify("defend_stop");
  self._id_2769 = undefined;
  self._id_276A = undefined;
  self._id_276D = undefined;
  self._id_276B = undefined;
  self._id_276F = undefined;
  self._id_276E = undefined;
  self._id_276C = undefined;
  self._id_2764 = undefined;
  self._id_2770 = undefined;
  self._id_4628 = undefined;
  self._id_A550 = undefined;
  self._id_4625 = undefined;
  self._id_4623 = undefined;
  self._id_45E0 = undefined;
  self._id_BC06 = undefined;
  self._id_412C = undefined;
  self._id_412B = undefined;
  self._id_412D = undefined;
  self._id_45DB = undefined;
  self._id_4627 = undefined;
  self _meth_802B();
  self _meth_805B("none");
}

_id_45DD(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_AE7C) {
    if(!isDefined(var_3.team)) {
      continue;
    }
    if(var_3.team == self.team && var_3 != self && isai(var_3) && var_3 scripts\mp\bots\bots_util::_id_2805() && isDefined(var_3._id_412E) && var_3._id_412E == var_0) {
      if(var_3._id_276F == self._id_276F && scripts\mp\bots\bots_util::_id_2806(var_3._id_276A)) {
        var_1 = scripts\engine\utility::array_add(var_1, var_3);
      }
    }
  }

  return var_1;
}

_id_A0C6() {
  var_0 = 0;
  var_1 = 175;
  var_2 = self._id_2764.origin;
  var_3 = 0;
  var_4 = 0;

  for(;;) {
    if(!isDefined(self._id_2764)) {
      thread _id_2766();
    }

    self._id_276A = self._id_2764.origin;
    self._id_A550 = self._id_2764 _meth_815E();

    if(!isDefined(self._id_A550)) {
      self._id_A550 = self _meth_815E();
    }

    if(self _meth_803E() != "none") {
      var_5 = self _meth_803B();
      var_6 = self._id_2764 getvelocity();
      var_7 = _func_0135(var_6);

      if(var_7 > 100) {
        var_0 = 0;

        if(distancesquared(var_2, self._id_2764.origin) > var_1 * var_1) {
          var_2 = self._id_2764.origin;
          var_4 = 1;
          var_8 = vectornormalize(var_5 - self._id_2764.origin);
          var_9 = vectornormalize(var_6);

          if(vectordot(var_8, var_9) < 0.1) {
            self notify("defend_force_node_recalculation");
            wait 0.25;
          }
        }
      } else {
        var_0 = var_0 + 0.05;

        if(var_3 > 100 && var_4) {
          var_2 = self._id_2764.origin;
          var_4 = 0;
        }

        if(var_0 > 0.5) {
          var_10 = distancesquared(var_5, self._id_276A);

          if(var_10 > self._id_276D * self._id_276D) {
            self notify("defend_force_node_recalculation");
            wait 0.25;
          }
        }
      }

      var_3 = var_7;

      if(abs(self._id_2764.origin[2] - var_5[2]) >= 50) {
        self notify("defend_force_node_recalculation");
        wait 0.25;
      }
    }

    wait 0.05;
  }
}

_id_5AC1() {
  var_0 = _id_2763();
  var_1 = scripts\mp\bots\bots_util::_id_2791(scripts\mp\bots\bots_util::_id_45E3(), self._id_276D, var_0);

  if(isDefined(var_1)) {
    if(isDefined(var_0)) {
      var_2 = vectornormalize(var_0 - var_1.origin);
      self._id_412B = vectortoangles(var_2);
    } else {
      var_3 = vectornormalize(var_1.origin - scripts\mp\bots\bots_util::_id_45E3());
      self._id_412B = vectortoangles(var_3);
    }

    self._id_412C = var_1;
  } else if(isDefined(var_0))
    _id_27E7(var_0, undefined);
  else {
    _id_27E7(undefined, scripts\mp\bots\bots_util::_id_45E3());
  }
}

_id_5AC2() {
  var_0 = _id_2763();
  var_1 = scripts\mp\bots\bots_util::_id_2792(self._id_276B, var_0);

  if(isDefined(var_1)) {
    if(isDefined(var_0)) {
      var_2 = vectornormalize(var_0 - var_1.origin);
      self._id_412B = vectortoangles(var_2);
    } else {
      var_3 = vectornormalize(var_1.origin - scripts\mp\bots\bots_util::_id_45E3());
      self._id_412B = vectortoangles(var_3);
    }

    self._id_412C = var_1;
  } else if(isDefined(var_0))
    _id_27E7(var_0, undefined);
  else {
    _id_27E7(undefined, scripts\mp\bots\bots_util::_id_45E3());
  }
}

_id_5AC4() {
  var_0 = scripts\mp\bots\bots_util::_id_2790(scripts\mp\bots\bots_util::_id_45E3(), self._id_276D);

  if(isDefined(var_0)) {
    var_1 = vectornormalize(scripts\mp\bots\bots_util::_id_45E3() - var_0.origin);
    self._id_412B = vectortoangles(var_1);
    self._id_412C = var_0;
  } else
    _id_27E7(scripts\mp\bots\bots_util::_id_45E3(), undefined);
}

_id_5AC5() {
  var_0 = scripts\mp\bots\bots_util::_id_2794(self._id_276B, scripts\mp\bots\bots_util::_id_45E3());

  if(isDefined(var_0)) {
    self._id_412C = var_0;
  } else {
    _id_27E7(scripts\mp\bots\bots_util::_id_45E3(), undefined);
  }
}

_id_5AC0() {
  var_0 = scripts\mp\bots\bots_util::_id_2793(scripts\mp\bots\bots_util::_id_45E3(), self._id_276D);

  if(isDefined(var_0)) {
    self._id_412C = var_0;
  } else {
    var_1 = self _meth_815E();

    if(isDefined(var_1)) {
      self._id_412C = var_1;
    } else {
      self._id_412D = self.origin;
    }
  }
}

_id_5AC3() {
  var_0 = undefined;
  var_1 = _func_00B4(scripts\mp\bots\bots_util::_id_45E3(), self._id_276D, 0);

  if(isDefined(var_1) && var_1.size > 0) {
    var_0 = self _meth_8049(var_1, 1 + var_1.size * 0.5, "node_traffic");
  }

  if(isDefined(var_0)) {
    self._id_412C = var_0;
  } else {
    _id_27E7(undefined, scripts\mp\bots\bots_util::_id_45E3());
  }
}

_id_27E7(var_0, var_1) {
  if(self._id_276F == "protect_zone") {
    self._id_412D = scripts\engine\utility::random(self._id_276B).origin;
  } else {
    if(self._id_276F == "capture_zone") {
      self._id_412D = scripts\mp\bots\bots_util::_id_288A(scripts\mp\bots\bots_util::_id_45E3(), self._id_276B, ::_id_2726);
    } else {
      self._id_412D = scripts\mp\bots\bots_util::_id_288B(scripts\mp\bots\bots_util::_id_45E3(), self._id_276D, ::_id_2726, 0.15, 0.9);
    }

    if(isDefined(var_0)) {
      var_2 = vectornormalize(var_0 - self._id_412D);
      self._id_412B = vectortoangles(var_2);
      return;
    }

    if(isDefined(var_1)) {
      var_2 = vectornormalize(self._id_412D - var_1);
      self._id_412B = vectortoangles(var_2);
    }
  }
}

_id_2726(var_0) {
  if(_id_272D(var_0, 1, 1, 1)) {
    return 0;
  }

  return 1;
}

_id_272D(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < level._id_AE7C.size; var_4++) {
    var_5 = level._id_AE7C[var_4];

    if(var_5.team == self.team && var_5 != self) {
      if(isai(var_5)) {
        if(var_2) {
          if(distancesquared(var_0, var_5.origin) < 441) {
            return 1;
          }
        }

        if(var_3 && var_5 _meth_8042()) {
          var_6 = var_5 _meth_803B();

          if(distancesquared(var_0, var_6) < 441) {
            return 1;
          }
        }

        continue;
      }

      if(var_1) {
        if(distancesquared(var_0, var_5.origin) < 441) {
          return 1;
        }
      }
    }
  }

  return 0;
}

_id_272B() {
  var_0 = 0;

  if(isDefined(self._id_276B)) {
    foreach(var_2 in self._id_276B) {
      var_3 = distance(self._id_276A, var_2.origin);
      var_0 = max(var_3, var_0);
    }
  }

  return var_0;
}

_id_2902() {
  self notify("bot_think_tactical_goals");
  self endon("bot_think_tactical_goals");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self._id_ED29 = [];
  self._id_ED28 = 0;

  for(;;) {
    if(self._id_ED29.size > 0 && !scripts\mp\bots\bots_util::_id_280F()) {
      var_0 = self._id_ED29[0];

      if(!isDefined(var_0._id_0E06)) {
        self notify("start_tactical_goal");

        if(isDefined(var_0._id_E656)) {
          self[[var_0._id_E656]](var_0);
        }

        childthread _id_10A71(var_0);
        var_1 = "tactical";

        if(isDefined(var_0._id_7080)) {
          var_1 = var_0._id_7080;
        }

        if(istrue(var_0._id_38FA)) {
          self _meth_802B();
        }

        self _meth_8058(var_0._id_707E, var_0._id_707F, var_1, var_0._id_01FD, var_0._id_A8A8, var_0._id_DA40);
        var_2 = scripts\mp\bots\bots_util::_id_291C(undefined, "stop_tactical_goal");
        self notify("stop_goal_aborted_watch");

        if(var_2 == "goal") {
          if(isDefined(var_0._id_0E86)) {
            self._id_ED28 = 1;
            self[[var_0._id_0E86]](var_0);
            self._id_ED28 = 0;
          }
        }

        if(var_2 != "script_goal_changed") {
          self _meth_802B();
        }

        if(isDefined(var_0._id_52CD)) {
          self[[var_0._id_52CD]](var_0);
        }
      }

      self._id_ED29 = scripts\engine\utility::array_remove(self._id_ED29, var_0);
    }

    wait 0.05;
  }
}

_id_10A71(var_0) {
  self endon("stop_tactical_goal");
  self endon("stop_goal_aborted_watch");
  wait 0.05;

  for(;;) {
    if(isDefined(var_0._id_0E06) || isDefined(var_0._id_DA6E) && self[[var_0._id_DA6E]](var_0)) {
      self notify("stop_tactical_goal");
    }

    wait 0.05;
  }
}

_id_2862(var_0, var_1, var_2, var_3) {
  if(_func_0135(var_1) == 0) {
    var_1 = var_1 + (0, 0, 1);
  }

  var_4 = spawnStruct();
  var_4.type = var_0;
  var_4._id_707E = var_1;

  if(isDefined(self._id_AB2E)) {
    if(!scripts\engine\utility::array_contains(self._id_AB2E, var_0)) {
      return;
    }
  }

  var_4._id_BD27 = var_2;
  var_4._id_A860 = var_3._id_A860;
  var_4._id_7080 = var_3._id_CD73;
  var_4._id_01FD = var_3._id_CD74;
  var_4._id_707F = 0;

  if(isDefined(var_3._id_CD72)) {
    var_4._id_707F = var_3._id_CD72;
  }

  var_4._id_E656 = var_3._id_E656;
  var_4._id_52CD = var_3._id_52CD;
  var_4._id_DA6E = var_3._id_DA6E;
  var_4._id_0E86 = var_3._id_0E86;
  var_4._id_A8A8 = var_3._id_A8A8;
  var_4._id_DA40 = var_3._id_DA40;
  var_4._id_AC4C = var_3._id_AC4C;
  var_4._id_38FA = var_3._id_38FA;

  for(var_5 = 0; var_5 < self._id_ED29.size; var_5++) {
    if(var_4._id_BD27 > self._id_ED29[var_5]._id_BD27) {
      break;
    }
  }

  for(var_6 = self._id_ED29.size - 1; var_6 >= var_5; var_6--) {
    self._id_ED29[var_6 + 1] = self._id_ED29[var_6];
  }

  self._id_ED29[var_5] = var_4;
}

_id_27ED(var_0, var_1) {
  if(!isDefined(self._id_ED29)) {
    return 0;
  }

  if(isDefined(var_0)) {
    foreach(var_3 in self._id_ED29) {
      if(var_3.type == var_0) {
        if(isDefined(var_1) && isDefined(var_3._id_A860)) {
          return var_3._id_A860 == var_1;
        } else {
          return 1;
        }
      }
    }

    return 0;
  } else
    return self._id_ED29.size > 0;
}

_id_27B4(var_0) {
  var_1 = [];

  if(isDefined(self._id_ED29)) {
    foreach(var_3 in self._id_ED29) {
      if(!istrue(var_3._id_0E06) && var_3.type == var_0) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

_id_26EF(var_0, var_1) {
  if(!isDefined(self._id_ED29)) {
    return;
  }
  foreach(var_3 in self._id_ED29) {
    if(var_3.type == var_0) {
      if(isDefined(var_1)) {
        if(isDefined(var_3._id_A860) && var_3._id_A860 == var_1) {
          var_3._id_0E06 = 1;
        }

        continue;
      }

      var_3._id_0E06 = 1;
    }
  }
}

_id_2775() {
  self._id_AB2E[0] = "map_interactive_object";

  foreach(var_1 in self._id_ED29) {
    if(var_1.type != "map_interactive_object") {
      var_1._id_0E06 = 1;
    }
  }
}

_id_2782() {
  self._id_AB2E = undefined;
}

_id_2855() {
  var_0 = gettime();

  if(!isDefined(self._id_8F3C) || var_0 - self._id_8F3C > 1000) {
    self._id_8F3C = var_0;
    var_1 = _id_27B6("tacticalinsertion");

    if(!isDefined(var_1)) {
      return 0;
    }

    if(isDefined(self._id_0192) && self _meth_8028(self._id_0192)) {
      return 0;
    }

    var_2 = _func_00F5(self.origin);

    if(!isDefined(var_2)) {
      return 0;
    }

    var_3 = _func_002B(var_2, self.team, 1, "enemy_predict", ">", 0);

    if(!isDefined(var_3)) {
      return 0;
    }

    var_4 = _func_00B4(self.origin, 500, 0);

    if(var_4.size <= 0) {
      return 0;
    }

    var_5 = self _meth_8049(var_4, var_4.size * 0.15, "node_hide");

    if(!isDefined(var_5)) {
      return 0;
    }

    return _id_28C1(var_1, undefined, undefined, undefined, var_5);
  }

  return 0;
}