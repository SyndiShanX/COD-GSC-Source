/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_alt_mode_escape.gsc
***********************************************/

init() {
  if(!getdvarint("_encstr_BABB17E68D9CFA4C27FA58B13AFADADEC82BEBACDC8DB0C1CA", 0)) {
    return;
  }
  ammorestock_customlocale6cleanup();
  level.obit_activation = spawnStruct();
  level.obit_activation._id_14385 = getdvarfloat("_encstr_8B611CCD3639FAC4E4D795B936C2C1B2F52D9B8DF6AD5AB9EC7D8E5A5B2B", 240.9);
  level.obit_activation._id_1438F = getdvarfloat("_encstr_95841B3FBB4A29FE033111DB9A27AFA0A902ABB73076A0308F9BE8ADC2", -1);
  level.obit_activation._id_129DB = getdvarfloat("_encstr_AB5D1EA3FA0368D022E77B4FC3CE08CD0F4379C9A29FA060BEB6731FFC343885", 10) + level.obit_activation._id_14385;
  level.obit_activation._id_13B6E = getdvarfloat("_encstr_93EF2667B0E3EF925D109F126623EB9DEEB0878768BE093A5915A70154D9722EB658530758F34502", 20);
  level.obit_activation._encstr_84F21273D01ADBDA9308A90D817F98B3FE075A20 = getdvarfloat("_encstr_B1D81DC7CF3EF162681EB73AB1D8B8EAAF493737BBF06A5750A32A0929A0E0", 30);
  level.obit_activation._id_129D7 = getdvarfloat("_encstr_91F61EB98DC9FA3127FA959B6C0B1CB2F54EB0462DB7FAD28CD8CAD7E84BDAAC", 45);
  level.obit_activation.unset_forced_aitype = getdvarint("_encstr_AF342AC31EE3D73E4561824A20C735DFD9F5674DAE6977C20349BB924883ED67B36DB3C545B6AF8D33D8622A", 0);
  level.obit_activation._id_12C73 = getdvarint("_encstr_B6682A6E6CC9AF4C27F50BC6D1BE6B7B4659BE5637C62C07B2BE932C19D2F6EBE4956EACA37DDBB9F5DBDE89", 1);
  level.obit_activation._encstr_BDAA153D52BA4B8BE5B37848C737A09F12FD24342AB239 = getdvarint("_encstr_B2C528485FA2260DE3690799BB694B681CFFA160F74B39E1BA01861797E287D64FBFF0391FE691DF42F3", -15);
  level.obit_activation.unset_just_keep_moving = getdvarint("_encstr_9159286EC693BE1393AF0BC6D1FADAB7322BFA2BB91BB0382BAF593C3AB2E68C5919BEB359396EA5DEDC", 1);
  level.obit_activation._id_129D6 = getdvarint("_encstr_ACC930E6364EFA26397D58C61DEBDA7B3256FACAE6D858C1AC7D93C2234BB7EB46CAB1594756AF1BB7DE8ED74E0B915A5737", 128);
  level.obit_activation.onspawn_fastspeed = getdvarint("_encstr_A7B227DFB71B90503A9979D07B2F1030D2370F0B1FD2478845E1034967F1C8606BCB97A9CFBA1A7888", 900);
  level.obit_activation.onspawn_slowspeed = getdvarint("_encstr_971124670FA32898E241B128B3E7A8789A7F47C3D71A8FD00DA9DB81DF8980B8B393CF7F1732", 15000);
  level.obit_activation._id_129D5 = getdvarint("_encstr_8AE0299B10959F0DB0D71120192F3052D573D78D9B12A89FB7A9484F08B375F6D3D7D202BB595FB8E94947", 1);
  level.obit_activation.start_fly_over = getdvarint("_encstr_B69633CDC627F52693BEB0C6A37DB5F6C856F595E68D160E59D7E4C28CB47BFA4B7336DEB52DE6D9BE27ACE607C277DCEBA35AB6B2", 30);
  level.obit_activation.personalscorecount = getdvarint("_encstr_AAEF2F802A829F69E36F87093C2FF0B76FD26988831E1BE3974716F704DF780F57FA9088B9F25BDB1B619C782773E0237F", 10);
  level.obit_activation._id_129D8 = getdvarint("_encstr_BAA92D1BAE0A814EA3F75341735901B8B4870651D243387F0A0F6D632B4258F1451E6A6EBBA180BDC1FF5D174FEA9E", 15);
  level.obit_activation.personalnukecostoverride = getdvarint("_encstr_A3F7309F3BE2AF40BB0107EA63B7CA70A7CD813743485FEFED89F507C96007182899FA5B67C63DFE5BD7538AA658707D1F63", 5);
  level.obit_activation.obj_destroy_tanks = [];
  level.obit_activation.obj_fob1 = [];
  level.obit_activation.obj_cleanup = [];
  level.obit_activation.obj_a_covers = [];
  level.obit_activation._id_12345 = 0;
  level.obit_activation._id_129DA = -1;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3CC128B305334B193FFCD89DE996AE619E80B5F"] = "_encstr_BECC16DAFEAD3A0F3BD0B7EF5096E48247956996E923637D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B4CE18E49513D24E47D07DB0B359CDECCAD7E89585B5D6858EAC"] = "_encstr_B4CE18E49513D24E47D07DB0B359CDECCAD7E89585B5D6858EAC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84A0116030A58FCA831B2E186558091BD878D0"] = "_encstr_84A0116030A58FCA831B2E186558091BD878D0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9571117507B22308D4BC4639E4BBD8EE2A6FC1"] = "_encstr_82C61F5B5BBE1AFA2070A1F2C9103E2280CD979F235532B4511924BA612074AAED";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AC030F2243FA28039C50BE0573D1B0BD47"] = "_encstr_8A4A1D9C2B265A4ED186BE93B2B4DC667B39B1CAADCA9BE8BEB2DC912DCDEC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9ADC1927CA4CB4E43A86F58E2B2CD6B6B0A3ACD72795DC382CBBCD"] = "_encstr_9ADC1927CA4CB4E43A86F58E2B2CD6B6B0A3ACD72795DC382CBBCD";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BDBE1E5687A547BE37D14E588EACB3CBFA6CA1BD1C83CA93BE2D374CF6AE9B46"] = "_encstr_BDBE1E5687A547BE37D14E588EACB3CBFA6CA1BD1C83CA93BE2D374CF6AE9B46";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81851CAF5B665ABBFF91DFA16D836BB183FF76575063E2A17728E834F065"] = "_encstr_9384208D0EC4FA56B98D2C0E95D76C0DBD83C195937D36DEADADDCF5DBCDD84B7395";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8CA11E6033338CF172EB4053D9221F03C9204978FD60ABA1E288836179123B73"] = "_encstr_8CA11E6033338CF172EB4053D9221F03C9204978FD60ABA1E288836179123B73";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7B91D9AA37E57CAF05F9A913148D5671F1872E2C945F7C330778596DB4018"] = "_encstr_A7B91D9AA37E57CAF05F9A913148D5671F1872E2C945F7C330778596DB4018";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8D471EF7389FA359478B5003C3D56432C1C2D28BF64FBB74E79BE10AFF81EA85"] = "_encstr_8D471EF7389FA359478B5003C3D56432C1C2D28BF64FBB74E79BE10AFF81EA85";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88651E1A889B5B3F530D424925B997A04F8082F3281F93DB49786713A840772D"] = "_encstr_88651E1A889B5B3F530D424925B997A04F8082F3281F93DB49786713A840772D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA341EE7501C6139784B4DD6931D590A4E6CEDE3630973C27E80812281396305"] = "_encstr_AA341EE7501C6139784B4DD6931D590A4E6CEDE3630973C27E80812281396305";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD011FCAC34BD1EB6E1D9CB0E89576E5D7B1AC9B377D470D85E67D6C03BEE6958D"] = "_encstr_AD011FCAC34BD1EB6E1D9CB0E89576E5D7B1AC9B377D470D85E67D6C03BEE6958D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_92011F93BBCA65991B733B519BF5A01B41731B073FF12D6821CD8603D3E7485D3A"] = "_encstr_92011F93BBCA65991B733B519BF5A01B41731B073FF12D6821CD8603D3E7485D3A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BAF61FCAC39647F5CD3A935847CA9DE5FAB1B26EDCBE474385E6FAC803FAE62BC6"] = "_encstr_BAF61FCAC39647F5CD3A935847CA9DE5FAB1B26EDCBE474385E6FAC803FAE62BC6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BA151FA91861A8A023CBC5EBE36AF4983F75D1E342EF60E3FABBA7538A91C6B0DB"] = "_encstr_BA151FA91861A8A023CBC5EBE36AF4983F75D1E342EF60E3FABBA7538A91C6B0DB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88391EB15A08AB167F733829C16A3980E982CD8FB7292CCBF9A53FF3A1BA9577"] = "_encstr_88391EB15A08AB167F733829C16A3980E982CD8FB7292CCBF9A53FF3A1BA9577";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AC4B160F9BF1C1A363AF2AE6F5032AB7D8709F9F5868361A"] = "_encstr_AC4B160F9BF1C1A363AF2AE6F5032AB7D8709F9F5868361A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_968215A18A06D3391D5E2302450850AE3FB39F3F526519"] = "_encstr_968215A18A06D3391D5E2302450850AE3FB39F3F526519";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AB2819E54350ABA197C8434AF083E7D7CE2E699C5338BFB747388A"] = "_encstr_AB2819E54350ABA197C8434AF083E7D7CE2E699C5338BFB747388A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E0D1D9538B2C9F66BC398082B95092B39221FADD48AD73B34E338887FBCA0"] = "_encstr_8E0D1D9538B2C9F66BC398082B95092B39221FADD48AD73B34E338887FBCA0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8D6C1B48C0ABD5C1CABB2AB72BC52F3F77CA0650CCDFB8568160704691"] = "_encstr_8D6C1B48C0ABD5C1CABB2AB72BC52F3F77CA0650CCDFB8568160704691";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_951F17DC11C7D9912083A069CAB86333B7ABDDCE69CB818F08"] = "_encstr_951F17DC11C7D9912083A069CAB86333B7ABDDCE69CB818F08";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5B71679DFE315E98368B880355B49407A736233D32F604A"] = "_encstr_A5B71679DFE315E98368B880355B49407A736233D32F604A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BAFA1BCAC39647F5CD3A935847CA9DE5FA8DB04E9CD256937D467BDDE6"] = "_encstr_BAFA1BCAC39647F5CD3A935847CA9DE5FA8DB04E9CD256937D467BDDE6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B19E1A59F0D21DFAE6D1C958D12B76E5AF1BB0C99C5AB2C9EB1A961D"] = "_encstr_B19E1A59F0D21DFAE6D1C958D12B76E5AF1BB0C99C5AB2C9EB1A961D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_97E11CACC35AE8FADC8EE416E8569DE5AFC985232DED7DB1B0274EB459C9"] = "_encstr_97E11CACC35AE8FADC8EE416E8569DE5AFC985232DED7DB1B0274EB459C9";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9A1D162B0FB41DBE373A9CB0E895D9CBFAE6AE39EC2DCE2B"] = "_encstr_9A1D162B0FB41DBE373A9CB0E895D9CBFAE6AE39EC2DCE2B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A9631DCA3C4B47AFCD3A27B0D1B23BE5AFAE38C80B8ECABE0DACC2234BDCD9"] = "_encstr_A9631DCA3C4B47AFCD3A27B0D1B23BE5AFAE38C80B8ECABE0DACC2234BDCD9";
  level.obit_activation._id_13BFD = getdvarint("_encstr_8EF82163396E27C6F0D711146971CD1F9D11398A834E973A10EF1FE94549D34FB18963", 300.9);
  level.obit_activation._id_145CD = level.obit_activation._id_13BFD;
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::_id_12069);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_8E1318E912B74D912D942347ADD240B763DBE3373A977F38C366", ::vehicle_spawn_mp_gamemodesupportsrespawn);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8C4512C19C95E9E6141B0BBC2BC9B496D8B1AC32", ::onplayerkilled);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8B4A08AC3746E8165B56", ::obit_trigger_for_player);

  if(getdvarint("_encstr_8DE12B6E369CFA13C9AF16638E7DDAEDC8CA7D95E6B1168356D7CDB6D21CD7B473A51D96B063F5D85A4E8D8D2B", 0)) {
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_9B301516FE3D63ED424F23FBBB303F938931ABCE2B26B3", ::init_relic_aggressive_melee);
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_B1130F58C89145BD6813990CA473335A36", ::being_hacked);
  }

  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B10("_encstr_B8CB0D83F5B80B4A0811E7B768D0A9", 180);

  if(getdvarint("_encstr_8FC028BB0F58195BEE36B2DB994FCB4FD9F32C24DFE0DF5797E9AB12E69EA782D853D587336866EBB101", 0) == 0) {
    if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_9B220634456A5747"))
      level _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B220634456A5747");

    level.usegulag = 0;
    level.obit_activation._id_121AD = 3;
    level thread _encstr_95992DE6D827D21C3A6EF2ADE0BC9DC2B6953ABC0E56B9F28939D7760BD6593AE583CABE4E59C4D2C9D143719DE6C6::enabledskiplaststand();
  } else {
    level.disable_super_in_turret._id_12CA4 = 1;
    level.disable_super_in_turret.fly_to_laser_trap_start_pos = 1;
    level.disable_super_in_turret._id_14081 = 1;
    _encstr_95992DE6D827D21C3A6EF2ADE0BC9DC2B6953ABC0E56B9F28939D7760BD6593AE583CABE4E59C4D2C9D143719DE6C6::end_reach_icbm_launch();
    var_0 = 30;
    level.disable_super_in_turret._id_12A7B = var_0;
    level.playingtutorialdialogue["_encstr_BADF16AD165ED0F6B99B96C895E40A3616CBB2E488AC5846"] = _encstr_95992DE6D827D21C3A6EF2ADE0BC9DC2B6953ABC0E56B9F28939D7760BD6593AE583CABE4E59C4D2C9D143719DE6C6::empty_function;
    level.playingtutorialdialogue["_encstr_AB11161D39D23B76954E29AC6E832CEE377ACE95E436C2F2"] = _encstr_95992DE6D827D21C3A6EF2ADE0BC9DC2B6953ABC0E56B9F28939D7760BD6593AE583CABE4E59C4D2C9D143719DE6C6::end_silo_thrust;
    level.playingtutorialdialogue["_encstr_992B1791C362CB50F215A1F8C7CC91863A1B71278F5A98E82C"] = _encstr_95992DE6D827D21C3A6EF2ADE0BC9DC2B6953ABC0E56B9F28939D7760BD6593AE583CABE4E59C4D2C9D143719DE6C6::end_intro_obj;
    level.playingthrowingknifewickfx["_encstr_BADF16AD165ED0F6B99B96C895E40A3616CBB2E488AC5846"] = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::dynamic_door;
    level.playingthrowingknifewickfx["_encstr_AB11161D39D23B76954E29AC6E832CEE377ACE95E436C2F2"] = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_13DCC;
    level.playingthrowingknifewickfx["_encstr_992B1791C362CB50F215A1F8C7CC91863A1B71278F5A98E82C"] = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_11E23;
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_BADF16AD165ED0F6B99B96C895E40A3616CBB2E488AC5846", ::add_pack_playeranim);
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AB11161D39D23B76954E29AC6E832CEE377ACE95E436C2F2", ::add_pilot_setup);
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_992B1791C362CB50F215A1F8C7CC91863A1B71278F5A98E82C", ::add_pack_startfunc);
  }

  level.nosuspensemusic = 1;
  level._id_11E96 = 1;
  level._id_1205E = ::_id_131A9;
  thread ai_hold_wake_watch();
  thread anyone_can_see_spawner();
  thread ammoids();
  level._id_13364 = 1;
  level.disable_super_in_turret._encstr_93D40F204FBF4B78A8B843C1835B487380 = getdvarint("_encstr_A2D722620E2531AA83296B5FE0796F5BF188AA1FEE818AE209416F53F9535D63913F7355", 1);
  level._id_133EA = getdvarint("_encstr_BA2D1EDC1B9CFA4CB6EDEBB95BB41C5D2B2C0EBDDC229CDE0E9ECD22B2161DD0", 0);
}

