/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2c20a33cd30eee5f.gsc
***********************************************/

_id_59AE7C32A14BDA75() {
  if(!isDefined(level._id_FB4E36DCF267C9A9))
    level._id_FB4E36DCF267C9A9 = [];

  if(isDefined(level._id_FB4E36DCF267C9A9["subpen"])) {
    return;
  }
  level._id_FB4E36DCF267C9A9["subpen"] = getEnt("area2_gas_trigger", "targetname");
  scripts\engine\utility::stop_exploder("vent_gas");
  scripts\engine\utility::stop_exploder("water_rise1");
  scripts\engine\utility::stop_exploder("water_rise2");
  _id_F3493A61496A2C45(0);
}

_id_9C706E1E0C18C0A3(area) {
  foreach(fx in level._id_97D97E38B7F074C5[area]) {
    fx.effect = spawnfx(level._effect["vfx_gas_jet"], fx.origin, anglesToForward(fx.angles), anglestoup(fx.angles));
    waitframe();
  }

  foreach(fx in level._id_E595827B3496FE9B[area]) {
    if(fx.script_noteworthy == "lower") {
      if(!isDefined(fx.ogorigin))
        fx.ogorigin = fx.origin;

      fx.origin = fx.ogorigin + (0, 0, 72);
    }

    fx.effect = spawnfx(level._effect["vfx_gas_linger"], fx.origin, anglesToForward(fx.angles), anglestoup(fx.angles));
    waitframe();
  }
}

_id_549AD3DA1C9834FE(area) {
  level endon("game_ended");
  level childthread _id_1C06BEDD9980B7AF::_id_A63241F100B7E1D0();
  level childthread _id_A5B3280FD5465188();
  level scripts\engine\utility::waittill_any_timeout_1(4, "gas_alarm_warning_over");
  scripts\engine\utility::exploder("vent_gas");
  scripts\engine\utility::exploder("water_rise1");
  level thread _id_F3493A61496A2C45(1);
  wait 3;
  scripts\engine\utility::stop_exploder("water_rise1");
  scripts\engine\utility::exploder("water_rise2");

  foreach(enemy in level.agentarray) {
    if(enemy == level._id_E2958F412A7425C0) {
      continue;
    }
    if(istrue(enemy.isactive))
      enemy thread _id_CEEEB2973899A493();
  }

  if(!isDefined(level._id_FB4E36DCF267C9A9[area].og_origin)) {
    level._id_FB4E36DCF267C9A9[area].og_origin = level._id_FB4E36DCF267C9A9[area].origin;
    level._id_FB4E36DCF267C9A9[area] enablelinkTo();
    level._id_FB4E36DCF267C9A9[area].anchor = spawn("script_origin", level._id_FB4E36DCF267C9A9[area].origin);
    level._id_FB4E36DCF267C9A9[area] linkTo(level._id_FB4E36DCF267C9A9[area].anchor);
  }

  level._id_FB4E36DCF267C9A9[area] thread _id_67B175176CA50322();
  level._id_FB4E36DCF267C9A9[area].anchor movez(-545, 7);
  wait 3;
  endtime = gettime() + 15000;

  while(gettime() < endtime)
    wait 0.05;

  level thread _id_F3493A61496A2C45(0);
  scripts\engine\utility::stop_exploder("vent_gas");
  scripts\engine\utility::stop_exploder("water_rise2");
  level._id_FB4E36DCF267C9A9[area] notify("stop_gas");
  level notify("stop_gas_alarm");
  scripts\engine\utility::flag_clear("vo_boss_gas");

  foreach(enemy in level.agentarray) {
    if(enemy == level._id_E2958F412A7425C0) {
      continue;
    }
    enemy notify("stop_throwing");
  }

  level._id_FB4E36DCF267C9A9[area].anchor.origin = level._id_FB4E36DCF267C9A9[area].og_origin;
}

_id_922983C197BEC925() {
  _id_5E957CF3465F9B46 = scripts\engine\utility::flag("p1_finished");

  if(istrue(_id_5E957CF3465F9B46))
    return 1;

  return 0;
}

_id_A5B3280FD5465188() {
  level endon("game_ended");
  level endon("stop_gas_alarm");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    playsoundatpos(scripts\engine\utility::getStruct("alarm_audio", "targetname").origin, "cp_gas_attack_countdown");
    wait 1;
  }

  level notify("gas_alarm_warning_over");
  playsoundatpos(scripts\engine\utility::getStruct("alarm_audio", "targetname").origin, "cp_gas_attack_alarm");
  playsoundatpos((15961, 9095, 726), "cp_raid3_gas_attack");
  playsoundatpos((15961, 8401, 726), "cp_raid3_gas_attack");

  for(;;) {
    playsoundatpos(scripts\engine\utility::getStruct("alarm_audio", "targetname").origin, "cp_gas_attack_interim");
    wait 2.5;
  }
}

_id_67B175176CA50322() {
  self endon("stop_gas");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(player _id_4B87F2871B6B025C::_id_1CF18F5E612E68C5()) {
      continue;
    }
    if(!istrue(player._id_BF7A269C23B01A56))
      player thread _id_834C2829D72B403E(self);
  }
}

