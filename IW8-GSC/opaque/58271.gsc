/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58271.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_AA060B6EB2731DE4BCFAEC57E6", scripts\cp_mp\killstreaks\sentry_gun::tryusesentryturretfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56", ::_id_13030);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83", ::_id_1302B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_BDEC10D7BDF951795318BFE3516922EAA34E", ::_id_1302C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_A6FC132FD03008172AB6C3C662F3899B5BE36AB26F", ::_id_1302E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_8CDE1476A048475337CB9FA7EBCF1886716B2A3A3920", ::_id_1302A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_824D15630388FAD498047D03B8F8E771519B9BA3F72ED2", scripts\mp\killstreaks\manual_turret_mp::_id_11AC1);
}

_id_1302C(var_0, var_1) {
  return scripts\mp\killstreaks\target_marker::gettargetmarker(var_0, var_1);
}

_id_1302B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  return scripts\mp\gameobjects::createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_13030(var_0) {
  var_0 thread scripts\mp\damage::monitordamage(var_0.maxhealth, "_encstr_A2FB098A2035874AB0F358", ::_id_1302D, ::_id_1302F, 1);
}

_id_1302D(var_0) {
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

_id_1302F(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_6 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_2, var_3, var_6, self.maxhealth, 2, 3, 4, 12, 400);

  if(var_2.classname == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0" || var_2.classname == "_encstr_8C8D08671D451291C849" || var_2.basename == "_encstr_A2C219E404B131BBCD290B06C0FA70CAC79E6CDBE5AD8AE74ED013")
    var_6 = var_6 * getdvarfloat("_encstr_BD6C217B21762FCEC8DF1C059D10D74B081943D368C5BFC7C993151479E0DA534BB11B", 2.0);

  return var_6;
}

_id_1302E() {
  scripts\mp\killstreaks\sentry_gun_mp::sentryturret_initsentrysettings();

  if(isDefined(level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"])) {
    level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].maxhealth = getdvarint("_encstr_A6D7159BB19C7D4C937D6E2BB91D2797EBA1B20B8DE886", 750);
    level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].spinuptime = getdvarfloat("_encstr_A3D119F720731F62ADE08A0750995BF17E387367A04B884BF38117", 1.0);
    level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].timeout = getdvarint("_encstr_BD99179B6C9CBE269CEBB959B93A93F2AFB14B99B28E5AB52B", 90);
    level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].weaponinfo = "_encstr_824611B2BD3DBC6881966B03923A1BA3613818";
  }
}

_id_1302A() {
  if(scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress())
    return 0;

  if(scripts\cp_mp\utility\killstreak_utility::unsetobjectivemarker(self getcurrentweapon()))
    return 0;

  return 1;
}