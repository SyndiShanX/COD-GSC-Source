/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_tdef.gsc
**************************************************/

main() {
  setup_callbacks();
  setup_bot_flag();
  thread monitor_flag_carrier();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_tdef_think;
}

setup_bot_flag() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled(1);
  level.protect_radius = 600;
  level.bodyguard_radius = 400;
  thread bot_flag_ai_director_update();
  level.bot_gametype_precaching_done = 1;
}

bot_get_tdef_flag() {
  return level.defenderflag;
}

bot_get_flag_carrier() {
  if(isDefined(level.defenderflag.carrier))
    return level.defenderflag.carrier;

  return undefined;
}

bot_get_enemy_team() {
  if(self.team == "allies")
    return "axis";

  return "allies";
}

bot_tdef_think() {
  self notify("bot_flag_think");
  self endon("bot_flag_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("separation", 0);
  _id_C51208294F4D77D1 = undefined;
  _id_78BFF961DF1C9FBD = undefined;

  for(;;) {
    wait 0.05;

    if(!isDefined(self.role)) {
      initialize_flag_role();
      _id_C51208294F4D77D1 = undefined;
    }

    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal()) {
      _id_C51208294F4D77D1 = undefined;
      continue;
    }

    if(self.role != "carrier" && isDefined(self.carryobject)) {
      _id_C51208294F4D77D1 = undefined;
      flag_set_role("carrier");
    }

    if(self.role == "carrier") {
      if(isDefined(self.carryobject)) {
        _id_6F1937277208C460 = 0;

        if(isDefined(self.enemy))
          _id_6F1937277208C460 = distancesquared(self.enemy.origin, self.origin);

        if(isDefined(self.enemy) && _id_6F1937277208C460 < 9216) {} else {}

        self botclearscriptgoal();

        if(!isDefined(_id_78BFF961DF1C9FBD))
          _id_78BFF961DF1C9FBD = gettime() + randomintrange(500, 1000);

        if(gettime() > _id_78BFF961DF1C9FBD)
          _id_78BFF961DF1C9FBD = gettime() + randomintrange(500, 1000);
      } else {
        _id_CB042FAFEE68E950 = bot_get_tdef_flag();

        if(!isDefined(_id_CB042FAFEE68E950)) {
          carrier = bot_get_flag_carrier();

          if(isDefined(carrier) && carrier != self)
            initialize_flag_role();
        } else {
          self botsetscriptgoal(_id_CB042FAFEE68E950.curorigin, 16, "objective");
          continue;
        }
      }
    } else
      _id_C51208294F4D77D1 = undefined;

    if(self.role == "attacker") {
      _id_CB042FAFEE68E950 = bot_get_tdef_flag();

      if(!isDefined(_id_CB042FAFEE68E950)) {
        carrier = bot_get_flag_carrier();

        if(isDefined(carrier)) {
          if(!scripts\mp\bots\bots_util::bot_is_guarding_player(carrier))
            scripts\mp\bots\bots_strategy::bot_guard_player(carrier, level.bodyguard_radius);
        }
      } else if(!istrue(_id_CB042FAFEE68E950.isresetting) && !istrue(_id_CB042FAFEE68E950.in_goal)) {
        _id_702E9B4033EA2748 = getclosestpointonnavmesh(_id_CB042FAFEE68E950.curorigin);

        if(!scripts\mp\bots\bots_util::bot_is_defending_point(_id_702E9B4033EA2748))
          scripts\mp\bots\bots_strategy::bot_protect_point(_id_702E9B4033EA2748, level.protect_radius);
      }

      continue;
    }

    if(self.role == "defender") {
      _id_DA0E11B0A9FA934B = level.defenderflag.carrier;
      goal = _id_DA0E11B0A9FA934B.origin;

      if(!scripts\mp\bots\bots_util::bot_is_defending_point(goal))
        scripts\mp\bots\bots_strategy::bot_protect_point(goal, level.protect_radius);
    }
  }
}

initialize_flag_role() {
  attackers = get_allied_attackers_for_team(self.team);
  _id_2FD93EA689E77097 = get_allied_defenders_for_team(self.team);
  _id_DD81F3B223F70502 = flag_bot_attacker_limit_for_team(self.team);
  _id_C3FE770AB5FB04EE = flag_bot_defender_limit_for_team(self.team);
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
        flag_set_role("attacker");
        return;
      }

      flag_set_role("defender");
      return;
    } else
      flag_set_role("attacker");
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
        flag_set_role("defender");
        return;
      }

      flag_set_role("attacker");
      return;
    } else
      flag_set_role("defender");
  }
}

