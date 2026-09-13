/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_669c0f6cb0b7f0cd.gsc
***********************************************/

_id_97F8AA617741E7FF() {
  _id_A1B2242F89FE2B18();
  thread _id_08B872ED34FE5921();
  scripts\cp\utility::battlechatter_off();
  childthread _id_56DC0467B6A67C72();
  _id_5A4194BE2A98FB2B = getaiarrayinradius((7605.08, 14659, 1563.35), 500);
  player = _id_71FC89B3E8140B4B(_id_5A4194BE2A98FB2B, 3000)[0];
  childthread _id_06E01F2DA21D7FF3(_id_5A4194BE2A98FB2B);
  _id_066D7491B9CD9AED();
  scripts\cp\utility::battlechatter_on();
  childthread _id_7F447B719B4B73CE(_id_5A4194BE2A98FB2B);
  thread _id_100B957B4DACE0E0();
  thread _id_71C102FAF0201ED8();
  _id_3B46C8D1F1AE39D3(0, 3100);
}

_id_5175593A7A2CCDB5() {
  scripts\engine\utility::flag_init("vo_combat");

  for(;;) {
    scripts\engine\utility::flag_clear("vo_combat");
    _id_7C50C629B4D4086A(1);

    while(!_id_73709F2B96C09080(undefined, 1, 5))
      waitframe();

    scripts\engine\utility::flag_set("vo_combat");
    _id_7C50C629B4D4086A(0);

    while(_id_73709F2B96C09080(undefined, 1, 5))
      waitframe();
  }
}

_id_FC711A4308F52F72() {
  scripts\engine\utility::flag_init("vo_strict_combat");

  for(;;) {
    scripts\engine\utility::flag_clear("vo_strict_combat");

    while(!_id_73709F2B96C09080(undefined, 0))
      waitframe();

    scripts\engine\utility::flag_set("vo_strict_combat");

    while(_id_73709F2B96C09080(undefined, 0))
      waitframe();
  }
}

_id_A1B2242F89FE2B18() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vo", "onPing", _id_166B4F052DA169A7::_id_929BB46251E5E4F2);
  wait 3;
  thread _id_D638372E26728053();
  _id_3B46C8D1F1AE39D3(0, 9220);
  scripts\engine\utility::flag_set("players_exit_first_room");
}

_id_D638372E26728053() {
  level endon("players_exit_first_room");
  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");
  _id_A606867D80CFABD5(level._id_E0632103DFA5BB19, "dx_cp_cpr1_intr_gazz_clear");
  _id_A606867D80CFABD5(level.price, "dx_cp_cpr1_intr_pric_stayquiet", 0.3);
  _id_A606867D80CFABD5(level.price, "dx_cp_cpr1_intr_pric_letsfindoutwhatthehe", 0.2);
  aliases = [undefined, "dx_cp_cpr1_intr_fara_orwho", "dx_cp_cpr1_intr_gazz_orwho"];
  player = _id_AA8653DEA5520361(0.5, [level.farah, level._id_E0632103DFA5BB19]);
  _id_A606867D80CFABD5(player, aliases, 0.4);
  aliases = [];
  aliases[aliases.size] = [level.price, "dx_cp_cpr1_intr_pric_takethedoors"];
  aliases[aliases.size] = [level.farah, "dx_cp_cpr1_intr_fara_soletsmove"];
  aliases[aliases.size] = [level._id_E0632103DFA5BB19, "dx_cp_cpr1_intr_gazz_wemovingornot"];
  nags = scripts\engine\utility::create_deck(aliases, 1, 1);
  level thread _id_5D265B4FCA61F070::nag_wait("players_exit_first_room", nags, _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(5, 30, 3));
}

_id_08B872ED34FE5921() {
  scripts\engine\utility::flag_wait("sounded_alarm");
  aliases = ["dx_cp_cpr1_intr_pric_fuckinhell", "dx_cp_cpr1_intr_fara_damnit", "dx_cp_cpr1_intr_gazz_shit"];
  player = _id_A9D9C0245997A414(1);
  _id_A606867D80CFABD5(player, aliases, 0.2);

  if(isDefined(player))
    player = _id_A9D9C0245997A414(1, scripts\engine\utility::array_remove(level.players, player));
  else
    player = _id_A9D9C0245997A414(1, level.players);

  _id_A606867D80CFABD5(player, aliases, 0.2);
  aliases = ["dx_cp_cpr1_intr_pric_incoming", "dx_cp_cpr1_intr_fara_theyresendingreinfor", "dx_cp_cpr1_intr_gazz_wevegotincoming"];
  player = _id_A9D9C0245997A414(2);
  _id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_56DC0467B6A67C72() {
  while(level.players.size < 3)
    waitframe();

  aliases = ["dx_cp_cpr1_intr_pric_usethewaterforcover", "dx_cp_cpr1_intr_fara_thewatercanhideus", "dx_cp_cpr1_intr_gazz_wecanusethewaterforc"];

  for(result = 0; !istrue(result); result = _id_A606867D80CFABD5(player, aliases, 0.3, 0, 1)) {
    _id_8F1F8D6A4A094898 = [];

    while(_id_8F1F8D6A4A094898.size == 0 || _id_8F1F8D6A4A094898.size == level.players.size || scripts\engine\utility::flag("vo_combat") || istrue(level._id_9F84E4E1C0C2A033)) {
      _id_8F1F8D6A4A094898 = [];

      foreach(player in level.players) {
        if(player _meth_E40102956C887F7C() && !player _meth_6F55D55CCFF20D14())
          _id_8F1F8D6A4A094898[_id_8F1F8D6A4A094898.size] = player;
      }

      waitframe();
    }

    player = scripts\engine\utility::random(_id_8F1F8D6A4A094898);
  }
}

_id_06E01F2DA21D7FF3(enemies) {
  foreach(enemy in enemies)
  enemy endon("stealth_combat");

  enemies[1] _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0, "dx_cp_cpr1_intr_aqs2_anysignofhowtheygoti");
  enemies[0] _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.3, "dx_cp_cpr1_intr_aqs1_nothingyetyou");
  enemies[1] _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.2, "dx_cp_cpr1_intr_aqs2_nothingwesealedthesi");
  enemies[0] _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.3, "dx_cp_cpr1_intr_aqs1_weregoingtofinishwit");
  enemies[1] _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.4, "dx_cp_cpr1_intr_aqs2_okaybrother");
}

_id_066D7491B9CD9AED() {
  wait 0.7;

  if(scripts\engine\utility::flag("vo_combat")) {
    return;
  }
  childthread _id_C51AB16BE84F5675();
  _id_BE1FF2030AD6BA18 = [level._id_E0632103DFA5BB19, 1.3, "dx_cp_cpr1_intr_gazz_voicesupahead", level.price, 1.4, "dx_cp_cpr1_intr_pric_arabic", level.farah, 3, "dx_cp_cpr1_intr_fara_alqatala", level.farah, 1.2, "dx_cp_cpr1_intr_fara_theyreplantingtraps"];
  level _id_5D265B4FCA61F070::_id_B0C2A659A5C2761F([level, "sounded_alarm", level, "stealth_combat"], _id_BE1FF2030AD6BA18);
}

_id_7F447B719B4B73CE(_id_5A4194BE2A98FB2B) {
  thread _id_F9EC117E695C4634(_id_5A4194BE2A98FB2B);

  if(scripts\engine\utility::flag("vo_combat")) {
    return;
  }
  foreach(enemy in _id_5A4194BE2A98FB2B)
  enemy endon("stealth_combat");

  aliases = ["dx_cp_cpr1_intr_pric_threeaqhere", "dx_cp_cpr1_intr_fara_threeaqonthewalkway", "dx_cp_cpr1_intr_gazz_gotavisualthreeaq"];
  player = _id_5BC7A5C4437D3803(_id_5A4194BE2A98FB2B, 0.9995, 0.1, 0)[0];
  _id_A606867D80CFABD5(player, aliases, 0.3, 0, 1);
  level scripts\engine\utility::delaythread(0.4, ::_id_C4C5FC733F796FCE, _id_5A4194BE2A98FB2B);
  level endon("vo_more_enemies_timeout");
  _id_CA71F76D55C9E987 = scripts\engine\utility::array_remove_array(getaiarray(), _id_5A4194BE2A98FB2B);
  aliases = ["dx_cp_cpr1_intr_pric_morethanthat", "dx_cp_cpr1_intr_fara_morebehindthem", "dx_cp_cpr1_intr_gazz_placeiscrawling"];
  result = 0;

  while(!istrue(result)) {
    player = _id_5BC7A5C4437D3803(_id_CA71F76D55C9E987, 0.9995, 0.3, 1, player)[0];
    result = _id_A606867D80CFABD5(player, aliases, 0.2, 0, 1);
    waitframe();
  }
}

_id_0127760A23DFB596(reviver) {
  if(isDefined(level._id_E1C77D5ECC0CCA5A) && !scripts\engine\utility::time_has_passed(level._id_E1C77D5ECC0CCA5A, 10)) {
    return;
  }
  if(istrue(level._id_9F84E4E1C0C2A033)) {
    return;
  }
  level._id_E1C77D5ECC0CCA5A = gettime();
  aliases = ["dx_cp_cpr1_intr_pric_ctnr", "dx_cp_cpr1_intr_fara_ctnr", "dx_cp_cpr1_intr_gazz_ctnr"];
  _id_A606867D80CFABD5(reviver, aliases, 0.3, 0, 1);
}

_id_C4C5FC733F796FCE(_id_5A4194BE2A98FB2B) {
  if(scripts\engine\utility::flag("vo_combat")) {
    return;
  }
  foreach(enemy in _id_5A4194BE2A98FB2B)
  enemy endon("stealth_combat");

  level notify("vo_more_enemies_timeout");
  aliases = ["dx_cp_cpr1_intr_pric_chooseatargetweneedt", "dx_cp_cpr1_intr_fara_weeachtakeoneengagea", "dx_cp_cpr1_intr_gazz_pickyourtargetwelldr"];
  player = _id_A9D9C0245997A414(3);
  _id_A606867D80CFABD5(player, aliases, 0.2, 0, 1);
  aliases = [];
  aliases[aliases.size] = ["dx_cp_cpr1_intr_pric_ready", "dx_cp_cpr1_intr_pric_gotthisone"];
  aliases[aliases.size] = ["dx_cp_cpr1_intr_fara_imready", "dx_cp_cpr1_intr_fara_illtakethisone"];
  aliases[aliases.size] = ["dx_cp_cpr1_intr_gazz_goodere", "dx_cp_cpr1_intr_gazz_thisonesmine"];
  _id_042A7CD0B06E308F = scripts\engine\utility::create_deck([1, 1, 0]);
  previous = undefined;

  for(;;) {
    player = _id_A0580E9BD081384B(_id_5A4194BE2A98FB2B)[0];

    if(scripts\engine\utility::is_equal(player, previous)) {
      continue;
    }
    _id_A37D38AB220A18E8 = _id_C810DB5F583495B1(player, aliases);
    _id_A606867D80CFABD5(player, _id_A37D38AB220A18E8[_id_042A7CD0B06E308F scripts\engine\utility::deck_draw()], 0.1, 0, 0.6);
    previous = player;
  }
}

_id_9C5067157CF34297(player, aliases) {
  if(scripts\engine\utility::flag("sounded_alarm") || scripts\engine\utility::flag("vo_combat")) {
    return;
  }
  level endon("vo_combat");
  level endon("sounded_alarm");
  level endon("vo_question_convo");
  players = level.players;

  if(isDefined(player))
    players = scripts\engine\utility::array_remove(players, player);

  while(players.size > 0) {
    player = players[0];

    if(istrue(player _id_6BC561D9F8020303())) {
      wait 2;
      _id_A606867D80CFABD5(player, aliases, 0.2);
    }

    if(isDefined(player))
      players = scripts\engine\utility::array_remove(players, player);
  }
}

