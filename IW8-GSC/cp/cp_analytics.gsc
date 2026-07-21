/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_analytics.gsc
***********************************************/

initlevelvars() {
  start_game_type("_encstr_BD4D18EA21990EED389FABA06788B62BB6186222CBE7D267B071", "_encstr_833C21DF3FBB8DE1D0262D28C7FBDABD798CB4EA80CC1381130EE0602FA87175ECCDF1", "_encstr_8254148D83BC8D83D78573B0632F474B1B9B7136B9EC");
  level.transactionid = 0;
  level.analyticsendgame = ::zombieendgameanalytics;
  level.revive_success_analytics_func = ::revive_success_analytics_func;
}

init_weapon_and_player_analytics(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(!isDefined(var_0.pers))
    wait 1;

  var_0.timewithitem = [];
  var_0.killswithitem = [];
  var_0.itemtype = "_encstr_974C0246";
  var_0.timeitemlasted = [];

  if(!isDefined(level.brutefirstspawn))
    level.brutefirstspawn = 0;

  if(level.wave_num == 0) {
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"] = spawnStruct();
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave = [];
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1] = [];
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_823314C47BBB6396DC9DFA99DE9CD783B1B0E6ACE8CD"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_B6AC1E98EDBBD84BE6B37D99DB93D71C63C273B21DDCBE58CCA3B227B1B4992B"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_8817081FE8B9EBDB6B9E"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_AD490EC60BBAEC1A96CDCEB1B1DBDDE6"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_975A188AE36307793F982920C138CFB641902AC46FAD3880F20F"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_84D110918693B855AB7B3BD9BBE1AC20551F"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_AB6A1A5E365BBFC914D35828F367C1E3C25F58574F837BD3E4D76868"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_8A0411D26850377509116F67F958F1AF8FE00A"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_8BCA1B3B71B80B2D31E5F83F236171B71F35FD2F1619FB071E7298DFD5"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_AA700AD767908926962F8BDD"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_BE5F116E381575631CC5D2B76F28F962C5C373"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_A18A1BE6867BDB1DA5CD9DEBB30B363659E42FBE58CCE82B27C696332B"] = 0;
  }

  if(!isDefined(var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"])) {
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"] = spawnStruct();
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave = [];
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num] = [];
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num]["_encstr_823314C47BBB6396DC9DFA99DE9CD783B1B0E6ACE8CD"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num]["_encstr_B6AC1E98EDBBD84BE6B37D99DB93D71C63C273B21DDCBE58CCA3B227B1B4992B"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num]["_encstr_8817081FE8B9EBDB6B9E"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num]["_encstr_AD490EC60BBAEC1A96CDCEB1B1DBDDE6"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num]["_encstr_975A188AE36307793F982920C138CFB641902AC46FAD3880F20F"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num]["_encstr_84D110918693B855AB7B3BD9BBE1AC20551F"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num]["_encstr_AB6A1A5E365BBFC914D35828F367C1E3C25F58574F837BD3E4D76868"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num]["_encstr_8A0411D26850377509116F67F958F1AF8FE00A"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num]["_encstr_8BCA1B3B71B80B2D31E5F83F236171B71F35FD2F1619FB071E7298DFD5"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num]["_encstr_AA700AD767908926962F8BDD"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num]["_encstr_BE5F116E381575631CC5D2B76F28F962C5C373"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num]["_encstr_A18A1BE6867BDB1DA5CD9DEBB30B363659E42FBE58CCE82B27C696332B"] = 0;
  } else if(!isDefined(var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1])) {
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_823314C47BBB6396DC9DFA99DE9CD783B1B0E6ACE8CD"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_B6AC1E98EDBBD84BE6B37D99DB93D71C63C273B21DDCBE58CCA3B227B1B4992B"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_8817081FE8B9EBDB6B9E"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_AD490EC60BBAEC1A96CDCEB1B1DBDDE6"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_975A188AE36307793F982920C138CFB641902AC46FAD3880F20F"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_84D110918693B855AB7B3BD9BBE1AC20551F"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_AB6A1A5E365BBFC914D35828F367C1E3C25F58574F837BD3E4D76868"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_8A0411D26850377509116F67F958F1AF8FE00A"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_8BCA1B3B71B80B2D31E5F83F236171B71F35FD2F1619FB071E7298DFD5"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_AA700AD767908926962F8BDD"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_BE5F116E381575631CC5D2B76F28F962C5C373"] = 0;
    var_0.pers["_encstr_BDBC0D4796B556E605954ED52CCEB2"].timesperwave[level.wave_num + 1]["_encstr_A18A1BE6867BDB1DA5CD9DEBB30B363659E42FBE58CCE82B27C696332B"] = 0;
  }

  var_0.itemuses = [];
  var_0.itemkills = [];
  var_0.itemignored = "_encstr_974C0246";
  var_0.itemreplaced = "_encstr_974C0246";
  var_0.itempicked = "_encstr_974C0246";
  var_0.itemuses[var_0.itempicked] = 0;
  var_0.itemkills[var_0.itempicked] = 0;

  if(!isDefined(var_0.totalxpearned))
    var_0.totalxpearned = 0;

  if(!isDefined(var_0.score_earned))
    var_0.score_earned = 0;

  var_0.downsperweaponlog = [];
  var_0.killsperweaponlog = [];
  var_0.wavesheldwithweapon = [];
  var_0.shotsfiredwithweapon = [];
  var_0.shotsontargetwithweapon = [];
  var_0.headshots = [];
  var_0.total_match_headshots = 0;
  var_0.aggregateweaponkills = [];
  var_0.weapon_name_log = "_encstr_974C0246";
  var_0.accuracy_shots_fired = 0;
  var_0.accuracy_shots_on_target = 0;
  var_0.explosive_kills = 0;
  var_0.total_trap_kills = 0;

  if(!isDefined(var_0.exitingafterlifearcade))
    var_0.exitingafterlifearcade = 0;

  var_0.meleekill = 0;
  var_0.kung_fu_vo = 0;

  if(!isDefined(var_0.trapkills))
    var_0.trapkills = [];

  var_1 = ["_encstr_8B690BAD7A3FA391DFDA25C02B", "_encstr_88FB0CB37DCF60A789550FBAE84E", "_encstr_B1360FB1934A67990FF259B3DCE4081052", "_encstr_B801103B1EEB2B6FB930FBC7785309536933", "_encstr_A9E30CE3306382E7DB38EBEBC5E3", "_encstr_AAA00A1542B73B87E2434B20"];

  foreach(var_3 in var_1) {
    if(!isDefined(var_0.trapkills[var_3]))
      var_0.trapkills[var_3] = 0;
  }

  var_5 = var_0.getweaponslist;

  if(isDefined(var_5)) {
    foreach(var_7 in var_5) {
      var_0.weapon_name_log = scripts\cp\utility::getbaseweaponname(var_7);

      if(!isDefined(var_0.aggregateweaponkills[var_0.weapon_name_log]))
        var_0.aggregateweaponkills[var_0.weapon_name_log] = 0;
    }
  }
}

revive_success_analytics_func(var_0) {
  log_event("_encstr_B15517ADDF2BFBE03D478E41EDEF28A3F27B7F3153E2BB3042", 1, [var_0.clientid], [var_0.clientid], [var_0.clientid]);
}

zombieendgameanalytics() {
  var_0 = ["_encstr_8B690BAD7A3FA391DFDA25C02B", "_encstr_88FB0CB37DCF60A789550FBAE84E", "_encstr_B1360FB1934A67990FF259B3DCE4081052", "_encstr_B801103B1EEB2B6FB930FBC7785309536933", "_encstr_A9E30CE3306382E7DB38EBEBC5E3", "_encstr_AAA00A1542B73B87E2434B20"];

  foreach(var_3, var_2 in level.players) {
    log_weapons_data(var_3, var_2);
    log_headshots_data(var_3, var_2);
  }
}

log_headshots_data(var_0, var_1) {
  foreach(var_5, var_3 in var_1.headshots) {
    if(var_5 == "_encstr_8BBA05185F8B99" || var_5 == "_encstr_B40101" || var_3 == 0 || !scripts\engine\utility::array_contains(level.loadout_weapons, var_5)) {
      continue;
    }
    setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_0, "_encstr_96D30A3468575BA7C307A128", scripts\cp\utility::getbaseweaponname(var_5), var_3);
    var_4 = var_1 getplayerdata("_encstr_850703B7D9", "_encstr_96D30A3468575BA7C307A128", scripts\cp\utility::getbaseweaponname(var_5));
    var_1 setplayerdata("_encstr_850703B7D9", "_encstr_96D30A3468575BA7C307A128", scripts\cp\utility::getbaseweaponname(var_5), var_4 + var_3);
  }

  setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_0, "_encstr_8A7A1055B7E08F6051D0C07F72EADB05F3F3", var_1.total_match_headshots);
}

log_card_data(var_0, var_1) {
  if(!isDefined(var_1.consumables)) {
    return;
  }
  if(level.gametype != "_encstr_95240820B7C260898103") {
    return;
  }
  foreach(var_5, var_3 in var_1.consumables) {
    var_4 = var_1 getplayerdata("_encstr_850703B7D9", "_encstr_8A6E0BB1C227C8CDBEAE9B2B23", var_5);
    var_1 setplayerdata("_encstr_850703B7D9", "_encstr_8A6E0BB1C227C8CDBEAE9B2B23", var_5, var_4 + var_3.times_used);
  }
}

log_explosive_kills(var_0, var_1) {
  if(!isDefined(var_1.explosive_kills)) {
    return;
  }
  var_2 = var_1 getplayerdata("_encstr_850703B7D9", "_encstr_830D10ACF08363B7DC966756BEB55AD8C6B9");
  var_1 setplayerdata("_encstr_850703B7D9", "_encstr_830D10ACF08363B7DC966756BEB55AD8C6B9", var_2 + var_1.explosive_kills);
}

