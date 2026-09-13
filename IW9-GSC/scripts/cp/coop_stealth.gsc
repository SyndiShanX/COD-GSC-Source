/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\coop_stealth.gsc
***********************************************/

_id_A2C5010C4E9D31FE() {
  while(!isDefined(level.stealth))
    waitframe();

  setDvar("dvar_AE9C969DF88E37E1", 5000);
  setDvar("dvar_F72CE39DD23B00D1", 5000);
  setDvar("dvar_CDA36D9770CF5189", 150);
  level.stealth._id_792E4B9A380ADE11 = 5000;
  level.stealth._id_094F8771062F2161 = 5000;
  level.stealth._id_E2E3C78D7DC88605 = 22500;
  _func_4FF17EFD15D01D3F(256);
  _func_1611D0F6B5F84B9A(700);
  level.stealth.override_damage_auto_range = 200;
}

coop_stealth_init() {
  if(!scripts\engine\utility::flag_exist("raid_active"))
    scripts\engine\utility::flag_init("raid_active");

  if(!scripts\engine\utility::flag_exist("weapons_free"))
    scripts\engine\utility::flag_init("weapons_free");

  if(!scripts\engine\utility::flag_exist("stealth_enabled"))
    scripts\engine\utility::flag_init("stealth_enabled");

  setDvar("dvar_B1A48F998D883FFB", 1);

  if(getdvarint("dvar_F8332F8A8CEDCA1C", 0))
    _id_7C110E744404EE81::main();

  scripts\engine\utility::flag_init("stealth_settings_activated");

  if(!isDefined(level._id_7651ACE291F2CE35))
    level._id_7651ACE291F2CE35 = [];

  level._id_7651ACE291F2CE35["combat"] = gettime();
  level._id_7651ACE291F2CE35["cover_blown"] = gettime();
  level._id_7651ACE291F2CE35["explosion"] = gettime();
  level._id_01A6C1600565C49A = ::_id_01A6C1600565C49A;
  level._id_FCFF6DF987BE068C = ::_id_FCFF6DF987BE068C;
  level._id_28C0D60E971FF699 = ::_id_DE5486DC9107107C;
  level._id_5F907987B2562F10 = ::isinexecutionvictim;
  setDvar("dvar_52188CD691F99B29", 1);
  setDvar("dvar_1E36075E6B8CED83", 0);
  thread players_weapon_fired_monitor();
  _id_AB229ED68FC7FD63();
  level thread _id_B5EB90C4BF658113();
  register_stealth_state_funcs();
  randomize_stealth_alert_music_array();
  randomize_stealth_broken_music_array();
  level.ai_raising_alarm = [];
  level.stealth_soundaliases = ["ui_stealth_threat_low_lp", "ui_stealth_threat_med_lp", "ui_stealth_threat_high_lp"];
}

_id_01A6C1600565C49A(event) {
  if(!isDefined(level._id_7651ACE291F2CE35[event.type]))
    level._id_7651ACE291F2CE35[event.type] = gettime();

  if(_id_85DD561037B4B981(gettime(), event)) {
    if(isDefined(event.type)) {
      if(event.type == "combat") {
        if(isDefined(level._id_6C5A3DD9183FA65E))
          level thread[[level._id_6C5A3DD9183FA65E]](event);
      } else if(issubstr(event.type, "hunt"))
        iprintlnbold("^1 HUNT ");

      level._id_7651ACE291F2CE35[event.type] = gettime() + 5000;
    } else {
      iprintlnbold(event.type);
      level._id_7651ACE291F2CE35[event.type] = gettime() + 3000;
    }
  }
}

_id_85DD561037B4B981(_id_AB0B17E756D19D0C, event) {
  if(isDefined(level._id_7651ACE291F2CE35[event.type]) && _id_AB0B17E756D19D0C <= level._id_7651ACE291F2CE35[event.type])
    return 0;
  else
    return 1;
}

reset_global_stealth_settings() {
  level.ai_raising_alarm = [];
  level.global_stealth_broken = 0;
}

register_stealth_state_funcs() {
  level.enter_stealth_state_func = [];
  level.exit_stealth_state_func = [];
  register_stealth_state_func("idle", ::enter_casual, ::exit_casual);
  register_stealth_state_func("casual", ::enter_casual, ::exit_casual);
  register_stealth_state_func("alert", ::enter_alert, ::exit_alert);
  register_stealth_state_func("combat", ::enter_combat, ::exit_combat);
}

register_stealth_state_func(_id_53709E15B972FF84, _id_2F3A6C49BA7B137C, _id_5298FDCAABE4F9DC) {
  level.enter_stealth_state_func[_id_53709E15B972FF84] = _id_2F3A6C49BA7B137C;
  level.exit_stealth_state_func[_id_53709E15B972FF84] = _id_5298FDCAABE4F9DC;
}

ai_sight_monitor(player) {
  self.sightlastactivetime = 0;
  self.sightstate = 0;
  updateaisightonplayer(self.sightstate);
}

getaisightdirection(enemy) {
  forward = anglesToForward(self getplayerangles());
  _id_9D9E76097A59CB60 = (forward[0], forward[1], forward[2]);
  _id_9D9E76097A59CB60 = vectorNormalize(_id_9D9E76097A59CB60);
  _id_9001DA663C7CDFEC = enemy.origin - self.origin;
  _id_4720FAE3929BBDBA = (_id_9001DA663C7CDFEC[0], _id_9001DA663C7CDFEC[1], _id_9001DA663C7CDFEC[2]);
  _id_4720FAE3929BBDBA = vectorNormalize(_id_4720FAE3929BBDBA);
  dot = vectordot(_id_9D9E76097A59CB60, _id_4720FAE3929BBDBA);

  if(dot >= 0.92388)
    return 2;
  else if(dot >= 0.382683)
    return scripts\engine\utility::ter_op(isleft2d(self.origin, _id_9D9E76097A59CB60, enemy.origin), 4, 1);
  else if(dot >= -0.382683)
    return scripts\engine\utility::ter_op(isleft2d(self.origin, _id_9D9E76097A59CB60, enemy.origin), 128, 64);
  else if(dot >= -0.92388)
    return scripts\engine\utility::ter_op(isleft2d(self.origin, _id_9D9E76097A59CB60, enemy.origin), 32, 8);
  else
    return 16;
}

isleft2d(startpos, _id_49E63390E090A2A8, _id_990BC5D950404EE5) {
  _id_7799A293BF13FE15 = (startpos[0], startpos[1], 0);
  _id_4C711FE4D7900B43 = (_id_990BC5D950404EE5[0], _id_990BC5D950404EE5[1], 0);
  _id_79868B365E4D18F8 = _id_4C711FE4D7900B43 - _id_7799A293BF13FE15;
  _id_9D9E76097A59CB60 = (_id_49E63390E090A2A8[0], _id_49E63390E090A2A8[1], 0);
  return _id_79868B365E4D18F8[0] * _id_9D9E76097A59CB60[1] - _id_79868B365E4D18F8[1] * _id_9D9E76097A59CB60[0] < 0;
}

regular_enemy_death_func() {
  _id_CD977BE97BC0FC1E = self;

  if(isDefined(level.ai_going_to_alarm) && level.ai_going_to_alarm == self)
    level.ai_going_to_alarm = undefined;

  if(isDefined(level.ai_raising_alarm) && scripts\engine\utility::array_contains(level.ai_raising_alarm, self))
    scripts\engine\utility::array_remove(level.ai_raising_alarm, self);

  _id_CD977BE97BC0FC1E leave_corpse_for_others_to_see();
  _id_CD977BE97BC0FC1E delete_stealth_meter(_id_CD977BE97BC0FC1E);
  _id_CD977BE97BC0FC1E delete_combat_icon(_id_CD977BE97BC0FC1E);
}

leave_corpse_for_others_to_see() {
  if(!isDefined(level.enemy_ai_corpse_locations))
    level.enemy_ai_corpse_locations = [];

  if(!istrue(self.died_poorly)) {
    _id_1D9B3A3FA1867EBA = spawnStruct();
    _id_1D9B3A3FA1867EBA.loc = self.origin + (0, 0, 120);
    _id_1D9B3A3FA1867EBA.time_stamp = gettime();
    _id_1D9B3A3FA1867EBA.index = self getentitynumber() + randomint(100);
    level.enemy_ai_corpse_locations = scripts\engine\utility::array_add(level.enemy_ai_corpse_locations, _id_1D9B3A3FA1867EBA);
  }
}

level_should_run_sp_stealth() {
  if(scripts\cp\utility::coop_mode_has("sp_stealth"))
    return 1;

  return getdvarint("dvar_9EB1E24F643E2711", 0);
}

_id_8FFEFFB485C990C2(_id_CD977BE97BC0FC1E) {
  level endon("game_ended");
  level endon("weapons_free");
  _id_CD977BE97BC0FC1E endon("death");
  _id_CD977BE97BC0FC1E endon("enter_combat");
  _id_CD977BE97BC0FC1E endon("exit_stealth_think");
  _id_CD977BE97BC0FC1E notify("stealth_meter_sp_stealth_display_think");
  _id_CD977BE97BC0FC1E endon("stealth_meter_sp_stealth_display_think");

  for(;;) {
    _id_CD977BE97BC0FC1E waittill("display_stealth_meter_to", player);
    player thread ping_enemy_and_player_for_duration(_id_CD977BE97BC0FC1E, player, 1);
  }
}

ping_enemy_and_player_for_duration(_id_CD977BE97BC0FC1E, player, duration) {
  player notify("ping_enemy_and_player_for_duration");
  player endon("disconnect");
  player endon("ping_enemy_and_player_for_duration");

  if(!isDefined(duration))
    duration = 3;

  player.sightstate = player getaisightdirection(_id_CD977BE97BC0FC1E);
  player updateaisightonplayer(player.sightstate);
  wait(duration);
  player updateaisightonplayer(0);
}

updateaisightonplayer(_id_75ABBF0830C5D3FA) {
  self setclientomnvar("ui_edge_glow", _id_75ABBF0830C5D3FA);
}

threat_sight_monitor() {
  self endon("death");
  self endon("disconnect");
}

mark_seen_this_player_this_frame(_id_CD977BE97BC0FC1E, player) {
  _id_CD977BE97BC0FC1E.player_most_recently_saw = player;
  _id_6698924DFF3AA2FC = player getentitynumber();

  if(!isDefined(_id_CD977BE97BC0FC1E.time_seeing_players))
    _id_CD977BE97BC0FC1E thread seeing_player_time_tracker(_id_CD977BE97BC0FC1E);

  if(!isDefined(_id_CD977BE97BC0FC1E.time_seeing_players[_id_6698924DFF3AA2FC]))
    _id_CD977BE97BC0FC1E.time_seeing_players[_id_6698924DFF3AA2FC] = 0;
}

