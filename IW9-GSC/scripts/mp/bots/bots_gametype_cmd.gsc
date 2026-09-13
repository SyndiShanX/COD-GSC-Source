/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_cmd.gsc
*************************************************/

main() {
  setup_callbacks();
  setup_hardpoint();
}

setup_hardpoint() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled(1);
  thread bot_hardpoint_ai_director_update();
  level.protect_radius = 128;
  level.patrol_radius = 800;
  level.bot_gametype_precaching_done = 1;
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_hardpoint_think;
}

initialize_role() {
  attackers = get_allied_attackers_for_team(self.team);
  _id_2FD93EA689E77097 = get_allied_defenders_for_team(self.team);
  _id_DD81F3B223F70502 = bot_attacker_limit_for_team(self.team);
  _id_C3FE770AB5FB04EE = bot_defender_limit_for_team(self.team);
  _id_30F9CA2FA8449648 = level.bot_personality_type[self.personality];

  if(_id_30F9CA2FA8449648 == "active") {
    if(attackers.size >= _id_DD81F3B223F70502) {
      _id_8668B3FA2350C9B3 = 0;

      foreach(attacker in attackers) {
        if(isai(attacker) && level.bot_personality_type[attacker.personality] == "stationary") {
          attacker.role = undefined;
          _id_8668B3FA2350C9B3 = 1;
          break;
        }
      }

      if(_id_8668B3FA2350C9B3) {
        bot_set_role("attacker");
        return;
      }

      bot_set_role("defender");
      return;
    } else
      bot_set_role("attacker");
  } else if(_id_30F9CA2FA8449648 == "stationary") {
    if(_id_2FD93EA689E77097.size >= _id_C3FE770AB5FB04EE) {
      _id_8668B3FA2350C9B3 = 0;

      foreach(_id_EE2753C1176F5C7E in _id_2FD93EA689E77097) {
        if(isai(_id_EE2753C1176F5C7E) && level.bot_personality_type[_id_EE2753C1176F5C7E.personality] == "active") {
          _id_EE2753C1176F5C7E.role = undefined;
          _id_8668B3FA2350C9B3 = 1;
          break;
        }
      }

      if(_id_8668B3FA2350C9B3) {
        bot_set_role("defender");
        return;
      }

      bot_set_role("attacker");
      return;
    } else
      bot_set_role("defender");
  }
}

bot_hardpoint_think() {
  self notify("bot_grnd_think");
  self endon("bot_grnd_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self botclearscriptgoal();

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("separation", 0);
  _id_B8C1E1E55C9691E4 = undefined;
  _id_BC9376A31C216786 = undefined;

  for(;;) {
    wait 0.05;

    if(!isDefined(level.currentobjective)) {
      continue;
    }
    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal()) {
      continue;
    }
    if(!isDefined(self.role))
      initialize_role();

    if(!istrue(self.bot_defending)) {
      _id_B8C1E1E55C9691E4 = undefined;
      _id_BC9376A31C216786 = undefined;
    }

    if(self.role == "attacker") {
      _id_7D8B092BACF8A8D8 = 0;
      _id_BC9376A31C216786 = undefined;

      if(!isDefined(_id_B8C1E1E55C9691E4))
        _id_7D8B092BACF8A8D8 = 1;
      else if(isDefined(level.currentobjective.trigger)) {
        if(_id_B8C1E1E55C9691E4 != level.currentobjective.trigger)
          _id_7D8B092BACF8A8D8 = 1;
      }

      if(_id_7D8B092BACF8A8D8) {
        _id_456B8F0EA933D0E5 = getclosestpointonnavmesh(level.currentobjective.trigger.origin, self);
        optional_params["min_goal_time"] = 1;
        optional_params["max_goal_time"] = 4;
        scripts\mp\bots\bots_strategy::bot_patrol_area(_id_456B8F0EA933D0E5, level.patrol_radius, optional_params);
        _id_B8C1E1E55C9691E4 = level.currentobjective.trigger;
      }

      continue;
    }

    if(self.role == "defender") {
      _id_B8C1E1E55C9691E4 = undefined;
      _id_D6180D62096F9CDC = 0;

      if(!isDefined(_id_BC9376A31C216786))
        _id_D6180D62096F9CDC = 1;
      else if(isDefined(level.currentobjective.trigger)) {
        if(_id_BC9376A31C216786 != level.currentobjective.trigger)
          _id_D6180D62096F9CDC = 1;
      }

      if(_id_D6180D62096F9CDC) {
        nodes = getnodesintrigger(level.currentobjective.trigger);

        if(nodes.size > 0) {
          optional_params["min_goal_time"] = 3;
          optional_params["max_goal_time"] = 6;
          scripts\mp\bots\bots_strategy::bot_capture_zone(level.currentobjective.trigger.origin, nodes, level.currentobjective.trigger, optional_params);
          _id_BC9376A31C216786 = level.currentobjective.trigger;
        }
      }
    }
  }
}

