/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_personality.gsc
************************************************/

setup_personalities() {
  level.bot_personality = [];
  level.bot_personality_list = [];
  level.bot_personality["active"][0] = "run_and_gun";
  level.bot_personality["active"][1] = "cqb";
  level.bot_personality["stationary"][0] = "camper";
  level.bot_personality_type = [];

  foreach(index, _id_CCCF318246AE77DD in level.bot_personality) {
    foreach(personality in _id_CCCF318246AE77DD) {
      level.bot_personality_type[personality] = index;
      level.bot_personality_list[level.bot_personality_list.size] = personality;
    }
  }

  level.bot_personality_types_desired = [];
  level.bot_personality_types_desired["active"] = 4;
  level.bot_personality_types_desired["stationary"] = 1;
  level.bot_pers_init = [];
  level.bot_pers_init["run_and_gun"] = ::init_personality_default;
  level.bot_pers_init["camper"] = ::init_personality_camper;
  level.bot_pers_update["run_and_gun"] = ::update_personality_default;
  level.bot_pers_update["camper"] = ::update_personality_camper;
}

bot_assign_personality_functions() {
  self.personality = self botgetpersonality();
  self.pers["personality"] = self.personality;
  self.personality_init_function = level.bot_pers_init[self.personality];

  if(!isDefined(self.personality_init_function))
    self.personality_init_function = level.bot_pers_init["run_and_gun"];

  self[[self.personality_init_function]]();
  self.personality_update_function = level.bot_pers_update[self.personality];

  if(!isDefined(self.personality_update_function))
    self.personality_update_function = level.bot_pers_update["run_and_gun"];
}

bot_balance_personality() {
  if(isDefined(self.personalitymanuallyset) && self.personalitymanuallyset) {
    return;
  }
  if(isDefined(self.pers["personality"])) {
    self botsetpersonality(self.pers["personality"]);
    return;
  }

  _id_2B4384D19A199121 = self.team;

  if(!isDefined(_id_2B4384D19A199121) && !isDefined(self.bot_team))
    _id_2B4384D19A199121 = self.pers["team"];

  _id_55D47D98F8988A2D = getarraykeys(level.bot_personality_types_desired);
  _id_D65F62258C383749 = [];
  _id_1560F7B587190CF0 = [];

  foreach(_id_30F9CA2FA8449648, _id_CCCF318246AE77DD in level.bot_personality) {
    _id_1560F7B587190CF0[_id_30F9CA2FA8449648] = 0;

    foreach(personality in _id_CCCF318246AE77DD)
    _id_D65F62258C383749[personality] = 0;
  }

  foreach(bot in level.participants) {
    if(bot == self) {
      continue;
    }
    if(!scripts\mp\utility\entity::isteamparticipant(bot) || !isDefined(bot.has_balanced_personality)) {
      continue;
    }
    if(isDefined(bot.team) && bot.team == _id_2B4384D19A199121 || !level.teambased) {
      personality = bot botgetpersonality();
      _id_30F9CA2FA8449648 = level.bot_personality_type[personality];
      _id_D65F62258C383749[personality] = _id_D65F62258C383749[personality] + 1;
      _id_1560F7B587190CF0[_id_30F9CA2FA8449648] = _id_1560F7B587190CF0[_id_30F9CA2FA8449648] + 1;
    }
  }

  _id_E1631B2CD55E620B = [];

  foreach(type in _id_55D47D98F8988A2D)
  _id_E1631B2CD55E620B[type] = int(_id_1560F7B587190CF0[type] / level.bot_personality_types_desired[type]);

  _id_E59B08D6C09BB673 = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_55D47D98F8988A2D.size && !isDefined(_id_E59B08D6C09BB673); _id_AC0E594AC96AA3A8++) {
    _id_D5E564ACD20D2E2A = _id_55D47D98F8988A2D[_id_AC0E594AC96AA3A8];
    _id_5CEEDB6C6B6E3DD4 = 1;

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_55D47D98F8988A2D.size; _id_AC0E5C4AC96AAA41++) {
      _id_D5E563ACD20D2BF7 = _id_55D47D98F8988A2D[_id_AC0E5C4AC96AAA41];

      if(_id_D5E564ACD20D2E2A != _id_D5E563ACD20D2BF7) {
        if(_id_E1631B2CD55E620B[_id_D5E564ACD20D2E2A] >= _id_E1631B2CD55E620B[_id_D5E563ACD20D2BF7])
          _id_5CEEDB6C6B6E3DD4 = 0;
      }
    }

    if(_id_5CEEDB6C6B6E3DD4)
      _id_E59B08D6C09BB673 = _id_D5E564ACD20D2E2A;
  }

  if(!isDefined(_id_E59B08D6C09BB673)) {
    _id_4846C4BCE18FD427 = [];

    foreach(type in _id_55D47D98F8988A2D)
    _id_4846C4BCE18FD427[type] = level.bot_personality_types_desired[type] - _id_1560F7B587190CF0[type] % level.bot_personality_types_desired[type];

    _id_C01D5A3093AC1E22 = 0;

    foreach(type in _id_55D47D98F8988A2D)
    _id_C01D5A3093AC1E22 = _id_C01D5A3093AC1E22 + _id_4846C4BCE18FD427[type];

    _id_6A8A60939CE622B0 = randomfloat(_id_C01D5A3093AC1E22);

    foreach(type in _id_55D47D98F8988A2D) {
      if(_id_6A8A60939CE622B0 < _id_4846C4BCE18FD427[type]) {
        _id_E59B08D6C09BB673 = type;
        break;
      }

      _id_6A8A60939CE622B0 = _id_6A8A60939CE622B0 - _id_4846C4BCE18FD427[type];
    }
  }

  _id_F172415EA82E0395 = undefined;
  _id_25A35F1F4BFACFA5 = undefined;
  _id_7C1E7AC0E071D88E = 9999;
  _id_6E83E2B8AFBFA881 = undefined;
  _id_7E2D2363D6EF89EA = -9999;
  _id_51888C1474F8523D = scripts\engine\utility::array_randomize(level.bot_personality[_id_E59B08D6C09BB673]);

  foreach(personality in _id_51888C1474F8523D) {
    if(_id_D65F62258C383749[personality] < _id_7C1E7AC0E071D88E) {
      _id_25A35F1F4BFACFA5 = personality;
      _id_7C1E7AC0E071D88E = _id_D65F62258C383749[personality];
    }

    if(_id_D65F62258C383749[personality] > _id_7E2D2363D6EF89EA) {
      _id_6E83E2B8AFBFA881 = personality;
      _id_7E2D2363D6EF89EA = _id_D65F62258C383749[personality];
    }
  }

  if(_id_7E2D2363D6EF89EA - _id_7C1E7AC0E071D88E >= 2)
    _id_F172415EA82E0395 = _id_25A35F1F4BFACFA5;
  else
    _id_F172415EA82E0395 = scripts\engine\utility::random(level.bot_personality[_id_E59B08D6C09BB673]);

  if(self botgetpersonality() != _id_F172415EA82E0395)
    self botsetpersonality(_id_F172415EA82E0395);

  self.has_balanced_personality = 1;
}

