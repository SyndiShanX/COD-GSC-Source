/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_55b8229c19c258d.gsc
***********************************************/

_id_7B6E96193E81C072() {
  level endon("game_ended");
  level endon("endofscripting");
  wait 6;
  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");
  thread _id_62E11D77B25C1D30::_id_5175593A7A2CCDB5();
  thread _id_62E11D77B25C1D30::_id_FC711A4308F52F72();
  level._id_D017B9C13EC2BB69 = 1;
  level._id_93617D996E732D98 = ::_id_F5E227327AC5A2B4;
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();
  checkpoint = scripts\engine\utility::ter_op(checkpoint != "", checkpoint, getDvar("start"));

  switch (scripts\engine\utility::_id_53C4C53197386572(checkpoint, "captured")) {
    case "checkpoint_captured_blind":
    case "captured":
    case "":
      _id_BEF9F8336C9B269D();
    case "checkpoint_rescue_warehouse":
    case "escape_warehouse":
      _id_BF1CFA736357E037();
    case "checkpoint_stealth_section":
    case "stealth_section":
      _id_4CC5919CF7844F35();
    case "checkpoint_mine_section":
    case "mine_section":
      _id_1F9F4A512EF692B7();
    case "mine_section_laser_2":
      _id_07CDA0F84A658E63();
    case "mine_section_laser_3":
      _id_07CD9FF84A658C30();
    case "checkpoint_mine_postlasers":
    case "mine_section_postlasers":
      _id_4E30F16753F98B71();
    case "checkpoint_jugg_maze_section_postcard":
    case "checkpoint_jugg_maze":
    case "jugg_maze_postkeycard":
    case "jugg_maze":
      _id_68BDB72143BB5407();
    case "checkpoint_jugg_maze_section_postvent":
    case "start_airlock_door":
      _id_90281633FA46082E();
    case "checkpoint_elevator_section":
    case "checkpoint_elevator_section_downstairs":
    case "start_elevator":
      _id_3E3FED2767E87BC3();
    case "checkpoint_elevator_defend_start":
    case "elevator_defend":
      _id_ECB013AB73031ECD();
    default:
      return;
  }
}

_id_82E02994003CFFF7(player) {
  player._id_EEF929505A9B77B9 = scripts\engine\utility::_id_53C4C53197386572(player._id_EEF929505A9B77B9, 0);
  player._id_AED624967395163B = _id_62E11D77B25C1D30::_id_B8AE7D3FFA2CE9D8;
}

_id_F5E227327AC5A2B4() {}

_id_1280E19E4CE21681() {
  while(!isDefined(level._id_652C062C6B740024))
    waitframe();

  level._id_652C062C6B740024 endon("death");

  for(;;) {
    level._id_652C062C6B740024 waittill("goal_changed");
    scripts\engine\utility::flag_clear("vo_guardMovingToPrice");
    scripts\engine\utility::flag_clear("vo_guardMovingToAlex");

    if(level._id_652C062C6B740024.goalpos == level._id_C0E5BB83FE3A79E5.origin) {
      scripts\engine\utility::flag_set("vo_guardMovingToPrice");
      continue;
    }

    if(level._id_652C062C6B740024.goalpos == level._id_D6BA25E54AFE7E5E.origin)
      scripts\engine\utility::flag_set("vo_guardMovingToAlex");
  }
}

_id_CDD46DEA6B8B5C7E() {
  scripts\engine\utility::flag_wait("vo_combat");
  guy = level._id_949A50E725B56274;
  aliases = ["dx_cp_cpr4_cptr_aqs2_theprisonersescaping", "dx_cp_cpr4_cptr_aqs1_shesescaping", "dx_cp_cpr4_cptr_aqs1_you"];
  guy thread _id_5D265B4FCA61F070::say(scripts\engine\utility::random(aliases));
  scripts\cp\utility::battlechatter_on();
}

_id_AAA7C056D54B8461(_id_14BE97A8AB21AF04) {
  self endon("entitydeleted");
  _id_14BE97A8AB21AF04 = scripts\engine\utility::_id_53C4C53197386572(_id_14BE97A8AB21AF04, "animscripted");
  end = undefined;

  for(;;) {
    self waittill(_id_14BE97A8AB21AF04, notetracks);

    foreach(_id_A234A65C378F3289 in notetracks) {
      if(isstartstr(_id_A234A65C378F3289, "say_")) {
        alias = getsubstr(_id_A234A65C378F3289, 4);
        _id_93FA9B11F85EC1A9 = self;

        foreach(player in level.players) {
          if(!isDefined(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
            continue;
          }
          context = scripts\engine\utility::ter_op(!scripts\engine\utility::_id_5B7E9A4C946F3A13(player, [level.price, level.alex]), "dx_open_air", "dx_radio_2d");
          _id_93FA9B11F85EC1A9 _meth_480DEAF73792CCF1(alias, "dx_type", context, player);
        }
      }

      if(_id_A234A65C378F3289 == "end")
        end = 1;
    }

    if(isDefined(end)) {
      break;
    }
  }
}

_id_BEF9F8336C9B269D() {
  _id_62E11D77B25C1D30::_id_7C50C629B4D4086A(1, "captured");
  scripts\cp\utility::battlechatter_off();
  thread _id_CDD46DEA6B8B5C7E();

  while(!isDefined(level.farah))
    waitframe();

  level.farah endon("death");
  childthread _id_1280E19E4CE21681();
  childthread _id_FB550F8B47C4B8DE();
  childthread _id_CD027CA38C4C04EA();
  childthread _id_1ECE879D63421810();
  childthread _id_A4DF1CEFDCD02D2A();
  childthread _id_02E68E40B0A327AF();
  childthread _id_025A086FDDD4605C();
  childthread _id_6138245E6E519149();
  childthread _id_489F2ACE251201BC();
  childthread _id_F20B82F8CF98B5F2();
  childthread _id_6FE60E3149A71AEC();
  level thread _id_3C3D19FB95EB5AC0();

  if(istrue(game["enable_farah_chair_animation"]))
    level waittill("intro_animation_completed");

  _id_D51122270DD5F5B5();
  level waittill("captured_completed");
  _id_62E11D77B25C1D30::_id_7C50C629B4D4086A(0, "captured");
}

_id_D51122270DD5F5B5() {
  if(scripts\engine\utility::flag("vo_captured_priceAlexSpotFarah")) {
    return;
  }
  level endon("vo_captured_priceAlexSpotFarah");
  wait 5;
  scripts\engine\utility::flag_set("vo_captured_farahAskedLocation");

  if(istrue(game["enable_farah_chair_animation"]))
    childthread _id_986DFB19F2FAA93D();

  _id_55E33B16EE9EDF88();
}

_id_986DFB19F2FAA93D() {
  aliases = scripts\engine\utility::create_deck(["dx_cp_cpr4_cptr_fara_alexcaptainpricewher", "dx_cp_cpr4_cptr_fara_ineedthisblindfoldof", "dx_cp_cpr4_cptr_fara_alexcaptainpricearey"]);
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(0, 15, 3);

  for(;;) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, aliases scripts\engine\utility::deck_draw(), 0.4);
  }
}

_id_55E33B16EE9EDF88() {
  foreach(player in level.players) {
    if(isDefined(player._id_74CD7962F11BE6A8))
      return;
  }

  level endon("vo_spot_cctv_camera");
  thread _id_23164A0929C67F75();
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_cptr_pric_wellhavetofigureaway", "dx_cp_cpr4_cptr_pric_nothingtoworkwithinh", "dx_cp_cpr4_cptr_pric_ivegotfuckallinhere"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_cptr_alex_igotnothinusefulinhe", "dx_cp_cpr4_cptr_alex_notseeinanythinginhe", "dx_cp_cpr4_cptr_alex_weregonnaneedtofinda"]);
  aliases = [undefined, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(5, 15, 3);

  foreach(player in level.players) {
    if(scripts\engine\utility::is_equal(player, level.farah)) {
      continue;
    }
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 0, 0);
  }
}

_id_23164A0929C67F75() {
  _id_6CAA9E3B828DBEED = [scripts\engine\utility::getStruct("cctv_interact_1", "targetname"), scripts\engine\utility::getStruct("cctv_interact_7", "targetname")];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_6CAA9E3B828DBEED, 0.985, 0.2, 0, [], 512, undefined, undefined, undefined, 1)[0];
  level notify("vo_spot_cctv_camera");
  aliases = [undefined, "dx_cp_cpr4_cptr_pric_alexeyesup", "dx_cp_cpr4_cptr_alex_captaincamerasinthec"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);

  if(scripts\engine\utility::is_equal(player, level.price))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_cptr_pric_closedcircuitsintheh", 0.1);

  aliases = [undefined, "dx_cp_cpr4_cptr_pric_iseeem", "dx_cp_cpr4_cptr_alex_gotem"];
  result = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_6CAA9E3B828DBEED, 0.95, 0.2, 0, [player], 512, undefined, 2, undefined, 1);

  if(!isDefined(result)) {
    return;
  }
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(result[0], aliases, 0.2);
}

_id_CD027CA38C4C04EA() {
  if(istrue(game["enable_farah_chair_animation"]))
    level waittill("chair_break_go_ahead", player);

  player = _id_96DB5EC08272F1FD();
  scripts\engine\utility::flag_set("vo_captured_priceAlexSpotFarah");
  aliases = [undefined, "dx_cp_cpr4_cptr_pric_gotavisualonyoufarah", "dx_cp_cpr4_cptr_alex_goteyesonyoufarahhad"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);

  if(istrue(game["enable_farah_chair_animation"])) {
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_cptr_fara_weneedtostophimwhere", 0.2);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_cptr_pric_aqsgotuslockedupweca", 0.4, 1, 0.3);
    scripts\engine\utility::flag_wait("break_out_of_chair");
  }

  if(!scripts\engine\utility::flag("vo_captured_farahReachLaser")) {
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_cptr_fara_bemyeyesguidemetoyou", 0.3);
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_cptr_pric_wevegotyoursix", 0.7);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_cptr_alex_andyourtwelve", 0.2);
  }

  thread _id_52F540B660A3199B();
  thread _id_EB8B8024BF54985B();
}

_id_52F540B660A3199B() {
  level endon("farah_nearby");
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_cptr_alex_farahyourecleartomov", "dx_cp_cpr4_cptr_alex_youreclear", "dx_cp_cpr4_cptr_alex_wegotyoukeepmovin", "dx_cp_cpr4_cptr_alex_yougottamove"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_cptr_pric_clearfarahmovenow", "dx_cp_cpr4_cptr_pric_youcandothisfarah", "dx_cp_cpr4_cptr_pric_yougottamovefarah", "dx_cp_cpr4_cptr_pric_clockstickinletsmove", "dx_cp_cpr4_cptr_pric_wegottamoveifweregon"]);
  aliases = [undefined, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(6, 30, 4);

  for(;;) {
    if(!isalive(level.farah)) {} else {
      _id_41701EF07A1F9FE8 = [];

      foreach(player in scripts\engine\utility::array_remove(level.players, level.farah)) {
        if(_id_140CB15B91F5B28C(player))
          _id_41701EF07A1F9FE8[_id_41701EF07A1F9FE8.size] = player;
      }

      if(_id_41701EF07A1F9FE8.size > 0)
        _id_7FC57783D8969A86(scripts\engine\utility::random(_id_41701EF07A1F9FE8), aliases, delay);
    }

    waitframe();
  }
}

_id_7FC57783D8969A86(player, aliases, delay) {
  level endon("farah_nearby");
  level.farah endon("death_or_disconnect");
  player endon("death_or_disconnect");
  level endon("vo_captured_farah_moved");
  player endon("vo_captured_stopped_looking_at_farah");
  childthread _id_9183BD0F77B18982();
  childthread _id_97CC1B27EC98267E(player);
  _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
  level notify("vo_captured_killWaitNagFarahToMoveThreads");
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 0, 0);
}

_id_9183BD0F77B18982() {
  level endon("vo_captured_killWaitNagFarahToMoveThreads");
  _id_F16655E1462A3DD2 = level.farah.origin;

  for(;;) {
    if(distancesquared(level.farah.origin, _id_F16655E1462A3DD2) > 100)
      level notify("vo_captured_farah_moved");

    waitframe();
  }
}

_id_97CC1B27EC98267E(player) {
  level endon("vo_captured_killWaitNagFarahToMoveThreads");

  for(;;) {
    if(!_id_140CB15B91F5B28C(player))
      player notify("vo_captured_stopped_looking_at_farah");

    waitframe();
  }
}

_id_EB8B8024BF54985B() {
  level endon("farah_nearby");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr4_cptr_fara_icantseepointmeinthe";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_fara_whatsmynextmove";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_fara_whichway";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_fara_whereto";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_fara_ineedthisblindfoldof";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_fara_alexcaptainpricearey";
  aliases = scripts\engine\utility::create_deck(aliases);
  _id_9845EF6505DA40FB = 0;
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(3, 20, 6);

  for(;;) {
    if(!isalive(level.farah)) {} else {
      _id_41701EF07A1F9FE8 = [];

      foreach(player in scripts\engine\utility::array_remove(level.players, level.farah)) {
        if(_id_0AF1C819AFF3C09B(player))
          _id_41701EF07A1F9FE8[_id_41701EF07A1F9FE8.size] = player;
      }

      if(_id_41701EF07A1F9FE8.size == 0)
        _id_9845EF6505DA40FB = _id_9845EF6505DA40FB + 0.05;

      if(_id_9845EF6505DA40FB > delay.current) {
        delay.current = min(delay.current + delay._id_2F977E27FA739602, delay.maximum);
        _id_9845EF6505DA40FB = 0;
        _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, aliases, 0.2, 0, 0);
      }
    }

    waitframe();
  }
}

_id_96DB5EC08272F1FD(timeout, dot) {
  timer = 0;

  while(!isDefined(timeout) || timer < timeout) {
    timer = timer + 0.05;

    if(!isDefined(level.farah)) {} else {
      players = scripts\engine\utility::array_randomize(level.players);

      foreach(player in scripts\engine\utility::array_remove(players, level.farah)) {
        if(_id_140CB15B91F5B28C(player, dot))
          return player;
      }
    }

    waitframe();
  }
}

_id_0AF1C819AFF3C09B(player) {
  return isDefined(player) && istrue(player._id_D5AF94588739718C);
}

_id_140CB15B91F5B28C(player, dot) {
  if(!isDefined(player) || !istrue(player._id_D5AF94588739718C) || !isDefined(player._id_74CD7962F11BE6A8))
    return 0;

  dot = scripts\engine\utility::_id_53C4C53197386572(dot, 0.5);

  if(!isDefined(level.farah))
    return 0;

  start = level.farah.origin + (0, 0, 30);
  end = player._id_74CD7962F11BE6A8.origin;
  angles = vectortoangles(start - end);
  forward = anglesToForward(angles);
  _id_DEE6508B0BA437C5 = player._id_74CD7962F11BE6A8.angles;
  _id_70222FBC47330166 = anglesToForward(_id_DEE6508B0BA437C5);
  _id_334AF980E8C1A3AD = vectordot(forward, _id_70222FBC47330166);

  if(_id_334AF980E8C1A3AD < dot)
    return 0;

  return scripts\engine\trace::ray_trace_passed(start, end, level.farah, scripts\engine\trace::create_default_contents(1));
}

_id_FB550F8B47C4B8DE() {
  level endon("farah_nearby");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr4_cptr_fara_damnit";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_fara_frustratedgrunt";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_fara_alexcaptainbemyeyes";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_fara_imblockedguidemeifyo";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_fara_ineedeyes";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_fara_icantgetpasthere";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_fara_somethingsblockingme";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_fara_imstucktellmewhereto";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_fara_howdoigetpastthis";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_fara_imstuck";
  aliases = scripts\engine\utility::create_deck(aliases);
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(5, 16, 7);

  for(;;) {
    while(!istrue(level._id_CD9009B5B205C31A) && !istrue(level._id_67A8432ADEB6435A) && !istrue(level._id_2CD172FC4DA5275C) && !istrue(level._id_DDEC7DE8B1ED91DF) && !istrue(level.blocked))
      waitframe();

    if(_id_0AF1C819AFF3C09B(level.price) || _id_0AF1C819AFF3C09B(level.alex)) {} else {
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, aliases, 0.5, 0, 0);
      _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);

      while(istrue(level._id_CD9009B5B205C31A) || istrue(level._id_67A8432ADEB6435A) || istrue(level._id_2CD172FC4DA5275C) || istrue(level._id_DDEC7DE8B1ED91DF) || istrue(level.blocked))
        waitframe();
    }

    waitframe();
  }
}

_id_1ECE879D63421810() {
  level endon("vo_captured_farahThroughDoorway");

  for(player = _id_96DB5EC08272F1FD(); !isalive(level.farah) || level.farah.origin[0] < 10450; player = _id_96DB5EC08272F1FD())
    waitframe();

  scripts\engine\utility::flag_set("vo_captured_farahReachLaser");
  aliases = [undefined, "dx_cp_cpr4_cptr_pric_aqsgotalaserguarding", "dx_cp_cpr4_cptr_alex_aqsgotalaserguarding"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_cptr_fara_hadirwasalwaysobsess", 0);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_cptr_alex_hesgotanotherthingco", 0);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_cptr_pric_letsfocusonthetaskat", 0);
  aliases = [undefined, "dx_cp_cpr4_cptr_pric_theresacratethereloo", "dx_cp_cpr4_cptr_alex_lookslikethelaserdoe"];
  aliases = [undefined, "dx_cp_cpr4_cptr_pric_goodcall", "dx_cp_cpr4_cptr_alex_goodcatch"];
}

_id_A4DF1CEFDCD02D2A() {
  level endon("captured_lurker");

  for(player = _id_96DB5EC08272F1FD(); !isalive(level.farah) || level.farah.origin[0] < 10900; player = _id_96DB5EC08272F1FD())
    waitframe();

  scripts\engine\utility::flag_set("vo_captured_farahThroughDoorway");
  aliases = [undefined, "dx_cp_cpr4_cptr_pric_youmadeitfarah", "dx_cp_cpr4_cptr_alex_niceyoureclear"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  aliases = [undefined, "dx_cp_cpr4_cptr_pric_theresastaircaseahea", "dx_cp_cpr4_cptr_alex_gotstairsaheadyoureg"];
  player = _id_96DB5EC08272F1FD();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_02E68E40B0A327AF() {
  scripts\engine\utility::flag_wait("farah_fell");
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_cptr_fara_shit", 0, 1, 0);
  wait 0.3;
  aliases = [undefined, "dx_cp_cpr4_cptr_pric_farah_01", "dx_cp_cpr4_cptr_alex_farah"];
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(level.farah);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0, 1, 0);
}

_id_6138245E6E519149() {
  level notify("vo_captured_farahMakeJump");

  for(player = _id_96DB5EC08272F1FD(); !isalive(level.farah) || !level.farah _id_62E11D77B25C1D30::_id_1D8DC0F6BBB423BA((10990.3, 17248.4, -3603.11), (10990.3, 17248.4, -3603.11)); player = _id_96DB5EC08272F1FD())
    waitframe();

  aliases = ["dx_cp_cpr4_cptr_pric_nextsetofstepsaretot", "dx_cp_cpr4_cptr_alex_nextflightstotheleft"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_489F2ACE251201BC() {
  trigger = getEnt("farah_nearby", "targetname");
  trigger endon("death");

  while(!level.farah istouching(trigger) || !level.farah isonground())
    waitframe();

  level notify("vo_captured_farahMakeJump");

  if(_id_140CB15B91F5B28C(level.price)) {
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_cptr_pric_goodjump", 0.3);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_cptr_alex_airkarim", 0.4);
  } else if(_id_140CB15B91F5B28C(level.alex)) {
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_cptr_alex_nicejump", 0.3);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_cptr_pric_neverdoubtedyou", 0.4);
  }

  childthread _id_325E2F41B7F37A17();
  childthread _id_186E00EBAADC4B4C();
}

_id_025A086FDDD4605C() {
  level waittill("captured_lurker");
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_cptr_fara_iheardadoor", [gettime() + 2200]);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_cptr_fara_someonescoming", 0.4);
}

_id_325E2F41B7F37A17() {
  level endon("vo_combat");
  level endon("vo_guardDistracted");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr4_cptr_pric_gotaguardincomingale";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_pric_alexneedyoutodistrac";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_pric_alexcanyougetridofth";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_pric_alexcanyoudistractth";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_pric_alexcanyoupullthisgu";
  aliases = scripts\engine\utility::create_deck(aliases);

  for(;;) {
    scripts\engine\utility::flag_waitopen("vo_guardMovingToPrice");
    scripts\engine\utility::flag_wait("vo_guardMovingToPrice");
    wait 2;
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, aliases, 0.3, 0, 0.5);
  }
}

_id_186E00EBAADC4B4C() {
  if(scripts\engine\utility::flag("vo_captured_reachedPrice")) {
    return;
  }
  level endon("vo_captured_reachedPrice");
  scripts\engine\utility::flag_wait("vo_guardDistracted");
  wait 2;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_cptr_pric_clearfarahmovetome", 0.2);
  wait 3;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_cptr_pric_farahmovenow", 0.3);
}

_id_F20B82F8CF98B5F2() {
  distsq = squared(250);

  while(!isalive(level.price) || !isalive(level.farah) || distancesquared(level.price.origin, level.farah.origin) > distsq)
    waitframe();

  scripts\engine\utility::flag_set("vo_captured_reachedPrice");
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_cptr_pric_goodillgetyourhandsf", 0.2);
}

_id_6FE60E3149A71AEC() {
  level waittill("removedFarahBindings", player);
  aliases = [undefined, "dx_cp_cpr4_cptr_pric_gotya", "dx_cp_cpr4_cptr_alex_youregood"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.6);
  childthread _id_E085C3506E0AD4D3();
  childthread _id_53B2C75E2619AF38();
  _id_EB1AE4DBD2F7F949();
}

_id_3C3D19FB95EB5AC0() {
  level endon("game_ended");
  level endon("captured_completed");
  marker = scripts\engine\utility::getStruct("vo_captured_ee_code", "script_noteworthy");
  _id_1A053B84F208B832 = scripts\engine\utility::getStruct("vo_captured_ee_code_origin", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(marker.origin, 64)[0];
  _id_E029643DC0658709 = "dx_cp_cpr4_cptr_aqs2_thecodecombinationis";
  aliases = [];
  aliases[0] = "";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_aqs2_1";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_aqs2_2";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_aqs2_3";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_aqs2_4";
  aliases[aliases.size] = "dx_cp_cpr4_cptr_aqs2_5";

  if(!isDefined(game["easter_egg_code"])) {
    return;
  }
  _id_D6ABCB75E41F1152(_id_1A053B84F208B832.origin, _id_E029643DC0658709);
  wait 0.6;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    _id_D6ABCB75E41F1152(_id_1A053B84F208B832.origin, aliases[game["easter_egg_code"][_id_AC0E594AC96AA3A8]]);
    wait 0.6;
  }
}

_id_EB1AE4DBD2F7F949() {
  level endon("vo_strict_combat");
  aliases = ["dx_cp_cpr4_cptr_pric_guardsacrossthehallm", "dx_cp_cpr4_cptr_pric_acrossthehallfarahgo", "dx_cp_cpr4_cptr_pric_gottagonowfarah", "dx_cp_cpr4_cptr_pric_notimetowastetakethe"];
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(0, 10, 4);

  foreach(alias in aliases) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, alias, 0.3);
  }
}

