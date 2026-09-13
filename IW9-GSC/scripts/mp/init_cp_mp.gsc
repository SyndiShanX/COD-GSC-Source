/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\init_cp_mp.gsc
***********************************************/

init() {
  setDvar("sm_spotUpdateMoreDynEnt", 1);
  setDvar("sm_spotShadowScoreSystem", 1);
  anim_init();
  hud_init();

  if(!istrue(game["isLaunchChunk"]))
    killstreak_init();

  equipment_init();
  perk_init();
  player_init();

  if(!istrue(game["isLaunchChunk"]))
    vehicle_init();

  game_init();
  spawn_init();

  if(!istrue(game["isLaunchChunk"]))
    emp_init();

  execution_init();
  entity_init();
  weapons_init();
  damage_init();
  sound_init();
  flares_init();
  _id_6FFB2C9A5681AED4();
  shellshock_init();
  bots_init();
  _id_550BCD278C30275E();
  outline_init();
  game_utility_init();
  rank_init();
  supers_init();
  gamescore_init();
  pers_init();
  dlog_init();
  challenges_init();
  _id_A92ED2F4C44E5FFA();
  stealth_init();
  gameskill_init();
  _id_C08668FE290FC31A();
  _id_C1199C7CD79918B3();
  _id_B2DA884CE2769FE2();
  tripwire_init();
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "runLeanThreadMode", scripts\mp\utility\game::runleanthreadmode);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "lpcFeatureGated", scripts\mp\utility\game::lpcfeaturegated);
}

gameskill_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("gameskill", "updatePlayerAttackerAccuracy", _id_53DA3333B83B3527::update_player_attacker_accuracy);
}

_id_C08668FE290FC31A() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("poi", "isSystemActive", _id_5DEF7AF2A9F04234::_id_47D356083884F913);
  scripts\cp_mp\utility\script_utility::registersharedfunc("poi", "isInActivePOI", _id_5DEF7AF2A9F04234::_id_9C93E67F90980177);
  scripts\cp_mp\utility\script_utility::registersharedfunc("poi", "findPOIOriginIsIn", _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC);
}

stealth_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("stealth", "init", _id_1407E72346815BC3::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("stealth_music", "init", _id_15C7DC779B327C9B::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("stealth_enemy", "init", _id_5B3343E89EFB05B6::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("stealth", "revertAiAccuracy", _id_1407E72346815BC3::_id_A1D7DF5CC0E9C6A0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("stealth", "dropAiAccuracy", _id_1407E72346815BC3::_id_A293F22894E2466B);
}

anim_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("anim", "player_solo", scripts\mp\anim::anim_player_solo);
}

hud_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "showSplash", scripts\mp\hud_message::showsplash);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "teamPlayerCardSplash", scripts\mp\hud_util::teamplayercardsplash);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "showErrorMessage", scripts\mp\hud_message::showerrormessage);
}

killstreak_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "init", scripts\mp\killstreaks\init_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "addToActiveKillstreakList", scripts\mp\utility\killstreak::addtoactivekillstreaklist);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "logKillstreakEvent", scripts\mp\matchdata::logkillstreakevent);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "giveKillstreak", scripts\mp\killstreaks\killstreaks::givekillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakMakeVehicle", scripts\mp\utility\killstreak::killstreak_make_vehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetPreModDamageCallback", scripts\mp\utility\killstreak::killstreak_set_pre_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetPostModDamageCallback", scripts\mp\utility\killstreak::killstreak_set_post_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetDeathCallback", scripts\mp\utility\killstreak::killstreak_set_death_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "maxVehiclesAllowed", scripts\mp\utility\killstreak::maxvehiclesallowed);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "currentActiveVehicleCount", scripts\mp\utility\killstreak::currentactivevehiclecount);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "allowRideKillstreakPlayerExit", scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakHit", scripts\mp\killstreaks\killstreaks::killstreakhit);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "getModifiedAntiKillstreakDamage", scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "isKillstreakWeapon", _id_2669878CF5A1B6BC::iskillstreakweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "doDamageToKillstreak", scripts\mp\utility\killstreak::dodamagetokillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "removeFromActiveKillstreakList", scripts\mp\utility\killstreak::removefromactivekillstreaklist);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "awardKillstreakFromStruct", scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "getSelectMapPoint", scripts\mp\killstreaks\mapselect::_id_A5839924B6723EAC);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "startMapSelectSequence", scripts\mp\killstreaks\mapselect::_id_90F093CA8576232F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "setKillstreakControlPriority", scripts\mp\utility\killstreak::setkillstreakcontrolpriority);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "updateScrapAssistDataForceCredit", scripts\mp\killstreaks\killstreaks::updatescrapassistdataforcecredit);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "updateScrapAssistData", scripts\mp\killstreaks\killstreaks::updatescrapassistdata);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "processScrapAssist", scripts\mp\events::processscrapassist);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "dangerNotifyPlayer", _id_1671F48D05259D22::dangernotifyplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "getTargetMarker", scripts\mp\killstreaks\target_marker::gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "forceGiveKillstreak", _id_7E52B56769FA7774::forcegivekillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "waittill_confirm_or_cancel", scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "forceUseKillstreak", _id_7E52B56769FA7774::forceusekillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "awardKillstreak", scripts\mp\killstreaks\killstreaks::awardkillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "onKillstreakDanger", scripts\mp\utility\killstreak::_id_BDFA4410167443AD);
}

