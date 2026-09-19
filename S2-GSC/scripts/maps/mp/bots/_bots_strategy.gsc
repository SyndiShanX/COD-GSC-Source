/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_strategy.gsc
***************************************************/

_id_19A0() {
  var_0 = _id_199F(self._id_28C8);

  if(isDefined(var_0) && var_0.size > 0)
    return common_scripts\utility::random(var_0).origin;

  return undefined;
}

_id_199F(var_0, var_1) {
  if(isDefined(self._id_2C16))
    return maps\mp\bots\_bots_util::_id_19F1(var_0, self._id_2C16, var_1);

  return [];
}

_id_19ED(var_0, var_1, var_2) {
  if(self _meth_837D("allowGrenades") == 0)
    return undefined;

  var_3 = [];
  var_3[var_3.size] = var_0;

  if(isDefined(var_1))
    var_3[var_3.size] = var_1;

  if(isDefined(var_1))
    var_3[var_3.size] = var_2;

  if(var_3.size == 0)
    return undefined;

  var_4 = self _meth_82D2();
  var_5 = [];

  foreach(var_7 in var_4) {
    if(self getweaponammoclip(var_7) > 0 || self getweaponammostock(var_7) > 0)
      var_5[var_5.size] = var_7;
  }

  if(var_5.size <= 0)
    return undefined;

  foreach(var_10 in var_3) {
    foreach(var_7 in var_5) {
      if(maps\mp\bots\_bots_util::_id_1A3A(var_10, var_7)) {
        var_12["purpose"] = var_10;

        if(_func_1DA(var_7) || _func_27E(var_7))
          var_12["item_action"] = "throw";
        else
          var_12["item_action"] = "attack";

        var_12["weap_name"] = var_7;
        return var_12;
      }
    }
  }
}

_id_1AD0(var_0, var_1, var_2, var_3, var_4) {
  self notify("bot_set_ambush_trap");
  self endon("bot_set_ambush_trap");

  if(!isDefined(var_0))
    return 0;

  var_5 = undefined;

  if(!isDefined(var_4) && isDefined(var_1) && var_1.size > 0) {
    if(!isDefined(var_2))
      return 0;

    var_6 = [];
    var_7 = undefined;

    if(isDefined(var_3))
      var_7 = anglesToForward((0, var_3, 0));

    foreach(var_9 in var_1) {
      if(!isDefined(var_7)) {
        var_6[var_6.size] = var_9;
        continue;
      }

      if(distancesquared(var_9.origin, var_2.origin) > 90000) {
        if(vectordot(var_7, vectorNormalize(var_9.origin - var_2.origin)) < 0.4)
          var_6[var_6.size] = var_9;
      }
    }

    if(var_6.size > 0) {
      var_5 = common_scripts\utility::random(var_6);
      var_11 = _func_0B8(var_5.origin, 300, 50);
      var_12 = [];

      foreach(var_14 in var_11) {
        if(!isDefined(var_14._id_1938))
          var_12[var_12.size] = var_14;
      }

      var_11 = var_12;
      var_4 = self _meth_8366(var_11, _func_0AF(var_11.size, 3), "node_trap", var_2, var_5);
    }
  }

  if(isDefined(var_4)) {
    var_16 = undefined;

    if(var_0["purpose"] == "trap_directional" && isDefined(var_5)) {
      var_17 = vectortoangles(var_5.origin - var_4.origin);
      var_16 = var_17[1];
    }

    if(self _meth_8367() && self _meth_835F() != "critical" && self _meth_835F() != "tactical")
      self _meth_8358();

    var_18 = self _meth_8357(var_4, "guard", var_16);

    if(var_18) {
      var_19 = maps\mp\bots\_bots_util::_id_1B21();

      if(var_19 == "goal") {
        thread maps\mp\bots\_bots_util::_id_19D4("stand", 4.0);

        if(!isDefined(self._id_0088) || !self _meth_8371(self._id_0088)) {
          thread maps\mp\bots\_bots_util::_id_19AF(4.0);
          var_20 = (0, 0, 0);

          if(var_0["weap_name"] == "h1_claymore_mp")
            var_20 = (0, 0, 55);

          if(isDefined(var_16))
            self _meth_836F(var_5.origin + var_20, 3.0, "script_forced");
          else
            self _meth_836F(self.origin + var_20 + anglesToForward(self getplayerangles()) * 50, 3.0, "script_forced");

          self switchtoweapon(var_0["weap_name"]);

          while(self getcurrentweapon() != var_0["weap_name"])
            waitframe();

          _id_1B0B(var_0["item_action"]);
          self._id_0D8F = undefined;
          thread _id_1AD1("grenade_fire");
          thread _id_1AD1("missile_fire");
          var_21 = common_scripts\utility::_id_98E7(var_0["purpose"] == "tacticalinsertion", 6.0, 3.0);
          common_scripts\utility::_id_A71A(var_21, "missile_fire", "grenade_fire");
          waitframe();
          self notify("ambush_trap_ent");

          if(isDefined(self._id_0D8F) && var_0["purpose"] == "c4")
            thread _id_1B26(self._id_0D8F, 300);

          self._id_0D8F = undefined;
          wait(_func_0A3(0.25));
          self notify("bot_force_stance_for_time");
          self _meth_8354("none");
          self switchtoweapon("none");
          self notify("bot_disable_movement_for_time");
          self _meth_8353("disable_movement", 0);
          self _meth_836F(undefined);
        }
      }

      return 1;
    }
  }

  return 0;
}

_id_1B0B(var_0) {
  self endon("grenade_pullback");

  for(;;) {
    self _meth_8380(var_0);
    wait 0.5;
  }
}

_id_1AD1(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("bot_set_ambush_trap");
  self endon("ambush_trap_ent");
  level endon("game_ended");
  self waittill(var_0, var_1);
  self._id_0D8F = var_1;
}

_id_1B26(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_0 endon("death");
  level endon("game_ended");
  var_2 = var_1 * var_1;

  for(;;) {
    if(distancesquared(self.origin, var_0.origin) > var_2) {
      var_3 = self _meth_8172(var_0.origin, 1.0);

      if(var_3 < var_2) {
        self _meth_8380("use", 0.25);
        wait 0.5;
        self _meth_8380("use", 0.25);
        return;
      }
    }

    wait(_func_0A5(0.25, 1.0));
  }
}

_id_196A(var_0, var_1, var_2) {
  thread _id_19A4(var_0, var_1, "capture", var_2);
}

