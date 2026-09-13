/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_sd.gsc
************************************************/

main() {
  setup_callbacks();
  bot_sd_start();
}

setup_callbacks() {
  level.bot_funcs["crate_can_use"] = ::crate_can_use;
  level.bot_funcs["gametype_think"] = ::bot_sd_think;
  level.bot_funcs["should_start_cautious_approach"] = ::should_start_cautious_approach_sd;
  level.bot_funcs["know_enemies_on_start"] = undefined;
  level.bot_funcs["notify_enemy_bots_bomb_used"] = ::notify_enemy_team_bomb_used;

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    level.bot_funcs["player_spawned_gamemode"] = _id_27FDECE778E999D8::_id_5F51C5C13FD2911B;
    level.modifyplayerdamage = _id_27FDECE778E999D8::modifyplayerdamage;
  }
}

bot_sd_start() {
  setup_bot_sd();
}

crate_can_use(crate) {
  if(isagent(self) && !isDefined(crate.boxtype))
    return 0;

  if(!scripts\mp\bots\bots::_id_9BD84CEDE4FE8F24(crate))
    return 0;

  if(!scripts\mp\utility\entity::isteamparticipant(self))
    return 1;

  if(!isDefined(self.role))
    return 0;

  switch (self.role) {
    case "atk_bomber":
    case "investigate_someone_using_bomb":
    case "defuser":
      return 0;
  }

  return 1;
}

setup_bot_sd() {
  level.bots_disable_team_switching = 1;
  level.initial_pickup_wait_time = 3000;
  _id_7F989E71B934C9FC::bot_setup_objective_bottargets();
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  level.bot_sd_override_zone_targets = [];
  level.bot_sd_override_zone_targets["axis"] = [];
  level.bot_sd_override_zone_targets["allies"] = [];
  level.bot_default_sd_role_behavior["atk_bomber"] = ::atk_bomber_update;
  level.bot_default_sd_role_behavior["clear_target_zone"] = ::clear_target_zone_update;
  level.bot_default_sd_role_behavior["defend_planted_bomb"] = ::defend_planted_bomb_update;
  level.bot_default_sd_role_behavior["defuser"] = ::bomb_defuser_update;
  level.bot_default_sd_role_behavior["investigate_someone_using_bomb"] = ::investigate_someone_using_bomb_update;
  level.bot_default_sd_role_behavior["camp_bomb"] = ::camp_bomb_update;
  level.bot_default_sd_role_behavior["defender"] = ::defender_update;
  level.bot_default_sd_role_behavior["backstabber"] = ::backstabber_update;
  level.bot_default_sd_role_behavior["random_killer"] = ::random_killer_update;
  _id_F4B4C81B7E99C586 = _id_7F989E71B934C9FC::bot_verify_and_cache_bombzones(["_a", "_b"]);

  if(_id_F4B4C81B7E99C586) {
    foreach(_id_EEF26A325310D3AF in level.objectives)
    _id_EEF26A325310D3AF thread _id_7F989E71B934C9FC::monitor_bombzone_control();

    thread bot_sd_ai_director_update();
    level.bot_gametype_precaching_done = 1;
  }
}