log_weapons_data(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = "_encstr_B40101";

  foreach(var_8, var_6 in var_1.aggregateweaponkills) {
    if(var_8 == "_encstr_8BBA05185F8B99" || var_8 == "_encstr_B40101" || var_6 == 0 || !scripts\engine\utility::array_contains(level.loadout_weapons, var_8)) {
      continue;
    }
    setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_0, "_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D", scripts\cp\utility::getbaseweaponname(var_8), var_6);
    var_7 = var_1 getplayerdata("_encstr_850703B7D9", "_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D", scripts\cp\utility::getbaseweaponname(var_8));
    var_1 setplayerdata("_encstr_850703B7D9", "_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D", scripts\cp\utility::getbaseweaponname(var_8), var_7 + var_6);

    if(var_1.aggregateweaponkills[var_8] > 0 && var_2 == 0) {
      var_3 = var_1.aggregateweaponkills[var_8];
      var_2 = 1;
      var_4 = scripts\cp\utility::getbaseweaponname(var_8);
    }

    if(var_1.aggregateweaponkills[var_8] > var_3) {
      var_3 = var_1.aggregateweaponkills[var_8];
      var_4 = scripts\cp\utility::getbaseweaponname(var_8);
    }
  }

  if(var_3 > 0) {
    setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_0, "_encstr_88A01022CA2C91362DACB9A3AB95161CEDB9", var_4);
    setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_0, "_encstr_9A0515A1D2DE418D37FD269DE72FE931050AA140DA35A7", var_3);
  }

  var_9 = var_1 getplayerdata("_encstr_850703B7D9", "_encstr_AB94146D69DE61B957D082F44F95B04080CDF0829B69");
  var_7 = var_1 getplayerdata("_encstr_850703B7D9", "_encstr_9A0515A1D2DE418D37FD269DE72FE931050AA140DA35A7", var_9);

  if(var_7 < var_3) {
    if(var_3 > 0) {
      var_10 = var_1 getplayerdata("_encstr_850703B7D9", "_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D", var_4);

      if(!isDefined(var_1.aggregateweaponkills[var_4]))
        var_1 setplayerdata("_encstr_850703B7D9", "_encstr_9A0515A1D2DE418D37FD269DE72FE931050AA140DA35A7", var_4, var_10);
      else
        var_1 setplayerdata("_encstr_850703B7D9", "_encstr_9A0515A1D2DE418D37FD269DE72FE931050AA140DA35A7", var_4, var_10);

      var_1 setplayerdata("_encstr_850703B7D9", "_encstr_AB94146D69DE61B957D082F44F95B04080CDF0829B69", var_4);
    }
  } else {
    var_11 = var_1 getplayerdata("_encstr_850703B7D9", "_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D", var_9);

    if(!isDefined(var_1.aggregateweaponkills[var_9]))
      var_1 setplayerdata("_encstr_850703B7D9", "_encstr_9A0515A1D2DE418D37FD269DE72FE931050AA140DA35A7", var_9, var_11);
    else
      var_1 setplayerdata("_encstr_850703B7D9", "_encstr_9A0515A1D2DE418D37FD269DE72FE931050AA140DA35A7", var_9, var_1.aggregateweaponkills[var_9] + var_11);

    var_1 setplayerdata("_encstr_850703B7D9", "_encstr_AB94146D69DE61B957D082F44F95B04080CDF0829B69", var_9);
  }
}

start_game_type(var_0, var_1, var_2) {
  init(var_2);
  init_matchdata(var_0, var_1);
}

init_matchdata(var_0, var_1) {
  setclientmatchdatadef(var_1);

  if(getdvarint("_encstr_A5B60A1F499D8F973153F986") != 0) {
    setmatchdatadef(var_0);
    setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_AB1904852B68", level.script);
    setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_A5F909EC0B5B2B8EF20ECA", getDvar("_encstr_ADE50BEB2F7C519F9918E82B68"));
    setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_B6320E9E25AFD1F98864BF5877AC703E", getbuildversion());
    setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_AAD30DC4EA5A8D32AF9BEA5B98CA9C", getbuildnumber());
    setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_8B18119FE8210F63B1EFFA73D8691AF509490F", getsystemtime());
    setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_AA3011D75B916950A86B6B93B12718092B636B", getdvarint("_encstr_93390B136AA2628AA8A93529D4"));
    setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_93D110CB6BC180BFB3B251791957676866D8", 1);
  }

  level thread wait_set_initial_player_count();
}

init(var_0) {
  var_1 = spawnStruct();
  var_2 = [];
  var_1.single_value_stats = var_2;
  var_3 = [];
  var_1.challenge_results = var_3;
  level.cp_matchdata = var_1;
  init_analytics(var_0);
  level.player_count = 0;
  level.player_count_left = 0;
}

wait_set_initial_player_count() {
  level endon("_encstr_841E0AB3B0AD598AB9465946");
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_92AE13AAA17A8089CE2F7F274855807143D0FE62E3", validate_byte(level.players.size));
}

on_player_connect() {
  player_init();
  set_player_count();
  set_split_screen();
  set_join_in_progress();
  level.player_count = level.player_count + 1;
  _id_119CD();
}

_id_119CD() {
  var_0 = isbot(self) || initmaxspeedforpathlengthtable(self) || isai(self);

  if(scripts\cp\utility::rankingenabled()) {
    var_1 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8CFD0EDD51312A070C8B9AE3B3534F65", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_B607032B8B");
    var_2 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8E8D0697EB01F243");
    var_3 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8E0607055DBFB3919A");
    var_4 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_A9F6058464DADF");
    var_5 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_956807294FC34ED073");
    var_6 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_88CC0521F3A13B");
    var_7 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8EDA07FF229707BB77");
    var_8 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_95B80C17DA7BF867C7ED6BC84D94");
    var_9 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_8893104796DA2B14B185E5B2198A7BE80B36");
    var_10 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_82FB06EB26785BD7");
    var_11 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8CFD0EDD51312A070C8B9AE3B3534F65", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_A1ED09400BA5D351227715");
  } else {
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;
    var_5 = 0;
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
    var_11 = 0;
  }

  var_12 = self updatelastcovertime();
  var_13[0] = "_encstr_B40101";
  var_13[1] = "_encstr_B40101";
  var_14[0] = -1;
  var_14[1] = -1;

  if(!isbot(self)) {
    if(level.teambased) {
      var_13[0] = scripts\cp\survival\survival_loadout::lookupcurrentoperator("_encstr_9A8507BA4040188D08");
      var_13[1] = scripts\cp\survival\survival_loadout::lookupcurrentoperator("_encstr_8E8405EA382B2A");
      var_14[0] = scripts\cp\survival\survival_loadout::lookupcurrentoperatorskin("_encstr_9A8507BA4040188D08");
      var_14[1] = scripts\cp\survival\survival_loadout::lookupcurrentoperatorskin("_encstr_8E8405EA382B2A");
    } else {
      var_13[0] = scripts\cp\survival\survival_loadout::lookupcurrentoperator("_encstr_9A8507BA4040188D08");
      var_14[0] = scripts\cp\survival\survival_loadout::lookupcurrentoperatorskin("_encstr_9A8507BA4040188D08");
    }
  }

  var_15 = 0;

  if(level.onlinegame)
    var_15 = self isfireteamleader();

  self.pers["_encstr_8390136DF11BC9AF90E0D26A2975277B385BF5FF57"] = getsystemtime();
  var_16 = _func_042D();
  self dlog_recordplayerevent("_encstr_916E21EC51F057EF2553F24A3B1047CA19116C71D318DA27D9A9DB82C048CF0330BD0C", ["_encstr_8390136DF11BC9AF90E0D26A2975277B385BF5FF57", self.pers["_encstr_8390136DF11BC9AF90E0D26A2975277B385BF5FF57"], "_encstr_BA060957A1E0EDA345BBEF", self.name, "_encstr_8AEF05472BC2D6", self.sessionteam, "_encstr_A50B0A35BD969BEB47F283AC", self getjointype(), "_encstr_AFC0076727109AD710", var_0, "_encstr_814106BF330C3079", self getskill(), "_encstr_97410978B74BD3A047B8AA", self getmissilevelocity(), "_encstr_AA530E629B81B84F10738B2993971351", var_15, "_encstr_8DC5056CF390E3", var_12[0], "_encstr_8CC5054B38D7C4", var_12[1], "_encstr_9AC5054B07BE8D", var_12[2], "_encstr_BAC5053CA291E9", var_12[3], "_encstr_B4E409701329CF0B199B39", self scriptablesetparententity(), "_encstr_ACB009AFBB96ABD858C363", var_1, "_encstr_B438189BE8B04E1D7DD14BAD59BEC11B58CB5623AFA3F6A3B01B", var_9, "_encstr_AB360F927593732CB6E0A3E7E00BF9EA63", var_11, "_encstr_A54D12D411BF9EAF271398E88A3A791077AD5E45", self startzeroarrival() != 1, "_encstr_91EC10ED8356930B8EBD4EFAC2C63696B2B9", var_13[0], "_encstr_87F30E601B47C509FB5F0E9029B3708F", var_13[1], "_encstr_B4FB1528DAAD587F93670557773A315845F2D6238419F0", var_14[0], "_encstr_97A413F63856930BD1F64EAFB0E14BE6AF37AD5A9B", var_14[1], "_encstr_87D40E83D81697C65ADC8EFAB9B0DAAC", var_16]);
}

