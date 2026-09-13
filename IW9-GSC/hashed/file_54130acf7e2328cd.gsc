/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_54130acf7e2328cd.gsc
***********************************************/

init() {
  _id_2661B4D6A717AE21();
  level thread _id_7455F245ADD89EE7();
  scripts\cp_mp\utility\script_utility::registersharedfunc("biobunker_radiation", "isInBiobunkerRadiationVolume", ::_id_662F175187FAC58E);
}

#using_animtree("script_model");

_id_2661B4D6A717AE21() {
  level.scr_animtree["manual_door"] = #animtree;
  level.scr_model["manual_door"] = "structural_blast_door_bunker_biobunker_assembly";
  level.scr_anim["manual_door"]["door_open"] = % dmz_nuke_vault_door_open;
  level.scr_animname["manual_door"]["door_open"] = "dmz_nuke_vault_door_open";
  level.scr_anim["manual_door"]["door_close"] = % dmz_nuke_vault_door_close;
  level.scr_animname["manual_door"]["door_close"] = "dmz_nuke_vault_door_close";
}

_id_7455F245ADD89EE7() {
  level endon("game_ended");

  while(!isDefined(level.struct_class_names) || !isDefined(level.objectiveidpool))
    waitframe();

  _id_6D476F1DEA7803BB = [];
  _id_0D7470B0D25E4822 = [];
  _id_B9A2DFFF1288B930 = "radiation_phase_";

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 3; _id_AC0E594AC96AA3A8++) {
    _id_5388D2C9CE4922E5 = getEnt(_id_B9A2DFFF1288B930 + _id_AC0E594AC96AA3A8, "script_noteworthy");
    _id_5388D2C9CE4922E5 _id_97D3DD3DEBE1A589();
    _id_5388D2C9CE4922E5 _id_650368F3AA9734AD();
    _id_5388D2C9CE4922E5 _id_D5AC5FE51E0A3950();
    _id_5388D2C9CE4922E5 _id_DB75C5128A7CC0CE(_id_AC0E594AC96AA3A8);
    _id_0D7470B0D25E4822[_id_0D7470B0D25E4822.size] = _id_5388D2C9CE4922E5;
    _id_6D476F1DEA7803BB[_id_6D476F1DEA7803BB.size] = _id_5388D2C9CE4922E5;

    foreach(vol in _id_5388D2C9CE4922E5._id_FFE2D42CC55E9B2D)
    _id_6D476F1DEA7803BB[_id_6D476F1DEA7803BB.size] = vol;

    foreach(_id_9E9B05C4E7422981 in _id_5388D2C9CE4922E5._id_2C94C6EB2A09536E)
    _id_6D476F1DEA7803BB[_id_6D476F1DEA7803BB.size] = _id_9E9B05C4E7422981._id_F504CAB18E3E6D1E;
  }

  level._id_C2C1B609589593D6 = _id_6D476F1DEA7803BB;
  level thread _id_0864AF87D5910593(_id_6D476F1DEA7803BB);
  level thread _id_DA3E4D3E47FF9859(_id_6D476F1DEA7803BB);
  level thread _id_61BE0585DACB9199(_id_6D476F1DEA7803BB);
  level thread _id_758B369EBF76352A();
  level thread _id_9A41406F250EF300(_id_0D7470B0D25E4822);
  level thread _id_FB4393CDED0867DC();
  level thread _id_57D755E039C1429E();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("bunkerdoor_button", ::_id_4FC5403A566D1263);
}

_id_97D3DD3DEBE1A589() {
  _id_D6C04A6D8C7B7693 = getentitylessscriptablearray(self.target, "targetname");

  if(isDefined(_id_D6C04A6D8C7B7693[0])) {
    self._id_0E4118BDA122B112 = _id_D6C04A6D8C7B7693[0];
    self._id_0E4118BDA122B112 setscriptablepartstate("bunkerdoor_light", "activated", 0);
  } else {}

  _id_51D497EA5E755E18 = scripts\engine\utility::getStruct(self.target, "targetname");

  if(isDefined(_id_51D497EA5E755E18)) {
    self._id_605BEDAF6FB5F0E5 = _id_51D497EA5E755E18;
    self._id_605BEDAF6FB5F0E5.light = self._id_0E4118BDA122B112;
  } else {}
}

_id_D5AC5FE51E0A3950() {
  _id_75746B3B51F3A581 = getEntArray(self.target, "targetname");
  _id_F56BCE83866A4E89(_id_75746B3B51F3A581);

  switch (self.script_noteworthy) {
    case "radiation_phase_1":
      _id_B3D0499A91ECFFAA = _id_7C927BB4F47DAAE4(_id_75746B3B51F3A581, 2);

      foreach(door in _id_B3D0499A91ECFFAA) {
        door._id_33A2175A9A4306BC = 0;
        door.closed = 0;
        door._id_27356B036BCCF82E = 1;
        door._id_CEDEA810AE6B89CF = 1;
      }

      _id_B3D0499A91ECFFAA[0]._id_33A2175A9A4306BC = 1;
      _id_9F919DB62BBDD89C(_id_B3D0499A91ECFFAA);
      break;
    case "radiation_phase_2":
      _id_B3D0499A91ECFFAA = _id_7C927BB4F47DAAE4(_id_75746B3B51F3A581, 4);

      foreach(door in _id_B3D0499A91ECFFAA) {
        door._id_33A2175A9A4306BC = 1;
        door.closed = 0;
        door._id_27356B036BCCF82E = 1;
        door._id_CEDEA810AE6B89CF = 1;
      }

      _id_B3D0499A91ECFFAA[0]._id_33A2175A9A4306BC = 0;
      level thread _id_05FCD52E61B5250B(2, _id_B3D0499A91ECFFAA[0].script_index);
      _id_B3D0499A91ECFFAA[1].closed = 1;
      _id_B3D0499A91ECFFAA[1]._id_33A2175A9A4306BC = 0;
      _id_B3D0499A91ECFFAA[1]._id_27356B036BCCF82E = 0;
      _id_B3D0499A91ECFFAA[1] thread _id_44344A83843EA13D();
      _id_B3D0499A91ECFFAA[1] thread _id_09AE2E428FD385EB();
      _id_B3D0499A91ECFFAA[1] thread _id_A2DBD8D9D4E7D794();
      _id_9F919DB62BBDD89C(_id_B3D0499A91ECFFAA);
      break;
    case "radiation_phase_3":
      _id_B3D0499A91ECFFAA = _id_7C927BB4F47DAAE4(_id_75746B3B51F3A581, 4);

      foreach(door in _id_B3D0499A91ECFFAA) {
        door._id_33A2175A9A4306BC = 1;
        door.closed = 0;
        door._id_27356B036BCCF82E = 0;
        door._id_CEDEA810AE6B89CF = 1;
      }

      _id_B3D0499A91ECFFAA[0]._id_27356B036BCCF82E = 1;
      _id_B3D0499A91ECFFAA[0].closed = 1;
      _id_B3D0499A91ECFFAA[0] thread _id_44344A83843EA13D();
      _id_B3D0499A91ECFFAA[1]._id_33A2175A9A4306BC = 0;
      level thread _id_05FCD52E61B5250B(3, _id_B3D0499A91ECFFAA[1].script_index);
      _id_B3D0499A91ECFFAA[2]._id_27356B036BCCF82E = 1;
      _id_9F919DB62BBDD89C(_id_B3D0499A91ECFFAA);
      break;
  }
}

