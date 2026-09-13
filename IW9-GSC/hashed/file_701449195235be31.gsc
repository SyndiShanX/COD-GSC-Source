/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_701449195235be31.gsc
***********************************************/

_id_256740E934855015() {
  level endon("game_ended");
  level._id_891590581BD5541C = [];
  level._id_FB05F29BCEF74534 = [];
  level._id_3276266E4E961F20 = [];

  for(;;) {
    waittillframeend;

    if(level._id_891590581BD5541C.size > 0) {
      level._id_891590581BD5541C = scripts\engine\utility::array_sort_with_func(level._id_891590581BD5541C, ::_id_979433D274C73D05);

      foreach(group in level._id_891590581BD5541C) {
        if(isDefined(group._id_6EE0003EDC819B06)) {
          foreach(player in group._id_6EE0003EDC819B06) {
            if(!isDefined(player)) {
              continue;
            }
            playerid = player getentitynumber();

            if(!isDefined(level._id_FB05F29BCEF74534[playerid]))
              level._id_FB05F29BCEF74534[playerid] = spawnStruct();

            level._id_FB05F29BCEF74534[playerid]._id_7C00F004F425CDC3 = 0;
          }
        }
      }

      foreach(group in level._id_891590581BD5541C) {
        if(isDefined(group._id_C92DA37DD03A2FF3)) {
          foreach(player in group._id_C92DA37DD03A2FF3) {
            if(!isDefined(player)) {
              continue;
            }
            playerid = player getentitynumber();

            if(!isDefined(level._id_FB05F29BCEF74534[playerid]))
              level._id_FB05F29BCEF74534[playerid] = spawnStruct();

            level._id_FB05F29BCEF74534[playerid]._id_7C00F004F425CDC3 = 1;
            level._id_FB05F29BCEF74534[playerid]._id_55F38A9ECA24F5B8 = group._id_55F38A9ECA24F5B8;
            level._id_FB05F29BCEF74534[playerid]._id_6958D396E4AD3B95 = group._id_6958D396E4AD3B95;
          }
        }
      }

      foreach(player in level.players) {
        if(!isDefined(player)) {
          continue;
        }
        playerid = player getentitynumber();

        if(isDefined(level._id_FB05F29BCEF74534[playerid])) {
          _id_7C00F004F425CDC3 = level._id_FB05F29BCEF74534[playerid]._id_7C00F004F425CDC3;
          _id_55F38A9ECA24F5B8 = level._id_FB05F29BCEF74534[playerid]._id_55F38A9ECA24F5B8;
          _id_6958D396E4AD3B95 = level._id_FB05F29BCEF74534[playerid]._id_6958D396E4AD3B95;

          if(!isDefined(level._id_3276266E4E961F20[playerid])) {
            level._id_3276266E4E961F20[playerid] = spawnStruct();
            player setclientomnvar("ui_dmz_biolab_show_countdown", _id_7C00F004F425CDC3);

            if(_id_7C00F004F425CDC3 == 1) {
              player setclientomnvar("ui_dmz_biolab_countdown_desc_index", _id_55F38A9ECA24F5B8);
              player setclientomnvar("ui_dmz_biolab_countdown", _id_6958D396E4AD3B95);
            }
          } else {
            _id_8F0B1CDEBB00ED3F = level._id_3276266E4E961F20[playerid]._id_7C00F004F425CDC3;
            _id_C2B67EFA40BB395C = level._id_3276266E4E961F20[playerid]._id_55F38A9ECA24F5B8;
            _id_9B94233FCD917739 = level._id_3276266E4E961F20[playerid]._id_6958D396E4AD3B95;

            if(!isDefined(_id_8F0B1CDEBB00ED3F) || _id_8F0B1CDEBB00ED3F != _id_7C00F004F425CDC3)
              player setclientomnvar("ui_dmz_biolab_show_countdown", _id_7C00F004F425CDC3);

            if(isDefined(_id_55F38A9ECA24F5B8) && (!isDefined(_id_C2B67EFA40BB395C) || _id_C2B67EFA40BB395C != _id_55F38A9ECA24F5B8))
              player setclientomnvar("ui_dmz_biolab_countdown_desc_index", _id_55F38A9ECA24F5B8);

            if(isDefined(_id_6958D396E4AD3B95) && (!isDefined(_id_9B94233FCD917739) || _id_9B94233FCD917739 != _id_6958D396E4AD3B95))
              player setclientomnvar("ui_dmz_biolab_countdown", _id_6958D396E4AD3B95);
          }

          level._id_3276266E4E961F20[playerid]._id_7C00F004F425CDC3 = _id_7C00F004F425CDC3;
          level._id_3276266E4E961F20[playerid]._id_55F38A9ECA24F5B8 = _id_55F38A9ECA24F5B8;
          level._id_3276266E4E961F20[playerid]._id_6958D396E4AD3B95 = _id_6958D396E4AD3B95;
        }
      }
    }

    waitframe();
  }
}

