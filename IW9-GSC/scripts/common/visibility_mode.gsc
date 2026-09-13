/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\visibility_mode.gsc
***********************************************/

main(_id_AB5381A1C9CF0CE5) {
  level thread _id_741772FD1005A4C9(_id_AB5381A1C9CF0CE5);
}

_id_741772FD1005A4C9(_id_AB5381A1C9CF0CE5) {
  if(getdvarint("dvar_33A01AF682CAAE50", -1) < 0) {
    return;
  }
  level._id_D766FAF69209BBD6 = spawnStruct();
  level._id_D766FAF69209BBD6._id_5EBB807C9DA025A5 = [];
  level._id_D766FAF69209BBD6.funcs = [];

  if(isfunction(_id_AB5381A1C9CF0CE5))
    _id_AB5381A1C9CF0CE5 = [[_id_AB5381A1C9CF0CE5]]();

  foreach(index, func in _id_AB5381A1C9CF0CE5)
  level._id_D766FAF69209BBD6.funcs[index] = func;

  if(!istrue(_id_9DDAF19178508D55())) {
    return;
  }
  level thread _id_9D4B2121C099B285();
}

_id_9DDAF19178508D55() {
  if(isDefined(level._id_D766FAF69209BBD6.funcs["shouldRun"]))
    return level[[level._id_D766FAF69209BBD6.funcs["shouldRun"]]]();

  return 0;
}

_id_9D4B2121C099B285() {
  level endon("game_ended");

  if(isDefined(level._id_D766FAF69209BBD6.funcs["init"]))
    level[[level._id_D766FAF69209BBD6.funcs["init"]]]();

  level childthread[[level._id_D766FAF69209BBD6.funcs["checkForDataUpdates"]]]();

  for(;;) {
    level waittill("visibilityModeValUpdatedForPlayer", player, val);
    level._id_D766FAF69209BBD6._id_5EBB807C9DA025A5 = _id_C1D9FD48EB09C8C9();

    if(level._id_D766FAF69209BBD6._id_5EBB807C9DA025A5.size == 0) {
      continue;
    }
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_D766FAF69209BBD6._id_5EBB807C9DA025A5.size; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(level._id_D766FAF69209BBD6._id_5EBB807C9DA025A5[_id_AC0E594AC96AA3A8]._id_ADA3F21A8212C26F))
        level thread _id_C3AE50F84A8329AC(level._id_D766FAF69209BBD6._id_5EBB807C9DA025A5[_id_AC0E594AC96AA3A8]);
    }
  }
}

