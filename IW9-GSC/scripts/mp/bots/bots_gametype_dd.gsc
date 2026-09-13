/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_dd.gsc
************************************************/

main() {
  setup_callbacks();
  bot_dd_start();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_dd_think;
  level.bot_funcs["notify_enemy_bots_bomb_used"] = ::notify_enemy_team_bomb_used;
}

bot_dd_start() {
  setup_bot_dd();
}

setup_bot_dd() {
  _id_7F989E71B934C9FC::bot_setup_objective_bottargets();
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  _id_F4B4C81B7E99C586 = _id_7F989E71B934C9FC::bot_verify_and_cache_bombzones(["_a", "_b"]);

  if(_id_F4B4C81B7E99C586) {
    foreach(_id_EEF26A325310D3AF in level.objectives)
    _id_EEF26A325310D3AF thread _id_7F989E71B934C9FC::monitor_bombzone_control();

    thread bot_dd_ai_director_update();
    level.bot_gametype_precaching_done = 1;
  }
}

bot_dd_think() {
  self notify("bot_dd_think");
  self endon("bot_dd_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self.current_bombzone = undefined;
  self.defuser_bad_path_counter = 0;

  for(;;) {
    wait 0.05;

    if(isDefined(self.current_bombzone) && !bombzone_is_active(self.current_bombzone)) {
      self.current_bombzone = undefined;
      bot_dd_clear_role();
    }

    if(scripts\mp\utility\game::inovertime())
      _id_CA9E6DE8AAEF2781 = level.objectives["_a"].ownerteam != self.team;
    else
      _id_CA9E6DE8AAEF2781 = self.team == game["attackers"];

    if(_id_CA9E6DE8AAEF2781) {
      bot_pick_new_zone("attack");

      if(!isDefined(self.current_bombzone)) {
        continue;
      }
      bot_try_switch_attack_zone();
      bot_choose_attack_role();

      if(self.role == "sweep_zone") {
        if(!scripts\mp\bots\bots_util::bot_is_defending_point(self.current_bombzone.curorigin)) {
          optional_params["min_goal_time"] = 2;
          optional_params["max_goal_time"] = 4;
          optional_params["override_origin_node"] = scripts\engine\utility::random(self.current_bombzone.bottargets);
          scripts\mp\bots\bots_strategy::bot_protect_point(self.current_bombzone.curorigin, level.protect_radius, optional_params);
        }
      } else if(self.role == "defend_zone") {
        if(!scripts\mp\bots\bots_util::bot_is_defending_point(level.ddbombmodel[self.current_bombzone.objectivekey].origin)) {
          optional_params["score_flags"] = "strongly_avoid_center";
          scripts\mp\bots\bots_strategy::bot_protect_point(level.ddbombmodel[self.current_bombzone.objectivekey].origin, level.protect_radius, optional_params);
        }
      } else if(self.role == "investigate_someone_using_bomb")
        investigate_someone_using_bomb();
      else if(self.role == "atk_bomber")
        plant_bomb();

      continue;
    }

    bot_pick_new_zone("defend");

    if(!isDefined(self.current_bombzone)) {
      continue;
    }
    bot_choose_defend_role();

    if(self.role == "defend_zone") {
      if(!scripts\mp\bots\bots_util::bot_is_defending_point(self.current_bombzone.curorigin)) {
        optional_params["score_flags"] = "strict_los";
        optional_params["override_origin_node"] = scripts\engine\utility::random(self.current_bombzone.bottargets);
        scripts\mp\bots\bots_strategy::bot_protect_point(self.current_bombzone.curorigin, level.protect_radius, optional_params);
      }

      continue;
    }

    if(self.role == "investigate_someone_using_bomb") {
      investigate_someone_using_bomb();
      continue;
    }

    if(self.role == "defuser")
      defuse_bomb();
  }
}

notify_enemy_team_bomb_used(type) {
  _id_78477ECDEE5F9959 = _id_7F989E71B934C9FC::find_closest_bombzone_to_player(self);
  players = _id_7F989E71B934C9FC::get_ai_hearing_bomb_plant_sound(type);

  foreach(player in players) {
    if(isDefined(player.current_bombzone) && _id_78477ECDEE5F9959 == player.current_bombzone)
      player bot_dd_set_role("investigate_someone_using_bomb");
  }
}

plant_bomb() {
  self endon("change_role");
  _id_735FD56DB96F509C = _id_7F989E71B934C9FC::get_bombzone_node_to_plant_on(self.current_bombzone, 0);
  self botsetscriptgoal(_id_735FD56DB96F509C.origin, 0, "critical");
  _id_2504DA19C43FB0D3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "change_role");

  if(_id_2504DA19C43FB0D3 == "goal") {
    _id_546BDD6F69FD53E0 = scripts\mp\gamelogic::gettimeremaining();
    _id_87E36BCBD7AF1D56 = _id_546BDD6F69FD53E0 - level.planttime * 2 * 1000;
    _id_D77E04D8D7105BB0 = gettime() + _id_87E36BCBD7AF1D56;

    if(_id_87E36BCBD7AF1D56 > 0)
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(_id_87E36BCBD7AF1D56);

    _id_5B45D81D67839650 = _id_D77E04D8D7105BB0 > 0 && gettime() >= _id_D77E04D8D7105BB0;
    _id_F4B4C81B7E99C586 = _id_7F989E71B934C9FC::bombzone_press_use(level.planttime + 2, "bomb_planted", _id_5B45D81D67839650);
    self botclearscriptgoal();

    if(_id_F4B4C81B7E99C586)
      bot_dd_clear_role();
  }
}

