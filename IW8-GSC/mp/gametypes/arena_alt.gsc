/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\arena_alt.gsc
***********************************************/

main() {
  setDvar("_encstr_85F6186F966321C7B788A810A5332B2B8053CC380BD9E150DDC5", 10);
  level.bots_gametype_handles_class_choice = 1;

  if(!isDefined(game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"])) {
    game["_encstr_AC581242886BE5F778CE681560201F6CF5685ADB"] = 0;
    game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] = 0;
    game["_encstr_925A1733A0FBB31B09A57673339553BB059099FBF843A2F7C3"] = 0;
    game["_encstr_BAFF17DDB09B12DB9BA3A0634B6756821D25B75D9B19A83732"] = 1;
    game["_encstr_A7A918DA16E8D886D48EB0C98E2959E2574B9CB2E652B90EEAD1"] = 1;
  } else if(game["_encstr_AC581242886BE5F778CE681560201F6CF5685ADB"] == 1) {
    game["_encstr_AC581242886BE5F778CE681560201F6CF5685ADB"] = 0;
    game["_encstr_925A1733A0FBB31B09A57673339553BB059099FBF843A2F7C3"] = game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"];
    game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"]++;
    level.resetstats = 1;
    game["_encstr_A7A918DA16E8D886D48EB0C98E2959E2574B9CB2E652B90EEAD1"] = 1;
  }

  if(game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] > 3)
    game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] = 0;

  scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
  scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 30);
  scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
  scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 19);
  scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 10);
  scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  scripts\mp\utility\game::registerwinbytwoenableddvar(scripts\mp\utility\game::getgametype(), 1);
  scripts\mp\utility\game::registerwinbytwomaxroundsdvar(scripts\mp\utility\game::getgametype(), 4);
  setDvar("_encstr_9B270A70DC9083EA9955848B", 0);

  if(!isDefined(level.tweakablesinitialized))
    scripts\mp\tweakables::init();

  thread launchchunkbotspawning();
  level.setinitialbotdifficulties = 1;

  switch (game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"]) {
    case 0:
      if(!isDefined(game["_encstr_AAB00EE05A17D310432A8FF73A6FB8A8"])) {
        game["_encstr_AAB00EE05A17D310432A8FF73A6FB8A8"] = 1;
        game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_817D099248EF14F3CB0657"] = "_encstr_96310D55C77FF740E1AF1A4B1BD7FB";
      } else if(game["_encstr_AAB00EE05A17D310432A8FF73A6FB8A8"] == 1) {
        game["_encstr_AAB00EE05A17D310432A8FF73A6FB8A8"] = 2;
        game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_817D099248EF14F3CB0657"] = "_encstr_BDCD0E368DBECCCC58F59BB2D87B3723";
      } else
        game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_817D099248EF14F3CB0657"] = "_encstr_93340DBA11D01B1F802FECC87B20A7";

      setomnvar("_encstr_BDDF21D55AFA93DEAEB919F5D04B9BE8FABDCEB2C9E42DC8CAFAB0A3D10BB15BAC39B9", 1);
      setomnvar("_encstr_BD3721E0DA99B5B88F0E55C010274071714270F8C36ADB91A7176DC5F63F0829A73BA0", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_8B250A53848DC8D17A472BE9", 180);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_AAAE09A03BDF5128C33DB7", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_95BD0B27EDABDC468DA5D62D8E", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_97B20977D2B91B2DAD4BD1", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_B6FB0B93B87F020F183BE5E94D", 15);
      waitthensethealthregentweakable(6);
      setDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_92030FE79BAAEB101CB27FD11ADBD09172", 1);
      setDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8316094F78B8E72DB90F9B", 0);
      setDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8F870DFA1BCA3A342C8D88598D165E", 0);
      level.scoreconfirm = 0;
      level.scoredeny = 0;
      break;
    case 1:
      if(!isDefined(game["_encstr_85EF0D14BF81243BBDC3626948982F"])) {
        game["_encstr_85EF0D14BF81243BBDC3626948982F"] = 1;
        game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_817D099248EF14F3CB0657"] = "_encstr_81270F9CD721C65B15BA0A69C4F15E6031";
      } else if(game["_encstr_85EF0D14BF81243BBDC3626948982F"] == 1) {
        game["_encstr_85EF0D14BF81243BBDC3626948982F"] = 2;
        game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_817D099248EF14F3CB0657"] = "_encstr_88DE10A9B676BF43C83E2F898245C74FF03C";
      } else
        game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_817D099248EF14F3CB0657"] = "_encstr_9A740F36D87D58C9B27385F547D0D29C32";

      setomnvar("_encstr_BDDF21D55AFA93DEAEB919F5D04B9BE8FABDCEB2C9E42DC8CAFAB0A3D10BB15BAC39B9", 0);
      setomnvar("_encstr_BD3721E0DA99B5B88F0E55C010274071714270F8C36ADB91A7176DC5F63F0829A73BA0", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_8B250A53848DC8D17A472BE9", 40);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_AAAE09A03BDF5128C33DB7", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_95BD0B27EDABDC468DA5D62D8E", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_97B20977D2B91B2DAD4BD1", 6);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_B6FB0B93B87F020F183BE5E94D", 6);
      waitthensethealthregentweakable(0);
      setDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_92030FE79BAAEB101CB27FD11ADBD09172", 0);
      setDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8316094F78B8E72DB90F9B", 0);
      setDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8F870DFA1BCA3A342C8D88598D165E", 5);
      level.overridetimelimitclock = 10;
      level.setinitialbotdifficulties = 0;
      break;
    case 2:
      if(!isDefined(game["_encstr_8EEF0D19A369F080638B4876D357C8"])) {
        game["_encstr_8EEF0D19A369F080638B4876D357C8"] = 1;
        game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_817D099248EF14F3CB0657"] = "_encstr_8BD70D349FA142DFDE8612EACB364B";
      } else if(game["_encstr_8EEF0D19A369F080638B4876D357C8"] == 1) {
        game["_encstr_8EEF0D19A369F080638B4876D357C8"] = 2;
        game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_817D099248EF14F3CB0657"] = "_encstr_8E2C0ECA10B71ABF9358838D6E3873A7";
      } else
        game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_817D099248EF14F3CB0657"] = "_encstr_883B0D9039B92B107FDF0820FB1B59";

      setomnvar("_encstr_BDDF21D55AFA93DEAEB919F5D04B9BE8FABDCEB2C9E42DC8CAFAB0A3D10BB15BAC39B9", 0);
      setomnvar("_encstr_BD3721E0DA99B5B88F0E55C010274071714270F8C36ADB91A7176DC5F63F0829A73BA0", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_8B250A53848DC8D17A472BE9", 40);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_AAAE09A03BDF5128C33DB7", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_95BD0B27EDABDC468DA5D62D8E", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_97B20977D2B91B2DAD4BD1", 6);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_B6FB0B93B87F020F183BE5E94D", 6);
      waitthensethealthregentweakable(0);
      setDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_92030FE79BAAEB101CB27FD11ADBD09172", 0);
      setDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8316094F78B8E72DB90F9B", 0);
      setDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8F870DFA1BCA3A342C8D88598D165E", 5);
      level.overridetimelimitclock = 10;
      level.setinitialbotdifficulties = 0;
      break;
    case 3:
      if(!isDefined(game["_encstr_87B80F80D64F58205BEBF78FEBC276700D"])) {
        game["_encstr_87B80F80D64F58205BEBF78FEBC276700D"] = 1;
        game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_817D099248EF14F3CB0657"] = "_encstr_81500E7C5F777EE776FB8E6E7343BF38";
      } else if(game["_encstr_87B80F80D64F58205BEBF78FEBC276700D"] == 1) {
        game["_encstr_87B80F80D64F58205BEBF78FEBC276700D"] = 2;
        game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_817D099248EF14F3CB0657"] = "_encstr_A3570F316B7761CF8D7AD9B062E69798F3";
      } else
        game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_817D099248EF14F3CB0657"] = "_encstr_84CF0E5006BFF8500A6B47E9AB822608";

      setomnvar("_encstr_BDDF21D55AFA93DEAEB919F5D04B9BE8FABDCEB2C9E42DC8CAFAB0A3D10BB15BAC39B9", 2);
      setomnvar("_encstr_BD3721E0DA99B5B88F0E55C010274071714270F8C36ADB91A7176DC5F63F0829A73BA0", 2);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_8B250A53848DC8D17A472BE9", 180);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_AAAE09A03BDF5128C33DB7", 0);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_95BD0B27EDABDC468DA5D62D8E", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_97B20977D2B91B2DAD4BD1", 1);
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_B6FB0B93B87F020F183BE5E94D", 20);
      waitthensethealthregentweakable(6);
      setDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_92030FE79BAAEB101CB27FD11ADBD09172", 0);
      setDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8316094F78B8E72DB90F9B", 1);
      setDvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8F870DFA1BCA3A342C8D88598D165E", 0);
      level.scoreconfirm = 1;
      level.scoredeny = 0;
      break;
    default:
      break;
  }

  updategametypedvars();

  if(israndompreviewloadouts()) {
    level.ispreviewbuild = 1;
    level.previewbuildfirstallies = 1;
    level.previewbuildfirstaxis = 1;
  }

  setDvar("_encstr_87750A3D9EA82A699EA24953", 4);
  level.teambased = 1;
  level.objectivebased = 1;
  level.ontimelimit = ::ontimelimit;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerdamaged = ::onplayerdamaged;
  level.onnormaldeath = ::onnormaldeath;
  level.onplayerkilled = ::onplayerkilled;
  level.modeonspawnplayer = ::onspawnplayer;
  level.ondeadevent = ::ondeadevent;
  level.ontimelimitot = ::ontimelimitot;
  level.droplaunchchunkbots = ::droplaunchchunkbots;
  level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;
  level.allowlatecomers = 0;

  if(!scripts\mp\utility\game::iswinbytworulegametype())
    level.skipdefendersadvantage = 1;

  level.disablecopycatloadout = 1;
  setomnvar("_encstr_88D613AE96AFB6D21B8DB12CADAFC6DBC15E1BB0A3", 0);
  level.bypassclasschoicefunc = ::alwaysgamemodeclass;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_A5110F11A66D283D9BD3D39FAF138D3839";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  if(ispickuploadouts() && !isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"])) {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_95F61489EDB79B1DF55893B2CDB0D7072D8DB557389B";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_95F61489EDB79B1DF55893B2CDB0D7072D8DB557389B";
  } else if(level.objmodifier == 1 && !isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"])) {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_A16116852FE5A00D4F3A6BB1F28F50887EB2037FDCCC30DD";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_A16116852FE5A00D4F3A6BB1F28F50887EB2037FDCCC30DD";
  } else {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_92180CD5DF204B214171A29F6592";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_92180CD5DF204B214171A29F6592";
  }

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84F10CD0C8FAC0BAD060AD874371"] = "_encstr_879214317BDECDD1BE0B4EACDC167DD2378C560E3AA1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7270B37CAC6BA4E96CD76BE2C"] = "_encstr_92D90ECA58D9ECAFFFE5F62B1D0FDDFF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9BDC098D7BCD96DC76FA2C"] = "_encstr_81FB0C66D908DF7739F82BB2E084";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7010A03FD5FFFE3521A09C8"] = "_encstr_87EB0D3BC089CF595705669BF613A2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD68071BF6B9A3BE0B"] = "_encstr_86B50A09DDA9F06012670701";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91830E2E77CFD0E9F11B98207217BF0B"] = "_encstr_83F10A82A8CBC24CC6889FFB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AFC40E0B1F055ADC4961FEC41820F222"] = "_encstr_87BE0BF25F281D1B20186A9301";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A61E1037C8EBFB1A4FA0497A157FF2B5B370"] = "_encstr_AB810ED289113F72107BB4AD6F60BC4B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_816310BDC878934A600DB75B7B1B62ED18D1"] = "_encstr_ABF40FEF78D81D4B693793CF307142B343";
  level.allieshealth = 0;
  level.alliesmaxhealth = 0;
  level.axishealth = 0;
  level.axismaxhealth = 0;
  level.usedspawnposone = 0;
  level.usedspawnpostwo = 0;
  level.usedspawnposthree = 0;
  setomnvar("_encstr_ACA6173B381FB91E3AD3497717A1590BFBC796C2A9C735FB83", 0);
  setomnvar("_encstr_816F151599487B067533F2B9B13B2B0BF060B9AE2114D4", 0);
  setomnvar("_encstr_96DF1B4592613B6B2AE3F6B1015A4D67BF7BF87A6739406B5C899D3633", 100);
  setomnvar("_encstr_AFAE19574BEB2CE4CADC0BAF0BE1A5E6AF86AC58361D347DDA8587", 100);
  setomnvar("_encstr_A1021AAB96D7164EB2DCB0AF0E39A5B658932F2B0B392DB0B9472944", -1);
  setomnvar("_encstr_8C1F1C1BF3F75A22F928E717E8D1EB627D9DE652635D126A2D48E3A3C12D", -1);

  if(game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 0) {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_99100DB316B556D1BCC12B7D99CC2C";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91B2067E0898939B"] = "_encstr_A2660AB0527D4F23CFCC8D71";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_A2660AB0527D4F23CFCC8D71";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_A2660AB0527D4F23CFCC8D71";
  } else if(game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 3) {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_83F717762C6B598EE507B2FA6D96C6D86CDB9B664BC9B62BC8";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91B2067E0898939B"] = "_encstr_8A561449F2BF4658219B3B39B416B880330AC3D03ACB";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_8A561449F2BF4658219B3B39B416B880330AC3D03ACB";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_8A561449F2BF4658219B3B39B416B880330AC3D03ACB";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C"] = "_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C";
  }
}

waitthensethealthregentweakable(var_0) {
  scripts\mp\tweakables::settweakablevalue("_encstr_8BB007E03658CBCAE4", "_encstr_823F10A0FA2F91A384EA5B47E5EDC8EBE712", var_0);
  scripts\mp\tweakables::settweakablelastvalue("_encstr_8BB007E03658CBCAE4", "_encstr_823F10A0FA2F91A384EA5B47E5EDC8EBE712", var_0);
}

