/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_79823539ca298145.gsc
***********************************************/

_id_952A793B3FEF082B() {
  wait 6;
  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");
  thread _id_62E11D77B25C1D30::_id_5175593A7A2CCDB5();
  thread _id_62E11D77B25C1D30::_id_FC711A4308F52F72();
  _id_2700506DC3C63D78();

  switch (scripts\engine\utility::_id_53C4C53197386572(level.start_point, "trap_platforms")) {
    case "trap_platforms":
      _id_5FA5D20243E7740D();
      player = _id_62E11D77B25C1D30::_id_15FCF4C7B710C321(-5122, -5484, 2682, 2516, -1085, -1182);
      scripts\engine\utility::flag_set("vo_reach_rappel");
    case "trap_rappel":
      vo_rappel();
    default:
      return;
  }
}

_id_82E02994003CFFF7(player) {
  player._id_EEF929505A9B77B9 = 0;
  player._id_AED624967395163B = _id_62E11D77B25C1D30::_id_B8AE7D3FFA2CE9D8;
  level._id_93617D996E732D98 = ::_id_F5E227327AC5A2B4;
}

_id_5FA5D20243E7740D() {
  if(_id_AAC9CBB13160E609(-1500)) {
    return;
  }
  level endon("vo_reach_ventilation");

  foreach(player in level.players)
  thread _id_FA8B4208B93FBC22(player);

  childthread _id_5E67D56C78DE115A();
  childthread _id_05EBDF9B313C5E6C();
  childthread _id_EEDFEAD2B9A5045C();
  childthread _id_1FC24897F77C48D1();
  childthread _id_1460F1F5756B4A6E();
  childthread _id_ED9BB7CF0236FF30();
  childthread _id_10A5241A25F98C1C();
  childthread _id_BB8124EB704D69B5();
  childthread _id_4B9ADDBA6296BB5C();
  _id_6AFF89F47ADB0B72 = (-5482.88, 949.826, -2273.38);
  childthread _id_2035B1D36A184BE8(_id_6AFF89F47ADB0B72);
  childthread _id_9305EF2898AD9E1E();
  childthread _id_622F479EA1F7C8A8();
  childthread _id_A302F70D6D7904C1();
  childthread _id_4E851484FFE46607();
  childthread _id_C100829D21D0EAD8();
  childthread _id_5467809F53D9D19D();
  childthread _id_5040F2FC86F7B928();
  thread _id_6A9C52067369BA46();
}