_id_119CC(var_0) {
  var_1 = "_encstr_B40101";

  if(isDefined(var_0) && isstring(var_0))
    var_1 = var_0;
  else {
    switch (var_0) {
      case 1:
        var_1 = "_encstr_91190447C232";
        break;
      case 2:
        var_1 = "_encstr_BD79059C51C351";
        break;
      case 3:
        var_1 = "_encstr_BA19049B7723";
        break;
      case 4:
        var_1 = "_encstr_A2160B72184E2BF628D5747DE9";
        break;
      default:
        var_1 = "_encstr_BA19049B7723";
        break;
    }
  }

  if(level.teambased)
    var_2 = int(scripts\cp\drone\emp_drone::getteamrankxpmultiplier(self.team));
  else
    var_2 = 0;

  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;

  if(scripts\cp\utility::onlinestatsenabled() && !scripts\cp\utility::tryingtoleave()) {
    if(isDefined(self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"]))
      var_3 = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"];

    if(isDefined(self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_82FB06EB26785BD7"]))
      var_4 = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_82FB06EB26785BD7"];

    if(isDefined(self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_932E0A09FB023CC0DA8D7FFF"]))
      var_5 = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_932E0A09FB023CC0DA8D7FFF"];

    if(isDefined(self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_84A40620D6E488A3"]))
      var_6 = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_84A40620D6E488A3"];

    if(isDefined(self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_BDC706D9372AABE8"]))
      var_7 = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_BDC706D9372AABE8"];

    if(isDefined(self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC84B"]))
      var_8 = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC84B"];

    if(isDefined(self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B6A2056BD237D8"]))
      var_9 = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B6A2056BD237D8"];
  }

  if(scripts\cp\utility::tryingtoleave())
    var_10 = -1;
  else {
    var_11 = scripts\cp\drone\emp_drone::getrankxp();
    var_10 = scripts\cp\drone\emp_drone::getrankforxp(var_11);
  }

  if(scripts\cp\utility::rankingenabled() && self hasplayerdata()) {
    var_12 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8CFD0EDD51312A070C8B9AE3B3534F65", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_B607032B8B");
    var_13 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8E8D0697EB01F243");
    var_14 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8E0607055DBFB3919A");
    var_15 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_A9F6058464DADF");
    var_16 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_956807294FC34ED073");
    var_17 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_88CC0521F3A13B");
    var_18 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8EDA07FF229707BB77");
    var_19 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_95B80C17DA7BF867C7ED6BC84D94");
    var_20 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_8893104796DA2B14B185E5B2198A7BE80B36");
    var_21 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_82FB06EB26785BD7");
    var_22 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8CFD0EDD51312A070C8B9AE3B3534F65", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_A1ED09400BA5D351227715");
  } else {
    var_12 = 0;
    var_13 = 0;
    var_14 = 0;
    var_15 = 0;
    var_16 = 0;
    var_17 = 0;
    var_18 = 0;
    var_19 = 0;
    var_20 = 0;
    var_21 = 0;
    var_22 = 0;
  }

  var_23 = -1;
  var_24 = 0;
  var_25 = 0;

  if(isDefined(var_0)) {
    if(level.teambased) {
      if(isDefined(self.team)) {
        if(self.team == "_encstr_9A8507BA4040188D08") {
          var_24 = getteamscore("_encstr_9A8507BA4040188D08");
          var_25 = getteamscore("_encstr_8E8405EA382B2A");
        } else if(self.team == "_encstr_8E8405EA382B2A") {
          var_24 = getteamscore("_encstr_8E8405EA382B2A");
          var_25 = getteamscore("_encstr_9A8507BA4040188D08");
        }
      }
    }
  }

  var_26 = 0.0;
  var_27 = 0.0;

  if(isDefined(self.segments)) {
    if(isDefined(self.segments["_encstr_993F14DA70E55FB751C084BDE7594FA37BB962D37389"])) {
      if(self.segments["_encstr_993F14DA70E55FB751C084BDE7594FA37BB962D37389"] >= 30) {
        var_27 = self.segments["_encstr_A2900CD6BDECD237D9157B8E161B"] / (self.segments["_encstr_993F14DA70E55FB751C084BDE7594FA37BB962D37389"] / 5) * 100;
        var_26 = self.segments["_encstr_93060EB111AAD0DFD352F1DFBA938748"] / self.segments["_encstr_993F14DA70E55FB751C084BDE7594FA37BB962D37389"];
      }
    }
  }

  var_28 = 0;

  if(isDefined(self.pers["_encstr_8390136DF11BC9AF90E0D26A2975277B385BF5FF57"]))
    var_28 = self.pers["_encstr_8390136DF11BC9AF90E0D26A2975277B385BF5FF57"];

  var_29 = "_encstr_B40101";

  if(isDefined(level.completedobjectives) && isarray(level.completedobjectives) && level.completedobjectives.size > 0)
    var_29 = level.completedobjectives[level.completedobjectives.size - 1].objname;

  self dlog_recordplayerevent("_encstr_B4661F0AD010A7DFD9BCA34ABBFF47F8A83B50AE13F9AD67AB562BB77947CF8091", ["_encstr_8390136DF11BC9AF90E0D26A2975277B385BF5FF57", var_28, "_encstr_911316D58E6CF5C8A5CD8DBD9BCDAC363AD747966B56F5B9", getsystemtime(), "_encstr_821A1317353ADB895267D0887F95ED29425F03150A", int(scripts\cp\drone\emp_drone::getrankxpmultipliertotal()), "_encstr_BE18111DCA85D6FA3C07BEB67B32A5CC5A954E", var_2, "_encstr_95BB1377AC0BE0F6CD7D870EEBD6F6C896664BB24E", int(scripts\cp\cp_weaponrank::getweaponrankxpmultipliertotal()), "_encstr_8663174C2CD11DB1AC832CDCDCEBE10EEB6BBDC82D995AB24E", int(scripts\cp\drone\emp_drone::registerpublicevent()), "_encstr_AF250998CA2383C837286F", var_3, "_encstr_BA17096BDE6798BDE1FBC1", var_4, "_encstr_93FC0D1A68EB3D93B120776D50FA2B", var_5, "_encstr_A279099D7721FAB83E1823", var_6, "_encstr_BEDA097D95E13A5CDEF883", var_7, "_encstr_BE7609E690080D43C099A3", var_8, "_encstr_914C08B5B49B1BFAE1C1", var_9, "_encstr_A51F05CB11A052", var_10, "_encstr_938A079F08E09F3B8F", var_12, "_encstr_83CC1659E6327D47B4B5567D1C8D2CBCB246F5E87B8EC2D8", var_20, "_encstr_84AA0D8F68917F23CD9DEA23F39F0A", var_22, "_encstr_AC99122C6FF0283880FEE84FE3BFD61FC1D03DF2", var_1, "_encstr_8EBC1B169DAC2785762BAFB91CB25691F546AE272D379D7DB585A3C6A1", var_26, "_encstr_9563141CB24E6C95E68EF5A3B4B6CAF5DAB7EC969BD9", var_27, "_encstr_AA91112CB1E85AB3ACAFDE899A5936A35AD9CA", level.active_objectives_string, "_encstr_A3891970A673A0A83AAFC3C19B6205603CB198C90CCDA0F57223DB", var_29, "_encstr_9B7C07725D17A39473", var_1]);
}

initsegmentstats() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread recordplayersegmentdata();

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    createplayersegmentstats(var_0);
  }
}

recordplayersegmentdata() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp\utility::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  wait 4;

  for(;;) {
    wait 1;

    foreach(var_1 in level.players)
    var_1 thread updateplayersegmentdata();
  }
}

createplayersegmentstats(var_0) {
  var_0.segments = [];
  var_0.segments["_encstr_93060EB111AAD0DFD352F1DFBA938748"] = 0;
  var_0.segments["_encstr_A2900CD6BDECD237D9157B8E161B"] = 0;
  var_0.segments["_encstr_993F14DA70E55FB751C084BDE7594FA37BB962D37389"] = 0;
  var_0.savedsegmentposition = var_0.origin;
  var_0.positionptm = var_0.origin;
}

updateplayersegmentdata() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(self.savedsegmentposition)) {
    self.savedsegmentposition = self.origin;
    self.positionptm = self.origin;
  }

  if(scripts\cp\utility::isusingremote()) {
    self waittill("_encstr_A5D2156EE8DEE0C15646F5EACD96E6D9FA9359B5DED1CA");
    self.savedsegmentposition = self.origin;
    self.positionptm = self.origin;
    return;
  }

  self.segments["_encstr_993F14DA70E55FB751C084BDE7594FA37BB962D37389"]++;
  self.segments["_encstr_93060EB111AAD0DFD352F1DFBA938748"] = self.segments["_encstr_93060EB111AAD0DFD352F1DFBA938748"] + distance2d(self.savedsegmentposition, self.origin);
  self.savedsegmentposition = self.origin;

  if(self.segments["_encstr_993F14DA70E55FB751C084BDE7594FA37BB962D37389"] % 5 == 0) {
    var_0 = distance2d(self.positionptm, self.origin);
    self.positionptm = self.origin;

    if(var_0 > 16)
      self.segments["_encstr_A2900CD6BDECD237D9157B8E161B"]++;
  }
}

on_player_disconnect(var_0) {
  set_custom_stats();
  level.player_count_left = level.player_count_left + 1;
  _id_119CC(var_0);
}

player_init() {
  var_0 = spawnStruct();
  var_1 = [];
  var_1["_encstr_A1AE1267375AA31F8B49B33370707F895921CDB0"] = get_single_value_struct(0, "_encstr_921904C3DEF8");
  var_1["_encstr_A65D134A709F6C3F63D50E2CE8883FB6F37092B328"] = get_single_value_struct(0, "_encstr_921904C3DEF8");
  var_1["_encstr_AA4810634F935B2211C0029BA915AB7B89AF"] = get_single_value_struct(0, "_encstr_921904C3DEF8");
  var_0.single_value_stats = var_1;
  var_2 = [];
  var_2["_encstr_AB430C13C4CD881EE80F571D5F92"] = [];
  var_2["_encstr_B1720D138868ADFB756543BCD43342"] = [];
  var_2["_encstr_A6D30DA3B45B956E12B1AC233D5D47"] = [];
  var_0.laststand_record = var_2;
  self.cp_matchdata = var_0;
}

set_player_count() {
  if(!isDefined(level.max_concurrent_player_count))
    level.max_concurrent_player_count = 0;

  if(level.players.size >= level.max_concurrent_player_count)
    level.max_concurrent_player_count = level.players.size + 1;
}

set_split_screen() {}

set_join_in_progress() {}

prematch_over() {
  if(scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525") && scripts\engine\utility::flag("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    return 1;

  return 0;
}

update_challenges_status(var_0, var_1) {
  if(level.cp_matchdata.challenge_results.size > 25) {
    return;
  }
  var_2 = spawnStruct();
  var_2.challenge_name = var_0;
  var_2.result = var_1;
  level.cp_matchdata.challenge_results[level.cp_matchdata.challenge_results.size] = var_2;
}

inc_downed_counts() {
  inc_laststand_record("_encstr_AB430C13C4CD881EE80F571D5F92");
}

inc_revived_counts() {
  inc_laststand_record("_encstr_B1720D138868ADFB756543BCD43342");
}

inc_bleedout_counts() {
  inc_laststand_record("_encstr_A6D30DA3B45B956E12B1AC233D5D47");
}

inc_laststand_record(var_0) {
  if(!isDefined(self.cp_matchdata.laststand_record[var_0][level.wave_num]))
    self.cp_matchdata.laststand_record[var_0][level.wave_num] = 0;

  self.cp_matchdata.laststand_record[var_0][level.wave_num]++;
}

update_spending_type(var_0, var_1) {
  switch (var_1) {
    case "_encstr_AC20072B9FA9487832":
      self.cp_matchdata.single_value_stats["_encstr_A1AE1267375AA31F8B49B33370707F895921CDB0"].value = self.cp_matchdata.single_value_stats["_encstr_A1AE1267375AA31F8B49B33370707F895921CDB0"].value + var_0;
      break;
    case "_encstr_A23908476E6229C09C07":
      self.cp_matchdata.single_value_stats["_encstr_A65D134A709F6C3F63D50E2CE8883FB6F37092B328"].value = self.cp_matchdata.single_value_stats["_encstr_A65D134A709F6C3F63D50E2CE8883FB6F37092B328"].value + var_0;
      break;
    case "_encstr_85EF050C9D7062":
      self.cp_matchdata.single_value_stats["_encstr_AA4810634F935B2211C0029BA915AB7B89AF"].value = self.cp_matchdata.single_value_stats["_encstr_AA4810634F935B2211C0029BA915AB7B89AF"].value + var_0;
      break;
    default:
      break;
  }
}

endgame(var_0, var_1) {
  set_game_data(var_0, var_1);
  write_global_clientmatchdata();

  foreach(var_4, var_3 in level.players) {
    scripts\cp\cp_persistence::increment_player_career_total_waves(var_3);
    scripts\cp\cp_persistence::increment_player_career_total_score(var_3);
    var_3 set_player_data(var_1);
    var_3 set_player_game_data();
    var_3 write_clientmatchdata_for_player(var_3, var_4);
  }

  if(isDefined(level.analyticsendgame))
    [[level.analyticsendgame]]();

  if(getdvarint("_encstr_A5B60A1F499D8F973153F986") != 0)
    sendmatchdata();

  sendclientmatchdata();
}

set_player_data(var_0) {
  var_1 = self getplayerdata("_encstr_850703B7D9", "_encstr_B864100E38A8A0F877252F274D36D3E9D803", "_encstr_AC8F12E9ED74FF7A98381538A3C5293835B94FB3");
  var_2 = self getplayerdata("_encstr_850703B7D9", "_encstr_B864100E38A8A0F877252F274D36D3E9D803", "_encstr_95B80C17DA7BF867C7ED6BC84D94");

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 0;

  var_1 = var_1 + var_0 / 1000;
  var_2 = var_2 + 1;
  self setplayerdata("_encstr_850703B7D9", "_encstr_B864100E38A8A0F877252F274D36D3E9D803", "_encstr_AC8F12E9ED74FF7A98381538A3C5293835B94FB3", int(var_1));
  self setplayerdata("_encstr_850703B7D9", "_encstr_B864100E38A8A0F877252F274D36D3E9D803", "_encstr_95B80C17DA7BF867C7ED6BC84D94", int(var_2));
}

set_game_data(var_0, var_1) {
  var_2 = "_encstr_911F1446D019B0116FD0FA15CB6EAD6BF1691D551D5F";
  var_3 = level.cp_matchdata;

  foreach(var_7, var_5 in var_3.single_value_stats)
  var_6 = validate_value(var_5.value, var_5.value_type);

  foreach(var_10, var_9 in var_3.challenge_results) {}

  setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_B4B811B8FA66B3E9830FE6E81DCBF337CF4290", level.players.size);
  setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_B44D0F2DB14089F750E1813BA8390F7128", getsystemtime());
  setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_A7E60D8363F85FA2B6F17737DDA0C8", validate_byte(level.player_count));
  setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_921912F1DC500A03934FB31D5362BBC118DB174B", validate_byte(level.player_count_left));
}

set_player_game_data() {
  copy_from_playerdata();
  set_laststand_stats();
  set_single_value_stats();
  set_custom_stats();
}

get_player_matchdata(var_0, var_1) {
  if(isDefined(level.matchdata["_encstr_8BB007E03658CBCAE4"][self.clientid]) && isDefined(level.matchdata["_encstr_8BB007E03658CBCAE4"][self.clientid][var_0]))
    return level.matchdata["_encstr_8BB007E03658CBCAE4"][self.clientid][var_0];

  return var_1;
}

set_custom_stats() {
  var_0 = self getplayerdata("_encstr_850703B7D9", "_encstr_B864100E38A8A0F877252F274D36D3E9D803", "_encstr_AC8F12E9ED74FF7A98381538A3C5293835B94FB3");
  var_1 = self getplayerdata("_encstr_850703B7D9", "_encstr_B864100E38A8A0F877252F274D36D3E9D803", "_encstr_95B80C17DA7BF867C7ED6BC84D94");
  var_2 = self getplayerdata("_encstr_850703B7D9", "_encstr_81F20CA34DEDEF635F1296D1C755", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_A51F05CB11A052");
  var_3 = self getplayerdata("_encstr_850703B7D9", "_encstr_81F20CA34DEDEF635F1296D1C755", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_A1ED09400BA5D351227715");
}

copy_from_playerdata() {}

set_laststand_stats() {}

set_single_value_stats() {}

validate_value(var_0, var_1) {
  switch (var_1) {
    case "_encstr_BE9C05C6A8B33B":
      return validate_byte(var_0);
    case "_encstr_8C4806EBD0682BFB":
      return validate_short(var_0);
    case "_encstr_921904C3DEF8":
      return validate_int(var_0);
    default:
  }
}

validate_byte(var_0) {
  return int(min(var_0, 127));
}

validate_short(var_0) {
  return int(min(var_0, 32767));
}

validate_int(var_0) {
  return int(min(var_0, 2147483647));
}

get_single_value_struct(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.value = var_0;
  var_2.value_type = var_1;
  return var_2;
}

init_analytics(var_0) {
  var_1 = 0;
  var_2 = 1;
  var_3 = 2;
  var_4 = 1;
  var_5 = 2;
  var_6 = 3;
  var_7 = 4;
  var_8 = 5;
  var_9 = 6;
  var_10 = 1;
  var_11 = 100;
  var_12 = 101;
  var_13 = 300;
  level.blackbox_data_type = [];
  level.matchdata_struct = [];
  level.matchdata_data_type = [];
  level.matchdata = [];
  level.clientmatchdata_struct = [];
  level.clientmatchdata_data_type = [];
  level.clientmatchdata = [];

  for(var_14 = var_12; var_14 <= var_13; var_14++) {
    var_15 = tablelookup(var_0, var_1, var_14, var_4);

    if(var_15 == "_encstr_B40101") {
      continue;
    }
    var_16 = tablelookup(var_0, var_1, var_14, var_5);

    if(var_16 != "_encstr_B40101")
      level.blackbox_data_type[var_15] = var_16;

    var_17 = tablelookup(var_0, var_1, var_14, var_6);

    if(var_17 != "_encstr_B40101")
      level.matchdata_data_type[var_15] = var_17;

    var_18 = tablelookup(var_0, var_1, var_14, var_7);

    if(var_18 != "_encstr_B40101") {
      level.matchdata_struct[var_15] = [];
      level.matchdata[var_15] = [];
    }

    var_19 = tablelookup(var_0, var_1, var_14, var_8);

    if(var_19 != "_encstr_B40101")
      level.clientmatchdata_data_type[var_15] = var_19;

    var_20 = tablelookup(var_0, var_1, var_14, var_9);

    if(var_20 != "_encstr_B40101") {
      level.clientmatchdata_struct[var_15] = [];
      level.clientmatchdata[var_15] = [];
    }
  }

  level.analytics_event = [];

  for(var_14 = var_10; var_14 <= var_11; var_14++) {
    var_21 = tablelookup(var_0, var_1, var_14, var_2);

    if(var_21 == "_encstr_B40101") {
      break;
    }

    var_22 = tablelookup(var_0, var_1, var_14, var_3);
    level.analytics_event[var_21] = var_22;
    var_23 = strtok(var_22, "_encstr_974C0246");

    foreach(var_25 in var_23) {
      if(isDefined(level.matchdata_struct[var_25]))
        level.matchdata_struct[var_25][var_21] = 0;

      if(isDefined(level.clientmatchdata_struct[var_25]) && isDefined(level.clientmatchdata_data_type[var_21]))
        level.clientmatchdata_struct[var_25][var_21] = 0;
    }
  }
}

log_event(var_0, var_1, var_2, var_3, var_4) {
  var_5 = get_data_to_update(var_0);
  log_clientmatchdata(var_0, var_5, var_1, var_4);
}

log_clientmatchdata(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    return;
  }
  var_4 = 0;

  if(is_clientmatchdata_data(var_0)) {
    foreach(var_6 in var_1) {
      if(is_clientmatchdata_struct(var_6)) {
        var_7 = var_3[var_4];

        if(!isDefined(level.clientmatchdata[var_6][var_7]))
          level.clientmatchdata[var_6][var_7] = level.clientmatchdata_struct[var_6];

        level.clientmatchdata[var_6][var_7][var_0] = level.clientmatchdata[var_6][var_7][var_0] + var_2;
        var_4++;
      }
    }
  }
}

get_bb_string(var_0) {
  var_1 = "_encstr_B40101";

  foreach(var_4, var_3 in var_0) {
    var_1 = var_1 + (var_3 + "_encstr_974C0246" + level.blackbox_data_type[var_3]);

    if(var_4 != var_0.size - 1)
      var_1 = var_1 + "_encstr_974C0246";
  }

  return var_1;
}

get_data_to_update(var_0) {
  var_1 = level.analytics_event[var_0];
  return strtok(var_1, "_encstr_974C0246");
}

log_matchdata(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  foreach(var_6 in var_1) {
    if(is_matchdata_struct(var_6)) {
      var_7 = var_3[var_4];

      if(!isDefined(level.matchdata[var_6][var_7]))
        level.matchdata[var_6][var_7] = level.matchdata_struct[var_6];

      level.matchdata[var_6][var_7][var_0] = level.matchdata[var_6][var_7][var_0] + var_2;
      var_4++;
    }
  }
}

is_matchdata_struct(var_0) {
  return isDefined(level.matchdata_struct[var_0]);
}

is_clientmatchdata_struct(var_0) {
  return isDefined(level.clientmatchdata_struct[var_0]);
}

is_clientmatchdata_data(var_0) {
  return isDefined(level.clientmatchdata_data_type[var_0]);
}

write_global_clientmatchdata() {
  setclientmatchdata("_encstr_84660F83CB0BF5DAC847E5FD4BB89E5FD7", level.wave_num);
  setclientmatchdata("_encstr_BACD0EF1714D38A0C753B33B7A3B65E8", level.time_survived);

  if(isDefined(level.eogscoringtotalpoints))
    setclientmatchdata("_encstr_BADE0B8E56585BF5CD1BF6E495", level.eogscoringtotalpoints);

  if(isDefined(level.starsearned))
    setclientmatchdata("_encstr_885D0DE63AB09CE6BE59B0E4DC95C8", level.starsearned);

  setclientmatchdata("_encstr_B14F16272F50C385C838965A3131C48A334BBB6F8F85CA6C", level.players.size);
  setclientmatchdata("_encstr_AB1904852B68", level.script);

  if(isDefined(level.write_global_clientmatchdata_func))
    [[level.write_global_clientmatchdata_func]]();
}

write_clientmatchdata_for_player(var_0, var_1) {
  setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_1, "_encstr_9BB5094F0EC73D22DE5BBA", var_0.name);
  var_2 = var_0 getplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_8E8D0697EB01F243");
  var_3 = var_0 getplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_8FAE0723DEEECDCA19");
  var_4 = var_0 getplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_B642089B65A658E8F597");
  var_5 = var_0 getxuidhigh();
  var_6 = var_0 getxuidlow();

  if(!scripts\cp\utility::tryingtoleave()) {
    if(scripts\cp\utility::matchmakinggame())
      setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_1, "_encstr_A51F05CB11A052", var_0 scripts\cp\drone\emp_drone::getrank());
    else
      setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_1, "_encstr_A51F05CB11A052", var_0 scripts\cp\cp_persistence::get_player_rank());
  }

  if(!isDefined(var_0.player_character_index)) {
    return;
  }
  setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_1, "_encstr_85BB0F5A28ABFAE7316D353A9BF8BB47E1", var_0.player_character_index);
  var_7 = level.clientmatchdata["_encstr_8BB007E03658CBCAE4"][var_0.clientid];

  if(isDefined(var_7)) {
    foreach(var_10, var_9 in var_7)
    setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_1, var_10, int(var_9));
  }

  if(isDefined(level.endgame_write_clientmatchdata_for_player_func))
    [[level.endgame_write_clientmatchdata_for_player_func]](var_0, var_1);
}

lootchopper_getattackerdata() {
  setdvarifuninitialized("_encstr_AACB0BD3C4A6A2B49AD25392D4", 0);
  level.analyticslog = spawnStruct();
  level.analyticslog.nextplayerid = 0;
  level.analyticslog.nextobjectid = 0;
  level.analyticslog.nextdeathid = 0;

  if(!analyticsactive())
    return;
}

analyticsactive() {
  if(analyticsspawnlogenabled())
    return 1;

  if(analyticslogenabled())
    return 1;

  return 0;
}

analyticslogenabled() {
  return getdvarint("_encstr_AACB0BD3C4A6A2B49AD25392D4") == 1;
}

getuniqueobjectid() {
  var_0 = level.analyticslog.nextobjectid;
  level.analyticslog.nextobjectid++;
  return var_0;
}

cacheplayeraction(var_0) {
  if(!isDefined(self.analyticslog.cachedactions))
    self.analyticslog.cachedactions = 0;

  self.analyticslog.cachedactions = self.analyticslog.cachedactions | var_0;
}

watchforconnectedplayers() {
  if(!analyticsactive()) {
    return;
  }
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 logevent_playerconnected();
  }
}

watchforbasicplayerevents() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!analyticslogenabled()) {
    return;
  }
  for(;;) {
    var_0 = scripts\engine\utility::_id_143B6("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_AD0607FAAB4AF8ED7B", "_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", "_encstr_8A730DD6B72A37C984A7486847CA23", "_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

    if(var_0 == "_encstr_82EE0F816D2233A3C06BCD7214775D361D") {
      checkstancestatus();
      continue;
    }

    if(var_0 == "_encstr_AD0607FAAB4AF8ED7B") {
      cacheplayeraction(4);
      continue;
    }

    if(var_0 == "_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19") {
      cacheplayeraction(8);
      continue;
    }

    if(var_0 == "_encstr_8A730DD6B72A37C984A7486847CA23") {
      cacheplayeraction(16);
      continue;
    }

    if(var_0 == "_encstr_A76F0F9B1C16BB37B246FAC1C616E59527")
      thread logevent_playerspawn();
  }
}

watchforplayermovementevents() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!analyticslogenabled()) {
    return;
  }
  for(;;) {
    var_0 = scripts\engine\utility::_id_143B5("_encstr_85B4109DAF78A271A1D433199F052FF8D050", "_encstr_878E0E7B375DC28CF09C939DB399C6DA", "_encstr_850E1357739303C8B411A358848CD8502A8FE7EBF3");

    if(var_0 == "_encstr_85B4109DAF78A271A1D433199F052FF8D050") {
      cacheplayeraction(64);
      continue;
    }

    if(var_0 == "_encstr_878E0E7B375DC28CF09C939DB399C6DA") {
      cacheplayeraction(128);
      continue;
    }

    if(var_0 == "_encstr_850E1357739303C8B411A358848CD8502A8FE7EBF3")
      cacheplayeraction(256);
  }
}

