/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_cyber.gsc
***************************************************/

main() {
  setup_callbacks();
  setup_bot_cyber();
}

setup_callbacks() {
  level.bot_funcs["crate_can_use"] = ::crate_can_use;
  level.bot_funcs["gametype_think"] = ::bot_cyber_think;
  level.bot_funcs["know_enemies_on_start"] = undefined;
  level.bot_funcs["emp_picked_up_cancel"] = ::bot_abort_emp_pickup;
  level.bot_funcs["tactical_revive_override"] = ::bot_abort_tactical_goal_for_revive;
}

setup_bot_cyber() {
  _id_7F989E71B934C9FC::bot_setup_objective_bottargets();
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  _id_F4B4C81B7E99C586 = _id_7F989E71B934C9FC::bot_verify_and_cache_bombzones(["_allies", "_axis"]);

  if(_id_F4B4C81B7E99C586) {
    foreach(_id_EEF26A325310D3AF in level.objectives)
    _id_EEF26A325310D3AF thread _id_7F989E71B934C9FC::monitor_bombzone_control();

    level.protect_radius = 600;
    level.bot_gametype_precaching_done = 1;
  }
}

bot_cyber_think() {
  self notify("bot_sab_think");
  self endon("bot_sab_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  init_bot_game_cyber();
  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);
  self.next_time_hunt_carrier = gettime();

  if(!isDefined(level.next_game_update_time))
    level.next_game_update_time = gettime() + 100;

  for(;;) {
    wait 0.05;

    if(gettime() >= level.next_game_update_time) {
      update_game_cyber();
      level.next_game_update_time = gettime() + 100;
    }

    if(!scripts\mp\utility\player::isreallyalive(self)) {
      continue;
    }
    if(!isDefined(level.team_planted_bomb)) {
      if(!isDefined(level.bomb_carrier)) {
        if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("seek_cyber_emp", undefined) == 0) {
          action_thread = ::cyber_bot_pickup_emp;
          _id_4F3B05E382BB8C7C = spawnStruct();
          _id_4F3B05E382BB8C7C.object = level.cyberemp.trigger;
          _id_4F3B05E382BB8C7C.script_goal_radius = 16;
          _id_4F3B05E382BB8C7C.should_abort = level.bot_funcs["emp_picked_up_cancel"];
          _id_4F3B05E382BB8C7C.action_thread = action_thread;
          _id_DB532BB6D3E2F8E6 = getclosestpointonnavmesh(level.cyberemp.curorigin, self);
          scripts\mp\bots\bots_strategy::bot_new_tactical_goal("seek_cyber_emp", _id_DB532BB6D3E2F8E6, 99, _id_4F3B05E382BB8C7C);
        }
      } else if(self.isbombcarrier) {
        if(!scripts\mp\bots\bots_strategy::bot_has_tactical_goal()) {
          _id_EEF26A325310D3AF = level.objectives[scripts\engine\utility::get_enemy_team(self.team)];
          _id_735FD56DB96F509C = _id_7F989E71B934C9FC::get_bombzone_node_to_plant_on(_id_EEF26A325310D3AF, 1);
          self botclearscriptgoal();
          self botsetscriptgoal(_id_735FD56DB96F509C.origin, 0, "critical", _id_735FD56DB96F509C.angles[1]);
          _id_2504DA19C43FB0D3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

          if(_id_2504DA19C43FB0D3 == "goal") {
            self botpressbutton("use", level.planttime + 2);
            level scripts\engine\utility::waittill_any_timeout_1(level.planttime + 2, "bomb_planted");
          }

          self botclearscriptgoal();
        }
      } else if(level.bomb_carrier.team == self.team) {
        if(!scripts\mp\bots\bots_util::bot_is_defending())
          scripts\mp\bots\bots_strategy::bot_guard_player(level.bomb_carrier, 400);
      } else if(gettime() > self.next_time_hunt_carrier || sighttracepassed(self.origin + (0, 0, 77), level.bomb_carrier.origin + (0, 0, 77), 0, self)) {
        self botsetscriptgoal(level.bomb_carrier.origin, 16, "hunt");
        self.next_time_hunt_carrier = gettime() + randomintrange(4500, 5500);
      }

      continue;
    }

    _id_EEF26A325310D3AF = level.objectives[scripts\engine\utility::get_enemy_team(level.team_planted_bomb)];

    if(self.team == level.team_planted_bomb) {
      if(!is_defending_bombzone())
        scripts\mp\bots\bots_strategy::bot_protect_point(_id_EEF26A325310D3AF.curorigin, 600);
    } else if(isDefined(level.bomb_defuser) && level.bomb_defuser == self) {
      _id_2FEA4B3D4AAB8868 = _id_7F989E71B934C9FC::get_bombzone_node_to_defuse_on(_id_EEF26A325310D3AF).origin;
      self botsetscriptgoal(_id_2FEA4B3D4AAB8868, 20, "critical");
      result = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "no_longer_bomb_defuser");

      if(result == "goal") {
        self botpressbutton("use", level.defusetime + 2);
        waittill_usebutton_released_or_time_or_bomb_planted(level.defusetime + 2);
      }
    } else if(!scripts\mp\bots\bots_util::bot_is_defending()) {
      optional_params["entrance_points_index"] = "zone" + _id_EEF26A325310D3AF.label;
      scripts\mp\bots\bots_strategy::bot_capture_point(_id_EEF26A325310D3AF.curorigin, 200, optional_params);
    }
  }
}

