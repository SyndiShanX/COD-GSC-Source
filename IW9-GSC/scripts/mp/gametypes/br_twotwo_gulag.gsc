/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_twotwo_gulag.gsc
****************************************************/

#using_animtree("script_model");

_id_B7A198C3929006D7() {
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("prepGulagArena", ::_id_F4AC4C4F63924776);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("startGulagSequence", ::_id_8739234FFE5B08F5);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagKeyAcquired", ::_id_B5EC51AC542C7638);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("canPlayerSpectateGulag", ::_id_BB22CAE6DD0B7899);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("shouldPlayerSpectateGulag", ::_id_1A16AE715C7D1D44);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagWinSequence", ::_id_669067932A658A0B);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagLoseSequence", ::_id_8FE77205A38F1C50);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("getArenaLoadout", ::_id_3CBF68EF6C5CA981);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagOnPlayerKilled", ::_id_ED93A4074BBF2E51);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagCanPlayerDropKey", ::_id_452AB051852E4DF1);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagOvertimeStart", ::_id_7873119D67C51A6D);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagTrackPlayerBulletHitAI", ::_id_9B688CC3FCE07E4F);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagTrackPlayerBulletHitPlayer", ::_id_9B688CC3FCE07E4F);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetMatchDuration", ::_id_F0E6F4161C97D369);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetMaxPlayers", ::_id_CCAD0DB0ADAE4784);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagIsMatchPending", ::_id_4E8443EB7352FFD4);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetClosedCircleIndex", ::_id_50019571D7C08658);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetOvertimeLength", ::_id_F592BABBD034685B);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetCountdownLength", ::_id_F12807F1BED9E2CB);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagIsOneTeamLeft", ::_id_86BE51018A07870C);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagJailTimeout", ::_id_11B53584EC3DBC7B);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagLeftoverJailTimeout", ::_id_B628764AB30B26CE);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetVictoryWait", ::_id_DBEE0792574758D3);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetPostVictoryWait", ::_id_4925EFB18ECCE08D);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulag_startWaitingStartTime", ::_id_9B2D3873CC90A014);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulag_initPlayerArena", ::_id_E552FDBCCCA8F866);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("onGulagJailTimeout", ::_id_1FC65FF42AFBB7FC);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("setGulagJailTimeoutVariation", ::_id_7F7B72ED922A1C24);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("unsetGulagJailTimeoutVariation", ::_id_DF994A817536AE7B);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("isGulagJailTimeoutVariation", ::_id_CF70188E00C433C4);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("setGulagVariationTeams", ::_id_90B1506EBCEED929);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagOnPlayerDisconnect", ::_id_CFCC53A5D95FD20A);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagOrderArenaPlayers", ::_id_F8CBCFC051AF262B);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagLostOverlay", ::_id_796BAD56DE4895FA);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetWinSplashName", ::_id_CEA3949E01C439C6);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagJailRockAmount", ::_id_F1B80997F5C5A401);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagWatchPlayerDeath", ::_id_4FA43F06FAEEE96C);

  if(_id_3583FF375AB3A91E::_id_7AD9FCB1AC4F3DB8()) {
    _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagHandleLossInfiniteLate", ::_id_CCF74B81F01F0BF1);
    _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagHandleLossInfiniteWatchDeath", ::_id_CCF74B81F01F0BF1);
  }

  _id_5BC60484D17FA95C::_id_F6796774D7A9535B("gulag2v2Teams");
  level _id_48814951E916AF89::_id_93ADD0B65DB9F722(::_id_C525D1DF15D88A84);
  _id_ED63C88560AD9BA9();
  level thread _id_ECF124F447CED0AA();

  if(!isDefined(level._id_289DF80E1DED586F))
    thread _id_48814951E916AF89::init();

  if(_id_3583FF375AB3A91E::_id_7AD9FCB1AC4F3DB8())
    level thread _id_D8668DBEDD47D5DE();

  _id_3B5E4D861CD09132(%wz_gulag_player_acknowledge_r, "wz_gulag_player_acknowledge_r");
  _id_3B5E4D861CD09132(%wz_gulag_player_acknowledge_l, "wz_gulag_player_acknowledge_l");
  _id_3B5E4D861CD09132(%wz_gulag_player_acknowledge_r_pistol, "wz_gulag_player_acknowledge_r_pistol");
  _id_3B5E4D861CD09132(%wz_gulag_player_acknowledge_l_pistol, "wz_gulag_player_acknowledge_l_pistol");
  level thread _id_5CDA031797DCE489::_id_25A296C2ED85E35F();
  level._id_F684D37D5503EEBA = spawnStruct();
  level._id_F684D37D5503EEBA._id_B61A334EC66DB6A9 = getdvarint("dvar_C973FFC21381CF54", 7);
  level._id_F684D37D5503EEBA._id_1D8A378E37A1B6E5 = getdvarint("dvar_C6069A2A8998F630", 16);
  level._id_F684D37D5503EEBA._id_4BD43E30441ECBE3 = getdvarint("dvar_40E04BB0CF289D6A", 0);
  level._id_F684D37D5503EEBA._id_C47A1BFF68EB4112 = getdvarint("dvar_FCB9B4A4F5C268FA", 2);
  level._id_F684D37D5503EEBA.gulagloadouttable = getDvar("dvar_6717D1FD6E31379F", "mp/br_twotwo_gulag_loadout.csv");
}

_id_ED63C88560AD9BA9() {
  game["dialog"]["twotwo_gulag_jailer_dead"] = "fght_jalr_gujd";
  game["dialog"]["twotwo_gulag_allies_all_dead"] = "fght_jalr_gbad";
  game["dialog"]["twotwo_gulag_enemies_all_dead"] = "fght_jalr_gbed";
}

_id_3B5E4D861CD09132(_id_B1E6FBABCE1A26BA, _id_41503CD028EFB569) {
  if(!isDefined(_id_41503CD028EFB569)) {
    return;
  }
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"][_id_41503CD028EFB569] = _id_B1E6FBABCE1A26BA;
  level.scr_animname["player"][_id_41503CD028EFB569] = getanimname(_id_B1E6FBABCE1A26BA);
  level.scr_eventanim["player"][_id_41503CD028EFB569] = _id_41503CD028EFB569;
}

_id_ECF124F447CED0AA() {
  level waittill("prematch_done");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("second_chance_door_dom_gulag", ::_id_15AE52C5E218380A);
  _id_9F4B9FD336784C3B = 0;

  foreach(arena in level.gulag.arenas) {
    arena._id_CEFC1BF41237BBAC = [];
    arena.keys = [];
    arena._id_45E35B44EC23AB43 = [];
    arena._id_62D1855D36CFF5D2 = [];
    arena._id_1ED14283F14082AE = [];
    arena._id_6D4E3B180776136F = [];
    arena._id_2C4104D74359893B = [];
    arena._id_AEAC6A7F3FB3167F = [];
    arena._id_02A7E62879A75FFE = [];
    arena._id_49E6D5114201A22B = [];
    arena._id_79F102B3ABCC6F8A = [];
    arena._id_5B4F59070035F64E = [];
    arena._id_6F46A87C5570DEAB = undefined;
    arena._id_198C1CB09F6DBFB1 = undefined;
    arena.id = _id_9F4B9FD336784C3B;
    _id_9F4B9FD336784C3B++;

    if(level._id_43307855F189EB31._id_732A414F682801CC)
      arena._id_62D1855D36CFF5D2 = [];

    _id_BB81957D1AE1CF3A = scripts\engine\utility::getStructArray(arena.target, "targetname");

    foreach(_id_BDF25D8A73FF7DAD in _id_BB81957D1AE1CF3A) {
      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_dom_escape") {
        if(level._id_43307855F189EB31._id_7CA96B105DD358DF == -1) {
          if(!isDefined(_id_BDF25D8A73FF7DAD.script_parameters) || _id_BDF25D8A73FF7DAD.script_parameters != "center" || _id_BDF25D8A73FF7DAD.script_parameters == "center")
            _id_889D1AC5AE186841(_id_BDF25D8A73FF7DAD);
        } else if(level._id_43307855F189EB31._id_7CA96B105DD358DF == 1) {
          if(!isDefined(_id_BDF25D8A73FF7DAD.script_parameters) || _id_BDF25D8A73FF7DAD.script_parameters != "center")
            _id_889D1AC5AE186841(_id_BDF25D8A73FF7DAD);
          else
            _id_9FB89C3E5E88656C(_id_BDF25D8A73FF7DAD, arena);
        } else if(level._id_43307855F189EB31._id_7CA96B105DD358DF == 0) {
          if(isDefined(_id_BDF25D8A73FF7DAD.script_parameters) && _id_BDF25D8A73FF7DAD.script_parameters == "center")
            _id_889D1AC5AE186841(_id_BDF25D8A73FF7DAD);
          else
            _id_9FB89C3E5E88656C(_id_BDF25D8A73FF7DAD, arena);
        }
      }

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_twotwo_legendary_loot_structs") {
        if(level._id_43307855F189EB31._id_CDDD2B80C91E5CAB != 0 && level._id_43307855F189EB31._id_CDDD2B80C91E5CAB < 0 || arena.keys.size < level._id_43307855F189EB31._id_CDDD2B80C91E5CAB)
          arena.keys[arena.keys.size] = spawnscriptable("second_chance_drive", _id_BDF25D8A73FF7DAD.origin);
      }

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_twotwo_topdown_camera1" || _id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_twotwo_topdown_camera2")
        arena._id_1ED14283F14082AE[arena._id_1ED14283F14082AE.size] = _id_BDF25D8A73FF7DAD;

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_twotwo_jugg_spawn")
        arena._id_79F102B3ABCC6F8A[_id_BDF25D8A73FF7DAD.script_index] = _id_BDF25D8A73FF7DAD;

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_twotwo_jugg_spawn_alt1")
        arena._id_5B4F59070035F64E[arena._id_5B4F59070035F64E.size] = _id_BDF25D8A73FF7DAD;

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_twotwo_jugg_intro" && getdvarint("dvar_FBF0C13AB4A94311", 0)) {
        arena._id_198C1CB09F6DBFB1 = _id_BDF25D8A73FF7DAD;
        arena._id_945AC0DF95F159B3 = spawn("script_model", arena._id_198C1CB09F6DBFB1.origin);
        arena._id_945AC0DF95F159B3 setModel("generic_prop_x3");

        if(isDefined(arena._id_198C1CB09F6DBFB1.angles))
          arena._id_945AC0DF95F159B3.angles = arena._id_198C1CB09F6DBFB1.angles;

        arena._id_48404668E5582241 = spawn("script_model", arena._id_198C1CB09F6DBFB1.origin);
        arena._id_48404668E5582241 setModel("door_industrial_metal_mp_01");
        arena._id_48404668E5582241 linkTo(arena._id_945AC0DF95F159B3, "j_prop_1", (0, 0, 0), (0, 0, 0));
        arena._id_48404368E5581BA8 = spawn("script_model", arena._id_198C1CB09F6DBFB1.origin);
        arena._id_48404368E5581BA8 setModel("door_industrial_metal_mp_01");
        arena._id_48404368E5581BA8 linkTo(arena._id_945AC0DF95F159B3, "j_prop_2", (0, 0, 0), (0, 0, 0));
        arena._id_945AC0DF95F159B3 scriptmodelplayanimdeltamotionfrompos("wz_gulag_jailer_enter_doors_a", arena._id_198C1CB09F6DBFB1.origin, arena._id_198C1CB09F6DBFB1.angles);
      }

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_twotwo_spectator")
        arena._id_9068D43C1F20D9F1 = _id_BDF25D8A73FF7DAD;

      if(issubstr(_id_BDF25D8A73FF7DAD.script_noteworthy, "cashSpawn"))
        arena._id_2C4104D74359893B[arena._id_2C4104D74359893B.size] = _id_BDF25D8A73FF7DAD;

      if(issubstr(_id_BDF25D8A73FF7DAD.script_noteworthy, "itemSpawn"))
        arena._id_AEAC6A7F3FB3167F[arena._id_AEAC6A7F3FB3167F.size] = _id_BDF25D8A73FF7DAD;

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "aud_gulag_pa") {
        arena._id_6F46A87C5570DEAB = _id_BDF25D8A73FF7DAD;

        if(isvector(arena._id_6F46A87C5570DEAB.origin))
          arena._id_05C21E504CDF8C47 = spawn("script_model", arena._id_6F46A87C5570DEAB.origin);
      }
    }

    if(istrue(level._id_43307855F189EB31._id_E6B8A86F7F3D8B48))
      _id_3583FF375AB3A91E::_id_DA0A5D9A9FC8ABC2(arena);

    _id_3583FF375AB3A91E::_id_6F05F895A3054FF0(arena);
    _id_0AB674FC3132AFE8(arena);

    if(istrue(level._id_43307855F189EB31._id_B155C6403AE16B83))
      _id_1B2E2FD7F80FDD0B(arena);

    _id_33C93A39C558A492(arena);
  }

  _id_BA8DD61B00316E24();
  _id_9B254813C229A51C();
}

