/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_zonecontrol.gsc
************************************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "zonecontrol") {
    return;
  }
  init();
}

_id_F0245D1B6A36EF77() {}

_id_5D6ED45785284123() {}

init() {
  level thread _id_14183DF6F9AF8737::_id_7269C88A927E7937();
  level thread _id_14183DF6F9AF8737::_id_D7A7AA9EE1CC1071();
  level thread _id_A5644EF903874738();
  level thread _id_34B491F2BDF6DA40();
  level thread _id_B54DE60F1C39483C();
  level thread _id_7DEAC72BB9770203();
  level thread _id_56D4FA60C084B45B();
  level thread _id_F0245D1B6A36EF77();
  level thread _id_9E9B01992F22AAF9();
  level thread _id_FDE30CEBCACDB61E();
  thread _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("mp_gamemode_lockdown");
  _id_5D6ED45785284123();
  level.validautoassignquests = [];
  level.validautoassignquests[0] = "assassination";
  level.validautoassignquests[1] = "domination";
  level.validautoassignquests[2] = "scavenger";
  _id_920C1DA6479AE205();
  _id_56240586D0AE0B1D();
  _id_DE45F3BA013D803C();
  _id_9017FFCFBFB5D51C();
  _id_C453D69202CBFB0F();
}

_id_A5644EF903874738() {
  level endon("game_ended");
  _id_362C58E8BB39BCDA::disablefeature("gulag");
  _id_362C58E8BB39BCDA::disablefeature("drogBagLoadout");
  _id_362C58E8BB39BCDA::disablefeature("dropBagLoop");
  _id_362C58E8BB39BCDA::disablefeature("randomizeCircleCenter");
  _id_362C58E8BB39BCDA::enablefeature("planeUseCircleRadius");
  _id_362C58E8BB39BCDA::disablefeature("registerReviveCount");
  _id_362C58E8BB39BCDA::enablefeature("gasVehicleSpawns");
  _id_362C58E8BB39BCDA::disablefeature("vehiclesGasDamage");
}

_id_34B491F2BDF6DA40() {
  level endon("game_ended");
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_B96F59F29D1C4398);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerWelcomeSplashes", ::_id_0E6B67D05F77313F);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("createMultiCircleObjectivesStruct", ::_id_94E64FE4713EFF4B);
  _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("onPlayerKilled");
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerConnect", ::_id_28161557D00ACFAD);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("getGametypeTeamPlacement", ::_id_2AEE645E0C39ABD4);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerEnterVehicle", ::_id_9AAED3AB745B2A1A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("zonecontrol", "packClientMatchData", ::_id_8ECDB9663CB000AC);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerGetRespawnPoint", ::_id_5C969A7697E1A7CD);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("dontConsiderAFK", ::_id_4E923934E9E9FFE7);
  level waittill("prematch_done");
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::_id_5B8CD2B216A2086F);
}

_id_B54DE60F1C39483C() {
  level endon("game_ended");
  waittillframeend;
  _id_26A43A730CDCCCAD();
  level waittill("prematch_done");
  _id_F7FA8A135BB71BF1();
  _id_56355C272F045E8C();
  _id_17DAFC2A055018CD();
  _id_8E6D11416198DA98();
  thread _id_96D5EC7CFB96BA1E();
  _id_5FD5D5232392F8E3();
}

_id_26A43A730CDCCCAD() {
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
}

_id_7DEAC72BB9770203() {
  level endon("game_ended");
  waitframe();
  waittillframeend;
  game["dialog"]["match_start"] = "zone_wzan_name";
  game["dialog"]["offense_obj"] = "zone_wzan_boos";
  game["dialog"]["objective_desc"] = "zone_wzan_objt";
  game["dialog"]["zone_activation"] = "zone_wzan_unlk";
  game["dialog"]["zone_deactivation"] = "zone_wzan_clsd";
  game["dialog"]["halfway_leaders"] = "zone_wzan_hlff";
  game["dialog"]["halfway_others"] = "zone_wzan_hlfe";
  game["dialog"]["lead_first"] = "zone_wzan_ledf";
  game["dialog"]["lead_marked"] = "zone_wzan_ledm";
  game["dialog"]["lead_taking"] = "zone_wzan_ledt";
  game["dialog"]["lead_lost"] = "zone_wzan_ledl";
  game["dialog"]["zone_secured"] = "zone_wzan_secu";
  game["dialog"]["zone_contested"] = "zone_wzan_acco";
  game["dialog"]["attacking_zone"] = "zone_wzan_attk";
  game["dialog"]["activation_anticipation"] = "zone_wzan_t15n";
  game["dialog"]["deactivation_anticipation"] = "zone_wzan_tr15";
  game["dialog"]["play_objective"] = "zone_wzan_hint";
  game["dialog"]["overtime_start"] = "zone_wzan_ovrt";
  game["dialog"]["victory_close_leaders"] = "zone_wzan_vicf";
  game["dialog"]["victory_close_others"] = "zone_wzan_vice";
  game["dialog"]["high_value_zone"] = "zone_wzan_timh";
  game["dialog"]["match_end_soon"] = "zone_wzan_time";
  game["dialog"]["squadmate_left"] = "zone_wzan_sadj";
  game["dialog"]["resurgence_on_player_disconnect"] = "";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.brgametype._id_E8B86399CBD6A85E; _id_AC0E594AC96AA3A8++) {
    _id_783809DA65285CB1 = level.brgametype.letters[_id_AC0E594AC96AA3A8];
    game["dialog"]["attacking_" + _id_783809DA65285CB1] = "zone_wzan_atk" + _id_783809DA65285CB1;
    game["dialog"][_id_783809DA65285CB1 + "_contested"] = "zone_wzan_act" + _id_783809DA65285CB1;
    game["dialog"][_id_783809DA65285CB1 + "_secured"] = "zone_wzan_sec" + _id_783809DA65285CB1;
  }
}

_id_56D4FA60C084B45B() {
  level endon("game_ended");
}

_id_9E9B01992F22AAF9() {
  level endon("game_ended");
  level waittill("br_ready_to_jump");

  foreach(team in level.teamnamelist) {
    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
      player.radarmode = "slow_radar";
      player.skipuavupdate = 1;
    }

    setteamradar(team, 1);
    setteamradarstrength(team, 1);
  }
}

_id_920C1DA6479AE205() {
  level.brgametype._id_B184DDAD2BCF6F49 = undefined;
  level.brgametype._id_FF62FBB921AE39BD = [];
  level.brgametype._id_6EEF49FDE768C24F = [];
  level.brgametype._id_8C60F1A7127109CF = 0;
  level.brgametype._id_B357705D6F9B3080 = getdvarint("dvar_AFE0AD16235C6390", 1);
  level.brgametype._id_6F677AE3468374BD = getdvarint("dvar_FCC9FA7343B1EC14", 2);
  level.brgametype._id_BBCE590C8E68F35B = getdvarint("dvar_17B773757887A5F7", 25);
  level.brgametype._id_72A3808F03841546 = getdvarint("dvar_2CA9CC987F401338", 650);
  level.brgametype._id_9FC633A4965B8851 = getdvarint("dvar_4FC8A88F29991F0E", 15);
  level.brgametype._id_63F2DD4C20977582 = getdvarint("dvar_F5045541BF7360A4", 1);
  level.brgametype._id_EF80665D53789D98 = getdvarint("dvar_BC36B3EDFDB08B10", 0);
  level.brgametype._id_A44DF2A0823C0ACE = getdvarint("dvar_4176D6F6DAF037F9", 0);
  level.brgametype._id_16118949D71FBB2F = getdvarint("dvar_26AAA30A80C7FADA", 2);
  level.brgametype._id_E9A4C3DF54D13FD1 = getdvarint("dvar_E6C9AFDC35422CBC", 1);
  level.brgametype._id_D4A62F500784AD3B = getdvarint("dvar_188C3454482783FD", 2);
  level.brgametype._id_30A69220CB03BBA6 = _id_6D83E1AAD1B29028();
  level.brgametype._id_6E933AB788BF25E7 = getdvarint("dvar_F329FB2AE3F22094", 1);
  level.brgametype._id_F5CA6A058F95E438 = getdvarint("dvar_4F01D0B6C438CDFD", 7);
  level.brgametype._id_B4410FA3070BDB2F = getdvarint("dvar_A0571B5581AAC4BA", 5);
  level.brgametype._id_FAF946460FCEE87B = getdvarint("dvar_82CAE3F17C2975C5", 1);
  level.brgametype._id_416FEBDC38ED88BE = getdvarint("dvar_8564FD301E5235D6", 1);
  level.brgametype._id_A4153AE6BCB25FC3 = getdvarint("dvar_BF61C823BEACD1CB", 5);
  level.brgametype._id_A5FC9E22F4382909 = getdvarint("dvar_22339F5888777D4D", 3);
  level.brgametype._id_8253CD4C8354424E = getdvarint("dvar_3BF26249A54616B0", 2);
  level.brgametype._id_BD5D2A7A94C784AB = getdvarint("dvar_FCD0A0FDA2F77856", 0);
  level.brgametype._id_ADAFBAF3C7E24AD3 = _id_2BF47D0BC2323F05();
  level.brgametype._id_B4A42A0051F3FED8 = getdvarint("dvar_DF248738E4894BF1", 30);
  level.brgametype._id_9FDB99442028FCA4 = _id_EA308097CBF28BF6();
  level.brgametype._id_6BF149B60DA04F9B = level.brgametype._id_9FDB99442028FCA4.size;
  level.brgametype._id_BD12E1C552278AD6 = _id_2689681546AC00B4();
  level.brgametype._id_A0712831EC60EE71 = _id_6BD66C998921855F();
  level.brgametype._id_7253B43EF30F88B9 = _id_D426D35C0F2BE953();
  level.brgametype._id_B458560354506894 = getdvarfloat("dvar_AD4CB735A53A2F47", 6.75);
  level.brgametype._id_77134F0DDB570883 = getdvarfloat("dvar_08B1077145E2C139", 15);
  level.brgametype._id_E97CD8F39E602A98 = getdvarfloat("dvar_BD2AD1874DDB4FE6", 4000);
  _id_0AC9754E38F924B5 = getdvarint("dvar_47F6FB1896633385", 1);

  if(istrue(_id_0AC9754E38F924B5)) {
    level.brgametype._id_8F7905B05BA12DF4 = spawnStruct();
    level.brgametype._id_8F7905B05BA12DF4.count = getdvarint("dvar_F634C09AC19A0E83", 1);
    level.brgametype._id_8F7905B05BA12DF4.duration = getdvarint("dvar_755BBD8BA2793561", 60);
    level.brgametype._id_8F7905B05BA12DF4._id_12926948D93C7ED0 = _id_D029C67042B833EF();
  }

  level.brgametype._id_9B3E632A26358302 = getdvarint("dvar_1D341D3600365498", 15);
  level.brgametype._id_13D640CEE5DF4AC3 = getdvarint("dvar_7F61D5BFD6814DED", 5);
  level.brgametype._id_4A459E59B4B10244 = _id_4F773961BB78FB7E();
  level.brgametype._id_080E82584C694B4A = level.brgametype._id_4A459E59B4B10244[0];
  level.brgametype._id_293DC429F3A19DFD = _id_B3E0554CF34D5CF7(level.brgametype._id_080E82584C694B4A);
  level.brgametype._id_7BAB81A92B4BE919 = _id_242319FC7747107F();
  level.brgametype._id_719C030C6596B6A5 = getdvarint("dvar_19CD3AA47E9A9EF5", 0);
  level.brgametype._id_58B474CB0E57096A = [];
  level.brgametype.clusters = [];
  level.brgametype.letters = ["a", "b", "c", "d", "e", "f", "g", "h"];
  level.brgametype._id_6B04289A49CAE84D = getdvarint("dvar_39E5A4F1BA733C1F", 0);
  level.brgametype._id_A7BD67E2C17C3DC1 = getdvarint("dvar_A49776597B308F58", 10000);
  level.brgametype._id_36875A3DF3AE81F0 = getdvarint("dvar_EA138B5DAD20E381", 7000);
  level.brgametype._id_D993BF69B9541CBF = getdvarint("dvar_CB5D885251E81B6A", 4000);
  level.brgametype._id_EFBAAD993A315482 = getdvarint("dvar_1BC38BAA909B90EF", 6000);
  level.brgametype._id_36A5C1335A8FF080 = getdvarint("dvar_19FDA6A24870C61D", 2000);
  level.brgametype._id_78C2D7D97F7E9215 = getdvarint("dvar_C0F82F769F124250", 1500);
  level.brgametype._id_A814399CC303B418 = getdvarint("dvar_48AFC9DF42C9888E", 0);
  level.brgametype._id_E75711D488AAD5C9 = getdvarfloat("dvar_7EFDA168670CBD76", 2);
  level.brgametype._id_88A254227DA87C7F = [];
  level.brgametype._id_AF41098889966EE1 = _id_67B4CFF7142DD6BB();
  level.brgametype._id_BB9B77186CB79AE6 = 1;
  level.brgametype._id_4A8A68AFCCFA6692 = "zc_resurgence_respawn";
  level.brgametype._id_748A99415228DE0E = "splash_list_iw9_br_zonecontrol";
  setDvar("scr_br_magcount", 3);
  level.brgametype._id_65C42F3AC6958818 = _id_CC65FF69B7798D8A();
  level.brgametype._id_2D08E0F710460F75 = _id_4B142266DB88B16F();
  level.brgametype._id_9429AEBA8918C5CA = getdvarint("dvar_99B1DB027DFF38C6", 60);
  level.brgametype._id_D35C2D99F63CEC4A = getdvarint("dvar_1455D87AEDBBB31A", 30);
  level.brgametype._id_B09B7AFE082A9239 = "dx_br_bds4_";
  level.brgametype._id_F983A9D28A83A074 = getdvarint("dvar_8365AE49880F4B66", 60);
  level.brgametype._id_8EA33E944D74F0CF = getdvarint("dvar_A42A89C01B404460", 1);
  level.brgametype._id_D6F1CDC1F64D318E = getdvarint("dvar_724ED04AA79193F3", 1);
  level.brgametype._id_CCAF7DCC548B6DF3 = getdvarint("dvar_CBEF5B58A4B634C4", 30);
  level.brgametype._id_C435BC516C8091CA = 1;
  level.brgametype._id_BE0C10911FEC189F = 1;
  level.brgametype._id_98ADE9E8627AF484 = 1;
}