_id_FF5183505692184F() {
  level endon("game_ended");

  if(!isDefined(self._id_6958D396E4AD3B95) || self._id_6958D396E4AD3B95 <= 0) {
    return;
  }
  waitframe();

  if(istrue(_id_9484F2E484CAE262())) {
    if(isDefined(self._id_26237A5432EF38B6))
      thread _id_44518890795B4144(self._id_26237A5432EF38B6);

    while(self._id_6958D396E4AD3B95 > 0) {
      wait 1;
      self._id_6958D396E4AD3B95--;
    }

    self notify("bio_lab_count_down_finished");
    waitframe();
    level._id_891590581BD5541C = scripts\engine\utility::array_remove(level._id_891590581BD5541C, self);
  }
}

_id_979433D274C73D05(_id_E58FF7B19D80585B, _id_E58FF8B19D805A8E) {
  return _id_E58FF7B19D80585B.priority < _id_E58FF8B19D805A8E.priority;
}

_id_9484F2E484CAE262() {
  foreach(group in level._id_891590581BD5541C) {
    if(group.id == self.id) {
      logstring("Error: " + self.id + " is already in countdown groups");
      return 0;
    }
  }

  level._id_891590581BD5541C[level._id_891590581BD5541C.size] = self;
  return 1;
}

_id_44518890795B4144(origin) {
  level endon("game_ended");
  self endon("bio_lab_count_down_finished");
  _id_3FBEBB497A464E48 = 250000;

  if(isDefined(self._id_AE52C3C4A761FB73))
    _id_3FBEBB497A464E48 = self._id_AE52C3C4A761FB73 * self._id_AE52C3C4A761FB73;

  for(;;) {
    self._id_C92DA37DD03A2FF3 = [];
    self._id_6EE0003EDC819B06 = [];

    foreach(player in self._id_5ABB8DC2E7CD678E) {
      if(!isDefined(player)) {
        continue;
      }
      if(distancesquared(player.origin, origin) < _id_3FBEBB497A464E48) {
        self._id_C92DA37DD03A2FF3[self._id_C92DA37DD03A2FF3.size] = player;
        continue;
      }

      self._id_6EE0003EDC819B06[self._id_6EE0003EDC819B06.size] = player;
    }

    waitframe();
  }
}