bot_sd_think() {
  self notify("bot_sd_think");
  self endon("bot_sd_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.has_started_thinking = undefined;

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);
  _id_754FF1A3B4403376 = game["attackers"];
  _id_E96DF5260FDA3EDD = 1;

  if(isDefined(level.sdbomb) && isDefined(level.sdbomb.carrier) && level.sdbomb.carrier == self && isDefined(self.role) && self.role == "atk_bomber")
    _id_E96DF5260FDA3EDD = 0;

  if(_id_E96DF5260FDA3EDD) {
    self.role = undefined;

    if(isDefined(level.atk_bomber) && level.atk_bomber == self)
      level.atk_bomber = undefined;
  }

  self.suspend_sd_role = undefined;
  self.has_started_thinking = 0;
  self.atk_bomber_no_path_to_bomb_count = 0;
  self.scripted_path_style = undefined;
  self.defender_set_script_pathstyle = undefined;
  self.defuser_bad_path_counter = 0;

  if(!isDefined(level.initial_bomb_location) && !level.multibomb) {
    level.initial_bomb_location = level.sdbomb.curorigin;
    level.initial_bomb_location_nearest_node = getclosestnodeinsight(level.sdbomb.curorigin);
  }

  if(self.team == _id_754FF1A3B4403376 && !isDefined(level.can_pickup_bomb_time)) {
    _id_9D5768A33C477288 = 0;

    if(!level.multibomb) {
      players = _id_7F989E71B934C9FC::get_living_players_on_team(_id_754FF1A3B4403376);

      foreach(player in players) {
        if(!isai(player))
          _id_9D5768A33C477288 = 1;
      }
    }

    if(_id_9D5768A33C477288) {
      time = 6000;
      level.can_pickup_bomb_time = gettime() + time;
      badplace_cylinder("bomb", time / 1000, level.sdbomb.curorigin, 75, 300, _id_754FF1A3B4403376);
    }
  }

  for(;;) {
    wait(randomintrange(1, 3) * 0.05);

    if(self.health <= 0) {
      continue;
    }
    self.has_started_thinking = 1;

    if(!isDefined(self.role))
      initialize_sd_role();

    if(isDefined(self.suspend_sd_role)) {
      continue;
    }
    if(self.team == _id_754FF1A3B4403376) {
      if(!level.multibomb && isDefined(level.can_pickup_bomb_time) && gettime() < level.can_pickup_bomb_time && !isDefined(level.sdbomb.carrier)) {
        if(!scripts\mp\bots\bots_util::bot_is_defending_point(level.sdbomb.curorigin)) {
          _id_F67C409A17D1E614 = getclosestnodeinsight(level.sdbomb.curorigin);

          if(isDefined(_id_F67C409A17D1E614)) {
            optional_params["nearest_node_to_center"] = _id_F67C409A17D1E614;
            scripts\mp\bots\bots_strategy::bot_protect_point(level.sdbomb.curorigin, 900, optional_params);
          } else
            level.can_pickup_bomb_time = gettime();
        }
      } else
        self[[level.bot_default_sd_role_behavior[self.role]]]();

      continue;
    }

    if(level.bombplanted) {
      if(isDefined(level.sdbombmodel) && distancesquared(self.origin, level.sdbombmodel.origin) > squared(level.protect_radius * 2)) {
        if(!isDefined(self.defender_set_script_pathstyle)) {
          self.defender_set_script_pathstyle = 1;
          self botsetpathingstyle("scripted");
        }
      } else if(isDefined(self.defender_set_script_pathstyle) && !isDefined(self.scripted_path_style)) {
        self.defender_set_script_pathstyle = undefined;
        self botsetpathingstyle(undefined);
      }
    }

    if(level.bombplanted && isDefined(level.sdbombmodel) && isDefined(level.bomb_defuser) && self.role != "defuser") {
      if(!scripts\mp\bots\bots_util::bot_is_defending_point(level.sdbombmodel.origin)) {
        self botclearscriptgoal();
        scripts\mp\bots\bots_strategy::bot_protect_point(level.sdbombmodel.origin, level.protect_radius);
      }

      continue;
    }

    self[[level.bot_default_sd_role_behavior[self.role]]]();
  }
}

bomber_disable_movement_for_time(time) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self botsetflag("disable_movement", 1);
  self botsetstance("stand");
  wait(time);
  self botsetflag("disable_movement", 0);
  self botsetstance("none");
}

atk_bomber_update() {
  self endon("new_role");

  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();

  if(isDefined(level.sdbomb) && isDefined(level.sdbomb.carrier) && isalive(level.sdbomb.carrier) && level.sdbomb.carrier != self)
    wait 0.7;

  if(!self.isbombcarrier && !level.multibomb) {
    if(level.bombplanted) {
      level.atk_bomber = undefined;
      scripts\mp\bots\bots_strategy::bot_enable_tactical_goals();
      bot_set_role("defend_planted_bomb");
      return;
    }

    if(isDefined(level.sdbomb)) {
      if(!isDefined(self.last_bomb_location))
        self.last_bomb_location = level.sdbomb.curorigin;

      if(distancesquared(self.last_bomb_location, level.sdbomb.curorigin) > 4) {
        self botclearscriptgoal();
        self.last_bomb_location = level.sdbomb.curorigin;
      }
    }

    if(self.atk_bomber_no_path_to_bomb_count >= 2) {
      nodes = getnodesinradiussorted(level.sdbomb.curorigin, 512, 0);
      _id_C03AD507D44DDB40 = undefined;

      foreach(node in nodes) {
        if(!node nodeisdisconnected()) {
          _id_C03AD507D44DDB40 = node;
          break;
        }
      }

      if(isDefined(_id_C03AD507D44DDB40)) {
        self botsetscriptgoal(_id_C03AD507D44DDB40.origin, 20, "critical");
        scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

        if(isDefined(level.sdbomb) && !isDefined(level.sdbomb.carrier))
          level.sdbomb scripts\mp\gameobjects::setpickedup(self);
      } else {}

      return;
    }

    if(!self bothasscriptgoal()) {
      _id_E4C365203906EA25 = 15;
      _id_962D421F44AEA5C4 = 32;
      _id_7F18DDA105927D60 = scripts\mp\bots\bots_util::bot_queued_process("BotGetClosestNavigablePoint", scripts\mp\bots\bots_util::func_bot_get_closest_navigable_point, level.sdbomb.curorigin, _id_E4C365203906EA25 + _id_962D421F44AEA5C4, self);

      if(isDefined(_id_7F18DDA105927D60)) {
        _id_AC5A0E2F2B31FA6B = self botsetscriptgoal(level.sdbomb.curorigin, 0, "critical");

        if(_id_AC5A0E2F2B31FA6B) {
          childthread bomber_monitor_no_path();
          return;
        }
      } else {
        nodes = getnodesinradiussorted(level.sdbomb.curorigin, 512, 0);

        if(nodes.size > 0) {
          self botsetscriptgoal(nodes[0].origin, 0, "critical");
          scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
        }

        if(isDefined(level.sdbomb) && !isDefined(level.sdbomb.carrier)) {
          _id_7F18DDA105927D60 = scripts\mp\bots\bots_util::bot_queued_process("BotGetClosestNavigablePoint", scripts\mp\bots\bots_util::func_bot_get_closest_navigable_point, level.sdbomb.curorigin, _id_E4C365203906EA25 + _id_962D421F44AEA5C4, self);

          if(!isDefined(_id_7F18DDA105927D60))
            level.sdbomb scripts\mp\gameobjects::setpickedup(self);
        }
      }
    }
  } else {
    if(isDefined(self.dont_plant_until_time) && gettime() < self.dont_plant_until_time) {
      return;
    }
    if(!isDefined(level.bomb_zone_assaulting))
      level.bomb_zone_assaulting = scripts\engine\utility::random(level.objectives);

    bombzonegoal = level.bomb_zone_assaulting;
    self.bombzonegoal = bombzonegoal;

    if(!isDefined(level.initial_bomb_pickup_time) || gettime() - level.initial_bomb_pickup_time < level.initial_pickup_wait_time) {
      level.initial_bomb_pickup_time = gettime() + level.initial_pickup_wait_time;
      thread bomber_disable_movement_for_time(level.initial_pickup_wait_time / 1000);
      wait(level.initial_pickup_wait_time / 1000);
    }

    self botclearscriptgoal();

    if(level.attack_behavior == "rush") {
      self botsetpathingstyle("scripted");
      _id_735FD56DB96F509C = _id_7F989E71B934C9FC::get_bombzone_node_to_plant_on(bombzonegoal, 1);
      self botsetscriptgoal(_id_735FD56DB96F509C.origin, 0, "critical");
    }

    _id_2504DA19C43FB0D3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

    if(_id_2504DA19C43FB0D3 == "goal") {
      _id_546BDD6F69FD53E0 = get_round_end_time() - gettime();
      _id_87E36BCBD7AF1D56 = _id_546BDD6F69FD53E0 - level.planttime * 2 * 1000;
      _id_D77E04D8D7105BB0 = gettime() + _id_87E36BCBD7AF1D56;

      if(_id_87E36BCBD7AF1D56 > 0)
        scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(_id_87E36BCBD7AF1D56);

      _id_5B45D81D67839650 = gettime() >= _id_D77E04D8D7105BB0;
      _id_F4B4C81B7E99C586 = _id_7F989E71B934C9FC::bombzone_press_use(level.planttime + 2, "bomb_planted", _id_5B45D81D67839650);
      self botclearscriptgoal();

      if(_id_F4B4C81B7E99C586) {
        scripts\mp\bots\bots_strategy::bot_enable_tactical_goals();
        bot_set_role("defend_planted_bomb");
      } else if(_id_87E36BCBD7AF1D56 > 5000)
        self.dont_plant_until_time = gettime() + 5000;
    }
  }
}