_id_889D1AC5AE186841(_id_BDF25D8A73FF7DAD) {
  _id_A366308BF18A9167 = scripts\engine\utility::getStructArray(_id_BDF25D8A73FF7DAD.target, "targetname");

  foreach(_id_5836BB6E49A3078E in _id_A366308BF18A9167) {
    if(_id_5836BB6E49A3078E.script_noteworthy == "gulag_dom_escape_doors")
      _id_3C865C6F7B13E400 = spawnscriptable("second_chance_door_dom_gulag", _id_5836BB6E49A3078E.origin, _id_5836BB6E49A3078E.angles);
  }
}

_id_9FB89C3E5E88656C(_id_BDF25D8A73FF7DAD, arena) {
  arena._id_CEFC1BF41237BBAC[arena._id_CEFC1BF41237BBAC.size] = _id_BDF25D8A73FF7DAD;
  _id_A366308BF18A9167 = scripts\engine\utility::getStructArray(_id_BDF25D8A73FF7DAD.target, "targetname");

  foreach(_id_5836BB6E49A3078E in _id_A366308BF18A9167) {
    if(_id_5836BB6E49A3078E.script_noteworthy == "gulag_dom_escape_goal") {
      _id_66BE6E0502FCD39F = spawn("trigger_radius", _id_5836BB6E49A3078E.origin, 0, _id_5836BB6E49A3078E.radius, 9);
      arena._id_CEFC1BF41237BBAC[arena._id_CEFC1BF41237BBAC.size - 1]._id_448DCBC6F715EFDC = _id_66BE6E0502FCD39F;
      _id_BDF25D8A73FF7DAD thread _id_740FBC412DFF7C67(arena);
    }

    if(_id_5836BB6E49A3078E.script_noteworthy == "gulag_dom_escape_doors") {
      if(!isDefined(arena._id_CEFC1BF41237BBAC[arena._id_CEFC1BF41237BBAC.size - 1]._id_15FEE21B382BFD2E)) {
        _id_745BC2250EE77657 = spawnscriptable("second_chance_door_dom_gulag", _id_5836BB6E49A3078E.origin, _id_5836BB6E49A3078E.angles);
        _id_745BC2250EE77657 setscriptablepartstate("second_chance_door_dom_gulag", "door_standing_still", 0);
        _id_745BC2250EE77657._id_F590D44509C2E578 = _id_745BC2250EE77657.origin;
        arena._id_CEFC1BF41237BBAC[arena._id_CEFC1BF41237BBAC.size - 1]._id_15FEE21B382BFD2E = _id_745BC2250EE77657;
        continue;
      }

      _id_F43A6B24B1E03E21 = spawnscriptable("second_chance_door_dom_gulag", _id_5836BB6E49A3078E.origin, _id_5836BB6E49A3078E.angles);
      arena._id_CEFC1BF41237BBAC[arena._id_CEFC1BF41237BBAC.size - 1]._id_9A86491B9A098194 = _id_F43A6B24B1E03E21;
      _id_F43A6B24B1E03E21._id_F590D44509C2E578 = _id_F43A6B24B1E03E21.origin;
    }
  }
}

_id_F4AC4C4F63924776(arena) {
  arena notify("arena_about_to_prep_for_next_match");
  level thread _id_8CD391E5244B5670(arena);

  if(isDefined(arena._id_45E35B44EC23AB43) && arena._id_45E35B44EC23AB43.size > 0) {
    foreach(_id_90C4543B2658D4EF in arena._id_45E35B44EC23AB43)
    spawnscriptable("second_chance_drive", _id_90C4543B2658D4EF);

    arena._id_45E35B44EC23AB43 = [];
  }

  _id_3583FF375AB3A91E::_id_15997D969114692D(arena);
  _id_3583FF375AB3A91E::_id_394C37628AFD48EF(arena);
  [arena._id_1003FA05CFFAADCB, arena._id_28DDCFCEC434CBF5] = _id_C3D75FB801E462F9(arena);
  _id_5EAF324209D1C3F0();
  _id_144FC7F54908932F(arena);
  _id_12801693C8C241BB(arena);
  _id_FCC8620F60CA604C(arena);
  _id_B2D8F9ADEE070020(arena);
  _id_CC5468BB6E866411(arena);
  arena notify("gulag_about_to_start_camera_sequence");
  arena waittill("gulag_players_in_place_for_match_sequence");

  foreach(player in arena.arenaplayers) {
    if(!isDefined(player)) {
      continue;
    }
    player._id_4AF73CE40A5D8572 = undefined;
    player _id_B9418A161C3B9EBD(arena);
  }

  if(arena.arenaplayers.size > 2) {
    foreach(_id_AC0E424AC96A7113 in arena.jailedplayers) {
      if(!isDefined(_id_AC0E424AC96A7113)) {
        continue;
      }
      _id_AC0E424AC96A7113 thread scripts\mp\hud_message::showsplash("br_twotwo_gulag_start_alert");
    }
  }
}

_id_8739234FFE5B08F5(arena) {
  level endon("game_ended");
  arena._id_2D0904DA1AC3FB61 = undefined;

  if(_id_3583FF375AB3A91E::_id_D8F18F1D691C0EF8(arena) && level._id_43307855F189EB31._id_CB1A9A6651A906DF < 4) {
    _id_6E5FDAFE4800CD7D = "gulagai" + arena.gulagindex;
    _id_1CE1B071385A88F0 = "gulagplayers" + arena.gulagindex;
    _id_5C7F3CEA21F3B966 = "gulagspectators" + arena.gulagindex;

    if(!threatbiasgroupexists(_id_1CE1B071385A88F0))
      createthreatbiasgroup(_id_1CE1B071385A88F0);

    if(!threatbiasgroupexists(_id_6E5FDAFE4800CD7D)) {
      createthreatbiasgroup(_id_6E5FDAFE4800CD7D);
      setignoremegroup(_id_5C7F3CEA21F3B966, _id_6E5FDAFE4800CD7D);
      setthreatbias(_id_6E5FDAFE4800CD7D, _id_1CE1B071385A88F0, 2000);
    }

    thread _id_9A77E3AAA6DA41C2(arena, _id_6E5FDAFE4800CD7D);
  }

  if(isDefined(arena._id_CEFC1BF41237BBAC)) {
    foreach(_id_3CCB8742D21B61D7 in arena._id_CEFC1BF41237BBAC)
    _id_3CCB8742D21B61D7 thread _id_740FBC412DFF7C67(arena);
  }

  if(level._id_43307855F189EB31._id_26F27E5ACF1B3864)
    _id_3583FF375AB3A91E::_id_B57F39D9E91EBF95(arena);

  if(level._id_43307855F189EB31._id_732A414F682801CC && isDefined(arena._id_62D1855D36CFF5D2) && arena._id_62D1855D36CFF5D2.size > 0)
    _id_3583FF375AB3A91E::_id_1794EC0DECE12D2F(arena);

  foreach(player in arena.arenaplayers) {
    if(!isDefined(player)) {
      continue;
    }
    if(istrue(level._id_43307855F189EB31._id_A30DC2EA18FAA0AA))
      player.nocorpse = 1;

    if(arena.arenaplayers.size < 4)
      player thread scripts\mp\hud_message::showsplash("br_twotwo_one_v_one_gulag_start");
    else
      player thread scripts\mp\hud_message::showsplash("br_twotwo_gulag_start");

    player._id_32484CD3B17F16C8 = undefined;
    player._id_3A7C9A3E9AA20358 = undefined;
    player._id_D25277121D9D0A6C = undefined;
    player._id_322535086C0890FA = undefined;
    player._id_0938604A8B5DD849 = undefined;
    player._id_E1ED3A7677EF1776 = undefined;

    if(isDefined(player._id_97AC1EA78FAEA6E3)) {
      player._id_97AC1EA78FAEA6E3 = undefined;
      arena._id_C83619011083E3C2 = 1;
    }

    player _id_3583FF375AB3A91E::_id_63776B389E7C92C1();
    player _id_720EF3A3E6616AB7(0);

    if(_id_3583FF375AB3A91E::_id_D8F18F1D691C0EF8(arena) && level._id_43307855F189EB31._id_CB1A9A6651A906DF < 4) {
      _id_1CE1B071385A88F0 = "gulagplayers" + arena.gulagindex;
      player setthreatbiasgroup();
      player setthreatbiasgroup(_id_1CE1B071385A88F0);
    }

    player thread _id_718C0E14FE043027();
    player skydive_interrupt();
  }

  if(isDefined(arena._id_707537A8904AA962))
    arena._id_28A470799D66ECD7 = arena._id_707537A8904AA962.size;

  if(isDefined(arena.arenaplayers))
    arena._id_B6B01621833467D1 = arena.arenaplayers.size;

  foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
    if(!isDefined(_id_AC0E424AC96A7113)) {
      continue;
    }
    _id_AC0E424AC96A7113 setclientomnvar("ui_match_in_progress", 1);
    _id_AC0E424AC96A7113 setclientomnvar("ui_match_start_countdown", 0);
  }

  arena notify("ai_gulag_matchStarted");
}

_id_9A77E3AAA6DA41C2(arena, _id_6E5FDAFE4800CD7D) {
  arena endon("fight_over");
  arena endon("matchEnded");
  arena waittill("Jailer_Spawned");

  if(isDefined(arena._id_707537A8904AA962)) {
    foreach(ai in arena._id_707537A8904AA962) {
      if(isagent(ai))
        ai setthreatbiasgroup(_id_6E5FDAFE4800CD7D);
    }
  }
}

_id_CCAD0DB0ADAE4784() {
  return level._id_F684D37D5503EEBA._id_C47A1BFF68EB4112;
}

_id_4E8443EB7352FFD4(_id_607899D4420FE1A5, arena) {
  if(level._id_43307855F189EB31._id_10C30E8082648B35 && isDefined(arena._id_654C981854394718)) {
    if(arena._id_654C981854394718.size < level._id_43307855F189EB31._id_0BD9294679812B88)
      return 0;
    else {
      _id_1CE522F5B914158B = _id_53B2531FD0BB8F26(arena._id_654C981854394718);
      return _id_1CE522F5B914158B;
    }
  } else if(_id_607899D4420FE1A5.size < level.gulag._id_28F8483EA37164F3)
    return 0;
  else
    return 1;
}

_id_53B2531FD0BB8F26(_id_AA9F4C033D62BC8A) {
  _id_1CE522F5B914158B = 0;

  foreach(player in _id_AA9F4C033D62BC8A) {
    if(!isDefined(player)) {
      continue;
    }
    foreach(_id_AC0E424AC96A7113 in _id_AA9F4C033D62BC8A) {
      if(!isDefined(_id_AC0E424AC96A7113)) {
        continue;
      }
      if(player == _id_AC0E424AC96A7113) {
        continue;
      }
      if(player.team == _id_AC0E424AC96A7113.team) {
        continue;
      }
      _id_1CE522F5B914158B = 1;
      break;
    }
  }

  return _id_1CE522F5B914158B;
}

_id_BA8DD61B00316E24() {
  if(!isDefined(level._id_43307855F189EB31._id_51D6638087FB19E8))
    level._id_43307855F189EB31._id_51D6638087FB19E8 = [];

  _id_2B4F934F7CF9286F = _id_67708F418B1FAC79::getgulagclosedcircleindex() + 1;

  if(_id_2B4F934F7CF9286F <= 0) {
    if(scripts\cp_mp\utility\game_utility::islargemap())
      scripts\mp\utility\script::demoforcesre("[GULAG] gulag_createLoadoutsPerCircle found 0 circles in the big map with gulag enabled");

    _id_3C8D801D3DEAD146 = randomint(int(tablelookupgetnumrows(level._id_F684D37D5503EEBA.gulagloadouttable)));
    level._id_43307855F189EB31._id_51D6638087FB19E8 = [[_id_3C8D801D3DEAD146]];
    return;
  }

  _id_6814510717A67678 = int(tablelookupgetnumrows(level._id_F684D37D5503EEBA.gulagloadouttable));

  for(_id_D280129509A08F5A = 0; _id_D280129509A08F5A < _id_2B4F934F7CF9286F; _id_D280129509A08F5A++) {
    _id_4BA03A61B0BB0AFB = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6814510717A67678; _id_AC0E594AC96AA3A8++) {
      if(scripts\engine\utility::array_contains(level._id_43307855F189EB31._id_13A255F6D4F217B5, _id_AC0E594AC96AA3A8)) {
        continue;
      }
      _id_00836A83C2BCA261 = int(tablelookupbyrow(level._id_F684D37D5503EEBA.gulagloadouttable, _id_AC0E594AC96AA3A8, 0));
      _id_40899434BDA1D462 = int(tablelookupbyrow(level._id_F684D37D5503EEBA.gulagloadouttable, _id_AC0E594AC96AA3A8, 1));

      if(_id_D280129509A08F5A >= _id_00836A83C2BCA261 && _id_D280129509A08F5A <= _id_40899434BDA1D462)
        _id_4BA03A61B0BB0AFB[_id_4BA03A61B0BB0AFB.size] = _id_AC0E594AC96AA3A8;
    }

    if(_id_4BA03A61B0BB0AFB.size == 0) {
      scripts\mp\utility\script::demoforcesre("[GULAG] gulag_createLoadoutsPerCircle found no valid loadouts for circle index : " + _id_D280129509A08F5A);
      _id_4BA03A61B0BB0AFB[_id_4BA03A61B0BB0AFB.size] = randomint(int(tablelookupgetnumrows(level._id_F684D37D5503EEBA.gulagloadouttable)));
    }

    level._id_43307855F189EB31._id_51D6638087FB19E8[level._id_43307855F189EB31._id_51D6638087FB19E8.size] = _id_4BA03A61B0BB0AFB;
  }
}