_id_6A5D3F2DA685613B(point, angles, dist, _id_756916B2AF9EBB9C) {
  if(isDefined(_id_756916B2AF9EBB9C)) {
    if(scripts\engine\utility::flag(_id_756916B2AF9EBB9C)) {
      return;
    }
    level endon(_id_756916B2AF9EBB9C);
  }

  dist = scripts\engine\utility::_id_53C4C53197386572(dist, 1000);
  distsq = squared(dist);
  player = _id_45831CF64D17BBB1(point, angles);
  forward = anglesToForward(angles);
  _id_CEB1FF9428033CFD = scripts\engine\utility::array_remove(level.players, player);
  _id_BEE1CB9FA4B83F51 = [];

  foreach(_id_6EE5484560EC747C in _id_CEB1FF9428033CFD) {
    if(vectordot(_id_6EE5484560EC747C.origin - point, forward) < 0 && distancesquared(player.origin, _id_6EE5484560EC747C.origin) > distsq)
      _id_BEE1CB9FA4B83F51[_id_BEE1CB9FA4B83F51.size] = _id_6EE5484560EC747C;
  }

  if(_id_BEE1CB9FA4B83F51.size == 0) {
    return;
  }
  if(!isDefined(level._id_1F772B45196B1B7C)) {
    _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_pric_gazfarahrallyonme", "dx_cp_cpr1_intr_pric_needyoutwouphere", "dx_cp_cpr1_intr_pric_bothofyoumoveup"]);
    _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_fara_pricesergeantdontfal", "dx_cp_cpr1_intr_fara_okayboysletsmove", "dx_cp_cpr1_intr_fara_keepmovingyoutwo"]);
    _id_3E2004F5DFEF859B = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_gazz_farahcapnimmoving", "dx_cp_cpr1_intr_gazz_holdinforyoulot", "dx_cp_cpr1_intr_gazz_oiyoutwoletsmoveyeah"]);
    level._id_BE2A7FBF44E05483 = [_id_6DFEEEBD5989A352, _id_EC44C06676021F69, _id_3E2004F5DFEF859B];
    _id_C9A17BCFBDFCE146 = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_fara_keepupoldman", "dx_cp_cpr1_intr_fara_dontgetseparatedcapt", "dx_cp_cpr1_intr_fara_priceletsmove"]);
    _id_EF408D79AB3332F0 = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_gazz_captainwerepushingup", "dx_cp_cpr1_intr_gazz_weremovingcapn", "dx_cp_cpr1_intr_gazz_capnweregettingsplit"]);
    level._id_0740A7BAF2992D8E = [undefined, _id_C9A17BCFBDFCE146, _id_EF408D79AB3332F0];
    _id_AC883563535E1D5D = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_pric_farahweremoving", "dx_cp_cpr1_intr_pric_needyouupherefarah", "dx_cp_cpr1_intr_pric_staywithusfarah"]);
    _id_EF408D79AB3332F0 = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_gazz_farahmeandthecapnare", "dx_cp_cpr1_intr_gazz_commanderwerepushing", "dx_cp_cpr1_intr_gazz_weremovingupfarah"]);
    level._id_03C212E6ECB2B841 = [_id_AC883563535E1D5D, undefined, _id_EF408D79AB3332F0];
    _id_AC883563535E1D5D = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_pric_gazrallyup", "dx_cp_cpr1_intr_pric_dontfallbehindsergea", "dx_cp_cpr1_intr_pric_needyouwithusgaz"]);
    _id_C9A17BCFBDFCE146 = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_fara_sergeantweremovingup", "dx_cp_cpr1_intr_fara_gazwithus", "dx_cp_cpr1_intr_fara_gazwhereareyou"]);
    level._id_CAD9A91072752BF7 = [_id_AC883563535E1D5D, _id_C9A17BCFBDFCE146];
  }

  aliases = level._id_BE2A7FBF44E05483;

  if(_id_BEE1CB9FA4B83F51.size == 1) {
    if(scripts\engine\utility::is_equal(_id_BEE1CB9FA4B83F51[0], level.price))
      aliases = level._id_0740A7BAF2992D8E;
    else if(scripts\engine\utility::is_equal(_id_BEE1CB9FA4B83F51[0], level.farah))
      aliases = level._id_03C212E6ECB2B841;
    else if(scripts\engine\utility::is_equal(_id_BEE1CB9FA4B83F51[0], level._id_E0632103DFA5BB19))
      aliases = level._id_CAD9A91072752BF7;
  }

  _id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_6BC561D9F8020303() {
  self endon("death_or_disconnect");
  eattacker = undefined;

  while(!scripts\engine\utility::is_equal(eattacker, self))
    level waittill("enemy_killed", eattacker, _id_E851FFA44B7E0D54);

  return 1;
}

_id_F9EC117E695C4634(_id_5A4194BE2A98FB2B) {
  _id_8935EE5F55A88C21(_id_5A4194BE2A98FB2B);
  _id_99A887D75310BF40(2);
  aliases = ["dx_cp_cpr1_intr_pric_droppedem", "dx_cp_cpr1_intr_fara_theyredown", "dx_cp_cpr1_intr_gazz_clear_01"];
  player = _id_AA8653DEA5520361(5, [level._id_E0632103DFA5BB19, level.price, level.farah]);
  _id_A606867D80CFABD5(player, aliases, 0.3);
  thread _id_9C5067157CF34297(player, aliases);
  _id_99A887D75310BF40(1);

  if(scripts\engine\utility::flag("sounded_alarm")) {
    aliases = [undefined, "dx_cp_cpr1_intr_fara_theyknowwereherenow", "dx_cp_cpr1_intr_gazz_couldvegonebetter"];
    player = _id_AA8653DEA5520361(5, [level.farah, level._id_E0632103DFA5BB19]);
    _id_A606867D80CFABD5(player, aliases, 0.3);
  }

  _id_99A887D75310BF40(1.5);
  level._id_9F84E4E1C0C2A033 = 1;

  if(!isDefined(_id_45831CF64D17BBB1((4066.61, 17785.2, 1552), (0, 155, 0), undefined, 0.1))) {
    aliases = ["dx_cp_cpr1_intr_pric_wellworkourwaydownth", "dx_cp_cpr1_intr_fara_myteamwillhavemovedd", "dx_cp_cpr1_intr_gazz_wecanheaddownthistun"];
    player = _id_AA8653DEA5520361(5, [level.farah, level.price, level._id_E0632103DFA5BB19]);
    _id_A606867D80CFABD5(player, aliases, 0.4);
    _id_99A887D75310BF40(1);
    aliases = ["dx_cp_cpr1_intr_pric_letsmove", "dx_cp_cpr1_intr_fara_letsseewhereitleads", "dx_cp_cpr1_intr_gazz_letsgo"];
    player = _id_AA8653DEA5520361(5, [level.price, level.farah, level._id_E0632103DFA5BB19]);
    _id_A606867D80CFABD5(player, aliases, 0.2);
  }

  level._id_9F84E4E1C0C2A033 = undefined;
  _id_45831CF64D17BBB1((6627.13, 16385, 1552), (0, 132, 0));
  _id_E35E13135222B2A8(2);
  _id_99A887D75310BF40(2);
  level notify("vo_question_convo");
  level._id_9F84E4E1C0C2A033 = 1;
  player = _id_AA8653DEA5520361(5, [level._id_E0632103DFA5BB19, level.farah]);

  if(isDefined(player)) {
    aliases = [undefined, "dx_cp_cpr1_intr_fara_whatisthisplace", "dx_cp_cpr1_intr_gazz_whatthehellisthispla"];
    _id_A606867D80CFABD5(player, aliases, 0.4);
    wait 1;
    aliases = ["dx_cp_cpr1_intr_pric_itsanundergrounddock", "dx_cp_cpr1_intr_fara_itsanundergrounddock", "dx_cp_cpr1_intr_gazz_itsanundergrounddock"];
    _id_E50F13A24D028E8B = scripts\engine\utility::array_removeundefined([level.price, level.farah, level._id_E0632103DFA5BB19]);
    player = _id_AA8653DEA5520361(2, scripts\engine\utility::array_remove(_id_E50F13A24D028E8B, player));
    _id_A606867D80CFABD5(player, aliases, 0.3);
  }

  _id_425B54058CDF8AB1 = player;
  level._id_9F84E4E1C0C2A033 = undefined;
  _id_99A887D75310BF40(1);
  _id_E35E13135222B2A8(2);
  player = _id_AA8653DEA5520361(5, [level._id_E0632103DFA5BB19, level.price, level.farah]);

  if(isDefined(player)) {
    level._id_9F84E4E1C0C2A033 = 1;
    aliases = ["dx_cp_cpr1_intr_pric_whatsaqafter", "dx_cp_cpr1_intr_fara_whatisaqafter", "dx_cp_cpr1_intr_gazz_whatsaqafter"];
    _id_A606867D80CFABD5(player, aliases, 0.5);

    if(scripts\engine\utility::is_equal(_id_425B54058CDF8AB1, level.price)) {
      _id_E50F13A24D028E8B = scripts\engine\utility::array_removeundefined([level.farah, level.price]);
      player = _id_AA8653DEA5520361(5, scripts\engine\utility::array_remove(_id_E50F13A24D028E8B, player));
    } else {
      _id_E50F13A24D028E8B = scripts\engine\utility::array_removeundefined([level.price, level.farah]);
      player = _id_AA8653DEA5520361(5, scripts\engine\utility::array_remove(_id_E50F13A24D028E8B, player));
    }

    aliases = ["dx_cp_cpr1_intr_pric_theyrescavengingtryi", "dx_cp_cpr1_intr_fara_theyrescavengingbuil"];
    _id_A606867D80CFABD5(player, aliases, 0.5);
  }

  level._id_9F84E4E1C0C2A033 = undefined;
  _id_99A887D75310BF40(2);
  _id_6A5D3F2DA685613B((6627.13, 16385, 1552), (0, 132, 0), 1500, "reached_tunnel_end");
}

_id_100B957B4DACE0E0() {
  aliases = ["dx_cp_cpr1_intr_pric_aqsetclaymoreschecky", "dx_cp_cpr1_intr_fara_theyveplantedclaymor", "dx_cp_cpr1_intr_gazz_enemyclaymorehere"];
  result = 0;

  while(!istrue(result)) {
    player = _id_5BC7A5C4437D3803(scripts\engine\utility::array_removeundefined(level._id_C4EA99FA46D27C12), 0.98, 0.2, 0, undefined, 400, (0, 0, 10))[0];

    if(!scripts\engine\utility::flag("vo_combat") && !istrue(level._id_9F84E4E1C0C2A033))
      result = _id_A606867D80CFABD5(player, aliases, 0.2, 0, 1);

    scripts\engine\utility::flag_waitopen("vo_combat");
  }
}

_id_2E2D08CB518DBEAF() {
  self waittill("ownerChanged");

  if(!isDefined(level._id_B37597284A6DE133)) {
    decks = [];
    decks[decks.size] = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_pric_itsourclaymorenow", "dx_cp_cpr1_intr_pric_hackedone", "dx_cp_cpr1_intr_pric_disarmed"]);
    decks[decks.size] = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_fara_hackedthisone", "dx_cp_cpr1_intr_fara_disarmedaclaymore", "dx_cp_cpr1_intr_fara_trapdisarmed"]);
    decks[decks.size] = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_gazz_hackedaclaymore", "dx_cp_cpr1_intr_gazz_claymoredisarmed"]);
    level._id_B37597284A6DE133 = decks;
  }

  if(!scripts\engine\utility::flag("vo_combat") && !istrue(level._id_9F84E4E1C0C2A033))
    _id_A606867D80CFABD5(self.owner, level._id_B37597284A6DE133, 0.3, 0, 1);
}

_id_29ECBC29B4D0FE6A() {
  level endon("found_puzzle");

  if(!isDefined(level._id_072A187C54476990)) {
    decks = [];
    decks[decks.size] = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_pric_moreaq", "dx_cp_cpr1_intr_pric_xrays"]);
    decks[decks.size] = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_fara_enemy", "dx_cp_cpr1_intr_fara_aqhere"]);
    decks[decks.size] = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_gazz_aqspotted", "dx_cp_cpr1_intr_gazz_gotmoreaq"]);
    level._id_072A187C54476990 = decks;
  }

  wait 1;
  player = _id_A9D9C0245997A414(3);
  _id_A606867D80CFABD5(player, level._id_072A187C54476990, 0.6);
  scripts\engine\utility::flag_wait("vo_combat");
  _id_99A887D75310BF40(2, 1);
  aliases = ["dx_cp_cpr1_nums_pric_wereclear", "dx_cp_cpr1_armo_fara_clear", "dx_cp_cpr1_armo_gazz_clear"];
  player = _id_A9D9C0245997A414(3);
  _id_A606867D80CFABD5(player, aliases, 0.6);
}

_id_71C102FAF0201ED8() {
  level endon("found_puzzle");
  aliases = ["dx_cp_cpr1_intr_pric_movingupstairs", "dx_cp_cpr1_intr_fara_takingthestairs", "dx_cp_cpr1_intr_gazz_movingtotheseconddec"];
  player = _id_B826409EE2EFF7B6(1667);

  if(!scripts\engine\utility::flag("vo_combat") && !istrue(level._id_9F84E4E1C0C2A033))
    _id_A606867D80CFABD5(player, aliases, 0.3, 0, 0.5);
}

_id_0670B7C2821CB804() {
  level endon("found_puzzle");
  thread _id_8B9669A9CC941CEA();
  thread _id_D836665C56E2A3B3();
  _id_D1B5403237090258 = ["dx_cp_cpr1_intr_pric_weneedtogetthosedoor", "dx_cp_cpr1_intr_fara_weneedtoopenthosedoo", "dx_cp_cpr1_intr_gazz_weneedtogetthosedoor"];
  _id_98004E404750C0B9 = ["dx_cp_cpr1_intr_pric_lookforawaytoopentho", "dx_cp_cpr1_intr_fara_searchforawaytoopent", "dx_cp_cpr1_intr_gazz_findawaytoopenthosed"];
  _id_967C3B5BDC341CE1 = [_id_D1B5403237090258, _id_98004E404750C0B9];
  _id_AB61047C58ED1026 = [];
  _id_AB61047C58ED1026[_id_AB61047C58ED1026.size] = [level.price, level.farah, level._id_E0632103DFA5BB19];
  _id_AB61047C58ED1026[_id_AB61047C58ED1026.size] = [level.farah, level._id_E0632103DFA5BB19, level.price];
  _id_AB61047C58ED1026[_id_AB61047C58ED1026.size] = [level._id_E0632103DFA5BB19, level.price, level.farah];
  _id_46AB238A3D106DD5 = scripts\engine\utility::create_deck(_id_AB61047C58ED1026, 1, 1);
  _id_0E72A2C43C5BC656 = (2052.06, 18376.8, 1672.34);
  index = 0;
  _id_99A887D75310BF40(2, 0);

  for(player = _id_5BC7A5C4437D3803(_id_0E72A2C43C5BC656, 0.9, 0.4)[0]; scripts\engine\utility::flag("vo_combat"); player = _id_5BC7A5C4437D3803(_id_0E72A2C43C5BC656, 0.9, 0.4)[0])
    _id_99A887D75310BF40(2, 0);

  result = _id_A606867D80CFABD5(player, _id_967C3B5BDC341CE1[index], 0.2);

  if(istrue(result))
    index = !index;

  wait 15;

  for(;;) {
    _id_99A887D75310BF40(2, 0);
    player = _id_AA8653DEA5520361(undefined, _id_46AB238A3D106DD5 scripts\engine\utility::deck_draw());
    result = _id_A606867D80CFABD5(player, _id_967C3B5BDC341CE1[index], 0.2);

    if(istrue(result))
      index = !index;

    wait 15;
  }
}

_id_8B9669A9CC941CEA() {
  origin = (3114.27, 18580.6, 1552.5);
  angles = (0, 180, 0);
  scripts\engine\utility::flag_set("reached_tunnel_end");
  _id_99A887D75310BF40(2, 0);
  _id_6A5D3F2DA685613B(origin, angles);
}

_id_D836665C56E2A3B3() {
  _id_7D2852D02216C876 = _id_3B46C8D1F1AE39D3(0, 1950);

  foreach(player in level.players)
  player thread _id_7A189F5170165314();

  thread _id_B41BFA06C8C373EB();
  thread _id_42C380642222787F();
  thread _id_568403AC422BD12F();
  scripts\engine\utility::flag_set("found_puzzle");
  aliases = ["dx_cp_cpr1_intr_pric_foundsomething", "dx_cp_cpr1_intr_fara_ifoundsomething", "dx_cp_cpr1_intr_gazz_gotsomethinghere"];
  _id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);
  thread _id_F3AA9544DC0E3F0D();
  _id_3AE89F6413180DEE();
}

_id_B41BFA06C8C373EB() {
  level endon("game_ended");
  scripts\engine\utility::flag_set("stealth_music_pause");
  waitframe();
  level._id_7CAA8AB2F4145CFA = "mx_cp_raid1_puzzle1";
  setmusicstate(level._id_7CAA8AB2F4145CFA);
}

_id_F3AA9544DC0E3F0D() {
  wait 2;
  aliases = ["dx_cp_cpr1_intr_pric_aqgotthepoweron", "dx_cp_cpr1_intr_fara_aqturnedonthepower", "dx_cp_cpr1_intr_gazz_niceofemtoleavetheli"];
  player = _id_3B46C8D1F1AE39D3(0, 1950, scripts\engine\utility::array_randomize(level.players));
  _id_A606867D80CFABD5(player, aliases, 0.3);
  aliases = ["dx_cp_cpr1_intr_pric_someoneknowshowtowor", "dx_cp_cpr1_intr_fara_someoneknowsrussiane", "dx_cp_cpr1_intr_gazz_someoneknowstheirrus"];
  player = _id_A9D9C0245997A414(0.5, scripts\engine\utility::array_remove(level.players, player));
  _id_A606867D80CFABD5(player, aliases, 0.3, 0, 0);
  scripts\engine\utility::flag_set("power_on_convo_finished");
}

_id_7A189F5170165314() {
  level endon("cctv_camera_enter");
  level endon("vo_exit_puzzle_room");

  while(self.origin[0] > 1950)
    waitframe();

  while(self.origin[0] < 1950)
    waitframe();

  player = _id_3B46C8D1F1AE39D3(0, 1950, scripts\engine\utility::array_remove(scripts\engine\utility::array_randomize(level.players), self), 0.2);

  if(!isDefined(player))
    player = self;

  aliases = ["dx_cp_cpr1_intr_pric_thecontrolsforthedoo", "dx_cp_cpr1_intr_fara_theseterminalsopenth", "dx_cp_cpr1_intr_gazz_wecanopenthedoorfrom"];
  thread _id_A606867D80CFABD5(player, aliases, 0.3);
  level notify("vo_exit_puzzle_room");
}

