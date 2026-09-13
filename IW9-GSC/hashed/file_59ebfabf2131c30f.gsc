/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_59ebfabf2131c30f.gsc
***********************************************/

_id_6FBDD8615F9428B6() {
  if(getdvarint("dvar_6C48003930D2725C", 1) > 0)
    return 1;

  return 0;
}

_id_89D2C891548875FD() {
  level._effect["vfx_hween_butcher_roar"] = loadfx("vfx/iw9/executions/vfx_hween_butcher_roar.vfx");
  level._effect["vfx_hween_butcher_slam"] = loadfx("vfx/iw9/level/mp_saba/season6/hween/Butcher/vfx_hween_butcher_slam.vfx");
  level._effect["vfx_hween_butcher_grnd_pantagram"] = loadfx("vfx/iw9/level/mp_saba/season6/hween/Butcher/vfx_hween_butcher_grnd_pantagram.vfx");
}

_id_0007510DB499B9CB(_id_AED74300DAF62896) {
  if(scripts\engine\utility::flag_exist("boss_butcher_init")) {
    return;
  }
  scripts\engine\utility::flag_init("boss_butcher_init");
  level._id_DF7BB2103A91DF49 = getdvarint("dvar_FEA0F83AD90CDC6A", 30) * 1000;
  level._id_4486483D1F534AB5 = int(level._id_DF7BB2103A91DF49 * 0.4);
  _id_AED74300DAF62896._id_BFE291B401A9BF2A = [];

  if(!isDefined(getdvarfloat("dvar_AAA1F671C868B5FA")))
    setDvar("dvar_AAA1F671C868B5FA", 0.02);

  if(!isDefined(level.struct_class_names) || !isDefined(level.struct_class_names["script_noteworthy"])) {
    return;
  }
  if(!isDefined(level.struct_class_names["script_noteworthy"]["boss_butcher"])) {
    return;
  }
  foreach(node in level.struct_class_names["script_noteworthy"]["boss_butcher"])
  _id_AED74300DAF62896._id_BFE291B401A9BF2A[_id_AED74300DAF62896._id_BFE291B401A9BF2A.size] = node;
}

_id_322482F38CB4A256() {
  level thread _id_678541A6BE39AAF4();
}

_id_C3D723A43ACE2916() {
  level endon("game_ended");
  _id_4DDC095EC77D4BEC::_id_3406446981D65075();
  _id_633854BDBF5472F4::_id_FA8DDEAA2A6BB272();
  createthreatbiasgroup("butcher_enemies");
  level waittill("prematch_started");
  _id_6D16A1F2F1E32453();
  gametype = scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5();

  if(gametype != "dmz") {
    _id_784C8FB1713EE2E8::_id_47BD9E7F3C47BDF8();
    _id_322482F38CB4A256();
  } else if(gametype == "dmz")
    _id_00E246AFBD6ABD13::_id_47BD9E7F3C47BDF8();

  level thread _id_30986513D6D6877A::_id_C4D89B1AABFD3516();
}

_id_91182B18FE6CD5BE(_id_E60552DD6ABCC4AA) {
  level endon("game_ended");
  level._id_49D407295B31E357._id_D8BD03B318CB8767 = _id_E60552DD6ABCC4AA;

  if(!_id_E60552DD6ABCC4AA) {
    _id_A84DE252D1CE9F25();
    _id_30986513D6D6877A::_id_49DFCC9932C8570E();
  }

  return level._id_49D407295B31E357._id_D8BD03B318CB8767;
}

_id_6D69350C86BAF67B(_id_58C817414D96DE59, _id_4DDD755385BF05CF) {
  aitype = "enemy_mp_boss_butcher";
  _id_E2958F412A7425C0 = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_58C817414D96DE59.origin, _id_58C817414D96DE59.angles, "absolute", "bosses", "butcherBoss", undefined, undefined, undefined, "bossArea", 1, 0, 0);
  _id_E2958F412A7425C0 thread _id_30986513D6D6877A::_id_CE893CBCBA60CAAE();
  _id_019D65E3097CBC8C(_id_E2958F412A7425C0);

  if(!isDefined(_id_E2958F412A7425C0)) {
    return;
  }
  _id_E2958F412A7425C0._id_B582B10663B5B2A9 = 0;
  _id_E2958F412A7425C0.ignoreall = 0;
  _id_E2958F412A7425C0.dontevershoot = 1;
  _id_E2958F412A7425C0.invulnerable = 0;
  _id_E2958F412A7425C0.speedscalemult = 0.7;
  _id_E2958F412A7425C0._id_A4738C70736D3A61 = ::_id_F8E1DF4D0E2286F4;
  _id_E2958F412A7425C0 scripts\engine\utility::ent_flag_init("attack_players");
  _id_63B36051424E70EC(_id_E2958F412A7425C0);
  _id_A0E8AB08D64A52CC = getdvarint("dvar_7167E7C732B1CCB7", 120);
  _id_E2958F412A7425C0.meleerangesq = _id_A0E8AB08D64A52CC * _id_A0E8AB08D64A52CC;
  _id_E2958F412A7425C0.disabledodge = 1;
  _id_E2958F412A7425C0._id_B3FA6C20CA52B960 = 0;
  _id_E2958F412A7425C0._id_CD251FBF5563EB4A = 0;
  _id_E2958F412A7425C0._id_F44C9CEDE4FB20D6 = 1;
  _id_E2958F412A7425C0.meleechargedistvsplayer = getdvarint("dvar_47BAB758E26DF6B7", 150);
  _id_E2958F412A7425C0._id_E0C57AF70D480252 = 1;
  _id_E2958F412A7425C0._id_384C9CC6CD2605D0 = 1;
  _id_E2958F412A7425C0.pathenemyfightdist = 0;
  _id_E2958F412A7425C0.allowstrafe = 0;
  _id_E2958F412A7425C0.meleemaxzdiff = 100;
  _id_E2958F412A7425C0.meleeignoreplayerstance = 1;
  _id_3188E119DCAD9617 = getdvarint("dvar_D87AAD22263F1835", 150);
  _id_E2958F412A7425C0.meleestopattackdistsq = _id_3188E119DCAD9617 * _id_3188E119DCAD9617;
  _id_F10569B9FA122F4B = getdvarint("dvar_515BC1B642EA5E4F", 200);
  _id_E2958F412A7425C0._id_8F438EA9E6AE83A2 = _id_F10569B9FA122F4B * _id_F10569B9FA122F4B;
  _id_DB82AFE69BDEBDD1 = getdvarint("dvar_437212A79AF2D72B", 120);
  _id_E2958F412A7425C0.meleebashmaxdistsq = _id_DB82AFE69BDEBDD1 * _id_DB82AFE69BDEBDD1;
  _id_E2958F412A7425C0.meleetryhard = 1;
  _id_E2958F412A7425C0 setengagementmaxdist(0.1, 768.0);
  _id_E2958F412A7425C0 _meth_4CA9518DC8BEF142("all", 0);
  _id_E2958F412A7425C0.ignoreme = 1;
  _id_E2958F412A7425C0._id_8FD71E47F0BFAFC4 = 1;
  _id_E2958F412A7425C0._id_09584776529FB7F6 = "execution_boss_butcher_00";
  _id_E2958F412A7425C0 scripts\cp_mp\execution::_giveexecution(_id_E2958F412A7425C0._id_09584776529FB7F6);
  _id_E2958F412A7425C0._id_2D8D11A34BE5B244 = ::_id_037DA92CF9ACD9F6;
  _id_E2958F412A7425C0._id_922C14FABBF684D5 = ::_id_2D8D1B02489A2BE7;
  _id_E2958F412A7425C0._id_CDBC6EE27C5C2856 = ::_id_582458544998EA8C;
  _id_E2958F412A7425C0._id_83600C3F18318D98 = ::_id_99550213A19278B0;
  _id_E2958F412A7425C0._id_1449B46EDCCF92ED = ::_id_1C7F23417414BC39;
  _id_E2958F412A7425C0 _meth_7E763899297EC59C(0);
  _id_E2958F412A7425C0._id_3119604B74DFDBBD = 0;
  _id_E2958F412A7425C0.pushable = 0;
  _id_E2958F412A7425C0._id_DF41B7F76F62D9A2 = 0;
  _id_E2958F412A7425C0._id_274D3A7704E351EF = 1;
  _id_E2958F412A7425C0._id_98E373D243C1936F = 1;
  _id_E2958F412A7425C0._id_8392C47BCDD3138A = 0.0;
  _id_E2958F412A7425C0 attach("mp_butcher_iw9_1_1_weapon_cleaver", "tag_accessory_right");
  _id_E2958F412A7425C0 attach("mp_butcher_iw9_1_1_weapon_sickle", "tag_accessory_left");
  _id_7CA25CAEA50CBC7D = getdvarfloat("dvar_B2B82FF812A9E6FE", 1.0);
  _id_F74F4B3CB77E27C3 = getdvarfloat("dvar_58EAD4934366A659", 5.0);
  _id_88A88A218B58EE09 = getdvarint("dvar_F3BF7AEAEF0910A4", 0);

  if(!_id_55E395B5A89CC532::_id_1BE5E0D403A7EDDC("butcher_area_damage")) {
    _id_BD4D15324FD72298 = _id_58C817414D96DE59.origin + (0, 0, -100);
    _id_55E395B5A89CC532::_id_DA643EDBADA6B491("butcher_area_damage", _id_BD4D15324FD72298, 3000, 600, "Butcher_Level_Damage", -1.0, _id_7CA25CAEA50CBC7D, _id_F74F4B3CB77E27C3, 0, 1, 0, 1, _id_88A88A218B58EE09, 1);
    _id_55E395B5A89CC532::_id_364ADECE553CCB86("butcher_area_damage", "vfx_dmz_butcher_radiation", "gas", "active");
    _id_26B3FDFF79D6B1D3 = spawn("noent_volume_trigger_radius", _id_BD4D15324FD72298, 0, 3000, 600);
    _id_58C817414D96DE59.trigger = _id_26B3FDFF79D6B1D3;
    scripts\mp\utility\trigger::makeenterexittrigger(_id_58C817414D96DE59.trigger, ::_id_21EC99A5E3F1869C, ::_id_9AD925769676C9AA);
    self._id_8D7456489F9A1FFC = getdvarfloat("dvar_B2B82FF812A9E6FE", 1.0);
    self._id_FF5ACF6010B74CC8 = getdvarfloat("dvar_58EAD4934366A659", 5.0);
  }

  _id_E2958F412A7425C0 setscriptablepartstate("butcher_glow", "active", 0);
  _id_E2958F412A7425C0 setscriptablepartstate("butcher_eyes", "active", 0);
  _id_E2958F412A7425C0 setscriptablepartstate("butcher_hook", "active", 0);
  _id_E2958F412A7425C0 thread _id_7C8F1CCFCCA56715();
  _id_E2958F412A7425C0 thread _id_D9CDC5157204CF00();
  _id_E2958F412A7425C0 thread _id_4D0D764C1ABAC155();
  _id_E2958F412A7425C0.fnasm_handlenotetrack = ::_id_4EEF3D865BDD8991;
  return _id_E2958F412A7425C0;
}

