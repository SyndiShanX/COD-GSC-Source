/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_strategy.gsc
***********************************************/

bot_defend_get_random_entrance_point_for_current_area() {
  var_0 = bot_defend_get_precalc_entrances_for_current_area(self.cur_defend_stance);

  if(isDefined(var_0) && var_0.size > 0)
    return scripts\engine\utility::random(var_0).origin;

  return undefined;
}

bot_defend_get_precalc_entrances_for_current_area(var_0, var_1) {
  if(isDefined(self.defend_entrance_index))
    return scripts\mp\bots\bots_util::bot_get_entrances_for_stance_and_index(var_0, self.defend_entrance_index, var_1);

  return [];
}

bot_get_ambush_trap_item(var_0, var_1, var_2) {
  if(self botgetdifficultysetting("_encstr_8A9B0E47C31DC01387FBDD88AF740362") == 0)
    return undefined;

  var_3 = [];
  var_3[var_3.size] = var_0;

  if(isDefined(var_1))
    var_3[var_3.size] = var_1;

  if(isDefined(var_1))
    var_3[var_3.size] = var_2;

  if(var_3.size == 0)
    return undefined;

  var_4 = self getweaponslistall();
  var_5 = [];

  foreach(var_7 in var_4) {
    if(self getweaponammoclip(var_7) > 0 || self getweaponammostock(var_7) > 0)
      var_5[var_5.size] = var_7;
  }

  if(var_5.size <= 0)
    return undefined;

  foreach(var_10 in var_3) {
    foreach(var_7 in var_5) {
      if(scripts\mp\bots\bots_util::deactivate_laser_from_struct(var_10, var_7)) {
        var_12["_encstr_8B2D08C81BD2B1B89705"] = var_10;
        var_13 = self botfirstavailablegrenade("_encstr_B116071BCAD186858D");

        if(isDefined(var_13) && var_7 == var_13)
          var_12["_encstr_BE2A0C316DF9E7998B587BA250FD"] = "_encstr_B116071BCAD186858D";

        var_14 = self botfirstavailablegrenade("_encstr_99C209E34FC743616118AB");

        if(isDefined(var_14) && var_7 == var_14)
          var_12["_encstr_BE2A0C316DF9E7998B587BA250FD"] = "_encstr_99C209E34FC743616118AB";

        var_12["_encstr_925B0A4318F33257E8AF7575"] = var_7;
        return var_12;
      }
    }
  }
}

bot_set_ambush_trap(var_0, var_1, var_2, var_3, var_4) {
  self notify("_encstr_A20C14B3E70DC1432BABC94EA0108DDBEB6F137B63B7");
  self endon("_encstr_A20C14B3E70DC1432BABC94EA0108DDBEB6F137B63B7");

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
      var_5 = scripts\engine\utility::random(var_6);
      var_11 = getnodesinradius(var_5.origin, 300, 50);
      var_12 = [];

      foreach(var_14 in var_11) {
        if(!isDefined(var_14.bot_ambush_end))
          var_12[var_12.size] = var_14;
      }

      var_11 = var_12;
      var_4 = self botnodepick(var_11, min(var_11.size, 3), "_encstr_93380A9BED232BFAE8391638", var_2, var_5);
    }
  }

  if(isDefined(var_4)) {
    var_16 = undefined;

    if(var_0["_encstr_8B2D08C81BD2B1B89705"] == "_encstr_ADE71199DB51118FEA4A767BAAA4AB852D2E44" && isDefined(var_5)) {
      var_17 = vectortoangles(var_5.origin - var_4.origin);
      var_16 = var_17[1];
    }

    if(self bothasscriptgoal() && self botgetscriptgoaltype() != "_encstr_99CC09DA9020C4ECD149AD" && self botgetscriptgoaltype() != "_encstr_99C209E34FC743616118AB")
      self botclearscriptgoal();

    var_18 = self botsetscriptgoalnode(var_4, "_encstr_AF2206AF7DE90BA7", var_16);

    if(var_18) {
      var_19 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

      if(var_19 == "_encstr_8B7205D9ED5958") {
        thread scripts\mp\bots\bots_util::bot_force_stance_for_time("_encstr_A5AD069B231F0BAF", 4.0);

        if(!isDefined(self.enemy) || !self botcanseeentity(self.enemy)) {
          thread scripts\mp\bots\bots_util::damage_func(4.0);
          var_20 = (0, 0, 0);

          if(issubstr(var_0["_encstr_925B0A4318F33257E8AF7575"].basename, "_encstr_9BD1091BC62CBCB5F6E4CA"))
            var_20 = (0, 0, 55);

          if(isDefined(var_16))
            self botlookatpoint(var_5.origin + var_20, 3.0, "_encstr_A7300E08584D77DBA497CF3FC5432757");
          else
            self botlookatpoint(self.origin + var_20 + anglesToForward(self getplayerangles()) * 50, 3.0, "_encstr_A7300E08584D77DBA497CF3FC5432757");

          if(!isDefined(var_0["_encstr_BE2A0C316DF9E7998B587BA250FD"]))
            var_0 = bot_get_ambush_trap_item("_encstr_ADE71199DB51118FEA4A767BAAA4AB852D2E44", "_encstr_85EF050C9D7062");

          if(isDefined(var_0["_encstr_BE2A0C316DF9E7998B587BA250FD"]))
            debug_chopper_boss(var_0["_encstr_BE2A0C316DF9E7998B587BA250FD"]);

          self.ambush_trap_ent = undefined;
          thread bot_set_ambush_trap_wait_fire("_encstr_9B620D8F0DC07577C551F16A3826BF");
          thread bot_set_ambush_trap_wait_fire("_encstr_ACA30D383847FB93AAFF7705139D4B");
          var_21 = scripts\engine\utility::ter_op(isDefined(var_0["_encstr_8B2D08C81BD2B1B89705"]) && var_0["_encstr_8B2D08C81BD2B1B89705"] == "_encstr_A18312AC2BC2345017F8FB82F6FB896A14333FE3", 6.0, 3.0);
          scripts\engine\utility::_id_143BA(var_21, "_encstr_ACA30D383847FB93AAFF7705139D4B", "_encstr_9B620D8F0DC07577C551F16A3826BF");
          wait 0.05;
          self notify("_encstr_AAC4103F18594B17E0EED50AD9BA8767C8D4");

          if(isDefined(self.ambush_trap_ent) && isDefined(var_0["_encstr_8B2D08C81BD2B1B89705"]) && var_0["_encstr_8B2D08C81BD2B1B89705"] == "_encstr_8B07036CD0")
            thread bot_watch_manual_detonate(self.ambush_trap_ent, 300);

          self.ambush_trap_ent = undefined;
          wait(randomfloat(0.25));
          self notify("_encstr_BD271A11AA8BF860953A87F36FFAB8BFBBC2493EA20FA6716B0993FB");
          self botsetstance("_encstr_8BBA05185F8B99");
          self switchtoweapon("_encstr_8BBA05185F8B99");
          self notify("_encstr_9AA51E26BD1DEB462DCD0B898D56BE5BBD67CAB5CA37A3F5CCED39D7A3D2DACA");
          self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 0);
          self botlookatpoint(undefined);
        }
      }

      return 1;
    }
  }

  return 0;
}

debug_chopper_boss(var_0) {
  self endon("_encstr_B89B11B393CACDC2C859AF8357638D13B08DD6");

  for(;;) {
    self botpressbutton(var_0);
    wait 0.5;
  }
}

bot_set_ambush_trap_wait_fire(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A20C14B3E70DC1432BABC94EA0108DDBEB6F137B63B7");
  self endon("_encstr_AAC4103F18594B17E0EED50AD9BA8767C8D4");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill(var_0, var_1);
  self.ambush_trap_ent = var_1;
}

bot_watch_manual_detonate(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = var_1 * var_1;

  for(;;) {
    if(distancesquared(self.origin, var_0.origin) > var_2) {
      var_3 = self getclosestenemysqdist(var_0.origin, 1.0);

      if(var_3 < var_2) {
        self botpressbutton("_encstr_AB19049D0FC0", 0.25);
        wait 0.5;
        self botpressbutton("_encstr_AB19049D0FC0", 0.25);
        return;
      }
    }

    wait(randomfloatrange(0.25, 1.0));
  }
}

