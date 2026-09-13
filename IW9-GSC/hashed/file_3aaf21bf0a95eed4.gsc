/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3aaf21bf0a95eed4.gsc
***********************************************/

_id_9C660C8EF32706C8() {
  level._effect["vfx_gas_jet"] = loadfx("vfx/iw8_mp/trials/fl_petrograd/vfx_trials_gas_jet_start.vfx");
  level._effect["vfx_gas_linger"] = loadfx("vfx/iw8_mp/trials/fl_petrograd/vfx_trials_gas_cloud_linger_lg.vfx");
}

_id_9C706E1E0C18C0A3(_id_49996EBEBBBBF375, _id_C2D2196BA31240BF, _id_A1300CB0D3F4193F, _id_AC55DF9B5B077F09, _id_F37681ED6C463517, _id_E3107C7D037D0629) {
  if(!isDefined(level._id_97D97E38B7F074C5))
    level._id_97D97E38B7F074C5 = [];

  if(!isDefined(level._id_E595827B3496FE9B))
    level._id_E595827B3496FE9B = [];

  if(!isDefined(level._id_FB4E36DCF267C9A9))
    level._id_FB4E36DCF267C9A9 = [];

  if(!isDefined(level._id_26101DA6866B8D43))
    level._id_26101DA6866B8D43 = [];

  if(!isDefined(level._id_FB4E36DCF267C9A9[_id_49996EBEBBBBF375]))
    level._id_FB4E36DCF267C9A9[_id_49996EBEBBBBF375] = [];

  level._id_FB4E36DCF267C9A9[_id_49996EBEBBBBF375] = getEntArray(_id_C2D2196BA31240BF, "targetname");

  if(isDefined(_id_E3107C7D037D0629))
    level._id_26101DA6866B8D43[_id_49996EBEBBBBF375] = _id_E3107C7D037D0629;

  if(isDefined(_id_A1300CB0D3F4193F))
    level._id_97D97E38B7F074C5[_id_49996EBEBBBBF375] = scripts\engine\utility::getStructArray(_id_A1300CB0D3F4193F, "targetname");
  else
    level._id_97D97E38B7F074C5[_id_49996EBEBBBBF375] = [];

  if(isDefined(_id_AC55DF9B5B077F09))
    level._id_E595827B3496FE9B[_id_49996EBEBBBBF375] = scripts\engine\utility::getStructArray(_id_AC55DF9B5B077F09, "targetname");
  else
    level._id_E595827B3496FE9B[_id_49996EBEBBBBF375] = [];

  if(!isDefined(level._id_5D39AAE7C9967A09))
    level._id_5D39AAE7C9967A09 = [];

  if(isDefined(_id_F37681ED6C463517))
    level._id_5D39AAE7C9967A09[_id_49996EBEBBBBF375] = _id_F37681ED6C463517;

  thread _id_1AB36D8EDC771142(_id_49996EBEBBBBF375);
}

_id_E98C4212D1E67EA3(_id_49996EBEBBBBF375) {
  if(!isDefined(level._id_FB4E36DCF267C9A9)) {
    return;
  }
  if(!isDefined(level._id_FB4E36DCF267C9A9[_id_49996EBEBBBBF375])) {
    return;
  }
  if(isDefined(level._id_FB4E36DCF267C9A9[_id_49996EBEBBBBF375])) {
    foreach(trigger in level._id_FB4E36DCF267C9A9[_id_49996EBEBBBBF375])
    trigger delete();

    level._id_FB4E36DCF267C9A9[_id_49996EBEBBBBF375] = undefined;
  }

  if(isDefined(level._id_97D97E38B7F074C5[_id_49996EBEBBBBF375])) {
    foreach(_id_93FA9B11F85EC1A9 in level._id_97D97E38B7F074C5[_id_49996EBEBBBBF375])
    _id_93FA9B11F85EC1A9.effect delete();

    level._id_97D97E38B7F074C5[_id_49996EBEBBBBF375] = undefined;
  }

  if(isDefined(level._id_E595827B3496FE9B[_id_49996EBEBBBBF375])) {
    foreach(_id_741820633EEC028A in level._id_E595827B3496FE9B[_id_49996EBEBBBBF375])
    _id_741820633EEC028A.effect delete();

    level._id_E595827B3496FE9B[_id_49996EBEBBBBF375] = undefined;
  }

  if(isDefined(level._id_5D39AAE7C9967A09[_id_49996EBEBBBBF375]))
    level._id_5D39AAE7C9967A09[_id_49996EBEBBBBF375] = undefined;
}