_id_FDE30CEBCACDB61E() {
  level._id_BCF7BE5C24905AB9 = [];
  level._id_5477E9D7BBF824BF = [];
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = _id_062C595D55B88B26::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = _id_062C595D55B88B26::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["score"];
  params.floor = 1;
  params._id_47EF1080427D4D3A = 10000;
  params.scale = 0;
  _id_062C595D55B88B26::_id_FA624B8C032AFCF7("zc_mvp", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = _id_062C595D55B88B26::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = _id_062C595D55B88B26::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["matchPoints"];
  params.floor = 1;
  params._id_47EF1080427D4D3A = 800;
  params.scale = 0;
  _id_062C595D55B88B26::_id_FA624B8C032AFCF7("zc_carrier", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = _id_062C595D55B88B26::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = _id_062C595D55B88B26::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["longestScoreStreak"];
  params.floor = 1;
  params._id_47EF1080427D4D3A = 120;
  params.scale = 0;
  _id_062C595D55B88B26::_id_FA624B8C032AFCF7("zc_relentless", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = _id_062C595D55B88B26::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = _id_062C595D55B88B26::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["deadSilenceKills", "throwingKnifeKills", "killstreakCUAVAssists", "silencedKills"];
  params.floor = 1;
  params._id_47EF1080427D4D3A = 30;
  params.weight = 0.5;
  _id_062C595D55B88B26::_id_1EF76151D5FB5218("ghost", "killstreakCUAVAssists", 0.5);
  _id_062C595D55B88B26::_id_FA624B8C032AFCF7("ghost", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = _id_062C595D55B88B26::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = _id_062C595D55B88B26::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["kills"];
  params.floor = 1;
  params._id_47EF1080427D4D3A = 100;
  params.weight = 1.0;
  _id_062C595D55B88B26::_id_FA624B8C032AFCF7("killer", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = _id_062C595D55B88B26::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = _id_062C595D55B88B26::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["munitionsBoxUsed", "armorBoxUsed"];
  params.floor = 1;
  params._id_47EF1080427D4D3A = 10;
  params.weight = 1.0;
  _id_062C595D55B88B26::_id_FA624B8C032AFCF7("supplier", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = _id_062C595D55B88B26::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = _id_062C595D55B88B26::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["rescues", "kioskRevives"];
  params.floor = 1;
  params._id_47EF1080427D4D3A = 10;
  params.weight = 1.0;
  _id_062C595D55B88B26::_id_FA624B8C032AFCF7("medic", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = _id_062C595D55B88B26::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = _id_062C595D55B88B26::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["damageHealed", "gulagWins", "rescued", "revivedFromKiosk"];
  params.floor = 1;
  params._id_47EF1080427D4D3A = 20;
  params.weight = 0.5;
  _id_062C595D55B88B26::_id_1EF76151D5FB5218("survivor", "damageHealed", 0.1);
  _id_062C595D55B88B26::_id_FA624B8C032AFCF7("survivor", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = _id_062C595D55B88B26::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = _id_062C595D55B88B26::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["reconDroneMarks", "killstreakUAVAssists", "killstreakAUAVAssists", "binocularMarks", "snapshotHits", "tacCamMarks"];
  params.floor = 5;
  params._id_47EF1080427D4D3A = 30;
  params.weight = 0.5;
  _id_062C595D55B88B26::_id_FA624B8C032AFCF7("scout", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = _id_062C595D55B88B26::_id_56C0AE4C11E6ECC3;
  params._id_FDE59C56D8B89B3B = _id_062C595D55B88B26::_id_0C8209FBD2F8C013;
  params.floor = 1;
  params._id_47EF1080427D4D3A = 30;
  params.weight = 0.5;
  _id_062C595D55B88B26::_id_FA624B8C032AFCF7("scavenger", params);
}

_id_2BF47D0BC2323F05() {
  _id_BFD8ABEFB099A1E0 = strtok(getDvar("dvar_7ADCD307F6E7611B", "30 30 30 30"), " ");
  _id_ADAFBAF3C7E24AD3 = [];

  foreach(_id_220DE96CF780522B in _id_BFD8ABEFB099A1E0)
  _id_ADAFBAF3C7E24AD3[_id_ADAFBAF3C7E24AD3.size] = int(_id_220DE96CF780522B);

  return _id_ADAFBAF3C7E24AD3;
}

_id_EA308097CBF28BF6() {
  _id_B4011C42BDD8776B = strtok(getDvar("dvar_E9AA6901B60A53F3", "120 120 120 120 120"), " ");
  _id_9FDB99442028FCA4 = [];

  foreach(_id_E75BF341CE28D72A in _id_B4011C42BDD8776B)
  _id_9FDB99442028FCA4[_id_9FDB99442028FCA4.size] = int(_id_E75BF341CE28D72A);

  return _id_9FDB99442028FCA4;
}

_id_2689681546AC00B4() {
  _id_BD12E1C552278AD6 = level.brgametype._id_B4A42A0051F3FED8;

  foreach(zoneduration in level.brgametype._id_9FDB99442028FCA4)
  _id_BD12E1C552278AD6 = _id_BD12E1C552278AD6 + zoneduration;

  foreach(zoneactivationdelay in level.brgametype._id_ADAFBAF3C7E24AD3)
  _id_BD12E1C552278AD6 = _id_BD12E1C552278AD6 + zoneactivationdelay;

  return _id_BD12E1C552278AD6;
}

_id_6BD66C998921855F() {
  _id_A0712831EC60EE71 = getDvar("dvar_28904496ACB0D67F", "");
  return strtok(_id_A0712831EC60EE71, " ");
}

_id_D426D35C0F2BE953() {
  _id_7253B43EF30F88B9 = getDvar("dvar_1D1DF0335CC35EF3", "");
  return strtok(_id_7253B43EF30F88B9, " ");
}

_id_4F773961BB78FB7E() {
  _id_7253B43EF30F88B9 = getDvar("dvar_8B615C555C3F27BB", "1 2 3 4");
  return strtok(_id_7253B43EF30F88B9, " ");
}

_id_B3E0554CF34D5CF7(_id_CBF035D71D332C29) {
  _id_911EDF512130CE9D = _id_F60524C89FC95284(_id_CBF035D71D332C29);
  _id_9364E710471507DE = [];

  if(_id_911EDF512130CE9D != "") {
    _id_FBF0061B9920C119 = strtok(_id_911EDF512130CE9D, " ");
    _id_9364E710471507DE["1"] = int(_id_FBF0061B9920C119[0]);
    _id_9364E710471507DE["2"] = int(_id_FBF0061B9920C119[1]);
  }

  return _id_9364E710471507DE;
}

_id_F60524C89FC95284(_id_CBF035D71D332C29) {
  switch (_id_CBF035D71D332C29) {
    case "1":
      return getDvar("dvar_AE72DA6DCD955CFE", "7 0");
    case "2":
      return getDvar("dvar_9F0581A85C59B0BB", "7 0");
    case "3":
      return getDvar("dvar_D1C9BA0B2E2638F4", "6 0");
    case "4":
      return getDvar("dvar_692AB13E0FA3DEF9", "6 0");
    default:
      return;
  }
}

_id_242319FC7747107F() {
  _id_7BAB81A92B4BE919 = [];
  _id_7BAB81A92B4BE919["1"] = _id_7B354CBFF410C6B8("1", 1, 2000, 0, "2");
  _id_7BAB81A92B4BE919["2"] = _id_7B354CBFF410C6B8("2", 2, 5000, _id_7BAB81A92B4BE919["1"]._id_64A4D492B7ADD279, undefined);
  return _id_7BAB81A92B4BE919;
}

_id_7B354CBFF410C6B8(name, _id_98EA5AFB293A76A2, _id_64A4D492B7ADD279, basescore, _id_51BB8BA0DD6CAB42) {
  _id_BCC2E271115B13F0 = spawnStruct();
  _id_BCC2E271115B13F0.name = name;

  if(isDefined(_id_98EA5AFB293A76A2))
    _id_BCC2E271115B13F0._id_98EA5AFB293A76A2 = getdvarint(_func_2EF675C13CA1C4AF("dvar_811DDD31FED8791A", name), _id_98EA5AFB293A76A2);

  if(isDefined(_id_64A4D492B7ADD279))
    _id_BCC2E271115B13F0._id_64A4D492B7ADD279 = getdvarint(_func_2EF675C13CA1C4AF("dvar_1CC2EA23EBD79BED", name), _id_64A4D492B7ADD279);

  if(isDefined(basescore))
    _id_BCC2E271115B13F0.basescore = basescore;

  _id_BCC2E271115B13F0._id_51BB8BA0DD6CAB42 = _id_51BB8BA0DD6CAB42;
  return _id_BCC2E271115B13F0;
}

_id_56240586D0AE0B1D() {
  _id_1852DA5050D81F13 = getentitylessscriptablearray("zc_cluster", "targetname");
  level.brgametype._id_E8B86399CBD6A85E = 0;

  foreach(_id_93BB5850A0334FD2 in _id_1852DA5050D81F13) {
    if(scripts\engine\utility::array_contains(level.brgametype._id_7253B43EF30F88B9, _id_93BB5850A0334FD2.targetname)) {
      continue;
    }
    _id_3402D60C1EF6B931 = spawnStruct();
    _id_3402D60C1EF6B931._id_F945C49AF8CE3F75 = _id_93BB5850A0334FD2 _id_75D1F81D43231B87();
    _id_3402D60C1EF6B931.zones = _id_93BB5850A0334FD2 _id_FAFD7A9DE6E4BA1E();
    _id_C54302BB1C559C77 = _id_3402D60C1EF6B931.zones.size;
    _id_3402D60C1EF6B931.name = _id_93BB5850A0334FD2.target;
    _id_3402D60C1EF6B931.origin = _id_93785E8E7A4BDDB2(_id_3402D60C1EF6B931.zones);
    level.brgametype.clusters[_id_3402D60C1EF6B931.name] = _id_3402D60C1EF6B931;
    level.brgametype._id_E8B86399CBD6A85E = max(level.brgametype._id_E8B86399CBD6A85E, _id_C54302BB1C559C77);
  }
}

_id_7876F532A72A3BB8() {
  _id_870CF4A260C81E7E = _id_B3E0554CF34D5CF7("1");
  _id_F19C896F971BF709 = _id_B3E0554CF34D5CF7("2");
  _id_38BF4F5715700774 = _id_B3E0554CF34D5CF7("3");
  _id_B217544591B3F217 = _id_B3E0554CF34D5CF7("4");
  _id_0570E6F8CEF795AC = [_id_870CF4A260C81E7E, _id_F19C896F971BF709, _id_38BF4F5715700774, _id_B217544591B3F217];
  _id_A863A1430C541394 = 0;

  foreach(_id_EA667411B8861FD7 in _id_0570E6F8CEF795AC) {
    _id_D599276E2F395A29 = 0;

    foreach(_id_88DE8FF497AB3B5F in _id_EA667411B8861FD7)
    _id_D599276E2F395A29 = _id_D599276E2F395A29 + _id_88DE8FF497AB3B5F;

    if(_id_D599276E2F395A29 > _id_A863A1430C541394)
      _id_A863A1430C541394 = _id_D599276E2F395A29;
  }

  return _id_A863A1430C541394;
}

_id_DE45F3BA013D803C() {
  _id_7B1E1E474E9570A7 = [];
  _id_FE8F7203F63133D5 = getDvar("dvar_30C480D6C4BC482D", "");

  if(_id_FE8F7203F63133D5 != "") {
    clusters = strtok(_id_FE8F7203F63133D5, " ");
    index = 0;

    foreach(_id_3402D60C1EF6B931 in clusters) {
      if(isDefined(level.brgametype.clusters[_id_3402D60C1EF6B931]) && index < level.brgametype._id_6BF149B60DA04F9B)
        level.brgametype._id_58B474CB0E57096A[level.brgametype._id_58B474CB0E57096A.size] = clusters[index];

      index++;
    }
  }

  if(level.brgametype._id_58B474CB0E57096A.size <= 0)
    level.brgametype._id_58B474CB0E57096A[0] = _id_EBC874D697CA40FA(randomint(level.brgametype.clusters.size));

  for(_id_7B1E1E474E9570A7 = _id_8DB616127C1CE8A8(_id_7B1E1E474E9570A7); level.brgametype._id_58B474CB0E57096A.size < level.brgametype._id_6BF149B60DA04F9B; _id_7B1E1E474E9570A7 = _id_8DB616127C1CE8A8(_id_7B1E1E474E9570A7))
    level.brgametype._id_58B474CB0E57096A[level.brgametype._id_58B474CB0E57096A.size] = _id_B27519F5F601AAD1(_id_7B1E1E474E9570A7);
}

_id_EBC874D697CA40FA(_id_6F8AE5B48E171EAC) {
  _id_628A1764EFA79FD8 = 0;

  foreach(_id_3402D60C1EF6B931 in level.brgametype.clusters) {
    if(_id_628A1764EFA79FD8 == _id_6F8AE5B48E171EAC)
      return _id_3402D60C1EF6B931.name;

    _id_628A1764EFA79FD8++;
  }
}

_id_93785E8E7A4BDDB2(zones) {
  origin = (0, 0, 0);

  if(zones.size == 0)
    return origin;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < zones.size; _id_AC0E594AC96AA3A8++)
    origin = origin + zones[_id_AC0E594AC96AA3A8].origin;

  return origin / zones.size;
}

_id_8DB616127C1CE8A8(_id_7B1E1E474E9570A7) {
  _id_7B1E1E474E9570A7[_id_7B1E1E474E9570A7.size] = level.brgametype._id_58B474CB0E57096A[level.brgametype._id_58B474CB0E57096A.size - 1];

  if(_id_7B1E1E474E9570A7.size > level.brgametype._id_8253CD4C8354424E)
    _id_7B1E1E474E9570A7 = scripts\engine\utility::array_remove_index(_id_7B1E1E474E9570A7, 0);

  return _id_7B1E1E474E9570A7;
}

_id_B27519F5F601AAD1(_id_7B1E1E474E9570A7) {
  _id_E08E0CC44F5AF529 = level.brgametype._id_58B474CB0E57096A[level.brgametype._id_58B474CB0E57096A.size - 1];
  _id_10A5085ADA658E2B = level.brgametype.clusters[_id_E08E0CC44F5AF529]._id_F945C49AF8CE3F75;
  _id_10A5085ADA658E2B = scripts\engine\utility::array_remove_array(_id_10A5085ADA658E2B, _id_7B1E1E474E9570A7);
  _id_6780FD50A2D4BC5B = randomint(_id_10A5085ADA658E2B.size);
  _id_072B3F7EB10D73C9 = _id_10A5085ADA658E2B[_id_6780FD50A2D4BC5B];
  return _id_072B3F7EB10D73C9;
}

_id_5B8CD2B216A2086F(player) {
  _id_BBF92C043B4C87C6(player.team);
}

_id_28161557D00ACFAD(player) {
  player._id_393B1E905723327D = 0;
  player._id_53E3AF3B2C8752BD = 1;
  player._id_0F4D5A85FEDC6267 = 0;
  player._id_662A7FF003A3442F = 0;
}

_id_5129B71105A55FCF() {
  foreach(team in level.teamnamelist) {
    _id_BBF92C043B4C87C6(team, 1);
    _id_1300C157B617ABD7(team);
  }
}

_id_BBF92C043B4C87C6(team, _id_840011EFD5B6414E) {
  if(level.brgametype._id_63F2DD4C20977582 == 0 || scripts\mp\utility\teams::getteamcount(team) == 0) {
    return;
  }
  _id_9052970FF4BCE526 = [];

  if(istrue(level.brgametype._id_E9A4C3DF54D13FD1)) {
    _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");
    _id_A6AB8D0FDA441DC2 = scripts\engine\utility::array_removeundefined(_id_A6AB8D0FDA441DC2);

    if(_id_A6AB8D0FDA441DC2.size != 1) {
      return;
    }
    player = _id_A6AB8D0FDA441DC2[0];
    _id_9052970FF4BCE526[_id_9052970FF4BCE526.size] = player;
    player._id_53E3AF3B2C8752BD = level.brgametype._id_D4A62F500784AD3B;
  } else {
    _id_D46BC9BE217EC18D = _id_43D0931E0C776713(team);

    if(_id_D46BC9BE217EC18D == 0) {
      return;
    }
    while(_id_D46BC9BE217EC18D > 0) {
      player = _id_2DBE32176AEB50CF(team);
      player._id_53E3AF3B2C8752BD++;
      _id_D46BC9BE217EC18D--;

      if(!scripts\engine\utility::array_contains(_id_9052970FF4BCE526, player))
        _id_9052970FF4BCE526[_id_9052970FF4BCE526.size] = player;
    }
  }

  foreach(player in _id_9052970FF4BCE526) {
    player scripts\mp\hud_message::showsplash("zc_smateleft", undefined, undefined, undefined, undefined, "splash_list_iw9_br_zonecontrol");

    if(!istrue(_id_840011EFD5B6414E))
      level thread _id_2CEDCC356F1B9FC8::brleaderdialog("squadmate_left", undefined, [player], 0, 1, undefined, "dx_br_bds4_");
  }
}

_id_43D0931E0C776713(team) {
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");
  _id_D46BC9BE217EC18D = level.maxsquadsize;

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(!isDefined(player)) {
      continue;
    }
    _id_D46BC9BE217EC18D = _id_D46BC9BE217EC18D - player._id_53E3AF3B2C8752BD;
  }

  return _id_D46BC9BE217EC18D;
}

_id_2DBE32176AEB50CF(team) {
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");

  if(_id_A6AB8D0FDA441DC2.size == 0)
    return undefined;

  _id_A6AB8D0FDA441DC2 = _id_F9DE48B78868B0DC(_id_A6AB8D0FDA441DC2);
  player = _id_8D70AFE0AA19F48D(_id_A6AB8D0FDA441DC2);
  return player;
}

_id_F9DE48B78868B0DC(players) {
  _id_050DD2127E3A2962 = [];
  _id_CFF5CDF93F2CD0AF = level.maxsquadsize;

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    if(player._id_53E3AF3B2C8752BD < _id_CFF5CDF93F2CD0AF) {
      _id_050DD2127E3A2962 = [player];
      _id_CFF5CDF93F2CD0AF = player._id_53E3AF3B2C8752BD;
      continue;
    }

    if(player._id_53E3AF3B2C8752BD == _id_CFF5CDF93F2CD0AF)
      _id_050DD2127E3A2962[_id_050DD2127E3A2962.size] = player;
  }

  return _id_050DD2127E3A2962;
}

_id_8D70AFE0AA19F48D(players) {
  _id_D72DE2015142F6D2 = 0;
  _id_397CCC3B3F303FF5 = undefined;

  foreach(player in players) {
    if(!isDefined(_id_397CCC3B3F303FF5) || player._id_393B1E905723327D > _id_D72DE2015142F6D2) {
      _id_397CCC3B3F303FF5 = player;
      _id_D72DE2015142F6D2 = player._id_393B1E905723327D;
    }
  }

  return _id_397CCC3B3F303FF5;
}

_id_17DAFC2A055018CD() {
  foreach(_id_FABF84450735DD93 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamcount(_id_FABF84450735DD93) == 0) {
      continue;
    }
    _id_00AE17C5A8B1BC1B = _id_2AEE645E0C39ABD4(_id_FABF84450735DD93);
    _id_F7B9D28BD826E5C0(_id_FABF84450735DD93, _id_00AE17C5A8B1BC1B);
  }
}

_id_2AEE645E0C39ABD4(team) {
  _id_00AE17C5A8B1BC1B = 1;
  score = _id_A97D64DD14F6D878(team);

  foreach(_id_FABF84450735DD93 in level.teamnamelist) {
    if(team == _id_FABF84450735DD93 || scripts\mp\utility\teams::getteamcount(_id_FABF84450735DD93) == 0) {
      continue;
    }
    _id_929A6DF466DC4F22 = _id_A97D64DD14F6D878(_id_FABF84450735DD93);

    if(_id_929A6DF466DC4F22 > score)
      _id_00AE17C5A8B1BC1B++;
  }

  if(_id_00AE17C5A8B1BC1B == 1 && !_id_8FFE98714B82D58B(team))
    _id_00AE17C5A8B1BC1B = 2;

  return _id_00AE17C5A8B1BC1B;
}

_id_F7B9D28BD826E5C0(team, _id_00AE17C5A8B1BC1B) {
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(isDefined(player))
      player _id_4BBCB0B68D6681B6(_id_00AE17C5A8B1BC1B);
  }
}

_id_5E0AAB868C752ED8() {
  foreach(player in level.players) {
    if(isDefined(player))
      player _id_154E26C852E765F5();
  }
}

_id_96D5EC7CFB96BA1E() {
  level endon("game_ended");
  level endon("overtime");
  _id_3C6BB864DCC6CDA7 = 0;
  _id_FDF17DDB1F56D876(level.brgametype._id_58B474CB0E57096A[_id_3C6BB864DCC6CDA7]);
  _id_A9EDFBDC1855B5B9("active");
  scripts\mp\flags::gameflagwait("infil_animatic_complete");
  wait(level.brgametype._id_B458560354506894);
  _id_A9EDFBDC1855B5B9("current");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialog("objective_desc", undefined, undefined, 1, 2, undefined, "dx_br_bds4_");
  level.brgametype._id_D1D6FDE697F2E010 = 2;
  thread _id_5129B71105A55FCF();
  _id_BD8347A5EBCBE61D();
  thread _id_3FF03703317ED195(level.brgametype._id_BD12E1C552278AD6);
  thread _id_CE8D756798226FF9();
  thread _id_D8A422E76C69A3DE(level.brgametype._id_B4A42A0051F3FED8);

  for(;;) {
    level waittill("activate_next_active_zones");
    level.brgametype._id_D1D6FDE697F2E010 = 0;
    level thread _id_2CEDCC356F1B9FC8::brleaderdialog("zone_activation", undefined, undefined, 1, 0, undefined, "dx_br_bds4_");
    _id_23A142E89743326D("uin_iw9_lockdown_zone_unlock");
    _id_037D4A6E29F171CE();
    _id_E1B409E458079ED2();
    _id_F1DC82AF499CA14D();
    level.brgametype._id_2A33F7CB739A32F1 = _id_3C6BB864DCC6CDA7;
    thread _id_070FF1FA71DB052C(level.brgametype._id_9FDB99442028FCA4[_id_3C6BB864DCC6CDA7], 0);
    _id_3C6BB864DCC6CDA7++;

    if(_id_3C6BB864DCC6CDA7 == level.brgametype._id_58B474CB0E57096A.size) {
      break;
    }

    level waittill("show_next_active_zone");
    _id_FDF17DDB1F56D876(level.brgametype._id_58B474CB0E57096A[_id_3C6BB864DCC6CDA7]);
    _id_388937DA6A4B9E5B("uin_iw9_lockdown_zone_unlocked_ping", level.brgametype._id_58B474CB0E57096A[_id_3C6BB864DCC6CDA7]);
    scripts\mp\hud_util::showsplashtoall("zc_zone_spawned", undefined, undefined, undefined, undefined, "splash_list_iw9_br_zonecontrol");
    level.brgametype._id_D1D6FDE697F2E010 = 1;
    level.brgametype._id_562E8657526813DE = 1;

    if(level.brgametype._id_BD5D2A7A94C784AB > 0)
      level waittill("deactivate_active_zone");

    if(_id_3C6BB864DCC6CDA7 < level.brgametype._id_58B474CB0E57096A.size) {
      level thread _id_2CEDCC356F1B9FC8::brleaderdialog("zone_deactivation", undefined, undefined, 1, 0, undefined, "dx_br_bds4_");
      _id_388937DA6A4B9E5B("uin_iw9_lockdown_zone_deactivated_ping", level.brgametype._id_58B474CB0E57096A[_id_3C6BB864DCC6CDA7]);
      _id_23A142E89743326D("uin_iw9_lockdown_round_completed");
    }

    _id_A2EEACE6CA96B9F9();
    _id_EE4FD43F55427502(level.brgametype._id_AC1C493ADFB1430E);
    level.brgametype._id_D1D6FDE697F2E010 = 2;
    level.brgametype._id_562E8657526813DE = 0;
    thread _id_D8A422E76C69A3DE(level.brgametype._id_ADAFBAF3C7E24AD3[level.brgametype._id_2A33F7CB739A32F1]);
  }
}

_id_FDF17DDB1F56D876(_id_3C6BB864DCC6CDA7) {
  _id_CCCEEC3049422EF7(_id_3C6BB864DCC6CDA7);
  _id_598B7B1949FCA42E();
  _id_D6651C2D7069674D(_id_3C6BB864DCC6CDA7);
}

_id_F7FA8A135BB71BF1() {
  _id_BAB98E6EFFF82B79 = 9;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.brgametype._id_E8B86399CBD6A85E; _id_AC0E594AC96AA3A8++) {
    _id_0E4731409BD255E0 = level.brgametype.letters[_id_AC0E594AC96AA3A8];
    scripts\mp\gamelogic::setwaypointiconinfo("zc_waypoint_lock_" + _id_0E4731409BD255E0, _id_BAB98E6EFFF82B79, "neutral", "MP_INGAME_ONLY/OBJ_ZC_LOCKED_CAPS", "icon_waypoint_lock_" + _id_0E4731409BD255E0, 0);
    scripts\mp\gamelogic::setwaypointiconinfo("zc_waypoint_defending_" + _id_0E4731409BD255E0, _id_BAB98E6EFFF82B79, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_" + _id_0E4731409BD255E0, 0);
    scripts\mp\gamelogic::setwaypointiconinfo("zc_waypoint_losing_" + _id_0E4731409BD255E0, _id_BAB98E6EFFF82B79, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_" + _id_0E4731409BD255E0, 0);
    scripts\mp\gamelogic::setwaypointiconinfo("zc_waypoint_contested_" + _id_0E4731409BD255E0, _id_BAB98E6EFFF82B79, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_" + _id_0E4731409BD255E0, 0);
    scripts\mp\gamelogic::setwaypointiconinfo("zc_waypoint_neutral_" + _id_0E4731409BD255E0, _id_BAB98E6EFFF82B79, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_" + _id_0E4731409BD255E0, 0);
  }
}

_id_D6651C2D7069674D(_id_3C6BB864DCC6CDA7) {
  if(!level.brgametype._id_6B04289A49CAE84D) {
    return;
  }
  objidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  _id_1C683105D19D60A3 = level.brgametype.clusters[_id_3C6BB864DCC6CDA7].origin;
  scripts\mp\objidpoolmanager::objective_add(objidnum, "invisible", _id_1C683105D19D60A3, "hud_icon_objective_zclock", "icon_medium");
  scripts\mp\objidpoolmanager::update_objective_setbackground(objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(objidnum, undefined);
  _func_1A20F52DE11BA2EF(objidnum, 1);
  objective_setshowdistance(objidnum, 1);
  objective_sethideelevation(objidnum, 1);
  objective_setshowoncompass(objidnum, 0);
  _func_C047D7FFE7A83501(objidnum, level.brgametype._id_A7BD67E2C17C3DC1, level.brgametype._id_36875A3DF3AE81F0);
  objective_setplayintro(objidnum, 1);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(objidnum);
  level.brgametype._id_827395AAD2C2C5A6 = objidnum;
}

_id_037D4A6E29F171CE() {
  if(!level.brgametype._id_6B04289A49CAE84D) {
    return;
  }
  level.brgametype._id_03A04D4CE47EB118 = level.brgametype._id_827395AAD2C2C5A6;
  level.brgametype._id_827395AAD2C2C5A6 = undefined;
  scripts\mp\objidpoolmanager::update_objective_icon(level.brgametype._id_03A04D4CE47EB118, "hud_icon_objective_cluster");
}

_id_A2EEACE6CA96B9F9() {
  if(!level.brgametype._id_6B04289A49CAE84D) {
    return;
  }
  scripts\mp\objidpoolmanager::returnobjectiveid(level.brgametype._id_03A04D4CE47EB118);
  level.brgametype._id_03A04D4CE47EB118 = undefined;
}

_id_CCCEEC3049422EF7(_id_3C6BB864DCC6CDA7) {
  level.brgametype._id_038BA95F71251449 = [];
  _id_3402D60C1EF6B931 = level.brgametype.clusters[_id_3C6BB864DCC6CDA7];
  _id_B2D6A56CC8091C98 = _id_3402D60C1EF6B931.zones;

  if(getdvarint("dvar_333139864C70CC89", 0) == 1) {
    foreach(zone in _id_B2D6A56CC8091C98) {
      zone._id_BCC2E271115B13F0 = level.brgametype._id_7BAB81A92B4BE919["1"];
      level.brgametype._id_038BA95F71251449[level.brgametype._id_038BA95F71251449.size] = zone;
    }

    return;
  }

  _id_D5228F9A181D6107 = 0;

  foreach(_, quantity in level.brgametype._id_293DC429F3A19DFD)
  _id_D5228F9A181D6107 = _id_D5228F9A181D6107 + quantity;

  _id_1B55F97C09461B2B = int(_id_D5228F9A181D6107 / 2);
  _id_B052895E262E979F = _id_D5228F9A181D6107 - _id_1B55F97C09461B2B;
  _id_32F0D5B203302413 = randomint(_id_B2D6A56CC8091C98.size);
  _id_F778714FF68135A2 = _id_3402D60C1EF6B931 _id_A4E4EF93C0727408(_id_3402D60C1EF6B931.zones[_id_32F0D5B203302413].origin, level.brgametype._id_E97CD8F39E602A98);
  _id_8FE9F75867D3A074 = _id_3402D60C1EF6B931 _id_E6FE58EAFE08822C(_id_F778714FF68135A2, undefined, _id_1B55F97C09461B2B);
  _id_03381A786A11D230 = _id_3402D60C1EF6B931 _id_E6FE58EAFE08822C(_id_32F0D5B203302413, _id_8FE9F75867D3A074, _id_B052895E262E979F);
  _id_880AFAB75682943B = scripts\engine\utility::array_combine(_id_8FE9F75867D3A074, _id_03381A786A11D230);
  _id_ADB94E999B24CAB3 = 0;

  foreach(_id_4677A80A385B3F2D, quantity in level.brgametype._id_293DC429F3A19DFD) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < quantity; _id_AC0E594AC96AA3A8++) {
      if(_id_ADB94E999B24CAB3 < _id_880AFAB75682943B.size) {
        zone = _id_880AFAB75682943B[_id_ADB94E999B24CAB3];
        zone._id_783809DA65285CB1 = level.brgametype.letters[_id_ADB94E999B24CAB3];
        zone._id_BCC2E271115B13F0 = level.brgametype._id_7BAB81A92B4BE919[_id_4677A80A385B3F2D];
        level.brgametype._id_038BA95F71251449[level.brgametype._id_038BA95F71251449.size] = zone;
        _id_ADB94E999B24CAB3++;
      }
    }
  }

  _id_33C85FEFC873679E(_id_32F0D5B203302413, _id_3402D60C1EF6B931, _id_ADB94E999B24CAB3);
}

_id_33C85FEFC873679E(_id_FE02B20F9AC0BD11, _id_3402D60C1EF6B931, _id_AFE57C392B4E352A) {
  if(!isDefined(level.brgametype._id_8F7905B05BA12DF4)) {
    return;
  }
  level.brgametype._id_8F7905B05BA12DF4.zones = [];
  _id_8F7905B05BA12DF4 = _id_3402D60C1EF6B931 _id_E6FE58EAFE08822C(_id_FE02B20F9AC0BD11, level.brgametype._id_038BA95F71251449, level.brgametype._id_8F7905B05BA12DF4.count);

  foreach(zone in _id_8F7905B05BA12DF4) {
    zone._id_783809DA65285CB1 = level.brgametype.letters[_id_AFE57C392B4E352A];
    zone._id_BCC2E271115B13F0 = level.brgametype._id_7BAB81A92B4BE919["2"];
    level.brgametype._id_8F7905B05BA12DF4.zones[level.brgametype._id_8F7905B05BA12DF4.zones.size] = zone;
    _id_AFE57C392B4E352A++;
  }
}

_id_D8B31B9B82F66DF6(_id_FE02B20F9AC0BD11, _id_B2D6A56CC8091C98) {
  _id_73640074AC127DFD = scripts\engine\utility::array_remove_array(_id_B2D6A56CC8091C98, level.brgametype._id_038BA95F71251449);
  _id_8065266D3F5D57B8 = scripts\engine\utility::get_array_of_closest(_id_B2D6A56CC8091C98[_id_FE02B20F9AC0BD11].origin, _id_73640074AC127DFD, undefined, level.brgametype._id_8F7905B05BA12DF4.count);
  return _id_8065266D3F5D57B8;
}

_id_A9EDFBDC1855B5B9(_id_9B1941CB7354665E) {
  foreach(zone in level.brgametype._id_038BA95F71251449) {
    if(isDefined(zone.objidnum))
      objective_state(zone.objidnum, _id_9B1941CB7354665E);
  }
}

_id_E1B409E458079ED2(zones) {
  level.brgametype._id_AC1C493ADFB1430E = level.brgametype._id_038BA95F71251449;

  foreach(zone in level.brgametype._id_AC1C493ADFB1430E)
  zone _id_9CBB049ED676E5BF();

  scripts\mp\hud_util::showsplashtoall("zc_zone_activated", undefined, undefined, undefined, undefined, "splash_list_iw9_br_zonecontrol");
}

_id_EE4FD43F55427502(zones) {
  foreach(zone in zones) {
    if(isDefined(zone.objidnum)) {
      foreach(player in zone.players) {
        if(isDefined(player)) {
          scripts\mp\objidpoolmanager::objective_unpin_player(zone.objidnum, player, 1);

          if(isDefined(player._id_6688811DFB4D2D96) && player._id_6688811DFB4D2D96 == 1) {
            player._id_6688811DFB4D2D96 = 0;
            player _id_A8722F6B1D8B1BCD(player._id_6688811DFB4D2D96);
            player _id_9B46D53ABE69E2BF(0);
            player _id_E4BF8B6F5854C6CA(0);
          }
        }
      }

      zone _id_C7641266E2FCBDE4();
      scripts\mp\objidpoolmanager::returnobjectiveid(zone.objidnum);
      zone.objidnum = undefined;
    }

    zone._id_BCC2E271115B13F0 = undefined;
    zone.players = undefined;
    zone.vehicles = undefined;
    zone._id_D9DAB6771A3CAA4E = undefined;
    zone.isactive = 0;
    zone._id_46B09B33357E572E = 0;
    zone _id_F6F080447D2F7E50();
    zone notify("deactivate_zone");
  }
}

_id_B4759D625B4E4AC0(_id_DB47053F2E2557DB) {
  if(!isDefined(level.brgametype._id_8F7905B05BA12DF4) || istrue(level.brgametype._id_FA48BEA82741B77A)) {
    return;
  }
  level endon("game_ended");
  level endon("overtime");
  level endon("deactivate_active_zone");
  eventduration = 4 + level.brgametype._id_8F7905B05BA12DF4.duration;

  if(eventduration >= _id_DB47053F2E2557DB) {
    return;
  }
  wait(_id_DB47053F2E2557DB - eventduration);

  if(istrue(level.brgametype._id_8F7905B05BA12DF4._id_8F83FE56013A157C))
    _id_BC52ACACDD2C553D();
}

_id_598B7B1949FCA42E() {
  foreach(zone in level.brgametype._id_038BA95F71251449)
  zone _id_86543DF2BB948A24();
}

_id_BC52ACACDD2C553D() {
  if(!isDefined(level.brgametype._id_8F7905B05BA12DF4) || level.brgametype._id_8F7905B05BA12DF4.zones.size == 0) {
    return;
  }
  scripts\mp\hud_util::showsplashtoall("zc_extra_zones", undefined, undefined, undefined, undefined, "splash_list_iw9_br_zonecontrol");
  wait 4;
  level thread _id_2CEDCC356F1B9FC8::brleaderdialog("high_value_zone", undefined, level.players, 0, 0, undefined, "dx_br_bds4_");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.brgametype._id_8F7905B05BA12DF4.count; _id_AC0E594AC96AA3A8++) {
    zone = level.brgametype._id_8F7905B05BA12DF4.zones[_id_AC0E594AC96AA3A8] _id_86543DF2BB948A24();
    zone _id_9CBB049ED676E5BF();
    level.brgametype._id_AC1C493ADFB1430E[level.brgametype._id_AC1C493ADFB1430E.size] = zone;
  }
}

_id_070FF1FA71DB052C(time, _id_4E378291CBEA730E) {
  level endon("game_ended");
  level endon("overtime");
  _id_ADEBCA556FBB1224(time, _id_4E378291CBEA730E);
  thread _id_B4759D625B4E4AC0(time);
  thread _id_B22B15568FFA32AF(time);
  thread _id_1524C00DE48C44F3(time, _id_4E378291CBEA730E);
  _id_3B092428347E8D66 = level.brgametype._id_2A33F7CB739A32F1 < level.brgametype._id_58B474CB0E57096A.size && time > 16 && _id_4E378291CBEA730E != 2;

  if(istrue(_id_3B092428347E8D66))
    thread _id_7E136DD8BA2417AD(time);

  _id_B9B119B5AF06D232 = min(level.brgametype._id_BD5D2A7A94C784AB, time);
  wait(time - _id_B9B119B5AF06D232);
  level notify("show_next_active_zone");
  wait(_id_B9B119B5AF06D232);
  _id_63BF192D1FD856E5(level.brgametype._id_2A33F7CB739A32F1);
  level notify("deactivate_active_zone");
  _id_5E0AAB868C752ED8();
}

_id_B22B15568FFA32AF(time) {
  level endon("game_ended");
  level endon("overtime");
  level endon("deactivate_active_zone");

  while(time > 1) {
    _id_B9E478AD63E8153B();
    wait 1;
    time--;
    level._id_2D54101DE4B3F30E = time;
  }
}

_id_4E923934E9E9FFE7(player) {
  if(isDefined(player) && isDefined(player.zone))
    return 1;

  return 0;
}

_id_BD8347A5EBCBE61D() {
  level.brgametype.starttime = gettime();
  level.brgametype._id_4A6D6CA4BC4A64C0 = 0;
}

_id_ADEBCA556FBB1224(time, type) {
  level.brgametype._id_4A6D6CA4BC4A64C0 = level.brgametype._id_4A6D6CA4BC4A64C0 + time;

  if(isDefined(type)) {
    _id_9CA19D36142D1919(type);

    if(type == 2) {
      thread _id_DF430A39E06206B7(time);
      return;
    }
  }

  _id_1E3CF8B4C4579564(level.brgametype._id_4A6D6CA4BC4A64C0);
}

_id_D8A422E76C69A3DE(time) {
  level endon("game_ended");
  level endon("overtime");
  _id_ADEBCA556FBB1224(time, 1);

  if(time > 16) {
    _id_E89C89A93773FA23 = time - 16;
    level thread _id_2CEDCC356F1B9FC8::brleaderdialog("activation_anticipation", undefined, undefined, 1, _id_E89C89A93773FA23, undefined, "dx_br_bds4_");
  }

  wait(time);
  level notify("activate_next_active_zones");
}

_id_CE8D756798226FF9() {
  level endon("game_ended");
  level endon("overtime");
  wait(level.brgametype._id_BD12E1C552278AD6 - level.brgametype._id_CCAF7DCC548B6DF3);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialog("match_end_soon", undefined, undefined, 1, 0, undefined, "dx_br_bds4_");
  wait(level.brgametype._id_CCAF7DCC548B6DF3);
  _id_0E861B56F866E4A9(1);
}

_id_67B4CFF7142DD6BB() {
  _id_045188A9F344EBFE = _id_29B527D8B0E817C3("dvar_4FDDBFB63E4AFFFA", "0 0.25 0.5 0.75 1");
  _id_9BE2DFD5A5C29111 = _id_29B527D8B0E817C3("dvar_F7D19878AACF8EE9", "18 23 28 28 18");
  _id_7C95E46027B9F37A = _id_29B527D8B0E817C3("dvar_1F76B3BA6E820F12", "18 23 28 28 18");
  _id_8B1354989EA17606 = _id_29B527D8B0E817C3("dvar_02B0D8B301DF0C16", "13 18 23 23 13");
  _id_1239A37ED7B8010D = _id_29B527D8B0E817C3("dvar_6E491DA843B1E135", "8 13 18 18 8");

  if(_id_045188A9F344EBFE.size != _id_9BE2DFD5A5C29111.size || _id_045188A9F344EBFE.size != _id_7C95E46027B9F37A.size || _id_045188A9F344EBFE.size != _id_8B1354989EA17606.size || _id_045188A9F344EBFE.size != _id_1239A37ED7B8010D.size) {}

  _id_AF41098889966EE1 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_045188A9F344EBFE.size; _id_AC0E594AC96AA3A8++)
    _id_AF41098889966EE1[_id_AC0E594AC96AA3A8] = _id_1E86E9FD0B721D59(_id_045188A9F344EBFE[_id_AC0E594AC96AA3A8], _id_9BE2DFD5A5C29111[_id_AC0E594AC96AA3A8], _id_7C95E46027B9F37A[_id_AC0E594AC96AA3A8], _id_8B1354989EA17606[_id_AC0E594AC96AA3A8], _id_1239A37ED7B8010D[_id_AC0E594AC96AA3A8]);

  return _id_AF41098889966EE1;
}

_id_1E86E9FD0B721D59(_id_64A4D492B7ADD279, _id_5819A1F831DB83D8, _id_013FE8EF58BD08ED, _id_B6E5EE78504F6791, _id_C52AC290D2752FCC) {
  _id_AF41098889966EE1 = spawnStruct();
  _id_AF41098889966EE1._id_64A4D492B7ADD279 = float(_id_64A4D492B7ADD279) * level.brgametype._id_72A3808F03841546;
  _id_AF41098889966EE1._id_96197AE66BD1D8C3 = [];
  _id_AF41098889966EE1._id_96197AE66BD1D8C3["_quads"] = int(_id_5819A1F831DB83D8);
  _id_AF41098889966EE1._id_96197AE66BD1D8C3["_trios"] = int(_id_013FE8EF58BD08ED);
  _id_AF41098889966EE1._id_96197AE66BD1D8C3["_duos"] = int(_id_B6E5EE78504F6791);
  _id_AF41098889966EE1._id_96197AE66BD1D8C3["_solos"] = int(_id_C52AC290D2752FCC);
  return _id_AF41098889966EE1;
}

_id_29B527D8B0E817C3(dvar, _id_FC8AFB765C52482B) {
  _id_34BC96CFBEE3B86F = getDvar(dvar, _id_FC8AFB765C52482B);
  return strtok(_id_34BC96CFBEE3B86F, " ");
}

_id_1300C157B617ABD7(team) {
  if(scripts\mp\utility\teams::getteamcount(team) == 0) {
    return;
  }
  _id_2237E7CB6F4D0149 = _id_A7AFCB850C19C0CF(team);

  if(_id_2237E7CB6F4D0149 == level.brgametype._id_AF41098889966EE1.size - 1) {
    return;
  }
  _id_929A6DF466DC4F22 = level.brgametype._id_6EEF49FDE768C24F[team];
  _id_5928D7192719603E = _id_2237E7CB6F4D0149;

  if(_id_929A6DF466DC4F22 >= level.brgametype._id_AF41098889966EE1[_id_2237E7CB6F4D0149 + 1]._id_64A4D492B7ADD279)
    _id_5928D7192719603E = _id_2237E7CB6F4D0149 + 1;

  if(!isDefined(level.brgametype._id_88A254227DA87C7F[team]))
    level.brgametype._id_88A254227DA87C7F[team] = spawnStruct();

  if(!isDefined(level.brgametype._id_88A254227DA87C7F[team]._id_4DADE83AA767E6B2) || _id_2237E7CB6F4D0149 != _id_5928D7192719603E) {
    level.brgametype._id_88A254227DA87C7F[team]._id_4DADE83AA767E6B2 = _id_5928D7192719603E;
    level.brgametype._id_88A254227DA87C7F[team]._id_96197AE66BD1D8C3 = level.brgametype._id_AF41098889966EE1[_id_5928D7192719603E]._id_96197AE66BD1D8C3;
  }
}

_id_A7AFCB850C19C0CF(team) {
  if(isDefined(level.brgametype._id_88A254227DA87C7F[team]))
    return level.brgametype._id_88A254227DA87C7F[team]._id_4DADE83AA767E6B2;

  return 0;
}

_id_56355C272F045E8C() {
  foreach(_id_FABF84450735DD93 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamcount(_id_FABF84450735DD93) == 0) {
      continue;
    }
    if(!isDefined(level.brgametype._id_6EEF49FDE768C24F[_id_FABF84450735DD93]))
      level.brgametype._id_6EEF49FDE768C24F[_id_FABF84450735DD93] = 0;
  }
}

_id_6D83E1AAD1B29028() {
  _id_847926C333F5EEB5 = getdvarfloat("dvar_97ADBD29C0ACFA59", 0.5);
  return level.brgametype._id_72A3808F03841546 * _id_847926C333F5EEB5;
}

_id_B9E478AD63E8153B() {
  foreach(zone in level.brgametype._id_AC1C493ADFB1430E) {
    _id_24E879E009AEE925 = zone _id_4549DA620DBE742B();

    if(zone.state != "occupied") {
      continue;
    }
    _id_9ECE534476D102BB = 0;
    _id_6AB5606DA9634C9A = zone _id_DC8C285F0E287553(level.brgametype._id_B357705D6F9B3080);
    _id_92CC00AD244291D3 = _id_6AB5606DA9634C9A;
    _id_1190AFA59B16F447 = scripts\engine\utility::ter_op(zone._id_BCC2E271115B13F0.name == "2", "highValueZone", "normalZone");

    if(istrue(_id_24E879E009AEE925))
      _id_6AB5606DA9634C9A = _id_6AB5606DA9634C9A + level.brgametype._id_416FEBDC38ED88BE;

    if(istrue(level.brgametype._id_E9A4C3DF54D13FD1)) {
      foreach(player in zone.players) {
        _id_663572CC85C027C6 = player _id_60AFA719948A5DE2(_id_6AB5606DA9634C9A, zone);

        if(istrue(_id_24E879E009AEE925))
          player _id_3AE9C7708BF1DEF0(zone);

        if(_id_663572CC85C027C6 > _id_6AB5606DA9634C9A)
          _id_6AB5606DA9634C9A = _id_663572CC85C027C6;
      }

      _id_82ABF65B162F526F(zone.players[0].team, _id_92CC00AD244291D3, _id_1190AFA59B16F447);
      _id_A5125E3BB9AA0B2A(zone.players[0].team, _id_6AB5606DA9634C9A);
      _id_9ECE534476D102BB = _id_9ECE534476D102BB + _id_6AB5606DA9634C9A;
    } else {
      foreach(player in zone.players) {
        _id_663572CC85C027C6 = player _id_60AFA719948A5DE2(_id_6AB5606DA9634C9A, zone);
        _id_A5125E3BB9AA0B2A(player.team, _id_663572CC85C027C6);
        _id_9ECE534476D102BB = _id_9ECE534476D102BB + _id_663572CC85C027C6;
      }
    }

    zone _id_3E26FDCEED81D3A8(_id_9ECE534476D102BB);
  }

  _id_8E6D11416198DA98();
  _id_17DAFC2A055018CD();
  _id_0E861B56F866E4A9();
}

_id_A5125E3BB9AA0B2A(team, points) {
  if(!isDefined(team)) {
    return;
  }
  score = _id_A97D64DD14F6D878(team) + points;
  level.brgametype._id_6EEF49FDE768C24F[team] = score;

  foreach(player in level.players) {
    if(isDefined(player)) {
      if(player.team == team)
        player _id_DAE80BBAA1D7B643(score);

      player _id_943449AC36405826(player.team);
    }
  }

  _id_1300C157B617ABD7(team);
}

_id_A97D64DD14F6D878(team) {
  if(isDefined(level.brgametype._id_6EEF49FDE768C24F[team]))
    return level.brgametype._id_6EEF49FDE768C24F[team];

  return 0;
}

_id_F151AE91A336C4F1(team) {
  if(!istrue(level.brgametype._id_FAF946460FCEE87B)) {
    return;
  }
  _id_A6AB8D0FDA441DC2 = scripts\engine\utility::array_removeundefined(scripts\mp\utility\teams::getteamdata(team, "players"));
  zones = scripts\engine\utility::array_combine(level.brgametype._id_AC1C493ADFB1430E, level.brgametype._id_038BA95F71251449);

  foreach(zone in zones) {
    if(!isDefined(zone.players)) {
      continue;
    }
    _id_09712C9E21FD915F = scripts\engine\utility::array_intersection(_id_A6AB8D0FDA441DC2, zone.players);

    foreach(player in _id_09712C9E21FD915F) {
      _id_C806C2FD9F920735 = isDefined(zone.state) && zone.state == "occupied" && _id_09712C9E21FD915F.size > 1;
      _id_6688811DFB4D2D96 = scripts\engine\utility::ter_op(_id_C806C2FD9F920735, 1, 0);

      if(!isDefined(player._id_6688811DFB4D2D96) || player._id_6688811DFB4D2D96 != _id_6688811DFB4D2D96) {
        player._id_6688811DFB4D2D96 = _id_6688811DFB4D2D96;
        player _id_A8722F6B1D8B1BCD(player._id_6688811DFB4D2D96);
      }

      _id_A6AB8D0FDA441DC2 = scripts\engine\utility::array_remove(_id_A6AB8D0FDA441DC2, player);

      if(_id_A6AB8D0FDA441DC2.size == 0)
        return;
    }
  }

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(isDefined(player._id_6688811DFB4D2D96) && player._id_6688811DFB4D2D96 == 1) {
      player._id_6688811DFB4D2D96 = 0;
      player _id_A8722F6B1D8B1BCD(player._id_6688811DFB4D2D96);
    }
  }
}

_id_E5B3ACB7936AA9E0() {
  if(isDefined(level.brgametype._id_8A5E17FAB329354C)) {
    return;
  }
  _id_CBF035D71D332C29 = _id_B0E67DD0180BB457();

  if(level.brgametype._id_080E82584C694B4A != _id_CBF035D71D332C29) {
    level.brgametype._id_080E82584C694B4A = _id_CBF035D71D332C29;
    level.brgametype._id_293DC429F3A19DFD = _id_B3E0554CF34D5CF7(_id_CBF035D71D332C29);
  }
}

_id_B0E67DD0180BB457() {
  _id_6C8D21B2E54B2478 = level.brgametype._id_8C60F1A7127109CF / level.brgametype._id_72A3808F03841546;

  if(_id_6C8D21B2E54B2478 >= 1)
    return "overtime";

  index = int(floor(level.brgametype._id_4A459E59B4B10244.size * _id_6C8D21B2E54B2478));
  return level.brgametype._id_4A459E59B4B10244[index];
}

_id_8E6D11416198DA98() {
  foreach(team in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamcount(team) == 0) {
      continue;
    }
    _id_10724EF5718C0736(team);
  }
}

_id_10724EF5718C0736(team) {
  _id_929A6DF466DC4F22 = _id_A97D64DD14F6D878(team);
  _id_963524745F704899 = _id_4B1A1903CCA7AA39();
  _id_8C60F1A7127109CF = 0;

  if(isDefined(level.brgametype._id_B184DDAD2BCF6F49))
    _id_8C60F1A7127109CF = _id_A97D64DD14F6D878(level.brgametype._id_B184DDAD2BCF6F49);

  _id_AB08F00196E4BE49 = _id_929A6DF466DC4F22 == _id_963524745F704899;
  _id_159B57523989B823 = isDefined(level.brgametype._id_B184DDAD2BCF6F49) && level.brgametype._id_B184DDAD2BCF6F49 == team;
  _id_0E93B3F2ABEAB81C = _id_8C60F1A7127109CF < _id_963524745F704899;

  if(_id_AB08F00196E4BE49 && (_id_159B57523989B823 || _id_0E93B3F2ABEAB81C)) {
    level.brgametype._id_B184DDAD2BCF6F49 = team;
    level.brgametype._id_8C60F1A7127109CF = _id_929A6DF466DC4F22;

    if(_id_929A6DF466DC4F22 < level.brgametype._id_72A3808F03841546)
      _id_E5B3ACB7936AA9E0();

    if(_id_FBD948A0967F8AF1() && (!isDefined(level.brgametype._id_3237373815779BF5) || istrue(_id_0E93B3F2ABEAB81C))) {
      level notify("new_leaders");
      _id_B7F04AE2F89F6846();
      _id_871FB9DF81CDD81E();
    }

    if(!isDefined(level.brgametype._id_F24DD2E0D7A9FBC1) && level.brgametype._id_8C60F1A7127109CF > level.brgametype._id_65C42F3AC6958818) {
      _id_A2A83B7513C9A3DE("zc_midscore_leaders", "zc_midscore_others", "halfway_leaders", "halfway_others");
      level.brgametype._id_F24DD2E0D7A9FBC1 = 1;
    }

    if(_id_D4F2D1878F57440B())
      level.brgametype._id_8F7905B05BA12DF4._id_8F83FE56013A157C = 1;

    if(!isDefined(level.brgametype._id_72138BFFB8750C2A) && level.brgametype._id_8C60F1A7127109CF > level.brgametype._id_2D08E0F710460F75) {
      _id_A2A83B7513C9A3DE("zc_majorityscore_leaders", "zc_majorityscore_others", "victory_close_leaders", "victory_close_others");
      level.brgametype._id_72138BFFB8750C2A = 1;
    }
  }
}

_id_4B1A1903CCA7AA39() {
  _id_963524745F704899 = 0;

  foreach(team in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamcount(team) == 0) {
      continue;
    }
    _id_929A6DF466DC4F22 = _id_A97D64DD14F6D878(team);

    if(_id_929A6DF466DC4F22 > _id_963524745F704899)
      _id_963524745F704899 = _id_929A6DF466DC4F22;
  }

  return _id_963524745F704899;
}