bot_capture_point(var_0, var_1, var_2) {
  thread bot_defend_think(var_0, var_1, "_encstr_95EB0866891B23FB85B3", var_2);
}

bot_capture_zone(var_0, var_1, var_2, var_3) {
  var_3["_encstr_873710FE09A0544B2EDB77D31D5B92BFE0F3"] = var_2;
  thread bot_defend_think(var_0, var_1, "_encstr_9B6F0DD8B0078E5739567DD3BD37CA", var_3);
}

bot_protect_point(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !isDefined(var_2["_encstr_A3350E30CAC5DF89D71141D0FC373063"]))
    var_2["_encstr_A3350E30CAC5DF89D71141D0FC373063"] = 12;

  if(!isDefined(var_2) || !isDefined(var_2["_encstr_82E20ED21780D944E75EF94F139CE05B"]))
    var_2["_encstr_82E20ED21780D944E75EF94F139CE05B"] = 18;

  thread bot_defend_think(var_0, var_1, "_encstr_AF08083BAA57988D729B", var_2);
}

bot_protect_zone(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3) || !isDefined(var_3["_encstr_A3350E30CAC5DF89D71141D0FC373063"]))
    var_3["_encstr_A3350E30CAC5DF89D71141D0FC373063"] = 12;

  if(!isDefined(var_3) || !isDefined(var_3["_encstr_82E20ED21780D944E75EF94F139CE05B"]))
    var_3["_encstr_82E20ED21780D944E75EF94F139CE05B"] = 18;

  if(!isDefined(var_3) || !isDefined(var_3["_encstr_91B40E39C29B23DB5BFA37D1B0CD6C56"]))
    var_3["_encstr_91B40E39C29B23DB5BFA37D1B0CD6C56"] = 1;

  var_3["_encstr_91D409509304BBA70D97DD"] = var_2;
  thread bot_defend_think(var_1, var_0, "_encstr_860B0DE1722558457FAB0E9222730D", var_3);
}

bot_patrol_area(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !isDefined(var_2["_encstr_A3350E30CAC5DF89D71141D0FC373063"]))
    var_2["_encstr_A3350E30CAC5DF89D71141D0FC373063"] = 0.0;

  if(!isDefined(var_2) || !isDefined(var_2["_encstr_82E20ED21780D944E75EF94F139CE05B"]))
    var_2["_encstr_82E20ED21780D944E75EF94F139CE05B"] = 0.01;

  thread bot_defend_think(var_0, var_1, "_encstr_96080730D8534E0A28", var_2);
}

bot_guard_player(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !isDefined(var_2["_encstr_A3350E30CAC5DF89D71141D0FC373063"]))
    var_2["_encstr_A3350E30CAC5DF89D71141D0FC373063"] = 15;

  if(!isDefined(var_2) || !isDefined(var_2["_encstr_82E20ED21780D944E75EF94F139CE05B"]))
    var_2["_encstr_82E20ED21780D944E75EF94F139CE05B"] = 20;

  thread bot_defend_think(var_0, var_1, "_encstr_ADA30A13DE32CB76572CE432", var_2);
}

bot_defend_requires_center(var_0) {
  if(var_0 == "_encstr_860B0DE1722558457FAB0E9222730D")
    return 0;

  return 1;
}

