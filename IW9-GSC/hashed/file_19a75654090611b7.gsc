/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_19a75654090611b7.gsc
***********************************************/

_id_2A0A83F0371D3F6A() {
  if(!_id_2C3C990BA58FA6F5::_id_7B1DBD160221DB16())
    return 0;

  if(level.script == "mp_mummy_ruins_dev" || level.script == "mp_saba_pm")
    return 1;

  return 0;
}

_id_32A0F82DC7FEBEF9() {
  level._effect["vfx_hween_mummy_camera"] = loadfx("vfx/iw9/level/mp_saba/season6/hween/Mummy/vfx_hween__mummy_screenfx.vfx");
  level._effect["vfx_hween_mummy_playeraura"] = loadfx("vfx/iw9/level/mp_saba/season6/hween/Mummy/vfx_hween_mummy_playerwithskulls_aura.vfx");
  level._effect["vfx_hween_mummy_teleport"] = loadfx("vfx/iw9/gameplay/hween/vfx_hween_mummy_teleport.vfx");
}

_id_E06277CAEAA2935F(_id_AED74300DAF62896) {
  if(scripts\engine\utility::flag_exist("boss_mummy_init")) {
    return;
  }
  scripts\engine\utility::flag_init("boss_mummy_init");
  level._id_CFB2E3977FD1BF2C = getdvarint("dvar_88A6578EF1D28925", 5) * 1000;
  level._id_CB62AC3CFE2982D2 = 0;
  level._id_0F4974B18243877D = 0;
  level._id_A7DB5E2C3FC93037 = 0;
  _id_AED74300DAF62896._id_BFE291B401A9BF2A = [];

  if(!isDefined(level.struct_class_names) || !isDefined(level.struct_class_names["script_noteworthy"])) {
    return;
  }
  if(!isDefined(level.struct_class_names["script_noteworthy"]["boss_mummy"])) {
    return;
  }
  foreach(node in level.struct_class_names["script_noteworthy"]["boss_mummy"])
  _id_AED74300DAF62896._id_BFE291B401A9BF2A[_id_AED74300DAF62896._id_BFE291B401A9BF2A.size] = node;

  scripts\engine\scriptable::scriptable_addusedcallbackbypart("sarcophagus_deposit", ::_id_DAE467FC6E2B1A49);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("brloot_valuable_cursed_skull", ::_id_F6EE262568FF4622);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_B88E6ACE3E918449);
  level._id_796BCFECDCC6BDF8 = spawnStruct();
  level._id_796BCFECDCC6BDF8._id_9331B22CA6C15966 = 0;
  level._id_796BCFECDCC6BDF8._id_68623CDF221D38F5 = 0;
  level._id_796BCFECDCC6BDF8._id_1AE013F9F46FF5F4 = 0;
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_match_end", ::_id_A1B92CA3EFE65027);
}

_id_7AC416FB0F40517A() {
  level thread _id_5CEAA439E031DDB0();
}

_id_3812AF77D66F36F2() {
  level endon("game_ended");
  createthreatbiasgroup("mummy_enemies");

  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    _id_0B105E2A89476BD8::_id_FBFF191ACE79186C();
    _id_7AC416FB0F40517A();
  }
}

_id_007B6091AF439B3F(_id_58C817414D96DE59, _id_4DDD755385BF05CF) {
  aitype = "enemy_mp_boss_mummy";
  _id_E2958F412A7425C0 = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_58C817414D96DE59.origin, _id_58C817414D96DE59.angles, "absolute", "bosses", "mummyBoss", undefined, undefined, undefined, "bossArea", 0, 0, 0);

  if(!isDefined(_id_E2958F412A7425C0))
    logstring("Haunting - Mummy - Could not spawn the mummy.");
  else {
    _id_E2958F412A7425C0.disabledodge = 1;
    _id_E2958F412A7425C0._id_B3FA6C20CA52B960 = 0;
    _id_E2958F412A7425C0._id_CD251FBF5563EB4A = 0;
    _id_E2958F412A7425C0._id_F44C9CEDE4FB20D6 = 1;
    _id_E2958F412A7425C0.meleechargedistvsplayer = 125;
    _id_E2958F412A7425C0._id_384C9CC6CD2605D0 = 1;
    _id_E2958F412A7425C0.pathenemyfightdist = 0;
    _id_E2958F412A7425C0._id_65771500F49956C1 = 1;
    _id_E2958F412A7425C0._id_47BDE44B1ACEC603 = "mummy";
    level._id_8E3A5A3223D8DB16._id_47BDE44B1ACEC603 = "mummy";
    _id_E2958F412A7425C0._id_E0C57AF70D480252 = 1;
    _id_E2958F412A7425C0 _meth_4CA9518DC8BEF142("all", 0);
    _id_E2958F412A7425C0.meleestopattackdistsq = 14400;
    _id_E2958F412A7425C0.meleemaxzdiff = 150;
    _id_E2958F412A7425C0._id_8F438EA9E6AE83A2 = 14400;
    _id_E2958F412A7425C0.meleebashmaxdistsq = 14400;
    _id_E2958F412A7425C0.meleetryhard = 1;
    _id_E2958F412A7425C0.meleerangesq = 14400;
    _id_E2958F412A7425C0.meleetargetallowedoffmeshdistsq = 30625;
    _id_E2958F412A7425C0.meleeignorefinalzdiff = 1;
    _id_E2958F412A7425C0.meleeignoreplayerstance = 1;
    _id_E2958F412A7425C0._id_B582B10663B5B2A9 = 0;
    _id_E2958F412A7425C0.ignoreall = 1;
    _id_E2958F412A7425C0.dontevershoot = 1;
    _id_E2958F412A7425C0.invulnerable = 1;
    _id_E2958F412A7425C0.speedscalemult = 0;
    _id_E2958F412A7425C0.allowstrafe = 0;
    _id_E2958F412A7425C0._id_DF41B7F76F62D9A2 = 0;
    _id_E2958F412A7425C0._id_274D3A7704E351EF = 1;
    _id_E2958F412A7425C0._id_98E373D243C1936F = 1;
    _id_E2958F412A7425C0.stealth_enabled = 0;
    _id_E2958F412A7425C0.flashbangimmunity = 1;
    _id_E2958F412A7425C0._id_D242609E66DE99D9 = 1;
    _id_E2958F412A7425C0._id_0109D6AFBC11C5F9 = 2;
    _id_E2958F412A7425C0 thread _id_21EB2B7B46687BB1();
    _id_E2958F412A7425C0 thread _id_3A900BA398283227();
    _id_E2958F412A7425C0 thread _id_B819A91CB9C4CBF8();
    _id_E2958F412A7425C0 thread _id_51C916963695DFAD();
    _id_E2958F412A7425C0 hudoutlineenable("outline_depth_red");
    _id_E2958F412A7425C0 scripts\engine\utility::ent_flag_init("attack_players");
    _id_C22A996857C05960(_id_E2958F412A7425C0);
    _id_E2958F412A7425C0 thread _id_2FDEB8023287BE67::_id_49725DC1ABCC7B7E(getdvarint("dvar_D2E6D69C49732FE6", 3000));
    _id_E2958F412A7425C0._id_09584776529FB7F6 = "execution_boss_mummy_00";
    _id_E2958F412A7425C0 scripts\cp_mp\execution::_giveexecution(_id_E2958F412A7425C0._id_09584776529FB7F6);
    _id_E2958F412A7425C0._id_2D8D11A34BE5B244 = ::_id_5CF40BAE64553932;
    _id_E2958F412A7425C0._id_922C14FABBF684D5 = ::_id_AC35FCECF711E5DA;
    _id_E2958F412A7425C0._id_CDBC6EE27C5C2856 = ::_id_113CAF6420815BCF;
    _id_E2958F412A7425C0._id_A4738C70736D3A61 = ::_id_E9827038A2D4F418;
    _id_E2958F412A7425C0._id_AB96E6AE80B66789 = ::_id_0F17148B7FD53535;
  }
}

_id_C22A996857C05960(agent) {
  if(!isDefined(agent)) {
    return;
  }
  _id_A664AAD02EE98BD2 = "gas_mp";
  grenadeammo = getdvarint("dvar_537FA443CE212A8A", 12);
  weapon = undefined;
  armor = getdvarint("dvar_BCAE02FF3F51980E", 2000);

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    armor = getdvarint("dvar_99E203587EA8FA1D", 3300);
  else
    agent thread _id_1A0E875E639208C3();

  agent._id_0566BB878601192A = armor;
  _id_DF6AAF908406FC87 = int(armor * 0.3);
  agent scripts\mp\mp_agent::set_agent_health(_id_DF6AAF908406FC87);
  helmet = 40;
  agent._id_668B72F41E87C75A = 1;
  agent._id_EF3BFD0243258E2F = 1;
  agent._id_8FD71E47F0BFAFC4 = 1;
  agent._id_D38FB77455B25729 = 4000;
  agent._id_BA2F6374446E1525 = 0;
  agent._id_E6AF4BA7CF5CC852 = 0;
  agent._id_62482B4F67666074 = 10000;
  agent._id_A7AAE99DA4C9E990 = 60000;
  agent._id_2808079B46AE6650 = 3000;
  agent._id_7528BDD4F8EA8811 = 0;
  agent._id_0A83B580F45A7120 = 20000;
  agent._id_0D42CFFB8DAA15E0 = 1;
  agent.a.disablepain = 1;

  if(scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "zxp" || scripts\mp\utility\game::getsubgametype() == "resurgence")
    _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_plate_carrier_3_comms", undefined, undefined, 1);
  else
    _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_redeploy_token", undefined, undefined, 1);

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_valuable_bandage", undefined, undefined, 3);

  if(scripts\engine\utility::cointoss())
    _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_offhand_trophysystem", undefined, undefined, 1);
  else
    _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_offhand_heartbeatsensor", undefined, undefined, 100);

  _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_equip_gasmask", undefined, undefined, 108);
  _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_offhand_binoculars", undefined, undefined, 1);
  _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_self_revive", undefined, undefined, 1);
  _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_super_hauntedbox", undefined, undefined, 1);
  _id_C6774147D5DAB9EB = getdvarint("dvar_6F4F1AA656AD30DA", 3);
  _id_79FE733CDDEFC33D = getdvarint("dvar_79BA8D4D868A7179", 1);

  if(getdvarint("dvar_56801C94A3780DDE", 1) > 0)
    _id_C6774147D5DAB9EB = _id_C6774147D5DAB9EB - level._id_A7DB5E2C3FC93037;

  if(_id_C6774147D5DAB9EB < _id_79FE733CDDEFC33D)
    _id_C6774147D5DAB9EB = _id_79FE733CDDEFC33D;

  if(_id_C6774147D5DAB9EB > 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C6774147D5DAB9EB; _id_AC0E594AC96AA3A8++)
      _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_plunder_cash_legendary_1", undefined, undefined, 1500);
  }

  if(getdvarint("dvar_CF5A7B0483BAD648", 0) > 0)
    _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_valuable_cursed_skull", undefined, undefined, getdvarint("dvar_CF5A7B0483BAD648", 0));

  agent.baseaccuracy = getdvarfloat("dvar_298D4EA8B0934E31", 1.2);
  headmodel = undefined;
  bodymodel = undefined;
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(headmodel, bodymodel, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet, 1);
  agent _id_2FDEB8023287BE67::_id_720C3B7ABF4BAAC8("mummy", 0, undefined);
  agent _meth_8ABE5A968CC3C220("strapsgr");
  agent setclothtype("poncho");
  agent setthreatbiasgroup("mummy_enemies");
  setignoremegroup("Lethal_Static", "mummy_enemies");
}

_id_21EB2B7B46687BB1() {
  level endon("game_ended");
  self endon("death");

  while(!isDefined(self._id_0566868292EE2A1B) || !isDefined(self._id_0566868292EE2A1B._id_44E60D99B00BDED7))
    waitframe();

  _id_BCF9684C0529009A = self._id_0566868292EE2A1B._id_44E60D99B00BDED7.origin;
  _id_F20BC08C9FC211A0 = self._id_0566868292EE2A1B._id_44E60D99B00BDED7.angles + (0, 180, 0);
  self forceteleport(_id_BCF9684C0529009A, _id_F20BC08C9FC211A0);
  scripts\asm\asm_bb::bb_setanimScripted();
  self asmsetstate(self.asmname, "animscripted");
  self animmode("noclip");
  self dontinterpolate();
  self _meth_68A2305FCD0FE054();
  level waittill("bossMummyUnleashed");
  animindex = scripts\asm\asm::asm_lookupanimfromalias("animscripted", "mummy_exposed_stand_intro");
  xanim = scripts\asm\asm::asm_getxanim("animscripted", animindex);
  self aisetanim("animscripted", animindex);
  animlength = getanimlength(xanim);
  thread scripts\engine\utility::_id_AD9433AAB9FCDF04(0.15, "death", ::_meth_E7D001043BD5012C);
  thread _id_B9D4306B4408A6A0(11);
  self._id_DFEEC0C82A35EE8E = 1;
  wait(animlength);
  scripts\asm\asm_bb::bb_clearanimScripted();
  self._id_DFEEC0C82A35EE8E = 0;
}

_id_F552DC87B876280A(_id_58C817414D96DE59, _id_D5E8C424C0E9F6B6, _id_1AAF01E3E913A79F) {
  aitype = undefined;

  if(getdvarint("dvar_4D6D2C87B94AB285", 1) > 0)
    aitype = "enemy_mp_boss_mummy_minion";
  else
    aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("smg", 2);

  _id_3138C7EBA9B7AA1F = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_58C817414D96DE59.origin, _id_58C817414D96DE59.angles, "absolute", "bossMinions", "mummyBossMinion", undefined, undefined, undefined, "bossArea", 0, 0, 0);

  if(!isDefined(_id_3138C7EBA9B7AA1F)) {
    logstring("Haunting - Mummy - Could not spawn minion.");
    return undefined;
  }

  if(istrue(_id_1AAF01E3E913A79F)) {
    if(!isDefined(level._id_5CA02A174E3E79D0))
      level._id_5CA02A174E3E79D0 = [];

    level._id_5CA02A174E3E79D0[level._id_5CA02A174E3E79D0.size] = _id_3138C7EBA9B7AA1F;
  } else {
    if(!isDefined(level._id_55D0341F9A17FC94))
      level._id_55D0341F9A17FC94 = [];

    level._id_55D0341F9A17FC94[level._id_55D0341F9A17FC94.size] = _id_3138C7EBA9B7AA1F;
  }

  _id_3138C7EBA9B7AA1F._id_B582B10663B5B2A9 = 0;
  _id_D58537BF8D1FE9BF(_id_3138C7EBA9B7AA1F, _id_D5E8C424C0E9F6B6, _id_1AAF01E3E913A79F);
  _id_3138C7EBA9B7AA1F thread _id_120270BD0A747A35::_id_C7307D56A1A61172(_id_3138C7EBA9B7AA1F);
  return _id_3138C7EBA9B7AA1F;
}