defuse_bomb() {
  self endon("change_role");
  self botsetpathingstyle("scripted");
  _id_2FEA4B3D4AAB8868 = _id_7F989E71B934C9FC::get_bombzone_node_to_defuse_on(self.current_bombzone).origin;
  self botsetscriptgoal(_id_2FEA4B3D4AAB8868, 20, "critical");
  _id_2504DA19C43FB0D3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "change_role");

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

        _id_2504DA19C43FB0D3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "change_role");

        if(_id_2504DA19C43FB0D3 == "bad_path") {
          self.defuser_bad_path_counter++;
          continue;
        }

        break;
      }
    }
  }

  if(_id_2504DA19C43FB0D3 == "goal") {
    _id_B497E19421070AE9 = gettime() - self.current_bombzone.startbombtime;
    _id_546BDD6F69FD53E0 = level.bombtimer * 1000 - _id_B497E19421070AE9;
    _id_BAE7D7B60CE8FFC3 = _id_546BDD6F69FD53E0 - level.defusetime * 2 * 1000;
    _id_BB36F4158262888D = gettime() + _id_BAE7D7B60CE8FFC3;

    if(_id_BAE7D7B60CE8FFC3 > 0)
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(_id_BAE7D7B60CE8FFC3);

    _id_8759DC70176704AD = _id_BB36F4158262888D > 0 && gettime() >= _id_BB36F4158262888D;
    _id_F4B4C81B7E99C586 = _id_7F989E71B934C9FC::bombzone_press_use(level.defusetime + 2, "bomb_defused", _id_8759DC70176704AD);

    if(!_id_F4B4C81B7E99C586 && self.defuser_bad_path_counter >= 4)
      self.defuser_bad_path_counter++;

    self botclearscriptgoal();

    if(_id_F4B4C81B7E99C586)
      bot_dd_clear_role();
  }
}

investigate_someone_using_bomb() {
  self endon("change_role");

  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();

  self botsetscriptgoalnode(scripts\engine\utility::random(self.current_bombzone.bottargets), "critical");
  result = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(result == "goal") {
    wait 2;
    bot_dd_clear_role();
  }
}

get_player_defusing_zone(zone) {
  _id_BFEDEA4FFE22CDA9 = get_players_at_zone(zone, self.team);

  foreach(player in _id_BFEDEA4FFE22CDA9) {
    if(!isai(player)) {
      if(player.isdefusing)
        return player;
    }
  }

  foreach(player in _id_BFEDEA4FFE22CDA9) {
    if(isai(player)) {
      if(isDefined(player.role) && player.role == "defuser")
        return player;
    }
  }

  return undefined;
}

