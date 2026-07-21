/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\arena.gsc
***********************************************/

main() {
  game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"] = getdvarint("_encstr_82EF0BAD77307D200137587432", 0) != 0;

  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = scripts\mp\utility\game::getgametype();
  var_0[1] = "_encstr_8218041DF5FA";
  scripts\mp\gameobjects::main(var_0);

  if(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]) {
    _encstr_B6F82393B845C45B1B36A7ED4F88FF0E93106B8B88333A6E919EF516EFAEAF1519A2C2A368::main();
    return;
  }

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 24);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 30);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 19);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 10);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinbytwoenableddvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinbytwomaxroundsdvar(scripts\mp\utility\game::getgametype(), 4);
  }

  updategametypedvars();

  if(israndompreviewloadouts()) {
    level.ispreviewbuild = 1;
    level.previewbuildfirstallies = 1;
    level.previewbuildfirstaxis = 1;
  }

  level.teambased = 1;
  level.objectivebased = 1;
  level.overridetimelimitclock = 10;
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
  level.allowlatecomers = 0;
  level.removekilleventsplash = 1;

  if(scripts\mp\utility\game::matchmakinggame()) {
    var_1 = getdvarint("_encstr_87750A3D9EA82A699EA24953", 4) / 2;
    level._id_12C49 = 1;
    level.requiredplayercount["_encstr_9A8507BA4040188D08"] = var_1;
    level.requiredplayercount["_encstr_8E8405EA382B2A"] = var_1;
  }

  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::_id_12043);

  if(!scripts\mp\utility\game::iswinbytworulegametype())
    level.skipdefendersadvantage = 1;

  if(!isnormalloadouts()) {
    level.disablecopycatloadout = 1;
    setomnvar("_encstr_88D613AE96AFB6D21B8DB12CADAFC6DBC15E1BB0A3", 0);
    level.bypassclasschoicefunc = ::alwaysgamemodeclass;
  } else
    level.disablecopycatloadout = undefined;

  level.calloutmarkerpingvo_doesoperatorsupportalias = removefromlittlebirdmglistondeath();

  if(level.calloutmarkerpingvo_doesoperatorsupportalias) {
    level.playerzombievehiclehittoss = 0.5;
    level.playerzombiewaittillinputreturn = 0.05;
  }

  if(scripts\cp_mp\utility\game_utility::getmapname() == "_encstr_99D9106DE1F95D77B8DB4A03C383FB53708D") {
    level._id_1343F = 1;
    level.brmissionscompleted = getdvarint("_encstr_8EC815CD8D93AF85B1DD2C976EF56E73DEBB99A5CE868E", 0);

    if(level.brmissionscompleted)
      level.practiceround = 0;
    else
      level.practiceround = 1;
  }

  if(getdvarint("_encstr_A2FD0FDB81D68FAE68CB6671A79037BFFB") == 1) {
    level.calloutmarkerpingvo_getcalloutaliasstringworld = 1;
    level._id_136CB = 1;
  } else if(getdvarint("_encstr_96F711C7CF3EF161685975BE3648BCBB9D6377") == 1) {
    level.calloutmarkerpingvo_getcalloutaliasstringloot = 1;
    level._id_136CB = 1;
  }

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
  level.usedspawnposone["_encstr_9A8507BA4040188D08"] = 0;
  level.usedspawnpostwo["_encstr_9A8507BA4040188D08"] = 0;
  level.usedspawnposthree["_encstr_9A8507BA4040188D08"] = 0;
  level.usedspawnposone["_encstr_8E8405EA382B2A"] = 0;
  level.usedspawnpostwo["_encstr_8E8405EA382B2A"] = 0;
  level.usedspawnposthree["_encstr_8E8405EA382B2A"] = 0;
  setomnvar("_encstr_ACA6173B381FB91E3AD3497717A1590BFBC796C2A9C735FB83", 0);
  setomnvar("_encstr_816F151599487B067533F2B9B13B2B0BF060B9AE2114D4", 0);
  setomnvar("_encstr_96DF1B4592613B6B2AE3F6B1015A4D67BF7BF87A6739406B5C899D3633", 100);
  setomnvar("_encstr_AFAE19574BEB2CE4CADC0BAF0BE1A5E6AF86AC58361D347DDA8587", 100);
  setomnvar("_encstr_A1021AAB96D7164EB2DCB0AF0E39A5B658932F2B0B392DB0B9472944", -1);
  setomnvar("_encstr_8C1F1C1BF3F75A22F928E717E8D1EB627D9DE652635D126A2D48E3A3C12D", -1);
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
  setdynamicdvar("_encstr_92D71B7FFB0A693F43D2B05999E76E60A551A3F974B6C0F307CA48E363", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_B8BE11111BAF37387E5CC9DB731C905D5B93AB"));
  setdynamicdvar("_encstr_93B415573F9318B0B29FCDF90989604DEA9F8FD38B0A56", getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_81E30B018548FDEFC6DB7BD2C3"));
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

  if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0)
    level thread setroundwinstreakarray();

  thread adjustroundendtimer();
  thread waittooverridegraceperiod();
  var_5 = 1;

  if(istrue(level._id_1343F)) {
    if(!level.brmissionscompleted && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0 && istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
      level.extratime = 30;
      game["_encstr_A34F0D1D746A8FE84FC721409F9063"] = 1;
      level.arenaloadouts = 3;
      var_5 = 0;
    } else if(level.brmissionscompleted) {
      level.arenaloadouts = 3;
      var_5 = 0;
    }

    level._id_13443["_encstr_8BE007AB0FE8607F9B"] = loadfx("_encstr_AB531FCE99C3CB1BDEE456F25AB51CC26CE8CDBC9BDA2CC636F5CD73B777865AE8");
    level._id_13443["_encstr_852907B9D8C959B2CD"] = loadfx("_encstr_88213814B7AB770857FA6AB09799E3BF219C019FCEB299B83B8B60B863B138418EC30C23294A639B2F8750800FCA5189E2217E26FAD25D03FE83");

    if(!var_5)
      _id_1343F();
  }

  if(var_5) {
    if(israndomloadouts() || usbs_pulled_out() || usb_right() || usb_tape_animation_test())
      thread updaterandomloadout();
    else if(ispickuploadouts()) {
      buildrandomweapontable();

      if(!isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]) || isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]) && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0) {
        level.startweapon.weapon = getrandomweaponforweapontier(level.startweapon.weapon, 1);
        level.arenaweapont1.weapon = getrandomweaponforweapontier(level.arenaweapont1.weapon);
        level.arenaweapont2.weapon = getrandomweaponforweapontier(level.arenaweapont2.weapon);
        level.arenaweapont3.weapon = getrandomweaponforweapontier(level.arenaweapont3.weapon);
        level.arenaweapont4.weapon = getrandomweaponforweapontier(level.arenaweapont4.weapon);
        level.arenaweapont5.weapon = getrandomweaponforweapontier(level.arenaweapont5.weapon);
        level.arenaweapont6.weapon = getrandomweaponforweapontier(level.arenaweapont6.weapon);
        level.arenaweapont7.weapon = getrandomweaponforweapontier(level.arenaweapont7.weapon);
        level.arenaweapont8.weapon = getrandomweaponforweapontier(level.arenaweapont8.weapon);
        level.startweapon.variantid = regroup_at_truck(level.startweapon.weapon);
        level.arenaweapont1.variantid = regroup_at_truck(level.arenaweapont1.weapon);
        level.arenaweapont2.variantid = regroup_at_truck(level.arenaweapont2.weapon);
        level.arenaweapont3.variantid = regroup_at_truck(level.arenaweapont3.weapon);
        level.arenaweapont4.variantid = regroup_at_truck(level.arenaweapont4.weapon);
        level.arenaweapont5.variantid = regroup_at_truck(level.arenaweapont5.weapon);
        level.arenaweapont6.variantid = regroup_at_truck(level.arenaweapont6.weapon);
        level.arenaweapont7.variantid = regroup_at_truck(level.arenaweapont7.weapon);
        level.arenaweapont8.variantid = regroup_at_truck(level.arenaweapont8.weapon);
      } else if(level.loadoutchangeround == 0 || game["_encstr_8DC30DAA0285FD69FAE113371B1934"] % level.loadoutchangeround != 0) {
        level.startweapon.weapon = game["_encstr_9AA50C37D1584E47EA950BC1EDE6"]["_encstr_AC20072B9FA9487832"];
        level.arenaweapont1.weapon = game["_encstr_910F0EF3427758977F4A3903F243C56A"]["_encstr_AC20072B9FA9487832"];
        level.arenaweapont2.weapon = game["_encstr_8F0F0E0BE459732CAB56851CBD9B1523"]["_encstr_AC20072B9FA9487832"];
        level.arenaweapont3.weapon = game["_encstr_A30F0E98F560CD10AF559683DF782BF7"]["_encstr_AC20072B9FA9487832"];
        level.arenaweapont4.weapon = game["_encstr_930F0EF6967B52D957E84F13A028A4BF"]["_encstr_AC20072B9FA9487832"];
        level.arenaweapont5.weapon = game["_encstr_A10F0EA883FF7581EFDD0FFFBF636F9B"]["_encstr_AC20072B9FA9487832"];
        level.arenaweapont6.weapon = game["_encstr_A70F0EBEF53990561F6771E79DAA110C"]["_encstr_AC20072B9FA9487832"];
        level.arenaweapont7.weapon = game["_encstr_AB0F0E5839CA73165DACB00EED738A6E"]["_encstr_AC20072B9FA9487832"];
        level.arenaweapont8.weapon = game["_encstr_960F0EA7A809D81BAFD89F2BC285055A"]["_encstr_AC20072B9FA9487832"];
        level.startweapon.variantid = game["_encstr_9AA50C37D1584E47EA950BC1EDE6"]["_encstr_8A3E0A0D67C353E09EEBD48D"];
        level.arenaweapont1.variantid = game["_encstr_910F0EF3427758977F4A3903F243C56A"]["_encstr_8A3E0A0D67C353E09EEBD48D"];
        level.arenaweapont2.variantid = game["_encstr_8F0F0E0BE459732CAB56851CBD9B1523"]["_encstr_8A3E0A0D67C353E09EEBD48D"];
        level.arenaweapont3.variantid = game["_encstr_A30F0E98F560CD10AF559683DF782BF7"]["_encstr_8A3E0A0D67C353E09EEBD48D"];
        level.arenaweapont4.variantid = game["_encstr_930F0EF6967B52D957E84F13A028A4BF"]["_encstr_8A3E0A0D67C353E09EEBD48D"];
        level.arenaweapont5.variantid = game["_encstr_A10F0EA883FF7581EFDD0FFFBF636F9B"]["_encstr_8A3E0A0D67C353E09EEBD48D"];
        level.arenaweapont6.variantid = game["_encstr_A70F0EBEF53990561F6771E79DAA110C"]["_encstr_8A3E0A0D67C353E09EEBD48D"];
        level.arenaweapont7.variantid = game["_encstr_AB0F0E5839CA73165DACB00EED738A6E"]["_encstr_8A3E0A0D67C353E09EEBD48D"];
        level.arenaweapont8.variantid = game["_encstr_960F0EA7A809D81BAFD89F2BC285055A"]["_encstr_8A3E0A0D67C353E09EEBD48D"];
      } else if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] % level.loadoutchangeround == 0) {
        level.startweapon.weapon = getrandomweaponforweapontier(level.startweapon.weapon, 1);
        level.arenaweapont1.weapon = getrandomweaponforweapontier(level.arenaweapont1.weapon);
        level.arenaweapont2.weapon = getrandomweaponforweapontier(level.arenaweapont2.weapon);
        level.arenaweapont3.weapon = getrandomweaponforweapontier(level.arenaweapont3.weapon);
        level.arenaweapont4.weapon = getrandomweaponforweapontier(level.arenaweapont4.weapon);
        level.arenaweapont5.weapon = getrandomweaponforweapontier(level.arenaweapont5.weapon);
        level.arenaweapont6.weapon = getrandomweaponforweapontier(level.arenaweapont6.weapon);
        level.arenaweapont7.weapon = getrandomweaponforweapontier(level.arenaweapont7.weapon);
        level.arenaweapont8.weapon = getrandomweaponforweapontier(level.arenaweapont8.weapon);
        level.startweapon.variantid = regroup_at_truck(level.startweapon.weapon);
        level.arenaweapont1.variantid = regroup_at_truck(level.arenaweapont1.weapon);
        level.arenaweapont2.variantid = regroup_at_truck(level.arenaweapont2.weapon);
        level.arenaweapont3.variantid = regroup_at_truck(level.arenaweapont3.weapon);
        level.arenaweapont4.variantid = regroup_at_truck(level.arenaweapont4.weapon);
        level.arenaweapont5.variantid = regroup_at_truck(level.arenaweapont5.weapon);
        level.arenaweapont6.variantid = regroup_at_truck(level.arenaweapont6.weapon);
        level.arenaweapont7.variantid = regroup_at_truck(level.arenaweapont7.weapon);
        level.arenaweapont8.variantid = regroup_at_truck(level.arenaweapont8.weapon);
      }

      game["_encstr_9AA50C37D1584E47EA950BC1EDE6"]["_encstr_AC20072B9FA9487832"] = level.startweapon.weapon;
      game["_encstr_910F0EF3427758977F4A3903F243C56A"]["_encstr_AC20072B9FA9487832"] = level.arenaweapont1.weapon;
      game["_encstr_8F0F0E0BE459732CAB56851CBD9B1523"]["_encstr_AC20072B9FA9487832"] = level.arenaweapont2.weapon;
      game["_encstr_A30F0E98F560CD10AF559683DF782BF7"]["_encstr_AC20072B9FA9487832"] = level.arenaweapont3.weapon;
      game["_encstr_930F0EF6967B52D957E84F13A028A4BF"]["_encstr_AC20072B9FA9487832"] = level.arenaweapont4.weapon;
      game["_encstr_A10F0EA883FF7581EFDD0FFFBF636F9B"]["_encstr_AC20072B9FA9487832"] = level.arenaweapont5.weapon;
      game["_encstr_A70F0EBEF53990561F6771E79DAA110C"]["_encstr_AC20072B9FA9487832"] = level.arenaweapont6.weapon;
      game["_encstr_AB0F0E5839CA73165DACB00EED738A6E"]["_encstr_AC20072B9FA9487832"] = level.arenaweapont7.weapon;
      game["_encstr_960F0EA7A809D81BAFD89F2BC285055A"]["_encstr_AC20072B9FA9487832"] = level.arenaweapont8.weapon;
      game["_encstr_9AA50C37D1584E47EA950BC1EDE6"]["_encstr_8A3E0A0D67C353E09EEBD48D"] = level.startweapon.variantid;
      game["_encstr_910F0EF3427758977F4A3903F243C56A"]["_encstr_8A3E0A0D67C353E09EEBD48D"] = level.arenaweapont1.variantid;
      game["_encstr_8F0F0E0BE459732CAB56851CBD9B1523"]["_encstr_8A3E0A0D67C353E09EEBD48D"] = level.arenaweapont2.variantid;
      game["_encstr_A30F0E98F560CD10AF559683DF782BF7"]["_encstr_8A3E0A0D67C353E09EEBD48D"] = level.arenaweapont3.variantid;
      game["_encstr_930F0EF6967B52D957E84F13A028A4BF"]["_encstr_8A3E0A0D67C353E09EEBD48D"] = level.arenaweapont4.variantid;
      game["_encstr_A10F0EA883FF7581EFDD0FFFBF636F9B"]["_encstr_8A3E0A0D67C353E09EEBD48D"] = level.arenaweapont5.variantid;
      game["_encstr_A70F0EBEF53990561F6771E79DAA110C"]["_encstr_8A3E0A0D67C353E09EEBD48D"] = level.arenaweapont6.variantid;
      game["_encstr_AB0F0E5839CA73165DACB00EED738A6E"]["_encstr_8A3E0A0D67C353E09EEBD48D"] = level.arenaweapont7.variantid;
      game["_encstr_960F0EA7A809D81BAFD89F2BC285055A"]["_encstr_8A3E0A0D67C353E09EEBD48D"] = level.arenaweapont8.variantid;
      level.lethaldelay = 0;
      defineplayerloadout();

      if(!istrue(level._id_1343F)) {
        initweaponmap();
        thread setupweapons();
      } else
        _id_1343F();
    } else if(isgungameloadouts()) {
      level.blockweapondrops = 1;
      thread updatearenagungameloadout(0);
    } else if(isrvsgungameloadouts()) {
      level.blockweapondrops = 1;
      thread updatearenagungameloadout(1);
    }
  }

  if(!isnormalloadouts())
    buildloadoutsforweaponstreaming();

  setupwaypointicons();
  seticonnames();

  if(level.objmodifier == 1)
    level setupendzones();

  if(level.spawnflag) {
    var_6 = 0;

    if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0)
      var_6 = 1;

    level thread spawngameendflagzone(var_6);
  }

  physics_raycastents(scripts\mp\gamelogic::gettimeremaining(), 0);

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0) {
      level thread outlineenemyplayers();
      level thread removeenemyoutlines();
    }
  }

  if(!isDefined(game["_encstr_AC020C205BF6E9E5867119815FD1"]))
    game["_encstr_AC020C205BF6E9E5867119815FD1"] = getdvarint("_encstr_825A0BFCD0272981554F5F55A4", 0);

  if(istrue(game["_encstr_AC020C205BF6E9E5867119815FD1"]))
    scripts\cp_mp\vehicles\vehicle_compass::calloutmarkerping_init();
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

  if(level.dogtagsenabled) {
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

  level.arenaloadouts = scripts\mp\utility\dvars::dvarintvalue("_encstr_BD870E859CCACD16267BB023ED5DE8E6", 1, 1, 16);
  level.loadoutchangeround = scripts\mp\utility\dvars::dvarintvalue("_encstr_8A8413E1576E1098FF6375181ABB44C04ABF2B6DC4", 3, 0, 5);
  level.switchspawns = scripts\mp\utility\dvars::dvarintvalue("_encstr_AF4B0D9BBB5AE8D8864D0E0BDD37DC", 1, 0, 1);
  level.wincondition = scripts\mp\utility\dvars::dvarintvalue("_encstr_966E0D67F070833215FD8CC3532F1A", 1, 0, 2);
  setomnvar("_encstr_A96C165BACA7F0C652B3D3A793DA87603F03E39693D93075", level.arenaloadouts);
  setomnvar("_encstr_95B8105F5A1F680FD82E770DCD99F878E898", level.wincondition);
  level.objmodifier = scripts\mp\utility\dvars::dvarintvalue("_encstr_AB4D0C0FA0F8F54A0973578C6D0D", 0, 0, 2);
  level.spawnflag = scripts\mp\utility\dvars::dvarintvalue("_encstr_87EE0A6F2089DF4A3D81E61F", 0, 0, 1);

  if(level.spawnflag) {
    level.ontimelimitgraceperiod = getdvarfloat("_encstr_83AC1DD6662AD971D0EFB686A920B0CD9BA3D7B338717C3A7398F1824F4053", 10.0);
    level.currenttimelimitdelay = 0.0;
    level.canprocessot = 1;
  }

  level.tacticaltimemod = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_B22A108032FEC12DBF59096D39EFC9EBA5CA", 2.5, 0.5, 5);
  level.startweapon = spawnStruct();
  level.arenaweapont1 = spawnStruct();
  level.arenaweapont2 = spawnStruct();
  level.arenaweapont3 = spawnStruct();
  level.arenaweapont4 = spawnStruct();
  level.arenaweapont5 = spawnStruct();
  level.arenaweapont6 = spawnStruct();
  level.arenaweapont7 = spawnStruct();
  level.arenaweapont8 = spawnStruct();
  level.startweapon.weapon = getDvar("_encstr_824D160F078649D920013DC67E10F4625EB117AFEB2FF29E", "_encstr_8BBA05185F8B99");
  level.arenaweapont1.weapon = getDvar("_encstr_A96716DCB127EBB0C9ACCD2CD7BB951607EDDC515ACA2789", "_encstr_B8B311C42CC8F74278DFF7F29998FA43110A4B");
  level.arenaweapont2.weapon = getDvar("_encstr_BA67160328D5F9AF6BAD7671A81367BE39B05AE9D043EAAA", "_encstr_8DE1122D770EFA9BA1AF46832CC1C22664BEB5C1");
  level.arenaweapont3.weapon = getDvar("_encstr_B16716F79F33B810527FE019E93F78EF6BC755310FEAF67A", "_encstr_93D811967783AFB9DAEB5BC1C2E0B0D4F5AD83");
  level.arenaweapont4.weapon = getDvar("_encstr_A567168FFE7E3E116E3D10C8A10B489F313F95BBD8F26B71", "_encstr_A3D91096BB07BEC227BEAD2DB6CAA1FAB6C1");
  level.arenaweapont5.weapon = getDvar("_encstr_8D6716E66CE4BE0B4E95B92CAFDD950BE0F6CD8AB456E44D", "_encstr_8F091280BBC06FBB63BF57D988A321732AC128D0");
  level.arenaweapont6.weapon = getDvar("_encstr_AF6716936E93A78E35E022AA4947C7178BC0060CF399EB83", "_encstr_8BBB0B9D41E718D9E922D8582A");
  level.arenaweapont7.weapon = getDvar("_encstr_9A671602E32B279863CA68F31E4751D2F34FB61F09DAED2B", "_encstr_AD0B110A20CB30F897F120B0BBDB76DBE8D81E");
  level.arenaweapont8.weapon = getDvar("_encstr_A66716F05AF2CF59B3E5B03FC77F017BDA229051924FCD3A", "_encstr_820F114AE740032B7F8680CAD930B1D239F212");
  level.calloutmarkerpingvo_getcalloutaliasstringentity = getdvarint("_encstr_92D71B7FFB0A693F43D2B05999E76E60A551A3F974B6C0F307CA48E363", 0);
  level.calloutmarkerpingvo_getcalloutaliasstringvehicle = getDvar("_encstr_93B415573F9318B0B29FCDF90989604DEA9F8FD38B0A56", "_encstr_8BBA05185F8B99");

  if(level.calloutmarkerpingvo_getcalloutaliasstringvehicle == "_encstr_8BBA05185F8B99")
    setomnvar("_encstr_85D719BDA2513D8067493554C147D51FE9044365D9D406F794FA0A", 1);
}

