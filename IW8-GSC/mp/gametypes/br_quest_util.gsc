/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_quest_util.gsc
***********************************************/

init_quest_util() {
  if(!getdvarint("_encstr_880516D261985722C647373F2B6E8BB349090DDE3963357A", 1)) {
    return;
  }
  level.questinfo = spawnStruct();
  level.questinfo.quests = [];
  level.questinfo.thinkers = [];
  level.questinfo.tabletinfo = [];
  level.questinfo._id_13745 = [];
  level.questinfo.teamsonquests = [];
  level.questinfo.thinkindex = 0;
  level.questinfo._id_139EC = [];
  level.questinfo._id_12D2F = spawnStruct();
  level.questinfo._id_12D2F.get_vehicle_idle_anim = [];
  level.questinfo._id_12D2F.set_look_at_ent = [];
  level.questinfo._id_12D2F._id_12EC4 = [];
  level.questinfo._id_12D2F._id_12D31 = [];
  level.questinfo._id_12D2F._id_12D32 = [];
  level.questinfo._id_13B62 = [];
  level.questinfo._id_13F19 = [];
  level.questinfo._id_132E8 = scripts\mp\menus::_id_13733() && getdvarint("_encstr_824E1D8E3F0B3F8888F34CFD901B511BE0A19D134FDEF9AFA1436760A5AB13", 0);
  level.questinfo.defaultfilter = [];
  level.questinfo.defaultfilter[0] = ::filtercondition_isdead;
  level.questinfo.defaultfilter[1] = ::filtercondition_ingulag;
  level.questinfo.register_seat_data = ::register_vehicle_spawners;
  _id_11963();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  _id_12C08();
  _encstr_AFDA30371B274B1CE8CDF2B583E5B30BB5ACA3978356DCE54CE4AFB0B96E0BDC6EB4B92CD1A5DBCD7D5CAECADC8E5C9D376C::init();
  _encstr_BD8926CDD8E42D073A9B976B0ECBCEC2B6B21DCBC1596E79C427EB197BB5AF2EAB95B947B83B37B1::init();
  _encstr_AD562C9A0106DBEB134320E0CBEF8C81F0B5DB1FF38B07B711CAE7FFF126B329A887EDDDC14267FD62A3C2692EAF::init();
  _encstr_92CD26C37908D8EB3D1F670F50C8DA3955FB5BD792B14F9E42836953ACF2D18F7312F230F087FB66::init();
  _encstr_86912B6E0EF303C3BC0FC2D86B8F794BAA3765F3227AFFE0921339083715F189035BD068FAD3AB536C4AF038F7::init();
  _encstr_8F4D2A4057AAF8318B1A2801B25657A1EDE7C09883557357D242681D883B85694BDB11407FED0BA9FE2F7616::init();
  _encstr_BD7726BB0F589413EDB3163AFB68974E48FB342981585A269E8B2932A11F3F02D053CBACA520E2EF::init();
  _encstr_910B29179372A0DF33EB3060C3061CA8CDED919B281FA88883D336ABFB534F38607FE30BA542D840AF3B89::init();
  _encstr_8BAB36731E7AD22383DBA865332F57F865170303C8E5272EA25ADE2BAA2EE8D5B3325313987A727436E91B4C2F2387B7C7B3CB884530C3B2::init();
  _encstr_8DD92B9B364EA5C11DDCCBAD38CBCE0BB5AC3ACB0EB2B9E54C39EB6E2C26F61D0BEC2BBE175D2BCD1DC576DCC6::init();
  _encstr_A77C2FBB906DDC43F3CE5F0567B0D766EB085393702B1206E9B6270271019F2C67D08A5B5BF30B8FE31DE52B15C0477247::init();
  _encstr_95383423288639018B079E98F2E8A8D910C93389D36A2397E9ADBF3D201532EB1343165DFF4BD0C93B8A4353F6D89389E865EA9F8363::init();

  if(istrue(level.tryupdategenericprogress))
    _encstr_93A436EA59A0592B1DC7A6A7E9688289B061A3F093A00B967EDD5FC73767DBC5F0891FBAEE68B5CACEB957CF071F712C50139702A83B7BE2::init();

  if(level.script == "_encstr_8CD508CA98A70FAFC01D") {
    if(getdvarint("_encstr_83611FB7DF73F84812B1E158A2E980A9FA8B17073BD8B55053172B15CED3885533", 1) == 1)
      _encstr_8EDD2B8782956F91793A38D0131E9C9BB88F43E04020974FC220B1066D7A904B3A58F75B61491F3C33D57CBE30::loadout_given();

    if(getdvarint("_encstr_96B11D7B4E73E615728E312977E0E608BFAA9B2613C2EAA707A6012FD0A1B3", 0) == 1)
      _encstr_8EDD2B8782956F91793A38D0131E9C9BB88F43E04020974FC220B1066D7A904B3A58F75B61491F3C33D57CBE30::little_bird_mg_onenterheavydamagestate();

    if(getdvarint("_encstr_96311C92C725B96083AF8AC7F9A331117D309BD26F620A50F1B2B4C228CB", 0) != 1)
      _encstr_AC5329EBB1E647FA4817D76DE96AC7AF81E913F37B355765D03DAF6FE3500FA333A39A19809D93FDA0278B::doextractionevent();
  }

  if(isDefined(level._encstr_83F31407ABC7324AA0188BFF30DB063BA5368BFCB715))
    [[level._encstr_83F31407ABC7324AA0188BFF30DB063BA5368BFCB715]]();

  if(isDefined(level._encstr_BD33209196B90B13C6CAB1DEBD47335DE66C1D96DEB90EE4B2D658A3C686C8B79B59))
    thread _encstr_BD33209196B90B13C6CAB1DEBD47335DE66C1D96DEB90EE4B2D658A3C686C8B79B59(level._encstr_BD33209196B90B13C6CAB1DEBD47335DE66C1D96DEB90EE4B2D658A3C686C8B79B59);

  thread inittablets();
  thread _id_13234();
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88E013ABB3F3F72F983E304807C0BF53513B99084D"] = "_encstr_ADDD1B83318AC8FBF7A2D698BAEFAE40259E5F1FA5356137FF6AE92353";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE4815B62D9B9BA57B73FAD64BDC8DBEB9BA6C6C956EB9"] = "_encstr_B29F1631AAE36DC0162BA9875D7C80BE7FC34BB9F2272610";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8BE6130B77E36E908F7D06186662E9AEAABF9597FF"] = "_encstr_8EDA1BFF229707A34F7D36D077DB968BA84DEF50525827D7C8B8FD8465";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BD8D12856B07D381ED8087BF18587FFAE77C0F7F"] = "_encstr_AAF71AF58030DB322845EF3F53CE5B092888E1FD5950AF0A705D0F13";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_92BC19B04A0207C8579E58486ABBF6F56FC3F099739B5BE35FBDD5"] = "_encstr_8FCA21B6A5E63796DEDCF56B2D9BDCD2EDE6AFF6C4A67D73B20F8ED7383A85C9D92B3A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_82011A6750A887DFEDF2B04051E4905D7DC13B87AD5B2CD743F428F0"] = "_encstr_811622E5491A87D727881798226838B7608DBFF5BAC4EF48E14123F9760B4C6F4349BA01";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_82701985538B2F8407A03932A8657147A1461E0978D1570BD38082"] = "_encstr_B4FE21F793860B5148E0F145389073625005B7076DA27107500BB54C30D897EB3BABC7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_87501C7713068BD1C8607145D9D8DF03D7BDF39FF5A4F193D0CBB3CB3348"] = "_encstr_A7C924D8BC477E6FA76837F843C752826FB06F15634A597F6FB31808C02FE7EEE253ABA32A0B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_875718B6D2DC6E96EDCD7DBD26A6FA6CD2278DD8B2F5CCB09636"] = "_encstr_82A9200570C02BC2F8953F8FE39E2B797838310D89E0FFBAC385C783D35082A9E08D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B9511AD2D379B4BBDE6BE9D95B9FACC2CB48D"] = "_encstr_81921910E4B358733A6B673B4FC3464077BDDEA90F0681BCB21F09";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A50916B6A537DC2DF6DCFA8EAC58ADB60BA32BAF19EDEEDC"] = "_encstr_A50916B6A537DC2DF6DCFA8EAC58ADB60BA32BAF19EDEEDC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8DB91302F86E17849835AF9DDD204DC780B1BA2BA0"] = "_encstr_8DB91302F86E17849835AF9DDD204DC780B1BA2BA0";
  level._effect["_encstr_8B1C0E9378420F1287E9B1F74143ABFD"] = loadfx("_encstr_A1AC25AC2DC03658A4D249E3867602514339435B8F4020CD864AF6B66A1F5BA839B6E2579312C1");
  level._effect["_encstr_B2010F28C601C76CC0AF1D79B20B6A43E2"] = loadfx("_encstr_9A2839EC3387F22DDD07F598395ED2CDD8C2E623E53B2CDA59071BB0E59767331E7D3139337D66C6B03956BE8C7BF6D69B1DB0A3A5BD37B8B36687");
  level._effect["_encstr_911811463253E9EA11B3B323F9E9A690F17D6F"] = loadfx("_encstr_A7AF28D5A3BBA8083F40BE11FA5F403742375119577360B84628A629E2C780F9FAC3E3F7A3DA94988E47");
  level._effect["_encstr_923614C3D52BE1636068E36AC1A8B439096F6B434356"] = loadfx("_encstr_AA8D2A0CAFB36F2D5FC2E113C32F192B0A978799C61B27AB36DBD9183B87717992FAF588DA3217130AD76060");
  level._effect["_encstr_92181DFDD698CE13A262BB9F5D717930FBDB598D46685E3CE7EE130365C3BB"] = loadfx("_encstr_88F3296799C35ED2DD1C7D269C79EC58B6591C63C2E5E5676687AF89E4FAD193D75BB0275BAC27E2CE33F0");
  level.elevator_lights_toggle = undefined;
  level.questinfo.hotfootabsloops = 1;
  level._id_14060 = getdvarint("_encstr_BE15199B1B4EBE3193F5EADC95C21B8E4E2BDDB0C932D15826C695", 0);
}

_id_11963() {
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_B1E81D5B38BC3127AD2DDCE64BF6DCD7BA731BDB6C6D0B268D5937E236CDD9", var_0, 0);

    if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
      break;
    }

    var_2 = spawnStruct();
    var_2._id_13F18 = int(var_1);
    var_2._id_11A23 = int(tablelookup("_encstr_B1E81D5B38BC3127AD2DDCE64BF6DCD7BA731BDB6C6D0B268D5937E236CDD9", 0, var_1, 1));
    var_2._id_13F17 = [];
    var_3 = 0;

    for(;;) {
      var_4 = tablelookup("_encstr_B1E81D5B38BC3127AD2DDCE64BF6DCD7BA731BDB6C6D0B268D5937E236CDD9", 0, var_1, 3 + var_3);

      if(!isDefined(var_4) || var_4 == "_encstr_B40101") {
        break;
      }

      var_2._id_13F17[var_3] = int(var_4);
      var_3++;
    }

    level.questinfo._id_13F19[scripts\engine\utility::string(var_2._id_11A23)] = var_2;
    var_0++;
  }
}

_encstr_BD33209196B90B13C6CAB1DEBD47335DE66C1D96DEB90EE4B2D658A3C686C8B79B59(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  [[var_0]]();
}

little_bird_mg_playercontrolmg(var_0, var_1, var_2, var_3) {
  var_4 = 175;
  var_5 = 100;

  if(!isDefined(var_1))
    var_1 = var_4;

  if(!isDefined(var_2))
    var_2 = var_5;

  var_6 = getlootspawnpoint(var_0, var_1, 0, 1);

  foreach(var_8 in var_6) {
    if(tv_station_marker_player_connect_monitor(var_0[2], var_8.origin[2], var_2))
      getlootspawnpointcount(var_8.index);
  }
}

_encstr_99161B551B0BC722A19DABC8D993FDE353EF8208534382B092ABE12CA0(var_0, var_1, var_2) {
  foreach(var_9, var_4 in level.questinfo.tabletinfo) {
    var_5 = canceljoins(removepatchablecollision_delayed(var_9), undefined, var_0, var_1);

    foreach(var_7 in var_5) {
      if(tv_station_marker_player_connect_monitor(var_0[2], var_7.origin[2], var_2)) {
        var_7._encstr_8EB912CCA0758ACC88882B075083BDE3294FD647 = 1;
        _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_11A21(var_7);
      }
    }
  }
}

tv_station_marker_player_connect_monitor(var_0, var_1, var_2) {
  return abs(var_0 - var_1) <= var_2;
}

_encstr_BD401B8CCA315D9DC84E2CDD367BB7D1C8A5DCB031B1562785C84B5737(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = (0, 0, var_1);
  var_4 = var_0 - var_3;
  var_5 = var_0 + var_3;

  for(;;)
    wait 1;
}

