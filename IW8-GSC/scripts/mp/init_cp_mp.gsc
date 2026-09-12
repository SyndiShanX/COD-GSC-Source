/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\init_cp_mp.gsc
***********************************************/

function init() {
  setDvar("sm_spotUpdateMoreDynEnt", 1);
  setDvar("sm_spotShadowScoreSystem", 1);
  anim_init();
  hud_init();

  if(!istrue(game["isLaunchChunk"])) {
    killstreak_init();
  }

  equipment_init();
  perk_init();
  player_init();

  if(!istrue(game["isLaunchChunk"])) {
    vehicle_init();
  }

  game_init();
  spawn_init();

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
  outline_init();
  game_utility_init();
  rank_init();
  ref_14599();
  supers_init();
  gamescore_init();
  pers_init();
  dlog_init();
  getanglesfromsurfacenormal();
  ref_13a9e();
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "runLeanThreadMode", &scripts\mp\utility\game::runleanthreadmode);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "lpcFeatureGated", &scripts\mp\utility\game::lpcfeaturegated);
}

function anim_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("anim", "player_solo", &scripts\mp\anim::anim_player_solo);
}

function hud_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "showSplash", &scripts\mp\hud_message::showsplash);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "teamPlayerCardSplash", &scripts\mp\hud_util::teamplayercardsplash);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "showErrorMessage", &scripts\mp\hud_message::showerrormessage);
}

function killstreak_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "init", &scripts\mp\killstreaks\init_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "addToActiveKillstreakList", &scripts\mp\utility\killstreak::addtoactivekillstreaklist);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "logKillstreakEvent", &scripts\mp\matchdata::logkillstreakevent);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "giveKillstreak", &scripts\mp\killstreaks\killstreaks::givekillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakMakeVehicle", &scripts\mp\utility\killstreak::killstreak_make_vehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetPreModDamageCallback", &scripts\mp\utility\killstreak::killstreak_set_pre_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetPostModDamageCallback", &scripts\mp\utility\killstreak::killstreak_set_post_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetDeathCallback", &scripts\mp\utility\killstreak::killstreak_set_death_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "maxVehiclesAllowed", &scripts\mp\utility\killstreak::maxvehiclesallowed);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "currentActiveVehicleCount", &scripts\mp\utility\killstreak::currentactivevehiclecount);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "allowRideKillstreakPlayerExit", &scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakHit", &scripts\mp\killstreaks\killstreaks::killstreakhit);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "getModifiedAntiKillstreakDamage", &scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "isKillstreakWeapon", &scripts\mp\utility\weapon::iskillstreakweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "doDamageToKillstreak", &scripts\mp\utility\killstreak::dodamagetokillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "removeFromActiveKillstreakList", &scripts\mp\utility\killstreak::removefromactivekillstreaklist);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "awardKillstreakFromStruct", &scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "getSelectMapPoint", &scripts\mp\killstreaks\mapselect::getselectmappoint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "startMapSelectSequence", &scripts\mp\killstreaks\mapselect::startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "setKillstreakControlPriority", &scripts\mp\utility\killstreak::setkillstreakcontrolpriority);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "updateScrapAssistDataForceCredit", &scripts\mp\killstreaks\killstreaks::ref_14019);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "updateScrapAssistData", &scripts\mp\killstreaks\killstreaks::ref_14018);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "processScrapAssist", &scripts\mp\events::ref_128b3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "dangerNotifyPlayersInRange", &scripts\mp\gametypes\br_killstreaks::isbulletpenetration);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "dangerNotifyPlayer", &scripts\mp\gametypes\br_killstreaks::isbrsquadleader);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "teamJuggMaxReached", &scripts\mp\juggernaut::changecirclestateatlowtime);
}

function equipment_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "init", &scripts\mp\equipment\throwing_knife_mp::throwing_knife_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "takeEquipment", &scripts\mp\equipment::takeequipment);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "giveEquipment", &scripts\mp\equipment::giveequipment);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "getEquipmentTableInfo", &scripts\mp\equipment::getequipmenttableinfo);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "allow_equipment", &scripts\mp\equipment::allow_equipment);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "getEquipmentRefFromWeapon", &scripts\mp\equipment::getequipmentreffromweapon);
}