init_personality_camper() {
  clear_camper_data();
}

init_personality_default() {
  clear_camper_data();
}

update_personality_camper() {
  if(should_select_new_ambush_point() && !scripts\mp\bots\bots_util::bot_is_defending() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
    _id_8635A138F0BA2A2A = self botgetscriptgoaltype();
    _id_8CBB02B399F5A5B2 = 0;

    if(!isDefined(self.camper_time_started_hunting))
      self.camper_time_started_hunting = 0;

    _id_0CDCA96A984FDB85 = _id_8635A138F0BA2A2A == "hunt";
    _id_A703A9E683F32F15 = gettime() > self.camper_time_started_hunting + 10000;

    if((!_id_0CDCA96A984FDB85 || _id_A703A9E683F32F15) && !scripts\mp\bots\bots_util::bot_out_of_ammo()) {
      if(!self bothasscriptgoal())
        bot_random_path();

      if(isDefined(level.override_find_camp_node))
        _id_8CBB02B399F5A5B2 = [[level.override_find_camp_node]]();

      if(!_id_8CBB02B399F5A5B2) {
        _id_8CBB02B399F5A5B2 = find_camp_node();

        if(!_id_8CBB02B399F5A5B2)
          self.camper_time_started_hunting = gettime();
      }
    }

    if(isDefined(_id_8CBB02B399F5A5B2) && _id_8CBB02B399F5A5B2) {
      self.ambush_entrances = scripts\mp\bots\bots_util::bot_queued_process("bot_find_ambush_entrances", ::bot_find_ambush_entrances, self.node_ambushing_from, 1);
      _id_A43DC094A51DD46C = scripts\mp\bots\bots_strategy::bot_get_ambush_trap_item("trap_directional", "trap", "c4");

      if(isDefined(_id_A43DC094A51DD46C)) {
        _id_30E1DFEA54864B8F = gettime();
        scripts\mp\bots\bots_strategy::bot_set_ambush_trap(_id_A43DC094A51DD46C, self.ambush_entrances, self.node_ambushing_from, self.ambush_yaw);
        _id_30E1DFEA54864B8F = gettime() - _id_30E1DFEA54864B8F;

        if(_id_30E1DFEA54864B8F > 0 && isDefined(self.ambush_end) && isDefined(self.node_ambushing_from)) {
          self.ambush_end = self.ambush_end + _id_30E1DFEA54864B8F;
          self.node_ambushing_from.bot_ambush_end = self.ambush_end + 10000;
        }
      }

      if(!scripts\mp\bots\bots_strategy::bot_has_tactical_goal() && !scripts\mp\bots\bots_util::bot_is_defending() && isDefined(self.node_ambushing_from)) {
        _id_AC5A0E2F2B31FA6B = self botsetscriptgoalnode(self.node_ambushing_from, "camp", self.ambush_yaw);

        if(_id_AC5A0E2F2B31FA6B) {
          thread clear_script_goal_on("bad_path", "node_relinquished", "out_of_ammo");
          thread watch_out_of_ammo();
          thread bot_add_ambush_time_delayed("clear_camper_data", "goal");
          thread bot_watch_entrances_delayed("clear_camper_data", "bot_add_ambush_time_delayed", self.ambush_entrances, self.ambush_yaw);
          childthread bot_try_trap_follower("clear_camper_data", "goal");
          return;
        }

        clear_camper_data();
        return;
        return;
      }
    } else {
      if(_id_8635A138F0BA2A2A == "camp")
        self botclearscriptgoal();

      update_personality_default();
    }
  }
}