_id_C3AE50F84A8329AC(_id_2C6CA80E296FED3A) {
  _id_2C6CA80E296FED3A endon("disconnect");
  _id_2C6CA80E296FED3A._id_ADA3F21A8212C26F = 1;
  _id_6EA8E24D4901E87C = _id_2C6CA80E296FED3A getentitynumber();
  _id_2C6CA80E296FED3A childthread _id_40353363F8512BB0();

  while(_id_2C6CA80E296FED3A _id_5F46CF1503A0541A()) {
    wait 0.5;

    if(!_id_2C6CA80E296FED3A _id_5F46CF1503A0541A()) {
      break;
    }

    if(!_id_2C6CA80E296FED3A scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    _id_0C68737226B9498A = [[level._id_D766FAF69209BBD6.funcs["getTargetArray"]]](_id_2C6CA80E296FED3A);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0C68737226B9498A.size; _id_AC0E594AC96AA3A8++) {
      if(_id_0C68737226B9498A[_id_AC0E594AC96AA3A8] == _id_2C6CA80E296FED3A) {
        continue;
      }
      if(!_id_0C68737226B9498A[_id_AC0E594AC96AA3A8] scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(_id_0C68737226B9498A[_id_AC0E594AC96AA3A8] _id_3359E7308038233E(_id_2C6CA80E296FED3A)) {
        continue;
      }
      if(isDefined(_id_0C68737226B9498A[_id_AC0E594AC96AA3A8]._id_79A7C8A11ED7C0E3)) {
        if(isDefined(_id_0C68737226B9498A[_id_AC0E594AC96AA3A8]._id_79A7C8A11ED7C0E3[_id_6EA8E24D4901E87C]))
          continue;
      }

      _id_0C68737226B9498A[_id_AC0E594AC96AA3A8] thread _id_8419F0F3143CDCFA(_id_2C6CA80E296FED3A);
    }
  }

  _id_2C6CA80E296FED3A._id_ADA3F21A8212C26F = undefined;
  _id_2C6CA80E296FED3A notify("visibiltyMode_disabled");
}

_id_8419F0F3143CDCFA(_id_2C6CA80E296FED3A) {
  if(istrue(self._id_533E1F58C82C7473)) {
    return;
  }
  _id_6EA8E24D4901E87C = _id_2C6CA80E296FED3A getentitynumber();

  if(isDefined(self._id_79A7C8A11ED7C0E3)) {
    if(isDefined(self._id_79A7C8A11ED7C0E3[_id_6EA8E24D4901E87C]))
      return;
  }

  if(!isDefined(self.team)) {
    return;
  }
  _id_517520758F9C478F = _id_2C6CA80E296FED3A _id_266DA5D877397673();

  if(scripts\cp_mp\utility\player_utility::playersareenemies(self, _id_2C6CA80E296FED3A)) {
    if(_id_517520758F9C478F == "alliesonly") {
      return;
    }
    self._id_23E106FCB074622F = _id_2C6CA80E296FED3A _id_EA4E39208C784A4A();
  } else if(isPlayer(self)) {
    if(_id_517520758F9C478F == "enemiesonly") {
      return;
    }
    self._id_23E106FCB074622F = _id_2C6CA80E296FED3A _id_63A1833B6A352CD7();
  } else {
    if(_id_517520758F9C478F == "enemiesonly") {
      return;
    }
    self._id_23E106FCB074622F = _id_2C6CA80E296FED3A _id_4448756918B98E87();
  }

  _id_01D5EB7943C015CC = level._id_D766FAF69209BBD6.funcs["enableForClient"];

  if(!isDefined(self._id_79A7C8A11ED7C0E3))
    self._id_79A7C8A11ED7C0E3 = [];

  id = self[[_id_01D5EB7943C015CC]](_id_2C6CA80E296FED3A, self._id_23E106FCB074622F, "lowest");
  clientnum = _id_2C6CA80E296FED3A getentitynumber();
  self._id_79A7C8A11ED7C0E3[clientnum] = id;
  thread _id_C0AE1FA01F6B706B(_id_2C6CA80E296FED3A);
  thread _id_32EF0B3582B595D2();
  thread _id_E5C56140AE690938(_id_2C6CA80E296FED3A);
}

_id_32EF0B3582B595D2() {
  level endon("game_ended");
  self notify("visibilityMode_disableOutlineOnDeath");
  self endon("visibilityMode_disableOutlineOnDeath");
  outlineids = [];

  foreach(id in self._id_79A7C8A11ED7C0E3)
  outlineids[outlineids.size] = id;

  self waittill("death_or_disconnect");

  foreach(id in outlineids) {
    if(isDefined(id))
      self[[level._id_D766FAF69209BBD6.funcs["disable"]]](id);
  }

  self._id_23E106FCB074622F = undefined;
  self._id_79A7C8A11ED7C0E3 = undefined;
}

_id_C0AE1FA01F6B706B(_id_2C6CA80E296FED3A) {
  self endon("death");
  _id_2C6CA80E296FED3A endon("disconnect");

  if(isPlayer(self))
    self endon("disconnect");

  clientnum = _id_2C6CA80E296FED3A getentitynumber();
  self notify("visibilityMode_disableOutlineOnCallback_" + clientnum);
  self endon("visibilityMode_disableOutlineOnCallback_" + clientnum);
  _id_7ABB90C7E07FF11B = _id_2C6CA80E296FED3A._id_B1D7DCA915C8EB6D;

  for(;;) {
    _id_2C6CA80E296FED3A waittill("visibilityModeVal", val);

    if(isDefined(val) && val == 0) {
      break;
    }

    if(val != _id_7ABB90C7E07FF11B)
      _id_85E0F20BA385BF6D(_id_2C6CA80E296FED3A);

    _id_7ABB90C7E07FF11B = _id_2C6CA80E296FED3A._id_B1D7DCA915C8EB6D;
  }

  _id_6B814EAFDDCCDD4D(_id_2C6CA80E296FED3A);
}

_id_6B814EAFDDCCDD4D(_id_2C6CA80E296FED3A) {
  foreach(_id_6EA8E24D4901E87C, id in self._id_79A7C8A11ED7C0E3) {
    clientnum = _id_2C6CA80E296FED3A getentitynumber();

    if(clientnum == _id_6EA8E24D4901E87C) {
      if(isDefined(id)) {
        self[[level._id_D766FAF69209BBD6.funcs["disable"]]](id);
        self._id_79A7C8A11ED7C0E3[_id_6EA8E24D4901E87C] = undefined;
      }
    }
  }
}

_id_85E0F20BA385BF6D(_id_2C6CA80E296FED3A) {
  _id_6B814EAFDDCCDD4D(_id_2C6CA80E296FED3A);
  thread _id_8419F0F3143CDCFA(_id_2C6CA80E296FED3A);
}

_id_E5C56140AE690938(_id_2C6CA80E296FED3A) {
  if(!isDefined(level._id_D766FAF69209BBD6.funcs["outlineOccluded"])) {
    return;
  }
  clientnum = _id_2C6CA80E296FED3A getentitynumber();
  self notify("visibilityMode_disableOnsmokeOcclude_" + clientnum);
  self endon("visibilityMode_disableOnsmokeOcclude_" + clientnum);
  self endon("death_or_disconnect");
  _id_2C6CA80E296FED3A endon("disconnect");
  _id_2C6CA80E296FED3A endon("visibiltyMode_disabled");

  for(;;) {
    wait 0.5;

    if(!scripts\engine\utility::within_fov(_id_2C6CA80E296FED3A.origin, _id_2C6CA80E296FED3A.angles, self.origin, 0.766)) {
      continue;
    }
    if(_id_3359E7308038233E(_id_2C6CA80E296FED3A)) {
      _id_6B814EAFDDCCDD4D(_id_2C6CA80E296FED3A);
      return;
    }
  }
}

_id_3359E7308038233E(_id_2C6CA80E296FED3A) {
  if(!isDefined(level._id_D766FAF69209BBD6.funcs["outlineOccluded"]))
    return 0;

  if([[level._id_D766FAF69209BBD6.funcs["outlineOccluded"]]](_id_2C6CA80E296FED3A getEye(), self getEye()))
    return 1;

  return 0;
}

_id_8C2E8285C9915B12(_id_1A265C496508B47B) {
  _id_FBC7AD2D6177CE87 = spawnStruct();
  _id_FBC7AD2D6177CE87.currentvalue = _id_1A265C496508B47B;
  _id_FBC7AD2D6177CE87._id_978D9C828A6163DB = 0;
  _id_FBC7AD2D6177CE87._id_93549F28B5B2D802 = "normal";
  _id_FBC7AD2D6177CE87._id_4D49C11ADF0F1D63 = "green";
  _id_FBC7AD2D6177CE87._id_7205D3D5D54D0B33 = "blue";
  _id_FBC7AD2D6177CE87._id_29100ED6A90836BE = "red";
  _id_FBC7AD2D6177CE87._id_9275B71D42944E57 = 0;
  _id_FBC7AD2D6177CE87 = _id_F3239764175224DA(_id_FBC7AD2D6177CE87);
  _id_FBC7AD2D6177CE87 = _id_70CDE4AFF892C728(_id_FBC7AD2D6177CE87);
  _id_FBC7AD2D6177CE87 = _id_3B372246C79C0658(_id_FBC7AD2D6177CE87);
  _id_FBC7AD2D6177CE87 = _id_D7ED7D211A79CEB3(_id_FBC7AD2D6177CE87);
  _id_FBC7AD2D6177CE87 = _id_93260FADBD47622B(_id_FBC7AD2D6177CE87);
  self._id_BE1E6D7FF9628B76 = _id_FBC7AD2D6177CE87;
  self._id_B1D7DCA915C8EB6D = _id_1A265C496508B47B;
  self notify("visibilityModeVal", _id_1A265C496508B47B);
  level notify("visibilityModeValUpdatedForPlayer", self, _id_1A265C496508B47B);
}

_id_F3239764175224DA(data) {
  if(data.currentvalue >= 512) {
    data.currentvalue = data.currentvalue - 512;
    data._id_93549F28B5B2D802 = "alliesonly";
  } else if(data.currentvalue >= 256) {
    data.currentvalue = data.currentvalue - 256;
    data._id_93549F28B5B2D802 = "enemiesonly";
  } else {
    data.currentvalue = data.currentvalue - 0;
    data._id_93549F28B5B2D802 = "normal";
  }

  return data;
}

_id_70CDE4AFF892C728(data) {
  if(data.currentvalue >= 192) {
    data.currentvalue = data.currentvalue - 192;
    data._id_4D49C11ADF0F1D63 = "outline_depth_white";
  } else if(data.currentvalue >= 128) {
    data.currentvalue = data.currentvalue - 128;
    data._id_4D49C11ADF0F1D63 = "outlinefill_depth_white";
  } else if(data.currentvalue >= 64) {
    data.currentvalue = data.currentvalue - 64;
    data._id_4D49C11ADF0F1D63 = "outline_highvis_green";
  } else {
    data.currentvalue = data.currentvalue - 0;
    data._id_4D49C11ADF0F1D63 = "outlinefill_depth_green";
  }

  return data;
}

_id_3B372246C79C0658(data) {
  if(data.currentvalue >= 48) {
    data.currentvalue = data.currentvalue - 48;
    data._id_7205D3D5D54D0B33 = "outline_depth_green";
  } else if(data.currentvalue >= 32) {
    data.currentvalue = data.currentvalue - 32;
    data._id_7205D3D5D54D0B33 = "outlinefill_depth_green";
  } else if(data.currentvalue >= 16) {
    data.currentvalue = data.currentvalue - 16;
    data._id_7205D3D5D54D0B33 = "outline_depth_cyan";
  } else {
    data.currentvalue = data.currentvalue - 0;
    data._id_7205D3D5D54D0B33 = "outlinefill_depth_cyan";
  }

  return data;
}

_id_D7ED7D211A79CEB3(data) {
  if(data.currentvalue >= 12) {
    data.currentvalue = data.currentvalue - 12;
    data._id_29100ED6A90836BE = "outline_depth_yellow";
  } else if(data.currentvalue >= 8) {
    data.currentvalue = data.currentvalue - 8;
    data._id_29100ED6A90836BE = "outlinefill_depth_yellow";
  } else if(data.currentvalue >= 4) {
    data.currentvalue = data.currentvalue - 4;
    data._id_29100ED6A90836BE = "outline_depth_red";
  } else {
    data.currentvalue = data.currentvalue - 0;
    data._id_29100ED6A90836BE = "outlinefill_depth_red";
  }

  return data;
}

_id_93260FADBD47622B(data) {
  if(data.currentvalue > 2) {
    data.currentvalue = data.currentvalue - 2;
    data._id_9275B71D42944E57 = 1;
  } else {
    data.currentvalue = data.currentvalue - 0;
    data._id_9275B71D42944E57 = 0;
  }

  return data;
}

_id_40353363F8512BB0() {
  childthread _id_D26EE9FF27D79349();

  while(_id_5F46CF1503A0541A()) {
    wait 0.1;

    if(!isalive(self)) {
      continue;
    }
    if(!_id_0787341D4CC18BBA()) {
      continue;
    }
    playerads = self playerads();

    if(playerads == 1)
      childthread _id_C4E7B8218A1533CC();
  }
}

_id_C4E7B8218A1533CC() {
  _id_BDF908D5D1AAE9F2 = _id_B8618B0D8D7FF3E3();
  entity = _id_BDF908D5D1AAE9F2.entity;

  if(isDefined(entity) && isDefined(entity.team) && isDefined(entity._id_23E106FCB074622F)) {
    _id_517520758F9C478F = _id_266DA5D877397673();

    if(scripts\cp_mp\utility\player_utility::playersareenemies(entity, self)) {
      if(_id_517520758F9C478F == "alliesonly") {
        return;
      }
      _id_5000BB58F1128C5C = self _meth_B02C8E799779BC10(entity getentitynumber());

      if(_id_BDF908D5D1AAE9F2.type == "middle") {
        if(_id_5000BB58F1128C5C) {
          if(soundexists("ui_text_type"))
            self playlocalsound("ui_text_type");
        }

        if(soundexists("2pop")) {
          self playlocalsound("2pop");
          return;
        }

        return;
      }

      if(_id_BDF908D5D1AAE9F2.type == "middle_near") {
        if(_id_5000BB58F1128C5C) {
          if(soundexists("ui_menu_ability_hover"))
            self playlocalsound("ui_menu_ability_hover");
        }

        if(soundexists("2pop_low")) {
          self playlocalsound("2pop_low");
          return;
        }

        return;
      }

      if(_id_BDF908D5D1AAE9F2.type == "left") {
        if(_id_5000BB58F1128C5C) {
          if(soundexists("ui_menu_ability_hover"))
            self playlocalsound("ui_menu_ability_hover");
        }

        if(soundexists("2pop_low")) {
          self playlocalsound("2pop_low");
          return;
        }

        return;
      }

      if(_id_5000BB58F1128C5C) {
        if(soundexists("ui_menu_ability_hover"))
          self playlocalsound("ui_menu_ability_hover");
      }

      if(soundexists("2pop_low")) {
        self playlocalsound("2pop_low");
        return;
      }

      return;
      return;
      return;
    } else if(isPlayer(entity)) {
      if(_id_517520758F9C478F == "enemiesonly") {
        return;
      }
      if(soundexists("ui_chyron_firstline"))
        self playlocalsound("ui_chyron_firstline");
    } else {
      if(_id_517520758F9C478F == "enemiesonly") {
        return;
      }
      if(soundexists("ui_chyron_plusminus"))
        self playlocalsound("ui_chyron_plusminus");
    }
  }
}

_id_B8618B0D8D7FF3E3() {
  _id_30E65BD6257F2186 = self[[level._id_D766FAF69209BBD6.funcs["getADSWeaponDist"]]]();
  _id_3C70A7175FBFA3FC = self getgunangles();
  _id_8B39E5984DA1FFAF = self getEye() + anglesToForward(_id_3C70A7175FBFA3FC) * _id_30E65BD6257F2186;
  _id_5985D426AA39D205 = (0, 0, 0);
  _id_9CCFF25B22CB483B = 32;
  _id_5D9720C9F3A6DF33 = spawnStruct();
  _id_5D9720C9F3A6DF33.entity = undefined;
  _id_5D9720C9F3A6DF33.type = "middle";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 15; _id_AC0E594AC96AA3A8++) {
    if(_id_AC0E594AC96AA3A8 == 1) {
      _id_5985D426AA39D205 = rotatevector((0, _id_9CCFF25B22CB483B * -1, 0), _id_3C70A7175FBFA3FC);
      _id_5D9720C9F3A6DF33.type = "left";
    } else if(_id_AC0E594AC96AA3A8 == 2) {
      _id_5985D426AA39D205 = rotatevector((0, _id_9CCFF25B22CB483B, 0), _id_3C70A7175FBFA3FC);
      _id_5D9720C9F3A6DF33.type = "right";
    } else if(_id_AC0E594AC96AA3A8 == 3) {
      _id_5985D426AA39D205 = rotatevector((0, 0, _id_9CCFF25B22CB483B), _id_3C70A7175FBFA3FC);
      _id_5D9720C9F3A6DF33.type = "middle_near";
    } else if(_id_AC0E594AC96AA3A8 == 4) {
      _id_5985D426AA39D205 = rotatevector((0, _id_9CCFF25B22CB483B * -1, _id_9CCFF25B22CB483B), _id_3C70A7175FBFA3FC);
      _id_5D9720C9F3A6DF33.type = "left";
    } else if(_id_AC0E594AC96AA3A8 == 5) {
      _id_5985D426AA39D205 = rotatevector((0, _id_9CCFF25B22CB483B, _id_9CCFF25B22CB483B), _id_3C70A7175FBFA3FC);
      _id_5D9720C9F3A6DF33.type = "right";
    } else if(_id_AC0E594AC96AA3A8 == 6) {
      _id_5985D426AA39D205 = rotatevector((0, 0, _id_9CCFF25B22CB483B * -1), _id_3C70A7175FBFA3FC);
      _id_5D9720C9F3A6DF33.type = "middle_near";
    } else if(_id_AC0E594AC96AA3A8 == 7) {
      _id_5985D426AA39D205 = rotatevector((0, _id_9CCFF25B22CB483B * -1, _id_9CCFF25B22CB483B * -1), _id_3C70A7175FBFA3FC);
      _id_5D9720C9F3A6DF33.type = "left";
    } else if(_id_AC0E594AC96AA3A8 == 8) {
      _id_5985D426AA39D205 = rotatevector((0, _id_9CCFF25B22CB483B, _id_9CCFF25B22CB483B * -1), _id_3C70A7175FBFA3FC);
      _id_5D9720C9F3A6DF33.type = "right";
    } else if(_id_AC0E594AC96AA3A8 == 9) {
      _id_5985D426AA39D205 = rotatevector((0, _id_9CCFF25B22CB483B * -2, _id_9CCFF25B22CB483B), _id_3C70A7175FBFA3FC);
      _id_5D9720C9F3A6DF33.type = "left";
    } else if(_id_AC0E594AC96AA3A8 == 10) {
      _id_5985D426AA39D205 = rotatevector((0, _id_9CCFF25B22CB483B * -2, 0), _id_3C70A7175FBFA3FC);
      _id_5D9720C9F3A6DF33.type = "left";
    } else if(_id_AC0E594AC96AA3A8 == 11) {
      _id_5985D426AA39D205 = rotatevector((0, _id_9CCFF25B22CB483B * -2, _id_9CCFF25B22CB483B * -1), _id_3C70A7175FBFA3FC);
      _id_5D9720C9F3A6DF33.type = "left";
    } else if(_id_AC0E594AC96AA3A8 == 12) {
      _id_5985D426AA39D205 = rotatevector((0, _id_9CCFF25B22CB483B * 2, _id_9CCFF25B22CB483B), _id_3C70A7175FBFA3FC);
      _id_5D9720C9F3A6DF33.type = "right";
    } else if(_id_AC0E594AC96AA3A8 == 13) {
      _id_5985D426AA39D205 = rotatevector((0, _id_9CCFF25B22CB483B * 2, 0), _id_3C70A7175FBFA3FC);
      _id_5D9720C9F3A6DF33.type = "right";
    } else if(_id_AC0E594AC96AA3A8 == 14) {
      _id_5985D426AA39D205 = rotatevector((0, _id_9CCFF25B22CB483B * 2, _id_9CCFF25B22CB483B * -1), _id_3C70A7175FBFA3FC);
      _id_5D9720C9F3A6DF33.type = "right";
    }

    trace = scripts\engine\trace::ray_trace(self getEye(), _id_8B39E5984DA1FFAF + _id_5985D426AA39D205);

    if(isDefined(trace["entity"]) && (isPlayer(trace["entity"]) || issentient(trace["entity"]))) {
      if(_id_5D9720C9F3A6DF33.type == "middle")
        _id_5D9720C9F3A6DF33.type = _id_04FFAD916A54CA2F(trace, _id_3C70A7175FBFA3FC, _id_30E65BD6257F2186);

      _id_5D9720C9F3A6DF33.entity = trace["entity"];
      return _id_5D9720C9F3A6DF33;
    }
  }

  return _id_5D9720C9F3A6DF33;
}