_id_196B(var_0, var_1, var_2, var_3) {
  var_3["capture_trigger"] = var_2;
  thread _id_19A4(var_0, var_1, "capture_zone", var_3);
}

_id_1AA6(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !isDefined(var_2["min_goal_time"]))
    var_2["min_goal_time"] = 12;

  if(!isDefined(var_2) || !isDefined(var_2["max_goal_time"]))
    var_2["max_goal_time"] = 18;

  thread _id_19A4(var_0, var_1, "protect", var_2);
}

_id_1AA7(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3) || !isDefined(var_3["min_goal_time"]))
    var_3["min_goal_time"] = 12;

  if(!isDefined(var_3) || !isDefined(var_3["max_goal_time"]))
    var_3["max_goal_time"] = 18;

  if(!isDefined(var_3) || !isDefined(var_3["random_stance"]))
    var_3["random_stance"] = 1;

  var_3["uniqueID"] = var_2;
  thread _id_19A4(var_1, var_0, "protect_zone", var_3);
}

_id_1A8D(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !isDefined(var_2["min_goal_time"]))
    var_2["min_goal_time"] = 0.0;

  if(!isDefined(var_2) || !isDefined(var_2["max_goal_time"]))
    var_2["max_goal_time"] = 0.01;

  thread _id_19A4(var_0, var_1, "patrol", var_2);
}

_id_1A0C(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !isDefined(var_2["min_goal_time"]))
    var_2["min_goal_time"] = 15;

  if(!isDefined(var_2) || !isDefined(var_2["max_goal_time"]))
    var_2["max_goal_time"] = 20;

  thread _id_19A4(var_0, var_1, "bodyguard", var_2);
}

_id_19A2(var_0) {
  if(var_0 == "protect_zone")
    return 0;

  return 1;
}