_id_1AB36D8EDC771142(_id_49996EBEBBBBF375) {
  level._id_46C69F3C3F6FAB13 = "cp_raid2_gas_attack";

  foreach(fx in level._id_97D97E38B7F074C5[_id_49996EBEBBBBF375]) {
    fx.effect = spawnfx(level._effect["vfx_cp_raid_trap_gas_wall"], fx.origin, anglesToForward(fx.angles), anglestoup(fx.angles));
    waitframe();
  }
}

_id_653EBA3B129AEA0E(_id_90B5C417C3555C4C, _id_1FC8BA3D29706E94) {
  if(!isDefined(level._id_B43C427CFB21FF0C))
    level._id_B43C427CFB21FF0C = [];

  if(!isDefined(level._id_B43C427CFB21FF0C[_id_90B5C417C3555C4C]))
    level._id_B43C427CFB21FF0C[_id_90B5C417C3555C4C] = [];

  _id_75214D835E79EA94 = [];
  _id_448456F634611AAF = 0;

  for(_id_E30FBEC40C3CB51F = getEnt(_id_1FC8BA3D29706E94 + _id_448456F634611AAF, "targetname"); isDefined(_id_E30FBEC40C3CB51F); _id_E30FBEC40C3CB51F = getEnt(_id_1FC8BA3D29706E94 + _id_448456F634611AAF, "targetname")) {
    _id_AA45AA2A90D96203 = _id_1FC8BA3D29706E94 + _id_448456F634611AAF;
    level._id_B43C427CFB21FF0C[_id_90B5C417C3555C4C][level._id_B43C427CFB21FF0C[_id_90B5C417C3555C4C].size] = _id_AA45AA2A90D96203;
    thread _id_9C706E1E0C18C0A3(_id_AA45AA2A90D96203, _id_AA45AA2A90D96203, _id_AA45AA2A90D96203 + "_fx", _id_AA45AA2A90D96203 + "_fx_linger");
    _id_448456F634611AAF++;
  }
}

_id_6532A0C1B8B58A22(_id_90B5C417C3555C4C, totaltime) {
  level endon("game_ended");
  _id_75214D835E79EA94 = level._id_B43C427CFB21FF0C[_id_90B5C417C3555C4C];
  _id_46BCCF24774BA912 = totaltime / _id_75214D835E79EA94.size;
  playsoundatpos((-416, -427, -534), "scn_raid2_escape_glass_break_impact");
  _id_FE5C6FBAA476EE63 = 0;
  _id_36E3A5E3E5DFEEEB = 0;

  while(!istrue(_id_36E3A5E3E5DFEEEB)) {
    level notify("stop_gas_wall_catchup");
    level thread _id_1F5D08BE8B7E5501(_id_75214D835E79EA94[_id_FE5C6FBAA476EE63]);
    level thread _id_930B9A9822C43795(_id_FE5C6FBAA476EE63, _id_75214D835E79EA94, 4);
    level scripts\engine\utility::waittill_any_timeout_1(_id_46BCCF24774BA912, "do_gas_wall_catch_up");
    _id_FE5C6FBAA476EE63++;

    if(_id_FE5C6FBAA476EE63 >= _id_75214D835E79EA94.size) {
      _id_36E3A5E3E5DFEEEB = 1;
      continue;
    }

    level thread _id_79823539CA298145::_id_26C15B16B63B126D(_id_75214D835E79EA94[_id_FE5C6FBAA476EE63 + 1]);
  }
}

_id_930B9A9822C43795(_id_448456F634611AAF, _id_75214D835E79EA94, _id_718DD1360FB5D543) {
  level endon("game_ended");
  level endon("stop_gas_wall_catchup");
  level notify("single_watch_for_gas_wall_catch_up");
  level endon("single_watch_for_gas_wall_catch_up");
  _id_909901F2C9DD9088 = _id_75214D835E79EA94.size;
  _id_9416330628555B86 = undefined;

  if(_id_909901F2C9DD9088 - _id_448456F634611AAF <= _id_718DD1360FB5D543) {
    _id_9416330628555B86 = _id_75214D835E79EA94[_id_75214D835E79EA94.size - 1];
    wait 2;
  } else
    _id_9416330628555B86 = _id_75214D835E79EA94[_id_448456F634611AAF + _id_718DD1360FB5D543];

  _id_C85C96521B9FA174 = level._id_FB4E36DCF267C9A9[_id_9416330628555B86];

  if(!isDefined(_id_C85C96521B9FA174)) {
    return;
  }
  for(;;) {
    if(istrue(_id_1FA6123ACBDC3287(_id_C85C96521B9FA174))) {
      level notify("do_gas_wall_catch_up");
      return;
    } else
      waitframe();
  }
}