get_round_end_time() {
  if(level.bombplanted)
    return level.defuseendtime;
  else
    return gettime() + scripts\mp\gamelogic::gettimeremaining();
}

bomber_monitor_no_path() {
  self notify("bomber_monitor_no_path");
  self endon("death_or_disconnect");
  self endon("goal");
  self endon("bomber_monitor_no_path");
  level.sdbomb endon("pickup_object");

  for(;;) {
    self waittill("no_path");
    self.atk_bomber_no_path_to_bomb_count++;
  }
}

clear_target_zone_update() {
  self endon("new_role");

  if(isDefined(level.atk_bomber)) {
    if(level.attack_behavior == "rush") {
      if(!isDefined(self.set_initial_rush_goal)) {
        if(!level.multibomb) {
          optional_params["nearest_node_to_center"] = level.initial_bomb_location_nearest_node;
          scripts\mp\bots\bots_strategy::bot_protect_point(level.initial_bomb_location, 900, optional_params);
          wait(randomfloatrange(0.0, 4.0));
          scripts\mp\bots\bots_strategy::bot_defend_stop();
        }

        self.set_initial_rush_goal = 1;
      }

      if(self botgetdifficultysetting("strategyLevel") > 0)
        set_force_sprint();

      if(isai(level.atk_bomber) && isDefined(level.atk_bomber.bombzonegoal))
        _id_65523BEB5C030672 = level.atk_bomber.bombzonegoal;
      else if(isDefined(level.bomb_zone_assaulting))
        _id_65523BEB5C030672 = level.bomb_zone_assaulting;
      else
        _id_65523BEB5C030672 = _id_7F989E71B934C9FC::find_closest_bombzone_to_player(level.atk_bomber);

      if(!scripts\mp\bots\bots_util::bot_is_defending_point(_id_65523BEB5C030672.curorigin)) {
        optional_params["min_goal_time"] = 2;
        optional_params["max_goal_time"] = 4;
        optional_params["override_origin_node"] = scripts\engine\utility::random(_id_65523BEB5C030672.bottargets);
        scripts\mp\bots\bots_strategy::bot_protect_point(_id_65523BEB5C030672.curorigin, level.protect_radius, optional_params);
      }
    }
  }
}

defend_planted_bomb_update() {
  self endon("new_role");

  if(level.bombplanted && isDefined(level.sdbombmodel)) {
    if(level.attack_behavior == "rush")
      disable_force_sprint();

    if(!scripts\mp\bots\bots_util::bot_is_defending_point(level.sdbombmodel.origin)) {
      optional_params["score_flags"] = "strongly_avoid_center";
      scripts\mp\bots\bots_strategy::bot_protect_point(level.sdbombmodel.origin, level.protect_radius, optional_params);
    }
  }
}

