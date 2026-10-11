/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_509d466932bca53e.gsc
*************************************************/

#using script_1407e72346815bc3;
#using script_15c7dc779b327c9b;
#using script_22c948a23ad2fbdf;
#using script_29ec5691a72b84d4;
#using script_2d9d24f7c63ac143;
#using script_53da3333b83b3527;
#using script_5b3343e89efb05b6;
#using script_5bab271917698dc4;
#using script_5bc60484d17fa95c;
#using script_64acb6ce534155b7;
#using script_7118a63f6a493ea8;
#using script_74b851b7aa1ef32d;
#using scripts\common\damage_tuning;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\analyticslog;
#using scripts\mp\anim;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\bots\bots_killstreaks_remote_vehicle;
#using scripts\mp\class;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff_mp;
#using scripts\mp\equipment;
#using scripts\mp\equipment\gas_grenade;
#using scripts\mp\equipment\nvg;
#using scripts\mp\equipment\tactical_camera;
#using scripts\mp\equipment\throwing_knife_mp;
#using scripts\mp\events;
#using scripts\mp\execution_mp;
#using scripts\mp\featurebans;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_headgear;
#using scripts\mp\gametypes\br_killstreaks;
#using scripts\mp\gametypes\br_maphints;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\juggernaut;
#using scripts\mp\killstreaks\flares;
#using scripts\mp\killstreaks\init_mp;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\killstreaks\manual_turret_mp;
#using scripts\mp\killstreaks\mapselect;
#using scripts\mp\killstreaks\target_marker;
#using scripts\mp\laststand;
#using scripts\mp\loot;
#using scripts\mp\matchdata;
#using scripts\mp\menus;
#using scripts\mp\movers;
#using scripts\mp\mp_agent;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\oxygenmask_mp;
#using scripts\mp\perks\perkfunctions;
#using scripts\mp\perks\perkpackage;
#using scripts\mp\perks\perks;
#using scripts\mp\playerhealth;
#using scripts\mp\playerlogic;
#using scripts\mp\poi;
#using scripts\mp\rank;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\shellshock;
#using scripts\mp\spawnlogic;
#using scripts\mp\supers;
#using scripts\mp\supers\super_suppression_rounds;
#using scripts\mp\teams;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\game_utility_mp;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\player_frame_update_aggregator;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\script;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\trigger;
#using scripts\mp\utility\weapon;
#using scripts\mp\vehicles\damage;
#using scripts\mp\vehicles\vehicle_mp;
#using scripts\mp\weapons;
#namespace namespace_657dc7e018dcfce9;

function init() {
  namespace_c3fdc5febda99c60::init();
  anim_init();
  hud_init();

  if(!istrue(game["isLaunchChunk"])) {
    killstreak_init();
  }

  equipment_init();
  perk_init();
  player_init();
  loadout_init();

  if(!istrue(game["isLaunchChunk"])) {
    vehicle_init();
  }

  game_init();
  spawn_init();
  objective_init();

  if(!istrue(game["isLaunchChunk"])) {
    emp_init();
  }

  execution_init();
  entity_init();
  weapons_init();
  damage_init();
  sound_init();
  flares_init();
  shellshock_init();
  bots_init();
  agents_init();
  outline_init();
  game_utility_init();
  function_b9e6cdc26386e536();
  rank_init();
  stats_init();
  supers_init();
  gamescore_init();
  pers_init();
  dlog_init();
  challenges_init();
  function_a92ed2f4c44e5ffa();
  stealth_init();
  gameskill_init();
  poi_init();
  aggregator_init();
  vehicle_damage_init();
  cameras_init();
  function_a30b248a8fc67a00();
  battlechatter_init();
  host_migration_init();
  function_f677f2d747d21482();
  function_52b5f55ca64bd530();
  utility::registersharedfunc("game", "runLeanThreadMode", &game_utility::runleanthreadmode);
  utility::registersharedfunc("game", "lpcFeatureGated", &game_utility::lpcfeaturegated);
}

function gameskill_init() {
  utility::registersharedfunc("gameskill", "updatePlayerAttackerAccuracy", &namespace_3dfa6eb6c5741630::update_player_attacker_accuracy);
}

function poi_init() {
  utility::registersharedfunc("poi", "isSystemActive", &poi::poi_issystemactive);
  utility::registersharedfunc("poi", "isInActivePOI", &poi::function_9c93e67f90980177);
  utility::registersharedfunc("poi", "findPOIOriginIsIn", &poi::poi_findpoioriginisin);
  utility::registersharedfunc("poi", "try_TranslatePOI", &poi::function_150af7f3a2874667);
}

function stealth_init() {
  utility::registersharedfunc("stealth", "init", &manager_mp::init);
  utility::registersharedfunc("stealth_music", "init", &namespace_17ca84825c926284::init);
  utility::registersharedfunc("stealth_enemy", "init", &enemy_mp::init);
  utility::registersharedfunc("stealth", "revertAiAccuracy", &manager_mp::revertaiaccuracy);
  utility::registersharedfunc("stealth", "dropAiAccuracy", &manager_mp::dropaiaccuracy);
}

function anim_init() {
  utility::registersharedfunc("anim", "player_solo", &anim_mp::anim_player_solo);
}

function hud_init() {
  utility::registersharedfunc("hud", "showSplash", &hud_message::showsplash);
  utility::registersharedfunc("hud", "teamPlayerCardSplash", &hud_util::teamplayercardsplash);
  utility::registersharedfunc("hud", "showErrorMessage", &hud_message::showerrormessage);
  utility::registersharedfunc("hud", "createHudElem", &hud_util::createhudelem);
  utility::registersharedfunc("hud", "showElem", &hud_util::showelem);
  utility::registersharedfunc("hud", "hideElem", &hud_util::hideelem);
}