_id_D58537BF8D1FE9BF(agent, _id_D5E8C424C0E9F6B6, _id_1AAF01E3E913A79F) {
  if(!isDefined(agent)) {
    return;
  }
  _id_A664AAD02EE98BD2 = "gas_mp";
  grenadeammo = getdvarint("dvar_537FA443CE212A8A", 12);
  weapon = undefined;
  armor = getdvarint("dvar_5E24AA0755510EC6", 100);
  helmet = 4;
  agent._id_668B72F41E87C75A = 1;

  if(level._id_0F4974B18243877D > 10) {
    _id_074087EF40D241B4 = scripts\engine\math::remap(level._id_0F4974B18243877D, 10, 50, 0.2, 0.9);
    _id_91E742B0FF6A5B12 = getdvarfloat("dvar_F6DB1DC0881837B3", 1);

    if(_id_074087EF40D241B4 * _id_91E742B0FF6A5B12 > randomfloat(1))
      _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropWeapon", 0);
  }

  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    armor = getdvarint("dvar_B569A220E403B405", 150);
    helmet = 6;
  }

  _id_12A03055ECE0D34F = randomint(100);

  if(_id_12A03055ECE0D34F < 20) {
    weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_sh_charlie725_mp", ["ammo_12g_db_charlie725", "none", "none", "none", "none", "none"], "none", "none");
    agent.guid = agent getentitynumber();
  } else if(_id_12A03055ECE0D34F < 40)
    weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_lm_rkilo_mp", ["laserbox_hip03", "none", "none", "none", "none", "none"], "none", "none");
  else if(_id_12A03055ECE0D34F < 45)
    agent thread _id_77C95318A822A7AA();
  else if(_id_12A03055ECE0D34F < 55)
    weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_sh_mike1014", ["lasercyl_hip04", "none", "none", "none", "none", "none"], "none", "none");

  agent._id_D38FB77455B25729 = 4000;
  agent._id_BA2F6374446E1525 = 0;
  agent._id_E6AF4BA7CF5CC852 = 0;
  agent._id_62482B4F67666074 = 10000;
  agent._id_A7AAE99DA4C9E990 = 60000;
  agent._id_2808079B46AE6650 = 3000;
  agent._id_7528BDD4F8EA8811 = 0;
  agent._id_0A83B580F45A7120 = 20000;
  level._id_0F4974B18243877D++;

  if(istrue(_id_D5E8C424C0E9F6B6)) {
    if(getdvarint("dvar_73C274ED64C71AAF", 1) == 1)
      agent setscriptablepartstate("headglow", "on_skull");

    level._id_CB62AC3CFE2982D2++;
    agent._id_D5E8C424C0E9F6B6 = 1;
    _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_valuable_cursed_skull", undefined, undefined, 1);
  } else if(getdvarint("dvar_73C274ED64C71AAF", 1) == 1)
    agent setscriptablepartstate("headglow", "on_noskull");

  _id_8B704F9A90D94040 = getdvarfloat("dvar_9E2EACFF44875722", 0.2);

  if(_id_8B704F9A90D94040 > 0 && randomfloat(1) < _id_8B704F9A90D94040)
    _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_armor_plate", undefined, undefined, 1);

  if(!istrue(_id_1AAF01E3E913A79F)) {
    agent.goalradius = 1500;
    agent.goalheight = 100;
  }

  agent.baseaccuracy = getdvarfloat("dvar_9DB33B273A1C1566", 1.1);
  bodymodel = undefined;
  headmodel = undefined;

  if(getdvarint("dvar_4D6D2C87B94AB285", 1) > 0) {
    bodymodel = undefined;
    headmodel = undefined;
  } else {
    bodymodel = "body_dmz_mummy_npc";
    headmodel = "head_dmz_mummy_npc";
  }

  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(bodymodel, headmodel, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet, 1);
  agent _meth_8ABE5A968CC3C220("milmedgr");
  agent setclothtype("vestheavy");
  agent setthreatbiasgroup("mummy_enemies");
}

_id_77C95318A822A7AA() {
  level endon("game_ended");
  self endon("death");

  if(getdvarint("dvar_3AB2F1577F017285", 1) <= 0) {
    return;
  }
  self.lastattackedtime = gettime();
  self._id_7528BDD4F8EA8811 = gettime();
  self._id_0A83B580F45A7120 = 10000;

  for(;;) {
    self waittill("damage", einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);

    if(!isPlayer(eattacker)) {
      continue;
    }
    _id_7D9345F67D35EFA7 = distance(self.origin, eattacker.origin);

    if(_id_7D9345F67D35EFA7 > 1000 || _id_7D9345F67D35EFA7 < 100) {
      continue;
    }
    if(scripts\engine\utility::time_has_passed(self._id_7528BDD4F8EA8811, self._id_0A83B580F45A7120 / 1000)) {
      self._id_7528BDD4F8EA8811 = gettime();
      wait 1;
      grenade = magicgrenademanual("smoke_grenade_mp", self.origin, (0, 0, -10), 0.1);
    }

    self.lastattackedtime = gettime();
  }
}

_id_9B11B1F57C0701B1() {
  level endon("game_ended");

  if(!isDefined(level._id_55D0341F9A17FC94))
    level._id_55D0341F9A17FC94 = [];

  if(!isDefined(level._id_5CA02A174E3E79D0))
    level._id_5CA02A174E3E79D0 = [];

  while(!isDefined(level._id_8E3A5A3223D8DB16) || !isDefined(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7))
    wait 0.1;

  for(;;) {
    level._id_55D0341F9A17FC94 = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_55D0341F9A17FC94);
    level childthread _id_7BC00A987B21C294();

    while(istrue(level._id_B72429FBCC9A3984))
      wait 1;

    _id_B4208787E6D21BD5 = scripts\mp\utility\player::getplayersinradius(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7.origin, 4000);
    _id_9B450DCF29974FED = scripts\engine\math::remap(_id_B4208787E6D21BD5.size, 1, 5, 45, 30);
    wait(randomfloat(3));

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < int(_id_9B450DCF29974FED); _id_AC0E594AC96AA3A8++) {
      wait 1;
      level._id_55D0341F9A17FC94 = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_55D0341F9A17FC94);

      if(level._id_55D0341F9A17FC94.size <= 1) {
        _id_4046BF37E49E7A5C = _id_9B450DCF29974FED - _id_AC0E594AC96AA3A8;
        _id_4046BF37E49E7A5C = min(5, _id_4046BF37E49E7A5C);
        wait(_id_4046BF37E49E7A5C);
        _id_AC0E594AC96AA3A8 = int(_id_9B450DCF29974FED + 99);
      }
    }

    level childthread _id_415CB4433E5618D5();
  }
}

_id_7BC00A987B21C294() {
  if(istrue(level._id_7252495AD129237D)) {
    return;
  }
  level._id_7252495AD129237D = 1;
  wait 10;
  level childthread _id_415CB4433E5618D5(undefined, 1);
}

_id_415CB4433E5618D5(_id_B8563082CE5DB34A, _id_B063BC07F91C62C2, _id_5AF5EDB5F6F9028B, _id_04B3C44CE4DA6624) {
  if(getdvarint("dvar_18098F734DA82295", -1) > 0) {
    return;
  }
  spawnpoints = level._id_8E3A5A3223D8DB16.nodes["boss_mummy_minion"];

  if(istrue(_id_B063BC07F91C62C2))
    spawnpoints = level._id_8E3A5A3223D8DB16.nodes["boss_mummy_minion_outside"];

  if(istrue(level._id_B72429FBCC9A3984))
    spawnpoints = scripts\engine\utility::array_combine(level._id_8E3A5A3223D8DB16.nodes["boss_mummy_minion_anger"], spawnpoints);

  if(isDefined(_id_B8563082CE5DB34A))
    spawnpoints = sortbydistance(spawnpoints, _id_B8563082CE5DB34A);
  else {
    spawnpoints = scripts\engine\utility::array_randomize(spawnpoints);
    _id_B5F7B6A6852C98B8 = spawnpoints[0].origin;
    spawnpoints = sortbydistance(spawnpoints, _id_B5F7B6A6852C98B8);
  }

  _id_B4208787E6D21BD5 = scripts\mp\utility\player::getplayersinradius(spawnpoints[0].origin, 4000);
  _id_E637C1556B37C075 = 200;
  _id_2DC459931CAE6F04 = 6;
  _id_997ECEECC13D853A = 3;

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    _id_997ECEECC13D853A = 2;

  if(istrue(level._id_B72429FBCC9A3984)) {
    _id_E637C1556B37C075 = 40;
    _id_997ECEECC13D853A = 0;
    _id_2DC459931CAE6F04 = getdvarint("dvar_AF666BE8951334C7", 3);
  }

  if(istrue(_id_B063BC07F91C62C2)) {
    _id_997ECEECC13D853A = 0;
    _id_2DC459931CAE6F04 = 5;
  }

  if(isDefined(_id_5AF5EDB5F6F9028B) && _id_2DC459931CAE6F04 < _id_5AF5EDB5F6F9028B)
    _id_2DC459931CAE6F04 = _id_5AF5EDB5F6F9028B;

  level._id_55D0341F9A17FC94 = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_55D0341F9A17FC94);
  level._id_5CA02A174E3E79D0 = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_5CA02A174E3E79D0);

  if(level._id_55D0341F9A17FC94.size > 0) {
    _id_64630F9DC8F4F927 = 0;

    foreach(_id_0BF97D9914F15362 in level._id_55D0341F9A17FC94) {
      if(istrue(_id_0BF97D9914F15362._id_D5E8C424C0E9F6B6))
        _id_64630F9DC8F4F927++;
    }

    _id_997ECEECC13D853A = _id_997ECEECC13D853A - _id_64630F9DC8F4F927;
    _id_997ECEECC13D853A = int(clamp(_id_997ECEECC13D853A, 0, 10));

    if(level._id_CB62AC3CFE2982D2 > 15) {
      if(_id_997ECEECC13D853A > 1)
        _id_997ECEECC13D853A = 1;
    }
  }

  _id_31A6216FBF7E8CC3 = _id_2DC459931CAE6F04 - level._id_55D0341F9A17FC94.size;

  if(isDefined(_id_5AF5EDB5F6F9028B) && _id_31A6216FBF7E8CC3 < _id_5AF5EDB5F6F9028B) {
    _id_1DCCE4A808038E37 = 0;
    _id_C0F516E77EE2FEB1 = undefined;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5AF5EDB5F6F9028B; _id_AC0E594AC96AA3A8++) {
      _id_2BB43EDA76DCFCF4 = _id_2AE0E6EAB15F8840(_id_C0F516E77EE2FEB1);

      if(isDefined(_id_2BB43EDA76DCFCF4)) {
        if(!isDefined(_id_2BB43EDA76DCFCF4._id_1C9CB43BCF3EB16D))
          _id_2BB43EDA76DCFCF4._id_1C9CB43BCF3EB16D = "EganMummyMinion";

        level thread _id_51D9E5AEF85D751A(_id_2BB43EDA76DCFCF4.origin, anglesToForward(_id_2BB43EDA76DCFCF4.angles), "out");
        _id_2BB43EDA76DCFCF4 _id_48814951E916AF89::_id_28B90EB2B591003F();

        if(isDefined(_id_04B3C44CE4DA6624) && !isDefined(_id_C0F516E77EE2FEB1))
          _id_C0F516E77EE2FEB1 = _id_04B3C44CE4DA6624;

        _id_1DCCE4A808038E37++;
      }
    }

    if(_id_1DCCE4A808038E37 > 0) {
      level._id_55D0341F9A17FC94 = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_55D0341F9A17FC94);
      _id_31A6216FBF7E8CC3 = _id_2DC459931CAE6F04 - level._id_55D0341F9A17FC94.size;
    }
  }

  _id_131AB14471FB6476 = 0;
  _id_29A452EA171181FF = 0;

  foreach(node in spawnpoints) {
    if(isDefined(level._id_8E3A5A3223D8DB16) && isDefined(level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0) && istrue(level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0._id_DFEEC0C82A35EE8E)) {
      continue;
    }
    if(_id_131AB14471FB6476 < _id_31A6216FBF7E8CC3) {
      _id_78122E18403A8DC4 = scripts\mp\utility\player::getplayersinradius(node.origin, _id_E637C1556B37C075);

      if(_id_78122E18403A8DC4.size == 0) {
        _id_131AB14471FB6476++;
        _id_5E5A686D9C95C7C1 = 0;

        if(_id_29A452EA171181FF < _id_997ECEECC13D853A) {
          _id_5E5A686D9C95C7C1 = 1;
          _id_29A452EA171181FF++;
        }

        _id_3138C7EBA9B7AA1F = _id_F552DC87B876280A(node, _id_5E5A686D9C95C7C1, _id_B063BC07F91C62C2);

        if(!isDefined(_id_3138C7EBA9B7AA1F)) {
          continue;
        }
        _id_3138C7EBA9B7AA1F thread _id_BF43621AD477B84A();

        foreach(player in _id_B4208787E6D21BD5) {
          if(isDefined(player) && isPlayer(player))
            _id_3138C7EBA9B7AA1F getenemyinfo(player);
        }

        _id_D125F02BB2FFDAD1 = scripts\mp\utility\player::getplayersinradius(_id_3138C7EBA9B7AA1F.origin, 2000);

        if(_id_D125F02BB2FFDAD1.size > 0) {
          if(isDefined(_id_B8563082CE5DB34A)) {
            closestplayer = scripts\engine\utility::getclosest(_id_3138C7EBA9B7AA1F.origin, _id_D125F02BB2FFDAD1);
            _id_3138C7EBA9B7AA1F aieventlistenerevent("combat", closestplayer, closestplayer.origin);
            _id_3138C7EBA9B7AA1F.baseaccuracy = getdvarfloat("dvar_D20FE71E4ADB547B", 0.6);
          } else {
            closestplayer = scripts\engine\utility::getclosest(_id_3138C7EBA9B7AA1F.origin, _id_D125F02BB2FFDAD1);

            if(isDefined(closestplayer) && distance(_id_3138C7EBA9B7AA1F.origin, closestplayer.origin) < 750) {
              _id_3138C7EBA9B7AA1F aieventlistenerevent("combat", closestplayer, closestplayer.origin);
              _id_3138C7EBA9B7AA1F.baseaccuracy = getdvarfloat("dvar_D20FE71E4ADB547B", 0.6);
            } else
              _id_3138C7EBA9B7AA1F aieventlistenerevent("investigate", closestplayer, closestplayer.origin);
          }
        }

        wait(0.25 + randomfloat(1));
      }
    }
  }
}

_id_BF43621AD477B84A() {
  level endon("game_ended");
  self endon("death");
  _id_010B6724C15A95E8::_id_C434AF0895CC147C("cap_play_once", "caps/common/cap_play_spawn_mummy_minion");
  self waittill("cap_exit_completed");
}

