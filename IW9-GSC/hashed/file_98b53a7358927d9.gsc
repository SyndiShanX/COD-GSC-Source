/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_98b53a7358927d9.gsc
***********************************************/

_id_87072B42853A9C58(perkname) {
  _id_58123F4F0B918DBC = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk"))
    _id_58123F4F0B918DBC = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]](perkname);

  return _id_58123F4F0B918DBC;
}

_id_CC76ABCED8A70F47(perkname) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "activatePerk"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "activatePerk")]](perkname);
}

_id_234F5394668ED388(ref, optionalnumber, playerforplayercard, altdisplayindex, _id_EF4849B4CB3AC7E2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showSplash"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showSplash")]](ref, optionalnumber, playerforplayercard, altdisplayindex, _id_EF4849B4CB3AC7E2);
}

_id_946938D9FDE4BDCE(_id_3F44C731FDDDD082) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isFeatureDisabled"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isFeatureDisabled")]](_id_3F44C731FDDDD082);
  else
    return 0;
}

checkforactiveobjicon() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "checkForActiveObjIcon"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "checkForActiveObjIcon")]]();
}

deletequestobjicon() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "deleteQuestObjIcon"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "deleteQuestObjIcon")]]();
}

_id_09D6D4C76ABC82CF(_id_C0DD242FFCB18BD2, _id_CB4FAD49263E20C4, count, _id_8D9AE21C4B7DA354, weaponobj, _id_1AD2DB70C8D01F51, countlefthand, _id_E97D731BEDD44C63) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "spawnPickup"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "spawnPickup")]](_id_C0DD242FFCB18BD2, _id_CB4FAD49263E20C4, count, _id_8D9AE21C4B7DA354, weaponobj, _id_1AD2DB70C8D01F51, countlefthand, _id_E97D731BEDD44C63);
}

_id_BB87CFAE1E28E70B(index, baseorigin, baseangles, _id_447F40C814B97CDC, _id_8A600B6102DA9F9B, _id_F71D4F78D508DA69, _id_6FE2FF802D5192D4, _id_3ACE5AC9C7D6FA44) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getItemDropOriginAndAngles"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getItemDropOriginAndAngles")]](index, baseorigin, baseangles, _id_447F40C814B97CDC, _id_8A600B6102DA9F9B, _id_F71D4F78D508DA69, _id_6FE2FF802D5192D4, _id_3ACE5AC9C7D6FA44);
}

_id_E2DB59D7677BFCEB(player, scriptablename, _id_43FB3D97ABB79854, _id_8E4538D786FB9418, _id_7F437A5779C8787C, _id_1E736A37C3737585) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "br_forceGiveCustomPickupItem"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "br_forceGiveCustomPickupItem")]](player, scriptablename, _id_43FB3D97ABB79854, _id_8E4538D786FB9418, _id_7F437A5779C8787C, _id_1E736A37C3737585);
}

_id_98BD9179435D1557(player, _id_465AB95DD1230BD3, _id_75B71E1F4013579E, itemname) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "brAnalytics_kiosk_purchaseItem"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "brAnalytics_kiosk_purchaseItem")]](player, _id_465AB95DD1230BD3, _id_75B71E1F4013579E, itemname);
}

_id_74EFAA97EBFEC5DF(points, _id_F0FA3B7B27926553, _id_B4B593FACAA83AF7, _id_53E3AF3B2C8752BD) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](points, _id_F0FA3B7B27926553, _id_B4B593FACAA83AF7, _id_53E3AF3B2C8752BD);
}

_id_19DD797E5D48D987() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "getSuperPointsNeeded"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "getSuperPointsNeeded")]]();
}

_id_4F2BD7DA634CBA24(_id_EBEC497FF8B18A45, _id_6C70BF5AD211F464, immediate) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuper"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuper")]](_id_EBEC497FF8B18A45, _id_6C70BF5AD211F464, immediate);
}

_id_25FB9A3B7EE98D69(_id_EA847593E957F2B0, param1, param2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "runBrGametypeFunc"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "runBrGametypeFunc")]](_id_EA847593E957F2B0, param1, param2);
}

_id_CED51005E26102FA(_id_EA847593E957F2B0, param1, param2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](_id_EA847593E957F2B0, param1, param2);
}

