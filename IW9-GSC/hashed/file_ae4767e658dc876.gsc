/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_ae4767e658dc876.gsc
***********************************************/

_id_4FC6DF7E1EEA9EB2() {
  level.next_board_to_repair_func = ::_id_72239E53273C92C2;
  level._id_FE1046164E280980 = [];
  level.window_entrances = scripts\engine\utility::getStructArray("window_entrance", "targetname");
  scripts\engine\utility::array_thread(level.window_entrances, ::_id_2EB830BF763EC59F);
}

_id_FBA2BC61F8C954A9() {
  wait 5;

  for(;;) {
    _id_0D32078955171127 = scripts\engine\utility::getclosest(level.players[0].origin, level.window_entrances);
    _id_FDC11BA76911059E = scripts\engine\utility::getStructArray(_id_0D32078955171127.target, "targetname");
    _id_FDC11BA76911059E = scripts\engine\utility::array_add_safe(_id_FDC11BA76911059E, _id_0D32078955171127);

    foreach(_id_0C3EA9B1A20FF199 in _id_FDC11BA76911059E) {
      yaw = 0;

      if(isDefined(_id_0C3EA9B1A20FF199.angles))
        yaw = _id_0C3EA9B1A20FF199.angles[1];

      color = (0, 1, 0);

      if(_id_E244B2773B8A39CF(_id_0C3EA9B1A20FF199))
        color = (1, 0, 0);
    }

    wait 0.25;
  }
}

_id_2EB830BF763EC59F() {
  self.enabled = 0;
  self._id_DB6B2B512CB17207 = undefined;
  targets = getEntArray(self.target, "targetname");

  if(targets.size) {
    foreach(target in targets) {
      if(isDefined(target.script_noteworthy) && target.script_noteworthy == "clip") {
        self.clip = target;
        continue;
      }

      self.barrier = target;
    }
  }

  self.barrier._id_52213C216549ADC9 = 6;
  self.barrier._id_B9715A616B5A64C4 = [];
  self.barrier._id_B9715A616B5A64C4[0] = "boarded";
  self.barrier._id_B9715A616B5A64C4[1] = "boarded";
  self.barrier._id_B9715A616B5A64C4[2] = "boarded";
  self.barrier._id_B9715A616B5A64C4[3] = "boarded";
  self.barrier._id_B9715A616B5A64C4[4] = "boarded";
  self.barrier._id_B9715A616B5A64C4[5] = "boarded";
  _id_BC012E4B86892733 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(_id_0C3EA9B1A20FF199 in _id_BC012E4B86892733) {
    if(isDefined(_id_0C3EA9B1A20FF199.script_noteworthy) && _id_0C3EA9B1A20FF199.script_noteworthy == "attack_spot") {
      self._id_DEF78C0FFA5DAF9D = _id_0C3EA9B1A20FF199;
      continue;
    }

    _id_0C3EA9B1A20FF199._id_DB6B2B512CB17207 = undefined;
    _id_0C3EA9B1A20FF199.enabled = 0;
    level._id_FE1046164E280980[level._id_FE1046164E280980.size] = _id_0C3EA9B1A20FF199;
  }

  level._id_FE1046164E280980[level._id_FE1046164E280980.size] = self;
  interaction = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("secure_window", "script_noteworthy"));
  self.script_noteworthy = _id_DCC29A3A6ABAD7EE(interaction);
  self.script_label = "mid";

  if(isDefined(self.script_tag) && self.script_tag == "extended")
    self._id_886A9D7510157DEC = 1;

  _id_DE40082E48FF7CC9 = anglestoright(self.angles);

  foreach(_id_0C3EA9B1A20FF199 in _id_BC012E4B86892733) {
    _id_A06D5AC9D3A6492D = _id_0C3EA9B1A20FF199.origin - self.origin;
    dot = vectordot(_id_A06D5AC9D3A6492D, _id_DE40082E48FF7CC9);

    if(dot > 0)
      _id_0C3EA9B1A20FF199.script_label = "left";
    else
      _id_0C3EA9B1A20FF199.script_label = "right";

    if(istrue(self._id_886A9D7510157DEC))
      _id_0C3EA9B1A20FF199._id_886A9D7510157DEC = 1;
  }
}

_id_DCC29A3A6ABAD7EE(interaction) {
  volumes = getEntArray("spawn_volume", "targetname");

  foreach(volume in volumes) {
    if(ispointinvolume(interaction.origin, volume))
      return volume.script_linkname;
  }

  return undefined;
}