_id_E085C3506E0AD4D3() {
  level notify("single_vo_captured_killGuardCombat");
  level endon("single_vo_captured_killGuardCombat");

  if(!isDefined(level._id_652C062C6B740024) || !isalive(level._id_3485A4EFD0CCA09C)) {
    return;
  }
  level._id_652C062C6B740024 endon("death");
  wait 1;
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_cptr_alex_theresaknifeonthetab", 0.4);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_cptr_pric_nowfarah", 0.3);
  wait 0.5;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_cptr_pric_takehimout", 0.2);
}

_id_53B2C75E2619AF38() {
  level._id_652C062C6B740024 waittill("death");
  scripts\engine\utility::flag_waitopen("vo_combat");
  wait 2;

  while(scripts\engine\utility::flag("vo_combat")) {
    scripts\engine\utility::flag_waitopen("vo_combat");
    wait 2;
  }

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_cptr_alex_thatguywastheworst", 0.2);
  wait 2;

  if(!scripts\engine\utility::flag("vo_combat")) {
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_cptr_alex_goodtoseeyoucommande", 0.3);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_cptr_fara_likewise", 0.4);
  }

  _id_85C65D6B03062A0B();
}

_id_85C65D6B03062A0B() {
  if(scripts\engine\utility::flag("captured_cell_doors_button_pressed")) {
    return;
  }
  level endon("captured_cell_doors_button_pressed");
  aliases = ["dx_cp_cpr4_cptr_pric_thebuttononthewallun", "dx_cp_cpr4_cptr_pric_onthewalltheredbutto", "dx_cp_cpr4_cptr_pric_redbuttoncantmissit", "dx_cp_cpr4_cptr_pric_alrighttimetogetusou"];
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(0, 15, 4);
  _id_C028A97C3EC05859 = 0;

  foreach(alias in aliases) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);

    if(scripts\engine\utility::flag("vo_combat")) {
      if(_id_C028A97C3EC05859 == 0)
        _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_cptr_pric_hitthebuttongetusout", 0.2);
      else if(_id_C028A97C3EC05859 == 1)
        _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_cptr_alex_youcantfightthemalon", 0.2);
      else
        continue;

      _id_C028A97C3EC05859++;
    }

    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, alias, 0.2);
  }
}

_id_BF1CFA736357E037() {
  childthread _id_1EDD80ADC3C93BF4();
  childthread _id_D0FB9B88C55FDE31();
  childthread _id_3A322D10A4B63EE9();
  childthread _id_05C70E8827622861("seq_captured_exit_door");
  level waittill("seq_captured_exit_door_door_open");
}

_id_1EDD80ADC3C93BF4() {
  wait 1;
  _id_62E11D77B25C1D30::_id_1D977083C90B0996((11404.2, 17317.6, -3548.51), (12214.4, 17647.3, -3393.55));
  wait 1;

  if(!scripts\engine\utility::flag("captured_cell_doors_button_pressed")) {
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_cptr_pric_fuckinhellfarahgladi", 0.4);

    if(!scripts\engine\utility::flag("captured_cell_doors_button_pressed"))
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_cptr_alex_nicemaybeletusoutnow", 0.6);
  }

  scripts\engine\utility::flag_wait("captured_cell_doors_opened");
  wait 1;
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_cptr_fara_weneedtogetbackdowns", 0.3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_cptr_alex_letsgearupwellhaveco", 0.4);
  scripts\engine\utility::flag_set("vo_captured_startGearUp");
}

_id_D0FB9B88C55FDE31() {
  aliases = ["dx_cp_cpr4_cptr_fara_gotagun", "dx_cp_cpr4_cptr_pric_securedaweapon", "dx_cp_cpr4_cptr_alex_gotsomefirepower"];
  players = level.players;

  while(players.size > 0) {
    result = _id_0EDCF07839930CA2("pickedupweapon", players);

    if(result[2] == "iw9_me_knife_mp+iw9_me_knife") {
      continue;
    }
    players = scripts\engine\utility::array_remove(players, result[0]);

    if(!scripts\engine\utility::flag("vo_captured_startGearUp")) {
      continue;
    }
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(result[0], aliases, 0.4);
  }
}

_id_3A322D10A4B63EE9() {
  aliases = ["dx_cp_cpr4_cptr_fara_letsrainfirefromtheh", "dx_cp_cpr4_cptr_pric_wecanpickemoffuphere", "dx_cp_cpr4_cptr_alex_wellgetclearshotsfro"];

  for(;;) {
    result = _id_0EDCF07839930CA2("weapon_fired");
    player = result[0];

    if(player _id_62E11D77B25C1D30::_id_1D8DC0F6BBB423BA((11018.6, 17690.1, -3385.77), (10900.9, 17426.5, -3577.42)) && player.angles[1] < 245 && player.angles[1] > 115) {
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
      return;
    }
  }
}

_id_F2D04A72F825CEE4(_id_24A4E29034CF3EBC) {
  if(!isDefined(level._id_9B661E6037455194)) {
    level._id_446EC2FB463DEEB1 = [];
    _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_cptr_pric_gottamovefarah", "dx_cp_cpr4_cptr_pric_withusfarah", "dx_cp_cpr4_cptr_pric_letsgofarah"]);
    _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_cptr_alex_letsmovefarah", "dx_cp_cpr4_cptr_alex_needyouherefarah", "dx_cp_cpr4_cptr_alex_comeonfarah"]);
    level._id_446EC2FB463DEEB1["farah"] = [undefined, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
    _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_cptr_fara_captainpriceweneedyo", "dx_cp_cpr4_cptr_fara_captainweneedyouhere", "dx_cp_cpr4_cptr_fara_captain"]);
    _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_cptr_alex_weneedyouheresir", "dx_cp_cpr4_cptr_alex_letsmovecaptain", "dx_cp_cpr4_cptr_alex_needyouwithuscaptain"]);
    level._id_446EC2FB463DEEB1["price"] = [_id_EC44C06676021F69, undefined, _id_A739AB0E1D996CF3];
    _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_cptr_fara_alexletsgo", "dx_cp_cpr4_cptr_fara_keepupecho", "dx_cp_cpr4_cptr_fara_timetomovealex"]);
    _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_cptr_pric_alextimetomovemate", "dx_cp_cpr4_cptr_pric_needyouwithusalex", "dx_cp_cpr4_cptr_pric_withusalex"]);
    level._id_446EC2FB463DEEB1["alex"] = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352];
    _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_fara_atthedoorletsgo", "dx_cp_cpr4_scpw_fara_hurryletsgetthrought", "dx_cp_cpr4_scpw_fara_thisway"]);
    _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_pric_readyatthedoor", "dx_cp_cpr4_scpw_pric_moveonthedoor", "dx_cp_cpr4_scpw_pric_doorshere"]);
    _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_alex_imatthedoor", "dx_cp_cpr4_scpw_alex_letsmoveonthedoor", "dx_cp_cpr4_mnsc_alex_doorshere"]);
    level._id_9B661E6037455194 = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  }

  if(_id_24A4E29034CF3EBC.size == 1) {
    _id_284CE6FECADF83D7 = _id_24A4E29034CF3EBC[0];
    return level._id_446EC2FB463DEEB1[_id_284CE6FECADF83D7._id_938E8B2CA6549759];
  }

  return level._id_9B661E6037455194;
}

_id_05C70E8827622861(_id_6EC5749C5CE7657E, _id_20510600314FE827) {
  _id_20510600314FE827 = scripts\engine\utility::_id_53C4C53197386572(_id_20510600314FE827, scripts\engine\utility::getStruct(_id_6EC5749C5CE7657E, "script_noteworthy").origin);
  level endon(_id_6EC5749C5CE7657E + "_door_open");
  distsq = squared(160);
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(3, 15, 3);

  for(;;) {
    player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(_id_20510600314FE827, 160);
    _id_57A1DB84D888872E = 0;
    _id_24A4E29034CF3EBC = [];

    foreach(player in level.players) {
      if(!isalive(player) || player isspectatingplayer()) {
        continue;
      }
      if(distancesquared(player.origin, _id_20510600314FE827) < distsq) {
        _id_57A1DB84D888872E++;
        continue;
      }

      _id_24A4E29034CF3EBC[_id_24A4E29034CF3EBC.size] = player;
    }

    if(_id_57A1DB84D888872E == level.players.size) {
      wait 2;
      continue;
    }

    nags = _id_F2D04A72F825CEE4(_id_24A4E29034CF3EBC);
    level notify(_id_6EC5749C5CE7657E + "door_nag", player);
    player = scripts\engine\utility::getclosest(_id_20510600314FE827, level.players);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, nags, 0.2, 0, 1);
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
  }
}

_id_4CC5919CF7844F35() {
  level endon("stealth_section_complete");
  childthread _id_C66A0548567211B7();
  childthread _id_AFFF009A5F0B1430();
  childthread _id_72CBC10D4F55DDC4();
  childthread _id_5DE4A2BBAA991250();
  childthread _id_1686F8E9EC87C230();
  childthread _id_413EE7D56D3D028A();
  childthread _id_2FF4B96712B11547();
  childthread _id_E7419DAA6DF3A983();
  childthread _id_AB2709F94915FDCB();
  childthread _id_EE7362EFEAB3D9DA();
  childthread _id_CA33DC9ADE1C4DE4();
  childthread _id_13CDD9C90220CC37();
  childthread _id_796DA9CF2E91A97A();
  childthread _id_8A8DC981451856FB();
  childthread _id_36FEF0DEF3432128();
  childthread _id_EEA4F538FF009CA5();
  childthread _id_F5DCBFDA664697FE();
  childthread _id_B743DCDC09670D3D();
  childthread _id_2BD0E29161FC6FFA();
  childthread _id_3A8CDCF197676F6A();
  level waittill("stealth_section_complete");
}

_id_3A8CDCF197676F6A() {
  level endon("vo_stealthSection_allThroughGate");
  _id_62E11D77B25C1D30::_id_1D977083C90B0996((9958.59, 19464.1, -3171.74), (3441.54, 16455, -4443.75));
  wait 1.3;
  aliases = ["dx_cp_cpr4_stls_fara_wereclear", "dx_cp_cpr4_stls_pric_clear", "dx_cp_cpr4_stls_alex_clear"];
  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_C66A0548567211B7() {
  weapons = (9741.74, 17518.4, -3625.5);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(weapons, 0.9, 0.2, 0, [level.farah, level.price])[0];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_scpw_alex_thisiswhatimtalkinab", 0.3);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_scpw_pric_takeeverythingyoucan", 0.2);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_scpw_fara_doitfast", 0.4);
  wait 4;
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_scpw_alex_aqsgotagoodweaponsco", 0.3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_scpw_pric_indeed", 0.3);
  childthread _id_E4369A958821ECE5();
}

_id_AFFF009A5F0B1430() {
  aliases = ["dx_cp_cpr4_scpw_fara_gotasuppressedweapon", "dx_cp_cpr4_scpw_pric_weshouldstaydarkyeah", "dx_cp_cpr4_scpw_alex_gonnatrytokeepitquie"];

  for(;;) {
    result = _id_0EDCF07839930CA2("finish_pickup_of_weapon");

    if(!isDefined(result[2]) || !_id_DD8A1895C28E6190(result[2])) {
      continue;
    }
    result = _id_62E11D77B25C1D30::_id_A606867D80CFABD5(result[0], aliases, 0.4, 0, 3);

    if(istrue(result))
      return;
  }
}

_id_DD8A1895C28E6190(weapon) {
  if(!isDefined(weapon) || isnullweapon(weapon))
    return 0;

  attachments = getweaponattachments(weapon);

  if(!isDefined(attachments))
    return 0;

  foreach(attachment in attachments) {
    if(issubstr(attachment, "silencer"))
      return 1;
  }

  return 0;
}

_id_E4369A958821ECE5() {
  level endon("vo_stealthSection_exitArmory");
  level endon("vo_stealthSection_endHadirConvo");

  if(scripts\engine\utility::flag("vo_stealthSection_exitArmory")) {
    return;
  }
  wait 12;
  _id_A3529C4E4EBF23E3();
}

_id_A3529C4E4EBF23E3() {
  level endon("vo_combat");
  level endon("vo_stealthSection_endHadirConvo");
  wait 1;
  _id_7F9BB0B911C426BC = [0.2, "dx_cp_cpr4_trnf_pric_youheardwhathadirsai", level.farah, 0.3, "dx_cp_cpr4_trnf_fara_youthinkiwontdowhati", level.alex, 0.4, "dx_cp_cpr4_trnf_alex_weknowyouwillwejustw", level.price, 0.2, "dx_cp_cpr4_trnf_pric_familyaddsaheavyweig", level.farah, 0.3, "dx_cp_cpr4_trnf_fara_hadirchosehisfamilys"];
  level.price _id_5D265B4FCA61F070::_id_B0C2A659A5C2761F(["vo_stealthSection_endHadirConvo", "vo_combat"], _id_7F9BB0B911C426BC);
}

_id_E2A1CFCB4A31C708(timeout) {
  foreach(player in level.players) {
    if(player.origin[0] > 9175 || player.origin[2] < -3650)
      return 0;
  }

  return 1;
}

_id_72CBC10D4F55DDC4() {
  outside = (9571.63, 16989.9, -3682.5);
  player = _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(outside, 100)[0];
  scripts\engine\utility::flag_set("vo_stealthSection_exitArmory");
  aliases = ["dx_cp_cpr4_scpw_fara_thisway", "dx_cp_cpr4_scpw_pric_doorshere", "dx_cp_cpr4_scpw_alex_foundthewaydown"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 0, 3);
  childthread _id_D063B2D735B33F2E();
  childthread _id_362346B856122E02();
}