_id_BE79DBA5F7B2A51B(scriptablename) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isKiosk"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isKiosk")]](scriptablename);
}

_id_76AE39F27ED53321(pickupent) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "canTakePickup"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "canTakePickup")]](pickupent);
}

_id_E667D74ECC894CEB(player, _id_A00244F669488912, _id_6C457C5F341BEB23) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "brAnalytics_kiosk_menu_event"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "brAnalytics_kiosk_menu_event")]](player, _id_A00244F669488912, _id_6C457C5F341BEB23);
}

_id_F4C2D922E3610D74(_id_CB8E582431CF1641, state, _id_38116998DF9814D4) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createQuestObjIcon"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createQuestObjIcon")]](_id_CB8E582431CF1641, state, _id_38116998DF9814D4);
}

_id_46F7AD16E39B4E0D(player) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "showQuestObjIconToPlayer"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "showQuestObjIconToPlayer")]](player);
}

_id_2F0D084017095D28(eventtype) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isPublicEventOfTypeActive"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isPublicEventOfTypeActive")]](eventtype);

  return 0;
}

_id_0601B78B411B7479(player) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "hideQuestObjIconFromPlayer"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "hideQuestObjIconFromPlayer")]](player);
}

_id_1A0BFFD69502C210(player) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBrPracticeMode"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBrPracticeMode")]]();

  return 0;
}

_id_77986DB57958B676(_id_A4E8372932B8612C) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hasKillstreak"))
    return self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hasKillstreak")]](_id_A4E8372932B8612C);

  return 0;
}

_id_3F422A1C87BD2809() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isSuperInUse"))
    return self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isSuperInUse")]]();

  return 0;
}

_id_97FAC14206681B1F() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "getCurrentSuperRef"))
    return self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getCurrentSuperRef")]]();
}

_id_ECEEA793E05658BD() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "br_ammo_player_is_maxed_out"))
    return self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "br_ammo_player_is_maxed_out")]]();

  return 0;
}

_id_F41FE8DC1D31D5BF() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "respawnTokenDisabled"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "respawnTokenDisabled")]]();

  return 0;
}

_id_C8DFC3FECEEB2896() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "hasSelfReviveToken"))
    return self[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "hasSelfReviveToken")]]();

  return 0;
}

_id_DA31E13C27A6ACF4(_id_A4E8372932B8612C, _id_A5AB866673E5E99D, _id_7F437A5779C8787C, _id_1E736A37C3737585, _id_DB943473454F6EA6) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "forceGiveKillstreak"))
    return self[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "forceGiveKillstreak")]](_id_A4E8372932B8612C, _id_A5AB866673E5E99D, _id_7F437A5779C8787C, _id_1E736A37C3737585, _id_DB943473454F6EA6);

  return;
}

_id_88CAFEC24778C70C(_id_12E3586B64301806, _id_9BA4FCFEB48763BA, _id_0CD73FF319D57C07) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "waittill_confirm_or_cancel"))
    return self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "waittill_confirm_or_cancel")]](_id_12E3586B64301806, _id_9BA4FCFEB48763BA, _id_0CD73FF319D57C07);

  return undefined;
}

_id_5C8AD6E89A9F7B73(location) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "traceSelectedMapLocation"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "traceSelectedMapLocation")]](location);

  return undefined;
}

_id_25C4C34D6C3DD08A(_id_A4E8372932B8612C) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "forceUseKillstreak"))
    return self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "forceUseKillstreak")]](_id_A4E8372932B8612C);

  return undefined;
}

_id_CFB85293F9660751(weapon, maxammo) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getDefaultWeaponAmmo"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getDefaultWeaponAmmo")]](weapon, maxammo);

  return;
}

_id_6E3DB23952F2E451(pickupent, _id_DB943473454F6EA6) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "takeWeaponPickup"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "takeWeaponPickup")]](pickupent, _id_DB943473454F6EA6);
}

_id_EB96721D13C5F3DF(_id_9394537680F9C8A4, _id_A5AB866673E5E99D, _id_7F437A5779C8787C, _id_1E736A37C3737585, _id_DB943473454F6EA6) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "forceGiveSuper"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "forceGiveSuper")]](_id_9394537680F9C8A4, _id_A5AB866673E5E99D, _id_7F437A5779C8787C, _id_1E736A37C3737585, _id_DB943473454F6EA6);
}