launchchunkbotspawning() {
  level waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

  switch (game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"]) {
    case 0:
      level.launchchunkfreespawn = 0;
      break;
    case 1:
      level.launchchunkfreespawn = 1;
      break;
    case 2:
      level.launchchunkfreespawn = 1;
      break;
    case 3:
      level.launchchunkfreespawn = 1;
      break;
    default:
      break;
  }
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_88B018786F92361BF397F00F61BA4539E6FF0820CF5CC8FBBB3A", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_BD870E859CCACD16267BB023ED5DE8E6"));
  setdynamicdvar("_encstr_85321DC8DF22A68B6367379FF1DACF299C57706837C0B95D1A0F0690531211", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_8A8413E1576E1098FF6375181ABB44C04ABF2B6DC4"));
  setdynamicdvar("_encstr_BD7F17AB1EBA317FF34F3D2B8FCBBC5854F63023421138A09B", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_AF4B0D9BBB5AE8D8864D0E0BDD37DC"));
  setdynamicdvar("_encstr_B29B17D8CF32D6FB137710AFC17BD338AB67B8980FECA8AFBA", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_966E0D67F070833215FD8CC3532F1A"));
  setdynamicdvar("_encstr_85E816035AA3C868C23D8D8B1FED382A27F279C8B2671D08", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_AB4D0C0FA0F8F54A0973578C6D0D"));
  setdynamicdvar("_encstr_B2CF14AFC0FB1EF9C64D0DDF5748A86EB768C7A879E7", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_87EE0A6F2089DF4A3D81E61F"));
  setdynamicdvar("_encstr_976F1A9B6CC9FAB03995CD2CD7CC36B09DA1C2C1A3BA2759452DB6B2", getmatchrulesdata("_encstr_9BEB08778773D4A6BBBF", "_encstr_AFBB1099B1B0D91AC2C1E8579C598AD25BCA"));
  setdynamicdvar("_encstr_A5C61ACF79D0F72943CF885F9FF4AF4B34581B6FC3CB33E897B90814", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_B22A108032FEC12DBF59096D39EFC9EBA5CA"));
  setdynamicdvar("_encstr_849E19681B85570E9B9D08807868280A3B1B809AAAAA980BFB5F6C", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_BA940F98C6C29B8EA90D5A563623A6B7C8"));
  setdynamicdvar("_encstr_A55A1B68C26A47D1CB6D38A77FA3B883921BF0381AC76949579CB7A948", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_ABC211C4C6859B1DD4D0B4B28DC80D1B166B07"));
  setdynamicdvar("_encstr_824D160F078649D920013DC67E10F4625EB117AFEB2FF29E", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_9AA50C37D1584E47EA950BC1EDE6"));
  setdynamicdvar("_encstr_A96716DCB127EBB0C9ACCD2CD7BB951607EDDC515ACA2789", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_85700CEE950B1CDEDCA2D2563989"));
  setdynamicdvar("_encstr_BA67160328D5F9AF6BAD7671A81367BE39B05AE9D043EAAA", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_AA700CF777112B2098B581DD93CE"));
  setdynamicdvar("_encstr_B16716F79F33B810527FE019E93F78EF6BC755310FEAF67A", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_97700CBBAC8583B737512DAC9C66"));
  setdynamicdvar("_encstr_A567168FFE7E3E116E3D10C8A10B489F313F95BBD8F26B71", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_B2700C5B2988F08A40D9CFF7BD55"));
  setdynamicdvar("_encstr_8D6716E66CE4BE0B4E95B92CAFDD950BE0F6CD8AB456E44D", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_A6700CDC3F7281B036034B68F305"));
  setdynamicdvar("_encstr_AF6716936E93A78E35E022AA4947C7178BC0060CF399EB83", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_8A700CBBCA16E0BDDC8A4B2B938D"));
  setdynamicdvar("_encstr_9A671602E32B279863CA68F31E4751D2F34FB61F09DAED2B", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_84700CEE9558E0DECD152D564EDC"));
  setdynamicdvar("_encstr_A66716F05AF2CF59B3E5B03FC77F017BDA229051924FCD3A", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_82700C9F55C9230505715A9228C1"));
  setdynamicdvar("_encstr_9585133FBB4A297F03927099590327E8E704B38B25", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
}

onstartgametype() {
  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    game["_encstr_991C0AB9ED5B57161FE89B83"] = var_1;
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_0;
  }

  foreach(var_3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_3, &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_8E0115EFFEFCF57FDDF961736767B9353A5927B7BFB66F");

    scripts\mp\utility\game::setobjectivehinttext(var_3, &"_encstr_9A1A147A4825518645A495A2A6BCD50A92BE09A49C8A");
  }

  initspawns();
  thread adjustroundendtimer();
  thread waittooverridegraceperiod();

  if(israndomloadouts() || israndompreviewloadouts() || israndomalphaloadouts())
    thread updaterandomloadout();
  else if(ispickuploadouts()) {
    level.lethaldelay = 0;
    defineplayerloadout();
    initweaponmap();
    thread setupweapons();
  } else if(isgungameloadouts()) {
    level.blockweapondrops = 1;
    thread updatearenagungameloadout(0);
  } else if(isrvsgungameloadouts()) {
    level.blockweapondrops = 1;
    thread updatearenagungameloadout(1);
  }

  buildloadoutsforweaponstreaming();
  setupwaypointicons();
  seticonnames();

  if(level.objmodifier == 1)
    level setupendzones();

  var_5 = 0;

  switch (game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"]) {
    case 0:
      break;
    case 1:
      if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0)
        var_5 = 1;

      break;
    case 2:
      break;
    case 3:
      break;
    default:
      break;
  }

  level thread _encstr_8F431F033E8D20B1DDCB708D3270CF09537A130B900DBA08F8E65DC88B762F677F::spawngameendflagzone(var_5);
  physics_raycastents(scripts\mp\gamelogic::gettimeremaining(), 0);

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0) {
      if(game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 0 && game["_encstr_925A1733A0FBB31B09A57673339553BB059099FBF843A2F7C3"] != 3)
        level thread outlineenemyplayerslaunchchunk();
      else {
        level thread outlineenemyplayers();
        level thread removeenemyoutlines();
      }
    }
  }

  if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0)
    level thread setroundwinstreakarray();

  setDvar("_encstr_933B11DC6C93FA23D2B91631C65914AC4ED69B", 1);
}

droplaunchchunkbots() {
  if(istrue(game["_encstr_8E411136D05D73DA21DEE8B9A6C12CDDE69591"])) {
    game["_encstr_8E411136D05D73DA21DEE8B9A6C12CDDE69591"] = 0;
    scripts\mp\bots\bots::drop_bots(1, "_encstr_9A8507BA4040188D08");
    scripts\mp\bots\bots::drop_bots(1, "_encstr_8E8405EA382B2A");
  }
}

tryspawnlaunchchunkbots() {
  if(istrue(game["_encstr_8E411136D05D73DA21DEE8B9A6C12CDDE69591"])) {
    return;
  }
  level thread scripts\mp\bots\bots::spawn_bots(1, "_encstr_9A8507BA4040188D08", undefined, undefined, "_encstr_8EC50F5F713FFBE6A8F1A136E83839128E", "_encstr_889F0893CA6CC9BA2D8E");
  level thread scripts\mp\bots\bots::spawn_bots(1, "_encstr_8E8405EA382B2A", undefined, undefined, "_encstr_A20D10F7D987435E2BA9C94FC028957A6D37", "_encstr_889F0893CA6CC9BA2D8E");
  game["_encstr_8E411136D05D73DA21DEE8B9A6C12CDDE69591"] = 1;
}

waittooverridegraceperiod() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level.overrideingraceperiod = 1;
  level.ingraceperiod = 5;
}

alwaysgamemodeclass() {
  return "_encstr_AAAC09D09972B9C83F2B7F";
}

adjustroundendtimer() {
  wait 1;
  level.roundenddelay = 4.0;
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();

  if(game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 3) {
    level.dogtagallyonusecb = ::dogtagallyonusecbconf;
    level.dogtagenemyonusecb = ::dogtagenemyonusecbconf;
  } else if(level.dogtagsenabled) {
    level.dogtagallyonusecb = ::dogtagallyonusecb;
    level.dogtagenemyonusecb = ::dogtagenemyonusecb;
  }

  if(getdvarint("_encstr_A9ED1556B16A103FEFF7C5FBC5C9F127432028C9F903CB", 0) == 1) {
    setDvar("_encstr_97720B8110327704CFACD8A143", 1);
    var_0 = 128;
    var_1 = getdvarint("_encstr_958219C1C9DE0FC6A1B0E8BE27C291D2AB377DDEEC954E93A591AC", 0);

    if(var_1 != 0)
      var_0 = var_1;

    setDvar("_encstr_AB150B27C9D4134DA69CA8A745", var_0);
  }

  var_2 = 0;

  if(scripts\mp\utility\game::matchmakinggame()) {
    var_3 = getdvarint("_encstr_8A2E1D936C8DA783067F8BBAE347E5E833A4F028D8132F0AFB8FE34B544959", 0);

    if(var_3)
      var_2 = getdvarint("_encstr_922C171BAA8FA07FFB3291395A77AD10A91F8D9B32B2503567", 0);
  }

  level.arenaloadouts = 2;
  level.loadoutchangeround = scripts\mp\utility\dvars::dvarintvalue("_encstr_8A8413E1576E1098FF6375181ABB44C04ABF2B6DC4", 3, 0, 5);

  if(var_2 != 0) {
    level.arenaloadouts = var_2;
    level.loadoutchangeround = 3;
  }

  level.switchspawns = scripts\mp\utility\dvars::dvarintvalue("_encstr_AF4B0D9BBB5AE8D8864D0E0BDD37DC", 1, 0, 1);
  level.wincondition = scripts\mp\utility\dvars::dvarintvalue("_encstr_966E0D67F070833215FD8CC3532F1A", 1, 0, 2);
  setomnvar("_encstr_A96C165BACA7F0C652B3D3A793DA87603F03E39693D93075", level.arenaloadouts);
  setomnvar("_encstr_95B8105F5A1F680FD82E770DCD99F878E898", level.wincondition);
  level.objmodifier = scripts\mp\utility\dvars::dvarintvalue("_encstr_AB4D0C0FA0F8F54A0973578C6D0D", 0, 0, 1);
  level.spawnflag = scripts\mp\utility\dvars::dvarintvalue("_encstr_87EE0A6F2089DF4A3D81E61F", 0, 0, 1);

  if(game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] != 1 && game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] != 2)
    level.spawnflag = 0;
  else if(level.spawnflag) {
    level.ontimelimitgraceperiod = 10.0;
    level.currenttimelimitdelay = 0.0;
    level.canprocessot = 1;
  }

  level.tacticaltimemod = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_B22A108032FEC12DBF59096D39EFC9EBA5CA", 2.5, 0.5, 5);
  level.startweapon = getDvar("_encstr_824D160F078649D920013DC67E10F4625EB117AFEB2FF29E", "_encstr_8BBA05185F8B99");
  level.arenaweapont1 = getDvar("_encstr_A96716DCB127EBB0C9ACCD2CD7BB951607EDDC515ACA2789", "_encstr_B8B311C42CC8F74278DFF7F29998FA43110A4B");
  level.arenaweapont2 = getDvar("_encstr_BA67160328D5F9AF6BAD7671A81367BE39B05AE9D043EAAA", "_encstr_8DE1122D770EFA9BA1AF46832CC1C22664BEB5C1");
  level.arenaweapont3 = getDvar("_encstr_B16716F79F33B810527FE019E93F78EF6BC755310FEAF67A", "_encstr_93D811967783AFB9DAEB5BC1C2E0B0D4F5AD83");
  level.arenaweapont4 = getDvar("_encstr_A567168FFE7E3E116E3D10C8A10B489F313F95BBD8F26B71", "_encstr_A3D91096BB07BEC227BEAD2DB6CAA1FAB6C1");
  level.arenaweapont5 = getDvar("_encstr_8D6716E66CE4BE0B4E95B92CAFDD950BE0F6CD8AB456E44D", "_encstr_8F091280BBC06FBB63BF57D988A321732AC128D0");
  level.arenaweapont6 = getDvar("_encstr_AF6716936E93A78E35E022AA4947C7178BC0060CF399EB83", "_encstr_8BBB0B9D41E718D9E922D8582A");
  level.arenaweapont7 = getDvar("_encstr_9A671602E32B279863CA68F31E4751D2F34FB61F09DAED2B", "_encstr_AD0B110A20CB30F897F120B0BBDB76DBE8D81E");
  level.arenaweapont8 = getDvar("_encstr_A66716F05AF2CF59B3E5B03FC77F017BDA229051924FCD3A", "_encstr_820F114AE740032B7F8680CAD930B1D239F212");

  if(game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 2) {
    level.arenaloadouts = 3;
    level.loadoutchangeround = 3;
    level.startweapon = "_encstr_8BBA05185F8B99";
    level.arenaweapont1 = "_encstr_88870C93169BC8EB0EA56E47F663";
    level.arenaweapont2 = "_encstr_A31207CBF788523281";
    level.arenaweapont3 = "_encstr_B4D90992BFCD52477348B7";
    level.arenaweapont4 = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
    level.arenaweapont5 = "_encstr_8B4C0C4EB0E68CF5DCE6A5C15693";
    level.arenaweapont6 = "_encstr_ACA40CDB397D1988AAFF5C1917A1";
    level.arenaweapont7 = "_encstr_B1C30E930BDC91F53A0BD88EB46C16D8";
    level.arenaweapont8 = "_encstr_A31207CBF788523281";
    level thread botpickuphack();
  }

  if(ispickuploadouts()) {
    buildrandomweapontable();

    if(!isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]) || isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]) && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0) {
      level.startweapon = getrandomweaponforweapontier(level.startweapon);
      level.arenaweapont1 = getrandomweaponforweapontier(level.arenaweapont1);
      level.arenaweapont2 = getrandomweaponforweapontier(level.arenaweapont2);
      level.arenaweapont3 = getrandomweaponforweapontier(level.arenaweapont3);
      level.arenaweapont4 = getrandomweaponforweapontier(level.arenaweapont4);
      level.arenaweapont5 = getrandomweaponforweapontier(level.arenaweapont5);
      level.arenaweapont6 = getrandomweaponforweapontier(level.arenaweapont6);
      level.arenaweapont7 = getrandomweaponforweapontier(level.arenaweapont7);
      level.arenaweapont8 = getrandomweaponforweapontier(level.arenaweapont8);
    } else if(level.loadoutchangeround == 0 || game["_encstr_8DC30DAA0285FD69FAE113371B1934"] % level.loadoutchangeround != 0) {
      level.startweapon = game["_encstr_9AA50C37D1584E47EA950BC1EDE6"];
      level.arenaweapont1 = game["_encstr_910F0EF3427758977F4A3903F243C56A"];
      level.arenaweapont2 = game["_encstr_8F0F0E0BE459732CAB56851CBD9B1523"];
      level.arenaweapont3 = game["_encstr_A30F0E98F560CD10AF559683DF782BF7"];
      level.arenaweapont4 = game["_encstr_930F0EF6967B52D957E84F13A028A4BF"];
      level.arenaweapont5 = game["_encstr_A10F0EA883FF7581EFDD0FFFBF636F9B"];
      level.arenaweapont6 = game["_encstr_A70F0EBEF53990561F6771E79DAA110C"];
      level.arenaweapont7 = game["_encstr_AB0F0E5839CA73165DACB00EED738A6E"];
      level.arenaweapont8 = game["_encstr_960F0EA7A809D81BAFD89F2BC285055A"];
    } else if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] % level.loadoutchangeround == 0) {
      level.startweapon = getrandomweaponforweapontier(level.startweapon);
      level.arenaweapont1 = getrandomweaponforweapontier(level.arenaweapont1);
      level.arenaweapont2 = getrandomweaponforweapontier(level.arenaweapont2);
      level.arenaweapont3 = getrandomweaponforweapontier(level.arenaweapont3);
      level.arenaweapont4 = getrandomweaponforweapontier(level.arenaweapont4);
      level.arenaweapont5 = getrandomweaponforweapontier(level.arenaweapont5);
      level.arenaweapont6 = getrandomweaponforweapontier(level.arenaweapont6);
      level.arenaweapont7 = getrandomweaponforweapontier(level.arenaweapont7);
      level.arenaweapont8 = getrandomweaponforweapontier(level.arenaweapont8);
    }

    game["_encstr_9AA50C37D1584E47EA950BC1EDE6"] = level.startweapon;
    game["_encstr_910F0EF3427758977F4A3903F243C56A"] = level.arenaweapont1;
    game["_encstr_8F0F0E0BE459732CAB56851CBD9B1523"] = level.arenaweapont2;
    game["_encstr_A30F0E98F560CD10AF559683DF782BF7"] = level.arenaweapont3;
    game["_encstr_930F0EF6967B52D957E84F13A028A4BF"] = level.arenaweapont4;
    game["_encstr_A10F0EA883FF7581EFDD0FFFBF636F9B"] = level.arenaweapont5;
    game["_encstr_A70F0EBEF53990561F6771E79DAA110C"] = level.arenaweapont6;
    game["_encstr_AB0F0E5839CA73165DACB00EED738A6E"] = level.arenaweapont7;
    game["_encstr_960F0EA7A809D81BAFD89F2BC285055A"] = level.arenaweapont8;
  }
}

getrandomweaponforweapontier(var_0) {
  if(issubstr(var_0, "_encstr_8F1F052AC9E5A2")) {
    if(var_0 == "_encstr_A31207CBF788523281")
      var_0 = getrandomspawnweapon();
    else
      var_0 = getrandomweaponfromcategory(var_0);
  }

  return var_0;
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_92CE0CFC3930E089337FE96FA040", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_8D041C5B1C7D0BC9593785D7E6070BEE9BF585C663D22BDCFADCE82C39D1");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_B4BA1AAD1CBEB0C9CAB9B0FAB9380BBB73D716C3D26EFA378E854E47");
  var_2 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_ADBE0FD0D86941F207A6217E93F35B4BE0");

  if(var_0.size > 0 || var_1.size > 0) {
    scripts\mp\spawnlogic::addstartspawnpoints("_encstr_8D041C5B1C7D0BC9593785D7E6070BEE9BF585C663D22BDCFADCE82C39D1");
    scripts\mp\spawnlogic::addstartspawnpoints("_encstr_B4BA1AAD1CBEB0C9CAB9B0FAB9380BBB73D716C3D26EFA378E854E47");
    level.alliesstartspawn = "_encstr_8D041C5B1C7D0BC9593785D7E6070BEE9BF585C663D22BDCFADCE82C39D1";
    level.axisstartspawn = "_encstr_B4BA1AAD1CBEB0C9CAB9B0FAB9380BBB73D716C3D26EFA378E854E47";
  } else {
    scripts\mp\spawnlogic::addstartspawnpoints("_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39");
    scripts\mp\spawnlogic::addstartspawnpoints("_encstr_AC9A15250B91A8BDA6E3404BD38E405F4178BFF233D550");
    level.alliesstartspawn = "_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39";
    level.axisstartspawn = "_encstr_AC9A15250B91A8BDA6E3404BD38E405F4178BFF233D550";
  }

  if(var_2.size > 0) {
    scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_ADBE0FD0D86941F207A6217E93F35B4BE0");
    scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_ADBE0FD0D86941F207A6217E93F35B4BE0");
    level.spawntype = "_encstr_ADBE0FD0D86941F207A6217E93F35B4BE0";
  } else {
    var_2 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");

    if(var_2.size > 0) {
      scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
      scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
      level.spawntype = "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD";
    } else
      level.alwaysusestartspawns = 1;
  }

  if(!istrue(level.alwaysusestartspawns)) {
    scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", level.spawntype);
    scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", level.spawntype);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

validatespawns(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = scripts\mp\spawnlogic::getspawnpointarray(var_0);

  foreach(var_7 in var_5) {
    if(isDefined(var_7.script_noteworthy)) {
      if(!var_1)
        var_1 = var_7.script_noteworthy == "_encstr_A34C02BB";
      else {}

      if(!var_2)
        var_2 = var_7.script_noteworthy == "_encstr_A74C0222";
      else {}

      if(!var_3) {
        var_3 = var_7.script_noteworthy == "_encstr_A14C023B";
        level.hasthreespawns = 1;
      } else {}

      continue;
    }

    if(var_4 == 0) {
      var_7.script_noteworthy = "_encstr_A34C02BB";
      var_4++;
      continue;
    }

    if(var_4 == 1) {
      var_7.script_noteworthy = "_encstr_A74C0222";
      var_4++;
      continue;
    }

    if(var_4 == 2) {
      var_7.script_noteworthy = "_encstr_A14C023B";
      var_4++;
      level.hasthreespawns = 1;
    }
  }
}

getspawnpoint() {
  var_0 = undefined;
  var_1 = level.axisstartspawn;
  var_2 = 0;
  var_3 = 0;

  if(self.pers["_encstr_8AEF05472BC2D6"] == game["_encstr_991C0AB9ED5B57161FE89B83"])
    var_1 = level.alliesstartspawn;

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn() || istrue(level.alwaysusestartspawns) || dotournamentendgame()) {
    var_4 = scripts\mp\spawnlogic::getspawnpointarray(var_1);

    if(istrue(level.switchspawns) && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] > 0) {
      var_5 = scripts\mp\utility\teams::getteamcount(self.pers["_encstr_8AEF05472BC2D6"]);

      if(var_5 > 3) {
        foreach(var_7 in scripts\mp\utility\teams::getteamdata(self.pers["_encstr_8AEF05472BC2D6"], "_encstr_9775086022BE1B413B8B")) {
          if(isDefined(var_7.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"]))
            var_7.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] = "_encstr_934C0218";
        }

        var_3 = 1;
      }
    }

    if(istrue(level.switchspawns) && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] > 0 && !var_3) {
      if(self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] == "_encstr_A34C02BB")
        self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] = "_encstr_A74C0222";
      else if(scripts\mp\utility\teams::getteamcount(self.pers["_encstr_8AEF05472BC2D6"], 0) == 3 && istrue(level.hasthreespawns) && self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] == "_encstr_A74C0222")
        self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] = "_encstr_A14C023B";
      else if(self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] == "_encstr_A14C023B")
        self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] = "_encstr_A34C02BB";
      else
        self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] = "_encstr_A34C02BB";

      var_0 = getswitchside_spawnpoint(var_4, self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"]);
    }

    if(!isDefined(var_0)) {
      if(istrue(self.switching_teams_arena) && isDefined(self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"])) {
        cleanupspawn_scriptnoteworthy();
        var_0 = getspawnpoint_startspawn(var_4);
        self.switching_teams_arena = undefined;
      } else
        var_0 = getspawnpoint_startspawn(var_4);

      if(!isDefined(var_0)) {
        var_5 = scripts\mp\utility\teams::getteamcount(self.pers["_encstr_8AEF05472BC2D6"]);

        if(var_5 > 3) {
          var_9 = undefined;

          foreach(var_7 in scripts\mp\utility\teams::getteamdata(self.pers["_encstr_8AEF05472BC2D6"], "_encstr_9775086022BE1B413B8B")) {
            if(isDefined(var_7.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"])) {
              if(level.usedspawnposone == 1 && level.usedspawnposone == 1 && level.usedspawnposthree == 1) {
                level.usedspawnposone = 0;
                level.usedspawnpostwo = 0;
                level.usedspawnposthree = 0;
              }

              if(var_7.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] == "_encstr_A34C02BB" && level.usedspawnposone == 0) {
                level.usedspawnposone++;
                var_9 = var_7;
                break;
              } else if(var_7.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] == "_encstr_A74C0222" && level.usedspawnpostwo == 0) {
                level.usedspawnpostwo++;
                var_9 = var_7;
                break;
              } else if(var_7.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] == "_encstr_A14C023B" && level.usedspawnposthree == 0) {
                level.usedspawnposthree++;
                var_9 = var_7;
                break;
              } else {
                level.usedspawnposone++;
                var_9 = var_7;
                break;
              }
            }
          }

          if(isDefined(var_9)) {
            var_0 = scripts\mp\spawnscoring::findteammatebuddyspawn(var_9);
            var_2 = 1;
          }
        }
      }

      if(istrue(level.switchspawns) && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0 && !var_2)
        self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] = var_0.script_noteworthy;
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("_encstr_820E07FAE8780B3A4C");
    var_0 = scripts\mp\spawnlogic::getspawnpoint(self, self.pers["_encstr_8AEF05472BC2D6"], "_encstr_820E07FAE8780B3A4C", "_encstr_AD0C095DF195E8B6074A18");
  }

  return var_0;
}

