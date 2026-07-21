/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\manual_turret_mp.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", scripts\cp_mp\killstreaks\manual_turret::tryusemanualturretfromstruct);
  init_manual_turret_settings();
  init_manual_turret_vo();
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56", ::manual_turret_monitordamage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83", ::manual_turret_createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_BDEC10D7BDF951795318BFE3516922EAA34E", ::manual_turret_gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_8109104A2DEB99C539550A3A11D1D2ADA52A", ::manual_turret_getenemyplayers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_B6F720D3A849463B5D38FAD04141870FAD11CA5B201DBC6B5181F10B652FFB562DF0", ::_id_11AC2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_824D15630388FAD498047D03B8F8E771519B9BA3F72ED2", ::_id_11AC1);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_8CDE1476A048475337CB9FA7EBCF1886716B2A3A3920", ::_id_11AC0);
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
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].timeout = getdvarfloat("_encstr_A93A214BFF82999A0A0EDF1729EB206B13959BB90B0B7581557F0580632F829D5A7947", 90.0);
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
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].votimeout = "_encstr_9BC916831FF0ADF0633B71C96216235FD03748037BFBFD55";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].vodestroyed = "_encstr_83D418E5BD1753053D7BD8D8F155DBE8E72179F00457DB4DE793";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].scorepopup = "_encstr_83D418E5BD1753053D7BD8D8F155DBE8E72179F00457DB4DE793";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].lightfxtag = "_encstr_B2BF0708BA770F795B";
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].iskillstreak = 1;
  level.sentrysettings["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].headiconoffset = (0, 0, 75);
}

init_manual_turret_vo() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E77171862ED935133D7B52DD2631929191A9040F946EBE8E7"] = "_encstr_860917DB6165504743196B73F3030D1071F953A307812098C7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_86231683AB15B068801E2BFD23C802654F152F1F69182830"] = "_encstr_86231683AB15B068801E2BFD23C802654F152F1F69182830";
}

manual_turret_equipment_wrapper(var_0, var_1, var_2) {
  scripts\mp\equipment::takeequipment(var_1);
  var_3 = scripts\cp_mp\killstreaks\manual_turret::tryusemanualturret("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4");

  if(!var_3)
    scripts\mp\equipment::giveequipment("_encstr_B18113D03F8DD811193AEB6397027123D55B1058B3", var_1);
  else {
    init_manual_turret_settings();
    init_manual_turret_vo();
    scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56", ::manual_turret_monitordamage);
    scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83", ::manual_turret_createhintobject);
    scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_BDEC10D7BDF951795318BFE3516922EAA34E", ::manual_turret_gettargetmarker);
    scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_8109104A2DEB99C539550A3A11D1D2ADA52A", ::manual_turret_getenemyplayers);
  }
}

manual_turret_gettargetmarker(var_0, var_1) {
  return scripts\mp\killstreaks\target_marker::gettargetmarker(var_0, var_1);
}

manual_turret_createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  return scripts\mp\gameobjects::createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

manual_turret_monitordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  scripts\mp\damage::monitordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

manual_turret_getenemyplayers(var_0) {
  return scripts\mp\utility\teams::getenemyplayers(var_0);
}

_id_11AC1(var_0) {
  if(isDefined(var_0.moving_platform)) {
    var_1 = spawnStruct();
    var_1.linkparent = var_0.moving_platform;
    var_1.x1givelaststandoverride = var_0._id_11DBE;
    var_1.angleoffset = var_0._id_11DBD;
    var_1.endonstring = "_encstr_A93B084AF782F0DA4A04";
    var_1.deathoverridecallback = ::_id_11ACB;
    var_0 thread scripts\mp\movers::handle_moving_platforms(var_1);
  }
}

_id_11ACB(var_0) {
  self notify("_encstr_AD75063D571AE108");
}

_id_11AC2() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_BD652493BB47CF09B5893D33B1DD419577B3CBD9232F0920CA744F39D905A0CCCF6B61E09A63");
  self endon("_encstr_BD652493BB47CF09B5893D33B1DD419577B3CBD9232F0920CA744F39D905A0CCCF6B61E09A63");
  self endon("_encstr_B4F71A4B9BBA587D93A7013177CAB57845B5B3A6C719F0239B631339");
  thread scripts\cp_mp\killstreaks\manual_turret::_id_11AC6("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  self waittill("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  self notify("_encstr_AF98149D096B11095F8A71A019221A88E0494EDFF754");
}

_id_11AC0() {
  if(scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress())
    return 0;

  if(scripts\cp_mp\utility\killstreak_utility::unsetobjectivemarker(self getcurrentweapon()))
    return 0;

  return 1;
}