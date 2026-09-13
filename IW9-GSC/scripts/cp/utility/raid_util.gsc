/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\raid_util.gsc
***********************************************/

_id_490993B77C6D2C41() {
  scripts\cp\utility\cp_controlled_callbacks::registercontrolledcallback("Earthquake", ::earthquake, 5, scripts\cp\utility::_id_97196D9C69A91E2B, 0, 0, 0, 1, 1);
  level._id_2F1EE97802511A62 = ::_id_8ADC1A61A9D810E7;
}

_id_8ADC1A61A9D810E7(winner, _id_1379934A423852EF) {
  result = "";

  switch (_id_1379934A423852EF) {
    case 1:
      result = "SUCCESS";
      break;
    case 4:
      result = "HOST QUIT";
      break;
    default:
      result = "FAIL";
      break;
  }

  if(_id_1379934A423852EF == 1)
    _id_467F0FDFDD155A45::_id_3167B5F4F0E8EB9E(1, result);

  _id_467F0FDFDD155A45::endgame(winner, _id_1379934A423852EF);
}

_id_050326CC21187D35(_id_92C4DE821390F609, hintstring, buttonmodel, duration) {
  struct = scripts\engine\utility::getStruct(_id_92C4DE821390F609, "script_noteworthy");
  return _id_683F024F53CEE760(struct, hintstring, buttonmodel, duration);
}

_id_683F024F53CEE760(struct, hintstring, buttonmodel, duration, usedist, hintdist, _id_45240FD27B5679F4, usefov) {
  button = spawn("script_model", struct.origin);
  button.angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
  button.script_noteworthy = struct.script_noteworthy;

  if(!isDefined(_id_45240FD27B5679F4))
    _id_45240FD27B5679F4 = "hide";

  if(!isDefined(usedist))
    usedist = 64;

  if(!isDefined(hintdist))
    hintdist = 256;

  if(!isDefined(duration))
    duration = "duration_short";

  if(!isDefined(usefov))
    usefov = 65;

  if(isDefined(buttonmodel))
    button setModel(buttonmodel);
  else
    button setModel("button_on");

  button scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, hintstring, 25, duration, _id_45240FD27B5679F4, hintdist, 65, usedist, usefov);
  button _meth_DFB78B3E724AD620(1);
  return button;
}

_id_DC1F6851FDA93BEC(_id_497A14A8727744F4, _id_D1E50A639DFB62A0, _id_C32E62905819941C, _id_6B3429E420584763, _id_C3BF2A3EBA5CF2DD, _id_35B822F718D22CC8, _id_83B4C79B5D4B85C5) {
  _id_AC89E0692886C8BC = getEntArray(_id_497A14A8727744F4, "targetname");
  _id_0D4A389E846C8AF5 = getEntArray(_id_D1E50A639DFB62A0, "targetname");
  _id_BB7A49ED7B440D16 = [];

  if(_id_0D4A389E846C8AF5.size > 1) {
    foreach(_id_7B1DF66974B696FB in _id_0D4A389E846C8AF5) {
      if(!isDefined(_id_C32E62905819941C) || _id_C32E62905819941C == _id_7B1DF66974B696FB.script_noteworthy)
        _id_BB7A49ED7B440D16[_id_BB7A49ED7B440D16.size] = _id_7B1DF66974B696FB;
    }
  } else
    _id_BB7A49ED7B440D16 = _id_0D4A389E846C8AF5;

  foreach(lever in _id_AC89E0692886C8BC) {
    lever solid();
    lever thread _id_45B5920DB7A5AD60(_id_BB7A49ED7B440D16);
  }

  thread _id_CFDBDC695E3B4201(_id_AC89E0692886C8BC, _id_BB7A49ED7B440D16, _id_6B3429E420584763, _id_C3BF2A3EBA5CF2DD, _id_35B822F718D22CC8, _id_83B4C79B5D4B85C5);
  return _id_AC89E0692886C8BC;
}

_id_CFDBDC695E3B4201(_id_AC89E0692886C8BC, _id_BB7A49ED7B440D16, _id_6B3429E420584763, _id_C3BF2A3EBA5CF2DD, _id_35B822F718D22CC8, _id_83B4C79B5D4B85C5) {
  _id_A36803EEB489E394 = 0;

  while(!istrue(_id_A36803EEB489E394)) {
    _id_F71B616FAF689471 = 0;

    foreach(lever in _id_AC89E0692886C8BC) {
      if(!istrue(lever.destroyed)) {
        _id_F71B616FAF689471 = 1;
        wait 0.2;
        break;
      }
    }

    if(istrue(_id_F71B616FAF689471)) {
      continue;
    }
    _id_A36803EEB489E394 = 1;
  }

  thread _id_4E6773ED426B7BE2(_id_AC89E0692886C8BC, _id_BB7A49ED7B440D16, _id_6B3429E420584763, 300, _id_C3BF2A3EBA5CF2DD);

  if(isDefined(_id_35B822F718D22CC8)) {
    _id_DFE65A0649B7BE95 = getEntArray(_id_35B822F718D22CC8, "script_noteworthy");

    foreach(ent in _id_DFE65A0649B7BE95)
    ent delete();
  }

  if(isDefined(_id_83B4C79B5D4B85C5)) {
    _id_DFE65A0649B7BE95 = getEntArray(_id_83B4C79B5D4B85C5, "script_noteworthy");

    foreach(ent in _id_DFE65A0649B7BE95)
    ent delete();
  }
}

_id_895D02555CC69458() {
  if(isDefined(level._id_C36C08704A4D3B97.ent) && !level._id_C36C08704A4D3B97._id_70D316467FB1733B) {
    level._id_C36C08704A4D3B97._id_AE4ABD3AC3882BFF = spawn("script_origin", level._id_C36C08704A4D3B97.ent.origin);
    level._id_C36C08704A4D3B97._id_AE4ABD3AC3882BFF linkTo(level._id_C36C08704A4D3B97.ent);
    level._id_C36C08704A4D3B97._id_AE4ABD3AC3882BFF playLoopSound("evt_raid4_elevator_tension_lp");
    level._id_C36C08704A4D3B97._id_70D316467FB1733B = 1;
  }
}

_id_45B5920DB7A5AD60(_id_BB7A49ED7B440D16) {
  self endon("death");
  level endon("game_ended");
  self endon("weight_freefell");
  self endon("destroyed_lever");
  self.health = 9999;
  self setCanDamage(1);
  self._id_30CA52AAA2C7B73A = 8;
  f = anglesToForward(self.angles - (0, 90, 90));

  for(;;) {
    self waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, _id_9E834FE6754A9C98, _id_1D3F20A69CED2DD5, _id_920FF4456CE9A2FC, idflags, objweapon, origin, angles, normal, einflictor, eventid);

    if(!isDefined(eattacker) || !isPlayer(eattacker) && (!isDefined(eattacker.owner) || !isPlayer(eattacker.owner))) {
      continue;
    }
    if(isDefined(smeansofdeath) && smeansofdeath == "MOD_MELEE") {
      scripts\engine\utility::flag_set("counterweight_cut_start");
      self._id_30CA52AAA2C7B73A = self._id_30CA52AAA2C7B73A - 1;
      level notify("damagable_lever_hit", self, eattacker);

      if(isDefined(self getlinkedparent())) {
        parent = self getlinkedparent();
        self unlink();
        self.angles = combineangles(self.angles, (18, 0, 0));

        if(isDefined(parent))
          self linkTo(parent);
      } else
        self rotatepitch(18, 0.005);

      eattacker thread _id_6A9E142F943BB4AA();
      eattacker _id_354C862768CFE202::updatehitmarker("standard", 1, idamage, 0, 0);
    } else
      continue;

    if(self._id_30CA52AAA2C7B73A <= 0) {
      playFX(level._effect["vfx_raid_elevator_sparks_burst"], self.origin, f);
      self playSound("evt_raid4_elevator_lever_impact_lvl4");

      if(level._id_C36C08704A4D3B97._id_FADA5AACD1C05046 < 1) {
        self playSound("cp_raid4_elevator_drop_lever_break_swt");
        level thread _id_895D02555CC69458();
      }

      self.destroyed = 1;
      level thread _id_895D02555CC69458();
      self notify("destroyed_lever");
    } else if(self._id_30CA52AAA2C7B73A <= 3) {
      playFX(level._effect["vfx_cp_raid_crank_sparks"], self.origin);
      self playSound("evt_raid4_elevator_lever_impact_lvl3");
      self playSound("evt_raid4_elevator_sway");
    } else {
      playFX(level._effect["vfx_cp_raid_crank_sparks"], self.origin);
      self playSound("evt_raid4_elevator_lever_impact_lvl2");
      self playSound("evt_raid4_elevator_sway");
    }

    self notify("stop_melee_progress_reset");
  }
}

_id_6A9E142F943BB4AA() {
  self notify("gain_enemy_focus");
  self endon("gain_enemy_focus");
  self endon("disconnect");
  level endon("game_ended");

  if(!istrue(self._id_07DB344940E7FE69)) {
    self._id_07DB344940E7FE69 = 1;
    ai_array = getaiarray("axis");

    if(isDefined(ai_array) && ai_array.size > 0) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < ai_array.size; _id_AC0E594AC96AA3A8++) {
        if(_id_AC0E594AC96AA3A8 > 3) {
          break;
        }

        ai_array[_id_AC0E594AC96AA3A8].favoriteenemy = self;
      }
    }
  }

  wait 5;
  self._id_07DB344940E7FE69 = undefined;
}

_id_A0888F618640AC0F() {
  self endon("stop_melee_progress_reset");

  while(self._id_30CA52AAA2C7B73A < 8) {
    wait 0.5;
    self._id_30CA52AAA2C7B73A = self._id_30CA52AAA2C7B73A + 1;
    self rotateby((0, -10, 0), 0.005);
    self playSound("bullet_npc_helmet_break");
  }
}

_id_4E6773ED426B7BE2(_id_AC89E0692886C8BC, _id_BB7A49ED7B440D16, goalheight, damageradius, _id_C3BF2A3EBA5CF2DD) {
  level endon("game_ended");

  foreach(ent in _id_BB7A49ED7B440D16) {
    ent.active = 1;

    if(isDefined(level._id_C36C08704A4D3B97.ent))
      ent unlink();

    thread _id_A22953DD9FBB3251(ent, goalheight, damageradius, _id_C3BF2A3EBA5CF2DD);
  }

  foreach(lever in _id_AC89E0692886C8BC) {
    if(isDefined(lever)) {
      lever notify("weight_freefell");
      lever delete();
    }
  }

  if(isDefined(level._id_EF0F2E9F39B9E2F8))
    [[level._id_EF0F2E9F39B9E2F8]]();
}