function killstreak_init() {
  utility::registersharedfunc("killstreak", "init", &init_mp::init);
  utility::registersharedfunc("killstreak", "addToActiveKillstreakList", &killstreak::addtoactivekillstreaklist);
  utility::registersharedfunc("killstreak", "logKillstreakEvent", &matchdata::logkillstreakevent);
  utility::registersharedfunc("killstreak", "giveKillstreak", &killstreaks::givekillstreak);
  utility::registersharedfunc("killstreak", "killstreakMakeVehicle", &killstreak::killstreak_make_vehicle);
  utility::registersharedfunc("killstreak", "killstreakSetPreModDamageCallback", &killstreak::killstreak_set_pre_mod_damage_callback);
  utility::registersharedfunc("killstreak", "killstreakSetPostModDamageCallback", &killstreak::killstreak_set_post_mod_damage_callback);
  utility::registersharedfunc("killstreak", "killstreakSetDeathCallback", &killstreak::killstreak_set_death_callback);
  utility::registersharedfunc("killstreak", "maxVehiclesAllowed", &killstreak::maxvehiclesallowed);
  utility::registersharedfunc("killstreak", "currentActiveVehicleCount", &killstreak::currentactivevehiclecount);
  utility::registersharedfunc("killstreak", "allowRideKillstreakPlayerExit", &killstreaks::allowridekillstreakplayerexit);
  utility::registersharedfunc("killstreak", "killstreakHit", &killstreaks::killstreakhit);
  utility::registersharedfunc("killstreak", "getModifiedDamageUsingDamageTuning", &damage_tuning::getmodifieddamageusingdamagetuning);
  utility::registersharedfunc("killstreak", "getModifiedAntiKillstreakDamage", &killstreak::getmodifiedantikillstreakdamage);
  utility::registersharedfunc("killstreak", "isKillstreakWeapon", &weapon::iskillstreakweapon);
  utility::registersharedfunc("killstreak", "doDamageToKillstreak", &killstreak::dodamagetokillstreak);
  utility::registersharedfunc("killstreak", "removeFromActiveKillstreakList", &killstreak::removefromactivekillstreaklist);
  utility::registersharedfunc("killstreak", "awardKillstreakFromStruct", &killstreaks::awardkillstreakfromstruct);
  utility::registersharedfunc("killstreak", "getSelectMapPoint", &mapselect::function_a5839924b6723eac);
  utility::registersharedfunc("killstreak", "startMapSelectSequence", &mapselect::function_90f093ca8576232f);
  utility::registersharedfunc("killstreak", "setKillstreakControlPriority", &killstreak::setkillstreakcontrolpriority);
  utility::registersharedfunc("killstreak", "updateScrapAssistDataForceCredit", &killstreaks::updatescrapassistdataforcecredit);
  utility::registersharedfunc("killstreak", "updateScrapAssistData", &killstreaks::updatescrapassistdata);
  utility::registersharedfunc("killstreak", "processScrapAssist", &events::processscrapassist);
  utility::registersharedfunc("killstreak", "dangerNotifyPlayer", &br_killstreaks::dangernotifyplayer);
  utility::registersharedfunc("killstreak", "getTargetMarker", &target_marker::gettargetmarker);
  utility::registersharedfunc("killstreak", "forceGiveKillstreak", &br_pickups::forcegivekillstreak);
  utility::registersharedfunc("killstreak", "waittill_confirm_or_cancel", &mapselect::waittill_confirm_or_cancel);
  utility::registersharedfunc("killstreak", "forceUseKillstreak", &br_pickups::forceusekillstreak);
  utility::registersharedfunc("killstreak", "awardKillstreak", &killstreaks::awardkillstreak);
  utility::registersharedfunc("killstreak", "registerKillstreak", &killstreaks::registerkillstreak);
  utility::registersharedfunc("killstreak", "registerKillstreakDamageDealingWeapon", &killstreaks::registerkillstreakdamagedealingweapon);
  utility::registersharedfunc("killstreak", "handleMovingPlatform", &manual_turret_mp::manual_turret_handlemovingplatform);
  utility::registersharedfunc("killstreak", "rewardAssistPoints", &namespace_b09d1ea3e62b8710::rewardassistpoints);
}

function equipment_init() {
  utility::registersharedfunc("throwing_knife", "init", &throwing_knife_mp::throwing_knife_mp_init);
  utility::registersharedfunc("equipment", "takeEquipment", &equipment::takeequipment);
  utility::registersharedfunc("equipment", "giveEquipment", &equipment::giveequipment);
  utility::registersharedfunc("equipment", "hasEquipment", &equipment::hasequipment);
  utility::registersharedfunc("equipment", "findEquipmentSlot", &equipment::findequipmentslot);
  utility::registersharedfunc("equipment", "getEquipmentAmmo", &equipment::getequipmentammo);
  utility::registersharedfunc("equipment", "setEquipmentAmmo", &equipment::setequipmentammo);
  utility::registersharedfunc("equipment", "getEquipmentTableInfo", &equipment::getequipmenttableinfo);
  utility::registersharedfunc("equipment", "getEquipmentRefFromWeapon", &equipment::getequipmentreffromweapon);
  utility::registersharedfunc("equipment", "hackEquipment", &equipment::hackequipment);
  utility::registersharedfunc("equipment", "isPlantedEquipment", &scripts\mp\weapons::isplantedequipment);
  utility::registersharedfunc("equipment", "deleteExplosive", &scripts\mp\weapons::deleteexplosive);
  utility::registersharedfunc("equipment", "giveScoreForEquipment", &scripts\mp\killstreaks\killstreaks::givescoreforequipment);
  utility::registersharedfunc("equipment", "makeExplosiveUsableTag", &scripts\mp\weapons::makeexplosiveusabletag);
  utility::registersharedfunc("equipment", "makeExplosiveUnusuableTag", &scripts\mp\weapons::makeexplosiveunusuabletag);
  utility::registersharedfunc("equipment", "areNVGTogglableForPlayer", &nvg::function_258c5e445c8b7f80);
  utility::registersharedfunc("equipment", "combatRecordTacticalStat", &scripts\mp\damage::combatrecordtacticalstat);
  utility::registersharedfunc("oxygenmask", "init", &scripts\mp\oxygenmask_mp::init);
  utility::registersharedfunc("headgear", "breakHeadGear", &scripts\mp\gametypes\br_headgear::breakheadgear);
  utility::registersharedfunc("headgear", "resetGasMaskRemovalDelay", &scripts\mp\gametypes\br_headgear::resetgasmaskremovaldelay);
}

function entity_init() {
  utility::registersharedfunc("entity", "touchingBadTrigger", &entity::touchingbadtrigger);
  utility::registersharedfunc("entity", "delayEntDelete", &script::delayentdelete);
  utility::registersharedfunc("entity", "isTouchingBoundsTrigger", &entity::istouchingboundstrigger);
}

