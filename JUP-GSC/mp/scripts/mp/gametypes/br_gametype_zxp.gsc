/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_gametype_zxp.gsc
*******************************************************/

#using script_294dda4a4b00ffe3;
#using script_5bab271917698dc4;
#using script_f820c96419fe887;
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\gestures;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\class;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_gametype_zxp;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\gametypes\br_skydive_protection;
#using scripts\mp\gametypes\br_utility;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\gametypes\common;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerlogic;
#using scripts\mp\supers\super_deadsilence;
#using scripts\mp\teams;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#namespace br_gametype_zxp;

function main() {
  level.var_cdc15ee14362fbf = &scripts\mp\gametypes\br_gametype_zxp::init;
  scripts\mp\gametypes\br::main();
  level thread initdialog();
}

function init() {
  scripts\mp\gametypes\br_gametypes::disablefeature("gulag");
  scripts\mp\gametypes\br_gametypes::disablefeature("randomizeCircleCenter");
  scripts\mp\gametypes\br_gametypes::disablefeature("planeSnapToOOB");
  scripts\mp\gametypes\br_gametypes::disablefeature("match_start_VO");

  if(getdvarint(@ "hash_c7f6b4289dec1b29", 1) != 0) {
    scripts\mp\gametypes\br_gametypes::disablefeature("littleBirdSpawns");
  }

  scripts\mp\gametypes\br_gametypes::enablefeature("planeUseCircleRadius");
  scripts\mp\gametypes\br_gametypes::enablefeature("circleEarlyStart");
  level.var_1fa2a6b50267656a = &allowimpactvehicledamage;
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerShouldRespawn", &playershouldrespawn);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("createC130PathStruct", &createc130pathstruct);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("addToC130Infil", &addtoc130infil);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerSkipLootPickup", &playerskiplootpickup);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerSkipKioskUse", &playerskipkioskuse);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onPlayerKilled", &onplayerkilled);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("vipRespawnPlayer", &function_8e4317f4e78b9488);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("circleTimerNext", &circletimernext);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("markPlayerAsEliminatedOnKilled", &markplayeraseliminatedonkilled);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerKilledSpawn", &playerkilledspawn);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("addToTeamLives", &addtoteamlives);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("removeFromTeamLives", &removefromteamlives);

  if(!scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerWelcomeSplashes", &playerwelcomesplashes);
  }

  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("allowMeleeVehicleDamage", &allowmeleevehicledamage);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerNakedDropLoadout", &playernakeddroploadout);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("dropOnPlayerDeath", &droponplayerdeath);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("shouldLastStandDamageScale", &shouldlaststanddamagescale);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("exfilStart", &exfilstart);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("gulagWinnerRespawn", &gulagwinnerrespawn);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onPlayerConnect", &onplayerconnect);
  utility::registersharedfunc("zxp", "packClientMatchData", &packclientmatchdata);
  utility::registersharedfunc("zxp", "isZombieRoyaleZombie", &iszombieroyalezombie);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("remainingPlayersAliveOnTeam", &namespace_27c39fecb94c2a6d::remainingplayersaliveonteam);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("spawnHandled", &namespace_27c39fecb94c2a6d::spawnhandled);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("mayConsiderPlayerDead", &namespace_27c39fecb94c2a6d::mayconsiderplayerdead);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("modifyPlayerDamage", &namespace_27c39fecb94c2a6d::modifyplayerdamage);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("modifyVehicleDamage", &namespace_27c39fecb94c2a6d::modifyvehicledamage);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("ignoreVehicleExplosiveDamage", &namespace_27c39fecb94c2a6d::ignorevehicleexplosivedamage);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("regenHealthAdd", &namespace_27c39fecb94c2a6d::playerregenhealthadd);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("regenDelaySpeed", &namespace_27c39fecb94c2a6d::playerregendelayspeed);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("postUpdateGameEvents", &namespace_27c39fecb94c2a6d::postupdategameevents);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("lastStandAllowed", &namespace_27c39fecb94c2a6d::laststandallowed);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("kioskRevivePlayer", &namespace_27c39fecb94c2a6d::kioskreviveplayer);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onPlayerDamaged", &namespace_27c39fecb94c2a6d::onplayerdamaged);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("endGame", &namespace_27c39fecb94c2a6d::function_330f2255da6b470);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("isValidSpectateTarget", &namespace_27c39fecb94c2a6d::isvalidspectatetarget);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("canTakePickupLoot", &namespace_27c39fecb94c2a6d::cantakepickuploot);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("filterDamage", &namespace_27c39fecb94c2a6d::filterdamage);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("compareTeamHigherScore", &namespace_27c39fecb94c2a6d::sortbylastzombietime);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onDeadEvent", &namespace_27c39fecb94c2a6d::ondeadevent);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onEliminatedTeamsRespawn", &namespace_27c39fecb94c2a6d::oneliminatedteamsrespawn);

  utility::registersharedfunc("<dev string:x1c>", "<dev string:x23>", &runcommand);

  if(level.script == "<dev string:x35>") {
    setdvarifuninitialized(@ "hash_9c4658bfbe5e2b39", 0);
    setdvarifuninitialized(@ "hash_9ec879d1dafa798b", 0);
    setdvarifuninitialized(@ "hash_5bb9da56e8fc0f3f", -1);
  }

  level.brgametype.var_aa2243b8e5933bf0 = getdvarint(@ "hash_f86d972e7588520", 0);
  level.brgametype.zombiekilledlootcachecount = 0;
  level.brgametype.var_67d3b7cefcb15cd = getdvarint(@ "hash_4673d84307b77b28", 1);
  level.brgametype.humanpowersenabled = getdvarint(@ "hash_64f5b71a90f71b0b", 0);
  level.brgametype.var_fe5b4c3def3b21d9 = getdvarint(@ "hash_9f0c717fe5771d0e", 1);
  level.brgametype.var_8a2701db21ded0bc = getdvarint(@ "hash_a61c509770f58d52", 2);
  level.brgametype.var_5fc0811cb9626ef0 = getdvarint(@ "hash_823bc5febfcf5512", 1);
  level.brgametype.respawnitems = [];
  level.brgametype.var_664897c80ff2a610 = getdvarint(@ "hash_7995a3c1dca19725", 20);
  level.brgametype.var_593867cbadf91278 = getdvarint(@ "hash_2fca391c375bcea1", 10);
  level.respawnheightoverride = getdvarint(@ "hash_daca869f129dff7", 7500);
  level.brgametype.var_219163d4522e75c9 = getdvarint(@ "hash_6d5aa7ee61b5edc0", 0);
  level.brgametype.var_dcf9974c44eee730 = getdvarint(@ "hash_e61c38b111680647", 0);
  level.brgametype.var_f55be0289e3ef5aa = getdvarint(@ "hash_455dac717f56a2f8", 0);
  level._effect["stim_pickup"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_stim_pickup.vfx");
  namespace_27c39fecb94c2a6d::init();
  thread function_d4b27081237958b4();
  thread initpostmain();
}

function initdialog() {
  level endon("game_ended");
  waitframe();
  level.brgametype.var_c435bc516c8091ca = 1;
  level.brgametype.dialogprefix = "dx_br_bds6_";
  game["dialog"]["deploy_squad_leader"] = "";
  game["dialog"]["match_start"] = "dx_br_brpn_brps_grav_name";
  game["dialog"]["zmb_infil_tutorial_01"] = "dx_br_brpn_brps_grav_boos";
  game["dialog"]["zmb_infil_tutorial_02"] = "dx_br_brpn_brps_grav_ab03";
  game["dialog"]["zmb_back_human"] = "zxp1_wzan_plcr";
  game["dialog"]["zmb_teammate_back_human"] = "zxp1_wzan_tmcr";
  game["dialog"]["zxp_squadCured"] = "dx_br_brpn_brps_grav_ab14";
  game["dialog"]["zxp_lastAlive"] = "dx_br_brpn_brps_grav_ab12";
  game["dialog"]["zmb_player_into_zombie"] = "dx_br_brpn_brps_grav_ab18";
  game["dialog"]["zmb_teammate_into_zombie"] = "dx_br_brpn_brps_grav_ab09";
  game["dialog"]["last_human_alive"] = "dx_br_brpn_brps_grav_ab17";
  game["dialog"]["loot_syringe_01"] = "dx_br_brpn_brps_grav_ab15";
  game["dialog"]["loot_syringe_02"] = "dx_br_brpn_brps_grav_ab16";
  game["dialog"]["loot_syringe_03"] = "dx_br_brpn_brps_grav_ab13";
  game["dialog"]["dead_reminder"] = "dx_br_brpn_brps_grav_ab19";
  game["dialog"]["infil_ac130_5_seconds"] = "zxp1_ldms_zmdr";
  game["dialog"]["zxp_infestationStart"] = "dx_br_brpn_brps_grav_ab04";
  game["dialog"]["zxp_infestationTimerHalf"] = "dx_br_brpn_brps_grav_ab07";
  game["dialog"]["zxp_infestationTimerLow"] = "dx_br_brpn_brps_grav_ab05";
  game["dialog"]["zxp_playerRevive"] = "dx_br_brpn_brps_grav_ab10";
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("zombieDialog_tryLastHumanAlive", &function_b7ba0e456d366ce0);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("zombieDialog_respawnAsZombie", &function_17faa3b3fa0fe88d);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("zombieDialog_lootSyringe", &function_441a6c6ffaa18dde);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("zombieDialog_playerRevived", &function_c99c402a4b8728d5);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("allowImpactVehicleDamage", &function_441a6c6ffaa18dde);
}