_id_D063B2D735B33F2E() {
  level endon("vo_hear_or_spot_enemies");
  level endon("vo_combat");
  player = undefined;
  _id_8FC78EB8CC2BE0BB(800);
  level notify("vo_stealthSection_endHadirConvo");
  wait 0.7;

  if(scripts\engine\utility::flag("vo_combat")) {
    return;
  }
  aliases = ["dx_cp_cpr4_stls_fara_ihearenemies", "dx_cp_cpr4_stls_pric_gotaqahead", "dx_cp_cpr4_stls_alex_ihearaq"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  scripts\engine\utility::flag_set("vo_hear_or_spot_enemies", player);
}

_id_8FC78EB8CC2BE0BB(dist) {
  distsq = squared(dist);

  for(;;) {
    level.battlechatter waittill("chatter_started", _id_3A7AEA3989AE851A);

    foreach(player in level.players) {
      if(distancesquared(player.origin, _id_3A7AEA3989AE851A.owner.origin) < distsq)
        return;
    }
  }
}

_id_362346B856122E02() {
  level endon("vo_hear_or_spot_enemies");
  level endon("vo_combat");
  aliases = ["dx_cp_cpr4_stls_fara_carefulenemieshere", "dx_cp_cpr4_stls_pric_gotaqhere", "dx_cp_cpr4_stls_alex_eyesupgotaqhere"];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(::getaiarray, 0.8, 0.2, 0, [], 800)[0];
  level notify("vo_stealthSection_endHadirConvo");

  if(scripts\engine\utility::flag("vo_combat")) {
    return;
  }
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  scripts\engine\utility::flag_set("vo_hear_or_spot_enemies", player);
}

_id_5DE4A2BBAA991250() {
  player = scripts\engine\utility::flag_wait("vo_hear_or_spot_enemies");

  if(!isDefined(player))
    player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
  else
    player = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(player.origin, player);

  aliases = ["dx_cp_cpr4_stls_fara_getlowusethevehicles", "dx_cp_cpr4_stls_pric_wecancrawlundertheve", "dx_cp_cpr4_stls_alex_wecanusethevehiclesf"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_1686F8E9EC87C230() {
  for(;;) {
    player = _id_F4B1BE8BDCE0DEA0(-3765);

    if(scripts\engine\utility::flag("vo_combat")) {
      waitframe();
      continue;
    }

    if(!isDefined(level._id_74E59397554FA00A) || scripts\engine\utility::time_has_passed(level._id_74E59397554FA00A, 5))
      aliases = ["dx_cp_cpr4_stls_fara_goinguptop", "dx_cp_cpr4_stls_pric_takinthehighground", "dx_cp_cpr4_stls_alex_rightovertheirheads"];
    else
      aliases = ["dx_cp_cpr4_stls_fara_wecanusethetruckstoc", "dx_cp_cpr4_stls_pric_goinoverthetop", "dx_cp_cpr4_stls_alex_usethetruckswecancli"];

    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4, 0, 3);
    break;
  }
}

_id_F4B1BE8BDCE0DEA0(height) {
  for(;;) {
    foreach(player in level.players) {
      if(player.origin[2] > height && player.origin[0] < 9175 && player.origin[0] > 6000)
        return player;
    }

    waitframe();
  }
}

_id_413EE7D56D3D028A() {
  tripwires = [(7789.83, 18132.2, -3777.14), (6880.78, 18158.1, -3777.14), (6001.92, 17960.2, -3777.14), (5206.31, 17549.1, -3764.12)];
  traps = scripts\engine\utility::array_combine(tripwires, level._id_495A85B8678D3C6A);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(traps, 0.9, 0.3, 0, [], 400, (0, 0, 10))[0];

  if(scripts\engine\utility::flag("vo_combat"))
    aliases = ["dx_cp_cpr4_stls_fara_traphere", "dx_cp_cpr4_stls_pric_carefultrapshere", "dx_cp_cpr4_stls_alex_gotatraphere"];
  else
    aliases = ["dx_cp_cpr4_stls_fara_carefultheyvesettrap", "dx_cp_cpr4_stls_pric_trapsherestaysharp", "dx_cp_cpr4_stls_alex_stayfrostytunnelsrig"];

  level._id_74E59397554FA00A = gettime();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_AF37DB5B7FAB0115() {
  for(player = undefined; !isDefined(player); player = _id_07BE3E09F12F1993()) {}

  return player;
}

_id_07BE3E09F12F1993() {
  scripts\engine\utility::flag_wait("vo_combat");
  level endon("vo_combat");
  wait 1;
  _id_CA233BC61873024C();
  _id_CA233BC61873024C();
  _id_CA233BC61873024C();
  player = _id_CA233BC61873024C()[0];
}

_id_2FF4B96712B11547() {
  player = _id_AF37DB5B7FAB0115();
  aliases = ["dx_cp_cpr4_stls_fara_therestoomanyusethev", "dx_cp_cpr4_stls_pric_wereoutgunnedusethet", "dx_cp_cpr4_stls_alex_usethevehiclesstayin"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  wait 5;

  while(!scripts\engine\utility::flag("vo_strict_combat")) {
    scripts\engine\utility::flag_wait("vo_combat");
    wait 5;
  }

  aliases = ["dx_cp_cpr4_stls_fara_findsomethingtohideb", "dx_cp_cpr4_stls_pric_findcovergodark", "dx_cp_cpr4_stls_alex_usethetrucksforcover"];
  player = _id_62E11D77B25C1D30::_id_167FAE92423447B9();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  scripts\engine\utility::flag_waitopen("vo_strict_combat");
  wait 3;
  aliases = ["dx_cp_cpr4_stls_fara_welostthemletsstayda", "dx_cp_cpr4_stls_pric_werebackinthedarklet", "dx_cp_cpr4_stls_alex_theylostusletsusethi"];
  player = _id_62E11D77B25C1D30::_id_167FAE92423447B9();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_E7419DAA6DF3A983() {
  _id_34A8E0811773CFA7 = [(8389.4, 18684.9, -3817.5), (6030.26, 18675, -3817.5), (6544.71, 17680.5, -3817.5), (7872.57, 17707.9, -3817.5)];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_34A8E0811773CFA7, 0.8, 0.3, 0, [], 400)[0];
  aliases = ["dx_cp_cpr4_stls_fara_ifoundaroom", "dx_cp_cpr4_stls_pric_foundaroomhere", "dx_cp_cpr4_stls_alex_gotaroomoverhere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  aliases = ["dx_cp_cpr4_stls_fara_nowayoutthroughthere", "dx_cp_cpr4_stls_pric_noegressthroughthere", "dx_cp_cpr4_stls_alex_noexfilthatwaygottak"];
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_AB2709F94915FDCB() {
  aliases = ["dx_cp_cpr4_stls_fara_climbinguptothecatwa", "dx_cp_cpr4_stls_pric_climbinguptop", "dx_cp_cpr4_stls_alex_goinguptopforabetter"];
  height = -3680;
  player = _id_F4B1BE8BDCE0DEA0(height);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  aliases = ["dx_cp_cpr4_stls_fara_wecanshootdownonthem", "dx_cp_cpr4_stls_alex_coveringfromuptop", "dx_cp_cpr4_stls_pric_gotclearshotsuphere"];

  for(;;) {
    result = _id_0EDCF07839930CA2("weapon_fired");
    player = result[0];

    if(player.origin[2] > height && player.origin[0] < 9000 && player.origin[0] > 6000) {
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
      return;
    }
  }
}

_id_EE7362EFEAB3D9DA() {
  aliases = ["dx_cp_cpr4_stls_fara_theresanopenventhere", "dx_cp_cpr4_stls_pric_theresapassagehere", "dx_cp_cpr4_stls_alex_foundanopenventhere"];
  _id_96320925B7BDFBDA = (4145.15, 17418.5, -3708.17);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_96320925B7BDFBDA, 0.7, 0.3, 0, [], 300)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_CA33DC9ADE1C4DE4() {
  aliases = ["dx_cp_cpr4_stls_fara_maybewetryupstairs", "dx_cp_cpr4_stls_pric_stairsgottaleadsomew", "dx_cp_cpr4_stls_alex_maybetheressomething"];
  _id_4A393CAA91D7B533 = [(3996.01, 16673.9, -3661.07), (3977.47, 17285.3, -3648.87)];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_4A393CAA91D7B533, 0.7, 0.3, 0, [], 300)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_13CDD9C90220CC37() {
  aliases = ["dx_cp_cpr4_stls_fara_searchingthestairs", "dx_cp_cpr4_stls_pric_pushingupthestairs", "dx_cp_cpr4_stls_alex_headinuptop"];
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((3817.26, 17320.7, -3642.25), (4126.64, 16629.9, -3486.04));
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.6, 0, 0);
}

_id_796DA9CF2E91A97A() {
  button = (4183.79, 17335.1, -3496.49);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(button, 0.9, 0.2, 0, [], 400)[0];
  scripts\engine\utility::flag_set("vo_spotUpperGate");

  if(scripts\engine\utility::flag("vo_spotLowerGate"))
    aliases = ["dx_cp_cpr4_stls_fara_lookslikethebuttondo", "dx_cp_cpr4_stls_pric_thislookslikethebutt", "dx_cp_cpr4_stls_alex_looksjustlikethebutt"];
  else
    aliases = ["dx_cp_cpr4_stls_fara_theresabuttonhere", "dx_cp_cpr4_stls_pric_gotabuttonhere", "dx_cp_cpr4_stls_alex_gotsomethinhereitsab"];

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_8A8DC981451856FB() {
  button = (4260.09, 16646.6, -3693.78);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(button, 0.9, 0.2, 0, [], 200)[0];
  scripts\engine\utility::flag_set("vo_spotLowerGate");
  aliases = ["dx_cp_cpr4_stls_fara_gateslockedtheresabu", "dx_cp_cpr4_stls_pric_gateslockedlookslike", "dx_cp_cpr4_stls_alex_thisgateunlocksfromt"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(button, 0.9, 0.2, 0, [], 350)[0];

  if(!scripts\engine\utility::flag("vo_spotUpperGate")) {
    aliases = ["dx_cp_cpr4_stls_fara_thecontrolroomuptopm", "dx_cp_cpr4_stls_pric_weshouldsweepthecont", "dx_cp_cpr4_stls_alex_maybetheresawaytounl"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  }
}

_id_36FEF0DEF3432128() {
  aliases = ["dx_cp_cpr4_stls_fara_imin", "dx_cp_cpr4_stls_pric_imclear", "dx_cp_cpr4_stls_alex_imthrough"];
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((4293.65, 16623.6, -3789.64), (4126.89, 16522.1, -3574.45));
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_EEA4F538FF009CA5() {
  level waittill("twoman_door_used", door);
  door waittill("opening");
  wait 0.6;
  player = door._id_0A365BADCD826F9D;
  aliases = ["dx_cp_cpr4_stls_fara_youhearthatsomething", "dx_cp_cpr4_stls_pric_itopenedsomething", "dx_cp_cpr4_stls_alex_soundslikeitopenedso"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);
}

_id_F5DCBFDA664697FE() {
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_stls_fara_unlockthegate", "dx_cp_cpr4_stls_fara_hitthebuttonforme"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_stls_pric_needyoutohitthebutto", "dx_cp_cpr4_stls_pric_unlockthegateyeah"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_stls_alex_unlockthegateforme", "dx_cp_cpr4_stls_alex_ineedyoutohitthebutt"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(3, 12, 4);
  _id_1FE90B84D9AB9DB6 = getEnt("2man_hallway_door", "script_noteworthy");

  while(isDefined(_id_1FE90B84D9AB9DB6)) {
    player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((4286.23, 16624.8, -3778), (4132.3, 16718.4, -3653.77));
    result = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((4127.63, 16625.9, -3546.08), (4288.68, 15255.5, -4065.6), 0, undefined, 0.1);

    if(isDefined(result) && !istrue(_id_1FE90B84D9AB9DB6._id_233D382A9996DE04)) {
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
      _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    }

    wait 0.3;
  }
}

_id_B743DCDC09670D3D() {
  level notify("vo_stealthSection_allThroughGate");
  aliases = ["dx_cp_cpr4_stls_fara_wereallthroughletske", "dx_cp_cpr4_stls_pric_allaccountedforletsk", "dx_cp_cpr4_stls_alex_bandsallhereletsroll"];
  _id_62E11D77B25C1D30::_id_EF2011A8C2920E8C((4127.63, 16625.9, -3546.08), (4288.68, 15255.5, -4065.6));
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7((4099.64, 15377.4, -4008.41));
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_2BD0E29161FC6FFA() {
  aliases = ["dx_cp_cpr4_stls_fara_nothinghere", "dx_cp_cpr4_stls_pric_nothinthisway", "dx_cp_cpr4_stls_alex_notseeinawaythroughh"];
  _id_77119C5DA69C8FD1 = (3941.07, 15331, -3955.52);
  player = _id_62E11D77B25C1D30::_id_F3C414CE5CCAB845(_id_77119C5DA69C8FD1, 0.6, 0.2, 0, [], 100)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
}

_id_1F9F4A512EF692B7() {
  level endon("game_ended");
  level thread _id_F4A0288F4CB8999C();
  level thread _id_4570294222E4990A();
  level thread _id_1CB162A1124726F3();
  level thread _id_8A0CA83EA076E8BB();
  level thread _id_A01F83B9B54B63FC();
  level thread _id_1CA6BFF042F70C76();
  level thread _id_D870A23F7B3ED9D9();
  level thread _id_3921E774557F3797();
  level thread _id_86BC8E7BBD512CA8();
  level thread _id_83E06513E42C6D84();
  level thread _id_586DEAA591D6C117();
  level thread _id_24BE7162C18E5BD6();
  level thread _id_9A096C30FC3BA296();
  level thread _id_16CC9D1FBF519A82();
  level thread _id_8E837B680A07FCAE();
  level thread _id_E42B9455BE466940();
  level thread _id_8B0D169F7F13C1A8();
  level thread _id_9AB7F387C883723E();
  level thread _id_A3AF0FB0C531F33E();
  level thread _id_5E8CA95EA4A9B717();
}

_id_5E8CA95EA4A9B717() {
  level endon("game_ended");
  level endon("traps_defused_laser_sentry_defuse_mines");

  while(!isDefined(level._id_B3A61E1FD4CE7D8A))
    wait 1;

  while(level._id_B3A61E1FD4CE7D8A < 2) {
    level waittill("resetting_mine");
    wait 3;

    if(!istrue(level._id_580128B72946BEA1))
      level thread _id_86BC8E7BBD512CA8();

    if(!istrue(level._id_15D625C04C5EFFDE))
      level thread _id_9A096C30FC3BA296();

    level thread _id_E42B9455BE466940();
  }
}

_id_F4A0288F4CB8999C() {
  level endon("game_ended");
  _id_EA4FFFFC60463D30 = scripts\engine\utility::getStructArray("vo_laser_closed_gates", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_F3C414CE5CCAB845(_id_EA4FFFFC60463D30, 0.8, 0.6)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_idontseeanywayinther", "dx_cp_cpr4_mnsc_pric_notseeinawayinthere", "dx_cp_cpr4_mnsc_alex_nowayinthere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_8A0CA83EA076E8BB() {
  level endon("game_ended");
  level endon("traps_defused_laser_sentry_defuse_mines");
  lever = getEnt("damagable_lever", "targetname");
  _id_2BDB1EA9FEFC8567 = lever.origin[2];
  lever waittill("weight_freefell");
  players = scripts\engine\utility::create_deck(level.players);
  wait 0.3;
  alias = ["dx_cp_cpr4_stls_fara_problemsolved", "dx_cp_cpr4_stls_pric_nothinalittleelbowgr", "dx_cp_cpr4_stls_alex_whenindoubtbeatthesh"];
  _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, alias, 0.1);
  _id_B91C95CF773944CC = 1;
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(25, 40, 3);

  foreach(player in level.players)
  player thread _id_6160BED81C0BDCAE(_id_2BDB1EA9FEFC8567);

  while(_id_B91C95CF773944CC) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);

    foreach(player in level.players) {
      if(player.origin[2] < _id_2BDB1EA9FEFC8567 && abs(_id_2BDB1EA9FEFC8567 - player.origin[2]) >= 200)
        _id_B91C95CF773944CC = 0;
    }

    alias = ["dx_cp_cpr4_stls_fara_getdownhere", "dx_cp_cpr4_stls_pric_jumpdownwegottamove", "dx_cp_cpr4_stls_alex_downhereletsgo"];
    _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, alias, 0.1);
  }

  level notify("minesection_all_players_down");
  scripts\engine\utility::flag_set("minesection_all_players_down");
}

_id_6160BED81C0BDCAE(_id_2BDB1EA9FEFC8567) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait 5;

  while(!istrue(level._id_96057873DC7101B3)) {
    if(self.origin[2] < _id_2BDB1EA9FEFC8567 && abs(_id_2BDB1EA9FEFC8567 - self.origin[2]) >= 200) {
      level._id_96057873DC7101B3 = 1;
      alias = ["dx_cp_cpr4_stls_fara_noturningbacknow", "dx_cp_cpr4_stls_pric_onlywaysdown", "dx_cp_cpr4_stls_alex_mightaswelljump"];
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(self, alias, 0.1);
      wait 1;
      alias = ["dx_cp_cpr4_mnsc_fara_tunnelsclear", "dx_cp_cpr4_mnsc_pric_itsclear", "dx_cp_cpr4_mnsc_alex_cleardownhere"];
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(self, alias, 0.1);
      return;
    } else
      waitframe();
  }
}

_id_4570294222E4990A() {
  level endon("game_ended");
  level endon("vo_mines_barred_window_combat");
  level endon("minesection_all_players_down");
  lever = getEnt("damagable_lever", "targetname");

  if(isDefined(lever)) {
    lever endon("weight_freefell");
    lever endon("death");
  }

  players = scripts\engine\utility::create_deck(scripts\engine\utility::array_randomize(level.players));
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(15, 45, 3);

  for(;;) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);

    if(istrue(level._id_F73222E91960157A)) {
      alias = ["dx_cp_cpr4_stls_fara_itlookedlikethatwasw", "dx_cp_cpr4_stls_pric_keephittinit", "dx_cp_cpr4_stls_alex_dontstopnow"];
      _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, alias, 0.1);
      continue;
    } else {
      _id_871246B6C6ACEF63 = ["dx_cp_cpr4_stls_alex_looksliketheytriedto", "dx_cp_cpr4_stls_alex_gottabeawaytorelease"];
      _id_69706C7B0DA787F2 = ["dx_cp_cpr4_stls_pric_thatholeinthefloorlo", "dx_cp_cpr4_stls_pric_letsfindawaytodropth"];
      _id_2C8DC88FF5BB5EE5 = ["dx_cp_cpr4_stls_fara_looksliketheyretryin", "dx_cp_cpr4_stls_fara_maybewecanlowerthis"];
      _id_DCE885FB982EB23F = _id_871246B6C6ACEF63;
      _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();

      if(isDefined(level.farah) && _id_137CC0FFDF383E20 == level.farah)
        _id_DCE885FB982EB23F = _id_2C8DC88FF5BB5EE5;

      if(isDefined(level.alex) && _id_137CC0FFDF383E20 == level.alex)
        _id_DCE885FB982EB23F = _id_871246B6C6ACEF63;

      if(isDefined(level.price) && _id_137CC0FFDF383E20 == level.price)
        _id_DCE885FB982EB23F = _id_69706C7B0DA787F2;

      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, _id_DCE885FB982EB23F[0], 0.1);
      wait 0.9;
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, _id_DCE885FB982EB23F[1], 0.1);
    }
  }
}

_id_1CB162A1124726F3() {
  level endon("game_ended");
  level endon("minesection_all_players_down");
  level endon("traps_defused_laser_sentry_defuse_mines");
  lever = getEnt("damagable_lever", "targetname");

  if(isDefined(lever)) {
    lever endon("weight_freefell");
    lever endon("death");
  }

  waitframe();

  for(;;) {
    lever waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath);

    if(smeansofdeath == "MOD_EXPLOSIVE") {
      players = scripts\engine\utility::create_deck(scripts\engine\utility::array_randomize(level.players));
      _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
      alias = ["dx_cp_cpr4_stls_fara_theremustbeanotherwa", "dx_cp_cpr4_stls_pric_thatsnotgonnamoveit", "dx_cp_cpr4_stls_alex_wellthatdidntwork"];
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, alias, 0.1);
      wait 3;
      continue;
    }

    if(smeansofdeath == "MOD_MELEE") {
      _id_137CC0FFDF383E20 = eattacker;

      if(isDefined(eattacker) && isPlayer(eattacker))
        _id_137CC0FFDF383E20 = eattacker;
      else {
        players = scripts\engine\utility::create_deck(scripts\engine\utility::array_randomize(level.players));
        _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
      }

      alias = ["dx_cp_cpr4_stls_fara_letsdoittheoldfashio", "dx_cp_cpr4_stls_pric_whenallelsefails", "dx_cp_cpr4_stls_alex_learnedthistradecraf"];
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, alias, 0.1);
      level._id_F73222E91960157A = 1;
      wait 15;
    }
  }
}

_id_A01F83B9B54B63FC() {
  level endon("game_ended");
  _id_D1C41FA740331679 = scripts\engine\utility::getStruct("vo_laser_tunnel_drop_end", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_F3C414CE5CCAB845(_id_D1C41FA740331679, 0.8, 1)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_watchyourfiretheresg", "dx_cp_cpr4_mnsc_pric_checkfiregas", "dx_cp_cpr4_mnsc_alex_holdyourfirewegotgas"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
  _id_B21F6B7864297C65 = scripts\engine\utility::getStruct("vo_laser_tunnel_drop_left", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_F3C414CE5CCAB845(_id_B21F6B7864297C65, 0.8, 1)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_idontseeanywayinther", "dx_cp_cpr4_mnsc_pric_notseeinawayinthere", "dx_cp_cpr4_mnsc_alex_nowayinthere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_1CA6BFF042F70C76() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  level endon("vo_mines_barred_window_combat");
  level endon("traps_defused_laser_sentry_defuse_mines");
  lever = getEnt("damagable_lever", "targetname");
  lever waittill("weight_freefell");
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(20, 40, 3);
  _id_43BCAFC0C8767EBA = spawnStruct();
  _id_43BCAFC0C8767EBA.origin = (4117.33, 14479.4, -4279.93);
  _id_0D73BDD3CCD0DF1C = 262144;

  while(getaiarray("axis").size <= 0)
    waitframe();

  players = scripts\engine\utility::create_deck(scripts\engine\utility::array_randomize(level.players));

  while(scripts\cp\utility::are_all_players_nearby(_id_43BCAFC0C8767EBA.origin, _id_0D73BDD3CCD0DF1C)) {
    _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
    aliases = ["dx_cp_cpr4_mnsc_fara_wehavetofindawaytoke", "dx_cp_cpr4_mnsc_pric_weneedtofindawaypast", "dx_cp_cpr4_mnsc_alex_gottabeawaytogetpast"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.1);
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
  }
}

_id_D870A23F7B3ED9D9() {
  level endon("game_ended");
  level endon("traps_defused_laser_sentry_defuse_mines");
  level waittill("laser_section_ai_laser_section_1", _id_6F0F553953DFFB68);

  if(!isai(_id_6F0F553953DFFB68)) {
    return;
  }
  _id_6F0F553953DFFB68 endon("death");
  level thread _id_76B46D42E5B47C12(_id_6F0F553953DFFB68);
  _id_6F0F553953DFFB68 waittill("weapon_fired");
  level notify("vo_mines_barred_window_combat");
  aliases = ["dx_cp_cpr4_mnsc_fara_contactshootersbehin", "dx_cp_cpr4_mnsc_pric_takingfireguardbehin", "dx_cp_cpr4_mnsc_alex_contactwegottatakeou"];
  players = scripts\engine\utility::create_deck(scripts\engine\utility::array_randomize(level.players));
  _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.1);
  _id_6F0F553953DFFB68 thread _id_13C871822EDD2F05();
}

_id_13C871822EDD2F05() {
  level endon("game_ended");
  ai = self;
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(15, 30, 3);
  players = scripts\engine\utility::create_deck(level.players);
  wait 3;

  while(isalive(ai)) {
    _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
    aliases = ["dx_cp_cpr4_mnsc_fara_wehavetotakeoutthatg", "dx_cp_cpr4_mnsc_pric_wegottadealwiththatg", "dx_cp_cpr4_mnsc_alex_thatguardsgonnabeapr"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.1);
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
  }
}

_id_76B46D42E5B47C12(ai) {
  level endon("game_ended");
  ai waittill("death");
  level._id_F9BBAB957C3AE0C8 = 1;
  aliases = ["dx_cp_cpr4_mnsc_fara_guardsdown", "dx_cp_cpr4_mnsc_pric_sortedtheguard", "dx_cp_cpr4_mnsc_alex_guardshandled"];
  players = scripts\engine\utility::create_deck(level.players);
  _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.1);
}

_id_86BC8E7BBD512CA8() {
  level endon("game_ended");
  level endon("traps_defused_laser_sentry_defuse_mines");
  level endon("resetting_mine");

  if(getdvarint("dvar_F0F10B52A800D290", 0) < 1) {
    while(!istrue(level._id_F9BBAB957C3AE0C8))
      waitframe();
  }

  players = scripts\engine\utility::create_deck(level.players);
  _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
  aliases = ["dx_cp_cpr4_mnsc_fara_theresenoughgasdownh", "dx_cp_cpr4_mnsc_pric_lottagasnoroomformis", "dx_cp_cpr4_mnsc_alex_werestandininonegian"];
  level._id_580128B72946BEA1 = 1;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.1);
}

_id_3921E774557F3797() {
  level endon("game_ended");
  level endon("traps_defused_laser_sentry_defuse_mines");
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(5, 15, 3);
  players = scripts\engine\utility::create_deck(level.players);

  for(;;) {
    level waittill("lasers_red_barrel_damaged");
    _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
    _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_fara_dontshootthegasyoull", "dx_cp_cpr4_mnsc_fara_checkfireonthegas", "dx_cp_cpr4_mnsc_fara_watchthegas"]);
    _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_pric_dontshootthebloodych", "dx_cp_cpr4_mnsc_pric_checkyourfire", "dx_cp_cpr4_mnsc_pric_dontshootthegas"]);
    _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_alex_easyshootingatthegas", "dx_cp_cpr4_mnsc_alex_thatshitlltakeyourle", "dx_cp_cpr4_mnsc_alex_checkyourfire", "dx_cp_cpr4_mnsc_alex_dontshootthegas"]);
    aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.1);
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
  }
}

_id_9A096C30FC3BA296() {
  level endon("game_ended");
  level endon("started_laser_deactivation_vo");
  level endon("resetting_mine");
  marker = scripts\engine\utility::getStruct("vo_barkov_convo", "script_noteworthy");
  _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(marker.origin, 400);

  if(!isDefined(level._id_055CE07BF81C7081))
    level._id_055CE07BF81C7081 = 0;

  if(level._id_055CE07BF81C7081 <= 0) {
    if(isDefined(level.alex))
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_mnsc_alex_weveseenthesebarrels", 0.1);

    level._id_055CE07BF81C7081 = 1;
  }

  if(level._id_055CE07BF81C7081 <= 1) {
    if(isDefined(level.farah))
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_mnsc_fara_barkovthiswasthegash", 0.1);

    level._id_055CE07BF81C7081 = 2;
  }

  if(level._id_055CE07BF81C7081 <= 2) {
    if(isDefined(level.alex))
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_mnsc_alex_whatthehellsaqplanni", 0.1);

    level._id_055CE07BF81C7081 = 3;
  }

  if(level._id_055CE07BF81C7081 <= 2) {
    if(isDefined(level.price))
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_mnsc_pric_westophadirwemakesur", 0.1);

    level._id_055CE07BF81C7081 = 4;
  }

  level._id_15D625C04C5EFFDE = 1;
}

_id_24BE7162C18E5BD6() {
  level endon("game_ended");
  level endon("traps_defused_laser_sentry_defuse_mines");
  _id_4261D280BB619EF4 = scripts\engine\utility::getStruct("vo_laser1_deactivation_room", "script_noteworthy");
  _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(_id_4261D280BB619EF4.origin, 256);
  _id_A8B1A75B47CB2497 = scripts\engine\utility::getStruct("vo_laser_tunnel_guard_button", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_A8B1A75B47CB2497, 0.8, 0.1, 0, [], 300)[0];
  level notify("started_laser_deactivation_vo");
  aliases = ["dx_cp_cpr4_mnsc_fara_therescontrolboxesin", "dx_cp_cpr4_mnsc_pric_controlboxesinthegua", "dx_cp_cpr4_mnsc_alex_lookslikewecandisarm"];
  players = scripts\engine\utility::create_deck(level.players);
  _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.1);
}

_id_83E06513E42C6D84() {
  level endon("game_ended");
  level endon("traps_defused_laser_sentry_defuse_mines");
  lever = getEnt("damagable_lever", "targetname");
  lever waittill("weight_freefell");
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(30, 60, 3);
  players = scripts\engine\utility::create_deck(level.players);

  while(!isDefined(level._id_B3A61E1FD4CE7D8A))
    wait 1;

  while(level._id_B3A61E1FD4CE7D8A < 2) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
    aliases = ["dx_cp_cpr4_mnsc_fara_wecantlethadirslowus", "dx_cp_cpr4_mnsc_pric_theresgottabeawaypas", "dx_cp_cpr4_mnsc_alex_justgottafindawaypas"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.1);
  }
}

_id_586DEAA591D6C117() {
  level endon("game_ended");
  level endon("traps_defused_laser_sentry_defuse_mines");
  _id_8831727CF86C30A0 = scripts\engine\utility::getStructArray("vo_hang_beam_convo", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_57E617784FB02909(_id_8831727CF86C30A0[0].origin, _id_8831727CF86C30A0[1].origin, 0.8, 0.3, 0, [], 600);
  aliases = ["dx_cp_cpr4_mnsc_fara_maybewecanusethosebe", "dx_cp_cpr4_mnsc_pric_shouldbeabletoclimbu", "dx_cp_cpr4_mnsc_alex_maybewecanusethosebe"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
  level thread _id_2D39DA3D38EA4DB2();
}

_id_2D39DA3D38EA4DB2() {
  level endon("game_ended");
  _id_8831727CF86C30A0 = scripts\engine\utility::getStructArray("vo_hang_beam_convo", "script_noteworthy");

  for(;;) {
    foreach(player in level.players) {
      if(player _meth_415FE9EECA7B2E2B() && abs(_id_8831727CF86C30A0[0].origin[2] - player.origin[2]) <= 32) {
        aliases = ["dx_cp_cpr4_mnsc_fara_letsusethebeamstocli", "dx_cp_cpr4_mnsc_pric_usethebeamsclimbup", "dx_cp_cpr4_mnsc_alex_climbinguptop"];
        thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
        return;
      }
    }

    waitframe();
  }
}

_id_E42B9455BE466940() {
  level endon("game_ended");
  level endon("started_laser_deactivation_vo");
  level endon("vo_mines_barred_window_combat");
  level endon("traps_defused_laser_sentry_defuse_mines");
  level endon("resetting_mine");
  level notify("single_vo_mine_linger_before_opening_security_room");
  level endon("single_vo_mine_linger_before_opening_security_room");
  lever = getEnt("damagable_lever", "targetname");

  if(isDefined(lever))
    lever waittill("weight_freefell");
  else
    wait 3;

  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(40, 120, 3);
  players = scripts\engine\utility::create_deck(level.players);

  for(;;) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
    aliases = ["dx_cp_cpr4_mnsc_fara_wehavetodisarmthesel", "dx_cp_cpr4_mnsc_pric_needtofindawaytodisa", "dx_cp_cpr4_mnsc_alex_gottabeawaytokillthe"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.1);
    wait 1;
    aliases = ["dx_cp_cpr4_mnsc_fara_maybetheressomething", "dx_cp_cpr4_mnsc_pric_letschecktheguardroo", "dx_cp_cpr4_mnsc_alex_maybetherescontrolsi"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.1);
    players = scripts\engine\utility::create_deck(level.players);
  }
}

_id_8E837B680A07FCAE() {
  level endon("game_ended");
  level endon("players_at_guard_door");
  _id_421681406E479DAF = scripts\engine\utility::getStruct("vo_guardroom_door", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_421681406E479DAF.origin, 0.7, 0.9, 0, undefined, 65)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_theresthedoor", "dx_cp_cpr4_mnsc_pric_goteyesontheguardroo", "dx_cp_cpr4_mnsc_alex_theresourdoor"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
}

_id_8B0D169F7F13C1A8() {
  level endon("game_ended");
  _id_8831727CF86C30A0 = scripts\engine\utility::getStructArray("vo_laser_barrels_hit", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_8831727CF86C30A0, 0.8, 3, 0, undefined, 512)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_thebarrelsthelasersd", "dx_cp_cpr4_mnsc_pric_lookslikethosebarrel", "dx_cp_cpr4_mnsc_alex_thelasersarehittinth"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
}

_id_9AB7F387C883723E() {
  level endon("game_ended");
  _id_8831727CF86C30A0 = scripts\engine\utility::getStructArray("vo_laser_barrels_top", "script_noteworthy");

  foreach(marker in _id_8831727CF86C30A0)
  level thread _id_C8DAE3140A450D60(marker);
}

_id_C8DAE3140A450D60(marker) {
  level endon("game_ended");
  level endon("traps_defused_laser_sentry_defuse_mines");

  for(;;) {
    excludedplayers = [];

    foreach(player in level.players) {
      if(istrue(player._id_1FB5DE24381634F6))
        excludedplayers[excludedplayers.size] = player;
    }

    if(excludedplayers.size >= level.players.size) {
      return;
    }
    player = _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(marker.origin, 100, excludedplayers)[0];
    wait 2;

    if(distance2d(player.origin, marker.origin) <= 100 && player.origin[2] >= marker.origin[2]) {
      aliases = ["dx_cp_cpr4_mnsc_fara_climbuponthebarrels", "dx_cp_cpr4_mnsc_pric_usethebarrelstoclimb", "dx_cp_cpr4_mnsc_alex_wecanusethebarrelsto"];
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
      player._id_1FB5DE24381634F6 = 1;
      continue;
    }

    waitframe();
  }
}

_id_16CC9D1FBF519A82() {
  level endon("game_ended");
  level endon("traps_defused_laser_sentry_defuse_mines");
  _id_421681406E479DAF = scripts\engine\utility::getStruct("vo_guardroom_door", "script_noteworthy");
  aliases = ["dx_cp_cpr4_mnsc_fara_atthedoorletsgo", "dx_cp_cpr4_mnsc_pric_readyatthedoor", "dx_cp_cpr4_mnsc_alex_imatthedoor"];
  _id_5AAB9D85460F9E87 = level.players;
  _id_C3A7995450D10E1C = 0;

  while(!_id_C3A7995450D10E1C) {
    foreach(player in _id_5AAB9D85460F9E87) {
      if(!isDefined(player)) {
        waitframe();
        continue;
      }

      if(distance(player.origin, _id_421681406E479DAF.origin) < 100) {
        _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
        _id_C3A7995450D10E1C = 1;
        _id_5AAB9D85460F9E87 = scripts\engine\utility::array_remove(_id_5AAB9D85460F9E87, player);
        level notify("players_at_guard_door");
        break;
      }
    }

    wait 2;
  }

  level waittill("3man_door_laser_1_door_open");
  players = scripts\engine\utility::create_deck(level.players);
  _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
  aliases = ["dx_cp_cpr4_mnsc_fara_clear", "dx_cp_cpr4_mnsc_pric_allclear", "dx_cp_cpr4_mnsc_alex_wereclear"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.1);
  level thread _id_E2C9314424C4FE2A();
}

_id_E2C9314424C4FE2A() {
  level endon("game_ended");
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(20, 60, 3);
  players = scripts\engine\utility::create_deck(level.players);
  aliases = ["dx_cp_cpr4_mnsc_fara_lookforcontrolswenee", "dx_cp_cpr4_mnsc_pric_checkforcontrols", "dx_cp_cpr4_mnsc_alex_gottabesomethingtoki"];
  level thread _id_FE3F50FF8EF193BC();

  while(!scripts\engine\utility::flag("traps_defused_laser_sentry_defuse_mines")) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.1);
  }
}