equipment_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "init", scripts\mp\equipment\throwing_knife_mp::throwing_knife_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwstar", "init", _id_6A46378AF0D33F53::_id_12D7CA3FF609CABA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "takeEquipment", scripts\mp\equipment::takeequipment);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "giveEquipment", scripts\mp\equipment::giveequipment);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "getEquipmentTableInfo", scripts\mp\equipment::getequipmenttableinfo);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "getEquipmentRefFromWeapon", scripts\mp\equipment::getequipmentreffromweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "isPlantedEquipment", scripts\mp\weapons::isplantedequipment);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "deleteExplosive", scripts\mp\weapons::deleteexplosive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("oxygenmask", "init", _id_3C9F0944A991EDB0::init);
}

entity_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("entity", "touchingBadTrigger", scripts\mp\utility\entity::touchingbadtrigger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("entity", "delayEntDelete", scripts\mp\utility\script::delayentdelete);
  scripts\cp_mp\utility\script_utility::registersharedfunc("entity", "isTouchingBoundsTrigger", scripts\mp\utility\entity::istouchingboundstrigger);
}

perk_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("perk", "hasPerk", scripts\mp\utility\perk::_hasperk);
  scripts\cp_mp\utility\script_utility::registersharedfunc("perk", "removePerk", scripts\mp\utility\perk::removeperk);
  scripts\cp_mp\utility\script_utility::registersharedfunc("perk", "givePerk", scripts\mp\utility\perk::giveperk);
  scripts\cp_mp\utility\script_utility::registersharedfunc("perk", "activatePerk", scripts\mp\perks\perks::_id_5A3FEF8CB39336B8);
  scripts\cp_mp\utility\script_utility::registersharedfunc("perk", "block", scripts\mp\utility\perk::blockperkfunction);
  scripts\cp_mp\utility\script_utility::registersharedfunc("perk", "unblock", scripts\mp\utility\perk::unblockperkfunction);
  scripts\cp_mp\utility\script_utility::registersharedfunc("perk", "perkpackage_giveOverrideFieldUpgrades", scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades);
}