function initpostmain() {
  waittillframeend();

  if(level.brgametype.var_aa2243b8e5933bf0) {
    thread circlesetup();
  }

  thread setupzombierespawnglobaltimer();
  thread setuphumanpowers();
  thread setdropbagdelay();

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    thread namespace_27c39fecb94c2a6d::function_e4cffb22a28408e2();
    scripts\mp\gametypes\br_pickups::registerpickupcreatedcallback("brloot_zmb_stim", &function_d22ff024b17335f9);
    scripts\mp\gametypes\br_pickups::function_c3e1679f348a5e40(&function_231de05cf1cbadb9);
  }
}

function playerwelcomesplashes() {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;

  if(!istrue(level.br_infils_disabled)) {
    self waittill("joining_Infil");
  } else {
    level waittill("prematch_done");
  }

  scripts\mp\gametypes\br_public::brleaderdialog("match_start", 0, undefined, 0, 0);
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_zxp_mode_intro", undefined, undefined, undefined, undefined, "splash_list_iw9_br_zxp");
  wait 1;
  scripts\mp\gametypes\br_public::brleaderdialog("zmb_infil_tutorial_01", 0, undefined, 0, 0);
  scripts\mp\gametypes\br_analytics::branalytics_landing(self);

  if(isalive(self) && !playeriszombie()) {
    thread playerhumanpowers();
  }

  self waittill("br_jump");
  wait 1;
  scripts\mp\gametypes\br_public::brleaderdialogplayer("zmb_infil_tutorial_02", self, 0, 0, 0);
}

function onplayerconnect(player) {
  level endon("game_ended");
  player endon("disconnect");
  scripts\mp\flags::gameflagwait("br_ready_to_jump");
  player.var_ba760cec09a741c8 = gettime();
  player.var_9035b3b19e0298bc = 0;
  player.zombiekills = 0;
}

function packclientmatchdata() {
  packedvalues = [];
  packedvalues[0] = int(min(self.zombiekills, 1023));
  packedvalues[1] = int(min(self.var_9035b3b19e0298bc, 4095));
  return packedvalues;
}

function iszombieroyalezombie() {
  return scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "zxp" && playeriszombie();
}

function setdropbagdelay() {
  var_21be5f4d451efd18 = -15;
  firsttime = scripts\mp\gametypes\br_circle::getcircleclosetime(1);
  firstdefaultval = max(0, firsttime + var_21be5f4d451efd18);
  firstdelay = getdvarfloat(@ "hash_b81b25bcd8c7d749", firstdefaultval);
  scripts\mp\gametypes\br_gametypes::registerbrgametypedata("dropBagDelay", firstdelay);
}

function markplayeraseliminatedonkilled() {
  return namespace_27c39fecb94c2a6d::markplayeraseliminatedonkilled();
}

function playerkilledspawn(deathdata, finaldeath) {
  return namespace_27c39fecb94c2a6d::playerkilledspawn(deathdata, finaldeath);
}

function playershouldrespawn(data) {
  if(!istrue(level.br_prematchstarted)) {
    return 1;
  }

  return playeriszombie();
}

function playerskiplootpickup(instance, bautouse) {
  if(istrue(level.brgametype.var_9dd997ced889b541) && isDefined(instance)) {
    if(isDefined(instance.type) && instance.type == "brloot_zmb_stim") {
      return !playeriszombie();
    } else {
      return (playeriszombie() && !instance scriptableislootcache());
    }

    return;
  }

  return playeriszombie();
}

function playerskipkioskuse(instance) {
  return playeriszombie();
}

function shouldlaststanddamagescale(data) {
  var_7bfcad6985f865ac = isPlayer(data.attacker) && data.attacker playeriszombie();
  var_8d6deeb9c425ce1b = isPlayer(data.victim) && data.victim playeriszombie();

  if(var_7bfcad6985f865ac && !var_8d6deeb9c425ce1b && data.meansofdeath == "MOD_MELEE") {
    return false;
  }

  return true;
}

function allowmeleevehicledamage(data) {
  var_7bfcad6985f865ac = isPlayer(data.attacker) && data.attacker playeriszombie();
  return var_7bfcad6985f865ac;
}

function function_cd17fd9df37e3def() {
  endtime = gettime() + 3000;

  while(self isgestureplaying() && endtime > gettime()) {
    self stopgestureviewmodel();
    waitframe();
  }

  while(endtime > gettime() && (self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self[[utility::getsharedfunc("player", "isPlayerADS")]]())) {
    waitframe();
  }

  self enableoffhandweapons();
  self giveandfireoffhand("stim_zmb_mp");
  wait 0.5;
}

function function_172ca8a9c3a0981d(value) {
  self allowfire(value);
  self allowmovement(value);
  self allowmelee(value);

  if(value) {
    self playershow();
    self enableoffhandweapons();
    return;
  }

  self playerhide();
  self disableoffhandweapons();
}