updatenukeprogress(var_0) {
  if(!isDefined(level.obit_activation.radio) || !isDefined(level.obit_activation.radio.ownerteam))
    return 0;

  return var_0.team == level.obit_activation.radio.ownerteam;
}

addtodismembermentlist(var_0) {
  foreach(var_2 in scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B")) {
    var_3 = !isalive(var_2);

    if(var_2 != var_0 && var_3) {
      var_2 notify("_encstr_8AC8131EA7E8A61728E3D36AABAF739F48019177CD");
      var_2 _encstr_95992DE6D827D21C3A6EF2ADE0BC9DC2B6953ABC0E56B9F28939D7760BD6593AE583CABE4E59C4D2C9D143719DE6C6::end_ml_p3_exfil();
    }
  }
}

add_pack_playeranim(var_0) {
  var_1 = "_encstr_BADF16AD165ED0F6B99B96C895E40A3616CBB2E488AC5846";

  if(updatenukeprogress(var_0) && isDefined(level.playingtutorialdialogue[var_1])) {
    if(level.obit_activation.radio.owner == var_0) {
      addtodismembermentlist(var_0);
      return [[level.playingthrowingknifewickfx[var_1]]](var_0);
    } else
      return [[level.playingtutorialdialogue[var_1]]](var_0);
  } else if(isDefined(level.playingthrowingknifewickfx[var_1]))
    return [[level.playingthrowingknifewickfx[var_1]]](var_0);

  return undefined;
}

