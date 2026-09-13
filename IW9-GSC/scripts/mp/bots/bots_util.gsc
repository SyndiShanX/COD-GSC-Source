/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_util.gsc
***********************************************/

bot_get_nodes_in_cone(_id_76C663E82A2008DC, _id_21B0311D64CADFA2, _id_6BD958BBAA5FDFFE, _id_50900C536441AF50) {
  _id_685B8946E5EAC800 = getnodesinradius(self.origin, _id_21B0311D64CADFA2, _id_76C663E82A2008DC);
  _id_6F3D9EC6437C14F2 = [];
  _id_EFB3AD3709FA0C8C = self getnearestnode();
  _id_B000432483BA2056 = anglesToForward(self getplayerangles());
  _id_C38D0BA6459AC5D1 = vectorNormalize(_id_B000432483BA2056 * (1, 1, 0));

  foreach(node in _id_685B8946E5EAC800) {
    _id_0D49D19E3C272366 = vectorNormalize((node.origin - self.origin) * (1, 1, 0));
    dot = vectordot(_id_0D49D19E3C272366, _id_C38D0BA6459AC5D1);

    if(dot > _id_6BD958BBAA5FDFFE) {
      if(!_id_50900C536441AF50 || isDefined(_id_EFB3AD3709FA0C8C) && nodesvisible(node, _id_EFB3AD3709FA0C8C, 1))
        _id_6F3D9EC6437C14F2[_id_6F3D9EC6437C14F2.size] = node;
    }
  }

  return _id_6F3D9EC6437C14F2;
}

bot_goal_can_override(_id_BDBEA41B82DA516B, _id_BDBEA51B82DA539E) {
  if(_id_BDBEA41B82DA516B == "none")
    return _id_BDBEA51B82DA539E == "none";
  else if(_id_BDBEA41B82DA516B == "hunt")
    return _id_BDBEA51B82DA539E == "hunt" || _id_BDBEA51B82DA539E == "none";
  else if(_id_BDBEA41B82DA516B == "guard")
    return _id_BDBEA51B82DA539E == "guard" || _id_BDBEA51B82DA539E == "hunt" || _id_BDBEA51B82DA539E == "none";
  else if(_id_BDBEA41B82DA516B == "objective")
    return _id_BDBEA51B82DA539E == "objective" || _id_BDBEA51B82DA539E == "guard" || _id_BDBEA51B82DA539E == "hunt" || _id_BDBEA51B82DA539E == "none";
  else if(_id_BDBEA41B82DA516B == "critical")
    return _id_BDBEA51B82DA539E == "critical" || _id_BDBEA51B82DA539E == "objective" || _id_BDBEA51B82DA539E == "guard" || _id_BDBEA51B82DA539E == "hunt" || _id_BDBEA51B82DA539E == "none";
  else if(_id_BDBEA41B82DA516B == "tactical")
    return 1;
}

bot_set_personality(personality) {
  self botsetpersonality(personality);
  scripts\mp\bots\bots_personality::bot_assign_personality_functions();
  self botclearscriptgoal();
}

bot_set_difficulty(difficulty, _id_89ED03DBD38CD74C) {
  if(difficulty == "default")
    difficulty = bot_choose_difficulty_for_default();

  _id_5E3A9E8959ABB91C = self botgetdifficulty();
  self botsetdifficulty(difficulty);

  if(isPlayer(self) && _id_5E3A9E8959ABB91C != difficulty) {
    self.pers["rankxp"] = get_rank_xp_for_bot();
    scripts\mp\rank::playerupdaterank();
  }
}

bot_choose_difficulty_for_default() {
  if(!isDefined(level.bot_difficulty_defaults)) {
    level.bot_difficulty_defaults = [];

    if(level.rankedmatch) {
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "normal";
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "hard";
    } else {
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "easy";
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "normal";
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "hard";
    }
  }

  if(!isDefined(level.bot_next_difficulty_type_index))
    level.bot_next_difficulty_type_index = [];

  if(!isDefined(level.bot_next_difficulty_type_index["allies"]))
    level.bot_next_difficulty_type_index["allies"] = 0;

  if(!isDefined(level.bot_next_difficulty_type_index["axis"]))
    level.bot_next_difficulty_type_index["axis"] = 0;

  if(!isDefined(level.bot_next_difficulty_type_index["all"]))
    level.bot_next_difficulty_type_index["all"] = 0;

  if(!isDefined(self.pers["bot_chosen_difficulty"])) {
    _id_3B15057D7D685616 = undefined;
    team = "all";

    if(level.teambased) {
      team = self.team;

      if(!isDefined(team))
        team = self.bot_team;

      if(!isDefined(team))
        team = self.pers["team"];

      if(isDefined(team) && !isDefined(level.bot_next_difficulty_type_index[team]))
        team = "all";
    }

    _id_3B15057D7D685616 = level.bot_next_difficulty_type_index[team];
    _id_6A91FB0A2FC69E09 = level.bot_difficulty_defaults[_id_3B15057D7D685616];
    self.pers["bot_chosen_difficulty"] = get_difficulty_for_difficulty_type(_id_6A91FB0A2FC69E09);
    level.bot_next_difficulty_type_index[team] = (level.bot_next_difficulty_type_index[team] + 1) % level.bot_difficulty_defaults.size;
  }

  return self.pers["bot_chosen_difficulty"];
}

get_difficulty_for_difficulty_type(_id_09D294094DD8C5F1) {
  if(_id_09D294094DD8C5F1 == "easy")
    return "recruit";
  else if(_id_09D294094DD8C5F1 == "normal")
    return "regular";
  else if(_id_09D294094DD8C5F1 == "hard")
    return scripts\engine\utility::random(["hardened", "veteran"]);
  else {}
}

bot_is_capturing() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "capture" || self.bot_defending_type == "capture_zone")
      return 1;
  }

  return 0;
}

bot_is_patrolling() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "patrol")
      return 1;
  }

  return 0;
}

bot_is_protecting() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "protect" || self.bot_defending_type == "protect_zone")
      return 1;
  }

  return 0;
}

bot_is_bodyguarding() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "bodyguard")
      return 1;
  }

  return 0;
}

bot_is_defending() {
  return isDefined(self.bot_defending);
}

bot_is_defending_point(point) {
  if(bot_is_defending()) {
    if(bot_vectors_are_equal(self.bot_defending_center, point))
      return 1;
  }

  return 0;
}

bot_is_guarding_player(player) {
  if(bot_is_bodyguarding() && self.bot_defend_player_guarding == player)
    return 1;

  return 0;
}

entrance_visible_from(_id_418AFDEFE253D28A, _id_A0556100A6D18404, stance) {
  _id_09A0552027241E9D = (0, 0, 11);
  _id_7434285528B2568B = (0, 0, 40);
  offset = undefined;

  if(stance == "stand")
    return 1;
  else if(stance == "crouch")
    offset = _id_7434285528B2568B;
  else if(stance == "prone")
    offset = _id_09A0552027241E9D;

  return sighttracepassed(_id_A0556100A6D18404 + offset, _id_418AFDEFE253D28A + offset, 0, undefined);
}

get_extended_path(start, end) {
  path = func_get_nodes_on_path(start, end);

  if(isDefined(path)) {
    path = remove_ends_from_path(path);
    path = get_all_connected_nodes(path);
  }

  return path;
}

func_get_path_dist(start, end) {
  return getpathdist(start, end);
}

func_get_nodes_on_path(start, end) {
  return getnodesonpath(start, end);
}

func_bot_get_closest_navigable_point(origin, radius, entity) {
  return botgetclosestnavigablepoint(origin, radius, entity);
}

node_is_on_path_from_labels(_id_AE48E0ABEE4A0FF8, _id_AE48E3ABEE4A1691) {
  if(!isDefined(self.on_path_from))
    return 0;

  if(isDefined(self.on_path_from[_id_AE48E0ABEE4A0FF8]) && isDefined(self.on_path_from[_id_AE48E0ABEE4A0FF8][_id_AE48E3ABEE4A1691]) && self.on_path_from[_id_AE48E0ABEE4A0FF8][_id_AE48E3ABEE4A1691])
    return 1;

  if(isDefined(self.on_path_from[_id_AE48E3ABEE4A1691]) && isDefined(self.on_path_from[_id_AE48E3ABEE4A1691][_id_AE48E0ABEE4A0FF8]) && self.on_path_from[_id_AE48E3ABEE4A1691][_id_AE48E0ABEE4A0FF8])
    return 1;

  return 0;
}

get_all_connected_nodes(nodes) {
  _id_C6736586AE30F7EA = nodes;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < nodes.size; _id_AC0E594AC96AA3A8++) {
    _id_789069F44709F226 = getlinkednodes(nodes[_id_AC0E594AC96AA3A8]);

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_789069F44709F226.size; _id_AC0E5C4AC96AAA41++) {
      if(!scripts\engine\utility::array_contains(_id_C6736586AE30F7EA, _id_789069F44709F226[_id_AC0E5C4AC96AAA41]))
        _id_C6736586AE30F7EA = scripts\engine\utility::array_add(_id_C6736586AE30F7EA, _id_789069F44709F226[_id_AC0E5C4AC96AAA41]);
    }
  }

  return _id_C6736586AE30F7EA;
}

