/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_164e99d8d824a8e2.gsc
***********************************************/

init() {
  level._id_BBCDC4CF394D1E97 = 0;

  while(!isDefined(level.struct_class_names) || !isDefined(level.br_pickups))
    waitframe();

  if(getdvarint("dvar_FFF3F32249AB9121", 0) == 1) {
    level thread _id_701449195235BE31::_id_2A171645B15089FF("uniquedoor_datacenter_saferoom", 1000);
    _id_AB322B0B1C9355CB = scripts\engine\utility::getStructArray("biobunker_datacenter_panel_vfx", "script_noteworthy");

    foreach(_id_850AB69BFC46BCF6 in _id_AB322B0B1C9355CB)
    _id_850AB69BFC46BCF6 = spawnscriptable(_id_850AB69BFC46BCF6.script_noteworthy, _id_850AB69BFC46BCF6.origin, _id_850AB69BFC46BCF6.angles);

    return;
  }

  _id_701449195235BE31::_id_6CAE4397834E60C8("brloot_valuable_laptop_biobunker_node", "brloot_valuable_laptop_biobunker", 2, 1);
  _id_91C6CBC3CEA6F99C = scripts\engine\utility::getStruct("hack_reinforce_guard_point", "script_noteworthy");
  level._id_06F5130224E78299 = [];
  _id_745CBAD97AF9DF8C = scripts\engine\utility::getStructArray("datacenter_laptop", "targetname");

  if(isDefined(_id_745CBAD97AF9DF8C)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_745CBAD97AF9DF8C.size; _id_AC0E594AC96AA3A8++) {
      _id_9A01675C5F6B90A1 = spawnscriptable("biobunker_datacenter_panel_laptop", _id_745CBAD97AF9DF8C[_id_AC0E594AC96AA3A8].origin, _id_745CBAD97AF9DF8C[_id_AC0E594AC96AA3A8].angles);
      _id_E7418A40005F3175 = scripts\engine\utility::getStructArray(_id_745CBAD97AF9DF8C[_id_AC0E594AC96AA3A8].target, "targetname");

      foreach(_id_2B9A4F0A1E02E5C4 in _id_E7418A40005F3175) {
        _id_8A46C62F0A756DD3 = spawnscriptable(_id_2B9A4F0A1E02E5C4.script_noteworthy, _id_2B9A4F0A1E02E5C4.origin, _id_2B9A4F0A1E02E5C4.angles);
        _id_2B9A4F0A1E02E5C4._id_8A46C62F0A756DD3 = _id_8A46C62F0A756DD3;
      }

      _id_9A01675C5F6B90A1._id_51B1A8B16DFF9C96 = _id_E7418A40005F3175;
      _id_FCD5F86DDFAD7E24 = spawn("script_model", _id_9A01675C5F6B90A1.origin + (0, 0, 20));
      _id_FCD5F86DDFAD7E24 makeusable();
      _id_FCD5F86DDFAD7E24 setHintString(&"MP_BIOBUNKER/DATA_CENTER_PANEL_USE_REQUIRED");
      _id_FCD5F86DDFAD7E24 setCursorHint("HINT_NOBUTTON");
      _id_FCD5F86DDFAD7E24 sethintdisplayrange(65);
      _id_FCD5F86DDFAD7E24 sethintdisplayfov(125);
      _id_FCD5F86DDFAD7E24 setuserange(65);
      _id_FCD5F86DDFAD7E24 setusefov(125);
      _id_FCD5F86DDFAD7E24 sethintonobstruction("show");
      _id_FCD5F86DDFAD7E24 sethintlockplayermovement(1);
      _id_FCD5F86DDFAD7E24 thread _id_EEBD5EA80B6A073E(_id_9A01675C5F6B90A1, _id_E7418A40005F3175, _id_91C6CBC3CEA6F99C);
      _id_FCD5F86DDFAD7E24.scriptable = _id_9A01675C5F6B90A1;
      _id_9A01675C5F6B90A1.hint = _id_FCD5F86DDFAD7E24;
      _id_FCD5F86DDFAD7E24.trigger = spawn("trigger_radius", _id_9A01675C5F6B90A1.origin, 0, 75, 75);
      _id_FCD5F86DDFAD7E24.trigger thread _id_19B9FF221EADA269(_id_FCD5F86DDFAD7E24);
      level._id_06F5130224E78299[level._id_06F5130224E78299.size] = _id_9A01675C5F6B90A1;
    }
  }

  level thread _id_20597D33E23EF6AB();
}

_id_20597D33E23EF6AB() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");

  foreach(door in level._id_F64C6EF6F688A407) {
    if(isDefined(door._id_8F7EDDC9C0864A1B) && door._id_8F7EDDC9C0864A1B == "datacenter_saferoom") {
      door._id_65513AD5397A67EF = "dc_activity_key";
      _id_5C493302B016B154 = door._id_5C493302B016B154;
      _id_5C493302B016B154._id_65513AD5397A67EF = "dc_activity_key";

      if(istrue(door._id_3D9512B73BDC1514))
        door scriptabledoorfreeze(1);
      else
        _id_57D3850A12CF1D8F::_id_FBBFE6F05EDA5EB1(door);

      break;
    }
  }
}