_id_CF18FCB411DB697F() {
  self endon("death");
  self endon("recieved_damage");
  self endon("new_cheese_thread");
  level endon("disconnect");
  _id_F230680AF21A2A1D = getdvarint("dvar_632A065E41111276", 35);

  for(;;) {
    wait(_id_F230680AF21A2A1D);

    if(isDefined(level._id_49D407295B31E357._id_FCD0365F5A9FB237) && level._id_49D407295B31E357._id_FCD0365F5A9FB237.size > 0)
      _id_5B01E0CD91DC5D3E();
  }
}

_id_4EEF3D865BDD8991(_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978) {
  _id_A18C779A48D376F8 = issubstr(_id_A234A65C378F3289, "footstep");

  if(_id_A18C779A48D376F8)
    self playSound("iw9_haunting_butcher_step_light");

  _id_4F57E90811AA8900::handlenotetrack(_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978);
}

_id_21EC99A5E3F1869C(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }
  if(!istrue(player._id_E6204058F06B94E5)) {
    player notify("enter_butcher_dungeon");
    _id_E2958F412A7425C0 = undefined;

    if(isDefined(level._id_16E11016257D52E2))
      _id_E2958F412A7425C0 = level._id_16E11016257D52E2._id_E2958F412A7425C0;

    if(!isDefined(level._id_49D407295B31E357._id_FCD0365F5A9FB237[player.guid]))
      level._id_49D407295B31E357._id_FCD0365F5A9FB237[player.guid] = player;

    if(isDefined(_id_E2958F412A7425C0)) {
      _id_E2958F412A7425C0 notify("new_cheese_thread");
      _id_E2958F412A7425C0 thread _id_CF18FCB411DB697F();
    }

    scripts\mp\outofbounds::clearoob(player);
    scripts\mp\outofbounds::enableoobimmunity(player);

    if(!player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
      player _id_67708F418B1FAC79::setplayeringulagjailextrainfo(1);

    level notify("update_circle_hide");
    player setclientomnvar("ui_hide_compass", 1);

    if(getdvarint("dvar_133827C2C0FD1C24", 1) == 1 && isDefined(_id_E2958F412A7425C0))
      player setclientomnvar("ui_butcher_boss_health_enabled", 1);

    player._id_E6204058F06B94E5 = 1;
    player _id_FAD864200BB1A414(0);
    _id_30986513D6D6877A::_id_09772E6CDFE8BB54(player);
    _id_4F22298ED4AA65FF(player, istrue(player._id_E6204058F06B94E5));
    _id_0330A38452DFE6B6(player);
    player thread _id_A67E74148D679AFC();

    if(!istrue(player._id_2DF3E475716D82B0)) {
      wait 2;
      _id_D224642D94E07B6E = getdvarint("dvar_5F9787B2A0E89680", 250);

      if(isDefined(_id_E2958F412A7425C0) && _id_E2958F412A7425C0.health > _id_D224642D94E07B6E) {
        _id_E2958F412A7425C0 playsoundtoplayer("dx_br_saba_actn_butc_frmt", player, _id_E2958F412A7425C0);
        player._id_2DF3E475716D82B0 = 1;
      }
    }
  }
}

_id_9AD925769676C9AA(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }
  if(istrue(player._id_E6204058F06B94E5)) {
    level notify("update_circle_hide");
    player._id_E6204058F06B94E5 = 0;

    if(!player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
      player _id_67708F418B1FAC79::setplayeringulagjailextrainfo(0);

    if(isDefined(player.oobimmunity))
      scripts\mp\outofbounds::disableoobimmunity(player);

    if(getdvarint("dvar_133827C2C0FD1C24", 1) == 1) {
      player._id_7E7B22FC341D740B = 0;
      player setclientomnvar("ui_butcher_boss_health_enabled", 0);
    }

    player setclientomnvar("ui_hide_compass", 0);
    level._id_49D407295B31E357._id_FCD0365F5A9FB237[player.guid] = undefined;
    player _id_FAD864200BB1A414(1);
    _id_0330A38452DFE6B6(player);
    _id_4F22298ED4AA65FF(player, istrue(player._id_E6204058F06B94E5));
    player notify("exit_butcher_dungeon");
  }
}

_id_7C8F1CCFCCA56715() {
  level endon("game_ended");
  self waittill("death");
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("splash_haunting_butcher_killed", level.players);
  level thread _id_2FDEB8023287BE67::_id_3E409004EDF37731("butcher");
  _id_9DC2394FEE4A29EA = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "haunting_attackers");

  if(isDefined(_id_9DC2394FEE4A29EA))
    _id_F14BCB2F51EBE26D(_id_9DC2394FEE4A29EA.attackers);

  foreach(player in level._id_49D407295B31E357._id_FCD0365F5A9FB237) {
    if(getdvarint("dvar_133827C2C0FD1C24", 1) == 1) {
      if(!isDefined(player)) {
        continue;
      }
      player._id_7E7B22FC341D740B = 0;
      player setclientomnvar("ui_butcher_boss_health_enabled", 0);
      player setclientomnvar("ui_butcher_boss_health", 0);
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("splash_haunting_diablo_cross_promo", [player]);
      player setplayermusicstate("mx_dmz_boss_butcher_win");
      player.nosuspensemusic = undefined;
    }
  }

  level._id_16E11016257D52E2._id_E2958F412A7425C0 = undefined;
  wait 0.5;
  level thread _id_A84DE252D1CE9F25();
}

_id_A84DE252D1CE9F25() {
  level endon("game_ended");
  level endon("butcher_boss_reset");
  _id_979E8C24C9DEAB58 = getdvarfloat("dvar_2E33E91CB69173C0", 10);
  _id_6A1C9246E7158B79 = getdvarfloat("dvar_29528244EA6E6200", 0.7);
  _id_F552AC3040296D52 = getdvarfloat("dvar_34E176C4C7A324F4", 15);
  _id_7788503D058DDF93 = getdvarfloat("dvar_60D96586AFAFDE27", 30);
  _id_8D7456489F9A1FFC = level._id_16E11016257D52E2._id_8D7456489F9A1FFC;
  _id_FF5ACF6010B74CC8 = level._id_16E11016257D52E2._id_FF5ACF6010B74CC8;
  _id_00FB8ECF63AEED59 = 100;
  _id_D8212E54401E8495 = 1.5;
  _id_3AD2CA3D287D2223 = getdvarint("dvar_6D184110809E70B6", 1);
  wait(_id_7788503D058DDF93);

  while(_id_8D7456489F9A1FFC < _id_00FB8ECF63AEED59 || _id_FF5ACF6010B74CC8 > _id_D8212E54401E8495) {
    foreach(player in level._id_49D407295B31E357._id_FCD0365F5A9FB237) {
      if(istrue(_id_3AD2CA3D287D2223)) {
        player setclienttriggeraudiozone("saba_butcher_arena_heat", 2);
        _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("splash_haunting_butcher_hell_heating", [player]);
      }
    }

    _id_8D7456489F9A1FFC = clamp(_id_8D7456489F9A1FFC + _id_979E8C24C9DEAB58, 0.0, _id_00FB8ECF63AEED59);
    _id_55E395B5A89CC532::_id_1C436B0944DB5FDF("butcher_area_damage", _id_8D7456489F9A1FFC);
    _id_FF5ACF6010B74CC8 = clamp(_id_FF5ACF6010B74CC8 - _id_6A1C9246E7158B79, _id_D8212E54401E8495, 999999.0);
    _id_55E395B5A89CC532::_id_661C9A3EA014D8F0("butcher_area_damage", _id_FF5ACF6010B74CC8);
    wait(_id_F552AC3040296D52);
  }
}

_id_5B01E0CD91DC5D3E() {
  _id_979E8C24C9DEAB58 = getdvarfloat("dvar_2E33E91CB69173C0", 10);
  _id_6A1C9246E7158B79 = getdvarfloat("dvar_29528244EA6E6200", 0.7);
  _id_8D7456489F9A1FFC = level._id_16E11016257D52E2._id_8D7456489F9A1FFC;
  _id_FF5ACF6010B74CC8 = level._id_16E11016257D52E2._id_FF5ACF6010B74CC8;
  _id_00FB8ECF63AEED59 = 100;
  _id_D8212E54401E8495 = 1.5;
  _id_3AD2CA3D287D2223 = getdvarint("dvar_6D184110809E70B6", 1);

  if(_id_8D7456489F9A1FFC < _id_00FB8ECF63AEED59 || _id_FF5ACF6010B74CC8 > _id_D8212E54401E8495) {
    foreach(player in level._id_49D407295B31E357._id_FCD0365F5A9FB237) {
      if(istrue(_id_3AD2CA3D287D2223)) {
        player setclienttriggeraudiozone("saba_butcher_arena_heat", 2);
        _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("splash_haunting_butcher_hell_heating", [player]);
      }
    }

    _id_8D7456489F9A1FFC = clamp(_id_8D7456489F9A1FFC + _id_979E8C24C9DEAB58, 0.0, _id_00FB8ECF63AEED59);
    _id_55E395B5A89CC532::_id_1C436B0944DB5FDF("butcher_area_damage", _id_8D7456489F9A1FFC);
    level._id_16E11016257D52E2._id_8D7456489F9A1FFC = _id_8D7456489F9A1FFC;
    _id_FF5ACF6010B74CC8 = clamp(_id_FF5ACF6010B74CC8 - _id_6A1C9246E7158B79, _id_D8212E54401E8495, 999999.0);
    _id_55E395B5A89CC532::_id_661C9A3EA014D8F0("butcher_area_damage", _id_FF5ACF6010B74CC8);
    level._id_16E11016257D52E2._id_FF5ACF6010B74CC8 = _id_FF5ACF6010B74CC8;
  }
}

