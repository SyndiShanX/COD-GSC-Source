/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3593e95c2fcfa407.gsc
***********************************************/

register_spawn_modules() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("cp_raid_complex_cs_trap_room_completed");
  _id_18A73A64992DD07D::registerambientgroup("trap_room_initial_spawning", 0, 9, 9, 0.1, undefined, "initial_spawning");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("trap_room_initial_spawning", ::_id_B057BDD9791F64C2);
  _id_18A73A64992DD07D::registerambientgroup("outrostart_jugg", 1, 1, 1, 0.1, undefined, "outrostart_jugg");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("outrostart_jugg", ::_id_3D22426B1249BFAE);
  _id_18A73A64992DD07D::registerambientgroup("outrostart_t3", 1, 1, 1, 0.1, undefined, "outrostart_t3");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("outrostart_t3", ::_id_3D22426B1249BFAE);
  _id_18A73A64992DD07D::registerambientgroup("bomber_test", 0, 1, 1, 0.1, undefined, "bomber_test");
  end_func = [::module_wait_for_level_flag_set_and_clear, "any_player_in_trap_room"];
  _id_18A73A64992DD07D::registerambientgroup("trap_room_spawning", 0, 32, [::increase_total_count_per_module_call, 24, 0.5, 4], 0.1, end_func, ::choose_spawners_from_matching_volumes, ::init_trap_room_spawning_module, "trap_room_spawning");
  _id_17E17F0C541451CC = ::_id_AFCDBC5178CB5C04;
  _id_FF33BBED1CB61238 = ::_id_AFCCD352B81C7B68;
  _id_DB5588D7C028971A = ::init_trap_room_spawning_module;
  _id_85EAD211436E6A64 = undefined;
  _id_0A29223B463EC3EA = ::_id_F845480D763CE1A1;
  spawn_groups = ["filler_a", "filler_b", "jugg_a", "jugg_b", "shield_a", "shield_b", "bomber_a", "bomber_b", "rpg_a", "rpg_b", "sniper_a", "sniper_b"];
  _id_18A73A64992DD07D::registerambientgroup("filler_a_test", 0, 4, 4, 0.1, undefined, "filler_a_test", undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("filler_a_test", ::_id_81FCB63BC44A4463);
  _id_18A73A64992DD07D::registerambientgroup("punishment_wave", 0, ::_id_1E6F648E6DAEB0A3, ::_id_1E6F648E6DAEB0A3, 0.1, end_func, "punishment_wave", undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("punishment_wave", ::_id_0604ACCB70ADCD93);
  _id_18A73A64992DD07D::registerambientgroup("filler_a", 0, _id_FF33BBED1CB61238, _id_17E17F0C541451CC, 0.1, end_func, _id_0A29223B463EC3EA, _id_DB5588D7C028971A, _id_85EAD211436E6A64);
  _id_18A73A64992DD07D::registerambientgroup("filler_b", 0, _id_FF33BBED1CB61238, _id_17E17F0C541451CC, 0.1, end_func, _id_0A29223B463EC3EA, _id_DB5588D7C028971A, _id_85EAD211436E6A64);
  _id_18A73A64992DD07D::registerambientgroup("jugg_a", 0, _id_FF33BBED1CB61238, _id_17E17F0C541451CC, 0.1, end_func, _id_0A29223B463EC3EA, _id_DB5588D7C028971A, _id_85EAD211436E6A64);
  _id_18A73A64992DD07D::registerambientgroup("jugg_b", 0, _id_FF33BBED1CB61238, _id_17E17F0C541451CC, 0.1, end_func, _id_0A29223B463EC3EA, _id_DB5588D7C028971A, _id_85EAD211436E6A64);
  _id_18A73A64992DD07D::registerambientgroup("shield_a", 0, _id_FF33BBED1CB61238, _id_17E17F0C541451CC, 0.1, end_func, _id_0A29223B463EC3EA, _id_DB5588D7C028971A, _id_85EAD211436E6A64);
  _id_18A73A64992DD07D::registerambientgroup("shield_b", 0, _id_FF33BBED1CB61238, _id_17E17F0C541451CC, 0.1, end_func, _id_0A29223B463EC3EA, _id_DB5588D7C028971A, _id_85EAD211436E6A64);
  _id_18A73A64992DD07D::registerambientgroup("bomber_a", 0, _id_FF33BBED1CB61238, _id_17E17F0C541451CC, 0.1, end_func, _id_0A29223B463EC3EA, _id_DB5588D7C028971A, _id_85EAD211436E6A64);
  _id_18A73A64992DD07D::registerambientgroup("bomber_b", 0, _id_FF33BBED1CB61238, _id_17E17F0C541451CC, 0.1, end_func, _id_0A29223B463EC3EA, _id_DB5588D7C028971A, _id_85EAD211436E6A64);
  _id_18A73A64992DD07D::registerambientgroup("rpg_a", 0, _id_FF33BBED1CB61238, _id_17E17F0C541451CC, 0.1, end_func, _id_0A29223B463EC3EA, _id_DB5588D7C028971A, _id_85EAD211436E6A64);
  _id_18A73A64992DD07D::registerambientgroup("rpg_b", 0, _id_FF33BBED1CB61238, _id_17E17F0C541451CC, 0.1, end_func, _id_0A29223B463EC3EA, _id_DB5588D7C028971A, _id_85EAD211436E6A64);
  _id_18A73A64992DD07D::registerambientgroup("sniper_a", 0, _id_FF33BBED1CB61238, _id_17E17F0C541451CC, 0.1, end_func, _id_0A29223B463EC3EA, _id_DB5588D7C028971A, _id_85EAD211436E6A64);
  _id_18A73A64992DD07D::registerambientgroup("sniper_b", 0, _id_FF33BBED1CB61238, _id_17E17F0C541451CC, 0.1, end_func, _id_0A29223B463EC3EA, _id_DB5588D7C028971A, _id_85EAD211436E6A64);
  init_spawners("filler_a");
  init_spawners("jugg_a");
  init_spawners("shield_a");
  init_spawners("bomber_a");
  init_spawners("rpg_a");
  init_spawners("sniper_a");
  init_spawners("filler_b");
  init_spawners("jugg_b");
  init_spawners("shield_b");
  init_spawners("bomber_b");
  init_spawners("rpg_b");
  init_spawners("sniper_b");
  _id_70989CF917B97159 = "ar_t1_aq";
  _id_222983CFBF7DB77F = "smg_t1_aq";
  _id_8752D118928DBF51 = "shotgun_t1_aq";
  _id_84BBC240F5607AD1 = "sniper_t1_aq";
  _id_151D6ACFB676F93D = "rpg_t1_aq";
  _id_5362BE84F14962F7 = "riotshield_t1_aq";
  _id_644071F90F781AF0 = "ar_t2_aq";
  _id_ED545BBC4669DEDC = "smg_t2_aq";
  _id_49336939CA41EA60 = "shotgun_t2_aq";
  _id_751E98863D3226AC = "sniper_t2_aq";
  _id_56E062F906149BB7 = "ar_t3_aq";
  _id_28854BA91DF9181D = "smg_t3_aq";
  _id_DDFEAF298DB571CB = "shotgun_t3_aq";
  _id_E6C37FF62F38630F = "sniper_t3_aq";
  _id_E21279FA90BDF012 = "jugg_aq";
  init_trap_room_wave("filler_a", 1, [_id_70989CF917B97159, _id_222983CFBF7DB77F, _id_644071F90F781AF0], [2, 3, 2], 7, "side_a");
  init_trap_room_wave("filler_a", 2, [_id_70989CF917B97159, _id_222983CFBF7DB77F, _id_8752D118928DBF51, _id_644071F90F781AF0, _id_56E062F906149BB7], [2, 3, 1, 3, 2], 11, "side_a");
  init_trap_room_wave("shield_a", 2, [_id_5362BE84F14962F7], [1], 1, "side_a");
  init_trap_room_wave("filler_b", 2, [_id_70989CF917B97159, _id_222983CFBF7DB77F, _id_ED545BBC4669DEDC], [3, 3, 1], 7, "side_b");
  init_trap_room_wave("filler_a", 3, [_id_70989CF917B97159, _id_222983CFBF7DB77F, _id_644071F90F781AF0], [1, 1, 3], 5, "side_a");
  init_trap_room_wave("filler_b", 3, [_id_70989CF917B97159, _id_222983CFBF7DB77F, _id_644071F90F781AF0], [1, 2, 2], 5, "side_b");
  init_trap_room_wave("filler_a", 4, [_id_70989CF917B97159, _id_222983CFBF7DB77F], [3, 3], 6, "side_a");
  init_trap_room_wave("filler_b", 4, [_id_70989CF917B97159, _id_ED545BBC4669DEDC, _id_56E062F906149BB7], [5, 5, 1], 11, "side_b");
  init_trap_room_wave("shield_b", 4, [_id_5362BE84F14962F7], [1], 1, "side_b");
  init_trap_room_wave("filler_b", 5, [_id_644071F90F781AF0, _id_ED545BBC4669DEDC], [3, 3], 6, "side_b");
  init_trap_room_wave("shield_b", 5, [_id_5362BE84F14962F7], [1], 1, "side_b");
  init_trap_room_wave("filler_b", 6, [_id_644071F90F781AF0, _id_ED545BBC4669DEDC], [4, 5], 9, "side_b");
  init_trap_room_wave("jugg_b", 6, [_id_E21279FA90BDF012], [1], 1, "side_b");
  init_trap_room_wave("shield_b", 6, [_id_5362BE84F14962F7], [2], 2, "side_b");
  _id_3D0EF4CC564F84DB = [scripts\cp\cp_spawning_util::set_recent_spawn_time_threshold_override, 5];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < spawn_groups.size; _id_AC0E594AC96AA3A8++) {
    _id_18A73A64992DD07D::set_spawn_scoring_params_for_group(spawn_groups[_id_AC0E594AC96AA3A8], undefined, 20000, 30000);
    scripts\cp\cp_spawning_util::register_module_init_func(spawn_groups[_id_AC0E594AC96AA3A8], _id_3D0EF4CC564F84DB);
    _id_18A73A64992DD07D::register_module_ai_spawn_func(spawn_groups[_id_AC0E594AC96AA3A8], ::_id_81FCB63BC44A4463);
  }
}