_id_04FFAD916A54CA2F(trace, _id_3C70A7175FBFA3FC, _id_30E65BD6257F2186) {
  _id_2E3BC21C15E7AB6C = trace["position"];
  _id_1DC4C86806743C5C = trace["entity"] getEye();
  _id_DB58AC8CD20F8954 = trace["entity"] gettagorigin("tag_origin", 1);
  _id_734D8FCBDD28F284 = self getEye() + anglesToForward(_id_3C70A7175FBFA3FC) * (_id_30E65BD6257F2186 * 1.5);

  if(isDefined(_id_1DC4C86806743C5C) && isDefined(_id_DB58AC8CD20F8954)) {
    data = scripts\engine\utility::closestdistancebetweenlines(_id_DB58AC8CD20F8954, _id_1DC4C86806743C5C, self getEye(), _id_734D8FCBDD28F284);

    if(isDefined(data) && data[2] < 7)
      return "middle";
    else if(isDefined(data)) {
      up = anglestoup(_id_3C70A7175FBFA3FC);
      _id_8A15205372A55A43 = _func_767CEA82B001F645(_id_734D8FCBDD28F284 - self.origin);
      _id_6A4277FF9E64049F = _func_767CEA82B001F645(_id_DB58AC8CD20F8954 - self.origin);
      _id_C5F68CDF7B9421D9 = scripts\engine\math::anglebetweenvectorssigned(_id_8A15205372A55A43, _id_6A4277FF9E64049F, up);

      if(_id_C5F68CDF7B9421D9 > 0)
        return "right";
      else
        return "left";
    }
  }

  return "middle";
}