getrandomweaponforweapontier(var_0, var_1) {
  if(issubstr(var_0, "_encstr_8F1F052AC9E5A2")) {
    if(var_0 == "_encstr_A31207CBF788523281")
      var_0 = getrandomspawnweapon();
    else
      var_0 = getrandomweaponfromcategory(var_0, var_1);
  }

  return var_0;
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
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

  var_3 = scripts\mp\spawnlogic::getspawnpointarray(level.spawntype);
  var_4 = scripts\mp\spawnlogic::getspawnpointarray(level.spawntype);
  scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", var_3);
  scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", var_4);
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
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");
  var_0 = undefined;
  var_1 = level.axisstartspawn;
  var_2 = 0;

  if(self.pers["_encstr_8AEF05472BC2D6"] == game["_encstr_991C0AB9ED5B57161FE89B83"])
    var_1 = level.alliesstartspawn;

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn() || istrue(level.alwaysusestartspawns) || dotournamentendgame()) {
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8AEF0B35A3C227D19A38C2BBCD", "_encstr_829A0D0F1AF8FB5ED127855073F940");
    var_3 = scripts\mp\spawnlogic::getspawnpointarray(var_1);

    if(istrue(level.switchspawns) && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] > 0) {
      var_4 = scripts\mp\utility\teams::getteamcount(self.pers["_encstr_8AEF05472BC2D6"]);

      if(var_4 > 3) {
        foreach(var_6 in scripts\mp\utility\teams::getteamdata(self.pers["_encstr_8AEF05472BC2D6"], "_encstr_9775086022BE1B413B8B")) {
          if(isDefined(var_6.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"]))
            var_6.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] = "_encstr_934C0218";
        }

        var_2 = 1;
      }
    }

    if(istrue(level.switchspawns) && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] > 0 && !var_2) {
      if(self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] == "_encstr_A34C02BB")
        self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] = "_encstr_A74C0222";
      else if(scripts\mp\utility\teams::getteamcount(self.pers["_encstr_8AEF05472BC2D6"], 0) == 3 && istrue(level.hasthreespawns) && self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] == "_encstr_A74C0222")
        self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] = "_encstr_A14C023B";
      else if(self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] == "_encstr_A14C023B")
        self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] = "_encstr_A34C02BB";
      else
        self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] = "_encstr_A34C02BB";

      var_0 = getswitchside_spawnpoint(var_3, self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"]);
    }

    if(!isDefined(var_0)) {
      if(istrue(self.switching_teams_arena) && isDefined(self.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"])) {
        cleanupspawn_scriptnoteworthy();
        var_0 = getspawnpoint_startspawn(var_3);
        self.switching_teams_arena = undefined;

        if(isDefined(var_0))
          self._id_13685 = var_0.angles;
      } else {
        var_0 = getspawnpoint_startspawn(var_3);

        if(isDefined(var_0))
          self._id_13685 = var_0.angles;
      }

      if(!isDefined(var_0)) {
        var_4 = scripts\mp\utility\teams::getteamcount(self.pers["_encstr_8AEF05472BC2D6"]);

        if(var_4 > 3) {
          var_8 = undefined;
          var_9 = 0;

          foreach(var_6 in scripts\mp\utility\teams::getteamdata(self.pers["_encstr_8AEF05472BC2D6"], "_encstr_9775086022BE1B413B8B")) {
            if(istrue(var_6.fine_drop_pos)) {
              var_9++;
              continue;
            }

            break;
          }

          foreach(var_6 in scripts\mp\utility\teams::getteamdata(self.pers["_encstr_8AEF05472BC2D6"], "_encstr_9775086022BE1B413B8B")) {
            if(var_6 == self) {
              continue;
            }
            if(istrue(var_6.fine_drop_pos)) {
              continue;
            }
            if(!istrue(var_6.hasspawned)) {
              continue;
            }
            if(isDefined(var_6.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"])) {
              if(level.usedspawnposone[self.pers["_encstr_8AEF05472BC2D6"]] == 1 && level.usedspawnpostwo[self.pers["_encstr_8AEF05472BC2D6"]] == 1 && level.usedspawnposthree[self.pers["_encstr_8AEF05472BC2D6"]] == 1) {
                level.usedspawnposone[self.pers["_encstr_8AEF05472BC2D6"]] = 0;
                level.usedspawnpostwo[self.pers["_encstr_8AEF05472BC2D6"]] = 0;
                level.usedspawnposthree[self.pers["_encstr_8AEF05472BC2D6"]] = 0;
              }

              if(var_6.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] == "_encstr_A34C02BB" && level.usedspawnposone[self.pers["_encstr_8AEF05472BC2D6"]] == 0) {
                level.usedspawnposone[self.pers["_encstr_8AEF05472BC2D6"]]++;
                var_6.fine_drop_pos = 1;
                var_8 = var_6;
                break;
              } else if(var_6.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] == "_encstr_A74C0222" && level.usedspawnpostwo[self.pers["_encstr_8AEF05472BC2D6"]] == 0) {
                level.usedspawnpostwo[self.pers["_encstr_8AEF05472BC2D6"]]++;
                var_6.fine_drop_pos = 1;
                var_8 = var_6;
                break;
              } else if(var_6.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] == "_encstr_A14C023B" && level.usedspawnposthree[self.pers["_encstr_8AEF05472BC2D6"]] == 0) {
                level.usedspawnposthree[self.pers["_encstr_8AEF05472BC2D6"]]++;
                var_6.fine_drop_pos = 1;
                var_8 = var_6;
                break;
              } else {
                level.usedspawnposone[self.pers["_encstr_8AEF05472BC2D6"]]++;
                var_6.fine_drop_pos = 1;
                var_8 = var_6;
                break;
              }
            }
          }

          if(isDefined(var_8)) {
            var_0 = scripts\mp\spawnscoring::findteammatebuddyspawn(var_8);

            if(isDefined(var_8._id_13685))
              var_0.angles = var_8._id_13685;
          }
        }
      }

      if(!isDefined(var_0)) {
        scripts\mp\spawnlogic::activatespawnset("_encstr_820E07FAE8780B3A4C");
        var_0 = scripts\mp\spawnlogic::getspawnpoint(self, self.pers["_encstr_8AEF05472BC2D6"], "_encstr_820E07FAE8780B3A4C", "_encstr_AD0C095DF195E8B6074A18");
      }

      if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy != "_encstr_B40101" && istrue(level.switchspawns) && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0)
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
  if(istrue(level.allowkillstreaks))
    level.allowkillstreaks = 0;

  var_0.arenadamage = 0;
  var_0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var_0.pers["_encstr_B2BE0788BAF573592F"]))
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["_encstr_B2BE0788BAF573592F"]);

  if(!isnormalloadouts()) {
    var_0 setclientomnvar("_encstr_8E8510ABB0472A5FC0DFBFB478E92B754B30", 1);
    var_0.pers["_encstr_959506B911C79707"] = "_encstr_AAAC09D09972B9C83F2B7F";
    var_0.pers["_encstr_92690A5B078ED325F539E25E"] = "_encstr_B40101";
    var_0.class = var_0.pers["_encstr_959506B911C79707"];
    var_0.lastclass = var_0.pers["_encstr_92690A5B078ED325F539E25E"];

    if(israndomloadouts() || usbs_pulled_out() || usb_right() || usb_tape_animation_test())
      var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]];
    else if(ispickuploadouts())
      var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.arena_loadouts["_encstr_8E8405EA382B2A"];

    if(isgungameloadouts() || isrvsgungameloadouts()) {
      var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][getgungameloadoutindex(var_0)];

      if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0)
        var_0 setenemyloadoutomnvars();
    }

    foreach(var_2 in level.teamnamelist) {
      if(isDefined(var_0.pers["_encstr_8AEF05472BC2D6"]) && game["_encstr_82330FE47BAB7346AEA5734DE89C590BAD"][var_2] > 0 && var_0.pers["_encstr_8AEF05472BC2D6"] == var_2) {
        var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_A6741E660FB7A8A1BBE20819CB0A6B811798EE53958F53C3964A18F0E1E71B58"] = var_2;
        var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_97081A4EB7ABCD23EA5AE6A6E8E42B58D6149C5AB68539970D2C6B7B"] = _id_131BD();
        var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_AC711F781AB32D79A76930A66CEB81FB9C027808628F6BF337AB4FA15F1BC943C5"] = var_2;
        var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_A3AF1CC2E88B820C8738C3CF28DBC5BA6F6E8F3E40D55A510B907F0FC850"] = _id_131BD();
      }
    }
  }

  if(istrue(level.switchspawns) && !isDefined(var_0.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"]))
    var_0.pers["_encstr_B25E10B0DB3A72CE8F139B8A541E619BCF28"] = "_encstr_934C0218";

  var_0 thread onjoinedteam();

  if(!isnormalloadouts())
    var_0 updatehighpriorityweapons();

  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);

  if(istrue(game["_encstr_AC020C205BF6E9E5867119815FD1"]))
    var_0 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_initplayer();
}

onplayerdisconnect(var_0) {
  _id_131CB(1);

  if(istrue(game["_encstr_AC020C205BF6E9E5867119815FD1"])) {
    var_1 = 1;

    foreach(var_3 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamcount(var_3) > 4) {
        var_1 = 0;
        break;
      }
    }

    setDvar("_encstr_825A0BFCD0272981554F5F55A4", var_1);
  }
}

onjoinedteam() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    scripts\engine\utility::_id_143A5("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
    _id_131CB();
  }
}