_id_2AE0E6EAB15F8840(_id_CB057CCF6279533F) {
  if(level._id_55D0341F9A17FC94.size == 0)
    return undefined;

  _id_14F2E41BC5CED509 = 0;
  _id_FCE62685F22FE63A = undefined;

  foreach(_id_3138C7EBA9B7AA1F in level._id_55D0341F9A17FC94) {
    closestplayer = scripts\engine\utility::getclosest(_id_3138C7EBA9B7AA1F.origin, level.players);
    _id_DF8E0358F6E2B842 = distance(closestplayer.origin, _id_3138C7EBA9B7AA1F.origin);

    if(_id_DF8E0358F6E2B842 > _id_14F2E41BC5CED509) {
      _id_14F2E41BC5CED509 = _id_DF8E0358F6E2B842;
      _id_FCE62685F22FE63A = _id_3138C7EBA9B7AA1F;
    }
  }

  if(isDefined(_id_CB057CCF6279533F) && _id_14F2E41BC5CED509 < _id_CB057CCF6279533F)
    return undefined;

  return _id_FCE62685F22FE63A;
}

_id_B4EB8DB27CDE1A41(_id_CB057CCF6279533F) {
  if(level._id_55D0341F9A17FC94.size == 0)
    return [];

  if(!isDefined(_id_CB057CCF6279533F))
    _id_CB057CCF6279533F = 2000;

  _id_C8DADD43AEFDC396 = [];

  foreach(_id_3138C7EBA9B7AA1F in level._id_55D0341F9A17FC94) {
    _id_DF8E0358F6E2B842 = distance(self.origin, _id_3138C7EBA9B7AA1F.origin);

    if(_id_DF8E0358F6E2B842 <= _id_CB057CCF6279533F)
      _id_C8DADD43AEFDC396[_id_C8DADD43AEFDC396.size] = _id_3138C7EBA9B7AA1F;
  }

  return _id_C8DADD43AEFDC396;
}

_id_2EBE59253158B359(_id_CB057CCF6279533F) {
  if(!isDefined(_id_CB057CCF6279533F))
    _id_CB057CCF6279533F = 2000;

  _id_52939F406A24ED5F = _id_B4EB8DB27CDE1A41(_id_CB057CCF6279533F);
  _id_B4208787E6D21BD5 = scripts\mp\utility\player::getplayersinradius(self.origin, _id_CB057CCF6279533F, undefined, self);
  _id_9227291F6953C03F = [];

  foreach(guy in _id_B4208787E6D21BD5) {
    if(!scripts\mp\utility\player::isfriendly(self.team, guy))
      _id_9227291F6953C03F[_id_9227291F6953C03F.size] = guy;
  }

  total = _id_52939F406A24ED5F.size + _id_9227291F6953C03F.size;
  return total;
}

_id_0B97865A82331EF9() {
  if(getdvarint("dvar_79F5A05DE3D1339F", 1) <= 0) {
    return;
  }
  level._id_55D0341F9A17FC94 = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_55D0341F9A17FC94);
  level._id_5CA02A174E3E79D0 = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_5CA02A174E3E79D0);

  foreach(_id_3138C7EBA9B7AA1F in level._id_55D0341F9A17FC94) {
    level thread _id_51D9E5AEF85D751A(_id_3138C7EBA9B7AA1F.origin, anglesToForward(_id_3138C7EBA9B7AA1F.angles), "minion_out");
    _id_3138C7EBA9B7AA1F._id_F543095C3CA1B743 = 1;
    _id_3138C7EBA9B7AA1F _id_48814951E916AF89::_id_28B90EB2B591003F();
  }

  foreach(_id_3138C7EBA9B7AA1F in level._id_5CA02A174E3E79D0) {
    level thread _id_51D9E5AEF85D751A(_id_3138C7EBA9B7AA1F.origin, anglesToForward(_id_3138C7EBA9B7AA1F.angles), "minion_out");
    _id_3138C7EBA9B7AA1F._id_F543095C3CA1B743 = 1;
    _id_3138C7EBA9B7AA1F _id_48814951E916AF89::_id_28B90EB2B591003F();
  }
}

_id_4C61CE86C1FF681B() {
  _id_97C62B25C8EA4A25 = _id_62C45C3D85F95EA5::_id_043AB23D816E98F8();

  if(_id_97C62B25C8EA4A25.size > 0 && _id_97C62B25C8EA4A25.size >= getdvarint("dvar_74E1D62FCE88A3F6", 60))
    _id_0B97865A82331EF9();
}

_id_C92850CF4B5DC781() {
  level endon("game_ended");
  self endon("death");
  wait 3.5;
  _id_9A3A8A9AC332188D = 2;
  _id_03C5EACA58C27809 = 0;

  if(getdvarint("dvar_2AE46F78C9E5E48A", -1) > 0)
    _id_9A3A8A9AC332188D = getdvarint("dvar_2AE46F78C9E5E48A", -1);

  for(;;) {
    childthread _id_B9D4306B4408A6A0(10);
    childthread _id_E0FD8EE0853F21A2(_id_03C5EACA58C27809);
    wait 0.5;

    if(_id_03C5EACA58C27809 == 2) {
      thread _id_DD1761BBAF4B281B();
      wait 2;
    }

    while(istrue(self._id_2EEE30ED130E9D4A) || self isinexecutionattack() || self isonladder())
      wait 0.5;

    thread _id_2B7B5D5374BD7E72();
    wait 1;
    _id_FC617751F654A141 = 3;

    if(_id_03C5EACA58C27809 == 1) {
      _id_FC617751F654A141 = 3;

      if(_id_2CFB88AF9245875C() < 300) {
        _id_FC617751F654A141 = 6;
        grenade = magicgrenademanual("smoke_grenade_mp", self.origin, (0, 0, -10), 4);
      }
    } else if(_id_03C5EACA58C27809 == 2) {
      _id_FC617751F654A141 = 3;

      if(_id_2CFB88AF9245875C() < 300) {
        _id_FC617751F654A141 = 9;
        grenade = magicgrenademanual("smoke_grenade_mp", self.origin, (0, 0, -10), 4);
      }
    }

    level childthread _id_415CB4433E5618D5(self.origin, undefined, _id_FC617751F654A141, 1000);
    wait 5;
    childthread _id_6F426C44C586F562(_id_03C5EACA58C27809);

    if(_id_03C5EACA58C27809 >= _id_9A3A8A9AC332188D) {
      return;
    }
    _id_03C5EACA58C27809++;

    while(self.armorhealth > 400 && self.helmethealth > 5 && self.health > 150)
      wait 0.05;
  }
}

_id_B9D4306B4408A6A0(time) {
  self endon("death");
  self._id_ECAD872D8C836432 = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < int(time * 2); _id_AC0E594AC96AA3A8++) {
    self.armorhealth = self._id_8790C077C95DB752;
    self.helmethealth = self._id_CFC69E5588A5BED6;
    self.health = self.maxhealth;
    wait 0.5;
  }

  self._id_ECAD872D8C836432 = 0;
}

_id_2B7B5D5374BD7E72() {
  level endon("game_ended");
  self endon("death");
  childthread _id_013FDB11574FCE3B();
  self._id_2EEE30ED130E9D4A = 1;
  scripts\asm\asm_bb::bb_setanimScripted();
  self asmsetstate(self.asmname, "animscripted");
  self animmode("noclip");
  self dontinterpolate();
  animindex = scripts\asm\asm::asm_lookupanimfromalias("animscripted", "mummy_exposed_stand_summon");
  xanim = scripts\asm\asm::asm_getxanim("animscripted", animindex);
  self aisetanim("animscripted", animindex);
  animlength = getanimlength(xanim);
  wait(animlength);
  self._id_2EEE30ED130E9D4A = undefined;
  scripts\asm\asm_bb::bb_clearanimScripted();
}

_id_0F17148B7FD53535(attacker, objweapon, smeansofdeath, _id_24DF708F286B0562, _id_BE4285B26ED99AB1) {
  maxdamage = 2700;

  if(isDefined(self._id_0566BB878601192A))
    maxdamage = self._id_0566BB878601192A - 300;

  if(_id_24DF708F286B0562 > maxdamage)
    _id_24DF708F286B0562 = maxdamage;

  return _id_24DF708F286B0562;
}

_id_E9827038A2D4F418(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(istrue(self._id_DFEEC0C82A35EE8E))
    idamage = 0;

  if(istrue(level._id_B72429FBCC9A3984)) {
    _id_86BD371AF21EF2E7 = undefined;

    if(isDefined(eattacker)) {
      if(isPlayer(eattacker)) {
        _id_171F90B9C4C76D44 = "stat_22A0E850ADD468A3";

        if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
          _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(eattacker.origin, 1);

        eattacker thread _id_2FDEB8023287BE67::_id_9483543F1B1BFA73("mummy", _id_171F90B9C4C76D44, eattacker, self, 2500);
        _id_86BD371AF21EF2E7 = eattacker;
      } else if(isDefined(eattacker.owner) && isPlayer(eattacker.owner))
        _id_86BD371AF21EF2E7 = eattacker.owner;
    }

    if(!scripts\engine\utility::ent_flag("attack_players"))
      scripts\engine\utility::ent_flag_set("attack_players");

    thread _id_909A57E6CC25842F();
  }

  self.lastattackedtime = gettime();

  if(!isDefined(_id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "haunting_attackers")))
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(self, "haunting_attackers", spawnStruct());

  if(isDefined(eattacker) && isPlayer(eattacker)) {
    self._id_9E8FCAC6728AA14F = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "haunting_attackers");

    if(!isDefined(self._id_9E8FCAC6728AA14F.attackers))
      self._id_9E8FCAC6728AA14F.attackers = [];

    if(!isDefined(self._id_9E8FCAC6728AA14F.attackers[eattacker.guid]))
      self._id_9E8FCAC6728AA14F.attackers[eattacker.guid] = [eattacker, 0];

    [_, _id_535FD96FD1B3C9BC] = self._id_9E8FCAC6728AA14F.attackers[eattacker.guid];
    self._id_9E8FCAC6728AA14F.attackers[eattacker.guid] = [eattacker, _id_535FD96FD1B3C9BC + idamage];
  }

  if(isDefined(einflictor) && isDefined(einflictor.vehicle) && istrue(einflictor.vehicle._id_11CE4D3D11BDECFC)) {
    if(getdvarint("dvar_3ABBBD7843CEB4BB", 0) == 0) {
      idamage = max(int(idamage * 0.05), 1);
      thread _id_B9D4306B4408A6A0(1);
    }
  }

  self.lastattackedtime = gettime();

  if(istrue(self._id_ECAD872D8C836432))
    idamage = max(int(idamage * 0.05), 1);

  _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0(einflictor, eattacker, int(idamage), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

_id_4CE03E1B24D54E21(playerlist) {
  if(isDefined(playerlist)) {
    foreach(_id_F90358454413407F in playerlist) {
      if(isPlayer(_id_F90358454413407F[0]) && _id_F90358454413407F[1] >= 1)
        scripts\cp_mp\challenges::_id_8359CADD253F9604(_id_F90358454413407F[0], "mummy_killed", 1, 0);
    }
  }
}

_id_3E6EDBD5ABAB0149(delay) {
  level endon("game_ended");
  self endon("death");

  if(isDefined(delay))
    wait(delay);

  _id_636C8575D7A7768B = 40;
  _id_4F0FC1C36324AFFB = squared(_id_636C8575D7A7768B);

  for(;;) {
    wait 1;

    if(!isDefined(level.mines)) {
      continue;
    }
    foreach(mine in level.mines) {
      if(!isDefined(mine.equipmentref) || mine.equipmentref != "equip_tac_cover") {
        continue;
      }
      if(distancesquared(self.origin, mine.origin) > _id_4F0FC1C36324AFFB) {
        continue;
      }
      mine[[mine.deletefunc]](0, 1, 1);
    }
  }
}

_id_3A900BA398283227() {
  level endon("game_ended");
  self waittill("death");
  level notify("boss_mummy_death");
  logstring("Haunting - Mummy - Killed");

  if(istrue(level._id_7375DA301EBCC5DB)) {
    return;
  }
  _id_9DC2394FEE4A29EA = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "haunting_attackers");

  if(isDefined(_id_9DC2394FEE4A29EA))
    _id_4CE03E1B24D54E21(_id_9DC2394FEE4A29EA.attackers);

  _id_8023E5A651CAD543();
  level thread _id_E9CD2BDE89D8E12E();
  level thread _id_2FDEB8023287BE67::_id_3E409004EDF37731("mummy");
  _id_DCC6762423F2D127 = getdvarint("dvar_EBDB616D19A29BFC", 8000);
  level thread _id_62C45C3D85F95EA5::_id_F36EC32AC1889838(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7.origin, _id_DCC6762423F2D127, ::_id_F00C43299C6F9BF2, undefined, undefined, undefined, "expandMummy");
}

_id_B819A91CB9C4CBF8() {
  level endon("game_ended");
  self endon("death");

  while(!isDefined(level._id_8E3A5A3223D8DB16) || !isDefined(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7))
    wait 0.1;

  for(;;) {
    if(scripts\engine\utility::ent_flag("attack_players")) {
      wait 5;
      break;
    }

    wait 0.5;
  }

  maxdist = getdvarint("dvar_9C4F5B08C23C6C7D", 1900);
  _id_CDC5DD6C28C9709D = squared(maxdist);
  maxzdiff = getdvarint("dvar_A57FCC1971CC4E59", 350);
  _id_D736562B3486A9CD = level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7.origin + (736, -1072, 0);

  for(;;) {
    while(self isinexecutionattack() || istrue(self._id_2EEE30ED130E9D4A))
      wait 0.5;

    _id_E6CCD363DDA80C4D = distancesquared(self.origin, _id_D736562B3486A9CD);
    _id_C2024D4AFBC8916D = self.origin - _id_D736562B3486A9CD;
    _id_276BDCF8674211AA(_id_E6CCD363DDA80C4D);

    if(_id_E6CCD363DDA80C4D > _id_CDC5DD6C28C9709D || abs(_id_C2024D4AFBC8916D[2]) > maxzdiff) {
      position = self.origin;
      level thread _id_51D9E5AEF85D751A(position, anglesToForward(self.angles), "out");
      _id_3E1F718EE5C9DEB7 = getclosestpointonnavmesh(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7.origin);
      self setOrigin(_id_3E1F718EE5C9DEB7);
      level thread _id_51D9E5AEF85D751A(_id_3E1F718EE5C9DEB7, anglesToForward(self.angles), "in");
      childthread _id_F1113C85AD9397B6(position);
      childthread _id_B9D4306B4408A6A0(1);
      level childthread _id_415CB4433E5618D5(position, undefined, 1, 1000);
      self notify("teleportedToSarcophagus");
    }

    wait 1;
  }
}