get_visible_nodes_array(nodes, _id_D4BF83E605881B56) {
  _id_9AA5BFED7BC50893 = [];

  foreach(node in nodes) {
    if(nodesvisible(node, _id_D4BF83E605881B56, 1))
      _id_9AA5BFED7BC50893 = scripts\engine\utility::array_add(_id_9AA5BFED7BC50893, node);
  }

  return _id_9AA5BFED7BC50893;
}

remove_ends_from_path(path) {
  path[path.size - 1] = undefined;
  path[0] = undefined;
  return scripts\engine\utility::array_removeundefined(path);
}

bot_waittill_bots_enabled(_id_09472FF28DDF7B38) {
  while(!bot_bots_enabled_or_added(_id_09472FF28DDF7B38))
    wait 0.5;
}

bot_bots_enabled_or_added(_id_09472FF28DDF7B38) {
  if(botsystemstatus() != "off")
    return 1;

  if(bots_exist(_id_09472FF28DDF7B38))
    return 1;

  return 0;
}

bot_waittill_out_of_combat_or_time(time) {
  start_time = gettime();

  for(;;) {
    if(isDefined(time)) {
      if(gettime() > start_time + time)
        return;
    }

    if(!isDefined(self.enemy))
      return;
    else if(!bot_in_combat()) {
      return;
    }
    wait 0.05;
  }
}

bot_in_combat(_id_48E29A59ED3EDA8F) {
  if(self.last_enemy_sight_time == 0)
    return 0;

  _id_934322FA5FF595CB = gettime() - self.last_enemy_sight_time;
  _id_9F7837F99FB67BA5 = level.bot_out_of_combat_time;

  if(isDefined(_id_48E29A59ED3EDA8F))
    _id_9F7837F99FB67BA5 = _id_48E29A59ED3EDA8F;

  return _id_934322FA5FF595CB < _id_9F7837F99FB67BA5;
}

bot_waittill_goal_or_fail(_id_48E29A59ED3EDA8F, _id_9C8BAE256226DB8B, _id_9C8BAF256226DDBE, _id_9C8BB0256226DFF1) {
  if(!isDefined(_id_9C8BAE256226DB8B) && isDefined(_id_9C8BAF256226DDBE)) {}

  if((!isDefined(_id_9C8BAE256226DB8B) || !isDefined(_id_9C8BAF256226DDBE)) && isDefined(_id_9C8BB0256226DFF1)) {}

  _id_819382A0FC083B42 = ["goal", "bad_path", "no_path", "node_relinquished", "script_goal_changed"];

  if(isDefined(_id_9C8BAE256226DB8B))
    _id_819382A0FC083B42[_id_819382A0FC083B42.size] = _id_9C8BAE256226DB8B;

  if(isDefined(_id_9C8BAF256226DDBE))
    _id_819382A0FC083B42[_id_819382A0FC083B42.size] = _id_9C8BAF256226DDBE;

  if(isDefined(_id_9C8BB0256226DFF1))
    _id_819382A0FC083B42[_id_819382A0FC083B42.size] = _id_9C8BB0256226DFF1;

  if(isDefined(_id_48E29A59ED3EDA8F))
    result = scripts\engine\utility::waittill_any_in_array_or_timeout(_id_819382A0FC083B42, _id_48E29A59ED3EDA8F);
  else
    result = scripts\engine\utility::waittill_any_in_array_return(_id_819382A0FC083B42);

  return result;
}

bot_usebutton_wait(time, _id_6EA12445EB7B72DD, _id_6EA12145EB7B6C44) {
  level endon("game_ended");
  childthread use_button_stopped_notify();
  result = scripts\engine\utility::waittill_any_timeout_4(time, _id_6EA12445EB7B72DD, _id_6EA12145EB7B6C44, "use_button_no_longer_pressed", "finished_use");
  self notify("stop_usebutton_watcher");
  return result;
}

use_button_stopped_notify(_id_6EA12445EB7B72DD, _id_6EA12145EB7B6C44) {
  self endon("stop_usebutton_watcher");
  wait 0.05;

  while(self useButtonPressed())
    wait 0.05;

  self notify("use_button_no_longer_pressed");
}

bots_exist(_id_09472FF28DDF7B38) {
  foreach(player in level.participants) {
    if(isai(player)) {
      if(isDefined(_id_09472FF28DDF7B38) && _id_09472FF28DDF7B38) {
        if(!scripts\mp\utility\entity::isteamparticipant(player))
          continue;
      }

      return 1;
    }
  }

  return 0;
}

bot_get_entrances_for_stance_and_index(stance, index, _id_FECD5903478D0482) {
  if(!isDefined(level.entrance_points_finished_caching))
    return undefined;

  if(isarray(index)) {
    if(isDefined(_id_FECD5903478D0482) && _id_FECD5903478D0482) {
      _id_012E19920C0CF525 = undefined;
      _id_7B4F24EDF5A2B51E = 999999999;

      foreach(label in index) {
        _id_E00E92328D38A7A5 = scripts\engine\utility::array_find(level.entrance_indices, label);
        _id_174856386E13BD8A = level.entrance_origin_points[_id_E00E92328D38A7A5];
        _id_5CAADA3DC60CFF57 = distancesquared(self.origin, _id_174856386E13BD8A);

        if(_id_5CAADA3DC60CFF57 < _id_7B4F24EDF5A2B51E) {
          _id_012E19920C0CF525 = label;
          _id_7B4F24EDF5A2B51E = _id_5CAADA3DC60CFF57;
        }
      }

      index = _id_012E19920C0CF525;
    } else
      index = scripts\engine\utility::random(index);
  }

  _id_1C17E70621BB1BBC = level.entrance_points[index];

  if(!isDefined(stance) || stance == "stand")
    return _id_1C17E70621BB1BBC;
  else if(stance == "crouch") {
    _id_DDAB7E16FA1D72EB = [];

    foreach(node in _id_1C17E70621BB1BBC) {
      if(node.crouch_visible_from[index])
        _id_DDAB7E16FA1D72EB = scripts\engine\utility::array_add(_id_DDAB7E16FA1D72EB, node);
    }

    return _id_DDAB7E16FA1D72EB;
  } else if(stance == "prone") {
    _id_DDAB7E16FA1D72EB = [];

    foreach(node in _id_1C17E70621BB1BBC) {
      if(node.prone_visible_from[index])
        _id_DDAB7E16FA1D72EB = scripts\engine\utility::array_add(_id_DDAB7E16FA1D72EB, node);
    }

    return _id_DDAB7E16FA1D72EB;
  }

  return undefined;
}

bot_find_node_to_guard_player(_id_3968C766141F9301, radius, _id_6B1CA44BC56AF3D6) {
  result = undefined;
  _id_20D851954EAE02C4 = self.bot_defend_player_guarding getvelocity();

  if(lengthsquared(_id_20D851954EAE02C4) > 100) {
    _id_8624CB173A64E63F = getnodesinradius(_id_3968C766141F9301, radius * 1.75, radius * 0.5, 500);
    _id_C6736586AE30F7EA = [];
    _id_F142B39B6F5BE136 = vectorNormalize(_id_20D851954EAE02C4);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8624CB173A64E63F.size; _id_AC0E594AC96AA3A8++) {
      _id_5AB345E9F27E0DFD = vectorNormalize(_id_8624CB173A64E63F[_id_AC0E594AC96AA3A8].origin - self.bot_defend_player_guarding.origin);

      if(vectordot(_id_5AB345E9F27E0DFD, _id_F142B39B6F5BE136) > 0.1)
        _id_C6736586AE30F7EA[_id_C6736586AE30F7EA.size] = _id_8624CB173A64E63F[_id_AC0E594AC96AA3A8];
    }
  } else
    _id_C6736586AE30F7EA = getnodesinradius(_id_3968C766141F9301, radius, 0, 500);

  if(isDefined(_id_6B1CA44BC56AF3D6) && _id_6B1CA44BC56AF3D6) {
    _id_76026DCBA9ABF886 = vectorNormalize(self.bot_defend_player_guarding.origin - self.origin);
    _id_E3C9131608985DC0 = _id_C6736586AE30F7EA;
    _id_C6736586AE30F7EA = [];

    foreach(node in _id_E3C9131608985DC0) {
      _id_5AB345E9F27E0DFD = vectorNormalize(node.origin - self.bot_defend_player_guarding.origin);

      if(vectordot(_id_76026DCBA9ABF886, _id_5AB345E9F27E0DFD) > 0.2)
        _id_C6736586AE30F7EA[_id_C6736586AE30F7EA.size] = node;
    }
  }

  _id_F2308CB987D31DEF = [];
  _id_13EE61A7CA8F5BB5 = [];
  _id_F7900A48A2A885CA = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C6736586AE30F7EA.size; _id_AC0E594AC96AA3A8++) {
    _id_3E9E7A9DDC20A36D = distancesquared(_id_C6736586AE30F7EA[_id_AC0E594AC96AA3A8].origin, _id_3968C766141F9301) > 10000;
    _id_DB857D42A4D5695D = abs(_id_C6736586AE30F7EA[_id_AC0E594AC96AA3A8].origin[2] - self.bot_defend_player_guarding.origin[2]) < 50;

    if(_id_3E9E7A9DDC20A36D)
      _id_F2308CB987D31DEF[_id_F2308CB987D31DEF.size] = _id_C6736586AE30F7EA[_id_AC0E594AC96AA3A8];

    if(_id_DB857D42A4D5695D)
      _id_13EE61A7CA8F5BB5[_id_13EE61A7CA8F5BB5.size] = _id_C6736586AE30F7EA[_id_AC0E594AC96AA3A8];

    if(_id_3E9E7A9DDC20A36D && _id_DB857D42A4D5695D)
      _id_F7900A48A2A885CA[_id_F7900A48A2A885CA.size] = _id_C6736586AE30F7EA[_id_AC0E594AC96AA3A8];

    if(_id_AC0E594AC96AA3A8 % 100 == 99)
      wait 0.05;
  }

  if(_id_F7900A48A2A885CA.size > 0)
    result = self botnodepick(_id_F7900A48A2A885CA, _id_F7900A48A2A885CA.size * 0.15, "node_capture", _id_3968C766141F9301, undefined, self.defense_score_flags);

  if(!isDefined(result)) {
    wait 0.05;

    if(_id_13EE61A7CA8F5BB5.size > 0)
      result = self botnodepick(_id_13EE61A7CA8F5BB5, _id_13EE61A7CA8F5BB5.size * 0.15, "node_capture", _id_3968C766141F9301, undefined, self.defense_score_flags);

    if(!isDefined(result) && _id_F2308CB987D31DEF.size > 0) {
      wait 0.05;
      result = self botnodepick(_id_F2308CB987D31DEF, _id_F2308CB987D31DEF.size * 0.15, "node_capture", _id_3968C766141F9301, undefined, self.defense_score_flags);
    }
  }

  return result;
}

