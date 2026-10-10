/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5513783c21494d08.gsc
*************************************************/

#using script_2709f0932dd1e5a7;
#using script_3a8f9ace195c9da9;
#using script_5b3c060b476939a8;
#using script_68fa6b4ee60216ae;
#using script_7118a63f6a493ea8;
#using script_be30eb214e1af7b;
#using scripts\common\shellshock_utility;
#using scripts\common\utility;
#using scripts\cp\agent_damage;
#using scripts\cp\challenges_cp;
#using scripts\cp\cp_anim;
#using scripts\cp\cp_flares;
#using scripts\cp\cp_gameskill;
#using scripts\cp\cp_hostmigration;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_hud_util;
#using scripts\cp\cp_mapselect;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_outline_utility;
#using scripts\cp\cp_outofbounds;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\cp_relics;
#using scripts\cp\cp_weapons;
#using scripts\cp\damage;
#using scripts\cp\emp_debuff_cp;
#using scripts\cp\equipment;
#using scripts\cp\equipment\cp_gas_grenade;
#using scripts\cp\equipment\throwing_knife_cp;
#using scripts\cp\events;
#using scripts\cp\inventory\cp_target_marker;
#using scripts\cp\killstreaks\assault_drone_cp;
#using scripts\cp\killstreaks\chopper_gunner_cp;
#using scripts\cp\killstreaks\cruise_predator_cp;
#using scripts\cp\killstreaks\init_cp;
#using scripts\cp\kits;
#using scripts\cp\laststand;
#using scripts\cp\munitions;
#using scripts\cp\perks;
#using scripts\cp\perks\cp_perks;
#using scripts\cp\pickups;
#using scripts\cp\points;
#using scripts\cp\rank;
#using scripts\cp\super;
#using scripts\cp\utility;
#using scripts\cp\utility\game_utility_cp;
#using scripts\cp\utility\lui_game_event_aggregator;
#using scripts\cp\utility\player;
#using scripts\cp\utility\player_utility_cp;
#using scripts\cp\utility\spawn_event_aggregator;
#using scripts\cp\vehicles\vehicle_cp;
#using scripts\cp\weapon;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\pickups;
#using scripts\cp_mp\supers\supers;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\mp\utility\trigger;
#namespace namespace_657dc7e018dcfce9;

function init() {
  namespace_c3fdc5febda99c60::init();
  perk_init();
  anim_init();
  hud_init();
  killstreak_init();
  equipment_init();
  player_init();
  vehicle_init();
  host_migration_init();
  game_init();
  emp_init();
  weapons_init();
  damage_init();
  entity_init();
  sound_init();
  flares_init();
  shellshock_init();
  outline_init();
  game_utility_init();
  rank_init();
  supers_init();
  gamescore_init();
  stealth_init();
  gameskill_init();
  function_c1199c7cd79918b3();
  function_1e223bbe18efd769();
  challenges_init();
  function_bbe0803dcadd7d18();
  function_f677f2d747d21482();
}

function perk_init() {
  registersharedfunc("perk", "hasPerk", &scripts\cp\utility::_hasperk);
  registersharedfunc("perk", "givePerk", &scripts\cp\utility::giveperk);
  registersharedfunc("perk", "removePerk", &scripts\cp\perks::removeperk);
  registersharedfunc("perk", "activatePerk", &scripts\cp\perks\cp_perks::activateperk);
}

function gameskill_init() {
  registersharedfunc("gameskill", "updatePlayerAttackerAccuracy", &scripts\cp\cp_gameskill::update_player_attacker_accuracy);
}

function stealth_init() {
  registersharedfunc("stealth", "init", &namespace_dbc09aedfbfae91f::init);
  registersharedfunc("stealth", "revertAiAccuracy", &namespace_dbc09aedfbfae91f::revertaiaccuracy);
  registersharedfunc("stealth", "dropAiAccuracy", &namespace_dbc09aedfbfae91f::dropaiaccuracy);
  registersharedfunc("stealth", "spotted_event_handler", &namespace_dbc09aedfbfae91f::function_5af9997f0eefb9a2);
  registersharedfunc("stealth_music", "init", &namespace_7421af812c81d88b::init);
  registersharedfunc("stealth_enemy", "init", &namespace_f07a91c6c17492be::init);
  registersharedfunc("stealth_player", "init", &namespace_dbc09aedfbfae91f::init_player);
}