inittablets() {
  level.questinfo.activetablets = [];
  var_3 = getdvarfloat("_encstr_8108210B2BF349DDDBD90B7395C37397A9AE2641F5FCE9B2BF5B90A983E75B613A7B4B", 0.667);
  var_4 = [];

  foreach(var_2, var_1 in level.questinfo.tabletinfo) {
    var_6 = removepatchablecollision_delayed(var_2);
    var_7 = getlootscriptablearrayinradius(var_6);

    if(!var_1.enabled) {
      continue;
    }
    if(var_7.size > 0) {
      var_8 = getdvarfloat("_encstr_B26E1F5AE910DF5A4ECFAFB793F60367883196E5417897022B57BFF7FF159A8370", 1200.0);

      if(var_8 > 0) {
        var_9 = 0;

        foreach(var_11 in level.br_armory_kiosk.scriptables) {
          var_12 = canceljoins(var_6, undefined, var_11.origin, var_8);

          foreach(var_14 in var_12) {
            if(istrue(var_14._id_13840)) {
              continue;
            }
            var_14._id_13840 = 1;
            var_9++;
          }
        }

        for(var_17 = var_7.size - 1; var_17 >= 0 && var_9; var_17--) {
          if(istrue(var_7[var_17]._id_13840)) {
            var_7[var_17] = var_7[var_7.size - 1];
            var_7[var_7.size - 1] = undefined;
            var_9--;
          }
        }
      }
    }

    if(istrue(level._id_11A5E) && _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_11A5C()) {
      var_18 = getdvarfloat("_encstr_AF3A23177FD358E872D123BB475B90900BDFADA11FDBAFA0B7330BF02A0FE835834F2BDDF3", 0.8);
      var_19 = int(min(var_7.size, var_7.size * (1.0 - var_18) + 0.5));

      for(var_17 = 0; var_17 < var_19; var_17++) {
        var_20 = randomintrange(0, var_7.size);
        var_7[var_20]._id_13840 = 1;
        var_7[var_20] = var_7[var_7.size - 1];
        var_7[var_7.size - 1] = undefined;
      }
    }

    for(var_17 = var_7.size - 1; var_17 >= 0; var_17--) {
      var_21 = var_7[var_17];
      var_21 tabletinit(var_2);

      if(!var_21.init) {
        var_7[var_17]._id_13840 = 1;
        var_7[var_17] = var_7[var_7.size - 1];
        var_7[var_7.size - 1] = undefined;
      }
    }

    if(var_7.size)
      _id_13180(var_2);

    var_22 = revivingteammate(rewards(var_6));

    if(isDefined(level.br_circle) && isDefined(var_22) && var_22 > 0)
      var_23 = var_7.size;
    else {
      var_24 = var_7.size * var_3;
      var_23 = int(var_24);
      var_25 = var_24 - var_23;

      if(randomfloat(1.0) < var_25)
        var_23++;
    }

    for(var_17 = 0; var_17 < var_23; var_17++) {
      var_20 = randomintrange(0, var_7.size);
      var_21 = var_7[var_20];
      var_7[var_20]._id_13840 = 1;
      var_4[var_4.size] = var_7[var_20];
      var_7[var_20] = var_7[var_7.size - 1];
      var_7[var_7.size - 1] = undefined;
    }
  }

  var_26 = getarraykeys(level.calloutglobals._id_11E29);
  var_27 = [];
  var_28 = getdvarint("_encstr_A5E3219EFE039F516A6F80A86F836B678BE69EA9D73BD7D82FA7185847A7602FA20C37", 1);

  if(var_28 > 0) {
    foreach(var_30 in var_26)
    var_27[var_30] = var_28;
  }

  var_32 = 0;

  foreach(var_2, var_1 in level.questinfo.tabletinfo) {
    var_7 = getlootscriptablearrayinradius(removepatchablecollision_delayed(var_2));
    var_32 = var_32 + var_7.size;

    if(var_1.enabled) {
      foreach(var_21 in var_7) {
        if(istrue(var_21._id_13840)) {
          var_21 tablethide();
          continue;
        }

        var_21 tabletshow();

        if(var_27.size > 0) {
          var_35 = _encstr_B2372553095ECF72D09FAFE571E27F3709619B7BF3BDEFFD588527F36BA0C547ADBB6396790E57::removeminigunrestrictions(var_21.origin);

          if(isDefined(var_27[var_35])) {
            var_27[var_35]--;

            if(!var_27[var_35])
              var_27[var_35] = undefined;
          }
        }
      }

      continue;
    }

    foreach(var_21 in var_7)
    var_21 tablethide();
  }

  if(var_27.size) {
    var_4 = scripts\engine\utility::array_randomize(var_4);

    for(var_17 = 0; var_17 < var_4.size; var_17++) {
      var_21 = var_4[var_17];
      var_22 = revivingteammate(var_21._id_139EB);

      if(isDefined(level.br_circle) && isDefined(var_22) && var_22 > 0) {
        var_17++;
        continue;
      }

      var_35 = _encstr_B2372553095ECF72D09FAFE571E27F3709619B7BF3BDEFFD588527F36BA0C547ADBB6396790E57::removeminigunrestrictions(var_21.origin);

      if(isDefined(var_27[var_35])) {
        var_21 tabletshow();
        var_27[var_35]--;

        if(!var_27[var_35]) {
          var_27[var_35] = undefined;

          if(!var_27.size) {
            break;
          }
        }
      }
    }
  }

  var_40 = level.questinfo.activetablets.size;
  var_41 = var_4.size;
  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroypropspecatehud(var_32, var_40, var_41, var_3);

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_8CE50ED185C48D59A325B238360B36AC"))
    thread _id_139E9(var_4);
  else
    thread ks_airdropcratearmor(var_4);
}

_id_13180(var_0) {
  if(issubstr(var_0, "_encstr_87D20AFAE4564616D81DAC23")) {
    if(!isDefined(level._id_12AAC))
      level._id_12AAC = "_encstr_B40101";

    if(level._id_12AAC == "_encstr_B40101") {
      var_1 = getquestindex(var_0);
      setomnvarbit("_encstr_84A1165850DFA3CA2F9889D865602B8A9B39E15BABFBB957", var_1, 1);
      level._id_12AAC = var_0;
    }
  } else {
    var_1 = getquestindex(var_0);
    setomnvarbit("_encstr_84A1165850DFA3CA2F9889D865602B8A9B39E15BABFBB957", var_1, 1);
  }
}

_id_139E9(var_0) {
  if(!isDefined(level.br_level)) {
    return;
  }
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = 0;
  var_2 = level._id_139EA;
  var_3 = 0;
  var_4 = var_0.size;

  foreach(var_6 in var_0) {
    if(!isDefined(var_6.circleindex))
      var_6.circleindex = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::relic_amped_reset_deathshield_on_revived(var_6.origin);
  }

  while(var_3 < var_4) {
    var_8 = var_0[var_3];

    if(istrue(var_8._encstr_8EB912CCA0758ACC88882B075083BDE3294FD647)) {
      var_3++;
      continue;
    }

    level waittill("_encstr_A3100E18FB608AB8AE43D392E5A86782");
    var_9 = obj_room_fire_01(var_8);

    if(var_9 < 1) {
      for(var_10 = 0; var_3 < var_4; var_9 = obj_room_fire_01(var_8)) {
        if(var_9 == 1 && var_8.circleindex >= relic_mythic_modifyplayerdamage()) {
          break;
        }

        if(var_9 == 0 && var_8.circleindex >= relic_mythic_modifyplayerdamage())
          var_0[var_0.size] = var_8;

        var_3++;
        var_8 = var_0[var_3];
      }
    }

    if(var_3 == var_4) {
      var_4 = var_0.size;
      continue;
    } else {
      if(isDefined(level._id_139EA) && level._id_139EA != -1) {
        var_1++;

        if(var_1 >= var_2) {
          var_8 tabletshow();
          var_2 = var_2 + level._id_139EA;
          var_3++;
          var_4 = var_0.size;
        }

        continue;
      }

      var_8 tabletshow();
      var_3++;
      var_4 = var_0.size;
    }
  }
}

ks_airdropcratearmor(var_0) {
  if(!isDefined(level.br_level)) {
    return;
  }
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_AD69131956360BF22B469A0DDB77A816898D958E6E")) {
    level thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_AD69131956360BF22B469A0DDB77A816898D958E6E", var_0);
    return;
  }

  var_1 = getdvarfloat("_encstr_88BB21EBD93B071E5886E0338BF3339759DA0E939DF1AF6243B06FFFBBCDEBFFAA6593", 0.3);
  var_2 = getdvarint("_encstr_BE0D31DFB71B90503A997BF33F03D828D327751947A3589048EDA38EA6F1207E2A9F9781CFBB1FC09447AE800BA5782ED2E36B", 0);
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_3 = level.br_level.br_circledelaytimes.size - 1 - getdvarint("_encstr_82C8285F57B679EA10962A33C9C024B10DEB93BB33DD21B3E878A3B121786ACAE90BDF13B3860A9AB001", 4);

  if(getdvarint("_encstr_93DE21E28EA5B12A03A993F7F0DBF2FA53906E9F780DAA632B308FD37931D6C2353977", 0) == 1)
    var_3 = _encstr_95992DE6D827D21C3A6EF2ADE0BC9DC2B6953ABC0E56B9F28939D7760BD6593AE583CABE4E59C4D2C9D143719DE6C6::rocket_attack_min_cooldown();
  else if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_9B220634456A5747"))
    var_3 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::remove_engineer_class();

  if(var_2 > 0)
    var_3 = var_2;

  var_4 = [];

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];
    var_6.circleindex = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::relic_amped_reset_deathshield_on_revived(var_6.origin);

    if(var_6.circleindex >= 0)
      var_4[var_4.size] = var_6;
  }

  var_0 = scripts\engine\utility::array_randomize(var_4);

  for(;;) {
    level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB");

    if(!level.br_circle.circleindex) {
      _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destorder(0, var_1, var_4.size, 0);
      continue;
    }

    var_4 = [];
    var_7 = [];

    for(var_5 = 0; var_5 < var_0.size; var_5++) {
      var_6 = var_0[var_5];

      if(var_6.circleindex >= relic_mythic_modifyplayerdamage()) {
        if(obj_room_fire_01(var_6) == 1) {
          var_4[var_4.size] = var_6;
          continue;
        }

        if(obj_room_fire_01(var_6) == 0)
          var_7[var_7.size] = var_6;
      }
    }

    var_8 = int(ceil(var_4.size * var_1));
    var_9 = int(max(0, getdvarint("_encstr_ACE21D6BABDD38EDB5CF3F508F43B9E73BB2BE91AD235990C8186849F2DF03", 100) - level.questinfo.activetablets.size));
    var_8 = int(min(var_8, var_9));

    for(var_5 = 0; var_5 < var_8; var_5++) {
      var_6 = var_4[var_5];
      var_6 tabletshow();
    }

    var_0 = [];

    for(var_5 = 0; var_5 < var_7.size; var_5++)
      var_0[var_0.size] = var_7[var_5];

    for(var_5 = var_8; var_5 < var_4.size; var_5++)
      var_0[var_0.size] = var_4[var_5];

    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destorder(level.br_circle.circleindex, var_1, var_4.size, var_8);

    if(level.br_circle.circleindex >= var_3) {
      break;
    }
  }
}

little_bird_mg_mp_enterendinternal() {
  foreach(var_6, var_1 in level.questinfo.tabletinfo) {
    var_2 = getlootscriptablearrayinradius(removepatchablecollision_delayed(var_6));

    if(var_1.enabled) {
      foreach(var_4 in var_2)
      var_4 tablethide();
    }
  }
}

tablethide() {
  thread anim_pause_fracs();
}

anim_pause_fracs() {
  self endon("_encstr_BD1805CB69C063");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_11A21(self);
}

tabletshow() {
  self notify("_encstr_BD1805CB69C063");
  var_0 = self.type;
  self setscriptablepartstate(var_0, "_encstr_BE8B08E323FB2BCD6268");
  level.questinfo.activetablets["_encstr_B40101" + self.index] = self;
  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::dialog_hurry(self);
}

tabletinit(var_0) {
  if(isDefined(self.init)) {
    return;
  }
  self.init = 1;
  self._id_139EB = var_0;
  var_1 = level.questinfo.quests[var_0].funcs["_encstr_95A10BA3B35EAA0DC074CD14CB"];

  if(isDefined(var_1)) {
    self.init = self[[var_1]]();

    if(!self.init)
      _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroyscoreevent(self);
  }
}

_id_1207A(var_0) {
  if(isDefined(level.questinfo.activetablets["_encstr_B40101" + var_0.index]))
    level.questinfo.activetablets["_encstr_B40101" + var_0.index] = undefined;
}

removepatchablecollision_delayed(var_0) {
  var_1 = undefined;

  if(isDefined(level.questinfo.tabletinfo[var_0]))
    var_1 = level.questinfo.tabletinfo[var_0]._id_11A3C;

  if(!isDefined(var_1))
    var_1 = "_encstr_8C7A081EBE517AFF1B61" + var_0 + "_encstr_8D500871F35FC6F0DF89";

  return var_1;
}

registerteamonquest(var_0, var_1) {
  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::determinetrackingcirclesize(self, var_1);

  if(istrue(level.questinfo._id_132E8)) {
    var_2 = var_0 + var_1.squadindex;
    level.questinfo._id_13745 = scripts\engine\utility::array_add(level.questinfo._id_13745, var_2);
  } else
    level.questinfo.teamsonquests = scripts\engine\utility::array_add(level.questinfo.teamsonquests, var_0);

  if(!isDefined(level.questinfo._id_11B69))
    level.questinfo._id_11B69 = [];

  level.questinfo._id_11B69[var_0] = rewardangles(var_0, 1);
  level notify("_encstr_A3100E18FB608AB8AE43D392E5A86782", var_0, var_1.squadindex);
}