_id_D26EE9FF27D79349() {
  self._id_FF7A6CAA0A544D30 = 0;
  self._id_44446BD6D8FD6ED0 = 0;
  self notifyonplayercommand("vis_sprint_pressed", "+breath_sprint");
  self notifyonplayercommand("vis_sprint_pressed", "+melee_breath");

  while(_id_5F46CF1503A0541A()) {
    wait 0.1;

    if(!isalive(self)) {
      continue;
    }
    if(!_id_0787341D4CC18BBA()) {
      wait 1;
      continue;
    }

    playerads = self playerads();

    if(playerads == 1) {
      if(self._id_FF7A6CAA0A544D30 == 0) {
        self._id_FF7A6CAA0A544D30 = 1;
        thread _id_DC7453C8550C512C();
        thread _id_EEC104C84DC70618("vis_sprint_pressed");
      }

      continue;
    }

    if(playerads < 1) {
      self._id_FF7A6CAA0A544D30 = 0;
      self._id_44446BD6D8FD6ED0 = 0;
      self notify("visibilityMode_stopads");
    }
  }
}

_id_EEC104C84DC70618(type) {
  self endon("death_or_disconnect");
  self endon("visibilityMode_stopads");

  if(type == "vis_sprint_pressed") {
    for(;;) {
      self waittill("vis_sprint_pressed");
      _id_B17C1EBA153A25E8();
      _id_5C04DCD5E95FBB53();
      _id_49AFC10334084167();
    }
  }
}

