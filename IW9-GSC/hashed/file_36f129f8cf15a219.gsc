/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_36f129f8cf15a219.gsc
***********************************************/

_id_C99F924FA8207378() {
  level._id_C6877E979D75F191 = spawnStruct();
  level._id_C6877E979D75F191._id_F443B3DC5E606CD3 = 1;
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetMatchDuration", ::_id_8F5B44EE18A6DECA);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetMaxPlayers", ::_id_E9A47AB830AC1CC5);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagIsMatchPending", ::_id_C1E9CFBE4012B893);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetClosedCircleIndex", ::_id_D93FBF0BC270F36F);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetCountdownLength", ::_id_372395E6755D5A8C);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagIsOneTeamLeft", ::_id_B0FC2AF257A22F45);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetVictoryWait", ::_id_669976CE21613EE0);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGetPostVictoryWait", ::_id_7767D68C8C3FCE72);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagHandleLossInfiniteEarly", ::_id_0D06455FCF3EC9EB);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagGiveAIKillRewards", ::_id_DDDEEDEE8F02562C);
  _id_5BC60484D17FA95C::_id_C9FA720726FAB853("gulagLoseSequence", ::_id_2715F6A1CA390F47);
  _id_5BC60484D17FA95C::_id_8DEBF0C616BF9480("gulagOvertime");
  level _id_48814951E916AF89::_id_93ADD0B65DB9F722(::_id_0A6B64FC536E1D37);
  level thread _id_2125D6C49B78388F();

  if(!isDefined(level._id_289DF80E1DED586F))
    thread _id_48814951E916AF89::init();

  if(_id_3583FF375AB3A91E::_id_7AD9FCB1AC4F3DB8())
    level thread _id_B767720F3F3717EF();

  level thread _id_5CDA031797DCE489::_id_25A296C2ED85E35F();
}

_id_2125D6C49B78388F() {
  level waittill("prematch_done");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("second_chance_drive", ::_id_CBEEEB6EAFFAA114);

  foreach(arena in level.gulag.arenas) {
    arena._id_D5BDB69EB6ECFB2F = [];
    arena.keys = [];
    arena._id_45E35B44EC23AB43 = [];
    arena._id_62D1855D36CFF5D2 = [];
    _id_BB81957D1AE1CF3A = scripts\engine\utility::getStructArray(arena.target, "targetname");

    foreach(_id_BDF25D8A73FF7DAD in _id_BB81957D1AE1CF3A) {
      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_large_escape_door") {
        _id_66BE6E0502FCD39F = spawn("trigger_radius", _id_BDF25D8A73FF7DAD.origin, 0, 60, 10);
        arena._id_D5BDB69EB6ECFB2F[arena._id_D5BDB69EB6ECFB2F.size] = _id_66BE6E0502FCD39F;
      }

      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_large_legendary_loot_structs" && level._id_43307855F189EB31._id_CDDD2B80C91E5CAB != 0) {
        if(level._id_43307855F189EB31._id_CDDD2B80C91E5CAB < 0 || arena.keys.size < level._id_43307855F189EB31._id_CDDD2B80C91E5CAB)
          arena.keys[arena.keys.size] = spawnscriptable("second_chance_drive", _id_BDF25D8A73FF7DAD.origin);
      }
    }

    _id_F02D2C1DE50BB269(arena);
    level _id_55ADE1B0B40E05D5(arena);
    level thread _id_DB6BA7931EB88793(arena);
  }
}

_id_8F5B44EE18A6DECA() {
  return getdvarfloat("dvar_8BE34599DFA102B8", 60.0);
}

_id_E9A47AB830AC1CC5() {
  return 8;
}

_id_C1E9CFBE4012B893(_id_607899D4420FE1A5, arena) {
  if(_id_607899D4420FE1A5.size < 8)
    return 0;
  else
    return 1;
}

_id_D93FBF0BC270F36F(offset) {
  return level.br_level.br_circledelaytimes.size - 1 - getdvarint("scr_br_fc_circle_disable", 4) - offset;
}

_id_372395E6755D5A8C() {
  return getdvarint("dvar_0FB05C5F6825931D", 3);
}

_id_B0FC2AF257A22F45() {
  return 0;
}

_id_669976CE21613EE0() {
  return 3.0;
}

_id_7767D68C8C3FCE72() {
  return 2.0;
}