releaseteamonquest(var_0) {
  if(!scripts\mp\menus::_id_13733()) {}

  if(isDefined(level.questinfo._id_11B69)) {
    level.questinfo._id_11B69[var_0] = undefined;
    scripts\mp\perks\perkfunctions::_id_14022(var_0);
  }

  if(istrue(level.questinfo._id_132E8)) {
    var_1 = var_0 + self.squadindex;
    level.questinfo._id_13745 = scripts\engine\utility::array_remove(level.questinfo._id_13745, var_1);
  } else
    level.questinfo.teamsonquests = scripts\engine\utility::array_remove(level.questinfo.teamsonquests, var_0);

  var_2 = ringing(var_0);
  var_3 = [];

  if(isDefined(self.result) && self.result == "_encstr_88E30897BDF1B71F7823") {
    foreach(var_5 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, self.squadindex)) {
      if(isbot(var_5) && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker()) {
        continue;
      }
      var_5.egress_landlord_vo = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::get_int_or_0(var_5.egress_landlord_vo) + 1;
      var_5 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_8AD9126BA5B96ED2B7E6DC68B7ADC1D82B47AC32", var_5.egress_landlord_vo);
      var_5 scripts\mp\utility\stats::incpersstat("_encstr_A77D0ABAF0559B4B51C6041B", 1);

      if(!isDefined(var_5.ejectplayerfromturret))
        var_5.ejectplayerfromturret = [];

      var_5.ejectplayerfromturret[self.questcategory] = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::get_int_or_0(var_5.ejectplayerfromturret[self.questcategory]) + 1;
      var_5 _encstr_ABE327C7AF0393A844EAD8E8527758DFAA1F715B7B9A668A6A82DE217CE1F881824BDFFB9F96242083::getallspawninstances("_encstr_B1951998C97DD658CDD1CA9C5EF599A59DB234BD9BD1C9B036D1E6");
    }

    if(!isDefined(self._id_11EBA) || self._id_11EBA == 0) {
      if(isDefined(self._id_12D2E) && isDefined(self._id_12D2B) && isDefined(self._id_12D30))
        var_3 = search_speed(var_0, self._id_12D2E, self._id_12D2B, self._id_12D30, self.house_enter_animate_and_kill_player);
    }
  }

  if(isDefined(self.result)) {
    var_7 = scripts\engine\utility::ter_op(self.result == "_encstr_88E30897BDF1B71F7823", 1, 2);
    var_8 = self.category;

    foreach(var_5 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, self.squadindex)) {
      if(isbot(var_5) && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker()) {
        continue;
      }
      var_5 scripts\cp\vehicles\vehicle_compass_cp::_id_12009(self.category, var_7, 1);
      var_5 _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_9A8B0EBDB986F69B3A4E851B3A8A3719", var_7);
      var_5 notify("_encstr_91D9276C8563B1B75D8EAD0B936D95E4835AB9D9EBBB8527E9F673CAA55A1B36A2AE56E6D1A436DBCD");
    }

    if(isDefined(self.targetteam)) {
      var_11 = scripts\engine\utility::ter_op(self.result == "_encstr_88E30897BDF1B71F7823", 2, 1);

      foreach(var_5 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, self.squadindex)) {
        if(isbot(var_5) && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker()) {
          continue;
        }
        var_5 scripts\cp\vehicles\vehicle_compass_cp::_id_12009(self.category, var_11, 2);
      }
    }
  }

  var_14 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, self.squadindex);
  var_15 = var_14.size;
  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::determinetrackingcircleoffset(self, var_2, var_3, var_15);
  self notify("_encstr_A3930BFFC7652B2418ADDC2161");

  if(isDefined(self._id_12D30))
    self._id_12D30 notify("_encstr_A3930BFFC7652B2418ADDC2161");
}

_id_13879(var_0, var_1, var_2) {
  foreach(var_4 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_2, self.squadindex)) {
    if(isbot(var_4) && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker()) {
      continue;
    }
    var_4 scripts\cp\vehicles\vehicle_compass_cp::_id_1200A(var_0, var_1);
  }
}

_id_13A38(var_0) {
  switch (var_0.type) {
    case "_encstr_BE7925B6634847D225A7DB9FC947DA94F84961FEFB18116BFEE3A387017B42F681D3668670F0CC":
    case "_encstr_913F1C3276C0F79DA9C1221BB8DBD2CFD8D0B9BC03482BA981581AE22019":
      _encstr_AFDA30371B274B1CE8CDF2B583E5B30BB5ACA3978356DCE54CE4AFB0B96E0BDC6EB4B92CD1A5DBCD7D5CAECADC8E5C9D376C::takequestitem(var_0);
      break;
    case "_encstr_8B5F22989C367BEDE8FAE49519C26C8E95C8AF32DBB5B4E6B0A3967BCDEBD12C988D95E8":
    case "_encstr_BE1E194A0E91B877C347FD581559B387ADBB77AD4E8CDFA55822FB":
      if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_A1D0081CC297B1EDB08C")
        _encstr_83852BDAB6ED9A609B809E9FB0D82F42BBDD63D0A77BF3F7A19067BF406BF31A6760EBC18FB32AD34B9A8FF778::takequestitem(var_0);
      else
        _encstr_BD8926CDD8E42D073A9B976B0ECBCEC2B6B21DCBC1596E79C427EB197BB5AF2EAB95B947B83B37B1::takequestitem(var_0);

      break;
    case "_encstr_A75421F6E051E24F13C942AAE113EBB35A74492EFB1AB3D76BEAE8139199A659A11B13":
    case "_encstr_BA5A1826E463DEBD3AFACD1B583B959BEC5639D7A30B8963B23A":
      _encstr_AD562C9A0106DBEB134320E0CBEF8C81F0B5DB1FF38B07B711CAE7FFF126B329A887EDDDC14267FD62A3C2692EAF::takequestitem(var_0);
      break;
    case "_encstr_8C181B6B7068871A1958625F3DDB1244916827B33083FFF30BEEED571D":
    case "_encstr_ABF012FBE0F8178A692813CCA717F3A181B87F2B":
      _encstr_92CD26C37908D8EB3D1F670F50C8DA3955FB5BD792B14F9E42836953ACF2D18F7312F230F087FB66::takequestitem(var_0);
      break;
    case "_encstr_8F0A20D8EBD50F380BBFDE5D9C8761F17F72B9F0F22D43117BBDE85864AF09B927DB":
    case "_encstr_AA7F175A0B90A73D9BB1D14F21FF32ED7D70207DB1A33C47AB":
      _encstr_86912B6E0EF303C3BC0FC2D86B8F794BAA3765F3227AFFE0921339083715F189035BD068FAD3AB536C4AF038F7::takequestitem(var_0);
      break;
    case "_encstr_B4D11AC4C963DEED47BE9DB24BD9AC4EE61DC2CDA17D47854C8D59A3":
      _encstr_9A642E829E286FE109F3A2F3F0278136506FF0714830EFFF0EBB7127B3409727480AE35F436850C7D598235158F2E357::takequestitem(var_0);
      break;
    case "_encstr_845B1F61B25C48807B3F8D898F3257E8E10D2B19D8AC784F22FBFFB1F7AA91E894":
      _encstr_8F4D2A4057AAF8318B1A2801B25657A1EDE7C09883557357D242681D883B85694BDB11407FED0BA9FE2F7616::takequestitem(var_0);
      break;
    case "_encstr_AA021EC813B4380F8B110606F6C35340E7E7F0A9935151D1A2C3681F8FBAAB0B":
      _encstr_A25F32A802AAEB33933BD8E110D69943D5CA0870CB8717E09342E8E61B1763037D7208D091DA43613F6C90D7F40B49F5B51A9BD0::takequestitem(var_0);
      break;
    case "_encstr_9AB7223127D8BDBDE8FA6EC60B9D56DC9DB293BE3A0B138DCA47F5E6DB2CEBE8BDDD5693":
      _encstr_93A436EA59A0592B1DC7A6A7E9688289B061A3F093A00B967EDD5FC73767DBC5F0891FBAEE68B5CACEB957CF071F712C50139702A83B7BE2::takequestitem(var_0);
      break;
    case "_encstr_951B1278EA63183F2B87B8436BC9BB43663049F0":
      _encstr_BD7726BB0F589413EDB3163AFB68974E48FB342981585A269E8B2932A11F3F02D053CBACA520E2EF::dropoff_sound_hvt_handler(var_0);
      break;
    case "_encstr_86661598E4D8F6DB8EF56EAB0E388DE5FAD15889B1B28E":
      _encstr_910B29179372A0DF33EB3060C3061CA8CDED919B281FA88883D336ABFB534F38607FE30BA542D840AF3B89::takequestitem(var_0);
      break;
    case "_encstr_885B22C43936DBDEE8D7B6C2E6D1CA93586EDC2CDCB996CD2CE85AB737EBE82C4C63CAE8":
      _encstr_8BAB36731E7AD22383DBA865332F57F865170303C8E5272EA25ADE2BAA2EE8D5B3325313987A727436E91B4C2F2387B7C7B3CB884530C3B2::takequestitem(var_0);
      break;
    case "_encstr_A19E2016B64962F71359632798E9B39B23C5D1CA97FDBA1459B037C770C16AE28B65":
    case "_encstr_8FE717A2CBB137553027D3C975C0DB576C41094B311EF30FC8":
      _encstr_8DD92B9B364EA5C11DDCCBAD38CBCE0BB5AC3ACB0EB2B9E54C39EB6E2C26F61D0BEC2BBE175D2BCD1DC576DCC6::takequestitem(var_0);
      break;
    case "_encstr_83AC1B5EEE34DA7FE007BAC54A4058D078E6BBBF38C357EB6BA0F1422B":
      _encstr_A77C2FBB906DDC43F3CE5F0567B0D766EB085393702B1206E9B6270271019F2C67D08A5B5BF30B8FE31DE52B15C0477247::takequestitem(var_0);
  }

  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_11C91("_encstr_A17816F8CBF52F182B5FB1BB6BEF2DE7DDA1C078A28D6333", -1);
}

dangercircletick(var_0, var_1, var_2) {
  if(!isDefined(level.questinfo)) {
    return;
  }
  foreach(var_4 in level.questinfo.activetablets) {
    if(distance2dsquared(var_0, var_4.origin) > var_1 * var_1) {
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_11A21(var_4);
      _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_11C91("_encstr_A17816F8CBF52F182B5FB1BB6BEF2DE7DDA1C078A28D6333", -1);
    }
  }

  foreach(var_7 in level.questinfo.quests) {
    if(isDefined(var_7.funcs["_encstr_875E0B19E2BBDE083F348B9723"])) {
      foreach(var_9 in var_7.instances)
      var_9[[var_7.funcs["_encstr_875E0B19E2BBDE083F348B9723"]]](var_0, var_2);
    }
  }
}

createquestinstance(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.questcategory = var_0;
  var_5.enabled = 1;
  var_5.category = var_0;
  var_5.id = var_1;
  var_5._id_11C4E = "_encstr_B40101" + var_2;
  var_5._id_12D30 = var_3;
  var_5 _assignthinkoffset();
  var_5.squadindex = var_4;
  return var_5;
}

addquestinstance(var_0, var_1) {
  if(!istrue(level.questinfo.ismanagerthreadthinking)) {
    _initmanagerquestthread();
    level.questinfo thread _questmanagerthread();
  }

  if(!_isquestthreaded(var_0) && isDefined(level.questinfo.quests[var_0].numthinkfuncs)) {
    if(_checkforregister(var_0, "_encstr_ABD90EAAF08B9312E09B2B14C578E247"))
      level.questinfo.quests[var_0] _runinitquestvars(var_0);

    _runaddquestinstance(var_0, var_1);
    _runaddquestthread(var_0);
  } else
    _runaddquestinstance(var_0, var_1);
}

removequestinstance() {
  if(istrue(self.removed)) {
    return;
  }
  self.removed = 1;
  self notify("_encstr_921711BD93D330B2958F438AE1129220F83351");
  var_0 = self.questcategory;
  _runremovequestinstance(var_0);

  if(isDefined(self._id_1393B))
    leavequestlocale();

  if(_questinstancesactive(var_0) <= 0) {
    if(_checkforregister(var_0, "_encstr_87510F4F190DAACA3903FF421B39E153DE"))
      level.questinfo.quests[var_0] _runclearquestvars(var_0);

    if(_questthreadsactive() <= 0)
      _removemanagerquestthread();
  }
}

upper_door_coll(var_0) {
  return isDefined(var_0.subscribedinstances);
}

_initmanagerquestthread() {
  level.questinfo.ismanagerthreadthinking = 1;
}

_removemanagerquestthread() {
  level notify("_encstr_8FB2192BDCC8EBE25D59E6E8AFB6B09BB07695E4F5470D932B0B32");
  level.questinfo.ismanagerthreadthinking = 0;
}

_questmanagerthread() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8FB2192BDCC8EBE25D59E6E8AFB6B09BB07695E4F5470D932B0B32");

  for(;;) {
    wait 0.05;
    level.questinfo.thinkindex++;

    foreach(var_1 in level.questinfo.thinkers) {
      if(!level.questinfo.quests[var_1].enabled) {
        continue;
      }
      foreach(var_3 in level.questinfo.quests[var_1].instances) {
        if(var_3.enabled)
          var_3 _runquestthinkfunctions(var_1);
      }
    }
  }
}

_runquestthinkfunctions(var_0) {
  for(var_1 = 0; var_1 < level.questinfo.quests[var_0].numthinkfuncs; var_1++) {
    if((level.questinfo.thinkindex - (self.thinkoffset + self.firstthink)) % level.questinfo.quests[var_0].thinkrates[var_1] == 0) {
      var_2 = "_encstr_91E00B47A3458B4B4B83383854" + var_1;
      [[level.questinfo.quests[var_0].funcs[var_2]]]();
    }
  }
}

_assignthinkoffset() {
  if(!isDefined(level.questinfo.thinkoffset))
    level.questinfo.thinkoffset = 0;

  self.thinkoffset = level.questinfo.thinkoffset;
  self.firstthink = level.questinfo.thinkindex;
  level.questinfo.thinkoffset++;
}

_registerquestfunc(var_0, var_1, var_2) {
  level.questinfo.quests[var_0].funcs[var_2] = var_1;
}

_checkforregister(var_0, var_1) {
  return isDefined(level.questinfo.quests[var_0].funcs[var_1]);
}

registerquestcategory(var_0, var_1) {
  var_2 = upload_station_players_manager(var_0, var_1);
  var_3 = spawnStruct();
  var_3.enabled = var_2;
  level.questinfo.tabletinfo[var_0] = var_3;

  if(!var_2)
    return 0;

  _registerquestcategory(var_0);
  return 1;
}