_id_19B9FF221EADA269(_id_FCD5F86DDFAD7E24) {
  level endon("game_ended");
  level endon("data_center_hacked");

  for(;;) {
    self waittill("trigger", player);

    if(!isDefined(self) || !isDefined(_id_FCD5F86DDFAD7E24) || !isDefined(_id_FCD5F86DDFAD7E24.scriptable)) {
      break;
    }

    if(!isDefined(player) || !isalive(player)) {
      continue;
    }
    state = _id_FCD5F86DDFAD7E24.scriptable getscriptablepartstate("datacenter_laptop");

    if(state == "inactivated") {
      if(isDefined(_id_FCD5F86DDFAD7E24.player) && isalive(_id_FCD5F86DDFAD7E24.player) && player != _id_FCD5F86DDFAD7E24.player && distance(_id_FCD5F86DDFAD7E24.player.origin, _id_FCD5F86DDFAD7E24.origin) < 65) {
        continue;
      }
      _id_FCD5F86DDFAD7E24.player = player;

      if(player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(29315)) {
        _id_FCD5F86DDFAD7E24 setHintString(&"MP_BIOBUNKER/DATA_CENTER_PANEL_USE");
        _id_FCD5F86DDFAD7E24 setCursorHint("HINT_BUTTON");
        _id_FCD5F86DDFAD7E24 setuseholdduration("duration_long");
      } else {
        _id_FCD5F86DDFAD7E24 setHintString(&"MP_BIOBUNKER/DATA_CENTER_PANEL_USE_REQUIRED");
        _id_FCD5F86DDFAD7E24 setCursorHint("HINT_NOBUTTON");
      }

      continue;
    }

    if(state == "activated_single") {
      _id_FCD5F86DDFAD7E24 setHintString(&"MP_BIOBUNKER/DATA_CENTER_PANEL_HACKING");
      _id_FCD5F86DDFAD7E24 sethintstringparams(level._id_BBCDC4CF394D1E97, level._id_06F5130224E78299.size);
    }
  }

  if(isDefined(self))
    self delete();
}

_id_EEBD5EA80B6A073E(_id_9A01675C5F6B90A1, _id_E7418A40005F3175, _id_91C6CBC3CEA6F99C) {
  level endon("game_ended");
  level endon("data_center_hacked");

  for(;;) {
    self waittill("trigger", player);

    if(!isDefined(self)) {
      break;
    }

    if(!isDefined(player) || !isalive(player)) {
      continue;
    }
    state = _id_9A01675C5F6B90A1 getscriptablepartstate("datacenter_laptop");

    if(state == "inactivated") {
      if(player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(29315)) {
        if(!istrue(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(29315, 1))) {
          player scripts\mp\utility\lower_message::setlowermessageomnvar("bio_bunker_dc_panel_use_no_laptop", undefined, 3);
          _id_701449195235BE31::_id_77EB9584ECCFBBC0();
          continue;
        }
      } else {
        _id_701449195235BE31::_id_77EB9584ECCFBBC0();
        continue;
      }

      self _meth_DFB78B3E724AD620(0);
      self _meth_DFB78B3E724AD620(1);
      level._id_BBCDC4CF394D1E97++;

      if(level._id_BBCDC4CF394D1E97 < level._id_06F5130224E78299.size) {
        _id_9A01675C5F6B90A1 setscriptablepartstate("datacenter_laptop", "activated_single");

        foreach(_id_2B9A4F0A1E02E5C4 in _id_E7418A40005F3175)
        _id_2B9A4F0A1E02E5C4._id_8A46C62F0A756DD3 setscriptablepartstate("datacenter_panel_part", "activated_single");

        _id_9A01675C5F6B90A1.hint setCursorHint("HINT_NOBUTTON");
      } else {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_06F5130224E78299.size; _id_AC0E594AC96AA3A8++) {
          level._id_06F5130224E78299[_id_AC0E594AC96AA3A8] setscriptablepartstate("datacenter_laptop", "activated_all");

          foreach(_id_2B9A4F0A1E02E5C4 in level._id_06F5130224E78299[_id_AC0E594AC96AA3A8]._id_51B1A8B16DFF9C96)
          _id_2B9A4F0A1E02E5C4._id_8A46C62F0A756DD3 setscriptablepartstate("datacenter_panel_part", "activated_all");

          _id_FCD5F86DDFAD7E24 = level._id_06F5130224E78299[_id_AC0E594AC96AA3A8].hint;

          if(isDefined(_id_FCD5F86DDFAD7E24)) {
            if(isDefined(_id_FCD5F86DDFAD7E24.trigger))
              _id_FCD5F86DDFAD7E24.trigger delete();

            _id_FCD5F86DDFAD7E24 delete();
          }
        }

        foreach(player in level.players) {
          if(!isDefined(player)) {
            continue;
          }
          player._id_B2FB23E638ADC7D2 = "dc_activity_key";
        }

        player _id_3D732BB6A256ADFD::_id_D50D0A086958E440("stat_39A2298D6704DF34", "missionCompleted");

        if(soundexists("mp_dmz_alrm_trap")) {
          wait 2;
          playsoundatpos(_id_91C6CBC3CEA6F99C.origin + (0, 0, 120), "mp_dmz_alrm_trap");
        }

        wait 1.5;
        _id_2D9C29F869A29FCA::_id_844DFE93476D59AB("datacenter_hacked_reinforcement", player.origin, 64);
        level notify("data_center_hacked");
        break;
      }

      continue;
    }

    if(state == "activated_single")
      _id_701449195235BE31::_id_77EB9584ECCFBBC0();
  }

  if(isDefined(self))
    self delete();
}