_id_A22953DD9FBB3251(ent, goalheight, damageradius, _id_C3BF2A3EBA5CF2DD) {
  dist = ent.origin[2] - goalheight[2];
  gravity = 385.827;
  time = sqrt(dist / gravity);
  _id_D4CF75E8A617D80C = (ent.origin[0], ent.origin[1], goalheight[2]);

  if(isDefined(ent.classname) && ent.classname == "script_brushmodel")
    _id_D4CF75E8A617D80C = (ent.origin[0], ent.origin[1], goalheight[2] + 80);

  if(isDefined(ent.targetname) && ent.targetname == "elevator_counterweight")
    _id_D4CF75E8A617D80C = (ent.origin[0], ent.origin[1], goalheight[2] + getdvarint("dvar_44120259B1522BD5", 48));

  ent moveTo(_id_D4CF75E8A617D80C, time, time);

  if(!istrue(_id_C3BF2A3EBA5CF2DD)) {
    return;
  }
  wait(time);
  damageradius = scripts\engine\utility::_id_53C4C53197386572(damageradius, 120);

  foreach(player in level.players) {
    if(distancesquared(player.origin, _id_D4CF75E8A617D80C) < damageradius * damageradius) {
      player.shouldskipdeathsshield = 1;
      player._id_1983AF7858AA2ABA = 1;
      player._id_230A3287F9AD2965 = 1;
      player.ability_invulnerable = undefined;
      player _id_25845ACA699D038D::setdamageflag(1, 0);
      damage = scripts\engine\math::lerp(999, 30, distance(player.origin, _id_D4CF75E8A617D80C) / damageradius);
      player dodamage(damage, _id_D4CF75E8A617D80C, ent, ent, "MOD_CRUSH");
    }
  }
}

_id_A6E2EBB3F7E5A9F6(_id_92C4DE821390F609, hintstring, buttonmodel, duration) {
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(_id_92C4DE821390F609, "script_noteworthy");
  buttons = [];

  foreach(struct in _id_9E4E1482CB40C9C5)
  buttons[buttons.size] = _id_683F024F53CEE760(struct, hintstring, buttonmodel, duration);

  return buttons;
}

_id_92233BCD56EA95C5(_id_92C4DE821390F609, _id_43BAFB58FE4EE161, _id_89FCEB49BA5D7862, _id_60480D8FA1D4809D, _id_A6F2B5276D1CC26C, _id_C52CC05194B362D4, _id_08204D487A1F9ED8) {
  level endon("game_ended");
  doors = getEntArray(_id_92C4DE821390F609, "script_noteworthy");
  use_struct = scripts\engine\utility::getStruct(_id_92C4DE821390F609, "script_noteworthy");

  if(isDefined(doors) && isDefined(use_struct)) {
    _id_887438C3B4B194B6(1, use_struct.origin);

    if(isDefined(_id_60480D8FA1D4809D))
      scripts\engine\utility::flag_wait(_id_60480D8FA1D4809D);

    hintdist = scripts\engine\utility::ter_op(isDefined(level._id_E88DDD791BC1A3E0), level._id_E88DDD791BC1A3E0, 200);
    _id_C5D3D8FF129F88BA = scripts\cp\utility::createhintobject(use_struct.origin, "HINT_BUTTON", undefined, &"CP_TRAP_ROOM/3MANDOOR", undefined, "duration_short", "show", hintdist, 300, 64, 40, undefined);
    _id_830905E5C2645826 = _id_92C4DE821390F609 + "_door_open";
    childthread _id_F6BC7D593D54CFEC(_id_C5D3D8FF129F88BA, _id_830905E5C2645826);
    childthread _id_4D3C7EB683BC1E25(use_struct, _id_830905E5C2645826, _id_89FCEB49BA5D7862, _id_C5D3D8FF129F88BA);
    waitframe();
    _id_C5D3D8FF129F88BA sethintstringparams(0);
    level waittill(_id_830905E5C2645826);

    if(istrue(_id_43BAFB58FE4EE161))
      scripts\engine\utility::flag_set(_id_830905E5C2645826);

    _id_1FC06BF514F2782A = _id_C5D3D8FF129F88BA.origin;
    _id_C5D3D8FF129F88BA delete();
    _id_E82B3CC012178322 = scripts\engine\utility::_id_53C4C53197386572(_id_A6F2B5276D1CC26C, "emb_garage_open_start");
    _id_4B96F4710D7BC606 = scripts\engine\utility::_id_53C4C53197386572(_id_C52CC05194B362D4, "emb_garage_open_lp");
    _id_29899805D9CA5FB4 = scripts\engine\utility::_id_53C4C53197386572(_id_08204D487A1F9ED8, "emb_garage_open_stop");

    if(soundexists(_id_E82B3CC012178322))
      scripts\cp\utility::playsoundatpos_safe(_id_1FC06BF514F2782A, _id_E82B3CC012178322);

    if(soundexists(_id_4B96F4710D7BC606) && isDefined(doors[0]))
      doors[0] playLoopSound(_id_4B96F4710D7BC606);

    wait 1;

    if(soundexists(_id_29899805D9CA5FB4))
      scripts\cp\utility::playsoundatpos_safe(_id_1FC06BF514F2782A, _id_29899805D9CA5FB4);

    wait 0.25;

    if(soundexists(_id_4B96F4710D7BC606) && isDefined(doors[0]))
      doors[0] stoploopsound();

    wait 0.25;
    _id_887438C3B4B194B6(0, use_struct.origin);

    if(isDefined(level._id_8739AC8958071FA3))
      [[level._id_8739AC8958071FA3]](doors);
    else {
      foreach(door in doors)
      door delete();
    }
  }
}

_id_4D3C7EB683BC1E25(use_struct, _id_830905E5C2645826, _id_89FCEB49BA5D7862, _id_C5D3D8FF129F88BA) {
  level endon("game_ended");
  level endon(_id_830905E5C2645826);
  dist = scripts\engine\utility::ter_op(isDefined(_id_89FCEB49BA5D7862), _id_89FCEB49BA5D7862, 120);
  _id_B5A9B9C0EEB065DE = squared(dist);
  wait 1;

  for(;;) {
    count = _id_D7A0BFE1D6409805(use_struct.origin, _id_B5A9B9C0EEB065DE);

    if(isDefined(_id_C5D3D8FF129F88BA))
      _id_C5D3D8FF129F88BA sethintstringparams(count);

    if(count == level.players.size) {
      level notify(_id_830905E5C2645826);
      return;
    }

    wait 1;
  }
}

_id_D7A0BFE1D6409805(origin, _id_A9B6B677F6D0A010) {
  count = 0;

  foreach(player in level.players) {
    if(distancesquared(player.origin, origin) <= _id_A9B6B677F6D0A010)
      count++;
  }

  return count;
}

_id_887438C3B4B194B6(closed, pos, radius) {
  if(!isDefined(radius))
    radius = 128;

  if(!isDefined(pos))
    pos = self.origin;

  _id_786FD7C325A6D910 = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(pos, radius);

  foreach(_id_26BAEFB3804B52C3 in _id_786FD7C325A6D910) {
    if(_id_26BAEFB3804B52C3 scriptableisdoor()) {
      if(closed) {
        timeout = 0;
        _id_26BAEFB3804B52C3 scriptabledoorclose();

        while(!_id_26BAEFB3804B52C3 scriptabledoorisclosed() && timeout < 10) {
          wait 0.1;
          timeout++;
        }

        _id_26BAEFB3804B52C3 scriptabledoorfreeze(1);
        continue;
      }

      _id_26BAEFB3804B52C3 scriptabledoorfreeze(0);
      _id_26BAEFB3804B52C3 scriptabledooropen("away", pos);
    }
  }
}

_id_F6BC7D593D54CFEC(_id_C5D3D8FF129F88BA, _id_830905E5C2645826, _id_CEBB22306F7A7C58) {
  level endon("game_ended");
  level endon(_id_830905E5C2645826);
  _id_88F7BC4C4C26E93D = [];
  _id_C5D3D8FF129F88BA sethintstringparams(_id_88F7BC4C4C26E93D.size);

  for(;;) {
    _id_C5D3D8FF129F88BA waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(!isDefined(scripts\engine\utility::array_find(_id_88F7BC4C4C26E93D, player)) || getdvarint("dvar_621832322EB666A6")) {
      _id_88F7BC4C4C26E93D = scripts\engine\utility::array_add(_id_88F7BC4C4C26E93D, player);
      _id_C5D3D8FF129F88BA thread _id_E70555DA16B3A073();
      _id_C5D3D8FF129F88BA sethintstringparams(_id_88F7BC4C4C26E93D.size);

      if(isDefined(_id_CEBB22306F7A7C58)) {
        level notify(_id_CEBB22306F7A7C58, player);
        level notify("vo_" + _id_CEBB22306F7A7C58, player);
      }
    }

    if(getdvarint("dvar_621832322EB666A6") > 0)
      _id_0F714A515FC59FF0 = 3;
    else
      _id_0F714A515FC59FF0 = level.players.size;

    if(_id_88F7BC4C4C26E93D.size == _id_0F714A515FC59FF0) {
      level notify("vo_" + _id_830905E5C2645826);
      return;
    }
  }
}

_id_E70555DA16B3A073() {
  level endon("game_ended");

  if(!isDefined(self._id_EEF18F2278DC177D)) {
    return;
  }
  foreach(marker in self._id_EEF18F2278DC177D) {
    if(!istrue(marker._id_C37B1CC67943336D)) {
      marker show();
      return;
    }
  }
}