_id_7C927BB4F47DAAE4(_id_75746B3B51F3A581, _id_879FADF6CE21C660) {
  _id_B3D0499A91ECFFAA = [];
  _id_75746B3B51F3A581 = scripts\engine\utility::array_randomize(_id_75746B3B51F3A581);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_879FADF6CE21C660; _id_AC0E594AC96AA3A8++) {
    _id_75746B3B51F3A581[_id_AC0E594AC96AA3A8].enable = 1;
    _id_B3D0499A91ECFFAA[_id_AC0E594AC96AA3A8] = _id_75746B3B51F3A581[_id_AC0E594AC96AA3A8];

    if(_id_B3D0499A91ECFFAA[_id_AC0E594AC96AA3A8].script_index == 3 && _id_B3D0499A91ECFFAA[_id_AC0E594AC96AA3A8].targetname == "radiation_phase_3")
      level._id_6C879C92C6D61028 = _id_B3D0499A91ECFFAA[_id_AC0E594AC96AA3A8];
  }

  return _id_B3D0499A91ECFFAA;
}

_id_F56BCE83866A4E89(_id_75746B3B51F3A581) {
  foreach(door in _id_75746B3B51F3A581) {
    door._id_5B557D68019B1895 = 0;
    door.animname = "manual_door";
    door scripts\common\anim::setanimtree();
    door setModel("yellow::structural_blast_door_bunker_biobunker_assembly");
    door thread scripts\common\anim::anim_first_frame_solo(door, "door_open");
    door.closed = 1;
    ents = getEntArray(door.target, "targetname");

    if(isDefined(ents)) {
      foreach(ent in ents) {
        if(ent.script_noteworthy == "clip")
          door.axis = ent;

        if(ent.script_noteworthy == "clip_player")
          door._id_14D9D4FFFC09A76D = ent;

        if(ent.script_noteworthy == "volume")
          door._id_F504CAB18E3E6D1E = ent;
      }
    } else {}

    _id_53948F219984A4D9 = scripts\engine\utility::getStructArray(door.target, "targetname");
    door._id_53948F219984A4D9 = [];

    foreach(_id_08B6FBD0C52928B0 in _id_53948F219984A4D9) {
      door._id_53948F219984A4D9[door._id_53948F219984A4D9.size] = _id_08B6FBD0C52928B0;
      _id_08B6FBD0C52928B0._id_51F127F126DB4B5D = spawn("script_model", _id_08B6FBD0C52928B0.origin);
      _id_08B6FBD0C52928B0._id_51F127F126DB4B5D setModel("light_yellow::ee_pipe_05_valve_01_wheel_broken");
      _id_08B6FBD0C52928B0._id_51F127F126DB4B5D.angles = _id_08B6FBD0C52928B0.angles;
    }

    _id_D6C04A6D8C7B7693 = getentitylessscriptablearray(door.target, "targetname");
    door._id_ACBCC50DD8904645 = [];

    if(isDefined(_id_D6C04A6D8C7B7693)) {
      foreach(scriptable in _id_D6C04A6D8C7B7693) {
        if(scriptable.script_noteworthy == "scriptable_button") {
          door._id_C1E998720BF6D63A = scriptable;
          door._id_C1E998720BF6D63A.door = door;
          door._id_C1E998720BF6D63A setscriptablepartstate("bunkerdoor_button_model", "bunkerdoor_buttont_broken_model");
        }

        if(scriptable.script_noteworthy == "canister") {
          door._id_ACBCC50DD8904645[door._id_ACBCC50DD8904645.size] = scriptable;
          scriptable setscriptablepartstate("canister", "clear");
        }
      }

      continue;
    }
  }
}

_id_9F919DB62BBDD89C(_id_B3D0499A91ECFFAA) {
  foreach(door in _id_B3D0499A91ECFFAA) {
    door _id_D25C79A5CFC96114(self);

    if(door._id_27356B036BCCF82E) {
      door._id_C1E998720BF6D63A setscriptablepartstate("bunkerdoor_button_model", "bunkerdoor_buttont_usable_model");

      if(door.closed)
        door._id_C1E998720BF6D63A setscriptablepartstate("bunkerdoor_button", "usable_open");

      door._id_C1E998720BF6D63A setscriptablepartstate("bunkerdoor_button", "usable");
    }

    if(door._id_CEDEA810AE6B89CF)
      door _id_28DD394D144D8A52();

    if(door._id_33A2175A9A4306BC) {
      if(!door.closed)
        _id_479E458F6F530F0D::_id_F0D61E14DFDE9CCD(door._id_ACBCC50DD8904645[0]);

      foreach(_id_4E0D9C78FA04CDD4 in door._id_ACBCC50DD8904645)
      _id_4E0D9C78FA04CDD4 setscriptablepartstate("canister", "radiation");
    }

    doorclip = getEnt(door.axis.target, "targetname");
    doorclip linkTo(door.axis);
    door.axis.doorclip = doorclip;
    _id_39A621FDAB9D783E = getEnt(door._id_14D9D4FFFC09A76D.target, "targetname");
    _id_39A621FDAB9D783E linkTo(door._id_14D9D4FFFC09A76D);
    door._id_14D9D4FFFC09A76D.doorclip = _id_39A621FDAB9D783E;

    if(!door.closed) {
      door thread scripts\common\anim::anim_first_frame_solo(door, "door_close");
      door.axis.doorclip disconnectPaths();
      door.axis thread _id_701449195235BE31::_id_2AB59E04B43701ED(-102, 1, 0, 0);
      door._id_14D9D4FFFC09A76D.doorclip disconnectPaths();
      door._id_14D9D4FFFC09A76D thread _id_701449195235BE31::_id_2AB59E04B43701ED(-102, 1, 0, 0);
    }
  }
}

_id_D25C79A5CFC96114(_id_9D0BAA9EE652F555) {
  self._id_F504CAB18E3E6D1E.status = "deactivated";
  self._id_F504CAB18E3E6D1E.door = self;
  self._id_D0744581F786828B = _id_9D0BAA9EE652F555;

  if(!self._id_33A2175A9A4306BC)
    _id_9D0BAA9EE652F555._id_FFE2D42CC55E9B2D[_id_9D0BAA9EE652F555._id_FFE2D42CC55E9B2D.size] = self._id_F504CAB18E3E6D1E;
  else {
    self._id_F504CAB18E3E6D1E.status = "active";
    _id_9D0BAA9EE652F555._id_2C94C6EB2A09536E[_id_9D0BAA9EE652F555._id_2C94C6EB2A09536E.size] = self;

    if(!self.closed)
      _id_9D0BAA9EE652F555._id_79E0913B5EA51E1D[self.script_index] = 1;
  }

  if(!self.closed)
    self._id_F504CAB18E3E6D1E.status = "active";

  _id_54142D2676ABDB0B();
}