seeing_player_time_tracker(_id_CD977BE97BC0FC1E) {
  level endon("game_ended");
  level endon("weapons_free");
  _id_CD977BE97BC0FC1E notify("seeing_player_time_tracker");
  _id_CD977BE97BC0FC1E endon("seeing_player_time_tracker");
  _id_CD977BE97BC0FC1E endon("death");
  _id_CD977BE97BC0FC1E endon("long_death");
  _id_CD977BE97BC0FC1E endon("enter_combat");
  _id_CD977BE97BC0FC1E.player_most_recently_saw = undefined;
  _id_CD977BE97BC0FC1E.time_seeing_players = [];
  _id_7670D6A914797E69 = 0;

  if(getdvarint("dvar_91536E3E17DDDC14", 0) != 0) {
    return;
  }
  for(;;) {
    if(isDefined(_id_CD977BE97BC0FC1E.player_most_recently_saw))
      _id_7670D6A914797E69 = 0;
    else
      _id_7670D6A914797E69 = _id_7670D6A914797E69 + 0.1;

    foreach(_id_6698924DFF3AA2FC, time in _id_CD977BE97BC0FC1E.time_seeing_players) {
      if(isDefined(_id_CD977BE97BC0FC1E.player_most_recently_saw) && _id_6698924DFF3AA2FC == _id_CD977BE97BC0FC1E.player_most_recently_saw getentitynumber()) {
        _id_CD977BE97BC0FC1E.time_seeing_players[_id_6698924DFF3AA2FC] = _id_CD977BE97BC0FC1E.time_seeing_players[_id_6698924DFF3AA2FC] + 0.1;
        _id_CD977BE97BC0FC1E.player_most_recently_saw = undefined;
        continue;
      }

      _id_CD977BE97BC0FC1E.time_seeing_players[_id_6698924DFF3AA2FC] = max(_id_CD977BE97BC0FC1E.time_seeing_players[_id_6698924DFF3AA2FC] - 0.05, 0);
    }

    foreach(player in level.players) {
      _id_6698924DFF3AA2FC = player getentitynumber();

      if(isDefined(_id_CD977BE97BC0FC1E.time_seeing_players[_id_6698924DFF3AA2FC]) && _id_CD977BE97BC0FC1E.time_seeing_players[_id_6698924DFF3AA2FC] == 0)
        hide_stealth_meter_from(player, _id_CD977BE97BC0FC1E);
    }

    if(_id_7670D6A914797E69 >= 0.5)
      stop_stealth_meter(_id_CD977BE97BC0FC1E);

    wait 0.1;
  }
}

stop_stealth_meter(_id_CD977BE97BC0FC1E) {
  _id_CD977BE97BC0FC1E.target_stealth_meter_progress = _id_CD977BE97BC0FC1E.current_stealth_meter_progress;
  _id_CD977BE97BC0FC1E notify("stop_stealth_meter");
}

should_run_sp_stealth() {
  return level_should_run_sp_stealth() && (self.unittype == "soldier" || self.unittype == "juggernaut" || self.unittype == "dog");
}

run_common_functions(_id_CD977BE97BC0FC1E, _id_5001D8D3A6A01D08, _id_B723FE98DD0F39F4, fov, _id_D5AE73A7CC51F85A, _id_F31BA637CEC4081E, _id_5438269DEEB18825) {
  if(!scripts\engine\utility::flag("stealth_settings_activated")) {
    setdvarifuninitialized("dvar_9EB1E24F643E2711", 0);
    activate_stealth_settings();
  }

  if(isDefined(level._id_2A7A0DD9628AB102))
    _id_CD977BE97BC0FC1E[[level._id_2A7A0DD9628AB102]]();

  _id_34C6D56FA2022688 = 0;

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    _id_CD977BE97BC0FC1E laseron();

  if(isDefined(level._id_B20A836DA84340B0) && isfunction(level._id_B20A836DA84340B0)) {
    if(isDefined(_id_CD977BE97BC0FC1E.group) && isDefined(_id_CD977BE97BC0FC1E.group.group_name))
      _id_CD977BE97BC0FC1E.script_stealthgroup = _id_CD977BE97BC0FC1E.group.group_name;
    else
      _id_CD977BE97BC0FC1E.script_stealthgroup = "group";

    if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint)) {
      if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint.script_stealthgroup))
        _id_CD977BE97BC0FC1E.script_stealthgroup = _id_CD977BE97BC0FC1E.spawnpoint.script_stealthgroup;

      if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint.script_sightrange))
        _id_CD977BE97BC0FC1E.stealth.override_damage_auto_range = int(_id_CD977BE97BC0FC1E.script_sightrange);
    }

    if([[level._id_B20A836DA84340B0]](_id_CD977BE97BC0FC1E, _id_CD977BE97BC0FC1E.script_stealthgroup)) {
      _id_CD977BE97BC0FC1E scripts\asm\soldier\patrol::_id_3ABA5F22B60D37F5();

      if(_id_CD977BE97BC0FC1E should_run_sp_stealth()) {
        if(isDefined(_id_CD977BE97BC0FC1E.group) && isDefined(_id_CD977BE97BC0FC1E.group.group_name))
          _id_CD977BE97BC0FC1E.script_stealthgroup = _id_CD977BE97BC0FC1E.group.group_name;
        else
          _id_CD977BE97BC0FC1E.script_stealthgroup = "group";

        if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint)) {
          if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint.script_stealthgroup))
            _id_CD977BE97BC0FC1E.script_stealthgroup = _id_CD977BE97BC0FC1E.spawnpoint.script_stealthgroup;

          if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint.script_sightrange))
            _id_CD977BE97BC0FC1E.stealth.override_damage_auto_range = int(_id_CD977BE97BC0FC1E.script_sightrange);
        }

        _id_CD977BE97BC0FC1E thread scripts\stealth\enemy::main();
        _id_CD977BE97BC0FC1E thread _id_07CAEBC5D4875185::monitor_death_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
        _id_CD977BE97BC0FC1E thread seeing_player_time_tracker(_id_CD977BE97BC0FC1E);
        _id_CD977BE97BC0FC1E thread watch_for_level_weapons_free();
        _id_CD977BE97BC0FC1E.fnstealthgotonode = ::go_to_node_callback;
      }

      return;
    } else {
      _id_CD977BE97BC0FC1E scripts\asm\soldier\patrol::_id_3ABA5F22B60D37F5();

      if(_id_CD977BE97BC0FC1E should_run_sp_stealth()) {
        if(isDefined(_id_CD977BE97BC0FC1E.group) && isDefined(_id_CD977BE97BC0FC1E.group.group_name))
          _id_CD977BE97BC0FC1E.script_stealthgroup = _id_CD977BE97BC0FC1E.group.group_name;
        else
          _id_CD977BE97BC0FC1E.script_stealthgroup = "group";

        if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint)) {
          if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint.script_stealthgroup))
            _id_CD977BE97BC0FC1E.script_stealthgroup = _id_CD977BE97BC0FC1E.spawnpoint.script_stealthgroup;

          if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint.script_sightrange))
            _id_CD977BE97BC0FC1E.stealth.override_damage_auto_range = int(_id_CD977BE97BC0FC1E.script_sightrange);
        }

        _id_CD977BE97BC0FC1E thread scripts\stealth\enemy::main();
        _id_CD977BE97BC0FC1E thread _id_07CAEBC5D4875185::monitor_death_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
        _id_CD977BE97BC0FC1E thread seeing_player_time_tracker(_id_CD977BE97BC0FC1E);
        _id_CD977BE97BC0FC1E thread watch_for_level_weapons_free();

        if(_id_CD977BE97BC0FC1E.agent_type != "dog_agent")
          _id_CD977BE97BC0FC1E.fnstealthgotonode = ::go_to_node_callback;
      }
    }
  } else if(_id_94FFB636A243CF0E(4)) {
    _id_CD977BE97BC0FC1E scripts\asm\soldier\patrol::_id_3ABA5F22B60D37F5();

    if(_id_CD977BE97BC0FC1E should_run_sp_stealth()) {
      if(isDefined(_id_CD977BE97BC0FC1E.group) && isDefined(_id_CD977BE97BC0FC1E.group.group_name))
        _id_CD977BE97BC0FC1E.script_stealthgroup = _id_CD977BE97BC0FC1E.group.group_name;
      else
        _id_CD977BE97BC0FC1E.script_stealthgroup = "group";

      if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint)) {
        if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint.script_stealthgroup))
          _id_CD977BE97BC0FC1E.script_stealthgroup = _id_CD977BE97BC0FC1E.spawnpoint.script_stealthgroup;

        if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint.script_sightrange))
          _id_CD977BE97BC0FC1E.stealth.override_damage_auto_range = int(_id_CD977BE97BC0FC1E.script_sightrange);
      }

      _id_CD977BE97BC0FC1E thread scripts\stealth\enemy::main();
      _id_CD977BE97BC0FC1E thread _id_07CAEBC5D4875185::monitor_death_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
      _id_CD977BE97BC0FC1E thread seeing_player_time_tracker(_id_CD977BE97BC0FC1E);
      _id_CD977BE97BC0FC1E thread watch_for_level_weapons_free();
      _id_CD977BE97BC0FC1E.fnstealthgotonode = ::go_to_node_callback;
    } else {}

    return;
  }

  if(istrue(level.global_stealth_broken) || istrue(level._id_1CBECB12F3EC3970) && istrue(_id_34C6D56FA2022688)) {
    _id_CD977BE97BC0FC1E scripts\asm\soldier\patrol::_id_3ABA5F22B60D37F5();

    if(_id_CD977BE97BC0FC1E should_run_sp_stealth()) {
      if(isDefined(_id_CD977BE97BC0FC1E.group) && isDefined(_id_CD977BE97BC0FC1E.group.group_name))
        _id_CD977BE97BC0FC1E.script_stealthgroup = _id_CD977BE97BC0FC1E.group.group_name;
      else
        _id_CD977BE97BC0FC1E.script_stealthgroup = "group";

      if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint)) {
        if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint.script_stealthgroup))
          _id_CD977BE97BC0FC1E.script_stealthgroup = _id_CD977BE97BC0FC1E.spawnpoint.script_stealthgroup;

        if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint.script_sightrange))
          _id_CD977BE97BC0FC1E.stealth.override_damage_auto_range = int(_id_CD977BE97BC0FC1E.script_sightrange);
      }

      _id_CD977BE97BC0FC1E thread scripts\stealth\enemy::main();
      _id_CD977BE97BC0FC1E thread _id_07CAEBC5D4875185::monitor_death_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
      _id_CD977BE97BC0FC1E thread seeing_player_time_tracker(_id_CD977BE97BC0FC1E);
      _id_CD977BE97BC0FC1E thread watch_for_level_weapons_free();
      _id_CD977BE97BC0FC1E scripts\stealth\utility::set_stealth_func("event_combat", ::enter_combat_callback);
      _id_CD977BE97BC0FC1E.fnstealthgotonode = ::go_to_node_callback;
    } else {}

    return;
  }

  if(_id_CD977BE97BC0FC1E should_run_sp_stealth()) {
    _id_CD977BE97BC0FC1E scripts\asm\soldier\patrol::_id_3ABA5F22B60D37F5();

    if(isDefined(_id_CD977BE97BC0FC1E.group) && isDefined(_id_CD977BE97BC0FC1E.group.group_name))
      _id_CD977BE97BC0FC1E.script_stealthgroup = _id_CD977BE97BC0FC1E.group.group_name;
    else
      _id_CD977BE97BC0FC1E.script_stealthgroup = "group";

    if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint)) {
      if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint.script_stealthgroup))
        _id_CD977BE97BC0FC1E.script_stealthgroup = _id_CD977BE97BC0FC1E.spawnpoint.script_stealthgroup;

      if(isDefined(_id_CD977BE97BC0FC1E.spawnpoint.script_sightrange))
        _id_CD977BE97BC0FC1E.stealth.override_damage_auto_range = int(_id_CD977BE97BC0FC1E.script_sightrange);
    }

    _id_CD977BE97BC0FC1E thread scripts\stealth\enemy::main();
    _id_CD977BE97BC0FC1E thread _id_07CAEBC5D4875185::monitor_death_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
    _id_CD977BE97BC0FC1E thread seeing_player_time_tracker(_id_CD977BE97BC0FC1E);
    _id_CD977BE97BC0FC1E thread watch_for_level_weapons_free();
    _id_CD977BE97BC0FC1E scripts\stealth\utility::set_stealth_func("event_combat", ::enter_combat_callback);

    if(_id_CD977BE97BC0FC1E.agent_type != "dog_agent")
      _id_CD977BE97BC0FC1E.fnstealthgotonode = ::go_to_node_callback;
  }
}