_id_F0E6F4161C97D369(arena) {
  return getdvarfloat("dvar_8BE34599DFA102B8", 20.0);
}

_id_50019571D7C08658(offset) {
  return level.br_level.br_circledelaytimes.size - 1 - getdvarint("dvar_1141FEA0C6EF428F", 3) - offset;
}

_id_F592BABBD034685B() {
  return getdvarint("dvar_1FF83F4F24656C5B", 15.0);
}

_id_F12807F1BED9E2CB() {
  return getdvarint("dvar_0FB05C5F6825931D", 8);
}

_id_86BE51018A07870C() {
  return 0;
}

_id_11B53584EC3DBC7B() {
  return getdvarfloat("dvar_E5F703A38F6E8043", 1.0);
}

_id_B628764AB30B26CE() {
  return getdvarfloat("dvar_78B34F0755FAE527", 94.0);
}

_id_DBEE0792574758D3() {
  return getdvarfloat("dvar_6B4DAC9326512A03", 4.0);
}

_id_4925EFB18ECCE08D() {
  return getdvarfloat("dvar_9E833E314C2B6FEA", 7.0);
}

_id_9B2D3873CC90A014() {
  player = self;
  player._id_7AF171F0AE71A689 = gettime();
}

_id_E552FDBCCCA8F866() {
  player = self;
  player._id_AD6498E5D4B1AE34 = gettime() - player._id_7AF171F0AE71A689;
  player._id_7AF171F0AE71A689 = undefined;
}

_id_7F7B72ED922A1C24(arena) {
  arena._id_5F525E1E05714BB5 = 1;
}

_id_DF994A817536AE7B(arena) {
  if(isDefined(arena._id_5F525E1E05714BB5))
    arena._id_5F525E1E05714BB5 = undefined;
}

_id_CF70188E00C433C4(arena) {
  if(istrue(arena._id_5F525E1E05714BB5))
    return 1;
  else
    return 0;
}

_id_90B1506EBCEED929() {
  arena = self;
  arena._id_801CDCFADC4D465C = [];
  arena._id_AF5243FBBA0720C2 = [];

  if(arena.arenaplayers.size > 2) {
    arena._id_801CDCFADC4D465C[arena._id_801CDCFADC4D465C.size] = arena.arenaplayers[0];
    arena._id_AF5243FBBA0720C2[arena._id_AF5243FBBA0720C2.size] = arena.arenaplayers[1];
    arena._id_AF5243FBBA0720C2[arena._id_AF5243FBBA0720C2.size] = arena.arenaplayers[2];
    arena._id_801CDCFADC4D465C[arena._id_801CDCFADC4D465C.size] = arena.arenaplayers[3];
    arena.arenaplayers[0]._id_6D34BF5491AD7588 = 1;
    arena.arenaplayers[1]._id_6D34BF5491AD7588 = 2;
    arena.arenaplayers[2]._id_6D34BF5491AD7588 = 2;
    arena.arenaplayers[3]._id_6D34BF5491AD7588 = 1;
    arena.arenaplayers[0].gulagloadoutindex = 1;
    arena.arenaplayers[1].gulagloadoutindex = 1;
    arena.arenaplayers[2].gulagloadoutindex = 2;
    arena.arenaplayers[3].gulagloadoutindex = 2;
    arena.arenaplayers[0]._id_098482020D94DBD8 = 1;
    arena.arenaplayers[1]._id_098482020D94DBD8 = 2;
    arena.arenaplayers[2]._id_098482020D94DBD8 = 1;
    arena.arenaplayers[3]._id_098482020D94DBD8 = 2;
    _id_3EDA0EF65C9478AC = arena.id * 2 + 1;
    arena.arenaplayers[0]._id_B5091EFEFE8E436B = level.allteamnamelist[_id_3EDA0EF65C9478AC];
    arena.arenaplayers[1]._id_B5091EFEFE8E436B = level.allteamnamelist[_id_3EDA0EF65C9478AC + 1];
    arena.arenaplayers[2]._id_B5091EFEFE8E436B = level.allteamnamelist[_id_3EDA0EF65C9478AC + 1];
    arena.arenaplayers[3]._id_B5091EFEFE8E436B = level.allteamnamelist[_id_3EDA0EF65C9478AC];
  } else {
    arena._id_801CDCFADC4D465C[arena._id_801CDCFADC4D465C.size] = arena.arenaplayers[0];
    arena._id_AF5243FBBA0720C2[arena._id_AF5243FBBA0720C2.size] = arena.arenaplayers[1];
    arena.arenaplayers[0]._id_6D34BF5491AD7588 = 1;
    arena.arenaplayers[1]._id_6D34BF5491AD7588 = 2;
    arena.arenaplayers[0].gulagloadoutindex = 1;
    arena.arenaplayers[1].gulagloadoutindex = 1;
    arena.arenaplayers[0]._id_098482020D94DBD8 = 1;
    arena.arenaplayers[1]._id_098482020D94DBD8 = 1;
    _id_3EDA0EF65C9478AC = arena.id * 2 + 1;
    arena.arenaplayers[0]._id_B5091EFEFE8E436B = level.allteamnamelist[_id_3EDA0EF65C9478AC];
    arena.arenaplayers[1]._id_B5091EFEFE8E436B = level.allteamnamelist[_id_3EDA0EF65C9478AC + 1];
  }

  _id_3583FF375AB3A91E::_id_36C9DC5A1D1BB023(arena);
}

_id_4FA43F06FAEEE96C(arena) {
  player = self;
  arena endon("matchEnded");
  player endon("disconnect");
  player endon("gulag_end");
  player endon("gulag_auto_win");
  player endon("gulagLost");
  level endon("game_ended");
  player scripts\engine\utility::waittill_any_2("death", "gulag_volume_win");
  player setclientomnvar("ui_br_twotwo_gulag_player_state", -1);
  _id_E4C8A8DCD301EE41 = _id_861C9EC1A22D6AA4(player);

  if(!isDefined(_id_E4C8A8DCD301EE41)) {
    return;
  }
  player thread _id_67708F418B1FAC79::playersetwasingulag(1);
  player._id_797179EC3AE453F7 = gettime();
  fightover = player _id_EF6CE7FD02518720(_id_E4C8A8DCD301EE41, arena);
  player _id_35F647C6340CEB22(_id_E4C8A8DCD301EE41, arena);
  player thread _id_556E62498EC825C5(fightover, arena);
}

_id_35F647C6340CEB22(_id_E4C8A8DCD301EE41, arena) {
  player = self;

  foreach(_id_AC0E424AC96A7113 in _id_E4C8A8DCD301EE41) {
    if(!isDefined(_id_AC0E424AC96A7113) || _id_AC0E424AC96A7113 == player || !istrue(_id_AC0E424AC96A7113.gulag)) {
      continue;
    }
    _id_AC0E424AC96A7113 playlocalsound("mp_bodycount_tick_negative_final");
  }

  _id_8E28D3D3DF9A6321 = _id_488428F4237C7E87(player);

  foreach(_id_AC0E424AC96A7113 in _id_8E28D3D3DF9A6321) {
    if(!isDefined(_id_AC0E424AC96A7113) || !istrue(_id_AC0E424AC96A7113.gulag)) {
      continue;
    }
    _id_AC0E424AC96A7113 playlocalsound("mp_bodycount_tick_positive_final");
  }
}

_id_EF6CE7FD02518720(_id_E4C8A8DCD301EE41, arena) {
  player = self;

  if(_id_CF70188E00C433C4(arena) || _id_E4C8A8DCD301EE41.size < 2)
    return 1;

  fightover = 0;

  foreach(_id_AC0E424AC96A7113 in _id_E4C8A8DCD301EE41) {
    if(_id_AC0E424AC96A7113 == player) {
      continue;
    }
    if(!isDefined(_id_AC0E424AC96A7113)) {
      fightover = 1;
      continue;
    }

    if(!isalive(_id_AC0E424AC96A7113) || !istrue(_id_AC0E424AC96A7113.gulag)) {
      fightover = 1;
      continue;
    }

    _id_AC0E424AC96A7113 setclientomnvar("ui_br_twotwo_gulag_player_state", -1);
  }

  return fightover;
}

_id_556E62498EC825C5(fightover, arena) {
  player = self;
  level endon("game_ended");
  _id_04560E1F068A68F0 = undefined;

  if(isDefined(arena._id_AF5243FBBA0720C2)) {
    if(player._id_6D34BF5491AD7588 == 1)
      _id_04560E1F068A68F0 = arena._id_AF5243FBBA0720C2;
    else
      _id_04560E1F068A68F0 = arena._id_801CDCFADC4D465C;
  }

  if(fightover) {
    foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
      if(!isDefined(_id_AC0E424AC96A7113) || !isDefined(_id_AC0E424AC96A7113.forcespectatorclient) || _id_AC0E424AC96A7113.forcespectatorclient == -1) {
        continue;
      }
      _id_AC0E424AC96A7113.forcespectatorclient = -1;
    }

    arena thread _id_50FC80E21E19D442();
  }

  if(!isDefined(_id_04560E1F068A68F0)) {
    return;
  }
  foreach(_id_02B6C9E57C112F30 in _id_04560E1F068A68F0) {
    if(!isDefined(_id_02B6C9E57C112F30)) {
      continue;
    }
    if(!istrue(_id_02B6C9E57C112F30.gulag)) {
      continue;
    }
    if(istrue(_id_02B6C9E57C112F30._id_4AF73CE40A5D8572)) {
      continue;
    }
    if(fightover) {
      _id_02B6C9E57C112F30 _id_0DC0A56E258889CB(arena, "br_twotwo_gulag_win");
      continue;
    }

    if(istrue(level._id_F684D37D5503EEBA._id_4BD43E30441ECBE3))
      _id_02B6C9E57C112F30 thread scripts\mp\hud_message::showsplash("br_twotwo_gulag_one_enemy_left");
  }

  if(fightover) {
    foreach(_id_AC0E424AC96A7113 in _id_04560E1F068A68F0) {
      if(!isDefined(_id_AC0E424AC96A7113)) {
        continue;
      }
      if(arena.arenaplayers.size > 2)
        _id_AC0E424AC96A7113 thread scripts\mp\events::killeventtextpopup("stat_5766542B6AD9975A", 0);

      _id_AC0E424AC96A7113 thread _id_3583FF375AB3A91E::_id_696F54DA8FCB6BBE("twotwo_gulag_enemies_all_dead", arena);
    }

    _id_D63EC8946A18FD86 = _id_861C9EC1A22D6AA4(player);

    if(isDefined(_id_D63EC8946A18FD86)) {
      if(_id_D63EC8946A18FD86.size > 1)
        _id_D63EC8946A18FD86 = scripts\mp\utility\script::quicksort(_id_D63EC8946A18FD86, ::_id_0E4549DA9DA5CB20);

      foreach(_id_AC0E424AC96A7113 in _id_D63EC8946A18FD86) {
        if(!isDefined(_id_AC0E424AC96A7113) || istrue(_id_AC0E424AC96A7113.disconnecting)) {
          continue;
        }
        _id_AC0E424AC96A7113._id_797179EC3AE453F7 = undefined;

        if(istrue(_id_AC0E424AC96A7113._id_4AF73CE40A5D8572)) {
          continue;
        }
        _id_AC0E424AC96A7113 thread _id_3583FF375AB3A91E::_id_696F54DA8FCB6BBE("twotwo_gulag_allies_all_dead", arena);
        _id_AC0E424AC96A7113 _id_7AAF75A824252D97(arena, "br_twotwo_gulag_lost_death");
      }
    }
  }

  _id_CC5468BB6E866411(arena);
}

_id_0E4549DA9DA5CB20(left, right) {
  return left._id_797179EC3AE453F7 <= right._id_797179EC3AE453F7;
}