bot_defend_think(var_0, var_1, var_2, var_3) {
  self notify("_encstr_87FA19DCE8B04EE82B91FA317BD1FA46566656DC32AF3A43A5B9D6");
  self endon("_encstr_87FA19DCE8B04EE82B91FA317BD1FA46566656DC32AF3A43A5B9D6");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_81BE0C550DF3C1AD6F8918286282");
  thread defense_death_monitor();

  if(isDefined(self.bot_defending) || self botgetscriptgoaltype() == "_encstr_8F9005D80B6B38")
    self botclearscriptgoal();

  self.bot_defending = 1;
  self.bot_defending_type = var_2;

  if(var_2 == "_encstr_9B6F0DD8B0078E5739567DD3BD37CA") {
    self.bot_defending_radius = undefined;
    self.bot_defending_nodes = var_1;
    self.bot_defending_trigger = var_3["_encstr_873710FE09A0544B2EDB77D31D5B92BFE0F3"];
  } else if(var_2 == "_encstr_860B0DE1722558457FAB0E9222730D") {
    self.bot_defending_radius = undefined;
    self.bot_defending_nodes = var_1;
    self.bot_defending_zone_id = var_3["_encstr_91D409509304BBA70D97DD"];
  } else {
    self.bot_defending_radius = var_1;
    self.bot_defending_nodes = undefined;
    self.bot_defending_trigger = undefined;
  }

  if(scripts\mp\utility\entity::isgameparticipant(var_0)) {
    self.bot_defend_player_guarding = var_0;
    childthread monitor_defend_player();
  } else {
    self.bot_defend_player_guarding = undefined;
    self.bot_defending_center = var_0;
  }

  self botsetstance("_encstr_8BBA05185F8B99");
  var_4 = undefined;
  var_5 = 6;
  var_6 = 10;
  self.defense_score_flags = [];

  if(isDefined(var_3)) {
    self.defend_entrance_index = var_3["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"];
    self.bot_defending_override_origin_node = var_3["_encstr_8D9715A8C35F281DB93F3107FF7268CA83581FF20F8F41"];

    if(isDefined(var_3["_encstr_91F90CB98DBD93B2F533B10BEC9B"])) {
      if(isarray(var_3["_encstr_91F90CB98DBD93B2F533B10BEC9B"]))
        self.defense_score_flags = var_3["_encstr_91F90CB98DBD93B2F533B10BEC9B"];
      else
        self.defense_score_flags[0] = var_3["_encstr_91F90CB98DBD93B2F533B10BEC9B"];
    }

    if(isDefined(var_3["_encstr_A105137B6759274EB4C8B2AFECB78536D7A32F382B"]))
      var_4 = var_3["_encstr_A105137B6759274EB4C8B2AFECB78536D7A32F382B"];

    if(isDefined(var_3["_encstr_A3350E30CAC5DF89D71141D0FC373063"]))
      var_5 = var_3["_encstr_A3350E30CAC5DF89D71141D0FC373063"];

    if(isDefined(var_3["_encstr_82E20ED21780D944E75EF94F139CE05B"]))
      var_6 = var_3["_encstr_82E20ED21780D944E75EF94F139CE05B"];

    if(isDefined(var_3["_encstr_A1BE15DB6759E493961956D7DD0B3A36D0AF73ED9156DC"]) && var_3["_encstr_A1BE15DB6759E493961956D7DD0B3A36D0AF73ED9156DC"].size > 0)
      self.defense_override_watch_nodes = var_3["_encstr_A1BE15DB6759E493961956D7DD0B3A36D0AF73ED9156DC"];

    self.defend_objective_radius = var_3["_encstr_B18E11508A434137EB6AB020E182EBB9E725E6"];
  }

  if(!isDefined(self.bot_defend_player_guarding) && bot_defend_requires_center(var_2)) {
    var_7 = undefined;

    if(isDefined(var_3) && isDefined(var_3["_encstr_856A173AF01B4A47A3FD9FD618290F596908916268ED039FBB"]))
      var_7 = var_3["_encstr_856A173AF01B4A47A3FD9FD618290F596908916268ED039FBB"];

    if(!isDefined(var_7) && isDefined(self.bot_defending_override_origin_node))
      var_7 = self.bot_defending_override_origin_node;

    if(!isDefined(var_7) && isDefined(self.bot_defending_trigger) && isDefined(self.bot_defending_trigger.nearest_node))
      var_7 = self.bot_defending_trigger.nearest_node;

    if(!isDefined(var_7))
      var_7 = getclosestnodeinsight(scripts\mp\bots\bots_util::defend_valid_center());

    if(!isDefined(var_7)) {
      var_8 = scripts\mp\bots\bots_util::defend_valid_center();
      var_9 = getnodesinradiussorted(var_8, 256, 0);

      for(var_10 = 0; var_10 < var_9.size; var_10++) {
        var_11 = vectorNormalize(var_9[var_10].origin - var_8);
        var_12 = var_8 + var_11 * 15;

        if(sighttracepassed(var_12, var_9[var_10].origin, 0, undefined)) {
          var_7 = var_9[var_10];
          break;
        }

        wait 0.05;

        if(sighttracepassed(var_12 + (0, 0, 55), var_9[var_10].origin + (0, 0, 55), 0, undefined)) {
          var_7 = var_9[var_10];
          break;
        }

        wait 0.05;
      }
    }

    self.node_closest_to_defend_center = var_7;
  } else if(isDefined(var_3) && isDefined(var_3["_encstr_856A173AF01B4A47A3FD9FD618290F596908916268ED039FBB"]))
    self.node_closest_to_defend_center = var_3["_encstr_856A173AF01B4A47A3FD9FD618290F596908916268ED039FBB"];

  var_13 = level.bot_find_defend_node_func[var_2];

  if(!isDefined(var_4)) {
    var_4 = "_encstr_AF2206AF7DE90BA7";

    if(var_2 == "_encstr_95EB0866891B23FB85B3" || var_2 == "_encstr_9B6F0DD8B0078E5739567DD3BD37CA")
      var_4 = "_encstr_9A2B0A12F03587575B7BBEA5";
  }

  var_14 = 0;
  var_15 = 0;

  if(scripts\mp\bots\bots_util::bot_is_capturing()) {
    var_14 = 1;
    var_15 = isDefined(var_3) && isDefined(var_3["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"]) && isarray(var_3["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"]);
  } else if(isDefined(var_3) && istrue(var_3["_encstr_91B40E39C29B23DB5BFA37D1B0CD6C56"])) {
    var_14 = 1;
    var_15 = 1;
  }

  var_16 = 1;

  if(isDefined(var_3) && istrue(var_3["_encstr_86A11EC52D1219068477D0605F9F59778A95D05D036BEBE87787F8B007FA5189"]))
    var_16 = 0;

  if(var_2 == "_encstr_AF08083BAA57988D729B")
    childthread protect_watch_allies();

  for(;;) {
    self.prev_defend_node = self.cur_defend_node;
    self.cur_defend_node = undefined;
    self.cur_defend_angle_override = undefined;
    self.cur_defend_point_override = undefined;
    self.cur_defend_stance = calculate_defend_stance(var_14, var_15);
    var_17 = self botgetscriptgoaltype();
    var_18 = scripts\mp\bots\bots_util::bot_goal_can_override(var_4, var_17);

    if(!var_18) {
      wait 0.25;
      continue;
    }

    var_19 = var_5;
    var_20 = var_6;
    var_21 = 1;

    if(isDefined(self.defense_investigate_specific_point)) {
      self.cur_defend_point_override = self.defense_investigate_specific_point;
      self.defense_investigate_specific_point = undefined;
      var_21 = 0;
      var_19 = 1.0;
      var_20 = 2.0;
    } else if(isDefined(self.defense_force_next_node_goal)) {
      self.cur_defend_node = self.defense_force_next_node_goal;
      self.defense_force_next_node_goal = undefined;
    } else {
      if(isDefined(level.aerial_danger_exists_for) && level.aerial_danger_exists_for[self.team]) {
        if(!scripts\engine\utility::array_contains(self.defense_score_flags, "_encstr_8E9715890590B46358D1522B38AF9BE1688D051D53B87A"))
          self.defense_score_flags[self.defense_score_flags.size] = "_encstr_8E9715890590B46358D1522B38AF9BE1688D051D53B87A";
      }

      self[[var_13]]();
    }

    self botclearscriptgoal();
    var_22 = "_encstr_B40101";

    if(isDefined(self.cur_defend_node) || isDefined(self.cur_defend_point_override)) {
      if(var_21 && scripts\mp\bots\bots_util::bot_is_protecting() && !isPlayer(var_0) && isDefined(self.defend_entrance_index)) {
        var_23 = bot_get_ambush_trap_item("_encstr_ADE71199DB51118FEA4A767BAAA4AB852D2E44", "_encstr_85EF050C9D7062", "_encstr_8B07036CD0");

        if(isDefined(var_23)) {
          var_24 = scripts\mp\bots\bots_util::bot_get_entrances_for_stance_and_index(undefined, self.defend_entrance_index);
          bot_set_ambush_trap(var_23, var_24, self.node_closest_to_defend_center);
        }
      }

      if(isDefined(self.cur_defend_point_override)) {
        var_25 = undefined;

        if(isDefined(self.cur_defend_angle_override))
          var_25 = self.cur_defend_angle_override[1];

        self botsetscriptgoal(self.cur_defend_point_override, 0, var_4, var_25, self.defend_objective_radius);
      } else if(!isDefined(self.cur_defend_angle_override))
        self botsetscriptgoalnode(self.cur_defend_node, var_4, undefined, self.defend_objective_radius);
      else
        self botsetscriptgoalnode(self.cur_defend_node, var_4, self.cur_defend_angle_override[1], self.defend_objective_radius);

      if(var_14) {
        if(!isDefined(self.prev_defend_node) || !isDefined(self.cur_defend_node) || self.prev_defend_node != self.cur_defend_node)
          self botsetstance("_encstr_8BBA05185F8B99");
      }

      var_26 = self botgetscriptgoal();
      self notify("_encstr_8AB81035E82F2719A5CF4035311F7ABAD171");
      scripts\mp\bots\bots_util::watch_nodes_stop();

      if(var_4 == "_encstr_9A2B0A12F03587575B7BBEA5") {
        defense_cautious_approach();
        self botsetawareness(1.0);
        self botsetflag("_encstr_839A09C658ABE896DBEA37", 0);
      }

      if(self bothasscriptgoal()) {
        var_27 = self botgetscriptgoal();

        if(scripts\mp\bots\bots_util::bot_vectors_are_equal(var_27, var_26))
          var_22 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(20, "_encstr_9ABE20A97F4E2B1872478D979B6AD589EE55110169A2C8461A93FFBBDB92A5F0B76D");
      }

      if(var_22 == "_encstr_8B7205D9ED5958") {
        if(var_14)
          self botsetstance(self.cur_defend_stance);

        childthread defense_watch_entrances_at_goal();

        if(var_21 && scripts\mp\bots\bots_util::bot_is_protecting() && !isPlayer(var_0) && isDefined(self.defend_entrance_index))
          scripts\mp\bots\bots_personality::bot_try_trap_follower();
      }
    }

    if(var_22 != "_encstr_8B7205D9ED5958") {
      var_28 = 0.25;

      if(var_22 == "_encstr_866D08B0C561870B03FB" && isDefined(self.defend_wait_time_when_no_path))
        var_28 = self.defend_wait_time_when_no_path;

      wait(var_28);
      continue;
    }

    var_29 = randomfloatrange(var_19, var_20);
    var_22 = scripts\engine\utility::_id_143BD(var_29, "_encstr_A3BE12E0F55418981BD79183E373D530FB8C0939", "_encstr_B4E60DB1D2A6C481D9F813A887E0B1", "_encstr_93F9149BD8C92DC18ED7B3EDB0D8BE6C0DB0E6ECB28C", "_encstr_9ABE20A97F4E2B1872478D979B6AD589EE55110169A2C8461A93FFBBDB92A5F0B76D", "_encstr_86E5092BA829F7AB738DA4");

    if((var_22 == "_encstr_A3BE12E0F55418981BD79183E373D530FB8C0939" || var_22 == "_encstr_86E5092BA829F7AB738DA4" || var_22 == "_encstr_B4E60DB1D2A6C481D9F813A887E0B1" || var_22 == "_encstr_93F9149BD8C92DC18ED7B3EDB0D8BE6C0DB0E6ECB28C") && (self.cur_defend_stance == "_encstr_B13D076BED70539F23" || self.cur_defend_stance == "_encstr_922406F1A6FD5E05"))
      self botsetstance("_encstr_8BBA05185F8B99");

    if(var_22 == "_encstr_995408F398012F656821" && !var_16)
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time();
  }
}