_id_28DD394D144D8A52() {
  foreach(_id_08B6FBD0C52928B0 in self._id_53948F219984A4D9) {
    _id_08B6FBD0C52928B0._id_51F127F126DB4B5D setModel("light_yellow::ee_pipe_05_valve_01_wheel_yellow");
    _id_08B6FBD0C52928B0._id_51F127F126DB4B5D.angles = _id_08B6FBD0C52928B0.angles;
    _id_08B6FBD0C52928B0.door = self;
    _id_08B6FBD0C52928B0._id_D0DDF8B1760B6E2C = spawnscriptable("biobunker_bunkerdoor_crank_stem", _id_08B6FBD0C52928B0.origin);

    if(isDefined(_id_08B6FBD0C52928B0.script_label)) {
      if(_id_08B6FBD0C52928B0.script_label == "outside")
        self._id_D50C51FC054DE81F = _id_08B6FBD0C52928B0;
    } else
      self._id_1CBACF0A8ABA28B4 = _id_08B6FBD0C52928B0;

    if(!isDefined(self._id_53948F219984A4D9))
      self._id_53948F219984A4D9 = [];

    self._id_53948F219984A4D9[self._id_53948F219984A4D9.size] = _id_08B6FBD0C52928B0;

    if(!isDefined(level._id_D2D6A0D2FC3C0E38))
      level._id_D2D6A0D2FC3C0E38 = [];

    level._id_D2D6A0D2FC3C0E38[level._id_D2D6A0D2FC3C0E38.size] = _id_08B6FBD0C52928B0;
    _id_08B6FBD0C52928B0._id_B93BA4E9C5805F0A = 0;
    _id_08B6FBD0C52928B0.progress = 0;
    _id_08B6FBD0C52928B0._id_D32CCBD5A44D790D = 0;
    _id_08B6FBD0C52928B0.capturetime = getdvarint("dvar_641B3F5D7D34B0F6", 6);
    _id_08B6FBD0C52928B0._id_243F810EBB89FEF1 = squared(128);
  }
}

_id_650368F3AA9734AD() {
  self.status = "active";
  self._id_FFE2D42CC55E9B2D = [];
  self._id_2C94C6EB2A09536E = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++)
    self._id_79E0913B5EA51E1D[_id_AC0E594AC96AA3A8] = 0;

  _id_64D09AE5CD426F8E();
}

_id_64D09AE5CD426F8E() {
  _id_9A7956B6A5AFA143 = getentitylessscriptablearray(self.target, "script_noteworthy");
  self._id_3FDD2AC01443A0D0 = _id_9A7956B6A5AFA143[0];
  self._id_3FDD2AC01443A0D0 setscriptablepartstate("radiation", "radiationEnable");
}

_id_54142D2676ABDB0B() {
  _id_67F14F8315CB0F2F = strtok(self.target, "_");
  _id_9A7956B6A5AFA143 = getentitylessscriptablearray(_id_67F14F8315CB0F2F[1], "script_noteworthy");
  self._id_3FDD2AC01443A0D0 = _id_9A7956B6A5AFA143[0];

  if(self._id_F504CAB18E3E6D1E.status == "active")
    self._id_3FDD2AC01443A0D0 setscriptablepartstate("radiation", "radiationEnable");
}

_id_A5B1FDFF20A8BD69() {
  volumes = [];

  if(isDefined(level._id_C2C1B609589593D6)) {
    foreach(volume in level._id_C2C1B609589593D6) {
      if(volume.status == "active")
        volumes[volumes.size] = volume;
    }
  }

  return volumes;
}

_id_662F175187FAC58E(origin) {
  volumes = _id_A5B1FDFF20A8BD69();

  foreach(volume in volumes) {
    if(ispointinvolume(origin, volume))
      return 1;
  }

  return 0;
}

_id_0864AF87D5910593(_id_6D476F1DEA7803BB) {
  level endon("game_ended");
  level waittill("matchStartTimer_done");

  if(getdvarint("dvar_6104190544BFE7C3", 1)) {
    for(;;) {
      _id_1C02B1AEEAFF8C6A = [];

      foreach(vol in _id_6D476F1DEA7803BB) {
        if(vol.status == "active")
          _id_1C02B1AEEAFF8C6A[_id_1C02B1AEEAFF8C6A.size] = vol;
      }

      foreach(player in level.players) {
        if(!isDefined(player) || !isalive(player)) {
          continue;
        }
        _id_44F8A3BCD427CBB3 = 0;

        foreach(vol in _id_1C02B1AEEAFF8C6A) {
          if(ispointinvolume(player.origin, vol)) {
            _id_44F8A3BCD427CBB3 = 1;
            break;
          }
        }

        if(_id_44F8A3BCD427CBB3 && !istrue(player._id_E6204058F06B94E5)) {
          if(scripts\cp_mp\gasmask::hasgasmask(player) && !istrue(player.gasmaskswapinprogress))
            player _id_7E52B56769FA7774::_id_00CDF7F2F6BD3207("puzzle_radiation");

          _id_1174ABEDBEFE9ADA::_id_C4A3072CE7B3F1FD(player, getdvarint("dvar_3EC52821551CB391", 5), 0);
          continue;
        }

        if(scripts\cp_mp\gasmask::hasgasmask(player) && !istrue(player.gasmaskswapinprogress))
          player _id_7E52B56769FA7774::_id_8206BC54A1ED73CB("puzzle_radiation");
      }

      wait 1;
    }
  }
}

_id_DA3E4D3E47FF9859(_id_6D476F1DEA7803BB) {
  level endon("game_ended");
  level waittill("matchStartTimer_done");

  for(;;) {
    foreach(player in level.players) {
      _id_B670211E29D8308D = 0;

      foreach(volume in _id_6D476F1DEA7803BB) {
        if(volume.status == "active" && ispointinvolume(player.origin, volume)) {
          _id_B670211E29D8308D = 1;
          break;
        }
      }

      if(_id_B670211E29D8308D) {
        player thread _id_695D46C833824DD7(player);
        continue;
      }

      player._id_ED9F8A3B11D67A31 = 0;
      player notify("exitedVolumes");
    }

    waitframe();
  }
}

_id_695D46C833824DD7(player) {
  player endon("death");
  player endon("exitedVolumes");

  if(istrue(player._id_ED9F8A3B11D67A31)) {
    return;
  }
  player._id_ED9F8A3B11D67A31 = 1;

  for(;;) {
    _id_744AF42B66F6D746 = randomfloatrange(0.2, 0.8);

    if(istrue(player.extracted)) {
      player._id_ED9F8A3B11D67A31 = 0;
      player notify("exitedVolumes");
    }

    if(isDefined(_id_744AF42B66F6D746)) {
      player playlocalsound("iw9_mp_radiation_tick");
      wait(_id_744AF42B66F6D746);
    }

    waitframe();
  }
}