_id_CFCC53A5D95FD20A() {
  player = self;
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);

  if(!isDefined(arena)) {
    return;
  }
  if(!isDefined(player._id_6D34BF5491AD7588)) {
    return;
  }
  foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
    if(!isDefined(_id_AC0E424AC96A7113)) {
      continue;
    }
    _id_AC0E424AC96A7113 _id_6D217BA4DE4B166B(arena);
    _id_AC0E424AC96A7113 _id_FB51BDAA21D694E5(arena);
  }

  foreach(_id_AC0E424AC96A7113 in arena.jailedplayers) {
    if(!isDefined(_id_AC0E424AC96A7113)) {
      continue;
    }
    _id_AC0E424AC96A7113 _id_6D217BA4DE4B166B(arena);
    _id_AC0E424AC96A7113 _id_FB51BDAA21D694E5(arena);
  }

  _id_E4C8A8DCD301EE41 = _id_861C9EC1A22D6AA4(player);

  if(!isDefined(_id_E4C8A8DCD301EE41)) {
    return;
  }
  fightover = player _id_EF6CE7FD02518720(_id_E4C8A8DCD301EE41, arena);
  player _id_35F647C6340CEB22(_id_E4C8A8DCD301EE41, arena);
  player thread _id_556E62498EC825C5(fightover, arena);
}

_id_F8CBCFC051AF262B(_id_AA9F4C033D62BC8A) {
  if(_id_AA9F4C033D62BC8A.size == 4) {
    _id_6DAF5C22ABBA2234 = undefined;
    _id_CCFD4A1C9626F37C = 0;
    _id_DA4146D44A272F3A = 1;
    _id_9E96035329B953B0 = 2;
    _id_6DAF5C22ABBA2234 = _id_AA9F4C033D62BC8A[_id_CCFD4A1C9626F37C] _id_E7940D6D0CD7148A(_id_AA9F4C033D62BC8A);

    if(isDefined(_id_6DAF5C22ABBA2234)) {
      _id_AA9F4C033D62BC8A = _id_AA9F4C033D62BC8A _id_3682F0CC9E284D5B(_id_CCFD4A1C9626F37C, _id_6DAF5C22ABBA2234);
      return _id_AA9F4C033D62BC8A;
    } else
      _id_6DAF5C22ABBA2234 = _id_AA9F4C033D62BC8A[_id_DA4146D44A272F3A] _id_E7940D6D0CD7148A(_id_AA9F4C033D62BC8A);

    if(isDefined(_id_6DAF5C22ABBA2234)) {
      _id_AA9F4C033D62BC8A = _id_AA9F4C033D62BC8A _id_3682F0CC9E284D5B(_id_DA4146D44A272F3A, _id_6DAF5C22ABBA2234);
      return _id_AA9F4C033D62BC8A;
    } else
      _id_6DAF5C22ABBA2234 = _id_AA9F4C033D62BC8A[_id_9E96035329B953B0] _id_E7940D6D0CD7148A(_id_AA9F4C033D62BC8A);

    if(!isDefined(_id_6DAF5C22ABBA2234)) {
      return _id_AA9F4C033D62BC8A;
      return;
    }

    _id_AA9F4C033D62BC8A = _id_AA9F4C033D62BC8A _id_3682F0CC9E284D5B(_id_9E96035329B953B0, _id_6DAF5C22ABBA2234);
    return _id_AA9F4C033D62BC8A;
    return;
  } else
    return _id_AA9F4C033D62BC8A;
}

_id_796BAD56DE4895FA(player, _id_40D8983FC5E5C7A5) {
  player endon("disconnect");
  player._id_4AF73CE40A5D8572 = 1;
  splashname = "br_twotwo_gulag_lost_timeout";

  if(isDefined(_id_40D8983FC5E5C7A5))
    splashname = _id_40D8983FC5E5C7A5;

  player thread scripts\mp\hud_message::showsplash(splashname);
  wait 3;
  player thread _id_6489FCDFE6FA2E36::triggereliminatedoverlay();
}

_id_CEA3949E01C439C6() {
  return "br_twotwo_gulag_win";
}

_id_F1B80997F5C5A401() {
  player = self;
  player scripts\mp\equipment::setequipmentammo(level.br_pickups.br_equipname["brloot_rock"], level._id_43307855F189EB31._id_5BC7DBD34DF10B08);
}

_id_E7940D6D0CD7148A(_id_AA9F4C033D62BC8A) {
  player = self;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_AA9F4C033D62BC8A.size; _id_AC0E594AC96AA3A8++) {
    if(player == _id_AA9F4C033D62BC8A[_id_AC0E594AC96AA3A8]) {
      continue;
    }
    if(player.team == _id_AA9F4C033D62BC8A[_id_AC0E594AC96AA3A8].team)
      return _id_AC0E594AC96AA3A8;
  }
}

_id_3682F0CC9E284D5B(_id_EF50426720E1DBB8, _id_A60CE7964DBA5B3B) {
  _id_AA9F4C033D62BC8A = self;

  switch (_id_EF50426720E1DBB8) {
    case 0:
      _id_6CE69D9DBE6A1F3A = _id_AA9F4C033D62BC8A[_id_A60CE7964DBA5B3B];
      _id_AA9F4C033D62BC8A[_id_A60CE7964DBA5B3B] = _id_AA9F4C033D62BC8A[3];
      _id_AA9F4C033D62BC8A[3] = _id_6CE69D9DBE6A1F3A;
      return _id_AA9F4C033D62BC8A;
    case 1:
      _id_6CE69D9DBE6A1F3A = _id_AA9F4C033D62BC8A[_id_A60CE7964DBA5B3B];
      _id_AA9F4C033D62BC8A[_id_A60CE7964DBA5B3B] = _id_AA9F4C033D62BC8A[2];
      _id_AA9F4C033D62BC8A[2] = _id_6CE69D9DBE6A1F3A;
      return _id_AA9F4C033D62BC8A;
    case 2:
      _id_6CE69D9DBE6A1F3A = _id_AA9F4C033D62BC8A[_id_A60CE7964DBA5B3B];
      _id_AA9F4C033D62BC8A[_id_A60CE7964DBA5B3B] = _id_AA9F4C033D62BC8A[1];
      _id_AA9F4C033D62BC8A[1] = _id_6CE69D9DBE6A1F3A;
      return _id_AA9F4C033D62BC8A;
    default:
      return _id_AA9F4C033D62BC8A;
  }
}

_id_B5EC51AC542C7638() {
  player = self;
  _id_F9CD7FDA74E92E2A = 8;
  _id_E0E11F3B4551BE11 = 1;
  _id_30516B4AFD1763DE = 500;
  maxdistance = 25000;
  _id_EE1C1550F39782C4 = "ui_map_icon_key_skeleton_green";
  _id_1BF1EEBCAB47C063 = "ui_map_icon_key_skeleton_red";
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);

  if(isDefined(arena)) {
    _id_EFA74C6ECAAA78D0 = _id_861C9EC1A22D6AA4(player);
    _id_EFA74C6ECAAA78D0 = scripts\engine\utility::array_remove(_id_EFA74C6ECAAA78D0, player);
    _id_7B938C58658569DF = _id_488428F4237C7E87(player);
    headicon = player scripts\cp_mp\entityheadicons::setheadicon_singleimage(_id_EFA74C6ECAAA78D0, _id_EE1C1550F39782C4, _id_F9CD7FDA74E92E2A, _id_E0E11F3B4551BE11, maxdistance, _id_30516B4AFD1763DE, undefined, 1, 1, undefined);

    foreach(_id_AC0E424AC96A7113 in _id_EFA74C6ECAAA78D0) {
      _id_AC0E424AC96A7113 thread _id_5A150F2908A378CB(headicon, player);
      player thread _id_E6C0858F7A0AAC96(headicon, _id_AC0E424AC96A7113);
    }

    headicon = player scripts\cp_mp\entityheadicons::setheadicon_singleimage(_id_7B938C58658569DF, _id_1BF1EEBCAB47C063, _id_F9CD7FDA74E92E2A, _id_E0E11F3B4551BE11, maxdistance, _id_30516B4AFD1763DE, undefined, 1, 1, undefined);

    foreach(_id_AC0E424AC96A7113 in _id_7B938C58658569DF) {
      _id_AC0E424AC96A7113 thread _id_5A150F2908A378CB(headicon, player);
      player thread _id_E6C0858F7A0AAC96(headicon, _id_AC0E424AC96A7113);
    }
  }

  player._id_43B2A82936A5E974 = 1;
  player _id_A7EC5E159CE62C68();
  _id_1F058C408F19EDDB = _id_861C9EC1A22D6AA4(player);

  if(isDefined(_id_1F058C408F19EDDB)) {
    foreach(_id_AC0E424AC96A7113 in _id_1F058C408F19EDDB) {
      if(!isDefined(_id_AC0E424AC96A7113)) {
        continue;
      }
      _id_AC0E424AC96A7113 thread scripts\mp\hud_message::showsplash("br_twotwo_gulag_got_key_ally");
    }
  }

  _id_A1FFA0E77F4AE724 = _id_488428F4237C7E87(player);

  if(isDefined(_id_A1FFA0E77F4AE724)) {
    foreach(_id_AC0E424AC96A7113 in _id_A1FFA0E77F4AE724) {
      if(!isDefined(_id_AC0E424AC96A7113)) {
        continue;
      }
      _id_AC0E424AC96A7113 thread scripts\mp\hud_message::showsplash("br_twotwo_gulag_got_key_enemy");
    }
  }

  player setclientomnvar("ui_br_special_item_acquired", 1);

  if(isDefined(arena))
    _id_3583FF375AB3A91E::_id_00BA5DBC7633C84A(arena);
}

_id_A7EC5E159CE62C68() {
  player = self;
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);

  foreach(_id_3CCB8742D21B61D7 in arena._id_CEFC1BF41237BBAC) {
    objective_addclienttomask(_id_3CCB8742D21B61D7.objid, player);
    objective_showtoplayersinmask(_id_3CCB8742D21B61D7.objid);
  }
}

_id_E6C0858F7A0AAC96(headicon, _id_0CA5A607C4F7A315) {
  _id_B37AEF355BA7B694 = self;
  level endon("game_ended");
  _id_0CA5A607C4F7A315 endon("watchHeadIconDelete");
  scripts\engine\utility::waittill_any_ents(_id_B37AEF355BA7B694, "death", _id_B37AEF355BA7B694, "disconnect", _id_B37AEF355BA7B694, "gulag_end", _id_B37AEF355BA7B694, "gulagLost");

  if(!isDefined(_id_B37AEF355BA7B694)) {
    return;
  }
  removeclientfromheadiconmask(headicon, _id_B37AEF355BA7B694);
}

_id_5A150F2908A378CB(headicon, _id_B37AEF355BA7B694) {
  _id_0CA5A607C4F7A315 = self;
  level endon("game_ended");
  scripts\engine\utility::waittill_any_ents(_id_0CA5A607C4F7A315, "death", _id_0CA5A607C4F7A315, "disconnect", _id_0CA5A607C4F7A315, "gulag_end", _id_0CA5A607C4F7A315, "gulagLost");
  _id_0CA5A607C4F7A315 notify("watchHeadIconDelete");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(headicon);
}

_id_1A16AE715C7D1D44() {
  player = self;
  _id_E4C8A8DCD301EE41 = _id_861C9EC1A22D6AA4(player);

  if(!isDefined(_id_E4C8A8DCD301EE41))
    return 0;

  fightover = 0;

  foreach(_id_AC0E424AC96A7113 in _id_E4C8A8DCD301EE41) {
    if(!isDefined(_id_AC0E424AC96A7113)) {
      fightover = 1;
      continue;
    }

    if(_id_AC0E424AC96A7113 == player) {
      continue;
    }
    if(!isalive(_id_AC0E424AC96A7113) || !istrue(_id_AC0E424AC96A7113.gulag))
      fightover = 1;
  }

  if(fightover)
    return 0;
  else
    return 1;
}

_id_618BF5253A72136F() {
  player = self;
  player endon("disconnect");
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);

  if(!isDefined(arena) || !isDefined(arena.time)) {
    return;
  }
  if(arena.time < 5) {
    return;
  }
  player._id_36386F3F03C2AB4B = 1;
  player setclientdvar("dvar_B21F1157C582FF15", 0);
  _id_1F058C408F19EDDB = _id_861C9EC1A22D6AA4(player);
  playertospectate = undefined;

  foreach(_id_AC0E424AC96A7113 in _id_1F058C408F19EDDB) {
    if(!isDefined(_id_AC0E424AC96A7113) || _id_AC0E424AC96A7113 == player) {
      continue;
    }
    playertospectate = _id_AC0E424AC96A7113;
  }

  if(isDefined(playertospectate)) {
    player setclientomnvar("ui_show_spectateHud", playertospectate getentitynumber());
    player scripts\mp\utility\player::updatesessionstate("dead");
    player.sessionstate = "dead";
    player setclientomnvar("ui_session_state", "spectator");

    if(!isDefined(arena._id_2BF44E032B5FCDA1)) {
      arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(self);
      spawnpoint = arena._id_9068D43C1F20D9F1;
      camera = spawn("script_model", spawnpoint.origin);
      camera.angles = spawnpoint.angles;
      camera setModel("tag_origin");
      arena._id_2BF44E032B5FCDA1 = camera;
    }

    player cameralinkTo(arena._id_2BF44E032B5FCDA1, "tag_origin", 1, 1);
  }

  scripts\engine\utility::waittill_any_ents_or_timeout_return(arena.time, player, "stop_gulag_spectator", level, "game_ended");

  if(!isDefined(player)) {
    return;
  }
  player cameraunlink();
  player setclientdvar("dvar_B21F1157C582FF15", 1);
  player._id_36386F3F03C2AB4B = undefined;
}