add_pilot_setup() {
  return _id_12182("_encstr_AB11161D39D23B76954E29AC6E832CEE377ACE95E436C2F2");
}

add_pack_startfunc() {
  return _id_12182("_encstr_992B1791C362CB50F215A1F8C7CC91863A1B71278F5A98E82C");
}

_id_12182(var_0) {
  var_1 = self;

  if(updatenukeprogress(var_1) && level.obit_activation.radio.owner != var_1 && isDefined(level.playingtutorialdialogue[var_0]))
    return [[level.playingtutorialdialogue[var_0]]]();
  else if(isDefined(level.playingthrowingknifewickfx[var_0]))
    return [[level.playingthrowingknifewickfx[var_0]]]();
}

ai_hold_wake_watch() {
  if(level.obit_activation._id_129DA == -1) {
    level waittill("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
    waitframe();

    if(!istrue(level.br_circle_disabled)) {
      while(!isDefined(level.br_circle) || !isDefined(level.br_circle.safecircleent))
        waitframe();
    }

    _encstr_BEAF12FFA8EBEB9A712502FE9D6B32BC30D05F87(1);
  } else
    _encstr_BEAF12FFA8EBEB9A712502FE9D6B32BC30D05F87(4);
}

_encstr_BEAF12FFA8EBEB9A712502FE9D6B32BC30D05F87(var_0) {
  var_1 = obj_a_post_behavior();
  level.obit_activation.radio = ai_goto_ascender_and_wait(var_1 + (0, 0, 10), var_0);
  level thread obj_fob1_juggs(level.obit_activation.radio);
  ai_dropgren_override_hide();
  scripts\mp\flags::gameflagwait("_encstr_B28811BA9B8952D39F1FE35F99DFCFC398101B");
  ai_give_flashlight(var_0);
  level thread obit_destroy_old_vehicles(level.obit_activation.radio, var_0);
}

ammorestock_customlocale6cleanup() {
  if(!getdvarint("_encstr_8DE12B6E369CFA13C9AF16638E7DDAEDC8CA7D95E6B1168356D7CDB6D21CD7B473A51D96B063F5D85A4E8D8D2B", 0)) {
    return;
  }
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_84EC163339208BC548FB4A5DC74BCAEF59D1B8CA6085477A");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A5D50F0ED8C2DC9535E616E051F6F4D312");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_A92C15EAC13B1A65AF90871768635B829B7636673B4B83");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_913C1133FB03C75D8B11220B40EBDAD3D9DEAC");
}

init_relic_aggressive_melee() {
  var_0 = (level.br_level.default_class_chosen[1][0], level.br_level.default_class_chosen[1][1], 0);
  var_1 = level.br_level.br_circleradii[1];
  var_2 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::createtestc130path(var_0, var_1);
  return var_2;
}

being_hacked() {
  thread vehomn_getleveldata();
}

vehomn_getleveldata() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = distance(self._id_12205.startpt, self._id_12205.neurotoxin_damage_monitor);
  var_1 = var_0 / _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::getc130speed() - 5;
  wait(var_1);

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_3.br_infil_type) && var_3.br_infil_type == "_encstr_969105B1C4CC81" && !isDefined(var_3.jumptype)) {
      var_3.jumptype = "_encstr_8A720C58B3AB7729A26778B853CB";
      var_3 notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
    }
  }
}

ammoids() {
  if(!getdvarint("_encstr_8DE12B6E369CFA13C9AF16638E7DDAEDC8CA7D95E6B1168356D7CDB6D21CD7B473A51D96B063F5D85A4E8D8D2B", 0)) {
    return;
  }
  waittillframeend;
  level.br_level.br_circledelaytimes[1] = level.br_level.br_circledelaytimes[0];
  level.br_level.br_circledelaytimes[0] = 1;
  level.br_level.br_circleclosetimes[0] = 1;
  level.br_level.default_player_connect_black_screen[0] = 1;
}

obj_fob2(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_A5B71679DFE315E98368B880355B49407A736233D32F604A", 0, var_0);
  wait 1.5;
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_951F17DC11C7D9912083A069CAB86333B7ABDDCE69CB818F08", 0, var_0);
}

obj_fob1_juggs(var_0) {
  level endon("_encstr_AA7E144A4791AB3D3768F3632D7F81EFFF08347031BB");

  if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    var_1 = [1000, 3000, 5000, 7000, 13000];
    var_2 = [0, 30, 90, 120, 180];
  } else {
    var_1 = [3000, 7000, 10000, 13000, 17500];
    var_2 = [0, 45, 90, 135, 180];
  }

  level.obit_activation._id_129D4 = gettime() + level.obit_activation._id_14385 * 1000;
  var_3 = level.obit_activation._id_14385;
  var_4 = undefined;
  var_5 = -1;

  if(level.obit_activation._id_14385 > var_2[4])
    var_5 = 4;
  else if(level.obit_activation._id_14385 > var_2[3])
    var_5 = 3;
  else if(level.obit_activation._id_14385 > var_2[2])
    var_5 = 2;
  else if(level.obit_activation._id_14385 > var_2[1])
    var_5 = 1;
  else if(level.obit_activation._id_14385 > var_2[0])
    var_5 = 0;

  if(var_5 < 0)
    wait 3;

  while(var_5 >= 0) {
    var_3 = var_3 - var_2[var_5];
    var_0 ai_ascender_giveascender(var_1[var_5]);
    scripts\mp\flags::gameflagwait("_encstr_B28811BA9B8952D39F1FE35F99DFCFC398101B");

    if(var_5 == 0) {
      ai_fire_at_chopper(var_2[1]);
      var_4 = scripts\engine\utility::play_loopsound_in_space("_encstr_B409126447BAD816EFC78DC8E3BCF90E78914D88", var_0.origin);
    }

    var_6 = ai_ascender_getclosestdescender(var_3);

    if(!isDefined(var_6))
      var_5 = 0;

    var_0 ai_ascender_getstartpos();
    var_3 = var_2[var_5];
    var_5--;
  }

  var_0 ai_ascender_getstartpos();

  if(isDefined(var_4))
    var_4 delete();

  level.obit_activation._id_129DA = 1;
  level notify("_encstr_96BD0D8BD2530BC061DC6B7DFCD7A0");
}

obit_destroy_old_vehicles(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AA7E144A4791AB3D3768F3632D7F81EFFF08347031BB");

  foreach(var_3 in level.players) {
    if(!var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal())
      var_3 scripts\mp\hud_message::showsplash("_encstr_8B701928CE0F6F9F431AA05A97E2C311282F9E2AF559275388F820");
  }

  var_5 = 255;
  var_6 = level.obit_activation._id_14385;
  var_7 = level.obit_activation._id_14385;
  ai_extra_think(var_1, var_5, var_6, 0);
  ai_fire_at_chopper(var_7);
  level waittill("_encstr_96BD0D8BD2530BC061DC6B7DFCD7A0");

  foreach(var_3 in level.players) {
    if(!var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal())
      var_3 scripts\mp\hud_message::showsplash("_encstr_A66518921509AF374E290B42F61EB7274B87371C6DE0B2036561");
  }

  obj_hvt_dead("_encstr_968215A18A06D3391D5E2302450850AE3FB39F3F526519", 0.75, 1);
  ai_dropgren_override_hide();
  var_0 ai_hold_wake_behavior("_encstr_81D60AEDCDFAB327F6D57319");
  var_0 ai_goal_distribution_debug();
  var_1 = 2;
  var_5 = 255;
  var_6 = level.obit_activation._id_13BFD;
  var_7 = level.obit_activation._id_145CD;
  level.obit_activation.radio.waittime = var_7;
  ai_extra_think(var_1, var_5, var_6);
  ai_fire_at_chopper(var_7, 1);
  level ai_deaf_event_active(var_0.origin);
}

ai_ascender_getclosestdescender(var_0) {
  return level.obit_activation scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_AAAD0FD8588379C95F1F53DFA7F0514B6F", var_0);
}

obj_a_roof_jugg() {
  if(!isDefined(level.br_level) || !isDefined(level.br_level.br_circledelaytimes))
    return 0;

  var_0 = level.br_level.delay_start_infiltrate_objective;

  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = 0;

  if(level.obit_activation.unset_just_keep_moving)
    var_1 = getdvarint("_encstr_8BF526436895B9E32BF03D23F611F37FA790BBFA4821612FA04E03249D7B87420BC892F230F36547", 6);
  else
    var_1 = getdvarint("_encstr_8BF526436895B9E32BF03D23F611F37FA790BBFA4821612FA04E03249D7B87420BC892F230F36547", 3);

  var_2 = level.br_level.br_circledelaytimes.size - 1 - var_1 - var_0;
  return var_2;
}