watchforusermessageevents() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isai(self)) {
    return;
  }
  if(getdvarint("_encstr_A90F0DE66C39AF1CC6B0E5A395CDE8", 0) == 0) {
    return;
  }
  self notifyonplayercommand("_encstr_ADDD1581378FA9F5871273DE7AFBA578E3AF0739A13238", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
  self notifyonplayercommand("_encstr_9727138C3FD8313F5659DBF1A12CB7B598F73D06B1", "_encstr_A6380E5AB0C61D4BED7337D87B8E0866");
  self notifyonplayercommand("_encstr_BE2A1D34E0B92F13AF681BC12BCD4FB3734087B5880153DCB7A1124B3825C3", "_encstr_B44609DFE707CF394E1651");

  for(;;) {
    self waittill("_encstr_ADDD1581378FA9F5871273DE7AFBA578E3AF0739A13238");
    var_0 = scripts\engine\utility::_id_143AD("_encstr_9727138C3FD8313F5659DBF1A12CB7B598F73D06B1", "_encstr_BE2A1D34E0B92F13AF681BC12BCD4FB3734087B5880153DCB7A1124B3825C3");

    if(isDefined(var_0) && var_0 == "_encstr_BE2A1D34E0B92F13AF681BC12BCD4FB3734087B5880153DCB7A1124B3825C3") {
      self iprintlnbold("_encstr_832F0D5DDBA2902BA6B8E807BC310D");
      logevent_message(self.name, self.origin, "_encstr_BD6813BC459B89CD74023AE97B0F85696FFE2590CC");
    }
  }
}