_id_B17C1EBA153A25E8() {
  if(self getstance() != "prone") {
    return;
  }
  angles = (0, self.angles[1], self.angles[2]);
  self setplayerangles(angles);
}

_id_5C04DCD5E95FBB53() {
  self endon("death_or_disconnect");
  self endon("visibilityMode_stopads");

  if(istrue(level._id_D766FAF69209BBD6._id_419D1A784E4B187C)) {
    return;
  }
  _id_FB4C50D90A50B2DC = _id_E3C04F03881B4DC7();
  _id_C76806C8C53C93EE = [];
  _id_B94177401C42C6EF = [];

  foreach(ally in _id_FB4C50D90A50B2DC) {
    if(isPlayer(ally)) {
      _id_C76806C8C53C93EE[_id_C76806C8C53C93EE.size] = ally;
      continue;
    }

    _id_B94177401C42C6EF[_id_B94177401C42C6EF.size] = ally;
  }

  _id_C76806C8C53C93EE = sortbydistance(_id_C76806C8C53C93EE, self.origin);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C76806C8C53C93EE.size; _id_AC0E594AC96AA3A8++) {
    if(_id_C76806C8C53C93EE[_id_AC0E594AC96AA3A8] == self) {
      continue;
    }
    if(!isDefined(_id_C76806C8C53C93EE[_id_AC0E594AC96AA3A8]) || !_id_C76806C8C53C93EE[_id_AC0E594AC96AA3A8] scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(!istrue(_id_C76806C8C53C93EE[_id_AC0E594AC96AA3A8].inlaststand)) {
      if(soundexists("uin_ping_confirm"))
        _id_C76806C8C53C93EE[_id_AC0E594AC96AA3A8] playsoundtoplayer("uin_ping_confirm", self);
    } else if(soundexists("uin_ping_wheel_announce_help"))
      _id_C76806C8C53C93EE[_id_AC0E594AC96AA3A8] playsoundtoplayer("uin_ping_wheel_announce_help", self);

    if(_id_C76806C8C53C93EE.size > 1)
      wait 0.2;
  }

  if(_id_C76806C8C53C93EE.size > 0)
    wait 0.5;
}