bot_attacker_limit_for_team(team) {
  _id_6ACE8681F94CDC7C = get_num_players_on_team(team);
  return int(int(_id_6ACE8681F94CDC7C) / 2) + 1 + int(_id_6ACE8681F94CDC7C) % 2;
}

bot_defender_limit_for_team(team) {
  _id_6ACE8681F94CDC7C = get_num_players_on_team(team);
  return max(int(int(_id_6ACE8681F94CDC7C) / 2) - 1, 0);
}

get_num_players_on_team(team) {
  _id_35B2ACE44B93C013 = 0;

  foreach(player in level.participants) {
    if(scripts\mp\utility\entity::isteamparticipant(player) && isDefined(player.team) && player.team == team)
      _id_35B2ACE44B93C013++;
  }

  return _id_35B2ACE44B93C013;
}

get_allied_attackers_for_team(team) {
  attackers = get_players_by_role("attacker", team);

  if(isDefined(level.currentobjective.trigger)) {
    foreach(player in level.players) {
      if(!isai(player) && isDefined(player.team) && player.team == team) {
        if(!player istouching(level.currentobjective.trigger))
          attackers = scripts\engine\utility::array_add(attackers, player);
      }
    }
  }

  return attackers;
}

get_allied_defenders_for_team(team) {
  _id_2FD93EA689E77097 = get_players_by_role("defender", team);

  if(isDefined(level.currentobjective.trigger)) {
    foreach(player in level.players) {
      if(!isai(player) && isDefined(player.team) && player.team == team) {
        if(player istouching(level.currentobjective.trigger))
          _id_2FD93EA689E77097 = scripts\engine\utility::array_add(_id_2FD93EA689E77097, player);
      }
    }
  }

  return _id_2FD93EA689E77097;
}

get_players_by_role(role, team) {
  players = [];

  foreach(player in level.participants) {
    if(!isDefined(player.team)) {
      continue;
    }
    if(isalive(player) && scripts\mp\utility\entity::isteamparticipant(player) && player.team == team && isDefined(player.role) && player.role == role)
      players[players.size] = player;
  }

  return players;
}

bot_set_role(_id_B7EAC42471AC7FAE) {
  self.role = _id_B7EAC42471AC7FAE;
  self botclearscriptgoal();
  scripts\mp\bots\bots_strategy::bot_defend_stop();
}

is_b_better_defender(a, b) {
  _id_434D144CD8A384A1 = a istouching(level.currentobjective.trigger);
  _id_E1EF322511A0D75C = b istouching(level.currentobjective.trigger);

  if(_id_434D144CD8A384A1 != _id_E1EF322511A0D75C) {
    if(_id_434D144CD8A384A1)
      return 0;

    return 1;
  }

  if(_id_434D144CD8A384A1) {
    if(a.role != b.role) {
      if(b.role == "defender")
        return 1;

      return 0;
    }
  }

  _id_385D89DEB0C96C1E = distance2dsquared(a.origin, level.currentobjective.trigger.origin);
  _id_EDEB7BA2F77891A7 = distance2dsquared(b.origin, level.currentobjective.trigger.origin);

  if(_id_385D89DEB0C96C1E < _id_EDEB7BA2F77891A7)
    return 1;

  return 0;
}