_id_61BE0585DACB9199(_id_6D476F1DEA7803BB) {
  level endon("game_ended");
  level waittill("matchStartTimer_done");
  _id_055E91E475DD1A6B = 3;
  _id_1C02B1AEEAFF8C6A = [];

  for(;;) {
    agents = _func_7E3F22E620F3F71E("biobunker_radiation", "everybody");

    if(agents.size > 0) {
      _id_87FEAEF653A8C7DA = scripts\engine\utility::array_randomize(agents);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_87FEAEF653A8C7DA.size; _id_AC0E594AC96AA3A8++) {
        if(_id_AC0E594AC96AA3A8 % _id_055E91E475DD1A6B == 0) {
          waitframe();
          _id_1C02B1AEEAFF8C6A = [];

          foreach(vol in _id_6D476F1DEA7803BB) {
            if(vol.status == "active")
              _id_1C02B1AEEAFF8C6A[_id_1C02B1AEEAFF8C6A.size] = vol;
          }
        }

        agent = _id_87FEAEF653A8C7DA[_id_AC0E594AC96AA3A8];

        if(!isDefined(agent) || !isalive(agent) || istrue(agent._id_65771500F49956C1)) {
          continue;
        }
        _id_44F8A3BCD427CBB3 = 0;

        foreach(vol in _id_1C02B1AEEAFF8C6A) {
          if(ispointinvolume(agent.origin, vol)) {
            _id_44F8A3BCD427CBB3 = 1;
            break;
          }
        }

        if(_id_44F8A3BCD427CBB3) {
          damage = 10;
          damagemultiplier = scripts\engine\utility::ter_op(isDefined(agent.maxhealth), agent.maxhealth * 0.01, 1);
          agent dodamage(int(damage * damagemultiplier), agent.origin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br", "torso_upper");
        }
      }
    }

    wait 1;
  }
}

_id_4FC5403A566D1263(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_5F852D5D8F5DA831(instance);
  instance.door _id_AC9FEBA62C6D7CF3();
}

_id_A2EAE745C89B1968() {
  level endon("game_ended");
  self.hint endon("death");
  _id_F281046D69A15216 = 2;

  for(;;) {
    self.hint waittill("trigger", player);

    if(!self.hint._id_2EDE9F5D69830193) {
      continue;
    }
    scripts\mp\objidpoolmanager::update_objective_icon(self.hint.objidnum, "ui_map_icon_repair");
    scripts\mp\objidpoolmanager::update_objective_setbackground(self.hint.objidnum, 1);
    scripts\mp\objidpoolmanager::update_objective_state(self.hint.objidnum, "current");
    scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.hint.objidnum, player.team);
    self notify("inUse");
    waitframe();
    self._id_51F127F126DB4B5D stopsounds();
    self._id_D0DDF8B1760B6E2C setscriptablepartstate("crank_stem", "idle");
    self._id_1BC8A82F95D48F4E = 0;
    _id_CAC2B2FB9C00D470 = 0;
    _id_D66E93508F7B4AB9 = self._id_B40694FC388C2200 / (_id_F281046D69A15216 * 20);
    _id_30F0AABB2EB7E4AE = self.capturetime / _id_F281046D69A15216 * self._id_B40694FC388C2200;

    for(;;) {
      if(!isalive(player) || scripts\mp\utility\player::isinlaststand(player) || !player useButtonPressed() || distance2dsquared(self.origin, player.origin) >= self._id_243F810EBB89FEF1 || !self.hint._id_2EDE9F5D69830193) {
        progress = self.progress / self.capturetime;
        scripts\mp\objidpoolmanager::objective_set_progress(self.hint.objidnum, progress);

        foreach(_id_80EF668C09FFB70F in scripts\mp\utility\teams::getteamdata(player.team, "players"))
        scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.hint.objidnum, _id_80EF668C09FFB70F);

        scripts\mp\objidpoolmanager::objective_teammask_removefrommask(self.hint.objidnum, player.team);
        self._id_51F127F126DB4B5D stopsounds();
        thread _id_3CA970C05C7F4FA7();
        self.door _id_3729D24DF7C929EA();
        break;
      }

      foreach(_id_08B6FBD0C52928B0 in self.door._id_53948F219984A4D9) {
        if(isDefined(_id_08B6FBD0C52928B0.hint) && _id_08B6FBD0C52928B0.hint isusable()) {
          if(_id_08B6FBD0C52928B0.hint == self.hint) {
            _id_08B6FBD0C52928B0.hint makeunusable();
            continue;
          }

          _id_08B6FBD0C52928B0.hint._id_2EDE9F5D69830193 = 0;
          _id_08B6FBD0C52928B0.hint setCursorHint("HINT_NOBUTTON");
          _id_08B6FBD0C52928B0.hint setHintString(&"MP_BIOBUNKER/CRANK_IN_USE");
        }
      }

      self.progress = min(self.capturetime, self.progress + level.framedurationseconds);

      if(self.progress > self._id_1BC8A82F95D48F4E && (gettime() - _id_CAC2B2FB9C00D470) / 1000 >= _id_F281046D69A15216) {
        _id_A73B548A39B19AEB = _id_30F0AABB2EB7E4AE - self._id_D32CCBD5A44D790D;

        if(_id_A73B548A39B19AEB != 0) {
          if(abs(_id_A73B548A39B19AEB) < abs(self._id_B40694FC388C2200))
            self._id_51F127F126DB4B5D rotatepitch(_id_A73B548A39B19AEB, _id_F281046D69A15216 * _id_A73B548A39B19AEB / self._id_B40694FC388C2200, 0, 0.1);
          else
            self._id_51F127F126DB4B5D rotatepitch(self._id_B40694FC388C2200, _id_F281046D69A15216 - 0.2, _id_F281046D69A15216 * 0.1, _id_F281046D69A15216 * 0.1);
        }

        self._id_51F127F126DB4B5D _id_109E2D99642BC7E1(0);
        self._id_1BC8A82F95D48F4E = self.progress;
        _id_CAC2B2FB9C00D470 = gettime();
      }

      self._id_D32CCBD5A44D790D = self._id_D32CCBD5A44D790D + _id_D66E93508F7B4AB9;
      progress = self.progress / self.capturetime;
      scripts\mp\objidpoolmanager::objective_set_progress(self.hint.objidnum, progress);
      scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(self.hint.objidnum, player, 1, 2, self._id_96E045575043919C);

      if(self.progress >= self.capturetime) {
        foreach(_id_80EF668C09FFB70F in scripts\mp\utility\teams::getteamdata(player.team, "players"))
        scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.hint.objidnum, _id_80EF668C09FFB70F);

        scripts\mp\objidpoolmanager::objective_teammask_removefrommask(self.hint.objidnum, player.team);
        self.progress = 0;
        self._id_D32CCBD5A44D790D = 0;
        self.door thread _id_AC9FEBA62C6D7CF3();
        break;
      }

      waitframe();
    }
  }
}

