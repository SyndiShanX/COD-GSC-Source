/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_strategy.gsc
***********************************************/

bot_defend_get_random_entrance_point_for_current_area() {
  _id_D5B76D1E2CC71B6B = bot_defend_get_precalc_entrances_for_current_area(self.cur_defend_stance);

  if(isDefined(_id_D5B76D1E2CC71B6B) && _id_D5B76D1E2CC71B6B.size > 0)
    return scripts\engine\utility::random(_id_D5B76D1E2CC71B6B).origin;

  return undefined;
}

bot_defend_get_precalc_entrances_for_current_area(stance, _id_FECD5903478D0482) {
  if(isDefined(self.defend_entrance_index))
    return scripts\mp\bots\bots_util::bot_get_entrances_for_stance_and_index(stance, self.defend_entrance_index, _id_FECD5903478D0482);

  return [];
}

bot_get_ambush_trap_item(_id_0D5160E708615340, _id_0D5163E7086159D9, _id_0D5162E7086157A6) {
  if(self botgetdifficultysetting("allowGrenades") == 0)
    return undefined;

  _id_DBF63E06B8CA889A = [];
  _id_DBF63E06B8CA889A[_id_DBF63E06B8CA889A.size] = _id_0D5160E708615340;

  if(isDefined(_id_0D5163E7086159D9))
    _id_DBF63E06B8CA889A[_id_DBF63E06B8CA889A.size] = _id_0D5163E7086159D9;

  if(isDefined(_id_0D5163E7086159D9))
    _id_DBF63E06B8CA889A[_id_DBF63E06B8CA889A.size] = _id_0D5162E7086157A6;

  if(_id_DBF63E06B8CA889A.size == 0)
    return undefined;

  items = self getweaponslistall();
  _id_68939DB9F7B6D3C4 = [];

  foreach(item in items) {
    if(self getweaponammoclip(item) > 0 || self getweaponammostock(item) > 0)
      _id_68939DB9F7B6D3C4[_id_68939DB9F7B6D3C4.size] = item;
  }

  if(_id_68939DB9F7B6D3C4.size <= 0)
    return undefined;

  foreach(_id_6197E9BB77C3052D in _id_DBF63E06B8CA889A) {
    foreach(item in _id_68939DB9F7B6D3C4) {
      if(scripts\mp\bots\bots_util::bot_item_matches_purpose(_id_6197E9BB77C3052D, item)) {
        result["purpose"] = _id_6197E9BB77C3052D;
        _id_3956B7BB38700F0D = self botfirstavailablegrenade("lethal");

        if(isDefined(_id_3956B7BB38700F0D) && item == _id_3956B7BB38700F0D)
          result["item_action"] = "lethal";

        _id_63B63448C8A71B0E = self botfirstavailablegrenade("tactical");

        if(isDefined(_id_63B63448C8A71B0E) && item == _id_63B63448C8A71B0E)
          result["item_action"] = "tactical";

        result["weap_name"] = item;
        return result;
      }
    }
  }
}

bot_set_ambush_trap(_id_A43DC094A51DD46C, ambush_entrances, _id_2C8DEFA46C5DAA22, ambush_yaw, _id_BF5197D9B22A2F5B) {
  self notify("bot_set_ambush_trap");
  self endon("bot_set_ambush_trap");

  if(!isDefined(_id_A43DC094A51DD46C))
    return 0;

  _id_65277EFB57BFEF86 = undefined;

  if(!isDefined(_id_BF5197D9B22A2F5B) && isDefined(ambush_entrances) && ambush_entrances.size > 0) {
    if(!isDefined(_id_2C8DEFA46C5DAA22))
      return 0;

    _id_D0085A48DAE59967 = [];
    fwd = undefined;

    if(isDefined(ambush_yaw))
      fwd = anglesToForward((0, ambush_yaw, 0));

    foreach(_id_0D32078955171127 in ambush_entrances) {
      if(!isDefined(fwd)) {
        _id_D0085A48DAE59967[_id_D0085A48DAE59967.size] = _id_0D32078955171127;
        continue;
      }

      if(distancesquared(_id_0D32078955171127.origin, _id_2C8DEFA46C5DAA22.origin) > 90000) {
        if(vectordot(fwd, vectorNormalize(_id_0D32078955171127.origin - _id_2C8DEFA46C5DAA22.origin)) < 0.4)
          _id_D0085A48DAE59967[_id_D0085A48DAE59967.size] = _id_0D32078955171127;
      }
    }

    if(_id_D0085A48DAE59967.size > 0) {
      _id_65277EFB57BFEF86 = scripts\engine\utility::random(_id_D0085A48DAE59967);
      _id_94E232E9AE9B3161 = getnodesinradius(_id_65277EFB57BFEF86.origin, 300, 50);
      _id_43F671C1B889E061 = [];

      foreach(node in _id_94E232E9AE9B3161) {
        if(!isDefined(node.bot_ambush_end))
          _id_43F671C1B889E061[_id_43F671C1B889E061.size] = node;
      }

      _id_94E232E9AE9B3161 = _id_43F671C1B889E061;
      _id_BF5197D9B22A2F5B = self botnodepick(_id_94E232E9AE9B3161, min(_id_94E232E9AE9B3161.size, 3), "node_trap", _id_2C8DEFA46C5DAA22, _id_65277EFB57BFEF86);
    }
  }

  if(isDefined(_id_BF5197D9B22A2F5B)) {
    yaw = undefined;

    if(_id_A43DC094A51DD46C["purpose"] == "trap_directional" && isDefined(_id_65277EFB57BFEF86)) {
      _id_F5798034F8D40700 = vectortoangles(_id_65277EFB57BFEF86.origin - _id_BF5197D9B22A2F5B.origin);
      yaw = _id_F5798034F8D40700[1];
    }

    if(self bothasscriptgoal() && self botgetscriptgoaltype() != "critical" && self botgetscriptgoaltype() != "tactical")
      self botclearscriptgoal();

    _id_C3C26A607FA95ADC = self botsetscriptgoalnode(_id_BF5197D9B22A2F5B, "guard", yaw);

    if(_id_C3C26A607FA95ADC) {
      result = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

      if(result == "goal") {
        thread scripts\mp\bots\bots_util::bot_force_stance_for_time("stand", 4.0);

        if(!isDefined(self.enemy) || !self botcanseeentity(self.enemy)) {
          thread scripts\mp\bots\bots_util::bot_disable_movement_for_time(4.0);
          offset = (0, 0, 0);

          if(issubstr(_id_A43DC094A51DD46C["weap_name"].basename, "claymore"))
            offset = (0, 0, 55);

          if(isDefined(yaw))
            self botlookatpoint(_id_65277EFB57BFEF86.origin + offset, 3.0, "script_forced");
          else
            self botlookatpoint(self.origin + offset + anglesToForward(self getplayerangles()) * 50, 3.0, "script_forced");

          if(!isDefined(_id_A43DC094A51DD46C["item_action"]))
            _id_A43DC094A51DD46C = bot_get_ambush_trap_item("trap_directional", "trap");

          if(isDefined(_id_A43DC094A51DD46C["item_action"]))
            bot_try_use_ambush_item(_id_A43DC094A51DD46C["item_action"]);

          self.ambush_trap_ent = undefined;
          thread bot_set_ambush_trap_wait_fire("grenade_fire");
          thread bot_set_ambush_trap_wait_fire("missile_fire");
          _id_0CF1441229A2390C = scripts\engine\utility::ter_op(isDefined(_id_A43DC094A51DD46C["purpose"]) && _id_A43DC094A51DD46C["purpose"] == "tacticalinsertion", 6.0, 3.0);
          scripts\engine\utility::waittill_any_timeout_2(_id_0CF1441229A2390C, "missile_fire", "grenade_fire");
          wait 0.05;
          self notify("ambush_trap_ent");

          if(isDefined(self.ambush_trap_ent) && isDefined(_id_A43DC094A51DD46C["purpose"]) && _id_A43DC094A51DD46C["purpose"] == "c4")
            thread bot_watch_manual_detonate(self.ambush_trap_ent, 300);

          self.ambush_trap_ent = undefined;
          wait(randomfloat(0.25));
          self notify("bot_force_stance_for_time");
          self botsetstance("none");
          self switchtoweapon("none");
          self notify("bot_disable_movement_for_time");
          self botsetflag("disable_movement", 0);
          self botlookatpoint(undefined);
        }
      }

      return 1;
    }
  }

  return 0;
}

bot_try_use_ambush_item(button) {
  self endon("grenade_pullback");

  for(;;) {
    self botpressbutton(button);
    wait 0.5;
  }
}

bot_set_ambush_trap_wait_fire(_id_26610181286682D3) {
  self endon("death_or_disconnect");
  self endon("bot_set_ambush_trap");
  self endon("ambush_trap_ent");
  level endon("game_ended");
  self waittill(_id_26610181286682D3, ent);
  self.ambush_trap_ent = ent;
}