_id_8FFE98714B82D58B(team) {
  if(isDefined(level.brgametype._id_B184DDAD2BCF6F49))
    return team == level.brgametype._id_B184DDAD2BCF6F49;

  return 0;
}

_id_D4F2D1878F57440B() {
  return isDefined(level.brgametype._id_8F7905B05BA12DF4) && !isDefined(level.brgametype._id_8F7905B05BA12DF4._id_8F83FE56013A157C) && level.brgametype._id_8C60F1A7127109CF > level.brgametype._id_8F7905B05BA12DF4._id_12926948D93C7ED0;
}

_id_FBD948A0967F8AF1() {
  progression = level.brgametype._id_8C60F1A7127109CF / level.brgametype._id_72A3808F03841546 * 100;

  if(progression >= level.brgametype._id_9FC633A4965B8851)
    return 1;

  return 0;
}

_id_871FB9DF81CDD81E() {
  level.brgametype._id_3237373815779BF5 = level.brgametype._id_B184DDAD2BCF6F49;
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(level.brgametype._id_3237373815779BF5, "players");
  hasbeentracked = scripts\engine\utility::array_contains(level.brgametype._id_FF62FBB921AE39BD, level.brgametype._id_3237373815779BF5);

  foreach(player in level.players) {
    if(isDefined(player) && isalive(player)) {
      if(scripts\engine\utility::array_contains(_id_A6AB8D0FDA441DC2, player)) {
        _id_1B4ADA49A21B51CA = scripts\engine\utility::ter_op(hasbeentracked, "zc_lead_won", "zc_top_marked");
        vo = scripts\engine\utility::ter_op(hasbeentracked, "lead_taking", "lead_first");
        player scripts\mp\hud_message::showsplash(_id_1B4ADA49A21B51CA, undefined, undefined, undefined, undefined, "splash_list_iw9_br_zonecontrol");
        level thread _id_2CEDCC356F1B9FC8::brleaderdialog(vo, undefined, [player], 1, 0, undefined, "dx_br_bds4_");
        player thread _id_CF348FB9247C7213();
        continue;
      }

      if(!isDefined(level.brgametype._id_C4D2C929F6186C8A)) {
        player scripts\mp\hud_message::showsplash("zc_top_team_marked", undefined, undefined, undefined, undefined, "splash_list_iw9_br_zonecontrol");
        level thread _id_2CEDCC356F1B9FC8::brleaderdialog("lead_marked", undefined, [player], 1, 0, undefined, "dx_br_bds4_");
      }
    }
  }

  if(!isDefined(level.brgametype._id_C4D2C929F6186C8A))
    level.brgametype._id_C4D2C929F6186C8A = 1;

  if(!hasbeentracked)
    level.brgametype._id_FF62FBB921AE39BD[level.brgametype._id_FF62FBB921AE39BD.size] = level.brgametype._id_3237373815779BF5;
}

