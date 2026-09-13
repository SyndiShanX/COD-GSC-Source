/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4a7f448ed5fa7fec.gsc
***********************************************/

init(itemlist) {
  if(!isDefined(itemlist) || itemlist.size <= 0) {
    return;
  }
  level._id_AEB78277D6F21982 = [];
  level thread _id_5923928ABF319809(itemlist);
  level thread _id_5366608003E817BC();
}

_id_5366608003E817BC() {
  level endon("game_ended");

  while(!isDefined(level.struct_class_names))
    waitframe();

  level._id_8906F56063970306 = [];
  _id_CC65231D5F44AA17 = scripts\engine\utility::getStructArray("bio_puzzle_door_struct", "script_noteworthy");

  foreach(_id_D6AFF3BEFA51BD6F in _id_CC65231D5F44AA17) {
    _id_602105E14E6E984E = spawnStruct();
    _id_602105E14E6E984E.parts = [];
    _id_602105E14E6E984E._id_446135EB7FDAD263 = [];
    _id_602105E14E6E984E.doors = [];
    _id_602105E14E6E984E.script_label = _id_D6AFF3BEFA51BD6F.script_label;
    _id_ACB1C43711ABC792 = 1;

    foreach(struct in getentitylessscriptablearray(_id_D6AFF3BEFA51BD6F.target, "targetname")) {
      if(!isDefined(_id_602105E14E6E984E.parts[struct.script_noteworthy]))
        _id_602105E14E6E984E.parts[struct.script_noteworthy] = [];

      if(scripts\engine\utility::string_starts_with(struct.script_noteworthy, "pd_puzzle_box_")) {
        _id_ACB1C43711ABC792 = _id_53BF9650A8BF8308(struct.script_noteworthy);

        if(!_id_ACB1C43711ABC792) {
          break;
        }

        _id_602105E14E6E984E._id_446135EB7FDAD263[_id_602105E14E6E984E._id_446135EB7FDAD263.size] = struct.script_noteworthy;
      }

      _id_602105E14E6E984E.parts[struct.script_noteworthy][_id_602105E14E6E984E.parts[struct.script_noteworthy].size] = struct;
    }

    if(!_id_ACB1C43711ABC792) {
      continue;
    }
    _id_3C1C75575DE72451 = scripts\engine\utility::getStruct(_id_D6AFF3BEFA51BD6F.target, "targetname");
    _id_1860EB172945DD74 = 1;

    if(isDefined(_id_3C1C75575DE72451)) {
      if(_id_D6AFF3BEFA51BD6F.script_label == "xp_door_flooded_to_boss")
        _id_8F01082520CC1A7E = spawn("script_model", _id_3C1C75575DE72451.origin + (-30, 0, 0));
      else if(_id_D6AFF3BEFA51BD6F.script_label == "xp_door_radiation_to_boss" || _id_D6AFF3BEFA51BD6F.script_label == "xp_door_dark_to_boss" || _id_D6AFF3BEFA51BD6F.script_label == "xp_door_boss_saferoom")
        _id_8F01082520CC1A7E = spawn("script_model", _id_3C1C75575DE72451.origin + (0, 30, 0));
      else
        _id_8F01082520CC1A7E = spawn("script_model", _id_3C1C75575DE72451.origin);

      _id_8F01082520CC1A7E makeusable();
      _id_8F01082520CC1A7E sethintdisplayrange(128);
      _id_8F01082520CC1A7E sethintdisplayfov(120);
      _id_8F01082520CC1A7E setuserange(60);
      _id_8F01082520CC1A7E setusefov(128);
      _id_8F01082520CC1A7E sethintonobstruction("show");
      _id_3C1C75575DE72451.hint = _id_8F01082520CC1A7E;
      _id_CC61161D5F4097A9 = getentitylessscriptablearray(_id_3C1C75575DE72451.target, "targetname");

      if(_id_CC61161D5F4097A9.size > 0)
        _id_602105E14E6E984E._id_CC61161D5F4097A9 = _id_CC61161D5F4097A9[0];

      _id_3C1C75575DE72451 thread _id_F7A798600A95E403(_id_602105E14E6E984E);
      _id_602105E14E6E984E._id_3C1C75575DE72451 = _id_3C1C75575DE72451;
    } else
      _id_1860EB172945DD74 = 0;

    _id_1E17D47157865CB2 = _id_602105E14E6E984E.parts["buddy_door_button"];

    if(isDefined(_id_1E17D47157865CB2)) {
      foreach(button in _id_1E17D47157865CB2) {
        doors = getEntArray(button.target, "targetname");

        if(!isDefined(doors) || isDefined(doors) && doors.size == 0)
          doors = getentitylessscriptablearray(button.target, "targetname");

        door = doors[0];

        if(isDefined(door)) {
          _id_602105E14E6E984E _id_BE24F93FD204C945(button, door, _id_1860EB172945DD74);
          _id_3F57BCE790B3F25E = undefined;
          _id_4659F6272926E493 = getentarrayinradius(undefined, undefined, door.origin, 256);

          foreach(ent in _id_4659F6272926E493) {
            if(ent.classname == "script_brushmodel" && isDefined(ent.target)) {
              _id_3F57BCE790B3F25E = ent;
              break;
            }
          }

          if(isDefined(_id_3F57BCE790B3F25E)) {
            door._id_3F57BCE790B3F25E = _id_3F57BCE790B3F25E;
            doorclip = getEnt(_id_3F57BCE790B3F25E.target, "targetname");
            doorclip linkTo(_id_3F57BCE790B3F25E);
            door._id_3F57BCE790B3F25E.doorclip = doorclip;
            door._id_3F57BCE790B3F25E disconnectPaths();
          } else {}

          _id_BF1F6E2B40469D28 = [];
          _id_96CA9C72AAAE980E = getentitylessscriptablearray(undefined, undefined, door.origin, 256);

          foreach(scriptable in _id_96CA9C72AAAE980E) {
            if(issubstr(scriptable.classname, "biobunker_bunkerdoor_light"))
              _id_BF1F6E2B40469D28[_id_BF1F6E2B40469D28.size] = scriptable;
          }

          if(isDefined(_id_BF1F6E2B40469D28)) {
            door._id_BF1F6E2B40469D28 = _id_BF1F6E2B40469D28;

            if(_id_602105E14E6E984E _id_AB0B57F7EFFF87CE() == 1)
              door thread _id_CA111691FDB1AD5D("activated");
          }

          continue;
        }
      }
    } else {}

    _id_62FC89C4CE899C55 = _id_602105E14E6E984E.parts["buddy_door_interior_button"];

    if(isDefined(_id_62FC89C4CE899C55)) {
      foreach(_id_54D2363346D8AF24 in _id_62FC89C4CE899C55) {
        doors = getEntArray(_id_54D2363346D8AF24.target, "targetname");

        if(!isDefined(doors) || isDefined(doors) && doors.size == 0)
          doors = getentitylessscriptablearray(_id_54D2363346D8AF24.target, "targetname");

        door = doors[0];

        if(isDefined(door))
          _id_602105E14E6E984E _id_09E1F4EC29297B57(_id_54D2363346D8AF24, door);
      }
    }

    if(isDefined(_id_3C1C75575DE72451))
      _id_602105E14E6E984E thread _id_3752998F8DA01643();

    level._id_8906F56063970306[level._id_8906F56063970306.size] = _id_602105E14E6E984E;
  }

  level thread _id_19F6FD4CB08C358E();
}

