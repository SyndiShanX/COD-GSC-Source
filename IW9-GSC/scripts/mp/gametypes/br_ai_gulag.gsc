/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_ai_gulag.gsc
************************************************/

_id_4A0935954BBFDEB1() {
  level._id_37E52C7FB7267EFC = spawnStruct();
  level._id_37E52C7FB7267EFC._id_2E88FFF6C419EE6A = 1;
  level._id_37E52C7FB7267EFC._id_7D4922396DAA0192 = getdvarint("dvar_674E53F15C9FF53D", 1);
  level._id_37E52C7FB7267EFC._id_37AFB6F23303B55A = getdvarint("dvar_7E7947CCB6191852", 1);
  level._id_37E52C7FB7267EFC._id_5CD8016B769D02AA = getdvarint("dvar_BC73689CD8209E75", 1);
  level._id_37E52C7FB7267EFC._id_4B133D9C5B92891D = getdvarint("dvar_A3F1CFF5C396D63D", 12);
  level._id_37E52C7FB7267EFC._id_E74CDBC9111D53C7 = getdvarint("dvar_5B3585AFD70EAF8E", 0);
  level._id_37E52C7FB7267EFC._id_2713A9CF5318D984 = getdvarint("dvar_A206A25A0CE81DDA", 1);
  level._id_37E52C7FB7267EFC._id_5B74E1E54F3F3B74 = getdvarint("dvar_F14D2F2480B4B618", 0);
  level._id_37E52C7FB7267EFC._id_54C7916BCEA2B113 = getdvarint("dvar_8993DD89B4D00B97", 0);
  level._id_37E52C7FB7267EFC._id_3564A4453EAFCACB = getdvarint("dvar_D824B632CCB82353", 0);
  level._id_37E52C7FB7267EFC._id_F98AEC28092AE4F2 = getdvarfloat("dvar_0546A3F7597C568A", 9.0);
  level._id_37E52C7FB7267EFC._id_F04A0FB05108F52E = getdvarint("dvar_EACCAF202728CE0C", 0);
  level._id_37E52C7FB7267EFC._id_DDCC046E7B061885 = getdvarint("dvar_8D62B3080C53B03F", 0);
  level._id_37E52C7FB7267EFC._id_609A4F76DCE95688 = getdvarint("dvar_BFBFCD12D33DCE15", 1);
  level._id_37E52C7FB7267EFC._id_BE0BBFD2065C69B3 = getdvarint("dvar_19476C64D4742882", 0);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetMatchDuration", ::_id_92CFA932B04A6719);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagIsMatchPending", ::_id_D1B3EED24BB52B44);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetClosedCircleIndex", ::_id_EBAFDB7112DB8628);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetCountdownLength", ::_id_441F914BA636643B);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagIsOneTeamLeft", ::_id_94AA98226F7A425C);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetVictoryWait", ::_id_EB1596A5DAEA0EF5);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetPostVictoryWait", ::_id_D556BD222194D447);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagHandleLossInfiniteEarly", ::_id_BD71F506AF2CAC70);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGiveAIKillRewards", ::_id_F561AF47DB779C79);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagWinSequence", ::_id_2B0FD45EF612B4A5);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagLoseSequence", ::_id_9DBB71AAAE4E335E);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulag_startWaitingStartTime", ::_id_FD55F9D5EF55B95E);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulag_initPlayerArena", ::_id_9D53E328C2D1AEC4);
  _id_5BC60484D17FA95C::_id_8DEBF0C616BF9480("gulagOvertime");
  level _id_48814951E916AF89::_id_93ADD0B65DB9F722(::_id_A7A1D8D937762614);
  level thread _id_9D02912CFE66605A();

  if(!isDefined(level._id_289DF80E1DED586F))
    thread _id_48814951E916AF89::init();

  if(_id_3583FF375AB3A91E::_id_7AD9FCB1AC4F3DB8())
    level thread _id_669D65FCD2AC3D84();

  level thread _id_5CDA031797DCE489::_id_25A296C2ED85E35F();
}