bot_find_node_to_capture_point(_id_3968C766141F9301, radius, _id_949CB180A69B5EAD) {
  result = undefined;
  _id_C6736586AE30F7EA = getnodesinradius(_id_3968C766141F9301, radius, 0, 500);

  if(_id_C6736586AE30F7EA.size > 0)
    result = self botnodepick(_id_C6736586AE30F7EA, _id_C6736586AE30F7EA.size * 0.15, "node_capture", _id_3968C766141F9301, _id_949CB180A69B5EAD, self.defense_score_flags);

  return result;
}

bot_find_node_to_capture_zone(nodes, _id_949CB180A69B5EAD) {
  result = undefined;

  if(nodes.size > 0)
    result = self botnodepick(nodes, nodes.size * 0.15, "node_capture", undefined, _id_949CB180A69B5EAD, self.defense_score_flags);

  return result;
}

bot_find_node_to_protect_zone(nodes, _id_3968C766141F9301) {
  result = undefined;

  if(nodes.size > 0)
    result = self botnodepick(nodes, nodes.size * 0.25, "node_capture", _id_3968C766141F9301, undefined, self.defense_score_flags);

  return result;
}

bot_find_node_that_protects_point(_id_3968C766141F9301, radius) {
  result = undefined;
  _id_C6736586AE30F7EA = getnodesinradius(_id_3968C766141F9301, radius, 0, 500);

  if(_id_C6736586AE30F7EA.size > 0)
    result = self botnodepick(_id_C6736586AE30F7EA, _id_C6736586AE30F7EA.size * 0.15, "node_protect", _id_3968C766141F9301, self.defense_score_flags);

  return result;
}

bot_pick_random_point_in_radius(center_point, _id_F0E21B45A1740CC0, _id_FC3BC2E3860D44F9, close_dist, far_dist) {
  _id_F5D11AF6EB2E85D6 = undefined;
  nodes = getnodesinradius(center_point, _id_F0E21B45A1740CC0, 0, 500);

  if(isDefined(nodes) && nodes.size >= 2)
    _id_F5D11AF6EB2E85D6 = bot_find_random_midpoint(nodes, _id_FC3BC2E3860D44F9);

  if(!isDefined(_id_F5D11AF6EB2E85D6)) {
    if(!isDefined(close_dist))
      close_dist = 0;

    if(!isDefined(far_dist))
      far_dist = 1;

    _id_9ABE0A319F55A437 = randomfloatrange(self.bot_defending_radius * close_dist, self.bot_defending_radius * far_dist);
    _id_3A7279D29E10F766 = anglesToForward((0, randomint(360), 0));
    _id_F5D11AF6EB2E85D6 = center_point + _id_3A7279D29E10F766 * _id_9ABE0A319F55A437;
  }

  return _id_F5D11AF6EB2E85D6;
}

bot_pick_random_point_from_set(center_point, _id_506406B99ADF5702, _id_FC3BC2E3860D44F9) {
  _id_F5D11AF6EB2E85D6 = undefined;

  if(_id_506406B99ADF5702.size >= 2)
    _id_F5D11AF6EB2E85D6 = bot_find_random_midpoint(_id_506406B99ADF5702, _id_FC3BC2E3860D44F9);

  if(!isDefined(_id_F5D11AF6EB2E85D6)) {
    _id_4F25410C4C678B38 = scripts\engine\utility::random(_id_506406B99ADF5702);
    _id_570CD77233B5C984 = _id_4F25410C4C678B38.origin - center_point;
    _id_F5D11AF6EB2E85D6 = center_point + vectorNormalize(_id_570CD77233B5C984) * length(_id_570CD77233B5C984) * randomfloat(1.0);
  }

  return _id_F5D11AF6EB2E85D6;
}

bot_find_random_midpoint(nodes, _id_FC3BC2E3860D44F9) {
  _id_F5D11AF6EB2E85D6 = undefined;
  _id_DF9887C7D65CF426 = scripts\engine\utility::array_randomize(nodes);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_DF9887C7D65CF426.size; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 + 1; _id_AC0E5C4AC96AAA41 < _id_DF9887C7D65CF426.size; _id_AC0E5C4AC96AAA41++) {
      _id_61EE04CD86F17F18 = _id_DF9887C7D65CF426[_id_AC0E594AC96AA3A8];
      _id_61EE07CD86F185B1 = _id_DF9887C7D65CF426[_id_AC0E5C4AC96AAA41];

      if(nodesvisible(_id_61EE04CD86F17F18, _id_61EE07CD86F185B1, 1)) {
        _id_F5D11AF6EB2E85D6 = ((_id_61EE04CD86F17F18.origin[0] + _id_61EE07CD86F185B1.origin[0]) * 0.5, (_id_61EE04CD86F17F18.origin[1] + _id_61EE07CD86F185B1.origin[1]) * 0.5, (_id_61EE04CD86F17F18.origin[2] + _id_61EE07CD86F185B1.origin[2]) * 0.5);

        if(isDefined(_id_FC3BC2E3860D44F9) && self[[_id_FC3BC2E3860D44F9]](_id_F5D11AF6EB2E85D6) == 1)
          return _id_F5D11AF6EB2E85D6;
      }
    }
  }

  return _id_F5D11AF6EB2E85D6;
}

defend_valid_center() {
  if(isDefined(self.bot_defending_override_origin_node))
    return self.bot_defending_override_origin_node.origin;
  else if(isDefined(self.bot_defending_center))
    return self.bot_defending_center;

  return undefined;
}

bot_allowed_to_use_killstreaks() {
  if(!istrue(level.allowkillstreaks))
    return 0;

  if(scripts\mp\utility\game::iskillstreakdenied())
    return 0;

  if(bot_is_remote_or_linked())
    return 0;

  if(self isusingturret())
    return 0;

  if(isDefined(level.nukeinfo._id_9DCCABA98B643CAD))
    return 0;

  if(isDefined(self.underwater) && self.underwater)
    return 0;

  if(isDefined(self.controlsfrozen) && self.controlsfrozen)
    return 0;

  if(self isoffhandweaponreadytothrow())
    return 0;

  if(scripts\mp\utility\game::getgametypenumlives() > 0) {
    _id_6AD81A0BA3C14575 = 1;

    foreach(player in level.participants) {
      if(isalive(player) && !isalliedsentient(self, player))
        _id_6AD81A0BA3C14575 = 0;
    }

    if(_id_6AD81A0BA3C14575)
      return 0;
  }

  if(istrue(self.botdisablekillstreaks))
    return 0;

  if(!bot_in_combat(500))
    return 1;

  if(!isalive(self.enemy))
    return 1;

  return 0;
}