_id_8CB19E3B36ED0EC6(attack_spot) {
  attack_spot.enabled = 1;
  attack_spot._id_DB6B2B512CB17207 = undefined;
  _id_BC012E4B86892733 = scripts\engine\utility::getStructArray(attack_spot.target, "targetname");

  foreach(_id_0C3EA9B1A20FF199 in _id_BC012E4B86892733) {
    _id_0C3EA9B1A20FF199._id_DB6B2B512CB17207 = undefined;
    _id_0C3EA9B1A20FF199.enabled = 1;
  }
}

_id_C6A2CAA6DB09379B(attack_spot) {
  attack_spot.enabled = 0;
  attack_spot._id_DB6B2B512CB17207 = undefined;
  _id_BC012E4B86892733 = scripts\engine\utility::getStructArray(attack_spot.target, "targetname");

  foreach(_id_0C3EA9B1A20FF199 in _id_BC012E4B86892733) {
    _id_0C3EA9B1A20FF199._id_DB6B2B512CB17207 = undefined;
    _id_0C3EA9B1A20FF199.enabled = 0;
  }
}

_id_030C8F78F5B0F51A(_id_7E352803B2D9BC36) {
  _id_771800B6FB3A4C46 = scripts\engine\utility::getStructArray(_id_7E352803B2D9BC36, "script_noteworthy");

  foreach(_id_4B37C1DF960B78D1 in _id_771800B6FB3A4C46)
  _id_8CB19E3B36ED0EC6(_id_4B37C1DF960B78D1);
}

_id_0F28D58A3D6E7F7F(_id_0D32078955171127, _id_EEE718E33217DC9E) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0D32078955171127._id_41856677E1F1EC3D; _id_AC0E594AC96AA3A8++) {
    if(_id_0D32078955171127._id_AF25E4A5F1045D14[_id_AC0E594AC96AA3A8] == _id_EEE718E33217DC9E)
      return _id_AC0E594AC96AA3A8;
  }

  return undefined;
}

_id_C3E941B6F08E09F2(_id_0D32078955171127) {
  if(!isDefined(_id_0D32078955171127._id_AF25E4A5F1045D14)) {
    return;
  }
  index = _id_0F28D58A3D6E7F7F(_id_0D32078955171127, self);

  if(!isDefined(index)) {
    return;
  }
  if(_id_0D32078955171127._id_41856677E1F1EC3D == 1) {
    _id_0D32078955171127._id_AF25E4A5F1045D14 = [];
    _id_0D32078955171127._id_41856677E1F1EC3D = 0;
  } else {
    _id_0D32078955171127._id_AF25E4A5F1045D14[index] = _id_0D32078955171127._id_AF25E4A5F1045D14[_id_0D32078955171127._id_41856677E1F1EC3D - 1];
    _id_0D32078955171127._id_AF25E4A5F1045D14[_id_0D32078955171127._id_41856677E1F1EC3D - 1] = undefined;
    _id_0D32078955171127._id_41856677E1F1EC3D--;
  }
}

_id_2FE504FA79344506(_id_0D32078955171127) {
  _id_C3E941B6F08E09F2(_id_0D32078955171127);

  if(!isDefined(_id_0D32078955171127._id_AF25E4A5F1045D14)) {
    _id_0D32078955171127._id_AF25E4A5F1045D14 = [];
    _id_0D32078955171127._id_41856677E1F1EC3D = 0;
  }

  index = _id_0D32078955171127._id_41856677E1F1EC3D;
  _id_0D32078955171127._id_AF25E4A5F1045D14[index] = self;
  _id_0D32078955171127._id_41856677E1F1EC3D++;
}

_id_E3D0C615074C4014() {
  foreach(_id_0D32078955171127 in level.window_entrances)
  _id_8CB19E3B36ED0EC6(_id_0D32078955171127);
}

_id_B706E9A22C3F85A8(org) {
  _id_09E859286E166B28 = scripts\engine\utility::get_array_of_closest(org, level.window_entrances);

  foreach(_id_0D32078955171127 in _id_09E859286E166B28) {
    if(!_id_A521CF63997D5421(_id_0D32078955171127))
      return _id_0D32078955171127;
  }

  return undefined;
}

_id_5D11906B196A1764(org, _id_39C23DA6A27586E8) {
  _id_09E859286E166B28 = sortbydistance(level.window_entrances, org);

  foreach(_id_0D32078955171127 in _id_09E859286E166B28) {
    if(isDefined(_id_39C23DA6A27586E8)) {
      if(_id_0D32078955171127 == _id_39C23DA6A27586E8)
        _id_39C23DA6A27586E8 = undefined;

      continue;
    }

    if(_id_0D32078955171127.enabled)
      return _id_0D32078955171127;
  }

  return undefined;
}