_id_36F38CD0FC5FEEAC(arena) {
  level thread _id_DB6BA7931EB88793(arena);
  level thread _id_74624E51971E5186(arena);

  if(isDefined(arena._id_45E35B44EC23AB43) && arena._id_45E35B44EC23AB43.size > 0) {
    foreach(_id_90C4543B2658D4EF in arena._id_45E35B44EC23AB43)
    spawnscriptable("second_chance_drive", _id_90C4543B2658D4EF);

    arena._id_45E35B44EC23AB43 = [];
  }
}

_id_7A93B7F959EFF093(arena) {
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

  foreach(_id_6F2D5AC61454FF66 in arena._id_D5BDB69EB6ECFB2F)
  _id_6F2D5AC61454FF66 thread _id_72DF31D819988A76(arena);

  foreach(player in arena.arenaplayers) {
    player thread scripts\mp\hud_message::showsplash("br_large_gulag_start");
    player._id_32484CD3B17F16C8 = undefined;
    player._id_3A7C9A3E9AA20358 = undefined;
    player._id_D25277121D9D0A6C = undefined;
    player._id_322535086C0890FA = undefined;
    player._id_0938604A8B5DD849 = undefined;
    player._id_E1ED3A7677EF1776 = undefined;
    player._id_A8FC9188D0F627AD = undefined;

    if(isDefined(player._id_97AC1EA78FAEA6E3)) {
      player._id_97AC1EA78FAEA6E3 = undefined;
      arena._id_C83619011083E3C2 = 1;
    }

    player _id_3583FF375AB3A91E::_id_63776B389E7C92C1();
    player _id_3583FF375AB3A91E::_id_1167994A7CE49346();
    player _id_6CD1F6F8FBABF600(0);
    player setthreatbiasgroup(_id_1CE1B071385A88F0);
    player thread _id_A829C9B7D4DA8480();
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

  if(isDefined(arena._id_707537A8904AA962))
    arena._id_28A470799D66ECD7 = arena._id_707537A8904AA962.size;

  if(isDefined(arena.arenaplayers))
    arena._id_B6B01621833467D1 = arena.arenaplayers.size;

  arena notify("ai_gulag_matchStarted");
}

_id_74624E51971E5186(arena) {
  wait 1;
  _id_B4637ECADC7205C6 = (-6.16415, -0.554057, 1050);
  _id_6C9E9A5AC1A039A9 = (-6.16415, -0.554057, 870);
  _id_A92416210045EA54 = (-353.134, -123.783, 273.378);
  _id_06318224598B656B = (-438.192, -59.7148, 230.022);
  camera = spawn("script_model", _id_B4637ECADC7205C6);
  camera setModel("tag_origin");
  camera.angles = (90, 0, 0);

  foreach(player in arena.arenaplayers)
  player cameralinkTo(camera, "tag_origin", 1, 1);

  camera moveTo(_id_6C9E9A5AC1A039A9, 3, 0.5, 0.5);
  wait 3;
  camera.origin = _id_A92416210045EA54;
  camera.angles = (30, 140, 0);
  camera moveTo(_id_06318224598B656B, 3, 0.5, 0.5);
  wait 3;

  foreach(player in arena.arenaplayers)
  player cameraunlink();

  wait 0.5;
  camera delete();
}

_id_A829C9B7D4DA8480() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player notify("gulagLarge_trackPlayerBullets");
  player endon("gulagLarge_trackPlayerBullets");
  player endon("can_show_splashes");

  for(;;) {
    player waittill("weapon_fired", objweapon);

    if(!isDefined(player._id_322535086C0890FA))
      player._id_322535086C0890FA = 0;

    player._id_322535086C0890FA = player._id_322535086C0890FA + 1;
  }
}

_id_B767720F3F3717EF() {
  level endon("game_ended");
  level waittill("prematch_done");
  wait 6;

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

_id_72DF31D819988A76(arena) {
  _id_6F2D5AC61454FF66 = self;
  level endon("game_ended");

  while(arena.arenaplayers.size > 0) {
    _id_6F2D5AC61454FF66 waittill("trigger", player);

    if(!istrue(player._id_A8FC9188D0F627AD)) {
      continue;
    }
    if(scripts\engine\utility::array_contains(arena.arenaplayers, player)) {
      player thread _id_3583FF375AB3A91E::_id_A65DF5D97EE38203(arena);
      player _id_3583FF375AB3A91E::_id_0DCEAD2B56FDBF3E("win");
      player _id_3583FF375AB3A91E::_id_3F18739AE34D9958();
      player _id_6CD1F6F8FBABF600(-1);

      foreach(_id_6F2D5AC61454FF66 in arena._id_D5BDB69EB6ECFB2F)
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_6F2D5AC61454FF66.objid, player);

      player thread _id_67708F418B1FAC79::gulagvictory(arena, player, 1, 0, "gulag_ai", undefined, undefined, undefined, 1);

      if(_id_3583FF375AB3A91E::_id_7AD9FCB1AC4F3DB8())
        player thread _id_CC815BD31C5E382D();
    }
  }
}