_id_0604ACCB70ADCD93(group) {
  self _meth_9215CE6FC83759B9(3000);
  players = _id_544C706A83CA9086("a");
  closestplayer = scripts\engine\utility::getclosest(self.origin, players, 2048);

  if(isDefined(closestplayer) && isalive(closestplayer)) {
    self getenemyinfo(closestplayer);
    self setgoalentity(closestplayer);
  }
}

_id_81FCB63BC44A4463(group) {
  if(isDefined(self._id_4C3337129231E244)) {
    _id_4F2A0297830D644C = strtok(self._id_4C3337129231E244, "_");

    switch (_id_4F2A0297830D644C[0]) {
      case "ar":
        break;
      case "smg":
        break;
      case "rpg":
        self setengagementmindist(1024, 1024);
        self setengagementmaxdist(2048, 2048);
        self _meth_9215CE6FC83759B9(2048);
        self.goalradius = 2500;
        self enabletraversals(0, "soldier");
        break;
      case "sniper":
        self setengagementmindist(1024, 1024);
        self setengagementmaxdist(2048, 2048);
        self _meth_9215CE6FC83759B9(2048);
        self.goalradius = 2500;
        self enabletraversals(0, "soldier");
        break;
      default:
        break;
    }
  }

  _id_6D8E8725698EEFC2 = sortbydistance(level.players, self.origin);

  if(isDefined(_id_6D8E8725698EEFC2[0])) {
    self getenemyinfo(_id_6D8E8725698EEFC2[0]);

    if(isDefined(level._id_5F6D7C9AB8032014) && level._id_5F6D7C9AB8032014 == 6) {
      self setgoalentity(_id_6D8E8725698EEFC2[0]);
      thread _id_D2C80D25A9934BC4();
    }
  }
}

_id_D2C80D25A9934BC4() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    _id_6D8E8725698EEFC2 = sortbydistance(level.players, self.origin);

    if(isDefined(_id_6D8E8725698EEFC2[0]))
      self setgoalentity(_id_6D8E8725698EEFC2[0]);

    wait 10;
  }
}

_id_75A111F7AB1C92EE(group, _id_FA2F367065F11915) {
  self endon("death");
  level endon("game_ended");
  self notify("basic_combat");
  self.ignoreall = 1;
  anchor = scripts\engine\utility::spawn_tag_origin();
  self linkTo(anchor);
  thread _id_41328D99A64A9813::_id_4FBCD21D182FEF58(_id_FA2F367065F11915);
  _id_FA2F367065F11915 waittill("elevator_opened");
  self.is_on_platform = 0;
  self.never_kill_off = 1;
  self.dontkilloff = 1;
  self.ignoreall = 0;
  self unlink();
  anchor delete();

  if(isDefined(self.spawner) && isDefined(self.spawner.target) && isDefined(scripts\engine\utility::getStruct(self.spawner.target, "targetname"))) {
    _id_CED0426E7E729ED5 = scripts\engine\utility::getStruct(self.spawner.target, "targetname");
    self setgoalpos(_id_CED0426E7E729ED5.origin);
  } else {
    closestplayer = scripts\engine\utility::getclosest(self.origin, level.players, 2048);

    if(isDefined(closestplayer) && isPlayer(closestplayer)) {
      self getenemyinfo(closestplayer);
      self.favoriteenemy = closestplayer;
      self setgoalentity(closestplayer);
    }
  }
}

_id_9F21E0004DAD2995(group_name) {
  wait 2;
}

_id_5C7633E120166DAC(_id_EF4E676FC377AFBB) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  triggers = getEntArray(_id_EF4E676FC377AFBB, "script_noteworthy");

  foreach(trigger in triggers) {
    if(isDefined(trigger.targetname)) {
      if(!isDefined(trigger.script_flag)) {
        level thread _id_97BDE46CE4421680(trigger);
        continue;
      }

      if(isDefined(trigger.script_flag) && trigger.script_flag == "hard_mode" && scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
        level thread _id_97BDE46CE4421680(trigger);
    }
  }
}

_id_97BDE46CE4421680(_id_F9CE4EE3950DD8CF) {
  _id_B8C12A18F2D34763 = strtok(_id_F9CE4EE3950DD8CF.targetname, ",");
  groupname = _id_B8C12A18F2D34763[0];
  _id_5652480FA5097F6B = 0;
  _id_BC68E8E5F4C4F28D = 1;

  if(_id_B8C12A18F2D34763.size >= 3) {
    _id_5652480FA5097F6B = int(_id_B8C12A18F2D34763[1]);
    _id_BC68E8E5F4C4F28D = int(_id_B8C12A18F2D34763[2]);
  }

  _id_F9CE4EE3950DD8CF._id_B29D63D5BCEF6670 = _id_5652480FA5097F6B;
  _id_DCAA4378BA2F134C = scripts\engine\utility::getStructArray(groupname, "targetname").size;
  total_spawns = _id_BC68E8E5F4C4F28D * _id_DCAA4378BA2F134C;
  _id_18A73A64992DD07D::registerambientgroup(groupname, ::_id_1E6F648E6DAEB0A3, ::_id_1E6F648E6DAEB0A3, total_spawns, 0.1, undefined, groupname);

  if(!isDefined(_id_F9CE4EE3950DD8CF.script_parameters))
    _id_18A73A64992DD07D::register_module_ai_spawn_func(groupname, ::_id_BC4EF206E692DE0A);
  else {
    switch (_id_F9CE4EE3950DD8CF.script_parameters) {
      case "snipe":
        _id_18A73A64992DD07D::register_module_ai_spawn_func(groupname, ::_id_B018F6F46A6CD36A);
        break;
      case "ambush":
        _id_18A73A64992DD07D::register_module_ai_spawn_func(groupname, ::_id_DBC16CC3078D23FF);
        break;
      case "supress":
        _id_18A73A64992DD07D::register_module_ai_spawn_func(groupname, ::_id_8E922130A9978066);
        break;
      case "molotov":
        _id_18A73A64992DD07D::register_module_ai_spawn_func(groupname, ::_id_01B0B2A4C814B7C7);
        break;
      case "keybearer":
        _id_18A73A64992DD07D::register_module_ai_spawn_func(groupname, ::_id_3CD8D6737BD7B10B);
        break;
      case "thermite_thrower":
        _id_18A73A64992DD07D::register_module_ai_spawn_func(groupname, ::_id_B90ED11B0C5B274C);
        break;
      case "juggernaut":
        _id_18A73A64992DD07D::register_module_ai_spawn_func(groupname, ::_id_D976B5094996FFE8);
        break;
      case "stealth_patrol":
        if(isDefined(level._id_AAF6515899A6735D))
          _id_18A73A64992DD07D::register_module_ai_spawn_func(groupname, level._id_AAF6515899A6735D);
      default:
        break;
    }
  }

  if(getdvarint("dvar_F0F10B52A800D290", 0) > 0) {
    return;
  }
  _id_77104DAE551BE48A = getEnt(groupname + "_abort", "script_noteworthy");
  level thread _id_9D09936B4A120126(_id_F9CE4EE3950DD8CF, groupname);

  if(isDefined(_id_77104DAE551BE48A))
    level thread _id_903FA31FE27AC367(_id_77104DAE551BE48A, groupname);
}

_id_903FA31FE27AC367(_id_77104DAE551BE48A, groupname) {
  level endon("game_ended");

  for(;;) {
    _id_77104DAE551BE48A waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    _id_18A73A64992DD07D::stop_module_by_groupname(groupname);
  }
}

_id_9D09936B4A120126(trigger, groupname) {
  level endon("game_ended");
  trigger endon("death");

  if(!isDefined(trigger)) {
    return;
  }
  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(isDefined(trigger._id_B29D63D5BCEF6670))
      wait(trigger._id_B29D63D5BCEF6670);

    _id_18A73A64992DD07D::run_spawn_module(groupname);
    return;
  }
}