_id_834C2829D72B403E(_id_85754313C848D450) {
  self endon("disconnect");
  self._id_BF7A269C23B01A56 = 1;
  thread gas_applyblur();
  thread scripts\cp\equipment\cp_gas_grenade::gas_applycough();
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudio();
  _id_2841F41440CBB817 = randomintrange(3, 6);
  _id_2841F41440CBB817 = gettime() + _id_2841F41440CBB817 * 1000;

  while(gettime() < _id_2841F41440CBB817) {
    if(isDefined(level._id_58D3D7CC1F3D2A37))
      self dodamage(level._id_58D3D7CC1F3D2A37, self.origin);
    else
      self dodamage(10, self.origin);

    wait 1;
  }

  self._id_BF7A269C23B01A56 = 0;
  self notify("gas_modify_blur");
  waitframe();
  self notify("gas_exited");
  waitframe();
  scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudio();
}

gas_applyblur() {
  self endon("disconnect");
  self notify("gas_modify_blur");
  self endon("gas_modify_blur");
  _id_22F87C8BF7C4616B = "gas_grenade_heavy_mp";

  if(scripts\cp\utility::_hasperk("specialty_gas_grenade_resist"))
    _id_22F87C8BF7C4616B = "gas_grenade_light_mp";

  for(;;) {
    scripts\cp_mp\utility\shellshock_utility::_shellshock(_id_22F87C8BF7C4616B, "gas", 3, 0);
    wait 1;
  }
}

gas_removeblur() {
  self notify("gas_modify_blur");
}

gas_clearblur(_id_FCEF8D217A441961) {
  self notify("gas_modify_blur");

  if(!istrue(_id_FCEF8D217A441961))
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
}

_id_C01ABBA465C912C6(area) {
  self endon("death");

  if(istrue(self._id_8FFF9E977E206515) || istrue(self._id_5D765B7A01E415D8) || istrue(self._id_1C9A41EC57318EC8)) {
    return;
  }
  self.goalradius = 16;
  self._id_1C9A41EC57318EC8 = 1;
  _id_0C3EA9B1A20FF199 = scripts\engine\utility::getStruct("boss_attack_gas", "targetname");
  self setgoalpos(getclosestpointonnavmesh(_id_0C3EA9B1A20FF199.origin));
  self waittill("goal");
  wait 1;
  level thread _id_549AD3DA1C9834FE(area);
  wait 5;
  self._id_1C9A41EC57318EC8 = undefined;
  self.goalradius = 2048;
  self.goalheight = 100;
}

_id_CEEEB2973899A493() {
  self endon("death");
  self endon("stop_throwing");
  grenades = randomintrange(1, 3);

  if(!isDefined(level._id_B98850B58450BF4B))
    level._id_B98850B58450BF4B = gettime();

  for(;;) {
    if(!isDefined(self.enemy)) {
      wait 0.1;
      continue;
    }

    if(isDefined(self.node) && distance(self.origin, self.node.origin) > 72 || isDefined(self.pathgoalpos)) {
      wait 0.05;
      continue;
    }

    if(gettime() >= level._id_B98850B58450BF4B) {
      _id_3F7AA286B2E359B5 = scripts\cp\utility::get_point_in_local_ent_space(self.enemy, (100, 0, 0));

      if(!isDefined(_id_3F7AA286B2E359B5))
        _id_3F7AA286B2E359B5 = self.enemy.origin;

      thread scripts\cp\utility::_id_AE99616202575E39(_id_3F7AA286B2E359B5, "semtex_mp");
      level._id_B98850B58450BF4B = gettime() + randomintrange(3, 6) * 1000;
      grenades--;
    }

    if(grenades == 0) {
      return;
    }
    wait 0.1;
  }
}

_id_3C1F1D3C515C1982() {
  level endon("game_ended");
  _id_41D8BF229CF29051 = 1;

  for(;;) {
    _id_F3493A61496A2C45(_id_41D8BF229CF29051);
    _id_41D8BF229CF29051 = !_id_41D8BF229CF29051;
    wait 6;
  }
}

_id_F3493A61496A2C45(_id_41D8BF229CF29051, _id_5E0065A1DC2434B6) {
  level endon("game_ended");
  _id_DA00EEF5E8349195 = 5000;

  if(istrue(_id_5E0065A1DC2434B6))
    _id_DA00EEF5E8349195 = 1;

  if(istrue(_id_41D8BF229CF29051)) {
    _func_90FB4916AA7FD9F3("enum_3999B87C83A04850");
    waitframe();
    _func_7C2E0421AA80F818("enum_1BCEC513B4F95BAE", _id_DA00EEF5E8349195);
  } else {
    _func_90FB4916AA7FD9F3("enum_1BCEC513B4F95BAE");
    waitframe();
    _func_7C2E0421AA80F818("enum_3999B87C83A04850", _id_DA00EEF5E8349195);
  }
}