function perk_init() {
  utility::registersharedfunc("perk", "hasPerk", &perk::_hasperk);
  utility::registersharedfunc("perk", "removePerk", &perk::removeperk);
  utility::registersharedfunc("perk", "givePerk", &perk::giveperk);
  utility::registersharedfunc("perk", "activatePerk", &scripts\mp\perks\perks::activateperk);
  utility::registersharedfunc("perk", "block", &perk::blockperkfunction);
  utility::registersharedfunc("perk", "unblock", &perk::unblockperkfunction);
  utility::registersharedfunc("perk", "perkpackage_giveOverrideFieldUpgrades", &perkpackage::perkpackage_giveoverridefieldupgrades);
  utility::registersharedfunc("perk", "applyStunResistence", &perkfunctions::applystunresistence);
}

function player_init() {
  utility::registersharedfunc("player", "setUsingRemote", &player::setusingremote);
  utility::registersharedfunc("player", "clearUsingRemote", &player::clearusingremote);
  utility::registersharedfunc("player", "freezeControls", &player::_freezecontrols);
  utility::registersharedfunc("player", "freezeControlsDebug", &player::function_8213d31f7a3c32e2);
  utility::registersharedfunc("player", "freezeLookControls", &player::_freezelookcontrols);
  utility::registersharedfunc("player", "printGameAction", &print::printgameaction);
  utility::registersharedfunc("player", "isPlayerADS", &player::isplayerads);
  utility::registersharedfunc("player", "doScoreEvent", &points::doscoreevent);
  utility::registersharedfunc("player", "setThirdPersonDOF", &player::setthirdpersondof);
  utility::registersharedfunc("player", "hideMiniMap", &player::hideminimap);
  utility::registersharedfunc("player", "showMiniMap", &player::showminimap);
  utility::registersharedfunc("player", "getPlayersInRadius", &player::getplayersinradius);
  utility::registersharedfunc("player", "isFriendly", &player_utility::isfriendly);
  utility::registersharedfunc("player", "isReallyAlive", &player::isreallyalive);
  utility::registersharedfunc("player", "getStanceCenter", &player::getstancecenter);
  utility::registersharedfunc("player", "getStanceTop", &player::getstancetop);
  utility::registersharedfunc("player", "loadout_finalizeWeapons", &class::loadout_finalizeweapons);
  utility::registersharedfunc("player", "lookupCurrentOperator", &teams::lookupcurrentoperator);
  utility::registersharedfunc("player", "lookupOtherOperator", &teams::lookupotheroperator);
  utility::registersharedfunc("player", "isInLastStand", &player::isinlaststand);
  utility::registersharedfunc("player", "isAliveAndNotInLastStand", &scripts\mp\utility\player::isaliveandnotinlaststand);
  utility::registersharedfunc("player", "cleanInterrogationOnExit", &scripts\mp\laststand::cleaninterrogationonexit);
  utility::registersharedfunc("player", "disableClassSwapAllowed", &class::disableclassswapallowed);
  utility::registersharedfunc("player", "isPlayerOnIntelChallenge", &br_maphints::isplayeronintelchallenge);
  utility::registersharedfunc("player", "getGametypeHealthPerFrame", &playerhealth::getgametypehealthperframe);
  utility::registersharedfunc("player", "onFullHealth", &playerhealth::onfullhealth);
  utility::registersharedfunc("player", "isOOB", &outofbounds::isoob);
  utility::registersharedfunc("player", "hasKillstreak", &br_pickups::haskillstreak);
  utility::registersharedfunc("player", "isSuperInUse", &supers::issuperinuse);
  utility::registersharedfunc("player", "getCurrentSuper", &supers::getcurrentsuper);
  utility::registersharedfunc("player", "getCurrentSuperRef", &supers::getcurrentsuperref);
  utility::registersharedfunc("player", "br_ammo_player_is_maxed_out", &br_weapons::br_ammo_player_is_maxed_out);
  utility::registersharedfunc("player", "hasSelfReviveToken", &br_public::hasselfrevivetoken);
  utility::registersharedfunc("player", "takeWeaponPickup", &br_weapons::takeweaponpickup);
  utility::registersharedfunc("player", "forceGiveSuper", &br_pickups::forcegivesuper);
  utility::registersharedfunc("player", "resetSuper", &br_pickups::resetsuper);
  utility::registersharedfunc("player", "br_ammo_player_max_out", &br_weapons::br_ammo_player_max_out);
  utility::registersharedfunc("player", "addRespawnToken", &br_pickups::addrespawntoken);
  utility::registersharedfunc("player", "addSelfReviveToken", &br_pickups::addselfrevivetoken);
  utility::registersharedfunc("player", "isJuggernaut", &killstreak::isjuggernaut);
  utility::registersharedfunc("player", "jugg_removeJuggernaut", &scripts\mp\juggernaut::jugg_removejuggernaut);
  utility::registersharedfunc("player", "getAvailableDMZBackpackIndex", &namespace_e50e624d9af51c8c::getavailabledmzbackpackindex);
  utility::registersharedfunc("player", "playerPlunderKioskPurchase", &br_plunder::playerplunderkioskpurchase);
  utility::registersharedfunc("player", "preloadAndQueueClass", &class::preloadandqueueclass);
  utility::registersharedfunc("player", "br_giveSelectedClass", &br::br_giveselectedclass);
  utility::registersharedfunc("player", "isEligibleForTeamRevive", &br_public::iseligibleforteamrevive);
  utility::registersharedfunc("player", "isRespawningFromToken", &br_public::isrespawningfromtoken);
  utility::registersharedfunc("player", "playerGulagAutoWin", &br_gulag::playergulagautowin);
  utility::registersharedfunc("player", "playerPrestreamRespawnOrigin", &namespace_6e6b980bec22af5b::playerprestreamrespawnorigin);
  utility::registersharedfunc("player", "gulagFadeToBlack", &namespace_6e6b980bec22af5b::function_334a8fe67e88bbe7);
  utility::registersharedfunc("player", "gulagStreamExit", &namespace_6e6b980bec22af5b::function_961b4afc4c695b94);
  utility::registersharedfunc("player", "playerTeleportGulag", &namespace_6e6b980bec22af5b::function_ab31cf673d70f72d);
  utility::registersharedfunc("player", "playerCleanupEntOnDisconnect", &namespace_6e6b980bec22af5b::playercleanupentondisconnect);
  utility::registersharedfunc("player", "playerWaittillStreamHintComplete", &br_public::playerwaittillstreamhintcomplete);
  utility::registersharedfunc("player", "playerClearStreamHintOrigin", &br_public::playerclearstreamhintorigin);
  utility::registersharedfunc("player", "resetPlayerMoveSpeedScale", &namespace_6e6b980bec22af5b::resetplayermovespeedscale);
  utility::registersharedfunc("player", "gulagFadeFromBlack", &namespace_6e6b980bec22af5b::function_e68e4bb4f65f5fe4);
  utility::registersharedfunc("player", "doOnActionScoreEvent", &namespace_40cd4a4db2010f22::doonactionscoreevent);
  utility::registersharedfunc("player", "updateBRScoreboardStat", &br_public::updatebrscoreboardstat);
  utility::registersharedfunc("player", "gulagTrackPlayerBulletHitAI", &function_e1e9831c1bcd6f59);
  utility::registersharedfunc("player", "isInGulagCheck", &br_public::isplayerinorgoingtogulag);
  utility::registersharedfunc("player", "getUniqueId", &player::getuniqueid);
  utility::registersharedfunc("player", "initPlayerGameobjects", &gameobjects::init_player_gameobjects);
  utility::registersharedfunc("player", "shellShock", &shellshock_utility::_shellshock);
  utility::registersharedfunc("player", "stopShellShock", &shellshock_utility::_stopshellshock);
  utility::registersharedfunc("player", "fadeToBlackForPlayer", &game_utility::fadetoblackforplayer);
  utility::registersharedfunc("player", "playerHasMoved", &playerlogic::playerhasmoved);
  utility::registersharedfunc("player", "checkHit", &scripts\mp\weapons::checkhit);
  utility::registersharedfunc("player", "setDOF_cruiseFirst", undefined);
  utility::registersharedfunc("player", "addExtraMoveSpeed", &weapons::addextramovespeed);
  utility::registersharedfunc("player", "removeExtraMoveSpeed", &weapons::removeextramovespeed);
  utility::registersharedfunc("player", "updateMoveSpeed", &weapons::updatemovespeedscale);
  utility::registersharedfunc("player", "isSpawnProtected", &game_utility::isspawnprotected);
}

