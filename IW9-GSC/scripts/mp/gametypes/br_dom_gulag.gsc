/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_dom_gulag.gsc
*************************************************/

_id_53088602EA68D303() {
  level._id_5B530D6E84AC2128 = spawnStruct();
  level._id_5B530D6E84AC2128._id_3E34096B136F9A10 = 1;
  level._id_5B530D6E84AC2128._id_991A2D40AE12A427 = getdvarint("dvar_CB50D86A5A28600F", 1);
  level._id_5B530D6E84AC2128._id_CB871A5B28F14E14 = getdvarint("dvar_90416440E434DBF2", 20);
  level._id_5B530D6E84AC2128._id_A93342FFB3C354E6 = getdvarint("dvar_2BD3933013DD58E3", 0);
  level._id_5B530D6E84AC2128._id_4D40D2FEC8E9C5B0 = getdvarint("dvar_4CCF8B7C96D2FFB8", 0);
  level._id_5B530D6E84AC2128._id_C96EEE8D172A57C6 = getdvarint("dvar_6DE1D9CA39CF2712", 6);
  level._id_5B530D6E84AC2128._id_9313E9BBEA781AED = getdvarint("dvar_D7E49331FB4E8054", 1);
  level._id_5B530D6E84AC2128._id_659E35594C7FC814 = getdvarint("dvar_645BD13059493F28", 1);
  level._id_5B530D6E84AC2128._id_599C54CFD95ADDAD = getdvarint("dvar_D6B5A1019326F578", 0);
  level._id_5B530D6E84AC2128._id_C47A2536CBDBC9D7 = getdvarint("dvar_BB2E63007CC6F524", 0);
  level._id_5B530D6E84AC2128._id_AB48B8F9EB30C8FC = getdvarint("dvar_097DA3C665FA2E83", 1);
  level._id_5B530D6E84AC2128._id_F455B3807D4EA69D = getdvarint("dvar_4657318B9060B437", 0);
  level._id_5B530D6E84AC2128._id_17EE664650BD17CB = getdvarint("dvar_79E30FA9726A9EA1", 1);
  level._id_5B530D6E84AC2128._id_B7B9865CA59961D9 = getDvar("dvar_966A30FDA4998D93", "40, 10, 20, 6, 10, 4, 1, 2");
  level._id_5B530D6E84AC2128._id_B5B3DB55C42637C3 = getdvarint("dvar_D9D6E11CCDBF1F1C", -1);
  level._id_5B530D6E84AC2128._id_F2ADAAFE5F7860E8 = getdvarint("dvar_D6134717439619F9", 0);
  level._id_5B530D6E84AC2128._id_1E63C57879330B37 = getdvarint("dvar_F155A7E8658F9B9C", 1);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetMatchDuration", ::_id_AB54F9EDC268063B);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagTrackPlayerBulletHitAI", ::_id_CD7C7D0FC6ADF4B1);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagTrackPlayerBulletHitPlayer", ::_id_CD7C7D0FC6ADF4B1);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetMaxPlayers", ::_id_F9D544F605DDE72A);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagIsMatchPending", ::_id_0A48B4BEDB9BD286);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetClosedCircleIndex", ::_id_DB27FF4A01BA7ACE);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagIsOneTeamLeft", ::_id_301ED1C7AC115606);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetVictoryWait", ::_id_370F0564E0B9D801);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetPostVictoryWait", ::_id_196C3EE37902FF93);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagHandleLossInfiniteEarly", ::_id_F9FAE1B8F601F0EA);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagCanPlayerDropKey", ::_id_DB60ABB28498007B);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGiveAIKillRewards", ::_id_3104D393DC6CC377);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagLoseSequence", ::_id_115AA986E2C13FEA);
  level _id_48814951E916AF89::_id_93ADD0B65DB9F722(::_id_6EC844085B807D62);
  level thread _id_202939344423679C();

  if(!isDefined(level._id_289DF80E1DED586F))
    thread _id_48814951E916AF89::init();

  if(_id_3583FF375AB3A91E::_id_7AD9FCB1AC4F3DB8())
    level thread _id_A504BD9AE48A23D8();

  if(level._id_5B530D6E84AC2128._id_AB48B8F9EB30C8FC)
    _id_25E2B333B4736A48::setupdom();

  level thread _id_5CDA031797DCE489::_id_25A296C2ED85E35F();
}