_id_F39400365156886F(table) {
  if(!_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    return;
  }
  if(!isDefined(table)) {
    return;
  }
  if(!tableexists(table)) {
    return;
  }
  [_id_9C12DE5C46ABF0C9, _id_4261502DED85A362] = _id_BED7868283B80525(table);
  level endon("game_ended");

  while(!isDefined(level.struct_class_names) || !isDefined(level.br_pickups))
    waitframe();

  foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
    _id_2DF529E18DAD91C9 = getdvarint(_func_2EF675C13CA1C4AF("dvar_396CDE75A5559E8C", _id_171F90B9C4C76D44), 10);
    _id_5D71D807F3D89419 = scripts\engine\utility::getStructArray("MainNotePackage_" + _id_171F90B9C4C76D44, "script_noteworthy");

    foreach(_id_11F568BBCEDEBCF0 in _id_5D71D807F3D89419) {
      _id_D64C04C3E5570259 = [];
      _id_0279466E06EC7244 = [];
      _id_D4D776E430B79812 = [];
      nodes = scripts\engine\utility::getStructArray(_id_11F568BBCEDEBCF0.target, "targetname");

      foreach(node in nodes) {
        if(scripts\engine\utility::string_starts_with(node.script_noteworthy, "required_note_")) {
          _id_CB325DDB4A764623 = _func_2E84A570D6AF300A(node.script_noteworthy, "required_note_");

          if(isDefined(_id_D64C04C3E5570259[_id_CB325DDB4A764623])) {} else
            _id_D64C04C3E5570259[_id_CB325DDB4A764623] = node;

          continue;
        }

        if(scripts\engine\utility::string_starts_with(node.script_noteworthy, "required_group_")) {
          groupname = tolower(_func_2E84A570D6AF300A(node.script_noteworthy, "required_group_"));

          if(isDefined(_id_0279466E06EC7244[groupname])) {} else
            _id_0279466E06EC7244[groupname] = node;

          continue;
        }

        if(scripts\engine\utility::string_starts_with(node.script_noteworthy, "optional"))
          _id_D4D776E430B79812[_id_D4D776E430B79812.size] = node;
      }

      _id_5D02A89F45CC20D7 = _id_9C12DE5C46ABF0C9[_id_171F90B9C4C76D44];

      if(!isDefined(_id_5D02A89F45CC20D7)) {
        continue;
      }
      _id_AA24F5300447823C = 0;

      if(_id_AA24F5300447823C < _id_2DF529E18DAD91C9 && _id_5D02A89F45CC20D7.size > 0) {
        foreach(_id_CB325DDB4A764623, node in _id_D64C04C3E5570259) {
          if(_id_AA24F5300447823C >= _id_2DF529E18DAD91C9) {
            break;
          }

          if(isDefined(_id_5D02A89F45CC20D7[_id_CB325DDB4A764623])) {
            dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
            _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, node.origin, node.angles, undefined, 0, 0);
            item = _id_7E52B56769FA7774::spawnpickup(_id_CB325DDB4A764623, _id_CB4FAD49263E20C4);

            if(isDefined(item)) {
              _id_5D02A89F45CC20D7[_id_CB325DDB4A764623] = undefined;
              _id_AA24F5300447823C++;
            }

            continue;
          }
        }
      }

      if(_id_AA24F5300447823C < _id_2DF529E18DAD91C9 && scripts\engine\utility::array_removeundefined(_id_5D02A89F45CC20D7).size > 0) {
        foreach(groupname, node in _id_0279466E06EC7244) {
          if(_id_AA24F5300447823C >= _id_2DF529E18DAD91C9) {
            break;
          }

          _id_4C21E8095C4ACBEC = _id_4261502DED85A362[groupname].items;
          _id_9B1367DEB1B4C3DC = _id_4261502DED85A362[groupname]._id_9B1367DEB1B4C3DC;
          random = randomint(_id_9B1367DEB1B4C3DC);

          foreach(_id_D6C288311FFE5017 in _id_4C21E8095C4ACBEC) {
            if(random > _id_D6C288311FFE5017._id_302E82DA1A1989AD) {
              random = random - _id_D6C288311FFE5017._id_302E82DA1A1989AD;
              continue;
            }

            if(isDefined(_id_5D02A89F45CC20D7[_id_D6C288311FFE5017.ref])) {
              dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
              _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, node.origin, node.angles, undefined, 0, 0);
              item = _id_7E52B56769FA7774::spawnpickup(_id_D6C288311FFE5017.ref, _id_CB4FAD49263E20C4);

              if(isDefined(item)) {
                _id_5D02A89F45CC20D7[_id_D6C288311FFE5017.ref] = undefined;
                _id_AA24F5300447823C++;
              }
            } else {}

            break;
          }
        }
      }

      if(_id_AA24F5300447823C < _id_2DF529E18DAD91C9) {
        _id_5D02A89F45CC20D7 = scripts\engine\utility::array_removeundefined(_id_5D02A89F45CC20D7);
        _id_5D02A89F45CC20D7 = scripts\engine\utility::array_randomize(_id_5D02A89F45CC20D7);

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < min(_id_5D02A89F45CC20D7.size, _id_D4D776E430B79812.size); _id_AC0E594AC96AA3A8++) {
          if(_id_AA24F5300447823C >= _id_2DF529E18DAD91C9) {
            break;
          }

          _id_CB325DDB4A764623 = _id_5D02A89F45CC20D7[_id_AC0E594AC96AA3A8];
          node = _id_D4D776E430B79812[_id_AC0E594AC96AA3A8];
          dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
          _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, node.origin, node.angles, undefined, 0, 0);
          item = _id_7E52B56769FA7774::spawnpickup(_id_CB325DDB4A764623, _id_CB4FAD49263E20C4);

          if(isDefined(item))
            _id_AA24F5300447823C++;
        }
      }
    }
  }
}