_id_648CA482C539FEA0() {
  level endon("game_ended");

  if(getdvarint("dvar_CA0F7A9EAE7CD4CC", 0) <= 0) {
    return;
  }
  _id_3F30F9BB65C6FC8C = _id_18AF78602B67B70C::_id_050326CC21187D35("test_wave_spawn", &"CP_TRAP_ROOM/TEST_WAVE", "button_on");
  _id_76FA1A36ED9896E1 = _id_18AF78602B67B70C::_id_050326CC21187D35("test_tier_advance", &"CP_TRAP_ROOM/LOOP_TIERS", "button_on");
  thread _id_06B4BE1C8079DBD1(_id_3F30F9BB65C6FC8C);
  thread _id_7633B4AB7CF120DE(_id_76FA1A36ED9896E1);
}

_id_7633B4AB7CF120DE(button) {
  level endon("game_ended");

  for(;;) {
    button _meth_DFB78B3E724AD620(1);
    button waittill("trigger", player);

    if(!isPlayer(player)) {
      waitframe();
      continue;
    }

    button _meth_DFB78B3E724AD620(0);

    if(_id_3A864E6F5D874675() >= 6) {
      _id_8147054DB47AF43C();
      iprintlnbold("wave tier 1");
    } else {
      _id_4EEC65C94E0AB667();
      iprintlnbold("wave tier " + _id_3A864E6F5D874675());
    }

    wait 0.4;
  }
}

_id_06B4BE1C8079DBD1(button) {
  level endon("game_ended");

  for(;;) {
    button _meth_DFB78B3E724AD620(1);
    button waittill("trigger", player);

    if(!isPlayer(player)) {
      waitframe();
      continue;
    }

    button _meth_DFB78B3E724AD620(0);
    _id_C1E6B81F3E693135(1);
    return;
  }
}

module_wait_for_level_flag_set_and_clear(_id_F8E5E3AA5762A8E7, _id_7B295362196F3D9D) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait(_id_7B295362196F3D9D);
  scripts\engine\utility::flag_waitopen(_id_7B295362196F3D9D);
}

module_set_skip_basic_combat(_id_F8E5E3AA5762A8E7) {
  self.skip_basic_combat = 1;
}

choose_spawners_from_matching_volumes(_id_F8E5E3AA5762A8E7) {
  _id_64E4B70CB932933C = scripts\engine\utility::getStructArray("side_a", "targetname");
  _id_B7228B6495741463 = scripts\engine\utility::getStructArray("side_b", "targetname");
  _id_15CA06DD9E32849E = getEntArray("side_a", "targetname");
  _id_414DDA4CABF358AF = getEnt("trap_room", "targetname");
  _id_658E422BC3F29E03 = scripts\engine\utility::array_combine(_id_15CA06DD9E32849E, _id_414DDA4CABF358AF);

  if(!isDefined(_id_15CA06DD9E32849E))
    return scripts\engine\utility::array_combine(_id_64E4B70CB932933C, _id_B7228B6495741463);

  _id_81503EDD3735B37B = getEntArray("side_b", "targetname");

  if(!isDefined(_id_81503EDD3735B37B))
    return scripts\engine\utility::array_combine(_id_64E4B70CB932933C, _id_B7228B6495741463);

  _id_A1780ACBE9372380 = int(min(level.players.size, 3));
  _id_CB3C7356E1F156E9 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    _id_823F8193C8220611 = 1;

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_658E422BC3F29E03.size; _id_AC0E5C4AC96AAA41++) {
      if(level.players[_id_AC0E594AC96AA3A8] istouching(_id_658E422BC3F29E03[_id_AC0E5C4AC96AAA41])) {
        _id_823F8193C8220611 = 0;
        break;
      }
    }

    if(_id_823F8193C8220611)
      _id_CB3C7356E1F156E9++;
  }

  _id_F4CAE9D2914CC11B = randomint(_id_A1780ACBE9372380);

  if(_id_CB3C7356E1F156E9 >= _id_A1780ACBE9372380) {
    _id_18A73A64992DD07D::stop_all_groups();
    return undefined;
  }

  if(_id_CB3C7356E1F156E9 > _id_F4CAE9D2914CC11B)
    return _id_B7228B6495741463;
  else
    return _id_64E4B70CB932933C;
}

init_trap_room_spawning_module(_id_F8E5E3AA5762A8E7) {
  level endon("game_ended");

  if(!isDefined(level.module_call_counter))
    level.module_call_counter = [];

  if(!isDefined(level.module_call_counter[_id_F8E5E3AA5762A8E7.group_name]))
    level.module_call_counter[_id_F8E5E3AA5762A8E7.group_name] = 1;
  else
    level.module_call_counter[_id_F8E5E3AA5762A8E7.group_name]++;

  if(_id_0CD68A61419FD07A(_id_F8E5E3AA5762A8E7)) {
    _id_A75E674C355F4772 = _id_F8E5E3AA5762A8E7 _id_402C8788F9691DCD(_id_F8E5E3AA5762A8E7.group_name, level.module_call_counter[_id_F8E5E3AA5762A8E7.group_name]);
    _id_F8E5E3AA5762A8E7 create_ai_type_override(_id_A75E674C355F4772[0], _id_A75E674C355F4772[1]);
    _id_F8E5E3AA5762A8E7 thread wait_until_trap_room_clear();
  } else
    _id_F8E5E3AA5762A8E7 thread wait_until_trap_room_clear(1);
}

_id_0CD68A61419FD07A(_id_F8E5E3AA5762A8E7) {
  tier = _id_3A864E6F5D874675();

  if(isDefined(level.trap_room_wave_settings[_id_F8E5E3AA5762A8E7.group_name]) && isDefined(level.trap_room_wave_settings[_id_F8E5E3AA5762A8E7.group_name][tier]))
    return 1;
  else
    return 0;
}

module_has_data_for_call_count(_id_F8E5E3AA5762A8E7) {
  _id_FFA37BAD3D0EEDBD = get_module_call_count(_id_F8E5E3AA5762A8E7);

  if(isDefined(level.trap_room_wave_settings[_id_F8E5E3AA5762A8E7.group_name]) && isDefined(level.trap_room_wave_settings[_id_F8E5E3AA5762A8E7.group_name][_id_FFA37BAD3D0EEDBD]))
    return 1;
  else
    return 0;
}

_id_402C8788F9691DCD(_id_CA8D3101C7736449, counter) {
  aitypes = [];
  weights = [];

  if(isDefined(counter) && isDefined(_id_CA8D3101C7736449) && _id_0CD68A61419FD07A(self)) {
    data = get_wave_data(self);
    aitypes = data.aitypes;
    weights = data.aitype_counts;
    return [aitypes, weights];
  }

  return [aitypes, weights];
}

create_ai_type_override(aitypes, weights) {
  if(!isDefined(self.aitype_override)) {
    self.aitype_override = [];
    self.aitype_override_weights = [];
    self.aitype_override_cumulative_weight = 0;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < aitypes.size; _id_AC0E594AC96AA3A8++) {
    self.aitype_override[self.aitype_override.size] = aitypes[_id_AC0E594AC96AA3A8];
    weight = _id_18A73A64992DD07D::define_var_if_undefined(weights[_id_AC0E594AC96AA3A8], 10);
    self.aitype_override_weights[self.aitype_override_weights.size] = weight;
    self.aitype_override_cumulative_weight = self.aitype_override_cumulative_weight + weight;
  }
}

wait_until_trap_room_clear(_id_B40532DB53DA365D) {
  level endon("game_ended");
  level endon("trap_room_complete");
  self endon("death");
  scripts\engine\utility::flag_waitopen("any_player_in_trap_room");

  if(istrue(_id_B40532DB53DA365D))
    _id_18A73A64992DD07D::stop_module_by_groupname(self.group_name, 1);
}

increase_total_count_per_module_call(_id_F8E5E3AA5762A8E7, count, _id_875BC731059842BB, _id_A6974F8331AAB9EF) {
  _id_FFA37BAD3D0EEDBD = get_module_call_count(_id_F8E5E3AA5762A8E7);

  if(isDefined(_id_A6974F8331AAB9EF))
    _id_FFA37BAD3D0EEDBD = min(_id_FFA37BAD3D0EEDBD, _id_A6974F8331AAB9EF);

  return int(max(_id_FFA37BAD3D0EEDBD * _id_875BC731059842BB, 1)) * count;
}

_id_AFCDBC5178CB5C04(_id_F8E5E3AA5762A8E7) {
  tier = _id_3A864E6F5D874675();
  keys = getarraykeys(level.trap_room_wave_settings[_id_F8E5E3AA5762A8E7.group_name]);
  _id_222049A1CD0DEC46 = keys[keys.size - 1];
  tier = int(min(_id_222049A1CD0DEC46, tier));

  if(!isDefined(level.trap_room_wave_settings[_id_F8E5E3AA5762A8E7.group_name][tier]))
    return 0;
  else {
    _id_8A52520CE1A05C16 = getaiarray("axis").size;
    _id_350FC69B17797361 = level.trap_room_wave_settings[_id_F8E5E3AA5762A8E7.group_name][tier].total_spawns;

    if(_id_8A52520CE1A05C16 + _id_350FC69B17797361 >= 40)
      return 0;
    else
      return _id_350FC69B17797361;
  }
}