_id_CC815BD31C5E382D() {
  player = self;
  player endon("disconnect");
  level endon("game_ended");
  wait 11;
  player kill();
}

_id_CBEEEB6EAFFAA114(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
    return;
  }
  if(isDefined(player._id_A8FC9188D0F627AD)) {
    return;
  }
  player thread scripts\mp\hud_message::showsplash("br_large_gulag_got_key_self");
  player._id_A8FC9188D0F627AD = 1;
  level thread _id_64ACB6CE534155B7::utilflare_shootflare((57.6814, -29.0559, 450), "dom", 1);
  player _id_F5F03D651394FBBC();
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);

  if(isDefined(arena)) {
    foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
      if(_id_AC0E424AC96A7113 == player) {
        continue;
      }
      _id_AC0E424AC96A7113 thread scripts\mp\hud_message::showsplash("br_large_gulag_got_key_enemy");
    }
  }

  arena._id_45E35B44EC23AB43[arena._id_45E35B44EC23AB43.size] = instance.origin;
  instance freescriptable();
}

_id_55ADE1B0B40E05D5(arena) {
  foreach(_id_6F2D5AC61454FF66 in arena._id_D5BDB69EB6ECFB2F) {
    objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(objid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", _id_6F2D5AC61454FF66.origin + (0, 0, 60), "ui_mp_br_mapmenu_icon_x1_05_objective");
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);
    } else {}

    _id_6F2D5AC61454FF66.objid = objid;
  }
}

_id_F5F03D651394FBBC() {
  player = self;
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);
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

_id_E960DED6E9565058() {
  loadout = [];
  loadout["loadoutArchetype"] = "archetype_assault";

  if(level._id_43307855F189EB31._id_5466042078981FF3 == 0)
    loadout["loadoutPrimary"] = "iw9_me_fists";
  else if(level._id_43307855F189EB31._id_5466042078981FF3 == 1)
    loadout["loadoutPrimary"] = "iw9_ar_mike4_mp";
  else if(level._id_43307855F189EB31._id_5466042078981FF3 == 2)
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

_id_2715F6A1CA390F47(arena) {
  _id_3583FF375AB3A91E::_id_0DCEAD2B56FDBF3E("lost");

  if(isDefined(arena.objid))
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(arena.objid, self);
}

_id_DDDEEDEE8F02562C(arena) {
  player = self;
  player endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(player._id_32484CD3B17F16C8)) {
    return;
  }
  points = player._id_32484CD3B17F16C8;
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

_id_0A6B64FC536E1D37(agent, _id_6181DE250AFA5BB6) {
  if(!isPlayer(_id_6181DE250AFA5BB6)) {
    return;
  }
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(_id_6181DE250AFA5BB6);

  if(!isDefined(arena)) {
    return;
  }
  if(!isDefined(_id_6181DE250AFA5BB6._id_32484CD3B17F16C8))
    _id_6181DE250AFA5BB6._id_32484CD3B17F16C8 = 0;

  _id_6181DE250AFA5BB6._id_32484CD3B17F16C8 = _id_6181DE250AFA5BB6._id_32484CD3B17F16C8 + 1;
  _id_6181DE250AFA5BB6 playsoundtoplayer("mp_killconfirm_tags_pickup", _id_6181DE250AFA5BB6);
  _id_6181DE250AFA5BB6 _id_6CD1F6F8FBABF600(_id_6181DE250AFA5BB6._id_32484CD3B17F16C8);
}

_id_DD0E015C852A102E(attacker) {
  if(!isPlayer(attacker)) {
    return;
  }
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(attacker);

  if(!isDefined(arena)) {
    return;
  }
  if(!isDefined(attacker._id_32484CD3B17F16C8))
    attacker._id_32484CD3B17F16C8 = 0;

  attacker._id_32484CD3B17F16C8 = attacker._id_32484CD3B17F16C8 + 1;
  attacker playsoundtoplayer("mp_killconfirm_tags_pickup", attacker);
  attacker _id_6CD1F6F8FBABF600(attacker._id_32484CD3B17F16C8);

  if(isDefined(attacker._id_A8FC9188D0F627AD)) {
    return;
  }
  if(!istrue(level._id_43307855F189EB31._id_EC2EAA1A4B68C0CF)) {
    return;
  }
  attacker thread scripts\mp\hud_message::showsplash("br_large_gulag_got_key_self");
  attacker._id_A8FC9188D0F627AD = 1;
  level thread _id_64ACB6CE534155B7::utilflare_shootflare((57.6814, -29.0559, 450), "dom", 1);
  attacker _id_F5F03D651394FBBC();
  arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(attacker);

  if(isDefined(arena)) {
    foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
      if(_id_AC0E424AC96A7113 == attacker) {
        continue;
      }
      _id_AC0E424AC96A7113 thread scripts\mp\hud_message::showsplash("br_large_gulag_got_key_enemy");
    }
  }
}