_id_BED7868283B80525(table) {
  _id_9C12DE5C46ABF0C9 = [];
  _id_4261502DED85A362 = [];
  _id_B78A33A2141CEBAD = 0;
  _id_812E8D04770AAABB = _id_B78A33A2141CEBAD + 1;
  _id_B0866816AA781BBC = _id_812E8D04770AAABB + 1;
  _id_D14B902C1E8C6C15 = _id_B78A33A2141CEBAD + 1;
  _id_977F24E61599CBBA = tablelookupgetnumrows(table);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_977F24E61599CBBA; _id_AC0E594AC96AA3A8++) {
    ref = tolower(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_B78A33A2141CEBAD));

    if(scripts\engine\utility::string_starts_with(ref, "pool_")) {
      _id_DB151AA4778D7AA1 = tolower(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_D14B902C1E8C6C15));
      _id_560AB944C21CA1F0 = strtok(_id_DB151AA4778D7AA1, ",");
      _id_DE0600B92AD0F1D4 = _func_2E84A570D6AF300A(ref, "pool_");
      _id_9C12DE5C46ABF0C9[_id_DE0600B92AD0F1D4] = _id_560AB944C21CA1F0;

      foreach(ref in _id_560AB944C21CA1F0)
      _id_9C12DE5C46ABF0C9[_id_DE0600B92AD0F1D4][ref] = ref;

      continue;
    }

    if(scripts\engine\utility::string_starts_with(ref, "group_")) {
      _id_1562E71C57265A93 = spawnStruct();
      _id_1562E71C57265A93.ref = tolower(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_812E8D04770AAABB));
      _id_1562E71C57265A93._id_302E82DA1A1989AD = int(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_B0866816AA781BBC));
      groupname = ref;

      if(!isDefined(_id_4261502DED85A362[groupname])) {
        _id_4261502DED85A362[groupname] = spawnStruct();
        _id_4261502DED85A362[groupname]._id_9B1367DEB1B4C3DC = 0;
        _id_4261502DED85A362[groupname].items = [];
      }

      _id_4261502DED85A362[groupname]._id_9B1367DEB1B4C3DC = _id_4261502DED85A362[groupname]._id_9B1367DEB1B4C3DC + _id_1562E71C57265A93._id_302E82DA1A1989AD;
      _id_4261502DED85A362[groupname].items[_id_4261502DED85A362[groupname].items.size] = _id_1562E71C57265A93;
    }
  }

  return [_id_9C12DE5C46ABF0C9, _id_4261502DED85A362];
}

_id_4C866681BC6481BE(table) {
  if(!isDefined(table)) {
    return;
  }
  if(!tableexists(table)) {
    return;
  }
  level endon("game_ended");

  while(!isDefined(level.struct_class_names) || !isDefined(level.br_pickups))
    waitframe();

  _id_B6FC1068E5169172 = 0;
  _id_D2CD988BE2FD313F = _id_B6FC1068E5169172 + 1;
  _id_5411A2A196AEC6BF = _id_D2CD988BE2FD313F + 1;
  _id_4AA21E7F933D2511 = _id_5411A2A196AEC6BF + 1;
  _id_977F24E61599CBBA = tablelookupgetnumrows(table);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_977F24E61599CBBA; _id_AC0E594AC96AA3A8++) {
    _id_17CA952DEDAD0B25 = tolower(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_B6FC1068E5169172));
    _id_CB325DDB4A764623 = tolower(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_D2CD988BE2FD313F));
    count = int(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_5411A2A196AEC6BF));
    _id_B9722BE77DD512C7 = scripts\engine\utility::ter_op(int(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_4AA21E7F933D2511)) == 1, 1, 0);
    _id_6CAE4397834E60C8(_id_17CA952DEDAD0B25, _id_CB325DDB4A764623, count, _id_B9722BE77DD512C7);
  }
}

