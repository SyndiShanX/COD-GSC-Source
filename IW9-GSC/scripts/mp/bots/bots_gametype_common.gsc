/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_common.gsc
****************************************************/

bot_cache_entrances_to_bombzones() {
  entrance_origin_points = [];
  _id_31AC0F14318B785F = [];
  index = 0;

  foreach(zone in level.objectives) {
    if(isDefined(zone.bottargets)) {
      if(zone.bottargets.size > 0) {
        if(isDefined(zone.objectivekey)) {
          entrance_origin_points[index] = scripts\engine\utility::random(zone.bottargets).origin;
          _id_31AC0F14318B785F[index] = "zone" + zone.objectivekey;
          index++;
        } else {}
      } else {}

      continue;
    }
  }

  bot_cache_entrances(entrance_origin_points, _id_31AC0F14318B785F);
}

bot_cache_entrances_to_gametype_array(array, _id_700B574A652AFB56, _id_CCA64496409970BC, _id_59D7820E096A5FF9) {
  wait 1.0;
  entrance_origin_points = [];
  _id_31AC0F14318B785F = [];
  _id_E435228617B823E7 = 0;

  foreach(gameobject in array) {
    _id_7D7A19F3663FB26C = gameobject.trigger;

    if(isDefined(_id_7D7A19F3663FB26C.bottarget))
      entrance_origin_points[_id_E435228617B823E7] = _id_7D7A19F3663FB26C.bottarget.origin;
    else {
      _id_7D7A19F3663FB26C.nearest_node = getclosestnodeinsight(_id_7D7A19F3663FB26C.origin);

      if(!isDefined(_id_7D7A19F3663FB26C.nearest_node) || _id_7D7A19F3663FB26C.nearest_node nodeisdisconnected()) {
        nodes = getnodesinradiussorted(_id_7D7A19F3663FB26C.origin, 256, 0);

        if(nodes.size > 0)
          _id_7D7A19F3663FB26C.nearest_node = nodes[0];
      }

      if(!isDefined(_id_7D7A19F3663FB26C.nearest_node)) {
        continue;
      }
      if(distance(_id_7D7A19F3663FB26C.nearest_node.origin, _id_7D7A19F3663FB26C.origin) > 130) {
        _id_7D7A19F3663FB26C.nearest_node = undefined;
        continue;
      }

      entrance_origin_points[_id_E435228617B823E7] = _id_7D7A19F3663FB26C.nearest_node.origin;
    }

    _id_31AC0F14318B785F[_id_E435228617B823E7] = _id_700B574A652AFB56 + gameobject.objectivekey;
    _id_E435228617B823E7++;
  }

  bot_cache_entrances(entrance_origin_points, _id_31AC0F14318B785F, _id_CCA64496409970BC, _id_59D7820E096A5FF9);
}