_id_0330A38452DFE6B6(player) {
  if(!isDefined(player)) {
    return;
  }
  if(istrue(player._id_E6204058F06B94E5)) {
    if(getdvarint("dvar_B3422AD4BDC1AD75", 1) && !istrue(player._id_FB060ED2A152AF79)) {
      player setclientomnvar("ui_jammer_strength", 1);
      player._id_FB060ED2A152AF79 = 1;
    }

    if(getdvarint("dvar_EE7A6594E8553168", 1) && !istrue(player._id_1B82E949A4331EF1)) {
      player setclientomnvar("ui_hide_minimap", 1);
      player._id_1B82E949A4331EF1 = 1;
    }
  } else if(!istrue(player._id_E6204058F06B94E5)) {
    if(getdvarint("dvar_B3422AD4BDC1AD75", 1) && istrue(player._id_FB060ED2A152AF79)) {
      player setclientomnvar("ui_jammer_strength", 0);
      player._id_FB060ED2A152AF79 = 0;
    }

    if(getdvarint("dvar_EE7A6594E8553168", 1) && istrue(player._id_1B82E949A4331EF1)) {
      player setclientomnvar("ui_hide_minimap", 0);
      player._id_1B82E949A4331EF1 = 0;
    }
  }
}

_id_4F22298ED4AA65FF(player, _id_2233081D33932640) {
  _id_607DA387F3617ED1 = level.teamdata[player.team]["players"];

  if(isDefined(level.squaddata) && isDefined(level.squaddata[player.team]) && isDefined(level.squaddata[player.team][player._id_0FF97225579DE16A]))
    _id_607DA387F3617ED1 = level.squaddata[player.team][player._id_0FF97225579DE16A].players;

  foreach(_id_89C718895A5117B3 in _id_607DA387F3617ED1) {
    if(isDefined(_id_89C718895A5117B3))
      _id_89C718895A5117B3 setclientomnvar("ui_in_butcher_dungeon_" + player._id_3F78C6A0862F9E25, _id_2233081D33932640);
  }

  level thread _id_2CE67B8EB281CDD1(player);
}

_id_2CE67B8EB281CDD1(player) {
  level endon("game_ended");
  player endon("disconnect");
  player setclientomnvar("ui_force_update_last_stand", 1);
  waitframe();
  player setclientomnvar("ui_force_update_last_stand", 0);
}

_id_A67E74148D679AFC() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("enter_butcher_dungeon");
  self endon("exit_butcher_dungeon");

  while(isDefined(level._id_16E11016257D52E2) && isDefined(level._id_16E11016257D52E2._id_E2958F412A7425C0)) {
    if(isDefined(level._id_16E11016257D52E2._id_E2958F412A7425C0.health) && isDefined(level._id_16E11016257D52E2._id_E2958F412A7425C0.maxhealth)) {
      _id_E592B9BE13FCF611 = scripts\mp\utility\script::limitdecimalplaces(clamp(level._id_16E11016257D52E2._id_E2958F412A7425C0.health / level._id_16E11016257D52E2._id_E2958F412A7425C0.maxhealth, 0.0, 1.0), 3);
      self setclientomnvar("ui_butcher_boss_health", _id_E592B9BE13FCF611);
    } else {
      self setclientomnvar("ui_butcher_boss_health", 0);
      return;
    }

    waitframe();
  }
}

_id_63B36051424E70EC(agent) {
  if(!isDefined(agent)) {
    return;
  }
  _id_A664AAD02EE98BD2 = "gas_mp";
  grenadeammo = getdvarint("dvar_537FA443CE212A8A", 12);
  weapon = undefined;
  armor = 0;
  helmet = 0;
  agent._id_668B72F41E87C75A = 1;
  agent.health = 50000;

  if(getdvarint("dvar_0DC0E2A6A0334885", 0) > 0)
    agent.health = 2000;

  agent.maxhealth = agent.health;
  agent._id_D38FB77455B25729 = 4000;
  agent._id_BA2F6374446E1525 = 0;
  agent._id_E6AF4BA7CF5CC852 = 0;
  agent._id_62482B4F67666074 = 10000;
  agent._id_A7AAE99DA4C9E990 = 60000;
  agent._id_65771500F49956C1 = 1;
  agent.badplaceawareness = 0;
  agent.agentname = &"MP/BUTCHER_BOSS";
  agent.stage = 1;
  agent._id_2808079B46AE6650 = 3000;
  agent._id_7528BDD4F8EA8811 = 0;
  agent._id_0A83B580F45A7120 = 20000;
  agent._id_0D42CFFB8DAA15E0 = 1;
  agent.a.disablepain = 1;
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "overrideLoot", 1);
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropRadio", 0);
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropKey", 0);
  agent.baseaccuracy = getdvarfloat("dvar_298D4EA8B0934E31", 1.2);
  headmodel = "head_mp_butcher_test_iw9_1_1";
  headmodel = undefined;
  bodymodel = "body_mp_butcher_test_iw9_1_1";
  bodymodel = undefined;
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(bodymodel, headmodel, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet, 1);
  agent _id_2FDEB8023287BE67::_id_720C3B7ABF4BAAC8("butcher", 0, undefined);
  agent.fnasm_handlenotetrack = ::_id_4EEF3D865BDD8991;
  agent setthreatbiasgroup("butcher_enemies");
  setignoremegroup("Lethal_Static", "butcher_enemies");
}

_id_6D16A1F2F1E32453() {
  level._id_3EE2767CBB701B58 = [];
  level._id_D0DBF9BF852DD46C = [];
  level._id_D5C5B96C29B5C567 = [];

  if(scripts\mp\utility\game::getsubgametype() != "zxp") {
    level._id_1FA2A6B50267656A = ::_id_46B4BD6590584475;
    _id_362C58E8BB39BCDA::registerbrgametypefunc("modifyVehicleDamage", _id_0F820C96419FE887::modifyvehicledamage);
    level.brgametype.zombienumhitsheli = getdvarfloat("dvar_8D24CF268D991C83", 2);
    level.brgametype.zombienumhitsatv = getdvarfloat("dvar_AFB1F56AC422F668", 2);
    level.brgametype.zombienumhitscar = getdvarfloat("dvar_9162A16AAD712F5B", 3);
    level.brgametype.zombienumhitstruck = getdvarfloat("dvar_5552790671B23F3E", 4);
  }
}

_id_C48BC2EFBD1CE08A(spawnpoint, _id_A225843AB49856BC, _id_F9CBFF5134DA960B) {
  spawnorigin = (0, 0, 0);

  if(isDefined(_id_F9CBFF5134DA960B))
    spawnorigin = _id_F9CBFF5134DA960B;
  else
    spawnorigin = spawnpoint.origin;

  spawnorigin = scripts\engine\utility::drop_to_ground(spawnorigin, 20, -150, (0, 0, 1));
  _id_3138C7EBA9B7AA1F = _id_4DDC095EC77D4BEC::_id_BC39F450BA654089(spawnorigin, spawnpoint.angles, "enemy_lw_zombie_default", "base", undefined, "spawn_ground", "bossArea");

  if(!isDefined(_id_3138C7EBA9B7AA1F)) {
    return;
  }
  _id_32051B37CAF754B3(_id_3138C7EBA9B7AA1F);

  if(istrue(_id_A225843AB49856BC)) {
    _id_3138C7EBA9B7AA1F._id_2964A6C155E309F9 = 1;
    _id_3138C7EBA9B7AA1F.ignoreme = 1;
    _id_3138C7EBA9B7AA1F thread _id_2A4563CF9FF0BDC4();

    if(!isDefined(level._id_D0DBF9BF852DD46C))
      level._id_D0DBF9BF852DD46C = [];

    level._id_D0DBF9BF852DD46C[level._id_D0DBF9BF852DD46C.size] = _id_3138C7EBA9B7AA1F;
  } else {
    if(!isDefined(level._id_D5C5B96C29B5C567))
      level._id_D5C5B96C29B5C567 = [];

    level._id_D5C5B96C29B5C567[level._id_D5C5B96C29B5C567.size] = _id_3138C7EBA9B7AA1F;

    if(level._id_D5C5B96C29B5C567.size > 15)
      _id_3138C7EBA9B7AA1F thread _id_210B92F05995A998();
  }

  if(!isDefined(level._id_3EE2767CBB701B58))
    level._id_3EE2767CBB701B58 = [];

  level._id_3EE2767CBB701B58[level._id_3EE2767CBB701B58.size] = _id_3138C7EBA9B7AA1F;
  return _id_3138C7EBA9B7AA1F;
}

_id_210B92F05995A998() {
  self endon("death");
  level waittill("butcher_portal_opened");
  _id_7D76146D9EBE74F9 = getdvarint("dvar_ADEFD3CF436C3350", 25) * 2 + randomintrange(0, 8);
  wait(_id_7D76146D9EBE74F9);
  self dodamage(self.maxhealth, self.origin);
}

_id_2A4563CF9FF0BDC4() {
  self endon("death");
  time = 0;

  for(;;) {
    wait(time);
    _id_CAB8FC67DCF2FB87 = randomintrange(0, 3);

    if(isDefined(self) && isDefined(self.origin)) {
      switch (_id_CAB8FC67DCF2FB87) {
        case 0:
          _id_0A662F25DBF78119::_id_E8F9A124778CC606(0);
          time = randomintrange(getdvarint("dvar_72D807A595E514D4", 6), getdvarint("dvar_9B0AD3A96B519512", 9));
          break;
        case 1:
          _id_0A662F25DBF78119::_id_E8F9A124778CC606(1);
          time = randomintrange(getdvarint("dvar_A2D301090602C454", 3), getdvarint("dvar_E69ADD0132E571FE", 6));
          break;
        case 2:
          _id_0A662F25DBF78119::_id_E8F9A124778CC606(2);
          time = randomintrange(getdvarint("dvar_043EA4D683AE0836", 9), getdvarint("dvar_469E595C2FCA2114", 12));
          break;
      }
    }
  }
}

_id_6C6874289D5500BF(agent) {
  _id_EEEBD7263F6EF4FF = 1;
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_74B0328B6595AF05 = [];
  _id_8B028DB4079A8DD8 = getdvarfloat("dvar_1FE84D951B980F73", 0.6);
  _id_C9CEA96AA090B039 = randomfloatrange(0, 1);

  if(_id_C9CEA96AA090B039 <= _id_8B028DB4079A8DD8) {
    _id_C9CEA96AA090B039 = randomfloatrange(0, 1);
    _id_7CD1BEB5D334A96F = getdvarfloat("dvar_E479F4E006B48394", 0.1);

    if(_id_C9CEA96AA090B039 <= _id_7CD1BEB5D334A96F)
      _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, "brloot_health_adrenaline");

    if(scripts\mp\utility\game::getsubgametype() != "dmz") {
      _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, _id_A475CC06CA1CD2A1());
      _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, "brloot_armor_plate");
    } else {
      _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, _id_A475CC06CA1CD2A1());
      _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, "brloot_armor_plate");
    }

    foreach(_id_62E76947E5C708AD in _id_74B0328B6595AF05) {
      count = 1;

      switch (_id_62E76947E5C708AD) {
        case "brloot_ammo_50cal":
        case "brloot_ammo_12g":
          count = 16;
          break;
        case "brloot_ammo_919":
        case "brloot_ammo_762":
          count = 60;
          break;
      }

      _id_48814951E916AF89::_id_63A043D47490F90D(agent, _id_62E76947E5C708AD, undefined, 1, count);
    }
  }
}