_id_5E67D56C78DE115A() {
  _id_F29D066417572EA2 = (-4866.57, 813.536, -2797.01);
  player = _id_62E11D77B25C1D30::_id_F3C414CE5CCAB845(_id_F29D066417572EA2, 0.98, 0.3, 0, [], 200)[0];
  aliases = ["dx_cp_cpr2_trpp_fara_weaponsandequipmenth", "dx_cp_cpr2_trpp_pric_overerekitup", "dx_cp_cpr2_trpp_gazz_wecankitupoverhere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_05EBDF9B313C5E6C() {
  _id_0D32078955171127 = (-5260.02, 193.549, -2863.32);
  player = _id_62E11D77B25C1D30::_id_F3C414CE5CCAB845(_id_0D32078955171127, 0.97, 0.3, 0, [], 150)[0];
  aliases = ["dx_cp_cpr2_trpp_fara_entranceislocked", "dx_cp_cpr2_trpp_pric_entranceissealed", "dx_cp_cpr2_trpp_gazz_werestuckinhere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_1FC24897F77C48D1() {
  wait 1;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr2_trpp_pric_searchforanexitwenee");
  aliases = ["dx_cp_cpr2_trpp_fara_copy", "", "dx_cp_cpr2_trpp_gazz_solidcopy"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(level.price);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.6);
  thread _id_C0F2F18BF80DD817();
  thread _id_BEF6D6F24CF2D58F();

  if(scripts\engine\utility::flag("vo_platforms_found_lower_exit") || scripts\engine\utility::flag("vo_platforms_found_lower_ladder")) {
    return;
  }
  level endon("vo_platforms_found_lower_exit");
  level endon("vo_platforms_found_lower_ladder");
  wait 9;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr2_trpp_pric_anything");
  wait 0.3;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr2_trpp_fara_negative");
  wait 0.4;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level._id_E0632103DFA5BB19, "dx_cp_cpr2_trpp_gazz_nothingyet");
}

_id_BEF6D6F24CF2D58F() {
  level endon("game_ended");
  player = _id_7A2F2E0693A3B2B3();
  scripts\engine\utility::flag_set("vo_platforms_found_lower_ladder");
  aliases = ["dx_cp_cpr2_trpp_fara_theresaladder", "dx_cp_cpr2_trpp_pric_foundaladder", "dx_cp_cpr2_trpp_gazz_gotaladderere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.6);
}

_id_C0F2F18BF80DD817() {
  level endon("platform_top_enemies_killed");
  _id_9F925F5509626DF1 = (-4877.27, 1061.24, -2385);
  player = _id_62E11D77B25C1D30::_id_F3C414CE5CCAB845(_id_9F925F5509626DF1, 0.92, 0.4, 0, [], 600)[0];
  scripts\engine\utility::flag_set("vo_platforms_found_lower_exit");

  if(player.origin[2] > -2582) {
    return;
  }
  aliases = ["dx_cp_cpr2_trpp_fara_iseeaway", "dx_cp_cpr2_trpp_pric_foundourexit", "dx_cp_cpr2_trpp_gazz_visualontheexit"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.6);
  wait 10;
  scripts\engine\utility::flag_wait("vo_platforms_found_lower_ladder");

  if(_id_AAC9CBB13160E609(-2757) > 2) {
    return;
  }
  _id_7D2852D02216C876 = undefined;

  foreach(player in level.players) {
    if(!isalive(player) || !scripts\cp\utility::is_valid_player(1, 1)) {
      continue;
    }
    if(!isDefined(_id_7D2852D02216C876) || player.origin[2] > _id_7D2852D02216C876.origin[2])
      _id_7D2852D02216C876 = player;
  }

  aliases = ["dx_cp_cpr2_trpp_fara_taketheladder", "dx_cp_cpr2_trpp_pric_usetheladder", "dx_cp_cpr2_trpp_gazz_wecanusetheladder"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.4);
}

_id_1A7E234D729B5993(_id_E95CEB3B8D7CB4DC) {
  _id_24D3A2A0CCE9EFB6();

  for(player = _id_F428223F1149C9F5(_id_E95CEB3B8D7CB4DC); !_id_0C399B9BD0244642(3, ::_id_61E87BFAF2361A65, [player, _id_E95CEB3B8D7CB4DC]); player = _id_F428223F1149C9F5(_id_E95CEB3B8D7CB4DC)) {}

  aliases = ["dx_cp_cpr2_trpp_fara_climbupmove", "dx_cp_cpr2_trpp_pric_getclimbing", "dx_cp_cpr2_trpp_gazz_letsclimbup"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases);

  while(!_id_0C399B9BD0244642(1.5, ::_id_61E87BFAF2361A65, [player, _id_E95CEB3B8D7CB4DC]))
    player = _id_F428223F1149C9F5(_id_E95CEB3B8D7CB4DC);

  aliases = ["dx_cp_cpr2_trpp_fara_cantreach", "dx_cp_cpr2_trpp_pric_cantreachit", "dx_cp_cpr2_trpp_gazz_itstoofar"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.7);

  while(!_id_0C399B9BD0244642(0.5, ::_id_61E87BFAF2361A65, [player, _id_E95CEB3B8D7CB4DC]))
    player = _id_F428223F1149C9F5(_id_E95CEB3B8D7CB4DC);

  aliases = ["dx_cp_cpr2_trpp_fara_lookforsomethingtogr", "dx_cp_cpr2_trpp_pric_grabholdofsomething", "dx_cp_cpr2_trpp_gazz_trytograbaholdofsome"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.2);

  while(isalive(player) && (player.origin[2] < -2595.75 || !player _meth_415FE9EECA7B2E2B()))
    waitframe();

  aliases = ["dx_cp_cpr2_trpp_fara_gotit", "dx_cp_cpr2_trpp_pric_thatlldo", "dx_cp_cpr2_trpp_gazz_yepthatworked"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_ED9BB7CF0236FF30() {
  level endon("vo_enter_platforms_combat");
  scripts\engine\utility::flag_wait("platform_top_enemies_killed");
  thread _id_ADA3B59F9DE3792E();
  player = _id_62E11D77B25C1D30::_id_B826409EE2EFF7B6(-2429);

  while(!player isonground() || getaiarray().size > 0) {
    player = _id_62E11D77B25C1D30::_id_B826409EE2EFF7B6(-2429);
    waitframe();
  }

  wait 1;
  aliases = ["dx_cp_cpr2_trpp_fara_itsclear", "dx_cp_cpr2_trpp_pric_wereclear", "dx_cp_cpr2_trpp_gazz_allclear"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  level endon("vo_combat");

  if(scripts\engine\utility::flag("vo_combat")) {
    return;
  }
  player = _id_62E11D77B25C1D30::_id_513E47CE46DBF91F(-4689, -4944, 1337, 800, -2301, -2452);

  if(isDefined(player)) {
    foreach(_id_6EE5484560EC747C in level.players) {
      if(!isalive(_id_6EE5484560EC747C) || !_id_6EE5484560EC747C scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(_id_6EE5484560EC747C.origin[2] < player.origin[2])
        player = _id_6EE5484560EC747C;
    }

    aliases = ["dx_cp_cpr2_trpp_fara_copy", "dx_cp_cpr2_trpp_pric_rog", "dx_cp_cpr2_trpp_gazz_solidcopy"];
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);
    aliases = ["dx_cp_cpr2_trpp_fara_onourway", "dx_cp_cpr2_trpp_pric_cominup", "dx_cp_cpr2_trpp_gazz_headedyourway"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);
  }

  _id_62E11D77B25C1D30::_id_A2E15CA9CC1E141F(-4689, -4944, 1337, 800, -2301, -2452);
  aliases = ["dx_cp_cpr2_trpp_fara_watchyourflanks", "dx_cp_cpr2_trpp_pric_checkyourcorners", "dx_cp_cpr2_trpp_gazz_checkthosecorners"];
  _id_906B38780FE61467 = sortbydistance(level.players, (-4844.63, 1075.33, -2424));
  _id_7D2852D02216C876 = _id_906B38780FE61467[_id_906B38780FE61467.size - 1];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);
  wait 0.7;
  aliases = ["dx_cp_cpr2_trpp_fara_letsgo", "dx_cp_cpr2_trpp_pric_moveout", "dx_cp_cpr2_trpp_gazz_letsmove"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);
}

_id_ADA3B59F9DE3792E() {
  aliases = ["dx_cp_cpr2_trpp_fara_moreaqhere", "dx_cp_cpr2_trpp_pric_moreaq", "dx_cp_cpr2_trpp_gazz_moreaq"];

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(::getaiarray, 0.8, 0.2, 0, [], 500)[0]; !scripts\engine\utility::flag("vo_combat"); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(::getaiarray, 0.8, 0.2, 0, [], 500)[0]) {}

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_10A5241A25F98C1C() {
  if(!isDefined(level.tripwires) || !isDefined(level.tripwires.tripwires)) {
    return;
  }
  aliases = ["dx_cp_cpr2_trpp_fara_tripwirescareful", "dx_cp_cpr2_trpp_pric_tripwiresstaysharp", "dx_cp_cpr2_trpp_gazz_tripwireswatchyourst"];
  [player, target] = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(level.tripwires.tripwires, 0.9, 0.2, 0, [], 200);
  _id_C8BEAA3561609074 = scripts\engine\utility::getclosest(target, level.tripwires.tripwires, 20);

  if(isDefined(_id_C8BEAA3561609074) && _id_C8BEAA3561609074.triggered == 0)
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_34477069259ED380() {
  _id_E6CC733EFE9BC25C = [];
  aliases = ["dx_cp_cpr2_trpp_fara_hangjumpeffort", "dx_cp_cpr2_trpp_fara_hangjumpeffort_01", "dx_cp_cpr2_trpp_fara_hangjumpeffort_02"];
  _id_E6CC733EFE9BC25C[0] = scripts\engine\utility::create_deck(aliases);
  aliases = ["dx_cp_cpr2_trpp_pric_hangjumpeffort", "dx_cp_cpr2_trpp_pric_hangjumpeffort_01", "dx_cp_cpr2_trpp_pric_hangjumpeffort_02"];
  _id_E6CC733EFE9BC25C[1] = scripts\engine\utility::create_deck(aliases);
  aliases = ["dx_cp_cpr2_trpp_gazz_hangjumpeffort", "dx_cp_cpr2_trpp_gazz_hangjumpeffort_01", "dx_cp_cpr2_trpp_gazz_hangjumpeffort_02"];
  _id_E6CC733EFE9BC25C[2] = scripts\engine\utility::create_deck(aliases);

  for(;;) {
    player = _id_989A88E63186B0FB();
    thread _id_70F0DE1AC2A4EBA9(player, _id_E6CC733EFE9BC25C);
    waitframe();
  }
}

_id_70F0DE1AC2A4EBA9(player, _id_E6CC733EFE9BC25C) {
  if(!isDefined(player)) {
    return;
  }
  player._id_30977AE2A78FF7E5 = 1;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_E6CC733EFE9BC25C, 0, 0);

  while(isDefined(player) && player scripts\cp\utility::is_valid_player(1, 1) && player _meth_415FE9EECA7B2E2B())
    waitframe();

  if(isDefined(player))
    player._id_30977AE2A78FF7E5 = undefined;
}

_id_1460F1F5756B4A6E() {
  level endon("vo_enter_platforms_combat");
  level endon("vo_past_first_combat");

  if(scripts\engine\utility::flag("vo_past_first_combat")) {
    return;
  }
  scripts\engine\utility::flag_wait("platform_top_enemies_killed");
  player = _id_07D33A297FE77317(3);
  aliases = ["dx_cp_cpr2_trpp_fara_keepclimbing", "dx_cp_cpr2_trpp_pric_getyerarseupthere", "dx_cp_cpr2_trpp_gazz_keepitmoving"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_24D3A2A0CCE9EFB6() {
  player = _id_5C8F9B467406FFCC(400);
  aliases = ["dx_cp_cpr2_trpp_fara_ihearsomeone", "dx_cp_cpr2_trpp_pric_someoneshere", "dx_cp_cpr2_trpp_gazz_gotincominguptop"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
  thread _id_1E0C42CC37EEC872();
  scripts\engine\utility::flag_wait("platform_top_enemies_killed");
  wait 1;
  aliases = ["dx_cp_cpr2_trpp_fara_theyredown", "dx_cp_cpr2_trpp_pric_theyredone", "dx_cp_cpr2_trpp_gazz_droppedem"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level._id_15F31A57A5D19148, aliases, 0.3);
}

_id_1E0C42CC37EEC872() {
  setmusicstate("mx_cp_raid1_trap_firstkill");
}

_id_EEDFEAD2B9A5045C() {
  level waittill("ai_killed", pos, weapon, mod, attacker);
  level._id_15F31A57A5D19148 = attacker;
  scripts\engine\utility::flag_set("platform_top_enemies_killed");
}

_id_2700506DC3C63D78() {
  level._id_69FD5BACF8633C7D = ["", "dx_cp_cpr2_trpp_pric_movin", "dx_cp_cpr2_trpp_gazz_immoving"];
  level._id_ACF5A7E3AC33FD38 = ["", "dx_cp_cpr2_trpp_pric_movingup", "dx_cp_cpr2_trpp_gazz_pushinup"];
  level._id_76E1BC055755A7D8 = [];
  aliases = ["", "", ""];
  level._id_76E1BC055755A7D8[level._id_76E1BC055755A7D8.size] = scripts\engine\utility::create_deck(aliases, 1, 0);
  aliases = ["dx_cp_cpr2_trpp_pric_takinleft", "dx_cp_cpr2_trpp_pric_goinleft", "dx_cp_cpr2_trpp_pric_pushinleft"];
  level._id_76E1BC055755A7D8[level._id_76E1BC055755A7D8.size] = scripts\engine\utility::create_deck(aliases, 1, 0);
  aliases = ["dx_cp_cpr2_trpp_gazz_takinleft", "dx_cp_cpr2_trpp_gazz_movinleft", "dx_cp_cpr2_trpp_gazz_headinleft"];
  level._id_76E1BC055755A7D8[level._id_76E1BC055755A7D8.size] = scripts\engine\utility::create_deck(aliases, 1, 0);
  level._id_649960BD21A9CB0D = [];
  aliases = ["", "", ""];
  level._id_649960BD21A9CB0D[level._id_649960BD21A9CB0D.size] = scripts\engine\utility::create_deck(aliases);
  aliases = ["dx_cp_cpr2_trpp_pric_goinright", "dx_cp_cpr2_trpp_pric_takinright", "dx_cp_cpr2_trpp_pric_pushinright"];
  level._id_649960BD21A9CB0D[level._id_649960BD21A9CB0D.size] = scripts\engine\utility::create_deck(aliases);
  aliases = ["dx_cp_cpr2_trpp_gazz_movinright", "dx_cp_cpr2_trpp_gazz_headinright", "dx_cp_cpr2_trpp_gazz_takinright"];
  level._id_649960BD21A9CB0D[level._id_649960BD21A9CB0D.size] = scripts\engine\utility::create_deck(aliases);
}

_id_FA8B4208B93FBC22(player) {
  if(!isDefined(player._id_938E8B2CA6549759) || player._id_938E8B2CA6549759 == "farah") {
    return;
  }
  if(scripts\engine\utility::flag("vo_past_first_combat")) {
    return;
  }
  level endon("vo_past_first_combat");

  if(scripts\engine\utility::flag("vo_platformsUpperPlayerReachedExit")) {
    return;
  }
  level endon("vo_platformsUpperPlayerReachedExit");
  player endon("death_or_disconnect");

  while(isalive(player) && player.origin[0] < -4690)
    waitframe();

  while(isalive(player) && (player.origin[1] < 1400 || player.origin[0] > -4800 && player.origin[1] < 1665))
    waitframe();

  level notify("vo_enter_platforms_combat");
  level._id_5A215F004934F468 = 0;

  if(player.origin[1] >= 1665) {
    if(scripts\engine\utility::time_has_passed(level._id_5A215F004934F468, 10)) {
      level._id_5A215F004934F468 = gettime();
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, level._id_649960BD21A9CB0D, 0.3);
    }

    while(isalive(player) && player.origin[1] >= 1665)
      waitframe();
  }

  for(;;) {
    if(scripts\engine\utility::time_has_passed(level._id_5A215F004934F468, 10)) {
      level._id_5A215F004934F468 = gettime();
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, level._id_76E1BC055755A7D8, 0.3);
    }

    wait 1;

    while(isalive(player) && player.origin[1] < 1665)
      waitframe();

    if(scripts\engine\utility::time_has_passed(level._id_5A215F004934F468, 10)) {
      level._id_5A215F004934F468 = gettime();
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, level._id_649960BD21A9CB0D, 0.3);
    }

    wait 1;

    while(isalive(player) && player.origin[1] >= 1665)
      waitframe();
  }
}

_id_3B16F8CFD0F7972E(_id_5BA045294C1D4D1B) {
  if(!isDefined(game["vo_keycardsFound"]))
    game["vo_keycardsFound"] = [];

  if(scripts\engine\utility::array_contains(game["vo_keycardsFound"], _id_5BA045294C1D4D1B)) {
    return;
  }
  if(game["vo_keycardsFound"].size == 0) {
    aliases = ["dx_cp_cpr2_trpp_fara_foundakeycard", "dx_cp_cpr2_trpp_pric_foundakeycard", "dx_cp_cpr2_trpp_gazz_foundakeycard"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(self, aliases, 0.3);
    aliases = ["dx_cp_cpr2_trpp_fara_holdontoit", "dx_cp_cpr2_trpp_pric_keepitonyou", "dx_cp_cpr2_trpp_gazz_dontloseit"];
    player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(self);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  } else if(game["vo_keycardsFound"].size == 1) {
    aliases = ["dx_cp_cpr2_trpp_fara_theresanotherkeycard", "dx_cp_cpr2_trpp_pric_anotherkeycarduphere", "dx_cp_cpr2_trpp_gazz_foundanotherkeycard"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(self, aliases, 0.3);
  } else if(game["vo_keycardsFound"].size == 2) {
    aliases = ["dx_cp_cpr2_trpp_fara_anotherkeycardthatst", "dx_cp_cpr2_trpp_pric_foundathirdkeycard", "dx_cp_cpr2_trpp_gazz_keycardnumberthree"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(self, aliases, 0.3);
  }

  game["vo_keycardsFound"][game["vo_keycardsFound"].size] = _id_5BA045294C1D4D1B;
}

_id_BB8124EB704D69B5() {
  player = _id_62E11D77B25C1D30::_id_3B46C8D1F1AE39D3(0, -6000);
  scripts\engine\utility::flag_set("vo_past_first_combat");

  if(scripts\engine\utility::flag("vo_platformsUpperPlayerReachedExit")) {
    return;
  }
  level endon("vo_platformsUpperPlayerReachedExit");
  childthread _id_7B9EAD48B36C7203();

  while(getaiarray().size > 0)
    level waittill("ai_killed");

  wait 1;
  thread _id_1637825A39DFD336();
  level endon("vo_player_reach_upper_silo");
  level endon("vo_player_steam_damaged");

  if(scripts\engine\utility::flag("vo_reach_upper_exit")) {
    return;
  }
  level endon("vo_reach_upper_exit");
  aliases = ["dx_cp_cpr2_trpp_fara_itsclear", "dx_cp_cpr2_trpp_pric_clear", "dx_cp_cpr2_trpp_gazz_allclear_01"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  _id_63A94F469B35C9AF = (-6069.37, 1257.58, -2358.55);
  player = _id_62E11D77B25C1D30::_id_F3C414CE5CCAB845(_id_63A94F469B35C9AF, 0.8, 0.3, 0, undefined, 300)[0];
  aliases = ["dx_cp_cpr2_trpp_fara_thisway", "dx_cp_cpr2_trpp_pric_throughhere", "dx_cp_cpr2_trpp_gazz_thislookslikeawaythr"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 0.2;
  aliases = ["dx_cp_cpr2_trpp_fara_timeyourmovement", "dx_cp_cpr2_trpp_pric_mindyourtiming", "dx_cp_cpr2_trpp_gazz_havetotimeit"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_1637825A39DFD336() {
  if(scripts\engine\utility::flag("vo_platformsUpperPlayerReachedExit")) {
    return;
  }
  level endon("vo_platformsUpperPlayerReachedExit");
  result = _id_CA233BC61873024C();
  player = result[0];
  attacker = result[1];

  if(!player scripts\engine\math::is_point_in_front(attacker.origin)) {
    aliases = ["dx_cp_cpr2_trpp_fara_behindus", "dx_cp_cpr2_trpp_pric_contactrear", "dx_cp_cpr2_trpp_gazz_checksix"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  }

  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(::getaiarray, 0.8, 0.2, 0, [], 500)[0];
  aliases = ["dx_cp_cpr2_trpp_fara_moreaqtheyrearmored", "dx_cp_cpr2_trpp_pric_armoredaq", "dx_cp_cpr2_trpp_gazz_armoredaq"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  victim = undefined;

  while(getaiarray().size > 0) {
    level waittill("ai_killed", pos, weapon, mod, attacker, victim);

    if(isDefined(victim) && victim scripts\cp\utility::isjuggernaut() && isPlayer(attacker)) {
      aliases = ["dx_cp_cpr2_trpp_fara_enemyjuggernautisdow", "dx_cp_cpr2_trpp_gazz_enemyjuggernautdestr", "dx_cp_cpr2_trpp_pric_enemyjuggernautisdow"];
      thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(attacker, aliases, 1.2);
    }
  }

  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr2_trpr_fara_allclear", 1.5);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr2_trpr_pric_clear_01", 0.3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level._id_E0632103DFA5BB19, "dx_cp_cpr2_trpr_gazz_clear", 0.2);
}

_id_7B9EAD48B36C7203() {
  if(scripts\engine\utility::flag("vo_reach_upper_exit")) {
    return;
  }
  level endon("vo_reach_upper_exit");
  player = _id_0EDCF07839930CA2("steam_damage")[0];
  scripts\engine\utility::flag_set("vo_player_steam_damaged");
  aliases = ["dx_cp_cpr2_trpp_fara_steamreactioneffort", "dx_cp_cpr2_trpp_pric_steamreactioneffort", "dx_cp_cpr2_trpp_gazz_steamreactioneffort"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0, 1, 0);
  level endon("vo_combat");

  if(scripts\engine\utility::flag("vo_combat")) {
    return;
  }
  aliases = ["dx_cp_cpr2_trpp_fara_areyouhurt", "dx_cp_cpr2_trpp_pric_yousolid", "dx_cp_cpr2_trpp_gazz_yougood"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.6);
  wait 1;
  aliases = ["dx_cp_cpr2_trpp_fara_imgood", "dx_cp_cpr2_trpp_pric_hitshard", "dx_cp_cpr2_trpp_gazz_packsapunch"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  scripts\engine\utility::flag_clear("vo_player_steam_damaged");
}

_id_4B9ADDBA6296BB5C() {
  level endon("vo_spotted_hangs");
  level endon("vo_spotted_valve");
  _id_E969C49D993B0091 = (-5736.98, 724.565, -2262.26);
  player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(_id_E969C49D993B0091, 200)[0];
  scripts\engine\utility::flag_set("vo_player_reach_upper_silo");
  scripts\engine\utility::flag_waitopen("vo_player_steam_damaged");
  aliases = ["dx_cp_cpr2_trpp_fara_foundthenextfloor", "dx_cp_cpr2_trpp_pric_locatedthenextfloor", "dx_cp_cpr2_trpp_gazz_madeittothenextfloor"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  wait 6;
  _id_52DA456EFC538FCD = (-5262.54, 722.72, -2634.18);
  _id_62E11D77B25C1D30::_id_D38E56EFB3AF96B1(_id_52DA456EFC538FCD, 515, undefined, 1);
  aliases = ["dx_cp_cpr2_trpp_fara_searchforanexit", "dx_cp_cpr2_trpp_pric_wellneedanotherexit", "dx_cp_cpr2_trpp_gazz_nowwejustneedawayout"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.4);
}

_id_2035B1D36A184BE8(_id_CCDCDA1A56E931B5, _id_231877E20A6D13F5) {
  distsq = squared(500);

  for(;;) {
    player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_CCDCDA1A56E931B5, 0.85, 0.4, 0, undefined, 300)[0];
    _id_49BE45F83BE0135E = 0;

    foreach(_id_6EE5484560EC747C in level.players) {
      if(_id_6EE5484560EC747C == player) {
        continue;
      }
      if(distancesquared(_id_6EE5484560EC747C.origin, player.origin) < distsq) {
        _id_49BE45F83BE0135E = 1;
        break;
      }
    }

    if(_id_49BE45F83BE0135E) {
      break;
    }
  }

  aliases = ["dx_cp_cpr2_trpp_fara_watchyourstep", "dx_cp_cpr2_trpp_pric_watchyourstep", "dx_cp_cpr2_trpp_gazz_mindthegapsyeah"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_A71ED552F1930AAF() {
  height = -2390;
  _id_52DA456EFC538FCD = (-5262.54, 722.72, -2634.18);
  _id_791C9D56EBDB0B8E = squared(450);

  for(;;) {
    foreach(player in level.players) {
      if(!isalive(player) || player isspectatingplayer()) {
        continue;
      }
      if(distance2dsquared(_id_52DA456EFC538FCD, player.origin) > _id_791C9D56EBDB0B8E || player.origin[2] < -2420) {
        continue;
      }
      if(player.origin[2] < height)
        return player;
    }

    waitframe();
  }
}

_id_9305EF2898AD9E1E() {
  for(;;) {
    player = _id_A71ED552F1930AAF();
    aliases = ["dx_cp_cpr2_trpp_fara_jumpfaileffort", "dx_cp_cpr2_trpp_pric_jumpfaileffort", "dx_cp_cpr2_trpp_gazz_jumpfaileffort"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0, 1, 0);

    if(player._id_938E8B2CA6549759 == "farah")
      aliases = [undefined, "dx_cp_cpr2_trpp_pric_farah_01", "dx_cp_cpr2_trpp_gazz_farah_01"];
    else if(player._id_938E8B2CA6549759 == "price")
      aliases = ["dx_cp_cpr2_trpp_fara_captain_01", undefined, "dx_cp_cpr2_trpp_gazz_price_01"];
    else if(player._id_938E8B2CA6549759 == "gaz")
      aliases = ["dx_cp_cpr2_trpp_fara_gaz", "dx_cp_cpr2_trpp_pric_gaz_01"];
    else
      aliases = undefined;

    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(player, 0.7, 0.1, 0, player, undefined, undefined, 2);

    if(isDefined(_id_7D2852D02216C876))
      _id_7D2852D02216C876 = _id_7D2852D02216C876[0];

    if(isDefined(aliases) && isDefined(_id_7D2852D02216C876))
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0, 1, 0);

    while(!player isonground())
      waitframe();

    if(istrue(level._id_7E92075AD4561D88)) {} else {
      level._id_7E92075AD4561D88 = 1;
      wait 1;

      if(!isDefined(_id_7D2852D02216C876))
        _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);

      if(!isalive(player) || player.origin[2] > -2344.02 || _id_0AFB7E332AEE4BF2::player_in_laststand(player)) {} else {
        aliases = ["dx_cp_cpr2_trpp_fara_areyouhurt_01", "dx_cp_cpr2_trpp_pric_youbroken", "dx_cp_cpr2_trpp_gazz_youokay"];
        thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases);
        aliases = ["dx_cp_cpr2_trpp_fara_imokay", "dx_cp_cpr2_trpp_pric_stillere", "dx_cp_cpr2_trpp_gazz_walkinitoff"];
        thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);

        if(!istrue(level._id_0EC7106FFD9CF89F)) {
          return;
        }
        aliases = ["dx_cp_cpr2_trpp_fara_copyclimbbacktoususe", "dx_cp_cpr2_trpp_pric_rogworkyourwaybackup", "dx_cp_cpr2_trpp_gazz_copygetbackerewhenyo"];
        thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.4);
      }
    }

    waitframe();
  }
}

_id_622F479EA1F7C8A8() {
  level endon("vo_platforms_upper_exit");
  _id_3B0DCBA40867F731 = (-5230.53, 1219.48, -2172.61);
  _id_B146311DF0E031C5 = (-5229.57, 1219.41, -2017.5);
  _id_870394E45BE96959 = (-5223.61, 1218.92, -2230.5);
  player = _id_55B1E3DB3A1FEFEE(_id_870394E45BE96959, 100);
  scripts\engine\utility::flag_set("vo_spotted_hangs");
  aliases = ["dx_cp_cpr2_trpp_fara_hereusethesetoclimbu", "dx_cp_cpr2_trpp_pric_climbuphere", "dx_cp_cpr2_trpp_gazz_wecanclimbthese"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_A302F70D6D7904C1() {
  _id_F1C12E7F5B714194 = getEntArray("intro_steam_valve", "targetname");

  if(_id_F1C12E7F5B714194[0].origin[2] < _id_F1C12E7F5B714194[1].origin[2]) {
    level._id_C817410DEB0CD184 = _id_F1C12E7F5B714194[0];
    level._id_477302BF52CFB1A3 = _id_F1C12E7F5B714194[1];
  } else {
    level._id_477302BF52CFB1A3 = _id_F1C12E7F5B714194[0];
    level._id_C817410DEB0CD184 = _id_F1C12E7F5B714194[1];
  }

  _id_63A94F469B35C9AF = (-5327.69, 1216.05, -2014.36);
  _id_3AD974EE99198ECC = scripts\engine\utility::getStructArray(level._id_C817410DEB0CD184.target, "targetname");

  if(distancesquared(_id_63A94F469B35C9AF, _id_3AD974EE99198ECC[0].origin) < distancesquared(_id_63A94F469B35C9AF, _id_3AD974EE99198ECC[1].origin)) {
    level._id_CC7FC99546647BD3 = _id_3AD974EE99198ECC[0];
    level._id_82706F9F5D3677DE = _id_3AD974EE99198ECC[1];
  } else {
    level._id_82706F9F5D3677DE = _id_3AD974EE99198ECC[0];
    level._id_CC7FC99546647BD3 = _id_3AD974EE99198ECC[1];
  }

  level._id_477302BF52CFB1A3 waittill("trigger");
  scripts\engine\utility::flag_set("vo_playerUsedUpperValve");
}

_id_4E851484FFE46607() {
  level endon("vo_platforms_upper_exit");
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(level._id_C817410DEB0CD184, 0.95, 0.4, 0, undefined, 200)[0];
  scripts\engine\utility::flag_set("vo_spotted_valve");
  aliases = ["dx_cp_cpr2_trpp_fara_theresavalve", "dx_cp_cpr2_trpp_pric_foundavalve", "dx_cp_cpr2_trpp_gazz_gotavalvehere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  level._id_0EC7106FFD9CF89F = 1;
}

_id_C100829D21D0EAD8() {
  while(level._id_CC7FC99546647BD3.script_parameters == "on")
    waitframe();

  scripts\engine\utility::flag_set("vo_activated_valve");
  player = _id_62E11D77B25C1D30::_id_F3C414CE5CCAB845([level._id_82706F9F5D3677DE, level._id_CC7FC99546647BD3], 0.9, 0.4, 0, undefined, 400)[0];

  if(!istrue(level._id_FE57C19426A17715))
    aliases = ["dx_cp_cpr2_trpp_fara_itmovedthesteam", "dx_cp_cpr2_trpp_pric_itreroutedthesteam", "dx_cp_cpr2_trpp_gazz_itroutedthesteamover"];
  else
    aliases = ["dx_cp_cpr2_trpp_fara_thatworked", "dx_cp_cpr2_trpp_pric_thatdidit", "dx_cp_cpr2_trpp_gazz_wereinbusiness"];

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_5467809F53D9D19D() {
  _id_63A94F469B35C9AF = (-5327.69, 1216.05, -2014.36);
  maxdist = 80;

  for(;;) {
    for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_63A94F469B35C9AF, 0.9, 0.3, 0, undefined, maxdist)[0]; isalive(player) && !player _meth_415FE9EECA7B2E2B(); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_63A94F469B35C9AF, 0.9, 0.3, 0, undefined, maxdist)[0]) {}

    level._id_FE57C19426A17715 = 1;

    if(level._id_CC7FC99546647BD3.script_parameters == "on") {
      aliases = ["dx_cp_cpr2_trpp_fara_weneedtoshutoffthest", "dx_cp_cpr2_trpp_pric_thesteamsblockingus", "dx_cp_cpr2_trpp_gazz_cantgetpastthatsteam"];
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);

      if(scripts\engine\utility::flag("vo_spotted_valve")) {
        _id_9F8413BB6B187C8D = sortbydistance(_id_62E11D77B25C1D30::_id_29714545859E6445(), level._id_C817410DEB0CD184.origin);
        _id_7D2852D02216C876 = _id_9F8413BB6B187C8D[_id_9F8413BB6B187C8D.size - 1];
        wait 1;

        if(level._id_CC7FC99546647BD3.script_parameters == "off" || scripts\engine\utility::flag("vo_activated_valve")) {
          return;
        }
        aliases = ["dx_cp_cpr2_trpp_fara_tryusingthevalve", "dx_cp_cpr2_trpp_pric_usethatvalve", "dx_cp_cpr2_trpp_gazz_trythatvalve"];
        _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.2);
      }

      return;
    }
  }
}

_id_5040F2FC86F7B928() {
  _id_36C12D04A03471D6 = (-5378.47, 1205.24, -2065.09);
  _id_0567A13B0E922974 = (-5458.67, 1177.59, -2025.7);
  distsq = squared(50);

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_0567A13B0E922974, 0.85, 0.4, 0, undefined, 150)[0]; isalive(player) && (level._id_82706F9F5D3677DE.script_parameters == "off" || distancesquared(_id_36C12D04A03471D6, player.origin) > distsq); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_0567A13B0E922974, 0.85, 0.4, 0, undefined, 150)[0]) {}

  aliases = ["dx_cp_cpr2_trpp_fara_imblockeduphere", "dx_cp_cpr2_trpp_pric_itsblocked", "dx_cp_cpr2_trpp_gazz_blockeduphere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  _id_B083B57949067448(player, _id_36C12D04A03471D6, distsq, _id_0567A13B0E922974);
  _id_47D6B5B8455C9E93(_id_36C12D04A03471D6, distsq, _id_0567A13B0E922974);
}

_id_B083B57949067448(player, _id_36C12D04A03471D6, distsq, _id_0567A13B0E922974) {
  level._id_C817410DEB0CD184 endon("trigger");
  level._id_477302BF52CFB1A3 endon("trigger");
  wait 2;

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_0567A13B0E922974, 0.85, 0.4, 0, undefined, 150)[0]; isalive(player) && (level._id_82706F9F5D3677DE.script_parameters == "off" || distancesquared(_id_36C12D04A03471D6, player.origin) > distsq); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_0567A13B0E922974, 0.85, 0.4, 0, undefined, 150)[0]) {}

  aliases = ["dx_cp_cpr2_trpp_fara_trythevalveagain", "dx_cp_cpr2_trpp_pric_usethevalveagain", "dx_cp_cpr2_trpp_gazz_hitthevalveagain"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_47D6B5B8455C9E93(_id_36C12D04A03471D6, distsq, _id_0567A13B0E922974) {
  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_0567A13B0E922974, 0.85, 0.4, 0, undefined, 150)[0]; isalive(player) && (level._id_82706F9F5D3677DE.script_parameters == "off" || distancesquared(_id_36C12D04A03471D6, player.origin) > distsq || _id_AAC9CBB13160E609(-1970) < 1); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_0567A13B0E922974, 0.85, 0.4, 0, undefined, 150)[0]) {}

  aliases = ["dx_cp_cpr2_trpp_fara_itsblocked", "dx_cp_cpr2_trpp_pric_imblockeddownhere", "dx_cp_cpr2_trpp_gazz_itsblockedagain"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  _id_68ABB68161F72929 = player;
  player = _id_62E11D77B25C1D30::_id_B826409EE2EFF7B6(-1970);
  scripts\engine\utility::flag_set("vo_reach_upper_exit");

  if(level._id_82706F9F5D3677DE.script_parameters == "off") {
    return;
  }
  if(!scripts\engine\utility::flag("vo_playerUsedUpperValve")) {
    aliases = ["dx_cp_cpr2_trpp_fara_thereshouldbeavalveu", "dx_cp_cpr2_trpp_pric_lookforavalveuphere", "dx_cp_cpr2_trpp_gazz_weneedanothervalve"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  }

  if(level._id_82706F9F5D3677DE.script_parameters == "off") {
    return;
  }
  level._id_477302BF52CFB1A3 waittill("trigger", player);
  wait 2.5;
  aliases = ["dx_cp_cpr2_trpp_fara_tryitnow", "dx_cp_cpr2_trpp_pric_thisshouldwork", "dx_cp_cpr2_trpp_gazz_shouldbegoodnow"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);

  for(player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_0567A13B0E922974, 0.85, 0.4, 0, undefined, 150)[0]; isalive(player) && (level._id_82706F9F5D3677DE.script_parameters == "off" || distancesquared(_id_36C12D04A03471D6, player.origin) > distsq || _id_AAC9CBB13160E609(-1970) < 2); player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_0567A13B0E922974, 0.85, 0.4, 0, _id_68ABB68161F72929, 150)[0]) {}

  aliases = ["dx_cp_cpr2_trpp_fara_itsblocked", "dx_cp_cpr2_trpp_pric_imblockeddownhere", "dx_cp_cpr2_trpp_gazz_itsblockedagain"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_6A9C52067369BA46() {
  player = _id_62E11D77B25C1D30::_id_B826409EE2EFF7B6(-1970);

  while(!player isonground()) {
    player = _id_62E11D77B25C1D30::_id_B826409EE2EFF7B6(-1970);
    waitframe();
  }

  thread _id_7DDC19C18B0A379A();
  thread _id_AEE61E36FD0018E2();
  scripts\engine\utility::flag_set("vo_platformsUpperPlayerReachedExit");
  aliases = ["dx_cp_cpr2_trpp_fara_wereclearmoveup", "dx_cp_cpr2_trpp_pric_allclearclimbup", "dx_cp_cpr2_trpp_gazz_itsclearheadup"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  aliases = ["dx_cp_cpr2_trpp_fara_copy", "dx_cp_cpr2_trpp_pric_rog", "dx_cp_cpr2_trpp_gazz_solidcopy"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_7DDC19C18B0A379A() {
  _id_37162ADD31FFCB93 = (-5828.53, 1352.29, -1929);

  for(;;) {
    player = _id_62E11D77B25C1D30::_id_45831CF64D17BBB1((-5785.41, 1309.59, -1929), 135);

    if(_id_AAC9CBB13160E609(-1970) == 3 && player getstance() == "prone") {
      break;
    }

    waitframe();
  }

  aliases = ["dx_cp_cpr2_trpp_fara_wecancrawlthrough", "dx_cp_cpr2_trpp_pric_crawlunderit", "dx_cp_cpr2_trpp_gazz_crawlthroughhere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  thread _id_F4ED09434CED02F2();
}

_id_F4ED09434CED02F2() {
  wait 3;
  _id_37162ADD31FFCB93 = (-5828.53, 1352.29, -1929);

  for(;;) {
    player = _id_62E11D77B25C1D30::_id_45831CF64D17BBB1((-5785.41, 1309.59, -1929), 135);

    if(_id_AAC9CBB13160E609(-1970) == 3) {
      break;
    }

    waitframe();
  }

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr2_trpp_fara_laswellsaidthiswasah", 0.3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level._id_E0632103DFA5BB19, "dx_cp_cpr2_trpp_gazz_someoneishelpingthem", 0.3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr2_trpp_pric_orleadingthem", 0.4);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level._id_E0632103DFA5BB19, "dx_cp_cpr2_trpp_gazz_ithoughtwecutthehead", 0.2);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr2_trpp_pric_differentsnakethison", 0.3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr2_trpp_fara_godhelpus", 0.3);
  scripts\engine\utility::flag_set("vo_crawl_finish");
  _id_E04CD3579B7FEA7F();
}

_id_18284518C5EF7BD3(_id_656F0AE440B1B5D5) {
  player = _id_D1FCFFA79675A570(_id_656F0AE440B1B5D5);
  scripts\engine\utility::flag_set("vo_spottedClaymore");

  if(!isDefined(player)) {
    return;
  }
  aliases = ["dx_cp_cpr2_trpp_fara_claymoredontmove", "dx_cp_cpr2_trpp_pric_holduptheresaclaymor", "dx_cp_cpr2_trpp_gazz_waitclaymoreaheadofu"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_D1FCFFA79675A570(_id_656F0AE440B1B5D5) {
  level endon("vo_spottedClaymore");
  _id_656F0AE440B1B5D5 endon("mine_triggered");
  _id_656F0AE440B1B5D5 endon("mine_destroyed");
  _id_656F0AE440B1B5D5 endon("death");
  scripts\engine\utility::flag_wait("vo_crawl_finish");
  return _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_656F0AE440B1B5D5, 0.9, 0.3, 0, undefined, 300, (0, 0, 30))[0];
}

_id_E04CD3579B7FEA7F() {
  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    scripts\engine\utility::flag_wait("vo_spottedClaymore");

  origin = (-5917.3, 2732.08, -1957.29);

  for(;;) {
    player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(origin, 0.5, 0.3, 0, undefined, 600)[0];

    if(player.origin[2] > -1957 || !player isonground()) {
      continue;
    }
    break;
  }

  aliases = ["dx_cp_cpr2_trpo_fara_clear", "dx_cp_cpr2_trpo_pric_clear", "dx_cp_cpr2_trpo_gazz_clear"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_AEE61E36FD0018E2() {
  level endon("vo_reach_rappel");
  scripts\engine\utility::flag_set("vo_past_first_combat");
  childthread _id_312BD900E6E03A03();
  childthread _id_11EF69AE38E19B4E();
  scripts\engine\utility::flag_wait("vo_crawl_finish");
  thread _id_C0D7A75C7BC77E74();
  thread _id_B729B5221D8F26C6(-3076, -4787, 2804, 2439, -1900, -2233);
  childthread _id_BE0FCCF296CA1A14();
  childthread _id_9BE6885E8AA7F1FE();
  childthread _id_23141445C0DA45FC();
  childthread _id_7A3A3F2AA4C44C5D();
  childthread _id_8231A8140F24D62B();
  childthread _id_990DC6001D9315E7(-2963, -3494, 2857, 2370, -727, -1869);
  childthread _id_581A63D092D362A7(-2963, -3494, 2857, 2370, -727, -1869, "vo_playersClearedLowerVentilation");
  childthread _id_1B982224713FC1A3();
  childthread _id_6499C8456FC62A10();
  childthread _id_21ED32E53F399F27();
  childthread _id_55D0EC4FB7A0BEC8();
  childthread _id_7CB68FF453F923B8();
  childthread _id_75A544A3B4D51339();
  childthread _id_25CA8E03F0D8F35E();
  childthread _id_58CE102E3BF50C81();
  childthread _id_1B0B144D8A12D5F8();
}

_id_312BD900E6E03A03() {
  _id_02F7A447AEEF0644 = (-5891.99, 2346.29, -1927.29);

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    scripts\engine\utility::flag_wait("vo_spottedClaymore");

    while(isDefined(level._id_C4EA99FA46D27C12) && scripts\engine\utility::array_removeundefined(level._id_C4EA99FA46D27C12).size > 0)
      waitframe();
  }

  for(;;) {
    player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_02F7A447AEEF0644, 0.7, 0.5, 0, undefined, 200)[0];

    if(player.origin[2] < -1950 || !scripts\engine\utility::flag("vo_crawl_finish")) {
      continue;
    }
    _id_C3D39F87A49B2B6F = 1;

    foreach(_id_6EE5484560EC747C in scripts\engine\utility::array_remove(level.players, player)) {
      if(_id_6EE5484560EC747C.origin[2] > -1950) {
        _id_C3D39F87A49B2B6F = 0;
        break;
      }
    }

    if(_id_C3D39F87A49B2B6F) {
      return;
    }
    aliases = ["dx_cp_cpr2_trpp_fara_dropdown", "dx_cp_cpr2_trpp_pric_downhere", "dx_cp_cpr2_trpp_gazz_dropdownhere"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
    return;
  }
}

_id_11EF69AE38E19B4E() {
  player = _id_82D126B88255888E();
  aliases = ["dx_cp_cpr2_trpr_fara_lookupaqsmovingin", "dx_cp_cpr2_trpr_pric_contactuphigh", "dx_cp_cpr2_trpr_gazz_headsupaqshere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_5E933F689131666E() {
  self endon("death");
  self waittill("damage", dmg, attacker);

  if(isPlayer(attacker)) {
    scripts\engine\utility::flag_set("vo_engagedVentilationKeybearer");
    thread _id_7CAF2AB9662CAB05();
  }
}

_id_7CAF2AB9662CAB05() {
  self waittill("death");
  scripts\engine\utility::flag_clear("vo_engagedVentilationKeybearer");
}

_id_BE0FCCF296CA1A14() {
  level endon("platform_sequence_active");
  _id_62E11D77B25C1D30::_id_07F379814DFAF520(-2959, -4856, 2843, 2336, -1434, -1890);
  _id_62E11D77B25C1D30::_id_537E4A75785D15F5(-2959, -4788, 2835, 2336, -1553, -1896);
  wait 1;
  _id_6CB6920473D33EE3 = (-4818.56, 2606.38, -1732.9);
  aliases = ["dx_cp_cpr2_trpo_fara_clear", "dx_cp_cpr2_trpo_pric_clear", "dx_cp_cpr2_trpo_gazz_clear"];
  player = scripts\engine\utility::getclosest(_id_6CB6920473D33EE3, level.players);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);

  if(scripts\engine\utility::flag("vo_engagedVentilationKeybearer")) {
    aliases = ["dx_cp_cpr2_trpp_fara_onegotaway", "dx_cp_cpr2_trpp_pric_onegotaway", "dx_cp_cpr2_trpp_gazz_oneranoff"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.6);
    aliases = ["dx_cp_cpr2_trpp_fara_theyllbereadyforus", undefined, "dx_cp_cpr2_trpp_gazz_expectcontactupahead"];
    player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(level.price);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);
    aliases = [undefined, "dx_cp_cpr2_trpp_pric_letsnotkeepemwaiting", "dx_cp_cpr2_trpp_gazz_letsnotkeepemwaiting"];
    player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74([level.farah, player]);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  }

  scripts\engine\utility::flag_set("vo_ventilationClear");
  wait 1;

  if(!scripts\engine\utility::flag("vo_spotted_vetilation_controls")) {
    aliases = ["dx_cp_cpr2_trpp_fara_lookforawaytocross", "dx_cp_cpr2_trpp_pric_letsfindawaytocross", "dx_cp_cpr2_trpp_gazz_wellneedawaytocross"];
    player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  }

  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_6CB6920473D33EE3, 0.7, 0.3, 0, level.price, 500)[0];
  wait 3;
  aliases = ["dx_cp_cpr2_trpp_fara_whatisthis", undefined, "dx_cp_cpr2_trpp_gazz_wherearewe"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr2_trpp_pric_ventilation", 0.2);
}

_id_23141445C0DA45FC() {
  level endon("platform_sequence_active");
  _id_A12C85A2396E5429 = (-4826.3, 2609.34, -1810.03);
  _id_BF41A4C953DC4398 = (-4826.3, 2473.92, -1810.03);
  scripts\engine\utility::flag_wait("vo_ventilationClear");
  player = _id_62E11D77B25C1D30::_id_57E617784FB02909(_id_A12C85A2396E5429, _id_BF41A4C953DC4398, 0.95, 0.5, 0, undefined, 150);
  scripts\engine\utility::flag_set("vo_spotted_vetilation_controls");
  aliases = ["dx_cp_cpr2_trpp_fara_controlsarehere", "dx_cp_cpr2_trpp_pric_controlshere", "dx_cp_cpr2_trpp_gazz_gotcontrolshere"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  aliases = ["dx_cp_cpr2_trpp_fara_theyreforthevents", "dx_cp_cpr2_trpp_pric_theyopenthevents", "dx_cp_cpr2_trpp_gazz_startsaventingsequen"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 1.3);
  wait 8;
  aliases = ["dx_cp_cpr2_trpp_fara_wejustneedawayacross", "dx_cp_cpr2_trpp_pric_anyideas", "dx_cp_cpr2_trpp_gazz_couldbeadeadend"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.2);
  aliases = ["dx_cp_cpr2_trpp_fara_wetrythecontrols", "dx_cp_cpr2_trpp_pric_wehavecontrols", "dx_cp_cpr2_trpp_gazz_letsseewhatthecontro"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 5;
  aliases = ["dx_cp_cpr2_trpp_fara_theresthreeswitches", "dx_cp_cpr2_trpp_pric_controlshavethreeswi", "dx_cp_cpr2_trpp_gazz_threeswitchesontheco"];
  player = _id_62E11D77B25C1D30::_id_57E617784FB02909(_id_A12C85A2396E5429, _id_BF41A4C953DC4398, 0.95, 0.5, 0, undefined, 150);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  aliases = ["dx_cp_cpr2_trpp_fara_theresthreeofus", "dx_cp_cpr2_trpp_pric_andtheresthreeofus", "dx_cp_cpr2_trpp_gazz_oneforeachofus"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.2);
}

_id_9BE6885E8AA7F1FE() {
  level endon("vo_jump_on_vents");
  scripts\engine\utility::flag_wait("platform_sequence_active");
  _id_BE6AF5030B2978F8 = (-4605.31, 2678.11, -1802);
  end = (-3641.26, 2678.11, -1802);
  childthread _id_FCBB819EC22CEC43(_id_BE6AF5030B2978F8, end);
  player = _id_62E11D77B25C1D30::_id_57E617784FB02909(_id_BE6AF5030B2978F8, end, 0.7, 0.3, 0, undefined, undefined, undefined, 3);

  if(!isDefined(player))
    player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();

  aliases = ["dx_cp_cpr2_trpp_fara_theventsareopening", "dx_cp_cpr2_trpp_pric_ventsareopening", "dx_cp_cpr2_trpp_gazz_ventsareopening"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_FCBB819EC22CEC43(_id_BE6AF5030B2978F8, end) {
  level waittill("platform_dropped");
  player = _id_62E11D77B25C1D30::_id_57E617784FB02909(_id_BE6AF5030B2978F8, end, 0.9, 0.3, 0, undefined, undefined, undefined, 10);

  if(!isDefined(player))
    player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();

  aliases = ["dx_cp_cpr2_trpp_fara_theyclosefast", "dx_cp_cpr2_trpp_pric_theyreclosingup", "dx_cp_cpr2_trpp_gazz_theyrenotopenlong"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  aliases = ["dx_cp_cpr2_trpp_fara_theyretimed", "dx_cp_cpr2_trpp_pric_itsonatimer", "dx_cp_cpr2_trpp_gazz_mustbetimed"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.2);
  wait 12;
  player = _id_62E11D77B25C1D30::_id_57E617784FB02909(_id_BE6AF5030B2978F8, end, 0.9, 0.3, 0, undefined, undefined, undefined, 2);

  if(!isDefined(player))
    player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();

  aliases = ["dx_cp_cpr2_trpp_fara_wecouldusetheventsto", "dx_cp_cpr2_trpp_pric_wecouldusethemtocros", "dx_cp_cpr2_trpp_gazz_theventscouldgetusac"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  aliases = ["dx_cp_cpr2_trpp_fara_madness", "dx_cp_cpr2_trpp_pric_areyoumad", "dx_cp_cpr2_trpp_gazz_youhavinalaugh"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.2);
  aliases = ["dx_cp_cpr2_trpp_fara_thewarheadisallthatm", "dx_cp_cpr2_trpp_pric_wehavetostopaqfromge", "dx_cp_cpr2_trpp_gazz_thelongerwetakethecl"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_7A3A3F2AA4C44C5D() {
  for(;;) {
    player = _id_62E11D77B25C1D30::_id_4E943B7BA4CCBBE8(0, -4765);

    if(scripts\engine\utility::flag("platform_sequence_active")) {
      break;
    }

    waitframe();
  }

  aliases = ["dx_cp_cpr2_trpp_fara_letsgo_01", "dx_cp_cpr2_trpp_pric_go", "dx_cp_cpr2_trpp_gazz_gogo"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0, 0, 0);
  player = _id_61F81FD71A1BB37F();
  level notify("vo_jump_on_vents");
  thread _id_76102C6D7B88B715();
  aliases = ["dx_cp_cpr2_trpp_fara_theycantholdmuchweig", "dx_cp_cpr2_trpp_pric_platescantholdusall", "dx_cp_cpr2_trpp_gazz_movefasttheycanthold"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  aliases = ["dx_cp_cpr2_trpp_fara_wegooneatatime", "dx_cp_cpr2_trpp_pric_oneatatimethen", "dx_cp_cpr2_trpp_gazz_keepitoneatatime"];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);
}

_id_058CF809FE66F659() {
  wait 3;
  aliases = ["dx_cp_cpr2_trpp_fara_dronesarehere", "dx_cp_cpr2_trpp_pric_dronesincoming", "dx_cp_cpr2_trpp_gazz_dronesincoming"];
  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  thread _id_5EEAA2CFF576DE79();
}

_id_5EEAA2CFF576DE79() {
  player = _id_0EDCF07839930CA2("flashbang")[0];
  aliases = ["dx_cp_cpr2_trpp_fara_flashbangeffort", "dx_cp_cpr2_trpp_pric_flashbangeffort", "dx_cp_cpr2_trpp_gazz_flashbangeffort"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0, 0, 0);
  aliases = ["dx_cp_cpr2_trpp_fara_theyreusingflashbang", "dx_cp_cpr2_trpp_pric_theyrelaunchingflash", "dx_cp_cpr2_trpp_gazz_theyredeployingflash"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_76102C6D7B88B715() {
  for(;;) {
    level waittill("platform_dropped");
    wait 1;
    player = _id_61F81FD71A1BB37F(1);

    if(isDefined(player)) {
      break;
    }
  }

  aliases = ["dx_cp_cpr2_trpp_fara_theventsareclosing", "dx_cp_cpr2_trpp_pric_theyreclosing", "dx_cp_cpr2_trpp_gazz_ventsareclosing"];
  aliases = ["dx_cp_cpr2_trpp_fara_theyreclosingbehindu", "dx_cp_cpr2_trpp_pric_wereoutoftimemove", "dx_cp_cpr2_trpp_gazz_theyreclosingtimesup"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_8231A8140F24D62B() {
  _id_71C3DDC005841ADC = (-3123.26, 2486.14, -1834.39);
  distsq = squared(500);

  for(;;) {
    player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_71C3DDC005841ADC, 0.7, 0.3, 0, undefined, 300)[0];
    _id_49BE45F83BE0135E = 0;

    foreach(_id_6EE5484560EC747C in level.players) {
      if(_id_6EE5484560EC747C == player) {
        continue;
      }
      if(distancesquared(_id_6EE5484560EC747C.origin, player.origin) < distsq) {
        _id_49BE45F83BE0135E = 1;
        break;
      }
    }

    if(_id_49BE45F83BE0135E) {
      break;
    }
  }

  aliases = ["dx_cp_cpr2_trpp_fara_carefulnearthatwater", "dx_cp_cpr2_trpp_pric_watchthatwater", "dx_cp_cpr2_trpp_gazz_donttouchthewater"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_DFCD4822978119BE(_id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5) {
  for(;;) {
    foreach(player in level.players) {
      if(!isalive(player) || player isspectatingplayer() || player isonground() || player _meth_9CC921A57FF4DEB5()) {
        continue;
      }
      if(!player _id_62E11D77B25C1D30::isinside(_id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5)) {
        player._id_730257270CE2FFAA = undefined;
        continue;
      }

      if(istrue(player._id_730257270CE2FFAA)) {
        continue;
      }
      player thread _id_EE79512FB7410469();
      player._id_730257270CE2FFAA = 1;
      return player;
    }

    waitframe();
  }
}

_id_EE79512FB7410469() {
  self endon("death_or_disconnect");

  while(isalive(self) && !self isonground())
    waitframe();

  if(isDefined(self) && !self isspectatingplayer())
    _id_5D265B4FCA61F070::_id_5510C489D7F09128(0, 0);
}

_id_B729B5221D8F26C6(_id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5) {
  level notify("vo_ventilationPlatformingFall");
  level endon("vo_ventilationPlatformingFall");

  for(;;) {
    player = _id_DFCD4822978119BE(_id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5);
    aliases = ["dx_cp_cpr2_trpp_fara_longfallefforts", "dx_cp_cpr2_trpp_pric_longfallefforts", "dx_cp_cpr2_trpp_gazz_longfallefforts"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0, 1, 0);
    thread _id_9455A6C47A2298C7(player);
  }
}

_id_9455A6C47A2298C7(player) {
  player endon("death_or_disconnect");
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(player, 0.85, 0.1, 0, player, undefined, undefined, 2);

  if(isDefined(_id_7D2852D02216C876))
    _id_7D2852D02216C876 = _id_7D2852D02216C876[0];

  if(player._id_938E8B2CA6549759 == "farah")
    aliases = [undefined, "dx_cp_cpr2_trpp_pric_farah_02", "dx_cp_cpr2_trpp_gazz_farah_02"];
  else if(player._id_938E8B2CA6549759 == "price")
    aliases = ["dx_cp_cpr2_trpp_fara_price", undefined, "dx_cp_cpr2_trpp_gazz_price_02"];
  else if(player._id_938E8B2CA6549759 == "gaz")
    aliases = ["dx_cp_cpr2_trpp_fara_gaz_01", "dx_cp_cpr2_trpp_pric_gaz_02"];
  else
    aliases = undefined;

  if(isDefined(aliases) && isDefined(_id_7D2852D02216C876))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0, 1, 0);
}

_id_581A63D092D362A7(_id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5, _id_30DD9F6DDD87B138, _id_6396F940DACCA980) {
  if(isDefined(_id_30DD9F6DDD87B138))
    level endon(_id_30DD9F6DDD87B138);

  for(;;) {
    scripts\engine\utility::flag_wait("platform_sequence_active");
    scripts\engine\utility::flag_waitopen("platform_sequence_active");
    wait 2;
    _id_EA12F5A1AE0234F0();
    _id_7B3BDBCE35F323AB = [];
    _id_9F9FD91903D8BA5A = [];

    foreach(player in level.players) {
      if(!isalive(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(_id_62E11D77B25C1D30::_id_816A81935C705C98(player, _id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5) || isDefined(_id_6396F940DACCA980) && [[_id_6396F940DACCA980]](player)) {
        _id_7B3BDBCE35F323AB[_id_7B3BDBCE35F323AB.size] = player;
        continue;
      }

      _id_9F9FD91903D8BA5A[_id_9F9FD91903D8BA5A.size] = player;
    }

    if(_id_7B3BDBCE35F323AB.size == 0) {
      continue;
    }
    if(_id_7B3BDBCE35F323AB.size == 3) {
      return;
    }
    if(_id_9F9FD91903D8BA5A.size == 1) {
      player = _id_9F9FD91903D8BA5A[0];

      if(!isDefined(player) || !isDefined(player._id_938E8B2CA6549759)) {
        continue;
      }
      if(player._id_938E8B2CA6549759 == "farah")
        aliases = [undefined, "dx_cp_cpr2_trpp_pric_weregoingbackforfara", "dx_cp_cpr2_trpp_gazz_wehavetogobackforfar"];
      else if(player._id_938E8B2CA6549759 == "price")
        aliases = ["dx_cp_cpr2_trpp_fara_wecantleaveprice", undefined, "dx_cp_cpr2_trpp_gazz_cantleavethecaptain"];
      else if(player._id_938E8B2CA6549759 == "gaz")
        aliases = ["dx_cp_cpr2_trpp_fara_gazisstillbackthere", "dx_cp_cpr2_trpp_pric_letsregroupwiththese"];
      else
        aliases = undefined;

      _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);

      if(!isDefined(_id_6396F940DACCA980)) {
        childthread _id_75986BB9C5670F87(0);
        childthread _id_BC1B60C21B58700C();
      }

      continue;
    }

    if(_id_7B3BDBCE35F323AB.size == 1) {
      player = _id_7B3BDBCE35F323AB[0];

      if(!isDefined(player) || !isDefined(player._id_938E8B2CA6549759)) {
        continue;
      }
      if(player._id_938E8B2CA6549759 == "farah")
        aliases = [undefined, "dx_cp_cpr2_trpp_pric_farahweneedyoutohelp", "dx_cp_cpr2_trpp_gazz_farahwellneedahandba"];
      else if(player._id_938E8B2CA6549759 == "price")
        aliases = ["dx_cp_cpr2_trpp_fara_pricewellneedyourhel", undefined, "dx_cp_cpr2_trpp_gazz_rallyonuscaptainwene"];
      else if(player._id_938E8B2CA6549759 == "gaz")
        aliases = ["dx_cp_cpr2_trpp_fara_sergeantwecantstartt", "dx_cp_cpr2_trpp_pric_gazregrouponuswehave"];
      else
        aliases = undefined;

      _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);

      if(!isDefined(_id_6396F940DACCA980)) {
        childthread _id_75986BB9C5670F87(1);
        childthread _id_BC1B60C21B58700C();
      }
    }
  }
}

_id_BC1B60C21B58700C() {
  level notify("vo_ventilationReturning");
  level endon("vo_ventilationReturning");
  aliases = ["dx_cp_cpr2_trpp_fara_movingtoyoustandby", "dx_cp_cpr2_trpp_pric_headingbackyourway", "dx_cp_cpr2_trpp_gazz_movingyourwaysittigh"];
  player = _id_62E11D77B25C1D30::_id_15FCF4C7B710C321(-3351, -4900, 2450, 2290, -386, -1691);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_75986BB9C5670F87(_id_21973208CF834AD7) {
  level endon("platform_sequence_active");
  _id_2AC1B4B54EBF876E = _id_62E11D77B25C1D30::_id_B826409EE2EFF7B6(-1375);
  _id_7B3BDBCE35F323AB = [];

  foreach(player in level.players) {
    if(!isalive(player) || player isspectatingplayer()) {
      continue;
    }
    if(player.origin[0] > -3529 && player.origin[2] > -1882 || player.origin[2] > -1375)
      _id_7B3BDBCE35F323AB[_id_7B3BDBCE35F323AB.size] = player;
  }

  if(_id_7B3BDBCE35F323AB.size == 3) {
    return;
  }
  speakers = _id_62E11D77B25C1D30::_id_29714545859E6445(level.players, _id_2AC1B4B54EBF876E);
  _id_7D2852D02216C876 = scripts\engine\utility::getclosest(_id_2AC1B4B54EBF876E.origin, speakers);

  if(!isalive(_id_7D2852D02216C876)) {
    return;
  }
  if(!_id_7D2852D02216C876 _meth_9CC921A57FF4DEB5()) {
    aliases = ["dx_cp_cpr2_trpp_fara_staydownhere", "dx_cp_cpr2_trpp_pric_downhere_01", "dx_cp_cpr2_trpp_gazz_getdownhere"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);
  }

  if(_id_21973208CF834AD7) {
    aliases = ["dx_cp_cpr2_trpp_fara_weshouldregroup", "dx_cp_cpr2_trpp_pric_werespreadoutletsreg", "dx_cp_cpr2_trpp_gazz_weneedtoregroup"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);
  } else {
    aliases = ["dx_cp_cpr2_trpp_fara_wehavetogoback", "dx_cp_cpr2_trpp_pric_weneedawaybackacross", "dx_cp_cpr2_trpp_gazz_wellhavetocrossbacko"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);
  }
}

_id_1B982224713FC1A3() {
  _id_840D7246B05DB77D = (-3105.84, 2762.13, -1834.37);
  _id_E0B88CAE86E87074 = (-3105.84, 2762.13, -1726.39);

  for(;;) {
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_57E617784FB02909(_id_840D7246B05DB77D, _id_E0B88CAE86E87074, 0.9, 0.3, 0, undefined, 150);
    _id_7B3BDBCE35F323AB = [];

    foreach(player in level.players) {
      if(!isalive(player) || player isspectatingplayer()) {
        continue;
      }
      if(player.origin[0] > -3529 && player.origin[2] > -1882 || player.origin[2] > 2412)
        _id_7B3BDBCE35F323AB[_id_7B3BDBCE35F323AB.size] = player;
    }

    if(_id_7B3BDBCE35F323AB.size == 3) {
      break;
    }
  }

  thread _id_581A63D092D362A7(-4788, -5045, 2873, 2381, -816, -996, "vo_playersClearedUpperVentilation");
  thread _id_B729B5221D8F26C6(-3504, -4773, 2848, 2463, -1328, -2925);
  aliases = ["dx_cp_cpr2_trpp_fara_theresanascendercabl", "dx_cp_cpr2_trpp_pric_ascendercablehere", "dx_cp_cpr2_trpp_gazz_gotanascendercable"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);
  player = _id_7029BF8C5A168BED();
  aliases = ["dx_cp_cpr2_trpp_fara_goingup", "dx_cp_cpr2_trpp_pric_takinit", "dx_cp_cpr2_trpp_gazz_headinup"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_6499C8456FC62A10() {
  scripts\engine\utility::flag_wait("vo_playersClearedLowerVentilation");
  _id_1535D51D119F3752 = (-3421, 2567.8, -923.435);
  _id_06ECEB91B8A3E09F = (-3421, 2684.52, -923.435);
  _id_48234EC8FB6C617F = _id_1535D51D119F3752 + (_id_06ECEB91B8A3E09F - _id_1535D51D119F3752) / 2;
  player = _id_62E11D77B25C1D30::_id_57E617784FB02909(_id_1535D51D119F3752, _id_06ECEB91B8A3E09F, 0.95, 0.3, 0, undefined, 200);
  aliases = ["dx_cp_cpr2_trpp_fara_morecontrols", "dx_cp_cpr2_trpp_pric_controlshere_01", "dx_cp_cpr2_trpp_gazz_gotanotherterminal"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  scripts\engine\utility::flag_wait_or_timeout("platform_sequence_active", 1);

  if(scripts\engine\utility::flag("platform_sequence_active")) {
    return;
  }
  player = sortbydistance(level.players, _id_48234EC8FB6C617F)[0];
  aliases = ["dx_cp_cpr2_trpp_fara_letsstartthesequence", "dx_cp_cpr2_trpp_pric_sameplangetreadytomo", "dx_cp_cpr2_trpp_gazz_okaysameplanasbefore"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  scripts\engine\utility::flag_wait_or_timeout("platform_sequence_active", 13);

  if(scripts\engine\utility::flag("platform_sequence_active")) {
    return;
  }
  players = level.players;

  while(players.size > 0) {
    player = sortbydistance(players, _id_48234EC8FB6C617F)[0];
    aliases = ["dx_cp_cpr2_trpp_fara_weneedeveryoneonthec", "dx_cp_cpr2_trpp_pric_everyoneonthetermina", "dx_cp_cpr2_trpp_gazz_ontheterminalletsget"];
    result = _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);

    if(istrue(result))
      players = scripts\engine\utility::array_remove(players, player);

    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953([10, 15]);
  }
}

_id_21ED32E53F399F27() {
  player = _id_62E11D77B25C1D30::_id_15FCF4C7B710C321(-3997, -4261, 2705, 2418, -827, -970);
  aliases = ["dx_cp_cpr2_trpp_fara_cantgothisway", "dx_cp_cpr2_trpp_pric_itsadeadend", "dx_cp_cpr2_trpp_gazz_whereto"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_55D0EC4FB7A0BEC8() {
  player = _id_62E11D77B25C1D30::_id_15FCF4C7B710C321(undefined, undefined, undefined, 2770, undefined, -1120);
  aliases = ["dx_cp_cpr2_trpp_fara_jumptothepipes", "dx_cp_cpr2_trpp_pric_usethepipes", "dx_cp_cpr2_trpp_gazz_wecanusethepipes"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_C0D7A75C7BC77E74() {
  aliases = [];
  aliases[0] = scripts\engine\utility::create_deck(["dx_cp_cpr2_trpp_fara_stoppingthesequence", "dx_cp_cpr2_trpp_fara_imclosingthevents"]);
  aliases[1] = scripts\engine\utility::create_deck(["dx_cp_cpr2_trpp_pric_abortingthesequence", "dx_cp_cpr2_trpp_pric_closingthevents"]);
  aliases[2] = scripts\engine\utility::create_deck(["dx_cp_cpr2_trpp_gazz_stoppingthevents", "dx_cp_cpr2_trpp_gazz_cancellingthesequenc"]);

  for(;;) {
    level waittill("cancel_plat_seq");
    player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  }
}

_id_7CB68FF453F923B8() {
  player = _id_62E11D77B25C1D30::_id_15FCF4C7B710C321(-3468.86, -4463.61, 2657.4, 2405.3, -619.863, -781.539);
  aliases = ["dx_cp_cpr2_trpp_fara_otherside", "dx_cp_cpr2_trpp_pric_jumpacross", "dx_cp_cpr2_trpp_gazz_backacross"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_75A544A3B4D51339() {
  player = _id_62E11D77B25C1D30::_id_15FCF4C7B710C321(-4437.13, -4726, 2839, 2673, -849, -960);
  aliases = ["dx_cp_cpr2_trpp_fara_jumpdown", "dx_cp_cpr2_trpp_pric_usethisplatform", "dx_cp_cpr2_trpp_gazz_jumptothisplatform"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_990DC6001D9315E7(_id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5) {
  _id_62E11D77B25C1D30::_id_A2E15CA9CC1E141F(_id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5);
  scripts\engine\utility::flag_set("vo_playersClearedLowerVentilation");

  if(!isDefined(level._id_E1468249C31E4BF1))
    level._id_E1468249C31E4BF1 = level.players;

  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F(level._id_E1468249C31E4BF1);
  aliases = ["dx_cp_cpr2_trpp_fara_wereallhere", "dx_cp_cpr2_trpp_pric_weregood", "dx_cp_cpr2_trpp_gazz_allhere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  level._id_E1468249C31E4BF1 = scripts\engine\utility::array_remove(level._id_E1468249C31E4BF1, player);
}

_id_25CA8E03F0D8F35E() {
  _id_62E11D77B25C1D30::_id_A2E15CA9CC1E141F(-4788, -5045, 2873, 2381, -816, -996);
  scripts\engine\utility::flag_set("vo_playersClearedUpperVentilation");

  if(!isDefined(level._id_E1468249C31E4BF1))
    level._id_E1468249C31E4BF1 = level.players;

  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F(level._id_E1468249C31E4BF1);
  aliases = ["dx_cp_cpr2_trpp_fara_wereallhere", "dx_cp_cpr2_trpp_pric_weregood", "dx_cp_cpr2_trpp_gazz_allhere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  level._id_E1468249C31E4BF1 = scripts\engine\utility::array_remove(level._id_E1468249C31E4BF1, player);
}

_id_58CE102E3BF50C81() {
  level endon("seq2_exit_door_door_open");
  scripts\engine\utility::flag_wait("vo_playersClearedUpperVentilation");
  door = (-5047.63, 2744.04, -946);
  _id_05C70E8827622861(door);
}

_id_7BF0A12D9A148DCE() {
  if(isDefined(level._id_9B661E6037455194))
    return level._id_9B661E6037455194;

  _id_D3CF981513A949AC = scripts\engine\utility::create_deck(["dx_cp_cpr2_trpp_fara_onmeatthedoors", "dx_cp_cpr2_trpp_fara_thisway_01", "dx_cp_cpr2_trpp_fara_overhere"]);
  _id_A07C8A34027231B5 = scripts\engine\utility::create_deck(["dx_cp_cpr2_trpp_pric_rallyatthedoors", "dx_cp_cpr2_trpp_pric_rallyonme", "dx_cp_cpr2_trpp_pric_letsregroup"]);
  _id_26C5BA2CFC2BF056 = scripts\engine\utility::create_deck(["dx_cp_cpr2_trpp_gazz_doorshererallyup", "dx_cp_cpr2_trpp_gazz_regroupatthedoors", "dx_cp_cpr2_trpp_gazz_regrouponme"]);
  level._id_9B661E6037455194 = [_id_D3CF981513A949AC, _id_A07C8A34027231B5, _id_26C5BA2CFC2BF056];
  return level._id_9B661E6037455194;
}

_id_05C70E8827622861(door) {
  nags = _id_7BF0A12D9A148DCE();
  distsq = squared(160);
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(3, 15, 3);

  for(;;) {
    player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(door, 160);
    _id_57A1DB84D888872E = 0;

    foreach(player in level.players) {
      if(!isalive(player) || player isspectatingplayer()) {
        continue;
      }
      if(distancesquared(player.origin, door) > distsq)
        _id_57A1DB84D888872E++;
    }

    if(_id_57A1DB84D888872E == level.players.size) {
      wait 2;
      continue;
    }

    player = scripts\engine\utility::getclosest(door, level.players);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, nags, 0.2, 0, 1);
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
  }
}

_id_1B0B144D8A12D5F8() {
  _id_37162ADD31FFCB93 = (-5185.78, 2615.13, -939.75);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_37162ADD31FFCB93, 0.95, 0.5, 0, undefined, 300)[0];
  aliases = ["dx_cp_cpr2_trpp_fara_theresapathhere", "dx_cp_cpr2_trpp_pric_gotatunnelhere", "dx_cp_cpr2_trpp_gazz_opentunnelhere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 8;
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  aliases = ["dx_cp_cpr2_trpp_fara_usethetunnelkeepmovi", "dx_cp_cpr2_trpp_pric_downthetunnelkeepitm", "dx_cp_cpr2_trpp_gazz_takethetunnelletskee"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

vo_rappel() {
  thread _id_B729B5221D8F26C6(-2937, -4803, 2852, 2418, -226, -2925);

  if(getdvarint("dvar_DB100AC6C9ECE479", 0) > 0) {
    while(level.players.size < 3)
      waitframe();

    waitframe();

    foreach(player in level.players) {
      player setplayerangles((0, 90, 0));
      player setOrigin((-5022.65, 2425.72, 149.75));
    }

    thread _id_03E12320A4B71A96();
    childthread _id_03645119A0CE356B();
    scripts\engine\utility::flag_set("platform_sequence_active");
    waitframe();
    scripts\engine\utility::flag_clear("platform_sequence_active");
    return;
  }

  childthread _id_420C499FF681BE3B();
  childthread _id_BEA117390BA52131();
  childthread _id_DF0B580FB6244C99();
  childthread _id_BDF2CBBC147C1D57();
  childthread _id_936A06D1A7F272B9();
  childthread _id_341E7DA5F9932F88();
  childthread _id_AE2BEF45C51FFEA4();
  childthread _id_E75BBF6E5C54CDAE();
  childthread _id_DBA4BAE2B90F8356();
  childthread _id_BE55A2891461D2E5();
  childthread _id_73ABF26350008C05();
  childthread _id_3A889DF3C78DDC34();
  childthread _id_772451AC7FE3FDC6();
  childthread _id_B3B3CDE87F715167();
  childthread _id_46F2501E26C79E73();
  childthread _id_01224C9339F200D7();
  childthread _id_03645119A0CE356B();
  childthread _id_330F7B3366542365();
}

_id_420C499FF681BE3B() {
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803((-5599.1, 2608.22, -1162), 0.7, 0.5)[0];
  aliases = ["dx_cp_cpr2_trpr_fara_clear", "dx_cp_cpr2_trpr_pric_clear", "dx_cp_cpr2_trpr_gazz_itsclear"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);
}

_id_BEA117390BA52131() {
  equipment = [(-5611.85, 2555.64, -1104), (-5648.85, 2590.95, -1111.88), (-5665.73, 2925.93, -1122), (-5788.65, 2960.8, -1122), (-5916.46, 2908.53, -1121.99), (-6040.7, 2901.62, -1121.97), (-6153.07, 2904.78, -1105.45), (-6074.51, 3341.57, -1105.44), (-6127.98, 3305.82, -1122)];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(equipment, 0.6, 0.3, 0, undefined, 250)[0];
  aliases = ["dx_cp_cpr2_trpr_fara_lotsofequipment", "dx_cp_cpr2_trpr_pric_lotsofequipment", "dx_cp_cpr2_trpr_gazz_lotsofequipment"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  wait 0.6;
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(equipment, 0.6, 0.3, 0, [player], 250)[0];
  aliases = ["dx_cp_cpr2_trpr_fara_sovietsleftmorethana", "dx_cp_cpr2_trpr_pric_sovietsleftmorethana", "dx_cp_cpr2_trpr_gazz_sovietsleftmorethana"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(equipment, 0.6, 0.3, 0, [player], 250)[0];
  wait 0.3;
  aliases = ["dx_cp_cpr2_trpr_fara_theselooknew", "dx_cp_cpr2_trpr_pric_theselooknew", "dx_cp_cpr2_trpr_gazz_theselooknew"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_DF0B580FB6244C99() {
  player = _id_62E11D77B25C1D30::_id_15FCF4C7B710C321(-4983, -5601.59, 3653, 3017, -1200, -1480);
  scripts\engine\utility::flag_waitopen("vo_combat");
  wait 1;
  aliases = ["dx_cp_cpr2_trpr_fara_downstairsletsmove", "dx_cp_cpr2_trpr_pric_downstairsmove", "dx_cp_cpr2_trpr_gazz_headdownstairs"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_BDF2CBBC147C1D57() {
  _id_45C0631F166B0A85 = [(-5372.04, 3473.02, -1399.5), (-5299.63, 3504.61, -1394), (-5178.33, 3475.74, -1416.34), (-5440.07, 3182.74, -1402.3), (-5400.64, 3141.47, -1402.3), (-5358.61, 3107.39, -1395.6)];
  equipment = [(-5417.55, 3438.74, -1394), (-5513.54, 3396.94, -1394), (-5498.07, 3237.17, -1394.01)];
  _id_653000736A9579E3 = scripts\engine\utility::array_combine(_id_45C0631F166B0A85, equipment);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_653000736A9579E3, 0.8, 0.3, 0, undefined, 300)[0];
  aliases = ["dx_cp_cpr2_trpr_fara_theyhaveanarmory", "dx_cp_cpr2_trpr_pric_theresanarmory", "dx_cp_cpr2_trpr_gazz_theresabloodyarmory"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_45C0631F166B0A85, 0.8, 0.3, 0, [player], 200)[0];
  aliases = ["dx_cp_cpr2_trpr_fara_thisequipmentisntrus", "dx_cp_cpr2_trpr_pric_thisisntrussianequip", "dx_cp_cpr2_trpr_gazz_therussiansdidntleav"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  aliases = ["dx_cp_cpr2_trpr_fara_aqsdiggingin", "dx_cp_cpr2_trpr_pric_aqsdiggingin", "dx_cp_cpr2_trpr_gazz_aqsdiggingin"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  _id_647AE36E483057A4();
}

_id_647AE36E483057A4() {
  _id_015C8624BAFF33FC = (-6707.21, 3328.77, -1466.25);
  player = undefined;

  for(;;) {
    player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(_id_015C8624BAFF33FC, 1000)[0];

    if(player.origin[2] < -1370) {
      break;
    }

    waitframe();
  }

  if(player._id_938E8B2CA6549759 == "farah") {
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr2_trpp_fara_wecantletaqsecurethe", 0.3);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level._id_E0632103DFA5BB19, "dx_cp_cpr2_trpp_gazz_letshopealexfoundthe", 0.5);
  } else if(player._id_938E8B2CA6549759 == "price") {
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr2_trpp_pric_weneedtolocatealexan", 0.3);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level._id_E0632103DFA5BB19, "dx_cp_cpr2_trpp_gazz_letshopealexfoundthe", 0.5);
  } else if(player._id_938E8B2CA6549759 == "gaz") {
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level._id_E0632103DFA5BB19, "dx_cp_cpr2_trpp_gazz_letshopealexfoundthe", 0.5);
    aliases = ["dx_cp_cpr2_trpp_fara_ifalexisaliveweneedt", "dx_cp_cpr2_trpp_pric_alexisgoingtoneedour"];
    player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(level._id_E0632103DFA5BB19);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);
  }
}

_id_936A06D1A7F272B9() {
  player = _id_82D126B88255888E();
  aliases = ["dx_cp_cpr2_trpr_fara_aboveus", "dx_cp_cpr2_trpr_pric_uptop", "dx_cp_cpr2_trpr_gazz_aqsgotthehighground"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  thread _id_F950F94F843CDC08();
  _id_62E11D77B25C1D30::_id_B826409EE2EFF7B6(-950);
  player = _id_82D126B88255888E();
  aliases = ["dx_cp_cpr2_trpr_fara_moreaquptop", "dx_cp_cpr2_trpr_pric_wegotaquptop", "dx_cp_cpr2_trpr_gazz_aqaboveus"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  thread _id_F7B953C15E91CBE7();
}

_id_F950F94F843CDC08() {
  while(getaiarray().size > 0)
    level waittill("ai_killed");

  wait 0.5;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr2_trpr_pric_clear_01", 0.5);

  if(scripts\engine\utility::flag("vo_rappelUsedAscender")) {
    return;
  }
  level endon("vo_rappelUsedAscender");
  wait 1;
  aliases = ["dx_cp_cpr2_trpp_fara_nosignofalex", "dx_cp_cpr2_trpp_pric_nosignofalex", "dx_cp_cpr2_trpp_gazz_nosignofalex"];
  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  ascender = (-7316.78, 3507.81, -1521.79);
  result = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(ascender, 0.8, 0, 0, undefined, 200, undefined, 1);

  if(!isDefined(result)) {
    aliases = ["dx_cp_cpr2_trpp_fara_orawayup", "dx_cp_cpr2_trpp_pric_orawayup", "dx_cp_cpr2_trpp_gazz_orawayup"];
    player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  }

  wait 2;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr2_trpp_fara_wehavetogettothetopo", 0.2);
  wait 5;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr2_trpp_pric_theresawayupthesilow", 0.3);
  wait 8;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level._id_E0632103DFA5BB19, "dx_cp_cpr2_trpp_gazz_wehavetosecurethatwa", 0.3);
  wait 10;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr2_trpr_fara_weneedawayup", 0.5);
  wait 12;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr2_trpr_pric_findawayup", 0.3);
  wait 15;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level._id_E0632103DFA5BB19, "dx_cp_cpr2_trpr_gazz_searchforanexitroute", 0.4);
}

_id_F7B953C15E91CBE7() {
  while(getaiarray().size > 0)
    level waittill("ai_killed");

  wait 0.5;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level._id_E0632103DFA5BB19, "dx_cp_cpr2_trpr_gazz_clear", 0.5);
}

_id_CA233BC61873024C() {
  for(;;) {
    result = _id_0EDCF07839930CA2(["bulletwhizby", "damage"]);

    if(result[1] == "damage")
      attacker = result[3];
    else
      attacker = result[2];

    if(!isai(attacker)) {
      continue;
    }
    player = result[0];
    return [player, attacker];
  }
}

_id_82D126B88255888E() {
  for(;;) {
    result = _id_0EDCF07839930CA2(["bulletwhizby", "damage"]);

    if(result[1] == "damage")
      attacker = result[3];
    else
      attacker = result[2];

    if(!isDefined(attacker) || !isai(attacker)) {
      continue;
    }
    player = result[0];

    if(attacker.origin[2] > player.origin[2] + 125)
      return player;
  }
}

_id_341E7DA5F9932F88() {
  player = _id_7029BF8C5A168BED();
  scripts\engine\utility::flag_set("vo_rappelUsedAscender");
  aliases = ["dx_cp_cpr2_trpr_fara_usingtheascender", "dx_cp_cpr2_trpr_pric_taketheascendercable", "dx_cp_cpr2_trpr_gazz_ascendershere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_AE2BEF45C51FFEA4() {
  _id_DE41D9BB34536CD1 = [(-7857.27, 2725.24, -1515.5), (-7875.95, 2730.92, -837.25), (-6536.63, 2731.73, -534.519)];
  aliases = [];
  aliases[0] = scripts\engine\utility::create_deck(["dx_cp_cpr2_trpr_fara_nowayout", "dx_cp_cpr2_trpr_fara_cantgothisway", "dx_cp_cpr2_trpr_fara_theresnoexithere"]);
  aliases[1] = scripts\engine\utility::create_deck(["dx_cp_cpr2_trpr_pric_noexit", "dx_cp_cpr2_trpr_pric_noexitthisway", "dx_cp_cpr2_trpr_pric_itsadeadend"]);
  aliases[2] = scripts\engine\utility::create_deck(["dx_cp_cpr2_trpr_gazz_notanexit", "dx_cp_cpr2_trpr_gazz_deadend", "dx_cp_cpr2_trpr_gazz_wrongway"]);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    result = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_DE41D9BB34536CD1, 0.7, 0.3, 0, undefined, 250);
    player = result[0];
    _id_DE41D9BB34536CD1 = scripts\engine\utility::array_remove(_id_DE41D9BB34536CD1, result[1]);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);

    if(result[1] == (-7875.95, 2730.92, -837.25)) {
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr2_trpr_pric_letskeepclimbing", 0.3);
      thread _id_DC55A06E9785CB29();
    }
  }
}

_id_DC55A06E9785CB29() {
  if(scripts\engine\utility::flag("vo_rappel_found_climb")) {
    return;
  }
  level endon("vo_rappel_found_climb");
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(5, 10, 3);
  aliases = ["dx_cp_cpr2_trpr_pric_weneedawayup", "dx_cp_cpr2_trpr_fara_lookforsomethingweca", "dx_cp_cpr2_trpr_gazz_dontthinkwecanusethe"];
  players = [level.price, level.farah, level._id_E0632103DFA5BB19];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < aliases.size; _id_AC0E594AC96AA3A8++) {
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(players[_id_AC0E594AC96AA3A8], aliases[_id_AC0E594AC96AA3A8], 0.3);
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
  }
}

_id_E75BBF6E5C54CDAE() {
  player = _id_62E11D77B25C1D30::_id_15FCF4C7B710C321(-7005, -7252, 3479, 3280, -776, -816);
  scripts\engine\utility::flag_set("vo_rappel_found_climb");
  aliases = ["dx_cp_cpr2_trpr_fara_herethisway", "dx_cp_cpr2_trpr_pric_overerefoundawayup", "dx_cp_cpr2_trpr_gazz_oimighthaveawayupher"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  aliases = ["dx_cp_cpr2_trpr_fara_goodfind", "dx_cp_cpr2_trpr_pric_solidwork", "dx_cp_cpr2_trpr_gazz_righton"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);
  _id_8A925332BA34F25E = (-7197, 3206, -627);
  top = (-7197, 3206, -290);
  player = _id_62E11D77B25C1D30::_id_57E617784FB02909(_id_8A925332BA34F25E, top, 0.7, 0.3, 0, undefined, 100);
  aliases = ["dx_cp_cpr2_trpr_fara_theresanothercable", "dx_cp_cpr2_trpr_pric_cablehere", "dx_cp_cpr2_trpr_gazz_gotanothercablehere"];

  if(scripts\engine\utility::flag("vo_combat"))
    aliases = ["dx_cp_cpr2_trpr_fara_theresanothercable_01", "dx_cp_cpr2_trpr_pric_cablehere_01", "dx_cp_cpr2_trpr_gazz_anothercablehere"];

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  fire = (-7198.22, 3215.84, -268.968);
  player = _id_62E11D77B25C1D30::_id_F3C414CE5CCAB845(fire, 0.7, 0.3, 0, undefined, 100)[0];

  if(scripts\engine\utility::flag("vo_combat"))
    aliases = ["dx_cp_cpr2_trpr_fara_itsblockedbyfire_01", "dx_cp_cpr2_trpr_pric_firesblockingtheway_01", "dx_cp_cpr2_trpr_gazz_wecantmakeitpastthat_01"];
  else
    aliases = ["dx_cp_cpr2_trpr_fara_itsblockedbyfire", "dx_cp_cpr2_trpr_pric_firesblockingtheway", "dx_cp_cpr2_trpr_gazz_wecantmakeitpastthat"];

  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  childthread _id_55EDF02ABBCBF4FC();
}

_id_DBA4BAE2B90F8356() {
  dist = squared(150);
  player = undefined;

  for(;;) {
    player = _id_7029BF8C5A168BED();

    if(distancesquared(player.origin, (-7197.94, 3205.83, -667)) < dist) {
      break;
    }

    waitframe();
  }

  if(player._id_938E8B2CA6549759 == "farah")
    aliases = [undefined, "dx_cp_cpr2_trpr_pric_farahtheresfire", "dx_cp_cpr2_trpr_gazz_farahtheresfire"];
  else if(player._id_938E8B2CA6549759 == "price")
    aliases = ["dx_cp_cpr2_trpr_fara_pricetheresfire", undefined, "dx_cp_cpr2_trpr_gazz_pricetheresfire"];
  else if(player._id_938E8B2CA6549759 == "gaz")
    aliases = ["dx_cp_cpr2_trpr_fara_gaztheresfire", "dx_cp_cpr2_trpr_pric_gaztheresfire"];
  else
    aliases = undefined;

  _id_8A925332BA34F25E = (-7197, 3206, -627);
  top = (-7197, 3206, -290);
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_57E617784FB02909(_id_8A925332BA34F25E, top, 0.85, 0.3, 0, player, undefined, undefined, 0.8);

  if(!isDefined(_id_7D2852D02216C876))
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0, 1, 0);
}

_id_BE55A2891461D2E5() {
  _id_05CE5B54E58D14C5 = (-7454.54, 3485.68, -544.838);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_05CE5B54E58D14C5, 0.7, 0.3, 0, undefined, 200)[0];
  aliases = ["dx_cp_cpr2_trpr_fara_theresavalvehere", "dx_cp_cpr2_trpr_pric_foundavalve", "dx_cp_cpr2_trpr_gazz_gotavalvehere"];

  if(!scripts\engine\utility::flag("vo_combat"))
    aliases = ["dx_cp_cpr2_trpr_fara_theresavalve", "dx_cp_cpr2_trpr_pric_foundavalve_01", "dx_cp_cpr2_trpr_gazz_gotavalvehere_01"];

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  scripts\engine\utility::flag_set("vo_spottedFireValve");
}

_id_55EDF02ABBCBF4FC() {
  level endon("vo_spottedFireOut");

  if(scripts\engine\utility::flag("vo_spottedFireOut")) {
    return;
  }
  wait 10;
  scripts\engine\utility::flag_waitopen("vo_combat");
  wait 1;
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74();
  aliases = ["dx_cp_cpr2_trpr_fara_weneedthefiregonetou", "dx_cp_cpr2_trpr_pric_needtosortthatfireou", "dx_cp_cpr2_trpr_gazz_cantusethecableuntil"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);

  if(scripts\engine\utility::flag("vo_spottedFireValve")) {
    aliases = ["dx_cp_cpr2_trpr_fara_usethatvalve", "dx_cp_cpr2_trpr_pric_trythevalve", "dx_cp_cpr2_trpr_gazz_turnthevalve"];
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);
  } else
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level._id_E0632103DFA5BB19, "dx_cp_cpr2_trpr_gazz_findavalvewecanuse", 0.3);
}

_id_73ABF26350008C05() {
  _id_51E791B4D5448C42 = getEntArray("intro_fire_valve", "targetname");
  _id_9C70BE53D55AC5CD = scripts\engine\utility::getStructArray(_id_51E791B4D5448C42[0].target, "targetname")[0];
  fire = (-7198.22, 3215.84, -268.968);
  player = undefined;

  for(;;) {
    player = _id_0A57DEC546876DA1(_id_51E791B4D5448C42, "trigger")[2];

    while(_id_9C70BE53D55AC5CD.script_parameters == "on")
      waitframe();

    aliases = ["dx_cp_cpr2_trpr_fara_thefiresout", "dx_cp_cpr2_trpr_pric_firesgone", "dx_cp_cpr2_trpr_gazz_flamesareout"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
    scripts\engine\utility::flag_set("vo_spottedFireOut");

    while(_id_9C70BE53D55AC5CD.script_parameters == "off")
      waitframe();

    players = _id_93C58B66A9BD16C8(-380);
    player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F(players);

    if(_id_AAC9CBB13160E609(0) != level.players.size) {
      aliases = ["dx_cp_cpr2_trpr_fara_thefireisback", "dx_cp_cpr2_trpr_pric_firesbackon", "dx_cp_cpr2_trpr_gazz_thatfiresback"];
      thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
    }

    wait 8;

    while(_id_9C70BE53D55AC5CD.script_parameters == "off")
      waitframe();
  }
}

_id_3A889DF3C78DDC34() {
  _id_51E791B4D5448C42 = getEntArray("intro_fire_valve", "targetname");

  if(_id_51E791B4D5448C42[0].origin[2] > _id_51E791B4D5448C42[1].origin[2])
    _id_477302BF52CFB1A3 = _id_51E791B4D5448C42[0];
  else
    _id_477302BF52CFB1A3 = _id_51E791B4D5448C42[1];

  _id_477302BF52CFB1A3 endon("trigger");

  while(_id_AAC9CBB13160E609(0) < 2)
    waitframe();

  wait 5;
  player = _id_62E11D77B25C1D30::_id_B826409EE2EFF7B6(0);
  aliases = ["dx_cp_cpr2_trpr_fara_lookforavalveuphere", "dx_cp_cpr2_trpr_pric_searchforavalveupher", "dx_cp_cpr2_trpp_gazz_weneedanothervalve"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_772451AC7FE3FDC6() {
  level endon("vo_foundRappelExit");

  while(_id_AAC9CBB13160E609(0) < 3)
    waitframe();

  wait 5;
  player = _id_62E11D77B25C1D30::_id_B826409EE2EFF7B6(0, scripts\engine\utility::array_randomize(level.players));
  aliases = ["dx_cp_cpr2_trpr_fara_lookforanexituphere", "dx_cp_cpr2_trpr_pric_searchforanexitupher", "dx_cp_cpr2_trpr_gazz_weneedtofindanexit"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_B3B3CDE87F715167() {
  level endon("rappel_exit_3_man_door_door_open");
  door = (-7017.18, 2656.3, 122.171);

  while(_id_AAC9CBB13160E609(0) < 3)
    waitframe();

  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(door, 0.8, 0.3)[0];
  scripts\engine\utility::flag_set("vo_foundRappelExit");
  aliases = ["dx_cp_cpr2_trpr_fara_theresadooroverhere", "dx_cp_cpr2_trpr_pric_exitshere", "dx_cp_cpr2_trpr_gazz_locatedtheexit"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
  wait 5;
  aliases = ["dx_cp_cpr2_trpr_fara_gettotheexitweneedto", "dx_cp_cpr2_trpr_pric_rallyatthedoorletsmo", "dx_cp_cpr2_trpr_gazz_regroupattheexitlets"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_46F2501E26C79E73() {
  level waittill("rappel_exit_3_man_door_door_open");
  wait 3;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr2_trpr_fara_letsmove", 0.2);
}

_id_01224C9339F200D7() {
  level endon("vo_reenteredVentilation");
  _id_85FA8ABEEBA6E4B7 = (-5198.86, 2809.11, 80.9681);
  scripts\engine\utility::flag_waitopen("vo_combat");
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_85FA8ABEEBA6E4B7, 0.8, 0.3, 0, undefined, 300)[0];
  aliases = ["dx_cp_cpr2_trpr_fara_theresapassagehere", "dx_cp_cpr2_trpr_pric_gotanopenpassage", "dx_cp_cpr2_trpr_gazz_passagehereinthecorn"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
  wait 10;
  aliases = ["dx_cp_cpr2_trpr_fara_keepmoving", "dx_cp_cpr2_trpr_pric_letsmove", "dx_cp_cpr2_trpr_gazz_letskeepitmoving"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_03645119A0CE356B() {
  thread _id_2B82C2FF00995553();
  level endon("platform_sequence_active");
  _id_94564218DD6125B9 = [];

  for(_id_0BF41B80601595A4 = (-3967.08, 2731.52, 24.0061); _id_94564218DD6125B9.size < 2; _id_94564218DD6125B9[_id_94564218DD6125B9.size] = player) {
    player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_0BF41B80601595A4, 0.5, 0.3, 0, _id_94564218DD6125B9, 1200)[0];
    level notify("vo_reenteredVentilation");
    aliases = ["dx_cp_cpr2_trpd_fara_damnit", "dx_cp_cpr2_trpd_pric_bloodyhell", "dx_cp_cpr2_trpd_gazz_ohpissoff"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.6);
  }

  wait 1.4;
  _id_020A8D27F3402C6E();
}

_id_020A8D27F3402C6E() {
  if(scripts\engine\utility::flag("platform_sequence_active")) {
    return;
  }
  _id_48234EC8FB6C617F = (-4964, 2625, 0);
  players = level.players;

  while(players.size > 0) {
    player = sortbydistance(players, _id_48234EC8FB6C617F)[0];
    aliases = ["dx_cp_cpr2_trpd_fara_everyoneonthecontrol", "dx_cp_cpr2_trpd_pric_getonthecontrols", "dx_cp_cpr2_trpd_gazz_onthecontrolsletsget"];
    result = _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.6);

    if(istrue(result))
      players = scripts\engine\utility::array_remove(players, player);

    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953([10, 15]);
  }
}

_id_2B82C2FF00995553() {
  scripts\engine\utility::flag_wait("platform_sequence_active");
  childthread _id_581A63D092D362A7(-4763, -5113, 2592, 2293, 324, -100, "vo_rappelVentilationClear", ::_id_DAD96AE32B52A3A9);
  _id_62E11D77B25C1D30::_id_A2E15CA9CC1E141F(-4763, -5113, 2592, 2293, 324, -100, 0, undefined, undefined, ::_id_DAD96AE32B52A3A9);
  childthread _id_168C4AED35E75369();
  childthread _id_69A1CB41E85F305B();
  childthread _id_948DE3F982762466();
  scripts\engine\utility::flag_set("vo_rappelVentilationClear");

  if(!isDefined(level._id_E1468249C31E4BF1))
    level._id_E1468249C31E4BF1 = level.players;

  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F(level._id_E1468249C31E4BF1);
  aliases = ["dx_cp_cpr2_trpp_fara_wereallhere", "dx_cp_cpr2_trpp_pric_weregood", "dx_cp_cpr2_trpp_gazz_allhere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  aliases = ["dx_cp_cpr2_trpd_fara_checkinguphere", "dx_cp_cpr2_trpd_pric_checkinguphere", "dx_cp_cpr2_trpd_gazz_checkinguphere"];
  player = _id_3716DB9770DC5266();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  door = (-5018.29, 2850.46, 208);
  aliases = ["dx_cp_cpr2_trpd_fara_theresadoor", "dx_cp_cpr2_trpd_pric_foundadoor", "dx_cp_cpr2_trpd_gazz_gotadooruphere"];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(door, 0.8, 0.2, 0, [], 400)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_03E12320A4B71A96() {
  level endon("game_ended");
  _id_4D56A5BE03B9585F = ["interactable_note_keycard_a", "interactable_note_keycard_b", "interactable_note_keycard_c"];

  foreach(keycard in _id_4D56A5BE03B9585F) {
    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(0, (-5020.85, 2727.66, 160.75), (0, 90, 0));
    item = _id_66122A002AFF5D57::spawnpickup(keycard, _id_CB4FAD49263E20C4, 1, 0, undefined, 0);
    level thread _id_3593E95C2FCFA407::_id_91E8BF59BDBB9A6D(keycard);
  }
}

_id_948DE3F982762466() {
  for(;;) {
    level waittill("tried_insert_keycard", _id_11A06898445637E9, _id_7D2852D02216C876, keycard);
    _id_69AB89D99FBA46D0 = 0;

    foreach(player in level.players) {
      if(isDefined(_id_78547FBB6C0083E0::_id_1378F1533E0BCFB9(player)))
        _id_69AB89D99FBA46D0++;
    }

    if(_id_69AB89D99FBA46D0 > 0) {
      continue;
    }
    if(_id_11A06898445637E9._id_4B5C333569939235.size == 0) {
      return;
    }
    aliases = ["dx_cp_cpr2_trpd_fara_itneedskeycards", "dx_cp_cpr2_trpd_pric_needskeycards", "dx_cp_cpr2_trpd_gazz_needskeycardsthreeof"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.4);

    if(_id_11A06898445637E9._id_4B5C333569939235.size == 1) {
      aliases = ["dx_cp_cpr2_trpd_fara_weredownone", "dx_cp_cpr2_trpd_pric_downone", "dx_cp_cpr2_trpd_gazz_weredownone"];
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.8);
    }

    wait 3;
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(_id_7D2852D02216C876);
    aliases = ["dx_cp_cpr2_trpd_fara_letskeepmoving", "dx_cp_cpr2_trpd_pric_letspushon", "dx_cp_cpr2_trpd_gazz_backtoityeah"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.5);
    return;
  }
}

_id_168C4AED35E75369() {
  player = _id_62E11D77B25C1D30::_id_15FCF4C7B710C321(-4782, -5073, 2866, 2598, 70, -70);
  alias = undefined;

  if(player._id_938E8B2CA6549759 == "farah")
    alias = "dx_cp_cpr2_trpp_pric_farah";
  else if(player._id_938E8B2CA6549759 == "gaz")
    alias = "dx_cp_cpr2_trpp_pric_gaz";

  if(isDefined(alias))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, alias);

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr2_trpd_pric_fuckmyoldboots", 0.2);
}

_id_3716DB9770DC5266() {
  for(;;) {
    foreach(player in level.players) {
      if(_id_DAD96AE32B52A3A9(player))
        return player;
    }

    waitframe();
  }
}

_id_DAD96AE32B52A3A9(player) {
  return _id_62E11D77B25C1D30::_id_816A81935C705C98(player, -4396, -5069, 4189, 2380, 270, 45);
}

_id_69A1CB41E85F305B() {
  area = (-4694.63, 3937.54, 190);

  if(!isalive(level.farah)) {
    return;
  }
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(area, 0.8, 0.3, 0, scripts\engine\utility::array_remove(level.players, level.farah), 300)[0];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr2_trpd_fara_weaponstools", 0.2);

  if(!isalive(level.price)) {
    return;
  }
  _id_62E11D77B25C1D30::_id_15FCF4C7B710C321(-4403, -4928, 4174, 3713, 249, 143, 1, level.price);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr2_trpd_pric_aqsbeenhereawhile", 0.2);

  if(!isalive(level._id_E0632103DFA5BB19)) {
    return;
  }
  _id_62E11D77B25C1D30::_id_15FCF4C7B710C321(-4403, -4928, 4174, 3713, 249, 143, 1, level._id_E0632103DFA5BB19);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level._id_E0632103DFA5BB19, "dx_cp_cpr2_trpd_gazz_evenleftthelighton", 0.3);
  thread _id_75BAE24C15132869();
}

_id_A39C97933985B5F4(weapon) {
  level endon("game_ended");
  level endon("vo_spottedSecretWeapon");
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(weapon, 0.7, 0.3, 0, undefined, 200, (0, 0, 15))[0];
  aliases = ["dx_cp_cpr2_trpd_fara_theresablueprinthere", "dx_cp_cpr2_trpd_pric_foundablueprint", "dx_cp_cpr2_trpd_gazz_gotablueprinthere"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  level notify("vo_spottedSecretWeapon");
}

_id_FF078026D67B1A6B(weapon) {
  if(!isDefined(level._id_609A7229CB425C02))
    level._id_609A7229CB425C02 = [];

  if(scripts\engine\utility::array_contains(level._id_609A7229CB425C02, self)) {
    return;
  }
  level._id_609A7229CB425C02[level._id_609A7229CB425C02.size] = self;

  if(level._id_609A7229CB425C02.size == level.players.size)
    scripts\engine\utility::flag_set("vo_pickedUpSecretWeapon");

  aliases = ["dx_cp_cpr2_trpd_fara_aqwontbeneedingthis", "dx_cp_cpr2_trpd_pric_imkeepingthis", "dx_cp_cpr2_trpd_gazz_sweetheat"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(self, aliases, 0.6);
}

_id_75BAE24C15132869() {
  scripts\engine\utility::flag_wait("vo_pickedUpSecretWeapon");
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(8, 15, 3);
  _id_6A1446BABBE17F7F = [];

  while(_id_6A1446BABBE17F7F.size < level.players.size) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    _id_66FC67B3DE879008 = undefined;

    foreach(player in scripts\engine\utility::array_randomize(level.players)) {
      if(_id_62E11D77B25C1D30::_id_816A81935C705C98(player, -4403, -4928, 4174, 3713, 249, 143)) {
        _id_66FC67B3DE879008 = player;
        break;
      }
    }

    if(!isDefined(_id_66FC67B3DE879008)) {
      return;
    }
    player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(scripts\engine\utility::array_add(_id_6A1446BABBE17F7F, _id_66FC67B3DE879008));
    _id_6A1446BABBE17F7F[_id_6A1446BABBE17F7F.size] = player;
    aliases = ["dx_cp_cpr2_trpd_fara_letsheadbackfindalex", "dx_cp_cpr2_trpd_pric_alrightletsheadout", "dx_cp_cpr2_trpd_gazz_letsgetbacktoityeah"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  }
}

_id_330F7B3366542365() {
  level endon("seq4_exit_door_door_open");
  scripts\engine\utility::flag_wait("vo_rappelVentilationClear");
  door = (-5124.53, 2507.8, -58);
  _id_05C70E8827622861(door);
}

_id_7029BF8C5A168BED() {
  for(;;) {
    foreach(player in level.players) {
      if(!isDefined(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(player _meth_9CC921A57FF4DEB5())
        return player;
    }

    waitframe();
  }
}

_id_EA12F5A1AE0234F0() {
  for(;;) {
    _id_EE04FC82FA87166F = 0;

    foreach(player in level.players) {
      if(isalive(player) && player isonground())
        _id_EE04FC82FA87166F++;
    }

    if(_id_EE04FC82FA87166F == 3) {
      return;
    }
    waitframe();
  }
}

_id_61F81FD71A1BB37F(timeout) {
  if(isDefined(timeout)) {
    struct = spawnStruct();
    struct scripts\cp\utility::notify_delay("timeout", timeout);
    struct endon("timeout");
  }

  level waittill("player_touching_platform", player, _id_36C12D04A03471D6);
  return player;
}

_id_4889FAD559F76542(height) {
  foreach(player in level.players) {
    if(player.origin[2] < height)
      return 1;
  }

  return 0;
}

_id_2AD5C0CE0FA8F697(height) {
  foreach(player in level.players) {
    if(player.origin[2] > height)
      return 0;
  }

  return 1;
}

_id_AAC9CBB13160E609(height) {
  count = 0;

  foreach(player in level.players) {
    if(player.origin[2] > height)
      count++;
  }

  return count;
}

_id_0A57DEC546876DA1(ents, _id_FBF2840DF6D0452F) {
  if(!isarray(_id_FBF2840DF6D0452F))
    _id_FBF2840DF6D0452F = [_id_FBF2840DF6D0452F];

  struct = spawnStruct();

  foreach(msg in _id_FBF2840DF6D0452F) {
    foreach(ent in ents)
    ent childthread _id_4B9AB96C345311A6(msg, struct);
  }

  struct waittill("returned", msg, ent, _id_A9B8FA5C0A14AD43, _id_A9B8FB5C0A14AF76, _id_A9B8FC5C0A14B1A9);
  struct notify("die");
  return [ent, msg, _id_A9B8FA5C0A14AD43, _id_A9B8FB5C0A14AF76, _id_A9B8FC5C0A14B1A9];
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

_id_7A2F2E0693A3B2B3() {
  level endon("game_ended");
  _id_6312ECFCDCAA33BF = (-4832.13, 982.454, -2757);
  _id_F1AF323AD78C802A = (-4817.38, 990.753, -2489.65);
  _id_44FD9D044DE2130B = [_id_62E11D77B25C1D30::_id_57E617784FB02909, _id_6312ECFCDCAA33BF, _id_F1AF323AD78C802A, 0.97, 0.6, 0, [], 250];
  thread _id_1A7E234D729B5993(_id_F1AF323AD78C802A);
  return _id_BDAD11D01FF14F3F([_id_44FD9D044DE2130B, ::_id_7C477FCDD28D98D0]);
}

_id_BDAD11D01FF14F3F(funcs) {
  struct = spawnStruct();

  foreach(_id_6087AE7DD4379CD3 in funcs) {
    if(isarray(_id_6087AE7DD4379CD3)) {
      struct thread _id_55870452E821A3C1(_id_6087AE7DD4379CD3[0], scripts\engine\utility::array_remove_index(_id_6087AE7DD4379CD3, 0));
      continue;
    }

    struct thread _id_55870452E821A3C1(_id_6087AE7DD4379CD3);
  }

  if(!istrue(struct._id_0F5E6316C2383F5F))
    struct waittill("result");

  return struct.result;
}

_id_55870452E821A3C1(func, params) {
  self endon("result");
  self.result = _id_5D265B4FCA61F070::call_with_params(func, params);
  self._id_0F5E6316C2383F5F = 1;
  self notify("result");
}

_id_0C399B9BD0244642(time, func, params) {
  while(time > 0) {
    if(!istrue(_id_5D265B4FCA61F070::call_with_params(func, params)))
      return 0;

    time = time - 0.05;
    waitframe();
  }

  return 1;
}

_id_7C477FCDD28D98D0() {
  for(;;) {
    foreach(player in level.players) {
      if(!isDefined(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(player isonladder())
        return player;
    }

    waitframe();
  }
}

_id_F428223F1149C9F5(_id_E95CEB3B8D7CB4DC) {
  for(;;) {
    foreach(player in level.players) {
      if(_id_61E87BFAF2361A65(player, _id_E95CEB3B8D7CB4DC))
        return player;
    }

    waitframe();
  }
}

_id_61E87BFAF2361A65(player, _id_E95CEB3B8D7CB4DC) {
  _id_4F0FC1C36324AFFB = squared(100);

  if(!isDefined(player) || !player scripts\cp\utility::is_valid_player(1, 1))
    return 0;

  return player isonladder() && distancesquared(player.origin, _id_E95CEB3B8D7CB4DC) < _id_4F0FC1C36324AFFB;
}

_id_989A88E63186B0FB() {
  for(;;) {
    foreach(player in level.players) {
      if(!isDefined(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(istrue(player._id_30977AE2A78FF7E5)) {
        continue;
      }
      if(player _meth_415FE9EECA7B2E2B())
        return player;
    }

    waitframe();
  }
}

_id_55B1E3DB3A1FEFEE(origin, maxdist) {
  distsq = squared(maxdist);

  for(;;) {
    foreach(player in level.players) {
      if(!isDefined(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(istrue(player._id_30977AE2A78FF7E5)) {
        continue;
      }
      if(player _meth_415FE9EECA7B2E2B() && distancesquared(player.origin, origin) < distsq)
        return player;
    }

    waitframe();
  }
}

_id_07D33A297FE77317(time) {
  for(;;) {
    foreach(player in level.players) {
      if(!isDefined(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(player _meth_415FE9EECA7B2E2B()) {
        if(!isDefined(player._id_17298D0C9865A53E))
          player._id_17298D0C9865A53E = 0;

        player._id_17298D0C9865A53E = player._id_17298D0C9865A53E + 0.05;
      } else
        player._id_17298D0C9865A53E = 0;

      if(player._id_17298D0C9865A53E > time)
        return player;
    }

    waitframe();
  }
}

_id_5C8F9B467406FFCC(_id_636C8575D7A7768B) {
  for(;;) {
    foreach(player in level.players) {
      if(_id_CD9C4519FC43F244(player, _id_636C8575D7A7768B))
        return player;
    }

    waitframe();
  }
}

_id_CD9C4519FC43F244(player, _id_636C8575D7A7768B) {
  _id_4F0FC1C36324AFFB = squared(_id_636C8575D7A7768B);

  if(!isDefined(player) || !player scripts\cp\utility::is_valid_player(1, 1))
    return 0;

  foreach(ai in getaiarray()) {
    if(distancesquared(player.origin, ai.origin) < _id_4F0FC1C36324AFFB)
      return 1;
  }

  return 0;
}

_id_B65BCB262597FB2B() {
  level endon("game_ended");
  level endon("trap_platforms_done");
  childthread _id_B3BF112368E8CD8D();
  childthread _id_FD3014095E564B32();
  childthread _id_E09251F004271F00();
  childthread _id_D2494F7D54CA0A6C();
  _id_592E5478D4BF7030();
  childthread _id_E4D7F8836C40BA35();
}

_id_B3BF112368E8CD8D() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpo_fara_aqwentthroughhere";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_pric_theybreachedthrough";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_gazz_floorsbreached";
  _id_0416CA60B3985426 = (-5192.01, 2407.27, -53.1);
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_0416CA60B3985426, 0.98, 0.3, 0, undefined, 300)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.4);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpo_fara_letsmove";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_pric_letsmove";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_gazz_letsmove";
  wait 6;
  childthread _id_F40F0B1AE93F961A(aliases);
}

_id_409A0410C75EC5A4() {
  level endon("vo_looking_at_kitchen_door");
  _id_92A922B82C71C6DA = self.origin;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpo_fara_tripwire";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_pric_holdupanothertripwir";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_gazz_waittheresatripwire";

  if(!isDefined(level.tripwires) || !isDefined(level.tripwires.tripwires)) {
    return;
  }
  offset = (-50, -50, 0);
  _id_9B22BC4B395CBD52 = length(offset);
  [player, target] = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(level.tripwires.tripwires, 0.85, 0.1, 0, [], 150, (-50, -50, 0));
  _id_C8BEAA3561609074 = scripts\engine\utility::getclosest(target, level.tripwires.tripwires, _id_9B22BC4B395CBD52 + 10);

  if(isDefined(_id_C8BEAA3561609074) && _id_C8BEAA3561609074.triggered == 0)
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_F40F0B1AE93F961A(aliases) {
  players = _id_6D9F25F0B3035358(-60);

  if(players.size > 1) {
    player = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(5, players);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  }
}

_id_FD3014095E564B32() {
  level endon("game_ended");
  level endon("trap_platforms_done");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpo_fara_flashlightson";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_pric_torchesup";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_gazz_torcheson";
  _id_7E98C7E518C708A4 = getEnt("oldroom_flashlights", "targetname");

  for(;;) {
    _id_7E98C7E518C708A4 waittill("trigger", player);

    if(isPlayer(player)) {
      break;
    }

    waitframe();
  }

  childthread _id_409A0410C75EC5A4();

  if(isPlayer(player))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_E09251F004271F00() {
  _id_D265C0390B11BF83 = [];
  _id_D265C0390B11BF83[_id_D265C0390B11BF83.size] = "dx_cp_cpr2_trpo_fara_moreaq";
  _id_D265C0390B11BF83[_id_D265C0390B11BF83.size] = "dx_cp_cpr2_trpo_pric_moreaq";
  _id_D265C0390B11BF83[_id_D265C0390B11BF83.size] = "dx_cp_cpr2_trpo_gazz_gotmoreaq";
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpo_fara_theyrebelowus";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_pric_belowus";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_gazz_underus";
  origin = (-3862.51, 1622.71, -152.5);
  player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(origin, 60)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_D265C0390B11BF83);
  players = _id_6D9F25F0B3035358(-210);

  if(isDefined(player) && players.size > 0)
    players = scripts\engine\utility::array_remove(level.players, player);

  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3, scripts\engine\utility::array_add_safe(players, player));
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);
}

_id_D2494F7D54CA0A6C() {
  _id_754DA3D61E35CCBF = (-3686.89, 1217.66, -145);
  _id_754DA4D61E35CEF2 = (-2992.25, 1494.36, -145);
  _id_754DA5D61E35D125 = (-3250.4, 1942.39, -145);
  _id_E8C1AFCAB99296B0 = [_id_754DA3D61E35CCBF, _id_754DA4D61E35CEF2, _id_754DA5D61E35D125];
  _id_56715444B3139F79 = [];
  _id_56715444B3139F79[_id_56715444B3139F79.size] = "dx_cp_cpr2_trpo_fara_theresanopeninghere";
  _id_56715444B3139F79[_id_56715444B3139F79.size] = "dx_cp_cpr2_trpo_pric_foundanopening";
  _id_56715444B3139F79[_id_56715444B3139F79.size] = "dx_cp_cpr2_trpo_gazz_gotanopeninghere";
  _id_D99D7A32B0B8E014 = [];
  _id_D99D7A32B0B8E014[_id_D99D7A32B0B8E014.size] = "dx_cp_cpr2_trpo_fara_foundanotheropening";
  _id_D99D7A32B0B8E014[_id_D99D7A32B0B8E014.size] = "dx_cp_cpr2_trpo_pric_anotheropeninghere";
  _id_D99D7A32B0B8E014[_id_D99D7A32B0B8E014.size] = "dx_cp_cpr2_trpo_gazz_anotherdropdownhere";
  [player, target] = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_E8C1AFCAB99296B0, 0.95, 0.2, 0, undefined, 350);

  if(target == _id_754DA3D61E35CCBF)
    _id_E8C1AFCAB99296B0 = scripts\engine\utility::array_remove(_id_E8C1AFCAB99296B0, _id_754DA3D61E35CCBF);
  else if(target == _id_754DA4D61E35CEF2)
    _id_E8C1AFCAB99296B0 = scripts\engine\utility::array_remove(_id_E8C1AFCAB99296B0, _id_754DA4D61E35CEF2);
  else if(target == _id_754DA5D61E35D125)
    _id_E8C1AFCAB99296B0 = scripts\engine\utility::array_remove(_id_E8C1AFCAB99296B0, _id_754DA5D61E35D125);

  if(player.origin[2] > -190 && !scripts\engine\utility::flag("vo_strict_combat"))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_56715444B3139F79);

  [player, target] = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_E8C1AFCAB99296B0, 0.95, 0.2, 0, undefined, 350);

  if(player.origin[2] > -190 && !scripts\engine\utility::flag("vo_strict_combat"))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_D99D7A32B0B8E014);

  childthread _id_C319E382320AB932();
}

_id_C319E382320AB932() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpo_fara_wellhavetodropdown";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_pric_wellhavetodropdown";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_gazz_weneedtodropdown";
  wait 7;
  players = _id_6D9F25F0B3035358(-165);

  if(players.size > 1) {
    player = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(5, players);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  }
}

_id_592E5478D4BF7030() {
  level endon("game_ended");
  level endon("trap_platforms_done");

  for(;;) {
    players = _id_93C58B66A9BD16C8(-165);

    if(players.size > 0) {
      break;
    }

    wait 0.5;
  }

  _id_2386AF9F09E40BAC = (-4113.78, 1956.11, -371.04);
  _id_54EB9EACE6D1CC2D = [];
  _id_54EB9EACE6D1CC2D[_id_54EB9EACE6D1CC2D.size] = "dx_cp_cpr2_trpo_fara_downstairsmove";
  _id_54EB9EACE6D1CC2D[_id_54EB9EACE6D1CC2D.size] = "dx_cp_cpr2_trpo_pric_headdownstairs";
  _id_54EB9EACE6D1CC2D[_id_54EB9EACE6D1CC2D.size] = "dx_cp_cpr2_trpo_gazz_downthestairs";
  _id_ABD5A17E0FABE6F2 = [];
  _id_ABD5A17E0FABE6F2[_id_ABD5A17E0FABE6F2.size] = "dx_cp_cpr2_trpo_fara_downstairsmove_01";
  _id_ABD5A17E0FABE6F2[_id_ABD5A17E0FABE6F2.size] = "dx_cp_cpr2_trpo_pric_headdownstairs_01";
  _id_ABD5A17E0FABE6F2[_id_ABD5A17E0FABE6F2.size] = "dx_cp_cpr2_trpo_gazz_downthestairs_01";
  _id_C8DADD43AEFDC396 = 0;

  while(!_id_C8DADD43AEFDC396) {
    _id_C8DADD43AEFDC396 = scripts\cp\utility::any_player_nearby((-4113.78, 1956.11, -371.04), 90000);
    wait 1;
  }

  player = _id_62E11D77B25C1D30::_id_F28ADB32E474B426(-350);

  if(scripts\engine\utility::flag("vo_strict_combat"))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_54EB9EACE6D1CC2D, 0.3);
  else
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_ABD5A17E0FABE6F2, 0.3);

  childthread _id_CFDF545C82B70783();
  thread _id_FE6EE44823FF6590();
}

_id_E4D7F8836C40BA35() {
  level endon("vo_looking_at_kitchen_door");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpo_fara_weneedapathforward";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_pric_lookforawayoutofhere";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_gazz_weneedawayoutofhere";
  wait 7;

  for(;;) {
    if(!scripts\engine\utility::flag("vo_strict_combat")) {
      break;
    }

    wait 0.1;
  }

  wait 5;
  player = _id_62E11D77B25C1D30::_id_A9D9C0245997A414(3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_B010B4375C28E3C1() {
  level endon("game_ended");
  level endon("trap_platforms_done");
  childthread _id_C06D8E63B5C3F0E7();
  childthread _id_A09FE79186FFDE35();
  childthread _id_17CC468C7CFC6F64();
  childthread _id_CD069728592B3629();
  childthread _id_FF63A2DA0A1DCEF8();
}

_id_CFDF545C82B70783() {
  level endon("vo_looking_at_kitchen_door");
  level endon("vo_breakout_wall_oldrooms_c4_used");
  _id_45023C04B5E387AE = (-3119, 1350, -455);
  found = [];
  found[found.size] = "dx_cp_cpr2_trpo_fara_theresanotherarmory";
  found[found.size] = "dx_cp_cpr2_trpo_pric_anotherarmory";
  found[found.size] = "dx_cp_cpr2_trpo_gazz_foundanotherarmory";
  _id_7E9CCC2D6DDB44DA = [];
  _id_7E9CCC2D6DDB44DA[_id_7E9CCC2D6DDB44DA.size] = "dx_cp_cpr2_trpo_fara_aqwasexpectingafight";
  _id_7E9CCC2D6DDB44DA[_id_7E9CCC2D6DDB44DA.size] = "dx_cp_cpr2_trpo_pric_aqwaspreparedtofight";
  _id_7E9CCC2D6DDB44DA[_id_7E9CCC2D6DDB44DA.size] = "dx_cp_cpr2_trpo_gazz_theywerereadyforafig";

  for(;;) {
    if(getaicount("axis") == 0) {
      break;
    }

    waitframe();
  }

  player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(_id_45023C04B5E387AE, 200)[0];
  _id_1B14E48CBE8CF9A9 = _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, found, 0.3, 0.4, 2);
  speakers = scripts\engine\utility::array_remove(level.players, player);
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(2, speakers);

  if(_id_1B14E48CBE8CF9A9)
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_7E9CCC2D6DDB44DA, 0.3, 0.4, 3);
}

_id_C06D8E63B5C3F0E7() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpo_fara_wecanbreachthedoor";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_pric_wecanbreachthisdoor";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_gazz_wecanbreachthroughhe";
  _id_4EACCEAD759685D0 = (-2901, 1198, -457);
  _id_14209210239F33AB = "breakout_wall_oldrooms";
  _id_0FE5E08B6494785E = scripts\engine\utility::getStruct(_id_14209210239F33AB, "script_noteworthy");
  _id_F5B975BF5237CFF0 = _id_0FE5E08B6494785E.origin - (0, 0, 18);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_F5B975BF5237CFF0, 0.9, 0.1, 0, undefined, 200)[0];
  level notify("vo_looking_at_kitchen_door");
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  childthread _id_0B6FF4C82F833BDE(_id_14209210239F33AB, _id_F5B975BF5237CFF0);
  childthread _id_9D667338B29F4942(_id_14209210239F33AB, _id_F5B975BF5237CFF0);
  childthread _id_492DE6E0B8118716(_id_14209210239F33AB, _id_F5B975BF5237CFF0);
}

_id_0B6FF4C82F833BDE(noteworthy, origin) {
  level endon("vo_" + noteworthy + "_c4_used");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpo_fara_setthecharges";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_pric_setcharges";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_gazz_plantthecharges";

  for(;;) {
    if(scripts\cp\utility::are_all_players_nearby(origin, 90000)) {
      break;
    }

    wait 0.5;
  }

  player = _id_62E11D77B25C1D30::_id_43D8FA96ACF30CA8(origin, 3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_9D667338B29F4942(noteworthy, origin) {
  aliases = [];
  level endon("vo_" + noteworthy + "_c4_used");
  aliases[aliases.size] = "dx_cp_cpr2_trpo_fara_getchargesonthedoor";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_pric_plantthechargeswereg";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_gazz_setchargesonthedoor";
  wait 12;
  times_nagged = 0;
  _id_8BA8A42D1A94EDB7 = [];

  while(times_nagged < 3) {
    if(scripts\cp\utility::are_all_players_nearby(origin, 160000)) {
      speakers = sortbydistance(level.players, origin);

      foreach(player in speakers) {
        if(!isDefined(player)) {
          continue;
        }
        if(!scripts\engine\utility::array_contains(_id_8BA8A42D1A94EDB7, player)) {
          _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 0.8, 0.5);

          if(isDefined(player))
            _id_8BA8A42D1A94EDB7[_id_8BA8A42D1A94EDB7.size] = player;

          times_nagged++;
          wait(randomfloatrange(9, 12));
        }
      }
    }

    waitframe();
  }
}

_id_492DE6E0B8118716(noteworthy, origin) {
  _id_F37ED82DFDB3EB35 = [];
  _id_F37ED82DFDB3EB35[_id_F37ED82DFDB3EB35.size] = "dx_cp_cpr2_trpo_fara_chargessetgetsafe";
  _id_F37ED82DFDB3EB35[_id_F37ED82DFDB3EB35.size] = "dx_cp_cpr2_trpo_pric_weresetbackup";
  _id_F37ED82DFDB3EB35[_id_F37ED82DFDB3EB35.size] = "dx_cp_cpr2_trpo_gazz_chargesarehotfindsom";
  door_open = [];
  door_open[door_open.size] = "dx_cp_cpr2_trpo_fara_doorsopen";
  door_open[door_open.size] = "dx_cp_cpr2_trpo_pric_goodbreach";
  door_open[door_open.size] = "dx_cp_cpr2_trpo_gazz_goodbreach";
  _id_1E92C20ECC065CD0 = [];
  _id_1E92C20ECC065CD0[_id_1E92C20ECC065CD0.size] = "dx_cp_cpr2_trpo_fara_letsmove_01";
  _id_1E92C20ECC065CD0[_id_1E92C20ECC065CD0.size] = "dx_cp_cpr2_trpo_pric_moveup";
  _id_1E92C20ECC065CD0[_id_1E92C20ECC065CD0.size] = "dx_cp_cpr2_trpo_gazz_doorsopen";
  level waittill("vo_" + noteworthy + "_c4_used");
  wait 1.5;
  player = _id_62E11D77B25C1D30::_id_43D8FA96ACF30CA8(origin, 3, level.players, 150);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_F37ED82DFDB3EB35, 0.3);
  level waittill(noteworthy + "_wall_blown");
  wait 1.5;
  player = _id_62E11D77B25C1D30::_id_215866EE17ECD840(origin, 3, 300);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, door_open, 0.3);
  level endon("vo_spotted_trap_intro_opening");
  player = _id_62E11D77B25C1D30::_id_215866EE17ECD840(origin, 3, 300);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_1E92C20ECC065CD0, 0.3);
}

_id_A09FE79186FFDE35() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpo_fara_theydroppeddownhere";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_pric_theywentdownthere";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_gazz_aqsdownthere";
  _id_4E19B0E89937FFAB = [];
  _id_4E19B0E89937FFAB[_id_4E19B0E89937FFAB.size] = "dx_cp_cpr2_trpo_fara_thenletsgo";
  _id_4E19B0E89937FFAB[_id_4E19B0E89937FFAB.size] = "dx_cp_cpr2_trpo_pric_wellletsgodowntheret";
  _id_4E19B0E89937FFAB[_id_4E19B0E89937FFAB.size] = "dx_cp_cpr2_trpo_gazz_thenletsgetafterem";
  _id_0D40B5EEC09826F2 = (-2665.51, 1160.66, -485);
  childthread _id_C005553D99DBF2AC();
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_0D40B5EEC09826F2, 0.93, 0.3, 0, undefined, 250)[0];
  level notify("vo_spotted_trap_intro_opening");
  _id_31E40E7712C5C799 = _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);

  if(level.players.size > 1) {
    speakers = _id_6D9F25F0B3035358(-495);

    if(isDefined(player))
      speakers = scripts\engine\utility::array_remove(speakers, player);

    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_A9D9C0245997A414(3, speakers);

    if(_id_31E40E7712C5C799)
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_4E19B0E89937FFAB, 0.3);
  }
}

_id_8673C93D1793EB32() {
  level endon("vo_spotted_trap_intro_opening");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpo_fara_letsmove_01";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_pric_moveup";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_gazz_doorsopen";
  wait 4;
  player = _id_62E11D77B25C1D30::_id_A9D9C0245997A414(2);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_C005553D99DBF2AC() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpo_fara_letsdropdown";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_pric_letsheaddown";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_gazz_letsgetdownthere";
  level waittill("vo_spotted_trap_intro_opening");
  wait 10;
  _id_0D40B5EEC09826F2 = (-2665.51, 1160.66, -485);
  players = _id_6D9F25F0B3035358(-495);

  if(players.size > 1) {
    player = _id_62E11D77B25C1D30::_id_88BC9CD1FFAB6FEF(_id_0D40B5EEC09826F2, 3, players, 400);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  }
}

_id_17CC468C7CFC6F64() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_itsblockedbehindus";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_exitsblocked";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_wereblockedbackhere";
  _id_11D6808A2DEA81A0 = (-2874, 1172, -541);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_11D6808A2DEA81A0, 0.93, 0.3, 0, undefined, 150)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_FE6EE44823FF6590() {
  level endon("vo_loadout_taken");
  level endon("any_player_in_trap_room");

  foreach(player in level.players)
  player childthread _id_C5E868F158E0DD63();
}

_id_C5E868F158E0DD63() {
  self waittill("giveLoadout");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_grabsomegearhurry";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_gearupmakeitfast";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_grabaloadoutfast";
  result = _id_62E11D77B25C1D30::_id_A606867D80CFABD5(self, aliases, 0.5);

  if(result)
    level notify("vo_loadout_taken");
}

_id_CD069728592B3629() {
  level._id_960790044AA78AC7 = 0;
  _id_EA11F75FDC6AF106 = [];
  _id_EA11F75FDC6AF106[_id_EA11F75FDC6AF106.size] = "dx_cp_cpr2_trpg_fara_controlsarehere";
  _id_EA11F75FDC6AF106[_id_EA11F75FDC6AF106.size] = "dx_cp_cpr2_trpg_pric_controlterminalhere";
  _id_EA11F75FDC6AF106[_id_EA11F75FDC6AF106.size] = "dx_cp_cpr2_trpg_gazz_theresacontroltermin";
  _id_16DA81F49865879A = [];
  _id_16DA81F49865879A[_id_16DA81F49865879A.size] = "dx_cp_cpr2_trpg_fara_controlsoverhere";
  _id_16DA81F49865879A[_id_16DA81F49865879A.size] = "dx_cp_cpr2_trpg_pric_anotherterminalhere";
  _id_16DA81F49865879A[_id_16DA81F49865879A.size] = "dx_cp_cpr2_trpg_gazz_gotanotherterminalhe";
  _id_25D9156722C684C3 = [];
  _id_25D9156722C684C3[_id_25D9156722C684C3.size] = "dx_cp_cpr2_trpg_fara_morecontrolshere";
  _id_25D9156722C684C3[_id_25D9156722C684C3.size] = "dx_cp_cpr2_trpg_pric_thirdterminalsoverhe";
  _id_25D9156722C684C3[_id_25D9156722C684C3.size] = "dx_cp_cpr2_trpg_gazz_theresathirdterminal";
  childthread _id_FDF26A33C0FD9075(200, 0.87, _id_EA11F75FDC6AF106, _id_16DA81F49865879A, _id_25D9156722C684C3);
  childthread _id_41B1EA8C9443899C(200, 0.87, _id_EA11F75FDC6AF106, _id_16DA81F49865879A, _id_25D9156722C684C3);
  childthread _id_34CBEAE61FB4EEFA(200, 0.87, _id_EA11F75FDC6AF106, _id_16DA81F49865879A, _id_25D9156722C684C3);
  childthread _id_2031CB5015278113();
  childthread _id_2EE4D36C77A0F8FB();
}

_id_FDF26A33C0FD9075(range, dot, _id_BDB5F73CAEF68F1B, _id_B110B99805B735B7, _id_FE0D6852A65AD0CC) {
  origin = (-1247.09, 1116.93, -560);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(origin, dot, 0.2, 0, undefined, range)[0];

  if(!isDefined(level._id_960790044AA78AC7))
    level._id_960790044AA78AC7 = 1;
  else
    level._id_960790044AA78AC7++;

  if(level._id_960790044AA78AC7 == 1)
    aliases = _id_BDB5F73CAEF68F1B;
  else if(level._id_960790044AA78AC7 == 2)
    aliases = _id_B110B99805B735B7;
  else
    aliases = _id_FE0D6852A65AD0CC;

  scripts\engine\utility::flag_set("gas_button_seen");
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_41B1EA8C9443899C(range, dot, _id_BDB5F73CAEF68F1B, _id_B110B99805B735B7, _id_FE0D6852A65AD0CC) {
  origin = (-164.35, 851.24, -558.75);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(origin, dot, 0.3, 0, undefined, range)[0];

  if(!isDefined(level._id_960790044AA78AC7))
    level._id_960790044AA78AC7 = 1;
  else
    level._id_960790044AA78AC7++;

  if(level._id_960790044AA78AC7 == 1)
    aliases = _id_BDB5F73CAEF68F1B;
  else if(level._id_960790044AA78AC7 == 2)
    aliases = _id_B110B99805B735B7;
  else
    aliases = _id_FE0D6852A65AD0CC;

  scripts\engine\utility::flag_set("fans_button_seen");
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
  childthread _id_8D76C203C9985C88(origin);
}

_id_8D76C203C9985C88(origin) {
  if(scripts\engine\utility::flag("fans_interact_pressed")) {
    return;
  }
  level endon("vo_fans_pressed");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_thisstopsthefans";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_thesecontrolthefans";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_thisonecutsthefansof";
  wait 1;
  player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(origin, 120)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3, 0.8);
}

_id_34CBEAE61FB4EEFA(range, dot, _id_BDB5F73CAEF68F1B, _id_B110B99805B735B7, _id_FE0D6852A65AD0CC) {
  origin = (821.03, 589.38, -545.5);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(origin, dot, 0.3, 0, undefined, range)[0];

  if(!isDefined(level._id_960790044AA78AC7))
    level._id_960790044AA78AC7 = 1;
  else
    level._id_960790044AA78AC7++;

  if(level._id_960790044AA78AC7 == 1)
    aliases = _id_BDB5F73CAEF68F1B;
  else if(level._id_960790044AA78AC7 == 2)
    aliases = _id_B110B99805B735B7;
  else
    aliases = _id_FE0D6852A65AD0CC;

  scripts\engine\utility::flag_set("door_button_seen");
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
  childthread _id_516216CBF64A325F(origin);
}

_id_516216CBF64A325F(origin) {
  if(scripts\engine\utility::flag("door_interact_pressed")) {
    return;
  }
  level endon("vo_door_pressed");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_foundthedoorcontrols";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_doorcontrols";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_doorcontrolshere";
  wait 1;
  player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(origin, 120)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3, 0.8);
}

_id_2031CB5015278113() {
  origin = (1940, -130, -660);
  level endon("any_player_in_trap_room");
  _id_FEB55F9EC88A82B4 = [];
  _id_FEB55F9EC88A82B4[_id_FEB55F9EC88A82B4.size] = "dx_cp_cpr2_trpg_fara_foundadoor";
  _id_FEB55F9EC88A82B4[_id_FEB55F9EC88A82B4.size] = "dx_cp_cpr2_trpg_pric_gotadoorere";
  _id_FEB55F9EC88A82B4[_id_FEB55F9EC88A82B4.size] = "dx_cp_cpr2_trpg_gazz_theresadoordownhere";
  _id_C36906E1789D7AC7 = [];
  _id_C36906E1789D7AC7[_id_C36906E1789D7AC7.size] = "dx_cp_cpr2_trpg_fara_iseethedoor";
  _id_C36906E1789D7AC7[_id_C36906E1789D7AC7.size] = "dx_cp_cpr2_trpg_pric_foundthedoor";
  _id_C36906E1789D7AC7[_id_C36906E1789D7AC7.size] = "dx_cp_cpr2_trpg_gazz_visualonthedoor";
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(origin, 0.93, 0.15, 0, undefined, 250)[0];

  if(scripts\engine\utility::flag("gas_door_seen")) {
    return;
  }
  scripts\engine\utility::flag_set("gas_door_seen");

  if(scripts\engine\utility::flag("door_interact_pressed"))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_C36906E1789D7AC7, 0.2, 0, 0.5);
  else
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_FEB55F9EC88A82B4, 0.2, 0, 0.5);
}

_id_2EE4D36C77A0F8FB() {
  level endon("vo_kill_gas_linger");
  childthread _id_E87EFE93563BF7DC();
  childthread _id_FDFB894BEBD8B54B();
  origin = (-1842, 1167, -592);

  for(;;) {
    if(_id_2AD5C0CE0FA8F697(-500)) {
      break;
    }

    waitframe();
  }

  wait 6;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_lookforawayoutofhere";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_lookforawayout";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_lookforawayout";
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_A9D9C0245997A414(4);

  if(!_id_90A64D8392654454(250))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3, 0.3, 0.5);

  scripts\engine\utility::flag_set("vo_first_gaslinger_played");
  wait 8;

  if(isDefined(level.farah) && !_id_90A64D8392654454(300) && !scripts\engine\utility::flag("gas_door_seen")) {
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr2_trpg_fara_nuclearweaponschemic", 0.2, 0.3, 0.5);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr2_trpg_fara_thisentirecityitwasm", 0.5, 0.3, 0.5);
  }
}

_id_E87EFE93563BF7DC() {
  for(;;) {
    if(scripts\engine\utility::flag("gas_door_seen") && scripts\engine\utility::flag("door_interact_pressed") || scripts\engine\utility::flag("any_player_in_trap_room")) {
      break;
    }

    waitframe();
  }

  level notify("vo_kill_gas_linger");
}

_id_FDFB894BEBD8B54B() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_itsblockedthisway";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_notseeinganyexits";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_gotfuckalloverere";
  _id_334A63268EF38085 = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_therehastobeaway";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_therehastobeaway";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_therehastobeaway";
  _id_4E19B0E89937FFAB = aliases;
  _id_952B78630C600FED = (-1348, 2517, -592);
  _id_9B9E8FC8B5070BD4 = (-438, 2148, -592);
  _id_83B6DA15CB40AE8E = (167, 2148, -592);
  scripts\engine\utility::flag_wait("vo_first_gaslinger_played");
  player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B([_id_952B78630C600FED, _id_9B9E8FC8B5070BD4, _id_83B6DA15CB40AE8E], 550)[0];
  _id_01C8A00B4DE29A9F = undefined;

  if(!_id_90A64D8392654454(250))
    _id_01C8A00B4DE29A9F = _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_334A63268EF38085, 0.4, 0.3, 0.5);

  players = scripts\engine\utility::array_remove(level.players, player);
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3, players);
  _id_A9C14A524BB959B2 = 0;

  if(istrue(_id_01C8A00B4DE29A9F) && !_id_90A64D8392654454(250))
    _id_A9C14A524BB959B2 = _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_4E19B0E89937FFAB, 0.4, 0.3, 1);

  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_weshouldtrythatdoor";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_weshouldtrythatdoor";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_weshouldtrythatdoor";

  if(scripts\engine\utility::flag("gas_door_seen")) {
    if(istrue(_id_A9C14A524BB959B2) && !_id_90A64D8392654454(250)) {
      _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3);
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.4, 0.3, 1);
    }
  }
}

_id_FF63A2DA0A1DCEF8() {
  childthread _id_B90E09F3961C8C27();
  childthread _id_97213FDCB5ABAA76();
  childthread _id_F1B29512A840E41C();
  childthread _id_1A07E94FD8A886E7();
}

_id_B90E09F3961C8C27() {
  _id_597D3DFB5C841467 = [];
  _id_597D3DFB5C841467[_id_597D3DFB5C841467.size] = "dx_cp_cpr2_trpg_fara_itsclearingthegas";
  _id_597D3DFB5C841467[_id_597D3DFB5C841467.size] = "dx_cp_cpr2_trpg_pric_itsventingthegas";
  _id_597D3DFB5C841467[_id_597D3DFB5C841467.size] = "dx_cp_cpr2_trpg_gazz_gasisclearingout";
  _id_8EFF4B442884C37C = [];
  _id_8EFF4B442884C37C[_id_8EFF4B442884C37C.size] = "dx_cp_cpr2_trpg_fara_ventingthegas";
  _id_8EFF4B442884C37C[_id_8EFF4B442884C37C.size] = "dx_cp_cpr2_trpg_pric_clearingthegas";
  _id_8EFF4B442884C37C[_id_8EFF4B442884C37C.size] = "dx_cp_cpr2_trpg_gazz_ventingnow";
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_ventingthegas_01";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_clearingthegas_01";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_ventingnow_01";
  _id_E8C105BDF3CF42ED = aliases;

  for(;;) {
    level waittill("vo_gas_pressed", player);
    wait 1.5;

    if(scripts\engine\utility::flag("gas_interact_pressed")) {
      if(scripts\engine\utility::flag("vo_strict_combat"))
        _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_E8C105BDF3CF42ED, 0.2);
      else
        _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_8EFF4B442884C37C, 0.2);
    } else
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_597D3DFB5C841467, 0.2);

    if(!scripts\engine\utility::flag("gas_interact_pressed"))
      scripts\engine\utility::flag_set("gas_interact_pressed");

    wait 0.5;
  }
}

_id_F1B29512A840E41C() {
  _id_DC16622BA4C5C379 = [];
  _id_DC16622BA4C5C379[_id_DC16622BA4C5C379.size] = "dx_cp_cpr2_trpg_fara_fansshuttingdown";
  _id_DC16622BA4C5C379[_id_DC16622BA4C5C379.size] = "dx_cp_cpr2_trpg_pric_fansdown";
  _id_DC16622BA4C5C379[_id_DC16622BA4C5C379.size] = "dx_cp_cpr2_trpg_gazz_thefansstopped";
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_fansoff";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_fansoff";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_fansoff";
  _id_26FB231ED788CEDE = aliases;

  for(;;) {
    level waittill("vo_fans_pressed", player);
    wait 1.5;

    if(scripts\engine\utility::flag("vo_strict_combat"))
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_26FB231ED788CEDE, 0.2);
    else
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_DC16622BA4C5C379, 0.2);

    if(!scripts\engine\utility::flag("fans_interact_pressed"))
      scripts\engine\utility::flag_set("fans_interact_pressed");

    wait 0.5;
  }
}

_id_97213FDCB5ABAA76() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_doorsopen";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_doorsunlocked";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_unlockingnow";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_openingnow";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_openingthedoor";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_itsopen";
  _id_32887CF9D13FE7E5 = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_doorsopen_01";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_doorsunlocked_01";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_openingnow_01";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_itsopen_01";
  _id_8D3DB476BB7F9772 = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_doorsopen";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_doorsunlocked";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_unlockingnow";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_openingnow";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_openingthedoor";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_itsopen";
  _id_1B7B7DE0179F242E = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_doorsopen_01";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_doorsunlocked_01";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_openingnow_01";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_itsopen_01";
  _id_E881A64E32C77473 = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_doorsopen";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_doorsunlocked";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_unlockingnow";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_openingnow";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_openingthedoor";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_itsopen";
  _id_8B2FA2DFAF24943B = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_doorsopen_01";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_doorsunlocked_01";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_openingnow_01";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_itsopen_01";
  _id_09D5EDD827BC0EB4 = scripts\engine\utility::create_deck(aliases);
  door_open = [_id_32887CF9D13FE7E5, _id_1B7B7DE0179F242E, _id_8B2FA2DFAF24943B];
  _id_AE7BA56FD4B8BC0B = [_id_8D3DB476BB7F9772, _id_E881A64E32C77473, _id_09D5EDD827BC0EB4];

  for(;;) {
    level waittill("vo_door_pressed", player);
    scripts\engine\utility::flag_wait("vo_gasdoor_open");
    childthread _id_42E7A2ABFB1BE254();

    if(scripts\engine\utility::flag("vo_strict_combat"))
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_AE7BA56FD4B8BC0B, 0.2, 0.6, 0.5);
    else
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, door_open, 0.2, 0.6, 0.5);

    if(!scripts\engine\utility::flag("door_interact_pressed"))
      scripts\engine\utility::flag_set("door_interact_pressed");

    aliases = [];
    aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_theresgasinhere";
    aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_theresgas";
    aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_gasisinhere";
    _id_71CEE3BF4B0B9ED2 = aliases;
    aliases = [];
    aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_weneedtoclearitout";
    aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_lookforcontrolswellh";
    aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_cantgetthroughuntilw";
    _id_8EDA6B4D9F4C9B14 = aliases;

    if(istrue(level._id_26396B92520392D7)) {
      _id_4EACCEAD759685D0 = (1940, -130, -660);
      _id_ED5EC1B91411631A = undefined;
      _id_D6F4447476394CEB = _id_A026A046480475C5();
      player = _id_62E11D77B25C1D30::_id_43D8FA96ACF30CA8((1940, -130, -660), 5, _id_D6F4447476394CEB, 500);
      _id_ED5EC1B91411631A = _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_71CEE3BF4B0B9ED2, 0.2);

      if(isDefined(player) && player _id_A4D4C568A046A7CF()) {
        if(istrue(_id_ED5EC1B91411631A))
          _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_8EDA6B4D9F4C9B14, 0.2);
      } else {
        _id_D6F4447476394CEB = _id_A026A046480475C5();
        _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_A9D9C0245997A414(1.5, _id_D6F4447476394CEB);

        if(istrue(_id_ED5EC1B91411631A))
          _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_8EDA6B4D9F4C9B14, 0.2);
      }

      if(!scripts\engine\utility::flag("gas_button_seen"))
        childthread _id_4CCC34196E1153FC();
    }

    wait 1;
    scripts\engine\utility::flag_waitopen("vo_gasdoor_open");
  }
}

_id_4CCC34196E1153FC() {
  level endon("gas_button_seen");

  if(scripts\engine\utility::flag("gas_button_seen")) {
    return;
  }
  wait 4;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_lookforthegascontrol";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_weneedtolocatecontro";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_weneedtoventthegasse";
  _id_D6F4447476394CEB = _id_A026A046480475C5();
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3, _id_D6F4447476394CEB);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.2);
}

_id_9A72C3D82EAE10C7(time_remaining) {
  _id_158A08A221063E1B = [];
  _id_158A08A221063E1B[_id_158A08A221063E1B.size] = "dx_cp_cpr2_trpg_fara_gaspressureisunstabl";
  _id_158A08A221063E1B[_id_158A08A221063E1B.size] = "dx_cp_cpr2_trpg_pric_gaspressureisbuildin";
  _id_158A08A221063E1B[_id_158A08A221063E1B.size] = "dx_cp_cpr2_trpg_gazz_oigasisbuildingup15m";
  _id_158A0BA2210644B4 = [];
  _id_158A0BA2210644B4[_id_158A0BA2210644B4.size] = "dx_cp_cpr2_trpg_fara_gaspressureisunstabl_01";
  _id_158A0BA2210644B4[_id_158A0BA2210644B4.size] = "dx_cp_cpr2_trpg_pric_gaspressureisbuildin_01";
  _id_158A0BA2210644B4[_id_158A0BA2210644B4.size] = "dx_cp_cpr2_trpg_gazz_gasisbuildingup10mik";
  _id_068754A558BA0DE4 = [];
  _id_068754A558BA0DE4[_id_068754A558BA0DE4.size] = "dx_cp_cpr2_trpg_fara_gaspressureisunstabl_02";
  _id_068754A558BA0DE4[_id_068754A558BA0DE4.size] = "dx_cp_cpr2_trpg_pric_gaspressureisbuildin_02";
  _id_068754A558BA0DE4[_id_068754A558BA0DE4.size] = "dx_cp_cpr2_trpg_gazz_gasisbuildingup9mike";
  _id_068755A558BA1017 = [];
  _id_068755A558BA1017[_id_068755A558BA1017.size] = "dx_cp_cpr2_trpg_fara_gaspressureisunstabl_03";
  _id_068755A558BA1017[_id_068755A558BA1017.size] = "dx_cp_cpr2_trpg_pric_gaspressureisbuildin_03";
  _id_068755A558BA1017[_id_068755A558BA1017.size] = "dx_cp_cpr2_trpg_gazz_gasisbuildingup8mike";
  _id_068748A558B9F380 = [];
  _id_068748A558B9F380[_id_068748A558B9F380.size] = "dx_cp_cpr2_trpg_fara_5minutes";
  _id_068748A558B9F380[_id_068748A558B9F380.size] = "dx_cp_cpr2_trpg_pric_5mikesonthegas";
  _id_068748A558B9F380[_id_068748A558B9F380.size] = "dx_cp_cpr2_trpg_gazz_5mikes";
  _id_06874CA558B9FC4C = [];
  _id_06874CA558B9FC4C[_id_06874CA558B9FC4C.size] = "dx_cp_cpr2_trpg_fara_1minutemove";
  _id_06874CA558B9FC4C[_id_06874CA558B9FC4C.size] = "dx_cp_cpr2_trpg_pric_1minutewegottamove";
  _id_06874CA558B9FC4C[_id_06874CA558B9FC4C.size] = "dx_cp_cpr2_trpg_gazz_1minute";

  switch (time_remaining) {
    case 900:
      aliases = _id_158A08A221063E1B;
      break;
    case 600:
      aliases = _id_158A0BA2210644B4;
      break;
    case 540:
      aliases = _id_068754A558BA0DE4;
      break;
    case 480:
      aliases = _id_068755A558BA1017;
      break;
    case 300:
      aliases = _id_068748A558B9F380;
      break;
    case 60:
      aliases = _id_06874CA558B9FC4C;
      break;
    default:
      aliases = undefined;
      break;
  }

  _id_D6F4447476394CEB = [];
  _id_D6F4447476394CEB = _id_A026A046480475C5();
  player = _id_62E11D77B25C1D30::_id_A9D9C0245997A414(4, _id_D6F4447476394CEB);

  if(isDefined(aliases))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_5914153D9652CC82(time_remaining) {
  _id_157C79A220F6EF19 = [];
  _id_157C79A220F6EF19[_id_157C79A220F6EF19.size] = "dx_cp_cpr2_trpg_fara_youvegot40seconds";
  _id_157C79A220F6EF19[_id_157C79A220F6EF19.size] = "dx_cp_cpr2_trpg_pric_40secondsonthegas";
  _id_157C79A220F6EF19[_id_157C79A220F6EF19.size] = "dx_cp_cpr2_trpg_gazz_40secondsonthevents";
  _id_15927CA2210F28E5 = [];
  _id_15927CA2210F28E5[_id_15927CA2210F28E5.size] = "dx_cp_cpr2_trpg_fara_35seconds";
  _id_15927CA2210F28E5[_id_15927CA2210F28E5.size] = "dx_cp_cpr2_trpg_pric_35seconds";
  _id_15927CA2210F28E5[_id_15927CA2210F28E5.size] = "dx_cp_cpr2_trpg_gazz_35seconds";
  _id_1596FDA221143A6F = [];
  _id_1596FDA221143A6F[_id_1596FDA221143A6F.size] = "dx_cp_cpr2_trpg_fara_20seconds";
  _id_1596FDA221143A6F[_id_1596FDA221143A6F.size] = "dx_cp_cpr2_trpg_pric_20seconds";
  _id_1596FDA221143A6F[_id_1596FDA221143A6F.size] = "dx_cp_cpr2_trpg_gazz_20seconds";
  _id_158A0BA2210644B4 = [];
  _id_158A0BA2210644B4[_id_158A0BA2210644B4.size] = "dx_cp_cpr2_trpg_fara_10seconds";
  _id_158A0BA2210644B4[_id_158A0BA2210644B4.size] = "dx_cp_cpr2_trpg_pric_10seconds";
  _id_158A0BA2210644B4[_id_158A0BA2210644B4.size] = "dx_cp_cpr2_trpg_gazz_10seconds";

  switch (time_remaining) {
    case 40:
      aliases = _id_157C79A220F6EF19;
      _id_B44001BA80D72BCA = 0;
      break;
    case 35:
      aliases = _id_15927CA2210F28E5;
      _id_B44001BA80D72BCA = 1;
      break;
    case 20:
      aliases = _id_1596FDA221143A6F;
      _id_B44001BA80D72BCA = 2;
      break;
    case 10:
      aliases = _id_158A0BA2210644B4;
      _id_B44001BA80D72BCA = 3;
      break;
    default:
      aliases = undefined;
      _id_B44001BA80D72BCA = undefined;
      break;
  }

  _id_F78A2E898EA4139F = [];
  _id_F78A2E898EA4139F[_id_F78A2E898EA4139F.size] = "dx_cp_cpr2_trpg_rupa_ventilatinggas40seco";
  _id_F78A2E898EA4139F[_id_F78A2E898EA4139F.size] = "dx_cp_cpr2_trpg_rupa_ventilatinggas35seco";
  _id_F78A2E898EA4139F[_id_F78A2E898EA4139F.size] = "dx_cp_cpr2_trpg_rupa_ventilatinggas20seco";
  _id_F78A2E898EA4139F[_id_F78A2E898EA4139F.size] = "dx_cp_cpr2_trpg_rupa_ventilatinggas10seco";
  _id_59D0580C01332155 = (-1247.09, 1116.93, -560);
  _id_64D441010374CB5E = (-1247.09, 1116.93, -560);
  player = _id_6817A33C556E64EB();

  if(isDefined(_id_B44001BA80D72BCA)) {
    level thread _id_51D741D1F501856F(_id_59D0580C01332155, _id_F78A2E898EA4139F[_id_B44001BA80D72BCA], 0.2);
    level thread _id_51D741D1F501856F(_id_64D441010374CB5E, _id_F78A2E898EA4139F[_id_B44001BA80D72BCA], 0.2);
  }

  if(isDefined(aliases) && (scripts\engine\utility::flag("any_player_in_trap_room") || scripts\engine\utility::flag("vo_strict_combat")))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 1, 0.2, 1);
}

_id_1A07E94FD8A886E7() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_ventsystemisrestarti";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_thesystemisrestartin";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_theventcontrolsarelo";
  _id_32887CF9D13FE7E5 = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_ventcontrolsarelocke";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_thesystemsrestarting";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_itsrestartingwereloc";
  _id_1B7B7DE0179F242E = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_thecontrolsarelocked";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_itslockedsystemsrest";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_ventcontrolsareoncoo";
  _id_8B2FA2DFAF24943B = scripts\engine\utility::create_deck(aliases);
  _id_393E2E6B03F8588D = [_id_32887CF9D13FE7E5, _id_1B7B7DE0179F242E, _id_8B2FA2DFAF24943B];
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_itsbackup";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_ventsystemsareup";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_ventsystemsready";
  _id_32887CF9D13FE7E5 = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_ventingsready";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_ventcontrolsareup";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_ventsystemisonline";
  _id_1B7B7DE0179F242E = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_ventingsystemsready";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_controlsareunlocked";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_wereonlineventsarere";
  _id_8B2FA2DFAF24943B = scripts\engine\utility::create_deck(aliases);
  _id_BF7CD029C0423F5A = [_id_32887CF9D13FE7E5, _id_1B7B7DE0179F242E, _id_8B2FA2DFAF24943B];
  _id_A1ED6F7A4CA79C1F = (-1247.09, 1116.93, -560);
  _id_64D441010374CB5E = (-1670.6, 243.38, -561.85);

  for(;;) {
    level waittill("start_trap_timer");
    wait 0.5;
    thread _id_7C2610A9F013FFC5(_id_A1ED6F7A4CA79C1F, _id_64D441010374CB5E, _id_393E2E6B03F8588D);
    level waittill("vo_gas_console_ready");
    wait 0.5;
    thread _id_51D741D1F501856F(_id_A1ED6F7A4CA79C1F, "dx_cp_cpr2_trpg_rupa_ventilationsystemrea", 0.2);
    thread _id_51D741D1F501856F(_id_64D441010374CB5E, "dx_cp_cpr2_trpg_rupa_ventilationsystemrea", 0.2);
    wait 2;
    _id_B8DE34BACCE96F81 = _id_A026A046480475C5();
    player = _id_62E11D77B25C1D30::_id_43D8FA96ACF30CA8(_id_A1ED6F7A4CA79C1F, 3, _id_B8DE34BACCE96F81);

    if(scripts\engine\utility::flag("any_player_in_trap_room") || scripts\engine\utility::flag("vo_strict_combat") || scripts\engine\utility::flag("first_player_through_maze")) {
      if(_id_B7B8F6E8931641DE().size < level.players.size)
        _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
    }
  }
}

_id_7C2610A9F013FFC5(origin, _id_771DFEBE644FFBA4, aliases) {
  level endon("vo_gas_console_ready");
  level waittill("vo_gas_cooldown_pressed", player);
  thread _id_51D741D1F501856F(origin, "dx_cp_cpr2_trpg_rupa_ventilationsystemres", 0.2);
  wait 2;

  if(scripts\engine\utility::flag("any_player_in_trap_room") || scripts\engine\utility::flag("vo_strict_combat") || scripts\engine\utility::flag("first_player_through_maze")) {
    if(_id_B7B8F6E8931641DE().size < level.players.size)
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  }
}

_id_42E7A2ABFB1BE254() {
  level notify("vo_player_in_trap_room");
  level endon("vo_player_in_trap_room");
  scripts\engine\utility::flag_wait("any_player_in_trap_room");
  level._id_D017B9C13EC2BB69 = 1;
  player = _id_F4EDC3A26FB79A3D();

  if(!isDefined(player)) {
    return;
  }
  player endon("death");
  player endon("player_exit_maze");
  childthread _id_ADD728D81011893F(player);
  childthread _id_EEC410AC147CDAEA(player);
  wait 5;

  if(!scripts\engine\utility::flag("any_player_in_trap_room")) {
    return;
  }
  childthread _id_157A77FD80A066A5(player);
  childthread _id_019EC54B234A39FE(player);
  childthread _id_8E35247950253C7C(player);
}

_id_EEC410AC147CDAEA(player) {
  for(;;) {
    if(!scripts\engine\utility::flag("any_player_in_trap_room")) {
      break;
    }

    waitframe();
  }

  player notify("player_exit_maze");
}

_id_ADD728D81011893F(player) {
  player endon("death");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_moving";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_immoving";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_movingin";
  _id_CCDC54473D2B175E = (1722.55, -54.27, -714.15);

  if(distance(_id_CCDC54473D2B175E, player.origin) < 250 && !istrue(level._id_26396B92520392D7))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 1, 1);
}

_id_157A77FD80A066A5(player) {
  if(isDefined(player))
    player endon("death");
  else
    return;

  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_thisroomisflooded";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_thissectionsflooded";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_itsfloodedinhere";
  _id_D369496B1B0B9D17 = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_stayoutofthewater";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_donttouchthewater";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_keepoutofthewater";
  _id_2C825ED3CF8A9C17 = aliases;
  _id_3D3C70CEFC707C14 = getEnt("flooded_room_entrance", "script_noteworthy");
  _id_3D3C70CEFC707C14 waittill("trigger", player);

  if(scripts\engine\utility::flag("first_player_through_maze")) {
    return;
  }
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_D369496B1B0B9D17, 0.2, 1, 0.5);

  if(level.players.size > 1) {
    players = scripts\engine\utility::array_remove(level.players, player);
    player = _id_62E11D77B25C1D30::_id_A9D9C0245997A414(4, players);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_2C825ED3CF8A9C17, 0.2, 1);
  }
}

_id_019EC54B234A39FE(player) {
  if(isDefined(player))
    player endon("death");
  else
    return;

  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_afansblockingtheway";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_afansblockingthewayo";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_gotafanblockingme";
  _id_804FB5E030D78CCE = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_imatthefans";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_atthefans";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_imbythefanshittheswi";
  _id_7E48C5549AD83ABF = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_shutoffthefan";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_cutpowertothefan";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_needthisfanoff";
  _id_F12263915907DBFC = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_okayimthrough";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_imthrough";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_madeitthrough";
  _id_20A55DF859C08C0D = aliases;
  _id_EE3EC1998020BF1F = getEntArray("fan_blades", "script_noteworthy");
  _id_3B30990BB5FE3998 = scripts\engine\utility::array_difference(level.players, [player]);
  player = _id_CB93740616AEDC60(_id_EE3EC1998020BF1F, 500, _id_3B30990BB5FE3998)[0];

  if(!scripts\engine\utility::flag("vo_first_reached_fans")) {
    if(!istrue(level._id_ABA1FB7E45F15F7B))
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_804FB5E030D78CCE, 0.2, 1, 1.3);
  } else if(!istrue(level._id_ABA1FB7E45F15F7B))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_7E48C5549AD83ABF, 0.2, 1, 1.3);

  scripts\engine\utility::flag_set("vo_first_reached_fans");
  childthread _id_6F55B7ADACF390C8(player, _id_20A55DF859C08C0D);
  wait 4;

  if(!scripts\engine\utility::flag("vo_runner_past_fans")) {
    if(!istrue(level._id_ABA1FB7E45F15F7B))
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_F12263915907DBFC, 0.2);
  }
}

_id_6F55B7ADACF390C8(player, aliases) {
  if(isDefined(player))
    player endon("death");
  else
    return;

  _id_C3C37205C72EBA3B = getEnt("past_trap_fans", "targetname");
  _id_C3C37205C72EBA3B waittill("trigger", player);
  scripts\engine\utility::flag_set("vo_runner_past_fans");
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 1, 0.5);
}