relic_amped_victim(var_0) {
  var_1 = 0.0;

  for(var_2 = 0; var_2 < level.br_level.br_circledelaytimes.size && var_2 < var_0; var_2++)
    var_1 = var_1 + (level.br_level.br_circledelaytimes[var_2] + level.br_level.br_circleclosetimes[var_2]);

  return var_1;
}

obj_a_post_behavior() {
  var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
  var_2 = _id_11A00(var_0, var_1);
  var_3 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::play_train_speaker_vo("_encstr_B84407FD927A8B4B25", var_2);
  var_4 = undefined;
  var_5 = "_encstr_8BBA05185F8B99";

  if(isDefined(var_3)) {
    var_4 = var_3.origin;
    var_5 = "_encstr_9A7606B11A95DCD1";
  } else {
    var_6 = 0.0;
    var_7 = 1.0;
    var_8 = 1;
    var_9 = 1;
    var_10 = 1;
    var_11 = level.obit_activation._id_129DB;
    var_4 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_0, var_1, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_4 == var_0) {
      var_12 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
      var_4 = scripts\engine\utility::drop_to_ground((var_4[0], var_4[1], 4000), undefined, undefined, undefined, var_12);

      if(var_9 && isscriptabledefined())
        var_4 = getclosestpointonnavmesh(var_4);
    }

    var_5 = "_encstr_A31207CBF788523281";
  }

  logstring("_encstr_A21417A09B467FE228495D77E92BB8C2EE704B4A8D2D321D0A" + var_0 + "_encstr_AD170408E4A3" + var_1 + "_encstr_B2490AA2B1094CBAEF27E5C8" + var_4 + "_encstr_A31704EE7D02" + var_5);
  return var_4;
}

obj_heli_assault3_fob(var_0) {
  var_1 = self.tracknonoobplayerlocation;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B2270A3E87C886F7C8C1923A");
  level notify("_encstr_93CE13FD790F58B8773373D9AB7778D0A4D17D5FE5");
  var_1 endon("_encstr_AD75063D571AE108");
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(var_4.team == var_0.team) {
      if(var_4 == var_0) {
        level thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_140B1(var_0.origin, "_encstr_9695073995D94BD959");
        var_4 thread ai_dropgren_override_hint("_encstr_81851CAF5B665ABBFF91DFA16D836BB183FF76575063E2A17728E834F065", 4);
        var_4 scripts\mp\hud_message::showsplash("_encstr_860B1FC57229D04E7FFAEB7121030F90FCF73799018E189D8BF143DB496F3508D7");
        var_4 thread ai_dropgren_weapontype("_encstr_9A1D162B0FB41DBE373A9CB0E895D9CBFAE6AE39EC2DCE2B", 0.75, 0);
      } else {
        if(!var_4 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal())
          var_4 thread ai_dropgren_override_hint("_encstr_81851CAF5B665ABBFF91DFA16D836BB183FF76575063E2A17728E834F065", 4);

        var_4 scripts\mp\hud_message::showsplash("_encstr_8C941FAE026953FBF30F83500F1A7199D2ED882F5CC23761DCDF20F02721A8D17B");
        var_4 thread ai_dropgren_weapontype("_encstr_8CA11E6033338CF172EB4053D9221F03C9204978FD60ABA1E288836179123B73", 0.75, 0);
        var_5 = _encstr_92CD26C37908D8EB3D1F670F50C8DA3955FB5BD792B14F9E42836953ACF2D18F7312F230F087FB66::_id_142C5(var_4, var_0, "_encstr_84BA0EF05B473368978245467897F3F5");

        if(var_5 && !var_2) {
          var_2 = 1;
          var_0 thread scripts\mp\hud_message::showsplash("_encstr_A59215D2E33F9B57D0116250A7B5672E4BF9EB538B7D7D");
        }
      }

      continue;
    }

    if(!var_4 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal()) {
      var_4 thread ai_dropgren_override_hint("_encstr_81851CAF5B665ABBFF91DFA16D836BB183FF76575063E2A17728E834F065", 4);
      var_4 scripts\mp\hud_message::showsplash("_encstr_97EA208939BE2BDCB1B0E095FA2758325ABDFAE0D236B559197DBA83F52BB959B5BC");
      var_4 thread ai_dropgren_weapontype("_encstr_A7B91D9AA37E57CAF05F9A913148D5671F1872E2C945F7C330778596DB4018", 0.75, 0);
    }
  }

  var_1 ai_hold_positions_freed();
  var_1 ai_hold_wake_behavior("_encstr_9A990A13739E149BF7605DD9", var_0);
  var_1 ai_dismount_turret();
  var_1.owner = var_0;
  var_1._id_121AE = var_1.ownerteam;
  var_1.ownerteam = var_1.owner.team;
  var_7 = scripts\mp\utility\teams::getteamdata(var_1.ownerteam, "_encstr_9775086022BE1B413B8B");
  _encstr_8C490F0AF1E8673FC027916EC72005AF84(var_7, 1);
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_9B281792FB182F62D80BA0BD5F78AE93BBF0D9FAA0E8A3DFB8");

  if(level.obit_activation.onspawn_fastspeed > 0)
    setteamscore(var_1.ownerteam, getteamscore(var_1.ownerteam) + level.obit_activation.onspawn_fastspeed);

  level.obit_activation._id_12345 = gettime();
  ai_dropgren_override_hide();
  var_8 = 3;
  var_9 = var_0 getentitynumber();
  var_10 = level.obit_activation._id_13BFD;
  var_11 = level.obit_activation._id_145CD;
  ai_extra_think(var_8, var_9, var_10, 0);
  ai_fire_at_chopper(var_11);
  var_1.owner thread obj_heli_assault2();
  var_1.owner thread ai_goal_update_population(var_0);
  level.obit_activation._id_129D1 = var_0.team;
  var_1 notify("_encstr_B2F017295AEB80B7C2E7456B232A702990B491604754B9ED6B");
  var_0 ai_hold_free(var_1);
}

ai_dropgren_override_hint(var_0, var_1) {
  var_2 = self;
  var_2 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A554246C0B378D2BD8D7B2CD8D2C07AC922C8CA5DBA01BB0CBA134DEC138B239222D1663DE76");

  if(isDefined(var_1))
    wait(var_1);

  var_3 = "_encstr_AB7508A1C157AA4A61C7" + game["_encstr_B2DA070A5F8BAB87AF"][var_0];
  var_3 = tolower(var_3);
  var_4 = lookupsoundlength(var_3, 1) / 1000;
  var_2 queuedialogforplayer(var_3, var_0, var_4);
}

ai_dropgren_weapontype(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_93CE13FD790F58B8773373D9AB7778D0A4D17D5FE5");

  if(isDefined(var_1))
    wait(var_1);

  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward(var_0, var_3, var_2);
}

obj_hvt_dead(var_0, var_1, var_2) {
  thread ai_excluder(var_0, var_1, var_2);
}

ai_excluder(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_93CE13FD790F58B8773373D9AB7778D0A4D17D5FE5");

  if(isDefined(var_1))
    wait(var_1);

  foreach(var_4 in level.players)
  var_4 ai_dropgren_weapontype(var_0, undefined, var_2);
}

ai_hold_free(var_0) {
  var_1 = self;
  var_1 endon("_encstr_993D1C5A90CF5EC351588289EDF877695FE87271D0B315AF6BA08F817323");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(level.obit_activation.radio.waittime))
    ai_hold_positions(level.obit_activation.radio.waittime);
  else
    ai_hold_positions(level.obit_activation._id_145CD);
}