_id_F1113C85AD9397B6(position) {
  if(isDefined(level._id_1CDC49D6FD0BD5A5) && !scripts\engine\utility::time_has_passed(level._id_1CDC49D6FD0BD5A5, 7))
    wait 8;

  players = scripts\mp\utility\player::getplayersinradius(position, 3000);

  foreach(player in players) {
    if(player _id_C8DE71E5D197129B())
      player thread _id_BC0D82B7B41B3853("ingame_haunting_mummy_2s", 2, "dx_br_saba_actn_mumy_evll");
  }
}

_id_51D9E5AEF85D751A(origin, angles, type) {
  level endon("game_ended");

  if(!isDefined(angles))
    angles = (0, 0, 0);

  if(!isDefined(type))
    type = "out";

  scriptable = spawnscriptable("dmz_boss_mummy_teleport", origin, angles);
  scriptable setscriptablepartstate("teleport", type);
  wait 10;
  scriptable freescriptable();
}

_id_9AEFE0A164B4F0EB() {
  level endon("game_ended");
  level endon("boss_mummy_death");

  if(getdvarint("dvar_4C85564F0DE62F04", 1) <= 0) {
    return;
  }
  while(!isDefined(level._id_8E3A5A3223D8DB16) || !isDefined(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7))
    wait 0.1;

  while(!scripts\mp\flags::gameflag("prematch_done"))
    waitframe();

  scripts\mp\gamelogic::waitforplayers(level.prematchperiod, 0, 0);
  wait 5;

  for(;;) {
    _id_D736562B3486A9CD = level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7.origin;
    players = scripts\mp\utility\player::getplayersinradius(_id_D736562B3486A9CD, 3800);

    foreach(player in players) {
      if(!isalive(player)) {
        continue;
      }
      if(istrue(player._id_0DA252EFCCF72E16)) {
        continue;
      }
      if(player _id_C8DE71E5D197129B()) {
        player thread _id_BC0D82B7B41B3853("ingame_haunting_mummy_6s", 6, "dx_br_saba_prsp_mumy_bringtheskullstomeun");
        player._id_0DA252EFCCF72E16 = 1;
        thread _id_1B2D094202B481D5(player);
      }
    }

    wait 1;
  }
}

_id_1B2D094202B481D5(player) {
  player endon("disconnect");
  player.nosuspensemusic = 1;
  wait 6.5;

  if(isDefined(player)) {
    if(istrue(level._id_B72429FBCC9A3984))
      setmusicstate("mx_dmz_boss_mummy_combat");
    else
      setmusicstate("mx_dmz_boss_mummy_approach");
  }
}

_id_276BDCF8674211AA(_id_C8F753EC884934CC) {
  _id_5894921C3039C1B5 = getdvarint("dvar_5E355F48623471E6", -1);

  if(_id_5894921C3039C1B5 <= 0) {
    return;
  }
  if(_id_C8F753EC884934CC < _id_5894921C3039C1B5)
    self._id_F44C9CEDE4FB20D6 = 0;
  else
    self._id_F44C9CEDE4FB20D6 = 1;
}

_id_181594EEDDF88943() {
  level endon("game_ended");

  while(!isDefined(level._id_8E3A5A3223D8DB16) || !isDefined(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7))
    wait 0.1;

  minplayerdist = 64;
  _id_C44409CE5F850362 = squared(minplayerdist);
  cooldown = 1;

  for(;;) {
    wait 1;

    if(!isDefined(level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0) || !isalive(level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0)) {
      continue;
    }
    if(!istrue(level._id_B72429FBCC9A3984)) {
      continue;
    }
    foreach(position in level._id_8E3A5A3223D8DB16.nodes["boss_mummy_pushspot"]) {
      if(!isDefined(level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0) || !isalive(level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0)) {
        continue;
      }
      nearbyplayer = scripts\engine\utility::getclosest(position.origin, level.players, minplayerdist);

      if(!isDefined(nearbyplayer)) {
        continue;
      }
      nearbyplayer setvelocity((0, 300, 50));
      wait(cooldown);
    }
  }
}

_id_1A8419AF11082DB9() {
  level endon("game_ended");

  while(!isDefined(level._id_8E3A5A3223D8DB16) || !isDefined(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7))
    wait 0.1;

  if(getdvarint("dvar_600D5CA936233C76", 0) >= 1) {
    return;
  }
  _id_75C9D0AC1F8A998E = 170;
  _id_75C1491951DF7562 = squared(_id_75C9D0AC1F8A998E);
  minplayerdist = 70;
  _id_C44409CE5F850362 = squared(minplayerdist);
  cooldown = getdvarint("dvar_ECFC08E6BA7939D7", 15);
  _id_397DBA74481A3048 = 0;

  for(;;) {
    wait 1;

    if(!isDefined(level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0) || !isalive(level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0)) {
      continue;
    }
    if(!istrue(level._id_B72429FBCC9A3984)) {
      continue;
    }
    if(!level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0 scripts\engine\utility::ent_flag("attack_players")) {
      continue;
    }
    foreach(position in level._id_8E3A5A3223D8DB16.nodes["boss_mummy_stuckspot"]) {
      if(!isDefined(level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0) || !isalive(level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0)) {
        continue;
      }
      if(distancesquared(position.origin, level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0.origin) > _id_75C1491951DF7562) {
        continue;
      }
      nearbyplayer = scripts\engine\utility::getclosest(position.origin, level.players, minplayerdist);

      if(!isDefined(nearbyplayer)) {
        continue;
      }
      level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0 _id_172B5C0A88F3535F(nearbyplayer, _id_397DBA74481A3048);
      _id_397DBA74481A3048++;
      wait(cooldown);
    }
  }
}

_id_172B5C0A88F3535F(nearbyplayer, _id_397DBA74481A3048) {
  self endon("death");

  while(istrue(self._id_2EEE30ED130E9D4A) || self isinexecutionattack() || self isonladder())
    wait 0.5;

  thread _id_2B7B5D5374BD7E72();
  wait 1;
  _id_FC617751F654A141 = 2;

  if(_id_397DBA74481A3048 >= 3)
    _id_FC617751F654A141 = 3;

  level childthread _id_415CB4433E5618D5(self.origin, undefined, _id_FC617751F654A141, 1500);

  if(getdvarint("dvar_218327B19D55E425", 0) >= 1) {
    return;
  }
  inflictor = spawnStruct();
  inflictor.origin = self.origin;
  inflictor._id_D442547D75DFFD09 = spawnStruct();
  inflictor._id_D442547D75DFFD09._id_F2FB099C7B7B0A1F = 4.5;
  inflictor._id_D442547D75DFFD09._id_C5A6A953A99CEA74 = 4.5;
  nearbyplayer thread scripts\mp\equipment\concussion_grenade::applyconcussion(inflictor, self);
}

_id_1B6724A39793F0D8() {
  self endon("death");

  for(;;) {
    if(isDefined(self.lastattackedtime)) {
      if(gettime() - self.lastattackedtime > self._id_2808079B46AE6650 && gettime() - self._id_7528BDD4F8EA8811 > self._id_0A83B580F45A7120) {
        self._id_7528BDD4F8EA8811 = gettime();
        players = scripts\mp\utility\player::getplayersinradius(self.origin, 1000);
        self.lastattackedtime = undefined;
      }
    }

    wait 0.1;
  }
}

_id_E25174A752B40CF8(icon) {
  self endon("death");

  for(;;) {
    waitframe();
    icon scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(self.origin);
    icon.origin = self.origin;
  }
}

_id_5CEAA439E031DDB0() {
  level endon("game_ended");

  if(!isDefined(level._id_6A4C9FBD7AA58544) || !isDefined(level._id_6A4C9FBD7AA58544["mummy"]) || !isDefined(level._id_6A4C9FBD7AA58544["mummy"]._id_BFE291B401A9BF2A)) {
    return;
  }
  _id_0BAA08EA813E9752 = _id_2FDEB8023287BE67::_id_3BCF85FF011D31F8("mummy");

  if(!isDefined(_id_0BAA08EA813E9752)) {
    return;
  }
  _id_A942AE9112CD6BDE = scripts\engine\utility::getStructArray(_id_0BAA08EA813E9752.target, "targetname");
  _id_1435F6F97C873063 = 0;

  if(scripts\mp\utility\game::getsubgametype() != "dmz")
    _id_58C817414D96DE59 = _id_2636152C566D6C64::_id_2E6E2B664DFE3186("mummy", _id_1435F6F97C873063);
  else
    _id_58C817414D96DE59 = _id_2FDEB8023287BE67::_id_2E6E2B664DFE3186("mummy", _id_1435F6F97C873063);

  level._id_8E3A5A3223D8DB16 = _id_58C817414D96DE59;
  _id_58C817414D96DE59.nodes = [];

  foreach(node in _id_A942AE9112CD6BDE) {
    if(isDefined(node.script_noteworthy)) {
      if(!isDefined(_id_58C817414D96DE59.nodes[node.script_noteworthy]))
        _id_58C817414D96DE59.nodes[node.script_noteworthy] = [];

      _id_58C817414D96DE59.nodes[node.script_noteworthy][_id_58C817414D96DE59.nodes[node.script_noteworthy].size] = node;
    }
  }

  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    while(!scripts\mp\flags::gameflagexists("prematch_done"))
      waitframe();

    scripts\mp\flags::gameflagwait("prematch_done");
    _id_2636152C566D6C64::_id_F7B1205F52BED8EB();
  } else
    _id_48814951E916AF89::_id_2FC80954FA70D153();

  _id_607275F58B62ACDA(_id_58C817414D96DE59);

  if(isDefined(_id_58C817414D96DE59.nodes["boss_mummy_minion"]))
    thread _id_9B11B1F57C0701B1();

  if(isDefined(_id_58C817414D96DE59.nodes["boss_mummy_sarcophagus"])) {
    _id_392C68768D1759B6 = _id_58C817414D96DE59.nodes["boss_mummy_sarcophagus"][0];
    _id_58C817414D96DE59._id_44E60D99B00BDED7 = spawnscriptable("dmz_boss_mummy_sarcophagus", _id_392C68768D1759B6.origin, _id_392C68768D1759B6.angles);
  }

  if(isDefined(_id_58C817414D96DE59.nodes["boss_mummy_sarcophagus_lid"])) {
    _id_68FD3F4920245485 = _id_58C817414D96DE59.nodes["boss_mummy_sarcophagus_lid"][0];
    _id_58C817414D96DE59._id_ACB4F752811AC914 = spawnscriptable("dmz_boss_mummy_sarcophagus_lid", _id_68FD3F4920245485.origin, _id_68FD3F4920245485.angles);
  }

  if(isDefined(_id_58C817414D96DE59.nodes["boss_mummy_stuckspot"]))
    thread _id_1A8419AF11082DB9();

  if(isDefined(_id_58C817414D96DE59.nodes["boss_mummy_pushspot"]))
    thread _id_181594EEDDF88943();

  _id_58C817414D96DE59._id_9A96E52512FCACBE = [];
  _id_58C817414D96DE59._id_74B1FCD096CA5BC5 = [];

  foreach(_id_8FFE8998D8EDCE39 in _id_58C817414D96DE59.nodes["boss_mummy_deposit"])
  _id_58C817414D96DE59._id_9A96E52512FCACBE[_id_58C817414D96DE59._id_9A96E52512FCACBE.size] = spawnscriptable("dmz_boss_mummy_deposit", _id_8FFE8998D8EDCE39.origin + (0, 0, 4), _id_8FFE8998D8EDCE39.angles);

  level thread _id_4A3ACC4E2139FBB9();
  level thread _id_CBCEAD80F3E40C51();
  level thread _id_74EA3B7225B7AE20();
  level thread _id_91D077C25E0B8FE1();
  level thread _id_9AEFE0A164B4F0EB();
  scripts\engine\utility::flag_set("boss_mummy_init");
}

_id_607275F58B62ACDA(_id_58C817414D96DE59) {
  if(isDefined(_id_58C817414D96DE59._id_E2958F412A7425C0) && isalive(_id_58C817414D96DE59._id_E2958F412A7425C0)) {
    logstring("Haunting - Mummy - Another mummy tried to spawn in!");
    return;
  }

  _id_4C61CE86C1FF681B();
  _id_58C817414D96DE59._id_E2958F412A7425C0 = _id_58C817414D96DE59 _id_007B6091AF439B3F(_id_58C817414D96DE59.nodes["boss_mummy_spawn"][0]);

  if(!isDefined(_id_58C817414D96DE59._id_E2958F412A7425C0)) {
    logstring("Haunting - Mummy - Mummy spawn failed. At reset #: " + level._id_A7DB5E2C3FC93037);
    return;
  }

  _id_58C817414D96DE59 notify("boss_spawned");
  _id_58C817414D96DE59._id_E2958F412A7425C0._id_0566868292EE2A1B = _id_58C817414D96DE59;
  pos = _id_58C817414D96DE59._id_E2958F412A7425C0.origin;
  level._id_1E1F7470C9CC40F2 = getdvarint("dvar_263DED1FD47C7B48", 4000);
  _id_58C817414D96DE59 _id_2FDEB8023287BE67::_id_8002B09B8348902C(pos, "hud_icon_minimap_haunting_mummy", 0);
  _id_58C817414D96DE59 thread _id_E5AD94ACD6BC33F0(pos, "hud_icon_minimap_haunting_mummy");
  _id_58C817414D96DE59._id_E2958F412A7425C0 _id_5938B1C7E9CF6DDD::go_to_node_set_goal(_id_58C817414D96DE59.nodes["boss_mummy_spawn"]);
}

_id_E5AD94ACD6BC33F0(origin, icon) {
  level endon("game_ended");
  self._id_8B921A63781BDE80 = spawnStruct();
  self._id_8B921A63781BDE80.curorigin = origin;
  self._id_8B921A63781BDE80.offset3d = (0, 0, 1500);
  self._id_8B921A63781BDE80 scripts\mp\gameobjects::requestid(1, 0, undefined, 0, 0);

  if(isDefined(icon)) {
    scripts\mp\objidpoolmanager::update_objective_icon(self._id_8B921A63781BDE80.objidnum, icon);
    scripts\mp\objidpoolmanager::_id_2946E9EB07ACB3F1(self._id_8B921A63781BDE80.objidnum, &"MP_BR_INGAME/PHARAOH_DEFAULT");
    scripts\mp\objidpoolmanager::_id_D7E3C4A08682C1B9(self._id_8B921A63781BDE80.objidnum, 1);
  }

  objective_setbackground(self._id_8B921A63781BDE80.objidnum, 1);
  level waittill("boss_mummy_death");
  scripts\mp\objidpoolmanager::update_objective_state(self.objidnum, "done");
  scripts\mp\gameobjects::releaseid(self.objidnum);
  scripts\mp\objidpoolmanager::update_objective_state(self._id_8B921A63781BDE80.objidnum, "done");
  scripts\mp\gameobjects::releaseid(self._id_8B921A63781BDE80.objidnum);
}

