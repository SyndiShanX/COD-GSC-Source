/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\little_bird_mg_cp.gsc
***********************************************/

fulton_actors_players() {
  level thread fulton_used();
}

fulton_ac130_model(var_0, var_1) {
  var_2 = self;
  var_2 calloutmarkerping_removecallout(var_0);
  var_3 = getdvarint("_encstr_932B2B0B7E330F219A89697D5DE8D7AF72AAF06A5301D877107288BD9A16BF0D27859D413255A046CFE8505548", 82);
  var_4 = var_1.origin + (0, 0, var_3);
  var_5 = 1;
  var_6 = var_2 sethasspecialistbonus(1);
  var_7 = getdvarint("_encstr_AB780B650E2F678AB14949C071", 3);
  var_8 = var_2 sethasspecialistbonus(2);

  if(var_8 < var_6 && var_7 > 1) {
    var_6 = var_8;
    var_5 = 2;
  }

  var_9 = var_2 sethasspecialistbonus(3);

  if(var_9 < var_6 && var_7 > 2) {
    var_6 = var_9;
    var_5 = 3;
  }

  var_2 calloutmarkerping_create(var_5, var_4, 0);
  var_2 thread addquestrewardtierframeend(var_5);
  addquestrewardtier("_encstr_8A7A19CDB56889C8AAB3505F73EEDB87B3995BA0BAB7F1C8EF582D");
}

addquestrewardtier(var_0) {}

addpostlaunchspawns(var_0) {
  return var_0 == 9 || var_0 == 10 || var_0 == 11;
}

addplundercarrycredit(var_0) {
  return var_0 == 4 || var_0 == 5 || var_0 == 6;
}

addplayeraslootleader(var_0) {
  return var_0 == 1 || var_0 == 2 || var_0 == 3;
}

addquestrewardtierframeend(var_0, var_1, var_2) {
  var_3 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_4 = 2;
  var_5 = undefined;

  if(addplundercarrycredit(var_0)) {
    var_6 = var_3 calloutmarkerping_getsavedzoffset(var_0);

    if(isDefined(var_6)) {
      var_7 = getdvarint("_encstr_8B8B34620ECB57039BF8AD40AD6BC84BAE8FA733887342CF27690BC11B97BE0A10939169701966C7791B1E3B61ABE87941E9D201FF63", 1);

      if(var_7 && additionalrecondronetargets(var_6, var_3)) {
        if(isDefined(level._id_11A32) && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_B18D0B5281530117EDEAC82033" && scripts\engine\utility::array_contains(level._id_11A32, var_6))
          var_4 = getdvarfloat("_encstr_BA8B2637C639EBC6586336B75DA35BC24E6D5939E02DE69D7D8E93B01BADFA6DA53776AFA34BDA56", 0.0);
        else
          var_4 = getdvarfloat("_encstr_B8A228C0C63A894AE7B073F70B108587F8F765F289B27831E993B3E3423751E38D69B97DA31F9B09B505", 3.0);

        var_5 = var_6;
        addquestrewardtier("_encstr_93460F50D0F76A98DACB9A7E2B72EBEF4E");

        if(!istrue(var_2))
          var_6.update_bomb_vest_lua = 1;
      }

      var_3 thread fulton_interactions_disabled(var_0, var_6);

      if(isDefined(var_5) && istrue(var_2))
        return;
    }
  }

  var_3 notify("_encstr_AF8E187BEA1D58CBB25B4375379807A0BC054373DE4C18F77B0F" + var_0);
  var_3 endon("_encstr_AF8E187BEA1D58CBB25B4375379807A0BC054373DE4C18F77B0F" + var_0);

  if(addpostlaunchspawns(var_0)) {
    var_8 = var_3 calloutmarkerping_getsavedzoffset(var_0);
    var_3 thread calloutmarkerping_watchscriptabledeath(var_0, var_8);
  } else if(var_0 == 0) {
    if(getdvarint("_encstr_93B832573F9318A0A1DD4038839C984F2BB7E3DD8BCA58B8C735E913AC77207DF23F7D7F2323908819CD906B5067783F5A67D391", 0))
      var_3 thread fulton_create();
  } else if(var_0 == 8) {
    var_8 = var_3 calloutmarkerping_getsavedzoffset(var_0);
    var_3 thread fulton_interactions_disabled(var_0, var_8);
    var_3 thread fulton_handledamage(var_0, var_8);
  } else if(var_0 == 7) {
    var_9 = self getnodeoffset_code(7);

    if(var_9 == -1)
      calloutmarkerping_removecallout(var_0);
    else {
      var_3 thread fulton_refundsuper(var_0, var_9);
      var_3 thread fulton_planted(var_0, var_9);
    }
  } else if(var_0 == 12)
    var_3 thread fulton_open(12, var_1);

  if(!isDefined(var_5))
    var_4 = var_3 fulton_actors(var_0);

  addquestrewardtier("_encstr_AB571C1564EAF3D845FB22A89764533BE64E75847DB34B692FC760B012C0" + var_4 + "_encstr_966C0C3A58B9B03217F984CFFAB1" + var_0);
  wait(var_4);

  if(isDefined(var_5) && isDefined(var_3)) {
    if(isDefined(var_5.update_bomb_vest_lua))
      var_5.update_bomb_vest_lua = undefined;

    var_3 thread fulton_ac130_model(var_0, var_5);
  } else {
    addquestrewardtier("_encstr_97F81141B7ED6301E84BDA2B9110DB571D8E02" + var_0);
    var_3 calloutmarkerping_removecallout(var_0);
  }
}

addpowerbutton() {
  var_0 = self;

  for(var_1 = 0; var_1 < 13; var_1++) {
    if(var_0 calloutmarkerping_getfeedback(var_1))
      return var_1;
  }

  return -1;
}

addproptolist() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    var_0 waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_1, var_2, var_3);

    if(!isDefined(var_1) || !isDefined(var_2)) {
      continue;
    }
    addquestrewardtier("_encstr_A51E0E3BD0E372B480C16BB3549A90B6" + var_1 + "_encstr_B8EF0A1AE05080A37718ADB6" + var_2);

    switch (var_1) {
      case "_encstr_9584181FB9CDB0781F8310998B0F25186219BD9F1F763835679A":
        var_0 addallkillstreaksunlocked(var_2);
        break;
      case "_encstr_B64E1ACEB99532C81560AD36FA0AE28ACBC21077C9722A3799E3D5F4":
        var_0 addbattlepassxpmultiplier(var_2);
        break;
      case "_encstr_A76F1F1B58C636B7BA476B8527B695C907A5B976BE16C6DADCBD773656C8ECAC8C":
        var_0 addaccesscard(var_2, var_3);
        break;
      case "_encstr_8EDE26B1C28D8DEDD58EB60B93B659390E2DCD76FA85D8B537EDEE36CAC8B395917D1BB0B9B15636":
        var_0 addaliasarraytoqueue(var_2);
        break;
      case "_encstr_92A521B9C263F9B09BB46373DA44B8BEBBFA90A1C9BF2028B5A17F4DF56A1008BF5269":
        var_0 adddroponplayerdeath(var_2);
        break;
      case "_encstr_B6A9175B2C38BE8396379D7D192B1B59A3CAFAB6589CD659E4":
        var_0 addedcollision();
        break;
      case "_encstr_BE4F1A7A022EBB85F6687051EF92530E2670FF6039B2C14BF3C2EB8C":
        var_0 addallkillstreaksunlockedinonelife(var_2);
        break;
      default:
        break;
    }
  }
}

calloutmarkerping_initplayer() {
  var_0 = self;

  if(!isDefined(var_0.fxrings))
    var_0.fxrings = [];

  if(!isDefined(var_0.fulton_repositoryatcapacitycallback))
    var_0.fulton_repositoryatcapacitycallback = [];

  var_0 thread addproptolist();
}

addscriptedspawnpoints(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = var_0 getscriptablepartnameatindex(0);

  if(!isDefined(var_1))
    return 0;

  var_2 = var_0 getscriptablepartstate(var_1, 1);

  if(!isDefined(var_2))
    return 0;

  var_3 = var_0 getscriptablepartstatefield(var_1, var_2, "_encstr_81EF05D197C12B");

  if(!isDefined(var_3))
    return 0;

  if(var_3 != "_encstr_85200893580BE633381D")
    return 0;

  return 1;
}

additionalrecondronetargets(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(!isPlayer(var_0) && !isagent(var_0))
    return 0;

  if(!isDefined(var_0.team))
    return 0;

  if(var_0.team == "_encstr_A7A408B9CA5D1D4E2C63")
    return 0;

  return var_0.team != var_1.team;
}

addjuggsettings(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!isent(var_0))
    return issubstr(var_0.type, "_encstr_BEC61AA1729C8840BB7FE9C9CFC21D103A81C97A9BEAA00E934FDFC5") || issubstr(var_0.type, "_encstr_8AE71095B8EA2D1C7D66D5B1E8BD37F55B38");

  if(!isDefined(var_0.model))
    return 0;

  return var_0.model == "_encstr_AF92192B99F5A0DD67FBFA26F31713E04DE7AFD73E1EA0B08772BB";
}

addlaststandoverheadiconcallback(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!isent(var_0))
    return 0;

  if(!isDefined(var_0.model))
    return 0;

  return var_0.model == "_encstr_A7B622EA83601F0C1031879F2FF957FB1D7B5262EBC33705490D818BDBD14AA6D0F13AEF" || var_0.model == "_encstr_8F0D2663DAD76B2D3696D158C95ED7375BF2D0F6DB5B7DB20FE8E485D8A34BDEDCBEC098EBB1A199" || istrue(var_0._encstr_916E0FE16F109537A071F28B18085B8F80);
}

addincoming(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!isent(var_0))
    return 0;

  if(!isDefined(var_0.cratetype))
    return 0;

  switch (var_0.cratetype) {
    case "_encstr_B2AD0EADE3C1932783ABA66E30DB3448":
    case "_encstr_B85113DA10C8D7DAF1F17749F590E237E62B62C339":
    case "_encstr_8664130DAC859DE5EBBBAC581CEDB9EB6C9385E8AC":
    case "_encstr_BAE911E54813B56117F37033BF7F79EDEAF36D":
    case "_encstr_AF3514D21F237BBD6B61B37A48BB75F7BE755D4BA0C8":
    case "_encstr_9B0E1EC458E8D11B95AF27B7E50BC6B2F58E58C6A35A6CB08DD7192BD94B6CCA":
    case "_encstr_992A1BB5F7334D18E551C378C0C9D00D39573927CB1B9DD007756870AB":
    case "_encstr_96D516B648DD1B404537ADC86326F8CFFF133847B347132D":
    case "_encstr_A77318E360E304B2B3D01A552B636ADD2EC8263E82FE44CA8F5D":
    case "_encstr_A61A1913A6A320E023CF6BA0F08F0A196F3C05D4D70F2B1619B385":
    case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
    case "_encstr_85CE0B9770B02C73A1760F06D2":
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      return 1;
    default:
      return 0;
  }
}

addexecutionquip(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.vehiclename))
    return 0;

  return var_0.vehiclename == "_encstr_BAC20FBEE6F88945F163A37BD68409923B";
}

fulton_crate_model_playclosedidle(var_0) {
  return isDefined(var_0.equipmentref) && var_0.equipmentref == "_encstr_BAA11195B85DD20EF5DCABC1C1EDC9A309F6F0";
}

addjuggernautcharge(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!var_0 getscriptableisloot())
    return 0;

  if(var_0.type != "_encstr_9AB90F3127BEC1B1EA738CCA93D726DEE1")
    return 0;

  return 1;
}