checkstancestatus() {
  var_0 = self getstance();

  if(var_0 == "_encstr_922406F1A6FD5E05")
    cacheplayeraction(1);
  else if(var_0 == "_encstr_B13D076BED70539F23")
    cacheplayeraction(2);
}

logallplayerposthink() {
  if(!analyticslogenabled()) {
    return;
  }
  for(;;) {
    var_0 = gettime();
    var_1 = level.players;

    foreach(var_3 in var_1) {
      if(!shouldplayerlogevents(var_3)) {
        continue;
      }
      if(isDefined(var_3) && scripts\cp\utility\player::isreallyalive(var_3)) {
        var_3 logevent_path();
        var_3 logevent_scoreupdate();
        waitframe();
      }
    }

    wait(max(0.05, 1.5 - (gettime() - var_0) / 1000));
  }
}

recordbreadcrumbdata() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(getDvar("_encstr_86810B700C22CF5AF105ECF82B") == "_encstr_934C0218") {
    return;
  }
  if(isDefined(scripts\cp\utility::getgametype()) && scripts\cp\utility::getgametype() == "_encstr_B607038AAB")
    var_0 = getdvarfloat("_encstr_B4A60B29D97F914D8B1B06301F", 4.0);
  else
    var_0 = getdvarfloat("_encstr_8A710B27A6D49639984A627A72", 2.0);

  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  for(;;) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2)) {
        continue;
      }
      var_3 = scripts\cp\utility\player::isreallyalive(var_2) && !isai(var_2);
      var_4 = isDefined(var_2.matchdatalifeindex) && scripts\cp\agents\agents::canlogclient(var_2);
      var_5 = isDefined(var_2.team) && var_2.team != "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_2.sessionstate == "_encstr_877508C1D8C22F2DDC3B" && var_2.sessionstate != "_encstr_84670547C3E9F4";

      if(var_3 && var_4 && var_5) {
        var_6 = var_2 scripts\cp\utility::isplayerads();
        var_7 = scripts\cp\agents\agents::gettimefrommatchstart(gettime());
        var_2 recordbreadcrumbdataforplayer(var_7, var_2.matchdatalifeindex, var_6);
      }
    }

    wait(var_0);
  }
}

getpathactionvalue() {
  var_0 = scripts\engine\utility::ter_op(isDefined(self.analyticslog.cachedactions), self.analyticslog.cachedactions, 0);

  if(self iswallrunning())
    var_0 = var_0 | 32;

  return var_0;
}

clearpathactionvalue() {
  self.analyticslog.cachedactions = 0;
  checkstancestatus();
}

buildkilldeathactionvalue() {
  var_0 = 0;
  var_1 = self getstance();

  if(var_1 == "_encstr_922406F1A6FD5E05")
    var_0 = var_0 | 1;
  else if(var_1 == "_encstr_B13D076BED70539F23")
    var_0 = var_0 | 2;

  if(self isjumping())
    var_0 = var_0 | 4;

  if(isDefined(self.lastshotfiredtime) && gettime() - self.lastshotfiredtime < 500)
    var_0 = var_0 | 8;

  if(self isreloading())
    var_0 = var_0 | 16;

  return var_0;
}

buildloadoutstring() {
  var_0 = "_encstr_96841258398D43ACD1CBE0CA021004028001809E" + self.loadoutarchetype + "_encstr_A54C02F2" + "_encstr_A96412E0B7BB5639413996B68539CB801004107A" + self.loadoutequipmentprimary + "_encstr_A54C02F2" + "_encstr_86831283683C1F120953C3C76D989E1B63E9FEDF" + self.loadoutequipmentsecondary + "_encstr_A54C02F2" + "_encstr_932612D75D6EB09893215338DA87CE20D6F081CB" + self.primaryweapon + "_encstr_A54C02F2" + "_encstr_A3E0122FA5E638B70B9909F162334D78FA210943" + self.secondaryweapon + "_encstr_A54C02F2";
  return var_0;
}

buildspawnpointstatestring(var_0) {
  var_1 = "_encstr_B40101";

  if(isDefined(var_0.lastbucket)) {
    if(isDefined(var_0.lastbucket["_encstr_9A8507BA4040188D08"]))
      var_1 = var_1 + ("_encstr_92340ECF9171D225A07D73FE70387C2F" + var_0.lastbucket["_encstr_9A8507BA4040188D08"] + "_encstr_A54C02F2");

    if(isDefined(var_0.lastbucket["_encstr_8E8405EA382B2A"]))
      var_1 = var_1 + ("_encstr_8CEE0C1BA08C48EE1FF2D019EB56" + var_0.lastbucket["_encstr_8E8405EA382B2A"] + "_encstr_A54C02F2");
  }

  return var_1;
}

logevent_path() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_0 = anglesToForward(self getplayerangles());
  getentitylessscriptablearray("_encstr_9BC80CCF3FF0AD90225E08CF3310", ["_encstr_A2F8090B80BFF74F88F34C", self.analyticslog.playerid, "_encstr_814C02A2", self.origin[0], "_encstr_AA4C0279", self.origin[1], "_encstr_964C02E5", self.origin[2], "_encstr_A5010C3B57DCFABDC94BACE6A3E1", var_0[0], "_encstr_86010C6750305FF2EDBB4F851DC3", var_0[1], "_encstr_8B010C19CDD571F71B2A6F98B0F8", var_0[2], "_encstr_B40B07666F8BC31783", getpathactionvalue(), "_encstr_91B50734CA58631D1A", getsantizedhealth()]);
  clearpathactionvalue();
}

logevent_playerspawn() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_0 = isDefined(self.lastspawnpoint) && isDefined(self.lastspawnpoint.buddyspawn) && self.lastspawnpoint.buddyspawn;
  var_1 = anglesToForward(self.angles);
  getentitylessscriptablearray("_encstr_A2E6105A0199A7EEB8FF3B209BD8F5073358", ["_encstr_A2F8090B80BFF74F88F34C", self.analyticslog.playerid, "_encstr_814C02A2", self.origin[0], "_encstr_AA4C0279", self.origin[1], "_encstr_964C02E5", self.origin[2], "_encstr_8E730808532CB3B053F0", var_1[0], "_encstr_B87308406A623B209C07", var_1[1], "_encstr_AC73084A1BF9A9103462", var_1[2], "_encstr_B1750873B8E9AC3A3BED", buildloadoutstring(), "_encstr_81EF05D197C12B", scripts\engine\utility::ter_op(var_0, "_encstr_85E20624BA8C8CCB", "_encstr_820E07F8E8780B3A4C"), "_encstr_8AEF05472BC2D6", self.team]);
}