_id_8E35247950253C7C(player) {
  if(!isDefined(player)) {
    return;
  }
  player endon("player_exit_maze");
  player endon("death");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_iseetheexit";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_foundtheexit";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_imattheexit";
  _id_D9656EB893F0455D = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_openthedoor";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_getthisdooropen";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_openthebloodydoor";
  open_door = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_thegasiscoming";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_gasincoming";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_gasisincoming";
  _id_D4CF3D6B73395C23 = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_youhavetomove";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_getyourarseouttather";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_getoutoftherenow";
  _id_9F8888ABE6A394F7 = aliases;
  origin = (-2396.77, 905.9, -667.41);
  thread _id_C4E47F7297338B3F(player);
  _id_D6F4447476394CEB = _id_A026A046480475C5();
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(origin, 0.87, 0.1, 0, _id_D6F4447476394CEB, 330)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_D9656EB893F0455D, 0.2, 1, 0.3);
  wait 3;

  if(!scripts\engine\utility::flag("vo_gasdoor_open"))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, open_door);
  else if(level.players.size > 1) {
    _id_D6F4447476394CEB = _id_A026A046480475C5();

    if(_id_D6F4447476394CEB.size > 0) {
      _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_A9D9C0245997A414(2, _id_D6F4447476394CEB);
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_D4CF3D6B73395C23, 0.3, 0.8, 0.5);
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_9F8888ABE6A394F7, 0.2, 0.8, 0.7);
    }
  }
}

