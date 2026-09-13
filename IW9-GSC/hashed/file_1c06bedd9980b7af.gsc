/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1c06bedd9980b7af.gsc
***********************************************/

_id_7B6E96193E81C072() {
  wait 6;
  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");
  thread _id_62E11D77B25C1D30::_id_5175593A7A2CCDB5();
  thread _id_62E11D77B25C1D30::_id_FC711A4308F52F72();
  level._id_93617D996E732D98 = ::_id_F8CAE53234697BBD;
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();
  checkpoint = scripts\engine\utility::ter_op(checkpoint != "", checkpoint, getDvar("start"));
  level._id_D017B9C13EC2BB69 = 1;

  switch (scripts\engine\utility::_id_53C4C53197386572(checkpoint, "silo")) {
    case "boss1_silo":
    case "silo":
    case "":
      _id_553E6252A4867E3E();
    case "boss1_silo_power":
    case "silo_power":
      _id_64A4FFB8F4617ECF();
    case "boss1_silo_2nd_stop":
    case "silo_2nd_stop":
      _id_01F3AC9B6672DFA6();
    case "boss1_silo_2nd_power":
      _id_257299C987860897();
    case "boss1_silo_end":
    case "silo_end":
      _id_F0B364E18B6D863B();
    case "boss1_fil":
    case "floor_is_lava":
      _id_405B25F99240FC45();
    case "boss1_fil_p":
    case "floor_is_lava_power":
      _id_FD2C08CAE78B5486();
    case "boss1_fil_end":
    case "floor_is_lava_end":
      _id_5050BBDC53CD02AA();
    case "boss1_fil_vent":
    case "floor_is_lava_vent":
      _id_7431244D9DF44D3E();
    case "boss1_fil_tripwire":
      _id_29C70580051E35D1();
    case "b1_p0":
    case "subpen_raise_water_1":
      _id_1044C8F0E0BA2ECC();
    case "b1_p1":
    case "subpen_raise_water_2":
      _id_AD12C8DF3C0A55B1();
    case "b1_p2":
    case "subpen_reach_catwalks":
      _id_E2D827F9A2573B4B();
    case "b1_p3":
    case "subpen_saw_doors":
      _id_744D949F22BE30B8();
    default:
      return;
  }
}

_id_82E02994003CFFF7(player) {
  player._id_EEF929505A9B77B9 = scripts\engine\utility::_id_53C4C53197386572(player._id_EEF929505A9B77B9, 0);
  player._id_AED624967395163B = _id_62E11D77B25C1D30::_id_B8AE7D3FFA2CE9D8;
  player thread _id_49EE7688C9CF1D19();
  player thread _id_8A52F776F04B11DB();
}

_id_553E6252A4867E3E() {
  thread _id_45572301BBA23853();
  thread _id_20FBB097F253EC6A();
  thread _id_E41215355603EF19();
  thread _id_9DF6CFE90A1FFFA1();
  thread _id_9BB9657FA3CC834E();
  thread _id_F6BEABA7B1F29C4C();
  scripts\engine\utility::flag_wait("elevator_raised");
}

_id_45572301BBA23853() {
  wait 1;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr3_silo_fara_wehavetostophadirfro", 0.2);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr3_silo_pric_hesgotenoughbloodonh", 0.3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr3_silo_alex_wellneedtoclosesomed", 0.2);
  scripts\engine\utility::flag_set("vo_siloIntroConvo_finished");
  _id_2EAE96A7007F0295 = (2969.1, 8854.64, 6312);
  _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(_id_2EAE96A7007F0295, 300);
  scripts\engine\utility::flag_set("vo_reachConcreteDoorway");
  thread _id_E5389EF51B2E45A3();
  thread _id_F7B52EA64AE2962F(_id_2EAE96A7007F0295);
  thread _id_11CDFC222C9421A2(_id_2EAE96A7007F0295);
}

_id_F6BEABA7B1F29C4C() {
  if(scripts\engine\utility::flag("elevator_raised")) {
    return;
  }
  level endon("elevator_raised");
  player = _id_A82D13FAA88CF41E(1);
  scripts\engine\utility::flag_set("vo_player_on_elevator_early");
}

_id_9DF6CFE90A1FFFA1() {
  level waittill("ai_killed");
  level waittill("ai_killed", _id_C9B351269A319209, sweapon, smeansofdeath, eattacker);
  level notify("vo_killedFirstTwoEnemies");
  wait 1;

  if(!isPlayer(eattacker))
    eattacker = _id_62E11D77B25C1D30::_id_167FAE92423447B9();

  aliases = ["dx_cp_cpr3_silo_fara_theyredown", "dx_cp_cpr3_silo_pric_theyredone", "dx_cp_cpr3_silo_alex_theyredown"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(eattacker, aliases, 0.2);
  aliases = ["dx_cp_cpr3_silo_fara_keepmoving", "dx_cp_cpr3_silo_pric_checkthosecorners", "dx_cp_cpr3_silo_alex_letsmove"];
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(eattacker);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_E5389EF51B2E45A3() {
  level endon("vo_spotElevator");

  while(getaiarray().size > 0)
    level waittill("ai_killed");

  wait 1;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr3_silo_fara_wherewashadirgoing", 1.3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr3_silo_alex_soundedliketheyfound", 0.4);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr3_silo_alex_thatsallicouldpickup", 0.5);
}

_id_9BB9657FA3CC834E() {
  player = _id_62E11D77B25C1D30::_id_4E943B7BA4CCBBE8(0, 5200);
  aliases = ["dx_cp_cpr3_slpw_fara_ihearsomething", "dx_cp_cpr3_slpw_pric_listen", "dx_cp_cpr3_sl2s_alex_whatsmakingthatsound"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0, 0, 0);
  _id_EEC55FABA21F3653 = (5539.55, 11405.3, 6378.41);
  aliases = ["dx_cp_cpr3_slpw_fara_theresanexit", "dx_cp_cpr3_slpw_pric_egress", "dx_cp_cpr3_slpw_alex_egressabove"];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_EEC55FABA21F3653, 0.5, 0.3, 0, [], 1200)[0];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  aliases = ["dx_cp_cpr3_slpw_fara_dowehavecomms", "dx_cp_cpr3_slpw_pric_checkcomms", "dx_cp_cpr3_slpw_alex_anysignal"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(player.origin, player);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.6);
  scripts\engine\utility::flag_set("vo_spotElevator");
  aliases = ["dx_cp_cpr3_slpw_fara_watcher1doyouread", "dx_cp_cpr3_slpw_pric_watcher1youread", "dx_cp_cpr3_slpw_alex_watcher1commscheck"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);

  if(player._id_938E8B2CA6549759 == "alex")
    level _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.4, "dx_cp_cpr3_slpw_lasw_echo31sendtraffic");
  else
    level _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.4, "dx_cp_cpr3_slpw_lasw_copysendtraffic");

  aliases = ["dx_cp_cpr3_slpw_fara_wefoundalexbuthadirh", "dx_cp_cpr3_slpw_pric_wehavealexhadirhasth", "dx_cp_cpr3_slpw_alex_imwithpriceandcomman"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);
  level _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.3, "dx_cp_cpr3_slpw_lasw_copythatareyoustilla");
  aliases = ["dx_cp_cpr3_slpw_fara_affirmativecontactga", "dx_cp_cpr3_slpw_pric_afirmcontactgazgetus", "dx_cp_cpr3_slpw_alex_afirmcontactgazwelln"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  level _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.5, "dx_cp_cpr3_slpw_lasw_onitwatcherout");
}

_id_20FBB097F253EC6A() {
  level endon("vo_reachConcreteDoorway");
  level endon("vo_reachedConcreateRoom");

  if(scripts\engine\utility::flag("vo_reachConcreteDoorway") || scripts\engine\utility::flag("vo_reachedConcreateRoom")) {
    return;
  }
  scripts\engine\utility::flag_wait("vo_siloIntroConvo_finished");
  _id_6D0F2A79E074E9CD = (2367.97, 8686.78, 6347.64);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_6D0F2A79E074E9CD, 0.7, 0.3, 0, [], 300)[0];
  wait 2;
  aliases = ["dx_cp_cpr3_silo_fara_letsmove", "dx_cp_cpr3_silo_pric_moveout", "dx_cp_cpr3_silo_alex_letsmoveout"];
  players = level.players;

  for(delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(5, 11, 3); players.size > 0; players = scripts\engine\utility::array_remove(players, player)) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F(players);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
  }
}

_id_E41215355603EF19() {
  _id_D6ABABB25607E3A1 = (2908.55, 8693.2, 6370);
  scripts\engine\utility::flag_wait("vo_siloIntroConvo_finished");
  aliases = ["dx_cp_cpr3_silo_fara_clear", "dx_cp_cpr3_silo_pric_clear", "dx_cp_cpr3_silo_alex_wereclear"];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_D6ABABB25607E3A1, 0.7, 0.3, 0, [], 600)[0];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);
  scripts\engine\utility::flag_set("vo_reachedConcreateRoom");
}

_id_11CDFC222C9421A2(_id_2EAE96A7007F0295) {
  level endon("vo_killedFirstTwoEnemies");
  aliases = ["dx_cp_cpr3_silo_fara_twoaq", "dx_cp_cpr3_silo_pric_twoxrays", "dx_cp_cpr3_silo_alex_aqsaheadtwoofem"];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(::getaiarray, 0.9, 0.5, 0)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  scripts\engine\utility::flag_wait_or_timeout("vo_combat", 5);
  aliases = ["dx_cp_cpr3_silo_fara_shootthem", "dx_cp_cpr3_silo_pric_weaponsfree", "dx_cp_cpr3_silo_alex_letshitem"];
  player = _id_62E11D77B25C1D30::_id_167FAE92423447B9();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_F7B52EA64AE2962F(_id_2EAE96A7007F0295) {
  ai = sortbydistance(getaiarray(), _id_2EAE96A7007F0295);
  aq_soldier_1 = ai[0];
  aq_soldier_2 = ai[1];
  _id_30A1D5FCC9E17015(aq_soldier_1, aq_soldier_2);

  if(isalive(aq_soldier_1))
    aq_soldier_1 _id_5D265B4FCA61F070::_id_5510C489D7F09128();

  if(isalive(aq_soldier_2))
    aq_soldier_2 _id_5D265B4FCA61F070::_id_5510C489D7F09128();
}

_id_30A1D5FCC9E17015(aq_soldier_1, aq_soldier_2) {
  if(!isalive(aq_soldier_1) || !isalive(aq_soldier_2)) {
    return;
  }
  level endon("vo_combat");

  if(scripts\engine\utility::flag("vo_combat")) {
    return;
  }
  aq_soldier_1 endon("death");
  aq_soldier_2 endon("death");
  aq_soldier_1 _id_5D265B4FCA61F070::say("dx_cp_cpr3_silo_aqs1_doyouthinkshellliste", 0.4);
  aq_soldier_2 _id_5D265B4FCA61F070::say("dx_cp_cpr3_silo_aqs2_ifsheisassmartashesa", 0.3);
  aq_soldier_1 _id_5D265B4FCA61F070::say("dx_cp_cpr3_silo_aqs1_hissisterisablindspo", 0.5);
  aq_soldier_2 _id_5D265B4FCA61F070::say("dx_cp_cpr3_silo_aqs2_thenwekillherandever", 0.3);
}

_id_64A4FFB8F4617ECF() {
  thread _id_B79FD1C4A5042FE7();
  thread _id_A6D554789ED34D26();
  thread _id_6040395E0B0C765F();
  thread _id_2212ABCDE587D0D6([(6516.21, 11936.2, 5778), (6562.72, 11162, 5770.64)]);
  thread _id_2212ABCDE587D0D6([(5099.45, 12513.5, 5211.98), (5931.28, 12566.5, 5211.21)]);
  thread _id_2212ABCDE587D0D6([(6911.05, 11532.8, 4088)]);
  thread _id_2212ABCDE587D0D6([(5535.52, 12906.6, 4088)]);
  thread _id_64B9DCF165F9528A();
  thread _id_2D96EE72119D1914();
  scripts\engine\utility::flag_wait("vo_siloPowerPressElevatorControls");
  thread _id_107DE502A6377099();
  thread _id_E618F1EFA68146FA();
  thread _id_9CAC43C4EF486D18();
  thread _id_9E52C2FC05F5DC04();
  scripts\engine\utility::flag_wait("vo_generatorPoweredOn");
  thread _id_4B72C6C519997AD9();
  level._id_142FFEF4BA6476C6 waittill("stop_moving");
}

_id_2D96EE72119D1914() {
  player = _id_A82D13FAA88CF41E(1);

  if(!scripts\engine\utility::flag("vo_player_on_elevator_early")) {
    aliases = ["dx_cp_cpr3_slpw_fara_madeit", "dx_cp_cpr3_slpw_pric_madeit", "dx_cp_cpr3_slpw_alex_gotit"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4, 0, 0);

    if(scripts\engine\utility::flag("vo_siloPowerPressElevatorControls")) {
      aliases = ["dx_cp_cpr3_slpw_fara_itsstable", "dx_cp_cpr3_slpw_pric_seemssolid", "dx_cp_cpr3_slpw_alex_feelsstableenough"];
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);
    }
  }

  if(!scripts\engine\utility::flag("vo_siloPowerSpotElevatorControls") && !scripts\engine\utility::flag("vo_siloPowerPressElevatorControls"))
    thread _id_E849CAAFCA8D5CF9();
}

_id_64B9DCF165F9528A() {
  level._id_142FFEF4BA6476C6 waittill("stop_moving");
  wait 2;
  aliases = ["dx_cp_cpr3_slpw_fara_werenotmoving", "dx_cp_cpr3_slpw_pric_theliftsdead", "dx_cp_cpr3_slpw_alex_elevatorsstopped"];
  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F(_id_00DE4CC4721B71B4());
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  thread _id_E7D77F98FCC10A26();
  thread _id_EE0C8A901810CEE9();

  while(scripts\engine\utility::flag("vo_combat")) {
    scripts\engine\utility::flag_waitopen("vo_combat");
    wait 3;
  }

  aliases = ["dx_cp_cpr3_slpw_fara_aqshutoffthepower", "dx_cp_cpr3_slpw_pric_aqkilledthepower", "dx_cp_cpr3_slpw_alex_nopoweraqmustveshuti"];
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  aliases = ["dx_cp_cpr3_slpw_fara_letsgetitbackon", "dx_cp_cpr3_slpw_pric_thenletsswitchitback", "dx_cp_cpr3_slpw_alex_weneedtoturnitbackon"];
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  _id_277B23D89B6BF476 = ["dx_cp_cpr3_slpw_fara_wellhavetosearchthea", "dx_cp_cpr3_slpw_pric_wellsearchthealcoves", "dx_cp_cpr3_slpw_alex_wecansearchthealcove"];
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_277B23D89B6BF476, 0.5);
  _id_830F00AE40ED9102();
  players = _id_6D9F25F0B3035358(level._id_142FFEF4BA6476C6.origin[2] + 300);

  if(players.size == 1) {
    player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(players[0]);
    aliases = _id_C0B1DC1379FF2380(players[0]);
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, level._id_F8AA66E82BC58937, 0.4);
  }

  thread _id_AF309B2B66822F7E(_id_277B23D89B6BF476, player);
  thread _id_2ACAFD8B60D4FA24();
  thread _id_2E9C040480350718();
  thread _id_7FF84F0C12F37B4C();
  thread _id_C4138CD6A8965990();
  thread _id_D70616CEC1CFDCB5();
  thread _id_B5B7107B9966F900();
  thread _id_5B68A059136F0C4F();
  thread _id_7E8946C448A83AE3();
}

_id_5B68A059136F0C4F() {
  if(scripts\engine\utility::flag("vo_searchingNorthAlcove")) {
    return;
  }
  level endon("vo_searchingNorthAlcove");
  _id_92448ABEA0C6CCBA = (6043.75, 11527.9, 4648.38);
  _id_3F95846D7D0D8E74 = (5035.04, 11525.2, 4642);
  result = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803([_id_92448ABEA0C6CCBA, _id_3F95846D7D0D8E74], 0.8, 0.5, 0, [], 1000);
  scripts\engine\utility::flag_set("vo_dontNagAlcoves");
  player = result[0];

  if(_id_6D9F25F0B3035358(_id_03AEFA52C1689CD3()[2] - 150).size == 0) {
    return;
  }
  aliases = ["dx_cp_cpr3_slpw_fara_theresanotheralcoveb", "dx_cp_cpr3_slpw_pric_anotheralcovesdownth", "dx_cp_cpr3_slpw_alex_gotanotheralcovebelo"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);

  if(result[1] == _id_3F95846D7D0D8E74)
    scripts\engine\utility::flag_set("vo_spottedSouthAlcove");

  _id_01CA1E16FD3E7F57 = scripts\engine\utility::array_remove([_id_92448ABEA0C6CCBA, _id_3F95846D7D0D8E74], result[1]);
  result = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_01CA1E16FD3E7F57, 0.8, 0.5, 0, [], 1000, undefined, 5);

  if(isDefined(result)) {
    scripts\engine\utility::flag_set("vo_spottedBothAlcoves");
    aliases = ["dx_cp_cpr3_slpw_fara_makethattwo", "dx_cp_cpr3_slpw_pric_makethattwo", "dx_cp_cpr3_slpw_alex_makethattwo"];
    player = result[0];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);

    if(player.origin[2] > _id_03AEFA52C1689CD3()[2] - 150) {
      aliases = ["dx_cp_cpr3_slpw_fara_ithinkwecanreachthem", "dx_cp_cpr3_slpw_pric_theyreclose", "dx_cp_cpr3_slpw_alex_theyrenotfar"];
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 1.3);
    }
  } else if(player.origin[2] > _id_03AEFA52C1689CD3()[2] - 150) {
    aliases = ["dx_cp_cpr3_slpw_fara_ithinkwecanreachit", "dx_cp_cpr3_slpw_pric_itsclose", "dx_cp_cpr3_slpw_alex_itsnotfar"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  }

  wait 2;
  players = _id_00DE4CC4721B71B4();

  if(players.size > 1) {
    player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F(players);
    aliases = ["dx_cp_cpr3_slpw_fara_wellhavetojumpdown", "dx_cp_cpr3_slpw_pric_letsjumpdownthere", "dx_cp_cpr3_slpw_alex_lookslikewerejumping"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  }

  wait 3;
  scripts\engine\utility::flag_clear("vo_dontNagAlcoves");
}

_id_2ACAFD8B60D4FA24() {
  aliases = ["dx_cp_cpr3_slpw_fara_imsearchingwest", "dx_cp_cpr3_slpw_pric_illcheckwest", "dx_cp_cpr3_slpw_alex_illtakethewestalcove"];
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((5650.11, 12064.8, 5051.99), (5453.31, 12354.1, 5558.32), 0);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  scripts\engine\utility::flag_set("vo_searchingAlcoves");
}

_id_AF309B2B66822F7E(_id_277B23D89B6BF476, player) {
  if(scripts\engine\utility::flag("vo_searchingAlcoves")) {
    return;
  }
  level endon("vo_searchingAlcoves");
  _id_277B22D89B6BF243 = ["dx_cp_cpr3_slpw_fara_wehavetogetthepowero", "dx_cp_cpr3_slpw_pric_weneedthepowerbackon", "dx_cp_cpr3_slpw_alex_ifwedontgetthispower"];
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(8, 23, 6);
  aliases = scripts\engine\utility::create_deck([_id_277B22D89B6BF243, _id_277B23D89B6BF476]);
  players = scripts\engine\utility::array_randomize(level.players);

  if(scripts\engine\utility::is_equal(players[0], player)) {
    players = scripts\engine\utility::array_remove(players, player);
    players = scripts\engine\utility::array_insert(players, player, 1);
  }

  foreach(player in players) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);

    while(scripts\engine\utility::flag("vo_dontNagAlcoves") || scripts\engine\utility::flag("vo_combat")) {
      scripts\engine\utility::flag_waitopen("vo_dontNagAlcoves");
      scripts\engine\utility::flag_waitopen("vo_combat");
      wait 1;
    }

    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases scripts\engine\utility::deck_draw(), 0.4);
  }
}

_id_EE0C8A901810CEE9() {
  scripts\engine\utility::flag_waitopen_or_timeout("vo_combat", 8);

  if(scripts\engine\utility::flag("vo_combat")) {
    aliases = ["dx_cp_cpr3_slpw_fara_weregettingpinneddow", "dx_cp_cpr3_slpw_pric_weneedtoslotthesebas", "dx_cp_cpr3_slpw_alex_sittinducksuphere"];
    player = _id_62E11D77B25C1D30::_id_167FAE92423447B9(_id_00DE4CC4721B71B4());
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  }
}

_id_B79FD1C4A5042FE7() {
  level endon("vo_siloPowerPressElevatorControls");
  level endon("vo_siloPowerSpotElevatorControls");
  _id_48497D676003002B = (5602.04, 10894.3, 6362.85);
  aliases = ["dx_cp_cpr3_slpw_fara_controlsarehere", "dx_cp_cpr3_slpw_pric_liftcontrolshere", "dx_cp_cpr3_slpw_alex_foundthecontrols"];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_48497D676003002B, 0.8, 0.3, 0, [], 130)[0];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  thread _id_534FE41003867536();
  scripts\engine\utility::flag_set("vo_siloPowerSpotElevatorControls");
}

_id_A6D554789ED34D26() {
  level waittill("player_interaction_success", player, ent);

  while(ent.targetname != "silo_power_switch_0")
    level waittill("player_interaction_success", player, ent);

  if(scripts\engine\utility::flag("vo_siloPowerGettingControls"))
    aliases = ["dx_cp_cpr3_slpw_fara_herewego", "dx_cp_cpr3_slpw_pric_eregoes", "dx_cp_cpr3_slpw_alex_downwego"];
  else
    aliases = ["dx_cp_cpr3_slpw_fara_usingthebutton", "dx_cp_cpr3_slpw_pric_usingthelift", "dx_cp_cpr3_slpw_alex_usingthebutton"];

  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 1, 0.5);
  scripts\engine\utility::flag_set("vo_siloPowerPressElevatorControls");
  _id_EEC55FABA21F3653 = (5539.55, 11405.3, 6378.41);
  wait 3;
  _id_2E063712F5ECAF3A = _id_00DE4CC4721B71B4();
  _id_102284B812A3E17F = level.players.size - 1;

  if(_id_2E063712F5ECAF3A.size < _id_102284B812A3E17F) {
    player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_EEC55FABA21F3653, level.players);
    aliases = ["dx_cp_cpr3_slpw_fara_itsmoving", "dx_cp_cpr3_slpw_pric_theliftsmovin", "dx_cp_cpr3_slpw_alex_itsheadeddown"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1, 1, 0.3);
  } else if(_id_2E063712F5ECAF3A.size == _id_102284B812A3E17F) {
    player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F(_id_2E063712F5ECAF3A);
    aliases = ["dx_cp_cpr3_slpw_fara_weremoving", "dx_cp_cpr3_slpw_pric_weremoving", "dx_cp_cpr3_slpw_alex_weremoving"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  } else
    return;

  wait 3;
  _id_2E063712F5ECAF3A = _id_00DE4CC4721B71B4();

  if(_id_2E063712F5ECAF3A.size < _id_102284B812A3E17F) {
    result = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_EEC55FABA21F3653, 0.6, 0, 0, _id_2E063712F5ECAF3A, 700, undefined, 0.5);

    if(isDefined(result))
      player = result[0];
    else
      player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_EEC55FABA21F3653, level.players, _id_2E063712F5ECAF3A);

    aliases = ["dx_cp_cpr3_slpw_fara_jumpdown", "dx_cp_cpr3_slpw_pric_jumpforit", "dx_cp_cpr3_slpw_alex_weneedtojumpnow"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  } else if(_id_2E063712F5ECAF3A.size == _id_102284B812A3E17F) {
    foreach(player in level.players) {
      if(!scripts\engine\utility::array_contains(_id_2E063712F5ECAF3A, player)) {
        break;
      }
    }

    aliases = _id_C0B1DC1379FF2380(player);
    player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F(_id_2E063712F5ECAF3A);
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1, 0, 1);
    aliases = ["dx_cp_cpr3_slpw_fara_jumptous", "dx_cp_cpr3_slpw_pric_jumpdown", "dx_cp_cpr3_slpw_alex_jumpdowntous"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 0, 2);
  }
}