function playerzombiebacktohuman(force) {
  level endon("game_ended");

  if(!istrue(force) && !playeriszombie()) {
    return;
  }

  streamorigin = self.origin;
  spawnorigin = self.origin;
  spawnangles = self getplayerangles();
  spawninplace = 0;

  if(level.brgametype.humanspawninair) {
    [spawnorigin, spawnangles, streamorigin] = function_1d81091658f53612();
  } else {
    [spawnorigin, spawnangles, spawninplace] = function_1a67db35424bf909();
    streamorigin = spawnorigin;
  }

  self setscriptablepartstate("zombie", "off");
  self setscriptablepartstate("compassicon", "defaulticon");
  self setscriptablepartstate("skydiveVfx", "default", 0);
  playFX(getfx("zombie_trans"), self.origin);
  self notify("endSuperJumpFov");
  function_172ca8a9c3a0981d(0);

  if(!istrue(force)) {
    function_cd17fd9df37e3def();
  }

  self lerpfovbypreset("default_2seconds");

  if(level.brgametype.var_63d9be743a6ba8cd) {
    thread scripts\mp\supers\super_deadsilence::superdeadsilence_endhudsequence();
  }

  if(level.brgametype.zombievision) {
    namespace_27c39fecb94c2a6d::function_234906f719267cd4();

    if(!level.brgametype.var_63d9be743a6ba8cd) {
      self setscriptablepartstate("headVFX", "neutral");
    }

    self.var_54e863ebad3e233 = undefined;
    scripts\mp\utility\player::restorebasevisionset(2);
  }

  if(!istrue(force)) {
    wait 1.5;
  }

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    if(!spawninplace) {
      namespace_8bfdb6eb5a3df67a::function_334a8fe67e88bbe7();
      wait 1;
    }

    self notify("zombie_back_to_player");
  }

  var_eea48e381591a294 = playeriszombie() || istrue(self.var_b106546c4418e645);
  namespace_27c39fecb94c2a6d::playersetiszombie(0);
  namespace_27c39fecb94c2a6d::playerzombiestatechange(0);

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self function_555e2d32e2756625("female");
  } else {
    self function_555e2d32e2756625("");
  }

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.clothtype) && self.operatorcustomization.clothtype != "") {
    self setclothtype(self.operatorcustomization.clothtype);
  } else {
    self setclothtype("vestlight");
  }

  self.operatorcustomization = undefined;
  scripts\cp_mp\execution::_clearexecution();
  self.respawningbr = 1;
  self.plotarmor = 1;

  if(isDefined(self.team)) {
    scripts\mp\gametypes\br_quest_util::displaysquadmessagetoteam(self.team, self, 14, 1);
  }

  if(!spawninplace && !scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    namespace_8bfdb6eb5a3df67a::function_334a8fe67e88bbe7();
    wait 1;
  } else {
    waitframe();
  }

  scripts\mp\gametypes\br_utility::unmarkplayeraseliminated(self, "zombieRevived");
  namespace_27c39fecb94c2a6d::function_c53d906a08ed3e87();
  scripts\mp\class::loadout_emptycacheofloadout("gamemode");
  self.pers["gamemodeLoadout"] = level.br_loadouts["default"];
  self.pers["class"] = "gamemode";
  self.class = "gamemode";
  self.forcespawnangles = spawnangles;
  self.forcespawnorigin = streamorigin;
  _setsuit("iw9_defaultsuit_mp");
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  thread scripts\mp\gametypes\br::br_displayperkinfo();
  function_172ca8a9c3a0981d(1);
  self enableexecutionvictim();

  if(level.brgametype.humanspawninair) {
    self.plotarmor = undefined;
    namespace_27c39fecb94c2a6d::playerstreamwaittillcomplete(spawnorigin, spawnangles, streamorigin);
  } else {
    if(!spawninplace) {
      scripts\mp\gametypes\br_public::playerwaittillstreamhintcomplete();
      scripts\mp\gametypes\br_public::playerclearstreamhintorigin();
      playFX(getfx("zombie_trans"), self.origin);
    }

    if(!spawninplace) {
      namespace_8bfdb6eb5a3df67a::function_e68e4bb4f65f5fe4();
    }

    thread function_5855e4b39bae3587();
  }

  if(istrue(level.brgametype.var_5fc0811cb9626ef0) && namespace_27c39fecb94c2a6d::function_6ece6988ecaf0ea7()) {
    playerloadoutrestore();
  } else {
    loadoutindex = scripts\mp\gametypes\br::brgetloadoutoptionstandardloadoutindex();
    scripts\mp\gametypes\br::givestandardtableloadout(loadoutindex, 0);
  }

  var_968bd61837a9c038 = getdvarint(@ "hash_3c87ccc2c15b53a4", 100);
  respawnreserveplates = getdvarint(@ "hash_8b8e8245086efdd1", 0);
  scripts\cp_mp\armor::givestartingarmor(var_968bd61837a9c038, undefined, respawnreserveplates);
  thread scripts\mp\gametypes\br::br_displayperkinfo();
  namespace_27c39fecb94c2a6d::function_fd7bdffe7cea51ed(0);

  if(istrue(level.var_3ff7c73209fcf59d)) {
    scripts\mp\gametypes\br_skydive_protection::initprotection();
  }

  scripts\common\swim_common::function_ef73345010f390f4();

  if(var_eea48e381591a294) {
    scripts\mp\hud_message::showsplash("br_gametype_zxp_change_human", undefined, undefined, undefined, undefined, "splash_list_iw9_br_zxp");
    scripts\mp\gametypes\br_public::brleaderdialogplayer("zmb_back_human", self, 0, 0, 0, undefined, level.brgametype.dialogprefix);
  }

  self.plotarmor = undefined;
  thread playerhumanhitground();
  self.respawningbr = undefined;
  self.var_ba760cec09a741c8 = gettime();

  if(var_eea48e381591a294) {
    foreach(teammate in level.teamdata[self.team]["players"]) {
      if(self != teammate) {
        scripts\mp\gametypes\br_public::brleaderdialogplayer("zmb_teammate_back_human", teammate, 0, 0, 0, undefined, level.brgametype.dialogprefix);
      }
    }
  }

  var_89b42c040dcaf62a = 0;
  var_ffc368c1d2a95b7b = 0;

  foreach(teammate in level.teamdata[self.team]["players"]) {
    if(teammate playeriszombie()) {
      var_89b42c040dcaf62a++;
    }

    if(teammate isreallyalive()) {
      var_ffc368c1d2a95b7b++;
    }
  }

  if(level.teamdata[self.team]["players"].size > 1 && var_89b42c040dcaf62a <= 0) {
    foreach(teammate in level.teamdata[self.team]["players"]) {
      scripts\mp\gametypes\br_public::brleaderdialogplayer("zxp_squadCured", teammate, 0, 0, 0);
    }
  }

  if(var_ffc368c1d2a95b7b == 1) {
    if(isreallyalive()) {
      scripts\mp\gametypes\br_public::brleaderdialogplayer("zxp_lastAlive", self, 0, 0, 0);
    }
  }
}

function function_1d81091658f53612() {
  streamtimeout = scripts\mp\gametypes\br_public::getdefaultstreamhinttimeoutms() / 1000;
  spawnpoint = namespace_8bfdb6eb5a3df67a::playergetrespawnpoint(0, streamtimeout);
  streamorigin = namespace_8bfdb6eb5a3df67a::playerprestreamrespawnorigin(spawnpoint);
  return [spawnpoint.origin, spawnpoint.angles, streamorigin];
}

function function_1a67db35424bf909() {
  [spawnorigin, spawnangles, spawninplace] = function_afbd524fec2f5ec0();

  if(!spawninplace) {
    scripts\mp\gametypes\br_public::playerstreamhintlocation(spawnorigin);
  }

  return [spawnorigin, spawnangles, spawninplace];
}

function function_afbd524fec2f5ec0() {
  var_72541f27d0911a16 = 500;
  var_ddb70f36e908d6d9 = 10000;
  const_attempts = 5;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent)) {
    return [self.origin, self getplayerangles(), 1];
  }

  dangerradius = scripts\mp\gametypes\br_circle::getdangercircleradius();
  dangerorigin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_2db625e063f40b4 = distance2dsquared(self.origin, dangerorigin);

  if(var_2db625e063f40b4 <= dangerradius * dangerradius) {
    return [self.origin, self getplayerangles(), 1];
  }

  startorigin = undefined;
  spawnangles = undefined;
  var_ac2e1efdf095af8c = (self.origin[0], self.origin[1], 0);
  dirtoplayer = vectorNormalize(var_ac2e1efdf095af8c - dangerorigin);

  for(i = 1; i <= const_attempts; i++) {
    distfromcenter = dangerradius - var_72541f27d0911a16 * i;

    if(distfromcenter < 0) {
      break;
    }

    [startorigin, spawnangles] = function_fb6925f5e828580d(dangerorigin, dirtoplayer, distfromcenter);

    if(isDefined(startorigin)) {
      break;
    }
  }

  if(!isDefined(startorigin)) {
    startorigin = dangerorigin;
    spawnangles = self getplayerangles();
  }

  spawnorigin = scripts\mp\gametypes\br_public::droptogroundmultitrace(startorigin, var_ddb70f36e908d6d9);
  return [spawnorigin, spawnangles, 0];
}

function function_fb6925f5e828580d(origin, dir, dist) {
  startorigin = origin + dir * dist;
  streamtimeout = scripts\mp\gametypes\br_public::getdefaultstreamhinttimeoutms() / 1000;

  if(namespace_8bfdb6eb5a3df67a::function_61b5424aa3fe974e(startorigin, streamtimeout)) {
    spawnangles = vectortoangles(dir * -1);
    return [startorigin, spawnangles];
  }

  return [undefined, undefined];
}

function playerhumanhitground() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_set");

  while(!self isonground()) {
    waitframe();
  }

  thread playerhumanpowers();
}

function playerloadoutrestore() {
  self takeallweapons(0, 1);
  scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
  self.equipment["primary"] = undefined;
  self.equipment["secondary"] = undefined;
  self.equipment["health"] = undefined;
  self.equipment["super"] = undefined;
  fists = makeweapon("iw8_fists_mp");

  if(self.var_45f93a3ba26bd0b7.primaries.size < 2) {
    self giveweapon(fists);
  }

  var_cf6837e74d470965 = 0;

  foreach(weaponobj in self.var_45f93a3ba26bd0b7.primaries) {
    weaponname = getcompleteweaponname(weaponobj);

    if(scripts\cp_mp\weapon::isbackuppistol(weaponobj)) {
      self giveweapon(weaponobj, 0, 0, 0, 1, 1);
    } else {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(weaponobj);
    }

    if(!var_cf6837e74d470965) {
      self assignweaponprimaryslot(weaponname);
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(weaponobj);
      var_cf6837e74d470965 = 1;
    }

    scripts\cp_mp\weapon::fixupplayerweapons(self, weaponname);
  }

  foreach(offhandobj in self.var_45f93a3ba26bd0b7.offhands) {
    equipref = scripts\mp\equipment::getequipmentreffromweapon(offhandobj);

    if(!isDefined(equipref)) {
      continue;
    }

    slot = self.var_45f93a3ba26bd0b7.equipslots[equipref];

    if(!isDefined(slot)) {
      continue;
    }

    scripts\mp\equipment::giveequipment(equipref, slot);
  }

  foreach(weaponname, ammo in self.var_45f93a3ba26bd0b7.ammostock) {
    self setweaponammostock(weaponname, ammo);
    weaponobj = makeweapon(getweaponbasename(weaponname));
    weaponammotype = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(weaponobj);

    if(isDefined(weaponammotype)) {
      self.br_ammo[weaponammotype] = ammo;
      scripts\mp\gametypes\br_weapons::br_ammo_player_hud_update_ammotype(weaponammotype);
    }
  }

  foreach(weaponname, ammo in self.var_45f93a3ba26bd0b7.ammoclip) {
    self setweaponammoclip(weaponname, ammo);
  }

  foreach(weaponname, ammo in self.var_45f93a3ba26bd0b7.ammoclipleft) {
    self setweaponammoclip(weaponname, ammo, "left");
  }

  waitframe();
  var_b8f86333b805d701 = fists;

  if(isDefined(self.var_45f93a3ba26bd0b7.current) && self.var_45f93a3ba26bd0b7.current != makeweapon("none")) {
    var_b8f86333b805d701 = self.var_45f93a3ba26bd0b7.current;
  }

  self switchtoweaponimmediate(var_b8f86333b805d701);

  if(isDefined(self.var_45f93a3ba26bd0b7.super)) {
    superref = level.br_pickups.br_superreference[level.br_pickups.br_equipnametoscriptable[self.var_45f93a3ba26bd0b7.super]];
    scripts\mp\gametypes\br_pickups::forcegivesuper(superref, 0);
  }

  thread scripts\cp_mp\gestures::tryreenablescriptablevfx();
  self.var_45f93a3ba26bd0b7 = undefined;
}