_id_42C380642222787F() {
  level endon("cctv_camera_enter");
  scripts\engine\utility::flag_wait("power_on_convo_finished");
  aliases = ["dx_cp_cpr1_intr_pric_checkthecamerasseeif", "dx_cp_cpr1_intr_fara_wecouldusethecameras", "dx_cp_cpr1_intr_gazz_thecamerascouldhelpu"];
  origin = level._id_5A2AF420BC54EE97.interacts[1]._id_C5D3D8FF129F88BA.origin;
  player = _id_5BC7A5C4437D3803(origin, 0.97, 0.3, 0, undefined, 100)[0];
  _id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_3AE89F6413180DEE() {
  level endon("vo_correct_code");
  aliases = ["dx_cp_cpr1_intr_pric_terminalisshowingthr", "dx_cp_cpr1_intr_fara_iseethreelettersonth", "dx_cp_cpr1_intr_gazz_theresthreeletterson"];
  player = _id_DF69B417C287B3BA();
  _id_A606867D80CFABD5(player, aliases, 0.3);
  players = scripts\engine\utility::array_remove(scripts\engine\utility::array_randomize(level.players), player);
  players[players.size] = player;
  aliases = ["dx_cp_cpr1_intr_pric_couldbepartofthecode", "dx_cp_cpr1_intr_fara_theycouldbepartofthe", "dx_cp_cpr1_intr_gazz_itmaybepartofthecode"];
  player = _id_AA8653DEA5520361(0, players);
  _id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_78B7A8FFD064D278() {
  level endon("vo_correct_code");
  aliases = ["dx_cp_cpr1_intr_pric_itsfourlettersnow", "dx_cp_cpr1_intr_fara_waitnowitshowsfourle", "dx_cp_cpr1_intr_gazz_okayitsshowingfourle"];
  player = _id_DF69B417C287B3BA();
  thread _id_A606867D80CFABD5(player, aliases, 0.3);
  players = scripts\engine\utility::array_remove(scripts\engine\utility::array_randomize(level.players), player);
  players[players.size] = player;
  aliases = ["dx_cp_cpr1_intr_pric_onesadecoy", "dx_cp_cpr1_intr_fara_onemustbeadecoy", "dx_cp_cpr1_intr_gazz_theresadecoy"];
  player = _id_AA8653DEA5520361(0, players);
  _id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_E9CBC884E223874C() {
  level endon("vo_correct_code");
  aliases = ["dx_cp_cpr1_intr_pric_fivelettersnow", "dx_cp_cpr1_intr_fara_itshowsfivelettersno", "dx_cp_cpr1_intr_gazz_fivelettersthistime"];
  player = _id_DF69B417C287B3BA();
  thread _id_A606867D80CFABD5(player, aliases, 0.3);
  players = scripts\engine\utility::array_remove(scripts\engine\utility::array_randomize(level.players), player);
  players[players.size] = player;
  aliases = ["dx_cp_cpr1_intr_pric_twoaredecoys", "dx_cp_cpr1_intr_fara_therearetwodecoys", "dx_cp_cpr1_intr_gazz_twodecoysnow"];
  player = _id_AA8653DEA5520361(0, players);
  _id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_DF69B417C287B3BA() {
  origin = (1879, 18735, 1615);

  for(player = _id_5BC7A5C4437D3803(origin, 0.95, 0.3, 0, undefined, 120)[0]; istrue(level._id_D0A95B4588E0CB2B); player = _id_5BC7A5C4437D3803(origin, 0.96, 0.3, 0, undefined, 120)[0]) {}

  return player;
}

_id_72A0C69D4DF855E5(door) {
  thread _id_24A5EF674C709F1A();
}

_id_24A5EF674C709F1A() {
  player = _id_3B46C8D1F1AE39D3(0, 1615);
  aliases = ["dx_cp_cpr1_intr_pric_foundanotherroom", "dx_cp_cpr1_intr_fara_theresanotherroom", "dx_cp_cpr1_intr_gazz_anotherroomhere"];
  thread _id_A606867D80CFABD5(player, aliases, 0.3);
  aliases = ["dx_cp_cpr1_intr_pric_morecamerashere", "dx_cp_cpr1_intr_fara_theresmorecameras", "dx_cp_cpr1_intr_gazz_gotmorecamerasinhere"];
  origin = level._id_5A2AF420BC54EE97.interacts[0]._id_C5D3D8FF129F88BA.origin;
  player = _id_5BC7A5C4437D3803(origin, 0.97, 0.2, 0, undefined, 150)[0];
  _id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_FA472D0EABDC4A2F(alias) {
  _id_A606867D80CFABD5(self, alias, 0.1, 0, 0.7);
}

_id_1AD056E2EAF1F51E() {
  level endon("game_ended");

  if(scripts\engine\utility::flag("seq3_poweron")) {
    aliases = [];

    switch (level.seq3_tier) {
      case 2:
        _id_5E7BF2DED37463C3();
        return;
      case 3:
        _id_5E7BF3DED37465F6();
        return;
    }

    _id_0A7EBAB04E39FEC8();
  } else
    _id_6C8EF50042FDAA0C();
}

_id_6C8EF50042FDAA0C() {
  level notify("vo_correct_code");

  if(level.seq3_tier == 4) {
    return;
  }
  wait 1.5;
  aliases = [];
  aliases[aliases.size] = ["dx_cp_cpr1_intr_pric_thatsit", "dx_cp_cpr1_intr_pric_lastone"];
  aliases[aliases.size] = ["dx_cp_cpr1_intr_fara_thatworked", "dx_cp_cpr1_intr_fara_onemore"];
  aliases[aliases.size] = ["dx_cp_cpr1_intr_gazz_wereinbusiness", "dx_cp_cpr1_intr_gazz_onetogo"];
  aliases = _id_C810DB5F583495B1(self, aliases);
  _id_A606867D80CFABD5(self, aliases[level.seq3_tier - 2], 0.1);

  if(level.seq3_tier == 2) {
    players = scripts\engine\utility::array_remove(scripts\engine\utility::array_randomize(level.players), self);
    players[players.size] = self;
    aliases = ["dx_cp_cpr1_intr_pric_alrightnextcode", "dx_cp_cpr1_intr_fara_theresanewsequence", "dx_cp_cpr1_intr_gazz_letsrunitagain"];
    player = _id_AA8653DEA5520361(0.3, players);
    _id_A606867D80CFABD5(player, aliases, 0.3);
    thread _id_78B7A8FFD064D278();
    return;
  }

  thread _id_E9CBC884E223874C();
}

_id_84B9148AF8CA5D53() {
  wait 1;

  if(!isDefined(level._id_7EDAD2FBC5F2C2CF)) {
    if(scripts\engine\utility::flag("seq3_poweron"))
      _id_29100C853B2EA8AE();
    else
      _id_4E06438C3BDA7971();
  }

  _id_A606867D80CFABD5(self, level._id_7EDAD2FBC5F2C2CF, 0.1);
}

_id_4E06438C3BDA7971() {
  decks = [];
  decks[decks.size] = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_pric_wrongcode", "dx_cp_cpr1_intr_pric_thatdidntwork", "dx_cp_cpr1_intr_pric_nogood"]);
  decks[decks.size] = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_fara_itdidntwork", "dx_cp_cpr1_intr_fara_itsnotworking", "dx_cp_cpr1_intr_fara_invalidcode"]);
  decks[decks.size] = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_gazz_negativedidntwork", "dx_cp_cpr1_intr_gazz_nahthatcodesnogood", "dx_cp_cpr1_intr_gazz_thatsnotit"]);
  level._id_7EDAD2FBC5F2C2CF = decks;
}

_id_63765016FA13A8E0() {
  level endon("game_ended");
  level endon("seq3_puzzle_complete");
  level endon("maze_numstutorial_complete");
  wait 1.3;
  _id_9BBACB179DEA3237 = scripts\engine\utility::array_remove_array(level.players, level._id_B54CC012D53DB80F);
  aliases = ["dx_cp_cpr1_intr_pric_imlockedout", "dx_cp_cpr1_intr_fara_itlockedmeout", "dx_cp_cpr1_intr_gazz_bloodythinglockedmeo"];
  _id_A606867D80CFABD5(self, aliases, 0.2);

  if(_id_9BBACB179DEA3237.size == 1) {
    if(scripts\engine\utility::is_equal(_id_9BBACB179DEA3237[0], level.price))
      aliases = [undefined, "dx_cp_cpr1_intr_fara_howaboutyoucaptain", "dx_cp_cpr1_intr_gazz_haveatitcaptain"];
    else if(scripts\engine\utility::is_equal(_id_9BBACB179DEA3237[0], level.farah))
      aliases = ["dx_cp_cpr1_intr_pric_farahaveago", undefined, "dx_cp_cpr1_intr_gazz_farahyoullhavetodoit"];
    else if(scripts\engine\utility::is_equal(_id_9BBACB179DEA3237[0], level._id_E0632103DFA5BB19))
      aliases = ["dx_cp_cpr1_intr_pric_sergeantyoureup", "dx_cp_cpr1_intr_fara_sergeantyoutry"];
    else
      return;

    _id_A606867D80CFABD5(self, aliases, 0.2);
    aliases = ["dx_cp_cpr1_intr_pric_rspg", "dx_cp_cpr1_nums_fara_rspg", "dx_cp_cpr1_nums_gazz_rspg"];
    _id_A606867D80CFABD5(_id_9BBACB179DEA3237[0], aliases, 0.3);
  } else {
    aliases = ["dx_cp_cpr1_intr_pric_oneofyoutry", "dx_cp_cpr1_intr_fara_someoneelsetryit", "dx_cp_cpr1_intr_gazz_oneofyougiveitago"];
    _id_A606867D80CFABD5(self, aliases, 0.2);
  }
}

_id_BF64E2D9FCB0F94F() {
  aliases = ["dx_cp_cpr1_intr_pric_theresasubmarineinth", "dx_cp_cpr1_intr_fara_asubmarineisinthatro", "dx_cp_cpr1_intr_gazz_thatsabloodysubinthe"];
  origin = (1178.36, 18452.9, 1609.02);
  player = _id_5BC7A5C4437D3803(origin, 0.98, 0.6);
  _id_A606867D80CFABD5(player, aliases, 0.3);
  aliases = ["dx_cp_cpr1_intr_pric_couldbewhataqsafter", "dx_cp_cpr1_intr_fara_aqcouldbescavengingi", "dx_cp_cpr1_intr_gazz_guessaqdidntgetthedo"];
  player = _id_A9D9C0245997A414(0.5, scripts\engine\utility::array_remove(level.players, player));
  _id_A606867D80CFABD5(player, aliases, 0.3);
  scripts\engine\utility::flag_set("vo_sub_spotted");
}

_id_6F8B5DAC34599048() {
  level._id_D0A95B4588E0CB2B = 1;
  _id_E2FC7B87138BDEF2();
  wait 4;
  level._id_D0A95B4588E0CB2B = 0;

  if(!isDefined(level._id_746D8B3728AA2AD8)) {
    decks = [];
    decks[decks.size] = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_pric_herewerebackup", "dx_cp_cpr1_intr_pric_restarting"]);
    decks[decks.size] = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_fara_therethesystemisunlo", "dx_cp_cpr1_intr_fara_goodtogo"]);
    decks[decks.size] = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_gazz_gotitsystemsup", "dx_cp_cpr1_intr_gazz_letstryagain"]);
    level._id_746D8B3728AA2AD8 = decks;
  }

  _id_A606867D80CFABD5(level._id_A4D87E220508D745, level._id_746D8B3728AA2AD8, 0.3);
}

_id_E2FC7B87138BDEF2() {
  level endon("puzzle_code_reset");
  wait 2;
  _id_E2E3E36BA514DC2F = (1667.02, 18760.9, 1552);
  players = sortbydistance(level.players, _id_E2E3E36BA514DC2F);

  if(!istrue(level._id_CBDA0E2F8EBF90D3)) {
    if(players.size == 3)
      players = [players[1], players[0], players[2]];

    aliases = ["dx_cp_cpr1_intr_pric_whathappened", "dx_cp_cpr1_intr_fara_whatswrong", "dx_cp_cpr1_intr_gazz_whatjusthappened"];
    player = _id_AA8653DEA5520361(0.5, players);
    _id_A606867D80CFABD5(player, aliases, 0.3);

    if(isDefined(player))
      players = scripts\engine\utility::array_remove(players, player);

    level._id_CBDA0E2F8EBF90D3 = 1;
  }

  aliases = ["dx_cp_cpr1_intr_pric_weguessedwrongsystem", "dx_cp_cpr1_intr_fara_threewrongcodeswerel", "dx_cp_cpr1_intr_gazz_invalidcodesitlocked"];
  player = _id_AA8653DEA5520361(0.5, players);
  _id_A606867D80CFABD5(player, aliases, 0.3);
  players = sortbydistance(level.players, _id_E2E3E36BA514DC2F);
  players = scripts\engine\utility::array_reverse(players);
  aliases = ["dx_cp_cpr1_intr_pric_tryandrestartit", "dx_cp_cpr1_intr_fara_canwerestartit", "dx_cp_cpr1_intr_gazz_lookforawaytorestart"];
  player = _id_AA8653DEA5520361(0.5, players);
  _id_A606867D80CFABD5(player, aliases, 0.3);
  level waittill("puzzle_code_reset");
}

_id_568403AC422BD12F() {
  thread _id_14E8F62149F5F257();
  level waittill("switched_cctv_cam", player, interact);

  while(!scripts\engine\utility::is_equal(interact.name, "cctv_interact_2") || !scripts\engine\utility::is_equal(interact._id_163F0EFAB64B2DDB, 1))
    level waittill("switched_cctv_cam", player, interact);

  aliases = ["dx_cp_cpr1_intr_pric_tunnels", "dx_cp_cpr1_intr_fara_tunnels", "dx_cp_cpr1_intr_gazz_tunnels"];
  scripts\engine\utility::delaythread(0.7, ::_id_A606867D80CFABD5, player, aliases, 0.3);

  while(!scripts\engine\utility::is_equal(interact.name, "cctv_interact_2") || !scripts\engine\utility::is_equal(interact._id_163F0EFAB64B2DDB, 2))
    level waittill("switched_cctv_cam", player, interact);

  aliases = ["dx_cp_cpr1_intr_pric_controlrooms", "dx_cp_cpr1_intr_fara_controlrooms", "dx_cp_cpr1_intr_gazz_controlrooms"];
  scripts\engine\utility::delaythread(0.7, ::_id_A606867D80CFABD5, player, aliases, 0.3);

  while(!scripts\engine\utility::is_equal(interact.name, "cctv_interact_2") || !scripts\engine\utility::is_equal(interact._id_163F0EFAB64B2DDB, 3))
    level waittill("switched_cctv_cam", player, interact);

  wait 0.7;
  aliases = ["dx_cp_cpr1_intr_pric_itsasovietbase", "dx_cp_cpr1_intr_fara_itssovietbase", "dx_cp_cpr1_intr_gazz_itssovietbase"];
  wait 0.7;
  _id_A606867D80CFABD5(player, aliases, 0.3);
  players = scripts\engine\utility::array_remove(level.players, player);
  player = _id_AA8653DEA5520361(1, scripts\engine\utility::array_insert(players, player, 0));
  aliases = ["dx_cp_cpr1_intr_pric_alexfoundthis", "dx_cp_cpr1_intr_fara_thisiswhatalexfound", "dx_cp_cpr1_intr_gazz_alexfoundthis"];
  thread _id_A606867D80CFABD5(player, aliases, 0.3);
  players = scripts\engine\utility::array_remove(level.players, player);
  player = _id_AA8653DEA5520361(1, scripts\engine\utility::array_add(players, player));
  aliases = ["dx_cp_cpr1_intr_pric_beforehewentdark", "dx_cp_cpr1_intr_fara_beforewelostcomms", "dx_cp_cpr1_intr_gazz_beforehewentdark"];
  _id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_14E8F62149F5F257() {
  level waittill("switched_cctv_cam", player, interact);

  while(!(scripts\engine\utility::is_equal(interact.name, "cctv_interact_1") || scripts\engine\utility::is_equal(interact.name, "cctv_interact_2")) || !scripts\engine\utility::is_equal(interact._id_163F0EFAB64B2DDB, 4))
    level waittill("switched_cctv_cam", player, interact);

  aliases = ["dx_cp_cpr1_intr_pric_gotacodehere", "dx_cp_cpr1_intr_fara_ifoundacode", "dx_cp_cpr1_intr_gazz_gotacodehere"];
  scripts\engine\utility::delaythread(0.7, ::_id_A606867D80CFABD5, player, aliases, 0.3);
  _id_59C5C2B38F942037 = scripts\engine\utility::ter_op(scripts\engine\utility::is_equal(interact.name, "cctv_interact_1"), "cctv_interact_2", "cctv_interact_1");

  while(!scripts\engine\utility::is_equal(interact.name, _id_59C5C2B38F942037) || !scripts\engine\utility::is_equal(interact._id_163F0EFAB64B2DDB, 4))
    level waittill("switched_cctv_cam", player, interact);

  aliases = ["dx_cp_cpr1_intr_pric_foundanothercode", "dx_cp_cpr1_intr_fara_ifoundanothercode", "dx_cp_cpr1_intr_gazz_foundanothercodewith"];
  level._id_EF009C528C870124 = 1;
  scripts\engine\utility::delaythread(1.5, ::_id_A606867D80CFABD5, player, aliases, 0.3);
}

_id_E7258F01214A04A2() {
  for(;;) {
    level waittill("switched_cctv_cam", player, interact);
    thread _id_41DA9EE2ED3A1CBE(player, interact);
  }
}

_id_41DA9EE2ED3A1CBE(player, interact) {
  level endon("switched_cctv_cam");

  for(;;)
    waitframe();
}

_id_279630B251D193C2(hints) {
  if(hints == 0) {
    return;
  }
  if(istrue(level._id_D0A95B4588E0CB2B)) {
    hints--;
    return;
  }

  if(hints == 1) {
    if(istrue(level._id_EF009C528C870124)) {
      aliases = ["dx_cp_cpr1_intr_pric_codecouldbesplitbetw", "dx_cp_cpr1_intr_fara_checkbothscreenforth", "dx_cp_cpr1_intr_gazz_bothscreenscouldhave"];
      player = _id_A9D9C0245997A414();
      _id_A606867D80CFABD5(player, aliases, 0.3);
    }

    return;
  }

  if(hints > 1) {
    return;
  }
  aliases = ["dx_cp_cpr1_intr_pric_itsathreedigitcode", "dx_cp_cpr1_intr_fara_thecodeisthreenumber", "dx_cp_cpr1_intr_gazz_codeisthreedigits"];
  player = _id_A9D9C0245997A414();
  _id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_DD654A48F02EBFD9() {
  level endon("game_ended");
  _id_CA6072CDCAA99E14();
  level childthread _id_84443287A0AA294A();
  level childthread _id_4E3FA173056C07EC();
  level childthread _id_6FBAE834FA93AE9E();
  wait 3;
  _id_4221FB208176557E();
}

_id_CA6072CDCAA99E14() {
  level._id_42B4D2C5FB711AFE = undefined;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_intr_pric_werein";
  aliases[aliases.size] = "dx_cp_cpr1_intr_fara_thedoorsareopening";
  aliases[aliases.size] = "dx_cp_cpr1_intr_gazz_silodoorsareopening";
  player = _id_A9D9C0245997A414(0.5);
  _id_A606867D80CFABD5(player, aliases, 0.3);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_intr_pric_watcher1bravo06comms";
  aliases[aliases.size] = "dx_cp_cpr1_intr_fara_watcher1kilo01commsc";
  aliases[aliases.size] = "dx_cp_cpr1_intr_gazz_watcher1bravo61comms";
  player = _id_A9D9C0245997A414(0.5);
  _id_A606867D80CFABD5(player, aliases, 0.3);
  _id_18AF78602B67B70C::_id_775CD164C569E279("dx_cp_cpr1_intr_lasw_thisiswatchersendtra");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_intr_pric_facilityisasovietbas";
  aliases[aliases.size] = "dx_cp_cpr1_intr_fara_thisisasovietbaseaqi";
  aliases[aliases.size] = "dx_cp_cpr1_intr_gazz_facilityisasovietbas";
  player = _id_A9D9C0245997A414(0.5);
  _id_A606867D80CFABD5(player, aliases, 0.3);
  _id_18AF78602B67B70C::_id_775CD164C569E279("dx_cp_cpr1_intr_lasw_copyweneedtofindwhat");
  _id_18AF78602B67B70C::_id_775CD164C569E279("dx_cp_cpr1_intr_lasw_continueyourreconoft");

  if(isDefined(level.farah))
    level.farah _id_5D265B4FCA61F070::say("dx_cp_cpr1_intr_fara_welcometomyworld", undefined, 2);
}

_id_4221FB208176557E() {
  level endon("game_ended");
  origin = (1174, 18388, 1612);

  if(!scripts\engine\utility::flag("vo_sigil_playing"))
    level endon("vo_sigil_playing");

  if(scripts\engine\utility::flag("vo_sigil_playing"))
    scripts\engine\utility::flag_waitopen_or_timeout("vo_sigil_playing", 7);

  _id_D39A15B9327D0EEF = _id_5BC7A5C4437D3803(origin, 0.98, 0.2, 0, undefined, 800)[0];
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_theressomerussiantec";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_aqfoundasubmarine";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_thatsanicesub";
  scripts\engine\utility::flag_set("vo_sub_playing");
  speakers = level.players;
  _id_D39A15B9327D0EEF = _id_AA8653DEA5520361(undefined, scripts\engine\utility::array_combine([_id_D39A15B9327D0EEF], scripts\engine\utility::array_remove(speakers, _id_D39A15B9327D0EEF)));
  _id_A606867D80CFABD5(_id_D39A15B9327D0EEF, aliases, 0.3);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_theyhaventtakenit";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_theydidnttakeit";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_looksliketheyleftit";
  speakers = level.players;
  wait 0.3;
  _id_466744BDE443021B = _id_AA8653DEA5520361(10, scripts\engine\utility::array_combine(scripts\engine\utility::array_remove(speakers, _id_D39A15B9327D0EEF), [_id_D39A15B9327D0EEF]));
  _id_A606867D80CFABD5(_id_466744BDE443021B, aliases, 0.3);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_theyreaftersomething";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_theyreaftersomething";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_maybetheyfoundsometh";
  wait 0.3;

  if(level.players.size == 3) {
    _id_31DF9B697450141C = level.players;
    _id_31DF9B697450141C = scripts\engine\utility::array_remove_array(_id_31DF9B697450141C, [_id_D39A15B9327D0EEF, _id_466744BDE443021B]);
    _id_7D2852D02216C876 = _id_AA8653DEA5520361(10, scripts\engine\utility::array_combine(_id_31DF9B697450141C, [_id_D39A15B9327D0EEF, _id_466744BDE443021B]));
  } else
    _id_7D2852D02216C876 = _id_AA8653DEA5520361(10, scripts\engine\utility::array_combine(scripts\engine\utility::array_remove(speakers, _id_466744BDE443021B), [_id_466744BDE443021B]));

  if(isDefined(_id_7D2852D02216C876))
    _id_A606867D80CFABD5(_id_7D2852D02216C876, aliases);

  scripts\engine\utility::flag_clear("vo_sub_playing");
}

_id_CB807C54DDFA3FB8() {
  level._id_42B4D2C5FB711AFE = undefined;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_foundanairtank";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_airtankhere";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_gotanairtankhere";
  _id_C3A4A4E66BB7D63C = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_onlyone";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_theresonlyone";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_justone";
  _id_7AEF5B890EC8F140 = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_onlyoneairtankstickt";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_wellhavetosharetheai";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_sticktogetherweonlyh";
  _id_D247D4F49557C576 = aliases;
  scripts\engine\utility::flag_wait("picked_up_oxygen_mask");

  if(scripts\engine\utility::flag("vo_sigil_playing"))
    scripts\engine\utility::flag_waitopen_or_timeout("vo_sigil_playing", 7);

  player = _id_4D5D872A7BD5C0C3::_id_A3070BE4E578D579();
  scripts\engine\utility::flag_set("vo_airtank_playing");
  _id_A606867D80CFABD5(player, _id_C3A4A4E66BB7D63C, 0.3);
  thread _id_A606867D80CFABD5(player, _id_7AEF5B890EC8F140, 0.35);
  scripts\engine\utility::flag_set("vo_airtank_ended");
}

_id_4E3FA173056C07EC() {
  origin = (1059, 18030, 1610);

  if(scripts\engine\utility::flag("vo_sub_playing"))
    scripts\engine\utility::flag_waitopen_or_timeout("vo_sub_playing", 10);

  player = _id_5BC7A5C4437D3803(origin, 0.98, 0.4, 0, undefined, 150)[0];
  scripts\engine\utility::flag_set("vo_sigil_playing");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_lookhere31alexscalls";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_look31alexandmyteamw";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_oitheresa31hereitsal";
  _id_A606867D80CFABD5(player, aliases, 0.3);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_theymadeitthrough";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_mysoldiersmadeitthro";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_theymadeitthrough";
  player = _id_A9D9C0245997A414(0.5);
  _id_A606867D80CFABD5(player, aliases, 0.3);
  scripts\engine\utility::flag_clear("vo_sigil_playing");
}

_id_6FBAE834FA93AE9E() {
  level endon("game_ended");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_underthewaterherethe";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_theresapaththroughth";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_checkunderthewaterlo";
  origin = (645, 18040, 1419);
  player = _id_5BC7A5C4437D3803(origin, 0.98, 0.2, 0, undefined, 600)[0];

  if(player _meth_6F55D55CCFF20D14())
    _id_9A835763C929EB24(player, 10);

  if(isDefined(player))
    _id_A606867D80CFABD5(player, aliases, 0.5);
  else {
    _id_6BCD40D4AAE48211 = scripts\engine\utility::get_array_of_closest(origin, level.players, undefined, undefined, 400, undefined);
    player = _id_AA8653DEA5520361(15, _id_6BCD40D4AAE48211);
    _id_A606867D80CFABD5(player, aliases, 0.5);
  }
}

_id_180FBB36934E2687(start, end, _id_75BEA58D65510615) {
  _id_C56207BDA09B3A36 = ["physicscontents_foliage", "physicscontents_foliage_audio", "physicscontents_glass", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicleclip", "physicscontents_itemclip", "physicscontents_clipshot", "physicscontents_playerclip", "physicscontents_aiclip", "physicscontents_vehicle", "physicscontents_useclip"];
  contents = physics_createcontents(_id_C56207BDA09B3A36);
  trace = scripts\engine\trace::ray_trace_passed(start, end, _id_75BEA58D65510615, contents);
  return trace;
}

_id_84443287A0AA294A() {
  level endon("game_ended");
  level endon("stairs_trigger_hit");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_cantswimitwithoutair";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_wellneedairtogetthro";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_wecantmakeitthroughw";
  _id_7CDD32320CBFEF78 = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_onlyoneairtankstickt";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_wellhavetosharetheai";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_sticktogetherweonlyh";
  _id_8E75A295BBECCFD2 = aliases;
  origin = (470, 17800, 1375);
  _id_B6C4774B0349A731 = 0;

  while(!istrue(_id_B6C4774B0349A731)) {
    _id_7D2852D02216C876 = _id_71FC89B3E8140B4B([origin], 100)[0];

    if(_id_7D2852D02216C876 _meth_6F55D55CCFF20D14())
      _id_9A835763C929EB24(_id_7D2852D02216C876, 15);

    if(!isDefined(_id_7D2852D02216C876)) {
      return;
    }
    _id_B6C4774B0349A731 = _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_7CDD32320CBFEF78, 0.3);

    if(!_id_B6C4774B0349A731) {
      continue;
    }
    speakers = level.players;

    if(scripts\engine\utility::flag("picked_up_oxygen_mask") && level.players.size > 1) {
      _id_8AEA06B2E3F1169A = scripts\engine\utility::array_combine(scripts\engine\utility::array_remove(speakers, _id_7D2852D02216C876), [_id_7D2852D02216C876]);
      _id_632907A9ED2D6DA9 = _id_4D5D872A7BD5C0C3::_id_A3070BE4E578D579();
      _id_8AEA06B2E3F1169A = scripts\engine\utility::array_removeundefined(scripts\engine\utility::array_combine([_id_632907A9ED2D6DA9], _id_8AEA06B2E3F1169A));
      _id_7D2852D02216C876 = _id_AA8653DEA5520361(10, _id_8AEA06B2E3F1169A);

      if(isDefined(_id_7D2852D02216C876))
        _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_8E75A295BBECCFD2, 0.3);
    }
  }
}

_id_32E44483E735F7A1() {
  _id_29C381EB09171E93 = getEnt("first_staircase", "script_noteworthy");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_thegreenchemlights";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_thosegreenlights";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_youseethegreenchemli";
  _id_BE3E67903AA0B19F = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_alexandyoursoldiersm";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_alexandmysoldiersmar";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_alexandyoursoldiersm";
  _id_657101C6711A8654 = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_farahssoldiersmarked";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_farahssoldiersmarked";
  _id_5086753382CF603A = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_keepaneyeout";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_itcanhelpguideus";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_wecanfollowit";
  _id_58ADBFCA23D5372B = aliases;

  for(;;) {
    _id_29C381EB09171E93 waittill("trigger", player);

    if(isPlayer(player)) {
      break;
    }
  }

  level notify("stairs_trigger_hit");

  if(isDefined(level.farah)) {
    speakers = level.players;
    _id_7D2852D02216C876 = _id_215866EE17ECD840(_id_29C381EB09171E93.origin, undefined, 1200);
    _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_BE3E67903AA0B19F);
    _id_42B4D2C5FB711AFE = _id_7D2852D02216C876;
    _id_7D2852D02216C876 = _id_AA8653DEA5520361(10, scripts\engine\utility::array_combine(scripts\engine\utility::array_remove(speakers, _id_7D2852D02216C876), [_id_7D2852D02216C876]));

    if(_id_7D2852D02216C876 != level.farah && _id_42B4D2C5FB711AFE != level.farah && !_id_6B80A21EDCF9D296(level.farah))
      _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_5086753382CF603A, 0.3);
    else
      _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_657101C6711A8654, 0.3);

    _id_7D2852D02216C876 = _id_215866EE17ECD840(_id_29C381EB09171E93.origin, undefined, 1200);
    _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_58ADBFCA23D5372B, 0.2);
  } else {
    speakers = level.players;
    _id_7D2852D02216C876 = _id_215866EE17ECD840(_id_29C381EB09171E93.origin, undefined, 1200);
    _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_BE3E67903AA0B19F);
    _id_7D2852D02216C876 = _id_AA8653DEA5520361(10, scripts\engine\utility::array_combine([_id_7D2852D02216C876], scripts\engine\utility::array_remove(speakers, _id_7D2852D02216C876)));
    _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_5086753382CF603A, 0.3);
    _id_7D2852D02216C876 = _id_215866EE17ECD840(_id_29C381EB09171E93.origin, undefined, 1200);
    _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_58ADBFCA23D5372B, 0.2);
  }

  player = _id_B826409EE2EFF7B6(1620);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_deadend";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_nowayoutuphere";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_noexitthisway";
  _id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_7D2179D71A41F0C3() {
  _id_95054CC84B605A21 = getEnt("watermaze_hint_pistols", "targetname");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_lasw_bravo6watcher1";
  aliases[aliases.size] = "dx_cp_cpr1_maze_lasw_ididsomedigging";
  aliases[aliases.size] = "dx_cp_cpr1_maze_lasw_thatbasecouldbeparto";
  aliases[aliases.size] = "dx_cp_cpr1_maze_lasw_theywerebuilttodevel";
  aliases[aliases.size] = "dx_cp_cpr1_maze_lasw_ifaqistherewehaveamu";

  for(;;) {
    _id_95054CC84B605A21 waittill("trigger", player);

    if(isPlayer(player)) {
      break;
    }
  }

  foreach(alias in aliases) {
    level _id_18AF78602B67B70C::_id_775CD164C569E279(alias);
    wait(randomfloatrange(0.7, 2.0));
  }
}

