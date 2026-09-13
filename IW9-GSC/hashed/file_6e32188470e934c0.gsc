/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6e32188470e934c0.gsc
***********************************************/

_id_99D88F8F3450C7D3(objectivestruct) {
  _id_60008A9093C7A9B5::_id_D3CB8E66A665F324();
  thread _id_63325153465F8869::_id_06A45861DDC5FDD4();
  thread _id_63325153465F8869::_id_FFEC324BD5085987();
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("raise_water_1");

  if(scripts\cp\cp_checkpoint::_id_9EED75023A958C18() != "b1_p1") {
    scripts\cp\cp_checkpoint::checkpoint_set("b1_p0");

    if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
      _id_2E9261330FBCEC80 = scripts\engine\utility::getStructArray("b1_p0_playerstart", "targetname");
      _id_0AFB7E332AEE4BF2::_id_79DDAC0EF09B8D0F(_id_2E9261330FBCEC80, 0);
    }
  }

  level thread _id_01B1A46EFB26E5A9::_id_E00BA90C8FAF1451();
  _id_382959D7794736CC::_id_D68D0E8E5202A02A("pristine");
  _id_382959D7794736CC::_id_E458190349EE6968();
  scripts\engine\utility::flag_init("manualoverride");
  scripts\engine\utility::flag_wait("subarea_ready");
  level thread _id_382959D7794736CC::_id_0C735D60735EDA5F();
  level._id_58D3D7CC1F3D2A37 = undefined;
  level thread _id_24D3D5C5A0521C72::_id_8CE8975F5D76A5CF();
  scripts\cp\cp_spawning_util::_id_5EBBD91D2F142DBC();
  _id_63BA37D826ED10D6 = getEntArray("spawn_door_monitor", "targetname");
  scripts\engine\utility::array_thread(_id_63BA37D826ED10D6, _id_382959D7794736CC::_id_E8BA0B0361B31FDC);
  _id_60008A9093C7A9B5::_id_7624BFD29CC1CB18();
  level._id_E2958F412A7425C0 = _id_382959D7794736CC::_id_C9A7AC016440B3C0();
  level._id_E2958F412A7425C0 thread _id_13FFCCF97A3E3294::_id_D686CFE6F2435D1F("flood_bay", "bay_flooded");
  _id_A5516703B3F7D1FF = "devgui_cmd \"Level:0 / Debug / Skip Secondary Pump Step\" \"set scr_skipsecondarypump 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"Level:0 / Debug / Spawn GL Turret\" \"set scr_spawnglturret 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_82CD563E25B04A17();
  _id_594132FAB60AA90D::_id_246582E2CB860BCD();
  thread _id_13FFCCF97A3E3294::_id_9580ECCE8D201C4F();
  _id_678ADBED602DA5EB::_id_BCE89A6DE8A052AF();
  level thread _id_1922F683D2FE270B();
  level thread _id_382959D7794736CC::_id_5BFBD6454C40219F();
  level thread _id_5734778D7F1B6E6F();
  level thread _id_382959D7794736CC::_id_2220614448CCF940();
  level thread _id_031C9179F5060A17::_id_0FF1D3ACD85657B7();
  level thread _id_3CAFE6589322F6E0();
  level thread _id_509C71310F742737();
  level thread _id_D9CE237F384CCE02();
  scripts\engine\utility::flag_wait("bay_flooded");
  thread _id_382959D7794736CC::_id_148E44373E8EE372();
  scripts\engine\utility::flag_set("p0_finished");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("raise_water_1");
  scripts\cp\cp_checkpoint::checkpoint_set("b1_p1");
}