bot_hardpoint_ai_director_update() {
  level notify("bot_hardpoint_ai_director_update");
  level endon("bot_hardpoint_ai_director_update");
  level endon("game_ended");
  teams[0] = "allies";
  teams[1] = "axis";
  _id_315ADA03F3555768["allies"] = 0;
  _id_315ADA03F3555768["axis"] = 0;

  for(;;) {
    _id_E0CE35063064FB94 = "neutral";

    if(!isDefined(level.currentobjective)) {
      wait 1.0;
      continue;
    }

    if(isDefined(level.currentobjective.trigger))
      _id_E0CE35063064FB94 = level.currentobjective scripts\mp\gameobjects::getownerteam();

    foreach(team in teams) {
      _id_3E2F5D10887AEB24 = [];
      _id_EAD9B3CBCF05416C = [];

      if(team != _id_E0CE35063064FB94) {
        _id_315ADA03F3555768[team] = 0;

        foreach(player in level.participants) {
          if(scripts\mp\utility\entity::isteamparticipant(player) && isDefined(player.team) && player.team == team) {
            if(isbot(player) && (!isDefined(player.role) || player.role != "defender"))
              player bot_set_role("defender");
          }
        }

        continue;
      }

      _id_DD81F3B223F70502 = bot_attacker_limit_for_team(team);
      _id_C3FE770AB5FB04EE = bot_defender_limit_for_team(team);

      if(!_id_315ADA03F3555768[team]) {
        _id_315ADA03F3555768[team] = 1;
        _id_2857A3996FB3FA53 = [];

        foreach(player in level.participants) {
          if(scripts\mp\utility\entity::isteamparticipant(player) && isDefined(player.team) && player.team == team) {
            if(isbot(player))
              _id_2857A3996FB3FA53[_id_2857A3996FB3FA53.size] = player;
          }
        }

        _id_8B00F8B964FC840A = scripts\engine\utility::array_sort_with_func(_id_2857A3996FB3FA53, ::is_b_better_defender);

        if(_id_2857A3996FB3FA53.size < _id_C3FE770AB5FB04EE)
          _id_C3FE770AB5FB04EE = _id_2857A3996FB3FA53.size;

        _id_C3FE770AB5FB04EE = int(_id_C3FE770AB5FB04EE);

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C3FE770AB5FB04EE; _id_AC0E594AC96AA3A8++)
          _id_2857A3996FB3FA53[_id_AC0E594AC96AA3A8] bot_set_role("defender");

        for(_id_AC0E594AC96AA3A8 = _id_C3FE770AB5FB04EE; _id_AC0E594AC96AA3A8 < _id_2857A3996FB3FA53.size; _id_AC0E594AC96AA3A8++)
          _id_2857A3996FB3FA53[_id_AC0E594AC96AA3A8] bot_set_role("attacker");

        wait 1;
        continue;
      }

      attackers = get_allied_attackers_for_team(team);
      _id_2FD93EA689E77097 = get_allied_defenders_for_team(team);

      if(attackers.size > _id_DD81F3B223F70502) {
        _id_76912C7979E5A46B = 0;

        foreach(attacker in attackers) {
          if(isai(attacker)) {
            if(level.bot_personality_type[attacker.personality] == "stationary") {
              attacker bot_set_role("defender");
              _id_76912C7979E5A46B = 1;
              break;
            } else
              _id_3E2F5D10887AEB24 = scripts\engine\utility::array_add(_id_3E2F5D10887AEB24, attacker);
          }
        }

        if(!_id_76912C7979E5A46B && _id_3E2F5D10887AEB24.size > 0)
          scripts\engine\utility::random(_id_3E2F5D10887AEB24) bot_set_role("defender");
      }

      if(_id_2FD93EA689E77097.size > _id_C3FE770AB5FB04EE) {
        _id_75E6CF655A01F333 = 0;

        foreach(_id_EE2753C1176F5C7E in _id_2FD93EA689E77097) {
          if(isai(_id_EE2753C1176F5C7E)) {
            if(level.bot_personality_type[_id_EE2753C1176F5C7E.personality] == "active") {
              _id_EE2753C1176F5C7E bot_set_role("attacker");
              _id_75E6CF655A01F333 = 1;
              break;
            } else
              _id_EAD9B3CBCF05416C = scripts\engine\utility::array_add(_id_EAD9B3CBCF05416C, _id_EE2753C1176F5C7E);
          }
        }

        if(!_id_75E6CF655A01F333 && _id_EAD9B3CBCF05416C.size > 0)
          scripts\engine\utility::random(_id_EAD9B3CBCF05416C) bot_set_role("attacker");
      }

      if(_id_2FD93EA689E77097.size == 0) {
        _id_B9D34299856E0A60 = get_players_by_role("attacker", team);

        if(_id_B9D34299856E0A60.size > 0)
          scripts\engine\utility::random(_id_B9D34299856E0A60) bot_set_role("defender");
      }
    }

    wait 1.0;
  }
}

