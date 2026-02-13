/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2020.gsc
*************************************************/

init() {
  setDvar("#x3fac8f39da5737155", 1);
  setDvar("#x3f93ae5bcf5c3c0c0", 1);
  _id_17E2();
  _id_7B3A();

  if(!istrue(game["isLaunchChunk"])) {
    _id_8DB5();
  }

  _id_5554();
  _id_AFC5();
  _id_B4F9();

  if(!istrue(game["isLaunchChunk"])) {
    _id_100E0();
  }

  _id_60AC();
  _id_E16E();

  if(!istrue(game["isLaunchChunk"])) {
    _id_518C();
  }

  _id_56FD();
  _id_54FB();
  _id_10DCA();
  _id_42C7();
  _id_E056();
  _id_5C80();
  _id_D9CD();
  _id_2947();
  _id_ACBB();
  _id_60B4();
  _id_C022();
  _id_EB3E();
  _id_60E3();
  _id_B00C();
  _id_4BC6();
  _id_33B1();
  _id_EF5B();
  _id_D0C7();
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "runLeanThreadMode", scripts\mp\utility\game::_id_CA4B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "lpcFeatureGated", scripts\mp\utility\game::_id_98D3);
}

_id_17E2() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("anim", "player_solo", _id_07AA::_id_17FD);
}

_id_7B3A() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "showSplash", scripts\mp\hud_message::showsplash);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "teamPlayerCardSplash", scripts\mp\hud_util::_id_EF8D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "showErrorMessage", scripts\mp\hud_message::_id_DCA2);
}

_id_8DB5() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "init", _id_0A4D::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "addToActiveKillstreakList", scripts\mp\utility\killstreak::_id_1155);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "logKillstreakEvent", _id_07EE::_id_97A4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "giveKillstreak", scripts\mp\killstreaks\killstreaks::givekillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakMakeVehicle", scripts\mp\utility\killstreak::_id_8DB7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetPreModDamageCallback", scripts\mp\utility\killstreak::_id_8DC1);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetPostModDamageCallback", scripts\mp\utility\killstreak::_id_8DC0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetDeathCallback", scripts\mp\utility\killstreak::_id_8DBF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "maxVehiclesAllowed", scripts\mp\utility\killstreak::maxvehiclesallowed);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "currentActiveVehicleCount", scripts\mp\utility\killstreak::currentactivevehiclecount);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "allowRideKillstreakPlayerExit", scripts\mp\killstreaks\killstreaks::_id_15CF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakHit", scripts\mp\killstreaks\killstreaks::_id_8DD6);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "getModifiedAntiKillstreakDamage", scripts\mp\utility\killstreak::_id_6B66);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "isKillstreakWeapon", scripts\mp\utility\weapon::_id_88F6);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "doDamageToKillstreak", scripts\mp\utility\killstreak::_id_4C56);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "removeFromActiveKillstreakList", scripts\mp\utility\killstreak::_id_C4A2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "awardKillstreakFromStruct", scripts\mp\killstreaks\killstreaks::_id_1FC9);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "getSelectMapPoint", _id_0A54::_id_6D1F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "startMapSelectSequence", _id_0A54::_id_E6E4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "setKillstreakControlPriority", scripts\mp\utility\killstreak::_id_D5D2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "updateScrapAssistDataForceCredit", scripts\mp\killstreaks\killstreaks::_id_FD20);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "updateScrapAssistData", scripts\mp\killstreaks\killstreaks::_id_FD1F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "processScrapAssist", _id_07CE::_id_BD7D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "dangerNotifyPlayersInRange", scripts\mp\gametypes\br_killstreaks::_id_4344);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "dangerNotifyPlayer", scripts\mp\gametypes\br_killstreaks::_id_4343);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "teamHasUAV", scripts\cp_mp\utility\killstreak_utility::_id_EF77);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "enemyHasCUAV", scripts\cp_mp\utility\killstreak_utility::_id_5413);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "helper_drone_isTargetMarked", _id_09B5::_id_8A90);
}

_id_5554() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "init", _id_0A1B::_id_F19A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_star", "init", _id_0A1C::_id_F1A8);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "takeEquipment", scripts\mp\equipment::_id_EDBD);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "giveEquipment", scripts\mp\equipment::giveequipment);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "getEquipmentTableInfo", scripts\mp\equipment::_id_6A17);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "allow_equipment", scripts\mp\equipment::allow_equipment);
}

_id_54FB() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("entity", "touchingBadTrigger", scripts\mp\utility\entity::_id_F38F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("entity", "delayEntDelete", scripts\mp\utility\script::_id_46C7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("entity", "isTouchingBoundsTrigger", scripts\mp\utility\entity::_id_8AA9);
}

_id_AFC5() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("perk", "hasPerk", scripts\mp\utility\perk::_hasperk);
  scripts\cp_mp\utility\script_utility::registersharedfunc("perk", "removePerk", scripts\mp\utility\perk::removeperk);
  scripts\cp_mp\utility\script_utility::registersharedfunc("perk", "givePerk", scripts\mp\utility\perk::_id_6FC2);
}