_id_5734778D7F1B6E6F() {
  if(!istrue(level._id_5734778D7F1B6E6F)) {
    level._id_867AD728DC373F89 = 1;
    _id_A5516703B3F7D1FF = "devgui_cmd \"Level:0 / Debug / Skip Manual Override\" \"set scr_skipmanualoverride 1\" \n";
    scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  }

  _id_558A9A418B2D3405::_id_D8CC0613A4D4C3E1();
  button = getEnt("manualoverride", "targetname");
  light = getEnt("override_active_light", "targetname");
  button.light = light;
  level thread _id_5CCB83745E23886E();
  button makeusable();
  button sethintdisplayrange(128);
  button setCursorHint("HINT_BUTTON");
  button sethintdisplayfov(65);
  button sethintonobstruction("show");
  button setuseholdduration("duration_none");
  button setHintString(&"CP_RAID1_BOSS1/CANT_USE");
  button sethintinoperable(1);

  while(!scripts\engine\utility::flag_exist("p1_finished"))
    wait 1;

  scripts\engine\utility::flag_wait("p1_finished");
  button sethintinoperable(0);
  button setHintString(&"CP_RAID1_BOSS1/OVERRIDE_ON");
  button waittill("trigger", ent);
  button makeunusable();
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(ent, "plyr_platforms", 1, 1);
  _id_54E38BC53ABC8A5E = scripts\cp_mp\anim_scene::anim_scene_create_actor(button, "platforms_button", 0, 0);
  actors = [actorplayer, _id_54E38BC53ABC8A5E];
  playsoundatpos(ent.origin, "cp_raid3_platform_console_fly");
  playsoundatpos(button.origin, "cp_raid3_platform_console_button");
  button scripts\cp_mp\anim_scene::anim_scene(actors, "button_press", 1, 1);
  button.light setModel("electronics_elevator_security_lock_console_a_green_light_on");
  button setModel("electrical_cell_door_button_green");
  scripts\engine\utility::flag_set("manualoverride");
}

_id_5CCB83745E23886E() {
  for(;;) {
    if(getdvarint("dvar_CB73E387FA890A56", 0) > 0) {
      _id_382959D7794736CC::_id_AC901BAA09661D94(&"CP_RAID1_BOSS1/P0_BILGEPUMPS_DISABLED");
      scripts\engine\utility::flag_set("manualoverride");
      setDvar("dvar_CB73E387FA890A56", 0);
    }

    wait 1;
  }
}