get_player_planting_zone(zone) {
  _id_14B1D2EFBEF0F949 = get_players_at_zone(zone, self.team);

  foreach(player in _id_14B1D2EFBEF0F949) {
    if(!isai(player)) {
      if(player.isplanting)
        return player;
    }
  }

  foreach(player in _id_14B1D2EFBEF0F949) {
    if(isai(player)) {
      if(isDefined(player.role) && player.role == "atk_bomber")
        return player;
    }
  }

  return undefined;
}

bombzone_is_active(zone) {
  if(zone.visibleteam == "any")
    return 1;

  return 0;
}

get_active_bombzones() {
  _id_2607EE8948BF00E3 = [];

  foreach(zone in level.objectives) {
    if(bombzone_is_active(zone))
      _id_2607EE8948BF00E3[_id_2607EE8948BF00E3.size] = zone;
  }

  return _id_2607EE8948BF00E3;
}

get_players_at_zone(zone, team) {
  _id_4DF404DBB0D6B517 = [];
  _id_41F00D5086D9F26C = _id_7F989E71B934C9FC::get_living_players_on_team(team);

  foreach(player in _id_41F00D5086D9F26C) {
    if(isai(player)) {
      if(isDefined(player.current_bombzone) && player.current_bombzone == zone)
        _id_4DF404DBB0D6B517 = scripts\engine\utility::array_add(_id_4DF404DBB0D6B517, player);

      continue;
    }

    if(distancesquared(player.origin, zone.curorigin) < level.protect_radius * level.protect_radius)
      _id_4DF404DBB0D6B517 = scripts\engine\utility::array_add(_id_4DF404DBB0D6B517, player);
  }

  return _id_4DF404DBB0D6B517;
}

bot_pick_dd_zone_with_fewer_defenders(zones, _id_2A83DF6C49112D96) {
  _id_43A7AE1BFB0CDEC0[0] = get_players_at_zone(zones[0], game["defenders"]).size;
  _id_43A7AE1BFB0CDEC0[1] = get_players_at_zone(zones[1], game["defenders"]).size;

  if(_id_43A7AE1BFB0CDEC0[0] > _id_43A7AE1BFB0CDEC0[1] + _id_2A83DF6C49112D96)
    return zones[1];
  else if(_id_43A7AE1BFB0CDEC0[0] + _id_2A83DF6C49112D96 < _id_43A7AE1BFB0CDEC0[1])
    return zones[0];
}

bot_pick_new_zone(type) {
  _id_617BC0DD99650908 = undefined;

  if(type == "attack")
    _id_617BC0DD99650908 = bot_choose_attack_zone();
  else if(type == "defend")
    _id_617BC0DD99650908 = bot_choose_defend_zone();

  if(isDefined(_id_617BC0DD99650908) && (!isDefined(self.current_bombzone) || self.current_bombzone != _id_617BC0DD99650908)) {
    self.current_bombzone = _id_617BC0DD99650908;
    bot_dd_clear_role();
  }
}