_id_B9418A161C3B9EBD(arena) {
  player = self;

  if(arena.arenaplayers.size > 2) {
    if(level._id_43307855F189EB31._id_4749A3B876804AE5 == 1)
      player thread _id_3583FF375AB3A91E::_id_63CEF9BB6769F404(arena);
    else if(level._id_43307855F189EB31._id_4749A3B876804AE5 == 2)
      player thread _id_3583FF375AB3A91E::_id_85B349978CD4DE4F(arena);
  } else
    player thread _id_3583FF375AB3A91E::_id_608E28250C9D63A9(arena);
}

_id_718C0E14FE043027() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player notify("gulagTwoTwo_trackPlayerBullets");
  player endon("gulagTwoTwo_trackPlayerBullets");
  player endon("can_show_splashes");

  for(;;) {
    player waittill("weapon_fired", objweapon);

    if(!isDefined(player._id_322535086C0890FA))
      player._id_322535086C0890FA = 0;

    player._id_322535086C0890FA = player._id_322535086C0890FA + 1;
  }
}

_id_9B688CC3FCE07E4F(eattacker, _id_19EF223648735F8F) {
  if(isDefined(eattacker) && istrue(eattacker.gulag) && isPlayer(eattacker)) {
    arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(eattacker);

    if(isDefined(arena)) {
      if(!isDefined(eattacker._id_D25277121D9D0A6C))
        eattacker._id_D25277121D9D0A6C = 0;

      if(!isDefined(eattacker._id_322535086C0890FA))
        eattacker._id_322535086C0890FA = 1;

      eattacker._id_D25277121D9D0A6C = min(eattacker._id_D25277121D9D0A6C + 1, eattacker._id_322535086C0890FA);

      if(isDefined(_id_19EF223648735F8F)) {
        if(!isDefined(eattacker._id_A6E0850023A9D8F9))
          eattacker._id_A6E0850023A9D8F9 = 0;

        eattacker._id_A6E0850023A9D8F9 = eattacker._id_A6E0850023A9D8F9 + _id_19EF223648735F8F;
      }
    }
  }
}

_id_D8668DBEDD47D5DE() {
  level endon("game_ended");
  level waittill("prematch_done");
  wait 15;

  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }
    if(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
      continue;
    }
    player kill();
  }
}

_id_740FBC412DFF7C67(arena) {
  _id_3CCB8742D21B61D7 = self;
  level endon("game_ended");

  for(;;) {
    _id_3CCB8742D21B61D7._id_448DCBC6F715EFDC waittill("trigger", player);

    if(isDefined(player) && isPlayer(player) && player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag() && !istrue(player._id_4AF73CE40A5D8572)) {
      if(istrue(_id_3CCB8742D21B61D7.dooropen))
        player _id_7C296B84F3F04CB5(arena);
    }
  }
}

_id_15AE52C5E218380A(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(player) || !isPlayer(player) || !player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag() || istrue(player._id_4AF73CE40A5D8572)) {
    return;
  }
  if(!istrue(player._id_43B2A82936A5E974)) {
    player scripts\mp\hud_message::showerrormessage("MP/MISSING_GULAG_KEY");
    return;
  }

  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);

  if(!isDefined(arena)) {
    return;
  }
  level thread _id_64ACB6CE534155B7::utilflare_shootflare(player.origin + (0, 0, 150), "revive", 1);
  instance thread _id_BCA70E305FB00F25(arena);
  player setclientomnvar("ui_br_special_item_acquired", 0);
  player._id_43B2A82936A5E974 = undefined;
}

_id_BCA70E305FB00F25(arena) {
  _id_C1057221E17F180B = self;
  _id_12DB0FE9902CD14B = undefined;
  _id_C1057221E17F180B notify("gulagDom_DoorOpened");
  _id_C1057221E17F180B endon("gulagDom_DoorOpened");
  _id_3CCB8742D21B61D7 = undefined;

  foreach(_id_5836BB6E49A3078E in arena._id_CEFC1BF41237BBAC) {
    if(_id_5836BB6E49A3078E._id_15FEE21B382BFD2E == _id_C1057221E17F180B) {
      _id_3CCB8742D21B61D7 = _id_5836BB6E49A3078E;
      _id_12DB0FE9902CD14B = _id_5836BB6E49A3078E._id_9A86491B9A098194;
      break;
    } else if(_id_5836BB6E49A3078E._id_9A86491B9A098194 == _id_C1057221E17F180B) {
      _id_3CCB8742D21B61D7 = _id_5836BB6E49A3078E;
      _id_12DB0FE9902CD14B = _id_5836BB6E49A3078E._id_15FEE21B382BFD2E;
      break;
    }
  }

  if(!isDefined(_id_3CCB8742D21B61D7)) {
    return;
  }
  _id_3CCB8742D21B61D7.dooropen = 1;

  foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
    if(!isDefined(_id_AC0E424AC96A7113)) {
      continue;
    }
    if(isDefined(_id_AC0E424AC96A7113._id_C1057221E17F180B) && _id_AC0E424AC96A7113._id_C1057221E17F180B == _id_C1057221E17F180B) {
      continue;
    }
    _id_AC0E424AC96A7113 _id_3583FF375AB3A91E::_id_6CE94CF4EEE9EAB7(_id_3CCB8742D21B61D7);
  }

  _id_C1057221E17F180B _id_3583FF375AB3A91E::_id_080658D002F64199(_id_12DB0FE9902CD14B);
  wait(level._id_43307855F189EB31._id_4304A1E29279A798);
  thread _id_3583FF375AB3A91E::_id_51B0F4B8CBCE83AD(_id_3CCB8742D21B61D7);
  _id_3CCB8742D21B61D7 _id_77DC965BED28A081(arena);
}

_id_67D92D9A720E2307(_id_3CCB8742D21B61D7) {
  player = self;

  if(!isDefined(player)) {
    return;
  }
  objective_addclienttomask(_id_3CCB8742D21B61D7.objid, player);
  objective_showtoplayersinmask(_id_3CCB8742D21B61D7.objid);
}

_id_77DC965BED28A081(arena) {
  _id_3CCB8742D21B61D7 = self;

  foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
    if(!isDefined(_id_AC0E424AC96A7113) || isDefined(_id_AC0E424AC96A7113._id_C1057221E17F180B) && _id_AC0E424AC96A7113._id_C1057221E17F180B == _id_3CCB8742D21B61D7) {
      continue;
    }
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_3CCB8742D21B61D7.objid, _id_AC0E424AC96A7113);
  }
}

_id_7C296B84F3F04CB5(arena) {
  player = self;
  arena thread _id_50FC80E21E19D442();
  _id_1F058C408F19EDDB = _id_861C9EC1A22D6AA4(player);
  _id_A1FFA0E77F4AE724 = _id_488428F4237C7E87(player);

  foreach(_id_AC0E424AC96A7113 in _id_1F058C408F19EDDB) {
    if(!isDefined(_id_AC0E424AC96A7113)) {
      continue;
    }
    if(!istrue(_id_AC0E424AC96A7113.gulag)) {
      continue;
    }
    if(istrue(_id_AC0E424AC96A7113._id_4AF73CE40A5D8572)) {
      continue;
    }
    _id_AC0E424AC96A7113._id_4AF73CE40A5D8572 = 1;

    if(isalive(_id_AC0E424AC96A7113)) {
      _id_AC0E424AC96A7113 _id_0DC0A56E258889CB(arena, "br_twotwo_gulag_win_door");
      continue;
    }

    _id_913E4D836CBD71FD = _id_1BD32287885BB933(_id_AC0E424AC96A7113);

    if(!isDefined(_id_913E4D836CBD71FD))
      _id_913E4D836CBD71FD = _id_AC0E424AC96A7113;

    _id_AC0E424AC96A7113 thread _id_67708F418B1FAC79::playergulagautowin("gulagTwoTwoVolume", _id_913E4D836CBD71FD, undefined, undefined, undefined, 1);
  }

  foreach(_id_AC0E424AC96A7113 in _id_A1FFA0E77F4AE724) {
    if(!isDefined(_id_AC0E424AC96A7113)) {
      continue;
    }
    if(!istrue(_id_AC0E424AC96A7113.gulag)) {
      continue;
    }
    if(istrue(_id_AC0E424AC96A7113._id_4AF73CE40A5D8572)) {
      continue;
    }
    _id_AC0E424AC96A7113._id_4AF73CE40A5D8572 = 1;
    _id_AC0E424AC96A7113 _id_7AAF75A824252D97(arena, "br_twotwo_gulag_lost_door");
  }

  waitframe();
  arena notify("matchEnded");
  arena notify("fight_over_early");
  level _id_67708F418B1FAC79::handleendarena(arena);
}

_id_0DC0A56E258889CB(arena, _id_B6ACF0C07C4311E6) {
  player = self;

  if(istrue(player._id_4AF73CE40A5D8572))
    return;
  else
    player._id_4AF73CE40A5D8572 = 1;

  player setclientomnvar("ui_br_gulag_match_end_time", 0);
  player setclientomnvar("ui_br_twotwo_gulag_players", -1);

  if(player.sessionstate == "playing")
    player thread _id_67708F418B1FAC79::gulagvictory(arena, player, 0, 0, _id_B6ACF0C07C4311E6, undefined, undefined, undefined, 1);
  else {
    _id_913E4D836CBD71FD = _id_1BD32287885BB933(player);

    if(!isDefined(_id_913E4D836CBD71FD))
      _id_913E4D836CBD71FD = player;

    player thread _id_67708F418B1FAC79::playergulagautowin("gulagTwoTwo_victory", _id_913E4D836CBD71FD, undefined, undefined, undefined, 1, undefined, _id_B6ACF0C07C4311E6);
  }

  _id_CC5468BB6E866411(arena);
}

_id_669067932A658A0B(arena, _id_B6ACF0C07C4311E6) {
  player = self;

  if(isDefined(arena) && isDefined(arena._id_654C981854394718)) {
    if(scripts\engine\utility::array_contains(arena._id_654C981854394718, player))
      arena._id_654C981854394718 = scripts\engine\utility::array_remove(arena._id_654C981854394718, player);
  }

  player._id_4AF73CE40A5D8572 = 1;
  player _id_3583FF375AB3A91E::_id_0DCEAD2B56FDBF3E(_id_B6ACF0C07C4311E6);
  player _id_3583FF375AB3A91E::_id_3F18739AE34D9958();
  player _id_720EF3A3E6616AB7(-1);
  player setthreatbiasgroup();
  player setclientomnvar("ui_br_twotwo_gulag_player_state", -1);

  if(isDefined(arena) && isDefined(arena._id_A9350ED31BEC6AEF)) {
    foreach(_id_3CCB8742D21B61D7 in arena._id_CEFC1BF41237BBAC)
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_3CCB8742D21B61D7.objid, player);

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(arena._id_A9350ED31BEC6AEF, player);
  }

  player setclientomnvar("ui_br_special_item_acquired", 0);

  if(_id_3583FF375AB3A91E::_id_7AD9FCB1AC4F3DB8())
    player thread _id_DEFEE99C5C401B40();

  if(isDefined(arena))
    _id_67708F418B1FAC79::setovertimeomnvarenabled(arena, 0);
}

_id_7AAF75A824252D97(arena, _id_40D8983FC5E5C7A5) {
  player = self;

  if(istrue(player._id_4AF73CE40A5D8572))
    return;
  else
    player._id_4AF73CE40A5D8572 = 1;

  player setclientomnvar("ui_br_gulag_match_end_time", 0);
  player setclientomnvar("ui_br_twotwo_gulag_players", -1);
  player thread _id_67708F418B1FAC79::gulagplayerlost(arena, _id_40D8983FC5E5C7A5);
}

_id_8FE77205A38F1C50(arena, _id_40D8983FC5E5C7A5) {
  player = self;

  if(isDefined(arena._id_654C981854394718)) {
    if(scripts\engine\utility::array_contains(arena._id_654C981854394718, player))
      arena._id_654C981854394718 = scripts\engine\utility::array_remove(arena._id_654C981854394718, player);
  }

  if(!isDefined(_id_40D8983FC5E5C7A5)) {
    if(!isalive(player))
      _id_40D8983FC5E5C7A5 = "death";
    else
      _id_40D8983FC5E5C7A5 = "time_ran_out";
  }

  player setclientomnvar("ui_br_twotwo_gulag_player_state", -1);

  foreach(_id_3CCB8742D21B61D7 in arena._id_CEFC1BF41237BBAC)
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_3CCB8742D21B61D7.objid, player);

  if(isDefined(arena._id_A9350ED31BEC6AEF))
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(arena._id_A9350ED31BEC6AEF, player);

  player setthreatbiasgroup();
  player _id_3583FF375AB3A91E::_id_0DCEAD2B56FDBF3E(_id_40D8983FC5E5C7A5);
  player _id_3583FF375AB3A91E::_id_3F18739AE34D9958();
  _id_67708F418B1FAC79::setovertimeomnvarenabled(arena, 0);
  _id_CC5468BB6E866411(arena);

  if(!istrue(level._id_D034183ABF2E274D)) {
    player _id_2D9D24F7C63AC143::_id_5C5E6619F0B24F90();
    _id_2D9D24F7C63AC143::_id_954372D604277278(player);
  }
}