_id_53BF9650A8BF8308(partname) {
  return isDefined(level._id_AEB78277D6F21982[partname]);
}

_id_6FBCA622FD861241(player, partname) {
  lootid = level._id_AEB78277D6F21982[partname];

  if(!isDefined(lootid)) {
    return;
  }
  foreach(part in self.parts[partname]) {
    if(istrue(part.occupied)) {
      continue;
    }
    if(player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(lootid)) {
      if(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(lootid, 1)) {
        part setscriptablepartstate("pd_puzzle_part", "inserted", 0);
        part.occupied = 1;
        continue;
      } else
        logstring("Failed to use " + lootid + " although it is in player's backpack");
    }
  }
}

_id_3B0AC2F7FC8B633A(player) {
  _id_5DA9CD5A39E4F616 = 0;
  _id_889080B4E2243689 = 0;
  _id_BDF70A677EE11822 = 1;
  _id_73C1B8377D926417 = 0;
  count = min(self._id_446135EB7FDAD263.size, 2);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++) {
    partname = self._id_446135EB7FDAD263[_id_AC0E594AC96AA3A8];
    parts = self.parts[partname];
    occupied = 1;

    foreach(part in parts) {
      if(!istrue(part.occupied)) {
        occupied = 0;
        break;
      }
    }

    lootid = level._id_AEB78277D6F21982[partname];
    _id_587F61AD4C5334A0 = player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(lootid);

    if(_id_AC0E594AC96AA3A8 == 0) {
      _id_5DA9CD5A39E4F616 = occupied;
      _id_889080B4E2243689 = _id_587F61AD4C5334A0;
      continue;
    }

    if(_id_AC0E594AC96AA3A8 == 1) {
      _id_BDF70A677EE11822 = occupied;
      _id_73C1B8377D926417 = _id_587F61AD4C5334A0;
    }
  }

  if(scripts\engine\utility::string_starts_with(self._id_446135EB7FDAD263[0], "pd_puzzle_box_brloot_valuable")) {
    if(!_id_5DA9CD5A39E4F616 && !_id_BDF70A677EE11822) {
      if(_id_889080B4E2243689 && _id_73C1B8377D926417) {
        self._id_3C1C75575DE72451.hint setHintString(&"MP_BIOBUNKER/PUZZLE_DOOR_POWER_BOX_INSERT");
        self._id_3C1C75575DE72451.hint setCursorHint("HINT_BUTTON");
      } else if(_id_889080B4E2243689) {
        self._id_3C1C75575DE72451.hint setHintString(&"MP_BIOBUNKER/PUZZLE_DOOR_POWER_BOX_INSERT_CABLE");
        self._id_3C1C75575DE72451.hint setCursorHint("HINT_BUTTON");
      } else if(_id_73C1B8377D926417) {
        self._id_3C1C75575DE72451.hint setHintString(&"MP_BIOBUNKER/PUZZLE_DOOR_POWER_BOX_INSERT_BATTERY");
        self._id_3C1C75575DE72451.hint setCursorHint("HINT_BUTTON");
      } else {
        self._id_3C1C75575DE72451.hint setHintString(&"MP_BIOBUNKER/NEED_TWO_ITEMS");
        self._id_3C1C75575DE72451.hint setCursorHint("HINT_NOBUTTON");
      }
    } else if(!_id_5DA9CD5A39E4F616) {
      if(_id_889080B4E2243689) {
        self._id_3C1C75575DE72451.hint setHintString(&"MP_BIOBUNKER/PUZZLE_DOOR_POWER_BOX_INSERT_CABLE");
        self._id_3C1C75575DE72451.hint setCursorHint("HINT_BUTTON");
      } else {
        self._id_3C1C75575DE72451.hint setHintString(&"MP_BIOBUNKER/NEED_ONE_ITEM");
        self._id_3C1C75575DE72451.hint setCursorHint("HINT_NOBUTTON");
      }
    } else if(!_id_BDF70A677EE11822) {
      if(_id_73C1B8377D926417) {
        self._id_3C1C75575DE72451.hint setHintString(&"MP_BIOBUNKER/PUZZLE_DOOR_POWER_BOX_INSERT_BATTERY");
        self._id_3C1C75575DE72451.hint setCursorHint("HINT_BUTTON");
      } else {
        self._id_3C1C75575DE72451.hint setHintString(&"MP_BIOBUNKER/NEED_ONE_ITEM");
        self._id_3C1C75575DE72451.hint setCursorHint("HINT_NOBUTTON");
      }
    } else
      return;
  } else if(!_id_5DA9CD5A39E4F616 && !_id_BDF70A677EE11822) {
    if(_id_889080B4E2243689 && _id_73C1B8377D926417) {
      self._id_3C1C75575DE72451.hint setHintString(&"MP_BIOBUNKER/PUZZLE_DOOR_INSERT_KEYS");
      self._id_3C1C75575DE72451.hint setCursorHint("HINT_BUTTON");
    } else if(_id_889080B4E2243689) {
      self._id_3C1C75575DE72451.hint setHintString(&"MP_BIOBUNKER/PUZZLE_DOOR_INSERT_KEYS");
      self._id_3C1C75575DE72451.hint setCursorHint("HINT_BUTTON");
    } else if(_id_73C1B8377D926417) {
      self._id_3C1C75575DE72451.hint setHintString(&"MP_BIOBUNKER/PUZZLE_DOOR_INSERT_KEYS");
      self._id_3C1C75575DE72451.hint setCursorHint("HINT_BUTTON");
    } else {
      self._id_3C1C75575DE72451.hint setHintString(&"MP_BIOBUNKER/NEED_TWO_KEYS");
      self._id_3C1C75575DE72451.hint setCursorHint("HINT_NOBUTTON");
    }
  } else if(!_id_5DA9CD5A39E4F616 || !_id_BDF70A677EE11822) {
    if(_id_889080B4E2243689) {
      self._id_3C1C75575DE72451.hint setHintString(&"MP_BIOBUNKER/PUZZLE_DOOR_INSERT_KEYS");
      self._id_3C1C75575DE72451.hint setCursorHint("HINT_BUTTON");
    } else {
      self._id_3C1C75575DE72451.hint setHintString(&"MP_BIOBUNKER/NEED_ONE_KEY");
      self._id_3C1C75575DE72451.hint setCursorHint("HINT_NOBUTTON");
    }
  } else
    return;
}