bot_choose_defend_zone() {
  _id_2607EE8948BF00E3 = get_active_bombzones();
  _id_A622BA42EB483DAB = undefined;

  if(_id_2607EE8948BF00E3.size == 1)
    _id_A622BA42EB483DAB = _id_2607EE8948BF00E3[0];
  else if(_id_2607EE8948BF00E3.size == 2) {
    _id_43A7AE1BFB0CDEC0[0] = get_players_at_zone(_id_2607EE8948BF00E3[0], game["defenders"]).size;
    _id_43A7AE1BFB0CDEC0[1] = get_players_at_zone(_id_2607EE8948BF00E3[1], game["defenders"]).size;
    _id_64E23B30076E759A[0] = is_bomb_planted_on(_id_2607EE8948BF00E3[0]);
    _id_64E23B30076E759A[1] = is_bomb_planted_on(_id_2607EE8948BF00E3[1]);

    if(_id_64E23B30076E759A[0] && _id_64E23B30076E759A[1] || !_id_64E23B30076E759A[0] && !_id_64E23B30076E759A[1]) {
      _id_2A83DF6C49112D96 = 0;

      if(isDefined(self.current_bombzone))
        _id_2A83DF6C49112D96 = 1;

      _id_A622BA42EB483DAB = bot_pick_dd_zone_with_fewer_defenders(_id_2607EE8948BF00E3, _id_2A83DF6C49112D96);

      if(!isDefined(_id_A622BA42EB483DAB) && !isDefined(self.current_bombzone))
        _id_A622BA42EB483DAB = scripts\engine\utility::random(_id_2607EE8948BF00E3);
    } else if(_id_64E23B30076E759A[0] || _id_64E23B30076E759A[1]) {
      _id_655DF04BD2181345 = scripts\engine\utility::ter_op(_id_64E23B30076E759A[0], 0, 1);
      _id_49B95B5588EBF99B = scripts\engine\utility::ter_op(!_id_64E23B30076E759A[0], 0, 1);

      if(_id_43A7AE1BFB0CDEC0[_id_655DF04BD2181345] > _id_43A7AE1BFB0CDEC0[_id_49B95B5588EBF99B] + 2)
        _id_A622BA42EB483DAB = _id_2607EE8948BF00E3[_id_49B95B5588EBF99B];
      else if(_id_43A7AE1BFB0CDEC0[_id_655DF04BD2181345] <= _id_43A7AE1BFB0CDEC0[_id_49B95B5588EBF99B])
        _id_A622BA42EB483DAB = _id_2607EE8948BF00E3[_id_655DF04BD2181345];
      else if(!isDefined(self.current_bombzone)) {
        if(_id_43A7AE1BFB0CDEC0[_id_655DF04BD2181345] >= _id_43A7AE1BFB0CDEC0[_id_49B95B5588EBF99B] + 2)
          _id_A622BA42EB483DAB = _id_2607EE8948BF00E3[_id_49B95B5588EBF99B];
        else if(_id_43A7AE1BFB0CDEC0[_id_655DF04BD2181345] < _id_43A7AE1BFB0CDEC0[_id_49B95B5588EBF99B] + 2)
          _id_A622BA42EB483DAB = _id_2607EE8948BF00E3[_id_655DF04BD2181345];
      }
    }
  }

  return _id_A622BA42EB483DAB;
}

get_other_active_zone(_id_5F9FDAEC6649EC9C) {
  _id_70EC15F01983A7F3 = get_active_bombzones();

  foreach(zone in _id_70EC15F01983A7F3) {
    if(zone != _id_5F9FDAEC6649EC9C)
      return zone;
  }
}

bot_choose_attack_zone() {
  if(isDefined(self.current_bombzone)) {
    return;
  }
  if(!isDefined(level.current_zone_target) || !bombzone_is_active(level.current_zone_target) || gettime() > level.next_target_switch_time) {
    level.next_target_switch_time = gettime() + 1000 * randomintrange(30, 45);
    level.current_zone_target = scripts\engine\utility::random(get_active_bombzones());
  }

  if(!isDefined(level.current_zone_target)) {
    return;
  }
  _id_BD85DCAA8111048B = level.current_zone_target;
  _id_C07CE18DA8A3F3E4 = get_other_active_zone(_id_BD85DCAA8111048B);
  self.current_bombzone = undefined;

  if(isDefined(_id_C07CE18DA8A3F3E4)) {
    if(randomfloat(1.0) < 0.25)
      return _id_C07CE18DA8A3F3E4;
  }

  return _id_BD85DCAA8111048B;
}

bot_try_switch_attack_zone() {
  _id_1329D9E0D32232D4 = get_other_active_zone(self.current_bombzone);

  if(isDefined(_id_1329D9E0D32232D4)) {
    _id_02E892C72CD7EF8D = distance(self.origin, self.current_bombzone.curorigin);
    _id_E16650182C449DB1 = distance(self.origin, _id_1329D9E0D32232D4.curorigin);

    if(_id_E16650182C449DB1 < _id_02E892C72CD7EF8D * 0.6)
      self.current_bombzone = _id_1329D9E0D32232D4;
  }
}