_id_C4E47F7297338B3F(runner) {
  trigger = getEnt("side_b_gas_door", "script_noteworthy");

  for(;;) {
    trigger waittill("trigger", player);

    if(isPlayer(player) && player == runner) {
      break;
    }

    waitframe();
  }

  player notify("player_exit_maze");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_imadeitout";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_madeit";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_okayimout";
  _id_5652844D62D45BC3 = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_imadeitout_01";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_madeit_01";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_okayimout_01";
  _id_F09A9C5E7FC6C4E2 = aliases;

  if(isDefined(player.loopingcoughaudio)) {
    if(player.loopingcoughaudio > 0)
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_F09A9C5E7FC6C4E2);
    else
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_5652844D62D45BC3, 0.1);
  } else
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_5652844D62D45BC3, 0.1);

  childthread _id_E1B74304B5812F02();
}

_id_E1B74304B5812F02(player) {
  _id_B02EF8BBDEE293D7 = _id_B7B8F5E893163FAB();
  _id_DF0773C99928E2EA = _id_B7B8F6E8931641DE();

  if(scripts\engine\utility::flag("first_player_through_maze")) {
    if(_id_DF0773C99928E2EA.size == level.players.size - 1)
      childthread _id_2266C85CAB2A9881();
    else if(_id_DF0773C99928E2EA.size == level.players.size) {
      aliases = [];
      aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_clearthearea";
      aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_securetheroom";
      aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_aqsstillhere";

      if(getaiarray("axis").size > 0) {
        _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_A9D9C0245997A414(4);
        _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.4);
      }

      childthread _id_402B11EFC31EAD76();
    }
  } else {
    scripts\engine\utility::flag_set("first_player_through_maze");
    aliases = [];
    aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_lookforcontrolsonyou";
    aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_lookforcontrolsonyou";
    aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_lookforcontrolsonyou";
    wait 4;
    _id_40543D2FA19C98BE = _id_62E11D77B25C1D30::_id_A9D9C0245997A414(4, _id_B02EF8BBDEE293D7);
    _id_2E4FA58C67E4E281 = _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_40543D2FA19C98BE, aliases, 0.4, 0.5, 1.5);
    _id_297F171B442CC30E = (-1670.6, 243.38, -561.85);
    _id_297F161B442CC0DB = (-642.18, -78.22, -562.13);
    _id_297F151B442CBEA8 = (417.91, -267.62, -533.6);
    childthread _id_F47D2059986A909E();
    aliases = [];
    aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_iseethem";
    aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_gotavisual";
    aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_gotem";
    player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803([_id_297F171B442CC30E, _id_297F161B442CC0DB, _id_297F151B442CBEA8], 0.87, 0.1, 0, undefined, 300)[0];
    level notify("spotted_b_controls");

    if(istrue(_id_2E4FA58C67E4E281))
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4, 0.5, 1.5);
  }
}