get_players_not_in_laststand() {
  result = [];

  foreach(player in level.players) {
    if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
      continue;
    }
    result[result.size] = player;
  }

  return result;
}

_id_BE21052E355EAC6A(_id_0C3EA9B1A20FF199) {
  if(!isDefined(_id_0C3EA9B1A20FF199)) {
    return;
  }
  event = spawnStruct();
  event.type = "combat_hunt";
  event.typeorig = "sight";
  event.origin = _id_0C3EA9B1A20FF199 + anglesToForward((0, randomfloatrange(0, 360), 0)) * 75;
  event.investigate_pos = getclosestpointonnavmesh(event.origin, self);

  if(!isDefined(self.fnsetstealthstate)) {
    self setgoalpos(event.investigate_pos);
    return;
  }

  scripts\stealth\enemy::bt_set_stealth_state("hunt", event);
}

_id_7E00903590974138(_id_AFF9420E4547CEEA) {
  if(isDefined(self.fnisinstealthhunt) && self[[self.fnisinstealthhunt]]()) {
    return;
  }
  event = spawnStruct();
  event.entity = scripts\engine\utility::random(get_players_not_in_laststand());

  if(!isDefined(event.entity)) {
    scripts\stealth\enemy::bt_set_stealth_state("hunt", undefined);
    return;
  }

  event.investigate_pos = event.entity.origin;
  _id_0C3EA9B1A20FF199 = event.investigate_pos;

  if(!isDefined(_id_0C3EA9B1A20FF199)) {
    return;
  }
  event = spawnStruct();
  event.type = "combat_hunt";
  event.typeorig = scripts\engine\utility::ter_op(isDefined(_id_AFF9420E4547CEEA), _id_AFF9420E4547CEEA, "sight");
  event.origin = _id_0C3EA9B1A20FF199 + anglesToForward((0, randomfloatrange(0, 360), 0)) * 75;
  event.investigate_pos = getclosestpointonnavmesh(event.origin);

  if(!isDefined(self.fnsetstealthstate)) {
    self setgoalpos(event.investigate_pos);
    return;
  }

  scripts\stealth\enemy::bt_set_stealth_state("hunt", event);
}

enter_combat_callback(event) {
  if(self isinexecutionvictim())
    return 0;

  thread _id_85DE6FD095875E9D();
  return 0;
}

_id_85DE6FD095875E9D() {
  self endon("death");
  wait 2.5;

  if(isDefined(self.vehicle))
    self.vehicle thread _id_FFE8657189764909(self);

  level notify("stealth_combat_validated", self.script_stealthgroup);
}

_id_81F873EAE0CBAC09() {
  target = self getturrettarget(0);

  if(isDefined(target) && isPlayer(target) && !target isparachuting()) {
    origin = target.origin;
    _id_DA96C8943126A950 = getaiarrayinradius(origin, 2048);

    foreach(ai in _id_DA96C8943126A950) {
      if(!isDefined(origin)) {
        continue;
      }
      event = spawnStruct();
      event.origin = origin + anglesToForward((0, randomfloatrange(0, 360), 0)) * 75;
      event.investigate_pos = getclosestpointonnavmesh(event.origin, ai);
      ai aieventlistenerevent("investigate", target, event.origin);
    }
  }
}

_id_FFE8657189764909(rider) {
  self vehicle_setspeedimmediate(0, 300, 300);
  self stoppath(1);
  self notify("unload_guys");

  foreach(ai in self.riders)
  ai notify("unloaded_from_techo");

  scripts\common\vehicle::vehicle_unload();
}

go_to_node_callback(nodes, _id_29455CBEA8B9AD83, _id_B7E2619A5C2C393D) {
  if(isDefined(self.currentnode))
    thread _id_18A73A64992DD07D::go_to_node(self.currentnode);
  else
    _id_18A73A64992DD07D::return_to_last_goalRadius();
}

suspicious_door_monitor() {
  self notify("suspicious_door_monitor_end");
  self endon("death");
  self endon("disconnect");
  self endon("suspicious_door_monitor_end");
  _id_EBAB8C83F9C41C5F = 512;
  _id_DA76FC64F53D4B8C = 512;

  for(;;) {
    level waittill("door_event", origin, _id_EEE718E33217DC9E);

    if(isDefined(_id_EEE718E33217DC9E) && isPlayer(_id_EEE718E33217DC9E))
      _func_DAF6C5596BB31DFF("window_open", _id_EEE718E33217DC9E, _id_EEE718E33217DC9E.origin, _id_EBAB8C83F9C41C5F, _id_EEE718E33217DC9E.origin, 1, _id_DA76FC64F53D4B8C);
  }
}

change_stealth_state_to(_id_CD977BE97BC0FC1E, _id_6879F8F1B126E993) {
  level endon("weapons_free");
  _id_CD977BE97BC0FC1E notify("change_stealth_state_to", _id_6879F8F1B126E993);
  _id_CD977BE97BC0FC1E endon("change_stealth_state_to");
  _id_CD977BE97BC0FC1E endon("death");
  _id_CD977BE97BC0FC1E endon("enter_combat");
  exit_current_stealth_state(_id_CD977BE97BC0FC1E);
  set_current_stealth_state(_id_CD977BE97BC0FC1E, _id_6879F8F1B126E993);
  enter_current_stealth_state(_id_CD977BE97BC0FC1E);
}

exit_current_stealth_state(_id_CD977BE97BC0FC1E) {
  _id_CD977BE97BC0FC1E[[level.exit_stealth_state_func[get_current_stealth_state(_id_CD977BE97BC0FC1E)]]](_id_CD977BE97BC0FC1E);
}

enter_current_stealth_state(_id_CD977BE97BC0FC1E) {
  _id_CD977BE97BC0FC1E[[level.enter_stealth_state_func[get_current_stealth_state(_id_CD977BE97BC0FC1E)]]](_id_CD977BE97BC0FC1E);
}

set_current_stealth_state(_id_CD977BE97BC0FC1E, current_stealth_state) {
  _id_CD977BE97BC0FC1E.current_stealth_state = current_stealth_state;
}

get_current_stealth_state(_id_CD977BE97BC0FC1E) {
  return _id_CD977BE97BC0FC1E.current_stealth_state;
}

is_ai_in_stealth(_id_CD977BE97BC0FC1E) {
  return isDefined(get_current_stealth_state(_id_CD977BE97BC0FC1E));
}

enter_casual(_id_CD977BE97BC0FC1E) {
  _id_CD977BE97BC0FC1E _id_18A73A64992DD07D::set_demeanor_from_unittype("patrol");
  _id_CD977BE97BC0FC1E scripts\engine\utility::set_movement_speed(25);
}

exit_casual(_id_CD977BE97BC0FC1E) {}

enter_alert(_id_CD977BE97BC0FC1E) {}

stopsoundoncompletion(alias) {
  wait(lookupsoundlength(alias));
  self.bplayingspecificstealthsound = undefined;
}

exit_alert(_id_CD977BE97BC0FC1E) {
  delete_stealth_meter(_id_CD977BE97BC0FC1E);
}

enter_combat(_id_CD977BE97BC0FC1E) {
  _id_CD977BE97BC0FC1E endon("death");
  _id_CD977BE97BC0FC1E endon("enter_combat");

  if(scripts\cp\utility::coop_mode_has("sp_stealth")) {
    level.global_stealth_broken = 1;
    level thread play_combat_music_to_players();
  }
}

ai_is_juggernaut(_id_CD977BE97BC0FC1E) {
  return _id_CD977BE97BC0FC1E.agent_type == "actor_enemy_cp_rus_juggernaut" || _id_CD977BE97BC0FC1E.agent_type == "actor_enemy_cp_jugg_aq" || _id_CD977BE97BC0FC1E.agent_type == "actor_enemy_cp_jugg_cartel";
}

exit_combat(_id_CD977BE97BC0FC1E) {}

stop_patrol(_id_65773575AFB98ED4) {
  _id_CD977BE97BC0FC1E = self;
  _id_CD977BE97BC0FC1E notify("stop_going_to_node");
  _id_CD977BE97BC0FC1E notify("patrol_using_cover_nodes");

  if(istrue(_id_65773575AFB98ED4))
    _id_CD977BE97BC0FC1E _id_18A73A64992DD07D::set_goal_pos(_id_CD977BE97BC0FC1E.origin);
}

watch_for_level_weapons_free() {
  level endon("game_ended");
  self notify("watch_for_level_weapons_free");
  self endon("watch_for_level_weapons_free");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");

  if(getdvarint("dvar_05F4B6ED389FC998", 0) != 0) {
    return;
  }
  level waittill("weapons_free");
  _id_18A73A64992DD07D::remove_pacifist_from_guy();
  self aieventlistenerevent("combat", self, self.origin);
}