_id_F8C7F0B26960DF68() {
  if(istrue(level._id_102FD3491CDFC22C)) {
    return;
  }
  level._id_102FD3491CDFC22C = 1;
  _id_70FAE4FEFED22687 = scripts\engine\utility::getStruct("starting_room_marker", "script_noteworthy");

  if(isDefined(_id_70FAE4FEFED22687))
    _id_70FAE4FEFED22687 thread _id_26198B4BB49A3DF5();

  if(getdvarint("dvar_FB311D38464CFE24", 1)) {
    _id_848D98522B5E2243("sn_alpha_model", "iw9_sn_alpha50_mp+bar_sn_p23+bgrip_sn_p23+iw9_snprscope_alpha50+mag_sn_p23+rec_alpha50+stock_sn_p23", "sn_alpha_give_button", &"CP_HARRIER_BOSS/TAKE_SN_ALPHA");
    _id_848D98522B5E2243("sn_alpha_model", "iw9_sn_limax_mp+bar_sn_heavy_p22+limax_snprscope+mag_sn_p22+pgrip_p22+rec_limax+stock_sn_p22", "sn_alpha_give_button", &"CP_HARRIER_BOSS/TAKE_SN_ALPHA");
    _id_848D98522B5E2243("sh_mike_model", "iw9_sh_mike1014_mp+ammo_12g+bar_sh_light_p12+bolt_p12+guard_p12+ironsdefault_mike1014+rec_mike1014+stock_sh_p12+tube_5_12g_mike1014", "sh_mike_give_button", &"CP_HARRIER_BOSS/TAKE_SHG_MIKE");
    _id_848D98522B5E2243("sm_papa_model", "iw9_sm_mpapa7_mp+bar_sm_p09+ironsdefault_mpapa7+mag_sm_p09+pgrip_p09+rec_mpapa7+stock_sm_light_p09", "sm_papa_give_button", &"CP_HARRIER_BOSS/TAKE_SMG_PAPA");
    _id_848D98522B5E2243("sm_beta_model", "iw9_sm_beta_mp+bar_sm_lgtshort_p04+iw9_ironsdefault_beta+iw9_rec_beta+iw9_selectsemi+magheli_sm_p04+pgrip_p04+stock_sm_p04", "sm_beta_give_button", &"CP_HARRIER_BOSS/TAKE_SMG_BETA");
    _id_848D98522B5E2243("sm_augolf_model", "iw9_sm_papa90_mp+bar_sm_short_p07+iw9_ironsdefault_papa90+iw9_rec_papa90+mag_sm_p07+pgrip_p07+rail_sm_p07+stock_sm_light_p07", "sm_beta_give_button", &"CP_HARRIER_BOSS/TAKE_SMG_BETA");
    _id_848D98522B5E2243("ar_mike_model", "iw9_ar_mike4_mp+ammo_556n+bar_ar_p01+iw9_ironsdefault_mike4+iw9_rec_mike4+iw9_selectsemi+mag_ar_p01+pgrip_p01+stock_ar_p01", "ar_mike_give_button", &"CP_HARRIER_BOSS/TAKE_AR_MIKE");
    _id_848D98522B5E2243("ar_charlie1_model", "iw9_ar_mcharlie_mp+ammo_556n+bar_ar_p08+iw9_ironsdefault_mcharlie+iw9_rec_mcharlie+iw9_selectsemi+mag_ar_p08+pgrip_ar_p08+stock_ar_p08", "ar_charlie1_give_button", &"CP_HARRIER_BOSS/TAKE_AR_CHARLIE");
    _id_848D98522B5E2243("ar_charlie2_model", "iw9_ar_scharlie_mp+ammo_556n+bar_ar_p05+iw9_ironsdefault_scharlie+iw9_rec_scharlie+iw9_selectsemi+mag_ar_p05+pgrip_p05+stock_ar_p05", "ar_charlie2_give_button", &"CP_HARRIER_BOSS/TAKE_AR_CHARLIE1");
    _id_848D98522B5E2243("ar_kilo_model", "iw9_ar_akilo_mp+ammo_762s+bar_ar_long_p04+ironsdefault_akilo+mag_ar_p04+pgrip_p04+rec_akilo+selectsemi_akilo+stock_ar_p04", "ar_kilo_give_button", &"CP_HARRIER_BOSS/TAKE_AR_KILO");
    _id_848D98522B5E2243("ar_sierra_model", "iw9_ar_scsierra_mp+ammo_556n+bar_ar_light_p05+ironsdefault_scsierra+iw9_selectsemi+mag_ar_p05+pgrip_p05+rec_scsierra+stock_sm_p05", "ar_sierra_give_button", &"CP_HARRIER_BOSS/TAKE_AR_SIERRA");
    _id_848D98522B5E2243("ar_mike14_model", "iw9_sn_mromeo_mp+bar_sn_p21+bolt_p21+mag_sn_p21+pgrip_p21+rec_mromeo+snprscope_mromeo+stock_sn_p21", "ar_mike14_give_button", &"CP_HARRIER_BOSS/TAKE_AR_MIKE1");
    _id_848D98522B5E2243("me_riotshield_model", "iw9_me_riotshield_mp+", "me_riotshield_give_button", &"CP_HARRIER_BOSS/TAKE_ME_RIOTSHIELD");
  } else {
    _id_848D98522B5E2243("sn_alpha_model", "iw8_sn_alpha50_mp+ammomod_wound+bipodsnpr|1+flashhidersnpr_alpha50|1+iw8_back_alpha50|3+iw8_front_alpha50|3+iw8_mag_alpha50|3+iw8_rec_alpha50|3+pistolgrip01_alpha50|2+snprscope_alpha50|2+loot3", "sn_alpha_give_button", &"CP_HARRIER_BOSS/TAKE_SN_ALPHA");
    _id_848D98522B5E2243("sn_mike_model", "iw8_sn_mike14_mp+front_mike14_mp|12+laserbalanceddmr_bar|15+pistolgrip03_mike14|5+rec_mike14_mp|12+reflex_east02|6+stockcqb_mike14_mp|5+xmags_mike14|6+loot12", "sn_mike_give_button", &"CP_HARRIER_BOSS/TAKE_DMR");
    _id_848D98522B5E2243("sh_mike_model", "iw8_sh_mike26_mp+back_mike26|3+barlong_mike26|1+gripside_mike26|3+laserrangeshtgn_bar|5+minireddot03_tall|3+muzzlemelee_mike26|3+rec_mike26|3+loot3", "sh_mike_give_button", &"CP_HARRIER_BOSS/TAKE_SHG_MIKE");
    _id_848D98522B5E2243("sm_papa_model", "iw9_sm_mpapa7_mp+bar_sm_p09+ironsdefault_mpapa7+mag_sm_p09+pgrip_p09+rec_mpapa7+stock_sm_light_p09", "sm_papa_give_button", &"CP_HARRIER_BOSS/TAKE_SMG_PAPA");
    _id_848D98522B5E2243("sm_beta_model", "iw8_sm_beta_mp+back_beta|3+compsmg|1+front_beta|3+holo_east01|1+mag_beta|3+pistolgrip01_beta|1+rec_beta|3+loot3", "sm_beta_give_button", &"CP_HARRIER_BOSS/TAKE_SMG_BETA");
    _id_848D98522B5E2243("sm_augolf_model", "iw8_sm_augolf_mpv3+front_augolf|8+gripangpro_augolf|12+laserbalanced_smg|5+rec_augolf_mp|8+reflex_east01_ironsfull|1+selectsemi+stockh_augolf_v3|2+xmags_augolf|1+loot8", "sm_augolf_give_button", &"CP_HARRIER_BOSS/TAKE_SMG_GOLF");
    _id_848D98522B5E2243("ar_mike_model", "iw8_ar_mike4_mpv2a+barmid_mike4_mpv2|6+gripvertpro|15+holo_west02|3+laserbalanced_mike4|12+mag_mike4a|2+rec_mike4a|2+selectsemi+stocks_mike4|5+loot18", "ar_mike_give_button", &"CP_HARRIER_BOSS/TAKE_AR_MIKE");
    _id_848D98522B5E2243("ar_charlie1_model", "iw8_ar_scharlie_mpv2+barshort_scharlie|7+gripvert|7+ironsdefault_scharlie+laserrange|11+rec_scharlie|6+selectsemi+stockl_scharlie|6+xmags_scharlie|3+loot6", "ar_charlie1_give_button", &"CP_HARRIER_BOSS/TAKE_AR_CHARLIE");
    _id_848D98522B5E2243("ar_charlie2_model", "iw8_ar_scharlie_mpv2+back_scharlie|7+front_scharlie|7+mag_scharlie|7+rec_scharlie|7+loot7", "ar_charlie2_give_button", &"CP_HARRIER_BOSS/TAKE_AR_CHARLIE1");
    _id_848D98522B5E2243("ar_kilo_model", "iw8_ar_kilo433_mp+acog_west01_irons+back_kilo433+drums_kilo433+fastreload+front_kilo433+laserrange_kilo433+rec_kilo433+selectsemi", "ar_kilo_give_button", &"CP_HARRIER_BOSS/TAKE_AR_KILO");
    _id_848D98522B5E2243("ar_sierra_model", "iw8_ar_sierra552_mpa+back_sierra552a+barxlong_sierra552|5+laserbalanced_sierra552|3+minireddot03_tall|14+pistolgrip02_sierra552|2+rec_sierra552a+xmagslrg_sierra552", "ar_sierra_give_button", &"CP_HARRIER_BOSS/TAKE_AR_SIERRA");
    _id_848D98522B5E2243("ar_mike14_model", "iw8_sn_mike14_mp+fastreload+front_mike14_mp+laserrange_bar+reargrip_mike14+rec_mike14_mp+thermaldmr_west01+xmags_mike14", "ar_mike14_give_button", &"CP_HARRIER_BOSS/TAKE_AR_MIKE1");
    _id_848D98522B5E2243("me_riotshield_model", "iw9_me_riotshield_mp+", "me_riotshield_give_button", &"CP_HARRIER_BOSS/TAKE_ME_RIOTSHIELD");
  }

  _id_0441F289555E2CCF = getEntArray("silencer_interaction", "targetname");
  scripts\engine\utility::array_thread(_id_0441F289555E2CCF, ::_id_15A0FFB5BBAF82B1);
  _id_D5ECF70A4D407B43 = scripts\engine\utility::getStructArray("start_offhand_struct", "targetname");
  level_offhand_spawn(_id_D5ECF70A4D407B43);
}

_id_15A0FFB5BBAF82B1() {
  scripts\cp\utility::sethintobject("tag_origin", "HINT_BUTTON", "icon_attachment_silencer_east01", &"CP_RAID1_BOSS1/TAKE_SILENCER", undefined, "duration_none", "show", 250, 35, 72, 45);

  for(;;) {
    self waittill("trigger", ent);
    self _meth_DFB78B3E724AD620(0);
    objweapon = ent getcurrentprimaryweapon();
    _id_DD515FCF025B2E79 = objweapon _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00("silencer");

    if(isDefined(_id_DD515FCF025B2E79)) {
      ent takeweapon(objweapon);
      ent giveweapon(_id_DD515FCF025B2E79);
      ent switchtoweapon(_id_DD515FCF025B2E79);
    }

    wait 0.5;
    self _meth_DFB78B3E724AD620(1);
  }
}