_id_F7A798600A95E403(_id_602105E14E6E984E) {
  level endon("game_ended");
  self.hint endon("death");

  for(;;) {
    self.hint waittill("trigger", player);

    foreach(partname in _id_602105E14E6E984E._id_446135EB7FDAD263)
    _id_602105E14E6E984E _id_6FBCA622FD861241(player, partname);

    if(_id_602105E14E6E984E _id_AB0B57F7EFFF87CE()) {
      if(isDefined(_id_602105E14E6E984E._id_CC61161D5F4097A9))
        _id_602105E14E6E984E._id_CC61161D5F4097A9 setscriptablepartstate("effect", "effect");

      foreach(partname in _id_602105E14E6E984E._id_446135EB7FDAD263) {
        foreach(part in _id_602105E14E6E984E.parts[partname]) {
          if(part getscriptableparthasstate("pd_puzzle_part", "inserted_all"))
            part setscriptablepartstate("pd_puzzle_part", "inserted_all", 1);
        }
      }

      foreach(door in _id_602105E14E6E984E.doors) {
        if(isDefined(door._id_9A4AA3610DCBF2F5.hint))
          door._id_9A4AA3610DCBF2F5.hint setHintString(&"MP_BIOBUNKER/PUZZLE_DOOR_CAN_OPEN");

        if(isDefined(door._id_BF1F6E2B40469D28))
          door thread _id_CA111691FDB1AD5D("activated");

        if(isDefined(door.script_noteworthy) && door.script_noteworthy == "auto_door")
          door thread openbunkerdoor(_id_602105E14E6E984E, player);
      }

      break;
    }
  }

  self.hint delete();
}