player_in_concealment_area(_id_FA8D840338038893) {
  return istrue(_id_FA8D840338038893.inside_bush);
}

make_headicon_on_ai(_id_CD977BE97BC0FC1E, _id_5B78E77C334FA943) {
  if(getdvarint("dvar_52188CD691F99B29", 0) != 0) {
    return;
  }
  if(has_headicon(_id_CD977BE97BC0FC1E)) {
    return;
  }
  _id_D4478D6ECC123A9A = get_reinforcement_icon_image(_id_CD977BE97BC0FC1E);
  _id_8A0B23D4A234EFBC = createheadicon(_id_CD977BE97BC0FC1E);
  setheadiconimage(_id_8A0B23D4A234EFBC, _id_D4478D6ECC123A9A);
  setheadiconzoffset(_id_8A0B23D4A234EFBC, 10);
  setheadiconsnaptoedges(_id_8A0B23D4A234EFBC, 0);
  setheadicondrawthroughgeo(_id_8A0B23D4A234EFBC, 1);
  setheadiconmaxdistance(_id_8A0B23D4A234EFBC, 5000);
  setheadiconnaturaldistance(_id_8A0B23D4A234EFBC, 500);
  reinforcement_icon_objective_id = scripts\cp\cp_objectives::requestworldid("enemy_AI_combat_ID_" + _id_CD977BE97BC0FC1E getentitynumber(), 22);
  objective_state(reinforcement_icon_objective_id, "active");
  objective_icon(reinforcement_icon_objective_id, _id_D4478D6ECC123A9A);
  objective_setbackground(reinforcement_icon_objective_id, 1);
  objective_removeallfrommask(reinforcement_icon_objective_id);
  objective_setplayoutro(reinforcement_icon_objective_id, 0);
  objective_setshowdistance(reinforcement_icon_objective_id, 0);
  objective_setshowprogress(reinforcement_icon_objective_id, 0);
  objective_setfadedisabled(reinforcement_icon_objective_id, 1);
  objective_sethot(reinforcement_icon_objective_id, 1);
  objective_setpulsate(reinforcement_icon_objective_id, 1);
  objective_setshowoncompass(reinforcement_icon_objective_id, 1);
  objective_onentity(reinforcement_icon_objective_id, _id_CD977BE97BC0FC1E);
  _id_CD977BE97BC0FC1E thread[[_id_5B78E77C334FA943]](reinforcement_icon_objective_id, _id_8A0B23D4A234EFBC, _id_CD977BE97BC0FC1E);
  _id_CD977BE97BC0FC1E.reinforcement_icon_objective_id = reinforcement_icon_objective_id;
}

get_reinforcement_icon_image(_id_CD977BE97BC0FC1E) {
  switch (_id_CD977BE97BC0FC1E.reinforcement_type) {
    case "alert":
      return "hud_alert";
    case "alarm":
      return "hud_icon_head_tacops_alarm";
    case "cellphone":
      return "hud_icon_head_tacops_cellphone";
    case "head_marked":
      return "hud_icon_esc_bounty_target";
  }
}

make_combat_icon_on_ai(_id_CD977BE97BC0FC1E) {
  if(getdvarint("dvar_52188CD691F99B29", 0) != 0) {
    return;
  }
  if(has_combat_icon(_id_CD977BE97BC0FC1E)) {
    return;
  }
  combat_icon_objective_id = scripts\cp\cp_objectives::requestworldid("enemy_AI_combat_ID_" + _id_CD977BE97BC0FC1E getentitynumber(), 22);
  objective_state(combat_icon_objective_id, "active");
  objective_icon(combat_icon_objective_id, "hud_icon_stealth");
  objective_onentity(combat_icon_objective_id, _id_CD977BE97BC0FC1E);
  objective_setzoffset(combat_icon_objective_id, 90);
  objective_removeallfrommask(combat_icon_objective_id);
  objective_setplayintro(combat_icon_objective_id, 0);
  objective_setplayoutro(combat_icon_objective_id, 0);
  objective_setbackground(combat_icon_objective_id, 1);
  objective_setshowdistance(combat_icon_objective_id, 0);
  objective_setshowprogress(combat_icon_objective_id, 1);
  objective_setfadedisabled(combat_icon_objective_id, 1);
  objective_sethot(combat_icon_objective_id, 1);
  objective_setpulsate(combat_icon_objective_id, 1);
  objective_setshowoncompass(combat_icon_objective_id, 1);
  _id_CD977BE97BC0FC1E.combat_icon_objective_id = combat_icon_objective_id;
}

make_stealth_meter_on_ai(_id_CD977BE97BC0FC1E) {
  if(getdvarint("dvar_52188CD691F99B29", 0) != 0) {
    return;
  }
  if(has_stealth_meter(_id_CD977BE97BC0FC1E)) {
    return;
  }
  stealth_meter_objective_id = scripts\cp\cp_objectives::requestworldid("enemy_AI_stealth_ID_" + _id_CD977BE97BC0FC1E getentitynumber(), 21);
  objective_state(stealth_meter_objective_id, "active");
  objective_icon(stealth_meter_objective_id, "hud_icon_stealth");
  objective_onentity(stealth_meter_objective_id, _id_CD977BE97BC0FC1E);
  objective_setzoffset(stealth_meter_objective_id, 90);
  objective_removeallfrommask(stealth_meter_objective_id);
  objective_setplayintro(stealth_meter_objective_id, 0);
  objective_setplayoutro(stealth_meter_objective_id, 0);
  objective_setbackground(stealth_meter_objective_id, 1);
  objective_setshowdistance(stealth_meter_objective_id, 0);
  objective_setshowprogress(stealth_meter_objective_id, 1);
  objective_setprogress(stealth_meter_objective_id, 0);
  objective_setfadedisabled(stealth_meter_objective_id, 1);
  objective_sethot(stealth_meter_objective_id, 1);
  objective_setpulsate(stealth_meter_objective_id, 1);
  objective_setshowoncompass(stealth_meter_objective_id, 1);
  _id_CD977BE97BC0FC1E.showing_the_stealth_meter_to_players = [];
  _id_CD977BE97BC0FC1E.stealth_meter_objective_id = stealth_meter_objective_id;
  _id_CD977BE97BC0FC1E thread clear_up_stealth_meter_when_enter_combat(_id_CD977BE97BC0FC1E);
}

clear_up_stealth_meter_when_enter_combat(_id_CD977BE97BC0FC1E) {
  _id_CD977BE97BC0FC1E endon("death");
  _id_CD977BE97BC0FC1E waittill("enter_combat");
  delete_stealth_meter(_id_CD977BE97BC0FC1E);
}

show_stealth_meter_to(player, _id_CD977BE97BC0FC1E) {
  if(!has_stealth_meter(_id_CD977BE97BC0FC1E))
    make_stealth_meter_on_ai(_id_CD977BE97BC0FC1E);

  if(is_showing_stealth_meter_to(player, _id_CD977BE97BC0FC1E)) {
    return;
  }
  _id_CD977BE97BC0FC1E.showing_the_stealth_meter_to_players[_id_CD977BE97BC0FC1E.showing_the_stealth_meter_to_players.size] = player;
  objective_addclienttomask(_id_CD977BE97BC0FC1E.stealth_meter_objective_id, player);
}

show_combat_icon_to(player, _id_CD977BE97BC0FC1E) {
  if(getdvarint("dvar_52188CD691F99B29", 0) != 0) {
    return;
  }
  if(!has_combat_icon(_id_CD977BE97BC0FC1E))
    make_combat_icon_on_ai(_id_CD977BE97BC0FC1E);

  objective_addclienttomask(_id_CD977BE97BC0FC1E.combat_icon_objective_id, player);
}

show_headicon_to(player, _id_CD977BE97BC0FC1E, _id_5B78E77C334FA943) {
  if(istrue(level.disable_stealth_reinforcement_icon)) {
    return;
  }
  if(getdvarint("dvar_52188CD691F99B29", 0) != 0) {
    return;
  }
  if(!has_headicon(_id_CD977BE97BC0FC1E))
    make_headicon_on_ai(_id_CD977BE97BC0FC1E, _id_5B78E77C334FA943);

  objective_addclienttomask(_id_CD977BE97BC0FC1E.reinforcement_icon_objective_id, player);
}

set_stealth_meter_progress(_id_CD977BE97BC0FC1E, progress) {
  if(get_current_stealth_state(_id_CD977BE97BC0FC1E) == "alert")
    _id_CD977BE97BC0FC1E.target_stealth_meter_progress = progress;
}

hide_stealth_meter_from(player, _id_CD977BE97BC0FC1E) {
  if(!has_stealth_meter(_id_CD977BE97BC0FC1E)) {
    return;
  }
  if(!is_showing_stealth_meter_to(player, _id_CD977BE97BC0FC1E)) {
    return;
  }
  _id_CD977BE97BC0FC1E.showing_the_stealth_meter_to_players = scripts\engine\utility::array_remove(_id_CD977BE97BC0FC1E.showing_the_stealth_meter_to_players, player);
  objective_removeclientfrommask(_id_CD977BE97BC0FC1E.stealth_meter_objective_id, player);

  if(_id_CD977BE97BC0FC1E.showing_the_stealth_meter_to_players.size == 0)
    _id_CD977BE97BC0FC1E.i_am_seeing_this_player = undefined;
}

is_showing_stealth_meter_to(player, _id_CD977BE97BC0FC1E) {
  return scripts\engine\utility::array_contains(_id_CD977BE97BC0FC1E.showing_the_stealth_meter_to_players, player);
}

has_stealth_meter(_id_CD977BE97BC0FC1E) {
  return isDefined(_id_CD977BE97BC0FC1E.stealth_meter_objective_id);
}

has_combat_icon(_id_CD977BE97BC0FC1E) {
  return isDefined(_id_CD977BE97BC0FC1E.combat_icon_objective_id);
}

has_headicon(_id_CD977BE97BC0FC1E) {
  return isDefined(_id_CD977BE97BC0FC1E.reinforcement_icon_objective_id);
}

delete_stealth_meter(_id_CD977BE97BC0FC1E) {
  if(has_stealth_meter(_id_CD977BE97BC0FC1E)) {
    scripts\cp\cp_objectives::freeworldid("enemy_AI_stealth_ID_" + _id_CD977BE97BC0FC1E getentitynumber());
    objective_delete(_id_CD977BE97BC0FC1E.stealth_meter_objective_id);
    _id_CD977BE97BC0FC1E.stealth_meter_objective_id = undefined;
    _id_CD977BE97BC0FC1E notify("exit_stealth_think");
  }
}