_id_C0B1DC1379FF2380(player, _id_531A7B24A3184A02) {
  aliases = undefined;

  if(istrue(_id_531A7B24A3184A02)) {
    if(player._id_938E8B2CA6549759 == "farah")
      aliases = [undefined, "dx_cp_cpr3_sl2s_pric_farah", "dx_cp_cpr3_sl2s_alex_commander"];
    else if(player._id_938E8B2CA6549759 == "price")
      aliases = ["dx_cp_cpr3_sl2s_fara_price", undefined, "dx_cp_cpr3_sl2s_alex_captain"];
    else if(player._id_938E8B2CA6549759 == "alex")
      aliases = ["dx_cp_cpr3_sl2s_fara_alex", "dx_cp_cpr3_sl2s_pric_alex"];
  } else if(player._id_938E8B2CA6549759 == "farah")
    aliases = [undefined, "dx_cp_cpr3_slpw_pric_farah", "dx_cp_cpr3_slpw_alex_farah"];
  else if(player._id_938E8B2CA6549759 == "price")
    aliases = ["dx_cp_cpr3_slpw_fara_price", undefined, "dx_cp_cpr3_slpw_alex_price"];
  else if(player._id_938E8B2CA6549759 == "alex")
    aliases = ["dx_cp_cpr3_slpw_fara_alex", "dx_cp_cpr3_slpw_pric_alex"];

  return aliases;
}

_id_A82D13FAA88CF41E(_id_59F02C6C6C928ED3) {
  _id_59F02C6C6C928ED3 = scripts\engine\utility::_id_53C4C53197386572(_id_59F02C6C6C928ED3, 0);

  for(;;) {
    players = _id_00DE4CC4721B71B4(_id_59F02C6C6C928ED3);

    if(players.size > 0)
      return scripts\engine\utility::random(players);

    waitframe();
  }
}

_id_03AEFA52C1689CD3() {
  up = anglestoup(level._id_142FFEF4BA6476C6.angles);
  return level._id_142FFEF4BA6476C6._id_BD901692981B143A.origin - up * 10725;
}

_id_9FE3EDDD988585DF() {
  return scripts\engine\utility::array_remove_array(level.players, _id_00DE4CC4721B71B4());
}

_id_00DE4CC4721B71B4(_id_59F02C6C6C928ED3) {
  if(!isDefined(level._id_142FFEF4BA6476C6))
    return [];

  _id_59F02C6C6C928ED3 = scripts\engine\utility::_id_53C4C53197386572(_id_59F02C6C6C928ED3, 0);
  forward = anglesToForward(level._id_142FFEF4BA6476C6.angles);
  right = anglestoright(level._id_142FFEF4BA6476C6.angles);
  up = anglestoup(level._id_142FFEF4BA6476C6.angles);
  _id_12B397CBEAAB23B6 = level._id_142FFEF4BA6476C6._id_BD901692981B143A.origin;
  _id_12B397CBEAAB23B6 = _id_12B397CBEAAB23B6 - forward * 150;
  _id_12B397CBEAAB23B6 = _id_12B397CBEAAB23B6 - right * 150;
  _id_12B397CBEAAB23B6 = _id_12B397CBEAAB23B6 - up * 10725;
  origin2 = level._id_142FFEF4BA6476C6._id_BD901692981B143A.origin;
  origin2 = origin2 + forward * 150;
  origin2 = origin2 + right * 150;
  origin2 = origin2 - up * 10575;
  players = [];

  foreach(player in level.players) {
    if(_id_4A68B63FC8E6542F(player, _id_12B397CBEAAB23B6, origin2) && (!_id_59F02C6C6C928ED3 || player isonground()))
      players[players.size] = player;
  }

  return players;
}

_id_4A68B63FC8E6542F(player, _id_12B397CBEAAB23B6, origin2) {
  angles = level._id_142FFEF4BA6476C6.angles;
  forward = anglesToForward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);

  if(!isDefined(_id_12B397CBEAAB23B6)) {
    _id_12B397CBEAAB23B6 = level._id_142FFEF4BA6476C6._id_BD901692981B143A.origin;
    _id_12B397CBEAAB23B6 = _id_12B397CBEAAB23B6 - forward * 150;
    _id_12B397CBEAAB23B6 = _id_12B397CBEAAB23B6 - right * 150;
    _id_12B397CBEAAB23B6 = _id_12B397CBEAAB23B6 - up * 10725;
  }

  if(!isDefined(origin2)) {
    origin2 = level._id_142FFEF4BA6476C6._id_BD901692981B143A.origin;
    origin2 = origin2 + forward * 150;
    origin2 = origin2 + right * 150;
    origin2 = origin2 - up * 10575;
  }

  return vectordot(player.origin - _id_12B397CBEAAB23B6, forward) > 0 && vectordot(player.origin - origin2, forward) < 0 && vectordot(player.origin - _id_12B397CBEAAB23B6, right) > 0 && vectordot(player.origin - origin2, right) < 0 && vectordot(player.origin - _id_12B397CBEAAB23B6, up) > 0 && vectordot(player.origin - origin2, up) < 0;
}

_id_49EE7688C9CF1D19() {
  if(!isDefined(level._id_E251A6BC300A83DB)) {
    _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_slpw_fara_painlandingeffort", "dx_cp_cpr3_slpw_fara_painlandingeffort_01", "dx_cp_cpr3_slpw_fara_painlandingeffort_02"]);
    _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_slpw_pric_painlandingeffort", "dx_cp_cpr3_slpw_pric_painlandingeffort_01", "dx_cp_cpr3_slpw_pric_painlandingeffort_02"]);
    _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_slpw_alex_painlandingeffort", "dx_cp_cpr3_slpw_alex_painlandingeffort_01", "dx_cp_cpr3_slpw_alex_painlandingeffort_02"]);
    level._id_E251A6BC300A83DB = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  }

  for(;;) {
    self waittill("damage", damage, attacker, dir, point, type);

    if(scripts\engine\utility::is_equal(type, "MOD_FALLING"))
      thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(self, level._id_E251A6BC300A83DB, 0, 0, 0);
  }
}

_id_8A52F776F04B11DB() {}

_id_EE79512FB7410469() {
  self endon("death_or_disconnect");

  while(isalive(self) && !self isonground())
    waitframe();

  if(isDefined(self) && !self isspectatingplayer())
    _id_5D265B4FCA61F070::_id_5510C489D7F09128(0, 0);
}

_id_E849CAAFCA8D5CF9() {
  level endon("vo_siloPowerPressElevatorControls");
  level endon("vo_siloPowerSpotElevatorControls");
  _id_48497D676003002B = (5602.04, 10894.3, 6362.85);
  aliases = ["dx_cp_cpr3_slpw_fara_controlsareonthewall", "dx_cp_cpr3_slpw_pric_controlsareonthewall", "dx_cp_cpr3_slpw_alex_controlsareonthewall"];

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_48497D676003002B, 0.9, 0.3, 0, [], 800)[0]; !_id_4A68B63FC8E6542F(player); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_48497D676003002B, 0.9, 0.3, 0, [], 800)[0]) {}

  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  thread _id_534FE41003867536();
  thread _id_E27EF9B8167823EB();
  scripts\engine\utility::flag_set("vo_siloPowerSpotElevatorControlsFromElevator");
  scripts\engine\utility::flag_set("vo_siloPowerSpotElevatorControls");
}

_id_534FE41003867536() {
  level endon("vo_siloPowerPressElevatorControls");

  if(scripts\engine\utility::flag("vo_siloPowerPressElevatorControls")) {
    return;
  }
  players = scripts\engine\utility::create_deck(scripts\engine\utility::array_randomize(level.players));
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(5, 15, 4);

  for(;;) {
    _id_62E11D77B25C1D30::_id_936A98F2467DD886(delay, "vo_siloPowerGettingControls");
    aliases = ["dx_cp_cpr3_slpw_fara_wellhavetousetheelev", "dx_cp_cpr3_slpw_pric_theliftsouronlyoptio", "dx_cp_cpr3_slpw_alex_theelevatorsouronlyw"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(players scripts\engine\utility::deck_draw(), aliases, 0.3);
    _id_62E11D77B25C1D30::_id_936A98F2467DD886(delay, "vo_siloPowerGettingControls");
    aliases = ["dx_cp_cpr3_slpw_fara_usethebutton", "dx_cp_cpr3_slpw_pric_hitthebutton", "dx_cp_cpr3_slpw_alex_hitit"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(players scripts\engine\utility::deck_draw(), aliases, 0.3);
  }
}

_id_E27EF9B8167823EB() {
  _id_48497D676003002B = (5617.02, 11000.3, 6361.68);
  wait 0.3;
  players = sortbydistance(level.players, _id_48497D676003002B);
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((5360.37, 11116.7, 6215.57), (5724.77, 10726.9, 6474.89), 0, players);
  aliases = ["dx_cp_cpr3_slpw_fara_ivegotit", "dx_cp_cpr3_slpw_pric_illdoit", "dx_cp_cpr3_slpw_alex_imonit"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  scripts\engine\utility::flag_set("vo_siloPowerGettingControls");
}

_id_E618F1EFA68146FA() {
  _id_8999BA6CDAF041DB = (5995.4, 11522.6, 5800.8);
  aliases = ["dx_cp_cpr3_slpw_fara_aqnorthside", "dx_cp_cpr3_slpw_pric_contactnorth", "dx_cp_cpr3_slpw_alex_contactnorthside"];

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_8999BA6CDAF041DB, 0.7, 0.3, 0, [], 1500)[0]; getaiarrayinradius(_id_8999BA6CDAF041DB, 800).size == 0 || !_id_4A68B63FC8E6542F(player); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_8999BA6CDAF041DB, 0.85, 0.3, 0, [], 1500)[0]) {}

  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_8999BA6CDAF041DB, 0.85, 0.3, 0, [], 1500)[0]; getaiarrayinradius(_id_8999BA6CDAF041DB, 800).size > 0 || !_id_4A68B63FC8E6542F(player); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_8999BA6CDAF041DB, 0.85, 0.3, 0, [], 1500)[0]) {}

  thread _id_F762BCE14CF88FD4();
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, level._id_A255EA1FB0E213E7, 0.4);
}

_id_9CAC43C4EF486D18() {
  _id_5B61A1809E7950C9 = (5539.77, 11952, 5210);
  aliases = ["dx_cp_cpr3_slpw_fara_onourwest", "dx_cp_cpr3_slpw_pric_checkwest", "dx_cp_cpr3_slpw_alex_moreaqwestside"];

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_5B61A1809E7950C9, 0.7, 0.3, 0, [], 1500)[0]; getaiarrayinradius(_id_5B61A1809E7950C9, 800).size == 0 || !_id_4A68B63FC8E6542F(player); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_5B61A1809E7950C9, 0.85, 0.3, 0, [], 1500)[0]) {}

  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_5B61A1809E7950C9, 0.85, 0.3, 0, [], 1500)[0]; getaiarrayinradius(_id_5B61A1809E7950C9, 800).size > 0 || !_id_4A68B63FC8E6542F(player); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_5B61A1809E7950C9, 0.85, 0.3, 0, [], 1500)[0]) {}
}

_id_9E52C2FC05F5DC04() {
  _id_915146A21501433D = (5928.53, 11519.6, 4642);
  aliases = ["dx_cp_cpr3_slpw_fara_belowus", "dx_cp_cpr3_slpw_pric_underus", "dx_cp_cpr3_slpw_alex_theyreunderus"];

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_915146A21501433D, 0.7, 0.3, 0, [], 1500)[0]; getaiarrayinradius(_id_915146A21501433D, 800).size == 0 || !_id_4A68B63FC8E6542F(player); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_915146A21501433D, 0.85, 0.3, 0, [], 1500)[0]) {}

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_107DE502A6377099() {
  aliases = ["dx_cp_cpr3_slpw_fara_imgoing", "dx_cp_cpr3_slpw_pric_imcrossing", "dx_cp_cpr3_slpw_alex_imgoingover"];
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((6050.53, 11149.9, 5892.18), (5754.96, 11865.5, 5627.11), 0);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0);
  aliases = ["dx_cp_cpr3_slpw_fara_makeitfast", "dx_cp_cpr3_slpw_pric_moveyerarse", "dx_cp_cpr3_slpw_alex_movefast"];
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_E7D77F98FCC10A26() {
  _id_62E11D77B25C1D30::_id_1D977083C90B0996((6059.57, 12054, 5970.81), (5011.46, 11009.1, 4484.31));
  wait 1;
  aliases = ["dx_cp_cpr3_srw1_fara_clear", "dx_cp_cpr3_srw1_pric_wereclear", "dx_cp_cpr3_srw1_alex_clear"];
  player = _id_62E11D77B25C1D30::_id_167FAE92423447B9(_id_00DE4CC4721B71B4());
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4, 0, 1);
}

_id_6040395E0B0C765F() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr3_slpw_fara_nothinginhere";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_fara_nothinghere";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_fara_nothing";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_fara_nothingitsclear";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_fara_thisonesclear";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_fara_itsclear";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_fara_clearinthisone";
  _id_C9A17BCFBDFCE146 = scripts\engine\utility::create_deck(aliases, 1, 0);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr3_slpw_pric_nothinghere";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_pric_nothinginthisone";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_pric_gotnothinginhere";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_pric_nothingsinhere";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_pric_thisonesclear";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_pric_alcovesclear";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_pric_thisalcovesclear";
  _id_AC883563535E1D5D = scripts\engine\utility::create_deck(aliases, 1, 0);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr3_slpw_alex_nothinginthisone";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_alex_nothing";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_alex_dryholenothinghere";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_alex_thisonesclean";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_alex_clearedthisone";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_alex_thisalcovesclear";
  aliases[aliases.size] = "dx_cp_cpr3_slpw_alex_alcovesclear";
  _id_8803F509C087BB78 = scripts\engine\utility::create_deck(aliases, 1, 0);
  level._id_81718FEAD161E1B4 = [_id_C9A17BCFBDFCE146, _id_AC883563535E1D5D, _id_8803F509C087BB78];
}

_id_2212ABCDE587D0D6(origins) {
  player = _id_BD3828A9F489F6A8(origins, 0.8, 0.4, 800);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, level._id_81718FEAD161E1B4, 0.3);
}

_id_BD3828A9F489F6A8(origins, dot, holdtime, maxdistance, _id_8EB32C573C5D5263, _id_94564218DD6125B9) {
  result = undefined;

  while(origins.size > 0) {
    result = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(origins, dot, holdtime, 0, _id_94564218DD6125B9, maxdistance);

    if(istrue(_id_8EB32C573C5D5263) || getaiarrayinradius(result[1], 400).size == 0)
      origins = scripts\engine\utility::array_remove(origins, result[1]);
  }

  if(isDefined(result))
    return result[0];
}

_id_830F00AE40ED9102() {
  aliases = ["dx_cp_cpr3_slpw_fara_youllhavetojumpdown", "dx_cp_cpr3_slpw_fara_jumpdownhere", "dx_cp_cpr3_slpw_fara_becarefulwhenyoujump"];
  _id_C9A17BCFBDFCE146 = scripts\engine\utility::create_deck(aliases, 1, 0);
  aliases = ["dx_cp_cpr3_slpw_pric_rallydownhere", "dx_cp_cpr3_slpw_pric_getbackdownhere", "dx_cp_cpr3_slpw_pric_jumpbackdown"];
  _id_AC883563535E1D5D = scripts\engine\utility::create_deck(aliases, 1, 0);
  aliases = ["dx_cp_cpr3_slpw_alex_downhere", "dx_cp_cpr3_slpw_alex_jumpdowntotheelevato", "dx_cp_cpr3_slpw_alex_headbackdownhere"];
  _id_8803F509C087BB78 = scripts\engine\utility::create_deck(aliases, 1, 0);
  level._id_F8AA66E82BC58937 = [_id_C9A17BCFBDFCE146, _id_AC883563535E1D5D, _id_8803F509C087BB78];
}

_id_2E9C040480350718() {
  level endon("vo_spotFirstGenerator");

  if(scripts\engine\utility::flag("vo_spotFirstGenerator")) {
    return;
  }
  aliases = ["dx_cp_cpr3_slpw_fara_movingnorth", "dx_cp_cpr3_slpw_pric_checkingnorth", "dx_cp_cpr3_slpw_alex_searchingnorth"];
  player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B((6078.43, 11530.1, 4590.38), 200)[0];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  scripts\engine\utility::flag_set("vo_searchingAlcoves");
  scripts\engine\utility::flag_set("vo_searchingNorthAlcove");
  scripts\engine\utility::flag_clear("vo_dontNagAlcoves");
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803((6914.25, 11525.6, 4649.75), 0.7, 0.5, 0, [], 300)[0];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, level._id_81718FEAD161E1B4, 0.4);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803((4901.47, 11532.1, 4642), 0.7, 0.3, 0, [], 1350)[0];

  if(!scripts\engine\utility::flag("vo_spottedSouthAlcove") && !scripts\engine\utility::flag("vo_spottedBothAlcoves")) {
    aliases = ["dx_cp_cpr3_slpw_fara_looksouththeresathir", "dx_cp_cpr3_slpw_pric_checksouththeresathi", "dx_cp_cpr3_slpw_alex_gotathirdalcovetothe"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  } else {
    aliases = ["dx_cp_cpr3_slpw_fara_theressomethinginthe", "dx_cp_cpr3_slpw_pric_checkalcove9southsom", "dx_cp_cpr3_slpw_alex_somethingsinthesouth"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  }

  aliases = ["dx_cp_cpr3_slpw_fara_weneedawaytogetacros", "dx_cp_cpr3_slpw_pric_lookforawaytocross", "dx_cp_cpr3_slpw_alex_weneedtogetacross"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((6075.46, 11229.5, 4449.39), (5010.5, 10915, 4830.5), 1);
  aliases = ["dx_cp_cpr3_slpw_fara_hereusethese", "dx_cp_cpr3_slpw_pric_thesellholdus", "dx_cp_cpr3_slpw_alex_thesearesturdyenough"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_7FF84F0C12F37B4C() {
  level endon("vo_endNearMisses");
  level endon("vo_generatorPoweredOn");

  if(scripts\engine\utility::flag("vo_generatorPoweredOn")) {
    return;
  }
  for(;;) {
    foreach(player in level.players) {
      if(player _meth_415FE9EECA7B2E2B() && !istrue(player._id_3ED7B70127C2A141)) {
        player._id_3ED7B70127C2A141 = 1;
        thread _id_71DD0A942266F224(player);
        continue;
      }

      if(!player _meth_415FE9EECA7B2E2B())
        player._id_3ED7B70127C2A141 = undefined;
    }

    waitframe();
  }
}

_id_71DD0A942266F224(player) {}

_id_7E8946C448A83AE3() {
  aliases = ["dx_cp_cpr3_slpw_fara_becareful", "dx_cp_cpr3_slpw_pric_mindthebloodygaps", "dx_cp_cpr3_slpw_alex_dontlookdown"];

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803((5526.08, 11527.1, 2002.62), 0.7, 0.3)[0]; scripts\engine\utility::flag("vo_dontNagAlcoves"); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803((5526.08, 11527.1, 2002.62), 0.7, 0.3)[0]) {}

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_C4138CD6A8965990() {
  level endon("vo_siloPowerFound");

  if(scripts\engine\utility::flag("vo_siloPowerFound")) {
    return;
  }
  aliases = ["dx_cp_cpr3_slpw_fara_thatsagenerator", "dx_cp_cpr3_slpw_pric_thatsagenerator", "dx_cp_cpr3_slpw_alex_thatsagenerator"];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803((4850.81, 11537.1, 4666.12), 0.8, 0.3, 0, [], 500)[0];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  scripts\engine\utility::flag_set("vo_spotFirstGenerator");
  scripts\engine\utility::flag_set("vo_searchingAlcoves");
  aliases = ["dx_cp_cpr3_slpw_fara_weneedtoswitchiton", "dx_cp_cpr3_slpw_pric_letsswitchiton", "dx_cp_cpr3_slpw_alex_letsgetitswitchedon"];
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);
  _id_C9A17BCFBDFCE146 = scripts\engine\utility::create_deck(["dx_cp_cpr3_slpw_fara_letskeepmoving", "dx_cp_cpr3_slpw_fara_letsmove", "dx_cp_cpr3_slpw_fara_moveup"]);
  _id_AC883563535E1D5D = scripts\engine\utility::create_deck(["dx_cp_cpr3_slpw_pric_pushup", "dx_cp_cpr3_slpw_pric_move", "dx_cp_cpr3_slpw_pric_keepmoving"]);
  _id_8803F509C087BB78 = scripts\engine\utility::create_deck(["dx_cp_cpr3_slpw_alex_keepitmoving", "dx_cp_cpr3_slpw_alex_forceup", "dx_cp_cpr3_slpw_alex_keeppushing"]);
  _id_97DD2CB4A46415D3 = [_id_C9A17BCFBDFCE146, _id_AC883563535E1D5D, _id_8803F509C087BB78];
  _id_C9A17BCFBDFCE146 = scripts\engine\utility::create_deck(["dx_cp_cpr3_slpw_fara_findthecontrols", "dx_cp_cpr3_slpw_fara_weneedthepoweron", "dx_cp_cpr3_slpw_fara_lookforthecontrols"]);
  _id_AC883563535E1D5D = scripts\engine\utility::create_deck(["dx_cp_cpr3_slpw_pric_weneedthatgeneratoro", "dx_cp_cpr3_slpw_pric_thecontrolsaresomewh", "dx_cp_cpr3_slpw_pric_locateaswitchforthep"]);
  _id_8803F509C087BB78 = scripts\engine\utility::create_deck(["dx_cp_cpr3_slpw_alex_lookforthecontrols", "dx_cp_cpr3_slpw_alex_findthegeneratorswit", "dx_cp_cpr3_slpw_alex_letsgetthepowerbacko"]);
  _id_49F91D496E0648AB = [_id_C9A17BCFBDFCE146, _id_AC883563535E1D5D, _id_8803F509C087BB78];
  players = scripts\engine\utility::create_deck(level.players, 1, 1);
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(15, 50, 6);

  for(;;) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    player = players scripts\engine\utility::deck_draw();

    if(scripts\engine\utility::flag("vo_combat")) {
      scripts\engine\utility::flag_waitopen("vo_combat");
      wait 3;

      while(scripts\engine\utility::flag("vo_combat")) {
        scripts\engine\utility::flag_waitopen("vo_combat");
        wait 3;
      }

      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_97DD2CB4A46415D3, 0.3);
      continue;
    }

    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_49F91D496E0648AB, 0.3);
  }
}