_id_6CAE4397834E60C8(_id_17CA952DEDAD0B25, _id_CB325DDB4A764623, _id_D7801635225598A2, _id_B9722BE77DD512C7) {
  _id_47ACE10A0A9EC64F = scripts\engine\utility::getStructArray(_id_17CA952DEDAD0B25, "script_noteworthy");
  spawncount = scripts\engine\utility::_id_53C4C53197386572(_id_D7801635225598A2, 1);

  foreach(_id_9C46B77054982706 in _id_47ACE10A0A9EC64F) {
    if(!isDefined(_id_9C46B77054982706.target) || _id_9C46B77054982706.target == "") {
      continue;
    }
    _id_2EACD68308D1305A = scripts\engine\utility::getStructArray(_id_9C46B77054982706.target, "targetname");

    if(_id_2EACD68308D1305A.size > 0) {
      _id_2EACD68308D1305A = scripts\engine\utility::array_randomize(_id_2EACD68308D1305A);
      spawncount = min(spawncount, _id_2EACD68308D1305A.size);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < spawncount; _id_AC0E594AC96AA3A8++) {
        _id_46B0EB76F92D69C2 = _id_600B944A95C3A7BF::_id_0E025BB823276187(_id_CB325DDB4A764623);
        _id_AE500216F7D4B84D = _id_2EACD68308D1305A[_id_AC0E594AC96AA3A8];
        dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
        _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_AE500216F7D4B84D.origin, _id_AE500216F7D4B84D.angles, undefined, 0, 0);
        item = _id_7E52B56769FA7774::spawnpickup(_id_CB325DDB4A764623, _id_CB4FAD49263E20C4, _id_46B0EB76F92D69C2);

        if(isDefined(item) && istrue(_id_B9722BE77DD512C7)) {
          item._id_BBC200BC77C5DB2B = 1;
          item._id_8C6CE30A6A5126B1 = 1;
        }

        logstring("THE RANDOM ITEM [" + _id_CB325DDB4A764623 + "] IS LOCATED AT " + _id_AE500216F7D4B84D.origin);
      }

      continue;
    }
  }
}

_id_E3752C40826A26D4() {
  setDvar("scr_br_allowkillstreaks", 0);
  level.modeiskillstreakallowed = ::_id_137B0321DC8B84C5;
}

_id_137B0321DC8B84C5(_id_16EFCF27E6EFCBE8, _id_015314DA30B44470) {
  return 0;
}

_id_17FD42AE13D8ABC9() {
  level.modeiskillstreakallowed = ::_id_09B0B661BB9E17F4;
}

_id_09B0B661BB9E17F4(_id_16EFCF27E6EFCBE8, _id_015314DA30B44470) {
  if(!isDefined(_id_16EFCF27E6EFCBE8) || !isDefined(_id_16EFCF27E6EFCBE8.streakname))
    return 0;

  switch (_id_16EFCF27E6EFCBE8.streakname) {
    case "cluster_spike":
    case "assault_drone":
    case "sentry_gun":
      return 1;
    default:
      return 0;
  }
}

_id_2AB59E04B43701ED(_id_0944B1CC80DD0EED, _id_CC5BC42930ABBC4F, _id_1D5DB5EEFD5BE7C6, _id_B6689F84DACEB617) {
  level endon("game_ended");

  if(isDefined(self.doorclip)) {
    self.doorclip connectpaths();
    self rotateYaw(_id_0944B1CC80DD0EED, _id_CC5BC42930ABBC4F, _id_1D5DB5EEFD5BE7C6, _id_B6689F84DACEB617);
    wait(_id_CC5BC42930ABBC4F);
    self.doorclip disconnectPaths();
  } else {}
}