_id_B7F04AE2F89F6846(_id_5AF933B7B2B07F42) {
  if(!isDefined(level.brgametype._id_3237373815779BF5)) {
    return;
  }
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(level.brgametype._id_3237373815779BF5, "players");

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(isDefined(player) && isalive(player))
      _id_7754E43584E5A8EA(player, player.objidnum, _id_5AF933B7B2B07F42);
  }
}

_id_F46E5521AC7DD59F() {
  _id_88F532FCB60E4622 = [];
  _id_CEB1FF9428033CFD = [];

  foreach(player in level.players) {
    if(isDefined(player)) {
      if(_id_8FFE98714B82D58B(player.team)) {
        _id_88F532FCB60E4622[_id_88F532FCB60E4622.size] = player;
        continue;
      }

      _id_CEB1FF9428033CFD[_id_CEB1FF9428033CFD.size] = player;
    }
  }

  players = spawnStruct();
  players._id_CE3C23B4AB427559 = _id_88F532FCB60E4622;
  players.others = _id_CEB1FF9428033CFD;
  return players;
}

_id_A2A83B7513C9A3DE(_id_E5E5E4D824208AD2, _id_915478BABBBB5B95, _id_2BB9FB22D055AFF6, _id_A9C602D95D54000D) {
  players = _id_F46E5521AC7DD59F();

  foreach(player in players._id_CE3C23B4AB427559)
  player scripts\mp\hud_message::showsplash(_id_E5E5E4D824208AD2, undefined, undefined, undefined, undefined, "splash_list_iw9_br_zonecontrol");

  foreach(player in players.others)
  player scripts\mp\hud_message::showsplash(_id_915478BABBBB5B95, undefined, undefined, undefined, undefined, "splash_list_iw9_br_zonecontrol");

  if(isDefined(_id_2BB9FB22D055AFF6))
    level thread _id_2CEDCC356F1B9FC8::brleaderdialog(_id_2BB9FB22D055AFF6, undefined, players._id_CE3C23B4AB427559, 1, 0, undefined, "dx_br_bds4_");

  if(isDefined(_id_A9C602D95D54000D))
    level thread _id_2CEDCC356F1B9FC8::brleaderdialog(_id_A9C602D95D54000D, undefined, players.others, 1, 0, undefined, "dx_br_bds4_");
}