calculate_defend_stance(var_0, var_1) {
  var_2 = "_encstr_A5AD069B231F0BAF";

  if(var_0) {
    var_3 = 100;
    var_4 = 0;
    var_5 = 0;
    var_6 = self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592");

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
      var_2 = "_encstr_B13D076BED70539F23";
    else if(var_7 < var_4 + var_5)
      var_2 = "_encstr_922406F1A6FD5E05";

    var_8 = !isDefined(var_1) || !var_1;

    if(var_8 && var_2 == "_encstr_922406F1A6FD5E05") {
      var_9 = bot_defend_get_precalc_entrances_for_current_area("_encstr_922406F1A6FD5E05");
      var_10 = defend_get_ally_bots_at_zone_for_stance("_encstr_922406F1A6FD5E05");

      if(var_10.size >= var_9.size)
        var_2 = "_encstr_B13D076BED70539F23";
    }

    if(var_8 && var_2 == "_encstr_B13D076BED70539F23") {
      var_11 = bot_defend_get_precalc_entrances_for_current_area("_encstr_B13D076BED70539F23");
      var_12 = defend_get_ally_bots_at_zone_for_stance("_encstr_B13D076BED70539F23");

      if(var_12.size >= var_11.size)
        var_2 = "_encstr_A5AD069B231F0BAF";
    }
  }

  return var_2;
}

should_start_cautious_approach_default(var_0) {
  var_1 = 1250;
  var_2 = var_1 * var_1;

  if(var_0) {
    if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") == 0)
      return 0;

    if(self.bot_defending_type == "_encstr_9B6F0DD8B0078E5739567DD3BD37CA" && self istouching(self.bot_defending_trigger))
      return 0;

    return distancesquared(self.origin, self.bot_defending_center) > var_2 * 0.75 * 0.75;
  } else if(self botpursuingscriptgoal() && distancesquared(self.origin, self.bot_defending_center) < var_2) {
    var_3 = self botgetpathdist();
    return 0 <= var_3 && var_3 <= var_1;
  } else
    return 0;
}

setup_investigate_location(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_1))
    var_2.origin = var_1;
  else
    var_2.origin = var_0.origin;

  var_2.node = var_0;
  var_2.frames_visible = 0;
  return var_2;
}

defense_cautious_approach() {
  self notify("_encstr_9B651A8C23D8B74B4E51F13A39A5FB6C38BB132F4310BA7378C9CA92");
  self endon("_encstr_9B651A8C23D8B74B4E51F13A39A5FB6C38BB132F4310BA7378C9CA92");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_9ABE20A97F4E2B1872478D979B6AD589EE55110169A2C8461A93FFBBDB92A5F0B76D");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_81BE0C550DF3C1AD6F8918286282");
  self endon("_encstr_87FA19DCE8B04EE82B91FA317BD1FA46566656DC32AF3A43A5B9D6");

  if(![[level.bot_funcs["_encstr_AA071F6E347B5DD832FA6E4716C9D1EB36B05D3A4BB7EAE6BE16070EE4DBB0D80D"]]](1)) {
    return;
  }
  var_0 = self botgetscriptgoal();
  var_1 = self botgetscriptgoalnode();
  var_2 = 1;
  var_3 = 0.2;
  var_4 = 0;

  while(var_2) {
    wait 0.25;
    var_4 = var_4 + 0.25;

    if(!self bothasscriptgoal()) {
      return;
    }
    var_5 = self botgetscriptgoal();

    if(!scripts\mp\bots\bots_util::bot_vectors_are_equal(var_0, var_5)) {
      return;
    }
    if(var_4 >= 1.0) {
      var_6 = self botgetnodesonpath();

      if(var_6.size == 0) {
        self botclearscriptgoal();
        return;
      }
    }

    var_3 = var_3 + 0.25;

    if(var_3 >= 0.5) {
      var_3 = 0.0;

      if([[level.bot_funcs["_encstr_AA071F6E347B5DD832FA6E4716C9D1EB36B05D3A4BB7EAE6BE16070EE4DBB0D80D"]]](0))
        var_2 = 0;
    }
  }

  self botsetawareness(1.8);
  self botsetflag("_encstr_839A09C658ABE896DBEA37", 1);
  var_7 = self botgetnodesonpath();

  if(!isDefined(var_7) || var_7.size <= 2) {
    return;
  }
  self.locations_to_investigate = [];
  var_8 = 1000;

  if(isDefined(level.protect_radius))
    var_8 = level.protect_radius;

  var_9 = var_8 * var_8;
  var_10 = getnodesinradius(self.bot_defending_center, var_8, 0, 500);

  if(var_10.size <= 0) {
    return;
  }
  var_11 = 5 + self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") * 2;
  var_12 = int(min(var_11, var_10.size));
  var_13 = self botnodepickmultiple(var_10, 15, var_12, "_encstr_AAF90D354088CD51A77D2F5B4BC62B", scripts\mp\bots\bots_util::defend_valid_center(), "_encstr_937711C81FEE909D22B9D0EE8E1BA1194697C0");

  for(var_14 = 0; var_14 < var_13.size; var_14++) {
    var_15 = setup_investigate_location(var_13[var_14]);
    self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, var_15);
  }

  var_16 = botgetmemoryevents(0, gettime() - 60000, 1, "_encstr_AD75063D571AE108", 0, self);

  foreach(var_18 in var_16) {
    if(distancesquared(var_18, self.bot_defending_center) < var_9) {
      var_19 = getclosestnodeinsight(var_18);

      if(isDefined(var_19)) {
        var_15 = setup_investigate_location(var_19, var_18);
        self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, var_15);
      }
    }
  }

  if(isDefined(self.defend_entrance_index)) {
    var_21 = scripts\mp\bots\bots_util::bot_get_entrances_for_stance_and_index("_encstr_A5AD069B231F0BAF", self.defend_entrance_index);

    for(var_14 = 0; var_14 < var_21.size; var_14++) {
      var_15 = setup_investigate_location(var_21[var_14]);
      self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, var_15);
    }
  }

  if(self.locations_to_investigate.size == 0) {
    return;
  }
  childthread monitor_cautious_approach_dangerous_locations();
  var_22 = self botgetscriptgoaltype();
  var_23 = self botgetscriptgoalRadius();
  var_24 = self botgetscriptgoalyaw();
  wait 0.05;

  for(var_25 = 1; var_25 < var_7.size - 2; var_25++) {
    scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time();
    var_26 = getlinkednodes(var_7[var_25]);

    if(var_26.size == 0) {
      continue;
    }
    var_27 = [];

    for(var_14 = 0; var_14 < var_26.size; var_14++) {
      if(!scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var_26[var_14].origin, 0)) {
        continue;
      }
      for(var_28 = 0; var_28 < self.locations_to_investigate.size; var_28++) {
        var_18 = self.locations_to_investigate[var_28];

        if(nodesvisible(var_18.node, var_26[var_14], 1)) {
          var_27 = scripts\engine\utility::array_add(var_27, var_26[var_14]);
          var_28 = self.locations_to_investigate.size;
        }
      }
    }

    if(var_27.size == 0) {
      continue;
    }
    var_29 = self botnodepick(var_27, 1 + var_27.size * 0.15, "_encstr_8E210AB9ED8C56F51AA53259");

    if(isDefined(var_29)) {
      var_30 = [];

      for(var_14 = 0; var_14 < self.locations_to_investigate.size; var_14++) {
        if(nodesvisible(self.locations_to_investigate[var_14].node, var_29, 1)) {
          if(distance2dsquared(self.locations_to_investigate[var_14].origin, var_29.origin) > 3600)
            var_30 = scripts\engine\utility::array_add(var_30, self.locations_to_investigate[var_14]);
        }
      }

      self botclearscriptgoal();
      self botsetscriptgoalnode(var_29, "_encstr_99CC09DA9020C4ECD149AD");
      childthread monitor_cautious_approach_early_out();
      var_31 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "_encstr_8DF81C2218FB13AFE8458BAF57D3135A67A0AA0A81A30E8BA0AB5F87753B");
      self notify("_encstr_BA5429B9D1DB0EFA6C58D54796B7EA6EBE85C13893DE0BD8A1FAB216C9B12FFADE57A37D6BDBE6D2E8B727");

      if(var_31 == "_encstr_8DF81C2218FB13AFE8458BAF57D3135A67A0AA0A81A30E8BA0AB5F87753B") {
        break;
      }

      if(var_31 == "_encstr_8B7205D9ED5958") {
        for(var_14 = 0; var_14 < var_30.size; var_14++) {
          if(distance2dsquared(self.origin, var_30[var_14].origin) < 1600) {
            continue;
          }
          for(var_4 = 0; var_30[var_14].frames_visible < 18 && var_4 < 3.6; var_4 = var_4 + 0.25) {
            self botlookatpoint(var_30[var_14].origin + (0, 0, self getplayerviewheight()), 0.25, "_encstr_87DC0E4B639368ABD51153431A439EE1");
            wait 0.25;
          }
        }
      }
    }

    wait 0.05;
  }

  self notify("_encstr_B2111947082F02E91170529F9D73A8429E38F79D4013C8B64B55CF");
  self botclearscriptgoal();

  if(isDefined(var_1))
    self botsetscriptgoalnode(var_1, var_22, var_24);
  else
    self botsetscriptgoal(self.cur_defend_point_override, var_23, var_22, var_24);
}

