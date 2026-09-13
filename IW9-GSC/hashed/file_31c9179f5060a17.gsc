/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_31c9179f5060a17.gsc
***********************************************/

_id_99D88E8F3450C5A0(objectivestruct) {
  _id_382959D7794736CC::_id_D68D0E8E5202A02A("pristine");
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("raise_water_2");
  scripts\engine\utility::flag_wait("subarea_ready");
  scripts\engine\utility::flag_clear("spawning_reinforcements");
  scripts\engine\utility::flag_set("p0_finished");
  thread _id_63325153465F8869::_id_FFEC324BD5085987();
  level thread _id_382959D7794736CC::_id_0C735D60735EDA5F();
  level thread _id_01B1A46EFB26E5A9::_id_E00BA90C8FAF1451();
  level thread _id_24D3D5C5A0521C72::_id_8CE8975F5D76A5CF();
  level thread _id_13FFCCF97A3E3294::_id_9580ECCE8D201C4F();
  _id_6E32188470E934C0::_id_82CD563E25B04A17();
  _id_323248A3057C390F::_id_2D7992159C9B6DEF();
  _id_2C20A33CD30EEE5F::_id_59AE7C32A14BDA75();
  level thread _id_6E32188470E934C0::_id_5734778D7F1B6E6F();
  _id_A5516703B3F7D1FF = "devgui_cmd \"Level:0 / Debug / Skip Valve Step\" \"set scr_valveskip 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread _id_60008A9093C7A9B5::_id_9087E9EF731F305C();
  level._id_E2958F412A7425C0 thread _id_13FFCCF97A3E3294::_id_D686CFE6F2435D1F("raise_water", "p1_finished");
  _id_0FF1D3ACD85657B7();
  _id_079D09558F0A7FA7 = getEnt("water_pump_switch", "targetname");
  _id_079D09558F0A7FA7 sethintinoperable(0);
  scripts\engine\utility::flag_wait("p1_finished");
  thread _id_382959D7794736CC::_id_148E44373E8EE372();
  wait 2;
  setomnvar("requires_scriptmover_ladder_checks", 1);
  scripts\cp\cp_analytics::_id_B6283AC45A607764("raise_water_2");
  scripts\cp\cp_checkpoint::checkpoint_set("b1_p2");
}

_id_B00C1AA0FF8EA651() {
  offset = 40;
  _func_AC735EEE7BC507F6(offset);

  while(!scripts\engine\utility::flag_exist("p1_finished"))
    waitframe();

  scripts\engine\utility::flag_wait("p1_finished");

  while(offset < 126) {
    offset = offset + 0.0625;
    _func_AC735EEE7BC507F6(offset);
    wait 0.05;
  }

  level notify("vo_water_raise_done");
}