logevent_playerconnected() {
  if(!analyticsactive()) {
    return;
  }
  if(!isDefined(self.analyticslog))
    self.analyticslog = spawnStruct();

  self.analyticslog.playerid = level.analyticslog.nextplayerid;
  level.analyticslog.nextplayerid++;

  if(!analyticslogenabled()) {
    return;
  }
  var_0 = undefined;

  if(isDefined(self.changedarchetypeinfo))
    var_0 = self.changedarchetypeinfo.super;
  else
    var_0 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_AB010F01B25370857BA7A99B17335750FA");

  var_1 = self getxuid();
  getentitylessscriptablearray("_encstr_9570165F17422580D071A338E6B1F8E61977D7C5936AFEC0", ["_encstr_A2F8090B80BFF74F88F34C", self.analyticslog.playerid, "_encstr_B1540CA9FB5AF3782A89A8412DE5", self.name, "_encstr_84E90C90A37122C32329CB55BC9A", var_1, "_encstr_B15512A9FB5AF3782A890BC36AE5183842371B1B", var_0]);
}

logevent_playerdeath(var_0, var_1, var_2) {
  if(!shouldplayerlogevents(self) || !isPlayer(self)) {
    return;
  }
  var_3 = anglesToForward(self getplayerangles());
  var_4 = -1;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = "_encstr_B24C02EF";
  var_12 = 0;

  if(isDefined(var_0) && isPlayer(var_0)) {
    var_4 = var_0.analyticslog.playerid;

    if(isDefined(var_0.team)) {
      if(var_0.team == "_encstr_8E8405EA382B2A")
        var_11 = "_encstr_994C023A";
      else
        var_11 = "_encstr_A54C0259";
    }

    if(isDefined(var_0.origin)) {
      var_5 = var_0.origin[0];
      var_6 = var_0.origin[1];
      var_7 = var_0.origin[2];
    }

    if(isDefined(var_0.lifeid))
      var_12 = var_0.lifeid;

    var_13 = anglesToForward(var_0 getplayerangles());

    if(isDefined(var_13)) {
      var_8 = var_13[0];
      var_9 = var_13[1];
      var_10 = var_13[2];
    }
  }

  var_14 = level.analyticslog.nextdeathid;
  level.analyticslog.nextdeathid++;
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, "_encstr_8BBA05085F8B99");
  var_15 = "_encstr_B24C02EF";

  if(self.team == "_encstr_8E8405EA382B2A")
    var_15 = "_encstr_994C023A";
  else
    var_15 = "_encstr_A54C0259";

  getentitylessscriptablearray("_encstr_841609A1F7328F0F2F2B2A", ["_encstr_A2F8090B80BFF74F88F34C", self.analyticslog.playerid, "_encstr_814C02A2", self.origin[0], "_encstr_AA4C0279", self.origin[1], "_encstr_964C02E5", self.origin[2], "_encstr_A5010C3B57DCFABDC94BACE6A3E1", var_3[0], "_encstr_86010C6750305FF2EDBB4F851DC3", var_3[1], "_encstr_8B010C19CDD571F71B2A6F98B0F8", var_3[2], "_encstr_AC20072B9FA9487832", var_2, "_encstr_B23C0EADCAB0E67DB7CCEB3259164786", scripts\engine\utility::ter_op(isDefined(var_1), var_1, "_encstr_8BBA05085F8B99"), "_encstr_8FC70BB0D1E81636D6CA274B8C", var_4, "_encstr_B40B07666F8BC31783", buildkilldeathactionvalue(), "_encstr_B81010A3EF135B789A7774955743B06FCF8D", var_14, "_encstr_9697123027E3F3ABA2B951EBCF1AFF18468B2038", self.lifeid, "_encstr_8FD7142E489BB9F0E01FC286686036754FC2C0273761", var_12, "_encstr_BA490CF653989B2F397EDBF28101", var_15, "_encstr_8FA50E7363F307A0AB9F833EC38DF849", var_11, "_encstr_BEB40F602B73B319D7E5BE20E81FC307D8", var_5, "_encstr_8EB40FCEAD718AC3C8807BC74020AB1103", var_6, "_encstr_B8B40F0BE8E82C6CD62B9CAFE0BD6EBEA7", var_7, "_encstr_B287158A834396DFB75F665FBFEBAD1748E88A61CD4D43", var_8, "_encstr_A68715920BBD0F56C853D2F77F105DAF68A36A5AD015A7", var_9, "_encstr_8A8715FB4C2B389E877253FE7AD7C01105A2137BCE93A8", var_10, "_encstr_AB8B0E2368F69B1438E7170DB3F85D2B", self.primaryweapon]);

  if(isDefined(var_1) && isexplosivedamagemod(var_1))
    logevent_explosion(scripts\engine\utility::ter_op(isDefined(var_2), var_2, "_encstr_979608DF73C8E70B73A1"), self.origin, var_0, 1.0);

  if(isDefined(self.attackers)) {
    foreach(var_17 in self.attackers) {
      if(isDefined(var_17) && isPlayer(var_17) && var_17 != var_0)
        logevent_assist(var_17.analyticslog.playerid, var_14, var_2);
    }
  }
}

logevent_playerkill(var_0, var_1, var_2) {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_3 = anglesToForward(self getplayerangles());
  getentitylessscriptablearray("_encstr_8B990CD9165B59D81CBEB62D638D", ["_encstr_A2F8090B80BFF74F88F34C", self.analyticslog.playerid, "_encstr_814C02A2", self.origin[0], "_encstr_AA4C0279", self.origin[1], "_encstr_964C02E5", self.origin[2], "_encstr_A5010C3B57DCFABDC94BACE6A3E1", var_3[0], "_encstr_86010C6750305FF2EDBB4F851DC3", var_3[1], "_encstr_8B010C19CDD571F71B2A6F98B0F8", var_3[2], "_encstr_AC20072B9FA9487832", scripts\engine\utility::ter_op(isDefined(var_2), var_2, "_encstr_8BBA05085F8B99"), "_encstr_A5490DD915F7B8C7A5E271C80ABD69", scripts\engine\utility::ter_op(isDefined(var_1), var_1, "_encstr_8BBA05085F8B99"), "_encstr_B89509D92DD8E85AD6D246", scripts\engine\utility::ter_op(isDefined(var_0) && isPlayer(var_0), var_0.analyticslog.playerid, "_encstr_B10703DD0F"), "_encstr_B40B07666F8BC31783", buildkilldeathactionvalue(), "_encstr_A56110C2D1A358C6B65627F5A1CA0B8DD10D", getsantizedhealth(), "_encstr_A1C913A310204CA29997E3BFE1B53AAFF8389B2D2B", 0]);
}

logevent_explosion(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }
  if(!isDefined(var_4))
    var_4 = (1, 0, 0);

  getentitylessscriptablearray("_encstr_8DBC11CE2CD6CA6C07FAB2C31CC6BDB996DB9B", ["_encstr_A2F8090B80BFF74F88F34C", var_2.analyticslog.playerid, "_encstr_814C02A2", var_1[0], "_encstr_AA4C0279", var_1[1], "_encstr_964C02E5", var_1[2], "_encstr_8E730808532CB3B053F0", var_4[0], "_encstr_B87308406A623B209C07", var_4[1], "_encstr_AC73084A1BF9A9103462", var_4[2], "_encstr_A7AC09C857E458475AED37", var_3, "_encstr_81EF05D197C12B", var_0]);
}

logevent_frontlineupdate(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }
  getentitylessscriptablearray("_encstr_8B0E12EC586B2BB183F5664EBDDC8EFA1BD2CD95", ["_encstr_826D079BDDC92BC329", var_0[0], "_encstr_BD6D077BC3FF9B4B90", var_0[1], "_encstr_9A60050718982B", var_1[0], "_encstr_8C600556DC465E", var_1[1], "_encstr_86130D79CA120FB7506F10DC1FDB52", var_3[0], "_encstr_A5130DEE8B6B8B9FA9E06B0BC8A381", var_3[1], "_encstr_9B470F373DF251AD6AE186A5D0D908DA78", var_2[0], "_encstr_99470FB0ED7990BD880E4B2B38A3BFF263", var_2[1], "_encstr_A1AD062E09D98338", var_4]);
}

logevent_gameobject(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }
  getentitylessscriptablearray("_encstr_93660EB3B06BB2B11CD7BD4C35CA8DD1", ["_encstr_91D409509304BBA70D17CD", var_1, "_encstr_814C02A2", var_2[0], "_encstr_AA4C0279", var_2[1], "_encstr_964C02E5", var_2[2], "_encstr_A32908801BD3D5F0043C", var_3, "_encstr_81EF05D197C12B", var_0, "_encstr_A1AD062E09D98338", var_4]);
}

logevent_message(var_0, var_1, var_2) {
  if(!analyticslogenabled()) {
    return;
  }
  getentitylessscriptablearray("_encstr_BEF90F6F277215B0C061106912ABE85CAA", ["_encstr_A32908801BD3D5F0043C", var_0, "_encstr_814C02A2", var_1[0], "_encstr_AA4C0279", var_1[1], "_encstr_964C02E5", var_1[2], "_encstr_A9B508B69537CD16D9CA", var_2]);
}

logevent_tag(var_0) {
  if(!analyticslogenabled()) {
    return;
  }
  bbprint("_encstr_ADF011308F65A9C7FB215957C3E21933D13F08", "_encstr_92170BBD9BF3F0F214B5062E23", var_0);
}

logevent_powerused(var_0, var_1) {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_2 = anglesToForward(self.angles);
  getentitylessscriptablearray("_encstr_868C0D18A74DB1DF13D93F482BBA05", ["_encstr_A32908801BD3D5F0043C", self.analyticslog.playerid, "_encstr_814C02A2", self.origin[0], "_encstr_AA4C0279", self.origin[1], "_encstr_964C02E5", self.origin[2], "_encstr_8E730808532CB3B053F0", var_2[0], "_encstr_B87308406A623B209C07", var_2[1], "_encstr_AC73084A1BF9A9103462", var_2[2], "_encstr_81EF05D197C12B", var_0, "_encstr_A1AD062E09D98338", var_1]);
}

logevent_scoreupdate() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_0 = anglesToForward(self.angles);
  getentitylessscriptablearray("_encstr_B80F12E2FFE239481A7763936F5BBD9BD70FAE74", ["_encstr_A32908801BD3D5F0043C", self.analyticslog.playerid, "_encstr_82FB06EB26785BD7", self.score]);
}

logevent_minimapcorners() {
  if(!analyticslogenabled()) {
    return;
  }
  var_0 = getEntArray("_encstr_A6BC0F4183703022A7E3EFDE40DB48380B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0) || var_0.size != 2) {
    return;
  }
  getentitylessscriptablearray("_encstr_BE0D0BF7BFEA8D583899F8717A", ["_encstr_A27B0A1E702D2AB59BD09F0B", var_0[0].origin[0], "_encstr_957B0A23AF73254AA81E1F3A", var_0[0].origin[1], "_encstr_B47B0A3E756D4AA79273A12A", var_0[1].origin[0], "_encstr_957B0A23AF73254AA8DE1F3A", var_0[1].origin[1], "_encstr_887106DCEDC93A34", getnorthyaw()]);
}

