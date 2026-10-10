/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_16ea1b94f0f381b3.gsc
*************************************************/

#using scripts\engine\utility;
#namespace namespace_2b1145f62aa835b8;

function function_c7f98a48eeddbf2f(animname, notifystring, var_d3a7686bdb2b1c76, blendtype) {
  return utility::function_f3bb4f4911a1beb2("anim", "scriptModelPlayAnimDeltaMotion", animname, notifystring, var_d3a7686bdb2b1c76, blendtype);
}

function function_87072b42853a9c58(perkname) {
  has_perk = 0;

  if(utility::issharedfuncdefined("perk", "hasPerk")) {
    has_perk = self[[utility::getsharedfunc("perk", "hasPerk")]](perkname);
  }

  return has_perk;
}

function function_cc76abced8a70f47(perkname) {
  if(issharedfuncdefined("perk", "activatePerk")) {
    self[[getsharedfunc("perk", "activatePerk")]](perkname);
  }
}

function function_690e9e142ebc1c69(fieldupgrade1, fieldupgrade2) {
  if(utility::issharedfuncdefined("perk", "perkpackage_giveOverrideFieldUpgrades")) {
    self[[utility::getsharedfunc("perk", "perkpackage_giveOverrideFieldUpgrades")]](fieldupgrade1, fieldupgrade2);
  }
}

function function_5942f6cdbb6cb63b(perkname) {
  if(utility::issharedfuncdefined("perk", "givePerk")) {
    self[[utility::getsharedfunc("perk", "givePerk")]](perkname);
  }
}

function function_edbac3224d97a666(perkname) {
  if(utility::issharedfuncdefined("perk", "removePerk")) {
    self[[utility::getsharedfunc("perk", "removePerk")]](perkname);
  }
}

function function_234f5394668ed388(ref, optionalnumber, playerforplayercard, altdisplayindex, var_ef4849b4cb3ac7e2) {
  if(utility::issharedfuncdefined("hud", "showSplash")) {
    self[[utility::getsharedfunc("hud", "showSplash")]](ref, optionalnumber, playerforplayercard, altdisplayindex, var_ef4849b4cb3ac7e2);
  }
}

function function_ced51005e26102fa(funcname, param1, param2) {
  if(utility::issharedfuncdefined("hud", "showErrorMessage")) {
    self[[utility::getsharedfunc("hud", "showErrorMessage")]](funcname, param1, param2);
  }
}

function function_946938d9fde4bdce(featurename) {
  if(utility::issharedfuncdefined("game", "isFeatureDisabled")) {
    return [[utility::getsharedfunc("game", "isFeatureDisabled")]](featurename);
  }

  return 0;
}

function checkforactiveobjicon() {
  if(utility::issharedfuncdefined("game", "checkForActiveObjIcon")) {
    self[[utility::getsharedfunc("game", "checkForActiveObjIcon")]]();
  }
}

function deletequestobjicon() {
  if(utility::issharedfuncdefined("game", "deleteQuestObjIcon")) {
    self[[utility::getsharedfunc("game", "deleteQuestObjIcon")]]();
  }
}

function function_9d6d4c76abc82cf(pickupname, dropinfo, count, showtrail, weaponobj, allowautopickup, countlefthand, countalt) {
  if(utility::issharedfuncdefined("game", "spawnPickup")) {
    [[utility::getsharedfunc("game", "spawnPickup")]](pickupname, dropinfo, count, showtrail, weaponobj, allowautopickup, countlefthand, countalt);
  }
}

function function_aa6b52df8080cac7(var_e31d665c86f80a86, count, origin) {
  if(utility::issharedfuncdefined("game", "spawnPickupFromList")) {
    [[utility::getsharedfunc("game", "spawnPickupFromList")]](var_e31d665c86f80a86, count, origin);
  }
}

function function_e0a57e47b2947bc(lootid) {
  if(utility::issharedfuncdefined("game", "getScriptableFromLootID")) {
    return [[utility::getsharedfunc("game", "getScriptableFromLootID")]](lootid);
  }

  return undefined;
}

function function_38e113a4c30f6c0d(scriptablename, itemorigin, itemangles, itemindex, totalitemcount, var_14c85b39207719b8, var_57266f5ca6feebd7) {
  if(utility::issharedfuncdefined("game", "spawnNewItemFromScriptable")) {
    return [[utility::getsharedfunc("game", "spawnNewItemFromScriptable")]](scriptablename, itemorigin, itemangles, itemindex, totalitemcount, var_14c85b39207719b8, var_57266f5ca6feebd7);
  }
}

function function_bb87cfae1e28e70b(index, baseorigin, baseangles, ignoreent, var_8a600b6102da9f9b, var_f71d4f78d508da69, var_6fe2ff802d5192d4, var_3ace5ac9c7d6fa44) {
  if(utility::issharedfuncdefined("game", "getItemDropOriginAndAngles")) {
    [[utility::getsharedfunc("game", "getItemDropOriginAndAngles")]](index, baseorigin, baseangles, ignoreent, var_8a600b6102da9f9b, var_f71d4f78d508da69, var_6fe2ff802d5192d4, var_3ace5ac9c7d6fa44);
  }
}

function function_e2db59d7677bfceb(player, scriptablename, var_43fb3d97abb79854, countoverride, fromkiosk, droppurchased) {
  if(utility::issharedfuncdefined("game", "br_forceGiveCustomPickupItem")) {
    return [[utility::getsharedfunc("game", "br_forceGiveCustomPickupItem")]](player, scriptablename, var_43fb3d97abb79854, countoverride, fromkiosk, droppurchased);
  }
}