_id_0FF1D3ACD85657B7() {
  _id_65EA34233174FE1B = getEnt("water_valve_left", "targetname");
  _id_36582838964290E4 = getEnt("water_valve_right", "targetname");
  _id_079D09558F0A7FA7 = getEnt("water_pump_switch", "targetname");
  _id_079D09558F0A7FA7 scripts\cp\utility::sethintobject("tag_origin", "HINT_BUTTON", undefined, &"CP_RAID1_BOSS1/ACTIVATE_SECONDARY_PUMP", undefined, "duration_none", "show", 250, 35, 72, 45);
  _id_65EA34233174FE1B scripts\cp\utility::sethintobject("tag_origin", "HINT_BUTTON", undefined, &"CP_RAID1_BOSS1/INCREASE_SECONDARY_PRESSURE", undefined, "duration_none", "hide", 450, 35, 35, 45);
  _id_36582838964290E4 scripts\cp\utility::sethintobject("tag_origin", "HINT_BUTTON", undefined, &"CP_RAID1_BOSS1/INCREASE_SECONDARY_PRESSURE", undefined, "duration_none", "hide", 450, 35, 35, 45);
  _id_65EA34233174FE1B thread _id_382959D7794736CC::_id_66344994F6CA11D6(&"CP_RAID1_BOSS1/SECONDARY_VALVE_REQUIRED", "bay_flooded", &"CP_RAID1_BOSS1/INCREASE_SECONDARY_PRESSURE");
  _id_36582838964290E4 thread _id_382959D7794736CC::_id_66344994F6CA11D6(&"CP_RAID1_BOSS1/SECONDARY_VALVE_REQUIRED", "bay_flooded", &"CP_RAID1_BOSS1/INCREASE_SECONDARY_PRESSURE");
  _id_65EA34233174FE1B.cooldowntime = getdvarfloat("dvar_ECEE3C9837FCE0A4", 1);
  _id_36582838964290E4.cooldowntime = getdvarfloat("dvar_ECEE3C9837FCE0A4", 1);
  _id_65EA34233174FE1B._id_CF70FB0CAB5AB856 = getdvarfloat("dvar_7DF601472B590831", 3);
  _id_36582838964290E4._id_CF70FB0CAB5AB856 = getdvarfloat("dvar_7DF601472B590831", 3);
  _id_29235AC6D41F67B8 = randomintrange(40, 200);
  _id_8FE5058B83E1804E = _id_29235AC6D41F67B8 + 35;
  _id_65EA34233174FE1B thread _id_6BAB59CA8BA0B3C7("left", _id_29235AC6D41F67B8, _id_8FE5058B83E1804E);
  _id_292368C6D41F8682 = randomintrange(40, 200);

  if(abs(_id_29235AC6D41F67B8 - _id_292368C6D41F8682) < 40) {
    if(_id_292368C6D41F8682 - 60 < 40)
      _id_292368C6D41F8682 = _id_292368C6D41F8682 + randomintrange(75, 100);
    else
      _id_292368C6D41F8682 = _id_292368C6D41F8682 - 60;
  }

  _id_8FE4EF8B83E14FEC = _id_292368C6D41F8682 + 20;
  _id_36582838964290E4 thread _id_6BAB59CA8BA0B3C7("right", _id_292368C6D41F8682, _id_8FE4EF8B83E14FEC);
  _id_079D09558F0A7FA7 thread _id_55749D9551BAC3E6();
}

_id_6BAB59CA8BA0B3C7(targetname, _id_5FB9E1D791004A2E, _id_5F96D3D790D9E3AC) {
  level endon("game_ended");
  thread _id_382959D7794736CC::_id_A0D3C7111B497557();
  level notify(targetname + "_valve_think");
  level endon(targetname + "_valve_think");
  _id_A92B260D35A73EB9 = getEntArray("water_pump_needle_" + targetname, "targetname");

  foreach(_id_633CAFA47D2991FE in _id_A92B260D35A73EB9) {
    if(!isDefined(_id_633CAFA47D2991FE.ogangles))
      _id_633CAFA47D2991FE.ogangles = _id_633CAFA47D2991FE.angles;
  }

  lights = getEntArray(targetname + "_needle_indicator", "targetname");

  foreach(light in lights)
  light setModel("electronics_elevator_security_lock_console_a_green_light_off");

  self._id_0AC5ACEB2230C3A5 = 0;
  self._id_D4FDE2EACFCDE2C9 = 235;
  self setModel("ee_pipe_05_valve_02_wheel");
  _id_069EB193385E91A0 = 0;

  for(;;) {
    self waittill("trigger", ent);

    if(!isPlayer(ent) || ent isjumping()) {
      continue;
    }
    self _meth_DFB78B3E724AD620(0);
    self._id_FEAF5D8BE6377441 = 1;
    self notify("start_audio");
    level notify("p1_valve_used", ent, targetname);

    while(ent scripts\cp\utility::is_valid_player() && ent useButtonPressed() && distance(ent.origin, self.origin) < 128) {
      ent._id_5D43389756907528 = 1;

      if(self._id_0AC5ACEB2230C3A5 >= self._id_D4FDE2EACFCDE2C9) {
        self._id_0AC5ACEB2230C3A5 = self._id_D4FDE2EACFCDE2C9;
        self notify("reached_max");
        wait 0.05;
        continue;
      }

      foreach(_id_633CAFA47D2991FE in _id_A92B260D35A73EB9)
      _id_633CAFA47D2991FE rotateroll(-1, 0.05);

      self rotatepitch(1, 0.05);
      self._id_0AC5ACEB2230C3A5 = self._id_0AC5ACEB2230C3A5 + 1;
      _id_33597E4A8DBEF383(_id_5FB9E1D791004A2E, _id_5F96D3D790D9E3AC, _id_069EB193385E91A0, lights, targetname, _id_A92B260D35A73EB9);
      self waittill("rotatedone");
    }

    if(ent scripts\cp\utility::is_valid_player(1))
      ent._id_5D43389756907528 = undefined;

    self._id_FEAF5D8BE6377441 = 0;
    thread _id_386D81DF1BC13865(_id_5FB9E1D791004A2E, _id_5F96D3D790D9E3AC, _id_069EB193385E91A0, lights, targetname, _id_A92B260D35A73EB9);
    wait 0.25;
    self _meth_DFB78B3E724AD620(1);
  }
}