bot_cache_entrances(_id_24B68CCCCD2558A9, _id_6221A2F77B043913, _id_CCA64496409970BC, _id_59D7820E096A5FF9) {
  _id_FEF8F535F1F12918 = !isDefined(_id_CCA64496409970BC) || !_id_CCA64496409970BC;
  _id_129F7BAC538976FC = isDefined(_id_59D7820E096A5FF9) && _id_59D7820E096A5FF9;
  wait 0.1;

  if(_id_129F7BAC538976FC && _id_FEF8F535F1F12918) {
    nodes = getallnodes();

    foreach(node in nodes)
    node.on_path_from = undefined;
  }

  entrance_points = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_24B68CCCCD2558A9.size; _id_AC0E594AC96AA3A8++) {
    index = _id_6221A2F77B043913[_id_AC0E594AC96AA3A8];
    entrance_points[index] = findentrances(_id_24B68CCCCD2558A9[_id_AC0E594AC96AA3A8]);
    wait 0.05;

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < entrance_points[index].size; _id_AC0E5C4AC96AAA41++) {
      _id_0D32078955171127 = entrance_points[index][_id_AC0E5C4AC96AAA41];
      _id_0D32078955171127.is_precalculated_entrance = 1;
      _id_0D32078955171127.prone_visible_from[index] = scripts\mp\bots\bots_util::entrance_visible_from(_id_0D32078955171127.origin, _id_24B68CCCCD2558A9[_id_AC0E594AC96AA3A8], "prone");
      wait 0.05;
      _id_0D32078955171127.crouch_visible_from[index] = scripts\mp\bots\bots_util::entrance_visible_from(_id_0D32078955171127.origin, _id_24B68CCCCD2558A9[_id_AC0E594AC96AA3A8], "crouch");
      wait 0.05;
    }
  }

  precalculated_paths = [];

  if(_id_FEF8F535F1F12918) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_24B68CCCCD2558A9.size; _id_AC0E594AC96AA3A8++) {
      for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 + 1; _id_AC0E5C4AC96AAA41 < _id_24B68CCCCD2558A9.size; _id_AC0E5C4AC96AAA41++) {
        path = scripts\mp\bots\bots_util::get_extended_path(_id_24B68CCCCD2558A9[_id_AC0E594AC96AA3A8], _id_24B68CCCCD2558A9[_id_AC0E5C4AC96AAA41]);

        foreach(node in path)
        node.on_path_from[_id_6221A2F77B043913[_id_AC0E594AC96AA3A8]][_id_6221A2F77B043913[_id_AC0E5C4AC96AAA41]] = 1;
      }
    }
  }

  if(!isDefined(level.entrance_origin_points))
    level.entrance_origin_points = [];

  if(!isDefined(level.entrance_indices))
    level.entrance_indices = [];

  if(!isDefined(level.entrance_points))
    level.entrance_points = [];

  if(_id_129F7BAC538976FC) {
    level.entrance_origin_points = _id_24B68CCCCD2558A9;
    level.entrance_indices = _id_6221A2F77B043913;
    level.entrance_points = entrance_points;
  } else {
    level.entrance_origin_points = scripts\engine\utility::array_combine(level.entrance_origin_points, _id_24B68CCCCD2558A9);
    level.entrance_indices = scripts\engine\utility::array_combine(level.entrance_indices, _id_6221A2F77B043913);
    level.entrance_points = scripts\engine\utility::array_combine_non_integer_indices(level.entrance_points, entrance_points);
  }

  level.entrance_points_finished_caching = 1;
}

bot_add_missing_nodes(nodes, trigger) {
  if(trigger.classname == "trigger_radius") {
    _id_0D2D0BF810CF372E = getnodesinradius(trigger.origin, trigger.radius, 0, 100);
    _id_7C3BABD4364B03C4 = scripts\engine\utility::array_remove_array(_id_0D2D0BF810CF372E, nodes);

    if(_id_7C3BABD4364B03C4.size > 0)
      nodes = scripts\engine\utility::array_combine(nodes, _id_7C3BABD4364B03C4);
  } else if(trigger.classname == "trigger_multiple" || trigger.classname == "trigger_use_touch") {
    _id_6EFB87DC31950D0F[0] = trigger getpointinbounds(1, 1, 1);
    _id_6EFB87DC31950D0F[1] = trigger getpointinbounds(1, 1, -1);
    _id_6EFB87DC31950D0F[2] = trigger getpointinbounds(1, -1, 1);
    _id_6EFB87DC31950D0F[3] = trigger getpointinbounds(1, -1, -1);
    _id_6EFB87DC31950D0F[4] = trigger getpointinbounds(-1, 1, 1);
    _id_6EFB87DC31950D0F[5] = trigger getpointinbounds(-1, 1, -1);
    _id_6EFB87DC31950D0F[6] = trigger getpointinbounds(-1, -1, 1);
    _id_6EFB87DC31950D0F[7] = trigger getpointinbounds(-1, -1, -1);
    _id_067073C9D63FA853 = 0;

    foreach(point in _id_6EFB87DC31950D0F) {
      dist = distance(point, trigger.origin);

      if(dist > _id_067073C9D63FA853)
        _id_067073C9D63FA853 = dist;
    }

    _id_0D2D0BF810CF372E = getnodesinradius(trigger.origin, _id_067073C9D63FA853, 0, 200);

    foreach(node in _id_0D2D0BF810CF372E) {
      if(!ispointinvolume(node.origin, trigger)) {
        if(ispointinvolume(node.origin + (0, 0, 40), trigger) || ispointinvolume(node.origin + (0, 0, 80), trigger) || ispointinvolume(node.origin + (0, 0, 120), trigger))
          nodes = scripts\engine\utility::array_add(nodes, node);
      }
    }
  }

  return nodes;
}