_id_50FC80E21E19D442() {
  arena = self;
  level endon("game_ended");
  _id_ACFFAF2E14327BE0 = [];

  foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
    if(!isDefined(_id_AC0E424AC96A7113)) {
      continue;
    }
    body = _id_AC0E424AC96A7113 getcorpseentity();

    if(isDefined(body))
      _id_ACFFAF2E14327BE0[_id_ACFFAF2E14327BE0.size] = body;
  }

  wait 5.5;

  foreach(body in _id_ACFFAF2E14327BE0) {
    if(!isDefined(body)) {
      continue;
    }
    body notify("corpse_manually_deleted");
  }
}

_id_DEFEE99C5C401B40() {
  player = self;
  player endon("disconnect");
  level endon("game_ended");
  wait 18;

  if(!player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
    player kill();
}

_id_4F4C7829487B8220(arena) {
  foreach(_id_3CCB8742D21B61D7 in arena._id_CEFC1BF41237BBAC) {
    objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(objid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", _id_3CCB8742D21B61D7.origin + (0, 0, 60), "ui_mp_br_icon_gulag_exit_objective");
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);
      scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
    } else {}

    _id_3CCB8742D21B61D7.objid = objid;
  }
}

_id_3DC19FBE8B98E015() {
  player = self;
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);
  _id_0421E96E09A60042 = arena._id_CEFC1BF41237BBAC[0];
  _id_27C330DA5D381169 = distance(_id_0421E96E09A60042.origin, player.origin);

  foreach(_id_3CCB8742D21B61D7 in arena._id_CEFC1BF41237BBAC) {
    _id_AF169CA88313D704 = distance(_id_3CCB8742D21B61D7.origin, player.origin);

    if(_id_27C330DA5D381169 > distance(_id_3CCB8742D21B61D7.origin, player.origin)) {
      _id_0421E96E09A60042 = _id_3CCB8742D21B61D7;
      _id_27C330DA5D381169 = _id_AF169CA88313D704;
    }
  }

  objective_addclienttomask(_id_0421E96E09A60042.objid, player);
  objective_showtoplayersinmask(_id_0421E96E09A60042.objid);
}

_id_C3D75FB801E462F9(arena) {
  _id_D280129509A08F5A = level.br_circle.circleindex;

  if(!isDefined(_id_D280129509A08F5A) || _id_D280129509A08F5A < 0)
    _id_D280129509A08F5A = randomint(level._id_43307855F189EB31._id_51D6638087FB19E8.size);

  _id_C2AFFEEDC8035B93 = scripts\engine\utility::array_randomize(level._id_43307855F189EB31._id_51D6638087FB19E8[int(min(_id_D280129509A08F5A, level._id_43307855F189EB31._id_51D6638087FB19E8.size - 1))]);
  _id_1B3BCE554DCBFD60 = _id_C2AFFEEDC8035B93[0];
  _id_7DB53554DB156D36 = _id_C2AFFEEDC8035B93[1];

  if(!isDefined(_id_7DB53554DB156D36))
    _id_7DB53554DB156D36 = _id_1B3BCE554DCBFD60;

  return [_id_1B3BCE554DCBFD60, _id_7DB53554DB156D36];
}

_id_3CBF68EF6C5CA981(arena) {
  player = self;

  if(player.gulagloadoutindex == 1)
    index = arena._id_1003FA05CFFAADCB;
  else
    index = arena._id_28DDCFCEC434CBF5;

  if(level._id_43307855F189EB31._id_3B156BE10B96EDB9)
    index = arena._id_1003FA05CFFAADCB;

  if(level._id_43307855F189EB31._id_F336DFCEF737A30C >= 0)
    index = level._id_43307855F189EB31._id_F336DFCEF737A30C;

  _id_E99060FDD64F411E = int(tablelookupgetnumcols(level._id_F684D37D5503EEBA.gulagloadouttable));
  _id_953ABAF49E83F2E4 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E99060FDD64F411E; _id_AC0E594AC96AA3A8++)
    _id_953ABAF49E83F2E4[_id_953ABAF49E83F2E4.size] = tablelookupbyrow(level._id_F684D37D5503EEBA.gulagloadouttable, index, _id_AC0E594AC96AA3A8);

  loadout["loadoutArchetype"] = _id_953ABAF49E83F2E4[2];
  loadout["loadoutPrimary"] = _id_953ABAF49E83F2E4[3];
  loadout["loadoutPrimaryAttachment"] = _id_953ABAF49E83F2E4[4];
  loadout["loadoutPrimaryAttachment2"] = _id_953ABAF49E83F2E4[5];
  loadout["loadoutPrimaryAttachment3"] = _id_953ABAF49E83F2E4[6];
  loadout["loadoutPrimaryAttachment4"] = _id_953ABAF49E83F2E4[7];
  loadout["loadoutPrimaryAttachment5"] = _id_953ABAF49E83F2E4[8];
  loadout["loadoutPrimaryCamo"] = _id_953ABAF49E83F2E4[9];
  loadout["loadoutPrimaryReticle"] = _id_953ABAF49E83F2E4[10];
  loadout["loadoutSecondary"] = _id_953ABAF49E83F2E4[11];
  loadout["loadoutSecondaryAttachment"] = _id_953ABAF49E83F2E4[12];
  loadout["loadoutSecondaryAttachment2"] = _id_953ABAF49E83F2E4[13];
  loadout["loadoutSecondaryAttachment3"] = _id_953ABAF49E83F2E4[14];
  loadout["loadoutSecondaryAttachment4"] = _id_953ABAF49E83F2E4[15];
  loadout["loadoutSecondaryAttachment5"] = _id_953ABAF49E83F2E4[16];
  loadout["loadoutSecondaryCamo"] = _id_953ABAF49E83F2E4[17];
  loadout["loadoutSecondaryReticle"] = _id_953ABAF49E83F2E4[18];
  loadout["loadoutMeleeSlot"] = _id_953ABAF49E83F2E4[19];
  loadout["loadoutEquipmentPrimary"] = _id_953ABAF49E83F2E4[20];
  loadout["loadoutEquipmentSecondary"] = _id_953ABAF49E83F2E4[21];
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = ["specialty_null"];
  loadout["loadoutGesture"] = "playerData";
  return loadout;
}

_id_1FC65FF42AFBB7FC(arena, player) {
  if(!isDefined(arena._id_654C981854394718))
    arena._id_654C981854394718 = [];

  arena._id_654C981854394718 = scripts\engine\utility::array_add(arena._id_654C981854394718, player);
}

_id_1B2E2FD7F80FDD0B(arena) {
  arena._id_06984048B2D336A7 = arena._id_AEAC6A7F3FB3167F;
  arena._id_06984048B2D336A7 = sortbydistance(arena._id_06984048B2D336A7, arena.center);
  arena._id_06984048B2D336A7 = scripts\engine\utility::array_reverse(arena._id_06984048B2D336A7);
}

_id_33C93A39C558A492(arena) {
  _id_DF6698A1AD9D50BF = [];

  foreach(_id_D1FCEC4DEA575B18 in arena.fightspawns) {
    if(_id_D1FCEC4DEA575B18.script_index == 0 || _id_D1FCEC4DEA575B18.script_index == 1 || _id_D1FCEC4DEA575B18.script_index == 6 || _id_D1FCEC4DEA575B18.script_index == 7)
      _id_DF6698A1AD9D50BF[_id_DF6698A1AD9D50BF.size] = _id_D1FCEC4DEA575B18;
  }

  _id_DF6698A1AD9D50BF = scripts\engine\utility::array_sort_by_script_index(_id_DF6698A1AD9D50BF);
  arena.fightspawns = _id_DF6698A1AD9D50BF;
}

_id_C525D1DF15D88A84(agent, _id_6181DE250AFA5BB6) {
  if(!isPlayer(_id_6181DE250AFA5BB6)) {
    return;
  }
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(_id_6181DE250AFA5BB6);

  if(!isDefined(arena)) {
    return;
  }
  if(!isDefined(_id_6181DE250AFA5BB6._id_F73178C689F257AE))
    _id_6181DE250AFA5BB6._id_F73178C689F257AE = 0;

  _id_6181DE250AFA5BB6._id_F73178C689F257AE = _id_6181DE250AFA5BB6._id_F73178C689F257AE + 1;

  if(_id_CF70188E00C433C4(arena)) {
    arena thread _id_50FC80E21E19D442();

    foreach(player in arena.arenaplayers) {
      if(!isDefined(player)) {
        continue;
      }
      if(!istrue(player.gulag)) {
        continue;
      }
      if(istrue(player._id_4AF73CE40A5D8572)) {
        continue;
      }
      player _id_0DC0A56E258889CB(arena, "br_twotwo_jailer_gulag_win");
    }

    return;
  }

  if(isDefined(level._id_43307855F189EB31._id_B18455B0E6B6E213)) {
    if(level._id_43307855F189EB31._id_B18455B0E6B6E213 == 1) {
      arena thread _id_50FC80E21E19D442();
      _id_E4C8A8DCD301EE41 = _id_861C9EC1A22D6AA4(_id_6181DE250AFA5BB6);

      foreach(player in _id_E4C8A8DCD301EE41) {
        if(!isDefined(player)) {
          continue;
        }
        if(!istrue(player.gulag)) {
          continue;
        }
        if(istrue(player._id_4AF73CE40A5D8572)) {
          continue;
        }
        player _id_0DC0A56E258889CB(arena, "br_twotwo_jailer_gulag_win");
        player thread _id_3583FF375AB3A91E::_id_696F54DA8FCB6BBE("twotwo_gulag_jailer_dead", arena);
      }

      return;
    } else if(level._id_43307855F189EB31._id_B18455B0E6B6E213 == 2) {
      _id_9135ADA02E07BF10(arena, "br_twotwo_jailer_gulag_win", 1);
      return;
    }
  }

  if(istrue(level._id_43307855F189EB31._id_6EFB9D0AFA7EFCB2) && !istrue(arena._id_2D0904DA1AC3FB61)) {
    arena._id_2D0904DA1AC3FB61 = 1;
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    agent thread _id_7E52B56769FA7774::_id_55463A3679678E2F(dropstruct, arena);
  }
}

_id_9135ADA02E07BF10(arena, _id_5D77A96DCFE7FA54, _id_BD8EBD50121F174E) {
  arena thread _id_50FC80E21E19D442();

  foreach(player in arena.arenaplayers) {
    if(!isDefined(player)) {
      continue;
    }
    if(!istrue(player.gulag)) {
      continue;
    }
    if(istrue(player._id_4AF73CE40A5D8572)) {
      continue;
    }
    player _id_0DC0A56E258889CB(arena, _id_5D77A96DCFE7FA54);

    if(istrue(_id_BD8EBD50121F174E))
      player thread _id_3583FF375AB3A91E::_id_696F54DA8FCB6BBE("twotwo_gulag_jailer_dead", arena);
  }
}

_id_ED93A4074BBF2E51(attacker) {
  if(!isPlayer(attacker)) {
    return;
  }
  if(!isDefined(attacker._id_32484CD3B17F16C8))
    attacker._id_32484CD3B17F16C8 = 0;

  attacker._id_32484CD3B17F16C8 = attacker._id_32484CD3B17F16C8 + 1;
}

_id_A4C35FE489CC7DA5() {
  player = self;
  player waittill("gulag_outline_removed");

  if(isDefined(player) && player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
    _id_E4C8A8DCD301EE41 = _id_861C9EC1A22D6AA4(player);

    foreach(_id_AC0E424AC96A7113 in _id_E4C8A8DCD301EE41) {
      if(!isDefined(_id_AC0E424AC96A7113) || !istrue(_id_AC0E424AC96A7113.gulag) || _id_AC0E424AC96A7113 == player) {
        continue;
      }
      _id_AC0E424AC96A7113 thread _id_3583FF375AB3A91E::_id_DA46DE174875958A(player, "outline_nodepth_green");
    }
  }
}

_id_720EF3A3E6616AB7(value) {
  player = self;
  player setclientomnvar("ui_br_ai_gulag_score", value);
}

_id_CC5468BB6E866411(arena) {
  foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
    if(!isDefined(_id_AC0E424AC96A7113)) {
      continue;
    }
    _id_AC0E424AC96A7113 _id_6D217BA4DE4B166B(arena);
    _id_AC0E424AC96A7113 _id_FB51BDAA21D694E5(arena);
  }

  foreach(_id_AC0E424AC96A7113 in arena.jailedplayers) {
    if(!isDefined(_id_AC0E424AC96A7113)) {
      continue;
    }
    _id_AC0E424AC96A7113 _id_6D217BA4DE4B166B(arena);
    _id_AC0E424AC96A7113 _id_FB51BDAA21D694E5(arena);
  }
}