function addtoteamlives(player, team) {
  player namespace_27c39fecb94c2a6d::addtoteamlives(player, team);
}

function removefromteamlives(player, team) {
  player namespace_27c39fecb94c2a6d::removefromteamlives(player, team);
}

function gulagwinnerrespawn(player) {
  if(level.brgametype.var_5fc0811cb9626ef0 && namespace_27c39fecb94c2a6d::function_6ece6988ecaf0ea7()) {
    playerloadoutrestore();
  }
}

function function_536210a44b407bf4() {
  self.itemsdropped = 0;
  index = level.brgametype.zombiekilledlootcachecount % 10;
  level.brgametype.zombiekilledlootcachecount++;
  var_60eea229f65480a = ter_op(isPlayer(self), "zombie_death", "zombie_agent_death");
  items = getscriptcachecontents(var_60eea229f65480a, index);

  if(isDefined(items)) {
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    pickupents = scripts\mp\gametypes\br_lootcache::lootspawnitemlist(dropstruct, items, 0);
  }
}

function playernakeddroploadout() {
  if(playeriszombie()) {
    return;
  }

  scripts\mp\gametypes\br::nakeddrophandleloadout();
}

function droponplayerdeath(attacker) {
  if(playeriszombie()) {
    return true;
  }

  if(level.brgametype.var_5fc0811cb9626ef0) {
    namespace_27c39fecb94c2a6d::function_10ffa1071b1c2681();
  }

  return false;
}

function onplayerkilled(deathdata) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  if(level.gameended) {
    return;
  }

  victim = deathdata.victim;
  attacker = deathdata.attacker;

  if(!isDefined(attacker) || !isPlayer(attacker) || !isDefined(victim)) {
    return;
  }

  if(victim function_5b11d4c1dcfb5c70(attacker, deathdata.meansofdeath)) {
    victim thread function_87aa367a0fc501cd(victim, attacker);
  }

  if(istrue(level.brgametype.var_fe5b4c3def3b21d9) && victim function_3406e94db80d3df1(attacker)) {
    victim thread function_d4881e5a408d9c4a(victim, attacker);
  }

  if(victim shouldspawnloot(attacker)) {
    victim thread function_536210a44b407bf4();
  }

  var_36bc58bb63dbffbe = istrue(attacker.buffed);
  var_598687918805b282 = istrue(attacker.var_92b4c28f6870ce5);
  var_3cb1bd50d2032642 = 0;
  var_7bfcad6985f865ac = attacker playeriszombie();
  var_8d6deeb9c425ce1b = victim playeriszombie() && isPlayer(victim);

  if(!istrue(var_8d6deeb9c425ce1b)) {
    victim.disable_killcam = 1;
  }

  if(attacker function_17d34b7536ee4da5(deathdata)) {
    attacker thread scripts\cp_mp\challenges::oncollectitem("zxp_execution");
    attacker thread scripts\mp\gametypes\br_gametype_zxp::playerzombiebacktohuman(1);
    var_3cb1bd50d2032642 = 1;
  }

  hitloc = deathdata.hitloc;

  if(isDefined(hitloc) && victim playeriszombie() && (hitloc == "head" || hitloc == "helmet")) {
    var_6f0108f13e558e0 = 0;
    attacker thread scripts\cp_mp\damagefeedback::updatedamagefeedback("hitzombieheadshot", var_6f0108f13e558e0, 1);
  }

  if(namespace_c711384b1335919::function_4ad287e0971672a6()) {
    if(victim playeriszombie() && isPlayer(victim)) {
      namespace_c711384b1335919::function_d24f2dd28d26377e(level.brgametype.var_dcf9974c44eee730);

      if(!namespace_c711384b1335919::function_989d407ad1798eb0()) {
        thread scripts\mp\gametypes\br_public::brleaderdialogplayer("dead_reminder", victim, 0, 1, 1);
      }
    } else if(!victim playeriszombie() && (attacker playeriszombie() || isagent(attacker) && isDefined(attacker.zombietype))) {
      namespace_c711384b1335919::function_d24f2dd28d26377e(-1 * level.brgametype.var_219163d4522e75c9);
    }
  }

  if(victim playeriszombie() && isPlayer(victim) && scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    attacker.zombiekills++;
    attacker scripts\mp\gametypes\br_public::updatebrscoreboardstat("zombieKills", attacker.zombiekills);
  }

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    victim function_85ac199ed33991d6();
  }

  victim setscriptablepartstate("skydiveVfx", "default", 0);

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    dlog_recordevent("dlog_event_zxp_mgl_zombie_player_kill", ["attacker_has_tempered_skin_buff", var_598687918805b282, "attacker_is_zombie", var_7bfcad6985f865ac, "is_attacker_execute_auto_respawn", var_3cb1bd50d2032642, "victim_is_zombie", var_8d6deeb9c425ce1b]);
  }
}

function function_85ac199ed33991d6() {
  if(!playeriszombie()) {
    var_445c62598598598c = int((gettime() - self.var_ba760cec09a741c8) * 0.001);

    if(var_445c62598598598c > self.var_9035b3b19e0298bc) {
      self.var_9035b3b19e0298bc = var_445c62598598598c;
      scripts\mp\gametypes\br_public::updatebrscoreboardstat("longestLife", self.var_9035b3b19e0298bc);
    }
  }
}

function function_17d34b7536ee4da5(deathdata) {
  if(!level.brgametype.var_888a368fc494c603) {
    return false;
  }

  if(deathdata.meansofdeath != "MOD_EXECUTION") {
    return false;
  }

  if(deathdata.victim playeriszombie()) {
    return false;
  }

  if(!level.brgametype.var_b8456bbdf46925a3 && istrue(deathdata.victim.inlaststand)) {
    return false;
  }

  if(!deathdata.attacker playeriszombie()) {
    return false;
  }

  return true;
}

function shouldspawndropscommon(attacker, var_7159f30ea8781c0b) {
  if(isDefined(attacker) && attacker == self) {
    return istrue(var_7159f30ea8781c0b);
  }

  if(level.teambased && isDefined(attacker) && isDefined(attacker.team) && attacker.team == self.team) {
    return false;
  }

  if(isDefined(attacker) && !isDefined(attacker.team) && (attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn")) {
    return false;
  }

  if(isagent(self) || isagent(attacker)) {
    return false;
  }

  return true;
}

function shouldspawnloot(attacker) {
  if(!shouldspawndropscommon(attacker)) {
    return false;
  }

  if(!playeriszombie()) {
    return false;
  }

  return true;
}

function function_5b11d4c1dcfb5c70(attacker, meansofdeath) {
  if(!shouldspawndropscommon(attacker, 1)) {
    return false;
  }

  if(playeriszombie()) {
    return false;
  }

  if(meansofdeath == "MOD_EXECUTION" && attacker playeriszombie()) {
    if(!level.brgametype.var_b8456bbdf46925a3 && !istrue(self.inlaststand)) {
      return false;
    }
  }

  return true;
}

function function_d54483159d739a01(var_26784414a3b75d58) {
  if(!isDefined(var_26784414a3b75d58) || !ispointonnavmesh(var_26784414a3b75d58)) {
    return false;
  }

  return true;
}

function function_7fa9a8fb1f8cb5a7(origin, angles, ent, count) {
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

  for(i = 0; i < count; i++) {
    offsetangles = (0, randomfloatrange(0, 360), 0);
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, origin, angles + offsetangles, ent, undefined, 35);

    if(istrue(level.var_9b5a91cce18ad997)) {
      if(!function_d54483159d739a01(dropinfo.origin)) {
        continue;
      }
    }

    scripts\mp\gametypes\br_pickups::spawnpickup("brloot_zmb_stim", dropinfo, 1, 1, undefined, level.brgametype.var_67d3b7cefcb15cd);
  }
}

function function_d22ff024b17335f9() {
  thread function_179b77928ea64469();
}

function function_179b77928ea64469() {
  self.indexstring = "s" + self.index;
  self.criticalitem = 1;
  self.ownerteam = "neutral";

  for(state = self getscriptablepartstate("brloot_zmb_stim"); state != "visible" && state != "delayauto" && state != "noauto"; state = self getscriptablepartstate("brloot_zmb_stim")) {
    waitframe();

    if(!isDefined(self)) {
      return;
    }
  }

  groundorg = scripts\mp\gametypes\br_public::droptogroundmultitrace(self.origin, 30);
  level.brgametype.respawnitems[self.indexstring] = self;
  playsoundatpos(self.origin, "mp_killconfirm_tags_drop");
}