logevent_assist(var_0, var_1, var_2) {
  if(!analyticslogenabled()) {
    return;
  }
  getentitylessscriptablearray("_encstr_A17D0FD0FAB53B993B5FB7B66B8743D19A", ["_encstr_A2F8090B80BFF74F88F34C", var_0, "_encstr_B81010A3EF135B789A7774955743B06FCF8D", var_1, "_encstr_AC20072B9FA9487832", var_2]);
}

getsantizedhealth() {
  return int(clamp(self.health, 0, 100000));
}

shouldplayerlogevents(var_0) {
  if(!analyticslogenabled())
    return 0;

  if(!isDefined(var_0.team) || var_0.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_0.sessionstate != "_encstr_877508C1D8C22F2DDC3B" && var_0.sessionstate != "_encstr_84670547C3E9F4")
    return 0;

  return 1;
}

logmatchtags() {
  var_0 = getDvar("_encstr_A975122F47EB60D8B68668C2EB6910AED1E3839F", "_encstr_B40101");

  if(var_0 != "_encstr_B40101")
    logevent_tag(var_0);

  if(scripts\cp\utility::matchmakinggame())
    logevent_tag("_encstr_A63E0CD4A52C08701A679B89E7F2");
  else if(getdvarint("_encstr_93390B136AA2628AA8A93529D4"))
    logevent_tag("_encstr_84920D61F0B3C3DFDBFD05210D4183");
  else if(!getdvarint("_encstr_BE9C0BD1E3C16D64B9DB4989F7"))
    logevent_tag("_encstr_85480DD333CCB15AE62BA9B0A38D34");
}

logevent_superended(var_0, var_1, var_2, var_3) {
  if(!analyticslogenabled()) {
    return;
  }
  var_4 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    var_4 = self.analyticslog.playerid;

  getentitylessscriptablearray("_encstr_8D0414589B8563E51DB48DDCBED683BEDC57C15693E6", ["_encstr_B4970B6EEA07ACE4EBCD2CD6AC", var_0, "_encstr_A23B0CCDAC223B069C5F217807A5", var_1, "_encstr_87DB099A7562AECB5BDB53", var_2, "_encstr_96420A1AA3E3DEA0183A0D3A", var_3, "_encstr_86FF0AA0F9E12F9F254122EA", var_4]);
}

logevent_superearned(var_0) {
  if(!analyticslogenabled()) {
    return;
  }
  var_1 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    var_1 = self.analyticslog.playerid;

  getentitylessscriptablearray("_encstr_ABDE1AE39B3211E0446C512B9935E0C04B5F796373396DF87A8599C1", ["_encstr_A9960BD109BB01A1A13BC8E0C2", var_0, "_encstr_86FF0AA0F9E12F9F254122EA", var_1]);
}

logevent_awardgained(var_0) {
  if(!analyticslogenabled()) {
    return;
  }
  getentitylessscriptablearray("_encstr_A12314037BD2F1CBA48CB18B399580A00AF7FBADCB5B", ["_encstr_852F0EDA57B77A0A0F70C5CF9A57079D", var_0]);
}

logevent_giveplayerxp(var_0, var_1, var_2, var_3) {
  if(!analyticslogenabled()) {
    return;
  }
  var_4 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    var_4 = self.analyticslog.playerid;

  getentitylessscriptablearray("_encstr_B6541768DB01D0AB1314F686E1FAC1FE784BE0105FCA4E617B", ["_encstr_AFE5111B5727E456DCA3FA83C9B2E6D15AB356", var_0, "_encstr_998F0EE8A36A1D51BB7CA02145F39999", var_1, "_encstr_BEE30A73FB5867A648D5757C", var_2, "_encstr_9B490A2353C176B5E81AA64B", var_3, "_encstr_86FF0AA0F9E12F9F254122EA", var_4]);
}

_id_119B3(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }
  var_5 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    var_5 = self.analyticslog.playerid;

  var_6 = createheadicon(var_0);
  getentitylessscriptablearray("_encstr_A66417912DF8ED1FC5283A23F691F3E9F093090857E87923EF", ["_encstr_AC20072B9FA9487832", var_6, "_encstr_AFE5111B5727E456DCA3FA83C9B2E6D15AB356", var_1, "_encstr_998F0EE8A36A1D51BB7CA02145F39999", var_2, "_encstr_BEE30A73FB5867A648D5757C", var_3, "_encstr_9B490A2353C176B5E81AA64B", var_4, "_encstr_86FF0AA0F9E12F9F254122EA", var_5]);
}

logevent_sendplayerindexdata() {
  if(!analyticslogenabled()) {
    return;
  }
  var_0 = [];
  var_1 = [];
  var_2 = 0;

  for(var_2 = 0; var_2 < 12; var_2++) {
    var_0[var_2] = 0;
    var_1[var_2] = "_encstr_B40101";
  }

  var_2 = 0;

  foreach(var_4 in level.players) {
    if(!isai(var_4)) {
      var_0[var_2] = var_4.analyticslog.playerid;
      var_1[var_2] = var_4 getxuid();
    }

    var_2 = var_2 + 1;
  }

  getentitylessscriptablearray("_encstr_870D2285E65836BC3A9636DCEBAD2CD1C6D0FA0E8DC2F2959CEBB43791591EF5A5CDD247", ["_encstr_A5C40E83E14EE339B39B593B580FF151", var_0[0], "_encstr_AF3C0D2F34F9F8AD9ACBF9D08B7703", var_1[0], "_encstr_ABF70E0EB10BBCCA93237DA573C856F0", var_0[1], "_encstr_8E900DA7E46FB061A3B7AF41331A49", var_1[1], "_encstr_B8750ECFEDE203419A2E219873A41959", var_0[2], "_encstr_83720D1C63C2CBCAE466BE0FAE4B32", var_1[2], "_encstr_83ED0EF3E99FBB4DB09BC154C8D89563", var_0[3], "_encstr_B6050D87A5AA4B19C27A595847E1F1", var_1[3], "_encstr_85080EFBE187A355B883C94CC0209D6B", var_0[4], "_encstr_93E20D220983D32D03FA2783C058E4", var_1[4], "_encstr_A5560E0E63B0E52BE48DAFA5B98C560F", var_0[5], "_encstr_B6C50D527993C33D13D21793D0A8F4", var_1[5], "_encstr_8F8F0E81814F0B97DA4F4FC97A4F05E0", var_0[6], "_encstr_A9190D21ACE670057BDF4E92C32F4D", var_1[6], "_encstr_B2580E1C1B585EACC91CEBB49B195687", var_0[7], "_encstr_B6A50D83D8165ECAC970BE1EBA5A23", var_1[7], "_encstr_BAB10E03C1E0D0F5FB63794BD8D85F2B", var_0[8], "_encstr_B68E0D1CC60BF256E493AFE1572D91", var_1[8], "_encstr_BE100FD98B2A83683A0253B63C1E583513", var_0[9], "_encstr_91FF0E57757A9BC9129ED2B1A34D2DE9", var_1[9], "_encstr_86F50F1CD8169759274C62BE2DCDC8CA3C", var_0[10], "_encstr_A9A50E377C973AD38237A2C9BB1B83D1", var_1[10], "_encstr_836B0FDB687163056B5FE717A32861D21B", var_0[11], "_encstr_8A500EB3A5A10875EB16BD5F0BA34B28", var_1[11]]);
}

analyticsspawnlogenabled() {
  return getdvarint("_encstr_AABE0B211185FFF44F26C9DECD") != 0;
}