delete_combat_icon(_id_CD977BE97BC0FC1E) {
  if(has_combat_icon(_id_CD977BE97BC0FC1E)) {
    scripts\cp\cp_objectives::freeworldid("enemy_AI_combat_ID_" + _id_CD977BE97BC0FC1E getentitynumber());
    objective_delete(_id_CD977BE97BC0FC1E.combat_icon_objective_id);
    _id_CD977BE97BC0FC1E.combat_icon_objective_id = undefined;
    _id_CD977BE97BC0FC1E notify("exit_stealth_think");
  }
}

delete_headicon(reinforcement_icon_objective_id, _id_8A0B23D4A234EFBC, _id_CD977BE97BC0FC1E, _id_EDCDE399CCBC2094) {
  scripts\cp\cp_objectives::freeworldid("enemy_AI_reinforcement_ID_" + _id_EDCDE399CCBC2094);
  objective_delete(reinforcement_icon_objective_id);
  _id_CD977BE97BC0FC1E.reinforcement_icon_objective_id = undefined;
  deleteheadicon(_id_8A0B23D4A234EFBC);
  _id_CD977BE97BC0FC1E notify("exit_stealth_think");
}

did_anyone_see_this(enemy, _id_43F256778AC8F6A8, _id_9836DF1FB7E76589, _id_BE714C91530BA6CA, _id_33D9F922BB21C778, _id_601D79340374BC27) {
  _id_8BAB3203A26744B8 = getaiarray("axis");
  _id_29B1911EEE2BCB5C = _id_9836DF1FB7E76589 * _id_9836DF1FB7E76589;

  if(!isDefined(_id_BE714C91530BA6CA))
    _id_BE714C91530BA6CA = 1;

  if(!isDefined(_id_33D9F922BB21C778))
    _id_33D9F922BB21C778 = _id_43F256778AC8F6A8;

  _id_2068A3EFD793AFBA = 3;
  _id_C9787ABB0668D729 = 0;

  foreach(ai in _id_8BAB3203A26744B8) {
    if(enemy == ai) {
      if(!isDefined(enemy.times_hit))
        enemy.times_hit = 1;
      else
        enemy.times_hit++;

      if(enemy.times_hit > 1)
        return 1;
      else
        continue;
    }

    if(!isalive(ai)) {
      continue;
    }
    distsq = distancesquared(ai.origin, _id_43F256778AC8F6A8);

    if(distsq > _id_29B1911EEE2BCB5C) {
      continue;
    }
    if(isDefined(_id_601D79340374BC27) && distsq <= _id_601D79340374BC27 * _id_601D79340374BC27) {
      continue;
    }
    if(!ai hastacvis(_id_33D9F922BB21C778, _id_BE714C91530BA6CA)) {
      if(_id_BE714C91530BA6CA && !ai aipointinfov(_id_43F256778AC8F6A8)) {
        continue;
      }
      _id_C9787ABB0668D729++;

      if(_id_C9787ABB0668D729 > _id_2068A3EFD793AFBA) {
        waitframe();
        _id_C9787ABB0668D729 = 0;
      }

      if(!sighttracepassed(ai getEye(), _id_43F256778AC8F6A8, 0, enemy))
        continue;
    }

    return 1;
  }

  return 0;
}

increase_script_maxdist(group, param1, param2, param3) {
  spawnpoints = _id_18A73A64992DD07D::process_module_var(group, group.spawn_points);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < spawnpoints.size; _id_AC0E594AC96AA3A8++) {
    struct = spawnpoints[_id_AC0E594AC96AA3A8];
    struct.script_maxdist = 20000;
  }
}

player_in_bush_monitor() {
  level endon("game_ended");

  foreach(player in level.players)
  player thread monitor_bush_trig(player);

  level thread bush_onplayerconnect();
}

bush_onplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    player thread monitor_bush_trig(player);
  }
}

monitor_bush_trig(player) {
  level endon("game_ended");
  player endon("disconnect");
  _id_EACE1F6533829EAD = 100;
  interval = 0.1;

  for(;;) {
    wait(interval);
    player.inside_bush = 0;

    if(player istouching(level.bush_trig)) {
      player.inside_bush = 1;
      continue;
    }

    zone = get_current_bush_zone(player);

    if(!isDefined(zone)) {
      continue;
    }
    foreach(struct in zone[2]) {
      org = struct[0];
      _id_1A96B3062BB2C598 = struct[1];

      if(scripts\engine\utility::distance_2d_squared(org, player.origin) < _id_1A96B3062BB2C598 && abs(org[2] - player.origin[2]) < _id_EACE1F6533829EAD) {
        player.inside_bush = 1;
        continue;
      }
    }
  }
}

get_current_bush_zone(player) {
  foreach(zone in level.bush_zones) {
    if(scripts\engine\utility::distance_2d_squared(player.origin, zone[0]) < zone[1])
      return zone;
  }

  return undefined;
}

is_stealth_sequence_activated() {
  if(!scripts\engine\utility::flag_exist("stealth_settings_activated"))
    return 0;

  return scripts\engine\utility::flag("stealth_settings_activated");
}

activate_stealth_settings() {
  _func_7AFB89FC511BF315("explosion", 2048);
  _func_7AFB89FC511BF315("gunshot", 1024);
  _func_7AFB89FC511BF315("footstep", 128);
  _func_7AFB89FC511BF315("footstep_walk", 64);
  _func_7AFB89FC511BF315("footstep_sprint", 200);
  level thread grenade_exploded_during_stealth_listener();

  if(isDefined(level._id_04056F15D39BCF78))
    [[level._id_04056F15D39BCF78]]();
  else
    _id_A2C5010C4E9D31FE();

  setDvar("dvar_7AF445124B2A7094", 1);
  scripts\engine\utility::flag_set("stealth_settings_activated");
}

players_grenade_fire_monitor() {
  level endon("game_ended");
  level endon("weapons_free");
  level notify("players_grenade_fire_monitor");
  level endon("players_grenade_fire_monitor");

  foreach(player in level.players)
  player thread player_grenade_fire_monitor(player);

  for(;;) {
    level waittill("connected", player);
    player thread delay_start_player_grenade_fire_monitor(player);
  }
}

delay_start_player_grenade_fire_monitor(player) {
  level endon("game_ended");
  level endon("weapons_free");
  player scripts\engine\utility::waittill_any_2("loadout_given", "start_hotjoining_via_c130");
  player thread player_grenade_fire_monitor(player);
}

player_grenade_fire_monitor(player) {
  level endon("game_ended");
  level endon("weapons_free");
  player notify("player_grenade_fire_monitor");
  player endon("player_grenade_fire_monitor");

  for(;;) {
    player waittill("grenade_fire");
    player.last_grenade_fire_time = gettime();
  }
}

get_player_who_most_recently_threw_grenade() {
  result = undefined;
  _id_826CE097D3746CC8 = -1;

  foreach(player in level.players) {
    if(player.sessionstate == "spectator") {
      continue;
    }
    if(isDefined(player.last_grenade_fire_time) && player.last_grenade_fire_time > _id_826CE097D3746CC8) {
      result = player;
      _id_826CE097D3746CC8 = player.last_grenade_fire_time;
    }
  }

  return result;
}

players_weapon_fired_monitor() {
  level endon("game_ended");
  level notify("players_weapon_fired_monitor");
  level endon("players_weapon_fired_monitor");

  while(!isDefined(level.players))
    waitframe();

  foreach(player in level.players)
  player thread player_weapon_fired_monitor(player);

  for(;;) {
    level waittill("connected", player);
    player thread delay_start_player_weapon_fired_monitor(player);
  }
}

delay_start_player_weapon_fired_monitor(player) {
  level endon("game_ended");
  player scripts\engine\utility::waittill_any_2("loadout_given", "start_hotjoining_via_c130");
  player thread player_weapon_fired_monitor(player);
}

player_weapon_fired_monitor(player) {
  level endon("game_ended");
  player notify("player_weapon_fired_monitor");
  player endon("player_weapon_fired_monitor");

  for(;;) {
    player waittill("weapon_fired");
    player.last_weapon_fired_time = gettime();
  }
}

get_player_who_most_likely_broke_stealth(_id_717279ADA7C23D46, _id_6AB916505C4D2E82) {
  result = [[_id_6AB916505C4D2E82]]();

  if(isDefined(result))
    return result;

  return get_closest_valid_player(_id_717279ADA7C23D46);
}

get_closest_valid_player(_id_717279ADA7C23D46) {
  _id_E031661B7146A294 = [];

  foreach(player in level.players) {
    if(player.sessionstate == "spectator") {
      continue;
    }
    _id_E031661B7146A294[_id_E031661B7146A294.size] = player;
  }

  return scripts\engine\utility::getclosest(_id_717279ADA7C23D46, _id_E031661B7146A294);
}

get_player_who_most_recently_fired_weapon() {
  result = undefined;
  _id_826CE097D3746CC8 = -1;

  foreach(player in level.players) {
    if(player.sessionstate == "spectator") {
      continue;
    }
    if(isDefined(player.last_weapon_fired_time) && player.last_weapon_fired_time > _id_826CE097D3746CC8) {
      result = player;
      _id_826CE097D3746CC8 = player.last_weapon_fired_time;
    }
  }

  return result;
}

deactivate_stealth_settings() {
  _func_7AFB89FC511BF315("explosion", 1024);
  _func_7AFB89FC511BF315("gunshot", 1024);
  _func_7AFB89FC511BF315("glass_destroyed", 384);
  _func_7AFB89FC511BF315("footstep", 256);
  _func_7AFB89FC511BF315("footstep_walk", 128);
  _func_7AFB89FC511BF315("footstep_sprint", 400);
  scripts\engine\utility::flag_clear("stealth_settings_activated");
}

randomize_stealth_alert_music_array() {
  _id_60B19C2064E2DCB5 = ["mus_cp_stealth_1", "mus_cp_stealth_2", "mus_cp_stealth_3", "mus_cp_stealth_4", "mus_cp_stealth_5", "mus_cp_stealth_6"];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++)
    _id_60B19C2064E2DCB5 = scripts\engine\utility::array_randomize(_id_60B19C2064E2DCB5);

  level.stealth_alert_music = _id_60B19C2064E2DCB5;
  level.stealth_alert_music_index = 0;
}

get_stealth_alert_music_alias() {
  result = level.stealth_alert_music[level.stealth_alert_music_index];
  level.stealth_alert_music_index++;

  if(level.stealth_alert_music_index == level.stealth_alert_music.size - 1)
    randomize_stealth_alert_music_array();

  return result;
}