function function_e1e9831c1bcd6f59(eattacker, idamage) {
  if(namespace_d36e6800233f4f97::function_cfe304859f30e747("gulagTrackPlayerBulletHitAI")) {
    namespace_d36e6800233f4f97::function_3cceb052d780fef1("gulagTrackPlayerBulletHitAI", eattacker, idamage);
  }
}

function host_migration_init() {
  utility::registersharedfunc("hostmigration", "waitLongDurationWithPause", &hostmigration::waitlongdurationwithhostmigrationpause);
  utility::registersharedfunc("hostmigration", "waittillNotifyOrTimeoutPause", &hostmigration::waittill_notify_or_timeout_hostmigration_pause);
}

function vehicle_init() {
  utility::registersharedfunc("vehicle", "init", &vehicle_mp::vehicle_mp_init);
  utility::registersharedfunc("vehicle", "incrementFauxVehicleCount", &killstreak::incrementfauxvehiclecount);
  utility::registersharedfunc("vehicle", "decrementFauxVehicleCount", &killstreak::decrementfauxvehiclecount);
  utility::registersharedfunc("vehicle", "reserveVehicle", &vehicle_tracking::reservevehicle);
  utility::registersharedfunc("vehicle", "clearVehicleReservation", &vehicle_tracking::clearvehiclereservation);
  utility::registersharedfunc("vehicle", "spawnVehicle", &vehicle_tracking::_spawnvehicle);
  utility::registersharedfunc("vehicle", "deleteVehicle", &vehicle_tracking::_deletevehicle);
  utility::registersharedfunc("vehicle", "registerInstance", &vehicle_tracking::vehicle_tracking_registerinstance);
  utility::registersharedfunc("vehicle", "deregisterInstance", &vehicle_tracking::vehicle_tracking_deregisterinstance);
  utility::registersharedfunc("vehicle", "isVehicleWeapon", &weapon::isvehicleweapon);
}