_id_FE3F50FF8EF193BC() {
  level endon("game_ended");
  players = scripts\engine\utility::create_deck(level.players);
  scripts\engine\utility::flag_wait("traps_defused_laser_sentry_defuse_mines");
  _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
  aliases = ["dx_cp_cpr4_mnsc_fara_clear", "dx_cp_cpr4_mnsc_pric_allclear", "dx_cp_cpr4_mnsc_alex_wereclear"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.1);
}

_id_776BCF5590B59708() {
  level endon("game_ended");
  level notify("single_mine_ee_entrance_seen");
  level endon("single_mine_ee_entrance_seen");
  _id_0D32078955171127 = scripts\engine\utility::getStruct("vo_ee_room_entrance", "script_noteworthy");
  aliases = ["dx_cp_cpr4_mnsc_fara_theyreprotectingsome", "dx_cp_cpr4_mnsc_pric_aqsguardinsomethinin", "dx_cp_cpr4_mnsc_alex_mustbesomethininther"];
  _id_E68973C4E336C67B = ["dx_cp_cpr4_mnsc_fara_lookforcontrolswenee", "dx_cp_cpr4_mnsc_pric_checkforcontrols", "dx_cp_cpr4_mnsc_alex_gottabesomethingtoki"];
  player = _id_62E11D77B25C1D30::_id_F3C414CE5CCAB845(_id_0D32078955171127, 0.8, 3, 1, [], 400)[0];

  if(isDefined(level._id_B3A61E1FD4CE7D8A) && level._id_B3A61E1FD4CE7D8A == 2)
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_E68973C4E336C67B);
  else
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_07CDA0F84A658E63() {
  level endon("game_ended");

  while(!isDefined(level._id_B3A61E1FD4CE7D8A) || level._id_B3A61E1FD4CE7D8A < 2)
    wait 1;

  level thread _id_71BD702403DD7724();
  level thread _id_4919D4C17703556A();
  level thread _id_F0B742D63E70968C();
  level thread _id_DC00088624029B21();
  level thread _id_EF35EAFAC788D61A();
  level thread _id_7261B87378F29C80();
  level thread _id_FF1115243F829ECA();
  level thread _id_BC134B0D4E836FDF();
  level thread _id_662F30E4F4971EE9();
  level thread _id_C9A6D14479280986();
}

_id_C9A6D14479280986() {
  level endon("game_ended");
  level endon("traps_defused_laser_sentry_defuse_mines_2");

  while(!isDefined(level._id_B3A61E1FD4CE7D8A))
    wait 1;

  while(level._id_B3A61E1FD4CE7D8A == 2) {
    level waittill("resetting_mine");
    wait 3;

    if(!istrue(level._id_AA65EAE3AD18F2F1))
      level thread _id_DC00088624029B21();
  }
}

_id_FF1115243F829ECA() {
  level endon("game_ended");
  level endon("3man_door_laser_2_door_open");
  marker = scripts\engine\utility::getStruct("vo_mine_second_lasers_laserwall", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(marker.origin, 20)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_findawaypastthisgate", "dx_cp_cpr4_mnsc_pric_lookforawaypastthisg", "dx_cp_cpr4_mnsc_alex_theresgottabeawaypas"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_BC134B0D4E836FDF() {
  level endon("game_ended");
  level endon("3man_door_laser_2_door_open");
  marker = scripts\engine\utility::getStruct("vo_mine_second_lasers_badcorner", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(marker.origin, 20)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_thiswaysblockedcheck", "dx_cp_cpr4_mnsc_pric_nothinherecheckthefa", "dx_cp_cpr4_mnsc_alex_notfindinanythingove"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_662F30E4F4971EE9() {
  level endon("game_ended");
  level endon("3man_door_laser_2_door_open");
  marker = scripts\engine\utility::getStruct("vo_mine_second_lasers_door", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(marker.origin, 20)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_herefoundadoor", "dx_cp_cpr4_mnsc_pric_gotadoorhere", "dx_cp_cpr4_mnsc_alex_doorshere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_4919D4C17703556A() {
  level endon("game_ended");
  _id_F6F83FCC40670A9B = scripts\engine\utility::getStruct("vo_ee_room_prize", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_F3C414CE5CCAB845(_id_F6F83FCC40670A9B, 0.8, 0.5, 0, [], 400)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_ifoundsomething", "dx_cp_cpr4_mnsc_pric_foundsomethinghere", "dx_cp_cpr4_mnsc_alex_gotsomethinghere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);

  for(;;) {
    level waittill("pickedup_loot_success", key, player);

    if(key == "interactable_note_keycard_c") {
      aliases = ["dx_cp_cpr4_mnsc_fara_pickedupwhataqwastry", "dx_cp_cpr4_mnsc_pric_gotwhataqwastryingto", "dx_cp_cpr4_mnsc_alex_pickedupwhataqwastry"];
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
    }
  }
}

_id_71BD702403DD7724() {
  level endon("game_ended");
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(40, 120, 3);
  players = scripts\engine\utility::create_deck(level.players);
  aliases = ["dx_cp_cpr4_mnsc_fara_theresmoretraps", "dx_cp_cpr4_mnsc_pric_weneedtodisarmemall", "dx_cp_cpr4_mnsc_alex_stillgottrapsahead"];
  level thread _id_4C5AFD7B24EBFC78();

  for(_id_0DB653914731FC35 = 0; !scripts\engine\utility::flag("traps_defused_laser_sentry_defuse_mines_2") && _id_0DB653914731FC35 < 3; _id_0DB653914731FC35++) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.1);
  }
}

_id_4C5AFD7B24EBFC78() {
  level endon("game_ended");
  players = scripts\engine\utility::create_deck(level.players);
  scripts\engine\utility::flag_wait("traps_defused_laser_sentry_defuse_mines_2");
  _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
  aliases = ["dx_cp_cpr4_mnsc_fara_wereclearletskeepmov", "dx_cp_cpr4_mnsc_pric_trapsareofflinewereg", "dx_cp_cpr4_mnsc_alex_alllasersdisarmedwer"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.1);
}

_id_F0B742D63E70968C() {
  level endon("game_ended");
  marker = scripts\engine\utility::getStruct("vo_mine_tunnels", "script_noteworthy");
  _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(marker.origin, 400);
  player = sortbydistance(level.players, marker.origin)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_tracksleadthiswaylet", "dx_cp_cpr4_mnsc_pric_followthetrackskeepm", "dx_cp_cpr4_mnsc_alex_imthinkinwefollowthe"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
}

_id_DC00088624029B21() {
  level endon("game_ended");
  level endon("resetting_mine");
  level waittill("laser_section_ai_laser_section_2", ai);
  wait 3;

  while(getaiarray("axis").size > 0)
    wait 2;

  if(isDefined(level.price))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_mnsc_pric_thatwasntafullforcea", 0.1);

  if(isDefined(level.alex))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_mnsc_alex_theyretryintoslowusd", 0.1);

  if(isDefined(level.farah))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_mnsc_fara_thenweregettingclose", 0.1);

  level._id_AA65EAE3AD18F2F1 = 1;
}

_id_EF35EAFAC788D61A() {
  level endon("game_ended");
  marker = scripts\engine\utility::getStruct("vo_mine_second_lasers_seen", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(marker.origin, 400)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_becarefultheselasers", "dx_cp_cpr4_mnsc_pric_eyesuplasersaremovin", "dx_cp_cpr4_mnsc_alex_itslikealightshowwit"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
  level._id_A65DA46B560BE004 = level.players;
  level thread _id_0300660DEA08F829();
  level thread _id_AF269F9CABAC3014();
}

_id_0300660DEA08F829() {
  level endon("game_ended");
  marker = scripts\engine\utility::getStruct("vo_mine_second_lasers_passed", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(marker.origin, 400)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_ifyoutimeitrightyoul", "dx_cp_cpr4_mnsc_pric_theresapatterntimeit", "dx_cp_cpr4_mnsc_alex_ifyoutimeitrightyouc"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
  level._id_A65DA46B560BE004 = scripts\engine\utility::array_remove(level._id_A65DA46B560BE004, player);

  while(level._id_A65DA46B560BE004.size > 0) {
    foreach(player in level._id_A65DA46B560BE004) {
      if(distance2d(marker.origin, player.origin) <= 400)
        level._id_A65DA46B560BE004 = scripts\engine\utility::array_remove(level._id_A65DA46B560BE004, player);
    }

    wait 1;
  }

  level notify("vo_all_players_past_first_moving_lasers");
}

_id_AF269F9CABAC3014() {
  level endon("game_ended");
  level endon("vo_all_players_past_first_moving_lasers");
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(40, 60, 3);
  players = scripts\engine\utility::create_deck(level.players);
  aliases = ["dx_cp_cpr4_mnsc_fara_timethelaserandkeepm", "dx_cp_cpr4_mnsc_pric_timeitthenmove", "dx_cp_cpr4_mnsc_alex_timeitupletsgo"];

  while(!scripts\engine\utility::flag("traps_defused_laser_sentry_defuse_mines")) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.1);
  }
}

_id_7261B87378F29C80() {
  level endon("game_ended");
  level endon("3man_door_laser_2_door_open");
  _id_51F5101F6755F379 = scripts\engine\utility::getStructArray("vo_mine_second_lasers_crouchspot", "script_noteworthy");
  scripts\engine\utility::array_thread(_id_51F5101F6755F379, ::_id_9045083A2C020E67);
}

_id_70A81C6A27CE3233(player) {
  stance = player getstance();
  return stance == "crouch" || stance == "prone";
}

_id_9045083A2C020E67() {
  level endon("game_ended");
  level endon("3man_door_laser_2_door_open");
  excludedplayers = [];

  for(;;) {
    player = _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(self.origin, 50, excludedplayers)[0];

    if(istrue(player._id_98BFBBB2841319E4)) {
      excludedplayers[excludedplayers.size] = player;
      continue;
    }

    starttime = gettime();
    endtime = starttime + 2000;

    while(_id_70A81C6A27CE3233(player) && distance2d(player.origin, self.origin) <= 50) {
      if(gettime() > endtime) {
        player._id_98BFBBB2841319E4 = 1;
        _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_fara_searchforcover", "dx_cp_cpr4_mnsc_fara_findcover", "dx_cp_cpr4_mnsc_fara_findsomethingforcove"]);
        _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_pric_wecanusecover", "dx_cp_cpr4_mnsc_pric_lookforcover", "dx_cp_cpr4_mnsc_pric_findcover"]);
        _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_alex_usesomethingforcover", "dx_cp_cpr4_mnsc_alex_findcover", "dx_cp_cpr4_mnsc_alex_usecover"]);
        aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
        _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
        player thread _id_EC8E120791951E9D(player.origin);
        break;
      }

      wait 1;
    }

    wait 1;
  }
}

_id_EC8E120791951E9D(_id_F21F93A20936DC2C) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  wait 3;

  if(distance2d(_id_F21F93A20936DC2C, self.origin) <= 100) {
    aliases = ["dx_cp_cpr4_mnsc_fara_weresafeaslongaswere", "dx_cp_cpr4_mnsc_pric_lookslikeweregoodasl", "dx_cp_cpr4_mnsc_alex_lasersarebodyheatact"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(self, aliases, 0.1);
  }
}

_id_07CD9FF84A658C30() {
  level endon("game_ended");

  while(!isDefined(level._id_B3A61E1FD4CE7D8A) || level._id_B3A61E1FD4CE7D8A < 3)
    wait 1;

  level thread _id_C8C288A7C1DFE14C();
  level thread _id_EBEA0544FD77DFA0();
  level thread _id_9CF00B1AC3E4BD94();
  level thread _id_72577FEF5A72936B();
  level thread _id_0957A45A064F939C();
  level thread _id_B795EF81F3483AA5();
  level thread _id_28344ACE14649803();
  level thread _id_796364E780E56474();
}

_id_796364E780E56474() {
  level endon("game_ended");
  level endon("traps_defused_laser_sentry_defuse_mines_3");

  while(!isDefined(level._id_B3A61E1FD4CE7D8A))
    wait 1;

  while(level._id_B3A61E1FD4CE7D8A == 3) {
    level waittill("resetting_mine");
    wait 3;

    if(!istrue(level._id_8D94D70ECA218CAA))
      level thread _id_9CF00B1AC3E4BD94();
  }
}

_id_9CF00B1AC3E4BD94() {
  level endon("game_ended");
  level endon("resetting_mine");

  if(getdvarint("dvar_F0F10B52A800D290", 0) <= 0) {
    level waittill("laser_section_ai_laser_section_2", ai);
    wait 3;

    while(getaiarray("axis").size > 0)
      wait 4;
  } else
    wait 5;

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_mnsc_pric_fuckssakewiththesela", 0.1);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_mnsc_alex_yourbrotherreallylik", 0.1);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_mnsc_fara_theycouldnthavesetal", 0.1);
  wait 0.6;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_mnsc_pric_theysetallthesetraps", 0.1);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_mnsc_alex_ifhadirsmovingthewar", 0.1);
  wait 0.6;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_mnsc_pric_ireckonwereinitmate", 0.1);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_mnsc_fara_thesetunnels", 0.1);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_mnsc_fara_themissilesthegasthe", 0.1);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_mnsc_alex_butmovingemtowhere", 0.1);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_mnsc_pric_somewherewedontwanta", 0.1);
  level._id_8D94D70ECA218CAA = 1;
}

_id_C8C288A7C1DFE14C() {
  level endon("game_ended");
  level waittill("traps_defused_laser_sentry_defuse_mines_2");
  marker = scripts\engine\utility::getStruct("vo_mine_spinning_lasers", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_F3C414CE5CCAB845(marker, 0.6, 1)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_wehavetofindawayacro", "dx_cp_cpr4_mnsc_pric_wellthislookslikefun", "dx_cp_cpr4_mnsc_alex_greatmorelasers"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_EBEA0544FD77DFA0() {
  level endon("game_ended");
  level waittill("laser_section_ai_laser_section_3", ai);

  if(!isai(ai)) {
    return;
  }
  ai endon("death");
  ai waittill("weapon_fired");
  _id_B49ED71941CDDF48 = ["dx_cp_cpr4_mnsc_fara_theyreontheledgeacro", "dx_cp_cpr4_mnsc_pric_shootersacrosstheway", "dx_cp_cpr4_mnsc_alex_wegotcompanytheyreon"];
  _id_DE03CF7D07ED4542 = ["dx_cp_cpr4_mnsc_fara_takethemout", "dx_cp_cpr4_mnsc_pric_ineedcovertogetacros", "dx_cp_cpr4_mnsc_alex_ineedcover"];
  players = scripts\engine\utility::create_deck(scripts\engine\utility::array_randomize(level.players));
  _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();

  if(abs(ai.origin[2] - _id_137CC0FFDF383E20.origin[2]) >= 100)
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, _id_B49ED71941CDDF48, 0.1);
  else
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, _id_B49ED71941CDDF48, 0.1);
}

_id_0957A45A064F939C() {
  level endon("game_ended");
  level endon("traps_defused_laser_sentry_defuse_mines_3");
  _id_8831727CF86C30A0 = scripts\engine\utility::getStructArray("vo_mine_second_tall_wall", "script_noteworthy");
  _id_5243F9D30EA0788A = [];

  foreach(marker in _id_8831727CF86C30A0)
  _id_5243F9D30EA0788A[_id_5243F9D30EA0788A.size] = marker.origin;

  player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(_id_5243F9D30EA0788A, 64, undefined, 0)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_quickwehavetofindawa", "dx_cp_cpr4_mnsc_pric_wereexposedherefinda", "dx_cp_cpr4_mnsc_alex_werecompromisedherel"];

  if(!istrue(level._id_30EF2F87C8F78B22))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_B795EF81F3483AA5() {
  level endon("game_ended");
  doors = scripts\engine\utility::getStruct("vo_mine_shut_door", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_F3C414CE5CCAB845(doors, 0.8, 2, 0, [], 128)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_theyreprotectingsome", "dx_cp_cpr4_mnsc_pric_aqsguardinsomethinin", "dx_cp_cpr4_mnsc_alex_mustbesomethininther"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_72577FEF5A72936B() {
  level endon("game_ended");
  _id_B882D7790A69375C = scripts\engine\utility::getStruct("vo_mine_third_beams_height", "script_noteworthy");
  _id_68C8BD68F38332B7 = getEnt("vo_trigger_mine_exit_3", "script_noteworthy");
  level thread _id_AF01AB9EF8AA52DE(_id_68C8BD68F38332B7);

  foreach(player in level.players)
  player thread _id_0CC4BF5D45369BF4(_id_B882D7790A69375C, _id_68C8BD68F38332B7);
}

_id_AF01AB9EF8AA52DE(_id_68C8BD68F38332B7) {
  level endon("game_ended");
  level endon("all_players_have_crossed");
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(40, 60, 3);
  _id_890F3151247E07DB = [];
  level thread _id_CC52262CF22AB5CE(_id_68C8BD68F38332B7);

  for(;;) {
    _id_890F3151247E07DB = [];

    foreach(player in level.players) {
      if(player istouching(_id_68C8BD68F38332B7))
        _id_890F3151247E07DB = scripts\engine\utility::array_add(_id_890F3151247E07DB, player);
    }

    if(_id_890F3151247E07DB.size <= 0 || _id_890F3151247E07DB.size >= level.players.size) {
      wait 1;
      continue;
    }

    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_fara_jumpitstheonlyway", "dx_cp_cpr4_mnsc_fara_youhavetomakeit"]);
    _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_pric_yougotthis", "dx_cp_cpr4_mnsc_pric_yougottajumpforit"]);
    _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_alex_jump", "dx_cp_cpr4_mnsc_alex_yougottagoforit"]);
    aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
    players = scripts\engine\utility::create_deck(_id_890F3151247E07DB);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(players scripts\engine\utility::deck_draw(), aliases);
  }
}

_id_CC52262CF22AB5CE(_id_68C8BD68F38332B7) {
  level endon("game_ended");

  for(;;) {
    _id_890F3151247E07DB = [];

    foreach(player in level.players) {
      if(player istouching(_id_68C8BD68F38332B7))
        _id_890F3151247E07DB = scripts\engine\utility::array_add(_id_890F3151247E07DB, player);
    }

    if(_id_890F3151247E07DB.size >= level.players.size) {
      aliases = ["dx_cp_cpr4_mnsc_fara_goodworkletskeepmovi", "dx_cp_cpr4_mnsc_pric_nicelydoneletskeepat", "dx_cp_cpr4_mnsc_alex_hellyeahletskeeppush"];
      players = scripts\engine\utility::create_deck(_id_890F3151247E07DB);
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(players scripts\engine\utility::deck_draw(), aliases);
      level notify("all_players_have_crossed");
      return;
    }

    wait 2;
  }
}

_id_28344ACE14649803() {
  level endon("game_ended");
  level endon("3man_door_laser_3_door_open");
  level waittill("all_players_have_crossed");
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(40, 60, 3);

  for(;;) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_fara_herethroughthisgate", "dx_cp_cpr4_mnsc_fara_weneedtomovetogether"]);
    _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_pric_stackonthisgate", "dx_cp_cpr4_mnsc_pric_whenwemovewemovetoge"]);
    _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_alex_onthegatehere", "dx_cp_cpr4_mnsc_alex_wegottasticktogether"]);
    aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
    players = scripts\engine\utility::create_deck(scripts\engine\utility::array_randomize(level.players));
    player = players scripts\engine\utility::deck_draw();
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
  }
}

_id_0CC4BF5D45369BF4(_id_B882D7790A69375C, _id_68C8BD68F38332B7) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("reached_final_laser_exit");
  _id_62E11D77B25C1D30::_id_F28ADB32E474B426(_id_B882D7790A69375C.origin[2], [self]);
  wait 2;
  _id_62E11D77B25C1D30::_id_B826409EE2EFF7B6(_id_B882D7790A69375C.origin[2], self);
  aliases = ["dx_cp_cpr4_mnsc_fara_usethebeams", "dx_cp_cpr4_mnsc_pric_weresafeuponthebeams", "dx_cp_cpr4_mnsc_alex_getonthebeams"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(self, aliases);
  thread _id_AA9B363DD5388F6E(_id_68C8BD68F38332B7);
}

_id_AA9B363DD5388F6E(_id_68C8BD68F38332B7) {
  level endon("game_ended");

  for(;;) {
    _id_68C8BD68F38332B7 waittill("trigger", player);

    if(player == self) {
      break;
    }
  }

  if(getaiarray("axis").size > 0)
    aliases = ["dx_cp_cpr4_mnsc_fara_madeitacross", "dx_cp_cpr4_mnsc_pric_imacross", "dx_cp_cpr4_mnsc_alex_igotacross"];
  else
    aliases = ["dx_cp_cpr4_mnsc_fara_imacross", "dx_cp_cpr4_mnsc_pric_thatwasntsobad", "dx_cp_cpr4_mnsc_alex_ihopethatsthelastoft"];

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(self, aliases);
  wait 0.5;

  if(!istrue(level._id_30EF2F87C8F78B22)) {
    level._id_30EF2F87C8F78B22 = 1;
    aliases = ["dx_cp_cpr4_mnsc_fara_wecanjumpacrossfromt", "dx_cp_cpr4_mnsc_pric_usethatbeamtojumpacr", "dx_cp_cpr4_mnsc_alex_madethejumpfromthatb"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(self, aliases);
  }

  self notify("reached_final_laser_exit");
}

_id_4E30F16753F98B71() {
  while(!isDefined(level._id_B3A61E1FD4CE7D8A) || level._id_B3A61E1FD4CE7D8A < 4)
    wait 1;

  level thread _id_09EBF1340BE85AAC();
  level thread _id_DADCB70F62C54105();
  level thread _id_BE4AD1EE5CD754B7();
  level thread _id_C0226BE37ACF0A24();
  level thread _id_D23CDA248FEE6AFB();
}

_id_09EBF1340BE85AAC() {
  level endon("game_ended");
  level waittill("laser_section_ai_laser_section_4", ai);

  if(!isai(ai)) {
    return;
  }
  ai scripts\engine\utility::waittill_any_2("damage", "weapon_fired");
  aliases = ["dx_cp_cpr4_mnsc_fara_takingcontacttheyveg", "dx_cp_cpr4_mnsc_pric_contacttheygotshield", "dx_cp_cpr4_mnsc_alex_aqtheygotriotshields"];
  players = scripts\engine\utility::create_deck(scripts\engine\utility::array_randomize(level.players));
  player = players scripts\engine\utility::deck_draw();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);

  while(getaiarray("axis").size > 2)
    wait 1;

  _id_05E49FF3F240A8E2 = (-1084.39, 10481, -4081.25);
  _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(_id_05E49FF3F240A8E2, 400);
  aliases = ["dx_cp_cpr4_mnsc_fara_weregettingclose", "dx_cp_cpr4_mnsc_pric_aqssteppinuptheirdef", "dx_cp_cpr4_mnsc_alex_theyrebringininthehe"];
  player = players scripts\engine\utility::deck_draw();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
  level thread _id_E7EFDE304D07322C();
}

_id_A3AF0FB0C531F33E() {
  level endon("game_ended");
  level waittill("traps_defused_laser_sentry_defuse_mines");
  wait 3;
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_mnsc_pric_aqsgotenoughmunition", 0.5);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_mnsc_alex_andthisnukeishowhadi", 0.2);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_mnsc_fara_tohellwithhisplans", 0.3);
}