bot_flag_ai_director_update() {
  level notify("bot_flag_ai_director_update");
  level endon("bot_flag_ai_director_update");
  level endon("game_ended");
  teams[0] = "allies";
  teams[1] = "axis";
  _id_352C449F6F15C3C8 = [];

  for(;;) {
    foreach(team in teams) {
      _id_DD81F3B223F70502 = flag_bot_attacker_limit_for_team(team);
      _id_C3FE770AB5FB04EE = flag_bot_defender_limit_for_team(team);
      attackers = get_allied_attackers_for_team(team);
      _id_2FD93EA689E77097 = get_allied_defenders_for_team(team);

      if(attackers.size > _id_DD81F3B223F70502) {
        _id_3E2F5D10887AEB24 = [];
        _id_76912C7979E5A46B = 0;

        foreach(attacker in attackers) {
          if(isai(attacker)) {
            if(level.bot_personality_type[attacker.personality] == "stationary") {
              attacker flag_set_role("defender");
              _id_76912C7979E5A46B = 1;
              break;
            } else
              _id_3E2F5D10887AEB24 = scripts\engine\utility::array_add(_id_3E2F5D10887AEB24, attacker);
          }
        }

        if(!_id_76912C7979E5A46B && _id_3E2F5D10887AEB24.size > 0)
          scripts\engine\utility::random(_id_3E2F5D10887AEB24) flag_set_role("defender");
      }

      if(_id_2FD93EA689E77097.size > _id_C3FE770AB5FB04EE) {
        _id_EAD9B3CBCF05416C = [];
        _id_75E6CF655A01F333 = 0;

        foreach(_id_EE2753C1176F5C7E in _id_2FD93EA689E77097) {
          if(isai(_id_EE2753C1176F5C7E)) {
            if(level.bot_personality_type[_id_EE2753C1176F5C7E.personality] == "active") {
              _id_EE2753C1176F5C7E flag_set_role("attacker");
              _id_75E6CF655A01F333 = 1;
              break;
            } else
              _id_EAD9B3CBCF05416C = scripts\engine\utility::array_add(_id_EAD9B3CBCF05416C, _id_EE2753C1176F5C7E);
          }
        }

        if(!_id_75E6CF655A01F333 && _id_EAD9B3CBCF05416C.size > 0)
          scripts\engine\utility::random(_id_EAD9B3CBCF05416C) flag_set_role("attacker");
      }

      _id_CB042FAFEE68E950 = bot_get_tdef_flag();

      if(isDefined(_id_CB042FAFEE68E950)) {
        _id_7480BEB51DF7A34E = pick_flagcarrier(team, _id_CB042FAFEE68E950);

        if(isDefined(_id_7480BEB51DF7A34E) && isDefined(_id_7480BEB51DF7A34E.role) && _id_7480BEB51DF7A34E.role != "carrier") {
          if(!isDefined(_id_7480BEB51DF7A34E.carryobject)) {
            previouscarrier = _id_352C449F6F15C3C8[team];

            if(isDefined(previouscarrier))
              previouscarrier flag_set_role(undefined);

            _id_7480BEB51DF7A34E flag_set_role("carrier");
            _id_352C449F6F15C3C8[_id_7480BEB51DF7A34E.team] = _id_7480BEB51DF7A34E;
          }
        }
      }
    }

    wait 1.0;
  }
}

flag_bot_attacker_limit_for_team(team) {
  _id_6ACE8681F94CDC7C = flag_num_players_on_team(team);
  return _id_6ACE8681F94CDC7C;
}

flag_bot_defender_limit_for_team(team) {
  return 0;
}

flag_num_players_on_team(team) {
  _id_35B2ACE44B93C013 = 0;

  foreach(player in level.participants) {
    if(scripts\mp\utility\entity::isteamparticipant(player) && isDefined(player.team) && player.team == team)
      _id_35B2ACE44B93C013++;
  }

  return _id_35B2ACE44B93C013;
}

pick_flagcarrier(team, _id_CB042FAFEE68E950) {
  _id_DF206C6F376359FD = undefined;
  _id_84D4866087B00608 = undefined;

  foreach(player in level.participants) {
    if(!isDefined(player.team)) {
      continue;
    }
    if(player.team != team) {
      continue;
    }
    if(!isalive(player)) {
      continue;
    }
    if(!isai(player)) {
      continue;
    }
    if(isDefined(player.role) && player.role == "defender") {
      continue;
    }
    distsq = distancesquared(player.origin, _id_CB042FAFEE68E950.curorigin);

    if(!isDefined(_id_84D4866087B00608) || distsq < _id_84D4866087B00608) {
      _id_84D4866087B00608 = distsq;
      _id_DF206C6F376359FD = player;
    }
  }

  if(isDefined(_id_DF206C6F376359FD))
    return _id_DF206C6F376359FD;

  return undefined;
}

get_allied_attackers_for_team(team) {
  attackers = get_players_by_role("attacker", team);
  return attackers;
}

get_allied_defenders_for_team(team) {
  _id_2FD93EA689E77097 = get_players_by_role("defender", team);
  return _id_2FD93EA689E77097;
}

flag_set_role(_id_B7EAC42471AC7FAE) {
  self.role = _id_B7EAC42471AC7FAE;
  self botclearscriptgoal();
  scripts\mp\bots\bots_strategy::bot_defend_stop();
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

monitor_flag_carrier() {
  level endon("game_ended");
  _id_1C29730020F199CE = undefined;

  for(;;) {
    carrier = bot_get_flag_carrier();

    if(!isDefined(_id_1C29730020F199CE) || !isDefined(carrier) || carrier != _id_1C29730020F199CE) {
      if(isDefined(_id_1C29730020F199CE) && _id_1C29730020F199CE.threatbias == 505)
        _id_1C29730020F199CE.threatbias = 0;

      _id_1C29730020F199CE = carrier;
    }

    if(isDefined(carrier) && carrier.threatbias == 0)
      carrier.threatbias = 505;

    wait 0.05;
  }
}