fulton_cancreate(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!isent(var_0))
    return 0;

  if(!isDefined(var_0.classname))
    return 0;

  return issubstr(var_0.classname, "_encstr_8C8D08671D451291C849") || issubstr(var_0.classname, "_encstr_AC190457A459") || issubstr(var_0.classname, "_encstr_871A158393BD87B4AD4B8E5EF52B3CE01BDE9B5A672BAF") || issubstr(var_0.classname, "_encstr_8E230A8D8D2C97D6DBC9B2D7");
}

fullweaponname(var_0, var_1) {
  if(var_0 ismlgspectator() || var_0 isspectatingplayer())
    return 0;

  if(!isalive(var_0))
    return 0;

  if(istrue(var_0.mapmarkermodeenabled) && !isDefined(var_1))
    return 0;

  if(istrue(var_0.gulag))
    return 0;

  if(var_0 scripts\cp_mp\utility\player_utility::isusingremote())
    return 0;

  return 1;
}

remove_punchcard(var_0) {
  switch (var_0) {
    case 0:
      return undefined;
    case 1:
      return undefined;
    case 2:
      return undefined;
    case 3:
      return undefined;
    case 10:
      return "_encstr_A9AE0E07D2B9B3FACDB22B46D7CED59B";
    case 4:
      return "_encstr_961F1062CB5DF2D740B80F335199B21A07DE";
    case 5:
      return "_encstr_B192111CA5B976D7B995CA19D7D6A591D8B0C6";
    case 6:
      return "_encstr_8F6F11E0A5DC3BBECD9595917DE6D0B28D1BCD";
    case 7:
      return "_encstr_AADF134B1C2670E0B2CFABA10F4B3198CCB5D1E1C5";
    case 8:
      return "_encstr_8E7D130E5A9BCEBE3795B291EB632CAE73360DB293";
    case 9:
      return "_encstr_96751243C848EF794D25C7BFAF6952B7D0F07FBB";
    default:
      break;
  }

  return undefined;
}

remove_prohibited_weapons(var_0) {
  if(!isDefined(var_0))
    return "_encstr_B40101";

  switch (var_0) {
    case 0:
      return "_encstr_83A20883C6EA378C2B93";
    case 10:
      return "_encstr_AC20072B9FA9487832";
    case 4:
      return "_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69";
    case 3:
      return "_encstr_B87115F542355090F3E9B923535FD7190FA95F73F95A28";
    case 5:
      return "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD";
    case 6:
      return "_encstr_84DA105286BAFAFA6DF1A14B97D0EEA34B18";
    case 7:
      return "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9";
    case 8:
      return "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014";
    case 9:
      return "_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6";
    case 2:
    case 1:
      return "_encstr_83180CD38347BF3F7217FB9B6199";
    default:
      return "_encstr_B40101";
  }
}

fulton_handlefataldamage(var_0) {
  var_1 = self;

  if(!fullweaponname(var_1)) {
    return;
  }
  var_2 = var_1 calloutmarkerping_getfeedback(12);

  if(var_2) {
    var_3 = var_1 isdismembermentenabledforplayer(12);
    var_1 calloutmarkerping_removecallout(12);

    if(var_3 == var_0) {
      var_1 fulton_deletenextframe("_encstr_AB9A0FF88607CBB106F7EF29A065C925D1", 12);
      return;
    }
  }

  var_4 = getdvarint("_encstr_9A4525B812BA9741B75409F0258BC8B3E23AB038BB943D19775A807C0E4F315101B21840222F7D", 82);
  var_5 = (0, 0, var_4);
  var_1 calloutmarkerping_create(12, var_5, var_0);
  var_1 thread addquestrewardtierframeend(12, var_0);
  var_1 thread fxred(var_0);
}

fxred(var_0) {
  var_1 = self;
  wait(getdvarfloat("_encstr_955A3E03590E47E648913C378BC82D07B6F0FA9BC36B4BDFE1F92D0CBB587943558B5312C9B0D75388A7210659413A8B0386AB9A91961FCCB8ED5D1E419882BF", 0.5));
  var_2 = remove_punchcard(var_0);

  if(isDefined(var_2) && isDefined(var_1))
    var_1 fxent2(var_2, 12);
}

add_track_points(var_0) {
  var_1 = self;

  if(isalive(var_1)) {
    return;
  }
  if(!addpostlaunchspawns(var_0)) {
    return;
  }
  var_2 = var_1 calloutmarkerping_getsavedzoffset(var_0);

  if(!addjuggernautcharge(var_2)) {
    return;
  }
  var_1 notify("_encstr_966811918399F057DA5F5DCBCF43ADB04C1FD9");
}

fulton_hostage_vo() {}

fulton_repositoryusecallback(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = self;
  var_2 = var_1 calloutmarkerping_getsavedzoffset(var_0);
  var_3 = undefined;

  if(addpostlaunchspawns(var_0)) {
    var_4 = undefined;
    var_5 = 0;
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;

    if(isDefined(var_2))
      var_4 = var_2;
    else
      return;

    if(isDefined(var_4)) {
      var_5 = var_4 scriptableisdoor();

      if(var_5)
        var_6 = var_4 scriptabledoorisclosed();
      else
        var_7 = var_4 isplayerheadless();

      var_8 = addscriptedspawnpoints(var_4);
    }

    if(var_7 && !var_8 || var_5 && !var_6)
      var_3 = "_encstr_ACD7155893E8BFC9C1683A1258233D632689DFCFB5D1FB";
    else if(var_5)
      return;
    else if(isDefined(var_4) && isDefined(var_4.entity)) {
      if(addincoming(var_4.entity))
        var_3 = "_encstr_B15919A9EFAAFCA93304E8E0AAF41825B21F276F6FE23E30409CB1";
      else if(istrue(var_4.entity._encstr_9B3B102B429B47DBE40F9018E703708F73EC) || istrue(var_4.entity._encstr_BE3C13E343B64897AFAAB82123575D400CA1674FF3))
        var_3 = "_encstr_A33F145F3C82AFB628E3E030AB556BA76BA7D8ED159B";
      else if(istrue(var_4.entity.isjuggernaut))
        var_3 = "_encstr_AFAB1CB280D8CF512A4B233B674D4B055828EAF158A897AA755523078375";
      else if(addjuggsettings(var_2))
        var_3 = "_encstr_874E12031388CAE73020FB0519A0F281569BF397";
      else if(addexecutionquip(var_4.entity))
        var_3 = "_encstr_ABA5131C9673CEBE3B2BD096361B2BBE3459B09D5E";
      else if(istrue(var_4.entity.use_vehicle_turret))
        var_3 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
      else if(istrue(var_4.entity.unset_relic_noregen))
        var_3 = "_encstr_860616E16965C058431A89F1936F08C071FF43A50DCA089E";
      else if(addlaststandoverheadiconcallback(var_4.entity))
        var_3 = "_encstr_860616E16965C058431A89F1936F08C071FF43A50DCA089E";
    } else
      var_3 = var_1 fusesound(var_0, var_2);
  } else if(addplundercarrycredit(var_0))
    var_3 = var_1 fuselit(var_0, var_2);
  else if(addplayeraslootleader(var_0))
    var_3 = "_encstr_992213E05AB9D9D759B9ACB5F27DB3CAB9CA9C5836";
  else {
    switch (var_0) {
      case 0:
        if(level.gametype == "_encstr_B607038AAB" && isDefined(var_1.br_infil_type)) {
          if(istrue(var_1.tutorial_usingparachute))
            var_3 = "_encstr_8F51168396DCCEBEC6DB6C85A35AED9BBE1B2CCD324BCDB3";
          else
            var_3 = "_encstr_9BF32173F878DF491970168EE53B026EE678AF8368701EF227169B0744DB1B3C48F81B";
        } else
          var_3 = "_encstr_860616E16965C058431A89F1936F08C071FF43A50DCA089E";

        break;
      case 8:
        var_3 = var_1 fx_ent_index(var_0, var_2);
        break;
      case 7:
        var_3 = var_1 fx_ents(var_0);
        break;
      default:
        break;
    }
  }

  var_1 fxent2(var_3, var_0);
}

addplayerasexpiredlootleader(var_0) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_87AF07C852A26B705F")) {
    return;
  }
  if(addpostlaunchspawns(var_0))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_87AF07C852A26B705F")]]("_encstr_BE9907FFAB82953044");
  else if(addplundercarrycredit(var_0)) {
    var_1 = self calloutmarkerping_getsavedzoffset(var_0);

    if(isDefined(var_1)) {
      if(additionalrecondronetargets(var_1, self)) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_87AF07C852A26B705F")]]("_encstr_88BF06FD784A6393");
        return;
      }

      if(!isPlayer(var_1)) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_87AF07C852A26B705F")]]("_encstr_BE9907FFAB82953044");
        return;
      }

      return;
      return;
    }
  } else if(addplayeraslootleader(var_0))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_87AF07C852A26B705F")]]("_encstr_83A107A3F3185A4DB0");
  else {
    switch (var_0) {
      case 12:
      case 8:
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_87AF07C852A26B705F")]]("_encstr_BE9907FFAB82953044");
        break;
      case 7:
      case 0:
        break;
    }
  }
}

fuselit(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_1) && isent(var_1))
    var_3 = var_1;
  else
    return "_encstr_B40101";

  if(isPlayer(var_3) && var_3.team == self.team)
    return "_encstr_B6D11507B4CD76FAC9CADCE0B79BCD56AF43958D386B2B";
  else if(isDefined(var_3.juggcontext) || istrue(var_3.isjuggernaut))
    return "_encstr_AFAB1CB280D8CF512A4B233B674D4B055828EAF158A897AA755523078375";
  else if(fulton_crate_model_playclosedidle(var_3))
    return "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(isDefined(var_3.equipmentref) && var_3.equipmentref == "_encstr_961B0FBD525BDB0B5F7F60805FAA851F33")
    return "_encstr_82F712E823580F5969C84AC2C08181CF73994F62";
  else if(fulton_cancreate(var_3))
    return "_encstr_830A1182B0E8FF613D5517CF83C81B22483BFA";
  else if(addjuggsettings(var_3))
    return "_encstr_874E12031388CAE73020FB0519A0F281569BF397";
  else if(isPlayer(var_3) && istrue(var_3.inlaststand) && var_3.team != self.team) {
    var_4 = var_2 fx_model("_encstr_81CB18CFD85826BA7EFFFB83EBA3427A0141C097D1ABEC12D885");
    var_5 = var_2 fx_obj("_encstr_81CB18CFD85826BA7EFFFB83EBA3427A0141C097D1ABEC12D885");

    if(isDefined(var_4) && isDefined(var_5)) {
      var_6 = soundexists(var_4);
      var_7 = soundexists(var_5);

      if(istrue(var_6) && istrue(var_7))
        return "_encstr_81CB18CFD85826BA7EFFFB83EBA3427A0141C097D1ABEC12D885";
    }
  } else if(var_3.model == "_encstr_AFE11FDA4B632DE8C29CF2FA166BB5F6D74E59DCD1DE6C6D7D63B7C6853AA5DBB9")
    return "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(var_3.model == "_encstr_849E1AF870BB97819B9DAB286060C8E9D8781B0A7B6AF8239F476043")
    return "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_3.model, "_encstr_95D81EE89F6E48BFF28B9FC787C9F6280E7351A005D550789A87FF8F9B7248C0") || var_3.model == "_encstr_AC031B3F45FE086186D1BE0C7FB6A87F02CA27A61FF0013B1AF8902F4A")
    return "_encstr_BE0718E24BDD72572178AF9FD1D9321A85D76FDFA163FBB8C998";
  else if(scripts\mp\utility\entity::isturret(var_3)) {
    if(isDefined(var_3.owner) && var_3.owner.team != self.team)
      return "_encstr_AAAF2463FAD3D49984318991332BB8AD97B29B0EE3631BB09D14B1AB5A92D8EDC7CAB0F1EAFF";

    return "_encstr_8E8023D197D284C12B1CC0D8821CE0CD9A374F07075A5B287437CBF3EAE280FD11BFC18BDB";
  } else if(issubstr(var_3.model, "_encstr_836007B99B42E3283F"))
    return "_encstr_860616E16965C058431A89F1936F08C071FF43A50DCA089E";
  else if(issubstr(var_3.model, "_encstr_836E09C13FB0E8359853BB"))
    return "_encstr_ABE31BC187C294D15B6CB0C8922CF0DD6A277F1777FAE6F86586B8E1FA";

  return "_encstr_A16C1450ABD087C1DB78522A3857846B0907C6ECBE5A";
}