mlgmodifyheadshotdamage(var_0) {
  var_1 = self;
  level.obit_activation notify("_encstr_83F715566E1B580E95F5390B8C96F6BE8C9CDB07839532");
  level notify("_encstr_A554246C0B378D2BD8D7B2CD8D2C07AC922C8CA5DBA01BB0CBA134DEC138B239222D1663DE76");
  level notify("_encstr_93CE13FD790F58B8773373D9AB7778D0A4D17D5FE5");
  var_1 notify("_encstr_993D1C5A90CF5EC351588289EDF877695FE87271D0B315AF6BA08F817323");
  var_1 endon("_encstr_993D1C5A90CF5EC351588289EDF877695FE87271D0B315AF6BA08F817323");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread obj_caches_threaded_nags_vo();
  thread obj_a_goals();
  ai_goal_distribution(0);
  var_2 = _encstr_AAA51DF7A0E3F382792D3AF685133ABF4950CB87481921BAA3B047AB7B3352();

  if(var_2 <= 0)
    var_2 = level.obit_activation._encstr_84F21273D01ADBDA9308A90D817F98B3FE075A20;

  var_3 = ceil(var_2 / level.obit_activation._encstr_84F21273D01ADBDA9308A90D817F98B3FE075A20) * level.obit_activation._encstr_84F21273D01ADBDA9308A90D817F98B3FE075A20;
  var_4 = min(level.obit_activation._id_13BFD, var_3);
  level.obit_activation.radio.waittime = min(var_4, var_2 + level.obit_activation._id_13B6E);
  level.obit_activation._id_145CD = level.obit_activation.radio.waittime;
  level.obit_activation.radio ai_hold_positions_freed();
  ai_dropgren_model();

  if(getdvarint("_encstr_8FC028BB0F58195BEE36B2DB994FCB4FD9F32C24DFE0DF5797E9AB12E69EA782D853D587336866EBB101", 0) != 0)
    ai_ground_set_goal_radii(var_1);

  var_5 = scripts\mp\utility\teams::getteamdata(var_1.team, "_encstr_9775086022BE1B413B8B");
  _encstr_8C490F0AF1E8673FC027916EC72005AF84(var_5, 0);
  var_6 = 2;
  var_7 = 255;
  var_8 = level.obit_activation._id_13BFD;
  var_9 = level.obit_activation.radio.waittime;
  ai_extra_think(var_6, var_7, var_8, 0);
  ai_fire_at_chopper(var_9, 1);
  var_10 = var_9 - var_2;
  setomnvar("_encstr_AC621D202FD7C965892F53540492F77351B358788F814171F297D8651CFADB", int(var_10));
  level.obit_activation._id_129D1 = undefined;
  level.obit_activation.radio freescriptable();
  var_11 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_0, var_1.origin, var_1.angles, self, 0, 0, 10, 1);
  level.obit_activation.radio = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup("_encstr_BE7B14B6634847D225A787C7C747EB85298BEEBFB8F8", var_11, 0, 1);
  level.obit_activation.radio.init_weapon_placements = 1;
  level.obit_activation.radio.keepinmap = 1;
  level.obit_activation.radio.hidden = 0;
  level.obit_activation.radio thread ai_deaf_event_active(level.obit_activation.radio.origin);

  foreach(var_1 in level.players) {
    if(!var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal())
      var_1 scripts\mp\hud_message::showsplash("_encstr_91F11A6A3EEE97223FF8EBB221359E2B8028CFEF58B6D7AAFFA0129A");
  }

  obj_hvt_dead("_encstr_AB2819E54350ABA197C8434AF083E7D7CE2E699C5338BFB747388A", 0.75, 1);
  level.obit_activation.radio ai_hold_wake_behavior("_encstr_81D60AEDCDFAB327F6D57319");
}

obj_caches_threaded_nags_vo() {
  if(level.obit_activation._id_12C73 != 1) {
    return;
  }
  level endon("_encstr_93CE13FD790F58B8773373D9AB7778D0A4D17D5FE5");
  level endon("_encstr_A3340AC84A47B388171FC04E");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = undefined;
  var_1 = (0, 0, level.obit_activation._encstr_BDAA153D52BA4B8BE5B37848C737A09F12FD24342AB239);
  var_2 = getEntArray("_encstr_85FE0DD5727A27098513298817CA23", "_encstr_AC110A7F14873B5B3D073009");
  var_3 = getEntArray("_encstr_A9A7153562B7F9D74703D1706BDAB9B6D31728A3CD0BE0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = scripts\engine\utility::array_combine(var_2, var_3);

  for(;;) {
    if(isDefined(level.obit_activation.radio)) {
      if(isDefined(var_0) && var_0 == level.obit_activation.radio.origin) {
        foreach(var_6 in var_4) {
          if(ispointinvolume(level.obit_activation.radio.origin + var_1, var_6)) {
            thread obj_a_behavior();
            level notify("_encstr_A3340AC84A47B388171FC04E");
          }
        }

        break;
      } else
        var_0 = level.obit_activation.radio.origin;
    }

    wait 1;
  }
}

obj_a_behavior() {
  level endon("_encstr_93CE13FD790F58B8773373D9AB7778D0A4D17D5FE5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 2.5;
  obj_hvt_dead("_encstr_8E0D1D9538B2C9F66BC398082B95092B39221FADD48AD73B34E338887FBCA0", 0.0, 1);
  wait 2.5;
  level.obit_activation.radio thread ai_ascender_use(0);
}

obj_a_goals() {
  if(level.obit_activation.unset_forced_aitype != 1) {
    return;
  }
  level endon("_encstr_93CE13FD790F58B8773373D9AB7778D0A4D17D5FE5");
  level endon("_encstr_A3340AC84A47B388171FC04E");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(level.obit_activation._id_129D7 * 0.75);
  obj_hvt_dead("_encstr_8E0D1D9538B2C9F66BC398082B95092B39221FADD48AD73B34E338887FBCA0", 0.0, 1);
  wait(level.obit_activation._id_129D7 * 0.25);
  level.obit_activation.radio thread ai_ascender_use(0);
}

ai_ground_set_goal_radii(var_0) {
  foreach(var_0 in scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B")) {
    var_0 notify("_encstr_8AC8131EA7E8A61728E3D36AABAF739F48019177CD");
    var_0 _encstr_95992DE6D827D21C3A6EF2ADE0BC9DC2B6953ABC0E56B9F28939D7760BD6593AE583CABE4E59C4D2C9D143719DE6C6::_encstr_99FC22AE7BA0550A93C5CBB3B7CB628CF083E736B0180CE276F3EFCB336C5AD4C8C81FBA();
    var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_AD4E116857C3E0D65F68B9EBB997BEC040CF6B", 0);
  }
}

ai_damage_monitor(var_0) {
  if(level.obit_activation._id_129D6 <= 0) {
    return;
  }
  var_1 = canceljoins(undefined, undefined, var_0, level.obit_activation._id_129D6);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(!_encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::update_gamebattles_char_loc(var_3, 0)) {
        continue;
      }
      if(var_3 getscriptableisreserved() && !isDefined(var_3.embassy_main)) {
        continue;
      }
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_11A21(var_3);
    }
  }
}

ai_deaf_event_active(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_B2F017295AEB80B7C2E7456B232A702990B491604754B9ED6B");

  if(level.obit_activation._id_129D6 <= 0) {
    return;
  }
  for(;;) {
    ai_damage_monitor(var_0);
    wait 2;
  }
}

ai_hold_positions(var_0) {
  var_1 = self;
  var_1 endon("_encstr_993D1C5A90CF5EC351588289EDF877695FE87271D0B315AF6BA08F817323");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 thread ai_ascender_takeascender(var_0);
  var_1 thread ai_ground_think(var_0);
  ai_flash_swap(level.obit_activation._id_13BFD);
  ai_fire_at_chopper(var_0);
  wait(var_0);
  ai_dropgren_override_hide();
  ai_delete_after_level_notify(var_1.team, 1);
}

_encstr_AAA51DF7A0E3F382792D3AF685133ABF4950CB87481921BAA3B047AB7B3352() {
  var_0 = gettime() - level.obit_activation._id_12345;
  var_1 = level.obit_activation._id_145CD - var_0 / 1000;

  if(isDefined(level.obit_activation.radio._encstr_B2E61750F34D6BE3DA0D35B3A5A20FD3B57B102017F5039302) && level.obit_activation.radio._encstr_B2E61750F34D6BE3DA0D35B3A5A20FD3B57B102017F5039302 > 0) {
    var_2 = level.obit_activation.radio._encstr_B2E61750F34D6BE3DA0D35B3A5A20FD3B57B102017F5039302 / 1000;
    var_1 = var_1 + var_2;
  }

  return var_1;
}

ai_ascender_takeascender(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B2270A3E87C886F7C8C1923A");
  level.obit_activation endon("_encstr_83F715566E1B580E95F5390B8C96F6BE8C9CDB07839532");
  var_1 endon("_encstr_993D1C5A90CF5EC351588289EDF877695FE87271D0B315AF6BA08F817323");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = 10;
  var_3 = max(0, var_0 - var_2);
  wait(var_3);

  while(var_2 > 1) {
    var_4 = scripts\mp\gamelogic::relic_bang_and_boom_dropfunc(var_2);

    foreach(var_6 in level.players)
    var_6 playlocalsound(var_4);

    var_2 = var_2 - 1;
    wait 1;
  }
}