cleanupspawn_scriptnoteworthy() {
  var_0 = scripts\mp\utility\game::getotherteam(self.pers["_encstr_8AEF05472BC2D6"])[0];

  if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    var_1 = level.alliesstartspawn;
    var_2 = level.axisstartspawn;
  } else {
    var_1 = level.axisstartspawn;
    var_2 = level.alliesstartspawn;
  }

  var_3 = scripts\mp\spawnlogic::getspawnpointarray(var_1);

  foreach(var_5 in var_3) {
    if(var_5.script_noteworthy == self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"])
      var_5.selected = 0;
  }

  var_3 = scripts\mp\spawnlogic::getspawnpointarray(var_2);

  foreach(var_5 in var_3) {
    foreach(var_9 in scripts\mp\utility\teams::getteamdata(self.pers["_encstr_8AEF05472BC2D6"], "_encstr_9775086022BE1B413B8B")) {
      if(var_9 != self && isDefined(var_9.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"]) && var_5.script_noteworthy != var_9.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"])
        var_5.selected = 0;
    }
  }
}

getspawnpoint_startspawn(var_0, var_1) {
  if(!isDefined(var_0))
    return undefined;

  var_2 = undefined;
  var_0 = scripts\mp\spawnscoring::checkdynamicspawns(var_0);

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.selected)) {
      continue;
    }
    if(var_4.selected) {
      continue;
    }
    if(var_4.script_noteworthy == "_encstr_A34C02BB") {
      var_2 = var_4;
      break;
    } else if(var_4.script_noteworthy == "_encstr_A74C0222") {
      var_2 = var_4;
      break;
    }

    var_2 = var_4;
  }

  if(isDefined(var_2))
    var_2.selected = 1;

  return var_2;
}

getswitchside_spawnpoint(var_0, var_1) {
  if(!isDefined(var_0))
    return undefined;

  var_2 = 0;

  foreach(var_4 in var_0) {
    if(var_4.script_noteworthy == var_1) {
      if(istrue(var_4.selected)) {
        var_2 = 1;
        continue;
      }

      var_4.selected = 1;
      return var_4;
    }
  }

  return undefined;
}

onplayerconnect(var_0) {
  level.bots_gametype_handles_class_choice = 1;

  if(istrue(level.resetstats))
    var_0 resetpersstats();

  var_0.arenadamage = 0;
  var_0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var_0.pers["_encstr_B2BE0788BAF573592F"]))
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["_encstr_B2BE0788BAF573592F"]);

  var_0 setclientomnvar("_encstr_8E8510ABB0472A5FC0DFBFB478E92B754B30", 1);
  var_0 setclientomnvar("_encstr_A5FB16AE4BD7632CEACDC60DEBD80DD5735BFAE043C2E62B", 0);
  var_0.pers["_encstr_959506B911C79707"] = "_encstr_AAAC09D09972B9C83F2B7F";
  var_0.pers["_encstr_92690A5B078ED325F539E25E"] = "_encstr_B40101";
  var_0.class = var_0.pers["_encstr_959506B911C79707"];
  var_0.lastclass = var_0.pers["_encstr_92690A5B078ED325F539E25E"];

  if(!istrue(game["_encstr_8D9213B186AEB9DAC85A27E6E80ACDCD4B769B5619"])) {
    var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.chunkloadouts[3];
    game["_encstr_8D9213B186AEB9DAC85A27E6E80ACDCD4B769B5619"] = 1;
  } else if(israndomloadouts() || israndompreviewloadouts() || israndomalphaloadouts())
    var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]];
  else if(ispickuploadouts())
    var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.arena_loadouts["_encstr_8E8405EA382B2A"];

  if(istrue(level.switchspawns) && !isDefined(var_0.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"]))
    var_0.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] = "_encstr_934C0218";

  var_0 thread onjoinedteam();
  var_0 updatehighpriorityweapons();
}

resetpersstats() {
  self.pers["_encstr_82FB06EB26785BD7"] = 0;
  self.pers["_encstr_8E8D0697EB01F243"] = 0;
  self.pers["_encstr_8E0607055DBFB3919A"] = 0;
  self.pers["_encstr_A68209DFE7B79AEC5BF76E"] = 0;
  self.pers["_encstr_96D30A3468575BA3C307A128"] = 0;
  self.pers["_encstr_A1F308589BCD96CD476E"] = 0;
  self.pers["_encstr_81CF0936850ED1D54EACCD"] = 0;
  self.pers["_encstr_820E0A2AE8981DBA528588DC"] = 0;
  self.pers["_encstr_B64E070F391562989D"] = 0;
  self.pers["_encstr_8A220C2BC3474E0BB9B17B9CB203"] = 0;
  self.pers["_encstr_84220CB23C8E9CC2CD36DB27AC4C"] = 0;
  self.pers["_encstr_AD220CACE18E93C2B98DEDE4B223"] = 0;
  self.pers["_encstr_B2BE0788BAF573592F"] = 0;
  self.pers["_encstr_A7E80EB868982F22383F6F4FD680F85D"] = 0;
  self.score = 0;
  self.kills = 0;
  self.deaths = 0;
  self.assists = 0;
  self.extrascore0 = 0;
  self.extrascore1 = 0;
  self.extrascore2 = 0;
}

onjoinedteam() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    scripts\engine\utility::_id_143A5("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
    var_0 = getdvarint("_encstr_856E15E68D93D7E0D80BF25639FADA163CA1AC0B8DD134", 100);

    if(isbot(self))
      wait 0.1;

    var_1 = scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_AB580A05672AE35D5FFF50B8");

    if(var_1) {
      level.alliesmaxhealth = scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_AB580A05672AE35D5FFF50B8") * var_0;
      setomnvar("_encstr_96DF1B4592613B6B2AE3F6B1015A4D67BF7BF87A6739406B5C899D3633", level.alliesmaxhealth);

      if(!scripts\mp\utility\player::isreallyalive(self) && scripts\mp\playerlogic::mayspawn())
        self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

      var_2 = 0;

      foreach(var_4 in scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_9775086022BE1B413B8B"))
      var_2 = var_2 + var_4.health;

      level.allieshealth = var_2;

      if(level.allieshealth < 0)
        level.allieshealth = 0;

      setomnvar("_encstr_ACA6173B381FB91E3AD3497717A1590BFBC796C2A9C735FB83", level.allieshealth);
    } else
      setomnvar("_encstr_ACA6173B381FB91E3AD3497717A1590BFBC796C2A9C735FB83", 0);

    var_6 = scripts\mp\utility\teams::getteamdata("_encstr_8E8405EA382B2A", "_encstr_AB580A05672AE35D5FFF50B8");

    if(var_6) {
      level.axismaxhealth = scripts\mp\utility\teams::getteamdata("_encstr_8E8405EA382B2A", "_encstr_AB580A05672AE35D5FFF50B8") * var_0;
      setomnvar("_encstr_AFAE19574BEB2CE4CADC0BAF0BE1A5E6AF86AC58361D347DDA8587", level.axismaxhealth);

      if(!scripts\mp\utility\player::isreallyalive(self) && scripts\mp\playerlogic::mayspawn())
        self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

      var_7 = 0;

      foreach(var_4 in scripts\mp\utility\teams::getteamdata("_encstr_8E8405EA382B2A", "_encstr_9775086022BE1B413B8B"))
      var_7 = var_7 + var_4.health;

      level.axishealth = var_7;

      if(level.axishealth < 0)
        level.axishealth = 0;

      setomnvar("_encstr_816F151599487B067533F2B9B13B2B0BF060B9AE2114D4", level.axishealth);
      continue;
    }

    setomnvar("_encstr_816F151599487B067533F2B9B13B2B0BF060B9AE2114D4", 0);
  }
}

onspawnplayer() {
  thread onspawnfinished();
  level notify("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  thread updatematchstatushintonspawn();
}

setphteamscores() {
  self notifyonplayercommand("_encstr_BE210C40871698B74527F5981E49", "_encstr_B44609DFE707CF394E1651");
  self notifyonplayercommand("_encstr_BE210C40871698B74527F5981E49", "_encstr_97410B23BD6B976233901AF2F8");
  thread setplacementstats();
}

setplacementstats() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_BE210C40871698B74527F5981E49");
  self notify("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", "_encstr_A5EF0DF98DF99B2651677B6157FAED", 2);
  level notify("_encstr_8A5E1260A27DBB4003C7EFA8CE2E03C12A40D72B");
  self setclientomnvar("_encstr_A5FB16AE4BD7632CEACDC60DEBD80DD5735BFAE043C2E62B", 0);
  game["_encstr_A7A918DA16E8D886D48EB0C98E2959E2574B9CB2E652B90EEAD1"] = 0;
  self notifyonplayercommandremove("_encstr_BE210C40871698B74527F5981E49", "_encstr_B44609DFE707CF394E1651");
  self notifyonplayercommandremove("_encstr_BE210C40871698B74527F5981E49", "_encstr_97410B23BD6B976233901AF2F8");
}

onspawnfinished() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(game["_encstr_A7A918DA16E8D886D48EB0C98E2959E2574B9CB2E652B90EEAD1"] && !isbot(self)) {
    foreach(var_1 in level.teamnamelist)
    level.requiredplayercount[var_1] = 0;

    self setclientomnvar("_encstr_A5FB16AE4BD7632CEACDC60DEBD80DD5735BFAE043C2E62B", game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] + 1);
    self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 3);
    wait 2;
    self setclientomnvar("_encstr_A5FB16AE4BD7632CEACDC60DEBD80DD5735BFAE043C2E62B", 5);
    thread setphteamscores();

    for(;;) {
      self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_3, var_4);

      if(var_3 == "_encstr_A5EF0DF98DF99B2651677B6157FAED") {
        break;
      }
    }

    level notify("_encstr_8A5E1260A27DBB4003C7EFA8CE2E03C12A40D72B");
    self setclientomnvar("_encstr_A5FB16AE4BD7632CEACDC60DEBD80DD5735BFAE043C2E62B", 0);
    game["_encstr_A7A918DA16E8D886D48EB0C98E2959E2574B9CB2E652B90EEAD1"] = 0;
    scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_817D099248EF14F3CB0657", "_encstr_817D099248EF14F3CB0657");
  }

  thread damagewatcher();
  self waittill("_encstr_B2030CA0C91D2F44C0B314F8836B");
  runarenaloadoutrulesonplayer();
  thread modifyblastshieldperk();
  wait 0.1;
  self.hasarenaspawned = 1;

  if(isbot(self)) {
    if(!isDefined(game["_encstr_8FFA14F738D3EE320D388B428563DAAEF8F827B3B00A"])) {
      var_5 = "_encstr_B892078D2C5BE05927";
      game["_encstr_8FFA14F738D3EE320D388B428563DAAEF8F827B3B00A"] = "_encstr_889F0893CA6CC9BA2D8E";
    } else {
      var_6 = randomint(3);

      switch (var_6) {
        case 0:
        default:
          var_5 = "_encstr_B892078D2C5BE05927";
          break;
        case 1:
          var_5 = "_encstr_BD560C63E89DE9BFF81D7747ADC0";
          break;
        case 2:
          var_5 = "_encstr_931904C66102";
          break;
      }

      var_7 = ["_encstr_889F0893CA6CC9BA2D8E", "_encstr_813008928DA89D31A8CA", "_encstr_A7D409342C272359DC59C8", "_encstr_BAAF081BD348D7E299C8"];
      var_8 = 0;

      if(isDefined(game["_encstr_8FFA14F738D3EE320D388B428563DAAEF8F827B3B00A"])) {
        for(var_9 = 0; var_9 < var_7.size; var_9++) {
          if(game["_encstr_8FFA14F738D3EE320D388B428563DAAEF8F827B3B00A"] == var_7[var_9]) {
            var_8 = var_9;
            break;
          }
        }

        if(!level.setinitialbotdifficulties && (game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 1 || game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 2)) {
          if(!isbot(self)) {
            if(game["_encstr_BDC61457F23A85480F8FC8F1E756E0F3F2DFDD558E12"] == self.team && game["_encstr_BAFF17DDB09B12DB9BA3A0634B6756821D25B75D9B19A83732"]) {
              if(var_8 < var_7.size - 1)
                var_8++;
            } else if(var_8 > 0)
              var_8--;
          }

          game["_encstr_8FFA14F738D3EE320D388B428563DAAEF8F827B3B00A"] = var_7[var_8];
          level.setinitialbotdifficulties = 1;
        }
      }
    }

    self botsetdifficulty(game["_encstr_8FFA14F738D3EE320D388B428563DAAEF8F827B3B00A"]);
    scripts\mp\bots\bots_util::bot_set_personality(var_5);
  }

  wait 0.15;

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0) {
    if(level.spawnflag && isDefined(level.matchcountdowntime) && level.matchcountdowntime > 5) {
      if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
        scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_84F10CD0C8FAC0BAD060AD874371", "_encstr_9A3C0B1F658D93DFB848454A03");
    }

    level scripts\engine\utility::_id_143A5("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", "_encstr_B4F6148B9FA5B0F482DF05234BEAA0B8543510800703");
  }

  self setclientomnvar("_encstr_B23A193348C8AB75788BE5FA2FE87D630B014B1970B8A72F308B0C", gettime());
}