_id_AC9FEBA62C6D7CF3() {
  if(self._id_5B557D68019B1895) {
    return;
  }
  self._id_5B557D68019B1895 = 1;

  if(!self.closed) {
    self.closed = 1;
    _id_23FC69E57175309D = 0;

    foreach(_id_08B6FBD0C52928B0 in self._id_53948F219984A4D9) {
      if(isDefined(_id_08B6FBD0C52928B0.hint)) {
        if(!_id_08B6FBD0C52928B0.hint isusable())
          _id_08B6FBD0C52928B0.hint makeusable();

        _id_08B6FBD0C52928B0.hint setCursorHint("HINT_NOBUTTON");
        _id_08B6FBD0C52928B0.hint setHintString(&"MP_BIOBUNKER/DOOR_IN_OPERATING");
        _id_08B6FBD0C52928B0.hint._id_2EDE9F5D69830193 = 0;
      }
    }

    if(isDefined(self._id_C1E998720BF6D63A))
      self._id_C1E998720BF6D63A setscriptablepartstate("bunkerdoor_button", "disabled");

    if(self._id_33A2175A9A4306BC) {
      self._id_D0744581F786828B._id_79E0913B5EA51E1D[self.script_index] = 0;

      if(self._id_D0744581F786828B._id_79E0913B5EA51E1D[0] == 0 && self._id_D0744581F786828B._id_79E0913B5EA51E1D[1] == 0 && self._id_D0744581F786828B._id_79E0913B5EA51E1D[2] == 0 && self._id_D0744581F786828B._id_79E0913B5EA51E1D[3] == 0) {
        self._id_D0744581F786828B._id_605BEDAF6FB5F0E5.light setscriptablepartstate("bunkerdoor_light", "opening", 0);
        _id_23FC69E57175309D = 1;
      }
    }

    _id_F63E6414BF88700F(0);
    self.axis thread _id_701449195235BE31::_id_2AB59E04B43701ED(102, 5.5, 0.1, 0.5);
    self._id_14D9D4FFFC09A76D thread _id_701449195235BE31::_id_2AB59E04B43701ED(102, 5.5, 0.1, 0.5);
    self useanimtree(#animtree);
    scripts\common\anim::anim_single_solo(self, "door_close");
    self._id_5B557D68019B1895 = 0;
    _id_3729D24DF7C929EA();

    if(_id_23FC69E57175309D) {
      if(isDefined(self._id_D0744581F786828B._id_605BEDAF6FB5F0E5))
        self._id_D0744581F786828B._id_605BEDAF6FB5F0E5 _id_895B6E76C40422C1(self._id_D0744581F786828B);

      if(isDefined(self._id_D0744581F786828B._id_FFE2D42CC55E9B2D)) {
        foreach(volume in self._id_D0744581F786828B._id_FFE2D42CC55E9B2D) {
          volume.status = "deactivated";
          volume.door._id_3FDD2AC01443A0D0 setscriptablepartstate("radiation", "idle");
        }
      }

      if(isDefined(self._id_D0744581F786828B)) {
        self._id_D0744581F786828B.status = "deactivated";
        self._id_D0744581F786828B._id_3FDD2AC01443A0D0 setscriptablepartstate("radiation", "idle");
      }
    }

    if(!self._id_33A2175A9A4306BC) {
      self._id_F504CAB18E3E6D1E.status = "deactivated";
      self._id_3FDD2AC01443A0D0 setscriptablepartstate("radiation", "idle");
    } else
      _id_479E458F6F530F0D::_id_A67007B5AF86FF0B(self._id_ACBCC50DD8904645[0]);

    if(isDefined(self._id_C1E998720BF6D63A)) {
      if("bunkerdoor_buttont_usable_model" == self._id_C1E998720BF6D63A getscriptablepartstate("bunkerdoor_button_model")) {
        self._id_C1E998720BF6D63A setscriptablepartstate("bunkerdoor_button", "usable_open");
        return;
      }

      return;
    }
  } else {
    self.closed = 0;

    foreach(_id_08B6FBD0C52928B0 in self._id_53948F219984A4D9) {
      if(isDefined(_id_08B6FBD0C52928B0.hint)) {
        if(!_id_08B6FBD0C52928B0.hint isusable())
          _id_08B6FBD0C52928B0.hint makeusable();

        _id_08B6FBD0C52928B0.hint setCursorHint("HINT_NOBUTTON");
        _id_08B6FBD0C52928B0.hint setHintString(&"MP_BIOBUNKER/DOOR_IN_OPERATING");
        _id_08B6FBD0C52928B0.hint._id_2EDE9F5D69830193 = 0;
      }
    }

    if(isDefined(self._id_C1E998720BF6D63A))
      self._id_C1E998720BF6D63A setscriptablepartstate("bunkerdoor_button", "disabled");

    if(self._id_33A2175A9A4306BC) {
      self._id_D0744581F786828B._id_79E0913B5EA51E1D[self.script_index] = 1;
      self._id_D0744581F786828B.status = "active";
      self._id_D0744581F786828B._id_3FDD2AC01443A0D0 thread _id_2C4C65F02D528A95();
      self._id_D0744581F786828B._id_605BEDAF6FB5F0E5 _id_36563D29BA446A97(self._id_D0744581F786828B);
      _id_479E458F6F530F0D::_id_F0D61E14DFDE9CCD(self._id_ACBCC50DD8904645[0]);
    }

    if(isDefined(self._id_D0744581F786828B._id_FFE2D42CC55E9B2D)) {
      foreach(volume in self._id_D0744581F786828B._id_FFE2D42CC55E9B2D) {
        if(!volume.door.closed && self._id_D0744581F786828B.status == "active") {
          volume.status = "active";
          volume.door._id_3FDD2AC01443A0D0 thread _id_2C4C65F02D528A95();
        }
      }
    }

    self useanimtree(#animtree);
    self.axis thread _id_701449195235BE31::_id_2AB59E04B43701ED(-102, 5.5, 0.1, 0.5);
    self._id_14D9D4FFFC09A76D thread _id_701449195235BE31::_id_2AB59E04B43701ED(-102, 5.5, 0.1, 0.5);
    _id_F63E6414BF88700F(1);
    scripts\common\anim::anim_single_solo(self, "door_open");
    self._id_5B557D68019B1895 = 0;
    _id_3729D24DF7C929EA();

    if(isDefined(self._id_C1E998720BF6D63A)) {
      if("bunkerdoor_buttont_usable_model" == self._id_C1E998720BF6D63A getscriptablepartstate("bunkerdoor_button_model"))
        self._id_C1E998720BF6D63A setscriptablepartstate("bunkerdoor_button", "usable");
    }
  }
}

_id_895B6E76C40422C1(_id_9D0BAA9EE652F555) {
  doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(self.origin, 64, 75);

  if(isDefined(self.light)) {
    self.light setscriptablepartstate("bunkerdoor_light", "open_with_sound", 0);
    _id_7E4457DA8D15B89F(_id_9D0BAA9EE652F555._id_B947C76FCEF1AFDB);
  }

  _id_57D3850A12CF1D8F::_id_B092780F9EC4496E(doors[0]);
}

_id_36563D29BA446A97(_id_9D0BAA9EE652F555) {
  doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(self.origin, 64, 75);

  if(isDefined(self.light)) {
    self.light setscriptablepartstate("bunkerdoor_light", "activated", 0);
    _id_F7B421481AB5AE7F(_id_9D0BAA9EE652F555._id_B947C76FCEF1AFDB);
  }

  foreach(door in doors)
  door setscriptablepartstate("door", "closed");

  wait 0.5;

  foreach(door in doors)
  _id_57D3850A12CF1D8F::_id_FBBFE6F05EDA5EB1(door);
}

_id_2C4C65F02D528A95() {
  level endon("game_ended");
  wait 2;
  self setscriptablepartstate("radiation", "radiationEnable");
}

_id_3729D24DF7C929EA() {
  foreach(_id_08B6FBD0C52928B0 in self._id_53948F219984A4D9) {
    if(!self._id_5B557D68019B1895) {
      if(!isDefined(_id_08B6FBD0C52928B0.hint)) {
        continue;
      }
      if(!_id_08B6FBD0C52928B0.hint isusable())
        _id_08B6FBD0C52928B0.hint makeusable();

      _id_08B6FBD0C52928B0.hint._id_2EDE9F5D69830193 = 1;

      if(self.closed) {
        _id_08B6FBD0C52928B0._id_B40694FC388C2200 = -120;
        _id_08B6FBD0C52928B0._id_96E045575043919C = &"MP_BIOBUNKER/PUZZLE_DOOR_CAN_OPEN";
        _id_08B6FBD0C52928B0.hint setHintString(&"MP_BIOBUNKER/PUZZLE_DOOR_CAN_OPEN");
      } else {
        _id_08B6FBD0C52928B0._id_B40694FC388C2200 = 120;
        _id_08B6FBD0C52928B0._id_96E045575043919C = &"MP_BIOBUNKER/MANUAL_DOOR_SHOULD_CLOSE";
        _id_08B6FBD0C52928B0.hint setHintString(&"MP_BIOBUNKER/MANUAL_DOOR_SHOULD_CLOSE");
      }

      _id_08B6FBD0C52928B0.hint setCursorHint("HINT_BUTTON");
      _id_08B6FBD0C52928B0._id_D0DDF8B1760B6E2C setscriptablepartstate("crank_stem", "stem");
    } else {
      if(!isDefined(_id_08B6FBD0C52928B0.hint)) {
        continue;
      }
      if(!_id_08B6FBD0C52928B0.hint isusable())
        _id_08B6FBD0C52928B0.hint makeusable();

      _id_08B6FBD0C52928B0.hint._id_2EDE9F5D69830193 = 0;

      if(self.closed) {
        _id_08B6FBD0C52928B0._id_B40694FC388C2200 = -120;
        _id_08B6FBD0C52928B0._id_96E045575043919C = &"MP_BIOBUNKER/PUZZLE_DOOR_CAN_OPEN";
      } else {
        _id_08B6FBD0C52928B0._id_B40694FC388C2200 = 120;
        _id_08B6FBD0C52928B0._id_96E045575043919C = &"MP_BIOBUNKER/MANUAL_DOOR_SHOULD_CLOSE";
      }

      _id_08B6FBD0C52928B0.hint setHintString(&"MP_BIOBUNKER/DOOR_IN_OPERATING");
      _id_08B6FBD0C52928B0.hint setCursorHint("HINT_NOBUTTON");
    }

    _id_08B6FBD0C52928B0.hint sethintdisplayrange(128);
    _id_08B6FBD0C52928B0.hint sethintdisplayfov(65);
    _id_08B6FBD0C52928B0.hint setuserange(128);
    _id_08B6FBD0C52928B0.hint setusefov(65);
    _id_08B6FBD0C52928B0.hint sethintonobstruction("hide");
    _id_08B6FBD0C52928B0.hint setuseholdduration("duration_none");
  }
}

_id_44344A83843EA13D() {
  level endon("game_ended");

  while(!isDefined(level.br_pickups))
    waitframe();

  phase = strtok(self.targetname, "_");

  if(phase[2] == "2") {
    _id_17CA952DEDAD0B25 = "loot_key_biobunker_rad_a_worn_phase" + phase[2] + "_" + self.script_index;
    item = "loot_key_biobunker_rad_a_worn";
  } else {
    _id_17CA952DEDAD0B25 = "loot_key_biobunker_rad_b_worn_phase" + phase[2] + "_" + self.script_index;
    item = "loot_key_biobunker_rad_b_worn";
  }

  _id_701449195235BE31::_id_6CAE4397834E60C8(_id_17CA952DEDAD0B25, item, 1, 1);
}

_id_09AE2E428FD385EB() {
  level endon("game_ended");

  while(!isDefined(level.br_pickups))
    waitframe();

  _id_6889E17F7E992ED9 = scripts\engine\utility::getStruct("br_loot_cache_for_puzzle_" + self.script_index, "script_noteworthy");
  _id_0BDD432D40603573 = spawnscriptable("br_loot_cache", _id_6889E17F7E992ED9.origin, _id_6889E17F7E992ED9.angles);
  _id_0BDD432D40603573 setscriptablepartstate("body", "closed_usable");
}

_id_05FCD52E61B5250B(phaseindex, _id_1FC860A3DD042E43) {
  level endon("game_ended");
  _id_48814951E916AF89::_id_2FC80954FA70D153();
  _id_E8A7D7225E809BCD = "radiation_bomber_spawn_point_phase_" + phaseindex + "_" + _id_1FC860A3DD042E43;
  _id_C229D93C0BB4F8E8 = scripts\engine\utility::getStruct(_id_E8A7D7225E809BCD, "script_noteworthy");
  _id_A1078A4990D909C2 = _id_C229D93C0BB4F8E8.script_stealthgroup;
  _id_FB1DEF007972B25A = getclosestpointonnavmesh(_id_C229D93C0BB4F8E8.origin);
  team = "team_hundred_ninety_five";
  _id_B205D90302DA2F07 = _id_C229D93C0BB4F8E8._id_B205D90302DA2F07;
  bomber = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF("enemy_mp_bomber", _id_FB1DEF007972B25A, (0, 0, 0), "absolute", "reinforcements", "biolab", _id_A1078A4990D909C2, team, undefined, _id_B205D90302DA2F07, 0, undefined, 0, undefined);
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(bomber, "dropWeapon", 0);
}

_id_758B369EBF76352A() {
  level endon("game_ended");
  _id_48814951E916AF89::_id_2FC80954FA70D153();

  for(_id_AC0E594AC96AA3A8 = 2; _id_AC0E594AC96AA3A8 <= 3; _id_AC0E594AC96AA3A8++) {
    _id_E8A7D7225E809BCD = "radiation_firebug_spawn_set_" + _id_AC0E594AC96AA3A8;
    _id_34384161D0218520 = scripts\engine\utility::getStruct(_id_E8A7D7225E809BCD, "script_noteworthy");
    _id_B7015A0DBEFEBCE1 = scripts\engine\utility::getStructArray(_id_34384161D0218520.target, "targetname");

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_B7015A0DBEFEBCE1.size; _id_AC0E5C4AC96AAA41++) {
      _id_399106EE831A29C7 = "enemy_mp_firebug_tier" + _id_AC0E594AC96AA3A8 + "_aq";
      _id_A1078A4990D909C2 = _id_B7015A0DBEFEBCE1[_id_AC0E5C4AC96AAA41].script_stealthgroup;
      _id_FB1DEF007972B25A = getclosestpointonnavmesh(_id_B7015A0DBEFEBCE1[_id_AC0E5C4AC96AAA41].origin);
      team = "team_hundred_ninety_five";
      _id_B205D90302DA2F07 = _id_B7015A0DBEFEBCE1[_id_AC0E5C4AC96AAA41]._id_B205D90302DA2F07;
      _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(_id_399106EE831A29C7, _id_FB1DEF007972B25A, (0, 0, 0), "absolute", "reinforcements", "biolab", _id_A1078A4990D909C2, team, undefined, _id_B205D90302DA2F07, 0, undefined, 0, undefined);
    }
  }
}

_id_A2DBD8D9D4E7D794() {
  level endon("game_ended");
  _id_48814951E916AF89::_id_2FC80954FA70D153();
  _id_E8A7D7225E809BCD = "radiation_firebug_spawn_set_for_puzzle_" + self.script_index;
  _id_34384161D0218520 = scripts\engine\utility::getStruct(_id_E8A7D7225E809BCD, "script_noteworthy");
  _id_B7015A0DBEFEBCE1 = scripts\engine\utility::getStructArray(_id_34384161D0218520.target, "targetname");

  for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_B7015A0DBEFEBCE1.size; _id_AC0E5C4AC96AAA41++) {
    _id_399106EE831A29C7 = "enemy_mp_firebug_tier1_aq";
    _id_A1078A4990D909C2 = _id_B7015A0DBEFEBCE1[_id_AC0E5C4AC96AAA41].script_stealthgroup;
    _id_FB1DEF007972B25A = getclosestpointonnavmesh(_id_B7015A0DBEFEBCE1[_id_AC0E5C4AC96AAA41].origin);
    team = "team_hundred_ninety_five";
    _id_B205D90302DA2F07 = _id_B7015A0DBEFEBCE1[_id_AC0E5C4AC96AAA41]._id_B205D90302DA2F07;
    _id_C4730EF372573D1A = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(_id_399106EE831A29C7, _id_FB1DEF007972B25A, (0, 0, 0), "absolute", "reinforcements", "biolab", _id_A1078A4990D909C2, team, undefined, _id_B205D90302DA2F07, 0, undefined, 0, undefined);
    _id_C4730EF372573D1A._id_B582B10663B5B2A9 = 0;
    _id_C4730EF372573D1A._id_4517F4FED904680A = 1;
  }
}