player_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "setUsingRemote", scripts\mp\utility\player::setusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "clearUsingRemote", scripts\mp\utility\player::clearusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isUsingRemote", scripts\mp\utility\player::isusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "freezeControls", scripts\mp\utility\player::_freezecontrols);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "freezeControlsDebug", scripts\mp\utility\player::_id_8213D31F7A3C32E2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "freezeLookControls", scripts\mp\utility\player::_freezelookcontrols);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "printGameAction", scripts\mp\utility\print::printgameaction);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isPlayerADS", scripts\mp\utility\player::isplayerads);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "doScoreEvent", scripts\mp\utility\points::_id_0366980B6A8796AE);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "setThirdPersonDOF", scripts\mp\utility\player::setthirdpersondof);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "hideMiniMap", scripts\mp\utility\player::hideminimap);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "showMiniMap", scripts\mp\utility\player::showminimap);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getPlayersInRadius", scripts\mp\utility\player::getplayersinradius);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isReallyAlive", scripts\mp\utility\player::isreallyalive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getStanceCenter", scripts\mp\utility\player::getstancecenter);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getStanceTop", scripts\mp\utility\player::getstancetop);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "loadout_finalizeWeapons", scripts\mp\class::loadout_finalizeweapons);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "lookupCurrentOperator", scripts\mp\teams::lookupcurrentoperator);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "lookupOtherOperator", scripts\mp\teams::lookupotheroperator);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isInLastStand", scripts\mp\utility\player::isinlaststand);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "disableClassSwapAllowed", scripts\mp\class::disableclassswapallowed);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isFriendly", scripts\mp\utility\player::isfriendly);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isPlayerOnIntelChallenge", _id_2DC6E355AF43A711::isplayeronintelchallenge);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getGametypeHealthPerFrame", _id_65A96EA484CF876D::_id_4A583E8FE08859DB);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "onFullHealth", _id_65A96EA484CF876D::onfullhealth);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isOOB", scripts\mp\outofbounds::isoob);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "hasKillstreak", _id_7E52B56769FA7774::haskillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isSuperInUse", scripts\mp\supers::issuperinuse);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getCurrentSuperRef", scripts\mp\supers::getcurrentsuperref);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "br_ammo_player_is_maxed_out", _id_724736FCF0FB6604::br_ammo_player_is_maxed_out);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "hasSelfReviveToken", _id_2CEDCC356F1B9FC8::hasselfrevivetoken);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "takeWeaponPickup", _id_724736FCF0FB6604::takeweaponpickup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "forceGiveSuper", _id_7E52B56769FA7774::forcegivesuper);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "br_ammo_player_max_out", _id_724736FCF0FB6604::br_ammo_player_max_out);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "addRespawnToken", _id_7E52B56769FA7774::addrespawntoken);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "addSelfReviveToken", _id_7E52B56769FA7774::addselfrevivetoken);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isJuggernaut", scripts\mp\utility\killstreak::isjuggernaut);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getAvailableDMZBackpackIndex", _id_2D9D24F7C63AC143::_id_AE22C70A9C2474D9);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "playerPlunderKioskPurchase", _id_6AFF3948CF4CCA03::playerplunderkioskpurchase);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "preloadAndQueueClass", scripts\mp\class::preloadandqueueclass);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "br_giveSelectedClass", _id_1E4A61DB11011446::br_giveselectedclass);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isEligibleForTeamRevive", _id_2CEDCC356F1B9FC8::iseligibleforteamrevive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isRespawningFromToken", _id_2CEDCC356F1B9FC8::isrespawningfromtoken);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "playerGulagAutoWin", _id_67708F418B1FAC79::playergulagautowin);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "playerPrestreamRespawnOrigin", _id_5BAB271917698DC4::playerprestreamrespawnorigin);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "gulagFadeToBlack", _id_5BAB271917698DC4::_id_334A8FE67E88BBE7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "gulagStreamExit", _id_5BAB271917698DC4::_id_961B4AFC4C695B94);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "playerTeleportGulag", _id_5BAB271917698DC4::_id_AB31CF673D70F72D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "playerCleanupEntOnDisconnect", _id_5BAB271917698DC4::playercleanupentondisconnect);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "playerWaittillStreamHintComplete", _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "playerClearStreamHintOrigin", _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "resetPlayerMoveSpeedScale", _id_5BAB271917698DC4::resetplayermovespeedscale);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "gulagFadeFromBlack", _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isEnemy", scripts\cp_mp\utility\player_utility::isenemy);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "doOnActionScoreEvent", _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "gulagTrackPlayerBulletHitAI", ::_id_E1E9831C1BCD6F59);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isInGulagCheck", _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "playerHasMoved", scripts\mp\playerlogic::_id_E636E108DFFE6AB7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "checkHit", scripts\mp\weapons::checkhit);
}

_id_E1E9831C1BCD6F59(eattacker, idamage) {
  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagTrackPlayerBulletHitAI"))
    _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagTrackPlayerBulletHitAI", eattacker, idamage);
}

