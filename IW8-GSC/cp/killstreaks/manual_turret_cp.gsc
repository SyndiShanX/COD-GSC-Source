/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\killstreaks\manual_turret_cp.gsc
***********************************************/

init() {
  init_manual_turret_settings();
  init_manual_turret_vo();
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56", ::manual_turret_monitordamage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83", ::manual_turret_createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_BDEC10D7BDF951795318BFE3516922EAA34E", ::manual_turret_gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_8109104A2DEB99C539550A3A11D1D2ADA52A", ::manual_turret_getenemyplayers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_8B330D3ADBD0F47B4B9536570725A8", ::_id_11AC3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_B6F720D3A849463B5D38FAD04141870FAD11CA5B201DBC6B5181F10B652FFB562DF0", ::_id_11AC2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_8CDE1476A048475337CB9FA7EBCF1886716B2A3A3920", ::_id_11ABF);
}

init_manual_turret_settings() {
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"] = spawnStruct();
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].health = 999999;
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].maxhealth = 650;
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].burstmin = 20;
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].burstmax = 120;
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].pausemin = 0.15;
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].pausemax = 0.35;
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].sentrymodeon = "_encstr_849007B268BD03DFD8";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].sentrymodeoff = "_encstr_84FD0F03BB736BB3C36E7AF251911725E0";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].ammo = 200;
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].timeout = 90;
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].spinuptime = 0.05;
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].overheattime = 8.0;
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].cooldowntime = 0.1;
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].fxtime = 0.3;
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].streakname = "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].weaponinfo = "_encstr_969E11D61673EA0B8DF58EAE39272B477DB61C";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].playerweaponinfo = "_encstr_969E11D61673EA0B8DF58EAE39272B477DB61C";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].scriptable = "_encstr_93C3146C0E076AA10860576B19638D23F5AD33E9F981";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].modelbasecover = "_encstr_BADB1D085B3A543B734302865A3F37FD6E32C05B4613BA0B81310BDB58C9E3";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].modelbaseground = "_encstr_9B5D1B14F7BA4948CEE728E0FF1581DF829D06930D524F53BD7B08A8BB";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].modeldestroyedcover = "_encstr_BADB1D085B3A543B734302865A3F37FD6E32C05B4613BA0B81310BDB58C9E3";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].modeldestroyedground = "_encstr_9B5D1B14F7BA4948CEE728E0FF1581DF829D06930D524F53BD7B08A8BB";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].placementhintstring = &"_encstr_B2731FBB730DC39F17B1DDC990A7E7B1A078093F1E86DFE457A1D1F63149B917CD";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].ownerusehintstring = &"_encstr_826B234B03E44C8B796A1507679F0198E49E01DB56762DD85402D8011C3F40AFEB877FA655";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].otherusehintstring = &"_encstr_AF6823AB7B54EB02795990A8E90F49B3AC503C0BD05F379D51715941E129745F67A0A5830D";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].dismantlehintstring = &"_encstr_B69C234B93611547255F4830449E3F5C11F52CDBC731EFEBCDB781D9CDFB37C5B94DA45CBB";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].headicon = 1;
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].teamsplash = "_encstr_8D7413A59F3747D08237752390E8D9F36D30ABA8CC";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].destroyedsplash = "_encstr_99D92063C3601DB7B59BE962818E93D2209B1DEC27C0E66B5DD1D2D9CBE5B30A9839";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].shouldsplash = 1;
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].votimeout = "_encstr_8A6C15B9CAE6E8C9F2EB9B437BD8DABE8E2DDA2BF657A3";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].vodestroyed = "_encstr_A13D159BCADC3AC997FAB9A1BD8DDAF5462B9B4793EDF2";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].scorepopup = "_encstr_998811915937D193ED5E95C8D7CD2BCD1D9397";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].lightfxtag = "_encstr_B2BF0708BA770F795B";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].iskillstreak = 1;
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].headiconoffset = (0, 0, 75);
}

init_manual_turret_vo() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_860917DB6165504743196B73F3030D1071F953A307812098C7"] = "_encstr_860917DB6165504743196B73F3030D1071F953A307812098C7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_86231683AB15B068801E2BFD23C802654F152F1F69182830"] = "_encstr_86231683AB15B068801E2BFD23C802654F152F1F69182830";
}

manual_turret_gettargetmarker(var_0, var_1) {
  return scripts\cp\inventory\cp_target_marker::gettargetmarker(var_0, var_1);
}

manual_turret_createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  return scripts\cp\utility::createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

manual_turret_monitordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {}

manual_turret_getenemyplayers(var_0) {
  return scripts\cp\utility::getteamarray(var_0, 1);
}

_id_11AC3(var_0, var_1) {
  self notify("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32", "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4");
}

_id_11AC2() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_BD652493BB47CF09B5893D33B1DD419577B3CBD9232F0920CA744F39D905A0CCCF6B61E09A63");
  self endon("_encstr_BD652493BB47CF09B5893D33B1DD419577B3CBD9232F0920CA744F39D905A0CCCF6B61E09A63");
  self endon("_encstr_B4F71A4B9BBA587D93A7013177CAB57845B5B3A6C719F0239B631339");
  thread scripts\cp_mp\killstreaks\manual_turret::_id_11AC6("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");
  scripts\mp\playeractions::allowactionset("_encstr_A50E0E73A67238B54B6FC3E3E3828DD8", 1);
  scripts\cp_mp\killstreaks\manual_turret::_id_11ACC(1);
  self.bgivensentry = 0;
}

_id_11ABF() {
  if(isDefined(level.nuclear_core_carrier)) {
    if(self == level.nuclear_core_carrier)
      return 0;
  }

  return 1;
}