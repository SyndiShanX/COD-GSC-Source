/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_372d8c5f69b0ae2e.gsc
***********************************************/

main() {
  if(getdvarint("scr_debug_scripted_melee"))
    iprintlnbold("SCRIPTED MELEE ACTIVE!");

  if(istrue(level._id_74A171505D979CBC.enabled)) {
    return;
  }
  level._id_74A171505D979CBC.enabled = 1;
  level._id_74A171505D979CBC._id_950DA684EAE1C18A = ::main;
  level._id_74A171505D979CBC._id_A7013F4BC7F81AFF = ::_id_C4DC31621D524849;
  setdvarifuninitialized("dvar_AF4553A66846825B", 1);
  setsaveddvar("scripted_melee_range", 100);
  setsaveddvar("scripted_melee_width", 640);
  setsaveddvar("scripted_melee_height", 384);

  if(!isDefined(level._id_74A171505D979CBC._id_7BC18D5686145F5F) || !level._id_74A171505D979CBC._id_7BC18D5686145F5F)
    precache();

  if(!scripts\common\utility::issp()) {
    while(level.players.size < 1)
      waitframe();
  }

  foreach(player in level.players)
  player thread _id_2F2FCB2D8AFAFF5E();
}

precache() {
  level._id_74A171505D979CBC._id_DC0788366A9ACB40 = "tag_player";
  level._effect["vfx_scriptedmelee_stab"] = loadfx("vfx/iw8/weap/_knife/vfx_contextmele_neckstab_med_ch2.vfx");
  level._effect["vfx_wnd_throat_stab"] = loadfx("vfx/iw9/level/wounded/vfx_wnd_throat_stab");
  level._effect["vfx_vm_sp_undershoulder_stab"] = loadfx("vfx/iw9/level/wounded/vfx_vm_sp_undershoulder_stab");
  level._effect["vfx_vm_sp_throat_stab"] = loadfx("vfx/iw9/level/wounded/vfx_vm_sp_throat_stab");
  level._effect["vfx_vm_sp_chest_stab_01"] = loadfx("vfx/iw9/level/wounded/vfx_vm_sp_chest_stab_01");
  level._effect["vfx_vm_sp_chest_stab_ri_01"] = loadfx("vfx/iw9/level/wounded/vfx_vm_sp_chest_stab_ri_01");
  level._effect["vfx_vm_sp_stab_neck_back_ri_01"] = loadfx("vfx/iw9/level/wounded/vfx_vm_sp_stab_neck_back_ri_01");

  if(scripts\common\utility::issp()) {
    scripts\engine\sp\utility::add_hint_string("scripted_melee_takedown", &"SCRIPTED_MELEE/TAKEDOWN", ::_id_0EC9009FA379356C, 2);
    level.player._id_B16E3EC6B657E398 = 0;
  }

  precachemodel("axis_guide_simple");
  precachemodel("att_vm_p33_me_tac_knife01_v0");
  [[level._id_74A171505D979CBC._id_1FC4FD3EF975E8C8]]();
  level._id_74A171505D979CBC._id_7BC18D5686145F5F = 1;
}

_id_0EC9009FA379356C() {
  if(!getdvarint("dvar_AF4553A66846825B")) {
    level.player._id_B16E3EC6B657E398 = 0;
    return 1;
  }

  if(!level.player isscriptedmeleeactive()) {
    level.player._id_B16E3EC6B657E398 = 0;
    return 1;
  }

  if(!level.player _meth_BAC81C2C3A5BEBE0()) {
    level.player._id_B16E3EC6B657E398 = 0;
    return 1;
  }

  return 0;
}

_id_2F2FCB2D8AFAFF5E() {
  level notify("scripted_melee_stop");
  level endon("scripted_melee_stop");

  if(!isDefined(self._id_7E7071F7B9501085))
    self[[level._id_74A171505D979CBC._id_02EC260CA66F2378]]();

  self._id_7E7071F7B9501085 notsolid();
  self._id_7E7071F7B9501085 hide();
  self notifyonplayercommand("player_scripted_melee", "+melee_zoom");
  thread _id_47A1953E498454B4();
  thread _id_4122323699A9DE19();
  debug_print("scripted_melee enabled: " + gettime());
}

_id_C4DC31621D524849() {
  level notify("scripted_melee_stop");
  level._id_74A171505D979CBC.enabled = 0;
  scripted_melee_active(0);
  debug_print("scripted_melee disabled: " + gettime());
}

scripted_melee_active(_id_E3108E412AFB3811) {
  if(_id_E3108E412AFB3811) {
    if(!self isscriptedmeleeactive()) {
      debug_print("scripted melee code active " + gettime());
      self setscriptedmeleeactive(_id_E3108E412AFB3811);
    }

    if(scripts\common\utility::issp()) {
      if(self _meth_BAC81C2C3A5BEBE0() && !self._id_B16E3EC6B657E398) {
        thread scripts\engine\sp\utility::display_hint_forced("scripted_melee_takedown");
        self._id_B16E3EC6B657E398 = 1;
      }
    }
  } else {
    self _meth_DBF8692A4C239DCF();
    self._id_B16E3EC6B657E398 = 0;

    if(self isscriptedmeleeactive()) {
      debug_print("scripted melee code INactive " + gettime());
      self setscriptedmeleeactive(_id_E3108E412AFB3811);
    }
  }
}

_id_5ED0667FAA731A14() {
  level endon("scripted_melee_stop");
  self notifyonplayercommand("player_scripted_melee", "+melee_zoom");

  for(;;) {
    count = 0;
    self waittill("player_scripted_melee");
    scripted_melee_active(1);

    for(;;) {
      if(self meleeButtonPressed())
        count = count + 1;

      if(count == 12) {
        self notify("player_scripted_melee_hold");
        break;
      }

      waitframe();
    }
  }
}

_id_47A1953E498454B4() {
  thread _id_F31EEF930EE6169F();
  level endon("scripted_melee_stop");

  for(;;) {
    if(istrue(self.in_melee_death) || !_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("melee") || isDefined(self.hasriotshieldequipped) && self.hasriotshieldequipped)
      scripted_melee_active(0);
    else {
      self._id_A13EDA80C7C29501 = undefined;
      self._id_EAB23F9EEB595C1E = undefined;
      _id_5A3E4E5298C7D61F = undefined;
      self._id_A13EDA80C7C29501 = _id_631805963060A8E4();

      if(isDefined(self._id_A13EDA80C7C29501)) {
        self._id_EAB23F9EEB595C1E = _id_77967A9EF882F668(self._id_A13EDA80C7C29501);

        if(isDefined(self._id_EAB23F9EEB595C1E))
          _id_5A3E4E5298C7D61F = _id_56E9E1D5FDD332D8(self._id_A13EDA80C7C29501, self._id_EAB23F9EEB595C1E);

        if(isDefined(_id_5A3E4E5298C7D61F)) {
          if(scripts\common\utility::issp())
            self _meth_7739EDA9DBAC25AC(self._id_A13EDA80C7C29501, undefined, undefined, _id_5A3E4E5298C7D61F);
          else
            self _meth_7739EDA9DBAC25AC(self._id_A13EDA80C7C29501, (0, 0, 1), (0, 0, 1), _id_5A3E4E5298C7D61F);

          scripted_melee_active(1);
        } else
          scripted_melee_active(0);
      } else
        scripted_melee_active(0);
    }

    waitframe();
  }
}