bot_watch_manual_detonate(grenade, range) {
  self endon("death_or_disconnect");
  grenade endon("death");
  level endon("game_ended");
  _id_5BF0CCB545DC79B2 = range * range;

  for(;;) {
    if(distancesquared(self.origin, grenade.origin) > _id_5BF0CCB545DC79B2) {
      _id_D393614AE33D3D14 = self getclosestenemysqdist(grenade.origin, 1.0);

      if(_id_D393614AE33D3D14 < _id_5BF0CCB545DC79B2) {
        self botpressbutton("use", 0.25);
        wait 0.5;
        self botpressbutton("use", 0.25);
        return;
      }
    }

    wait(randomfloatrange(0.25, 1.0));
  }
}

bot_capture_point(point, radius, optional_params) {
  thread bot_defend_think(point, radius, "capture", optional_params);
}

bot_capture_zone(point, nodes, _id_9C3B30C72198413E, optional_params) {
  optional_params["capture_trigger"] = _id_9C3B30C72198413E;
  thread bot_defend_think(point, nodes, "capture_zone", optional_params);
}

bot_protect_point(point, radius, optional_params) {
  if(!isDefined(optional_params) || !isDefined(optional_params["min_goal_time"]))
    optional_params["min_goal_time"] = 12;

  if(!isDefined(optional_params) || !isDefined(optional_params["max_goal_time"]))
    optional_params["max_goal_time"] = 18;

  thread bot_defend_think(point, radius, "protect", optional_params);
}

bot_protect_zone(nodes, _id_702E9B4033EA2748, uniqueid, optional_params) {
  if(!isDefined(optional_params) || !isDefined(optional_params["min_goal_time"]))
    optional_params["min_goal_time"] = 12;

  if(!isDefined(optional_params) || !isDefined(optional_params["max_goal_time"]))
    optional_params["max_goal_time"] = 18;

  if(!isDefined(optional_params) || !isDefined(optional_params["random_stance"]))
    optional_params["random_stance"] = 1;

  optional_params["uniqueID"] = uniqueid;
  thread bot_defend_think(_id_702E9B4033EA2748, nodes, "protect_zone", optional_params);
}

bot_patrol_area(point, radius, optional_params) {
  if(!isDefined(optional_params) || !isDefined(optional_params["min_goal_time"]))
    optional_params["min_goal_time"] = 0.0;

  if(!isDefined(optional_params) || !isDefined(optional_params["max_goal_time"]))
    optional_params["max_goal_time"] = 0.01;

  thread bot_defend_think(point, radius, "patrol", optional_params);
}

bot_guard_player(player, radius, optional_params) {
  if(!isDefined(optional_params) || !isDefined(optional_params["min_goal_time"]))
    optional_params["min_goal_time"] = 15;

  if(!isDefined(optional_params) || !isDefined(optional_params["max_goal_time"]))
    optional_params["max_goal_time"] = 20;

  thread bot_defend_think(player, radius, "bodyguard", optional_params);
}

bot_defend_requires_center(_id_89C86E7D10C8ADE0) {
  if(_id_89C86E7D10C8ADE0 == "protect_zone")
    return 0;

  return 1;
}

bot_defend_think(_id_D486D821777BC27C, _id_B73C45408B9CE86B, _id_89C86E7D10C8ADE0, optional_params) {
  self notify("started_bot_defend_think");
  self endon("started_bot_defend_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("defend_stop");
  thread defense_death_monitor();

  if(isDefined(self.bot_defending) || self botgetscriptgoaltype() == "camp")
    self botclearscriptgoal();

  self.bot_defending = 1;
  self.bot_defending_type = _id_89C86E7D10C8ADE0;

  if(_id_89C86E7D10C8ADE0 == "capture_zone") {
    self.bot_defending_radius = undefined;
    self.bot_defending_nodes = _id_B73C45408B9CE86B;
    self.bot_defending_trigger = optional_params["capture_trigger"];
  } else if(_id_89C86E7D10C8ADE0 == "protect_zone") {
    self.bot_defending_radius = undefined;
    self.bot_defending_nodes = _id_B73C45408B9CE86B;
    self.bot_defending_zone_id = optional_params["uniqueID"];
  } else {
    self.bot_defending_radius = _id_B73C45408B9CE86B;
    self.bot_defending_nodes = undefined;
    self.bot_defending_trigger = undefined;
  }

  if(scripts\cp_mp\utility\game_utility::isgameparticipant(_id_D486D821777BC27C)) {
    self.bot_defend_player_guarding = _id_D486D821777BC27C;
    childthread monitor_defend_player();
  } else {
    self.bot_defend_player_guarding = undefined;
    self.bot_defending_center = _id_D486D821777BC27C;
  }

  self botsetstance("none");
  goal_type = undefined;
  _id_E3415F203CC2FB01 = 6;
  _id_D0D2138597DAC82B = 10;
  self.defense_score_flags = [];

  if(isDefined(optional_params)) {
    self.defend_entrance_index = optional_params["entrance_points_index"];
    self.bot_defending_override_origin_node = optional_params["override_origin_node"];

    if(isDefined(optional_params["score_flags"])) {
      if(isarray(optional_params["score_flags"]))
        self.defense_score_flags = optional_params["score_flags"];
      else
        self.defense_score_flags[0] = optional_params["score_flags"];
    }

    if(isDefined(optional_params["override_goal_type"]))
      goal_type = optional_params["override_goal_type"];

    if(isDefined(optional_params["min_goal_time"]))
      _id_E3415F203CC2FB01 = optional_params["min_goal_time"];

    if(isDefined(optional_params["max_goal_time"]))
      _id_D0D2138597DAC82B = optional_params["max_goal_time"];

    if(isDefined(optional_params["override_watch_nodes"]) && optional_params["override_watch_nodes"].size > 0)
      self.defense_override_watch_nodes = optional_params["override_watch_nodes"];

    self.defend_objective_radius = optional_params["objective_radius"];
  }

  if(!isDefined(self.bot_defend_player_guarding) && bot_defend_requires_center(_id_89C86E7D10C8ADE0)) {
    nearest_node = undefined;

    if(isDefined(optional_params) && isDefined(optional_params["nearest_node_to_center"]))
      nearest_node = optional_params["nearest_node_to_center"];

    if(!isDefined(nearest_node) && isDefined(self.bot_defending_override_origin_node))
      nearest_node = self.bot_defending_override_origin_node;

    if(!isDefined(nearest_node) && isDefined(self.bot_defending_trigger) && isDefined(self.bot_defending_trigger.nearest_node))
      nearest_node = self.bot_defending_trigger.nearest_node;

    if(!isDefined(nearest_node))
      nearest_node = getclosestnodeinsight(scripts\mp\bots\bots_util::defend_valid_center());

    if(!isDefined(nearest_node)) {
      _id_1D14FF4F8B8E125B = scripts\mp\bots\bots_util::defend_valid_center();
      nodes = getnodesinradiussorted(_id_1D14FF4F8B8E125B, 256, 0);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < nodes.size; _id_AC0E594AC96AA3A8++) {
        _id_594F44744FB80561 = vectorNormalize(nodes[_id_AC0E594AC96AA3A8].origin - _id_1D14FF4F8B8E125B);
        _id_7FE710B31B2B752D = _id_1D14FF4F8B8E125B + _id_594F44744FB80561 * 15;

        if(sighttracepassed(_id_7FE710B31B2B752D, nodes[_id_AC0E594AC96AA3A8].origin, 0, undefined)) {
          nearest_node = nodes[_id_AC0E594AC96AA3A8];
          break;
        }

        wait 0.05;

        if(sighttracepassed(_id_7FE710B31B2B752D + (0, 0, 55), nodes[_id_AC0E594AC96AA3A8].origin + (0, 0, 55), 0, undefined)) {
          nearest_node = nodes[_id_AC0E594AC96AA3A8];
          break;
        }

        wait 0.05;
      }
    }

    self.node_closest_to_defend_center = nearest_node;
  } else if(isDefined(optional_params) && isDefined(optional_params["nearest_node_to_center"]))
    self.node_closest_to_defend_center = optional_params["nearest_node_to_center"];

  _id_339F8BA30BFE82BC = level.bot_find_defend_node_func[_id_89C86E7D10C8ADE0];

  if(!isDefined(goal_type)) {
    goal_type = "guard";

    if(_id_89C86E7D10C8ADE0 == "capture" || _id_89C86E7D10C8ADE0 == "capture_zone")
      goal_type = "objective";
  }

  _id_81A934C1F7D7E976 = 0;
  _id_33B8D7005A8510CA = 0;

  if(scripts\mp\bots\bots_util::bot_is_capturing()) {
    _id_81A934C1F7D7E976 = 1;
    _id_33B8D7005A8510CA = isDefined(optional_params) && isDefined(optional_params["entrance_points_index"]) && isarray(optional_params["entrance_points_index"]);
  } else if(isDefined(optional_params) && istrue(optional_params["random_stance"])) {
    _id_81A934C1F7D7E976 = 1;
    _id_33B8D7005A8510CA = 1;
  }

  _id_F5096F93A28105B8 = 1;

  if(isDefined(optional_params) && istrue(optional_params["dont_leave_goal_during_combat"]))
    _id_F5096F93A28105B8 = 0;

  if(_id_89C86E7D10C8ADE0 == "protect")
    childthread protect_watch_allies();

  for(;;) {
    self.prev_defend_node = self.cur_defend_node;
    self.cur_defend_node = undefined;
    self.cur_defend_angle_override = undefined;
    self.cur_defend_point_override = undefined;
    self.cur_defend_stance = calculate_defend_stance(_id_81A934C1F7D7E976, _id_33B8D7005A8510CA);
    _id_E7073093C8C51701 = self botgetscriptgoaltype();
    _id_33C1CC1033245F18 = scripts\mp\bots\bots_util::bot_goal_can_override(goal_type, _id_E7073093C8C51701);

    if(!_id_33C1CC1033245F18) {
      wait 0.25;
      continue;
    }

    _id_6462F213110D0C30 = _id_E3415F203CC2FB01;
    _id_9F09525E6F9A8906 = _id_D0D2138597DAC82B;
    _id_78A174EAB45C6C23 = 1;

    if(isDefined(self.defense_investigate_specific_point)) {
      self.cur_defend_point_override = self.defense_investigate_specific_point;
      self.defense_investigate_specific_point = undefined;
      _id_78A174EAB45C6C23 = 0;
      _id_6462F213110D0C30 = 1.0;
      _id_9F09525E6F9A8906 = 2.0;
    } else if(isDefined(self.defense_force_next_node_goal)) {
      self.cur_defend_node = self.defense_force_next_node_goal;
      self.defense_force_next_node_goal = undefined;
    } else {
      if(isDefined(level.aerial_danger_exists_for) && level.aerial_danger_exists_for[self.team]) {
        if(!scripts\engine\utility::array_contains(self.defense_score_flags, "avoid_aerial_enemies"))
          self.defense_score_flags[self.defense_score_flags.size] = "avoid_aerial_enemies";
      }

      self[[_id_339F8BA30BFE82BC]]();
    }

    self botclearscriptgoal();
    result = "";

    if(isDefined(self.cur_defend_node) || isDefined(self.cur_defend_point_override)) {
      if(_id_78A174EAB45C6C23 && scripts\mp\bots\bots_util::bot_is_protecting() && !isPlayer(_id_D486D821777BC27C) && isDefined(self.defend_entrance_index)) {
        _id_A43DC094A51DD46C = bot_get_ambush_trap_item("trap_directional", "trap", "c4");

        if(isDefined(_id_A43DC094A51DD46C)) {
          _id_1C17E70621BB1BBC = scripts\mp\bots\bots_util::bot_get_entrances_for_stance_and_index(undefined, self.defend_entrance_index);
          bot_set_ambush_trap(_id_A43DC094A51DD46C, _id_1C17E70621BB1BBC, self.node_closest_to_defend_center);
        }
      }

      if(isDefined(self.cur_defend_point_override)) {
        yaw = undefined;

        if(isDefined(self.cur_defend_angle_override))
          yaw = self.cur_defend_angle_override[1];

        self botsetscriptgoal(self.cur_defend_point_override, 0, goal_type, yaw, self.defend_objective_radius);
      } else if(!isDefined(self.cur_defend_angle_override))
        self botsetscriptgoalnode(self.cur_defend_node, goal_type, undefined, self.defend_objective_radius);
      else
        self botsetscriptgoalnode(self.cur_defend_node, goal_type, self.cur_defend_angle_override[1], self.defend_objective_radius);

      if(_id_81A934C1F7D7E976) {
        if(!isDefined(self.prev_defend_node) || !isDefined(self.cur_defend_node) || self.prev_defend_node != self.cur_defend_node)
          self botsetstance("none");
      }

      _id_E9392579C4528E6A = self botgetscriptgoal();
      self notify("new_defend_goal");
      scripts\mp\bots\bots_util::watch_nodes_stop();

      if(goal_type == "objective") {
        defense_cautious_approach();
        self botsetawareness(1.0);
        self botsetflag("cautious", 0);
      }

      if(self bothasscriptgoal()) {
        current_goal = self botgetscriptgoal();

        if(scripts\mp\bots\bots_util::bot_vectors_are_equal(current_goal, _id_E9392579C4528E6A))
          result = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(20, "defend_force_node_recalculation");
      }

      if(result == "goal") {
        if(_id_81A934C1F7D7E976)
          self botsetstance(self.cur_defend_stance);

        childthread defense_watch_entrances_at_goal();

        if(_id_78A174EAB45C6C23 && scripts\mp\bots\bots_util::bot_is_protecting() && !isPlayer(_id_D486D821777BC27C) && isDefined(self.defend_entrance_index))
          scripts\mp\bots\bots_personality::bot_try_trap_follower();
      }
    }

    if(result != "goal") {
      time = 0.25;

      if(result == "no_path" && isDefined(self.defend_wait_time_when_no_path))
        time = self.defend_wait_time_when_no_path;

      wait(time);
      continue;
    }

    wait_time = randomfloatrange(_id_6462F213110D0C30, _id_9F09525E6F9A8906);
    result = scripts\engine\utility::waittill_any_timeout_5(wait_time, "node_relinquished", "goal_changed", "script_goal_changed", "defend_force_node_recalculation", "bad_path");

    if((result == "node_relinquished" || result == "bad_path" || result == "goal_changed" || result == "script_goal_changed") && (self.cur_defend_stance == "crouch" || self.cur_defend_stance == "prone"))
      self botsetstance("none");

    if(result == "timeout" && !_id_F5096F93A28105B8)
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time();
  }
}