monitor_cautious_approach_early_out() {
  self endon("_encstr_8DF81C2218FB13AFE8458BAF57D3135A67A0AA0A81A30E8BA0AB5F87753B");
  self endon("_encstr_BA5429B9D1DB0EFA6C58D54796B7EA6EBE85C13893DE0BD8A1FAB216C9B12FFADE57A37D6BDBE6D2E8B727");
  var_0 = undefined;

  if(isDefined(self.bot_defending_radius))
    var_0 = self.bot_defending_radius * self.bot_defending_radius;
  else if(isDefined(self.bot_defending_nodes)) {
    var_1 = bot_capture_zone_get_furthest_distance();
    var_0 = var_1 * var_1;
  }

  wait 0.05;

  for(;;) {
    if(distancesquared(self.origin, self.bot_defending_center) < var_0)
      self notify("_encstr_8DF81C2218FB13AFE8458BAF57D3135A67A0AA0A81A30E8BA0AB5F87753B");

    wait 0.05;
  }
}

monitor_cautious_approach_dangerous_locations() {
  self endon("_encstr_B2111947082F02E91170529F9D73A8429E38F79D4013C8B64B55CF");
  var_0 = 10000;

  for(;;) {
    var_1 = self getnearestnode();

    if(isDefined(var_1)) {
      var_2 = self botgetfovdot();

      for(var_3 = 0; var_3 < self.locations_to_investigate.size; var_3++) {
        if(nodesvisible(var_1, self.locations_to_investigate[var_3].node, 1)) {
          var_4 = scripts\engine\utility::within_fov(self.origin, self getplayerangles(), self.locations_to_investigate[var_3].origin, var_2);
          var_5 = !var_4 || self.locations_to_investigate[var_3].frames_visible < 17;

          if(var_5 && distancesquared(self.origin, self.locations_to_investigate[var_3].origin) < var_0) {
            var_4 = 1;
            self.locations_to_investigate[var_3].frames_visible = 18;
          }

          if(var_4) {
            self.locations_to_investigate[var_3].frames_visible++;

            if(self.locations_to_investigate[var_3].frames_visible >= 18) {
              self.locations_to_investigate[var_3] = self.locations_to_investigate[self.locations_to_investigate.size - 1];
              self.locations_to_investigate[self.locations_to_investigate.size - 1] = undefined;
              var_3--;
            }
          }
        }
      }
    }

    wait 0.05;
  }
}

protect_watch_allies() {
  self notify("_encstr_BEB515E84BB599D9F7F42834F973C16911C28090924FCF");
  self endon("_encstr_BEB515E84BB599D9F7F42834F973C16911C28090924FCF");
  var_0 = [];
  var_1 = 1050;
  var_2 = var_1 * var_1;
  var_3 = 900;

  if(isDefined(level.protect_radius))
    var_3 = level.protect_radius;

  for(;;) {
    var_4 = gettime();
    var_5 = bot_get_teammates_in_radius(self.bot_defending_center, var_3);

    foreach(var_7 in var_5) {
      var_8 = var_7.entity_number;

      if(!isDefined(var_8))
        var_8 = var_7 getentitynumber();

      if(!isDefined(var_0[var_8]))
        var_0[var_8] = var_4 - 1;

      if(!isDefined(var_7.last_investigation_time))
        var_7.last_investigation_time = var_4 - 10001;

      if(var_7.health == 0 && isDefined(var_7.deathtime) && var_4 - var_7.deathtime < 5000) {
        if(var_4 - var_7.last_investigation_time > 10000 && var_4 > var_0[var_8]) {
          if(isDefined(var_7.lastattacker) && isDefined(var_7.lastattacker.team) && var_7.lastattacker.team == scripts\engine\utility::get_enemy_team(self.team)) {
            if(distancesquared(var_7.body.origin, self.origin) < var_2) {
              self botgetimperfectenemyinfo(var_7.lastattacker, var_7.body.origin);
              var_9 = getclosestnodeinsight(var_7.body.origin);

              if(isDefined(var_9)) {
                self.defense_investigate_specific_point = var_9.origin;
                self notify("_encstr_9ABE20A97F4E2B1872478D979B6AD589EE55110169A2C8461A93FFBBDB92A5F0B76D");
              }

              var_7.last_investigation_time = var_4;
            }

            var_0[var_8] = var_4 + 10000;
          }
        }
      }
    }

    wait((randomint(5) + 1) * 0.05);
  }
}

defense_get_initial_entrances() {
  if(isDefined(self.defense_override_watch_nodes))
    return self.defense_override_watch_nodes;
  else if(scripts\mp\bots\bots_util::bot_is_capturing())
    return bot_defend_get_precalc_entrances_for_current_area(self.cur_defend_stance, 1);
  else if(scripts\mp\bots\bots_util::bot_is_protecting() || scripts\mp\bots\bots_util::bot_is_bodyguarding()) {
    var_0 = findentrances(self.origin);
    return var_0;
  }
}

defense_watch_entrances_at_goal() {
  self notify("_encstr_885F20C8B23359DCE659AFEEC2D1C643D7AC9B8E9CB0E66CACE6D7B03AEBCEED2C63");
  self endon("_encstr_885F20C8B23359DCE659AFEEC2D1C643D7AC9B8E9CB0E66CACE6D7B03AEBCEED2C63");
  self endon("_encstr_8AB81035E82F2719A5CF4035311F7ABAD171");
  self endon("_encstr_93F9149BD8C92DC18ED7B3EDB0D8BE6C0DB0E6ECB28C");
  var_0 = self getnearestnode();
  var_1 = undefined;

  if(scripts\mp\bots\bots_util::bot_is_capturing()) {
    var_2 = defense_get_initial_entrances();
    var_1 = [];

    if(isDefined(var_0)) {
      foreach(var_4 in var_2) {
        if(nodesvisible(var_0, var_4, 1))
          var_1 = scripts\engine\utility::array_add(var_1, var_4);
      }
    }

    if(var_1.size == 0)
      var_1 = findentrances(self.origin);
  } else if(scripts\mp\bots\bots_util::bot_is_protecting() || scripts\mp\bots\bots_util::bot_is_bodyguarding()) {
    var_1 = defense_get_initial_entrances();
    var_6 = self getcurrentweapon();

    if(isDefined(var_0) && !issubstr(var_6.basename, "_encstr_A5450BC280BF4B604068C33187") && isDefined(self.node_closest_to_defend_center)) {
      if(nodesvisible(var_0, self.node_closest_to_defend_center, 1))
        var_1 = scripts\engine\utility::array_add(var_1, self.node_closest_to_defend_center);
    }
  }

  if(isDefined(var_1)) {
    childthread scripts\mp\bots\bots_util::bot_watch_nodes(var_1);

    if(scripts\mp\bots\bots_util::bot_is_bodyguarding())
      childthread bot_monitor_watch_entrances_bodyguard();
    else if(isDefined(level.bot_funcs["_encstr_A2BF1431DE3AAFAC9B1D9C2C373695EBBA1C8CB047AC"]))
      self childthread[[level.bot_funcs["_encstr_A2BF1431DE3AAFAC9B1D9C2C373695EBBA1C8CB047AC"]]]();
    else
      childthread bot_monitor_watch_entrances_at_goal();
  }
}