_id_3CAFE6589322F6E0() {
  _id_64569EB1053934A6 = getEnt("p0_prime_valve_l", "targetname");
  _id_6456B8B105396DD4 = getEnt("p0_prime_valve_r", "targetname");
  _id_ADEA919C93F885C1 = getEnt("left_p0_needle_indicator", "targetname");
  _id_ADEA7B9C93F8555F = getEnt("right_p0_needle_indicator", "targetname");
  _id_34A8289F11E9D64D = getEnt("water_pump_needle_left_p0", "targetname");
  _id_34A80A9F11E99453 = getEnt("water_pump_needle_right_p0", "targetname");
  _id_DEBA44F65F3CE69D = getEnt("water_pump_switch_p0", "targetname");
  _id_64569EB1053934A6.angles = (0, 0, 90);
  _id_6456B8B105396DD4.angles = (0, 0, 90);
  _id_DEBA44F65F3CE69D scripts\cp\utility::sethintobject("tag_origin", "HINT_BUTTON", undefined, &"CP_RAID1_BOSS1/ACTIVATE_PUMP", undefined, "duration_none", "show", 150, 35, 72, 45);
  _id_64569EB1053934A6 scripts\cp\utility::sethintobject("tag_origin", "HINT_BUTTON", undefined, &"CP_RAID1_BOSS1/INCREASE_WATER_PRESSURE", undefined, "duration_none", "hide", 150, 35, 35, 45);
  _id_6456B8B105396DD4 scripts\cp\utility::sethintobject("tag_origin", "HINT_BUTTON", undefined, &"CP_RAID1_BOSS1/INCREASE_WATER_PRESSURE", undefined, "duration_none", "hide", 150, 35, 35, 45);
  _id_ADEA919C93F885C1 setModel("electronics_elevator_security_lock_console_a_green_light_off");
  _id_ADEA7B9C93F8555F setModel("electronics_elevator_security_lock_console_a_green_light_off");
  _id_64569EB1053934A6.cooldowntime = 0.15;
  _id_6456B8B105396DD4.cooldowntime = 0.15;
  _id_64569EB1053934A6._id_CF70FB0CAB5AB856 = getdvarfloat("dvar_7DF601472B590831", 3);
  _id_6456B8B105396DD4._id_CF70FB0CAB5AB856 = getdvarfloat("dvar_7DF601472B590831", 3);
  _id_29235AC6D41F67B8 = randomintrange(40, 200);
  _id_8FE5058B83E1804E = _id_29235AC6D41F67B8 + 20;
  _id_64569EB1053934A6 thread _id_B2303922E4F9A11A("left_p0", _id_29235AC6D41F67B8, _id_8FE5058B83E1804E);
  _id_292368C6D41F8682 = randomintrange(40, 200);

  if(abs(_id_29235AC6D41F67B8 - _id_292368C6D41F8682) < 40) {
    if(_id_292368C6D41F8682 - 60 < 40)
      _id_292368C6D41F8682 = _id_292368C6D41F8682 + randomintrange(75, 100);
    else
      _id_292368C6D41F8682 = _id_292368C6D41F8682 - 60;
  }

  _id_8FE4EF8B83E14FEC = _id_292368C6D41F8682 + 20;
  _id_6456B8B105396DD4 thread _id_B2303922E4F9A11A("right_p0", _id_292368C6D41F8682, _id_8FE4EF8B83E14FEC);
  _id_DEBA44F65F3CE69D thread _id_E9B51FED28266F4E();
  scripts\engine\utility::flag_wait("p0_primer");
  _id_ADEA919C93F885C1 setModel("electronics_elevator_security_lock_console_a_green_light_on");
  _id_ADEA7B9C93F8555F setModel("electronics_elevator_security_lock_console_a_green_light_on");
}

_id_3D6C6FE34D0EB56B() {
  level endon("game_ended");
  level endon("bay_flooded");

  for(;;) {
    if(getdvarint("dvar_695A0867F31C373C", 0) > 0) {
      setDvar("dvar_695A0867F31C373C", 0);
      scripts\engine\utility::flag_set("bay_flooded");
    }

    wait 0.1;
  }
}

_id_E9B51FED28266F4E() {
  level endon("game_ended");
  level endon("bay_flooded");
  level thread _id_3D6C6FE34D0EB56B();

  for(;;) {
    level._id_83A8EBAAE405B206 = 0;
    self waittill("trigger", player);
    self _meth_DFB78B3E724AD620(0);

    if(scripts\engine\utility::flag("valve_left_p0_turned") && scripts\engine\utility::flag("valve_right_p0_turned"))
      level._id_83A8EBAAE405B206 = 1;

    _id_558A9A418B2D3405::_id_CEA1D99FB4716416(player);

    if(level._id_83A8EBAAE405B206) {
      player playsoundtoplayer("cp_computer_success", player, self);
      scripts\engine\utility::flag_set("p0_primer");
      waitframe();
      scripts\engine\utility::flag_set("bay_flooded");
      return;
    }

    player playsoundtoplayer("cp_computer_fail", player, self);
    level notify("vo_primary_pump_fail", player);
    wait 1;
    self _meth_DFB78B3E724AD620(1);
  }
}

_id_1922F683D2FE270B() {
  while(_func_EAC0CD99C9C6D8EE() != "spotted")
    wait 1;

  level.stealth.bstayincombatoncealerted = 1;
  _func_AA9FA9C5A97D0F6E(1);
  level notify("stealth_broken");
  wait 3;
  thread _id_382959D7794736CC::_id_68242F0E071E0D3E((2244, 8720, 141));
  wait 1.5;

  foreach(enemy in level.agentarray) {
    if(isDefined(level._id_E2958F412A7425C0) && enemy == level._id_E2958F412A7425C0) {
      continue;
    }
    if(istrue(enemy.isactive))
      enemy.goalradius = 2048;
  }

  while(scripts\cp\cp_agent_utils::get_alive_enemies().size >= 2)
    wait 1;
}