modifyblastshieldperk() {
  var_0 = scripts\mp\utility\dvars::dvarintvalue("_encstr_BA940F98C6C29B8EA90D5A563623A6B7C8", 65, 0, 100) / 100;

  if(isbot(self)) {
    if(var_0 == 0 || game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 0 || game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 3)
      scripts\mp\utility\perk::removeperk("_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19");
  }
}

onplayerdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(var_1) && var_1 != var_2 && isPlayer(var_1)) {
    if(var_3 >= var_7)
      var_3 = var_7;

    var_1.arenadamage = var_1.arenadamage + var_3;
    var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B2BE0788BAF573592F", var_1.pers["_encstr_B2BE0788BAF573592F"]);
    var_1 scripts\mp\utility\stats::setextrascore0(var_1.pers["_encstr_B2BE0788BAF573592F"]);
  }
}

damagewatcher() {
  self notify("_encstr_928913BB033F5B8BB963C5D177E81B5FDD9982426B");
  self endon("_encstr_928913BB033F5B8BB963C5D177E81B5FDD9982426B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.totaldamagetaken = 0;

  for(;;) {
    scripts\engine\utility::_id_143AA("_encstr_B2BE0788BAF573592F", "_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5", "_encstr_9BD1119356ADB7D95682C8392B9B588D4B3759", "_encstr_8FB50718DD41DB3FA9", "_encstr_85211042E803A51BFF1DCFC5A007232CB55B", "_encstr_96B00A7E4F82030372481F2D", "_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

    if(self.team == "_encstr_9A8507BA4040188D08") {
      var_0 = 0;

      foreach(var_2 in scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_9775086022BE1B413B8B"))
      var_0 = var_0 + var_2.health;

      level.allieshealth = var_0;

      if(level.allieshealth < 0)
        level.allieshealth = 0;

      setomnvar("_encstr_ACA6173B381FB91E3AD3497717A1590BFBC796C2A9C735FB83", level.allieshealth);
    } else {
      var_4 = 0;

      foreach(var_2 in scripts\mp\utility\teams::getteamdata("_encstr_8E8405EA382B2A", "_encstr_9775086022BE1B413B8B"))
      var_4 = var_4 + var_2.health;

      level.axishealth = var_4;

      if(level.axishealth < 0)
        level.axishealth = 0;

      setomnvar("_encstr_816F151599487B067533F2B9B13B2B0BF060B9AE2114D4", level.axishealth);
    }

    if(istrue(self.iscapturing)) {
      var_7 = undefined;

      if(level.objmodifier == 1) {
        if(self.team == game["_encstr_B6A70A23CA6659DC91CAE4DC"]) {
          level.attackerendzone.curprogress = 50;
          level.attackerendzone.teamprogress[self.team] = 50;
          var_7 = level.attackerendzone;
        } else if(self.team == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
          level.defenderendzone.curprogress = 50;
          level.defenderendzone.teamprogress[self.team] = 50;
          var_7 = level.defenderendzone;
        }

        scripts\mp\objidpoolmanager::objective_set_progress(var_7.objidnum, var_7.curprogress / var_7.usetime);
      }
    }
  }
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);

  if(isbot(var_0))
    var_0.classcallback = "_encstr_AAAC09D09972B9C83F2B7F";

  if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060")
    var_1.finalkill = 1;

  if(game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 0 || game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 3) {
    if(isbot(var_1)) {
      if(var_1.kills % 4 == 0 || !isbot(var_0)) {
        var_6 = ["_encstr_889F0893CA6CC9BA2D8E", "_encstr_813008928DA89D31A8CA", "_encstr_A7D409342C272359DC59C8", "_encstr_BAAF081BD348D7E299C8"];
        var_7 = 0;
        var_8 = var_1 botgetdifficulty();

        if(var_8 == "_encstr_889F0893CA6CC9BA2D8E")
          var_7 = 0;
        else if(var_8 == "_encstr_813008928DA89D31A8CA")
          var_7 = 0;
        else if(var_8 == "_encstr_A7D409342C272359DC59C8")
          var_7 = 1;
        else if(var_8 == "_encstr_BAAF081BD348D7E299C8")
          var_7 = 2;

        var_1 botsetdifficulty(var_6[var_7]);
        game["_encstr_8FFA14F738D3EE320D388B428563DAAEF8F827B3B00A"] = var_6[var_7];
      }
    }

    if(isbot(var_0)) {
      if(var_0.deaths % 2 == 0) {
        var_6 = ["_encstr_889F0893CA6CC9BA2D8E", "_encstr_813008928DA89D31A8CA", "_encstr_A7D409342C272359DC59C8", "_encstr_BAAF081BD348D7E299C8"];
        var_7 = 0;
        var_8 = var_0 botgetdifficulty();

        if(var_8 == "_encstr_889F0893CA6CC9BA2D8E")
          var_7 = 1;
        else if(var_8 == "_encstr_813008928DA89D31A8CA")
          var_7 = 2;
        else if(var_8 == "_encstr_A7D409342C272359DC59C8")
          var_7 = 3;
        else if(var_8 == "_encstr_BAAF081BD348D7E299C8")
          var_7 = 3;

        var_0 botsetdifficulty(var_6[var_7]);
        game["_encstr_8FFA14F738D3EE320D388B428563DAAEF8F827B3B00A"] = var_6[var_7];
      }
    }

    if(var_0.deaths % 3 == 0) {
      game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]++;

      if(game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"] == game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"].size)
        game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"] = 0;

      var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]];
    }
  } else if(!isbot(var_0)) {
    var_9 = scripts\mp\gamelogic::gettimeremaining();

    if(var_9 > 35000) {
      var_6 = ["_encstr_889F0893CA6CC9BA2D8E", "_encstr_813008928DA89D31A8CA", "_encstr_A7D409342C272359DC59C8", "_encstr_BAAF081BD348D7E299C8"];
      var_7 = 0;
      var_8 = game["_encstr_8FFA14F738D3EE320D388B428563DAAEF8F827B3B00A"];

      if(var_8 == "_encstr_889F0893CA6CC9BA2D8E")
        var_7 = 0;
      else if(var_8 == "_encstr_813008928DA89D31A8CA")
        var_7 = 0;
      else if(var_8 == "_encstr_A7D409342C272359DC59C8")
        var_7 = 1;
      else if(var_8 == "_encstr_BAAF081BD348D7E299C8")
        var_7 = 1;

      game["_encstr_8FFA14F738D3EE320D388B428563DAAEF8F827B3B00A"] = var_6[var_7];
    }
  }
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isbot(self))
    self.classcallback = "_encstr_AAAC09D09972B9C83F2B7F";

  thread checkallowspectating();
}

checkallowspectating() {
  waitframe();
  var_0 = 0;

  if(!scripts\mp\utility\teams::getteamdata(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_8A2A0B936CCCC3078547970A8B")) {
    level.spectateoverride[game["_encstr_991C0AB9ED5B57161FE89B83"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(!scripts\mp\utility\teams::getteamdata(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_8A2A0B936CCCC3078547970A8B")) {
    level.spectateoverride[game["_encstr_B6A70A23CA6659DC91CAE4DC"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(var_0)
    scripts\mp\spectating::updatespectatesettings();
}

ontimelimit() {
  physics_raycastents(scripts\mp\gamelogic::gettimeremaining(), 3);

  if(game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 0 || game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 3)
    scripts\mp\gamelogic::default_ontimelimit();
  else if(level.wincondition == 1)
    checkliveswinner();
  else if(level.wincondition == 2)
    checkhealthwinner();
  else
    checkhealthwinner();

  if(game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] != 3)
    level tryspawnlaunchchunkbots();
}

ontimelimitot() {
  physics_raycastents(scripts\mp\gamelogic::gettimeremaining(), 1);
  var_0 = 1;

  if(scripts\mp\utility\game::getgametypenumlives() == 0)
    var_0 = 0;

  if(var_0)
    level thread startotmechanics();
}

checkliveswinner() {
  if(scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_8A2A0B936CCCC3078547970A8B") > scripts\mp\utility\teams::getteamdata("_encstr_8E8405EA382B2A", "_encstr_8A2A0B936CCCC3078547970A8B")) {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91830E2E77CFD0E9F11B98207217BF0B"] = "_encstr_916B15CEB0D659DC3A2CE859F5BB5ACDD786ACC2C6A31A";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AFC40E0B1F055ADC4961FEC41820F222"] = "_encstr_8F52163B16DACAE647588E95FA1BEDDCE8D70DACB0638E34";
    thread arena_endgame("_encstr_9A8507BA4040188D08", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AC0D15770A9726195F53100858203CD33B1962B73874ED"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AA3116F75A1F55C8194B7BD5B12738086B65E6217C880373"]);
  } else if(scripts\mp\utility\teams::getteamdata("_encstr_8E8405EA382B2A", "_encstr_8A2A0B936CCCC3078547970A8B") > scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_8A2A0B936CCCC3078547970A8B")) {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91830E2E77CFD0E9F11B98207217BF0B"] = "_encstr_916B15CEB0D659DC3A2CE859F5BB5ACDD786ACC2C6A31A";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AFC40E0B1F055ADC4961FEC41820F222"] = "_encstr_8F52163B16DACAE647588E95FA1BEDDCE8D70DACB0638E34";
    thread arena_endgame("_encstr_8E8405EA382B2A", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AC0D15770A9726195F53100858203CD33B1962B73874ED"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AA3116F75A1F55C8194B7BD5B12738086B65E6217C880373"]);
  } else
    checkhealthwinner();
}

checkhealthwinner() {
  if(level.axishealth < level.allieshealth) {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91830E2E77CFD0E9F11B98207217BF0B"] = "_encstr_916B15CEB0D659DC3A2CE859F5BB5ACDD786ACC2C6A31A";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AFC40E0B1F055ADC4961FEC41820F222"] = "_encstr_8F52163B16DACAE647588E95FA1BEDDCE8D70DACB0638E34";
    thread arena_endgame("_encstr_9A8507BA4040188D08", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_A57816BBB32A4888D793B830FFEFF875C25319D16F538338"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_927117371AD25D5127A32008CF0F48F33A0535CB391A17DBD3"]);
  } else if(level.allieshealth < level.axishealth) {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91830E2E77CFD0E9F11B98207217BF0B"] = "_encstr_916B15CEB0D659DC3A2CE859F5BB5ACDD786ACC2C6A31A";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AFC40E0B1F055ADC4961FEC41820F222"] = "_encstr_8F52163B16DACAE647588E95FA1BEDDCE8D70DACB0638E34";
    thread arena_endgame("_encstr_8E8405EA382B2A", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_A57816BBB32A4888D793B830FFEFF875C25319D16F538338"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_927117371AD25D5127A32008CF0F48F33A0535CB391A17DBD3"]);
  } else if(scripts\mp\utility\game::matchmakinggame()) {
    var_0 = scripts\mp\gamelogic::getbetterteam();
    thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
  } else
    thread arena_endgame("_encstr_8D19048EA595", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
}

ondeadevent(var_0) {
  if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"])
    level thread arena_endgame(game["_encstr_B6A70A23CA6659DC91CAE4DC"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][tolower(game[game["_encstr_991C0AB9ED5B57161FE89B83"]]) + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
  else if(var_0 == game["_encstr_B6A70A23CA6659DC91CAE4DC"])
    level thread arena_endgame(game["_encstr_991C0AB9ED5B57161FE89B83"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][tolower(game[game["_encstr_B6A70A23CA6659DC91CAE4DC"]]) + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
}

ontimelimitdeadevent(var_0) {}

arena_endgame(var_0, var_1, var_2, var_3, var_4) {
  if(isgungameloadouts() || isrvsgungameloadouts())
    level setenemyloadoutomnvarsatmatchend(var_0);

  if(var_0 != "_encstr_8D19048EA595") {
    game["_encstr_BDC61457F23A85480F8FC8F1E756E0F3F2DFDD558E12"] = var_0;

    foreach(var_6 in level.teamnamelist) {
      if(var_6 == var_0) {
        game["_encstr_82330FE47BAB7346AEA5734DE89C590BAD"][var_0]++;
        continue;
      }

      game["_encstr_82330FE47BAB7346AEA5734DE89C590BAD"][var_6] = 0;
    }

    switch (game["_encstr_82330FE47BAB7346AEA5734DE89C590BAD"][var_0]) {
      case 2:
        game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91830E2E77CFD0E9F11B98207217BF0B"] = "_encstr_AD17139CDE577391AFDD2DE6FA37A32759B0D6AF64";
        break;
      case 3:
        game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91830E2E77CFD0E9F11B98207217BF0B"] = "_encstr_9717134EB7AB9B91D7EE5AE67DB98EC9ACC26DD7CC";
        break;
      case 4:
        game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91830E2E77CFD0E9F11B98207217BF0B"] = "_encstr_871713BEE75F405941EBE8D84162219B77914AA014";
        break;
      case 5:
        var_8 = scripts\mp\utility\game::getroundswon(var_0);
        var_9 = scripts\mp\utility\dvars::getwatcheddvar("_encstr_97B20977D2B91B2DAD4BD1");

        if(var_9 == 6 && var_8 != var_9 - 1)
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91830E2E77CFD0E9F11B98207217BF0B"] = "_encstr_BD171375989B986721CB20E8C9CA2805C5416C0F06";

        break;
      default:
        break;
    }

    if(game["_encstr_96DF0BCC92723B8A59E7F338A1"] == 1) {
      if(game["_encstr_82330FE47BAB7346AEA5734DE89C590BAD"][var_0] > 3)
        game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A61E1037C8EBFB1A4FA0497A157FF2B5B370"] = "_encstr_A36C17CE2CDACAB93A2C3AB2F5BBB4E6F51BDB6B5998B0C6DA";
    }
  } else
    game["_encstr_BDC61457F23A85480F8FC8F1E756E0F3F2DFDD558E12"] = "_encstr_B40101";

  var_10 = undefined;

  foreach(var_12 in level.players) {
    if(!isbot(var_12))
      var_10 = var_12;
  }

  if(isDefined(var_10) && !isalive(var_10))
    game["_encstr_BAFF17DDB09B12DB9BA3A0634B6756821D25B75D9B19A83732"] = 0;
  else
    game["_encstr_BAFF17DDB09B12DB9BA3A0634B6756821D25B75D9B19A83732"] = 1;

  thread scripts\mp\gamelogic::endgame(var_0, var_1, var_2, var_3, var_4);

  if(game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] != 3)
    level thread tryspawnlaunchchunkbots();
}

setroundwinstreakarray() {
  wait 1;

  foreach(var_1 in level.teamnamelist)
  game["_encstr_82330FE47BAB7346AEA5734DE89C590BAD"][var_1] = 0;
}

runarenaloadoutrulesonplayer() {
  if(israndomloadouts() || israndompreviewloadouts() || israndomalphaloadouts()) {
    if(israndompreviewloadouts() || israndomalphaloadouts()) {
      if(self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] == "_encstr_8BBA05185F8B99")
        scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
    }
  } else if(ispickuploadouts()) {
    self.equipment = [];

    if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0)
      wait 0.1;
    else
      wait 0.25;

    if(issubstr(level.startweapon, "_encstr_84D7067AA0C37CE3"))
      scripts\mp\equipment::giveequipment(level.startweapon, scripts\mp\equipment::getdefaultslot(level.startweapon));

    if(level.takefists)
      scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  }
}

updatehighpriorityweapons() {
  self loadweaponsforplayer(level.loadweapons, 1);
}

buildloadoutsforweaponstreaming() {
  level.loadweapons = [];
  level.takefists = 0;

  if(ispickuploadouts()) {
    if(level.startweapon == "_encstr_8BBA05185F8B99") {
      var_0 = "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C";
      var_1 = getcompleteweaponname(var_0);
      var_0 = createheadicon(var_1);
    } else if(issubstr(level.startweapon, "_encstr_84D7067AA0C37CE3")) {
      var_0 = "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C";
      var_1 = getcompleteweaponname(var_0);
      var_0 = createheadicon(var_1);
    } else {
      var_2 = scripts\mp\utility\weapon::getweaponrootname(level.startweapon);
      var_3 = [];
      var_1 = scripts\mp\class::buildweapon(var_2, var_3, "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
      var_0 = createheadicon(var_1);
      level.takefists = 1;
    }

    level.newweaponname = var_0;
    level.loadweapons[level.loadweapons.size] = var_1;
  } else {
    var_4 = [];
    var_5 = [];
    var_6 = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]];
    var_7 = var_6["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"];
    var_8 = var_6["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"];

    if(var_7 != "_encstr_8BBA05185F8B99")
      var_4[var_4.size] = buildprimaries(var_7, var_6);

    if(var_8 != "_encstr_8BBA05185F8B99")
      var_5[var_5.size] = buildsecondaries(var_8, var_6);

    if(level.loadoutchangeround != 0) {
      var_9 = game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"] + 1;

      if(game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"] == game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"].size - 1)
        var_9 = 0;

      var_10 = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][var_9];
      var_11 = var_10["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"];
      var_12 = var_10["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"];

      if(var_11 != "_encstr_8BBA05185F8B99")
        var_4[var_4.size] = buildprimaries(var_11, var_10);

      if(var_12 != "_encstr_8BBA05185F8B99")
        var_5[var_5.size] = buildsecondaries(var_12, var_10);
    }

    level.loadweapons = scripts\engine\utility::array_combine(var_4, var_5);
  }
}

