/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\deployablebox_vest.gsc
*************************************************/

init() {
  var_0 = spawnStruct();
  var_0.id = "_encstr_B63910C82B831BDEBCB0261BCAD7CE95E6E8";
  var_0.weaponinfo = "_encstr_823D1A21FA6B91D8C0F95551E5A1D8ED9F03DE8802CB5AF05AEF4361";
  var_0.modelbase = "_encstr_AB11181C39DE83F5892C368D2D9B8ED2B1FACE95E63ABED2DDC6";
  var_0.modelbombsquad = "_encstr_86262203AA2FC8BF1A0B28F8490BBB4B66C1D387C621BF6073C7E94890222DC78FFBA949";
  var_0.hintstring = &"_encstr_AF8525B95743815FB9AF8F4E01BAFEE1B9A5C3E998249B37A36497C792671019E6138309489B21";
  var_0.capturingstring = &"_encstr_B1AC1D9F21594047B391EF2BC15769F524F34974B9D149DB0D255FA34DF714";
  var_0.event = "_encstr_8B4E1646CA07C6DEBC1626D8B2EBCE59E68EAF3A85DA599B";
  var_0.streakname = "_encstr_B63910C82B831BDEBCB0261BCAD7CE95E6E8";
  var_0.splashname = "_encstr_872215BB5E23AAAF79D0C3BB6832491299FD89F3CD77E3";
  var_0.shadername = "_encstr_A2A021367BD61C583737AFF6989AC17BA537A3D7232B0EC6DE5EAF33394B59CD8C8D2F";
  var_0.headiconoffset = 20;
  var_0.lifespan = 90.0;
  var_0.usexp = 50;
  var_0.scorepopup = "_encstr_97500F8CB2DCA339DEE5958CF53B95CD47";
  var_0.vodestroyed = "_encstr_8D5319A2A76B45D85A8978364F36CD2843F9AFCBB3534B5FA032C3";
  var_0.deployedsfx = "_encstr_A7991469C2293579A31B399827D8104F132F55F81BA2";
  var_0.onusesfx = "_encstr_A3C80F4AF0E9DFB1709519F44369C36705";
  var_0.onusecallback = ::onusedeployable;
  var_0.canusecallback = ::canusedeployable;
  var_0.usetime = 1000;
  var_0.maxhealth = 220;
  var_0.damagefeedback = "_encstr_8DB40F9279EF6B05282B9294CBF18EA79C";
  var_0.deathvfx = loadfx("_encstr_8843337DF690F2335F0F908643CFF7E86F5BF1EFD7BD502873F2728E3AA720D042A9673F0562B043137A299073776D709A76C535B0");
  var_0.allowmeleedamage = 1;
  var_0.allowgrenadedamage = 0;
  var_0.maxuses = 4;
  var_0.canuseotherboxes = 0;
  level.boxsettings["_encstr_B63910C82B831BDEBCB0261BCAD7CE95E6E8"] = var_0;
  level.deployable_box["_encstr_B63910C82B831BDEBCB0261BCAD7CE95E6E8"] = [];
}

tryusedeployablevest(var_0, var_1) {
  var_2 = scripts\mp\killstreaks\deployablebox::begindeployableviamarker(var_0, "_encstr_B63910C82B831BDEBCB0261BCAD7CE95E6E8");

  if(!isDefined(var_2) || !var_2)
    return 0;

  scripts\common\utility::_id_13E0A(level._id_11B2A, "_encstr_B63910C82B831BDEBCB0261BCAD7CE95E6E8", self.origin);
  return 1;
}

canusedeployable(var_0) {
  return !scripts\mp\lightarmor::haslightarmor(self);
}

onusedeployable(var_0) {
  scripts\mp\perks\perkfunctions::setlightarmor();
}

get_adjusted_armor(var_0, var_1) {
  if(var_0 + level.deployablebox_vest_rank[var_1] > level.deployablebox_vest_max)
    return level.deployablebox_vest_max;

  return var_0 + level.deployablebox_vest_rank[var_1];
}