_id_B4F9() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "setUsingRemote", scripts\mp\utility\player::_id_D8D4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "clearUsingRemote", scripts\mp\utility\player::_id_3990);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isUsingRemote", scripts\mp\utility\player::_id_8ACE);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "freezeControls", scripts\mp\utility\player::_freezecontrols);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "freezeLookControls", scripts\mp\utility\player::_id_0BEE);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "printGameAction", scripts\mp\utility\print::_id_BD15);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isPlayerADS", scripts\mp\utility\player::_id_8989);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "giveUnifiedPoints", _id_0A9F::_id_7003);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "setThirdPersonDOF", scripts\mp\utility\player::setthirdpersondof);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "hideMiniMap", scripts\mp\utility\player::_id_7908);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "showMiniMap", scripts\mp\utility\player::_id_DCC4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getPlayersInRadius", scripts\mp\utility\player::_id_6C5F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "allowGesture", scripts\mp\utility\player::_id_1543);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isReallyAlive", scripts\mp\utility\player::isreallyalive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isEnemy", scripts\mp\utility\player::isenemy);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "loadout_finalizeWeapons", scripts\mp\class::_id_9626);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "lookupCurrentOperator", scripts\mp\teams::_id_9817);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "lookupOtherOperator", scripts\mp\teams::_id_981A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isInLastStand", scripts\mp\utility\player::_id_88C8);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "disableClassSwapAllowed", scripts\mp\class::_id_4A86);
}

_id_7A3E() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("hostmigration", "waitLongDurationWithPause", scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hostmigration", "waittillNotifyOrTimeoutPause", scripts\mp\hostmigration::_id_108F6);
}

_id_100E0() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "init", _id_0ABF::_id_10152);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "initVehicles", _id_0ABF::_id_10153);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "spawnPlayerInVehicle", _id_0ABF::_id_10154);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "destroyVehicles", _id_0ABF::_id_10151);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "incrementFauxVehicleCount", scripts\mp\utility\killstreak::_id_7DEF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "decrementFauxVehicleCount", scripts\mp\utility\killstreak::_id_455A);
}

_id_60AC() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isKillStreakDenied", scripts\mp\utility\game::_id_88EE);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isAirDenied", scripts\mp\utility\game::_id_873C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "lpcFeatureGated", scripts\mp\utility\game::_id_98D3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "objectiveUnPinPlayer", _id_07F9::_id_A8CF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "objectivePlayerMaskAddShowPlayer", _id_07F9::_id_A89D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "objectivePlayerMaskHideFrom", _id_07F9::_id_A89E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isMLGMatch", scripts\mp\utility\game::_id_8932);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getGameType", scripts\mp\utility\game::getgametype);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getEnemyTeams", scripts\mp\utility\teams::_id_6A01);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getTeamData", scripts\mp\utility\teams::_id_6DCA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "createObjective", _id_07F9::_id_4022);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "createObjectiveEngineer", _id_07F9::_id_4023);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "requestObjectiveID", _id_07F9::_id_C57D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "returnObjectiveID", _id_07F9::_id_C799);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "updateObjectiveIcon", _id_07F9::_id_FB8F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "Objective_PlayerMask_HideFrom", _id_07F9::_id_A89E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "handlemovingplatforms", scripts\mp\movers::_id_7403);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "registerEntForOOB", scripts\mp\outofbounds::_id_C259);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "clearOOB", scripts\mp\outofbounds::_id_3964);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isGameplayTeam", scripts\mp\utility\teams::_id_8878);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getGametypeNumLives", scripts\mp\utility\game::_id_6A65);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getFriendlyPlayers", scripts\mp\utility\teams::_id_6A59);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "registerOnPlayerSpawnCallback", _id_0AA3::_id_C28D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "registerPlayerFrameUpdateCallback", _id_0A9E::_id_C29C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "trySayLocalSound", scripts\mp\battlechatter_mp::_id_F759);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "addCashForScoreEvent", scripts\mp\gametypes\base::_id_1099);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "givePlayerCash", scripts\mp\gametypes\base::_id_6FCA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "checkBaseNukeCrateCarrier", scripts\mp\gametypes\base::_id_34E4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "monitorNukeCrateCarrier", scripts\mp\gametypes\base::_id_A126);
}