function function_98bd9179435d1557(player, plunderspent, purchasetype, itemname) {
  if(utility::issharedfuncdefined("game", "brAnalytics_kiosk_purchaseItem")) {
    return [[utility::getsharedfunc("game", "brAnalytics_kiosk_purchaseItem")]](player, plunderspent, purchasetype, itemname);
  }
}

function function_25fb9a3b7ee98d69(funcname, param1, param2) {
  if(utility::issharedfuncdefined("game", "runBrGametypeFunc")) {
    self[[utility::getsharedfunc("game", "runBrGametypeFunc")]](funcname, param1, param2);
  }
}

function function_be79dba5f7b2a51b(scriptablename) {
  if(utility::issharedfuncdefined("game", "isKiosk")) {
    return [[utility::getsharedfunc("game", "isKiosk")]](scriptablename);
  }
}

function function_76ae39f27ed53321(pickupent) {
  if(utility::issharedfuncdefined("game", "canTakePickup")) {
    return [[utility::getsharedfunc("game", "canTakePickup")]](pickupent);
  }
}

function function_e667d74ecc894ceb(player, menuevent, var_6c457c5f341beb23) {
  if(utility::issharedfuncdefined("game", "brAnalytics_kiosk_menu_event")) {
    [[utility::getsharedfunc("game", "brAnalytics_kiosk_menu_event")]](player, menuevent, var_6c457c5f341beb23);
  }
}

function function_f4c2d922e3610d74(iconref, state, var_38116998df9814d4) {
  if(utility::issharedfuncdefined("game", "createQuestObjIcon")) {
    self[[utility::getsharedfunc("game", "createQuestObjIcon")]](iconref, state, var_38116998df9814d4);
  }
}

function function_46f7ad16e39b4e0d(player) {
  if(utility::issharedfuncdefined("game", "showQuestObjIconToPlayer")) {
    self[[utility::getsharedfunc("game", "showQuestObjIconToPlayer")]](player);
  }
}

function function_2f0d084017095d28(eventtype) {
  if(utility::issharedfuncdefined("game", "isPublicEventOfTypeActive")) {
    return [[utility::getsharedfunc("game", "isPublicEventOfTypeActive")]](eventtype);
  }

  return 0;
}

function function_601b78b411b7479(player) {
  if(utility::issharedfuncdefined("game", "hideQuestObjIconFromPlayer")) {
    self[[utility::getsharedfunc("game", "hideQuestObjIconFromPlayer")]](player);
  }
}

function function_1a0bffd69502c210(player) {
  if(utility::issharedfuncdefined("game", "isBrPracticeMode")) {
    return [[utility::getsharedfunc("game", "isBrPracticeMode")]]();
  }

  return 0;
}

function function_f41fe8dc1d31d5bf() {
  if(utility::issharedfuncdefined("game", "respawnTokenDisabled")) {
    return [[utility::getsharedfunc("game", "respawnTokenDisabled")]]();
  }

  return 0;
}

function function_c8dfc3feceeb2896() {
  if(utility::issharedfuncdefined("game", "hasSelfReviveToken")) {
    return self[[utility::getsharedfunc("game", "hasSelfReviveToken")]]();
  }

  return 0;
}

function function_da31e13c27a6acf4(killstreakref, dropcurrent, fromkiosk, droppurchased, var_db943473454f6ea6) {
  if(utility::issharedfuncdefined("game", "forceGiveKillstreak")) {
    return self[[utility::getsharedfunc("game", "forceGiveKillstreak")]](killstreakref, dropcurrent, fromkiosk, droppurchased, var_db943473454f6ea6);
  }
}

function function_5c8ad6e89a9f7b73(location) {
  if(utility::issharedfuncdefined("game", "traceSelectedMapLocation")) {
    return [[utility::getsharedfunc("game", "traceSelectedMapLocation")]](location);
  }

  return undefined;
}

function function_cfb85293f9660751(weapon, maxammo) {
  if(utility::issharedfuncdefined("game", "getDefaultWeaponAmmo")) {
    return [[utility::getsharedfunc("game", "getDefaultWeaponAmmo")]](weapon, maxammo);
  }
}

function function_83e3b506365bafc5() {
  if(utility::issharedfuncdefined("game", "isBackpackInventoryEnabled")) {
    return [[utility::getsharedfunc("game", "isBackpackInventoryEnabled")]]();
  }

  return 0;
}

function function_67386b14d0c7d1ee() {
  if(utility::issharedfuncdefined("game", "getGameType")) {
    return [[utility::getsharedfunc("game", "getGameType")]]();
  }

  return undefined;
}

function function_3d48da36c7fd0fdb(plunderspent) {
  if(utility::issharedfuncdefined("game", "calculatePurchaseXp")) {
    return [[utility::getsharedfunc("game", "calculatePurchaseXp")]](plunderspent);
  }

  return undefined;
}

function function_a8a68668a0b2c9c4() {
  if(utility::issharedfuncdefined("game", "isAnyTutorialOrBotPracticeMatch")) {
    return [[utility::getsharedfunc("game", "isAnyTutorialOrBotPracticeMatch")]]();
  }

  return 0;
}

function function_9bc69c26770d9533(callback) {
  if(utility::issharedfuncdefined("game", "registerOnLuiEventCallback")) {
    level[[utility::getsharedfunc("game", "registerOnLuiEventCallback")]](callback);
  }
}

function function_496ba4f72ba5e5d1(index) {
  if(utility::issharedfuncdefined("game", "isLoadoutIndexDefault")) {
    return [[utility::getsharedfunc("game", "isLoadoutIndexDefault")]](index);
  }

  return 0;
}