_id_550A4455B981180C() {
  level endon("game_ended");
  scripts\engine\utility::flag_set("elevator_trip_active");
  _id_8C4F97DFD1B00408 = getEnt("elevator", "script_noteworthy");
  _id_92A922B82C71C6DA = self.origin;
  self waittill("trigger", player);

  if(isDefined(_id_8C4F97DFD1B00408)) {
    if(distance2d(_id_92A922B82C71C6DA, _id_8C4F97DFD1B00408.origin) < 200) {
      scripts\engine\utility::flag_clear("elevator_trip_active");
      level._id_6E21B75958471FCC = player;
    }
  }
}

_id_CB0134F9E5CA5411() {
  _id_8C4F97DFD1B00408 = getEnt("elevator", "script_noteworthy");

  for(;;) {
    _id_8C4F97DFD1B00408 waittill("trigger", player);

    if(isPlayer(player)) {
      break;
    }
  }

  player = _id_B826409EE2EFF7B6(1370, [player]);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_foundanelevatorshaft";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_ifoundanelevatorshaf";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_locatedanelevatorsha";
  _id_A606867D80CFABD5(player, aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_aqsgotitrigged";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_therearetripwires";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_aqandtheirbloodytrap";
  _id_7D2852D02216C876 = _id_43D8FA96ACF30CA8(_id_8C4F97DFD1B00408.origin);

  if(scripts\engine\utility::flag("elevator_trip_active")) {
    if(_id_7D2852D02216C876 == player)
      wait 0.3;

    _id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.5);
    thread _id_5B458CEEE7E61D1C();
  } else if(isDefined(level._id_6E21B75958471FCC)) {
    aliases = [];
    aliases[aliases.size] = "dx_cp_cpr1_maze_pric_disarmedthetrap";
    aliases[aliases.size] = "dx_cp_cpr1_maze_fara_thetrapsdisarmed";
    aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_trapsdisarmedweregoo";
    _id_7D2852D02216C876 = level._id_6E21B75958471FCC;

    if(isPlayer(_id_7D2852D02216C876))
      _id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.5);
  }

  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_noaccesspointsinhere";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_theresnoexithere";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_cantexitthroughhere";
  _id_ACD1BB3316B5C68B = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_wellsearchthedrinkan";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_thenwesearchthewater";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_letscrackonthen";
  _id_DA42F9F6AEA7A468 = aliases;
  wait 12;
  level notify("leave_elevator");

  if(scripts\cp\utility::getplayersinradius(_id_8C4F97DFD1B00408.origin, 500).size >= level.players.size - 1) {
    _id_7D2852D02216C876 = _id_215866EE17ECD840(_id_8C4F97DFD1B00408.origin, undefined, 500);
    _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_ACD1BB3316B5C68B);
    _id_795EC7CD59ADF26D = scripts\engine\utility::array_combine(scripts\engine\utility::array_remove(level.players, _id_7D2852D02216C876), [_id_7D2852D02216C876]);
    _id_7D2852D02216C876 = _id_88BC9CD1FFAB6FEF(_id_8C4F97DFD1B00408.origin, 7, _id_795EC7CD59ADF26D, 500);
    wait 0.5;

    if(isDefined(_id_7D2852D02216C876))
      _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_DA42F9F6AEA7A468, 0.2);
  }
}

_id_5B458CEEE7E61D1C() {
  level endon("leave_elevator");

  while(!isDefined(level._id_6E21B75958471FCC))
    waitframe();

  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_maze_pric_disarmedthetrap";
  aliases[aliases.size] = "dx_cp_cpr1_maze_fara_thetrapsdisarmed";
  aliases[aliases.size] = "dx_cp_cpr1_maze_gazz_trapsdisarmedweregoo";
  _id_7D2852D02216C876 = level._id_6E21B75958471FCC;

  if(isPlayer(_id_7D2852D02216C876)) {
    if(_id_7D2852D02216C876 _meth_6F55D55CCFF20D14())
      _id_9A835763C929EB24(_id_7D2852D02216C876, 10);

    _id_A606867D80CFABD5(_id_7D2852D02216C876, aliases);
  }
}

_id_74FEF0D96F450853(name, radius) {
  level endon("game_ended");
  struct = scripts\engine\utility::getStruct(name, "targetname");
  _id_1A96B3062BB2C598 = radius * radius;

  while(!scripts\cp\utility::any_player_nearby(struct.origin, _id_1A96B3062BB2C598))
    wait 1;

  _id_1869B3EC9EE075F7 = getEnt("cave_start", "script_noteworthy");
  origin = (-1893, 11977, 1049);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_theseareaqtunnels";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_theseareaqtunnels";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_theseareaqtunnels";
  dist = distance(origin, _id_1869B3EC9EE075F7.origin);

  while(!scripts\cp\utility::any_player_nearby(_id_1869B3EC9EE075F7.origin, dist * dist))
    wait 0.25;

  scripts\engine\utility::flag_set("vo_cave_triggered");
  level._id_7CAA8AB2F4145CFA = "mx_cp_raid1_puzzleoneshots";
  setmusicstate(level._id_7CAA8AB2F4145CFA);
  speakers = scripts\cp\utility::getplayersinradius(_id_1869B3EC9EE075F7.origin, dist + 500);

  if(isDefined(level.farah))
    _id_7D2852D02216C876 = _id_AA8653DEA5520361(undefined, scripts\engine\utility::array_combine([level.farah], scripts\engine\utility::array_remove(speakers, level.farah)));
  else
    _id_7D2852D02216C876 = _id_AA8653DEA5520361(undefined, speakers);

  _id_A606867D80CFABD5(_id_7D2852D02216C876, aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_theyknewwheretolook";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_theyknewwheretolook";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_theyknewwheretolook";
  wait 0.3;
  speakers = scripts\cp\utility::getplayersinradius(_id_1869B3EC9EE075F7.origin, dist + 500);
  _id_466744BDE443021B = _id_AA8653DEA5520361(10, scripts\engine\utility::array_combine(scripts\engine\utility::array_remove(speakers, _id_7D2852D02216C876), [_id_7D2852D02216C876]));
  _id_A606867D80CFABD5(_id_466744BDE443021B, aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_someoneshelpingthem";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_someoneishelpingthem";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_someoneshelpingthem";
  wait 0.45;

  if(level.players.size == 3) {
    _id_31DF9B697450141C = level.players;
    _id_31DF9B697450141C = scripts\engine\utility::array_remove_array(_id_31DF9B697450141C, [_id_7D2852D02216C876, _id_466744BDE443021B]);
    _id_7D2852D02216C876 = _id_AA8653DEA5520361(10, scripts\engine\utility::array_combine(_id_31DF9B697450141C, [_id_7D2852D02216C876, _id_466744BDE443021B]));
  } else
    _id_7D2852D02216C876 = _id_AA8653DEA5520361(10, scripts\engine\utility::array_combine(scripts\engine\utility::array_remove(speakers, _id_466744BDE443021B), [_id_466744BDE443021B]));

  _id_A606867D80CFABD5(_id_7D2852D02216C876, aliases);
  thread _id_F950924159350CF0(_id_1869B3EC9EE075F7.origin);
  origin = (-697, 11697, 1036);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_findanything";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_isthereapath";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_gotanything";
  _id_72DB12D2CB004D10 = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_negativeadeadend";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_theresnothing";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_negativenothingoverh";
  _id_7333B1BC131A3F88 = aliases;
  _id_7D2852D02216C876 = _id_71FC89B3E8140B4B([origin], 80)[0];
  scripts\engine\utility::flag_set("player_near_cave_end");
  players = level.players;
  _id_D39A15B9327D0EEF = _id_43D8FA96ACF30CA8(origin, 10, scripts\engine\utility::array_add(scripts\engine\utility::array_remove(players, _id_7D2852D02216C876), _id_7D2852D02216C876), 1100, 200);

  if(isDefined(_id_D39A15B9327D0EEF)) {
    _id_A606867D80CFABD5(_id_D39A15B9327D0EEF, _id_72DB12D2CB004D10, 0.5);

    if(isDefined(_id_7D2852D02216C876))
      _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_7333B1BC131A3F88, 0.6);
  }
}

_id_F950924159350CF0(origin) {
  if(level.players.size == 1) {
    return;
  }
  wait 5;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_wellhavetojump";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_weneedtojump";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_lookslikewerejumping";
  _id_F028E45D40CED68B = scripts\cp\utility::getplayersinradius(origin, 530);

  if(!scripts\engine\utility::flag("player_near_cave_end") && _id_F028E45D40CED68B.size >= level.players.size - 1) {
    foreach(player in level.players) {
      if(player.origin[2] < 970)
        _id_F028E45D40CED68B = scripts\engine\utility::array_remove(_id_F028E45D40CED68B, player);
    }

    _id_7D2852D02216C876 = _id_A9D9C0245997A414(4, _id_F028E45D40CED68B);
    _id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);
  }
}

_id_84977F380F37AA5B(name, radius) {
  level endon("game_ended");
  _id_7B7E7A91689B9DA2 = getEnt(name, "script_noteworthy");
  _id_1A96B3062BB2C598 = radius * radius;

  while(!scripts\cp\utility::any_player_nearby(_id_7B7E7A91689B9DA2.origin, _id_1A96B3062BB2C598))
    wait 1;

  childthread _id_FCE7C07A404C7C61();
  childthread _id_453EFBA9058A5A61();
  childthread _id_683A95A448F89F4D();
  childthread _id_21CFC737A3D30F15();
  childthread _id_DAD52271C8C095CE();
}

_id_FCE7C07A404C7C61() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_itsclear";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_nothreatswereclear";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_allclear";
  _id_4FC32F0B4FE4A4C6 = aliases;
  _id_7B7E7A91689B9DA2 = getEnt("generator_room", "script_noteworthy");
  _id_7B7E7A91689B9DA2 waittill("trigger", player);
  wait 1.5;
  level._id_7CAA8AB2F4145CFA = "mx_cp_raid1_puzzle3";
  setmusicstate(level._id_7CAA8AB2F4145CFA);
  _id_7D2852D02216C876 = _id_43D8FA96ACF30CA8(player.origin, 30, scripts\engine\utility::array_combine([player], scripts\engine\utility::array_remove(level.players, player)), 400);
  _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_4FC32F0B4FE4A4C6, 0.3);
}

_id_21CFC737A3D30F15() {
  origin = (-2118, 9293, 526);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_armo_pric_foundanotherbutton";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_theresabutton";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_theresabutton";
  _id_A0EA3093E83AC848 = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_thewiresleadtoacontr";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_thegeneratorpowersac";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_foundacontrolbuttont";
  _id_32BA148E0D85A888 = aliases;
  player = _id_5BC7A5C4437D3803(origin, 0.8, 0.3, undefined, undefined, 200)[0];
  scripts\engine\utility::flag_set("vo_seen_button");

  if(scripts\engine\utility::flag("vo_seen_gen")) {
    _id_9A835763C929EB24(player, 15);
    _id_A606867D80CFABD5(player, _id_32BA148E0D85A888, 0.5);
  } else {
    _id_9A835763C929EB24(player, 15);
    _id_A606867D80CFABD5(player, _id_A0EA3093E83AC848, 0.5);
  }
}

_id_453EFBA9058A5A61() {
  _id_893740CDAA5F597C = scripts\engine\utility::getStruct("maze_gas_interact", "targetname");
  level._id_FBA07A0138CBB04C = _id_893740CDAA5F597C.origin;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_generatorhere";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_foundagenerator";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_theresagenerator";
  _id_D663B5A75E0277A1 = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_somethingneedspower";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_weneedtofindwhatitsp";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_itspoweringsomething";
  _id_10EAEFBAA882E07E = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_followthewires";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_followthewires";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_followthewires";
  _id_37B3AF60F421687D = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_seeifitopensthatdoor";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_itcouldopenthedoor";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_guessingthatopensthe";
  open_door = aliases;
  player = _id_5BC7A5C4437D3803(_id_893740CDAA5F597C.origin, 0.98, 0.8, undefined, undefined, 200)[0];
  scripts\engine\utility::flag_set("vo_seen_gen");
  players_in_range = scripts\cp\utility::getplayersinradius(_id_893740CDAA5F597C.origin, 600);
  _id_7D2852D02216C876 = _id_AA8653DEA5520361(15, scripts\engine\utility::array_combine([player], scripts\engine\utility::array_remove(players_in_range, player)));
  _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_D663B5A75E0277A1, 0.3);

  if(!scripts\engine\utility::flag("vo_seen_button") && !scripts\engine\utility::flag("vo_seen_door")) {
    _id_7D2852D02216C876 = _id_AA8653DEA5520361(15, scripts\engine\utility::array_add(scripts\engine\utility::array_remove(level.players, _id_7D2852D02216C876), _id_7D2852D02216C876));
    _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_10EAEFBAA882E07E, 0.4);
    _id_7D2852D02216C876 = _id_AA8653DEA5520361(15, scripts\engine\utility::array_add(scripts\engine\utility::array_remove(level.players, _id_7D2852D02216C876), _id_7D2852D02216C876));
    _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_37B3AF60F421687D, 0.35);
  } else if(scripts\engine\utility::flag("vo_seen_door")) {
    _id_7D2852D02216C876 = _id_AA8653DEA5520361(15, scripts\engine\utility::array_add(scripts\engine\utility::array_remove(level.players, _id_7D2852D02216C876), _id_7D2852D02216C876));
    _id_A606867D80CFABD5(_id_7D2852D02216C876, open_door, 0.4);
  }

  childthread _id_F803DAB8C3C53594();
}

_id_683A95A448F89F4D() {
  door_ent = getEnt("ending_puzzle_door", "script_noteworthy");
  _id_4EACCEAD759685D0 = door_ent.origin;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_gotadoorunderwater";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_theresadoorunderthew";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_foundadoordownthere";
  _id_29026875611B1B94 = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_letsfindawaytoopenit";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_lookforawaytoopenit";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_letsfindawaytogetito";
  _id_5ADC4F5B07D9D553 = aliases;
  player = _id_5BC7A5C4437D3803(_id_4EACCEAD759685D0, 0.98, undefined, undefined, undefined, 225)[0];
  scripts\engine\utility::flag_set("vo_seen_door");
  _id_7D2852D02216C876 = _id_9A835763C929EB24(player, 50);

  if(_id_65383A3130460A08(_id_7D2852D02216C876)) {
    return;
  }
  if(isDefined(_id_7D2852D02216C876))
    _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_29026875611B1B94, 0.4);

  if(isDefined(_id_7D2852D02216C876))
    _id_7D2852D02216C876 = _id_AA8653DEA5520361(5, scripts\engine\utility::array_add(scripts\engine\utility::array_remove(level.players, _id_7D2852D02216C876), _id_7D2852D02216C876));
  else
    _id_7D2852D02216C876 = _id_AA8653DEA5520361(5, level.players);

  _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_5ADC4F5B07D9D553, 0.2);
}

_id_9DFDAD79E177BA83(player) {
  level endon("game_ended");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_generatorson";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_itson";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_generatorsrunning";
  _id_AE84EC1698A220EB = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_hitthebutton";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_usethebutton";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_pressthebutton";
  _id_5FCD3DB7ECF0EE69 = aliases;
  scripts\engine\utility::flag_set("used_gen");
  wait 0.5;
  _id_A606867D80CFABD5(player, _id_AE84EC1698A220EB);
  door = getEnt("ending_puzzle_door", "script_noteworthy");

  if(scripts\engine\utility::flag("vo_seen_button")) {
    _id_87DEE739BF4C5F18 = _id_217790A42F0EE1BD(2);

    if(isDefined(player) && !istrue(_id_87DEE739BF4C5F18))
      _id_A606867D80CFABD5(player, _id_5FCD3DB7ECF0EE69);
  }
}