onspawnplayer() {
  thread onspawnfinished();
  level notify("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  thread updatematchstatushintonspawn();
  scripts\mp\menus::updatesquadomnvars(self.team, self.squadindex);
}

onspawnfinished() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"]) || istrue(level.brmissionscompleted))
    thread _id_13441();

  thread damagewatcher();

  if(!isnormalloadouts()) {
    self waittill("_encstr_B2030CA0C91D2F44C0B314F8836B");
    runarenaloadoutrulesonplayer();
  }

  thread modifyblastshieldperk();

  if(level.calloutmarkerpingvo_doesoperatorsupportalias)
    scripts\mp\utility\perk::giveperk("_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F");

  wait 0.1;
  self.hasarenaspawned = 1;
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

_id_131CB(var_0) {
  var_1 = getdvarint("_encstr_856E15E68D93D7E0D80BF25639FADA163CA1AC0B8DD134", 100);
  var_2 = scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_AB580A05672AE35D5FFF50B8");

  if(var_2) {
    level.alliesmaxhealth = scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_AB580A05672AE35D5FFF50B8") * var_1;
    setomnvar("_encstr_96DF1B4592613B6B2AE3F6B1015A4D67BF7BF87A6739406B5C899D3633", level.alliesmaxhealth);

    if(!istrue(var_0) && !scripts\mp\utility\player::isreallyalive(self) && scripts\mp\playerlogic::mayspawn())
      self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

    var_3 = 0;

    foreach(var_5 in scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_9775086022BE1B413B8B"))
    var_3 = var_3 + var_5.health;

    level.allieshealth = var_3;

    if(level.allieshealth < 0)
      level.allieshealth = 0;

    setomnvar("_encstr_ACA6173B381FB91E3AD3497717A1590BFBC796C2A9C735FB83", level.allieshealth);
  } else
    setomnvar("_encstr_ACA6173B381FB91E3AD3497717A1590BFBC796C2A9C735FB83", 0);

  var_7 = scripts\mp\utility\teams::getteamdata("_encstr_8E8405EA382B2A", "_encstr_AB580A05672AE35D5FFF50B8");

  if(var_7) {
    level.axismaxhealth = scripts\mp\utility\teams::getteamdata("_encstr_8E8405EA382B2A", "_encstr_AB580A05672AE35D5FFF50B8") * var_1;
    setomnvar("_encstr_AFAE19574BEB2CE4CADC0BAF0BE1A5E6AF86AC58361D347DDA8587", level.axismaxhealth);

    if(!istrue(var_0) && !scripts\mp\utility\player::isreallyalive(self) && scripts\mp\playerlogic::mayspawn())
      self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

    var_8 = 0;

    foreach(var_5 in scripts\mp\utility\teams::getteamdata("_encstr_8E8405EA382B2A", "_encstr_9775086022BE1B413B8B"))
    var_8 = var_8 + var_5.health;

    level.axishealth = var_8;

    if(level.axishealth < 0)
      level.axishealth = 0;

    setomnvar("_encstr_816F151599487B067533F2B9B13B2B0BF060B9AE2114D4", level.axishealth);
  } else
    setomnvar("_encstr_816F151599487B067533F2B9B13B2B0BF060B9AE2114D4", 0);
}

modifyblastshieldperk() {
  var_0 = scripts\mp\utility\dvars::dvarintvalue("_encstr_BA940F98C6C29B8EA90D5A563623A6B7C8", 65, 0, 100) / 100;

  if(var_0 == 0)
    scripts\mp\utility\perk::removeperk("_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19");
}

onplayerdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(var_1) && var_1 != var_2 && isPlayer(var_1)) {
    if(istrue(level._id_1343F) && (var_6.basename == "_encstr_BA410C6338E0D79EC39832198839" || var_6.basename == "_encstr_8183093B28FB2D83C69150"))
      playfxontagforclients(level._id_13443["_encstr_852907B9D8C959B2CD"], var_2, "_encstr_A130084D2FDAD8AA8F62", var_2);

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

  if(!isnormalloadouts()) {
    if(isbot(var_0))
      var_0.classcallback = "_encstr_AAAC09D09972B9C83F2B7F";
  }

  if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060")
    var_1.finalkill = 1;
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  scripts\mp\menus::updatesquadomnvars(self.team, self.squadindex);

  if(!isnormalloadouts()) {
    if(isbot(self))
      self.classcallback = "_encstr_AAAC09D09972B9C83F2B7F";
  }

  if(isDefined(var_1) && (var_4.basename == "_encstr_BA410C6338E0D79EC39832198839" || var_4.basename == "_encstr_8183093B28FB2D83C69150"))
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_B42B0E0765402CB5E13138DE02608261");

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
  if(level.gameended) {
    return;
  }
  physics_raycastents(scripts\mp\gamelogic::gettimeremaining(), 3);

  if(level.wincondition == 1)
    checkliveswinner();
  else if(level.wincondition == 2)
    checkhealthwinner();
  else
    checkhealthwinner();
}

ontimelimitot() {
  physics_raycastents(scripts\mp\gamelogic::gettimeremaining(), 1);
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
    if(dotournamentendgame()) {
      game["_encstr_AD3F0EB158739AC6EDE456F43751B495"] = 1;

      if(game["_encstr_96DF0BCC92723B8A59E7F338A1"] == 1) {
        game["_encstr_AD3F0EB158739AC6EDE456F43751B495"] = 0;

        if(!isDefined(game["_encstr_ADA20B93DEBA7346378AD2B219"]))
          game["_encstr_ADA20B93DEBA7346378AD2B219"] = 1;
        else
          game["_encstr_ADA20B93DEBA7346378AD2B219"]++;

        if(game["_encstr_ADA20B93DEBA7346378AD2B219"] >= 2) {
          var_0 = scripts\mp\gamelogic::getbetterteam();
          thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AF071919AA5D488FB19B8FB3AB8AC7E8F5052356D389D8A86B9795"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_99F91A2C27959B0BD7D1DE579CDC2CDAB2DCA3D7474BB2EBD8ED9B37"]);
        } else
          thread arena_endgame("_encstr_8D19048EA595", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
      } else
        thread arena_endgame("_encstr_8D19048EA595", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AF9C0A077B223BF35F4BF34B"]);
    } else {
      if(!isDefined(game["_encstr_ADA20B93DEBA7346378AD2B219"]))
        game["_encstr_ADA20B93DEBA7346378AD2B219"] = 1;
      else
        game["_encstr_ADA20B93DEBA7346378AD2B219"]++;

      game["_encstr_AD3F0EB158739AC6EDE456F43751B495"] = game["_encstr_ADA20B93DEBA7346378AD2B219"] >= 2;

      if(game["_encstr_AD3F0EB158739AC6EDE456F43751B495"])
        thread arena_endgame("_encstr_8D19048EA595", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AF9C0A077B223BF35F4BF34B"]);
      else
        thread arena_endgame("_encstr_8D19048EA595", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
    }
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

checkshouldallowtradekilltie(var_0) {
  var_1 = [];

  foreach(var_3 in level.teamnamelist)
  var_1[var_3] = 0;

  foreach(var_6 in level.players) {
    if(!istrue(var_6.hasspawned) || var_6.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_6.team == "_encstr_933E090A10B17DDFB3E522") {
      continue;
    }
    var_1[var_6.team] = var_1[var_6.team] + var_6.pers["_encstr_8CAA06DB20A31543"];
  }

  var_8 = 0;

  foreach(var_3 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(var_3, "_encstr_8A2A0B936CCCC3078547970A8B")) {
      var_8 = 1;
      break;
    }
  }

  var_11 = 0;

  foreach(var_13 in var_1) {
    if(var_13) {
      var_11 = 1;
      break;
    }
  }

  if(!var_8 && !var_11)
    return "_encstr_8D19048EA595";

  foreach(var_3 in level.teamnamelist) {
    if(!scripts\mp\utility\teams::getteamdata(var_3, "_encstr_8A2A0B936CCCC3078547970A8B") && !var_1[var_3]) {
      if(level.multiteambased) {
        if(!scripts\mp\utility\teams::getteamdata(var_3, "_encstr_8B340BAAD957B3BA5DD33DBB1B") && scripts\mp\utility\teams::getteamdata(var_3, "_encstr_A1310B432F9BDEFBEF4393B0F1")) {
          scripts\mp\utility\teams::setteamdata(var_3, "_encstr_8B340BAAD957B3BA5DD33DBB1B", 1);
          return var_0;
        }
      } else
        return var_0;
    }
  }

  foreach(var_3 in level.teamnamelist) {
    var_18 = scripts\mp\utility\teams::getteamdata(var_3, "_encstr_8A2A0B936CCCC3078547970A8B") == 1;

    if(var_18) {
      var_19 = 0;
      var_20 = undefined;
      var_21 = scripts\mp\utility\teams::getteamdata(var_3, "_encstr_9775086022BE1B413B8B");

      foreach(var_6 in var_21) {
        if(!isalive(var_6))
          var_19 = var_19 + var_6.pers["_encstr_8CAA06DB20A31543"];
      }

      if(var_19 == 0) {
        if(!scripts\mp\utility\teams::getteamdata(var_3, "_encstr_A63208900AB769596374") && gettime() > scripts\mp\utility\teams::getteamdata(var_3, "_encstr_AC610CF033ED0C4B1A6B45D30502") + 5000) {
          scripts\mp\utility\teams::setteamdata(var_3, "_encstr_AC610CF033ED0C4B1A6B45D30502", gettime());
          scripts\mp\utility\teams::setteamdata(var_3, "_encstr_A63208900AB769596374", 1);

          if(var_21.size > 1)
            return var_0;
        }
      }

      continue;
    }

    scripts\mp\utility\teams::setteamdata(var_3, "_encstr_A63208900AB769596374", 0);
  }

  return var_0;
}

arena_endgame(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 != "_encstr_8D19048EA595") {
    if(istrue(level.nukeincoming)) {
      return;
    }
    waittillframeend;
    var_0 = checkshouldallowtradekilltie(var_0);
  }

  if(isgungameloadouts() || isrvsgungameloadouts())
    level setenemyloadoutomnvarsatmatchend(var_0);

  if(var_0 != "_encstr_8D19048EA595") {
    game["_encstr_ADA20B93DEBA7346378AD2B219"] = 0;
    game["_encstr_BDC61457F23A85480F8FC8F1E756E0F3F2DFDD558E12"] = var_0;

    foreach(var_6 in level.teamnamelist) {
      if(var_6 == var_0) {
        game["_encstr_82330FE47BAB7346AEA5734DE89C590BAD"][var_0]++;
        continue;
      }

      game["_encstr_82330FE47BAB7346AEA5734DE89C590BAD"][var_6] = 0;
    }

    if(!scripts\mp\utility\game::iswinbytworulegametype()) {
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
    }

    if(game["_encstr_96DF0BCC92723B8A59E7F338A1"] == 1) {
      if(game["_encstr_82330FE47BAB7346AEA5734DE89C590BAD"][var_0] > 3)
        game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A61E1037C8EBFB1A4FA0497A157FF2B5B370"] = "_encstr_A36C17CE2CDACAB93A2C3AB2F5BBB4E6F51BDB6B5998B0C6DA";
    }
  } else
    game["_encstr_BDC61457F23A85480F8FC8F1E756E0F3F2DFDD558E12"] = "_encstr_B40101";

  scripts\cp_mp\pet_watch::_id_13FBD();
  thread scripts\mp\gamelogic::endgame(var_0, var_1, var_2, var_3, var_4);
}

setroundwinstreakarray() {
  foreach(var_1 in level.teamnamelist)
  game["_encstr_82330FE47BAB7346AEA5734DE89C590BAD"][var_1] = 0;
}

_id_12043(var_0) {
  if(istrue(game["_encstr_AC020C205BF6E9E5867119815FD1"])) {
    var_1 = 1;

    foreach(var_3 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamcount(var_3) > 4) {
        var_1 = 0;
        break;
      }
    }

    setDvar("_encstr_825A0BFCD0272981554F5F55A4", var_1);
  }
}

runarenaloadoutrulesonplayer() {
  if(israndomloadouts() || israndompreviewloadouts() || usb_right() || usb_tape_animation_test()) {
    if(israndompreviewloadouts()) {
      if(self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] == "_encstr_8BBA05185F8B99")
        scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
    }
  } else if(ispickuploadouts()) {
    if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0)
      wait 0.1;
    else
      wait 0.25;

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
    if(level.startweapon.weapon == "_encstr_8BBA05185F8B99") {
      var_0 = "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C";
      var_1 = getcompleteweaponname(var_0);
      var_0 = createheadicon(var_1);
    } else if(issubstr(level.startweapon.weapon, "_encstr_84D7067AA0C37CE3")) {
      var_0 = "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C";
      var_1 = getcompleteweaponname(var_0);
      var_0 = createheadicon(var_1);
    } else {
      var_2 = scripts\mp\utility\weapon::getweaponrootname(level.startweapon.weapon);
      var_3 = [];
      var_4 = "_encstr_8BBA05185F8B99";
      var_5 = "_encstr_8BBA05185F8B99";
      var_6 = undefined;
      var_7 = undefined;
      var_8 = undefined;
      var_9 = undefined;

      if(istrue(level._id_136CB)) {
        var_4 = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"];
        var_8 = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_96312155DF03770863F979C678AFBE024B219FA36DD21B383270F36308C9BC3D578EFD"];
        var_9[0] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_B6FC168DDB85197B5D471439D2DA2C27F2A9A3A58DB6B227"];
        var_9[1] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_91D217989706EACF1D63D7326AE3D33D398E6368A60A97029F"];
        var_9[2] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_8ED217397721CB9863CBFF8BFB079FB890BE63ACCF971A3522"];
        var_9[3] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_B8D21763FFE7E52FFB99EB46A9B9109AC7EF131BE1FC0F4A5F"];
      } else if(istrue(level.setplayerselfrevivingextrainfo)) {
        var_4 = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"];
        var_8 = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_96312155DF03770863F979C678AFBE024B219FA36DD21B383270F36308C9BC3D578EFD"];
        var_9[0] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_B6FC168DDB85197B5D471439D2DA2C27F2A9A3A58DB6B227"];
        var_9[1] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_91D217989706EACF1D63D7326AE3D33D398E6368A60A97029F"];
        var_9[2] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_8ED217397721CB9863CBFF8BFB079FB890BE63ACCF971A3522"];
        var_9[3] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_B8D21763FFE7E52FFB99EB46A9B9109AC7EF131BE1FC0F4A5F"];
      }

      if(updatec4vehiclemultkill())
        var_1 = scripts\mp\class::fixcollision(var_2, var_4, var_5, level.startweapon.variantid, var_7, var_8, var_9);
      else
        var_1 = scripts\mp\class::buildweapon(var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

      var_0 = createheadicon(var_1);
      level.takefists = 1;
    }

    level.loadweapons[level.loadweapons.size] = var_1;
  } else {
    var_10 = [];
    var_11 = [];
    var_12 = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]];
    var_13 = var_12["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"];
    var_14 = var_12["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"];

    if(var_13 != "_encstr_8BBA05185F8B99")
      var_10[var_10.size] = buildprimaries(var_13, var_12, 1);

    if(var_14 != "_encstr_8BBA05185F8B99")
      var_11[var_11.size] = buildsecondaries(var_14, var_12, 1);

    if(level.loadoutchangeround != 0) {
      var_15 = game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"] + 1;

      if(game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"] == game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"].size - 1)
        var_15 = 0;

      var_16 = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][var_15];
      var_17 = var_16["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"];
      var_18 = var_16["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"];

      if(var_17 != "_encstr_8BBA05185F8B99")
        var_10[var_10.size] = buildprimaries(var_17, var_16);

      if(var_18 != "_encstr_8BBA05185F8B99")
        var_11[var_11.size] = buildsecondaries(var_18, var_16);
    }

    level.loadweapons = scripts\engine\utility::array_combine(var_10, var_11);
  }
}