calculate_defend_stance(_id_81A934C1F7D7E976, _id_97DF6EE9F2FE6188) {
  stance = "stand";

  if(_id_81A934C1F7D7E976) {
    _id_55BB9EC645ADA05C = 100;
    _id_B42989B458B54982 = 0;
    _id_8E7073E75873765A = 0;
    strategy_level = self botgetdifficultysetting("strategyLevel");

    if(strategy_level == 1) {
      _id_55BB9EC645ADA05C = 20;
      _id_B42989B458B54982 = 25;
      _id_8E7073E75873765A = 55;
    } else if(strategy_level >= 2) {
      _id_55BB9EC645ADA05C = 10;
      _id_B42989B458B54982 = 20;
      _id_8E7073E75873765A = 70;
    }

    _id_DC061F521C45D732 = randomint(100);

    if(_id_DC061F521C45D732 < _id_B42989B458B54982)
      stance = "crouch";
    else if(_id_DC061F521C45D732 < _id_B42989B458B54982 + _id_8E7073E75873765A)
      stance = "prone";

    _id_F218C8E9E8858C5E = !isDefined(_id_97DF6EE9F2FE6188) || !_id_97DF6EE9F2FE6188;

    if(_id_F218C8E9E8858C5E && stance == "prone") {
      _id_5FA45BB134AEBC31 = bot_defend_get_precalc_entrances_for_current_area("prone");
      _id_E10E66576540C59E = defend_get_ally_bots_at_zone_for_stance("prone");

      if(_id_E10E66576540C59E.size >= _id_5FA45BB134AEBC31.size)
        stance = "crouch";
    }

    if(_id_F218C8E9E8858C5E && stance == "crouch") {
      _id_297C1279113E2757 = bot_defend_get_precalc_entrances_for_current_area("crouch");
      _id_A4439BF074B564E5 = defend_get_ally_bots_at_zone_for_stance("crouch");

      if(_id_A4439BF074B564E5.size >= _id_297C1279113E2757.size)
        stance = "stand";
    }
  }

  return stance;
}

should_start_cautious_approach_default(_id_44770B14726E7A47) {
  _id_8FA07DC6DC122490 = 1250;
  _id_334D85F434992401 = _id_8FA07DC6DC122490 * _id_8FA07DC6DC122490;

  if(_id_44770B14726E7A47) {
    if(self botgetdifficultysetting("strategyLevel") == 0)
      return 0;

    if(self.bot_defending_type == "capture_zone" && isDefined(self.bot_defending_trigger) && self istouching(self.bot_defending_trigger))
      return 0;

    return distancesquared(self.origin, self.bot_defending_center) > _id_334D85F434992401 * 0.75 * 0.75;
  } else if(self botpursuingscriptgoal() && distancesquared(self.origin, self.bot_defending_center) < _id_334D85F434992401) {
    _id_647B4BB147D18201 = self botgetpathdist();
    return 0 <= _id_647B4BB147D18201 && _id_647B4BB147D18201 <= _id_8FA07DC6DC122490;
  } else
    return 0;
}

setup_investigate_location(node, _id_50C9E9E8712D921D) {
  _id_092045964A16006D = spawnStruct();

  if(isDefined(_id_50C9E9E8712D921D))
    _id_092045964A16006D.origin = _id_50C9E9E8712D921D;
  else
    _id_092045964A16006D.origin = node.origin;

  _id_092045964A16006D.node = node;
  _id_092045964A16006D.frames_visible = 0;
  return _id_092045964A16006D;
}