_id_461CF47AA3FB0F2B(_id_602105E14E6E984E) {
  level endon("game_ended");
  self.hint endon("death");

  for(;;) {
    self.hint waittill("trigger", player);
    self setscriptablepartstate("interact", "pushed");

    if(_id_602105E14E6E984E _id_AB0B57F7EFFF87CE()) {
      self.door thread openbunkerdoor(_id_602105E14E6E984E, player);
      break;
    } else
      self.hint _id_701449195235BE31::_id_77EB9584ECCFBBC0();
  }
}

_id_73AA5B204D792544(_id_602105E14E6E984E) {
  level endon("game_ended");
  self.hint endon("death");

  for(;;) {
    self.hint waittill("trigger", player);
    self setscriptablepartstate("interact", "pushed");
    self.door thread openbunkerdoor(_id_602105E14E6E984E, player);
    break;
  }
}

_id_AB0B57F7EFFF87CE() {
  foreach(partname in self._id_446135EB7FDAD263) {
    parts = self.parts[partname];

    foreach(part in parts) {
      if(!istrue(part.occupied))
        return 0;
    }
  }

  return 1;
}

_id_BE24F93FD204C945(button, door, _id_1860EB172945DD74) {
  button.door = door;
  door._id_9A4AA3610DCBF2F5 = button;
  _id_B9A270D85703AC18 = spawn("script_model", button.origin);
  _id_B9A270D85703AC18 makeusable();

  if(_id_1860EB172945DD74 == 1)
    _id_B9A270D85703AC18 setHintString(&"MP_BIOBUNKER/PUZZLE_DOOR_NO_POWER");
  else
    _id_B9A270D85703AC18 setHintString(&"MP_BIOBUNKER/PUZZLE_DOOR_CAN_OPEN");

  _id_B9A270D85703AC18 setCursorHint("HINT_BUTTON");
  _id_B9A270D85703AC18 sethintdisplayrange(64);
  _id_B9A270D85703AC18 sethintdisplayfov(120);
  _id_B9A270D85703AC18 setuserange(64);
  _id_B9A270D85703AC18 setusefov(120);
  _id_B9A270D85703AC18 sethintonobstruction("show");
  button.hint = _id_B9A270D85703AC18;
  button thread _id_461CF47AA3FB0F2B(self);
  door.open = 0;
  self.doors[self.doors.size] = door;
}