_id_DC7453C8550C512C() {
  self endon("death_or_disconnect");
  self endon("visibilityMode_stopads");

  if(self._id_44446BD6D8FD6ED0 == 0)
    self._id_44446BD6D8FD6ED0 = 1;
  else
    return;

  maxdist = self[[level._id_D766FAF69209BBD6.funcs["getADSWeaponDist"]]]();
  _id_CDC5DD6C28C9709D = squared(maxdist);
  _id_9103858B121B07EE = _id_090CE2459298D263();
  _id_9103858B121B07EE = sortbydistance(_id_9103858B121B07EE, self.origin);
  _id_72013161599ED91B = min(5, _id_9103858B121B07EE.size);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_72013161599ED91B; _id_AC0E594AC96AA3A8++) {
    if(!_id_8EEE51AF38988DB6(self, _id_9103858B121B07EE[_id_AC0E594AC96AA3A8])) {
      continue;
    }
    if(!isDefined(_id_9103858B121B07EE[_id_AC0E594AC96AA3A8]) || !_id_9103858B121B07EE[_id_AC0E594AC96AA3A8] scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    _id_C92A4399B993144A = distancesquared(_id_9103858B121B07EE[_id_AC0E594AC96AA3A8].origin, self.origin);

    if(_id_C92A4399B993144A < _id_CDC5DD6C28C9709D) {
      if(soundexists("uin_ping_enemy")) {
        _id_9103858B121B07EE[_id_AC0E594AC96AA3A8] playsoundtoplayer("uin_ping_enemy", self);
        delay = scripts\engine\math::remap(_id_C92A4399B993144A, 0, _id_CDC5DD6C28C9709D, 0.15, 0.6);
        wait(delay);
      }
    }
  }
}