fx_ent_index(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_1) && isent(var_1))
    var_3 = var_1;
  else
    return "_encstr_B40101";

  if(isDefined(var_3.streakname)) {
    switch (var_3.streakname) {
      case "_encstr_86FD08B775CD07DC1338":
        return "_encstr_8BA0197BF070A7311F7BCDC55E19DB6D3978FF3F68CB16BB7103D2";
      case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
        return "_encstr_8461165893E8BFC9CF58CAC260197A4FE10AC3FFBBD1DB8D";
      case "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC":
        return "_encstr_AB7D175893E8BFC9CF58CAC260197A4FE10AC3FFB6D1E78D9D";
      case "_encstr_B1B30B51D176511E377A1BC313":
        return "_encstr_AB7D175893E8BFC9CF58CAC260197A4FE10AC3FFB6D1E78D9D";
      case "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B":
        return "_encstr_93A91B952EEA2D07DAB2378EFA96CDB1EDADA5B93BFAD9ACCD56C9D26C";
      default:
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_870D05C1969BB3", "_encstr_A25E1CB0A2ADF7D6CF38E0E405BB1D211BCAE8F0FAC53B6D9F5C71E80D43")) {
    var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_870D05C1969BB3", "_encstr_A25E1CB0A2ADF7D6CF38E0E405BB1D211BCAE8F0FAC53B6D9F5C71E80D43")]](var_3);

    if(isDefined(var_4) && istrue(var_4.fail_on_transmission_timeout))
      return var_4._id_142F4;
  }

  if(!isDefined(var_3.vehiclename))
    return "_encstr_B2921ECB98121749330DC390F75A6A979EB780AFA19147EB6AFF61581825ED6A";

  var_5 = addplatepouch(var_3, var_2.team);
  var_6 = isDefined(var_3.ownerteam) && var_3.ownerteam == var_2.team;

  if(istrue(var_5)) {
    switch (var_3.vehiclename) {
      case "_encstr_BE820B53A080CF0245ADFC77B7":
      case "_encstr_97AE0AF6E0959BEB4D2B95C1":
      case "_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB":
      case "_encstr_BDC80A5437EAD749519A6068":
      case "_encstr_99C20BA548E9F27A61D897932B":
      case "_encstr_91F511673FA9BB292DD8BAE321179E73A328F3":
      case "_encstr_911904464232":
      case "_encstr_84D70A6B2BEF3C9B30A67164":
      case "_encstr_9A120A1D8536F5E4ED3BB293":
      case "_encstr_8FD60D6AA0EAB34083F7C423A0213B":
      case "_encstr_85DE05A6B2AC0E":
      case "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6":
      case "_encstr_8C190467402B":
        return "_encstr_8C5C1938D2DCB3D7AC9B59D6BCFAB3B2A1B46CB1597D8DB49D34D1";
      case "_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843":
      case "_encstr_83F40783ADF1D14AA3":
      case "_encstr_BAC20FBEE6F88945F163A37BD68409923B":
      case "_encstr_86510C82737817CD40B38B720A15":
        return "_encstr_91201982D816D1776FD0DA1D6B60EB40C1631B591D914CB2670551";
      case "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F":
      case "_encstr_9A8F0CB1A5E8471BB2EB894B39C8":
        return "_encstr_8461165893E8BFC9CF58CAC260197A4FE10AC3FFBBD1DB8D";
      case "_encstr_AF390B295782C3585F1B21D8C4":
        return "_encstr_97D318ABD0FDFC979498487887D3CA9F812F37B97718DE399079";
      case "_encstr_8C980A867B3B569CFAA659E8":
        return "_encstr_82F319F31FE53A074064E86CD0D3BAD5BA18039830E7BB235777DB";
      case "_encstr_B1B30B51D176511E377A1BC313":
        return "_encstr_B2251A288B28871FD240B2BAEBB553FFB817A3BF1F404FBF093B9A62";
      case "_encstr_9BEF16359B67FDA671371305E0BDB293E166C898324FA18B":
        return "_encstr_81C9124A782037B97C8B9B97EF294257B841C515";
      default:
    }
  } else if(istrue(var_6)) {
    switch (var_3.vehiclename) {
      case "_encstr_BE820B53A080CF0245ADFC77B7":
      case "_encstr_97AE0AF6E0959BEB4D2B95C1":
      case "_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB":
      case "_encstr_83F40783ADF1D14AA3":
      case "_encstr_BDC80A5437EAD749519A6068":
      case "_encstr_99C20BA548E9F27A61D897932B":
      case "_encstr_91F511673FA9BB292DD8BAE321179E73A328F3":
      case "_encstr_911904464232":
      case "_encstr_84D70A6B2BEF3C9B30A67164":
      case "_encstr_9A120A1D8536F5E4ED3BB293":
      case "_encstr_8FD60D6AA0EAB34083F7C423A0213B":
      case "_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E":
      case "_encstr_85DE05A6B2AC0E":
      case "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6":
      case "_encstr_8C190467402B":
        return "_encstr_BEC3136021F56FDFFB821A59C8F1CBA7D5E8A7D8C8";
      case "_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843":
      case "_encstr_AF390B295782C3585F1B21D8C4":
      case "_encstr_BAC20FBEE6F88945F163A37BD68409923B":
      case "_encstr_86510C82737817CD40B38B720A15":
        return "_encstr_ABA5131C9673CEBE3B2BD096361B2BBE3459B09D5E";
      case "_encstr_9BEF16359B67FDA671371305E0BDB293E166C898324FA18B":
      case "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F":
      case "_encstr_9A8F0CB1A5E8471BB2EB894B39C8":
        return "_encstr_81C9124A782037B97C8B9B97EF294257B841C515";
      default:
    }
  } else {
    switch (var_3.vehiclename) {
      case "_encstr_BE820B53A080CF0245ADFC77B7":
      case "_encstr_97AE0AF6E0959BEB4D2B95C1":
      case "_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB":
      case "_encstr_BDC80A5437EAD749519A6068":
      case "_encstr_99C20BA548E9F27A61D897932B":
      case "_encstr_91F511673FA9BB292DD8BAE321179E73A328F3":
      case "_encstr_911904464232":
      case "_encstr_84D70A6B2BEF3C9B30A67164":
      case "_encstr_9A120A1D8536F5E4ED3BB293":
      case "_encstr_8FD60D6AA0EAB34083F7C423A0213B":
      case "_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E":
      case "_encstr_85DE05A6B2AC0E":
      case "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6":
      case "_encstr_8C190467402B":
        return "_encstr_BEC3136021F56FDFFB821A59C8F1CBA7D5E8A7D8C8";
      case "_encstr_8D860D49508DBBF831085BF0335F07":
      case "_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843":
      case "_encstr_83F40783ADF1D14AA3":
      case "_encstr_AF390B295782C3585F1B21D8C4":
      case "_encstr_BAC20FBEE6F88945F163A37BD68409923B":
      case "_encstr_86510C82737817CD40B38B720A15":
        return "_encstr_ABA5131C9673CEBE3B2BD096361B2BBE3459B09D5E";
      case "_encstr_9BEF16359B67FDA671371305E0BDB293E166C898324FA18B":
      case "_encstr_A7B30DE187CA05B92B54B8537A15E8":
      case "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F":
      case "_encstr_9A8F0CB1A5E8471BB2EB894B39C8":
        return "_encstr_81C9124A782037B97C8B9B97EF294257B841C515";
      case "_encstr_96640DCD1EC91F027169CBA3D0B7BC":
        return "_encstr_BEC3136021F56FDFFB821A59C8F1CBA7D5E8A7D8C8";
      default:
    }
  }
}

fx_ents(var_0) {
  var_1 = self;

  if(level.gametype != "_encstr_B607038AAB")
    return "_encstr_860616E16965C058431A89F1936F08C071FF43A50DCA089E";

  var_2 = var_1 getnodeoffset_code(7);

  if(isDefined(level.questinfo) && isDefined(level.questinfo.quests) && isDefined(level.questinfo.quests["_encstr_951904D8F1E0"]) && isDefined(level.questinfo.quests["_encstr_951904D8F1E0"].instances)) {
    foreach(var_6, var_4 in level.questinfo.quests["_encstr_951904D8F1E0"].instances) {
      var_5 = var_4.objectiveiconid;

      if(!isDefined(var_5)) {
        continue;
      }
      if(var_5 == var_2)
        return "_encstr_A16C1450ABD087C1DB78522A3857846B0907C6ECBE5A";
    }
  }

  var_7 = var_1 calloutmarkerping_entityzoffset("_encstr_A7AE16D39FC90ED0179519103F13D833F3370F136BA245C8");

  if(!isDefined(var_7) || var_7 == 0)
    return "_encstr_860616E16965C058431A89F1936F08C071FF43A50DCA089E";

  var_8 = tablelookup("_encstr_B468129A5318AD6BD8338F9B6A9F73E01059A86B", 0, var_7, 1);

  switch (var_8) {
    case "_encstr_845409AAEF42B8A367AFBD":
    case "_encstr_97580E238AD72960B651E3379C0EE7F9":
    case "_encstr_A19B096816E6C71BC36072":
    case "_encstr_AADD079327E9CA81D2":
    case "_encstr_8D600AE8F5694A3F2C68BA72":
    case "_encstr_B82D088332497B18D26E":
    case "_encstr_A93908FBBAC970BACA02":
    case "_encstr_B4AB0698A3B0E99A":
    case "_encstr_8745086CF27708C893BF":
    case "_encstr_B47808F8E26FEBB7D25B":
    case "_encstr_92A40EF9E31F7F501AA96573DCC4E8B0":
    case "_encstr_A6B10B0EF0CF8423188FFF5B36":
    case "_encstr_9A3F1133610DE2C03888058B21400C4BEF9793":
      if(var_1 func_load_difficulty_table("_encstr_A5AA18AB80982F61C005A2B51F40B423B5FE12C2886DA3268841"))
        return "_encstr_A5AA18AB80982F61C005A2B51F40B423B5FE12C2886DA3268841";

      return "_encstr_860616E16965C058431A89F1936F08C071FF43A50DCA089E";
    case "_encstr_A11904D82B38":
    case "_encstr_ACE0106BABFBACE38DF73568015199D47F83":
    case "_encstr_AF460A7B2649F34FE367455D":
      if(var_1 func_load_difficulty_table("_encstr_A5AA18AB80982F61C005A2B51F40B423B5FE12C2886DA3268841"))
        return "_encstr_A5AA18AB80982F61C005A2B51F40B423B5FE12C2886DA3268841";

      return "_encstr_A604164858E0F7AF3F4814A7915BD3EB0B81712A981A40F7";
    case "_encstr_BD6E090B60F9C74FC88B06":
      if(var_1 func_load_difficulty_table("_encstr_A5AA18AB80982F61C005A2B51F40B423B5FE12C2886DA3268841"))
        return "_encstr_A5AA18AB80982F61C005A2B51F40B423B5FE12C2886DA3268841";

      return "_encstr_A33F145F3C82AFB628E3E030AB556BA76BA7D8ED159B";
    default:
      break;
  }

  return "_encstr_860616E16965C058431A89F1936F08C071FF43A50DCA089E";
}