defense_cautious_approach() {
  self notify("defense_cautious_approach");
  self endon("defense_cautious_approach");
  level endon("game_ended");
  self endon("defend_force_node_recalculation");
  self endon("death_or_disconnect");
  self endon("defend_stop");
  self endon("started_bot_defend_think");

  if(1) {
    return;
  }
  if(![[level.bot_funcs["should_start_cautious_approach"]]](1)) {
    return;
  }
  _id_92230FB89972F06A = self botgetscriptgoal();
  _id_4C3D0077FA7D56EF = self botgetscriptgoalnode();
  _id_45C020BE05608172 = 1;
  _id_CB0DA3AE63287098 = 0.2;
  _id_EEB18C09526831F4 = 0;

  while(_id_45C020BE05608172) {
    wait 0.25;
    _id_EEB18C09526831F4 = _id_EEB18C09526831F4 + 0.25;

    if(!self bothasscriptgoal()) {
      return;
    }
    _id_B2A9A67EB5732E9A = self botgetscriptgoal();

    if(!scripts\mp\bots\bots_util::bot_vectors_are_equal(_id_92230FB89972F06A, _id_B2A9A67EB5732E9A)) {
      return;
    }
    if(_id_EEB18C09526831F4 >= 1.0) {
      current_path = self botgetnodesonpath();

      if(current_path.size == 0) {
        self botclearscriptgoal();
        return;
      }
    }

    _id_CB0DA3AE63287098 = _id_CB0DA3AE63287098 + 0.25;

    if(_id_CB0DA3AE63287098 >= 0.5) {
      _id_CB0DA3AE63287098 = 0.0;

      if([[level.bot_funcs["should_start_cautious_approach"]]](0))
        _id_45C020BE05608172 = 0;
    }
  }

  self botsetawareness(1.8);
  self botsetflag("cautious", 1);
  _id_55D2448DD14FBB1E = self botgetnodesonpath();

  if(!isDefined(_id_55D2448DD14FBB1E) || _id_55D2448DD14FBB1E.size <= 2) {
    return;
  }
  self.locations_to_investigate = [];
  _id_E83C82ADFBDAAFB4 = 1000;

  if(isDefined(level.protect_radius))
    _id_E83C82ADFBDAAFB4 = level.protect_radius;

  _id_51CA426712B96DF5 = _id_E83C82ADFBDAAFB4 * _id_E83C82ADFBDAAFB4;
  _id_B3464EEEBEF71679 = getnodesinradius(self.bot_defending_center, _id_E83C82ADFBDAAFB4, 0, 500);

  if(_id_B3464EEEBEF71679.size <= 0) {
    return;
  }
  _id_8529E9F32CF6579C = 5 + self botgetdifficultysetting("strategyLevel") * 2;
  _id_F570F5D5D761C173 = int(min(_id_8529E9F32CF6579C, _id_B3464EEEBEF71679.size));
  _id_B784196CF6D9C696 = self botnodepickmultiple(_id_B3464EEEBEF71679, 15, _id_F570F5D5D761C173, "node_protect", scripts\mp\bots\bots_util::defend_valid_center(), "ignore_occupancy");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B784196CF6D9C696.size; _id_AC0E594AC96AA3A8++) {
    _id_092045964A16006D = setup_investigate_location(_id_B784196CF6D9C696[_id_AC0E594AC96AA3A8]);
    self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, _id_092045964A16006D);
  }

  _id_C56107E9F1A4E1CD = botgetmemoryevents(0, gettime() - 60000, 1, "death", 0, self);

  foreach(location in _id_C56107E9F1A4E1CD) {
    if(distancesquared(location, self.bot_defending_center) < _id_51CA426712B96DF5) {
      _id_BA8A43C132FA515A = getclosestnodeinsight(location);

      if(isDefined(_id_BA8A43C132FA515A)) {
        _id_092045964A16006D = setup_investigate_location(_id_BA8A43C132FA515A, location);
        self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, _id_092045964A16006D);
      }
    }
  }

  if(isDefined(self.defend_entrance_index)) {
    _id_77EECA99C75956F8 = scripts\mp\bots\bots_util::bot_get_entrances_for_stance_and_index("stand", self.defend_entrance_index);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_77EECA99C75956F8.size; _id_AC0E594AC96AA3A8++) {
      _id_092045964A16006D = setup_investigate_location(_id_77EECA99C75956F8[_id_AC0E594AC96AA3A8]);
      self.locations_to_investigate = scripts\engine\utility::array_add(self.locations_to_investigate, _id_092045964A16006D);
    }
  }

  if(self.locations_to_investigate.size == 0) {
    return;
  }
  childthread monitor_cautious_approach_dangerous_locations();
  goal_type = self botgetscriptgoaltype();
  _id_C8F6ACA9EA35B446 = self botgetscriptgoalRadius();
  _id_1DA81E91AAB37A9B = self botgetscriptgoalyaw();
  wait 0.05;

  for(_id_F51C48051FFCA680 = 1; _id_F51C48051FFCA680 < _id_55D2448DD14FBB1E.size - 2; _id_F51C48051FFCA680++) {
    scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time();
    _id_906D6B682A625FDC = getlinkednodes(_id_55D2448DD14FBB1E[_id_F51C48051FFCA680]);

    if(_id_906D6B682A625FDC.size == 0) {
      continue;
    }
    _id_8594AEB2834C5D66 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_906D6B682A625FDC.size; _id_AC0E594AC96AA3A8++) {
      if(!scripts\engine\utility::within_fov(self.origin, self getplayerangles(), _id_906D6B682A625FDC[_id_AC0E594AC96AA3A8].origin, 0)) {
        continue;
      }
      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < self.locations_to_investigate.size; _id_AC0E5C4AC96AAA41++) {
        location = self.locations_to_investigate[_id_AC0E5C4AC96AAA41];

        if(nodesvisible(location.node, _id_906D6B682A625FDC[_id_AC0E594AC96AA3A8], 1)) {
          _id_8594AEB2834C5D66 = scripts\engine\utility::array_add(_id_8594AEB2834C5D66, _id_906D6B682A625FDC[_id_AC0E594AC96AA3A8]);
          _id_AC0E5C4AC96AAA41 = self.locations_to_investigate.size;
        }
      }
    }

    if(_id_8594AEB2834C5D66.size == 0) {
      continue;
    }
    _id_7E939D9754FB78DE = self botnodepick(_id_8594AEB2834C5D66, 1 + _id_8594AEB2834C5D66.size * 0.15, "node_hide");

    if(isDefined(_id_7E939D9754FB78DE)) {
      _id_724C1907987840A4 = [];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.locations_to_investigate.size; _id_AC0E594AC96AA3A8++) {
        if(nodesvisible(self.locations_to_investigate[_id_AC0E594AC96AA3A8].node, _id_7E939D9754FB78DE, 1)) {
          if(distance2dsquared(self.locations_to_investigate[_id_AC0E594AC96AA3A8].origin, _id_7E939D9754FB78DE.origin) > 3600)
            _id_724C1907987840A4 = scripts\engine\utility::array_add(_id_724C1907987840A4, self.locations_to_investigate[_id_AC0E594AC96AA3A8]);
        }
      }

      self botclearscriptgoal();
      self botsetscriptgoalnode(_id_7E939D9754FB78DE, "critical");
      childthread monitor_cautious_approach_early_out();
      result = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "cautious_approach_early_out");
      self notify("stop_cautious_approach_early_out_monitor");

      if(result == "cautious_approach_early_out") {
        break;
      }

      if(result == "goal") {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_724C1907987840A4.size; _id_AC0E594AC96AA3A8++) {
          if(distance2dsquared(self.origin, _id_724C1907987840A4[_id_AC0E594AC96AA3A8].origin) < 1600) {
            continue;
          }
          for(_id_EEB18C09526831F4 = 0; _id_724C1907987840A4[_id_AC0E594AC96AA3A8].frames_visible < 18 && _id_EEB18C09526831F4 < 3.6; _id_EEB18C09526831F4 = _id_EEB18C09526831F4 + 0.25) {
            self botlookatpoint(_id_724C1907987840A4[_id_AC0E594AC96AA3A8].origin + (0, 0, self getplayerviewheight()), 0.25, "script_search");
            wait 0.25;
          }
        }
      }
    }

    wait 0.05;
  }

  self notify("stop_location_monitoring");
  self botclearscriptgoal();

  if(isDefined(_id_4C3D0077FA7D56EF))
    self botsetscriptgoalnode(_id_4C3D0077FA7D56EF, goal_type, _id_1DA81E91AAB37A9B);
  else
    self botsetscriptgoal(self.cur_defend_point_override, _id_C8F6ACA9EA35B446, goal_type, _id_1DA81E91AAB37A9B);
}

monitor_cautious_approach_early_out() {
  self endon("cautious_approach_early_out");
  self endon("stop_cautious_approach_early_out_monitor");
  _id_82FE1C44F0E59DD5 = undefined;

  if(isDefined(self.bot_defending_radius))
    _id_82FE1C44F0E59DD5 = self.bot_defending_radius * self.bot_defending_radius;
  else if(isDefined(self.bot_defending_nodes)) {
    _id_3432C95D4C01BBFB = bot_capture_zone_get_furthest_distance();
    _id_82FE1C44F0E59DD5 = _id_3432C95D4C01BBFB * _id_3432C95D4C01BBFB;
  }

  wait 0.05;

  for(;;) {
    if(distancesquared(self.origin, self.bot_defending_center) < _id_82FE1C44F0E59DD5)
      self notify("cautious_approach_early_out");

    wait 0.05;
  }
}