update_personality_default() {
  _id_4CBD8AE83804749C = undefined;
  _id_F8CD7C50CE12C857 = self bothasscriptgoal();

  if(_id_F8CD7C50CE12C857)
    _id_4CBD8AE83804749C = self botgetscriptgoal();

  if(gettime() - self.lastspawntime > 5000)
    bot_try_trap_follower();

  if(!scripts\mp\bots\bots_strategy::bot_has_tactical_goal() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
    distsq = undefined;
    goalradius = undefined;

    if(_id_F8CD7C50CE12C857) {
      distsq = distancesquared(self.origin, _id_4CBD8AE83804749C);
      goalradius = self botgetscriptgoalRadius();
      _id_73A7BF31171D039A = goalradius * 2;

      if(isDefined(self.bot_memory_goal) && distsq < _id_73A7BF31171D039A * _id_73A7BF31171D039A) {
        _id_3068AC978537C7BE = botmemoryflags("investigated");
        botflagmemoryevents(0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, _id_73A7BF31171D039A, "kill", _id_3068AC978537C7BE, self);
        botflagmemoryevents(0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, _id_73A7BF31171D039A, "death", _id_3068AC978537C7BE, self);
        self.bot_memory_goal = undefined;
        self.bot_memory_goal_time = undefined;
      }
    }

    if(!_id_F8CD7C50CE12C857 || distsq < goalradius * goalradius) {
      _id_74D7ABD5F49C5C17 = bot_random_path();
      _id_BF1B72D688BC972D = undefined;
      _id_D99A6026E41A6CB1 = undefined;

      if(_id_74D7ABD5F49C5C17) {
        _id_BF1B72D688BC972D = self botgetscriptgoal();
        _id_D99A6026E41A6CB1 = self botgetscriptgoaltype();
      }

      _id_B56CD59CC7090A01 = 25;

      if(istrue(self.encourage_explosive_use))
        _id_B56CD59CC7090A01 = 50;

      if(_id_74D7ABD5F49C5C17 && randomfloat(100) < _id_B56CD59CC7090A01) {
        _id_A43DC094A51DD46C = scripts\mp\bots\bots_strategy::bot_get_ambush_trap_item("trap_directional", "trap");

        if(isDefined(_id_A43DC094A51DD46C)) {
          _id_3383068FEAA6E948 = self botgetscriptgoal();

          if(isDefined(_id_3383068FEAA6E948)) {
            _id_2C8DEFA46C5DAA22 = getclosestnodeinsight(_id_3383068FEAA6E948);

            if(isDefined(_id_2C8DEFA46C5DAA22) && getlinkednodes(_id_2C8DEFA46C5DAA22).size > 0) {
              ambush_entrances = bot_find_ambush_entrances(_id_2C8DEFA46C5DAA22, 0);
              _id_AAD3E36E9762AE4B = scripts\mp\bots\bots_strategy::bot_set_ambush_trap(_id_A43DC094A51DD46C, ambush_entrances, _id_2C8DEFA46C5DAA22);

              if(!isDefined(_id_AAD3E36E9762AE4B) || _id_AAD3E36E9762AE4B) {
                self botclearscriptgoal();
                _id_74D7ABD5F49C5C17 = bot_random_path();

                if(_id_74D7ABD5F49C5C17) {
                  _id_BF1B72D688BC972D = self botgetscriptgoal();
                  _id_D99A6026E41A6CB1 = self botgetscriptgoaltype();
                }
              }
            }
          }
        }
      }

      if(_id_74D7ABD5F49C5C17 && self bothasscriptgoal()) {
        _id_7D6FE43B33853BBD = self botgetscriptgoal();
        _id_E7073093C8C51701 = self botgetscriptgoaltype();
        _id_C7DB4BBA18015B56 = scripts\mp\bots\bots_util::bot_vectors_are_equal(_id_BF1B72D688BC972D, _id_7D6FE43B33853BBD);
        _id_327022DFFA914C44 = _id_D99A6026E41A6CB1 == _id_E7073093C8C51701;

        if(_id_C7DB4BBA18015B56 && _id_327022DFFA914C44)
          thread clear_script_goal_on("enemy", "bad_path", "goal", "node_relinquished", "search_end");
      }
    }
  }
}