_id_1A0E875E639208C3() {
  level endon("game_ended");
  self endon("death");
  level waittill("br_ending_start");
  level._id_7375DA301EBCC5DB = 1;
  self kill();
}

_id_F00C43299C6F9BF2() {
  level._id_A7DB5E2C3FC93037++;

  foreach(_id_37161947304FFCED in level._id_8E3A5A3223D8DB16._id_9A96E52512FCACBE) {
    _id_37161947304FFCED setscriptablepartstate("sarcophagus_deposit", "usable");
    _id_37161947304FFCED setscriptablepartstate("sarcophagus_effects", "off");
  }

  level._id_1405C76497905B89 = 0;
  level thread _id_4A3ACC4E2139FBB9();
  level._id_8E3A5A3223D8DB16._id_ACB4F752811AC914 setscriptablepartstate("sarcophagus_lid", "off");
  level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0 = undefined;
  level._id_B72429FBCC9A3984 = 0;
  level._id_7252495AD129237D = 0;
  _id_607275F58B62ACDA(level._id_8E3A5A3223D8DB16);
  level._id_8E3A5A3223D8DB16._id_7D8AD21E5DFD7C94 = [];
  level._id_0F4974B18243877D = 0;
  level thread _id_03988F5B34D230BC();
}

_id_DAE467FC6E2B1A49(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  player endon("disconnect");

  if(!isDefined(instance.uses))
    instance.uses = 0;

  instance.uses++;
  lootid = 35070;
  _id_452C6AAC817BECD8 = player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(lootid);

  if(!_id_452C6AAC817BECD8) {
    return;
  }
  if(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(lootid, 1))
    level childthread _id_47DBEC1374E5199E(instance, player);
  else
    logstring("Failed to use " + lootid + " although it is in player's backpack");
}

_id_47DBEC1374E5199E(instance, player) {
  if(!isDefined(level._id_1405C76497905B89))
    level._id_1405C76497905B89 = 0;

  level._id_1405C76497905B89++;
  level._id_796BCFECDCC6BDF8._id_9331B22CA6C15966++;
  instance setscriptablepartstate("sarcophagus_deposit", "unusable");
  instance setscriptablepartstate("sarcophagus_effects", "on");

  if(isDefined(player)) {
    player notify("player_deposited_skull");
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2DEC8C5484C61C7C");
    _id_4E18AB842F3A78CD(player);
  }
}

_id_4E18AB842F3A78CD(player) {
  if(level._id_1405C76497905B89 == 10) {
    level notify("bossMummyUnleashed");
    logstring("Haunting - Mummy - Unleashed");
    _id_58C817414D96DE59 = level._id_8E3A5A3223D8DB16;
    _id_58C817414D96DE59._id_ACB4F752811AC914 setscriptablepartstate("sarcophagus_lid", "on");
    _id_58C817414D96DE59._id_E2958F412A7425C0.ignoreall = 1;
    _id_58C817414D96DE59._id_E2958F412A7425C0.dontevershoot = 0;
    _id_58C817414D96DE59._id_E2958F412A7425C0.invulnerable = 0;
    _id_58C817414D96DE59._id_E2958F412A7425C0.speedscalemult = 1;
    _id_58C817414D96DE59._id_E2958F412A7425C0 hudoutlinedisable();
    _id_58C817414D96DE59._id_E2958F412A7425C0 thread _id_9B3BE7C4FAA9B932(player);
    _id_58C817414D96DE59._id_E2958F412A7425C0 thread _id_C273C9A42C0BA769();
    level thread _id_511651E463CB517D();
    level thread _id_0B97865A82331EF9();
    level._id_B72429FBCC9A3984 = 1;
  } else {
    _id_58C817414D96DE59 = level._id_8E3A5A3223D8DB16;
    _id_58C817414D96DE59._id_ACB4F752811AC914 setscriptablepartstate("sarcophagus_sound", "quake");
  }
}

_id_511651E463CB517D() {
  level endon("game_ended");
  _id_58C817414D96DE59 = level._id_8E3A5A3223D8DB16;
  _id_58C817414D96DE59._id_ACB4F752811AC914 setscriptablepartstate("sarcophagus_lid_explode", "on");
}

_id_45274600D9D51EBA(players) {
  level endon("game_ended");
  self endon("death");
  wait 2.2;

  if(scripts\engine\utility::ent_flag("attack_players")) {
    return;
  }
  players = scripts\engine\utility::_id_FDC9D5557C53078E(players);

  if(!isDefined(players) || players.size == 0)
    players = scripts\mp\utility\player::getplayersinradius(self.origin, 1000);

  childthread _id_F6F9D678639FA9D5(players);
  _id_42623C2865853280 = 900;

  if(getdvarint("dvar_A9500AD3E878D141", -1) >= 0)
    _id_42623C2865853280 = getdvarint("dvar_A9500AD3E878D141", -1);

  if(players.size > 0 && _id_42623C2865853280 > 0) {
    total = 900 / players.size;
    _id_C65DF5EF44DD0AA1 = int(ceil(total));

    foreach(player in players) {
      data = _id_1F9F119E097E9F6E(player);
      player _id_6AFF3948CF4CCA03::playerplunderpickup(_id_C65DF5EF44DD0AA1, data);
    }
  }
}

_id_1F9F119E097E9F6E(player) {
  data = spawnStruct();
  data.player = undefined;

  if(isDefined(player))
    data.player = player;

  data.playersplash = undefined;
  data.playerscoreeventref = undefined;
  data.playerscoreeventvalue = undefined;
  data.setplunderifunchanged = undefined;
  data.playplundersound = 1;
  data.plundersoundamount = undefined;
  data.playanimation = undefined;
  return data;
}

_id_F6F9D678639FA9D5(players) {
  if(getdvarint("dvar_388A2B8AE74AB2AD", 1) <= 0) {
    return;
  }
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_5BF3E22BDB650432 = level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7.origin + (0, 0, 0);
  _id_53A1972C91553018 = (0, 180, 0);
  _id_A626CCAD8052F1BF = 63;
  _id_43E2358D2ECBBD87 = 25;
  _id_EB6CD17BC5BF04EB = "brloot_plate_carrier_3";
  _id_A36C31E78931D9A3 = 1;

  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    _id_EB6CD17BC5BF04EB = "brloot_equip_gasmask";
    _id_A36C31E78931D9A3 = 108;
  }

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_5BF3E22BDB650432, _id_53A1972C91553018, self, _id_A626CCAD8052F1BF);
  _id_7E52B56769FA7774::spawnpickup("brloot_killstreak_uav", _id_CB4FAD49263E20C4);
  _id_A626CCAD8052F1BF = _id_A626CCAD8052F1BF + _id_43E2358D2ECBBD87;
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_5BF3E22BDB650432, _id_53A1972C91553018, self, _id_A626CCAD8052F1BF);
  _id_7E52B56769FA7774::spawnpickup(_id_EB6CD17BC5BF04EB, _id_CB4FAD49263E20C4, _id_A36C31E78931D9A3);
  _id_A626CCAD8052F1BF = _id_A626CCAD8052F1BF + _id_43E2358D2ECBBD87;
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_5BF3E22BDB650432, _id_53A1972C91553018, self, _id_A626CCAD8052F1BF);
  _id_7E52B56769FA7774::spawnpickup(_id_EB6CD17BC5BF04EB, _id_CB4FAD49263E20C4, _id_A36C31E78931D9A3);
  _id_A626CCAD8052F1BF = _id_A626CCAD8052F1BF + _id_43E2358D2ECBBD87;
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_5BF3E22BDB650432, _id_53A1972C91553018, self, _id_A626CCAD8052F1BF);
  _id_7E52B56769FA7774::spawnpickup(_id_EB6CD17BC5BF04EB, _id_CB4FAD49263E20C4, _id_A36C31E78931D9A3);
  _id_A626CCAD8052F1BF = _id_A626CCAD8052F1BF + _id_43E2358D2ECBBD87;
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_5BF3E22BDB650432, _id_53A1972C91553018, self, _id_A626CCAD8052F1BF);
  _id_7E52B56769FA7774::spawnpickup("brloot_super_armorbox", _id_CB4FAD49263E20C4);

  if(getdvarint("dvar_E1021AFD4056BEAE", 0) > 0) {
    level._id_DB7E814F7458CDBB = 5000;
    _id_A626CCAD8052F1BF = _id_A626CCAD8052F1BF + _id_43E2358D2ECBBD87;
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_5BF3E22BDB650432, _id_53A1972C91553018, self, _id_A626CCAD8052F1BF);
    _id_7E52B56769FA7774::spawnpickup("brloot_offhand_advancedvehicledrop", _id_CB4FAD49263E20C4);
    return;
  }

  if(getdvarint("dvar_2E30E40FDF552216", 1) <= 0) {
    return;
  }
  _id_C37ADCC0D4E42139 = scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C("veh9_mil_lnd_mrap");

  if(!istrue(_id_C37ADCC0D4E42139)) {
    return;
  }
  origin = level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7.origin;
  origin = origin + (-650, -3250, 0);
  origin = scripts\engine\utility::drop_to_ground(origin, 1500, -12000);
  closestplayer = scripts\engine\utility::getclosest(_id_5BF3E22BDB650432, players);

  if(!isDefined(level._id_66C37F456631A56C))
    level._id_66C37F456631A56C = 0;

  spawndata = spawnStruct();
  spawndata.origin = origin + (200 * level._id_66C37F456631A56C, -200 * level._id_66C37F456631A56C, 100);
  spawndata.angles = level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7.angles;
  spawndata.spawntype = "GAME_MODE";

  if(isDefined(closestplayer))
    spawndata.team = closestplayer.team;

  level._id_66C37F456631A56C++;
  _id_EFB5620DEEAD5E9B = level _id_721EE99D7A8F9168::_id_66C684FEA143FBFD("veh9_mil_lnd_mrap", spawndata);
  _id_EFB5620DEEAD5E9B._id_11CE4D3D11BDECFC = 1;

  if(isDefined(closestplayer)) {
    closestplayer thread _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("splash_haunting_mummy_mrap", level.teamdata[closestplayer.team]["players"]);
    _id_EFB5620DEEAD5E9B scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(_id_EFB5620DEEAD5E9B, closestplayer.team);
    _id_D0AE85B60EC1F5F7 = closestplayer calloutmarkerping_create(21, (0, 0, 100), _id_EFB5620DEEAD5E9B getentitynumber());
    closestplayer thread _id_7C74A92DA4DCB997(_id_EFB5620DEEAD5E9B, _id_D0AE85B60EC1F5F7);
    level thread _id_FD7C89CBC9C6B0D0(_id_EFB5620DEEAD5E9B, closestplayer);
  }

  _id_EFB5620DEEAD5E9B thread _id_AEED3B4EB76DA91B(closestplayer);
}

_id_7C74A92DA4DCB997(vehicle, _id_D0AE85B60EC1F5F7) {
  vehicle endon("death");
  entnumber = vehicle getentitynumber();
  vehicle waittill("vehicle_owner_update");

  if(isDefined(self) && self _meth_B02C8E799779BC10(entnumber))
    self calloutmarkerping_delete(_id_D0AE85B60EC1F5F7);
}

_id_FD7C89CBC9C6B0D0(vehicle, player) {
  level endon("game_ended");
  vehicle endon("death");

  if(getdvarint("dvar_FD267852A2FCA3DE", 1) <= 0) {
    return;
  }
  _id_6B805A0E08B30595 = level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0.origin;
  radius = getdvarint("dvar_D2E6D69C49732FE6", 3000);
  level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0 scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Boss_Dmz_Mummyddos", _id_6B805A0E08B30595, radius);
  vehicle childthread _id_F1D78A257B85235A();
  driver = undefined;

  for(;;) {
    if(isDefined(driver))
      vehicle scripts\engine\utility::waittill_any_ents(vehicle, "vehicle_owner_update", driver, "vehicle_seat_exit");
    else
      vehicle waittill("vehicle_owner_update");

    level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0 scripts\cp_mp\utility\game_utility::_id_04EAF685BC40A3B9();
    driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(vehicle, 1);

    if(isDefined(driver) && isPlayer(driver))
      level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0 scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(driver);
  }
}

_id_F1D78A257B85235A() {
  for(;;) {
    if(!isDefined(level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0) || !isalive(level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0)) {
      return;
    }
    level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0 scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0.origin);
    wait 0.1;
  }
}

_id_AEED3B4EB76DA91B(closestplayer) {
  level endon("game_ended");
  self endon("death");
  self endon("vehicle_owner_update");
  _id_636C8575D7A7768B = 5000;
  wait 30;

  for(;;) {
    _id_665CB4FADE42281A = 0;
    _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(closestplayer.team, "players");

    if(!isDefined(_id_E2B2BBD9E6539F11) || _id_E2B2BBD9E6539F11.size == 0) {
      if(isDefined(closestplayer) && isPlayer(closestplayer))
        _id_E2B2BBD9E6539F11 = [closestplayer];
    }

    if(!isDefined(_id_E2B2BBD9E6539F11) || _id_E2B2BBD9E6539F11.size == 0) {
      _id_78122E18403A8DC4 = scripts\mp\utility\player::getplayersinradius(self.origin, 800);

      if(isDefined(_id_78122E18403A8DC4) && _id_78122E18403A8DC4.size > 0)
        _id_665CB4FADE42281A = 1;
    }

    if(!_id_665CB4FADE42281A) {
      foreach(player in _id_E2B2BBD9E6539F11) {
        if(distance(player.origin, self.origin) < _id_636C8575D7A7768B)
          _id_665CB4FADE42281A = 1;
      }
    }

    if(!_id_665CB4FADE42281A || !istrue(level._id_B72429FBCC9A3984)) {
      if(isDefined(self) && isalive(self))
        self dodamage(self.health, self.origin, self, self, "MOD_CRUSH");

      return;
    }

    wait 5;
  }
}

_id_F5E079A9A7281A14(instance) {
  _id_D0AE85B60EC1F5F7 = self calloutmarkerping_create(6, (0, 0, 0), instance.index);
  thread _id_BA2070F53FA400B6(_id_D0AE85B60EC1F5F7, instance.index);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "stat_4F581684012440EC");

  return _id_D0AE85B60EC1F5F7;
}