bomb_defuser_update() {
  self endon("new_role");

  if(level.bombdefused || !isDefined(level.sdbombmodel)) {
    return;
  }
  zone = find_ticking_bomb();

  if(!isDefined(zone)) {
    return;
  }
  _id_E6CFE3243AA08909 = scripts\engine\utility::get_array_of_closest(level.sdbombmodel.origin, zone.bottargets);
  _id_2FEA4B3D4AAB8868 = (level.sdbombmodel.origin[0], level.sdbombmodel.origin[1], _id_E6CFE3243AA08909[0].origin[2]);

  if(self.defuser_bad_path_counter <= 1)
    _id_B66A59EAC85E4643 = cautious_approach_till_close(_id_2FEA4B3D4AAB8868, undefined);
  else {
    self botclearscriptgoal();
    _id_B66A59EAC85E4643 = self botsetscriptgoal(_id_2FEA4B3D4AAB8868, 20, "critical");
  }

  if(!_id_B66A59EAC85E4643) {
    return;
  }
  _id_2504DA19C43FB0D3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(_id_2504DA19C43FB0D3 == "bad_path") {
    self.defuser_bad_path_counter++;

    if(self.defuser_bad_path_counter >= 4) {
      for(;;) {
        nodes = getnodesinradiussorted(_id_2FEA4B3D4AAB8868, 50, 0);
        _id_27F1AFCF87CA4186 = self.defuser_bad_path_counter - 4;

        if(nodes.size <= _id_27F1AFCF87CA4186) {
          _id_FAE2F8846758E0E9 = botgetclosestnavigablepoint(_id_2FEA4B3D4AAB8868, 50, self);

          if(isDefined(_id_FAE2F8846758E0E9))
            self botsetscriptgoal(_id_FAE2F8846758E0E9, 20, "critical");
          else
            break;
        } else
          self botsetscriptgoal(nodes[_id_27F1AFCF87CA4186].origin, 20, "critical");

        _id_2504DA19C43FB0D3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

        if(_id_2504DA19C43FB0D3 == "bad_path") {
          self.defuser_bad_path_counter++;
          continue;
        }

        break;
      }
    }
  }

  if(_id_2504DA19C43FB0D3 == "goal") {
    _id_546BDD6F69FD53E0 = get_round_end_time() - gettime();
    _id_BAE7D7B60CE8FFC3 = _id_546BDD6F69FD53E0 - level.defusetime * 2 * 1000;
    _id_BB36F4158262888D = gettime() + _id_BAE7D7B60CE8FFC3;

    if(_id_BAE7D7B60CE8FFC3 > 0)
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(_id_BAE7D7B60CE8FFC3);

    _id_8759DC70176704AD = gettime() >= _id_BB36F4158262888D;
    _id_E8376B7B324E07BB = level.sdbombmodel.origin[2] - self.origin[2];
    _id_F4B4C81B7E99C586 = _id_7F989E71B934C9FC::bombzone_press_use(level.defusetime + 2, "bomb_defused", _id_8759DC70176704AD, _id_E8376B7B324E07BB > 40);

    if(!_id_F4B4C81B7E99C586 && self.defuser_bad_path_counter >= 4)
      self.defuser_bad_path_counter++;

    self botclearscriptgoal();
    scripts\mp\bots\bots_strategy::bot_enable_tactical_goals();
  }
}

investigate_someone_using_bomb_update() {
  self endon("new_role");

  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();

  _id_D49D443D41CDC71C = _id_7F989E71B934C9FC::find_closest_bombzone_to_player(self);
  self botsetscriptgoalnode(scripts\engine\utility::random(_id_D49D443D41CDC71C.bottargets), "critical");
  result = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(result == "goal") {
    wait 2;
    bot_set_role(self.prev_role);
  }
}

camp_bomb_update() {
  self endon("new_role");

  if(isDefined(level.sdbomb.carrier)) {
    if(self.prev_role == "defender")
      self.defend_zone = _id_7F989E71B934C9FC::find_closest_bombzone_to_player(self);

    bot_set_role(self.prev_role);
  } else if(!scripts\mp\bots\bots_util::bot_is_defending_point(level.sdbomb.curorigin)) {
    optional_params["nearest_node_to_center"] = level.sdbomb.nearest_node_for_camping;
    scripts\mp\bots\bots_strategy::bot_protect_point(level.sdbomb.curorigin, level.protect_radius, optional_params);
  }
}

defender_update() {
  self endon("new_role");

  if(!scripts\mp\bots\bots_util::bot_is_defending_point(self.defend_zone.curorigin)) {
    optional_params["score_flags"] = "strict_los";
    optional_params["override_origin_node"] = scripts\engine\utility::random(self.defend_zone.bottargets);
    scripts\mp\bots\bots_strategy::bot_protect_point(self.defend_zone.curorigin, level.protect_radius, optional_params);
  }
}