_id_AFCCD352B81C7B68(_id_F8E5E3AA5762A8E7) {
  tier = _id_3A864E6F5D874675();
  keys = getarraykeys(level.trap_room_wave_settings[_id_F8E5E3AA5762A8E7.group_name]);
  _id_222049A1CD0DEC46 = keys[keys.size - 1];
  tier = int(min(_id_222049A1CD0DEC46, tier));

  if(!isDefined(level.trap_room_wave_settings[_id_F8E5E3AA5762A8E7.group_name][tier]))
    return 0;
  else
    return level.trap_room_wave_settings[_id_F8E5E3AA5762A8E7.group_name][tier].max_spawns;
}

_id_40989844C5EFE161(_id_F8E5E3AA5762A8E7) {
  return scripts\engine\utility::getStructArray(_id_F8E5E3AA5762A8E7.group_name, "targetname").size;
}

init_spawners(groupname) {
  _id_8A0DA49670997C6D = scripts\engine\utility::getStructArray(groupname, "targetname");

  if(!isDefined(level._id_38E50D27B7AA5E9D))
    level._id_38E50D27B7AA5E9D = [];

  if(!isDefined(level._id_38E50D27B7AA5E9D[groupname]))
    level._id_38E50D27B7AA5E9D[groupname] = [];

  foreach(spawner in _id_8A0DA49670997C6D) {
    if(!isDefined(spawner.target) || getdvarint("dvar_60C0CBEF11D5A392", 0) > 0) {
      spawner._id_C8F0C14DD34F6B9C = spawnStruct();
      spawner._id_C8F0C14DD34F6B9C.origin = spawner.origin;

      if(!isDefined(spawner._id_C8F0C14DD34F6B9C.spawners))
        spawner._id_C8F0C14DD34F6B9C.spawners = [spawner];
    } else {
      for(_id_C8F0C14DD34F6B9C = scripts\engine\utility::getStruct(spawner.target, "targetname"); isDefined(_id_C8F0C14DD34F6B9C.target); _id_C8F0C14DD34F6B9C = scripts\engine\utility::getStruct(_id_C8F0C14DD34F6B9C.target, "targetname")) {}

      spawner._id_C8F0C14DD34F6B9C = _id_C8F0C14DD34F6B9C;

      if(!isDefined(_id_C8F0C14DD34F6B9C.spawners))
        _id_C8F0C14DD34F6B9C.spawners = [];

      _id_C8F0C14DD34F6B9C.spawners[_id_C8F0C14DD34F6B9C.spawners.size] = spawner;
    }

    if(!scripts\engine\utility::array_contains(level._id_38E50D27B7AA5E9D[groupname], spawner._id_C8F0C14DD34F6B9C))
      level._id_38E50D27B7AA5E9D[groupname][level._id_38E50D27B7AA5E9D[groupname].size] = spawner._id_C8F0C14DD34F6B9C;
  }
}

_id_1DDAA70EDC614359(destinations, _id_4351410D12107DF3, _id_F7D024DFBF2D902D) {
  if(destinations.size <= _id_F7D024DFBF2D902D)
    return destinations;

  _id_11FE125321C4C1F9 = [];
  _id_523566FE93C0238C = destinations;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F7D024DFBF2D902D; _id_AC0E594AC96AA3A8++) {
    _id_114AB88507847C50 = scripts\engine\utility::getclosest(_id_4351410D12107DF3, _id_523566FE93C0238C);
    _id_523566FE93C0238C = _id_3B2CD5E70D48BD44(_id_523566FE93C0238C, _id_114AB88507847C50);
    _id_11FE125321C4C1F9[_id_11FE125321C4C1F9.size] = _id_114AB88507847C50;
  }

  return _id_11FE125321C4C1F9;
}

_id_C0DB8DDB89E44BCE(destinations, _id_4351410D12107DF3, spawner_number) {
  _id_3DFDCC5DC839943F = [];
  _id_0BDB45DB038A3899 = sortbydistance(destinations, _id_4351410D12107DF3);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < spawner_number; _id_AC0E594AC96AA3A8++) {
    _id_C972C06FF2A6EB8F = _id_AC0E594AC96AA3A8;

    if(_id_AC0E594AC96AA3A8 >= _id_0BDB45DB038A3899.size)
      _id_C972C06FF2A6EB8F = 0;

    foreach(spawner in _id_0BDB45DB038A3899[_id_C972C06FF2A6EB8F].spawners) {
      _id_3DFDCC5DC839943F[_id_3DFDCC5DC839943F.size] = spawner;

      if(_id_3DFDCC5DC839943F.size == spawner_number)
        return _id_3DFDCC5DC839943F;
    }
  }

  return _id_3DFDCC5DC839943F;
}

_id_1E6F648E6DAEB0A3(_id_F8E5E3AA5762A8E7) {
  spawners = scripts\engine\utility::getStructArray(_id_F8E5E3AA5762A8E7.group_name, "targetname");

  if(isDefined(spawners))
    return spawners.size;
  else
    return 0;
}

_id_3B2CD5E70D48BD44(ents, _id_F7E215BD10CC45E9) {
  _id_D674D7970EEF9653 = [];

  foreach(ent in ents) {
    if(ent != _id_F7E215BD10CC45E9)
      _id_D674D7970EEF9653[_id_D674D7970EEF9653.size] = ent;

    waitframe();
  }

  return _id_D674D7970EEF9653;
}

_id_F845480D763CE1A1(_id_F8E5E3AA5762A8E7) {
  _id_259CBB4537DFC975 = _id_AFCDBC5178CB5C04(_id_F8E5E3AA5762A8E7);
  _id_3DFDCC5DC839943F = [];

  if(isDefined(level._id_38E50D27B7AA5E9D[_id_F8E5E3AA5762A8E7.group_name])) {
    _id_81582FB2CC2429C8 = _id_003447161688A4A4(_id_F8E5E3AA5762A8E7);
    targetplayer = scripts\engine\utility::random(_id_81582FB2CC2429C8);
    destinations = level._id_38E50D27B7AA5E9D[_id_F8E5E3AA5762A8E7.group_name];

    if(!isDefined(targetplayer) || (!isDefined(_id_259CBB4537DFC975) || _id_259CBB4537DFC975 <= 0))
      _id_3DFDCC5DC839943F = [];
    else
      _id_3DFDCC5DC839943F = _id_C0DB8DDB89E44BCE(destinations, targetplayer.origin, _id_259CBB4537DFC975);
  } else {
    spawners = scripts\engine\utility::getStructArray(_id_F8E5E3AA5762A8E7.group_name, "targetname");
    spawners = scripts\engine\utility::array_randomize(spawners);

    if(spawners.size <= _id_259CBB4537DFC975)
      return spawners;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_259CBB4537DFC975; _id_AC0E594AC96AA3A8++)
      _id_3DFDCC5DC839943F[_id_3DFDCC5DC839943F.size] = spawners[_id_AC0E594AC96AA3A8];
  }

  return _id_3DFDCC5DC839943F;
}

_id_BC4EF206E692DE0A(group) {
  if(isDefined(self.spawner) && isDefined(self.spawner.target)) {
    _id_815D30728A6EF9D9 = scripts\engine\utility::getStruct(self.spawner.target, "targetname");

    if(isDefined(_id_815D30728A6EF9D9)) {
      self.goalradius = 128;
      self._id_9FF99CFC426066A2 = 128;
      self.combatmode = "no_cover";
      self setgoalpos(_id_815D30728A6EF9D9.origin);
    }
  }
}

_id_B018F6F46A6CD36A(group) {
  self.goalradius = 0;
  self._id_9FF99CFC426066A2 = 0;
  wait 1;
  closestplayer = scripts\engine\utility::getclosest(self.origin, level.players, 2048);

  if(isDefined(closestplayer) && isPlayer(closestplayer)) {
    self getenemyinfo(closestplayer);
    self.favoriteenemy = closestplayer;
  }

  _id_51A5A63AC735F21F(group);
}

_id_D976B5094996FFE8(group) {
  scripts\engine\utility::set_movement_speed(150);
  closestplayer = scripts\engine\utility::getclosest(self.origin, level.players, 2048);

  if(isDefined(closestplayer) && isPlayer(closestplayer)) {
    self getenemyinfo(closestplayer);
    self.favoriteenemy = closestplayer;
    self setgoalpos(closestplayer.origin);
  }

  if(group.group_name == "seq_intro_d")
    level thread _id_DACE4AB7D8A37574(self);
}

_id_DACE4AB7D8A37574(_id_E21279FA90BDF012) {
  level endon("game_ended");
  _id_E21279FA90BDF012 endon("death");
  trigger = getEnt("jugg_ground_stomp_trigger", "script_noteworthy");

  for(;;) {
    trigger waittill("trigger", _id_F770E9D1531ED3CD);

    if(_id_F770E9D1531ED3CD != _id_E21279FA90BDF012)
      continue;
  }

  _id_E21279FA90BDF012 playsoundonmovingent("evt_raid2_enemy_special_land");
}