_id_217790A42F0EE1BD(timeout) {
  _id_5AC49E018B46B2CD = scripts\engine\utility::getStruct("2man_out_maze", "targetname");
  _id_20F3271DC43A6012 = scripts\engine\utility::getStruct("2man_master_maze", "targetname");
  _id_829451E7760D460B = scripts\cp\utility::give_closest_player_nearby(_id_5AC49E018B46B2CD.origin, 40000);
  _id_974F2F99DF43A8AC = scripts\cp\utility::give_closest_player_nearby(_id_20F3271DC43A6012.origin, 40000);
  starttime = gettime();

  while(!scripts\engine\utility::time_has_passed(starttime, timeout)) {
    waitframe();

    if(!isDefined(_id_829451E7760D460B) && !isDefined(_id_974F2F99DF43A8AC))
      return 0;

    if(isDefined(_id_829451E7760D460B)) {
      if(isDefined(_id_829451E7760D460B._id_EB8EE2C6D463E28F)) {
        if(istrue(_id_829451E7760D460B._id_EB8EE2C6D463E28F))
          return 1;
      }
    } else if(isDefined(_id_974F2F99DF43A8AC)) {
      if(isDefined(_id_974F2F99DF43A8AC._id_EB8EE2C6D463E28F)) {
        if(istrue(_id_974F2F99DF43A8AC._id_EB8EE2C6D463E28F))
          return 1;
      }
    }
  }

  return 0;
}

_id_65383A3130460A08(player) {
  door_ent = getEnt("ending_puzzle_door", "script_noteworthy");
  _id_C3B57ADA9429AE15 = vectorNormalize(anglestoleft(door_ent.angles));

  if(vectordot(player.origin - door_ent.origin, _id_C3B57ADA9429AE15) < 0)
    return 1;

  return 0;
}

_id_9FD63FE067555F38() {
  door_ent = getEnt("ending_puzzle_door", "script_noteworthy");
  _id_C3B57ADA9429AE15 = vectorNormalize(anglestoleft(door_ent.angles));

  foreach(player in level.players) {
    if(vectordot(player.origin - door_ent.origin, _id_C3B57ADA9429AE15) < 0)
      return 1;
  }

  return 0;
}

_id_DAD52271C8C095CE() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_imlockedout";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_icantgetthrough";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_icantopenitfromhere";
  _id_C821EBC3A8D00C24 = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_youllhavetofindawayt";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_seeiftheresawaytoope";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_lookforaswitchonyour";
  _id_EA746417DC0495C3 = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_lookingforaswitch";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_wellfindtheswitch";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_welllocatetheswitch";
  _id_6AF205CA01F14A83 = aliases;
  door_ent = getEnt("ending_puzzle_door", "script_noteworthy");
  _id_30DB7529489C4C58 = [];
  _id_FDAB4F721CFDB0FE = [];
  _id_C3B57ADA9429AE15 = vectorNormalize(anglestoleft(door_ent.angles));
  level waittill("used_gen");

  for(;;) {
    wait 2;
    _id_30DB7529489C4C58 = [];
    _id_FDAB4F721CFDB0FE = [];

    foreach(player in level.players) {
      if(vectordot(player.origin - door_ent.origin, _id_C3B57ADA9429AE15) > 0) {
        _id_30DB7529489C4C58 = scripts\engine\utility::array_add(_id_30DB7529489C4C58, player);
        continue;
      }

      _id_FDAB4F721CFDB0FE = scripts\engine\utility::array_add(_id_FDAB4F721CFDB0FE, player);
    }

    if(_id_FDAB4F721CFDB0FE.size >= 1 && _id_30DB7529489C4C58.size == 1) {
      break;
    }

    if(_id_FDAB4F721CFDB0FE.size >= level.players.size)
      return;
  }

  _id_D105741F9F9D32CB = _id_A9D9C0245997A414(10, _id_30DB7529489C4C58);
  _id_A606867D80CFABD5(_id_D105741F9F9D32CB, _id_C821EBC3A8D00C24, 0.4);
  wait 1;

  if(_id_6B80A21EDCF9D296(_id_D105741F9F9D32CB))
    _id_A606867D80CFABD5(_id_D105741F9F9D32CB, _id_EA746417DC0495C3, 0.4);

  _id_20F3271DC43A6012 = scripts\engine\utility::getStruct("2man_master_maze", "targetname");
  _id_974F2F99DF43A8AC = scripts\cp\utility::give_closest_player_nearby(_id_20F3271DC43A6012.origin, 40000);
  _id_7D2852D02216C876 = _id_A9D9C0245997A414(10, _id_FDAB4F721CFDB0FE);

  if(!isDefined(_id_974F2F99DF43A8AC))
    _id_A606867D80CFABD5(_id_7D2852D02216C876, _id_6AF205CA01F14A83, 0.3);

  if(_id_6B80A21EDCF9D296(_id_7D2852D02216C876) && isDefined(_id_D105741F9F9D32CB)) {
    if(_id_D105741F9F9D32CB._id_938E8B2CA6549759 == "price") {
      if(_id_7D2852D02216C876._id_938E8B2CA6549759 == "farah")
        _id_7D2852D02216C876 _id_5D265B4FCA61F070::say("dx_cp_cpr1_mzmd_fara_standbycaptain");
      else if(_id_7D2852D02216C876._id_938E8B2CA6549759 == "gaz")
        _id_7D2852D02216C876 _id_5D265B4FCA61F070::say("dx_cp_cpr1_mzmd_gazz_sittightcapn");
    }

    if(_id_D105741F9F9D32CB._id_938E8B2CA6549759 == "farah") {
      if(_id_7D2852D02216C876._id_938E8B2CA6549759 == "price")
        _id_7D2852D02216C876 _id_5D265B4FCA61F070::say("dx_cp_cpr1_mzmd_pric_wellgetyouthroughfar");
      else if(_id_7D2852D02216C876._id_938E8B2CA6549759 == "gaz")
        _id_7D2852D02216C876 _id_5D265B4FCA61F070::say("dx_cp_cpr1_mzmd_gazz_sittightfarah");
    }

    if(_id_D105741F9F9D32CB._id_938E8B2CA6549759 == "gaz") {
      if(_id_7D2852D02216C876._id_938E8B2CA6549759 == "price")
        _id_7D2852D02216C876 _id_5D265B4FCA61F070::say("dx_cp_cpr1_mzmd_pric_wellgetyouthroughgaz");
      else if(_id_7D2852D02216C876._id_938E8B2CA6549759 == "farah")
        _id_7D2852D02216C876 _id_5D265B4FCA61F070::say("dx_cp_cpr1_mzmd_fara_standbygaz");
    }
  }
}

_id_F803DAB8C3C53594() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_cantdothiswithjustus";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_weneedanothertogetth";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_wecantdothisalone";
  _id_39A50172DC068F7D = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_pric_thisisntaonemanjob";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_fara_cantgetpastthisonmyo";
  aliases[aliases.size] = "dx_cp_cpr1_mzmd_gazz_cantdothisalone";
  _id_1A2C1AED60B2A7F3 = aliases;

  if(level.players.size == 1)
    _id_A606867D80CFABD5(level.players[0], _id_1A2C1AED60B2A7F3, 0.4);
}

_id_72D2B5997DCD8691() {
  level endon("game_ended");
  scripts\cp\utility::battlechatter_off();
  _id_AAAC59E1222BB635();
  _id_9B545A680D261633();
  thread _id_14BFE5EBC36507BA();
}

_id_AAAC59E1222BB635() {
  while(!isDefined(level._id_5BF7305A7B90D2F2))
    wait 0.1;

  wait 2;

  foreach(enemy in level._id_5BF7305A7B90D2F2.ai_spawned) {
    enemy endon("stealth_combat");
    enemy endon("death");
  }

  _id_90465AE4437C9ABA = level._id_5BF7305A7B90D2F2.ai_spawned[0];
  _id_904659E4437C9887 = level._id_5BF7305A7B90D2F2.ai_spawned[1];
  _id_90465AE4437C9ABA _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0, "dx_cp_cpr1_armo_aqs1_didhebreak");
  _id_904659E4437C9887 _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.6, "dx_cp_cpr1_armo_aqs2_notawordjustkeptspit");
  _id_90465AE4437C9ABA _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.4, "dx_cp_cpr1_armo_aqs1_animals");
  _id_904659E4437C9887 _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(1, "dx_cp_cpr1_armo_aqs2_somearestillloose");
  childthread _id_ABD1E2C0BE1777B5();
  _id_90465AE4437C9ABA _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.4, "dx_cp_cpr1_armo_aqs1_howdoyouknowthat");
  _id_904659E4437C9887 _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.6, "dx_cp_cpr1_armo_aqs2_theywereprotectingso");
}

_id_ABD1E2C0BE1777B5() {
  aliases = [];
  aliases[aliases.size] = [level.price, "dx_cp_cpr1_armo_pric_getthisroomsecure"];
  aliases[aliases.size] = [level.farah, "dx_cp_cpr1_armo_fara_moreaq"];
  aliases[aliases.size] = [level._id_E0632103DFA5BB19, "dx_cp_cpr1_armo_gazz_securetheroom"];
  nags = scripts\engine\utility::create_deck(aliases, 1, 1);
  _id_5D265B4FCA61F070::nag_wait("vo_armory_guards_dead", nags, _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(3, 30, 3));
}

_id_9B545A680D261633() {
  level endon("armory_gate_opened");

  if(!isDefined(level._id_5BF7305A7B90D2F2)) {
    return;
  }
  scripts\engine\utility::flag_init("vo_armory_guards_dead");

  while(level._id_5BF7305A7B90D2F2.activecount > 0)
    wait 0.1;

  scripts\engine\utility::flag_set("vo_armory_guards_dead");
  aliases = ["dx_cp_cpr1_armo_pric_clear", "dx_cp_cpr1_armo_fara_wereclear", "dx_cp_cpr1_armo_gazz_secure"];
  player = _id_A9D9C0245997A414();
  _id_A606867D80CFABD5(player, aliases, 2.5);
  _id_4015264BCA561349();
  childthread _id_2384014CA13951FA();
  childthread _id_4056EF9256FF4B97();
}

_id_4015264BCA561349() {
  aliases = ["dx_cp_cpr1_armo_pric_watcher1bravo6howcop", "dx_cp_cpr1_armo_fara_watcher1kilo01commsc", "dx_cp_cpr1_armo_gazz_watcher1bravo61doyou"];
  player = _id_A9D9C0245997A414();
  _id_A606867D80CFABD5(player, aliases, 2, 1);
  _id_07C18CE3017436A3(player);
}

_id_07C18CE3017436A3(_id_019E48BF497DBA22) {
  wait 0.5;
  _id_166B4F052DA169A7::_id_775CD164C569E279("dx_cp_cpr1_armo_lasw_thiwatchnegyourlasts");

  if(level.players.size == 1) {
    aliases = ["dx_cp_cpr1_armo_pric_losingcomms", "dx_cp_cpr1_armo_fara_losingcomms", "dx_cp_cpr1_armo_gazz_losingcomms"];
    player = _id_A9D9C0245997A414();
    _id_A606867D80CFABD5(player, aliases, 1, 1);
  } else {
    aliases = ["dx_cp_cpr1_armo_pric_welllosecommsifwekee", "dx_cp_cpr1_armo_fara_ifwekeepgoingwelosec", "dx_cp_cpr1_armo_gazz_werelosingcommswellg"];
    speakers = scripts\engine\utility::array_remove(level.players, _id_019E48BF497DBA22);
    player = _id_A9D9C0245997A414(1, speakers);
    result = _id_A606867D80CFABD5(player, aliases, 1, 1);

    if(result == 0) {
      player = _id_A9D9C0245997A414();
      result = _id_A606867D80CFABD5(player, aliases, 1, 1);
    }

    if(isDefined(level.farah)) {
      result = _id_A606867D80CFABD5(level.farah, "dx_cp_cpr1_armo_fara_iwillnotabandonmytea", 0.75, 1);

      if(result && isDefined(level.price))
        _id_A606867D80CFABD5(level.price, "dx_cp_cpr1_armo_pric_ourfriendsareinhellr", 0.6, 1);
    } else {
      aliases = ["dx_cp_cpr1_armo_pric_cantabandonfarahstea", "dx_cp_cpr1_armo_gazz_cantabandonfarahstea"];
      player = _id_A9D9C0245997A414();
      _id_A606867D80CFABD5(player, aliases, 0.75, 1);
    }
  }

  if(isDefined(level._id_E0632103DFA5BB19))
    _id_A606867D80CFABD5(level._id_E0632103DFA5BB19, "dx_cp_cpr1_armo_gazz_letsgearupwhilewecan", 0.9, 1);
}

_id_4056EF9256FF4B97() {
  aliases = [];

  if(isDefined(level.price))
    aliases[aliases.size] = [level.price, "dx_cp_cpr1_armo_pric_topoffyourammograban"];

  if(isDefined(level.farah))
    aliases[aliases.size] = [level.farah, "dx_cp_cpr1_armo_fara_grabweaponsandequipm"];

  if(isDefined(level.price) || isDefined(level.farah)) {
    nags = scripts\engine\utility::create_deck(aliases, 1, 1);
    _id_5D265B4FCA61F070::nag_wait("armory_gate_opened", nags, _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(20, 70, 3));
  }
}

_id_2384014CA13951FA() {
  level endon("armory_gate_opened");

  foreach(player in level.players)
  player childthread _id_5755B2FFC543A575();
}

_id_41EF4CE6EE43742D() {
  self endon("death_or_disconnect");
  self endon("vo_armory_regear");
  _id_F300544DAAAB28D6 = self.primaryweapon;

  while(!isDefined(_id_F300544DAAAB28D6)) {
    _id_F300544DAAAB28D6 = self.primaryweapon;
    wait 0.25;
  }

  for(;;) {
    if(isDefined(self.primaryweapon) && isDefined(_id_F300544DAAAB28D6)) {
      if(self.primaryweapon != _id_F300544DAAAB28D6) {
        break;
      }
    }

    wait 0.25;
  }

  if(issubstr(self.primaryweapon.basename, "sh"))
    _id_39355723B485D0F9();
  else
    _id_996427FBF05B012C();
}

_id_5755B2FFC543A575() {
  self endon("death_or_disconnect");
  self endon("vo_armory_regear");
  _id_94C9FB0BC9232353 = self getweaponslistprimaries();
  self waittill("ammo_update");
  _id_1523BE422E863FFE = _id_78542EE6CB1C63DD(_id_94C9FB0BC9232353);

  if(_id_1523BE422E863FFE.size > 1) {
    foreach(weapon in _id_1523BE422E863FFE) {
      if(_id_D09E485FF85BAB8C(weapon)) {
        _id_39355723B485D0F9();
        return;
      }
    }

    _id_996427FBF05B012C();
  } else
    _id_003DFCFC41876CC3();
}

_id_78542EE6CB1C63DD(_id_94C9FB0BC9232353) {
  _id_1523BE422E863FFE = [];
  _id_849C1DF4114E0A37 = self getweaponslistprimaries();

  foreach(weapon in _id_849C1DF4114E0A37) {
    _id_AC0E5C4AC96AAA41 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_94C9FB0BC9232353.size; _id_AC0E594AC96AA3A8++) {
      if(weaponclass(weapon.basename) == weaponclass(_id_94C9FB0BC9232353[_id_AC0E594AC96AA3A8].basename)) {
        break;
      } else
        _id_AC0E5C4AC96AAA41++;
    }

    if(_id_AC0E5C4AC96AAA41 >= _id_94C9FB0BC9232353.size)
      _id_1523BE422E863FFE[_id_1523BE422E863FFE.size] = weapon;
  }

  return _id_1523BE422E863FFE;
}

_id_D09E485FF85BAB8C(weapon) {
  if(weaponclass(weapon.basename) == "shotgun")
    return 1;

  return 0;
}

_id_2CE96B2D08468C9E() {
  self endon("death_or_disconnect");
  self endon("vo_armory_regear");
  self waittill("ammo_update");
}

_id_996427FBF05B012C() {
  aliases = ["dx_cp_cpr1_armo_pric_thatlldoit", "dx_cp_cpr1_armo_fara_notbad", "dx_cp_cpr1_armo_gazz_icanworkwiththis"];
  result = _id_A606867D80CFABD5(self, aliases, 0.5);

  if(result)
    self notify("vo_armory_regear");
}

_id_39355723B485D0F9() {
  aliases = ["dx_cp_cpr1_armo_pric_iliketokeepthisforcl", "dx_cp_cpr1_armo_fara_iliketokeepthisforcl", "dx_cp_cpr1_armo_gazz_iliketokeepthisforcl"];
  result = _id_A606867D80CFABD5(self, aliases, 0.5);

  if(result) {
    _id_89362D9B68B55EA9 = [];

    foreach(player in level.players) {
      if(player != self)
        _id_89362D9B68B55EA9[_id_89362D9B68B55EA9.size] = player;
    }

    aliases = ["dx_cp_cpr1_armo_pric_tooright", "dx_cp_cpr1_armo_fara_allday", "dx_cp_cpr1_armo_gazz_tooright"];
    player = _id_6B2A1B9750071995(_id_89362D9B68B55EA9);
    result = _id_A606867D80CFABD5(self, aliases, 0.6);

    if(result)
      self notify("vo_armory_regear");
  }
}

_id_003DFCFC41876CC3() {
  aliases = ["dx_cp_cpr1_armo_pric_thatstheway", "dx_cp_cpr1_armo_fara_goodshit", "dx_cp_cpr1_armo_gazz_brilliant"];
  result = _id_A606867D80CFABD5(self, aliases, 0.5);

  if(result)
    self notify("vo_armory_regear");
}

_id_14BFE5EBC36507BA() {
  level endon("vo_player_in_armory_vents");
  _id_C5D3D8FF129F88BA = getEnt("armory_keypad", "script_noteworthy");
  player = _id_5BC7A5C4437D3803(_id_C5D3D8FF129F88BA.origin + (130, -7, 10), 0.8, undefined, undefined, undefined, 150)[0];
  aliases = ["dx_cp_cpr1_armo_pric_foundamarkinghere", "dx_cp_cpr1_armo_fara_lookalexleftthis", "dx_cp_cpr1_armo_gazz_lookere31itsfromalex"];
  result = _id_A606867D80CFABD5(player, aliases, 0.5);

  if(result) {
    if(isDefined(level.price))
      _id_A606867D80CFABD5(level.price, "dx_cp_cpr1_armo_pric_attaboyalex", 0.8);
  }
}

_id_52CE5631A404B7E2() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("armory_gate_opened");
  childthread _id_8424090260DF5158();
  childthread _id_A9DE6DEF0837E2D7();
  _id_2C1824E345806E61 = level._id_4739CCC734313EC0.origin;
  scripts\engine\utility::flag_wait("armory_button_pressed");
  _id_1DD46684CC487D58();
  childthread _id_2D0D9D2F108BAA15();
  childthread _id_A34028DC4352CA03(_id_2C1824E345806E61);
  childthread _id_4D8098D13B4C41C9(_id_2C1824E345806E61);
  scripts\engine\utility::flag_init("vo_player_in_armory_vents");
  _id_08F8ACAAEBAF248D(_id_2C1824E345806E61);
  _id_08969D89AAF527FE(_id_2C1824E345806E61);
}

_id_8424090260DF5158() {
  while(level._id_3E40D3C71E631A6F.activecount > 0)
    wait 0.1;

  enemies = getaiarray("axis");
  enemies = scripts\engine\utility::array_removedead_or_dying(enemies);
  _id_E21279FA90BDF012 = undefined;

  foreach(guy in enemies) {
    if(guy.agent_type == "actor_enemy_cp_jugg_aq")
      _id_E21279FA90BDF012 = guy;
  }

  while(isalive(_id_E21279FA90BDF012))
    wait 0.5;

  wait 3;

  if(_id_6B80A21EDCF9D296(level._id_E0632103DFA5BB19))
    level._id_E0632103DFA5BB19 _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(1, "dx_cp_cpr1_armo_gazz_clear");

  if(_id_6B80A21EDCF9D296(level.price))
    level.price _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(1, "dx_cp_cpr1_armo_pric_checkthedoors");
}

_id_9CE3A54106B97F35() {
  level endon("vo_player_in_armory_vents");
  self endon("death_or_disconnect");

  if(isDefined(self._id_3F2C4CC0E2A25500)) {
    return;
  }
  aliases = ["dx_cp_cpr1_armo_pric_locked", "dx_cp_cpr1_armo_fara_thisdoorslocked", "dx_cp_cpr1_armo_gazz_doorslocked"];
  _id_A606867D80CFABD5(self, aliases, 0.5);
  self._id_3F2C4CC0E2A25500 = 1;
}