host_migration_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("hostmigration", "waitLongDurationWithPause", scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hostmigration", "waittillNotifyOrTimeoutPause", scripts\mp\hostmigration::waittill_notify_or_timeout_hostmigration_pause);
}

vehicle_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "init", scripts\mp\vehicles\vehicle_mp::vehicle_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "incrementFauxVehicleCount", scripts\mp\utility\killstreak::incrementfauxvehiclecount);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "decrementFauxVehicleCount", scripts\mp\utility\killstreak::decrementfauxvehiclecount);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "isVehicleWeapon", scripts\mp\utility\weapon::isvehicleweapon);
}

game_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isKillStreakDenied", scripts\mp\utility\game::iskillstreakdenied);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "lpcFeatureGated", scripts\mp\utility\game::lpcfeaturegated);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "objectiveUnPinPlayer", scripts\mp\objidpoolmanager::objective_unpin_player);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isMLGMatch", scripts\mp\utility\game::ismlgmatch);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getGameType", scripts\mp\utility\game::getgametype);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getEnemyTeams", scripts\mp\utility\teams::getenemyteams);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getOtherTeam", scripts\mp\utility\game::getotherteam);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getTeamData", scripts\mp\utility\teams::getteamdata);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "createObjective", scripts\mp\objidpoolmanager::createobjective);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "createObjectiveEngineer", scripts\mp\objidpoolmanager::createobjective_engineer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "requestObjectiveID", scripts\mp\objidpoolmanager::requestobjectiveid);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "returnObjectiveID", scripts\mp\objidpoolmanager::returnobjectiveid);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "handlemovingplatforms", scripts\mp\movers::handle_moving_platforms);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "registerEntForOOB", scripts\mp\outofbounds::registerentforoob);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "clearOOB", scripts\mp\outofbounds::clearoob);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "onEnterOOBTrigger", scripts\mp\outofbounds::onenteroobtrigger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "onExitOOBTrigger", scripts\mp\outofbounds::onexitoobtrigger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isGameplayTeam", scripts\mp\utility\teams::isgameplayteam);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getGametypeNumLives", scripts\mp\utility\game::getgametypenumlives);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getFriendlyPlayers", scripts\mp\utility\teams::getfriendlyplayers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getSquadmates", scripts\mp\utility\teams::_id_3D0F2343793D709B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "registerOnPlayerSpawnCallback", scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "registerPlayerFrameUpdateCallback", scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "trySayLocalSound", scripts\mp\battlechatter_mp::trysaylocalsound);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "tutorialPrint", scripts\mp\utility\print::tutorialprint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "setOverTimeLimitDvar", scripts\mp\utility\game::setovertimelimitdvar);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getHostPlayer", scripts\mp\gamelogic::gethostplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "brGetOperatorTeam", _id_2CEDCC356F1B9FC8::brgetoperatorteam);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "gameFlag", scripts\mp\flags::gameflag);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "makeEnterExitTrigger", scripts\mp\utility\trigger::makeenterexittrigger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "registerSentient", scripts\mp\sentientpoolmanager::registersentient);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "gameflagSet", scripts\mp\flags::gameflagset);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "gameflagClear", scripts\mp\flags::gameflagclear);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isFeatureDisabled", _id_362C58E8BB39BCDA::isfeaturedisabled);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "checkForActiveObjIcon", _id_64ACB6CE534155B7::checkforactiveobjicon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "deleteQuestObjIcon", _id_64ACB6CE534155B7::deletequestobjicon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "spawnPickup", _id_7E52B56769FA7774::spawnpickup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getItemDropOriginAndAngles", _id_7E52B56769FA7774::getitemdroporiginandangles);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "br_forceGiveCustomPickupItem", _id_7E52B56769FA7774::br_forcegivecustompickupitem);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "brAnalytics_kiosk_purchaseItem", _id_715028F54BAD19A1::branalytics_kiosk_purchaseitem);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "runBrGametypeFunc", _id_362C58E8BB39BCDA::runbrgametypefunc);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isKiosk", _id_2CEDCC356F1B9FC8::_id_7897CA6463069464);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "canTakePickup", _id_7E52B56769FA7774::cantakepickup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "brAnalytics_kiosk_menu_event", _id_715028F54BAD19A1::branalytics_kiosk_menu_event);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "createQuestObjIcon", _id_64ACB6CE534155B7::createquestobjicon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "showQuestObjIconToPlayer", _id_64ACB6CE534155B7::showquestobjicontoplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "hideQuestObjIconFromPlayer", _id_64ACB6CE534155B7::hidequestobjiconfromplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isPublicEventOfTypeActive", _id_337BD370F7C5E6F9::ispubliceventoftypeactive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isBrPracticeMode", _id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "respawnTokenDisabled", _id_7E52B56769FA7774::respawntokendisabled);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "traceSelectedMapLocation", _id_1E4A61DB11011446::traceselectedmaplocation);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getDefaultWeaponAmmo", _id_4480C6CE37B2BDF3::_id_5C9E1BD30347CB36);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getTeamData", scripts\mp\utility\teams::getteamdata);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isBackpackInventoryEnabled", _id_2D9D24F7C63AC143::_id_8B121DD10A442DD2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "calculatePurchaseXp", _id_1E4A61DB11011446::calculatepurchasexp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isAnyTutorialOrBotPracticeMatch", _id_2CEDCC356F1B9FC8::isanytutorialorbotpracticematch);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "registerOnLuiEventCallback", scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isLoadoutIndexDefault", scripts\mp\menus::isloadoutindexdefault);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getClassChoice", scripts\mp\menus::getclasschoice);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isBrGametypeFuncDefined", _id_362C58E8BB39BCDA::isbrgametypefuncdefined);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "utilFlare_shootFlare", _id_64ACB6CE534155B7::utilflare_shootflare);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isValidPointInBounds", _id_2695A20D4011076D::isvalidpointinbounds);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "initCirclePostStartToCircleIndex", _id_2695A20D4011076D::initcirclepoststarttocircleindex);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isPointWithinInitialDangerCircle", _id_2695A20D4011076D::_id_D449927F9683E871);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getTimeTillCircleClosing", _id_2695A20D4011076D::_id_E55C19338F6E9E0C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getTimeTillDangerForPoint", _id_58F20490049AF6AC::_id_03E0A90B32E551AD);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isFeatureEnabled", _id_362C58E8BB39BCDA::isfeatureenabled);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "spectate_init", _id_6489FCDFE6FA2E36::spectate_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "createHintObject", scripts\mp\gameobjects::createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isBRStyleGameType", scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "non_player_add_ignore_damage_signature", scripts\mp\utility\damage::non_player_add_ignore_damage_signature);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "non_player_remove_ignore_damage_signature", scripts\mp\utility\damage::non_player_remove_ignore_damage_signature);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isLifeLimited", scripts\mp\utility\game::islifelimited);
}