fusesound(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_1) && isDefined(var_1.type))
    var_3 = var_1.type;
  else
    return "_encstr_B40101";

  var_4 = 0;
  var_5 = tablelookupgetnumrows(level.brloottablename);
  var_6 = undefined;

  for(var_7 = var_4; var_7 < var_5; var_7++) {
    var_8 = tablelookupbyrow(level.brloottablename, var_7, 1);

    if(var_8 == var_3) {
      var_6 = tablelookupbyrow(level.brloottablename, var_7, 12);

      if(var_6 == "_encstr_B40101") {}

      break;
    }
  }

  if(!isDefined(var_6)) {
    if(var_3 == "_encstr_A1EB22D00BAC5067F3799FA9CB6A49D91A2760F8FB6A29379B9C18A0A9539BA3758F523A" || var_3 == "_encstr_93EB22233820DF425110DAD56D3DAA9D4BE9B7D3E01B094A7913654D40EFB234F1815A72" || var_3 == "_encstr_8AE71095B8EA2D1C7D66D5B1E8BD37F55B38") {
      if(var_2 func_load_difficulty_table("_encstr_97BA1F389673D97D9D951A2D1BC6B2D73685DC0DFA46B2E0B7DC2DA3F5D0ACB1DB"))
        return "_encstr_97BA1F389673D97D9D951A2D1BC6B2D73685DC0DFA46B2E0B7DC2DA3F5D0ACB1DB";

      return "_encstr_874E12031388CAE73020FB0519A0F281569BF397";
    } else if(var_3 == "_encstr_A2E6149A4380B76CA8893A3FB999B6B3371BF24189EE")
      return "_encstr_A346130729FBA9F75292F0102A2F656617C906F3BD";
    else if(var_3 == "_encstr_BE0A1566C6BF32694380BFA738B825B9B95EAD9A2775EA" || var_3 == "_encstr_85E418214B17D668C22A838B222D2BB0AB525BAB22131858DC1E" || var_3 == "_encstr_91361613EE974BD9233224936601C9C72707C3D8E2378029")
      return "_encstr_BE0718E24BDD72572178AF9FD1D9321A85D76FDFA163FBB8C998";
    else if(var_3 == "_encstr_8E631A3798D3B367DBC2F348F20F43B7BBE097E064C9B121B9C7E72D" || var_3 == "_encstr_A3BC1661B25F6885DA3F8BB9EF91D660FACCAB3B9EBA884D" || var_3 == "_encstr_BE7C15B663D144D2A8F16F87EBCEDB85F02E6EBC391804" || var_3 == "_encstr_AAE30F09DA1768F8A2EF8781F73B33E8CE")
      return "_encstr_860616E16965C058431A89F1936F08C071FF43A50DCA089E";
    else if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "_encstr_A6712ADEBE43B3532CD75820AF6F69FDF9A55BE994FB6BDBF917585097670635E24A4DE0EEA24FCDC7172890")
      return "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";

    return "_encstr_B40101";
  }

  var_9 = "_encstr_B40101";

  if(issubstr(var_6, "_encstr_A28C0EFAA0135539222A297D0D82A924"))
    var_9 = "_encstr_A96012E0B47376AFC136573791B2937D36EDB7E8";
  else if(issubstr(var_6, "_encstr_ADF20E611F468D9FB9A678434D914334") || issubstr(var_6, "_encstr_A362131BC5ED59D023788034C07B19A9334A837BA3"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_99D20DE132C9A95AA6DF1CF1C8F9E2")) {
    if(!isalive(var_2))
      var_9 = "_encstr_8A7C1057BB308CF9A0F0C837736ED5849F50";
    else
      var_9 = "_encstr_A33F145F3C82AFB628E3E030AB556BA76BA7D8ED159B";
  } else if(issubstr(var_6, "_encstr_8C2A0CA749F0F5CF8D6C615169C7") || issubstr(var_6, "_encstr_8EFC07539179931F29"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_86AD0C21142A1A09AFA6219E928A"))
    var_9 = "_encstr_860616E16965C058431A89F1936F08C071FF43A50DCA089E";
  else if(issubstr(var_6, "_encstr_92A80F1160822311425447B1795CBF3B90"))
    var_9 = "_encstr_A33F145F3C82AFB628E3E030AB556BA76BA7D8ED159B";
  else if(issubstr(var_6, "_encstr_AD7B0E05BA7D491EA93FE1F55F20CDE9"))
    var_9 = "_encstr_860616E16965C058431A89F1936F08C071FF43A50DCA089E";
  else if(issubstr(var_6, "_encstr_87C209BE35217AA83A5539"))
    var_9 = "_encstr_A3F3126BF2DBECA10E3D939F67F260A0DB8A4310";
  else if(issubstr(var_6, "_encstr_8C740FE9155175C080B1274F8DA678B571"))
    var_9 = "_encstr_923F139119F550C8E78AF8A0B18B9F888D6B2923AA";
  else if(issubstr(var_6, "_encstr_921C08AFE3290C69E042"))
    var_9 = "_encstr_8A0B12BB220B1C51FECD434FD76438D4FB7A11A0";
  else if(issubstr(var_6, "_encstr_973C0857A74F7FED63C9"))
    var_9 = "_encstr_B6A01570D370DF77BFB8CAD2C681E75740AB14E15D8022";
  else if(issubstr(var_6, "_encstr_82330CBE824A9A459E31FA4D9AD1"))
    var_9 = "_encstr_AB611397D90B5907E612A0A8293A2BD1BB74968724";
  else if(issubstr(var_6, "_encstr_A7B606D88769EF42") || var_6 == "_encstr_B4B41911296BD34F7F157075477B37378260B961803159E4777B6B")
    var_9 = "_encstr_82F712E823580F5969C84AC2C08181CF73994F62";
  else if(issubstr(var_6, "_encstr_B21A04BE8294"))
    var_9 = "_encstr_889F1983D2CD9DAFEEACB083B7B9F5586ECD16D51B3A934B99B1B2";
  else if(issubstr(var_6, "_encstr_A11A04BE9AA6"))
    var_9 = "_encstr_8E4A10A7C91B491773E2B0403A4D5F834F6F";
  else if(issubstr(var_6, "_encstr_831A048777AB"))
    var_9 = "_encstr_8224146704BA97BE27DF48B88F46F6F7822DDD649B52";
  else if(issubstr(var_6, "_encstr_951A0491C829"))
    var_9 = "_encstr_A3CC13FB70F027B1A7FD0E42D0AD89F8B838637FB0";
  else if(issubstr(var_6, "_encstr_931A04C943C0"))
    var_9 = "_encstr_8DCC13DF8153014F2BAA0888E285975BFB3967DDF2";
  else if(issubstr(var_6, "_encstr_B41A04FA316A"))
    var_9 = "_encstr_974910436870D799E8930118AF0851232941";
  else if(issubstr(var_6, "_encstr_BA1A04AFE363"))
    var_9 = "_encstr_964815F13060F95F93490E207FA098298FF59666C37740";
  else if(var_6 == "_encstr_8EC019A73118A8DA79F7207ACDA11D10988D3F37514E5089811C6F" || var_6 == "_encstr_B23E1BA9A0972449AF8A2B2851F5D454D768D39A215051A990922AC488")
    var_9 = "_encstr_87F017988A85EFCEEB59868A3D93B68D2C723038329C136093";
  else if((issubstr(var_6, "_encstr_A11A04BE6AA2") || var_6 == "_encstr_AF3116FD8748A3321F390189A9C7BF779CE56A61B6EEDF4D") && !issubstr(var_6, "_encstr_86BA076148CF098D9B"))
    var_9 = "_encstr_919D12C12DCD9D7DEE9516E0BDE6D7ADACB15695";
  else if(issubstr(var_6, "_encstr_86BA0B81680D270FE7E3131886") || issubstr(var_6, "_encstr_AD75062D5F38972E") || issubstr(var_6, "_encstr_88A9065F05D67961") || issubstr(var_6, "_encstr_AFD3071727ABF7ABD1") || issubstr(var_6, "_encstr_BE7206AAD4013320") || issubstr(var_6, "_encstr_9B6609E925886F72B34083") || issubstr(var_6, "_encstr_939A0E4F63499F675D65F92BF1EF5609") || issubstr(var_6, "_encstr_8F0D1072AA5312A829357DD149519314228A"))
    var_9 = "_encstr_96D81A832DCDCEBE0B5BB5B7D77693569B168C59D10B6C3A4BD8B01B";
  else if(issubstr(var_6, "_encstr_A2820AB3B9BDCAD92505FEA3") || issubstr(var_6, "_encstr_8ECF0B70011570776DF95B0E52"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_8DD6078169A994F36D") || issubstr(var_6, "_encstr_9BD1091AC428AC35F4A48A") || issubstr(var_6, "_encstr_8B070368D0") || issubstr(var_6, "_encstr_8A78054CCD499C") || issubstr(var_6, "_encstr_930107EF890CFCF801") || issubstr(var_6, "_encstr_8D760984733FCAD9C0ADBF") || issubstr(var_6, "_encstr_ACA80981DB59AF575C75E9") || issubstr(var_6, "_encstr_8DCB081BCF6D015D4F09"))
    var_9 = "_encstr_BE0718E24BDD72572178AF9FD1D9321A85D76FDFA163FBB8C998";
  else if(issubstr(var_6, "_encstr_8CDB0FFB2B06E1E981BD9D5115093E0866") || issubstr(var_6, "_encstr_9BB407CB9E6F7940D0") || issubstr(var_6, "_encstr_AD050BA42A1A3DC98894D3278A") || issubstr(var_6, "_encstr_A274092AA6148849E99354") || issubstr(var_6, "_encstr_878F0CFB6347A0B3915C9F55D599") || issubstr(var_6, "_encstr_BEA30A39077DC497608AB027") || issubstr(var_6, "_encstr_A3FE0B9957FC444106D49E4017") || issubstr(var_6, "_encstr_992E0CD727715F01D29366DD4DF0") || issubstr(var_6, "_encstr_8C440B51500DEB9493D42A29A2") || issubstr(var_6, "_encstr_82C115751803F7219E0DC9876373992733610E5DE18FB7") || issubstr(var_6, "_encstr_B2F0094C55DE8120B0A711") || issubstr(var_6, "_encstr_97100E0997B020F9CF42178DBBF1B9E8") || issubstr(var_6, "_encstr_BAF90B964AF435B47D2292D305") || issubstr(var_6, "_encstr_8B9807921453535194") || issubstr(var_6, "_encstr_834310A2A5CDFF47FE9FFEB90F85A33FC1D3") || issubstr(var_6, "_encstr_82571E35827D0992D72572A30AA954FAA2AAFA752D66D0A6F29A895293A35129")) {
    if(var_2 func_load_difficulty_table("_encstr_96F719CBDB30725F78D8363C735097DA1B6B23139B673A4A2881AF"))
      var_9 = "_encstr_96F719CBDB30725F78D8363C735097DA1B6B23139B673A4A2881AF";
    else
      var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  } else if(issubstr(var_6, "_encstr_958F090DD39C2A9405D0A8")) {
    if(issubstr(var_6, "_encstr_B1CC0905D4A90A4D4D9472"))
      var_9 = "_encstr_A38F1DC360F847F137408FB84B19E1B0FE58D5C3532631B4179B8D73B08373";
    else if(issubstr(var_6, "_encstr_A1580B119E5352930AA252E9C9"))
      var_9 = "_encstr_AA481C704B3067212398729B980BA5CFC920E60C5E79CF33A790BAE2C07D";
    else if(issubstr(var_6, "_encstr_AF460A7F366973CF636F651D"))
      var_9 = "_encstr_845D2023745E0898AAFB9BB9FF725981EB4D683B5AB9F0C5E1E7879BABDA90F88562";
    else if(issubstr(var_6, "_encstr_951904D9D1E1"))
      var_9 = "_encstr_963A213F2A80BFB828A8ABEBD927B0A08A952B28BBBE90B9A06A450BF3F4B308587AC0";
    else if(issubstr(var_6, "_encstr_863708C32B0966591B4B"))
      var_9 = "_encstr_A71E26882B88277FB3C0825B089F8B9148BF1EF475A86E1B70994B031166F7158803907CCD40B643";
    else if(issubstr(var_6, "_encstr_BD6E090964E94747C9CB26"))
      var_9 = "_encstr_A2EE203017DE4117320523B5DC6AA98E3BF74888D3699909396A25BF7292CB53755B";

    if(var_9 != "_encstr_B40101" && !var_2 func_load_difficulty_table(var_9))
      var_9 = "_encstr_B40101";

    if(var_9 == "_encstr_B40101")
      var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";

    if(var_9 != "_encstr_B40101" && !var_2 func_load_difficulty_table(var_9))
      var_9 = "_encstr_B40101";

    if(var_9 == "_encstr_B40101")
      var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  } else if(issubstr(var_6, "_encstr_88EA08E8284D9AA035A5")) {
    if(var_2 func_load_difficulty_table("_encstr_86980DEAD8809719542317670B0602"))
      var_9 = "_encstr_86980DEAD8809719542317670B0602";
    else
      var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  } else if(issubstr(var_6, "_encstr_83540EA4159A0528EAE47D51D3962A39") || issubstr(var_6, "_encstr_96110B31414C0967FFF917CB60"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(var_6 == "_encstr_A6B718A7391FF1B95B655DC3486BB052A5692F0B019435711D86" || var_6 == "_encstr_8C9924D482AF2494FA94938E82A951CB964A7AA696BE4A458A9AEBD4518964F52551B2A4AC15")
    var_9 = "_encstr_97DB1342EBBD12376338F72F209BFF2A7377CDFBC3";
  else if(var_6 == "_encstr_AC6F1AB178FD699FAB52A5AF536FC8A316B0C979404101179BBA5D3D")
    var_9 = "_encstr_8E8023D197D284C12B1CC0D8821CE0CD9A374F07075A5B287437CBF3EAE280FD11BFC18BDB";
  else if(issubstr(var_6, "_encstr_AFC60C7805CE67A2E13FCBD13D81")) {
    if(var_2 func_load_difficulty_table("_encstr_B18B15DF8153014FED0A78A8E146EF59D723E6DEE15B29"))
      var_9 = "_encstr_B18B15DF8153014FED0A78A8E146EF59D723E6DEE15B29";
    else
      var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  } else if(issubstr(var_6, "_encstr_85CE0B1771B40C71E166070EC2") || var_6 == "_encstr_978B14192181771394B3444D50FCBF4D79BA30B00121")
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_8C0A1127D9192BBBA525B1690D83EB52D967A4")) {
    if(var_2 func_load_difficulty_table("_encstr_ABB91AD7FF730C4E6F23E7389781BFF0BA42EB0B8FE6CF787D3A8032"))
      var_9 = "_encstr_ABB91AD7FF730C4E6F23E7389781BFF0BA42EB0B8FE6CF787D3A8032";
    else
      var_9 = "_encstr_874E12031388CAE73020FB0519A0F281569BF397";
  } else if(issubstr(var_6, "_encstr_93270EBF77E5B180270135DD4927D0D1"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_BE5210698A6DEF4CC121E31F99A2302C3597"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_A1530B053E2249D039CB0B03A3"))
    var_9 = "_encstr_860616E16965C058431A89F1936F08C071FF43A50DCA089E";
  else if(issubstr(var_6, "_encstr_8159085BC253DF779EA9"))
    var_9 = "_encstr_860616E16965C058431A89F1936F08C071FF43A50DCA089E";
  else if(issubstr(var_6, "_encstr_AAA70897F144D460013F"))
    var_9 = "_encstr_860616E16965C058431A89F1936F08C071FF43A50DCA089E";
  else if(issubstr(var_6, "_encstr_ADCF1A24111919D1B7D0EF23DFC327398FAEF154B1C138DB81FF2331"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_B4E90DF5112EE9421D1E753F4F81E7"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_A22D17987AE945FA680A9288FA2C19EBA872A8AF4552A831A8"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_829410B0E359ECC8341BB393C745411901F4"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_82D313298CF55150682A4A342826BE221565940D54"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_A962168222B214270DA244AF59A24225A189A2BE224A9EA0"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_A39A0D91678F7B91B811E12C51F80B"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_8CC60E9EB743784B40345D99B82B412C"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_818C1529094A5184EB13F41AA554A4EB96A22BD00A4922"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_8E7612E120A3FB3793D72DBBF4E39D7FDD48D9D1"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_8ED01020412F704B71FD5388567BAC0F73E9"))
    var_9 = "_encstr_BE0718E24BDD72572178AF9FD1D9321A85D76FDFA163FBB8C998";
  else if(issubstr(var_6, "_encstr_9A570C0FF8F789BDE7B0646C4923"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_A9DF0B10E9398DAF7CA8CFC55E"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_88E60E65304F251BB7B0AAF95748D1B7"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_9A8406A909B109BB"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_9A430AA170B2BF270F71186D"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_857D0633190C2D88"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_A51904CB417F"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_A32022F978B9D001176C950F38E4708F216346FCFD1623AA3813CD7F3281D1EAAA74395F"))
    var_9 = "_encstr_860616E16965C058431A89F1936F08C071FF43A50DCA089E";
  else if(issubstr(var_6, "_encstr_B2061ECD579673E2CF21802859D36F4FAFBD57AFCAB316A2C79149A129BF55E3"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_8285235382AF9025D7A49C3AA06A8AAF45AAD775D2CC5318CB2125AF225132AA35A2B42945"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else if(issubstr(var_6, "_encstr_A26D2515A970E5D99764D39F616BE8A17963B94701579D97682E0517D9B120E1AF638F11D7E046"))
    var_9 = "_encstr_81971460BBC097D1E1B0C25A4839195F1990FDFAC309";
  else {}

  return var_9;
}

fusefx(var_0, var_1, var_2) {
  var_3 = self;

  if(isDefined(var_1) && isDefined(var_1.type))
    var_4 = var_1.type;
  else
    return "_encstr_B40101";

  var_5 = 0;
  var_6 = tablelookupgetnumrows(level.brloottablename);
  var_7 = undefined;

  for(var_8 = var_5; var_8 < var_6; var_8++) {
    var_9 = tablelookupbyrow(level.brloottablename, var_8, 1);

    if(var_9 == var_4) {
      var_7 = tablelookupbyrow(level.brloottablename, var_8, 12);

      if(var_7 == "_encstr_B40101") {}

      break;
    }
  }

  if(!isDefined(var_7)) {
    if(var_4 == "_encstr_A1EB22D00BAC5067F3799FA9CB6A49D91A2760F8FB6A29379B9C18A0A9539BA3758F523A" || var_4 == "_encstr_93EB22233820DF425110DAD56D3DAA9D4BE9B7D3E01B094A7913654D40EFB234F1815A72" || var_4 == "_encstr_8AE71095B8EA2D1C7D66D5B1E8BD37F55B38") {
      if(var_2 func_load_difficulty_table("_encstr_8EC71AC1A573B37DC1B1AEE68C564EFAC4B0B9ADBE36EDB9994BC96B"))
        return "_encstr_8EC71AC1A573B37DC1B1AEE68C564EFAC4B0B9ADBE36EDB9994BC96B";
    }

    return "_encstr_A63A0AE0B4DCD9FA8C4B26E6";
  }

  var_10 = "_encstr_B40101";

  if(issubstr(var_7, "_encstr_958F090DD39C2A9405D0A8")) {
    if(issubstr(var_7, "_encstr_B1CC0905D4A90A4D4D9472"))
      var_10 = "_encstr_A1421C87E45A775ED13390D05BE596B792CD7D0E7E22E906BA7FABE0AB19";
    else if(issubstr(var_7, "_encstr_A1580B119E5352930AA252E9C9"))
      var_10 = "_encstr_B8F51BD0C2CD97B6E70E5CC3F23F7E67755A6848FA26F9CEF335D6C8F6";
    else if(issubstr(var_7, "_encstr_AF460A7F366973CF636F651D"))
      var_10 = "_encstr_88111F5BB9583F97F8ABA69CDA47672EB7C558B3D00FBC892329C89BCD2020F32E";
    else if(issubstr(var_7, "_encstr_951904D9D1E1"))
      var_10 = "_encstr_A9ED2012334A1117D137D5E3DADDF1AEE0CD24EBEB07CBA73868334B4B0BBAF3D8B1";
    else if(issubstr(var_7, "_encstr_863708C32B0966591B4B"))
      var_10 = "_encstr_860F25634850F7B978B5E6E175F0713F08CD9BCBD1BEF3E150890AF16DC8456BA53A1353B9060B";
    else if(issubstr(var_7, "_encstr_BD6E090964E94747C9CB26"))
      var_10 = "_encstr_B1561FA9EFAAFCA939C7A940EAED7126520B293567C23DE1431B537B95D150651A";

    if(var_10 != "_encstr_B40101" && !var_2 func_load_difficulty_table(var_10))
      var_10 = "_encstr_B40101";

    if(var_10 == "_encstr_B40101")
      var_10 = "_encstr_875C1D7BE2CBDC913E0695833A65C996A7EA73A3CA478D59571DBD83424CE0";

    if(var_10 != "_encstr_B40101" && !var_2 func_load_difficulty_table(var_10))
      var_10 = "_encstr_B40101";
  } else if(issubstr(var_7, "_encstr_88EA08E8284D9AA035A5")) {
    if(var_2 func_load_difficulty_table("_encstr_BD6E154B6078CF8160A31B1DBB1854E7165822B2C8CEBF"))
      var_10 = "_encstr_BD6E154B6078CF8160A31B1DBB1854E7165822B2C8CEBF";
  } else if(issubstr(var_7, "_encstr_99D20DE132C9A95AA6DF1CF1C8F9E2")) {
    if(var_2 func_load_difficulty_table("_encstr_BD101CA290C8DF419771772359355B2FD0F9DD2FC8805FDA601D33379DE9"))
      var_10 = "_encstr_BD101CA290C8DF419771772359355B2FD0F9DD2FC8805FDA601D33379DE9";
  } else if(issubstr(var_7, "_encstr_8C0A1127D9192BBBA525B1690D83EB52D967A4")) {
    if(var_2 func_load_difficulty_table("_encstr_A20C1AFBEB37426F3009C20CE6209DEB683767631F3E8A066010BA55"))
      var_10 = "_encstr_A20C1AFBEB37426F3009C20CE6209DEB683767631F3E8A066010BA55";
  }

  if(var_10 == "_encstr_B40101")
    var_10 = "_encstr_A63A0AE0B4DCD9FA8C4B26E6";

  return var_10;
}

calloutmarkerping_removecallout(var_0) {
  var_1 = self;

  if(!isDefined(var_1)) {
    return;
  }
  addquestrewardtier("_encstr_95451A81424DC7D3B7088E872CFBB88B737EC1B9AE6A39C933643A2F" + var_0);

  if(isDefined(var_0)) {
    if(var_0 == 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_870D05C1969BB3", "_encstr_876231B12CC663DEBAA36A85C9DA95E414B4B9ECF56EB8D5C29198B22C46AC4E90B22CC6DECDA5A5B1638C7B390A8D58CBACE4"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_870D05C1969BB3", "_encstr_876231B12CC663DEBAA36A85C9DA95E414B4B9ECF56EB8D5C29198B22C46AC4E90B22CC6DECDA5A5B1638C7B390A8D58CBACE4")]](var_1);
    }

    var_1 calloutmarkerping_delete(var_0);
    addquestrewardtier("_encstr_BA621BCA25382F134382486208B98D9FB33F6954EF2467DB63A813CF52" + var_0);
    var_1 notify("_encstr_AF8E187BEA1D58CBB25B4375379807A0BC054373DE4C18F77B0F" + var_0);
  }
}

fulton_refundsuper(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AF8E187BEA1D58CBB25B4375379807A0BC054373DE4C18F77B0F" + var_0);

  for(;;) {
    level waittill("_encstr_96D71AFD50D25FA1CD01A5982FAAB08BE703384C635A50A426F3186E", var_2);

    if(isDefined(var_2) && var_2 == var_1) {
      addquestrewardtier("_encstr_93191EC76312EF9118CADE3BCCC09FAA49BFD2235F83B15B30B88B02CFDB2079" + var_0 + "_encstr_84EF0E169A0787C238B75252D369D8E2" + var_1);
      break;
    }
  }

  calloutmarkerping_removecallout(var_0);
}

fulton_planted(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AF8E187BEA1D58CBB25B4375379807A0BC054373DE4C18F77B0F" + var_0);

  for(;;) {
    level waittill("_encstr_84A7116416FAB826DB07457BC7807DB88DEBA9", var_2);

    if(isDefined(var_2) && var_2 == var_1) {
      addquestrewardtier("_encstr_8DF1168077DB5C750AFF2EADD4E3B3E505E36890B774BAA9" + var_0 + "_encstr_84EF0E169A0787C238B75252D369D8E2" + var_1);
      break;
    }
  }

  calloutmarkerping_removecallout(var_0);
}

fulton_interactions_disabled(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AF8E187BEA1D58CBB25B4375379807A0BC054373DE4C18F77B0F" + var_0);
  addquestrewardtier("_encstr_ABB82944DF1B0EA8626B93D84F83CF7208C7FB0B53C7F7886E9837826D731E29F2236A304DD345125C9A02" + var_0);

  if(!isDefined(var_1)) {} else if(isPlayer(var_1))
    var_1 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  else
    var_1 scripts\engine\utility::_id_143A6("_encstr_AD75063D571AE108", "_encstr_A31C07E04BD8ADABE0", "_encstr_860808CB78E2984063BA");

  if(isDefined(var_1.update_bomb_vest_lua))
    var_1.update_bomb_vest_lua = undefined;

  calloutmarkerping_removecallout(var_0);
}

fulton_open(var_0, var_1) {
  self endon("_encstr_AF8E187BEA1D58CBB25B4375379807A0BC054373DE4C18F77B0F" + var_0);
  addquestrewardtier("_encstr_93181FC371635FD05F5ADF0FCFE01B27633554CF0303225FB1F84AB297CBB34DF1" + var_0);
  var_2 = remove_prohibited_weapons(var_1);

  if(var_2 != "_encstr_83180CD38347BF3F7217FB9B6199")
    scripts\engine\utility::_id_143A5("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_83D013DC563699F538A536AD598CAE38B44756DAFA" + var_2);

  calloutmarkerping_removecallout(var_0);
}

calloutmarkerping_watchscriptabledeath(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AF8E187BEA1D58CBB25B4375379807A0BC054373DE4C18F77B0F" + var_0);
  addquestrewardtier("_encstr_93411C196081BEC359EE333A8B3BFB46D560A2E6F00BF64B887F11043A09" + var_0);

  if(!isDefined(var_1)) {} else if(var_1.type == "_encstr_8AE71095B8EA2D1C7D66D5B1E8BD37F55B38") {
    var_2 = var_1.entity;

    if(!isDefined(var_2)) {
      return;
    }
    var_2 scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_AA150FCC57B13A7B73D7A358B5567B9999");
  } else if(var_1.type == "_encstr_9AB90F3127BEC1B1EA738CCA93D726DEE1")
    var_1 waittill("_encstr_82430FB4BB3FBBA0A7F12C0F812A09E7AF");
  else
    level scripts\engine\utility::_id_143A8("_encstr_BAA71D50AB71B74FD9A0038BD82BC26F0818C3F1B1F81F96FB40CA02702971" + var_1.type + var_1.origin, "_encstr_82941EBD48D8D4AA27572B17C7D8633D389137C960B08412106F17CBB9F07B64" + var_1.origin, "_encstr_AAA5161B1860E0B25B2C717403190A8789F8B3A3589B3CA9" + var_1.origin, "_encstr_83EC19E3F31EEA4D80104C17A9019B72E111C7275BB1B20FE0BBC9" + var_1.origin, "_encstr_8C8C18773BCED399E0A9C58F2698D16AA92F0FF7B979CA5DB016" + var_1.origin);

  addquestrewardtier("_encstr_AFDC23750B471B1A40CD36C94B0E3A0B898D2B022356588E0D4029B2B6EDB35904A4114780" + var_0);
  calloutmarkerping_removecallout(var_0);
}

fulton_actors(var_0) {
  var_1 = self;

  if(addleadobjective(var_0))
    var_2 = getdvarfloat("_encstr_82382F27A3224106376A2870C35BC978FA3383DD584C705CA78201B93BC3E888549D1B6FE573B11087BB986172EBBB982D", 120.0);
  else if(addpostlaunchspawns(var_0)) {
    if(addjuggfunctionality(var_0))
      var_2 = getdvarfloat("_encstr_82382F27A3224106376A2870C35BC978FA3383DD584C705CA78201B93BC3E888549D1B6FE573B11087BB986172EBBB982D", 120.0);
    else if(fulton_check_for_moving_platform(var_0))
      var_2 = getdvarfloat("_encstr_96C32FC3E8153967C9E9B4BF7D3307FE7DD02A4BD89BADBFE6C585A995980743934852126849A99F9BBD9BB438E0FFCD01", 120.0);
    else
      var_2 = getdvarfloat("_encstr_ADDD29BF3BCAA9FECF82B0D87BF3A10B629B2B35B0F4E8340F1AE901535B7060FCE5A3975D1B19892782C3", 30.0);
  } else if(addplundercarrycredit(var_0)) {
    if(addjuggfunctionality(var_0))
      var_2 = getdvarfloat("_encstr_82382F27A3224106376A2870C35BC978FA3383DD584C705CA78201B93BC3E888549D1B6FE573B11087BB986172EBBB982D", 120.0);
    else
      var_2 = getdvarfloat("_encstr_BA902BDC36E4FA6CB08D1BF6BAA3B6B0E45B9593E02DDC3BAF462BB047A1F58E96DAACBDBAA3AF569B47B4A397", 60.0);
  } else if(addplayeraslootleader(var_0))
    var_2 = getdvarfloat("_encstr_A24A2B8F9E96B72133EB9878E780259F6A3027B3707A5527AEDC399F2CEC394CB3A7C568B09C677163BBF4AFDD", 15.0);
  else {
    switch (var_0) {
      case 0:
        var_2 = getdvarfloat("_encstr_82382F27A3224106376A2870C35BC978FA3383DD584C705CA78201B93BC3E888549D1B6FE573B11087BB986172EBBB982D", 120.0);
        break;
      case 7:
        var_2 = getdvarfloat("_encstr_91A72A37B3523176477A3840F34B3988EA0393AD487C604C97921189CBD3F898446D2B1FD563A18CAFCB4811", 120.0);
        break;
      case 8:
        var_2 = getdvarfloat("_encstr_8CDF2CF241B87712AFC1A3B7EBCD3A8140A8EF3A9BC81E2AE8F98F8701FB41EC30F067C55378E7F3DD9987770915", 60.0);
        break;
      case 12:
        var_2 = getdvarfloat("_encstr_AF152CB812BA9741B75409F0258BC8B3E23AB038BB943D19774485FF1C2376518C223848036B27F3777995E5F37B", 30.0);
        break;
      default:
        var_2 = 2;
    }
  }

  return var_2;
}

calloutmarkerping_onplayerdisconnect(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 fulton_exfil_model();
}

fulton_repositorycountdownendcallback(var_0, var_1) {
  var_2 = self;

  if(addpostlaunchspawns(var_0))
    return var_1 + 500;
  else if(addplundercarrycredit(var_0))
    return var_1 + 500;
  else if(addplayeraslootleader(var_0))
    return var_1 + 500;
  else {
    switch (var_0) {
      case 0:
        return var_1 + 500;
      case 8:
        return var_1 + 500;
      case 7:
        return var_1 + 500;
      case 12:
        return var_1 + 500;
      default:
        break;
    }
  }
}

fxangles(var_0) {
  var_1 = self;

  if(!isDefined(var_1.fxrings[var_0]))
    return 0;

  return 1;
}

fx_thermal_end(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_5 = var_4.fxrings.size;

  if(var_5 > 10)
    return 0;

  var_6 = var_4 fulton_repositorycountdownendcallback(var_0, var_3);
  var_7 = var_6 + var_1;
  var_8 = spawnStruct();
  var_8._id_134E0 = var_7;
  var_8.poolid = var_0;
  var_8.generatenumbercode_array = 0;
  var_4.fxrings[var_2] = var_8;
  return 1;
}

fulton_repositoryextractcallback(var_0, var_1, var_2) {
  var_3 = self;

  if(!isDefined(var_3) || !isPlayer(var_3))
    return 0;

  if(istrue(var_3.loadout_updateglobalclassstruct))
    return 0;

  var_4 = gettime();
  var_5 = "_encstr_930D05B2186F72" + var_0;
  var_6 = var_3 fxangles(var_5);

  if(var_6) {
    var_7 = var_3.fxrings[var_5]._id_134E0;

    if(var_4 >= var_7) {
      var_8 = var_3 fx_thermal_end(var_0, var_4, var_5, var_2);
      return istrue(var_8);
    }

    if(var_1 == "_encstr_9576159B022B3C711AE59F9107C5C8F5471A31C0CA7FE1" && var_3.fxrings[var_5].generatenumbercode_array == 0) {
      var_3.fxrings[var_5].generatenumbercode_array = 1;
      return 1;
    }

    return 0;
  } else if(var_1 == "_encstr_9576159B022B3C711AE59F9107C5C8F5471A31C0CA7FE1")
    return 0;
  else {
    var_8 = var_3 fx_thermal_end(var_0, var_4, var_5, var_2);
    return istrue(var_8);
  }
}

fulton_used() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 10;
    var_0 = gettime();

    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      var_2 = level.players[var_1];

      if(!isDefined(var_2) || !isDefined(var_2.fxrings)) {
        continue;
      }
      foreach(var_5, var_4 in var_2.fxrings) {
        if(var_0 > var_4._id_134E0)
          var_2.fxrings[var_5] = undefined;
      }
    }
  }
}

fx_thermal(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(var_0) {
    var_5 = lookupsoundlength(var_1, 1);

    if(var_5 > var_4)
      var_4 = var_5;
  }

  if(var_2) {
    var_5 = lookupsoundlength(var_3, 1);

    if(var_5 > var_4)
      var_4 = var_5;
  }

  return var_4;
}

calloutmarkerping_getpoolidnavigation() {
  return 0;
}

fulton_deletenextframe(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2) || !isPlayer(var_2) || !isDefined(var_0)) {
    return;
  }
  if(!soundexists(var_0)) {}

  var_3 = var_2 calloutmarkerping_getsavedzoffset(var_1);
  var_4 = var_2 setallstreamloaddist(var_1);
  var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_85881311AA2BD460B48D3D11BC9839992703293B53")]](var_2.team, 1);

  foreach(var_7 in var_5) {
    if(istrue(var_7.gulag)) {
      continue;
    }
    if(var_2 isspectatingplayer())
      var_8 = var_7;
    else if(isDefined(var_3)) {
      var_8 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_3.origin);
      var_8.validatedamagerelicswat = 1;
    } else if(isDefined(var_4)) {
      var_8 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_4);
      var_8.validatedamagerelicswat = 1;
    } else
      var_8 = var_2;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_830A11821090E1A138633BEBD9D06921E8193F"))
      var_8[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_830A11821090E1A138633BEBD9D06921E8193F")]](var_0, var_2.team, var_2);
    else
      var_8 playsoundtoteam(var_0, var_2.team);

    if(isDefined(var_8.validatedamagerelicswat))
      var_8 delete();

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8")]]()) {
      break;
    }
  }
}