bot_setup_objective_bottargets() {
  wait 1.0;
  bot_setup_bot_targets(level.objectives);
  level.bot_set_objective_bottargets = 1;
}

bot_setup_bot_targets(array) {
  foreach(_id_F7806D4CF24AACD3 in array) {
    if(!isDefined(_id_F7806D4CF24AACD3.bottargets))
      _id_F7806D4CF24AACD3.bottargets = bot_get_valid_nodes_in_trigger(_id_F7806D4CF24AACD3.trigger);
  }
}

bot_gametype_get_num_players_on_team(team) {
  _id_35B2ACE44B93C013 = 0;

  foreach(player in level.participants) {
    if(scripts\mp\utility\entity::isteamparticipant(player) && isDefined(player.team) && player.team == team)
      _id_35B2ACE44B93C013++;
  }

  return _id_35B2ACE44B93C013;
}

bot_gametype_get_allied_attackers_for_team(team, _id_F5B5B3EADE6D9680, _id_FEC94D2722FABAF4) {
  attackers = bot_gametype_get_players_by_role("attacker", team);

  foreach(player in level.players) {
    if(!isai(player) && isDefined(player.team) && player.team == team) {
      if(player bot_gametype_human_player_always_considered_attacker() || distancesquared(_id_F5B5B3EADE6D9680, player.origin) > squared(_id_FEC94D2722FABAF4))
        attackers = scripts\engine\utility::array_add(attackers, player);
    }
  }

  return attackers;
}

bot_gametype_get_allied_defenders_for_team(team, _id_F5B5B3EADE6D9680, _id_FEC94D2722FABAF4) {
  _id_2FD93EA689E77097 = bot_gametype_get_players_by_role("defender", team);

  foreach(player in level.players) {
    if(!isai(player) && isDefined(player.team) && player.team == team) {
      if(player bot_gametype_human_player_always_considered_defender() || distancesquared(_id_F5B5B3EADE6D9680, player.origin) <= squared(_id_FEC94D2722FABAF4))
        _id_2FD93EA689E77097 = scripts\engine\utility::array_add(_id_2FD93EA689E77097, player);
    }
  }

  return _id_2FD93EA689E77097;
}

bot_gametype_human_player_always_considered_attacker() {
  if(isDefined(level.bot_gametype_human_player_always_attacker))
    return self[[level.bot_gametype_human_player_always_attacker]]();

  return 0;
}

bot_gametype_human_player_always_considered_defender() {
  if(isDefined(level.bot_gametype_human_player_always_defender))
    return self[[level.bot_gametype_human_player_always_defender]]();

  return 0;
}

bot_gametype_set_role(_id_B7EAC42471AC7FAE) {
  self.role = _id_B7EAC42471AC7FAE;
  self botclearscriptgoal();
  scripts\mp\bots\bots_strategy::bot_defend_stop();
}

bot_gametype_get_players_by_role(role, team) {
  players = [];

  foreach(player in level.participants) {
    if(isDefined(player.team) && isalive(player) && scripts\mp\utility\entity::isteamparticipant(player) && player.team == team && isDefined(player.role) && player.role == role)
      players[players.size] = player;
  }

  return players;
}