function anim_init() {
  registersharedfunc("anim", "player_solo", &scripts\cp\cp_anim::anim_player_solo);
}

function hud_init() {
  registersharedfunc("hud", "showErrorMessage", &scripts\cp\cp_hud_message::showerrormessage);
  registersharedfunc("hud", "teamPlayerCardSplash", &scripts\cp\cp_hud_util::teamplayercardsplash);
  registersharedfunc("hud", "showSplash", &scripts\cp\cp_hud_message::showsplash);
}

function killstreak_init() {
  registersharedfunc("killstreak", "init", &scripts\cp\killstreaks\init_cp::init);
  registersharedfunc("killstreak", "addToActiveKillstreakList", &scripts\cp\utility::addtoactivekillstreaklist);
  registersharedfunc("killstreak", "allowRideKillstreakPlayerExit", &scripts\cp\utility::allowridekillstreakplayerexit);
  registersharedfunc("killstreak", "getSelectMapPoint", &scripts\cp\cp_mapselect::getselectmappoint);
  registersharedfunc("killstreak", "startMapSelectSequence", &scripts\cp\cp_mapselect::startmapselectsequence);
  registersharedfunc("killstreak", "killstreakMakeVehicle", &scripts\cp\utility::killstreak_make_vehicle);
  registersharedfunc("killstreak", "killstreakSetPreModDamageCallback", &scripts\cp\utility::killstreak_set_pre_mod_damage_callback);
  registersharedfunc("killstreak", "killstreakSetPostModDamageCallback", &scripts\cp\utility::killstreak_set_post_mod_damage_callback);
  registersharedfunc("killstreak", "killstreakSetDeathCallback", &scripts\cp\utility::killstreak_set_death_callback);
  registersharedfunc("killstreak", "killstreakHit", &scripts\cp\utility::killstreakhit);
  registersharedfunc("killstreak", "createCustomStreakData", &scripts\cp\killstreaks\init_cp::init_killstreak_data_for_challenges);
  registersharedfunc("killstreak", "setKillstreakControlPriority", &scripts\cp\utility::setkillstreakcontrolpriority);
  registersharedfunc("killstreak", "killstreakUse", &scripts\cp\kits::function_76634baec9299866);
  registersharedfunc("killstreak", "getModifiedAntiKillstreakDamage", &scripts\cp\damage::getmodifiedantikillstreakdamage);
  registersharedfunc("killstreak", "waittill_confirm_or_cancel", &scripts\cp\cp_mapselect::waittill_confirm_or_cancel);
  registersharedfunc("killstreak", "getTargetMarker", &scripts\cp\inventory\cp_target_marker::gettargetmarker);
  registersharedfunc("killstreak", "refundKillstreak", &scripts\cp\kits::kit_givekillstreak);
  registersharedfunc("killstreak", "makePlayerVulnerableOnAssaultDroneDetonate", &scripts\cp\killstreaks\assault_drone_cp::function_28fc7edb00dd6601);
  registersharedfunc("killstreak", "makePlayerVulnerableOnCruisePredatorDetonate", &scripts\cp\killstreaks\cruise_predator_cp::function_8a023375b0197bdc);
  registersharedfunc("killstreak", "makeChopperGunnerTargetableByAI", &scripts\cp\killstreaks\chopper_gunner_cp::function_6a41bef845f5c144);
  registersharedfunc("killstreak", "doDamageToKillstreak", &scripts\cp\munitions::function_8c2b940cf1550e4d);
}