_id_CC65FF69B7798D8A() {
  _id_6C8D21B2E54B2478 = getdvarfloat("dvar_8649481A9908DB9E", 0.5);
  return level.brgametype._id_72A3808F03841546 * _id_6C8D21B2E54B2478;
}

_id_4B142266DB88B16F() {
  _id_6C8D21B2E54B2478 = getdvarfloat("dvar_D944221A78AF1923", 0.8463);
  return level.brgametype._id_72A3808F03841546 * _id_6C8D21B2E54B2478;
}

_id_D029C67042B833EF() {
  _id_6C8D21B2E54B2478 = getdvarfloat("dvar_8649481A9908DB9E", 0.01);
  return level.brgametype._id_72A3808F03841546 * _id_6C8D21B2E54B2478;
}

_id_127EE218EB82D3C1() {
  level.brgametype._id_10182C9DCAF0D685 = 1;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player _id_1E4A61DB11011446::_id_96D6B5E51DD4A63B();
    player._id_5393B7EE3366D551 = 0;
  }
}

_id_0E861B56F866E4A9(_id_6DCC0656A06D44F4) {
  if(istrue(level.brgametype._id_8A5E17FAB329354C)) {
    return;
  }
  if(istrue(_id_6DCC0656A06D44F4) || level.brgametype._id_8C60F1A7127109CF >= level.brgametype._id_72A3808F03841546) {
    level.brgametype._id_8A5E17FAB329354C = 1;
    _id_FC9C904AB75E6755(istrue(_id_6DCC0656A06D44F4));
  }
}

_id_FC9C904AB75E6755(_id_6DCC0656A06D44F4) {
  if(getdvarint("dvar_9CAA664D3FC05216", 1) == 0) {
    thread _id_673752017801BE1A(_id_6DCC0656A06D44F4);
    return;
  }

  foreach(team, _id_9A1C82E113823B06 in level.brgametype._id_6EEF49FDE768C24F) {
    if(!_id_8FFE98714B82D58B(team)) {
      _id_4FCA91C462F41CE6 = level.brgametype._id_8C60F1A7127109CF - _id_9A1C82E113823B06;

      if(_id_4FCA91C462F41CE6 <= level.brgametype._id_30A69220CB03BBA6) {
        thread _id_701A4D4DE297E642();
        return;
      }
    }
  }

  thread _id_673752017801BE1A(_id_6DCC0656A06D44F4);
}

_id_D99C89AE27F855E5() {
  foreach(player in level.players) {
    if(isDefined(player)) {
      player notify("force_stop_respawn");
      player freezecontrols(1);
    }
  }
}

_id_701A4D4DE297E642() {
  level endon("game_ended");
  level notify("overtime");
  level.brgametype._id_FA48BEA82741B77A = 1;
  _id_FC4560A4BF4BB156 = getdvarint("dvar_6D4C043F839D0769", 60);
  thread _id_21CCCABF14B4DBE6::_id_628F61246095F688(level.brgametype._id_2A33F7CB739A32F1, _id_FC4560A4BF4BB156);
  scripts\mp\hud_util::showsplashtoall("zc_overtime", undefined, undefined, undefined, undefined, "splash_list_iw9_br_zonecontrol");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialog("overtime_start", undefined, undefined, 0, 0, undefined, "dx_br_bds4_");
  _id_494FF493B7C30886();
  _id_070FF1FA71DB052C(_id_FC4560A4BF4BB156, 2);
  thread _id_4187B508EE08DBD4();
}

_id_494FF493B7C30886() {
  foreach(zone in level.brgametype._id_AC1C493ADFB1430E) {
    zone._id_BCC2E271115B13F0 = level.brgametype._id_7BAB81A92B4BE919["2"];
    zone _id_12F42921034BD85D(zone._id_BCC2E271115B13F0.name);
    zone _id_D230E52EA9D04F61();
  }
}

_id_4187B508EE08DBD4() {
  level endon("game_ended");

  if(level.brgametype._id_63F2DD4C20977582 > 0)
    level.brgametype._id_63F2DD4C20977582 = 0;

  scripts\mp\hud_util::showsplashtoall("zc_end_game_times_up", undefined, undefined, undefined, undefined, "splash_list_iw9_br_zonecontrol");
  wait 5.5;
  _id_985ED0BA7CD89AF4();
}

_id_673752017801BE1A(_id_6DCC0656A06D44F4) {
  _id_D99C89AE27F855E5();
  _id_EE4FD43F55427502(level.brgametype._id_AC1C493ADFB1430E);
  level.skipplaybodycountsound = 1;

  if(istrue(_id_6DCC0656A06D44F4))
    thread _id_4187B508EE08DBD4();
  else
    _id_985ED0BA7CD89AF4();
}

_id_985ED0BA7CD89AF4() {
  if(istrue(level.brgametype._id_FEE4704875DAE062)) {
    return;
  }
  if(level.brgametype._id_63F2DD4C20977582 > 0)
    level.brgametype._id_63F2DD4C20977582 = 0;

  _id_127EE218EB82D3C1();
  level.brgametype._id_FEE4704875DAE062 = 1;
  _id_8BCF55E50A4A221C = 0;
  _id_3E270BE7101B9308 = 0;

  foreach(_id_FABF84450735DD93 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamcount(_id_FABF84450735DD93) == 0) {
      continue;
    }
    _id_00AE17C5A8B1BC1B = _id_2AEE645E0C39ABD4(_id_FABF84450735DD93);

    if(_id_00AE17C5A8B1BC1B == 1)
      _id_8BCF55E50A4A221C = _id_A97D64DD14F6D878(_id_FABF84450735DD93);
    else if(_id_00AE17C5A8B1BC1B == 2)
      _id_3E270BE7101B9308 = _id_A97D64DD14F6D878(_id_FABF84450735DD93);

    _id_06F1B573F9CDBE3D(_id_FABF84450735DD93, _id_00AE17C5A8B1BC1B);

    if(!_id_8FFE98714B82D58B(_id_FABF84450735DD93)) {
      _id_52CC6C848F589AD3 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "alivePlayers");

      if(_id_52CC6C848F589AD3.size > 0) {
        foreach(player in _id_52CC6C848F589AD3) {
          player.plotarmor = 1;
          player freezecontrols(1);
          player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
          player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_gametype_zonecontrol::brZoneControl_endGame()");
          player scripts\mp\weapons::disableburnfx();
        }
      }
    }
  }

  _id_D0E600DEB7949696(level.brgametype._id_2A33F7CB739A32F1, _id_8BCF55E50A4A221C - _id_3E270BE7101B9308);
  winner = scripts\engine\utility::ter_op(isDefined(level.brgametype._id_B184DDAD2BCF6F49), level.brgametype._id_B184DDAD2BCF6F49, "tie");
  thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["objective_completed"], game["end_reason"]["br_eliminated"]);
}

_id_06F1B573F9CDBE3D(team, _id_AC573FB60ACEDACE) {
  foreach(player in level.teamdata[team]["players"]) {
    if(!isDefined(player)) {
      continue;
    }
    player setclientomnvar("ui_br_player_position", _id_AC573FB60ACEDACE);

    if(_id_AC573FB60ACEDACE > 1)
      player setclientomnvar("ui_br_squad_eliminated_active", 1);
  }
}

_id_F1DC82AF499CA14D() {
  foreach(player in level.players) {
    if(isDefined(player) && isalive(player))
      player thread _id_C31D411C03F9923B();
  }
}

_id_7E136DD8BA2417AD(time) {
  level endon("game_ended");
  level endon("overtime");
  _id_E89C89A93773FA23 = time - 16;
  wait(_id_E89C89A93773FA23);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialog("deactivation_anticipation", undefined, undefined, 1, 0, undefined, "dx_br_bds4_");
}

_id_C453D69202CBFB0F() {
  scripts\cp_mp\utility\omnvar_utility::_id_D3CF7FF1A257E2C3("ui_zonecontrol_game_data", 0, 13, level.brgametype._id_72A3808F03841546);
}

_id_3FF03703317ED195(value) {
  level endon("game_ended");
  setomnvar("ui_br_circle_state", 5);
  time = value * 1000;
  setomnvar("ui_hardpoint_timer", int(level.brgametype.starttime + time));
  wait(int(max(value - level.brgametype._id_9429AEBA8918C5CA, 0)));
  setomnvar("ui_br_circle_state", 6);
}

_id_1E3CF8B4C4579564(value) {
  time = value * 1000;
  setomnvar("ui_zonecontrol_round_timer_value", int(level.brgametype.starttime + time));
}

_id_9CA19D36142D1919(value) {
  scripts\cp_mp\utility\omnvar_utility::_id_D3CF7FF1A257E2C3("ui_zonecontrol_game_data", 13, 2, value);
}

_id_DF430A39E06206B7(value) {
  level endon("game_ended");
  setomnvar("ui_br_circle_state", 5);
  gametime = gettime();
  time = value * 1000;
  setomnvar("ui_hardpoint_timer", int(gametime + time));
  setomnvar("ui_zonecontrol_round_timer_value", int(gametime + time));
  wait(int(max(value - level.brgametype._id_D35C2D99F63CEC4A, 0)));
  setomnvar("ui_br_circle_state", 6);
}

_id_8ECDB9663CB000AC() {
  _id_9320300321C77F03 = [];
  _id_9320300321C77F03[0] = int(min(self._id_662A7FF003A3442F, 1023));
  _id_9320300321C77F03[1] = int(min(self._id_393B1E905723327D, 4095));
  return _id_9320300321C77F03;
}

_id_46DB667F66F9761E(ent) {
  return ent scripts\common\vehicle::isvehicle() || isDefined(ent.classname) && ent.classname == "script_vehicle";
}

_id_FAFD7A9DE6E4BA1E() {
  _id_3402D60C1EF6B931 = self;
  zones = getEntArray(_id_3402D60C1EF6B931.target, "targetname");
  _id_B2D6A56CC8091C98 = [];
  _id_FE02B20F9AC0BD11 = 0;

  foreach(zone in zones) {
    if(scripts\engine\utility::array_contains(level.brgametype._id_A0712831EC60EE71, zone.target)) {
      continue;
    }
    zone _id_432462422E56F3A1();
    zone._id_783809DA65285CB1 = level.brgametype.letters[_id_FE02B20F9AC0BD11];
    _id_B2D6A56CC8091C98[_id_B2D6A56CC8091C98.size] = zone;
    _id_FE02B20F9AC0BD11++;
  }

  return _id_B2D6A56CC8091C98;
}

_id_75D1F81D43231B87() {
  _id_3402D60C1EF6B931 = self;
  _id_C33028419AD7ACD5 = _id_3402D60C1EF6B931.script_noteworthy;
  _id_D07B1C610B748F16 = [];

  if(_id_C33028419AD7ACD5 != "") {
    _id_3D59C36E185837A1 = strtok(_id_C33028419AD7ACD5, " ");

    foreach(_id_D65996EBBBD652A8 in _id_3D59C36E185837A1) {
      if(scripts\engine\utility::array_contains(level.brgametype._id_7253B43EF30F88B9, _id_D65996EBBBD652A8)) {
        continue;
      }
      _id_D07B1C610B748F16[_id_D07B1C610B748F16.size] = _id_D65996EBBBD652A8;
    }
  }

  return _id_D07B1C610B748F16;
}

_id_E6FE58EAFE08822C(_id_FE02B20F9AC0BD11, _id_6342A5CD84590602, _id_D5228F9A181D6107, _id_53002C30822E754C) {
  _id_3402D60C1EF6B931 = self;
  origin = _id_3402D60C1EF6B931.zones[_id_FE02B20F9AC0BD11].origin;
  _id_8065266D3F5D57B8 = scripts\engine\utility::get_array_of_closest(origin, _id_3402D60C1EF6B931.zones, _id_6342A5CD84590602, _id_D5228F9A181D6107, undefined, _id_53002C30822E754C);
  return scripts\engine\utility::array_randomize(_id_8065266D3F5D57B8);
}

_id_A4E4EF93C0727408(origin, mindistance) {
  _id_3402D60C1EF6B931 = self;
  _id_73A56D219E2F275A = undefined;
  _id_E55FCDED0888C103 = undefined;
  _id_37E269D27E0AFA73 = undefined;
  _id_46AE9A117F132A0A = -1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3402D60C1EF6B931.zones.size; _id_AC0E594AC96AA3A8++) {
    _id_84A154235C811394 = distance2d(origin, _id_3402D60C1EF6B931.zones[_id_AC0E594AC96AA3A8].origin);

    if(!isDefined(_id_E55FCDED0888C103) || _id_84A154235C811394 < _id_E55FCDED0888C103) {
      if(_id_84A154235C811394 >= mindistance) {
        _id_E55FCDED0888C103 = _id_84A154235C811394;
        _id_73A56D219E2F275A = _id_AC0E594AC96AA3A8;
        continue;
      }

      if(_id_84A154235C811394 > _id_46AE9A117F132A0A) {
        _id_46AE9A117F132A0A = _id_84A154235C811394;
        _id_37E269D27E0AFA73 = _id_AC0E594AC96AA3A8;
      }
    }
  }

  return scripts\engine\utility::ter_op(isDefined(_id_73A56D219E2F275A), _id_73A56D219E2F275A, _id_37E269D27E0AFA73);
}

_id_432462422E56F3A1() {
  zone = self;
  chevrons = getentitylessscriptablearray(zone.target, "targetname");
  _id_E23E0BAB88C6EF9F = [];

  foreach(_id_0EAE85273686F4F4 in chevrons) {
    if(isDefined(_id_0EAE85273686F4F4.script_noteworthy)) {
      _id_0EAE85273686F4F4._id_B779CB958BC7769A = int(_id_0EAE85273686F4F4.script_noteworthy);
      _id_E23E0BAB88C6EF9F[_id_E23E0BAB88C6EF9F.size] = _id_0EAE85273686F4F4;
      continue;
    }
  }

  zone.chevrons = _id_E23E0BAB88C6EF9F;
}

_id_12F42921034BD85D(_id_D660EEA11ECEAF33) {
  zone = self;

  foreach(_id_BCC2E271115B13F0 in level.brgametype._id_7BAB81A92B4BE919) {
    if(_id_D660EEA11ECEAF33 == _id_BCC2E271115B13F0.name) {
      zone._id_BCC2E271115B13F0 = _id_BCC2E271115B13F0;
      break;
    }
  }

  foreach(_id_0EAE85273686F4F4 in zone.chevrons) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0EAE85273686F4F4._id_B779CB958BC7769A; _id_AC0E594AC96AA3A8++)
      _id_0EAE85273686F4F4 setscriptablepartstate("chevron_" + _id_AC0E594AC96AA3A8, zone._id_BCC2E271115B13F0.name);
  }

  zone _id_A36DD8549E61C2A1();
}

_id_86543DF2BB948A24() {
  zone = self;
  zone.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  zone.players = [];
  zone.vehicles = [];
  zone._id_82A3887C0F3B738A = [];
  zone._id_383B3DE50746912A = [];
  zone.score = 0;
  zone.isactive = 0;
  zone._id_46B09B33357E572E = 1;
  zone.state = "lock";
  zone._id_F7EC6D992938B955 = undefined;
  zone._id_4EB63A0DC6CD6400 = undefined;
  zone _id_CEBE23E67CC65F6D();
  zone _id_A36DD8549E61C2A1();
  zone _id_F6F080447D2F7E50();
  zone thread _id_95E3204D0AA4581F();
  zone thread _id_BE2486DD0DEF6253();
  return zone;
}

_id_9CBB049ED676E5BF() {
  zone = self;
  zone _id_12F42921034BD85D(zone._id_BCC2E271115B13F0.name);
  zone thread _id_6F0E0E33CDB00EF6();
  zone.isactive = 1;
  zone._id_D004EDE2F247EB3E = [];
  zone._id_46B09B33357E572E = 0;
  zone _id_F6F080447D2F7E50();
  zone thread _id_2C76EC79BE5EFFDB();
  zone notify("zone_activated");
}