_id_32051B37CAF754B3(agent) {
  if(!isDefined(agent)) {
    return;
  }
  weapon = undefined;
  armor = 0;
  helmet = 0;
  agent._id_668B72F41E87C75A = 1;
  agent.health = 250;
  agent._id_D38FB77455B25729 = 0;
  agent._id_BA2F6374446E1525 = 0;
  agent._id_E6AF4BA7CF5CC852 = 0;
  agent._id_62482B4F67666074 = 10000;
  agent._id_A7AAE99DA4C9E990 = 60000;
  agent._id_65771500F49956C1 = 1;
  agent.badplaceawareness = 0;
  agent._id_B89B3ADA2D19BE6C = 1;
  agent._id_06F0B4FE6DA4A0F8 = 1;
  agent.agentname = &"MP/BUTCHER_MINION";
  agent._id_B582B10663B5B2A9 = 0;
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "overrideLoot", 1);
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropGrenade", 0);
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropArmor", 0);
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropWeapon", 0);
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropBackpack", 0);
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropRadio", 0);
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropAmmo", 0);
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropKey", 0);
  _id_6C6874289D5500BF(agent);
  agent._id_0D42CFFB8DAA15E0 = 1;
  agent.entered_playspace = 1;

  if(getdvarint("dvar_62A0AB47E683702A", 1) == 1) {
    if(!istrue(level._id_D52249FB68FBD070)) {
      _id_07D70B8494B82DD0 = 0.03;
      _id_714A984CFED0FE23 = 0.15;

      if(!isDefined(level._id_6CD6EF3DFBD41278))
        level._id_6CD6EF3DFBD41278 = 0.8;
      else {
        level._id_6CD6EF3DFBD41278 = level._id_6CD6EF3DFBD41278 - _id_07D70B8494B82DD0;

        if(level._id_6CD6EF3DFBD41278 < _id_714A984CFED0FE23)
          level._id_6CD6EF3DFBD41278 = _id_714A984CFED0FE23;
      }
    }
  }

  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(undefined, undefined, undefined, undefined, undefined, armor, helmet, 0);
  agent setscriptablepartstate("headglow", "on");
  agent setthreatbiasgroup("butcher_enemies");
}

_id_15D9871ABFBD3249(spawnpoints) {
  level endon("game_ended");
  wait(randomfloat(1));

  if(!isDefined(level._id_3EE2767CBB701B58))
    level._id_3EE2767CBB701B58 = [];

  if(!isDefined(level._id_D0DBF9BF852DD46C))
    level._id_D0DBF9BF852DD46C = [];

  _id_5E775CBE1E4B789F = 1;
  _id_A9979045658C3DED = getdvarint("dvar_DC8BF984F6A8B231", 1);
  _id_2DC459931CAE6F04 = getdvarint("dvar_E87A79662D263791", 20);

  for(;;) {
    level._id_3EE2767CBB701B58 = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_3EE2767CBB701B58);
    level._id_D0DBF9BF852DD46C = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_D0DBF9BF852DD46C);
    level._id_D5C5B96C29B5C567 = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_D5C5B96C29B5C567);

    if(getdvarint("dvar_180EDF32ED792B5A", 1) == 1) {
      _id_31A6216FBF7E8CC3 = _id_2DC459931CAE6F04 - level._id_D0DBF9BF852DD46C.size;

      if(_id_31A6216FBF7E8CC3 > 0) {
        _id_131AB14471FB6476 = 0;

        if(_id_131AB14471FB6476 < _id_31A6216FBF7E8CC3) {
          if(istrue(_id_A9979045658C3DED) || istrue(_id_5E775CBE1E4B789F)) {
            _id_5078A08CC4EC9D12 = getdvarint("dvar_A688E5F86E5C42EC", 600);
            spawnpoints = scripts\engine\utility::array_randomize(spawnpoints);
            _id_5EB46327FB4C111E = getrandomnavpoint(spawnpoints[0].origin, _id_5078A08CC4EC9D12);
            _id_C48BC2EFBD1CE08A(spawnpoints[0], 1, _id_5EB46327FB4C111E);
            _id_131AB14471FB6476++;

            if(_id_131AB14471FB6476 == _id_31A6216FBF7E8CC3)
              _id_5E775CBE1E4B789F = 0;

            _id_41A9D90CA59E24EA = self.stage;

            if(!isDefined(_id_41A9D90CA59E24EA))
              _id_41A9D90CA59E24EA = 3;

            _id_39B08558013A744A = getdvarint("dvar_970B2980F12189D3", 1.0);
            _id_39D38F580160D200 = getdvarint("dvar_972E3F80F14801ED", 3.0);
            wait(1 / _id_41A9D90CA59E24EA * randomfloatrange(_id_39B08558013A744A, _id_39D38F580160D200));
          } else {
            players = scripts\engine\utility::_id_53C4C53197386572(level._id_49D407295B31E357._id_FCD0365F5A9FB237, undefined);

            if(players.size > 0) {
              players = scripts\engine\utility::array_randomize(players);

              foreach(player in players) {
                _id_95DA95F2E9954514 = vectorNormalize(anglesToForward(player getplayerangles()));
                _id_FBF57B4CF56E32D7 = player getvelocity();
                _id_98A70D33B19596A5 = vectorNormalize(_id_FBF57B4CF56E32D7);
                _id_C300923664E9AE5F = length(_id_FBF57B4CF56E32D7) / getdvarint("dvar_AAC11E6F5DADD0B2", 150);
                _id_54B537194CCB11DF = getdvarint("dvar_A35455943A3022A4", 800);
                _id_622BD2C923BCACBA = vectordot(_id_95DA95F2E9954514, _id_98A70D33B19596A5);
                _id_3C386D0B07F7BE05 = (0, 0, 0);

                if(_id_622BD2C923BCACBA == 0) {
                  _id_73DCC7FA1BA3B483 = _id_95DA95F2E9954514 * _id_54B537194CCB11DF;
                  _id_1DC4464AF4FE6BBD = vectorcross(_id_95DA95F2E9954514, (0, 0, 1)) * 0.5 * _id_54B537194CCB11DF;
                  _id_3C386D0B07F7BE05 = player.origin + _id_73DCC7FA1BA3B483 + _id_1DC4464AF4FE6BBD;
                  thread scripts\cp_mp\utility\debug_utility::drawsphere(_id_3C386D0B07F7BE05, 6, 6, (1, 0, 0));
                }

                if(_id_622BD2C923BCACBA > 0.0) {
                  _id_F3643DFA7801CA81 = _id_98A70D33B19596A5 * clamp(_id_C300923664E9AE5F, 0, 1) * _id_54B537194CCB11DF;
                  _id_1DC4464AF4FE6BBD = vectorcross(_id_95DA95F2E9954514, (0, 0, 1)) * 0.5 * clamp(_id_C300923664E9AE5F, 0, 1) * _id_54B537194CCB11DF;
                  _id_3C386D0B07F7BE05 = player.origin + _id_F3643DFA7801CA81 + _id_1DC4464AF4FE6BBD;
                  thread scripts\cp_mp\utility\debug_utility::drawsphere(_id_3C386D0B07F7BE05, 6, 6, (0, 1, 0));
                } else {
                  _id_F3643DFA7801CA81 = _id_98A70D33B19596A5 * clamp(_id_C300923664E9AE5F, 0, 1) * _id_54B537194CCB11DF;
                  _id_1DC4464AF4FE6BBD = vectorcross(_id_95DA95F2E9954514, (0, 0, -1)) * 0.5 * clamp(_id_C300923664E9AE5F, 0, 1) * _id_54B537194CCB11DF;
                  _id_3C386D0B07F7BE05 = player.origin + _id_F3643DFA7801CA81 + _id_1DC4464AF4FE6BBD;
                  thread scripts\cp_mp\utility\debug_utility::drawsphere(_id_3C386D0B07F7BE05, 6, 6, (0, 0, 1));
                }

                if(!istrue(ispointonnavmesh(_id_3C386D0B07F7BE05))) {
                  _id_BAF96185FC1F86F8 = getclosestpointonnavmesh(_id_3C386D0B07F7BE05);
                  _id_5078A08CC4EC9D12 = getdvarint("dvar_A688E5F86E5C42EC", 600);
                  _id_3C386D0B07F7BE05 = getrandomnavpoint(_id_BAF96185FC1F86F8, _id_5078A08CC4EC9D12);
                  thread scripts\cp_mp\utility\debug_utility::drawsphere(_id_3C386D0B07F7BE05, 6, 6, (1, 0, 1));
                }

                _id_2AC210AF318CF38B = scripts\engine\utility::drop_to_ground(_id_3C386D0B07F7BE05, 20, -200);
                _id_C48BC2EFBD1CE08A(spawnpoints[0], 1, _id_2AC210AF318CF38B);
                _id_131AB14471FB6476++;
                _id_41A9D90CA59E24EA = self.stage;

                if(!isDefined(_id_41A9D90CA59E24EA))
                  _id_41A9D90CA59E24EA = 3;

                wait(1 / _id_41A9D90CA59E24EA * randomfloatrange(getdvarint("dvar_970B2980F12189D3", 1.0), getdvarint("dvar_972E3F80F14801ED", 3.0)));
                break;
              }
            }
          }
        }
      }
    }

    waitframe();
  }
}