_id_9D02912CFE66605A() {
  level waittill("prematch_done");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("second_chance_cargo", ::_id_F63BAAD2F7765F34);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("second_chance_cable", ::_id_875F67700E4D2769);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("second_chance_camera", ::_id_6C9AE1F39F71F7E1);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("second_chance_bag", ::_id_E40FAA26DA957604);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("second_chance_vent", ::_id_0B0F86BE8E080101);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("second_chance_door", ::_id_3BC6F653F16663AA);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("second_chance_door_win", ::_id_B7E4CBD2A1618BDC);

  if(istrue(level._id_37E52C7FB7267EFC._id_E74CDBC9111D53C7))
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("second_chance_drive", ::_id_ED3B3A2040C051A6);

  foreach(arena in level.gulag.arenas) {
    _id_F50999508E0B9282 = getEntArray(arena.target, "targetname");

    foreach(_id_DFA9FB8402123505 in _id_F50999508E0B9282) {
      if(!isDefined(_id_DFA9FB8402123505.script_noteworthy)) {
        continue;
      }
      if(_id_DFA9FB8402123505.script_noteworthy == "gulag_ai_goal_door") {
        arena._id_42097EB056866B9C = _id_DFA9FB8402123505;

        if(!istrue(level._id_37E52C7FB7267EFC._id_E74CDBC9111D53C7)) {
          arena._id_42097EB056866B9C delete();
          continue;
        }
      }

      if(_id_DFA9FB8402123505.script_noteworthy == "gulag_ai_goal_volume") {
        if(!istrue(level._id_37E52C7FB7267EFC._id_609A4F76DCE95688))
          arena._id_B59E8B6B1C730B69 = _id_DFA9FB8402123505;
      }

      if(_id_DFA9FB8402123505.script_noteworthy == "gulag_ai_camera_door") {
        arena._id_DDC1E4A34C27B016 = _id_DFA9FB8402123505;
        arena._id_DDC1E4A34C27B016 delete();
      }
    }

    arena._id_79F102B3ABCC6F8A = [];
    arena._id_74128AA339E351B0 = [];
    arena._id_4E0BA30B0C9F09D2 = [];
    arena._id_267F3A45751996C2 = [];
    arena._id_060792B044C2D2CB = [];
    arena._id_04D916BB4BDA1F18 = [];

    if(istrue(level._id_43307855F189EB31._id_732A414F682801CC))
      arena._id_62D1855D36CFF5D2 = [];

    _id_BB81957D1AE1CF3A = scripts\engine\utility::getStructArray(arena.target, "targetname");

    foreach(_id_BDF25D8A73FF7DAD in _id_BB81957D1AE1CF3A) {
      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "guard_stationary_smg" || isstartstr(_id_BDF25D8A73FF7DAD.script_noteworthy, "gulag_ai_enemy"))
        arena._id_79F102B3ABCC6F8A[arena._id_79F102B3ABCC6F8A.size] = _id_BDF25D8A73FF7DAD;

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "mhc_legendary_loot_structs " || _id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_ai_legendary_loot_structs")
        arena._id_74128AA339E351B0[arena._id_74128AA339E351B0.size] = _id_BDF25D8A73FF7DAD;

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "mhc_loot_structs" || _id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_ai_loot_structs")
        arena._id_4E0BA30B0C9F09D2[arena._id_4E0BA30B0C9F09D2.size] = _id_BDF25D8A73FF7DAD;

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_ai_cabin_door")
        arena._id_060792B044C2D2CB[arena._id_060792B044C2D2CB.size] = _id_BDF25D8A73FF7DAD;

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_ai_camera")
        arena._id_267F3A45751996C2[arena._id_267F3A45751996C2.size] = _id_BDF25D8A73FF7DAD;

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_ai_cable")
        arena._id_BD901692981B143A = spawnscriptable("second_chance_cable", _id_BDF25D8A73FF7DAD.origin + (0, 0, level._id_37E52C7FB7267EFC._id_3564A4453EAFCACB), (0, 180, 0));

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_ai_cameras")
        arena.camera = spawnscriptable("second_chance_camera", _id_BDF25D8A73FF7DAD.origin);

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_ai_cargo") {
        if(level._id_37E52C7FB7267EFC._id_DDCC046E7B061885 < 0)
          arena._id_D6635C91EEFF8D6B = spawnscriptable("second_chance_cargo", _id_BDF25D8A73FF7DAD.origin + (0, 0, level._id_37E52C7FB7267EFC._id_3564A4453EAFCACB));
        else
          arena._id_D6635C91EEFF8D6B = _id_BDF25D8A73FF7DAD thread _id_6341D4F1620C75FD();
      }

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_ai_usb" && istrue(level._id_37E52C7FB7267EFC._id_E74CDBC9111D53C7))
        arena._id_1DFB62F15B7D51CF = spawnscriptable("second_chance_drive", _id_BDF25D8A73FF7DAD.origin);

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_ai_ot_flag")
        arena._id_1DF1ACEE38DCCA72 = _id_BDF25D8A73FF7DAD.origin;

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_ai_vent")
        arena._id_96320925B7BDFBDA = spawnscriptable("second_chance_vent", _id_BDF25D8A73FF7DAD.origin + (0, 0, -10));

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_ai_vent_bag")
        arena._id_B5ECC103C0E9710D = spawnscriptable("second_chance_bag", _id_BDF25D8A73FF7DAD.origin + (0, 0, level._id_37E52C7FB7267EFC._id_3564A4453EAFCACB));

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_ai_escape_doors") {
        if(istrue(level._id_37E52C7FB7267EFC._id_609A4F76DCE95688)) {
          _id_68A6E69DDB34008A = spawnscriptable("second_chance_door_win", _id_BDF25D8A73FF7DAD.origin, _id_BDF25D8A73FF7DAD.angles);
          arena._id_04D916BB4BDA1F18[arena._id_04D916BB4BDA1F18.size] = _id_68A6E69DDB34008A;
        }
      }
    }

    _id_CB74A3E70DDFE7AC(arena);

    if(istrue(level._id_37E52C7FB7267EFC._id_37AFB6F23303B55A))
      arena.objid = _id_3E4C7D5B30F40ED9(arena);

    level thread _id_591AA4C281221460(arena);
  }
}

_id_92CFA932B04A6719() {
  return getdvarfloat("dvar_8BE34599DFA102B8", 50.0);
}

_id_D1B3EED24BB52B44(_id_607899D4420FE1A5, arena) {
  if(_id_607899D4420FE1A5.size < 2) {
    if(_id_D58396C1483BFBDB()) {
      foreach(_id_AC0E424AC96A7113 in _id_607899D4420FE1A5) {
        if(!isDefined(_id_AC0E424AC96A7113._id_D95581FDFC29EC7A))
          return 1;
        else
          return 0;
      }
    } else
      return 0;
  }
}

_id_EBAFDB7112DB8628(offset) {
  return level.br_level.br_circledelaytimes.size - 1 - getdvarint("dvar_1141FEA0C6EF428F", 4) - offset;
}

_id_441F914BA636643B() {
  return getdvarint("dvar_0FB05C5F6825931D", 3);
}

_id_94AA98226F7A425C() {
  if(_id_6A7FE34AFAA1A01D())
    return 0;
}

_id_EB1596A5DAEA0EF5() {
  return 4.5;
}

_id_D556BD222194D447() {
  return 2.0;
}

_id_F6681BDE87AF34C8(arena) {
  if(istrue(level._id_37E52C7FB7267EFC._id_5B74E1E54F3F3B74)) {
    if(level._id_37E52C7FB7267EFC._id_54C7916BCEA2B113 == 1)
      arena _id_7E3B92CD362571D0();

    arena thread _id_7CFCE31D9C561B2D(arena.arenaplayers);
  }

  level thread _id_591AA4C281221460(arena);
}

