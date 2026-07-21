/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\killstreaks\sentry_gun_cp.gsc
***********************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83", ::sentryturret_createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_BDEC10D7BDF951795318BFE3516922EAA34E", ::sentryturret_gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_8B330D3ADBD0F47B4B9536570725A8", ::sentryturret_munitionused);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_9BD80FADABB996E8967BCD35E0B10BB986", scripts\cp\cp_hud_message::showsplash);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_A6FC132FD03008172AB6C3C662F3899B5BE36AB26F", ::sentryturret_initsentrysettings);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_B6F720D3A849463B5D38FAD04141870FAD11CA5B201DBC6B5181F10B652FFB562DF0", ::sentryturret_laststandwatcher);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_8CDE1476A048475337CB9FA7EBCF1886716B2A3A3920", ::_id_13026);
}

sentryturret_gettargetmarker(var_0, var_1) {
  return scripts\cp\inventory\cp_target_marker::gettargetmarker(var_0, var_1);
}

sentryturret_createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  return scripts\cp\utility::createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

sentryturret_munitionused(var_0, var_1) {
  self notify("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32", "_encstr_9B1807D39B48FD93A3");
}

sentryturret_initsentrysettings() {
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"] = spawnStruct();
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].health = 999999;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].maxhealth = 650;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].burstmin = 20;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].burstmax = 120;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].pausemin = 0.15;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].pausemax = 0.35;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].lockstrength = 2;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].sentrymodeon = "_encstr_9B1807D39B48FD93A3";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].sentrymodeoff = "_encstr_84FD0F03BB736BB3C36E7AF251911725E0";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].ammo = 200;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].timeout = 75;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].spinuptime = 0.65;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].overheattime = 8.0;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].cooldowntime = 0.1;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].fxtime = 0.3;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].streakname = "_encstr_AA060B6EB2731DE4BCFAEC57E6";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].weaponinfo = "_encstr_BD4611B956CDD14EF2F5E8ABC99C953AF55B38";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].playerweaponinfo = "_encstr_BD4611B956CDD14EF2F5E8ABC99C953AF55B38";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].scriptable = "_encstr_86351482A88FF2BFE8256A69A873277A3DE0FB59F069";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].modelbasecover = "_encstr_BADB1D085B3A543B734302865A3F37FD6E32C05B4613BA0B81310BDB58C9E3";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].modelbaseground = "_encstr_B12D1BBBEAE62128738F6C69B74711B7CA7240E07338C70377CAF65574";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].modeldestroyedcover = "_encstr_BADB1D085B3A543B734302865A3F37FD6E32C05B4613BA0B81310BDB58C9E3";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].modeldestroyedground = "_encstr_B12D1BBBEAE62128738F6C69B74711B7CA7240E07338C70377CAF65574";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].placementhintstring = &"_encstr_8A0A23DC20838931B3F21313C3AA89437FA8B747EE475591DBEA1337370349B04320EDCDD0";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].ownerusehintstring = &"_encstr_A3A81D238B59809F714627B1909699F9591B79AADE5FFB0C711E6BC66B6B40";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].otherusehintstring = &"_encstr_AF6823AB7B54EB02795990A8E90F49B3AC503C0BD05F379D51715941E129745F67A0A5830D";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].dismantlehintstring = &"_encstr_B69C234B93611547255F4830449E3F5C11F52CDBC731EFEBCDB781D9CDFB37C5B94DA45CBB";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].headicon = 1;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].teamsplash = "_encstr_A544100350B54F0198E9D501022F49C8BD56";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].destroyedsplash = "_encstr_AA6F1DDF67B0A82015A5B75D716E7BBB28805ABA9E47824A2BDABAA71A1768";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].shouldsplash = 1;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].votimeout = "_encstr_8A6C15B9CAE6E8C9F2EB9B437BD8DABE8E2DDA2BF657A3";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].vodestroyed = "_encstr_A13D159BCADC3AC997FAB9A1BD8DDAF5462B9B4793EDF2";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].scorepopup = "_encstr_998811915937D193ED5E95C8D7CD2BCD1D9397";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].lightfxtag = "_encstr_B2BF0708BA770F795B";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].iskillstreak = 1;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].headiconoffset = (0, 0, 75);
}

sentryturret_laststandwatcher() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_A7FE23039B3003B90B20C6C3DA1F2DBDE246716B5704F89B13CBD45F72888F81A3132BB72B");
  self endon("_encstr_A7FE23039B3003B90B20C6C3DA1F2DBDE246716B5704F89B13CBD45F72888F81A3132BB72B");
  self endon("_encstr_B4F71A4B9BBA587D93A7013177CAB57845B5B3A6C719F0239B631339");
  thread scripts\cp_mp\killstreaks\manual_turret::_id_11AC6("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");
  scripts\mp\playeractions::allowactionset("_encstr_A50E0E73A67238B54B6FC3E3E3828DD8", 1);
  scripts\cp_mp\killstreaks\manual_turret::_id_11ACC(1);
  self.bgivensentry = 0;
}

_id_13026() {
  if(isDefined(level.nuclear_core_carrier)) {
    if(self == level.nuclear_core_carrier)
      return 0;
  }

  return 1;
}

sentryturret_revivedwatcher() {
  self waittill("_encstr_9695073995D94BD959");
  scripts\common\utility::allow_sprint(1);
}