_id_6D217BA4DE4B166B(arena) {
  player = self;
  _id_C8A5261A0FCA66D4 = 0;
  _id_4C096C17E2C382E1 = 0;
  _id_77FA43FC5F58845D = 4;

  if(_id_CF70188E00C433C4(arena))
    _id_77FA43FC5F58845D = 2;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_77FA43FC5F58845D; _id_AC0E594AC96AA3A8++) {
    _id_AC0E424AC96A7113 = arena.arenaplayers[_id_AC0E594AC96AA3A8];

    if(!isDefined(_id_AC0E424AC96A7113) || !_id_AC0E424AC96A7113 _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
      _id_C53E78332A6C514F = 0;
    else
      _id_C53E78332A6C514F = _id_AC0E424AC96A7113 getentitynumber() + 1;

    _id_C99096116AFD1827 = 255;
    _id_C8A5261A0FCA66D4 = _id_C8A5261A0FCA66D4 + ((int(_id_C53E78332A6C514F) &_id_C99096116AFD1827) << _id_4C096C17E2C382E1);
    _id_4C096C17E2C382E1 = _id_4C096C17E2C382E1 + 8;
  }

  player setclientomnvar("ui_br_twotwo_gulag_players", _id_C8A5261A0FCA66D4);
}

_id_FB51BDAA21D694E5(arena) {
  player = self;
  _id_C8A5261A0FCA66D4 = 0;
  _id_4C096C17E2C382E1 = 0;
  _id_77FA43FC5F58845D = 4;

  if(_id_CF70188E00C433C4(arena))
    _id_77FA43FC5F58845D = 2;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_77FA43FC5F58845D; _id_AC0E594AC96AA3A8++) {
    _id_AC0E424AC96A7113 = arena.arenaplayers[_id_AC0E594AC96AA3A8];
    _id_C8D776E41ECC6881 = _id_A3404116E7794C47(player, _id_AC0E424AC96A7113, arena);
    _id_62B5521602CBB385 = 7;
    _id_C8A5261A0FCA66D4 = _id_C8A5261A0FCA66D4 + ((int(_id_C8D776E41ECC6881) &_id_62B5521602CBB385) << _id_4C096C17E2C382E1);
    _id_4C096C17E2C382E1 = _id_4C096C17E2C382E1 + 3;
  }

  player setclientomnvar("ui_br_twotwo_gulag_players_state", _id_C8A5261A0FCA66D4);
}

_id_A3404116E7794C47(player, _id_435B226327D6361A, arena) {
  if(!isDefined(_id_435B226327D6361A) || !_id_435B226327D6361A _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
    return 0;

  if(!isalive(_id_435B226327D6361A))
    return 1;

  if(player == _id_435B226327D6361A)
    return 3;

  _id_407BF5DB5DB81053 = scripts\engine\utility::array_contains(arena.jailedplayers, player);

  if(_id_407BF5DB5DB81053)
    return 2;

  if(_id_435B226327D6361A.team == player.team)
    return 5;
  else {
    _id_F3CEF7E5EBAD72E0 = scripts\engine\utility::array_contains(arena._id_801CDCFADC4D465C, _id_435B226327D6361A);

    if(_id_F3CEF7E5EBAD72E0) {
      _id_EB3D6FA548FA6972 = scripts\engine\utility::array_contains(arena._id_801CDCFADC4D465C, player);

      if(_id_EB3D6FA548FA6972)
        return 4;
    } else {
      _id_55FF96A652E94EA8 = scripts\engine\utility::array_contains(arena._id_AF5243FBBA0720C2, player);

      if(_id_55FF96A652E94EA8)
        return 4;
    }

    return 6;
  }
}

_id_861C9EC1A22D6AA4(player) {
  if(!isDefined(player)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.gulag.arenas.size; _id_AC0E594AC96AA3A8++) {
    _id_F40E6DEEC30EE209 = level.gulag.arenas[_id_AC0E594AC96AA3A8];

    if(isDefined(_id_F40E6DEEC30EE209._id_801CDCFADC4D465C)) {
      foreach(_id_31210CE93279D451 in _id_F40E6DEEC30EE209._id_801CDCFADC4D465C) {
        if(_id_31210CE93279D451 == player)
          return _id_F40E6DEEC30EE209._id_801CDCFADC4D465C;
      }
    }

    if(isDefined(_id_F40E6DEEC30EE209._id_AF5243FBBA0720C2)) {
      foreach(_id_31210CE93279D451 in _id_F40E6DEEC30EE209._id_AF5243FBBA0720C2) {
        if(_id_31210CE93279D451 == player)
          return _id_F40E6DEEC30EE209._id_AF5243FBBA0720C2;
      }
    }
  }

  return undefined;
}

_id_1BD32287885BB933(player) {
  if(!isDefined(player))
    return undefined;

  _id_15D6E806D3E1ED4A = _id_861C9EC1A22D6AA4(player);

  if(isDefined(_id_15D6E806D3E1ED4A)) {
    foreach(_id_AC0E424AC96A7113 in _id_15D6E806D3E1ED4A) {
      if(!isDefined(_id_AC0E424AC96A7113)) {
        continue;
      }
      if(_id_AC0E424AC96A7113 != player)
        return _id_AC0E424AC96A7113;
    }
  }

  return undefined;
}

_id_488428F4237C7E87(player) {
  if(!isDefined(player)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.gulag.arenas.size; _id_AC0E594AC96AA3A8++) {
    _id_F40E6DEEC30EE209 = level.gulag.arenas[_id_AC0E594AC96AA3A8];

    if(isDefined(_id_F40E6DEEC30EE209._id_801CDCFADC4D465C)) {
      foreach(_id_31210CE93279D451 in _id_F40E6DEEC30EE209._id_801CDCFADC4D465C) {
        if(!isDefined(_id_31210CE93279D451)) {
          continue;
        }
        if(_id_31210CE93279D451 == player)
          return _id_F40E6DEEC30EE209._id_AF5243FBBA0720C2;
      }
    }

    if(isDefined(_id_F40E6DEEC30EE209._id_AF5243FBBA0720C2)) {
      foreach(_id_31210CE93279D451 in _id_F40E6DEEC30EE209._id_AF5243FBBA0720C2) {
        if(!isDefined(_id_31210CE93279D451)) {
          continue;
        }
        if(_id_31210CE93279D451 == player)
          return _id_F40E6DEEC30EE209._id_801CDCFADC4D465C;
      }
    }
  }

  return undefined;
}

_id_66BA5F24FBB13A23(player) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.gulag.arenas.size; _id_AC0E594AC96AA3A8++) {
    _id_F40E6DEEC30EE209 = level.gulag.arenas[_id_AC0E594AC96AA3A8];

    foreach(jailedplayers in _id_F40E6DEEC30EE209.jailedplayers) {
      if(jailedplayers == player) {
        arena = level.gulag.arenas[_id_AC0E594AC96AA3A8];
        return arena;
      }
    }
  }

  return undefined;
}

_id_6E3541FD8FAB45BC() {
  if(isDefined(level._id_43307855F189EB31) && level._id_43307855F189EB31.name == "gulag_twotwo")
    return 1;

  return 0;
}

_id_CCF74B81F01F0BF1(arena) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");

  foreach(_id_3CCB8742D21B61D7 in arena._id_CEFC1BF41237BBAC)
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_3CCB8742D21B61D7.objid, player);

  _id_3583FF375AB3A91E::_id_00BA5DBC7633C84A(arena);
  wait 12;

  if(!isDefined(player)) {
    return;
  }
  player.gulag = 0;
  player _id_3583FF375AB3A91E::_id_3F18739AE34D9958();
  player _id_67708F418B1FAC79::playergulagautowin("gulagInfinite", player, undefined, undefined, undefined, 1);
  wait 12;

  if(!isDefined(player)) {
    return;
  }
  player.gulagloser = undefined;

  if(!player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
    player kill();
}

_id_BB22CAE6DD0B7899() {
  if(isDefined(level._id_43307855F189EB31) && istrue(level._id_43307855F189EB31._id_D06B935D7D60DE61))
    return 1;

  return 0;
}

_id_452AB051852E4DF1() {
  player = self;

  if(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag() && istrue(player._id_43B2A82936A5E974) && istrue(level._id_43307855F189EB31._id_EC2EAA1A4B68C0CF))
    return 1;

  return 0;
}

_id_7873119D67C51A6D() {
  arena = self;
  arena endon("matchEnded");
  arena endon("fight_over");
  _id_67708F418B1FAC79::setovertimeomnvarenabled(arena, 1);

  if(level._id_43307855F189EB31._id_789D529318E2DF1B == 1) {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

    if(isDefined(arena._id_707537A8904AA962)) {
      foreach(agent in arena._id_707537A8904AA962) {
        if(!istrue(arena._id_2D0904DA1AC3FB61)) {
          agent thread _id_7E52B56769FA7774::_id_55463A3679678E2F(dropstruct, arena);
          arena._id_2D0904DA1AC3FB61 = 1;
        }
      }

      return;
    }
  } else if(level._id_43307855F189EB31._id_789D529318E2DF1B == 2) {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    arena._id_2D0904DA1AC3FB61 = 1;

    if(isDefined(arena._id_707537A8904AA962)) {
      foreach(agent in arena._id_707537A8904AA962) {
        agent thread _id_7E52B56769FA7774::_id_55463A3679678E2F(dropstruct, arena);

        foreach(player in arena.arenaplayers)
        player thread scripts\mp\hud_message::showsplash("br_twotwo_gulag_key_dropped");

        _id_3583FF375AB3A91E::_id_9F7B9A86A5328F0B(arena, agent.origin);
        wait 0.3;
        agent kill();
      }

      return;
    }
  } else if(level._id_43307855F189EB31._id_789D529318E2DF1B == 3) {
    _id_73D9D766F03D3E99 = getgroundposition(arena.center, 1);
    scriptable = level.br_pickups._id_838863C4848D4C26["loot_key_gulag"];
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_73D9D766F03D3E99, (0, 0, 0), undefined, level.br_pickups._id_AD49A38DD7C4C10F, level.br_pickups._id_3B53BC0EEE6AE84E);
    item = _id_7E52B56769FA7774::spawnpickup(scriptable, _id_CB4FAD49263E20C4, 1, 1, undefined, 0);
    arena._id_6D4E3B180776136F[arena._id_6D4E3B180776136F.size] = item;

    foreach(player in arena.arenaplayers)
    player thread scripts\mp\hud_message::showsplash("br_twotwo_gulag_key_spawned_center");

    _id_3583FF375AB3A91E::_id_9F7B9A86A5328F0B(arena, item.origin);
    playsoundatpos(_id_73D9D766F03D3E99, "flag_spawned");
  } else if(level._id_43307855F189EB31._id_789D529318E2DF1B == 4) {
    wait(level._id_43307855F189EB31._id_B1985D454F9B2200);

    if(istrue(level._id_43307855F189EB31._id_B155C6403AE16B83))
      arena thread _id_46FDF7B12C5F5620::_id_5427C6229B93668E(arena._id_06984048B2D336A7, 11, 1.2);
  }
}

_id_8CD391E5244B5670(arena) {
  if(!isDefined(arena._id_707537A8904AA962)) {
    arena._id_7B2D0FF4698FB2E9 = 1;

    if(isDefined(arena._id_79F102B3ABCC6F8A))
      thread _id_3AEE652DA47A2A39(arena);

    arena waittill("matchEnded");
    thread _id_D6B701F1CB759BD5(arena);
  }
}

_id_9B254813C229A51C() {
  category = "gulag";
  _id_48814951E916AF89::_id_BA4022744DCE59F6(category);
}

_id_3AEE652DA47A2A39(arena) {
  if(_id_3583FF375AB3A91E::_id_D8F18F1D691C0EF8(arena))
    thread _id_5CDA031797DCE489::_id_89235E4FE5354B16(arena);
}

_id_D1F5AADDAB74BD10(arena, _id_55E69FB0CE97F15E) {
  aitype = "enemy_mp_smg_tier1_aq";
  _id_2AC210AF318CF38B = _id_55E69FB0CE97F15E.origin;

  if(!getdvarint("dvar_B3D7A9483362813E", 0))
    _id_2AC210AF318CF38B = getclosestpointonnavmesh(_id_55E69FB0CE97F15E.origin);

  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_2AC210AF318CF38B, _id_55E69FB0CE97F15E.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1);

  if(isagent(agent)) {
    agent thread _id_82EEE32BB4C490D8(arena);

    if(getdvarint("dvar_B3D7A9483362813E", 0)) {
      agent forceteleport(_id_2AC210AF318CF38B, _id_55E69FB0CE97F15E.angles);
      agent setgoalpos(agent.origin, 32);
      agent clearpath();
      agent.fixednode = 1;
      agent thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent, 1, agent.origin);
    } else
      agent thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent);
  }
}