ai_ground_think(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B2270A3E87C886F7C8C1923A");
  level.obit_activation endon("_encstr_83F715566E1B580E95F5390B8C96F6BE8C9CDB07839532");
  var_1 endon("_encstr_993D1C5A90CF5EC351588289EDF877695FE87271D0B315AF6BA08F817323");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = [];

  if(var_0 >= 240)
    var_2 = [240, 180, 120, 60, 45, 20, 10, 5];
  else if(var_0 >= 180)
    var_2 = [180, 120, 60, 45, 20, 10, 5];
  else if(var_0 >= 120)
    var_2 = [120, 60, 45, 20, 10, 5];
  else if(var_0 >= 60)
    var_2 = [60, 45, 20, 10, 5];
  else if(var_0 >= 45)
    var_2 = [45, 20, 10, 5];
  else if(var_0 >= 20)
    var_2 = [20, 10, 5];
  else if(var_0 >= 10)
    var_2 = [10, 5];
  else if(var_0 >= 5)
    var_2 = [5];

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_0 - var_2[var_3];
    var_0 = var_0 - var_4;
    wait(var_4);

    if(var_2[var_3] <= 60) {
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_969619A863E9F3C743735EEF4B1A8F1A77AB206027874B618A1DC0" + var_2[var_3] + "_encstr_834305A193A339");
      continue;
    }

    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_969619A863E9F3C743735EEF4B1A8F1A77AB206027874B618A1DC0" + var_2[var_3] / 60 + "_encstr_8E43057DADD29B");
  }
}

ai_goto_ascender_and_wait(var_0, var_1) {
  var_2 = easepower("_encstr_BE7B14B6634847D225A787C7C747EB85298BEEBFB8F8", var_0);
  var_2.keepinmap = 1;
  var_3 = 255;
  var_4 = level.obit_activation._id_14385;
  var_5 = level.obit_activation._id_14385;
  ai_extra_think(var_1, var_3, var_4, 0);
  ai_fire_at_chopper(var_5);
  var_2 ai_dismount_turret();
  level.obit_activation.radio = var_2;
  return var_2;
}

ai_hold_debug() {
  self notify("_encstr_8D031FD759CD1B851CB24958C8967BAA1C4685472B921BDB7314DE6EB4D12DEDDC");
  self endon("_encstr_8D031FD759CD1B851CB24958C8967BAA1C4685472B921BDB7314DE6EB4D12DEDDC");
  self endon("_encstr_8A0F179BD069B6F991596BD66D8A90A921613D42E708DC5C79");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    scripts\mp\objidpoolmanager::update_objective_position(self.icon, self.origin + (0, 0, 50));
    waitframe();
  }
}

ai_hold_wake_behavior(var_0, var_1) {
  var_2 = self;

  if(var_0 == "_encstr_9A990A13739E149BF7605DD9")
    var_2 ammobox_giverandomattachment(var_1, "_encstr_AF6E30F533B9AB5239854AC9807607B3815815F752415D26BFDB3E282BCB97B98A3A30BA4A33BF3BE3AFAC66BAA090ABE968", "_encstr_A2792D9B73771AA03EC82B9798D178C2EB186399EBB772F646E8177F0B2B25A9A7A62C8F46F1AA162951474308E001");
  else if(var_0 == "_encstr_81D60AEDCDFAB327F6D57319") {
    var_3 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(var_3 != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(var_3, "_encstr_AF5A081BBAC993AC73A3", var_2.origin + (0, 0, 50), "_encstr_A5662797FBE87870F8BE93392D8EE0991B3E5379D892BAC5410A62E69AEBE7DFD86302DDEF83D9D37F");
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_3, 1);

      foreach(var_5 in level.players) {
        if(!var_5 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal())
          objective_addclienttomask(var_3, var_5);
      }

      objective_showtoplayersinmask(var_3);
      var_2.icon = var_3;
      var_2 thread ai_hold_debug();
    } else {}
  }
}

ai_hold_positions_freed() {
  var_0 = self;
  var_0 notify("_encstr_8A0F179BD069B6F991596BD66D8A90A921613D42E708DC5C79");

  if(isDefined(var_0.icon)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0.icon);
    var_0.icon = undefined;
  }

  if(isDefined(var_0.playersetattractionstateindex)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0.playersetattractionstateindex);
    var_0.playersetattractionstateindex = undefined;
  }

  if(isDefined(var_0.nuke_cancel)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0.nuke_cancel);
    var_0.nuke_cancel = undefined;
  }
}

ai_ascender_giveascender(var_0) {
  var_1 = self;
  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle(var_1.origin, var_0, 0.0, 0.4, 0, 0);
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(4, 8, 4, var_2);
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(var_0);

  foreach(var_4 in level.players)
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336A(var_4);
}

ai_ascender_getstartpos() {
  var_0 = self;

  foreach(var_2 in level.players)
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_dogtags(var_2);
}

ai_goal_update_population(var_0) {
  if(level.obit_activation._id_129D5 != 1) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.obit_activation notify("_encstr_BD8F13876627F298410977A798794C7A877F0F3FC2");
  level.obit_activation endon("_encstr_BD8F13876627F298410977A798794C7A877F0F3FC2");

  if(!isDefined(level._id_13ACA) || !isDefined(level._id_13ACA[var_0.team]) || level._id_13ACA[var_0.team] == 0)
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12972(var_0.team);

  for(;;) {
    level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_1);
    var_2 = level.br_circle.circleindex + 1;

    if(var_1 >= var_2) {
      if(level._id_13ACA[var_0.team] + var_2 <= var_1 + 1) {
        level._id_13ACA[var_0.team] = undefined;
        _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12972(var_0.team);
      }
    }
  }
}

ai_dropgren_model() {
  level.obit_activation notify("_encstr_BD8F13876627F298410977A798794C7A877F0F3FC2");
}

ai_dismount_turret() {
  var_0 = self;
  var_0.hidden = 1;
  var_0 setscriptablepartstate("_encstr_BE7B14B6634847D225A787C7C747EB85298BEEBFB8F8", "_encstr_95DF070DD22319CA9B");
}

ai_goal_distribution_debug() {
  var_0 = self;
  var_0.hidden = 0;
  var_0 setscriptablepartstate("_encstr_BE7B14B6634847D225A787C7C747EB85298BEEBFB8F8", "_encstr_BE8B08E323FB2BCD6268");
}

obit_trigger_for_player(var_0) {
  level thread ai_dropgren_override_hide();
  ai_delete_after_level_notify(var_0);
}

ai_delete_after_level_notify(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = level.obit_activation.radio.ownerteam;

  if(istrue(var_1)) {
    thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AF36133B4BA241B065DAE6B90541588BAADF81B31B"], undefined, undefined, undefined, 1);
    return;
  }

  var_2 = getarraykeys(level.teamdata);
  var_3 = [];

  foreach(var_5 in var_2) {
    if(var_5 == var_0)
      setteamscore(var_5, getteamscore(var_5) + level.obit_activation.onspawn_slowspeed);

    if(level.teamdata[var_5]["_encstr_8A2A0B936CCCC3078547970A8B"] > 0)
      var_3[var_3.size] = var_5;
  }

  var_7 = scripts\mp\utility\script::quicksort(var_3, ::ammorestock_disableusefortime);

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_5 = var_7[var_8];
    var_9 = var_8 + 1;
    thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1209B(var_5, var_9, 0, 1, undefined, var_5 == var_0);
  }

  foreach(var_5, var_11 in level.teamdata) {
    if(var_5 == var_0) {
      var_12 = scripts\mp\utility\teams::getteamdata(var_5, "_encstr_9775086022BE1B413B8B");
      _encstr_8C490F0AF1E8673FC027916EC72005AF84(var_12, 0);
      continue;
    }

    var_13 = scripts\mp\utility\teams::getteamdata(var_5, "_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE");

    if(var_13.size > 0) {
      foreach(var_15 in var_13) {
        var_15 freezecontrols(1);
        var_15 playerhide();
      }
    }
  }
}

ammorestock_disableusefortime(var_0, var_1) {
  var_2 = getteamscore(var_0);
  var_3 = getteamscore(var_1);
  return var_2 >= var_3;
}

_id_11A00(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_12FA3 = "_encstr_B16718DF8753BD6855FA81B92D27286558FF4F493FA8F6709950";
  var_2._id_12F9F = var_0;
  var_2._id_12FA6 = var_1;
  var_2._id_12FA7 = 0;
  var_2._id_12FA1 = 1;
  var_2.mintime = level.obit_activation._id_129DB;
  return var_2;
}

ammobox_giverandomattachment(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_4 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_4, "_encstr_AF5A081BBAC993AC73A3", var_3.origin, var_1);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_4, 1);
    var_5 = getdvarfloat("_encstr_BDB826B01AB28F79F31FF5F63BE763B351F230F8924D2170F7778BE61F334E21841A20C17B264969", 0.0);
    var_3 thread anyoneisinmarkingrange(var_0, var_4, var_5);
    objective_removeallfrommask(var_4);
    var_6 = scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B");

    foreach(var_8 in var_6) {
      if(!var_8 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal())
        objective_addclienttomask(var_4, var_8);
    }

    objective_showtoplayersinmask(var_4);
    var_3.playersetattractionstateindex = var_4;
  }

  var_10 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_10 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_10, "_encstr_AF5A081BBAC993AC73A3", var_3.origin, var_2);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_10, 1);
    var_5 = getdvarfloat("_encstr_959F23BFB756990AF0B60F9229304072B8C3437F037B41C99098C591235896AA104507B38B", 0.0);
    var_3 thread anyoneisinmarkingrange(var_0, var_10, var_5);
    objective_removeallfrommask(var_10);

    foreach(var_8 in level.players) {
      if(var_8 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal() || var_8.team == var_0.team)
        objective_addclienttomask(var_10, var_8);
    }

    objective_hidefromplayersinmask(var_10);
    var_3.nuke_cancel = var_10;
  }
}