_id_509C71310F742737() {
  wait 5;
  _id_079D09558F0A7FA7 = getEnt("water_pump_switch", "targetname");
  _id_079D09558F0A7FA7 _id_08CFA05169ABE592();
  wait 0.5;
}

_id_08CFA05169ABE592() {
  level endon("bay_flooded");
  level endon("game_ended");
  scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_RAID1_BOSS1/SECONDARY_VALVE_REQUIRED", undefined, "duration_none", "show", 250, 35, 72, 45);
  _id_382959D7794736CC::_id_66344994F6CA11D6(&"CP_RAID1_BOSS1/SECONDARY_VALVE_REQUIRED", "bay_flooded", &"CP_RAID1_BOSS1/ACTIVATE_PUMP", "scr_skipsecondarypump");
}

_id_B2303922E4F9A11A(targetname, _id_5FB9E1D791004A2E, _id_5F96D3D790D9E3AC) {
  level endon("game_ended");
  thread _id_382959D7794736CC::_id_A0D3C7111B497557();
  ogangles = self.angles;
  _id_A92B260D35A73EB9 = getEntArray("water_pump_needle_" + targetname, "targetname");

  foreach(_id_633CAFA47D2991FE in _id_A92B260D35A73EB9)
  _id_633CAFA47D2991FE.ogangles = _id_633CAFA47D2991FE.angles;

  lights = getEntArray(targetname + "_needle_indicator", "targetname");

  foreach(light in lights)
  light setModel("electronics_elevator_security_lock_console_a_green_light_off");

  self._id_0AC5ACEB2230C3A5 = 0;
  self._id_D4FDE2EACFCDE2C9 = 235;
  self setModel("ee_pipe_05_valve_02_wheel");
  _id_069EB193385E91A0 = 0;

  for(;;) {
    self waittill("trigger", ent);

    if(!ent isonground() || ent _meth_E40102956C887F7C()) {
      continue;
    }
    self _meth_DFB78B3E724AD620(0);
    self._id_FEAF5D8BE6377441 = 1;
    self notify("start_audio");

    while(ent scripts\cp\utility::is_valid_player() && ent useButtonPressed() && distance2d(ent.origin, self.origin) < 36) {
      ent._id_5D43389756907528 = 1;

      if(self._id_0AC5ACEB2230C3A5 >= self._id_D4FDE2EACFCDE2C9) {
        self notify("reached_max");
        self._id_0AC5ACEB2230C3A5 = self._id_D4FDE2EACFCDE2C9;
        wait 0.05;
        continue;
      }

      foreach(_id_633CAFA47D2991FE in _id_A92B260D35A73EB9)
      _id_633CAFA47D2991FE rotateroll(-1, 0.05);

      self rotatepitch(1, 0.05);
      self._id_0AC5ACEB2230C3A5 = self._id_0AC5ACEB2230C3A5 + 1;
      _id_8077A5A1A29261C0(_id_5FB9E1D791004A2E, _id_5F96D3D790D9E3AC, _id_069EB193385E91A0, lights, targetname, _id_A92B260D35A73EB9);
      self waittill("rotatedone");
    }

    if(ent scripts\cp\utility::is_valid_player(1))
      ent._id_5D43389756907528 = undefined;

    self._id_FEAF5D8BE6377441 = 0;
    thread _id_86DB2A44E74B4B9C(_id_5FB9E1D791004A2E, _id_5F96D3D790D9E3AC, _id_069EB193385E91A0, lights, targetname, _id_A92B260D35A73EB9);
    wait 0.25;
    self _meth_DFB78B3E724AD620(1);
  }
}