spawn_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("spawn", "addSpawnDangerZone", scripts\mp\spawnlogic::addspawndangerzone);
  scripts\cp_mp\utility\script_utility::registersharedfunc("spawn", "removeSpawnDangerZone", scripts\mp\spawnlogic::removespawndangerzone);
  scripts\cp_mp\utility\script_utility::registersharedfunc("spawn", "isSpawnDangerZoneAlive", scripts\mp\spawnlogic::isspawndangerzonealive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("spawn", "getCodeHandleFromScriptHandle", scripts\mp\spawnlogic::influencepoint_getcodehandlefromscripthandle);
}

emp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "init", scripts\mp\emp_debuff_mp::emp_debuff_init);
}

execution_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("execution", "init", scripts\mp\execution_mp::execution_mp_init);
}

weapons_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "enableBurnFX", scripts\mp\weapons::enableburnfx);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "disableBurnFX", scripts\mp\weapons::disableburnfx);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "_launchGrenade", scripts\mp\utility\weapon::_launchgrenade);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "mapWeapon", scripts\mp\utility\weapon::mapweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "gas_createTrigger", scripts\mp\equipment\gas_grenade::gas_createtrigger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "getDefaultWeaponBaseName", scripts\mp\utility\weapon::getdefaultweaponbasename);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "isCACPrimaryOrSecondary", scripts\mp\utility\weapon::iscacprimaryorsecondary);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "attachmentIsSelectable", scripts\mp\utility\weapon::attachmentisselectable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "saveToggleScopeStates", scripts\mp\weapons::savetogglescopestates);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "saveAltStates", scripts\mp\weapons::savealtstates);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "updateSavedAltState", scripts\mp\weapons::updatesavedaltstate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "updateToggleScopeState", scripts\mp\weapons::updatetogglescopestate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "watchForPlacementFireState", scripts\mp\killstreaks\target_marker::_id_ECCFD4B7CD6B40B3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "isThrowingKnife", scripts\mp\utility\weapon::isthrowingknife);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "isThrowStar", scripts\mp\utility\weapon::_id_160A992C78BDF589);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "getWeaponGroup", scripts\mp\utility\weapon::getweapongroup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "isSuperWeapon", scripts\mp\utility\weapon::issuperweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("molotov", "molotov_burn_for_time", scripts\mp\equipment\molotov::molotov_burn_for_time);
  scripts\cp_mp\utility\script_utility::registersharedfunc("molotov", "molotov_get_cast_contents", scripts\mp\equipment\molotov::molotov_get_cast_contents);
  scripts\cp_mp\utility\script_utility::registersharedfunc("molotov", "molotov_rebuild_angles_up_right", scripts\mp\equipment\molotov::molotov_rebuild_angles_up_right);
  scripts\cp_mp\utility\script_utility::registersharedfunc("molotov", "molotov_rebuild_angles_up_forward", scripts\mp\equipment\molotov::molotov_rebuild_angles_up_forward);
  scripts\cp_mp\utility\script_utility::registersharedfunc("molotov", "molotov_simulate_impact", scripts\mp\equipment\molotov::molotov_simulate_impact);
}

