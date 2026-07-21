/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\sentry_gun_mp.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_AA060B6EB2731DE4BCFAEC57E6", scripts\cp_mp\killstreaks\sentry_gun::tryusesentryturretfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56", ::sentryturret_monitordamage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83", ::sentryturret_createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_BDEC10D7BDF951795318BFE3516922EAA34E", ::sentryturret_gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_A6FC132FD03008172AB6C3C662F3899B5BE36AB26F", ::sentryturret_initsentrysettings);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_8CDE1476A048475337CB9FA7EBCF1886716B2A3A3920", ::_id_13027);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_824D15630388FAD498047D03B8F8E771519B9BA3F72ED2", scripts\mp\killstreaks\manual_turret_mp::_id_11AC1);
}

sentryturret_gettargetmarker(var_0, var_1) {
  return scripts\mp\killstreaks\target_marker::gettargetmarker(var_0, var_1);
}

sentryturret_createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  return scripts\mp\gameobjects::createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

sentryturret_monitordamage(var_0) {
  var_0 thread scripts\mp\damage::monitordamage(var_0.maxhealth, "_encstr_A2FB098A2035874AB0F358", ::sentryturret_handledeathdamage, ::sentryturret_modifydamage, 1);
}

sentryturret_handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = level.sentrysettings[self.turrettype];
  var_7 = scripts\mp\damage::onkillstreakkilled(var_6.streakname, var_1, var_2, var_3, var_4, var_6.scorepopup, var_6.vodestroyed, var_6.destroyedsplash);

  if(var_7)
    var_1 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");

  var_8 = 0;

  if(var_3 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_3 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_3 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" || var_3 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421")
    var_8 = 1;

  self notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", var_8, 1);
}

sentryturret_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_6 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_2, var_3, var_6, self.maxhealth, 2, 3, 4, 12, 400);
  return var_6;
}

sentryturret_initsentrysettings() {
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"] = spawnStruct();
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].health = 999999;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].maxhealth = 650;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].burstmin = 20;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].burstmax = 120;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].pausemin = 0.15;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].pausemax = 0.35;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].lockstrength = 6;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].sentrymodeon = "_encstr_9B1807D39B48FD93A3";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].sentrymodeoff = "_encstr_84FD0F03BB736BB3C36E7AF251911725E0";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].timeout = 75;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].spinuptime = 0.65;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].overheattime = 8.0;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].cooldowntime = 0.3;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].fxtime = 0.3;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].streakname = "_encstr_AA060B6EB2731DE4BCFAEC57E6";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].weaponinfo = "_encstr_BD4611B956CDD14EF2F5E8ABC99C953AF55B38";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].playerweaponinfo = "_encstr_BD4611B956CDD14EF2F5E8ABC99C953AF55B38";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].scriptable = "_encstr_86351482A88FF2BFE8256A69A873277A3DE0FB59F069";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].modelbasecover = "_encstr_BADB1D085B3A543B734302865A3F37FD6E32C05B4613BA0B81310BDB58C9E3";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].modelbaseground = "_encstr_B12D1BBBEAE62128738F6C69B74711B7CA7240E07338C70377CAF65574";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].modeldestroyedcover = "_encstr_BADB1D085B3A543B734302865A3F37FD6E32C05B4613BA0B81310BDB58C9E3";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].modeldestroyedground = "_encstr_B12D1BBBEAE62128738F6C69B74711B7CA7240E07338C70377CAF65574";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].placementhintstring = &"_encstr_B2731FBB730DC39F17B1DDC990A7E7B1A078093F1E86DFE457A1D1F63149B917CD";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].ownerusehintstring = &"_encstr_A3A81D238B59809F714627B1909699F9591B79AADE5FFB0C711E6BC66B6B40";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].otherusehintstring = &"_encstr_AF6823AB7B54EB02795990A8E90F49B3AC503C0BD05F379D51715941E129745F67A0A5830D";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].dismantlehintstring = &"_encstr_B69C234B93611547255F4830449E3F5C11F52CDBC731EFEBCDB781D9CDFB37C5B94DA45CBB";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].headicon = 1;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].teamsplash = "_encstr_A544100350B54F0198E9D501022F49C8BD56";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].destroyedsplash = "_encstr_AA6F1DDF67B0A82015A5B75D716E7BBB28805ABA9E47824A2BDABAA71A1768";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].shouldsplash = 1;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].votimeout = "_encstr_964D15D9B1EE9B0590CA0F341F03852DDBF28178FF37A0";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].vodestroyed = "_encstr_964D15D9B1EE9B0590CA0F341F03852DDBF28178FF37A0";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].scorepopup = "_encstr_998811915937D193ED5E95C8D7CD2BCD1D9397";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].lightfxtag = "_encstr_B2BF0708BA770F795B";
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].iskillstreak = 1;
  level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].headiconoffset = (0, 0, 75);
}

_id_13027() {
  if(scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress())
    return 0;

  if(scripts\cp_mp\utility\killstreak_utility::unsetobjectivemarker(self getcurrentweapon()))
    return 0;

  return 1;
}