bot_monitor_watch_entrances_at_goal() {
  self notify("_encstr_8F1E243AC7D1116BC0585159EFB2D6E8C778D6A06737F8931E21387FD5C779596BC6C7A86AF5");
  self endon("_encstr_8F1E243AC7D1116BC0585159EFB2D6E8C778D6A06737F8931E21387FD5C779596BC6C7A86AF5");
  self notify("_encstr_BE8C1CE6208B30D35230A98BC5631E3382E352CB09DA65E3A3389013AF7B");
  self endon("_encstr_BE8C1CE6208B30D35230A98BC5631E3382E352CB09DA65E3A3389013AF7B");
  self endon("_encstr_95F2151237532153F0848E30710542EC27074146CB70DA");

  while(!isDefined(self.watch_nodes))
    wait 0.05;

  var_0 = level.bot_funcs["_encstr_B2E0163B56A3BEEE2CE88DD07D37B7462BF58DA12CB9D8AC"];

  for(;;) {
    var_1 = 0.8;
    var_2 = 1.0;

    if(scripts\engine\utility::array_contains(self.defense_score_flags, "_encstr_850A0BF7D10EA25388CE05CD63")) {
      var_1 = 1.0;
      var_2 = 0.5;
    }

    if(isDefined(self.node_closest_to_defend_center)) {
      foreach(var_4 in self.watch_nodes) {
        if(var_4 == self.node_closest_to_defend_center) {
          var_4.watch_node_chance[self.entity_number] = var_4.watch_node_base_chance[self.entity_number] * var_1;
          continue;
        }

        var_4.watch_node_chance[self.entity_number] = var_4.watch_node_base_chance[self.entity_number] * var_2;
      }
    }

    var_6 = isDefined(var_0);

    if(!var_6)
      prioritize_watch_nodes_toward_enemies(0.5);

    foreach(var_4 in self.watch_nodes) {
      if(var_6) {
        var_8 = self[[var_0]](var_4);
        var_4.watch_node_chance[self.entity_number] = var_4.watch_node_chance[self.entity_number] * var_8;
      }

      if(entrance_watched_by_ally(var_4))
        var_4.watch_node_chance[self.entity_number] = var_4.watch_node_chance[self.entity_number] * 0.5;
    }

    wait(randomfloatrange(0.5, 0.75));
  }
}

bot_monitor_watch_entrances_bodyguard() {
  self notify("_encstr_8EE826A11A3B488805B60321AF2A512417C31968A1D718B89A910507CD528966875AD231EB1F4E70");
  self endon("_encstr_8EE826A11A3B488805B60321AF2A512417C31968A1D718B89A910507CD528966875AD231EB1F4E70");
  self notify("_encstr_BE8C1CE6208B30D35230A98BC5631E3382E352CB09DA65E3A3389013AF7B");
  self endon("_encstr_BE8C1CE6208B30D35230A98BC5631E3382E352CB09DA65E3A3389013AF7B");

  while(!isDefined(self.watch_nodes))
    wait 0.05;

  for(;;) {
    var_0 = anglesToForward(self.bot_defend_player_guarding getplayerangles()) * (1, 1, 0);
    var_0 = vectorNormalize(var_0);

    foreach(var_2 in self.watch_nodes) {
      var_2.watch_node_chance[self.entity_number] = var_2.watch_node_base_chance[self.entity_number];
      var_3 = var_2.origin - self.bot_defend_player_guarding.origin;
      var_3 = vectorNormalize(var_3);
      var_4 = vectordot(var_0, var_3);

      if(var_4 > 0.6)
        var_2.watch_node_chance[self.entity_number] = var_2.watch_node_chance[self.entity_number] * 0.33;
      else if(var_4 > 0)
        var_2.watch_node_chance[self.entity_number] = var_2.watch_node_chance[self.entity_number] * 0.66;

      if(!entrance_to_enemy_zone(var_2))
        var_2.watch_node_chance[self.entity_number] = var_2.watch_node_chance[self.entity_number] * 0.5;
    }

    wait(randomfloatrange(0.4, 0.6));
  }
}

entrance_to_enemy_zone(var_0) {
  var_1 = getnodezone(var_0);
  var_2 = vectorNormalize(var_0.origin - self.origin);

  for(var_3 = 0; var_3 < level.zonecount; var_3++) {
    if(botzonegetcount(var_3, self.team, "_encstr_B2620E4878194F72EE030A77E3BA5EB4") > 0) {
      if(isDefined(var_1) && var_3 == var_1)
        return 1;
      else {
        var_4 = vectorNormalize(getzoneorigin(var_3) - self.origin);
        var_5 = vectordot(var_2, var_4);

        if(var_5 > 0.2)
          return 1;
      }
    }
  }

  return 0;
}

prioritize_watch_nodes_toward_enemies(var_0) {
  if(self.watch_nodes.size <= 0) {
    return;
  }
  var_1 = self.watch_nodes;

  for(var_2 = 0; var_2 < level.zonecount; var_2++) {
    if(botzonegetcount(var_2, self.team, "_encstr_B2620E4878194F72EE030A77E3BA5EB4") <= 0) {
      continue;
    }
    if(var_1.size == 0) {
      break;
    }

    var_3 = vectorNormalize(getzoneorigin(var_2) - self.origin);

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      var_5 = getnodezone(var_1[var_4]);
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
        var_1[var_4].watch_node_chance[self.entity_number] = var_1[var_4].watch_node_chance[self.entity_number] * var_0;
        var_1[var_4] = var_1[var_1.size - 1];
        var_1[var_1.size - 1] = undefined;
        var_4--;
      }
    }
  }
}

entrance_watched_by_ally(var_0) {
  if(self.bot_defending_type == "_encstr_860B0DE1722558457FAB0E9222730D")
    var_1 = bot_get_teammates_currently_defending_zone(self.bot_defending_zone_id);
  else
    var_1 = bot_get_teammates_currently_defending_point(self.bot_defending_center);

  foreach(var_3 in var_1) {
    if(entrance_watched_by_player(var_3, var_0))
      return 1;
  }

  return 0;
}

entrance_watched_by_player(var_0, var_1) {
  var_2 = anglesToForward(var_0 getplayerangles());
  var_3 = vectorNormalize(var_1.origin - var_0.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 > 0.6)
    return 1;

  return 0;
}

bot_get_teammates_currently_defending_zone(var_0) {
  var_1 = [];
  var_2 = bot_get_teammates_in_radius(self.origin, 1000);

  foreach(var_4 in var_2) {
    if(!isai(var_4) || var_4 scripts\mp\bots\bots_util::bot_is_defending() && var_4.bot_defending_zone_id == var_0)
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

bot_get_teammates_currently_defending_point(var_0, var_1) {
  if(!isDefined(var_1)) {
    if(isDefined(level.protect_radius))
      var_1 = level.protect_radius;
    else
      var_1 = 900;
  }

  var_2 = [];
  var_3 = bot_get_teammates_in_radius(var_0, var_1);

  foreach(var_5 in var_3) {
    if(!isai(var_5) || var_5 scripts\mp\bots\bots_util::bot_is_defending_point(var_0))
      var_2 = scripts\engine\utility::array_add(var_2, var_5);
  }

  return var_2;
}

bot_get_teammates_in_radius(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = [];

  for(var_4 = 0; var_4 < level.participants.size; var_4++) {
    var_5 = level.participants[var_4];

    if(var_5 != self && isDefined(var_5.team) && var_5.team == self.team && scripts\mp\utility\entity::isteamparticipant(var_5)) {
      if(distancesquared(var_0, var_5.origin) < var_2)
        var_3 = scripts\engine\utility::array_add(var_3, var_5);
    }
  }

  return var_3;
}

defense_death_monitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_87FA19DCE8B04EE82B91FA317BD1FA46566656DC32AF3A43A5B9D6");
  self endon("_encstr_81BE0C550DF3C1AD6F8918286282");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self))
    thread bot_defend_stop();
}