_id_E7EFDE304D07322C() {
  level endon("game_ended");
  level endon("3man_door_laser_4_door_open");
  level endon("jugg_maze_objective_started");
  level endon("twoman_door_open");
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(50, 70, 3);
  _id_B7C21B0B9F4D7AE8 = scripts\engine\utility::getStruct("vo_mine_missile_tunnel_end", "script_noteworthy");

  for(;;) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    players = scripts\engine\utility::create_deck(level.players);
    _id_137CC0FFDF383E20 = players scripts\engine\utility::deck_draw();

    if(distance2d(_id_137CC0FFDF383E20.origin, _id_B7C21B0B9F4D7AE8.origin) <= 400) {
      aliases = ["dx_cp_cpr4_mnsc_fara_thisisnttheway", "dx_cp_cpr4_mnsc_pric_nothinthisway", "dx_cp_cpr4_mnsc_alex_deadend"];
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.4, 0, 1);
      continue;
    }

    _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_fara_thiswaythetracks", "dx_cp_cpr4_mnsc_fara_theremustbeawayoutof"]);
    _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_pric_followthetracks", "dx_cp_cpr4_mnsc_pric_findawayouttathesetu"]);
    _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_alex_theresgottabeanother_01", "dx_cp_cpr4_mnsc_alex_keepfollowingthetrac"]);
    aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_137CC0FFDF383E20, aliases, 0.4, 0, 1);
  }
}

_id_DADCB70F62C54105() {
  level endon("game_ended");
  level endon("3man_door_laser_4_door_open");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr4_mnsc_aqs4_brotherscomein";
  aliases[aliases.size] = "dx_cp_cpr4_mnsc_aqs4_doyoucopy";
  aliases[aliases.size] = "dx_cp_cpr4_mnsc_aqs3_theycantallbedead";
  aliases[aliases.size] = "dx_cp_cpr4_mnsc_aqs4_justholdyourpostbere";
  _id_421681406E479DAF = scripts\engine\utility::getStruct("vo_mine_missile_tunnel_door", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(_id_421681406E479DAF.origin, 300)[0];
  _id_1A053B84F208B832 = (-1218.7, 8821, -3693.25);
  ai = sortbydistance(getaiarray(), _id_1A053B84F208B832);

  if(ai.size > 0) {
    ai[0] endon("Death");

    foreach(alias in aliases)
    ai[0] _id_5D265B4FCA61F070::say(alias, 0.4);
  }

  aliases = ["dx_cp_cpr4_mnsc_fara_ihearthemothersideof", "dx_cp_cpr4_mnsc_pric_stackonthisdoorihear", "dx_cp_cpr4_mnsc_alex_gotsomethinontheothe"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_BE4AD1EE5CD754B7() {
  level endon("game_ended");
  marker = scripts\engine\utility::getStruct("vo_mine_missile_tracks_end", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(marker.origin, 0.9, 2, 0, [], 100);
  aliases = ["dx_cp_cpr4_mnsc_fara_theresnowheretogoher", "dx_cp_cpr4_mnsc_pric_endofthelinehere", "dx_cp_cpr4_mnsc_alex_tracksarenohelpanymo"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_C0226BE37ACF0A24() {
  level endon("game_ended");
  marker = scripts\engine\utility::getStruct("vo_mine_vent_locked_door", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(marker.origin, 0.9, 1, 0, [], 100);
  aliases = ["dx_cp_cpr4_mnsc_fara_doorslockedsearchfor", "dx_cp_cpr4_mnsc_pric_doorslockedfindanoth", "dx_cp_cpr4_mnsc_alex_doorslocked"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_D23CDA248FEE6AFB() {
  level endon("game_ended");
  marker = scripts\engine\utility::getStruct("vo_mine_lasers_vent", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(marker.origin, 0.8, 0.4, 0, [], 200)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_letstrythisairduct", "dx_cp_cpr4_mnsc_pric_foundanairduct", "dx_cp_cpr4_mnsc_alex_thisairductcouldlead"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, undefined, undefined, 2);
}

_id_68BDB72143BB5407() {
  level endon("game_ended");
  level childthread _id_1C87C0CDFA9E6E7A();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("door", ::_id_5B509B8F0FAD02F2);
  level childthread _id_9ECED48C2EDB1D62();
  level childthread _id_7DC3F8B26AE1B09E();
  level childthread _id_7488E360A0F1CF7F();
  level childthread _id_8B98A410CEE24BAF();
  level childthread _id_CC928475F8A858B3();
  level childthread _id_81B4A15ED1CDA973();
  level childthread _id_9A7C1D574735376C();
  level childthread _id_B1E3CDFB76C716B6();
  level childthread _id_744847B146C67E52();
  level childthread _id_C600CB75740C3864();
  level childthread _id_BB50F39C46D90DA7();
  level childthread _id_0F34DDDB11BE4591();
  level childthread _id_C71E7966B6EC9B3A();
  level childthread _id_CECE010D21A1327D();
}

_id_1C87C0CDFA9E6E7A() {
  level endon("clean_vo_juggMaze_fireNotice");
  level endon("progress_level");
  _id_60B16CB263834231 = (-887, 8398.5, -3731.5);
  _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(_id_60B16CB263834231, 200);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_mnsc_fara_hadirsslowingusdownt", 0.6);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_mnsc_alex_wereflushinghimoutwe", 0.4);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_mnsc_pric_wetoldkyletomakecont", 0.4);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_mnsc_fara_letsfinishours", 0.2);
  childthread _id_51C59808AF7DE61F();
}

_id_51C59808AF7DE61F() {
  _id_41576170767BBA05 = (-445, 8578, -3832);

  for(_id_9CF446F53DD57DFE = getEnt("screen_guy", "script_noteworthy"); !isDefined(_id_9CF446F53DD57DFE); _id_9CF446F53DD57DFE = getEnt("screen_guy", "script_noteworthy"))
    wait 1;

  while(!scripts\cp\utility::any_player_nearby(_id_9CF446F53DD57DFE.origin, squared(450)))
    wait 1;

  if(!isalive(_id_9CF446F53DD57DFE)) {
    return;
  }
  _id_9CF446F53DD57DFE _id_5D265B4FCA61F070::say("dx_cp_cpr4_mnsc_aqs2_youreclearintherethe");
  _id_9CF446F53DD57DFE childthread _id_0839EE245333F0DB();
  _id_9CF446F53DD57DFE childthread _id_C3C556F336A2F74E();
  wait 1;
  aliases = ["dx_cp_cpr4_mnsc_fara_quietihearsomething", "dx_cp_cpr4_mnsc_pric_ihearsomethinahead", "dx_cp_cpr4_mnsc_alex_gotsomethinahead"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_41576170767BBA05);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_0839EE245333F0DB() {
  self endon("death");
  scripts\engine\utility::waittill_any_2("stealth_update_investigate", "stealth_investigate");
  _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.25, "dx_cp_cpr4_mnsc_aqs2_fuck");
}

_id_C3C556F336A2F74E() {
  _id_41576170767BBA05 = (-445, 8578, -3832);
  self waittill("death");
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_41576170767BBA05);
  aliases = ["dx_cp_cpr4_mnsc_fara_theroomissecure", "dx_cp_cpr4_mnsc_pric_werecleardownhere", "dx_cp_cpr4_mnsc_alex_roomsclear"];
  wait 2;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_5B509B8F0FAD02F2(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!instance _meth_FAC544C98A3D9EB4()) {
    return;
  }
  if(isDefined(level._id_EFC52CD1B2F9C2A6) && gettime() - 10000 < level._id_EFC52CD1B2F9C2A6) {
    return;
  }
  level._id_EFC52CD1B2F9C2A6 = gettime();
  _id_D41BA9550737CE52 = (-523.5, 9016.5, -3821.5);

  if(distance(instance.origin, _id_D41BA9550737CE52) > 100) {
    return;
  }
  level thread _id_4D0DA62950E0538B(player);
}

_id_4D0DA62950E0538B(player) {
  player endon("disconnect");

  if(level.players.size > 1) {
    _id_6EE5484560EC747C = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(player.origin, player);

    if(isDefined(_id_6EE5484560EC747C) && distance(_id_6EE5484560EC747C.origin, player.origin) > 1000)
      return;
  }

  wait 0.5;

  if(scripts\engine\utility::cointoss())
    aliases = ["dx_cp_cpr4_mnsc_fara_doorslockeditwontope", "dx_cp_cpr4_mnsc_pric_thisdoorslocked", "dx_cp_cpr4_mnsc_alex_noluckonthisdooritsl"];
  else
    aliases = ["dx_cp_cpr4_mnsc_fara_locked", "dx_cp_cpr4_mnsc_pric_locked", "dx_cp_cpr4_mnsc_alex_doorslocked_01"];

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_9ECED48C2EDB1D62() {
  level endon("clean_vo_juggMaze_valveNotice");
  _id_EBA9F091760275B2 = (-181.5, 8592, -3781.5);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_EBA9F091760275B2, 0.5, 0.2, 0, undefined, 65)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_theresavalvehere", "dx_cp_cpr4_mnsc_pric_gotavalvehere", "dx_cp_cpr4_mnsc_alex_theressomekindavalve"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, undefined, undefined, 0.5);
  targetname = "intro_fire_valve";
  level waittill(targetname + "_valve_activate_end");
  aliases = ["dx_cp_cpr4_mnsc_fara_doesntseemtocontrola", "dx_cp_cpr4_mnsc_pric_mustcontrolsomething", "dx_cp_cpr4_mnsc_alex_whateveritdoesitdoes"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_EBA9F091760275B2);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, undefined, 1.5);
}

_id_7DC3F8B26AE1B09E() {
  origin = (-285.5, 8327.5, -3762);
  radius = 140;
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(origin, 0.6, 0.3, 0, undefined, radius)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_foundasurveillancesc", "dx_cp_cpr4_mnsc_pric_itsasurveillancescre", "dx_cp_cpr4_mnsc_alex_gotasurveillancescre"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
  wait 1;
  aliases = ["dx_cp_cpr4_mnsc_fara_lookslikethisisusupt", "dx_cp_cpr4_mnsc_pric_wemustbetheblueupint", "dx_cp_cpr4_mnsc_alex_lookslikethatsusatth"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
  wait 0.6;
  _id_52A463A16496D1CA = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(origin, player);

  if(!isDefined(_id_52A463A16496D1CA))
    _id_52A463A16496D1CA = player;

  aliases = ["dx_cp_cpr4_mnsc_fara_itmightbehadir", "dx_cp_cpr4_mnsc_pric_thathvtmightbehadir", "dx_cp_cpr4_mnsc_alex_couldbehadir"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_52A463A16496D1CA, aliases);
  wait 2;
  aliases = ["dx_cp_cpr4_mnsc_fara_someoneneedstostayhe", "dx_cp_cpr4_mnsc_pric_weneedsomeonetostayo", "dx_cp_cpr4_mnsc_alex_someoneshouldhangbac"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_52A463A16496D1CA, aliases, undefined, undefined, 2);
  childthread _id_003CB8F27EEF4610();
}

_id_003CB8F27EEF4610() {
  level endon("vo_juggmaze_door_notice");
  level endon("vo_juggmaze_door_open");
  level endon("twoman_door_open");
  wait 8;
  _id_0192B2B32B848071 = _id_4BB23F70102CF6BC::_id_B34C6E374DF9C4A1();

  if(_id_0192B2B32B848071.size > 0) {
    return;
  }
  origin = (-372.5, 8326, -3750.5);
  radius = squared(400);

  while(scripts\cp\utility::any_player_nearby(origin, radius))
    wait 0.5;

  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(origin);
  aliases = ["dx_cp_cpr4_mnsc_fara_lookforawaypastthatw", "dx_cp_cpr4_mnsc_pric_findawaytoothersideo", "dx_cp_cpr4_mnsc_alex_weneedtogetontheothe"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_7488E360A0F1CF7F() {
  level endon("vo_juggmaze_doorbutton_notice");
  aliases = ["dx_cp_cpr4_mnsc_fara_lookforawaytoopenthi", "dx_cp_cpr4_mnsc_pric_findawaytoopenthisdo", "dx_cp_cpr4_mnsc_alex_weneedtofindawaytoop"];
  origin = (-185, 8326, -3777);
  radius = 150;
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(origin, 0.7, 0.15, 0, undefined, radius)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
  level notify("vo_juggmaze_door_notice");
}

_id_8B98A410CEE24BAF() {
  level endon("jugg_maze_keycard_success");
  aliases = ["dx_cp_cpr4_mnsc_fara_herethisbutton", "dx_cp_cpr4_mnsc_pric_foundabuttonhere", "dx_cp_cpr4_mnsc_alex_thisbuttonmightopeni"];
  origin = (-215, 8326, -3766);
  radius = 70;
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(origin, 0.8, 0.5, 0, undefined, radius)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, undefined, undefined, 2);
  level notify("vo_juggmaze_doorbutton_notice");
  level waittill("twoman_door_open", door);
  wait 0.2;
  aliases = ["dx_cp_cpr4_mnsc_fara_doorsopen", "dx_cp_cpr4_mnsc_pric_doorsopengo", "dx_cp_cpr4_mnsc_alex_doorsup"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(origin);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1);
  level notify("vo_juggmaze_door_open");
  _id_5CE9E969443CD568 = (-359, 8694.5, -3825);
  _id_4D91EE4A821ED70C = 380;
  _id_049535AC9E06A60B = 0;
  _id_C7B06DD265A7C0CD = 0;

  while(!_id_049535AC9E06A60B || !_id_C7B06DD265A7C0CD) {
    level waittill("twoman_door_close", door);
    _id_590B7EAEB04EC24D = 0;

    foreach(player in level.players) {
      if(distance2d(player.origin, _id_5CE9E969443CD568) <= _id_4D91EE4A821ED70C)
        _id_590B7EAEB04EC24D++;
    }

    if(_id_590B7EAEB04EC24D == 3) {
      aliases = ["dx_cp_cpr4_mnsc_fara_someoneneedstoholdth", "dx_cp_cpr4_mnsc_pric_lookslikesomeonesgon", "dx_cp_cpr4_mnsc_alex_shitsomeonesgonnanee"];
      player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(door.origin);
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.7);
      _id_C7B06DD265A7C0CD = 1;
      continue;
    }

    if(_id_590B7EAEB04EC24D == 2) {
      aliases = ["dx_cp_cpr4_mnsc_fara_weneedtwoofusouthere", "dx_cp_cpr4_mnsc_pric_onlyneedoneonthescre", "dx_cp_cpr4_mnsc_alex_wellneednumbersouthe"];
      player = _id_62E11D77B25C1D30::_id_D63542EBC6F90151(_id_5CE9E969443CD568);
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
      _id_049535AC9E06A60B = 1;
    }
  }
}

_id_1E16AD0C22F49D61() {
  _id_544A7D3AEC2CF651 = getEnt("intro_fire_valve", "targetname");

  while(!isDefined(_id_544A7D3AEC2CF651)) {
    _id_544A7D3AEC2CF651 = getEnt("intro_fire_valve", "targetname");
    wait 1;
  }

  return _id_544A7D3AEC2CF651;
}

_id_CC928475F8A858B3() {
  _id_544A7D3AEC2CF651 = _id_1E16AD0C22F49D61();
  childthread _id_5D8657FD56D77981();
  childthread _id_642152809DA50F25();
  childthread _id_B34F2DFD95423DF9();
  _id_66B8505E36A0E0DA = _id_544A7D3AEC2CF651._id_3AD974EE99198ECC;

  for(;;) {
    foreach(_id_9C70BE53D55AC5CD in _id_66B8505E36A0E0DA) {
      if(!istrue(self._id_ED513444FC7D1C23))
        _id_9C70BE53D55AC5CD childthread _id_ED513444FC7D1C23();
    }

    wait 1;
  }
}

_id_ED513444FC7D1C23() {
  if(istrue(self._id_ED513444FC7D1C23)) {
    return;
  }
  self._id_ED513444FC7D1C23 = 1;
  _id_636C8575D7A7768B = 190;
  _id_4F0FC1C36324AFFB = squared(_id_636C8575D7A7768B);
  _id_87ECE664C97872A7 = 300;
  _id_302CD570BF97C157 = squared(_id_87ECE664C97872A7);
  targetname = "intro_fire_valve";
  _id_4E97FDF06B12635C = targetname + "_valve_activate_start";
  _id_D42F6D2527D6059C = 20;
  _id_7F0DB1B965A0AD80 = 5;
  _id_DB8D8FDD81F23AEC = 9;
  _id_9F04C8EAF5DAA2CA = 14;
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(self.origin, 0.4, 0.05, 0, undefined, _id_636C8575D7A7768B)[0];
  level notify("clean_vo_juggMaze_valveNotice");

  if(_id_1F02B7CD1FD760C6()) {
    wait(_id_7F0DB1B965A0AD80);
    self._id_ED513444FC7D1C23 = undefined;
    return;
  }

  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(self.origin);
  level notify("vo_juggMaze_fireNotice_first", player);
  result = scripts\engine\utility::waittill_any_ents_or_timeout_return(_id_DB8D8FDD81F23AEC, level, _id_4E97FDF06B12635C);

  if(result == _id_4E97FDF06B12635C) {
    if(scripts\cp\utility::any_player_nearby(self.origin, _id_4F0FC1C36324AFFB)) {
      player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(self.origin);
      level notify("vo_juggMaze_fireNotice_fixed", player);
    }

    wait(_id_D42F6D2527D6059C);
    self._id_ED513444FC7D1C23 = undefined;
    return;
  }

  while(!scripts\cp\utility::any_player_nearby(self.origin, _id_4F0FC1C36324AFFB))
    wait 0.1;

  if(_id_1F02B7CD1FD760C6()) {
    wait(_id_7F0DB1B965A0AD80);
    self._id_ED513444FC7D1C23 = undefined;
    return;
  }

  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(self.origin);
  childthread _id_7CEBECE4B67431F7(player);
  result = scripts\engine\utility::waittill_any_ents_or_timeout_return(_id_9F04C8EAF5DAA2CA, level, _id_4E97FDF06B12635C);

  if(result == _id_4E97FDF06B12635C) {
    if(scripts\cp\utility::any_player_nearby(self.origin, _id_4F0FC1C36324AFFB)) {
      player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(self.origin);
      level notify("vo_juggMaze_fireNotice_fixed", player);
    }

    wait(_id_D42F6D2527D6059C);
    self._id_ED513444FC7D1C23 = undefined;
    return;
  }

  while(!scripts\cp\utility::any_player_nearby(self.origin, _id_4F0FC1C36324AFFB))
    wait 0.1;

  if(_id_1F02B7CD1FD760C6()) {
    wait(_id_7F0DB1B965A0AD80);
    self._id_ED513444FC7D1C23 = undefined;
    return;
  }

  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(self.origin);
  childthread _id_B53086B9685B36F1(player);
  level waittill(_id_4E97FDF06B12635C);

  if(scripts\cp\utility::any_player_nearby(self.origin, _id_302CD570BF97C157)) {
    player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(self.origin);
    level notify("vo_juggMaze_fireNotice_fixed", player);
  }

  wait(_id_D42F6D2527D6059C);
  self._id_ED513444FC7D1C23 = undefined;
}

_id_1F02B7CD1FD760C6() {
  _id_02A3020BBFE5BDC1 = 3000;
  return isDefined(level._id_DEAE2DABCFC21C07) && gettime() - _id_02A3020BBFE5BDC1 < level._id_DEAE2DABCFC21C07;
}

_id_5D8657FD56D77981() {
  level endon("clean_vo_juggMaze_fireNotice");
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_fara_theresfireherewecant", "dx_cp_cpr4_trnf_fara_gotfireherewecantget"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_pric_firesblockingus", "dx_cp_cpr4_trnf_pric_theresfireblockingus"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_alex_gotfireblockinus", "dx_cp_cpr4_trnf_alex_firescuttinusoff"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];

  for(;;) {
    level waittill("vo_juggMaze_fireNotice_first", player);

    if(_id_1F02B7CD1FD760C6()) {
      continue;
    }
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, undefined, 1.5);
  }
}

_id_7CEBECE4B67431F7(player) {
  aliases = ["dx_cp_cpr4_trnf_fara_fireiscomingfromaval", "dx_cp_cpr4_trnf_pric_lookslikeitscominfro", "dx_cp_cpr4_trnf_alex_firescominoutofagasv"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, undefined, 3);
}

_id_B53086B9685B36F1(player) {
  aliases = ["dx_cp_cpr4_trnf_fara_findavalvetoturnthef", "dx_cp_cpr4_trnf_pric_findavalvetokilltheg", "dx_cp_cpr4_trnf_alex_findavalveseeifyouca"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, undefined, 1.5);
}

_id_642152809DA50F25() {
  level endon("clean_vo_juggMaze_fireNotice");
  _id_EBA9F091760275B2 = (-181.5, 8592, -3781.5);
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_fara_imturningthevalve", "dx_cp_cpr4_trnf_fara_imonthevalve"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_pric_imonthevalve", "dx_cp_cpr4_trnf_pric_turninthevalve"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_alex_workinthevalve", "dx_cp_cpr4_trnf_alex_turningthevalve"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  targetname = "intro_fire_valve";

  for(;;) {
    level waittill(targetname + "_valve_activate_start", player);

    if(!isDefined(player))
      player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_EBA9F091760275B2);

    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, undefined, undefined, 2.5);
    level._id_DEAE2DABCFC21C07 = gettime();
  }
}

_id_B34F2DFD95423DF9() {
  level endon("clean_vo_juggMaze_fireNotice");
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_fara_thatworked", "dx_cp_cpr4_trnf_fara_goodworkfiresout"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_pric_thatdidit", "dx_cp_cpr4_trnf_pric_firesoutwereclear"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_alex_nicethatworked", "dx_cp_cpr4_trnf_alex_firesdeadthanks"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];

  for(;;) {
    level waittill("vo_juggMaze_fireNotice_fixed", player);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 4, undefined, 2);
  }
}

_id_81B4A15ED1CDA973() {
  _id_405885D1BA1F2152 = (-285.5, 8327.5, -3762);
  _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(_id_405885D1BA1F2152, 500);
  cooldown = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(30, 90, 3);
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_fara_wecanhideinthevents", "dx_cp_cpr4_trnf_fara_foundavent"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_pric_wecangetinthevents", "dx_cp_cpr4_trnf_pric_takingcoverinavent"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_alex_wecancrawlinthevents", "dx_cp_cpr4_trnf_alex_foundaventhere"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  _id_B0DFD912BE32D040 = undefined;

  for(;;) {
    _id_82106BB7416E62D0 = undefined;

    foreach(player in level.players) {
      if(isDefined(_id_82106BB7416E62D0)) {
        continue;
      }
      if(isDefined(_id_B0DFD912BE32D040) && _id_B0DFD912BE32D040 == player) {
        continue;
      }
      if(isDefined(_id_B0DFD912BE32D040) && distance(_id_B0DFD912BE32D040.origin, player.origin) < 600) {
        continue;
      }
      if(istrue(player._id_217C1AF507AA009E)) {
        _id_82106BB7416E62D0 = player;
        _id_B0DFD912BE32D040 = _id_82106BB7416E62D0;
      }
    }

    if(isDefined(_id_82106BB7416E62D0)) {
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_82106BB7416E62D0, aliases, 0.8, undefined, 2.5);
      _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(cooldown);
    }

    wait 0.5;
  }
}

_id_9A7C1D574735376C() {
  level endon("vo_juggMaze_keycard_jugglookat");
  _id_405885D1BA1F2152 = (-285.5, 8327.5, -3762);
  _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(_id_405885D1BA1F2152, 250);
  wait 1;
  radius = 1000;
  _id_593659CC7685B307 = [];

  while(_id_593659CC7685B307.size < 6) {
    _id_593659CC7685B307 = [];
    _id_FC9AC45209F959BB = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC9AC45209F959BB.size; _id_AC0E594AC96AA3A8++) {
      if(_id_FC9AC45209F959BB[_id_AC0E594AC96AA3A8] _id_18A73A64992DD07D::is_specified_unittype("juggernaut"))
        _id_593659CC7685B307[_id_593659CC7685B307.size] = _id_FC9AC45209F959BB[_id_AC0E594AC96AA3A8];
    }

    wait 3;
  }

  level notify("vo_juggMaze_spot_juggs_spawned");
  aliases = ["dx_cp_cpr4_trnf_fara_thatmonitorstracking", "dx_cp_cpr4_trnf_pric_bollocksthosereddots", "dx_cp_cpr4_trnf_alex_thatsabigfucker"];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_593659CC7685B307, 0.7, 0.2, 0, undefined, radius)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5, 1);
}