_id_E16E() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("spawn", "addSpawnDangerZone", _id_0817::_id_1135);
  scripts\cp_mp\utility\script_utility::registersharedfunc("spawn", "removeSpawnDangerZone", _id_0817::_id_C51F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("spawn", "isSpawnDangerZoneAlive", _id_0817::_id_8A47);
  scripts\cp_mp\utility\script_utility::registersharedfunc("spawn", "getCodeHandleFromScriptHandle", _id_0817::_id_7E99);
}

_id_518C() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "init", _id_07CB::_id_5181);
}

_id_56FD() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("execution", "init", _id_07CF::_id_56FF);
}

_id_10DCA() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "enableBurnFX", scripts\mp\weapons::_id_523B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "disableBurnFX", scripts\mp\weapons::_id_4A84);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "_launchGrenade", scripts\mp\utility\weapon::_id_0C48);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "mapWeapon", scripts\mp\utility\weapon::_id_9ACB);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "gas_createTrigger", _id_0A0D::_id_6157);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "smoke_createTrigger", _id_0A6B::_id_DE36);
}

_id_42C7() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "enqueueCorpsetableFunc", _id_07C3::_id_5466);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "dequeueCorpsetableFunc", _id_07C3::_id_47FD);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "updateDamageFeedback", _id_07C4::_id_FC47);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "onKillstreakKilled", _id_07C3::_id_AB18);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "logAttackerKillstreak", _id_07C3::_id_9757);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "handleDamageFeedback", _id_07C3::_id_7430);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "_suicide", _id_0A8B::_id_0D8A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "hudIconType", _id_07C4::_id_7B6B);
}

_id_E056() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("sound", "trySayLocalSound", scripts\mp\battlechatter_mp::_id_F759);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sound", "playKillstreakDialogOnPlayer", _id_0A8D::_id_B86E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sound", "playKillstreakDeployDialog", scripts\mp\battlechatter_mp::_id_B86D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sound", "playKillstreakUseDialog", _id_0A8D::_id_B871);
}

_id_5C80() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "handleIncomingStinger", _id_0A44::_id_5C7F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "reduceReserves", _id_0A44::_id_5C84);
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "deploy", _id_0A44::_id_5C76);
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "playFx", _id_0A44::_id_5C82);
}

_id_D9CD() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "artillery_earthQuake", _id_0814::_id_1C1F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "grenade_earthQuakeAtPosition", _id_0814::_id_7144);
}

_id_2947() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("bots", "get_random_outside_target", _id_09F5::_id_66DB);
  scripts\cp_mp\utility\script_utility::registersharedfunc("bots", "bot_body_is_dead", _id_09F5::_id_270A);
}

_id_ACBB() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineDisable", scripts\mp\utility\outline::outlinedisable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineEnableForPlayer", scripts\mp\utility\outline::outlineenableforplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineEnableForTeam", scripts\mp\utility\outline::_id_ACD2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "hudOutlineViewmodelEnable", scripts\mp\utility\outline::_id_0C2E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "hudOutlineViewmodelDisable", scripts\mp\utility\outline::_id_0C2D);
}

_id_60B4() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("game_utility", "init", _id_0A93::_id_60B6);
}

_id_C022() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "getScoreInfoValue", scripts\mp\rank::getscoreinfovalue);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "giveRankXP", scripts\mp\rank::giverankxp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "scoreEventPopup", scripts\mp\rank::_id_CC00);
}

_id_EB3E() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "giveSuperPoints", scripts\mp\supers::_id_6FF9);
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "superUseFinished", scripts\mp\supers::_id_EB50);
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "getSuperPointsNeeded", scripts\mp\supers::_id_6DA3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "combatRecordSuperMisc", scripts\mp\supers::_id_3AC1);
}

_id_60E3() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("gamescore", "trackDebuffAssist", scripts\mp\gamescore::_id_F3FA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gamescore", "untrackDebuffAssist", scripts\mp\gamescore::_id_FB2C);
}

_id_B00C() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("pers", "incPersStat", scripts\mp\utility\stats::_id_7DAE);
}

_id_4BC6() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("dlog", "fieldUpgradeExpired", _id_07A9::_id_9768);
  scripts\cp_mp\utility\script_utility::registersharedfunc("dlog", "killStreakExpired", _id_07A9::_id_9773);
}

_id_33B1() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onVehicleKilled", _id_07BC::_id_10316);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onFieldUpgradeEnd", _id_07BC::_id_AAE7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onKillStreakEnd", _id_07BC::_id_AB16);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "resetChallengeTimer", _id_07BC::_id_C60B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "startChallengeTimer", _id_07BC::_id_E68C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "stopChallengeTimer", _id_07BC::_id_E901);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onPing", _id_07BC::_id_AB53);
}

_id_EF5B() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("team_utility", "init", scripts\mp\utility\teams::_id_EF5C);
}

_id_D0C7() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentient", "registerSentient", _id_0812::_id_C2B2);
}