monitor_cautious_approach_dangerous_locations() {
  self endon("stop_location_monitoring");
  _id_F3EDCEFBABC5A8F0 = 10000;

  for(;;) {
    _id_F6CBDE8CC73449C9 = self getnearestnode();

    if(isDefined(_id_F6CBDE8CC73449C9)) {
      _id_9230F5246D95A3D6 = self botgetfovdot();

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.locations_to_investigate.size; _id_AC0E594AC96AA3A8++) {
        if(nodesvisible(_id_F6CBDE8CC73449C9, self.locations_to_investigate[_id_AC0E594AC96AA3A8].node, 1)) {
          node_within_fov = scripts\engine\utility::within_fov(self.origin, self getplayerangles(), self.locations_to_investigate[_id_AC0E594AC96AA3A8].origin, _id_9230F5246D95A3D6);
          _id_C9F1DF8D1FD67FDA = !node_within_fov || self.locations_to_investigate[_id_AC0E594AC96AA3A8].frames_visible < 17;

          if(_id_C9F1DF8D1FD67FDA && distancesquared(self.origin, self.locations_to_investigate[_id_AC0E594AC96AA3A8].origin) < _id_F3EDCEFBABC5A8F0) {
            node_within_fov = 1;
            self.locations_to_investigate[_id_AC0E594AC96AA3A8].frames_visible = 18;
          }

          if(node_within_fov) {
            self.locations_to_investigate[_id_AC0E594AC96AA3A8].frames_visible++;

            if(self.locations_to_investigate[_id_AC0E594AC96AA3A8].frames_visible >= 18) {
              self.locations_to_investigate[_id_AC0E594AC96AA3A8] = self.locations_to_investigate[self.locations_to_investigate.size - 1];
              self.locations_to_investigate[self.locations_to_investigate.size - 1] = undefined;
              _id_AC0E594AC96AA3A8--;
            }
          }
        }
      }
    }

    wait 0.05;
  }
}