upload_station_players_manager(var_0, var_1) {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_AF190997F3A62B7168C0DA"))
    return 0;

  return getdvarint("_encstr_85AA08C091CA67165B67" + var_0 + "_encstr_84E007B963F5C78AF8", var_1) == 1;
}

registerquestlocale(var_0) {
  _registerquestcategory(var_0);
}

_registerquestcategory(var_0) {
  if(!isDefined(level.questinfo.quests[var_0])) {
    level.questinfo.quests[var_0] = spawnStruct();
    level.questinfo.quests[var_0].initflag = 0;
    level.questinfo.quests[var_0].hasinitfunc = 0;
    level.questinfo.quests[var_0].funcs = [];
    level.questinfo.quests[var_0].instances = [];
    level.questinfo.quests[var_0].enabled = 1;
    _id_12B38(var_0);
  }
}

_id_12B38(var_0) {
  level.questinfo._id_139EC[var_0] = spawnStruct();
  level.questinfo._id_139EC[var_0].index = getquesttableindex(var_0);
}

registerinitquestvars(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "_encstr_ABD90EAAF08B9312E09B2B14C578E247");
  level.questinfo.quests[var_0].hasinitfunc = 1;
}

registerquestthink(var_0, var_1, var_2) {
  if(!isDefined(level.questinfo.quests[var_0].numthinkfuncs))
    level.questinfo.quests[var_0].numthinkfuncs = 0;

  var_3 = int(var_2 * 20);
  level.questinfo.quests[var_0].thinkrates[level.questinfo.quests[var_0].numthinkfuncs] = var_3;
  var_4 = "_encstr_91E00B47A3458B4B4B83383854" + level.questinfo.quests[var_0].numthinkfuncs;
  _registerquestfunc(var_0, var_1, var_4);
  level.questinfo.quests[var_0].numthinkfuncs = level.questinfo.quests[var_0].numthinkfuncs + 1;
}

registerquestcircletick(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "_encstr_875E0B19E2BBDE083F348B9723");
}

registerremovequestinstance(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "_encstr_A1250F68AAA5DFCB9F5920A65CB7F08F0F");
}

registerclearquestvars(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "_encstr_87510F4F190DAACA3903FF421B39E153DE");
}

registerplayerfilter(var_0, var_1, var_2) {
  if(!isDefined(level.questinfo.quests[var_0].filters))
    level.questinfo.quests[var_0].filters = [];

  if(isDefined(var_2))
    level.questinfo.quests[var_0].filters[var_2] = var_1;
  else {
    var_3 = level.questinfo.quests[var_0].filters.size;
    level.questinfo.quests[var_0].filters[var_3] = var_1;
  }
}

registeronplayerkilled(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "_encstr_8CDB0F17758F62C1503912545010040A7D");
}

_id_12B2E(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "_encstr_A6B4130FC0BFD4AA337552C76B0FC26FC068BFB7E8");
}

_id_12B2D(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "_encstr_813E0D8736072075DF63D59BEAA7A4");
}

_id_12B30(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "_encstr_BA4C0AEF5D11DF47B7B9EB42");
}

_id_12B32(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "_encstr_861D0E7BB92AA5B6CAE4AAE032C2A395");
}

_id_12B31(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "_encstr_B1FE0FF88D4C50A972E3BBC983DA6E4814");
}

_id_12B3D(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "_encstr_95A10BA3B35EAA0DC074CD14CB");
}

_id_12B2A(var_0, var_1) {
  level.questinfo.tabletinfo[var_0]._id_11A3C = var_1;
}

_clearregisters(var_0) {
  var_1 = [];
}

onplayerkilled(var_0, var_1) {
  if(!isDefined(level.questinfo)) {
    return;
  }
  foreach(var_3 in level.questinfo.quests) {
    if(isDefined(var_3.funcs["_encstr_8CDB0F17758F62C1503912545010040A7D"])) {
      foreach(var_5 in var_3.instances)
      var_5[[var_3.funcs["_encstr_8CDB0F17758F62C1503912545010040A7D"]]](var_0, var_1);
    }
  }
}

onplayerconnect(var_0) {
  if(!isDefined(level.questinfo)) {
    return;
  }
  if(!isDefined(var_0.team)) {
    return;
  }
  _id_131B0(var_0.team, ringing(var_0.team), var_0.squadindex);
}

onplayerdisconnect(var_0) {
  if(!isDefined(level.questinfo)) {
    return;
  }
  foreach(var_2 in level.questinfo.quests) {
    if(isDefined(var_2.funcs["_encstr_A6B4130FC0BFD4AA337552C76B0FC26FC068BFB7E8"])) {
      foreach(var_4 in var_2.instances)
      var_4[[var_2.funcs["_encstr_A6B4130FC0BFD4AA337552C76B0FC26FC068BFB7E8"]]](var_0);
    }
  }
}

_id_1206C() {
  if(!isDefined(level.questinfo)) {
    return;
  }
  foreach(var_1 in level.questinfo.quests) {
    if(isDefined(var_1.funcs["_encstr_813E0D8736072075DF63D59BEAA7A4"])) {
      foreach(var_3 in var_1.instances)
      var_3[[var_1.funcs["_encstr_813E0D8736072075DF63D59BEAA7A4"]]](self);
    }
  }
}

_id_12072() {
  if(!isDefined(level.questinfo)) {
    return;
  }
  self setclientomnvar("_encstr_8108196B214730C1B95089B288C3F3A9AF6DE751CFE66873BF5370", gettime());

  foreach(var_1 in level.questinfo.quests) {
    if(isDefined(var_1.funcs["_encstr_BA4C0AEF5D11DF47B7B9EB42"])) {
      foreach(var_3 in var_1.instances)
      var_3[[var_1.funcs["_encstr_BA4C0AEF5D11DF47B7B9EB42"]]](self);
    }
  }
}

_runinitquestvars(var_0) {
  [[level.questinfo.quests[var_0].funcs["_encstr_ABD90EAAF08B9312E09B2B14C578E247"]]]();
}

_runaddquestthread(var_0) {
  if(!_isquestthreaded(var_0)) {
    var_2 = level.questinfo.thinkers.size;
    level.questinfo.thinkers[var_2] = var_0;
    level.questinfo.quests[var_0].enabled = 1;
  } else {}
}

_runaddquestinstance(var_0, var_1) {
  level.questinfo.quests[var_0].instances[var_1.id] = var_1;
}

_runremovequestinstance(var_0) {
  self[[level.questinfo.quests[var_0].funcs["_encstr_A1250F68AAA5DFCB9F5920A65CB7F08F0F"]]]();
  self notify("_encstr_A2BD0839CAB6B7CE5919");
  level.questinfo.quests[var_0].instances[self.id] = undefined;
}

_runclearquestvars(var_0) {
  [[level.questinfo.quests[var_0].funcs["_encstr_87510F4F190DAACA3903FF421B39E153DE"]]]();
  level.questinfo.thinkers = scripts\engine\utility::array_remove(level.questinfo.thinkers, var_0);
  level.questinfo.quests[var_0].enabled = 0;
}

_isquestthreaded(var_0) {
  if(scripts\engine\utility::array_contains(level.questinfo.thinkers, var_0))
    return 1;

  return 0;
}

_questinstancesactive(var_0) {
  if(isDefined(level.questinfo.quests[var_0].instances))
    return level.questinfo.quests[var_0].instances.size;

  return 0;
}

_questthreadsactive() {
  if(isDefined(level.questinfo.thinkers))
    return level.questinfo.thinkers.size;

  return 0;
}

createlocaleinstance(var_0, var_1, var_2) {
  var_3 = createquestinstance(var_0, var_2, "_encstr_975C08DAFD6501713F9D", undefined, self.squadindex);
  var_3.subscriber_type = var_1;
  getquestdata(var_1).locale_type = var_0;
  var_3.subscribedinstances = [];
  return var_3;
}

registercreatequestlocale(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "_encstr_83500E76430A692CB5FFC292DFF81DD7");
}

_id_12B2B(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "_encstr_836C0CAD577088471927A7722193");
}

registercheckiflocaleisavailable(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "_encstr_AADE10295C2D50FAA1DF8DABD7BA3780CCF7");
}

adrenaline_crate_player_at_max_ammo(var_0) {
  switch (var_0._id_12FA3) {
    case "_encstr_8A351DE42D9BE58D4BCAC0A0B2276FFBEFD3867B902329DD351251E0ABFE33":
      return getentitylessscriptablearrayinradius(var_0.vehicle_collision_registerevent, "_encstr_AC110A7F14873B5B3D073009", var_0._id_12F9F, var_0._id_12FA6);
    case "_encstr_B16718DF8753BD6855FA81B92D27286558FF4F493FA8F6709950":
      var_1 = getlootspawnpoint(var_0._id_12F9F, var_0._id_12FA6, 0, 1);
      return var_1;
    case "_encstr_9A17115CD55637E80AB7B473E8B9509393B097":
      return disablelootspawnpoint(var_0._id_1297F, var_0._id_12F9F, var_0._id_12FA6, 0, 1);
    case "_encstr_AD1C182B5B6D903511A7F3F5E30BE7C01236526708E450677ABB":
      var_2 = play_thrust_fx(var_0);

      if(isDefined(var_2))
        return var_2;

      var_0._id_1407E = undefined;
      return disablelootspawnpoint(var_0._id_1297F, var_0._id_12F9F, var_0._id_12FA6, 0, 1);
    case "_encstr_AF500AEC2B4769D2DECD5B37":
      var_3 = _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::registeraccesscardlocs();
      var_4 = [];

      foreach(var_6 in level.br_armory_kiosk.scriptables) {
        if(!istrue(var_6.disabled))
          var_4[var_4.size] = var_6;
      }

      return var_4;
    case "_encstr_8B7F149D563A4A9B581BD12D3B560959B15A83588CB9":
      if(isDefined(level.br_plunder_sites)) {
        var_8 = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::retrieve_data_objective();
        var_9 = [];

        foreach(var_11 in var_8) {
          if(istrue(var_11 getscriptablepartstate(var_11.type) == "_encstr_95DF070DD22319CA9B"))
            var_9[var_9.size] = var_11;
        }

        if(var_9.size == 0)
          return var_8;

        return var_9;
      }
    default:
  }
}

play_thrust_fx(var_0) {
  var_1 = undefined;

  if(isDefined(level._id_145F1) && isDefined(level._id_145F1._id_13C8D)) {
    if([[level._id_145F1.funcs.c130airdrop_createpath]]())
      return undefined;

    if([[level._id_145F1.funcs.c130airdrop_deleteatlifetime]](100, 20))
      return undefined;

    var_2 = [];

    foreach(var_4 in level._id_145F1._id_13C8D) {
      if(isDefined(var_4.maphint_keypadscriptableused) && level._id_145F1.hotfootlastposition >= var_4.mapnamefilter)
        var_2[var_2.size] = var_4;
    }

    var_6 = 0;
    var_7 = undefined;

    foreach(var_4 in var_2) {
      if(isDefined(var_4.maphitloctoburningpart) && var_6 < var_4.maphitloctoburningpart) {
        var_6 = var_4.maphitloctoburningpart;
        var_7 = var_4;
      }
    }

    if(var_2.size > 1) {
      if(isDefined(var_7))
        var_2 = scripts\engine\utility::array_remove(var_2, var_7);
    }

    var_4 = scripts\engine\utility::random(var_2);
    var_4.maphitloctoburningpart = gettime();
    level._id_145F1.hostvictimskipburndownmedium = var_4;
    var_10 = spawnStruct();
    var_10.origin = var_4.origin;
    var_10.angles = var_4.angles;
    var_10.spawnflags = 4;
    var_10.traincar = var_4;
    var_10.offset = var_4.maphint_keypadscriptableused;
    var_1 = [];
    var_1[var_1.size] = var_10;
  }

  return var_1;
}

ai_molotov_swapp(var_0, var_1) {
  var_0 = scripts\engine\utility::array_randomize(var_0);

  if(!isDefined(var_1.mintime))
    var_1.mintime = 0;

  if(!isDefined(var_1._id_13D09))
    var_1._id_13D09 = 190;

  var_2 = isDefined(var_1._id_12FA4) && isDefined(var_1._id_12FA5);

  if(istrue(var_1._id_12FA1))
    var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getmintimetillpointindangercircle(var_1._id_12F9F);
  else
    var_3 = 0;

  var_4 = spawnStruct();
  var_5 = undefined;
  var_6 = var_1._id_12FA6;

  foreach(var_13, var_8 in var_0) {
    var_9 = distance2d(var_8.origin, var_1._id_12F9F);

    if(var_9 < var_1._id_12FA7) {
      continue;
    }
    if(!level.br_circle_disabled) {
      var_10 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getmintimetillpointindangercircle(var_8.origin);

      if(var_10 <= var_3) {
        continue;
      }
      if(var_1._id_13D09 > 0) {
        var_11 = var_9 / var_1._id_13D09;
        var_10 = var_10 - var_11;
      }

      if(var_10 < var_1.mintime)
        continue;
    }

    if(var_2) {
      if(var_9 < var_1._id_12FA4) {
        if(var_9 >= var_1._id_12FA5)
          var_12 = 0;
        else
          var_12 = var_1._id_12FA5 - var_9;
      } else
        var_12 = var_9 - var_1._id_12FA4;

      if(var_12 < var_6) {
        var_6 = var_12;
        var_5 = var_13;

        if(var_12 <= 0) {
          break;
        }
      }

      continue;
    }

    var_5 = var_13;
  }

  var_14 = undefined;

  if(isDefined(var_5))
    var_14 = var_0[var_5];
  else {}

  return var_14;
}

_runcreatequestlocale(var_0, var_1) {
  if(isDefined(var_1))
    var_2 = self[[level.questinfo.quests[var_0].funcs["_encstr_83500E76430A692CB5FFC292DFF81DD7"]]](var_1);
  else
    var_2 = self[[level.questinfo.quests[var_0].funcs["_encstr_83500E76430A692CB5FFC292DFF81DD7"]]]();

  return var_2;
}