_id_C273C9A42C0BA769() {
  level endon("game_ended");
  self endon("death");
  self endon("attack_players");
  wait 2;

  while(istrue(self._id_DFEEC0C82A35EE8E))
    wait 0.25;

  self.stealth_enabled = 1;
  self._id_5323A94889EFF1DE = 1;
  self setstealthstate("combat");
  goalpos = getclosestpointonnavmesh(self.origin);
  self setgoalpos(goalpos, 45);
  wait 5;
  target = undefined;
  _id_78122E18403A8DC4 = scripts\mp\utility\player::getplayersinradius(self.origin, 600);

  if(_id_78122E18403A8DC4.size > 0)
    target = scripts\engine\utility::getclosest(self.origin, _id_78122E18403A8DC4);

  if(isDefined(target)) {
    goalpos = self.origin;

    if(isDefined(self._id_0566868292EE2A1B) && isDefined(self._id_0566868292EE2A1B._id_44E60D99B00BDED7))
      goalpos = self._id_0566868292EE2A1B._id_44E60D99B00BDED7.origin;

    goalpos = (goalpos + target.origin) / 2;
    goalpos = getclosestpointonnavmesh(goalpos);
    self setgoalpos(goalpos, 25);
    wait 4;

    if(isDefined(self._id_0566868292EE2A1B) && isDefined(self._id_0566868292EE2A1B._id_44E60D99B00BDED7)) {
      _id_B421B21C92B89D6B = goalpos - self._id_0566868292EE2A1B._id_44E60D99B00BDED7.origin;
      _id_E8D51BF2E0FD9BF4 = self._id_0566868292EE2A1B._id_44E60D99B00BDED7.origin + rotatevector(_id_B421B21C92B89D6B, (0, 180, 0));
    }

    goalpos = getclosestpointonnavmesh(goalpos);
    self setgoalpos(goalpos, 25);
    wait 2;
  }

  _id_9C0FF5D12FECF3A1 = 3;
  maxdist = 3800;

  for(;;) {
    if(!isDefined(self._id_0566868292EE2A1B) || !isDefined(self._id_0566868292EE2A1B._id_44E60D99B00BDED7)) {
      wait 1;
      continue;
    }

    goalpos = self._id_0566868292EE2A1B._id_44E60D99B00BDED7.origin;
    goalpos = (goalpos[0] + randomintrange(-200, 200), goalpos[1] + randomintrange(-200, 200), goalpos[2]);
    goalpos = getclosestpointonnavmesh(goalpos);
    self setgoalpos(goalpos, 25);
    wait(_id_9C0FF5D12FECF3A1);
    spawnpoints = level._id_8E3A5A3223D8DB16.nodes["boss_mummy_minion_outside"];
    _id_8BD9C0C101D4F67A = _id_45437518D020306C(self._id_0566868292EE2A1B._id_44E60D99B00BDED7.origin, spawnpoints, maxdist);
    goalpos = getclosestpointonnavmesh(_id_8BD9C0C101D4F67A.origin);
    self setgoalpos(goalpos, 25);
    _id_9C0FF5D12FECF3A1 = randomintrange(26, 29);
    maxdist = randomintrange(3000, 3800);
    _id_1C9D61C4B985C8AC = randomintrange(29, 32);
    wait(_id_1C9D61C4B985C8AC);
  }
}

_id_909A57E6CC25842F() {
  level endon("game_ended");
  self endon("death");

  if(istrue(self._id_E31150FF1569D298)) {
    return;
  }
  self._id_E31150FF1569D298 = 1;

  while(istrue(self._id_DFEEC0C82A35EE8E))
    wait 0.1;

  logstring("Haunting - Mummy - Angered");
  self.ignoreall = 0;
  thread _id_B9D4306B4408A6A0(4);
  thread _id_4EA6A1CAE9D252A2();
  level thread _id_77642CE5D606B86C();
  thread _id_7B361F5EB4324894();
  thread _id_C92850CF4B5DC781();
  thread _id_3E6EDBD5ABAB0149();
}

_id_DD1761BBAF4B281B() {
  self endon("death");

  if(getdvarint("dvar_D634962D43004098", 1) == 1)
    self setscriptablepartstate("headfire", "on");

  thread _id_C5A2FCC9688CCBF2();
}

_id_7B361F5EB4324894() {
  level endon("game_ended");
  self endon("death");
  scripts\engine\utility::ent_flag_wait("attack_players");

  for(;;) {
    _id_78122E18403A8DC4 = scripts\mp\utility\player::getplayersinradius(self.origin, 1200);
    _id_6DDCFDBD186AE278 = scripts\mp\utility\player::getplayersinradius(self.origin, 600);
    _id_42B880DD8711B117 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_78122E18403A8DC4.size; _id_AC0E594AC96AA3A8++) {
      if(scripts\mp\utility\player::isreallyalive(_id_78122E18403A8DC4[_id_AC0E594AC96AA3A8]) && !istrue(_id_78122E18403A8DC4[_id_AC0E594AC96AA3A8].inlaststand))
        _id_42B880DD8711B117[_id_42B880DD8711B117.size] = _id_78122E18403A8DC4[_id_AC0E594AC96AA3A8];
    }

    _id_78122E18403A8DC4 = _id_42B880DD8711B117;

    if(_id_6DDCFDBD186AE278.size == 0) {
      if(_id_78122E18403A8DC4.size > 0) {
        target = scripts\engine\utility::getclosest(self.origin, _id_78122E18403A8DC4);
        _id_120270BD0A747A35::_id_304DA84D9A815C01(target.origin, 8, 1);
      } else if(isDefined(level._id_8E3A5A3223D8DB16) && isDefined(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7)) {
        target = getclosestpointonnavmesh(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7.origin);
        _id_120270BD0A747A35::_id_304DA84D9A815C01(target, 8, 1);
      }
    }

    wait 10;
  }
}

_id_4A3ACC4E2139FBB9() {
  level endon("game_ended");
  _id_58C817414D96DE59 = level._id_8E3A5A3223D8DB16;
  _id_9A96E52512FCACBE = _id_58C817414D96DE59._id_9A96E52512FCACBE;
  _id_9A96E52512FCACBE = scripts\engine\utility::array_randomize(_id_9A96E52512FCACBE);
  _id_FC8AFB765C52482B = 3;
  dvar = "dvar_28C71CFB2EBB7EE9";

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    dvar = "dvar_6E055AFA4083A606";

  if(getdvarint(dvar, _id_FC8AFB765C52482B) > 0) {
    total = getdvarint(dvar, _id_FC8AFB765C52482B);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < total; _id_AC0E594AC96AA3A8++) {
      _id_47DBEC1374E5199E(_id_9A96E52512FCACBE[_id_AC0E594AC96AA3A8]);
      wait 0.05;
    }
  }
}

_id_CBCEAD80F3E40C51() {
  level endon("game_ended");
  level endon("bossMummyUnleashed");

  while(!isDefined(level._id_8E3A5A3223D8DB16) || !isDefined(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7))
    wait 0.1;

  minplayerdist = 1000;
  lootid = 35070;

  for(;;) {
    if(istrue(level._id_B72429FBCC9A3984)) {
      return;
    }
    origin = level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7.origin;
    _id_78122E18403A8DC4 = scripts\mp\utility\player::getplayersinradius(origin, minplayerdist);

    if(_id_78122E18403A8DC4.size > 0) {
      foreach(player in _id_78122E18403A8DC4) {
        _id_452C6AAC817BECD8 = player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(lootid);

        if(!_id_452C6AAC817BECD8) {
          player thread _id_7B2985E176CB4791();
          continue;
        }

        player thread _id_377A5D810EEFBC8B();

        if(!istrue(player._id_1A8BDDE58103C6FC))
          player thread _id_CC0D21D4D1E94C43(1);
      }
    }

    wait 5;
  }
}

_id_B88E6ACE3E918449() {
  player = self;
  lootid = 35070;
  _id_452C6AAC817BECD8 = player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(lootid);

  if(!_id_452C6AAC817BECD8) {
    player thread _id_7B2985E176CB4791();
    return;
  }

  player thread _id_CC0D21D4D1E94C43(undefined, 1);
}

_id_F6EE262568FF4622(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  player endon("disconnect");
  lootid = 35070;
  _id_452C6AAC817BECD8 = player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(lootid);

  if(!_id_452C6AAC817BECD8) {
    return;
  }
  player thread _id_377A5D810EEFBC8B();
  player thread _id_CC0D21D4D1E94C43();
}

_id_377A5D810EEFBC8B() {
  self endon("disconnect");
  scripts\engine\utility::flag_wait("boss_mummy_init");
  _id_58C817414D96DE59 = level._id_8E3A5A3223D8DB16;

  foreach(_id_8FFE8998D8EDCE39 in _id_58C817414D96DE59._id_9A96E52512FCACBE)
  _id_8FFE8998D8EDCE39 enablescriptableplayeruse(self);

  thread _id_460D85B26F3B236F(self);
}

_id_460D85B26F3B236F(player) {
  player endon("disconnect");
  player notify("mummy_waitUntilCannotDeposit");
  player endon("mummy_waitUntilCannotDeposit");

  for(;;) {
    player scripts\engine\utility::waittill_any_5("death", "player_deposited_skull", "ping_inv_drop_valuable", "quickDropCleanupCache", "updateLootSplash");
    lootid = 35070;
    _id_452C6AAC817BECD8 = player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(lootid);

    if(!_id_452C6AAC817BECD8) {
      player thread _id_7B2985E176CB4791();
      return;
    }
  }
}

_id_7B2985E176CB4791() {
  self endon("disconnect");
  scripts\engine\utility::flag_wait("boss_mummy_init");
  _id_58C817414D96DE59 = level._id_8E3A5A3223D8DB16;

  foreach(_id_8FFE8998D8EDCE39 in _id_58C817414D96DE59._id_9A96E52512FCACBE)
  _id_8FFE8998D8EDCE39 disablescriptableplayeruse(self);
}

_id_CC0D21D4D1E94C43(_id_847CF056F9711E29, _id_0336C2609C59DD04) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(istrue(_id_0336C2609C59DD04)) {
    while(!scripts\mp\flags::gameflag("prematch_done"))
      waitframe();

    scripts\mp\gamelogic::waitforplayers(level.prematchperiod, 0, 0);
    _id_E5D77BF46A926594 = self.origin;

    while(distance2d(self.origin, _id_E5D77BF46A926594) < 64)
      wait 1;

    wait 3;
  }

  if(istrue(self._id_1A8BDDE58103C6FC)) {
    if(!istrue(_id_847CF056F9711E29))
      self._id_5190B983133A8167 = 1;

    return;
  }

  self._id_1A8BDDE58103C6FC = 1;

  for(;;) {
    while(distance(self.origin, level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7.origin) < 350)
      wait 1;

    if(istrue(level._id_B72429FBCC9A3984)) {
      break;
    }

    while(istrue(self._id_E7AF56A2DF18030D) || istrue(self.extracted))
      wait 1;

    _id_C80A6140E101FAFF = 0;
    lootid = 35070;
    _id_452C6AAC817BECD8 = _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(lootid);
    _id_C80A6140E101FAFF = _id_2D9D24F7C63AC143::_id_B4BD198A25085E3E(lootid);
    _id_A0418589DD81226A = 15;
    _id_663D78F75F0EF168 = 21;
    _id_C762AF5EC56ECCB1 = 26;
    _id_D356D84A1AE17493 = 38;
    _id_D0212FDCCA97006C = _id_A0418589DD81226A;

    if(_id_C80A6140E101FAFF > 0) {
      _id_0488CF627600F486 = scripts\engine\math::remap(_id_C80A6140E101FAFF, 1, 5, 0.65, 1);

      if(_id_2CFB88AF9245875C() < 4000)
        _id_D0212FDCCA97006C = scripts\engine\math::remap(_id_C80A6140E101FAFF, 1, 5, _id_D356D84A1AE17493, _id_C762AF5EC56ECCB1);
      else
        _id_D0212FDCCA97006C = scripts\engine\math::remap(_id_C80A6140E101FAFF, 1, 5, _id_663D78F75F0EF168, _id_A0418589DD81226A);

      alias = _id_00DE1B30B56D8941(_id_C80A6140E101FAFF);

      if(isDefined(alias))
        childthread _id_C75930D716E3A094(_id_C80A6140E101FAFF, _id_0488CF627600F486, alias);
    } else
      break;

    self._id_5190B983133A8167 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D0212FDCCA97006C; _id_AC0E594AC96AA3A8++) {
      if(self._id_5190B983133A8167 && _id_AC0E594AC96AA3A8 + 4 < _id_D0212FDCCA97006C) {
        wait 4;
        break;
      }

      wait 1;
    }

    wait(randomfloat(2));
  }

  self._id_1A8BDDE58103C6FC = undefined;
}

_id_C75930D716E3A094(_id_C80A6140E101FAFF, _id_0488CF627600F486, alias) {
  self notify("mummy_face_appear");
  self endon("mummy_face_appear");

  if(!_id_2C3C990BA58FA6F5::_id_5A758C8D306F92ED() && !isDefined(self.radiationoverlay)) {
    self.radiationoverlay = newclienthudelem(self);
    self.radiationoverlay.x = 0;
    self.radiationoverlay.y = 0;
    self.radiationoverlay setshader("black", 640, 480);
    self.radiationoverlay.alignx = "left";
    self.radiationoverlay.aligny = "top";
    self.radiationoverlay.horzalign = "fullscreen";
    self.radiationoverlay.vertalign = "fullscreen";
    self.radiationoverlay.alpha = 0;
  }

  if(!isDefined(_id_C80A6140E101FAFF))
    _id_C80A6140E101FAFF = 1;

  duration = 2;

  if(!_id_2C3C990BA58FA6F5::_id_5A758C8D306F92ED())
    self.radiationoverlay _id_DA4359697726B010(1, _id_0488CF627600F486);

  if(_id_C80A6140E101FAFF == 1)
    thread _id_BC0D82B7B41B3853("ingame_haunting_mummy_2s", 2, alias);
  else if(_id_C80A6140E101FAFF == 2 || _id_C80A6140E101FAFF == 3)
    thread _id_BC0D82B7B41B3853("ingame_haunting_mummy_4s", 4, alias);
  else if(_id_C80A6140E101FAFF > 3)
    thread _id_BC0D82B7B41B3853("ingame_haunting_mummy_6s", 6, alias);

  wait(duration);

  if(!_id_2C3C990BA58FA6F5::_id_5A758C8D306F92ED())
    self.radiationoverlay _id_46495EF11FDDA775(1, 0);
}

_id_DA4359697726B010(duration, alpha) {
  self fadeovertime(duration);
  self.alpha = alpha;
  wait(duration);
}

_id_46495EF11FDDA775(duration, alpha) {
  self fadeovertime(duration);
  self.alpha = alpha;
  wait(duration);
}