bot_recent_point_of_interest() {
  result = undefined;
  _id_FC96BF0DB6540B44 = botmemoryflags("investigated", "killer_died");
  _id_4A52839A5A1EA880 = botmemoryflags("investigated");
  _id_D8E026EEBFCB4315 = scripts\engine\utility::random(botgetmemoryevents(0, gettime() - 10000, 1, "death", _id_FC96BF0DB6540B44, self));

  if(isDefined(_id_D8E026EEBFCB4315)) {
    result = _id_D8E026EEBFCB4315;
    self.bot_memory_goal_time = 10000;
  } else {
    _id_F06CAF66C4B77411 = undefined;

    if(self botgetscriptgoaltype() != "none")
      _id_F06CAF66C4B77411 = self botgetscriptgoal();

    _id_F6FD4DA771B0BB3A = botgetmemoryevents(0, gettime() - 45000, 1, "kill", _id_4A52839A5A1EA880, self);
    _id_84B4EDB2CB8A1E95 = botgetmemoryevents(0, gettime() - 45000, 1, "death", _id_FC96BF0DB6540B44, self);
    _id_D8E026EEBFCB4315 = scripts\engine\utility::random(scripts\engine\utility::array_combine(_id_F6FD4DA771B0BB3A, _id_84B4EDB2CB8A1E95));

    if(isDefined(_id_D8E026EEBFCB4315) > 0 && (!isDefined(_id_F06CAF66C4B77411) || distancesquared(_id_F06CAF66C4B77411, _id_D8E026EEBFCB4315) > 1000000)) {
      result = _id_D8E026EEBFCB4315;
      self.bot_memory_goal_time = 45000;
    }
  }

  if(isDefined(result)) {
    _id_9471AE538C525086 = getzonenearest(result);
    _id_FE9216675F0EF975 = getzonenearest(self.origin);

    if(isDefined(_id_9471AE538C525086) && isDefined(_id_FE9216675F0EF975) && _id_FE9216675F0EF975 != _id_9471AE538C525086) {
      _id_EFA8EF05B190D7D0 = botzonegetcount(_id_9471AE538C525086, self.team, "ally") + botzonegetcount(_id_9471AE538C525086, self.team, "path_ally");

      if(_id_EFA8EF05B190D7D0 > 1)
        result = undefined;
    }
  }

  if(isDefined(result))
    self.bot_memory_goal = result;

  return result;
}

bot_draw_cylinder(pos, _id_CB920E03144E9344, height, duration, _id_DA34C68A2CA176D7, color, _id_FFB74DFE2FDAD3BE, _id_52055A030C13E72B, alpha) {}

bot_draw_cylinder_think(pos, _id_CB920E03144E9344, height, _id_CC748B6D457627FE, _id_DA34C68A2CA176D7, color, _id_FFB74DFE2FDAD3BE, _id_52055A030C13E72B, alpha) {}

bot_draw_circle(center, radius, color, _id_FFB74DFE2FDAD3BE, segments) {}

_id_2BBB7DDF0BB3449E() {
  _id_BC9DA38A4BAB4CE2 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0)
    _id_BC9DA38A4BAB4CE2 = self.weaponlist;
  else
    _id_BC9DA38A4BAB4CE2 = self getweaponslistprimaries();

  _id_D5E336E80466B2E0 = [];

  foreach(weapon in _id_BC9DA38A4BAB4CE2) {
    if(!weapon.ismelee && weapon.type == "bullet")
      _id_D5E336E80466B2E0[_id_D5E336E80466B2E0.size] = weapon;
  }

  return _id_D5E336E80466B2E0;
}

bot_get_total_gun_ammo() {
  _id_DEAB3AF8D6303B6C = 0;
  _id_BC9DA38A4BAB4CE2 = _id_2BBB7DDF0BB3449E();

  foreach(weapon in _id_BC9DA38A4BAB4CE2) {
    _id_DEAB3AF8D6303B6C = _id_DEAB3AF8D6303B6C + self getweaponammoclip(weapon);
    _id_DEAB3AF8D6303B6C = _id_DEAB3AF8D6303B6C + self getweaponammostock(weapon);
  }

  return _id_DEAB3AF8D6303B6C;
}

bot_out_of_ammo() {
  _id_BC9DA38A4BAB4CE2 = _id_2BBB7DDF0BB3449E();
  return bot_get_total_gun_ammo() <= 0;
}

bot_get_low_on_ammo(_id_27713544055085DB) {
  _id_BC9DA38A4BAB4CE2 = _id_2BBB7DDF0BB3449E();

  foreach(weapon in _id_BC9DA38A4BAB4CE2) {
    _id_7FC9076882EE98FF = weaponclipsize(weapon);
    stock_ammo = self getweaponammostock(weapon);

    if(stock_ammo <= _id_7FC9076882EE98FF)
      return 1;

    if(self getfractionmaxammo(weapon) <= _id_27713544055085DB)
      return 1;
  }

  return 0;
}

bot_get_low_on_all_ammo(_id_27713544055085DB) {
  _id_BC9DA38A4BAB4CE2 = _id_2BBB7DDF0BB3449E();
  _id_539B3076CB018CEA = 0;
  _id_75466E02E9F04917 = 0;

  foreach(weapon in _id_BC9DA38A4BAB4CE2) {
    _id_7FC9076882EE98FF = weaponclipsize(weapon);
    stock_ammo = self getweaponammostock(weapon);

    if(stock_ammo <= _id_7FC9076882EE98FF || self getfractionmaxammo(weapon) <= _id_27713544055085DB)
      _id_75466E02E9F04917++;
  }

  if(_id_75466E02E9F04917 == _id_BC9DA38A4BAB4CE2.size)
    _id_539B3076CB018CEA = 1;

  return _id_539B3076CB018CEA;
}

bot_get_grenade_ammo() {
  _id_A7861294F4C08289 = 0;
  _id_E45D691F05EAA114 = self getweaponslistoffhands();

  foreach(weapon in _id_E45D691F05EAA114)
  _id_A7861294F4C08289 = _id_A7861294F4C08289 + self getweaponammostock(weapon);

  return _id_A7861294F4C08289;
}

bot_item_matches_purpose(_id_6197E9BB77C3052D, _id_B8F5D813D9E1194E) {
  switch (_id_6197E9BB77C3052D) {
    case "trap_directional":
      switch (_id_B8F5D813D9E1194E.basename) {
        case "claymore_mp":
          return 1;
      }

      break;
    case "trap":
      switch (_id_B8F5D813D9E1194E.basename) {
        case "motion_sensor_mp":
        case "proximity_explosive_mp":
        case "trophy_mp":
        case "at_mine_mp":
          return 1;
      }

      break;
    case "trap_follower":
      switch (_id_B8F5D813D9E1194E.basename) {
        case "tracking_drone_mp":
          return 1;
      }

      break;
    case "c4":
      switch (_id_B8F5D813D9E1194E.basename) {
        case "c4_mp":
          return 1;
      }

      break;
    case "tacticalinsertion":
      switch (_id_B8F5D813D9E1194E.basename) {
        case "flare_mp":
          return 1;
      }

      break;
  }

  return 0;
}

