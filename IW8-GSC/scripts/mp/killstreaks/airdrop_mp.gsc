/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\airdrop_mp.gsc
*************************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("airdrop", &scripts\cp_mp\killstreaks\airdrop::tryuseairdropmarkerfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "airdropMultipleInit", &airdrop_airdropmultipleinit);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "registerScoreInfo", &airdrop_registerscoreinfo);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "registerActionSet", &airdrop_registeractionset);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "updateUIProgress", &airdrop_updateuiprogress);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "allowActionSet", &airdrop_allowactionset);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "unresolvedCollisionNearestNode", &airdrop_unresolvedcollisionnearestnode);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "awardKillstreak", &airdrop_awardkillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "showKillstreakSplash", &airdrop_showkillstreaksplash);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "getTargetMarker", &airdrop_gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "airdropMultipleDropCrates", &airdrop_airdropmultipledropcrates);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "outlineDisable", &airdrop_outlinedisable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "captureLootCacheCallback", &airdrop_capturelootcachecallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "isKillstreakBlockedForBots", &airdrop_iskillstreakblockedforbots);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "botIsKillstreakSupported", &airdrop_botiskillstreaksupported);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "applyImmediateJuggernaut", &br_armor_plate_broken_remove);
}

function airdrop_airdropmultipleinit() {
  scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_init();
}

function airdrop_registerscoreinfo() {
  scripts\mp\rank::registerscoreinfo("little_bird", "value", 200);
}

function airdrop_registeractionset() {
  var_0 = getdvarint("scr_airDrop_use_weapon", 1);

  if(var_0) {
    scripts\mp\playeractions::registeractionset("crateUse", ["offhand_weapons", "fire", "melee", "weapon_switch", "killstreaks", "supers"]);
    scripts\mp\playeractions::registeractionset("juggCrateUse", ["offhand_weapons", "weapon", "killstreaks", "supers"]);
    return;
  }

  scripts\mp\playeractions::registeractionset("crateUse", ["offhand_weapons", "weapon", "killstreaks", "supers"]);
}

function airdrop_updateuiprogress(var_0, var_1) {
  scripts\mp\gameobjects::updateuiprogress(var_0, var_1);
}

function airdrop_allowactionset(var_0, var_1) {
  scripts\mp\playeractions::allowactionset(var_0, var_1);
}

function airdrop_unresolvedcollisionnearestnode(var_0, var_1, var_2) {
  childthread scripts\mp\movers::unresolved_collision_nearest_node(var_0, var_1, var_2);
}

function airdrop_awardkillstreak(var_0, var_1, var_2) {
  if(level.gametype == "grnd" || level.gametype == "infect") {
    var_3 = 0;
    var_4 = 0;
    var_5 = var_1;
  } else {
    var_3 = var_5.streakinfo.mpstreaksysteminfo.streaklifeid;
    var_4 = var_5.streakinfo.mpstreaksysteminfo.ref_13913;
    var_5 = var_5.streakinfo.owner;
  }

  thread scripts\mp\killstreaks\killstreaks::awardkillstreak(var_3, "carepackage", var_3, var_4, var_5);
  scripts\mp\utility\stats::incpersstat("carepackagesCaptured", 1);
}

function airdrop_showkillstreaksplash(var_0, var_1, var_2) {
  scripts\mp\hud_message::showkillstreaksplash(var_0, var_1, var_2);
}

function airdrop_gettargetmarker(var_0) {
  return scripts\mp\killstreaks\target_marker::gettargetmarker(var_0);
}

function airdrop_airdropmultipledropcrates(var_0, var_1, var_2, var_3, var_4, var_5) {
  return scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates(var_0, var_1, var_2, var_3, var_4, var_5);
}

function airdrop_outlinedisable(var_0, var_1) {
  scripts\mp\utility\outline::outlinedisable(var_0, var_1);
}

function airdrop_capturelootcachecallback() {
  return &scripts\mp\gametypes\plunder::capturelootcachecallback;
}

function airdrop_iskillstreakblockedforbots(var_0) {
  return scripts\mp\bots\bots_killstreaks::iskillstreakblockedforbots(var_0);
}

function airdrop_botiskillstreaksupported(var_0) {
  return scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var_0);
}

function br_armor_plate_broken_remove(var_0) {
  var_1 = "juggernaut";
  var_2 = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(var_1);
  var_2.madeavailabletime = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var_2.streaklifeid = self.lifeid;
  var_2.ref_13913 = self.matchdatalifeindex;
  var_2.owner = self;
  var_2.ref_121B0 = self getxuid();
  var_2.attackerisinflictor = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  scripts\mp\analyticslog::logevent_killstreakactivated(self, var_2.streaklifeid, var_2.streakname, var_2.isgimme, var_2.attackerisinflictor, self.origin);
  scripts\mp\killstreaks\killstreaks::combatrecordkillstreakuse(var_1);
  scripts\mp\utility\dialog::playkillstreakusedialog(var_1);
  var_3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_1, self);
  var_3.mpstreaksysteminfo = var_2;
  scripts\cp_mp\killstreaks\juggernaut::tryusejuggernautfromstruct(var_3, var_0);
}