_id_119B9() {
  var_0 = "_encstr_B40101";

  if(scripts\cp\utility::tryingtoleave()) {
    switch (level.script) {
      case "_encstr_B8790E5F2B9FDE2A79AB61FF18EC7A33":
        var_0 = "_encstr_AB821450AF05E3FE112B8F869141B6EB5DE54938776D";
        break;
      case "_encstr_951A0E70E899F83F87F3B04D2F0B7A73":
        var_0 = "_encstr_826F14A7CF4DAB8E71993820BA39F4D7A458362F6694";
        break;
      case "_encstr_A2B70D6C0EFACDDBF50BB94BBCC243":
        var_0 = "_encstr_BD9C140FCFD89EDB81F939D4E2E9C129A666C7C13154";
        break;
      case "_encstr_841F0DB138EBDCDE7D56DC472C1D59":
        var_0 = "_encstr_A3DF165F90EF2917E3384C5496CBDBD1B61009BD6446194A";
        break;
      case "_encstr_95250D66CBE1E88FC65252335FED9F":
        var_0 = "_encstr_B61713F84A08FD7D046F3949B26F578F5165C575D7";
        break;
      case "_encstr_A37B104F21108BD749C3FE0739C8EF23DE93":
        var_0 = "_encstr_826E15A7CF4DAB8E71993820BA3575AFC56F2331E5153B";
        break;
      default:
        var_0 = "_encstr_85E71405AAEFDEF8043B11EF306F30AB97C2F10CD30F";
    }
  } else if(scripts\cp\utility::turn_off_sniper_laser()) {
    switch (level.script) {
      case "_encstr_A5AF0C8E5BA9232BE887F3B7CF2B":
        var_0 = "_encstr_B24A126F886B5EBADD87254EFB8566333380570B";
        break;
      case "_encstr_A9680ED838F56E3B7D6C2CCE59FAC1D6":
        var_0 = "_encstr_88C417F16BFE1394601B8CC823880E172220AA6B59CE070B80";
        break;
      case "_encstr_A37B104F21108BCE49A3FF83DBF0E753D791":
        var_0 = "_encstr_922B167FAD4A607B13D230B13A1B87092704858F27B21035";
        break;
      case "_encstr_88250C99F0F790ACA79B77735B63":
        var_0 = "_encstr_97E618876083A642356FFDE643DD0E4B2848FF83627CE7CB5775";
        break;
      case "_encstr_83C80B19730FD6D8B1129B832C":
        var_0 = "_encstr_8D0518D45DC9B3A59DB0B108D2E6018E9C16E9E60B4092584B19";
        break;
      case "_encstr_AC110D7F087F3BFB5F072888B83F38":
        var_0 = "_encstr_848D1A3B83F8F3D74C51428EB8A82AE6B0039991D11232BF79494AC2";
        break;
      case "_encstr_B17B0E9033862B4AC9C6695DA2451118":
        var_0 = "_encstr_BEFD176FBD5A700B63A220A10A2B97F934039783544468C107";
        break;
      case "_encstr_8B4F0F36E0F537ECAF2696CEB98EED9CCA":
        var_0 = "_encstr_B48815FF5B96CBC110B18D86A8085030E1A987E3CBBD22";
        break;
      case "_encstr_A9AC0DC9BAF730944163030F573ADD":
        var_0 = "_encstr_AB9A137105B30BB11EF1DC41E065A116CB9749F8AB";
        break;
      case "_encstr_92BE0EC0DB09072B9792474E63A3F0C1":
        var_0 = "_encstr_93EC14E7ABE3C622550FDDC6633DEEBA29088F8338DB";
        break;
      case "_encstr_9B1E0F36C7595E03BEC353181189672D72":
        var_0 = "_encstr_8DAE1435BA27CE2DD92C8D104B3708952DD8B185EC59";
        break;
      default:
        var_0 = "_encstr_B12C0921EB222DE813B1E1";
    }
  } else {
    switch (level.script) {
      case "_encstr_96250E8F105945B875F131AFB3CBAEB7":
        var_0 = "_encstr_BDB412512B77D519EB29F078784FC395DE5280B8";
        break;
      case "_encstr_AC850C5F503EB4CA3DD5F52DC6C1":
        var_0 = "_encstr_99E71510EBAF0B42B429A0D8E8A1FA8A52E913C6B04733";
        break;
      case "_encstr_86A90F8D07AF0B4EB6E67DC82B2C36AC39":
        var_0 = "_encstr_BD481258A31D7BEE1813A7BE9961B64BB799B2D2";
        break;
      case "_encstr_8A37107778166123D3B60F4797E96A3ABEF2":
        var_0 = "_encstr_875C149C73E756607B09878D68EEA090D73B13C03A5B";
        break;
      case "_encstr_BE1D0DD8E07D46BB37F5E8BB73AFC8":
        var_0 = "_encstr_BA2B0BD38359932C3A2DED3701";
        break;
      case "_encstr_93580C1B837DB9DAAECED936B239":
        var_0 = "_encstr_9AF3147A38593985A34BDBE610905839134BDC9D569C";
        break;
      case "_encstr_88E50E81C30E039F77AC67E0E78B6132":
        var_0 = "_encstr_A5A714D5114F061FA36158E2E6E06DA315DA49904D09";
        break;
      case "_encstr_AC7F0DE0FB29E7698F7CA5254DFFB3":
        var_0 = "_encstr_B1A2107A83AC27B0D15ADBDC01A2B2CDD110";
        break;
      case "_encstr_8B82108D07AF93585A237D6CB7D60E1B951E":
        var_0 = "_encstr_BD1F05492CD246";
        break;
      case "_encstr_ABB40E5E9BB78D683307878123218F50":
        var_0 = "_encstr_BD1F05492CD246";
        break;
      default:
        var_0 = "_encstr_862B0B8D67AB4309E338C73B10";
    }
  }

  var_1 = _func_042D();
  getentitylessscriptablearray("_encstr_ADD523E4F1987F980BF8B81045FE4F70ED80B73F05935382A3C0BBEF4561D081ABB3276D63", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_A5F909EC0B5B2B8EF20ECA", scripts\cp\utility::getgametype(), "_encstr_99A20BD1B4DAB2BE371DB0AD38", getsystemtime(), "_encstr_AA91112CB1E85AB3ACAFDE899A5936A35AD9CA", var_0, "_encstr_87D40E83D81697C65ADC8EFAB9B0DAAC", var_1]);
}

_id_119B8(var_0) {
  var_1 = "_encstr_B40101";

  if(isint(var_0)) {
    var_1 = "_encstr_B40101";

    switch (var_0) {
      case 1:
        var_1 = "_encstr_91190447C232";
        break;
      case 2:
        var_1 = "_encstr_BD79059C51C351";
        break;
      case 3:
        var_1 = "_encstr_BA19049B7723";
        break;
      case 4:
        var_1 = "_encstr_A2160B72184E2BF628D5747DE9";
        break;
    }
  }

  var_2 = "_encstr_B40101";

  if(isDefined(level.completedobjectives) && isarray(level.completedobjectives) && level.completedobjectives.size > 0)
    var_2 = level.completedobjectives[level.completedobjectives.size - 1].objname;

  if(var_1 != "_encstr_B40101") {
    if(scripts\cp\utility::turn_off_sniper_laser())
      var_1 = "_encstr_BA1904BBF763";

    getentitylessscriptablearray("_encstr_954F219258604709C8059596E9F1CE9F9833B96BC1464BFF286F8561F1285417356882", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_A5F909EC0B5B2B8EF20ECA", scripts\cp\utility::getgametype(), "_encstr_99A20BD1B4DAB2BE371DB0AD38", getsystemtime(), "_encstr_AA91112CB1E85AB3ACAFDE899A5936A35AD9CA", level.active_objectives_string, "_encstr_A3891970A673A0A83AAFC3C19B6205603CB198C90CCDA0F57223DB", var_2, "_encstr_9B7C07725D17A39473", var_1]);
  } else
    getentitylessscriptablearray("_encstr_954F219258604709C8059596E9F1CE9F9833B96BC1464BFF286F8561F1285417356882", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_A5F909EC0B5B2B8EF20ECA", scripts\cp\utility::getgametype(), "_encstr_99A20BD1B4DAB2BE371DB0AD38", getsystemtime(), "_encstr_AA91112CB1E85AB3ACAFDE899A5936A35AD9CA", level.active_objectives_string, "_encstr_A3891970A673A0A83AAFC3C19B6205603CB198C90CCDA0F57223DB", var_2, "_encstr_9B7C07725D17A39473", var_0]);
}

_id_119BF(var_0, var_1, var_2, var_3, var_4) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 dlog_recordplayerevent("_encstr_878720789A85AF8EFF06C548FCEFF149AFD270E8011AC1633F205728C53F9B2D576A", ["_encstr_8CCE110E36C2BC599CEB1E07FA2B0BE49B5991", var_1, "_encstr_AC20072B9FA9487832", var_2, "_encstr_88BA11EF190A5998B886A872FF3167BA6D9A0D", var_3, "_encstr_9B490A2353C176B5E81AA64B", var_4, "_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_AA91112CB1E85AB3ACAFDE899A5936A35AD9CA", level.active_objectives_string]);
}

_id_119B6(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 dlog_recordplayerevent("_encstr_81DD24918DB7767D5667CACDE8EB1BE0462CE82CBEE01BC9F5ADEA73A5E896DB73BEBACD2B8C", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_A9900BF17C56C0B5CB1AD940B2", var_0.name, "_encstr_8F070308DF", var_0.origin[0], "_encstr_830703C0BB", var_0.origin[1], "_encstr_8807035222", var_0.origin[2], "_encstr_978D09FA80F57CF330A07E", var_1, "_encstr_AA91112CB1E85AB3ACAFDE899A5936A35AD9CA", level.active_objectives_string]);
}

_id_119BE(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 dlog_recordplayerevent("_encstr_88942146C6DE3BD795D995371DEB1BE023B0E80BBEE0634ED7CDAB38B24EEB5D9BCA46", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_A9900BF17C56C0B5CB1AD940B2", var_0.name, "_encstr_8F070308DF", var_0.origin[0], "_encstr_830703C0BB", var_0.origin[1], "_encstr_8807035222", var_0.origin[2], "_encstr_BEB406F03B72BB3B", var_1, "_encstr_AA91112CB1E85AB3ACAFDE899A5936A35AD9CA", level.active_objectives_string]);
}

_id_119B4(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 dlog_recordplayerevent("_encstr_92DC20EA5818ECAFD36CF51D11D79ED1C1F01DDB817839C3C8F7DB4175F1F36FFDD0", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_A32C08DBCBC6CB918820", var_1, "_encstr_83BE103CF3E8D7E28768BA6268D31A3B41ED", var_0.times_kidnapped, "_encstr_AA91112CB1E85AB3ACAFDE899A5936A35AD9CA", level.active_objectives_string]);
}

_id_119BD(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 dlog_recordplayerevent("_encstr_BD902B04B918BF17DDBB2A6203382FB2980BAC89478805FBE833739A4B88A76B58F30F045BB88D33AD8BFAF311", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_83740E1B0BE6A3BEE6E8C2CD8CFAB419", punishwavechaseplayers(var_0), "_encstr_AA91112CB1E85AB3ACAFDE899A5936A35AD9CA", level.active_objectives_string]);
}

_id_119BB(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 dlog_recordplayerevent("_encstr_A9542B1963BDECD72B6795E6D1BED88323B01D16D783D84EAFCD8316BBB9FAD99616D758BA3A7B4E2BCE4B67B2", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_83740E1B0BE6A3BEE6E8C2CD8CFAB419", punishwavechaseplayers(var_0), "_encstr_AA91112CB1E85AB3ACAFDE899A5936A35AD9CA", level.active_objectives_string]);
}

_id_119BC(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 dlog_recordplayerevent("_encstr_B228273C8120871FD5A3229A0B2017BA9003A4814F800DE3903B6B927380AF7340EB171851A090672E", ["_encstr_B442086D6763FB3D4F0A", var_1, "_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_83740E1B0BE6A3BEE6E8C2CD8CFAB419", punishwavechaseplayers(var_0), "_encstr_8F070308DF", var_0.origin[0], "_encstr_830703C0BB", var_0.origin[1], "_encstr_8807035222", var_0.origin[2], "_encstr_AA91112CB1E85AB3ACAFDE899A5936A35AD9CA", level.active_objectives_string]);
}

_id_119B5(var_0, var_1, var_2) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_3 = scripts\engine\utility::ter_op(isPlayer(var_1), var_1.name, var_1.agent_type);
  var_0 dlog_recordplayerevent("_encstr_9B661D9A616A897107DC47A6B101C998FCDA954BE8372A3277AAA8D8A9E18B", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_8F070308DF", var_0.origin[0], "_encstr_830703C0BB", var_0.origin[1], "_encstr_8807035222", var_0.origin[2], "_encstr_936B0AB93A0B3AAF1D5EC1AC", "_encstr_A7CF071C7B0912BD51", "_encstr_88BF06FD784A6393", var_3, "_encstr_91070301C2", var_1.origin[0], "_encstr_8B07032FC8", var_1.origin[1], "_encstr_BD0703BD7A", var_1.origin[2], "_encstr_AA91112CB1E85AB3ACAFDE899A5936A35AD9CA", level.active_objectives_string, "_encstr_AC20072B9FA9487832", var_2.basename]);
}

_id_119B2(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  _id_13F9C(var_0);
  var_2 = scripts\engine\utility::ter_op(isagent(var_1), var_1.agent_type, var_0.name);
  var_0 dlog_recordplayerevent("_encstr_B1B01D79DC75900837FB3940C307DEE04F29D1EB471A90E6B7F2706B8AC705", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_88BF06FD784A6393", var_2, "_encstr_83740E1B0BE6A3BEE6E8C2CD8CFAB419", punishwavechaseplayers(var_0), "_encstr_8F070308DF", var_0.origin[0], "_encstr_830703C0BB", var_0.origin[1], "_encstr_8807035222", var_0.origin[2], "_encstr_AA91112CB1E85AB3ACAFDE899A5936A35AD9CA", level.active_objectives_string]);
}

_id_13F9C(var_0) {
  if(!isDefined(var_0.watch_for_helis_killed))
    var_0.watch_for_helis_killed = 0;
  else
    var_0.watch_for_helis_killed++;

  return var_0.watch_for_helis_killed;
}

punishwavechaseplayers(var_0) {
  return var_0.watch_for_helis_killed;
}