function function_6a38b44a9a4e8761(menuindex) {
  if(utility::issharedfuncdefined("game", "getClassChoice")) {
    return [[utility::getsharedfunc("game", "getClassChoice")]](menuindex);
  }

  return undefined;
}

function function_3fcb060110170ac9(funcname) {
  if(utility::issharedfuncdefined("game", "isBrGametypeFuncDefined")) {
    return [[utility::getsharedfunc("game", "isBrGametypeFuncDefined")]](funcname);
  }

  return 0;
}

function function_188f8c265a7ef6ea(spawn_origin, flaretype) {
  if(utility::issharedfuncdefined("game", "utilFlare_shootFlare")) {
    level thread[[utility::getsharedfunc("game", "utilFlare_shootFlare")]](spawn_origin, flaretype);
  }
}

function function_9cb5f84f96e33914(point, var_ae913f2dc0534b48, var_498e4e279fb8ed85) {
  if(utility::issharedfuncdefined("game", "isValidPointInBounds")) {
    return [[utility::getsharedfunc("game", "isValidPointInBounds")]](point, var_ae913f2dc0534b48, var_498e4e279fb8ed85);
  }

  return 0;
}

function function_fa5baabe8489e675(origin, var_8f6402ad8e91da6a, startcircleindex, var_26189638809f7b88) {
  if(utility::issharedfuncdefined("game", "initCirclePostStartToCircleIndex")) {
    [[utility::getsharedfunc("game", "initCirclePostStartToCircleIndex")]](origin, var_8f6402ad8e91da6a, startcircleindex, var_26189638809f7b88);
  }
}

function function_9d18a22123e54d05(featurename) {
  if(utility::issharedfuncdefined("game", "isFeatureEnabled")) {
    return [[utility::getsharedfunc("game", "isFeatureEnabled")]](featurename);
  }

  return 0;
}

function function_baf6855827fe902() {
  if(utility::issharedfuncdefined("game", "spectate_init")) {
    [[utility::getsharedfunc("game", "spectate_init")]]();
  }
}

function function_560b2e700ce084a2(v_origin) {
  if(utility::issharedfuncdefined("game", "roundNumberDifficulty")) {
    return [[utility::getsharedfunc("game", "roundNumberDifficulty")]](v_origin);
  }

  assertmsg("Define a function for gametype " + level.gametype + " using scripts\engine\utility::registerSharedFunc( \"game\", \"roundNumberDifficulty\", func ) to get the round number difficulty");
}

function function_9563f2d4e690856d(team, property) {
  if(utility::issharedfuncdefined("game", "getTeamData")) {
    return [[utility::getsharedfunc("game", "getTeamData")]](team, property);
  }

  return [];
}

function function_83823ec7b243d291(type, category, value) {
  return utility::function_f3bb4f4911a1beb2("game", "registerScoreInfo", type, category, value);
}

function function_414c67fb50cf15b8(player, soundtype, targetent, delay, location) {
  return utility::function_f3bb4f4911a1beb2("game", "trySayLocalSound", player, soundtype, targetent, delay, location);
}

function function_d73502b54466bc10(data) {
  return utility::function_f3bb4f4911a1beb2("game", "handlemovingplatforms", data);
}

function function_61575e37b9200c0d() {
  return utility::function_f3bb4f4911a1beb2("game", "isTeamReviveEnabled");
}

function function_978c422352ec22bc(var_21323aee11762c98, showto, tomark, groupowner, friendlymarker, markonspawn, var_262f4b55aa151de1) {
  return utility::function_f3bb4f4911a1beb2("game", "targetMarkerGroup_on", var_21323aee11762c98, showto, tomark, groupowner, friendlymarker, markonspawn, var_262f4b55aa151de1);
}

function function_a24feab7513ef158(var_4226c12910d867d4) {
  return utility::function_f3bb4f4911a1beb2("game", "targetMarkerGroup_off", var_4226c12910d867d4);
}

function function_e09c803c659910d1(threatbiasgroup, var_5c00772332ce642c, islethal, var_5f6534ad3a0a1fa2, var_719c179eabb70b31, var_8928fdf873929e88) {
  return utility::function_f3bb4f4911a1beb2("game", "registerSentient", threatbiasgroup, var_5c00772332ce642c, islethal, var_5f6534ad3a0a1fa2, var_719c179eabb70b31, var_8928fdf873929e88);
}

function function_1882e2b280ff6e57(ent, ref) {
  return utility::function_f3bb4f4911a1beb2("game", "registerEntForOOB", ent, ref);
}

function function_366da6404beaf71d(ent, fromdeath) {
  return utility::function_f3bb4f4911a1beb2("game", "clearOOB", ent, fromdeath);
}

function function_6a067ab37ac2c0c2(entity) {
  return utility::function_f3bb4f4911a1beb2("game", "addSpawnViewer", entity);
}

function function_7d39bf4c0d07e091(entity) {
  return utility::function_f3bb4f4911a1beb2("game", "removeSpawnViewer", entity);
}

function function_cea710f9d017694a(set) {
  utility::function_f3bb4f4911a1beb2("game", "ForceNetfieldHighLoD", set);
}

function function_73f2baa01fa2b921(var_863c619037f3ac74, var_da8cec9bce12f9cb) {
  return utility::function_f3bb4f4911a1beb2("game", "isPointInOutOfBounds", var_863c619037f3ac74, var_da8cec9bce12f9cb);
}

function function_b1412f0ab907bab7() {
  return function_f3bb4f4911a1beb2("game", "isBRStyleGameType");
}

function function_2284137aa92dbd16(duration) {
  return utility::function_f3bb4f4911a1beb2("hostmigration", "waitLongDurationWithPause", duration);
}