_id_49AFC10334084167() {
  self endon("death_or_disconnect");
  self endon("visibilityMode_stopads");

  if(istrue(level._id_D766FAF69209BBD6._id_A7628FAB5ECE8D7A)) {
    return;
  }
  scripts\engine\utility::flag_wait("objectives_registered");
  _id_04267B02EDA9E961 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.worldobjidpool.active.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(level.worldobjidpool.active[_id_AC0E594AC96AA3A8].identifier) && level.worldobjidpool.active[_id_AC0E594AC96AA3A8].identifier == "nonobj_marker") {
      continue;
    }
    objstruct = spawnStruct();
    objstruct._id_6A7A0A172BE2F436 = level.worldobjidpool.active[_id_AC0E594AC96AA3A8];
    objstruct.origin = _func_05651D05B13FCF64(level.worldobjidpool.active[_id_AC0E594AC96AA3A8].objid, 0);
    _id_04267B02EDA9E961[_id_04267B02EDA9E961.size] = objstruct;
  }

  _id_04267B02EDA9E961 = sortbydistance(_id_04267B02EDA9E961, self.origin);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_04267B02EDA9E961.size; _id_AC0E594AC96AA3A8++) {
    _id_08137CAFF89EFD99 = _id_BD41D880DB5C1BAD(_id_04267B02EDA9E961[_id_AC0E594AC96AA3A8]._id_6A7A0A172BE2F436.identifier);

    if(isDefined(_id_08137CAFF89EFD99))
      level thread _id_95CD04544BC213E5(_id_04267B02EDA9E961[_id_AC0E594AC96AA3A8].origin, self, _id_08137CAFF89EFD99);
    else
      level thread _id_95CD04544BC213E5(_id_04267B02EDA9E961[_id_AC0E594AC96AA3A8].origin, self);

    if(_id_04267B02EDA9E961.size > 1)
      wait 1;
  }
}

_id_95CD04544BC213E5(origin, player, _id_AECB65519ABB47C1) {
  tag_origin = spawn("script_model", origin);
  tag_origin setModel("tag_origin");
  _id_90E6BC3A37537C77 = "uin_ping_mission";

  if(isDefined(_id_AECB65519ABB47C1))
    _id_90E6BC3A37537C77 = _id_AECB65519ABB47C1;

  tag_origin playsoundtoplayer(_id_90E6BC3A37537C77, player);
  wait(lookupsoundlength(_id_90E6BC3A37537C77) / 1000);
  tag_origin delete();
}

_id_BD41D880DB5C1BAD(_id_BC23A0A6125C16F4) {
  if(isDefined(level._id_D766FAF69209BBD6._id_3A5F706A07632F07)) {
    foreach(index, sound in level._id_D766FAF69209BBD6._id_3A5F706A07632F07) {
      if(index == _id_BC23A0A6125C16F4)
        return sound;
    }
  }

  return undefined;
}

_id_7068F93AACF2EF59(_id_BC23A0A6125C16F4, soundalias) {
  if(!isDefined(level._id_D766FAF69209BBD6)) {
    return;
  }
  if(!isDefined(level._id_D766FAF69209BBD6._id_3A5F706A07632F07))
    level._id_D766FAF69209BBD6._id_3A5F706A07632F07 = [];

  if(isDefined(level._id_D766FAF69209BBD6._id_3A5F706A07632F07[_id_BC23A0A6125C16F4])) {
    return;
  }
  level._id_D766FAF69209BBD6._id_3A5F706A07632F07[_id_BC23A0A6125C16F4] = soundalias;
}

_id_8EEE51AF38988DB6(player, target) {
  if(!scripts\engine\utility::within_fov(player.origin, player.angles, target.origin, 0.766))
    return 0;

  _id_D539DD4D949070D9 = player getEye();
  _id_8588CE8CB050BAF3 = target.origin;

  if(sighttracepassed(_id_D539DD4D949070D9, _id_8588CE8CB050BAF3, 1, player, target))
    return 1;

  _id_18718F98529A77D8 = undefined;

  if(isagent(target))
    _id_18718F98529A77D8 = target getapproxeyepos();
  else
    _id_18718F98529A77D8 = target getEye();

  if(sighttracepassed(_id_D539DD4D949070D9, _id_18718F98529A77D8, 1, player, target))
    return 1;

  _id_59A0BA7C30F92D0B = (_id_18718F98529A77D8 + _id_8588CE8CB050BAF3) * 0.5;

  if(sighttracepassed(_id_D539DD4D949070D9, _id_59A0BA7C30F92D0B, 1, player, target))
    return 1;

  return 0;
}