_id_1FA6123ACBDC3287(_id_C85C96521B9FA174) {
  foreach(trig in _id_C85C96521B9FA174) {
    foreach(player in level.players) {
      if(player istouching(trig))
        return 1;
    }
  }

  return 0;
}

_id_ECC126DE13320BB6(_id_B5C08016DE0CC3D7) {
  level endon("game_ended");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    playsoundatpos(_id_B5C08016DE0CC3D7, "cp_gas_attack_countdown");
    wait 1;
  }

  playsoundatpos(_id_B5C08016DE0CC3D7, "cp_gas_attack_alarm");
}

_id_1F5D08BE8B7E5501(area, _id_B5C08016DE0CC3D7) {
  level endon("game_ended");

  if(!isDefined(level._id_FF1D434CBDA6C1C4))
    level._id_FF1D434CBDA6C1C4 = [];

  level._id_FF1D434CBDA6C1C4[level._id_FF1D434CBDA6C1C4.size] = area;

  if(istrue(_id_B5C08016DE0CC3D7))
    level thread _id_ECC126DE13320BB6(_id_B5C08016DE0CC3D7);

  foreach(fx in level._id_97D97E38B7F074C5[area]) {
    triggerfx(fx.effect);
    scripts\engine\utility::play_sound_in_space(level._id_46C69F3C3F6FAB13, fx.origin);
  }

  wait 2;

  if(isDefined(level._id_26101DA6866B8D43[area]))
    scripts\engine\utility::exploder(level._id_26101DA6866B8D43[area]);

  foreach(trigger in level._id_FB4E36DCF267C9A9[area])
  trigger thread _id_67B175176CA50322(area);
}

_id_A557E6F1D71212CC(_id_49996EBEBBBBF375) {
  level endon("game_ended");

  if(isDefined(level._id_26101DA6866B8D43[_id_49996EBEBBBBF375]))
    scripts\engine\utility::stop_exploder(level._id_26101DA6866B8D43[_id_49996EBEBBBBF375]);

  foreach(fx in level._id_97D97E38B7F074C5[_id_49996EBEBBBBF375])
  fx.effect delete();

  wait 1;

  foreach(fx in level._id_E595827B3496FE9B[_id_49996EBEBBBBF375])
  fx.effect delete();

  level notify(_id_49996EBEBBBBF375 + "gas_dissipated");
}

_id_8E85F07351C72547(_id_49996EBEBBBBF375) {
  level endon("game_ended");
  level thread _id_A557E6F1D71212CC(_id_49996EBEBBBBF375);

  foreach(trigger in level._id_FB4E36DCF267C9A9[_id_49996EBEBBBBF375])
  trigger notify("stop_gas");

  level waittill(_id_49996EBEBBBBF375 + "gas_dissipated");

  if(isDefined(level._id_FF1D434CBDA6C1C4) && scripts\engine\utility::array_contains(level._id_FF1D434CBDA6C1C4, _id_49996EBEBBBBF375))
    level._id_FF1D434CBDA6C1C4 = scripts\engine\utility::array_remove(level._id_FF1D434CBDA6C1C4, _id_49996EBEBBBBF375);

  level._id_FF1D434CBDA6C1C4[level._id_FF1D434CBDA6C1C4.size] = _id_49996EBEBBBBF375;
  _id_1AB36D8EDC771142(_id_49996EBEBBBBF375);
}

_id_89E903D60BF7807C(_id_49996EBEBBBBF375) {
  if(!isDefined(level._id_FF1D434CBDA6C1C4))
    return 0;

  return scripts\engine\utility::array_contains(level._id_FF1D434CBDA6C1C4, _id_49996EBEBBBBF375);
}

_id_67B175176CA50322(_id_49996EBEBBBBF375) {
  self endon("stop_gas");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(!istrue(player._id_BF7A269C23B01A56))
      player thread _id_834C2829D72B403E(self, _id_49996EBEBBBBF375);
  }
}