_id_A9DE6DEF0837E2D7() {
  level endon("armory_button_pressed");
  player = _id_5BC7A5C4437D3803(level._id_4739CCC734313EC0, 0.85, undefined, undefined, undefined, 250)[0];
  aliases = ["dx_cp_cpr1_armo_pric_foundanotherbutton", "dx_cp_cpr1_armo_fara_theresabuttononthewa", "dx_cp_cpr1_armo_gazz_theresabuttonhere"];
  _id_A606867D80CFABD5(player, aliases, 0.25);
  wait 1;
  aliases = ["dx_cp_cpr1_mzmd_pric_hitthebutton", "dx_cp_cpr1_mzmd_fara_usethebutton", "dx_cp_cpr1_mzmd_gazz_pressthebutton"];
  speakers = scripts\engine\utility::array_remove(level.players, player);
  player = _id_A9D9C0245997A414(1, speakers);
  _id_A606867D80CFABD5(player, aliases, 0);
}

_id_1DD46684CC487D58() {
  level endon("game_ended");
  wait 2;

  while(level._id_3EC9FB0B6DB3F9F0.ai_spawned.size > 0)
    wait 1;

  while(level._id_82047D3399019BB8.ai_spawned.size > 0)
    wait 1;

  while(level._id_3E40D3C71E631A6F.ai_spawned.size > 0)
    wait 1;

  _id_A606867D80CFABD5(level.farah, "dx_cp_cpr1_armo_fara_clear", 2);
}

_id_2D0D9D2F108BAA15() {
  level endon("vo_player_in_armory_vents");
  doors = getentitylessscriptablearray("scriptable_scriptable_door_industrial_metal_mp_01", "classname");
  origins = [];

  foreach(door in doors)
  origins[origins.size] = door.origin;

  player = _id_5BC7A5C4437D3803(origins, 0.8, undefined, undefined, undefined, undefined, (0, 0, 32))[0];
  aliases = ["dx_cp_cpr1_armo_pric_thedoorsareopen", "dx_cp_cpr1_armo_fara_thedoorsareopennow", "dx_cp_cpr1_armo_gazz_doorsareopen"];
  _id_A606867D80CFABD5(player, aliases, 0);
}

_id_A34028DC4352CA03(_id_CDBB4A9588ABEF59) {
  level endon("vo_player_in_armory_vents");
  offset = (200, -800, -32);
  _id_2F38DABD01860335 = _id_CDBB4A9588ABEF59 + offset;
  threshold = 85;
  player = _id_76E9D4CB1F66793B(_id_2F38DABD01860335, threshold);
  aliases = ["dx_cp_cpr1_armo_pric_roomsclear", "dx_cp_cpr1_armo_fara_nothinginhere", "dx_cp_cpr1_armo_gazz_thisonesclear"];
  result = _id_A606867D80CFABD5(player, aliases, 0.5);
}

_id_4D8098D13B4C41C9(_id_2C1824E345806E61) {
  level endon("game_ended");
  level endon("vo_player_in_armory_vents");
  offset = (-625, 300, -32);
  threshold = 85;
  _id_2F38DABD01860335 = _id_2C1824E345806E61 + offset;
  _id_339169BF34EBA25E = [];

  while(_id_339169BF34EBA25E.size < 2) {
    _id_339169BF34EBA25E = [];

    foreach(player in level.players) {
      dist = distance2d(player.origin, _id_2F38DABD01860335);

      if(dist < threshold)
        _id_339169BF34EBA25E[_id_339169BF34EBA25E.size] = player;
    }

    wait 0.25;
  }

  if(isDefined(level.price) && _id_339169BF34EBA25E[0] == level.price) {
    if(isDefined(level.farah) && _id_339169BF34EBA25E[1] == level.farah)
      _id_B78CE3C10B8D63B4();
    else if(isDefined(level._id_E0632103DFA5BB19) && _id_339169BF34EBA25E[1] == level._id_E0632103DFA5BB19)
      _id_7977F663D5C3180E();
  } else if(isDefined(level._id_E0632103DFA5BB19) && _id_339169BF34EBA25E[0] == level._id_E0632103DFA5BB19) {
    if(isDefined(level.price) && _id_339169BF34EBA25E[1] == level.price)
      _id_7977F663D5C3180E();
    else if(isDefined(level.farah) && _id_339169BF34EBA25E[1] == level.farah)
      _id_772D26ED57A9DE9F();
  } else if(isDefined(level.farah) && _id_339169BF34EBA25E[0] == level.farah) {
    if(isDefined(level.price) && _id_339169BF34EBA25E[1] == level.price)
      _id_B78CE3C10B8D63B4();
    else if(isDefined(level._id_E0632103DFA5BB19) && _id_339169BF34EBA25E[1] == level._id_E0632103DFA5BB19)
      _id_772D26ED57A9DE9F();
  }
}

_id_B78CE3C10B8D63B4() {
  result = _id_A606867D80CFABD5(level.price, "dx_cp_cpr1_armo_pric_aqtookaprisoner", 0.5);

  if(result)
    result = _id_A606867D80CFABD5(level.farah, "dx_cp_cpr1_armo_fara_mysoldiersdownhereth", 0.6);

  _id_A606867D80CFABD5(level.price, "dx_cp_cpr1_armo_pric_theyrenotalone", 0.8);
}

_id_772D26ED57A9DE9F() {
  result = _id_A606867D80CFABD5(level.price, "dx_cp_cpr1_armo_gazz_aqtookaprisoner", 0.5);
  result = _id_A606867D80CFABD5(level.price, "dx_cp_cpr1_armo_gazz_theyputuponehellofaf", 0.6);

  if(result)
    result = _id_A606867D80CFABD5(level.farah, "dx_cp_cpr1_armo_fara_mysoldiersdownhereth", 0.6);

  _id_A606867D80CFABD5(level.price, "dx_cp_cpr1_armo_pric_theyrenotalone", 0.8);
}

_id_7977F663D5C3180E() {
  result = _id_A606867D80CFABD5(level.price, "dx_cp_cpr1_armo_pric_aqtookaprisoner", 0.5);
  result = _id_A606867D80CFABD5(level.price, "dx_cp_cpr1_armo_gazz_theyputuponehellofaf", 0.6);

  if(result)
    _id_A606867D80CFABD5(level.price, "dx_cp_cpr1_armo_pric_theyrenotalone", 0.8);
}

_id_08F8ACAAEBAF248D(_id_2C1824E345806E61) {
  offset = (-625, -260, -32);
  threshold = 85;
  player = _id_76E9D4CB1F66793B(_id_2C1824E345806E61 + offset, threshold);
  aliases = ["dx_cp_cpr1_armo_pric_theresapathhere", "dx_cp_cpr1_armo_fara_ifoundawaythrough", "dx_cp_cpr1_armo_gazz_gotapathhere"];
  _id_A606867D80CFABD5(player, aliases, 0);
  childthread _id_5EA8826345CE0535(_id_2C1824E345806E61 + offset);
}

_id_5EA8826345CE0535(position) {
  level endon("vo_player_in_armory_vents");
  player = undefined;
  aliases = ["dx_cp_cpr1_armo_pric_onme", "dx_cp_cpr1_armo_fara_thisway", "dx_cp_cpr1_armo_gazz_overere"];

  for(;;) {
    wait 10;
    player = _id_76E9D4CB1F66793B(position, 85);

    if(isDefined(player))
      _id_A606867D80CFABD5(player, aliases, 0);
  }
}