_id_B5B7107B9966F900() {
  aliases = ["dx_cp_cpr3_slpw_fara_movingupstairs", "dx_cp_cpr3_slpw_pric_movingupstairs", "dx_cp_cpr3_slpw_alex_headingupstairs"];
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((4280.38, 12217.8, 4779), (4145.46, 12326.7, 4669.46));
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
  wait 1;
  aliases = ["dx_cp_cpr3_slpw_fara_thecontrolscantbefar", "dx_cp_cpr3_slpw_pric_controlsshouldbehere", "dx_cp_cpr3_slpw_alex_powershouldbeinthisr"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_D70616CEC1CFDCB5() {
  _id_F406B509B50EE8BA = (4591.25, 11681.1, 4765.5);
  aliases = ["dx_cp_cpr3_slpw_fara_foundthepower", "dx_cp_cpr3_slpw_pric_foundtheswitch", "dx_cp_cpr3_slpw_alex_foundtheswitch"];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_F406B509B50EE8BA, 0.7, 0.2, 0, [], 200)[0];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  scripts\engine\utility::flag_set("vo_siloPowerFound");
  level waittill("player_interaction_success", player, ent);

  while(ent.targetname != "silo_power_switch_1")
    level waittill("player_interaction_success", player, ent);

  scripts\engine\utility::flag_set("vo_generatorPoweredOn");
  aliases = ["dx_cp_cpr3_slpw_fara_switchingiton", "dx_cp_cpr3_slpw_pric_powerscomingon", "dx_cp_cpr3_slpw_alex_hittingthepower"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 4;
  aliases = ["dx_cp_cpr3_slpw_fara_theelevatorsmoving", "dx_cp_cpr3_slpw_pric_theliftsheadeddown", "dx_cp_cpr3_slpw_alex_elevatorsheadingourw"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_03AEFA52C1689CD3());
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 0.5;
  aliases = ["dx_cp_cpr3_slpw_fara_headbacktotheplatfor", "dx_cp_cpr3_slpw_pric_rallyattheplatform", "dx_cp_cpr3_slpw_alex_getbacktotheplatform"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_03AEFA52C1689CD3());
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);

  while(_id_03AEFA52C1689CD3()[2] > 4850)
    waitframe();

  if(_id_00DE4CC4721B71B4().size == level.players.size) {
    return;
  }
  aliases = ["dx_cp_cpr3_slpw_fara_hereitis", "dx_cp_cpr3_slpw_pric_heresthelift", "dx_cp_cpr3_slpw_alex_hereitcomes"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_03AEFA52C1689CD3());
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 1;

  if(_id_00DE4CC4721B71B4().size == level.players.size) {
    return;
  }
  aliases = ["dx_cp_cpr3_slpw_fara_wellhavetojump", "dx_cp_cpr3_slpw_pric_getready", "dx_cp_cpr3_slpw_alex_getreadytojump"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_03AEFA52C1689CD3());
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);

  while(_id_03AEFA52C1689CD3()[2] > 4600)
    waitframe();

  if(_id_00DE4CC4721B71B4().size == level.players.size) {
    return;
  }
  aliases = ["dx_cp_cpr3_slpw_fara_jumpnow", "dx_cp_cpr3_slpw_pric_jump", "dx_cp_cpr3_slpw_alex_gogo"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_03AEFA52C1689CD3());
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);

  while(_id_03AEFA52C1689CD3()[2] > 4034)
    waitframe();

  if(_id_00DE4CC4721B71B4().size > 0) {
    return;
  }
  aliases = ["dx_cp_cpr3_slpw_fara_wecantgetdownthere", "dx_cp_cpr3_slpw_pric_fuckinhellnowaydown", "dx_cp_cpr3_slpw_alex_wecantmakethatjump"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_03AEFA52C1689CD3());
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  aliases = ["dx_cp_cpr3_slpw_fara_hadirisgoingtoescape", "dx_cp_cpr3_slpw_pric_themissionscompromis", "dx_cp_cpr3_slpw_alex_hadirsgoingtoescape"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);

  if(scripts\engine\utility::_id_5B7E9A4C946F3A13(player, [level.farah, level.alex]))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr3_slpw_fara_damnhimtohell", 0.4);
}

_id_4B72C6C519997AD9() {
  _id_F762BCE14CF88FD4();
  thread _id_956D914D36AFC126();
  thread _id_50EC40EB5990C2D0();
}

_id_956D914D36AFC126() {
  _id_8999BA6CDAF041DB = (5992.86, 11522, 4081);
  aliases = ["dx_cp_cpr3_slpw_fara_northside", "dx_cp_cpr3_slpw_pric_northside", "dx_cp_cpr3_slpw_alex_northside"];

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_8999BA6CDAF041DB, 0.7, 0.3, 0, [], 1500)[0]; getaiarrayinradius(_id_8999BA6CDAF041DB, 800).size == 0 || !_id_4A68B63FC8E6542F(player); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_8999BA6CDAF041DB, 0.85, 0.3, 0, [], 1500)[0]) {}

  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_8999BA6CDAF041DB, 0.85, 0.3, 0, [], 1500)[0]; getaiarrayinradius(_id_8999BA6CDAF041DB, 800).size > 0 || !_id_4A68B63FC8E6542F(player); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_8999BA6CDAF041DB, 0.85, 0.3, 0, [], 1500)[0]) {}

  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, level._id_A255EA1FB0E213E7, 0.4);
}

_id_50EC40EB5990C2D0() {
  _id_E5C015EA62D11105 = (5090.88, 11525.6, 3522);
  aliases = ["dx_cp_cpr3_slpw_fara_watchsouth", "dx_cp_cpr3_slpw_pric_contactsouth", "dx_cp_cpr3_slpw_alex_checksouth"];

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_E5C015EA62D11105, 0.7, 0.3, 0, [], 1500)[0]; getaiarrayinradius(_id_E5C015EA62D11105, 800).size == 0 || !_id_4A68B63FC8E6542F(player); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_E5C015EA62D11105, 0.85, 0.3, 0, [], 1500)[0]) {}

  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_E5C015EA62D11105, 0.85, 0.3, 0, [], 1500)[0]; getaiarrayinradius(_id_E5C015EA62D11105, 800).size > 0 || !_id_4A68B63FC8E6542F(player); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_E5C015EA62D11105, 0.85, 0.3, 0, [], 1500)[0]) {}

  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, level._id_EDD3DF2E8BE1CCFD, 0.4);
}

_id_0A8EDECF76CB4FF0() {
  _id_36C12D04A03471D6 = (5534.79, 11103.6, 1836.58);
  aliases = ["dx_cp_cpr3_sl2s_fara_alcove4", "dx_cp_cpr3_sl2s_pric_alcove4", "dx_cp_cpr3_sl2s_alex_alcove4"];

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_36C12D04A03471D6, 0.7, 0.3, 0, [], 1500)[0]; getaiarrayinradius(_id_36C12D04A03471D6, 800).size == 0 || !_id_4A68B63FC8E6542F(player); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_36C12D04A03471D6, 0.85, 0.3, 0, [], 1500)[0]) {}

  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_36C12D04A03471D6, 0.85, 0.3, 0, [], 1500)[0]; getaiarrayinradius(_id_36C12D04A03471D6, 800).size > 0 || !_id_4A68B63FC8E6542F(player); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_36C12D04A03471D6, 0.85, 0.3, 0, [], 1500)[0]) {}

  aliases = ["dx_cp_cpr3_sl2s_fara_4sclear", "dx_cp_cpr3_sl2s_pric_4sallclear", "dx_cp_cpr3_sl2s_alex_4sgood"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_0A8EE4CF76CB5D22() {
  _id_36C12D04A03471D6 = (5532.68, 11975.1, 714);
  aliases = ["dx_cp_cpr3_sl2s_fara_alcove2", "dx_cp_cpr3_sl2s_pric_alcove2", "dx_cp_cpr3_sl2s_alex_alcove2"];

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_36C12D04A03471D6, 0.7, 0.3, 0, [], 1500)[0]; getaiarrayinradius(_id_36C12D04A03471D6, 800).size == 0 || !_id_4A68B63FC8E6542F(player); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_36C12D04A03471D6, 0.85, 0.3, 0, [], 1500)[0]) {}

  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_36C12D04A03471D6, 0.85, 0.3, 0, [], 1500)[0]; getaiarrayinradius(_id_36C12D04A03471D6, 800).size > 0 || !_id_4A68B63FC8E6542F(player); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_36C12D04A03471D6, 0.85, 0.3, 0, [], 1500)[0]) {}

  aliases = ["dx_cp_cpr3_sl2s_fara_2sclear", "dx_cp_cpr3_sl2s_pric_2isclear", "dx_cp_cpr3_sl2s_alex_clearon2"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  aliases = ["dx_cp_cpr3_filv_fara_wereclear", "dx_cp_cpr3_filv_pric_wereclear", "dx_cp_cpr3_filv_alex_allclear"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.6);
}

_id_F762BCE14CF88FD4() {
  if(!isDefined(level._id_A255EA1FB0E213E7)) {
    _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_slpw_fara_northisclear", "dx_cp_cpr3_slpw_fara_clearnorth"]);
    _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_slpw_pric_clearnorth", "dx_cp_cpr3_slpw_pric_wereclearnorth"]);
    _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_slpw_alex_northsideisclear", "dx_cp_cpr3_slpw_alex_clearonthenorthside"]);
    level._id_A255EA1FB0E213E7 = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  }

  if(!isDefined(level._id_EDD3DF2E8BE1CCFD)) {
    _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_slpw_fara_southsideisclear", "dx_cp_cpr3_slpw_fara_southisclear"]);
    _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_slpw_pric_southisclear", "dx_cp_cpr3_slpw_pric_wereclearsouth"]);
    _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_slpw_alex_southsideisclear", "dx_cp_cpr3_slpw_alex_southisclear"]);
    level._id_EDD3DF2E8BE1CCFD = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  }
}

_id_01F3AC9B6672DFA6() {
  thread _id_BE87F49F34502DBA();
  thread _id_6AD7DFFA58542AB0();
  thread _id_2212ABCDE587D0D6([(5537.96, 10149.3, 3530)]);
  thread _id_2212ABCDE587D0D6([(4156.24, 11526.9, 3530)]);
  wait 2;
  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();

  if(scripts\engine\utility::is_equal(player, level.farah))
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr3_sl2s_fara_thosedogs", 0.3);

  aliases = ["dx_cp_cpr3_sl2s_fara_theycutthepoweragain", "dx_cp_cpr3_sl2s_pric_bastardscutthepowera", "dx_cp_cpr3_sl2s_alex_aqcutthepoweragain"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  thread _id_9B40DD2AB2104433(player);
}

_id_257299C987860897() {
  thread _id_26706044D46C7FB1();
  thread _id_2212ABCDE587D0D6([(5253.05, 10559.5, 1841.96), (6029.36, 10517.2, 1840.72)]);
  thread _id_2212ABCDE587D0D6([(5780.17, 12491.6, 1281.62), (5128.47, 12533.1, 1279.34)]);
  thread _id_2212ABCDE587D0D6([(6501.37, 11274.1, 1281.85), (6543.96, 11926.6, 1284.49)]);
  thread _id_2212ABCDE587D0D6([(5780.17, 12491.6, 711.62), (5128.47, 12533.1, 712.34)]);
  thread _id_2212ABCDE587D0D6([(4581.28, 11736.4, 711.281), (4526.3, 11116.8, 712.178)]);
  level._id_142FFEF4BA6476C6 waittill("stop_moving");
  thread _id_764F021E46A8FF8B();
  thread _id_2778AB5473DE9879();
}

_id_9B40DD2AB2104433(player) {
  if(scripts\engine\utility::flag("vo_silo2ndStopSearchingAlcoves")) {
    return;
  }
  level endon("vo_silo2ndStopSearchingAlcoves");
  players = scripts\engine\utility::array_randomize(level.players);

  if(scripts\engine\utility::is_equal(players[0], player)) {
    players = scripts\engine\utility::array_remove(players, player);
    players = scripts\engine\utility::array_insert(players, player, 1);
  }

  _id_277B23D89B6BF476 = ["dx_cp_cpr3_sl2s_fara_searchthealcoveslook", "dx_cp_cpr3_sl2s_pric_sweepthealcovesfinda", "dx_cp_cpr3_sl2s_alex_letshitthealcovesloc"];
  _id_277B22D89B6BF243 = ["dx_cp_cpr3_sl2s_fara_weneedtomovefasthadi", "dx_cp_cpr3_sl2s_pric_welllosehadirifwedon", "dx_cp_cpr3_sl2s_alex_weneedtogetthepowero"];
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(8, 23, 6);
  aliases = scripts\engine\utility::create_deck([_id_277B23D89B6BF476, _id_277B22D89B6BF243]);

  foreach(player in level.players) {
    scripts\engine\utility::flag_waitopen("vo_dontNagAlcoves");
    scripts\engine\utility::flag_waitopen("vo_combat");
    wait 2;

    while(scripts\engine\utility::flag("vo_dontNagAlcoves") || scripts\engine\utility::flag("vo_combat")) {
      scripts\engine\utility::flag_waitopen("vo_dontNagAlcoves");
      scripts\engine\utility::flag_waitopen("vo_combat");
      wait 2;
    }

    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases scripts\engine\utility::deck_draw(), 0.4);
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
  }
}

_id_BE87F49F34502DBA() {
  thread _id_DF5B1E80D884823C();
  aliases = ["dx_cp_cpr3_sl2s_fara_movingnorth", "dx_cp_cpr3_sl2s_pric_checkingnorth", "dx_cp_cpr3_sl2s_alex_imtakingnorth"];
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((5786.35, 11710.5, 2819.97), (6080.02, 11278.7, 3047.22), 0, ::_id_9FE3EDDD988585DF);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  scripts\engine\utility::flag_set("vo_silo2ndStopSearchingAlcoves");
  _id_D77F6E9C5D5D0F2D = (6615.05, 11546.1, 2941.06);
  _id_C553BA1882786B8A = (6605.47, 11475.1, 2941.13);
  result = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803([_id_D77F6E9C5D5D0F2D, _id_C553BA1882786B8A], 0.95, 0.2, 0, [], 175);

  if(result[1] == _id_D77F6E9C5D5D0F2D) {
    aliases = ["dx_cp_cpr3_sl2s_fara_theresabuzzsawhere", "dx_cp_cpr3_sl2s_pric_foundabuzzsaw", "dx_cp_cpr3_sl2s_alex_gotabuzzsawhere"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(result[0], aliases, 0.4);
    _id_10A49B3D021598BD = gettime();
    player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_C553BA1882786B8A, 0.95, 0.2, 0, [], 175)[0];

    if(scripts\engine\utility::time_has_passed(_id_10A49B3D021598BD, 3)) {
      aliases = ["dx_cp_cpr3_sl2s_fara_resuppliesarehere", "dx_cp_cpr3_sl2s_pric_foundresupplies", "dx_cp_cpr3_sl2s_alex_foundsomeresupplies"];
      thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(result[0], aliases, 0.4);
    } else {
      aliases = ["dx_cp_cpr3_sl2s_fara_resuppliestoo", "dx_cp_cpr3_sl2s_pric_andresupplies", "dx_cp_cpr3_sl2s_alex_andsomeresupplies"];
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
    }
  } else {
    aliases = ["dx_cp_cpr3_sl2s_fara_resuppliesarehere", "dx_cp_cpr3_sl2s_pric_foundresupplies", "dx_cp_cpr3_sl2s_alex_foundsomeresupplies"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(result[0], aliases, 0.4);
    _id_10A49B3D021598BD = gettime();
    player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_D77F6E9C5D5D0F2D, 0.95, 0.2, 0, [], 175)[0];

    if(scripts\engine\utility::time_has_passed(_id_10A49B3D021598BD, 3)) {
      aliases = ["dx_cp_cpr3_sl2s_fara_theresabuzzsawhere", "dx_cp_cpr3_sl2s_pric_foundabuzzsaw", "dx_cp_cpr3_sl2s_alex_gotabuzzsawhere"];
      thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(result[0], aliases, 0.4);
    } else {
      aliases = ["dx_cp_cpr3_sl2s_fara_andabuzzsaw", "dx_cp_cpr3_sl2s_pric_andabuzzsaw", "dx_cp_cpr3_sl2s_alex_andabuzzsaw"];
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
    }
  }
}

_id_6AD7DFFA58542AB0() {
  thread _id_4DD1E651619A24B4();
  thread _id_62B4A7EADAB4E708();
  thread _id_FC4FEF3DA1A9367F();
  thread _id_CA530CEAD7FC597B();
  thread _id_924D9201CB63C54E();
  thread _id_199C26C91E87BE5F();
  thread _id_5CA0574BCDA660AB();
  thread _id_3CC25B29C7D96087();
  thread _id_D25A44F1A6B06089();
  aliases = ["dx_cp_cpr3_sl2s_fara_movingsouth", "dx_cp_cpr3_sl2s_pric_checkingsouth", "dx_cp_cpr3_sl2s_alex_imheadingsouth"];
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((5290.33, 11344.7, 2878.74), (4989.21, 11736.5, 3143.88), 0, ::_id_9FE3EDDD988585DF);
  scripts\engine\utility::flag_set("vo_silo2ndStopSearchingAlcoves");
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_DF5B1E80D884823C() {
  thread _id_6F7B6198ADDCFE13();
  _id_277B23D89B6BF476 = ["dx_cp_cpr3_sl2s_fara_theresavalveinhere", "dx_cp_cpr3_sl2s_pric_avalvesinhere", "dx_cp_cpr3_sl2s_alex_gotavalveinhere"];
  _id_277B22D89B6BF243 = ["dx_cp_cpr3_sl2s_fara_theresanothervalvein", "dx_cp_cpr3_sl2s_pric_foundanothervalveinh", "dx_cp_cpr3_sl2s_alex_anothervalvesinhere"];
  _id_277B21D89B6BF010 = ["dx_cp_cpr3_sl2s_fara_anothervalve", "dx_cp_cpr3_sl2s_pric_gotanothervalvehere", "dx_cp_cpr3_sl2s_alex_locatedanothervalve"];
  aliases = [_id_277B21D89B6BF010, _id_277B22D89B6BF243, _id_277B23D89B6BF476];
  _id_51E7CFB4D545149C = (6538.22, 12067.7, 2940.55);
  _id_51E7D2B4D5451B35 = (5822.1, 12408.1, 2389.86);
  _id_51E7D1B4D5451902 = (6485.37, 10983, 2389.86);
  _id_51E791B4D5448C42 = [_id_51E7CFB4D545149C, _id_51E7D2B4D5451B35, _id_51E7D1B4D5451902];

  while(_id_51E791B4D5448C42.size > 0) {
    result = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_51E791B4D5448C42, 0.8, 0.4, 0, [], 150);
    _id_51E791B4D5448C42 = scripts\engine\utility::array_remove(_id_51E791B4D5448C42, result[1]);
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(result[0], aliases[_id_51E791B4D5448C42.size], 0.4);
  }
}