bot_gametype_initialize_attacker_defender_role() {
  attackers = [[level.bot_gametype_allied_attackers_for_team]](self.team);
  _id_2FD93EA689E77097 = [[level.bot_gametype_allied_defenders_for_team]](self.team);
  _id_DD81F3B223F70502 = [[level.bot_gametype_attacker_limit_for_team]](self.team);
  _id_C3FE770AB5FB04EE = [[level.bot_gametype_defender_limit_for_team]](self.team);
  _id_30F9CA2FA8449648 = level.bot_personality_type[self.personality];

  if(_id_30F9CA2FA8449648 == "active") {
    if(attackers.size >= _id_DD81F3B223F70502) {
      _id_8668B3FA2350C9B3 = 0;

      foreach(attacker in attackers) {
        if(isai(attacker) && level.bot_personality_type[attacker.personality] == "stationary" && attacker bot_can_switch_to_defender()) {
          attacker.role = undefined;
          _id_8668B3FA2350C9B3 = 1;
          break;
        }
      }

      if(_id_8668B3FA2350C9B3) {
        bot_gametype_set_role("attacker");
        return;
      }

      bot_gametype_set_role("defender");
      return;
    } else
      bot_gametype_set_role("attacker");
  } else if(_id_30F9CA2FA8449648 == "stationary") {
    if(_id_2FD93EA689E77097.size >= _id_C3FE770AB5FB04EE) {
      _id_8668B3FA2350C9B3 = 0;

      foreach(_id_EE2753C1176F5C7E in _id_2FD93EA689E77097) {
        if(isai(_id_EE2753C1176F5C7E) && level.bot_personality_type[_id_EE2753C1176F5C7E.personality] == "active" && _id_EE2753C1176F5C7E bot_can_switch_to_attacker()) {
          _id_EE2753C1176F5C7E.role = undefined;
          _id_8668B3FA2350C9B3 = 1;
          break;
        }
      }

      if(_id_8668B3FA2350C9B3) {
        bot_gametype_set_role("defender");
        return;
      }

      bot_gametype_set_role("attacker");
      return;
    } else
      bot_gametype_set_role("defender");
  }
}

bot_gametype_attacker_defender_ai_director_update() {
  level notify("bot_gametype_attacker_defender_ai_director_update");
  level endon("bot_gametype_attacker_defender_ai_director_update");
  level endon("game_ended");
  teams = ["allies", "axis"];
  _id_2E28F7108FAA95FC = gettime() + 2000;

  for(;;) {
    if(gettime() > _id_2E28F7108FAA95FC) {
      _id_2E28F7108FAA95FC = gettime() + 1000;

      foreach(team in teams) {
        attackers = [[level.bot_gametype_allied_attackers_for_team]](team);
        _id_2FD93EA689E77097 = [[level.bot_gametype_allied_defenders_for_team]](team);
        _id_DD81F3B223F70502 = [[level.bot_gametype_attacker_limit_for_team]](team);
        _id_C3FE770AB5FB04EE = [[level.bot_gametype_defender_limit_for_team]](team);

        if(attackers.size > _id_DD81F3B223F70502) {
          _id_3E2F5D10887AEB24 = [];
          _id_76912C7979E5A46B = 0;

          foreach(attacker in attackers) {
            if(isai(attacker) && attacker bot_can_switch_to_defender()) {
              if(level.bot_personality_type[attacker.personality] == "stationary") {
                attacker bot_gametype_set_role("defender");
                _id_76912C7979E5A46B = 1;
                break;
              } else
                _id_3E2F5D10887AEB24 = scripts\engine\utility::array_add(_id_3E2F5D10887AEB24, attacker);
            }
          }

          if(!_id_76912C7979E5A46B && _id_3E2F5D10887AEB24.size > 0)
            scripts\engine\utility::random(_id_3E2F5D10887AEB24) bot_gametype_set_role("defender");
        }

        if(_id_2FD93EA689E77097.size > _id_C3FE770AB5FB04EE) {
          _id_EAD9B3CBCF05416C = [];
          _id_75E6CF655A01F333 = 0;

          foreach(_id_EE2753C1176F5C7E in _id_2FD93EA689E77097) {
            if(isai(_id_EE2753C1176F5C7E) && _id_EE2753C1176F5C7E bot_can_switch_to_attacker()) {
              if(level.bot_personality_type[_id_EE2753C1176F5C7E.personality] == "active") {
                _id_EE2753C1176F5C7E bot_gametype_set_role("attacker");
                _id_75E6CF655A01F333 = 1;
                break;
              } else
                _id_EAD9B3CBCF05416C = scripts\engine\utility::array_add(_id_EAD9B3CBCF05416C, _id_EE2753C1176F5C7E);
            }
          }

          if(!_id_75E6CF655A01F333 && _id_EAD9B3CBCF05416C.size > 0)
            scripts\engine\utility::random(_id_EAD9B3CBCF05416C) bot_gametype_set_role("attacker");
        }
      }
    }

    wait 0.05;
  }
}