_id_9A41406F250EF300(_id_6A5EC5B7B5E36B35) {
  level endon("game_ended");
  level waittill("matchStartTimer_done");
  _id_82ADE947F8992573 = [];

  foreach(phase in _id_6A5EC5B7B5E36B35) {
    doors = getEntArray(phase.target, "targetname");

    foreach(door in doors) {
      if(door.closed == 1)
        _id_82ADE947F8992573[_id_82ADE947F8992573.size] = door._id_F504CAB18E3E6D1E;
    }
  }

  _id_5A0D5C3B2FCE976A = 1;
  _id_38A622094FB0CCC5 = [];
  _id_5C9209849DF8769C = [];

  while(_id_5A0D5C3B2FCE976A) {
    agents = _func_7E3F22E620F3F71E("biobunker_radiation", "everybody");
    _id_5A0D5C3B2FCE976A = 0;

    foreach(agent in agents) {
      if(isagent(agent)) {
        if(isDefined(agent._id_4517F4FED904680A)) {
          continue;
        }
        if(isDefined(agent._id_8AA9EFE6383C1D5A)) {
          if(isDefined(_id_5C9209849DF8769C[agent._id_8AA9EFE6383C1D5A]))
            continue;
          else
            _id_5C9209849DF8769C[agent._id_8AA9EFE6383C1D5A] = 1;
        }

        foreach(volume in _id_82ADE947F8992573) {
          if(ispointinvolume(agent.origin, volume)) {
            agent _id_48814951E916AF89::_id_28B90EB2B591003F();
            break;
          }
        }

        continue;
      }

      if(isint(agent)) {
        if(isDefined(_id_38A622094FB0CCC5[agent])) {
          continue;
        }
        info = _id_371B4C2AB5861E62::_id_2B0E82156FA6075B(agent);

        if(!isDefined(info)) {
          _id_5A0D5C3B2FCE976A = 1;
          continue;
        }

        foreach(volume in _id_82ADE947F8992573) {
          if(ispointinvolume(info.origin, volume)) {
            _id_371B4C2AB5861E62::_id_4E065F1747AADD51(agent);
            break;
          }
        }

        _id_38A622094FB0CCC5[agent] = 1;
      }
    }

    waitframe();
  }
}