_id_834C2829D72B403E(trigger, _id_49996EBEBBBBF375) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self._id_BF7A269C23B01A56 = 1;
  thread _id_9FDAB3820A01D904();
  thread gas_applyblur();
  thread scripts\cp\equipment\cp_gas_grenade::gas_applycough();
  enableloopingcoughaudio();
  self notify("entered_toxic_gas", _id_49996EBEBBBBF375);

  if(isDefined(level._id_5D39AAE7C9967A09) && isDefined(level._id_5D39AAE7C9967A09[_id_49996EBEBBBBF375]))
    thread[[level._id_5D39AAE7C9967A09[_id_49996EBEBBBBF375]]](self, _id_49996EBEBBBBF375);

  trigger.armor_piercing = 1;
  _id_66C0E8071E426BFA = 10;
  _id_891076C5D94AD64D = 50;
  _id_E39A4FEDB8462440 = 7;
  _id_1F733FA1537E3C07 = 10;

  if(isDefined(trigger.script_noteworthy)) {
    _id_67F14F8315CB0F2F = strtok(trigger.script_noteworthy, ",");
    _id_66C0E8071E426BFA = float(_id_67F14F8315CB0F2F[0]);
    _id_891076C5D94AD64D = float(_id_67F14F8315CB0F2F[1]);
    _id_66C0E8071E426BFA = max(_id_66C0E8071E426BFA, _id_E39A4FEDB8462440);
    _id_891076C5D94AD64D = max(_id_891076C5D94AD64D, _id_1F733FA1537E3C07);
  }

  while(self istouching(trigger)) {
    if(istrue(self.inlaststand))
      self dodamage(_id_891076C5D94AD64D, self.origin, trigger);
    else
      self dodamage(_id_66C0E8071E426BFA, self.origin, trigger);

    self._id_1983AF7858AA2ABA = 1;
    self._id_AB0E6A7A6909FC4D = 8;
    wait 0.5;
  }

  self notify("gas_modify_blur");
  waitframe();
  self notify("gas_exited", _id_49996EBEBBBBF375);
  waitframe();
  disableloopingcoughaudio();
  self._id_BF7A269C23B01A56 = 0;
}

_id_9FDAB3820A01D904() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gas_exited");
  self waittill("death");
  self._id_BF7A269C23B01A56 = 0;
}

gas_applyblur() {
  self endon("death_or_disconnect");
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

enableloopingcoughaudio() {
  if(!isDefined(self.loopingcoughaudio))
    self.loopingcoughaudio = 0;

  self.loopingcoughaudio++;

  if(self.loopingcoughaudio == 1)
    thread startloopingcoughaudio();
}

disableloopingcoughaudio() {
  if(!isDefined(self.loopingcoughaudio)) {
    return;
  }
  self.loopingcoughaudio--;

  if(self.loopingcoughaudio == 0) {
    thread stoploopingcoughaudio();
    self.loopingcoughaudio = undefined;
  }
}

startloopingcoughaudio() {
  self endon("death_or_disconnect");
  self endon("clearLoopingCoughAudio");
  level endon("game_ended");

  for(;;) {
    waittime = randomfloatrange(5, 7);

    if(!loopingcoughaudioissupressed()) {
      soundalias = "generic_cough_3_enemy_1";

      if(self.team == "allies") {
        if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
          _id_BF9336BF707FA7CA = game["dialogue"]["allies_female_cough"].size;
          _id_D337CAA5F4D5A1BF = randomint(_id_BF9336BF707FA7CA);
          soundalias = game["dialogue"]["allies_female_cough"][_id_D337CAA5F4D5A1BF];
        } else {
          _id_BF9336BF707FA7CA = game["dialogue"]["allies_male_cough"].size;
          _id_D337CAA5F4D5A1BF = randomint(_id_BF9336BF707FA7CA);
          soundalias = game["dialogue"]["allies_male_cough"][_id_D337CAA5F4D5A1BF];
        }
      } else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
        _id_BF9336BF707FA7CA = game["dialogue"]["axis_female_cough"].size;
        _id_D337CAA5F4D5A1BF = randomint(_id_BF9336BF707FA7CA);
        soundalias = game["dialogue"]["axis_female_cough"][_id_D337CAA5F4D5A1BF];
      } else {
        _id_BF9336BF707FA7CA = game["dialogue"]["axis_male_cough"].size;
        _id_D337CAA5F4D5A1BF = randomint(_id_BF9336BF707FA7CA);
        soundalias = game["dialogue"]["axis_male_cough"][_id_D337CAA5F4D5A1BF];
      }

      self playsoundonmovingent(soundalias);
    }

    wait(waittime);
  }
}

loopingcoughaudioissupressed() {
  return isDefined(self.loopingcoughaudiosupression) && self.loopingcoughaudiosupression > 0;
}

stoploopingcoughaudio() {
  self notify("clearLoopingCoughAudio");
}