_id_202939344423679C() {
  level waittill("prematch_done");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("second_chance_drive", ::_id_34C2AB381E6C17CB);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_captureneutral", 2, "neutral", "MP/BR_DOM_GULAG_EXIT", "ui_mp_br_icon_gulag_escape_objective", 0);

  foreach(arena in level.gulag.arenas) {
    arena._id_D5BDB69EB6ECFB2F = [];
    arena.keys = [];
    arena._id_45E35B44EC23AB43 = [];
    arena.domflag = [];
    arena._id_AB7AA90965BBFFAE = [];
    arena._id_79F102B3ABCC6F8A = [];
    arena._id_D7BAAFC9B07F5094 = [];
    arena._id_1ED14283F14082AE = [];

    if(level._id_43307855F189EB31._id_732A414F682801CC)
      arena._id_62D1855D36CFF5D2 = [];

    _id_BB81957D1AE1CF3A = scripts\engine\utility::getStructArray(arena.target, "targetname");

    foreach(_id_BDF25D8A73FF7DAD in _id_BB81957D1AE1CF3A) {
      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_dom_escape") {
        _id_66BE6E0502FCD39F = spawn("trigger_radius", _id_BDF25D8A73FF7DAD.origin, 0, 60, 10);
        _id_66BE6E0502FCD39F thread _id_8DE238B2A0070A51(arena);
        arena._id_D5BDB69EB6ECFB2F[arena._id_D5BDB69EB6ECFB2F.size] = _id_66BE6E0502FCD39F;
      }

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_dom_key" && level._id_43307855F189EB31._id_CDDD2B80C91E5CAB > 0) {
        if(arena.keys.size < level._id_43307855F189EB31._id_CDDD2B80C91E5CAB)
          arena.keys[arena.keys.size] = spawnscriptable("second_chance_drive", _id_BDF25D8A73FF7DAD.origin);
      }

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_dom_point")
        arena._id_AB7AA90965BBFFAE[arena._id_AB7AA90965BBFFAE.size] = _id_BDF25D8A73FF7DAD.origin;

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_dom_ai_spawn")
        arena._id_79F102B3ABCC6F8A[arena._id_79F102B3ABCC6F8A.size] = _id_BDF25D8A73FF7DAD;

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "patrolstart" || issubstr(_id_BDF25D8A73FF7DAD.script_noteworthy, "patrolpath")) {
        pathstruct = _id_48814951E916AF89::_id_09EDCF99159ABB0B(_id_BDF25D8A73FF7DAD, issubstr(_id_BDF25D8A73FF7DAD.script_noteworthy, "looped"));
        arena._id_D7BAAFC9B07F5094[arena._id_D7BAAFC9B07F5094.size] = pathstruct;
      }

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_dom_cameras")
        arena._id_1ED14283F14082AE[arena._id_1ED14283F14082AE.size] = _id_BDF25D8A73FF7DAD;
    }

    _id_36805F4856473B76(arena);
    level _id_12495EE9A0FA83C2(arena);
    level thread _id_F534043DEBEF1E2A(arena);

    if(level._id_5B530D6E84AC2128._id_AB48B8F9EB30C8FC && arena._id_AB7AA90965BBFFAE.size >= 1) {
      _id_6EFC840EED64C9FA = _id_A4F7AA7494769DCC(arena, arena._id_AB7AA90965BBFFAE[0]);
      _id_6EFC840EED64C9FA _id_6CEB835D3CC29DF1(arena, 0);
      arena.domflag[arena.domflag.size] = _id_6EFC840EED64C9FA;

      if(isDefined(arena._id_AB7AA90965BBFFAE) && arena._id_AB7AA90965BBFFAE.size > 1)
        arena._id_AB7AA90965BBFFAE = scripts\engine\utility::array_randomize(arena._id_AB7AA90965BBFFAE);
    }
  }
}

_id_C68DA8E2DDE4DFA3(arena) {
  player = self;
  level endon("game_ended");
  _id_6E5FDAFE4800CD7D = "gulagai" + arena.gulagindex;
  _id_1CE1B071385A88F0 = "gulagplayers" + arena.gulagindex;

  if(!threatbiasgroupexists(_id_1CE1B071385A88F0))
    createthreatbiasgroup(_id_1CE1B071385A88F0);

  if(!threatbiasgroupexists(_id_6E5FDAFE4800CD7D)) {
    createthreatbiasgroup(_id_6E5FDAFE4800CD7D);
    setthreatbiasagainstall(_id_6E5FDAFE4800CD7D, -100000);
    setthreatbias(_id_6E5FDAFE4800CD7D, _id_1CE1B071385A88F0, 2000);
  }

  if(isDefined(arena._id_707537A8904AA962)) {
    foreach(ai in arena._id_707537A8904AA962) {
      if(isagent(ai))
        ai setthreatbiasgroup(_id_6E5FDAFE4800CD7D);
    }
  }

  foreach(domflag in arena.domflag) {
    domflag _id_22D8A6225E699C6E(1);
    domflag _id_6CEB835D3CC29DF1(arena, 1);
  }

  player._id_4AF73CE40A5D8572 = undefined;
  player._id_C6E39E2728D28253 = player.plundercount;
  player._id_A6E134CA7661708D = level.br_circle.circleindex + 1;
  player._id_C1E95B394CA1743D = arena.arenaplayers.size;
  player _id_3583FF375AB3A91E::_id_63776B389E7C92C1();
  player _id_3583FF375AB3A91E::_id_1167994A7CE49346();

  if(istrue(level._id_5B530D6E84AC2128._id_4D40D2FEC8E9C5B0))
    player _id_DE9DDF5A99C3E235(0);

  if(istrue(level._id_5B530D6E84AC2128._id_A93342FFB3C354E6)) {
    foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
      if(_id_AC0E424AC96A7113 == player) {
        continue;
      }
      _id_AC0E424AC96A7113 thread _id_3583FF375AB3A91E::_id_DA46DE174875958A(player);
    }
  }

  player setthreatbiasgroup(_id_1CE1B071385A88F0);
  player thread _id_1A675077CEF778CD();

  if(level._id_43307855F189EB31._id_732A414F682801CC && isDefined(arena._id_62D1855D36CFF5D2) && arena._id_62D1855D36CFF5D2.size > 0) {
    foreach(loot in arena._id_62D1855D36CFF5D2) {
      if(!isDefined(loot)) {
        continue;
      }
      loot setscriptablepartstate(loot.type, "visible");
    }

    arena._id_62D1855D36CFF5D2 = [];
  }

  if(level._id_43307855F189EB31._id_26F27E5ACF1B3864) {
    _id_2D19E82B56A9C455 = arena.center;
    lootcaches = getlootscriptablearray("br_loot_cache_gulag");

    foreach(_id_B038ED928EC17A81 in lootcaches) {
      if(distance(_id_B038ED928EC17A81.origin, _id_2D19E82B56A9C455) < 8000) {
        items = getscriptablelootcachecontents(_id_B038ED928EC17A81);
        _id_B038ED928EC17A81.contents = _id_552B8E4EA5FF7DF1::_id_EC87B214CD429E96(items, undefined);
        _id_B038ED928EC17A81 setscriptablepartstate("body", "closed_usable");
      }
    }
  }

  if(isDefined(arena._id_707537A8904AA962))
    arena._id_28A470799D66ECD7 = arena._id_707537A8904AA962.size;

  if(isDefined(arena.arenaplayers))
    arena._id_B6B01621833467D1 = arena.arenaplayers.size;

  if(isDefined(arena._id_45E35B44EC23AB43) && arena._id_45E35B44EC23AB43.size > 0) {
    foreach(_id_90C4543B2658D4EF in arena._id_45E35B44EC23AB43)
    spawnscriptable("second_chance_drive", _id_90C4543B2658D4EF);

    arena._id_45E35B44EC23AB43 = [];
  }

  player setclientomnvar("ui_match_start_countdown", 0);

  if(level._id_5B530D6E84AC2128._id_B5B3DB55C42637C3 >= 0)
    player _id_6AFF3948CF4CCA03::playersetplundercount(2);

  arena notify("ai_gulag_matchStarted");
}