_id_19A4(var_0, var_1, var_2, var_3) {
  self notify("started_bot_defend_think");
  self endon("started_bot_defend_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("defend_stop");
  thread _id_2C83();

  if(isDefined(self._id_19A6) || self _meth_835F() == "camp")
    self _meth_8358();

  self._id_19A6 = 1;
  self._id_19AC = var_2;

  if(var_2 == "capture_zone") {
    self._id_19AA = undefined;
    self._id_19A8 = var_1;
    self._id_19AB = var_3["capture_trigger"];
  } else if(var_2 == "protect_zone") {
    self._id_19AA = undefined;
    self._id_19A8 = var_1;
    self._id_19AD = var_3["uniqueID"];
  } else {
    self._id_19AA = var_1;
    self._id_19A8 = undefined;
    self._id_19AB = undefined;
  }

  if(maps\mp\_utility::_id_56FF(var_0)) {
    self._id_19A1 = var_0;
    childthread _id_62FD();
  } else {
    self._id_19A1 = undefined;
    self._id_19A7 = var_0;
  }

  self _meth_8354("none");
  var_4 = undefined;
  var_5 = 6;
  var_6 = 10;
  self._id_2C89 = [];

  if(isDefined(var_3)) {
    self._id_2C16 = var_3["entrance_points_index"];
    self._id_19A9 = var_3["override_origin_node"];

    if(isDefined(var_3["score_flags"])) {
      if(_func_0C0(var_3["score_flags"]))
        self._id_2C89 = var_3["score_flags"];
      else
        self._id_2C89[0] = var_3["score_flags"];
    }

    if(isDefined(var_3["override_goal_type"]))
      var_4 = var_3["override_goal_type"];

    if(isDefined(var_3["min_goal_time"]))
      var_5 = var_3["min_goal_time"];

    if(isDefined(var_3["max_goal_time"]))
      var_6 = var_3["max_goal_time"];

    if(isDefined(var_3["override_watch_nodes"]) && var_3["override_watch_nodes"].size > 0)
      self._id_2C88 = var_3["override_watch_nodes"];

    self._id_2C36 = var_3["objective_radius"];
  }

  if(!isDefined(self._id_19A1) && _id_19A2(var_2)) {
    var_7 = undefined;

    if(isDefined(var_3) && isDefined(var_3["nearest_node_to_center"]))
      var_7 = var_3["nearest_node_to_center"];

    if(!isDefined(var_7) && isDefined(self._id_19A9))
      var_7 = self._id_19A9;

    if(!isDefined(var_7) && isDefined(self._id_19AB) && isDefined(self._id_19AB._id_6638))
      var_7 = self._id_19AB._id_6638;

    if(!isDefined(var_7))
      var_7 = _func_0BA(maps\mp\bots\_bots_util::_id_2C6C());

    if(!isDefined(var_7)) {
      var_8 = maps\mp\bots\_bots_util::_id_2C6C();
      var_9 = _func_0B9(var_8, 256, 0);

      for(var_10 = 0; var_10 < var_9.size; var_10++) {
        var_11 = vectorNormalize(var_9[var_10].origin - var_8);
        var_12 = var_8 + var_11 * 15;

        if(_func_07F(var_12, var_9[var_10].origin, 0, undefined)) {
          var_7 = var_9[var_10];
          break;
        }

        waitframe();

        if(_func_07F(var_12 + (0, 0, 55), var_9[var_10].origin + (0, 0, 55), 0, undefined)) {
          var_7 = var_9[var_10];
          break;
        }

        waitframe();
      }
    }

    self._id_6709 = var_7;
  } else if(isDefined(var_3) && isDefined(var_3["nearest_node_to_center"]))
    self._id_6709 = var_3["nearest_node_to_center"];

  var_13 = level._id_19CA[var_2];

  if(!isDefined(var_4)) {
    var_4 = "guard";

    if(var_2 == "capture" || var_2 == "capture_zone")
      var_4 = "objective";
  }

  var_14 = 0;
  var_15 = 0;

  if(maps\mp\bots\_bots_util::_id_1A28()) {
    var_14 = 1;
    var_15 = isDefined(var_3) && isDefined(var_3["entrance_points_index"]) && _func_0C0(var_3["entrance_points_index"]);
  } else if(isDefined(var_3) && common_scripts\utility::_id_562E(var_3["random_stance"])) {
    var_14 = 1;
    var_15 = 1;
  }

  var_16 = 1;

  if(isDefined(var_3) && common_scripts\utility::_id_562E(var_3["dont_leave_goal_during_combat"]))
    var_16 = 0;

  if(var_2 == "protect")
    childthread _id_7792();

  for(;;) {
    self._id_76BA = self._id_28C6;
    self._id_28C6 = undefined;
    self._id_28C5 = undefined;
    self._id_28C7 = undefined;
    self._id_28C8 = _id_1E44(var_14, var_15);
    var_17 = self _meth_835F();
    var_18 = maps\mp\bots\_bots_util::_id_1A0B(var_4, var_17);

    if(!var_18) {
      wait 0.25;
      continue;
    }

    var_19 = var_5;
    var_20 = var_6;
    var_21 = 1;

    if(isDefined(self._id_2C87)) {
      self._id_28C7 = self._id_2C87;
      self._id_2C87 = undefined;
      var_21 = 0;
      var_19 = 1.0;
      var_20 = 2.0;
    } else if(isDefined(self._id_2C85)) {
      self._id_28C6 = self._id_2C85;
      self._id_2C85 = undefined;
    } else {
      if(isDefined(level._id_0A2C) && level._id_0A2C[self.team]) {
        if(!common_scripts\utility::_id_0F79(self._id_2C89, "avoid_aerial_enemies"))
          self._id_2C89[self._id_2C89.size] = "avoid_aerial_enemies";
      }

      self[[var_13]]();
    }

    self _meth_8358();
    var_22 = "";

    if(isDefined(self._id_28C6) || isDefined(self._id_28C7)) {
      if(var_21 && maps\mp\bots\_bots_util::_id_1A33() && !isPlayer(var_0) && isDefined(self._id_2C16)) {
        var_23 = _id_19ED("trap_directional", "trap", "c4");

        if(isDefined(var_23)) {
          var_24 = maps\mp\bots\_bots_util::_id_19F1(undefined, self._id_2C16);
          _id_1AD0(var_23, var_24, self._id_6709);
        }
      }

      if(isDefined(self._id_28C7)) {
        var_25 = undefined;

        if(isDefined(self._id_28C5))
          var_25 = self._id_28C5[1];

        self _meth_8356(self._id_28C7, 0, var_4, var_25, self._id_2C36);
      } else if(!isDefined(self._id_28C5))
        self _meth_8357(self._id_28C6, var_4, undefined, self._id_2C36);
      else
        self _meth_8357(self._id_28C6, var_4, self._id_28C5[1], self._id_2C36);

      if(var_14) {
        if(!isDefined(self._id_76BA) || !isDefined(self._id_28C6) || self._id_76BA != self._id_28C6)
          self _meth_8354("none");
      }

      var_26 = self _meth_835C();
      self notify("new_defend_goal");
      maps\mp\bots\_bots_util::_id_A8CB();

      if(var_4 == "objective") {
        _id_2C82();
        self _meth_8376(1.0);
        self _meth_8353("cautious", 0);
      }

      if(self _meth_8367()) {
        var_27 = self _meth_835C();

        if(maps\mp\bots\_bots_util::_id_1B1C(var_27, var_26))
          var_22 = maps\mp\bots\_bots_util::_id_1B21(20, "defend_force_node_recalculation");
      }

      if(var_22 == "goal") {
        if(var_14)
          self _meth_8354(self._id_28C8);

        childthread _id_2C8D();

        if(var_21 && maps\mp\bots\_bots_util::_id_1A33() && !isPlayer(var_0) && isDefined(self._id_2C16))
          maps\mp\bots\_bots_personality::_id_1B0A();
      }
    }

    if(var_22 != "goal") {
      var_28 = 0.25;

      if(var_22 == "no_path" && isDefined(self._id_2C6E))
        var_28 = self._id_2C6E;

      wait(var_28);
      continue;
    }

    var_29 = _func_0A5(var_19, var_20);
    var_22 = common_scripts\utility::_id_A71A(var_29, "node_relinquished", "goal_changed", "script_goal_changed", "defend_force_node_recalculation", "bad_path");

    if((var_22 == "node_relinquished" || var_22 == "bad_path" || var_22 == "goal_changed" || var_22 == "script_goal_changed") && (self._id_28C8 == "crouch" || self._id_28C8 == "prone"))
      self _meth_8354("none");

    if(var_22 == "timeout" && !var_16)
      maps\mp\bots\_bots_util::_id_1B22();
  }
}

_id_1E44(var_0, var_1) {
  var_2 = "stand";

  if(var_0) {
    var_3 = 100;
    var_4 = 0;
    var_5 = 0;
    var_6 = self _meth_837D("strategyLevel");

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

    if(var_7 < var_4)
      var_2 = "crouch";
    else if(var_7 < var_4 + var_5)
      var_2 = "prone";

    var_8 = !isDefined(var_1) || !var_1;

    if(var_8 && var_2 == "prone") {
      var_9 = _id_199F("prone");
      var_10 = _id_2C1D("prone");

      if(var_10.size >= var_9.size)
        var_2 = "crouch";
    }

    if(var_8 && var_2 == "crouch") {
      var_11 = _id_199F("crouch");
      var_12 = _id_2C1D("crouch");

      if(var_12.size >= var_11.size)
        var_2 = "stand";
    }
  }

  return var_2;
}

_id_8B7A(var_0) {
  var_1 = 1250;
  var_2 = var_1 * var_1;

  if(var_0) {
    if(self _meth_837D("strategyLevel") == 0)
      return 0;

    if(self._id_19AC == "capture_zone" && self istouching(self._id_19AB))
      return 0;

    return distancesquared(self.origin, self._id_19A7) > var_2 * 0.75 * 0.75;
  } else if(self _meth_8377() && distancesquared(self.origin, self._id_19A7) < var_2) {
    var_3 = self _meth_837E();
    return 0 <= var_3 && var_3 <= var_1;
  } else
    return 0;
}

_id_8868(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_1))
    var_2.origin = var_1;
  else
    var_2.origin = var_0.origin;

  var_2._id_010D = var_0;
  var_2._id_3E73 = 0;
  return var_2;
}