_id_09E1F4EC29297B57(_id_54D2363346D8AF24, door) {
  _id_54D2363346D8AF24.door = door;
  door._id_54D2363346D8AF24 = _id_54D2363346D8AF24;
  _id_B9A270D85703AC18 = spawn("script_model", _id_54D2363346D8AF24.origin);
  _id_B9A270D85703AC18 makeusable();
  _id_B9A270D85703AC18 setHintString(&"MP_BIOBUNKER/PUZZLE_DOOR_CAN_OPEN");
  _id_B9A270D85703AC18 setCursorHint("HINT_BUTTON");
  _id_B9A270D85703AC18 sethintdisplayrange(64);
  _id_B9A270D85703AC18 sethintdisplayfov(120);
  _id_B9A270D85703AC18 setuserange(64);
  _id_B9A270D85703AC18 setusefov(120);
  _id_B9A270D85703AC18 sethintonobstruction("show");
  _id_54D2363346D8AF24.hint = _id_B9A270D85703AC18;
  _id_54D2363346D8AF24 thread _id_73AA5B204D792544(self);
}

_id_3752998F8DA01643() {
  level endon("game_ended");
  trigger = spawn("trigger_radius", self._id_3C1C75575DE72451.origin, 0, 72, 72);

  for(;;) {
    trigger waittill("trigger", ent);

    if(!isPlayer(ent)) {
      continue;
    }
    if(_id_AB0B57F7EFFF87CE() || _id_79EDDD8A5A3CC423(self)) {
      break;
    }

    _id_3B0AC2F7FC8B633A(ent);
  }

  trigger delete();
}

openbunkerdoor(_id_602105E14E6E984E, player) {
  thread _id_AFB319585A5CD48C();
  self.open = 1;
  _id_86FAACAACF9E1A90 = _id_79EDDD8A5A3CC423(_id_602105E14E6E984E);

  if(isDefined(_id_602105E14E6E984E._id_3C1C75575DE72451)) {
    if(isDefined(_id_602105E14E6E984E._id_3C1C75575DE72451.hint) && _id_86FAACAACF9E1A90 == 1)
      _id_602105E14E6E984E._id_3C1C75575DE72451.hint delete();
  }

  self._id_9A4AA3610DCBF2F5 setscriptablepartstate("model", "on");
  self._id_9A4AA3610DCBF2F5.hint delete();

  if(isDefined(self._id_54D2363346D8AF24)) {
    self._id_54D2363346D8AF24 setscriptablepartstate("model", "on");
    self._id_54D2363346D8AF24.hint delete();
  }

  if(isDefined(_id_602105E14E6E984E.script_label)) {
    if(isDefined(level._id_859A0B2D45BCDF20)) {
      if(isDefined(player) && !istrue(_id_602105E14E6E984E._id_C2B67343FA923707)) {
        player[[level._id_859A0B2D45BCDF20]](_id_602105E14E6E984E.script_label);
        _id_602105E14E6E984E._id_C2B67343FA923707 = 1;
      }
    }

    if(isDefined(level._id_6AB07FA19E534F51))
      [[level._id_6AB07FA19E534F51]](_id_602105E14E6E984E.script_label);
  }
}

_id_AFB319585A5CD48C() {
  level endon("game_ended");
  _id_5F8753D360CD9D25 = [-102, 5.5, 0.1, 0.5];
  _id_DC425B3D6696F8C8 = [-102, 42, 11.5, 11.5];
  wait 0.5;
  self setscriptablepartstate("bunkerdoor", "opening", 0);

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "auto_door")
    self._id_3F57BCE790B3F25E thread _id_701449195235BE31::_id_2AB59E04B43701ED(_id_5F8753D360CD9D25[0], _id_5F8753D360CD9D25[1], _id_5F8753D360CD9D25[2], _id_5F8753D360CD9D25[3]);
  else {
    self._id_3F57BCE790B3F25E thread _id_701449195235BE31::_id_2AB59E04B43701ED(_id_DC425B3D6696F8C8[0], _id_DC425B3D6696F8C8[1], _id_DC425B3D6696F8C8[2], _id_DC425B3D6696F8C8[3]);
    thread _id_84FAA47ADB75DDB5();
  }

  if(isDefined(self._id_BF1F6E2B40469D28))
    thread _id_CA111691FDB1AD5D("opened");
}