func_load_difficulty_table(var_0) {
  var_1 = self;
  var_2 = var_1 fx_model(var_0);
  var_3 = var_1 fx_obj(var_0);
  var_4 = soundexists(var_2);
  var_5 = soundexists(var_3);
  return var_4 || var_5;
}

fx_model(var_0) {
  var_1 = self;

  if(!isDefined(var_1.operatorcustomization) || !isDefined(var_1.operatorcustomization.voice)) {
    return;
  }
  var_2 = "_encstr_84690847F92EFD1A5F1F" + var_1.operatorcustomization.voice + "_encstr_BA4C02DF" + var_0;

  if(var_2 == "_encstr_975824E2A3D725C33251A217163F6F7B9BAF2F1F112FD2F5198915A875D92A60C017D317ACBA")
    var_2 = "_encstr_AB3F29E47179DD4BB77EEAB2E3180394A827A778CB30E4875F96F23A69E96B4BB09F02F179F821BB8F0B0A";

  if(var_2 == "_encstr_9B4A275373C17972C051266747CB4730E32DB0C9931FDE446B1D619F087A8BC260E055498A6596028E")
    var_2 = "_encstr_AD012CC8C3FAB50E0ED758B9C291F5C15AB9ECFA1699662DC9D67DC6F6DCE8C9851BE8AF93B28DDBB9F50D163743";

  return var_2;
}