_id_AB54F9EDC268063B() {
  return getdvarfloat("dvar_8BE34599DFA102B8", 150.0);
}

_id_F9D544F605DDE72A() {
  return 99;
}

_id_0A48B4BEDB9BD286(_id_607899D4420FE1A5, arena) {
  return 1;
}

_id_DB27FF4A01BA7ACE(offset) {
  return level.br_level.br_circledelaytimes.size - 1 - getdvarint("dvar_1141FEA0C6EF428F", 4) - offset;
}

_id_301ED1C7AC115606() {
  return 0;
}

_id_370F0564E0B9D801() {
  return 2.0;
}

_id_196C3EE37902FF93() {
  return 2.0;
}

_id_8B208C4CA074AAEB(arena) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player.plotarmor = 1;

  if(istrue(level._id_5B530D6E84AC2128._id_9313E9BBEA781AED)) {
    player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
    player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_dom_gulag::gulagDom_matchStartCameraSequence()");
  }

  foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
    if(_id_AC0E424AC96A7113 == player) {
      continue;
    }
    if(isDefined(_id_AC0E424AC96A7113.team) && _id_AC0E424AC96A7113.team == player.team)
      color = "outline_nodepth_green";
    else
      color = "outline_nodepth_yellow";

    player _id_3583FF375AB3A91E::_id_DA46DE174875958A(_id_AC0E424AC96A7113, color, 5.2);
  }

  foreach(agent in arena._id_707537A8904AA962)
  player _id_3583FF375AB3A91E::_id_DA46DE174875958A(agent, "outline_nodepth_red", -1);

  if(level._id_43307855F189EB31._id_4749A3B876804AE5 == 1)
    player _id_3583FF375AB3A91E::_id_63CEF9BB6769F404(arena);

  if(istrue(level._id_5B530D6E84AC2128._id_9313E9BBEA781AED)) {
    player scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
    player scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("br_dom_gulag::gulagDom_matchStartCameraSequence()");
  }

  player thread scripts\mp\hud_message::showsplash("br_dom_gulag_start");

  if(level._id_5B530D6E84AC2128._id_F2ADAAFE5F7860E8) {
    foreach(_id_6F2D5AC61454FF66 in arena._id_D5BDB69EB6ECFB2F) {
      if(istrue(_id_6F2D5AC61454FF66.dooropen))
        player _id_3583FF375AB3A91E::_id_6CE94CF4EEE9EAB7(_id_6F2D5AC61454FF66);
    }
  }

  if(level._id_5B530D6E84AC2128._id_1E63C57879330B37) {
    foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
      if(istrue(_id_AC0E424AC96A7113._id_43B2A82936A5E974))
        player thread _id_3583FF375AB3A91E::_id_DA46DE174875958A(_id_AC0E424AC96A7113, "outline_nodepth_green");
    }
  }

  player skydive_interrupt();
  player notify("gulag_done_with_camera_sequence");
  wait 2;

  if(!isDefined(player)) {
    return;
  }
  player.plotarmor = 0;
}

_id_1A675077CEF778CD() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player notify("gulagDom_trackPlayerBullets");
  player endon("gulagDom_trackPlayerBullets");
  player endon("can_show_splashes");

  for(;;) {
    player waittill("weapon_fired", objweapon);

    if(!isDefined(player._id_322535086C0890FA))
      player._id_322535086C0890FA = 0;

    player._id_322535086C0890FA = player._id_322535086C0890FA + 1;
  }
}

_id_8DE238B2A0070A51(arena) {
  _id_6F2D5AC61454FF66 = self;
  level endon("game_ended");

  for(;;) {
    _id_6F2D5AC61454FF66 waittill("trigger", player);

    if(isDefined(player) && isPlayer(player) && player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag() && !istrue(player._id_4AF73CE40A5D8572)) {
      if(!isDefined(player._id_C1057221E17F180B) || isDefined(player._id_C1057221E17F180B) && player._id_C1057221E17F180B == _id_6F2D5AC61454FF66) {
        if(istrue(player._id_43B2A82936A5E974)) {
          level thread _id_64ACB6CE534155B7::utilflare_shootflare(player.origin, "revive", 1);
          _id_6F2D5AC61454FF66.dooropen = 1;
          _id_6F2D5AC61454FF66 thread _id_ECFEB59B88AA2F77(arena);
          player _id_BA3F4C627DCF8F8B(arena);
          player._id_43B2A82936A5E974 = undefined;
          continue;
        }

        if(istrue(_id_6F2D5AC61454FF66.dooropen) && !istrue(player._id_43B2A82936A5E974))
          player _id_BA3F4C627DCF8F8B(arena);
      }
    }
  }
}

_id_ECFEB59B88AA2F77(arena) {
  _id_6F2D5AC61454FF66 = self;
  _id_6F2D5AC61454FF66 notify("gulagDom_DoorOpened");
  _id_6F2D5AC61454FF66 endon("gulagDom_DoorOpened");

  foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
    if(isDefined(_id_AC0E424AC96A7113._id_C1057221E17F180B) && _id_AC0E424AC96A7113._id_C1057221E17F180B == _id_6F2D5AC61454FF66) {
      continue;
    }
    _id_AC0E424AC96A7113 _id_3583FF375AB3A91E::_id_6CE94CF4EEE9EAB7(_id_6F2D5AC61454FF66);
  }

  wait(level._id_43307855F189EB31._id_4304A1E29279A798);
  _id_6F2D5AC61454FF66 _id_5F0D7586DDA3B8DB(arena);
  _id_6F2D5AC61454FF66.dooropen = 0;
}

_id_BA3F4C627DCF8F8B(arena) {
  player = self;
  player._id_4AF73CE40A5D8572 = 1;
  player _id_F63EFA737CA0E7C1(arena);
}