_id_86DB2A44E74B4B9C(_id_5FB9E1D791004A2E, _id_5F96D3D790D9E3AC, _id_069EB193385E91A0, lights, targetname, _id_A92B260D35A73EB9) {
  self endon("trigger");
  level endon("p0_primer");
  self notify("stop_audio");

  if(isDefined(self.cooldowntime))
    wait(self.cooldowntime);
  else
    wait 2;

  _id_CF70FB0CAB5AB856 = 1;

  if(isDefined(self._id_CF70FB0CAB5AB856))
    _id_CF70FB0CAB5AB856 = self._id_CF70FB0CAB5AB856;

  if(!istrue(self._id_FEAF5D8BE6377441))
    self notify("start_depaudio");

  for(;;) {
    if(istrue(self._id_FEAF5D8BE6377441)) {
      self notify("stop_depaudio");
      return;
    }

    self rotatepitch(-1 * _id_CF70FB0CAB5AB856, 0.05);

    foreach(_id_633CAFA47D2991FE in _id_A92B260D35A73EB9)
    _id_633CAFA47D2991FE rotateroll(1 * _id_CF70FB0CAB5AB856, 0.05);

    self._id_0AC5ACEB2230C3A5 = self._id_0AC5ACEB2230C3A5 - 1 * _id_CF70FB0CAB5AB856;

    if(self._id_0AC5ACEB2230C3A5 < 0)
      self._id_0AC5ACEB2230C3A5 = 0;

    self waittill("rotatedone");
    _id_8077A5A1A29261C0(_id_5FB9E1D791004A2E, _id_5F96D3D790D9E3AC, _id_069EB193385E91A0, lights, targetname, _id_A92B260D35A73EB9);

    if(self._id_0AC5ACEB2230C3A5 == 0) {
      self notify("stop_depaudio");

      foreach(_id_633CAFA47D2991FE in _id_A92B260D35A73EB9) {
        if(isDefined(_id_633CAFA47D2991FE.ogangles))
          _id_633CAFA47D2991FE.angles = _id_633CAFA47D2991FE.ogangles;
      }

      return;
    }
  }
}

_id_8077A5A1A29261C0(_id_5FB9E1D791004A2E, _id_5F96D3D790D9E3AC, _id_069EB193385E91A0, lights, targetname, _id_A92B260D35A73EB9) {
  if(self._id_0AC5ACEB2230C3A5 > _id_5FB9E1D791004A2E && self._id_0AC5ACEB2230C3A5 < _id_5F96D3D790D9E3AC) {
    if(scripts\engine\utility::flag("valve_" + targetname + "_turned")) {
      return;
    }
    foreach(light in lights) {
      light setModel("electronics_elevator_security_lock_console_a_green_light_on");
      playsoundatpos(light.origin, "evt_raid2_pump_valve_pressure_good");
    }

    scripts\engine\utility::flag_set("valve_" + targetname + "_turned");
  } else {
    if(!scripts\engine\utility::flag("valve_" + targetname + "_turned")) {
      return;
    }
    if(istrue(level._id_83A8EBAAE405B206)) {
      return;
    }
    foreach(light in lights)
    light setModel("electronics_elevator_security_lock_console_a_green_light_off");

    scripts\engine\utility::flag_clear("valve_" + targetname + "_turned");
  }
}

_id_82CD563E25B04A17() {
  if(istrue(level._id_6A4B6872B2D6BAB8)) {
    return;
  }
  door = getEnt("dumpster_door", "targetname");
  doorclip = getEnt("dumpster_door_clip", "targetname");
  doorclip linkTo(door);
  _id_5AC49E018B46B2CD = scripts\engine\utility::getStruct("dumpster_button", "targetname");
  _id_20F3271DC43A6012 = scripts\engine\utility::getStruct(_id_5AC49E018B46B2CD.target, "targetname");
  _id_5AC49E018B46B2CD _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(&"CP_HARRIER_BOSS/HOLD_TO_OPEN", "electrical_cell_door_button_red", 72, 256, "duration_none", "hide", undefined, "electrical_cell_door_button_green");
  _id_20F3271DC43A6012 _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(&"CP_HARRIER_BOSS/HOLD_TO_OPEN", "electrical_cell_door_button_red", 72, 256, "duration_none", "hide", undefined, "electrical_cell_door_button_green");
  door._id_CDFF6CE3D4D73F68 = 1;
  door._id_A85B0AF305EEDD88 = 1;
  door._id_F14FE08CFB8BEE65 = _id_382959D7794736CC::_id_07DF365D859CDC1E;
  _id_5AC49E018B46B2CD _id_34D2771929BD6022::_id_05F7C6BF2110C0FE(door, 1, 0, 1);
  level._id_6A4B6872B2D6BAB8 = 1;
}