bot_try_trap_follower(_id_6DE89AC92D7FA442, _id_CB4E6525B1E7DE54) {}

clear_script_goal_on(_id_079F302F0B65822E, _id_079F2F2F0B657FFB, _id_079F2E2F0B657DC8, _id_079F352F0B658D2D, _id_079F342F0B658AFA) {
  self notify("clear_script_goal_on");
  self endon("clear_script_goal_on");
  self endon("death_or_disconnect");
  self endon("start_tactical_goal");
  _id_15316F794A1B9615 = self botgetscriptgoal();
  _id_713DA3118338A569 = 1;

  while(_id_713DA3118338A569) {
    result = scripts\engine\utility::waittill_any_return_6(_id_079F302F0B65822E, _id_079F2F2F0B657FFB, _id_079F2E2F0B657DC8, _id_079F352F0B658D2D, _id_079F342F0B658AFA, "script_goal_changed");
    _id_713DA3118338A569 = 0;
    _id_7B4EE638A6F8339C = 1;

    if(result == "node_relinquished" || result == "goal" || result == "script_goal_changed") {
      if(!self bothasscriptgoal())
        _id_7B4EE638A6F8339C = 0;
      else {
        _id_3658F8E451E8136C = self botgetscriptgoal();
        _id_7B4EE638A6F8339C = scripts\mp\bots\bots_util::bot_vectors_are_equal(_id_15316F794A1B9615, _id_3658F8E451E8136C);
      }
    }

    if(result == "enemy" && isDefined(self.enemy)) {
      _id_7B4EE638A6F8339C = 0;
      _id_713DA3118338A569 = 1;
    }

    if(_id_7B4EE638A6F8339C)
      self botclearscriptgoal();
  }
}

watch_out_of_ammo() {
  self notify("watch_out_of_ammo");
  self endon("watch_out_of_ammo");
  self endon("death_or_disconnect");

  while(!scripts\mp\bots\bots_util::bot_out_of_ammo())
    wait 0.5;

  self notify("out_of_ammo");
}

bot_add_ambush_time_delayed(_id_6DE89AC92D7FA442, _id_B0FDDB86A2358953) {
  self notify("bot_add_ambush_time_delayed");
  self endon("bot_add_ambush_time_delayed");
  self endon("death_or_disconnect");

  if(isDefined(_id_6DE89AC92D7FA442))
    self endon(_id_6DE89AC92D7FA442);

  self endon("node_relinquished");
  self endon("bad_path");
  starttime = gettime();

  if(isDefined(_id_B0FDDB86A2358953))
    self waittill(_id_B0FDDB86A2358953);

  if(isDefined(self.ambush_end) && isDefined(self.node_ambushing_from)) {
    self.ambush_end = self.ambush_end + (gettime() - starttime);
    self.node_ambushing_from.bot_ambush_end = self.ambush_end + 10000;
  }

  self notify("bot_add_ambush_time_delayed");
}