_id_F63EFA737CA0E7C1(arena) {
  player = self;

  if(level._id_5B530D6E84AC2128._id_B5B3DB55C42637C3 >= 0) {
    _id_9714DDDA6A6DF159 = player.plundercount + player._id_C6E39E2728D28253;
    player _id_6AFF3948CF4CCA03::playersetplundercount(_id_9714DDDA6A6DF159);
  }

  if(level._id_5B530D6E84AC2128._id_599C54CFD95ADDAD)
    player thread _id_3583FF375AB3A91E::_id_A65DF5D97EE38203(arena);

  player _id_3583FF375AB3A91E::_id_0DCEAD2B56FDBF3E("gulag_key");
  player _id_3583FF375AB3A91E::_id_3F18739AE34D9958();
  player _id_DE9DDF5A99C3E235(-1);
  player thread _id_67708F418B1FAC79::gulagvictory(arena, player, 1, 0, "gulag_ai", undefined, undefined, undefined, 1);

  foreach(_id_6F2D5AC61454FF66 in arena._id_D5BDB69EB6ECFB2F)
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_6F2D5AC61454FF66.objid, player);

  if(level._id_5B530D6E84AC2128._id_C47A2536CBDBC9D7) {
    if(isDefined(player._id_2C1B47FBA58F503F)) {
      player._id_2C1B47FBA58F503F destroy();
      player._id_2C1B47FBA58F503F = undefined;
    }
  } else
    player setclientomnvar("ui_br_special_item_acquired", 0);

  foreach(domflag in arena.domflag)
  domflag _id_66CD97251E68435C(0, player);

  if(_id_3583FF375AB3A91E::_id_7AD9FCB1AC4F3DB8())
    player thread _id_63A31DA956C978EE();
}

_id_115AA986E2C13FEA(arena) {
  player = self;

  if(isDefined(self._id_2C1B47FBA58F503F)) {
    self._id_2C1B47FBA58F503F destroy();
    self._id_2C1B47FBA58F503F = undefined;
  }

  foreach(domflag in arena.domflag)
  domflag _id_66CD97251E68435C(0, self);

  if(self.health <= 0)
    _id_40D8983FC5E5C7A5 = "death_ai";
  else
    _id_40D8983FC5E5C7A5 = "time_ran_out";

  _id_3583FF375AB3A91E::_id_0DCEAD2B56FDBF3E(_id_40D8983FC5E5C7A5);
  _id_3583FF375AB3A91E::_id_3F18739AE34D9958();

  if(level._id_5B530D6E84AC2128._id_B5B3DB55C42637C3 >= 0) {
    _id_9714DDDA6A6DF159 = player.plundercount + player._id_C6E39E2728D28253;
    player _id_6AFF3948CF4CCA03::playersetplundercount(_id_9714DDDA6A6DF159);
  }
}

_id_34C2AB381E6C17CB(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
    return;
  }
  if(isDefined(player._id_43B2A82936A5E974)) {
    return;
  }
  player _id_37F6A694B8C6656A();
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);
  arena._id_45E35B44EC23AB43[arena._id_45E35B44EC23AB43.size] = instance.origin;
  instance freescriptable();
}

_id_37F6A694B8C6656A() {
  player = self;
  _id_F9CD7FDA74E92E2A = 8;
  _id_E0E11F3B4551BE11 = 1;
  _id_30516B4AFD1763DE = 500;
  maxdistance = 25000;
  iconname = "hud_icon_loot_key_skeleton";
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);

  if(isDefined(arena)) {
    foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
      if(_id_AC0E424AC96A7113 == player) {
        continue;
      }
      _id_AC0E424AC96A7113 thread scripts\mp\hud_message::showsplash("br_large_gulag_got_key_enemy");

      if(level._id_5B530D6E84AC2128._id_F455B3807D4EA69D) {
        headicon = player scripts\cp_mp\entityheadicons::setheadicon_singleimage(_id_AC0E424AC96A7113, iconname, _id_F9CD7FDA74E92E2A, _id_E0E11F3B4551BE11, maxdistance, _id_30516B4AFD1763DE, undefined, 1, 1, undefined);
        _id_AC0E424AC96A7113 thread _id_FA6FE679B2067AC9(headicon, player);
        player thread _id_E8A3FB7A095C39B8(headicon, _id_AC0E424AC96A7113);
      }
    }
  }

  player._id_43B2A82936A5E974 = 1;

  if(level._id_5B530D6E84AC2128._id_17EE664650BD17CB == 0)
    player _id_6E29D1220EA1A70E();
  else if(level._id_5B530D6E84AC2128._id_17EE664650BD17CB == 1)
    player _id_3C8729CDB6A4372B();
  else if(level._id_5B530D6E84AC2128._id_17EE664650BD17CB == 2) {
    _id_6F2D5AC61454FF66 = player _id_C46CDEE20F0BD709();
    player _id_3583FF375AB3A91E::_id_6CE94CF4EEE9EAB7(_id_6F2D5AC61454FF66);
    player._id_C1057221E17F180B = _id_6F2D5AC61454FF66;
  }

  player thread scripts\mp\hud_message::showsplash("br_large_gulag_got_key_self");

  if(level._id_5B530D6E84AC2128._id_C47A2536CBDBC9D7)
    player._id_2C1B47FBA58F503F = player _id_3583FF375AB3A91E::_id_0573DFD8CB86D79F(&"MP/BR_DOM_GULAG_KEY_EARNED", undefined, "RIGHT", "CENTER", 90, 200);
  else
    player setclientomnvar("ui_br_special_item_acquired", 1);

  if(level._id_5B530D6E84AC2128._id_1E63C57879330B37) {
    foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
      if(_id_AC0E424AC96A7113 == player) {
        continue;
      }
      _id_AC0E424AC96A7113 thread _id_3583FF375AB3A91E::_id_DA46DE174875958A(player, "outline_nodepth_green");
    }
  }
}