bot_can_switch_to_attacker() {
  if(isDefined(level.bot_gametype_allowed_to_switch_to_attacker))
    return self[[level.bot_gametype_allowed_to_switch_to_attacker]]();

  return 1;
}

bot_can_switch_to_defender() {
  if(isDefined(level.bot_gametype_allowed_to_switch_to_defender))
    return self[[level.bot_gametype_allowed_to_switch_to_defender]]();

  return 1;
}

bot_verify_and_cache_bombzones(_id_D36A7E987347E24D) {
  _id_99E49CED1B12AB57 = 0;

  if(!_id_99E49CED1B12AB57)
    bot_cache_entrances_to_bombzones();

  return !_id_99E49CED1B12AB57;
}

bot_get_valid_nodes_in_trigger(trigger) {
  nodes = getnodesintrigger(trigger, 1);
  _id_2AAD46D2DF2BCE53 = [];

  foreach(node in nodes) {
    if(!node nodeisdisconnected() && !scripts\engine\utility::isnode3d(node) && node.type != "Begin" && node.type != "End")
      _id_2AAD46D2DF2BCE53[_id_2AAD46D2DF2BCE53.size] = node;
  }

  return _id_2AAD46D2DF2BCE53;
}

bot_cache_entrances_to_zones(zones) {
  entrance_origin_points = [];
  _id_31AC0F14318B785F = [];
  _id_BD09BC96A2145F05 = 0;

  foreach(zone in zones) {
    _id_19CF496CAB075BEC = 0;
    zone.entrance_indices = [];
    zone.zone_bounds = calculate_zone_node_extents(zone);
    zone.center_node = zone_get_node_nearest_2d_bounds(zone, 0, 0);
    _id_3348F0EF95981795 = [(0, 0, 0), (1, 1, 0), (1, -1, 0), (-1, 1, 0), (-1, -1, 0)];

    foreach(_id_1859C8509B4F12EF in _id_3348F0EF95981795) {
      node = zone_get_node_nearest_2d_bounds(zone, _id_1859C8509B4F12EF[0], _id_1859C8509B4F12EF[1]);
      entrance_origin_points[_id_BD09BC96A2145F05] = node.origin;
      _id_1D52185A4E4DEE51 = zone.objectivekey + "_" + _id_19CF496CAB075BEC;
      _id_31AC0F14318B785F[_id_BD09BC96A2145F05] = _id_1D52185A4E4DEE51;
      zone.entrance_indices[zone.entrance_indices.size] = _id_1D52185A4E4DEE51;
      _id_BD09BC96A2145F05++;
      _id_19CF496CAB075BEC++;
    }
  }

  bot_cache_entrances(entrance_origin_points, _id_31AC0F14318B785F, 1);
}