anyoneisinmarkingrange(var_0, var_1, var_2) {
  var_3 = self;
  level.obit_activation endon("_encstr_83F715566E1B580E95F5390B8C96F6BE8C9CDB07839532");

  if(var_2 <= 0.0) {
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var_1, 50);
    scripts\mp\objidpoolmanager::update_objective_onentity(var_1, var_0);
  } else {
    for(;;) {
      if(isDefined(var_0)) {
        scripts\mp\objidpoolmanager::update_objective_position(var_1, var_0.origin + (0, 0, 50));

        if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
          wait 0.1;
          continue;
        }

        wait(var_2);
      }
    }
  }
}

dangercircletick(var_0, var_1, var_2) {
  if(!isDefined(level.obit_activation)) {
    return;
  }
  if(!isDefined(level.obit_activation.radio))
    level.obit_activation.plundereventamount = undefined;
  else if(istrue(level.obit_activation.radio.hidden))
    level.obit_activation.plundereventamount = undefined;
  else {
    var_3 = var_1 * var_1;
    var_4 = var_2 * var_2;
    var_5 = distance2dsquared(level.obit_activation.radio.origin, var_0);

    if(var_5 > var_3) {
      level.obit_activation.radio thread ai_ascender_use(1);
      level.obit_activation.plundereventamount = undefined;
      return;
    }

    if(var_5 > var_4) {
      if(!isDefined(level.obit_activation.plundereventamount))
        level.obit_activation.plundereventamount = 1;
      else
        level.obit_activation.plundereventamount = level.obit_activation.plundereventamount + 1;

      if(level.obit_activation.plundereventamount == 5)
        obj_hvt_dead("_encstr_8E0D1D9538B2C9F66BC398082B95092B39221FADD48AD73B34E338887FBCA0", 0.0, 1);

      if(level.obit_activation.plundereventamount >= level.obit_activation._id_129D8) {
        level.obit_activation.radio thread ai_ascender_use(1);
        level.obit_activation.plundereventamount = undefined;
        return;
      }

      return;
    }

    level.obit_activation.plundereventamount = undefined;
  }
}

ai_ascender_use(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_B2F017295AEB80B7C2E7456B232A702990B491604754B9ED6B");
  level notify("_encstr_93CE13FD790F58B8773373D9AB7778D0A4D17D5FE5");

  foreach(var_3 in level.players) {
    if(!var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal()) {
      if(var_0) {
        var_3 scripts\mp\hud_message::showsplash("_encstr_99341C9D93A9EDF80B367BD151E29095227F6F394F332DD129CD8669C6CB");
        continue;
      }

      var_3 scripts\mp\hud_message::showsplash("_encstr_869518E64A211BA3AB473898D7D2B941EAB5F0FD202BCB4B954B");
    }
  }

  obj_hvt_dead("_encstr_8D6C1B48C0ABD5C1CABB2AB72BC52F3F77CA0650CCDFB8568160704691", 0.75, 1);
  ai_dropgren_override_hide();
  var_1 ai_hold_positions_freed();
  var_1 freescriptable();
  level.obit_activation.radio = undefined;
  wait 5;
  var_5 = level.obit_activation.personalscorecount;

  if(level.obit_activation._id_1438F != -1)
    var_5 = level.obit_activation._id_1438F;
  else if(level.br_circle.circleindex < level.obit_activation.personalnukecostoverride)
    var_5 = level.obit_activation.start_fly_over;

  level.obit_activation._id_14385 = var_5;
  level thread ai_hold_wake_watch();
}

obj_hangar_bombs() {
  var_0 = self;

  if(!isDefined(level.obit_activation) || !isDefined(level.obit_activation.radio)) {
    return;
  }
  if(isDefined(level.obit_activation.radio.icon)) {
    objective_removeclientfrommask(level.obit_activation.radio.icon, var_0);
    objective_showtoplayersinmask(level.obit_activation.radio.icon);
    return;
  }

  if(isDefined(level.obit_activation.radio.ownerteam)) {
    if(var_0.team == level.obit_activation.radio.ownerteam && isDefined(level.obit_activation.radio.playersetattractionstateindex)) {
      objective_removeclientfrommask(level.obit_activation.radio.playersetattractionstateindex, var_0);
      objective_showtoplayersinmask(level.obit_activation.radio.playersetattractionstateindex);
    }

    if(var_0.team != level.obit_activation.radio.ownerteam && isDefined(level.obit_activation.radio.nuke_cancel)) {
      objective_addclienttomask(level.obit_activation.radio.nuke_cancel, var_0);
      objective_hidefromplayersinmask(level.obit_activation.radio.nuke_cancel);
    }
  }
}

obj_hangar_juggs() {
  var_0 = self;

  if(!isDefined(level.obit_activation) || !isDefined(level.obit_activation.radio)) {
    return;
  }
  if(isDefined(level.obit_activation.radio.icon)) {
    objective_addclienttomask(level.obit_activation.radio.icon, var_0);
    objective_showtoplayersinmask(level.obit_activation.radio.icon);
    return;
  }

  if(isDefined(level.obit_activation.radio.ownerteam)) {
    if(var_0.team == level.obit_activation.radio.ownerteam && isDefined(level.obit_activation.radio.playersetattractionstateindex)) {
      objective_addclienttomask(level.obit_activation.radio.playersetattractionstateindex, var_0);
      objective_showtoplayersinmask(level.obit_activation.radio.playersetattractionstateindex);
    }

    if(var_0.team != level.obit_activation.radio.ownerteam && isDefined(level.obit_activation.radio.nuke_cancel)) {
      objective_removeclientfrommask(level.obit_activation.radio.nuke_cancel, var_0);
      objective_hidefromplayersinmask(level.obit_activation.radio.nuke_cancel);
    }
  }
}

_id_12069(var_0) {
  var_0.locationtriggerupdate = var_0.origin;

  if(isDefined(level.obit_activation) && isDefined(level.obit_activation.radio) && isDefined(level.obit_activation.radio.owner) && level.obit_activation.radio.owner == var_0) {
    var_1 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
    var_0 mlgmodifyheadshotdamage(var_1);
  }
}

onplayerspawned() {
  if(istrue(level.gameended)) {
    return;
  }
  if(updatenukeprogress(self)) {
    _encstr_95E3306EC6935AE01DE6976B07F29D58DA5647E583B2B9BC13E4AFB32CB6CA1DE538B2F5D64B9B9D3736B0CB2B395CD99BB1::carriabletype();
    thread _encstr_9B1C11CD934877C7629092DAC173C262EF0860();
  }
}

onplayerkilled(var_0) {
  if(isDefined(var_0.victim.carryflag))
    var_0.attacker thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A3DE0F25A1A7F0B77FBB0BB1D227CB107D");

  _encstr_95E3306EC6935AE01DE6976B07F29D58DA5647E583B2B9BC13E4AFB32CB6CA1DE538B2F5D64B9B9D3736B0CB2B395CD99BB1::lbravo_hover_rider_death_monitor();
}

_encstr_8C490F0AF1E8673FC027916EC72005AF84(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_3 in var_0) {
    if(isDefined(var_3) && isalive(var_3)) {
      if(var_1) {
        var_3 _encstr_95E3306EC6935AE01DE6976B07F29D58DA5647E583B2B9BC13E4AFB32CB6CA1DE538B2F5D64B9B9D3736B0CB2B395CD99BB1::carriabletype();
        var_3 thread _encstr_9B1C11CD934877C7629092DAC173C262EF0860();
        continue;
      }

      var_3 _encstr_95E3306EC6935AE01DE6976B07F29D58DA5647E583B2B9BC13E4AFB32CB6CA1DE538B2F5D64B9B9D3736B0CB2B395CD99BB1::lbravo_hover_rider_death_monitor();
    }
  }
}

_encstr_9B1C11CD934877C7629092DAC173C262EF0860() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level.obit_activation endon("_encstr_83F715566E1B580E95F5390B8C96F6BE8C9CDB07839532");

  while(isDefined(self.carryflag)) {
    wait 5;
    thread scripts\mp\utility\points::giveunifiedpoints("_encstr_825612C90B91A57BDCC5ABB0236E5793B34BB356");
  }
}