_id_2266C85CAB2A9881() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_getreadyonthecontrol";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_grabthecontrolsandbe";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_youtwoonthecontrolsi";
  _id_7D2852D02216C876 = _id_B7B8F5E893163FAB()[0];
  _id_DF0773C99928E2EA = _id_B7B8F6E8931641DE();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.4);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_imatthedoor";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_atthedoor";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_readyatthedoor";
  _id_06087AE6560313B8 = (1940, -130, -660);
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(_id_06087AE6560313B8, 300, _id_DF0773C99928E2EA)[0];

  if(!scripts\engine\utility::flag("vo_gasdoor_open"))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.3);
}

_id_F47D2059986A909E() {
  level endon("spotted_b_controls");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_thereshouldbecontrol";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_locatethosecontrols";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_findthecontrols";
  wait 5;
  _id_B02EF8BBDEE293D7 = _id_B7B8F5E893163FAB();
  _id_40543D2FA19C98BE = _id_62E11D77B25C1D30::_id_A9D9C0245997A414(4, _id_B02EF8BBDEE293D7);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_40543D2FA19C98BE, aliases, 0.4);
}

_id_402B11EFC31EAD76() {
  level endon("vo_hallway_start");

  for(;;) {
    if(getaicount("axis") == 0) {
      break;
    }

    waitframe();
  }

  wait 8;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpg_fara_lookforanexitonthiss";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_pric_weneedanexit";
  aliases[aliases.size] = "dx_cp_cpr2_trpg_gazz_letsfindanexit";
  player = _id_62E11D77B25C1D30::_id_A9D9C0245997A414(4);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_B0E54597E03F3604() {
  level endon("vo_breakout_wall_a_c4_used");
  trigger = getEnt("pre_gas_wall_1", "targetname");

  for(;;) {
    trigger waittill("trigger", player);

    if(isPlayer(player)) {
      break;
    }

    waitframe();
  }

  level notify("vo_hallway_start");
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr2_trpe_fara_wehavetostopaqtheyca", 0.2, 0.5);
}

_id_00A9F1B83150E746() {
  _id_4EACCEAD759685D0 = (302.4, -3588.07, -617.34);
  _id_7EFF8275A82B99E6 = (308.72, -3622.29, -594.55);
  childthread _id_CC4E3B8C6C287E0C("breakout_wall_a", _id_7EFF8275A82B99E6);
  childthread _id_6FE4BE4A2BC20C08("breakout_wall_a", _id_4EACCEAD759685D0);
  childthread _id_04460E938982EA62("breakout_wall_a", _id_4EACCEAD759685D0);
  childthread _id_B7441DD326153495();
  childthread _id_7877ADEAE540FF46();
  childthread _id_9BA5F43A54F9ECDB();
}

_id_954E17D3147D9F93(origin) {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_theresadoorherewecan";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_foundadoorwecanbreac";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_wecanbreachthroughth";
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(origin, 0.88, 0.1, 0, undefined, 300)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  level notify("vo_player_seen_hall_door");
}

_id_CC4E3B8C6C287E0C(noteworthy, origin) {
  level endon("vo_" + noteworthy + "_c4_used");
  level endon(noteworthy + "_wall_blown");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpo_fara_lookalexleftthis";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_pric_lookerealexscallsign";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_gazz_oiitsalexsmark";
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(origin, 0.88, 0.1, 0, undefined, 300)[0];
  _id_2104266FE37232DE = undefined;
  _id_2104266FE37232DE = _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 0.8, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpo_fara_hecouldstillbealive";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_pric_hardbastard";
  aliases[aliases.size] = "dx_cp_cpr2_trpo_gazz_theresachancehesstil";
  players = scripts\engine\utility::array_remove(level.players, player);
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3, players);

  if(istrue(_id_2104266FE37232DE))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.2, 0.6, 0.75);

  level notify("vo_sigil_lines_said");
  wait 4;
}

