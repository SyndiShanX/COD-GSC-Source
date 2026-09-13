/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\init_cp_mp.gsc
***********************************************/

init() {
  setDvar("sm_spotUpdateMoreDynEnt", 1);
  setDvar("sm_spotShadowScoreSystem", 1);

  if(!isDefined(level.players))
    level.players = [];

  level._id_19D38DEC02A818CE = scripts\cp_mp\utility\script_utility::issharedfuncdefined;
  level._id_49B393A31D0B0B95 = scripts\cp_mp\utility\script_utility::getsharedfunc;
  perk_init();
  anim_init();
  hud_init();
  killstreak_init();
  equipment_init();
  player_init();
  vehicle_init();
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
  _id_C1199C7CD79918B3();
  challenges_init();
  _id_BBE0803DCADD7D18();
}

perk_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("perk", "hasPerk", scripts\cp\utility::_hasperk);
  scripts\cp_mp\utility\script_utility::registersharedfunc("perk", "givePerk", scripts\cp\utility::giveperk);
  scripts\cp_mp\utility\script_utility::registersharedfunc("perk", "removePerk", _id_6E09A830FAB9468F::removeperk);
  scripts\cp_mp\utility\script_utility::registersharedfunc("perk", "activatePerk", scripts\cp\utility::_id_5A3FEF8CB39336B8);
}

gameskill_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("gameskill", "updatePlayerAttackerAccuracy", scripts\cp\cp_gameskill::update_player_attacker_accuracy);
}

stealth_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("stealth", "init", _id_0BE30EB214E1AF7B::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("stealth", "revertAiAccuracy", _id_0BE30EB214E1AF7B::_id_A1D7DF5CC0E9C6A0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("stealth", "dropAiAccuracy", _id_0BE30EB214E1AF7B::_id_A293F22894E2466B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("stealth", "spotted_event_handler", _id_0BE30EB214E1AF7B::_id_5AF9997F0EEFB9A2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("stealth_music", "init", _id_2709F0932DD1E5A7::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("stealth_enemy", "init", _id_68FA6B4EE60216AE::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("stealth_player", "init", _id_0BE30EB214E1AF7B::init_player);
}

anim_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("anim", "player_solo", scripts\cp\cp_anim::anim_player_solo);
}

hud_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "showErrorMessage", scripts\cp\cp_hud_message::showerrormessage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "teamPlayerCardSplash", scripts\cp\cp_hud_util::teamplayercardsplash);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "showSplash", scripts\cp\cp_hud_message::showsplash);
}

killstreak_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "init", scripts\cp\killstreaks\init_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "addToActiveKillstreakList", scripts\cp\utility::addtoactivekillstreaklist);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "isKillstreakWeapon", _id_2669878CF5A1B6BC::iskillstreakweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "allowRideKillstreakPlayerExit", scripts\cp\utility::allowridekillstreakplayerexit);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "getSelectMapPoint", scripts\cp\cp_mapselect::getselectmappoint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "startMapSelectSequence", scripts\cp\cp_mapselect::startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakMakeVehicle", scripts\cp\utility::killstreak_make_vehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetPreModDamageCallback", scripts\cp\utility::killstreak_set_pre_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetPostModDamageCallback", scripts\cp\utility::killstreak_set_post_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetDeathCallback", scripts\cp\utility::killstreak_set_death_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakHit", scripts\cp\utility::killstreakhit);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "createCustomStreakData", scripts\cp\killstreaks\init_cp::init_killstreak_data_for_challenges);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "setKillstreakControlPriority", scripts\cp\utility::setkillstreakcontrolpriority);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakUse", _id_5E5507D57BBBB709::_id_76634BAEC9299866);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "getModifiedAntiKillstreakDamage", _id_25845ACA699D038D::getmodifiedantikillstreakdamage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "waittill_confirm_or_cancel", scripts\cp\cp_mapselect::waittill_confirm_or_cancel);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "refundKillstreak", _id_5E5507D57BBBB709::_id_4A1FD54AFFDAA367);
}

equipment_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("throwing_knife", "init", scripts\cp\equipment\throwing_knife_cp::throwing_knife_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "getEquipmentRefFromWeapon", scripts\cp\cp_equipment::getequipmentreffromweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "equipment_init", scripts\cp\cp_equipment::equipment_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "attachmentIsSelectable", _id_74502A9E0EF1F19C::attachmentisselectable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "getEquipmentTableInfo", scripts\cp\cp_equipment::getequipmenttableinfo);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "hackEquipment", scripts\cp\cp_equipment::_id_E0EF70F764B4A4C7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "isPlantedEquipment", _id_74502A9E0EF1F19C::isplantedequipment);
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "deleteExplosive", _id_74502A9E0EF1F19C::deleteexplosive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("oxygenmask", "init", _id_4D5D872A7BD5C0C3::_id_234851F94416F178);
}