function waittill_notify_or_timeout_hostmigration_pause(msg, duration) {
  return utility::function_f3bb4f4911a1beb2("hostmigration", "waittillNotifyOrTimeoutPause", msg, duration);
}

function function_300f8bd96a4461ff(objweapon, start, end, owner, event_ent) {
  return utility::function_f3bb4f4911a1beb2("weapons", "magicBullet", objweapon, start, end, owner, event_ent);
}

function function_6262c3a1ef0924d(set) {
  return function_f3bb4f4911a1beb2("weapons", "setMissileMinimapVisible", set);
}

function function_7a0d2d9d94d820ae(position, duration, scalemax, scalemid, scalemin, radiusmax, radiusmid, radiusmin, ignoreclients, playrumble, var_a03583ed539bdb39) {
  return utility::function_f3bb4f4911a1beb2("shellshock", "artillery_earthQuake", position, duration, scalemax, scalemid, scalemin, radiusmax, radiusmid, radiusmin, ignoreclients, playrumble, var_a03583ed539bdb39);
}

function function_74efaa97ebfec5df(points, scoreevent, var_b4b593facaa83af7, pointsmultiplier) {
  if(utility::issharedfuncdefined("supers", "giveSuperPoints")) {
    self[[utility::getsharedfunc("supers", "giveSuperPoints")]](points, scoreevent, var_b4b593facaa83af7, pointsmultiplier);
  }
}

function function_19dd797e5d48d987() {
  if(utility::issharedfuncdefined("supers", "getSuperPointsNeeded")) {
    self[[utility::getsharedfunc("supers", "getSuperPointsNeeded")]]();
  }
}

function function_4f2bd7da634cba24(superref, var_6c70bf5ad211f464, immediate, blueprintindex) {
  if(utility::issharedfuncdefined("supers", "giveSuper")) {
    self[[utility::getsharedfunc("supers", "giveSuper")]](superref, var_6c70bf5ad211f464, immediate, blueprintindex);
  }
}

function function_77986db57958b676(killstreakref) {
  if(utility::issharedfuncdefined("player", "hasKillstreak")) {
    return self[[utility::getsharedfunc("player", "hasKillstreak")]](killstreakref);
  }

  return 0;
}

function function_3f422a1c87bd2809() {
  if(utility::issharedfuncdefined("player", "isSuperInUse")) {
    return self[[utility::getsharedfunc("player", "isSuperInUse")]]();
  }

  return 0;
}

function function_97fac14206681b1f() {
  if(utility::issharedfuncdefined("player", "getCurrentSuperRef")) {
    return self[[utility::getsharedfunc("player", "getCurrentSuperRef")]]();
  }
}

function function_eceea793e05658bd() {
  if(utility::issharedfuncdefined("player", "br_ammo_player_is_maxed_out")) {
    return self[[utility::getsharedfunc("player", "br_ammo_player_is_maxed_out")]]();
  }

  return 0;
}

function function_6e3db23952f2e451(pickupent, var_db943473454f6ea6) {
  if(utility::issharedfuncdefined("player", "takeWeaponPickup")) {
    self[[utility::getsharedfunc("player", "takeWeaponPickup")]](pickupent, var_db943473454f6ea6);
  }
}

function function_eb96721d13c5f3df(targetsupername, dropcurrent, fromkiosk, droppurchased, var_db943473454f6ea6) {
  if(utility::issharedfuncdefined("player", "forceGiveSuper")) {
    self[[utility::getsharedfunc("player", "forceGiveSuper")]](targetsupername, dropcurrent, fromkiosk, droppurchased, var_db943473454f6ea6);
  }
}

function function_836c7d119e02d1d5() {
  if(utility::issharedfuncdefined("player", "br_ammo_player_max_out")) {
    self[[utility::getsharedfunc("player", "br_ammo_player_max_out")]]();
  }
}

function function_c00f90a28c41febe(skipsplash) {
  if(utility::issharedfuncdefined("player", "addRespawnToken")) {
    self[[utility::getsharedfunc("player", "addRespawnToken")]](skipsplash);
  }
}

function function_2d5a30d6fe54567b(skipsplash) {
  if(utility::issharedfuncdefined("player", "addSelfReviveToken")) {
    self[[utility::getsharedfunc("player", "addSelfReviveToken")]](skipsplash);
  }
}

function updatehitmarker_sharedfunc(markertype, killingblow, headshot, nonplayer, icontype, targetentnum, armorplatecount, var_203066c6662e1f2d) {
  return utility::function_f3bb4f4911a1beb2("hitmarker", "updateHitMarker_SharedFunc", markertype, killingblow, headshot, nonplayer, icontype, targetentnum, armorplatecount, var_203066c6662e1f2d);
}

function updatedamagefeedback_sharedfunc(icontype) {
  return utility::function_f3bb4f4911a1beb2("hitmarker", "updateDamageFeedback_SharedFunc", icontype);
}

function function_c4d8558fc1592cd6() {
  if(utility::issharedfuncdefined("player", "isJuggernaut")) {
    return self[[utility::getsharedfunc("player", "isJuggernaut")]]();
  }

  return 0;
}

function function_ef240aa7c1052d13(lootid, pickup, var_70e660487c2924ec, param4) {
  if(utility::issharedfuncdefined("player", "addItemToBackpack")) {
    return self[[utility::getsharedfunc("player", "addItemToBackpack")]](lootid, pickup, var_70e660487c2924ec, param4);
  }

  return 0;
}

function function_507b98884b41cc8e() {
  if(utility::issharedfuncdefined("player", "getAvailableDMZBackpackIndex")) {
    return [[utility::getsharedfunc("player", "getAvailableDMZBackpackIndex")]]();
  }

  return undefined;
}