function game_init() {
  utility::registersharedfunc("game", "isAnyMLGMatch", &game_utility::isanymlgmatch);
  utility::registersharedfunc("game", "isKillStreakDenied", &game_utility::iskillstreakdenied);
  utility::registersharedfunc("game", "lpcFeatureGated", &game_utility::lpcfeaturegated);
  utility::registersharedfunc("game", "objectiveUnPinPlayer", &objidpoolmanager::objective_unpin_player);
  utility::registersharedfunc("game", "isMLGMatch", &game_utility::ismlgmatch);
  utility::registersharedfunc("game", "getGameType", &game_utility::getgametype);
  utility::registersharedfunc("game", "getEnemyTeams", &teams::getenemyteams);
  utility::registersharedfunc("game", "getOtherTeam", &game_utility::getotherteam);
  utility::registersharedfunc("game", "getTeamData", &teams::getteamdata);
  utility::registersharedfunc("game", "createObjective", &objidpoolmanager::createobjective);
  utility::registersharedfunc("game", "createObjectiveEngineer", &objidpoolmanager::createobjective_engineer);
  utility::registersharedfunc("game", "createObjectiveHidden", &objidpoolmanager::function_c1a18d4076f420a5);
  utility::registersharedfunc("game", "requestObjectiveID", &objidpoolmanager::requestobjectiveid);
  utility::registersharedfunc("game", "returnObjectiveID", &objidpoolmanager::returnobjectiveid);
  utility::registersharedfunc("game", "handlemovingplatforms", &movers::handle_moving_platforms);
  utility::registersharedfunc("game", "registerEntForOOB", &outofbounds::registerentforoob);
  utility::registersharedfunc("game", "clearOOB", &outofbounds::clearoob);
  utility::registersharedfunc("game", "onEnterOOBTrigger", &outofbounds::onenteroobtrigger);
  utility::registersharedfunc("game", "onExitOOBTrigger", &outofbounds::onexitoobtrigger);
  utility::registersharedfunc("game", "checkInvalidOOBTriggers", &outofbounds::checkinvalidoobtriggers);
  utility::registersharedfunc("game", "isGameplayTeam", &teams::isgameplayteam);
  utility::registersharedfunc("game", "getGametypeNumLives", &game_utility::getgametypenumlives);
  utility::registersharedfunc("game", "getFriendlyPlayers", &teams::getfriendlyplayers);
  utility::registersharedfunc("game", "getSquadmates", &teams::getsquadmates);
  utility::registersharedfunc("game", "registerOnPlayerSpawnCallback", &spawn_event_aggregator::registeronplayerspawncallback);
  utility::registersharedfunc("game", "registerPlayerFrameUpdateCallback", &player_frame_update_aggregator::registerplayerframeupdatecallback);
  utility::registersharedfunc("game", "trySayLocalSound", &battlechatter_mp::trysaylocalsound);
  utility::registersharedfunc("game", "tutorialPrint", &print::tutorialprint);
  utility::registersharedfunc("game", "setOverTimeLimitDvar", &game_utility::setovertimelimitdvar);
  utility::registersharedfunc("game", "getHostPlayer", &gamelogic::gethostplayer);
  utility::registersharedfunc("game", "brGetOperatorTeam", &br_public::brgetoperatorteam);
  utility::registersharedfunc("game", "gameFlag", &flags::gameflag);
  utility::registersharedfunc("game", "makeEnterExitTrigger", &trigger::makeenterexittrigger);
  utility::registersharedfunc("game", "registerSentient", &sentientpoolmanager::registersentient);
  utility::registersharedfunc("game", "unregisterSentient", &sentientpoolmanager::unregistersentient);
  utility::registersharedfunc("game", "gameflagSet", &flags::gameflagset);
  utility::registersharedfunc("game", "gameflagClear", &flags::gameflagclear);
  utility::registersharedfunc("game", "isFeatureDisabled", &br_gametypes::isfeaturedisabled);
  utility::registersharedfunc("game", "checkForActiveObjIcon", &namespace_c133516bfc1d803c::checkforactiveobjicon);
  utility::registersharedfunc("game", "deleteQuestObjIcon", &namespace_c133516bfc1d803c::deletequestobjicon);
  utility::registersharedfunc("game", "spawnPickup", &br_pickups::spawnpickup);
  utility::registersharedfunc("game", "getItemDropOriginAndAngles", &br_pickups::getitemdroporiginandangles);
  utility::registersharedfunc("game", "br_forceGiveCustomPickupItem", &br_pickups::br_forcegivecustompickupitem);
  utility::registersharedfunc("game", "brAnalytics_kiosk_purchaseItem", &br_analytics::branalytics_kiosk_purchaseitem);
  utility::registersharedfunc("game", "runBrGametypeFunc", &br_gametypes::runbrgametypefunc);
  utility::registersharedfunc("game", "isKiosk", &br_public::iskiosk);
  utility::registersharedfunc("game", "canTakePickup", &br_pickups::cantakepickup);
  utility::registersharedfunc("game", "lootItem", &scripts\mp\gametypes\br_pickups::lootitem);
  utility::registersharedfunc("game", "isGasMask", &scripts\mp\gametypes\br_pickups::isgasmask);
  utility::registersharedfunc("game", "equipBackpackItem", &scripts\mp\gametypes\br_pickups::equipbackpackitem);
  utility::registersharedfunc("game", "getGasMaskLootID", &scripts\mp\gametypes\br_pickups::getgasmasklootid);
  utility::registersharedfunc("game", "getBagTypeForPlayer", &scripts\mp\gametypes\br_pickups::getbagtypeforplayer);
  utility::registersharedfunc("game", "quickDropGasMaskItem", &scripts\mp\gametypes\br_pickups::quickdropgasmaskitem);
  utility::registersharedfunc("game", "getWeaponPickupRarity", &scripts\mp\gametypes\br_pickups::getweaponpickuprarity);
  utility::registersharedfunc("game", "brAnalytics_kiosk_menu_event", &br_analytics::branalytics_kiosk_menu_event);
  utility::registersharedfunc("game", "createQuestObjIcon", &namespace_c133516bfc1d803c::createquestobjicon);
  utility::registersharedfunc("game", "showQuestObjIconToPlayer", &namespace_c133516bfc1d803c::showquestobjicontoplayer);
  utility::registersharedfunc("game", "hideQuestObjIconFromPlayer", &namespace_c133516bfc1d803c::hidequestobjiconfromplayer);
  utility::registersharedfunc("game", "isPublicEventOfTypeActive", &br_publicevents::ispubliceventoftypeactive);
  utility::registersharedfunc("game", "isBrPracticeMode", &br_public::isbrpracticemode);
  utility::registersharedfunc("game", "isJuggerMoshGameMode", &scripts\mp\utility\game::isjuggermoshgamemode);
  utility::registersharedfunc("game", "isMutationGameMode", &scripts\mp\utility\game::ismutationgamemode);
  utility::registersharedfunc("game", "isMutationGameModeZombie", &scripts\mp\utility\game::ismutationgamemodezombie);
  utility::registersharedfunc("game", "respawnTokenDisabled", &br_pickups::respawntokendisabled);
  utility::registersharedfunc("game", "traceSelectedMapLocation", &br::traceselectedmaplocation);
  utility::registersharedfunc("game", "getDefaultWeaponAmmo", &br_gametype_dmz::getdefaultweaponammo);
  utility::registersharedfunc("game", "getTeamData", &teams::getteamdata);
  utility::registersharedfunc("game", "isBackpackInventoryEnabled", &namespace_e50e624d9af51c8c::isbackpackinventoryenabled);
  utility::registersharedfunc("game", "isGameplayTeam", &scripts\mp\utility\teams::isgameplayteam);
  utility::registersharedfunc("game", "getOperatorCustomization", &scripts\mp\teams::getoperatorcustomization);
  utility::registersharedfunc("game", "getPlayerBackpackSize", &namespace_aead94004cf4c147::getplayerbackpacksize);
  utility::registersharedfunc("game", "getLootIDAtBackpackIndex", &namespace_aead94004cf4c147::getlootidatbackpackindex);
  utility::registersharedfunc("game", "isContainerOpen", &scripts\mp\loot::iscontaineropen);
  utility::registersharedfunc("game", "closeLootableContainer", &scripts\mp\loot::closelootablecontainer);
  utility::registersharedfunc("game", "isPointInMultiCircleDanger", &scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger);
  utility::registersharedfunc("game", "calculatePurchaseXp", &br::calculatepurchasexp);
  utility::registersharedfunc("game", "isAnyTutorialOrBotPracticeMatch", &br_public::isanytutorialorbotpracticematch);
  utility::registersharedfunc("game", "registerOnLuiEventCallback", &lui_game_event_aggregator::registeronluieventcallback);
  utility::registersharedfunc("game", "isLoadoutIndexDefault", &menus::isloadoutindexdefault);
  utility::registersharedfunc("game", "getClassChoice", &menus::getclasschoice);
  utility::registersharedfunc("game", "isBrGametypeFuncDefined", &br_gametypes::isbrgametypefuncdefined);
  utility::registersharedfunc("game", "utilFlare_shootFlare", &namespace_c133516bfc1d803c::utilflare_shootflare);
  utility::registersharedfunc("game", "isValidPointInBounds", &br_circle::isvalidpointinbounds);
  utility::registersharedfunc("game", "initCirclePostStartToCircleIndex", &br_circle::initcirclepoststarttocircleindex);
  utility::registersharedfunc("game", "isFeatureEnabled", &br_gametypes::isfeatureenabled);
  utility::registersharedfunc("game", "spectate_init", &br_spectate::spectate_init);
  utility::registersharedfunc("game", "createHintObject", &gameobjects::createhintobject);
  utility::registersharedfunc("game", "processTouchEnt", &gameobjects::processtouchent);
  utility::registersharedfunc("game", "updateUIProgress", &gameobjects::updateuiprogress);
  utility::registersharedfunc("game", "isBRStyleGameType", &game_utility::isbrstylegametype);
  utility::registersharedfunc("game", "non_player_add_ignore_damage_signature", &damage::non_player_add_ignore_damage_signature);
  utility::registersharedfunc("game", "non_player_remove_ignore_damage_signature", &damage::non_player_remove_ignore_damage_signature);
  utility::registersharedfunc("game", "registerScoreInfo", &rank::registerscoreinfo);
  utility::registersharedfunc("game", "addSpawnViewer", &spawnlogic::addspawnviewer);
  utility::registersharedfunc("game", "removeSpawnViewer", &spawnlogic::removespawnviewer);
  utility::registersharedfunc("game", "getEntitiesInRadius", &entity::getentitiesinradius);
  utility::registersharedfunc("game", "isPointInOutOfBounds", &outofbounds::ispointinoutofbounds);
  utility::registersharedfunc("game", "findboxcenter", &spawnlogic::findboxcenter);
  utility::registersharedfunc("game", "isTeamReviveEnabled", &game_utility::isteamreviveenabled);
  utility::registersharedfunc("game", "clearSpawnProtection", &game_utility::clearspawnprotection);
  utility::registersharedfunc("game", "isLifeLimited", &game_utility::islifelimited);
  utility::registersharedfunc("game", "isRoundBased", &scripts\mp\utility\game::isroundbased);
  utility::registersharedfunc("game", "adjustVoxelHead", &scripts\mp\damage::adjustvoxelhead);
}