function equipment_init() {
  registersharedfunc("throwing_knife", "init", &scripts\cp\equipment\throwing_knife_cp::throwing_knife_cp_init);
  registersharedfunc("equipment", "getEquipmentRefFromWeapon", &scripts\cp_mp\equipment::getequipmentreffromweapon);
  registersharedfunc("equipment", "equipment_init", &scripts\cp\equipment::equipment_init);
  registersharedfunc("weapons", "attachmentIsSelectable", &scripts\cp\weapon::attachmentisselectable);
  registersharedfunc("equipment", "getEquipmentTableInfo", &scripts\cp\equipment::getequipmenttableinfo);
  registersharedfunc("equipment", "hackEquipment", &scripts\cp\equipment::function_e0ef70f764b4a4c7);
  registersharedfunc("equipment", "autorefillequipmentammo", &scripts\cp\equipment::autorefillequipmentammo);
  registersharedfunc("equipment", "isPlantedEquipment", &scripts\cp\weapon::isplantedequipment);
  registersharedfunc("equipment", "deleteExplosive", &scripts\cp\weapon::deleteexplosive);
  registersharedfunc("oxygenmask", "init", &namespace_4bb5eda89afac572::function_234851f94416f178);
}

function player_init() {
  registersharedfunc("player", "_isAlive", &scripts\cp\utility\player_utility_cp::_isalive);
  registersharedfunc("player", "setUsingRemote", &scripts\cp\utility\player::setusingremote);
  registersharedfunc("player", "clearUsingRemote", &scripts\cp\utility\player::clearusingremote);
  registersharedfunc("player", "freezeControls", &scripts\cp\utility::_freezecontrols);
  registersharedfunc("player", "freezeLookControls", &scripts\cp\utility::_freezelookcontrols);
  registersharedfunc("player", "printGameAction", &printgameaction);
  registersharedfunc("player", "isPlayerADS", &isplayerads);
  registersharedfunc("player", "doScoreEvent", &scripts\cp\points::doscoreevent);
  registersharedfunc("player", "setThirdPersonDOF", &scripts\cp\utility::setthirdpersondof);
  registersharedfunc("player", "hideMiniMap", &scripts\cp\utility\player::hideminimap);
  registersharedfunc("player", "showMiniMap", &scripts\cp\utility\player::showminimap);
  registersharedfunc("player", "getPlayersInRadius", &scripts\cp\utility::getplayersinradius);
  registersharedfunc("player", "isFriendly", &scripts\cp\utility\player::isfriendly);
  registersharedfunc("player", "isReallyAlive", &scripts\cp\utility\player::isreallyalive);
  registersharedfunc("player", "getStanceCenter", &scripts\cp\utility\player::getstancecenter);
  registersharedfunc("player", "getStanceTop", &scripts\cp\utility\player::getstancetop);
  registersharedfunc("player", "surfaceFunc", &scripts\cp\utility\player::function_8196ea3bc8d5538a);
  registersharedfunc("player", "isSuperInUse", &scripts\cp\super::issuperinuse);
  registersharedfunc("player", "getCurrentSuperRef", &scripts\cp\super::getcurrentsuperref);
  registersharedfunc("player", "br_ammo_player_is_maxed_out", &scripts\cp_mp\pickups::br_ammo_player_is_maxed_out);
  registersharedfunc("player", "hasSelfReviveToken", &scripts\cp\laststand::hasselfrevivetoken);
  registersharedfunc("player", "takeWeaponPickup", &scripts\cp\pickups::takeweaponpickup);
  registersharedfunc("player", "br_ammo_player_max_out", &scripts\cp_mp\pickups::br_ammo_player_max_out);
  registersharedfunc("player", "addRespawnToken", &scripts\cp_mp\pickups::addrespawntoken);
  registersharedfunc("player", "addSelfReviveToken", &scripts\cp\pickups::addselfrevivetoken);
  registersharedfunc("player", "getAvailableDMZBackpackIndex", &scripts\cp\pickups::getavailabledmzbackpackindex);
  registersharedfunc("player", "playerPlunderKioskPurchase", &scripts\cp_mp\pickups::playerplunderkioskpurchase);
  registersharedfunc("player", "addItemToBackpack", &scripts\cp\pickups::additemtobackpack);
  registersharedfunc("player", "shellShock", &scripts\cp_mp\utility\shellshock_utility::_shellshock);
  registersharedfunc("player", "stopShellShock", &scripts\cp_mp\utility\shellshock_utility::_stopshellshock);
  registersharedfunc("player", "fadeToBlackForPlayer", &scripts\cp_mp\utility\game_utility::fadetoblackforplayer);
  registersharedfunc("player", "setDOF_cruiseFirst", undefined);
  registersharedfunc("player", "disable_backpack_inventory", &scripts\cp\utility::disable_backpack_inventory);
}

