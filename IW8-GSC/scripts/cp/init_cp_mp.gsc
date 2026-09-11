/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\init_cp_mp.gsc
***********************************************/

function init() {
  setDvar("NRSOTSLSSO", 1);
  setDvar("MNQKPNLOPT", 1);

  if(!isDefined(level.players)) {
    level.players = [];
  }

  anim_init();
  hud_init();
  killstreak_init();
  equipment_init();
  player_init();
  vehicle_init();
  game_init();
  emp_init();
  tripwire_init();
  weapons_init();
  damage_init();
  entity_init();
  sound_init();
  flares_init();
  shellshock_init();
  outline_init();
  game_utility_init();
  rank_init();
  ref_14599();
  supers_init();
  gamescore_init();
}

function anim_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("anim", "player_solo", &scripts\cp\cp_anim::anim_player_solo);
}

function hud_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "showErrorMessage", &scripts\cp\cp_hud_message::showerrormessage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "teamPlayerCardSplash", &scripts\cp\cp_hud_util::teamplayercardsplash);
}

function killstreak_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "init", &scripts\cp\killstreaks\init_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "addToActiveKillstreakList", &scripts\cp\utility::addtoactivekillstreaklist);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "isKillstreakWeapon", &scripts\cp\utility::iskillstreakweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "allowRideKillstreakPlayerExit", &scripts\cp\utility::allowridekillstreakplayerexit);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "getSelectMapPoint", &scripts\cp\cp_mapselect::getselectmappoint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "startMapSelectSequence", &scripts\cp\cp_mapselect::startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakMakeVehicle", &scripts\cp\utility::killstreak_make_vehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetPreModDamageCallback", &scripts\cp\utility::killstreak_set_pre_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetPostModDamageCallback", &scripts\cp\utility::killstreak_set_post_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetDeathCallback", &scripts\cp\utility::killstreak_set_death_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakHit", &scripts\cp\utility::killstreakhit);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "createCustomStreakData", &scripts\cp\crafting_system::support_box_spawn);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "getModifiedAntiKillstreakDamage", &scripts\cp\cp_damage::getmodifiedantikillstreakdamage);
}

function equipment_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "init", &scripts\cp\equipment\throwing_knife_cp::throwing_knife_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "getEquipmentRefFromWeapon", &scripts\cp\cp_equipment::getequipmentreffromweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "attachmentIsSelectable", &scripts\cp\cp_weapon::carriedpunchcard);
}

function player_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "_isAlive", &scripts\cp\utility\player_utility_cp::_isalive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "setUsingRemote", &scripts\cp\utility\player::setusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "clearUsingRemote", &scripts\cp\utility\player::clearusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isUsingRemote", &scripts\cp\utility::isusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "freezeControls", &scripts\cp\utility::_freezecontrols);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "printGameAction", &scripts\cp\utility::printgameaction);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isPlayerADS", &scripts\cp\utility::isplayerads);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "setThirdPersonDOF", &scripts\cp\utility::setthirdpersondof);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "hideMiniMap", &scripts\cp\utility\player::hideminimap);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "showMiniMap", &scripts\cp\utility\player::showminimap);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getPlayersInRadius", &scripts\cp\utility::getplayersinradius);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isFriendly", &scripts\cp\utility\player::isfriendly);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isReallyAlive", &scripts\cp\utility\player::isreallyalive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getStanceCenter", &scripts\cp\utility\player::getstancecenter);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getStanceTop", &scripts\cp\utility\player::round_smoke_logic);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "lookupCurrentOperator", &scripts\cp\survival\survival_loadout::lookupcurrentoperator);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "lookupOtherOperator", &scripts\cp\survival\survival_loadout::lookupotheroperator);
}

function vehicle_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "init", &scripts\cp\vehicles\vehicle_cp::vehicle_cp_init);
}

function host_migration_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("hostmigration", "waitLongDurationWithPause", &scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hostmigration", "waittillNotifyOrTimeoutPause", &scripts\cp\cp_hostmigration::waittill_notify_or_timeout_hostmigration_pause);
}