_id_8116AF5AFA37B9BF(arena) {
  level endon("game_ended");

  if(!istrue(level._id_37E52C7FB7267EFC._id_609A4F76DCE95688))
    level thread _id_07525A0ED21932D7(arena);

  if(isDefined(arena._id_42097EB056866B9C))
    level thread _id_39C797F7E7C6CA87(arena._id_42097EB056866B9C);

  _id_6E5FDAFE4800CD7D = "gulagai" + arena.gulagindex;
  _id_1CE1B071385A88F0 = "gulagplayers" + arena.gulagindex;

  if(!threatbiasgroupexists(_id_1CE1B071385A88F0))
    createthreatbiasgroup(_id_1CE1B071385A88F0);

  if(!threatbiasgroupexists(_id_6E5FDAFE4800CD7D)) {
    createthreatbiasgroup(_id_6E5FDAFE4800CD7D);
    setthreatbiasagainstall(_id_6E5FDAFE4800CD7D, -100000);
    setthreatbias(_id_6E5FDAFE4800CD7D, _id_1CE1B071385A88F0, 2000);
  }

  foreach(ai in arena._id_707537A8904AA962) {
    if(isagent(ai))
      ai setthreatbiasgroup(_id_6E5FDAFE4800CD7D);
  }

  arena._id_4EB3CE9801991000 = undefined;

  foreach(player in arena.arenaplayers) {
    player._id_B807B84E723C5CEA = undefined;
    player._id_D95581FDFC29EC7A = undefined;
    player._id_A51592FB4017D57B = undefined;
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

    if(!istrue(level._id_37E52C7FB7267EFC._id_5B74E1E54F3F3B74))
      player thread scripts\mp\hud_message::showsplash("br_ai_gulag_start");

    if(istrue(level._id_37E52C7FB7267EFC._id_37AFB6F23303B55A) && isDefined(arena.objid)) {
      objective_addclienttomask(arena.objid, player);
      objective_showtoplayersinmask(arena.objid);
    }

    player _id_3583FF375AB3A91E::_id_63776B389E7C92C1();
    player _id_3583FF375AB3A91E::_id_1167994A7CE49346();
    player _id_10AA5AC1861FFB67(0);
    player setthreatbiasgroup(_id_1CE1B071385A88F0);
    player thread _id_5A82DA3875197BB7();
  }

  if(isDefined(arena._id_6D49EA26B65FDDAF)) {
    arena._id_6D49EA26B65FDDAF freescriptable();
    arena._id_6D49EA26B65FDDAF = undefined;
  }

  if(isDefined(arena._id_62D1855D36CFF5D2) && arena._id_62D1855D36CFF5D2.size > 0) {
    foreach(loot in arena._id_62D1855D36CFF5D2) {
      if(!isDefined(loot)) {
        continue;
      }
      loot setscriptablepartstate(loot.type, "visible");
    }

    arena._id_62D1855D36CFF5D2 = [];
  }

  if(istrue(arena._id_C83619011083E3C2)) {
    _id_0F431C7F719A5A19(arena);
    arena._id_C83619011083E3C2 = undefined;
  }

  arena._id_F69974791BB59E4B = undefined;

  if(istrue(level._id_37E52C7FB7267EFC._id_E74CDBC9111D53C7))
    _id_51A5C2CBDDB8569A(arena);

  if(isDefined(arena._id_707537A8904AA962))
    arena._id_28A470799D66ECD7 = arena._id_707537A8904AA962.size;

  if(isDefined(arena.arenaplayers))
    arena._id_B6B01621833467D1 = arena.arenaplayers.size;

  arena notify("ai_gulag_matchStarted");
}

_id_5A82DA3875197BB7() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player notify("gulag_trackPlayerBullets");
  player endon("gulag_trackPlayerBullets");
  player endon("can_show_splashes");

  for(;;) {
    player waittill("weapon_fired", objweapon);

    if(!isDefined(player._id_322535086C0890FA))
      player._id_322535086C0890FA = 0;

    player._id_322535086C0890FA = player._id_322535086C0890FA + 1;
  }
}

_id_669D65FCD2AC3D84() {
  level endon("game_ended");
  level waittill("prematch_done");
  wait 10;

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

_id_51A5C2CBDDB8569A(arena) {
  if(isDefined(arena._id_937FD276DB7D6DCF))
    arena._id_937FD276DB7D6DCF delete();

  _id_CDB25F748B945CFA(arena._id_1DFB62F15B7D51CF.origin, arena);
}

_id_6341D4F1620C75FD() {
  _id_BDF25D8A73FF7DAD = self;
  level endon("game_ended");
  time = 0;

  if(isDefined(level.br_level) && isDefined(level.br_level.br_circlecenters)) {
    _id_4EBF4FDB24B6DF5C = _id_764CF6B0BCA0FE0A();

    for(circleindex = 0; circleindex < _id_4EBF4FDB24B6DF5C; circleindex++) {
      _id_3702CBA57F844507 = level.br_level.br_circledelaytimes[circleindex];
      _id_3D8565E2775A243C = level.br_level.br_circleclosetimes[circleindex];
      time = time + _id_3702CBA57F844507 + _id_3D8565E2775A243C;
    }
  }

  waittime = int(time);
  wait(waittime);

  if(!isDefined(_id_BDF25D8A73FF7DAD)) {
    return;
  }
  _id_F97856743FBD4B44 = spawnscriptable("second_chance_cargo", _id_BDF25D8A73FF7DAD.origin + (0, 0, level._id_37E52C7FB7267EFC._id_3564A4453EAFCACB));
  return _id_F97856743FBD4B44;
}

_id_764CF6B0BCA0FE0A() {
  if(!isDefined(level.br_level) || !isDefined(level.br_level.br_circledelaytimes) || !isDefined(level._id_37E52C7FB7267EFC._id_DDCC046E7B061885))
    return 0;

  if(isDefined(level._id_37E52C7FB7267EFC._id_DDCC046E7B061885) && level._id_37E52C7FB7267EFC._id_DDCC046E7B061885 > 0)
    return level._id_37E52C7FB7267EFC._id_DDCC046E7B061885;

  _id_4EBF4FDB24B6DF5C = max(0, _id_67708F418B1FAC79::getgulagclosedcircleindex() - 1);
  return _id_4EBF4FDB24B6DF5C;
}

_id_F63BAAD2F7765F34(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
    return;
  }
  if(!isDefined(instance._id_FCDBD9BCF3239F14))
    instance._id_FCDBD9BCF3239F14 = 0;

  if(instance._id_FCDBD9BCF3239F14 > 16 || istrue(player._id_B807B84E723C5CEA)) {
    return;
  }
  player._id_B807B84E723C5CEA = 1;
  player playsoundonmovingent("mine_betty_click");
  instance.origin = instance.origin + (0, -35, 0);
  instance._id_FCDBD9BCF3239F14++;
  player._id_44722265234D31B0 = 1;

  if(instance._id_FCDBD9BCF3239F14 > 16) {
    player _id_10167F4C451AADFF(instance);
    instance thread _id_1AA190DA562F8DB3();
  }

  player thread _id_A71C019FF0F90D9D();
}

_id_A71C019FF0F90D9D() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  wait 1.5;

  if(isDefined(player) && isDefined(player._id_B807B84E723C5CEA))
    player._id_B807B84E723C5CEA = 0;
}

_id_10167F4C451AADFF(instance) {
  player = self;
  arena = _id_DE20B194B1A37513(player);

  if(!isDefined(arena) || !isDefined(arena.jailedplayers) || arena.jailedplayers.size == 0) {
    return;
  }
  foreach(_id_AC0E424AC96A7113 in arena.jailedplayers)
  _id_AC0E424AC96A7113 thread scripts\mp\hud_message::showsplash("br_ai_gulag_cargo_success");

  instance thread _id_A4B9CC7EDE16275C(arena);
}

_id_1AA190DA562F8DB3() {
  instance = self;
  level endon("game_ended");
  wait 10;
  instance.origin = instance.origin + (0, 560, 0);
  instance._id_FCDBD9BCF3239F14 = 0;
}