_id_6F7B6198ADDCFE13() {
  level waittill("ee_valve_complete");
  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
  aliases = ["dx_cp_cpr3_sl2s_fara_thatdidsomething", "dx_cp_cpr3_sl2s_pric_thatdidsomething", "dx_cp_cpr3_sl2s_alex_thatdidsomething"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_4DD1E651619A24B4() {
  aliases = ["dx_cp_cpr3_sl2s_fara_cantreachit", "dx_cp_cpr3_sl2s_pric_cantgetupthere", "dx_cp_cpr3_sl2s_alex_thatsanogo"];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803((4743.56, 11099.8, 3054.75), 0.6, 0.4, 0, [], 140)[0];

  while(isalive(player) && !player isonground())
    waitframe();

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_FC4FEF3DA1A9367F() {
  level endon("vo_shotThroughGate");
  player = _id_5A758FD9ED9546FA();
  level notify("vo_shotAtThroughGate");
  _id_49B02B69E3D08154(player);
}

_id_62B4A7EADAB4E708() {
  level endon("vo_shotAtThroughGate");

  for(player = _id_0EDCF07839930CA2("weapon_fired")[0]; !isalive(player) || !isDefined(player _id_62E11D77B25C1D30::_id_826A16F43A8E949B((4681.77, 11853.4, 2964.01), 0.7)); player = _id_0EDCF07839930CA2("weapon_fired")[0]) {}

  level notify("vo_shotThroughGate");
  _id_49B02B69E3D08154(player);
}

_id_49B02B69E3D08154(player) {
  wait 0.2;
  aliases = ["dx_cp_cpr3_sl2s_fara_inthetunnel", "dx_cp_cpr3_sl2s_pric_aqinthetunnel", "dx_cp_cpr3_sl2s_alex_theyreinthetunnel"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  aliases = ["dx_cp_cpr3_sl2s_fara_behindthedoor", "dx_cp_cpr3_sl2s_pric_behindthedoor", "dx_cp_cpr3_sl2s_alex_behindthedoor"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  scripts\engine\utility::flag_set("vo_enemiesThroughGate");
}

_id_5A758FD9ED9546FA() {
  for(;;) {
    result = _id_0EDCF07839930CA2(["bulletwhizby", "damage"]);

    if(result[1] == "damage")
      attacker = result[3];
    else
      attacker = result[2];

    if(!isai(attacker)) {
      continue;
    }
    if(!attacker _id_62E11D77B25C1D30::_id_1D8DC0F6BBB423BA((4613.83, 11627.1, 2858.62), (4752.32, 12441.7, 3002.87))) {
      continue;
    }
    player = result[0];
    return player;
  }
}

_id_0EDCF07839930CA2(_id_FBF2840DF6D0452F, players) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, level.players);

  if(!isarray(_id_FBF2840DF6D0452F))
    _id_FBF2840DF6D0452F = [_id_FBF2840DF6D0452F];

  struct = spawnStruct();

  foreach(msg in _id_FBF2840DF6D0452F) {
    foreach(player in players)
    player childthread _id_4B9AB96C345311A6(msg, struct);
  }

  struct waittill("returned", msg, player, _id_A9B8FA5C0A14AD43, _id_A9B8FB5C0A14AF76, _id_A9B8FC5C0A14B1A9);
  struct notify("die");
  return [player, msg, _id_A9B8FA5C0A14AD43, _id_A9B8FB5C0A14AF76, _id_A9B8FC5C0A14B1A9];
}

_id_4B9AB96C345311A6(msg, ent) {
  if(msg != "death")
    self endon("death");

  ent endon("die");
  self waittill(msg, _id_A9B8FA5C0A14AD43, _id_A9B8FB5C0A14AF76, _id_A9B8FC5C0A14B1A9);
  ent notify("returned", msg, self, _id_A9B8FA5C0A14AD43, _id_A9B8FB5C0A14AF76, _id_A9B8FC5C0A14B1A9);
}

_id_9FE4364D519AD149(index, value) {
  players = [];

  foreach(player in level.players) {
    if(player.origin[index] < value)
      players[players.size] = player;
  }

  return players;
}

_id_90CCE07F1B9F0CC6(index, value) {
  players = [];

  foreach(player in level.players) {
    if(player.origin[index] > value)
      players[players.size] = player;
  }

  return players;
}

_id_6D9F25F0B3035358(height) {
  return _id_90CCE07F1B9F0CC6(2, height);
}

_id_CA530CEAD7FC597B() {
  level endon("saw_used");
  door = (4714.62, 11612.2, 2952.67);
  scripts\engine\utility::flag_wait("vo_enemiesThroughGate");
  level waittill("failed_saw_use", player);

  while(scripts\engine\utility::flag("vo_combat"))
    level waittill("failed_saw_use", player);

  aliases = ["dx_cp_cpr3_sl2s_fara_theyweldedthedoor", "dx_cp_cpr3_sl2s_pric_doorssealed", "dx_cp_cpr3_sl2s_alex_doorsweldedshut"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  scripts\engine\utility::flag_waitopen("vo_combat");
  wait 3;

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(door, 0.6, 0.4, 0, [], 100)[0]; scripts\engine\utility::flag("vo_combat"); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(door, 0.6, 0.4, 0, [], 100)[0]) {
    scripts\engine\utility::flag_waitopen("vo_combat");
    wait 3;
  }

  aliases = ["dx_cp_cpr3_sl2s_fara_weneedtogetthrough", "dx_cp_cpr3_sl2s_pric_weneedthatdooropen", "dx_cp_cpr3_sl2s_alex_weneedtogetinthere"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(door);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  scripts\engine\utility::flag_waitopen("vo_combat");
  wait 5;

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(door, 0.6, 0.4, 0, [], 100)[0]; scripts\engine\utility::flag("vo_combat"); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(door, 0.6, 0.4, 0, [], 100)[0]) {
    scripts\engine\utility::flag_waitopen("vo_combat");
    wait 5;
  }

  aliases = ["dx_cp_cpr3_sl2s_fara_thegeneratorcouldbei", "dx_cp_cpr3_sl2s_pric_ifthegeneratorsinsid", "dx_cp_cpr3_sl2s_alex_thegeneratorcouldbei"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(door);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 8;
  thread _id_8232CEB3339D66A7(door);
  player = _id_F75BF134C689F3D0();
  level notify("vo_player_got_saw");
  thread _id_6AFA95054D0F668E(door, player);

  while(_id_4A68B63FC8E6542F(player) || player.origin[0] > 5512) {
    waitframe();
    player = _id_F75BF134C689F3D0();
  }

  level notify("vo_player_returned_with_saw");
  aliases = ["dx_cp_cpr3_sl2s_fara_wereoutofcharges", "dx_cp_cpr3_sl2s_pric_outofcharges", "dx_cp_cpr3_sl2s_alex_nobreachingcharges"];
  player = _id_F75BF134C689F3D0();
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  aliases = ["dx_cp_cpr3_sl2s_fara_wehavethebuzzsaw", "dx_cp_cpr3_sl2s_pric_usethebuzzsaw", "dx_cp_cpr3_sl2s_alex_trythatbuzzsaw"];
  player = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(door, player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 6;
  player = _id_F75BF134C689F3D0();
  aliases = _id_C0B1DC1379FF2380(player, 1);
  player = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(door, player);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  aliases = ["dx_cp_cpr3_sl2s_fara_cutthroughthedoor", "dx_cp_cpr3_sl2s_pric_cutthroughthedoor", "dx_cp_cpr3_sl2s_alex_cutthroughthedoor"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_8232CEB3339D66A7(door) {
  level endon("vo_player_got_saw");

  if(!_id_C4CAAC251871E691()) {
    wait 1;
    scripts\engine\utility::flag_waitopen("vo_combat");
    player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(door, 0.6, 0.4, 0, [], 100)[0];
    aliases = ["dx_cp_cpr3_file_fara_wellneedasaw", "dx_cp_cpr3_file_pric_wellneedasaw", "dx_cp_cpr3_ssdr_alex_weneedasaw"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  }
}

_id_6AFA95054D0F668E(door, player) {
  level endon("vo_player_returned_with_saw");
  aliases = ["dx_cp_cpr3_sl2s_fara_getbackacross", "dx_cp_cpr3_sl2s_pric_backacross", "dx_cp_cpr3_sl2s_alex_jumpbackacross"];
  wait 3;
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(door, undefined, player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 8;
  _id_7711FEB2B9279561 = _id_F75BF134C689F3D0();
  wait 1;
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(door, undefined, [player, _id_7711FEB2B9279561]);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_C4CAAC251871E691(_id_E84136BA3D0BA016) {
  _id_E84136BA3D0BA016 = scripts\engine\utility::_id_53C4C53197386572(_id_E84136BA3D0BA016, 1);

  foreach(player in level.players) {
    if(!_id_E84136BA3D0BA016 && (!isalive(player) || !player scripts\cp\utility::is_valid_player(1, 1))) {
      continue;
    }
    if(player hasweapon("iw9_me_buzzsaw_mp"))
      return 1;
  }

  return 0;
}

_id_F75BF134C689F3D0() {
  for(;;) {
    foreach(player in level.players) {
      if(!isalive(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(player hasweapon("iw9_me_buzzsaw_mp"))
        return player;
    }

    waitframe();
  }
}

_id_924D9201CB63C54E() {
  level waittill("saw_used", objectiveindex, player);
  aliases = ["dx_cp_cpr3_sl2s_fara_covermeimcuttingthro", "dx_cp_cpr3_sl2s_pric_cuttingthroughcoverm", "dx_cp_cpr3_sl2s_alex_covermeimsawingthrou"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_D25A44F1A6B06089() {
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_fara_notthroughyet", "dx_cp_cpr3_sl2s_fara_finishcutting", "dx_cp_cpr3_sl2s_fara_keepcutting"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_pric_keepcuttingthrough", "dx_cp_cpr3_sl2s_pric_ehyourenotthroughyet", "dx_cp_cpr3_sl2s_pric_notdonewiththatside"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_alex_keepgoingwiththesaw", "dx_cp_cpr3_sl2s_alex_haventcutthroughyet", "dx_cp_cpr3_sl2s_alex_keepusingthesaw"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];

  for(;;) {
    level waittill("saw_released_early", objectiveindex, player);
    player = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(player.origin, player);
    wait 0.3;

    if(!_id_C4CAAC251871E691(0)) {
      continue;
    }
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  }
}

_id_199C26C91E87BE5F() {
  level waittill("saw_finished", objectiveindex, player);
  aliases = ["dx_cp_cpr3_sl2s_fara_werethroughletsmove", "dx_cp_cpr3_sl2s_pric_doorsopenmove", "dx_cp_cpr3_sl2s_alex_entrysclearmove"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.6);
  thread _id_04C3A349C9C6AA6E();
}

_id_5CA0574BCDA660AB() {
  _id_CE15E68E59D99AE6 = (4724.35, 12778.6, 2962);
  _id_13C4E20F998F86D5 = (4222.58, 12770.4, 2946);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803([_id_CE15E68E59D99AE6, _id_13C4E20F998F86D5], 0.5, 0.2, 0, [], 250)[0];
  level endon("saw_used");
  aliases = ["dx_cp_cpr3_sl2s_fara_foundthegenerator", "dx_cp_cpr3_sl2s_pric_visualonthegenerator", "dx_cp_cpr3_sl2s_alex_generatorsinthenextr"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  wait 2;

  for(player = _id_F75BF134C689F3D0(); scripts\engine\utility::flag("vo_combat"); player = _id_F75BF134C689F3D0())
    scripts\engine\utility::flag_waitopen("vo_combat");

  aliases = ["dx_cp_cpr3_sl2s_fara_wellhavetocutthedoor", "dx_cp_cpr3_sl2s_pric_getthatdooropen", "dx_cp_cpr3_sl2s_alex_weneedthedooropensta"];
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  scripts\engine\utility::flag_set("vo_saidStartCutting");
  wait 6;

  for(player = _id_F75BF134C689F3D0(); scripts\engine\utility::flag("vo_combat"); player = _id_F75BF134C689F3D0())
    scripts\engine\utility::flag_waitopen("vo_combat");

  aliases = ["dx_cp_cpr3_sl2s_fara_usethesawhurry", "dx_cp_cpr3_sl2s_pric_cutthroughthedoormak", "dx_cp_cpr3_sl2s_alex_getthatsawonthedoorp"];
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_3CC25B29C7D96087() {
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803((4422.33, 12705, 2964), 0.9, 0.3, 0, [], 250)[0];
  aliases = ["dx_cp_cpr3_filp_fara_foundthepower", "dx_cp_cpr3_filp_pric_foundthepower", "dx_cp_cpr3_filp_alex_foundthepower"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_04C3A349C9C6AA6E() {
  level waittill("saw_used", objectiveindex, player);
  thread _id_EA05A360B8EB16A6();

  while(objectiveindex != 1 && objectiveindex != 2)
    level waittill("saw_used", objectiveindex, player);

  scripts\engine\utility::flag_wait("vo_saidStartCutting");
  aliases = ["dx_cp_cpr3_sl2s_fara_onitcoverme", "dx_cp_cpr3_sl2s_pric_coverme", "dx_cp_cpr3_sl2s_alex_keepmecovered"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_EA05A360B8EB16A6() {
  scripts\engine\utility::flag_wait_either("silo_door_2_cut", "silo_door_3_cut");
  player = _id_F75BF134C689F3D0();
  aliases = ["dx_cp_cpr3_sl2s_fara_werethrough", "dx_cp_cpr3_sl2s_pric_movein", "dx_cp_cpr3_sl2s_alex_doorsopen"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 2;
  aliases = ["dx_cp_cpr3_sl2s_fara_findthecontrols", "dx_cp_cpr3_sl2s_pric_findthecontrolsfast", "dx_cp_cpr3_sl2s_alex_findthecontrols"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_26706044D46C7FB1() {
  level waittill("player_interaction_success", player, ent);

  while(ent.targetname != "silo_power_switch_2")
    level waittill("player_interaction_success", player, ent);

  wait 1.3;
  aliases = ["dx_cp_cpr3_sl2s_fara_powerswitcheffort", "dx_cp_cpr3_sl2s_pric_powerswitcheffort", "dx_cp_cpr3_sl2s_alex_powerswitcheffort"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 1;
  aliases = ["dx_cp_cpr3_sl2s_fara_powersongettotheelev", "dx_cp_cpr3_sl2s_pric_powersonbacktothelif", "dx_cp_cpr3_sl2s_alex_powersupbacktotheele"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  thread _id_0A8EDECF76CB4FF0();
  thread _id_0A8EE4CF76CB5D22();
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((4926.22, 11775.5, 2857.53), (5264.77, 11273.1, 3088.61));
  _id_6EE5484560EC747C = _id_87001DC286B063DC(player.origin, 500, player);

  if(_id_00DE4CC4721B71B4().size > 0 || isDefined(_id_6EE5484560EC747C)) {
    player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_03AEFA52C1689CD3());
    aliases = ["dx_cp_cpr3_sl2s_fara_jump", "dx_cp_cpr3_sl2s_pric_jump", "dx_cp_cpr3_sl2s_alex_jump"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  }
}

_id_87001DC286B063DC(origin, dist, _id_94564218DD6125B9) {
  distsq = squared(dist);

  if(isDefined(_id_94564218DD6125B9) && !isarray(_id_94564218DD6125B9))
    _id_94564218DD6125B9 = [_id_94564218DD6125B9];

  foreach(player in level.players) {
    if(isDefined(_id_94564218DD6125B9) && scripts\engine\utility::array_contains(_id_94564218DD6125B9, player)) {
      continue;
    }
    if(distancesquared(player.origin, origin) < distsq)
      return player;
  }
}

_id_F0B364E18B6D863B() {
  thread _id_AD9673645F9CA301();
  _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((7504.51, 14251.3, 212.831), (6976.57, 13902.6, 389.55), 1);
}

_id_03E986A5BBE1C73B(_id_6EF4FD3894A9F0A2) {
  if(!isDefined(level._id_4AFFFC8351D145CF)) {
    _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_fara_foundanothernote", "dx_cp_cpr3_sl2s_fara_theresanothernoteher"]);
    _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_pric_foundanothernote", "dx_cp_cpr3_sl2s_pric_gotanothernote"]);
    _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_alex_foundanothernote", "dx_cp_cpr3_sl2s_alex_anothernoteshere"]);
    level._id_4AFFFC8351D145CF = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  }

  game["ee_notesFound"] = scripts\engine\utility::_id_53C4C53197386572(game["ee_notesFound"], []);

  for(;;) {
    if(scripts\engine\utility::array_contains(game["ee_notesFound"], _id_6EF4FD3894A9F0A2)) {
      return;
    }
    level waittill("pickedup_loot_success", _id_5BA045294C1D4D1B, player, instance);

    if(!scripts\engine\utility::is_equal(instance, self)) {
      continue;
    }
    if(_id_6EF4FD3894A9F0A2 == "usb_stick")
      aliases = ["dx_cp_cpr3_sl2s_fara_foundsomething", "dx_cp_cpr3_sl2s_pric_foundsomething", "dx_cp_cpr3_sl2s_alex_foundsomething"];
    else if(game["ee_notesFound"].size == 0)
      aliases = ["dx_cp_cpr3_sl2s_fara_theresanotehere", "dx_cp_cpr3_sl2s_pric_foundanote", "dx_cp_cpr3_sl2s_alex_foundanote"];
    else
      aliases = level._id_4AFFFC8351D145CF;

    game["ee_notesFound"] = scripts\engine\utility::array_add(game["ee_notesFound"], _id_6EF4FD3894A9F0A2);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  }
}

_id_2778AB5473DE9879() {
  level endon("vo_foundSiloExit");
  wait 1;
  aliases = ["dx_cp_cpr3_sl2s_fara_werehereletsmove", "dx_cp_cpr3_sl2s_pric_move", "dx_cp_cpr3_sl2s_alex_thisisourstop"];
  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F(_id_00DE4CC4721B71B4());
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  wait 8;
  aliases = ["dx_cp_cpr3_sl2s_fara_lookforanexit", "dx_cp_cpr3_sl2s_pric_findusanexit", "dx_cp_cpr3_sl2s_alex_weneedawayoutofhere"];
  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_764F021E46A8FF8B() {
  _id_5BAC37C64CEF2C5D = (5535.92, 10887.6, 360);
  player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(_id_5BAC37C64CEF2C5D, 100)[0];
  scripts\engine\utility::flag_set("vo_foundSiloExit");
  _id_05C70E8827622861("silo_end_door");
}

_id_AD9673645F9CA301() {
  level notify("vo_floorIsLava");
  thread _id_DF327DE45522995C();
  player = _id_9E7257487DB14022();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_63A81802C49F3E41(), 0.2);
  tripwires = (6331.73, 11450, 371.555);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(tripwires, 0.7, 0.2, 0, [], 250)[0];
  aliases = ["dx_cp_cpr3_sl2s_fara_careful", "dx_cp_cpr3_sl2s_pric_holdup", "dx_cp_cpr3_sl2s_alex_carefulhere"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0, 1);
  aliases = ["dx_cp_cpr3_sl2s_fara_theysettraps", "dx_cp_cpr3_sl2s_pric_therestripwires", "dx_cp_cpr3_sl2s_alex_theysettripwires"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  game["vo_saidSetTripwires"] = player;
  thread _id_AFA37F0D16875AE8(tripwires, player);
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((6148.53, 11565.7, 503.636), (6448.52, 11787.7, 274.885));
  level notify("vo_pastTripwires");
  aliases = ["dx_cp_cpr3_sl2s_fara_moveslow", "dx_cp_cpr3_sl2s_pric_slowandsteady", "dx_cp_cpr3_sl2s_alex_dontrush"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);
  game["vo_saidMoveSlow"] = player;
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((6234.74, 11920.8, 291.383), (6388.18, 11991.2, 459.296));
  trap = (6323.57, 11947.3, 412.198);

  if(_id_3145AEFCF4E7559D(trap, 30)) {
    aliases = ["dx_cp_cpr3_sl2s_fara_staylowhere", "dx_cp_cpr3_sl2s_pric_crawlunder", "dx_cp_cpr3_sl2s_alex_staylow"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);
  }

  player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B((6308.71, 12540.4, 437.029), 200)[0];
  aliases = ["dx_cp_cpr3_sl2s_fara_itsclear", "dx_cp_cpr3_sl2s_pric_wereclear", "dx_cp_cpr3_sl2s_alex_clear"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr3_sl2s_alex_tunnelsandtrapshadir", 0.2);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr3_sl2s_fara_heknowstheywontstopu", 0.4);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr3_sl2s_pric_heknowsyoufarah", 0.3);
  childthread _id_0AAF64088E0C56B0();
  childthread _id_1677928162D4650B();
  childthread _id_C35CC8E4BDF3C5E7();
  childthread _id_11912018ABBE6BA9();
  childthread _id_6B6C0A75089F6514();
}

_id_DF327DE45522995C() {
  aliases = ["dx_cp_cpr3_sl2s_fara_thiswayisblocked", "dx_cp_cpr3_sl2s_pric_deadendoverhere", "dx_cp_cpr3_sl2s_alex_thiswaysadeadend"];
  _id_FC45B31FB510F898 = (6296.62, 15623.6, 390);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_FC45B31FB510F898, 0.7, 0.2, 0, [], 500)[0];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_AFA37F0D16875AE8(tripwires, player) {
  level endon("vo_pastTripwires");
  wait 6;
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr3_sl2s_alex_theremightbeawaythro", 0.4);
}

_id_3145AEFCF4E7559D(origin, dist) {
  ents = getentarrayinradius(undefined, undefined, origin, dist);

  foreach(ent in ents) {
    if(istrue(ent.istrap))
      return 1;
  }

  return 0;
}

_id_9E7257487DB14022() {
  for(;;) {
    foreach(player in level.players) {
      if(!isalive(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(istrue(player._id_4AAD4F06D972E6B2))
        return player;
    }

    waitframe();
  }
}

_id_F8CAE53234697BBD() {
  if(!isDefined(level._id_1752AC4683799067)) {
    _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_fara_disarmed", "dx_cp_cpr3_sl2s_fara_trapdisarmed"], 1, 1);
    _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_pric_disarmed", "dx_cp_cpr3_sl2s_pric_disarmedone"], 1, 1);
    _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_alex_disarmed", "dx_cp_cpr3_sl2s_alex_disarmedit"], 1, 1);
    level._id_1752AC4683799067 = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  }

  self waittill("trigger", player);
  level._id_32BB2B8B3BC7FE81 = scripts\engine\utility::_id_53C4C53197386572(level._id_32BB2B8B3BC7FE81, 0);

  if(scripts\engine\utility::time_has_passed(level._id_32BB2B8B3BC7FE81, 10)) {
    level._id_32BB2B8B3BC7FE81 = gettime();
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, level._id_1752AC4683799067, 0.2, 0, 1);
  }
}

_id_0AAF64088E0C56B0() {
  level endon("vo_spotBlockedDoor");

  for(;;) {
    level waittill("two_man_door_move");
    wait 0.5;
    player = _id_D5CC3E420888ECE9((7231.3, 14756.4, 342), 900, 200);

    if(isDefined(player)) {
      break;
    }
  }

  aliases = ["dx_cp_cpr3_sl2s_fara_whatisthatsound", "dx_cp_cpr3_sl2s_pric_whatsthatnoise", "dx_cp_cpr3_sl2s_alex_whatsmakingthatsound"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3, 0, [level, "vo_spotBlockedDoor"]);
}

_id_D5CC3E420888ECE9(origin, maxdist, _id_636C8575D7A7768B) {
  _id_CDC5DD6C28C9709D = squared(maxdist);
  _id_4F0FC1C36324AFFB = undefined;

  if(isDefined(_id_636C8575D7A7768B))
    _id_4F0FC1C36324AFFB = squared(_id_636C8575D7A7768B);

  foreach(player in level.players) {
    if(!isalive(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
      continue;
    }
    distsq = distancesquared(origin, player.origin);

    if(isDefined(_id_4F0FC1C36324AFFB) && distsq < _id_636C8575D7A7768B) {
      continue;
    }
    if(distsq < _id_CDC5DD6C28C9709D)
      return player;
  }
}

_id_1677928162D4650B() {
  locations = [(6785.57, 14352.8, 342), (7424.33, 14315.5, 342), (7073.07, 14301.2, 360.231), (7452.79, 14653.2, 403.713)];
  player = _id_BD3828A9F489F6A8(locations, 0.8, 0.1, 600, 1);
  aliases = ["dx_cp_cpr3_sl2s_fara_idontseeanexit", "dx_cp_cpr3_sl2s_pric_novisualonanexit", "dx_cp_cpr3_sl2s_alex_notseeinganexit"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_C35CC8E4BDF3C5E7() {
  _id_7AFF3CCEC9E7D40E = (7234.62, 15116.9, 381.959);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_7AFF3CCEC9E7D40E, 0.8, 0.2, 0, [], 350)[0];
  aliases = ["dx_cp_cpr3_sl2s_fara_itsclearonthisside", "dx_cp_cpr3_sl2s_pric_thissidesclear", "dx_cp_cpr3_sl2s_alex_clearonthisside"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_11912018ABBE6BA9() {
  door = (7235.63, 14745, 362.784);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(door, 0.95, 0.2, 0, [], 350)[0];
  level notify("vo_spotBlockedDoor");
}

_id_6B6C0A75089F6514() {
  level endon("vo_floorIsLava");
  level waittill("player_push_object", player, object);
  _id_F62A6F0439C9173E = object.origin;
  distsq = squared(25);

  while(distancesquared(_id_F62A6F0439C9173E, object.origin) < distsq)
    waitframe();

  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(object.origin);
  aliases = ["dx_cp_cpr3_sl2s_fara_here", "dx_cp_cpr3_sl2s_pric_overere", "dx_cp_cpr3_sl2s_alex_here"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  aliases = ["dx_cp_cpr3_sl2s_fara_wecanpushthis", "dx_cp_cpr3_sl2s_pric_wecanmovethis", "dx_cp_cpr3_sl2s_alex_wecanusethis"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  distsq = squared(100);

  while(distancesquared(_id_F62A6F0439C9173E, object.origin) < distsq)
    waitframe();

  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(object.origin);
  aliases = ["dx_cp_cpr3_sl2s_fara_whereto", "dx_cp_cpr3_sl2s_pric_whereto", "dx_cp_cpr3_sl2s_alex_whereto"];
  _id_62E11D77B25C1D30::_id_6533A630C9443AAC(player.origin, player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 1.4);
  _id_9F925F5509626DF1 = (7333.31, 14260.6, 444);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_9F925F5509626DF1, 0.95, 0.4, 0, player, 600)[0];

  if(distance(_id_9F925F5509626DF1 - (0, 0, 100), object.origin) < 300) {
    return;
  }
  aliases = ["dx_cp_cpr3_sl2s_fara_theresawayoverthewal", "dx_cp_cpr3_sl2s_pric_oppositewall", "dx_cp_cpr3_sl2s_alex_wecangetoverthewall"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  wait 12;

  if(distance(_id_9F925F5509626DF1 - (0, 0, 100), object.origin) < 300) {
    return;
  }
  aliases = ["dx_cp_cpr3_sl2s_fara_pushittothewall", "dx_cp_cpr3_sl2s_pric_getittothewall", "dx_cp_cpr3_sl2s_alex_letsgetittothewall"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_F2D04A72F825CEE4() {
  if(isDefined(level._id_9B661E6037455194))
    return level._id_9B661E6037455194;

  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_fara_thisway", "dx_cp_cpr3_sl2s_fara_theexitisoverhere", "dx_cp_cpr3_filv_fara_onme"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_pric_thisway", "dx_cp_cpr3_sl2s_pric_onmefoundtheexit", "dx_cp_cpr3_filv_pric_thisway"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_alex_thisway", "dx_cp_cpr3_sl2s_alex_overherefoundthewayo", "dx_cp_cpr3_filv_alex_overhere"]);
  level._id_9B661E6037455194 = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  return level._id_9B661E6037455194;
}

_id_05C70E8827622861(_id_6EC5749C5CE7657E, _id_20510600314FE827) {
  _id_20510600314FE827 = scripts\engine\utility::_id_53C4C53197386572(_id_20510600314FE827, scripts\engine\utility::getStruct(_id_6EC5749C5CE7657E, "script_noteworthy").origin);
  level endon(_id_6EC5749C5CE7657E + "_door_open");
  nags = _id_F2D04A72F825CEE4();
  distsq = squared(160);
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(3, 15, 3);

  for(;;) {
    player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(_id_20510600314FE827, 160);
    _id_57A1DB84D888872E = 0;

    foreach(player in level.players) {
      if(!isalive(player) || player isspectatingplayer()) {
        continue;
      }
      if(distancesquared(player.origin, _id_20510600314FE827) > distsq)
        _id_57A1DB84D888872E++;
    }

    if(_id_57A1DB84D888872E == level.players.size) {
      wait 2;
      continue;
    }

    level notify(_id_6EC5749C5CE7657E + "door_nag", player);
    player = scripts\engine\utility::getclosest(_id_20510600314FE827, level.players);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, nags, 0.2, 0, 1);
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
  }
}

_id_405B25F99240FC45() {
  level notify("vo_floorIsLava");
  thread _id_0C34BF6C7252D2DC();
  thread _id_39197477FBAA06CB();
  thread _id_C18FCF05D36A0066();
  door = (7487.5, 14472, 199.96);
  _id_05C70E8827622861("fil_intro_door");
  thread _id_F93E2F77E02EC9BC();
  thread _id_68E1DD5157B77420();
  thread _id_6225887BCF328187();
  thread _id_6D28238937E71EE6();
}

_id_FD2C08CAE78B5486() {
  thread _id_42203BD79388F4B8();
  thread _id_F4BC227AD3BEF17E();
  thread _id_45041E56C2B9A755();
  thread _id_31A4DAD68B496EF0();
  thread _id_996D66B14748F555();
  thread _id_201C60963A73749C();
  thread _id_3D3F3DBAC543F1BA();
  scripts\engine\utility::flag_wait("fil_exit_granted");
}

_id_D033342BE792CC2E() {
  level endon("vo_combat");

  if(scripts\engine\utility::flag("vo_combat")) {
    return;
  }
  aliases = ["dx_cp_cpr3_filv_fara_aqisinhere", "dx_cp_cpr3_filv_pric_aqsinhere", "dx_cp_cpr3_filv_alex_wegotcompany"];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(::getaiarray, 0.95, 0.2, 0, [], 1500)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  aliases = ["dx_cp_cpr3_filv_fara_theyreclose", "dx_cp_cpr3_filv_pric_theyreclose", "dx_cp_cpr3_filv_alex_theyreclose"];
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  aliases = ["dx_cp_cpr3_filv_fara_stayquiet", "dx_cp_cpr3_filv_pric_keepitquiet", "dx_cp_cpr3_filv_alex_keepitquiet"];
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_F93E2F77E02EC9BC() {
  level endon("fil_exit_granted");
  _id_D033342BE792CC2E();
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filv_fara_iseethem", "dx_cp_cpr3_filv_fara_enemyhere", "dx_cp_cpr3_filv_fara_aqhere"], 1, 1);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filv_pric_xray", "dx_cp_cpr3_filv_pric_xrayspotted", "dx_cp_cpr3_filv_pric_gotavisual"], 1, 1);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filv_alex_threatspotted", "dx_cp_cpr3_filv_alex_visualontargets", "dx_cp_cpr3_filv_alex_goteyeson"], 1, 1);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];

  for(;;) {
    player = _id_62E11D77B25C1D30::_id_A0580E9BD081384B()[0];

    if(scripts\engine\utility::flag("vo_strict_combat")) {
      continue;
    }
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 0, 0.5);
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953([8, 12]);
  }
}

_id_68E1DD5157B77420() {
  level endon("fil_exit_granted");
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filv_fara_targetdown", "dx_cp_cpr3_filv_fara_theyredown", "dx_cp_cpr3_filv_fara_gotone"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filv_pric_xraydown", "dx_cp_cpr3_filv_pric_droppedhim", "dx_cp_cpr3_filv_pric_hesdown"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filv_alex_enemydown", "dx_cp_cpr3_filv_alex_gothim", "dx_cp_cpr3_filv_alex_droppedone"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];

  for(;;) {
    level waittill("ai_killed", pos, weapon, mod, player);
    wait 1;

    if(scripts\engine\utility::flag("vo_strict_combat") || !isPlayer(player)) {
      continue;
    }
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 0, 0.5);
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953([8, 12]);
  }
}

_id_0C34BF6C7252D2DC() {
  _id_009EA67BFD2DE342 = (7000, 14000, 350);
  _id_E8F53C7119D381E7 = (7180, 14000, 350);

  for(player = _id_62E11D77B25C1D30::_id_57E617784FB02909(_id_009EA67BFD2DE342, _id_E8F53C7119D381E7, 0.9, 0.3, 0, [], 300); scripts\engine\utility::flag("vo_combat"); player = _id_62E11D77B25C1D30::_id_57E617784FB02909(_id_009EA67BFD2DE342, _id_E8F53C7119D381E7, 0.9, 0.3, 0, [], 300)) {}

  aliases = ["dx_cp_cpr3_filv_fara_weaponsandequipmenth", "dx_cp_cpr3_filv_pric_armoryhere", "dx_cp_cpr3_filv_alex_foundanarmory"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_2FE3A9DAB5F10CD0(player) {
  if(!scripts\engine\utility::flag("vo_combat"))
    aliases = ["dx_cp_cpr3_filv_fara_aqreinforcements_01", "dx_cp_cpr3_filv_pric_aqreinforcements", "dx_cp_cpr3_filv_alex_aqreinforcements_01"];
  else
    aliases = ["dx_cp_cpr3_filv_fara_aqreinforcements", "dx_cp_cpr3_filv_pric_aqreinforcements_01", "dx_cp_cpr3_filv_alex_aqreinforcements"];

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  attacker = undefined;

  while(getaiarray().size > 0)
    level waittill("ai_killed", pos, weapon, mod, attacker);

  if(!isPlayer(attacker)) {
    return;
  }
  wait 1;
  aliases = ["dx_cp_cpr3_filv_fara_wereclear", "dx_cp_cpr3_filv_pric_wereclear", "dx_cp_cpr3_filv_alex_allclear"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(attacker, aliases, 0.6);
}

_id_C18FCF05D36A0066() {
  _id_2BF8DD8AC39471B3 = undefined;

  while(!isDefined(_id_2BF8DD8AC39471B3)) {
    foreach(ai in getaiarray()) {
      if(isalive(ai) && isDefined(ai.aitype) && ai.aitype == "boss_velikan")
        _id_2BF8DD8AC39471B3 = ai;
    }

    wait 0.2;
  }

  if(!isalive(_id_2BF8DD8AC39471B3)) {
    return;
  }
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_2BF8DD8AC39471B3.origin);
  thread _id_2FE3A9DAB5F10CD0(player);
  thread _id_3B8443C06C49C019(_id_2BF8DD8AC39471B3);
  _id_2BF8DD8AC39471B3 waittill("death", attacker);

  if(isPlayer(attacker)) {
    aliases = ["dx_cp_cpr3_filv_fara_launchersdown", "dx_cp_cpr3_filv_pric_theirlaunchersdown", "dx_cp_cpr3_filv_alex_enemylaunchersdown"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(attacker, aliases, 1.2);
    return;
  }
}

_id_3B8443C06C49C019(_id_2BF8DD8AC39471B3) {
  _id_2BF8DD8AC39471B3 endon("death");

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_2BF8DD8AC39471B3, 0.85, 0.4)[0]; !scripts\engine\utility::flag("vo_combat"); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_2BF8DD8AC39471B3, 0.85, 0.4)[0]) {}

  aliases = ["dx_cp_cpr3_filv_fara_theyreusingalauncher", "dx_cp_cpr3_filv_pric_enemylauncher", "dx_cp_cpr3_filv_alex_grenadelauncher"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_6225887BCF328187() {
  level endon("vo_filPowerOn");
  power = (11585.3, 9252.55, 361);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(power, 0.95, 0.4, 0, [], 200)[0];

  if(!scripts\engine\utility::flag("vo_combat"))
    aliases = ["dx_cp_cpr3_filp_fara_foundthepower", "dx_cp_cpr3_filp_pric_foundthepower", "dx_cp_cpr3_filp_alex_foundthepower"];
  else
    aliases = ["dx_cp_cpr3_filp_fara_foundthepower_01", "dx_cp_cpr3_filp_pric_foundthepower_01", "dx_cp_cpr3_filp_alex_foundthepower_01"];

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3, 0, [level, "vo_filPowerOn"]);
}

_id_39197477FBAA06CB() {
  _id_50C0C1CAB31B144F = (7077.37, 13759.2, 313.174);

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_50C0C1CAB31B144F, 0.9, 0.6, 0, [], 250)[0]; scripts\engine\utility::flag("vo_combat"); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_50C0C1CAB31B144F, 0.9, 0.6, 0, [], 250)[0]) {}

  aliases = ["dx_cp_cpr3_filv_fara_theresanopening", "dx_cp_cpr3_filv_pric_downhere", "dx_cp_cpr3_filv_alex_foundanentrypoint"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  thread _id_D9CEB7CDEB3CFC8E();
  thread _id_82E19F3D79A9FBBB();
  level waittill("vo_playerLookedAtOrInWater", player);
  aliases = ["dx_cp_cpr3_filv_fara_itsflooded", "dx_cp_cpr3_filv_pric_itsflooded", "dx_cp_cpr3_filv_alex_itsflooded"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_D9CEB7CDEB3CFC8E() {
  level endon("vo_playerLookedAtOrInWater");
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((7479.1, 13566.2, 48.1237), (6982.09, 13918.9, 252.006), 1);
  level notify("vo_playerLookedAtOrInWater", player);
}

_id_82E19F3D79A9FBBB() {
  level endon("vo_playerLookedAtOrInWater");
  _id_71C3DDC005841ADC = (7031.5, 13738.5, 173.834);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_71C3DDC005841ADC, 0.9, 0.4, 0, [], 500)[0];
  level notify("vo_playerLookedAtOrInWater", player);
}

_id_F4BC227AD3BEF17E() {
  if(scripts\engine\utility::flag("fil_exit_granted")) {
    return;
  }
  level endon("fil_exit_granted");
  door = (10583.3, 9232.37, 350.62);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(door, 0.9, 0.4, 0, [], 200)[0];

  if(!scripts\engine\utility::flag("vo_foundCode") && !scripts\engine\utility::flag("securitykeygenerated")) {
    aliases = ["dx_cp_cpr3_filp_fara_iseeanexit", "dx_cp_cpr3_filp_pric_possibleexithere", "dx_cp_cpr3_filp_alex_mightvefoundourexit"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  }

  scripts\engine\utility::flag_set("vo_filFoundDoor");
  button = getEnt("fil_exit_button", "targetname");

  if(!scripts\engine\utility::flag("fil_power_on")) {
    aliases = ["dx_cp_cpr3_filp_fara_itneedspower", "dx_cp_cpr3_filp_pric_needspower", "dx_cp_cpr3_filp_alex_needspowertoopen"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
    scripts\engine\utility::flag_wait("fil_power_on");
    player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(button, 0.95, 0.4, 0, [], 200)[0];
  }

  scripts\engine\utility::flag_set("vo_sawDoorNeedsCode");

  if(!scripts\engine\utility::flag("vo_foundCode") && !scripts\engine\utility::flag("securitykeygenerated"))
    aliases = ["dx_cp_cpr3_filp_fara_weneedacodetoopenit", "dx_cp_cpr3_filp_pric_itwantsacode", "dx_cp_cpr3_filp_alex_saysitneedsacode"];
  else
    aliases = ["dx_cp_cpr3_filp_fara_theexitissealedtheco", "dx_cp_cpr3_filp_pric_exitslockedthatcodes", "dx_cp_cpr3_filp_alex_thecodesforthisdoori"];

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_42203BD79388F4B8() {
  level endon("securitykeygenerated");
  _id_48497D676003002B = (11206.4, 9250.18, 361.176);

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_48497D676003002B, 0.95, 0.4, 0, [], 200)[0]; scripts\engine\utility::flag("vo_combat"); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_48497D676003002B, 0.95, 0.4, 0, [], 200)[0]) {}

  if(!scripts\engine\utility::flag("fil_power_on")) {
    aliases = ["dx_cp_cpr3_filp_fara_systemcontrolsareher", "dx_cp_cpr3_filp_pric_theresaterminalhere", "dx_cp_cpr3_filp_alex_gotaterminalhere"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);

    if(scripts\engine\utility::flag("vo_filFoundDoor")) {
      aliases = ["dx_cp_cpr3_filp_fara_theyneedpowertoo", "dx_cp_cpr3_filp_pric_needspowertoo", "dx_cp_cpr3_filp_alex_thisneedspowertoo"];
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 0, [level, "fil_power_on"]);
    }

    scripts\engine\utility::flag_wait("fil_power_on");
    player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_48497D676003002B, 0.95, 0.4, 0, [], 200)[0];
  }

  scripts\engine\utility::flag_set("vo_foundCode");

  if(scripts\engine\utility::flag("vo_sawDoorNeedsCode")) {
    aliases = ["dx_cp_cpr3_filp_fara_herethiswillgiveusth", "dx_cp_cpr3_filp_pric_wecangetthecodefromh", "dx_cp_cpr3_filp_alex_wegetthecoderighther"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  } else {
    aliases = ["dx_cp_cpr3_filp_fara_wecangetacodefromher", "dx_cp_cpr3_filp_pric_thiscangenerateacode", "dx_cp_cpr3_filp_alex_sayswecangenerateaco"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
    aliases = ["dx_cp_cpr3_filp_fara_forwhat", "dx_cp_cpr3_filp_pric_forwhat", "dx_cp_cpr3_filp_alex_forwhat"];
    player = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(player.origin, player);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  }

  level endon("securitykeygeneration_start");
  wait 8;

  if(scripts\engine\utility::flag("securitykeygenerated")) {
    return;
  }
  aliases = ["dx_cp_cpr3_filp_fara_getthecodeletsmove", "dx_cp_cpr3_filp_pric_generateacode", "dx_cp_cpr3_filp_alex_letsgetthatcodeandke"];
  player = _id_62E11D77B25C1D30::_id_D63542EBC6F90151((11212.7, 9288.68, 360));
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4, 0, [level, "securitykeygeneration_start"]);
}

_id_6D28238937E71EE6() {
  level waittill("player_interaction_success", player, ent);

  while(ent.targetname != "fil_power_switch")
    level waittill("player_interaction_success", player, ent);

  level notify("vo_filPowerOn");

  if(!scripts\engine\utility::flag("vo_combat")) {
    aliases = ["dx_cp_cpr3_filp_fara_stayoutofthewater", "dx_cp_cpr3_filp_pric_donttouchthewater", "dx_cp_cpr3_filp_alex_noonetouchthewater"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
    player = scripts\engine\utility::flag_wait("fil_power_on");
    aliases = ["dx_cp_cpr3_filp_fara_thepowerson", "dx_cp_cpr3_filp_pric_powersup", "dx_cp_cpr3_filp_alex_powerson"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, [gettime() + 4000]);
  } else {
    aliases = ["dx_cp_cpr3_filp_fara_getoutofthewater", "dx_cp_cpr3_filp_pric_outofthewater", "dx_cp_cpr3_filp_alex_outofthewater"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
    player = scripts\engine\utility::flag_wait("fil_power_on");
    aliases = ["dx_cp_cpr3_filp_fara_powerson", "dx_cp_cpr3_filp_pric_powerson", "dx_cp_cpr3_filp_alex_powerson_01"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, [gettime() + 4000]);
  }

  wait 1;

  if(!scripts\engine\utility::flag("vo_filFoundDoor")) {
    return;
  }
  button = getEnt("fil_exit_button", "targetname");
  aliases = ["dx_cp_cpr3_filp_fara_trytheexit", "dx_cp_cpr3_filp_pric_checktheexit", "dx_cp_cpr3_filp_alex_trytheexitnow"];
  player = _id_62E11D77B25C1D30::_id_D63542EBC6F90151(button.origin);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_201C60963A73749C() {
  level endon("securitykey");
  level waittill("securitykeygeneration_start", player);

  if(!scripts\engine\utility::is_equal(player, level.farah))
    player = scripts\engine\utility::flag_wait("securitykeygenerated");

  aliases = ["dx_cp_cpr3_filp_fara_generatingacode", "dx_cp_cpr3_filp_pric_codesup", "dx_cp_cpr3_filp_alex_gotthecode"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);

  if(scripts\engine\utility::is_equal(player, level.farah)) {
    player = scripts\engine\utility::flag_wait("securitykeygenerated");
    wait 0.5;
  }

  aliases = ["dx_cp_cpr3_filp_fara_itsfifteennumbers", "dx_cp_cpr3_filp_pric_fifteennumbers", "dx_cp_cpr3_filp_alex_fifteendigits"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);

  if(scripts\engine\utility::flag("vo_filSpotSystems")) {
    return;
  }
  level endon("vo_filSpotSystems");
  players = scripts\engine\utility::array_randomize(level.players);
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(12, 25, 3);

  foreach(player in players) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    aliases = ["dx_cp_cpr3_filp_fara_weneedawaytoenterthe", "dx_cp_cpr3_filp_pric_justneedtogetthatblo", "dx_cp_cpr3_filp_alex_gotthecodenowhowdowe"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  }
}

_id_31A4DAD68B496EF0() {
  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(level._id_E5505AF18939A834, 0.9, 0.2, 0, [], 150, (0, 15, 15))[0]; scripts\engine\utility::flag("vo_combat") && !scripts\engine\utility::flag("fil_power_on"); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(level._id_E5505AF18939A834, 0.9, 0.2, 0, [], 150, (0, 15, 15))[0]) {}

  if(!scripts\engine\utility::flag("fil_power_on")) {
    aliases = ["dx_cp_cpr3_filv_fara_nopower", "dx_cp_cpr3_filv_pric_needspower", "dx_cp_cpr3_filv_alex_nopower"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  }

  scripts\engine\utility::flag_wait("securitykeygenerated");
  level endon("securitykey");
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(level._id_E5505AF18939A834, 0.9, 0.2, 0, [], 150, (0, 15, 15))[0];
  scripts\engine\utility::flag_set("vo_filSpotSystems");
  aliases = ["dx_cp_cpr3_filp_fara_herethesesystemsshow", "dx_cp_cpr3_filp_pric_checktheterminalsthe", "dx_cp_cpr3_filp_alex_heythecodesonthesete"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 5;
  aliases = ["dx_cp_cpr3_filp_fara_wecanusethem", "dx_cp_cpr3_filp_pric_wecanusethem", "dx_cp_cpr3_filp_alex_wecanusethem"];
  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 8;
  aliases = ["dx_cp_cpr3_filp_fara_usethesystemstheresn", "dx_cp_cpr3_filp_pric_givetheterminalsago", "dx_cp_cpr3_filp_alex_mightaswelltrytheter"];
  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_90E51894C4E50751() {
  if(!isDefined(level._id_140A222759917E27)) {
    level._id_140A222759917E27 = [];
    level._id_140A222759917E27["farah"] = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_fara_lightquickpusheffort", "dx_cp_cpr3_sl2s_fara_mediumpushefforts", "dx_cp_cpr3_filp_fara_lightshockefforts"]);
    level._id_140A222759917E27["price"] = scripts\engine\utility::create_deck(["dx_cp_cpr3_slpw_pric_painlandingeffort", "dx_cp_cpr3_slpw_pric_painlandingeffort_01", "dx_cp_cpr3_slpw_pric_painlandingeffort_02"]);
    level._id_140A222759917E27["alex"] = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_alex_lightquickpusheffort", "dx_cp_cpr3_sl2s_alex_mediumpushefforts", "dx_cp_cpr3_sl2s_alex_dooreffort"]);
  }

  if(isDefined(self._id_CEE915289E9FE02E) && !scripts\engine\utility::time_has_passed(self._id_CEE915289E9FE02E, 1.5)) {
    return;
  }
  if(!isalive(self) || _id_5D265B4FCA61F070::is_speaking() || _id_0AFB7E332AEE4BF2::player_in_laststand(self)) {
    return;
  }
  self._id_CEE915289E9FE02E = gettime();
  alias = level._id_140A222759917E27[self._id_938E8B2CA6549759] scripts\engine\utility::deck_draw();

  foreach(player in level.players) {
    if(!isDefined(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
      continue;
    }
    context = scripts\engine\utility::ter_op(player == self, "dx_player", "dx_open_air");
    self _meth_480DEAF73792CCF1(alias, "dx_type", context, player);
  }
}

_id_A76DBCE33D5CD2A8(alias) {
  _id_49066D76D23A1B10 = [];

  foreach(player in level.players) {
    origin = sortbydistance(level._id_E5505AF18939A834, player.origin)[0].origin;

    if(scripts\engine\utility::array_contains(_id_49066D76D23A1B10, origin)) {
      continue;
    }
    _id_49066D76D23A1B10[_id_49066D76D23A1B10.size] = origin;
    playsoundatpos(origin, alias);
  }

  wait(lookupsoundlength(alias) / 1000);
}

_id_0AD08836E7BD1B8B() {}

_id_45041E56C2B9A755() {
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_fara_timeranout", "dx_cp_cpr3_filp_fara_wereoutoftime", "dx_cp_cpr3_filp_fara_weranoutoftime"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_pric_timesup", "dx_cp_cpr3_filp_pric_timeexpired", "dx_cp_cpr3_filp_pric_outoftime"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_alex_tooslow", "dx_cp_cpr3_filp_alex_ourtimesup", "dx_cp_cpr3_filp_alex_timesup"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];

  for(;;) {
    level waittill("securityKeyTimeout");
    scripts\engine\utility::flag_set("vo_disableWrongCode");
    _id_A76DBCE33D5CD2A8("dx_cp_cpr3_filp_rupa_locktimerreset");
    wait 0.7;
    player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
    scripts\engine\utility::flag_clear("vo_disableWrongCode");
    _id_9DF1985CEC840E0B();
  }
}

_id_9DF1985CEC840E0B(aliases) {
  if(!isDefined(level._id_4745E884E4C74B77)) {
    _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_fara_wehavetostartagain", "dx_cp_cpr3_filp_fara_inputthecodewerewast"]);
    _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_pric_wehavetostartover", "dx_cp_cpr3_filp_pric_startitagainweneedth"]);
    _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_alex_wellhavetogoagain", "dx_cp_cpr3_filp_alex_runitagainletsmakeit"]);
    level._id_4745E884E4C74B77 = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  }

  level endon("securitykey");
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(10, 20, 3);
  player = undefined;

  for(;;) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);

    if(isDefined(player))
      player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
    else
      player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();

    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, level._id_4745E884E4C74B77, 0.2);
  }
}

_id_81CAFC3299691816(aliases) {
  level endon("securitykey");
  wait 6;
  _id_5BED58AAD4365C33 = level._id_0A67C97EB982F346[level._id_F19C237F80D770E5];
  _id_C1248F00E87B27CE = level._id_E5505AF18939A834[_id_5BED58AAD4365C33];
  player = _id_D5CC3E420888ECE9(_id_C1248F00E87B27CE.origin, 200);

  if(isDefined(player)) {
    return;
  }
  player = _id_62E11D77B25C1D30::_id_D63542EBC6F90151(_id_C1248F00E87B27CE.origin);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4, 0, [level, "securitykey"]);
}

_id_996D66B14748F555() {
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_fara_hurry", "dx_cp_cpr3_filp_fara_gogo", "dx_cp_cpr3_filp_fara_move"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_pric_movefast", "dx_cp_cpr3_filp_pric_keepitmoving", "dx_cp_cpr3_filp_pric_makeitsharpish"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_alex_doubletimeit", "dx_cp_cpr3_filp_alex_makeitfast", "dx_cp_cpr3_filp_alex_haulass"]);
  _id_E625C00A42003F8F = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_fara_nextsystemgo", "dx_cp_cpr3_filp_fara_nextonemove", "dx_cp_cpr3_filp_fara_gettothenextone"], 1, 1);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_pric_nextterminalhitit", "dx_cp_cpr3_filp_pric_hitthenextterminal", "dx_cp_cpr3_filp_pric_nextterminalsup"], 1, 1);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_alex_nextterminalyoureup", "dx_cp_cpr3_filp_alex_nextonehitit", "dx_cp_cpr3_filp_alex_usethenextterminal"], 1, 1);
  _id_B3FD8743ADC6D2C7 = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_fara_wrongone", "dx_cp_cpr3_filp_fara_thatdidntwork", "dx_cp_cpr3_filp_fara_wrongcode"], 1, 1);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_pric_didntwork", "dx_cp_cpr3_filp_pric_thatswrong", "dx_cp_cpr3_filp_pric_wrongcode"], 1, 1);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_alex_scratchthat", "dx_cp_cpr3_filp_alex_thatdidntwork", "dx_cp_cpr3_filp_alex_wrongcode"], 1, 1);
  _id_48980BABD264F0B8 = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  _id_4BA3D53CCF28509D = scripts\engine\utility::create_deck([0, 1, 0]);
  _id_9A2E1E7F65A75F91 = 1;
  scripts\engine\utility::flag_set("vo_filRestart");

  for(;;) {
    level waittill("securitykeyinput", _id_FAF6447BA7266992, button, player);

    if(_id_FAF6447BA7266992 == "correct") {
      if(level._id_F19C237F80D770E5 > 14) {
        return;
      }
      thread _id_81CAFC3299691816(_id_E625C00A42003F8F);
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_FFAE2AA995491A28()[button._id_1E1ACCA53AE06826], 0.1, 0, 0.5);

      if(scripts\engine\utility::flag("vo_filRestart")) {
        scripts\engine\utility::flag_clear("vo_filRestart");
        _id_A76DBCE33D5CD2A8("dx_cp_cpr3_filp_rupa_locktimerstarted");
      }

      if(_id_9A2E1E7F65A75F91) {
        _id_9A2E1E7F65A75F91 = 0;
        _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(player.origin, player);
        aliases = ["dx_cp_cpr3_filp_fara_thatdidsomething", "dx_cp_cpr3_filp_pric_thatdidsomething", "dx_cp_cpr3_filp_alex_thatdidsomething"];
        _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.2);
      }

      if(_id_4BA3D53CCF28509D scripts\engine\utility::deck_draw())
        _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_B3FD8743ADC6D2C7, 0.3);

      continue;
    }

    if(scripts\engine\utility::flag("vo_disableWrongCode")) {
      continue;
    }
    scripts\engine\utility::flag_set("vo_filRestart");
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_FFAE2AA995491A28()[button._id_1E1ACCA53AE06826], 0.1, 0, 0.5);
    wait 0.5;
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_48980BABD264F0B8, 0.3);

    if(level._id_F19C237F80D770E5 > 0)
      thread _id_9DF1985CEC840E0B();
  }
}

_id_3D3F3DBAC543F1BA() {
  level endon("b1fildone");
  player = scripts\engine\utility::flag_wait("fil_exit_granted");
  _id_A76DBCE33D5CD2A8("dx_cp_cpr3_filp_rupa_codeaccepted");
  wait 0.4;
  aliases = ["dx_cp_cpr3_filp_fara_thecodewasaccepted", "dx_cp_cpr3_filp_pric_werein", "dx_cp_cpr3_filp_alex_codeaccepted"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  wait 1.3;
  _id_A76DBCE33D5CD2A8("dx_cp_cpr3_filp_rupa_securitydoorunlocked");
  aliases = ["dx_cp_cpr3_filp_fara_gettotheexit", "dx_cp_cpr3_filp_pric_backtotheexit", "dx_cp_cpr3_filp_alex_regroupattheexit"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);

  foreach(player in level.players) {
    wait 20;
    aliases = ["dx_cp_cpr3_filp_fara_wehaveanexitletstake", "dx_cp_cpr3_filp_pric_exitdoorsunlockedlet", "dx_cp_cpr3_filp_alex_letshittheexit"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  }
}

_id_FFAE2AA995491A28() {
  if(isDefined(level._id_DC32D160DA356F18))
    return level._id_DC32D160DA356F18;

  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_fara_zero", "dx_cp_cpr3_filp_fara_zero_01"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_pric_zero", "dx_cp_cpr3_filp_pric_zero_01"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_alex_zero", "dx_cp_cpr3_filp_alex_zero_01"]);
  _id_7E171088F32EAB7F = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_fara_one", "dx_cp_cpr3_filp_fara_one_01"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_pric_one", "dx_cp_cpr3_filp_pric_one_01"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_alex_one", "dx_cp_cpr3_filp_alex_one_01"]);
  _id_54588204349C77DB = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_fara_two", "dx_cp_cpr3_filp_fara_two_01"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_pric_two", "dx_cp_cpr3_filp_pric_two_01"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_alex_two", "dx_cp_cpr3_filp_alex_two_01"]);
  _id_E94F7B032A5F1695 = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_fara_three", "dx_cp_cpr3_filp_fara_three_01"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_pric_three", "dx_cp_cpr3_filp_pric_three_01"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_alex_three", "dx_cp_cpr3_filp_alex_three_01"]);
  _id_6CAD5DC7F6D9541F = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_fara_four", "dx_cp_cpr3_filp_fara_four_01"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_pric_four", "dx_cp_cpr3_filp_pric_four_01"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_alex_four", "dx_cp_cpr3_filp_alex_four_01"]);
  _id_47E5B099C2CCBA89 = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_fara_five", "dx_cp_cpr3_filp_fara_five_01"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_pric_five", "dx_cp_cpr3_filp_pric_five_01"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_alex_five", "dx_cp_cpr3_filp_alex_five_01"]);
  _id_657BF799D8B2ACB9 = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_fara_six", "dx_cp_cpr3_filp_fara_six_01"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_pric_six", "dx_cp_cpr3_filp_pric_six_01"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_alex_six", "dx_cp_cpr3_filp_alex_six_01"]);
  _id_BE54F3030B11415F = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_fara_seven", "dx_cp_cpr3_filp_fara_seven_01"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_pric_seven", "dx_cp_cpr3_filp_pric_seven_01"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_alex_seven", "dx_cp_cpr3_filp_alex_seven_01"]);
  _id_C9D305E76CDFFA12 = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_fara_eight", "dx_cp_cpr3_filp_fara_eight_01"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_pric_eight", "dx_cp_cpr3_filp_pric_eight_01"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_alex_eight", "dx_cp_cpr3_filp_alex_eight_01"]);
  _id_3D242293F7E9ABCC = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_fara_nine", "dx_cp_cpr3_filp_fara_nine_01"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_pric_nine", "dx_cp_cpr3_filp_pric_nine_01"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_filp_alex_nine", "dx_cp_cpr3_filp_alex_nine_01"]);
  _id_BB8BD85C48C90B19 = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  level._id_DC32D160DA356F18 = [_id_7E171088F32EAB7F, _id_54588204349C77DB, _id_E94F7B032A5F1695, _id_6CAD5DC7F6D9541F, _id_47E5B099C2CCBA89, _id_657BF799D8B2ACB9, _id_BE54F3030B11415F, _id_C9D305E76CDFFA12, _id_3D242293F7E9ABCC, _id_BB8BD85C48C90B19];
  return level._id_DC32D160DA356F18;
}

_id_5050BBDC53CD02AA() {
  thread _id_0200E7E3C5A55483();
  thread _id_195AB69E485F3DFD();
  thread _id_697F7B94E5F60D29();
  _id_DFAA1AC3B35C67D1 = getEnt("ventroom_start_trigger", "targetname");
  _id_DFAA1AC3B35C67D1 waittill("trigger");
}

_id_0200E7E3C5A55483() {
  level endon("kitchen_trigger");
  player = scripts\engine\utility::flag_wait("b1fildone");
  wait 0.5;
  aliases = ["dx_cp_cpr3_file_fara_itsopen", "dx_cp_cpr3_file_pric_exitsopen", "dx_cp_cpr3_file_alex_doorsopen"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);
  wait 0.4;
  aliases = ["dx_cp_cpr3_file_fara_letsmove", "dx_cp_cpr3_file_pric_staysharp", "dx_cp_cpr3_file_alex_letssweepthrough"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 1;
  aliases = ["dx_cp_cpr3_file_fara_theybuildwarheadsher", "dx_cp_cpr3_file_pric_sovietsneverheardofk", "dx_cp_cpr3_file_alex_allthattoopenadoorno"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(player.origin, player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);
}

_id_195AB69E485F3DFD() {
  level waittill("kitchen_trigger");
  thread _id_3E3D135D170138A2();
  aliases = ["dx_cp_cpr3_file_fara_ambush", "dx_cp_cpr3_file_pric_ambush", "dx_cp_cpr3_file_alex_ambush"];
  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, [gettime() + 650], 1, 0.65);
  aliases = ["dx_cp_cpr3_file_fara_findcover", "dx_cp_cpr3_file_pric_gettocover", "dx_cp_cpr3_file_alex_takecover"];
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_3E3D135D170138A2() {
  juggernaut = undefined;

  while(!isDefined(juggernaut)) {
    foreach(ai in getaiarray()) {
      if(ai scripts\cp\utility::isjuggernaut())
        juggernaut = ai;
    }

    wait 0.2;
  }

  if(!isalive(juggernaut)) {
    return;
  }
  thread _id_8907345DB56A9604(juggernaut);
  juggernaut waittill("death", attacker);

  if(isPlayer(attacker)) {
    aliases = ["dx_cp_cpr3_file_fara_theirjuggernautsdown", "dx_cp_cpr3_file_pric_enemyjuggernautsdown", "dx_cp_cpr3_file_alex_theirjuggernautsdown"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(attacker, aliases, 1.2);
    return;
  }
}

_id_8907345DB56A9604(juggernaut) {
  juggernaut endon("death");
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(juggernaut, 0.85, 0.4)[0];

  if(!scripts\engine\utility::is_equal(player, level.alex)) {
    return;
  }
  aliases = ["", "", "dx_cp_cpr3_file_alex_enemyjuggernaut"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_697F7B94E5F60D29() {
  childthread _id_572484DB0E7C83F6();
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((10531.1, 7100.78, 238.3), (10716.7, 6848.75, 429.972));
  aliases = ["dx_cp_cpr3_file_fara_throughhere", "dx_cp_cpr3_file_pric_thisway", "dx_cp_cpr3_file_alex_thisway"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((11943.6, 6706.22, 244.386), (12097.7, 6460.99, 487.617));

  if(!scripts\engine\utility::flag("vo_filEndTunnelConvo_finished")) {
    return;
  }
  aliases = ["dx_cp_cpr3_file_fara_inhere", "dx_cp_cpr3_file_pric_inhere", "dx_cp_cpr3_file_alex_inhere"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_C5ABCB0109D20AB4() {
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr3_filv_alex_hadirsstillmovingdee", 0.3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr3_filv_fara_heshouldberottinginj", 0.4);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr3_filv_pric_mustvebeenwherehelea", 0.2);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr3_filv_pric_aqneededaleader", 0.6);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr3_filv_fara_hadirisonlyaterroris", 0.3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr3_filv_fara_nowhespromisedthemth", 0.4);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr3_filv_alex_wellstophimfarah", 0.2);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr3_filv_alex_whateverittakes", 0.2);
  scripts\engine\utility::flag_set("vo_filEndTunnelConvo_finished");
}

_id_572484DB0E7C83F6() {
  player = _id_9E7257487DB14022();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_63A81802C49F3E41(), 0.2);
  _id_C5ABCB0109D20AB4();
}

_id_63A81802C49F3E41() {
  if(!isDefined(level._id_CF6CF5D3C3839BB1)) {
    _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_fara_flashlights", "dx_cp_cpr3_file_fara_lightsup"]);
    _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_pric_torcheson", "dx_cp_cpr3_file_pric_torches"]);
    _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_alex_gowhitelight", "dx_cp_cpr3_file_alex_flashlights"]);
    level._id_CF6CF5D3C3839BB1 = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  }

  return level._id_CF6CF5D3C3839BB1;
}

_id_7431244D9DF44D3E() {
  thread _id_34529D55BB81E5A1();
  thread _id_E49EA6594310231F();
  thread _id_94916F33F3618C27();
  thread _id_4CBAC7A284AC4003();
  thread _id_943E050D247A48C8();
  thread _id_CB5A45F0609BEC99();
  thread _id_7732DCF315A9479F();
  thread _id_4A1B8A7A466B0E9B();
  thread _id_83C556935E4984FD();
}

_id_29C70580051E35D1() {
  thread _id_FB9FC18B3B5E3979("vent_exit_struct");
  thread _id_05C70E8827622861("vent_exit_struct");
  thread _id_770702927170880A();
  thread _id_4ADC6B2E1AA941E4();
  thread _id_83C4B0F97909EB1F();
  thread _id_ABAA2688E88DA6BF();
  thread _id_C3C90018B6F2150C();
  _id_B8FF749D7F3F25C1 = undefined;

  while(!isDefined(_id_B8FF749D7F3F25C1)) {
    _id_B8FF749D7F3F25C1 = getEnt("p0_trigger_spawner", "targetname");
    wait 0.2;
  }

  _id_B8FF749D7F3F25C1 waittill("trigger");
}

_id_34529D55BB81E5A1() {
  _id_0D32078955171127 = (11894, 6874, 400);
  ents = getentarrayinradius("script_model", "classname", _id_0D32078955171127, 800);
  _id_3494E2AE6B367DE9 = [];

  foreach(ent in ents) {
    if(scripts\engine\utility::is_equal(ent.model, "misc_c4_explosive_small_01"))
      _id_3494E2AE6B367DE9[_id_3494E2AE6B367DE9.size] = ent;
  }

  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();
  checkpoint = scripts\engine\utility::ter_op(checkpoint != "", checkpoint, getDvar("start"));

  if(checkpoint != "floor_is_lava_vent" && checkpoint != "boss1_fil_vent")
    scripts\engine\utility::flag_wait("vo_filEndTunnelConvo_finished");

  result = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_3494E2AE6B367DE9, 0.95, 0.2, 0, [], 200);
  _id_3494E2AE6B367DE9 = _id_5C5112342E1DBEE5(_id_3494E2AE6B367DE9, result[1].origin, 10);
  aliases = ["dx_cp_cpr3_file_fara_explosives", "dx_cp_cpr3_file_pric_explosives", "dx_cp_cpr3_file_alex_explosives"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(result[0], aliases, 0.2);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_3494E2AE6B367DE9, 0.95, 0.2, 0, [result[0]], 225)[0];
  aliases = ["dx_cp_cpr3_file_fara_theyreeverywhere", "dx_cp_cpr3_file_pric_roomswired", "dx_cp_cpr3_file_alex_theroomswired"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);

  if(scripts\engine\utility::flag("vo_foundCrawlSpace")) {
    return;
  }
  level endon("vo_foundCrawlSpace");
  wait 10;
  aliases = ["dx_cp_cpr3_file_fara_lookforawaythrough", "dx_cp_cpr3_file_pric_letspushthrough", "dx_cp_cpr3_file_alex_letsgetthroughherefa"];
  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_5C5112342E1DBEE5(array, origin, dist) {
  distsq = squared(dist);
  _id_BFC65A378A6D8EFE = [];

  foreach(item in array) {
    if(distancesquared(item.origin, origin) > distsq)
      _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = item;
  }

  return _id_BFC65A378A6D8EFE;
}

_id_E49EA6594310231F() {
  button = (12035.7, 7311.76, 347.232);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(button, 0.95, 0.3, 0, [], 300)[0];
  aliases = ["dx_cp_cpr3_file_fara_foundthedoorcontrols", "dx_cp_cpr3_file_pric_foundthedoorcontrols", "dx_cp_cpr3_file_alex_thedoorcontrolsarehe"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_94916F33F3618C27() {
  level endon("multiPersonDoor_startOpen");
  level waittill("multiPersonDoor_buttonReleased", player);
  wait 0.5;
  aliases = ["dx_cp_cpr3_file_fara_didntopen", "dx_cp_cpr3_file_pric_didntwork", "dx_cp_cpr3_file_alex_negativeonthedoor"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_4D8E6B8FE1731897() {}

_id_4CBAC7A284AC4003() {
  childthread _id_4D8E6B8FE1731897();
  button = (12062.6, 7362.23, 347.698);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(button, 0.95, 0.3, 0, [], 300)[0];
  aliases = ["dx_cp_cpr3_file_fara_therearedoorcontrols_01", "dx_cp_cpr3_file_pric_gotdoorcontrolsonthi", "dx_cp_cpr3_file_alex_theresdoorcontrolson"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  level notify("vo_spotSecondaryDoorControls");
}

_id_943E050D247A48C8() {
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((12198, 7132.04, 323.722), (12252.6, 7197.9, 383.126));
  scripts\engine\utility::flag_set("vo_foundCrawlSpace");
  aliases = ["dx_cp_cpr3_file_fara_ifoundacrawlspace", "dx_cp_cpr3_file_pric_foundacrawlspace", "dx_cp_cpr3_file_alex_foundacrawlspace"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_CB5A45F0609BEC99() {
  level waittill("multiPersonDoor_startOpen", door);
  wait 0.6;
  aliases = ["dx_cp_cpr3_file_fara_thatworked", "dx_cp_cpr3_file_pric_thatlldoit", "dx_cp_cpr3_file_alex_thatworks"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(door.origin);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_7732DCF315A9479F() {
  level endon("vo_reachVentClimbUp");
  ledge = (11816.6, 7437.46, 439.167);

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(ledge, 0.9, 0.1, 0, [], 300)[0]; scripts\engine\utility::is_equal(player, level.farah); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(ledge, 0.9, 0.1, 0, [], 300)[0]) {}

  aliases = ["", "dx_cp_cpr3_file_pric_uptop", "dx_cp_cpr3_file_alex_checkhigh"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  wait 1;
  aliases = ["dx_cp_cpr3_file_fara_findsomethingwecancl", "dx_cp_cpr3_file_pric_weneedtogetupthere", "dx_cp_cpr3_file_alex_wellneedaboosttogetu"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_4A1B8A7A466B0E9B() {
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((11816.7, 7388.76, 375.907), (11571.2, 7518.03, 643.788), 1);
  level notify("vo_reachVentClimbUp");
  aliases = ["dx_cp_cpr3_file_fara_uphere", "dx_cp_cpr3_file_pric_uphere", "dx_cp_cpr3_file_alex_climbuphere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_83C4B0F97909EB1F() {
  _id_6CB6920473D33EE3 = (12211.1, 7500.93, 587.026);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_6CB6920473D33EE3, 0.95, 0.3, 0, [], 250)[0];
  aliases = ["dx_cp_cpr3_file_fara_theresanopening", "dx_cp_cpr3_file_pric_theresawaythrough", "dx_cp_cpr3_file_alex_thinkifoundawaythrou"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_0CDAB6783127E317() {
  _id_9C70BE53D55AC5CD = scripts\engine\utility::getStruct("fire_spout", "targetname");
  return _id_9C70BE53D55AC5CD;
}

_id_D0CE94EB754E4AFE() {}

_id_618A50BE726365AC() {}

_id_83C556935E4984FD() {}

_id_C3C90018B6F2150C() {
  tripwires = (11850.2, 7855, 525.517);

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(tripwires, 0.5, 0.4, 0, [], 600)[0]; scripts\engine\utility::is_equal(player, game["vo_saidSetTripwires"]); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(tripwires, 0.6, 0.4, 0, [], 600)[0]) {}

  aliases = ["dx_cp_cpr3_sl2s_fara_theysettraps", "dx_cp_cpr3_sl2s_pric_therestripwires", "dx_cp_cpr3_sl2s_alex_theysettripwires"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);

  if(isDefined(game["vo_saidMoveSlow"]))
    player = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(player.origin, [player, game["vo_saidMoveSlow"]]);
  else
    player = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(player.origin, [player]);

  aliases = ["dx_cp_cpr3_sl2s_fara_moveslow", "dx_cp_cpr3_sl2s_pric_slowandsteady", "dx_cp_cpr3_sl2s_alex_dontrush"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);

  if(scripts\engine\utility::flag("vo_tripwiresVentSpottedExit")) {
    return;
  }
  level endon("vo_tripwiresVentSpottedExit");
  wait 8;
  aliases = ["dx_cp_cpr3_file_fara_idontseeawayout", "dx_cp_cpr3_file_pric_nosignofanexit", "dx_cp_cpr3_file_alex_novisualonanexit"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_FB9FC18B3B5E3979(_id_6EC5749C5CE7657E) {
  level endon(_id_6EC5749C5CE7657E + "door_nag");
  _id_9F925F5509626DF1 = (12120.7, 8261.97, 583.545);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_9F925F5509626DF1, 0.85, 0.4, 0, [], 600)[0];
  scripts\engine\utility::flag_set("vo_tripwiresVentSpottedExit");
  aliases = ["dx_cp_cpr3_file_fara_iseeawayoutuphighatt", "dx_cp_cpr3_file_pric_gotourexituptopinthe", "dx_cp_cpr3_file_alex_exitpointsaboveusint"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  wait 0.5;
  aliases = ["dx_cp_cpr3_file_fara_usetheshelvestoclimb", "dx_cp_cpr3_file_pric_usetheshelves", "dx_cp_cpr3_file_alex_climbtheshelvestoget"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_9F925F5509626DF1);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_770702927170880A() {
  childthread _id_B8F092D6DCFBBBAB();
  childthread _id_31D1A04E87B2ADC2();
  level waittill("vo_playerLookedAtOrInAirDuct", player);
  aliases = ["dx_cp_cpr3_file_fara_wecrawlthroughhere", "dx_cp_cpr3_file_pric_werecrawlingthroughh", "dx_cp_cpr3_file_alex_letsgetcrawling"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((11954.1, 8591.95, 525.832), (11991.7, 8524.18, 655.317));
  aliases = ["dx_cp_cpr3_file_fara_goingright", "dx_cp_cpr3_file_pric_goright", "dx_cp_cpr3_file_alex_hangaright"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((12535.4, 8632.44, 550.442), (12613.9, 8690.9, 660.315));
  aliases = ["dx_cp_cpr3_file_fara_thiswaycrawlthrough", "dx_cp_cpr3_file_pric_thiswaycrawlthrough", "dx_cp_cpr3_file_alex_thiswaycrawlthrough"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
  wait 0.5;
  aliases = ["dx_cp_cpr3_file_fara_wehavetodropdown", "dx_cp_cpr3_file_pric_dropdownhere", "dx_cp_cpr3_file_alex_wellhavetodrophere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
}

_id_B8F092D6DCFBBBAB() {
  level endon("vo_playerLookedAtOrInAirDuct");
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((11935.9, 8405.1, 648.406), (11851.8, 8843.64, 542.702), 1);
  level notify("vo_playerLookedAtOrInAirDuct", player);
}

_id_31D1A04E87B2ADC2() {
  level endon("vo_playerLookedAtOrInAirDuct");
  _id_A1E87640C2AF164F = (11892.6, 8557.08, 606);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_A1E87640C2AF164F, 0.9, 0.4, 0, [], 300)[0];
  level notify("vo_playerLookedAtOrInAirDuct", player);
}

_id_21EE519944B3CBDE() {
  _id_57E7CD6A22985C6C = [];

  foreach(player in level.players) {
    if(player _meth_E40102956C887F7C())
      _id_57E7CD6A22985C6C[_id_57E7CD6A22985C6C.size] = player;
  }

  return _id_57E7CD6A22985C6C;
}

_id_4ADC6B2E1AA941E4() {
  while(_id_21EE519944B3CBDE().size < 2)
    waitframe();

  wait 3;
  players = _id_2A0120538707A7A9();

  while(players.size < 2) {
    players = _id_2A0120538707A7A9();
    waitframe();
  }

  if(_id_FA8008FA2E94CA12(players)) {
    return;
  }
  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F(players);
  aliases = ["dx_cp_cpr3_file_fara_doyouseeanexit", "dx_cp_cpr3_file_pric_findanything", "dx_cp_cpr3_file_alex_anyoneseeawayout"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
  players = _id_2A0120538707A7A9();

  while(players.size < 2) {
    players = _id_2A0120538707A7A9();
    waitframe();
  }

  if(_id_FA8008FA2E94CA12(players)) {
    return;
  }
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player, players);
  aliases = ["dx_cp_cpr3_file_fara_negative", "dx_cp_cpr3_file_pric_negative", "dx_cp_cpr3_file_alex_nothingyet"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
  wait 0.6;

  while(players.size < 2) {
    players = _id_2A0120538707A7A9();
    waitframe();
  }

  if(_id_FA8008FA2E94CA12(players)) {
    return;
  }
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player, players);
  aliases = ["dx_cp_cpr3_file_fara_checkunderthewater", "dx_cp_cpr3_file_pric_checkunderwater", "dx_cp_cpr3_file_alex_checkunderwater"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);

  for(;;) {
    players = _id_2A0120538707A7A9();

    if(players.size < 1) {} else if(_id_FA8008FA2E94CA12(players)) {
      break;
    }

    waitframe();
  }
}

_id_FA8008FA2E94CA12(players) {
  player = _id_2BC56633035FF414(players);

  if(isDefined(player)) {
    aliases = ["dx_cp_cpr3_file_fara_foundawaythrough", "dx_cp_cpr3_file_pric_theresawaythrough_01", "dx_cp_cpr3_file_alex_gotusawaythrough"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
    aliases = ["dx_cp_cpr3_file_fara_wellhavetoswim", "dx_cp_cpr3_file_pric_wellhavetoswimforit", "dx_cp_cpr3_file_alex_wellhavetoswimforit"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
    return 1;
  }

  return 0;
}

_id_2BC56633035FF414(players) {
  foreach(player in players) {
    if(istrue(player._id_18894AAB53D25C15))
      return player;
  }
}

_id_ABAA2688E88DA6BF() {
  _id_37162ADD31FFCB93 = (13135.5, 8776.23, 47.0496);
  players = [];

  while(players.size < level.players.size) {
    player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_37162ADD31FFCB93, 0.8, 0.2, 0, players, 400)[0];

    if(!player _meth_6F55D55CCFF20D14()) {
      continue;
    }
    players = scripts\engine\utility::array_add(players, player);
    player._id_18894AAB53D25C15 = 1;
  }
}

_id_2A0120538707A7A9() {
  _id_878914B0358BC7B5 = _id_62E11D77B25C1D30::_id_7677B20356982F00((13050.9, 8908.08, 182.942), (12280.3, 8644.86, 12.061), 0);
  players = [];

  foreach(player in _id_878914B0358BC7B5) {
    if(!player _meth_6F55D55CCFF20D14())
      players[players.size] = player;
  }

  return players;
}

_id_744D949F22BE30B8() {
  thread _id_87854E4CA43EB51B();
  thread _id_C9CB975A8FFD91DA();
  thread _id_7B4501917754FC9B();
  thread _id_F7E068D39BBCA9E5();
  thread _id_14A740AD743B6145();
}

_id_87854E4CA43EB51B() {
  level endon("saw_used");
  _id_A74F7EFB3166D264 = (15252.6, 9491.29, 597.712);
  door2 = (14853.4, 9436.45, 597.712);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803([_id_A74F7EFB3166D264, door2], 0.95, 0.2, 0, [], 300)[0];
  aliases = ["dx_cp_cpr3_ssdr_fara_theysealedthedoors", "dx_cp_cpr3_ssdr_pric_doorssealed", "dx_cp_cpr3_ssdr_alex_aqsealedthedoors"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  wait 0.5;
  player = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(player.origin, player);

  if(!_id_C4CAAC251871E691()) {
    aliases = ["dx_cp_cpr3_ssdr_fara_weneedtocutthrough", "dx_cp_cpr3_ssdr_pric_needasaw", "dx_cp_cpr3_ssdr_alex_weneedasaw"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  }

  player = _id_F75BF134C689F3D0();
  wait 1;
  player = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(player.origin, player);
  aliases = ["dx_cp_cpr3_ssdr_fara_cutthroughgo", "dx_cp_cpr3_ssdr_pric_usethesaw", "dx_cp_cpr3_ssdr_alex_sawthrough"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 5;
  _id_7711FEB2B9279561 = _id_F75BF134C689F3D0();
  player = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(_id_7711FEB2B9279561.origin, [player, _id_7711FEB2B9279561]);
  aliases = ["dx_cp_cpr3_ssdr_fara_cutthedoor", "dx_cp_cpr3_ssdr_pric_getthosedoorsopennow", "dx_cp_cpr3_ssdr_alex_cutthosedoorsmakeitf"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_C9CB975A8FFD91DA() {
  _id_BE31E8030AEAE176 = (15978.3, 9461.69, 598.862);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_BE31E8030AEAE176, 0.95, 0.2, 0, [], 300)[0];
  aliases = ["dx_cp_cpr3_ssdr_fara_ifoundasaw", "dx_cp_cpr3_ssdr_pric_foundasaw", "dx_cp_cpr3_ssdr_alex_gotasawhere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_7B4501917754FC9B() {
  scripts\engine\utility::flag_wait_either("sub_door_2_cut", "sub_door_1_cut");
  wait 0.5;
  door = (15007.5, 9540.76, 593.772);

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(door, 0.95, 0.2, 0, [], 500)[0]; player hasweapon("iw9_me_buzzsaw_mp"); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(door, 0.95, 0.2, 0, [], 500)[0]) {}

  aliases = ["dx_cp_cpr3_ssdr_fara_nextonecutthrough", "dx_cp_cpr3_ssdr_pric_cutthroughthenextone", "dx_cp_cpr3_ssdr_alex_anotherdoorgetthesaw"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_F7E068D39BBCA9E5() {
  level waittill("boss_go_behind_glass", struct);
  level._id_E2958F412A7425C0 _id_5D265B4FCA61F070::say("dx_cp_cpr3_ssdr_aqld_killthem");
  wait 0.3;
  level._id_E2958F412A7425C0 _id_5D265B4FCA61F070::say("dx_cp_cpr3_ssdr_aqld_iwillwarnhadir");
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(struct.origin);
  aliases = ["dx_cp_cpr3_ssdr_fara_hesgoingtowarnhadir", "dx_cp_cpr3_ssdr_pric_hesgoingforhadir", "dx_cp_cpr3_ssdr_alex_hellleadustohadir"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  player = _id_F75BF134C689F3D0();
  door = (15125.3, 9802.2, 340.616);
  player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(door, 200, player)[0];
  aliases = ["dx_cp_cpr3_ssdr_fara_getthedooropen", "dx_cp_cpr3_ssdr_pric_getthisdooropennow", "dx_cp_cpr3_ssdr_alex_getthedooropennow"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_14A740AD743B6145() {
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_fara_werethrough", "dx_cp_cpr3_ssdr_fara_movemove", "dx_cp_cpr3_ssdr_fara_gogo", "dx_cp_cpr3_slpw_fara_letsmove"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_pric_movein", "dx_cp_cpr3_ssdr_pric_movein", "dx_cp_cpr3_ssdr_pric_movemove", "dx_cp_cpr3_slpw_pric_move"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_sl2s_alex_doorsopen", "dx_cp_cpr3_ssdr_alex_letsmovego", "dx_cp_cpr3_ssdr_alex_movego", "dx_cp_cpr3_slpw_alex_keepitmoving"]);
  nags = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  scripts\engine\utility::flag_wait_either("sub_door_2_cut", "sub_door_1_cut");
  _id_DD76BE04377033FA(nags, (15240.9, 9395.56, 611), (14862.3, 9544.38, 505.108), 0);
  scripts\engine\utility::flag_wait("sub_door_3_cut");
  player = _id_F75BF134C689F3D0();
  aliases = ["dx_cp_cpr3_sl2s_fara_werethroughletsmove", "dx_cp_cpr3_sl2s_pric_doorsopenmove", "dx_cp_cpr3_sl2s_alex_entrysclearmove"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  _id_DD76BE04377033FA(nags, (14862.3, 9544.38, 505.108), (15343.4, 10043, 651.13), 5);
  scripts\engine\utility::flag_wait("sub_door_4_cut");
  aliases = ["dx_cp_cpr3_ssdr_fara_hewentfortheexit", "dx_cp_cpr3_ssdr_pric_hewentfortheexit", "dx_cp_cpr3_ssdr_alex_hewentfortheexit"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(level._id_E2958F412A7425C0.origin);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  _id_DD76BE04377033FA(nags, (15413.5, 9790.3, 390.689), (14845.2, 9475.79, 508.825), 0);
  wait 5;
  _id_F60CC7A230BC7FDC();
}

_id_DD76BE04377033FA(aliases, _id_12B397CBEAAB23B6, origin2, _id_6393850CED28F59E) {
  level endon("vo_endNagPlayersInside");
  thread _id_2FEAD0C576A2DD58(_id_12B397CBEAAB23B6, origin2);
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(8, 16, 4);
  center = (_id_12B397CBEAAB23B6 + origin2) / 2;
  players = sortbydistance(level.players, center);
  _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(_id_6393850CED28F59E);

  for(;;) {
    foreach(player in players) {
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
      _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    }
  }
}

_id_2FEAD0C576A2DD58(_id_12B397CBEAAB23B6, origin2) {
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A(_id_12B397CBEAAB23B6, origin2);
  level notify("vo_endNagPlayersInside", player);
}

_id_F60CC7A230BC7FDC() {
  level endon("endofscripting");
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_ssdr_fara_gettotheexit", "dx_cp_cpr3_ssdr_fara_hesgoingtowarnhadir", "dx_cp_cpr3_ssdr_fara_hewentfortheexit"], 1, 0);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_ssdr_pric_stackupatthedoor", "dx_cp_cpr3_ssdr_pric_hesgoingforhadir", "dx_cp_cpr3_ssdr_pric_hewentfortheexit"], 1, 0);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_ssdr_alex_stackupattheexit", "dx_cp_cpr3_ssdr_alex_hellleadustohadir", "dx_cp_cpr3_ssdr_alex_hewentfortheexit"], 1, 0);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(8, 16, 4);
  players = scripts\engine\utility::array_randomize(level.players);

  for(;;) {
    foreach(player in players) {
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
      _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    }
  }
}

_id_1044C8F0E0BA2ECC() {
  level endon("game_ended");
  _id_CFF2BEEEF9E68585 = _id_950160E93BCB78D3();
  _id_9C5E34D7183A4FDD();
  childthread _id_E2E44C86F8CBB305();
  _id_E99C5DD975B08027(_id_CFF2BEEEF9E68585);
}

_id_950160E93BCB78D3() {
  level endon("game_ended");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr3_srw1_aqld_brothersihavejustmet";
  aliases[aliases.size] = "dx_cp_cpr3_srw1_aqld_thewarheadiswithhim";
  aliases[aliases.size] = "dx_cp_cpr3_srw1_aqld_hewillleaveforthebor";
  aliases[aliases.size] = "dx_cp_cpr3_srw1_aqld_ourmissionisalmostco";
  aliases[aliases.size] = "dx_cp_cpr3_srw1_aqld_thedreamofsulamannow";
  _id_1DF9726C06DD6E66 = (14177, 8777, -2);
  _id_CB920E03144E9344 = 500;
  player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(_id_1DF9726C06DD6E66, _id_CB920E03144E9344)[0];
  player = _id_62E11D77B25C1D30::_id_B826409EE2EFF7B6(100, level.players);
  level endon("vo_strict_combat");

  foreach(alias in aliases) {
    _id_901084B424165BD5 = (15185, 9245.95, 433.282);
    playsoundatpos(_id_901084B424165BD5, alias);
    wait(randomfloatrange(2, 4));
  }

  aliases = ["dx_cp_cpr3_srw1_fara_aq", "dx_cp_cpr3_srw1_pric_aq", "dx_cp_cpr3_srw1_alex_aq"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_A9D9C0245997A414(5);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);
  _id_550202CE6AF8A223 = 0;
  wait 1.5;
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(8, [level.alex, level.farah]);

  if(_id_7D2852D02216C876 == level.farah)
    _id_550202CE6AF8A223 = _id_7D2852D02216C876 _id_5D265B4FCA61F070::_id_C47E471F9B42B010("dx_cp_cpr3_srw1_fara_hadirisupthere_01", 0.7, 3);
  else if(_id_7D2852D02216C876 == level.alex)
    _id_550202CE6AF8A223 = _id_7D2852D02216C876 _id_5D265B4FCA61F070::_id_C47E471F9B42B010("dx_cp_cpr3_srw1_alex_hestalkingabouthadir", 0.7, 3);

  wait 1;
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(8, [level.alex, level.farah]);

  if(_id_7D2852D02216C876 == level.farah)
    _id_7D2852D02216C876 _id_5D265B4FCA61F070::_id_C47E471F9B42B010("dx_cp_cpr3_srw1_fara_heswantstocrossthebo", 0.7, 3);
  else if(_id_7D2852D02216C876 == level.alex)
    _id_7D2852D02216C876 _id_5D265B4FCA61F070::_id_C47E471F9B42B010("dx_cp_cpr3_srw1_alex_somethingaboutthebor", 0.7, 3);

  _id_550202CE6AF8A223 = 1;
  return _id_550202CE6AF8A223;
}

_id_9C5E34D7183A4FDD() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("vo_strict_combat");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr3_srw1_aqld_enemiesarehere";
  aliases[aliases.size] = "dx_cp_cpr3_srw1_aqld_itsher";
  aliases[aliases.size] = "dx_cp_cpr3_srw1_aqld_sheshere";
  aliases[aliases.size] = "dx_cp_cpr3_srw1_aqld_theyrehere";
  _id_81A329728ABB79E4 = scripts\engine\utility::create_deck(aliases, 1, 1);
  _id_901084B424165BD5 = (15185, 9245.95, 433.282);
  wait 0.5;
  playsoundatpos(_id_901084B424165BD5, _id_81A329728ABB79E4 scripts\engine\utility::deck_draw());
  wait 1.2;
  playsoundatpos(_id_901084B424165BD5, "dx_cp_cpr3_srw1_aqld_getreinforcementsinh");

  for(;;) {
    if(isDefined(level._id_E2958F412A7425C0)) {
      break;
    }

    waitframe();
  }

  _id_62E11D77B25C1D30::_id_8935EE5F55A88C21(scripts\engine\utility::array_remove(getaiarray("axis"), level._id_E2958F412A7425C0));
  wait 2;
  aliases = ["dx_cp_cpr3_srw1_fara_clear", "dx_cp_cpr3_srw1_pric_wereclear", "dx_cp_cpr3_srw1_alex_clear"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_167FAE92423447B9();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3, 0.7);
}

_id_E99C5DD975B08027(_id_CFF2BEEEF9E68585) {
  level endon("game_ended");
  _id_9E727E6303456997 = ["dx_cp_cpr3_srw1_fara_hadirisupthere", "dx_cp_cpr3_srw1_pric_hadirwentuptop", "dx_cp_cpr3_srw1_alex_hadirsupthere"];
  _id_E4863DD57A47399F = ["dx_cp_cpr3_srw1_fara_hesclose", "dx_cp_cpr3_srw1_pric_hesclosenow", "dx_cp_cpr3_srw1_alex_weregettingclose"];
  _id_7A9949E5FBA485F7 = ["dx_cp_cpr3_srw1_fara_wehavetogetonthoseca", "dx_cp_cpr3_srw1_pric_weneedawaytothosecat", "dx_cp_cpr3_srw1_alex_gottagettothosecatwa"];
  _id_7D2852D02216C876 = undefined;

  if(!istrue(_id_CFF2BEEEF9E68585)) {
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_9E727E6303456997, 0.3, 1, 4);
    wait 0.6;

    if(isDefined(_id_7D2852D02216C876))
      _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3, scripts\engine\utility::array_add(scripts\engine\utility::array_remove(level.players, _id_7D2852D02216C876), _id_7D2852D02216C876));

    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_E4863DD57A47399F, 0.3, 1, 4);
  }

  if(isDefined(_id_7D2852D02216C876))
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(5, scripts\engine\utility::array_add(scripts\engine\utility::array_remove(level.players, _id_7D2852D02216C876), _id_7D2852D02216C876));
  else
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(5);

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_7A9949E5FBA485F7, 0.4, 1, 4);
  aliases = ["dx_cp_cpr3_srw1_fara_thenwefindawayuplets", "dx_cp_cpr3_srw1_pric_fanoutweneedawayupth", "dx_cp_cpr3_srw1_alex_letsspreadoutfindawa"];

  if(isDefined(_id_7D2852D02216C876))
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3, scripts\engine\utility::array_remove(level.players, _id_7D2852D02216C876));
  else
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3);

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.4, 1, 4);
  scripts\engine\utility::flag_set("vo_catwalks_said");
  childthread _id_208CE42F3CB8CD52();
}

_id_208CE42F3CB8CD52() {
  level endon("vo_primary_controls_found");
  wait 12;
  _id_9645644489542E70 = ["dx_cp_cpr3_srw1_fara_wehavetogettothecatw", "dx_cp_cpr3_srw1_pric_findawayupfastaqwill", "dx_cp_cpr3_srw1_alex_wegottagetuptherebef"];
  _id_7E9CCC2D6DDB44DA = ["dx_cp_cpr3_srw1_fara_affirmative", "dx_cp_cpr3_srw1_pric_afirm", "dx_cp_cpr3_srw1_alex_affirmative"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(4);
  _id_9880246D2987F2BF = _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_9645644489542E70, 0.4, 0.7, 4);
  wait 0.8;

  if(_id_9880246D2987F2BF) {
    if(isDefined(_id_7D2852D02216C876))
      _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3, scripts\engine\utility::array_remove(level.players, _id_7D2852D02216C876));
    else
      _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3);

    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_7E9CCC2D6DDB44DA, 0.5, 0.8, 2);
  }
}

_id_E2E44C86F8CBB305() {
  level._id_13734D6FDD9E7277 = 0;
  childthread _id_26AD8B3B242704A4();
  childthread _id_7BFD7D7339C4358D();
  childthread _id_A60652F7F8183C96();
  childthread _id_87BC6D9A502AA455();
  childthread _id_5938E1ECBB640AB0();
  childthread _id_D69532F0B53127AE();
}

_id_26AD8B3B242704A4() {
  level endon("vo_primary_controls_found");
  level endon("bay_flooded");
  found = ["dx_cp_cpr3_srw1_fara_theresaroombackhere", "dx_cp_cpr3_srw1_pric_gotaroomhere", "dx_cp_cpr3_srw1_alex_foundaroombackhere"];
  _id_84E632AD0647D2B4 = ["dx_cp_cpr3_srw1_fara_theresaroomhere", "dx_cp_cpr3_srw1_pric_gotaroomhere_01", "dx_cp_cpr3_srw1_alex_foundaroomhere"];
  _id_599044DBF42B2438 = ["dx_cp_cpr3_srw1_fara_foundanotherroom", "dx_cp_cpr3_srw1_pric_gotanotherroombackhe", "dx_cp_cpr3_srw1_alex_theresanotherroomher"];
  _id_114066A4BB132A01 = ["dx_cp_cpr3_srw1_fara_foundanotherroom_01", "dx_cp_cpr3_srw1_pric_gotanotherroom", "dx_cp_cpr3_srw1_alex_theresanotherroom"];
  _id_23BDCE6A80D4DB28 = (15043.1, 9397.28, 219);
  _id_23BDBC6A80D4B392 = (14831.8, 9403.12, 218.56);
  _id_3F3D52A1AF5BD648 = [_id_23BDCE6A80D4DB28, _id_23BDBC6A80D4B392];
  scripts\engine\utility::flag_wait_or_timeout("vo_catwalks_said", 60);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_3F3D52A1AF5BD648, 0.9, 0.1, 0, undefined, 250)[0];

  if(!level._id_13734D6FDD9E7277) {
    if(scripts\engine\utility::flag("vo_strict_combat"))
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_84E632AD0647D2B4);
    else
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, found);
  } else if(scripts\engine\utility::flag("vo_strict_combat"))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_114066A4BB132A01);
  else
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_599044DBF42B2438);

  level._id_13734D6FDD9E7277 = 1;
}

_id_7BFD7D7339C4358D() {
  level endon("vo_primary_controls_found");
  level endon("bay_flooded");
  found = ["dx_cp_cpr3_srw1_fara_theresaroombackhere", "dx_cp_cpr3_srw1_pric_gotaroomhere", "dx_cp_cpr3_srw1_alex_foundaroombackhere"];
  _id_84E632AD0647D2B4 = ["dx_cp_cpr3_srw1_fara_theresaroomhere", "dx_cp_cpr3_srw1_pric_gotaroomhere_01", "dx_cp_cpr3_srw1_alex_foundaroomhere"];
  _id_599044DBF42B2438 = ["dx_cp_cpr3_srw1_fara_foundanotherroom", "dx_cp_cpr3_srw1_pric_gotanotherroombackhe", "dx_cp_cpr3_srw1_alex_theresanotherroomher"];
  _id_114066A4BB132A01 = ["dx_cp_cpr3_srw1_fara_foundanotherroom_01", "dx_cp_cpr3_srw1_pric_gotanotherroom", "dx_cp_cpr3_srw1_alex_theresanotherroom"];
  origin = (14275.1, 9201.54, 219);
  scripts\engine\utility::flag_wait_or_timeout("vo_catwalks_said", 60);
  door = getEnt("dumpster_door", "targetname");

  while(!istrue(door._id_233D382A9996DE04)) {
    wait 0.05;
    continue;
  }

  player = _id_62E11D77B25C1D30::_id_43D8FA96ACF30CA8(origin, 2, level.players, 150);
  wait 0.5;

  if(!level._id_13734D6FDD9E7277) {
    if(scripts\engine\utility::flag("vo_strict_combat"))
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_84E632AD0647D2B4);
    else
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, found);
  } else if(scripts\engine\utility::flag("vo_strict_combat"))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_114066A4BB132A01);
  else
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_599044DBF42B2438);

  level._id_13734D6FDD9E7277 = 1;
}

_id_A60652F7F8183C96() {
  aliases = ["dx_cp_cpr3_srw1_fara_goodidea", "dx_cp_cpr3_srw1_pric_thatlldoit", "dx_cp_cpr3_srw1_alex_thatworks"];
  _id_C9A1D5414B9E3E7E = (14967, 9442, 319);
  _id_CB920E03144E9344 = 140;
  _id_2595212E3EA750A2 = undefined;

  for(;;) {
    _id_2595212E3EA750A2 = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B([_id_C9A1D5414B9E3E7E], _id_CB920E03144E9344)[0];

    if(_id_2595212E3EA750A2.origin[2] > 230) {
      break;
    }

    waitframe();
  }

  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_2595212E3EA750A2, 0.8, 0.05, 0, undefined, 350, undefined, 3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.4, 1, 2);
}

_id_5938E1ECBB640AB0() {
  level endon("bay_flooded");
  thread _id_2430F0B11241CD81();
  found = ["dx_cp_cpr3_srw1_fara_primarywatercontrols", "dx_cp_cpr3_srw1_pric_primarywatercontrols", "dx_cp_cpr3_srw1_alex_primarywatercontrols"];
  _id_84E632AD0647D2B4 = ["dx_cp_cpr3_srw1_fara_primarywatercontrols_01", "dx_cp_cpr3_srw1_pric_primarywatercontrols_01", "dx_cp_cpr3_srw1_alex_primarywatercontrols_01"];
  origin = (15036.1, 9512.36, 202.219);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(origin, 0.95, 0.1, 0, undefined, 100)[0];
  scripts\engine\utility::flag_set("vo_primary_controls_found");

  if(scripts\engine\utility::flag("vo_strict_combat"))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_84E632AD0647D2B4);
  else
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, found);

  wait 6;
  aliases = ["dx_cp_cpr3_srw1_fara_startingthiswilltake", "dx_cp_cpr3_srw1_pric_itlltakethewholelott", "dx_cp_cpr3_srw1_alex_gonnaneedallofustost"];
  _id_57EEAF820A2E5567 = (14835.2, 9497.65, 210.758);
  _id_97781A13B04E7370 = (15222.3, 9503.47, 210.758);

  if(scripts\common\utility::playersnear(origin, 300).size < level.players.size || !scripts\cp\utility::any_player_nearby(_id_57EEAF820A2E5567, 1225) || !scripts\cp\utility::any_player_nearby(_id_97781A13B04E7370, 1225)) {
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_43D8FA96ACF30CA8(origin, 3, level.players, 300);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.5, 1, 4);
  }
}

_id_2430F0B11241CD81() {
  found = ["dx_cp_cpr3_srw1_fara_pressurevalves", "dx_cp_cpr3_srw1_pric_pressurevalves", "dx_cp_cpr3_srw1_alex_pressurevalves"];
  _id_84E632AD0647D2B4 = ["dx_cp_cpr3_srw1_fara_pressurevalves_01", "dx_cp_cpr3_srw1_pric_pressurevalves_01", "dx_cp_cpr3_srw1_alex_pressurevalves_01"];
  _id_57EEAF820A2E5567 = (14835.2, 9497.65, 210.758);
  _id_97781A13B04E7370 = (15222.3, 9503.47, 210.758);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803([_id_57EEAF820A2E5567, _id_97781A13B04E7370], 0.95, 0.1, 0, undefined, 100)[0];

  if(scripts\engine\utility::flag("vo_strict_combat"))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_84E632AD0647D2B4);
  else
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, found);
}

_id_4D772D0A051D3185() {
  found = ["dx_cp_cpr3_srw1_fara_foundthecranecontrol", "dx_cp_cpr3_srw1_pric_foundthecranecontrol", "dx_cp_cpr3_srw1_alex_foundthecranecontrol"];
  _id_84E632AD0647D2B4 = ["dx_cp_cpr3_srw1_fara_foundthecranecontrol_01", "dx_cp_cpr3_srw1_pric_foundthecranecontrol_01", "dx_cp_cpr3_srw1_alex_foundthecranecontrol_01"];
  _id_FD9093591A89F399 = ["dx_cp_cpr3_srct_fara_wecanusethecrane", "dx_cp_cpr3_srct_pric_wecanusethecrane", "dx_cp_cpr3_srct_alex_wecanusethecrane"];
  origin = (15194.4, 8079.38, 456.202);
  scripts\engine\utility::flag_wait("p1_finished");
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(origin, 0.87, 0.05, 0, undefined, 150)[0];
  scripts\engine\utility::flag_set("crane_controls_found");

  if(scripts\engine\utility::flag("vo_catwalk_guys") && !scripts\engine\utility::flag("vo_found_override"))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_FD9093591A89F399, 0.6, 1, 3);
  else if(scripts\engine\utility::flag("vo_strict_combat"))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_84E632AD0647D2B4);
  else
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, found);

  thread _id_5C11AEA0DC1E2DA9(player);
}

_id_D69532F0B53127AE() {
  childthread _id_9AE807DE6C75CC8F();
  scripts\engine\utility::flag_wait("bay_flooded");
  aliases = ["dx_cp_cpr3_srw1_fara_okayitson", "dx_cp_cpr3_srw1_pric_itsactiveweregood", "dx_cp_cpr3_srw1_alex_itsupandrunning"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_A9D9C0245997A414(3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.4, 1, 4);
  aliases = ["dx_cp_cpr3_srw1_fara_thewatersrising", "dx_cp_cpr3_srw1_pric_watersrising", "dx_cp_cpr3_srw1_alex_watersrising"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(4, scripts\engine\utility::array_add(scripts\engine\utility::array_remove(level.players, _id_7D2852D02216C876), _id_7D2852D02216C876));
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.6, 1, 3);
}

_id_9AE807DE6C75CC8F() {
  level endon("bay_flooded");
  _id_8773B12FA4040B38 = ["dx_cp_cpr3_srw1_fara_notenoughpressure", "dx_cp_cpr3_srw1_pric_wrongpressure", "dx_cp_cpr3_srw1_alex_needspressure"];
  _id_47CC2A0FF5634701 = ["dx_cp_cpr3_srw1_fara_itneedspressure", "dx_cp_cpr3_srw1_pric_itneedspressure", "dx_cp_cpr3_srw1_alex_itneedspressure"];

  for(;;) {
    level waittill("vo_primary_pump_fail", player);
    aliases = undefined;

    if(scripts\engine\utility::flag("vo_strict_combat"))
      aliases = _id_47CC2A0FF5634701;
    else
      aliases = _id_8773B12FA4040B38;

    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3, 1, 0.7);
    wait 2;
  }
}

_id_F02CF73255EE1E0B() {
  level endon("p1_finished");
  _id_D795CF32E9E4F58B = ["dx_cp_cpr3_srw2_fara_itsnotworking", "dx_cp_cpr3_srw2_pric_weneedtoprimeit", "dx_cp_cpr3_srw2_alex_pumpneedstobeprimed"];
  _id_80C9FAE8A3BE14D8 = ["dx_cp_cpr3_srw2_fara_lookforpressurevalve", "dx_cp_cpr3_srw2_pric_findthepressurevalve", "dx_cp_cpr3_srw2_alex_lookforpressurevalve"];
  _id_9930D5FA0AB23B5C = 0;

  for(;;) {
    level waittill("vo_secondary_pump_fail", player);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_D795CF32E9E4F58B, 0.3, 1, 0.7);
    _id_57EEAF820A2E5567 = (15952, 9175.18, 261.848);
    _id_97781A13B04E7370 = (14253.6, 8619.49, 26.7221);

    if(!_id_9930D5FA0AB23B5C) {
      if(!scripts\cp\utility::any_player_nearby(_id_57EEAF820A2E5567, 40000) && !scripts\cp\utility::any_player_nearby(_id_97781A13B04E7370, 40000)) {
        _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(4, scripts\engine\utility::array_add(scripts\engine\utility::array_remove(level.players, player), player));
        _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_80C9FAE8A3BE14D8, 0.4, 0.7, 2);
        _id_9930D5FA0AB23B5C = 1;
      }
    }

    wait 2;
  }
}

_id_EB859C0F231E4CFF() {
  if(!scripts\engine\utility::flag("bay_flooded")) {
    return;
  }
  level endon("vo_stop_electricity");
  level._id_66D48B8D19719A40 = scripts\engine\utility::_id_53C4C53197386572(level._id_66D48B8D19719A40, 0);
  level._id_71BA92419F6E5C63 = scripts\engine\utility::_id_53C4C53197386572(level._id_71BA92419F6E5C63, 0);
  level._id_71BA92419F6E5C63 = level._id_71BA92419F6E5C63 + 1;
  wait 3;
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_srw1_fara_thealarm", "dx_cp_cpr3_srw1_fara_theresthealarm"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_srw1_pric_thealarm", "dx_cp_cpr3_srw1_pric_theresthealarm"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_srw1_alex_thatsoursignal", "dx_cp_cpr3_srw1_alex_itsthealarm"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];

  if(level._id_66D48B8D19719A40 > 1 && level._id_71BA92419F6E5C63 > 1) {
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(2);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0, 1, 2);
  }

  _id_BB378E7FD66473B8 = ["dx_cp_cpr3_srw1_fara_getoutofthewater", "dx_cp_cpr3_srw1_pric_outofthewater", "dx_cp_cpr3_srw1_alex_everyoneoutofthewate"];
  _id_F62235D0EDD0315B = ["dx_cp_cpr3_srw1_fara_stayoutofthewater", "dx_cp_cpr3_srw1_pric_keepoutofthewater", "dx_cp_cpr3_srw1_alex_getawayfromthewatern"];

  if(_id_E1403F8F55868EF9()) {
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3, _id_121D84580A922034());
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_BB378E7FD66473B8, 0, 1, 1);
  } else {
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3, _id_121D84580A922034());
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_F62235D0EDD0315B, 0, 1, 1);
  }
}

_id_A63241F100B7E1D0() {
  scripts\engine\utility::flag_set("vo_boss_gas");
  level endon("vo_boss_gas");
  level._id_66D48B8D19719A40 = scripts\engine\utility::_id_53C4C53197386572(level._id_66D48B8D19719A40, 0);
  level._id_71BA92419F6E5C63 = scripts\engine\utility::_id_53C4C53197386572(level._id_71BA92419F6E5C63, 0);
  level._id_66D48B8D19719A40 = level._id_66D48B8D19719A40 + 1;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr3_srw1_aqld_brothersuseyourgasma";
  aliases[aliases.size] = "dx_cp_cpr3_srw1_aqld_gasmasks";
  aliases[aliases.size] = "dx_cp_cpr3_srw1_aqld_putyourgasmasksonnow";
  wait 2;

  if(!isDefined(level._id_9F84B150F88541DA))
    level._id_9F84B150F88541DA = scripts\engine\utility::create_deck(aliases, 1, 1);

  _id_901084B424165BD5 = (15185, 9245.95, 433.282);
  playsoundatpos(_id_901084B424165BD5, level._id_9F84B150F88541DA scripts\engine\utility::deck_draw());
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_srw1_fara_thealarm", "dx_cp_cpr3_srw1_fara_theresthealarm"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_srw1_pric_thealarm", "dx_cp_cpr3_srw1_pric_theresthealarm"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_srw1_alex_thatsoursignal", "dx_cp_cpr3_srw1_alex_itsthealarm"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  wait 1;

  if(level._id_66D48B8D19719A40 > 1 && level._id_71BA92419F6E5C63 > 1) {
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(2);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0, 1, 2);
  }

  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_srw1_fara_gasincoming", "dx_cp_cpr3_srw1_fara_theyreusinggas", "dx_cp_cpr3_srw1_fara_gasisinhere"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_srw1_pric_gasgas", "dx_cp_cpr3_srw1_pric_gasincoming", "dx_cp_cpr3_srw1_pric_theyreusinggas"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_srw1_alex_theresgasincoming", "dx_cp_cpr3_srw1_alex_gasisventingin", "dx_cp_cpr3_srw1_alex_gasispushingin"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  wait 3;
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(2);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0, 1, 2);
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr3_srw1_fara_getunderwater", "dx_cp_cpr3_srw1_fara_getunderthewater", "dx_cp_cpr3_srw1_fara_gounderwater"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr3_srw1_pric_getunderwater", "dx_cp_cpr3_srw1_pric_underwaternow", "dx_cp_cpr3_srw1_pric_usethewater"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr3_srw1_alex_diveunderwater", "dx_cp_cpr3_srw1_alex_divedown", "dx_cp_cpr3_srw1_alex_usethewaterforcover"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];

  if(_id_121D84580A922034().size > 0) {
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(2);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.5, 1, 2);
  }
}

_id_87BC6D9A502AA455() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr3_srw1_aqld_theenemyistrappedsho";
  aliases[aliases.size] = "dx_cp_cpr3_srw1_aqld_protecthadirkillthes";
  aliases[aliases.size] = "dx_cp_cpr3_srw1_aqld_attackthembrothers";
  aliases[aliases.size] = "dx_cp_cpr3_srw1_aqld_donotletthemstopyoud";
  _id_4940C2124A859060 = scripts\engine\utility::create_deck(aliases);

  for(;;) {
    if(scripts\engine\utility::flag("bay_flooded")) {
      break;
    }

    level waittill("boss1_ai_group_spawned", _id_F564CE57BB79FF69);
    _id_901084B424165BD5 = (15185, 9245.95, 433.282);
    playsoundatpos(_id_901084B424165BD5, _id_4940C2124A859060 scripts\engine\utility::deck_draw());
    wait 4;
  }

  scripts\engine\utility::flag_wait("bay_flooded");
  _id_C837F781CC027344 = ["dx_cp_cpr3_srw1_aqld_karim", "dx_cp_cpr3_srw1_aqld_youshouldhavelistene", "dx_cp_cpr3_srw1_aqld_youshouldhaveturnedb"];
  level waittill("boss1_ai_group_spawned", _id_F564CE57BB79FF69);

  foreach(alias in _id_C837F781CC027344) {
    _id_901084B424165BD5 = (15185, 9245.95, 433.282);
    playsoundatpos(_id_901084B424165BD5, alias);
    wait(randomfloatrange(2.5, 4.5));
  }

  aliases = ["dx_cp_cpr3_srw1_fara_thatsoneofhadirslieu", "dx_cp_cpr3_srw1_pric_soundslikehadirsrigh", "dx_cp_cpr3_srw1_alex_mustbehadirsrighthan"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.4, 1, 4);
  aliases = ["dx_cp_cpr3_srw1_fara_hecanleadustohim", "dx_cp_cpr3_srw1_pric_thenhecanleadustohim", "dx_cp_cpr3_srw1_alex_thenhecanleadustohim"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(4, scripts\engine\utility::array_add(scripts\engine\utility::array_remove(level.players, _id_7D2852D02216C876), _id_7D2852D02216C876));
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.5, 1, 5);
}

_id_AD12C8DF3C0A55B1() {
  scripts\engine\utility::flag_wait("bay_flooded");
  childthread _id_F02CF73255EE1E0B();
  childthread _id_D72105F3D2AFA802();
  wait 5;
  aliases = ["dx_cp_cpr3_srw2_fara_thewaterstopped", "dx_cp_cpr3_srw2_pric_thewaterstopped", "dx_cp_cpr3_srw2_alex_thewaterstopped"];
  player = _id_62E11D77B25C1D30::_id_A9D9C0245997A414(3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5, 0.5, 2);
  childthread _id_B830FA4B1CF20BA1();
}

_id_B830FA4B1CF20BA1() {
  level endon("vo_found_secondary_controls");
  wait 3;
  _id_9A404B9FEC86A048 = ["dx_cp_cpr3_srw2_fara_weneedanothersetofco", "dx_cp_cpr3_srw2_pric_findthesecondarycont", "dx_cp_cpr3_srw2_alex_lookforsecondarycont"];

  foreach(player in level.players) {
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_9A404B9FEC86A048, 0.4, 0.8, 3);
    wait(randomintrange(9, 14));
  }
}

_id_D72105F3D2AFA802() {
  level endon("game_ended");
  origin = (15131.4, 8067.41, 456.303);
  _id_E8BE191E84DFAE35 = ["dx_cp_cpr3_srw2_fara_imatthewatercontrols", "dx_cp_cpr3_srw2_pric_watercontrolsarehere", "dx_cp_cpr3_srw2_alex_atthewatercontrols"];
  _id_581E3ADBA8CF2801 = ["dx_cp_cpr3_srw1_fara_secondarywatercontro", "dx_cp_cpr3_srw1_pric_secondarywatercontro", "dx_cp_cpr3_srw1_alex_secondarywatercontro"];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(origin, 0.85, 0.1, 0, undefined, 200)[0];
  scripts\engine\utility::flag_set("vo_found_secondary_controls");

  if(scripts\engine\utility::flag("vo_strict_combat"))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_E8BE191E84DFAE35, 0.3, 1, 2);
  else
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_581E3ADBA8CF2801, 0.3, 1, 2);

  childthread _id_58DB9CD8E8028E7D();
}

_id_58DB9CD8E8028E7D() {
  level endon("p1_finished");
  wait 6;
  aliases = ["dx_cp_cpr3_srw2_fara_thevalveshavetobeclo", "dx_cp_cpr3_srw2_pric_weneedtofindthoseval", "dx_cp_cpr3_srw2_alex_locatethosevalveswer"];
  _id_F59E08843E6E0526 = (15131.4, 8067.41, 456.303);
  _id_57EEAF820A2E5567 = (15952, 9175.18, 261.848);
  _id_97781A13B04E7370 = (14253.6, 8619.49, 26.7221);

  if(!scripts\cp\utility::any_player_nearby(_id_57EEAF820A2E5567, 40000) && !scripts\cp\utility::any_player_nearby(_id_97781A13B04E7370, 40000)) {
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_43D8FA96ACF30CA8(_id_F59E08843E6E0526, 3);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.5, 0.6, 3);
  }
}

_id_E2D827F9A2573B4B() {
  scripts\engine\utility::flag_wait("p1_finished");
  childthread _id_CB1D3965E2CDD217();
  childthread _id_4D772D0A051D3185();
  childthread _id_96C9946DB27D7DB2();
  scripts\engine\utility::flag_wait_any("manualoverride", "vo_water_raise_final_done");
  aliases = ["dx_cp_cpr3_srct_fara_aqsonthecatwalks", "dx_cp_cpr3_srct_pric_aqonthecatwalks", "dx_cp_cpr3_srct_alex_checkhighaqsonthecat"];
  _id_30D8012FAFA2C40E();
  wait 2;
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(getaiarray("axis"), 0.8, 0.1, 0)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.4, 1);
  aliases = ["dx_cp_cpr3_srct_fara_weneedtogetupthere", "dx_cp_cpr3_srct_pric_aqhasthehighgroundwe", "dx_cp_cpr3_srct_alex_weneedtogetupthere"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(4, scripts\engine\utility::array_add(scripts\engine\utility::array_remove(level.players, _id_7D2852D02216C876), _id_7D2852D02216C876));
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.6, 1);
  scripts\engine\utility::flag_set("vo_catwalk_guys");
  childthread _id_E9594C7FA0438187();
  childthread _id_23933E62676981B1();
  scripts\engine\utility::flag_wait("p2_finished");
}

_id_96C9946DB27D7DB2() {
  level endon("started_using_crane_controls");
  level waittill("vo_water_raise_done");
  aliases = ["dx_cp_cpr3_srct_fara_thecontrolsaredown", "dx_cp_cpr3_srct_pric_secondarycontrolsare", "dx_cp_cpr3_srct_alex_secondarycontrolsshu"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(4);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.5, 1);
  scripts\engine\utility::flag_set("vo_water_raise_final_done");
}

_id_5C11AEA0DC1E2DA9(_id_09534B1DBE14144F) {
  wait 3;
  aliases = ["dx_cp_cpr3_srct_fara_wellhavetooverrideth", "dx_cp_cpr3_srct_pric_wehavetooverridethec", "dx_cp_cpr3_srct_alex_wellhavetooverrideth"];

  if(isDefined(_id_09534B1DBE14144F))
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(4, scripts\engine\utility::array_add(scripts\engine\utility::array_remove(level.players, _id_09534B1DBE14144F), _id_09534B1DBE14144F));
  else
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(4);

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.5, 1);
}

_id_CB1D3965E2CDD217() {
  level notify("kill_crane_override");
  level endon("kill_crane_override");
  _id_212E00D104339026 = ["dx_cp_cpr3_srct_fara_wecanusethecrane", "dx_cp_cpr3_srct_pric_wecanusethecrane", "dx_cp_cpr3_srct_alex_wecanusethecrane"];
  aliases = ["dx_cp_cpr3_srct_fara_ifoundtheoverride", "dx_cp_cpr3_srct_pric_foundtheoverride", "dx_cp_cpr3_srct_alex_foundtheoverride"];
  origin = (14100.2, 8759.31, 323.234);
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(origin, 0.95, 0.1, 0, undefined, 80)[0];

  if(!scripts\engine\utility::flag("crane_controls_found"))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_212E00D104339026, 0.4, 1);

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.4, 1);
  scripts\engine\utility::flag_set("vo_found_override");
  scripts\engine\utility::flag_wait("manualoverride");
  playsoundatpos(origin, "dx_cp_cpr3_srct_rupa_craneoverrideinitiat");
}

_id_E9594C7FA0438187() {
  level endon("started_using_crane_controls");
  wait 6;

  if(scripts\engine\utility::flag("vo_boss_gas"))
    scripts\engine\utility::flag_waitopen_or_timeout("vo_boss_gas", 25);

  aliases = ["dx_cp_cpr3_srct_fara_usethecontrols", "dx_cp_cpr3_srct_pric_usethecranecontrols", "dx_cp_cpr3_srct_alex_getonthecranecontrol"];
  origin = (15194.4, 8079.38, 456.202);
  players = scripts\engine\utility::array_reverse(sortbydistance(level.players, origin));
  level endon("started_using_crane_controls");
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3, players);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.6, 0.7);
}

_id_23933E62676981B1() {
  level waittill("started_using_crane_controls", _id_CE6AFC86CE65F95E);
  _id_F6DE9BCE72BA9008 = getEntArray("crane_arm_right", "targetname");
  _id_505F5ADC4322FF3C = _id_F6DE9BCE72BA9008[1];
  _id_8A1D623EAAFD58BE = undefined;

  if(isDefined(_id_505F5ADC4322FF3C)) {
    for(;;) {
      player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_505F5ADC4322FF3C.origin, level.players);

      if(!isDefined(player)) {
        waitframe();
        continue;
      }

      if(distance2d(player.origin, _id_505F5ADC4322FF3C.origin) < 265) {
        player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_505F5ADC4322FF3C.origin, level.players);

        if(player.origin[2] > 450) {
          _id_8A1D623EAAFD58BE = player;
          break;
        }
      }

      waitframe();
    }
  }

  aliases = ["dx_cp_cpr3_srct_fara_thecatwalkstoofar", "dx_cp_cpr3_srct_pric_cantreachthecatwalk", "dx_cp_cpr3_srct_alex_catwalkstoohigh"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_8A1D623EAAFD58BE, aliases, 0.6, 1);
  childthread _id_AF01E03186274EC2();
  childthread _id_BF4298050792B51E();
  childthread _id_7D1F3B358DC91E2B();
}

_id_AF01E03186274EC2() {
  level endon("explosivespickedup");
  wait 15;
  aliases = ["dx_cp_cpr3_srct_fara_weneedtogetupthere_01", "dx_cp_cpr3_srct_pric_westaydownherewerede", "dx_cp_cpr3_srct_alex_weneedawayupthere"];
  origin = (14028.2, 8432.59, 466.305);

  if(!scripts\cp\utility::any_player_nearby(origin, 330)) {
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_43D8FA96ACF30CA8(origin, 3);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.5, 0.7);
  }
}

_id_BF4298050792B51E() {
  aliases = ["dx_cp_cpr3_srct_fara_ifoundcharges", "dx_cp_cpr3_srct_pric_chargeshere", "dx_cp_cpr3_srct_alex_chargeshere"];
  level waittill("vo_explosives_grabbed", player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4, 1);
}

_id_7D1F3B358DC91E2B() {
  aliases = ["dx_cp_cpr3_srct_fara_wecanusechargesonthe", "dx_cp_cpr3_srct_pric_wecansetchargesonthe", "dx_cp_cpr3_srct_alex_wecansetchargesonthe"];
  _id_6CC0253AF33C6322 = scripts\engine\utility::getStructArray("plant_hint", "targetname");
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_6CC0253AF33C6322, 0.87, 0.05, 0, undefined, 330)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5, 1);
  _id_4B081C2A81CE890E = ["dx_cp_cpr3_srct_fara_chargeplanted", "dx_cp_cpr3_srct_pric_chargeset", "dx_cp_cpr3_srct_alex_chargeisset"];
  level waittill("charge_planted", _id_7D2852D02216C876);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_4B081C2A81CE890E, 0.5, 1, 2);
  childthread _id_55A00E4C53B97495();
  _id_E309C950B0AD4CBF = ["dx_cp_cpr3_srct_fara_chargesplantedfivese", "dx_cp_cpr3_srct_pric_chargeshotfivesecond", "dx_cp_cpr3_srct_alex_goingexplosivefivese"];
  level waittill("charge_planted", _id_7D2852D02216C876);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_E309C950B0AD4CBF, 0.5, 1, 2);
  level waittill("catwalk_explode");
  aliases = ["dx_cp_cpr3_srct_fara_getonthecatwalkgo", "dx_cp_cpr3_srct_pric_catwalksopenletsmove", "dx_cp_cpr3_srct_alex_wereinbusinessheadup"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3, scripts\engine\utility::array_add(scripts\engine\utility::array_remove(level.players, _id_7D2852D02216C876), _id_7D2852D02216C876));
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.5, 1, 2);
  _id_901084B424165BD5 = (15185, 9245.95, 433.282);
  _id_62E11D77B25C1D30::_id_B826409EE2EFF7B6(552);
  playsoundatpos(_id_901084B424165BD5, "dx_cp_cpr3_srct_aqld_theyareonthecatwalks");
  wait 3;
  playsoundatpos(_id_901084B424165BD5, "dx_cp_cpr3_srct_aqld_fightthemback");
  wait 4;

  if(isDefined(level.farah))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr3_srct_fara_theyknowwereuphere", 0.3);
  else if(isDefined(level.alex))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr3_srct_alex_theyknowwereuphere", 0.3);
}