bot_watch_nodes(nodes, yaw, _id_68BA2267CD0CAB78, end_time, end1, end2, _id_688F4E559BEFACDF, _id_688F4B559BEFA646) {
  self notify("bot_watch_nodes");
  self endon("bot_watch_nodes");
  self endon("bot_watch_nodes_stop");
  self endon("using_remote");
  self endon("death_or_disconnect");

  if(isDefined(end1))
    self endon(end1);

  if(isDefined(end2))
    self endon(end2);

  if(isDefined(_id_688F4E559BEFACDF))
    self endon(_id_688F4E559BEFACDF);

  if(isDefined(_id_688F4B559BEFA646))
    self endon(_id_688F4B559BEFA646);

  wait 0.5;
  _id_1461FB770F6F780C = 1;

  if(self isusingturret())
    _id_1461FB770F6F780C = 0;

  _id_1A96B3062BB2C598 = squared(self botgetscriptgoalRadius());

  while(_id_1461FB770F6F780C) {
    if(self bothasscriptgoal() && self botpursuingscriptgoal()) {
      if(distancesquared(self botgetscriptgoal(), self.origin) < _id_1A96B3062BB2C598) {
        if(length(self getvelocity()) <= 1)
          _id_1461FB770F6F780C = 0;
      }
    }

    if(_id_1461FB770F6F780C)
      wait 0.05;
  }

  _id_00AA937EA4F3A2AC = self.origin;
  _id_9CF909CA02AEC20D = (0, 0, self getplayerviewheight());

  if(isDefined(nodes)) {
    self.watch_nodes = [];

    foreach(node in nodes) {
      _id_9F339B5E36A51279 = 0;

      if(distance2dsquared(self.origin, node.origin) <= 40)
        _id_9F339B5E36A51279 = 1;

      _id_F1FCCDA1AD4EDF59 = self getEye();
      _id_1C72E15F82BC237D = vectordot((0, 0, 1), vectorNormalize(node.origin + _id_9CF909CA02AEC20D - _id_F1FCCDA1AD4EDF59));

      if(abs(_id_1C72E15F82BC237D) > 0.92)
        _id_9F339B5E36A51279 = 1;

      if(!_id_9F339B5E36A51279)
        self.watch_nodes[self.watch_nodes.size] = node;
    }
  }

  if(!isDefined(self.watch_nodes)) {
    return;
  }
  thread watch_nodes_aborted();
  self.watch_nodes = scripts\engine\utility::array_randomize(self.watch_nodes);

  foreach(node in self.watch_nodes) {
    node.watch_node_chance[self.entity_number] = 1.0;
    node.watch_node_base_chance[self.entity_number] = 1.0;
  }

  _id_971EE25F34B49D52 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.watch_nodes.size; _id_AC0E594AC96AA3A8++) {
    _id_971EE25F34B49D52[_id_AC0E594AC96AA3A8] = [];
    _id_DE36CF813F793AB2 = vectorNormalize(self.watch_nodes[_id_AC0E594AC96AA3A8].origin - self.origin);

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < self.watch_nodes.size; _id_AC0E5C4AC96AAA41++) {
      if(_id_AC0E594AC96AA3A8 == _id_AC0E5C4AC96AAA41) {
        continue;
      }
      _id_DE36CE813F79387F = vectorNormalize(self.watch_nodes[_id_AC0E5C4AC96AAA41].origin - self.origin);
      dot = vectordot(_id_DE36CF813F793AB2, _id_DE36CE813F79387F);

      if(dot > 0.94)
        _id_971EE25F34B49D52[_id_AC0E594AC96AA3A8] = scripts\engine\utility::array_add(_id_971EE25F34B49D52[_id_AC0E594AC96AA3A8], _id_AC0E5C4AC96AAA41);
    }
  }

  for(;;) {
    _id_E1A1D66CB73E2B88 = -1;
    _id_2207AE112077F472 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.watch_nodes.size; _id_AC0E594AC96AA3A8++) {
      if(_id_971EE25F34B49D52[_id_AC0E594AC96AA3A8].size > _id_2207AE112077F472) {
        _id_E1A1D66CB73E2B88 = _id_AC0E594AC96AA3A8;
        _id_2207AE112077F472 = _id_971EE25F34B49D52[_id_AC0E594AC96AA3A8].size;
      }
    }

    if(_id_E1A1D66CB73E2B88 == -1) {
      break;
    }

    self.watch_nodes[_id_E1A1D66CB73E2B88].watch_node_chance[self.entity_number] = 0.5;
    self.watch_nodes[_id_E1A1D66CB73E2B88].watch_node_base_chance[self.entity_number] = 0.5;
    _id_971EE25F34B49D52[_id_E1A1D66CB73E2B88] = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_971EE25F34B49D52.size; _id_AC0E594AC96AA3A8++) {
      if(scripts\engine\utility::array_contains(_id_971EE25F34B49D52[_id_AC0E594AC96AA3A8], _id_E1A1D66CB73E2B88))
        _id_971EE25F34B49D52[_id_AC0E594AC96AA3A8] = scripts\engine\utility::array_remove(_id_971EE25F34B49D52[_id_AC0E594AC96AA3A8], _id_E1A1D66CB73E2B88);
    }
  }

  starttime = gettime();
  _id_7D7882BECC0C7326 = starttime;
  _id_E1AA090F4F2161B1 = [];
  _id_0A2A227242F2C364 = undefined;

  if(isDefined(yaw))
    _id_0A2A227242F2C364 = (0, yaw, 0);

  _id_95D995D01E704A5E = isDefined(_id_0A2A227242F2C364) && isDefined(_id_68BA2267CD0CAB78);
  _id_DF2D0E9E79134677 = undefined;
  _id_0BB7B3933B08E813 = undefined;
  wait 0.1;

  for(;;) {
    _id_64F88D0441939203 = gettime();
    self notify("still_watching_nodes");
    _id_9230F5246D95A3D6 = self botgetfovdot();

    if(isDefined(end_time) && _id_64F88D0441939203 >= end_time) {
      return;
    }
    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal()) {
      self botlookatpoint(undefined);
      wait 0.2;
      continue;
    }

    if(!self bothasscriptgoal() || !self botpursuingscriptgoal()) {
      wait 0.2;
      continue;
    }

    if(isDefined(_id_0BB7B3933B08E813) && _id_0BB7B3933B08E813.watch_node_chance[self.entity_number] == 0.0)
      _id_7D7882BECC0C7326 = _id_64F88D0441939203;

    if(self.watch_nodes.size > 0) {
      _id_D613B824045689C7 = 0;

      if(isDefined(self.enemy)) {
        _id_CFC45BADFD3D5674 = self lastknownpos(self.enemy);
        _id_9BFA9640F52DA347 = self lastknowntime(self.enemy);

        if(_id_9BFA9640F52DA347 && _id_64F88D0441939203 - _id_9BFA9640F52DA347 < 5000) {
          _id_30CF0E53EABFB4FC = vectorNormalize(_id_CFC45BADFD3D5674 - self.origin);
          _id_850DAFBF8F438190 = 0;

          for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.watch_nodes.size; _id_AC0E594AC96AA3A8++) {
            _id_D18492A510556F2C = vectorNormalize(self.watch_nodes[_id_AC0E594AC96AA3A8].origin - self.origin);
            dot = vectordot(_id_30CF0E53EABFB4FC, _id_D18492A510556F2C);

            if(dot > _id_850DAFBF8F438190) {
              _id_850DAFBF8F438190 = dot;
              _id_0BB7B3933B08E813 = self.watch_nodes[_id_AC0E594AC96AA3A8];
              _id_D613B824045689C7 = 1;
            }
          }
        }
      }

      if(!_id_D613B824045689C7 && _id_64F88D0441939203 >= _id_7D7882BECC0C7326) {
        _id_B9D7426E00E4CBE3 = [];

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.watch_nodes.size; _id_AC0E594AC96AA3A8++) {
          node = self.watch_nodes[_id_AC0E594AC96AA3A8];
          _id_D47972BAB60448BA = node getnodenumber();

          if(_id_95D995D01E704A5E && !scripts\engine\utility::within_fov(self.origin, _id_0A2A227242F2C364, node.origin, _id_68BA2267CD0CAB78)) {
            continue;
          }
          if(distance2dsquared(self.origin, node.origin) <= 10) {
            continue;
          }
          if(!isDefined(_id_E1AA090F4F2161B1[_id_D47972BAB60448BA]))
            _id_E1AA090F4F2161B1[_id_D47972BAB60448BA] = 0;

          if(scripts\engine\utility::within_fov(self.origin, self getplayerangles(), node.origin, _id_9230F5246D95A3D6))
            _id_E1AA090F4F2161B1[_id_D47972BAB60448BA] = _id_64F88D0441939203;

          for(index = 0; index < _id_B9D7426E00E4CBE3.size; index++) {
            if(_id_E1AA090F4F2161B1[_id_B9D7426E00E4CBE3[index] getnodenumber()] > _id_E1AA090F4F2161B1[_id_D47972BAB60448BA]) {
              break;
            }
          }

          _id_B9D7426E00E4CBE3 = scripts\engine\utility::array_insert(_id_B9D7426E00E4CBE3, node, index);
        }

        _id_DF2D0E9E79134677 = _id_0BB7B3933B08E813;
        _id_0BB7B3933B08E813 = undefined;

        if(_id_B9D7426E00E4CBE3.size == 1)
          _id_0BB7B3933B08E813 = _id_B9D7426E00E4CBE3[0];
        else if(_id_B9D7426E00E4CBE3.size > 1) {
          _id_8EDDE92063566CAB = [];
          _id_C01D5A3093AC1E22 = 0;

          for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B9D7426E00E4CBE3.size; _id_AC0E594AC96AA3A8++) {
            _id_AAE9635F166A8D55 = 1.0 - _id_AC0E594AC96AA3A8 / (_id_B9D7426E00E4CBE3.size - 1) * 0.5;
            _id_96BE4349CAAC06EF = [_id_B9D7426E00E4CBE3[_id_AC0E594AC96AA3A8], _id_B9D7426E00E4CBE3[_id_AC0E594AC96AA3A8].watch_node_chance[self.entity_number] * _id_AAE9635F166A8D55];
            _id_8EDDE92063566CAB[_id_8EDDE92063566CAB.size] = _id_96BE4349CAAC06EF;
            _id_C01D5A3093AC1E22 = _id_C01D5A3093AC1E22 + _id_96BE4349CAAC06EF[1];
          }

          _id_6A8A60939CE622B0 = randomfloat(_id_C01D5A3093AC1E22);

          for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8EDDE92063566CAB.size; _id_AC0E594AC96AA3A8++) {
            if(_id_6A8A60939CE622B0 < _id_8EDDE92063566CAB[_id_AC0E594AC96AA3A8][1]) {
              _id_0BB7B3933B08E813 = _id_8EDDE92063566CAB[_id_AC0E594AC96AA3A8][0];
              break;
            }

            _id_6A8A60939CE622B0 = _id_6A8A60939CE622B0 - _id_8EDDE92063566CAB[_id_AC0E594AC96AA3A8][1];
          }
        }

        if(isDefined(_id_0BB7B3933B08E813)) {
          _id_7D7882BECC0C7326 = _id_64F88D0441939203 + randomintrange(3000, 5000);
          _id_D947C8A87113FDDD = !isDefined(_id_DF2D0E9E79134677) || _id_DF2D0E9E79134677 != _id_0BB7B3933B08E813;

          if(_id_D947C8A87113FDDD && istrue(self.bot_can_change_stance_while_watching_nodes))
            childthread bot_handle_stance_for_look(_id_0BB7B3933B08E813);
        }
      }

      if(isDefined(_id_0BB7B3933B08E813)) {
        _id_B16FE075D78158C7 = _id_0BB7B3933B08E813.origin + _id_9CF909CA02AEC20D;

        if(distance2dsquared(self.origin, _id_B16FE075D78158C7) <= 10) {
          self botlookatpoint(undefined);
          _id_0BB7B3933B08E813 = undefined;
          _id_7D7882BECC0C7326 = 0;
        } else
          self botlookatpoint(_id_B16FE075D78158C7, 0.4, "script_search");
      }
    }

    wait 0.2;
  }
}