_id_F8E1DF4D0E2286F4(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(!isDefined(_id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "haunting_attackers")))
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(self, "haunting_attackers", spawnStruct());

  if(!isPlayer(eattacker)) {
    return;
  }
  if(isPlayer(eattacker)) {
    self._id_9E8FCAC6728AA14F = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "haunting_attackers");

    if(!isDefined(self._id_9E8FCAC6728AA14F.attackers))
      self._id_9E8FCAC6728AA14F.attackers = [];

    if(!isDefined(self._id_9E8FCAC6728AA14F.attackers[eattacker.guid]))
      self._id_9E8FCAC6728AA14F.attackers[eattacker.guid] = [eattacker, 0];

    [_, _id_535FD96FD1B3C9BC] = self._id_9E8FCAC6728AA14F.attackers[eattacker.guid];
    self._id_9E8FCAC6728AA14F.attackers[eattacker.guid] = [eattacker, _id_535FD96FD1B3C9BC + idamage];
  }

  _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0(einflictor, eattacker, int(idamage), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
  health = self.health;
  _id_2777DB55F1F2DC8B = self.maxhealth;
  stage = self.stage;
  self notify("recieved_damage");

  if(isDefined(self) && health > 0) {
    self notify("new_cheese_thread");
    thread _id_CF18FCB411DB697F();
  }

  if(isDefined(health) && isDefined(_id_2777DB55F1F2DC8B) && isDefined(stage)) {
    if(stage == 1 && health < _id_2777DB55F1F2DC8B * 0.66 && health >= _id_2777DB55F1F2DC8B * 0.33)
      self.stage = 2;
    else if(stage == 2 && health < _id_2777DB55F1F2DC8B * 0.33)
      self.stage = 3;
  }

  if(istrue(self._id_E870C27D6E431A3B) && isDefined(level._id_49D407295B31E357._id_FCD0365F5A9FB237)) {
    self._id_8392C47BCDD3138A = self._id_8392C47BCDD3138A + idamage;
    numplayers = level._id_49D407295B31E357._id_FCD0365F5A9FB237.size - 1;
    _id_BF4187D4E43EB09A = numplayers * getdvarint("dvar_35CDEEFA1C125662", 250);

    if(self._id_8392C47BCDD3138A >= _id_BF4187D4E43EB09A) {
      _id_0430056385102FBD = 2.0;
      self shellshock("flashbang_mp", _id_0430056385102FBD);
      self notify("flashbang", self.origin, 1, 1, eattacker, undefined, _id_0430056385102FBD);
      _id_582458544998EA8C();
    }
  }
}

_id_F14BCB2F51EBE26D(playerlist) {
  if(isDefined(playerlist)) {
    foreach(_id_F90358454413407F in playerlist) {
      if(isPlayer(_id_F90358454413407F[0]) && _id_F90358454413407F[1] >= 1)
        scripts\cp_mp\challenges::_id_8359CADD253F9604(_id_F90358454413407F[0], "butcher_killed", 1, 0);
    }
  }
}

_id_0C447E7A1A3F59AC() {
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

_id_DA29174B9FFBB844(icon) {
  self endon("death");

  for(;;) {
    waitframe();
    icon scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(self.origin);
    icon.origin = self.origin;
  }
}

_id_678541A6BE39AAF4() {
  level endon("game_ended");
  _id_0BAA08EA813E9752 = _id_2FDEB8023287BE67::_id_3BCF85FF011D31F8("butcher");

  if(!isDefined(_id_0BAA08EA813E9752)) {
    return;
  }
  _id_A942AE9112CD6BDE = scripts\engine\utility::getStructArray(_id_0BAA08EA813E9752.target, "targetname");
  _id_1435F6F97C873063 = 1;

  if(scripts\mp\utility\game::getsubgametype() != "dmz")
    _id_58C817414D96DE59 = _id_2636152C566D6C64::_id_2E6E2B664DFE3186("butcher", _id_1435F6F97C873063);
  else
    _id_58C817414D96DE59 = _id_2FDEB8023287BE67::_id_2E6E2B664DFE3186("butcher", _id_1435F6F97C873063);

  level._id_16E11016257D52E2 = _id_58C817414D96DE59;
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

  _id_58C817414D96DE59._id_E2958F412A7425C0 = _id_58C817414D96DE59 _id_6D69350C86BAF67B(_id_58C817414D96DE59.nodes["boss_butcher_spawn"][0]);
  _id_58C817414D96DE59._id_E2958F412A7425C0._id_0566868292EE2A1B = _id_58C817414D96DE59;
  _id_58C817414D96DE59 notify("boss_spawned");
  pos = _id_58C817414D96DE59._id_E2958F412A7425C0.origin;

  if(scripts\mp\utility\game::getsubgametype() == "dmz") {}

  if(!isDefined(_id_58C817414D96DE59._id_E2958F412A7425C0)) {
    return;
  }
  _id_58C817414D96DE59._id_E2958F412A7425C0 _id_5938B1C7E9CF6DDD::go_to_node_set_goal(_id_58C817414D96DE59.nodes["boss_butcher_spawn"]);
  _id_58C817414D96DE59._id_E2958F412A7425C0.fnasm_handlenotetrack = ::_id_4EEF3D865BDD8991;

  if(isDefined(_id_58C817414D96DE59.nodes["boss_butcher_minion"]))
    _id_58C817414D96DE59._id_E2958F412A7425C0 thread _id_15D9871ABFBD3249(_id_58C817414D96DE59.nodes["boss_butcher_minion"]);

  _id_4673B0931E86514C = "Boss_Focus_Dmz";

  if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414() || scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1())
    _id_4673B0931E86514C = "Boss_Focus_SM_Dmz";

  scripts\engine\utility::flag_set("boss_butcher_init");
  waitframe();
}

_id_15ABCBFA6EA73838() {
  self endon("death");
  scripts\engine\utility::ent_flag_wait("attack_players");

  for(;;) {
    _id_78122E18403A8DC4 = scripts\mp\utility\player::getplayersinradius(self.origin, 1000);

    if(_id_78122E18403A8DC4.size > 0) {
      target = scripts\engine\utility::getclosest(self.origin, _id_78122E18403A8DC4);
      _id_120270BD0A747A35::_id_304DA84D9A815C01(target.origin, 8, 1);
    }

    wait 15;
  }
}

_id_FAD864200BB1A414(_id_BD138DE99B3B3507) {
  if(!isDefined(self)) {
    return;
  }
  if(_id_BD138DE99B3B3507)
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("butcher_arena");
  else
    _id_3B64EB40368C1450::set("butcher_arena", "supers", 0);
}

_id_F9B85A83346B7743(player, showicon) {
  return 0;
}

_id_5842493F9B1493FD(_id_9A2669DBBEBA4AAB, _id_DB9D191330E5E9DF, _id_D5998E8874D77B02) {
  if(!isDefined(_id_9A2669DBBEBA4AAB) || !isDefined(_id_DB9D191330E5E9DF)) {
    return;
  }
  if(istrue(_id_D5998E8874D77B02))
    playFX(scripts\engine\utility::getfx(_id_9A2669DBBEBA4AAB), scripts\engine\utility::drop_to_ground(_id_DB9D191330E5E9DF, 10, -50));
  else
    playFX(scripts\engine\utility::getfx(_id_9A2669DBBEBA4AAB), _id_DB9D191330E5E9DF);
}

_id_AA0D9B4F0ECE5F53() {
  return !istrue(self._id_51A7ACF6A037EF51);
}

_id_AE8DFAF9BDD86181() {
  if(!istrue(self._id_51A7ACF6A037EF51))
    thread _id_B73FC51A0984FD5A(getdvarint("dvar_9FAB9C97475F2212", 10));
}

_id_B73FC51A0984FD5A(timer) {
  self endon("death");
  self._id_51A7ACF6A037EF51 = 1;
  wait(timer);
  self._id_51A7ACF6A037EF51 = undefined;
}

_id_D9CDC5157204CF00() {
  self endon("death");

  for(;;) {
    while(!istrue(_id_AA0D9B4F0ECE5F53()))
      waitframe();

    if(!isDefined(level._id_49D407295B31E357._id_FCD0365F5A9FB237))
      numplayers = undefined;
    else
      numplayers = scripts\engine\utility::_id_53C4C53197386572(level._id_49D407295B31E357._id_FCD0365F5A9FB237.size, undefined);

    if(!isDefined(numplayers) || self isinexecutionattack()) {
      _id_AE8DFAF9BDD86181();
      continue;
    }

    _id_3FE6411D54B202AD = _id_619313D5C8B921E2();
    _id_6C8349DCB7387D6E = _id_5A7979BFDE4F6A77();
    _id_33EBBDDE1D22B5B0 = _id_244189DBD71883AD();
    _id_C604D280A5A18121 = getdvarint("dvar_1A42AF980C24DEE8", 0);

    if(!istrue(_id_3FE6411D54B202AD) && !istrue(_id_6C8349DCB7387D6E) && !istrue(_id_33EBBDDE1D22B5B0)) {
      continue;
    }
    _id_B7A62427E53FEC9B = self.origin;

    switch (self.stage) {
      case 1:
        if(istrue(_id_3FE6411D54B202AD)) {
          _id_A5C7D8F01A6A27C3 = getdvarint("dvar_3D3B13207FEF5C3E", 50);
          players = scripts\mp\utility\player::getplayersinradius(_id_B7A62427E53FEC9B, _id_A5C7D8F01A6A27C3);

          if(players.size >= 1) {
            _id_6774627EA9EE0078();
            continue;
          }
        }

        break;
      case 2:
        if(istrue(_id_33EBBDDE1D22B5B0)) {
          _id_A5C7D8F01A6A27C3 = getdvarint("dvar_81F7B1DC708B6695", 300);
          players = scripts\mp\utility\player::getplayersinradius(_id_B7A62427E53FEC9B, _id_A5C7D8F01A6A27C3);

          if(istrue(players.size >= 1)) {
            _id_1406DF07BD23DA61(_id_A5C7D8F01A6A27C3);
            continue;
          }
        }

        break;
      case 3:
        if(istrue(_id_6C8349DCB7387D6E)) {
          _id_7D1CC2D0E01F5FE5 = getdvarint("dvar_4F485B371874E9D4", 250);
          playersnear = scripts\mp\utility\player::getplayersinradius(_id_B7A62427E53FEC9B, _id_7D1CC2D0E01F5FE5);

          if(playersnear.size <= 1) {
            _id_A5C7D8F01A6A27C3 = getdvarint("dvar_AFEC181CDC97ACA3", 600);
            players = scripts\mp\utility\player::getplayersinradius(_id_B7A62427E53FEC9B, _id_A5C7D8F01A6A27C3);

            if(istrue(players.size >= 1)) {
              _id_D5A7416745178E11(_id_A5C7D8F01A6A27C3);
              continue;
            }
          }
        }

        if(istrue(_id_33EBBDDE1D22B5B0)) {
          _id_A5C7D8F01A6A27C3 = getdvarint("dvar_81F7B1DC708B6695", 350);
          players = scripts\mp\utility\player::getplayersinradius(_id_B7A62427E53FEC9B, _id_A5C7D8F01A6A27C3);

          if(istrue(players.size >= 1)) {
            _id_1406DF07BD23DA61(_id_A5C7D8F01A6A27C3);
            continue;
          }
        }

        break;
    }

    waitframe();
  }
}