_id_F31EEF930EE6169F() {
  player = self;

  for(;;) {
    player waittill("weapon_change", weapon);

    if(isDefined(weapon) && isDefined(weapon.type) && weapon.type == "riotshield") {
      player.hasriotshieldequipped = 1;
      continue;
    }

    player.hasriotshieldequipped = 0;
  }
}

_id_631805963060A8E4() {
  level endon("scripted_melee_stop");
  self[[level._id_74A171505D979CBC._id_EFAA5D51E08521EB]]();
  victim = self getscriptedmeleetarget();

  if(!isDefined(victim) || !_id_C0B5A507E4D35634(self, victim))
    return undefined;

  return victim;
}

_id_56E9E1D5FDD332D8(victim, direction) {
  _id_C5C849D37BD876B6 = undefined;
  _id_0004DA2FA57DBC26 = undefined;

  for(;;) {
    if(isDefined(victim._id_F145D382DCA7F7EE) && scripts\engine\utility::array_contains(victim._id_F145D382DCA7F7EE, direction) && (isDefined(victim._id_74A171505D979CBC) && isDefined(victim._id_74A171505D979CBC._id_5E0A4F882198A116[direction]) || isDefined(level._id_74A171505D979CBC._id_5E0A4F882198A116[direction])) && !isDefined(_id_0004DA2FA57DBC26)) {
      if(isDefined(victim._id_74A171505D979CBC._id_5E0A4F882198A116[direction]))
        array = victim._id_74A171505D979CBC._id_5E0A4F882198A116[direction];
      else
        array = level._id_74A171505D979CBC._id_5E0A4F882198A116[direction];

      if(array.size == 1) {
        if(_id_7EF5BFCBB7A7D366(array[0]["rules"], victim)) {
          break;
        }

        debug_print3d(victim.origin, "Skipping override direction, " + direction + ". " + array[0]["animScene"] + " doesn't pass the rules!", (1, 0, 0), 1, 0.1, 1, "line2");
        _id_0004DA2FA57DBC26 = 1;
        continue;
      }

      break;
    } else if(isDefined(level._id_F145D382DCA7F7EE) && scripts\engine\utility::array_contains(level._id_F145D382DCA7F7EE, direction) && isDefined(level._id_74A171505D979CBC._id_5E0A4F882198A116[direction]) && !isDefined(_id_C5C849D37BD876B6)) {
      array = level._id_74A171505D979CBC._id_5E0A4F882198A116[direction];

      if(array.size == 1) {
        if(_id_7EF5BFCBB7A7D366(array[0]["rules"], victim)) {
          break;
        }

        debug_print3d(victim.origin, "Skipping override direction, " + direction + ". " + array[0]["animScene"] + " doesn't pass the rules!", (1, 0, 0), 1, 0.1, 1, "line2");
        _id_C5C849D37BD876B6 = 1;
        continue;
      }

      break;
    } else {
      if(!isDefined(level._id_74A171505D979CBC.anims[direction]))
        return undefined;

      array = level._id_74A171505D979CBC.anims[direction];
      break;
    }
  }

  _id_5ABF35EBA9E29A41 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    if(_id_7EF5BFCBB7A7D366(array[_id_AC0E594AC96AA3A8]["rules"], victim))
      _id_5ABF35EBA9E29A41 = scripts\engine\utility::array_add(_id_5ABF35EBA9E29A41, array[_id_AC0E594AC96AA3A8]["animScene"]);
  }

  if(_id_5ABF35EBA9E29A41.size > 0) {
    _id_FABF3A6FDD01A7B2 = [0];

    foreach(_id_AC0E594AC96AA3A8, _id_56E57B64F9AC67C4 in _id_5ABF35EBA9E29A41) {
      _id_FABF3A6FDD01A7B2[_id_AC0E594AC96AA3A8] = spawnStruct();
      _id_FABF3A6FDD01A7B2[_id_AC0E594AC96AA3A8].animation = scripts\engine\utility::getanim_from_animname(_id_56E57B64F9AC67C4, "scripted_melee_player_rig");
      _id_FABF3A6FDD01A7B2[_id_AC0E594AC96AA3A8]._id_83E122372160D16A = _id_56E57B64F9AC67C4;
      _id_FABF3A6FDD01A7B2[_id_AC0E594AC96AA3A8]._id_0B9BCC917D46972B = 0.35;
    }

    if(_id_FABF3A6FDD01A7B2.size > 4) {
      debug_print("Array too large, reducing!Size: " + _id_FABF3A6FDD01A7B2.size);
      _id_FABF3A6FDD01A7B2 = scripts\engine\utility::array_slice(_id_FABF3A6FDD01A7B2, 0, 4);
    }

    return _id_FABF3A6FDD01A7B2;
  }

  debug_print3d(victim.origin, "NO animScene FOUND!", (1, 0, 0), 1, 0.1, 1, "line2");
  return undefined;
}