bot_handle_stance_for_look(_id_0BB7B3933B08E813) {
  if(isDefined(self.cur_defend_stance)) {
    _id_492F3C87247DF290 = self.cur_defend_stance;

    if(_id_492F3C87247DF290 == "prone" && self getstance() == "prone") {
      self botsetstance("crouch");
      wait 1.0;
    }

    if(_id_492F3C87247DF290 == "prone") {
      if(watch_nodes_visible_prone(self getnearestnode(), _id_0BB7B3933B08E813))
        self botsetstance("prone");
      else
        _id_492F3C87247DF290 = "crouch";
    }

    if(_id_492F3C87247DF290 == "crouch") {
      if(watch_nodes_visible_crouch(self getnearestnode(), _id_0BB7B3933B08E813))
        self botsetstance("crouch");
      else
        _id_492F3C87247DF290 = "stand";
    }

    if(_id_492F3C87247DF290 == "stand")
      self botsetstance("stand");
  }
}

watch_nodes_visible_prone(_id_D6B00014A5DAD5F1, _id_512306FFC667F6A8) {
  _id_9DA7B4B28DA70B98 = _id_512306FFC667F6A8 getnodenumber();

  if(!isDefined(_id_D6B00014A5DAD5F1.pronevisiblenodes) || !isDefined(_id_D6B00014A5DAD5F1.pronevisiblenodes[_id_9DA7B4B28DA70B98])) {
    _id_B25D6E13751F22F7 = sighttracepassed(_id_D6B00014A5DAD5F1.origin + (0, 0, 11), _id_512306FFC667F6A8.origin + (0, 0, 11), 0, undefined);
    _id_D6B00014A5DAD5F1.pronevisiblenodes[_id_9DA7B4B28DA70B98] = _id_B25D6E13751F22F7;
  }

  return _id_D6B00014A5DAD5F1.pronevisiblenodes[_id_9DA7B4B28DA70B98];
}

watch_nodes_visible_crouch(_id_D6B00014A5DAD5F1, _id_512306FFC667F6A8) {
  _id_9DA7B4B28DA70B98 = _id_512306FFC667F6A8 getnodenumber();

  if(!isDefined(_id_D6B00014A5DAD5F1.pronevisiblenodes) || !isDefined(_id_D6B00014A5DAD5F1.pronevisiblenodes[_id_9DA7B4B28DA70B98])) {
    _id_B25D6E13751F22F7 = sighttracepassed(_id_D6B00014A5DAD5F1.origin + (0, 0, 40), _id_512306FFC667F6A8.origin + (0, 0, 11), 0, undefined);
    _id_D6B00014A5DAD5F1.pronevisiblenodes[_id_9DA7B4B28DA70B98] = _id_B25D6E13751F22F7;
  }

  return _id_D6B00014A5DAD5F1.pronevisiblenodes[_id_9DA7B4B28DA70B98];
}

watch_nodes_stop() {
  self notify("bot_watch_nodes_stop");

  if(isDefined(self.watch_nodes)) {
    foreach(node in self.watch_nodes)
    watch_node_clear_data(node);
  }

  self.watch_nodes = undefined;
}

watch_node_clear_data(node) {
  node.watch_node_chance[self.entity_number] = undefined;
  node.watch_node_base_chance[self.entity_number] = undefined;
}

watch_nodes_aborted() {
  self notify("watch_nodes_aborted");
  self endon("watch_nodes_aborted");
  self endon("bot_watch_nodes_stop");
  self endon("disconnect");

  for(;;) {
    msg = scripts\engine\utility::waittill_any_timeout_1(0.5, "still_watching_nodes");

    if(!isDefined(msg) || msg != "still_watching_nodes") {
      thread watch_nodes_stop();
      return;
    }
  }
}

bot_leader_dialog(dialog, location) {
  if(isDefined(location) && location != (0, 0, 0)) {
    if(!scripts\engine\utility::within_fov(self.origin, self getplayerangles(), location, self botgetfovdot())) {
      _id_354B9B31F55BA593 = self botpredictseepoint(location);

      if(isDefined(_id_354B9B31F55BA593))
        self botlookatpoint(_id_354B9B31F55BA593 + (0, 0, 40), 1.0, "script_seek");
    }

    self botmemoryevent("known_enemy", undefined, location);
  }
}

bot_get_known_attacker(attacker, inflictor) {
  if(isDefined(inflictor) && isDefined(inflictor.classname)) {
    if(inflictor.classname == "grenade") {
      if(isDefined(attacker) && attacker.classname == "worldspawn")
        return undefined;

      if(!bot_ent_is_anonymous_mine(inflictor))
        return attacker;
    } else if(inflictor.classname == "rocket") {
      if(isDefined(inflictor.vehicle_fired_from))
        return inflictor.vehicle_fired_from;

      if(isDefined(inflictor.type) && inflictor.type == "remote")
        return inflictor;

      if(isDefined(inflictor.owner))
        return inflictor.owner;
    } else if(inflictor.classname == "worldspawn" || inflictor.classname == "trigger_hurt")
      return undefined;

    return inflictor;
  }

  return attacker;
}

bot_ent_is_anonymous_mine(ent) {
  _id_D5958F44DF33323A = ent.weapon_name;

  if(!isDefined(_id_D5958F44DF33323A))
    _id_D5958F44DF33323A = ent.weaponname;

  if(!isDefined(_id_D5958F44DF33323A))
    return 0;

  if(issubstr(_id_D5958F44DF33323A, "c4_mp"))
    return 1;

  if(issubstr(_id_D5958F44DF33323A, "claymore_mp"))
    return 1;

  if(issubstr(_id_D5958F44DF33323A, "mine_mp"))
    return 1;

  if(issubstr(_id_D5958F44DF33323A, "proximity_explosive_mp"))
    return 1;

  return 0;
}

bot_vectors_are_equal(_id_9601C225B7890378, _id_9601C525B7890A11) {
  return _id_9601C225B7890378[0] == _id_9601C525B7890A11[0] && _id_9601C225B7890378[1] == _id_9601C525B7890A11[1] && _id_9601C225B7890378[2] == _id_9601C525B7890A11[2];
}

bot_add_to_bot_level_targets(_id_AE802F9C07F6FDAC) {
  _id_AE802F9C07F6FDAC.high_priority_for = [];

  if(_id_AE802F9C07F6FDAC.bot_interaction_type == "use")
    bot_add_to_bot_use_targets(_id_AE802F9C07F6FDAC);
  else if(_id_AE802F9C07F6FDAC.bot_interaction_type == "damage")
    bot_add_to_bot_damage_targets(_id_AE802F9C07F6FDAC);
  else {}
}

bot_remove_from_bot_level_targets(_id_A7044CC8ABAC7165) {
  _id_A7044CC8ABAC7165.already_used = 1;
  level.level_specific_bot_targets = scripts\engine\utility::array_remove(level.level_specific_bot_targets, _id_A7044CC8ABAC7165);
}

bot_add_to_bot_use_targets(_id_01FFFA800EA7104B) {
  if(!issubstr(_id_01FFFA800EA7104B.code_classname, "trigger_use")) {
    return;
  }
  if(!isDefined(_id_01FFFA800EA7104B.target)) {
    return;
  }
  if(isDefined(_id_01FFFA800EA7104B.bot_target)) {
    return;
  }
  if(!isDefined(_id_01FFFA800EA7104B.use_time)) {
    return;
  }
  _id_75C1B28CA39FD98A = getnodearray(_id_01FFFA800EA7104B.target, "targetname");

  if(_id_75C1B28CA39FD98A.size != 1) {
    return;
  }
  _id_01FFFA800EA7104B.bot_target = _id_75C1B28CA39FD98A[0];

  if(!isDefined(level.level_specific_bot_targets))
    level.level_specific_bot_targets = [];

  level.level_specific_bot_targets = scripts\engine\utility::array_add(level.level_specific_bot_targets, _id_01FFFA800EA7104B);
}