randomize_stealth_broken_music_array() {
  _id_60B19C2064E2DCB5 = ["mus_cp_stealth_broken_1", "mus_cp_stealth_broken_2", "mus_cp_stealth_broken_3", "mus_cp_stealth_broken_4", "mus_cp_stealth_broken_5", "mus_cp_stealth_broken_6"];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++)
    _id_60B19C2064E2DCB5 = scripts\engine\utility::array_randomize(_id_60B19C2064E2DCB5);

  level.stealth_broken_music = _id_60B19C2064E2DCB5;
  level.stealth_broken_music_index = 0;
}

get_stealth_broken_music_alias() {
  result = level.stealth_broken_music[level.stealth_broken_music_index];
  level.stealth_broken_music_index++;

  if(level.stealth_broken_music_index == level.stealth_broken_music.size - 1)
    randomize_stealth_broken_music_array();

  return result;
}

play_alert_music_to_player(player) {
  level endon("game_ended");
  player endon("disconnect");
  player notify("play_alert_music_to_player");
  player endon("play_alert_music_to_player");

  if(scripts\cp\utility::coop_mode_has("sp_stealth")) {
    return;
  }
  _id_D0BC1A870DE36153 = 3;

  if(!isDefined(player.playing_stealth_alert_music)) {
    _id_3E67C99E801A5B2E = get_stealth_alert_music_alias();
    player.playing_stealth_alert_music = _id_3E67C99E801A5B2E;
    scripts\cp\utility::play_music_to_team(_id_3E67C99E801A5B2E, player);
  }

  result = level scripts\engine\utility::waittill_any_timeout_1(_id_D0BC1A870DE36153, "weapons_free");
  player.playing_stealth_alert_music = undefined;
  player setplayermusicstate("");
}

play_combat_music_to_players() {
  scripts\cp\utility::play_music_to_team(get_stealth_broken_music_alias(), level.players);
}

change_stealth_state_to_combat_warpper(_id_CD977BE97BC0FC1E, player_name_who_broke_stealth, reason_stealth_broken) {
  _id_CD977BE97BC0FC1E.player_name_who_broke_stealth = player_name_who_broke_stealth;
  _id_CD977BE97BC0FC1E.reason_stealth_broken = reason_stealth_broken;
  _id_CD977BE97BC0FC1E thread change_stealth_state_to(_id_CD977BE97BC0FC1E, "combat");
}

display_who_broke_stealth_message(_id_CD977BE97BC0FC1E) {
  foreach(player in level.players) {
    if(player.name == _id_CD977BE97BC0FC1E.player_name_who_broke_stealth) {
      display_message_to_guilty_player(player, _id_CD977BE97BC0FC1E.reason_stealth_broken);
      continue;
    }

    display_message_to_teammates(player, _id_CD977BE97BC0FC1E.player_name_who_broke_stealth, _id_CD977BE97BC0FC1E.reason_stealth_broken);
  }
}

display_message_to_guilty_player(_id_A34441262B0D5315, reason_stealth_broken) {
  switch (reason_stealth_broken) {
    case "enemies_are_alerted":
      _id_A34441262B0D5315 iprintlnbold("^1You ^7have alerted the enemies");
      break;
    case "player_spotted":
      _id_A34441262B0D5315 iprintlnbold("^1You ^7have been spotted by the enemies");
      break;
  }
}

display_message_to_teammates(_id_84CDD54DFEA85AC7, _id_A69465D9105A5CD5, reason_stealth_broken) {
  switch (reason_stealth_broken) {
    case "enemies_are_alerted":
      _id_84CDD54DFEA85AC7 iprintlnbold("^1" + _id_A69465D9105A5CD5 + "^7 has alerted the enemies");
      break;
    case "player_spotted":
      _id_84CDD54DFEA85AC7 iprintlnbold("^1" + _id_A69465D9105A5CD5 + "^7 has been spotted by the enemies");
      break;
  }
}

_id_AB229ED68FC7FD63() {
  level._id_A3C1A3A8DF3469C0 = 0;
  _id_B75DBBFF9D3CBE0A(1);
}

_id_B75DBBFF9D3CBE0A(state) {
  level._id_A3C1A3A8DF3469C0 = level._id_A3C1A3A8DF3469C0 | state;
}

_id_7DA79658B6525C11(state) {
  level._id_A3C1A3A8DF3469C0 = state;
}

_id_94FFB636A243CF0E(state) {
  return level._id_A3C1A3A8DF3469C0 &state;
}

_id_4DD5AAECF6ACB8D7(state) {
  level._id_A3C1A3A8DF3469C0 = level._id_A3C1A3A8DF3469C0 &~state;
}

_id_B5EB90C4BF658113() {
  level endon("game_ended");

  for(;;) {
    level waittill("stealth_combat", stealth_group);
    level thread _id_4C680574D02BC97C(stealth_group);
  }
}

_id_4C680574D02BC97C(stealth_group) {
  if(isDefined(stealth_group)) {
    level notify("validate_stealth_claim" + stealth_group);
    level endon("validate_stealth_claim" + stealth_group);
  } else {
    level notify("validate_stealth_claim");
    level endon("validate_stealth_claim");
  }

  msg = scripts\engine\utility::waittill_any_timeout_1(2.5, "stealth_combat_validated");

  if(isDefined(level._id_EF796AC0B0326726) && isfunction(level._id_EF796AC0B0326726))
    level thread[[level._id_EF796AC0B0326726]](stealth_group);

  if(!_id_94FFB636A243CF0E(4))
    _id_B75DBBFF9D3CBE0A(4);
  else {}
}

set_maxvisibledist(value) {
  self.maxvisibledist = value;
}

init_event_distances() {
  array["spotted"]["death"] = _func_9D30FD63965BAFA9("death");
  array["hidden"]["death"] = 512;
  array["spotted"]["pain"] = _func_9D30FD63965BAFA9("pain");
  array["hidden"]["pain"] = 256;
  array["spotted"]["explosion"] = _func_9D30FD63965BAFA9("explosion");
  array["hidden"]["explosion"] = 2048;
  array["spotted"]["bullet"] = _func_9D30FD63965BAFA9("bullet");
  array["hidden"]["bullet"] = 64;
  array["spotted"]["footstep_walk"] = _func_9D30FD63965BAFA9("footstep_walk");
  array["hidden"]["footstep_walk"] = 50;
  array["spotted"]["footstep"] = _func_9D30FD63965BAFA9("footstep");
  array["hidden"]["footstep"] = 100;
  array["spotted"]["footstep_sprint"] = _func_9D30FD63965BAFA9("footstep_sprint");
  array["hidden"]["footstep_sprint"] = 400;
  array["spotted"]["gunshot"] = _func_9D30FD63965BAFA9("gunshot");
  array["hidden"]["gunshot"] = 1500;
  array["spotted"]["silenced_shot"] = _func_9D30FD63965BAFA9("silenced_shot");
  array["hidden"]["silenced_shot"] = 180;
  array["spotted"]["glass_destroyed"] = _func_9D30FD63965BAFA9("glass_destroyed");
  array["hidden"]["glass_destroyed"] = 384;
  array["spotted"]["gunshot_teammate"] = _func_9D30FD63965BAFA9("gunshot_teammate");
  array["hidden"]["gunshot_teammate"] = 1500;
  array["spotted"]["new_enemy"] = 128;
  array["hidden"]["new_enemy"] = 128;
  scripts\stealth\manager::set_event_distances(array);
}

_id_FE683C90EAD4E88B() {
  level notify("level_setStealthSettings");
  level endon("level_setStealthSettings");
  _id_7DC093FB71342953["prone"] = 600;
  _id_7DC093FB71342953["crouch"] = 800;
  _id_7DC093FB71342953["stand"] = 1200;
  _id_B6B642CBEFF52B88["prone"] = 150;
  _id_B6B642CBEFF52B88["crouch"] = 350;
  _id_B6B642CBEFF52B88["stand"] = 600;
  _id_7DC093FB71342953["shadow_prone"] = 0.05;
  _id_7DC093FB71342953["shadow_crouch"] = 0.05;
  _id_7DC093FB71342953["shadow_stand"] = 0.3;
  _id_3B0034EB96B13650["prone"] = 1800;
  _id_3B0034EB96B13650["crouch"] = 2400;
  _id_3B0034EB96B13650["stand"] = 4200;
  _id_D0F35FC0A5C3DF79["prone"] = 250;
  _id_D0F35FC0A5C3DF79["crouch"] = 1000;
  _id_D0F35FC0A5C3DF79["stand"] = 1800;
  _id_3B0034EB96B13650["shadow_prone"] = 0.01;
  _id_3B0034EB96B13650["shadow_crouch"] = 0.02;
  _id_3B0034EB96B13650["shadow_stand"] = 0.38;
  _id_8F3F480583606401["prone"] = 1.1;
  _id_8F3F480583606401["crouch"] = 1.15;
  _id_8F3F480583606401["stand"] = 1.2;
  _id_FAC370D058479827["prone"] = 0;
  _id_FAC370D058479827["crouch"] = 0;
  _id_FAC370D058479827["stand"] = 0;
  _id_FB574B7959625BF0["prone"] = 0;
  _id_FB574B7959625BF0["crouch"] = 0;
  _id_FB574B7959625BF0["stand"] = 0;
  scripts\stealth\utility::set_detect_ranges(_id_7DC093FB71342953, _id_3B0034EB96B13650, _id_8F3F480583606401);
  scripts\stealth\utility::set_min_detect_range_darkness(_id_B6B642CBEFF52B88, _id_D0F35FC0A5C3DF79);
  scripts\stealth\utility::_id_0F3883FE06A11269(_id_FAC370D058479827, _id_FB574B7959625BF0);
  _id_04E4F703E8EA149C["spotted"]["explosion"] = 2500;
  _id_04E4F703E8EA149C["hidden"]["explosion"] = 2500;
  _id_04E4F703E8EA149C["spotted"]["gunshot"] = 4000;
  _id_04E4F703E8EA149C["hidden"]["gunshot"] = 4000;
  _id_04E4F703E8EA149C["spotted"]["gunshot_teammate"] = 4000;
  _id_04E4F703E8EA149C["hidden"]["gunshot_teammate"] = 4000;
  scripts\stealth\manager::set_custom_distances(_id_04E4F703E8EA149C);
}