_id_77967A9EF882F668(victim) {
  level endon("scripted_melee_stop");
  _id_F58A124E0F0556E7 = victim gettagorigin("tag_origin", 1);
  _id_A43B0202C06E0907 = victim gettagangles("tag_origin", 1);

  if(!isDefined(_id_F58A124E0F0556E7) || !isDefined(_id_A43B0202C06E0907))
    return undefined;

  _id_2A49AD1CAE501CE3 = anglestoright(_id_A43B0202C06E0907);
  _id_B4E1754D236C2278 = anglesToForward(_id_A43B0202C06E0907);
  _id_2353CA8656F77E04 = self.origin - _id_F58A124E0F0556E7;
  _id_2353CA8656F77E04 = (_id_2353CA8656F77E04[0], _id_2353CA8656F77E04[1], 0);
  _id_2353CA8656F77E04 = vectorNormalize(_id_2353CA8656F77E04);
  _id_EFC688FB667EF281 = abs(vectordot(_id_B4E1754D236C2278, (0, 0, 1)));

  if(_id_EFC688FB667EF281 > 0.7)
    _id_B4E1754D236C2278 = vectorNormalize((_id_2A49AD1CAE501CE3[0], _id_2A49AD1CAE501CE3[1], 0));
  else
    _id_B4E1754D236C2278 = vectorNormalize((_id_B4E1754D236C2278[0], _id_B4E1754D236C2278[1], 0));

  _id_9780F353E61A7BA3 = anglesToForward(victim.angles);

  if(vectordot(_id_2353CA8656F77E04, _id_9780F353E61A7BA3) > vectordot(_id_B4E1754D236C2278, _id_9780F353E61A7BA3))
    _id_B4E1754D236C2278 = _id_9780F353E61A7BA3;

  _id_2A49AD1CAE501CE3 = vectorcross(_id_B4E1754D236C2278, (0, 0, 1));
  dot = vectordot(_id_B4E1754D236C2278, _id_2353CA8656F77E04);
  _id_ED451F0EA36C48C6 = vectordot(_id_2A49AD1CAE501CE3, _id_2353CA8656F77E04);

  if(isDefined(victim._id_D7167E2D68AE05A3))
    _id_E5228E274C9DB3CE = victim._id_D7167E2D68AE05A3;
  else
    _id_E5228E274C9DB3CE = -0.5;

  if(dot < _id_E5228E274C9DB3CE) {
    if(isalive(victim))
      debug_print3d(victim.origin, "direction: back dot: " + dot + " threat: " + victim getthreatsight(self), (0, 1, 0), 1, 0.1, 1, "line1");

    return "back";
  } else if(dot > 0.6) {
    if(isalive(victim))
      debug_print3d(victim.origin, "direction: front dot: " + dot + " threat: " + victim getthreatsight(self), (0, 1, 0), 1, 0.1, 1, "line1");

    return "front";
  } else if(_id_ED451F0EA36C48C6 > 0) {
    if(isalive(victim))
      debug_print3d(victim.origin, "direction: right dot: " + dot + " threat: " + victim getthreatsight(self), (0, 1, 0), 1, 0.1, 1, "line1");

    return "right";
  } else {
    if(isalive(victim))
      debug_print3d(victim.origin, "direction: left dot: " + dot + " threat: " + victim getthreatsight(self), (0, 1, 0), 1, 0.1, 1, "line1");

    return "left";
  }

  return undefined;
}

_id_4122323699A9DE19() {
  level endon("scripted_melee_stop");

  for(;;) {
    self waittill("animscripted_predicted_entry", victim, _id_7BB9E2E4FFD90FDA, _id_5B88FD6CC81411A4, _id_51E0B68E2CD1EDE6, origin_offset, angles_offset, _id_56E57B64F9AC67C4);

    if(self isuseinprogress()) {
      continue;
    }
    victim thread _id_497214B31D3BC138(self, _id_56E57B64F9AC67C4);
    scripts\common\utility::_id_6D2D330FC885914C();
  }
}

_id_44FE9739A4D6D1DB(attacker) {
  if(!isDefined(level.stealth)) {
    return;
  }
  _id_601D79340374BC27 = level.stealth.damage_auto_range;
  _id_576F233D91CC27FF = level.stealth.damage_sight_range;

  if(isDefined(self.stealth) && isDefined(self.stealth.override_damage_auto_range))
    _id_601D79340374BC27 = self.stealth.override_damage_auto_range;
  else if(isDefined(level.stealth.override_damage_auto_range))
    _id_601D79340374BC27 = level.stealth.override_damage_auto_range;

  if(isDefined(self.stealth) && isDefined(self.stealth.override_damage_sight_range))
    _id_576F233D91CC27FF = self.stealth.override_damage_sight_range;
  else if(isDefined(level.stealth.override_damage_sight_range))
    _id_576F233D91CC27FF = level.stealth.override_damage_sight_range;

  if(isDefined(_id_601D79340374BC27) && isDefined(_id_576F233D91CC27FF))
    _func_AAD7A0EA8AC4CA23("combat", self, attacker, _id_601D79340374BC27, _id_576F233D91CC27FF, "scripted_melee");
}