_id_848D98522B5E2243(_id_64465D5627593246, _id_132360A247A77FA7, _id_EFCBDB1D398C8601, _id_A6F902EA5D061F1F, _id_212CD1B657CA5088) {
  _id_51A91CEB6CC9AD2F = _id_132360A247A77FA7;
  _id_07132F053DB6712D = scripts\engine\utility::getStructArray(_id_64465D5627593246, "script_noteworthy");
  _id_5D9720C9F3A6DF33 = spawnStruct();
  _id_5D9720C9F3A6DF33._id_711D53C4B8AE7F3A = [];
  _id_5D9720C9F3A6DF33._id_ACE531FE5DA6E1A5 = [];

  foreach(_id_60F7CB484EC61F6C in _id_07132F053DB6712D) {
    if(!isDefined(_id_60F7CB484EC61F6C.target)) {
      continue;
    }
    attachments = _func_6527364C1ECCA6C6(_id_132360A247A77FA7);
    weaponobj = makeweapon(_id_132360A247A77FA7, attachments);
    weaponobj = weaponobj _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00("silencer");
    _id_132360A247A77FA7 = getcompleteweaponname(weaponobj);
    _id_2BE8EAE884AD8905 = _id_132360A247A77FA7 + "2";

    if(!istrue(_id_212CD1B657CA5088)) {
      if(getdvarint("dvar_BAC49DC689DDA280", 1)) {
        weapon = _id_66122A002AFF5D57::createspawnweaponatpos(_id_60F7CB484EC61F6C.origin, _id_60F7CB484EC61F6C.angles, _id_2BE8EAE884AD8905, 1);

        if(isDefined(weapon)) {
          weapon _id_66122A002AFF5D57::_id_86321FC8F45C2A9B(1);
          weapon _id_66122A002AFF5D57::_id_B10EE40ED82D45C9(1);
          return;
        }
      }
    }

    _id_B8F5AC23CE0DFDE3 = spawn("weapon_" + _id_2BE8EAE884AD8905, _id_60F7CB484EC61F6C.origin);
    _id_EF0DA79BC6D64DC0 = scripts\engine\utility::getStruct(_id_60F7CB484EC61F6C.target, "targetname");
    button = _id_683F024F53CEE760(_id_EF0DA79BC6D64DC0, _id_A6F902EA5D061F1F, "tag_origin");
    weapon = makeweaponfromstring(_id_132360A247A77FA7);
    stockammo = weaponstartammo(weapon);
    ammotype = _id_66122A002AFF5D57::br_ammo_type_for_weapon(weapon);

    if(isDefined(ammotype)) {
      _id_0A862B844906A7C8 = _id_66122A002AFF5D57::_id_ECDFC73E68DCC209(ammotype);
      stockammo = int(min(stockammo, _id_0A862B844906A7C8));
    }

    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(_id_B8F5AC23CE0DFDE3), stockammo);
    level thread _id_1EB414719690376B(button, weapon);
    _id_B8F5AC23CE0DFDE3 _meth_DFB78B3E724AD620(0);
    _id_5D9720C9F3A6DF33._id_711D53C4B8AE7F3A[_id_5D9720C9F3A6DF33._id_711D53C4B8AE7F3A.size] = _id_B8F5AC23CE0DFDE3;
    _id_5D9720C9F3A6DF33._id_ACE531FE5DA6E1A5[_id_5D9720C9F3A6DF33._id_ACE531FE5DA6E1A5.size] = button;
  }

  return _id_5D9720C9F3A6DF33;
}

_id_079492C52EB9F56F(player, weapon) {
  if(!isDefined(player.weaponlist))
    return 0;

  foreach(_id_D13380BB17A918C0 in player.weaponlist) {
    if(_id_D13380BB17A918C0.basename == weapon.basename)
      return 1;
  }

  return 0;
}

_id_1EB414719690376B(button, weapon) {
  level endon("game_ended");

  for(;;) {
    button waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(_id_079492C52EB9F56F(player, weapon)) {
      continue;
    }
    if(player _id_1B4114093CD44368::_id_23A6763562820C70()) {
      player thread scripts\cp\utility::hint_prompt("cant_use_with_weapon", 1, 2);
      continue;
    }

    if(isDefined(player.currentweapon))
      player scripts\cp_mp\utility\inventory_utility::_takeweapon(player.currentweapon);

    _id_0A862B844906A7C8 = weaponstartammo(weapon);
    ammotype = _id_66122A002AFF5D57::br_ammo_type_for_weapon(weapon);

    if(isDefined(ammotype)) {
      _id_0A862B844906A7C8 = _id_66122A002AFF5D57::_id_ECDFC73E68DCC209(ammotype);
      player.br_ammo[ammotype] = _id_0A862B844906A7C8;
    }

    player scripts\cp_mp\utility\inventory_utility::_giveweapon(weapon);
    player.starting_weapon = weapon;
    waitframe();
    player scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(weapon);
    player setweaponammostock(weapon, _id_0A862B844906A7C8);
    _id_C00805D2E42B3456 = _id_74502A9E0EF1F19C::_id_2F4D1CDA9BC48E6A(weapon);
    checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

    if(isDefined(checkpoint) && checkpoint != "" && isDefined(self.pers["last_checkpoint"]) && self.pers["last_checkpoint"] != checkpoint)
      thread _id_12E2FB553EC1605E::_id_7DA7BD24B280D295();

    wait 2;
  }
}

level_offhand_spawn(_id_9E4E1482CB40C9C5) {
  offset = (0, -90, 0);

  foreach(struct in _id_9E4E1482CB40C9C5) {
    switch (struct.script_parameters) {
      case "ammo":
        _id_B1AD25AD91B2627D = ammo_crate_spawn(struct.origin, struct.angles + offset);
        _id_B1AD25AD91B2627D setHintString(&"COOP_CRAFTING/AMMO_CRATE_TAKE");
        break;
      case "claymore":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::claymore_crate_use, struct, &"EQUIPMENT_HINTS/PICKUP_CLAYMORE", undefined, ::claymore_crate_update_hint_logic_alt, 0);
        break;
      case "flash":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::flash_crate_use, struct, &"CP_SO_FINALE/PICKUP_FLASH", undefined, ::flash_crate_update_hint_logic_alt, 0);
        break;
      case "c4":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::c4_crate_use, struct, &"EQUIPMENT_HINTS/PICKUP_C4", undefined, ::c4_crate_update_hint_logic_alt, 0);
        break;
      case "semtex":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::_id_3F96668C7B895039, struct, &"EQUIPMENT_HINTS/PICKUP_SEMTEX", undefined, ::_id_35FAEE40D2A126DC, 0);
        break;
      case "stim":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::stim_crate_use_alt, struct, &"CP_SO_FINALE/PICKUP_STIMS", undefined, ::stim_crate_update_hint_logic, 0);
        break;
      case "molotov":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::molotov_crate_use, struct, &"CP_SO_FINALE/PICKUP_MOLOTOV", undefined, ::molotov_crate_update_hint_logic_alt, 0);
        break;
      case "shockstick":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::_id_D2C95F21C20C5837, struct, &"CP_SO_FINALE/PICKUP_SHOCKSTICK", undefined, ::_id_72209484279BC8B2, 0);
        break;
      case "snapshot":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::snapshot_crate_use, struct, &"EQUIPMENT_HINTS/PICKUP_SNAPSHOT", undefined, ::_id_0D7178547C687190, 0);
        break;
      case "decoy":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::_id_DE561C1CD30D79FB, struct, &"EQUIPMENT_HINTS/PICKUP_DECOY", undefined, ::_id_9F50F7E2890AC3D6, 0);
        break;
      case "hb_sensor":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::_id_61B64A8DD9B2B4A1, struct, &"EQUIPMENT_HINTS/PICKUP_HBSENSOR", undefined, ::_id_8C12C8772102DA1C, 0);
        break;
      case "throwknife":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::_id_C38036E90CD0BCE2, struct, &"EQUIPMENT_HINTS/PICKUP_THROWING_KNIFE", undefined, ::_id_72623A1D87BA8047, 0);
        break;
      case "smoke":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::_id_154280AC22F07112, struct, &"EQUIPMENT_HINTS/PICKUP_SMOKE_GRENADE", undefined, ::_id_F00C9AF9A6ADB597, 0);
        break;
      case "atmine":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::_id_3EF0644E135217F7, struct, &"EQUIPMENT_HINTS/PICKUP_AT_MINE", undefined, ::_id_9BF4D63445E01DFE, 0);
        break;
      case "stun":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::_id_3C92231366306421, struct, &"EQUIPMENT_HINTS/PICKUP_STUN_GRENADE", undefined, ::_id_EA907C735A4C319C, 0);
        break;
      case "thermite":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::_id_D1AC715565B885CB, struct, &"EQUIPMENT_HINTS/PICKUP_THERMITE", undefined, ::_id_20AA66119D8960FA, 0);
        break;
    }
  }
}

_id_8C12C8772102DA1C(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_hb_sensor");
}

_id_72623A1D87BA8047(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_throwing_knife");
}

_id_F00C9AF9A6ADB597(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_smoke");
}

_id_9BF4D63445E01DFE(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_at_mine");
}

_id_EA907C735A4C319C(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_concussion");
}

_id_20AA66119D8960FA(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_thermite");
}

claymore_crate_spawn(origin, angles) {
  return support_box_spawn(origin, angles, ::claymore_crate_use, "offhand_wm_supportbox_explosives", &"COOP_CRAFTING/CLAYMORE", "hud_icon_equipment_claymore", "hud_icon_equipment_claymore_red", ::claymore_crate_player_at_max_ammo);
}