_id_2C82() {
  self notify("defense_cautious_approach");
  self endon("defense_cautious_approach");
  level endon("game_ended");
  self endon("defend_force_node_recalculation");
  self endon("death");
  self endon("disconnect");
  self endon("defend_stop");
  self endon("started_bot_defend_think");

  if(![[level._id_19D5["should_start_cautious_approach"]]](1)) {
    return;
  }
  var_0 = self _meth_835C();
  var_1 = self _meth_8378();
  var_2 = 1;
  var_3 = 0.2;
  var_4 = 0;

  while(var_2) {
    wait 0.25;
    var_4 = var_4 + 0.25;

    if(!self _meth_8367()) {
      return;
    }
    var_5 = self _meth_835C();

    if(!maps\mp\bots\_bots_util::_id_1B1C(var_0, var_5)) {
      return;
    }
    if(var_4 >= 1.0) {
      var_6 = self _meth_8372();

      if(var_6.size == 0) {
        self _meth_8358();
        return;
      }
    }

    var_3 = var_3 + 0.25;

    if(var_3 >= 0.5) {
      var_3 = 0.0;

      if([[level._id_19D5["should_start_cautious_approach"]]](0))
        var_2 = 0;
    }
  }

  self _meth_8376(1.8);
  self _meth_8353("cautious", 1);
  var_7 = self _meth_8372();

  if(!isDefined(var_7) || var_7.size <= 2) {
    return;
  }
  self._id_5E5F = [];
  var_8 = 1000;

  if(isDefined(level._id_7790))
    var_8 = level._id_7790;

  var_9 = var_8 * var_8;
  var_10 = _func_0B8(self._id_19A7, var_8, 0, 500);

  if(var_10.size <= 0) {
    return;
  }
  var_11 = 5 + self _meth_837D("strategyLevel") * 2;
  var_12 = int(_func_0AF(var_11, var_10.size));
  var_13 = self _meth_8373(var_10, 15, var_12, "node_protect", maps\mp\bots\_bots_util::_id_2C6C(), "ignore_occupancy");

  for(var_14 = 0; var_14 < var_13.size; var_14++) {
    var_15 = _id_8868(var_13[var_14]);
    self._id_5E5F = common_scripts\utility::_id_0F6F(self._id_5E5F, var_15);
  }

  var_16 = _func_1E5(0, gettime() - 60000, 1, "death", 0, self);

  foreach(var_18 in var_16) {
    if(distancesquared(var_18, self._id_19A7) < var_9) {
      var_19 = _func_0BA(var_18);

      if(isDefined(var_19)) {
        var_15 = _id_8868(var_19, var_18);
        self._id_5E5F = common_scripts\utility::_id_0F6F(self._id_5E5F, var_15);
      }
    }
  }

  if(isDefined(self._id_2C16)) {
    var_21 = maps\mp\bots\_bots_util::_id_19F1("stand", self._id_2C16);

    for(var_14 = 0; var_14 < var_21.size; var_14++) {
      var_15 = _id_8868(var_21[var_14]);
      self._id_5E5F = common_scripts\utility::_id_0F6F(self._id_5E5F, var_15);
    }
  }

  if(self._id_5E5F.size == 0) {
    return;
  }
  childthread _id_62F2();
  var_22 = self _meth_835F();
  var_23 = self _meth_835D();
  var_24 = self _meth_835E();
  waitframe();

  for(var_25 = 1; var_25 < var_7.size - 2; var_25++) {
    maps\mp\bots\_bots_util::_id_1B22();
    var_26 = _func_204(var_7[var_25]);

    if(var_26.size == 0) {
      continue;
    }
    var_27 = [];

    for(var_14 = 0; var_14 < var_26.size; var_14++) {
      if(!common_scripts\utility::within_fov(self.origin, self getplayerangles(), var_26[var_14].origin, 0)) {
        continue;
      }
      for(var_28 = 0; var_28 < self._id_5E5F.size; var_28++) {
        var_18 = self._id_5E5F[var_28];

        if(_func_1F4(var_18._id_010D, var_26[var_14], 1)) {
          var_27 = common_scripts\utility::_id_0F6F(var_27, var_26[var_14]);
          var_28 = self._id_5E5F.size;
        }
      }
    }

    if(var_27.size == 0) {
      continue;
    }
    var_29 = self _meth_8366(var_27, 1 + var_27.size * 0.15, "node_hide");

    if(isDefined(var_29)) {
      var_30 = [];

      for(var_14 = 0; var_14 < self._id_5E5F.size; var_14++) {
        if(_func_1F4(self._id_5E5F[var_14]._id_010D, var_29, 1)) {
          if(_func_211(self._id_5E5F[var_14].origin, var_29.origin) > 3600)
            var_30 = common_scripts\utility::_id_0F6F(var_30, self._id_5E5F[var_14]);
        }
      }

      self _meth_8358();
      self _meth_8357(var_29, "critical");
      childthread _id_62F3();
      var_31 = maps\mp\bots\_bots_util::_id_1B21(undefined, "cautious_approach_early_out");
      self notify("stop_cautious_approach_early_out_monitor");

      if(var_31 == "cautious_approach_early_out") {
        break;
      }

      if(var_31 == "goal") {
        for(var_14 = 0; var_14 < var_30.size; var_14++) {
          if(_func_211(self.origin, var_30[var_14].origin) < 1600) {
            continue;
          }
          for(var_4 = 0; var_30[var_14]._id_3E73 < 18 && var_4 < 3.6; var_4 = var_4 + 0.25) {
            self _meth_836F(var_30[var_14].origin + (0, 0, self _meth_82F8()), 0.25, "script_search");
            wait 0.25;
          }
        }
      }
    }

    waitframe();
  }

  self notify("stop_location_monitoring");
  self _meth_8358();

  if(isDefined(var_1))
    self _meth_8357(var_1, var_22, var_24);
  else
    self _meth_8356(self._id_28C7, var_23, var_22, var_24);
}

_id_62F3() {
  self endon("cautious_approach_early_out");
  self endon("stop_cautious_approach_early_out_monitor");
  var_0 = undefined;

  if(isDefined(self._id_19AA))
    var_0 = self._id_19AA * self._id_19AA;
  else if(isDefined(self._id_19A8)) {
    var_1 = _id_196C();
    var_0 = var_1 * var_1;
  }

  waitframe();

  for(;;) {
    if(distancesquared(self.origin, self._id_19A7) < var_0)
      self notify("cautious_approach_early_out");

    waitframe();
  }
}