_id_619313D5C8B921E2() {
  if(istrue(self._id_3C5695A80DD81EE2))
    return 0;

  if(self._id_A97AC004F00C5DF9)
    return 0;

  return 1;
}

_id_BD7DE4BF80B313EE(timer) {
  self endon("death");
  self._id_3C5695A80DD81EE2 = 1;
  wait(timer);
  self._id_3C5695A80DD81EE2 = undefined;
}

_id_6774627EA9EE0078() {
  _id_970E772AF06CF1D9 = [];
  _id_610520BE555433B2 = randomintrange(0, 20);

  switch (_id_610520BE555433B2) {
    case 0:
      _id_970E772AF06CF1D9 = ["right_cleaver", "right_sickle"];
      break;
    case 1:
      _id_970E772AF06CF1D9 = ["right_sickle", "right_cleaver"];
      break;
    case 2:
      _id_970E772AF06CF1D9 = ["left_cleaver", "left_sickle"];
      break;
    case 3:
      _id_970E772AF06CF1D9 = ["left_sickle", "left_cleaver"];
      break;
    case 4:
      _id_970E772AF06CF1D9 = ["right_cleaver", "left_sickle"];
      break;
    case 5:
      _id_970E772AF06CF1D9 = ["left_sickle", "right_cleaver"];
      break;
    case 6:
      _id_970E772AF06CF1D9 = ["right_sickle", "left_cleaver"];
      break;
    case 7:
      _id_970E772AF06CF1D9 = ["left_cleaver", "right_sickle"];
      break;
    case 8:
      _id_970E772AF06CF1D9 = ["right_cleaver", "headbutt"];
      break;
    case 9:
      _id_970E772AF06CF1D9 = ["right_sickle", "headbutt"];
      break;
    case 10:
      _id_970E772AF06CF1D9 = ["left_sickle", "headbutt"];
      break;
    case 11:
      _id_970E772AF06CF1D9 = ["left_cleaver", "headbutt"];
      break;
    case 12:
      _id_970E772AF06CF1D9 = ["right_cleaver", "left_sickle", "right_cleaver"];
      break;
    case 13:
      _id_970E772AF06CF1D9 = ["left_sickle", "right_cleaver", "left_sickle"];
      break;
    case 14:
      _id_970E772AF06CF1D9 = ["right_sickle", "left_cleaver", "right_sickle"];
      break;
    case 15:
      _id_970E772AF06CF1D9 = ["left_cleaver", "right_sickle", "left_cleaver"];
      break;
    case 16:
      _id_970E772AF06CF1D9 = ["right_cleaver", "left_sickle", "headbutt"];
      break;
    case 17:
      _id_970E772AF06CF1D9 = ["left_sickle", "right_cleaver", "headbutt"];
      break;
    case 18:
      _id_970E772AF06CF1D9 = ["right_sickle", "left_cleaver", "headbutt"];
      break;
    case 19:
      _id_970E772AF06CF1D9 = ["left_cleaver", "right_sickle", "headbutt"];
      break;
  }

  _id_4B2445497FE06782(_id_970E772AF06CF1D9);
}

_id_4B2445497FE06782(_id_D9D97ABE6360C821) {
  self endon("death");
  _id_AE8DFAF9BDD86181();

  if(!istrue(self._id_3C5695A80DD81EE2))
    thread _id_BD7DE4BF80B313EE(getdvarint("dvar_00620FF7CDF50AE3", 12));

  self._id_D9D97ABE6360C821 = _id_D9D97ABE6360C821;
  self.script = "butcherCombo";
  anim.fire_notetrack_functions[self.script] = ::_id_A883DA47A5AA3CE2;
  _id_010B6724C15A95E8::_id_C434AF0895CC147C("cap_butcher_combo", "caps/common/cap_butcher_combo");
  self waittill("cap_exit_completed");
  self.script = undefined;
  anim.fire_notetrack_functions = [];
  self.fnasm_handlenotetrack = ::_id_4EEF3D865BDD8991;
}

_id_A883DA47A5AA3CE2() {
  if(isDefined(self.enemy)) {
    target = self.enemy;
    _id_034AA97BBCE2BDE0 = vectorNormalize(target.origin - self.origin);
    scripts\asm\soldier\melee::_id_E157C0CE32F71CBE(target, 0, _id_034AA97BBCE2BDE0);
  }
}

_id_1C7F23417414BC39(_id_1D9FB21B4F3023F3) {
  if(self._id_4DE4EE8F58535538) {
    _id_0430056385102FBD = getdvarfloat("dvar_E395466FC491969C", 2.25);
    _id_1D9FB21B4F3023F3 scripts\cp_mp\utility\shellshock_utility::_shellshock("butcher_headbutt_mp", "stun", _id_0430056385102FBD, 0);
    self._id_E5DFAB5DF30ED53D = 1;
  }
}

_id_4D0D764C1ABAC155() {
  self endon("death");
  self._id_4DE4EE8F58535538 = 0;
  self._id_E5DFAB5DF30ED53D = 0;
  _id_2F0F1113A028B3B9 = 0;

  for(;;) {
    if(self._id_E5DFAB5DF30ED53D) {
      self._id_E5DFAB5DF30ED53D = 0;
      _id_2F0F1113A028B3B9 = 0;
    }

    _id_5583213F2F6A93C6 = self._blackboard.meleerequestedcharge;

    if(_id_2F0F1113A028B3B9 && !_id_5583213F2F6A93C6) {
      if(self._blackboard.meleerequested) {
        self._id_4DE4EE8F58535538 = 1;
        _id_2F0F1113A028B3B9 = 1;
      } else {
        self._id_4DE4EE8F58535538 = 0;
        _id_2F0F1113A028B3B9 = _id_5583213F2F6A93C6;
      }
    } else {
      self._id_4DE4EE8F58535538 = 0;
      _id_2F0F1113A028B3B9 = _id_5583213F2F6A93C6;
    }

    waitframe();
  }
}

_id_99550213A19278B0() {
  if(isDefined(self.enemy)) {
    _id_0430056385102FBD = getdvarfloat("dvar_E395466FC491969C", 2.25);
    self.enemy scripts\cp_mp\utility\shellshock_utility::_shellshock("butcher_headbutt_mp", "stun", _id_0430056385102FBD, 0);
  }
}

_id_244189DBD71883AD() {
  return !istrue(self._id_3DE7734F1E0B7B41);
}

_id_A93BBE0366E4F1DD(timer) {
  self endon("death");
  self._id_3DE7734F1E0B7B41 = 1;
  wait(timer);
  self._id_3DE7734F1E0B7B41 = undefined;
}

_id_1406DF07BD23DA61(_id_A5C7D8F01A6A27C3) {
  self endon("death");
  _id_AE8DFAF9BDD86181();

  if(!istrue(self._id_3DE7734F1E0B7B41))
    thread _id_A93BBE0366E4F1DD(getdvarint("dvar_79A775F8B98E9EA2", 14));

  self._id_259BEAEFC971E7AC = "slam";
  _id_010B6724C15A95E8::_id_C434AF0895CC147C("cap_butcher_aoe", "caps/common/cap_butcher_aoe");
  scripts\engine\utility::waittill_any_2("effect", "cap_exit_completed");
  self.fnasm_handlenotetrack = ::_id_4EEF3D865BDD8991;
  _id_B7A62427E53FEC9B = self.origin;
  _id_5842493F9B1493FD("vfx_hween_butcher_slam", _id_B7A62427E53FEC9B, 1);
  players = scripts\mp\utility\player::getplayersinradius(_id_B7A62427E53FEC9B, _id_A5C7D8F01A6A27C3);
  agents = getaiarrayinradius(_id_B7A62427E53FEC9B, _id_A5C7D8F01A6A27C3);
  _id_0430056385102FBD = getdvarint("dvar_65154F186C848144", 3.25);
  _id_8DCA8B4F5D4AB471 = getdvarint("dvar_19729540BE85C726", 50);

  foreach(player in players) {
    player scripts\cp_mp\utility\shellshock_utility::_shellshock("butcher_slam_mp", "stun", _id_0430056385102FBD, 0);
    player dodamage(_id_8DCA8B4F5D4AB471, player.origin, player, undefined, "MOD_TRIGGER_HURT");
  }

  foreach(agent in agents) {
    if(agent == self) {
      continue;
    }
    agent dodamage(_id_8DCA8B4F5D4AB471 * 10, _id_B7A62427E53FEC9B, self, undefined, "MOD_EXPLOSIVE");
  }
}

_id_5A7979BFDE4F6A77() {
  return !istrue(self._id_53B37A56BF82BC71);
}

_id_CCA6C022C833537D(timer) {
  self endon("death");
  self._id_53B37A56BF82BC71 = 1;
  wait(timer);
  self._id_53B37A56BF82BC71 = undefined;
}

_id_D5A7416745178E11(_id_A5C7D8F01A6A27C3) {
  self endon("death");
  self playSound("dx_br_saba_actn_butc_frmt");
  _id_AE8DFAF9BDD86181();

  if(!istrue(self._id_53B37A56BF82BC71))
    thread _id_CCA6C022C833537D(getdvarint("dvar_403DE5BA40BFD8A4", 12));

  self._id_259BEAEFC971E7AC = "shout";
  _id_010B6724C15A95E8::_id_C434AF0895CC147C("cap_butcher_aoe", "caps/common/cap_butcher_aoe");
  scripts\engine\utility::waittill_any_2("effect", "cap_exit_completed");
  self.fnasm_handlenotetrack = ::_id_4EEF3D865BDD8991;
  _id_B7A62427E53FEC9B = self.origin;
  _id_5842493F9B1493FD("vfx_hween_butcher_roar", _id_B7A62427E53FEC9B, 1);
  players = scripts\mp\utility\player::getplayersinradius(_id_B7A62427E53FEC9B, _id_A5C7D8F01A6A27C3);
  _id_0430056385102FBD = getdvarint("dvar_835C09F71E7A53F6", 4.5);

  foreach(player in players)
  player scripts\cp_mp\utility\shellshock_utility::_shellshock("butcher_shout_mp", "stun", _id_0430056385102FBD, 0);
}