_id_497214B31D3BC138(attacker, _id_56E57B64F9AC67C4) {
  self notify("scripted_melee_start");

  if(!scripts\common\utility::issp()) {
    self kill();
    return;
  }

  self._id_540E3C006CE71D3A = attacker;

  if(isDefined(self.stealth) && !istrue(self.keepstealthoncontextmelee))
    scripts\engine\utility::ent_flag_clear("stealth_enabled");

  self notify("end_patrol");
  self _meth_EA63241A4D3092C4();

  if(isDefined(level._id_A5407B03B3E5F39F) && isDefined(self findoverridearchetype("animscript"))) {
    self[[level._id_A5407B03B3E5F39F._id_55050A7CEBE72181]]();
    waittillframeend;
  }

  _id_2FE1D1A5E6E2B591 = _id_2FE1D1A5E6E2B591(_id_56E57B64F9AC67C4, self);
  _id_A30FF6D320CC665E = scripts\engine\utility::spawn_tag_origin();

  if(!istrue(_id_2FE1D1A5E6E2B591))
    _id_A30FF6D320CC665E scripts\common\anim::_id_5CFFE82F5E70231B(1);

  level._id_74A171505D979CBC._id_A30FF6D320CC665E = _id_A30FF6D320CC665E;
  parent = self getlinkedparent();

  if(isDefined(attacker._id_E3E345B123304389))
    parent = attacker._id_E3E345B123304389;

  anim_stopanimScripted();
  set_scripted_node_angles(attacker, _id_A30FF6D320CC665E);
  _id_A30FF6D320CC665E thread _id_9BB1020C719E33B6();
  _id_A30FF6D320CC665E _id_EBF301224750C8B8((0, 1, 1), 1000, 10);
  debug_print3d(self.origin, "victim melee pos: " + attacker._id_EAB23F9EEB595C1E, (0, 1, 1), 1, 0.1, 1000);
  debug_line(attacker.origin, self.origin, (0, 1, 1), 1, 0, 1000);
  _id_AD531C0E89EB4A3D(self.origin, 16, (0, 1, 1), 1, 1, 1000);
  debug_print("^1Scripted Melee Kill from direction: " + attacker._id_EAB23F9EEB595C1E);
  attacker.in_melee_death = 1;
  self._id_678F0DD40099AE4D = self.maxsightdistsqrd;
  self._id_EFAC77944F03C86D = self.newenemyreactiondistsq;
  self._id_CF5F0EA142F70AA7 = self.battlechatterallowed;
  self._id_52C3B2D2140576D1 = self.allowdeath;
  self._id_57CC235F96B8EB06 = self.animname;
  self.in_melee_death = 1;
  self.allowantigrav = 0;
  self.dontmelee = 1;
  self.maxsightdistsqrd = 1;
  self.fixednode = 0;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.newenemyreactiondistsq = 0;
  self.allowdeath = 0;
  self.a.disablepain = 1;
  self.allowpain = 0;
  self.battlechatterallowed = 0;
  self.animname = "generic";
  self.remove_from_animloop = 1;
  _id_FB8F407964E90B58 = _id_C52BBCAF5686CFE1(_id_56E57B64F9AC67C4, self);
  _id_B728A0A492AFF957 = _id_9A787E5F1371B0CC(_id_56E57B64F9AC67C4, self);
  _id_587D102C235C401A = _id_9232CBCAAF33D60F(_id_56E57B64F9AC67C4, self);

  if(isDefined(self.script_stealthgroup) && !_id_FB8F407964E90B58)
    scripts\stealth\group::group_removefrompod(self);

  if(isDefined(self) && isalive(self) && !isDefined(self.delayeddeath) && !self._id_A97AC004F00C5DF9)
    thread scripts\common\ai::magic_bullet_shield();

  if(isDefined(self) || isalive(self)) {
    attacker[[level._id_74A171505D979CBC._id_03522908002CC5AF]]();
    _id_A30FF6D320CC665E scripts\common\anim::anim_first_frame_solo(attacker._id_7E7071F7B9501085, _id_56E57B64F9AC67C4);
    waitframe();
    _id_122D342799919CAF = _id_B9063E2BAEB9F696(_id_56E57B64F9AC67C4, self);
    _id_144130378B339AB7 = spawn("script_model", attacker.origin);

    if(isDefined(attacker._id_2CD5923C5934A055))
      _id_144130378B339AB7 setModel(attacker._id_2CD5923C5934A055);
    else if(istrue(_id_122D342799919CAF) && isDefined(attacker._id_EF760821473D9172)) {
      _id_144130378B339AB7 scripts\common\utility::make_weapon_model(attacker._id_EF760821473D9172.basename, attacker._id_EF760821473D9172.attachments);
      attacker._id_7E7071F7B9501085._id_EF760821473D9172 = _id_144130378B339AB7;
    } else
      _id_144130378B339AB7 setModel("att_vm_p33_me_tac_knife01_v0");

    _id_F5C48C59E172E0CB = _id_2D06346EAD46F1BC(_id_56E57B64F9AC67C4, self);
    _id_144130378B339AB7 notsolid();
    _id_144130378B339AB7 linkTo(attacker._id_7E7071F7B9501085, _id_F5C48C59E172E0CB, (0, 0, 0), (0, 0, 0));

    if(!_id_FB8F407964E90B58)
      scripts\engine\utility::delaythread(5, ::death_safety, self);

    self notify("scripted_melee_anim_started");
    attacker notify("scripted_melee_anim_started");
    attacker _id_1C96DB6D76C91865(self, _id_A30FF6D320CC665E, _id_56E57B64F9AC67C4, _id_B728A0A492AFF957);

    if(isDefined(parent)) {
      debug_print("scripted melee linking anim_ent to parent");
      _id_A30FF6D320CC665E linkTo(parent);
    }

    self linkTo(_id_A30FF6D320CC665E);
    attacker._id_7E7071F7B9501085 linkTo(_id_A30FF6D320CC665E);
    attacker lerpfovscalefactor(0, 0.25);
    _id_F4C85A3AF01B0120 = getanimlength(scripts\engine\utility::getanim(_id_56E57B64F9AC67C4));
    _id_4120F65E56B5E799 = getanimlength(attacker._id_7E7071F7B9501085 scripts\engine\utility::getanim(_id_56E57B64F9AC67C4));

    if(_id_F4C85A3AF01B0120 > _id_4120F65E56B5E799) {
      attacker thread notify_delay("scripted_melee_anim_ended_longest", _id_F4C85A3AF01B0120);
      level scripts\engine\utility::delaythread(_id_F4C85A3AF01B0120, ::_id_63F4A98A99979090, _id_A30FF6D320CC665E);
      scripts\engine\utility::delaythread(_id_F4C85A3AF01B0120 / 4, ::_id_44FE9739A4D6D1DB, attacker);
    } else {
      attacker thread notify_delay("scripted_melee_anim_ended_longest", _id_4120F65E56B5E799);
      level scripts\engine\utility::delaythread(_id_4120F65E56B5E799, ::_id_63F4A98A99979090, _id_A30FF6D320CC665E);
      scripts\engine\utility::delaythread(_id_4120F65E56B5E799 / 4, ::_id_44FE9739A4D6D1DB, attacker);
    }

    thread notify_delay("scripted_melee_anim_ended_victim", _id_F4C85A3AF01B0120);
    attacker thread notify_delay("scripted_melee_anim_ended", _id_4120F65E56B5E799);
    _id_AC6D99D19393F2D3 = 1;
    attacker scripts\engine\utility::delaycall(_id_4120F65E56B5E799 - _id_AC6D99D19393F2D3, ::lerpfovscalefactor, 1, _id_AC6D99D19393F2D3);
    self notify("damage", 0, attacker, undefined, undefined, "MOD_MELEE");
    thread _id_121362CF4A7EF895(parent, _id_FB8F407964E90B58);
    attacker thread _id_8CFF6477A8994CC0(_id_144130378B339AB7, _id_B728A0A492AFF957, _id_587D102C235C401A);
    _id_A30FF6D320CC665E thread scripts\common\anim::anim_single([self, attacker._id_7E7071F7B9501085], _id_56E57B64F9AC67C4);

    if(!istrue(_id_2FE1D1A5E6E2B591)) {
      attacker._id_7E7071F7B9501085 scripts\common\anim::_id_01CB661B457551A3(0);
      scripts\engine\utility::delaycall(0.05, ::_meth_5E69FA9CFA2546EC, 15, 18, 37, _id_01445E54B6C662C7(), [attacker, attacker._id_7E7071F7B9501085], 1);
      attacker._id_7E7071F7B9501085 scripts\engine\utility::delaycall(0.05, ::_meth_5E69FA9CFA2546EC, 15, 18, 37, _id_01445E54B6C662C7(), [attacker, self], 1);
    }
  }

  attacker waittill("scripted_melee_anim_ended_longest");
  debug_print("longest melee anim finished");
}

_id_121362CF4A7EF895(parent, _id_FB8F407964E90B58) {
  self endon("death");
  level endon("scripted_melee_stop");
  self waittill("scripted_melee_anim_ended_victim");

  if(!_id_FB8F407964E90B58) {
    [[level._id_74A171505D979CBC._id_0FBD8726770C4C39]](self);
    [[level._id_74A171505D979CBC._id_8A66FB76621B9C84]](self);
  } else {
    self.in_melee_death = 0;
    self.allowantigrav = 1;
    self.dontmelee = 0;
    self.maxsightdistsqrd = self._id_678F0DD40099AE4D;
    self.fixednode = 0;
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.newenemyreactiondistsq = self._id_EFAC77944F03C86D;
    self.a.disablepain = 0;
    self.allowpain = 1;
    self.battlechatterallowed = self._id_CF5F0EA142F70AA7;
    self.remove_from_animloop = undefined;
    self.allowdeath = self._id_52C3B2D2140576D1;
    self.animname = self._id_57CC235F96B8EB06;
    self._id_874F796E29AD7410 = gettime();
    self setgoalpos(self.origin);
    self clearpath();

    if(isDefined(parent))
      self linkTo(parent);
  }

  self notify("scripted_melee_anim_ended");
}