_id_348250AF323A523E(_id_5B44FF42D92F79B0) {
  return _id_5B44FF42D92F79B0.enabled;
}

_id_A521CF63997D5421(_id_0D32078955171127) {
  if(isDefined(_id_0D32078955171127.barrier) && _id_0D32078955171127.barrier._id_52213C216549ADC9 > 0)
    return 1;

  return 0;
}

_id_5714453DD422F178(attack_spot) {
  attack_spot._id_DB6B2B512CB17207 = undefined;
}

_id_16716D74E405BE15(attack_spot) {
  attack_spot._id_DB6B2B512CB17207 = self;
}

_id_E244B2773B8A39CF(attack_spot) {
  if(isDefined(attack_spot._id_DB6B2B512CB17207) && isalive(attack_spot._id_DB6B2B512CB17207))
    return 1;

  return 0;
}

_id_BF1932E23542632E(attack_spot) {
  return !_id_E244B2773B8A39CF(attack_spot);
}

_id_7736C350B89A5096() {
  rightdir = anglestoright(self.angles);
  _id_BC012E4B86892733 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(attack_spot in _id_BC012E4B86892733) {
    _id_3777ECE6A73EADA5 = attack_spot.origin - self.origin;
    _id_00D45030EDB8FBA9 = vectordot(_id_3777ECE6A73EADA5, rightdir);

    if(_id_00D45030EDB8FBA9 > 0) {
      self._id_7364FED179E36192 = attack_spot;
      continue;
    }

    self._id_84FBF1D0FACF96B1 = attack_spot;
  }
}

_id_41C10856E231EDC2() {
  temp = (0, 0, 0);

  foreach(_id_EEE718E33217DC9E in self._id_AF25E4A5F1045D14)
  temp = temp + _id_EEE718E33217DC9E.origin;

  _id_673DD98CBFA6B6EA = (temp[0] / self._id_41856677E1F1EC3D, temp[1] / self._id_41856677E1F1EC3D, temp[2] / self._id_41856677E1F1EC3D);
  _id_73F909D58240611C = sortbydistance(self._id_AF25E4A5F1045D14, _id_673DD98CBFA6B6EA);
  return _id_73F909D58240611C[0];
}

_id_E1D84D7BD7DFEF57(_id_4C04C2799DC1CD7F, dir) {
  _id_3777ECE6A73EADA5 = self.origin - _id_4C04C2799DC1CD7F.origin;
  _id_855EE3B9E482D183 = (_id_3777ECE6A73EADA5[0], _id_3777ECE6A73EADA5[1], 0);
  _id_00D45030EDB8FBA9 = vectordot(_id_855EE3B9E482D183, dir);

  if(_id_00D45030EDB8FBA9 > 0)
    return 1;

  return 0;
}

_id_5C725BD22ADD81FB(_id_5B44FF42D92F79B0) {
  if(!isDefined(_id_5B44FF42D92F79B0._id_84FBF1D0FACF96B1) && !isDefined(_id_5B44FF42D92F79B0._id_7364FED179E36192))
    _id_5B44FF42D92F79B0 _id_7736C350B89A5096();

  if(_id_5B44FF42D92F79B0._id_41856677E1F1EC3D <= 1)
    return _id_5B44FF42D92F79B0;

  if(_id_5B44FF42D92F79B0._id_41856677E1F1EC3D > 1) {
    _id_4C04C2799DC1CD7F = _id_5B44FF42D92F79B0 _id_41C10856E231EDC2();
    rightdir = anglestoright(_id_5B44FF42D92F79B0.angles);
    _id_C97984F220F9C0B3 = anglestoleft(_id_5B44FF42D92F79B0.angles);

    if(self == _id_4C04C2799DC1CD7F)
      return _id_5B44FF42D92F79B0;

    if(isDefined(_id_5B44FF42D92F79B0._id_7364FED179E36192) && _id_E1D84D7BD7DFEF57(_id_4C04C2799DC1CD7F, rightdir))
      return _id_5B44FF42D92F79B0._id_7364FED179E36192;

    if(isDefined(_id_5B44FF42D92F79B0._id_84FBF1D0FACF96B1) && _id_E1D84D7BD7DFEF57(_id_4C04C2799DC1CD7F, _id_C97984F220F9C0B3))
      return _id_5B44FF42D92F79B0._id_84FBF1D0FACF96B1;
  }

  _id_BC012E4B86892733 = scripts\engine\utility::getStructArray(_id_5B44FF42D92F79B0.target, "targetname");
  _id_BC012E4B86892733 = scripts\engine\utility::array_add_safe(_id_BC012E4B86892733, _id_5B44FF42D92F79B0);
  _id_30713088D8445006 = sortbydistance(_id_BC012E4B86892733, self.origin);
  return _id_30713088D8445006[0];
}