function function_e800498086e36c29(event, objweapon, pointsoverride, xpoverride, victim, var_51bdae03b05bc75e, dontwait, cankillchain, streakinfo, var_827c276da1cdcf23) {
  if(utility::issharedfuncdefined("player", "doScoreEvent")) {
    return [[utility::getsharedfunc("player", "doScoreEvent")]](event, objweapon, pointsoverride, xpoverride, victim, var_51bdae03b05bc75e, dontwait, cankillchain, streakinfo, var_827c276da1cdcf23);
  }

  return undefined;
}

function function_a4968a44b192f2ed(class, var_1dce12d4eaf02799) {
  if(utility::issharedfuncdefined("player", "preloadAndQueueClass")) {
    return self[[utility::getsharedfunc("player", "preloadAndQueueClass")]](class, var_1dce12d4eaf02799);
  }

  return undefined;
}

function function_be7af2b74939c9b5(player, dropcurrent) {
  if(utility::issharedfuncdefined("player", "br_giveSelectedClass")) {
    [[utility::getsharedfunc("player", "br_giveSelectedClass")]](player, dropcurrent);
  }
}

function function_b71e2f7afd69d580() {
  if(utility::issharedfuncdefined("player", "isEligibleForTeamRevive")) {
    return self[[utility::getsharedfunc("player", "isEligibleForTeamRevive")]]();
  }

  return 0;
}

function function_f6c807a601f8a34d(player) {
  if(utility::issharedfuncdefined("player", "isRespawningFromToken")) {
    return [[utility::getsharedfunc("player", "isRespawningFromToken")]](player);
  }

  return 0;
}

function function_8bd31d20349aa464(sponsor, tokenused, var_5806c4765695a2f4, var_74af5908127b6729) {
  if(utility::issharedfuncdefined("player", "playerGulagAutoWin")) {
    self[[utility::getsharedfunc("player", "playerGulagAutoWin")]]("", sponsor, tokenused, var_5806c4765695a2f4, var_74af5908127b6729);
  }
}

function function_20071a4b90f92b46(spawnpoint) {
  if(utility::issharedfuncdefined("player", "playerPrestreamRespawnOrigin")) {
    return self[[utility::getsharedfunc("player", "playerPrestreamRespawnOrigin")]](spawnpoint);
  }

  return undefined;
}

function function_a39e8a33d7378f08(fadespectators) {
  if(utility::issharedfuncdefined("player", "gulagFadeToBlack")) {
    self[[utility::getsharedfunc("player", "gulagFadeToBlack")]](fadespectators);
  }
}

function function_92e04b29006f91c() {
  if(utility::issharedfuncdefined("player", "gulagStreamExit")) {
    self[[utility::getsharedfunc("player", "gulagStreamExit")]]();
  }
}

function function_2cea92d21876a90a(origin, angles) {
  if(utility::issharedfuncdefined("player", "gulagStreamExit")) {
    self[[utility::getsharedfunc("player", "gulagStreamExit")]](origin, angles);
  }
}

function function_1f5865aab1fdafd(ent) {
  if(utility::issharedfuncdefined("player", "gulagStreamExit")) {
    self[[utility::getsharedfunc("player", "gulagStreamExit")]](ent);
  }
}

function function_b4e05f84b56c7bbf() {
  if(utility::issharedfuncdefined("player", "playerWaittillStreamHintComplete")) {
    self[[utility::getsharedfunc("player", "playerWaittillStreamHintComplete")]]();
  }
}

function function_ba38e09a56256701() {
  if(utility::issharedfuncdefined("player", "playerClearStreamHintOrigin")) {
    self[[utility::getsharedfunc("player", "playerClearStreamHintOrigin")]]();
  }
}

function function_4ec23357b146259c() {
  if(utility::issharedfuncdefined("player", "resetPlayerMoveSpeedScale")) {
    self[[utility::getsharedfunc("player", "resetPlayerMoveSpeedScale")]]();
  }
}

function function_b17054c9879ea13b() {
  if(utility::issharedfuncdefined("player", "gulagFadeFromBlack")) {
    self[[utility::getsharedfunc("player", "gulagFadeFromBlack")]]();
  }
}

function function_78a18c3b6dbfb0a5(amount, data) {
  if(utility::issharedfuncdefined("player", "playerPlunderKioskPurchase")) {
    self[[utility::getsharedfunc("player", "playerPlunderKioskPurchase")]](amount, data);
  }
}

function function_11ab60f2ec5f498a(player, fadetoblack, fadetime) {
  return utility::function_f3bb4f4911a1beb2("player", "fadeToBlackForPlayer", player, fadetoblack, fadetime);
}

function function_e65042177e4ef1be(name, category, duration, animationresponse, interruptdelayms) {
  return utility::function_f3bb4f4911a1beb2("player", "shellShock", name, category, duration, animationresponse, interruptdelayms);
}

function function_35dc5da55bba8f1e(fromdeath) {
  return utility::function_f3bb4f4911a1beb2("player", "stopShellShock", fromdeath);
}

function function_c0954ceff138883b() {
  return utility::function_f3bb4f4911a1beb2("player", "setDOF_cruiseFirst");
}

function function_bb10f30a40421b3f(frozen, force, debug) {
  return utility::function_f3bb4f4911a1beb2("player", "freezeControls", frozen, force, debug);
}

function function_ff961ce881949b90(player) {
  return utility::function_f3bb4f4911a1beb2("player", "getSuperFaction", player);
}

function function_287a1854579369f5() {
  return utility::function_f3bb4f4911a1beb2("player", "_isAlive");
}