crate_can_use(crate) {
  if(isagent(self) && !isDefined(crate.boxtype))
    return 0;

  if(!scripts\mp\bots\bots::_id_9BD84CEDE4FE8F24(crate))
    return 0;

  return !scripts\mp\bots\bots_util::bot_is_defending() || scripts\mp\bots\bots_util::bot_is_protecting();
}

setup_bot_koth() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();

  while(!isDefined(level.objectives))
    wait 0.05;

  _id_7F989E71B934C9FC::bot_setup_objective_bottargets();

  foreach(objective in level.objectives)
  objective thread _id_7F989E71B934C9FC::monitor_zone_control();

  _id_7F989E71B934C9FC::bot_cache_entrances_to_gametype_array(level.objectives, "radio", level.bot_ignore_precalc_paths);
  level.bot_gametype_precaching_done = 1;
}

bot_headquarters_think() {
  self notify("bot_hq_think");
  self endon("bot_hq_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("grenade_objectives", 1);
  init_bot_game_headquarters();

  for(;;) {
    wait_time = randomintrange(1, 11) * 0.05;
    wait(wait_time);

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(level.radioobject)) {
      if(scripts\mp\bots\bots_util::bot_is_defending())
        scripts\mp\bots\bots_strategy::bot_defend_stop();

      _id_5DB2B7F3A1E635C4 = 1;

      if(self botgetscriptgoaltype() != "none") {
        distsq = distancesquared(self botgetscriptgoal(), self.origin);
        radius = self botgetscriptgoalRadius();

        if(distsq > radius * radius)
          _id_5DB2B7F3A1E635C4 = 0;
      }

      if(_id_5DB2B7F3A1E635C4) {
        _id_C99BCC1633FD3654 = self botfindrandomgoal();

        if(isDefined(_id_C99BCC1633FD3654))
          self botsetscriptgoal(_id_C99BCC1633FD3654, 128, "hunt");
      }

      continue;
    }

    _id_B3757ACF241CF25B = level.radioobject scripts\mp\gameobjects::getownerteam();

    if(self.team != _id_B3757ACF241CF25B) {
      if(!is_capturing_current_headquarters()) {
        _id_8C707E4FA194D7C5 = get_num_ai_capturing_headquarters();
        _id_F3D4CE970FBCD5B7 = find_current_radio().bot_nodes.size;

        if(_id_8C707E4FA194D7C5 < _id_F3D4CE970FBCD5B7)
          capture_current_headquarters();
        else if(!is_protecting_current_headquarters())
          protect_current_headquarters();
      }
    } else if(!is_protecting_current_headquarters()) {
      wait(randomfloat(2));

      if(isDefined(level.radioobject))
        protect_current_headquarters();
    }
  }
}

find_current_radio() {
  foreach(radio in level.radios) {
    if(radio.trig == level.radioobject.trigger)
      return radio;
  }
}

is_capturing_current_headquarters() {
  return scripts\mp\bots\bots_util::bot_is_capturing();
}

get_num_ai_capturing_headquarters() {
  total = 0;

  foreach(player in level.participants) {
    if(isai(player) && player.health > 0 && player.team == self.team && player is_capturing_current_headquarters())
      total++;
  }

  return total;
}

capture_current_headquarters() {
  _id_0A8A529C46AF43D6 = find_current_radio();
  optional_params["entrance_points_index"] = "radio" + _id_0A8A529C46AF43D6.objectivekey;
  scripts\mp\bots\bots_strategy::bot_capture_zone(_id_0A8A529C46AF43D6.origin, _id_0A8A529C46AF43D6.bot_nodes, undefined, optional_params);
}

is_protecting_current_headquarters() {
  return scripts\mp\bots\bots_util::bot_is_protecting();
}

protect_current_headquarters() {
  _id_FA52693CF4679C62 = self botgetworldsize();
  _id_DD6786927BDE6332 = (_id_FA52693CF4679C62[0] + _id_FA52693CF4679C62[1]) / 2;
  protect_radius = min(1000, _id_DD6786927BDE6332 / 4);
  scripts\mp\bots\bots_strategy::bot_protect_point(find_current_radio().origin, protect_radius);
}

init_bot_game_headquarters() {
  if(isDefined(level.bots_gametype_initialized) && level.bots_gametype_initialized) {
    return;
  }
  level.bots_gametype_initialized = 1;

  foreach(radio in level.radios)
  radio.bot_nodes = getnodesintrigger(radio.trig);
}