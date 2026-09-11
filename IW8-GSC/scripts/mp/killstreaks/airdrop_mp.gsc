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
  var0 = getdvarint("scr_airDrop_use_weapon", 1);

  if(var0) {
    scripts\mp\playeractions::registeractionset("crateUse", ["offhand_weapons", "fire", "melee", "weapon_switch", "killstreaks", "supers"]);
    scripts\mp\playeractions::registeractionset("juggCrateUse", ["offhand_weapons", "weapon", "killstreaks", "supers"]);
    return;
  }

  scripts\mp\playeractions::registeractionset("crateUse", ["offhand_weapons", "weapon", "killstreaks", "supers"]);
}

function airdrop_updateuiprogress(var0, var1) {
  scripts\mp\gameobjects::updateuiprogress(var0, var1);
}

function airdrop_allowactionset(var0, var1) {
  scripts\mp\playeractions::allowactionset(var0, var1);
}

function airdrop_unresolvedcollisionnearestnode(var0, var1, var2) {
  childthread scripts\mp\movers::unresolved_collision_nearest_node(var0, var1, var2);
}

function airdrop_awardkillstreak(var0, var1, var2) {
  if(level.gametype == "grnd" || level.gametype == "infect") {
    var3 = 0;
    var4 = 0;
    var5 = var1;
  } else {
    var3 = var5.streakinfo.mpstreaksysteminfo.streaklifeid;
    var4 = var5.streakinfo.mpstreaksysteminfo.ref_13913;
    var5 = var5.streakinfo.owner;
  }

  thread scripts\mp\killstreaks\killstreaks::awardkillstreak(var3, "carepackage", var3, var4, var5);
  scripts\mp\utility\stats::incpersstat("carepackagesCaptured", 1);
}

function airdrop_showkillstreaksplash(var0, var1, var2) {
  scripts\mp\hud_message::showkillstreaksplash(var0, var1, var2);
}

function airdrop_gettargetmarker(var0) {
  return scripts\mp\killstreaks\target_marker::gettargetmarker(var0);
}

function airdrop_airdropmultipledropcrates(var0, var1, var2, var3, var4, var5) {
  return scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates(var0, var1, var2, var3, var4, var5);
}

function airdrop_outlinedisable(var0, var1) {
  scripts\mp\utility\outline::outlinedisable(var0, var1);
}

function airdrop_capturelootcachecallback() {
  return &scripts\mp\gametypes\plunder::capturelootcachecallback;
}

function airdrop_iskillstreakblockedforbots(var0) {
  return scripts\mp\bots\bots_killstreaks::iskillstreakblockedforbots(var0);
}

function airdrop_botiskillstreaksupported(var0) {
  return scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var0);
}

function br_armor_plate_broken_remove(var0) {
  var1 = "juggernaut";
  var2 = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(var1);
  var2.madeavailabletime = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var2.streaklifeid = self.lifeid;
  var2.ref_13913 = self.matchdatalifeindex;
  var2.owner = self;
  var2.ref_121b0 = self getxuid();
  var2.attackerisinflictor = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  scripts\mp\analyticslog::logevent_killstreakactivated(self, var2.streaklifeid, var2.streakname, var2.isgimme, var2.attackerisinflictor, self.origin);
  scripts\mp\killstreaks\killstreaks::combatrecordkillstreakuse(var1);
  scripts\mp\utility\dialog::playkillstreakusedialog(var1);
  var3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var1, self);
  var3.mpstreaksysteminfo = var2;
  scripts\cp_mp\killstreaks\juggernaut::tryusejuggernautfromstruct(var3, var0);
}