_id_C46CDEE20F0BD709() {
  player = self;
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);

  if(!isDefined(arena)) {
    return;
  }
  _id_1AF1E8013FA97E2C = sortbydistance(arena._id_D5BDB69EB6ECFB2F, player.origin);
  _id_8DD9F2EB8215A139 = abs((gettime() - (player._id_F42099A4E4FA8BC9 + level.gulag.timelimit * 1000)) / 1000);
  _id_B7B9865CA59961D9 = strtok(level._id_5B530D6E84AC2128._id_B7B9865CA59961D9, " ");
  _id_1FC860A3DD042E43 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B7B9865CA59961D9.size; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 2) {
    if(int(_id_B7B9865CA59961D9[_id_AC0E594AC96AA3A8]) < _id_8DD9F2EB8215A139) {
      if(isDefined(_id_B7B9865CA59961D9[_id_AC0E594AC96AA3A8 + 1]))
        _id_1FC860A3DD042E43 = _id_B7B9865CA59961D9[_id_AC0E594AC96AA3A8 + 1];
      else
        _id_1FC860A3DD042E43 = _id_B7B9865CA59961D9[_id_AC0E594AC96AA3A8 - 1];

      break;
    }
  }

  return _id_1AF1E8013FA97E2C[int(_id_1FC860A3DD042E43)];
}

_id_E8A3FB7A095C39B8(headicon, _id_0CA5A607C4F7A315) {
  _id_B37AEF355BA7B694 = self;
  level endon("game_ended");
  _id_0CA5A607C4F7A315 endon("watchHeadIconDelete");
  scripts\engine\utility::waittill_any_ents(_id_B37AEF355BA7B694, "death", _id_B37AEF355BA7B694, "disconnect", _id_B37AEF355BA7B694, "gulag_end", _id_B37AEF355BA7B694, "gulagLost");

  if(!isDefined(_id_B37AEF355BA7B694)) {
    return;
  }
  removeclientfromheadiconmask(headicon, _id_B37AEF355BA7B694);
}

_id_FA6FE679B2067AC9(headicon, _id_B37AEF355BA7B694) {
  _id_0CA5A607C4F7A315 = self;
  level endon("game_ended");
  scripts\engine\utility::waittill_any_ents(_id_0CA5A607C4F7A315, "death", _id_0CA5A607C4F7A315, "disconnect", _id_0CA5A607C4F7A315, "gulag_end", _id_0CA5A607C4F7A315, "gulagLost");
  _id_0CA5A607C4F7A315 notify("watchHeadIconDelete");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(headicon);
}

_id_12495EE9A0FA83C2(arena) {
  foreach(_id_6F2D5AC61454FF66 in arena._id_D5BDB69EB6ECFB2F) {
    objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(objid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", _id_6F2D5AC61454FF66.origin + (0, 0, 60), "ui_mp_br_icon_gulag_exit_objective");
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);
    } else {}

    _id_6F2D5AC61454FF66.objid = objid;
  }
}

_id_3C8729CDB6A4372B() {
  player = self;
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);

  if(!isDefined(arena)) {
    return;
  }
  _id_2464EDC7C410E680 = arena._id_D5BDB69EB6ECFB2F[0];
  _id_2B1CDEDF8B109EDB = distance(_id_2464EDC7C410E680.origin, player.origin);

  foreach(_id_6F2D5AC61454FF66 in arena._id_D5BDB69EB6ECFB2F) {
    _id_AF169CA88313D704 = distance(_id_6F2D5AC61454FF66.origin, player.origin);

    if(_id_2B1CDEDF8B109EDB > distance(_id_6F2D5AC61454FF66.origin, player.origin)) {
      _id_2464EDC7C410E680 = _id_6F2D5AC61454FF66;
      _id_2B1CDEDF8B109EDB = _id_AF169CA88313D704;
    }
  }

  objective_addclienttomask(_id_2464EDC7C410E680.objid, player);
  objective_showtoplayersinmask(_id_2464EDC7C410E680.objid);
}

_id_5F0D7586DDA3B8DB(arena) {
  _id_6F2D5AC61454FF66 = self;

  foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
    if(isDefined(_id_AC0E424AC96A7113._id_C1057221E17F180B) && _id_AC0E424AC96A7113._id_C1057221E17F180B == _id_6F2D5AC61454FF66) {
      continue;
    }
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_6F2D5AC61454FF66.objid, _id_AC0E424AC96A7113);
  }
}

_id_6E29D1220EA1A70E() {
  player = self;
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);

  foreach(_id_6F2D5AC61454FF66 in arena._id_D5BDB69EB6ECFB2F) {
    objective_addclienttomask(_id_6F2D5AC61454FF66.objid, player);
    objective_showtoplayersinmask(_id_6F2D5AC61454FF66.objid);
  }
}