backstabber_update() {
  self endon("new_role");

  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();

  if(!isDefined(self.backstabber_stage))
    self.backstabber_stage = "1_move_to_midpoint";

  if(self.backstabber_stage == "1_move_to_midpoint") {
    _id_7C32B030E8D60F75 = level.objectives["_a"].curorigin;
    _id_0033F217CFBC5D84 = level.objectives["_b"].curorigin;
    midpoint = ((_id_7C32B030E8D60F75[0] + _id_0033F217CFBC5D84[0]) * 0.5, (_id_7C32B030E8D60F75[1] + _id_0033F217CFBC5D84[1]) * 0.5, (_id_7C32B030E8D60F75[2] + _id_0033F217CFBC5D84[2]) * 0.5);
    nodes = getnodesinradiussorted(midpoint, 512, 0);

    if(nodes.size == 0) {
      bot_set_role("random_killer");
      return;
    }

    _id_953F471CA637DD82 = undefined;
    _id_2CABA9D4C386AC23 = int(nodes.size * (nodes.size + 1) * 0.5);
    _id_B7994B0FD923157A = randomint(_id_2CABA9D4C386AC23);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < nodes.size; _id_AC0E594AC96AA3A8++) {
      _id_4BD98C454D3FB97A = nodes.size - _id_AC0E594AC96AA3A8;

      if(_id_B7994B0FD923157A < _id_4BD98C454D3FB97A) {
        _id_953F471CA637DD82 = nodes[_id_AC0E594AC96AA3A8];
        break;
      }

      _id_B7994B0FD923157A = _id_B7994B0FD923157A - _id_4BD98C454D3FB97A;
    }

    self botsetpathingstyle("scripted");
    _id_AC5A0E2F2B31FA6B = self botsetscriptgoalnode(_id_953F471CA637DD82, "guard");

    if(_id_AC5A0E2F2B31FA6B) {
      _id_2504DA19C43FB0D3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

      if(_id_2504DA19C43FB0D3 == "goal") {
        wait(randomfloatrange(1.0, 4.0));
        self.backstabber_stage = "2_move_to_enemy_spawn";
      }
    }
  }

  if(self.backstabber_stage == "2_move_to_enemy_spawn") {
    _id_8B346894DC0A1A03 = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_attacker");
    _id_AFE5420A7F89DBDC = scripts\engine\utility::random(_id_8B346894DC0A1A03);
    self botsetpathingstyle("scripted");
    _id_AC5A0E2F2B31FA6B = self botsetscriptgoal(_id_AFE5420A7F89DBDC.origin, 250, "guard");

    if(_id_AC5A0E2F2B31FA6B) {
      _id_2504DA19C43FB0D3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

      if(_id_2504DA19C43FB0D3 == "goal")
        self.backstabber_stage = "3_move_to_bombzone";
    }
  }

  if(self.backstabber_stage == "3_move_to_bombzone") {
    if(!isDefined(self.bombzone_picked))
      self.bombzone_picked = scripts\engine\utility::random(level.objectives);

    self botsetpathingstyle(undefined);
    _id_AC5A0E2F2B31FA6B = self botsetscriptgoal(scripts\engine\utility::random(self.bombzone_picked.bottargets).origin, 160, "objective");

    if(_id_AC5A0E2F2B31FA6B) {
      _id_2504DA19C43FB0D3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

      if(_id_2504DA19C43FB0D3 == "goal") {
        self botclearscriptgoal();
        self.backstabber_stage = "2_move_to_enemy_spawn";

        foreach(objective in level.objectives) {
          if(objective != self.bombzone_picked) {
            self.bombzone_picked = objective;
            break;
          }
        }
      }
    }
  }
}

random_killer_update() {
  self endon("new_role");

  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();

  self[[self.personality_update_function]]();
}

set_force_sprint() {
  if(!isDefined(self.always_sprint)) {
    self botsetflag("force_sprint", 1);
    self.always_sprint = 1;
  }
}

disable_force_sprint() {
  if(isDefined(self.always_sprint)) {
    self botsetflag("force_sprint", 0);
    self.always_sprint = undefined;
  }
}

set_scripted_pathing_style() {
  if(!isDefined(self.scripted_path_style)) {
    self botsetpathingstyle("scripted");
    self.scripted_path_style = 1;
  }
}

cautious_approach_till_close(target, label) {
  capture_radius = level.capture_radius;
  optional_params["entrance_points_index"] = label;
  scripts\mp\bots\bots_strategy::bot_capture_point(target, capture_radius, optional_params);
  wait 0.05;

  while(distancesquared(self.origin, target) > capture_radius * capture_radius && scripts\mp\bots\bots_util::bot_is_defending()) {
    if(get_round_end_time() - gettime() < 20000) {
      set_scripted_pathing_style();
      set_force_sprint();
      break;
    }

    wait 0.05;
  }

  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();

  return self botsetscriptgoal(target, 20, "critical");
}

notify_enemy_team_bomb_used(type) {
  players = _id_7F989E71B934C9FC::get_ai_hearing_bomb_plant_sound(type);

  foreach(player in players) {
    if(isDefined(player.role))
      player bot_set_role("investigate_someone_using_bomb");
  }
}