function function_883458a342af3041(origin, radius, desiredteam, excludeent) {
  return utility::function_f3bb4f4911a1beb2("player", "getPlayersInRadius", origin, radius, desiredteam, excludeent);
}

function function_3ce030587f143c98(frozen, force) {
  return utility::function_f3bb4f4911a1beb2("player", "freezeLookControls", frozen, force);
}

function function_90ca6872b70e4c2e(player, reason) {
  if(utility::issharedfuncdefined("dlog", "brAnalytics_inventory_snapshot")) {
    [[utility::getsharedfunc("dlog", "brAnalytics_inventory_snapshot")]](player, reason);
  }
}

function function_3cf2d6ddf853bdee(player, plunderspent, loadoutdata) {
  if(utility::issharedfuncdefined("dlog", "brAnalytics_kiosk_purchaseLoadout")) {
    [[utility::getsharedfunc("dlog", "brAnalytics_kiosk_purchaseLoadout")]](player, plunderspent, loadoutdata);
  }
}

function function_88cafec24778c70c(confirmstring, cancelstring, endstring) {
  if(utility::issharedfuncdefined("killstreak", "waittill_confirm_or_cancel")) {
    return self[[utility::getsharedfunc("killstreak", "waittill_confirm_or_cancel")]](confirmstring, cancelstring, endstring);
  }

  return undefined;
}

function function_f8f5d33ba1c643df(bundle, killstreak) {
  return utility::function_f3bb4f4911a1beb2("killstreak", "killstreak_registerMinimapInfo", bundle, killstreak);
}

function function_2c47324e96a0854a(streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_8dfc256103cce53e, var_191284e2e2837328, premoddamagecallback, postmoddamagecallback, deathcallback) {
  return utility::function_f3bb4f4911a1beb2("killstreak", "killstreak_setupVehicleDamageFunctionality", streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_8dfc256103cce53e, var_191284e2e2837328, premoddamagecallback, postmoddamagecallback, deathcallback);
}

function function_d055c8fd735fd960(attacker, objweapon, meansofdeath, amount, maxhealth, var_cb15fa5174e71840, var_be7c04516c5d9ccd, var_ca960a517459fe15, var_8aceb016baaf67af, var_64103c6b531d18f0, explodeoverride) {
  return utility::function_f3bb4f4911a1beb2("killstreak", "getModifiedAntiKillstreakDamage", attacker, objweapon, meansofdeath, amount, maxhealth, var_cb15fa5174e71840, var_be7c04516c5d9ccd, var_ca960a517459fe15, var_8aceb016baaf67af, var_64103c6b531d18f0, explodeoverride);
}

function function_ea1962c946f018b2(currenthealth) {
  return utility::function_f3bb4f4911a1beb2("killstreak", "killstreak_updateDamageState", currenthealth);
}

function function_de31b76c1bf488e8(streakinfo, weaponobj, firednotify, weapongivencallback, var_8fd4d93dd619da88, weaponfiredcallback, var_91f739c2c51347d4, var_d55d8445518099b) {
  return function_f3bb4f4911a1beb2("killstreak", "streakDeploy_doWeaponFiredDeploy", streakinfo, weaponobj, firednotify, weapongivencallback, var_8fd4d93dd619da88, weaponfiredcallback, var_91f739c2c51347d4, var_d55d8445518099b);
}

function function_b01aad7f0553d2c8() {
  if(issharedfuncdefined("killstreak", "playerKillstreakGetOwnerLookAtIgnoreEnts")) {
    return function_f3bb4f4911a1beb2("killstreak", "playerKillstreakGetOwnerLookAtIgnoreEnts");
  }

  return undefined;
}

function function_940b2080e171a9d3(owner, ownerteam, range, streakname, location) {
  return function_f3bb4f4911a1beb2("killstreak", "killstreak_dangerNotifyPlayersInRange", owner, ownerteam, range, streakname, location);
}

function function_62de81d97c7d9e49(streakname, triggeredfunc, availablefunc, var_b1469bcdaec75a9) {
  return utility::function_f3bb4f4911a1beb2("killstreak", "registerKillstreak", streakname, triggeredfunc, availablefunc, var_b1469bcdaec75a9);
}

function function_a41e3a211a9e37a4(streakname, var_d8a64ed9bcdf7185, damagesize) {
  return utility::function_f3bb4f4911a1beb2("killstreak", "registerKillstreakDamageDealingWeapon", streakname, var_d8a64ed9bcdf7185, damagesize);
}

function function_80dd0a6b17291eb3(streakname, var_3e99c59055b3de67, omnvarvalue) {
  return utility::function_f3bb4f4911a1beb2("killstreak", "registerVisibilityOmnvarForKillstreak", streakname, var_3e99c59055b3de67, omnvarvalue);
}

function function_bc5bcad4a3bbd734(streakname, owner) {
  return utility::function_f3bb4f4911a1beb2("killstreak", "createStreakInfo", streakname, owner);
}

function function_63046c2c6bbd3868(streakinfo, weapongivencallback, var_8fd4d93dd619da88, var_91f739c2c51347d4, var_d55d8445518099b, var_f6a32dcc4b19aad9, var_67a06b4ea269058e, var_afe464c242489272, var_818a18147626dfbf, var_c2a00d4f077ebd87) {
  return utility::function_f3bb4f4911a1beb2("killstreak", "streakDeploy_doWeaponTabletDeploy", streakinfo, weapongivencallback, var_8fd4d93dd619da88, var_91f739c2c51347d4, var_d55d8445518099b, var_f6a32dcc4b19aad9, var_67a06b4ea269058e, var_afe464c242489272, var_818a18147626dfbf, var_c2a00d4f077ebd87);
}