_id_62F2() {
  self endon("stop_location_monitoring");
  var_0 = 10000;

  for(;;) {
    var_1 = self _meth_838A();

    if(isDefined(var_1)) {
      var_2 = self _meth_8375();

      for(var_3 = 0; var_3 < self._id_5E5F.size; var_3++) {
        if(_func_1F4(var_1, self._id_5E5F[var_3]._id_010D, 1)) {
          var_4 = common_scripts\utility::within_fov(self.origin, self getplayerangles(), self._id_5E5F[var_3].origin, var_2);
          var_5 = !var_4 || self._id_5E5F[var_3]._id_3E73 < 17;

          if(var_5 && distancesquared(self.origin, self._id_5E5F[var_3].origin) < var_0) {
            var_4 = 1;
            self._id_5E5F[var_3]._id_3E73 = 18;
          }

          if(var_4) {
            self._id_5E5F[var_3]._id_3E73++;

            if(self._id_5E5F[var_3]._id_3E73 >= 18) {
              self._id_5E5F[var_3] = self._id_5E5F[self._id_5E5F.size - 1];
              self._id_5E5F[self._id_5E5F.size - 1] = undefined;
              var_3--;
            }
          }
        }
      }
    }

    waitframe();
  }
}

_id_7792() {
  self notify("protect_watch_allies");
  self endon("protect_watch_allies");
  var_0 = [];
  var_1 = 1050;
  var_2 = var_1 * var_1;
  var_3 = 900;

  if(isDefined(level._id_7790))
    var_3 = level._id_7790;

  for(;;) {
    var_4 = gettime();
    var_5 = _id_1A06(self._id_19A7, var_3);

    foreach(var_7 in var_5) {
      var_8 = var_7._id_37CD;

      if(!isDefined(var_8))
        var_8 = var_7 getentitynumber();

      if(!isDefined(var_0[var_8]))
        var_0[var_8] = var_4 - 1;

      if(!isDefined(var_7._id_5B2C))
        var_7._id_5B2C = var_4 - 10001;

      if(var_7.health == 0 && isDefined(var_7._id_2AB8) && var_4 - var_7._id_2AB8 < 5000) {
        if(var_4 - var_7._id_5B2C > 10000 && var_4 > var_0[var_8]) {
          if(isDefined(var_7._id_00E6) && isDefined(var_7._id_00E6.team) && var_7._id_00E6.team == common_scripts\utility::_id_416F(self.team)) {
            if(distancesquared(var_7._id_18A8.origin, self.origin) < var_2) {
              self _meth_8379(var_7._id_00E6, var_7._id_18A8.origin);
              var_9 = _func_0BA(var_7._id_18A8.origin);

              if(isDefined(var_9)) {
                self._id_2C87 = var_9.origin;
                self notify("defend_force_node_recalculation");
              }

              var_7._id_5B2C = var_4;
            }

            var_0[var_8] = var_4 + 10000;
          }
        }
      }
    }

    wait((randomint(5) + 1) * 0.05);
  }
}

_id_2C86() {
  if(isDefined(self._id_2C88))
    return self._id_2C88;
  else if(maps\mp\bots\_bots_util::_id_1A28())
    return _id_199F(self._id_28C8, 1);
  else if(maps\mp\bots\_bots_util::_id_1A33() || maps\mp\bots\_bots_util::_id_1A27()) {
    var_0 = _func_201(self.origin);
    return var_0;
  }
}

_id_2C8D() {
  self notify("defense_watch_entrances_at_goal");
  self endon("defense_watch_entrances_at_goal");
  self endon("new_defend_goal");
  self endon("script_goal_changed");
  var_0 = self _meth_838A();
  var_1 = undefined;

  if(maps\mp\bots\_bots_util::_id_1A28()) {
    var_2 = _id_2C86();
    var_1 = [];

    if(isDefined(var_0)) {
      foreach(var_4 in var_2) {
        if(_func_1F4(var_0, var_4, 1))
          var_1 = common_scripts\utility::_id_0F6F(var_1, var_4);
      }
    }

    if(var_1.size == 0)
      var_1 = _func_201(self.origin);
  } else if(maps\mp\bots\_bots_util::_id_1A33() || maps\mp\bots\_bots_util::_id_1A27()) {
    var_1 = _id_2C86();

    if(isDefined(var_0) && !issubstr(self getcurrentweapon(), "riotshield") && isDefined(self._id_6709)) {
      if(_func_1F4(var_0, self._id_6709, 1))
        var_1 = common_scripts\utility::_id_0F6F(var_1, self._id_6709);
    }
  }

  if(isDefined(var_1)) {
    childthread maps\mp\bots\_bots_util::_id_1B2A(var_1);

    if(maps\mp\bots\_bots_util::_id_1A27())
      childthread _id_1A83();
    else if(isDefined(level._id_19D5["bot_entrance_update"]))
      self childthread[[level._id_19D5["bot_entrance_update"]]]();
    else
      childthread _id_1A82();
  }
}

_id_1A82() {
  self notify("bot_monitor_watch_entrances_at_goal");
  self endon("bot_monitor_watch_entrances_at_goal");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");
  self endon("bot_watch_nodes_stop");

  while(!isDefined(self._id_A8C9))
    waitframe();

  var_0 = level._id_19D5["get_watch_node_chance"];

  for(;;) {
    var_1 = 0.8;
    var_2 = 1.0;

    if(common_scripts\utility::_id_0F79(self._id_2C89, "strict_los")) {
      var_1 = 1.0;
      var_2 = 0.5;
    }

    if(isDefined(self._id_6709)) {
      foreach(var_4 in self._id_A8C9) {
        if(var_4 == self._id_6709) {
          var_4._id_A8C7[self._id_37CD] = var_4._id_A8C6[self._id_37CD] * var_1;
          continue;
        }

        var_4._id_A8C7[self._id_37CD] = var_4._id_A8C6[self._id_37CD] * var_2;
      }
    }

    var_6 = isDefined(var_0);

    if(!var_6)
      _id_7733(0.5);

    foreach(var_4 in self._id_A8C9) {
      if(var_6) {
        var_8 = self[[var_0]](var_4);
        var_4._id_A8C7[self._id_37CD] = var_4._id_A8C7[self._id_37CD] * var_8;
      }

      if(_id_37E0(var_4))
        var_4._id_A8C7[self._id_37CD] = var_4._id_A8C7[self._id_37CD] * 0.5;
    }

    wait(_func_0A5(0.5, 0.75));
  }
}