function entity_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("entity", "touchingBadTrigger", &scripts\mp\utility\entity::touchingbadtrigger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("entity", "delayEntDelete", &scripts\mp\utility\script::delayentdelete);
  scripts\cp_mp\utility\script_utility::registersharedfunc("entity", "isTouchingBoundsTrigger", &scripts\mp\utility\entity::istouchingboundstrigger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("entity", "isGondolaBrush", &scripts\mp\gametypes\br_gondola::triggereliminatedoverlay);
}

function perk_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("perk", "hasPerk", &scripts\mp\utility\perk::_hasperk);
  scripts\cp_mp\utility\script_utility::registersharedfunc("perk", "removePerk", &scripts\mp\utility\perk::removeperk);
  scripts\cp_mp\utility\script_utility::registersharedfunc("perk", "givePerk", &scripts\mp\utility\perk::giveperk);
}

function player_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "setUsingRemote", &scripts\mp\utility\player::setusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "clearUsingRemote", &scripts\mp\utility\player::clearusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isUsingRemote", &scripts\mp\utility\player::isusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "freezeControls", &scripts\mp\utility\player::_freezecontrols);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "freezeControlsDebug", &scripts\mp\utility\player::ai_offhandfiremanager);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "freezeLookControls", &scripts\mp\utility\player::_freezelookcontrols);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "printGameAction", &scripts\mp\utility\print::printgameaction);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isPlayerADS", &scripts\mp\utility\player::isplayerads);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "giveUnifiedPoints", &scripts\mp\utility\points::giveunifiedpoints);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "setThirdPersonDOF", &scripts\mp\utility\player::setthirdpersondof);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "hideMiniMap", &scripts\mp\utility\player::hideminimap);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "showMiniMap", &scripts\mp\utility\player::showminimap);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getPlayersInRadius", &scripts\mp\utility\player::getplayersinradius);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "allowGesture", &scripts\mp\utility\player::allow_gesture);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isReallyAlive", &scripts\mp\utility\player::isreallyalive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getStanceCenter", &scripts\mp\utility\player::getstancecenter);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getStanceTop", &scripts\mp\utility\player::round_smoke_logic);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "loadout_finalizeWeapons", &scripts\mp\class::zombierespawning);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "lookupCurrentOperator", &scripts\mp\teams::lookupcurrentoperator);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "lookupOtherOperator", &scripts\mp\teams::lookupotheroperator);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isInLastStand", &scripts\mp\utility\player::unset_relic_trex);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "disableClassSwapAllowed", &scripts\mp\class::disableclassswapallowed);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isFriendly", &scripts\mp\utility\player::isfriendly);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isPlayerOnIntelChallenge", &scripts\mp\gametypes\br_maphints::updatematchstatushintonnoflag);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "carriable_useAscender", &scripts\mp\equipment\binoculars::get_surface_point);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "carriable_useSkyhook", &scripts\mp\equipment\binoculars::carriable_useskyhook);
}

function host_migration_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("hostmigration", "waitLongDurationWithPause", &scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hostmigration", "waittillNotifyOrTimeoutPause", &scripts\mp\hostmigration::waittill_notify_or_timeout_hostmigration_pause);
}

function vehicle_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "init", &scripts\mp\vehicles\vehicle_mp::vehicle_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "incrementFauxVehicleCount", &scripts\mp\utility\killstreak::incrementfauxvehiclecount);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "decrementFauxVehicleCount", &scripts\mp\utility\killstreak::decrementfauxvehiclecount);
}