_id_106E2ABB020F44BC(enemy) {
  switch (self.stage) {
    case 1:
      _id_03E3E4D52CBB006C = getdvarfloat("dvar_B1B44343CDB1B29B", 0.5);
      break;
    case 2:
      _id_03E3E4D52CBB006C = getdvarfloat("dvar_B1B44443CDB1B4CE", 0.75);
      break;
    case 3:
      _id_03E3E4D52CBB006C = getdvarfloat("dvar_B1B44543CDB1B701", 1.0);
      break;
    default:
      _id_03E3E4D52CBB006C = getdvarfloat("dvar_B1B44543CDB1B701", 1.0);
      break;
  }

  if(!istrue(enemy.health <= _id_03E3E4D52CBB006C * enemy.maxhealth))
    return 0;

  if(isDefined(enemy._id_D322EFB4EE20D7FD) && istrue(enemy._id_D322EFB4EE20D7FD > 0))
    return 0;

  return 1;
}

_id_037DA92CF9ACD9F6() {
  if(isDefined(self.enemy) && scripts\mp\utility\player::isinlaststand(self.enemy))
    return 0;

  if(getdvarint("dvar_3C4381AC21C7D72A", 0))
    return 1;

  if(istrue(getdvarint("dvar_166AECF1EE92C8C0", 1))) {
    if(!istrue(self._id_F3DDFBE9CAD3ED6B)) {
      if(istrue(self.stage >= 1)) {
        if(isDefined(self.enemy))
          return _id_106E2ABB020F44BC(self.enemy);
      }
    }
  }

  return 0;
}

_id_55592072C6678B57(timer) {
  self endon("death");
  self._id_F3DDFBE9CAD3ED6B = 1;
  wait(timer);
  self._id_F3DDFBE9CAD3ED6B = undefined;
}

_id_2D8D1B02489A2BE7() {
  if(isDefined(self.enemy)) {
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(self, "executeVictim", self.enemy);
    self.enemy.ignoreme = 1;
    self._id_4882EE0CD4E52575 = createnavbadplacebybounds(self.enemy.origin, (50, 50, 50), (0, 0, 0));
    self playSound("dx_br_saba_actn_butc_frmt");
  }

  if(!istrue(self._id_F3DDFBE9CAD3ED6B))
    thread _id_55592072C6678B57(getdvarint("dvar_ABB879B7C4372DA6", 20));

  self._id_E870C27D6E431A3B = 1;
  self._id_4F2B235172B35964 = undefined;
}

_id_582458544998EA8C() {
  self._id_E870C27D6E431A3B = 0;
  self._id_4F2B235172B35964 = 1;
  self._id_8392C47BCDD3138A = 0;
  _id_74257B521753F376 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "executeVictim");

  if(isDefined(_id_74257B521753F376)) {
    destroynavobstacle(self._id_4882EE0CD4E52575);
    _id_74257B521753F376.ignoreme = 0;
  }
}

_id_019D65E3097CBC8C(agent) {
  _id_74B0328B6595AF05 = [];

  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, "brloot_offhand_advancedsupplydrop");
    _id_74B0328B6595AF05 = scripts\engine\utility::array_combine(_id_74B0328B6595AF05, _id_15909269866FB61E("brloot_offhand_molotov", 1, 2));
    _id_74B0328B6595AF05 = scripts\engine\utility::array_combine(_id_74B0328B6595AF05, _id_15909269866FB61E("brloot_offhand_magsnap", 2, 3));
    _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, "brloot_plate_carrier_3_comms");
    _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, "brloot_plate_carrier_3_medic");
    _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, "brloot_plate_carrier_tempered");
    _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, "brloot_plate_carrier_3_stealth");
    _id_74B0328B6595AF05 = scripts\engine\utility::array_combine(_id_74B0328B6595AF05, _id_15909269866FB61E("brloot_super_soundveil", 1, 2));
    _id_74B0328B6595AF05 = scripts\engine\utility::array_combine(_id_74B0328B6595AF05, _id_15909269866FB61E("brloot_offhand_decoy", 1, 2));
    _id_74B0328B6595AF05 = scripts\engine\utility::array_combine(_id_74B0328B6595AF05, _id_15909269866FB61E("killstreak", 2, 3));
    _id_74B0328B6595AF05 = scripts\engine\utility::array_combine(_id_74B0328B6595AF05, _id_15909269866FB61E("plunder", 7, 10));
    _id_74B0328B6595AF05 = scripts\engine\utility::array_combine(_id_74B0328B6595AF05, _id_15909269866FB61E("weapon", 4, 4));
  } else {
    _id_D46B5001967CDEEE = randomintrange(0, 3);

    switch (_id_D46B5001967CDEEE) {
      case 0:
        _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, "brloot_plate_carrier_3_comms");
        break;
      case 1:
        _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, "brloot_plate_carrier_3_medic");
        break;
      case 2:
        _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, "brloot_plate_carrier_3_stealth");
        break;
    }

    _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, "brloot_plate_carrier_tempered");
    _id_74B0328B6595AF05 = scripts\engine\utility::array_combine(_id_74B0328B6595AF05, _id_15909269866FB61E("brloot_offhand_molotov", 1, 2));
    _id_74B0328B6595AF05 = scripts\engine\utility::array_combine(_id_74B0328B6595AF05, _id_15909269866FB61E("killstreak", 2, 3));
    _id_74B0328B6595AF05 = scripts\engine\utility::array_combine(_id_74B0328B6595AF05, _id_15909269866FB61E("weapon", 4, 4));
    _id_F69933CDE4606998 = randomintrange(0, 2);

    switch (_id_F69933CDE4606998) {
      case 0:
        _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, "brloot_backpack_scav");
        break;
      case 1:
        _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, "brloot_backpack_large");
        break;
    }

    _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, "brloot_valuable_butcher_cleaver");
    _id_74B0328B6595AF05 = scripts\engine\utility::array_add(_id_74B0328B6595AF05, "brloot_valuable_gold_skull");
    _id_74B0328B6595AF05 = scripts\engine\utility::array_combine(_id_74B0328B6595AF05, _id_15909269866FB61E("brloot_self_revive", 0, 1));
  }

  foreach(_id_62E76947E5C708AD in _id_74B0328B6595AF05) {
    count = 1;

    switch (_id_62E76947E5C708AD) {
      case "brloot_plunder_cash_rare_1":
        _id_62F81FE299D330EA = randomfloatrange(0, 1);

        if(_id_62F81FE299D330EA <= 0.5)
          count = 120;
        else
          count = 180;

        break;
      case "brloot_plunder_cash_rare_2":
        _id_62F81FE299D330EA = randomfloatrange(0, 1);

        if(_id_62F81FE299D330EA <= 0.5)
          count = 240;
        else
          count = 300;

        break;
      case "brloot_plunder_cash_epic_1":
        _id_62F81FE299D330EA = randomfloatrange(0, 1);

        if(_id_62F81FE299D330EA <= 0.5)
          count = 360;
        else
          count = 420;

        break;
      case "brloot_plunder_cash_epic_2":
        _id_62F81FE299D330EA = randomfloatrange(0, 1);

        if(_id_62F81FE299D330EA <= 0.5)
          count = 480;
        else
          count = 540;

        break;
      case "brloot_plunder_cash_legendary_1":
        count = 666;
        break;
    }

    _id_48814951E916AF89::_id_63A043D47490F90D(agent, _id_62E76947E5C708AD, undefined, 1, count);
  }
}

_id_15909269866FB61E(itemname, min, max) {
  _id_45366615187F70B0 = randomintrange(min, max + 1);
  _id_28B8EF2FF7FD0C70 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_45366615187F70B0; _id_AC0E594AC96AA3A8++) {
    if(itemname == "killstreak") {
      if(istrue(0)) {
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_killstreak_clusterstrike");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_killstreak_precision_airstrike");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_killstreak_uav");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_killstreak_uav_bigmap");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_killstreak_scramblerdrone");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_killstreak_juggernaut");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_killstreak_auav");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_killstreak_assaultdrone");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_killstreak_cluster_spike");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_killstreak_supply_sweep");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_killstreak_sentrygun");
      } else
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, getkillstreak());

      continue;
    }

    if(itemname == "lethal") {
      if(istrue(0)) {
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_atmine");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_claymore");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_c4");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_frag");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_molotov");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_semtex");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_thermite");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_throwingknife");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_bunkerbuster");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_shuriken");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_throwstar");
      } else
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, _id_C07D4712E5FF0DD9());

      continue;
    }

    if(itemname == "plunder") {
      if(istrue(0)) {
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_plunder_cash_rare_1");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_plunder_cash_rare_2");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_plunder_cash_epic_1");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_plunder_cash_epic_2");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_plunder_cash_legendary_1");
      } else
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, _id_0C9CAC8B885E3B4B());

      continue;
    }

    if(itemname == "tactical") {
      if(istrue(0)) {
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_health_adrenaline");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_binoculars");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_concussion");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_decoy");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_flash");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_gas");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_heartbeatsensor");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_smoke");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_snapshot");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_geigercounter");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_shockstick");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_thermalphone");
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_offhand_magsnap");
      } else
        _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, _id_3B965E653D2865B2());

      continue;
    }

    if(itemname == "weapon") {
      if(istrue(0)) {
        if(scripts\mp\utility\game::getsubgametype() != "dmz") {
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_akilo74_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_akilo_rare_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_kilo53_rare_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_mcharlie_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_mcbravo_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_mike4_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_scharlie_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_acharlie300_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_helima_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_schotel_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_pi_papa220_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_pi_tango9_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_lm_foxtrot_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_lm_rkilo_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_lm_slima_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_lm_kilo21_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_lm_ngolf7_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_dm_stango25_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sn_crossbow_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sh_mbravo_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sh_mviktor_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sh_mike1014_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sh_vecho_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_dm_xmike2010_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sn_mromeo_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sn_alpha50_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sm_mpapa5_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sm_papa90_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sm_mpapa7_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sm_aviktor_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sm_acharlie45_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sn_india_lege_br");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_br_ngsierra_lege_br");
        } else {
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_schotel_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_golf3_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_br_msecho_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_br_soscar14_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_dm_mike14_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_dm_mike24_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_dm_pgolf1_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_dm_sa700_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_dm_sbeta_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_dm_scromeo_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_dm_la700_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_dm_xmike2010_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sn_limax_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sn_mromeo_one_shot");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sh_charlie725_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sh_mbravo_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sh_mike1014_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sh_mviktor_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_pi_decho_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_pi_golf17_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_pi_golf18_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_pi_papa220_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_pi_swhiskey_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_lm_ahotel_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_lm_foxtrot_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_lm_kilo21_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_lm_ngolf7_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_lm_rkilo_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_lm_slima_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_mike4_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_mike16_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_kilo53_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_akilo_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_akilo105_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_akilo74_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_augolf_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_ar_scharlie_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sm_alpha57_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sm_mpapa5_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sm_aviktor_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sm_beta_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sm_victor_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sm_apapa_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sm_papa90_lege");
          _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, "brloot_weapon_sm_mpapa7_lege");
        }
      }

      continue;
    }

    _id_28B8EF2FF7FD0C70 = scripts\engine\utility::array_add(_id_28B8EF2FF7FD0C70, itemname);
  }

  return _id_28B8EF2FF7FD0C70;
}