_id_08969D89AAF527FE(_id_2C1824E345806E61) {
  level endon("game_ended");
  _id_B92B2E2D2A7A155F = _id_2C1824E345806E61 + (-625, -260, -96);
  player = undefined;

  for(;;) {
    player = _id_3B46C8D1F1AE39D3(2, _id_B92B2E2D2A7A155F[2]);
    dist = distance2d(player.origin, _id_B92B2E2D2A7A155F);

    if(dist < 500) {
      break;
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set("vo_player_in_armory_vents");
  scripts\engine\utility::flag_init("vo_players_in_num");
  childthread _id_EEC42761D8935BC8(_id_B92B2E2D2A7A155F);
  childthread _id_2E3E4DDCE10DCA37(_id_B92B2E2D2A7A155F);
  childthread _id_D60713707C5344C3(_id_B92B2E2D2A7A155F);
  _id_B90931B0FEEE4020(_id_B92B2E2D2A7A155F);
}

_id_EEC42761D8935BC8(startpoint) {
  level endon("vo_players_in_num");
  _id_76A498119F4D69BC = startpoint + (0, -250, 0);
  excludedplayers = [];

  if(isDefined(level.farah)) {
    foreach(guy in level.players) {
      if(guy != level.farah)
        excludedplayers[excludedplayers.size] = guy;
    }
  } else
    return;

  _id_76E9D4CB1F66793B(_id_76A498119F4D69BC, 32, excludedplayers);

  if(_id_6B80A21EDCF9D296(level.farah)) {
    level.farah _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(2, "dx_cp_cpr1_armo_fara_likebarkovsprison");
    aliases = ["dx_cp_cpr1_armo_pric_whatisit", undefined, "dx_cp_cpr1_armo_gazz_whatsthat"];
    player = _id_A9D9C0245997A414(4, [level.price, level._id_E0632103DFA5BB19]);
    result = _id_A606867D80CFABD5(player, aliases, 1);

    if(result) {
      if(_id_6B80A21EDCF9D296(level.farah))
        level.farah _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.8, "dx_cp_cpr1_armo_fara_nothing");
    }
  }
}

_id_2E3E4DDCE10DCA37(startpoint) {
  level endon("vo_players_in_num");
  scripts\engine\utility::flag_init("vo_armory_vents_right");
  level endon("vo_armory_vents_right");
  _id_76A498119F4D69BC = startpoint + (-200, -520, 0);
  thread _id_E60E850D65323E41(_id_76A498119F4D69BC);
  _id_76A498119F4D69BC = _id_76A498119F4D69BC + (25, -560, 0);
  thread _id_E60E850D65323E41(_id_76A498119F4D69BC);
}

_id_E60E850D65323E41(_id_76A498119F4D69BC) {
  level endon("game_ended");
  level endon("vo_armory_vents_right");
  player = _id_76E9D4CB1F66793B(_id_76A498119F4D69BC, 32);
  player _id_9F2DCC6FBBCFB2F5();
  scripts\engine\utility::flag_set("vo_armory_vents_right");
}

_id_9F2DCC6FBBCFB2F5() {
  aliases = ["dx_cp_cpr1_armo_pric_movingright", "dx_cp_cpr1_armo_fara_illcheckright", "dx_cp_cpr1_armo_gazz_movingright"];
  _id_A606867D80CFABD5(self, aliases, 0.5);
}

_id_B90931B0FEEE4020(startpoint) {
  _id_76A498119F4D69BC = startpoint + (0, -1550, 120);
  player = _id_76E9D4CB1F66793B(_id_76A498119F4D69BC, 32);
  aliases = ["dx_cp_cpr1_armo_pric_downhere", "dx_cp_cpr1_armo_fara_wehavetodropdown", "dx_cp_cpr1_armo_gazz_wedropfromhere"];
  _id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_865D6CF09798ED49(_id_5D92416AC0D89610) {
  level endon("game_ended");
  childthread _id_A814CB746393BEC8(_id_5D92416AC0D89610.origin);
  childthread _id_361BE80829011801();

  while(!isDefined(level.seq3_keyboards))
    wait 0.5;

  wait 0.5;
  childthread _id_DC37CAEC6CD33DC7();
  childthread _id_733A2D949744D071();
}

_id_D60713707C5344C3(startpoint) {
  level endon("game_ended");
  level endon("seq3_poweron");
  struct = scripts\engine\utility::getStruct("seq3_approachstruct", "targetname");
  point = (0, 0, 0);
  threshold = 100;

  if(!isDefined(struct)) {
    _id_76A498119F4D69BC = startpoint + (0, -2100, -200);
    point = _id_76A498119F4D69BC;
  } else
    point = struct.origin + (0, 500, 0);

  count = 0;

  while(count < level.players.size) {
    foreach(player in level.players) {
      dist = distance2d(player.origin, point);

      if(dist < threshold)
        count++;
    }

    wait 0.25;
  }

  aliases = [undefined, "dx_cp_cpr1_nums_fara_whatisthat", "dx_cp_cpr1_nums_gazz_thebloodyhellisthis"];
  player = _id_A9D9C0245997A414(2, [level._id_E0632103DFA5BB19, level.farah]);
  result = _id_A606867D80CFABD5(player, aliases, 0);

  if(result)
    _id_A606867D80CFABD5(level.price, "dx_cp_cpr1_nums_pric_notafalloutshelterth", 0.8);
}

_id_A814CB746393BEC8(_id_2C1824E345806E61) {
  level endon("seq3_reset_once");
  scripts\engine\utility::flag_init("vo_find_silo");
  scripts\engine\utility::flag_init("vo_find_silo_done");
  _id_2F38DABD01860335 = _id_2C1824E345806E61 + (0, -1750, 0);
  threshold = 850;
  _id_7F238424F5623D05(_id_2F38DABD01860335, threshold);
  scripts\engine\utility::flag_set("vo_find_silo");
  _id_A606867D80CFABD5(level.price, "dx_cp_cpr1_nums_pric_amissilesilo", 0.8);
  _id_A606867D80CFABD5(level.price, "dx_cp_cpr1_nums_pric_searchtheareaweneeda", 1.4);
  scripts\engine\utility::flag_set("vo_find_silo_done");
}

_id_361BE80829011801() {
  level endon("seq3_reset_once");
  spotter = undefined;
  drone = undefined;
  wait 2;

  while(!isDefined(spotter) && !isDefined(drone)) {
    data = _id_5BC7A5C4437D3803(level.drone_turrets, 0.75);
    spotter = data[0];
    position = data[1];

    foreach(bot in level.drone_turrets) {
      if(bot.origin == position)
        drone = bot;
    }

    waitframe();
  }

  aliases = ["dx_cp_cpr1_nums_pric_bombdronesincoming", "dx_cp_cpr1_nums_fara_bombdrones", "dx_cp_cpr1_nums_gazz_headsupbombdrones"];
  _id_A606867D80CFABD5(spotter, aliases, 0);
}

_id_733A2D949744D071() {
  level endon("seq3_reset_once");
  scripts\engine\utility::flag_init("vo_found_main_terminal");
  player = _id_5BC7A5C4437D3803(level.seq3_reset_switch.origin, 0.8, undefined, undefined, undefined, 200, (0, 0, 12))[0];

  if(scripts\engine\utility::flag("vo_find_silo")) {
    scripts\engine\utility::flag_wait("vo_find_silo_done");
    player = _id_5BC7A5C4437D3803(level.seq3_reset_switch.origin, 0.8, undefined, undefined, undefined, 200, (0, 0, 12))[0];
  }

  aliases = ["dx_cp_cpr1_nums_pric_foundthesequenceterm", "dx_cp_cpr1_nums_fara_foundthesequenceterm", "dx_cp_cpr1_nums_gazz_foundthesequenceterm"];
  _id_A606867D80CFABD5(player, aliases, 0.3, 0);
  scripts\engine\utility::flag_set("vo_found_main_terminal");
  level endon("vo_consoles_all_on");
  player = undefined;

  if(isDefined(level.seq3_reset_switch))
    level.seq3_reset_switch waittill("trigger", player);
  else
    player = _id_5BC7A5C4437D3803(level.seq3_reset_switch.origin, 0.8, undefined, undefined, undefined, 80, (0, 0, 12))[0];

  wait 0.4;

  if(level.seq3_computersused < 2) {
    if(!isDefined(player))
      player = _id_43D8FA96ACF30CA8(level.seq3_reset_switch.origin);

    aliases = ["dx_cp_cpr1_nums_pric_cantuseityet", "dx_cp_cpr1_nums_fara_cantuseityet", "dx_cp_cpr1_nums_gazz_cantuseityet"];
    _id_A606867D80CFABD5(player, aliases, 0, 1);
  }
}

_id_DC37CAEC6CD33DC7() {
  _id_F7C814ADBA97C2B3 = (-1190.92, 2739.6, 757.494);
  _id_12A81BFA232293B5 = scripts\engine\utility::getclosest(_id_F7C814ADBA97C2B3, level.seq3_keyboards);
  _id_12A819FA23228F4F = undefined;

  foreach(_id_8ED7EFDCDFC4F998 in level.seq3_keyboards) {
    if(_id_8ED7EFDCDFC4F998 != _id_12A81BFA232293B5)
      _id_12A819FA23228F4F = _id_8ED7EFDCDFC4F998;
  }

  scripts\engine\utility::flag_init("vo_consoles_all_on");
  _id_12A81BFA232293B5 childthread _id_977333FB66A34F5A();
  _id_12A81BFA232293B5 childthread _id_33E70BD67FBCFCBE(1000);
  _id_12A819FA23228F4F childthread _id_977331FB66A34AF4();
  _id_12A819FA23228F4F childthread _id_33E70BD67FBCFCBE(1000);
}

_id_977333FB66A34F5A() {
  player = _id_5BC7A5C4437D3803(self.origin, 0.8, undefined, undefined, undefined, 300, (0, 0, 12))[0];
  aliases = ["dx_cp_cpr1_nums_pric_foundaterminalbackof", "dx_cp_cpr1_nums_fara_theresaterminalinthe", "dx_cp_cpr1_nums_gazz_eyesonaterminalbacko"];
  result = _id_A606867D80CFABD5(player, aliases, 0.3, 1);

  if(result == 0)
    _id_B4145545E7188FA5(aliases);

  self waittill("trigger", player);
  _id_31E754BD67E21EE3(player);
}

_id_977331FB66A34AF4() {
  player = _id_5BC7A5C4437D3803(self.origin, 0.8, undefined, undefined, undefined, 300, (0, 0, 12))[0];
  aliases = ["dx_cp_cpr1_nums_pric_foundaterminal", "dx_cp_cpr1_nums_fara_theresaterminalhere", "dx_cp_cpr1_nums_gazz_gotaterminalhere"];
  result = _id_A606867D80CFABD5(player, aliases, 0.3, 1);

  if(result == 0)
    _id_B4145545E7188FA5(aliases);

  self waittill("trigger", player);
  _id_31E754BD67E21EE3(player);
}

_id_B4145545E7188FA5(aliases) {
  level endon("game_ended");
  level endon("vo_consoles_all_on");
  player = _id_76E9D4CB1F66793B(self.origin, 200);
  _id_A606867D80CFABD5(player, aliases, undefined, 1);
}

_id_33E70BD67FBCFCBE(range) {
  level endon("vo_consoles_all_on");
  range = scripts\engine\utility::_id_53C4C53197386572(range, 1000);
  wait 2;

  for(enemies = getaiarrayinradius(self.origin, range); enemies.size > 0; enemies = getaiarrayinradius(self.origin, range)) {
    while(enemies.size > 0) {
      enemies = scripts\engine\utility::array_removedead(enemies);
      wait 0.5;
    }

    wait 3;
  }

  aliases = ["dx_cp_cpr1_nums_pric_wereclear", "dx_cp_cpr1_nums_fara_itsclear", "dx_cp_cpr1_nums_gazz_secure"];
  player = _id_A9D9C0245997A414();
  _id_A606867D80CFABD5(player, aliases, 0);
}

_id_31E754BD67E21EE3(player) {
  if(level.seq3_computersused < 1)
    childthread _id_8BB2A5A6B614EFA2(player);
  else {
    scripts\engine\utility::flag_set("vo_consoles_all_on");
    childthread _id_F081BDF2F350CCE0(player);
  }
}

_id_8BB2A5A6B614EFA2(_id_D5849C2EB41A4A1A) {
  level endon("vo_consoles_all_on");
  point = self.origin;
  speakers = scripts\cp\utility::getplayersinradius(point, 500);
  aliases = ["dx_cp_cpr1_nums_pric_thatdidsomething", "dx_cp_cpr1_nums_fara_whatdiditdo", "dx_cp_cpr1_nums_gazz_itsdoingsomething"];
  player = _id_A9D9C0245997A414(1, speakers);
  _id_A606867D80CFABD5(player, aliases, 2.5, undefined, 1);
  wait 0.5;
  level thread scripts\cp\utility::playsoundatpos_safe(self.origin, "dx_cp_cpr1_nums_cmpv_receiverwaitingforac");
  aliases = ["dx_cp_cpr1_nums_pric_saysreceiverwaitingf", "dx_cp_cpr1_nums_fara_itsaysareceiveriswai", "dx_cp_cpr1_nums_gazz_weneedtofindareceive"];
  result = _id_A606867D80CFABD5(_id_D5849C2EB41A4A1A, aliases, 3);

  if(!istrue(result)) {
    player = _id_A9D9C0245997A414();
    _id_A606867D80CFABD5(player, aliases, 3);
  }

  aliases = ["dx_cp_cpr1_nums_pric_lookforanotherconsol", "dx_cp_cpr1_nums_fara_theremustbeanotherco", "dx_cp_cpr1_nums_gazz_findanotherconsole"];
  player = _id_A9D9C0245997A414();
  _id_A606867D80CFABD5(player, aliases, 5);
}

_id_F081BDF2F350CCE0(player) {
  level endon("seq3_reset_once");
  aliases = ["dx_cp_cpr1_nums_pric_done", "dx_cp_cpr1_nums_fara_done", "dx_cp_cpr1_nums_gazz_done"];
  _id_A606867D80CFABD5(player, aliases, 2.5, undefined, 1);
  wait 0.5;
  level thread scripts\cp\utility::playsoundatpos_safe(self.origin, "dx_cp_cpr1_nums_cmpv_connectionestablishe");
  aliases = ["dx_cp_cpr1_nums_pric_connectionestablishe", "dx_cp_cpr1_nums_fara_connectionestablishe", "dx_cp_cpr1_nums_gazz_connectionestablishe"];
  result = _id_A606867D80CFABD5(player, aliases, 4);

  if(!istrue(result)) {
    player = _id_A9D9C0245997A414();
    _id_A606867D80CFABD5(player, aliases, 4);
  }

  aliases = ["dx_cp_cpr1_nums_pric_waitingforsequence", "dx_cp_cpr1_nums_fara_itsayswaitingforsequ", "dx_cp_cpr1_nums_gazz_waitingforsequence"];
  player = _id_A9D9C0245997A414();
  _id_A606867D80CFABD5(player, aliases, 0.4);
  wait 1;
  aliases = ["dx_cp_cpr1_nums_pric_weneedtobroadcastthe", "dx_cp_cpr1_nums_fara_thecodesfromthecctvw", "dx_cp_cpr1_nums_gazz_weneedcodeslikebefor"];
  player = _id_A9D9C0245997A414();
  _id_A606867D80CFABD5(player, aliases, 0);
  wait 4;
  aliases = ["dx_cp_cpr1_nums_pric_lookforsomethingweca", "dx_cp_cpr1_nums_fara_weneedtofindwhatcanb", "dx_cp_cpr1_nums_gazz_searchforsomethingto"];
  player = _id_A9D9C0245997A414();
  _id_A606867D80CFABD5(player, aliases, 0);

  if(!scripts\engine\utility::flag("vo_found_main_terminal"))
    _id_549F11E1DC2E1EE8();
}

_id_549F11E1DC2E1EE8() {
  level endon("vo_found_main_terminal");
  aliases = [];
  aliases[aliases.size] = [level.price, "dx_cp_cpr1_nums_pric_lookforasequenceterm"];
  aliases[aliases.size] = [level.farah, "dx_cp_cpr1_nums_fara_weneedtofindasequenc"];
  aliases[aliases.size] = [level._id_E0632103DFA5BB19, "dx_cp_cpr1_nums_gazz_searchforthesequence"];
  nags = scripts\engine\utility::create_deck(aliases, 1, 1);
  _id_5D265B4FCA61F070::nag_wait("vo_found_main_terminal", nags, _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(5, 30, 3));
}

_id_73F5EE271C35C4E8() {
  level endon("game_ended");
  level endon("seq3_puzzle_complete");
  scripts\engine\utility::flag_init("vo_drones_callout");
  wait 0.5;

  for(;;) {
    _id_2E8E05A9E26B5E90();
    level waittill("seq3_tier_increase");
  }
}

_id_2E8E05A9E26B5E90() {
  level endon("game_ended");
  player = _id_43D8FA96ACF30CA8(level.seq3_reset_switch.origin, 1, level.players, 300);

  if(!isDefined(player))
    player = _id_A9D9C0245997A414();

  switch (level.seq3_tier) {
    case 1:
      _id_E684BFC81002CFAF(player);
      break;
    case 2:
      _id_E684C0C81002D1E2(player);
      break;
    case 3:
      _id_E684C1C81002D415(player);
      break;
    default:
      _id_E684BFC81002CFAF(player);
  }
}

_id_E684BFC81002CFAF(player) {
  level endon("seq3_tier_increase");
  childthread _id_08B35B637BCBAB39();
  level._id_7EDAD2FBC5F2C2CF = undefined;
  aliases = ["dx_cp_cpr1_intr_pric_werein", "dx_cp_cpr1_intr_fara_therethesystemisunlo", "dx_cp_cpr1_intr_gazz_gotitsystemsup"];
  _id_A606867D80CFABD5(player, aliases, 2, 0);
  aliases = ["dx_cp_cpr1_nums_pric_wevegot1minuteuntilt", "dx_cp_cpr1_nums_fara_wehaveoneminutetoent", "dx_cp_cpr1_nums_gazz_movefastwevegotonemi"];
  _id_A606867D80CFABD5(player, aliases, 2, 0.6);
  wait 8;
  aliases = ["dx_cp_cpr1_nums_pric_bombdronesincoming", "dx_cp_cpr1_nums_fara_bombdrones", "dx_cp_cpr1_nums_gazz_headsupbombdrones"];
  player = _id_A9D9C0245997A414();
  _id_A606867D80CFABD5(player, aliases, 0);
  wait 4;
  childthread _id_BF24345D47CF5C2A();
}

_id_BF24345D47CF5C2A() {
  threshold = 250;
  target = undefined;
  spotter = undefined;
  drone = undefined;

  while(!isDefined(target)) {
    data = _id_5BC7A5C4437D3803(level.drone_turrets, 0.75);
    spotter = data[0];
    position = data[1];

    foreach(bots in level.drone_turrets) {
      if(bots.origin == position)
        drone = bots;
    }

    if(isDefined(drone)) {
      _id_587FA130C1104049 = [];

      foreach(guy in level.players) {
        if(guy != spotter)
          _id_587FA130C1104049[_id_587FA130C1104049.size] = guy;
      }

      foreach(player in _id_587FA130C1104049) {
        if(isDefined(drone._id_3AEC9A4EC140655A)) {
          dist = distance2d(player.origin, drone._id_3AEC9A4EC140655A);

          if(dist < threshold) {
            target = player;
            break;
          }
        }
      }
    }

    waitframe();
  }

  thread _id_166396841A0D3A57(target, spotter);
}

_id_166396841A0D3A57(target, player) {
  level endon("game_ended");
  aliases = undefined;

  if(isDefined(level.price) && player == level.price) {
    if(player == level.price) {
      if(isDefined(level.farah) && target == level.farah)
        aliases = ["dx_cp_cpr1_nums_pric_farah", "dx_cp_cpr1_nums_pric_abombdronesheadedyou"];
      else if(isDefined(level._id_E0632103DFA5BB19) && target == level._id_E0632103DFA5BB19)
        aliases = ["dx_cp_cpr1_nums_pric_gaz", "dx_cp_cpr1_nums_pric_bombdroneincoming"];
    }
  } else if(isDefined(level.farah) && player == level.farah) {
    if(isDefined(level.price) && target == level.price)
      aliases = ["dx_cp_cpr1_nums_fara_price", "dx_cp_cpr1_nums_fara_abombdroneiscomingfo"];
    else if(isDefined(level._id_E0632103DFA5BB19) && target == level._id_E0632103DFA5BB19)
      aliases = ["dx_cp_cpr1_nums_fara_gaz", "dx_cp_cpr1_nums_fara_theresabombdroneinco"];
  } else if(isDefined(level._id_E0632103DFA5BB19) && player == level._id_E0632103DFA5BB19) {
    if(isDefined(level.price) && target == level.price)
      aliases = ["dx_cp_cpr1_nums_gazz_price", "dx_cp_cpr1_nums_gazz_bombdronesmovingyour"];
    else if(isDefined(level.farah) && target == level.farah)
      aliases = ["dx_cp_cpr1_nums_gazz_farah", "dx_cp_cpr1_nums_gazz_bombdroneincoming"];
  }

  if(isDefined(aliases)) {
    scripts\engine\utility::flag_set("vo_drones_callout");
    result = _id_A606867D80CFABD5(player, aliases[0], 0);

    if(result) {
      result = _id_A606867D80CFABD5(player, aliases[1], 0.4);

      if(result)
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(target, "stat_BCA5E472447F8C73");
    }
  }
}

_id_08B35B637BCBAB39() {
  level endon("seq3_puzzle_complete");
  wait 30;
  aliases = ["dx_cp_cpr1_nums_pric_30seconds", "dx_cp_cpr1_nums_fara_30secondsleft", "dx_cp_cpr1_nums_gazz_30seconds"];
  player = _id_A9D9C0245997A414();
  _id_A606867D80CFABD5(player, aliases, 0, 1);
  wait 6;
  aliases = ["dx_cp_cpr1_nums_pric_morebombdrones", "dx_cp_cpr1_nums_fara_theresmorebombdrones", "dx_cp_cpr1_nums_gazz_morebombdronesincomi"];
  player = _id_A9D9C0245997A414();
  _id_A606867D80CFABD5(player, aliases, 0);

  if(scripts\engine\utility::flag("vo_drones_callout"))
    _id_BF24345D47CF5C2A();
}

_id_E684C0C81002D1E2(player) {
  level endon("seq3_tier_increase");
  aliases = ["dx_cp_cpr1_nums_pric_40secondsthistime", "dx_cp_cpr1_nums_fara_thecodewillchangein4_01", "dx_cp_cpr1_nums_gazz_coderesetsin40second"];
  _id_A606867D80CFABD5(player, aliases, 0, 1);
  wait 7.5;
  aliases = ["dx_cp_cpr1_nums_pric_aqshereexpectcontact", "dx_cp_cpr1_nums_fara_aqismovingin", "dx_cp_cpr1_nums_gazz_wevegotaqincoming"];
  _id_A606867D80CFABD5(player, aliases, 0);
}

_id_C47D2F984D3BF0A0() {
  level endon("seq3_tier_increase");
  player = _id_76E9D4CB1F66793B(self.origin, 1000);
  aliases = ["dx_cp_cpr1_nums_pric_theresgasinhere", "dx_cp_cpr1_nums_fara_theresgasitsfillingt", "dx_cp_cpr1_nums_gazz_shittheyreusinggas"];
  result = _id_A606867D80CFABD5(player, aliases, 0);

  if(result) {
    _id_84DDDDC60762142A = _id_1D00AE3820C14B8C(player);

    if(!isDefined(_id_84DDDDC60762142A)) {
      speakers = [];
      speakers = scripts\engine\utility::array_remove(level.players, player);
      player = undefined;
      player = _id_A9D9C0245997A414(1, speakers);
    } else
      player = _id_84DDDDC60762142A;

    aliases = ["dx_cp_cpr1_nums_pric_getunderwater", "dx_cp_cpr1_nums_fara_usethewater", "dx_cp_cpr1_nums_gazz_diveunderwater"];
    _id_A606867D80CFABD5(player, aliases, 0.4);
  }
}

_id_1D00AE3820C14B8C(_id_7FF848155485BCC7) {
  speakers = scripts\engine\utility::array_remove(level.players, _id_7FF848155485BCC7);
  player = _id_A9D9C0245997A414(1, speakers);
  alias = undefined;

  if(isDefined(level.price) && player == level.price) {
    if(isDefined(level.farah) && _id_7FF848155485BCC7 == level.farah)
      alias = ["dx_cp_cpr1_nums_pric_farah"];
    else if(isDefined(level._id_E0632103DFA5BB19) && _id_7FF848155485BCC7 == level._id_E0632103DFA5BB19)
      alias = ["dx_cp_cpr1_nums_pric_gaz"];
  } else if(isDefined(level.farah) && player == level.farah) {
    if(isDefined(level.price) && _id_7FF848155485BCC7 == level.price)
      alias = ["dx_cp_cpr1_nums_fara_price"];
    else if(isDefined(level._id_E0632103DFA5BB19) && _id_7FF848155485BCC7 == level._id_E0632103DFA5BB19)
      alias = ["dx_cp_cpr1_nums_fara_gaz"];
  } else if(isDefined(level._id_E0632103DFA5BB19) && player == level._id_E0632103DFA5BB19) {
    if(isDefined(level.price) && _id_7FF848155485BCC7 == level.price)
      alias = ["dx_cp_cpr1_nums_gazz_price"];
    else if(isDefined(level.farah) && _id_7FF848155485BCC7 == level.farah)
      alias = ["dx_cp_cpr1_nums_gazz_farah"];
  }

  result = _id_A606867D80CFABD5(player, alias, 1);

  if(result)
    return player;
}

_id_E684C1C81002D415(player) {
  level endon("seq3_tier_increase");
  wait 2;
  aliases = ["dx_cp_cpr1_nums_pric_25secondsnow", "dx_cp_cpr1_nums_fara_its25secondsnow", "dx_cp_cpr1_nums_gazz_only25seconds"];
  _id_A606867D80CFABD5(player, aliases, 0);
}

_id_1DE187F9C5F686D2() {
  level endon("game_ended");

  if(!scripts\engine\utility::flag("seq3_poweron")) {
    return;
  }
  aliases = [];

  switch (level.seq3_tier) {
    case 1:
      aliases = ["dx_cp_cpr1_nums_pric_thesequencechangedst", "dx_cp_cpr1_nums_fara_nogoodthesequencecha", "dx_cp_cpr1_nums_gazz_shitthecoderesetlets"];
      break;
    case 2:
      aliases = ["dx_cp_cpr1_nums_pric_itresetstartagain", "dx_cp_cpr1_nums_fara_toolateitreset", "dx_cp_cpr1_nums_gazz_nogooditreset"];
      break;
    case 3:
      aliases = ["dx_cp_cpr1_nums_pric_weretakingtoolonggoa", "dx_cp_cpr1_nums_fara_timesupitreset", "dx_cp_cpr1_nums_gazz_shititresetgoagain"];
      break;
  }

  wait 1;
  player = _id_43D8FA96ACF30CA8(level.seq3_reset_switch.origin, 1, level.players, 300);

  if(!isDefined(player))
    player = _id_A9D9C0245997A414();

  _id_A606867D80CFABD5(player, aliases, 0, 1);
}

_id_C480E756E3298B92(player) {
  level endon("game_ended");
  aliases = ["dx_cp_cpr1_nums_pric_thesequencechangedst", "dx_cp_cpr1_nums_fara_nogoodthesequencecha", "dx_cp_cpr1_nums_gazz_shitthecoderesetlets"];
  player = _id_A9D9C0245997A414();
  _id_A606867D80CFABD5(player, aliases, 1, 1);
}

_id_C480E656E329895F(player) {
  level endon("game_ended");
  aliases = ["dx_cp_cpr1_nums_pric_itresetstartagain", "dx_cp_cpr1_nums_fara_toolateitreset", "dx_cp_cpr1_nums_gazz_nogooditreset"];
  player = _id_A9D9C0245997A414();
  _id_A606867D80CFABD5(player, aliases, 1, 1);
}

_id_C480E556E329872C(player) {
  level endon("game_ended");
  aliases = ["dx_cp_cpr1_nums_pric_weretakingtoolonggoa", "dx_cp_cpr1_nums_fara_timesupitreset", "dx_cp_cpr1_nums_gazz_shititresetgoagain"];
  player = _id_A9D9C0245997A414();
  _id_A606867D80CFABD5(player, aliases, 1, 1);
}

_id_5E7BF2DED37463C3() {
  aliases = ["dx_cp_cpr1_nums_pric_thatworkednextcode", "dx_cp_cpr1_nums_fara_itworkednextcode", "dx_cp_cpr1_nums_fara_goodnextcode"];
  result = _id_A606867D80CFABD5(self, aliases, 1, 1);

  if(result == 0) {
    player = _id_A9D9C0245997A414();
    result = _id_A606867D80CFABD5(player, aliases, 1, 1);
  }
}

_id_5E7BF3DED37465F6() {
  level endon("game_ended");
  aliases = ["dx_cp_cpr1_nums_pric_okaylastcode", "dx_cp_cpr1_nums_fara_thatworkedlastcodeno", "dx_cp_cpr1_nums_gazz_itworkedonecodeleft"];
  result = _id_A606867D80CFABD5(self, aliases, 1, 1);

  if(result == 0) {
    player = _id_A9D9C0245997A414();
    result = _id_A606867D80CFABD5(player, aliases, 1, 1);
  }
}

_id_0A7EBAB04E39FEC8() {
  aliases = ["dx_cp_cpr1_intr_pric_thatsit", "dx_cp_cpr1_intr_fara_thatworked", "dx_cp_cpr1_intr_gazz_wereinbusiness"];
  result = _id_A606867D80CFABD5(self, aliases, 1, 0.6);

  if(result == 0) {
    player = _id_A9D9C0245997A414();
    result = _id_A606867D80CFABD5(player, aliases, 1, 0.6);
  }

  aliases = ["dx_cp_cpr1_intr_pric_thatsit", "dx_cp_cpr1_intr_fara_thatworked", "dx_cp_cpr1_intr_gazz_wereinbusiness"];
  result = _id_A606867D80CFABD5(self, aliases, 1, 0.6);

  if(result == 0) {
    player = _id_A9D9C0245997A414();
    result = _id_A606867D80CFABD5(player, aliases, 1, 0.4);
  }
}

_id_29100C853B2EA8AE() {
  decks = [];
  decks[decks.size] = scripts\engine\utility::create_deck(["dx_cp_cpr1_nums_pric_thatdidntwork", "dx_cp_cpr1_nums_fara_thatsnottherightcode", "dx_cp_cpr1_nums_gazz_thatcodesnotworking"]);
  decks[decks.size] = scripts\engine\utility::create_deck(["dx_cp_cpr1_nums_pric_negativewrongcode", "dx_cp_cpr1_nums_fadx_cp_cpr1_nums_fara_wrongcodera_thatsnottherightcode", "dx_cp_cpr1_nums_gazz_thatsthewrongcode"]);
  level._id_7EDAD2FBC5F2C2CF = decks;
}

_id_96AAADBB5D1468B8() {
  level endon("game_ended");
  scripts\engine\utility::flag_set("vo_doors_start");
  struct = scripts\engine\utility::getStruct("nums_finale_door_interact_struct", "targetname");
  _id_7D2852D02216C876 = undefined;
  result = 0;
  wait 5;

  if(isDefined(struct)) {
    foreach(guy in level.players) {
      dist = distance2d(struct.origin, guy.origin);

      if(dist < 200)
        _id_7D2852D02216C876 = guy;
    }
  }

  if(isDefined(_id_7D2852D02216C876)) {
    aliases = ["dx_cp_cpr1_nums_pric_ohyouvegottabeshitti", "dx_cp_cpr1_nums_fara_youvegottobeshitting", "dx_cp_cpr1_nums_gazz_ohyouvegottabeshitti"];
    _id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 2);
  }

  if(isDefined(level._id_E0632103DFA5BB19))
    result = _id_A606867D80CFABD5(level._id_E0632103DFA5BB19, "dx_cp_cpr1_nums_gazz_howlongsthisdoortake", 0.6);

  if(result) {
    if(isDefined(level.farah))
      _id_A606867D80CFABD5(level.farah, "dx_cp_cpr1_nums_fara_allday", 0.8);
  }

  speakers = [level.price, level.farah];
  aliases = ["dx_cp_cpr1_nums_pric_diginwevegotcompany", "dx_cp_cpr1_nums_fara_wevegotincoming"];
  player = _id_A9D9C0245997A414(undefined, speakers);
  _id_A606867D80CFABD5(player, aliases, 4);
  aliases = ["dx_cp_cpr1_nums_pric_oneminuteontheclock", "dx_cp_cpr1_nums_fara_wehaveoneminute", "dx_cp_cpr1_nums_gazz_wevegotoneminutetoge"];
  childthread _id_D1642DFBA4B65292(167, aliases);
  aliases = ["dx_cp_cpr1_nums_pric_30seconds", "dx_cp_cpr1_nums_fara_30secondsleft", "dx_cp_cpr1_nums_gazz_30seconds"];
  childthread _id_D1642DFBA4B65292(201, aliases);
}

_id_99DCB87DC1FC30D3() {
  level endon("game_ended");
  struct = scripts\engine\utility::getStruct("nums_finale_door_interact_struct", "targetname");
  _id_7D2852D02216C876 = undefined;

  if(isDefined(struct)) {
    foreach(guy in level.players) {
      dist = distance2d(struct.origin, guy.origin);

      if(dist < 200)
        _id_7D2852D02216C876 = guy;
    }
  }

  if(isDefined(_id_7D2852D02216C876) && isDefined(level._id_E0632103DFA5BB19)) {
    if(_id_7D2852D02216C876 == level._id_E0632103DFA5BB19) {
      result = _id_A606867D80CFABD5(level._id_E0632103DFA5BB19, "dx_cp_cpr1_nums_gazz_howlongsthisdoortake", 0);

      if(result)
        _id_A606867D80CFABD5(level.farah, "dx_cp_cpr1_nums_fara_allday", 0.6);
    }
  }
}

_id_D1642DFBA4B65292(delay, aliases) {
  struct = scripts\engine\utility::getStruct("nums_finale_door_interact_struct", "targetname");
  _id_7D2852D02216C876 = undefined;
  wait(delay);

  if(isDefined(struct)) {
    foreach(guy in level.players) {
      dist = distance2d(struct.origin, guy.origin);

      if(dist < 200)
        _id_7D2852D02216C876 = guy;
    }
  }

  if(isDefined(_id_7D2852D02216C876))
    result = _id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.6);
  else {
    player = _id_A9D9C0245997A414();
    _id_A606867D80CFABD5(player, aliases, 2);
  }
}