damage_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "enqueueCorpsetableFunc", scripts\mp\damage::enqueuecorpsetablefunc);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "dequeueCorpsetableFunc", scripts\mp\damage::dequeuecorpsetablefunc);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "updateDamageFeedback", _id_5762AC2F22202BA2::updatedamagefeedback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "onKillstreakKilled", scripts\mp\damage::onkillstreakkilled);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "logAttackerKillstreak", scripts\mp\damage::logattackerkillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "handleDamageFeedback", scripts\mp\damage::handledamagefeedback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "_suicide", scripts\mp\utility\damage::_suicide);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "hudIconType", _id_5762AC2F22202BA2::hudicontype);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "handleAPDamage", scripts\mp\damage::handleapdamage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "handleAPAmmoDamage", scripts\mp\damage::_id_C599A0001CA06DC9);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "handleAkimboDamage", scripts\mp\damage::_id_71A1605C1A9BDDD7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "monitorDamage", scripts\mp\damage::monitordamage);
}

sound_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("sound", "trySayLocalSound", scripts\mp\battlechatter_mp::trysaylocalsound);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sound", "playKillstreakDeployDialog", scripts\mp\battlechatter_mp::playkillstreakdeploydialog);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sound", "playSoundOnTag", scripts\mp\utility\sound::play_sound_on_tag);
}

flares_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "handleIncomingStinger", scripts\mp\killstreaks\flares::flares_handleincomingstinger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "reduceReserves", scripts\mp\killstreaks\flares::flares_reducereserves);
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "deploy", scripts\mp\killstreaks\flares::flares_deploy);
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "playFx", scripts\mp\killstreaks\flares::flares_playfx);
}

_id_6FFB2C9A5681AED4() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("popsmoke", "deploy", _id_0E43E8E28E88639E::_id_933806FB8408353D);
}

shellshock_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "artillery_earthQuake", scripts\mp\shellshock::artillery_earthquake);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "grenade_earthQuakeAtPosition", scripts\mp\shellshock::grenade_earthquakeatposition);
}

bots_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("bots", "get_random_outside_target", scripts\mp\bots\bots_killstreaks_remote_vehicle::get_random_outside_target);
  scripts\cp_mp\utility\script_utility::registersharedfunc("bots", "bot_body_is_dead", scripts\mp\bots\bots_killstreaks_remote_vehicle::bot_body_is_dead);
}

_id_550BCD278C30275E() {
  _id_22C948A23AD2FBDF::_id_CE55987060167D4A();
}