_id_B1E3CDFB76C716B6() {
  level endon("vo_juggMaze_core_complete");
  level waittill("vo_juggMaze_spot_juggs_spawned");
  level waittill("vo_juggmaze_door_open");
  _id_405885D1BA1F2152 = (-285.5, 8327.5, -3762);
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_fara_breakcontactyourepul", "dx_cp_cpr4_trnf_fara_therestoomanyyouneed", "dx_cp_cpr4_trnf_fara_breakcontact", "dx_cp_cpr4_trnf_fara_youneedtogetoutofthe"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_pric_breakcontactbreakcon", "dx_cp_cpr4_trnf_pric_breakcontact", "dx_cp_cpr4_trnf_pric_yougottaloseem"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_alex_shityougottabreakcon", "dx_cp_cpr4_trnf_alex_yougottagetouttather", "dx_cp_cpr4_trnf_alex_breakcontactandgetou", "dx_cp_cpr4_trnf_alex_youcanttakeemallyoun"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];

  for(;;) {
    while(_func_EAC0CD99C9C6D8EE() != "spotted" && !_id_201F7AA662D9FBC7())
      wait 0.15;

    _id_13080A3FDAE172B0 = isDefined(level._id_6E6C8E9CA9C42A38) && scripts\cp\utility::any_player_nearby(level._id_6E6C8E9CA9C42A38.origin, squared(800));

    if(scripts\cp\utility::any_player_nearby(_id_405885D1BA1F2152, squared(200)) && !_id_13080A3FDAE172B0) {
      player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_405885D1BA1F2152);
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 2, undefined, 4);
      wait 5;
    }

    while(_func_EAC0CD99C9C6D8EE() == "spotted" && !_id_2AA470F927718B0F())
      wait 0.2;

    wait 5;
    _id_8F54376DE3F7E149 = 0;
    player = _id_62E11D77B25C1D30::_id_D63542EBC6F90151(_id_405885D1BA1F2152);
    _id_9FE695F1B9641AB9 = isDefined(level._id_11FB171004EF0124) && scripts\engine\utility::time_has_passed(level._id_11FB171004EF0124, 20);

    if(istrue(player._id_217C1AF507AA009E) && !_id_0AFB7E332AEE4BF2::player_in_laststand(player) && !isDefined(player.dogtag) && !_id_9FE695F1B9641AB9) {
      aliases = ["dx_cp_cpr4_trnf_fara_wherearetheyarewecle", "dx_cp_cpr4_trnf_pric_oyeweclear", "dx_cp_cpr4_trnf_alex_theygone"];
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);
      _id_8F54376DE3F7E149 = 1;
      level._id_11FB171004EF0124 = gettime();
    }

    if(_id_8F54376DE3F7E149 && istrue(player._id_217C1AF507AA009E)) {
      aliases = ["dx_cp_cpr4_trnf_fara_youlostthem", "dx_cp_cpr4_trnf_pric_theyregoneyoureclear", "dx_cp_cpr4_trnf_alex_theylostya"];

      if(scripts\cp\utility::any_player_nearby(_id_405885D1BA1F2152, squared(200))) {
        player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_405885D1BA1F2152);
        _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 1.5, undefined, 2.5);
      }
    }

    wait 10;
  }
}

_id_2AA470F927718B0F() {
  radius = 200;
  _id_593659CC7685B307 = [];
  _id_FC9AC45209F959BB = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC9AC45209F959BB.size; _id_AC0E594AC96AA3A8++) {
    if(_id_FC9AC45209F959BB[_id_AC0E594AC96AA3A8] _id_18A73A64992DD07D::is_specified_unittype("juggernaut"))
      _id_593659CC7685B307[_id_593659CC7685B307.size] = _id_FC9AC45209F959BB[_id_AC0E594AC96AA3A8];
  }

  foreach(player in level.players) {
    foreach(_id_E21279FA90BDF012 in _id_593659CC7685B307) {
      if(distance(_id_E21279FA90BDF012.origin, player.origin) < radius)
        return 1;
    }
  }

  return 0;
}

_id_201F7AA662D9FBC7() {
  _id_593659CC7685B307 = [];
  _id_FC9AC45209F959BB = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC9AC45209F959BB.size; _id_AC0E594AC96AA3A8++) {
    if(_id_FC9AC45209F959BB[_id_AC0E594AC96AA3A8] _id_18A73A64992DD07D::is_specified_unittype("juggernaut"))
      _id_593659CC7685B307[_id_593659CC7685B307.size] = _id_FC9AC45209F959BB[_id_AC0E594AC96AA3A8];
  }

  foreach(player in level.players) {
    foreach(_id_E21279FA90BDF012 in _id_593659CC7685B307) {
      _id_4D6D6A486EF55682 = scripts\cp\utility::ifcanseeplayer(_id_E21279FA90BDF012, player);

      if(_id_4D6D6A486EF55682)
        return 1;
    }
  }

  return 0;
}

_id_744847B146C67E52() {
  childthread _id_3B015DC69704E6BB();
  childthread _id_E1F42A6B3FE802E6();
  childthread _id_F6FB3D6C0B7BE2CF();
  childthread _id_7C7583BB03D7CC6E();
  childthread _id_1D9B436B1AEFB41D();
}

_id_3B015DC69704E6BB() {
  _id_405885D1BA1F2152 = (-285.5, 8327.5, -3762);
  _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(_id_405885D1BA1F2152, 500);

  while(!isDefined(level._id_6E6C8E9CA9C42A38))
    wait 1;

  level._id_6E6C8E9CA9C42A38 endon("death");
  radius = 1000;
  _id_531A2B376A1BDC47 = 1500;
  _id_B1DC53FC76469290 = squared(radius);
  _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(level._id_6E6C8E9CA9C42A38, _id_531A2B376A1BDC47);
  level notify("vo_juggMaze_keycard_jugglookat");
  aliases = ["dx_cp_cpr4_trnf_fara_thatsnothadir", "dx_cp_cpr4_trnf_pric_hvtsnothadir", "dx_cp_cpr4_trnf_alex_thehvtsnothadir"];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(level._id_6E6C8E9CA9C42A38, 0.7, 0.4, 0, undefined, radius)[0];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3, undefined, 2);
  aliases = ["dx_cp_cpr4_trnf_fara_hvtsajuggernaut", "dx_cp_cpr4_trnf_pric_hvtsnothadiritsajugg", "dx_cp_cpr4_trnf_alex_awesomehvtsajuggerna"];
  _id_52A463A16496D1CA = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(level._id_6E6C8E9CA9C42A38.origin, player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_52A463A16496D1CA, aliases, 0.3, 1, 5);
  wait 1;
  _id_405885D1BA1F2152 = (-285.5, 8327.5, -3762);

  if(!isDefined(level._id_2313A19F59121665)) {
    aliases = ["dx_cp_cpr4_trnf_fara_hecouldhavethekeycar", "dx_cp_cpr4_trnf_pric_hemighthavethekeycar", "dx_cp_cpr4_trnf_alex_hecouldhavethekeycar"];
    _id_52A464A16496D3FD = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_405885D1BA1F2152);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_52A464A16496D3FD, aliases, 0.5);
  }

  while(scripts\cp\utility::any_player_nearby(level._id_6E6C8E9CA9C42A38.origin, _id_B1DC53FC76469290))
    wait 1;

  aliases = ["dx_cp_cpr4_trnf_fara_youneedtogoaftertheh", "dx_cp_cpr4_trnf_pric_yougottagoafterthehv", "dx_cp_cpr4_trnf_alex_hitthehvtitsouronlyp"];
  _id_52A464A16496D3FD = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_405885D1BA1F2152);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_52A464A16496D3FD, aliases, 0.5);
}

_id_E1F42A6B3FE802E6() {
  while(!isDefined(level._id_1C8FC4D6F9FCF7ED))
    wait 1;

  buttons = [];

  foreach(button in level._id_1C8FC4D6F9FCF7ED)
  buttons[buttons.size] = button.scriptable.origin;

  radius = 120;
  aliases = ["dx_cp_cpr4_trnf_fara_thisroomneedsakeycar", "dx_cp_cpr4_trnf_pric_needakeycardforthisd", "dx_cp_cpr4_trnf_alex_needakeycardtogetinh"];
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(buttons, 0.7, 0.3, 0, undefined, radius)[0];

  if(!isDefined(level._id_2313A19F59121665) || isDefined(level._id_2313A19F59121665) && level._id_2313A19F59121665 != player)
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);

  wait 1.5;

  if(isDefined(level._id_2313A19F59121665)) {
    return;
  }
  aliases = ["dx_cp_cpr4_trnf_fara_maybethatswhatthehvt", "dx_cp_cpr4_trnf_pric_mightbewhatthehvtsca", "dx_cp_cpr4_trnf_alex_couldbewhatthehvtsgo"];
  _id_6C6292AC9CB01DE4 = _id_62E11D77B25C1D30::_id_D63542EBC6F90151(player.origin);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_6C6292AC9CB01DE4, aliases);
  aliases = ["dx_cp_cpr4_trnf_fara_hesmarkedforareasonw", "dx_cp_cpr4_trnf_pric_hesmarkedforareasonw", "dx_cp_cpr4_trnf_alex_theymarkedhimforarea"];
  _id_6EE5484560EC747C = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(player.origin, player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_6EE5484560EC747C, aliases);
}

_id_F6FB3D6C0B7BE2CF() {
  level endon("vo_juggMaze_keycard_pickup");
  level waittill("maze_jugg_key_pickup_created", key);

  if(isstring(key)) {
    return;
  }
  aliases = ["dx_cp_cpr4_trnf_fara_hvtdroppedakeycard", "dx_cp_cpr4_trnf_pric_hvtdroppedakeycard", "dx_cp_cpr4_trnf_alex_thehvtdroppedakeycar"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(key.origin);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.1, 1, 4);
}

_id_7C7583BB03D7CC6E() {
  while(!isDefined(level._id_2313A19F59121665))
    wait 1;

  level notify("vo_juggMaze_keycard_pickup");
  aliases = ["dx_cp_cpr4_trnf_fara_gotthekeycard", "dx_cp_cpr4_trnf_pric_keycardsecure", "dx_cp_cpr4_trnf_alex_securedthekeycard"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level._id_2313A19F59121665, aliases, 0.3, 2, 5);
  wait 2;

  if(isDefined(level.price) && level._id_2313A19F59121665 != level.price) {
    aliases = ["dx_cp_cpr4_trnf_fara_isthekeycardrevealin", "dx_cp_cpr4_trnf_fara_isthekeycardrevealin", "dx_cp_cpr4_trnf_alex_thekeycardshowingany"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level._id_2313A19F59121665, aliases, 0.5);
    wait 1.5;
  }

  aliases = ["dx_cp_cpr4_trnf_fara_thatkeycardrevealeda", "dx_cp_cpr4_trnf_pric_keycardshighlighteda", "dx_cp_cpr4_trnf_alex_thatkeycardspointing"];
  _id_6C6292AC9CB01DE4 = _id_62E11D77B25C1D30::_id_D63542EBC6F90151(level._id_D526C84266C6DBB7[0].trigger.origin);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_6C6292AC9CB01DE4, aliases, 0.5, undefined, 5);
  wait 0.5;
  aliases = ["dx_cp_cpr4_trnf_fara_guideustoit", "dx_cp_cpr4_trnf_pric_leadustoit_01", "dx_cp_cpr4_trnf_alex_tellustheway"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level._id_2313A19F59121665, aliases, 0.5, undefined, 3);
  _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(level._id_D526C84266C6DBB7[0].trigger.origin, 700);
  aliases = ["dx_cp_cpr4_trnf_fara_thatstheroomtrytheke", "dx_cp_cpr4_trnf_pric_youreontargetusethek", "dx_cp_cpr4_trnf_alex_youreattheroomusethe"];
  player = _id_62E11D77B25C1D30::_id_D63542EBC6F90151(level._id_D526C84266C6DBB7[0].trigger.origin);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);
}

_id_1D9B436B1AEFB41D() {
  level waittill("jugg_maze_keycard_success", instance);
  origin = instance.origin;
  aliases = ["dx_cp_cpr4_trnf_fara_itworkedthedoorsopen", "dx_cp_cpr4_trnf_pric_cardworkedwerein", "dx_cp_cpr4_trnf_alex_doorsopen"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(origin);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);
  wait 1.3;

  if(istrue(level._id_0223FD3D4F9C3C3A)) {
    return;
  }
  aliases = ["dx_cp_cpr4_trnf_fara_doyouseeanythinginth", "dx_cp_cpr4_trnf_pric_gotanythinginthere", "dx_cp_cpr4_trnf_alex_findanythinginthere"];
  _id_6C6292AC9CB01DE4 = _id_62E11D77B25C1D30::_id_D63542EBC6F90151(origin);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_6C6292AC9CB01DE4, aliases, 0.5, undefined, 2);
}

_id_C600CB75740C3864() {
  level endon("progress_level");
  childthread _id_54D5B663811C9A74();
  childthread _id_5C9553F310B6E324();
  childthread _id_1581B766763798E5();
  childthread _id_C4F1599C3BA2BD3B();
  childthread _id_E79616BF9602760F();

  for(;;) {
    _id_C234C158FB9A5589();
    wait 9000;
  }
}

_id_54D5B663811C9A74() {
  while(!isDefined(level._id_D526C84266C6DBB7) || level._id_D526C84266C6DBB7.size == 0)
    wait 1;

  _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(level._id_D526C84266C6DBB7[0].trigger.origin, 350);
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(level._id_D526C84266C6DBB7[0].trigger.origin);

  if(player == level.farah) {
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, "dx_cp_cpr4_trnf_fara_shit", 0.05);
    wait 1;
  }

  if(!_id_CAD9C1F65723A4F3()) {
    aliases = ["dx_cp_cpr4_trnf_fara_itsthenuclearcore", "dx_cp_cpr4_trnf_pric_fuckmyoldbootsitshad", "dx_cp_cpr4_trnf_alex_luckydayitsthenuclea"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.05);
    level._id_0223FD3D4F9C3C3A = 1;
  }

  aliases = ["dx_cp_cpr4_trnf_fara_takeitandgetbackhere", "dx_cp_cpr4_trnf_pric_getitandgetoutofther", "dx_cp_cpr4_trnf_alex_grabitandgo"];
  _id_52A463A16496D1CA = _id_62E11D77B25C1D30::_id_51DEC43386554CAE(player.origin, player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_52A463A16496D1CA, aliases, 0.2, 2, 2);
  level notify("vo_juggMaze_core_approach");
}

_id_CAD9C1F65723A4F3() {
  _id_2997D4FCD285BA26 = 0;

  foreach(player in level.players) {
    if(isDefined(player.carryobject))
      _id_2997D4FCD285BA26 = 1;
  }

  return _id_2997D4FCD285BA26;
}

_id_5C9553F310B6E324() {
  cooldown = 10;
  aliases = ["dx_cp_cpr4_trnf_fara_ivegotthecore", "dx_cp_cpr4_trnf_pric_coressecure", "dx_cp_cpr4_trnf_alex_securedthecore"];
  _id_6DFB200F1185F35B = undefined;

  for(;;) {
    _id_2997D4FCD285BA26 = 0;

    foreach(player in level.players) {
      if(isDefined(player.carryobject)) {
        _id_2997D4FCD285BA26 = 1;

        if(!isDefined(_id_6DFB200F1185F35B) || player != _id_6DFB200F1185F35B) {
          _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, undefined, 2.5);
          _id_6DFB200F1185F35B = player;
          wait(cooldown);
        }
      }
    }

    if(!_id_2997D4FCD285BA26)
      _id_6DFB200F1185F35B = undefined;

    wait 0.05;
  }
}

_id_C234C158FB9A5589() {
  aliases = ["dx_cp_cpr4_trnf_fara_idontfeelright", "dx_cp_cpr4_trnf_pric_imgonnabesick", "dx_cp_cpr4_trnf_alex_imnotfeelinsohot"];
  _id_221CBF7573CF994D = undefined;

  for(;;) {
    foreach(player in level.players) {
      if(isDefined(player._id_D60E12EBA99F3BC4) && player._id_D60E12EBA99F3BC4 >= 12) {
        _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
        _id_221CBF7573CF994D = player;
        break;
      }
    }

    if(isDefined(_id_221CBF7573CF994D)) {
      break;
    }

    wait 1;
  }

  _id_221CBF7573CF994D endon("end_radiation_fx");
  _id_221CBF7573CF994D endon("drop_object");
  wait 1.4;
  _id_6EE5484560EC747C = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(_id_221CBF7573CF994D.origin, _id_221CBF7573CF994D);
  aliases = ["dx_cp_cpr4_trnf_fara_theradiationyouneedt", "dx_cp_cpr4_trnf_pric_youreholdinanuclearc", "dx_cp_cpr4_trnf_alex_itstheradiationyougo"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_6EE5484560EC747C, aliases, 0.1, undefined, 2);
  wait 1.75;

  if(isDefined(_id_221CBF7573CF994D)) {
    if(isDefined(level.price) && level.price == _id_221CBF7573CF994D)
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_trnf_pric_canyoutastemetal", 0.3, undefined, 2);
    else if(isDefined(level.farah) && level.farah == _id_221CBF7573CF994D)
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_trnf_fara_icantastemetal", 0.3, undefined, 2);
    else
      wait 1;
  }

  _id_6EE5484560EC747C = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(_id_221CBF7573CF994D.origin, _id_221CBF7573CF994D);
  aliases = ["dx_cp_cpr4_trnf_fara_itstheradiationfromt", "dx_cp_cpr4_trnf_pric_putthecoredown", "dx_cp_cpr4_trnf_alex_putthecoredown"];

  if(isDefined(_id_6EE5484560EC747C)) {
    if(!isDefined(_id_6EE5484560EC747C.dogtag))
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_6EE5484560EC747C, aliases, 0.1, undefined, 2);
  }

  wait 3.25;
  _id_6EE5484560EC747C = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(_id_221CBF7573CF994D.origin, _id_221CBF7573CF994D);
  aliases = ["dx_cp_cpr4_trnf_fara_dropthecore", "dx_cp_cpr4_trnf_pric_dropthecore", "dx_cp_cpr4_trnf_alex_dropthecore"];

  if(isDefined(_id_6EE5484560EC747C)) {
    if(!isDefined(_id_6EE5484560EC747C.dogtag))
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_6EE5484560EC747C, aliases, 0.1, undefined, 2);
  }
}

_id_C4F1599C3BA2BD3B() {
  level endon("progress_level");

  while(!isDefined(level._id_D526C84266C6DBB7) || level._id_D526C84266C6DBB7.size == 0)
    wait 1;

  for(;;) {
    while(!isDefined(level._id_D526C84266C6DBB7[0].carrier))
      wait 0.05;

    _id_13F875A9E5E426F2 = level._id_D526C84266C6DBB7[0].carrier;
    _id_13F875A9E5E426F2 waittill("drop_object");

    if(distance(_id_13F875A9E5E426F2.origin, level._id_96C4EC15F6D0210E[0].origin) > 600)
      level notify("vo_juggMaze_core_dropped", _id_13F875A9E5E426F2);
  }
}

_id_1581B766763798E5() {
  level endon("progress_level");
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_fara_idroppedthecore", "dx_cp_cpr4_trnf_fara_thecoresdown"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_pric_droppedthecore", "dx_cp_cpr4_trnf_pric_coresdown"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_alex_hadtodropthecore", "dx_cp_cpr4_trnf_alex_coresdown"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  _id_34D59C8542021B6F = 1;

  for(;;) {
    level waittill("vo_juggMaze_core_dropped", player);

    if(_id_0AFB7E332AEE4BF2::player_in_laststand(player) || isDefined(player.dogtag)) {
      continue;
    }
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.7, undefined, 2.5);

    if(_id_34D59C8542021B6F) {
      childthread _id_EECD983A179E8B71(player);
      childthread _id_236DB11852D0F5AC();
      _id_34D59C8542021B6F = 0;
    }
  }
}

_id_EECD983A179E8B71(_id_819388FC96AA7798) {
  level endon("vo_juggMaze_core_drop_response_clear");
  _id_819388FC96AA7798 endon("disconnect");
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_fara_youneedtoworktogethe", "dx_cp_cpr4_trnf_fara_worktogethergettheco"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_pric_gonnatakebothofyatog", "dx_cp_cpr4_trnf_pric_worktogethertogetitb"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_alex_gonnaneedtwosetsofha", "dx_cp_cpr4_trnf_alex_worktogethertomoveth"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  wait 2;
  _id_3A3E9592A2170448 = 0;

  if(!_id_3A3E9592A2170448) {
    if(level.players.size < 3)
      return;
  }

  if(istrue(level._id_EECD983A179E8B71)) {
    return;
  }
  level._id_EECD983A179E8B71 = 1;
  player = _id_62E11D77B25C1D30::_id_D63542EBC6F90151(_id_819388FC96AA7798.origin);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5);
  wait 10.5;
  player = _id_62E11D77B25C1D30::_id_D63542EBC6F90151(_id_819388FC96AA7798.origin);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.5, undefined, 3);
}