claymore_crate_use(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_claymore", "primary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_claymore", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

claymore_crate_player_at_max_ammo(player) {
  return player _id_1DB8D0E02A99C5E2::_id_06CB0B5230400C66("equip_claymore");
}

adrenaline_crate_spawn(origin, angles) {
  return support_box_spawn(origin, angles, ::adrenaline_crate_use, "lm_heal_first_aid_kit_01", &"CP_SO_FINALE/PICKUP_STIMS", "hud_icon_equipment_stim", "hud_icon_equipment_stim_red", ::adrenaline_crate_player_at_max_ammo);
}

adrenaline_crate_use(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_adrenaline", "secondary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_adrenaline", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

adrenaline_crate_player_at_max_ammo(player) {
  return player _id_1DB8D0E02A99C5E2::_id_06CB0B5230400C66("equip_adrenaline");
}

molotov_crate_spawn(origin, angles) {
  return support_box_spawn(origin, angles, ::molotov_crate_use, "offhand_wm_supportbox_explosives", &"COOP_CRAFTING/MOLOTOV", "hud_icon_equipment_molotov", "hud_icon_equipment_molotov_red", ::molotov_crate_player_at_max_ammo);
}

molotov_crate_use(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_molotov", "primary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_molotov", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

molotov_crate_player_at_max_ammo(player) {
  return player _id_1DB8D0E02A99C5E2::_id_06CB0B5230400C66("equip_molotov");
}

frag_crate_spawn(origin, angles) {
  return support_box_spawn(origin, angles, ::frag_crate_use, "offhand_wm_supportbox_explosives", &"COOP_CRAFTING/FRAG", "hud_icon_equipment_frag", "hud_icon_equipment_frag_red", ::frag_crate_player_at_max_ammo);
}

frag_crate_use(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_frag", "primary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_frag", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

frag_crate_player_at_max_ammo(player) {
  return player _id_1DB8D0E02A99C5E2::_id_06CB0B5230400C66("equip_frag");
}

c4_crate_spawn(origin, angles, _id_166611133C8F7524) {
  return support_box_spawn(origin, angles, ::c4_crate_use, "offhand_wm_supportbox_explosives", &"EQUIPMENT_HINTS/PICKUP_C4", "hud_icon_equipment_c4", "hud_icon_equipment_c4_red", ::c4_crate_player_at_max_ammo);
}

c4_crate_use(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_c4", "primary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_c4", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

c4_crate_player_at_max_ammo(player) {
  return player _id_1DB8D0E02A99C5E2::_id_06CB0B5230400C66("equip_c4");
}

_id_3F96668C7B895039(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_semtex", "primary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_semtex", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

flash_crate_use(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_flash", "secondary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_flash", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

flash_crate_player_at_max_ammo(player) {
  return player _id_1DB8D0E02A99C5E2::_id_06CB0B5230400C66("equip_flash");
}

_id_61B64A8DD9B2B4A1(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_hb_sensor", "secondary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_hb_sensor", 1);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

_id_C38036E90CD0BCE2(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_throwing_knife", "primary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_throwing_knife", 3);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_pickup_knife_plr");
}

_id_154280AC22F07112(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_smoke", "secondary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_smoke", 2);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

_id_3EF0644E135217F7(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_at_mine", "primary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_at_mine", 2);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

_id_3C92231366306421(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_concussion", "secondary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_concussion", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

_id_D1AC715565B885CB(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_thermite", "primary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_thermite", 2);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

_id_DE561C1CD30D79FB(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_decoy", "secondary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_decoy", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

snapshot_crate_use(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_snapshot_grenade", "secondary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_snapshot_grenade", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

snapshot_crate_player_at_max_ammo(player) {
  return player _id_1DB8D0E02A99C5E2::_id_06CB0B5230400C66("equip_snapshot_grenade");
}

gasgrenade_crate_use(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_gas_grenade", "secondary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_gas_grenade", 2);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

gasgrenade_crate_player_at_max_ammo(player) {
  return player _id_1DB8D0E02A99C5E2::_id_06CB0B5230400C66("equip_gas_grenade");
}

ammo_crate_spawn(origin, angles) {
  return support_box_spawn(origin, angles, ::ammo_crate_use, "offhand_wm_supportbox_ammunition", &"COOP_CRAFTING/AMMO_CRATE_TAKE", "hud_icon_fieldupgrade_ammo_box", "cp_crate_icon_ammo_red", ::player_has_primary_weapons_max_stock_ammo);
}

player_has_primary_weapons_max_stock_ammo(player) {
  primaryweapons = player getweaponslistprimaries();

  foreach(primaryweapon in primaryweapons) {
    if(weapontype(primaryweapon) == "riotshield") {
      continue;
    }
    _id_D1AD88BF84DAA67F = player getweaponammostock(primaryweapon);

    if(_id_D1AD88BF84DAA67F < weaponmaxammo(primaryweapon))
      return 0;
  }

  return 1;
}

ammo_crate_use(_id_B1AD25AD91B2627D, player) {
  primaryweapons = player getweaponslistprimaries();

  foreach(primaryweapon in primaryweapons) {
    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(weapontype(primaryweapon) == "riotshield") {
      continue;
    }
    if(_id_74502A9E0EF1F19C::is_incompatible_weapon(primaryweapon)) {
      continue;
    }
    player _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(primaryweapon);
  }

  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

_id_D2C95F21C20C5837(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_shockstick", "secondary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_shockstick", 2);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

claymore_crate_update_hint_logic_alt(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_claymore");
}

flash_crate_update_hint_logic_alt(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_flash");
}

c4_crate_update_hint_logic_alt(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_c4");
}

_id_35FAEE40D2A126DC(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_semtex");
}

_id_0D7178547C687190(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_snapshot_grenade");
}

_id_9F50F7E2890AC3D6(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_decoy");
}

stim_crate_use_alt(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_adrenaline", "secondary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_adrenaline", player _id_7EF95BBA57DC4B82::getequipmentmaxammo("equip_adrenaline"));
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

stim_crate_update_hint_logic(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_adrenaline");
}

molotov_crate_update_hint_logic_alt(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_molotov");
}

_id_72209484279BC8B2(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_shockstick");
}

update_hint_logic_offhand(_id_B1AD25AD91B2627D, type) {
  _id_B1AD25AD91B2627D endon("death");
  _id_2BDF748326F9F18C = [];

  foreach(player in level.players) {
    _id_1343B4F7FFC07B98 = player _id_7EF95BBA57DC4B82::hasequipment(type) && player _id_7EF95BBA57DC4B82::getequipmentammo(type) >= player _id_7EF95BBA57DC4B82::getequipmentmaxammo(type);

    if(_id_1343B4F7FFC07B98) {
      _id_B1AD25AD91B2627D disableplayeruse(player);
      continue;
    }

    _id_2BDF748326F9F18C = scripts\engine\utility::array_add(_id_2BDF748326F9F18C, player);
  }

  for(;;) {
    _id_C32DCE49091803F5 = [];

    foreach(player in level.players) {
      _id_1343B4F7FFC07B98 = player _id_7EF95BBA57DC4B82::hasequipment(type) && player _id_7EF95BBA57DC4B82::getequipmentammo(type) >= player _id_7EF95BBA57DC4B82::getequipmentmaxammo(type);

      if(_id_1343B4F7FFC07B98) {
        if(scripts\engine\utility::array_contains(_id_2BDF748326F9F18C, player))
          _id_B1AD25AD91B2627D disableplayeruse(player);

        continue;
      }

      if(!scripts\engine\utility::array_contains(_id_2BDF748326F9F18C, player))
        _id_B1AD25AD91B2627D enableplayeruse(player);

      _id_C32DCE49091803F5 = scripts\engine\utility::array_add(_id_C32DCE49091803F5, player);
    }

    _id_2BDF748326F9F18C = _id_C32DCE49091803F5;
    wait 0.1;
  }
}

script_model_spawn_and_use(origin, angles, _id_45CFCB352A9B4A37, boxmodel, hintstring, headicon, _id_EC2D1026AD0C63AD, _id_4EA123D69D1C0EB9) {
  _id_B1AD25AD91B2627D = spawn("script_model", origin);

  if(isDefined(angles))
    _id_B1AD25AD91B2627D.angles = angles;
  else
    _id_B1AD25AD91B2627D.angles = (0, 0, 0);

  if(isDefined(boxmodel)) {
    if(isstring(boxmodel))
      _id_B1AD25AD91B2627D setModel(boxmodel);
    else if(isstruct(boxmodel) && isDefined(boxmodel.target))
      _id_B1AD25AD91B2627D.ent_model = getEnt(boxmodel.target, "targetname");
  }

  scripts\cp\cp_outline_utility::outlineenableforall(_id_B1AD25AD91B2627D, "outline_depth_white", "equipment");

  if(isDefined(headicon)) {
    _id_B1AD25AD91B2627D.headicon = thread scripts\cp\utility::ent_createheadicon(_id_B1AD25AD91B2627D, 15, "allies", headicon, 1);
    setheadiconmaxdistance(_id_B1AD25AD91B2627D.headicon, 1500);
    setheadiconnaturaldistance(_id_B1AD25AD91B2627D.headicon, 15);
  }

  _id_B1AD25AD91B2627D makeusable();
  _id_B1AD25AD91B2627D _meth_DFB78B3E724AD620(1);
  _id_B1AD25AD91B2627D setCursorHint("HINT_BUTTON");
  _id_B1AD25AD91B2627D sethintdisplayrange(200);
  _id_B1AD25AD91B2627D sethintdisplayfov(45);
  _id_B1AD25AD91B2627D setuserange(100);
  _id_B1AD25AD91B2627D setusefov(40);
  _id_B1AD25AD91B2627D sethintonobstruction("show");
  _id_B1AD25AD91B2627D setuseholdduration("duration_none");

  if(isDefined(hintstring))
    _id_B1AD25AD91B2627D setHintString(hintstring);

  _id_B1AD25AD91B2627D.isused = 0;
  level._id_B5C99DB9E41E8EF8 = scripts\engine\utility::array_add_safe(level._id_B5C99DB9E41E8EF8, _id_B1AD25AD91B2627D);

  if(isDefined(_id_EC2D1026AD0C63AD))
    thread[[_id_EC2D1026AD0C63AD]](_id_B1AD25AD91B2627D);

  thread script_model_spawn_and_use_logic(_id_B1AD25AD91B2627D, _id_45CFCB352A9B4A37, _id_4EA123D69D1C0EB9);
  return _id_B1AD25AD91B2627D;
}

script_model_spawn_and_use_logic(_id_B1AD25AD91B2627D, _id_45CFCB352A9B4A37, _id_4EA123D69D1C0EB9) {
  _id_B1AD25AD91B2627D endon("entitydeleted");

  for(;;) {
    _id_B1AD25AD91B2627D waittill("trigger", _id_6DFB045EE2B42AAD);

    if(!isPlayer(_id_6DFB045EE2B42AAD)) {
      continue;
    }
    if(isDefined(_id_45CFCB352A9B4A37))
      thread[[_id_45CFCB352A9B4A37]](_id_B1AD25AD91B2627D, _id_6DFB045EE2B42AAD);

    if(istrue(_id_4EA123D69D1C0EB9) && istrue(_id_B1AD25AD91B2627D.isused)) {
      if(isDefined(_id_B1AD25AD91B2627D.ent_model)) {
        _id_B1AD25AD91B2627D.ent_model delete();
        wait 0.05;
      }

      _id_B1AD25AD91B2627D delete();
      break;
    }
  }
}

support_box_spawn(origin, angles, _id_45CFCB352A9B4A37, _id_3474B4E818850C46, hintstring, headicon, _id_29CAD18B7B5A8BD0, _id_9A999C2EF8CE6CBF, _id_166611133C8F7524, _id_F7848454BCD0D7AA) {
  _id_B1AD25AD91B2627D = spawn("script_model", origin);
  _id_B1AD25AD91B2627D.angles = angles;

  if(isDefined(_id_3474B4E818850C46))
    _id_B1AD25AD91B2627D setModel(_id_3474B4E818850C46);
  else
    _id_B1AD25AD91B2627D setModel("offhand_wm_supportbox");

  support_box_make_entity_usable(_id_B1AD25AD91B2627D);
  thread support_box_use_logic(_id_B1AD25AD91B2627D, _id_45CFCB352A9B4A37, _id_166611133C8F7524);
  thread support_box_update_hint_logic(_id_B1AD25AD91B2627D, hintstring, headicon, _id_29CAD18B7B5A8BD0, _id_9A999C2EF8CE6CBF, _id_F7848454BCD0D7AA);
  return _id_B1AD25AD91B2627D;
}

support_box_make_entity_usable(entity) {
  entity makeusable();
  entity _meth_DFB78B3E724AD620(1);
  entity setCursorHint("HINT_NOICON");
  entity sethintdisplayrange(256);
  entity setuserange(84);
  entity setusefov(180);
  entity sethintdisplayfov(180);
  entity sethintonobstruction("show");
  entity setuseholdduration("duration_short");
  entity sethintrequiresholding(0);
  entity setusepriority(0);
}

support_box_use_logic(_id_B1AD25AD91B2627D, _id_45CFCB352A9B4A37, _id_166611133C8F7524) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  _id_9CDA4693FBC64277 = 0;

  for(;;) {
    _id_B1AD25AD91B2627D waittill("trigger", _id_6DFB045EE2B42AAD);

    if(!isPlayer(_id_6DFB045EE2B42AAD)) {
      continue;
    }
    thread[[_id_45CFCB352A9B4A37]](_id_B1AD25AD91B2627D, _id_6DFB045EE2B42AAD);

    if(support_box_is_scriptable_model(_id_B1AD25AD91B2627D.model)) {
      _id_B1AD25AD91B2627D setscriptablepartstate("anims", "open_no_pause", 0);
      wait(support_box_get_open_anim_length());
      _id_B1AD25AD91B2627D setscriptablepartstate("anims", "close_no_pause", 0);
      wait(support_box_get_close_anim_length());
    }

    _id_9CDA4693FBC64277++;

    if(isDefined(_id_166611133C8F7524) && _id_9CDA4693FBC64277 >= _id_166611133C8F7524)
      _id_B1AD25AD91B2627D delete();
  }
}

#using_animtree("scriptables");

support_box_get_open_anim_length() {
  return getanimlength(%wm_supportbox_ground_open);
}

support_box_get_close_anim_length() {
  return getanimlength(%wm_supportbox_ground_close);
}

support_box_is_scriptable_model(modelname) {
  if(modelname == "offhand_wm_supportbox")
    return 1;

  if(modelname == "offhand_wm_supportbox_ammunition")
    return 1;

  if(modelname == "offhand_wm_supportbox_explosives")
    return 1;

  return 0;
}

support_box_update_hint_logic(_id_B1AD25AD91B2627D, hintstring, headicon, _id_29CAD18B7B5A8BD0, _id_9A999C2EF8CE6CBF, _id_F7848454BCD0D7AA) {
  _id_B1AD25AD91B2627D endon("entitydeleted");

  if(!isDefined(_id_F7848454BCD0D7AA))
    _id_F7848454BCD0D7AA = &"COOP_GAME_PLAY/AMMO_MAX_RED";

  _id_B1AD25AD91B2627D setHintString(hintstring);
  _id_0CE91B3BEFD99F4D = spawn("script_origin", _id_B1AD25AD91B2627D.origin);
  support_box_make_entity_usable(_id_0CE91B3BEFD99F4D);
  _id_0CE91B3BEFD99F4D setHintString(_id_F7848454BCD0D7AA);
  _id_B1AD25AD91B2627D.headiconid = scripts\cp\utility::ent_createheadicon(_id_B1AD25AD91B2627D, 15, "allies", headicon, 1);
  setheadiconmaxdistance(_id_B1AD25AD91B2627D.headiconid, 1500);
  setheadiconnaturaldistance(_id_B1AD25AD91B2627D.headiconid, 15);
  _id_EC5983A2C8991A18 = _id_B1AD25AD91B2627D getentitynumber();
  _id_B291FA39EF7C3A62 = 0.1;

  for(;;) {
    foreach(player in level.players) {
      if(!isDefined(player.supportboxmaxammo))
        player.supportboxmaxammo = [];

      if(_id_467F0FDFDD155A45::gamealreadyended()) {
        foreach(player in level.players) {
          removeclientfromheadiconmask(_id_B1AD25AD91B2627D.headiconid, player);
          return 1;
        }
      }

      _id_68756F14D1F443DE = !isDefined(player.supportboxmaxammo[_id_EC5983A2C8991A18]) || !player.supportboxmaxammo[_id_EC5983A2C8991A18];
      _id_E035DAA502312B39 = !isDefined(player.supportboxmaxammo[_id_EC5983A2C8991A18]) || player.supportboxmaxammo[_id_EC5983A2C8991A18];

      if(_id_68756F14D1F443DE && [[_id_9A999C2EF8CE6CBF]](player)) {
        player notify("support_box_update_player" + _id_EC5983A2C8991A18);
        removeclientfromheadiconmask(_id_B1AD25AD91B2627D.headiconid, player);
        _id_B1AD25AD91B2627D disableplayeruse(player);
        childthread support_box_delay_max_ammo_hint(player, _id_B1AD25AD91B2627D, _id_0CE91B3BEFD99F4D, _id_EC5983A2C8991A18);
        player.supportboxmaxammo[_id_B1AD25AD91B2627D getentitynumber()] = 1;
        continue;
      }

      if(_id_E035DAA502312B39 && ![[_id_9A999C2EF8CE6CBF]](player)) {
        player notify("support_box_update_player" + _id_EC5983A2C8991A18);
        addclienttoheadiconmask(_id_B1AD25AD91B2627D.headiconid, player);
        _id_B1AD25AD91B2627D enableplayeruse(player);
        _id_0CE91B3BEFD99F4D disableplayeruse(player);
        player.supportboxmaxammo[_id_B1AD25AD91B2627D getentitynumber()] = 0;
      }
    }

    wait(_id_B291FA39EF7C3A62);
  }
}

support_box_delay_max_ammo_hint(player, _id_B1AD25AD91B2627D, _id_0CE91B3BEFD99F4D, _id_EC5983A2C8991A18) {
  player endon("support_box_update_player" + _id_EC5983A2C8991A18);
  wait 2.0;
  _id_0CE91B3BEFD99F4D enableplayeruse(player);
}

_id_CD5D33E1011B0B9D() {
  if(isDefined(level._id_CD5D33E1011B0B9D)) {
    return;
  }
  level._id_CD5D33E1011B0B9D = 1;
  molotovs = scripts\engine\utility::getStructArray("molotov_pickup", "targetname");
  grenades = scripts\engine\utility::getStructArray("semtex_pickup", "targetname");
  c4s = scripts\engine\utility::getStructArray("c4_pickup", "targetname");
  _id_DB515C2CA5561EFA = scripts\engine\utility::getStructArray("self_revive_pickup", "targetname");

  foreach(molotov in molotovs) {
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdropinfo(molotov.origin, (0, 0, 0));
    _id_CD9D13143E83EEC9 = "brloot_offhand_molotov";
    item = _id_66122A002AFF5D57::spawnpickup(_id_CD9D13143E83EEC9, _id_06FE80416B4BE165, 4, undefined, undefined, 0);
    waitframe();
  }

  foreach(grenade in grenades) {
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdropinfo(grenade.origin, (0, 0, 0));
    _id_CD9D13143E83EEC9 = "brloot_offhand_semtex";
    item = _id_66122A002AFF5D57::spawnpickup(_id_CD9D13143E83EEC9, _id_06FE80416B4BE165, 4, undefined, undefined, 0);
    waitframe();
  }

  foreach(c4 in c4s) {
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdropinfo(c4.origin, c4.angles + (0, 0, -90));
    _id_CD9D13143E83EEC9 = "brloot_offhand_c4";
    item = _id_66122A002AFF5D57::spawnpickup(_id_CD9D13143E83EEC9, _id_06FE80416B4BE165, 4, undefined, undefined, 0);
    waitframe();
  }

  foreach(_id_E751C7771E6A1E5C in _id_DB515C2CA5561EFA) {
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdropinfo(_id_E751C7771E6A1E5C.origin, _id_E751C7771E6A1E5C.angles);
    _id_CD9D13143E83EEC9 = "brloot_self_revive";
    item = _id_66122A002AFF5D57::spawnpickup(_id_CD9D13143E83EEC9, _id_06FE80416B4BE165, 1, 1);
  }
}

_id_ED39B08FB6EE314A() {
  level thread _id_94D1CE6F91AAE06A("ar_charlie2_model");
  level thread _id_94D1CE6F91AAE06A("ar_kilo_model");
  level thread _id_94D1CE6F91AAE06A("ar_sierra_model");
  level thread _id_94D1CE6F91AAE06A("ar_charlie1_model");
  level thread _id_94D1CE6F91AAE06A("ar_mike_model");
  level thread _id_94D1CE6F91AAE06A("ar_mike14_model");
  level thread _id_94D1CE6F91AAE06A("sn_mike_model");
  level thread _id_94D1CE6F91AAE06A("sm_augolf_model");
  level thread _id_94D1CE6F91AAE06A("sh_mike_model");
  level thread _id_94D1CE6F91AAE06A("sm_beta_model");
  level thread _id_94D1CE6F91AAE06A("sm_papa_model");
  level thread _id_94D1CE6F91AAE06A("sn_alpha_model");
  level thread _id_94D1CE6F91AAE06A("start_offhand_struct");
  _id_D5ECF70A4D407B43 = scripts\engine\utility::getStructArray("start_offhand_struct", "targetname");

  if(_id_D5ECF70A4D407B43.size > 0) {
    _id_95DBA307F63D1F10 = getentarrayinradius("script_model", "code_classname", _id_D5ECF70A4D407B43[0].origin, 600);

    if(isDefined(_id_95DBA307F63D1F10) && _id_95DBA307F63D1F10.size > 0) {
      foreach(ent in _id_95DBA307F63D1F10)
      ent delete();
    }
  }

  if(isDefined(level._id_B5C99DB9E41E8EF8)) {
    foreach(entity in level._id_B5C99DB9E41E8EF8) {
      if(isent(entity)) {
        if(isent(entity.ent_model))
          entity.ent_model delete();

        entity delete();
      }
    }
  }
}

_id_94D1CE6F91AAE06A(name) {
  _id_3287B58AE2B03D50 = scripts\engine\utility::getStructArray(name, "targetname");

  foreach(_id_DB1C9BA21F529D03 in _id_3287B58AE2B03D50) {
    if(isDefined(_id_DB1C9BA21F529D03.target)) {
      model = getEnt(_id_DB1C9BA21F529D03.target, "targetname");

      if(isent(model))
        model delete();
    }
  }
}

_id_775CD164C569E279(alias, delay) {
  level endon("game_ended");

  if(isDefined(delay))
    wait(delay);

  while(istrue(level._id_7BCA58EBC45C1D47) || istrue(level.isteamvoplaying))
    waitframe();

  level._id_BFE5BB3BA83502E3 = 1;
  wait 0.1;

  foreach(player in level.players)
  player.bcdisabled = 1;

  level _id_166B4F052DA169A7::try_to_play_vo_on_team(alias, "allies");

  foreach(player in level.players)
  player.bcdisabled = undefined;

  level._id_BFE5BB3BA83502E3 = 0;
}

_id_CB272B35D348BA04(button, _id_29497B9188AEED3A, _id_BD901692981B143A, arm) {
  level endon("game_ended");
  button endon("death");
  _id_8091A29AB763E925(0, _id_29497B9188AEED3A.origin, 256);
  _id_BD901692981B143A hide();
  _id_BD901692981B143A notsolid();
  _id_2D80C6F5B8E4F153 = spawnStruct();
  _id_2D80C6F5B8E4F153._id_BD901692981B143A = _id_BD901692981B143A;
  _id_2D80C6F5B8E4F153.arm = arm;
  _id_2D80C6F5B8E4F153.button = button;
  _id_2D80C6F5B8E4F153._id_E60552DD6ABCC4AA = 1;
  level thread _id_206BA22E089C099B(_id_2D80C6F5B8E4F153, _id_29497B9188AEED3A);
  return _id_2D80C6F5B8E4F153;
}

_id_206BA22E089C099B(_id_2D80C6F5B8E4F153, _id_29497B9188AEED3A) {
  level endon("game_ended");
  _id_2D80C6F5B8E4F153.button endon("death");
  button = _id_2D80C6F5B8E4F153.button;

  for(;;) {
    button waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    button _meth_DFB78B3E724AD620(0);
    _id_8091A29AB763E925(1, _id_29497B9188AEED3A.origin, 256);
    _id_2D80C6F5B8E4F153._id_BD901692981B143A show();
    button delete();
  }
}

_id_2191D00EC620E904(_id_CA6C977557F7F7D8, arm) {
  _id_D28E92484F3D9482 = scripts\engine\utility::getStruct("ascender_marker_" + _id_CA6C977557F7F7D8, "script_noteworthy");
  _id_BD901692981B143A = getEnt("ascender_cable_" + _id_CA6C977557F7F7D8, "script_noteworthy");

  if(isDefined(arm))
    arm delete();

  _id_8091A29AB763E925(0, _id_D28E92484F3D9482.origin, 256);
  _id_BD901692981B143A hide();
  _id_AC1C2BCAE6979F5C = getEnt("gauntlet_dest_" + _id_CA6C977557F7F7D8, "script_noteworthy");

  if(isDefined(_id_AC1C2BCAE6979F5C))
    _id_AC1C2BCAE6979F5C delete();
}

_id_8091A29AB763E925(_id_41D8BF229CF29051, locationorigin, radius) {
  if(!isDefined(radius))
    radius = 128;

  _id_5C93411D5E143956 = getentitylessscriptablearray("elevator_ascend_start", "targetname");
  _id_DD156FF0EEBD118E = getentitylessscriptablearray("elevator_descend_start", "targetname");
  _id_B82724CDD7191C5C = scripts\cp\utility::array_merge(_id_5C93411D5E143956, _id_DD156FF0EEBD118E);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B82724CDD7191C5C.size; _id_AC0E594AC96AA3A8++) {
    if(distance2d(_id_B82724CDD7191C5C[_id_AC0E594AC96AA3A8].origin, locationorigin) <= radius)
      _id_F1BB8A269D750F18(_id_41D8BF229CF29051, _id_B82724CDD7191C5C[_id_AC0E594AC96AA3A8]);
  }
}

_id_F1BB8A269D750F18(_id_41D8BF229CF29051, scriptable) {
  if(istrue(_id_41D8BF229CF29051)) {
    foreach(player in level.players)
    scriptable enablescriptableplayeruse(player);
  } else {
    foreach(player in level.players)
    scriptable disablescriptableplayeruse(player);
  }
}

_id_26198B4BB49A3DF5(_id_921B9D1AB6394420) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  radius = 600;

  if(isDefined(self.radius))
    radius = self.radius * 3;

  if(isDefined(_id_921B9D1AB6394420))
    radius = _id_921B9D1AB6394420;

  distsq = radius * radius;
  _id_E30532966BDAECB9 = 0;

  for(;;) {
    if(_id_E30532966BDAECB9 == 0)
      wait 1.5;
    else
      wait 0.5;

    _id_E30532966BDAECB9 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(level.players[_id_AC0E594AC96AA3A8])) {
        continue;
      }
      if(distancesquared(level.players[_id_AC0E594AC96AA3A8].origin, self.origin) < distsq) {
        level.players[_id_AC0E594AC96AA3A8] notify("show_hud_near_objective");
        _id_E30532966BDAECB9 = _id_E30532966BDAECB9 + 1;
      }
    }
  }
}

_id_6AE8E5D7C480EF7D() {
  foreach(player in level.players)
  player notify("show_hud_near_objective");
}

_id_42D99448ADF8163A() {
  level endon("game_ended");
  _id_F62471988A47C163 = scripts\engine\utility::getStructArray("ammo_depot", "script_noteworthy");

  foreach(_id_FB7C65E67A8EED31 in _id_F62471988A47C163) {
    _id_7C6196E38B928886 = spawn("script_model", _id_FB7C65E67A8EED31.origin);
    _id_7C6196E38B928886.angles = scripts\engine\utility::ter_op(isDefined(_id_FB7C65E67A8EED31.angles), _id_FB7C65E67A8EED31.angles, (0, 0, 0));
    _id_7C6196E38B928886 setModel("military_ammo_restock_location_solid");
  }
}

_id_560360BA45CB3607() {
  self endon("death");
  _id_9A194154F62D1BDC = self;
  hintstring = &"EQUIPMENT_HINTS/SUPPORT_BOX_USE";
  _id_9A194154F62D1BDC scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, hintstring, 25, "duration_short", "show", 256, 256, 128, 256);
  _id_9A194154F62D1BDC _meth_DFB78B3E724AD620(1);

  for(;;) {
    _id_9A194154F62D1BDC _meth_DFB78B3E724AD620(1);
    _id_9A194154F62D1BDC waittill("trigger", player);

    if(!isPlayer(player) || !isalive(player)) {
      continue;
    }
    _id_9A194154F62D1BDC _meth_DFB78B3E724AD620(0);
    _id_BC9DA38A4BAB4CE2 = player getweaponslistprimaries();
    _id_1CD29382D1867470 = player _id_07C40FA80892A721::_id_0600F6CF462E983F();

    if(_id_1CD29382D1867470 < 8)
      player _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(8 - _id_1CD29382D1867470);

    _id_BC002676438672C9 = player _id_7EF95BBA57DC4B82::getcurrentequipment("primary");
    _id_2AEE5A9B1A165F09 = player _id_7EF95BBA57DC4B82::getcurrentequipment("secondary");
    player _id_7EF95BBA57DC4B82::setequipmentammo(_id_BC002676438672C9, 4);
    player _id_7EF95BBA57DC4B82::setequipmentammo(_id_2AEE5A9B1A165F09, 4);

    foreach(weapon in _id_BC9DA38A4BAB4CE2) {
      if(weapon.basename != "iw8_la_gromeo_mp" && weapon.basename != "iw9_la_gromeo_mp")
        player _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(weapon);
    }

    player playlocalsound("weap_ammo_pickup");
    player thread _id_354C862768CFE202::hudicontype("ammobox");
  }
}

_id_EA91746731D2AC2D() {
  level endon("game_ended");
  _id_30AB6942C287EEDA = scripts\engine\utility::getStructArray("beacon_fx", "targetname");

  foreach(beacon in _id_30AB6942C287EEDA)
  playFX(level._effect["vfx_ammo_beacon"], beacon.origin);
}

_id_144575F3C7764455(_id_8F155C2FA27332FE) {
  level endon("game_ended");
  level endon("stop_monitoring_party_wipes");

  for(;;) {
    if(_id_7DF2F29BD73C561C()) {
      wait 3;
      [[_id_8F155C2FA27332FE]]();
      wait 1;
    }

    wait 1;
  }
}

_id_7DF2F29BD73C561C() {
  foreach(player in level.players) {
    if(player isspectatingplayer())
      continue;
    else if(istrue(player._id_6F037E24E1D55A69))
      continue;
    else if(istrue(player.isselfreviving))
      return 0;
    else if(player _id_0AFB7E332AEE4BF2::hasselfrevivetoken())
      return 0;
    else if(isalive(player) && !_id_0AFB7E332AEE4BF2::player_in_laststand(player))
      return 0;
    else if(istrue(player.gettingupfromlaststand))
      return 0;
  }

  return 1;
}

_id_0D9A83DC4D06E2F7(_id_47E569777F8BB300) {
  return 0;
}

_id_EDCE93CF6B7199A0(_id_47E569777F8BB300) {
  return 0;
}

_id_C713EB7F9FE5D6FA() {
  level._effect["venom_gas"] = loadfx("vfx/iw8_cp/vfx_cp_venom_gas_cloud.vfx");
  level._effect["venom_gas_burst"] = loadfx("vfx/iw9/cp/vfx_cp_venom_gas_burst.vfx");
  level._effect["gas_cloud"] = loadfx("vfx/iw9/cp/raid/vfx_cp_raid_gas_cloud.vfx");
  level._effect["gas_cloud_burst"] = loadfx("vfx/iw9/cp/raid/vfx_cp_raid_gas_burst.vfx");
}

_id_8D22FF3DA7E116C2(_id_E6B5BE9B68DC62DC, _id_B95E652069A508F0, _id_519A7C618B018AC7, _id_C799AC677C489061) {
  _id_E531ADBE1391F033 = _id_E6B5BE9B68DC62DC[0];
  _id_E531ACBE1391EE00 = _id_E6B5BE9B68DC62DC[1];
  _id_688F97559BF04D6A = _id_B95E652069A508F0[0];
  _id_688F98559BF04F9D = _id_B95E652069A508F0[1];
  _id_1B11EAA9B42E5081 = _id_E531ADBE1391F033;
  _id_639828DC8BAC6376 = _id_E6B5BE9B68DC62DC[2];
  _id_8CE0A75736B91DC3 = scripts\engine\utility::ter_op(isDefined(_id_519A7C618B018AC7), _id_519A7C618B018AC7, 500);
  _id_32C3DCF6B07B1024 = 0;
  _id_80A324EB12EEF2CC = [];

  while(!istrue(_id_32C3DCF6B07B1024)) {
    if(!isDefined(_id_C799AC677C489061) || !_id_C799AC677C489061 _meth_DBAD28172D90C1AA((_id_E531ADBE1391F033, _id_E531ACBE1391EE00, _id_639828DC8BAC6376))) {
      _id_F4DE64E7E1762529 = spawnStruct();
      _id_F4DE64E7E1762529.origin = (_id_E531ADBE1391F033, _id_E531ACBE1391EE00, _id_639828DC8BAC6376);
      _id_F4DE64E7E1762529.angles = (0, 0, 0);
      _id_80A324EB12EEF2CC[_id_80A324EB12EEF2CC.size] = _id_F4DE64E7E1762529;
    }

    _id_E531ADBE1391F033 = _id_E531ADBE1391F033 + _id_8CE0A75736B91DC3;

    if(_id_E531ADBE1391F033 > _id_688F97559BF04D6A) {
      _id_E531ADBE1391F033 = _id_1B11EAA9B42E5081;
      _id_E531ACBE1391EE00 = _id_E531ACBE1391EE00 + _id_8CE0A75736B91DC3;

      if(_id_E531ACBE1391EE00 > _id_688F98559BF04F9D)
        _id_32C3DCF6B07B1024 = 1;
    }
  }

  return _id_80A324EB12EEF2CC;
}

_id_DC89DF631AF8F890(_id_80A324EB12EEF2CC, _id_41D8BF229CF29051) {
  foreach(spout in _id_80A324EB12EEF2CC) {
    if(istrue(_id_41D8BF229CF29051)) {
      level thread _id_44DAE21D9375E428(spout);
      continue;
    }

    level thread _id_7A7BD41DA08566BC(spout);
  }
}

_id_44DAE21D9375E428(_id_164DB7990FA7C15F) {
  _id_164DB7990FA7C15F.gas_fx = spawnfx(level._effect["gas_cloud"], _id_164DB7990FA7C15F.origin, anglesToForward(_id_164DB7990FA7C15F.angles), anglestoup(_id_164DB7990FA7C15F.angles));
  waitframe();
  triggerfx(_id_164DB7990FA7C15F.gas_fx);
}

_id_7A7BD41DA08566BC(_id_164DB7990FA7C15F) {
  playFX(level._effect["gas_cloud_burst"], _id_164DB7990FA7C15F.origin);

  if(isDefined(_id_164DB7990FA7C15F.gas_fx))
    _id_164DB7990FA7C15F.gas_fx delete();
}

_id_55A28F2BA806FE97(_id_864EB3B7A12480A4) {
  _id_526D28D8642C8C69 = getEntArray(_id_864EB3B7A12480A4, "targetname");
  scripts\engine\utility::array_thread(_id_526D28D8642C8C69, ::_id_06124BF07A461862);
}

_id_08FF8C8BD1F7AA28(_id_864EB3B7A12480A4) {
  _id_526D28D8642C8C69 = getEntArray(_id_864EB3B7A12480A4, "targetname");
  scripts\engine\utility::array_thread(_id_526D28D8642C8C69, ::_id_FAAB0B58CC29D628);
}

_id_FAAB0B58CC29D628() {
  level endon("game_ended");
  self endon("death");
  level endon("traversal_section_done");
  self notify("single_teamwiderespawn_trigger_think");
  self endon("single_teamwiderespawn_trigger_think");

  for(;;) {
    _id_73F81ABE44F5F790 = 0;

    foreach(player in level.players) {
      if(player istouching(self))
        _id_73F81ABE44F5F790++;
    }

    if(_id_73F81ABE44F5F790 < level.players.size) {
      waitframe();
      continue;
    }

    if(isDefined(self.script_flag) && !istrue(self._id_7E1CE2368ABCA1E3)) {
      self._id_7E1CE2368ABCA1E3 = 1;
      level notify(self.script_flag + "_first_contact");
    }

    foreach(player in level.players)
    _id_2DEE3569A5212D86(player, self);

    waitframe();
  }
}

_id_06124BF07A461862() {
  level endon("game_ended");
  self endon("death");
  level endon("traversal_section_done");
  self notify("single_respawn_trigger_think");
  self endon("single_respawn_trigger_think");

  if(!isDefined(level.player_respawn))
    level.player_respawn = [];

  if(isDefined(self.target)) {
    _id_45D3B6C15EAA8FE0 = scripts\engine\utility::getStructArray(self.target, "targetname");

    if(_id_45D3B6C15EAA8FE0.size > 0) {
      self._id_45D3B6C15EAA8FE0 = [];

      foreach(playerspawn in _id_45D3B6C15EAA8FE0)
      self._id_45D3B6C15EAA8FE0[self._id_45D3B6C15EAA8FE0.size] = playerspawn;
    }
  }

  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(isDefined(self.script_flag) && !istrue(self._id_7E1CE2368ABCA1E3)) {
      self._id_7E1CE2368ABCA1E3 = 1;
      level notify(self.script_flag + "_first_contact", player);
    }

    _id_2DEE3569A5212D86(player, self);
    waitframe();
  }
}

_id_2DEE3569A5212D86(player, trigger) {
  if(!isDefined(player.respawn_index)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      if(player == level.players[_id_AC0E594AC96AA3A8])
        player.respawn_index = _id_AC0E594AC96AA3A8;
    }
  }

  if(!isDefined(level.player_respawn))
    level.player_respawn = [];

  _id_107986DB0C363856 = trigger;
  index = player getentitynumber();

  if(isDefined(self._id_45D3B6C15EAA8FE0) && isDefined(self._id_45D3B6C15EAA8FE0[index]))
    _id_107986DB0C363856 = self._id_45D3B6C15EAA8FE0[index];

  if(!isDefined(level.player_respawn[player.respawn_index]))
    level.player_respawn[player.respawn_index] = _id_107986DB0C363856;
  else if(level.player_respawn.size <= 0 || level.player_respawn[player.respawn_index] != _id_107986DB0C363856) {
    player thread set_respawn_loc_delayed(_id_107986DB0C363856);
    player thread _id_145422ED1340DE8B(player);
  }
}

_id_145422ED1340DE8B(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  result = player scripts\engine\utility::waittill_any_timeout_1(4, "new_respawn_loc");

  if(isDefined(result) && result == "new_respawn_loc")
    player scripts\cp\utility::allow_player_basejumping(0, "watch_for_parachute_removal_if_set_traversal_respawn_loc");
}

set_respawn_loc_delayed(loc) {
  level endon("game_ended");
  level endon("traversal_section_done");
  self endon("new_respawn_loc");
  self endon("death_or_disconnect");
  wait 3;

  if(isalive(self)) {
    if(!isDefined(self.respawn_index)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
        if(self == level.players[_id_AC0E594AC96AA3A8])
          self.respawn_index = _id_AC0E594AC96AA3A8;
      }
    }

    level.player_respawn[self.respawn_index] = loc;
    _id_E0CBA2B0A5510D09 = level.player_respawn[self.respawn_index];
    self.forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
    self.forcespawnangles = self getplayerangles(1);
    self notify("new_respawn_loc");
  }
}

_id_B5361C8E7CB7A909(downed_player) {
  _id_E0CBA2B0A5510D09 = level.player_respawn[downed_player.respawn_index];
  downed_player.respawn_forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
  downed_player.respawn_forcespawnangles = downed_player getplayerangles(1);
  downed_player.forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
  downed_player.forcespawnangles = downed_player getplayerangles(1);
  timer = 5;
  _id_19F0135BD917C05D = getdvarint("dvar_B4B6597A66C1EC75", 0);

  if(_id_19F0135BD917C05D != 0)
    timer = _id_19F0135BD917C05D;

  wait(timer);

  foreach(key, value in downed_player.br_ammo)
  downed_player.br_ammo[key] = 0;

  downed_player _id_0AFB7E332AEE4BF2::instant_revive(downed_player);
  downed_player notify("last_stand_finished");
}

_id_1A477014CE8F4CE2(_id_EF4E676FC377AFBB) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  triggers = getEntArray(_id_EF4E676FC377AFBB, "script_noteworthy");

  if(!isDefined(level._id_F7EE94896E500409))
    level._id_F7EE94896E500409 = [];

  foreach(trigger in triggers) {
    if(isDefined(trigger.targetname)) {
      if(!isDefined(trigger.script_flag)) {
        level thread _id_13BC4E14B476CB22(trigger);
        continue;
      }

      if(isDefined(trigger.script_flag) && trigger.script_flag == "hard_mode" && scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
        level thread _id_13BC4E14B476CB22(trigger);
    }
  }
}

_id_13BC4E14B476CB22(_id_F9CE4EE3950DD8CF) {
  _id_B8C12A18F2D34763 = strtok(_id_F9CE4EE3950DD8CF.targetname, ",");
  groupname = _id_B8C12A18F2D34763[0];
  _id_5652480FA5097F6B = 0;
  _id_BC68E8E5F4C4F28D = 1;

  if(_id_B8C12A18F2D34763.size >= 3) {
    _id_5652480FA5097F6B = int(_id_B8C12A18F2D34763[1]);
    _id_BC68E8E5F4C4F28D = int(_id_B8C12A18F2D34763[2]);
  }

  _id_F9CE4EE3950DD8CF._id_B29D63D5BCEF6670 = _id_5652480FA5097F6B;
  _id_DCAA4378BA2F134C = scripts\engine\utility::getStructArray(groupname, "targetname").size;
  total_spawns = _id_BC68E8E5F4C4F28D * _id_DCAA4378BA2F134C;
  _id_18A73A64992DD07D::registerambientgroup(groupname, ::_id_546162DEBB4FD1B0, ::_id_546162DEBB4FD1B0, total_spawns, 0.1, undefined, groupname);

  if(isDefined(_id_F9CE4EE3950DD8CF.script_parameters)) {
    if(isDefined(level._id_F7EE94896E500409[_id_F9CE4EE3950DD8CF.script_parameters]))
      _id_18A73A64992DD07D::register_module_ai_spawn_func(groupname, level._id_F7EE94896E500409[_id_F9CE4EE3950DD8CF.script_parameters]);
    else {
      switch (_id_F9CE4EE3950DD8CF.script_parameters) {
        case "stealth_patrol":
          if(isDefined(level._id_AAF6515899A6735D))
            _id_18A73A64992DD07D::register_module_ai_spawn_func(groupname, level._id_AAF6515899A6735D);

          break;
        case "notify_on_spawn":
          _id_18A73A64992DD07D::register_module_ai_spawn_func(groupname, ::_id_0ED6A0DA2250366F);
        default:
          break;
      }
    }
  }

  if(getdvarint("dvar_F0F10B52A800D290", 0) > 0) {
    return;
  }
  _id_77104DAE551BE48A = getEnt(groupname + "_abort", "script_noteworthy");
  level thread _id_E811D2F54D1F37E4(_id_F9CE4EE3950DD8CF, groupname);

  if(isDefined(_id_77104DAE551BE48A))
    level thread _id_976823B9E5A0AA81(_id_77104DAE551BE48A, groupname);
}

_id_F331637729C41AA1(_id_6D7158C155532C9D, _id_D0E49134703DA0D5) {
  if(!isDefined(level._id_F7EE94896E500409))
    level._id_F7EE94896E500409 = [];

  level._id_F7EE94896E500409[_id_6D7158C155532C9D] = _id_D0E49134703DA0D5;
}

_id_0ED6A0DA2250366F(groupname) {
  level notify(groupname.group_name);
}

_id_976823B9E5A0AA81(_id_77104DAE551BE48A, groupname) {
  level endon("game_ended");

  for(;;) {
    _id_77104DAE551BE48A waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    _id_18A73A64992DD07D::stop_module_by_groupname(groupname);
  }
}

_id_E811D2F54D1F37E4(trigger, groupname) {
  level endon("game_ended");
  level endon(groupname);
  trigger endon("death");

  if(!isDefined(trigger)) {
    return;
  }
  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(isDefined(trigger._id_B29D63D5BCEF6670))
      wait(trigger._id_B29D63D5BCEF6670);

    _id_18A73A64992DD07D::run_spawn_module(groupname);
    return;
  }
}

_id_546162DEBB4FD1B0(_id_F8E5E3AA5762A8E7) {
  spawners = scripts\engine\utility::getStructArray(_id_F8E5E3AA5762A8E7.group_name, "targetname");

  if(isDefined(spawners))
    return spawners.size;
  else
    return 0;
}