_id_FCFF6DF987BE068C() {
  _id_262770259C50B3AD = getdvarint("dvar_52500D90411D2058", 828);
  _id_D80639AA5AE9958A = getdvarint("dvar_3C1BE1756FB521C7", 768);
  _id_661EDF1EF9FD9C38 = getdvarint("dvar_B70103E1C59E5DBD", 700);
  _id_5F12D85AB5DC2C0D = getdvarint("dvar_FF951E1686E0157C", 640);
  _id_A34F6FB5917D2093 = getdvarint("dvar_FA1BA7EA176F6C82", 512);
  self.smellradiussq = _id_D80639AA5AE9958A * _id_D80639AA5AE9958A;
  self.smellouterradiussq = _id_262770259C50B3AD * _id_262770259C50B3AD;
  self.barkradiussq = _id_5F12D85AB5DC2C0D * _id_5F12D85AB5DC2C0D;
  self.barkouterradiussq = _id_661EDF1EF9FD9C38 * _id_661EDF1EF9FD9C38;
  self.combatradiussq = _id_A34F6FB5917D2093 * _id_A34F6FB5917D2093;
}

grenade_exploded_during_stealth_listener() {
  level endon("game_ended");
  level notify("grenade_exploded_during_stealth_listener");
  level endon("grenade_exploded_during_stealth_listener");

  if(1) {
    return;
  }
  for(;;) {
    level waittill("grenade_exploded_during_stealth", grenade, _id_A664AAD02EE98BD2, grenade_owner_name);

    switch (_id_A664AAD02EE98BD2) {
      case "claymore_mp":
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 1, grenade_owner_name);
        break;
      case "suicide_vest":
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 1, grenade_owner_name);
        break;
      case "frag_grenade_mp":
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 1, grenade_owner_name);
        break;
      case "molotov_mp":
        level.last_molotov_explode_time = gettime();
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 1, grenade_owner_name);
        break;
      case "c4_mp":
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 1, grenade_owner_name);
        break;
      case "semtex_mp":
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 1.8, grenade_owner_name);
        break;
      case "throwingknife_mp":
        level._id_DB1B17B1CAAD25DB = gettime();
        nearby_ai_investigate_grenade(1048576, 1, grenade, _id_A664AAD02EE98BD2, ::should_enter_combat_after_checking_throwingknife, grenade_owner_name);
        break;
      case "at_mine_mp":
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 0.6, grenade_owner_name);
        break;
      case "thermite_mp":
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 0.6, grenade_owner_name);
        break;
      case "flash_grenade_mp":
        level.last_flash_explode_time = gettime();
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 0.6, grenade_owner_name);
        break;
      case "concussion_grenade_mp":
        level._id_012A10C9B8E19DF0 = gettime();
        level thread nearby_ai_combat_via_grenade(4194304, 32, grenade, 0.75, grenade_owner_name);
        break;
      case "smoke_grenade_mp":
        nearby_ai_investigate_grenade(4194304, 2, grenade, _id_A664AAD02EE98BD2, ::should_enter_combat_after_checking_smoke_grenade, grenade_owner_name);
        break;
      case "snapshot_grenade_mp":
        level._id_2445992238654014 = gettime();
        nearby_ai_investigate_grenade(4194304, 2, grenade, _id_A664AAD02EE98BD2, ::should_enter_combat_after_checking_snapshot_grenade, grenade_owner_name);
        break;
      case "gas_mp":
        nearby_ai_investigate_grenade(4194304, 2, grenade, _id_A664AAD02EE98BD2, ::should_enter_combat_after_checking_gas_grenade, grenade_owner_name);
        break;
      case "decoy_grenade_mp":
        nearby_ai_investigate_grenade(9437184, 2, grenade, _id_A664AAD02EE98BD2, ::should_enter_combat_after_checking_decoy_grenade, grenade_owner_name);
        break;
      default:
        return;
    }
  }
}

_id_663719D74FBEC07F(ai, pos) {
  event = spawnStruct();
  event.typeorig = "explosion";
  event.investigate_pos = pos;
  event.origin = pos;
  event.type = "combat";
  ai[[ai.fnsetstealthstate]]("combat", event);
}

nearby_ai_combat_via_grenade(_id_33621118E3427B21, _id_FC8AECB0C985E3F8, grenade, _id_96C5DB7B1E2F5891, grenade_owner_name) {
  if(level_should_run_sp_stealth()) {
    if(!isDefined(grenade_owner_name)) {
      if(isvector(grenade))
        _id_FFBB6654C3A1BF6A = get_player_who_most_likely_broke_stealth(grenade, ::get_player_who_most_recently_threw_grenade);
      else
        _id_FFBB6654C3A1BF6A = get_player_who_most_likely_broke_stealth(grenade.origin, ::get_player_who_most_recently_threw_grenade);

      grenade_owner_name = _id_FFBB6654C3A1BF6A.name;
    }

    wait(_id_96C5DB7B1E2F5891);

    if(isvector(grenade))
      _id_1FDA6BB5F77EB472 = get_ai_within_range(grenade, _id_33621118E3427B21, _id_FC8AECB0C985E3F8);
    else
      _id_1FDA6BB5F77EB472 = get_ai_within_range(grenade.origin, _id_33621118E3427B21, _id_FC8AECB0C985E3F8);

    foreach(_id_310236DBF257FBB5 in _id_1FDA6BB5F77EB472) {
      if(isvector(grenade)) {
        thread _id_663719D74FBEC07F(_id_310236DBF257FBB5, grenade);
        continue;
      }

      thread _id_663719D74FBEC07F(_id_310236DBF257FBB5, grenade.origin);
    }

    return;
  }

  if(!isDefined(grenade_owner_name)) {
    if(isvector(grenade))
      _id_FFBB6654C3A1BF6A = get_player_who_most_likely_broke_stealth(grenade, ::get_player_who_most_recently_threw_grenade);
    else
      _id_FFBB6654C3A1BF6A = get_player_who_most_likely_broke_stealth(grenade.origin, ::get_player_who_most_recently_threw_grenade);

    grenade_owner_name = _id_FFBB6654C3A1BF6A.name;
  }

  wait(_id_96C5DB7B1E2F5891);

  if(isvector(grenade))
    _id_1FDA6BB5F77EB472 = get_ai_within_range(grenade, _id_33621118E3427B21, _id_FC8AECB0C985E3F8);
  else
    _id_1FDA6BB5F77EB472 = get_ai_within_range(grenade.origin, _id_33621118E3427B21, _id_FC8AECB0C985E3F8);

  foreach(_id_310236DBF257FBB5 in _id_1FDA6BB5F77EB472) {
    if(isDefined(get_current_stealth_state(_id_310236DBF257FBB5)))
      _id_310236DBF257FBB5 change_stealth_state_to_combat_warpper(_id_310236DBF257FBB5, grenade_owner_name, "enemies_are_alerted");
  }
}

nearby_ai_investigate_grenade(_id_33621118E3427B21, _id_FC8AECB0C985E3F8, grenade, _id_A664AAD02EE98BD2, _id_C7259036623763C1, grenade_owner_name) {
  if(level_should_run_sp_stealth()) {
    return;
  }
  _id_1FDA6BB5F77EB472 = get_ai_within_range(grenade.origin, _id_33621118E3427B21, _id_FC8AECB0C985E3F8);

  foreach(_id_310236DBF257FBB5 in _id_1FDA6BB5F77EB472) {
    if(is_ai_in_stealth(_id_310236DBF257FBB5))
      enemy_ai_enter_alert_due_to_grenade_explode(_id_310236DBF257FBB5, grenade, _id_A664AAD02EE98BD2, _id_C7259036623763C1, grenade_owner_name);
  }
}

enemy_ai_enter_alert_due_to_grenade_explode(_id_CD977BE97BC0FC1E, _id_B5AAD1BF0DB6D8D4, _id_29875973E882FA97, _id_C7259036623763C1, grenade_owner_name) {
  if(get_current_stealth_state(_id_CD977BE97BC0FC1E) != "alert")
    _id_CD977BE97BC0FC1E thread change_stealth_state_to(_id_CD977BE97BC0FC1E, "alert");
}

get_ai_within_range(_id_914E920EE4A75F55, _id_92C8E5A6D23D9243, _id_FC8AECB0C985E3F8) {
  result = [];
  _id_8738C358F4873C51 = [];
  _id_CF24C09B6F305A34 = getaiarray("axis");

  foreach(ai in _id_CF24C09B6F305A34) {
    if(distancesquared(_id_914E920EE4A75F55, ai.origin) <= _id_92C8E5A6D23D9243)
      _id_8738C358F4873C51[_id_8738C358F4873C51.size] = ai;
  }

  _id_8738C358F4873C51 = sortbydistance(_id_8738C358F4873C51, _id_914E920EE4A75F55);
  _id_AEA70742C9F555F3 = int(min(_id_8738C358F4873C51.size, _id_FC8AECB0C985E3F8));

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_AEA70742C9F555F3; _id_AC0E594AC96AA3A8++)
    result[_id_AC0E594AC96AA3A8] = _id_8738C358F4873C51[_id_AC0E594AC96AA3A8];

  return result;
}

should_enter_combat_after_checking_throwingknife(throwingknife) {
  return 0;
}

should_enter_combat_after_checking_snapshot_grenade(_id_3A986F7390C48C70) {
  return 0;
}

should_enter_combat_after_checking_smoke_grenade(_id_7F8D26B0CC303CD3) {
  return isDefined(_id_7F8D26B0CC303CD3);
}

should_enter_combat_after_checking_gas_grenade(_id_A241727D55A4C2F8) {
  return isDefined(_id_A241727D55A4C2F8);
}

should_enter_combat_after_checking_decoy_grenade(_id_DC628A84E6255852) {
  return isDefined(_id_DC628A84E6255852);
}

_id_D15BB6BDCB366A27(event) {
  if(isDefined(event) && isDefined(event.type)) {
    switch (event.type) {
      case "cover_blown":
      case "combat":
        if(isDefined(event.typeorig)) {
          switch (event.typeorig) {
            case "sight":
              if(event.type == "cover_blown") {
                scripts\stealth\utility::set_event_override("should_ignore", undefined);
                _id_18A73A64992DD07D::set_goal_radius(1024);
                return 0;
              }
            case "danger":
            case "projectile_impact":
            case "saw_corpse":
            case "grenade danger":
            case "ally_damaged":
            case "bulletwhizby":
            case "gunshot":
            case "ally_killed":
            case "silenced_shot_impact":
            case "found_corpse":
            case "explosion":
            case "combat":
              return 1;
            case "enemy":
            default:
              scripts\stealth\utility::set_event_override("should_ignore", undefined);
              _id_18A73A64992DD07D::set_goal_radius(1024);
              return 0;
          }
        } else {
          scripts\stealth\utility::set_event_override("should_ignore", undefined);
          _id_18A73A64992DD07D::set_goal_radius(1024);
          return 0;
        }
      default:
        return 1;
    }
  } else
    return 1;
}