buildprimaries(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 1; var_4 < 6; var_4++) {
    var_5 = var_4;

    if(var_4 == 1)
      var_5 = "_encstr_B40101";

    var_6 = var_1["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878" + var_5];

    if(var_6 != "_encstr_8BBA05185F8B99")
      var_3[var_3.size] = var_6;
  }

  var_7 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_8 = "_encstr_8BBA05185F8B99";
  var_9 = "_encstr_8BBA05185F8B99";
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;
  var_13 = undefined;

  if(istrue(level._id_136CB) && istrue(var_2)) {
    var_8 = rotate_silo_gyro_lights();
    game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = var_8;

    if(_id_140DC(var_0)) {
      var_12 = rotateeffect();
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_96312155DF03770863F979C678AFBE024B219FA36DD21B383270F36308C9BC3D578EFD"] = var_12;
    }

    if(_id_140DD(var_0)) {
      var_13 = rotateplayer();
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_B6FC168DDB85197B5D471439D2DA2C27F2A9A3A58DB6B227"] = var_13[0];
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_91D217989706EACF1D63D7326AE3D33D398E6368A60A97029F"] = var_13[1];
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_8ED217397721CB9863CBFF8BFB079FB890BE63ACCF971A3522"] = var_13[2];
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_B8D21763FFE7E52FFB99EB46A9B9109AC7EF131BE1FC0F4A5F"] = var_13[3];
    }
  } else if(istrue(level.setplayerselfrevivingextrainfo)) {
    var_8 = rotate_silo_gyro_lights();
    game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = var_8;

    if(_id_140DC(var_0)) {
      var_12 = rotateeffect();
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_96312155DF03770863F979C678AFBE024B219FA36DD21B383270F36308C9BC3D578EFD"] = var_12;
    }

    if(_id_140DD(var_0)) {
      var_13 = rotateplayer();
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_B6FC168DDB85197B5D471439D2DA2C27F2A9A3A58DB6B227"] = var_13[0];
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_91D217989706EACF1D63D7326AE3D33D398E6368A60A97029F"] = var_13[1];
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_8ED217397721CB9863CBFF8BFB079FB890BE63ACCF971A3522"] = var_13[2];
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_B8D21763FFE7E52FFB99EB46A9B9109AC7EF131BE1FC0F4A5F"] = var_13[3];
    }
  }

  var_14 = scripts\mp\class::buildweapon(var_7, var_3, var_8, var_9, var_10, var_11, var_12, var_13);
  var_15 = createheadicon(var_14);
  return var_15;
}

buildsecondaries(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 1; var_4 < 6; var_4++) {
    var_5 = var_4;

    if(var_4 == 1)
      var_5 = "_encstr_B40101";

    var_6 = var_1["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB" + var_5];

    if(var_6 != "_encstr_8BBA05185F8B99")
      var_3[var_3.size] = var_6;
  }

  var_7 = "_encstr_8BBA05185F8B99";
  var_8 = "_encstr_8BBA05185F8B99";
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;

  if(istrue(level._id_136CB) && istrue(var_2)) {
    var_7 = rotate_silo_gyro_lights();
    game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = var_7;

    if(_id_140DC(var_0)) {
      var_11 = rotateeffect();
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_9595235890C7B9771BDD9B2F9BDFF5BB2263E1B7D89B7B431340776318E9BF6ABAB9EF550B"] = var_11;
    }

    if(_id_140DD(var_0)) {
      var_12 = rotateplayer();
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_9BB9182BB7D71132DB69D990F7D29E302EAB832FD37FD6EA9302"] = var_12[0];
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_872219FD502BAA9F5B584F9F08F0467283765EBA454392D361703E"] = var_12[1];
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_81221930EF31C19713239E9DFEEACD89992310516BC1F9573ACA26"] = var_12[2];
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_88221919F53AE1C855CB89208F972029C25A0B0E8B12B7302DFB82"] = var_12[3];
    }
  } else if(istrue(level.setplayerselfrevivingextrainfo) && istrue(var_2)) {
    var_7 = rotate_silo_gyro_lights();
    game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = var_7;

    if(_id_140DC(var_0)) {
      var_11 = rotateeffect();
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_9595235890C7B9771BDD9B2F9BDFF5BB2263E1B7D89B7B431340776318E9BF6ABAB9EF550B"] = var_11;
    }

    if(_id_140DD(var_0)) {
      var_12 = rotateplayer();
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_9BB9182BB7D71132DB69D990F7D29E302EAB832FD37FD6EA9302"] = var_12[0];
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_872219FD502BAA9F5B584F9F08F0467283765EBA454392D361703E"] = var_12[1];
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_81221930EF31C19713239E9DFEEACD89992310516BC1F9573ACA26"] = var_12[2];
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"]]["_encstr_88221919F53AE1C855CB89208F972029C25A0B0E8B12B7302DFB82"] = var_12[3];
    }
  }

  var_13 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_14 = scripts\mp\class::buildweapon(var_13, var_3, var_7, var_8);
  var_15 = createheadicon(var_14);
  return var_15;
}

rotate_silo_gyro_lights() {
  var_0 = "_encstr_8BBA05185F8B99";

  if(istrue(level.calloutmarkerpingvo_getcalloutaliasstringworld)) {
    var_1 = ["_encstr_84C809D2E83B05A7D3D4AF", "_encstr_97C809D9EED5C010C71603", "_encstr_87C809470B71329F3AB234", "_encstr_83C8091962C7D8912A508B", "_encstr_9BC809DF3FF0A87172B3D8", "_encstr_97C809D9EED5C010C71603"];
    var_0 = scripts\engine\utility::random(var_1);
  } else if(istrue(level.calloutmarkerpingvo_getcalloutaliasstringloot)) {
    var_1 = ["_encstr_96C8098FDBB937AFFBB2FA", "_encstr_8DC80947E1257BD8B23F29", "_encstr_8DC80947E1257BD8B23F29", "_encstr_ACC809C616AD7BF518E45A"];
    var_0 = scripts\engine\utility::random(var_1);
  } else if(istrue(level.setplayerselfrevivingextrainfo)) {
    var_1 = ["_encstr_93C8094FC868A739B14DC4", "_encstr_91C809D82CB6EDFA067098", "_encstr_A7C80919BE7B70B719DA47", "_encstr_A3C8096A71E9DFB1EA0312", "_encstr_9AC809AF21A9F7D7EB5269", "_encstr_B1C8095E91471847B20730", "_encstr_8BC8093BF7A80D4FAAC77B", "_encstr_83C8091962C7D8912A508B", "_encstr_9BC809DF3FF0A87172B3D8"];
    var_0 = scripts\engine\utility::random(var_1);
  }

  return var_0;
}

_id_140DC(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  return var_1 != "_encstr_8EF4120387DA5772B528A25C906463B05F38F38F" && var_1 != "_encstr_87610AB4EE83FAD6374B3395" && var_1 != "_encstr_A7ED0AD79F73990E28334B92" && var_1 != "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C" && var_1 != "_encstr_9B031467F4EAE7ADE56E91CFF3656002AE6B3129F5AB" && var_1 != "_encstr_B6BD13609368A9E10A1FABA7DF52BEE0CAAD6B18FB" && var_1 != "_encstr_9A0D0C4B54606F8F63C84B8B53EE" && var_1 != "_encstr_A5090EB4DD83D78D16BE3B4EED5BACB7" && var_1 != "_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59" && var_1 != "_encstr_A3EF0E518C324F35EBD9CA8250CB3A22" && var_1 != "_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB" && var_1 != "_encstr_97EF0EA5BB70FA1BB0AFD4D56396593A" && var_1 != "_encstr_A2A80D2D771CBE8D58EBDA9D7B8D33";
}

_id_140DD(var_0) {
  return var_0 != "_encstr_BED80D7C9C59D95BF870DBDFA9F018" && var_0 != "_encstr_A51417EC0CC949AD69315777A8409AF2D5297627FD8781E593" && var_0 != "_encstr_9BE916CAE02981E7E1E821539B8893D5C590B332600FC54B";
}

rotateeffect() {
  var_0 = "_encstr_8BBA05185F8B99";

  if(istrue(level.calloutmarkerpingvo_getcalloutaliasstringworld)) {
    var_1 = ["_encstr_A5F308E35D1B718A52F5", "_encstr_ACF30887709B67C227FB", "_encstr_ADF30810B77BEE61AF3A", "_encstr_92F3088DBDE6EBC8C9C9"];
    var_0 = scripts\engine\utility::random(var_1);
  } else if(istrue(level.calloutmarkerpingvo_getcalloutaliasstringloot)) {
    var_1 = ["_encstr_93F308F62787A635184F", "_encstr_A1F308D87BCDF5C89346", "_encstr_A7F3086F675BEF1220EE", "_encstr_83F308C6A8C7D119AB82"];
    var_0 = scripts\engine\utility::random(var_1);
  } else if(istrue(level.setplayerselfrevivingextrainfo)) {
    var_1 = ["_encstr_8BF308420897B9A662C7", "_encstr_84F30851A06BC01FFB8A", "_encstr_A1F308D87BCDF5CC9366", "_encstr_83F308C6A8C7D11B2AB2", "_encstr_93F308F62787A637DB0F", "_encstr_BEF3081E781B51131217", "_encstr_82F308C207DFB9DF8B73", "_encstr_B6F3088BDDE76FDAFAEA", "_encstr_99F3086CEDCDFA03C8C6", "_encstr_8BF308420897B9AA0347", "_encstr_95F30802379221026AC3"];
    var_0 = scripts\engine\utility::random(var_1);
  }

  return var_0;
}

rotateplayer() {
  var_0 = [];

  if(istrue(level.calloutmarkerpingvo_getcalloutaliasstringworld)) {
    var_1 = ["_encstr_9A710EF918E35BDC4720224B993D0286", "_encstr_8C710E548A63D113E95FBDB65F032E2F", "_encstr_97710E4BE5CDA3B4B1ADAC4ED7261898", "_encstr_B1710E2498E00CE2DEBFF793EFDF0F04"];
    var_0[var_0.size] = scripts\engine\utility::random(var_1);
    var_0[var_0.size] = scripts\engine\utility::random(var_1);
    var_0[var_0.size] = scripts\engine\utility::random(var_1);
    var_0[var_0.size] = scripts\engine\utility::random(var_1);
  } else if(istrue(level.calloutmarkerpingvo_getcalloutaliasstringloot)) {
    var_1 = ["_encstr_B6710E2D5E6EE8A56C6D95397D23D0C6", "_encstr_AB710E17A8BB411BB8A2C5F35FAA5892", "_encstr_99710E08CE3AACB0A760E8CD891B2B12"];
    var_0[var_0.size] = scripts\engine\utility::random(var_1);
    var_0[var_0.size] = scripts\engine\utility::random(var_1);
    var_0[var_0.size] = scripts\engine\utility::random(var_1);
    var_0[var_0.size] = scripts\engine\utility::random(var_1);
  } else if(istrue(level.setplayerselfrevivingextrainfo)) {
    var_1 = ["_encstr_B1710E2498E00CE2DEBFF793EFDE4F02", "_encstr_97710E4BE5CDA3B4B1ADAC4ED7469A99", "_encstr_BA710E927AE7E35F995A8D9278AB1E7A", "_encstr_99710E08CE3AACB0A760E8CD897B2A12", "_encstr_A3710ED2E5E6E8B4B16DB239F5919933", "_encstr_AF710EFB107B9914D8978F1B11A2A40F", "_encstr_A6710ED3AD5389703BFF60D04702A373", "_encstr_BE710E2D979BE8961BB6CAE4FA23994E", "_encstr_8D710E2897A6D54CCE4A3DFB876E623A", "_encstr_83710E805658A32B9E37AB43B83D705A", "_encstr_9A710EF918E35BDC4720224B993B02A2", "_encstr_99710E08CE3AACB0A760E8CD895B6B4A"];
    var_0[var_0.size] = scripts\engine\utility::random(var_1);
    var_0[var_0.size] = scripts\engine\utility::random(var_1);
    var_0[var_0.size] = scripts\engine\utility::random(var_1);
    var_0[var_0.size] = scripts\engine\utility::random(var_1);
  }

  return var_0;
}

_id_13272() {
  level.arenaweapont1 = fix_collisiontwo(level.arenaweapont1);
  level.arenaweapont2 = fix_collisiontwo(level.arenaweapont2);
  level.arenaweapont3 = fix_collisiontwo(level.arenaweapont3);
  level.arenaweapont4 = fix_collisiontwo(level.arenaweapont4);
  level.arenaweapont5 = fix_collisiontwo(level.arenaweapont5);
  level.arenaweapont6 = fix_collisiontwo(level.arenaweapont6);
  level.arenaweapont7 = fix_collisiontwo(level.arenaweapont7);
  level.arenaweapont8 = fix_collisiontwo(level.arenaweapont8);
}