should_start_cautious_approach_sd(_id_44770B14726E7A47) {
  _id_8FA07DC6DC122490 = 2000;
  _id_334D85F434992401 = _id_8FA07DC6DC122490 * _id_8FA07DC6DC122490;

  if(_id_44770B14726E7A47) {
    if(get_round_end_time() - gettime() < 15000)
      return 0;

    _id_8331082FC25E5E1D = 0;
    enemy_team = scripts\engine\utility::get_enemy_team(self.team);

    foreach(player in level.players) {
      if(!isDefined(player.team)) {
        continue;
      }
      if(isalive(player) && player.team == enemy_team)
        _id_8331082FC25E5E1D = 1;
    }

    return _id_8331082FC25E5E1D;
  } else
    return distancesquared(self.origin, self.bot_defending_center) <= _id_334D85F434992401 && self botpursuingscriptgoal();
}

get_players_defending_zone(zone) {
  _id_B73E8BD7CC328B51 = [];
  _id_41F00D5086D9F26C = _id_7F989E71B934C9FC::get_living_players_on_team(game["defenders"]);

  foreach(player in _id_41F00D5086D9F26C) {
    if(isai(player) && isDefined(player.role) && player.role == "defender") {
      if(isDefined(player.defend_zone) && player.defend_zone == zone)
        _id_B73E8BD7CC328B51 = scripts\engine\utility::array_add(_id_B73E8BD7CC328B51, player);

      continue;
    }

    if(distancesquared(player.origin, zone.curorigin) < level.protect_radius * level.protect_radius)
      _id_B73E8BD7CC328B51 = scripts\engine\utility::array_add(_id_B73E8BD7CC328B51, player);
  }

  return _id_B73E8BD7CC328B51;
}

find_ticking_bomb() {
  if(isDefined(level.tickingobject)) {
    foreach(zone in level.objectives) {
      if(distancesquared(level.tickingobject.origin, zone.curorigin) < 90000)
        return zone;
    }
  }

  return undefined;
}

get_specific_zone(_id_2ECDC7B6BEBE2254) {
  _id_2ECDC7B6BEBE2254 = "_" + tolower(_id_2ECDC7B6BEBE2254);
  return level.objectives[_id_2ECDC7B6BEBE2254];
}

bomber_wait_for_death() {
  self endon("stopped_being_bomb_carrier");
  self endon("new_role");
  self waittill("death_or_disconnect");
  level.atk_bomber = undefined;
  level.last_atk_bomber_death_time = gettime();

  if(isDefined(self))
    self.role = undefined;

  _id_3E2F5D10887AEB24 = _id_7F989E71B934C9FC::get_living_players_on_team(game["attackers"], 1);
  force_all_players_to_role(_id_3E2F5D10887AEB24, undefined);
}

bomber_wait_for_bomb_reset() {
  self endon("death_or_disconnect");
  self endon("stopped_being_bomb_carrier");
  level.sdbomb endon("pickup_object");
  level.sdbomb waittill("reset");

  if(scripts\mp\utility\entity::isaiteamparticipant(self))
    self botclearscriptgoal();

  bot_set_role("atk_bomber");
}

set_new_bomber() {
  level.atk_bomber = self;
  bot_set_role("atk_bomber");
  thread bomber_wait_for_death();

  if(!level.multibomb)
    thread bomber_wait_for_bomb_reset();

  if(isai(self)) {
    scripts\mp\bots\bots_strategy::bot_disable_tactical_goals();

    if(level.attack_behavior == "rush" && self botgetdifficultysetting("strategyLevel") > 0)
      set_force_sprint();
  }
}

