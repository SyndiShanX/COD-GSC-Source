/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_rugby.gsc
***************************************************/

main() {
  setup_callbacks();
  _id_7F19D11DBF8F7C20();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::_id_3B431AF7971BED6D;
  level.bot_funcs["crate_can_use"] = ::crate_can_use;
  level.bot_funcs["know_enemies_on_start"] = undefined;
  level.bot_funcs["jugg_picked_up_cancel"] = ::_id_E1792F85CFA1C508;
}

_id_7F19D11DBF8F7C20() {
  _id_789E1BB0F071AF10();
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  _id_F4B4C81B7E99C586 = _id_770D1881C6ADB8D0(["_allies", "_axis"]);

  if(_id_F4B4C81B7E99C586) {
    level.protect_radius = 1200;
    level.bot_gametype_precaching_done = 1;
  }
}

_id_3B431AF7971BED6D() {
  self notify("bot_rugby_think");
  self endon("bot_rugby_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  _id_9EC0E59B27B57A40();
  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);
  self.next_time_hunt_carrier = gettime();

  if(!isDefined(level.next_game_update_time))
    level.next_game_update_time = gettime() + 100;

  for(;;) {
    wait 0.05;

    if(gettime() >= level.next_game_update_time)
      level.next_game_update_time = gettime() + 100;

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(level._id_9A453437A59C7A57)) {
      if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("seek_rugby_jugg", undefined) == 0) {
        action_thread = ::_id_8830CE4EFDC64403;
        _id_4F3B05E382BB8C7C = spawnStruct();
        _id_4F3B05E382BB8C7C.object = level.rugby.activejuggcrates[0];
        _id_4F3B05E382BB8C7C.script_goal_radius = 16;
        _id_4F3B05E382BB8C7C.should_abort = level.bot_funcs["jugg_picked_up_cancel"];
        _id_4F3B05E382BB8C7C.action_thread = action_thread;
        _id_4B1CED49F4DC2AFB = getclosestpointonnavmesh(level.rugby.activejuggcrates[0].origin, self);
        scripts\mp\bots\bots_strategy::bot_new_tactical_goal("seek_rugby_jugg", _id_4B1CED49F4DC2AFB, 99, _id_4F3B05E382BB8C7C);
      }

      continue;
    }

    if(self == level._id_9A453437A59C7A57) {
      if(istrue(game["switchedsides"]))
        _id_54B003CE5D016238 = level.rugby.endzones[self.team][0];
      else
        _id_54B003CE5D016238 = level.rugby.endzones[scripts\engine\utility::get_enemy_team(self.team)][0];

      _id_735FD56DB96F509C = _id_451FE89FC8F4F1B1(_id_54B003CE5D016238.trigger);
      self botsetscriptgoal(_id_735FD56DB96F509C.origin, 0, "critical", _id_735FD56DB96F509C.angles[1]);
      _id_2504DA19C43FB0D3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
      continue;
    }

    if(level._id_9A453437A59C7A57.team == self.team) {
      if(!scripts\mp\bots\bots_util::bot_is_defending())
        scripts\mp\bots\bots_strategy::bot_guard_player(level._id_9A453437A59C7A57, 400);

      continue;
    }

    if(gettime() > self.next_time_hunt_carrier || sighttracepassed(self.origin + (0, 0, 77), level._id_9A453437A59C7A57.origin + (0, 0, 77), 0, self)) {
      self botsetscriptgoal(level._id_9A453437A59C7A57.origin, 16, "hunt");
      self.next_time_hunt_carrier = gettime() + randomintrange(4500, 5500);
    }
  }
}

_id_451FE89FC8F4F1B1(trigger) {
  if(trigger.bottargets.size >= 2) {
    _id_82D7851272CA820D = scripts\engine\utility::array_randomize(trigger.bottargets);
    return _id_82D7851272CA820D[0];
  } else
    return trigger.bottargets[0];
}

_id_E1792F85CFA1C508(goal) {
  if(isDefined(level._id_9A453437A59C7A57))
    return 1;

  return 0;
}

_id_8830CE4EFDC64403(goal) {
  _id_F4B4C81B7E99C586 = _id_7BA961E259D98D3D(_id_35199F2A94ED1877::_id_CCA61180D8FDF0EA() + 2, "jugg_captured", randomint(100) > 50);
  self botclearscriptgoal();

  if(_id_F4B4C81B7E99C586) {
    return;
  }
  return;
}

_id_7BA961E259D98D3D(time, _id_206BF0AC411B2257, _id_5B45D81D67839650, dont_prone) {
  _id_8E7073E75873765A = 0;

  if(self botgetdifficultysetting("strategyLevel") == 1)
    _id_8E7073E75873765A = 40;
  else if(self botgetdifficultysetting("strategyLevel") >= 2)
    _id_8E7073E75873765A = 80;

  if(randomint(100) < _id_8E7073E75873765A && !(isDefined(dont_prone) && dont_prone)) {
    self botsetstance("prone");
    wait 0.2;
  }

  if(self botgetdifficultysetting("strategyLevel") > 0 && !_id_5B45D81D67839650) {}

  self botpressbutton("use", time);
  result = scripts\mp\bots\bots_util::bot_usebutton_wait(time, _id_206BF0AC411B2257, "use_interrupted");
  self botsetstance("none");
  self botclearbutton("use");
  _id_F4B4C81B7E99C586 = result == _id_206BF0AC411B2257;
  return _id_F4B4C81B7E99C586;
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

_id_9EC0E59B27B57A40() {
  if(isDefined(level.bots_gametype_initialized) && level.bots_gametype_initialized) {
    return;
  }
  level.bots_gametype_initialized = 1;
}

_id_789E1BB0F071AF10() {
  wait 1.0;
  _id_9B8B9E0F9B6897E3(level.rugby.endzones["allies"][0].trigger);
  _id_9B8B9E0F9B6897E3(level.rugby.endzones["axis"][0].trigger);
  level.bot_set_objective_bottargets = 1;
}

_id_9B8B9E0F9B6897E3(_id_F7806D4CF24AACD3) {
  if(!isDefined(_id_F7806D4CF24AACD3.bottargets))
    _id_F7806D4CF24AACD3.bottargets = _id_7F989E71B934C9FC::bot_get_valid_nodes_in_trigger(_id_F7806D4CF24AACD3);
}

_id_CA798B60536C6B13() {
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

_id_770D1881C6ADB8D0(_id_D36A7E987347E24D) {
  _id_99E49CED1B12AB57 = 0;

  foreach(_id_54B003CE5D016238 in level.rugby.endzones) {}

  if(!_id_99E49CED1B12AB57)
    _id_19B1CD86E58E30CE();

  return !_id_99E49CED1B12AB57;
}

_id_19B1CD86E58E30CE() {
  entrance_origin_points = [];
  _id_31AC0F14318B785F = [];
  index = 0;

  foreach(_id_54B003CE5D016238 in level.rugby.endzones) {
    entrance_origin_points[index] = scripts\engine\utility::random(_id_54B003CE5D016238[0].trigger.bottargets).origin;
    _id_31AC0F14318B785F[index] = "zone" + _id_54B003CE5D016238[0].trigger.objectivekey;
    index++;
  }

  _id_7F989E71B934C9FC::bot_cache_entrances(entrance_origin_points, _id_31AC0F14318B785F);
}