player_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "_isAlive", scripts\cp\utility\player_utility_cp::_isalive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "setUsingRemote", scripts\cp\utility\player::setusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "clearUsingRemote", scripts\cp\utility\player::clearusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isUsingRemote", scripts\cp\utility::isusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "freezeControls", scripts\cp\utility::_freezecontrols);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "printGameAction", scripts\cp\utility::printgameaction);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isPlayerADS", scripts\cp\utility::isplayerads);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "setThirdPersonDOF", scripts\cp\utility::setthirdpersondof);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "hideMiniMap", scripts\cp\utility\player::hideminimap);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "showMiniMap", scripts\cp\utility\player::showminimap);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getPlayersInRadius", scripts\cp\utility::getplayersinradius);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isFriendly", scripts\cp\utility\player::isfriendly);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isReallyAlive", scripts\cp\utility\player::isreallyalive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getStanceCenter", scripts\cp\utility\player::getstancecenter);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getStanceTop", scripts\cp\utility\player::getstancetop);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isSuperInUse", _id_56EF8D52FE1B48A1::issuperinuse);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getCurrentSuperRef", _id_56EF8D52FE1B48A1::getcurrentsuperref);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "br_ammo_player_is_maxed_out", _id_531CB1BE084314F7::br_ammo_player_is_maxed_out);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "hasSelfReviveToken", _id_0AFB7E332AEE4BF2::hasselfrevivetoken);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "takeWeaponPickup", _id_66122A002AFF5D57::takeweaponpickup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "br_ammo_player_max_out", _id_531CB1BE084314F7::br_ammo_player_max_out);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "addRespawnToken", _id_531CB1BE084314F7::addrespawntoken);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "addSelfReviveToken", _id_66122A002AFF5D57::addselfrevivetoken);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getAvailableDMZBackpackIndex", _id_66122A002AFF5D57::_id_AE22C70A9C2474D9);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "playerPlunderKioskPurchase", _id_531CB1BE084314F7::playerplunderkioskpurchase);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "addItemToBackpack", _id_66122A002AFF5D57::_id_10F6E537F1B5763C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "surfaceFunc", scripts\cp\utility\player::_id_8196EA3BC8D5538A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "disable_backpack_inventory", scripts\cp\utility::_id_4CBAED764C116A25);
}

vehicle_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "init", scripts\cp\vehicles\vehicle_cp::vehicle_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "isVehicleWeapon", _id_74502A9E0EF1F19C::isvehicleweapon);
}

host_migration_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("hostmigration", "waitLongDurationWithPause", scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hostmigration", "waittillNotifyOrTimeoutPause", scripts\cp\cp_hostmigration::waittill_notify_or_timeout_hostmigration_pause);
}

game_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isKillStreakDenied", scripts\cp\utility::isairdenied);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getEnemyTeams", scripts\cp\utility::getenemyteams);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getGameType", scripts\cp\utility::getgametype);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getOtherTeam", scripts\cp\utility::getotherteam);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "createObjectiveEngineer", scripts\cp\utility::killstreak_createobjective_engineer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "createObjective", scripts\cp\utility::killstreak_createobjective);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "requestObjectiveID", scripts\cp\utility::nonobjective_requestobjectiveid);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "returnObjectiveID", scripts\cp\utility::nonobjective_returnobjectiveid);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getFriendlyPlayers", scripts\cp\cp_player_battlechatter::getfriendlyplayers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getSquadmates", scripts\cp\cp_player_battlechatter::_id_3D0F2343793D709B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "trySayLocalSound", scripts\cp\cp_player_battlechatter::trysaylocalsound);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "tutorialPrint", scripts\cp\cp_hud_message::tutorialprint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "onEnterOOBTrigger", scripts\cp\cp_outofbounds::onenteroobtrigger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "onExitOOBTrigger", scripts\cp\cp_outofbounds::onexitoobtrigger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "makeEnterExitTrigger", scripts\mp\utility\trigger::makeenterexittrigger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "checkForActiveObjIcon", _id_029458C0B233BE34::checkforactiveobjicon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "deleteQuestObjIcon", _id_029458C0B233BE34::deletequestobjicon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "spawnPickup", _id_66122A002AFF5D57::spawnpickup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getItemDropOriginAndAngles", _id_66122A002AFF5D57::getitemdroporiginandangles);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "br_forceGiveCustomPickupItem", _id_531CB1BE084314F7::br_forcegivecustompickupitem);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isKiosk", _id_531CB1BE084314F7::_id_7897CA6463069464);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "canTakePickup", _id_66122A002AFF5D57::cantakepickup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "createQuestObjIcon", _id_029458C0B233BE34::createquestobjicon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "showQuestObjIconToPlayer", scripts\cp\cp_objectives::showquestobjicontoplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "hideQuestObjIconFromPlayer", scripts\cp\cp_objectives::hidequestobjiconfromplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "traceSelectedMapLocation", _id_531CB1BE084314F7::traceselectedmaplocation);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getDefaultWeaponAmmo", _id_66122A002AFF5D57::_id_5C9E1BD30347CB36);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getTeamData", scripts\cp\cp_outline_utility::getteamdata);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "registerOnLuiEventCallback", scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isBRStyleGameType", scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isBackpackInventoryEnabled", _id_66122A002AFF5D57::_id_8B121DD10A442DD2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("inventory", "isBackpackInventoryEnabled", _id_66122A002AFF5D57::_id_8B121DD10A442DD2);

  if(getdvarint("dvar_CE58329537CB88ED", 1) > 0)
    scripts\cp_mp\utility\script_utility::registersharedfunc("backpack", "removeSmallestItemStackBackpack", _id_66122A002AFF5D57::_id_51F5AAFA38A37F0F);
}