bot_abort_emp_pickup(goal) {
  if(isDefined(level.cyberemp.carrier))
    return 1;

  return 0;
}

cyber_bot_pickup_emp(goal) {
  self botpressbutton("use", 0.5);
  _id_BCE1CF9927E810F2 = self botgetpersonality();

  if(_id_BCE1CF9927E810F2 == "default" || _id_BCE1CF9927E810F2 == "camper")
    wait 0.5;
}

waittill_usebutton_released_or_time_or_bomb_planted(time) {
  _id_F139A82799F5B68E = gettime();
  _id_F36002D69D048DB6 = _id_F139A82799F5B68E + time * 1000;
  wait 0.05;

  while(self useButtonPressed() && gettime() < _id_F36002D69D048DB6 && level.bombplanted)
    wait 0.05;
}

is_defending_bombzone() {
  return scripts\mp\bots\bots_util::bot_is_protecting();
}

init_bot_game_cyber() {
  if(isDefined(level.bots_gametype_initialized) && level.bots_gametype_initialized) {
    return;
  }
  level.bots_gametype_initialized = 1;
}

update_game_cyber() {
  if(!level.bombplanted) {
    if(isDefined(level.team_planted_bomb)) {
      level.team_planted_bomb = undefined;
      level.bomb_carrier = undefined;
    }

    _id_A8EF80D127014D2B = level.bomb_carrier;
    level.bomb_carrier = undefined;

    foreach(player in level.participants) {
      if(isalive(player) && player.isbombcarrier)
        level.bomb_carrier = player;
    }

    _id_0AF5FB37A7FBC388 = 0;

    if(!isDefined(_id_A8EF80D127014D2B) && isDefined(level.bomb_carrier)) {
      _id_0AF5FB37A7FBC388 = 1;

      if(isai(level.bomb_carrier))
        level.bomb_carrier thread bomber_think();
    } else if(isDefined(_id_A8EF80D127014D2B) && !isDefined(level.bomb_carrier))
      _id_0AF5FB37A7FBC388 = 1;

    if(_id_0AF5FB37A7FBC388) {
      foreach(player in level.participants) {
        if(scripts\mp\utility\entity::isaiteamparticipant(player))
          player scripts\mp\bots\bots_strategy::bot_defend_stop();
      }

      return;
    }
  } else {
    if(isDefined(level.bombowner) && !isDefined(level.team_planted_bomb)) {
      level.team_planted_bomb = level.bombowner.team;
      level.last_time_calc_defuser = gettime();
    }

    if(!isDefined(level.bomb_defuser) || !isalive(level.bomb_defuser) || gettime() > level.last_time_calc_defuser + 1000) {
      _id_7FF1C428CCF12888 = [];

      foreach(player in level.participants) {
        if(isalive(player) && scripts\mp\utility\entity::isaiteamparticipant(player) && player.team != level.team_planted_bomb)
          _id_7FF1C428CCF12888[_id_7FF1C428CCF12888.size] = player;
      }

      if(_id_7FF1C428CCF12888.size > 0) {
        _id_EEF26A325310D3AF = level.objectives[scripts\engine\utility::get_enemy_team(level.team_planted_bomb)];
        _id_8518445C76F3E0B8 = scripts\engine\utility::get_array_of_closest(_id_EEF26A325310D3AF.curorigin, _id_7FF1C428CCF12888);

        if(!isDefined(level.bomb_defuser) || level.bomb_defuser != _id_8518445C76F3E0B8[0]) {
          _id_B78EBA6AF13C0E63 = level.bomb_defuser;
          level.bomb_defuser = _id_8518445C76F3E0B8[0];
          level.bomb_defuser scripts\mp\bots\bots_strategy::bot_defend_stop();

          if(isDefined(_id_B78EBA6AF13C0E63))
            _id_B78EBA6AF13C0E63 notify("no_longer_bomb_defuser");
        }
      }
    }
  }
}