_id_236DB11852D0F5AC() {
  scripts\engine\utility::waittill_any_ents_array(level.players, "radiation_runGradualEffects");
  level notify("vo_juggMaze_core_drop_response_clear");
}

_id_BB50F39C46D90DA7() {
  level endon("vo_juggMaze_core_complete");
  level waittill("vo_juggmaze_door_open");
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_fara_whichwaydowego", "dx_cp_cpr4_trnf_fara_usethescreentelluswh", "dx_cp_cpr4_trnf_fara_weneeddirection", "dx_cp_cpr4_trnf_fara_whatareyouseeing", "dx_cp_cpr4_trnf_fara_telluswhichway"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_alex_whichway", "dx_cp_cpr4_trnf_alex_usethescreentelluswh", "dx_cp_cpr4_trnf_alex_usethescreentoguideu", "dx_cp_cpr4_trnf_alex_weneedanupdateouther", "dx_cp_cpr4_trnf_alex_status"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_pric_usethescreentelluswh", "dx_cp_cpr4_trnf_pric_weneedyoureyesouther", "dx_cp_cpr4_trnf_pric_tellustheway"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  _id_635EC6C4BFF67A54 = (-488, 9023.5, -3803.5);
  nag_radius = 500;
  _id_D8101A3E0B5D2269 = 900;
  cooldown = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(45, 75, 10);
  _id_0527249339E93209 = 0;

  for(;;) {
    _id_DAEFBD6EBC051D8B = [];

    foreach(player in level.players) {
      if(distance(player.origin, _id_635EC6C4BFF67A54) <= _id_D8101A3E0B5D2269)
        _id_DAEFBD6EBC051D8B[_id_DAEFBD6EBC051D8B.size] = player;
    }

    if(_id_DAEFBD6EBC051D8B.size == 1) {
      if(distance(_id_DAEFBD6EBC051D8B[0].origin, _id_635EC6C4BFF67A54) < nag_radius)
        _id_0527249339E93209++;
    }

    if(_id_0527249339E93209 > 10) {
      foreach(_id_6EE5484560EC747C in level.players) {
        if(length(_id_6EE5484560EC747C getvelocity()) <= 1) {
          _id_0527249339E93209 = 0;
          _id_6F20EC310A334C24 = _id_62E11D77B25C1D30::_id_D63542EBC6F90151(_id_635EC6C4BFF67A54);
          _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_6F20EC310A334C24, aliases, 1.5);
          _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(cooldown);
        }
      }
    }

    wait 1;
  }
}

_id_C71E7966B6EC9B3A() {
  level endon("vo_juggMaze_core_complete");
  level waittill("vo_juggMaze_core_approach");
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_fara_takingcontactimoffth", "dx_cp_cpr4_trnf_fara_ilostvisual", "dx_cp_cpr4_trnf_fara_imincontactyoureonyo"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_pric_engagingaqilostvisua", "dx_cp_cpr4_trnf_pric_contactimoffscreen"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_alex_takingcontactimoffth", "dx_cp_cpr4_trnf_alex_novisualengagingaq", "dx_cp_cpr4_trnf_alex_gotcontactilostvisua"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  _id_5D3FF10B186A2C73 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_alex_imback", "dx_cp_cpr4_trnf_alex_backonscreen"]);
  _id_9D527C5586AAF521 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_fara_imbackonthescreen", "dx_cp_cpr4_trnf_fara_backonoverwatch"]);
  _id_714A6A6BE9B24C20 = scripts\engine\utility::create_deck(["dx_cp_cpr4_trnf_pric_goteyesonyouagain", "dx_cp_cpr4_trnf_pric_imbackonscreen"]);
  _id_D0DDCF96EA79B33F = [_id_9D527C5586AAF521, _id_714A6A6BE9B24C20, _id_5D3FF10B186A2C73];

  for(;;) {
    results = _id_FC70A988C25A3DA1();
    player = results[0];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.8);
    _id_A16FF82E6239BD7F(player, gettime());

    if(!isDefined(player) || !isPlayer(player)) {
      continue;
    }
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, _id_D0DDCF96EA79B33F, 0.4);
    wait 5;
  }
}

_id_A16FF82E6239BD7F(player, _id_C804E03B751DC5F6) {
  player endon("disconnect");
  _id_405885D1BA1F2152 = (-285.5, 8327.5, -3762);

  while(!scripts\engine\utility::time_has_passed(_id_C804E03B751DC5F6, 3.5) || distance(player.origin, _id_405885D1BA1F2152) > 300 || !scripts\engine\utility::within_fov(player.origin, player getplayerangles(), _id_405885D1BA1F2152, 0.642788))
    wait 0.3;
}

_id_FC70A988C25A3DA1() {
  for(;;) {
    results = _id_CA233BC61873024C();

    if(!results[1] _id_18A73A64992DD07D::is_specified_unittype("juggernaut"))
      return results;
  }
}

_id_0F34DDDB11BE4591() {
  level waittill("vo_juggMaze_core_approach");
  _id_663E47B8A8C22B8B = (-175, 8155, -3818.5);
  radius = 150;
  _id_5F74063D83CBE844 = 0;

  for(;;) {
    foreach(player in level.players) {
      if(distance(player.origin, _id_663E47B8A8C22B8B) <= radius) {
        if(isDefined(player.carryobject)) {
          aliases = ["dx_cp_cpr4_trnf_fara_getthedoor", "dx_cp_cpr4_trnf_pric_openthedoor", "dx_cp_cpr4_trnf_alex_hitthedoorletusin"];
          _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.05);
          return;
        } else if(!_id_5F74063D83CBE844 && distance(level._id_D526C84266C6DBB7[0].trigger.origin, player.origin) > 300) {
          aliases = ["dx_cp_cpr4_trnf_fara_weneedthecoredontlea", "dx_cp_cpr4_trnf_pric_wecantleavethecorebe", "dx_cp_cpr4_trnf_alex_wecantleavewithoutth"];
          _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.05);
          _id_5F74063D83CBE844 = 1;
        }
      }
    }

    wait 0.25;
  }
}

_id_E79616BF9602760F() {
  _id_96C79BADBC81AF2D = (-357, 8568, -3821.5);
  radius = 240;

  for(;;) {
    foreach(player in level.players) {
      if(isDefined(player.carryobject) && distance(player.origin, _id_96C79BADBC81AF2D) <= radius) {
        level thread _id_CCC28C465AB81340();
        level notify("vo_juggMaze_core_complete");
        return;
      }
    }

    wait 0.25;
  }
}

_id_CCC28C465AB81340() {
  level endon("vo_juggMaze_foundDepositCrate");
  level endon("progress_level");
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_trnf_fara_thatwasclose", 0.05);
  wait 1;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_trnf_alex_hellyeah", 0.05);
  wait 1;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_trnf_pric_thatshowwegetitdonet", 0.05);
  wait 2;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_trnf_alex_ifthecoresstillhereh", 0.05);
  wait 1;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_trnf_fara_thenwecanstillstophi", 0.05);
  level thread _id_F764E9720F9E7151();
  wait 1.5;
  carrier = _id_C361BC8318FDA399();

  if(!isDefined(carrier))
    carrier = level.farah;

  aliases = ["dx_cp_cpr4_trnf_fara_wehavetofindawaytomo", "dx_cp_cpr4_trnf_pric_wehavetofindawaytotr", "dx_cp_cpr4_trnf_alex_weneedtofindsomethin"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(carrier, aliases, 0.05);
  wait 1;
  aliases = ["dx_cp_cpr4_trnf_fara_lookforsomethingweca", "dx_cp_cpr4_trnf_pric_searchforsomethingto", "dx_cp_cpr4_trnf_alex_weneedsomethingtotra"];
  carrier = _id_C361BC8318FDA399();

  if(!isDefined(carrier))
    carrier = level.farah;

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(carrier, aliases, 0.05, undefined, 3);
  wait 10;
  aliases = ["dx_cp_cpr4_trnf_fara_aqmusthaveusedsometh", "dx_cp_cpr4_trnf_pric_aqcouldnthavemovedth", "dx_cp_cpr4_trnf_alex_aqhadtousesomethingt"];
  carrier = _id_C361BC8318FDA399();

  if(!isDefined(carrier))
    carrier = level.farah;

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(carrier, aliases, 0.05, undefined, 4);
  aliases = ["dx_cp_cpr4_trnf_fara_lookforsomethinglead", "dx_cp_cpr4_trnf_pric_weneedaleadcontainer", "dx_cp_cpr4_trnf_alex_findaleadboxtomoveth"];
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(10, 30, 5);

  for(;;) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    carrier = _id_C361BC8318FDA399();

    if(!isDefined(carrier))
      carrier = level.farah;

    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(carrier, aliases, 0.05);
  }
}

_id_C361BC8318FDA399() {
  carrier = undefined;

  foreach(player in level.players) {
    if(isDefined(player.carryobject))
      return carrier;
  }

  return carrier;
}

_id_F764E9720F9E7151() {
  level endon("game_ended");
  level endon("progress_level");
  origin = level._id_96C4EC15F6D0210E[0].origin;
  _id_636C8575D7A7768B = 140;
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(origin, 0.4, 0.1, 0, undefined, _id_636C8575D7A7768B)[0];
  level notify("vo_juggMaze_foundDepositCrate");
  aliases = ["dx_cp_cpr4_trnf_fara_gotaleadcontainerher", "dx_cp_cpr4_trnf_pric_foundaleadcontainer", "dx_cp_cpr4_trnf_alex_gotaleadboxhere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.05, undefined, 3);
  level thread _id_C0EB20F671E33C3F(origin);
  _id_849EB9D16AF41567 = 1;

  while(_id_849EB9D16AF41567) {
    msg = level scripts\engine\utility::waittill_any_timeout_1(10, "progress_level");

    if(msg == "progress_level") {
      _id_849EB9D16AF41567 = 0;
      break;
    } else {
      aliases = ["dx_cp_cpr4_trnf_fara_putthecoreinside", "dx_cp_cpr4_trnf_pric_wecanusethatcontaine", "dx_cp_cpr4_trnf_alex_wecanuseittomovethec"];
      player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(origin);
      _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.05, undefined, 3);
    }
  }
}

_id_C0EB20F671E33C3F(origin) {
  level endon("game_ended");
  level waittill("core_secured");
  aliases = ["dx_cp_cpr4_trnf_fara_coresecureletshurry", "dx_cp_cpr4_trnf_pric_coressecureletsmove", "dx_cp_cpr4_trnf_alex_coresintheboxletsgo"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(origin);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.05);
}

_id_CECE010D21A1327D() {
  childthread _id_23A99754F6D41F69();
  childthread _id_A6B9973FE5E0779A();
}

_id_A6B9973FE5E0779A() {
  _id_4EACCEAD759685D0 = (3242, 5164.3, -3777.27);
  player = _id_62E11D77B25C1D30::_id_F3C414CE5CCAB845(_id_4EACCEAD759685D0, 0.8, 1, 0, [], 400)[0];
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_fara_thatdooritsaysitsthe", "dx_cp_cpr4_mnsc_fara_thatdoorlooksdiffere"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_pric_myrussiansalittledus", "dx_cp_cpr4_mnsc_pric_somethindifferentabo"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_alex_irecognizethatsignon", "dx_cp_cpr4_mnsc_alex_thatdoorlookslikewhe"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
  childthread _id_CB918650CE7D8545(_id_4EACCEAD759685D0);
}

_id_23A99754F6D41F69() {
  reader = scripts\engine\utility::getStruct("silo_door_ee_button", "script_noteworthy");
  player = _id_62E11D77B25C1D30::_id_F3C414CE5CCAB845(reader, 0.8, 3, 0, [], 200)[0];
  aliases = ["dx_cp_cpr4_mnsc_fara_thatdoorhasakeycardr", "dx_cp_cpr4_mnsc_pric_aqputakeycardreadero", "dx_cp_cpr4_mnsc_alex_endofthehallthatdoor"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
}

_id_CB918650CE7D8545(_id_20510600314FE827) {
  _id_50E9B7A117980B41 = 1;
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(30, 60, 3);
  _id_EC44C06676021F69 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_fara_wehavetofindanotherw", "dx_cp_cpr4_mnsc_fara_wellneedtofindthekey"]);
  _id_6DFEEEBD5989A352 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_pric_gottabeanotherwayaro", "dx_cp_cpr4_mnsc_pric_wellneedtofindakeyto"]);
  _id_A739AB0E1D996CF3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_mnsc_alex_notseeinawaypastthis", "dx_cp_cpr4_mnsc_alex_weregonnaneedtofinda"]);
  aliases = [_id_EC44C06676021F69, _id_6DFEEEBD5989A352, _id_A739AB0E1D996CF3];

  while(istrue(_id_50E9B7A117980B41)) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    player = scripts\engine\utility::getclosest(_id_20510600314FE827, level.players, 500);

    if(!isDefined(player)) {
      _id_50E9B7A117980B41 = 0;
      continue;
    }

    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases);
  }
}

_id_90281633FA46082E() {
  childthread _id_D1468C8D6B247234();
}

_id_D1468C8D6B247234() {
  _id_63D71C1C83B43669 = (-1021.5, 8972.5, -3821.5);
  level waittill("core_secured");
  childthread _id_017F7CB40061F20A(_id_63D71C1C83B43669);
  _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(_id_63D71C1C83B43669, 80);
  level notify("vo_juggMaze_exitStaircase");
  aliases = ["dx_cp_cpr4_trnf_fara_movingupthestairs", "dx_cp_cpr4_trnf_pric_upthestairsthisway", "dx_cp_cpr4_trnf_alex_headinupthesestairs"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_63D71C1C83B43669);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.05);
  childthread _id_EAEB9A66B8FEAED3();
  childthread _id_C2CC57484594B6B1();
  childthread _id_4E26A5C52824F314();
  childthread _id_91E5CCE307FE04FB();
}

_id_017F7CB40061F20A(_id_63D71C1C83B43669) {
  level endon("vo_juggMaze_exitStaircase");
  wait 10;
  aliases = ["dx_cp_cpr4_trnf_fara_lookforawayout", "dx_cp_cpr4_trnf_pric_wegottafindawayoutta", "dx_cp_cpr4_trnf_alex_searchforawayouttahe"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_63D71C1C83B43669);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.05);
}

_id_EAEB9A66B8FEAED3() {
  _id_4EACCEAD759685D0 = (-1078.5, 8517.5, -3686);
  _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(_id_4EACCEAD759685D0, 100);
  aliases = ["dx_cp_cpr4_trnf_fara_thisdooristheonlyway", "dx_cp_cpr4_trnf_pric_doorstheonlywayletsm", "dx_cp_cpr4_trnf_alex_letstrythedoor"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_4EACCEAD759685D0);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.05);
}

_id_38C0FA6DE0A5DFC1() {
  _id_CF9BB247E5455FCB = (-1211, 9696.5, -4066.5);
  _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(_id_CF9BB247E5455FCB, 400);
  level notify("clear_vo_juggMaze_exitDoorReturn");
}

_id_C2CC57484594B6B1() {
  level endon("clear_vo_juggMaze_exitDoorReturn");
  childthread _id_38C0FA6DE0A5DFC1();
  _id_A1BF416A6A203EA6 = (-1255, 8572.5, -3686);
  _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(_id_A1BF416A6A203EA6, 125);
  wait 1;
  aliases = ["dx_cp_cpr4_trnf_fara_wevebeenherebefore", "dx_cp_cpr4_trnf_pric_werebackatthetunnels", "dx_cp_cpr4_trnf_alex_backwherewestarted"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_A1BF416A6A203EA6);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.05);
  wait 1.5;

  if(istrue(game["mine_seen_lasers"])) {
    _id_4F6BFCDC7C5D5560 = 1;

    if(_id_4F6BFCDC7C5D5560)
      aliases = ["dx_cp_cpr4_trnf_fara_thekeycardmightopent", "dx_cp_cpr4_trnf_pric_thekeycardwepickedup", "dx_cp_cpr4_trnf_alex_maybethiskeycardwepi"];
    else
      aliases = ["dx_cp_cpr4_trnf_fara_thedooroutsidetheset", "dx_cp_cpr4_trnf_pric_thedoorbeforewecamed", "dx_cp_cpr4_trnf_alex_therewasadooratthest"];

    player = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(_id_A1BF416A6A203EA6, player);

    if(!isDefined(player))
      player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_A1BF416A6A203EA6);

    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.05);
  } else {
    aliases = ["dx_cp_cpr4_trnf_fara_shouldwedoubleback", "dx_cp_cpr4_trnf_pric_maybewedoublebackyea", "dx_cp_cpr4_trnf_alex_maybewebacktrack"];
    player = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(_id_A1BF416A6A203EA6, player);

    if(!isDefined(player))
      player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_A1BF416A6A203EA6);

    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.05);
  }

  wait 5;

  if(scripts\cp\utility::any_player_nearby(_id_A1BF416A6A203EA6, squared(400))) {
    aliases = ["dx_cp_cpr4_trnf_fara_backistheonlywaytogo", "dx_cp_cpr4_trnf_pric_backstheonlywayforwa", "dx_cp_cpr4_trnf_alex_onlywayoutsgottabeba"];
    player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_A1BF416A6A203EA6);
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.05);
  }
}

_id_4E26A5C52824F314() {
  level waittill("clear_vo_juggMaze_exitDoorReturn");
  scripts\engine\utility::flag_init("flag_clear_laswell_radio");
  level thread _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.3, "dx_cp_cpr4_trnf_lasw_bravo6watcher1doyouc");
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_trnf_pric_sixcopiesgoodtoheary", 0.5);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_trnf_alex_isecondthat", 0.4);
  level thread _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.5, "dx_cp_cpr4_trnf_lasw_whatsthesitrepdownth");
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_trnf_alex_werecoveredthecorewe", 0.3);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_trnf_pric_thenweneedexfilfastt", 0.5);
  level thread _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.4, "dx_cp_cpr4_trnf_lasw_excellentworksergean");
  level thread _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.6, "dx_cp_cpr4_trnf_gazz_captainexfils5mikeso");
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_trnf_pric_rogwellbethere", 0.5);
  level thread _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.4, "dx_cp_cpr4_trnf_lasw_whateverhappenskeept");
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_trnf_fara_hadirsnotgoinganywhe", 0.3);
  level _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.4, "dx_cp_cpr4_trnf_lasw_copythatseeyouontheo");
  scripts\engine\utility::flag_set("flag_clear_laswell_radio");
}

_id_91E5CCE307FE04FB() {
  for(_id_6EB04909CB5CA84D = getEnt("final_hallway_keypad", "script_noteworthy"); !isDefined(_id_6EB04909CB5CA84D); _id_6EB04909CB5CA84D = getEnt("final_hallway_keypad", "script_noteworthy"))
    wait 1;

  _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(_id_6EB04909CB5CA84D.origin, 220);
  player = undefined;

  if(!scripts\engine\utility::flag("flag_clear_laswell_radio"))
    scripts\engine\utility::flag_wait("flag_clear_laswell_radio");
  else {
    player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_6EB04909CB5CA84D.origin);
    aliases = ["dx_cp_cpr4_trnf_fara_theresourdoor", "dx_cp_cpr4_trnf_pric_theresthedoor", "dx_cp_cpr4_trnf_alex_goteyesonthedoor"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  }

  if(!istrue(_id_6EB04909CB5CA84D.activated)) {
    aliases = ["dx_cp_cpr4_trnf_fara_trythekeycard", "dx_cp_cpr4_trnf_pric_usethekeycard", "dx_cp_cpr4_trnf_alex_momentotruthtrytheke"];
    _id_52A463A16496D1CA = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_6EB04909CB5CA84D.origin, level.players, player);
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_52A463A16496D1CA, aliases, 0.3);
    level thread _id_0CEDAFD567E7AFA6(_id_6EB04909CB5CA84D);
    level waittill("nuke_finalhallway_keycard_success", _id_4E7BFA46D7161B5F);
    aliases = ["dx_cp_cpr4_trnf_fara_thedoorisopenletsgo", "dx_cp_cpr4_trnf_pric_doorsopen", "dx_cp_cpr4_trnf_alex_doorsopenletsmove"];
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(_id_4E7BFA46D7161B5F, aliases, 0.3);
  }

  wait 1;
  childthread _id_7B5A184B8448831A();
}

_id_0CEDAFD567E7AFA6(_id_6EB04909CB5CA84D) {
  level endon("nuke_finalhallway_keycard_success");
  wait 12;

  while(!scripts\cp\utility::any_player_nearby(_id_6EB04909CB5CA84D.origin, squared(250)))
    wait 1;

  aliases = ["dx_cp_cpr4_trnf_fara_thisdooristheonlyway_01", "dx_cp_cpr4_trnf_pric_gottabethroughthisdo", "dx_cp_cpr4_trnf_alex_thisisititstheonlywa"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_6EB04909CB5CA84D.origin);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_7B5A184B8448831A() {
  level endon("3man_door_elevator_door_open");

  if(!scripts\engine\utility::flag("flag_clear_laswell_radio"))
    scripts\engine\utility::flag_wait("flag_clear_laswell_radio");
  else {
    _id_A3918B6A9874AC14 = (-140, 11944, -4042);
    _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(_id_A3918B6A9874AC14, 220);
  }

  pos = (-290, 12829, -4042);
  _id_D6ABCB75E41F1152(pos, "dx_cp_cpr4_trnf_aqs1_ourscoutsarereportin");
  pos = (-240, 12829, -4042);
  _id_D6ABCB75E41F1152(pos, "dx_cp_cpr4_trnf_hadr_fuckweneedtohurrylet");

  if(scripts\cp\utility::any_player_nearby(pos, squared(900))) {
    aliases = ["dx_cp_cpr4_trnf_fara_thatshadir", "dx_cp_cpr4_trnf_pric_thatvoicesoundsfamil", "dx_cp_cpr4_trnf_alex_thatsoundslikehadir"];
    player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(pos);
    thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  }

  _id_A3918B6A9874AC14 = (-302, 12476, -4071);
  _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(_id_A3918B6A9874AC14, 400);
  aliases = ["dx_cp_cpr4_trnf_fara_wellneedallthefirepo", "dx_cp_cpr4_trnf_pric_kitupweregonnaneedit", "dx_cp_cpr4_trnf_alex_weregonnaneedtogearu"];
  player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_A3918B6A9874AC14);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.7);
  wait 1;
  _id_FA4915F8AE7043D4 = (-286, 13035, -4071);
  _id_D6ABCB75E41F1152(_id_FA4915F8AE7043D4, "dx_cp_cpr4_trnf_hadr_findthemgetthecoreba");
  wait 0.2;
  _id_D6ABCB75E41F1152(_id_FA4915F8AE7043D4, "dx_cp_cpr4_trnf_hadr_dowhateverittakes");
  wait 0.6;
  _id_D6ABCB75E41F1152(_id_FA4915F8AE7043D4, "dx_cp_cpr4_trnf_hadr_itoldheriwouldntgive");
  wait 1.1;
  _id_D6ABCB75E41F1152(_id_FA4915F8AE7043D4, "dx_cp_cpr4_trnf_hadr_letsgo");
}