_id_8CFF6477A8994CC0(_id_144130378B339AB7, _id_B728A0A492AFF957, _id_587D102C235C401A) {
  self endon("death");
  self waittill("scripted_melee_anim_ended");
  _id_144130378B339AB7 delete();
  self._id_7E7071F7B9501085 hide();

  if(isDefined(self._id_7E7071F7B9501085._id_EF760821473D9172))
    self._id_7E7071F7B9501085._id_EF760821473D9172 = undefined;

  release_player_from_viewmodel_anim(_id_587D102C235C401A);
  self[[level._id_74A171505D979CBC._id_16A2AD3BCCC62BB5]]();
  self._id_7E7071F7B9501085 hide();
  self.in_melee_death = 0;
  self._id_7E7071F7B9501085 scripts\common\anim::_id_01CB661B457551A3(1, self, 0.35);
}

_id_7EF5BFCBB7A7D366(rules, victim) {
  foreach(_id_519135C527F56067 in rules) {
    if(![[_id_519135C527F56067]](self, victim))
      return 0;
  }

  return 1;
}

_id_E5433A928BC95CCA() {
  rules = [::_id_BA9CF1DCE2684E06, ::_id_F2042B6B16526371, ::_id_F9BE8D51B4D903A7, ::_id_8AFEADEA083EAB3B, ::_id_1905DF1811CA29EC, ::_id_1B73B9DDA428E8EC, ::_id_A99C9E98B8C36ED0, ::_id_D3C20C23028BA3EA, ::_id_7383BAAF0F1F2A19, ::_id_1213C4AF15671C7B, ::_id_3F33052FAF524462, ::_id_185B2E98556D16D7];
  return rules;
}

_id_0B767805CA0E381E() {
  rules = scripts\common\utility::_id_33BEA9FCD7E7D254([::_id_C592DF6EC4469C4C]);
  return rules;
}

_id_A3356321F4375B10() {
  rules = scripts\common\utility::_id_33BEA9FCD7E7D254([::_id_071A6EC3371D375D, ::_id_C592DF6EC4469C4C]);
  return rules;
}

_id_279A32B2CDCE2B2B() {
  rules = scripts\common\utility::_id_33BEA9FCD7E7D254([::_id_071A6EC3371D375D]);
  return rules;
}

_id_65931E2CBCA86748() {
  rules = scripts\common\utility::_id_33BEA9FCD7E7D254([::_id_652F03CE87E99355, ::_id_C592DF6EC4469C4C]);
  return rules;
}

_id_FA7CC1AD28B01833() {
  rules = scripts\common\utility::_id_33BEA9FCD7E7D254([::_id_652F03CE87E99355]);
  return rules;
}

_id_9D501E35F4127F85() {
  rules = scripts\common\utility::_id_33BEA9FCD7E7D254([::_id_5E854E2A4DA4F3FF]);
  return rules;
}

_id_7E355057C5E32C56() {
  rules = scripts\common\utility::_id_33BEA9FCD7E7D254([::_id_12BAF7C107264C30]);
  return rules;
}

_id_199C2718C1A3385F() {
  rules = scripts\common\utility::_id_33BEA9FCD7E7D254([::_id_0DC5BFB7CE71C284, ::_id_C592DF6EC4469C4C]);
  return rules;
}

_id_FDFBAA517A1C4018() {
  rules = scripts\common\utility::_id_33BEA9FCD7E7D254([::_id_0DC5BFB7CE71C284]);
  return rules;
}

_id_C0B5A507E4D35634(player, victim) {
  if(!isPlayer(victim))
    return 1;

  debug_print("rule_NotIsPlayer failed");
  return 0;
}

_id_BA9CF1DCE2684E06(player, victim) {
  if(!player ismeleeing())
    return 1;

  debug_print("rule_PlayerNotMeleeing failed");
  return 0;
}

_id_F2042B6B16526371(player, victim) {
  if(isalive(victim))
    return 1;

  debug_print("rule_IsAlive failed");
  return 0;
}

_id_1B73B9DDA428E8EC(player, victim) {
  if(!victim scripts\engine\utility::doinglongdeath())
    return 1;

  debug_print("rule_NotDoingLongDeath failed");
  return 0;
}

_id_F9BE8D51B4D903A7(player, victim) {
  if(isDefined(victim._id_1A479CAD9C3ADBB1) && !victim._id_1A479CAD9C3ADBB1) {
    debug_print("rule_CanScriptedMeleeVictim failed");
    return 0;
  }

  return 1;
}

_id_185B2E98556D16D7(player, victim) {
  _id_D6BEB1D081D9A959 = victim getlinkedparent();

  if(isDefined(_id_D6BEB1D081D9A959)) {
    if(_id_D6BEB1D081D9A959 scripts\common\vehicle::isvehicle())
      return 0;
  }

  return 1;
}

_id_8AFEADEA083EAB3B(player, victim) {
  if(!scripts\common\utility::issp())
    return 1;

  if(isDefined(victim.animtree) && victim.animtree == "generic_human")
    return 1;

  debug_print("rule_HasCorrectAnimtree failed");
  return 0;
}

_id_1905DF1811CA29EC(player, victim) {
  if(isDefined(victim.unittype)) {
    switch (victim.unittype) {
      case "juggernaut":
      case "suicidebomber":
      case "dog":
        debug_print("rule_IsValidUnitType failed");
        return 0;
    }
  }

  return 1;
}

_id_BB4D4E9EEF766C87(player, victim) {}

_id_76D0CDC4BD023D56(player, victim) {}

_id_5E854E2A4DA4F3FF(player, victim) {
  if(isDefined(victim.fnisinstealthcombat) && victim[[victim.fnisinstealthcombat]]())
    return 0;

  _id_3D4B09D94DF0885A = _func_910A912F327B8D34(player);

  if(_id_3D4B09D94DF0885A < 1)
    return 1;

  return 0;
}

_id_12BAF7C107264C30(player, victim) {
  debug_print("rule_IsNotStealth failed");
  return !_id_5E854E2A4DA4F3FF(player, victim);
}

_id_D3C20C23028BA3EA(player, victim) {
  weapons = player getweaponslistall();
  _id_048AA5D980E9B010 = ["rifle", "sniper", "mg", "smg", "spread", "pistol", "rocketlauncher"];
  _id_BE8DFB8F9BA78B96 = ["throwingknife"];

  foreach(weapon in weapons) {
    if(isDefined(weapon.classname) && scripts\engine\utility::array_contains(_id_048AA5D980E9B010, weapon.classname))
      return 1;
  }

  foreach(weapon in weapons) {
    if(isDefined(weapon.classname) && scripts\engine\utility::array_contains(_id_BE8DFB8F9BA78B96, weapon.classname)) {
      if(player getweaponammostock(weapon) > 0)
        return 1;
      else
        continue;
    }
  }

  return 0;
}