function function_231de05cf1cbadb9() {
  if(isDefined(self.type) && self.type == "brloot_zmb_stim") {
    function_3bbc840fb244d188(self);
  }
}

function function_87aa367a0fc501cd(victim, attacker) {
  var_fd2fee325481dc7f = level.brgametype.var_8a2701db21ded0bc;
  function_7fa9a8fb1f8cb5a7(victim.origin, victim.angles, victim, var_fd2fee325481dc7f);
}

function function_3406e94db80d3df1(attacker) {
  if(!shouldspawndropscommon(attacker, 1)) {
    return false;
  }

  if(playeriszombie() && self.numconsumed > 0) {
    return true;
  }

  return false;
}

function function_d4881e5a408d9c4a(victim, attacker) {
  assert(self.numconsumed > 0);
  function_7fa9a8fb1f8cb5a7(victim.origin, victim.angles, victim, self.numconsumed);
}

function function_3bbc840fb244d188(syringe, var_426ec555fff751be, player) {
  if(isDefined(syringe.indexstring) && isDefined(level.brgametype.respawnitems[syringe.indexstring])) {
    level.brgametype.respawnitems[syringe.indexstring] = undefined;
  }

  playFX(level._effect["stim_pickup"], syringe.origin);

  if(isDefined(player)) {
    player playsoundtoplayer("zmb_pickup_syringe", player);
    player thread scripts\mp\utility\points::giveunifiedpoints("br_syringe_looted");
  }

  syringe notify("remove_syringes");

  if(isDefined(syringe.var_1ba53aa427c5162c)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(syringe.var_1ba53aa427c5162c);
    scripts\mp\objidpoolmanager::returnobjectiveid(syringe.var_1ba53aa427c5162c);
  }

  if(istrue(var_426ec555fff751be)) {
    syringe scripts\mp\gametypes\br_pickups::deletescriptableinstance(1);
  }
}

function onuse(player) {
  namespace_27c39fecb94c2a6d::onuse(player);
}

function circletimernext(circleindex) {
  if(istrue(level.brgametype.zombierespawning)) {
    if(getdvarint(@ "hash_26476f821df5d01f", 0) == 0) {
      return;
    }

    var_837f5b5677adc8fe = scripts\mp\gametypes\br_gulag::getgulagclosedcircleindex();

    if(circleindex >= var_837f5b5677adc8fe) {
      level.brgametype.zombierespawning = 0;
    }
  }
}

function setupzombierespawnglobaltimer() {
  if(istrue(level.br_circle_disabled)) {
    return;
  }

  if(getdvarint(@ "hash_26476f821df5d01f", 0) == 0) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_fade_done");
  const_font = "hudsmall";
  var_3c99de187802df31 = 0.8;
  var_9f83fcc7a160f4e6 = -100;
  var_ecf4e1d902a24c73 = -290;
  var_1461ce6f6b22e869 = 90;
  var_2948ca54731de34f = scripts\mp\gametypes\br_gulag::gettimetogulagclosed();
  var_ad40392184f37bac = createhudelem(const_font, var_3c99de187802df31);
  var_ad40392184f37bac scripts\mp\hud_util::setpoint("RIGHT", "CENTER", var_ecf4e1d902a24c73, var_9f83fcc7a160f4e6);
  var_ad40392184f37bac.label = &"MP_ZXP/RESPAWN_ALLOWED";
  var_32e699637bc9c0bb = scripts\mp\hud_util::createservertimer(const_font, var_3c99de187802df31);
  var_32e699637bc9c0bb scripts\mp\hud_util::setpoint("LEFT", "CENTER", var_ecf4e1d902a24c73, var_9f83fcc7a160f4e6);
  var_32e699637bc9c0bb settenthstimer(var_2948ca54731de34f);
  var_fc133e1a9d8063a1 = getdvarint(@ "hash_bf9aaa13e23f04ae", var_1461ce6f6b22e869);
  var_6113fc02b7117903 = var_2948ca54731de34f - var_fc133e1a9d8063a1;

  if(var_6113fc02b7117903 > 0) {
    wait var_6113fc02b7117903;
    var_32e699637bc9c0bb.color = (1, 0, 0);
    var_32e699637bc9c0bb thread namespace_27c39fecb94c2a6d::huddopulse();
    wait var_fc133e1a9d8063a1;
  } else {
    wait var_2948ca54731de34f;
  }

  wait 2;
  var_32e699637bc9c0bb destroy();
  var_ad40392184f37bac destroy();
}

function function_8e4317f4e78b9488(sponsor, var_df2fbb13c226be75) {
  if(!isalive(self) || playeriszombie()) {
    namespace_27c39fecb94c2a6d::kioskreviveplayer(sponsor);
  }
}

function createhudelem(font, fontscale, team) {
  if(isDefined(team)) {
    fontelem = newteamhudelem(team);
  } else {
    fontelem = newhudelem();
  }

  fontelem.elemtype = "font";
  fontelem.font = font;
  fontelem.fontscale = fontscale;
  fontelem.basefontscale = fontscale;
  fontelem.x = 0;
  fontelem.y = 0;
  fontelem.width = 0;
  fontelem.height = int(level.fontheight * fontscale);
  fontelem.xoffset = 0;
  fontelem.yoffset = 0;
  fontelem.children = [];
  fontelem scripts\mp\hud_util::setparent(level.uiparent);
  fontelem.hidden = 0;
  fontelem.alpha = 1;
  return fontelem;
}

function circlesetup() {
  level.br_level.br_circledelaytimes[1] = level.br_level.br_circledelaytimes[0];
  level.br_level.br_circledelaytimes[0] = 1;
  level.br_level.br_circleclosetimes[0] = 1;
  level.br_level.br_circleshowdelaydanger[0] = 1;
}

function createc130pathstruct() {
  assertex(isDefined(level.br_level) && isDefined(level.br_level.br_circlecenters) && isDefined(level.br_level.br_circleradii), "<dev string:x48>");

  if(level.brgametype.var_aa2243b8e5933bf0) {
    originoverride = (level.br_level.br_circlecenters[1][0], level.br_level.br_circlecenters[1][1], 0);
    radiusoverride = level.br_level.br_circleradii[1];
    c130pathstruct = scripts\mp\gametypes\br_c130::createtestc130path(originoverride, radiusoverride);
  } else {
    c130pathstruct = scripts\mp\gametypes\br_c130::createtestc130path();
  }

  return c130pathstruct;
}

function addtoc130infil() {
  thread kickplayersatcircleedge();
}

function kickplayersatcircleedge() {
  level endon("game_ended");
  self endon("death");
  traveldist = distance(self.pathstruct.startpt, self.pathstruct.endptui);
  traveltime = traveldist / scripts\mp\gametypes\br_c130::getc130speed() - 5;
  wait traveltime;

  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.br_infil_type) && player.br_infil_type == "c130" && !isDefined(player.jumptype)) {
      player.jumptype = "outOfBounds";
      player notify("halo_kick_c130");
    }
  }
}

function exfilstart(winners) {
  foreach(player in level.players) {
    player hudoutlinedisable();

    if(player playeriszombie()) {
      player setscriptablepartstate("compassicon", "defaulticon");
      player unsetperk("specialty_radarblip", 1);

      if(level.brgametype.zombievision) {
        if(!level.brgametype.var_63d9be743a6ba8cd) {
          player setscriptablepartstate("headVFX", "neutral");
        }

        player visionsetnakedforplayer("", 0);
      }

      if(!isDefined(array_find(winners, player))) {
        player playerhide();
        player setscriptablepartstate("zombie", "off");
        continue;
      }

      player setscriptablepartstate("zombie", "off");

      if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
        player scripts\mp\teams::setmodelfromcustomization();
      }
    }
  }

  if(isDefined(level.var_c01235187bc88f5a.spawnedagents)) {
    foreach(zombie in level.var_c01235187bc88f5a.spawnedagents) {
      if(isDefined(zombie)) {}
    }

    level.var_c01235187bc88f5a.spawnedagents = [];
  }
}

function setuphumanpowers() {
  if(!istrue(level.brgametype.humanpowersenabled)) {
    return;
  }

  level.brgametype.human = spawnStruct();
  level.brgametype.human.powers = [];
  namespace_27c39fecb94c2a6d::addpowerbutton(level.brgametype.human, "push", ["+stance", "+movedown"], &playerhumanconcusspush, 1, undefined, &playerhumanconcusspushcleanup, undefined, &"MP_ZXP/PUSH", undefined, 60);
}

function playerhumanpowers() {
  if(!istrue(level.brgametype.humanpowersenabled)) {
    return;
  }

  thread namespace_27c39fecb94c2a6d::playerstartpowers(level.brgametype.human);
}