function game_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isKillStreakDenied", &scripts\mp\utility\game::iskillstreakdenied);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "lpcFeatureGated", &scripts\mp\utility\game::lpcfeaturegated);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "objectiveUnPinPlayer", &scripts\mp\objidpoolmanager::objective_unpin_player);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isMLGMatch", &scripts\mp\utility\game::ismlgmatch);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isGameTypeBR", &scripts\mp\utility\game::unset_relic_grounded);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getGameType", &scripts\mp\utility\game::getgametype);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getSubGameType", &scripts\mp\utility\game::round_vehicle_logic);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getEnemyTeams", &scripts\mp\utility\teams::getenemyteams);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getOtherTeam", &scripts\mp\utility\game::getotherteam);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getTeamData", &scripts\mp\utility\teams::getteamdata);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "createObjective", &scripts\mp\objidpoolmanager::createobjective);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "createObjectiveEngineer", &scripts\mp\objidpoolmanager::createobjective_engineer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "requestObjectiveID", &scripts\mp\objidpoolmanager::requestobjectiveid);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "returnObjectiveID", &scripts\mp\objidpoolmanager::returnobjectiveid);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "handlemovingplatforms", &scripts\mp\movers::handle_moving_platforms);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "registerEntForOOB", &scripts\mp\outofbounds::registerentforoob);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "clearOOB", &scripts\mp\outofbounds::clearoob);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isGameplayTeam", &scripts\mp\utility\teams::isgameplayteam);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getGametypeNumLives", &scripts\mp\utility\game::getgametypenumlives);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getFriendlyPlayers", &scripts\mp\utility\teams::getfriendlyplayers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "registerOnPlayerSpawnCallback", &scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "registerPlayerFrameUpdateCallback", &scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "trySayLocalSound", &scripts\mp\battlechatter_mp::trysaylocalsound);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "tutorialPrint", &scripts\mp\utility\print::tutorialprint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "setOverTimeLimitDvar", &scripts\mp\utility\game::setovertimelimitdvar);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getHostPlayer", &scripts\mp\gamelogic::gethostplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "brGetOperatorTeam", &scripts\mp\gametypes\br_public::disableannouncer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "gameFlag", &scripts\mp\flags::gameflag);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isPointInBounds", &scripts\mp\outofbounds::unset_relic_rocket_kill_ammo);
}

function spawn_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("spawn", "addSpawnDangerZone", &scripts\mp\spawnlogic::addspawndangerzone);
  scripts\cp_mp\utility\script_utility::registersharedfunc("spawn", "removeSpawnDangerZone", &scripts\mp\spawnlogic::removespawndangerzone);
  scripts\cp_mp\utility\script_utility::registersharedfunc("spawn", "isSpawnDangerZoneAlive", &scripts\mp\spawnlogic::isspawndangerzonealive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("spawn", "getCodeHandleFromScriptHandle", &scripts\mp\spawnlogic::influencepoint_getcodehandlefromscripthandle);
}

function emp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "init", &scripts\mp\emp_debuff_mp::emp_debuff_init);
}

function execution_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("execution", "init", &scripts\mp\execution_mp::execution_mp_init);
}

function weapons_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "enableBurnFX", &scripts\mp\weapons::enableburnfx);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "disableBurnFX", &scripts\mp\weapons::disableburnfx);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "_launchGrenade", &scripts\mp\utility\weapon::_launchgrenade);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "mapWeapon", &scripts\mp\utility\weapon::mapweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "gas_createTrigger", &scripts\mp\equipment\gas_grenade::gas_createtrigger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "getDefaultWeaponBaseName", &scripts\mp\utility\weapon::relic_nuketimer_globalthread);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "getWeaponRootName", &scripts\mp\utility\weapon::getweaponrootname);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "isCACPrimaryOrSecondary", &scripts\mp\utility\weapon::iscacprimaryorsecondary);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "attachmentMap_toBase", &scripts\mp\utility\weapon::attachmentmap_tobase);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "attachmentIsSelectable", &scripts\mp\utility\weapon::carriedpunchcard);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "remapAttachmentParentName", &scripts\mp\utility\weapon::ref_12bbb);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "saveToggleScopeStates", &scripts\mp\weapons::savetogglescopestates);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "saveAltStates", &scripts\mp\weapons::savealtstates);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "updateSavedAltState", &scripts\mp\weapons::updatesavedaltstate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "updateToggleScopeState", &scripts\mp\weapons::updatetogglescopestate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "getWeaponGroup", &scripts\mp\utility\weapon::getweapongroup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "getWeaponMenuCategory", &scripts\mp\utility\weapon::runpubliceventoftype);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "getWeaponRarity", &scripts\mp\utility\weapon::russianletter);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "giveAmmoType", &scripts\mp\gametypes\br_weapons::br_ammo_give_type);
}

function damage_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "enqueueCorpsetableFunc", &scripts\mp\damage::enqueuecorpsetablefunc);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "dequeueCorpsetableFunc", &scripts\mp\damage::dequeuecorpsetablefunc);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "updateDamageFeedback", &scripts\mp\damagefeedback::updatedamagefeedback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "onKillstreakKilled", &scripts\mp\damage::onkillstreakkilled);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "logAttackerKillstreak", &scripts\mp\damage::logattackerkillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "handleDamageFeedback", &scripts\mp\damage::handledamagefeedback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "_suicide", &scripts\mp\utility\damage::_suicide);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "hudIconType", &scripts\mp\damagefeedback::hudicontype);
}