_id_9119DE486A6FA5CD(arena) {
  if(!istrue(arena._id_7B2D0FF4698FB2E9))
    _id_8CD391E5244B5670(arena);
}

_id_82EEE32BB4C490D8(arena) {
  if(!isDefined(arena._id_707537A8904AA962))
    arena._id_707537A8904AA962 = [];

  arena._id_707537A8904AA962 = scripts\engine\utility::array_add(arena._id_707537A8904AA962, self);

  if(getdvarint("dvar_CEF54D9E018C7722", 0)) {
    _id_F7A309109C19A8EB = scripts\engine\utility::array_combine(arena.arenaplayers, arena.jailedplayers);

    foreach(player in _id_F7A309109C19A8EB) {
      if(!isDefined(player)) {
        continue;
      }
      player _id_3583FF375AB3A91E::_id_DA46DE174875958A(self, "outline_nodepth_red", -1);
    }
  }
}

_id_3AAD61CBC63B74C8(arena) {
  if(isDefined(arena._id_707537A8904AA962)) {
    arena._id_707537A8904AA962 = scripts\engine\utility::array_remove(arena._id_707537A8904AA962, self);

    if(isagent(self)) {
      self notify("jailer_stop_firing");
      self stoploopsound("mus_jugg_01_hp");

      if(isalive(self)) {
        _id_DBD4CBA5D524EBA9(arena);
        _id_48814951E916AF89::_id_28B90EB2B591003F();
      } else if(getdvarint("dvar_82733198D2D5B09E", 1)) {
        if(isDefined(arena._id_A88CD2794AE356A7) && arena._id_A88CD2794AE356A7._id_0E0624B9863250A2 == "jailer_guard")
          wait 10;

        body = self getcorpseentity();

        if(isDefined(body))
          body delete();
      }
    }

    if(isDefined(arena._id_707537A8904AA962) && arena._id_707537A8904AA962.size <= 0)
      arena._id_707537A8904AA962 = undefined;
  }
}

_id_DBD4CBA5D524EBA9(arena) {
  agent = self;
  arena endon("arena_about_to_prep_for_next_match");
  level endon("game_ended");
  _id_E875263615163617 = 4.0;
  _id_C9EC98ACF0094360 = 200.0;
  exitposition = arena._id_198C1CB09F6DBFB1.origin + (-18, 205, -128);
  agent clearbtgoal(2);
  waitframe();

  if(!isDefined(agent)) {
    return;
  }
  agent.ignoreall = 1;
  agent _id_120270BD0A747A35::_id_304DA84D9A815C01(exitposition, _id_E875263615163617);
  agent aisetdesiredspeed(_id_C9EC98ACF0094360);
  starttime = gettime();
  _id_77836FF44D4CA9DD = getdvarint("dvar_5B82B0CF2B0FF269", 10000);

  while(distance2d(agent.origin, exitposition) > 4.0) {
    _id_3B5803E733581858 = gettime() - starttime;

    if(_id_3B5803E733581858 >= _id_77836FF44D4CA9DD) {
      break;
    }

    waitframe();
  }
}

_id_D6B701F1CB759BD5(arena) {
  if(isDefined(arena._id_707537A8904AA962)) {
    foreach(agent in arena._id_707537A8904AA962) {
      if(isagent(agent)) {
        agent thread _id_3AAD61CBC63B74C8(arena);
        agent setthreatbiasgroup();
      }
    }

    arena._id_707537A8904AA962 = undefined;
    arena._id_7B2D0FF4698FB2E9 = undefined;
  }

  _id_2E903A90A966D9C2 = 2650;
  _id_F9D6732A60363240 = getlootscriptablearrayinradius(undefined, undefined, arena.center, _id_2E903A90A966D9C2);

  foreach(_id_D8CD9C1941A88194 in _id_F9D6732A60363240) {
    if(_id_D8CD9C1941A88194 getscriptableisreserved() && _id_D8CD9C1941A88194 getscriptableisloot())
      _id_D8CD9C1941A88194 _id_7E52B56769FA7774::deletescriptableinstance();
  }
}

_id_12801693C8C241BB(arena) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++)
    arena._id_02A7E62879A75FFE[arena._id_02A7E62879A75FFE.size] = getscriptcachecontents(level._id_42706F92B61AB857, _id_AC0E594AC96AA3A8);
}

_id_144FC7F54908932F(arena) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++)
    arena._id_49E6D5114201A22B[arena._id_49E6D5114201A22B.size] = getscriptcachecontents(level._id_1D446B9562CAD6CB, _id_AC0E594AC96AA3A8);
}

_id_B2D8F9ADEE070020(arena) {
  _id_07205FAB5AC6F58E = 0;
  _id_A29AC4899ACD2C08 = arena._id_2C4104D74359893B;
  _id_39CE9039C3660D76 = "";
  maxcount = 0;

  while(_id_07205FAB5AC6F58E < level._id_F684D37D5503EEBA._id_B61A334EC66DB6A9) {
    _id_07205FAB5AC6F58E++;
    _id_9AE625E33B2FC5F6 = _id_A29AC4899ACD2C08.size;
    _id_8B591B0BC361AB3D = randomint(_id_9AE625E33B2FC5F6);
    _id_EFCCE422369F16A3 = arena._id_02A7E62879A75FFE.size;
    _id_D6A189DEAFCB31FD = randomint(_id_EFCCE422369F16A3);
    scriptablename = arena._id_02A7E62879A75FFE[_id_D6A189DEAFCB31FD][_id_07205FAB5AC6F58E - 1];

    if(!isDefined(scriptablename) || scriptablename == "") {
      _id_A29AC4899ACD2C08 = scripts\engine\utility::array_remove(_id_A29AC4899ACD2C08, _id_A29AC4899ACD2C08[_id_8B591B0BC361AB3D]);
      continue;
    }

    if(issubstr(scriptablename, "weapon")) {
      weaponname = _id_7E52B56769FA7774::getfullweaponobjfromscriptablename(scriptablename);
      _id_E52A49E4832AC060 = weaponclipsize(weaponname) * 2;
    } else
      _id_E52A49E4832AC060 = level.br_pickups.counts[scriptablename];

    if(!isDefined(_id_E52A49E4832AC060))
      _id_E52A49E4832AC060 = 1;

    _id_CB4FAD49263E20C4 = spawnStruct();
    _id_CB4FAD49263E20C4.origin = _id_A29AC4899ACD2C08[_id_8B591B0BC361AB3D].origin;
    _id_CB4FAD49263E20C4.angles = (0, 0, 0);
    _id_CB4FAD49263E20C4.payload = 0;
    _id_D8CD9C1941A88194 = _id_7E52B56769FA7774::spawnpickup(scriptablename, _id_CB4FAD49263E20C4, _id_E52A49E4832AC060);
    _id_39CE9039C3660D76 = _id_A29AC4899ACD2C08[_id_8B591B0BC361AB3D].script_noteworthy;
    _id_A29AC4899ACD2C08 = scripts\engine\utility::array_remove(_id_A29AC4899ACD2C08, _id_A29AC4899ACD2C08[_id_8B591B0BC361AB3D]);
    _id_A29AC4899ACD2C08 = _id_7F32923C29BCF243(arena._id_02A7E62879A75FFE, _id_A29AC4899ACD2C08, scriptablename, _id_39CE9039C3660D76, _id_E52A49E4832AC060);
  }
}

_id_FCC8620F60CA604C(arena) {
  _id_C68EE1A747F552E2 = 0;
  _id_A29AC4899ACD2C08 = arena._id_AEAC6A7F3FB3167F;
  _id_39CE9039C3660D76 = "";

  while(_id_C68EE1A747F552E2 < level._id_F684D37D5503EEBA._id_1D8A378E37A1B6E5 && _id_C68EE1A747F552E2 < arena._id_49E6D5114201A22B[0].size) {
    _id_C68EE1A747F552E2++;
    _id_9AE625E33B2FC5F6 = _id_A29AC4899ACD2C08.size;
    _id_8B591B0BC361AB3D = randomint(_id_9AE625E33B2FC5F6);
    scriptablename = arena._id_49E6D5114201A22B[0][_id_C68EE1A747F552E2 - 1];

    if(!isDefined(scriptablename) || scriptablename == "") {
      _id_A29AC4899ACD2C08 = scripts\engine\utility::array_remove(_id_A29AC4899ACD2C08, _id_A29AC4899ACD2C08[_id_8B591B0BC361AB3D]);
      continue;
    }

    _id_E52A49E4832AC060 = level.br_pickups.counts[scriptablename];

    if(!isDefined(_id_E52A49E4832AC060))
      _id_E52A49E4832AC060 = 1;

    _id_CB4FAD49263E20C4 = spawnStruct();
    _id_CB4FAD49263E20C4.origin = _id_A29AC4899ACD2C08[_id_8B591B0BC361AB3D].origin;
    _id_CB4FAD49263E20C4.angles = (0, 0, 0);
    _id_CB4FAD49263E20C4.payload = 0;
    _id_D8CD9C1941A88194 = _id_7E52B56769FA7774::spawnpickup(scriptablename, _id_CB4FAD49263E20C4, _id_E52A49E4832AC060);
    _id_D8CD9C1941A88194._id_1B46A808091EA19C = 1;
    _id_39CE9039C3660D76 = _id_A29AC4899ACD2C08[_id_8B591B0BC361AB3D].script_noteworthy;
    _id_A29AC4899ACD2C08 = scripts\engine\utility::array_remove(_id_A29AC4899ACD2C08, _id_A29AC4899ACD2C08[_id_8B591B0BC361AB3D]);
    _id_A29AC4899ACD2C08 = _id_7F32923C29BCF243(arena._id_49E6D5114201A22B, _id_A29AC4899ACD2C08, scriptablename, _id_39CE9039C3660D76, _id_E52A49E4832AC060);
  }
}

_id_7F32923C29BCF243(itemlist, _id_A29AC4899ACD2C08, scriptablename, _id_39CE9039C3660D76, _id_E52A49E4832AC060) {
  for(_id_9BD4297F76B63747 = 0; _id_9BD4297F76B63747 < _id_A29AC4899ACD2C08.size; _id_9BD4297F76B63747++) {
    if(_id_A29AC4899ACD2C08[_id_9BD4297F76B63747].script_noteworthy == _id_39CE9039C3660D76) {
      _id_CB4FAD49263E20C4 = spawnStruct();
      _id_CB4FAD49263E20C4.origin = _id_A29AC4899ACD2C08[_id_9BD4297F76B63747].origin;
      _id_CB4FAD49263E20C4.angles = (0, 0, 0);
      _id_CB4FAD49263E20C4.payload = 0;
      _id_D8CD9C1941A88194 = _id_7E52B56769FA7774::spawnpickup(scriptablename, _id_CB4FAD49263E20C4, _id_E52A49E4832AC060);
      _id_D8CD9C1941A88194._id_1B46A808091EA19C = 1;
      _id_A29AC4899ACD2C08 = scripts\engine\utility::array_remove(_id_A29AC4899ACD2C08, _id_A29AC4899ACD2C08[_id_9BD4297F76B63747]);
      break;
    }
  }

  return _id_A29AC4899ACD2C08;
}

_id_0AB674FC3132AFE8(arena) {
  if(level._id_F684D37D5503EEBA._id_1D8A378E37A1B6E5 > arena._id_AEAC6A7F3FB3167F.size / 2)
    level._id_F684D37D5503EEBA._id_1D8A378E37A1B6E5 = arena._id_AEAC6A7F3FB3167F.size / 2;

  if(level._id_F684D37D5503EEBA._id_B61A334EC66DB6A9 > arena._id_2C4104D74359893B.size / 2)
    level._id_F684D37D5503EEBA._id_B61A334EC66DB6A9 = arena._id_2C4104D74359893B.size / 2;
}

_id_5EAF324209D1C3F0() {
  level._id_1D446B9562CAD6CB = "sc_gulag_items_1";
  level._id_42706F92B61AB857 = "sc_gulag_cash_1";

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
    switch (level.br_circle.circleindex) {
      case 0:
        level._id_1D446B9562CAD6CB = "sc_gulag_items_1";
        level._id_42706F92B61AB857 = "sc_gulag_cash_1";
        break;
      case 1:
        level._id_1D446B9562CAD6CB = "sc_gulag_items_2";
        level._id_42706F92B61AB857 = "sc_gulag_cash_2";
        break;
      case 2:
        level._id_1D446B9562CAD6CB = "sc_gulag_items_3";
        level._id_42706F92B61AB857 = "sc_gulag_cash_3";
        break;
      case 3:
        level._id_1D446B9562CAD6CB = "sc_gulag_items_4";
        level._id_42706F92B61AB857 = "sc_gulag_cash_4";
        break;
      default:
        level._id_1D446B9562CAD6CB = "sc_gulag_items_1";
        level._id_42706F92B61AB857 = "sc_gulag_cash_1";
    }
  }
}