ammo_boxes(var_0, var_1) {
  if(isDefined(var_1))
    self[[level.questinfo.quests[var_0].funcs["_encstr_836C0CAD577088471927A7722193"]]](var_1);
  else
    self[[level.questinfo.quests[var_0].funcs["_encstr_836C0CAD577088471927A7722193"]]]();
}

_runcheckiflocaleisavailable(var_0) {
  return self[[level.questinfo.quests[var_0].funcs["_encstr_AADE10295C2D50FAA1DF8DABD7BA3780CCF7"]]]();
}

_findexisitingquestlocale(var_0, var_1) {
  var_2 = getquestdata(var_0);

  if(!isDefined(var_2) || !isDefined(var_2.instances))
    return undefined;

  foreach(var_4 in var_2.instances) {
    var_5 = distance2d(var_1._id_12F9F, var_4.curorigin);

    if(var_5 > var_1._id_12FA6) {
      continue;
    }
    if(!var_4 _runcheckiflocaleisavailable(var_0)) {
      continue;
    }
    return var_4;
  }

  return undefined;
}

play_train_speaker_vo(var_0, var_1) {
  if(isDefined(var_1._id_12C4A))
    var_2 = var_1._id_12C4A;
  else {
    var_3 = adrenaline_crate_player_at_max_ammo(var_1);

    if(istrue(var_1._id_1407E))
      var_2 = var_3[0];
    else
      var_2 = ai_molotov_swapp(var_3, var_1);
  }

  return var_2;
}

requestquestlocale(var_0, var_1, var_2) {
  var_3 = undefined;

  if(!isDefined(var_2) || !var_2)
    var_3 = _findexisitingquestlocale(var_0, var_1);

  if(!isDefined(var_3)) {
    var_4 = play_train_speaker_vo(var_0, var_1);
    var_3 = _runcreatequestlocale(var_0, var_4);
  }

  _id_1393C(var_3);
  return var_3;
}

_id_1393C(var_0) {
  self._id_1393B = var_0;
  var_0.subscribedinstances = scripts\engine\utility::array_add(var_0.subscribedinstances, self);
}

_id_11DAF(var_0, var_1) {
  var_2 = play_train_speaker_vo(var_0, var_1);
  var_2._id_11C4E = var_1._id_11C4E;
  ammo_boxes(var_0, var_2);
}

leavequestlocale() {
  var_0 = getquestdata(self.questcategory).locale_type;
  var_1 = self._id_1393B;
  var_1.subscribedinstances = scripts\engine\utility::array_remove(var_1.subscribedinstances, self);

  if(var_1.subscribedinstances.size <= 0)
    var_1 removequestinstance();
}

getquestdata(var_0) {
  return level.questinfo.quests[var_0];
}

getquestinstancedata(var_0, var_1) {
  return level.questinfo.quests[var_0].instances[var_1];
}

reviveteam(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(level.questinfo) && isDefined(level.questinfo.quests[var_0]))
    var_2 = level.questinfo.quests[var_0].instances[var_1];

  return var_2;
}

checkforinstance(var_0, var_1) {
  if(isDefined(level.questinfo.quests[var_0].instances[var_1]))
    return 1;

  return 0;
}

_validateplayerfilter(var_0) {
  if(isDefined(var_0)) {
    if(isint(var_0))
      return level.questinfo.quests[self.questcategory].filters[var_0];

    if(isarray(var_0))
      return var_0;
  } else if(isDefined(level.questinfo.quests[self.questcategory].filters))
    return level.questinfo.quests[self.questcategory].filters[0];
  else
    return level.questinfo.defaultfilter;
}

_validateplayer(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(![[var_3]](var_0))
      return 0;
  }

  return 1;
}

isplayervalid(var_0, var_1) {
  var_2 = _validateplayerfilter(var_1);
  return _validateplayer(var_0, var_2);
}

isteamvalid(var_0, var_1) {
  var_2 = _validateplayerfilter(var_1);

  foreach(var_4 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, self.squadindex)) {
    if(_validateplayer(var_4, var_2))
      return 1;
  }

  return 0;
}

isentireteamvalid(var_0, var_1) {
  var_2 = _validateplayerfilter(var_1);

  foreach(var_4 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, self.squadindex)) {
    if(!_validateplayer(var_4, var_2))
      return 0;
  }

  return 1;
}

getvalidplayersinteam(var_0, var_1) {
  var_2 = _validateplayerfilter(var_1);
  var_3 = [];

  foreach(var_5 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"]) {
    if(_validateplayer(var_5, var_2))
      var_3[var_3.size] = var_5;
  }

  return var_3;
}

run_trap_room_combat(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = self.squadindex;

  var_3 = _validateplayerfilter(var_1);
  var_4 = [];

  foreach(var_6 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, var_2)) {
    if(_validateplayer(var_6, var_3))
      var_4[var_4.size] = var_6;
  }

  return var_4;
}

getvalidplayersinarray(var_0, var_1) {
  var_2 = _validateplayerfilter(var_1);
  var_3 = [];

  foreach(var_5 in var_0) {
    if(_validateplayer(var_5, var_2))
      var_3[var_3.size] = var_5;
  }

  return var_3;
}

sortvalidplayersinarray(var_0, var_1) {
  var_2 = _validateplayerfilter(var_1);
  var_3 = [];
  var_3["_encstr_9B9406CE2CC64B23"] = [];
  var_3["_encstr_975C08DAFD6501713F9D"] = [];

  foreach(var_5 in var_0) {
    if(_validateplayer(var_5, var_2)) {
      var_3["_encstr_9B9406CE2CC64B23"][var_3["_encstr_9B9406CE2CC64B23"].size] = var_5;
      continue;
    }

    var_3["_encstr_975C08DAFD6501713F9D"][var_3["_encstr_975C08DAFD6501713F9D"].size] = var_5;
  }

  return var_3;
}

rotations(var_0, var_1, var_2) {
  var_3 = (0, 0, 0);
  var_4 = run_trap_room_combat(var_0, var_1, var_2);

  if(var_4.size <= 0)
    return var_3;

  foreach(var_6 in var_4)
  var_3 = var_3 + var_6.origin;

  var_3 = var_3 / var_4.size;
  return var_3;
}

getteamcenter(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_3 = getvalidplayersinteam(var_0, var_1);

  if(var_3.size <= 0)
    return var_2;

  foreach(var_5 in var_3)
  var_2 = var_2 + var_5.origin;

  var_2 = var_2 / var_3.size;
  return var_2;
}

filtercondition_isdead(var_0) {
  if(!isalive(var_0))
    return 0;

  return 1;
}

filtercondition_isdowned(var_0) {
  if(istrue(var_0.inlaststand))
    return 0;

  return 1;
}

filtercondition_ingulag(var_0) {
  if(var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal())
    return 0;

  return 1;
}

filtercondition_hasbeeningulag(var_0) {
  if(isDefined(var_0.gulag))
    return 0;

  return 1;
}

play_landlord_infil_vo(var_0) {
  if(istrue(var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()))
    return 0;

  return 1;
}

play_intro_hacking_vo(var_0) {
  if(istrue(var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()))
    return 0;

  return 1;
}

_id_121B9(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 0;

  var_5 = var_4;
  var_5 = var_5 << 5 | var_3;
  var_5 = var_5 << 6 | var_2;
  var_5 = var_5 << 5 | var_1;
  var_5 = var_5 << 5 | var_0;
  return var_5;
}

displayteamsplash(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = self.squadindex;

  var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, var_3);
  longwaitradarsweep(var_4, var_1, var_2);
}

longwaitradarsweep(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_4 in var_0) {
    if(var_4 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
      continue;
    }
    if(isbot(var_4) && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker()) {
      continue;
    }
    if(isDefined(var_2)) {
      if(isDefined(var_2.excludedplayers)) {
        if(scripts\engine\utility::array_contains(var_2.excludedplayers, var_4))
          continue;
      }
    }

    displayplayersplash(var_4, var_1, var_2);
  }
}

displayplayersplash(var_0, var_1, var_2) {
  if(isDefined(var_2) && isDefined(var_2._id_121B5))
    var_0 thread scripts\mp\hud_message::showsplash(var_1, var_2._id_121B5);
  else if(isDefined(var_2) && isDefined(var_2.intvar))
    var_0 thread scripts\mp\hud_message::showsplash(var_1, var_2.intvar);
  else
    var_0 thread scripts\mp\hud_message::showsplash(var_1);
}

look_at_heli(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_2 * var_2;
  var_6 = [];

  foreach(var_8 in level.players) {
    var_9 = distancesquared(var_1, var_8.origin);

    if(var_9 > var_5) {
      continue;
    }
    if(isDefined(var_4) && isDefined(var_4.ogangles) && scripts\engine\utility::array_contains(var_4.ogangles, var_8.team)) {
      continue;
    }
    if(isDefined(var_4) && isDefined(var_4.excludedplayers) && scripts\engine\utility::array_contains(var_4.excludedplayers, var_8)) {
      continue;
    }
    if(isDefined(var_3) && !isplayervalid(var_8, var_3)) {
      continue;
    }
    var_6[var_6.size] = var_8;
  }

  if(var_6.size > 0) {
    foreach(var_8 in var_6)
    displayplayersplash(var_8, var_0, var_4);
  }
}

look_for_more_leads_vo(var_0, var_1, var_2) {
  var_3 = var_0 getentitynumber();

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_2))
    var_2 = 0;

  var_4 = 0;
  var_4 = var_2 << 12 | var_3 << 4 | var_1;
  self setclientomnvar("_encstr_8B471C9BE0605B4A212B90803B70178F15DEB272484DF7C5982F9399DF2B", var_4);
}

lookforvehicles(var_0, var_1, var_2, var_3) {
  foreach(var_5 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, var_1.squadindex))
  var_5 look_for_more_leads_vo(var_1, var_2, var_3);
}

scriptmover_utils(var_0, var_1) {
  var_0 thread scripts\mp\utility\points::giveunifiedpoints(var_1);
}

searchfunc(var_0, var_1) {
  foreach(var_3 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, self.squadindex))
  var_3 thread scripts\mp\utility\points::giveunifiedpoints(var_1);
}

fronttruck(var_0, var_1) {
  var_2 = _encstr_851F24F3D825E47B3B1687CDAF681F2EB3700BABA8D3DA4E91FEEFEACD8BCFB2D96836C208B7::relic_punchbullets_fire_fists(0, 0, 1, 0, 0);
  var_0 _encstr_851F24F3D825E47B3B1687CDAF681F2EB3700BABA8D3DA4E91FEEFEACD8BCFB2D96836C208B7::_id_1363A(var_2);
  level thread _encstr_851F24F3D825E47B3B1687CDAF681F2EB3700BABA8D3DA4E91FEEFEACD8BCFB2D96836C208B7::_id_11AAA();
}

giveteamplunderflat(var_0, var_1, var_2) {
  var_3 = getdvarfloat("_encstr_91F1207BB64B7F661D09EB22700DDF2FE330E7E8DBD0DFE1C788A2EA606B93D79884", 0.4);
  var_4 = 0;
  var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, var_2);

  foreach(var_7 in var_5) {
    if(isbot(var_7) && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker()) {
      continue;
    }
    var_8 = var_1;

    if(!scripts\mp\utility\player::isreallyalive(var_7))
      var_8 = int(var_1 * var_3);

    var_7 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(var_8);
    level.br_plunder._id_12784 = level.br_plunder._id_12784 + var_8;
  }
}

giveteamplunderdistributive(var_0, var_1) {
  var_2 = int(var_1 / var_0.size);

  foreach(var_4 in var_0) {
    if(isbot(var_4) && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker()) {
      continue;
    }
    var_4 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(var_2);
    level.br_plunder._id_12784 = level.br_plunder._id_12784 + var_2;
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::_id_13C44(var_4, "_encstr_B8C808A7C3B63B617830", var_2);
  }
}

dropplunder(var_0, var_1, var_2, var_3) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  var_4 = 0;
  var_5 = 1;
  var_6 = 2;
  var_7[0] = ["_encstr_99201FC49CB1DBDB1D7D0EB1EAB932CAC9BED858B9A17DABE61BF6DADADB9B7DCC", level.br_plunder.quantityepic, getdvarfloat("_encstr_8BB219E6B19CFAC4E47DC5AECACDD1F59356BB164E19BE59E0966C", 0.2)];
  var_7[1] = ["_encstr_AB201FCBA509CA5790C63A05BB7864A2DE67473F4FA371052829F54D5098A65996", level.br_plunder.quantityrare, getdvarfloat("_encstr_A6EF19C74382E126DBF92B53A227E5295ADD475BFA6F9976BF03A1", 0.3)];
  var_7[2] = ["_encstr_A7201F9A1D9825BF3DE613DA8B18AB1FC0DF13E177E0611FE899FAF290E0CB5922", level.br_plunder.quantitycommon, getdvarfloat("_encstr_9AA91BE66C27F58993F5E25DB2E68EFA392BBBB027197D36DEDAB6DECD", 0.5)];
  var_8 = 0;

  for(var_9 = 0; var_9 < var_7.size; var_9++) {
    var_10 = var_7[var_9];
    var_8 = var_8 + var_10[var_6];
  }

  var_11 = 0;

  for(var_9 = 0; var_9 < var_7.size; var_9++) {
    var_10 = var_7[var_9];
    var_10[var_6] = var_10[var_6] / var_8;
    var_11 = var_11 + var_10[var_5] * var_10[var_6];
  }

  var_12 = var_0 / var_11;
  var_13 = var_0;
  var_14 = [];

  for(var_9 = 0; var_9 < var_7.size; var_9++) {
    var_10 = var_7[var_9];
    var_14[var_9] = int(var_12 * var_10[var_6]);
    var_13 = var_13 - var_14[var_9] * var_10[var_5];
  }

  if(var_13 > 0) {
    for(var_9 = 0; var_9 < var_7.size; var_9++) {
      var_10 = var_7[var_9];
      var_15 = int(var_13 / var_10[var_5]);
      var_14[var_9] = var_14[var_9] + var_15;
      var_13 = var_13 - var_15 * var_10[var_5];
    }
  }

  var_16 = [];

  for(var_9 = 0; var_9 < var_14.size; var_9++) {
    for(var_17 = 0; var_17 < var_14[var_9]; var_17++)
      var_16[var_16.size] = var_9;
  }

  var_16 = scripts\engine\utility::array_randomize(var_16);
  var_18 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();

  for(var_9 = 0; var_9 < var_16.size; var_9++) {
    var_19 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_18, var_1, var_2, var_3);
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(var_7[var_16[var_9]][var_4], var_19, var_7[var_16[var_9]][var_5], 1);
  }

  level.br_plunder._id_12784 = level.br_plunder._id_12784 + var_0;
  level thread _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::dropplundersounds(var_1, var_16.size);
}