bot_defend_stop() {
  self notify("_encstr_81BE0C550DF3C1AD6F8918286282");
  self.bot_defending = undefined;
  self.bot_defending_center = undefined;
  self.bot_defending_radius = undefined;
  self.bot_defending_nodes = undefined;
  self.bot_defending_type = undefined;
  self.bot_defending_trigger = undefined;
  self.bot_defending_override_origin_node = undefined;
  self.bot_defend_player_guarding = undefined;
  self.bot_defending_zone_id = undefined;
  self.defense_score_flags = undefined;
  self.node_closest_to_defend_center = undefined;
  self.defense_investigate_specific_point = undefined;
  self.defense_force_next_node_goal = undefined;
  self.defend_objective_radius = undefined;
  self.prev_defend_node = undefined;
  self.cur_defend_node = undefined;
  self.cur_defend_angle_override = undefined;
  self.cur_defend_point_override = undefined;
  self.defend_entrance_index = undefined;
  self.defense_override_watch_nodes = undefined;
  self botclearscriptgoal();
  self botsetstance("_encstr_8BBA05185F8B99");
}

defend_get_ally_bots_at_zone_for_stance(var_0) {
  var_1 = [];

  foreach(var_3 in level.participants) {
    if(!isDefined(var_3.team)) {
      continue;
    }
    if(var_3.team == self.team && var_3 != self && isai(var_3) && var_3 scripts\mp\bots\bots_util::bot_is_defending() && isDefined(var_3.cur_defend_stance) && var_3.cur_defend_stance == var_0) {
      if(var_3.bot_defending_type == self.bot_defending_type && scripts\mp\bots\bots_util::bot_is_defending_point(var_3.bot_defending_center))
        var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  return var_1;
}

monitor_defend_player() {
  var_0 = 0;
  var_1 = 175;
  var_2 = self.bot_defend_player_guarding.origin;
  var_3 = 0;
  var_4 = 0;

  for(;;) {
    if(!isDefined(self.bot_defend_player_guarding))
      thread bot_defend_stop();

    self.bot_defending_center = self.bot_defend_player_guarding.origin;
    self.node_closest_to_defend_center = self.bot_defend_player_guarding getnearestnode();

    if(!isDefined(self.node_closest_to_defend_center))
      self.node_closest_to_defend_center = self getnearestnode();

    if(self botgetscriptgoaltype() != "_encstr_8BBA05185F8B99") {
      var_5 = self botgetscriptgoal();
      var_6 = self.bot_defend_player_guarding getvelocity();
      var_7 = lengthsquared(var_6);

      if(var_7 > 100) {
        var_0 = 0;

        if(distancesquared(var_2, self.bot_defend_player_guarding.origin) > var_1 * var_1) {
          var_2 = self.bot_defend_player_guarding.origin;
          var_4 = 1;
          var_8 = vectorNormalize(var_5 - self.bot_defend_player_guarding.origin);
          var_9 = vectorNormalize(var_6);

          if(vectordot(var_8, var_9) < 0.1) {
            self notify("_encstr_9ABE20A97F4E2B1872478D979B6AD589EE55110169A2C8461A93FFBBDB92A5F0B76D");
            wait 0.25;
          }
        }
      } else {
        var_0 = var_0 + 0.05;

        if(var_3 > 100 && var_4) {
          var_2 = self.bot_defend_player_guarding.origin;
          var_4 = 0;
        }

        if(var_0 > 0.5) {
          var_10 = distancesquared(var_5, self.bot_defending_center);

          if(var_10 > self.bot_defending_radius * self.bot_defending_radius) {
            self notify("_encstr_9ABE20A97F4E2B1872478D979B6AD589EE55110169A2C8461A93FFBBDB92A5F0B76D");
            wait 0.25;
          }
        }
      }

      var_3 = var_7;

      if(abs(self.bot_defend_player_guarding.origin[2] - var_5[2]) >= 50) {
        self notify("_encstr_9ABE20A97F4E2B1872478D979B6AD589EE55110169A2C8461A93FFBBDB92A5F0B76D");
        wait 0.25;
      }
    }

    wait 0.05;
  }
}

find_defend_node_capture() {
  var_0 = bot_defend_get_random_entrance_point_for_current_area();
  var_1 = scripts\mp\bots\bots_util::bot_find_node_to_capture_point(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius, var_0);

  if(isDefined(var_1)) {
    if(isDefined(var_0)) {
      var_2 = vectorNormalize(var_0 - var_1.origin);
      self.cur_defend_angle_override = vectortoangles(var_2);
    } else {
      var_3 = vectorNormalize(var_1.origin - scripts\mp\bots\bots_util::defend_valid_center());
      self.cur_defend_angle_override = vectortoangles(var_3);
    }

    self.cur_defend_node = var_1;
  } else if(isDefined(var_0))
    bot_handle_no_valid_defense_node(var_0, undefined);
  else
    bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\bots_util::defend_valid_center());
}

find_defend_node_capture_zone() {
  var_0 = bot_defend_get_random_entrance_point_for_current_area();
  var_1 = scripts\mp\bots\bots_util::bot_find_node_to_capture_zone(self.bot_defending_nodes, var_0);

  if(isDefined(var_1)) {
    if(isDefined(var_0)) {
      var_2 = vectorNormalize(var_0 - var_1.origin);
      self.cur_defend_angle_override = vectortoangles(var_2);
    } else {
      var_3 = vectorNormalize(var_1.origin - scripts\mp\bots\bots_util::defend_valid_center());
      self.cur_defend_angle_override = vectortoangles(var_3);
    }

    self.cur_defend_node = var_1;
  } else if(isDefined(var_0))
    bot_handle_no_valid_defense_node(var_0, undefined);
  else
    bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\bots_util::defend_valid_center());
}

find_defend_node_protect() {
  var_0 = scripts\mp\bots\bots_util::bot_find_node_that_protects_point(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius);

  if(isDefined(var_0)) {
    var_1 = vectorNormalize(scripts\mp\bots\bots_util::defend_valid_center() - var_0.origin);
    self.cur_defend_angle_override = vectortoangles(var_1);
    self.cur_defend_node = var_0;
  } else
    bot_handle_no_valid_defense_node(scripts\mp\bots\bots_util::defend_valid_center(), undefined);
}

find_defend_node_protect_zone() {
  var_0 = scripts\mp\bots\bots_util::bot_find_node_to_protect_zone(self.bot_defending_nodes, scripts\mp\bots\bots_util::defend_valid_center());

  if(isDefined(var_0))
    self.cur_defend_node = var_0;
  else
    bot_handle_no_valid_defense_node(scripts\mp\bots\bots_util::defend_valid_center(), undefined);
}

find_defend_node_bodyguard() {
  var_0 = scripts\mp\bots\bots_util::bot_find_node_to_guard_player(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius);

  if(isDefined(var_0))
    self.cur_defend_node = var_0;
  else {
    var_1 = self getnearestnode();

    if(isDefined(var_1))
      self.cur_defend_node = var_1;
    else
      self.cur_defend_point_override = self.origin;
  }
}

find_defend_node_patrol() {
  var_0 = undefined;
  var_1 = getnodesinradius(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius, 0);

  if(isDefined(var_1) && var_1.size > 0)
    var_0 = self botnodepick(var_1, 1 + var_1.size * 0.5, "_encstr_BE280DC67788F7CF8DF3D2AA196B67");

  if(isDefined(var_0))
    self.cur_defend_node = var_0;
  else
    bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\bots_util::defend_valid_center());
}

bot_handle_no_valid_defense_node(var_0, var_1) {
  if(self.bot_defending_type == "_encstr_860B0DE1722558457FAB0E9222730D")
    self.cur_defend_point_override = scripts\engine\utility::random(self.bot_defending_nodes).origin;
  else {
    if(self.bot_defending_type == "_encstr_9B6F0DD8B0078E5739567DD3BD37CA")
      self.cur_defend_point_override = scripts\mp\bots\bots_util::bot_pick_random_point_from_set(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_nodes, ::bot_can_use_point_in_defend);
    else
      self.cur_defend_point_override = scripts\mp\bots\bots_util::bot_pick_random_point_in_radius(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius, ::bot_can_use_point_in_defend, 0.15, 0.9);

    if(isDefined(var_0)) {
      var_2 = vectorNormalize(var_0 - self.cur_defend_point_override);
      self.cur_defend_angle_override = vectortoangles(var_2);
      return;
    }

    if(isDefined(var_1)) {
      var_2 = vectorNormalize(self.cur_defend_point_override - var_1);
      self.cur_defend_angle_override = vectortoangles(var_2);
    }
  }
}