function playerhumanconcusspush(powerstruct, powerref) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_set");
  var_86bcac53e1a0e492 = 750;

  if(istrue(self.concusspushstart)) {
    var_3a0a5a93e61d5dd5 = getdvarint(@ "hash_53c7f9afd0c26ff0", var_86bcac53e1a0e492);
    durationms = gettime() - self.concusspushstart;

    if(durationms <= var_3a0a5a93e61d5dd5) {
      function_5855e4b39bae3587();
      thread namespace_27c39fecb94c2a6d::function_120695737abd78f4(powerstruct, powerref);
      self.concusspushstart = undefined;
      return;
    }
  }

  self.concusspushstart = gettime();
}

function function_5855e4b39bae3587() {
  if(!getdvarint(@ "hash_2fccf88068c3c939", 0)) {
    return;
  }

  var_95f31fd5810a9c2c = 650;
  maxradius = getdvarint(@ "hash_c631cb451d62f9ea", var_95f31fd5810a9c2c);
  closeplayers = sortbydistancecullbyradius(level.players, self.origin, maxradius);

  foreach(player in closeplayers) {
    if(player playeriszombie() && player.team != self.team && isalive(player)) {
      namespace_27c39fecb94c2a6d::playerhumanconcusspushplayer(player, maxradius);
    }
  }

  forward = anglesToForward(self.angles);
  playFX(level.brgametype.impulsefx, self.origin, forward);
  playsoundatpos(self.origin, "sentry_explode_smoke");
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.5, 1.5, self.origin, maxradius);
}

function playerhumanconcusspushcleanup(powerstruct, powerref) {
  self.concusspushstart = undefined;
}

function function_66653a9a40e32d36(deathdata, meansofdeath) {
  if(!isDefined(meansofdeath)) {
    meansofdeath = deathdata.meansofdeath;
  }

  victim = deathdata.victim;
  hitloc = deathdata.hitloc;

  if(isPlayer(victim) && victim playeriszombie() && (hitloc == "head" || hitloc == "helmet")) {
    meansofdeath = "MOD_HEAD_SHOT_ZOMBIE";
  }

  return meansofdeath;
}

function dangercircletick(dangercircleorigin, dangercircleradius, thresholdradius) {
  removaldelay = 0;

  if(level.brgametype.var_593867cbadf91278 >= 0) {
    thresholdradius = 0;
    removaldelay = level.brgametype.var_593867cbadf91278;
  }

  var_52d59c928eb97c81 = dangercircleradius + thresholdradius;
  var_c434624ff361bba2 = var_52d59c928eb97c81 * var_52d59c928eb97c81;

  foreach(item in level.brgametype.respawnitems) {
    if(!isDefined(item) || istrue(item.var_d25a9f9b70723670)) {
      continue;
    }

    if(distance2dsquared(item.origin, dangercircleorigin) > var_c434624ff361bba2) {
      thread function_547be82353222cb4(item, removaldelay);
    }
  }
}

function function_1a1709943670772a() {
  removaldelay = 0;
  thresholdradius = level.var_53c0fa66001cff52;

  if(level.brgametype.var_593867cbadf91278 >= 0) {
    thresholdradius = 0;
    removaldelay = level.brgametype.var_593867cbadf91278;
  }

  foreach(item in level.brgametype.respawnitems) {
    if(!isDefined(item) || istrue(item.var_d25a9f9b70723670)) {
      continue;
    }

    var_e4e4ae4481958d2e = !scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(item.origin, thresholdradius);

    if(var_e4e4ae4481958d2e) {
      thread function_547be82353222cb4(item, removaldelay);
    }
  }
}

function function_547be82353222cb4(item, delay) {
  level endon("game_ended");
  item.var_d25a9f9b70723670 = 1;
  wait delay;

  if(isDefined(item)) {
    function_3bbc840fb244d188(item, 1);
  }
}

function function_b7ba0e456d366ce0(var_86b7e6514f63521e) {
  humanplayers = [];

  foreach(teammate in level.teamdata[var_86b7e6514f63521e.team]["players"]) {
    if(var_86b7e6514f63521e == teammate) {
      continue;
    }

    if(isreallyalive(teammate) && !teammate playeriszombie()) {
      humanplayers[humanplayers.size] = teammate;
    }
  }

  if(humanplayers.size == 1) {
    scripts\mp\gametypes\br_public::brleaderdialog("last_human_alive", 0, humanplayers, 0, 0);
  }
}

function function_17faa3b3fa0fe88d(var_7c66490610b6f676) {
  foreach(teammate in level.teamdata[var_7c66490610b6f676.team]["players"]) {
    if(var_7c66490610b6f676 == teammate) {
      scripts\mp\gametypes\br_public::brleaderdialogplayer("zmb_player_into_zombie", teammate, 0, 0, 0);
      continue;
    }

    scripts\mp\gametypes\br_public::brleaderdialogplayer("zmb_teammate_into_zombie", teammate, 0, 0, 0);
  }
}

function function_c99c402a4b8728d5(player) {
  scripts\mp\gametypes\br_public::brleaderdialogplayer("zxp_playerRevive", player, 0, 0, 0);
}

function function_441a6c6ffaa18dde(var_1543f2cbb2cdf3d2) {
  var_1543f2cbb2cdf3d2 notify("loot_syringe_dialog");
  level endon("game_ended");
  var_1543f2cbb2cdf3d2 endon("death_or_disconnect");
  var_1543f2cbb2cdf3d2 endon("zombie_unset");
  var_1543f2cbb2cdf3d2 endon("loot_syringe_dialog");
  wait 1.5;

  if(!isDefined(var_1543f2cbb2cdf3d2.numconsumed) || var_1543f2cbb2cdf3d2.numconsumed <= 0 || var_1543f2cbb2cdf3d2.numconsumed > 3) {
    return;
  }

  dialog = "loot_syringe_0" + var_1543f2cbb2cdf3d2.numconsumed;
  scripts\mp\gametypes\br_public::brleaderdialogplayer(dialog, var_1543f2cbb2cdf3d2, 0, 0, 0);
}

function function_d4b27081237958b4() {
  if(getdvarint(@ "hash_ffd3cbbd2a5600f0", 1) <= 0) {
    return;
  }

  level.var_428703950599c9e9 = &function_ff7abda78e137510;
  level.var_cd41441b70af845e = &function_9486695a83828a6b;
  level.var_c7f73ef4cb5f312e = &function_c37a0b3355a0200d;
  utility::registersharedfunc("threat_bias", "customFriendlyCheck", &function_528397b2b79b6e9c);
  waitframe();
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  waitframe();
  function_b283548972ee46d2();
}

function function_ff7abda78e137510() {
  scripts\mp\ai_mp_controller::function_b1d1e7e3b23e0dfe(["bosses", "bossMinions", "zombies"]);
}