ai_fire_at_chopper(var_0, var_1) {
  var_2 = int(var_0 * 1000);
  var_3 = undefined;

  if(istrue(var_1))
    var_3 = var_2 | 1073741824;
  else {
    var_4 = gettime() + var_2;
    var_3 = var_4 &~1073741824;
  }

  setomnvar("_encstr_BE821B5FC066F2B3272DB837031939AAC9D0A7AFD999261ACFBDC4ED7D", var_3);
}

ai_give_flashlight(var_0) {
  ai_extra_think(var_0);
}

ai_force_damage_hit(var_0) {
  ai_extra_think(undefined, var_0);
}

ai_flash_swap(var_0) {
  ai_extra_think(undefined, undefined, var_0);
}

ai_extra_think(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.onmatchstartbr)) {
    level.onmatchstartbr = spawnStruct();
    level.onmatchstartbr._id_129DE = 0;
    level.onmatchstartbr._id_129DD = 0;
    level.onmatchstartbr._id_129D9 = 255;
    level.onmatchstartbr._id_11B6F = 0;
  }

  if(isDefined(var_3))
    level.onmatchstartbr._id_129DE = var_3;

  if(isDefined(var_0))
    level.onmatchstartbr._id_129DD = var_0;

  if(isDefined(var_1))
    level.onmatchstartbr._id_129D9 = var_1;

  if(isDefined(var_2))
    level.onmatchstartbr._id_11B6F = var_2;

  var_4 = (int(level.onmatchstartbr._id_129DE) & 1) << 22;
  var_4 = var_4 + ((int(level.onmatchstartbr._id_129DD) & 7) << 19);
  var_4 = var_4 + ((int(level.onmatchstartbr._id_129D9) & 255) << 11);
  var_4 = var_4 + (int(level.onmatchstartbr._id_11B6F) & 2047);
  setomnvar("_encstr_81771857C86EEAAB2F25803F1B6131A2F1C85FB7E143344281CD", var_4);
}

ai_dropgren_override_hide() {
  ai_give_flashlight(0);
}

ai_goal_distribution(var_0) {
  if(var_0 && !istrue(level.onmatchstartbr._id_129DE))
    level.obit_activation.radio._encstr_B121174F20F14A528908F3BFE8233D229745D6831D29428551 = gettime();
  else if(!var_0 && istrue(level.onmatchstartbr._id_129DE) && isDefined(level.obit_activation.radio._encstr_B121174F20F14A528908F3BFE8233D229745D6831D29428551))
    level.obit_activation.radio._encstr_B2E61750F34D6BE3DA0D35B3A5A20FD3B57B102017F5039302 = level.obit_activation.radio._encstr_B2E61750F34D6BE3DA0D35B3A5A20FD3B57B102017F5039302 + (gettime() - level.obit_activation.radio._encstr_B121174F20F14A528908F3BFE8233D229745D6831D29428551);

  ai_extra_think(undefined, undefined, undefined, var_0);
}

obj_heli_assault2() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level.obit_activation endon("_encstr_83F715566E1B580E95F5390B8C96F6BE8C9CDB07839532");
  var_1 = 0;
  level.obit_activation.radio._encstr_B2E61750F34D6BE3DA0D35B3A5A20FD3B57B102017F5039302 = 0;

  for(;;) {
    var_2 = istrue(var_0.unset_relic_shieldsonly) && !istrue(var_0.start_death_from_above_sequence) || scripts\mp\utility\player::unset_relic_trex(var_0);

    if(var_2 && !var_1) {
      var_1 = 1;
      var_3 = gettime();

      if(getdvarint("_encstr_A9043687EF43C87802A1510893C7C818FA5F6723373AAFB02D893B217AA5785853978BBB5B416CB845DD86B8259E1809FA0B771FFB4AB5E8", 0)) {
        level.obit_activation.radio.waittime = level.obit_activation._id_145CD;
        ai_goal_distribution(1);
      } else {
        var_0 notify("_encstr_993D1C5A90CF5EC351588289EDF877695FE87271D0B315AF6BA08F817323");
        ai_goal_distribution(1);
        level.obit_activation.radio.waittime = _encstr_AAA51DF7A0E3F382792D3AF685133ABF4950CB87481921BAA3B047AB7B3352();
      }

      ai_fire_at_chopper(level.obit_activation.radio.waittime, 1);
    } else if(!var_2 && var_1) {
      var_1 = 0;
      var_0 thread ai_hold_free(level.obit_activation.radio);
      ai_goal_distribution(0);
      ai_fire_at_chopper(level.obit_activation.radio.waittime);
    }

    waitframe();
  }
}

vehicle_spawn_mp_gamemodesupportsrespawn() {
  return 1;
}

adjustzoneactivationdelayforlargemaps() {
  if(!isDefined(level.onmatchstartbr) || !isDefined(level.onmatchstartbr._id_129DD))
    return -1;

  var_0 = level.onmatchstartbr._id_129DD;

  if((var_0 == 1 || var_0 == 4) && isDefined(level.obit_activation._id_129D4)) {
    var_1 = max(0, level.obit_activation._id_129D4 - gettime());
    var_2 = var_1 / 1000;
    return var_2;
  } else if(var_0 == 3) {
    var_2 = _encstr_AAA51DF7A0E3F382792D3AF685133ABF4950CB87481921BAA3B047AB7B3352();
    return var_2;
  } else if(var_0 == 2)
    return level.obit_activation._id_145CD;
  else
    return -1;
}

anyone_can_see_spawner() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B2270A3E87C886F7C8C1923A");
  level.initial_allies = undefined;
  level.initial_angles = -1;
  var_0 = 0;
  var_1 = level.obit_activation._id_13BFD;

  for(;;) {
    var_2 = 1;

    if(!isDefined(level.obit_activation))
      var_2 = 0;
    else if(!isDefined(level.onmatchstartbr) || !isDefined(level.onmatchstartbr._id_129DD))
      var_2 = 0;

    if(var_2) {
      var_3 = adjustzoneactivationdelayforlargemaps();
      var_4 = level.onmatchstartbr._id_129DD;

      if(var_3 == -1 || var_4 == 0) {} else if((var_4 == 1 || var_4 == 4) && !var_0) {
        if(getdvarint("_encstr_A7F81F9BB1E47D4C4EEBDB67599CC9963256FAE459B60BD2E6D2DCD9AFE8D2B5B2", 0) != 0)
          var_3 = getdvarint("_encstr_A7F81F9BB1E47D4C4EEBDB67599CC9963256FAE459B60BD2E6D2DCD9AFE8D2B5B2", 0);

        if(var_3 < 80)
          ammobox_getbufferedattachmentweapon("_encstr_B1D5153127F595B96C1683CA7D4759DC0E59E4D8B2CD8E");
      } else if(var_4 == 3 || var_4 == 2 || var_0) {
        if(var_4 == 1 || var_4 == 4)
          var_3 = var_1;

        var_0 = 1;
        var_5 = min(var_1, var_3);
        var_1 = var_5;

        if(getdvarint("_encstr_A7F81F9BB1E47D4C4EEBDB67599CC9963256FAE459B60BD2E6D2DCD9AFE8D2B5B2", 0) != 0)
          var_5 = getdvarint("_encstr_A7F81F9BB1E47D4C4EEBDB67599CC9963256FAE459B60BD2E6D2DCD9AFE8D2B5B2", 0);

        if(var_5 <= 60)
          ammobox_getbufferedattachmentweapon("_encstr_8CB918264EF5596E1B851C59FA73D273B23A2F1C95E48DAC73E8");
        else if(var_5 < 125)
          ammobox_getbufferedattachmentweapon("_encstr_9716184C39FA59CDD82C1C567DB22D9D0DE82F1C59E41B95738E");
        else if(var_5 < 185)
          ammobox_getbufferedattachmentweapon("_encstr_BD9B19134ED7CA37D82C38597DB92BECB2B9A3E538AC9C8D2B378E");
        else if(var_5 < 250)
          ammobox_getbufferedattachmentweapon("_encstr_8F101713E4D72B6EB116C1597D995A66A3F2E0569C1B95378E");
        else
          ammobox_getbufferedattachmentweapon("_encstr_8E9218AEFA70B7A3E782F17BB9CBC8DF15DBD34B0A2B2F4730A9");
      }
    }

    wait 1;
  }
}

ammobox_getbufferedattachmentweapon(var_0) {
  if(isDefined(level.initial_allies) && level.initial_allies == var_0) {
    return;
  }
  var_1 = game["_encstr_813F06832D8A18FE"][var_0].size;
  var_2 = randomint(var_1);
  setmusicstate("_encstr_B40101");
  level.initial_allies = var_0;
  level.initial_angles = var_2;

  foreach(var_4 in level.players) {
    if(!var_4 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal())
      var_4 _id_131A9();
  }
}

_id_131A9() {
  var_0 = self;

  if(isDefined(level.initial_allies))
    var_0 setplayermusicstate(game["_encstr_813F06832D8A18FE"][level.initial_allies][level.initial_angles]);
}