bot_watch_entrances_delayed(_id_6DE89AC92D7FA442, _id_B0FDDB86A2358953, _id_1C17E70621BB1BBC, yaw) {
  self notify("bot_watch_entrances_delayed");

  if(_id_1C17E70621BB1BBC.size > 0) {
    self endon("bot_watch_entrances_delayed");
    self endon("death_or_disconnect");
    self endon(_id_6DE89AC92D7FA442);
    self endon("node_relinquished");
    self endon("bad_path");

    if(isDefined(_id_B0FDDB86A2358953))
      self waittill(_id_B0FDDB86A2358953);

    self endon("path_enemy");
    childthread scripts\mp\bots\bots_util::bot_watch_nodes(_id_1C17E70621BB1BBC, yaw, 0, self.ambush_end);
    childthread bot_monitor_watch_entrances_camp();
  }
}

bot_monitor_watch_entrances_camp() {
  self notify("bot_monitor_watch_entrances_camp");
  self endon("bot_monitor_watch_entrances_camp");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");
  self endon("bot_watch_nodes_stop");
  self endon("death_or_disconnect");

  while(!isDefined(self.watch_nodes))
    wait 0.05;

  while(isDefined(self.watch_nodes)) {
    foreach(node in self.watch_nodes)
    node.watch_node_chance[self.entity_number] = node.watch_node_base_chance[self.entity_number];

    scripts\mp\bots\bots_strategy::prioritize_watch_nodes_toward_enemies(0.5);
    wait(randomfloatrange(0.5, 0.75));
  }
}

bot_find_ambush_entrances(_id_2C8DEFA46C5DAA22, _id_40516918C495CF09) {
  self endon("disconnect");
  _id_8B1A576D8E46A06F = [];
  _id_1C17E70621BB1BBC = findentrances(_id_2C8DEFA46C5DAA22.origin);

  if(isDefined(_id_1C17E70621BB1BBC) && _id_1C17E70621BB1BBC.size > 0) {
    wait 0.05;
    _id_5B7F7FFCBB727301 = _id_2C8DEFA46C5DAA22.type != "Cover Stand" && _id_2C8DEFA46C5DAA22.type != "Conceal Stand";

    if(_id_5B7F7FFCBB727301 && _id_40516918C495CF09)
      _id_1C17E70621BB1BBC = self botnodescoremultiple(_id_1C17E70621BB1BBC, "node_exposure_vis", _id_2C8DEFA46C5DAA22.origin, "crouch");

    foreach(node in _id_1C17E70621BB1BBC) {
      if(distancesquared(self.origin, node.origin) < 90000) {
        continue;
      }
      if(_id_5B7F7FFCBB727301 && _id_40516918C495CF09) {
        wait 0.05;

        if(!scripts\mp\bots\bots_util::entrance_visible_from(node.origin, _id_2C8DEFA46C5DAA22.origin, "crouch"))
          continue;
      }

      _id_8B1A576D8E46A06F[_id_8B1A576D8E46A06F.size] = node;
    }
  }

  return _id_8B1A576D8E46A06F;
}

bot_filter_ambush_inuse(nodes) {
  _id_F4FD5484E9DE558D = [];
  _id_64F88D0441939203 = gettime();
  _id_0D1EA28EA71337FF = nodes.size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0D1EA28EA71337FF; _id_AC0E594AC96AA3A8++) {
    node = nodes[_id_AC0E594AC96AA3A8];

    if(!isDefined(node.bot_ambush_end) || _id_64F88D0441939203 > node.bot_ambush_end)
      _id_F4FD5484E9DE558D[_id_F4FD5484E9DE558D.size] = node;
  }

  return _id_F4FD5484E9DE558D;
}

bot_filter_ambush_vicinity(nodes, bot, radius) {
  _id_F4FD5484E9DE558D = [];
  _id_761C3A588103E918 = [];
  radiussq = radius * radius;

  if(level.teambased) {
    foreach(player in level.participants) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(!isDefined(player.team)) {
        continue;
      }
      if(player.team == bot.team && player != bot && isDefined(player.node_ambushing_from))
        _id_761C3A588103E918[_id_761C3A588103E918.size] = player.node_ambushing_from.origin;
    }
  }

  _id_D3D9F13530067129 = _id_761C3A588103E918.size;
  _id_0D1EA28EA71337FF = nodes.size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0D1EA28EA71337FF; _id_AC0E594AC96AA3A8++) {
    _id_AC0A60A93BEAEF5B = 0;
    node = nodes[_id_AC0E594AC96AA3A8];

    for(_id_AC0E5C4AC96AAA41 = 0; !_id_AC0A60A93BEAEF5B && _id_AC0E5C4AC96AAA41 < _id_D3D9F13530067129; _id_AC0E5C4AC96AAA41++) {
      distsq = distancesquared(_id_761C3A588103E918[_id_AC0E5C4AC96AAA41], node.origin);
      _id_AC0A60A93BEAEF5B = distsq < radiussq;
    }

    if(!_id_AC0A60A93BEAEF5B)
      _id_F4FD5484E9DE558D[_id_F4FD5484E9DE558D.size] = node;
  }

  return _id_F4FD5484E9DE558D;
}