_id_55A00E4C53B97495() {
  level endon("charge_planted");
  level endon("catwalk_explode");
  _id_6CC0253AF33C6322 = scripts\engine\utility::getStructArray("plant_hint", "targetname");
  aliases = ["dx_cp_cpr3_srct_fara_othersideplantthecha", "dx_cp_cpr3_srct_pric_setachargeotherside", "dx_cp_cpr3_srct_alex_settheotherchargenow"];
  wait 2;
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_D63542EBC6F90151(_id_6CC0253AF33C6322[0].origin);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.5, 0.7);
}

_id_30D8012FAFA2C40E() {
  _id_D581EB31281EB774 = ["top_closet_N", "top_NE", "top_closet_SE", "top_closet_W", "top_NW"];

  for(;;) {
    level waittill("boss1_ai_group_spawned", _id_F564CE57BB79FF69);

    if(scripts\engine\utility::array_contains(_id_D581EB31281EB774, _id_F564CE57BB79FF69) && !scripts\engine\utility::flag("vo_boss_gas")) {
      break;
    }

    waitframe();
  }
}

_id_E1403F8F55868EF9(players) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, level.players);

  foreach(player in players) {
    if(player _meth_E40102956C887F7C())
      return 1;
  }

  return 0;
}

_id_0E1B07F20CB59E60() {
  players = [];

  foreach(player in level.players) {
    if(player _meth_E40102956C887F7C())
      players[players.size] = player;
  }

  return players;
}

_id_121D84580A922034() {
  players = [];

  foreach(player in level.players) {
    if(player _meth_E40102956C887F7C() == 0)
      players[players.size] = player;
  }

  return players;
}