function vehicle_init() {
  registersharedfunc("vehicle", "init", &scripts\cp\vehicles\vehicle_cp::vehicle_cp_init);
  registersharedfunc("vehicle", "reserveVehicle", &scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle);
  registersharedfunc("vehicle", "clearVehicleReservation", &scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation);
  registersharedfunc("vehicle", "spawnVehicle", &scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle);
  registersharedfunc("vehicle", "deleteVehicle", &scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle);
  registersharedfunc("vehicle", "registerInstance", &scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance);
  registersharedfunc("vehicle", "deregisterInstance", &scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance);
  registersharedfunc("vehicle", "isVehicleWeapon", &scripts\cp\weapon::isvehicleweapon);
}

function host_migration_init() {
  registersharedfunc("hostmigration", "waitLongDurationWithPause", &scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause);
  registersharedfunc("hostmigration", "waittillNotifyOrTimeoutPause", &scripts\cp\cp_hostmigration::waittill_notify_or_timeout_hostmigration_pause);
}

function game_init() {
  registersharedfunc("game", "isKillStreakDenied", &isairdenied);
  registersharedfunc("game", "getEnemyTeams", &scripts\cp\utility::getenemyteams);
  registersharedfunc("game", "getGameType", &scripts\cp\utility::getgametype);
  registersharedfunc("game", "getOtherTeam", &scripts\cp\utility::getotherteam);
  registersharedfunc("game", "createObjectiveEngineer", &scripts\cp\utility::killstreak_createobjective_engineer);
  registersharedfunc("game", "createObjective", &scripts\cp\utility::killstreak_createobjective);
  registersharedfunc("game", "requestObjectiveID", &scripts\cp\utility::nonobjective_requestobjectiveid);
  registersharedfunc("game", "returnObjectiveID", &scripts\cp\utility::nonobjective_returnobjectiveid);
  registersharedfunc("game", "getFriendlyPlayers", &scripts\cp\cp_player_battlechatter::getfriendlyplayers);
  registersharedfunc("game", "getSquadmates", &scripts\cp\cp_player_battlechatter::getsquadmates);
  registersharedfunc("game", "trySayLocalSound", &scripts\cp\cp_player_battlechatter::trysaylocalsound);
  registersharedfunc("game", "tutorialPrint", &scripts\cp\cp_hud_message::tutorialprint);
  registersharedfunc("game", "onEnterOOBTrigger", &scripts\cp\cp_outofbounds::onenteroobtrigger);
  registersharedfunc("game", "onExitOOBTrigger", &scripts\cp\cp_outofbounds::onexitoobtrigger);
  registersharedfunc("game", "makeEnterExitTrigger", &scripts\mp\utility\trigger::makeenterexittrigger);
  registersharedfunc("game", "checkForActiveObjIcon", &scripts\cp\cp_objectives::checkforactiveobjicon);
  registersharedfunc("game", "deleteQuestObjIcon", &scripts\cp\cp_objectives::deletequestobjicon);
  registersharedfunc("game", "spawnPickup", &scripts\cp\pickups::spawnpickup);
  registersharedfunc("game", "getItemDropOriginAndAngles", &scripts\cp\pickups::getitemdroporiginandangles);
  registersharedfunc("game", "br_forceGiveCustomPickupItem", &scripts\cp_mp\pickups::br_forcegivecustompickupitem);
  registersharedfunc("game", "isKiosk", &scripts\cp_mp\pickups::iskiosk);
  registersharedfunc("game", "canTakePickup", &scripts\cp\pickups::cantakepickup);
  registersharedfunc("game", "createQuestObjIcon", &scripts\cp\cp_objectives::createquestobjicon);
  registersharedfunc("game", "showQuestObjIconToPlayer", &scripts\cp\cp_objectives::showquestobjicontoplayer);
  registersharedfunc("game", "hideQuestObjIconFromPlayer", &scripts\cp\cp_objectives::hidequestobjiconfromplayer);
  registersharedfunc("game", "traceSelectedMapLocation", &scripts\cp_mp\pickups::traceselectedmaplocation);
  registersharedfunc("game", "getDefaultWeaponAmmo", &scripts\cp\pickups::getdefaultweaponammo);
  registersharedfunc("game", "getTeamData", &scripts\cp\cp_outline_utility::getteamdata);
  registersharedfunc("game", "registerOnLuiEventCallback", &scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback);
  registersharedfunc("game", "isBRStyleGameType", &scripts\cp_mp\utility\game_utility::isbrstylegametype);
  registersharedfunc("game", "createHintObject", &scripts\cp\utility::createhintobject);
  registersharedfunc("game", "isBackpackInventoryEnabled", &scripts\cp\pickups::isbackpackinventoryenabled);
  registersharedfunc("inventory", "isBackpackInventoryEnabled", &scripts\cp\pickups::isbackpackinventoryenabled);
  registersharedfunc("game", "disable_backpack_inventory", &scripts\cp\utility::disable_backpack_inventory);
  registersharedfunc("game", "registerEntForOOB", &scripts\cp\cp_outofbounds::registerentforoob);
  registersharedfunc("game", "clearOOB", &scripts\cp\cp_outofbounds::clearoob);
  registersharedfunc("game", "convertsbmissionnametoddl", &namespace_1170726b2799ea65::function_ce720be6f935d1d4);

  if(getdvarint(@ "hash_ce58329537cb88ed", 1) > 0) {
    registersharedfunc("backpack", "removeSmallestItemStackBackpack", &scripts\cp\pickups::removesmallestitemstackbackpack);
  }
}