calculate_zone_node_extents(zone) {
  _id_DC8625458EE5ED14 = spawnStruct();
  _id_DC8625458EE5ED14.min_pt = (999999, 999999, 999999);
  _id_DC8625458EE5ED14.max_pt = (-999999, -999999, -999999);

  foreach(node in zone.nodes) {
    _id_DC8625458EE5ED14.min_pt = (min(node.origin[0], _id_DC8625458EE5ED14.min_pt[0]), min(node.origin[1], _id_DC8625458EE5ED14.min_pt[1]), min(node.origin[2], _id_DC8625458EE5ED14.min_pt[2]));
    _id_DC8625458EE5ED14.max_pt = (max(node.origin[0], _id_DC8625458EE5ED14.max_pt[0]), max(node.origin[1], _id_DC8625458EE5ED14.max_pt[1]), max(node.origin[2], _id_DC8625458EE5ED14.max_pt[2]));
  }

  _id_DC8625458EE5ED14.center = ((_id_DC8625458EE5ED14.min_pt[0] + _id_DC8625458EE5ED14.max_pt[0]) / 2, (_id_DC8625458EE5ED14.min_pt[1] + _id_DC8625458EE5ED14.max_pt[1]) / 2, (_id_DC8625458EE5ED14.min_pt[2] + _id_DC8625458EE5ED14.max_pt[2]) / 2);
  _id_DC8625458EE5ED14.half_size = (_id_DC8625458EE5ED14.max_pt[0] - _id_DC8625458EE5ED14.center[0], _id_DC8625458EE5ED14.max_pt[1] - _id_DC8625458EE5ED14.center[1], _id_DC8625458EE5ED14.max_pt[2] - _id_DC8625458EE5ED14.center[2]);
  _id_DC8625458EE5ED14.radius = max(_id_DC8625458EE5ED14.half_size[0], _id_DC8625458EE5ED14.half_size[1]);
  return _id_DC8625458EE5ED14;
}

zone_get_node_nearest_2d_bounds(zone, _id_D83E63DB6C0197B6, _id_3653EB9930616B55) {
  _id_CA39ECDA1B5B394D = (zone.zone_bounds.center[0] + _id_D83E63DB6C0197B6 * zone.zone_bounds.half_size[0], zone.zone_bounds.center[1] + _id_3653EB9930616B55 * zone.zone_bounds.half_size[1], 0);
  _id_9BDE6CEB27BC4985 = undefined;
  closest_dist_sq = 9999999;

  foreach(node in zone.nodes) {
    _id_ABD9EE4725B96FC2 = distance2dsquared(node.origin, _id_CA39ECDA1B5B394D);

    if(_id_ABD9EE4725B96FC2 < closest_dist_sq) {
      closest_dist_sq = _id_ABD9EE4725B96FC2;
      _id_9BDE6CEB27BC4985 = node;
    }
  }

  return _id_9BDE6CEB27BC4985;
}

monitor_zone_control() {
  self notify("monitor_zone_control");
  self endon("monitor_zone_control");
  self endon("death");
  level endon("game_ended");
  _id_800054CA1A89DACE = self.origin;

  if(!isDefined(_id_800054CA1A89DACE))
    _id_800054CA1A89DACE = self.curorigin;

  if(level.mapname == "mp_townhouses" && self.objectivekey == "3")
    _id_800054CA1A89DACE = (6791, -8309, 100);

  zone = getzonenearest(_id_800054CA1A89DACE);

  for(;;) {
    team = "none";

    if(isDefined(self.gameobject))
      team = self.gameobject scripts\mp\gameobjects::getownerteam();

    if(team == "neutral" || team == "none")
      botzonesetteam(zone, "free");
    else
      botzonesetteam(zone, team);

    wait 1.0;
  }
}