fx_obj(var_0) {
  var_1 = self;

  if(!isDefined(var_1.operatorcustomization) || !isDefined(var_1.operatorcustomization.voice)) {
    return;
  }
  var_2 = "_encstr_A36908BCEB3E67D20D39" + var_1.operatorcustomization.voice + "_encstr_BA4C02DF" + var_0;
  return var_2;
}

fxent2(var_0, var_1, var_2) {
  var_3 = self;

  if(!isDefined(var_3) || !isPlayer(var_3)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_0) || var_0 == "_encstr_B40101") {
    return;
  }
  if(isPlayer(var_2))
    var_4 = var_2;
  else
    var_4 = var_3;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_95C50D4B8218F33AF1288B4298AD25") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_95C50D4B8218F33AF1288B4298AD25")]](var_4)) {
    return;
  }
  var_5 = var_4 fx_model(var_0);
  var_6 = var_4 fx_obj(var_0);
  var_7 = soundexists(var_5);
  var_8 = soundexists(var_6);
  var_9 = fx_thermal(var_7, var_5, var_8, var_6);
  var_10 = var_4 fulton_repositoryextractcallback(var_1, var_0, var_9);

  if(istrue(var_10)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8")]]())
      var_11 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_850710A7F30D014180090702800881BAE637")]](var_3.team, var_3.squadindex);
    else
      var_11 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_85881311AA2BD460B48D3D11BC9839992703293B53")]](var_3.team, 1);

    foreach(var_13 in var_11) {
      if(istrue(var_13.gulag)) {
        continue;
      }
      if(var_4 == var_13 || var_4 isspectatingplayer()) {
        if(var_7)
          var_4 playsoundtoplayer(var_5, var_13, var_13);

        continue;
      }

      if(var_8)
        var_4 playsoundtoplayer(var_6, var_13);
    }
  }

  if(!var_8)
    return;
}