function spawn_init() {
  utility::registersharedfunc("spawn", "addSpawnDangerZone", &spawnlogic::addspawndangerzone);
  utility::registersharedfunc("spawn", "removeSpawnDangerZone", &spawnlogic::removespawndangerzone);
  utility::registersharedfunc("spawn", "isSpawnDangerZoneAlive", &spawnlogic::isspawndangerzonealive);
  utility::registersharedfunc("spawn", "getCodeHandleFromScriptHandle", &spawnlogic::influencepoint_getcodehandlefromscripthandle);
}

function objective_init() {
  utility::registersharedfunc(#"objective", #"showtoplayer", &objidpoolmanager::objective_playermask_addshowplayer);
  utility::registersharedfunc(#"objective", #"hidefromplayer", &objidpoolmanager::objective_playermask_hidefrom);
  utility::registersharedfunc(#"objective", #"hidefromall", &objidpoolmanager::objective_playermask_hidefromall);
  utility::registersharedfunc(#"objective", #"hash_8114455fc014da35", &objidpoolmanager::function_fa3c420e27b5d08b);
  utility::registersharedfunc(#"objective", #"objective_add_objective", &objidpoolmanager::objective_add_objective);
  utility::registersharedfunc(#"objective", #"objective_set_play_intro", &objidpoolmanager::objective_set_play_intro);
  utility::registersharedfunc(#"objective", #"objective_set_play_outro", &objidpoolmanager::objective_set_play_outro);
  utility::registersharedfunc(#"objective", #"update_objective_onentity", &objidpoolmanager::update_objective_onentity);
  utility::registersharedfunc(#"objective", #"update_objective_setbackground", &objidpoolmanager::update_objective_setbackground);
  utility::registersharedfunc(#"objective", #"update_objective_ownerteam", &objidpoolmanager::update_objective_ownerteam);
  utility::registersharedfunc(#"objective", #"update_objective_ownerclient", &objidpoolmanager::update_objective_ownerclient);
}

function emp_init() {
  utility::registersharedfunc(#"emp", #"init", &emp_debuff_mp::emp_debuff_init);
  utility::registersharedfunc(#"emp", #"hash_a865e3770eb96298", &emp_debuff::function_ecb3af104f3ab0f4);
  utility::registersharedfunc(#"emp", #"emp_debuff_deregister", &emp_debuff::emp_debuff_deregister);
  utility::registersharedfunc("emp", "getPlayerEMPImmune", &emp_debuff_mp::getplayerempimmune);
  utility::registersharedfunc("emp", "setPlayerEMPImmune", &emp_debuff_mp::setplayerempimmune);
  utility::registersharedfunc("emp", "onPlayerEMPed", &emp_debuff_mp::onplayeremped);
  utility::registersharedfunc("emp", "onVehicleEMPed", &emp_debuff_mp::onvehicleemped);
}

function execution_init() {
  utility::registersharedfunc("execution", "init", &execution_mp::execution_mp_init);
}

function weapons_init() {
  utility::registersharedfunc("weapons", "enableBurnFX", &weapons::enableburnfx);
  utility::registersharedfunc("weapons", "disableBurnFX", &weapons::disableburnfx);
  utility::registersharedfunc("weapons", "_launchGrenade", &weapon::_launchgrenade);
  utility::registersharedfunc("weapons", "mapWeapon", &weapon::mapweapon);
  utility::registersharedfunc("weapons", "gas_createTrigger", &gas_grenade::gas_createtrigger);
  utility::registersharedfunc("weapons", "getDefaultWeaponBaseName", &weapon::getdefaultweaponbasename);
  utility::registersharedfunc("weapons", "isCACPrimaryOrSecondary", &weapon::iscacprimaryorsecondary);
  utility::registersharedfunc("weapons", "attachmentIsSelectable", &weapon::attachmentisselectable);
  utility::registersharedfunc("weapons", "saveToggleScopeStates", &weapons::savetogglescopestates);
  utility::registersharedfunc("weapons", "saveAltStates", &weapons::savealtstates);
  utility::registersharedfunc("weapons", "updateSavedAltState", &weapons::updatesavedaltstate);
  utility::registersharedfunc("weapons", "updateToggleScopeState", &weapons::updatetogglescopestate);
  utility::registersharedfunc("weapons", "onEquipmentPlanted", &scripts\mp\weapons::onequipmentplanted);
  utility::registersharedfunc("weapons", "removeEquip", &scripts\mp\weapons::removeequip);
  utility::registersharedfunc("weapons", "magicBullet", &weapon_utility::_magicbullet);
  utility::registersharedfunc("weapons", "watchForPlacementFireState", &target_marker::watchforplacementfirestate);
  utility::registersharedfunc("weapons", "dropWeaponForDeath", &weapons::dropweaponfordeath);
  utility::registersharedfunc("weapons", "getWeaponGroup", &scripts\mp\utility\weapon::getweapongroup);
  utility::registersharedfunc("weapons", "isSuperWeapon", &scripts\mp\utility\weapon::issuperweapon);
  utility::registersharedfunc("weapons", "isLoadoutWeapon", &scripts\mp\utility\weapon::isloadoutweapon);
  utility::registersharedfunc("weapons", "monitorDisownedGrenade", &scripts\mp\weapons::monitordisownedgrenade);
}

function damage_init() {
  utility::registersharedfunc("damage", "enqueueCorpsetableFunc", &damage::enqueuecorpsetablefunc);
  utility::registersharedfunc("damage", "dequeueCorpsetableFunc", &damage::dequeuecorpsetablefunc);
  utility::registersharedfunc("damage", "updateDamageFeedback", &damagefeedback::updatedamagefeedback);
  utility::registersharedfunc("damage", "onKillstreakKilled", &damage::onkillstreakkilled);
  utility::registersharedfunc("damage", "logAttackerKillstreak", &damage::logattackerkillstreak);
  utility::registersharedfunc("damage", "handleDamageFeedback", &damage::handledamagefeedback);
  utility::registersharedfunc("damage", "_suicide", &damage::_suicide);
  utility::registersharedfunc("damage", "hudIconType", &damagefeedback::hudicontype);
  utility::registersharedfunc("damage", "handleAPDamage", &damage::handleapdamage);
  utility::registersharedfunc("damage", "monitorDamage", &damage::monitordamage);
  utility::registersharedfunc("damage", "isFMJDamage", &damage::isfmjdamage);
  utility::registersharedfunc("damage", "handleAPAmmoDamage", &damage::handleapammodamage);
  utility::registersharedfunc("damage", "handleAkimboDamage", &damage::handleakimbodamage);
  utility::registersharedfunc("damage", "monitorDamage", &damage::monitordamage);
}

function sound_init() {
  utility::registersharedfunc("sound", "trySayLocalSound", &battlechatter_mp::trysaylocalsound);
  utility::registersharedfunc("sound", "playKillstreakDeployDialog", &battlechatter_mp::playkillstreakdeploydialog);
  utility::registersharedfunc("sound", "playSoundOnTag", &sound::play_sound_on_tag);
  utility::registersharedfunc("sound", "CodcasterSetPlayerStatusEffect", &player::codcastersetplayerstatuseffect);
}

function flares_init() {
  utility::registersharedfunc("flares", "handleIncomingStinger", &flares::flares_handleincomingstinger);
  utility::registersharedfunc("flares", "reduceReserves", &flares::flares_reducereserves);
  utility::registersharedfunc("flares", "deploy", &flares::flares_deploy);
  utility::registersharedfunc("flares", "playFx", &flares::flares_playfx);
}

function shellshock_init() {
  utility::registersharedfunc("shellshock", "artillery_earthQuake", &shellshock::artillery_earthquake);
  utility::registersharedfunc("shellshock", "grenade_earthQuakeAtPosition", &shellshock::grenade_earthquakeatposition);
}

function bots_init() {
  utility::registersharedfunc("bots", "get_random_outside_target", &bots_killstreaks_remote_vehicle::get_random_outside_target);
  utility::registersharedfunc("bots", "bot_body_is_dead", &bots_killstreaks_remote_vehicle::bot_body_is_dead);
}

function agents_init() {
  namespace_84c887a505a8f661::function_ce55987060167d4a();
  utility::registersharedfunc("agents", "deactivateAgent", &agent_utility::deactivateagent);
  utility::registersharedfunc("agents", "spawnNewAgentAiType", &mp_agent::spawnnewagentaitype);
}

function outline_init() {
  utility::registersharedfunc("outline", "outlineDisable", &outline::outlinedisable);
  utility::registersharedfunc("outline", "outlineEnableForPlayer", &outline::outlineenableforplayer);
  utility::registersharedfunc("outline", "outlineEnableForTeam", &outline::outlineenableforteam);
  utility::registersharedfunc("outline", "hudOutlineViewmodelEnable", &outline::_hudoutlineviewmodelenable);
  utility::registersharedfunc("outline", "hudOutlineViewmodelDisable", &outline::_hudoutlineviewmodeldisable);
}

function game_utility_init() {
  utility::registersharedfunc("game_utility", "init", &game_utility_mp::game_utility_mp_init);
}

function function_b9e6cdc26386e536() {
  utility::registersharedfunc("dvar_utility", "getFloatProperty", &dvars::getfloatproperty);
}

function rank_init() {
  utility::registersharedfunc("rank", "getScoreInfoValue", &rank::getscoreinfovalue);
  utility::registersharedfunc("rank", "getScoreInfoXP", &rank::getscoreinfoxp);
  utility::registersharedfunc("rank", "giveRankXP", &rank::giverankxp);
  utility::registersharedfunc("rank", "scoreEventPopup", &rank::scoreeventpopup);
  utility::registersharedfunc("rank", "displayScoreEventPoints", &points::displayscoreeventpoints);
  utility::registersharedfunc("rank", "killEventTextPopup", &events::killeventtextpopup);
}

function stats_init() {
  registersharedfunc("stats", "getPersStat", &scripts\mp\utility\stats::getpersstat);
}

function supers_init() {
  utility::registersharedfunc("supers", "giveSuper", &supers::givesuper);
  utility::registersharedfunc("supers", "giveSuperPoints", &supers::givesuperpoints);
  utility::registersharedfunc("supers", "superUseFinished", &supers::superusefinished);
  utility::registersharedfunc("supers", "getSuperPointsNeeded", &supers::getsuperpointsneeded);
  utility::registersharedfunc("supers", "combatRecordSuperMisc", &supers::combatrecordsupermisc);
  utility::registersharedfunc("supers", "hasAPRRounds", &super_suppression_rounds::function_1da49fb6441f8ab2);
  utility::registersharedfunc("supers", "setSuperBasePoints", &supers::setsuperbasepoints);
  utility::registersharedfunc("supers", "refundSuper", &supers::refundsuper);
  utility::registersharedfunc("supers", "setSuperIsInUse", &supers::setsuperisinuse);
  utility::registersharedfunc("supers", "setSuperIsActive", &supers::setsuperisactive);
  utility::registersharedfunc("supers", "getCurrentSuper", &supers::getcurrentsuper);
  utility::registersharedfunc("supers", "tryGiveUseWeapon", &supers::trygiveuseweapon);
  utility::registersharedfunc("supers", "isSuperInUse", &supers::issuperinuse);
  utility::registersharedfunc("supers", "getSuperRefForSuperOffhand", &supers::getsuperrefforsuperoffhand);
  utility::registersharedfunc("supers", "updateSuperUIProgress", &supers::updatesuperuiprogress);
  utility::registersharedfunc("supers", "updateSuperUIState", &supers::updatesuperuistate);
  utility::registersharedfunc("supers", "handleSuperUIStateChange", &supers::handlesuperuistatechange);
}

function gamescore_init() {
  utility::registersharedfunc("gamescore", "trackDebuffAssist", &gamescore::trackdebuffassist);
  utility::registersharedfunc("gamescore", "untrackDebuffAssist", &gamescore::untrackdebuffassist);
}

function pers_init() {
  utility::registersharedfunc("pers", "incPersStat", &stats::incpersstat);
}

function dlog_init() {
  utility::registersharedfunc("dlog", "fieldUpgradeExpired", &analyticslog::logevent_fieldupgradeexpired);
  utility::registersharedfunc("dlog", "killStreakExpired", &analyticslog::logevent_killstreakexpired);
  utility::registersharedfunc("dlog", "brAnalytics_inventory_snapshot", &br_analytics::branalytics_inventory_snapshot);
  utility::registersharedfunc("dlog", "brAnalytics_kiosk_purchaseLoadout", &br_analytics::branalytics_kiosk_purchaseloadout);
}

function challenges_init() {
  utility::registersharedfunc("challenges", "onVehicleKilled", &challenges::vehiclekilled);
  utility::registersharedfunc("challenges", "onFieldUpgradeEnd", &challenges::function_bd59aa7e8cece1ab);
  utility::registersharedfunc("challenges", "onKillStreakEnd", &challenges::function_597bc208d923a465);
  utility::registersharedfunc("challenges", "resetChallengeTimer", &challenges::resetchallengetimer);
  utility::registersharedfunc("challenges", "startChallengeTimer", &challenges::startchallengetimer);
  utility::registersharedfunc("challenges", "stopChallengeTimer", &challenges::stopchallengetimer);
  utility::registersharedfunc("challenges", "onPing", &challenges::onping);
}

function function_a92ed2f4c44e5ffa() {
  utility::registersharedfunc("team_utility", "init", &teams::function_f6728366ba30005c);
  utility::registersharedfunc("team_utility", "joinTeamAggregator", &join_team_aggregator::registeronplayerjointeamcallback);
}

function aggregator_init() {
  utility::registersharedfunc("aggregator", "registerOnPlayerSpawnCallback", &spawn_event_aggregator::registeronplayerspawncallback);
  utility::registersharedfunc("aggregator", "registerOnLuiEventCallback", &lui_game_event_aggregator::registeronluieventcallback);
}

function vehicle_damage_init() {
  utility::registersharedfunc("vehicle", "get_weapon_hit_damage_data", &damage::get_weapon_hit_damage_data);
  utility::registersharedfunc("vehicle", "get_vehicle_hit_damage_data", &damage::get_vehicle_hit_damage_data);
  utility::registersharedfunc("vehicle", "set_vehicle_hit_damage_data_for_weapon", &damage::set_vehicle_hit_damage_data_for_weapon);
}

function cameras_init() {
  utility::registersharedfunc("cameras", "tacticalCamera_Hack", &tactical_camera::tacticalcamera_hack);
}

function function_a30b248a8fc67a00() {
  utility::registersharedfunc("objdom", "distSquaredCheck", &obj_dom::distsquaredcheck);
}

function battlechatter_init() {
  utility::registersharedfunc("battlechatter", "equipmentDestroyed", &battlechatter_mp::equipmentdestroyed);
  utility::registersharedfunc("battlechatter", "onFieldUpgradeDestroy", &battlechatter_mp::onfieldupgradedestroy);
}

function loadout_init() {
  utility::registersharedfunc("loadout", "cac_getFlcExtraEquipmentPrimary", &class::cac_getflcextraequipmentprimary);
  utility::registersharedfunc("loadout", "cac_getFlcExtraEquipmentSecondary", &class::cac_getflcextraequipmentsecondary);
  utility::registersharedfunc("loadout", "table_getFlcExtraEquipmentPrimary", &class::table_getflcextraequipmentprimary);
  utility::registersharedfunc("loadout", "table_getFlcExtraEquipmentSecondary", &class::table_getflcextraequipmentsecondary);
  utility::registersharedfunc("loadout", "loadout_getClassType", &class::loadout_getclasstype);
  utility::registersharedfunc("loadout", "getExtraEquipmentPrimary", &class::cac_getextraequipmentprimary);
  utility::registersharedfunc("loadout", "getExtraEquipmentSecondary", &class::cac_getextraequipmentsecondary);
}

function function_f677f2d747d21482() {}

function function_52b5f55ca64bd530() {
  utility::registersharedfunc("featurebans", "featurebans_vehicleExplode", &scripts\mp\featurebans::featurebans_vehicleexplode);
  utility::registersharedfunc("featurebans", "featurebans_jumpScare", &scripts\mp\featurebans::featurebans_jumpscare);
}