protect_watch_allies() {
  self notify("protect_watch_allies");
  self endon("protect_watch_allies");
  _id_0CF1DC37D165E2F3 = [];
  _id_1692F8B760B4D6CB = 1050;
  _id_F5B7C9D0D13192E4 = _id_1692F8B760B4D6CB * _id_1692F8B760B4D6CB;
  _id_E83C82ADFBDAAFB4 = 900;

  if(isDefined(level.protect_radius))
    _id_E83C82ADFBDAAFB4 = level.protect_radius;

  for(;;) {
    _id_4FB72B720667636B = gettime();
    _id_A2FDE156132CAD23 = bot_get_teammates_in_radius(self.bot_defending_center, _id_E83C82ADFBDAAFB4);

    foreach(_id_F0EA4030349A33D5 in _id_A2FDE156132CAD23) {
      _id_96A7043372F6F04E = _id_F0EA4030349A33D5.entity_number;

      if(!isDefined(_id_96A7043372F6F04E))
        _id_96A7043372F6F04E = _id_F0EA4030349A33D5 getentitynumber();

      if(!isDefined(_id_0CF1DC37D165E2F3[_id_96A7043372F6F04E]))
        _id_0CF1DC37D165E2F3[_id_96A7043372F6F04E] = _id_4FB72B720667636B - 1;

      if(!isDefined(_id_F0EA4030349A33D5.last_investigation_time))
        _id_F0EA4030349A33D5.last_investigation_time = _id_4FB72B720667636B - 10001;

      if(_id_F0EA4030349A33D5.health == 0 && isDefined(_id_F0EA4030349A33D5.deathtime) && _id_4FB72B720667636B - _id_F0EA4030349A33D5.deathtime < 5000) {
        if(_id_4FB72B720667636B - _id_F0EA4030349A33D5.last_investigation_time > 10000 && _id_4FB72B720667636B > _id_0CF1DC37D165E2F3[_id_96A7043372F6F04E]) {
          if(isDefined(_id_F0EA4030349A33D5.lastattacker) && isDefined(_id_F0EA4030349A33D5.lastattacker.team) && _id_F0EA4030349A33D5.lastattacker.team == scripts\engine\utility::get_enemy_team(self.team)) {
            if(distancesquared(_id_F0EA4030349A33D5.body.origin, self.origin) < _id_F5B7C9D0D13192E4) {
              self botgetimperfectenemyinfo(_id_F0EA4030349A33D5.lastattacker, _id_F0EA4030349A33D5.body.origin);
              _id_56681CCFF326541B = getclosestnodeinsight(_id_F0EA4030349A33D5.body.origin);

              if(isDefined(_id_56681CCFF326541B)) {
                self.defense_investigate_specific_point = _id_56681CCFF326541B.origin;
                self notify("defend_force_node_recalculation");
              }

              _id_F0EA4030349A33D5.last_investigation_time = _id_4FB72B720667636B;
            }

            _id_0CF1DC37D165E2F3[_id_96A7043372F6F04E] = _id_4FB72B720667636B + 10000;
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
    _id_1C17E70621BB1BBC = findentrances(self.origin);
    return _id_1C17E70621BB1BBC;
  }
}

defense_watch_entrances_at_goal() {
  self notify("defense_watch_entrances_at_goal");
  self endon("defense_watch_entrances_at_goal");
  self endon("new_defend_goal");
  self endon("script_goal_changed");
  _id_170E87A3A1E8AF42 = self getnearestnode();
  _id_77EECA99C75956F8 = undefined;

  if(scripts\mp\bots\bots_util::bot_is_capturing()) {
    _id_3C31225BF8CAA5EA = defense_get_initial_entrances();
    _id_77EECA99C75956F8 = [];

    if(isDefined(_id_170E87A3A1E8AF42)) {
      foreach(_id_0D32078955171127 in _id_3C31225BF8CAA5EA) {
        if(nodesvisible(_id_170E87A3A1E8AF42, _id_0D32078955171127, 1))
          _id_77EECA99C75956F8 = scripts\engine\utility::array_add(_id_77EECA99C75956F8, _id_0D32078955171127);
      }
    }

    if(_id_77EECA99C75956F8.size == 0)
      _id_77EECA99C75956F8 = findentrances(self.origin);
  } else if(scripts\mp\bots\bots_util::bot_is_protecting() || scripts\mp\bots\bots_util::bot_is_bodyguarding()) {
    _id_77EECA99C75956F8 = defense_get_initial_entrances();
    currentweapon = self getcurrentweapon();

    if(isDefined(_id_170E87A3A1E8AF42) && !issubstr(currentweapon.basename, "riotshield") && isDefined(self.node_closest_to_defend_center)) {
      if(nodesvisible(_id_170E87A3A1E8AF42, self.node_closest_to_defend_center, 1))
        _id_77EECA99C75956F8 = scripts\engine\utility::array_add(_id_77EECA99C75956F8, self.node_closest_to_defend_center);
    }
  }

  if(isDefined(_id_77EECA99C75956F8)) {
    childthread scripts\mp\bots\bots_util::bot_watch_nodes(_id_77EECA99C75956F8);

    if(scripts\mp\bots\bots_util::bot_is_bodyguarding())
      childthread bot_monitor_watch_entrances_bodyguard();
    else if(isDefined(level.bot_funcs["bot_entrance_update"]))
      self childthread[[level.bot_funcs["bot_entrance_update"]]]();
    else
      childthread bot_monitor_watch_entrances_at_goal();
  }
}

bot_monitor_watch_entrances_at_goal() {
  self notify("bot_monitor_watch_entrances_at_goal");
  self endon("bot_monitor_watch_entrances_at_goal");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");
  self endon("bot_watch_nodes_stop");

  while(!isDefined(self.watch_nodes))
    wait 0.05;

  _id_16DA7E3AFE815065 = level.bot_funcs["get_watch_node_chance"];

  for(;;) {
    _id_CDD3FC13D49055E9 = 0.8;
    _id_8FAD49FEA979715D = 1.0;

    if(scripts\engine\utility::array_contains(self.defense_score_flags, "strict_los")) {
      _id_CDD3FC13D49055E9 = 1.0;
      _id_8FAD49FEA979715D = 0.5;
    }

    if(isDefined(self.node_closest_to_defend_center)) {
      foreach(node in self.watch_nodes) {
        if(node == self.node_closest_to_defend_center) {
          node.watch_node_chance[self.entity_number] = node.watch_node_base_chance[self.entity_number] * _id_CDD3FC13D49055E9;
          continue;
        }

        node.watch_node_chance[self.entity_number] = node.watch_node_base_chance[self.entity_number] * _id_8FAD49FEA979715D;
      }
    }

    _id_9BC4F8E26F7A0AC4 = isDefined(_id_16DA7E3AFE815065);

    if(!_id_9BC4F8E26F7A0AC4)
      prioritize_watch_nodes_toward_enemies(0.5);

    foreach(node in self.watch_nodes) {
      if(_id_9BC4F8E26F7A0AC4) {
        _id_072193E43C2472B8 = self[[_id_16DA7E3AFE815065]](node);
        node.watch_node_chance[self.entity_number] = node.watch_node_chance[self.entity_number] * _id_072193E43C2472B8;
      }

      if(entrance_watched_by_ally(node))
        node.watch_node_chance[self.entity_number] = node.watch_node_chance[self.entity_number] * 0.5;
    }

    wait(randomfloatrange(0.5, 0.75));
  }
}

bot_monitor_watch_entrances_bodyguard() {
  self notify("bot_monitor_watch_entrances_bodyguard");
  self endon("bot_monitor_watch_entrances_bodyguard");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");

  while(!isDefined(self.watch_nodes))
    wait 0.05;

  for(;;) {
    _id_FE3D6FB608E9EED8 = anglesToForward(self.bot_defend_player_guarding getplayerangles()) * (1, 1, 0);
    _id_FE3D6FB608E9EED8 = vectorNormalize(_id_FE3D6FB608E9EED8);

    foreach(node in self.watch_nodes) {
      node.watch_node_chance[self.entity_number] = node.watch_node_base_chance[self.entity_number];
      _id_5AB345E9F27E0DFD = node.origin - self.bot_defend_player_guarding.origin;
      _id_5AB345E9F27E0DFD = vectorNormalize(_id_5AB345E9F27E0DFD);
      _id_0A1CD126B61EABD2 = vectordot(_id_FE3D6FB608E9EED8, _id_5AB345E9F27E0DFD);

      if(_id_0A1CD126B61EABD2 > 0.6)
        node.watch_node_chance[self.entity_number] = node.watch_node_chance[self.entity_number] * 0.33;
      else if(_id_0A1CD126B61EABD2 > 0)
        node.watch_node_chance[self.entity_number] = node.watch_node_chance[self.entity_number] * 0.66;

      if(!entrance_to_enemy_zone(node))
        node.watch_node_chance[self.entity_number] = node.watch_node_chance[self.entity_number] * 0.5;
    }

    wait(randomfloatrange(0.4, 0.6));
  }
}

entrance_to_enemy_zone(_id_0D32078955171127) {
  _id_405DAA810191CBA9 = getnodezone(_id_0D32078955171127);
  _id_0F2ED0B797104FA5 = vectorNormalize(_id_0D32078955171127.origin - self.origin);

  for(z = 0; z < level.zonecount; z++) {
    if(botzonegetcount(z, self.team, "enemy_predict") > 0) {
      if(isDefined(_id_405DAA810191CBA9) && z == _id_405DAA810191CBA9)
        return 1;
      else {
        _id_4AA6951B8641043D = vectorNormalize(getzoneorigin(z) - self.origin);
        dot = vectordot(_id_0F2ED0B797104FA5, _id_4AA6951B8641043D);

        if(dot > 0.2)
          return 1;
      }
    }
  }

  return 0;
}

prioritize_watch_nodes_toward_enemies(_id_B79930868F410231) {
  if(self.watch_nodes.size <= 0) {
    return;
  }
  _id_1D0E74F96199B031 = self.watch_nodes;

  for(z = 0; z < level.zonecount; z++) {
    if(botzonegetcount(z, self.team, "enemy_predict") <= 0) {
      continue;
    }
    if(_id_1D0E74F96199B031.size == 0) {
      break;
    }

    _id_4AA6951B8641043D = vectorNormalize(getzoneorigin(z) - self.origin);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1D0E74F96199B031.size; _id_AC0E594AC96AA3A8++) {
      _id_E5DCBEEC9029AE9F = getnodezone(_id_1D0E74F96199B031[_id_AC0E594AC96AA3A8]);
      _id_A296921504813986 = 0;

      if(isDefined(_id_E5DCBEEC9029AE9F) && z == _id_E5DCBEEC9029AE9F)
        _id_A296921504813986 = 1;
      else {
        _id_A295C00559B01807 = vectorNormalize(_id_1D0E74F96199B031[_id_AC0E594AC96AA3A8].origin - self.origin);
        dot = vectordot(_id_A295C00559B01807, _id_4AA6951B8641043D);

        if(dot > 0.2)
          _id_A296921504813986 = 1;
      }

      if(_id_A296921504813986) {
        _id_1D0E74F96199B031[_id_AC0E594AC96AA3A8].watch_node_chance[self.entity_number] = _id_1D0E74F96199B031[_id_AC0E594AC96AA3A8].watch_node_chance[self.entity_number] * _id_B79930868F410231;
        _id_1D0E74F96199B031[_id_AC0E594AC96AA3A8] = _id_1D0E74F96199B031[_id_1D0E74F96199B031.size - 1];
        _id_1D0E74F96199B031[_id_1D0E74F96199B031.size - 1] = undefined;
        _id_AC0E594AC96AA3A8--;
      }
    }
  }
}

entrance_watched_by_ally(_id_0D32078955171127) {
  if(self.bot_defending_type == "protect_zone")
    _id_A2FDE156132CAD23 = bot_get_teammates_currently_defending_zone(self.bot_defending_zone_id);
  else
    _id_A2FDE156132CAD23 = bot_get_teammates_currently_defending_point(self.bot_defending_center);

  foreach(_id_F0EA4030349A33D5 in _id_A2FDE156132CAD23) {
    if(entrance_watched_by_player(_id_F0EA4030349A33D5, _id_0D32078955171127))
      return 1;
  }

  return 0;
}

entrance_watched_by_player(player, _id_0D32078955171127) {
  _id_70222FBC47330166 = anglesToForward(player getplayerangles());
  _id_5AB345E9F27E0DFD = vectorNormalize(_id_0D32078955171127.origin - player.origin);
  _id_0A1CD126B61EABD2 = vectordot(_id_70222FBC47330166, _id_5AB345E9F27E0DFD);

  if(_id_0A1CD126B61EABD2 > 0.6)
    return 1;

  return 0;
}

bot_get_teammates_currently_defending_zone(_id_5E803928BC35A4D6) {
  _id_33DE4B46D339A890 = [];
  _id_2F7DDC98419E6B67 = bot_get_teammates_in_radius(self.origin, 1000);

  foreach(_id_F0EA4030349A33D5 in _id_2F7DDC98419E6B67) {
    if(!isai(_id_F0EA4030349A33D5) || _id_F0EA4030349A33D5 scripts\mp\bots\bots_util::bot_is_defending() && _id_F0EA4030349A33D5.bot_defending_zone_id == _id_5E803928BC35A4D6)
      _id_33DE4B46D339A890 = scripts\engine\utility::array_add(_id_33DE4B46D339A890, _id_F0EA4030349A33D5);
  }

  return _id_33DE4B46D339A890;
}

bot_get_teammates_currently_defending_point(point, _id_E83C82ADFBDAAFB4) {
  if(!isDefined(_id_E83C82ADFBDAAFB4)) {
    if(isDefined(level.protect_radius))
      _id_E83C82ADFBDAAFB4 = level.protect_radius;
    else
      _id_E83C82ADFBDAAFB4 = 900;
  }

  _id_33DE4B46D339A890 = [];
  _id_2F7DDC98419E6B67 = bot_get_teammates_in_radius(point, _id_E83C82ADFBDAAFB4);

  foreach(_id_F0EA4030349A33D5 in _id_2F7DDC98419E6B67) {
    if(!isai(_id_F0EA4030349A33D5) || _id_F0EA4030349A33D5 scripts\mp\bots\bots_util::bot_is_defending_point(point))
      _id_33DE4B46D339A890 = scripts\engine\utility::array_add(_id_33DE4B46D339A890, _id_F0EA4030349A33D5);
  }

  return _id_33DE4B46D339A890;
}

bot_get_teammates_in_radius(point, _id_E83C82ADFBDAAFB4) {
  _id_51CA426712B96DF5 = _id_E83C82ADFBDAAFB4 * _id_E83C82ADFBDAAFB4;
  _id_2F7DDC98419E6B67 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.participants.size; _id_AC0E594AC96AA3A8++) {
    _id_5ECABDFE40A96663 = level.participants[_id_AC0E594AC96AA3A8];

    if(_id_5ECABDFE40A96663 != self && isDefined(_id_5ECABDFE40A96663.team) && _id_5ECABDFE40A96663.team == self.team && scripts\mp\utility\entity::isteamparticipant(_id_5ECABDFE40A96663)) {
      if(distancesquared(point, _id_5ECABDFE40A96663.origin) < _id_51CA426712B96DF5)
        _id_2F7DDC98419E6B67 = scripts\engine\utility::array_add(_id_2F7DDC98419E6B67, _id_5ECABDFE40A96663);
    }
  }

  return _id_2F7DDC98419E6B67;
}

defense_death_monitor() {
  level endon("game_ended");
  self endon("started_bot_defend_think");
  self endon("defend_stop");
  self endon("disconnect");
  self waittill("death");

  if(isDefined(self))
    thread bot_defend_stop();
}

bot_defend_stop() {
  self notify("defend_stop");
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
  self botsetstance("none");
}

defend_get_ally_bots_at_zone_for_stance(stance) {
  _id_A59D5599D9E0EE09 = [];

  foreach(_id_5ECABDFE40A96663 in level.participants) {
    if(!isDefined(_id_5ECABDFE40A96663.team)) {
      continue;
    }
    if(_id_5ECABDFE40A96663.team == self.team && _id_5ECABDFE40A96663 != self && isai(_id_5ECABDFE40A96663) && _id_5ECABDFE40A96663 scripts\mp\bots\bots_util::bot_is_defending() && isDefined(_id_5ECABDFE40A96663.cur_defend_stance) && _id_5ECABDFE40A96663.cur_defend_stance == stance) {
      if(_id_5ECABDFE40A96663.bot_defending_type == self.bot_defending_type && scripts\mp\bots\bots_util::bot_is_defending_point(_id_5ECABDFE40A96663.bot_defending_center))
        _id_A59D5599D9E0EE09 = scripts\engine\utility::array_add(_id_A59D5599D9E0EE09, _id_5ECABDFE40A96663);
    }
  }

  return _id_A59D5599D9E0EE09;
}

monitor_defend_player() {
  _id_508CB9269D009E4F = 0;
  _id_578D6AFD11258520 = 175;
  _id_8FCB33318BC2A8B2 = self.bot_defend_player_guarding.origin;
  _id_54F4232FF5F8F4B6 = 0;
  _id_77CC5C586FA6A28D = 0;

  for(;;) {
    if(!isDefined(self.bot_defend_player_guarding))
      thread bot_defend_stop();

    self.bot_defending_center = self.bot_defend_player_guarding.origin;
    self.node_closest_to_defend_center = self.bot_defend_player_guarding getnearestnode();

    if(!isDefined(self.node_closest_to_defend_center))
      self.node_closest_to_defend_center = self getnearestnode();

    if(self botgetscriptgoaltype() != "none") {
      _id_4CBD8AE83804749C = self botgetscriptgoal();
      _id_20D851954EAE02C4 = self.bot_defend_player_guarding getvelocity();
      _id_3519B2425797C239 = lengthsquared(_id_20D851954EAE02C4);

      if(_id_3519B2425797C239 > 100) {
        _id_508CB9269D009E4F = 0;

        if(distancesquared(_id_8FCB33318BC2A8B2, self.bot_defend_player_guarding.origin) > _id_578D6AFD11258520 * _id_578D6AFD11258520) {
          _id_8FCB33318BC2A8B2 = self.bot_defend_player_guarding.origin;
          _id_77CC5C586FA6A28D = 1;
          _id_3B619B88092C2AC0 = vectorNormalize(_id_4CBD8AE83804749C - self.bot_defend_player_guarding.origin);
          _id_F142B39B6F5BE136 = vectorNormalize(_id_20D851954EAE02C4);

          if(vectordot(_id_3B619B88092C2AC0, _id_F142B39B6F5BE136) < 0.1) {
            self notify("defend_force_node_recalculation");
            wait 0.25;
          }
        }
      } else {
        _id_508CB9269D009E4F = _id_508CB9269D009E4F + 0.05;

        if(_id_54F4232FF5F8F4B6 > 100 && _id_77CC5C586FA6A28D) {
          _id_8FCB33318BC2A8B2 = self.bot_defend_player_guarding.origin;
          _id_77CC5C586FA6A28D = 0;
        }

        if(_id_508CB9269D009E4F > 0.5) {
          distsq = distancesquared(_id_4CBD8AE83804749C, self.bot_defending_center);

          if(distsq > self.bot_defending_radius * self.bot_defending_radius) {
            self notify("defend_force_node_recalculation");
            wait 0.25;
          }
        }
      }

      _id_54F4232FF5F8F4B6 = _id_3519B2425797C239;

      if(abs(self.bot_defend_player_guarding.origin[2] - _id_4CBD8AE83804749C[2]) >= 50) {
        self notify("defend_force_node_recalculation");
        wait 0.25;
      }
    }

    wait 0.05;
  }
}

find_defend_node_capture() {
  _id_856840FBFDEDAD5E = bot_defend_get_random_entrance_point_for_current_area();
  node = scripts\mp\bots\bots_util::bot_find_node_to_capture_point(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius, _id_856840FBFDEDAD5E);

  if(isDefined(node)) {
    if(isDefined(_id_856840FBFDEDAD5E)) {
      _id_D70B2C2C937442F6 = vectorNormalize(_id_856840FBFDEDAD5E - node.origin);
      self.cur_defend_angle_override = vectortoangles(_id_D70B2C2C937442F6);
    } else {
      _id_594F44744FB80561 = vectorNormalize(node.origin - scripts\mp\bots\bots_util::defend_valid_center());
      self.cur_defend_angle_override = vectortoangles(_id_594F44744FB80561);
    }

    self.cur_defend_node = node;
  } else if(isDefined(_id_856840FBFDEDAD5E))
    bot_handle_no_valid_defense_node(_id_856840FBFDEDAD5E, undefined);
  else
    bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\bots_util::defend_valid_center());
}

find_defend_node_capture_zone() {
  _id_856840FBFDEDAD5E = bot_defend_get_random_entrance_point_for_current_area();
  node = scripts\mp\bots\bots_util::bot_find_node_to_capture_zone(self.bot_defending_nodes, _id_856840FBFDEDAD5E);

  if(isDefined(node)) {
    if(isDefined(_id_856840FBFDEDAD5E)) {
      _id_D70B2C2C937442F6 = vectorNormalize(_id_856840FBFDEDAD5E - node.origin);
      self.cur_defend_angle_override = vectortoangles(_id_D70B2C2C937442F6);
    } else {
      _id_594F44744FB80561 = vectorNormalize(node.origin - scripts\mp\bots\bots_util::defend_valid_center());
      self.cur_defend_angle_override = vectortoangles(_id_594F44744FB80561);
    }

    self.cur_defend_node = node;
  } else if(isDefined(_id_856840FBFDEDAD5E))
    bot_handle_no_valid_defense_node(_id_856840FBFDEDAD5E, undefined);
  else
    bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\bots_util::defend_valid_center());
}