monitor_bombzone_control() {
  self notify("monitor_bombzone_control");
  self endon("monitor_bombzone_control");
  self endon("death");
  level endon("game_ended");
  zone = getzonenearest(self.curorigin);

  if(!isDefined(zone)) {
    return;
  }
  for(;;) {
    if(self.bombplanted)
      _id_16A1AB6DFEB8D692 = scripts\engine\utility::get_enemy_team(self.ownerteam);
    else
      _id_16A1AB6DFEB8D692 = self.ownerteam;

    if(_id_16A1AB6DFEB8D692 == "neutral" || _id_16A1AB6DFEB8D692 == "any")
      _id_16A1AB6DFEB8D692 = "free";

    botzonesetteam(zone, _id_16A1AB6DFEB8D692);
    wait 1.0;
  }
}

find_closest_bombzone_to_player(player) {
  _id_DC6F87D01AD606EF = undefined;
  _id_F2194E18677893C8 = 999999999;

  foreach(zone in level.objectives) {
    distsq = distancesquared(zone.curorigin, player.origin);

    if(distsq < _id_F2194E18677893C8) {
      _id_DC6F87D01AD606EF = zone;
      _id_F2194E18677893C8 = distsq;
    }
  }

  return _id_DC6F87D01AD606EF;
}

get_living_players_on_team(team, _id_11739F6565C4BF01) {
  players = [];

  foreach(player in level.participants) {
    if(!isDefined(player.team)) {
      continue;
    }
    if(scripts\mp\utility\player::isreallyalive(player) && scripts\mp\utility\entity::isteamparticipant(player) && player.team == team) {
      if(!isDefined(_id_11739F6565C4BF01) || _id_11739F6565C4BF01 && isai(player) && isDefined(player.role))
        players[players.size] = player;
    }
  }

  return players;
}

get_bombzone_node_to_plant_on(_id_EEF26A325310D3AF, _id_5A63F206B448F5BD) {
  if(_id_EEF26A325310D3AF.bottargets.size >= 2) {
    if(_id_5A63F206B448F5BD)
      _id_DD2A0954EA29EA00 = self botnodescoremultiple(_id_EEF26A325310D3AF.bottargets, "node_exposed");
    else
      _id_DD2A0954EA29EA00 = self botnodescoremultiple(_id_EEF26A325310D3AF.bottargets, "node_hide_anywhere", "ignore_occupancy");

    _id_0E721DDCD54F8465 = self botgetdifficultysetting("strategyLevel") * 0.3;
    _id_4CBE365D7F1699EA = (self botgetdifficultysetting("strategyLevel") + 1) * 0.15;
    _id_82D7851272CA820D = scripts\engine\utility::array_randomize(_id_EEF26A325310D3AF.bottargets);

    foreach(node in _id_82D7851272CA820D) {
      if(!scripts\engine\utility::array_contains(_id_DD2A0954EA29EA00, node))
        _id_DD2A0954EA29EA00[_id_DD2A0954EA29EA00.size] = node;
    }

    if(randomfloat(1.0) < _id_0E721DDCD54F8465) {
      return _id_DD2A0954EA29EA00[0];
      return;
    }

    if(randomfloat(1.0) < _id_4CBE365D7F1699EA) {
      return _id_DD2A0954EA29EA00[1];
      return;
    }

    return scripts\engine\utility::random(_id_DD2A0954EA29EA00);
    return;
    return;
  } else
    return _id_EEF26A325310D3AF.bottargets[0];
}