_id_6C9AE1F39F71F7E1(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
    return;
  }
  if(istrue(player._id_04BB14F07087A5DA)) {
    return;
  }
  player thread _id_F5A4FD44B6A9E2AC();
}

_id_F5A4FD44B6A9E2AC() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  arena = _id_DE20B194B1A37513(player);

  if(!isDefined(arena)) {
    return;
  }
  player._id_04BB14F07087A5DA = 1;
  player._id_DBE1D28321E708DD = 1;
  player playsoundonmovingent("mine_betty_click");
  camera = spawn("script_model", arena._id_267F3A45751996C2[0].origin);
  camera setModel("tag_origin");
  camera.angles = arena._id_267F3A45751996C2[0].angles;
  _id_1F2C6C0D410AAB78 = spawn("script_model", arena._id_267F3A45751996C2[1].origin);
  _id_1F2C6C0D410AAB78 setModel("tag_origin");
  _id_1F2C6C0D410AAB78.angles = arena._id_267F3A45751996C2[1].angles;
  _id_16C2C02F4BB475FA = spawn("script_model", arena._id_267F3A45751996C2[2].origin);
  _id_16C2C02F4BB475FA setModel("tag_origin");
  _id_16C2C02F4BB475FA.angles = arena._id_267F3A45751996C2[2].angles;

  if(istrue(level._id_37E52C7FB7267EFC._id_2713A9CF5318D984)) {
    foreach(_id_C5F4970069850479 in _func_B4B9401715CF98EA("gulag"))
    _id_C5F4970069850479 hudoutlineenableforclient(player, "outlinefill_nodepth_red");
  }

  wait 1;

  if(istrue(player _id_5322B4A5EC08D2C9(camera, _id_1F2C6C0D410AAB78, _id_16C2C02F4BB475FA))) {
    return;
  }
  player setclientomnvar("ui_rcd_controls", 2);
  player cameralinkTo(camera, "tag_origin", 1, 1);
  wait 3;

  if(istrue(player _id_5322B4A5EC08D2C9(camera, _id_1F2C6C0D410AAB78, _id_16C2C02F4BB475FA))) {
    return;
  }
  player cameraunlink();
  player cameralinkTo(_id_1F2C6C0D410AAB78, "tag_origin", 1, 1);
  wait 3;

  if(istrue(player _id_5322B4A5EC08D2C9(camera, _id_1F2C6C0D410AAB78, _id_16C2C02F4BB475FA))) {
    return;
  }
  player cameraunlink();
  player cameralinkTo(_id_16C2C02F4BB475FA, "tag_origin", 1, 1);
  wait 3;

  if(istrue(player _id_5322B4A5EC08D2C9(camera, _id_1F2C6C0D410AAB78, _id_16C2C02F4BB475FA))) {
    return;
  }
  if(istrue(level._id_37E52C7FB7267EFC._id_2713A9CF5318D984)) {
    foreach(_id_C5F4970069850479 in _func_B4B9401715CF98EA("gulag"))
    _id_C5F4970069850479 hudoutlinedisableforclient(player);
  }

  player setclientomnvar("ui_rcd_controls", 0);
  player cameraunlink();
  camera delete();
  _id_1F2C6C0D410AAB78 delete();
  player._id_04BB14F07087A5DA = undefined;
}

_id_5322B4A5EC08D2C9(camera, _id_1F2C6C0D410AAB78, _id_16C2C02F4BB475FA) {
  player = self;

  if(!isDefined(player) || !istrue(player._id_04BB14F07087A5DA)) {
    if(isDefined(camera))
      camera delete();

    if(isDefined(_id_1F2C6C0D410AAB78))
      _id_1F2C6C0D410AAB78 delete();

    if(isDefined(_id_16C2C02F4BB475FA))
      _id_16C2C02F4BB475FA delete();

    return 1;
  }

  return 0;
}

_id_875F67700E4D2769(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
    return;
  }
  if(istrue(player._id_E9343FD6E229B035)) {
    return;
  }
  player._id_525C703CFDDAF913 = 1;
  player thread _id_F229C4CE80428FFE("briefcase_bomb_mp", 3);
}

_id_0B0F86BE8E080101(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
    return;
  }
  if(!isDefined(player._id_A51592FB4017D57B)) {
    player scripts\mp\hud_message::showerrormessage("MP/BR_AI_GULAG_VENT_UNABLE");
    return;
  }

  player._id_A51592FB4017D57B = undefined;
  player._id_97AC1EA78FAEA6E3 = 1;
  player._id_E60B359EB0C2F51D = 1;
  player playsoundonmovingent("mine_betty_click");
  player thread scripts\mp\hud_message::showsplash("br_ai_gulag_vent_success");
}

_id_3BC6F653F16663AA(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);

  if(!isDefined(arena)) {
    return;
  }
  if(!isDefined(arena._id_F69974791BB59E4B))
    arena._id_F69974791BB59E4B = [];

  if(scripts\engine\utility::array_contains(arena._id_F69974791BB59E4B, player)) {
    return;
  }
  arena._id_F69974791BB59E4B[arena._id_F69974791BB59E4B.size] = player;
  arena _id_2AC2880E868DFEC6();
  player playsoundonmovingent("mine_betty_click");
}

_id_E40FAA26DA957604(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
    return;
  }
  if(isDefined(player._id_A51592FB4017D57B) && !istrue(instance._id_05EECE9BDFC3E3E6)) {
    return;
  }
  player playsoundonmovingent("mine_betty_click");

  if(istrue(instance._id_05EECE9BDFC3E3E6)) {
    player.pers["gamemodeLoadout"] = _id_F4FAB9C1A6E08991();
    player.class = "gamemode";
    player.prevweaponobj = undefined;
    struct = player scripts\mp\class::loadout_getclassstruct();
    struct = player scripts\mp\class::loadout_updateclass(struct, "gamemode");
    player scripts\mp\class::preloadandqueueclassstruct(struct, 1, 1);
    player scripts\mp\class::giveloadout(player.team, "gamemode", 0, 0);
    player givestartammo(struct.loadoutprimaryobject);
    player _id_724736FCF0FB6604::br_give_weapon_clip(struct.loadoutprimaryobject, 2);

    if(isDefined(struct.loadoutsecondaryobject)) {
      player givestartammo(struct.loadoutsecondaryobject);
      player _id_724736FCF0FB6604::br_give_weapon_clip(struct.loadoutsecondaryobject, 2);
      return;
    }
  } else {
    player._id_A51592FB4017D57B = 1;
    player._id_2AC81A7104E85B68 = 1;
  }
}