_id_F6F080447D2F7E50() {
  zone = self;
  _id_9B1941CB7354665E = zone.state;
  _id_838778220EEDE9FC = undefined;
  _id_13A59BDAB41BACC9 = 0;
  _id_7E62E3E7308090D3 = [];

  if(istrue(zone.isactive)) {
    if(istrue(zone._id_46B09B33357E572E))
      zone._id_46B09B33357E572E = 0;

    if(zone.players.size == 0)
      _id_9B1941CB7354665E = "idle";
    else {
      foreach(player in zone.players) {
        if(isDefined(player) && !scripts\engine\utility::array_contains(_id_7E62E3E7308090D3, player.team))
          _id_7E62E3E7308090D3 = scripts\engine\utility::array_add(_id_7E62E3E7308090D3, player.team);
      }

      if(_id_7E62E3E7308090D3.size > 1)
        _id_9B1941CB7354665E = "contested";
      else {
        _id_9B1941CB7354665E = "occupied";
        _id_838778220EEDE9FC = _id_7E62E3E7308090D3[0];
      }
    }
  } else
    _id_9B1941CB7354665E = scripts\engine\utility::ter_op(istrue(zone._id_46B09B33357E572E), "lock", "off");

  _id_46B09B33357E572E = _id_9B1941CB7354665E == "lock";
  isidle = _id_9B1941CB7354665E == "idle";
  _id_A5250821FB1BEA6A = _id_9B1941CB7354665E == "contested";
  _id_950511821B7A2895 = _id_9B1941CB7354665E == "occupied";
  _id_3C0F5C8539E8F9AE = zone.state != _id_9B1941CB7354665E;
  _id_5E8BD0E4EBF95AC4 = !isDefined(zone.owner) && isDefined(_id_838778220EEDE9FC);
  _id_443185A3B7BBA89C = isDefined(zone.owner) && isDefined(_id_838778220EEDE9FC) && zone.owner != _id_838778220EEDE9FC;
  _id_13A59BDAB41BACC9 = isDefined(zone.owner) && zone.owner != "" && _id_A5250821FB1BEA6A && !scripts\engine\utility::array_contains(_id_7E62E3E7308090D3, zone.owner);
  _id_2098F6281324136C = _id_5E8BD0E4EBF95AC4 || _id_443185A3B7BBA89C;

  if(_id_2098F6281324136C) {
    zone.owner = _id_838778220EEDE9FC;

    if(_id_5E8BD0E4EBF95AC4)
      zone._id_D9DAB6771A3CAA4E = _id_838778220EEDE9FC;

    zone notify("newOwner");
  }

  if(_id_13A59BDAB41BACC9) {
    zone._id_D9DAB6771A3CAA4E = zone.owner;
    zone.owner = "";
    zone notify("ownerLeft");
  }

  if(_id_3C0F5C8539E8F9AE) {
    zone notify("state_changed");
    zone notify("zone_is_" + _id_9B1941CB7354665E);
    zone.state = _id_9B1941CB7354665E;

    if(_id_A5250821FB1BEA6A)
      zone _id_675E7D91F544F261();
    else if(_id_950511821B7A2895) {
      zone _id_C7689CDC1D1FCA8A();

      if(isDefined(zone._id_D9DAB6771A3CAA4E) && zone.owner != zone._id_D9DAB6771A3CAA4E)
        zone._id_D9DAB6771A3CAA4E = undefined;
    } else if(isidle) {
      zone.owner = undefined;
      zone._id_D9DAB6771A3CAA4E = undefined;
    }
  }

  if(_id_46B09B33357E572E || _id_3C0F5C8539E8F9AE || _id_2098F6281324136C) {
    zone _id_A36DD8549E61C2A1();

    if(isDefined(zone.objidnum))
      zone _id_D230E52EA9D04F61();

    zone _id_753569A44545AAF7();

    foreach(team in _id_7E62E3E7308090D3)
    _id_F151AE91A336C4F1(team);
  }

  zone notify("state_updated");
}

_id_C7689CDC1D1FCA8A() {
  zone = self;

  foreach(player in zone.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(player.team == zone.owner)
      level thread _id_2CEDCC356F1B9FC8::brleaderdialog("zone_secured", undefined, [player], 0, 0, undefined, "dx_br_bds4_");
  }

  zone _id_A41693628D26AD26(zone.owner);
}

_id_675E7D91F544F261() {
  zone = self;
  _id_07A46553E8BFE265 = [];

  foreach(player in zone.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(isDefined(zone.owner) && player.team == zone.owner) {
      level thread _id_2CEDCC356F1B9FC8::brleaderdialog("zone_contested", undefined, [player], 0, 0, undefined, "dx_br_bds4_");
      continue;
    }

    level thread _id_2CEDCC356F1B9FC8::brleaderdialog("attacking_zone", undefined, [player], 0, 0, undefined, "dx_br_bds4_");
    _id_07A46553E8BFE265 = scripts\engine\utility::_id_6D6AF8144A5131F1(_id_07A46553E8BFE265, player.team);
  }

  if(isDefined(zone.owner))
    _id_0C7CB254B79C81A4(zone.owner);

  foreach(team in _id_07A46553E8BFE265)
  zone _id_AB7CD2B966CA5855(team);
}

_id_AB7CD2B966CA5855(_id_A84A76D896EBE174) {
  if(!istrue(level.brgametype._id_D6F1CDC1F64D318E)) {
    return;
  }
  zone = self;
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(_id_A84A76D896EBE174, "players");

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(!scripts\engine\utility::array_contains(zone.players, player))
      level thread _id_2CEDCC356F1B9FC8::brleaderdialog("attacking_" + zone._id_783809DA65285CB1, undefined, [player], 0, 0, undefined, "dx_br_bds4_");
  }
}

_id_0C7CB254B79C81A4(ownerteam) {
  if(!istrue(level.brgametype._id_D6F1CDC1F64D318E)) {
    return;
  }
  zone = self;
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(ownerteam, "players");

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(!scripts\engine\utility::array_contains(zone.players, player))
      level thread _id_2CEDCC356F1B9FC8::brleaderdialog(zone._id_783809DA65285CB1 + "_contested", undefined, [player], 0, 0, undefined, "dx_br_bds4_");
  }
}

_id_A41693628D26AD26(ownerteam) {
  if(!istrue(level.brgametype._id_D6F1CDC1F64D318E)) {
    return;
  }
  zone = self;
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(ownerteam, "players");

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(!scripts\engine\utility::array_contains(zone.players, player))
      level thread _id_2CEDCC356F1B9FC8::brleaderdialog(zone._id_783809DA65285CB1 + "_secured", undefined, [player], 0, 0, undefined, "dx_br_bds4_");
  }
}

_id_6DD0CE29670EEE49(team) {
  zone = self;
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");
  _id_45A3EB54A169CEF8 = [];

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(isDefined(player) && isalive(player) && scripts\engine\utility::array_contains(zone.players, player))
      _id_45A3EB54A169CEF8[_id_45A3EB54A169CEF8.size] = player;
  }

  return _id_45A3EB54A169CEF8;
}

_id_28E62546DF1DF48D(team) {
  zone = self;
  _id_5E1D8A112CE40669 = spawnStruct();
  _id_5E1D8A112CE40669.progress = 0;
  _id_5E1D8A112CE40669.players = [];
  zone._id_DEFCBDC5B9796B2E[team] = _id_5E1D8A112CE40669;
}

_id_2C76EC79BE5EFFDB() {
  if(!istrue(level.brgametype._id_6E933AB788BF25E7)) {
    return;
  }
  zone = self;
  level endon("game_ended");
  zone endon("deactivate_zone");
  zone._id_DEFCBDC5B9796B2E = [];
  zone childthread _id_5A4A36906BC5AB3C();

  for(;;) {
    zone waittill("newOwner");

    if(!isDefined(zone._id_D9DAB6771A3CAA4E) || zone._id_D9DAB6771A3CAA4E != zone.owner)
      zone thread _id_CCB54531676BD87E(zone.owner);
  }
}

_id_CCB54531676BD87E(team) {
  zone = self;
  zone endon("newOwner");
  zone endon("takeover");
  zone endon("ownerLeft");
  zone endon("deactivate_zone");
  _id_B4410FA3070BDB2F = level.brgametype._id_B4410FA3070BDB2F;

  while(istrue(zone.isactive) && zone.owner == team) {
    while(zone.state == "occupied") {
      wait 1;

      if(!istrue(zone.state == "occupied")) {
        continue;
      }
      _id_B4410FA3070BDB2F--;
      _id_09712C9E21FD915F = zone _id_6DD0CE29670EEE49(team);

      foreach(player in _id_09712C9E21FD915F) {
        if(!isDefined(player)) {
          continue;
        }
        progress = level.brgametype._id_B4410FA3070BDB2F - _id_B4410FA3070BDB2F;
        zone._id_DEFCBDC5B9796B2E[player.team].progress = progress;
        player _id_E4BF8B6F5854C6CA(progress);
      }

      if(_id_B4410FA3070BDB2F == 0) {
        zone._id_D9DAB6771A3CAA4E = team;
        zone _id_FC7D1961A75CA741(team);
        zone notify("takeover");
      }
    }

    zone waittill("state_updated");
  }
}

_id_5A4A36906BC5AB3C() {
  zone = self;
  _id_12A76D3D3D173A49 = [];

  while(istrue(zone.isactive)) {
    _id_EDB67895AA6D6773 = [];
    _id_8FE35CAA2BAF54B0 = [];
    _id_EDB67895AA6D6773 = scripts\engine\utility::array_difference(_id_12A76D3D3D173A49, zone.players);
    _id_8FE35CAA2BAF54B0 = scripts\engine\utility::array_difference(zone.players, _id_12A76D3D3D173A49);

    foreach(player in _id_8FE35CAA2BAF54B0) {
      if(!isDefined(player)) {
        continue;
      }
      if(isDefined(zone.owner) && (!isDefined(zone._id_D9DAB6771A3CAA4E) || zone._id_D9DAB6771A3CAA4E != player.team)) {
        if(!scripts\engine\utility::array_contains_key(zone._id_DEFCBDC5B9796B2E, player.team))
          zone _id_28E62546DF1DF48D(player.team);

        zone._id_DEFCBDC5B9796B2E[player.team].players = scripts\engine\utility::array_add(zone._id_DEFCBDC5B9796B2E[player.team].players, player);
        player _id_E4BF8B6F5854C6CA(zone._id_DEFCBDC5B9796B2E[player.team].progress);
        player _id_9B46D53ABE69E2BF(1);
      }
    }

    foreach(player in _id_EDB67895AA6D6773) {
      if(!isDefined(player)) {
        continue;
      }
      player _id_9B46D53ABE69E2BF(0);
      player _id_E4BF8B6F5854C6CA(0);

      if(isDefined(zone._id_DEFCBDC5B9796B2E[player.team])) {
        zone._id_DEFCBDC5B9796B2E[player.team].players = scripts\engine\utility::array_remove(zone._id_DEFCBDC5B9796B2E[player.team].players, player);

        if(zone._id_DEFCBDC5B9796B2E[player.team].players.size == 0) {
          zone._id_DEFCBDC5B9796B2E = scripts\engine\utility::array_remove_key(zone._id_DEFCBDC5B9796B2E, player.team);

          if(isDefined(zone._id_D9DAB6771A3CAA4E) && zone._id_D9DAB6771A3CAA4E == player.team)
            zone._id_D9DAB6771A3CAA4E = undefined;
        }
      }
    }

    _id_12A76D3D3D173A49 = zone.players;
    zone scripts\engine\utility::waittill_any_two("state_updated", "player_left");
  }
}

_id_FC7D1961A75CA741(owner) {
  zone = self;

  foreach(player in zone.players) {
    if(player.team == owner)
      player _id_60AFA719948A5DE2(level.brgametype._id_F5CA6A058F95E438, zone, 1);
  }

  _id_82ABF65B162F526F(owner, level.brgametype._id_F5CA6A058F95E438, "takeover");
  _id_A5125E3BB9AA0B2A(owner, level.brgametype._id_F5CA6A058F95E438);
  zone _id_3E26FDCEED81D3A8(level.brgametype._id_F5CA6A058F95E438);
  _id_10724EF5718C0736(owner);
  _id_17DAFC2A055018CD();
  _id_0E861B56F866E4A9();
}

_id_753569A44545AAF7() {
  zone = self;

  if(!isDefined(zone.players) || zone.players.size == 0) {
    return;
  }
  foreach(player in zone.players) {
    if(isDefined(player))
      player _id_10E521B3E1ABC656(zone);
  }
}

_id_A36DD8549E61C2A1() {
  zone = self;
  state = zone.state;

  if(zone.state != "off")
    state = state + zone._id_BCC2E271115B13F0.name;

  foreach(_id_0EAE85273686F4F4 in zone.chevrons) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0EAE85273686F4F4._id_B779CB958BC7769A; _id_AC0E594AC96AA3A8++) {
      _id_0EAE85273686F4F4 setscriptablepartstate("chevron_" + _id_AC0E594AC96AA3A8, state);

      if(zone.state == "occupied")
        _id_0EAE85273686F4F4 _meth_FCA5BDBE24070D20("chevron_" + _id_AC0E594AC96AA3A8, zone.owner);
    }
  }
}

_id_CEBE23E67CC65F6D() {
  zone = self;
  objidnum = zone.objidnum;
  zone.objective = scripts\mp\gameobjects::createobjidobject(zone.origin, "neutral", (0, 0, 0), objidnum, "any");
  objective_setshowdistance(objidnum, 1);
  objective_sethideelevation(objidnum, 1);
  objective_setshowoncompass(objidnum, 1);
  _func_1A20F52DE11BA2EF(objidnum, 1);

  if(istrue(level.brgametype._id_A814399CC303B418)) {
    _func_C047D7FFE7A83501(objidnum, level.brgametype._id_D993BF69B9541CBF, level.brgametype._id_EFBAAD993A315482);
    _func_F749EB3FBF7DFD39(objidnum, level.brgametype._id_36A5C1335A8FF080, level.brgametype._id_78C2D7D97F7E9215);
  }
}

_id_D230E52EA9D04F61() {
  zone = self;
  islocked = zone.state == "lock";
  _id_A5250821FB1BEA6A = zone.state == "contested";
  _id_6E12D19DE1A02FE2 = zone._id_783809DA65285CB1;
  _id_5D9D309CFC3403BF = scripts\engine\utility::ter_op(islocked, "icon_waypoint_base_frame_lock", "icon_waypoint_base_frame_idle");
  _id_EF385701DEBE70B0 = _id_5D9D309CFC3403BF + zone._id_BCC2E271115B13F0.name;
  zone.objective.cancontestclaim = !islocked;
  zone.objective.stalemate = _id_A5250821FB1BEA6A;

  switch (zone.state) {
    case "lock":
      zone.objective scripts\mp\gameobjects::setobjectivestatusicons("zc_waypoint_lock_" + _id_6E12D19DE1A02FE2);
      break;
    case "idle":
      zone.objective scripts\mp\gameobjects::setobjectivestatusicons("zc_waypoint_neutral_" + _id_6E12D19DE1A02FE2);
      break;
    case "contested":
      zone.objective scripts\mp\gameobjects::setobjectivestatusicons("zc_waypoint_contested_" + _id_6E12D19DE1A02FE2);
      break;
    case "occupied":
      zone.objective scripts\mp\gameobjects::setobjectivestatusicons("zc_waypoint_defending_" + _id_6E12D19DE1A02FE2, "zc_waypoint_losing_" + _id_6E12D19DE1A02FE2, zone.objidnum, zone.owner);
      break;
  }

  zone.objective.wasstalemate = zone.objective.stalemate;
  _func_38C981837AD9518B(zone.objidnum, _id_EF385701DEBE70B0);
}

_id_95E3204D0AA4581F() {
  zone = self;
  level endon("game_ended");
  zone endon("deactivate_zone");

  for(;;) {
    zone waittill("trigger", _id_B25B5C45202C880C);

    if(isPlayer(_id_B25B5C45202C880C)) {
      if(scripts\engine\utility::array_contains(zone.players, _id_B25B5C45202C880C)) {
        continue;
      }
      zone thread _id_0A32464C6DFFE6D1(_id_B25B5C45202C880C);
      continue;
    }

    if(_id_46DB667F66F9761E(_id_B25B5C45202C880C)) {
      if(scripts\engine\utility::array_contains(zone.vehicles, _id_B25B5C45202C880C)) {
        continue;
      }
      zone thread _id_AD2906AB4702C1E6(_id_B25B5C45202C880C);
    }
  }
}

_id_53B59FD7E847103B() {
  zone = self;
  _id_98A5425AD272810F = zone getboundshalfsize();
  _id_4A6ABC8D46FB3619 = sqrt(squared(_id_98A5425AD272810F[0]) + squared(_id_98A5425AD272810F[1]));
  _id_58CAB040FD809108 = getlootscriptablearrayinradius(undefined, undefined, zone.origin, _id_4A6ABC8D46FB3619);
  _id_15837BD28F442406 = [];

  if(isDefined(_id_58CAB040FD809108)) {
    foreach(_id_DB376EE90688810D in _id_58CAB040FD809108) {
      _id_BD3E849E7B352D21 = _id_DB376EE90688810D getscriptableisreserved() && isDefined(_id_DB376EE90688810D.brpickupscriptableid);

      if(_id_BD3E849E7B352D21 && _id_7E52B56769FA7774::_id_2AE5E94BD6518AB5(_id_DB376EE90688810D, 0))
        _id_15837BD28F442406 = scripts\engine\utility::array_add(_id_15837BD28F442406, _id_DB376EE90688810D);
    }
  }

  return _id_15837BD28F442406;
}

_id_A59C0799E29F229C(_id_7603FA242367C756, _id_7603F9242367C523) {
  return _id_7603FA242367C756.brpickupscriptableid < _id_7603F9242367C523.brpickupscriptableid;
}