_id_1A83() {
  self notify("bot_monitor_watch_entrances_bodyguard");
  self endon("bot_monitor_watch_entrances_bodyguard");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");

  while(!isDefined(self._id_A8C9))
    waitframe();

  for(;;) {
    var_0 = anglesToForward(self._id_19A1 getplayerangles()) * (1, 1, 0);
    var_0 = vectorNormalize(var_0);

    foreach(var_2 in self._id_A8C9) {
      var_2._id_A8C7[self._id_37CD] = var_2._id_A8C6[self._id_37CD];
      var_3 = var_2.origin - self._id_19A1.origin;
      var_3 = vectorNormalize(var_3);
      var_4 = vectordot(var_0, var_3);

      if(var_4 > 0.6)
        var_2._id_A8C7[self._id_37CD] = var_2._id_A8C7[self._id_37CD] * 0.33;
      else if(var_4 > 0)
        var_2._id_A8C7[self._id_37CD] = var_2._id_A8C7[self._id_37CD] * 0.66;

      if(!_id_37DE(var_2))
        var_2._id_A8C7[self._id_37CD] = var_2._id_A8C7[self._id_37CD] * 0.5;
    }

    wait(_func_0A5(0.4, 0.6));
  }
}

_id_37DE(var_0) {
  var_1 = _func_1FB(var_0);
  var_2 = vectorNormalize(var_0.origin - self.origin);

  for(var_3 = 0; var_3 < level._id_AC9C; var_3++) {
    if(_func_1E7(var_3, self.team, "enemy_predict") > 0) {
      if(isDefined(var_1) && var_3 == var_1)
        return 1;
      else {
        var_4 = vectorNormalize(_func_1FA(var_3) - self.origin);
        var_5 = vectordot(var_2, var_4);

        if(var_5 > 0.2)
          return 1;
      }
    }
  }

  return 0;
}

_id_7733(var_0) {
  if(self._id_A8C9.size <= 0) {
    return;
  }
  var_1 = self._id_A8C9;

  for(var_2 = 0; var_2 < level._id_AC9C; var_2++) {
    if(_func_1E7(var_2, self.team, "enemy_predict") <= 0) {
      continue;
    }
    if(var_1.size == 0) {
      break;
    }

    var_3 = vectorNormalize(_func_1FA(var_2) - self.origin);

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      var_5 = _func_1FB(var_1[var_4]);
      var_6 = 0;

      if(isDefined(var_5) && var_2 == var_5)
        var_6 = 1;
      else {
        var_7 = vectorNormalize(var_1[var_4].origin - self.origin);
        var_8 = vectordot(var_7, var_3);

        if(var_8 > 0.2)
          var_6 = 1;
      }

      if(var_6) {
        var_1[var_4]._id_A8C7[self._id_37CD] = var_1[var_4]._id_A8C7[self._id_37CD] * var_0;
        var_1[var_4] = var_1[var_1.size - 1];
        var_1[var_1.size - 1] = undefined;
        var_4--;
      }
    }
  }
}

_id_37E0(var_0) {
  if(self._id_19AC == "protect_zone")
    var_1 = _id_1A05(self._id_19AD);
  else
    var_1 = _id_1A04(self._id_19A7);

  foreach(var_3 in var_1) {
    if(_id_37E1(var_3, var_0))
      return 1;
  }

  return 0;
}

_id_37E1(var_0, var_1) {
  var_2 = anglesToForward(var_0 getplayerangles());
  var_3 = vectorNormalize(var_1.origin - var_0.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 > 0.6)
    return 1;

  return 0;
}

_id_1A05(var_0) {
  var_1 = [];
  var_2 = _id_1A06(self.origin, 1000);

  foreach(var_4 in var_2) {
    if(!_func_0C1(var_4) || var_4 maps\mp\bots\_bots_util::_id_1A2D() && var_4._id_19AD == var_0)
      var_1 = common_scripts\utility::_id_0F6F(var_1, var_4);
  }

  return var_1;
}

_id_1A04(var_0, var_1) {
  if(!isDefined(var_1)) {
    if(isDefined(level._id_7790))
      var_1 = level._id_7790;
    else
      var_1 = 900;
  }

  var_2 = [];
  var_3 = _id_1A06(var_0, var_1);

  foreach(var_5 in var_3) {
    if(!_func_0C1(var_5) || var_5 maps\mp\bots\_bots_util::_id_1A2E(var_0))
      var_2 = common_scripts\utility::_id_0F6F(var_2, var_5);
  }

  return var_2;
}

_id_1A06(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = [];

  for(var_4 = 0; var_4 < level._id_6E97.size; var_4++) {
    var_5 = level._id_6E97[var_4];

    if(var_5 != self && isDefined(var_5.team) && var_5.team == self.team && maps\mp\_utility::_id_5800(var_5)) {
      if(distancesquared(var_0, var_5.origin) < var_2)
        var_3 = common_scripts\utility::_id_0F6F(var_3, var_5);
    }
  }

  return var_3;
}

_id_2C83() {
  level endon("game_ended");
  self endon("started_bot_defend_think");
  self endon("defend_stop");
  self endon("disconnect");
  self waittill("death");

  if(isDefined(self))
    thread _id_19A3();
}

_id_19A3() {
  self notify("defend_stop");
  self._id_19A6 = undefined;
  self._id_19A7 = undefined;
  self._id_19AA = undefined;
  self._id_19A8 = undefined;
  self._id_19AC = undefined;
  self._id_19AB = undefined;
  self._id_19A9 = undefined;
  self._id_19A1 = undefined;
  self._id_19AD = undefined;
  self._id_2C89 = undefined;
  self._id_6709 = undefined;
  self._id_2C87 = undefined;
  self._id_2C85 = undefined;
  self._id_2C36 = undefined;
  self._id_76BA = undefined;
  self._id_28C6 = undefined;
  self._id_28C5 = undefined;
  self._id_28C7 = undefined;
  self._id_2C16 = undefined;
  self._id_2C88 = undefined;
  self _meth_8358();
  self _meth_8354("none");
}

_id_2C1D(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_6E97) {
    if(!isDefined(var_3.team)) {
      continue;
    }
    if(var_3.team == self.team && var_3 != self && _func_0C1(var_3) && var_3 maps\mp\bots\_bots_util::_id_1A2D() && isDefined(var_3._id_28C8) && var_3._id_28C8 == var_0) {
      if(var_3._id_19AC == self._id_19AC && maps\mp\bots\_bots_util::_id_1A2E(var_3._id_19A7))
        var_1 = common_scripts\utility::_id_0F6F(var_1, var_3);
    }
  }

  return var_1;
}