_id_FB4393CDED0867DC() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");

  while(!isDefined(level._id_B205D90302DA2F07["biobunker_radiation"]["players"]))
    waitframe();

  for(;;) {
    foreach(_id_08B6FBD0C52928B0 in level._id_D2D6A0D2FC3C0E38) {
      _id_95CC360F21D292D2 = sortbydistancecullbyradius(level._id_B205D90302DA2F07["biobunker_radiation"]["players"], _id_08B6FBD0C52928B0.origin, 144);

      if(_id_95CC360F21D292D2.size != 0) {
        if(_id_08B6FBD0C52928B0._id_B93BA4E9C5805F0A == 1) {
          continue;
        }
        hint = spawn("script_model", _id_08B6FBD0C52928B0.origin);
        _id_08B6FBD0C52928B0.hint = hint;
        _id_08B6FBD0C52928B0.door _id_3729D24DF7C929EA();
        _id_08B6FBD0C52928B0.hint.curorigin = hint.origin;
        _id_08B6FBD0C52928B0.hint.offset3d = (0, 0, 0);
        _id_08B6FBD0C52928B0.hint scripts\mp\gameobjects::requestid(1, 0, undefined, 1);
        objid = _id_08B6FBD0C52928B0.hint.objidnum;
        scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
        scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 15);
        scripts\mp\objidpoolmanager::update_objective_position(objid, _id_08B6FBD0C52928B0.hint.origin + (0, 0, 5));
        scripts\mp\objidpoolmanager::objective_pin_global(objid, 1);
        scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
        _id_08B6FBD0C52928B0._id_B93BA4E9C5805F0A = 1;
        _id_08B6FBD0C52928B0 thread _id_A2EAE745C89B1968();
        continue;
      }

      if(_id_08B6FBD0C52928B0._id_B93BA4E9C5805F0A == 1) {
        _id_08B6FBD0C52928B0.hint scripts\mp\gameobjects::releaseid();
        _id_08B6FBD0C52928B0.hint delete();
        _id_08B6FBD0C52928B0._id_B93BA4E9C5805F0A = 0;
      }
    }

    waitframe();
  }
}