emp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "init", scripts\cp\emp_debuff_cp::emp_debuff_init);
}

entity_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("entity", "delayEntDelete", scripts\cp\utility::delayentdelete);
}

weapons_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "_launchGrenade", scripts\cp\utility::_launchgrenade);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "gas_createTrigger", scripts\cp\equipment\cp_gas_grenade::gas_createtrigger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "getDefaultWeaponBaseName", scripts\cp\utility::getdefaultweaponbasename);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "isCACPrimaryOrSecondary", _id_74502A9E0EF1F19C::iscacprimaryorsecondary);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "attachmentIsSelectable", _id_74502A9E0EF1F19C::attachmentisselectable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "watchForPlacementFireState", scripts\cp\inventory\cp_target_marker::_id_ECCFD4B7CD6B40B3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "isThrowingKnife", scripts\cp\cp_weapons::isthrowingknife);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "getWeaponGroup", _id_74502A9E0EF1F19C::getweapongroup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "isSuperWeapon", scripts\cp\utility::issuperweapon);
}

damage_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "updateDamageFeedback", _id_5762AC2F22202BA2::updatedamagefeedback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "onKillstreakKilled", scripts\cp\utility::onkillstreakkilled);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "hudIconType", _id_5762AC2F22202BA2::hudicontype);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "process_events_and_challenges_on_death", _id_6F1E07CE9FF97D5F::process_events_and_challenges_on_death);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "monitorDamage", _id_74502A9E0EF1F19C::monitordamage);
}

sound_init() {
  level.fnplaysoundonentity = scripts\cp\utility::play_sound_on_entity;
  level.fnplaysoundontag = scripts\cp\utility::play_sound_on_tag;
  scripts\cp_mp\utility\script_utility::registersharedfunc("sound", "trySayLocalSound", scripts\cp\cp_player_battlechatter::trysaylocalsound);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sound", "playKillstreakDeployDialog", scripts\cp\cp_player_battlechatter::playkillstreakdeploydialog);
}

flares_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "handleIncomingStinger", scripts\cp\cp_flares::flares_handleincomingstinger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "reduceReserves", scripts\cp\cp_flares::flares_reducereserves);
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "deploy", scripts\cp\cp_flares::flares_deploy);
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "playFx", scripts\cp\cp_flares::flares_playfx);
}

shellshock_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "artillery_earthQuake", scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "flashInterruptDelayFunc", scripts\cp_mp\utility\shellshock_utility::shellshock_nointerruptdelayfunc);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "concussionInterruptDelayFunc", scripts\cp_mp\utility\shellshock_utility::shellshock_nointerruptdelayfunc);
}

bots_init() {}

outline_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineDisable", scripts\cp\cp_outline_utility::outlinedisable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineEnableForPlayer", scripts\cp\cp_outline_utility::outlineenableforplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineEnableForTeam", scripts\cp\cp_outline_utility::outlineenableforteam);
}

game_utility_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("game_utility", "init", scripts\cp\utility\game_utility_cp::game_utility_cp_init);
}

rank_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "getScoreInfoValue", _id_187A04151C40FB72::getscoreinfovalue);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "getScoreInfoXP", _id_187A04151C40FB72::_id_D06C3CBB904AE29B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "giveRankXP", _id_187A04151C40FB72::giverankxp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "doScoreEvent", _id_41AE4F5CA24216CB::_id_0366980B6A8796AE);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "displayScoreEventPoints", _id_41AE4F5CA24216CB::displayscoreeventpoints);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "killEventTextPopup", _id_293BC33BD79CABD1::killeventtextpopup);
}

supers_init() {}

gamescore_init() {}

_id_C1199C7CD79918B3() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("aggregator", "registerOnPlayerSpawnCallback", scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback);
}

_id_BBE0803DCADD7D18() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("relics", "modify_agent_damage", scripts\cp\cp_relics::_id_CA2CB402BF88A284);
}

challenges_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "destroySamSiteNoPlant", scripts\cp\challenges_cp::_id_7EA6BAB94F0C5E45);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onPing", scripts\cp_mp\challenges::onping);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onFieldUpgradeEnd", scripts\cp_mp\challenges::_id_BD59AA7E8CECE1AB);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onKillStreakEnd", scripts\cp_mp\challenges::_id_597BC208D923A465);
}