find_defend_node_protect() {
  node = scripts\mp\bots\bots_util::bot_find_node_that_protects_point(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius);

  if(isDefined(node)) {
    _id_24A70CF44466DAF1 = vectorNormalize(scripts\mp\bots\bots_util::defend_valid_center() - node.origin);
    self.cur_defend_angle_override = vectortoangles(_id_24A70CF44466DAF1);
    self.cur_defend_node = node;
  } else
    bot_handle_no_valid_defense_node(scripts\mp\bots\bots_util::defend_valid_center(), undefined);
}

find_defend_node_protect_zone() {
  node = scripts\mp\bots\bots_util::bot_find_node_to_protect_zone(self.bot_defending_nodes, scripts\mp\bots\bots_util::defend_valid_center());

  if(isDefined(node))
    self.cur_defend_node = node;
  else
    bot_handle_no_valid_defense_node(scripts\mp\bots\bots_util::defend_valid_center(), undefined);
}

find_defend_node_bodyguard() {
  node = scripts\mp\bots\bots_util::bot_find_node_to_guard_player(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius);

  if(isDefined(node))
    self.cur_defend_node = node;
  else {
    _id_B6F1DEB8E946E67C = self getnearestnode();

    if(isDefined(_id_B6F1DEB8E946E67C))
      self.cur_defend_node = _id_B6F1DEB8E946E67C;
    else
      self.cur_defend_point_override = self.origin;
  }
}

find_defend_node_patrol() {
  node = undefined;
  nodes = getnodesinradius(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius, 0);

  if(isDefined(nodes) && nodes.size > 0)
    node = self botnodepick(nodes, 1 + nodes.size * 0.5, "node_traffic");

  if(isDefined(node))
    self.cur_defend_node = node;
  else
    bot_handle_no_valid_defense_node(undefined, scripts\mp\bots\bots_util::defend_valid_center());
}

bot_handle_no_valid_defense_node(_id_B76B361D985E9EFE, _id_1DC58F0A2B0494CD) {
  if(self.bot_defending_type == "protect_zone")
    self.cur_defend_point_override = scripts\engine\utility::random(self.bot_defending_nodes).origin;
  else {
    if(self.bot_defending_type == "capture_zone")
      self.cur_defend_point_override = scripts\mp\bots\bots_util::bot_pick_random_point_from_set(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_nodes, ::bot_can_use_point_in_defend);
    else
      self.cur_defend_point_override = scripts\mp\bots\bots_util::bot_pick_random_point_in_radius(scripts\mp\bots\bots_util::defend_valid_center(), self.bot_defending_radius, ::bot_can_use_point_in_defend, 0.15, 0.9);

    if(isDefined(_id_B76B361D985E9EFE)) {
      _id_0C17DE4A792C4A48 = vectorNormalize(_id_B76B361D985E9EFE - self.cur_defend_point_override);
      self.cur_defend_angle_override = vectortoangles(_id_0C17DE4A792C4A48);
      return;
    }

    if(isDefined(_id_1DC58F0A2B0494CD)) {
      _id_0C17DE4A792C4A48 = vectorNormalize(self.cur_defend_point_override - _id_1DC58F0A2B0494CD);
      self.cur_defend_angle_override = vectortoangles(_id_0C17DE4A792C4A48);
    }
  }
}

bot_can_use_point_in_defend(point) {
  if(bot_check_team_is_using_position(point, 1, 1, 1))
    return 0;

  return 1;
}