fulton_create() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_873519DB936D73BCF0199176C309469B01A803231DB10FF65067C0");
  self notify("_encstr_BA542CB1851B8D7BAE1D351627B5CA4EA0A5B9B3FADC0B9DA53BB047A5BDCD1AC2E61B95631427DEF0B4D65A3A5E");
  self endon("_encstr_BA542CB1851B8D7BAE1D351627B5CA4EA0A5B9B3FADC0B9DA53BB047A5BDCD1AC2E61B95631427DEF0B4D65A3A5E");
  var_0 = getdvarfloat("_encstr_82382F27A3224106376A2870C35BC978FA3383DD584C705CA78201B93BC3E888549D1B6FE573B11087BB986172EBBB982D", 120.0);
  var_1 = getdvarint("_encstr_ABD33AB8F6201FB7491923FD8323800FCD402D4B313373B119C5580B136CCFE4FB20C0B9C88928E01550A69B17F0C2DD65413F63B4C7AB07B0AA58D7", 10);
  wait(var_1);

  if(!self calloutmarkerping_getfeedback(0)) {
    return;
  }
  var_2 = self setallstreamloaddist(0);
  var_3 = getdvarint("_encstr_B8B63A9BC6E4EB6CC2631BB7EAD1ADC227B5594E072DB93BFA9BC2672D9D851DD2F637FA074EF61ED2B6D23A5EAF6CC2CDB12B1BAF3296E68EFA6E8B", 47089);
  var_4 = getdvarint("_encstr_96D037CD1B39D71B85B1C6B757E85B0B27AD56C91C9673D9AF7358D94B3BC28EB4B7DCF507E4F68796B5B447CBFA6CB0DCC6B2C67DE8CB1C56", 1);
  var_5 = getdvarint("_encstr_835C3CFB8E1B898FD2E28577339521F7A3B00AA53B69A5E770BEA34B1C39A97B02884587807530F204431A61E09F9EA672965D2821239B3ACFF79395C66B", 1.0);

  for(;;) {
    if(var_4 == 1)
      var_6 = distancesquared(self.origin, var_2);
    else {
      var_6 = var_3;
      var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_85881311AA2BD460B48D3D11BC9839992703293B53")]](self.team, 1);

      foreach(var_9 in var_7) {
        var_10 = distancesquared(var_9.origin, var_2);

        if(var_10 < var_6)
          var_6 = var_10;
      }
    }

    if(var_6 < var_3) {
      fulton_deletenextframe("_encstr_AB9A0FF88607CBB106F7EF29A065C925D1", 0);
      calloutmarkerping_removecallout(0);
      return;
    }

    wait(var_5);
  }
}

fulton_exfil_model() {
  var_0 = self;

  if(isDefined(var_0)) {
    for(var_1 = 0; var_1 < 13; var_1++)
      var_0 calloutmarkerping_removecallout(var_1);
  }
}

fulton_destroy(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    var_3 fulton_exfil_model();

    if(istrue(var_0)) {
      var_1++;

      if(var_1 % 10 == 0)
        waitframe();
    }
  }
}

fxorigintagb(var_0) {
  var_1 = self;
  var_1 notify("_encstr_8DF62E2218C915B7ABC5B591DEB0475A19E07AFAC9F78183A0A779B8F6190B24A7E0B263C861C4C3B98E648507C3F72F");
  var_1 endon("_encstr_8DF62E2218C915B7ABC5B591DEB0475A19E07AFAC9F78183A0A779B8F6190B24A7E0B263C861C4C3B98E648507C3F72F");
  var_1 fulton_deletenextframe("_encstr_AB9A0FF88607CBB106F7EF29A065C925D1", var_0);
  wait(getdvarfloat("_encstr_91FA3CB98DC9FAB11663B17BAEA35BB0276DB2270EB473CEEBC8CA1BC2CBBE4C593ADD95ACCDF53B7BD785DC91BEDC99C37DE6AC6CDCEB1B63AC5839B223", 0.5));

  if(isDefined(var_1))
    var_1 fxent2("_encstr_9576159B022B3C711AE59F9107C5C8F5471A31C0CA7FE1", var_0);
}

fxorigin(var_0) {
  var_1 = self;
  var_1 fxorigintagb(var_0);
}

fxgreen(var_0, var_1) {
  var_2 = self;
  var_2 notify("_encstr_886A33E07675612715AB81C9C30BFB7831E9B207BCE05F380B734B9026D77C74BEC877ABF9C1620DC77722BA56C778A24BFB7F27C1");
  var_2 endon("_encstr_886A33E07675612715AB81C9C30BFB7831E9B207BCE05F380B734B9026D77C74BEC877ABF9C1620DC77722BA56C778A24BFB7F27C1");

  if(addpostlaunchspawns(var_0)) {
    var_3 = var_2 calloutmarkerping_getsavedzoffset(var_0);
    var_4 = var_2 fusefx(var_0, var_3, var_1);
  } else if(addplundercarrycredit(var_0))
    var_4 = "_encstr_A346150729FBA9F7D202C0E09AED6721E7C984F4B12350";
  else if(addplayeraslootleader(var_0))
    var_4 = "_encstr_AC7213BBAAFEE9363281AF33200D0BE1D750CF8B9B";
  else {
    switch (var_0) {
      case 0:
        if(var_1 func_load_difficulty_table("_encstr_830E1B0ED2733BAFD956E656E4B4D8BE07B4B9ECBE2795CD07B79B9B95"))
          var_4 = "_encstr_830E1B0ED2733BAFD956E656E4B4D8BE07B4B9ECBE2795CD07B79B9B95";
        else
          var_4 = "_encstr_A346150729FBA9F7D202C0E09AED6721E7C984F4B12350";

        break;
      case 7:
        var_4 = "_encstr_AC7213BBAAFEE9363281AF33200D0BE1D750CF8B9B";
        break;
      case 8:
        if(var_1 func_load_difficulty_table("_encstr_815A15591F5A0C39BE97D8F03E9CD0A8229FED8DF743C1"))
          var_4 = "_encstr_815A15591F5A0C39BE97D8F03E9CD0A8229FED8DF743C1";
        else
          var_4 = "_encstr_A346150729FBA9F7D202C0E09AED6721E7C984F4B12350";

        break;
      case 12:
        var_4 = "_encstr_A63A0AE0B4DCD9FA8C4B26E6";
        break;
      default:
        var_4 = "_encstr_A346150729FBA9F7D202C0E09AED6721E7C984F4B12350";
        break;
    }
  }

  wait(getdvarfloat("_encstr_9A3A3AC7C6DB69863E1DA238ED9520D722024AE373BB98A1160AF538E26719F2D5CBEC8B6D651F1B4D87706DCC71D20AD818CFD5A223EFB370EF1B3F", 0.5));

  if(isPlayer(var_1))
    var_2 fxent2(var_4, var_0, var_1);
  else if(isDefined(var_2))
    var_2 fxent2(var_4, var_0);
}