_id_B7E4CBD2A1618BDC(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);

  if(!isDefined(arena)) {
    return;
  }
  if(scripts\engine\utility::array_contains(arena.arenaplayers, player)) {
    player thread _id_3583FF375AB3A91E::_id_A65DF5D97EE38203(arena);
    player _id_3583FF375AB3A91E::_id_0DCEAD2B56FDBF3E("win");
    player _id_3583FF375AB3A91E::_id_3F18739AE34D9958();
    player _id_10AA5AC1861FFB67(-1);

    if(istrue(level._id_37E52C7FB7267EFC._id_37AFB6F23303B55A) && isDefined(arena.objid))
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(arena.objid, player);

    player thread _id_67708F418B1FAC79::gulagvictory(arena, player, 1, 0, "gulag_ai");

    if(_id_3583FF375AB3A91E::_id_7AD9FCB1AC4F3DB8())
      player thread _id_45C3DC4231157A10();
  }
}

_id_0F431C7F719A5A19(arena) {
  if(!isDefined(arena._id_4E0BA30B0C9F09D2) || arena._id_4E0BA30B0C9F09D2.size == 0) {
    return;
  }
  arena._id_6D49EA26B65FDDAF = spawnscriptable("second_chance_bag", arena._id_4E0BA30B0C9F09D2[0].origin + (0, 0, 10));
  arena._id_6D49EA26B65FDDAF._id_05EECE9BDFC3E3E6 = 1;
}

_id_F229C4CE80428FFE(weaponref, _id_193BA10DFA6671B4) {
  player = self;
  player._id_E9343FD6E229B035 = 1;
  player _id_45CBF298ABFAF76A(weaponref, _id_193BA10DFA6671B4);
  player _id_BFB05639E6A851C0(weaponref);
}

_id_45CBF298ABFAF76A(weaponref, _id_193BA10DFA6671B4) {
  player = self;
  player endon("beginNewFight");
  player endon("can_show_splashes");
  item = makeweapon(weaponref);
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(item, undefined, undefined, 0);
  player setweaponammostock(item, 0);
  player setweaponammoclip(item, 0);
  player thread scripts\mp\gameobjects::switchtouseweapon(item, 1);
  wait(_id_193BA10DFA6671B4);
  player thread scripts\mp\hud_message::showsplash("br_ai_gulag_cable_tempered");
}

_id_BFB05639E6A851C0(weaponref) {
  player = self;
  player scripts\cp_mp\utility\inventory_utility::getridofweapon(weaponref);
  player._id_E9343FD6E229B035 = undefined;
}

_id_ED3B3A2040C051A6(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);

  if(!isDefined(arena)) {
    return;
  }
  if(istrue(arena.overtime)) {
    return;
  }
  foreach(player in arena.arenaplayers)
  player thread scripts\mp\hud_message::showsplash("br_ai_gulag_reached_end");

  if(!istrue(level._id_37E52C7FB7267EFC._id_609A4F76DCE95688))
    _id_CDB25F748B945CFA(arena._id_B59E8B6B1C730B69.origin, arena);

  arena._id_42097EB056866B9C._id_431D7A8AB1FDDFDC = 1;
  arena._id_42097EB056866B9C.origin = arena._id_42097EB056866B9C.origin - (0, 0, 200);

  if(istrue(level._id_37E52C7FB7267EFC._id_E74CDBC9111D53C7)) {
    arena.overtime = 1;
    arena.dom.arenaflag _id_67708F418B1FAC79::arenaflag_setenabled(1);
    arena.dom.arenaflag _id_67708F418B1FAC79::arenaflag_setvisible(arena, 1);
    arena.dom.arenaflag.flagmodel playsoundonmovingent("flag_spawned");
    progress = clamp(arena.time / _id_67708F418B1FAC79::getovertimelength(), 0.0, 1.0);
    _id_67708F418B1FAC79::setovertimeomnvarprogress(arena, progress);
  }
}

_id_07525A0ED21932D7(arena) {
  level endon("game_ended");

  while(arena.arenaplayers.size > 0) {
    arena._id_B59E8B6B1C730B69 waittill("trigger", player);

    if(scripts\engine\utility::array_contains(arena.arenaplayers, player)) {
      player thread _id_3583FF375AB3A91E::_id_A65DF5D97EE38203(arena);
      player _id_3583FF375AB3A91E::_id_0DCEAD2B56FDBF3E("win");
      player _id_3583FF375AB3A91E::_id_3F18739AE34D9958();
      player _id_10AA5AC1861FFB67(-1);

      if(istrue(level._id_37E52C7FB7267EFC._id_37AFB6F23303B55A) && isDefined(arena.objid))
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(arena.objid, player);

      player thread _id_67708F418B1FAC79::gulagvictory(arena, player, 1, 0, "gulag_ai");

      if(_id_3583FF375AB3A91E::_id_7AD9FCB1AC4F3DB8())
        player thread _id_45C3DC4231157A10();
    }
  }
}

_id_45C3DC4231157A10() {
  player = self;
  player endon("disconnect");
  level endon("game_ended");
  wait 9;
  player kill();
}

_id_39C797F7E7C6CA87(door) {
  level endon("game_ended");

  if(!isDefined(door.originalloc))
    door.originalloc = door.origin;

  if(isDefined(door._id_431D7A8AB1FDDFDC)) {
    door.origin = door.originalloc;
    door._id_431D7A8AB1FDDFDC = undefined;
  }
}

_id_7F1A7D1E230F666C(item, location) {
  scriptable = spawnscriptable(item, location, (0, 0, 0));
  return scriptable;
}

_id_3E4C7D5B30F40ED9(arena) {
  if(istrue(level._id_37E52C7FB7267EFC._id_609A4F76DCE95688)) {
    if(isDefined(arena._id_04D916BB4BDA1F18[0]))
      location = arena._id_04D916BB4BDA1F18[0].origin;
    else if(isDefined(arena._id_B59E8B6B1C730B69))
      location = arena._id_B59E8B6B1C730B69.origin;
    else
      location = (0, 0, 0);
  } else
    location = arena._id_B59E8B6B1C730B69.origin;

  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(objid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", location, "ui_mp_br_mapmenu_icon_x1_05_objective");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);
  } else {}

  return objid;
}

_id_CDB25F748B945CFA(location, arena) {
  if(!isDefined(arena.objid)) {
    return;
  }
  objective_position(arena.objid, location);
}

_id_B42C7B95B41F363C() {
  player = self;
  wait(level._id_37E52C7FB7267EFC._id_4B133D9C5B92891D);

  if(isDefined(player) && player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
    _id_5C6EF2A007983454 = _id_DE20B194B1A37513(player);

    if(isDefined(_id_5C6EF2A007983454))
      player._id_D95581FDFC29EC7A = undefined;
  }
}