buildprimaries(var_0, var_1) {
  var_2 = [];

  for(var_3 = 1; var_3 < 6; var_3++) {
    var_4 = var_3;

    if(var_3 == 1)
      var_4 = "_encstr_B40101";

    var_5 = var_1["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878" + var_4];

    if(var_5 != "_encstr_8BBA05185F8B99")
      var_2[var_2.size] = var_5;
  }

  var_6 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_7 = "_encstr_8BBA05185F8B99";
  var_8 = "_encstr_8BBA05185F8B99";
  var_9 = scripts\mp\class::buildweapon(var_6, var_2, var_7, var_8);
  var_10 = createheadicon(var_9);
  return var_10;
}

buildsecondaries(var_0, var_1) {
  var_2 = [];

  for(var_3 = 1; var_3 < 6; var_3++) {
    var_4 = var_3;

    if(var_3 == 1)
      var_4 = "_encstr_B40101";

    var_5 = var_1["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB" + var_4];

    if(var_5 != "_encstr_8BBA05185F8B99")
      var_2[var_2.size] = var_5;
  }

  var_6 = "_encstr_8BBA05185F8B99";
  var_7 = "_encstr_8BBA05185F8B99";
  var_8 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_9 = scripts\mp\class::buildweapon(var_8, var_2, var_6, var_7);
  var_10 = createheadicon(var_9);
  return var_10;
}

defineplayerloadout() {
  if(isDefined(level.startweapon) && level.startweapon != "_encstr_8BBA05185F8B99" && !issubstr(level.startweapon, "_encstr_84D7067AA0C37CE3"))
    var_0 = scripts\mp\utility\weapon::getweaponrootname(level.startweapon);
  else
    var_0 = "_encstr_8BBA05185F8B99";

  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"] = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = var_0;
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"] = "_encstr_A393109FCF38E936DA97CCE3177050314CB8";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = ["_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19"];
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_81E6112CD2D9B12F700387D0E8A7C32341A7DD"] = "_encstr_A63C0B33252188F56B439B89EF";
  level.arena_loadouts["_encstr_9A8507BA4040188D08"] = level.arena_loadouts["_encstr_8B1608EC43B8D647A113"];
  level.arena_loadouts["_encstr_8E8405EA382B2A"] = level.arena_loadouts["_encstr_8B1608EC43B8D647A113"];
}

updaterandomloadout() {
  if(israndomloadouts() || israndompreviewloadouts() || israndomalphaloadouts()) {
    if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0) {
      if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
        cacherandomloadouts();
        game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"] = 0;
      } else if(!isDefined(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
        cacherandomloadouts();
        game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"] = 0;
      }
    } else if(level.loadoutchangeround != 0) {
      if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] % level.loadoutchangeround == 0)
        game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]++;

      if(game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"] == game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"].size)
        game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"] = 0;
    } else
      game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"] = 0;
  }
}

cacherandomloadouts() {
  game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"] = [];
  level.chunkloadouts = [];
  var_0 = 0;

  for(var_1 = "_encstr_93A21C6D3B4A53EA97C7D743CBCE328D21E122F75080277279D19A8717EC"; scripts\mp\class::table_getloadoutname(var_1, var_0) != "_encstr_B40101"; var_0++)
    level.chunkloadouts[level.chunkloadouts.size] = updateloadoutarray(var_1, var_0);

  var_2 = level.chunkloadouts;
  var_2 = arenaloadouts_select(var_2, 99);
  game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"] = scripts\engine\utility::array_randomize(var_2);
}