_id_071A6EC3371D375D(player, victim) {
  if(!isDefined(player))
    return 0;

  if(player getstance() == "stand")
    return 1;

  return 0;
}

_id_652F03CE87E99355(player, victim) {
  if(!isDefined(player))
    return 0;

  if(player getstance() == "crouch")
    return 1;

  return 0;
}

_id_0DC5BFB7CE71C284(player, victim) {
  player._id_EF760821473D9172 = undefined;

  if(!isDefined(player))
    return 0;

  weapons = player getweaponslistprimaries();

  if(!isDefined(weapons))
    return 0;

  foreach(weapon in weapons) {
    if(weapon.basename == "iw9_pi_golf17_sp" && _id_8205EEF398B56D03(weapon)) {
      player._id_EF760821473D9172 = weapon;
      return 1;
    }
  }

  debug_print("failed, player doesn't have iw9_pi_golf17_sp");
  return 0;
}

_id_8205EEF398B56D03(weapon) {
  _id_51DBE1A1C3D8BF04 = _func_6527364C1ECCA6C6(weapon.basename);
  _id_A90071FDF6C09431 = scripts\engine\utility::array_remove_array(weapon.attachments, _id_51DBE1A1C3D8BF04);

  foreach(attachment in _id_A90071FDF6C09431) {
    if(issubstr(attachment, "silen")) {
      debug_print("failed, pistol has silencer: " + attachment);
      return 0;
    } else if(issubstr(attachment, "comp")) {
      debug_print("failed, pistol has comp: " + attachment);
      return 0;
    } else if(issubstr(attachment, "flash")) {
      debug_print("failed, pistol has flash: " + attachment);
      return 0;
    } else if(issubstr(attachment, "stock")) {
      debug_print("failed, pistol has stock: " + attachment);
      return 0;
    } else if(issubstr(attachment, "bar")) {
      debug_print("failed, pistol has barrel: " + attachment);
      return 0;
    }
  }

  return 1;
}

_id_A99C9E98B8C36ED0(player, victim) {
  _id_4573A8725DD3748E = abs(victim.origin[2] - player.origin[2]);

  if(_id_4573A8725DD3748E >= 20)
    return 0;

  return 1;
}

_id_7383BAAF0F1F2A19(player, victim) {
  if(player getstance() != "prone")
    return 1;

  return 0;
}

_id_1213C4AF15671C7B(player, victim) {
  if(!istrue(victim._id_2C1A52B48212191B))
    return 1;

  return 0;
}

_id_3F33052FAF524462(player, victim) {
  if(!istrue(victim._id_A97AC004F00C5DF9))
    return 1;

  return 0;
}

_id_C592DF6EC4469C4C(player, victim) {
  if(!istrue(victim.bhasriotshieldattached))
    return 1;

  return 0;
}

_id_63F4A98A99979090(_id_A30FF6D320CC665E) {
  _id_A30FF6D320CC665E delete();
}

notify_delay(_id_89D1FFD39DF87556, _id_3447DD0CDCD69308) {
  self endon("death");

  if(_id_3447DD0CDCD69308 > 0)
    wait(_id_3447DD0CDCD69308);

  if(!isDefined(self)) {
    return;
  }
  self notify(_id_89D1FFD39DF87556);
}

anim_stopanimScripted() {
  self stopanimScripted();
  self notify("stop_loop");
  self notify("single anim", "end");
  self notify("looping anim", "end");
  self notify("stop_animmode");
}

set_scripted_node_angles(attacker, _id_A165F8AFFEA867AC) {
  switch (attacker._id_EAB23F9EEB595C1E) {
    case "front":
      _id_A165F8AFFEA867AC.angles = vectortoangles((attacker.origin[0], attacker.origin[1], 0) - (self.origin[0], self.origin[1], 0));
      break;
    case "left":
      _id_A165F8AFFEA867AC.angles = vectortoangles((attacker.origin[0], attacker.origin[1], 0) - (self.origin[0], self.origin[1], 0)) + (0, -90, 0);
      break;
    case "right":
      _id_A165F8AFFEA867AC.angles = vectortoangles((attacker.origin[0], attacker.origin[1], 0) - (self.origin[0], self.origin[1], 0)) + (0, 90, 0);
      break;
    case "back":
      _id_A165F8AFFEA867AC.angles = vectortoangles((self.origin[0], self.origin[1], 0) - (attacker.origin[0], attacker.origin[1], 0));
      break;
    default:
  }
}

death_safety(guy) {
  if(isDefined(guy)) {
    if(isalive(guy)) {
      if(isDefined(guy.magic_bullet_shield))
        guy scripts\common\ai::stop_magic_bullet_shield();
    }
  }
}

_id_D8F48AB0DFD5EF51(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(!isalive(guy)) {
    return;
  }
  guy.skipdeathanim = 1;
  guy pushplayer(0);

  if(isDefined(level._id_36C5A68428425D34) && isDefined(level._id_7B5D9E727929565F)) {
    if(guy[[level._id_36C5A68428425D34]]())
      guy[[level._id_7B5D9E727929565F]]();
  }

  guy _id_3433EE6B63C7E243::dropallaiweapons();

  if(isDefined(self._id_1BAB8712529EB3C2) && isDefined(self.fnstealthflashlightdetach) && self._id_1BAB8712529EB3C2)
    self[[self.fnstealthflashlightdetach]]();

  guy.allowdeath = 1;
  guy.diequietly = 1;
  guy._id_F543095C3CA1B743 = 1;

  if(isDefined(guy.magic_bullet_shield))
    guy scripts\common\ai::stop_magic_bullet_shield();

  if(isDefined(guy.damageshield))
    guy.damageshield = 0;

  if(isDefined(guy.stealth) && !istrue(level.stealth._id_8D8A17B5C4438254))
    guy.stealth.override_damage_auto_range = 60;

  debug_print("do death via note");
  guy kill((0, 0, 0), guy._id_540E3C006CE71D3A, guy._id_540E3C006CE71D3A, "MOD_MELEE");

  if(!istrue(guy._id_91C24157247EF2FC))
    guy._id_540E3C006CE71D3A._id_4187711225445340 = guy.origin;
}

_id_497A27B31D43D6AF(guy) {}

_id_EBEA6B350AF8FB8D(guy) {
  if(isDefined(level.player._id_EF760821473D9172) && isDefined(guy._id_EF760821473D9172)) {
    startpos = guy._id_EF760821473D9172 gettagorigin("tag_flash", 1);
    magicbullet(level.player._id_EF760821473D9172, startpos, startpos + anglesToForward(guy._id_EF760821473D9172.angles) * 12);
    debug_line(startpos, startpos + anglesToForward(guy._id_EF760821473D9172.angles) * 12, (1, 0, 0), 1, 0, 1000);
  }
}