_id_82434E34C1223971() {
  loadout = [];
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = "iw9_pi_decho";
  loadout["loadoutPrimaryAttachment"] = "none";
  loadout["loadoutPrimaryAttachment2"] = "none";
  loadout["loadoutPrimaryCamo"] = "none";
  loadout["loadoutPrimaryReticle"] = "none";
  loadout["loadoutSecondary"] = "none";
  loadout["loadoutSecondaryAttachment"] = "none";
  loadout["loadoutSecondaryAttachment2"] = "none";
  loadout["loadoutSecondaryCamo"] = "none";
  loadout["loadoutSecondaryReticle"] = "none";
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = "equip_frag";
  loadout["loadoutEquipmentSecondary"] = "equip_snapshot_grenade";
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = ["specialty_null"];
  loadout["loadoutGesture"] = "playerData";
  loadout["loadoutExecution"] = "none";
  return loadout;
}

_id_F4FAB9C1A6E08991() {
  loadout = [];
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = "iw9_sm_aviktor_mp";
  loadout["loadoutPrimaryAttachment"] = "none";
  loadout["loadoutPrimaryAttachment2"] = "none";
  loadout["loadoutPrimaryCamo"] = "none";
  loadout["loadoutPrimaryReticle"] = "none";
  loadout["loadoutSecondary"] = "iw9_sh_mbravo";
  loadout["loadoutSecondaryAttachment"] = "none";
  loadout["loadoutSecondaryAttachment2"] = "none";
  loadout["loadoutSecondaryCamo"] = "none";
  loadout["loadoutSecondaryReticle"] = "none";
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = "equip_frag";
  loadout["loadoutEquipmentSecondary"] = "equip_concussion";
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = ["specialty_munitions_2"];
  loadout["loadoutGesture"] = "playerData";
  loadout["loadoutExecution"] = "none";
  return loadout;
}

_id_9DBB71AAAE4E335E(arena) {
  _id_3583FF375AB3A91E::_id_0DCEAD2B56FDBF3E("lost");

  if(isDefined(arena.objid))
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(arena.objid, self);
}

_id_2B0FD45EF612B4A5(arena, _id_B6ACF0C07C4311E6) {
  winner = self;
  winner._id_22F8F8D138D3C02F = 2;
  winner _id_F071DB381E990D80();
}

_id_FD55F9D5EF55B95E() {
  player = self;
  player._id_7AF171F0AE71A689 = gettime();
  player._id_D95581FDFC29EC7A = gettime();
  player thread _id_B42C7B95B41F363C();
}

_id_9D53E328C2D1AEC4() {
  player = self;
  player._id_AD6498E5D4B1AE34 = gettime() - player._id_7AF171F0AE71A689;
  player._id_7AF171F0AE71A689 = undefined;
  weaponobj = player getcurrentprimaryweapon();
  player _id_724736FCF0FB6604::br_give_weapon_clip(weaponobj, 2);
}

_id_F561AF47DB779C79(arena) {
  player = self;
  player endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(arena._id_4EB3CE9801991000)) {
    return;
  }
  points = arena._id_4EB3CE9801991000;
  wait 5;

  while(!player isonground())
    wait 0.5;

  if(points >= 2)
    player _id_6AFF3948CF4CCA03::playerplunderpickup(5);

  if(points >= 6)
    _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, "brloot_armor_plate", 1, 2);

  if(points >= 8)
    player _id_6AFF3948CF4CCA03::playerplunderpickup(10);

  if(points >= 10)
    _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, "brloot_super_munitionsbox", 1);
}

_id_A4B9CC7EDE16275C(arena) {
  _id_D6635C91EEFF8D6B = self;

  if(!isDefined(arena.jailedplayers) || arena.jailedplayers.size < 1) {
    return;
  }
  foreach(_id_AC0E424AC96A7113 in arena.jailedplayers) {
    if(isDefined(_id_AC0E424AC96A7113._id_B807B84E723C5CEA)) {
      _id_AC0E424AC96A7113 thread _id_67708F418B1FAC79::gulagvictory(_id_AC0E424AC96A7113.arena, _id_AC0E424AC96A7113, 1, 1, "jailbreakEvent");

      if(_id_3583FF375AB3A91E::_id_7AD9FCB1AC4F3DB8())
        _id_AC0E424AC96A7113 thread _id_45C3DC4231157A10();
    }
  }

  playsoundatpos(_id_D6635C91EEFF8D6B.origin, "evt_br_gulag_round_start_buzzer");
  arena.jailedplayers = scripts\engine\utility::array_removeundefined(arena.jailedplayers);
}

_id_A7A1D8D937762614(agent, _id_6181DE250AFA5BB6) {
  if(!isPlayer(_id_6181DE250AFA5BB6)) {
    return;
  }
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(_id_6181DE250AFA5BB6);

  if(!isDefined(arena)) {
    return;
  }
  if(!isDefined(arena._id_4EB3CE9801991000))
    arena._id_4EB3CE9801991000 = 0;

  if(!isDefined(_id_6181DE250AFA5BB6._id_32484CD3B17F16C8))
    _id_6181DE250AFA5BB6._id_32484CD3B17F16C8 = 0;

  arena._id_4EB3CE9801991000 = arena._id_4EB3CE9801991000 + 1;
  _id_6181DE250AFA5BB6._id_32484CD3B17F16C8 = _id_6181DE250AFA5BB6._id_32484CD3B17F16C8 + 1;

  if(arena._id_4EB3CE9801991000 == 2 || arena._id_4EB3CE9801991000 == 6 || arena._id_4EB3CE9801991000 == 8 || arena._id_4EB3CE9801991000 == 10) {
    foreach(_id_AC0E424AC96A7113 in arena.arenaplayers)
    _id_AC0E424AC96A7113 playsoundtoplayer("mp_killconfirm_tags_pickup", _id_AC0E424AC96A7113);
  }

  foreach(_id_AC0E424AC96A7113 in arena.arenaplayers)
  _id_AC0E424AC96A7113 _id_10AA5AC1861FFB67(arena._id_4EB3CE9801991000);
}

_id_10AA5AC1861FFB67(value) {
  player = self;
  player setclientomnvar("ui_br_ai_gulag_score", value);
}