function game_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isKillStreakDenied", &scripts\cp\utility::isairdenied);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getEnemyTeams", &scripts\cp\utility::getenemyteams);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getGameType", &scripts\cp\utility::getgametype);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getOtherTeam", &scripts\cp\utility::getotherteam);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "createObjectiveEngineer", &scripts\cp\utility::vo_ten_remain);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "createObjective", &scripts\cp\utility::killstreak_createobjective);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "requestObjectiveID", &scripts\cp\utility::nonobjective_requestobjectiveid);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "returnObjectiveID", &scripts\cp\utility::nonobjective_returnobjectiveid);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getFriendlyPlayers", &scripts\cp\cp_player_battlechatter::getfriendlyplayers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onKillStreakEnd", &scripts\mp\ammorestock::ref_1204a);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onFieldUpgradeEnd", &scripts\mp\ammorestock::ref_12033);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "trySayLocalSound", &scripts\cp\cp_player_battlechatter::trysaylocalsound);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "tutorialPrint", &scripts\cp\cp_hud_message::tutorialprint);
}

function emp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "init", &scripts\cp\emp_debuff_cp::emp_debuff_init);
}

function tripwire_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "init", &scripts\cp\tripwire_cp::init);
}

function entity_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("entity", "delayEntDelete", &scripts\cp\utility::delayentdelete);
}

function weapons_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "_launchGrenade", &scripts\cp\utility::_launchgrenade);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "gas_createTrigger", &scripts\cp\equipment\cp_gas_grenade::gas_createtrigger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "getDefaultWeaponBaseName", &scripts\cp\utility::relic_nuketimer_globalthread);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "getWeaponRootName", &scripts\cp\utility::getweaponrootname);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "isCACPrimaryOrSecondary", &scripts\cp\cp_weapon::iscacprimaryorsecondary);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "attachmentMap_toBase", &scripts\cp\utility::attachmentmap_tobase);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "attachmentIsSelectable", &scripts\cp\cp_weapon::carriedpunchcard);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "remapAttachmentParentName", &scripts\cp\cp_weapon::ref_12bbb);
}

function damage_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "updateDamageFeedback", &scripts\cp\cp_damagefeedback::updatedamagefeedback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "onKillstreakKilled", &scripts\cp\utility::onkillstreakkilled);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "hudIconType", &scripts\cp\cp_damagefeedback::hudicontype);
}

function sound_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("sound", "trySayLocalSound", &scripts\cp\cp_player_battlechatter::trysaylocalsound);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sound", "playKillstreakDeployDialog", &scripts\cp\cp_player_battlechatter::ref_1274c);
}

function flares_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "handleIncomingStinger", &scripts\cp\cp_flares::flares_handleincomingstinger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "reduceReserves", &scripts\cp\cp_flares::flares_reducereserves);
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "deploy", &scripts\cp\cp_flares::flares_deploy);
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "playFx", &scripts\cp\cp_flares::flares_playfx);
}

function shellshock_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "artillery_earthQuake", &scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "flashInterruptDelayFunc", &scripts\cp_mp\utility\shellshock_utility::shellshock_nointerruptdelayfunc);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "concussionInterruptDelayFunc", &scripts\cp_mp\utility\shellshock_utility::shellshock_nointerruptdelayfunc);
}

function bots_init() {}

function outline_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineDisable", &scripts\cp\cp_outline_utility::outlinedisable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineEnableForPlayer", &scripts\cp\cp_outline_utility::outlineenableforplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineEnableForTeam", &scripts\cp\cp_outline_utility::outlineenableforteam);
}

function game_utility_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("game_utility", "init", &scripts\cp\utility\game_utility_cp::game_utility_cp_init);
}

function rank_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "getScoreInfoValue", &scripts\cp\drone\emp_drone::getscoreinfovalue);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "giveRankXP", &scripts\cp\drone\emp_drone::giverankxp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "getRankXPMultiplierTotal", &scripts\cp\drone\emp_drone::getrankxpmultipliertotal);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "getBattlePassXPultiplierTotal", &scripts\cp\drone\emp_drone::registerpublicevent);
}

function ref_14599() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("weaponrank", "getWeaponRankXPMultiplierTotal", &scripts\cp\cp_weaponrank::getweaponrankxpmultipliertotal);
}

function supers_init() {}

function gamescore_init() {}