_id_BE2486DD0DEF6253() {
  zone = self;
  level endon("game_ended");
  zone endon("deactivate_zone");

  for(;;) {
    _id_A679C918818FA808 = _id_53B59FD7E847103B();
    _id_A679C918818FA808 = scripts\engine\utility::array_sort_with_func(_id_A679C918818FA808, ::_id_A59C0799E29F229C);
    _id_A0A4105E0662EDE0 = max(_id_A679C918818FA808.size - level.brgametype._id_77134F0DDB570883, 0);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A0A4105E0662EDE0; _id_AC0E594AC96AA3A8++)
      _id_7E52B56769FA7774::loothide(_id_A679C918818FA808[_id_AC0E594AC96AA3A8]);

    wait 10;
  }
}

_id_0A32464C6DFFE6D1(player) {
  zone = self;
  level endon("game_ended");
  zone endon("deactivate_zone");
  player endon("death_or_disconnect");

  for(;;) {
    waitframe();

    if(ispointinvolume(player.origin + (0, 0, 10), zone)) {
      if(scripts\engine\utility::array_contains(zone.players, player)) {
        continue;
      }
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      zone _id_3261EE4BB897DFF4(player);
      continue;
    }

    if(scripts\engine\utility::array_contains(zone.players, player)) {
      zone _id_A105B78E4FE62E20(player);
      break;
    }
  }
}

_id_AD2906AB4702C1E6(vehicle) {
  zone = self;
  level endon("game_ended");
  zone endon("deactivate_zone");
  vehicle endon("death");

  for(;;) {
    waitframe();

    if(ispointinvolume(vehicle.origin + (0, 0, 10), zone)) {
      if(scripts\engine\utility::array_contains(zone.vehicles, vehicle)) {
        continue;
      }
      zone _id_B4D85F72946EAC2B(vehicle);
      continue;
    }

    if(scripts\engine\utility::array_contains(zone.vehicles, vehicle)) {
      zone _id_47E70A48EEAFA5F3(vehicle);
      break;
    }
  }
}

_id_6F0E0E33CDB00EF6() {
  zone = self;
  level endon("game_ended");
  zone endon("deactivate_zone");
  zone endon("last_state_reach");

  if(!istrue(level.brgametype._id_719C030C6596B6A5)) {
    return;
  }
  zone.score = zone._id_BCC2E271115B13F0.basescore;

  for(;;) {
    if(zone._id_BCC2E271115B13F0.name == "2") {
      zone notify("last_state_reach");
      break;
    }

    zone waittill("zone_score_updated");

    if(zone.score > zone._id_BCC2E271115B13F0._id_64A4D492B7ADD279) {
      zone _id_12F42921034BD85D(zone._id_BCC2E271115B13F0._id_51BB8BA0DD6CAB42);
      _id_F6F080447D2F7E50();
    }
  }
}

_id_C7641266E2FCBDE4() {
  zone = self;

  if(zone.players.size == 0) {
    return;
  }
  foreach(player in zone.players) {
    if(isDefined(player))
      scripts\mp\objidpoolmanager::objective_unpin_player(zone.objidnum, player, 0);
  }
}

_id_3E26FDCEED81D3A8(_id_DF1128C61DE0989D) {
  zone = self;
  zone.score = zone.score + _id_DF1128C61DE0989D;
  zone notify("zone_score_updated");
}

_id_DC8C285F0E287553(score) {
  zone = self;
  return score * zone._id_BCC2E271115B13F0._id_98EA5AFB293A76A2;
}

_id_4549DA620DBE742B() {
  if(!istrue(level.brgametype._id_FAF946460FCEE87B))
    return 0;

  zone = self;

  if(!isDefined(zone._id_F7EC6D992938B955) || !isDefined(zone._id_4EB63A0DC6CD6400))
    zone _id_5A69B488063C5B72();

  _id_B5159586171AFFA6 = 0;

  switch (zone.state) {
    case "occupied":
      if(zone.players.size >= 2) {
        _id_DF918FDC2ED39815 = zone.players[0].team;

        if(zone._id_F7EC6D992938B955 == _id_DF918FDC2ED39815) {
          zone._id_4EB63A0DC6CD6400--;

          if(zone._id_4EB63A0DC6CD6400 == 0) {
            _id_82ABF65B162F526F(_id_DF918FDC2ED39815, level.brgametype._id_416FEBDC38ED88BE, "squadBonus");
            _id_B5159586171AFFA6 = 1;
            zone _id_5A69B488063C5B72(_id_DF918FDC2ED39815);
          }
        } else
          zone _id_5A69B488063C5B72(_id_DF918FDC2ED39815);
      } else
        zone _id_5A69B488063C5B72();

      break;
    case "contested":
      if(zone._id_F7EC6D992938B955 != "") {
        _id_EBAEB4F62B1D5C42 = 0;

        foreach(player in zone.players) {
          if(player.team == zone._id_F7EC6D992938B955) {
            _id_EBAEB4F62B1D5C42 = 1;
            break;
          }
        }

        if(!istrue(_id_EBAEB4F62B1D5C42))
          zone _id_5A69B488063C5B72();
      }

      break;
    default:
      zone _id_5A69B488063C5B72();
      break;
  }

  return _id_B5159586171AFFA6;
}

_id_5A69B488063C5B72(_id_DF918FDC2ED39815) {
  zone = self;
  zone._id_4EB63A0DC6CD6400 = level.brgametype._id_A4153AE6BCB25FC3;
  zone._id_F7EC6D992938B955 = scripts\engine\utility::ter_op(isDefined(_id_DF918FDC2ED39815), _id_DF918FDC2ED39815, "");
}

_id_3261EE4BB897DFF4(player) {
  zone = self;
  zone.players = scripts\engine\utility::array_add(zone.players, player);
  player.zone = zone;
  player thread _id_46C6D8C759215E1C(zone);
  player thread _id_D30659DFFEAD9A7D(zone);
  zone thread _id_18BF6044FF24F869(player);
  scripts\mp\objidpoolmanager::objective_pin_player(zone.objidnum, player);

  if(zone.state == "contested")
    level thread _id_2CEDCC356F1B9FC8::brleaderdialog("attacking_zone", undefined, [player], 0, 0, undefined, "dx_br_bds4_");

  zone _id_F6F080447D2F7E50();
  _id_F151AE91A336C4F1(player.team);
}

_id_A105B78E4FE62E20(player) {
  zone = self;
  player notify("player_left_zone");
  player _id_005E5F912A3729EB(zone);
  scripts\mp\objidpoolmanager::objective_unpin_player(zone.objidnum, player, 1);
  zone.players = scripts\engine\utility::array_remove(zone.players, player);
  player.zone = undefined;
  zone _id_F6F080447D2F7E50();
  zone notify("player_left");
  _id_F151AE91A336C4F1(player.team);
}

_id_B4D85F72946EAC2B(vehicle) {
  zone = self;
  zone.vehicles = scripts\engine\utility::array_add(zone.vehicles, vehicle);

  foreach(player in vehicle.occupants) {
    if(!scripts\engine\utility::array_contains(zone.players, player))
      zone _id_3261EE4BB897DFF4(player);

    zone thread _id_B37580861362CC67(vehicle, player);
  }

  zone thread _id_A8244D901881CB3A(vehicle);
}

_id_47E70A48EEAFA5F3(vehicle) {
  zone = self;
  vehicle notify("vehicle_left_zone");

  foreach(player in vehicle.occupants) {
    if(scripts\engine\utility::array_contains(zone.players, player))
      zone _id_A105B78E4FE62E20(player);
  }

  zone.vehicles = scripts\engine\utility::array_remove(zone.vehicles, vehicle);
}

_id_18BF6044FF24F869(player) {
  zone = self;
  level endon("game_ended");
  player endon("player_left_zone");
  zone endon("deactivate_zone");
  player waittill("death_or_disconnect");

  if(isDefined(player)) {
    scripts\mp\objidpoolmanager::objective_unpin_player(zone.objidnum, player, 1);
    zone.players = scripts\engine\utility::array_remove(zone.players, player);
  } else
    zone.players = scripts\engine\utility::array_removeundefined(zone.players);

  zone _id_F6F080447D2F7E50();
}

_id_A8244D901881CB3A(vehicle) {
  zone = self;
  level endon("game_ended");
  vehicle endon("vehicle_left_zone");
  zone endon("deactivate_zone");
  vehicle scripts\engine\utility::waittill_any_two("death", "player_enter");

  if(isDefined(vehicle))
    zone.vehicles = scripts\engine\utility::array_remove(zone.vehicles, vehicle);
  else
    zone.vehicles = scripts\engine\utility::array_removeundefined(zone.vehicles);
}

_id_B37580861362CC67(vehicle, player) {
  zone = self;
  level endon("game_ended");
  vehicle endon("vehicle_left_zone");
  zone endon("deactivate_zone");
  scripts\engine\utility::waittill_any_ents(vehicle, "death", player, "vehicle_exit", player, "death_or_disconnect");

  if(scripts\engine\utility::array_contains(zone.players, player))
    zone _id_A105B78E4FE62E20(player);
  else
    zone.players = scripts\engine\utility::array_removeundefined(zone.players);
}

_id_9AAED3AB745B2A1A(vehicle, player) {
  if(isDefined(vehicle))
    vehicle notify("player_enter");
}

_id_928E26A37FF97761(player) {
  zone = self;
  _id_A9DE32A7B66E5872 = istrue(zone.isactive) && !scripts\engine\utility::array_contains(zone._id_82A3887C0F3B738A, player);
  return _id_A9DE32A7B66E5872;
}

_id_A627C95C694D7093(player) {
  zone = self;
  _id_A9DE32A7B66E5872 = istrue(zone.isactive) && !scripts\engine\utility::array_contains(zone._id_383B3DE50746912A, player);
  return _id_A9DE32A7B66E5872;
}

_id_A06DBCCC97E32939(player) {
  zone = self;
  player endon("disconnect");
  level endon("game_ended");
  zone._id_82A3887C0F3B738A = scripts\engine\utility::array_add(zone._id_82A3887C0F3B738A, player);
  wait 0.3;
  zone._id_82A3887C0F3B738A = scripts\engine\utility::array_remove(zone._id_82A3887C0F3B738A, player);
}

_id_D1736A0C0C0B2E0B(player) {
  zone = self;
  player endon("disconnect");
  level endon("game_ended");
  zone._id_383B3DE50746912A = scripts\engine\utility::array_add(zone._id_383B3DE50746912A, player);
  wait 0.3;
  zone._id_383B3DE50746912A = scripts\engine\utility::array_remove(zone._id_383B3DE50746912A, player);
}

_id_0E6B67D05F77313F() {
  player = self;
  player endon("disconnect");
  player waittill("spawned_player");
  wait 1;

  if(!istrue(level.br_infils_disabled))
    player waittill("joining_Infil");
  else
    scripts\mp\flags::gameflagwait("prematch_done");

  wait 1;
  player scripts\mp\hud_message::showsplash("zc_mode_intro", undefined, undefined, undefined, undefined, "splash_list_iw9_br_zonecontrol");
  _id_715028F54BAD19A1::branalytics_landing(player);
}

_id_60AFA719948A5DE2(points, zone, _id_7A58FC3A248245B0) {
  player = self;
  _id_B2222A047729C009 = isDefined(zone) && (zone.state == "occupied" || istrue(_id_7A58FC3A248245B0));

  if(!istrue(_id_B2222A047729C009))
    return 0;

  if(!istrue(_id_7A58FC3A248245B0))
    points = points * player._id_53E3AF3B2C8752BD;

  player._id_393B1E905723327D = player._id_393B1E905723327D + points;
  player.pers["matchPoints"] = player._id_393B1E905723327D;
  player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("matchPoints", player._id_393B1E905723327D);

  if(isDefined(zone) && player._id_0F4D5A85FEDC6267 == 0) {
    player _id_92AC85A6BF2D40CE(zone);
    player thread _id_9C429A69B568B5F1(zone);
  }

  player thread _id_73581DB4CA9F8BFA(zone);
  player._id_0F4D5A85FEDC6267 = player._id_0F4D5A85FEDC6267 + points;
  player _id_F2278C0D03136386(player._id_0F4D5A85FEDC6267);

  if(player._id_0F4D5A85FEDC6267 >= 10 && !istrue(player._id_AA3BEF3360032A04) && isDefined(zone))
    player thread _id_7686D4004BE7259C();

  if(player._id_0F4D5A85FEDC6267 > player._id_662A7FF003A3442F) {
    player._id_662A7FF003A3442F = player._id_0F4D5A85FEDC6267;
    player.pers["longestScoreStreak"] = player._id_0F4D5A85FEDC6267;
    player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("longestScoreStreak", int(min(player._id_662A7FF003A3442F, 1023)));
  }

  return points;
}

_id_46C6D8C759215E1C(zone) {
  player = self;
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("player_left_zone");
  zone endon("deactivate_zone");

  if(!istrue(zone.isactive))
    zone waittill("zone_activated");

  for(;;) {
    player waittill("got_a_kill", victim);

    if(zone.state != "occupied") {
      continue;
    }
    if(ispointinvolume(player.origin + (0, 0, 10), zone)) {
      _id_6AB5606DA9634C9A = 0;

      if(isDefined(level.brgametype._id_3237373815779BF5) && victim.team == level.brgametype._id_3237373815779BF5) {
        player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_AA8DE88677F7703E");

        if(istrue(level.brgametype._id_EF80665D53789D98)) {
          _id_6AB5606DA9634C9A = level.brgametype._id_BBCE590C8E68F35B;
          player thread _id_A18EEB8060957A40();

          if(istrue(level.brgametype._id_FA48BEA82741B77A))
            _id_6AB5606DA9634C9A = _id_6AB5606DA9634C9A * level.brgametype._id_16118949D71FBB2F;
        }
      } else if(istrue(level.brgametype._id_A44DF2A0823C0ACE)) {
        player _id_38643BC5200D7146(zone);
        _id_6AB5606DA9634C9A = zone _id_DC8C285F0E287553(level.brgametype._id_6F677AE3468374BD);
      }

      if(_id_6AB5606DA9634C9A == 0) {
        continue;
      }
      _id_6AB5606DA9634C9A = player _id_60AFA719948A5DE2(_id_6AB5606DA9634C9A, zone);
      _id_A5125E3BB9AA0B2A(player.team, _id_6AB5606DA9634C9A);
      _id_10724EF5718C0736(player.team);
      zone _id_3E26FDCEED81D3A8(_id_6AB5606DA9634C9A);
      _id_17DAFC2A055018CD();
      _id_0E861B56F866E4A9();
      continue;
    }

    zone _id_A105B78E4FE62E20(player);
    break;
  }
}