get_bombzone_node_to_defuse_on(_id_EEF26A325310D3AF) {
  if(_id_EEF26A325310D3AF.bottargets.size >= 2) {
    _id_DD2A0954EA29EA00 = self botnodescoremultiple(_id_EEF26A325310D3AF.bottargets, "node_hide_anywhere", "ignore_occupancy");
    _id_199A6276B58CE0E0 = self botgetdifficultysetting("strategyLevel") * 0.3;
    _id_FABE802612D28C15 = (self botgetdifficultysetting("strategyLevel") + 1) * 0.15;
    _id_82D7851272CA820D = scripts\engine\utility::array_randomize(_id_EEF26A325310D3AF.bottargets);

    foreach(node in _id_82D7851272CA820D) {
      if(!scripts\engine\utility::array_contains(_id_DD2A0954EA29EA00, node))
        _id_DD2A0954EA29EA00[_id_DD2A0954EA29EA00.size] = node;
    }

    if(randomfloat(1.0) < _id_199A6276B58CE0E0) {
      return _id_DD2A0954EA29EA00[0];
      return;
    }

    if(randomfloat(1.0) < _id_FABE802612D28C15) {
      return _id_DD2A0954EA29EA00[1];
      return;
    }

    return scripts\engine\utility::random(_id_DD2A0954EA29EA00);
    return;
    return;
  } else
    return _id_EEF26A325310D3AF.bottargets[0];
}

bombzone_press_use(time, _id_206BF0AC411B2257, _id_5B45D81D67839650, dont_prone) {
  _id_8E7073E75873765A = 0;

  if(self botgetdifficultysetting("strategyLevel") == 1)
    _id_8E7073E75873765A = 40;
  else if(self botgetdifficultysetting("strategyLevel") >= 2)
    _id_8E7073E75873765A = 80;

  if(randomint(100) < _id_8E7073E75873765A && !(isDefined(dont_prone) && dont_prone)) {
    self botsetstance("prone");
    wait 0.2;
  }

  if(self botgetdifficultysetting("strategyLevel") > 0 && !_id_5B45D81D67839650) {
    childthread notify_planter_on_whizby();
    childthread notify_planter_on_damage();
  }

  self botpressbutton("use", time);
  result = scripts\mp\bots\bots_util::bot_usebutton_wait(time, _id_206BF0AC411B2257, "use_interrupted");
  self botsetstance("none");
  self botclearbutton("use");
  _id_F4B4C81B7E99C586 = result == _id_206BF0AC411B2257;
  return _id_F4B4C81B7E99C586;
}

notify_planter_on_whizby() {
  self endon("stop_usebutton_watcher");
  _id_5E59607CBB05E67C = find_closest_bombzone_to_player(self);
  self waittill("bulletwhizby", _id_7176B6A64D4D823B);

  if(!isDefined(_id_7176B6A64D4D823B.team) || _id_7176B6A64D4D823B.team != self.team) {
    _id_546BDD6F69FD53E0 = _id_5E59607CBB05E67C.usetime - _id_5E59607CBB05E67C.curprogress;

    if(_id_546BDD6F69FD53E0 > 1000)
      self notify("use_interrupted");
  }
}

notify_planter_on_damage() {
  self endon("stop_usebutton_watcher");
  self waittill("damage", amount, attacker);

  if(!isDefined(attacker.team) || attacker.team != self.team)
    self notify("use_interrupted");
}

get_ai_hearing_bomb_plant_sound(type) {
  _id_C4C04E5085782B42 = [];

  if(!istrue(level.silentplant)) {
    players = get_living_players_on_team(scripts\engine\utility::get_enemy_team(self.team));

    foreach(player in players) {
      if(!isai(player)) {
        continue;
      }
      _id_7609E1675A1F5BB8 = 0;

      if(type == "plant")
        _id_7609E1675A1F5BB8 = 300 + player botgetdifficultysetting("strategyLevel") * 100;
      else if(type == "defuse")
        _id_7609E1675A1F5BB8 = 500 + player botgetdifficultysetting("strategyLevel") * 500;

      if(distancesquared(player.origin, self.origin) < squared(_id_7609E1675A1F5BB8))
        _id_C4C04E5085782B42[_id_C4C04E5085782B42.size] = player;
    }
  }

  return _id_C4C04E5085782B42;
}