bot_add_to_bot_damage_targets(_id_5CF83A761F7A3EBD) {
  if(!issubstr(_id_5CF83A761F7A3EBD.code_classname, "trigger_damage")) {
    return;
  }
  _id_304CFBE931E87EAE = getnodearray(_id_5CF83A761F7A3EBD.target, "targetname");

  if(_id_304CFBE931E87EAE.size != 2) {
    return;
  }
  _id_5CF83A761F7A3EBD.bot_targets = _id_304CFBE931E87EAE;

  if(!isDefined(level.level_specific_bot_targets))
    level.level_specific_bot_targets = [];

  level.level_specific_bot_targets = scripts\engine\utility::array_add(level.level_specific_bot_targets, _id_5CF83A761F7A3EBD);
}

bot_get_string_index_for_integer(array, _id_C991A2934117C74E) {
  _id_BBB45D49F4EAF799 = 0;

  foreach(_id_BE3B62A925C3795F, _id_A9957E07C1F05014 in array) {
    if(_id_BBB45D49F4EAF799 == _id_C991A2934117C74E)
      return _id_BE3B62A925C3795F;

    _id_BBB45D49F4EAF799++;
  }

  return undefined;
}

bot_get_zones_within_dist(_id_11CA93F1E27B92B8, _id_21B0311D64CADFA2) {
  for(z = 0; z < level.zonecount; z++) {
    _id_357DB4590F30FBC8 = getzonenodeforindex(z);
    _id_357DB4590F30FBC8.visited = 0;
  }

  _id_78E4201C31443B38 = getzonenodeforindex(_id_11CA93F1E27B92B8);
  return bot_get_zones_within_dist_recurs(_id_78E4201C31443B38, _id_21B0311D64CADFA2);
}

bot_get_zones_within_dist_recurs(_id_78E4201C31443B38, _id_21B0311D64CADFA2) {
  _id_E510A3F92F966E4C = [];
  _id_E510A3F92F966E4C[0] = getnodezone(_id_78E4201C31443B38);
  _id_78E4201C31443B38.visited = 1;
  _id_499568C4DA593E13 = getlinkednodes(_id_78E4201C31443B38);

  foreach(node in _id_499568C4DA593E13) {
    if(!node.visited) {
      _id_FBD1A356311A2449 = distance(_id_78E4201C31443B38.origin, node.origin);

      if(_id_FBD1A356311A2449 < _id_21B0311D64CADFA2) {
        _id_C832A2585933D981 = bot_get_zones_within_dist_recurs(node, _id_21B0311D64CADFA2 - _id_FBD1A356311A2449);
        _id_E510A3F92F966E4C = scripts\engine\utility::array_combine(_id_C832A2585933D981, _id_E510A3F92F966E4C);
      }
    }
  }

  return _id_E510A3F92F966E4C;
}

bot_get_max_players_on_team(team) {
  return level.bot_max_players_on_team[team];
}

bot_get_team_limit() {
  return int(bot_get_client_limit() / 2);
}

bot_get_client_limit() {
  maxplayers = getdvarint("party_maxplayers", 0);

  if(maxplayers > level.maxclients)
    return level.maxclients;

  return maxplayers;
}

bot_queued_process_level_thread() {
  self notify("bot_queued_process_level_thread");
  self endon("bot_queued_process_level_thread");
  wait 0.05;

  for(;;) {
    if(isDefined(level.bot_queued_process_queue) && level.bot_queued_process_queue.size > 0) {
      _id_FA89613ACD0EB87E = level.bot_queued_process_queue[0];

      if(isDefined(_id_FA89613ACD0EB87E) && isDefined(_id_FA89613ACD0EB87E.owner)) {
        result = undefined;

        if(isDefined(_id_FA89613ACD0EB87E.parm4))
          result = _id_FA89613ACD0EB87E.owner[[_id_FA89613ACD0EB87E.func]](_id_FA89613ACD0EB87E.parm1, _id_FA89613ACD0EB87E.parm2, _id_FA89613ACD0EB87E.parm3, _id_FA89613ACD0EB87E.parm4);
        else if(isDefined(_id_FA89613ACD0EB87E.parm3))
          result = _id_FA89613ACD0EB87E.owner[[_id_FA89613ACD0EB87E.func]](_id_FA89613ACD0EB87E.parm1, _id_FA89613ACD0EB87E.parm2, _id_FA89613ACD0EB87E.parm3);
        else if(isDefined(_id_FA89613ACD0EB87E.parm2))
          result = _id_FA89613ACD0EB87E.owner[[_id_FA89613ACD0EB87E.func]](_id_FA89613ACD0EB87E.parm1, _id_FA89613ACD0EB87E.parm2);
        else if(isDefined(_id_FA89613ACD0EB87E.parm1))
          result = _id_FA89613ACD0EB87E.owner[[_id_FA89613ACD0EB87E.func]](_id_FA89613ACD0EB87E.parm1);
        else
          result = _id_FA89613ACD0EB87E.owner[[_id_FA89613ACD0EB87E.func]]();

        _id_FA89613ACD0EB87E.owner notify(_id_FA89613ACD0EB87E.name_complete, result);
      }

      _id_56F91C8CE10A0A41 = [];

      for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < level.bot_queued_process_queue.size; _id_AC0E594AC96AA3A8++)
        _id_56F91C8CE10A0A41[_id_AC0E594AC96AA3A8 - 1] = level.bot_queued_process_queue[_id_AC0E594AC96AA3A8];

      level.bot_queued_process_queue = _id_56F91C8CE10A0A41;
    }

    wait 0.05;
  }
}

bot_queued_process(_id_A5CF00537DFE0418, _id_95A9699B83906B59, _id_1F2EB21D96060BAF, _id_1F2EB31D96060DE2, _id_1F2EB41D96061015, _id_1F2EAD1D960600B0) {
  if(!isDefined(level.bot_queued_process_queue))
    level.bot_queued_process_queue = [];

  foreach(index, _id_FA89613ACD0EB87E in level.bot_queued_process_queue) {
    if(_id_FA89613ACD0EB87E.owner == self && _id_FA89613ACD0EB87E.name == _id_A5CF00537DFE0418) {
      self notify(_id_FA89613ACD0EB87E.name);
      level.bot_queued_process_queue[index] = undefined;
    }
  }

  _id_FA89613ACD0EB87E = spawnStruct();
  _id_FA89613ACD0EB87E.owner = self;
  _id_FA89613ACD0EB87E.name = _id_A5CF00537DFE0418;
  _id_FA89613ACD0EB87E.name_complete = _id_FA89613ACD0EB87E.name + "_done";
  _id_FA89613ACD0EB87E.func = _id_95A9699B83906B59;
  _id_FA89613ACD0EB87E.parm1 = _id_1F2EB21D96060BAF;
  _id_FA89613ACD0EB87E.parm2 = _id_1F2EB31D96060DE2;
  _id_FA89613ACD0EB87E.parm3 = _id_1F2EB41D96061015;
  _id_FA89613ACD0EB87E.parm4 = _id_1F2EAD1D960600B0;
  level.bot_queued_process_queue[level.bot_queued_process_queue.size] = _id_FA89613ACD0EB87E;

  if(!isDefined(level.bot_queued_process_level_thread_active)) {
    level.bot_queued_process_level_thread_active = 1;
    level thread bot_queued_process_level_thread();
  }

  self waittill(_id_FA89613ACD0EB87E.name_complete, result);
  return result;
}

bot_is_remote_or_linked() {
  return scripts\mp\utility\player::isusingremote() || self islinked();
}

bot_point_is_on_pathgrid(point, radius, height) {
  if(!isDefined(radius))
    radius = 256;

  if(!isDefined(height))
    height = 72;

  closestpoint = getclosestpointonnavmesh(point);
  _id_813AE95CBDEE3507 = closestpoint - point;

  if(length2dsquared(_id_813AE95CBDEE3507) > radius * radius)
    return 0;

  if(abs(_id_813AE95CBDEE3507[2]) > height)
    return 0;

  return 1;
}