_id_31B5A57BEAC56067() {
  loadout = [];
  loadout["loadoutArchetype"] = "archetype_assault";

  if(level._id_43307855F189EB31._id_5466042078981FF3 == 0)
    loadout["loadoutPrimary"] = "iw9_me_fists";
  else if(level._id_43307855F189EB31._id_5466042078981FF3 == 1)
    loadout["loadoutPrimary"] = "iw9_pi_decho";
  else if(level._id_43307855F189EB31._id_5466042078981FF3 == 2)
    loadout["loadoutPrimary"] = "iw9_ar_mike4_mp";
  else if(level._id_43307855F189EB31._id_5466042078981FF3 == 3)
    loadout["loadoutPrimary"] = "iw9_sh_mbravo_mp";

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
  loadout["loadoutEquipmentPrimary"] = "none";
  loadout["loadoutEquipmentSecondary"] = "none";
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

_id_3104D393DC6CC377(arena) {
  player = self;
  player endon("death_or_disconnect");
  level endon("game_ended");

  if(!istrue(level._id_5B530D6E84AC2128._id_4D40D2FEC8E9C5B0)) {
    return;
  }
  if(!isDefined(player._id_32484CD3B17F16C8))
    player._id_32484CD3B17F16C8 = 0;

  if(!isDefined(player._id_F73178C689F257AE))
    player._id_F73178C689F257AE = 0;

  points = player._id_32484CD3B17F16C8 + player._id_F73178C689F257AE;
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

_id_6EC844085B807D62(agent, _id_6181DE250AFA5BB6) {
  if(!isPlayer(_id_6181DE250AFA5BB6)) {
    return;
  }
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(_id_6181DE250AFA5BB6);

  if(!isDefined(arena)) {
    return;
  }
  if(!isDefined(_id_6181DE250AFA5BB6._id_F73178C689F257AE))
    _id_6181DE250AFA5BB6._id_F73178C689F257AE = 0;

  if(!isDefined(_id_6181DE250AFA5BB6._id_32484CD3B17F16C8))
    _id_6181DE250AFA5BB6._id_32484CD3B17F16C8 = 0;

  _id_6181DE250AFA5BB6._id_F73178C689F257AE = _id_6181DE250AFA5BB6._id_F73178C689F257AE + 1;

  if(istrue(level._id_5B530D6E84AC2128._id_4D40D2FEC8E9C5B0)) {
    _id_6181DE250AFA5BB6 playsoundtoplayer("mp_killconfirm_tags_pickup", _id_6181DE250AFA5BB6);
    _id_6181DE250AFA5BB6 _id_DE9DDF5A99C3E235(_id_6181DE250AFA5BB6._id_F73178C689F257AE + _id_6181DE250AFA5BB6._id_32484CD3B17F16C8);
  }

  if(istrue(level._id_43307855F189EB31._id_6EFB9D0AFA7EFCB2)) {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    agent thread _id_7E52B56769FA7774::_id_55463A3679678E2F(dropstruct);
  }

  if(getdvarint("dvar_39D4D700E41D2EDC", 1)) {
    _id_C229D93C0BB4F8E8 = arena._id_79F102B3ABCC6F8A[randomint(arena._id_79F102B3ABCC6F8A.size)];

    if(isDefined(agent._id_C229D93C0BB4F8E8))
      _id_C229D93C0BB4F8E8 = agent._id_C229D93C0BB4F8E8;

    _id_1439F86640D42E34 = undefined;

    if(_id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "subcategory") == "jugg")
      _id_1439F86640D42E34 = "jugg";

    agent thread _id_5CDA031797DCE489::_id_62729CB2F806997A(arena, _id_C229D93C0BB4F8E8, _id_1439F86640D42E34);
  }
}

_id_D22E87091AFD9FB7(attacker, victim) {
  if(!isDefined(attacker) || !isDefined(victim)) {
    return;
  }
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(attacker);

  if(!isDefined(arena)) {
    return;
  }
  if(!isDefined(attacker._id_32484CD3B17F16C8))
    attacker._id_32484CD3B17F16C8 = 0;

  if(!isDefined(attacker._id_F73178C689F257AE))
    attacker._id_F73178C689F257AE = 0;

  attacker._id_32484CD3B17F16C8 = attacker._id_32484CD3B17F16C8 + 1;

  if(istrue(level._id_5B530D6E84AC2128._id_4D40D2FEC8E9C5B0)) {
    attacker playsoundtoplayer("mp_killconfirm_tags_pickup", attacker);
    attacker _id_DE9DDF5A99C3E235(attacker._id_F73178C689F257AE + attacker._id_32484CD3B17F16C8);
  }

  if(isDefined(attacker._id_43B2A82936A5E974))
    return;
}

_id_DE9DDF5A99C3E235(value) {
  player = self;
  player setclientomnvar("ui_br_ai_gulag_score", value);
}

_id_6E49EA089039048A() {
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

_id_19ECEF885C1CEC21(player) {
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

_id_9005AF34E01BF8FE() {
  if(isDefined(level._id_5B530D6E84AC2128) && istrue(level._id_5B530D6E84AC2128._id_3E34096B136F9A10))
    return 1;

  return 0;
}

_id_F79445AE166C7150(attacker, victim) {
  if(!_id_9005AF34E01BF8FE() || !isDefined(victim) || !isDefined(attacker))
    return 0;

  if(istrue(level._id_5B530D6E84AC2128._id_991A2D40AE12A427))
    return 0;

  if(isPlayer(victim) && isPlayer(attacker)) {
    if(istrue(victim.gulag) && istrue(attacker.gulag))
      return 1;
  }

  return 0;
}

_id_DB60ABB28498007B() {
  player = self;

  if(isDefined(level._id_5B530D6E84AC2128) && istrue(level._id_5B530D6E84AC2128._id_3E34096B136F9A10) && player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag() && istrue(player._id_43B2A82936A5E974) && istrue(level._id_43307855F189EB31._id_EC2EAA1A4B68C0CF))
    return 1;

  return 0;
}

_id_CD7C7D0FC6ADF4B1(eattacker, _id_19EF223648735F8F) {
  if(_id_9005AF34E01BF8FE() && isDefined(eattacker) && istrue(eattacker.gulag) && isPlayer(eattacker)) {
    arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(eattacker);

    if(isDefined(arena)) {
      if(!isDefined(eattacker._id_D25277121D9D0A6C))
        eattacker._id_D25277121D9D0A6C = 0;

      eattacker._id_D25277121D9D0A6C = min(eattacker._id_D25277121D9D0A6C + 1, eattacker._id_322535086C0890FA);

      if(isDefined(_id_19EF223648735F8F)) {
        if(!isDefined(eattacker._id_A6E0850023A9D8F9))
          eattacker._id_A6E0850023A9D8F9 = 0;

        eattacker._id_A6E0850023A9D8F9 = eattacker._id_A6E0850023A9D8F9 + _id_19EF223648735F8F;
      }
    }
  }
}

_id_F534043DEBEF1E2A(arena) {
  if(!isDefined(arena._id_707537A8904AA962)) {
    arena._id_7B2D0FF4698FB2E9 = 1;

    if(isDefined(arena._id_79F102B3ABCC6F8A))
      thread _id_9971773D776C97AB(arena);

    arena waittill("matchEnded");
    thread _id_0FB48C109B5C01F0(arena);
  }
}

_id_36805F4856473B76(arena) {
  category = "gulag";
  _id_48814951E916AF89::_id_BA4022744DCE59F6(category);
}

_id_9971773D776C97AB(arena) {
  if(_id_3583FF375AB3A91E::_id_D8F18F1D691C0EF8(arena))
    thread _id_5CDA031797DCE489::_id_89235E4FE5354B16(arena);
  else {
    foreach(_id_55E69FB0CE97F15E in arena._id_79F102B3ABCC6F8A)
    thread _id_7B5F223F3EA0FD5A(arena, _id_55E69FB0CE97F15E);
  }
}

_id_7B5F223F3EA0FD5A(arena, _id_55E69FB0CE97F15E) {
  aitype = "enemy_mp_smg_tier1_aq";
  _id_2AC210AF318CF38B = _id_55E69FB0CE97F15E.origin;

  if(!getdvarint("dvar_B3D7A9483362813E", 0))
    _id_2AC210AF318CF38B = getclosestpointonnavmesh(_id_55E69FB0CE97F15E.origin);

  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_2AC210AF318CF38B, _id_55E69FB0CE97F15E.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1);

  if(isagent(agent)) {
    agent thread _id_65B46C19509929FE(arena);

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

_id_0F6147F8AE8D6DEB(arena) {
  if(!istrue(arena._id_7B2D0FF4698FB2E9))
    _id_F534043DEBEF1E2A(arena);

  _id_C99A915A0DD0DF12 = 0;

  if(_id_C99A915A0DD0DF12) {
    foreach(agent in arena._id_707537A8904AA962) {
      if(isagent(agent)) {}
    }
  }
}

_id_65B46C19509929FE(arena) {
  if(!isDefined(arena._id_707537A8904AA962))
    arena._id_707537A8904AA962 = [];

  arena._id_707537A8904AA962 = scripts\engine\utility::array_add(arena._id_707537A8904AA962, self);

  foreach(player in arena.arenaplayers)
  player _id_3583FF375AB3A91E::_id_DA46DE174875958A(self, "outline_nodepth_red", -1);
}

_id_6AF7DEB2B9A1DD06(arena) {
  if(isDefined(arena._id_707537A8904AA962)) {
    arena._id_707537A8904AA962 = scripts\engine\utility::array_remove(arena._id_707537A8904AA962, self);

    if(isagent(self)) {
      self notify("hidePlayerOutlineToPlayer");

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

_id_0FB48C109B5C01F0(arena) {
  if(isDefined(arena._id_707537A8904AA962)) {
    foreach(agent in arena._id_707537A8904AA962) {
      if(isagent(agent)) {
        agent _id_6AF7DEB2B9A1DD06(arena);
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

_id_A4F7AA7494769DCC(arena, _id_37E3A1EAA43EA82C) {
  _id_D0EAD7E588A015C5 = getdvarint("dvar_177D32D81BD6BC15", 130);
  _id_D30B471F5A146C39 = spawn("trigger_radius", _id_37E3A1EAA43EA82C, 0, _id_D0EAD7E588A015C5, 120);
  _id_D30B471F5A146C39.script_label = "_a";
  arenaflag = _id_6663215F917210AE::setupobjective(_id_D30B471F5A146C39, "neutral", undefined, 1);
  arenaflag.onuse = ::_id_AC9E0DA4D9B4494D;
  arenaflag.onbeginuse = ::_id_F49D19B1B7ACFA56;
  arenaflag.onenduse = ::_id_9A942FEFE2C0E3B2;
  arenaflag.isarena = 1;
  arenaflag scripts\mp\gameobjects::pinobjiconontriggertouch();
  arenaflag.id = "domFlag";
  arenaflag scripts\mp\gameobjects::setcapturebehavior("all_teams_dom_together");
  arenaflag.scriptable delete();
  arenaflag.ignorestomp = 1;
  arenaflag scripts\mp\gameobjects::requestid(0, 1, undefined, 0, 0);
  arenaflag.visibilitymanuallycontrolled = 1;
  arenaflag _id_22D8A6225E699C6E(1);
  arenaflag _id_6CEB835D3CC29DF1(arena, 1);
  arenaflag.arena = arena;
  return arenaflag;
}

_id_AC9E0DA4D9B4494D(_id_5AB435632B934364) {
  level thread _id_64ACB6CE534155B7::utilflare_shootflare(self.flagmodel.origin, "revive", 1);
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(_id_5AB435632B934364);
  _id_2B24AEDF3A828B22 = self.touchlist;
  _id_22D8A6225E699C6E(0);
  thread _id_8DEAE1CF3790AED2(arena);

  if(!isDefined(arena)) {
    return;
  }
  foreach(_id_687E3456E754E3E1 in _id_2B24AEDF3A828B22) {
    foreach(touchlist in _id_687E3456E754E3E1) {
      _id_AC0E424AC96A7113 = touchlist.player;

      if(!isDefined(_id_AC0E424AC96A7113)) {
        continue;
      }
      if(!istrue(_id_AC0E424AC96A7113.gulag)) {
        continue;
      }
      _id_AC0E424AC96A7113 _id_9A942FEFE2C0E3B2(_id_AC0E424AC96A7113.team, _id_AC0E424AC96A7113, 1);
      _id_AC0E424AC96A7113 _id_66CD97251E68435C(0, _id_AC0E424AC96A7113);
      _id_AC0E424AC96A7113 _id_F63EFA737CA0E7C1(arena);
    }
  }
}

_id_8DEAE1CF3790AED2(arena) {
  arenaflag = self;
  level endon("game_ended");
  arenaflag notify("gulagDom_arenaFlagRestartDom");
  arenaflag endon("gulagDom_arenaFlagRestartDom");
  arenaflag _id_6CEB835D3CC29DF1(arena, 0);
  wait 3;
  arenaflag _id_22D8A6225E699C6E(1);
  arenaflag _id_6CEB835D3CC29DF1(arena, 1);
  arenaflag.flagmodel playsoundonmovingent("flag_spawned");

  if(isDefined(arena._id_AB7AA90965BBFFAE) && arena._id_AB7AA90965BBFFAE.size > 1)
    arena._id_AB7AA90965BBFFAE = scripts\engine\utility::array_randomize(arena._id_AB7AA90965BBFFAE);

  index = randomint(arena._id_AB7AA90965BBFFAE.size);
  location = arena._id_AB7AA90965BBFFAE[index];
  arenaflag.flagmodel.origin = location;
  arenaflag.visuals[0].origin = location;
  arenaflag.trigger.origin = location;
  objective_position(arenaflag.objidnum, location + (0, 0, 100));
}

_id_F49D19B1B7ACFA56(_id_5AB435632B934364) {
  player = _id_5AB435632B934364;
  player.iscapturing = 1;
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral" && isPlayer(player))
    player setclientomnvar("ui_objective_pinned_text_param", 1);

  self.didstatusnotify = 1;
  scripts\mp\gameobjects::setusetime(level._id_5B530D6E84AC2128._id_CB871A5B28F14E14);
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_taking", "waypoint_taking");
}

_id_9A942FEFE2C0E3B2(team, player, success) {
  self.didstatusnotify = 0;

  if(success)
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);

  if(isPlayer(player)) {
    player.iscapturing = 0;
    player setclientomnvar("ui_objective_pinned_text_param", 0);
    player.ui_dom_securing = undefined;
  }

  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral");
  thread _id_6663215F917210AE::updateflagstate("idle", 0);
  self.neutralized = 0;
}

_id_22D8A6225E699C6E(enable) {
  if(enable) {
    scripts\mp\gameobjects::allowuse("any");
    self.trigger scripts\engine\utility::trigger_on();
  } else {
    scripts\mp\gameobjects::allowuse("none");
    self.trigger scripts\engine\utility::trigger_off();
    scripts\mp\gameobjects::resetcaptureprogress();
  }
}

_id_6CEB835D3CC29DF1(arena, enable, _id_9CB4BDC2122D46EB, _id_DDF49B0F7BD17A0C) {
  self notify("gulagDom_arenaFlagSetVisible");

  if(enable) {
    icon = "waypoint_captureneutral";

    if(istrue(_id_9CB4BDC2122D46EB))
      icon = level.iconovertime;

    thread _id_EEC0F9596304FDBF(arena);
    thread scripts\mp\gameobjects::setobjectivestatusicons(icon);
    thread scripts\mp\gameobjects::setownerteam("neutral");
    thread _id_6663215F917210AE::updateflagstate("idle", 0, "none");
    self.flagmodel show();
    thread _id_B97C83E94112CC1A(arena, 1);

    if(!istrue(_id_9CB4BDC2122D46EB)) {
      _id_67708F418B1FAC79::setovertimeomnvarenabled(arena, 1);
      return;
    }
  } else
    thread _id_C47B28B610FC1026(arena, _id_9CB4BDC2122D46EB, _id_DDF49B0F7BD17A0C);
}

_id_C47B28B610FC1026(arena, _id_9CB4BDC2122D46EB, _id_DDF49B0F7BD17A0C) {
  self endon("arenaFlag_setVisible");

  if(!istrue(_id_DDF49B0F7BD17A0C)) {
    objective_setpinned(self.objidnum, 0);
    wait 1;
  }

  thread _id_B97C83E94112CC1A(arena, 0);
  thread _id_5614184015570A1A(_id_DDF49B0F7BD17A0C);
  thread _id_6663215F917210AE::updateflagstate("off", 0, "none");
  self.flagmodel hide(1);

  if(!istrue(_id_9CB4BDC2122D46EB)) {
    _id_67708F418B1FAC79::setovertimeomnvarenabled(arena, 0);
    _id_67708F418B1FAC79::setovertimeomnvarprogress(arena, 0);
  }
}

_id_EEC0F9596304FDBF(arena) {
  objective_removeallfrommask(self.objidnum);

  foreach(player in arena.arenaplayers)
  objective_addclienttomask(self.objidnum, player);

  objective_showtoplayersinmask(self.objidnum);
}

_id_5614184015570A1A(_id_DDF49B0F7BD17A0C) {
  objective_setshowprogress(self.objidnum, 0);
  objective_removeallfrommask(self.objidnum);
  objective_showtoplayersinmask(self.objidnum);
}

_id_B97C83E94112CC1A(arena, enable) {
  if(!isDefined(arena) || !isDefined(arena.arenaplayers)) {
    return;
  }
  if(enable) {
    if(arena.arenaplayers.size > 0)
      self.flagmodel hudoutlineenableforclients(arena.arenaplayers, "outline_nodepth_orange");
  } else if(arena.arenaplayers.size > 0)
    self.flagmodel hudoutlinedisableforclients(arena.arenaplayers);
}

_id_66CD97251E68435C(enable, player) {
  player endon("death_or_disconnect");

  if(enable) {
    player setclientomnvar("ui_overtime_timer_show", 1);
    objective_addclienttomask(self.objidnum, player);
  } else {
    objective_unpinforclient(self.objidnum, player);
    wait 1;
    player setclientomnvar("ui_overtime_timer_show", 0);
    objective_removeclientfrommask(self.objidnum, player);
  }

  thread _id_67708F418B1FAC79::arenaflag_showflagoutlineplayer(enable, player);
}

_id_A504BD9AE48A23D8() {
  level endon("game_ended");
  level waittill("prematch_done");
  wait(level._id_5B530D6E84AC2128._id_C96EEE8D172A57C6);

  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }
    if(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
      continue;
    }
    player kill();
    wait 1;
  }
}

_id_63A31DA956C978EE() {
  player = self;
  player endon("disconnect");
  level endon("game_ended");
  wait 13;
  player kill();
}

_id_F9FAE1B8F601F0EA(arena) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player _id_3583FF375AB3A91E::_id_3F18739AE34D9958();

  if(isDefined(arena._id_D5BDB69EB6ECFB2F)) {
    foreach(_id_6F2D5AC61454FF66 in arena._id_D5BDB69EB6ECFB2F) {
      if(isDefined(_id_6F2D5AC61454FF66) && isDefined(_id_6F2D5AC61454FF66.objid) && isDefined(player))
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_6F2D5AC61454FF66.objid, player);
    }
  }

  if(level._id_5B530D6E84AC2128._id_C47A2536CBDBC9D7) {
    if(isDefined(player._id_2C1B47FBA58F503F)) {
      player._id_2C1B47FBA58F503F destroy();
      player._id_2C1B47FBA58F503F = undefined;
    }
  } else
    player setclientomnvar("ui_br_special_item_acquired", 0);

  foreach(domflag in arena.domflag)
  domflag _id_66CD97251E68435C(0, player);

  if(player.health <= 0) {
    wait 6;

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
      player _id_67708F418B1FAC79::playergulagautowin("domGulag", _id_F0EA4030349A33D5);
      wait 6;

      if(!isDefined(player)) {
        return;
      }
      player kill();
      return;
    }
  } else {
    player thread _id_67708F418B1FAC79::gulagvictory(arena, player, 1, 0, "shutdown");
    wait 9;

    if(!isDefined(player)) {
      return;
    }
    player kill();
  }
}