_id_DBC16CC3078D23FF(group) {
  self.goalradius = 20;
  self._id_9FF99CFC426066A2 = 20;
  self.combatmode = "ambush";
  self.dont_enter_combat = 1;
  thread _id_78942AAFDAA59637(1024);
  thread _id_5C4325F409A1BA2C(1024);

  if(issubstr(group.group_name, "oldroom"))
    thread _id_628DB4B6FFBC5BB2();

  _id_51A5A63AC735F21F(group);
}

waittill_near_goal(origin, radius) {
  if(!isDefined(origin)) {
    return;
  }
  while(distancesquared(self.origin, origin) > radius)
    wait 0.1;
}

_id_8E922130A9978066(group) {
  if(isDefined(self.spawner) && isDefined(self.spawner.target)) {
    _id_815D30728A6EF9D9 = scripts\engine\utility::getStruct(self.spawner.target, "targetname");

    if(isDefined(_id_815D30728A6EF9D9)) {
      self.combatmode = "no_cover";
      self.goalradius = 8;
      self.script_radius = 8;
      self setgoalpos(self getclosestreachablepointonnavmesh(_id_815D30728A6EF9D9.origin));
      waittill_near_goal(_id_815D30728A6EF9D9.origin, squared(384));
      self.goalradius = 8;
      self.script_radius = 8;
      self.ignoreall = 1;
      self.allowpain = 0;
      self waittill("goal");
    }
  }

  self.ignoreall = 0;
  self.allowpain = 1;
  self.combatmode = "cover";
  _id_137CC0FFDF383E20 = scripts\engine\utility::getclosest(self.origin, level.players);

  if(isPlayer(_id_137CC0FFDF383E20)) {
    self.favoriteenemy = _id_137CC0FFDF383E20;
    self getenemyinfo(_id_137CC0FFDF383E20);
  }

  self.goalradius = 3000;
  self.script_radius = 3000;
  self setengagementmindist(0, 0);
  self setengagementmaxdist(0, 0);
  self _meth_9215CE6FC83759B9(3000);
  _id_51A5A63AC735F21F(group);
}

_id_01B0B2A4C814B7C7(group) {
  waitframe();
  _id_A664AAD02EE98BD2 = "molotov_mp";
  self.grenadeweapon = makeweapon(_id_A664AAD02EE98BD2);
  self.grenadeammo = 4;
  _id_51A5A63AC735F21F(group);
}

_id_B90ED11B0C5B274C(group) {
  waitframe();
  self.maxfaceenemydist = 768;
  self.dontevershoot = 1;
  self.ignoreall = 1;
  self.maxhealth = 250;
  self.health = self.maxhealth;
  self.wearing_armor = 1;
  self._id_AD799295A6692B29 = 1;
  self.dropweapon = 0;
  _id_694915C4828FF35A = scripts\engine\utility::getStruct(self.spawner.target, "targetname");
  thread _id_31EBE204ECA0D7E7(_id_694915C4828FF35A.origin);
}

_id_31EBE204ECA0D7E7(goal) {
  level endon("game_ended");
  self endon("death");
  scripts\engine\utility::set_movement_speed(150);
  self.goalradius = 128;
  self setgoalpos(goal);
  _id_443408A1A029FCA6 = scripts\engine\utility::getStruct("thermite_target", "script_noteworthy").origin;
  self waittill("goal");
  level _id_9A33973715DE0610(self.origin, _id_443408A1A029FCA6, self);
  level notify("thermite_thrown");
  self.maxfaceenemydist = 768;
  self.dontevershoot = 0;
  self.ignoreall = 0;
  wait 1;
}

_id_9A33973715DE0610(origin, target, ai) {
  level endon("game_ended");
  _id_87302D685DEA776E = float(getDvar("dvar_898AEA3B2E7D5561", 1));
  _id_51C1B45046E1647C = origin + (0, 0, 50);
  _id_7331D469160F6A41 = (target - _id_51C1B45046E1647C) * (_id_87302D685DEA776E, _id_87302D685DEA776E, _id_87302D685DEA776E);
  _id_65AB49AC224010E3 = magicgrenademanual("thermite_mp", _id_51C1B45046E1647C, _id_7331D469160F6A41, 2);
  _id_65AB49AC224010E3.owner = ai;
  ai thread scripts\cp\equipment\cp_thermite::thermite_used(_id_65AB49AC224010E3);
  _id_65AB49AC224010E3 waittill("death");
}

_id_3CD8D6737BD7B10B(group) {
  waitframe();
  self.maxfaceenemydist = 768;
  self.dontevershoot = 1;
  self.ignoreall = 1;
  self.maxhealth = 250;
  self.health = self.maxhealth;
  self.wearing_armor = 1;
  self._id_AD799295A6692B29 = 1;
  self.dropweapon = 0;
  level thread _id_7EDED8183295DFA9(self, group.group_name);

  switch (group.group_name) {
    case "keybearer_1":
      scripts\engine\utility::set_movement_speed(120);
      thread _id_8B66BB0E85A40C93();
      break;
    case "keybearer_2":
      scripts\engine\utility::set_movement_speed(100);
      thread _id_8B66BB0E85A40C93("keybearer2_door");
      thread _id_79823539CA298145::_id_5E933F689131666E();
      break;
    case "keybearer_3":
      scripts\engine\utility::set_movement_speed(100);
      thread _id_8B66BB0E85A40C93("keybearer3_door");
      break;
  }

  _id_694915C4828FF35A = scripts\engine\utility::getStruct(self.spawner.target, "targetname");
  self.goalradius = 128;
  self setgoalpos(_id_694915C4828FF35A.origin);
}

_id_8B66BB0E85A40C93(_id_D01D549602AD625D) {
  level endon("game_ended");

  if(isDefined(_id_D01D549602AD625D)) {
    _id_1E92D8D3755A9FF8 = scripts\engine\utility::getStruct(_id_D01D549602AD625D, "script_noteworthy");

    if(isDefined(_id_1E92D8D3755A9FF8))
      _id_18AF78602B67B70C::_id_887438C3B4B194B6(0, _id_1E92D8D3755A9FF8.origin);

    result = scripts\engine\utility::waittill_any_return_2("death", "goal");

    if(isDefined(_id_1E92D8D3755A9FF8))
      _id_18AF78602B67B70C::_id_887438C3B4B194B6(1, _id_1E92D8D3755A9FF8.origin);
  } else
    result = scripts\engine\utility::waittill_any_return_2("death", "goal");

  if(_id_C49E1ED35CC53031(self)) {
    self.maxfaceenemydist = 768;
    self.dontevershoot = 0;
    self.ignoreall = 0;
  } else {
    self notify("keybearer_reached_goal");
    level notify("keybearer_escaped");
    waitframe();
    self kill();
  }
}

_id_03E12320A4B71A96() {
  level endon("game_ended");
  trigger = getEnt("test_keycard_trigger", "targetname");
  droppoint = scripts\engine\utility::getStruct("test_keycard_drop", "targetname");
  _id_4D56A5BE03B9585F = ["interactable_note_keycard_a", "interactable_note_keycard_b", "interactable_note_keycard_c"];
  index = 0;

  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(0, droppoint.origin, droppoint.angles);
    item = _id_66122A002AFF5D57::spawnpickup(_id_4D56A5BE03B9585F[index], _id_CB4FAD49263E20C4, 1, 0, undefined, 0);
    level thread _id_91E8BF59BDBB9A6D(_id_4D56A5BE03B9585F[index]);
    index++;

    if(index > 2)
      index = 0;

    wait 3;
  }
}

_id_7EDED8183295DFA9(ai, groupname) {
  level endon("game_ended");
  ai endon("keybearer_reached_goal");
  ai waittill("death");
  _id_920F4173513EB6B8 = "interactable_note_keycard_a";

  switch (groupname) {
    case "keybearer_1":
    default:
      _id_920F4173513EB6B8 = "interactable_note_keycard_a";
      break;
    case "keybearer_2":
      _id_920F4173513EB6B8 = "interactable_note_keycard_b";
      break;
    case "keybearer_3":
      _id_920F4173513EB6B8 = "interactable_note_keycard_c";
      break;
  }

  _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(0, ai.origin, ai.angles, ai);
  item = _id_66122A002AFF5D57::spawnpickup(_id_920F4173513EB6B8, _id_CB4FAD49263E20C4, 1, 0, undefined, 0);
  level thread _id_91E8BF59BDBB9A6D(_id_920F4173513EB6B8);
}

_id_4C0D9FDA8D7884E8(player, _id_9B12648B9F250B9C) {
  _id_6EF4FD3894A9F0A2 = _id_9B12648B9F250B9C.scriptablename;

  if(isDefined(_id_78547FBB6C0083E0::_id_1378F1533E0BCFB9(player))) {
    thread scripts\cp\cp_hud_message::tutorialprint(&"CP_TRAP_ROOM/HAS_KEYCARD_ALREADY", 2);
    self playlocalsound("br_pickup_deny");
    return 4;
  } else
    return 20;
}