_id_386D81DF1BC13865(_id_5FB9E1D791004A2E, _id_5F96D3D790D9E3AC, _id_069EB193385E91A0, lights, targetname, _id_A92B260D35A73EB9) {
  self endon("trigger");
  level endon("game_ended");
  self notify("stop_audio");

  if(isDefined(self.cooldowntime))
    wait(self.cooldowntime);
  else
    wait 1;

  if(!istrue(self._id_FEAF5D8BE6377441))
    self notify("start_depaudio");

  _id_CF70FB0CAB5AB856 = 1;

  if(isDefined(self._id_CF70FB0CAB5AB856))
    _id_CF70FB0CAB5AB856 = self._id_CF70FB0CAB5AB856;

  for(;;) {
    if(istrue(self._id_FEAF5D8BE6377441)) {
      self notify("start_depaudio");
      return;
    }

    foreach(_id_633CAFA47D2991FE in _id_A92B260D35A73EB9)
    _id_633CAFA47D2991FE rotateroll(1 * _id_CF70FB0CAB5AB856, 0.05);

    self rotatepitch(-1 * _id_CF70FB0CAB5AB856, 0.05);
    self._id_0AC5ACEB2230C3A5 = self._id_0AC5ACEB2230C3A5 - 1 * _id_CF70FB0CAB5AB856;

    if(self._id_0AC5ACEB2230C3A5 < 0)
      self._id_0AC5ACEB2230C3A5 = 0;

    self waittill("rotatedone");
    _id_33597E4A8DBEF383(_id_5FB9E1D791004A2E, _id_5F96D3D790D9E3AC, _id_069EB193385E91A0, lights, targetname, _id_A92B260D35A73EB9);

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

_id_33597E4A8DBEF383(_id_5FB9E1D791004A2E, _id_5F96D3D790D9E3AC, _id_069EB193385E91A0, lights, targetname, _id_A92B260D35A73EB9) {
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
    foreach(light in lights)
    light setModel("electronics_elevator_security_lock_console_a_green_light_off");

    scripts\engine\utility::flag_clear("valve_" + targetname + "_turned");
  }
}

_id_55749D9551BAC3E6() {
  level endon("game_ended");
  level notify("mainpumpswitch");
  level endon("mainpumpswitch");
  wait 2;
  self _meth_DFB78B3E724AD620(1);
  self show();

  for(;;) {
    self waittill("trigger", player);
    self _meth_DFB78B3E724AD620(0);
    _id_78C99873C0DD307A = 0;

    if(scripts\engine\utility::flag("valve_left_turned") && scripts\engine\utility::flag("valve_right_turned"))
      _id_78C99873C0DD307A = 1;

    success = _id_558A9A418B2D3405::_id_CEA1D99FB4716416(player);

    if(!istrue(success)) {
      self _meth_DFB78B3E724AD620(1);
      continue;
    }

    _id_6DC94A4483A5B7F3 = getdvarint("dvar_D8344EB38BEF8650", 0) > 0;

    if(_id_6DC94A4483A5B7F3) {
      scripts\engine\utility::flag_set("p1_finished");
      return;
    }

    if(_id_78C99873C0DD307A) {
      player playsoundtoplayer("cp_computer_success", player, self);
      wait 0.5;
      scripts\engine\utility::flag_set("p1_finished");
      return;
    } else {
      player playsoundtoplayer("cp_computer_fail", player, self);
      level notify("vo_secondary_pump_fail", player);
      wait 3;
      self _meth_DFB78B3E724AD620(1);
    }
  }
}