getquestindex(var_0) {
  return level.questinfo._id_139EC[var_0].index;
}

getquesttableindex(var_0) {
  var_1 = int(tablelookup("_encstr_B468129A5318AD6BD8338F9B6A9F73E01059A86B", 1, var_0, 0));
  return var_1;
}

relic_mythic_modifyplayerdamage() {
  return scripts\engine\utility::ter_op(isDefined(level.br_circle), level.br_circle.circleindex, 0);
}

obj_room_fire_01(var_0) {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.circleindex))
    return 1;

  var_1 = revivingteammate(var_0._id_139EB);

  if(relic_mythic_modifyplayerdamage() < var_1)
    return 0;

  var_2 = reviveweapon(var_0._id_139EB);

  if(relic_mythic_modifyplayerdamage() > var_2)
    return -1;

  return 1;
}

rewards(var_0) {
  var_1 = tablelookup("_encstr_B468129A5318AD6BD8338F9B6A9F73E01059A86B", 11, var_0, 1);
  return var_1;
}

revivingteammate(var_0) {
  if(!isDefined(level.br_circle))
    return 0;

  var_1 = tablelookup("_encstr_B468129A5318AD6BD8338F9B6A9F73E01059A86B", 1, var_0, 18);

  if(!isDefined(var_1) || var_1 == "_encstr_B40101")
    var_1 = 0;

  return int(var_1);
}

reviveweapon(var_0) {
  if(!isDefined(level.br_circle))
    return 65535;

  var_1 = tablelookup("_encstr_B468129A5318AD6BD8338F9B6A9F73E01059A86B", 1, var_0, 19);

  if(!isDefined(var_1) || var_1 == "_encstr_B40101")
    var_1 = level.br_level.default_class_chosen.size + 1;

  return int(var_1);
}

uiobjectiveshow(var_0) {
  var_1 = getquestindex(var_0);
  _id_131AE(var_1);
}

uiobjectiveshowtoteam(var_0, var_1) {
  foreach(var_3 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_1, self.squadindex))
  var_3 uiobjectiveshow(var_0);
}

uiobjectivehide() {
  _id_131AE(0);
}

uiobjectivehidefromteam(var_0) {
  foreach(var_2 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, self.squadindex))
  var_2 uiobjectivehide();
}

uiobjectivesetparameter(var_0) {
  self setclientomnvar("_encstr_BA6016ED237E1B1237F85AD240A74BEFF39D7F604FA35F9D", var_0);
}

_id_13EFD(var_0) {
  self setclientomnvar("_encstr_A27418ABB4D74CC9EBDB263559B11D4BEC597D63DBF63AAF9691", var_0);
}

init_tactical_boxes(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    self.mapcircle = getmaxobjectivecount(var_3[0], var_3[1], var_3[2]);
    self.guard_spawners = var_3;
  } else {
    self.mapcircle = getmaxobjectivecount(0, 0, 0);
    self.guard_spawners = (0, 0, 0);
  }

  if(!isDefined(var_2))
    var_2 = 0;

  self.mapcircle setmapcirclecolorindex(var_0);
  self.mapcircle setmapcircleiconindex(var_1);
  self.mapcircle setmapcirclestyleindex(var_2);
  self.mapcircle hide();
}

_id_11DAE(var_0) {
  self.mapcircle.origin = var_0;
  self.guard_spawners = var_0;
}

_id_13369() {
  self.mapcircle show();
}

spawn_double_cargo() {
  self.mapcircle hide();
}

_id_1336A(var_0) {
  self.mapcircle showtoplayer(var_0);
}

spawn_dogtags(var_0) {
  self.mapcircle hidefromplayer(var_0);
}

lastdirtyscore() {
  self.mapcircle delete();
}

_id_1316F(var_0) {
  self.mapcircle.origin = (self.mapcircle.origin[0], self.mapcircle.origin[1], var_0);
}

init_tape_machine_animations(var_0, var_1, var_2) {
  self.objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(self.objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(self.objectiveiconid, var_1, (0, 0, 0), var_0);
    scripts\mp\objidpoolmanager::update_objective_setbackground(self.objectiveiconid, 1);
    objective_showtoplayersinmask(self.objectiveiconid);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.objectiveiconid, 1);

    if(isDefined(var_2))
      _id_11DB0(var_2);
  } else {}
}

_id_11DB0(var_0) {
  scripts\mp\objidpoolmanager::update_objective_position(self.objectiveiconid, var_0);
}

_id_1336C(var_0) {
  objective_addclienttomask(self.objectiveiconid, var_0);
}

_id_1336B(var_0) {
  objective_addalltomask(var_0);
}

spawn_downed_friendly(var_0) {
  objective_removeclientfrommask(self.objectiveiconid, var_0);
}

gethelispawns() {
  return isDefined(self.objectiveiconid);
}

lastdropedtime() {
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
}

_id_140B1(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 0);
  var_4 = scripts\engine\trace::ray_trace(var_0 + (0, 0, 4000), var_0, undefined, var_3, undefined, 1)["_encstr_BD260953AA97E3F014279D"];
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);

  if(!isDefined(var_5)) {
    return;
  }
  var_5.angles = vectortoangles((0, 0, 1));
  var_5 setModel("_encstr_A33D0FD53A33B35307CB2848F355CEDD2B");
  wait 0.5;
  var_5 setscriptablepartstate("_encstr_9769076901B7A8AF74", "_encstr_99AD06D3A5B1538B", 0);
  var_6 = "_encstr_99AD06D3A5B1538B";

  if(var_1 == "_encstr_9695073995D94BD959")
    var_6 = "_encstr_A9D80DDA3DCB2B64FE88B7F378F32D";

  var_5 setscriptablepartstate("_encstr_AF6007232BD7B33710", var_6, 0);
  var_5 thread apc_rus_driverturretreload(var_1, var_2);
}

apc_rus_driverturretreload(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = 3.125;
  self moveTo(self.origin + (0, 0, 2500), var_2);
  wait(var_2);
  apc_rus_adjustdriverturretammo(var_0, var_1);
}

apc_rus_adjustdriverturretammo(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = "_encstr_AA3A0C14C35837A70410A21AD940";

  self setscriptablepartstate("_encstr_AF6007232BD7B33710", "_encstr_BA19049F4B2D", 0);

  if(!apc_rus_damagecancriticalhit(var_0)) {
    return;
  }
  var_2 = "_encstr_B86D07D74476B81D5F" + var_0;
  self setscriptablepartstate("_encstr_860808CB78E2984063BA", var_2, 0);
  thread _id_1328F(var_1);
}

apc_rus_damagecancriticalhit(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    switch (var_0) {
      case "_encstr_8E240C19DBDE6BE63A16474BBDB9":
      case "_encstr_9695073995D94BD959":
      case "_encstr_8218041DF5FA":
        var_1 = 1;
        break;
      case "_encstr_999A07C61338F9A23A":
        var_1 = 1;
        break;
      case "_encstr_8A12060D5BA9C745":
        var_1 = 1;
        break;
    }
  }

  return var_1;
}

_id_1328F(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 12;

  if(isDefined(var_0) && var_0 > 1)
    var_1 = var_0;

  self setscriptablepartstate("_encstr_976D0B830DBD9B3834BD4EAEDC", "_encstr_99AD06D3A5B1538B", 0);
  wait 0.3;
  self setscriptablepartstate("_encstr_959D10B3A1D85B1820B0CA132BC15CD2A0E9", "_encstr_99AD06D3A5B1538B", 0);
  wait(var_1);
  self setscriptablepartstate("_encstr_976D0B830DBD9B3834BD4EAEDC", "_encstr_961804BD954A", 0);
  wait 0.3;
  self setscriptablepartstate("_encstr_959D10B3A1D85B1820B0CA132BC15CD2A0E9", "_encstr_BA19049F4B2D", 0);
  wait 5;
  self delete();
}

_id_12971(var_0) {
  var_1 = 0;

  if(var_0.spawnflags & 4)
    var_1 = 256;
  else if(var_0.spawnflags & 2)
    var_1 = 128;
  else if(var_0.spawnflags & 1)
    var_1 = 168;
  else if(var_0.spawnflags & 16)
    var_1 = 256;

  return var_1;
}

_id_1297C(var_0, var_1) {
  var_2 = getquestdata(var_0);
  var_2._id_1408F = getdvarint("_encstr_85AA08C091CA67165B67" + var_0 + "_encstr_97B911DF8868C98A6905EA9B7D3FA3A4D0608F", var_1);
}

_id_1297D(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = var_0 + var_1;
  var_3 = getquestdata(self.category);

  if(!var_3._id_1408F) {
    return;
  }
  self._id_11C51 = gettime() + var_2 * 1000;
  _id_1297E();
}

_id_1297B(var_0) {
  var_1 = getquestdata(self.category);

  if(!var_1._id_1408F) {
    return;
  }
  self._id_11C51 = self._id_11C51 + var_0 * 1000;
  _id_1297E();
}

_encstr_B2D2134BF3EDAF7BC8A315E56D08C3238D8BC2D27B(var_0) {
  var_1 = getquestdata(self.category);

  if(!var_1._id_1408F) {
    return;
  }
  if(self._id_11C51 - gettime() - var_0 * 1000 <= 0)
    self._id_11C51 = gettime() + 1000;
  else
    self._id_11C51 = self._id_11C51 - var_0 * 1000;

  _id_1297E();
}

_id_1297E() {
  var_0 = undefined;

  if(istrue(level.questinfo._id_132E8) && isDefined(self.team))
    var_0 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.team, self.squadindex);
  else
    var_0 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.id, self.squadindex);

  foreach(var_2 in var_0)
  var_2 setclientomnvar("_encstr_862920A36CEFDA0BC97058384509BB4BEC4F999FC8238EC34252E32888B33BBF85F5", self._id_11C51);

  var_4 = getquestdata(self.category);
  var_5 = var_4.funcs["_encstr_861D0E7BB92AA5B6CAE4AAE032C2A395"];

  if(isDefined(var_5))
    [[var_5]]();

  thread ally_damage_thread();
}

ally_damage_thread() {
  self notify("_encstr_8AEE115783C816D12BA8EAB26E1DA2D2B69527");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8AEE115783C816D12BA8EAB26E1DA2D2B69527");
  self endon("_encstr_A3930BFFC7652B2418ADDC2161");
  var_0 = (self._id_11C51 - gettime()) / 1000;
  wait(var_0);
  var_1 = getquestdata(self.category);
  var_2 = var_1.funcs["_encstr_B1FE0FF88D4C50A972E3BBC983DA6E4814"];

  if(isDefined(var_2))
    [[var_2]]();

  self.result = "_encstr_995408F398012F656821";
  thread removequestinstance();
}

_id_12B15(var_0) {
  if(!isDefined(self.house_enter_animate_and_kill_player))
    self.house_enter_animate_and_kill_player = [];

  if(!scripts\engine\utility::array_contains(self.house_enter_animate_and_kill_player, var_0))
    self.house_enter_animate_and_kill_player[self.house_enter_animate_and_kill_player.size] = var_0;
}

search_speed(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4))
    var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, self.squadindex);

  foreach(var_7 in var_4) {
    if(!isDefined(var_7)) {
      continue;
    }
    if(!isDefined(var_7._id_11C4F))
      var_7._id_11C4F = 1;
    else
      var_7._id_11C4F++;

    var_7 _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::_id_121B6();

    if(getdvarint("_encstr_8F220B17E59FF1E9D15C692997", 0) && var_7 scripts\mp\utility\game::onlinestatsenabled())
      var_7 setplayerdata("_encstr_8C07031599", "_encstr_86831BD3EB35F7D23853D3DC0FA01D67E760AA4BB180E30CF069F7C23B", 0, 1);
  }

  return search_nodes(self.questcategory, self._id_12D2D, self.modifier, var_0, var_1, var_2, var_3, var_4, var_5);
}

search_nodes(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = rewardtotype(var_0, var_1, var_2);
  return search_activate_battle_station(var_9, var_3, var_4, var_5, var_6, var_7, var_8);
}

search_activate_battle_station(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [];
  level.intel_active = 0;
  level.playerlocationselectinterrupt = 0;
  var_8 = rider_models(var_0);

  foreach(var_14, var_10 in var_8) {
    [var_12, var_13] = search_maneuver_think(var_14, var_10, var_1, var_2, var_3, var_4, var_5, var_6);

    if(isDefined(var_7[var_12])) {
      if(isstring(var_7[var_12]))
        var_7[var_12] = var_7[var_12] + "_encstr_964C0249" + var_13;
      else
        var_7[var_12] = var_7[var_12] + var_13;

      continue;
    }

    var_7[var_12] = var_13;
  }

  level.intel_active = undefined;
  level.playerlocationselectinterrupt = undefined;
  return var_7;
}