bot_check_team_is_using_position(position, _id_A7581D21FFA324D2, _id_393CAA83813956EE, _id_02AD2D07831A9ACD) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.participants.size; _id_AC0E594AC96AA3A8++) {
    _id_5ECABDFE40A96663 = level.participants[_id_AC0E594AC96AA3A8];

    if(isDefined(_id_5ECABDFE40A96663.team) && _id_5ECABDFE40A96663.team == self.team && _id_5ECABDFE40A96663 != self) {
      if(isai(_id_5ECABDFE40A96663)) {
        if(_id_393CAA83813956EE) {
          if(distancesquared(position, _id_5ECABDFE40A96663.origin) < 441)
            return 1;
        }

        if(_id_02AD2D07831A9ACD && _id_5ECABDFE40A96663 bothasscriptgoal()) {
          _id_A0EDD50089B25358 = _id_5ECABDFE40A96663 botgetscriptgoal();

          if(distancesquared(position, _id_A0EDD50089B25358) < 441)
            return 1;
        }

        continue;
      }

      if(_id_A7581D21FFA324D2) {
        if(distancesquared(position, _id_5ECABDFE40A96663.origin) < 441)
          return 1;
      }
    }
  }

  return 0;
}

bot_capture_zone_get_furthest_distance() {
  _id_D0AD688A5D10B8BF = 0;

  if(isDefined(self.bot_defending_nodes)) {
    foreach(node in self.bot_defending_nodes) {
      _id_4FD3127FD90FD6E0 = distance(self.bot_defending_center, node.origin);
      _id_D0AD688A5D10B8BF = max(_id_4FD3127FD90FD6E0, _id_D0AD688A5D10B8BF);
    }
  }

  return _id_D0AD688A5D10B8BF;
}

bot_think_tactical_goals() {
  self notify("bot_think_tactical_goals");
  self endon("bot_think_tactical_goals");
  self endon("bot_suspended");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.tactical_goals = [];
  self.tactical_goal_in_action_thread = 0;

  for(;;) {
    if(self.tactical_goals.size > 0 && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
      _id_19139B636B627D59 = self.tactical_goals[0];

      if(!isDefined(_id_19139B636B627D59.abort)) {
        self notify("start_tactical_goal");

        if(isDefined(_id_19139B636B627D59.start_thread))
          self[[_id_19139B636B627D59.start_thread]](_id_19139B636B627D59);

        childthread watch_goal_aborted(_id_19139B636B627D59);
        goal_type = "tactical";

        if(isDefined(_id_19139B636B627D59.goal_type))
          goal_type = _id_19139B636B627D59.goal_type;

        if(istrue(_id_19139B636B627D59.clear_prev_goal))
          self botclearscriptgoal();

        self botsetscriptgoal(_id_19139B636B627D59.goal_position, _id_19139B636B627D59.goal_radius, goal_type, _id_19139B636B627D59.goal_yaw, _id_19139B636B627D59.objective_radius, _id_19139B636B627D59.short_term_goal);
        result = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "stop_tactical_goal");
        self notify("stop_goal_aborted_watch");

        if(result == "goal") {
          if(isDefined(_id_19139B636B627D59.action_thread)) {
            self.tactical_goal_in_action_thread = 1;
            self[[_id_19139B636B627D59.action_thread]](_id_19139B636B627D59);
            self.tactical_goal_in_action_thread = 0;
          }
        }

        if(result != "script_goal_changed")
          self botclearscriptgoal();

        if(isDefined(_id_19139B636B627D59.end_thread))
          self[[_id_19139B636B627D59.end_thread]](_id_19139B636B627D59);
      }

      self.tactical_goals = scripts\engine\utility::array_remove(self.tactical_goals, _id_19139B636B627D59);
    }

    wait 0.05;
  }
}

watch_goal_aborted(goal) {
  self endon("stop_tactical_goal");
  self endon("stop_goal_aborted_watch");
  wait 0.05;

  for(;;) {
    if(isDefined(goal.abort) || isDefined(goal.should_abort) && self[[goal.should_abort]](goal))
      self notify("stop_tactical_goal");

    wait 0.05;
  }
}

bot_new_tactical_goal(type, goal_position, priority, _id_4F3B05E382BB8C7C) {
  _id_19139B636B627D59 = spawnStruct();
  _id_19139B636B627D59.type = type;
  _id_19139B636B627D59.goal_position = goal_position;

  if(isDefined(self.only_allowable_tactical_goals)) {
    if(!scripts\engine\utility::array_contains(self.only_allowable_tactical_goals, type))
      return;
  }

  _id_19139B636B627D59.priority = priority;
  _id_19139B636B627D59.object = _id_4F3B05E382BB8C7C.object;
  _id_19139B636B627D59.goal_type = _id_4F3B05E382BB8C7C.script_goal_type;
  _id_19139B636B627D59.goal_yaw = _id_4F3B05E382BB8C7C.script_goal_yaw;
  _id_19139B636B627D59.goal_radius = 0;

  if(isDefined(_id_4F3B05E382BB8C7C.script_goal_radius))
    _id_19139B636B627D59.goal_radius = _id_4F3B05E382BB8C7C.script_goal_radius;

  _id_19139B636B627D59.start_thread = _id_4F3B05E382BB8C7C.start_thread;
  _id_19139B636B627D59.end_thread = _id_4F3B05E382BB8C7C.end_thread;
  _id_19139B636B627D59.should_abort = _id_4F3B05E382BB8C7C.should_abort;
  _id_19139B636B627D59.action_thread = _id_4F3B05E382BB8C7C.action_thread;
  _id_19139B636B627D59.objective_radius = _id_4F3B05E382BB8C7C.objective_radius;
  _id_19139B636B627D59.short_term_goal = _id_4F3B05E382BB8C7C.short_term_goal;
  _id_19139B636B627D59.optional_params = _id_4F3B05E382BB8C7C.optional_params;
  _id_19139B636B627D59.clear_prev_goal = _id_4F3B05E382BB8C7C.clear_prev_goal;

  for(_id_B5F8BF1C8EB1626E = 0; _id_B5F8BF1C8EB1626E < self.tactical_goals.size; _id_B5F8BF1C8EB1626E++) {
    if(_id_19139B636B627D59.priority > self.tactical_goals[_id_B5F8BF1C8EB1626E].priority) {
      break;
    }
  }

  for(_id_AC0E594AC96AA3A8 = self.tactical_goals.size - 1; _id_AC0E594AC96AA3A8 >= _id_B5F8BF1C8EB1626E; _id_AC0E594AC96AA3A8--)
    self.tactical_goals[_id_AC0E594AC96AA3A8 + 1] = self.tactical_goals[_id_AC0E594AC96AA3A8];

  self.tactical_goals[_id_B5F8BF1C8EB1626E] = _id_19139B636B627D59;
}

bot_has_tactical_goal(goal_type, object) {
  if(!isDefined(self.tactical_goals))
    return 0;

  if(isDefined(goal_type)) {
    foreach(goal in self.tactical_goals) {
      if(goal.type == goal_type) {
        if(isDefined(object) && isDefined(goal.object))
          return goal.object == object;
        else
          return 1;
      }
    }

    return 0;
  } else
    return self.tactical_goals.size > 0;
}

bot_get_active_tactical_goals_of_type(goal_type) {
  goals = [];

  if(isDefined(self.tactical_goals)) {
    foreach(goal in self.tactical_goals) {
      if(!istrue(goal.abort) && goal.type == goal_type)
        goals[goals.size] = goal;
    }
  }

  return goals;
}

bot_abort_tactical_goal(goal_type, object) {
  if(!isDefined(self.tactical_goals)) {
    return;
  }
  foreach(goal in self.tactical_goals) {
    if(goal.type == goal_type) {
      if(isDefined(object)) {
        if(isDefined(goal.object) && goal.object == object)
          goal.abort = 1;

        continue;
      }

      goal.abort = 1;
    }
  }
}

bot_disable_tactical_goals() {
  self.only_allowable_tactical_goals[0] = "map_interactive_object";

  foreach(goal in self.tactical_goals) {
    if(goal.type != "map_interactive_object")
      goal.abort = 1;
  }
}

bot_enable_tactical_goals() {
  self.only_allowable_tactical_goals = undefined;
}

bot_melee_tactical_insertion_check() {
  _id_64F88D0441939203 = gettime();

  if(!isDefined(self.last_melee_ti_check) || _id_64F88D0441939203 - self.last_melee_ti_check > 1000) {
    self.last_melee_ti_check = _id_64F88D0441939203;
    _id_A43DC094A51DD46C = bot_get_ambush_trap_item("tacticalinsertion");

    if(!isDefined(_id_A43DC094A51DD46C))
      return 0;

    if(isDefined(self.enemy) && self botcanseeentity(self.enemy))
      return 0;

    _id_FE9216675F0EF975 = getzonenearest(self.origin);

    if(!isDefined(_id_FE9216675F0EF975))
      return 0;

    _id_C00C20554CB14554 = botzonenearestcount(_id_FE9216675F0EF975, self.team, 1, "enemy_predict", ">", 0);

    if(!isDefined(_id_C00C20554CB14554))
      return 0;

    _id_C49A42FA6B3F0E0D = getnodesinradius(self.origin, 500, 0);

    if(_id_C49A42FA6B3F0E0D.size <= 0)
      return 0;

    _id_AD6C9F0BEDC9CA15 = self botnodepick(_id_C49A42FA6B3F0E0D, _id_C49A42FA6B3F0E0D.size * 0.15, "node_hide");

    if(!isDefined(_id_AD6C9F0BEDC9CA15))
      return 0;

    return bot_set_ambush_trap(_id_A43DC094A51DD46C, undefined, undefined, undefined, _id_AD6C9F0BEDC9CA15);
  }

  return 0;
}