clear_camper_data() {
  self notify("clear_camper_data");

  if(isDefined(self.node_ambushing_from) && isDefined(self.node_ambushing_from.bot_ambush_end))
    self.node_ambushing_from.bot_ambush_end = undefined;

  self.node_ambushing_from = undefined;
  self.point_to_ambush = undefined;
  self.ambush_yaw = undefined;
  self.ambush_entrances = undefined;
  self.ambush_duration = randomintrange(20000, 30000);
  self.ambush_end = -1;
}

should_select_new_ambush_point() {
  if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal())
    return 0;

  if(gettime() > self.ambush_end)
    return 1;

  if(!self bothasscriptgoal())
    return 1;

  return 0;
}

find_camp_node() {
  self notify("find_camp_node");
  self endon("find_camp_node");
  return scripts\mp\bots\bots_util::bot_queued_process("find_camp_node_worker", ::find_camp_node_worker);
}

find_camp_node_worker() {
  self notify("find_camp_node_worker");
  self endon("find_camp_node_worker");
  self endon("death_or_disconnect");
  level endon("game_ended");
  clear_camper_data();

  if(level.zonecount <= 0)
    return 0;

  _id_FE9216675F0EF975 = getzonenearest(self.origin);
  _id_BF99D5CCBEB6B3C2 = undefined;
  _id_FF414D5C2D2B6DAA = undefined;
  _id_179A55CD72DDBAD8 = self getplayerangles();

  if(isDefined(_id_FE9216675F0EF975)) {
    _id_7E0E80E1E807C5DD = botzonenearestcount(_id_FE9216675F0EF975, self.team, -1, "enemy_predict", ">", 0, "ally", "<", 1);

    if(!isDefined(_id_7E0E80E1E807C5DD))
      _id_7E0E80E1E807C5DD = botzonenearestcount(_id_FE9216675F0EF975, self.team, -1, "enemy_predict", ">", 0);

    if(isDefined(_id_7E0E80E1E807C5DD)) {
      _id_8125A9234B033718 = getzonenodeforindex(_id_7E0E80E1E807C5DD);
      _id_A2160A66D6AFE030 = getlinkednodes(_id_8125A9234B033718);

      if(_id_A2160A66D6AFE030.size == 0)
        _id_7E0E80E1E807C5DD = undefined;
    }

    if(!isDefined(_id_7E0E80E1E807C5DD)) {
      _id_5D5CB5AA330E94CE = -1;
      _id_19F6D1F55402F7E4 = -1;

      for(z = 0; z < level.zonecount; z++) {
        _id_8125A9234B033718 = getzonenodeforindex(z);
        _id_A2160A66D6AFE030 = getlinkednodes(_id_8125A9234B033718);

        if(_id_A2160A66D6AFE030.size == 0) {
          continue;
        }
        _id_AE6EB5B684C1A94B = getzonepath(_id_FE9216675F0EF975, z);

        if(!isDefined(_id_AE6EB5B684C1A94B) || _id_AE6EB5B684C1A94B.size == 0) {
          continue;
        }
        _id_8151FA2D560582FA = scripts\engine\utility::random(getzonenodes(z));

        if(isDefined(_id_8151FA2D560582FA.targetname) && _id_8151FA2D560582FA.targetname == "no_bot_random_path") {
          continue;
        }
        dist = distance2dsquared(getzoneorigin(z), self.origin);

        if(dist <= _id_5D5CB5AA330E94CE) {
          continue;
        }
        _id_5D5CB5AA330E94CE = dist;
        _id_19F6D1F55402F7E4 = z;
      }

      if(_id_19F6D1F55402F7E4 >= 0)
        _id_7E0E80E1E807C5DD = _id_19F6D1F55402F7E4;
    }

    if(!isDefined(_id_7E0E80E1E807C5DD))
      return 0;

    _id_E2BE760B496592CC = getzonepath(_id_FE9216675F0EF975, _id_7E0E80E1E807C5DD);

    if(!isDefined(_id_E2BE760B496592CC) || _id_E2BE760B496592CC.size == 0)
      return 0;

    for(index = 0; index <= int(_id_E2BE760B496592CC.size / 2); index++) {
      _id_BF99D5CCBEB6B3C2 = _id_E2BE760B496592CC[index];
      _id_FF414D5C2D2B6DAA = _id_E2BE760B496592CC[int(min(index + 1, _id_E2BE760B496592CC.size - 1))];

      if(botzonegetcount(_id_FF414D5C2D2B6DAA, self.team, "enemy_predict") != 0) {
        break;
      }
    }

    if(isDefined(_id_BF99D5CCBEB6B3C2) && isDefined(_id_FF414D5C2D2B6DAA) && _id_BF99D5CCBEB6B3C2 != _id_FF414D5C2D2B6DAA) {
      _id_179A55CD72DDBAD8 = getzoneorigin(_id_FF414D5C2D2B6DAA) - getzoneorigin(_id_BF99D5CCBEB6B3C2);
      _id_179A55CD72DDBAD8 = vectortoangles(_id_179A55CD72DDBAD8);
    }
  }

  _id_BE95318B128CB635 = undefined;

  if(isDefined(_id_BF99D5CCBEB6B3C2)) {
    _id_6039C1E5F7DFD683 = 1;
    _id_1D9E8FE61F152E77 = 1;
    _id_BD257189257844C3 = 0;

    while(_id_6039C1E5F7DFD683) {
      _id_0DEF8CD540EAB8DC = getzonenodesbydist(_id_BF99D5CCBEB6B3C2, 800 * _id_1D9E8FE61F152E77, 1);

      if(_id_0DEF8CD540EAB8DC.size > 1024)
        _id_0DEF8CD540EAB8DC = getzonenodes(_id_BF99D5CCBEB6B3C2, 0);

      wait 0.05;
      _id_D80612AE080F4B21 = randomint(100);

      if(_id_D80612AE080F4B21 < 66 && _id_D80612AE080F4B21 >= 33)
        _id_179A55CD72DDBAD8 = (_id_179A55CD72DDBAD8[0], _id_179A55CD72DDBAD8[1] + 45, 0);
      else if(_id_D80612AE080F4B21 < 33)
        _id_179A55CD72DDBAD8 = (_id_179A55CD72DDBAD8[0], _id_179A55CD72DDBAD8[1] - 45, 0);

      if(_id_0DEF8CD540EAB8DC.size > 0) {
        while(_id_0DEF8CD540EAB8DC.size > 1024)
          _id_0DEF8CD540EAB8DC[_id_0DEF8CD540EAB8DC.size - 1] = undefined;

        _id_63F6A1513460BDB0 = int(clamp(_id_0DEF8CD540EAB8DC.size * 0.15, 1, 10));

        if(_id_BD257189257844C3)
          _id_0DEF8CD540EAB8DC = self botnodepickmultiple(_id_0DEF8CD540EAB8DC, _id_63F6A1513460BDB0, _id_63F6A1513460BDB0, "node_camp", anglesToForward(_id_179A55CD72DDBAD8), "lenient");
        else
          _id_0DEF8CD540EAB8DC = self botnodepickmultiple(_id_0DEF8CD540EAB8DC, _id_63F6A1513460BDB0, _id_63F6A1513460BDB0, "node_camp", anglesToForward(_id_179A55CD72DDBAD8));

        _id_0DEF8CD540EAB8DC = bot_filter_ambush_inuse(_id_0DEF8CD540EAB8DC);

        if(!isDefined(self.can_camp_near_others) || !self.can_camp_near_others) {
          _id_1F46245610EEC2E1 = 800;
          _id_0DEF8CD540EAB8DC = bot_filter_ambush_vicinity(_id_0DEF8CD540EAB8DC, self, _id_1F46245610EEC2E1);
        }

        if(_id_0DEF8CD540EAB8DC.size > 0)
          _id_BE95318B128CB635 = scripts\engine\utility::random_weight_sorted(_id_0DEF8CD540EAB8DC);
      }

      if(isDefined(_id_BE95318B128CB635))
        _id_6039C1E5F7DFD683 = 0;
      else if(isDefined(self.camping_needs_fallback_camp_location)) {
        if(_id_1D9E8FE61F152E77 == 1 && !_id_BD257189257844C3)
          _id_1D9E8FE61F152E77 = 3;
        else if(_id_1D9E8FE61F152E77 == 3 && !_id_BD257189257844C3)
          _id_BD257189257844C3 = 1;
        else if(_id_1D9E8FE61F152E77 == 3 && _id_BD257189257844C3)
          _id_6039C1E5F7DFD683 = 0;
      } else
        _id_6039C1E5F7DFD683 = 0;

      if(_id_6039C1E5F7DFD683)
        wait 0.05;
    }
  }

  if(!isDefined(_id_BE95318B128CB635) || !self botnodeavailable(_id_BE95318B128CB635))
    return 0;

  self.node_ambushing_from = _id_BE95318B128CB635;
  self.ambush_end = gettime() + self.ambush_duration;
  self.node_ambushing_from.bot_ambush_end = self.ambush_end;
  self.ambush_yaw = _id_179A55CD72DDBAD8[1];
  return 1;
}