function sound_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("sound", "trySayLocalSound", &scripts\mp\battlechatter_mp::trysaylocalsound);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sound", "playKillstreakDialogOnPlayer", &scripts\mp\utility\dialog::playkillstreakdialogonplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sound", "playKillstreakDeployDialog", &scripts\mp\battlechatter_mp::ref_1274c);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sound", "playKillstreakUseDialog", &scripts\mp\utility\dialog::playkillstreakusedialog);
}

function flares_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "handleIncomingStinger", &scripts\mp\killstreaks\flares::flares_handleincomingstinger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "reduceReserves", &scripts\mp\killstreaks\flares::flares_reducereserves);
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "deploy", &scripts\mp\killstreaks\flares::flares_deploy);
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "playFx", &scripts\mp\killstreaks\flares::flares_playfx);
}

function shellshock_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "artillery_earthQuake", &scripts\mp\shellshock::artillery_earthquake);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "grenade_earthQuakeAtPosition", &scripts\mp\shellshock::grenade_earthquakeatposition);
}

function bots_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("bots", "get_random_outside_target", &scripts\mp\bots\bots_killstreaks_remote_vehicle::get_random_outside_target);
  scripts\cp_mp\utility\script_utility::registersharedfunc("bots", "bot_body_is_dead", &scripts\mp\bots\bots_killstreaks_remote_vehicle::bot_body_is_dead);
}

function outline_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineDisable", &scripts\mp\utility\outline::outlinedisable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineEnableForPlayer", &scripts\mp\utility\outline::outlineenableforplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineEnableForTeam", &scripts\mp\utility\outline::outlineenableforteam);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "hudOutlineViewmodelEnable", &scripts\mp\utility\outline::_hudoutlineviewmodelenable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "hudOutlineViewmodelDisable", &scripts\mp\utility\outline::_hudoutlineviewmodeldisable);
}

function game_utility_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("game_utility", "init", &scripts\mp\utility\game_utility_mp::game_utility_mp_init);
}

function rank_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "getScoreInfoValue", &scripts\mp\rank::getscoreinfovalue);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "giveRankXP", &scripts\mp\rank::giverankxp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "scoreEventPopup", &scripts\mp\rank::scoreeventpopup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "getRankXPMultiplierTotal", &scripts\mp\rank::getrankxpmultipliertotal);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "getBattlePassXPultiplierTotal", &scripts\mp\rank::registerpublicevent);
}

function ref_14599() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("weaponrank", "getWeaponRankXPMultiplierTotal", &scripts\mp\weaponrank::getweaponrankxpmultipliertotal);
}

function supers_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "giveSuperPoints", &scripts\mp\supers::givesuperpoints);
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "superUseFinished", &scripts\mp\supers::superusefinished);
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "getSuperPointsNeeded", &scripts\mp\supers::getsuperpointsneeded);
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "combatRecordSuperMisc", &scripts\mp\supers::hide_plunderboxes);
}

function gamescore_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("gamescore", "trackDebuffAssist", &scripts\mp\gamescore::trackdebuffassist);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gamescore", "untrackDebuffAssist", &scripts\mp\gamescore::untrackdebuffassist);
}

function pers_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("pers", "incPersStat", &scripts\mp\utility\stats::incpersstat);
}

function dlog_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("dlog", "fieldUpgradeExpired", &scripts\mp\analyticslog::logevent_fieldupgradeexpired);
  scripts\cp_mp\utility\script_utility::registersharedfunc("dlog", "killStreakExpired", &scripts\mp\analyticslog::logevent_killstreakexpired);
}

function getanglesfromsurfacenormal() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onVehicleKilled", &scripts\cp\vehicles\vehicle_compass_cp::vehiclekilled);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onFieldUpgradeEnd", &scripts\cp\vehicles\vehicle_compass_cp::ref_12032);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onKillStreakEnd", &scripts\cp\vehicles\vehicle_compass_cp::ref_1204a);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "resetChallengeTimer", &scripts\cp\vehicles\vehicle_compass_cp::ref_12c6e);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "startChallengeTimer", &scripts\cp\vehicles\vehicle_compass_cp::ref_1383b);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "stopChallengeTimer", &scripts\cp\vehicles\vehicle_compass_cp::ref_138d5);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onPing", &scripts\cp\vehicles\vehicle_compass_cp::ref_12061);
}

function ref_13a9e() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("team_utility", "init", &scripts\mp\utility\teams::ref_13a9f);
}