_id_57D755E039C1429E() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");

  while(!isDefined(level._id_B205D90302DA2F07["biobunker_radiation"]["players"]))
    waitframe();

  buttons = getentitylessscriptablearray("scriptable_button", "script_noteworthy");
  _id_371163F111E28D69 = [];

  foreach(button in buttons) {
    if("bunkerdoor_buttont_broken_model" == button getscriptablepartstate("bunkerdoor_button_model")) {
      _id_371163F111E28D69[_id_371163F111E28D69.size] = button;
      button._id_B93BA4E9C5805F0A = 0;
    }
  }

  for(;;) {
    foreach(button in _id_371163F111E28D69) {
      _id_82823411C262C447 = sortbydistancecullbyradius(level._id_B205D90302DA2F07["biobunker_radiation"]["players"], button.origin, 80);

      if(_id_82823411C262C447.size != 0) {
        if(button._id_B93BA4E9C5805F0A == 1) {
          continue;
        }
        hint = spawn("script_model", button.origin);
        button.hint = hint;
        button.hint makeusable();
        button.hint setHintString(&"MP_BIOBUNKER/BUTTON_IS_BROKEN");
        button.hint setCursorHint("HINT_NOBUTTON");
        button.hint sethintdisplayrange(96);
        button.hint sethintdisplayfov(200);
        button.hint setuserange(96);
        button.hint setusefov(200);
        button.hint sethintonobstruction("show");
        button._id_B93BA4E9C5805F0A = 1;
        continue;
      }

      if(button._id_B93BA4E9C5805F0A == 1) {
        button.hint delete();
        button._id_B93BA4E9C5805F0A = 0;
      }
    }

    waitframe();
  }
}

_id_DB75C5128A7CC0CE(_id_AC0E594AC96AA3A8) {
  self._id_B947C76FCEF1AFDB = self.origin;

  switch (_id_AC0E594AC96AA3A8) {
    case 1:
      self._id_B947C76FCEF1AFDB = (-15793, 12206, 1900);
      break;
    case 2:
      self._id_B947C76FCEF1AFDB = (-17256, 10772, 1900);
      break;
    case 3:
      self._id_B947C76FCEF1AFDB = (-14230, 9920, 1900);
      break;
  }
}

_id_3CA970C05C7F4FA7() {
  level endon("game_ended");
  self endon("inUse");
  _id_D3A31916B63429B6 = 0;

  for(;;) {
    if(self.door.closed)
      _id_134A0738A7A1A6F8 = -3;
    else
      _id_134A0738A7A1A6F8 = 3;

    self._id_51F127F126DB4B5D rotatepitch(-0.1 * _id_134A0738A7A1A6F8, 0.05);
    self._id_51F127F126DB4B5D.angles = self._id_51F127F126DB4B5D.angles - (_id_134A0738A7A1A6F8, 0, 0);
    self.progress = self.progress - level.framedurationseconds;
    self._id_D32CCBD5A44D790D = self._id_D32CCBD5A44D790D - _id_134A0738A7A1A6F8;

    if(self.door.closed) {
      if(self._id_D32CCBD5A44D790D >= 0) {
        self._id_D32CCBD5A44D790D = 0;
        self.progress = 0;
        break;
      }
    } else if(self._id_D32CCBD5A44D790D <= 0) {
      self._id_D32CCBD5A44D790D = 0;
      self.progress = 0;
      break;
    }

    if(gettime() - _id_D3A31916B63429B6 > 2000) {
      self._id_51F127F126DB4B5D playSound("dmz_biobunker_valve_rollback_sfx", undefined, self._id_51F127F126DB4B5D);
      _id_D3A31916B63429B6 = gettime();
    }

    waitframe();
  }
}

_id_109E2D99642BC7E1(_id_3EBCD4F86196FB73) {
  if(isDefined(self)) {
    _id_44F64AD2ED3208B4 = scripts\engine\utility::ter_op(_id_3EBCD4F86196FB73, "dmz_biobunker_radiation_vault_valve_open", "dmz_biobunker_radiation_vault_valve_shut");
    self playSound(_id_44F64AD2ED3208B4, undefined, self);
  }
}

_id_F63E6414BF88700F(_id_3EBCD4F86196FB73) {
  if(isDefined(self)) {
    _id_F427FF4B3A046ADC = scripts\engine\utility::ter_op(_id_3EBCD4F86196FB73, "dmz_biobunker_radiation_vault_door_open", "dmz_biobunker_radiation_vault_door_shut");
    _id_88E114FBE86CE809 = _id_81FE6DE9B56F9FF3(self);

    if(isDefined(_id_88E114FBE86CE809)) {
      _id_88E114FBE86CE809 playsoundonmovingent(_id_F427FF4B3A046ADC);
      thread _id_01AF7498A343BE2B(_id_88E114FBE86CE809);
    }
  }
}

_id_81FE6DE9B56F9FF3(door) {
  if(!isDefined(door._id_88E114FBE86CE809)) {
    tagorigin = door gettagorigin("door_joint");
    door._id_88E114FBE86CE809 = spawn("script_model", tagorigin);
    door._id_88E114FBE86CE809 linkTo(door, "door_joint", (0, 50, 0), (0, 0, 0));
    door._id_88E114FBE86CE809._id_80B40F48959D0FA1 = 0;
    waitframe();
  } else if(isDefined(door._id_88E114FBE86CE809) && !door._id_88E114FBE86CE809._id_80B40F48959D0FA1)
    door._id_88E114FBE86CE809 notify("recycleThisDoorEnt");

  return door._id_88E114FBE86CE809;
}

_id_01AF7498A343BE2B(ent) {
  ent endon("recycleThisDoorEnt");
  ent._id_80B40F48959D0FA1 = 1;
  wait 10;

  if(isDefined(ent))
    ent delete();
}

_id_DADC44AFAEED4729(_id_05CE5B54E58D14C5) {
  if(isDefined(self)) {
    _id_A3FBD259820EAABC = "dmz_biobunker_valve_rollback_sfx";
    self playSound(_id_A3FBD259820EAABC, undefined, self);
  }
}

_id_7E4457DA8D15B89F(position) {
  if(isDefined(position))
    playsoundatpos(position, "dmz_biobunker_radiation_clear");
}

_id_F7B421481AB5AE7F(position) {
  if(isDefined(position))
    playsoundatpos(position, "dmz_biobunker_radiation_spread");
}

_id_5F852D5D8F5DA831(button) {
  playsoundatpos(button.origin + (0, 0, 15), "emt_bunk_red_button_press");
}

_id_F9BD789D03D77733(_id_05CE5B54E58D14C5) {
  _id_05CE5B54E58D14C5 stopsounds();
}

_id_E2149470B69CD521(door) {
  door stopsounds();
}