release_player_from_viewmodel_anim(_id_587D102C235C401A) {
  self[[level._id_74A171505D979CBC.playerlinkeduselinkedvelocity]](0);
  self _meth_AF4B9B0F0E7C6C42(0.2);
  self freezecontrols(0);
  self freezelookcontrols(0);
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("scripted_melee");

  if(isDefined(_id_587D102C235C401A)) {
    if(_id_587D102C235C401A == "prone") {
      self setstance(_id_587D102C235C401A, 1, 1, 1);
      up = anglestoup(self.angles);
      _id_53FD9BCFE97F77D0 = scripts\engine\utility::drop_to_ground(self.origin + up * self getplayerviewheight(self._id_EF6BE8803BE11754), 0, -60, up);
      self setOrigin(_id_53FD9BCFE97F77D0, 1);
    } else
      self setstance(_id_587D102C235C401A);
  } else
    self setstance(self._id_EF6BE8803BE11754);

  if(isDefined(self._id_FC0B0E5BDDA97C8C))
    setsaveddvar("dvar_0863A2044D629615", self._id_FC0B0E5BDDA97C8C);
}

_id_1C96DB6D76C91865(victim, _id_A165F8AFFEA867AC, _id_56E57B64F9AC67C4, _id_B728A0A492AFF957) {
  prepare_player_for_viewmodel_anim(_id_B728A0A492AFF957);
  _id_D58D17E0A32CE60B = getstartangles(_id_A165F8AFFEA867AC.origin, _id_A165F8AFFEA867AC.angles, victim scripts\engine\utility::getanim(_id_56E57B64F9AC67C4));
  debug_line(victim.origin, victim.origin + anglesToForward(victim.angles) * 36, (0, 1, 0), 1, 0, 1000);
  debug_line(victim.origin, victim.origin + anglesToForward(_id_D58D17E0A32CE60B) * 36, (1, 0, 1), 1, 0, 1000);
  thread _id_EBF301224750C8B8((0, 1, 0), 1000, 10);
  debug_print3d(self.origin, "pre melee pos: " + gettime(), (0, 1, 0), 1, 0.1, 1000);
  debug_line(self.origin, self.origin + anglesToForward(self getplayerangles(1)) * 100, (0, 1, 0), 1, 0, 1000);
  _id_D775E14980E96400 = 0.35;
  _id_710129AC48BC62C4 = victim scripts\engine\utility::spawn_tag_origin();
  victim linktoblendtotag(_id_710129AC48BC62C4, "tag_origin");
  _id_710129AC48BC62C4 rotateTo(_id_D58D17E0A32CE60B, _id_D775E14980E96400, 0.1);
  self._id_7E7071F7B9501085 _meth_DB099ADC4053DA52(level._id_74A171505D979CBC._id_DC0788366A9ACB40, self.origin, self.angles);
  _id_2FE1D1A5E6E2B591 = _id_2FE1D1A5E6E2B591(_id_56E57B64F9AC67C4, victim);

  if(istrue(_id_2FE1D1A5E6E2B591))
    self playerlinktoblend(self._id_7E7071F7B9501085, level._id_74A171505D979CBC._id_DC0788366A9ACB40, 0.35, 0.15, 0.0, 1, 1);
  else
    self playerlinktoblend(self._id_7E7071F7B9501085, level._id_74A171505D979CBC._id_DC0788366A9ACB40, 0.35, 0.15, 0.0, 0, 1);

  self[[level._id_74A171505D979CBC.playerlinkeduselinkedvelocity]](1);
  _id_710129AC48BC62C4 delete();
  self._id_7E7071F7B9501085 show();
}

prepare_player_for_viewmodel_anim(_id_B728A0A492AFF957) {
  self._id_EF6BE8803BE11754 = self getstance();

  if(self _meth_E40102956C887F7C()) {
    self._id_FC0B0E5BDDA97C8C = getDvar("dvar_0863A2044D629615");
    setsaveddvar("dvar_0863A2044D629615", 40);
    stance = "crouch";
  } else {
    self._id_FC0B0E5BDDA97C8C = undefined;
    stance = "stand";

    if(isDefined(_id_B728A0A492AFF957))
      stance = _id_B728A0A492AFF957;
  }

  self setstance(stance, 0, 1, 1);
  thread freeze_controls_when_standing(stance);
  self freezelookcontrols(1);
  _id_3B64EB40368C1450::set("scripted_melee", "weapon", 0);
  _id_3B64EB40368C1450::set("scripted_melee", "melee", 0);
  _id_3B64EB40368C1450::set("scripted_melee", "prone", 0);
  _id_3B64EB40368C1450::set("scripted_melee", "crouch", 0);
}

freeze_controls_when_standing(stance) {
  self endon("death");
  level endon("scripted_melee_stop");

  while(self getstance() != stance)
    waitframe();

  self freezecontrols(1);
}

_id_01445E54B6C662C7() {
  contents = ["physicscontents_solid", "physicscontents_playerclip", "physicscontents_characterproxy", "physicscontents_glass"];
  return physics_createcontents(contents);
}

_id_C52BBCAF5686CFE1(_id_56E57B64F9AC67C4, victim) {
  if(isDefined(level._id_74A171505D979CBC._id_5E0A4F882198A116)) {
    foreach(key in getarraykeys(level._id_74A171505D979CBC._id_5E0A4F882198A116)) {
      array = level._id_74A171505D979CBC._id_5E0A4F882198A116[key];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
        if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
          return array[_id_AC0E594AC96AA3A8]["victimLives"];
      }
    }
  }

  if(isDefined(self._id_74A171505D979CBC) && isDefined(self._id_74A171505D979CBC._id_5E0A4F882198A116)) {
    foreach(key in getarraykeys(self._id_74A171505D979CBC._id_5E0A4F882198A116)) {
      array = self._id_74A171505D979CBC._id_5E0A4F882198A116[key];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
        if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
          return array[_id_AC0E594AC96AA3A8]["victimLives"];
      }
    }
  }

  foreach(key in getarraykeys(level._id_74A171505D979CBC.anims)) {
    array = level._id_74A171505D979CBC.anims[key];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
      if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
        return array[_id_AC0E594AC96AA3A8]["victimLives"];
    }
  }

  if(isDefined(victim) && isDefined(victim._id_74A171505D979CBC) && isDefined(victim._id_74A171505D979CBC._id_5E0A4F882198A116)) {
    foreach(key in getarraykeys(victim._id_74A171505D979CBC._id_5E0A4F882198A116)) {
      array = victim._id_74A171505D979CBC._id_5E0A4F882198A116[key];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
        if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
          return array[_id_AC0E594AC96AA3A8]["victimLives"];
      }
    }
  }

  return 0;
}