_id_10E521B3E1ABC656(zone) {
  player = self;

  switch (zone.state) {
    case "lock":
      player scripts\mp\objidpoolmanager::_id_160F522B63C32D76(1, &"MP_INGAME_ONLY/OBJ_ZC_LOCKED_CAPS", 0);
      break;
    case "contested":
      player scripts\mp\objidpoolmanager::_id_160F522B63C32D76(1, &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 0);
      break;
    case "idle":
      player scripts\mp\objidpoolmanager::_id_160F522B63C32D76(1, &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", 0);
      break;
    case "occupied":
      if(isDefined(zone.owner) && player.team == zone.owner)
        player scripts\mp\objidpoolmanager::_id_160F522B63C32D76(1, &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0);
      else
        player scripts\mp\objidpoolmanager::_id_160F522B63C32D76(1, &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", 0);

      break;
    default:
      break;
  }
}

_id_005E5F912A3729EB(zone) {
  player = self;

  if(zone _id_A627C95C694D7093(player)) {
    player playlocalsound("uin_iw9_lockdown_zone_exit");
    zone thread _id_D1736A0C0C0B2E0B(player);
  }
}

_id_D30659DFFEAD9A7D(zone) {
  player = self;
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("player_left_zone");

  if(!istrue(zone.isactive))
    zone waittill("zone_activated");

  if(ispointinvolume(player.origin + (0, 0, 10), zone)) {
    if(zone _id_928E26A37FF97761(player)) {
      _id_943E7B35D7D5A26E = zone._id_BCC2E271115B13F0.name == "2";
      _id_761A6A24F41D95C8 = scripts\engine\utility::ter_op(_id_943E7B35D7D5A26E, "uin_iw9_lockdown_zone_enter_special", "uin_iw9_lockdown_zone_enter");
      player playlocalsound(_id_761A6A24F41D95C8);
      zone thread _id_A06DBCCC97E32939(player);
    }

    player thread _id_8D62C12B7583FA6A(zone);
  }
}

_id_8D62C12B7583FA6A(zone) {
  player = self;
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("player_left_zone");
  zone waittill("deactivate_zone");
  player playlocalsound("uin_iw9_lockdown_zone_exit");
}

_id_7686D4004BE7259C() {
  player = self;
  level endon("game_ended");
  player endon("death_or_disconnect");

  if(level._id_2D54101DE4B3F30E < 25) {
    return;
  }
  if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
    _id_9BE07D4DA97C507B = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("zc_zone_streak_main_classic");
    player setplayermusicstate(_id_9BE07D4DA97C507B);
  } else {
    _id_E9602E7CD3B7A190 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("zc_zone_streak_main");
    player setplayermusicstate(_id_E9602E7CD3B7A190);
  }

  player._id_AA3BEF3360032A04 = 1;
}

_id_154E26C852E765F5() {
  player = self;
  player setplayermusicstate("");
  player._id_AA3BEF3360032A04 = 0;
}

_id_92AC85A6BF2D40CE(zone) {
  player = self;

  if(isDefined(player._id_D62A69764568DB0E) && player._id_D62A69764568DB0E == 0) {
    return;
  }
  player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_0C96052F73CDD535");
  player thread _id_7D8B3761CAD2AA7A(zone);
}

_id_7D8B3761CAD2AA7A(zone) {
  player = self;
  player endon("disconnect");
  level endon("game_ended");
  player._id_D62A69764568DB0E = 0;
  scripts\engine\utility::waittill_any_ents(player, "death", player, "player_left_zone", zone, "deactivate_zone");
  wait(level.brgametype._id_9B3E632A26358302);
  player._id_D62A69764568DB0E = 1;
}

_id_38643BC5200D7146(zone) {
  player = self;
  _id_F0FA3B7B27926553 = _func_2EF675C13CA1C4AF("stat_47A10FC2DCD83760", zone._id_BCC2E271115B13F0.name);
  player scripts\mp\utility\points::_id_0366980B6A8796AE(_id_F0FA3B7B27926553);
}

_id_9C429A69B568B5F1(zone) {
  player = self;
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("player_left_zone");
  zone endon("deactivate_zone");

  for(;;) {
    wait(level.brgametype._id_13D640CEE5DF4AC3);

    if(zone.state == "occupied") {
      _id_F0FA3B7B27926553 = _func_2EF675C13CA1C4AF("stat_C53D998F9895672B", zone._id_BCC2E271115B13F0.name);
      player scripts\mp\utility\points::_id_0366980B6A8796AE(_id_F0FA3B7B27926553);
      continue;
    }

    zone waittill("state_changed");
  }
}

_id_3AE9C7708BF1DEF0(zone) {
  player = self;

  if(!istrue(level.brgametype._id_FAF946460FCEE87B)) {
    return;
  }
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(player.team, "players");
  _id_D12A341B40354143 = 0;

  foreach(_id_736D8D9188CCBD45 in _id_A6AB8D0FDA441DC2) {
    if(isDefined(_id_736D8D9188CCBD45) && scripts\engine\utility::array_contains(zone.players, _id_736D8D9188CCBD45))
      _id_D12A341B40354143++;
  }

  if(_id_D12A341B40354143 < 2) {
    return;
  }
  player _id_105610BCC7BFE379();
  _id_F0FA3B7B27926553 = _func_2EF675C13CA1C4AF("stat_8E73D19416D829D9", _id_D12A341B40354143);
  player scripts\mp\utility\points::_id_0366980B6A8796AE(_id_F0FA3B7B27926553);
}

_id_4CD419222E96102D(player) {
  if(istrue(player._id_5393B7EE3366D551)) {
    return;
  }
  player._id_5393B7EE3366D551 = 1;
  player.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  scripts\mp\objidpoolmanager::objective_add(player.objidnum, "active", player.origin, "ui_mp_br_mapmenu_icon_assassin_objective_enemy");
  scripts\mp\objidpoolmanager::update_objective_setbackground(player.objidnum, 1);
  scripts\mp\objidpoolmanager::objective_mask_showtoenemyteam(player.objidnum, player);
  _func_D76CC64B205084A3(player.objidnum, 1);
  player thread _id_20CCC09DD75230AD();
  player thread _id_87903377A0C54746();
  _id_67572A1BE4AEE419 = player scripts\cp_mp\utility\player_utility::isinvehicle();

  if(!istrue(level.brgametype._id_10182C9DCAF0D685) && !istrue(_id_67572A1BE4AEE419))
    player _id_1E4A61DB11011446::_id_8D739EC62C568C41("prop_zc_game_flag");

  player thread _id_E1A5576F165B30AE(_id_67572A1BE4AEE419);
}

_id_20CCC09DD75230AD() {
  player = self;
  level endon("game_ended");
  level endon("new_leaders");
  player endon("death_or_disconnect");

  for(;;) {
    wait(level.brgametype._id_E75711D488AAD5C9);

    if(isDefined(player.objidnum))
      scripts\mp\objidpoolmanager::update_objective_position(player.objidnum, player.origin + (0, 0, 80));
  }
}

_id_87903377A0C54746() {
  player = self;
  level endon("game_ended");
  level endon("new_leaders");
  _id_82794B442EA4ABCE = player.objidnum;
  scripts\engine\utility::waittill_any_ents(player, "death_or_disconnect");
  level _id_7754E43584E5A8EA(player, _id_82794B442EA4ABCE, 1);
}

_id_E1A5576F165B30AE(_id_67572A1BE4AEE419) {
  player = self;
  level endon("game_ended");
  level endon("new_leaders");
  player endon("death_or_disconnect");

  for(;;) {
    if(!istrue(_id_67572A1BE4AEE419)) {
      player waittill("vehicle_enter");
      player _id_1E4A61DB11011446::_id_96D6B5E51DD4A63B();
    }

    player waittill("vehicle_exit");
    _id_67572A1BE4AEE419 = 0;

    if(!istrue(level.brgametype._id_10182C9DCAF0D685))
      player _id_1E4A61DB11011446::_id_8D739EC62C568C41("prop_zc_game_flag");
  }
}

_id_7754E43584E5A8EA(player, _id_82794B442EA4ABCE, _id_5AF933B7B2B07F42) {
  _id_11A6666371459FA7 = !isDefined(player);

  if(_id_11A6666371459FA7)
    scripts\mp\objidpoolmanager::returnobjectiveid(_id_82794B442EA4ABCE);
  else if(istrue(player._id_5393B7EE3366D551)) {
    player._id_5393B7EE3366D551 = undefined;
    scripts\mp\objidpoolmanager::returnobjectiveid(_id_82794B442EA4ABCE);
    player.objidnum = undefined;
    player _id_1E4A61DB11011446::_id_96D6B5E51DD4A63B();

    if(!istrue(_id_5AF933B7B2B07F42)) {
      player scripts\mp\hud_message::showsplash("zc_lead_lost", undefined, undefined, undefined, undefined, "splash_list_iw9_br_zonecontrol");
      level thread _id_2CEDCC356F1B9FC8::brleaderdialog("lead_lost", undefined, [player], 1, 0, undefined, "dx_br_bds4_");
    }
  }
}

_id_73581DB4CA9F8BFA(zone) {
  player = self;
  player notify("beginScorestreak");
  level endon("game_ended");
  player endon("disconnect");
  player endon("beginScorestreak");
  isinzone = 1;

  while(isinzone) {
    scripts\engine\utility::waittill_any_ents(player, "death", player, "player_left_zone", zone, "deactivate_zone");

    if(isalive(player) && !isDefined(player.zone))
      wait(level.brgametype._id_A5FC9E22F4382909);

    if(isalive(player) && isDefined(player.zone) && (player.zone.state == "occupied" || player.zone.state == "contested")) {
      zone = player.zone;
      continue;
    }

    isinzone = 0;
  }

  player _id_F61BE6566453B5A4();
}

_id_B96F59F29D1C4398() {
  player = self;
  player thread _id_C31D411C03F9923B();
  score = _id_A97D64DD14F6D878(player.team);

  if(!isDefined(level.brgametype._id_3237373815779BF5)) {
    return;
  }
  _id_C12CC113066DD7FA = scripts\mp\utility\teams::getteamdata(level.brgametype._id_3237373815779BF5, "players");

  if(scripts\engine\utility::array_contains(_id_C12CC113066DD7FA, player))
    player thread _id_CF348FB9247C7213();
}

_id_C31D411C03F9923B() {
  player = self;
  _id_72519CD6EC9CC2E2 = !isDefined(level.brgametype._id_AC1C493ADFB1430E) || level.brgametype._id_AC1C493ADFB1430E.size == 0 || !istrue(level.brgametype._id_AC1C493ADFB1430E[0].isactive);

  if(!istrue(level.brgametype._id_8EA33E944D74F0CF) || istrue(_id_72519CD6EC9CC2E2) || istrue(player._id_23B725DC2DCC0ECA)) {
    return;
  }
  player notify("tryPlayObjectiveDialog");
  level endon("game_ended");
  level endon("deactivate_active_zone");
  player endon("death_or_disconnect");
  player endon("beginScorestreak");
  player endon("tryPlayObjectiveDialog");
  wait(level.brgametype._id_F983A9D28A83A074);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialog("play_objective", undefined, [player], 0, 0, undefined, "dx_br_bds4_");
  player._id_23B725DC2DCC0ECA = 1;
}

_id_CF348FB9247C7213() {
  player = self;
  level endon("game_ended");
  player endon("death_or_disconnect");

  if(!isDefined(level.brgametype._id_3237373815779BF5)) {
    return;
  }
  while(!player isonground())
    waitframe();

  _id_C12CC113066DD7FA = scripts\mp\utility\teams::getteamdata(level.brgametype._id_3237373815779BF5, "players");

  if(scripts\engine\utility::array_contains(_id_C12CC113066DD7FA, player))
    level _id_4CD419222E96102D(player);
}

_id_F61BE6566453B5A4() {
  player = self;
  player._id_0F4D5A85FEDC6267 = 0;
  player _id_F2278C0D03136386(player._id_0F4D5A85FEDC6267);
  player _id_154E26C852E765F5();
}

_id_F2278C0D03136386(_id_0F4D5A85FEDC6267) {
  player = self;
  player scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_zonecontrol_client_data2", 6, 13, _id_0F4D5A85FEDC6267);
}

_id_4BBCB0B68D6681B6(_id_00AE17C5A8B1BC1B) {
  player = self;
  player scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_zonecontrol_client_data2", 0, 6, _id_00AE17C5A8B1BC1B);
}

_id_A18EEB8060957A40() {
  player = self;
  player scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_zonecontrol_client_data2", 20, 1, 1);
  waitframe();
  player scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_zonecontrol_client_data2", 20, 1, 0);
}

_id_9B46D53ABE69E2BF(active) {
  player = self;
  player scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_zonecontrol_client_data2", 21, 1, active);
}

_id_E4BF8B6F5854C6CA(_id_FE29C8D83F80FF32) {
  player = self;
  player scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_zonecontrol_client_data2", 23, 3, _id_FE29C8D83F80FF32);
}

_id_105610BCC7BFE379() {
  player = self;
  player scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_zonecontrol_client_data2", 22, 1, 1);
  waitframe();
  player scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_zonecontrol_client_data2", 22, 1, 0);
}

_id_A8722F6B1D8B1BCD(isactive) {
  player = self;
  player scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_zonecontrol_client_data2", 19, 1, isactive);
}

_id_DAE80BBAA1D7B643(score) {
  player = self;
  player scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_zonecontrol_client_data", 0, 13, score);
}

_id_943449AC36405826(playerteam) {
  player = self;
  _id_B2FA932257032883 = 0;

  foreach(team, _id_6EEF49FDE768C24F in level.brgametype._id_6EEF49FDE768C24F) {
    if(playerteam == team) {
      continue;
    }
    if(_id_6EEF49FDE768C24F > _id_B2FA932257032883)
      _id_B2FA932257032883 = _id_6EEF49FDE768C24F;
  }

  player scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_zonecontrol_client_data", 13, 13, _id_B2FA932257032883);
}

_id_5C969A7697E1A7CD(_id_447913206D1F7916, timeuntilspawn, _id_F9A785628F97EEC6) {
  spawnorigin = _id_2695A20D4011076D::getrandompointinboundssafecircle();

  if(isDefined(spawnorigin))
    spawnorigin = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(spawnorigin);

  return spawnorigin;
}

_id_9017FFCFBFB5D51C() {
  _id_9DE5C42A0EDB36F4 = [];
  _id_B0CF0545C2FDF0E0 = [];
  _id_D00BF195E2AB16CF = getdvarint("dvar_B0E54987B343400D", 3500);

  foreach(_id_3402D60C1EF6B931 in level.brgametype._id_58B474CB0E57096A) {
    _id_9DE5C42A0EDB36F4[_id_9DE5C42A0EDB36F4.size] = level.brgametype.clusters[_id_3402D60C1EF6B931].origin;
    _id_B0CF0545C2FDF0E0[_id_B0CF0545C2FDF0E0.size] = _id_2B12C267B4A765F1(_id_3402D60C1EF6B931) + _id_D00BF195E2AB16CF;
  }

  level.brgametype._id_9DE5C42A0EDB36F4 = _id_9DE5C42A0EDB36F4;
  level.brgametype._id_B0CF0545C2FDF0E0 = _id_B0CF0545C2FDF0E0;
}

_id_2B12C267B4A765F1(_id_DED994656B8D402A) {
  _id_1C683105D19D60A3 = level.brgametype.clusters[_id_DED994656B8D402A].origin;
  _id_B2D6A56CC8091C98 = level.brgametype.clusters[_id_DED994656B8D402A].zones;
  circleradius = 0;

  foreach(zone in _id_B2D6A56CC8091C98) {
    _id_6580DE42EF106BAF = distance2d(_id_1C683105D19D60A3, zone.origin);

    if(circleradius < _id_6580DE42EF106BAF)
      circleradius = _id_6580DE42EF106BAF;
  }

  return circleradius;
}

_id_94E64FE4713EFF4B() {
  _id_C661E5B77C016382 = getdvarint("dvar_FEB7DC22D6BEFAB3", 10);
  _id_D5BB10777AF0FDB1 = _id_21CCCABF14B4DBE6::_id_552D5DEDB157D313(level.brgametype._id_B4A42A0051F3FED8 + level.brgametype._id_B458560354506894, level.brgametype._id_9FDB99442028FCA4, _id_C661E5B77C016382, level.brgametype._id_ADAFBAF3C7E24AD3, level.brgametype._id_9DE5C42A0EDB36F4, level.brgametype._id_B0CF0545C2FDF0E0);
  return _id_D5BB10777AF0FDB1;
}

_id_ED8612F4C8E6BB7E(_id_501501DCD163BA3E, _id_C68ED0FFA54D516B, _id_03F29BC8B1C6FC48) {
  foreach(team in level.teamnamelist) {
    if(team == _id_501501DCD163BA3E) {
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam(_id_C68ED0FFA54D516B, team, undefined, undefined, undefined, 1);
      continue;
    }

    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam(_id_03F29BC8B1C6FC48, team, undefined, undefined, undefined, 1);
  }
}

_id_5BA95C324DF19C13() {
  level endon("game_ended");
}

_id_1524C00DE48C44F3(time, _id_4E378291CBEA730E) {
  level endon("game_ended");
  level endon("overtime");
  _id_AD07CB0C4E8D2C6C = scripts\engine\utility::ter_op(time >= 15 && _id_4E378291CBEA730E == 0, 1, 0);

  if(istrue(_id_AD07CB0C4E8D2C6C)) {
    wait(time - 15);
    _id_E4F897FD579BA3C7 = scripts\engine\utility::ter_op(istrue(level.brgametype._id_2A33F7CB739A32F1 == level.brgametype._id_6BF149B60DA04F9B - 1), "uin_iw9_lockdown_final_round_end_time_15sec", "uin_iw9_lockdown_round_end_time_15sec");
    _id_23A142E89743326D(_id_E4F897FD579BA3C7);
  } else {
    _id_E4A56D4EF907A94E = scripts\engine\utility::ter_op(time >= 15 && _id_4E378291CBEA730E == 2, 1, 0);

    if(istrue(_id_E4A56D4EF907A94E)) {
      wait(time - 20);
      _id_23A142E89743326D("uin_iw9_lockdown_overtime_timer_20sec");
    }
  }
}

_id_23A142E89743326D(sfx) {
  foreach(player in level.players) {
    if(!isDefined(player) || !scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    player playlocalsound(sfx);
  }
}

_id_388937DA6A4B9E5B(sfx, _id_3C6BB864DCC6CDA7) {
  playsoundatpos(level.brgametype.clusters[_id_3C6BB864DCC6CDA7].origin, sfx);
}

_id_5FD5D5232392F8E3() {
  level.brgametype._id_6D00C3E0BD12EAF8 = [];

  foreach(_id_FABF84450735DD93 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamcount(_id_FABF84450735DD93) == 0) {
      continue;
    }
    level.brgametype._id_6D00C3E0BD12EAF8[_id_FABF84450735DD93] = [];
    level.brgametype._id_6D00C3E0BD12EAF8[_id_FABF84450735DD93]["takeover"] = 0;
    level.brgametype._id_6D00C3E0BD12EAF8[_id_FABF84450735DD93]["squadBonus"] = 0;
    level.brgametype._id_6D00C3E0BD12EAF8[_id_FABF84450735DD93]["normalZone"] = 0;
    level.brgametype._id_6D00C3E0BD12EAF8[_id_FABF84450735DD93]["highValueZone"] = 0;
  }

  thread _id_E72095332B0D736B();
}

_id_82ABF65B162F526F(_id_FABF84450735DD93, value, source) {
  level.brgametype._id_6D00C3E0BD12EAF8[_id_FABF84450735DD93][source] = level.brgametype._id_6D00C3E0BD12EAF8[_id_FABF84450735DD93][source] + value;
}

_id_E72095332B0D736B() {
  level waittill("game_ended");

  foreach(_id_FABF84450735DD93, _id_B339E6FF7BC878A5 in level.brgametype._id_6D00C3E0BD12EAF8) {
    _id_EC6A81EAC0E4DC61 = [];
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "team";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_FABF84450735DD93;
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "takeover_points";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_B339E6FF7BC878A5["takeover"];
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "squad_bonus_points";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_B339E6FF7BC878A5["squadBonus"];
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "normal_zone_points";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_B339E6FF7BC878A5["normalZone"];
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "high_value_zone_points";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_B339E6FF7BC878A5["highValueZone"];
    dlog_recordevent("dlog_event_zc_match_points_stats", _id_EC6A81EAC0E4DC61);
  }
}

_id_D0E600DEB7949696(_id_DACB0AF906C45CA5, _id_4FCA91C462F41CE6) {
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "round_index";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DACB0AF906C45CA5;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "score_diff";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = int(_id_4FCA91C462F41CE6);
  dlog_recordevent("dlog_event_zc_match_end", _id_EC6A81EAC0E4DC61);
}

_id_63BF192D1FD856E5(_id_DACB0AF906C45CA5) {
  totalscore = 0;

  foreach(zone in level.brgametype._id_AC1C493ADFB1430E) {
    if(isDefined(zone.score))
      totalscore = totalscore + zone.score;
  }

  totalscore = totalscore / level.brgametype._id_AC1C493ADFB1430E.size;
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "round_index";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DACB0AF906C45CA5;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "average_points_given";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = int(totalscore);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "is_overtime";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = istrue(level.brgametype._id_FA48BEA82741B77A);
  dlog_recordevent("dlog_event_zc_round_end", _id_EC6A81EAC0E4DC61);
}