bot_choose_attack_role() {
  if(isDefined(self.role)) {
    if(self.role == "investigate_someone_using_bomb")
      return;
  }

  _id_B7EAC42471AC7FAE = undefined;

  if(is_bomb_planted_on(self.current_bombzone))
    _id_B7EAC42471AC7FAE = "defend_zone";
  else {
    _id_6EAA3366BA4607B8 = get_player_planting_zone(self.current_bombzone);

    if(!isDefined(_id_6EAA3366BA4607B8) || _id_6EAA3366BA4607B8 == self)
      _id_B7EAC42471AC7FAE = "atk_bomber";
    else if(isai(_id_6EAA3366BA4607B8)) {
      _id_9F0D0574D42D275A = distance(self.origin, self.current_bombzone.curorigin);
      _id_C7F0FA34E70E55C9 = distance(_id_6EAA3366BA4607B8.origin, self.current_bombzone.curorigin);

      if(_id_9F0D0574D42D275A < _id_C7F0FA34E70E55C9 * 0.9) {
        _id_B7EAC42471AC7FAE = "atk_bomber";
        _id_6EAA3366BA4607B8 bot_dd_clear_role();
      }
    }
  }

  if(!isDefined(_id_B7EAC42471AC7FAE))
    _id_B7EAC42471AC7FAE = "sweep_zone";

  bot_dd_set_role(_id_B7EAC42471AC7FAE);
}

bot_choose_defend_role() {
  if(isDefined(self.role)) {
    if(self.role == "investigate_someone_using_bomb")
      return;
  }

  _id_B7EAC42471AC7FAE = undefined;

  if(is_bomb_planted_on(self.current_bombzone)) {
    _id_899783611665DE35 = get_player_defusing_zone(self.current_bombzone);

    if(!isDefined(_id_899783611665DE35) || _id_899783611665DE35 == self)
      _id_B7EAC42471AC7FAE = "defuser";
    else if(isai(_id_899783611665DE35)) {
      _id_9F0D0574D42D275A = distance(self.origin, self.current_bombzone.curorigin);
      _id_F226ECAE7AFAFBA6 = distance(_id_899783611665DE35.origin, self.current_bombzone.curorigin);

      if(_id_9F0D0574D42D275A < _id_F226ECAE7AFAFBA6 * 0.9) {
        _id_B7EAC42471AC7FAE = "defuser";
        _id_899783611665DE35 bot_dd_clear_role();
      }
    }
  }

  if(!isDefined(_id_B7EAC42471AC7FAE))
    _id_B7EAC42471AC7FAE = "defend_zone";

  bot_dd_set_role(_id_B7EAC42471AC7FAE);
}

bot_dd_set_role(_id_B7EAC42471AC7FAE) {
  if(!isDefined(self.role) || self.role != _id_B7EAC42471AC7FAE) {
    bot_dd_clear_role();
    self.role = _id_B7EAC42471AC7FAE;
  }
}

bot_dd_clear_role() {
  self.role = undefined;
  self botclearscriptgoal();
  self botsetpathingstyle(undefined);
  scripts\mp\bots\bots_strategy::bot_defend_stop();
  self notify("change_role");
  self.defuser_bad_path_counter = 0;
}

bot_dd_ai_director_update() {
  level notify("bot_dd_ai_director_update");
  level endon("bot_dd_ai_director_update");
  level endon("game_ended");
  level.protect_radius = 725;

  for(;;) {
    foreach(zone in level.objectives) {
      foreach(player in level.players) {
        if(isDefined(player.role) && isDefined(player.current_bombzone) && player.current_bombzone == zone) {
          if(!bombzone_is_active(zone)) {
            if(player.role == "atk_bomber" || player.role == "defuser")
              player bot_dd_clear_role();

            continue;
          }

          if(is_bomb_planted_on(zone)) {
            if(player.role == "atk_bomber")
              player bot_dd_clear_role();
          }
        }
      }
    }

    wait 0.5;
  }
}

is_bomb_planted_on(zone) {
  return istrue(zone.bombplanted);
}