_id_62FD() {
  var_0 = 0;
  var_1 = 175;
  var_2 = self._id_19A1.origin;
  var_3 = 0;
  var_4 = 0;

  for(;;) {
    if(!isDefined(self._id_19A1))
      thread _id_19A3();

    self._id_19A7 = self._id_19A1.origin;
    self._id_6709 = self._id_19A1 _meth_838A();

    if(!isDefined(self._id_6709))
      self._id_6709 = self _meth_838A();

    if(self _meth_835F() != "none") {
      var_5 = self _meth_835C();
      var_6 = self._id_19A1 _meth_833D();
      var_7 = _func_0E5(var_6);

      if(var_7 > 100) {
        var_0 = 0;

        if(distancesquared(var_2, self._id_19A1.origin) > var_1 * var_1) {
          var_2 = self._id_19A1.origin;
          var_4 = 1;
          var_8 = vectorNormalize(var_5 - self._id_19A1.origin);
          var_9 = vectorNormalize(var_6);

          if(vectordot(var_8, var_9) < 0.1) {
            self notify("defend_force_node_recalculation");
            wait 0.25;
          }
        }
      } else {
        var_0 = var_0 + 0.05;

        if(var_3 > 100 && var_4) {
          var_2 = self._id_19A1.origin;
          var_4 = 0;
        }

        if(var_0 > 0.5) {
          var_10 = distancesquared(var_5, self._id_19A7);

          if(var_10 > self._id_19AA * self._id_19AA) {
            self notify("defend_force_node_recalculation");
            wait 0.25;
          }
        }
      }

      var_3 = var_7;

      if(_func_0AE(self._id_19A1.origin[2] - var_5[2]) >= 50) {
        self notify("defend_force_node_recalculation");
        wait 0.25;
      }
    }

    waitframe();
  }
}

_id_3B6F() {
  var_0 = _id_19A0();
  var_1 = maps\mp\bots\_bots_util::_id_19CC(maps\mp\bots\_bots_util::_id_2C6C(), self._id_19AA, var_0);

  if(isDefined(var_1)) {
    if(isDefined(var_0)) {
      var_2 = vectorNormalize(var_0 - var_1.origin);
      self._id_28C5 = vectortoangles(var_2);
    } else {
      var_3 = vectorNormalize(var_1.origin - maps\mp\bots\_bots_util::_id_2C6C());
      self._id_28C5 = vectortoangles(var_3);
    }

    self._id_28C6 = var_1;
  } else if(isDefined(var_0))
    _id_1A0F(var_0, undefined);
  else
    _id_1A0F(undefined, maps\mp\bots\_bots_util::_id_2C6C());
}

_id_3B70() {
  var_0 = _id_19A0();
  var_1 = maps\mp\bots\_bots_util::_id_19CD(self._id_19A8, var_0);

  if(isDefined(var_1)) {
    if(isDefined(var_0)) {
      var_2 = vectorNormalize(var_0 - var_1.origin);
      self._id_28C5 = vectortoangles(var_2);
    } else {
      var_3 = vectorNormalize(var_1.origin - maps\mp\bots\_bots_util::_id_2C6C());
      self._id_28C5 = vectortoangles(var_3);
    }

    self._id_28C6 = var_1;
  } else if(isDefined(var_0))
    _id_1A0F(var_0, undefined);
  else
    _id_1A0F(undefined, maps\mp\bots\_bots_util::_id_2C6C());
}

_id_3B72() {
  var_0 = maps\mp\bots\_bots_util::_id_19CB(maps\mp\bots\_bots_util::_id_2C6C(), self._id_19AA);

  if(isDefined(var_0)) {
    var_1 = vectorNormalize(maps\mp\bots\_bots_util::_id_2C6C() - var_0.origin);
    self._id_28C5 = vectortoangles(var_1);
    self._id_28C6 = var_0;
  } else
    _id_1A0F(maps\mp\bots\_bots_util::_id_2C6C(), undefined);
}

_id_3B73() {
  var_0 = maps\mp\bots\_bots_util::_id_19CF(self._id_19A8, maps\mp\bots\_bots_util::_id_2C6C());

  if(isDefined(var_0))
    self._id_28C6 = var_0;
  else
    _id_1A0F(maps\mp\bots\_bots_util::_id_2C6C(), undefined);
}

_id_3B6E() {
  var_0 = maps\mp\bots\_bots_util::_id_19CE(maps\mp\bots\_bots_util::_id_2C6C(), self._id_19AA);

  if(isDefined(var_0))
    self._id_28C6 = var_0;
  else {
    var_1 = self _meth_838A();

    if(isDefined(var_1))
      self._id_28C6 = var_1;
    else
      self._id_28C7 = self.origin;
  }
}

_id_3B71() {
  var_0 = undefined;
  var_1 = _func_0B8(maps\mp\bots\_bots_util::_id_2C6C(), self._id_19AA, 0);

  if(isDefined(var_1) && var_1.size > 0)
    var_0 = self _meth_8366(var_1, 1 + var_1.size * 0.5, "node_traffic");

  if(isDefined(var_0))
    self._id_28C6 = var_0;
  else
    _id_1A0F(undefined, maps\mp\bots\_bots_util::_id_2C6C());
}

_id_1A0F(var_0, var_1) {
  if(self._id_19AC == "protect_zone")
    self._id_28C7 = common_scripts\utility::random(self._id_19A8).origin;
  else {
    if(self._id_19AC == "capture_zone")
      self._id_28C7 = maps\mp\bots\_bots_util::_id_1A98(maps\mp\bots\_bots_util::_id_2C6C(), self._id_19A8, ::_id_1966);
    else
      self._id_28C7 = maps\mp\bots\_bots_util::_id_1A99(maps\mp\bots\_bots_util::_id_2C6C(), self._id_19AA, ::_id_1966, 0.15, 0.9);

    if(isDefined(var_0)) {
      var_2 = vectorNormalize(var_0 - self._id_28C7);
      self._id_28C5 = vectortoangles(var_2);
      return;
    }

    if(isDefined(var_1)) {
      var_2 = vectorNormalize(self._id_28C7 - var_1);
      self._id_28C5 = vectortoangles(var_2);
    }
  }
}

_id_1966(var_0) {
  if(_id_196F(var_0, 1, 1, 1))
    return 0;

  return 1;
}