outline_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineDisable", scripts\mp\utility\outline::outlinedisable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineEnableForPlayer", scripts\mp\utility\outline::outlineenableforplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineEnableForTeam", scripts\mp\utility\outline::outlineenableforteam);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "hudOutlineViewmodelEnable", scripts\mp\utility\outline::_hudoutlineviewmodelenable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "hudOutlineViewmodelDisable", scripts\mp\utility\outline::_hudoutlineviewmodeldisable);
}

game_utility_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("game_utility", "init", scripts\mp\utility\game_utility_mp::game_utility_mp_init);
}

rank_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "getScoreInfoValue", scripts\mp\rank::getscoreinfovalue);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "getScoreInfoXP", scripts\mp\rank::_id_D06C3CBB904AE29B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "giveRankXP", scripts\mp\rank::giverankxp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "scoreEventPopup", scripts\mp\rank::scoreeventpopup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "displayScoreEventPoints", scripts\mp\utility\points::displayscoreeventpoints);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "killEventTextPopup", scripts\mp\events::killeventtextpopup);
}

supers_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "giveSuper", scripts\mp\supers::givesuper);
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "giveSuperPoints", scripts\mp\supers::givesuperpoints);
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "superUseFinished", scripts\mp\supers::superusefinished);
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "getSuperPointsNeeded", scripts\mp\supers::getsuperpointsneeded);
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "combatRecordSuperMisc", scripts\mp\supers::combatrecordsupermisc);
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "hasAPRRounds", _id_4BEF961309209288::_id_1DA49FB6441F8AB2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "refundSuper", scripts\mp\supers::refundsuper);
}

gamescore_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("gamescore", "trackDebuffAssist", scripts\mp\gamescore::trackdebuffassist);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gamescore", "untrackDebuffAssist", scripts\mp\gamescore::untrackdebuffassist);
}

pers_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("pers", "incPersStat", scripts\mp\utility\stats::incpersstat);
}

dlog_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("dlog", "fieldUpgradeExpired", scripts\mp\analyticslog::logevent_fieldupgradeexpired);
  scripts\cp_mp\utility\script_utility::registersharedfunc("dlog", "killStreakExpired", scripts\mp\analyticslog::logevent_killstreakexpired);
  scripts\cp_mp\utility\script_utility::registersharedfunc("dlog", "brAnalytics_inventory_snapshot", _id_715028F54BAD19A1::branalytics_inventory_snapshot);
  scripts\cp_mp\utility\script_utility::registersharedfunc("dlog", "brAnalytics_kiosk_purchaseLoadout", _id_715028F54BAD19A1::branalytics_kiosk_purchaseloadout);
}

challenges_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onVehicleKilled", scripts\cp_mp\challenges::vehiclekilled);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onFieldUpgradeEnd", scripts\cp_mp\challenges::_id_BD59AA7E8CECE1AB);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onKillStreakEnd", scripts\cp_mp\challenges::_id_597BC208D923A465);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "resetChallengeTimer", scripts\cp_mp\challenges::resetchallengetimer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "startChallengeTimer", scripts\cp_mp\challenges::startchallengetimer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "stopChallengeTimer", scripts\cp_mp\challenges::stopchallengetimer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onPing", scripts\cp_mp\challenges::onping);
}

_id_A92ED2F4C44E5FFA() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("team_utility", "init", scripts\mp\utility\teams::_id_F6728366BA30005C);
}

_id_C1199C7CD79918B3() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("aggregator", "registerOnPlayerSpawnCallback", scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("aggregator", "registerOnLuiEventCallback", scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback);
}

_id_B2DA884CE2769FE2() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("weaponstats", "threadedSetWeaponStatByName", scripts\mp\gamelogic::threadedsetweaponstatbyname);
}

tripwire_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "createLootDropInfo", _id_4480C6CE37B2BDF3::_id_624810233C1B8082);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "spawnPickup", _id_7E52B56769FA7774::spawnpickup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "sort", _id_4480C6CE37B2BDF3::_id_5E77414CC166E514);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "onTripwireCreate", _id_62475AC39CFCD0C2::_id_671F550B1E068966);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "onTripwireTriggered", _id_62475AC39CFCD0C2::_id_EA6C096B9B96DCC3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "onTripwireDefused", _id_62475AC39CFCD0C2::_id_9CF9B16757A90BFC);
}