_id_DE5486DC9107107C(dir, active, spotted) {
  if(!isDefined(self._id_F5C2AECEB96A7D6B))
    self._id_F5C2AECEB96A7D6B = gettime();

  if(gettime() >= self._id_F5C2AECEB96A7D6B) {
    if(istrue(active) && !istrue(spotted)) {
      self notify("stealth_hud_updated");
      self._id_F5C2AECEB96A7D6B = gettime() + 5000;
    }
  }

  if(isDefined(level._id_D9C72C053D9F2FED) && !scripts\engine\utility::flag("stealthMusic_firstStingerPlayed")) {
    setmusicstate(level._id_D9C72C053D9F2FED);
    scripts\engine\utility::flag_set("stealthMusic_firstStingerPlayed");
  }
}

_id_A38FAD5164D90667() {
  return [2, 1, 0];
}

_id_C72B7181608C8607(_id_42012DD2E8EE7C69, _id_E085CF82ADC280A3, _id_AE4236AF36E273DC) {
  if(!isDefined(_id_42012DD2E8EE7C69)) {
    return;
  }
  if(!isDefined(level._id_1D4C5A0449D1C023))
    level._id_1D4C5A0449D1C023 = 0;

  level._id_1D4C5A0449D1C023++;

  if(scripts\cp\cp_relics::is_relic_active("relic_oneInTheChamber")) {
    setomnvar("num_bombs_planted", level._id_1D4C5A0449D1C023);

    if(level._id_1D4C5A0449D1C023 <= 1)
      _id_1E22D314CC16F807::_id_26DC2F0B0BD90E86(2);
    else
      _id_1E22D314CC16F807::_id_26DC2F0B0BD90E86(1);
  }

  game["stealth_was_broken"] = 1;

  if(isDefined(_id_AE4236AF36E273DC))
    wait(_id_AE4236AF36E273DC);

  org = undefined;

  if(isvector(_id_42012DD2E8EE7C69))
    org = _id_42012DD2E8EE7C69;
  else
    org = _id_42012DD2E8EE7C69.origin;

  pos = spawn("script_origin", org);

  if(!istrue(_id_E085CF82ADC280A3)) {
    while(!pos isnearanyplayer(2500))
      wait 0.1;
  }

  pos playLoopSound("milbase_alarm");

  if(getdvarint("dvar_B14F25E83A3E8215", 0) != 0)
    thread _id_795560A1304FC900(pos);

  wait 11;
  pos stoploopsound();
  pos delete();
}

_id_795560A1304FC900(ent) {
  ent endon("death");
  origin = ent.origin;
  _id_C103511638513254 = getaiarrayinradius(origin, 2500, "axis");

  foreach(ai in _id_C103511638513254) {
    if(ai[[ai.fnisinstealthcombat]]()) {
      continue;
    }
    foreach(player in level.players) {
      ai aieventlistenerevent("combat", player, player.origin);
      ai getenemyinfo(player);
    }
  }
}

_id_BA975873CB8E4618() {
  wait 5;

  if(_id_1FCFEC6AECF17A41())
    return 1;
}

_id_53C55A0C7AF36050() {
  level.shots_fired = [];
  level._id_6BAF074BA0F09AFC = [];
  level._id_A8B79F12E1F36E34 = [];
  level.entered_combat = [];
  level._id_73AF1476053FFAC4 = [];
  level._id_2C2959C093A3FF43 = [];
}

_id_18CD746FF947FF3C(region) {
  level.shots_fired[region] = 0;
  level._id_A8B79F12E1F36E34[region] = 0;
  level.entered_combat[region] = 0;
  level._id_73AF1476053FFAC4[region] = 0;
  level._id_2C2959C093A3FF43[region] = 0;
  level._id_6BAF074BA0F09AFC = scripts\engine\utility::array_add(level._id_6BAF074BA0F09AFC, region);
}

_id_16E012E4220410F6(region) {
  level._id_6BAF074BA0F09AFC = scripts\engine\utility::array_remove(level._id_6BAF074BA0F09AFC, region);
}

_id_1B1663A65690A44A(region, delay, _id_1D6462B67C5ED471) {
  if(isDefined(_id_1D6462B67C5ED471))
    self endon("death");

  wait(delay);
  _id_2A54763B46ECD8D7 = _func_9D30FD63965BAFA9("gunshot");

  if(isDefined(_id_1D6462B67C5ED471) && isvector(_id_1D6462B67C5ED471)) {
    if(distance2d(_id_1D6462B67C5ED471.origin, self.origin) < _id_2A54763B46ECD8D7)
      level.shots_fired[region]++;
  } else
    level.shots_fired[region]++;
}

_id_62AE6D951DA4B634(region) {
  self endon("death");
  self notify("stealth_watchWeaponFired");
  self endon("stealth_watchWeaponFired");

  for(;;) {
    self waittill("weapon_fired");
    level thread _id_1B1663A65690A44A(region, 0.05);
  }
}

_id_F09D803BBBE62E92(region) {
  self endon("death");
  self notify("stealth_watchAIGoingIntoCombat");
  self endon("stealth_watchAIGoingIntoCombat");

  for(;;) {
    self waittill("stealth_combat");
    level thread _id_A5464841FA1292FE("combat", region, 0.05);
  }
}

_id_A5464841FA1292FE(type, obj, delay) {
  wait(delay);

  switch (type) {
    case "hunt":
      level._id_A8B79F12E1F36E34[obj]++;
      break;
    case "combat":
      level.entered_combat[obj]++;
      break;
    case "investigate":
      level._id_73AF1476053FFAC4[obj]++;
      break;
    case "killed":
      level._id_2C2959C093A3FF43[obj]++;
      break;
  }
}

_id_1FCFEC6AECF17A41() {
  foreach(region in level._id_6BAF074BA0F09AFC) {
    if(level.shots_fired[region] > 1)
      return 1;
  }

  return 0;
}

_id_2CDD250EBE64308F(_id_DCF5E15C58C4152A, origin, _id_451A9D27D63C746B) {
  _id_7D2909FDC2B71387 = _id_371B4C2AB5861E62::_id_2B0E82156FA6075B(_id_451A9D27D63C746B);
  _id_371B4C2AB5861E62::_id_760792071513B00D(_id_451A9D27D63C746B);

  if(!isDefined(_id_7D2909FDC2B71387)) {
    return;
  }
  aitype = _id_7D2909FDC2B71387.aitype;
  origin = _id_7D2909FDC2B71387.origin;
  angles = _id_7D2909FDC2B71387.angles;
  priority = _id_371B4C2AB5861E62::_id_072D6808216B4D44(_id_7D2909FDC2B71387.priority);
  category = _id_7D2909FDC2B71387.category;
  _id_1C9CB43BCF3EB16D = _id_7D2909FDC2B71387._id_1C9CB43BCF3EB16D;
  groupname = _id_7D2909FDC2B71387.groupname;
  team = _id_7D2909FDC2B71387.team;
  destination = undefined;
  _id_171F90B9C4C76D44 = _id_7D2909FDC2B71387._id_B205D90302DA2F07;
  _id_F891E067B8802C0D = _id_7D2909FDC2B71387._id_F891E067B8802C0D;
  _id_F8BC7ECDD324DD79 = _id_7D2909FDC2B71387._id_F8BC7ECDD324DD79;
  _id_80F4BDE7090A4773 = _id_7D2909FDC2B71387._id_80F4BDE7090A4773;
  _id_8124E3F14D523A45 = _id_7D2909FDC2B71387._id_324DFDEE5BDF702E;
  _id_8A76B06617613D30 = scripts\cp_mp\utility\script_utility::getsharedfunc("ai_mp_controller", "ai_mp_requestSpawnAgent");
  agent = [[_id_8A76B06617613D30]](aitype, origin, angles, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, destination, _id_171F90B9C4C76D44, _id_F891E067B8802C0D, 1, undefined, _id_80F4BDE7090A4773);

  if(isDefined(agent)) {
    agent._id_F8BC7ECDD324DD79 = _id_F8BC7ECDD324DD79;
    _id_580A150BA253DE13 = scripts\cp_mp\utility\script_utility::getsharedfunc("ai_mp_controller", "behavior_executeBehaviorPackage");
    [[_id_580A150BA253DE13]](agent);
    agent._id_324DFDEE5BDF702E = _id_8124E3F14D523A45;
    _id_371B4C2AB5861E62::_id_E662189D61D1874E(agent);
  }
}

_id_418B248FC7829336() {
  _id_371B4C2AB5861E62::_id_B04C0433E8107615();
  level._id_74E9C02B56E4BA52 = ::_id_2CDD250EBE64308F;
  level._id_8A42B71F799936AD = ::_id_A362AF8FE3C74D33;
  level._id_FE093E9B2B6C3751 = getdvarint("dvar_320C4DB6AF00B215", 0);
  level._id_53DB9BACADEF066D = spawnStruct();
  level._id_53DB9BACADEF066D._id_D4053E1A1D2983CE = 0;
  level._id_879053468F168806 = [];
}

_id_A362AF8FE3C74D33(agent, _id_451A9D27D63C746B) {
  aitype = agent.agent_type;
  origin = agent.origin;
  angles = agent.angles;
  priority = agent.priority;
  category = agent.category;
  _id_1C9CB43BCF3EB16D = agent._id_1C9CB43BCF3EB16D;
  groupname = agent.script_stealthgroup;
  team = agent.team;
  destination = undefined;
  _id_171F90B9C4C76D44 = agent._id_B205D90302DA2F07;
  _id_F891E067B8802C0D = !agent.stealth_enabled;
  _id_F8BC7ECDD324DD79 = agent._id_F8BC7ECDD324DD79;
  _id_80F4BDE7090A4773 = agent._id_80F4BDE7090A4773;
  _id_8124E3F14D523A45 = agent._id_324DFDEE5BDF702E;

  if(isDefined(_id_F8BC7ECDD324DD79) && _id_F8BC7ECDD324DD79.behavior == "cqb" && isDefined(_id_F8BC7ECDD324DD79._id_F1548C57038E1B7A)) {
    foreach(node in _id_F8BC7ECDD324DD79._id_F1548C57038E1B7A) {
      if(isDefined(node))
        node.claimed = 0;
    }
  }

  _id_7D2909FDC2B71387 = _id_371B4C2AB5861E62::_id_E83D1F023A2609FF(aitype, origin, angles, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, destination, _id_171F90B9C4C76D44, _id_F891E067B8802C0D, _id_F8BC7ECDD324DD79, _id_80F4BDE7090A4773, _id_8124E3F14D523A45);
  _id_371B4C2AB5861E62::_id_7A9172605E0228DF(_id_451A9D27D63C746B, _id_7D2909FDC2B71387);
}

_id_778F9D9E0731E729() {
  level endon("gane_ended");

  for(;;) {
    level waittill("trigger_reinforcements_if_applicable");

    if(isDefined(level._id_42354BFD2F2F8439))
      level thread[[level._id_42354BFD2F2F8439]]();
  }
}