_id_F071DB381E990D80() {
  player = self;
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);

  if(!isDefined(arena)) {
    return;
  }
  _id_283BF79EFCF70762 = 0;
  _id_4ABDC6DFE813CD0E = 0;

  if(isDefined(arena.arenaplayers) && isDefined(arena.arenaplayers[0]) && isDefined(arena.arenaplayers[0]._id_22F8F8D138D3C02F))
    _id_283BF79EFCF70762 = arena.arenaplayers[0]._id_22F8F8D138D3C02F;

  if(isDefined(arena.arenaplayers) && isDefined(arena.arenaplayers[1]) && isDefined(arena.arenaplayers[1]._id_22F8F8D138D3C02F))
    _id_4ABDC6DFE813CD0E = arena.arenaplayers[1]._id_22F8F8D138D3C02F;

  _id_3F65A52935223A7A = (_id_4ABDC6DFE813CD0E << 4) + _id_283BF79EFCF70762;
  _id_087B2BE9FEF844DE = scripts\engine\utility::array_combine(arena.jailedplayers, arena.arenaplayers);

  foreach(_id_AC0E424AC96A7113 in _id_087B2BE9FEF844DE)
  _id_AC0E424AC96A7113 setclientomnvar("ui_br_ai_gulag_player_state", _id_3F65A52935223A7A);
}

_id_DE20B194B1A37513(player) {
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

_id_7EFFA8A355DDC886() {
  if(isDefined(level._id_37E52C7FB7267EFC) && istrue(level._id_37E52C7FB7267EFC._id_2E88FFF6C419EE6A))
    return 1;

  return 0;
}

_id_79FDF5CD036FF575() {
  if(isDefined(level._id_37E52C7FB7267EFC) && istrue(level._id_37E52C7FB7267EFC._id_2E88FFF6C419EE6A) && istrue(level._id_37E52C7FB7267EFC._id_F04A0FB05108F52E) || getdvarint("dvar_8FFA9721C8DD3DCC", 0) != 0)
    return 1;

  return 0;
}

_id_D58396C1483BFBDB() {
  if(isDefined(level._id_37E52C7FB7267EFC) && istrue(level._id_37E52C7FB7267EFC._id_2E88FFF6C419EE6A) && istrue(level._id_37E52C7FB7267EFC._id_7D4922396DAA0192))
    return 1;

  return 0;
}

_id_BD71F506AF2CAC70(arena) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");

  if(isDefined(arena.objid))
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(arena.objid, player);

  if(player.health == 0) {
    wait 7;

    if(!isDefined(player)) {
      return;
    }
    player.gulag = 0;
    _id_F0EA4030349A33D5 = player;
    _id_6D5ED003AF1F9612 = level.teamdata[player.team]["players"];

    foreach(_id_AC0E424AC96A7113 in _id_6D5ED003AF1F9612) {
      if(_id_AC0E424AC96A7113 == player) {
        continue;
      }
      _id_F0EA4030349A33D5 = _id_AC0E424AC96A7113;
    }

    if(isDefined(_id_F0EA4030349A33D5)) {
      _id_F0EA4030349A33D5 = _id_6D5ED003AF1F9612[0];
      _id_F0EA4030349A33D5 _id_7E52B56769FA7774::addrespawntoken(1);
      player _id_67708F418B1FAC79::playergulagautowin("aiGulag", _id_F0EA4030349A33D5);
      wait 7;

      if(!isDefined(player)) {
        return;
      }
      player kill();
      return;
    }
  } else {
    player thread _id_67708F418B1FAC79::gulagvictory(arena, player, 1, 0, "shutdown");
    wait 7;

    if(!isDefined(player)) {
      return;
    }
    player kill();
  }
}

_id_7B08C98431ABDA40(attacker, victim) {
  if(!_id_7EFFA8A355DDC886() || !isDefined(victim) || !isDefined(attacker))
    return 0;

  if(isPlayer(victim) && isPlayer(attacker)) {
    if(istrue(victim.gulag) && istrue(attacker.gulag))
      return 1;
  }

  return 0;
}

_id_6A7FE34AFAA1A01D() {
  if(isDefined(level._id_37E52C7FB7267EFC) && istrue(level._id_37E52C7FB7267EFC._id_5CD8016B769D02AA))
    return 1;

  return 0;
}

_id_7CFCE31D9C561B2D(arenaplayers) {
  arena = self;

  if(level._id_37E52C7FB7267EFC._id_54C7916BCEA2B113 == 0) {
    arena _id_AE6DCE59CCB4B681();
    arena thread _id_5427C6229B93668E(arena.fightspawns);
  } else if(level._id_37E52C7FB7267EFC._id_54C7916BCEA2B113 == 1) {
    foreach(_id_AC0E424AC96A7113 in arenaplayers)
    _id_AC0E424AC96A7113 thread scripts\mp\hud_message::showsplash("br_ai_gulag_afk_door");

    arena _id_AE6DCE59CCB4B681();
    arena _id_16D6792E689D7559();
    arena _id_3A22DD56AA026E21(arenaplayers);
  }
}

_id_AE6DCE59CCB4B681() {
  arena = self;
  wait(level._id_37E52C7FB7267EFC._id_F98AEC28092AE4F2);
}

_id_5427C6229B93668E(locations, _id_3929F105E3444DF2, _id_BA599E887E5CDAE4, _id_6611564090223DAB, _id_74AB6E197FEAE88B) {
  arena = self;
  arena endon("matchEnded");
  arena endon("fight_over");
  level endon("game_ended");

  if(!isDefined(locations)) {
    return;
  }
  if(!isDefined(_id_3929F105E3444DF2))
    _id_3929F105E3444DF2 = 11;

  if(!isDefined(_id_BA599E887E5CDAE4))
    _id_BA599E887E5CDAE4 = 0;

  if(!isDefined(_id_6611564090223DAB))
    _id_6611564090223DAB = 15;

  if(!isDefined(_id_74AB6E197FEAE88B))
    _id_74AB6E197FEAE88B = 1.5;

  foreach(player in arena.arenaplayers)
  player thread _id_F3C05E86869E397C(_id_6611564090223DAB, _id_74AB6E197FEAE88B);

  foreach(loc in locations) {
    position = loc.origin;
    playFX(scripts\engine\utility::getfx("glsmoke"), position, anglestoup((0, 90, 0)));
    arena thread scripts\mp\equipment\gas_grenade::gas_createtrigger(position, arena._id_707537A8904AA962[0], arena._id_707537A8904AA962[0].team, _id_3929F105E3444DF2, 0.7);
    wait(_id_BA599E887E5CDAE4);
  }
}

_id_F3C05E86869E397C(_id_6611564090223DAB, _id_74AB6E197FEAE88B) {
  player = self;
  player endon("gulagRespawn");
  player endon("gulagLost");
  player endon("death_or_disconnect");
  level endon("game_ended");

  while(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
    player waittill("gas_begin_coughing");
    player thread _id_870D349C1ED60C21(_id_6611564090223DAB, _id_74AB6E197FEAE88B);
  }
}