find_ambush_node(_id_B8B7E211F170A50D, _id_DFE45DF4596AF64D) {
  clear_camper_data();

  if(isDefined(_id_B8B7E211F170A50D))
    self.point_to_ambush = _id_B8B7E211F170A50D;
  else {
    _id_B4A8E3757F09F084 = undefined;
    _id_685B8946E5EAC800 = getnodesinradius(self.origin, 5000, 0, 2000);

    if(_id_685B8946E5EAC800.size > 0)
      _id_B4A8E3757F09F084 = self botnodepick(_id_685B8946E5EAC800, _id_685B8946E5EAC800.size * 0.25, "node_traffic");

    if(isDefined(_id_B4A8E3757F09F084))
      self.point_to_ambush = _id_B4A8E3757F09F084.origin;
    else
      return 0;
  }

  _id_4E334D76041960F4 = 2000;

  if(isDefined(_id_DFE45DF4596AF64D))
    _id_4E334D76041960F4 = _id_DFE45DF4596AF64D;

  _id_4703D99A1B9A1D4E = getnodesinradius(self.point_to_ambush, _id_4E334D76041960F4, 0, 1000);
  _id_6CB886AB6CC39AE0 = undefined;

  if(_id_4703D99A1B9A1D4E.size > 0) {
    _id_63F6A1513460BDB0 = int(max(1, int(_id_4703D99A1B9A1D4E.size * 0.15)));
    _id_4703D99A1B9A1D4E = self botnodepickmultiple(_id_4703D99A1B9A1D4E, _id_63F6A1513460BDB0, _id_63F6A1513460BDB0, "node_ambush", self.point_to_ambush);
  }

  _id_4703D99A1B9A1D4E = bot_filter_ambush_inuse(_id_4703D99A1B9A1D4E);

  if(_id_4703D99A1B9A1D4E.size > 0)
    _id_6CB886AB6CC39AE0 = scripts\engine\utility::random_weight_sorted(_id_4703D99A1B9A1D4E);

  if(!isDefined(_id_6CB886AB6CC39AE0) || !self botnodeavailable(_id_6CB886AB6CC39AE0))
    return 0;

  self.node_ambushing_from = _id_6CB886AB6CC39AE0;
  self.ambush_end = gettime() + self.ambush_duration;
  self.node_ambushing_from.bot_ambush_end = self.ambush_end;
  _id_F145B0C599CCA2DD = vectorNormalize(self.point_to_ambush - self.node_ambushing_from.origin);
  _id_F9562F398E9050EA = vectortoangles(_id_F145B0C599CCA2DD);
  self.ambush_yaw = _id_F9562F398E9050EA[1];
  return 1;
}

bot_random_path() {
  if(scripts\mp\bots\bots_util::bot_is_remote_or_linked())
    return 0;

  return self[[level.bot_random_path_function]]();
}

bot_random_path_default() {
  result = 0;
  _id_6F9E4387A0601B1B = 50;

  if(self.personality == "camper")
    _id_6F9E4387A0601B1B = 0;

  goalpos = undefined;

  if(randomint(100) < _id_6F9E4387A0601B1B)
    goalpos = scripts\mp\bots\bots_util::bot_recent_point_of_interest();

  if(!isDefined(goalpos))
    goalpos = self botfindrandomgoal();

  if(isDefined(goalpos))
    result = self botsetscriptgoal(goalpos, 128, "hunt");

  return result;
}

bot_setup_callback_class() {
  if(scripts\mp\bots\bots_loadout::_id_A693C24DEF6FB1ED())
    return "callback";
  else
    return "class0";
}