initialize_sd_role() {
  if(self.team == game["attackers"]) {
    if(level.bombplanted)
      bot_set_role("defend_planted_bomb");
    else if(!isDefined(level.atk_bomber))
      set_new_bomber();
    else if(level.attack_behavior == "rush")
      bot_set_role("clear_target_zone");
  } else {
    _id_260F53B6A58AF6D0 = get_players_by_role("backstabber");
    _id_2FD93EA689E77097 = get_players_by_role("defender");
    _id_30F9CA2FA8449648 = level.bot_personality_type[self.personality];
    strategy_level = self botgetdifficultysetting("strategyLevel");

    if(_id_30F9CA2FA8449648 == "active") {
      if(!isDefined(self.role) && level.allow_backstabbers && strategy_level > 0) {
        if(_id_260F53B6A58AF6D0.size == 0)
          bot_set_role("backstabber");
        else {
          _id_62BA97C0DBE82A6C = 1;

          foreach(_id_41588BAA72D0AD86 in _id_260F53B6A58AF6D0) {
            _id_0F08102F5F5EF20D = level.bot_personality_type[_id_41588BAA72D0AD86.personality];

            if(_id_0F08102F5F5EF20D == "active") {
              _id_62BA97C0DBE82A6C = 0;
              break;
            }
          }

          if(_id_62BA97C0DBE82A6C) {
            bot_set_role("backstabber");
            _id_260F53B6A58AF6D0[0] bot_set_role(undefined);
          }
        }
      }

      if(!isDefined(self.role)) {
        if(_id_2FD93EA689E77097.size < 4)
          bot_set_role("defender");
      }

      if(!isDefined(self.role)) {
        _id_6A8A60939CE622B0 = randomint(4);

        if(_id_6A8A60939CE622B0 == 3 && level.allow_random_killers && strategy_level > 0)
          bot_set_role("random_killer");
        else if(_id_6A8A60939CE622B0 == 2 && level.allow_backstabbers && strategy_level > 0)
          bot_set_role("backstabber");
        else
          bot_set_role("defender");
      }
    } else if(_id_30F9CA2FA8449648 == "stationary") {
      if(!isDefined(self.role)) {
        if(_id_2FD93EA689E77097.size < 4)
          bot_set_role("defender");
        else {
          foreach(_id_EE2753C1176F5C7E in _id_2FD93EA689E77097) {
            _id_5C7E92E7B121BA6C = level.bot_personality_type[_id_EE2753C1176F5C7E.personality];

            if(_id_5C7E92E7B121BA6C == "active") {
              bot_set_role("defender");
              _id_EE2753C1176F5C7E bot_set_role(undefined);
              break;
            }
          }
        }
      }

      if(!isDefined(self.role) && level.allow_backstabbers && strategy_level > 0) {
        if(_id_260F53B6A58AF6D0.size == 0)
          bot_set_role("backstabber");
      }

      if(!isDefined(self.role))
        bot_set_role("defender");
    }

    if(self.role == "defender") {
      _id_CEB6CF74CB9D8AEE = level.objectives;

      if(has_override_zone_targets(self.team))
        _id_CEB6CF74CB9D8AEE = get_override_zone_targets(self.team);

      if(_id_CEB6CF74CB9D8AEE.size == 1)
        self.defend_zone = _id_CEB6CF74CB9D8AEE["_a"];
      else {
        _id_669F62E425815AA5 = get_players_defending_zone(_id_CEB6CF74CB9D8AEE["_a"]);
        _id_669F61E425815872 = get_players_defending_zone(_id_CEB6CF74CB9D8AEE["_b"]);

        if(_id_669F62E425815AA5.size < _id_669F61E425815872.size)
          self.defend_zone = _id_CEB6CF74CB9D8AEE["_a"];
        else if(_id_669F61E425815872.size < _id_669F62E425815AA5.size)
          self.defend_zone = _id_CEB6CF74CB9D8AEE["_b"];
        else
          self.defend_zone = scripts\engine\utility::random(_id_CEB6CF74CB9D8AEE);
      }
    }
  }
}

bot_set_role(_id_B7EAC42471AC7FAE) {
  if(isai(self)) {
    scripts\mp\bots\bots_strategy::bot_defend_stop();
    self botsetpathingstyle(undefined);
  }

  self.prev_role = self.role;
  self.role = _id_B7EAC42471AC7FAE;
  self notify("new_role");
}

bot_set_role_delayed(_id_B7EAC42471AC7FAE, wait_time) {
  self endon("death_or_disconnect");
  self endon("new_role");
  wait(wait_time);
  bot_set_role(_id_B7EAC42471AC7FAE);
}

force_all_players_to_role(players, role, _id_7BDD50BFDD1B9031) {
  foreach(player in players) {
    if(isDefined(_id_7BDD50BFDD1B9031)) {
      player thread bot_set_role_delayed(role, randomfloatrange(0.0, _id_7BDD50BFDD1B9031));
      continue;
    }

    player thread bot_set_role(role);
  }
}

get_override_zone_targets(team) {
  return level.bot_sd_override_zone_targets[team];
}

has_override_zone_targets(team) {
  _id_88619EBFA03B1898 = get_override_zone_targets(team);
  return _id_88619EBFA03B1898.size > 0;
}

get_players_by_role(role) {
  players = [];

  foreach(player in level.participants) {
    if(isalive(player) && scripts\mp\utility\entity::isteamparticipant(player) && isDefined(player.role) && player.role == role)
      players[players.size] = player;
  }

  return players;
}