_id_6FE4BE4A2BC20C08(noteworthy, origin) {
  level endon("vo_" + noteworthy + "_c4_used");
  level endon(noteworthy + "_wall_blown");
  _id_041724BD008BF2F2 = [];
  _id_041724BD008BF2F2[_id_041724BD008BF2F2.size] = "dx_cp_cpr2_trpe_fara_theresadoorherewecan";
  _id_041724BD008BF2F2[_id_041724BD008BF2F2.size] = "dx_cp_cpr2_trpe_pric_foundadoorwecanbreac";
  _id_041724BD008BF2F2[_id_041724BD008BF2F2.size] = "dx_cp_cpr2_trpe_gazz_wecanbreachthroughth";
  _id_584830B74AA096E5 = [];
  _id_584830B74AA096E5[_id_584830B74AA096E5.size] = "dx_cp_cpr2_trpe_fara_setthechargesonthedo";
  _id_584830B74AA096E5[_id_584830B74AA096E5.size] = "dx_cp_cpr2_trpe_pric_getchargesonthedoor";
  _id_584830B74AA096E5[_id_584830B74AA096E5.size] = "dx_cp_cpr2_trpe_gazz_plantthecharges";
  level waittill("vo_sigil_lines_said");
  wait 4;

  for(;;) {
    if(scripts\cp\utility::are_all_players_nearby(origin, 262144)) {
      break;
    }

    wait 0.25;
  }

  player = _id_62E11D77B25C1D30::_id_43D8FA96ACF30CA8(origin, 3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_041724BD008BF2F2, 0.3, 0.8, 2);
  wait 5;
  speakers = level.players;

  if(isDefined(player))
    speakers = scripts\engine\utility::array_add(scripts\engine\utility::array_remove(level.players, player), player);

  player = _id_62E11D77B25C1D30::_id_88BC9CD1FFAB6FEF(origin, 3, speakers, 400);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_584830B74AA096E5, 0.2, 0.8, 1.5);
}