function emp_init() {
  registersharedfunc("emp", "init", &scripts\cp\emp_debuff_cp::emp_debuff_init);
  registersharedfunc("emp", "set_apply_emp_callback", &scripts\cp_mp\emp_debuff::set_apply_emp_callback);
}

function entity_init() {
  registersharedfunc("entity", "delayEntDelete", &scripts\cp\utility::delayentdelete);
}

function weapons_init() {
  registersharedfunc("weapons", "_launchGrenade", &scripts\cp\utility::_launchgrenade);
  registersharedfunc("weapons", "gas_createTrigger", &scripts\cp\equipment\cp_gas_grenade::gas_createtrigger);
  registersharedfunc("weapons", "getDefaultWeaponBaseName", &scripts\cp\utility::getdefaultweaponbasename);
  registersharedfunc("weapons", "isCACPrimaryOrSecondary", &scripts\cp\weapon::iscacprimaryorsecondary);
  registersharedfunc("weapons", "attachmentIsSelectable", &scripts\cp\weapon::attachmentisselectable);
  registersharedfunc("weapons", "magicBullet", &scripts\cp_mp\utility\weapon_utility::_magicbullet);
  registersharedfunc("weapons", "watchForPlacementFireState", &scripts\cp\inventory\cp_target_marker::watchforplacementfirestate);
  registersharedfunc("weapons", "isThrowingKnife", &scripts\cp\cp_weapons::isthrowingknife);
  registersharedfunc("weapons", "getWeaponGroup", &scripts\cp\weapon::getweapongroup);
  registersharedfunc("weapons", "isSuperWeapon", &scripts\cp\utility::issuperweapon);
}

function damage_init() {
  registersharedfunc("damage", "updateDamageFeedback", &scripts\cp_mp\damagefeedback::updatedamagefeedback);
  registersharedfunc("damage", "onKillstreakKilled", &scripts\cp\utility::onkillstreakkilled);
  registersharedfunc("damage", "hudIconType", &scripts\cp_mp\damagefeedback::hudicontype);
  registersharedfunc("damage", "process_events_and_challenges_on_death", &scripts\cp\agent_damage::process_events_and_challenges_on_death);
  registersharedfunc("damage", "monitorDamage", &scripts\cp\weapon::monitordamage);
  registersharedfunc("damage", "handleAPDamage", &scripts\cp\damage::handleapdamage);
  registersharedfunc("damage", "fx_stun_damage", &scripts\cp\weapon::fx_stun_damage);
}