function function_b00fe2fecfa420d0() {
  return utility::function_f3bb4f4911a1beb2("killstreak", "getKillstreakAirStrikeHeightEnt");
}

function function_d1b8339c6ab7b1fa(streakname, dialog, var_db68eeda63af9504, delaytime, charactersuffix) {
  return utility::function_f3bb4f4911a1beb2("killstreak", "playKillstreakOperatorDialog", streakname, dialog, var_db68eeda63af9504, delaytime, charactersuffix);
}

function function_25c4c34d6c3dd08a(killstreakref) {
  if(utility::issharedfuncdefined("killstreak", "forceUseKillstreak")) {
    return self[[utility::getsharedfunc("killstreak", "forceUseKillstreak")]](killstreakref);
  }

  return undefined;
}

function function_f5e58b5375381386(splashref, streakval, fromcarepackage) {
  if(utility::issharedfuncdefined("airdrop", "showKillstreakSplash")) {
    self thread[[utility::getsharedfunc("airdrop", "showKillstreakSplash")]](splashref, streakval, fromcarepackage);
  }
}

function function_f87529d7af4978b(streakname, source, overridelifeid, var_722764086bd2150d, overrideowner, var_546f4a2e8b131d3f, blueprintindex) {
  if(utility::issharedfuncdefined("killstreak", "awardKillstreak")) {
    self[[utility::getsharedfunc("killstreak", "awardKillstreak")]](streakname, source, overridelifeid, var_722764086bd2150d, overrideowner, var_546f4a2e8b131d3f, blueprintindex);
  }
}

function function_6741f10c19432885(streakname, var_b677bbe2241c4e3f) {
  return utility::function_f3bb4f4911a1beb2("killstreak", "setVisibiilityOmnvarForKillstreak", streakname, var_b677bbe2241c4e3f);
}

function function_37b26588f564813d(player) {
  return utility::function_f3bb4f4911a1beb2("killstreak", "restoreKillstreakPlayerAngles", player);
}

function function_fd8ddf2e23d31475(streakinfo) {
  return utility::function_f3bb4f4911a1beb2("killstreak", "recordKillstreakEndStats", streakinfo);
}

function function_b23ab1c04cc7fea2(visionsetname) {
  return utility::function_f3bb4f4911a1beb2("killstreak", "killstreak_setMainVision", visionsetname);
}

function function_a271c8ce1dd6c1b1(visionsetinfo) {
  return utility::function_f3bb4f4911a1beb2("killstreak", "killstreak_setSubVision", visionsetinfo);
}

function function_2470b047f8e10642(count) {
  return utility::function_f3bb4f4911a1beb2("vehicle", "reserveVehicle", count);
}

function function_49d5647f46bfe073(count) {
  return utility::function_f3bb4f4911a1beb2("vehicle", "clearVehicleReservation", count);
}

function function_10498f0a8127ad3a(bool) {
  return utility::function_f3bb4f4911a1beb2("vehicle", "vehicle_damage_setCanDamage", bool);
}

function function_3c16f3b83d60acbb(ref, minradius) {
  return utility::function_f3bb4f4911a1beb2("vehicle", "vehicle_spawn_setClearanceCheckMinRadius", ref, minradius);
}

function function_b2db3eefeaba048f(data, changed, fromdeath) {
  return utility::function_f3bb4f4911a1beb2("vehicle", "vehicle_damage_clearVisuals", data, changed, fromdeath);
}

function function_d7d7db3140b95ce3() {
  return function_f3bb4f4911a1beb2("vehicle", "vehicleCanFly");
}

function function_1a9f6dcef6e686ab(spawndata, faildata) {
  return utility::function_f3bb4f4911a1beb2("vehicle", "spawnVehicle", spawndata, faildata);
}

function function_2b2ae7070b2e47d(vehicle) {
  return utility::function_f3bb4f4911a1beb2("vehicle", "deleteVehicle", vehicle);
}

function function_84cc2da11f01ae43(vehicle, owner, team) {
  return utility::function_f3bb4f4911a1beb2("vehicle", "registerInstance", vehicle, owner, team);
}

function function_239d68eacdce9d10(vehicle) {
  return utility::function_f3bb4f4911a1beb2("vehicle", "deregisterInstance", vehicle);
}

function function_97e107d1361352a9(position) {
  return utility::function_f3bb4f4911a1beb2("event", "predatorMissileImpact", position);
}

function function_1d266a4cf6b48ffa(position) {
  return utility::function_f3bb4f4911a1beb2("event", "largeVehicleExplosion", position);
}

function function_60a28142eebe56eb(damagedata) {
  return utility::function_f3bb4f4911a1beb2("event", "vehicleKilled", damagedata);
}

function function_f03259645f5df6c0(missile) {
  return utility::function_f3bb4f4911a1beb2("event", "missileFired", missile);
}