_id_91E8BF59BDBB9A6D(key, _id_5B30935A93682242) {
  level endon("game_ended");

  for(;;) {
    level waittill("pickedup_loot_success", _id_5BA045294C1D4D1B, player);

    if(!isPlayer(player) || key != _id_5BA045294C1D4D1B) {
      waitframe();
      continue;
    }

    if(!istrue(_id_5B30935A93682242))
      player thread _id_79823539CA298145::_id_3B16F8CFD0F7972E(_id_5BA045294C1D4D1B);

    player thread _id_1E337E98B672B9EA(_id_5BA045294C1D4D1B);
    player thread _id_CBDA750AA59E94C9(_id_5BA045294C1D4D1B);
  }
}

_id_1E337E98B672B9EA(_id_5BA045294C1D4D1B) {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("dropped_backpack_item", _id_76F4143215683892);

  if(_id_76F4143215683892.type == _id_5BA045294C1D4D1B) {
    self notify("dropped_keycard");
    level thread _id_91E8BF59BDBB9A6D(_id_76F4143215683892.type, 1);
  }
}

_id_CBDA750AA59E94C9(_id_5BA045294C1D4D1B) {
  level endon("game_ended");
  level endon("topdoor_opened");
  self endon("dropped_keycard");
  scripts\engine\utility::waittill_any_3("laststand", "death", "entered_spectate");
  _id_55C80BAE27E47104 = _id_66122A002AFF5D57::_id_F8D85C542911E3A9(self, _id_5BA045294C1D4D1B);

  if(!isDefined(_id_55C80BAE27E47104)) {
    return;
  }
  _id_531CB1BE084314F7::_id_DB1DD76061352E5B(_id_55C80BAE27E47104, 1);
  thread scripts\cp\cp_hud_message::tutorialprint(&"CP_TRAP_ROOM/KEYCARD_RUINED", 2);
  level notify("topkeycard_destroyed");
}

_id_C49E1ED35CC53031(ai) {
  foreach(player in level.players) {
    if(_id_19B2AC035D02BEB8(player) || _id_E7C30095A6CDC3EF(player, ai))
      return 1;
  }

  return 0;
}

_id_E7C30095A6CDC3EF(player, ent) {
  if(!isDefined(player)) {
    return;
  }
  _id_7FE710B31B2B752D = player gettagorigin("tag_eye");
  _id_70222FBC47330166 = anglesToForward(player getplayerangles());
  _id_7636B8DC247C7CB4 = _id_7FE710B31B2B752D + _id_70222FBC47330166 * 20000;
  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_ainosight"]);
  trace = scripts\engine\trace::ray_trace(_id_7FE710B31B2B752D, _id_7636B8DC247C7CB4, undefined, contents);

  if(isDefined(trace["entity"]) && trace["entity"] == ent)
    return 1;
  else
    return 0;
}

_id_3D22426B1249BFAE(group) {
  waitframe();
  self _meth_9215CE6FC83759B9(3000);
  self._id_C833409FB72D15FB = 0;
  closestplayer = scripts\engine\utility::getclosest(self.origin, level.players, 2048);

  if(isDefined(closestplayer) && isalive(closestplayer))
    self getenemyinfo(closestplayer);

  if(!scripts\cp\utility::isjuggernaut()) {
    self.goalradius = 256;
    self setgoalentity(closestplayer);
    self setengagementmindist(256, 256);
    self setengagementmaxdist(256, 256);
  }
}

_id_579695C3D721F954(_id_E21279FA90BDF012) {
  level endon("game_ended");
  _id_E21279FA90BDF012 waittill("death");
  droppoint = _id_E21279FA90BDF012.origin;
  keycard = spawn("script_model", droppoint);
  keycard setModel("electronics_keycard_office_01");
  wait 5;
  keycard physicslaunchserver(droppoint, (5, 0, 20));
  keycard thread _id_16591A48F7D6F223::_id_9553BBBE653D6B53();
}

_id_B057BDD9791F64C2(group) {
  self.maxsightdistsqrd = 65536;
  self.baseaccuracy = 0.5;
  self.goalradius = 32;
  self setengagementmindist(256, 0);
  self setengagementmaxdist(768, 2048);
  self _meth_9215CE6FC83759B9(2000);
  thread _id_78942AAFDAA59637(2048);
  thread _id_5C4325F409A1BA2C(2048);
}

_id_628DB4B6FFBC5BB2() {
  level endon("game_ended");
  self endon("death");
  self endon("alerted_to_player");
  _id_7287EC98AAFB0427 = 250;
  _id_13F1BE1E7558643A = 130;

  for(;;) {
    playerlist = level.players;

    foreach(player in playerlist) {
      if(abs(player.origin[2] - self.origin[2]) <= _id_13F1BE1E7558643A) {
        self.goalradius = _id_7287EC98AAFB0427;
        self._id_9FF99CFC426066A2 = _id_7287EC98AAFB0427;
        self.dont_enter_combat = 0;
        self.combatmode = "no_cover";
        self.favoriteenemy = player;
        self getenemyinfo(player);
        self setgoalentity(player);
        self notify("alerted_to_player");
        return;
      }
    }

    wait 0.1;
  }
}

_id_78942AAFDAA59637(_id_7287EC98AAFB0427) {
  level endon("game_ended");
  self endon("death");
  self endon("alerted_to_player");

  if(!isDefined(_id_7287EC98AAFB0427))
    _id_7287EC98AAFB0427 = 250;

  for(;;) {
    playerlist = level.players;

    foreach(player in playerlist) {
      if(_id_19B2AC035D02BEB8(player)) {
        self.goalradius = _id_7287EC98AAFB0427;
        self._id_9FF99CFC426066A2 = _id_7287EC98AAFB0427;
        self.dont_enter_combat = 0;
        self.combatmode = "cover";
        self.favoriteenemy = player;
        self getenemyinfo(player);
        self setgoalentity(player);
        self notify("alerted_to_player");
        return;
      }
    }

    wait 0.1;
  }
}

_id_19B2AC035D02BEB8(player) {
  _id_ECE9C1126186017B = distance(player.origin, self.origin) <= 512;
  _id_30068470264CDE43 = self cansee(player);
  return _id_ECE9C1126186017B && _id_30068470264CDE43;
}

_id_5C4325F409A1BA2C(_id_7287EC98AAFB0427) {
  level endon("game_ended");
  self endon("death");
  self endon("alerted_to_player");
  self waittill("damage", idamage, eattacker);

  if(!isDefined(_id_7287EC98AAFB0427))
    _id_7287EC98AAFB0427 = 2048;

  self.goalradius = _id_7287EC98AAFB0427;
  self._id_9FF99CFC426066A2 = _id_7287EC98AAFB0427;
  self.dont_enter_combat = 0;

  if(isPlayer(eattacker)) {
    self.favoriteenemy = eattacker;
    self getenemyinfo(eattacker);
    self setgoalentity(eattacker);
  }

  self.combatmode = "cover";
}

_id_046ED662485EA221(agent) {
  if(istrue(agent._id_102A9D2CF99AB325)) {
    return;
  }
  agent._id_65771500F49956C1 = 1;
  agent._id_102A9D2CF99AB325 = 1;
  agent attach("hat_child_hadir_gas_mask_wm_br", "j_head");
  agent._id_CD6A3A50F09688B9 = ::_id_6950EC92C0AB0545;
}

_id_6950EC92C0AB0545(agent, attacker) {
  agent detach("hat_child_hadir_gas_mask_wm_br", "j_head");
  agent._id_65771500F49956C1 = 0;
  _id_24FBEDBA9A7A1EF4::_id_59EA6B2F800CB082(agent, attacker);
}

_id_5E2626E8DB4DC57C(group) {
  scripts\stealth\enemy::init_settings();
  event = spawnStruct();
  event.typeorig = "combat";
  event.type = "combat";
  groupname = group.group_name;
  _id_12729FF62E52ED4D = [];
  _id_19857805B46FEB0D = undefined;

  if(issubstr(groupname, "_a")) {
    _id_12729FF62E52ED4D = _id_544C706A83CA9086("a");
    _id_19857805B46FEB0D = scripts\engine\utility::getStruct("side_a_center", "script_noteworthy").origin;
  } else if(issubstr(groupname, "_b")) {
    _id_12729FF62E52ED4D = _id_544C706A83CA9086("b");
    _id_19857805B46FEB0D = scripts\engine\utility::getStruct("side_b_center", "script_noteworthy").origin;
  }

  if(_id_12729FF62E52ED4D.size > 0) {
    targetplayer = scripts\engine\utility::random(_id_12729FF62E52ED4D);
    self getenemyinfo(targetplayer);
    self setthreatsight(targetplayer, 1);
    event.origin = targetplayer.origin;
    event.investigate_pos = targetplayer.origin;
  } else {
    event.origin = _id_19857805B46FEB0D;
    event.investigate_pos = _id_19857805B46FEB0D;
  }

  self.goalradius = 512;
  self[[self.fnsetstealthstate]]("combat", event);
}

increase_max_count_per_kill(_id_F8E5E3AA5762A8E7, _id_861BE59C011E535E, _id_580B3B60AA841FF3) {
  return int(_id_F8E5E3AA5762A8E7.currentmodulekills * _id_580B3B60AA841FF3) + _id_861BE59C011E535E;
}