_id_836C7D119E02D1D5() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "br_ammo_player_max_out"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "br_ammo_player_max_out")]]();
}

_id_C00F90A28C41FEBE(skipsplash) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "addRespawnToken"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "addRespawnToken")]](skipsplash);
}

_id_2D5A30D6FE54567B(skipsplash) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "addSelfReviveToken"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "addSelfReviveToken")]](skipsplash);
}

_id_F5E58B5375381386(_id_F7B6CC6C062A7A43, _id_F06B5C1AC51DF6A6, _id_69E685E96DBF1D48) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "showKillstreakSplash"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "showKillstreakSplash")]](_id_F7B6CC6C062A7A43, _id_F06B5C1AC51DF6A6, _id_69E685E96DBF1D48);
}

_id_0F87529D7AF4978B(streakname, source, _id_352D315FC8A744CE, _id_722764086BD2150D, _id_E01ECD2F1FF85E28, _id_546F4A2E8B131D3F) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "awardKillstreak"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "awardKillstreak")]](streakname, source, _id_352D315FC8A744CE, _id_722764086BD2150D, _id_E01ECD2F1FF85E28, _id_546F4A2E8B131D3F);
}

_id_9563F2D4E690856D(team, _id_8E9EF05D6E84968C) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](team, _id_8E9EF05D6E84968C);

  return [];
}

_id_690E9E142EBC1C69(_id_7E397F4CE66BFFD0, _id_7E39824CE66C0669) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "perkpackage_giveOverrideFieldUpgrades"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "perkpackage_giveOverrideFieldUpgrades")]](_id_7E397F4CE66BFFD0, _id_7E39824CE66C0669);
}

_id_5942F6CDBB6CB63B(perkname) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]](perkname);
}

_id_C4D8558FC1592CD6() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isJuggernaut"))
    return self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isJuggernaut")]]();
  else
    return 0;
}

_id_83E3B506365BAFC5() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBackpackInventoryEnabled"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBackpackInventoryEnabled")]]();

  return 0;
}

_id_EF240AA7C1052D13(lootid, pickup, _id_70E660487C2924EC) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "addItemToBackpack"))
    return self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "addItemToBackpack")]](lootid, pickup, _id_70E660487C2924EC);

  return 0;
}

_id_507B98884B41CC8E() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "getAvailableDMZBackpackIndex"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getAvailableDMZBackpackIndex")]]();

  return undefined;
}

_id_67386B14D0C7D1EE() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

  return undefined;
}

_id_E800498086E36C29(event, objweapon, _id_91185FF4A2E16A72, _id_4B5A99C16ABFDFB1, victim, _id_51BDAE03B05BC75E, _id_30E33D4E4669117F, _id_F459A13A227B8DE6, streakinfo, _id_827C276DA1CDCF23) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]](event, objweapon, _id_91185FF4A2E16A72, _id_4B5A99C16ABFDFB1, victim, _id_51BDAE03B05BC75E, _id_30E33D4E4669117F, _id_F459A13A227B8DE6, streakinfo, _id_827C276DA1CDCF23);

  return undefined;
}

_id_3D48DA36C7FD0FDB(_id_465AB95DD1230BD3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "calculatePurchaseXp"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "calculatePurchaseXp")]](_id_465AB95DD1230BD3);

  return undefined;
}

_id_A8A68668A0B2C9C4() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isAnyTutorialOrBotPracticeMatch"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isAnyTutorialOrBotPracticeMatch")]]();

  return 0;
}

_id_78A18C3B6DBFB0A5(amount, data) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "playerPlunderKioskPurchase"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "playerPlunderKioskPurchase")]](amount, data);
}

_id_9BC69C26770D9533(callback) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "registerOnLuiEventCallback"))
    level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "registerOnLuiEventCallback")]](callback);
}

_id_496BA4F72BA5E5D1(index) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isLoadoutIndexDefault"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isLoadoutIndexDefault")]](index);

  return 0;
}

_id_6A38B44A9A4E8761(_id_3FD595213E78030A) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getClassChoice"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getClassChoice")]](_id_3FD595213E78030A);

  return undefined;
}