bomber_think() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!level.bombplanted && self.isbombcarrier) {
    _id_90C5703EF10884E8 = [];

    foreach(player in level.participants) {
      if(isalive(player) && scripts\mp\utility\entity::isaiteamparticipant(player) && player.team == self.team && player scripts\mp\bots\bots_util::bot_is_defending())
        _id_90C5703EF10884E8[_id_90C5703EF10884E8.size] = player;
    }

    _id_F3B7188AE6B4CF5C = 0;

    foreach(_id_F5CCB6C745FF8F0B in _id_90C5703EF10884E8) {
      _id_C267021F983A459B = distancesquared(self.origin, _id_F5CCB6C745FF8F0B.origin);
      _id_3A0DE1E171A0895F = _id_F5CCB6C745FF8F0B.bot_defending_radius * _id_F5CCB6C745FF8F0B.bot_defending_radius;
      _id_E7F967C527A728A7 = _id_F5CCB6C745FF8F0B.bot_defending_radius * 2 * (_id_F5CCB6C745FF8F0B.bot_defending_radius * 2);

      if(_id_C267021F983A459B > _id_3A0DE1E171A0895F && _id_C267021F983A459B < _id_E7F967C527A728A7)
        _id_F3B7188AE6B4CF5C++;
    }

    self setmovespeedscale(1.0 - 0.15 * _id_F3B7188AE6B4CF5C);
    wait 1;
  }
}

crate_can_use(crate) {
  if(isagent(self) && !isDefined(crate.boxtype))
    return 0;

  if(!scripts\mp\bots\bots::_id_9BD84CEDE4FE8F24(crate))
    return 0;

  if(self.isbombcarrier)
    return 0;

  if(!scripts\mp\bots\bots_util::bot_is_defending() && !scripts\mp\bots\bots_util::bot_is_protecting() && !scripts\mp\bots\bots_util::bot_is_bodyguarding())
    return 1;

  return 0;
}

bot_abort_tactical_goal_for_revive() {
  if(level.bombplanted)
    return 0;

  if(isDefined(level.cyberemp.carrier) && self == level.cyberemp.carrier)
    return 0;

  if(istrue(self.isbotmedicrole))
    return 0;

  _id_F9C0EA4126CEBF58 = scripts\mp\utility\teams::getteamdata(self.team, "aliveCount");
  _id_557D59EBFF7D41B2 = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");
  _id_266071535F1E555B = _id_557D59EBFF7D41B2 - _id_F9C0EA4126CEBF58;

  if(_id_266071535F1E555B == 0)
    return 0;

  _id_8F493BE601DD5562 = 0;
  _id_365CA68607BEFB50 = 0;

  foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(istrue(self.isbotmedicrole))
      _id_8F493BE601DD5562++;
  }

  _id_698A5AE4108AAA6B = int(clamp(_id_557D59EBFF7D41B2 - 2, 1, 3));

  if(_id_8F493BE601DD5562 < _id_698A5AE4108AAA6B + 1)
    _id_365CA68607BEFB50 = 1;

  if(_id_365CA68607BEFB50) {
    if(_id_557D59EBFF7D41B2 == 2)
      _id_51CA3CC37C90BCB3 = 1;
    else
      _id_51CA3CC37C90BCB3 = _id_F9C0EA4126CEBF58 / _id_557D59EBFF7D41B2 <= 0.7;

    if(_id_51CA3CC37C90BCB3)
      return 1;
  }

  return 0;
}