_id_F69BE58BD5E267C9() {
  level endon("game_ended");
  wait 1.5;
  _id_2E55675D530EFA46 = getaiarray("axis");

  if(_id_2E55675D530EFA46.size > 0) {
    aliases = ["dx_cp_cpr1_nums_pric_securethisarea", "dx_cp_cpr1_nums_fara_securethearea", "dx_cp_cpr1_nums_gazz_securethisarea"];
    player = _id_A9D9C0245997A414();
    _id_A606867D80CFABD5(player, aliases, 0, 1);
  }

  use_struct = scripts\engine\utility::getStruct("nums_finale_door_interact_struct", "targetname");
  players = scripts\cp\utility::getplayersinradius(use_struct.origin, 400);

  if(!isDefined(players) || players.size < 1) {
    aliases = ["dx_cp_cpr1_nums_pric_doorsopenmove", "dx_cp_cpr1_nums_fara_thedoorsopenletsmove", "dx_cp_cpr1_nums_gazz_itsopengetinside"];
    player = _id_A9D9C0245997A414();
    _id_A606867D80CFABD5(player, aliases, 1);
  }
}

_id_D760E9C63602F0AA() {
  level endon("game_ended");
  use_struct = scripts\engine\utility::getStruct("nums_finale_door_interact_struct", "targetname");
  aliases = ["dx_cp_cpr1_armo_pric_onme", "dx_cp_cpr1_armo_fara_thisway", "dx_cp_cpr1_armo_gazz_overere"];
  wait 3;

  for(guys = scripts\cp\utility::getplayersinradius(use_struct.origin, 100); guys.size < level.players.size; guys = scripts\cp\utility::getplayersinradius(use_struct.origin, 100)) {
    _id_7D2852D02216C876 = _id_A9D9C0245997A414(1, guys);
    _id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0, 1);
    wait 15;
  }
}

_id_FC4EE8E475C450C3() {
  level endon("game_ended");
  self waittill("death", attacker);
  wait 0.8;
  aliases = ["dx_cp_cpr1_armo_pric_kljg", "dx_cp_cpr1_armo_fara_kljg", "dx_cp_cpr1_armo_gazz_kljg"];
  _id_A606867D80CFABD5(attacker, aliases);
}

_id_A606867D80CFABD5(player, aliases, delay, priority, timeout, _id_F6E387B9F5A2B39C, scope) {
  scope = scripts\engine\utility::_id_53C4C53197386572(scope, "team");
  alias = _id_C810DB5F583495B1(player, aliases);

  if(isstruct(alias))
    alias = alias scripts\engine\utility::deck_draw();

  if(!isDefined(alias))
    return 0;

  return player _id_5D265B4FCA61F070::say(alias, priority, timeout, _id_F6E387B9F5A2B39C, delay, scope);
}

_id_C810DB5F583495B1(player, aliases) {
  if(!_id_6B80A21EDCF9D296(player) || !isDefined(player._id_938E8B2CA6549759)) {
    return;
  }
  if(!isDefined(aliases)) {
    return;
  }
  if(isstring(aliases))
    return aliases;

  switch (player._id_938E8B2CA6549759) {
    case "price":
      return aliases[0];
    case "farah":
      return aliases[1];
    case "gaz":
      return aliases[2];
    default:
      return;
  }
}

_id_AA8653DEA5520361(timeout, players) {
  _id_7D2852D02216C876 = _id_29714545859E6445(players)[0];

  for(time = 0; !isDefined(timeout) || time <= timeout; time = time + 0.05) {
    _id_7D2852D02216C876 = _id_29714545859E6445(players)[0];

    if(isDefined(_id_7D2852D02216C876))
      return _id_7D2852D02216C876;

    waitframe();
  }

  return _id_7D2852D02216C876;
}

_id_88BC9CD1FFAB6FEF(origin, timeout, players, maxdist) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, level.players);
  _id_9667B18C20430352 = scripts\cp\utility::getplayersinradius(origin, maxdist);
  _id_E031661B7146A294 = [];

  foreach(player in players) {
    if(scripts\engine\utility::array_contains(_id_9667B18C20430352, player))
      _id_E031661B7146A294 = scripts\engine\utility::array_add(_id_E031661B7146A294, player);
  }

  _id_E031661B7146A294 = scripts\engine\utility::array_removeundefined(_id_E031661B7146A294);
  return _id_AA8653DEA5520361(timeout, _id_E031661B7146A294);
}

_id_A9D9C0245997A414(timeout, players) {
  _id_7D2852D02216C876 = _id_6B2A1B9750071995(players);

  for(time = 0; !isDefined(timeout) || time <= timeout; time = time + 0.05) {
    _id_7D2852D02216C876 = _id_6B2A1B9750071995(players);

    if(isDefined(_id_7D2852D02216C876))
      return _id_7D2852D02216C876;

    waitframe();
  }

  return _id_7D2852D02216C876;
}

_id_43D8FA96ACF30CA8(origin, timeout, players, maxdist, _id_636C8575D7A7768B) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, level.players);
  _id_6BCD40D4AAE48211 = scripts\engine\utility::get_array_of_closest(origin, players, undefined, undefined, maxdist, _id_636C8575D7A7768B);
  return _id_AA8653DEA5520361(timeout, _id_6BCD40D4AAE48211);
}

_id_215866EE17ECD840(origin, timeout, range, _id_80BF6212193E8983) {
  _id_CEAD4E87C3F90536 = scripts\cp\utility::getplayersinradius(origin, range, undefined, _id_80BF6212193E8983);
  return _id_A9D9C0245997A414(timeout, _id_CEAD4E87C3F90536);
}

_id_6B80A21EDCF9D296(player) {
  return isDefined(player) && player scripts\cp\utility::is_valid_player(1, 1) && !player _meth_6F55D55CCFF20D14();
}

_id_6B2A1B9750071995(players) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, level.players);
  speakers = _id_29714545859E6445(players);
  return scripts\engine\utility::random(speakers);
}

_id_29714545859E6445(players) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, level.players);
  speakers = [];

  foreach(player in players) {
    if(_id_6B80A21EDCF9D296(player))
      speakers[speakers.size] = player;
  }

  return speakers;
}

_id_C51AB16BE84F5675() {
  scripts\engine\utility::waittill_any_ents_array(getaiarray("axis"), "stealth_combat");
  level notify("stealth_combat");
}

_id_99A887D75310BF40(time, _id_DA131BE836149780) {
  _id_DA131BE836149780 = scripts\engine\utility::_id_53C4C53197386572(_id_DA131BE836149780, 0);

  while(!istrue(_id_3278FE5D41A5D027(time, _id_DA131BE836149780)))
    continue;
}

_id_3278FE5D41A5D027(time, _id_DA131BE836149780) {
  msg = scripts\engine\utility::ter_op(_id_DA131BE836149780, "vo_strict_combat", "vo_combat");
  scripts\engine\utility::flag_waitopen(msg);
  level endon(msg);
  wait(time);
  return 1;
}

_id_73709F2B96C09080(array, _id_01ED762217419B34, _id_7D0D6FC0C0489FBA) {
  array = scripts\engine\utility::_id_53C4C53197386572(array, getaiarray("axis"));
  _id_2C85EC531CCF8E15 = 0;

  foreach(guy in array) {
    if(scripts\engine\utility::is_dead_or_dying(guy) || istrue(guy._id_776F2137854DF85E) || istrue(guy.in_melee_death)) {
      continue;
    }
    if(!isPlayer(guy.enemy)) {
      continue;
    }
    if(istrue(_id_01ED762217419B34) && scripts\engine\utility::time_has_passed(guy._blackboard._id_060DCAA3D3BE97AB, 10)) {
      if(guy._id_FE5EBEFA740C7106 == 3) {
        _id_2C85EC531CCF8E15++;

        if(isDefined(_id_7D0D6FC0C0489FBA) && _id_2C85EC531CCF8E15 > _id_7D0D6FC0C0489FBA)
          return 1;
      }
    } else if(guy._id_FE5EBEFA740C7106 == 3)
      return 1;
  }

  return 0;
}

_id_E35E13135222B2A8(count) {
  _id_05956C54E54EBF3D = 0;

  foreach(player in level.players) {
    if(player scripts\cp\utility::is_valid_player(1, 1))
      _id_05956C54E54EBF3D++;
  }

  while(_id_05956C54E54EBF3D < count) {
    waitframe();
    _id_05956C54E54EBF3D = 0;

    foreach(player in level.players) {
      if(player scripts\cp\utility::is_valid_player(1, 1))
        _id_05956C54E54EBF3D++;
    }
  }
}

_id_B826409EE2EFF7B6(height, players) {
  return _id_4E943B7BA4CCBBE8(2, height, players);
}

_id_4E943B7BA4CCBBE8(_id_47CC057E8A7B1FBE, value, players, timeout) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, level.players);

  for(time = 0; !isDefined(timeout) || time < timeout; time = time + 0.05) {
    foreach(player in players) {
      if(!isalive(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(player.origin[_id_47CC057E8A7B1FBE] > value)
        return player;
    }

    waitframe();
  }
}

_id_3B46C8D1F1AE39D3(_id_47CC057E8A7B1FBE, value, players, timeout) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, level.players);

  for(time = 0; !isDefined(timeout) || time <= timeout; time = time + 0.05) {
    foreach(player in players) {
      if(!isalive(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(player.origin[_id_47CC057E8A7B1FBE] < value)
        return player;
    }

    waitframe();
  }
}

_id_45831CF64D17BBB1(point, angles, players, timeout) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, level.players);
  forward = anglesToForward(angles);

  for(time = 0; !isDefined(timeout) || time <= timeout; time = time + 0.05) {
    foreach(player in players) {
      if(!isalive(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(vectordot(player.origin - point, forward) > 0)
        return player;
    }

    waitframe();
  }
}

_id_A0580E9BD081384B(targets) {
  for(;;) {
    level waittill("player_pinged_enemy", player, target);

    if(scripts\engine\utility::array_contains(targets, target))
      return [player, target];
  }
}

_id_2428384AF851217A(targets) {
  for(;;) {
    level waittill("player_pinged_object", player, target);

    if(scripts\engine\utility::array_contains(targets, target))
      return [player, target];
  }
}

_id_5BC7A5C4437D3803(targets, dot, holdtime, _id_E2073531FA9C0C72, _id_94564218DD6125B9, maxdist, offset) {
  dot = scripts\engine\utility::_id_53C4C53197386572(dot, 0.9995);
  _id_E2073531FA9C0C72 = scripts\engine\utility::_id_53C4C53197386572(_id_E2073531FA9C0C72, 0);
  holdtime = scripts\engine\utility::_id_53C4C53197386572(holdtime, 0.05);

  if(isPlayer(_id_94564218DD6125B9))
    _id_94564218DD6125B9 = [_id_94564218DD6125B9];

  _id_C20F037704A34DEA = [];
  _id_CDC5DD6C28C9709D = undefined;

  if(isDefined(maxdist))
    _id_CDC5DD6C28C9709D = squared(maxdist);

  for(;;) {
    foreach(_id_EF50426720E1DBB8, player in level.players) {
      if(!isalive(player)) {
        continue;
      }
      if(_id_E2073531FA9C0C72 && player playerads() < 0.5) {
        continue;
      }
      if(isDefined(_id_94564218DD6125B9) && scripts\engine\utility::array_contains(_id_94564218DD6125B9, player)) {
        continue;
      }
      target = player _id_826A16F43A8E949B(targets, dot, offset, _id_CDC5DD6C28C9709D);

      if(!isDefined(target)) {
        _id_C20F037704A34DEA[_id_EF50426720E1DBB8] = undefined;
        continue;
      }

      if(!isDefined(_id_C20F037704A34DEA[_id_EF50426720E1DBB8]))
        _id_C20F037704A34DEA[_id_EF50426720E1DBB8] = 0;

      _id_C20F037704A34DEA[_id_EF50426720E1DBB8] = _id_C20F037704A34DEA[_id_EF50426720E1DBB8] + 0.05;

      if(_id_C20F037704A34DEA[_id_EF50426720E1DBB8] > holdtime)
        return [player, target];
    }

    waitframe();
  }
}

_id_826A16F43A8E949B(targets, dot, offset, _id_CDC5DD6C28C9709D) {
  if(!isarray(targets))
    targets = [targets];

  foreach(target in targets) {
    if(!isDefined(target)) {
      continue;
    }
    if(isai(target)) {
      if(!isalive(target)) {
        continue;
      }
      target = target.origin + (0, 0, 50);
    } else if(isent(target))
      target = target.origin;

    if(isDefined(offset))
      target = target + offset;

    if(isDefined(_id_CDC5DD6C28C9709D) && distancesquared(self.origin, target) > _id_CDC5DD6C28C9709D) {
      continue;
    }
    if(scripts\cp\utility::player_looking_at(target, dot))
      return target;
  }
}

_id_71FC89B3E8140B4B(targets, dist, _id_94564218DD6125B9) {
  dist = squared(dist);

  for(;;) {
    foreach(target in targets) {
      if(isent(target)) {
        if(!isalive(target)) {
          continue;
        }
        target = target.origin;
      }

      foreach(player in level.players) {
        if(!isalive(player)) {
          continue;
        }
        if(isDefined(_id_94564218DD6125B9) && scripts\engine\utility::array_contains(_id_94564218DD6125B9, player)) {
          continue;
        }
        if(distance2dsquared(player.origin, target) < dist)
          return [player, target];
      }
    }

    waitframe();
  }
}

_id_E3C59645C8720E83(targets, dist, _id_94564218DD6125B9, timeout) {
  dist = squared(dist);
  _id_6B7BEE46F2C6DA28 = gettime();

  while(!scripts\engine\utility::time_has_passed(_id_6B7BEE46F2C6DA28, timeout)) {
    foreach(target in targets) {
      if(isent(target)) {
        if(!isalive(target)) {
          continue;
        }
        target = target.origin;
      }

      foreach(player in level.players) {
        if(!isalive(player)) {
          continue;
        }
        if(isDefined(_id_94564218DD6125B9) && scripts\engine\utility::array_contains(_id_94564218DD6125B9, player)) {
          continue;
        }
        if(distance2dsquared(player.origin, target) < dist)
          return 1;
      }
    }

    waitframe();
  }

  return 0;
}

_id_9A835763C929EB24(player, timeout) {
  for(time = 0; !isDefined(timeout) || time <= timeout; time = time + 0.05) {
    if(!player _meth_6F55D55CCFF20D14())
      return player;

    waitframe();
  }
}

_id_8935EE5F55A88C21(targets) {
  while(!_id_6BE2684644F905AC(targets))
    scripts\engine\utility::waittill_any_ents_array(targets, "death", "long_death");
}

_id_6BE2684644F905AC(targets) {
  foreach(target in targets) {
    if(!scripts\engine\utility::is_dead_or_dying(target))
      return 0;
  }

  return 1;
}

_id_9D4A0C8FC2BAD53C() {
  foreach(player in level.players) {
    if(istestclient(player))
      player thread _id_ED9BF82AD9A067BE();
  }
}

_id_ED9BF82AD9A067BE() {
  self allowfire(0);
  self allowmovement(0);

  for(;;) {
    wait 1;

    if(!isalive(self) || self isspectatingplayer()) {
      continue;
    }
    if(distance(self.origin, level.player.origin) < 500) {
      continue;
    }
    self allowfire(0);
    self allowmovement(0);
    self setplayerangles(level.player.angles);
    self setOrigin(level.player.origin - anglesToForward(level.player getplayerangles(1)) * 10);
  }
}

_id_76E9D4CB1F66793B(point, threshold, _id_94564218DD6125B9) {
  level endon("game_ended");

  for(;;) {
    foreach(player in level.players) {
      if(isDefined(_id_94564218DD6125B9) && scripts\engine\utility::array_contains(_id_94564218DD6125B9, player)) {
        continue;
      }
      dist = distance2d(player.origin, point);

      if(dist < threshold)
        return player;
    }

    wait 0.25;
  }
}

_id_7F238424F5623D05(point, threshold) {
  level endon("game_ended");
  count = 0;

  while(count < 3) {
    count = 0;

    foreach(player in level.players) {
      dist = distance2d(player.origin, point);

      if(dist < threshold)
        count++;
    }

    wait 0.25;
  }
}

_id_7C50C629B4D4086A(_id_41D8BF229CF29051) {
  _id_41D8BF229CF29051 = scripts\engine\utility::_id_53C4C53197386572(_id_41D8BF229CF29051, 1);
  level._id_5D4C8322D01B9C50 = _id_41D8BF229CF29051;

  if(_id_41D8BF229CF29051 == 1)
    scripts\cp\cp_player_battlechatter::togglecpplayerbc(0);
  else
    scripts\cp\cp_player_battlechatter::togglecpplayerbc(1);
}

_id_563D9FE3AEDCA497(_id_41D8BF229CF29051) {
  self._id_5D4C8322D01B9C50 = _id_41D8BF229CF29051;
}