function function_b283548972ee46d2() {
  if(level.mapname == "mp_delta_pm") {
    function_dab1e28ddbbc63ca((7822, 2314, 188), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((7713, 2462, 188), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((7547, 2342, 190), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((7638, 2177, 188), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((6539, 2730, 380), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((6475, 2874, 380), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((6785, 2896, 380), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((6740, 2761, 380), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((6719, 1056, 380), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((6891, 984, 380), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((7005, 1132, 380), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((7105, 1287, 380), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((5742, 1604, 188), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((5921, 1557, 188), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((6089, 1447, 188), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((5761, 1432, 188), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((1198, -7100, 448), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-199, -7690, 448), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((41, -7567, 192), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((2190, -7094, 192), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-6218, 2221, -94), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-6472, 2206, -97), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-6606, 2571, -100), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-6306, 2552, -95), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-6224, 2767, 167), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-6558, 2824, 167), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-6800, 2709, 167), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-10409, 9092, 304), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-10619, 9927, 304), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-10222, 10609, 496), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-9942, 11100, 496), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-9117, 11593, 540), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-8372, 11404, 412), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-9379, 11242, 168), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-10016, 10622, 165), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-9285, 8577, 176), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-9966, 8952, 576), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-10676, 9290, 584), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-10289, 9886, 576), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-10108, 9329, 576), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-235, 9066, 330), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((154, 8463, 330), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((262, 7668, 314), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-373, 8286, 378), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-918, 8497, 514), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((41, 8724, 514), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((392, 8051, 514), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((69, 8087, 690), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-174, 7805, 690), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-578, 8857, 690), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-823, 9898, 690), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-1704, 10016, 514), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-1417, 10751, 330), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-581, 10938, 378), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-704, 9834, 514), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((391, 9809, 514), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((7280, 7440, 323), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((7816, 7809, 324), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((8183, 7986, 324), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((8880, 6716, 324), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((7701, 6032, 324), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((8356, 6921, 188), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((8401, 7933, 188), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((7566, 7819, 188), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((7473, 7118, 243), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((8456, 7033, 324), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((7720, 6829, 324), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((12764, 5757, 191), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((13179, 5281, 191), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((13374, 5402, 327), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((12736, 4656, 191), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((13144, 4103, 191), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((12234, 4210, 327), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((12170, 2992, 391), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((12915, 2033, 327), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((13246, 2444, 191), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((13924, 3242, 55), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((13695, 4184, 327), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((14109, 1646, 191), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((13815, 684, 191), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((13146, 1436, 327), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((14479, 341, 327), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((12557, -73, 327), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((12551, -264, 831), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((12466, 1876, 1007), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((4547, -2699, 364), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((4201, -2685, 188), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((5035, -3131, 188), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((3804, -2671, 364), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((4247, -2840, 935), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((8024, -5405, 271), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((8307, -5875, 439), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((8915, -5286, 191), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((9757, -5730, 106), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((9522, -4261, 191), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((9355, -5309, 439), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((10118, -5058, 663), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((9374, -4549, 663), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((10129, -5618, 439), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((14736, -5434, 326), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((14619, -5338, 182), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((14161, -5545, 182), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((14079, -6189, 182), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((13675, -6687, 182), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((13628, -6239, 326), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((13891, -5634, 326), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((14364, -5101, 870), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((14925, -5196, 870), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-6791, -10472, 330), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-6865, -10376, 106), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-6714, 9727, 122), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-7052, -9330, 122), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-6327, -9972, 330), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-5849, -10375, 330), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-7158, -9477, 518), (0, randomintrange(0, 360), 0));
    return;
  }

  if(level.mapname == "mp_saba_pm") {
    function_dab1e28ddbbc63ca((19755, -53032, 1082), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((18198, -56072, 1082), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((15702, -53591, 1146), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((17711, -54096, 1210), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((22696, -55257, 770), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((18999, -55091, 1338), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((15798, -54613, 1210), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((11045, -52162, 770), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((29430, -41278, 410), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((30764, -41380, 266), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((29340, -41524, 410), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((30020, -41833, 1898), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((30020, -41833, 1898), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((30486, -32650, 418), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((29584, -33097, 270), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((27837, -33288, 226), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((28095, -33977, 418), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((27109, -32406, 418), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((28930, -32283, 418), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((29914, -30093, 418), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((31595, -31294, 418), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((31359, -33418, 420), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-18337, -37223, 511), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-19268, -38582, 536), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-19850, -41065, 550), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-22313, -39523, 564), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-21205, -37416, 578), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-22122, -35365, 488), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-20617, -36008, 578), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-20451, -38132, 579), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-44528, -18621, 322), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-42533, -17014, 322), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-41820, -19679, 498), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-45544, -20173, 314), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-46178, -17162, 326), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-46082, -16203, 327), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-45176, -15879, 326), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-42515, -18105, 322), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-44066, -17184, 322), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-44042, -13878, 322), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-48363, -14164, 362), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-50476, -14807, 322), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-46015, -13133, 322), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-45344, -11912, 322), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-51300, 14421, 1148), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-50218, 15334, 1148), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-50584, 17071, 1154), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-49595, 17950, 1545), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-45724, 14668, 1148), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-49156, 13229, 802), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-48490, 12707, 666), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-49358, 13070, 666), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-50340, 14115, 866), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-49239, 11146, 866), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-47629, 11057, 1154), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-50178, 9959, 1018), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-28445, 27757, -221), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-28098, 27884, -61), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-24974, 27316, -157), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-24613, 27873, 5), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-23685, 28190, -373), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-23016, 26709, -421), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-21946, 26811, -427), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-21074, 25888, -429), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-21963, 23907, -281), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-21660, 27903, -28), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-21313, 30081, -173), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-23001, 32225, -220), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-25249, 28998, -227), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-19954, 30339, 7), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-19961, 22221, -245), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-20532, 17125, -129), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-20234, 15933, -413), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-21689, 15727, -273), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-14641, 11791, 754), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-12528, 14008, 754), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-13102, 11318, 698), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-12697, 14198, 754), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-10677, 13030, 530), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-7531, 14273, 611), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-9362, 7951, 362), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-6452, 7523, 573), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-4795, 6721, 690), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-6170, 5693, 474), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-6922, 4681, 746), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-7786, 5608, 426), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-11823, 9361, 538), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-10066, 12037, 522), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((6693, 34625, 329), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((5471, 32749, 504), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((5534, 29622, 739), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((6362, 27668, 930), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((4964, 25856, 329), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((2685, 26008, 444), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((2483, 28429, 321), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((4012, 23787, 328), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((3958, 24164, 536), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((5093, 23453, 535), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((5961, 24056, 536), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((6220, 22126, 521), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((10071, 21721, 322), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((13561, 37926, 329), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((15521, 37651, 465), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((16289, 35720, 330), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((16928, 33203, 522), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((21575, 28715, 460), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((19427, 20587, -63), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((20544, 22038, -61), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((18747, 20249, 321), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((15387, 17604, 329), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((16851, 12594, 459), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((16603, 10634, 496), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((13584, 33690, 327), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((13845, 33825, 1975), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((13140, 33832, 1975), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((14970, 29461, 353), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((15099, 28924, 497), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((16460, 29539, 361), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((16720, 30514, 529), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((16860, 30500, 361), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((15082, 26035, 337), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((15249, 24661, 473), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((15271, 21812, 473), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((16087, 20513, 337), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((14431, 20823, 337), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((15666, 21216, 697), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((15276, 21105, 1633), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((15590, 23171, 1448), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((14198, 26001, 1632), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((15574, 25707, 2465), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((15037, 26059, 1057), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((30432, 17634, 610), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((30475, 19611, 610), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((30366, 19377, 322), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((30426, 17397, 322), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((30388, 18547, 466), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((22134, -16334, 3894), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((21638, -15155, 4038), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((22465, -14974, 3773), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((19706, -16523, 3531), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((17167, -16263, 3028), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((17209, -14057, 3099), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((16029, -13080, 3017), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((15042, -14247, 2776), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((19032, -12795, 2940), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((18480, -10701, 3176), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((20959, -9300, 2725), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((21441, -12985, 3093), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((29026, -18550, 804), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((31025, -16543, 641), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((32750, -14769, 786), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((32464, -17552, 842), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((32554, -19265, 744), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((33512, -21402, 654), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((29467, -21229, 570), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((3918, -10946, 4754), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((3628, -11835, 4802), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((1795, -11784, 4862), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((97, -13516, 4922), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-898, -13387, 4922), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-1434, -15634, 4802), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-3058, -20853, 4494), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-3435, -23863, 4254), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-3738, -22682, 4462), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-5384, -17294, 4546), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-2492, -11251, 4770), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((523, -10986, 4730), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((2138, -9644, 5050), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-865, -11331, 4474), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-3520, -12710, 3130), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-3988, -12284, 3130), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((8420, -28742, 1276), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((5663, -26837, 1396), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((4163, -25993, 1420), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((3214, -28137, 1404), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((6760, -25542, 1668), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((9461, -24447, 1312), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((11406, -24717, 1352), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((12539, -25109, 1200), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((11237, -26475, 1184), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((10240, -25763, 1360), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((12358, -26852, 1200), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((14349, -25863, 1464), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((14751, -26510, 1328), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((16605, -24555, 1130), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((14837, -23128, 1283), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((16986, -23646, 1123), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((18606, -22869, 1134), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((19358, -26126, 1122), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((22426, -26427, 626), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((25013, -25538, 818), (0, randomintrange(0, 360), 0));
    return;
  }

  if(level.mapname == "mp_escape4") {
    function_dab1e28ddbbc63ca((530, -7486, 100), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((502, -7420, 100), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((448, -7455, 100), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((461, -7368, 100), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((407, -7495, 100), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((398, -7374, 100), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((361, -7427, 100), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((317, -7462, 100), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((329, -7370, 100), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((578, -7409, 100), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((2450, -2915, 50), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((2501, -2864, 50), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((2448, -2827, 50), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((2534, -2806, 50), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((2396, -2804, 50), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((2505, -2750, 50), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((2442, -2736, 50), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((2483, -2685, 50), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((2393, -2708, 50), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((2540, -2930, 50), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-3375, 4404, -17), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-3420, 4459, -17), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-3478, 4375, -17), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-3485, 4432, -17), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-3474, 4498, -17), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-3543, 4399, -17), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-3532, 4496, -17), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-3584, 4454, -17), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-3586, 4368, -17), (0, randomintrange(0, 360), 0));
    function_dab1e28ddbbc63ca((-3350, 4491, -17), (0, randomintrange(0, 360), 0));
  }
}

function function_dab1e28ddbbc63ca(origin, angles, var_8ae63b0d643d4e2a, var_8216c9148d9cf617, forcespawn) {
  if(!istrue(forcespawn)) {
    circleorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    circleradius = scripts\mp\gametypes\br_circle::getsafecircleradius();

    if(!ispointinsidecircle(origin, circleorigin, circleradius) && level.br_circle.circleindex == 0) {
      return;
    }
  }

  zombie = undefined;

  if(isDefined(zombie)) {
    zombie.entered_playspace = 1;
    zombie.var_94919e2028dbc9d0 = &function_7998a7de21fc202e;
  }

  return zombie;
}

function function_9486695a83828a6b(var_af4cbac5d9f8d2dd) {
  if(var_af4cbac5d9f8d2dd scripts\mp\gametypes\br_public::playeriszombie()) {
    return true;
  }

  return false;
}

function function_c37a0b3355a0200d(attackent) {
  if(attackent scripts\mp\gametypes\br_public::playeriszombie()) {
    return 0;
  }

  return undefined;
}

function function_7998a7de21fc202e(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration) {
  if(!isDefined(level.brgametype.var_664897c80ff2a610)) {
    return;
  }

  if(randomint(100) <= level.brgametype.var_664897c80ff2a610) {
    function_536210a44b407bf4();
  }

  if(isDefined(eattacker) && isPlayer(eattacker) && !eattacker playeriszombie()) {
    namespace_c711384b1335919::function_d24f2dd28d26377e(level.brgametype.var_f55be0289e3ef5aa);
  }
}

function private function_528397b2b79b6e9c(agent, attacker, inflictor, meansofdeath) {
  var_f8f9822d9df61c5f = 0;

  if(isDefined(attacker) && isPlayer(attacker) && attacker scripts\mp\gametypes\br_public::playeriszombie() && isDefined(agent) && istrue(agent.zombie)) {
    var_f8f9822d9df61c5f = 1;
  }

  return var_f8f9822d9df61c5f;
}

function allowimpactvehicledamage(data) {
  attacker = ter_op(isDefined(data.attacker), data.attacker, data.inflictor);

  if(isDefined(attacker)) {
    return istrue(attacker.zombie);
  }

  return false;
}

function function_c271e4000367648f(location1, location2) {
  return distance2dsquared(location1.origin, self.origin) < distance2dsquared(location2.origin, self.origin);
}

function function_bfe726b5e0b35c27() {
  start = self getEye();
  dir = anglesToForward(self getplayerangles());
  end = start + 8000 * dir;
  trace = scripts\engine\trace::_bullet_trace(start, end, 1, self);
  player = undefined;

  if(isDefined(trace["<dev string:xad>"]) && isPlayer(trace["<dev string:xad>"]) && isreallyalive(trace["<dev string:xad>"])) {
    player = trace["<dev string:xad>"];
  }

  return player;
}

function function_c8f3d5a97c5a34d6(distance_from_player) {
  if(!isDefined(distance_from_player)) {
    distance_from_player = 200;
  }

  return level.player.origin + anglesToForward(level.player.angles) * distance_from_player;
}

function runcommand(args) {
  if(args.size == 0) {
    return;
  }

  command = args[0];
  var_c52518fe43f94b59 = ter_op(args.size >= 2, args[1], undefined);
  host = scripts\mp\gamelogic::gethostplayer();

  if(command == "<dev string:xb7>") {
    if(!host playeriszombie()) {
      host namespace_27c39fecb94c2a6d::playerzombierespawn(0);
    }

    return;
  }

  if(command == "<dev string:xc1>") {
    if(host playeriszombie()) {
      host playerzombiebacktohuman();
    } else if(!isDefined(host.powershud)) {
      host thread playerhumanpowers();
    }

    return;
  }

  if(command == "<dev string:xca>") {
    entnum = int(args[1]);
    ent = getEntArray()[entnum];

    if(!ent playeriszombie()) {
      ent namespace_27c39fecb94c2a6d::playerzombierespawn(0);
    }

    return;
  }

  if(command == "<dev string:xd7>") {
    entnum = int(args[1]);
    ent = getEntArray()[entnum];

    if(ent playeriszombie()) {
      ent playerzombiebacktohuman();
    }

    return;
  }

  if(command == "<dev string:xe3>") {
    player = host function_bfe726b5e0b35c27();

    if(isDefined(player) && !player playeriszombie()) {
      player namespace_27c39fecb94c2a6d::playerzombierespawn(0);
      waitframe();
      player scripts\mp\gametypes\common::removespawnprotection();
    }

    return;
  }

  if(command == "<dev string:xf1>") {
    player = host function_bfe726b5e0b35c27();

    if(isDefined(player) && player playeriszombie()) {
      player playerzombiebacktohuman();
      waitframe();
      player scripts\mp\gametypes\common::removespawnprotection();
    }

    return;
  }

  if(command == "<dev string:xfe>") {
    foreach(player in level.players) {
      player namespace_27c39fecb94c2a6d::playerzombierespawn(0);
      waitframe();
      player scripts\mp\gametypes\common::removespawnprotection();
    }

    return;
  }

  if(command == "<dev string:x10b>") {
    thread function_fe2c5864c61ef6e7();
    return;
  }

  if(command == "<dev string:x116>") {
    host function_2a87a924534f06fb();
    return;
  }

  if(command == "<dev string:x12a>") {
    player = host function_bfe726b5e0b35c27();

    if(isDefined(player)) {
      player dontinterpolate();
    }

    return;
  }

  if(command == "<dev string:x136>") {
    powerstruct = level.brgametype.human;

    if(host playeriszombie()) {
      powerstruct = level.brgametype.zombie;
    }

    host thread namespace_27c39fecb94c2a6d::playerpowerrestartallcooldowns(powerstruct);
    return;
  }

  if(command == "<dev string:x14a>") {
    powerstruct = level.brgametype.human;

    if(host playeriszombie()) {
      powerstruct = level.brgametype.zombie;
    }

    host thread namespace_27c39fecb94c2a6d::playerpowerresetpowers(powerstruct);
    return;
  }

  if(command == "<dev string:x159>") {
    player = host function_bfe726b5e0b35c27();

    if(isDefined(player) && player playeriszombie()) {
      player namespace_27c39fecb94c2a6d::playerpowerresetpowers(level.brgametype.zombie);
      waitframe();
      player namespace_27c39fecb94c2a6d::function_7f013d8a91788fdf(level.brgametype.zombie, "<dev string:x166>");
    }

    return;
  }

  if(command == "<dev string:x16f>") {
    player = host function_bfe726b5e0b35c27();

    if(isDefined(player) && player playeriszombie()) {
      player namespace_27c39fecb94c2a6d::playerpowerresetpowers(level.brgametype.zombie);
      waitframe();
      player_angles = player getplayerangles();
      player namespace_27c39fecb94c2a6d::playerapplyjumpvelocity(player_angles, 1300, 0.4);
    }

    return;
  }

  if(command == "<dev string:x17b>") {
    dir = anglesToForward(host.angles);
    org = host.origin + dir * 150;
    count = 1;

    if(isDefined(args[1])) {
      count = int(args[1]);
    }

    function_7fa9a8fb1f8cb5a7(org, dir, host, count);
    return;
  }

  if(command == "<dev string:x18c>") {
    start = host getEye();
    dir = anglesToForward(host getplayerangles());
    end = start + 8000 * dir;
    trace = scripts\engine\trace::_bullet_trace(start, end, 1, host);
    count = 1;

    if(isDefined(args[1])) {
      count = int(args[1]);
    }

    function_7fa9a8fb1f8cb5a7(trace["<dev string:x1a1>"], dir, host, count);
    return;
  }

  if(command == "<dev string:x1ad>") {
    host function_cd17fd9df37e3def();
    host function_172ca8a9c3a0981d(1);
    return;
  }

  if(command == "<dev string:x1b5>") {
    spawn_location = function_c8f3d5a97c5a34d6();
    spawn_angles = level.player.angles + (0, 0, 180);
    var_8ae63b0d643d4e2a = var_c52518fe43f94b59;
    function_dab1e28ddbbc63ca(spawn_location, spawn_angles, var_8ae63b0d643d4e2a);
    return;
  }

  if(command == "<dev string:x1c7>") {
    spawn_location = function_c8f3d5a97c5a34d6();
    spawn_angles = level.player.angles + (0, 0, 180);
    var_8ae63b0d643d4e2a = "<dev string:x1e0>";
    var_c11d7d9a63774677 = "<dev string:x1f0>";
    function_dab1e28ddbbc63ca(spawn_location, spawn_angles, var_8ae63b0d643d4e2a, var_c11d7d9a63774677);
  }
}

function function_fe2c5864c61ef6e7() {
  host = scripts\mp\gamelogic::gethostplayer();

  if(isDefined(host)) {
    teammates = level.teamdata[host.team]["<dev string:x1fc>"];

    if(teammates.size > 0) {
      teammate = teammates[0];
      teammate scripts\mp\gametypes\br_pickups::addrespawntoken(1);
      host namespace_27c39fecb94c2a6d::kioskreviveplayer(teammate);
    }
  }
}

function function_2a87a924534f06fb() {
  if(!playeriszombie()) {
    return;
  }

  vehicle = getvehicle();
  self dodamage(1000, vehicle.origin, vehicle);
}

function getvehicle() {
  foreach(var_e5cd5ce5ee8dc6c9 in level.vehicle.instances) {
    foreach(vehicle in var_e5cd5ce5ee8dc6c9) {
      if(isalive(vehicle)) {
        return vehicle;
      }
    }
  }
}

# /