updateloadoutarray(var_0, var_1) {
  var_2 = [];
  var_2["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = scripts\mp\class::table_getweapon(var_0, var_1, 0);

  for(var_3 = 0; var_3 < scripts\mp\class::getmaxprimaryattachments(); var_3++) {
    var_4 = scripts\mp\class::getattachmentloadoutstring(var_3, "_encstr_BA7F0830B3A7859B60B0");
    var_2[var_4] = scripts\mp\class::table_getweaponattachment(var_0, var_1, 0, var_3);
  }

  var_2["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = scripts\mp\class::table_getweaponcamo(var_0, var_1, 0);
  var_2["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = scripts\mp\class::table_getweaponreticle(var_0, var_1, 0);
  var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = scripts\mp\class::table_getweapon(var_0, var_1, 1);

  for(var_3 = 0; var_3 < scripts\mp\class::getmaxsecondaryattachments(); var_3++) {
    var_4 = scripts\mp\class::getattachmentloadoutstring(var_3, "_encstr_AC8F0AE74163F85AAA380AD8");
    var_2[var_4] = scripts\mp\class::table_getweaponattachment(var_0, var_1, 1, var_3);
  }

  var_2["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = scripts\mp\class::table_getweaponcamo(var_0, var_1, 1);
  var_2["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = scripts\mp\class::table_getweaponreticle(var_0, var_1, 1);
  var_2["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = scripts\mp\class::table_getequipmentprimary(var_0, var_1);
  var_2["_encstr_B8141D4CD0C932385B1BE7E9D1C8DFF773FB94EB1541184BFFBAB38186438B"] = scripts\mp\class::table_getextraequipmentprimary(var_0, var_1);
  var_2["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = scripts\mp\class::table_getequipmentsecondary(var_0, var_1);
  var_2["_encstr_8EA71F285227ADE0CBE403710CF268F58F6B2D13DA6FD0706ACD57A70E5F203617"] = scripts\mp\class::table_getextraequipmentsecondary(var_0, var_1);
  var_2["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = [];

  for(var_5 = 0; var_5 < 3; var_5++) {
    var_6 = scripts\mp\class::table_getperk(var_0, var_1, var_5);

    if(var_6 != "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249")
      var_2["_encstr_86CB0DFB97F7022F90BB3A7F53487B"][var_2["_encstr_86CB0DFB97F7022F90BB3A7F53487B"].size] = var_6;
  }

  var_2["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
  var_2["_encstr_81E6112CD2D9B12F700387D0E8A7C32341A7DD"] = "_encstr_A63C0B33252188F56B439B89EF";
  return var_2;
}

arenaloadouts_select(var_0, var_1) {
  var_2 = [];
  var_3 = [];

  for(var_4 = 0; var_4 < var_1 && var_0.size > 0; var_4++) {
    var_3[var_3.size] = var_0[randomint(var_0.size)];
    var_5 = var_3[var_3.size - 1]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"];
    var_0 = arenaloadouts_removeclass(var_0, var_5);
  }

  return var_3;
}

arenaloadouts_removeclass(var_0, var_1) {
  var_2 = [];
  var_3 = arenaloadouts_getweapongroup(var_1);

  foreach(var_5 in var_0) {
    var_6 = arenaloadouts_getweapongroup(var_5["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"]);

    if(var_3 != var_6)
      var_2[var_2.size] = var_5;
  }

  return var_2;
}

arenaloadouts_getweapongroup(var_0) {
  var_1 = "_encstr_8BBA05185F8B99";

  if(var_0 != "_encstr_8BBA05185F8B99") {
    var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

    if(var_1 == "_encstr_A1710B57AD31DBCDCDF1422A60")
      var_1 = "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33";
  }

  return var_1;
}

buildrandomweapontable() {
  level.weaponcategories = [];
  level.allweapons = [];
  var_0 = 0;

  for(;;) {
    var_1 = "_encstr_8A871AE348FD3816BFC231FD785F45E0C2BF1D57FFD6185DEA0A4BC3";
    var_2 = tablelookupbyrow(var_1, var_0, 4);

    if(var_2 == "_encstr_B40101") {
      break;
    }

    if(!isDefined(level.weaponcategories[var_2]))
      level.weaponcategories[var_2] = [];

    var_3 = [];
    var_3["_encstr_AC20072B9FA9487832"] = tablelookupbyrow(var_1, var_0, 0);
    level.weaponcategories[var_2][level.weaponcategories[var_2].size] = var_3;
    level.allweapons[level.allweapons.size] = var_3;
    var_0++;
  }
}

getrandomweaponfromcategory(var_0) {
  var_1 = level.weaponcategories[var_0];

  if(isDefined(var_1) && var_1.size > 0) {
    if(scripts\mp\utility\game::matchmakinggame()) {
      var_2 = getdvarint("_encstr_8A2E1D936C8DA783067F8BBAE347E5E833A4F028D8132F0AFB8FE34B544959", 0);

      if(var_2) {
        if(var_0 == "_encstr_88870C93169BC8EB0EA56E47F663") {
          var_3 = randomintrange(0, 100);

          if(var_3 > 90)
            return "_encstr_8BBA05185F8B99";
          else if(var_3 > 60 && var_3 <= 80)
            return "_encstr_88FE0D0157202970845121C58E802F";
        }
      }
    }

    var_4 = "_encstr_B40101";
    var_5 = undefined;
    var_6 = 0;

    for(;;) {
      var_7 = randomintrange(0, var_1.size);
      var_5 = var_1[var_7];
      var_8 = scripts\mp\utility\weapon::getweaponrootname(var_5["_encstr_AC20072B9FA9487832"]);

      if(var_6 > var_1.size) {
        level.selectedweapons[var_8] = 1;
        var_4 = var_5["_encstr_AC20072B9FA9487832"];

        for(var_9 = 0; var_9 < level.weaponcategories[var_0].size; var_9++) {
          if(level.weaponcategories[var_0][var_9]["_encstr_AC20072B9FA9487832"] == var_4) {
            break;
          }
        }

        break;
      }

      var_6++;
    }

    return var_4;
  } else
    return "_encstr_8BBA05185F8B99";
}

initweaponmap() {
  level.baseraritymap = [];
  level.baseraritymap[level.arenaweapont1] = 0;
  level.baseraritymap[level.arenaweapont2] = 1;
  level.baseraritymap[level.arenaweapont3] = 2;
  level.baseraritymap[level.arenaweapont4] = 3;
  level.baseraritymap[level.arenaweapont5] = 4;
  level.baseraritymap[level.arenaweapont6] = 5;
  level.baseraritymap[level.arenaweapont7] = 6;
  level.baseraritymap[level.arenaweapont8] = 0;
}

setupweapons() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_914C0EDDB20B837BB97D38D2365BAB83", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(var_2.script_label == "_encstr_A34C02BB") {
      spawnweapon(var_2, level.arenaweapont1);
      continue;
    }

    if(var_2.script_label == "_encstr_A74C0222") {
      spawnweapon(var_2, level.arenaweapont2);
      continue;
    }

    if(var_2.script_label == "_encstr_A14C023B") {
      spawnweapon(var_2, level.arenaweapont3);
      continue;
    }

    if(var_2.script_label == "_encstr_AC4C024A") {
      spawnweapon(var_2, level.arenaweapont4);
      continue;
    }

    if(var_2.script_label == "_encstr_B84C027E") {
      spawnweapon(var_2, level.arenaweapont5);
      continue;
    }

    if(var_2.script_label == "_encstr_8F4C026A") {
      spawnweapon(var_2, level.arenaweapont6);
      continue;
    }

    if(var_2.script_label == "_encstr_914C02DC") {
      spawnweapon(var_2, level.arenaweapont7);
      continue;
    }

    if(var_2.script_label == "_encstr_864C02F9")
      spawnweapon(var_2, level.arenaweapont8);
  }
}

getrandomspawnweapon() {
  var_0 = level.allweapons;

  if(isDefined(var_0) && var_0.size > 0) {
    var_1 = "_encstr_B40101";
    var_2 = undefined;
    var_3 = 0;

    for(;;) {
      var_4 = randomintrange(0, var_0.size);
      var_2 = var_0[var_4];

      if(!issubstr(var_2["_encstr_AC20072B9FA9487832"], "_encstr_84D7067AA0C37CE3"))
        var_5 = scripts\mp\utility\weapon::getweaponrootname(var_2["_encstr_AC20072B9FA9487832"]);
      else
        var_5 = var_2["_encstr_AC20072B9FA9487832"];

      if(var_3 > var_0.size) {
        level.selectedweapons[var_5] = 1;
        var_1 = var_2["_encstr_AC20072B9FA9487832"];

        for(var_6 = 0; var_6 < level.allweapons.size; var_6++) {
          if(level.allweapons[var_6]["_encstr_AC20072B9FA9487832"] == var_1) {
            break;
          }
        }

        break;
      }

      var_3++;
    }

    return var_1;
  } else
    return "_encstr_8BBA05185F8B99";
}

spawnweapon(var_0, var_1) {
  if(var_1 == "_encstr_8BBA05185F8B99") {
    return;
  }
  var_2 = var_0.origin + (0, 0, 32);
  var_3 = var_0.origin + (0, 0, -32);
  var_4 = scripts\engine\trace::ray_trace(var_2, var_3, undefined, scripts\engine\trace::create_default_contents(1));
  var_5 = player_give_infinite_rocks(var_0);

  if(var_4["_encstr_A53009A25003666B9818C6"] < 1.0)
    var_5 = var_4["_encstr_BD260953AA97E3F014279D"] + (0, 0, 2);

  var_6 = getequipmentmodel(var_1);

  if(var_6 != "_encstr_B40101") {
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5);
    var_7 setModel(var_6);

    if(isDefined(var_0.angles)) {
      if(var_1 == "_encstr_82A70F2B3B73E33B472371FF21D7809DDF" || var_1 == "_encstr_886E0ECA2ED5B438FAB0A3D7B5B4CD95" || var_1 == "_encstr_AA870D15FAF37393C74318F8BB184A") {
        if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_AFF605A3F9E16B")
          var_7.angles = (270, var_0.angles[1], 90);
        else
          var_7.angles = (0, var_0.angles[1], 0);
      } else if(var_1 == "_encstr_843D095F2B7D52B041D9A3") {
        if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_AFF605A3F9E16B")
          var_7.angles = (180, var_0.angles[1], 180);
        else
          var_7.angles = (0, var_0.angles[1], 90);
      } else {
        var_7.angles = (0, 90, 0);
        var_7.origin = var_7.origin + (0, 0, 2);
      }
    } else
      var_7.angles = (0, 0, 90);

    var_8 = 128;
    var_9 = var_7 getequipmenthintstring(var_1);
    var_10 = var_7 getequipmenthinticon(var_1);
    var_7.equipment = var_1;
    var_7 makeusable();
    var_7 sethinttag("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_7 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
    var_7 sethinticon(var_10);
    var_7 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
    var_7 setusehideprogressbar(1);
    var_7 setHintString(var_9);
    var_7 setusepriority(0);
    var_7 sethintdisplayrange(var_8);
    var_7 sethintdisplayfov(120);
    var_7 setuserange(var_8);
    var_7 setusefov(360);
    var_7 sethintonobstruction("_encstr_BECC055CF3811A");
    var_7 thread outlineequipmentwatchplayerprox(var_6, var_1);
    var_7 thread watchequipmentpickup();
  } else {
    var_11 = undefined;
    var_11 = scripts\mp\utility\weapon::getweaponrootname(var_1);
    var_12 = [];
    var_8 = 128;
    var_13 = scripts\mp\class::buildweapon(var_11, var_12, "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
    var_14 = createheadicon(var_13);
    var_15 = spawn("_encstr_B2010820C5337B67C8CF" + var_14, var_5, 17);
    var_15 sethintdisplayrange(var_8);
    var_15 setuserange(var_8);
    manageweaponstartingammo(var_15, var_14);

    if(isDefined(var_0.angles))
      var_15.angles = var_0.angles;
    else
      var_15.angles = (0, 0, 90);

    var_15 thread outlinewatchplayerprox();
    var_15 thread watchpickup();
  }
}

player_give_infinite_rocks(var_0) {
  if(isDefined(var_0.script_label) && var_0.script_label == "_encstr_A14C023B" && distance(var_0.origin, (-488.2, -399.9, 54.25)) < 10)
    var_0.origin = (-488.2, -409.9, 54.25);
  else if(isDefined(var_0.script_label) && var_0.script_label == "_encstr_B84C027E" && distance(var_0.origin, (657.3, 644.6, 56)) < 10)
    var_0.origin = (665.3, 644.6, 56);

  return var_0.origin;
}

getequipmentmodel(var_0) {
  switch (var_0) {
    case "_encstr_8BBB0B9D41E718D9E922D8582A":
      return "_encstr_923A1AA7D52492717889292B4019BFEB0D6D27034BC08A2168B18B23";
    case "_encstr_8C450D955CD52D07D7DC2BB6A39587":
      return "_encstr_AAF31AD7883B8816DEF779CC6B46A14AE578A0990719EB6B38C3C7B3";
    case "_encstr_843D095F2B7D52B041D9A3":
      return "_encstr_A3B30E856CADE209A050075FE07EC3EF";
    case "_encstr_82A70F2B3B73E33B472371FF21D7809DDF":
      return "_encstr_B26E195D49B0E86A40B917BF83E0725420325525A3F097322D51E3";
    case "_encstr_886E0ECA2ED5B438FAB0A3D7B5B4CD95":
      return "_encstr_99271388FF0E28DF92EB3F67276917109F95F020A7";
    case "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381":
      return "_encstr_931129731D73B3D77039176721489509EFA0FAEEF7BD99EB58E05B4F09E04E22B1CF05A770E9A23A802803";
    case "_encstr_B6C70ECA2EEAB4C1BED67BC6DE8EBDD9":
      return "_encstr_B63013183693D9F3106D57704B21713FF057049028";
    case "_encstr_BDF90F4D9F8B8702A7B08A52682BBC0B61":
      return "_encstr_AAF31AD7883B8816DEF779CC6B46A14AE578A0990719EB6B38C3C7B3";
    case "_encstr_BD170C5B689B786221E98009A80C":
      return "_encstr_8C9F19304B2D900B35EA297FEB811F156AF0C950FF26A591A29E02";
    case "_encstr_A15317C13205384F894F55535B939BC0BC0109BB5F76200D02":
      return "_encstr_A15A1F805EA33083DD0AA9E0B2B9B7CB07CE1F8DB59F9BD54633D0208A8B0F602B";
    case "_encstr_84CB0CB2680B841B3E76A5AF0201":
      return "_encstr_A5341932F00DA43F789DF7D721661FEAA3285A7A2BA7DA473072D5";
    case "_encstr_AD0B110A20CB30F897F120B0BBDB76DBE8D81E":
      return "_encstr_A9E11E52906D841F58BDD7F7C186FFCA83483A5A20473E6F7016E50BE6689795";
    case "_encstr_AA870D15FAF37393C74318F8BB184A":
      return "_encstr_A6D6197B3399A12C7391EBBBB5D74727EDC134CBEBE697DC1DCA6B";
    case "_encstr_8B0E0CAC5CAB4B38FA46566CBDF2":
      return "_encstr_B48C194D59A0F89AB04907AFB3F0223A10E046175111BC921E4767";
    case "_encstr_820F114AE740032B7F8680CAD930B1D239F212":
      return "_encstr_ACEE10EF9D7CCA2930B1E1F388E163434333";
    default:
      return "_encstr_B40101";
  }
}

getequipmenthintstring(var_0) {
  switch (var_0) {
    case "_encstr_8BBB0B9D41E718D9E922D8582A":
      self.equiptype = "_encstr_BA7F0830B3A7859B60B0";
      return &"_encstr_B2161BA6A0F5A439E882A9A2BE7A7226AC970A52A15A5541D78CA414D1";
    case "_encstr_8C450D955CD52D07D7DC2BB6A39587":
      self.equiptype = "_encstr_BA7F0830B3A7859B60B0";
      return &"_encstr_856F1D9A41FA529C8E0A9A54AF7A9CC4ACBC0A4A682DAA0AFA6A8AA9512A0B";
    case "_encstr_843D095F2B7D52B041D9A3":
      self.equiptype = "_encstr_BA7F0830B3A7859B60B0";
      return &"_encstr_AD5A19A614FA529CE80AA951BED39313CACB1429D0D25514FA0D0D";
    case "_encstr_82A70F2B3B73E33B472371FF21D7809DDF":
      self.equiptype = "_encstr_BA7F0830B3A7859B60B0";
      return &"_encstr_96981FE9C3DF54E5743EC1FD81B8DDBC71A689B1E7936F11695649F768F097A795";
    case "_encstr_886E0ECA2ED5B438FAB0A3D7B5B4CD95":
      self.equiptype = "_encstr_BA7F0830B3A7859B60B0";
      return &"_encstr_86DA1DA60ABE9472748235A27D9E2713CA5EA092A1D2AA82FA14A2A629C98A";
    case "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381":
      self.equiptype = "_encstr_BA7F0830B3A7859B60B0";
      return &"_encstr_82AB1D0D57A111B0ECCB772F8F80F85CC910F284ADE9F589D8C9670B8BDCB0";
    case "_encstr_B6C70ECA2EEAB4C1BED67BC6DE8EBDD9":
      self.equiptype = "_encstr_BA7F0830B3A7859B60B0";
      return &"_encstr_83D51E7188A7F47D37F899D1F1DD85AC576F67FB33AF3F0969D49161E823CFA7";
    case "_encstr_BDF90F4D9F8B8702A7B08A52682BBC0B61":
      self.equiptype = "_encstr_BA7F0830B3A7859B60B0";
      return &"_encstr_A97A1FBB01411926D88880D7C057253459F837F9E8324999A79DC8A9425BF361FD";
    case "_encstr_BD170C5B689B786221E98009A80C":
      self.equiptype = "_encstr_AC8F0AE74163F85AAA380AD8";
      return &"_encstr_A5641C9A41FA529C7414D4547D9E728965E5824A682DAAA0BE8C260AA921";
    case "_encstr_A15317C13205384F894F55535B939BC0BC0109BB5F76200D02":
      self.equiptype = "_encstr_AC8F0AE74163F85AAA380AD8";
      return &"_encstr_AB491F87315EF1584F679D877077104C26626B1F513425812706558EDFB7A807EF";
    case "_encstr_84CB0CB2680B841B3E76A5AF0201":
      self.equiptype = "_encstr_AC8F0AE74163F85AAA380AD8";
      return &"_encstr_A5E31C8132D1B3D45F17612987BF2C415975873B5EC8C35F1F677981CF8D";
    case "_encstr_AD0B110A20CB30F897F120B0BBDB76DBE8D81E":
      self.equiptype = "_encstr_AC8F0AE74163F85AAA380AD8";
      return &"_encstr_A3B21B0D77DFF02685794F97717CEE680B50C2B4569F4960AEC123DFD1";
    case "_encstr_AA870D15FAF37393C74318F8BB184A":
      self.equiptype = "_encstr_AC8F0AE74163F85AAA380AD8";
      return &"_encstr_9A62240D0741EF9D6FD0B1A3DFE7A47DF1FDD1417B41778041D9190FD96418CF4180078B7525";
    case "_encstr_8B0E0CAC5CAB4B38FA46566CBDF2":
      self.equiptype = "_encstr_AC8F0AE74163F85AAA380AD8";
      return &"_encstr_91B21CB5EF19A9387453FFD7070840D441987A0C25617D115061C7B73F2B";
    case "_encstr_820F114AE740032B7F8680CAD930B1D239F212":
      self.equiptype = "_encstr_AC8F0AE74163F85AAA380AD8";
      return &"_encstr_A9B21BD4A07DA472E8A06A54D79E39139597054A34D2AA057DA64592D4";
    default:
      return "_encstr_B40101";
  }
}

getequipmenthinticon(var_0) {
  var_1 = "_encstr_88BA16F5BBEE7B16E0A060BFCF7777A9513A08EFD6DFF723";
  var_2 = tablelookup(var_1, 0, var_0, 3);
  return var_2;
}

manageweaponstartingammo(var_0, var_1) {
  var_2 = weaponclipsize(var_1);
  var_3 = 0;

  if(level.magcount != 3) {
    var_4 = !level.magcount;

    if(var_4) {
      var_2 = 0;
      var_3 = 0;
    } else
      var_3 = level.magcount - 1;

    if(level.magcount == 7)
      var_3 = weaponmaxammo(var_1);
    else
      var_3 = var_2 * var_3;
  } else
    var_3 = var_2 * 2;

  var_0 itemweaponsetammo(var_2, var_3);
}

watchequipmentpickup() {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_8F5C086405E70FBA4B4A", var_0, var_1);
  var_2 = 0;
  var_3 = checkissameequip(var_0);
  var_4 = checkpickupequiptypeammocount(var_0);
  var_5 = var_0 scripts\mp\equipment::getequipmentmaxammo(self.equipment);
  var_6 = checkcurrentequiptypeammocount(var_0);

  if(var_3) {
    if(var_4 == var_5)
      var_2 = 1;
  }

  if(var_3 && !var_2)
    var_0 scripts\mp\equipment::incrementequipmentammo(self.equipment, 1);
  else if(var_6 && !var_3)
    var_0 dropoldequipinplace(var_0 scripts\mp\equipment::getcurrentequipment(self.equiptype));

  if(!var_3)
    var_0 scripts\mp\equipment::giveequipment(self.equipment, self.equiptype);

  if(var_3 && var_2) {
    var_0 iprintlnbold(&"_encstr_BA031F35A0FA5239A3509AA2FAF427C495F2548A5552A0D42A9C2AEB9A140BA222");
    thread watchequipmentpickup();
  } else {
    var_0 playlocalsound("_encstr_B8151653D6C913796D7967FD87D8DF6FD2AFD28F9680955B");
    clearweaponoutlines();
    self makeunusable();
    self delete();
  }
}

checkpickupequiptypeammocount(var_0) {
  return var_0 scripts\mp\equipment::getequipmentammo(self.equipment);
}

checkcurrentequiptypeammocount(var_0) {
  var_1 = var_0 scripts\mp\equipment::getcurrentequipment(self.equiptype);

  if(isDefined(var_1))
    return var_0 scripts\mp\equipment::getequipmentammo(var_1);
  else
    return 0;
}

checkissameequip(var_0) {
  var_1 = var_0 scripts\mp\equipment::getcurrentequipment(self.equiptype);

  if(isDefined(var_1))
    return self.equipment == var_1;
  else
    return 0;
}

dropoldequipinplace(var_0) {
  spawnweapon(self, var_0);
}

watchpickup() {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_8F5C086405E70FBA4B4A", var_0, var_1);
  clearweaponoutlines();

  if(isDefined(var_1)) {
    var_1 thread outlinewatchplayerprox();
    var_1 thread watchpickup();
  }
}

updatearenagungameloadout(var_0) {
  if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0) {
    cachearenagungameloadouts(var_0);
    game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"] = 0;
  }
}

cachearenagungameloadouts(var_0) {
  game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"] = [];
  var_1 = [];
  var_2 = "_encstr_93A21C6D3B4A53EA97C7D743CBCE328D21E122F75080277279D19A8717EC";

  if(var_0)
    var_3 = [14, 24, 12, 29, 1, 8, 31, 34, 10, 2];
  else
    var_3 = [2, 10, 34, 31, 8, 1, 29, 12, 24, 14];

  for(var_4 = 0; var_4 < var_3.size; var_4++)
    var_1[var_1.size] = updateloadoutarray(var_2, var_3[var_4]);

  game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"] = var_1;
}

setenemyloadoutomnvars() {
  var_0 = undefined;

  if(!isDefined(self.pers["_encstr_8AEF05472BC2D6"]))
    var_1 = "_encstr_9A8507BA4040188D08";
  else
    var_1 = scripts\mp\utility\game::getotherteam(self.pers["_encstr_8AEF05472BC2D6"])[0];

  foreach(var_3 in level.players) {
    if(var_3.team == var_1) {
      var_0 = var_3;
      break;
    }
  }

  if(!isDefined(var_0))
    var_0 = self;

  var_5 = "_encstr_88BA16F5BBEE7B16E0A060BFCF7777A9513A08EFD6DFF723";
  self setclientomnvar("_encstr_8FCE14D5B4EB163995B985AF5937BEC1C996D6C29CF2", -1);
  self setclientomnvar("_encstr_A53916D7D350EA8AD820BE0979B89F83155F37C3A1E76349", -1);
  self setclientomnvar("_encstr_83D3136DB1A7F105BF0AF8015295A7A8A7347BEF1C", -1);
  self setclientomnvar("_encstr_84FF1505A3892EB3CD489A613190CFA3C01F9C91CF1035", -1);
  var_6 = int(tablelookup(var_5, 0, var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"], 1));
  self setclientomnvar("_encstr_8FCE14D5B4EB163995B985AF5937BEC1C996D6C29CF2", var_6);
  var_7 = int(tablelookup(var_5, 0, var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"], 1));
  self setclientomnvar("_encstr_A53916D7D350EA8AD820BE0979B89F83155F37C3A1E76349", var_7);
  var_8 = int(tablelookup(var_5, 0, var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"], 1));
  self setclientomnvar("_encstr_83D3136DB1A7F105BF0AF8015295A7A8A7347BEF1C", var_8);
  var_9 = int(tablelookup(var_5, 0, var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"], 1));
  self setclientomnvar("_encstr_84FF1505A3892EB3CD489A613190CFA3C01F9C91CF1035", var_9);
}

getgungameloadoutindex(var_0) {
  var_1 = 0;

  if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0)
    var_1 = 0;
  else if(isgungameloadouts())
    var_1 = game["_encstr_B81B0A39EDABE69137D5BDCD"][var_0.pers["_encstr_8AEF05472BC2D6"]];
  else
    var_1 = game["_encstr_B81B0A39EDABE69137D5BDCD"][scripts\mp\utility\game::getotherteam(var_0.pers["_encstr_8AEF05472BC2D6"])[0]];

  return var_1;
}

getgungameloadoutomnvarindex(var_0, var_1) {
  var_2 = 0;

  if(isgungameloadouts()) {
    var_2 = game["_encstr_B81B0A39EDABE69137D5BDCD"][var_0.pers["_encstr_8AEF05472BC2D6"]];

    if(isDefined(var_1) && var_1 == var_0.pers["_encstr_8AEF05472BC2D6"])
      var_2 = var_2 + 1;
  } else {
    var_2 = game["_encstr_B81B0A39EDABE69137D5BDCD"][scripts\mp\utility\game::getotherteam(var_0.pers["_encstr_8AEF05472BC2D6"])[0]];

    if(isDefined(var_1) && var_1 == scripts\mp\utility\game::getotherteam(var_0.pers["_encstr_8AEF05472BC2D6"])[0])
      var_2 = var_2 + 1;
  }

  return var_2;
}

setenemyloadoutomnvarsatmatchend(var_0) {
  foreach(var_2 in level.players) {
    var_3 = undefined;

    if(!isDefined(var_2.pers["_encstr_8AEF05472BC2D6"]))
      var_4 = "_encstr_9A8507BA4040188D08";
    else
      var_4 = scripts\mp\utility\game::getotherteam(var_2.pers["_encstr_8AEF05472BC2D6"])[0];

    foreach(var_6 in level.players) {
      if(var_6.team == var_4) {
        var_3 = var_6;
        break;
      }
    }

    if(!isDefined(var_3))
      var_3 = var_2;

    var_3.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][getgungameloadoutomnvarindex(var_3, var_0)];
    var_8 = "_encstr_88BA16F5BBEE7B16E0A060BFCF7777A9513A08EFD6DFF723";
    var_2 setclientomnvar("_encstr_8FCE14D5B4EB163995B985AF5937BEC1C996D6C29CF2", -1);
    var_2 setclientomnvar("_encstr_A53916D7D350EA8AD820BE0979B89F83155F37C3A1E76349", -1);
    var_2 setclientomnvar("_encstr_83D3136DB1A7F105BF0AF8015295A7A8A7347BEF1C", -1);
    var_2 setclientomnvar("_encstr_84FF1505A3892EB3CD489A613190CFA3C01F9C91CF1035", -1);
    var_9 = int(tablelookup(var_8, 0, var_3.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"], 1));
    var_2 setclientomnvar("_encstr_8FCE14D5B4EB163995B985AF5937BEC1C996D6C29CF2", var_9);
    var_10 = int(tablelookup(var_8, 0, var_3.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"], 1));
    var_2 setclientomnvar("_encstr_A53916D7D350EA8AD820BE0979B89F83155F37C3A1E76349", var_10);
    var_11 = int(tablelookup(var_8, 0, var_3.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"], 1));
    var_2 setclientomnvar("_encstr_83D3136DB1A7F105BF0AF8015295A7A8A7347BEF1C", var_11);
    var_12 = int(tablelookup(var_8, 0, var_3.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"], 1));
    var_2 setclientomnvar("_encstr_84FF1505A3892EB3CD489A613190CFA3C01F9C91CF1035", var_12);
  }
}

spawngameendflagzone(var_0) {
  var_1 = getEntArray("_encstr_BE220B4E0117F8B7861D7D7819", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_1[0])) {
    return;
  }
  level.arenaflag = var_1[0];
  var_2 = var_1[0];

  if(isDefined(var_2.target))
    var_3[0] = getEnt(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  else {
    var_3[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
    var_3[0].angles = var_2.angles;
  }

  var_2.objectivekey = "_encstr_B20703DFCF";
  var_2.iconname = "_encstr_B20703DFCF";
  var_1 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_2, "_encstr_A7A408B9CA5D1D4E2C63", undefined, 1);
  var_1.onuse = ::arenaflag_onuse;
  var_1.onbeginuse = ::arenaflag_onusebegin;
  var_1.onenduse = ::arenaflag_onuseend;
  var_1.onuseupdate = ::arenaflag_onuseupdate;
  var_1.oncontested = ::arenaflag_oncontested;
  var_1.isarena = 1;
  var_1 scripts\mp\gameobjects::pinobjiconontriggertouch();
  var_1.id = "_encstr_87D9083A6F628DDB5F1F";
  var_1.scriptable delete();
  var_1 scripts\mp\gameobjects::setcapturebehavior("_encstr_92FC0B5BB01A6B73D09459526B");
  var_1.ignorestomp = 1;
  level.objectives[var_1.objectivekey] = var_1;
  level.arenaflag = var_1;

  if(istrue(var_0)) {
    wait 0.1;
    level.arenaflag scripts\mp\gameobjects::requestid(1, 1, undefined, 0, 0);
    level.arenaflag.visibleteam = "_encstr_9A19040BCDBC";
    level.arenaflag scripts\mp\gameobjects::setobjectivestatusicons("_encstr_8C1211AFCFB0E25F40D9B0FA3098A6FBAF7F43");
    level.arenaflag thread _encstr_8F431F033E8D20B1DDCB708D3270CF09537A130B900DBA08F8E65DC88B762F677F::deleteotpreview();
    level thread showflagoutline();
  } else {
    level.arenaflag scripts\mp\gameobjects::requestid(1, 1, undefined, 0, 0);
    level.arenaflag disableotflag();
  }
}

showflagoutline() {
  waitframe();

  if(isDefined(level.arenaflag) && isDefined(level.arenaflag.flagmodel))
    level.arenaflag.flagmodel.outlinedid = scripts\mp\utility\outline::outlineenableforall(level.arenaflag.flagmodel, "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");

  level thread removeflagoutlineongameend();
}

arenaflag_onusebegin(var_0) {
  var_0.iscapturing = 1;
  level.canprocessot = 0;
  var_1 = scripts\mp\gameobjects::getownerteam();

  if(var_1 == "_encstr_A7A408B9CA5D1D4E2C63")
    var_0 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 1);

  self.neutralizing = istrue(level.flagneutralization) && var_1 != "_encstr_A7A408B9CA5D1D4E2C63";

  if(!istrue(self.neutralized))
    self.didstatusnotify = 0;

  var_2 = scripts\engine\utility::ter_op(istrue(level.flagneutralization), level.flagcapturetime * 0.5, level.flagcapturetime);
  scripts\mp\gameobjects::setusetime(var_2);

  if(istrue(level.capturedecay))
    thread scripts\mp\gameobjects::useobjectdecay(var_0.team);

  if(var_2 > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(var_0.team)[0];
    _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagcapturestate(var_0.team);
    scripts\mp\gameobjects::setobjectivestatusicons(level.icontaking, level.iconlosing);
  }
}

arenaflag_onuseupdate(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gameobjects::getownerteam();

  if(var_1 > 0.05 && var_2 && !self.didstatusnotify) {
    if(var_4 == "_encstr_A7A408B9CA5D1D4E2C63") {
      if(level.flagcapturetime > 0.05) {
        scripts\mp\utility\dialog::statusdialog("_encstr_823109E62B1BAB27D2B93B" + self.objectivekey, var_0);
        var_5 = scripts\mp\utility\game::getotherteam(var_0)[0];
        scripts\mp\utility\dialog::statusdialog("_encstr_8267076C10DBE8B6E0" + self.objectivekey, var_5);
      }
    } else if(level.flagcapturetime > 0.05) {
      scripts\mp\utility\dialog::statusdialog("_encstr_8267076C10DBE8B6E0" + self.objectivekey, var_4);
      scripts\mp\utility\dialog::statusdialog("_encstr_823109E62B1BAB27D2B93B" + self.objectivekey, var_0);
    }

    self.didstatusnotify = 1;
  }
}

arenaflag_onuseend(var_0, var_1, var_2) {
  level.canprocessot = 1;
  self.didstatusnotify = 0;

  if(var_2)
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);

  if(isPlayer(var_1)) {
    var_1.iscapturing = 0;
    var_1 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
    var_1.ui_dom_securing = undefined;
  }

  var_3 = scripts\mp\gameobjects::getownerteam();

  if(var_3 == "_encstr_A7A408B9CA5D1D4E2C63") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_A7C5056BD931D1", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate(var_3, 0);
  }

  if(!var_2)
    self.neutralized = 0;
}

arenaflag_onuse(var_0) {
  level.canprocessot = 1;
  var_1 = var_0.team;
  var_2 = scripts\mp\gameobjects::getownerteam();
  var_3 = scripts\mp\utility\game::getotherteam(var_1)[0];
  self.capturetime = gettime();
  self.neutralized = 0;
  scripts\mp\utility\dialog::statusdialog("_encstr_86AD05B1F6B9A3" + self.objectivekey, var_3);
  scripts\mp\utility\dialog::statusdialog("_encstr_AAE70838F27E43E327DC" + self.objectivekey, var_1);
  thread scripts\mp\utility\print::printandsoundoneveryone(var_1, var_3, undefined, undefined, "_encstr_AF841588B30FD127CB0E030550B7FEB7F82ACBD80E0DC1", "_encstr_BD6C119A43E0C38D30DF0E1CBBB8592B10DB83", var_0);
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_setcaptured(var_1, var_0);

  if(!self.neutralized) {
    var_4 = 3;

    if(self.objectivekey == "_encstr_B20703DFCF")
      var_4 = 1;
    else if(self.objectivekey == "_encstr_B40703E96D")
      var_4 = 2;

    if(isDefined(level.onobjectivecomplete))
      [[level.onobjectivecomplete]]("_encstr_ABED0902389B228718185C", self.objectivekey, var_0, var_1, var_2, self);

    self.firstcapture = 0;
  }

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91830E2E77CFD0E9F11B98207217BF0B"] = "_encstr_A3E9165F58909A3E8B0153F8CF9470B83869DF6BCBD8BB12";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AFC40E0B1F055ADC4961FEC41820F222"] = "_encstr_B4FE17DF83896A4B90013B47FE686FC3DD67473F49ADD30270";
  level thread arena_endgame(var_0.team, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8E7C172C9C59DCC2AFBD3A998D0BECEB1BF6AD3863AC8E5923"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_83E014C2E4ACB916EBDE8E6636C276BE33162D632B8C"]);
}

arenaflag_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_B85C0AD87B9B8E95CD8E2B46", 0);
  level thread forcegameendcontesttimeout();
}

forcegameendcontesttimeout() {
  level notify("_encstr_917517EEA8C73013C7F836E780B1A8885F1FC34013F8DFBB01");
  level endon("_encstr_917517EEA8C73013C7F836E780B1A8885F1FC34013F8DFBB01");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(level.ottimecontested))
    level.ottimecontested = 0;

  while(level.ottimecontested < 5000) {
    wait(level.framedurationseconds);
    level.ottimecontested = level.ottimecontested + level.frameduration;
  }

  level.canprocessot = 1;
}

disableotflag() {
  scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  scripts\mp\gameobjects::disableobject();

  if(isDefined(self.scriptable))
    self.scriptable delete();

  self.flagmodel hide();
}

removeflagoutlineongameend() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(level.arenaflag) && isDefined(level.arenaflag.flagmodel.outlinedid))
    scripts\mp\utility\outline::outlinedisable(level.arenaflag.flagmodel.outlinedid, level.arenaflag.flagmodel);
}

deleteotpreview() {
  level scripts\engine\utility::_id_143A5("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", "_encstr_8F55118F8B711B6436974A09E1173783D313D9");
  disableotflag();
}

setupendzones() {
  level.attackerendzone = getEntArray("_encstr_BD7D139CF0C747800AFD535029D8CB1C6B63404DE3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.defenderendzone = getEntArray("_encstr_8A9E13034127E2CFB068266D86403D2A8DEDB387E5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.attackerendzone = level.attackerendzone[0] createendzone(game["_encstr_991C0AB9ED5B57161FE89B83"]);
  level.defenderendzone = level.defenderendzone[0] createendzone(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
  level.objectives = [];
  level.objectives[level.objectives.size] = level.attackerendzone;
  level.objectives[level.objectives.size] = level.defenderendzone;
}

createendzone(var_0) {
  if(isDefined(self.target))
    var_1[0] = getEnt(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  else {
    var_1[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
    var_1[0].angles = self.angles;
  }

  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_AFBB1099B1B0D91AC2C1E8579C598AD25BCA", 10, 0, 30);

  if(isDefined(self.objectivekey))
    var_2 = self.objectivekey;
  else
    var_2 = self.script_label;

  if(isDefined(self.iconname))
    var_3 = self.iconname;
  else
    var_3 = self.script_label;

  var_4 = scripts\mp\gameobjects::createuseobject(var_0, self, var_1, (0, 0, 100));
  var_4.team = var_0;
  var_4.ownerteam = var_0;
  var_4 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);
  var_4 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  var_4 scripts\mp\gameobjects::cancontestclaim(1);
  var_4 scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  var_4.onuse = ::endzone_onuse;
  var_4.onbeginuse = ::endzone_onusebegin;
  var_4.onenduse = ::endzone_onuseend;
  var_4.oncontested = ::endzone_oncontested;
  var_4.onuncontested = ::endzone_onuncontested;
  var_4.isarena = 1;
  var_4 scripts\mp\gameobjects::pinobjiconontriggertouch();
  var_4.id = "_encstr_87D9083A6F628DDB5F1F";

  if(isDefined(level.capturetype))
    var_4 scripts\mp\gameobjects::setcapturebehavior(getcapturetype());

  var_4.objectivekey = var_2;
  var_4.iconname = var_3;
  var_4 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  var_4.stompprogressreward = ::endzone_stompprogressreward;
  var_4.nousebar = 1;
  var_4.claimgracetime = level.flagcapturetime * 1000;
  var_5 = var_1[0].origin + (0, 0, 32);
  var_6 = var_1[0].origin + (0, 0, -32);
  var_7 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_8 = [];
  var_9 = scripts\engine\trace::ray_trace(var_5, var_6, var_8, var_7);
  var_4.baseeffectpos = var_9["_encstr_BD260953AA97E3F014279D"];
  var_10 = vectortoangles(var_9["_encstr_820E07FAE8780B3A4C"]);
  var_4.baseeffectforward = anglesToForward(var_10);
  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.baseeffectpos);
  var_11 setModel("_encstr_8B501446DED6F5CC361676BEB96C4E5AE08EB031B159");
  var_11.angles = generateaxisanglesfromforwardvector(var_4.baseeffectforward, var_11.angles);
  var_4.scriptable = var_11;
  var_4.vfxnamemod = "_encstr_B40101";

  if(isDefined(var_4.trigger.radius)) {
    if(var_4.trigger.radius == 160)
      var_4.vfxnamemod = "_encstr_AD450587AAD3F1";
    else if(var_4.trigger.radius == 90)
      var_4.vfxnamemod = "_encstr_BE1A04D772C0";
    else if(var_4.trigger.radius == 315)
      var_4.vfxnamemod = "_encstr_A64505BE660C06";
    else if(var_4.trigger.radius != 120)
      var_4.noscriptable = 1;
  }

  var_4.flagmodel = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.baseeffectpos);
  var_4.flagmodel setModel("_encstr_887E1AD64BB1A51D0B2797F519BDD6EB66B1B09DF5B9CAD5D139C2C6");
  var_4.outlineent = var_4.flagmodel;
  return var_4;
}

endzone_onusebegin(var_0) {
  var_0.iscapturing = 1;
  level.canprocessot = 0;
  var_1 = scripts\mp\gameobjects::getownerteam();

  if(var_1 == "_encstr_A7A408B9CA5D1D4E2C63")
    var_0 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 1);

  self.neutralizing = istrue(level.flagneutralization) && var_1 != "_encstr_A7A408B9CA5D1D4E2C63";

  if(!istrue(self.neutralized))
    self.didstatusnotify = 0;

  var_2 = scripts\engine\utility::ter_op(istrue(level.flagneutralization), level.flagcapturetime * 0.5, level.flagcapturetime);
  scripts\mp\gameobjects::setusetime(var_2);

  if(istrue(level.capturedecay))
    thread scripts\mp\gameobjects::useobjectdecay(var_0.team);

  if(var_2 > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(var_0.team)[0];
    _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagcapturestate(var_0.team);
    scripts\mp\gameobjects::setobjectivestatusicons(level.icontakingendzone, level.iconlosingendzone);
  }
}

endzone_onuseend(var_0, var_1, var_2) {
  level.canprocessot = 1;

  if(var_2)
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);

  if(isPlayer(var_1)) {
    var_1.iscapturing = 0;
    var_1 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
    var_1.ui_dom_securing = undefined;
  }

  var_3 = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);

  if(!var_2)
    self.neutralized = 0;
}

endzone_onuse(var_0) {
  level.canprocessot = 1;
  var_1 = var_0.team;
  var_2 = scripts\mp\gameobjects::getownerteam();
  var_3 = scripts\mp\utility\game::getotherteam(var_1)[0];
  self.capturetime = gettime();
  self.neutralized = 0;
  thread scripts\mp\utility\print::printandsoundoneveryone(var_1, var_3, undefined, undefined, "_encstr_AF841588B30FD127CB0E030550B7FEB7F82ACBD80E0DC1", "_encstr_BD6C119A43E0C38D30DF0E1CBBB8592B10DB83", var_0);
  endzone_setcaptured(var_1, var_0);

  if(!self.neutralized) {
    if(isDefined(level.onobjectivecomplete))
      [[level.onobjectivecomplete]]("_encstr_ABED0902389B228718185C", self.objectivekey, var_0, var_1, var_2, self);
  }

  level thread arena_endgame(var_0.team, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"], undefined, 0, 2);
}

endzone_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontestendzone);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
}

endzone_onuncontested(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);
  self.processot = 1;
}

endzone_setcaptured(var_0, var_1) {
  scripts\mp\gameobjects::setownerteam(var_0);
  self notify("_encstr_95EB0866891B23FB85B3", var_1);
  self notify("_encstr_AB3508737F830710ACDB", var_1);
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);
  self.neutralized = 0;

  if(self.touchlist[var_0].size == 0)
    self.touchlist = self.oldtouchlist;

  thread giveflagcapturexp(self.touchlist[var_0], var_1);

  if(isDefined(level.matchrecording_logevent))
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), scripts\engine\utility::ter_op(var_0 == "_encstr_9A8507BA4040188D08", 1, 2));

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "_encstr_AD260A8AFAF7FBA3658762C6" + var_0);
}

endzone_stompprogressreward(var_0) {
  var_0 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");
}

getcapturetype() {
  var_0 = "_encstr_820E07FAE8780B3A4C";

  if(level.capturetype == 2)
    var_0 = "_encstr_A10F0BD0F2FB41E337D40BFAB5";
  else if(level.capturetype == 3)
    var_0 = "_encstr_92FC0B5BB01A6B73D09459526B";

  return var_0;
}

giveflagcapturexp(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = var_1;

  if(isDefined(var_2.owner))
    var_2 = var_2.owner;

  level.lastcaptime = gettime();

  if(isPlayer(var_2)) {
    level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_B6C51896FF899237F3C017BF50E9E5BB6385DA0D5E2B4B49D838", var_2);
    var_2 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_95EB0866891B23FB85B3", var_2.origin);
  }

  var_3 = getarraykeys(var_0);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_0[var_3[var_4]].player;

    if(isDefined(var_5.owner))
      var_5 = var_5.owner;

    if(!isPlayer(var_5)) {
      continue;
    }
    var_5 scripts\mp\utility\stats::incpersstat("_encstr_81CF0936850ED1D54EACCD", 1);
    var_5 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_81CF0936850ED1D54EACCD", var_5.pers["_encstr_81CF0936850ED1D54EACCD"]);
    var_5 thread scripts\mp\awards::givemidmatchaward("_encstr_83A2106BF6C8B2EB237B6BD7CDCAB1ABE42B");
    wait 0.05;
  }
}

startotmechanics() {
  if(level.objmodifier == 1) {
    foreach(var_1 in level.objectives)
    var_1 deleteendzone();
  }

  level.canprocessot = 1;

  if(!isDefined(level.arenaflag.objidnum))
    level.arenaflag scripts\mp\gameobjects::requestid(1, 1, undefined, 0, 0);

  level.arenaflag scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  level.arenaflag scripts\mp\gameobjects::enableobject();
  level.arenaflag scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  level.arenaflag.flagmodel show();

  if(level.spawnflag)
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8B6D0940CC35339149DA08"] = "_encstr_B62B1DF74FBD793315290B951FEDE0EF085534C28537F7630FF8AB73F8A036";

  foreach(var_4 in level.players) {
    if(var_4 issplitscreenplayer() && !var_4 issplitscreenplayerprimary()) {
      continue;
    }
    var_4 scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_8B6D0940CC35339149DA08");
  }

  level.arenaflag.flagmodel playSound("_encstr_841B0DCC36B0D9FAB93885BB372B46");
  level thread showflagoutline();
}

deleteendzone() {
  scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  scripts\mp\gameobjects::releaseid();
  self.trigger = undefined;
  self notify("_encstr_8BE208E31FA8E1631D65");
  self.visibleteam = "_encstr_8BBA05185F8B99";

  if(isDefined(self.scriptable))
    self.scriptable delete();

  self.flagmodel delete();
}

dogtagallyonusecb(var_0) {}

dogtagenemyonusecb(var_0) {
  var_0.health = var_0.maxhealth;
  var_0 notify("_encstr_8FB50718DD41DB3FA9");
}

outlineenemyplayers() {
  level endon("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level endon("_encstr_B4F6148B9FA5B0F482DF05234BEAA0B8543510800703");

  for(;;) {
    level waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    waitframe();

    foreach(var_1 in level.players) {
      var_2 = var_1 getentitynumber();

      if(!isDefined(var_1.outlinedenemies)) {
        if(!isDefined(level.activeoutlines))
          level.activeoutlines = 1;
        else
          level.activeoutlines++;
      }

      foreach(var_4 in level.players) {
        if(var_4 != var_1 && var_4.team != var_1.team) {
          if(isDefined(var_1.outlinedenemies))
            scripts\mp\utility\outline::outlinedisable(var_1.outlinedenemies, var_1);

          var_1.outlinedenemies = scripts\mp\utility\outline::outlineenableforteam(var_1, var_4.team, "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
          break;
        }
      }
    }
  }
}

outlineenemyplayerslaunchchunk() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4F6148B9FA5B0F482DF05234BEAA0B8543510800703");

  for(;;) {
    level waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    waitframe();

    foreach(var_1 in level.players) {
      var_2 = var_1 getentitynumber();

      if(!isDefined(var_1.outlinedenemies)) {
        if(!isDefined(level.activeoutlines))
          level.activeoutlines = 1;
        else
          level.activeoutlines++;
      }

      foreach(var_4 in level.players) {
        if(var_4 != var_1 && var_4.team != var_1.team) {
          if(isDefined(var_1.outlinedenemies))
            scripts\mp\utility\outline::outlinedisable(var_1.outlinedenemies, var_1);

          var_1.outlinedenemies = scripts\mp\utility\outline::outlineenableforteam(var_1, var_4.team, "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
          break;
        }
      }
    }
  }
}

removeenemyoutlines() {
  thread notifyremoveoutlines();
  level scripts\engine\utility::_id_143A5("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", "_encstr_B4F6148B9FA5B0F482DF05234BEAA0B8543510800703");

  foreach(var_1 in level.players) {
    var_2 = var_1 getentitynumber();

    if(isDefined(var_1.outlinedenemies)) {
      level.activeoutlines--;
      scripts\mp\utility\outline::outlinedisable(var_1.outlinedenemies, var_1);
      var_1.outlinedenemies = undefined;
    }
  }
}

notifyremoveoutlines() {
  level endon("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level waittill("_encstr_924C1B4A90714E33663EF41956EB27D28B38E2E1182F83733BADE70760");

  if(level.prematchperiodend > 5)
    var_0 = int(max(level.prematchperiodend - 5, 5));
  else
    var_0 = int(max(level.prematchperiodend - 2, 2));

  wait(var_0);
  level notify("_encstr_B4F6148B9FA5B0F482DF05234BEAA0B8543510800703");
}

outlineequipmentwatchplayerprox(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8F5C086405E70FBA4B4A");
  self.outlinedplayers = [];
  var_2 = level.baseraritymap[var_1];
  var_3 = getoutlineasset(var_2);

  for(;;) {
    foreach(var_5 in level.players) {
      if(isDefined(var_5.hasarenaspawned)) {
        var_6 = distance2dsquared(self.origin, var_5.origin);
        var_7 = var_5 getentitynumber();

        if(var_6 < 490000) {
          if(!isDefined(self.outlinedplayers[var_7])) {
            if(!isDefined(level.activeoutlines))
              level.activeoutlines = 1;
            else
              level.activeoutlines++;

            self.outlinedplayers[var_7] = scripts\mp\utility\outline::outlineenableforplayer(self, var_5, var_3, "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
          }
        } else if(isDefined(self.outlinedplayers[var_7])) {
          level.activeoutlines--;
          scripts\mp\utility\outline::outlinedisable(self.outlinedplayers[var_7], self);
          self.outlinedplayers[var_7] = undefined;
        }
      }
    }

    waitframe();
  }
}

outlinewatchplayerprox() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8F5C086405E70FBA4B4A");
  self.outlinedplayers = [];
  var_0 = scripts\mp\weapons::getitemweaponname();
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_2 = level.baseraritymap[var_1 + "_encstr_851A049F8337"];
  var_3 = getoutlineasset(var_2);

  for(;;) {
    foreach(var_5 in level.players) {
      if(isDefined(var_5.hasarenaspawned)) {
        var_6 = distance2dsquared(self.origin, var_5.origin);
        var_7 = var_5 getentitynumber();

        if(var_6 < 490000) {
          if(!isDefined(self.outlinedplayers[var_7])) {
            if(!isDefined(level.activeoutlines))
              level.activeoutlines = 1;
            else
              level.activeoutlines++;

            self.outlinedplayers[var_7] = scripts\mp\utility\outline::outlineenableforplayer(self, var_5, var_3, "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
          }
        } else if(isDefined(self.outlinedplayers[var_7])) {
          level.activeoutlines--;
          scripts\mp\utility\outline::outlinedisable(self.outlinedplayers[var_7], self);
          self.outlinedplayers[var_7] = undefined;
        }
      }
    }

    waitframe();
  }
}

getoutlineasset(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = "_encstr_998806DD1A96D12B";
  var_2 = int(min(var_0, 8));

  switch (var_2) {
    case 0:
      var_1 = "_encstr_AAA514372003FC02452D71B705218BB00E48A3B78099";
      break;
    case 1:
      var_1 = "_encstr_966414C71D2B13C445B879C250917BFBA68C4245BD30";
      break;
    case 2:
      var_1 = "_encstr_9B9D132773AD52F9F829A96FC1E02CCA90F7C797DD";
      break;
    case 3:
      var_1 = "_encstr_9B0F12DE5DE8B15AB9B2F53295834734F54E59C8";
      break;
    case 4:
      var_1 = "_encstr_96AE15674513800375C947242F6863285787EB2916E22F";
      break;
    case 5:
      var_1 = "_encstr_AB6615D8332BB1480ECFA968D748A3F1E15845D1CD325F";
      break;
    case 6:
      var_1 = "_encstr_859613025BCD4BA470C34F7CEBA82BE3E011AA2B21";
      break;
    case 7:
      var_1 = "_encstr_966414C71D2B13C445B879C250917BFBA68C4245BD30";
      break;
    case 8:
      var_1 = "_encstr_9B0F12DE5DE8B15AB9B2F53295834734F54E59C8";
      break;
  }

  return var_1;
}

clearweaponoutlines() {
  foreach(var_2, var_1 in self.outlinedplayers) {
    level.activeoutlines--;
    scripts\mp\utility\outline::outlinedisable(var_1, self);
    var_1 = undefined;
  }
}

selflookatfriendly() {
  level endon("_encstr_88720F38AD6015D76D31E299D9481BCF80");
  var_0 = undefined;
  var_1 = 0;

  while(isDefined(level.matchcountdowntime) && level.matchcountdowntime > 5) {
    var_2 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

    if(var_2.size > 1) {
      var_1 = 1;
      break;
    }

    waitframe();
  }

  if(var_1) {
    var_3 = self.angles;
    var_4 = 0;
    var_5 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B");

    foreach(var_7 in var_5) {
      if(var_7 != self)
        var_0 = var_7;
    }

    var_9 = var_0.origin - self.origin;
    var_10 = self.origin - var_0.origin;
    var_11 = anglestoright(self.angles);
    var_12 = vectordot(var_11, var_9);
    var_13 = 0;
    var_14 = 0;

    if(var_12 < 0) {
      var_15 = 85;
      var_13 = 1;
    } else {
      var_15 = -90;
      var_14 = 1;
    }

    if(isDefined(var_0)) {
      if(var_13) {
        if(!isbot(self)) {
          wait 0.5;

          if(self.currentweapon.basename != "_encstr_8BBA05185F8B99")
            self forceplaygestureviewmodel("_encstr_9BE9132A70BF81DF03FD335080ABCF92DD90B2B260");
        }
      } else if(!isbot(self)) {
        wait 0.5;

        if(self.currentweapon.basename != "_encstr_8BBA05185F8B99")
          self forceplaygestureviewmodel("_encstr_ACD0143B2B37AF6C9CBA6E86F5A3ABC9DC27B4D9343A");
      }

      wait 3;
      scripts\mp\utility\player::_freezecontrols(0);
      return;
    }

    scripts\mp\utility\player::_freezecontrols(0);
    return;
  } else
    scripts\mp\utility\player::_freezecontrols(0);
}

updatematchstatushintonspawn() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 0);
}

seticonnames() {
  level.iconcaptureendzone = "_encstr_ADF019B08F710BDF6A6DD54806C22933C56BB879E70EC1CDD29545";
  level.icondefendendzone = "_encstr_B22C18983278C9C0975605E834CFA9BBE5CA61805AD71518B345";
  level.iconcontestendzone = "_encstr_B22F1C983278C9C0975605E833E7A89927BB38E05A175F59B3440AF80617";
  level.icontakingendzone = "_encstr_99E218C8F70963B7F2C56DE05B2AE708769701C063ACFA7F6A2F";
  level.iconlosingendzone = "_encstr_B82918D3A8538227B8B8FCDF4180AF0C953BD94A7831786F7015";
  level.iconneutral = "_encstr_85B118EB19F840DA93FDCB6FCF4FF39C7083E73531200C43FFE1";
  level.iconcapture = "_encstr_859A1183D94B3B2548D56447E7202A93F5133A";
  level.icondefend = "_encstr_994B105B20DB3A9F30206457CD5973870DE0";
  level.iconcontested = "_encstr_AA3B135FEBE0328F83F003B939E8D36BA877D4D509";
  level.icontaking = "_encstr_B40710E36BBF4F179FCD9CC8C9B1F3836012";
  level.iconlosing = "_encstr_8202100F51F881C7C0F2255890A5865376FF";
}

setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_99E218C8F70963B7F2C56DE05B2AE708769701C063ACFA7F6A2F", 0, "_encstr_93B508770F528D90B3DB", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B82918D3A8538227B8B8FCDF4180AF0C953BD94A7831786F7015", 0, "_encstr_93B508770F528D90B3DB", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B22F1C983278C9C0975605E833E7A89927BB38E05A175F59B3440AF80617", 0, "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_ADF019B08F710BDF6A6DD54806C22933C56BB879E70EC1CDD29545", 0, "_encstr_88BF06FD784A6393", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B22C18983278C9C0975605E834CFA9BBE5CA61805AD71518B345", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_8752176707085AE70881F88278C0EE33C88793AFCD2D929DF0", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A66F12DC3EF381B031EBE8B9EB5148CBEA27406F", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", "_encstr_8752176707085AE70881F88278C0EE33C88793AFCD2D929DF0", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A16713EE0B2F07DE2D9B3AFAB1B007D157E4ACEB2C", 0, "_encstr_88BF06FD784A6393", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_8752176707085AE70881F88278C0EE33C88793AFCD2D929DF0", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_9373123807F973A7E2F55DF04F1A8D99468BF1F0", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_8752176707085AE70881F88278C0EE33C88793AFCD2D929DF0", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B26A1563E7F2C198172EC97F81814BD58060B01DD74978", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", "_encstr_8752176707085AE70881F88278C0EE33C88793AFCD2D929DF0", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_BDD114BB85F2E0ED5AE6A3AF9863B71B5BB4B99DF50B", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_922B2143880199E8D7D0141D599FB0E9285FFFD50AF90921CFE8AC847067F05976584F", "_encstr_8752176707085AE70881F88278C0EE33C88793AFCD2D929DF0", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_917013FF4B40922F2350E359F989770EB83B644FE3", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B8E62095EF77589E3DD1D7FF091446D093B8EDDE7ACFA0D444D9F7E729CE0348D93E", "_encstr_8752176707085AE70881F88278C0EE33C88793AFCD2D929DF0", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_AAE91218B2F8494017D68568BC678B23657AE120", 0, "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", "_encstr_8752176707085AE70881F88278C0EE33C88793AFCD2D929DF0", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_AD371ABBE173130D903D9CAF3F0812CB9D7B12B2C9CD5B02B811BF99", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_8752176707085AE70881F88278C0EE33C88793AFCD2D929DF0", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_BA411567BF22CBDDD388B319F8075513191EECED458ED7", 0, "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", "_encstr_8752176707085AE70881F88278C0EE33C88793AFCD2D929DF0", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_996F16CB2AB8A880B348609750B080796C70CAC895F467E9", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", "_encstr_8752176707085AE70881F88278C0EE33C88793AFCD2D929DF0", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_95F117A22F95A85940918328F0C452FCA91BCEC6FA31DB0662", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", "_encstr_8752176707085AE70881F88278C0EE33C88793AFCD2D929DF0", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8384135CB6D7EA4FFB10C7EB48102613DFD863592F", 1, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_BAEC2251A887D49DD7187931D1FDA5CC374FC85EDADF5C614F300119F885F766A789CFAE", "_encstr_8752176707085AE70881F88278C0EE33C88793AFCD2D929DF0", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8ECD1123407BEFC751BD31889F2789592B50D7", 1, "_encstr_88BF06FD784A6393", "_encstr_B40101", "_encstr_973E1461B6E8BB2923B80A72B013DAC72128F7F4DFB1", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8D701AD8D9A3D7CD4C1A2C4F6BC02F0B49DF82890FABA35586805851", 1, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B40101", "_encstr_973E1461B6E8BB2923B80A72B013DAC72128F7F4DFB1", 0);
}

israndomloadouts() {
  return level.arenaloadouts == 2;
}

ispickuploadouts() {
  return level.arenaloadouts == 3;
}

isgungameloadouts() {
  return level.arenaloadouts == 4;
}

isrvsgungameloadouts() {
  return level.arenaloadouts == 5;
}

israndompreviewloadouts() {
  return level.arenaloadouts == 6;
}

israndomalphaoneloadouts() {
  return level.arenaloadouts == 7;
}

israndomalphatwoloadouts() {
  return level.arenaloadouts == 8;
}

israndomalphathreeloadouts() {
  return level.arenaloadouts == 9;
}

israndomalphafourloadouts() {
  return level.arenaloadouts == 10;
}

israndomalphafiveloadouts() {
  return level.arenaloadouts == 11;
}

israndomalphaloadouts() {
  switch (level.arenaloadouts) {
    case 11:
    case 10:
    case 9:
    case 8:
    case 7:
      return 1;
    default:
      return 0;
  }
}

dogtagallyonusecbconf(var_0) {
  if(isPlayer(var_0))
    var_0 scripts\mp\gamescore::giveteamscoreforobjective(var_0.pers["_encstr_8AEF05472BC2D6"], level.scoredeny, 0);
}

dogtagenemyonusecbconf(var_0) {
  if(isPlayer(var_0))
    var_0 scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C", undefined, undefined, undefined, 4);

  var_0 scripts\mp\gamescore::giveteamscoreforobjective(var_0.pers["_encstr_8AEF05472BC2D6"], level.scoreconfirm, 0);
}

botpickuphack() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  wait 1;

  for(;;) {
    foreach(var_1 in level.players) {
      if(isbot(var_1)) {
        var_2 = scripts\mp\utility\weapon::getweaponrootname(level.arenaweapont1);
        var_3 = [];
        var_4 = scripts\mp\class::buildweapon(var_2, var_3, "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
        var_5 = createheadicon(var_4);
        var_1 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_5);
        var_1 scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_4);
      }
    }

    break;
  }

  foreach(var_1 in level.players) {
    if(isbot(var_1))
      var_1 thread fakepickups();
  }
}