_id_7B3877AFD4D12BC9(_id_580837BA9DE8F3D4) {
  agent = self;

  if(isDefined(agent.weapon)) {
    _id_F0FFAFCA5D927A12 = agent.weapon;
    _id_A07C91BFED19B518 = ["rocketlauncher"];

    if(scripts\engine\utility::array_contains(_id_A07C91BFED19B518, _id_F0FFAFCA5D927A12.classname)) {
      return;
    }
    _id_631EB7A15A695766 = ["iw9_lm_foxtrot_mp", "iw9_ar_mike16_mp", "iw9_ar_mike4_mp"];
    _id_EFFB4AE1788A8B10 = "flashlight_box02";

    if(scripts\engine\utility::array_contains(_id_631EB7A15A695766, _id_F0FFAFCA5D927A12.basename))
      _id_EFFB4AE1788A8B10 = "laserbox_hip01_p01";
    else {
      switch (_id_F0FFAFCA5D927A12.classname) {
        case "sniper":
        case "rifle":
          _id_EFFB4AE1788A8B10 = "laserbox_hip01";
          break;
        case "mg":
          _id_EFFB4AE1788A8B10 = "laserbox_hip01";
          break;
        case "pistol":
          _id_EFFB4AE1788A8B10 = "laserpstl_hip01";
          break;
        case "smg":
          _id_EFFB4AE1788A8B10 = "flashlight_box02";
          break;
        case "spread":
          _id_EFFB4AE1788A8B10 = "flashlight_cyl02";
          break;
        default:
          break;
      }
    }

    if(isDefined(_id_580837BA9DE8F3D4)) {
      if(_func_6730D890F604CABE(_id_F0FFAFCA5D927A12, _id_580837BA9DE8F3D4) != -1)
        _id_EFFB4AE1788A8B10 = _id_580837BA9DE8F3D4;
    }

    _id_DD515FCF025B2E79 = scripts\mp\weapons::addattachmenttoweapon(_id_F0FFAFCA5D927A12, _id_EFFB4AE1788A8B10);

    if(isDefined(_id_DD515FCF025B2E79)) {
      _id_B003E2C45A4BF6F7 = undefined;
      agent takeweapon(_id_F0FFAFCA5D927A12);
      weaponname = getcompleteweaponname(_id_F0FFAFCA5D927A12);

      if(isDefined(agent.weaponinfo[weaponname])) {
        _id_B003E2C45A4BF6F7 = agent.weaponinfo[weaponname].position;
        agent.weaponinfo = scripts\engine\utility::array_remove_key(agent.weaponinfo, weaponname);
      }

      agent.weapon = _id_DD515FCF025B2E79;
      agent scripts\common\utility::initweapon(_id_DD515FCF025B2E79);
      _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "weapon", _id_DD515FCF025B2E79);
      agent giveweapon(_id_DD515FCF025B2E79);
      agent setspawnweapon(_id_DD515FCF025B2E79);
      agent.bulletsinclip = weaponclipsize(_id_DD515FCF025B2E79);
      agent.primaryweapon = _id_DD515FCF025B2E79;

      if(isDefined(_id_B003E2C45A4BF6F7) && isDefined(agent.a.weaponpos[_id_B003E2C45A4BF6F7])) {
        weaponname = getcompleteweaponname(_id_DD515FCF025B2E79);
        agent.weaponinfo[weaponname].position = _id_B003E2C45A4BF6F7;
        agent.a.weaponpos[_id_B003E2C45A4BF6F7] = _id_DD515FCF025B2E79;
        return;
      }
    } else {}
  }
}

_id_77EB9584ECCFBBC0() {
  level endon("game_ended");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(self)) {
      return;
    }
    self _meth_DFB78B3E724AD620(0);
    wait 0.05;

    if(!isDefined(self)) {
      return;
    }
    self _meth_DFB78B3E724AD620(1);
    wait 0.05;
  }
}

_id_2A171645B15089FF(_id_A50CC364A48A1F6F, _id_07D9A7690CC33EC1) {
  level endon("game_ended");
  _id_07919BB8D7505A92 = scripts\engine\utility::getStructArray(_id_A50CC364A48A1F6F, "script_noteworthy");

  foreach(_id_6EFE0C080EEEDD55 in _id_07919BB8D7505A92) {
    _id_A679C918818FA808 = getlootscriptablearrayinradius(undefined, undefined, _id_6EFE0C080EEEDD55.origin, _id_07D9A7690CC33EC1);

    foreach(loot in _id_A679C918818FA808) {
      if(loot.type == "br_loot_cache_lege" || loot.type == "br_loot_cache")
        loot setscriptablepartstate("body", "partially_opening_unusable");
    }
  }
}