bot_sd_ai_director_update() {
  level notify("bot_sd_ai_director_update");
  level endon("bot_sd_ai_director_update");
  level endon("game_ended");
  level.allow_backstabbers = randomint(3) <= 1;
  level.allow_random_killers = randomint(3) <= 1;
  level.attack_behavior = "rush";
  level.protect_radius = 725;
  level.capture_radius = 140;

  for(;;) {
    if(isDefined(level.sdbomb) && isDefined(level.sdbomb.carrier) && !isai(level.sdbomb.carrier))
      level.bomb_zone_assaulting = _id_7F989E71B934C9FC::find_closest_bombzone_to_player(level.sdbomb.carrier);

    _id_D3E8B7250C920E3B = 0;

    if(!level.bombplanted) {
      _id_B36FC67C36D08D33 = _id_7F989E71B934C9FC::get_living_players_on_team(game["attackers"]);

      foreach(player in _id_B36FC67C36D08D33) {
        if(player.isbombcarrier) {
          level.can_pickup_bomb_time = gettime();

          if(!isDefined(level.atk_bomber) || player != level.atk_bomber) {
            if(isDefined(level.atk_bomber) && isalive(level.atk_bomber)) {
              level.atk_bomber bot_set_role(undefined);
              level.atk_bomber notify("stopped_being_bomb_carrier");
            }

            _id_D3E8B7250C920E3B = 1;
            player set_new_bomber();
          }
        }
      }

      if(!level.multibomb && !isDefined(level.sdbomb.carrier)) {
        _id_9D84A6DD1297510D = getclosestnodeinsight(level.sdbomb.curorigin);

        if(isDefined(_id_9D84A6DD1297510D)) {
          level.sdbomb.nearest_node_for_camping = _id_9D84A6DD1297510D;
          _id_41A4B4CEBA91ED4E = 0;
          _id_F0833AAB2B73079E = _id_7F989E71B934C9FC::get_living_players_on_team(game["defenders"], 1);

          foreach(ai in _id_F0833AAB2B73079E) {
            _id_B6F1DEB8E946E67C = ai getnearestnode();
            strategy_level = ai botgetdifficultysetting("strategyLevel");

            if(strategy_level > 0 && ai.role != "camp_bomb" && isDefined(_id_B6F1DEB8E946E67C) && nodesvisible(_id_9D84A6DD1297510D, _id_B6F1DEB8E946E67C, 1)) {
              _id_9230F5246D95A3D6 = ai botgetfovdot();

              if(scripts\engine\utility::within_fov(ai.origin, ai getplayerangles(), level.sdbomb.curorigin, _id_9230F5246D95A3D6)) {
                if(strategy_level >= 2 || distancesquared(ai.origin, level.sdbomb.curorigin) < squared(700)) {
                  _id_41A4B4CEBA91ED4E = 1;
                  break;
                }
              }
            }
          }

          if(_id_41A4B4CEBA91ED4E) {
            foreach(ai in _id_F0833AAB2B73079E) {
              if(ai.role != "camp_bomb" && ai botgetdifficultysetting("strategyLevel") > 0)
                ai bot_set_role("camp_bomb");
            }
          }
        }
      }

      _id_CEB6CF74CB9D8AEE = level.objectives;

      if(has_override_zone_targets(game["defenders"]))
        _id_CEB6CF74CB9D8AEE = get_override_zone_targets(game["defenders"]);

      foreach(_id_AC0E594AC96AA3A8 in _id_CEB6CF74CB9D8AEE) {
        foreach(_id_AC0E5C4AC96AAA41 in _id_CEB6CF74CB9D8AEE) {
          _id_EAEA273876FE3E3E = get_players_defending_zone(_id_AC0E594AC96AA3A8);
          _id_EAEA263876FE3C0B = get_players_defending_zone(_id_AC0E5C4AC96AAA41);

          if(_id_EAEA273876FE3E3E.size > _id_EAEA263876FE3C0B.size + 1) {
            _id_24050F51453437C9 = [];

            foreach(player in _id_EAEA273876FE3E3E) {
              if(isai(player))
                _id_24050F51453437C9 = scripts\engine\utility::array_add(_id_24050F51453437C9, player);
            }

            if(_id_24050F51453437C9.size > 0) {
              _id_EE2753C1176F5C7E = scripts\engine\utility::random(_id_24050F51453437C9);
              _id_EE2753C1176F5C7E scripts\mp\bots\bots_strategy::bot_defend_stop();
              _id_EE2753C1176F5C7E.defend_zone = _id_AC0E5C4AC96AAA41;
            }
          }
        }
      }
    } else {
      if(isDefined(level.atk_bomber))
        level.atk_bomber = undefined;

      if(!isDefined(level.bomb_defuser) || !isalive(level.bomb_defuser)) {
        _id_98DD7D6E449918F2 = [];
        _id_2FD93EA689E77097 = get_players_by_role("defender");
        _id_260F53B6A58AF6D0 = get_players_by_role("backstabber");
        _id_9E73F4A730E660A9 = get_players_by_role("random_killer");

        if(_id_2FD93EA689E77097.size > 0)
          _id_98DD7D6E449918F2 = _id_2FD93EA689E77097;
        else if(_id_260F53B6A58AF6D0.size > 0)
          _id_98DD7D6E449918F2 = _id_260F53B6A58AF6D0;
        else if(_id_9E73F4A730E660A9.size > 0)
          _id_98DD7D6E449918F2 = _id_9E73F4A730E660A9;

        if(_id_98DD7D6E449918F2.size > 0 && isDefined(level.sdbombmodel)) {
          _id_E656F391B6A5BBFE = scripts\engine\utility::get_array_of_closest(level.sdbombmodel.origin, _id_98DD7D6E449918F2);
          level.bomb_defuser = _id_E656F391B6A5BBFE[0];
          level.bomb_defuser bot_set_role("defuser");
          level.bomb_defuser scripts\mp\bots\bots_strategy::bot_disable_tactical_goals();
          level.bomb_defuser thread defuser_wait_for_death();
        }
      }

      if(!isDefined(level.sd_bomb_just_planted)) {
        level.sd_bomb_just_planted = 1;
        attackers = _id_7F989E71B934C9FC::get_living_players_on_team(game["attackers"]);

        foreach(player in attackers) {
          if(isDefined(player.role)) {
            if(player.role == "atk_bomber") {
              player thread bot_set_role(undefined);
              continue;
            }

            if(player.role != "defend_planted_bomb")
              player thread bot_set_role_delayed("defend_planted_bomb", randomfloatrange(0.0, 3.0));
          }
        }
      }
    }

    wait 0.5;
  }
}

defuser_wait_for_death() {
  self waittill("death_or_disconnect");
  level.bomb_defuser = undefined;
}