_id_BC0D82B7B41B3853(type, duration, _id_5F01FBCA63F98450) {
  self endon("disconnect");
  self._id_1CDC49D6FD0BD5A5 = gettime();
  level._id_1CDC49D6FD0BD5A5 = gettime();

  if(isDefined(level._id_8336FB035950FE34) && isDefined(level._id_8336FB035950FE34._id_9CD34562C355C3B7)) {
    level._id_8336FB035950FE34._id_9CD34562C355C3B7["ingame_haunting_mummy_2s"]._id_0C641CE6EB2DB06C = 2;
    level._id_8336FB035950FE34._id_9CD34562C355C3B7["ingame_haunting_mummy_4s"]._id_0C641CE6EB2DB06C = 4;
    level._id_8336FB035950FE34._id_9CD34562C355C3B7["ingame_haunting_mummy_6s"]._id_0C641CE6EB2DB06C = 6;
  }

  alpha = 1.0;
  maxalpha = getdvarfloat("dvar_136363FB7354957A", 0.6);
  _id_E26B36A6DF3106DD = getdvarfloat("dvar_13866DFB737AF330", 0.3);
  _id_A09E6D340590460A = _id_2EBE59253158B359(3000);
  alpha = scripts\engine\math::remap(_id_A09E6D340590460A, 0, 6, maxalpha, _id_E26B36A6DF3106DD);
  _id_6A37A0FA28B02815 = getdvarfloat("dvar_4E36811226678C4B", -1);

  if(_id_6A37A0FA28B02815 > 0)
    alpha = _id_6A37A0FA28B02815;

  _id_44B8991C2B01716A::_id_0F7FE427D574911C(type, self, 1, 1, alpha);
  _id_E2480C76160E19C0(_id_5F01FBCA63F98450);
  _id_721982228624D657 = _id_6489FCDFE6FA2E36::getspectatorsofplayer(self);

  foreach(spectator in _id_721982228624D657) {
    spectator thread _id_44B8991C2B01716A::_id_0F7FE427D574911C(type, spectator, 1, 1, alpha);
    spectator _id_E2480C76160E19C0(_id_5F01FBCA63F98450);
  }

  _id_CEB1FF9428033CFD = scripts\mp\utility\player::getplayersinradius(self.origin, 2000, undefined, self);

  if(_id_CEB1FF9428033CFD.size > 0) {
    foreach(_id_6EE5484560EC747C in _id_CEB1FF9428033CFD) {
      if(isent(_id_6EE5484560EC747C) && isent(self))
        playfxontagforclients(level._effect["vfx_hween_mummy_playeraura"], self, "tag_eye", _id_6EE5484560EC747C);
    }
  }

  playfxontagforclients(level._effect["vfx_hween_mummy_camera"], self, "tag_eye", self);
  wait(duration);

  if(isent(self))
    stopfxontagforclients(level._effect["vfx_hween_mummy_camera"], self, "tag_eye", self);

  if(_id_CEB1FF9428033CFD.size > 0) {
    _id_CEB1FF9428033CFD = scripts\engine\utility::array_removeundefined(_id_CEB1FF9428033CFD);

    foreach(_id_6EE5484560EC747C in _id_CEB1FF9428033CFD) {
      if(isent(_id_6EE5484560EC747C) && isent(self))
        stopfxontagforclients(level._effect["vfx_hween_mummy_playeraura"], self, "tag_eye", _id_6EE5484560EC747C);
    }
  }
}

_id_FBF4861C9666A90B(player, showicon) {
  team = player.team;

  if(!isDefined(self._id_7D8AD21E5DFD7C94))
    self._id_7D8AD21E5DFD7C94 = [];

  if(!isDefined(self._id_E2958F412A7425C0) || !isalive(self._id_E2958F412A7425C0) || scripts\engine\utility::array_contains(self._id_7D8AD21E5DFD7C94, team))
    return 0;

  self._id_7D8AD21E5DFD7C94 = scripts\engine\utility::array_add(self._id_7D8AD21E5DFD7C94, team);
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  _id_AC4C51BF033F6323 = players;

  foreach(_id_6EE5484560EC747C in _id_AC4C51BF033F6323) {
    if(istrue(_id_6EE5484560EC747C._id_E6204058F06B94E5))
      _id_AC4C51BF033F6323 = scripts\engine\utility::array_remove(_id_AC4C51BF033F6323, _id_6EE5484560EC747C);
  }

  scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, team);

  if(isDefined(self._id_E2958F412A7425C0) && isDefined(self._id_E2958F412A7425C0._id_0566868292EE2A1B) && isDefined(self._id_E2958F412A7425C0._id_0566868292EE2A1B._id_44E60D99B00BDED7))
    scripts\mp\objidpoolmanager::update_objective_position(self.objidnum, self._id_E2958F412A7425C0._id_0566868292EE2A1B._id_44E60D99B00BDED7.origin);

  _id_171F90B9C4C76D44 = "saba_oasis";
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_mummy_revealed", _id_AC4C51BF033F6323, _id_171F90B9C4C76D44);
  return 1;
}

_id_49CEA61EF7FB0353() {
  _id_EB4D81FD840007E2 = undefined;
  _id_AC4C51BF033F6323 = [];

  foreach(player in level.players) {
    if(scripts\engine\utility::array_contains(level._id_96A411A078728E28._id_EE7192D15FF25287, player)) {
      continue;
    }
    if(distance2dsquared(player.origin, _id_EB4D81FD840007E2) < squared(12000)) {
      _id_AC4C51BF033F6323[_id_AC4C51BF033F6323.size] = player;
      level._id_96A411A078728E28._id_EE7192D15FF25287[level._id_96A411A078728E28._id_EE7192D15FF25287.size] = player;
    }
  }

  _id_171F90B9C4C76D44 = "saba_oasis";
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_mummy_revealed", _id_AC4C51BF033F6323, _id_171F90B9C4C76D44);
}

_id_E9CD2BDE89D8E12E() {
  level endon("game_ended");
  wait 2;
  _id_171F90B9C4C76D44 = "saba_oasis";
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_mummy_killed", level.players, _id_171F90B9C4C76D44);
}

_id_77642CE5D606B86C() {
  level endon("game_ended");
  wait 2;
  _id_B4208787E6D21BD5 = scripts\mp\utility\player::getplayersinradius(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7.origin, 4000);

  if(_id_B4208787E6D21BD5.size == 0) {
    return;
  }
  _id_171F90B9C4C76D44 = "saba_oasis";
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_mummy_unleashed", _id_B4208787E6D21BD5, _id_171F90B9C4C76D44);
}

_id_03988F5B34D230BC() {
  _id_171F90B9C4C76D44 = "saba_oasis";
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_mummy_respawned", level.players, _id_171F90B9C4C76D44);
}

_id_B0F5F1F5AEF80A9D(players) {
  _id_171F90B9C4C76D44 = "saba_oasis";
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_mummy_cashforskulls", players, _id_171F90B9C4C76D44);
}

_id_74EA3B7225B7AE20() {
  level endon("game_ended");
  level notify("mummy_cashforskulls_handler");
  level endon("mummy_cashforskulls_handler");

  if(getdvarint("dvar_C2ADD21C773B520E", -1) > 0) {
    return;
  }
  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    return;
  }
  while(!isDefined(level._id_8E3A5A3223D8DB16) || !isDefined(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7))
    wait 0.1;

  wait 10;

  for(;;) {
    _id_EFCAE04A8B892D80 = _id_2695A20D4011076D::_id_024C5A8D31AE262F(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7.origin);

    if(_id_EFCAE04A8B892D80) {
      break;
    }

    wait 5;
  }

  _id_3A4314B0AC506854 = getentitylessscriptablearray("brloot_valuable_cursed_skull", undefined);

  foreach(_id_2A2ED61642D3ACDE in _id_3A4314B0AC506854)
  _id_2A2ED61642D3ACDE setscriptablepartstate("brloot_valuable_cursed_skull", "hidden");

  _id_C01BE46E4BBD0431 = [];

  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }
    lootid = 35070;
    _id_452C6AAC817BECD8 = player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(lootid);
    total = 0;

    while(_id_452C6AAC817BECD8) {
      if(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(lootid, 1)) {
        _id_452C6AAC817BECD8 = player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(lootid);
        total++;
        continue;
      }

      _id_452C6AAC817BECD8 = 0;
      _id_C01BE46E4BBD0431[_id_C01BE46E4BBD0431.size] = player;
    }

    _id_A758990DB9B1F67B = getdvarint("dvar_44BE539E587D8264", 100);
    total = total * _id_A758990DB9B1F67B;
    _id_C65DF5EF44DD0AA1 = int(ceil(total));
    data = _id_1F9F119E097E9F6E(player);

    if(_id_C65DF5EF44DD0AA1 > 0)
      player _id_6AFF3948CF4CCA03::playerplunderpickup(_id_C65DF5EF44DD0AA1, data);
  }

  _id_B0F5F1F5AEF80A9D(_id_C01BE46E4BBD0431);
}

_id_91D077C25E0B8FE1() {
  level endon("game_ended");
  level endon("bossMummyUnleashed");
  level notify("mummy_revealNearbySkulls");
  level endon("mummy_revealNearbySkulls");

  while(!isDefined(level._id_8E3A5A3223D8DB16) || !isDefined(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7))
    wait 0.1;

  _id_3E1F718EE5C9DEB7 = level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7.origin;

  for(;;) {
    wait 3;
    _id_B4208787E6D21BD5 = scripts\mp\utility\player::getplayersinradius(_id_3E1F718EE5C9DEB7, 4000);
    _id_3A4314B0AC506854 = getentitylessscriptablearray("brloot_valuable_cursed_skull", undefined, _id_3E1F718EE5C9DEB7, 4000);

    if(_id_B4208787E6D21BD5.size == 0) {
      continue;
    }
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3A4314B0AC506854.size; _id_AC0E594AC96AA3A8++) {
      closestplayer = scripts\engine\utility::getclosest(_id_3A4314B0AC506854[_id_AC0E594AC96AA3A8].origin, _id_B4208787E6D21BD5, 150);

      if(!isDefined(closestplayer) || !scripts\mp\utility\player::_id_AD443BBCDCF37B85(closestplayer)) {
        continue;
      }
      if(scripts\mp\utility\outline::outlineoccluded(_id_3A4314B0AC506854[_id_AC0E594AC96AA3A8].origin, _id_3A4314B0AC506854[_id_AC0E594AC96AA3A8].origin + (0, 0, 10))) {
        continue;
      }
      closestplayer _id_4A5539E09B1FA855(_id_3A4314B0AC506854[_id_AC0E594AC96AA3A8]);
    }
  }
}

_id_4A5539E09B1FA855(instance) {
  foreach(_id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(_id_F0EA4030349A33D5 _meth_BEE315A15CF61820(instance.index))
      return undefined;
  }

  _id_DA07265F8351BD9E = self _meth_368AF07F7897FD79(18);

  if(_id_DA07265F8351BD9E)
    return undefined;

  if(isDefined(self._id_7378D2B46CC5F361) && self._id_7378D2B46CC5F361 == instance.origin)
    return undefined;

  self._id_7378D2B46CC5F361 = instance.origin;

  if(isDefined(self._id_B76E1467EAAAB29C) && !scripts\engine\utility::time_has_passed(self._id_B76E1467EAAAB29C, 60))
    return undefined;

  self._id_B76E1467EAAAB29C = gettime();
  _id_D0AE85B60EC1F5F7 = self calloutmarkerping_create(18, (0, 0, 0), instance.index);
  thread _id_BA2070F53FA400B6(_id_D0AE85B60EC1F5F7, instance.index);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "stat_D9107ED89E7C5302");

  return _id_D0AE85B60EC1F5F7;
}

_id_BA2070F53FA400B6(_id_D0AE85B60EC1F5F7, index) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_2(10, "death_or_disconnect", "enter_live_ragdoll");

  if(isDefined(self) && self _meth_BEE315A15CF61820(index))
    self calloutmarkerping_delete(_id_D0AE85B60EC1F5F7);
}

_id_807B408895209A6F() {
  if(getdvarint("dvar_9FA051AC8FD6130B", 1) <= 0)
    return 0;

  return 1;
}

_id_9B3BE7C4FAA9B932(_id_FAC2CD3BDC5B407B) {
  if(!_id_807B408895209A6F()) {
    return;
  }
  wait 12;

  if(scripts\engine\utility::ent_flag("attack_players")) {
    return;
  }
  _id_CDAD8A778CD06473("dialog_placebymyside");
  wait 7;

  if(scripts\engine\utility::ent_flag("attack_players")) {
    return;
  }
  players = scripts\mp\utility\teams::getteamdata(_id_FAC2CD3BDC5B407B.team, "players");

  if(!isDefined(players) || players.size == 0) {
    if(isDefined(_id_FAC2CD3BDC5B407B) && isPlayer(_id_FAC2CD3BDC5B407B))
      players = [_id_FAC2CD3BDC5B407B];
  }

  if((!isDefined(players) || players.size == 0) && (!isDefined(_id_FAC2CD3BDC5B407B) || !isPlayer(_id_FAC2CD3BDC5B407B)))
    players = scripts\mp\utility\player::getplayersinradius(self.origin, 1000);

  foreach(player in players)
  player thread _id_BC0D82B7B41B3853("ingame_haunting_mummy_4s", 4, "dx_br_saba_spwn_mumy_rwrd");

  if(players.size > 0)
    thread _id_45274600D9D51EBA(players);
}

_id_4EA6A1CAE9D252A2() {
  self endon("death");

  if(!_id_807B408895209A6F()) {
    return;
  }
  wait 0.2;
  _id_CDAD8A778CD06473("dialog_youdarechallengeme");
  wait 1.5;
  _id_7AB5B649FA408138::_id_FDD0934F1A32F70D(self.origin, 2000, "mx_dmz_boss_mummy_combat");
}

_id_C5A2FCC9688CCBF2() {
  self endon("death");

  if(!_id_807B408895209A6F()) {
    return;
  }
  _id_CDAD8A778CD06473("dialog_ahh");
}