_id_5F46CF1503A0541A() {
  if(isDefined(self._id_B1D7DCA915C8EB6D))
    return self._id_B1D7DCA915C8EB6D > 0;

  return 0;
}

_id_EA4E39208C784A4A() {
  color = "outline_depth_red";

  if(isDefined(self._id_BE1E6D7FF9628B76) && isDefined(self._id_BE1E6D7FF9628B76._id_29100ED6A90836BE))
    color = self._id_BE1E6D7FF9628B76._id_29100ED6A90836BE;

  return color;
}

_id_4448756918B98E87() {
  color = "outline_depth_cyan";

  if(isDefined(self._id_BE1E6D7FF9628B76) && isDefined(self._id_BE1E6D7FF9628B76._id_7205D3D5D54D0B33))
    color = self._id_BE1E6D7FF9628B76._id_7205D3D5D54D0B33;

  return color;
}

_id_63A1833B6A352CD7() {
  color = "outline_highvis_green";

  if(isDefined(self._id_BE1E6D7FF9628B76) && isDefined(self._id_BE1E6D7FF9628B76._id_4D49C11ADF0F1D63))
    color = self._id_BE1E6D7FF9628B76._id_4D49C11ADF0F1D63;

  return color;
}

_id_266DA5D877397673() {
  mode = "normal";

  if(isDefined(self._id_BE1E6D7FF9628B76) && isDefined(self._id_BE1E6D7FF9628B76._id_93549F28B5B2D802))
    mode = self._id_BE1E6D7FF9628B76._id_93549F28B5B2D802;

  return mode;
}

_id_0787341D4CC18BBA() {
  _id_9275B71D42944E57 = 0;

  if(isDefined(self._id_BE1E6D7FF9628B76) && isDefined(self._id_BE1E6D7FF9628B76._id_9275B71D42944E57))
    _id_9275B71D42944E57 = self._id_BE1E6D7FF9628B76._id_9275B71D42944E57;

  return _id_9275B71D42944E57;
}

_id_88EC96D66632C2B9() {
  _id_0C68737226B9498A = [[level._id_D766FAF69209BBD6.funcs["getTargetArray"]]](self);
  _id_86BE86845D4493C7 = [];
  _id_6EA8E24D4901E87C = self getentitynumber();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0C68737226B9498A.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_0C68737226B9498A[_id_AC0E594AC96AA3A8]._id_79A7C8A11ED7C0E3)) {
      if(isDefined(_id_0C68737226B9498A[_id_AC0E594AC96AA3A8]._id_79A7C8A11ED7C0E3[_id_6EA8E24D4901E87C]))
        _id_86BE86845D4493C7[_id_86BE86845D4493C7.size] = _id_0C68737226B9498A[_id_AC0E594AC96AA3A8];
    }
  }

  return _id_86BE86845D4493C7;
}

_id_090CE2459298D263() {
  _id_DFAEDAFC60ECA531 = _id_88EC96D66632C2B9();
  _id_0A85B3BF58543DC2 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_DFAEDAFC60ECA531.size; _id_AC0E594AC96AA3A8++) {
    if(scripts\cp_mp\utility\player_utility::playersareenemies(_id_DFAEDAFC60ECA531[_id_AC0E594AC96AA3A8], self))
      _id_0A85B3BF58543DC2[_id_0A85B3BF58543DC2.size] = _id_DFAEDAFC60ECA531[_id_AC0E594AC96AA3A8];
  }

  return _id_0A85B3BF58543DC2;
}

_id_E3C04F03881B4DC7() {
  _id_DFAEDAFC60ECA531 = _id_88EC96D66632C2B9();
  _id_0A85B3BF58543DC2 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_DFAEDAFC60ECA531.size; _id_AC0E594AC96AA3A8++) {
    if(!scripts\cp_mp\utility\player_utility::playersareenemies(_id_DFAEDAFC60ECA531[_id_AC0E594AC96AA3A8], self))
      _id_0A85B3BF58543DC2[_id_0A85B3BF58543DC2.size] = _id_DFAEDAFC60ECA531[_id_AC0E594AC96AA3A8];
  }

  return _id_0A85B3BF58543DC2;
}

_id_C1D9FD48EB09C8C9() {
  if(isDefined(level.players)) {
    activeplayers = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      if(level.players[_id_AC0E594AC96AA3A8] _id_5F46CF1503A0541A())
        activeplayers[activeplayers.size] = level.players[_id_AC0E594AC96AA3A8];
    }

    return activeplayers;
  } else if(isDefined(level.player))
    return level.player _id_5F46CF1503A0541A();
  else
    return [];
}

_id_8977A3724EC5CE9E() {
  level endon("game_ended");
  dvar = "dvar_5ECD08979278A317";

  for(;;) {
    for(;;) {
      _id_4F9DF27618277B1E = getDvar(dvar, "");

      if(_id_4F9DF27618277B1E != "") {
        level thread _id_BF79C9A4BC54B7DA(_id_4F9DF27618277B1E);
        setDvar(dvar, "");
      }

      wait 0.1;
    }

    wait 0.1;
  }
}

_id_BF79C9A4BC54B7DA(val) {
  val = int(val);
  level.players[0] _id_8C2E8285C9915B12(val);
}