_id_D9CE237F384CCE02() {
  while(getdvarint("dvar_09360268DFC6312F", 0) < 1)
    wait 1;

  setDvar("dvar_09360268DFC6312F", 0);
  _id_B5DEFF62BA0378CA = scripts\engine\utility::getStruct("substation_grenade_launcher", "targetname");
  level._id_E959C6E734621D0F = _id_678ADBED602DA5EB::_id_9273BA79878B2221(_id_B5DEFF62BA0378CA, "weapon_wm_mg_mobile_turret");
  level._id_E959C6E734621D0F._id_5D186451F21D7020 = 122500;
  level._id_E959C6E734621D0F.maxrange = 46240000;
  level._id_E959C6E734621D0F._id_B5BD9EDCB0BF65F1 = 350;
  level._id_E959C6E734621D0F._id_8EF48A17AC8ED417 = 1;
  level._id_E959C6E734621D0F thread turret_think();
}

turret_think() {
  level endon("game_ended");

  for(;;) {
    enemies = scripts\cp\cp_agent_utils::get_alive_enemies();

    if(!enemies.size) {
      wait 1;
      continue;
    }

    available = [];

    foreach(enemy in enemies) {
      if(abs(enemy.origin[2] - self.origin[2] > 100)) {
        continue;
      }
      if(enemy == level._id_E2958F412A7425C0) {
        continue;
      }
      available[available.size] = enemy;
    }

    _id_426EE900EFB1862C = scripts\engine\utility::getclosest(self.origin, available, 750);

    if(!isDefined(_id_426EE900EFB1862C)) {
      wait 1;
      continue;
    }

    _id_426EE900EFB1862C thread _id_F1698E3AEB6AAA60();
    msg = _id_426EE900EFB1862C scripts\engine\utility::waittill_any_return_2("death", "blocked");

    if(msg == "blocked") {
      waitframe();
      continue;
    }

    wait 15;
  }
}

_id_F1698E3AEB6AAA60() {
  self endon("death");
  thread _id_6CEADBE23F3D72AE(level._id_E959C6E734621D0F.covernode);
  msg = scripts\engine\utility::waittill_any_return_2("reachedNode", "badpath");

  if(msg == "badpath") {
    self.scripted_mode = undefined;
    self.goalradius = 2048;
    self.ignoreall = 0;
    return "blocked";
  }

  level._id_E959C6E734621D0F._id_2C5E84C1F846661B = self;
  self.turret = level._id_E959C6E734621D0F;
  level._id_E959C6E734621D0F thread[[level.turretsettings[level._id_E959C6E734621D0F.turrettype]._id_7E1467DC63368749]]();
  level._id_E959C6E734621D0F thread _id_678ADBED602DA5EB::_id_F3A3BBA54AA3A0A2(self);
  thread _id_678ADBED602DA5EB::_id_200CFD3D04D2510F(level._id_E959C6E734621D0F);
}

_id_6CEADBE23F3D72AE(_id_189A2D9A88EDFA93) {
  self endon("badpath");
  self endon("death");
  self.goalradius = 16;
  self.ignoreall = 1;
  self setgoalnode(_id_189A2D9A88EDFA93);

  while(distancesquared(self.origin, _id_189A2D9A88EDFA93.origin) > squared(16))
    waitframe();

  self notify("reachedNode");
}