fix_collisiontwo(var_0) {
  var_0.weapon = var_0.weapon;

  if(!issubstr(var_0.weapon, "_encstr_84D7067AA0C37CE3") && var_0.weapon != "_encstr_8BBA05185F8B99") {
    var_1 = [];
    var_2 = "_encstr_8BBA05185F8B99";
    var_3 = "_encstr_8BBA05185F8B99";
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = [];
    var_7[0] = "_encstr_8BBA05185F8B99";
    var_7[1] = "_encstr_8BBA05185F8B99";
    var_7[2] = "_encstr_8BBA05185F8B99";
    var_7[3] = "_encstr_8BBA05185F8B99";
    var_8 = scripts\mp\utility\weapon::getweaponrootname(var_0.weapon);
    var_2 = rotate_silo_gyro_lights();
    var_0.gasfx = var_2;

    if(_id_140DC(var_0.weapon)) {
      var_6 = rotateeffect();
      var_0.impactfunc_explo = var_6;
    }

    if(_id_140DD(var_0.weapon)) {
      var_7 = rotateplayer();
      var_0._id_138A8[0] = var_7[0];
      var_0._id_138A8[1] = var_7[1];
      var_0._id_138A8[2] = var_7[2];
      var_0._id_138A8[3] = var_7[3];
    }

    var_0.weaponobj = scripts\mp\class::buildweapon(var_8, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }

  return var_0;
}

_id_13227() {
  level.arenaweapont1 = fireoffsplashforplayer(level.arenaweapont1);
  level.arenaweapont2 = fireoffsplashforplayer(level.arenaweapont2);
  level.arenaweapont3 = fireoffsplashforplayer(level.arenaweapont3);
  level.arenaweapont4 = fireoffsplashforplayer(level.arenaweapont4);
  level.arenaweapont5 = fireoffsplashforplayer(level.arenaweapont5);
  level.arenaweapont6 = fireoffsplashforplayer(level.arenaweapont6);
  level.arenaweapont7 = fireoffsplashforplayer(level.arenaweapont7);
  level.arenaweapont8 = fireoffsplashforplayer(level.arenaweapont8);
}

fireoffsplashforplayer(var_0) {
  var_0.weapon = var_0.weapon;

  if(!issubstr(var_0.weapon, "_encstr_84D7067AA0C37CE3") && var_0.weapon != "_encstr_8BBA05185F8B99") {
    var_1 = [];
    var_2 = "_encstr_8BBA05185F8B99";
    var_3 = "_encstr_8BBA05185F8B99";
    var_4 = var_0.variantid;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = [];
    var_7[0] = "_encstr_8BBA05185F8B99";
    var_7[1] = "_encstr_8BBA05185F8B99";
    var_7[2] = "_encstr_8BBA05185F8B99";
    var_7[3] = "_encstr_8BBA05185F8B99";
    var_8 = scripts\mp\utility\weapon::getweaponrootname(var_0.weapon);
    var_0.weaponobj = scripts\mp\class::fixcollision(var_8, undefined, undefined, var_4, undefined, undefined, scripts\cp_mp\utility\game_utility::isnightmap());
  }

  return var_0;
}

_id_13274() {
  level.startweapon = _id_13280(level.startweapon);
  level.arenaweapont1 = _id_13280(level.arenaweapont1);
  level.arenaweapont2 = _id_13280(level.arenaweapont2);
  level.arenaweapont3 = _id_13280(level.arenaweapont3);
  level.arenaweapont4 = _id_13280(level.arenaweapont4);
  level.arenaweapont5 = _id_13280(level.arenaweapont5);
  level.arenaweapont6 = _id_13280(level.arenaweapont6);
  level.arenaweapont7 = _id_13280(level.arenaweapont7);
  level.arenaweapont8 = _id_13280(level.arenaweapont8);
}

_id_13280(var_0) {
  var_0.weapon = var_0.weapon;

  if(!issubstr(var_0.weapon, "_encstr_84D7067AA0C37CE3") && var_0.weapon != "_encstr_8BBA05185F8B99") {
    var_1 = [];
    var_2 = "_encstr_8BBA05185F8B99";
    var_3 = "_encstr_8BBA05185F8B99";
    var_4 = undefined;
    var_5 = scripts\mp\utility\weapon::getweaponrootname(var_0.weapon);
    var_1 = registerdonetskmap(var_5 + "_encstr_851A049F8337");
    var_0.weaponobj = scripts\mp\class::buildweapon(var_5, var_1, var_2, var_3, var_4);
  }

  return var_0;
}

registerlocation(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_2 = registerdonetskmap(var_1 + "_encstr_851A049F8337");
  return var_2;
}

defineplayerloadout(var_0) {
  var_1 = [];
  var_1[0] = "_encstr_8BBA05185F8B99";
  var_1[1] = "_encstr_8BBA05185F8B99";
  var_1[2] = "_encstr_8BBA05185F8B99";
  var_1[3] = "_encstr_8BBA05185F8B99";
  var_1[4] = "_encstr_8BBA05185F8B99";
  var_2 = "_encstr_8BBA05185F8B99";
  var_3 = "_encstr_8BBA05185F8B99";
  var_4 = 0;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = [];
  var_7[0] = "_encstr_8BBA05185F8B99";
  var_7[1] = "_encstr_8BBA05185F8B99";
  var_7[2] = "_encstr_8BBA05185F8B99";
  var_7[3] = "_encstr_8BBA05185F8B99";
  var_8 = ["_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19"];
  var_9 = "_encstr_8BBA05185F8B99";
  var_10 = "_encstr_8BBA05185F8B99";

  if(isDefined(level.startweapon.weapon) && level.startweapon.weapon != "_encstr_8BBA05185F8B99" && !issubstr(level.startweapon.weapon, "_encstr_84D7067AA0C37CE3")) {
    var_11 = scripts\mp\utility\weapon::getweaponrootname(level.startweapon.weapon);

    if(updatec4vehiclemultkill())
      var_4 = level.startweapon.variantid;

    if(istrue(level._id_136CB)) {
      var_2 = rotate_silo_gyro_lights();
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = var_2;

      if(_id_140DC(level.startweapon.weapon)) {
        var_6 = rotateeffect();
        game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_96312155DF03770863F979C678AFBE024B219FA36DD21B383270F36308C9BC3D578EFD"] = var_6;
      }

      if(_id_140DD(level.startweapon.weapon)) {
        var_7 = rotateplayer();
        game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_B6FC168DDB85197B5D471439D2DA2C27F2A9A3A58DB6B227"] = var_7[0];
        game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_91D217989706EACF1D63D7326AE3D33D398E6368A60A97029F"] = var_7[1];
        game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_8ED217397721CB9863CBFF8BFB079FB890BE63ACCF971A3522"] = var_7[2];
        game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_B8D21763FFE7E52FFB99EB46A9B9109AC7EF131BE1FC0F4A5F"] = var_7[3];
      }
    } else if(istrue(level.setplayerselfrevivingextrainfo)) {
      var_2 = rotate_silo_gyro_lights();
      game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = var_2;

      if(_id_140DC(level.startweapon.weapon)) {
        var_6 = rotateeffect();
        game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_96312155DF03770863F979C678AFBE024B219FA36DD21B383270F36308C9BC3D578EFD"] = var_6;
      }

      if(_id_140DD(level.startweapon.weapon)) {
        var_7 = rotateplayer();
        game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_B6FC168DDB85197B5D471439D2DA2C27F2A9A3A58DB6B227"] = var_7[0];
        game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_91D217989706EACF1D63D7326AE3D33D398E6368A60A97029F"] = var_7[1];
        game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_8ED217397721CB9863CBFF8BFB079FB890BE63ACCF971A3522"] = var_7[2];
        game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_B8D21763FFE7E52FFB99EB46A9B9109AC7EF131BE1FC0F4A5F"] = var_7[3];
      }
    } else if(!istrue(var_0))
      var_1 = registerlocation(level.startweapon.weapon);
  } else {
    var_11 = "_encstr_8BBA05185F8B99";

    if(issubstr(level.startweapon.weapon, "_encstr_84D7067AA0C37CE3")) {
      if(validateevents(level.startweapon.weapon)) {
        var_8[var_8.size] = "_encstr_84D117B3C285F853FA4311F3774223884A1EBEE92FE9B89953";

        if(level.calloutmarkerpingvo_doesoperatorsupportalias) {
          var_8[var_8.size] = "_encstr_93EC12672801D3227B89DB907805BA8B8B68AF9F";

          if(level.calloutmarkerpingvo_doesoperatorsupportalias == 2) {
            var_12 = scripts\engine\utility::ter_op(usb_right(), "_encstr_BDB423402BE5F7B8BF33FE7539EBE0B351823098228E57B1A35D8D6F022F6829021E1BA03B", "_encstr_8DFC185F680893323B46DA1BA7E5EA5DAE58ABE7F0B9868A37DC");
            var_4 = int(_encstr_BA5F1D37C693D2C13A9BBC6B1C979D58AD563A5E832BCD79B3BA3717766E1B::remappedhpzoneorder("_encstr_87610AB4EE83FAD6374B3395"));

            if(var_4 != 0)
              setomnvar("_encstr_A1021AAB96D7164EB2DCB0AF0E39A5B658932F2B0B392DB0B9472944", var_4);

            var_11 = "_encstr_87610AB4EE83FAD6374B3395";
          }
        }
      }

      var_13 = scripts\mp\equipment::getdefaultslot(level.startweapon.weapon);

      if(var_13 == "_encstr_BA7F0830B3A7859B60B0")
        var_9 = level.startweapon.weapon;
      else
        var_10 = level.startweapon.weapon;
    }
  }

  if(level.allowsupers) {
    var_14 = scripts\cp_mp\utility\game_utility::getmapname();

    if(issubstr(var_14, "_encstr_AA1606AD077DB6FA") && var_14 != "_encstr_A5110B50E25F68A83BD3D3EBBB")
      level.calloutmarkerpingvo_getcalloutaliasstringvehicle = player_give_intel_3_ks();
  } else {
    level.calloutmarkerpingvo_getcalloutaliasstringvehicle = "_encstr_8BBA05185F8B99";
    setomnvar("_encstr_85D719BDA2513D8067493554C147D51FE9044365D9D406F794FA0A", 1);
  }

  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"] = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = var_11;
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = var_1[0];
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = var_1[1];
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"] = var_1[2];
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3"] = var_1[3];
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB"] = var_1[4];
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = var_2;
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_96312155DF03770863F979C678AFBE024B219FA36DD21B383270F36308C9BC3D578EFD"] = var_6;
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = var_3;
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_B6FC168DDB85197B5D471439D2DA2C27F2A9A3A58DB6B227"] = var_7[0];
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_91D217989706EACF1D63D7326AE3D33D398E6368A60A97029F"] = var_7[1];
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_8ED217397721CB9863CBFF8BFB079FB890BE63ACCF971A3522"] = var_7[2];
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_B8D21763FFE7E52FFB99EB46A9B9109AC7EF131BE1FC0F4A5F"] = var_7[3];
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"] = var_4;
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_ACDB1CC6BD858CF6ABA3D45636F6E623169C2F0A1D8E85C634AD95B98ECC"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_A1DB1C292712B5A7DD034F97C73DF6E0A74D9011B3E1F77FA393B00593AC"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_A7DB1C731F0FFAD7182372C7F9F0EE32D7BDAF3FC12D12939868F70DF3CA"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_9BB9182BB7D71132DB69D990F7D29E302EAB832FD37FD6EA9302"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_872219FD502BAA9F5B584F9F08F0467283765EBA454392D361703E"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_81221930EF31C19713239E9DFEEACD89992310516BC1F9573ACA26"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_88221919F53AE1C855CB89208F972029C25A0B0E8B12B7302DFB82"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"] = -1;
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"] = "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = var_9;
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = var_10;
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_91C8151BEDB08C7BAEE891B4B28D91550E9DC9588CAC62"] = level.calloutmarkerpingvo_getcalloutaliasstringvehicle;
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_ACC815D8F62C23F6BAD19196598DC8AA387693C2C8598C"] = "_encstr_8BBA05185F8B99";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = var_8;
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
  level.arena_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_81E6112CD2D9B12F700387D0E8A7C32341A7DD"] = "_encstr_A63C0B33252188F56B439B89EF";
  level.arena_loadouts["_encstr_9A8507BA4040188D08"] = level.arena_loadouts["_encstr_8B1608EC43B8D647A113"];
  level.arena_loadouts["_encstr_8E8405EA382B2A"] = level.arena_loadouts["_encstr_8B1608EC43B8D647A113"];

  if(!istrue(level._id_136CB) && !istrue(level.setplayerselfrevivingextrainfo)) {
    foreach(var_16 in level.teamnamelist) {
      level.arena_loadouts[var_16]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = _id_131BD();
      level.arena_loadouts[var_16]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = _id_131BD();
    }
  }
}

_id_131BD() {
  var_0 = ["_encstr_AAC809D816B6DEF5814C58", "_encstr_96C8098FDBB937AFFB32F2", "_encstr_88C80936B06B7BFA0C4CC6", "_encstr_85C80936E93F602F9A8F80", "_encstr_85C80936E93F602F9A8F80", "_encstr_8AC8091BBB10A5FF9FABC2", "_encstr_97C809D9EED5C010C70E1D", "_encstr_ADC80981B69D8858FFC6C7", "_encstr_8EC8098D856BB77DC0C40D", "_encstr_BEC80981B69D8858FFC6DB", "_encstr_ACC809C616AD7BF518C49A", "_encstr_BEC80981B69D8858FFCACB", "_encstr_8EC8098D856BB77DC0C84C", "_encstr_B8C8099FD3B9FA5782BB2E", "_encstr_96C8098FDBB937AFFBF2F4", "_encstr_96C8098FDBB937AFFBF2F4", "_encstr_87C809470B71329F3AF3F7", "_encstr_BDC809DE36BAB78E509260", "_encstr_82C8091F53397AD7023BAF", "_encstr_97C809D9EED5C010C70201", "_encstr_AAC809D816B6DEF5818C5A", "_encstr_81C8098E79383FB95F2593", "_encstr_91C809D82CB6EDFA066658", "_encstr_ACC809C616AD7BF518CC98", "_encstr_B8C8099FD3B9FA57829B2E", "_encstr_8EC8098D856BB77DC0CC8C", "_encstr_8EC8098D856BB77DC0CC8C", "_encstr_BEC80981B69D8858FFCEC3", "_encstr_92C8098D2CB67B7D189999", "_encstr_82C8091F53397AD7021BAF", "_encstr_BDC809DE36BAB78E509610", "_encstr_87C809470B71329F3AD3F4", "_encstr_96C8098FDBB937AFFBB2FA", "_encstr_9BC809DF3FF0A871323380", "_encstr_A7C80919BE7B70B719BA4D", "_encstr_ABC809362C5B7BF56068B1", "_encstr_93C8094FC868A739B1CDC7", "_encstr_93C8094FC868A739B1CDC7", "_encstr_A1C809E6115057C13741B7", "_encstr_8FC809B185DAF6F5606866", "_encstr_A3C8096A71E9DFB1EA191F", "_encstr_9AC809AF21A9F7D7CB7208", "_encstr_8CC809ABA7334A89F7EB71", "_encstr_8DC80947E1257BD8B22F28", "_encstr_8BC8093BF7A80D4FEA45FF", "_encstr_8DC80947E1257BD8B23F29", "_encstr_A5C809EF39283717678E29", "_encstr_9AC809AF21A9F7D7CB7A89", "_encstr_9AC809AF21A9F7D7CB7A89", "_encstr_AFC8095A41D9CFA1FAEBED", "_encstr_A9C809DF794D68A0CA5731", "_encstr_8CC809ABA7334A89F7AB7F", "_encstr_93C8094FC868A739B14DC4", "_encstr_A3C8096A71E9DFB1EA1B11", "_encstr_A7C80919BE7B70B719B25D", "_encstr_A2C8091B58DAEDBE81D816", "_encstr_95C80977BF2877998742C2", "_encstr_B4C8094707523071A01BF1", "_encstr_B6C809C62CDAB77D606323", "_encstr_B6C809C62CDAB77D606323", "_encstr_A6C809D82CB5DE7D18D895", "_encstr_B2C80931911D9F11AFDA56", "_encstr_84C809D2E83B05A7D3D4AF", "_encstr_8AC8091BBB10A5FF9F4B12", "_encstr_85C80936E93F602F9AFFE8", "_encstr_ADC80981B69D8858FFDADD", "_encstr_B4C8094707523071A05BB1", "_encstr_95C80977BF2877998746C2", "_encstr_A2C8091B58DAEDBE81DC36", "_encstr_8AC8091BBB10A5FF9F6BD2", "_encstr_8AC8091BBB10A5FF9F6BD2", "_encstr_84C809D2E83B05A7D354AD", "_encstr_B2C80931911D9F11AFDE56", "_encstr_A6C809D82CB5DE7D18DC9D", "_encstr_AAC809D816B6DEF581CD1A", "_encstr_97C809D9EED5C010C71603", "_encstr_ADC80981B69D8858FFDEDD", "_encstr_93C8094FC868A739B1CB86", "_encstr_91C809D82CB6EDFA067098", "_encstr_8FC809B185DAF6F5607036", "_encstr_ABC809362C5B7BF5607032", "_encstr_ABC809362C5B7BF5607032", "_encstr_99C809C6B0ADB7AF060756", "_encstr_A1C809E6115057C13759BB", "_encstr_A7C80919BE7B70B719DA47", "_encstr_82C8091F53397AD7027A6C", "_encstr_92C8098D2CB67B7D18C1A5", "_encstr_87C809470B71329F3AB234", "_encstr_99C809C6B0ADB7AF062716", "_encstr_8BC8093BF7A80D4FEA437E", "_encstr_83C8091962C7D8916A599F", "_encstr_A1C809E6115057C1375BB3", "_encstr_A1C809E6115057C1375BB3", "_encstr_93C8094FC868A739B14B87", "_encstr_ABC809362C5B7BF5607233", "_encstr_A7C80919BE7B70B719D247", "_encstr_91C809D82CB6EDFA06721A", "_encstr_ACC809C616AD7BF518E45A", "_encstr_A3C8096A71E9DFB1EA0312", "_encstr_A9C809DF794D68A0CE07D1", "_encstr_8CC809ABA7334A8977EA7A", "_encstr_9AC809AF21A9F7D7EB5269", "_encstr_B4C8094707523071A19A11", "_encstr_B4C8094707523071A19A11", "_encstr_95C80977BF287799075AC5", "_encstr_A2C8091B58DAEDBE89C066", "_encstr_B1C8095E91471847B20730", "_encstr_8BC8093BF7A80D4FAAC77B", "_encstr_83C8091962C7D8912A508B", "_encstr_9BC809DF3FF0A87172B3D8"];
  var_1 = "_encstr_8BBA05185F8B99";

  foreach(var_3 in level.teamnamelist) {
    if(game["_encstr_82330FE47BAB7346AEA5734DE89C590BAD"][var_3] == 0) {
      continue;
    }
    if(game["_encstr_82330FE47BAB7346AEA5734DE89C590BAD"][var_3] > 5) {
      var_1 = "_encstr_BAC80988A6B0CAC98A4A98";
      continue;
    }

    switch (game["_encstr_82330FE47BAB7346AEA5734DE89C590BAD"][var_3]) {
      case 0:
        break;
      case 1:
        var_1 = scripts\engine\utility::random(var_0);
        break;
      case 2:
        var_1 = "_encstr_9AC809AF21A9F7D7EB5A29";
        break;
      case 3:
        var_1 = "_encstr_8CC809ABA7334A8977AA7A";
        break;
      case 4:
        var_1 = "_encstr_A9C809DF794D68A0CE1791";
        break;
      case 5:
        var_1 = "_encstr_BAC80988A6B0CAC98A4A98";
        break;
    }
  }

  return var_1;
}