_id_04460E938982EA62(noteworthy, origin) {
  _id_F37ED82DFDB3EB35 = [];
  _id_F37ED82DFDB3EB35 = [];
  _id_F37ED82DFDB3EB35[_id_F37ED82DFDB3EB35.size] = "dx_cp_cpr2_trpe_fara_standback";
  _id_F37ED82DFDB3EB35[_id_F37ED82DFDB3EB35.size] = "dx_cp_cpr2_trpe_pric_chargesset";
  _id_F37ED82DFDB3EB35[_id_F37ED82DFDB3EB35.size] = "dx_cp_cpr2_trpe_gazz_chargeshot";
  door_open = [];
  door_open[door_open.size] = "dx_cp_cpr2_trpe_fara_move";
  _id_89C2D02436C057F6[door_open.size] = "dx_cp_cpr2_trpe_pric_move";
  _id_89C2D02436C057F6[door_open.size] = "dx_cp_cpr2_trpe_gazz_move";
  level waittill("vo_" + noteworthy + "_c4_used");
  wait 1.5;
  player = _id_62E11D77B25C1D30::_id_43D8FA96ACF30CA8(origin, 3, level.players, 150);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_F37ED82DFDB3EB35, 0.3);
  level waittill(noteworthy + "_wall_blown");
  wait 1.5;
  player = _id_62E11D77B25C1D30::_id_215866EE17ECD840(origin, 3, 300);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, door_open, 0.3);
}