_id_00DE1B30B56D8941(_id_C80A6140E101FAFF) {
  if(!_id_807B408895209A6F())
    return undefined;

  if(!isDefined(self._id_BEA735FE9F445A65)) {
    _id_FFC2BEB36A5846C8 = ["dx_br_saba_prsp_mumy_bringtheskullstomeun_01", "dx_br_saba_prsp_mumy_bringmetheskullsdono", "dx_br_saba_prsp_mumy_delivertheskullstome", "dx_br_saba_prsp_mumy_thoseskullsbelongtom", "dx_br_saba_prsp_mumy_cometomewiththeskull_01", "dx_br_saba_prsp_mumy_taketheskullstomytom", "dx_br_saba_prsp_mumy_itisyourdutytobringm", "dx_br_saba_prsp_mumy_givemebackwhatsmineo", "dx_br_saba_prsp_mumy_bringmetheskullsandy_01", "dx_br_saba_prsp_mumy_taketheskullstomytom_01"];
    _id_2B3F4B570D267800 = ["dx_br_saba_prsp_mumy_irequireskullsbringt_01", "dx_br_saba_prsp_mumy_cometomewiththeskull", "dx_br_saba_prsp_mumy_bringmetheskullsandy", "dx_br_saba_prsp_mumy_bringtheskullstomeun", "dx_br_saba_prsp_mumy_irequireskullsbringt"];
    self._id_BEA735FE9F445A65 = spawnStruct();
    self._id_BEA735FE9F445A65._id_8B9F60486533A6C1 = 0;
    self._id_BEA735FE9F445A65._id_FFC2BEB36A5846C8 = scripts\engine\utility::create_deck(_id_FFC2BEB36A5846C8);
    self._id_BEA735FE9F445A65._id_2B3F4B570D267800 = scripts\engine\utility::create_deck(_id_2B3F4B570D267800);
  }

  if(!isDefined(_id_C80A6140E101FAFF) || _id_C80A6140E101FAFF == 0)
    return undefined;

  if(!istrue(self._id_BEA735FE9F445A65._id_28E87C1181B6815D) && _id_C80A6140E101FAFF > 1 && _id_2CFB88AF9245875C() > 5000) {
    self._id_BEA735FE9F445A65._id_28E87C1181B6815D = 1;
    return "dx_br_saba_prsp_mumy_thattreasurebelongst";
  }

  if(!istrue(self._id_BEA735FE9F445A65._id_7930918FC0A20239) && _id_C80A6140E101FAFF > 1 && _id_2CFB88AF9245875C() > 8000) {
    self._id_BEA735FE9F445A65._id_7930918FC0A20239 = 1;
    return "dx_br_saba_prsp_mumy_youcannotescapeme";
  }

  if(!istrue(self._id_BEA735FE9F445A65._id_C69E5A33B467198B) && _id_C80A6140E101FAFF > 1 && _id_163D0BCA557858DA()) {
    self._id_BEA735FE9F445A65._id_C69E5A33B467198B = 1;
    return "dx_br_saba_prsp_mumy_whatyoupossessispric";
  }

  _id_2F5432DBFC5F041A = 2;
  alias = undefined;

  if(_id_C80A6140E101FAFF == 1 && self._id_BEA735FE9F445A65._id_8B9F60486533A6C1 < _id_2F5432DBFC5F041A) {
    alias = "dx_br_saba_actn_mumy_evll";
    self._id_BEA735FE9F445A65._id_8B9F60486533A6C1++;
  } else if(_id_C80A6140E101FAFF == 2 || _id_C80A6140E101FAFF == 3 || self._id_BEA735FE9F445A65._id_8B9F60486533A6C1 >= _id_2F5432DBFC5F041A) {
    alias = self._id_BEA735FE9F445A65._id_FFC2BEB36A5846C8 scripts\engine\utility::deck_draw();
    self._id_BEA735FE9F445A65._id_8B9F60486533A6C1 = 0;
  } else if(_id_C80A6140E101FAFF > 3)
    alias = self._id_BEA735FE9F445A65._id_2B3F4B570D267800 scripts\engine\utility::deck_draw();

  return alias;
}

_id_E0FD8EE0853F21A2(_id_03C5EACA58C27809) {
  if(!_id_807B408895209A6F()) {
    return;
  }
  if(_id_03C5EACA58C27809 == 0) {
    return;
  }
  self stopsounds();
  _id_CDAD8A778CD06473("dialog_pain");
}

_id_013FDB11574FCE3B() {
  if(!_id_807B408895209A6F()) {
    return;
  }
  _id_CDAD8A778CD06473("dialog_summonminion");
}

_id_6F426C44C586F562(_id_03C5EACA58C27809) {
  if(!_id_807B408895209A6F()) {
    return;
  }
  if(isDefined(level._id_1CDC49D6FD0BD5A5) && !scripts\engine\utility::time_has_passed(level._id_1CDC49D6FD0BD5A5, 7))
    wait 8;

  players = scripts\mp\utility\player::getplayersinradius(self.origin, 4000);

  if(_id_03C5EACA58C27809 == 0) {
    foreach(player in players)
    player thread _id_BC0D82B7B41B3853("ingame_haunting_mummy_2s", 2, "dx_br_saba_tkdm_mumy_youknownotthepoweryo");
  } else if(_id_03C5EACA58C27809 == 1) {
    foreach(player in players)
    player thread _id_BC0D82B7B41B3853("ingame_haunting_mummy_4s", 4, "dx_br_saba_tkdm_mumy_youdaredisturbmyslum");
  } else if(_id_03C5EACA58C27809 == 2) {
    foreach(player in players)
    player thread _id_BC0D82B7B41B3853("ingame_haunting_mummy_2s", 2, "dx_br_saba_tkdm_mumy_youshallpayforthiswi");
  } else if(_id_03C5EACA58C27809 == 3) {
    foreach(player in players)
    player thread _id_BC0D82B7B41B3853("ingame_haunting_mummy_6s", 6, "dx_br_saba_tkdm_mumy_foolishmortalyoureno");
  }
}

_id_8023E5A651CAD543() {
  level endon("game_ended");

  if(!_id_807B408895209A6F()) {
    return;
  }
  if(!isDefined(self.origin)) {
    return;
  }
  _id_AD4D55FD441C70BD = self.origin;
  _id_7AB5B649FA408138::_id_FDD0934F1A32F70D(_id_AD4D55FD441C70BD, 2000, "mx_dmz_boss_mummy_win");
  _id_7AB5B649FA408138::_id_42A8A4F269E8483C(_id_AD4D55FD441C70BD, 2000, 1);
  wait 1;
  playsoundatpos(_id_AD4D55FD441C70BD + (0, 0, 15), "dx_br_saba_mnpc_mumy_klld");
}

_id_CDAD8A778CD06473(state) {
  if(!self getscriptablehaspart("mummy_dialog")) {
    return;
  }
  self setscriptablepartstate("mummy_dialog", state, 1);
}

_id_E2480C76160E19C0(alias) {
  if(getdvarint("dvar_CF79FC9D0EBBF2B0", 1))
    self playlocalsound(alias, undefined, undefined, 1);
  else
    self playsoundtoplayer(alias, self, self);
}

_id_470F9B78200C3AA2(soldier, player) {
  if(!isDefined(player))
    return 0;

  if(istrue(player.ignoreme))
    return 0;

  _id_B72BDF4AD529C791 = isPlayer(player);
  dist = distance(player.origin, soldier.origin);
  _id_3497D6AC3151641C = istrue(soldier.damaged);
  _id_9540D52E669B0713 = 1;
  _id_1D0DFDFEE6CACB97 = player getvelocity();
  _id_A8F6A48BE8F34C73 = length(_id_1D0DFDFEE6CACB97);

  if(_id_A8F6A48BE8F34C73 < 128)
    _id_9540D52E669B0713 = 0.75;
  else if(_id_A8F6A48BE8F34C73 < 200 || _id_B72BDF4AD529C791)
    _id_9540D52E669B0713 = 1;
  else
    _id_9540D52E669B0713 = 1.25;

  if(dist > 1500 * _id_9540D52E669B0713)
    return 0;

  _id_17BF930968A3057D = soldier cansee(player);

  if(_id_17BF930968A3057D) {
    _id_2F97851DDA9B1547 = cos(75);
    _id_5EF9B5A1FB992A8D = scripts\engine\utility::within_fov(soldier getEye(), soldier getplayerangles(1), player.origin + (0, 0, 40), _id_2F97851DDA9B1547);

    if(!_id_5EF9B5A1FB992A8D)
      return 0;

    passed = sighttracepassed(soldier getEye(), player getEye(), 0, soldier, _id_3497D6AC3151641C);

    if(!passed)
      return 0;

    contents = scripts\engine\trace::create_solid_ai_contents(1);

    if(!scripts\engine\trace::ray_trace_passed(soldier getEye(), player getEye(), soldier, contents))
      return 0;

    _id_5B94F282F7C090C5 = scripts\engine\math::get_dot(soldier.origin, anglesToForward(soldier.angles), player.origin);
    _id_9540D52E669B0713 = 1;

    if(_id_5B94F282F7C090C5 >= 0.573576)
      _id_9540D52E669B0713 = _id_9540D52E669B0713 - 0.34;

    if(_id_3497D6AC3151641C)
      _id_9540D52E669B0713 = _id_9540D52E669B0713 - 0.34;

    stance = player getstance();

    if(dist <= int(350 / _id_9540D52E669B0713)) {
      if(stance == "prone")
        return 0;

      return 1;
    } else if(dist <= int(500 / _id_9540D52E669B0713)) {
      if(stance == "prone")
        return 0;

      return 1;
    } else if(dist <= int(950 / _id_9540D52E669B0713)) {
      if(stance == "prone" || stance == "crouch")
        return 0;

      return 1;
    }
  }

  return 0;
}

_id_0851B2E528DC1087(soldier, player) {
  dist = distance(player.origin, soldier.origin);

  if(dist > 300)
    return 0;

  return 1;
}

_id_5CF40BAE64553932() {
  if(getdvarint("dvar_645824052F34C31D", 1) <= 0)
    return 0;

  if(!istrue(level._id_B72429FBCC9A3984))
    return 0;

  if(istrue(self._id_DFEEC0C82A35EE8E) || istrue(self._id_2EEE30ED130E9D4A) || self isonladder())
    return 0;

  if(istrue(self.ignoreall) || !scripts\engine\utility::ent_flag("attack_players"))
    return 0;

  if(isDefined(self.enemy) && scripts\mp\utility\player::isinlaststand(self.enemy))
    return 0;

  _id_12BFC009ADE4A833 = getdvarfloat("dvar_D4AA9AA7E7A65E87", 0.0);

  if(isDefined(self.enemy) && isPlayer(self.enemy) && _id_12BFC009ADE4A833 > 0) {
    if(isDefined(self.enemy.armorhealth) && isDefined(self.enemy._id_8790C077C95DB752)) {
      if(self.enemy._id_8790C077C95DB752 > 0) {
        _id_3777ECE6A73EADA5 = self.enemy.armorhealth / self.enemy._id_8790C077C95DB752;

        if(_id_3777ECE6A73EADA5 <= _id_12BFC009ADE4A833)
          return 0;
      }
    }
  }

  _id_AD3D762F59E04244 = level._id_8E3A5A3223D8DB16._id_E2958F412A7425C0;
  target = scripts\engine\utility::getclosest(_id_AD3D762F59E04244.origin, level.players);
  _id_636C8575D7A7768B = 200;

  if(isDefined(target) && isalive(target) && distance(_id_AD3D762F59E04244.origin, target.origin) > _id_636C8575D7A7768B)
    return 0;

  if(isDefined(target) && isalive(target) && isDefined(target._id_DE9D369DE44F1953) && gettime() - target._id_DE9D369DE44F1953 < level._id_CFB2E3977FD1BF2C)
    return 0;

  cooldown = 15;

  if(getdvarint("dvar_8EA79DE3D22ABFF2", cooldown) != cooldown)
    cooldown = getdvarint("dvar_8EA79DE3D22ABFF2", cooldown);

  if(isDefined(level._id_83541BF6C78C7E34)) {
    if(scripts\engine\utility::time_has_passed(level._id_83541BF6C78C7E34, cooldown))
      return 1;
    else
      return 0;
  }

  return 1;
}

_id_AC35FCECF711E5DA() {
  self.invulnerable = 1;

  if(isDefined(self.enemy)) {
    self._id_87C24994537457E1 = self.enemy;
    self.enemy.ignoreme = 1;
  }
}

_id_113CAF6420815BCF() {
  self.invulnerable = 0;
  thread _id_B9D4306B4408A6A0(1);

  if(isDefined(self._id_87C24994537457E1)) {
    _id_77FEF924ECDEFC3F = getclosestpointonnavmesh(self._id_87C24994537457E1.origin);

    if(isDefined(_id_77FEF924ECDEFC3F))
      self._id_87C24994537457E1 setOrigin(_id_77FEF924ECDEFC3F);

    self._id_87C24994537457E1.ignoreme = 0;
    self._id_87C24994537457E1 = undefined;
  }
}

_id_51C916963695DFAD() {
  self notify("mummy_checkIsExecuting");
  self endon("mummy_checkIsExecuting");
  self endon("death");

  for(;;) {
    if(self isinexecutionattack())
      level._id_83541BF6C78C7E34 = gettime();

    wait 0.5;
  }
}

_id_2CFB88AF9245875C() {
  if(!isDefined(level._id_8E3A5A3223D8DB16) || !isDefined(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7))
    return 0;

  return distance(self.origin, level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7.origin);
}

_id_163D0BCA557858DA() {
  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    return _id_1187F1CE131E4CE5();
  else {
    _id_EFCAE04A8B892D80 = _id_2695A20D4011076D::_id_024C5A8D31AE262F(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7.origin);

    if(_id_EFCAE04A8B892D80)
      return 0;

    _id_E9B24366A2A35636 = _id_2695A20D4011076D::getmintimetillpointindangercircle(level._id_8E3A5A3223D8DB16._id_44E60D99B00BDED7.origin);
    return _id_E9B24366A2A35636 < 30;
  }
}

_id_1187F1CE131E4CE5() {
  if(!isDefined(level.br_armory_kiosk) || !isDefined(level.br_armory_kiosk.scriptables) || level.br_armory_kiosk.scriptables.size == 0)
    return 0;

  _id_CED8A1F62AE2956B = [];

  foreach(_id_15B89FF206500554 in level.br_armory_kiosk.scriptables) {
    if(!istrue(_id_15B89FF206500554.disabled))
      _id_CED8A1F62AE2956B[_id_CED8A1F62AE2956B.size] = _id_15B89FF206500554;
  }

  _id_1D1479E278AB33DB = scripts\engine\utility::getclosest(self.origin, _id_CED8A1F62AE2956B);
  _id_E49E38042DCBDD76 = distance(self.origin, _id_1D1479E278AB33DB.origin) < 1500;
  return _id_E49E38042DCBDD76;
}

_id_C8DE71E5D197129B() {
  if(istrue(self._id_E7AF56A2DF18030D) || istrue(self.extracted))
    return 0;

  return !isDefined(self._id_1CDC49D6FD0BD5A5) || scripts\engine\utility::time_has_passed(self._id_1CDC49D6FD0BD5A5, 7);
}

_id_45437518D020306C(org, array, maxdist) {
  if(!isDefined(maxdist))
    maxdist = 500000;

  dist = 0;
  ent = undefined;

  foreach(item in array) {
    _id_5C1EE5AB8012EA11 = distance(item.origin, org);

    if(_id_5C1EE5AB8012EA11 <= dist || _id_5C1EE5AB8012EA11 >= maxdist) {
      continue;
    }
    dist = _id_5C1EE5AB8012EA11;
    ent = item;
  }

  return ent;
}

_id_A1B92CA3EFE65027(data) {
  if(isDefined(level._id_796BCFECDCC6BDF8))
    dlog_recordevent("dlog_event_haunting_oasis", ["number_of_skulls_depositied", level._id_796BCFECDCC6BDF8._id_9331B22CA6C15966, "number_of_skulls_sold", level._id_796BCFECDCC6BDF8._id_68623CDF221D38F5, "number_of_skulls_exfiled", level._id_796BCFECDCC6BDF8._id_1AE013F9F46FF5F4]);
}