fxorigintag(var_0) {
  var_1 = self;
  var_1 notify("_encstr_86C22CAEDE181A806F5B1B79FD9A07DA3F7835AF1B5FBF4170395959D6FD18B39B6860E631C97AF5988513AF6925");
  var_1 endon("_encstr_86C22CAEDE181A806F5B1B79FD9A07DA3F7835AF1B5FBF4170395959D6FD18B39B6860E631C97AF5988513AF6925");
  var_1 endon("_encstr_8DF62E2218C915B7ABC5B591DEB0475A19E07AFAC9F78183A0A779B8F6190B24A7E0B263C861C4C3B98E648507C3F72F");
  var_1 endon("_encstr_AF8E187BEA1D58CBB25B4375379807A0BC054373DE4C18F77B0F" + var_0);
  wait(getdvarfloat("_encstr_8D643AE3579341172F286A4213FD6786782F6D6AC970D5FFD801F27AF95377BE6889F7C50B90D1F3F89E8A2261B88FF758778B4D9F10697715D1C28A", 0.5));

  if(isDefined(var_1))
    var_1 fulton_repositoryusecallback(var_0);
}

fulton_check_for_moving_platform(var_0) {
  var_1 = self;
  var_2 = var_1 calloutmarkerping_getsavedzoffset(var_0);

  if(isDefined(var_2) && isDefined(var_2._id_139EB))
    return 1;

  return 0;
}

addjuggfunctionality(var_0) {
  var_1 = self;
  var_2 = var_1 calloutmarkerping_getsavedzoffset(var_0);

  if(isDefined(var_2) && isDefined(var_2.classname) && issubstr(var_2.classname, "_encstr_96010BDCD8392D073A164C1B2B") && !isDefined(var_2.entity) && var_2 getscriptableisreserved()) {
    if(var_2 _meth_87B9()) {
      var_3 = var_2 _meth_87B7();
      return _calloutmarkerping_handleluinotify_enemyrepinged::trophy_tryreflectsnapshot(var_3);
    }
  }

  return 0;
}

addleadobjective(var_0) {
  var_1 = self;
  var_2 = var_1 calloutmarkerping_getsavedzoffset(var_0);

  if(isDefined(var_2) && isDefined(var_2.vehiclename) && issubstr(var_2.vehiclename, "_encstr_ADA606A3E4B04BE6"))
    return 1;

  return 0;
}

fulton_handledamage(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AF8E187BEA1D58CBB25B4375379807A0BC054373DE4C18F77B0F" + var_0);
  var_2 = 0.25;
  var_3 = 0;
  var_4 = self.team;

  for(;;) {
    var_5 = addselfrevivetoken(var_0, var_1, var_4);

    if(var_5) {
      calloutmarkerping_removecallout(var_0);
      return;
    }

    var_6 = addplatepouch(var_1, var_4);

    if(var_6) {
      var_3 = var_3 + var_2;

      if(var_3 >= 3) {
        var_7 = var_1 getvehicleowner();

        if(isDefined(var_7))
          thread fulton_ac130_model(var_0, var_7);
        else
          calloutmarkerping_removecallout(var_0);

        return;
      }
    }

    wait(var_2);
  }
}

addselfrevivetoken(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = 0;
  var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_85881311AA2BD460B48D3D11BC9839992703293B53")]](var_2, 1);

  foreach(var_7 in var_5) {
    if(var_7 scripts\cp_mp\utility\player_utility::isinvehicle() && var_7.vehicle == var_1) {
      var_3 calloutmarkerping_hide(var_0, var_7);
      var_4++;
    }
  }

  if(var_4 == var_5.size)
    return 1;

  return 0;
}

addplatepouch(var_0, var_1) {
  var_2 = isDefined(var_0.ownerteam) && var_0.ownerteam != var_1;
  var_3 = isDefined(var_0.isempty) && var_0.isempty == 0;

  if(var_3 && var_2)
    return 1;

  return 0;
}

add_trigger_to_oob_system(var_0) {
  var_1 = self;

  if(!isDefined(var_1.fulton_repositoryatcapacitycallback))
    var_1.fulton_repositoryatcapacitycallback = [];

  if(!isDefined(var_1.fulton_repositoryatcapacitycallback[var_0]))
    var_1.fulton_repositoryatcapacitycallback[var_0] = 0;
  else
    var_1.fulton_repositoryatcapacitycallback[var_0]++;

  var_2 = [];
  var_2[var_2.size] = "_encstr_A5070838A5E6D9EB96C8";
  var_2[var_2.size] = var_1.fulton_repositoryatcapacitycallback[var_0];
  var_2[var_2.size] = "_encstr_A2C20AA20B1DB29743181B77";
  var_2[var_2.size] = var_0;
  var_2[var_2.size] = "_encstr_B2F90FD373A2492FE1C1C77A79B92D3457";
  var_2[var_2.size] = istrue(var_1 setadditionalstreamloaddist());
  var_2[var_2.size] = "_encstr_B26A0966E710E7D90325E9";
  var_2[var_2.size] = 0;
  var_2[var_2.size] = "_encstr_BA3C0E73BFC0875FD901D3BAE83F157B";
  var_2[var_2.size] = "_encstr_B40101";
  var_2[var_2.size] = "_encstr_A9F80907252ACB994257E0";
  var_2[var_2.size] = var_1.origin[0];
  var_2[var_2.size] = "_encstr_8CF809E8AA3683D9B3DF3B";
  var_2[var_2.size] = var_1.origin[1];
  var_2[var_2.size] = "_encstr_B1F8090B117753A5285E30";
  var_2[var_2.size] = var_1.origin[2];
  var_3 = var_1 setallstreamloaddist(var_0);
  var_2[var_2.size] = "_encstr_AC7607BBAAFEE93638";
  var_2[var_2.size] = var_3[0];
  var_2[var_2.size] = "_encstr_9176076F404098768B";
  var_2[var_2.size] = var_3[1];
  var_2[var_2.size] = "_encstr_8E7607F0E2EDB7966B";
  var_2[var_2.size] = var_3[2];
  var_1 dlog_recordplayerevent("_encstr_8748192A08B7BF1FF16C352605DEA382AF806202E87FF357A9DC3D", var_2);
}

add_wave_overrides_to_module() {
  var_0 = self;

  if(isDefined(var_0)) {
    for(var_1 = 0; var_1 < 13; var_1++) {
      if(var_0 calloutmarkerping_getfeedback(var_1))
        var_0 add_veh_spawners_to_passive_wave_spawning(var_1, "_encstr_A9930AD77C570B3E7FEA7860");
    }
  }
}

add_veh_spawners_to_passive_wave_spawning(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2.fulton_repositoryatcapacitycallback)) {
    return;
  }
  if(!isDefined(var_2.fulton_repositoryatcapacitycallback[var_0])) {
    return;
  }
  var_3 = [];
  var_3[var_3.size] = "_encstr_A5070838A5E6D9EB96C8";
  var_3[var_3.size] = var_2.fulton_repositoryatcapacitycallback[var_0];
  var_3[var_3.size] = "_encstr_A2C20AA20B1DB29743181B77";
  var_3[var_3.size] = var_0;
  var_3[var_3.size] = "_encstr_B2F90FD373A2492FE1C1C77A79B92D3457";
  var_3[var_3.size] = istrue(var_2 setadditionalstreamloaddist());
  var_3[var_3.size] = "_encstr_B26A0966E710E7D90325E9";
  var_3[var_3.size] = 1;
  var_3[var_3.size] = "_encstr_BA3C0E73BFC0875FD901D3BAE83F157B";
  var_3[var_3.size] = var_1;
  var_3[var_3.size] = "_encstr_A9F80907252ACB994257E0";
  var_3[var_3.size] = var_2.origin[0];
  var_3[var_3.size] = "_encstr_8CF809E8AA3683D9B3DF3B";
  var_3[var_3.size] = var_2.origin[1];
  var_3[var_3.size] = "_encstr_B1F8090B117753A5285E30";
  var_3[var_3.size] = var_2.origin[2];
  var_2 dlog_recordplayerevent("_encstr_8748192A08B7BF1FF16C352605DEA382AF806202E87FF357A9DC3D", var_3);
}

addbattlepassxpmultiplier(var_0) {
  var_1 = self;
  var_1 add_veh_spawners_to_passive_wave_spawning(var_0, "_encstr_92180DD7DC70092D4163B95D774299");
  var_1 notify("_encstr_AF8E187BEA1D58CBB25B4375379807A0BC054373DE4C18F77B0F" + var_0);
  var_1 thread fxorigintagb(var_0);
}

addaccesscard(var_0, var_1) {
  var_2 = self;
  var_2 thread addquestrewardtierframeend(var_0, 0, 1);
  var_2 thread fxgreen(var_0, var_1);

  if(getdvarint("_encstr_8F220B17E59FF1E9D15C692997", 0) && istrue(level.onlinestatsenabled) && isDefined(var_2.usingonlinedataoffline) && !var_2.usingonlinedataoffline)
    var_2 setplayerdata("_encstr_8C07031599", "_encstr_A7271557E6CAAF0E96CD76BE2C8DDAF50D966E47B79C5E", 0, 1);
}

addaliasarraytoqueue(var_0) {
  var_1 = self;
  var_1 thread fxorigin(var_0);
}

addallkillstreaksunlocked(var_0) {
  var_1 = self;

  if(istrue(level.stop_end_breach_fx) && !istrue(var_1 setadditionalstreamloaddist())) {
    calloutmarkerping_removecallout(var_0);
    return;
  }

  var_1 add_trigger_to_oob_system(var_0);
  var_1 thread addquestrewardtierframeend(var_0);
  var_1 add_track_points(var_0);
  var_1 thread fxorigintag(var_0);
  var_1 addplayerasexpiredlootleader(var_0);

  if(var_0 == 7) {
    var_2 = self getnodeoffset_code(var_0);
    var_3 = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_BD6220937A474D90F7B83305B7D7F01627B208D990DB0A2BCE743B3DDDCCF05D83DA"))
      var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_BD6220937A474D90F7B83305B7D7F01627B208D990DB0A2BCE743B3DDDCCF05D83DA")]](var_2);

    if(var_2 != -1 && var_3)
      objective_setplayintro(var_2, 0);
  }

  if(getdvarint("_encstr_8F220B17E59FF1E9D15C692997", 0) && istrue(level.onlinestatsenabled) && isDefined(var_1.usingonlinedataoffline) && !var_1.usingonlinedataoffline) {
    var_1 setplayerdata("_encstr_8C07031599", "_encstr_AD86115B635DD64B54EBE77E817A5BD1C802E3", 0, 1);

    if(addplundercarrycredit(var_0)) {
      var_4 = var_1 calloutmarkerping_getsavedzoffset(var_0);

      if(isDefined(var_4))
        var_1 setplayerdata("_encstr_8C07031599", "_encstr_8D1217108BE77FCB6FBE64708D4B51D348D17008637BA7C347", 0, 1);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_87AF07C852A26B705F"))
    var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_87AF07C852A26B705F")]](var_0);
}

adddroponplayerdeath(var_0) {
  var_1 = self;
  var_1 thread addquestrewardtierframeend(var_0, 0, 1);
  var_1 fulton_deletenextframe("_encstr_B2F50EC91AD7083B72071F630BEA7118", var_0);
}

addedcollision() {
  var_0 = self;
  var_1 = addpowerbutton();

  if(var_1 != -1) {
    var_0 add_wave_overrides_to_module();
    var_0 fulton_deletenextframe("_encstr_AB9A0FF88607CBB106F7EF29A065C925D1", var_1);
    var_0 fxent2("_encstr_9576159B022B3C711AE59F9107C5C8F5471A31C0CA7FE1", var_1);
  }

  var_0 fulton_exfil_model();
}

addallkillstreaksunlockedinonelife(var_0) {
  var_1 = self;
  var_1 thread fulton_handlefataldamage(var_0);
}