_id_196F(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < level._id_6E97.size; var_4++) {
    var_5 = level._id_6E97[var_4];

    if(var_5.team == self.team && var_5 != self) {
      if(_func_0C1(var_5)) {
        if(var_2) {
          if(distancesquared(var_0, var_5.origin) < 441)
            return 1;
        }

        if(var_3 && var_5 _meth_8367()) {
          var_6 = var_5 _meth_835C();

          if(distancesquared(var_0, var_6) < 441)
            return 1;
        }

        continue;
      }

      if(var_1) {
        if(distancesquared(var_0, var_5.origin) < 441)
          return 1;
      }
    }
  }

  return 0;
}

_id_196C() {
  var_0 = 0;

  if(isDefined(self._id_19A8)) {
    foreach(var_2 in self._id_19A8) {
      var_3 = distance(self._id_19A7, var_2.origin);
      var_0 = max(var_3, var_0);
    }
  }

  return var_0;
}

_id_1B04() {
  self notify("bot_think_tactical_goals");
  self endon("bot_think_tactical_goals");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self._id_959E = [];
  self._id_959D = 0;

  for(;;) {
    if(self._id_959E.size > 0 && !maps\mp\bots\_bots_util::_id_1A36()) {
      var_0 = self._id_959E[0];

      if(!isDefined(var_0._id_0843)) {
        self notify("start_tactical_goal");

        if(isDefined(var_0._id_9296))
          self[[var_0._id_9296]](var_0);

        childthread _id_A8B8(var_0);
        var_1 = "tactical";

        if(isDefined(var_0._id_4809))
          var_1 = var_0._id_4809;

        if(common_scripts\utility::_id_562E(var_0._id_23C7))
          self _meth_8358();

        self _meth_8356(var_0._id_4805, var_0._id_4806, var_1, var_0._id_480A, var_0._id_691E, var_0._id_8B2D);
        var_2 = maps\mp\bots\_bots_util::_id_1B21(undefined, "stop_tactical_goal");
        self notify("stop_goal_aborted_watch");

        if(var_2 == "goal") {
          if(isDefined(var_0._id_087F)) {
            self._id_959D = 1;
            self[[var_0._id_087F]](var_0);
            self._id_959D = 0;
          }
        }

        if(var_2 != "script_goal_changed")
          self _meth_8358();

        if(isDefined(var_0._id_36AC))
          self[[var_0._id_36AC]](var_0);
      }

      self._id_959E = common_scripts\utility::_id_0F93(self._id_959E, var_0);
    }

    waitframe();
  }
}

_id_A8B8(var_0) {
  self endon("stop_tactical_goal");
  self endon("stop_goal_aborted_watch");
  waitframe();

  for(;;) {
    if(isDefined(var_0._id_0843) || isDefined(var_0._id_8B3E) && self[[var_0._id_8B3E]](var_0))
      self notify("stop_tactical_goal");

    waitframe();
  }
}

_id_1A85(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.type = var_0;
  var_4._id_4805 = var_1;

  if(isDefined(self._id_6B4F)) {
    if(!common_scripts\utility::_id_0F79(self._id_6B4F, var_0))
      return;
  }

  var_4.priority = var_2;
  var_4._id_68FB = var_3._id_68FB;
  var_4._id_4809 = var_3._id_81C9;
  var_4._id_480A = var_3._id_81CA;
  var_4._id_4806 = 0;

  if(isDefined(var_3._id_81C8))
    var_4._id_4806 = var_3._id_81C8;

  var_4._id_9296 = var_3._id_9296;
  var_4._id_36AC = var_3._id_36AC;
  var_4._id_8B3E = var_3._id_8B3E;
  var_4._id_087F = var_3._id_087F;
  var_4._id_691E = var_3._id_691E;
  var_4._id_8B2D = var_3._id_8B2D;
  var_4._id_6C13 = var_3._id_6C13;
  var_4._id_23C7 = var_3._id_23C7;

  for(var_5 = 0; var_5 < self._id_959E.size; var_5++) {
    if(var_4.priority > self._id_959E[var_5].priority) {
      break;
    }
  }

  for(var_6 = self._id_959E.size - 1; var_6 >= var_5; var_6--)
    self._id_959E[var_6 + 1] = self._id_959E[var_6];

  self._id_959E[var_5] = var_4;
}

_id_1A14(var_0, var_1) {
  if(!isDefined(self._id_959E))
    return 0;

  if(isDefined(var_0)) {
    foreach(var_3 in self._id_959E) {
      if(var_3.type == var_0) {
        if(isDefined(var_1) && isDefined(var_3._id_68FB))
          return var_3._id_68FB == var_1;
        else
          return 1;
      }
    }

    return 0;
  } else
    return self._id_959E.size > 0;
}

_id_19EB(var_0) {
  var_1 = [];

  if(isDefined(self._id_959E)) {
    foreach(var_3 in self._id_959E) {
      if(!common_scripts\utility::_id_562E(var_3._id_0843) && var_3.type == var_0)
        var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_192C(var_0, var_1) {
  if(!isDefined(self._id_959E)) {
    return;
  }
  foreach(var_3 in self._id_959E) {
    if(var_3.type == var_0) {
      if(isDefined(var_1)) {
        if(isDefined(var_3._id_68FB) && var_3._id_68FB == var_1)
          var_3._id_0843 = 1;

        continue;
      }

      var_3._id_0843 = 1;
    }
  }
}

_id_19B0() {
  self._id_6B4F[0] = "map_interactive_object";

  foreach(var_1 in self._id_959E) {
    if(var_1.type != "map_interactive_object")
      var_1._id_0843 = 1;
  }
}

_id_19BC() {
  self._id_6B4F = undefined;
}

_id_1A7A() {
  var_0 = gettime();

  if(!isDefined(self._id_5B31) || var_0 - self._id_5B31 > 1000) {
    self._id_5B31 = var_0;
    var_1 = _id_19ED("tacticalinsertion");

    if(!isDefined(var_1))
      return 0;

    if(isDefined(self._id_0088) && self _meth_8371(self._id_0088))
      return 0;

    var_2 = _func_1F7(self.origin);

    if(!isDefined(var_2))
      return 0;

    var_3 = _func_1E9(var_2, self.team, 1, "enemy_predict", ">", 0);

    if(!isDefined(var_3))
      return 0;

    var_4 = _func_0B8(self.origin, 500, 0);

    if(var_4.size <= 0)
      return 0;

    var_5 = self _meth_8366(var_4, var_4.size * 0.15, "node_hide");

    if(!isDefined(var_5))
      return 0;

    return _id_1AD0(var_1, undefined, undefined, undefined, var_5);
  }

  return 0;
}