bot_monitor_enemy_camp_spots(validatefunc) {
  level endon("game_ended");
  self notify("bot_monitor_enemy_camp_spots");
  self endon("bot_monitor_enemy_camp_spots");
  level.enemy_camp_spots = [];
  level.enemy_camp_assassin_goal = [];
  level.enemy_camp_assassin = [];

  for(;;) {
    wait 1.0;
    _id_C5CB5B18BBD3BC7C = [];

    if(!isDefined(validatefunc)) {
      continue;
    }
    foreach(_id_D7836AB41DCA3E4A in level.participants) {
      if(!isDefined(_id_D7836AB41DCA3E4A.team)) {
        continue;
      }
      if(_id_D7836AB41DCA3E4A[[validatefunc]]() && !isDefined(_id_C5CB5B18BBD3BC7C[_id_D7836AB41DCA3E4A.team])) {
        level.enemy_camp_assassin[_id_D7836AB41DCA3E4A.team] = undefined;
        level.enemy_camp_spots[_id_D7836AB41DCA3E4A.team] = _id_D7836AB41DCA3E4A botpredictenemycampspots(1);

        if(isDefined(level.enemy_camp_spots[_id_D7836AB41DCA3E4A.team])) {
          if(!isDefined(level.enemy_camp_assassin_goal[_id_D7836AB41DCA3E4A.team]) || !scripts\engine\utility::array_contains(level.enemy_camp_spots[_id_D7836AB41DCA3E4A.team], level.enemy_camp_assassin_goal[_id_D7836AB41DCA3E4A.team]))
            level.enemy_camp_assassin_goal[_id_D7836AB41DCA3E4A.team] = scripts\engine\utility::random(level.enemy_camp_spots[_id_D7836AB41DCA3E4A.team]);

          if(isDefined(level.enemy_camp_assassin_goal[_id_D7836AB41DCA3E4A.team])) {
            _id_70B4E4D225874359 = [];

            foreach(_id_9D211F46B524698A in level.participants) {
              if(!isDefined(_id_9D211F46B524698A.team)) {
                continue;
              }
              if(_id_9D211F46B524698A[[validatefunc]]() && _id_9D211F46B524698A.team == _id_D7836AB41DCA3E4A.team)
                _id_70B4E4D225874359[_id_70B4E4D225874359.size] = _id_9D211F46B524698A;
            }

            _id_70B4E4D225874359 = sortbydistance(_id_70B4E4D225874359, level.enemy_camp_assassin_goal[_id_D7836AB41DCA3E4A.team]);

            if(_id_70B4E4D225874359.size > 0)
              level.enemy_camp_assassin[_id_D7836AB41DCA3E4A.team] = _id_70B4E4D225874359[0];
          }
        }

        _id_C5CB5B18BBD3BC7C[_id_D7836AB41DCA3E4A.team] = 1;
      }
    }
  }
}

bot_valid_camp_assassin() {
  if(!isDefined(self))
    return 0;

  if(!isai(self))
    return 0;

  if(!isDefined(self.team))
    return 0;

  if(self.team == "spectator")
    return 0;

  if(!isalive(self))
    return 0;

  if(!scripts\mp\utility\entity::isaiteamparticipant(self))
    return 0;

  if(!isDefined(self.personality) || self.personality == "camper")
    return 0;

  return 1;
}

bot_update_camp_assassin() {
  if(!isDefined(level.enemy_camp_assassin)) {
    return;
  }
  if(!isDefined(level.enemy_camp_assassin[self.team])) {
    return;
  }
  if(level.enemy_camp_assassin[self.team] == self) {
    scripts\mp\bots\bots_strategy::bot_defend_stop();
    self botsetscriptgoal(level.enemy_camp_assassin_goal[self.team], 128, "objective", undefined, 256);
    bot_waittill_goal_or_fail();
  }
}

bot_force_stance_for_time(stance, _id_CC748B6D457627FE) {
  self notify("bot_force_stance_for_time");
  self endon("bot_force_stance_for_time");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self botsetstance(stance);
  wait(_id_CC748B6D457627FE);
  self botsetstance("none");
}

set_high_priority_target_for_bot(bot) {
  if(!(isDefined(self.high_priority_for) && scripts\engine\utility::array_contains(self.high_priority_for, bot))) {
    self.high_priority_for = scripts\engine\utility::array_add(self.high_priority_for, bot);
    bot notify("calculate_new_level_targets");
  }
}

add_to_bot_use_targets(_id_01FFFA800EA7104B, use_time) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_add_to_level_targets"])) {
    _id_01FFFA800EA7104B.use_time = use_time;
    _id_01FFFA800EA7104B.bot_interaction_type = "use";
    [[level.bot_funcs["bots_add_to_level_targets"]]](_id_01FFFA800EA7104B);
  }
}

remove_from_bot_use_targets(_id_086D13C63AF450E1) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_remove_from_level_targets"]))
    [[level.bot_funcs["bots_remove_from_level_targets"]]](_id_086D13C63AF450E1);
}

add_to_bot_damage_targets(_id_5CF83A761F7A3EBD) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_add_to_level_targets"])) {
    _id_5CF83A761F7A3EBD.bot_interaction_type = "damage";
    [[level.bot_funcs["bots_add_to_level_targets"]]](_id_5CF83A761F7A3EBD);
  }
}

remove_from_bot_damage_targets(_id_7EA60499D879295D) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_remove_from_level_targets"]))
    [[level.bot_funcs["bots_remove_from_level_targets"]]](_id_7EA60499D879295D);
}

notify_enemy_bots_bomb_used(type) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["notify_enemy_bots_bomb_used"]))
    self[[level.bot_funcs["notify_enemy_bots_bomb_used"]]](type);
}

get_rank_xp_for_bot() {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bot_get_rank_xp"]))
    return self[[level.bot_funcs["bot_get_rank_xp"]]]();
}

bot_israndom() {
  return self botisrandomized();
}

client_is_dev_bot(_id_2C6CA80E296FED3A) {
  if(!isbot(_id_2C6CA80E296FED3A))
    return 0;

  if(!dev_spawning_bots())
    return 0;

  return 1;
}

dev_spawning_bots() {
  return 0;
}

bot_disable_movement_for_time(time) {
  self notify("bot_disable_movement_for_time");
  self endon("bot_disable_movement_for_time");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self botsetflag("disable_movement", 1);
  wait(time);
  self botsetflag("disable_movement", 0);
}

func_load_difficulty_table(table) {
  _id_977F24E61599CBBA = tablelookupgetnumrows(table);
  _id_D1818BFAC102014D = spawnStruct();
  _id_D1818BFAC102014D.settings = [];
  _id_D1818BFAC102014D.settings["recruit"] = [];
  _id_D1818BFAC102014D.settings["regular"] = [];
  _id_D1818BFAC102014D.settings["hardened"] = [];
  _id_D1818BFAC102014D.settings["veteran"] = [];

  for(_id_09DD5D9E57E7E36D = 0; _id_09DD5D9E57E7E36D < _id_977F24E61599CBBA; _id_09DD5D9E57E7E36D++) {
    _id_8C958BDE9A9F8547 = tablelookupbyrow(table, _id_09DD5D9E57E7E36D, 0);
    _id_D1818BFAC102014D.settings["recruit"][_id_8C958BDE9A9F8547] = spawnStruct();
    _id_D1818BFAC102014D.settings["regular"][_id_8C958BDE9A9F8547] = spawnStruct();
    _id_D1818BFAC102014D.settings["hardened"][_id_8C958BDE9A9F8547] = spawnStruct();
    _id_D1818BFAC102014D.settings["veteran"][_id_8C958BDE9A9F8547] = spawnStruct();
    _id_68BA1A56FB05CB94 = tablelookupbyrow(table, _id_09DD5D9E57E7E36D, 1);
    _id_D1818BFAC102014D.settings["recruit"][_id_8C958BDE9A9F8547] = _id_68BA1A56FB05CB94;
    _id_0CECE7F8AAA635CA = tablelookupbyrow(table, _id_09DD5D9E57E7E36D, 2);
    _id_D1818BFAC102014D.settings["regular"][_id_8C958BDE9A9F8547] = _id_0CECE7F8AAA635CA;
    _id_78FAFA0C1F2051D3 = tablelookupbyrow(table, _id_09DD5D9E57E7E36D, 3);
    _id_D1818BFAC102014D.settings["hardened"][_id_8C958BDE9A9F8547] = _id_78FAFA0C1F2051D3;
    _id_0AFFE5B99FC38864 = tablelookupbyrow(table, _id_09DD5D9E57E7E36D, 4);
    _id_D1818BFAC102014D.settings["veteran"][_id_8C958BDE9A9F8547] = _id_0AFFE5B99FC38864;
  }

  return _id_D1818BFAC102014D;
}

bot_update_difficultysetttings(difficulty, _id_D1818BFAC102014D) {
  if(!isDefined(_id_D1818BFAC102014D))
    _id_D1818BFAC102014D = level.difficultytabledata;

  values = _id_D1818BFAC102014D.settings[difficulty];
  keys = getarraykeys(values);

  foreach(key in keys) {
    if(key == "burstFireType")
      val = _id_D1818BFAC102014D.settings[difficulty][key];
    else
      val = float(_id_D1818BFAC102014D.settings[difficulty][key]);

    self botsetdifficultysetting(key, val);
  }
}

bot_set_difficultysetting(difficulty, _id_8C958BDE9A9F8547, _id_D1818BFAC102014D) {
  if(!isDefined(_id_D1818BFAC102014D))
    _id_D1818BFAC102014D = level.difficultytabledata;

  values = _id_D1818BFAC102014D.settings[difficulty];
  keys = getarraykeys(values);

  foreach(key in keys) {
    if(key != _id_8C958BDE9A9F8547) {
      continue;
    }
    if(key == "burstFireType")
      val = _id_D1818BFAC102014D.settings[difficulty][key];
    else
      val = float(_id_D1818BFAC102014D.settings[difficulty][key]);

    self botsetdifficultysetting(key, val);
    return;
  }
}