_id_F0BC089C7284A07D() {
  _id_F42869166D50FBE9 = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(_id_F42869166D50FBE9) && _id_F42869166D50FBE9 == "checkpoint_elevator_section_downstairs") {
    _id_20510600314FE827 = (-282, 12641, -4057);
    _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(_id_20510600314FE827, 100);
  } else
    scripts\engine\utility::flag_wait("3man_door_elevator_door_open");

  struct = scripts\engine\utility::getStruct("3man_door_elevator", "script_noteworthy");
}

_id_3E3FED2767E87BC3() {
  level endon("hadir_elevator_crashed");
  level childthread _id_F0BC089C7284A07D();
  _id_F42869166D50FBE9 = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(_id_F42869166D50FBE9) && _id_F42869166D50FBE9 == "checkpoint_elevator_section_downstairs") {
    _id_20510600314FE827 = (-282, 12641, -4057);
    _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(_id_20510600314FE827, 100);
  }

  player = scripts\engine\utility::flag_wait("hadir_elevator_seen");
  aliases = ["dx_cp_cpr4_stlv_fara_hadir", "dx_cp_cpr4_stlv_pric_wegoteyesonhadir", "dx_cp_cpr4_stlv_alex_visualonhadir"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 1;
  level.hadir thread _id_3C2AAAD486A9AA1D::_id_46BE59E416CC0790("a02");
  wait 3;
  scripts\engine\utility::flag_set("elevator_start_vo_done");
  aliases = ["dx_cp_cpr4_stlv_fara_hesescaping", "dx_cp_cpr4_stlv_pric_hesonthemove", "dx_cp_cpr4_stlv_alex_hesrunning"];
  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  level _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.4, "dx_cp_cpr4_stlv_lasw_allstationsdonotleth");
  childthread _id_F93E078BEBFD6105();
  childthread _id_17F596224FBFAFD6();
  wait 3;
  level _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.6, "dx_cp_cpr4_stlv_gazz_bravo62istakingsmall");
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_stlv_pric_itsonusthen", 0.4);
  aliases = ["dx_cp_cpr4_stlv_fara_lookforsomethingtobr", "dx_cp_cpr4_stlv_pric_findsomethingtotaket", "dx_cp_cpr4_stlv_alex_weneedtofindsomethin"];
  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 2;
  aliases = ["dx_cp_cpr4_stlv_fara_ifwebreakthecounterw", "dx_cp_cpr4_stlv_pric_wesendthecounterweig", "dx_cp_cpr4_stlv_alex_webreakthecounterwei"];
  player = _id_62E11D77B25C1D30::_id_24F716A0A25DAF74(player);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  childthread _id_05F744BF71F717CE();
  scripts\engine\utility::flag_wait("hadir_elevator_crashed");
}

_id_05F744BF71F717CE() {
  player = _id_62E11D77B25C1D30::_id_B826409EE2EFF7B6(-1950);
  scripts\engine\utility::flag_set("vo_startElevator_reachTopOfAscender");
  childthread _id_EEC3892EDA960F57();
  wait 1;
  aliases = ["dx_cp_cpr4_stlv_fara_weneedtogethigher", "dx_cp_cpr4_stlv_pric_weretoolowfindawayto", "dx_cp_cpr4_stlv_alex_counterweightsaresti"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  childthread _id_169405D9AF6D8EC4();
  childthread _id_5F594B3FE9B7ECFE();
  childthread _id_471DDFEE6E2396D6();
  childthread _id_D9921B7E73BA606E();
  childthread _id_172BFCB0B4D89504();
}

_id_169405D9AF6D8EC4() {}

_id_172BFCB0B4D89504() {
  _id_63E26D5A86AC531C = (-854.212, 13313.8, -1471.25);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_63E26D5A86AC531C, 0.7, 0, 0, [], 500)[0];
  aliases = ["dx_cp_cpr4_stlv_fara_stillonemorefloortot", "dx_cp_cpr4_stlv_pric_onemorefloor", "dx_cp_cpr4_stlv_alex_onemorefloortogo"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  player = _id_62E11D77B25C1D30::_id_37EC59F1CC982A2A((636.058, 13306.7, -1529.16), (1021.34, 13414.6, -1238.17));
  aliases = ["dx_cp_cpr4_stlv_fara_pushingupthestairs", "dx_cp_cpr4_stlv_pric_pushinguptop", "dx_cp_cpr4_stlv_alex_movingup"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  top = (365.93, 13311.8, -1087.25);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(top, 0.7, 0, 0, [], 500)[0];
  aliases = ["dx_cp_cpr4_stlv_fara_imatthetop", "dx_cp_cpr4_stlv_pric_imtopdeck", "dx_cp_cpr4_stlv_alex_reachedthetop"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 2;
  aliases = ["dx_cp_cpr4_stlv_fara_weneedtogettothecoun", "dx_cp_cpr4_stlv_pric_findawaytogettotheco", "dx_cp_cpr4_stlv_alex_weneedtogetonthoseco"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  wait 1;
  level.hadir thread _id_5D265B4FCA61F070::_id_8C12D3C7FD8BC4FF(0.2, "dx_cp_cpr4_stlv_hadr_keepthemofftheelevat");
}

_id_EEC3892EDA960F57() {
  wait 15;
  aliases = [undefined, "dx_cp_cpr4_stlv_pric_weneedtogethigherkee", "dx_cp_cpr4_stlv_alex_keeppushingupweneedt"];
  player = _id_62E11D77B25C1D30::_id_6533A630C9443AAC((-258.105, 13857.5, -1913.25), level.farah);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_471DDFEE6E2396D6() {
  _id_4A393CAA91D7B533 = (-1275.35, 13355, -1816.71);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_4A393CAA91D7B533, 0.7, 0.2, 0, [], 500)[0];
  aliases = ["dx_cp_cpr4_stlv_fara_foundsomestairs", "dx_cp_cpr4_stlv_pric_gotstairshere", "dx_cp_cpr4_stlv_alex_stairshere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_5F594B3FE9B7ECFE() {
  wait 3;
  dist = 300;
  enemy = _id_2D85A7B7966938F1(dist);
  scripts\engine\utility::flag_set("vo_startElevator_firstEnemies");
  enemy _id_5D265B4FCA61F070::say("dx_cp_cpr4_stlv_hadr_engage");
  wait 3.8;
  enemy = _id_2D85A7B7966938F1(dist);
  enemy _id_5D265B4FCA61F070::say("dx_cp_cpr4_stlv_hadr_dowhatyoumustbrother");
  wait 1.6;
  enemy = _id_2D85A7B7966938F1(dist);
  enemy _id_5D265B4FCA61F070::say("dx_cp_cpr4_stlv_hadr_whateverittakestoget");
}

_id_2D85A7B7966938F1(dist) {
  distsq = squared(dist);

  for(;;) {
    foreach(player in level.players) {
      if(!isalive(player)) {
        continue;
      }
      enemies = getaiarrayinradius(player.origin, dist);

      if(enemies.size > 0)
        return sortbydistance(enemies, player.origin)[0];
    }

    waitframe();
  }
}

_id_81924218A144BAE3() {
  level.hadir _id_3C2AAAD486A9AA1D::_id_46BE59E416CC0790(self._id_927B3199642B75FC[self.index]);
  self.index++;
}

_id_F93E078BEBFD6105() {
  if(scripts\engine\utility::flag("vo_tookAscender")) {
    return;
  }
  level endon("vo_tookAscender");
  rope = (-393.488, 12983.2, -4030);

  if(isDefined(level.price))
    player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(rope, 0.85, 0.3, 0, [level.price], 300)[0];
  else
    player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(rope, 0.85, 0.3, 0, [], 300)[0];

  aliases = ["dx_cp_cpr4_stlv_fara_wecanusethisascender", "dx_cp_cpr4_stlv_pric_theresanascenderhere", "dx_cp_cpr4_stlv_alex_gotanascendercablehe"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_17F596224FBFAFD6() {
  player = _id_7029BF8C5A168BED();
  scripts\engine\utility::flag_set("vo_tookAscender");
  aliases = ["dx_cp_cpr4_stlv_fara_headingup", "dx_cp_cpr4_stlv_pric_movinguptop", "dx_cp_cpr4_stlv_alex_goinup"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
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

_id_5296747427972510(lever) {
  level.hadir thread _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.6, "dx_cp_cpr4_stlv_hadr_shootthemdown");
  player = _id_0E8D3A766F14DA9A(10);
  aliases = ["dx_cp_cpr4_stlv_fara_itsworking", "dx_cp_cpr4_stlv_pric_itsworking", "dx_cp_cpr4_stlv_alex_itsworking"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  wait 0.5;
  level.hadir thread _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.6, "dx_cp_cpr4_stlv_hadr_stopyoudontknowwhaty");
  level.hadir thread _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.2, "dx_cp_cpr4_stlv_hadr_weshouldbefightingth");
  player = _id_0E8D3A766F14DA9A(0);
  aliases = ["dx_cp_cpr4_stlv_fara_counterweightiscomin", "dx_cp_cpr4_stlv_pric_counterweightsdestro", "dx_cp_cpr4_stlv_alex_counterweightscomind"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  level.hadir thread _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.6, "dx_cp_cpr4_stlv_hadr_dontdothis");
  level.hadir thread _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.3, "dx_cp_cpr4_stlv_hadr_imtryingtoprotectour");
  level.hadir thread _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.2, "dx_cp_cpr4_stlv_hadr_farahimdoingthisforu");
  player = _id_0E8D3A766F14DA9A(11);
  aliases = ["dx_cp_cpr4_stlv_fara_workingonthesecondle", "dx_cp_cpr4_stlv_pric_workinonthelastone", "dx_cp_cpr4_stlv_alex_lastcounterweight"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2, 0, 1);
  player = _id_0E8D3A766F14DA9A(0);
  aliases = ["dx_cp_cpr4_stlv_fara_elevatorscomingdown", "dx_cp_cpr4_stlv_pric_carscomindown", "dx_cp_cpr4_stlv_alex_itsallcomindown"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0, 1, 0);
  wait 0.5;
  level.hadir _id_5D265B4FCA61F070::say("dx_cp_cpr4_stlv_hadr_nosister", 1, 0);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_stlv_fara_hadir_01", 0.4);
  scripts\engine\utility::flag_wait("hadir_elevator_crashed");
}

_id_0E8D3A766F14DA9A(count) {
  level waittill("damagable_lever_hit", lever, player);

  while(lever._id_30CA52AAA2C7B73A > count)
    level waittill("damagable_lever_hit", lever, player);

  return player;
}

_id_D9921B7E73BA606E() {
  _id_AC89E0692886C8BC = [getEnt("damagable_lever_left", "targetname"), getEnt("damagable_lever_right", "targetname")];
  player = _id_62E11D77B25C1D30::_id_71FC89B3E8140B4B(_id_AC89E0692886C8BC, 100)[0];
  thread _id_5296747427972510();
  aliases = ["dx_cp_cpr4_stlv_fara_imatacounterweight", "dx_cp_cpr4_stlv_pric_madeittoacounterweig", "dx_cp_cpr4_stlv_alex_reachedacounterweigh"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  player = _id_62E11D77B25C1D30::_id_6533A630C9443AAC(player.origin, player);
  aliases = ["dx_cp_cpr4_stlv_fara_tryhittingit", "dx_cp_cpr4_stlv_pric_justhitthebloodythin", "dx_cp_cpr4_stlv_alex_smashit"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
}

_id_ECB013AB73031ECD() {
  _id_62E11D77B25C1D30::_id_7C50C629B4D4086A(1, "vo_elevatorDefend_intro");
  _id_4C632F9F897BF250();
  childthread _id_A9DBAEF5868233A7();
  childthread _id_CB6B1DBC7E7D7A90();
  childthread _id_BEDA03FDDE788892();
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_scpw_fara_shit", 0.3);
  player = _id_62E11D77B25C1D30::_id_A16693E3894FAF9F();
  wait 3.2;
  aliases = ["dx_cp_cpr4_stlv_fara_theyrethrowingsmokeg", "dx_cp_cpr4_stlv_pric_aqsthrowingsmokeprep", "dx_cp_cpr4_stlv_alex_smokeincominggetread"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  wait 0.5;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_stlv_fara_getreadytheyrecoming", 0.3);
  wait 5;
  _id_CA233BC61873024C();
  _id_CA233BC61873024C();
  _id_CA233BC61873024C();
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_stlv_alex_takingheavyfire", 0.3);
  level thread _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.4, "dx_cp_cpr4_stlv_lasw_bravo62canyougetdown");
  level thread _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.2, "dx_cp_cpr4_stlv_gazz_callitcaptain");
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_stlv_pric_negativeholdyourgrou", 0.4);
  level _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.3, "dx_cp_cpr4_stlv_gazz_copyholdinghere");
  childthread _id_595DCB2C3D6AE050();
  childthread _id_D08F3E601C449D06();
  wait 6;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_stlv_pric_digindontletthemgett", 0.5);
  _id_62E11D77B25C1D30::_id_7C50C629B4D4086A(0, "vo_elevatorDefend_intro");
}

_id_4C632F9F897BF250() {
  level endon("3personDoorElevatorDefend_door_open");
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();
  checkpoint = scripts\engine\utility::ter_op(checkpoint != "", checkpoint, getDvar("start"));

  if(!scripts\engine\utility::_id_5B7E9A4C946F3A13(checkpoint, ["elevator_defend", "checkpoint_elevator_defend_start"]))
    wait 4.5;

  wait 1;
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_stlv_pric_bravo6towatcher1hadi", 0.4);
  level thread _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.2, "dx_cp_cpr4_stlv_lasw_doyouhaveeyesonhimwe");
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_stlv_pric_copystandbyforconfir", 0.3);
  wait 1;
  level _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.3, "dx_cp_cpr4_stlv_gazz_bravo62isonstationex");
  _id_6D1607B388B0CCA2 = [];

  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }
    if(player.origin[2] > -3705)
      _id_6D1607B388B0CCA2[_id_6D1607B388B0CCA2.size] = player;
  }

  if(_id_6D1607B388B0CCA2.size > 1) {
    _id_EEC55FABA21F3653 = (-270.972, 13629, -3895.25);
    player = _id_62E11D77B25C1D30::_id_47C84E03DCBC5AA7(_id_EEC55FABA21F3653, _id_6D1607B388B0CCA2);
    aliases = ["dx_cp_cpr4_stlv_fara_wecanusetheplatforms", "dx_cp_cpr4_stlv_pric_usetheplatformstojum", "dx_cp_cpr4_stlv_alex_wecanjumpdownoffthep"];
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.2);
  }

  wait 1;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_stlv_pric_wegottagetinthatelev", 0.2);
  nags = _id_F2D04A72F825CEE4(level.players);

  if(isDefined(nags[0]))
    nags[0].items = scripts\engine\utility::array_insert(nags[0].items, "dx_cp_cpr4_stlv_fara_weneedtogetthisopenh", 0);

  if(isDefined(nags[1]))
    nags[1].items = scripts\engine\utility::array_insert(nags[1].items, "dx_cp_cpr4_stlv_pric_helpmegetthisopen", 0);

  if(isDefined(nags[2]))
    nags[2].items = scripts\engine\utility::array_insert(nags[2].items, "dx_cp_cpr4_stlv_alex_comehelpmewiththis", 0);

  foreach(_id_81A329728ABB79E4 in nags) {
    if(isDefined(_id_81A329728ABB79E4))
      _id_81A329728ABB79E4.index = 0;
  }

  _id_05C70E8827622861("3personDoorElevatorDefend");
}

_id_CB6B1DBC7E7D7A90() {
  level endon("stop_vo_elevatorDefend_trophy");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++) {
    level waittill("trophy_created", _id_2424BA8D014C44FA);
    childthread _id_0E2E1F9DE59A7066(_id_2424BA8D014C44FA);
  }
}

_id_7AE01F9E148D5F62() {
  level._id_6A809E4A794ECE70 = [];

  for(;;) {
    level waittill("ai_spawn_successful", soldier, spawnpoint, _id_E19D9B9929460E79, _id_F8E5E3AA5762A8E7);

    if(soldier scripts\cp\utility::isjuggernaut())
      level._id_6A809E4A794ECE70[level._id_6A809E4A794ECE70.size] = soldier;
  }
}

_id_BF6B852953CB8A89() {
  return level._id_6A809E4A794ECE70;
}

_id_BEDA03FDDE788892() {
  childthread _id_7AE01F9E148D5F62();

  for(;;) {
    result = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(::_id_BF6B852953CB8A89, 0.8, 0.2, 0, [], 500, (0, 0, 20));
    _id_EC92A30C51B7A553 = scripts\engine\utility::array_remove(level._id_6A809E4A794ECE70, result[1]);
    result = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_EC92A30C51B7A553, 0.8, 0.2, 0, [], 500, (0, 0, 20), 2);

    if(!isDefined(result)) {
      continue;
    }
    player = result[0];
    break;
  }

  aliases = ["dx_cp_cpr4_stlv_fara_multiplejuggernauts", "dx_cp_cpr4_stlv_pric_wegotsomebigbastards", "dx_cp_cpr4_stlv_alex_multiplejuggsincomin"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
}

_id_0E2E1F9DE59A7066(_id_2424BA8D014C44FA) {
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_2424BA8D014C44FA, 0.8, 0.2, 0, [], 500, (0, 0, 20))[0];
  aliases = ["dx_cp_cpr4_stlv_fara_takeouttheirtrophysy", "dx_cp_cpr4_stlv_pric_nogrenadestheyvegott", "dx_cp_cpr4_stlv_alex_theyvegottrophiesact"];
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.4);
  level notify("stop_vo_elevatorDefend_trophy");
}

_id_11D7E6FE7CCB4E27() {
  wait 2;
  player = _id_62E11D77B25C1D30::_id_167FAE92423447B9(level.players, [level.farah]);
  aliases = ["dx_cp_cpr4_stlv_fara_thatsittheyredone", "dx_cp_cpr4_stlv_pric_allclear", "dx_cp_cpr4_stlv_alex_wereclear"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
  level _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.5, "dx_cp_cpr4_stlv_lasw_hellofajobdownthere");
  level _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.3, "dx_cp_cpr4_stlv_lasw_nowineedekiaconfirma");
  scripts\engine\utility::flag_set("elevatorDefend_vo_compelete");
  level endon("3personDoorElevatorDefend_door_open");
  wait 1;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_stlv_fara_timetofinishthis", 0.2);
  _id_05C70E8827622861("3personDoorElevatorDefend");
}

_id_D08F3E601C449D06() {
  _id_62E11D77B25C1D30::_id_7C50C629B4D4086A(1, "vo_elevatorDefend_waveProgression");
  _id_CDCD3C78F5177DB6 = (-288.051, 12897, -3647.54);
  _id_FC60036BA7BF253A = (-284.854, 13161.9, -4089.25);
  scripts\engine\utility::flag_wait("wave1_complete");
  ai = sortbydistance(getaiarray(), _id_FC60036BA7BF253A);

  if(ai.size > 0)
    ai[0] _id_5D265B4FCA61F070::say("dx_cp_cpr4_stlv_aqs1_gettotheelevatorroom", 0.3);
  else
    _id_D6ABCB75E41F1152(_id_CDCD3C78F5177DB6, "dx_cp_cpr4_stlv_aqs1_gettotheelevatorroom");

  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_stlv_alex_resupplywhileyoucan", 0.3);
  _id_62E11D77B25C1D30::_id_7C50C629B4D4086A(0, "vo_elevatorDefend_waveProgression");
  scripts\engine\utility::flag_wait("wave2_complete");
  _id_62E11D77B25C1D30::_id_7C50C629B4D4086A(1, "vo_elevatorDefend_waveProgression");
  wait 0.2;
  ai = sortbydistance(getaiarray(), _id_FC60036BA7BF253A);

  if(ai.size > 0)
    ai[0] _id_5D265B4FCA61F070::say("dx_cp_cpr4_stlv_aqs1_allbrotherstotheelev", 0.3);
  else
    _id_D6ABCB75E41F1152(_id_CDCD3C78F5177DB6, "dx_cp_cpr4_stlv_aqs1_allbrotherstotheelev");

  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_stlv_fara_soundslikethelastoft", 0.2);
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_stlv_pric_timetomakeourfinalst", 0.3);
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.alex, "dx_cp_cpr4_stlv_alex_diginletsdothis", 0.4);
  _id_62E11D77B25C1D30::_id_7C50C629B4D4086A(0, "vo_elevatorDefend_waveProgression");
  scripts\engine\utility::flag_wait("wave3_complete");
  _id_62E11D77B25C1D30::_id_7C50C629B4D4086A(1, "vo_elevatorDefend_waveProgression");
  wait 3;
  level thread _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.5, "dx_cp_cpr4_stlv_lasw_allstationsisrreveal");
  level thread _id_5D265B4FCA61F070::_id_FC0EB6B81C66C661(0.3, "dx_cp_cpr4_stlv_lasw_keepthepressureonyou");
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.price, "dx_cp_cpr4_stlv_pric_solidcopyletsmopthis", 0.2);
  _id_62E11D77B25C1D30::_id_7C50C629B4D4086A(0, "vo_elevatorDefend_waveProgression");
}

_id_A9DBAEF5868233A7() {
  _id_FC60036BA7BF253A = (-284.854, 13161.9, -4089.25);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cpr4_trnf_aqs1_theretheyare";
  aliases[aliases.size] = "dx_cp_cpr4_stlv_aqs2_gethadiroutofthereki";
  aliases[aliases.size] = "dx_cp_cpr4_stlv_aqs2_keepthemawayfromhadi";
  aliases[aliases.size] = "dx_cp_cpr4_stlv_aqs1_wearethekillers";
  aliases[aliases.size] = "dx_cp_cpr4_stlv_aqs2_defendtheelevator";
  aliases[aliases.size] = "dx_cp_cpr4_stlv_aqs2_theyalldiehere";
  aliases = scripts\engine\utility::create_deck(aliases);
  delay = _id_5D265B4FCA61F070::_id_B9007D9F0FF19676(0.2, 30, 5);
  _id_CA233BC61873024C();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++) {
    _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
    ai = getaiarrayinradius(_id_FC60036BA7BF253A, 600);

    if(ai.size == 0) {
      _id_AC0E594AC96AA3A8--;
      delay.current = delay.current - delay._id_2F977E27FA739602;
      waitframe();
      continue;
    }

    ai = sortbydistance(ai, _id_FC60036BA7BF253A);
    ai[0] _id_5D265B4FCA61F070::say(aliases scripts\engine\utility::deck_draw());
  }
}

_id_D6ABCB75E41F1152(origin, alias) {
  playsoundatpos(origin, alias);
  wait(lookupsoundlength(alias) / 1000);
}

_id_595DCB2C3D6AE050() {
  _id_126C2FDCADFBF3F7 = (-622.439, 13479.4, -4041.25);
  player = _id_62E11D77B25C1D30::_id_5BC7A5C4437D3803(_id_126C2FDCADFBF3F7, 0.9, 0.3, 0, [], 150)[0];
  aliases = ["dx_cp_cpr4_stlv_fara_theresgearinhere", "dx_cp_cpr4_stlv_pric_gunsandammohere", "dx_cp_cpr4_stlv_alex_wecanresupplyinhere"];
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(player, aliases, 0.3);
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
  if(msg != "death_or_disconnect")
    self endon("death_or_disconnect");

  ent endon("die");
  self waittill(msg, _id_A9B8FA5C0A14AD43, _id_A9B8FB5C0A14AF76, _id_A9B8FC5C0A14B1A9);
  ent notify("returned", msg, self, _id_A9B8FA5C0A14AD43, _id_A9B8FB5C0A14AF76, _id_A9B8FC5C0A14B1A9);
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