_id_9A787E5F1371B0CC(_id_56E57B64F9AC67C4, victim) {
  if(isDefined(level._id_74A171505D979CBC._id_5E0A4F882198A116)) {
    foreach(key in getarraykeys(level._id_74A171505D979CBC._id_5E0A4F882198A116)) {
      array = level._id_74A171505D979CBC._id_5E0A4F882198A116[key];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
        if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
          return array[_id_AC0E594AC96AA3A8]["startStance"];
      }
    }
  }

  foreach(key in getarraykeys(level._id_74A171505D979CBC.anims)) {
    array = level._id_74A171505D979CBC.anims[key];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
      if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
        return array[_id_AC0E594AC96AA3A8]["startStance"];
    }
  }

  if(isDefined(victim) && isDefined(victim._id_74A171505D979CBC) && isDefined(victim._id_74A171505D979CBC._id_5E0A4F882198A116)) {
    foreach(key in getarraykeys(victim._id_74A171505D979CBC._id_5E0A4F882198A116)) {
      array = victim._id_74A171505D979CBC._id_5E0A4F882198A116[key];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
        if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
          return array[_id_AC0E594AC96AA3A8]["startStance"];
      }
    }
  }

  return undefined;
}

_id_9232CBCAAF33D60F(_id_56E57B64F9AC67C4, victim) {
  if(isDefined(level._id_74A171505D979CBC._id_5E0A4F882198A116)) {
    foreach(key in getarraykeys(level._id_74A171505D979CBC._id_5E0A4F882198A116)) {
      array = level._id_74A171505D979CBC._id_5E0A4F882198A116[key];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
        if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
          return array[_id_AC0E594AC96AA3A8]["endStance"];
      }
    }
  }

  foreach(key in getarraykeys(level._id_74A171505D979CBC.anims)) {
    array = level._id_74A171505D979CBC.anims[key];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
      if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
        return array[_id_AC0E594AC96AA3A8]["endStance"];
    }
  }

  if(isDefined(victim) && isDefined(victim._id_74A171505D979CBC) && isDefined(victim._id_74A171505D979CBC._id_5E0A4F882198A116)) {
    foreach(key in getarraykeys(victim._id_74A171505D979CBC._id_5E0A4F882198A116)) {
      array = victim._id_74A171505D979CBC._id_5E0A4F882198A116[key];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
        if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
          return array[_id_AC0E594AC96AA3A8]["endStance"];
      }
    }
  }

  return undefined;
}

_id_B9063E2BAEB9F696(_id_56E57B64F9AC67C4, victim) {
  if(isDefined(level._id_74A171505D979CBC._id_5E0A4F882198A116)) {
    foreach(key in getarraykeys(level._id_74A171505D979CBC._id_5E0A4F882198A116)) {
      array = level._id_74A171505D979CBC._id_5E0A4F882198A116[key];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
        if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
          return array[_id_AC0E594AC96AA3A8]["usePistol"];
      }
    }
  }

  foreach(key in getarraykeys(level._id_74A171505D979CBC.anims)) {
    array = level._id_74A171505D979CBC.anims[key];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
      if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
        return array[_id_AC0E594AC96AA3A8]["usePistol"];
    }
  }

  if(isDefined(victim) && isDefined(victim._id_74A171505D979CBC) && isDefined(victim._id_74A171505D979CBC._id_5E0A4F882198A116)) {
    foreach(key in getarraykeys(victim._id_74A171505D979CBC._id_5E0A4F882198A116)) {
      array = victim._id_74A171505D979CBC._id_5E0A4F882198A116[key];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
        if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
          return array[_id_AC0E594AC96AA3A8]["usePistol"];
      }
    }
  }

  return undefined;
}

_id_2D06346EAD46F1BC(_id_56E57B64F9AC67C4, victim) {
  if(isDefined(level._id_74A171505D979CBC._id_5E0A4F882198A116)) {
    foreach(key in getarraykeys(level._id_74A171505D979CBC._id_5E0A4F882198A116)) {
      array = level._id_74A171505D979CBC._id_5E0A4F882198A116[key];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
        if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
          return array[_id_AC0E594AC96AA3A8]["boneOverride"];
      }
    }
  }

  foreach(key in getarraykeys(level._id_74A171505D979CBC.anims)) {
    array = level._id_74A171505D979CBC.anims[key];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
      if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
        return array[_id_AC0E594AC96AA3A8]["boneOverride"];
    }
  }

  if(isDefined(victim) && isDefined(victim._id_74A171505D979CBC) && isDefined(victim._id_74A171505D979CBC._id_5E0A4F882198A116)) {
    foreach(key in getarraykeys(victim._id_74A171505D979CBC._id_5E0A4F882198A116)) {
      array = victim._id_74A171505D979CBC._id_5E0A4F882198A116[key];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
        if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
          return array[_id_AC0E594AC96AA3A8]["boneOverride"];
      }
    }
  }

  return "TAG_ACCESSORY_RIGHT";
}

_id_2FE1D1A5E6E2B591(_id_56E57B64F9AC67C4, victim) {
  if(isDefined(level._id_74A171505D979CBC._id_5E0A4F882198A116)) {
    foreach(key in getarraykeys(level._id_74A171505D979CBC._id_5E0A4F882198A116)) {
      array = level._id_74A171505D979CBC._id_5E0A4F882198A116[key];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
        if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
          return array[_id_AC0E594AC96AA3A8]["marina_hack"];
      }
    }
  }

  foreach(key in getarraykeys(level._id_74A171505D979CBC.anims)) {
    array = level._id_74A171505D979CBC.anims[key];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
      if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
        return array[_id_AC0E594AC96AA3A8]["marina_hack"];
    }
  }

  if(isDefined(victim) && isDefined(victim._id_74A171505D979CBC) && isDefined(victim._id_74A171505D979CBC._id_5E0A4F882198A116)) {
    foreach(key in getarraykeys(victim._id_74A171505D979CBC._id_5E0A4F882198A116)) {
      array = victim._id_74A171505D979CBC._id_5E0A4F882198A116[key];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
        if(array[_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
          return array[_id_AC0E594AC96AA3A8]["marina_hack"];
      }
    }
  }

  return undefined;
}

_id_7EAECC1FBFD9AD25(player) {}

debug_line(start, end, color, alpha, _id_FFB74DFE2FDAD3BE, duration) {}

debug_print(text) {}

debug_print3d(origin, text, color, alpha, scale, duration, offset) {}

_id_AD531C0E89EB4A3D(center, radius, color, alpha, _id_FFB74DFE2FDAD3BE, duration) {}

_id_1FEFF56A97BE22BC(origin, radius, color, _id_FFB74DFE2FDAD3BE, duration) {}

_id_EBF301224750C8B8(color, duration, _id_A61C75B156FC1EE0) {}

_id_F780674CF786BDA2(start, end, color, duration) {}

_id_4E0638157C0B38D1() {}

_id_9BB1020C719E33B6() {}