_id_A249B3CAB6A37673() {
  _id_414DDA4CABF358AF = getEnt("trap_room", "targetname");
  _id_3162B66AFCCFC0D5 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    triggering_ent = level.players[_id_AC0E594AC96AA3A8];

    if(triggering_ent istouching(_id_414DDA4CABF358AF) && triggering_ent scripts\cp\utility::is_valid_player(1))
      _id_3162B66AFCCFC0D5[_id_3162B66AFCCFC0D5.size] = level.players[_id_AC0E594AC96AA3A8];
  }

  return _id_3162B66AFCCFC0D5;
}

_id_DEC3407B80682CF2(_id_A66BA9B157533F5A) {
  volumes = [];

  if(_id_A66BA9B157533F5A == "a" || _id_A66BA9B157533F5A == "side_a")
    volumes = getEntArray("side_a", "targetname");
  else if(_id_A66BA9B157533F5A == "b" || _id_A66BA9B157533F5A == "side_b")
    volumes = getEntArray("side_b", "targetname");

  _id_9DC58ECEF5B19FF9 = [];
  _id_CD207438E3E764E6 = getaiarray("axis");

  foreach(ai in _id_CD207438E3E764E6) {
    foreach(volume in volumes) {
      if(isalive(ai) && ai istouching(volume) && !scripts\engine\utility::array_contains(_id_9DC58ECEF5B19FF9, ai))
        _id_9DC58ECEF5B19FF9[_id_9DC58ECEF5B19FF9.size] = ai;
    }
  }

  return _id_9DC58ECEF5B19FF9;
}

_id_544C706A83CA9086(_id_A66BA9B157533F5A) {
  volumes = [];

  if(_id_A66BA9B157533F5A == "a" || _id_A66BA9B157533F5A == "side_a")
    volumes = getEntArray("side_a", "targetname");
  else if(_id_A66BA9B157533F5A == "b" || _id_A66BA9B157533F5A == "side_b")
    volumes = getEntArray("side_a", "targetname");

  _id_64E10CE374AB22E3 = [];

  foreach(player in level.players) {
    foreach(volume in volumes) {
      if(player istouching(volume) && !scripts\engine\utility::array_contains(_id_64E10CE374AB22E3, player))
        _id_64E10CE374AB22E3[_id_64E10CE374AB22E3.size] = player;
    }
  }

  return _id_64E10CE374AB22E3;
}

_id_E4E8395176F82C74(_id_6ECF5A5F826643CB, _id_451EBBF6C53EDC68) {
  volumes = getEntArray(_id_6ECF5A5F826643CB, "targetname");
  _id_479133BF47196D28 = 0;

  while(!istrue(_id_479133BF47196D28)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < volumes.size; _id_AC0E594AC96AA3A8++) {
      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < level.players.size; _id_AC0E5C4AC96AAA41++) {
        if(level.players[_id_AC0E5C4AC96AAA41] istouching(volumes[_id_AC0E594AC96AA3A8]))
          _id_479133BF47196D28 = 1;
      }
    }

    wait(_id_451EBBF6C53EDC68);
  }
}

are_players_in_volume(_id_F8E5E3AA5762A8E7) {
  _id_39A176A3008F2304 = _id_003447161688A4A4(_id_F8E5E3AA5762A8E7);

  if(isDefined(_id_39A176A3008F2304) && _id_39A176A3008F2304.size > 0)
    return 1;
  else
    return 0;
}

_id_003447161688A4A4(_id_F8E5E3AA5762A8E7) {
  data = get_wave_data(_id_F8E5E3AA5762A8E7);

  if(!isDefined(data))
    return [];

  _id_1F9393BC6753D350 = getEntArray(data.trigger, "targetname");
  _id_479133BF47196D28 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1F9393BC6753D350.size; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < level.players.size; _id_AC0E5C4AC96AAA41++) {
      if(level.players[_id_AC0E5C4AC96AAA41] istouching(_id_1F9393BC6753D350[_id_AC0E594AC96AA3A8]))
        _id_479133BF47196D28[_id_479133BF47196D28.size] = level.players[_id_AC0E5C4AC96AAA41];
    }
  }

  return _id_479133BF47196D28;
}

get_wave_data(_id_F8E5E3AA5762A8E7) {
  tier = _id_3A864E6F5D874675();

  if(!isDefined(level.trap_room_wave_settings[_id_F8E5E3AA5762A8E7.group_name][tier]))
    return undefined;
  else
    return level.trap_room_wave_settings[_id_F8E5E3AA5762A8E7.group_name][tier];
}

_id_8147054DB47AF43C() {
  level._id_5F6D7C9AB8032014 = 1;
}

_id_B3FD2845FD414E11(_id_4023BE37E4783071) {
  level._id_5F6D7C9AB8032014 = _id_4023BE37E4783071;

  if(level._id_5F6D7C9AB8032014 > 6)
    level._id_5F6D7C9AB8032014 = 6;

  if(level._id_5F6D7C9AB8032014 < 1)
    level._id_5F6D7C9AB8032014 = 1;
}

_id_4EEC65C94E0AB667() {
  if(!isDefined(level._id_5F6D7C9AB8032014))
    level._id_5F6D7C9AB8032014 = 1;

  level._id_5F6D7C9AB8032014++;

  if(level._id_5F6D7C9AB8032014 > 6)
    level._id_5F6D7C9AB8032014 = 6;
}

_id_3A864E6F5D874675() {
  if(!isDefined(level._id_5F6D7C9AB8032014))
    level._id_5F6D7C9AB8032014 = 1;

  return level._id_5F6D7C9AB8032014;
}

get_module_call_count(_id_F8E5E3AA5762A8E7) {
  if(!isDefined(level.module_call_counter))
    return undefined;

  if(!isDefined(level.module_call_counter[_id_F8E5E3AA5762A8E7.group_name]))
    return undefined;

  return level.module_call_counter[_id_F8E5E3AA5762A8E7.group_name];
}

init_trap_room_wave(_id_CA8D3101C7736449, _id_FFA37BAD3D0EEDBD, aitypes, aitype_counts, max_spawns, trigger) {
  if(!isDefined(level.trap_room_wave_settings))
    level.trap_room_wave_settings = [];

  if(!isDefined(level.trap_room_wave_settings[_id_CA8D3101C7736449]))
    level.trap_room_wave_settings[_id_CA8D3101C7736449] = [];

  if(!isDefined(level.trap_room_wave_settings[_id_CA8D3101C7736449][_id_FFA37BAD3D0EEDBD]))
    level.trap_room_wave_settings[_id_CA8D3101C7736449][_id_FFA37BAD3D0EEDBD] = spawnStruct();

  struct = level.trap_room_wave_settings[_id_CA8D3101C7736449][_id_FFA37BAD3D0EEDBD];
  struct.aitypes = aitypes;
  struct.aitype_counts = aitype_counts;
  struct.total_spawns = scripts\engine\utility::array_sum(aitype_counts);
  struct.max_spawns = max_spawns;
  struct.trigger = trigger;
  level.trap_room_wave_settings[_id_CA8D3101C7736449][_id_FFA37BAD3D0EEDBD] = struct;
}

_id_C1E6B81F3E693135(_id_2A3FADA93E84DE98) {
  level endon("game_ended");
  level endon("trap_room_complete");

  if(istrue(level._id_80F70367C00E7D33)) {
    return;
  }
  if(!istrue(_id_2A3FADA93E84DE98) && getdvarint("dvar_F0F10B52A800D290", 0) > 0) {
    scripts\engine\utility::flag_set("start_trap_room_combat");
    return;
  }

  level._id_80F70367C00E7D33 = 1;
  _id_18A73A64992DD07D::stop_module_by_groupname("trap_room_initial_spawning");
  scripts\engine\utility::flag_set("start_trap_room_combat");
  level thread _id_3DB288A01C68E90B();
  level thread _id_A7C6FF731F27852D();
  level thread _id_A7C6FC731F277E94();
}

_id_3DB288A01C68E90B() {
  level endon("trap_room_complete");
  level endon("stop_trap_room_ambient_spawning");
  level endon("game_ended");

  if(getdvarint("dvar_CA0F7A9EAE7CD4CC", 0) > 0) {
    return;
  }
  if(istrue(level._id_FEB5759B57B1E923)) {
    return;
  }
  level._id_FEB5759B57B1E923 = 1;
  scripts\engine\utility::flag_wait("start_trap_room_combat");
  _id_15CA06DD9E32849E = getEntArray("side_a", "targetname");
  _id_81503EDD3735B37B = getEntArray("side_b", "targetname");

  for(;;) {
    _id_EF5498B4775016F5 = _id_16591A48F7D6F223::_id_E92B4CEEDE125AE7(_id_15CA06DD9E32849E);
    _id_EF5495B47750105C = _id_16591A48F7D6F223::_id_E92B4CEEDE125AE7(_id_81503EDD3735B37B);

    if(_id_EF5498B4775016F5 >= 1 && _id_EF5495B47750105C == 0)
      _id_B3FD2845FD414E11(1);
    else if(_id_EF5498B4775016F5 >= 2 && _id_EF5495B47750105C == 1)
      _id_B3FD2845FD414E11(2);
    else if(_id_EF5498B4775016F5 == 1 && _id_EF5495B47750105C == 1)
      _id_B3FD2845FD414E11(3);
    else if(_id_EF5498B4775016F5 == 1 && _id_EF5495B47750105C >= 2)
      _id_B3FD2845FD414E11(4);
    else if(_id_EF5498B4775016F5 == 0 && _id_EF5495B47750105C == 2)
      _id_B3FD2845FD414E11(5);
    else if(_id_EF5498B4775016F5 == 0 && _id_EF5495B47750105C > 2)
      _id_B3FD2845FD414E11(6);

    wait 2;
  }
}