search_maneuver_think(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = ringing(var_2);
  var_9 = right_side_spawn_adjuster(var_0);
  var_10 = ring(var_0);

  if(!isstring(var_10)) {
    var_11 = rings(var_1, var_8);

    if(var_11 != 1.0) {
      var_10 = var_10 * var_11;
      var_10 = get_vehicle_getin_anim(var_9, var_10);
    }
  }

  var_10 = search_acceleration(var_9, var_10, var_2, var_3, var_4, var_5, var_6, var_7);
  return [var_9, var_10];
}

search_acceleration(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = self.squadindex;

  if(isDefined(var_7))
    var_8 = var_7;

  switch (var_0) {
    case "_encstr_83A20883C6EA378C2B93":
      if(istrue(level.br_plunder_enabled)) {
        var_9 = isDefined(var_5) && istrue(var_5._id_121E3);

        if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_BE180419DAE9" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_8AE1099A0B999F2D28AF15" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_9B1F05BE4B9B52" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_866209ECEDB1197DEE0B4E" && !var_9)
          giveteamplunderflat(var_2, var_1, var_8);
        else if(var_6.size > 0)
          giveteamplunderdistributive(var_6, var_1);
        else
          var_1 = 0;
      } else
        var_1 = 0;

      break;
    case "_encstr_B607032B8B":
      if(isDefined(var_5) && istrue(var_5._id_121E5))
        var_10 = var_6;
      else
        var_10 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_2, var_8);

      foreach(var_12 in var_10) {
        var_12 thread scripts\mp\events::killeventtextpopup("_encstr_AD9913894E7DD64B9BCD5ADBCD867BAD83C6593A59", 0);
        var_12 scripts\mp\rank::giverankxp("_encstr_AD9913894E7DD64B9BCD5ADBCD867BAD83C6593A59", var_1);
        var_12.defaultclassindex = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::get_int_or_0(var_12.defaultclassindex) + var_1;
      }

      break;
    case "_encstr_BEDE0A8359473B2570B76868":
      if(isDefined(var_5) && istrue(var_5._id_121E4))
        var_10 = var_6;
      else
        var_10 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_2, var_8);

      foreach(var_12 in var_10) {
        var_15 = var_12.lastnormalweaponobj;
        var_12 _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::scriptableusestate("_encstr_B40101", var_1, var_15, 0, 0);
      }

      break;
    case "_encstr_ABA50B1BF67BE8BE3A0BC4C656":
      if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_BE180419DAE9" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_8AE1099A0B999F2D28AF15" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_9B1F05BE4B9B52" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_866209ECEDB1197DEE0B4E") {
        var_17 = pickscriptablelootitem(var_5, var_1);
        _id_12973(var_2, var_17, var_3, var_4, istrue(level.playerlocationselectinterrupt), var_8);
      }

      break;
    case "_encstr_96110B21404808677FF8974B62":
      var_17 = pickscriptablelootitem(var_5, var_1);
      _id_12973(var_2, var_17, var_3, var_4, 1, var_8);
      level.playerlocationselectinterrupt = 1;
      break;
    case "_encstr_84170BFC4FE88BE72B2BFA62D3":
      var_17 = strtok(var_1, "_encstr_974C0246");
      _id_12973(var_2, var_17, var_3, var_4, istrue(level.playerlocationselectinterrupt), var_8);
      break;
    case "_encstr_8D1C108DBDBD1DAFB4D1CA6BE6D78C397B0E":
      var_17 = strtok(var_1, "_encstr_974C0246");
      var_18 = undefined;

      if(isDefined(var_5))
        var_18 = var_5.stadium_three_death_func;

      _id_12973(var_2, var_17, var_3, var_4, 1, var_8, 0, var_18);
      break;
    case "_encstr_BE15092393EDE0AF1316CE":
      var_19 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_2, var_8)[0];
      fronttruck(var_19, var_3);
      break;
    case "_encstr_8B820C8D96391B1B59FAC1ACB2B6":
      _id_12972(var_2, var_8);
      break;
    case "_encstr_ADBB0C28CD2841F2479783B8F2D3":
      thread battletracksmusicstatestandingonvehicle(var_2, var_1, var_8);
      break;
    case "_encstr_8803119680A06D03C62B4B3B5F664AA1C0C9CF":
      var_20 = getdvarint("_encstr_888E17E6D8E47D13937D85C63A7DDADB91B27D3113B1D2A34F", 0) == 0;
      var_21 = _encstr_8F4D2A4057AAF8318B1A2801B25657A1EDE7C09883557357D242681D883B85694BDB11407FED0BA9FE2F7616::usb_keys();

      if(var_20 && var_21) {
        var_22 = _encstr_95383423288639018B079E98F2E8A8D910C93389D36A2397E9ADBF3D201532EB1343165DFF4BD0C93B8A4353F6D89389E865EA9F8363::convoy4_actively_hacking(var_3, var_5.type);

        if(isDefined(var_22)) {
          _encstr_95383423288639018B079E98F2E8A8D910C93389D36A2397E9ADBF3D201532EB1343165DFF4BD0C93B8A4353F6D89389E865EA9F8363::control_station_interact(var_2, self.tablet);
          var_17 = [var_22];
          _id_12973(var_2, var_17, var_3, var_4, istrue(level.playerlocationselectinterrupt));
          displayteamsplash(var_2, "_encstr_B23B23422BC8E375D8B3F0FA43E8BBCF0DC29BCBD1BEF3E1C08B1DE34139023BA7DBB22219", undefined, var_8);
        }
      }

      break;
    case "_encstr_851904B59B34":
      var_23 = relic_count(var_2, var_6, var_3, var_8);

      if(isDefined(var_23))
        var_23 thread _id_12977(var_1);

      break;
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      var_24 = spawnStruct();
      var_24.origin = var_3;
      var_24.modify_blast_shield_damage = 300;
      var_24._id_11EAB = 1;
      level thread _encstr_AB9028F6A91A7BB7236095EDABB080C8900FED03A169B3BE2233379AFBD114EFC608405D7BE54D49236E::mlgiconfullflag(var_24, "_encstr_A9BC0D13ABB5C713E9FD455FF3A85F");
      break;
    case "_encstr_85CE0B9770B02C73A1760F06D2":
      var_25 = relic_count(var_2, var_6, var_3, var_8);

      if(isDefined(var_25))
        var_25 thread _id_12975(var_1);

      break;
    case "_encstr_8A140619DDC9AF43":
      var_12 = relic_count(var_2, var_6, var_3, var_8);

      if(isDefined(var_12))
        var_12 thread _id_12976(var_1);

      break;
    case "_encstr_8BBA05185F8B99":
      break;
    default:
      break;
  }

  return var_1;
}

relic_count(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && var_1.size > 0)
    var_4 = var_1;
  else
    var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, var_3);

  var_5 = undefined;
  var_6 = undefined;

  foreach(var_8 in var_4) {
    if(!isDefined(var_8)) {
      continue;
    }
    var_9 = distance2d(var_8.origin, var_2);

    if(!isDefined(var_6) || var_9 < var_6) {
      var_6 = var_9;
      var_5 = var_8;
    }
  }

  return var_5;
}

_id_13234() {
  if(istrue(level.br_circle_disabled)) {
    return;
  }
  level.gulag_tutorial_vo = [];
  level._id_13ACA = [];

  for(var_0 = 1; var_0 < level.br_level.br_circleradii.size; var_0++) {
    var_1 = level.br_level.br_circleradii[var_0];
    var_2 = level.br_level.default_class_chosen[var_0];
    level.gulag_tutorial_vo[var_0] = getmaxobjectivecount(var_2[0], var_2[1], var_1);
    level.gulag_tutorial_vo[var_0] setmapcirclecolorindex(4);
    level.gulag_tutorial_vo[var_0] setmapcirclestyleindex(1);
    level.gulag_tutorial_vo[var_0] hide();
  }

  level thread gulag_think();
}

gulag_think() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8F8F12E70303AAD5CD813BC52A860CFD427A3BC3");

  for(;;) {
    level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB");
    level.gulag_tutorial_vo[level.br_circle.circleindex + 1] delete();

    foreach(var_1 in getarraykeys(level._id_13ACA)) {
      level._id_13ACA[var_1]--;

      if(level._id_13ACA[var_1] < 0)
        level._id_13ACA[var_1] = 0;
    }
  }
}

_id_12972(var_0, var_1) {
  if(istrue(level.br_circle_disabled)) {
    return;
  }
  if(!isDefined(level._id_13ACA[var_0]))
    level._id_13ACA[var_0] = 0;

  level._id_13ACA[var_0]++;
  var_2 = level._id_13ACA[var_0] + level.br_circle.circleindex + 1;

  if(!isDefined(level.gulag_tutorial_vo[var_2])) {
    foreach(var_4 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, var_1))
    var_4 scripts\mp\utility\lower_message::_id_1316E("_encstr_964912D7306E7939D10E4A356B6D9829AFED91ED", undefined, 5);

    return;
  }

  foreach(var_4 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, var_1))
  level.gulag_tutorial_vo[var_2] showtoplayer(var_4);
}

riotshield_checkshield(var_0) {
  var_1 = level.questinfo._id_12D2F.get_vehicle_idle_anim[var_0];

  if(!isDefined(var_1)) {
    var_1 = tablelookup("_encstr_B468129A5318AD6BD8338F9B6A9F73E01059A86B", 1, var_0, 7);
    level.questinfo._id_12D2F.get_vehicle_idle_anim[var_0] = var_1;
  }

  return var_1;
}

rider_models(var_0) {
  var_1 = right_control();
  var_2 = level.questinfo._id_12D2F.set_look_at_ent[var_0];

  if(!isDefined(var_2)) {
    var_2 = [];
    var_3 = 2;
    var_4 = 3;

    for(;;) {
      var_5 = tablelookup(var_1, 0, var_0, var_3);

      if(var_5 == "_encstr_B40101") {
        break;
      }

      var_6 = tablelookup(var_1, 0, var_0, var_4);
      var_2[var_5] = var_6;
      var_3 = var_3 + 2;
      var_4 = var_4 + 2;
    }

    if(isDefined(level.elevator_lights_toggle))
      var_2 = [[level.elevator_lights_toggle]](var_2);

    level.questinfo._id_12D2F.set_look_at_ent[var_0] = var_2;
  }

  return var_2;
}

right_side_spawn_adjuster(var_0) {
  var_1 = "_encstr_8B8A19E5CA606A1283D06AA0B1ADA837AE93235198699386D7674B";
  var_2 = scripts\mp\utility\game::round_vehicle_logic();

  if(var_2 == "_encstr_BE180419DAE9" || var_2 == "_encstr_8AE1099A0B999F2D28AF15" || var_2 == "_encstr_9B1F05BE4B9B52" || var_2 == "_encstr_866209ECEDB1197DEE0B4E")
    var_1 = "_encstr_B67A1D5B0EF289275BB4DC9B4BB7DCBE4EACEE2C3923DCF58CD6A7C56CB9CE";
  else if(level._id_14060 == 1)
    var_1 = "_encstr_848816AFF98032626028222AC098B639867B7F17655D6B17" + var_2 + "_encstr_96A70506895E33";

  var_3 = level.questinfo._id_12D2F._id_12D31[var_0];

  if(!isDefined(var_3)) {
    var_3 = tablelookup(var_1, 0, var_0, 1);
    level.questinfo._id_12D2F._id_12D31[var_0] = var_3;
  }

  return var_3;
}

ring(var_0) {
  var_1 = "_encstr_8B8A19E5CA606A1283D06AA0B1ADA837AE93235198699386D7674B";
  var_2 = scripts\mp\utility\game::round_vehicle_logic();

  if(var_2 == "_encstr_BE180419DAE9" || var_2 == "_encstr_8AE1099A0B999F2D28AF15" || var_2 == "_encstr_9B1F05BE4B9B52")
    var_1 = "_encstr_B67A1D5B0EF289275BB4DC9B4BB7DCBE4EACEE2C3923DCF58CD6A7C56CB9CE";

  if(var_2 == "_encstr_866209ECEDB1197DEE0B4E")
    var_1 = "_encstr_A68722528B100312F84BD3DB63C05DAFE6418B1A531D8F81505FF4D47758A6D3203943F3";
  else if(level._id_14060 == 1)
    var_1 = "_encstr_848816AFF98032626028222AC098B639867B7F17655D6B17" + var_2 + "_encstr_96A70506895E33";

  var_3 = level.questinfo._id_12D2F._id_12D32[var_0];

  if(!isDefined(var_3)) {
    var_4 = rewardscriptable(var_0);

    if(isDefined(var_4))
      var_3 = var_4;
    else {
      var_5 = ringcodephoneconstantly();
      var_3 = tablelookup(var_1, 0, var_0, var_5);
    }

    var_6 = right_side_spawn_adjuster(var_0);
    var_3 = get_vehicle_getin_anim(var_6, var_3);
    level.questinfo._id_12D2F._id_12D32[var_0] = var_3;
  }

  if(istrue(level.convoy_handle_stuck_compromise) && !isstring(var_3))
    var_3 = int(var_3 * level._id_12192);

  return var_3;
}

ringcodephoneconstantly() {
  var_0 = level.maxteamsize;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker())
    var_0 = 1;

  switch (var_0) {
    case 4:
      return 10;
    case 3:
      return 9;
    case 2:
      return 8;
    case 1:
      return 7;
    default:
      return 9;
  }
}

rewardscriptable(var_0) {
  var_1 = getdvarint("_encstr_818D11B98D4E7D17AE5937A32956EE2CE432EB" + var_0, -1);

  if(var_1 > -1)
    return var_1;

  return undefined;
}