_id_6CD1F6F8FBABF600(value) {
  player = self;
  player setclientomnvar("ui_br_ai_gulag_score", value);
}

_id_6C22791C62C18899() {
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

_id_9012D7DE49526F1A(player) {
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

_id_83FEEDA09E1A148E() {
  if(isDefined(level._id_C6877E979D75F191) && istrue(level._id_C6877E979D75F191._id_F443B3DC5E606CD3))
    return 1;

  return 0;
}

_id_438197F452ADC1F5(attacker, victim) {
  if(!_id_83FEEDA09E1A148E() || !isDefined(victim) || !isDefined(attacker))
    return 0;

  if(!istrue(level._id_43307855F189EB31._id_359208DF25B4333D))
    return 0;

  if(isPlayer(victim) && isPlayer(attacker)) {
    if(istrue(victim.gulag) && istrue(attacker.gulag))
      return 1;
  }

  return 0;
}

_id_0D06455FCF3EC9EB(arena) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");

  foreach(_id_6F2D5AC61454FF66 in arena._id_D5BDB69EB6ECFB2F)
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_6F2D5AC61454FF66.objid, player);

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
      player _id_67708F418B1FAC79::playergulagautowin("largeGulag", _id_F0EA4030349A33D5);
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

_id_DB6BA7931EB88793(arena) {
  if(!isDefined(arena._id_707537A8904AA962)) {
    arena._id_7B2D0FF4698FB2E9 = 1;

    if(isDefined(arena._id_79F102B3ABCC6F8A))
      thread _id_4D0570B3B6BEB2A8(arena);

    arena waittill("matchEnded");
    thread _id_D0E172A97595E5C7(arena);
  }
}

_id_F02D2C1DE50BB269(arena) {
  category = "gulag";
  _id_48814951E916AF89::_id_BA4022744DCE59F6(category);
}

_id_4D0570B3B6BEB2A8(arena) {
  if(_id_3583FF375AB3A91E::_id_D8F18F1D691C0EF8(arena))
    thread _id_5CDA031797DCE489::_id_89235E4FE5354B16(arena);
  else {
    foreach(_id_55E69FB0CE97F15E in arena._id_79F102B3ABCC6F8A)
    thread _id_E326A28E02C95FC7(arena, _id_55E69FB0CE97F15E);
  }
}

_id_E326A28E02C95FC7(arena, _id_55E69FB0CE97F15E) {
  aitype = "enemy_mp_smg_tier1_aq";
  _id_2AC210AF318CF38B = _id_55E69FB0CE97F15E.origin;

  if(!getdvarint("dvar_B3D7A9483362813E", 0))
    _id_2AC210AF318CF38B = getclosestpointonnavmesh(_id_55E69FB0CE97F15E.origin);

  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_2AC210AF318CF38B, _id_55E69FB0CE97F15E.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1);

  if(isagent(agent)) {
    agent thread _id_CC61194ECCD91AB1(arena);

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

_id_396DA1906C2BCCCA(arena) {
  if(!istrue(arena._id_7B2D0FF4698FB2E9))
    _id_DB6BA7931EB88793(arena);

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

_id_CC61194ECCD91AB1(arena) {
  if(!isDefined(arena._id_707537A8904AA962))
    arena._id_707537A8904AA962 = [];

  arena._id_707537A8904AA962 = scripts\engine\utility::array_add(arena._id_707537A8904AA962, self);
}

_id_C7D5C5080A52CEFB(arena) {
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

_id_D0E172A97595E5C7(arena) {
  if(isDefined(arena._id_707537A8904AA962)) {
    foreach(agent in arena._id_707537A8904AA962) {
      if(isagent(agent)) {
        agent _id_C7D5C5080A52CEFB(arena);
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