_id_870D349C1ED60C21(_id_6611564090223DAB, _id_74AB6E197FEAE88B) {
  player = self;
  player endon("gas_modify_blur");
  player endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    if(player.health - _id_6611564090223DAB <= 0)
      player kill();
    else
      player.health = player.health - _id_6611564090223DAB;

    wait(_id_74AB6E197FEAE88B);
  }
}

_id_2AC2880E868DFEC6() {
  arena = self;

  if(arena._id_F69974791BB59E4B.size >= arena.arenaplayers.size)
    arena notify("gulag_both_doors_interacted");
}

_id_7E3B92CD362571D0() {
  arena = self;
  arena._id_06C9E6734548F435 = [];

  foreach(_id_E05CEFDE9287F4F2 in arena._id_060792B044C2D2CB) {
    door = spawnscriptable("second_chance_door", _id_E05CEFDE9287F4F2.origin);
    arena._id_06C9E6734548F435[arena._id_06C9E6734548F435.size] = door;
  }
}

_id_16D6792E689D7559() {
  arena = self;

  if(!isDefined(arena._id_06C9E6734548F435) || arena._id_06C9E6734548F435.size < 1) {
    return;
  }
  foreach(door in arena._id_06C9E6734548F435)
  door freescriptable();

  arena._id_06C9E6734548F435 = undefined;

  foreach(_id_AC0E424AC96A7113 in arena.arenaplayers)
  _id_AC0E424AC96A7113 thread scripts\mp\hud_message::showsplash("br_ai_gulag_start");
}

_id_3A22DD56AA026E21(arenaplayers) {
  arena = self;

  if(!isDefined(arena._id_F69974791BB59E4B) || arena._id_F69974791BB59E4B.size < 1) {
    foreach(_id_AC0E424AC96A7113 in arenaplayers)
    _id_AC0E424AC96A7113 _id_2F3CEE02D1664AC3();

    return;
  }

  foreach(_id_AC0E424AC96A7113 in arenaplayers) {
    if(!scripts\engine\utility::array_contains(arena._id_F69974791BB59E4B, _id_AC0E424AC96A7113))
      _id_AC0E424AC96A7113 _id_2F3CEE02D1664AC3();
  }
}

_id_2F3CEE02D1664AC3() {
  player = self;
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);
  player thread _id_67708F418B1FAC79::gulagplayerlost(arena);
}

_id_591AA4C281221460(arena) {
  if(!isDefined(arena._id_707537A8904AA962)) {
    arena._id_7B2D0FF4698FB2E9 = 1;

    if(isDefined(arena._id_79F102B3ABCC6F8A))
      thread _id_7872AD2759563BC9(arena);

    arena waittill("matchEnded");
    thread _id_EC081B1E504799DE(arena);
  }
}

_id_CB74A3E70DDFE7AC(arena) {
  category = "gulag";
  _id_48814951E916AF89::_id_BA4022744DCE59F6(category);
}

_id_7872AD2759563BC9(arena) {
  if(_id_3583FF375AB3A91E::_id_D8F18F1D691C0EF8(arena))
    thread _id_5CDA031797DCE489::_id_89235E4FE5354B16(arena);
  else {
    foreach(_id_55E69FB0CE97F15E in arena._id_79F102B3ABCC6F8A)
    thread _id_390D1A2DC50058C0(arena, _id_55E69FB0CE97F15E);
  }
}

_id_390D1A2DC50058C0(arena, _id_55E69FB0CE97F15E) {
  aitype = "enemy_mp_smg_tier1_aq";
  _id_2AC210AF318CF38B = _id_55E69FB0CE97F15E.origin;

  if(!getdvarint("dvar_B3D7A9483362813E", 0))
    _id_2AC210AF318CF38B = getclosestpointonnavmesh(_id_55E69FB0CE97F15E.origin);

  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_2AC210AF318CF38B, _id_55E69FB0CE97F15E.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1);

  if(isagent(agent)) {
    agent thread _id_C31F3A6EF58A2928(arena);

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

_id_90E71E5AC7C0EE5D(arena) {
  if(!istrue(arena._id_7B2D0FF4698FB2E9))
    _id_591AA4C281221460(arena);

  _id_C99A915A0DD0DF12 = 0;

  foreach(player in arena.arenaplayers) {
    if(player _id_3583FF375AB3A91E::_id_3FACAB0D974296C1()) {
      _id_C99A915A0DD0DF12 = 1;
      break;
    }
  }

  if(_id_C99A915A0DD0DF12) {
    foreach(agent in arena._id_707537A8904AA962) {
      if(isagent(agent)) {}
    }
  }
}

_id_C31F3A6EF58A2928(arena) {
  if(!isDefined(arena._id_707537A8904AA962))
    arena._id_707537A8904AA962 = [];

  arena._id_707537A8904AA962 = scripts\engine\utility::array_add(arena._id_707537A8904AA962, self);
}

_id_5A881C43E5FEBF38(arena) {
  if(isDefined(arena._id_707537A8904AA962)) {
    arena._id_707537A8904AA962 = scripts\engine\utility::array_remove(arena._id_707537A8904AA962, self);

    if(isagent(self)) {
      if(isalive(self))
        _id_48814951E916AF89::_id_28B90EB2B591003F();
      else {
        body = self getcorpseentity();

        if(isDefined(body))
          body delete();
      }
    }

    if(arena._id_707537A8904AA962.size <= 0)
      arena._id_707537A8904AA962 = undefined;
  }
}

_id_EC081B1E504799DE(arena) {
  if(isDefined(arena._id_707537A8904AA962)) {
    foreach(agent in arena._id_707537A8904AA962) {
      if(isagent(agent)) {
        agent _id_5A881C43E5FEBF38(arena);
        agent setthreatbiasgroup();
      }
    }

    arena._id_707537A8904AA962 = undefined;
    arena._id_7B2D0FF4698FB2E9 = undefined;
  }

  waitframe();
  _id_2E903A90A966D9C2 = 2950;
  _id_F9D6732A60363240 = getlootscriptablearrayinradius(undefined, undefined, arena.center, _id_2E903A90A966D9C2);

  foreach(_id_D8CD9C1941A88194 in _id_F9D6732A60363240) {
    if(_id_D8CD9C1941A88194 getscriptableisreserved() && _id_D8CD9C1941A88194 getscriptableisloot())
      _id_D8CD9C1941A88194 _id_7E52B56769FA7774::deletescriptableinstance();
  }
}