_id_B7441DD326153495() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_thegasiscomingwehave";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_gasisincomingletsmov";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_wegotgasincomingmove";
  level waittill("traproom_enraged");
  _id_06E2EDA8088BF9C0 = getEnt("pre_gas_wall_1", "targetname");
  player = _id_62E11D77B25C1D30::_id_43D8FA96ACF30CA8(_id_06E2EDA8088BF9C0.origin, 4);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1, 0.7, 0.2);
}

_id_7877ADEAE540FF46() {
  if(scripts\engine\utility::flag("vo_passed_oppdoor")) {
    return;
  }
  level endon("vo_passed_oppdoor");
  _id_4EACCEAD759685D0 = (-470, -3400, -656);
  _id_CB920E03144E9344 = 170;
  childthread _id_584BDE9BBCB347EC();
  childthread _id_2258113488EC6F02();
}

_id_584BDE9BBCB347EC() {
  trigger = getEnt("outro_gr1,0,1", "targetname");

  for(;;) {
    trigger waittill("trigger", player);

    if(isPlayer(player)) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("vo_passed_oppdoor");
}

_id_9BA5F43A54F9ECDB() {
  level endon("player_found_breach_wall");
  level endon("vo_breakout_wall_b_c4_used");
  _id_4EACCEAD759685D0 = (-470, -3400, -656);
  _id_CB920E03144E9344 = 170;
  player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(_id_4EACCEAD759685D0, _id_CB920E03144E9344)[0];
  scripts\engine\utility::flag_wait("vo_strict_combat");
  wait 0.5;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_aq";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_contact";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_contact";
  player = _id_62E11D77B25C1D30::_id_43D8FA96ACF30CA8(_id_4EACCEAD759685D0, 3);

  if(getaicount("axis") > 0)
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1, 1, 0.1);

  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_movekeepaheadofthega";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_keepmovingstayaheado";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_letsmovethegasisrigh";
  scripts\engine\utility::flag_waitopen("vo_strict_combat");
  player = _id_62E11D77B25C1D30::_id_A9D9C0245997A414(2);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 0.5);
}

_id_2258113488EC6F02() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_thegasiscoming";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_thegasispushingus";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_weregettingpushedbyt";
  _id_DA4AF9F6AEAF9016 = [];
  _id_DA4AF9F6AEAF9016[_id_DA4AF9F6AEAF9016.size] = "dx_cp_cpr2_trpe_fara_wehavetopushthrough";
  _id_DA4AF9F6AEAF9016[_id_DA4AF9F6AEAF9016.size] = "dx_cp_cpr2_trpe_pric_stackupweremovingin";
  _id_DA4AF9F6AEAF9016[_id_DA4AF9F6AEAF9016.size] = "dx_cp_cpr2_trpe_gazz_letsgetinthere";
  wait 5;

  if(scripts\engine\utility::flag("vo_passed_oppdoor")) {
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(4);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, _id_DA4AF9F6AEAF9016);
  }
}

_id_26C15B16B63B126D(volume) {
  level endon("game_ended");
  _id_B8EDC26CDA0FB4FA();
  speakers = [];

  if(!scripts\engine\utility::flag("vo_passed_oppdoor")) {
    return;
  }
  if(!isDefined(volume)) {
    return;
  }
  trigger = level._id_FB4E36DCF267C9A9[volume];

  if(!isDefined(trigger)) {
    return;
  }
  if(isarray(trigger))
    trigger = trigger[0];

  if(!isDefined(trigger)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    triggering_ent = level.players[_id_AC0E594AC96AA3A8];

    if(triggering_ent istouching(trigger) && triggering_ent scripts\cp\utility::is_valid_player(1))
      speakers[speakers.size] = level.players[_id_AC0E594AC96AA3A8];
  }

  if(speakers.size > 0) {
    if(isDefined(level._id_64AA2711F3BF1739)) {
      if(gettime() - level._id_64AA2711F3BF1739 < 10000)
        return;
    }

    player = _id_62E11D77B25C1D30::_id_A9D9C0245997A414(3, speakers);
    _id_61C2956D029C53DA = _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, level._id_EC0280E81DF9EC4C, 0.2, 1, 0.7);

    if(istrue(_id_61C2956D029C53DA))
      level._id_64AA2711F3BF1739 = gettime();
  }
}

_id_B8EDC26CDA0FB4FA() {
  if(isDefined(level._id_EC0280E81DF9EC4C)) {
    return;
  }
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_gasisclosingin";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_gasisbehindus";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_thegasisgettingclose";
  _id_32887CF9D13FE7E5 = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_gasismovingin";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_gasispushingus";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_gasbehindus";
  _id_1B7B7DE0179F242E = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_thegasismoving";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_gasisclosingonus";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_gasisincoming";
  _id_8B2FA2DFAF24943B = scripts\engine\utility::create_deck(aliases);
  level._id_EC0280E81DF9EC4C = [_id_32887CF9D13FE7E5, _id_1B7B7DE0179F242E, _id_8B2FA2DFAF24943B];
}

_id_0F43A35048F4ADE0() {
  childthread _id_ECB7675005ED1A5A();
  childthread _id_63BF7ED87AFBA01C();
  childthread _id_01DFCF613436C08E();
}

_id_ECB7675005ED1A5A() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_thisway";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_endothehall";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_throughhere";
  trigger = getEnt("gas_wall_5", "targetname");

  for(;;) {
    trigger waittill("trigger", player);

    if(isPlayer(player)) {
      break;
    }

    waitframe();
  }

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 0.5, 1.5);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_downstairs";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_downthestairs";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_movingdownstairs";
  _id_B92C8C5A6E883DFE = (-1570, -3782, -672);
  player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(_id_B92C8C5A6E883DFE, 115)[0];
  _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_F28ADB32E474B426(-685);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.2, 0.5, 3);
}

_id_63BF7ED87AFBA01C() {
  level endon("vo_breakout_wall_b_c4_used");
  _id_48B6BC4489FB51AE = (-4352, -3478, -700);
  _id_00971D8F1D2B1D1D = (-4513, -3307, -671);
  players = undefined;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_uphere";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_upstairsmove";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_upthestairs";

  for(;;) {
    players = scripts\cp\utility::getplayersinradius(_id_48B6BC4489FB51AE, 70);

    if(players.size > 0) {
      break;
    }

    waitframe();
  }

  if(isDefined(players)) {
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3, players);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.2, 0.5, 1.5);
  }

  childthread _id_48152601BC4434C2();
}

_id_48152601BC4434C2() {
  level endon("player_found_breach_wall");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_wheredowego";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_weneedawayoutofhere";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_wheresthebloodyexit";
  wait 5;
  player = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 0.5);
}

_id_01DFCF613436C08E() {
  _id_2F7C388C381DEC84 = (-4911.06, -3306.88, -609.81);
  _id_9052F95A5D97BEE9 = [];
  _id_9052F95A5D97BEE9[_id_9052F95A5D97BEE9.size] = "dx_cp_cpr2_trpe_fara_here";
  _id_9052F95A5D97BEE9[_id_9052F95A5D97BEE9.size] = "dx_cp_cpr2_trpe_pric_lookhere";
  _id_9052F95A5D97BEE9[_id_9052F95A5D97BEE9.size] = "dx_cp_cpr2_trpe_gazz_foundsomething";
  wait 0.5;
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_2F7C388C381DEC84, 0.9, 0.1, 0, undefined, 150)[0];
  childthread _id_86A3B865556AD074(_id_2F7C388C381DEC84);
  level notify("player_found_breach_wall");
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_9052F95A5D97BEE9, 0.1, 1, 2);
}

_id_86A3B865556AD074(origin) {
  level endon("vo_breakout_wall_b_c4_used");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_thegasismovingweshou";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_werewastingtimesetch";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_thegaswillbeonussoon";
  wait 7;
  player = _id_62E11D77B25C1D30::_id_215866EE17ECD840(origin, 3, 200);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_F345F7CE204CB664() {
  level waittill("breakout_wall_b_wall_blown");
  childthread _id_B578AC29023CC1E5();
  childthread _id_DB615D91BC299081();
  childthread _id_D0C5349514B9A59D();
  childthread _id_38211B1CB22FC54A();
}

_id_B578AC29023CC1E5() {
  _id_48B6BC4489FB51AE = (-5496.7, -3267.44, -561.35);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_movingupstairs";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_upstairsmove_01";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_morestairshere";

  for(;;) {
    players = scripts\cp\utility::getplayersinradius(_id_48B6BC4489FB51AE, 70);

    if(players.size > 0) {
      break;
    }

    waitframe();
  }

  if(isDefined(players)) {
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3, players);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.2, 1, 1.5);
  }
}

_id_DB615D91BC299081() {
  trigger = getEnt("gas_wall_15", "targetname");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_theresalockoutendoft";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_lockoutendothehall";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_pushtothelockoutendo";

  for(;;) {
    trigger waittill("trigger", player);

    if(isPlayer(player)) {
      break;
    }

    waitframe();
  }

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 1, 3);
}

_id_D0C5349514B9A59D() {
  _id_D072BCBB6E145D73 = (-5263, -133, -442);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_thiswayinhere";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_getinhere";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_inhere";

  for(;;) {
    players = scripts\cp\utility::getplayersinradius(_id_D072BCBB6E145D73, 130);

    if(players.size > 0) {
      break;
    }

    waitframe();
  }

  if(isDefined(players)) {
    _id_7D2852D02216C876 = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(3, players);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_7D2852D02216C876, aliases, 0.2, 1, 1.5);
  }
}

_id_38211B1CB22FC54A() {
  level endon("trap_escape_finished");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_shutthedoor";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_sealthedoor";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_closethedoor";
  level waittill("vo_all_players_in_airlock");
  childthread _id_C3CE7E730C64D4FC();
  player = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(4);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 1, 2);
}

_id_C3CE7E730C64D4FC() {
  level endon("vo_airlock_button_hit");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpe_fara_usethecontrolshurry";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_pric_hitthecontrols";
  aliases[aliases.size] = "dx_cp_cpr2_trpe_gazz_hitthosecontrolsmake";
  wait 6;
  player = _id_62E11D77B25C1D30::_id_AA8653DEA5520361(4);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 1, 2);
}

_id_B7B8F5E893163FAB() {
  _id_15CA06DD9E32849E = getEntArray("side_a", "targetname");
  return _id_59D28D68FCCAD596(_id_15CA06DD9E32849E);
}

_id_B7B8F6E8931641DE() {
  _id_81503EDD3735B37B = getEntArray("side_b", "targetname");
  return _id_59D28D68FCCAD596(_id_81503EDD3735B37B);
}

_id_CB93740616AEDC60(targets, dist, _id_94564218DD6125B9, _id_CBE3524D314A7BD3) {
  dist = squared(dist);
  _id_5DDB2B9E6961D6C8 = scripts\engine\utility::ter_op(istrue(_id_CBE3524D314A7BD3), ::distance2dsquared, ::distancesquared);

  if(!isarray(targets))
    targets = [targets];

  for(;;) {
    foreach(target in targets) {
      if(isent(target))
        target = target.origin;

      foreach(player in level.players) {
        if(!isalive(player)) {
          continue;
        }
        if(isDefined(_id_94564218DD6125B9) && scripts\engine\utility::array_contains(_id_94564218DD6125B9, player)) {
          continue;
        }
        if(call[[_id_5DDB2B9E6961D6C8]](player.origin, target) < dist)
          return [player, target];
      }
    }

    waitframe();
  }
}

_id_5506D2F58A2E4674(volume) {
  _id_414DDA4CABF358AF = getEnt("trap_room", "targetname");

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      triggering_ent = level.players[_id_AC0E594AC96AA3A8];

      if(triggering_ent istouching(volume) && triggering_ent scripts\cp\utility::is_valid_player(1))
        return level.players[_id_AC0E594AC96AA3A8];
    }

    waitframe();
  }

  return undefined;
}

_id_59D28D68FCCAD596(_id_9CB3AB5121831D50) {
  players_inside = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_9CB3AB5121831D50.size; _id_AC0E5C4AC96AAA41++) {
      if(level.players[_id_AC0E594AC96AA3A8] istouching(_id_9CB3AB5121831D50[_id_AC0E5C4AC96AAA41]))
        players_inside[players_inside.size] = level.players[_id_AC0E594AC96AA3A8];
    }
  }

  return players_inside;
}

_id_6D9F25F0B3035358(height) {
  _id_816E0C54EDDC2D69 = [];

  foreach(player in level.players) {
    if(player.origin[2] > height)
      _id_816E0C54EDDC2D69[_id_816E0C54EDDC2D69.size] = player;
  }

  return _id_816E0C54EDDC2D69;
}

_id_93C58B66A9BD16C8(height) {
  _id_816E0C54EDDC2D69 = [];

  foreach(player in level.players) {
    if(player.origin[2] < height)
      _id_816E0C54EDDC2D69[_id_816E0C54EDDC2D69.size] = player;
  }

  return _id_816E0C54EDDC2D69;
}

_id_EC1CC650C938E97B() {
  _id_048CFB7B4E077D43 = [];

  foreach(player in level.players) {
    if(isDefined(player.attackers)) {
      if(player.attackers.size > 0)
        _id_048CFB7B4E077D43[_id_048CFB7B4E077D43.size] = player;
    }
  }

  return _id_048CFB7B4E077D43;
}

_id_D5A69A0C4A3B110E(player) {
  height = level.player.origin[2];
  _id_4F86D519AF62EEB6 = [];
  players = scripts\engine\utility::array_remove(level.players, player);

  foreach(player in players) {
    if(player.origin[2] - height <= 50 && player.origin[2] - height >= -50)
      _id_4F86D519AF62EEB6[_id_4F86D519AF62EEB6.size] = player;
  }

  return _id_4F86D519AF62EEB6;
}

_id_F4EDC3A26FB79A3D() {
  _id_414DDA4CABF358AF = getEnt("trap_room", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    triggering_ent = level.players[_id_AC0E594AC96AA3A8];

    if(triggering_ent istouching(_id_414DDA4CABF358AF) && triggering_ent scripts\cp\utility::is_valid_player(1))
      return level.players[_id_AC0E594AC96AA3A8];
  }

  return undefined;
}

_id_A4D4C568A046A7CF() {
  _id_414DDA4CABF358AF = getEnt("trap_room", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    triggering_ent = level.players[_id_AC0E594AC96AA3A8];

    if(triggering_ent istouching(_id_414DDA4CABF358AF) && triggering_ent scripts\cp\utility::is_valid_player(1) && triggering_ent == self)
      return 1;
  }

  return 0;
}

_id_A026A046480475C5() {
  players = level.players;
  _id_414DDA4CABF358AF = getEnt("trap_room", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    triggering_ent = level.players[_id_AC0E594AC96AA3A8];

    if(triggering_ent istouching(_id_414DDA4CABF358AF) && triggering_ent scripts\cp\utility::is_valid_player(1))
      players = scripts\engine\utility::array_remove(players, level.players[_id_AC0E594AC96AA3A8]);
  }

  return players;
}

_id_B2FECE5BC9F898C2() {
  self endon("death_or_disconnect");
  level endon("vo_loadout_taken");
  _id_94C9FB0BC9232353 = self getweaponslistprimaries();
  self waittill("ammo_update");
  _id_1523BE422E863FFE = _id_78542EE6CB1C63DD(_id_94C9FB0BC9232353);
  _id_E0DD667F1DCB93E4 = getEnt("loadout_drop", "targetname");

  if(_id_1523BE422E863FFE.size > 1) {
    if(isDefined(_id_E0DD667F1DCB93E4)) {
      if(distance(self.origin, _id_E0DD667F1DCB93E4.origin) < 100)
        _id_C5E868F158E0DD63();
    }
  }
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

_id_7C2C3F38A2D5E8D1(targets, aliases, dot, distance, holdtime) {
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(targets, dot, holdtime, 0, undefined, distance)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_F5E227327AC5A2B4() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpp_fara_tripwiredisabled";
  aliases[aliases.size] = "dx_cp_cpr2_trpp_fara_trapdisarmed";
  _id_32887CF9D13FE7E5 = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpp_pric_disabledatripwire";
  aliases[aliases.size] = "dx_cp_cpr2_trpp_pric_disarmed";
  _id_1B7B7DE0179F242E = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr2_trpp_gazz_disarmedatripwire";
  aliases[aliases.size] = "dx_cp_cpr2_trpp_gazz_tripwiresdisabled";
  _id_8B2FA2DFAF24943B = scripts\engine\utility::create_deck(aliases);
  _id_B5EAD3504508D53B = [_id_32887CF9D13FE7E5, _id_1B7B7DE0179F242E, _id_8B2FA2DFAF24943B];
  self waittill("trigger", player);

  if(!isDefined(level._id_DD92512A6FAAED6F))
    level._id_DD92512A6FAAED6F = 0;

  if(gettime() - level._id_DD92512A6FAAED6F > 10000) {
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_B5EAD3504508D53B, 0.2, 1, 0.5);
    level._id_DD92512A6FAAED6F = gettime();
  }
}

_id_51D741D1F501856F(origin, alias, delay) {
  wait(delay);
  playsoundatpos(origin, alias);
}

_id_6817A33C556E64EB() {
  _id_59D0580C01332155 = (-1247.09, 1116.93, -560);
  _id_64D441010374CB5E = (-1670.6, 243.38, -561.85);
  _id_B8DE34BACCE96F81 = _id_A026A046480475C5();
  player = undefined;
  _id_F9655F855D43AE28 = undefined;
  player = _id_62E11D77B25C1D30::_id_43D8FA96ACF30CA8(_id_59D0580C01332155, 3, _id_B8DE34BACCE96F81);

  if(_id_B7B8F6E8931641DE().size > 0)
    _id_F9655F855D43AE28 = _id_62E11D77B25C1D30::_id_43D8FA96ACF30CA8(_id_64D441010374CB5E, 4, _id_B8DE34BACCE96F81);

  if(isDefined(_id_F9655F855D43AE28)) {
    if(isDefined(player)) {
      if(distance(_id_F9655F855D43AE28.origin, _id_64D441010374CB5E) < distance(player.origin, _id_59D0580C01332155))
        player = _id_F9655F855D43AE28;
    }
  }

  return player;
}

_id_90A64D8392654454(distance) {
  _id_D0B10636A086893D = (-1247.09, 1116.93, -560);
  _id_72D192F79875DBE2 = (-164.35, 851.24, -558.75);
  _id_AA3F7C3CEA1ADC81 = (821.03, 589.38, -545.5);
  _id_A11E4B63D6F30E8A = scripts\engine\utility::getclosest(_id_D0B10636A086893D, level.players, distance);
  _id_AD655763DF22166A = scripts\engine\utility::getclosest(_id_72D192F79875DBE2, level.players, distance);
  _id_EB3D2A9483EC7A76 = scripts\engine\utility::getclosest(_id_AA3F7C3CEA1ADC81, level.players, distance);

  if(isDefined(_id_A11E4B63D6F30E8A) || isDefined(_id_AD655763DF22166A) || isDefined(_id_EB3D2A9483EC7A76))
    return 1;

  return 0;
}