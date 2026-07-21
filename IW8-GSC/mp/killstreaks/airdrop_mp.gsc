/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\airdrop_mp.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_BA67082278D537E3C827", scripts\cp_mp\killstreaks\airdrop::tryuseairdropmarkerfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_873B147E08B0443BA0F13FD721D572A8A811FC05A0D8", ::airdrop_airdropmultipleinit);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_A2DD124ECA9DB4CDD1569CD4B1EDC9CA4ADC33B7", ::airdrop_registerscoreinfo);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_855012A6C7EA4BFBE41F1071FF1C708FA2E2952D", ::airdrop_registeractionset);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_87DE11570791851DCA552914E4BDCE93B2379B", ::airdrop_updateuiprogress);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549", ::airdrop_allowactionset);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_81BC1FDD06A3C197ADBA30A0D24E773873B9665B6FABECF316435008EB553F718F", ::airdrop_unresolvedcollisionnearestnode);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_A1C61066D3304A728AFB93ABF73DDB95E8B8", ::airdrop_awardkillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_BD53157A9377DBFB98D8730770938DE2D7A602358FB7E2", ::airdrop_showkillstreaksplash);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_BDEC10D7BDF951795318BFE3516922EAA34E", ::airdrop_gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_8E211A852D4E4627DBC1A65D631D961CB1AC2239DE83A1C916472BE6", ::airdrop_airdropmultipledropcrates);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA", ::airdrop_outlinedisable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_AA1C1936160EA3AEE456C4DBDBA3860B6C3459860BC6D8C4B08D6D", ::airdrop_capturelootcachecallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_91A61B03A31C80F1738B3BE3F21F3A916D079F9F5D3F214823F0502BBB", ::airdrop_iskillstreakblockedforbots);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_A1EA19D07FB4945FB4F491A94ACB65D909F7D190EB68E8159B9F9D", ::airdrop_botiskillstreaksupported);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_ACD719491F2B93408B78DA52D823BE0B619AC5C73CD1A3CD838053", ::br_armor_plate_broken_remove);
}

airdrop_airdropmultipleinit() {
  scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_init();
}

airdrop_registerscoreinfo() {
  scripts\mp\rank::registerscoreinfo("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", "_encstr_BA94069D16D8ABAC", 200);
}

airdrop_registeractionset() {
  var_0 = getdvarint("_encstr_A5CD173B8E2AA1EFF2A3F99D3F8B3808C3E72633B7619090DA", 1);

  if(var_0) {
    scripts\mp\playeractions::registeractionset("_encstr_828C09996A99584D51C7DB", ["_encstr_A1AF107FB41FA3596A69773FD20858C85627", "_encstr_88780599B4E495", "_encstr_A6C7065BACB1CA95", "_encstr_A60F0E030703D180A0665F43BA558F28", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_BEF4071AA87BDF5220"]);
    scripts\mp\playeractions::registeractionset("_encstr_9B3B0DAAC3EA57FDE20F2050271BF1", ["_encstr_A1AF107FB41FA3596A69773FD20858C85627", "_encstr_AC20072B9FA9487832", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_BEF4071AA87BDF5220"]);
  } else
    scripts\mp\playeractions::registeractionset("_encstr_828C09996A99584D51C7DB", ["_encstr_A1AF107FB41FA3596A69773FD20858C85627", "_encstr_AC20072B9FA9487832", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_BEF4071AA87BDF5220"]);
}

airdrop_updateuiprogress(var_0, var_1) {
  scripts\mp\gameobjects::updateuiprogress(var_0, var_1);
}

airdrop_allowactionset(var_0, var_1) {
  scripts\mp\playeractions::allowactionset(var_0, var_1);
}

airdrop_unresolvedcollisionnearestnode(var_0, var_1, var_2) {
  childthread scripts\mp\movers::unresolved_collision_nearest_node(var_0, var_1, var_2);
}

airdrop_awardkillstreak(var_0, var_1, var_2) {
  if(level.gametype == "_encstr_9A7205B39CB919" || level.gametype == "_encstr_AAE507E8423F63C163") {
    var_3 = 0;
    var_4 = 0;
    var_5 = var_1;
  } else {
    var_3 = var_2.streakinfo.mpstreaksysteminfo.streaklifeid;
    var_4 = var_2.streakinfo.mpstreaksysteminfo._id_13913;
    var_5 = var_2.streakinfo.owner;
  }

  thread scripts\mp\killstreaks\killstreaks::awardkillstreak(var_0, "_encstr_8F180CCB17EB37825B883A9240BB", var_3, var_4, var_5);
  scripts\mp\utility\stats::incpersstat("_encstr_BD0515BB679B47D20BD80AA2906B4A875157142506818B", 1);
}

airdrop_showkillstreaksplash(var_0, var_1, var_2) {
  scripts\mp\hud_message::showkillstreaksplash(var_0, var_1, var_2);
}

airdrop_gettargetmarker(var_0) {
  return scripts\mp\killstreaks\target_marker::gettargetmarker(var_0);
}

airdrop_airdropmultipledropcrates(var_0, var_1, var_2, var_3, var_4, var_5) {
  return scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates(var_0, var_1, var_2, var_3, var_4, var_5);
}

airdrop_outlinedisable(var_0, var_1) {
  scripts\mp\utility\outline::outlinedisable(var_0, var_1);
}

airdrop_capturelootcachecallback() {
  return _encstr_B82C2106669B6BBBC467DAF053A791B3B20F7D8B3A42E708A873ABE0EB050B757A327E::capturelootcachecallback;
}

airdrop_iskillstreakblockedforbots(var_0) {
  return scripts\mp\bots\bots_killstreaks::iskillstreakblockedforbots(var_0);
}

airdrop_botiskillstreaksupported(var_0) {
  return scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var_0);
}

br_armor_plate_broken_remove(var_0) {
  var_1 = "_encstr_8BFC0BC2CBD4F737E0A5E1FD79";
  var_2 = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(var_1);
  var_2.madeavailabletime = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var_2.streaklifeid = self.lifeid;
  var_2._id_13913 = self.matchdatalifeindex;
  var_2.owner = self;
  var_2._id_121B0 = self getxuid();
  var_2.attackerisinflictor = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  scripts\mp\analyticslog::logevent_killstreakactivated(self, var_2.streaklifeid, var_2.streakname, var_2.isgimme, var_2.attackerisinflictor, self.origin);
  scripts\mp\killstreaks\killstreaks::combatrecordkillstreakuse(var_1);
  scripts\mp\utility\dialog::playkillstreakusedialog(var_1);
  var_3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_1, self);
  var_3.mpstreaksysteminfo = var_2;
  scripts\cp_mp\killstreaks\juggernaut::tryusejuggernautfromstruct(var_3, var_0);
}