function function_641996b5e113c5c6(entity, applycallback, startcallback, clearcallback) {
  return utility::function_f3bb4f4911a1beb2(#"emp", #"hash_a865e3770eb96298", entity, applycallback, startcallback, clearcallback);
}

function function_83cebe0ae5318a7f(entity) {
  return utility::function_f3bb4f4911a1beb2("emp", "emp_debuff_deregister", entity);
}

function function_940c49da06910de0(fromdeath) {
  return utility::function_f3bb4f4911a1beb2("emp", "clear_emp", fromdeath);
}

function function_72b03e277d253250(status) {
  return utility::function_f3bb4f4911a1beb2("emp", "allow_emp", status);
}

function function_8e610f938a53a07d() {
  return utility::function_f3bb4f4911a1beb2("emp", "emp_debuff_get_emp_count");
}

function function_f3890748bda5f813() {
  return function_f3bb4f4911a1beb2("emp", "is_empd");
}

function function_345d613203ca10d8(var_fa88f8af6b2f44d0, isjammer) {
  return utility::function_f3bb4f4911a1beb2("emp", "play_scramble", var_fa88f8af6b2f44d0, isjammer);
}

function function_ea96a5c13167a126(var_fa88f8af6b2f44d0, isjammer) {
  return utility::function_f3bb4f4911a1beb2("emp", "stop_scramble", var_fa88f8af6b2f44d0, isjammer);
}

function function_2ad34da25e5bdd45(aliasname, player, srcentity) {
  return utility::function_f3bb4f4911a1beb2("sound", "playSoundToPlayer", aliasname, player, srcentity);
}

function function_1f9d1f30f6845dd(fxid, position, player, forward, up) {
  return utility::function_f3bb4f4911a1beb2("fx", "SpawnFXForClient", fxid, position, player, forward, up);
}

function function_e531ef189c6c5d1d() {
  utility::function_f3bb4f4911a1beb2("fx", "SetFXKillDefOnDelete");
}

function function_2611d163b331ae1d(scriptbundle_name, current_round) {
  return utility::function_f3bb4f4911a1beb2("zombie", "health_scaling_get_starting_health", scriptbundle_name, current_round);
}

function function_f1810da227cb50f9() {
  return utility::function_f3bb4f4911a1beb2("zombie", "ammo_mod_cooldown_init");
}

function function_2e380dedfcfc7972(w_current) {
  return utility::function_f3bb4f4911a1beb2("zombie", "has_ammo_mod", w_current);
}

function function_87b7af080857567f(w_current) {
  return utility::function_f3bb4f4911a1beb2("zombie", "get_ammo_mod_name", w_current);
}

function function_ed7c10f78d0598f2(weapon) {
  return utility::function_f3bb4f4911a1beb2("zombie", "GetPlayerWeaponRarity", weapon);
}

function function_af5127390d3221e9(weapon) {
  return utility::function_f3bb4f4911a1beb2("zombie", "get_pap_level", weapon);
}

function onhumanoidagentkilledcommon_sharedfunc(einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration, dropweapons) {
  return utility::function_f3bb4f4911a1beb2("ai", "onHumanoidAgentKilledCommon_SharedFunc", einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration, dropweapons);
}

function spawnnewaitype_sharedfunc(aitype, position, angles, team, var_42e5c77b1d7fe6e7) {
  return utility::function_f3bb4f4911a1beb2("ai", "spawnNewAIType_SharedFunc", aitype, position, angles, team, var_42e5c77b1d7fe6e7);
}

function animscripted_sharedfunc(anime, anim_string, org, animangles, anim_flag) {
  return utility::function_f3bb4f4911a1beb2("ai", "Animscripted_SharedFunc", anime, anim_string, org, animangles, anim_flag);
}

function get_aitype_by_subclass_sharedfunc(subclass) {
  return utility::function_f3bb4f4911a1beb2("ai", "get_aitype_by_subclass_SharedFunc", subclass);
}

function get_aitype_default_spawn_team_sharedfunc() {
  return utility::function_f3bb4f4911a1beb2("ai", "get_aitype_default_spawn_team_SharedFunc");
}

function displaydamagenumber_sharedfunc(eattacker, etargethit, shitloc, smeansofdeath, sweapon, idamage, vpoint, isimmnue, selement, var_14edc6d1db3695bc, var_feef4b237a6beb07) {
  return utility::function_f3bb4f4911a1beb2("ai", "displayDamageNumber_SharedFunc", eattacker, etargethit, shitloc, smeansofdeath, sweapon, idamage, vpoint, isimmnue, selement, var_14edc6d1db3695bc, var_feef4b237a6beb07);
}

function function_ae4755f24321c4dc(weapname) {
  return utility::function_f3bb4f4911a1beb2("ai", "giveAIWeapon", weapname);
}

function function_c9eebf69d9a55148() {
  return utility::function_f3bb4f4911a1beb2("ai", "GetFreeAICount");
}

function function_2f8556207c6fd79f() {
  return function_f3bb4f4911a1beb2("cameras", "GetCameraThirdPerson");
}

function function_aef9ca498b472945() {
  return function_f3bb4f4911a1beb2("cameras", "GetCameraThirdPersonOrigin");
}

function function_a93fbc5ac33fc2f2(powerupname, lifetime) {
  if(utility::issharedfuncdefined("powerups", "showPowerupHud")) {
    self[[utility::getsharedfunc("powerups", "showPowerupHud")]](powerupname, lifetime);
  }
}

function function_990cf49669e49965() {
  if(utility::issharedfuncdefined("powerups", "doPowerupScoreEvent")) {
    self[[utility::getsharedfunc("powerups", "doPowerupScoreEvent")]]();
  }
}

function function_f4927f5a7aa5c6ab(powerupname, spawnpos, lifetimeoverride) {
  if(utility::issharedfuncdefined("powerups", "dropPowerup")) {
    return self[[utility::getsharedfunc("powerups", "dropPowerup")]](powerupname, spawnpos, lifetimeoverride);
  }
}

function function_fc2ee23e4402d457() {
  return utility::function_f3bb4f4911a1beb2("points", "get_points");
}

function function_993919ed9d35feeb(points) {
  return utility::function_f3bb4f4911a1beb2("points", "set_points", points);
}

function function_36a28b99ec0f7fd8(points) {
  return utility::function_f3bb4f4911a1beb2("points", "add_points", points);
}

function function_88137cfcbacc59b2(points) {
  return utility::function_f3bb4f4911a1beb2("points", "take_points", points);
}