bot_can_use_point_in_defend(var_0) {
  if(bot_check_team_is_using_position(var_0, 1, 1, 1))
    return 0;

  return 1;
}

bot_check_team_is_using_position(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < level.participants.size; var_4++) {
    var_5 = level.participants[var_4];

    if(isDefined(var_5.team) && var_5.team == self.team && var_5 != self) {
      if(isai(var_5)) {
        if(var_2) {
          if(distancesquared(var_0, var_5.origin) < 441)
            return 1;
        }

        if(var_3 && var_5 bothasscriptgoal()) {
          var_6 = var_5 botgetscriptgoal();

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

bot_capture_zone_get_furthest_distance() {
  var_0 = 0;

  if(isDefined(self.bot_defending_nodes)) {
    foreach(var_2 in self.bot_defending_nodes) {
      var_3 = distance(self.bot_defending_center, var_2.origin);
      var_0 = max(var_3, var_0);
    }
  }

  return var_0;
}

bot_think_tactical_goals() {
  self notify("_encstr_9B84194CDB1DBE471A5ACD5B7D47166C8E5AB10B63EBB3DE2CB1DC");
  self endon("_encstr_9B84194CDB1DBE471A5ACD5B7D47166C8E5AB10B63EBB3DE2CB1DC");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.tactical_goals = [];
  self._id_13A16 = 0;

  for(;;) {
    if(self.tactical_goals.size > 0 && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
      var_0 = self.tactical_goals[0];

      if(!isDefined(var_0.abort)) {
        self notify("_encstr_917A149B3AC239A3BED1C2D81D968DB01BAF3BDEB08D");

        if(isDefined(var_0.start_thread))
          self[[var_0.start_thread]](var_0);

        childthread watch_goal_aborted(var_0);
        var_1 = "_encstr_99C209E34FC743616118AB";

        if(isDefined(var_0.goal_type))
          var_1 = var_0.goal_type;

        if(istrue(var_0.hastargetmarker))
          self botclearscriptgoal();

        self botsetscriptgoal(var_0.goal_position, var_0.goal_radius, var_1, var_0.goal_yaw, var_0.objective_radius, var_0._id_132B7);
        var_2 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "_encstr_8F9F13C3502FF2976B6FBBA473D137BD27B08A7A38");
        self notify("_encstr_A1B31847BD5DAF9EFA088F5371084AC84A294FB5BF404A35AE9C");

        if(var_2 == "_encstr_8B7205D9ED5958") {
          if(isDefined(var_0.action_thread)) {
            self._id_13A16 = 1;
            self[[var_0.action_thread]](var_0);
            self._id_13A16 = 0;
          }
        }

        if(var_2 != "_encstr_93F9149BD8C92DC18ED7B3EDB0D8BE6C0DB0E6ECB28C")
          self botclearscriptgoal();

        if(isDefined(var_0.end_thread))
          self[[var_0.end_thread]](var_0);
      }

      self.tactical_goals = scripts\engine\utility::array_remove(self.tactical_goals, var_0);
    }

    wait 0.05;
  }
}

watch_goal_aborted(var_0) {
  self endon("_encstr_8F9F13C3502FF2976B6FBBA473D137BD27B08A7A38");
  self endon("_encstr_A1B31847BD5DAF9EFA088F5371084AC84A294FB5BF404A35AE9C");
  wait 0.05;

  for(;;) {
    if(isDefined(var_0.abort) || isDefined(var_0.should_abort) && self[[var_0.should_abort]](var_0))
      self notify("_encstr_8F9F13C3502FF2976B6FBBA473D137BD27B08A7A38");

    wait 0.05;
  }
}

bot_new_tactical_goal(var_0, var_1, var_2, var_3) {
  if(lengthsquared(var_1) == 0)
    var_1 = var_1 + (0, 0, 1);

  var_4 = spawnStruct();
  var_4.type = var_0;
  var_4.goal_position = var_1;

  if(isDefined(self.only_allowable_tactical_goals)) {
    if(!scripts\engine\utility::array_contains(self.only_allowable_tactical_goals, var_0))
      return;
  }

  var_4.priority = var_2;
  var_4.object = var_3.object;
  var_4.goal_type = var_3.script_goal_type;
  var_4.goal_yaw = var_3.script_goal_yaw;
  var_4.goal_radius = 0;

  if(isDefined(var_3.script_goal_radius))
    var_4.goal_radius = var_3.script_goal_radius;

  var_4.start_thread = var_3.start_thread;
  var_4.end_thread = var_3.end_thread;
  var_4.should_abort = var_3.should_abort;
  var_4.action_thread = var_3.action_thread;
  var_4.objective_radius = var_3.objective_radius;
  var_4._id_132B7 = var_3._id_132B7;
  var_4._id_12139 = var_3._id_12139;
  var_4.hastargetmarker = var_3.hastargetmarker;

  for(var_5 = 0; var_5 < self.tactical_goals.size; var_5++) {
    if(var_4.priority > self.tactical_goals[var_5].priority) {
      break;
    }
  }

  for(var_6 = self.tactical_goals.size - 1; var_6 >= var_5; var_6--)
    self.tactical_goals[var_6 + 1] = self.tactical_goals[var_6];

  self.tactical_goals[var_5] = var_4;
}

bot_has_tactical_goal(var_0, var_1) {
  if(!isDefined(self.tactical_goals))
    return 0;

  if(isDefined(var_0)) {
    foreach(var_3 in self.tactical_goals) {
      if(var_3.type == var_0) {
        if(isDefined(var_1) && isDefined(var_3.object))
          return var_3.object == var_1;
        else
          return 1;
      }
    }

    return 0;
  } else
    return self.tactical_goals.size > 0;
}

damageshield_cooldown(var_0) {
  var_1 = [];

  if(isDefined(self.tactical_goals)) {
    foreach(var_3 in self.tactical_goals) {
      if(!istrue(var_3.abort) && var_3.type == var_0)
        var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

bot_abort_tactical_goal(var_0, var_1) {
  if(!isDefined(self.tactical_goals)) {
    return;
  }
  foreach(var_3 in self.tactical_goals) {
    if(var_3.type == var_0) {
      if(isDefined(var_1)) {
        if(isDefined(var_3.object) && var_3.object == var_1)
          var_3.abort = 1;

        continue;
      }

      var_3.abort = 1;
    }
  }
}

bot_disable_tactical_goals() {
  self.only_allowable_tactical_goals[0] = "_encstr_955C17E2190F476430A1352AA3706B27B431594A81EA67DEB8";

  foreach(var_1 in self.tactical_goals) {
    if(var_1.type != "_encstr_955C17E2190F476430A1352AA3706B27B431594A81EA67DEB8")
      var_1.abort = 1;
  }
}

bot_enable_tactical_goals() {
  self.only_allowable_tactical_goals = undefined;
}

bot_melee_tactical_insertion_check() {
  var_0 = gettime();

  if(!isDefined(self.last_melee_ti_check) || var_0 - self.last_melee_ti_check > 1000) {
    self.last_melee_ti_check = var_0;
    var_1 = bot_get_ambush_trap_item("_encstr_A18312AC2BC2345017F8FB82F6FB896A14333FE3");

    if(!isDefined(var_1))
      return 0;

    if(isDefined(self.enemy) && self botcanseeentity(self.enemy))
      return 0;

    var_2 = getzonenearest(self.origin);

    if(!isDefined(var_2))
      return 0;

    var_3 = botzonenearestcount(var_2, self.team, 1, "_encstr_B2620E4878194F72EE030A77E3BA5EB4", "_encstr_834C028F", 0);

    if(!isDefined(var_3))
      return 0;

    var_4 = getnodesinradius(self.origin, 500, 0);

    if(var_4.size <= 0)
      return 0;

    var_5 = self botnodepick(var_4, var_4.size * 0.15, "_encstr_8E210AB9ED8C56F51AA53259");

    if(!isDefined(var_5))
      return 0;

    return bot_set_ambush_trap(var_1, undefined, undefined, undefined, var_5);
  }

  return 0;
}