updaterandomloadout() {
  if(israndomloadouts() || usbs_pulled_out() || usb_right() || usb_tape_animation_test()) {
    if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0) {
      if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
        cacherandomloadouts();
        game["_encstr_852B18DA52A7665A021040939D672C97321538BD59338E49198B"] = 0;
      } else if(!isDefined(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"]) || istrue(game["_encstr_A34F0D1D746A8FE84FC721409F9063"])) {
        if(istrue(game["_encstr_A34F0D1D746A8FE84FC721409F9063"]))
          game["_encstr_A34F0D1D746A8FE84FC721409F9063"] = undefined;

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
  var_0 = [];
  var_1 = 0;
  var_2 = scripts\engine\utility::ter_op(usb_right(), "_encstr_BDB423402BE5F7B8BF33FE7539EBE0B351823098228E57B1A35D8D6F022F6829021E1BA03B", "_encstr_8DFC185F680893323B46DA1BA7E5EA5DAE58ABE7F0B9868A37DC");

  if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163")
    var_2 = "_encstr_91FD19D9729EAFE80197C8E8C75AA0EBE15CC0D48FF25958EBBFE8";

  if(israndompreviewloadouts())
    var_1 = 144;
  else if(usb_left())
    var_1 = 0;
  else if(usbwm())
    var_1 = 57;
  else if(usbserver())
    var_1 = 93;
  else if(usbvm())
    var_1 = 123;
  else if(use_airdrop_fx())
    var_1 = 146;
  else if(usbmodel())
    var_1 = 188;

  while(scripts\mp\class::table_getloadoutname(var_2, var_1) != "_encstr_B40101") {
    var_0[var_0.size] = updateloadoutarray(var_2, var_1);
    var_1++;

    if(israndompreviewloadouts()) {
      if(var_1 == 0) {
        break;
      }
    } else if(usb_left()) {
      if(var_1 == 57) {
        break;
      }
    } else if(usbwm()) {
      if(var_1 == 93) {
        break;
      }
    } else if(usbserver()) {
      if(var_1 == 123) {
        break;
      }
    } else if(usbvm()) {
      if(var_1 == 146) {
        break;
      }
    } else if(use_airdrop_fx()) {
      if(var_1 == 188) {
        break;
      }
    }
  }

  var_3 = undefined;
  var_4 = undefined;
  var_5 = getDvar("_encstr_AD711AB9D827FA16E4CAB9B0FADE9DB227C9969195BAB2B00EDECD9B", "_encstr_B40101");
  var_6 = getdvarfloat("_encstr_83D51F6EBB1336237ABA80F0F1D5F589FB32FB6D15DF396BA22298199A6E8D011F", 0.0);

  if(var_5 != "_encstr_B40101" && var_6 > 0.0) {
    var_7 = strtok(var_5, "_encstr_964C0249");

    foreach(var_9 in var_7) {
      var_10 = strtok(var_9, "_encstr_854C021F");

      if(var_10.size == 2) {
        var_11 = var_10[0];
        var_12 = int(var_10[1]);
        var_13 = scripts\mp\utility\weapon::_id_1458C(var_11, var_12);

        if(var_13) {
          if(!isDefined(var_3)) {
            var_3 = [];
            var_4 = var_6;
          }

          var_14 = spawnStruct();
          var_14._id_12D96 = var_11;
          var_14.variantid = var_12;
          var_3[var_3.size] = var_14;
        }
      }
    }
  }

  var_0 = arenaloadouts_select(var_0, 99, var_3, var_4);
  game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"] = scripts\engine\utility::array_randomize(var_0);
}

updateloadoutarray(var_0, var_1) {
  var_2 = [];
  var_2["_encstr_B805263D90EB6A5F9B98038318F00953732F87B79E09B39D03B09FEBC8ADD4FB1B460C6DE5A5DBB3"] = scripts\mp\class::_id_139E4(var_0, var_1, 0);
  var_2["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = scripts\mp\class::table_getweapon(var_0, var_1, 0);

  for(var_3 = 0; var_3 < scripts\mp\class::getmaxprimaryattachments(); var_3++) {
    var_4 = scripts\mp\class::getattachmentloadoutstring(var_3, "_encstr_BA7F0830B3A7859B60B0");
    var_2[var_4] = scripts\mp\class::table_getweaponattachment(var_0, var_1, 0, var_3);
  }

  var_2["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = scripts\mp\class::table_getweaponcamo(var_0, var_1, 0);
  var_2["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = scripts\mp\class::table_getweaponreticle(var_0, var_1, 0);

  if(usb_right() || usb_tape_animation_test())
    var_2["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"] = scripts\mp\class::_id_139E6(var_0, var_1, 0, var_2["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"]);
  else
    var_2["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"] = 0;

  if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916" && var_2["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"] != 0)
    setomnvar("_encstr_A1021AAB96D7164EB2DCB0AF0E39A5B658932F2B0B392DB0B9472944", var_2["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"]);

  var_2["_encstr_99B2286888EADCAFF83B919362D82E502F18AB292D5116D86759C01D572BA8F0931B51BA61DDA87533DF"] = scripts\mp\class::_id_139E4(var_0, var_1, 1);
  var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = scripts\mp\class::table_getweapon(var_0, var_1, 1);

  for(var_3 = 0; var_3 < scripts\mp\class::getmaxsecondaryattachments(); var_3++) {
    var_4 = scripts\mp\class::getattachmentloadoutstring(var_3, "_encstr_AC8F0AE74163F85AAA380AD8");
    var_2[var_4] = scripts\mp\class::table_getweaponattachment(var_0, var_1, 1, var_3);
  }

  if(istrue(level._id_136CB) || istrue(level.setplayerselfrevivingextrainfo))
    var_2["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = scripts\mp\class::table_getweaponcamo(var_0, var_1, 1);
  else
    var_2["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = scripts\mp\class::table_getweaponcamo(var_0, var_1, 1);

  var_2["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = scripts\mp\class::table_getweaponreticle(var_0, var_1, 1);

  if(usb_right() || usb_tape_animation_test())
    var_2["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"] = scripts\mp\class::_id_139E6(var_0, var_1, 1, var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"]);
  else
    var_2["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"] = 0;

  if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916" && var_2["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"] != 0)
    setomnvar("_encstr_8C1F1C1BF3F75A22F928E717E8D1EB627D9DE652635D126A2D48E3A3C12D", var_2["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"]);

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

  if(level.allowsupers) {
    var_7 = scripts\cp_mp\utility\game_utility::getmapname();

    if(issubstr(var_7, "_encstr_AA1606AD077DB6FA") && var_7 != "_encstr_A5110B50E25F68A83BD3D3EBBB")
      level.calloutmarkerpingvo_getcalloutaliasstringvehicle = player_give_intel_3_ks();

    var_2["_encstr_91C8151BEDB08C7BAEE891B4B28D91550E9DC9588CAC62"] = level.calloutmarkerpingvo_getcalloutaliasstringvehicle;
    var_2["_encstr_ACC815D8F62C23F6BAD19196598DC8AA387693C2C8598C"] = "_encstr_8BBA05185F8B99";
  } else {
    var_2["_encstr_91C8151BEDB08C7BAEE891B4B28D91550E9DC9588CAC62"] = "_encstr_8BBA05185F8B99";
    var_2["_encstr_ACC815D8F62C23F6BAD19196598DC8AA387693C2C8598C"] = "_encstr_8BBA05185F8B99";
  }

  if(usbs_pulled_out()) {
    var_2["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
    var_2["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
    var_2["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"] = "_encstr_8BBA05185F8B99";
    var_2["_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3"] = "_encstr_8BBA05185F8B99";
    var_2["_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB"] = "_encstr_8BBA05185F8B99";
    var_2["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
    var_2["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
    var_2["_encstr_ACDB1CC6BD858CF6ABA3D45636F6E623169C2F0A1D8E85C634AD95B98ECC"] = "_encstr_8BBA05185F8B99";
    var_2["_encstr_A1DB1C292712B5A7DD034F97C73DF6E0A74D9011B3E1F77FA393B00593AC"] = "_encstr_8BBA05185F8B99";
    var_2["_encstr_A7DB1C731F0FFAD7182372C7F9F0EE32D7BDAF3FC12D12939868F70DF3CA"] = "_encstr_8BBA05185F8B99";
  }

  return var_2;
}

arenaloadouts_select(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = [];

  for(var_6 = 0; var_6 < var_1 && var_0.size > 0; var_6++) {
    var_7 = var_0[randomint(var_0.size)];
    var_8 = var_7["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"];

    if(isDefined(var_2) && isDefined(var_3)) {
      var_9 = arenaloadouts_getweapongroup(var_8);
      var_10 = calloutmarkerpingvo_getaffirmaliasstringloot(var_2, var_9);

      if(var_10.size > 0) {
        if(randomfloat(1.0) < var_3) {
          var_11 = randomint(var_10.size);
          var_12 = var_10[var_11];
          var_2 = scripts\engine\utility::array_remove_index(var_2, var_11);
          var_7["_encstr_B805263D90EB6A5F9B98038318F00953732F87B79E09B39D03B09FEBC8ADD4FB1B460C6DE5A5DBB3"] = 1;
          var_7["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = var_12._id_12D96;
          var_7["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"] = var_12.variantid;
          var_7["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
          var_7["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";

          for(var_13 = 0; var_13 < scripts\mp\class::getmaxprimaryattachments(); var_13++) {
            var_14 = scripts\mp\class::getattachmentloadoutstring(var_13, "_encstr_BA7F0830B3A7859B60B0");
            var_7[var_14] = "_encstr_8BBA05185F8B99";
          }
        }
      }
    }

    var_5[var_5.size] = var_7;
    var_0 = arenaloadouts_removeclass(var_0, var_8);
  }

  return var_5;
}

calloutmarkerpingvo_getaffirmaliasstringloot(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(arenaloadouts_getweapongroup(var_4._id_12D96) == var_1)
      var_2[var_2.size] = var_4;
  }

  return var_2;
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
    var_1 = tablelookupbyrow("_encstr_88BA16F5BBEE7B16E0A060BFCF7777A9513A08EFD6DFF723", var_0, 4);

    if(var_1 == "_encstr_97180566B03293") {
      var_0++;
      continue;
    }

    if(var_1 == "_encstr_B40101") {
      break;
    }

    var_2 = strtok(var_1, "_encstr_BE4C0295");

    foreach(var_4 in var_2) {
      if(!isDefined(level.weaponcategories[var_4]))
        level.weaponcategories[var_4] = [];

      var_5 = [];
      var_5["_encstr_AC20072B9FA9487832"] = tablelookupbyrow("_encstr_88BA16F5BBEE7B16E0A060BFCF7777A9513A08EFD6DFF723", var_0, 0);
      level.weaponcategories[var_4][level.weaponcategories[var_4].size] = var_5;
      level.allweapons[var_5["_encstr_AC20072B9FA9487832"]] = var_5["_encstr_AC20072B9FA9487832"];
    }

    var_0++;
  }
}

getrandomweaponfromcategory(var_0, var_1) {
  if(istrue(var_1) && var_0 == "_encstr_81510F625BB3FD276BDB48787543E3F0A2") {
    if(!isDefined(game["_encstr_8558160F6D3562E1E1FB36FAD3E92D2A17FFAB0F296FFBCB"])) {
      var_0 = scripts\engine\utility::ter_op(randomint(100) > 49, "_encstr_8B4C0C4EB0E68CF5DCE6A5C15693", "_encstr_84D809530F9A4AF96560C3");
      game["_encstr_8558160F6D3562E1E1FB36FAD3E92D2A17FFAB0F296FFBCB"] = var_0;
    } else {
      if(game["_encstr_8558160F6D3562E1E1FB36FAD3E92D2A17FFAB0F296FFBCB"] == "_encstr_8B4C0C4EB0E68CF5DCE6A5C15693")
        var_0 = "_encstr_84D809530F9A4AF96560C3";
      else
        var_0 = "_encstr_8B4C0C4EB0E68CF5DCE6A5C15693";

      game["_encstr_8558160F6D3562E1E1FB36FAD3E92D2A17FFAB0F296FFBCB"] = var_0;
    }
  }

  var_2 = level.weaponcategories[var_0];

  if(isDefined(var_2) && var_2.size > 0) {
    var_3 = "_encstr_B40101";
    var_4 = undefined;
    var_5 = 0;

    for(;;) {
      var_6 = randomintrange(0, var_2.size);
      var_4 = var_2[var_6];
      var_7 = scripts\mp\utility\weapon::getweaponrootname(var_4["_encstr_AC20072B9FA9487832"]);

      if(var_5 > var_2.size) {
        level.selectedweapons[var_7] = 1;
        var_3 = var_4["_encstr_AC20072B9FA9487832"];

        for(var_8 = 0; var_8 < level.weaponcategories[var_0].size; var_8++) {
          if(level.weaponcategories[var_0][var_8]["_encstr_AC20072B9FA9487832"] == var_3) {
            break;
          }
        }

        break;
      }

      var_5++;
    }

    return var_3;
  } else
    return "_encstr_8BBA05185F8B99";
}

initweaponmap() {
  level.baseraritymap = [];
  level.baseraritymap[level.arenaweapont1.weapon] = 0;
  level.baseraritymap[level.arenaweapont2.weapon] = 1;
  level.baseraritymap[level.arenaweapont3.weapon] = 2;
  level.baseraritymap[level.arenaweapont4.weapon] = 3;
  level.baseraritymap[level.arenaweapont5.weapon] = 4;
  level.baseraritymap[level.arenaweapont6.weapon] = 5;
  level.baseraritymap[level.arenaweapont7.weapon] = 6;
  level.baseraritymap[level.arenaweapont8.weapon] = 0;
}

regroup_at_truck(var_0) {
  if(updatec4vehiclemultkill() && !issubstr(var_0, "_encstr_84D7067AA0C37CE3") && var_0 != "_encstr_8BBA05185F8B99") {
    var_1 = "_encstr_BDB423402BE5F7B8BF33FE7539EBE0B351823098228E57B1A35D8D6F022F6829021E1BA03B";
    var_2 = 0;
    var_3 = "_encstr_B40101";

    for(var_4 = scripts\mp\utility\weapon::getweaponrootname(var_0); scripts\mp\class::table_getloadoutname(var_1, var_2) != "_encstr_B40101"; var_2++) {
      var_3 = scripts\mp\class::table_getweapon(var_1, var_2, 0);

      if(var_4 == var_3) {
        break;
      }
    }

    if(var_4 != "_encstr_B40101") {
      var_5 = scripts\mp\class::_id_139E6("_encstr_BDB423402BE5F7B8BF33FE7539EBE0B351823098228E57B1A35D8D6F022F6829021E1BA03B", var_2, 0, var_4);
      return var_5;
    }

    return 0;
  } else
    return 0;
}

setupweapons() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_914C0EDDB20B837BB97D38D2365BAB83", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(istrue(level._id_136CB) || istrue(level.setplayerselfrevivingextrainfo))
    _id_13272();
  else if(updatec4vehiclemultkill())
    _id_13227();
  else
    _id_13274();

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
      var_4 = scripts\engine\utility::random(var_0);

      if(!issubstr(var_4, "_encstr_84D7067AA0C37CE3"))
        var_5 = scripts\mp\utility\weapon::getweaponrootname(var_4);
      else
        var_5 = var_4;

      if(var_3 > var_0.size) {
        level.selectedweapons[var_5] = 1;
        var_1 = var_4;

        for(var_6 = 0; var_6 < level.allweapons.size; var_6++) {
          if(level.allweapons[var_4] == var_1) {
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

registerdonetskmap(var_0) {
  var_1 = [];

  if(level.calloutmarkerpingvo_getcalloutaliasstringentity == 1) {
    if(weaponclass(var_0) == "_encstr_850707F7E5833355B8" || weaponclass(var_0) == "_encstr_A11804C86B39")
      var_1[var_1.size] = "_encstr_B8FB06FF97EA2708";
  }

  if(weaponclass(var_0) == "_encstr_850707F7E5833355B8") {
    switch (var_0) {
      case "_encstr_8F091280BBC06FBB63BF57D988A321732AC128D0":
        var_1[var_1.size] = "_encstr_9BC007FBBD680FA49F";
        var_1[var_1.size] = "_encstr_83060D82B09BEC62B9474BDF917F7F";
        break;
      case "_encstr_8380108C3B128FFBF07F2B2771A582D71063":
        var_1[var_1.size] = "_encstr_96010ADC1DB76CB6B1576E1D";
        break;
      case "_encstr_998712A5DD837D9BCDD7A1C89CBD6BACDBFAD607":
        var_1[var_1.size] = "_encstr_AAC00736D0F8CE77E0";
        break;
      case "_encstr_99511344F3DA472338B7E34F23528AE1429271CD8B":
        var_1[var_1.size] = "_encstr_9BC007FBBD680FA49F";
        var_1[var_1.size] = "_encstr_83060D82B09BEC62B9474BDF917F7F";
        break;
      case "_encstr_A12C1328BF58B6BFB2997E886D7AFFF3383A11B00B":
        var_1[var_1.size] = "_encstr_B8FB06FF97EA2708";
        var_1[var_1.size] = "_encstr_9BC007FBBD680FA49F";
        var_1[var_1.size] = "_encstr_A95109B1C236D85D6EA346";
        var_1[var_1.size] = "_encstr_99B20618883ACCA3";
        break;
      default:
        break;
    }
  }

  if(var_1.size == 0)
    var_1[var_1.size] = "_encstr_8BBA05185F8B99";

  return var_1;
}

spawnweapon(var_0, var_1, var_2) {
  if(isDefined(var_2))
    var_3 = var_1;
  else
    var_3 = var_1.weapon;

  if(var_3 == "_encstr_8BBA05185F8B99") {
    return;
  }
  var_4 = player_give_infinite_rocks(var_0);

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_AFF605A3F9E16B") {} else {
    var_5 = var_0.origin + (0, 0, 16);
    var_6 = var_0.origin + (0, 0, -16);
    var_7 = scripts\engine\trace::ray_trace(var_5, var_6, undefined, scripts\engine\trace::create_default_contents(1));

    if(var_7["_encstr_A53009A25003666B9818C6"] < 1.0)
      var_4 = var_7["_encstr_BD260953AA97E3F014279D"] + (0, 0, 2);
  }

  var_8 = "_encstr_B40101";
  var_9 = getequipmentmodel(var_3);

  if(var_9 != "_encstr_B40101") {
    if(istrue(level._id_1343F) && var_3 == "_encstr_AC7B0F58B7054089918260F89B1AF3A874") {
      if(isPlayer(var_0))
        var_8 = "_encstr_BDDC07EBCCB5CA4BED";
      else if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_AFF605A3F9E16B")
        var_8 = "_encstr_BDDC07EBCCB5CA4BED";
      else if(scripts\engine\utility::cointoss()) {
        if(scripts\engine\utility::cointoss())
          var_8 = "_encstr_AD0D0571F995A0";
        else
          var_8 = "_encstr_BDDC07EBCCB5CA4BED";
      } else
        var_8 = "_encstr_8CC708B8AB0DAA055BFF";

      if(!isPlayer(var_0) && var_0.script_label == "_encstr_8F4C026A" && !level._id_12344) {
        if(distance(var_0.origin, (0, 0, 138)) < 10) {
          level._id_12344 = 1;
          var_3 = "_encstr_A9030CABA733D3E82F6A31A995F4";
          var_8 = "_encstr_BDDC07EBCCB5CA4BED";
        }
      } else if(!isPlayer(var_0) && var_0.script_label == "_encstr_864C02F9" && !level._id_12344) {
        if(distance(var_0.origin, (0, 0, -50)) < 10) {
          if(scripts\engine\utility::cointoss()) {
            level._id_12344 = 1;
            var_3 = "_encstr_A9030CABA733D3E82F6A31A995F4";
            var_8 = "_encstr_BDDC07EBCCB5CA4BED";
          }
        }
      }

      switch (var_8) {
        case "_encstr_AD0D0571F995A0":
          var_9 = "_encstr_9335173AD1CE3F1A7177F6CF47A0E67BE10EF39298954742EA";
          var_4 = var_4 - (0, 0, 3);
          break;
        case "_encstr_8CC708B8AB0DAA055BFF":
          var_9 = "_encstr_A9051AA9F752D0F82FAAB06853FAA8997AB7391B331AA9782C8973AB";
          var_4 = var_4 - (0, 0, 3);
          break;
        default:
          var_9 = "_encstr_823513EE2B0B83F6DC7DBBB5BEDC9B7BDD31168DD8";
          break;
      }

      var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
      var_10 setModel(var_9);
    } else {
      var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
      var_10 setModel(var_9);
    }

    if(isDefined(var_0.angles)) {
      if(var_3 == "_encstr_82A70F2B3B73E33B472371FF21D7809DDF" || var_3 == "_encstr_886E0ECA2ED5B438FAB0A3D7B5B4CD95" || var_3 == "_encstr_AA870D15FAF37393C74318F8BB184A") {
        if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_AFF605A3F9E16B" || isDefined(var_0._id_12F52) && var_0._id_12F52 == "_encstr_AFF605A3F9E16B")
          var_10.angles = (270, var_0.angles[1], 90);
        else
          var_10.angles = (0, var_0.angles[1], 0);
      } else if(var_3 == "_encstr_843D095F2B7D52B041D9A3" || var_3 == "_encstr_BDF90F4D9F8B8702A7B08A52682BBC0B61" || var_3 == "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381") {
        if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_AFF605A3F9E16B" || isDefined(var_0._id_12F52) && var_0._id_12F52 == "_encstr_AFF605A3F9E16B")
          var_10.angles = (180, var_0.angles[1], 180);
        else
          var_10.angles = (0, var_0.angles[1], 90);
      } else {
        var_10.angles = (0, 90, 0);
        var_10.origin = var_10.origin + (0, 0, 2);
      }
    } else
      var_10.angles = (0, 0, 90);

    var_11 = 96;
    var_12 = 96;
    var_13 = var_10 getequipmenthintstring(var_3);
    var_14 = var_10 getequipmenthinticon(var_3);
    var_10.equipment = var_3;
    var_10 makeusable();
    var_10 sethinttag("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_10 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
    var_10 sethinticon(var_14);
    var_10 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
    var_10 setusehideprogressbar(1);
    var_10 setHintString(var_13);
    var_10 setusepriority(0);
    var_10 sethintdisplayrange(var_12);
    var_10 sethintdisplayfov(120);
    var_10 setuserange(var_11);
    var_10 setusefov(210);
    var_10 sethintonobstruction("_encstr_BECC055CF3811A");
    var_10 thread outlineequipmentwatchplayerprox(var_9, var_3);
    var_10._id_1292D = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_10.origin, 0, 32, 32);
    var_10 thread vehicle_collision_registereventinternal();

    if(istrue(level._id_1343F)) {
      var_10 thread _id_144F3(var_0, var_8);
      var_10.targetname = "_encstr_AD580F5F2388E9EB57322E3069A1074090";
      return;
    }

    var_10 thread watchequipmentpickup();
    var_10.targetname = "_encstr_97DA124766BF6318C15007178B3BC9AB63754DFB";
    return;
  } else {
    var_15 = undefined;
    var_15 = scripts\mp\utility\weapon::getweaponrootname(var_3);
    var_16 = [];

    if(istrue(level._id_136CB) || istrue(level.setplayerselfrevivingextrainfo) || updatec4vehiclemultkill())
      var_17 = var_1.weaponobj;
    else {
      var_16 = registerdonetskmap(var_15 + "_encstr_851A049F8337");
      var_17 = scripts\mp\class::buildweapon(var_15, var_16, "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
    }

    var_18 = createheadicon(var_17);
    var_19 = spawn("_encstr_B2010820C5337B67C8CF" + var_18, var_4, 17);
    var_19 sethintdisplayrange(96);
    var_19 setuserange(96);
    var_19 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
    var_19 setusefov(210);
    var_19.targetname = "_encstr_AD580F5F2388E9EB57322E3069A1074090";
    var_19.objweapon = var_17;

    if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_AFF605A3F9E16B") {
      var_20 = anglestoright(var_0.angles);
      var_21 = vectorNormalize(var_20) * 30;
      var_5 = var_0.origin + var_21 + (0, 0, 16);
      var_6 = var_0.origin + var_21 + (0, 0, -100);
      var_7 = scripts\engine\trace::ray_trace(var_5, var_6, undefined, scripts\engine\trace::create_default_contents(1));
      var_22 = var_0.origin;

      if(var_7["_encstr_A53009A25003666B9818C6"] < 1.0)
        var_22 = var_7["_encstr_BD260953AA97E3F014279D"];

      var_19.deafen_ai_near_pa_for_duration = var_22;
    }

    manageweaponstartingammo(var_19, var_18);

    if(isDefined(var_0.angles)) {
      if(var_15 == "_encstr_8EF4120387DA5772B528A25C906463B05F38F38F") {
        if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_AFF605A3F9E16B" || isDefined(var_0._id_12F52) && var_0._id_12F52 == "_encstr_AFF605A3F9E16B")
          var_19.angles = (var_0.angles[0], var_0.angles[1] - 90, var_0.angles[2]);
        else
          var_19.angles = (var_0.angles[0] - 90, var_0.angles[1], var_0.angles[2]);
      } else if(var_15 == "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD") {
        if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_AFF605A3F9E16B")
          var_19.angles = (var_0.angles[0], var_0.angles[1], var_0.angles[2] + 90);
        else
          var_19.angles = (var_0.angles[0], var_0.angles[1], var_0.angles[2] + 90);
      } else
        var_19.angles = var_0.angles;
    } else
      var_19.angles = (0, 0, 90);

    var_19 thread outlinewatchplayerprox();
    var_19 thread watchpickup();
  }
}

player_give_infinite_rocks(var_0) {
  if(level.mapname == "_encstr_8E020FABE7B9F00F4EC0F83381FDDA9004") {
    if(var_0.script_label == "_encstr_A14C023B" && distance(var_0.origin, (-488.2, -399.9, 54.25)) < 10)
      var_0.origin = (-488.2, -409.9, 54.25);
    else if(var_0.script_label == "_encstr_B84C027E" && distance(var_0.origin, (657.3, 644.6, 56)) < 10)
      var_0.origin = (665.3, 644.6, 56);
  } else if(level.mapname == "_encstr_A90A0D75F9E1455F9EA3227A68F5EF") {
    if(var_0.script_label == "_encstr_B84C027E" && distance(var_0.origin, (400.748, 762, -291.005)) < 10)
      var_0._id_12F52 = "_encstr_AFF605A3F9E16B";
    else if(var_0.script_label == "_encstr_A74C0222" && distance(var_0.origin, (38.354, -115, -298.312)) < 10)
      var_0._id_12F52 = "_encstr_AFF605A3F9E16B";
    else if(var_0.script_label == "_encstr_A74C0222" && distance(var_0.origin, (-36.354, 83, -298.312)) < 10)
      var_0._id_12F52 = "_encstr_AFF605A3F9E16B";
  }

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
    case "_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC":
      return "_encstr_885E31EEB2B01CDEDCD7BBDABEB5CAFADCEDDC6C5839F56DCDD299B2AFCCD24EACFADECCCC1A85E68CF5E88639DBDDB9FA6B1C";
    case "_encstr_AFBF1E59C5BA5A83BED1D027DBDD2DDCD9BEADDC4B99ACAFCAB1ACD8A393961B":
      return "_encstr_81012DEE59C238DB737DDDADEBB695AFDCF6DC3658C9F5D69BA5CCACAFF63333D0C23732F5E8A193B7DDDCF53B6C1B";
    case "_encstr_978E1B7AA0C37CE3F62D787A481B4F451F390242D84D3727C916716CD1":
      return "_encstr_99C728EEB22C38B7CDEB77B5AF5B2B7D19E4D21BD8AFD6DCA5CCB27DF633CC342C7323AFD1D039EDDD9B";
    case "_encstr_B6C70ECA2EEAB4C1BED67BC6DE8EBDD9":
      return "_encstr_B63013183693D9F3106D57704B21713FF057049028";
    case "_encstr_BDF90F4D9F8B8702A7B08A52682BBC0B61":
      return "_encstr_AF3B1C2F6B92C3F06E1FE6FB457708061AE3ABB11F699580BD72A8302B35";
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
    case "_encstr_AC7B0F58B7054089918260F89B1AF3A874":
      return "_encstr_823513EE2B0B83F6DC7DBBB5BEDC9B7BDD31168DD8";
    case "_encstr_A9030CABA733D3E82F6A31A995F4":
      return "_encstr_823513EE2B0B83F6DC7DBBB5BEDC9B7BDD31168DD8";
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
    case "_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC":
      self.equiptype = "_encstr_BA7F0830B3A7859B60B0";
      return &"_encstr_9ADE22EB478F3B89F8B76C798799995B18766B48BB4F91E76904874B4150F9BF136BE797";
    case "_encstr_AFBF1E59C5BA5A83BED1D027DBDD2DDCD9BEADDC4B99ACAFCAB1ACD8A393961B":
      self.equiptype = "_encstr_BA7F0830B3A7859B60B0";
      return &"_encstr_A560269A41FA529C7414D4547D9E728965E5824A682DAAA0BEA8A572A4192AAFA2C42A1AA2942586";
    case "_encstr_978E1B7AA0C37CE3F62D787A481B4F451F390242D84D3727C916716CD1":
      self.equiptype = "_encstr_BA7F0830B3A7859B60B0";
      return &"_encstr_B43523782917F49B7537DDCDD09C534DE33A31B00997BB9B2E85D3CEC38527C17149285819";
    case "_encstr_B6C70ECA2EEAB4C1BED67BC6DE8EBDD9":
      self.equiptype = "_encstr_BA7F0830B3A7859B60B0";
      return &"_encstr_83D51E7188A7F47D37F899D1F1DD85AC576F67FB33AF3F0969D49161E823CFA7";
    case "_encstr_BDF90F4D9F8B8702A7B08A52682BBC0B61":
      self.equiptype = "_encstr_BA7F0830B3A7859B60B0";
      return &"_encstr_A97A1FBB01411926D88880D7C057253459F837F9E8324999A79DC8A9425BF361FD";
    case "_encstr_AC7B0F58B7054089918260F89B1AF3A874":
      self.equiptype = "_encstr_BA7F0830B3A7859B60B0";
      return &"_encstr_B2A11FF45927F3219F09DBB36FF569296706EFFCF09F3509A133D5AF4F6EE9E19B";
    case "_encstr_A9030CABA733D3E82F6A31A995F4":
      self.equiptype = "_encstr_AC8F0AE74163F85AAA380AD8";
      return &"_encstr_99D91C4DA1F95433AC3DC870C6907B5D913728C11FF1EB9348F73038CC79";
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
  spawnweapon(self, var_0, 1);
}

watchpickup() {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_8F5C086405E70FBA4B4A", var_0, var_1);
  clearweaponoutlines();

  if(isDefined(var_1)) {
    var_1 sethintdisplayrange(96);
    var_1 setuserange(96);
    var_1 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
    var_1 thread outlinewatchplayerprox();
    var_1 thread watchpickup();
  }
}

vehicle_collision_registereventinternal() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8BE208E31FA8E1631D65");
  self endon("_encstr_AD75063D571AE108");
  var_0 = undefined;

  for(;;) {
    wait 0.05;
    self._id_1292D waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }
    if(istrue(var_1.inlaststand)) {
      continue;
    }
    if(!isDefined(var_1.initialized_gameobject_vars)) {
      continue;
    }
    if(!scripts\mp\gameobjects::proxtriggerlos(var_1)) {
      continue;
    }
    var_0 = var_1 scripts\mp\equipment::getcurrentequipment(self.equiptype);
    var_2 = 0;
    var_3 = checkissameequip(var_1);
    var_4 = checkcurrentequiptypeammocount(var_1);
    var_0 = var_1 scripts\mp\equipment::getcurrentequipment(self.equiptype);

    if(isDefined(var_0) && !var_3 && var_4 > 0) {
      continue;
    }
    var_5 = checkpickupequiptypeammocount(var_1);
    var_6 = var_1 scripts\mp\equipment::getequipmentmaxammo(self.equipment);

    if(var_3) {
      if(var_5 == var_6)
        var_2 = 1;
    }

    if(var_3 && !var_2)
      var_1 scripts\mp\equipment::incrementequipmentammo(self.equipment, 1);

    if(var_3 && var_2) {
      continue;
    }
    if(!isDefined(var_0) || isDefined(var_0) && !var_3 && var_4 == 0)
      var_1 scripts\mp\equipment::giveequipment(self.equipment, self.equiptype);

    var_1 playlocalsound("_encstr_B8151653D6C913796D7967FD87D8DF6FD2AFD28F9680955B");
    clearweaponoutlines();
    self makeunusable();
    self delete();
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
  var_2 = "_encstr_8DFC185F680893323B46DA1BA7E5EA5DAE58ABE7F0B9868A37DC";

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
  var_1.onuncontested = ::calloutmarkerping_watchentitydeathorenemydisconnect;
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
    level.arenaflag thread deleteotpreview();
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
  self._id_126CD = 1;

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
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
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

calloutmarkerping_watchentitydeathorenemydisconnect(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();

  if(var_1 == "_encstr_A7A408B9CA5D1D4E2C63") {
    if(var_0 != "_encstr_8BBA05185F8B99")
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0);
    else if(isDefined(self.lastprogressteam))
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, self.lastprogressteam);
  } else
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, scripts\mp\utility\game::getotherteam(var_1)[0]);

  if(var_0 == "_encstr_8BBA05185F8B99" || var_1 == "_encstr_A7A408B9CA5D1D4E2C63") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
  } else
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
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
  if(level.mapname == "_encstr_A2200CDA13D6CBC897E1A0EBAA93") {
    level.attackerendzone = getEntArray("_encstr_8A9E13034127E2CFB068266D86403D2A8DEDB387E5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level.defenderendzone = getEntArray("_encstr_AF8314333685ECBE9DB7B0637DB0E8E80BB1DAAC27DC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  } else if(level.mapname == "_encstr_8A8F0ABBA391D191182CF008") {
    level.attackerendzone = getEntArray("_encstr_8A9E13034127E2CFB068266D86403D2A8DEDB387E5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level.defenderendzone = getEntArray("_encstr_BD7D139CF0C747800AFD535029D8CB1C6B63404DE3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  } else {
    level.attackerendzone = getEntArray("_encstr_BD7D139CF0C747800AFD535029D8CB1C6B63404DE3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level.defenderendzone = getEntArray("_encstr_8A9E13034127E2CFB068266D86403D2A8DEDB387E5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }

  level.attackerendzone = level.attackerendzone[0] createendzone(game["_encstr_991C0AB9ED5B57161FE89B83"]);
  level.defenderendzone = level.defenderendzone[0] createendzone(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
  level.objectives["_encstr_B40703E96D"] = level.attackerendzone;
  level.objectives["_encstr_B6070359BA"] = level.defenderendzone;
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
  else if(self.targetname == "_encstr_BD7D139CF0C747800AFD535029D8CB1C6B63404DE3")
    var_2 = "_encstr_B40703E96D";
  else
    var_2 = "_encstr_B6070359BA";

  var_3 = undefined;
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
  var_4.firstcapture = 1;
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

  if(istrue(level.setplayerselfrevivingextrainfo))
    var_12 = "_encstr_AFD41A34359BC76B019B6F1992B0E8B7C5E81957C6B02E25CF5E7B4B";
  else
    var_12 = "_encstr_887E1AD64BB1A51D0B2797F519BDD6EB66B1B09DF5B9CAD5D139C2C6";

  var_4.flagmodel setModel(var_12);
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
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosingendzone, level.icontakingendzone);
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
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
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
  var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_A20C07ABF304625E08");
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
    var_5 thread scripts\mp\rank::scoreeventpopup("_encstr_95EB0866891B23FB85B3");
    var_5 thread scripts\mp\awards::givemidmatchaward("_encstr_83A2106BF6C8B2EB237B6BD7CDCAB1ABE42B");
    wait 0.05;
  }
}

startotmechanics() {
  if(level.objmodifier == 1) {
    foreach(var_1 in level.objectives) {
      if(var_1.objectivekey != "_encstr_B20703DFCF")
        var_1 deleteendzone();
    }
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

  level thread _id_13311();
  level.arenaflag.flagmodel playSound("_encstr_841B0DCC36B0D9FAB93885BB372B46");
  scripts\mp\utility\game::setmlgannouncement(10, "_encstr_BD78059C33C543");
  level thread showflagoutline();

  if(istrue(level._id_1343F)) {
    foreach(var_4 in level.players) {
      if(isalive(var_4)) {
        var_5 = var_4 scripts\mp\equipment::getcurrentequipment("_encstr_BA7F0830B3A7859B60B0");

        if(isDefined(var_5) && var_5 == "_encstr_AC7B0F58B7054089918260F89B1AF3A874")
          var_4 scripts\mp\equipment::incrementequipmentammo("_encstr_AC7B0F58B7054089918260F89B1AF3A874", 10);
        else if(!isDefined(var_5)) {
          var_4 scripts\mp\equipment::giveequipment("_encstr_AC7B0F58B7054089918260F89B1AF3A874", "_encstr_BA7F0830B3A7859B60B0");
          var_4 scripts\mp\equipment::incrementequipmentammo("_encstr_AC7B0F58B7054089918260F89B1AF3A874", 10);
        }
      }
    }
  }
}

_id_13311() {
  wait 0.15;

  if(istrue(level.arenaflag._id_126CD)) {
    return;
  }
  foreach(var_1 in level.players) {
    if(var_1 issplitscreenplayer() && !var_1 issplitscreenplayerprimary()) {
      continue;
    }
    var_1 scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_8B6D0940CC35339149DA08");
  }
}

deleteendzone() {
  self notify("_encstr_93D715284F837F1B7888E6A19CF94CC7B0C72BF8430F03");
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

dogtagallyonusecb(var_0) {
  var_0.health = var_0.maxhealth;
  var_0 notify("_encstr_8FB50718DD41DB3FA9");
}

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
  var_3 = getoutlineasset(var_2, var_1);

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

getoutlineasset(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_2 = "_encstr_998806DD1A96D12B";
  var_3 = int(min(var_0, 8));

  switch (var_3) {
    case 0:
      var_2 = "_encstr_AAA514372003FC02452D71B705218BB00E48A3B78099";
      break;
    case 1:
      var_2 = "_encstr_966414C71D2B13C445B879C250917BFBA68C4245BD30";
      break;
    case 2:
      var_2 = "_encstr_9B9D132773AD52F9F829A96FC1E02CCA90F7C797DD";
      break;
    case 3:
      var_2 = "_encstr_9B0F12DE5DE8B15AB9B2F53295834734F54E59C8";
      break;
    case 4:
      var_2 = "_encstr_96AE15674513800375C947242F6863285787EB2916E22F";
      break;
    case 5:
      var_2 = "_encstr_AB6615D8332BB1480ECFA968D748A3F1E15845D1CD325F";
      break;
    case 6:
      var_2 = "_encstr_859613025BCD4BA470C34F7CEBA82BE3E011AA2B21";
      break;
    case 7:
      var_2 = "_encstr_966414C71D2B13C445B879C250917BFBA68C4245BD30";
      break;
    case 8:
      var_2 = "_encstr_9B0F12DE5DE8B15AB9B2F53295834734F54E59C8";
      break;
  }

  if(istrue(level._id_1343F) && isDefined(var_1) && var_1 == "_encstr_A9030CABA733D3E82F6A31A995F4")
    var_2 = "_encstr_AB6615D8332BB1480ECFA968D748A3F1E15845D1CD325F";

  return var_2;
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
  level.icondefending = "_encstr_A9E313D3A8538227B8B8FCDF45C1FB0F9518BAFA30";
}

setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_99E218C8F70963B7F2C56DE05B2AE708769701C063ACFA7F6A2F", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B82918D3A8538227B8B8FCDF4180AF0C953BD94A7831786F7015", 0, "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576", 0);
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
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_976E17BB2CE583B7B4B98EEB19EDB33A85B3E67D9BB5571BC6", 1, "_encstr_88BF06FD784A6393", "_encstr_B40101", "_encstr_A2D11AB4B1B7B9D75B96E65A6B161CD746B7CEA3589DBEDC5BBA6336", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_95641ADDB02F0EBD96CD47FA32B7CE47C2B3E6F5DCDAD51B36F59927", 1, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B40101", "_encstr_A2D11AB4B1B7B9D75B96E65A6B161CD746B7CEA3589DBEDC5BBA6336", 0);
}

isnormalloadouts() {
  return level.arenaloadouts == 1;
}

israndomloadouts() {
  return level.arenaloadouts == 2;
}

ispickuploadouts() {
  return level.arenaloadouts == 3 || level.arenaloadouts == 14;
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

usb_left() {
  return level.arenaloadouts == 7;
}

usbwm() {
  return level.arenaloadouts == 8;
}

usbserver() {
  return level.arenaloadouts == 9;
}

usbvm() {
  return level.arenaloadouts == 10;
}

use_airdrop_fx() {
  return level.arenaloadouts == 11;
}

usbmodel() {
  return level.arenaloadouts == 12;
}

usb_right() {
  return level.arenaloadouts == 13;
}

updatec4vehiclemultkill() {
  return level.arenaloadouts == 14;
}

usb_tape_animation_test() {
  return level.arenaloadouts == 15;
}

usbs_pulled_out() {
  return level.arenaloadouts == 16;
}

_id_1343F() {
  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"]) || istrue(level.brmissionscompleted)) {
    level.startweapon.weapon = "_encstr_AC7B0F58B7054089918260F89B1AF3A874";
    level.lethaldelay = 0;
    defineplayerloadout(1);
  }

  initweaponmap();
  thread _id_1326D();
}

_id_1326D() {
  level.arenaweapont1.weapon = "_encstr_AC7B0F58B7054089918260F89B1AF3A874";

  if(!istrue(level.brmissionscompleted) && !istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
    level.arenaweapont1.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont1.weapon, "_encstr_AC7B0F58B7054089918260F89B1AF3A874");
    level.arenaweapont2.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont2.weapon, "_encstr_AC7B0F58B7054089918260F89B1AF3A874");
    level.arenaweapont3.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont3.weapon, "_encstr_AC7B0F58B7054089918260F89B1AF3A874");
    level.arenaweapont4.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont4.weapon, "_encstr_AC7B0F58B7054089918260F89B1AF3A874");
    level.arenaweapont5.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont5.weapon, "_encstr_AC7B0F58B7054089918260F89B1AF3A874");
    level.arenaweapont6.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont6.weapon, "_encstr_AC7B0F58B7054089918260F89B1AF3A874");
    level.arenaweapont7.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont7.weapon, "_encstr_AC7B0F58B7054089918260F89B1AF3A874");
    level.arenaweapont8.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont8.weapon, "_encstr_AC7B0F58B7054089918260F89B1AF3A874");
  }

  level._id_12344 = 0;
  var_0 = scripts\engine\utility::getStructArray("_encstr_914C0EDDB20B837BB97D38D2365BAB83", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(istrue(level.brmissionscompleted) || istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"]) || level.arenaloadouts != 3) {
      spawnweapon(var_2, level.arenaweapont1);
      continue;
    }

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

_id_144F3(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_8F5C086405E70FBA4B4A", var_2, var_3);
  var_4 = 0;
  var_5 = checkissameequip(var_2);
  var_6 = checkpickupequiptypeammocount(var_2);

  if(self.equipment == "_encstr_AC7B0F58B7054089918260F89B1AF3A874")
    var_7 = 10;
  else
    var_7 = 1;

  var_8 = checkcurrentequiptypeammocount(var_2);
  var_9 = 1;

  switch (var_1) {
    case "_encstr_AD0D0571F995A0":
      var_9 = 10;
      break;
    case "_encstr_8CC708B8AB0DAA055BFF":
      var_9 = 5;
      break;
    default:
      var_9 = 1;
      break;
  }

  if(var_5) {
    if(var_6 == var_7)
      var_4 = 1;
  }

  if(var_5 && !var_4)
    var_2 scripts\mp\equipment::incrementequipmentammo(self.equipment, var_9);
  else if(var_8 && !var_5 && !isPlayer(var_0))
    var_2 dropoldequipinplace(var_2 scripts\mp\equipment::getcurrentequipment(self.equiptype));

  if(!var_5) {
    var_2 scripts\mp\equipment::giveequipment(self.equipment, self.equiptype);

    if(self.equipment == "_encstr_AC7B0F58B7054089918260F89B1AF3A874" && !var_4)
      var_2 scripts\mp\equipment::incrementequipmentammo(self.equipment, var_9);
  }

  if(var_5 && var_4) {
    var_2 iprintlnbold(&"_encstr_BA031F35A0FA5239A3509AA2FAF427C495F2548A5552A0D42A9C2AEB9A140BA222");
    thread watchequipmentpickup();
  } else {
    var_2 playlocalsound("_encstr_B8151653D6C913796D7967FD87D8DF6FD2AFD28F9680955B");
    playFX(level._id_13443["_encstr_8BE007AB0FE8607F9B"], self.origin);
    clearweaponoutlines();

    if(!isPlayer(var_0))
      level thread _id_14398(var_0);

    self makeunusable();
    self delete();
  }
}

_id_14398(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 15;
  playFX(level._id_13443["_encstr_8BE007AB0FE8607F9B"], var_0.origin);
  spawnweapon(var_0, level.arenaweapont1);
}

_id_13441() {
  level scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  wait 1;
  self allowmelee(0);
}

removefromlittlebirdmglistondeath() {
  if(scripts\mp\utility\game::matchmakinggame())
    return getdvarint("_encstr_866C1458C62A100B1BCFF087074A3DA33C8D231F6724", 0);
  else if(validateevents(level.arenaweapont1.weapon) && validateevents(level.arenaweapont2.weapon) && validateevents(level.arenaweapont3.weapon) && validateevents(level.arenaweapont4.weapon) && validateevents(level.arenaweapont5.weapon) && validateevents(level.arenaweapont6.weapon) && validateevents(level.arenaweapont7.weapon) && validateevents(level.arenaweapont8.weapon)) {
    if(validateevents(level.startweapon.weapon))
      return 2;
    else
      return 1;
  }

  return 0;
}

validateevents(var_0) {
  if(var_0 == "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381" || var_0 == "_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC" || var_0 == "_encstr_AFBF1E59C5BA5A83BED1D027DBDD2DDCD9BEADDC4B99ACAFCAB1ACD8A393961B" || var_0 == "_encstr_978E1B7AA0C37CE3F62D787A481B4F451F390242D84D3727C916716CD1")
    return 1;
  else
    return 0;
}

player_give_intel_3_ks() {
  switch (level.calloutmarkerpingvo_getcalloutaliasstringvehicle) {
    case "_encstr_B12F1220EBA20B8BB7A7656F984F30B70F0348C0":
    case "_encstr_995B109BAB0756E47DCA5B837D914EEDB995":
    case "_encstr_955F12039B0FAFA2B9AD353BBF18A113B6704AEA":
      level.calloutmarkerpingvo_getcalloutaliasstringvehicle = "_encstr_96F610C7E33F527201D9B5BD3029AC9B1841";
      break;
    default:
      break;
  }

  return level.calloutmarkerpingvo_getcalloutaliasstringvehicle;
}