_id_90CA6872B70E4C2E(player, _id_401C3A2E68AAB0FD) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dlog", "brAnalytics_inventory_snapshot"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("dlog", "brAnalytics_inventory_snapshot")]](player, _id_401C3A2E68AAB0FD);
}

_id_A4968A44B192F2ED(class, _id_1DCE12D4EAF02799) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "preloadAndQueueClass"))
    return self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "preloadAndQueueClass")]](class, _id_1DCE12D4EAF02799);

  return undefined;
}

_id_BE7AF2B74939C9B5(player, _id_A5AB866673E5E99D) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "br_giveSelectedClass"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "br_giveSelectedClass")]](player, _id_A5AB866673E5E99D);
}

_id_3CF2D6DDF853BDEE(player, _id_465AB95DD1230BD3, _id_13ECA9A3244E502F) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dlog", "brAnalytics_kiosk_purchaseLoadout"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("dlog", "brAnalytics_kiosk_purchaseLoadout")]](player, _id_465AB95DD1230BD3, _id_13ECA9A3244E502F);
}

_id_B71E2F7AFD69D580() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isEligibleForTeamRevive"))
    return self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isEligibleForTeamRevive")]]();

  return 0;
}

_id_F6C807A601F8A34D(player) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isRespawningFromToken"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isRespawningFromToken")]](player);

  return 0;
}

_id_3FCB060110170AC9(_id_EA847593E957F2B0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBrGametypeFuncDefined"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBrGametypeFuncDefined")]](_id_EA847593E957F2B0);

  return 0;
}

_id_8BD31D20349AA464(_id_4AC881E2A39322A5, _id_57D71760971F748F, _id_5806C4765695A2F4, _id_74AF5908127B6729) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "playerGulagAutoWin"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "playerGulagAutoWin")]]("", _id_4AC881E2A39322A5, _id_57D71760971F748F, _id_5806C4765695A2F4, _id_74AF5908127B6729);
}

_id_188F8C265A7EF6EA(spawn_origin, _id_1DA50610F94E1BFB) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "utilFlare_shootFlare"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "utilFlare_shootFlare")]](spawn_origin, _id_1DA50610F94E1BFB);
}

_id_9CB5F84F96E33914(point, _id_AE913F2DC0534B48, _id_498E4E279FB8ED85) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isValidPointInBounds"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isValidPointInBounds")]](point, _id_AE913F2DC0534B48, _id_498E4E279FB8ED85);

  return 0;
}

_id_FA5BAABE8489E675(origin, _id_8F6402AD8E91DA6A, _id_00836A83C2BCA261, _id_26189638809F7B88) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "initCirclePostStartToCircleIndex"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "initCirclePostStartToCircleIndex")]](origin, _id_8F6402AD8E91DA6A, _id_00836A83C2BCA261, _id_26189638809F7B88);
}

_id_9D18A22123E54D05(_id_3F44C731FDDDD082) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isFeatureEnabled"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isFeatureEnabled")]](_id_3F44C731FDDDD082);

  return 0;
}

_id_0BAF6855827FE902() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "spectate_init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "spectate_init")]]();
}

_id_20071A4B90F92B46(spawnpoint) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "playerPrestreamRespawnOrigin"))
    return self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "playerPrestreamRespawnOrigin")]](spawnpoint);

  return undefined;
}

_id_A39E8A33D7378F08(_id_89834994170E7989) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "gulagFadeToBlack"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "gulagFadeToBlack")]](_id_89834994170E7989);
}

_id_092E04B29006F91C() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "gulagStreamExit"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "gulagStreamExit")]]();
}

_id_2CEA92D21876A90A(origin, angles) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "gulagStreamExit"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "gulagStreamExit")]](origin, angles);
}

_id_01F5865AAB1FDAFD(ent) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "gulagStreamExit"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "gulagStreamExit")]](ent);
}

_id_B4E05F84B56C7BBF() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "playerWaittillStreamHintComplete"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "playerWaittillStreamHintComplete")]]();
}

_id_BA38E09A56256701() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "playerClearStreamHintOrigin"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "playerClearStreamHintOrigin")]]();
}

_id_4EC23357B146259C() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "resetPlayerMoveSpeedScale"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "resetPlayerMoveSpeedScale")]]();
}

_id_B17054C9879EA13B() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "gulagFadeFromBlack"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "gulagFadeFromBlack")]]();
}