function sound_init() {
  level.fnplaysoundonentity = &scripts\cp\utility::play_sound_on_entity;
  level.fnplaysoundontag = &scripts\cp\utility::play_sound_on_tag;
  registersharedfunc("sound", "trySayLocalSound", &scripts\cp\cp_player_battlechatter::trysaylocalsound);
  registersharedfunc("sound", "playKillstreakDeployDialog", &scripts\cp\cp_player_battlechatter::playkillstreakdeploydialog);
}

function flares_init() {
  registersharedfunc("flares", "handleIncomingStinger", &scripts\cp\cp_flares::flares_handleincomingstinger);
  registersharedfunc("flares", "reduceReserves", &scripts\cp\cp_flares::flares_reducereserves);
  registersharedfunc("flares", "deploy", &scripts\cp\cp_flares::flares_deploy);
  registersharedfunc("flares", "playFx", &scripts\cp\cp_flares::flares_playfx);
}

function shellshock_init() {
  registersharedfunc("shellshock", "artillery_earthQuake", &scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake);
  registersharedfunc("shellshock", "flashInterruptDelayFunc", &scripts\common\shellshock_utility::shellshock_nointerruptdelayfunc);
  registersharedfunc("shellshock", "concussionInterruptDelayFunc", &scripts\common\shellshock_utility::shellshock_nointerruptdelayfunc);
}

function bots_init() {}

function outline_init() {
  registersharedfunc("outline", "outlineDisable", &scripts\cp\cp_outline_utility::outlinedisable);
  registersharedfunc("outline", "outlineEnableForPlayer", &scripts\cp\cp_outline_utility::outlineenableforplayer);
  registersharedfunc("outline", "outlineEnableForTeam", &scripts\cp\cp_outline_utility::outlineenableforteam);
}

function game_utility_init() {
  registersharedfunc("game_utility", "init", &scripts\cp\utility\game_utility_cp::game_utility_cp_init);
}

function rank_init() {
  registersharedfunc("rank", "getScoreInfoValue", &scripts\cp\rank::getscoreinfovalue);
  registersharedfunc("rank", "getScoreInfoXP", &scripts\cp\rank::getscoreinfoxp);
  registersharedfunc("rank", "giveRankXP", &scripts\cp\rank::giverankxp);
  registersharedfunc("rank", "doScoreEvent", &scripts\cp\points::doscoreevent);
  registersharedfunc("rank", "displayScoreEventPoints", &scripts\cp\points::displayscoreeventpoints);
  registersharedfunc("rank", "killEventTextPopup", &scripts\cp\events::killeventtextpopup);
}

function supers_init() {
  registersharedfunc("supers", "setSuperIsInUse", &scripts\cp\super::setsuperisinuse);
  registersharedfunc("supers", "setSuperIsActive", &scripts\cp\super::setsuperisactive);
  registersharedfunc("supers", "getSuperID", &scripts\cp_mp\supers\supers::getsuperid);
}

function gamescore_init() {}

function function_c1199c7cd79918b3() {
  registersharedfunc("aggregator", "registerOnPlayerSpawnCallback", &scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback);
}

function function_1e223bbe18efd769() {
  registersharedfunc("takedowns", "is_in_takedown", &scripts\cp_mp\execution::is_in_takedown);
}

function function_bbe0803dcadd7d18() {
  registersharedfunc("relics", "modify_agent_damage", &scripts\cp\cp_relics::function_ca2cb402bf88a284);
}

function challenges_init() {
  registersharedfunc("challenges", "destroySamSiteNoPlant", &scripts\cp\challenges_cp::destroysamsitenoplant);
  registersharedfunc("challenges", "onPing", &scripts\cp_mp\challenges::onping);
  registersharedfunc("challenges", "onFieldUpgradeEnd", &scripts\cp_mp\challenges::function_bd59aa7e8cece1ab);
  registersharedfunc("challenges", "onKillStreakEnd", &scripts\cp_mp\challenges::function_597bc208d923a465);
}

function function_f677f2d747d21482() {}