_id_CA111691FDB1AD5D(_id_DF23BAD857DF2BBD) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("scriptables_ready");

  switch (_id_DF23BAD857DF2BBD) {
    case "activated":
      foreach(_id_CB7208BC5353564B in self._id_BF1F6E2B40469D28)
      _id_CB7208BC5353564B setscriptablepartstate("bunkerdoor_light", "activated", 0);

      break;
    case "opened":
      foreach(_id_CB7208BC5353564B in self._id_BF1F6E2B40469D28)
      _id_CB7208BC5353564B setscriptablepartstate("bunkerdoor_light", "opening", 0);

      wait 13.9;

      foreach(_id_CB7208BC5353564B in self._id_BF1F6E2B40469D28)
      _id_CB7208BC5353564B setscriptablepartstate("bunkerdoor_light", "open", 0);

      break;
  }
}

_id_84FAA47ADB75DDB5() {
  level endon("game_ended");
  _id_0D0718F6FE41D119 = 16;

  if(soundexists("dmz_bunkerdoor_klaxon_no_loop_sfx")) {
    _id_1499E7C2D69E0074 = lookupsoundlength("dmz_bunkerdoor_klaxon_no_loop_sfx") / 1000;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0D0718F6FE41D119; _id_AC0E594AC96AA3A8++) {
      playsoundatpos(self._id_9A4AA3610DCBF2F5.origin + (0, 0, 80), "dmz_bunkerdoor_klaxon_no_loop_sfx");
      wait(_id_1499E7C2D69E0074);
    }
  }
}

_id_79EDDD8A5A3CC423(_id_602105E14E6E984E) {
  foreach(door in _id_602105E14E6E984E.doors) {
    if(door.open == 0)
      return 0;
  }

  return 1;
}

_id_5923928ABF319809(itemlist) {
  level endon("game_ended");

  foreach(item in itemlist) {
    _id_4C9501D3F7923844 = "pd_puzzle_box_" + item;
    level._id_AEB78277D6F21982[_id_4C9501D3F7923844] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(item);
  }
}

_id_19F6FD4CB08C358E() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");
  _id_C599C6F5DE13EB1E = getdvarint("dvar_E2DCC379F3DF19F2", 0);
  _id_559B9EB0467596B9 = getdvarint("dvar_3229508091417107", 600);

  if(_id_C599C6F5DE13EB1E == 1) {
    if(_id_559B9EB0467596B9 > 0) {
      foreach(_id_602105E14E6E984E in level._id_8906F56063970306) {
        foreach(door in _id_602105E14E6E984E.doors) {
          if(isDefined(door.script_noteworthy) && door.script_noteworthy == "door_to_dark") {
            _id_A9C50EC3E1E0BBBD = scripts\engine\utility::getStruct(_id_602105E14E6E984E.script_label + "_detector", "script_noteworthy");
            _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_A9C50EC3E1E0BBBD.origin);
            door thread _id_01C5FAA6EAA37109(_id_602105E14E6E984E, _id_171F90B9C4C76D44, _id_559B9EB0467596B9);
          }
        }
      }
    }
  }
}

_id_01C5FAA6EAA37109(_id_602105E14E6E984E, _id_171F90B9C4C76D44, _id_559B9EB0467596B9) {
  level endon("game_ended");
  _id_2A6F690DF99342FB = 0;

  while(!isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"]))
    waitframe();

  while(self.open == 0) {
    if(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"].size > 0) {
      _id_2A6F690DF99342FB = _id_2A6F690DF99342FB + 1;

      if(_id_2A6F690DF99342FB >= _id_559B9EB0467596B9) {
        thread openbunkerdoor(_id_602105E14E6E984E);
        break;
      }
    } else if(level.nojip == 1) {
      break;
    } else if(isDefined(level.allowlatecomers) && level.allowlatecomers == 0) {
      break;
    } else
      _id_2A6F690DF99342FB = 0;

    wait 1;
  }
}