_id_313228003382F332(_id_5B44FF42D92F79B0) {
  _id_2C5D930D2B76362B = _id_5C725BD22ADD81FB(_id_5B44FF42D92F79B0);

  if(isDefined(_id_2C5D930D2B76362B) && _id_BF1932E23542632E(_id_2C5D930D2B76362B))
    return _id_2C5D930D2B76362B;

  _id_BC012E4B86892733 = scripts\engine\utility::getStructArray(_id_5B44FF42D92F79B0.target, "targetname");
  _id_BC012E4B86892733 = scripts\engine\utility::array_add_safe(_id_BC012E4B86892733, _id_5B44FF42D92F79B0);
  _id_BC012E4B86892733 = scripts\engine\utility::array_randomize(_id_BC012E4B86892733);

  foreach(_id_0C3EA9B1A20FF199 in _id_BC012E4B86892733) {
    if(_id_BF1932E23542632E(_id_0C3EA9B1A20FF199))
      return _id_0C3EA9B1A20FF199;
  }

  if(isDefined(_id_2C5D930D2B76362B))
    return _id_2C5D930D2B76362B;

  return scripts\engine\utility::random(_id_BC012E4B86892733);
}

_id_E71626C4B4F60736(_id_0D32078955171127, _id_C7C594511C61EC5F, state) {
  _id_0D32078955171127.barrier._id_B9715A616B5A64C4[_id_C7C594511C61EC5F] = state;
}

_id_43A6309B8367993A(_id_0D32078955171127, _id_C7C594511C61EC5F) {
  return _id_0D32078955171127.barrier._id_B9715A616B5A64C4[_id_C7C594511C61EC5F];
}

_id_11761A4A952726D6(_id_0D32078955171127) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++) {
    if(_id_0D32078955171127.barrier._id_B9715A616B5A64C4[_id_AC0E594AC96AA3A8] == "boarded")
      return _id_AC0E594AC96AA3A8 + 1;
  }
}

_id_72239E53273C92C2(_id_0D32078955171127) {
  for(_id_AC0E594AC96AA3A8 = 5; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    if(_id_0D32078955171127.barrier._id_B9715A616B5A64C4[_id_AC0E594AC96AA3A8] == "destroyed")
      return _id_AC0E594AC96AA3A8 + 1;
  }
}

_id_85E0FB7FEB6205D9(_id_0D32078955171127, _id_DB46F0EC0CC7C99F) {
  if(!_id_A521CF63997D5421(_id_0D32078955171127)) {
    return;
  }
  _id_2A608C5EDC78AEFA = scripts\engine\utility::getStructArray("secure_window", "script_noteworthy");
  _id_DF071553D0996FF9 = scripts\engine\utility::getclosest(_id_0D32078955171127.origin, _id_2A608C5EDC78AEFA);

  if(!isDefined(_id_DB46F0EC0CC7C99F)) {
    _id_DB46F0EC0CC7C99F = _id_0D32078955171127.barrier._id_52213C216549ADC9;

    if(_id_DB46F0EC0CC7C99F > 6)
      _id_DB46F0EC0CC7C99F = 6;
    else if(_id_DB46F0EC0CC7C99F < 1)
      _id_DB46F0EC0CC7C99F = 1;
  }

  _id_0D32078955171127.barrier _id_E8C53F0729392321("board_" + _id_DB46F0EC0CC7C99F, "destroy");
  _id_0D32078955171127.barrier._id_52213C216549ADC9--;

  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, _id_DF071553D0996FF9))
    level.current_interaction_structs = scripts\engine\utility::array_add(level.current_interaction_structs, _id_DF071553D0996FF9);

  _id_DF071553D0996FF9.disabled = 0;

  if(_id_0D32078955171127.barrier._id_52213C216549ADC9 < 1)
    _id_DF071553D0996FF9.disabled = 0;
}

_id_E8C53F0729392321(_id_C7C594511C61EC5F, state) {
  if(_id_C7C594511C61EC5F == "all" && state == "rebuild") {
    self setscriptablepartstate("board_1", "instant_rebuild");
    self setscriptablepartstate("board_2", "instant_rebuild");
    self setscriptablepartstate("board_3", "instant_rebuild");
    self setscriptablepartstate("board_4", "instant_rebuild");
    self setscriptablepartstate("board_5", "instant_rebuild");
    self setscriptablepartstate("board_6", "instant_rebuild");
  } else
    self setscriptablepartstate(_id_C7C594511C61EC5F, state);
}