_id_A475CC06CA1CD2A1() {
  _id_25C6725452A66D2A = randomfloatrange(0, 1);
  _id_20F489A286CC3403 = getdvarfloat("dvar_4184B0168FE8345B", 0.1);

  if(_id_25C6725452A66D2A <= _id_20F489A286CC3403) {
    _id_610520BE555433B2 = randomintrange(0, 2);

    switch (_id_610520BE555433B2) {
      case 0:
        return "brloot_ammo_50cal";
      case 1:
        return "brloot_ammo_rocket";
    }
  } else {
    _id_610520BE555433B2 = randomintrange(0, 3);

    switch (_id_610520BE555433B2) {
      case 0:
        return "brloot_ammo_12g";
      case 1:
        return "brloot_ammo_762";
      case 2:
        return "brloot_ammo_919";
    }
  }

  return undefined;
}

getkillstreak() {
  _id_610520BE555433B2 = randomintrange(0, 9);

  switch (_id_610520BE555433B2) {
    case 0:
      return "brloot_killstreak_clusterstrike";
    case 1:
      return "brloot_killstreak_precision_airstrike";
    case 2:
      return "brloot_killstreak_uav";
    case 3:
      return "brloot_killstreak_uav_bigmap";
    case 4:
      return "brloot_killstreak_scramblerdrone";
    case 5:
      return "brloot_killstreak_auav";
    case 6:
      return "brloot_killstreak_assaultdrone";
    case 7:
      return "brloot_killstreak_cluster_spike";
    case 8:
      return "brloot_killstreak_sentrygun";
  }

  return undefined;
}

_id_C07D4712E5FF0DD9() {
  _id_610520BE555433B2 = randomintrange(0, 11);

  switch (_id_610520BE555433B2) {
    case 0:
      return "brloot_offhand_atmine";
    case 1:
      return "brloot_offhand_claymore";
    case 2:
      return "brloot_offhand_c4";
    case 3:
      return "brloot_offhand_frag";
    case 4:
      return "brloot_offhand_molotov";
    case 5:
      return "brloot_offhand_semtex";
    case 6:
      return "brloot_offhand_thermite";
    case 7:
      return "brloot_offhand_throwingknife";
    case 8:
      return "brloot_offhand_bunkerbuster";
    case 9:
      return "brloot_offhand_shuriken";
    case 10:
      return "brloot_offhand_throwstar";
  }

  return undefined;
}

_id_3B965E653D2865B2() {
  _id_610520BE555433B2 = randomintrange(0, 13);

  switch (_id_610520BE555433B2) {
    case 0:
      return "brloot_health_adrenaline";
    case 1:
      return "brloot_offhand_binoculars";
    case 2:
      return "brloot_offhand_concussion";
    case 3:
      return "brloot_offhand_decoy";
    case 4:
      return "brloot_offhand_flash";
    case 5:
      return "brloot_offhand_gas";
    case 6:
      return "brloot_offhand_heartbeatsensor";
    case 7:
      return "brloot_offhand_smoke";
    case 8:
      return "brloot_offhand_snapshot";
    case 9:
      return "brloot_offhand_geigercounter";
    case 10:
      return "brloot_offhand_shockstick";
    case 11:
      return "brloot_offhand_thermalphone";
    case 12:
      return "brloot_offhand_magsnap";
  }

  return undefined;
}

_id_0C9CAC8B885E3B4B() {
  _id_610520BE555433B2 = randomintrange(0, 5);

  switch (_id_610520BE555433B2) {
    case 0:
      return "brloot_plunder_cash_rare_1";
    case 1:
      return "brloot_plunder_cash_rare_2";
    case 2:
      return "brloot_plunder_cash_epic_1";
    case 3:
      return "brloot_plunder_cash_epic_2";
    case 4:
      return "brloot_plunder_cash_legendary_1";
  }

  return undefined;
}

getweapon() {
  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    _id_610520BE555433B2 = randomintrange(0, 33);

    switch (_id_610520BE555433B2) {
      case 0:
        return "brloot_weapon_ar_akilo74_lege_br";
      case 1:
        return "brloot_weapon_ar_akilo_rare_br";
      case 2:
        return "brloot_weapon_ar_kilo53_rare_br";
      case 3:
        return "brloot_weapon_ar_mcharlie_lege_br";
      case 4:
        return "brloot_weapon_ar_mcbravo_lege_br";
      case 5:
        return "brloot_weapon_ar_mike4_lege_br";
      case 6:
        return "brloot_weapon_ar_scharlie_lege_br";
      case 7:
        return "brloot_weapon_ar_acharlie300_lege_br";
      case 8:
        return "brloot_weapon_ar_helima_lege_br";
      case 9:
        return "brloot_weapon_ar_schotel_lege_br";
      case 10:
        return "brloot_weapon_pi_papa220_lege_br";
      case 11:
        return "brloot_weapon_pi_tango9_lege_br";
      case 12:
        return "brloot_weapon_lm_foxtrot_lege_br";
      case 13:
        return "brloot_weapon_lm_rkilo_lege_br";
      case 14:
        return "brloot_weapon_lm_slima_lege_br";
      case 15:
        return "brloot_weapon_lm_kilo21_lege_br";
      case 16:
        return "brloot_weapon_lm_ngolf7_lege_br";
      case 17:
        return "brloot_weapon_dm_stango25_lege_br";
      case 18:
        return "brloot_weapon_sn_crossbow_lege_br";
      case 19:
        return "brloot_weapon_sh_mbravo_lege_br";
      case 20:
        return "brloot_weapon_sh_mviktor_lege_br";
      case 21:
        return "brloot_weapon_sh_mike1014_lege_br";
      case 22:
        return "brloot_weapon_sh_vecho_lege_br";
      case 23:
        return "brloot_weapon_dm_xmike2010_lege_br";
      case 24:
        return "brloot_weapon_sn_mromeo_lege_br";
      case 25:
        return "brloot_weapon_sn_alpha50_lege_br";
      case 26:
        return "brloot_weapon_sm_mpapa5_lege_br";
      case 27:
        return "brloot_weapon_sm_papa90_lege_br";
      case 28:
        return "brloot_weapon_sm_mpapa7_lege_br";
      case 29:
        return "brloot_weapon_sm_aviktor_lege_br";
      case 30:
        return "brloot_weapon_sm_acharlie45_lege_br";
      case 31:
        return "brloot_weapon_sn_india_lege_br";
      case 32:
        return "brloot_weapon_br_ngsierra_lege_br";
    }
  } else {
    _id_610520BE555433B2 = randomintrange(0, 45);

    switch (_id_610520BE555433B2) {
      case 0:
        return "brloot_weapon_ar_schotel_lege";
      case 1:
        return "brloot_weapon_ar_golf3_lege";
      case 2:
        return "brloot_weapon_br_msecho_lege";
      case 3:
        return "brloot_weapon_br_soscar14_lege";
      case 4:
        return "brloot_weapon_dm_mike14_lege";
      case 5:
        return "brloot_weapon_dm_mike24_lege";
      case 6:
        return "brloot_weapon_dm_pgolf1_lege";
      case 7:
        return "brloot_weapon_dm_sa700_lege";
      case 8:
        return "brloot_weapon_dm_sbeta_lege";
      case 9:
        return "brloot_weapon_dm_scromeo_lege";
      case 10:
        return "brloot_weapon_dm_la700_lege";
      case 11:
        return "brloot_weapon_dm_xmike2010_lege";
      case 12:
        return "brloot_weapon_sn_limax_lege";
      case 13:
        return "brloot_weapon_sn_mromeo_one_shot";
      case 14:
        return "brloot_weapon_sh_charlie725_lege";
      case 15:
        return "brloot_weapon_sh_mbravo_lege";
      case 16:
        return "brloot_weapon_sh_mike1014_lege";
      case 17:
        return "brloot_weapon_sh_mviktor_lege";
      case 18:
        return "brloot_weapon_pi_decho_lege";
      case 19:
        return "brloot_weapon_pi_golf17_lege";
      case 20:
        return "brloot_weapon_pi_golf18_lege";
      case 21:
        return "brloot_weapon_pi_papa220_lege";
      case 22:
        return "brloot_weapon_pi_swhiskey_lege";
      case 23:
        return "brloot_weapon_lm_ahotel_lege";
      case 24:
        return "brloot_weapon_lm_foxtrot_lege";
      case 25:
        return "brloot_weapon_lm_kilo21_lege";
      case 26:
        return "brloot_weapon_lm_ngolf7_lege";
      case 27:
        return "brloot_weapon_lm_rkilo_lege";
      case 28:
        return "brloot_weapon_lm_slima_lege";
      case 29:
        return "brloot_weapon_ar_mike4_lege";
      case 30:
        return "brloot_weapon_ar_mike16_lege";
      case 31:
        return "brloot_weapon_ar_kilo53_lege";
      case 32:
        return "brloot_weapon_ar_akilo_lege";
      case 33:
        return "brloot_weapon_ar_akilo105_lege";
      case 34:
        return "brloot_weapon_ar_akilo74_lege";
      case 35:
        return "brloot_weapon_ar_augolf_lege";
      case 36:
        return "brloot_weapon_ar_scharlie_lege";
      case 37:
        return "brloot_weapon_sm_alpha57_lege";
      case 38:
        return "brloot_weapon_sm_mpapa5_lege";
      case 39:
        return "brloot_weapon_sm_aviktor_lege";
      case 40:
        return "brloot_weapon_sm_beta_lege";
      case 41:
        return "brloot_weapon_sm_victor_lege";
      case 42:
        return "brloot_weapon_sm_apapa_lege";
      case 43:
        return "brloot_weapon_sm_papa90_lege";
      case 44:
        return "brloot_weapon_sm_mpapa7_lege";
    }
  }

  return undefined;
}

_id_46B4BD6590584475(data) {
  attacker = scripts\engine\utility::ter_op(isDefined(data.attacker), data.attacker, data.inflictor);

  if(isDefined(attacker))
    return istrue(attacker.zombie);

  return 0;
}