fakepickups() {
  for(;;) {
    wait 1;

    if(self.currentprimaryweapon.basename != "_encstr_8B98105A770ED71C5ABE46AC1B0DF6AFB61C" && self.currentprimaryweapon.basename != "_encstr_B8B7134BEE70EB0ED2FA5BB4D69526721398D7AD07" && self.currentprimaryweapon.basename != "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C" && self.currentprimaryweapon.basename != "_encstr_8BBA05185F8B99")
      wait 3;

    if(!self attackButtonPressed() && !self isreloading() && !self useButtonPressed()) {
      self botpressbutton("_encstr_AB19049D0FC0", 0.5);
      continue;
    }

    wait 0.5;

    if(!self attackButtonPressed() && !self isreloading() && !self useButtonPressed())
      self botpressbutton("_encstr_AB19049D0FC0", 0.5);
  }
}

currentdestination() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = getdvarint("_encstr_ABAF18CD3693BE37B54B83AF31BD7BD1FA3658D6C1EB6BBD3256");

    if(var_0 != -1) {
      var_1 = 3;
      level.starttime = gettime();
      var_2 = "_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8E6F0BE85BD29B9154974068CB";
      level.watchdvars[var_2].value = var_1;
      level.overridewatchdvars[var_2] = var_1;
      game["_encstr_92601150B29DA125D73567C006EFCB75C4EA90"] = var_0;
    }

    wait 1;
  }
}