_id_908561DCB5D29464() {
  level endon("game_ended");
  level notify("vo_player_in_trap_room");
  level endon("trap_room_complete");

  for(;;) {
    scripts\engine\utility::flag_wait("any_player_in_trap_room");
    wait 7;

    if(!scripts\engine\utility::flag("any_player_in_trap_room")) {
      continue;
    }
    _id_EBA39FED1290F0AA = _id_A249B3CAB6A37673();
    _id_EF5498B4775016F5 = _id_544C706A83CA9086("a");

    if(_id_EBA39FED1290F0AA.size >= 2 && _id_EF5498B4775016F5.size == 1) {
      _id_4275E487B0FD0E84();
      wait 20;
    }

    scripts\engine\utility::flag_waitopen("any_player_in_trap_room");
  }
}

_id_4275E487B0FD0E84() {
  _id_18A73A64992DD07D::run_spawn_module("punishment_wave");
}

_id_1757160773AA5313(_id_806955C1D41F65AA) {
  volumes = getEntArray(_id_806955C1D41F65AA, "targetname");
  _id_2DBC7C5305828A30 = getaiarray("axis");
  _id_413D29DD8AD999A7 = [];

  foreach(enemy in _id_2DBC7C5305828A30) {
    foreach(volume in volumes) {
      if(enemy istouching(volume)) {
        _id_413D29DD8AD999A7[_id_413D29DD8AD999A7.size] = enemy;
        break;
      }
    }
  }

  return _id_413D29DD8AD999A7.size;
}

_id_A7C6FF731F27852D() {
  level endon("game_ended");
  level endon("trap_room_enraged");
  level endon("trap_room_complete");
  level endon("stop_trap_room_ambient_spawning");
  _id_E4E8395176F82C74("side_a", 2);
  wait 3;
  _id_26B0E4F14D4C062E = ["filler_a", "jugg_a", "bomber_a", "rpg_a", "sniper_a", "shield_a"];

  for(;;) {
    level thread _id_599F7FAC1840A189(_id_26B0E4F14D4C062E);
    wait 8;
    _id_8A52520CE1A05C16 = _id_1757160773AA5313("side_a");

    while(_id_8A52520CE1A05C16 > 2) {
      _id_8A52520CE1A05C16 = _id_1757160773AA5313("side_a");
      wait 2;
    }

    _id_FC3B274A006AAB2A("side_a");
    wait 1;
  }
}

_id_A7C6FC731F277E94() {
  level endon("game_ended");
  level endon("trap_room_enraged");
  level endon("trap_room_complete");
  level endon("stop_trap_room_ambient_spawning");
  _id_E4E8395176F82C74("side_b", 2);
  _id_26B0E4F14D4C062E = ["filler_b", "jugg_b", "bomber_b", "rpg_b", "sniper_b", "shield_b"];
  wait 3;

  for(;;) {
    level thread _id_599F7FAC1840A189(_id_26B0E4F14D4C062E);
    wait 8;
    _id_8A52520CE1A05C16 = _id_1757160773AA5313("side_b");

    while(_id_8A52520CE1A05C16 > 2) {
      _id_8A52520CE1A05C16 = _id_1757160773AA5313("side_b");
      wait 2;
    }

    _id_FC3B274A006AAB2A("side_b");
    wait 1;
  }
}

_id_FC3B274A006AAB2A(_id_A66BA9B157533F5A) {
  level endon("game_ended");
  starttime = gettime();
  _id_EBE449EF11800E8D = starttime + 30000;
  _id_3BFDD53D76EA0F21 = starttime + 44000;
  _id_1BB79CA0D4FE1ADB = starttime + 37000;
  _id_24739E16733B36AD = starttime + 30000;
  endtimes = [_id_EBE449EF11800E8D, _id_3BFDD53D76EA0F21, _id_1BB79CA0D4FE1ADB, _id_24739E16733B36AD];
  _id_27E418445F44962C = 0;

  while(!istrue(_id_27E418445F44962C)) {
    _id_7B16B71F3113D26D = _id_544C706A83CA9086(_id_A66BA9B157533F5A).size;
    _id_7B16B71F3113D26D = int(clamp(_id_7B16B71F3113D26D, 0, 3));

    if(gettime() >= endtimes[_id_7B16B71F3113D26D])
      _id_27E418445F44962C = 1;

    wait 1;
  }
}

_id_210CED908491EC0A(mintime, totaltime, _id_AA317BF0FFEB0EA0) {
  level endon("game_ended");
  starttime = gettime();
  msg = level scripts\engine\utility::waittill_notify_or_timeout_return(_id_AA317BF0FFEB0EA0, mintime);

  if(msg != "timeout")
    totaltime = mintime;

  _id_54B6734298090B6F = gettime() - starttime;
  _id_3AF29042E14DCAC9 = int(_id_54B6734298090B6F / 1000);
  timeremaining = totaltime - _id_3AF29042E14DCAC9;

  if(timeremaining <= 0)
    return;
  else
    wait(timeremaining);
}

_id_599F7FAC1840A189(_id_26B0E4F14D4C062E) {
  _id_0611607BF73E7C79 = 0;
  _id_06115D7BF73E75E0 = 0;

  foreach(_id_F564CE57BB79FF69 in _id_26B0E4F14D4C062E) {
    _id_18A73A64992DD07D::stop_module_by_groupname(_id_F564CE57BB79FF69);
    waitframe();
    _id_F8E5E3AA5762A8E7 = _id_18A73A64992DD07D::get_module_struct_from_level(_id_F564CE57BB79FF69);

    if(_id_0CD68A61419FD07A(_id_F8E5E3AA5762A8E7) && are_players_in_volume(_id_F8E5E3AA5762A8E7)) {
      if(istrue(issubstr(_id_F564CE57BB79FF69, "_a")))
        _id_0611607BF73E7C79 = 0;
      else
        _id_06115D7BF73E75E0 = 0;

      _id_18A73A64992DD07D::run_spawn_module(_id_F564CE57BB79FF69);
    }
  }

  if(istrue(_id_0611607BF73E7C79)) {
    pos = scripts\engine\utility::getStruct("side_a_alarm", "script_noteworthy").origin;
    thread scripts\cp\utility::playsoundatpos_safe(pos, "emt_alarm_power_button");
  }

  if(istrue(_id_06115D7BF73E75E0)) {
    pos = scripts\engine\utility::getStruct("side_b_alarm", "script_noteworthy").origin;
    thread scripts\cp\utility::playsoundatpos_safe(pos, "emt_alarm_power_button");
  }
}

_id_7A06712741326A05() {
  level endon("game_ended");

  if(getdvarint("dvar_F0F10B52A800D290", 0) > 0) {
    return;
  }
  _id_26B0E4F14D4C062E = ["filler_b", "jugg_b", "shield_b"];
  level notify("stop_trap_room_ambient_spawning");
  waitframe();
  _id_B3FD2845FD414E11(6);

  foreach(_id_F564CE57BB79FF69 in _id_26B0E4F14D4C062E) {
    _id_18A73A64992DD07D::stop_module_by_groupname(_id_F564CE57BB79FF69);
    waitframe();
    _id_F8E5E3AA5762A8E7 = _id_18A73A64992DD07D::get_module_struct_from_level(_id_F564CE57BB79FF69);

    if(_id_0CD68A61419FD07A(_id_F8E5E3AA5762A8E7))
      _id_18A73A64992DD07D::run_spawn_module(_id_F564CE57BB79FF69);
  }

  pos = scripts\engine\utility::getStruct("side_b_alarm", "script_noteworthy").origin;
  thread scripts\cp\utility::playsoundatpos_safe(pos, "emt_alarm_power_button");
}

_id_489530F7D409592C() {
  if(getdvarint("dvar_F0F10B52A800D290", 0) > 0) {
    return;
  }
  if(getdvarint("dvar_CA0F7A9EAE7CD4CC", 0) > 0) {
    return;
  }
  wait 7;
  _id_18A73A64992DD07D::run_spawn_module("trap_room_initial_spawning");
}

_id_3A25D778FB70B212() {
  _id_4E315593F65CB37C = getEntArray("spawn_elevator", "targetname");
  _id_9A6BA9F5A0E705C7 = 1;

  foreach(_id_D167B380D9850069 in _id_4E315593F65CB37C) {
    _id_D167B380D9850069.script_noteworthy = "spawn_elevator_" + _id_9A6BA9F5A0E705C7;
    _id_9A6BA9F5A0E705C7++;
  }
}

_id_51A5A63AC735F21F(group) {
  groupname = group.group_name;

  if(isDefined(groupname)) {
    _id_67F14F8315CB0F2F = strtok(groupname, "_");

    if(_id_67F14F8315CB0F2F[0] == "outro")
      _id_046ED662485EA221(self);
  }
}