rifle_lights(var_0) {
  var_1 = level.questinfo._id_12D2F._id_12EC4[var_0];

  if(!isDefined(var_1)) {
    var_1 = [];
    var_2 = 1;
    var_3 = 2;

    for(;;) {
      var_4 = tablelookup("_encstr_B67E207AA3383B2AD013BBA30B9875873EB953220B6517A2886BACBD1590ADCFE6B3", 0, var_0, var_2);

      if(var_4 == "_encstr_B40101") {
        break;
      }

      var_4 = int(var_4);
      var_5 = float(tablelookup("_encstr_B67E207AA3383B2AD013BBA30B9875873EB953220B6517A2886BACBD1590ADCFE6B3", 0, var_0, var_3));
      var_1[var_4] = var_5;
      var_2 = var_2 + 2;
      var_3 = var_3 + 2;
    }

    level.questinfo._id_12D2F._id_12EC4[var_0] = var_1;
  }

  return var_1;
}

rewardorigin(var_0) {
  return rewardmodifier(self.questcategory, var_0, self.modifier, self._id_12D2D);
}

riotshieldmodeltag(var_0) {
  return riotshieldiscurrentprimary(self.questcategory, var_0, self.modifier, self._id_12D2D);
}

riotshieldclearvars(var_0) {
  return riotshield_return(self.questcategory, var_0, self.modifier, self._id_12D2D);
}

rewardmodifier(var_0, var_1, var_2, var_3) {
  if(!level.br_plunder_enabled)
    return 0;

  return ringphoneoccasionally(var_0, var_1, "_encstr_83A20883C6EA378C2B93", var_2, var_3);
}

riotshieldiscurrentprimary(var_0, var_1, var_2, var_3) {
  return ringphoneoccasionally(var_0, var_1, "_encstr_B607032B8B", var_2, var_3);
}

riotshield_return(var_0, var_1, var_2, var_3) {
  return ringphoneoccasionally(var_0, var_1, "_encstr_BEDE0A8359473B2570B76868", var_2, var_3);
}

ringphoneoccasionally(var_0, var_1, var_2, var_3, var_4) {
  var_5 = rewardtotype(var_0, var_4, var_3);
  var_6 = rider_models(var_5);
  var_7 = 0;

  foreach(var_13, var_9 in var_6) {
    var_10 = right_side_spawn_adjuster(var_13);

    if(var_10 == var_2) {
      var_11 = ring(var_13);
      var_12 = rings(var_9, var_1);
      var_7 = var_7 + var_11 * var_12;
    }
  }

  var_7 = get_vehicle_getin_anim(var_2, var_7);
  return var_7;
}

rings(var_0, var_1) {
  var_2 = 1.0;
  var_3 = rifle_lights(var_0);
  var_4 = 0.0;

  for(var_5 = 1; var_5 <= var_1; var_5++) {
    if(isDefined(var_3[var_5]))
      var_4 = var_3[var_5];

    var_2 = var_2 + var_4;
  }

  if(level.maxteamsize > 4)
    var_2 = 1.0 + (var_2 - 1.0) * (4 / level.maxteamsize);

  return var_2;
}

rewardangles(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = 0;

  foreach(var_4 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, self.squadindex)) {
    if(istrue(var_4.should_drop_scavenger_bag))
      var_2++;
  }

  if(!var_1 && isDefined(level.questinfo._id_11B69) && isDefined(level.questinfo._id_11B69[var_0]))
    var_2 = int(min(var_2, level.questinfo._id_11B69[var_0]));

  return var_2;
}

_id_12973(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_1)) {
    return;
  }
  var_8 = spawnStruct();
  var_8.origin = var_2;
  var_8.angles = var_3;
  var_8.itemsdropped = 0;

  if(isDefined(level.intel_active))
    var_8.itemsdropped = level.intel_active;

  var_9 = var_8 _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A42(var_1, var_4, var_6, var_7, 1);

  foreach(var_11 in var_9) {
    var_11.team = var_0;
    var_11.squadindex = var_5;
  }

  if(isDefined(level.intel_active))
    level.intel_active = var_8.itemsdropped;
}

_id_12977(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_0, self);
  var_1._id_133CE = 1;
  var_1._id_133CC = 1;
  scripts\cp_mp\killstreaks\uav::tryuseuavfromstruct(var_1);
}

_id_12975(var_0) {
  var_1 = isDefined(self.streakdata.streaks[1]);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::playerpackdataintogulagomnvar(var_0, var_1, 0);
  thread scripts\mp\hud_message::showsplash("_encstr_9618183E92F9DF286C4B68482BBDE11741BA2DBEAEE293534D83");
}

_id_12976(var_0) {
  var_1 = _id_135DF(var_0, self.origin, 1);
  _id_13A38(var_1);
}

_id_135DF(var_0, var_1, var_2) {
  var_3 = easepower(removepatchablecollision_delayed(var_0), var_1);
  var_3 tabletinit(var_0);
  var_3.keepinmap = 1;
  var_3 thread handleprop();

  if(istrue(var_2))
    var_3 setscriptablepartstate(var_3.type, "_encstr_95DF070DD22319CA9B");

  return var_3;
}

handleprop() {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_A3930BFFC7652B2418ADDC2161");
  self freescriptable();
}

rewardtotype(var_0, var_1, var_2) {
  var_3 = riotshield_checkshield(var_0);
  var_4 = var_3;

  if(isDefined(var_2))
    var_4 = var_4 + var_2;

  if(isDefined(var_1))
    var_4 = var_4 + var_1;

  if(_id_12974(var_4))
    return var_4;

  var_4 = var_3;

  if(isDefined(var_1))
    var_4 = var_4 + var_1;

  if(_id_12974(var_4))
    return var_4;

  return var_3;
}

_id_12974(var_0) {
  var_1 = right_control();
  var_2 = tablelookup(var_1, 0, var_0, 0);
  return var_2 != "_encstr_B40101";
}

rocket_death_fx(var_0) {
  switch (var_0) {
    case "_encstr_8803119680A06D03C62B4B3B5F664AA1C0C9CF":
    case "_encstr_BE15092393EDE0AF1316CE":
    case "_encstr_ABA50B1BF67BE8BE3A0BC4C656":
    case "_encstr_ADBB0C28CD2841F2479783B8F2D3":
    case "_encstr_96110B21404808677FF8974B62":
    case "_encstr_8B820C8D96391B1B59FAC1ACB2B6":
    case "_encstr_BEDE0A8359473B2570B76868":
    case "_encstr_83A20883C6EA378C2B93":
    case "_encstr_B607032B8B":
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
    case "_encstr_8BBA05185F8B99":
      return "_encstr_921904C3DEF8";
    case "_encstr_8D1C108DBDBD1DAFB4D1CA6BE6D78C397B0E":
    case "_encstr_84170BFC4FE88BE72B2BFA62D3":
    case "_encstr_8A140619DDC9AF43":
    case "_encstr_851904B59B34":
    case "_encstr_85CE0B9770B02C73A1760F06D2":
      return "_encstr_A1D80717112333A5D4";
    default:
      break;
  }
}

get_vehicle_getin_anim(var_0, var_1) {
  var_2 = rocket_death_fx(var_0);

  switch (var_2) {
    case "_encstr_921904C3DEF8":
      var_1 = int(var_1);
      break;
    case "_encstr_8AA9066663F62C3A":
      var_1 = float(var_1);
      break;
    case "_encstr_A1D80717112333A5D4":
      var_1 = "_encstr_B40101" + var_1;
      break;
    default:
      break;
  }

  return var_1;
}

right_control() {
  var_0 = getDvar("_encstr_BE42223276A6FF1CA7A0A2DA50A792971B57AAAC18495BA583D00BD13823CD2F50CF0D25", "_encstr_AC511F0AD3486B7A80238B73DB6885570EE923723BB5E77750078578C74A8EBFB4");

  if(var_0 == "_encstr_B40101")
    var_0 = "_encstr_AC511F0AD3486B7A80238B73DB6885570EE923723BB5E77750078578C74A8EBFB4";

  return var_0;
}

rewardtovalue(var_0) {
  var_1 = right_control();
  return int(tablelookup(var_1, 0, var_0, 1));
}

ringing(var_0) {
  var_1 = level.questinfo._id_13B62[var_0];

  if(!isDefined(var_1))
    var_1 = 1;

  return var_1;
}

_id_131B0(var_0, var_1, var_2) {
  level.questinfo._id_13B62[var_0] = var_1;
  _id_131B2(var_0, var_1, var_2);
}

battletracksmusicstate(var_0, var_1, var_2) {
  _id_131B0(var_0, ringing(var_0) + var_1, var_2);
}

battletracksmusicstatestandingonvehicle(var_0, var_1, var_2, var_3) {
  waittillframeend;
  _id_131B0(var_0, ringing(var_0) + var_1, var_2);
}

_id_131AF(var_0, var_1) {
  foreach(var_3 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, self.squadindex))
  var_3 _id_131AE(var_1);
}

_id_131AE(var_0) {
  self setclientomnvar("_encstr_A7AE16D39FC90ED0179519103F13D833F3370F136BA245C8", var_0);
}

_id_131B2(var_0, var_1, var_2) {
  foreach(var_4 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, var_2))
  var_4 _id_131B1(var_1);
}

_id_131B1(var_0) {
  self setclientomnvar("_encstr_A73B1CAE5AFA314EFABD4C53561BE8B4ECB27D9CCABB85398C7D1DB4B2E4", var_0);
}

generate_solution() {
  foreach(var_5, var_1 in level.questinfo.quests) {
    foreach(var_3 in var_1.instances) {
      var_3.result = "_encstr_A2AA076C1637C6AC1B";
      var_3 removequestinstance();
    }
  }
}

register_vehicle_spawners(var_0) {
  var_1 = [];

  foreach(var_8, var_3 in level.questinfo.quests) {
    foreach(var_7, var_5 in var_3.instances) {
      if(var_7 != var_0) {
        continue;
      }
      if(upper_door_coll(var_5)) {
        continue;
      }
      var_6 = spawnStruct();
      var_6.tracknonoobplayerlocation = var_5;

      switch (var_5.category) {
        case "_encstr_92A40EF9E31F7F501AA96573DCC4E8B0":
          if(isDefined(var_5.targetplayer))
            var_6.origin = var_5.targetplayer.origin;

          break;
        case "_encstr_A1580B19DE5B5A9B0BA35AEDCD":
          if(isDefined(var_5._id_1393B) && isDefined(var_5._id_1393B.domflag) && isDefined(var_5._id_1393B.domflag.curorigin))
            var_6.origin = var_5._id_1393B.domflag.curorigin + (0, 0, 60);

          break;
        case "_encstr_A11904D82B38":
        case "_encstr_AF460A7B2649F34FE367455D":
          if(isDefined(var_5._id_1393B.force_spawn_all_dead_players.origin) && isDefined(var_5._id_1393B.force_spawn_all_dead_players))
            var_6.origin = var_5._id_1393B.force_spawn_all_dead_players.origin + (0, 0, 50);

          break;
        case "_encstr_BD6E090B60F9C74FC88B06":
          break;
        case "_encstr_8AAE0C582A639D29EB0FE6E80CE7":
        case "_encstr_95B60C179A73E83FD62A41CE4698":
        case "_encstr_BD200CCDACC627CAA3DC1D2CCD86":
          if(isDefined(var_5.force_spawn_all_dead_players) && isDefined(var_5.force_spawn_all_dead_players.origin))
            var_6.origin = var_5.force_spawn_all_dead_players.origin + (0, 0, 50);

          break;
        case "_encstr_87930BB17BD8B195C6A32DEDDC":
        case "_encstr_97580E238AD72960B651E3379C0EE7F9":
        case "_encstr_A19B096816E6C71BC36072":
        case "_encstr_AADD079327E9CA81D2":
        case "_encstr_8D600AE8F5694A3F2C68BA72":
        case "_encstr_B82D088332497B18D26E":
        case "_encstr_A93908FBBAC970BACA02":
        case "_encstr_B4AB0698A3B0E99A":
        case "_encstr_8745086CF27708C893BF":
        case "_encstr_B47808F8E26FEBB7D25B":
        case "_encstr_A6B10B0EF0CF8423188FFF5B36":
        case "_encstr_9A3F1133610DE2C03888058B21400C4BEF9793":
        case "_encstr_951904D8F1E0":
          break;
        case "_encstr_B601090EE6BB5FB8DF17A3":
          if(isDefined(var_5._id_1393B) && isDefined(var_5._id_1393B.get_closest_living_player_not_in_laststand) && isDefined(var_5._id_1393B.get_closest_living_player_not_in_laststand.curorigin))
            var_6.origin = var_5._id_1393B.get_closest_living_player_not_in_laststand.curorigin + (0, 0, 60);

          break;
        default:
          break;
      }

      var_1[var_1.size] = var_6;
    }
  }

  return var_1;
}

riotshield_init_cp(var_0) {
  var_1 = level.questinfo._id_13F19[scripts\engine\utility::string(var_0)];

  if(!isDefined(var_1))
    return 0;

  return var_1._id_13F18;
}

risk_flagspawndebugobjicons(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = 0;

  foreach(var_3 in level.questinfo._id_13F19)
  var_1 = var_1 + var_3._id_13F17[var_0];

  var_5 = randomfloatrange(0, var_1);
  var_6 = 0;

  foreach(var_3 in level.questinfo._id_13F19) {
    var_8 = var_3._id_13F17[var_0];

    if(var_8 <= 0) {
      continue;
    }
    var_6 = var_6 + var_8;

    if(var_5 <= var_6)
      return var_3._id_11A23;
  }

  return level.questinfo._id_13F19[0]._id_11A23;
}

_id_12C08() {
  if(level.mapname == "_encstr_8CD508CA98A70FAFC01D") {
    var_0 = (-31160, 57824, 4536);
    var_1 = 1000;
    var_2 = getlootspawnpoint(var_0, var_1, 0, 1);

    foreach(var_4 in var_2)
    getlootspawnpointcount(var_4.index);
  }
}