/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_16ea1b94f0f381b3.gsc
*****************************************************/

#using scripts\engine\utility;
#namespace namespace_9d8e359c3b1041e5;

function scriptmodelplayanimdeltamotionsharedfunc(animname, notifystring, animstarttimeseconds, blendtype) {
  return utility::callsharedfunc(#"anim", #"scriptmodelplayanimdeltamotion", animname, notifystring, animstarttimeseconds, blendtype);
}

function activateperksharedfunc(perkname) {
  if(utility::issharedfuncdefined(#"perk", #"activatePerk")) {
    self[[utility::getsharedfunc(#"perk", #"activatePerk")]](perkname);
  }
}

function perkpackage_giveoverridefieldupgradessharedfunc(fieldupgrade1, fieldupgrade2) {
  if(utility::issharedfuncdefined(#"perk", #"perkpackage_giveoverridefieldupgrades")) {
    self[[utility::getsharedfunc(#"perk", #"perkpackage_giveoverridefieldupgrades")]](fieldupgrade1, fieldupgrade2);
  }
}

function giveperksharedfunc(perkname, parentperkname) {
  if(utility::issharedfuncdefined(#"perk", #"giveperk")) {
    self[[utility::getsharedfunc(#"perk", #"giveperk")]](perkname, parentperkname);
  }
}

function removeperksharedfunc(perkname) {
  if(utility::issharedfuncdefined(#"perk", #"removeperk")) {
    self[[utility::getsharedfunc(#"perk", #"removeperk")]](perkname);
  }
}

function showsplashsharedfunc(ref, optionalnumber, playerforplayercard, altdisplayindex, var_4dd30bf63f0b5e8b) {
  if(utility::issharedfuncdefined(#"hud", #"showsplash")) {
    self[[utility::getsharedfunc(#"hud", #"showsplash")]](ref, optionalnumber, playerforplayercard, altdisplayindex, var_4dd30bf63f0b5e8b);
  }
}

function showerrormessagesharedfunc(funcname, param) {
  if(utility::issharedfuncdefined(#"hud", #"showerrormessage")) {
    self[[utility::getsharedfunc(#"hud", #"showerrormessage")]](funcname, param);
  }
}

function isfeaturedisabledsharedfunc(featurename) {
  if(utility::issharedfuncdefined(#"game", #"isfeaturedisabled")) {
    return [[utility::getsharedfunc(#"game", #"isfeaturedisabled")]](featurename);
  }

  return 0;
}

function checkforactiveobjicon() {
  if(utility::issharedfuncdefined(#"game", #"checkforactiveobjicon")) {
    self[[utility::getsharedfunc(#"game", #"checkforactiveobjicon")]]();
  }
}

function deletequestobjicon() {
  if(utility::issharedfuncdefined(#"game", #"deletequestobjicon")) {
    self[[utility::getsharedfunc(#"game", #"deletequestobjicon")]]();
  }
}

function function_39104c6ed6c82786(fromorigin, fromangles) {
  if(utility::issharedfuncdefined(#"game", #"hash_da85e1cf6234f5f2")) {
    return [[utility::getsharedfunc(#"game", #"hash_da85e1cf6234f5f2")]](fromorigin, fromangles);
  }
}

function initspawnoptions_spawnfrompositionsharedfunc(fromorigin, fromangles) {
  if(utility::issharedfuncdefined(#"game", #"initSpawnOptions_SpawnFromPosition")) {
    return [[utility::getsharedfunc(#"game", #"initSpawnOptions_SpawnFromPosition")]](fromorigin, fromangles);
  }
}

function initspawnoptions_spawnfromentitysharedfunc(spawningentity) {
  if(utility::issharedfuncdefined(#"game", #"initSpawnOptions_SpawnFromEntity")) {
    return [[utility::getsharedfunc(#"game", #"initSpawnOptions_SpawnFromEntity")]](spawningentity);
  }
}

function spawnpickupfromlistsharedfunc(var_f1bc45484a606cd5, count, spawnoptions) {
  if(utility::issharedfuncdefined(#"game", #"spawnPickupFromList")) {
    [[utility::getsharedfunc(#"game", #"spawnPickupFromList")]](var_f1bc45484a606cd5, count, spawnoptions);
  }
}

function getscriptablefromlootidsharedfunc(lootid) {
  if(utility::issharedfuncdefined(#"game", #"getScriptableFromLootID")) {
    return [[utility::getsharedfunc(#"game", #"getScriptableFromLootID")]](lootid);
  }

  return undefined;
}

function spawnnewitemfromscriptablesharedfunc(scriptablename, itemorigin, itemangles, overridecount, critical) {
  spawnoptions = function_39104c6ed6c82786(itemorigin, itemangles);

  if(isDefined(spawnoptions)) {
    spawnoptions.critical = critical;
    return spawnitemfromscriptablesharedfunc(scriptablename, overridecount, spawnoptions);
  }

  return undefined;
}

function spawnitemfromscriptablesharedfunc(scriptablename, count, spawnoptions) {
  if(utility::issharedfuncdefined(#"game", #"spawnItemFromScriptable")) {
    return [[utility::getsharedfunc(#"game", #"spawnItemFromScriptable")]](scriptablename, count, spawnoptions);
  }
}

function function_a7918caa4f9819eb(scriptablename, iscustomweapon) {
  if(utility::issharedfuncdefined(#"game", #"hash_9a424766e665a6f7")) {
    return [[utility::getsharedfunc(#"game", #"hash_9a424766e665a6f7")]](scriptablename, iscustomweapon);
  }

  return 1;
}

function getitemdroporiginandanglessharedfunc(index, baseorigin, baseangles, ignoreent, var_8e48a889d5a11dee, optionaloverridedist, var_18608bd8660b3a19, var_11f401c17a8141c5) {
  if(utility::issharedfuncdefined(#"game", #"getitemdroporiginandangles")) {
    [[utility::getsharedfunc(#"game", #"getitemdroporiginandangles")]](index, baseorigin, baseangles, ignoreent, var_8e48a889d5a11dee, optionaloverridedist, var_18608bd8660b3a19, var_11f401c17a8141c5);
  }
}

function br_forcegivecustompickupitemsharedfunc(player, scriptablename, var_90916fc4b2724efd, countoverride, fromkiosk, droppurchased) {
  if(utility::issharedfuncdefined(#"game", #"br_forcegivecustompickupitem")) {
    return [[utility::getsharedfunc(#"game", #"br_forcegivecustompickupitem")]](player, scriptablename, var_90916fc4b2724efd, countoverride, fromkiosk, droppurchased);
  }
}

function branalytics_kiosk_purchaseitemsharedfunc(player, plunderspent, purchasetype, itemname) {
  if(utility::issharedfuncdefined(#"game", #"branalytics_kiosk_purchaseitem")) {
    return [[utility::getsharedfunc(#"game", #"branalytics_kiosk_purchaseitem")]](player, plunderspent, purchasetype, itemname);
  }
}

function iskiosksharedfunc(scriptablename) {
  if(utility::issharedfuncdefined(#"game", #"isKiosk")) {
    return [[utility::getsharedfunc(#"game", #"isKiosk")]](scriptablename);
  }
}

function cantakepickupsharedfunc(pickupent) {
  if(utility::issharedfuncdefined(#"game", #"cantakepickup")) {
    return [[utility::getsharedfunc(#"game", #"cantakepickup")]](pickupent);
  }
}

function branalytics_kiosk_menu_eventsharedfunc(player, menuevent, menueventparam) {
  if(utility::issharedfuncdefined(#"game", #"branalytics_kiosk_menu_event")) {
    [[utility::getsharedfunc(#"game", #"branalytics_kiosk_menu_event")]](player, menuevent, menueventparam);
  }
}

function createquestobjiconsharedfunc(iconref, state, var_e9c32dc17ce1bb57) {
  if(utility::issharedfuncdefined(#"game", #"createquestobjicon")) {
    self[[utility::getsharedfunc(#"game", #"createquestobjicon")]](iconref, state, var_e9c32dc17ce1bb57);
  }
}

function showquestobjicontoplayersharedfunc(player) {
  if(utility::issharedfuncdefined(#"game", #"showquestobjicontoplayer")) {
    self[[utility::getsharedfunc(#"game", #"showquestobjicontoplayer")]](player);
  }
}

function ispubliceventoftypeactivesharedfunc(eventtype) {
  if(utility::issharedfuncdefined(#"game", #"ispubliceventoftypeactive")) {
    return [[utility::getsharedfunc(#"game", #"ispubliceventoftypeactive")]](eventtype);
  }

  return 0;
}

function hidequestobjiconfromplayersharedfunc(player) {
  if(utility::issharedfuncdefined(#"game", #"hidequestobjiconfromplayer")) {
    self[[utility::getsharedfunc(#"game", #"hidequestobjiconfromplayer")]](player);
  }
}

function isbrpracticemodesharedfunc() {
  if(utility::issharedfuncdefined(#"game", #"isBrPracticeMode")) {
    return [[utility::getsharedfunc(#"game", #"isBrPracticeMode")]]();
  }

  return 0;
}

function respawntokendisabledsharedfunc() {
  if(utility::issharedfuncdefined(#"game", #"respawntokendisabled")) {
    return [[utility::getsharedfunc(#"game", #"respawntokendisabled")]]();
  }

  return 0;
}

function hasselfrevivetokensharedfunc() {
  if(utility::issharedfuncdefined(#"game", #"hasselfrevivetoken")) {
    return self[[utility::getsharedfunc(#"game", #"hasselfrevivetoken")]]();
  }

  return 0;
}

function forcegivekillstreaksharedfunc(killstreakref, dropcurrent, fromkiosk, droppurchased, var_6432f32bb6fece8b) {
  if(utility::issharedfuncdefined(#"game", #"forcegivekillstreak")) {
    return self[[utility::getsharedfunc(#"game", #"forcegivekillstreak")]](killstreakref, dropcurrent, fromkiosk, droppurchased, var_6432f32bb6fece8b);
  }
}

function traceselectedmaplocationsharedfunc(location) {
  if(utility::issharedfuncdefined(#"game", #"traceselectedmaplocation")) {
    return [[utility::getsharedfunc(#"game", #"traceselectedmaplocation")]](location);
  }

  return undefined;
}

function getdefaultweaponammosharedfunc(weapon, maxammo) {
  if(utility::issharedfuncdefined(#"game", #"getDefaultWeaponAmmo")) {
    return [[utility::getsharedfunc(#"game", #"getDefaultWeaponAmmo")]](weapon, maxammo);
  }
}

function isbackpackinventoryenabledsharedfunc() {
  if(utility::issharedfuncdefined(#"inventory", #"isbackpackinventoryenabled")) {
    return [[utility::getsharedfunc(#"inventory", #"isbackpackinventoryenabled")]]();
  }

  return 0;
}

function calculatepurchasexpsharedfunc(plunderspent) {
  if(utility::issharedfuncdefined(#"game", #"calculatepurchasexp")) {
    return [[utility::getsharedfunc(#"game", #"calculatepurchasexp")]](plunderspent);
  }

  return undefined;
}

function isanytutorialorbotpracticematchsharedfunc() {
  if(utility::issharedfuncdefined(#"game", #"isanytutorialorbotpracticematch")) {
    return [[utility::getsharedfunc(#"game", #"isanytutorialorbotpracticematch")]]();
  }

  return 0;
}

function registeronluieventcallbacksharedfunc(callback) {
  if(utility::issharedfuncdefined(#"game", #"registeronluieventcallback")) {
    level[[utility::getsharedfunc(#"game", #"registeronluieventcallback")]](callback);
  }
}

function isloadoutindexdefaultsharedfunc(index) {
  if(utility::issharedfuncdefined(#"game", #"isloadoutindexdefault")) {
    return [[utility::getsharedfunc(#"game", #"isloadoutindexdefault")]](index);
  }

  return 0;
}

function getclasschoicesharedfunc(menuindex) {
  if(utility::issharedfuncdefined(#"game", #"getclasschoice")) {
    return [[utility::getsharedfunc(#"game", #"getclasschoice")]](menuindex);
  }

  return undefined;
}

function utilflare_shootflaresharedfunc(spawn_origin, flaretype) {
  if(utility::issharedfuncdefined(#"game", #"utilflare_shootflare")) {
    level thread[[utility::getsharedfunc(#"game", #"utilflare_shootflare")]](spawn_origin, flaretype);
  }
}

function isvalidpointinboundssharedfunc(point, checkbadcircleareas, var_566819e204437d34) {
  if(utility::issharedfuncdefined(#"game", #"isvalidpointinbounds")) {
    return [[utility::getsharedfunc(#"game", #"isvalidpointinbounds")]](point, checkbadcircleareas, var_566819e204437d34);
  }

  return 0;
}

function initcirclepoststarttocircleindexsharedfunc(origin, startcircledelay, startcircleindex, startcircleclosetime) {
  if(utility::issharedfuncdefined(#"game", #"initcirclepoststarttocircleindex")) {
    [[utility::getsharedfunc(#"game", #"initcirclepoststarttocircleindex")]](origin, startcircledelay, startcircleindex, startcircleclosetime);
  }
}

function isfeatureenabledsharedfunc(featurename) {
  if(utility::issharedfuncdefined(#"game", #"isfeatureenabled")) {
    return [[utility::getsharedfunc(#"game", #"isfeatureenabled")]](featurename);
  }

  return 0;
}

function spectate_initsharedfunc() {
  if(utility::issharedfuncdefined(#"game", #"spectate_init")) {
    [[utility::getsharedfunc(#"game", #"spectate_init")]]();
  }
}

function function_57de0ca2e80536a1(v_origin) {
  if(utility::issharedfuncdefined(#"game", #"roundNumberDifficulty")) {
    return [[utility::getsharedfunc(#"game", #"roundNumberDifficulty")]](v_origin);
  }

  assertmsg("<dev string:x24>" + level.gametype + "<dev string:x47>");
}

function getteamdatasharedfunc(team, property) {
  if(utility::issharedfuncdefined(#"game", #"getteamdata")) {
    return [[utility::getsharedfunc(#"game", #"getteamdata")]](team, property);
  }

  return [];
}

function registerscoreinfosharedfunc(type, category, value) {
  return utility::callsharedfunc(#"game", #"registerscoreinfo", type, category, value);
}

function trysaylocalsoundsharedfunc(player, soundtype, delay, targetent, location, var_eeb6a639148e00e7) {
  return utility::callsharedfunc(#"game", #"trysaylocalsound", player, soundtype, delay, targetent, location, var_eeb6a639148e00e7);
}

function addrecentattackersharedfunc(attacker) {
  var_32dbca3143d9c4a5 = level.sharedfuncs[#"game"][#"addrecentattacker"];

  if(isDefined(var_32dbca3143d9c4a5)) {
    self[[var_32dbca3143d9c4a5]](attacker);
  }
}

function handlemovingplatformssharedfunc(data) {
  return utility::callsharedfunc(#"game", #"handlemovingplatforms", data);
}

function isteamreviveenabledsharedfunc() {
  return istrue(utility::callsharedfunc(#"game", #"isteamreviveenabled"));
}

function handlemovingplatformtouchsharedfunc(data) {
  if(utility::issharedfuncdefined(#"game", #"handleMovingPlatformTouch")) {
    [[utility::getsharedfunc(#"game", #"handleMovingPlatformTouch")]](data);
  }
}

function targetmarkergroup_onsharedfunc(markerwidgetname, showto, tomark, groupowner, friendlymarker, markonspawn, var_52abf1a1f858871c) {
  return utility::callsharedfunc(#"game", #"targetmarkergroup_on", markerwidgetname, showto, tomark, groupowner, friendlymarker, markonspawn, var_52abf1a1f858871c);
}

function targetmarkergroup_offsharedfunc(targetmarkergroupid) {
  return utility::callsharedfunc(#"game", #"targetmarkergroup_off", targetmarkergroupid);
}

function registersentientsharedfunc(threatbiasgroup, var_7abeff39c291fc41, islethal, var_29232a9774002e87, var_3b8ee7e3e8397398, var_d1d5db309b77a8bb) {
  return utility::callsharedfunc(#"game", #"registersentient", threatbiasgroup, var_7abeff39c291fc41, islethal, var_29232a9774002e87, var_3b8ee7e3e8397398, var_d1d5db309b77a8bb);
}

function unregistersentientsharedfunc(poolid, keyid) {
  return utility::callsharedfunc(#"game", #"unregistersentient", poolid, keyid);
}

function registerentforoobsharedfunc(ent, ref) {
  return utility::callsharedfunc(#"game", #"registerentforoob", ent, ref);
}

function clearoobsharedfunc(ent, fromdeath) {
  return utility::callsharedfunc(#"game", #"clearoob", ent, fromdeath);
}

function addspawnviewersharedfunc(entity) {
  return utility::callsharedfunc(#"game", #"addspawnviewer", entity);
}

function removespawnviewersharedfunc(entity) {
  return utility::callsharedfunc(#"game", #"removespawnviewer", entity);
}

function forcenetfieldhighlod_sharedfunc(set) {
  utility::callsharedfunc(#"game", #"forcenetfieldhighlod", set);
}

function ispointinoutofboundssharedfunc(pointtocheck, teamtocheck) {
  return istrue(utility::callsharedfunc(#"game", #"ispointinoutofbounds", pointtocheck, teamtocheck));
}

function shouldmodesetsquadssharedfunc() {
  return istrue(utility::callsharedfunc(#"game", #"shouldmodesetsquads"));
}

function ismagellanmodesharedfunc() {
  return istrue(utility::callsharedfunc(#"game", #"IsMagellanMode"));
}

function function_287accac73ec9c41(attacker, objweapon, inflictor, meansofdeath) {
  if(utility::issharedfuncdefined(#"game", #"non_player_add_ignore_damage_signature")) {
    return [[utility::getsharedfunc(#"game", #"non_player_add_ignore_damage_signature")]](attacker, objweapon, inflictor, meansofdeath);
  }

  return undefined;
}

function function_cc18ed453e5ccdbc(id) {
  if(utility::issharedfuncdefined(#"game", #"non_player_remove_ignore_damage_signature")) {
    [[utility::getsharedfunc(#"game", #"non_player_remove_ignore_damage_signature")]](id);
  }
}

function function_4e560ec0be671ce3(duration) {
  return utility::callsharedfunc(#"hostmigration", #"waitLongDurationWithPause", duration);
}

function waittill_notify_or_timeout_hostmigration_pause(msg, duration) {
  return utility::callsharedfunc(#"hostmigration", #"waittillNotifyOrTimeoutPause", msg, duration);
}

function magicbulletsharedfunc(objweapon, start, end, owner, event_ent) {
  return utility::callsharedfunc(#"weapons", #"magicbullet", objweapon, start, end, owner, event_ent);
}

function launchgrenadesharedfunc(weaponname, origin, velocity, var_f4f3f0356fef8102, notthrown, var_93e691e8536b5f6d, tickpercentoverride) {
  if(utility::issharedfuncdefined(#"weapons", #"_launchgrenade")) {
    return [[utility::getsharedfunc(#"weapons", #"_launchgrenade")]](weaponname, origin, velocity, var_f4f3f0356fef8102, notthrown, var_93e691e8536b5f6d, tickpercentoverride);
  }

  return undefined;
}

function setmissileminimapvisiblesharedfunc(set) {
  return utility::callsharedfunc(#"weapons", #"setmissileminimapvisible", set);
}

function function_bc3d11edade5004(set) {
  return utility::callsharedfunc(#"weapons", #"hash_a02d1dbbb057f8b0", set);
}

function function_2774ff2792a00056(set) {
  return utility::callsharedfunc(#"weapons", #"hash_b36b4b3fd3a15594", set);
}

function function_fe287412c2a2bb55(anchor) {
  return utility::callsharedfunc(#"weapons", #"hash_3db33cbf4379d27d", anchor);
}

function setmissileimpactminimapiconsharedfunc(iconname) {
  return utility::callsharedfunc(#"weapons", #"setMissileImpactMinimapIcon", iconname);
}

function saveweaponstatessharedfunc() {
  return utility::callsharedfunc(#"weapons", #"saveweaponstates");
}

function switchtoweaponsharedfunc(weapon) {
  return utility::callsharedfunc(#"weapons", #"switchtoweapon", weapon);
}

function switchtoweaponimmediatesharedfunc(weapon) {
  return utility::callsharedfunc(#"weapons", #"switchtoweaponimmediate", weapon);
}

function takeweaponsharedfunc(weapon) {
  return utility::callsharedfunc(#"weapons", #"takeweapon", weapon);
}

function monitordisownedgrenadesharedfunc(player, grenade) {
  if(utility::issharedfuncdefined(#"weapons", #"monitordisownedgrenade")) {
    [[utility::getsharedfunc(#"weapons", #"monitordisownedgrenade")]](player, grenade);
  }
}

function monitordisownedequipmentsharedfunc(player, equipment, var_6637462580611fe3) {
  if(utility::issharedfuncdefined(#"weapons", #"monitordisownedequipment")) {
    [[utility::getsharedfunc(#"weapons", #"monitordisownedequipment")]](player, equipment, var_6637462580611fe3);
  }
}

function minedamagemonitorsharedfunc(hitsmax) {
  if(utility::issharedfuncdefined(#"weapons", #"minedamagemonitor")) {
    [[utility::getsharedfunc(#"weapons", #"minedamagemonitor")]](hitsmax);
  }
}

function onequipmentplantedsharedfunc(newequipment, equipmentref, deletefunc, isagentowned) {
  if(utility::issharedfuncdefined(#"weapons", #"onequipmentplanted")) {
    [[utility::getsharedfunc(#"weapons", #"onequipmentplanted")]](newequipment, equipmentref, deletefunc, isagentowned);
  }
}

function outlineequipmentforownersharedfunc(equipment) {
  if(utility::issharedfuncdefined(#"weapons", #"outlineequipmentforowner")) {
    [[utility::getsharedfunc(#"weapons", #"outlineequipmentforowner")]](equipment);
  }
}

function makeexplosiveunusuabletagsharedfunc() {
  if(utility::issharedfuncdefined(#"weapons", #"makeexplosiveunusuabletag")) {
    [[utility::getsharedfunc(#"weapons", #"makeexplosiveunusuabletag")]]();
  }
}

function explosivetriggersharedfunc(target, graceperiod, notifystr) {
  if(utility::issharedfuncdefined(#"weapons", #"explosivetrigger")) {
    [[utility::getsharedfunc(#"weapons", #"explosivetrigger")]](target, graceperiod, notifystr);
  }
}

function removeequipsharedfunc(equip) {
  if(utility::issharedfuncdefined(#"weapons", #"removeequip")) {
    [[utility::getsharedfunc(#"weapons", #"removeequip")]](equip);
  }
}

function addlockedonsharedfunc(entity, attacker) {
  if(utility::issharedfuncdefined(#"weapons", #"addlockedon")) {
    [[utility::getsharedfunc(#"weapons", #"addlockedon")]](entity, attacker);
  }
}

function removelockedonsharedfunc(entity, attacker) {
  if(utility::issharedfuncdefined(#"weapons", #"removelockedon")) {
    [[utility::getsharedfunc(#"weapons", #"removelockedon")]](entity, attacker);
  }
}

function ismissilelauncherlockonallowedsharedfunc() {
  if(utility::issharedfuncdefined(#"weapons", #"isMissileLauncherLockOnAllowed")) {
    return [[utility::getsharedfunc(#"weapons", #"isMissileLauncherLockOnAllowed")]]();
  }
}

function lockonlaunchergettargetarraysharedfunc(addcharacters) {
  if(utility::issharedfuncdefined(#"weapons", #"lockOnLauncherGetTargetArray")) {
    return [[utility::getsharedfunc(#"weapons", #"lockOnLauncherGetTargetArray")]](addcharacters);
  }
}

function remoteinteractsetupsharedfunc(var_bc3be370eac48043, allowdefuse, allowhack) {
  if(utility::issharedfuncdefined(#"equipment", #"remoteinteractsetup")) {
    [[utility::getsharedfunc(#"equipment", #"remoteinteractsetup")]](var_bc3be370eac48043, allowdefuse, allowhack);
  }
}

function getmineignorelistsharedfunc() {
  if(utility::issharedfuncdefined(#"equipment", #"getMineIgnoreList")) {
    return [[utility::getsharedfunc(#"equipment", #"getMineIgnoreList")]]();
  }

  return undefined;
}

function watchflightcollisionsharedfunc() {
  if(utility::issharedfuncdefined(#"equipment", #"watchFlightCollision")) {
    [[utility::getsharedfunc(#"equipment", #"watchFlightCollision")]]();
  }
}

function setheadiconfactionimagesharedfunc(showtoallfactions, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_c6bd58f878e4420a, ownerinvisible, overrideorigin, showonminimap, image, iconsizes) {
  if(utility::issharedfuncdefined(#"hud", #"setHeadIconFactionImage")) {
    return [[utility::getsharedfunc(#"hud", #"setHeadIconFactionImage")]](showtoallfactions, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_c6bd58f878e4420a, ownerinvisible, overrideorigin, showonminimap, image, iconsizes);
  }

  return undefined;
}

function setheadicondeleteiconsharedfunc(icon) {
  if(utility::issharedfuncdefined(#"hud", #"setHeadIconDeleteIcon")) {
    [[utility::getsharedfunc(#"hud", #"setHeadIconDeleteIcon")]](icon);
  }
}

function function_b739495605e4ba8a(b_hide) {
  if(utility::issharedfuncdefined(#"hud", #"hash_6f07e8aa7e74982")) {
    utility::callsharedfunc(#"hud", #"hash_6f07e8aa7e74982", b_hide);
  }
}

function function_5fd1256ae6f663cd(position, duration, scalemax, scalemid, scalemin, radiusmax, radiusmid, radiusmin, ignoreclients, playrumble, var_ca144b5ca4279c98) {
  return utility::callsharedfunc(#"shellshock", #"artillery_earthquake", position, duration, scalemax, scalemid, scalemin, radiusmax, radiusmid, radiusmin, ignoreclients, playrumble, var_ca144b5ca4279c98);
}

function givesuperpointssharedfunc(points, scoreevent, bypassdisable, pointsmultiplier) {
  if(utility::issharedfuncdefined(#"supers", #"givesuperpoints")) {
    self[[utility::getsharedfunc(#"supers", #"givesuperpoints")]](points, scoreevent, bypassdisable, pointsmultiplier);
  }
}

function getsuperpointsneededsharedfunc() {
  if(utility::issharedfuncdefined(#"supers", #"getsuperpointsneeded")) {
    self[[utility::getsharedfunc(#"supers", #"getsuperpointsneeded")]]();
  }
}

function givesupersharedfunc(superref, savesuperpoints, immediate, blueprintindex) {
  if(utility::issharedfuncdefined(#"supers", #"givesuper")) {
    self[[utility::getsharedfunc(#"supers", #"givesuper")]](superref, savesuperpoints, immediate, blueprintindex);
  }
}

function getsuperbundlefromoffhandweaponnamesharedfunc(weaponname) {
  if(utility::issharedfuncdefined(#"supers", #"getSuperBundleFromOffhandWeaponName")) {
    return [[utility::getsharedfunc(#"supers", #"getSuperBundleFromOffhandWeaponName")]](weaponname);
  }

  return undefined;
}

function getsuperweaponsharedfunc(superref) {
  if(utility::issharedfuncdefined(#"supers", #"getSuperWeapon")) {
    return [[utility::getsharedfunc(#"supers", #"getSuperWeapon")]](superref);
  }

  return undefined;
}

function haskillstreaksharedfunc(killstreakref) {
  if(utility::issharedfuncdefined(#"player", #"haskillstreak")) {
    return self[[utility::getsharedfunc(#"player", #"haskillstreak")]](killstreakref);
  }

  return 0;
}

function issuperinusesharedfunc() {
  if(utility::issharedfuncdefined(#"player", #"issuperinuse")) {
    return self[[utility::getsharedfunc(#"player", #"issuperinuse")]]();
  }

  return 0;
}

function getcurrentsuperrefsharedfunc() {
  if(utility::issharedfuncdefined(#"player", #"getcurrentsuperref")) {
    return self[[utility::getsharedfunc(#"player", #"getcurrentsuperref")]]();
  }
}

function forcegivesupersharedfunc(targetsupername, dropcurrent, fromkiosk, droppurchased, var_6432f32bb6fece8b) {
  if(utility::issharedfuncdefined(#"player", #"forcegivesuper")) {
    self[[utility::getsharedfunc(#"player", #"forcegivesuper")]](targetsupername, dropcurrent, fromkiosk, droppurchased, var_6432f32bb6fece8b);
  }
}

function function_403389469efa28fe() {
  if(utility::issharedfuncdefined(#"player", #"br_ammo_player_max_out")) {
    self[[utility::getsharedfunc(#"player", #"br_ammo_player_max_out")]]();
  }
}

function addrespawntokensharedfunc(skipsplash) {
  if(utility::issharedfuncdefined(#"player", #"addrespawntoken")) {
    self[[utility::getsharedfunc(#"player", #"addrespawntoken")]](skipsplash);
  }
}

function addselfrevivetokensharedfunc(skipsplash) {
  if(utility::issharedfuncdefined(#"player", #"addselfrevivetoken")) {
    self[[utility::getsharedfunc(#"player", #"addselfrevivetoken")]](skipsplash);
  }
}

function updatehitmarker_sharedfunc(markertype, killingblow, headshot, nonplayer, icontype, targetentnum, armorPlateCount, var_795e8a31194a39ac) {
  return utility::callsharedfunc(#"hitmarker", #"updatehitmarker_sharedfunc", markertype, killingblow, headshot, nonplayer, icontype, targetentnum, armorPlateCount, var_795e8a31194a39ac);
}

function updateDamageFeedback_SharedFunc(icontype) {
  return utility::callsharedfunc(#"hitmarker", #"updateDamageFeedback_SharedFunc", icontype);
}

function isjuggernautsharedfunc() {
  if(utility::issharedfuncdefined(#"player", #"isjuggernaut")) {
    return self[[utility::getsharedfunc(#"player", #"isjuggernaut")]]();
  }

  return 0;
}

function additemtobackpacksharedfunc(lootid, pickup, dontdropleftover, param4) {
  if(utility::issharedfuncdefined(#"player", #"addItemToBackpack")) {
    return self[[utility::getsharedfunc(#"player", #"addItemToBackpack")]](lootid, pickup, dontdropleftover, param4);
  }

  return 0;
}

function getavailabledmzbackpackindexsharedfunc() {
  if(utility::issharedfuncdefined(#"player", #"getAvailableDMZBackpackIndex")) {
    return [[utility::getsharedfunc(#"player", #"getAvailableDMZBackpackIndex")]]();
  }

  return undefined;
}

function didextractwithweaponcasesharedfunc(player) {
  if(utility::issharedfuncdefined(#"dmz", #"didExtractWithWeaponCase")) {
    return [[utility::getsharedfunc(#"dmz", #"didExtractWithWeaponCase")]](player);
  }

  return 0;
}

function doscoreeventsharedfunc(event, objweapon, pointsoverride, xpoverride, victim, var_ae2a12845c1ef7c1, dontwait, cankillchain, streakinfo, var_dd3dc966adfb966) {
  if(utility::issharedfuncdefined(#"player", #"doScoreEvent")) {
    return [[utility::getsharedfunc(#"player", #"doScoreEvent")]](event, objweapon, pointsoverride, xpoverride, victim, var_ae2a12845c1ef7c1, dontwait, cankillchain, streakinfo, var_dd3dc966adfb966);
  }

  return undefined;
}

function preloadandqueueclasssharedfunc(class, highpriorityload) {
  if(utility::issharedfuncdefined(#"player", #"preloadandqueueclass")) {
    return self[[utility::getsharedfunc(#"player", #"preloadandqueueclass")]](class, highpriorityload);
  }

  return undefined;
}

function savefavoriteloadoutsharedfunc() {
  if(utility::issharedfuncdefined(#"player", #"saveFavoriteLoadout")) {
    return self[[utility::getsharedfunc(#"player", #"saveFavoriteLoadout")]]();
  }

  return undefined;
}

function br_giveselectedclasssharedfunc(player, dropcurrent) {
  if(utility::issharedfuncdefined(#"player", #"br_giveselectedclass")) {
    [[utility::getsharedfunc(#"player", #"br_giveselectedclass")]](player, dropcurrent);
  }
}

function iseligibleforteamrevivesharedfunc() {
  if(utility::issharedfuncdefined(#"player", #"iseligibleforteamrevive")) {
    return self[[utility::getsharedfunc(#"player", #"iseligibleforteamrevive")]]();
  }

  return 0;
}

function isrespawningfromtokensharedfunc(player) {
  if(utility::issharedfuncdefined(#"player", #"isrespawningfromtoken")) {
    return [[utility::getsharedfunc(#"player", #"isrespawningfromtoken")]](player);
  }

  return 0;
}

function playergulagautowinsharedfunc(sponsor, tokenused, var_350c06308cd3d7e3, var_ec22479f7c93f2e0) {
  if(utility::issharedfuncdefined(#"gulag", #"playergulagautowin")) {
    self[[utility::getsharedfunc(#"gulag", #"playergulagautowin")]]("", sponsor, tokenused, var_350c06308cd3d7e3, var_ec22479f7c93f2e0);
  }
}

function playerprestreamrespawnoriginsharedfunc(spawnpoint) {
  if(utility::issharedfuncdefined(#"player", #"playerprestreamrespawnorigin")) {
    return self[[utility::getsharedfunc(#"player", #"playerprestreamrespawnorigin")]](spawnpoint);
  }

  return undefined;
}

function gulagfadetoblacksharedfunc(fadespectators) {
  if(utility::issharedfuncdefined(#"gulag", #"gulagfadetoblack")) {
    self[[utility::getsharedfunc(#"gulag", #"gulagfadetoblack")]](fadespectators);
  }
}

function gulagstreamexitsharedfunc() {
  if(utility::issharedfuncdefined(#"gulag", #"gulagstreamexit")) {
    self[[utility::getsharedfunc(#"gulag", #"gulagstreamexit")]]();
  }
}

function playerteleportgulagsharedfunc(origin, angles) {
  if(utility::issharedfuncdefined(#"gulag", #"playerteleportgulag")) {
    self[[utility::getsharedfunc(#"gulag", #"playerteleportgulag")]](origin, angles);
  }
}

function playercleanupentondisconnectsharedfunc(ent) {
  if(utility::issharedfuncdefined(#"player", #"playercleanupentondisconnect")) {
    self[[utility::getsharedfunc(#"player", #"playercleanupentondisconnect")]](ent);
  }
}

function playerwaittillstreamhintcompletesharedfunc() {
  if(utility::issharedfuncdefined(#"player", #"playerwaittillstreamhintcomplete")) {
    self[[utility::getsharedfunc(#"player", #"playerwaittillstreamhintcomplete")]]();
  }
}

function playerclearstreamhintoriginsharedfunc() {
  if(utility::issharedfuncdefined(#"player", #"playerclearstreamhintorigin")) {
    self[[utility::getsharedfunc(#"player", #"playerclearstreamhintorigin")]]();
  }
}

function resetplayermovespeedscalesharedfunc() {
  if(utility::issharedfuncdefined(#"player", #"resetplayermovespeedscale")) {
    self[[utility::getsharedfunc(#"player", #"resetplayermovespeedscale")]]();
  }
}

function gulagfadefromblacksharedfunc() {
  if(utility::issharedfuncdefined(#"gulag", #"gulagfadefromblack")) {
    self[[utility::getsharedfunc(#"gulag", #"gulagfadefromblack")]]();
  }
}

function isplayeringulagsharedfunc() {
  var_32dbca3143d9c4a5 = level.sharedfuncs[#"gulag"][#"isplayeringulag"];

  if(var_32dbca3143d9c4a5 && self[[var_32dbca3143d9c4a5]]()) {
    return true;
  }

  return false;
}

function isplayerinorgoingtogulagsharedfunc() {
  if(utility::issharedfuncdefined(#"gulag", #"isplayerinorgoingtogulag")) {
    return self[[utility::getsharedfunc(#"gulag", #"isplayerinorgoingtogulag")]]();
  }

  return 0;
}

function isplayerwaitingresurgencerespawnsharedfunc() {
  if(utility::issharedfuncdefined(#"player", #"isPlayerWaitingResurgenceRespawn")) {
    return self[[utility::getsharedfunc(#"player", #"isPlayerWaitingResurgenceRespawn")]]();
  }

  return 0;
}

function playerplunderkioskpurchasesharedfunc(amount, data) {
  if(utility::issharedfuncdefined(#"player", #"playerplunderkioskpurchase")) {
    self[[utility::getsharedfunc(#"player", #"playerplunderkioskpurchase")]](amount, data);
  }
}

function setscriptmoverkillcamsharedfunc(killstring, offsetup, offsetback) {
  if(utility::issharedfuncdefined(#"player", #"setscriptmoverkillcam")) {
    utility::callsharedfunc(#"player", #"setscriptmoverkillcam", killstring, offsetup, offsetback);
  }
}

function fadetoblackforplayersharedfunc(player, fadetoblack, fadetime) {
  return utility::callsharedfunc(#"player", #"fadetoblackforplayer", player, fadetoblack, fadetime);
}

function shellshocksharedfunc(name, category, duration, animationresponse, interruptdelayms) {
  return utility::callsharedfunc(#"player", #"shellshock", name, category, duration, animationresponse, interruptdelayms);
}

function stopshellshocksharedfunc(fromdeath) {
  return utility::callsharedfunc(#"player", #"stopshellshock", fromdeath);
}

function setdof_cruisefirstsharedfunc() {
  return utility::callsharedfunc(#"player", #"setdof_cruisefirst");
}

function freezecontrolssharedfunc(frozen, force, debug) {
  return utility::callsharedfunc(#"player", #"freezecontrols", frozen, force, debug);
}

function getplayersuperfactionsharedfunc(player) {
  return utility::callsharedfunc(#"player", #"getSuperFaction", player);
}

function isalivesharedfunc() {
  return utility::callsharedfunc(#"player", #"playerisalive");
}

function getplayersinradiussharedfunc(origin, radius, desiredteam, excludeent) {
  return utility::callsharedfunc(#"player", #"getplayersinradius", origin, radius, desiredteam, excludeent);
}

function freezelookcontrolssharedfunc(frozen, force) {
  return utility::callsharedfunc(#"player", #"freezelookcontrols", frozen, force);
}

function enableplayerusesharedfunc(player) {
  return utility::callsharedfunc(#"player", #"enableplayeruse", player);
}

function disableplayerusesharedfunc(player) {
  return utility::callsharedfunc(#"player", #"disableplayeruse", player);
}

function setusingremotesharedfunc(remotename) {
  if(utility::issharedfuncdefined(#"player", #"setusingremote")) {
    [[utility::getsharedfunc(#"player", #"setusingremote")]](remotename);
  }
}

function clearusingremotesharedfunc(bypassweaponswitch) {
  if(utility::issharedfuncdefined(#"player", #"clearusingremote")) {
    [[utility::getsharedfunc(#"player", #"clearusingremote")]](bypassweaponswitch);
  }
}

function branalytics_inventory_snapshotsharedfunc(player, reason) {
  if(utility::issharedfuncdefined(#"dlog", #"branalytics_inventory_snapshot")) {
    [[utility::getsharedfunc(#"dlog", #"branalytics_inventory_snapshot")]](player, reason);
  }
}

function branalytics_kiosk_purchaseloadoutsharedfunc(player, plunderspent, loadoutdata) {
  if(utility::issharedfuncdefined(#"dlog", #"branalytics_kiosk_purchaseloadout")) {
    [[utility::getsharedfunc(#"dlog", #"branalytics_kiosk_purchaseloadout")]](player, plunderspent, loadoutdata);
  }
}

function waittill_confirm_or_cancelsharedfunc(confirmstring, cancelstring, endstring) {
  if(utility::issharedfuncdefined(#"killstreak", #"waittill_confirm_or_cancel")) {
    return self[[utility::getsharedfunc(#"killstreak", #"waittill_confirm_or_cancel")]](confirmstring, cancelstring, endstring);
  }

  return undefined;
}

function killstreak_registerminimapinfosharedfunc(bundle, killstreak, enableping, var_13ecbe20ea1c02d7) {
  return utility::callsharedfunc(#"killstreak", #"killstreak_registerMinimapInfo", bundle, killstreak, enableping, var_13ecbe20ea1c02d7);
}

function killstreak_setupvehicledamagefunctionalitysharedfunc(streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback) {
  return utility::callsharedfunc(#"killstreak", #"killstreak_setupVehicleDamageFunctionality", streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback);
}

function getmodifiedantikillstreakdamagesharedfunc(attacker, objweapon, meansofdeath, amount, maxhealth, divisorlrg, divisormed, divisorlow, divisormelee, divisortick, explodeoverride) {
  return utility::callsharedfunc(#"killstreak", #"getmodifiedantikillstreakdamage", attacker, objweapon, meansofdeath, amount, maxhealth, divisorlrg, divisormed, divisorlow, divisormelee, divisortick, explodeoverride);
}

function killstreak_updatedamagestatesharedfunc(currenthealth) {
  return utility::callsharedfunc(#"killstreak", #"killstreak_updateDamageState", currenthealth);
}

function function_99585ce0ed7d5df7(streakinfo, location) {
  return utility::callsharedfunc(#"killstreak", #"hash_183e3c892b7ef047", streakinfo, location);
}

function streakdeploy_doweaponfireddeploysharedfunc(streakinfo, weaponobj, firednotify, weapongivencallback, weaponswitchendedcallback, weaponfiredcallback, weaponcleanupcallback, weapontakencallback) {
  return utility::callsharedfunc(#"killstreak", #"streakdeploy_doweaponfireddeploy", streakinfo, weaponobj, firednotify, weapongivencallback, weaponswitchendedcallback, weaponfiredcallback, weaponcleanupcallback, weapontakencallback);
}

function playerkillstreakgetownerlookatignoreentssharedfunc() {
  if(utility::issharedfuncdefined(#"killstreak", #"playerkillstreakgetownerlookatignoreents")) {
    return utility::callsharedfunc(#"killstreak", #"playerkillstreakgetownerlookatignoreents");
  }

  return undefined;
}

function killstreak_dangernotifyplayersinrangesharedfunc(owner, ownerteam, range, streakname, location, overrideheight) {
  return utility::callsharedfunc(#"killstreak", #"killstreak_dangernotifyplayersinrange", owner, ownerteam, range, streakname, location, overrideheight);
}

function registerkillstreaksharedfunc(streakname, triggeredfunc, availablefunc, directusefunc, cleanupfunc) {
  return utility::callsharedfunc(#"killstreak", #"registerkillstreak", streakname, triggeredfunc, availablefunc, directusefunc, cleanupfunc);
}

function registerkillstreakdamagedealingweaponsharedfunc(streakname, var_bf295ddc16ebf8a0, damagesize, isplayerweapon) {
  return utility::callsharedfunc(#"killstreak", #"registerKillstreakDamageDealingWeapon", streakname, var_bf295ddc16ebf8a0, damagesize, isplayerweapon);
}

function registerkillstreakstowableweaponsharedfunc(streakname, weaponname, getweaponnamecallback, genericblueprintweaponkey, var_1a104ca5d22453a3, var_6e414cc6090725b6, var_140b97aca7f94974, weaponswitchendedcallback, var_20404e66691c7ed8) {
  return utility::callsharedfunc(#"killstreak", #"registerKillstreakStowableWeapon", streakname, weaponname, getweaponnamecallback, genericblueprintweaponkey, var_1a104ca5d22453a3, var_6e414cc6090725b6, var_140b97aca7f94974, weaponswitchendedcallback, var_20404e66691c7ed8);
}

function registervisibilityomnvarforkillstreaksharedfunc(streakname, omnvarid, omnvarvalue) {
  return utility::callsharedfunc(#"killstreak", #"registervisibilityomnvarforkillstreak", streakname, omnvarid, omnvarvalue);
}

function createstreakinfosharedfunc(streakname, owner) {
  return utility::callsharedfunc(#"killstreak", #"createstreakinfo", streakname, owner);
}

function streakdeploy_doweapontabletdeploysharedfunc(streakinfo, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, var_199122e4d3f907ba, var_572ea452a1bc65ed, var_35a34784f1c6d395, var_9e428c3b74527aba, var_75defa1f64eb375a, var_37ae78e0de4a6e53) {
  return utility::callsharedfunc(#"killstreak", #"streakdeploy_doweapontabletdeploy", streakinfo, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, var_199122e4d3f907ba, var_572ea452a1bc65ed, var_35a34784f1c6d395, var_9e428c3b74527aba, var_75defa1f64eb375a, var_37ae78e0de4a6e53);
}

function getkillstreakairstrikeheightentsharedfunc() {
  return utility::callsharedfunc(#"killstreak", #"getkillstreakairstrikeheightent");
}

function playkillstreaktacomdialogsharedfunc(streakinfo, legacydialog, dialog, bypasscooldown, delaytime, charactersuffix) {
  return utility::callsharedfunc(#"killstreak", #"playKillstreakTacomDialog", streakinfo, legacydialog, dialog, bypasscooldown, delaytime, charactersuffix);
}

function playkillstreakteamleaderdialogsharedfunc(streakinfo, legacydialog, dialog) {
  return utility::callsharedfunc(#"killstreak", #"playKillstreakTeamLeaderDialog", streakinfo, legacydialog, dialog);
}

function forceusekillstreaksharedfunc(killstreakref) {
  if(utility::issharedfuncdefined(#"killstreak", #"forceusekillstreak")) {
    return self[[utility::getsharedfunc(#"killstreak", #"forceusekillstreak")]](killstreakref);
  }

  return undefined;
}

function showkillstreaksplashsharedfunc(splashref, streakval, fromcarepackage) {
  if(utility::issharedfuncdefined(#"airdrop", #"showkillstreaksplash")) {
    self thread[[utility::getsharedfunc(#"airdrop", #"showkillstreaksplash")]](splashref, streakval, fromcarepackage);
  }
}

function awardkillstreaksharedfunc(streakname, source, overridelifeid, var_469a3c9c3145a68, overrideowner, var_f9c6f25b7483dfe6, blueprintindex) {
  if(utility::issharedfuncdefined(#"killstreak", #"awardkillstreak")) {
    self[[utility::getsharedfunc(#"killstreak", #"awardkillstreak")]](streakname, source, overridelifeid, var_469a3c9c3145a68, overrideowner, var_f9c6f25b7483dfe6, blueprintindex);
  }
}

function setvisibiilityomnvarforkillstreaksharedfunc(streakname, omnvarstate) {
  return utility::callsharedfunc(#"killstreak", #"setVisibiilityOmnvarForKillstreak", streakname, omnvarstate);
}

function restorekillstreakplayeranglessharedfunc(player) {
  return utility::callsharedfunc(#"killstreak", #"restorekillstreakplayerangles", player);
}

function recordkillstreakendstatssharedfunc(streakinfo) {
  return utility::callsharedfunc(#"killstreak", #"recordkillstreakendstats", streakinfo);
}

function killstreak_setmainvisionsharedfunc(visionsetname) {
  return utility::callsharedfunc(#"killstreak", #"killstreak_setMainVision", visionsetname);
}

function killstreak_setsubvisionsharedfunc(visionsetinfo) {
  return utility::callsharedfunc(#"killstreak", #"killstreak_setSubVision", visionsetinfo);
}

function streakdeploy_doweaponswitchdeploysharedfunc(streakinfo, weaponobj, keepweapon, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, var_3a21d446a2f14d2c) {
  return utility::callsharedfunc(#"killstreak", #"streakdeploy_doweaponswitchdeploy", streakinfo, weaponobj, keepweapon, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, var_3a21d446a2f14d2c);
}

function killstreak_switchbacklastweaponsharedfunc(deployweapon, immediateswitch, optionaltimedelay) {
  return utility::callsharedfunc(#"killstreak", #"killstreak_switchBackLastWeapon", deployweapon, immediateswitch, optionaltimedelay);
}

function getridofkillstreakdeployweaponsharedfunc(weaponobj) {
  return utility::callsharedfunc(#"killstreak", #"getridofkillstreakdeployweapon", weaponobj);
}

function manualturret_disablefiresharedfunc(user, disabletime, enableendons) {
  return utility::callsharedfunc(#"killstreak", #"manualturret_disablefire", user, disabletime, enableendons);
}

function manualturret_clearplacementinstructionssharedfunc(clearaction) {
  return utility::callsharedfunc(#"killstreak", #"manualturret_clearplacementinstructions", clearaction);
}

function registerkillstreakweaponfiresharedfunc(streakinfo, weaponname) {
  if(utility::issharedfuncdefined(#"killstreak", #"registerKillstreakWeaponFire")) {
    self[[utility::getsharedfunc(#"killstreak", #"registerKillstreakWeaponFire")]](streakinfo, weaponname);
  }
}

function function_19145ff013934a47(streakname) {
  return utility::callsharedfunc(#"killstreak", #"hash_ae9fad232ee97408", streakname);
}

function vehicle_damage_clearvisualssharedfunc(data, changed, fromdeath) {
  return utility::callsharedfunc(#"vehicle", #"vehicle_damage_clearvisuals", data, changed, fromdeath);
}

function vehicleminesgetleveldataforminesharedfunc(equipref, create) {
  if(utility::issharedfuncdefined(#"vehicle", #"vehicleMinesGetLevelDataForMine")) {
    return [[utility::getsharedfunc(#"vehicle", #"vehicleMinesGetLevelDataForMine")]](equipref, create);
  }

  return undefined;
}

function vehiclefindsafeexitpossharedfunc(guy) {
  return utility::callsharedfunc(#"vehicle", #"vehicleFindSafeExitPos", guy);
}

function registerspawnsharedfunc(entcount, deletefunc) {
  if(utility::issharedfuncdefined(#"entity", #"registerspawn")) {
    [[utility::getsharedfunc(#"entity", #"registerspawn")]](entcount, deletefunc);
  }
}

function deregisterspawnsharedfunc() {
  if(utility::issharedfuncdefined(#"entity", #"deregisterspawn")) {
    [[utility::getsharedfunc(#"entity", #"deregisterspawn")]]();
  }
}

function removespawninfluencersharedfunc(handle) {
  if(utility::issharedfuncdefined(#"spawn", #"removeSpawnInfluencer")) {
    [[utility::getsharedfunc(#"spawn", #"removeSpawnInfluencer")]](handle);
  }
}

function addspawninfluencersharedfunc(influencerkey, pos, friendlyteam, playerowner, linkedent) {
  if(utility::issharedfuncdefined(#"spawn", #"addSpawnInfluencer")) {
    return [[utility::getsharedfunc(#"spawn", #"addSpawnInfluencer")]](influencerkey, pos, friendlyteam, playerowner, linkedent);
  }

  return undefined;
}

function function_4c27e16d83fce53a(position) {
  return utility::callsharedfunc(#"event", #"predatormissileimpact", position);
}

function function_1b4f3463636d75b5(position) {
  return utility::callsharedfunc(#"event", #"largevehicleexplosion", position);
}

function function_3f6bebe1af42b0a8(damagedata) {
  return utility::callsharedfunc(#"event", #"vehiclekilled", damagedata);
}

function function_ed5039695a18b289(missile) {
  return utility::callsharedfunc(#"event", #"missilefired", missile);
}

function function_9b4fb0a03905926d(entity, applycallback, startcallback, clearcallback) {
  return utility::callsharedfunc(#"emp", #"emp_debuff_register", entity, applycallback, startcallback, clearcallback);
}

function emp_debuff_deregister_sharedfunc(entity) {
  return utility::callsharedfunc(#"emp", #"emp_debuff_deregister", entity);
}

function clear_empsharedfunc(fromdeath) {
  return utility::callsharedfunc(#"emp", #"clear_emp", fromdeath);
}

function allow_empsharedfunc(status) {
  return utility::callsharedfunc(#"emp", #"allow_emp", status);
}

function function_d2b2cb6a7fea26de() {
  return utility::callsharedfunc(#"emp", #"emp_debuff_get_emp_count");
}

function is_empdsharedfunc() {
  return istrue(utility::callsharedfunc(#"emp", #"is_empd"));
}

function play_scramblesharedfunc(scramblelevel, isjammer) {
  return utility::callsharedfunc(#"emp", #"play_scramble", scramblelevel, isjammer);
}

function stop_scramblesharedfunc(scramblelevel, isjammer) {
  return utility::callsharedfunc(#"emp", #"stop_scramble", scramblelevel, isjammer);
}

function function_62b4af8718fa499b(optionalorigin, optionalradius) {
  return utility::callsharedfunc(#"emp", #"emp_debuff_get_emp_ents", optionalorigin, optionalradius);
}

function playsoundtoplayersharedfunc(aliasname, player, srcentity) {
  return utility::callsharedfunc(#"sound", #"playsoundtoplayer", aliasname, player, srcentity);
}

function spawnfxforclientsharedfunc(fxid, position, player, forward, up) {
  return utility::callsharedfunc(#"fx", #"spawnfxforclient", fxid, position, player, forward, up);
}

function setfxkilldefondeletesharedfunc() {
  utility::callsharedfunc(#"fx", #"setfxkilldefondelete");
}

function function_bb9b98eb7368a15a(scriptbundle_name, current_round) {
  return utility::callsharedfunc(#"zombie", #"health_scaling_get_starting_health", scriptbundle_name, current_round);
}

function function_870440d8340968c0(subclass, current_round, var_97ec033c18291ffa) {
  return utility::callsharedfunc(#"zombie", #"health_scaling_get_subclass_health", subclass, current_round, var_97ec033c18291ffa);
}

function function_b2ccfa9f49ce6938(current_round) {
  return utility::callsharedfunc(#"zombie", #"hash_e27e55920dabe660", current_round);
}

function function_ba64ecf971fcc9ba(current_round) {
  return utility::callsharedfunc(#"zombie", #"hash_c726695b2536f1a", current_round);
}

function function_6977eb27282ef178() {
  return utility::callsharedfunc(#"zombie", #"ammo_mod_cooldown_init");
}

function function_f3b72bf1c0b8c737(w_current) {
  return istrue(utility::callsharedfunc(#"zombie", #"has_ammo_mod", w_current));
}

function function_30cd19b8533d27d2(w_current) {
  return utility::callsharedfunc(#"zombie", #"get_ammo_mod_name", w_current);
}

function getplayerweaponraritysharedfunc(weapon) {
  return utility::callsharedfunc(#"zombie", #"GetPlayerWeaponRarity", weapon);
}

function function_1d4087075103b248(weapon) {
  return utility::callsharedfunc(#"zombie", #"get_pap_level", weapon);
}

function function_d14f9550ec3c9c39(dmg_struct) {
  return utility::callsharedfunc(#"zombie", #"scaleUnderbarrelDamageByRound", dmg_struct);
}

function function_fd2dd8546ecc345e() {
  return utility::callsharedfunc(#"zombie", #"hash_5140dd0eed11854c");
}

function onHumanoidAgentKilledCommon_SharedFunc(einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration, dropweapons) {
  return utility::callsharedfunc(#"ai", #"onHumanoidAgentKilledCommon_SharedFunc", einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration, dropweapons);
}

function spawnnewaitype_sharedfunc(aitype, position, angles, team, characterlistname, gender) {
  return utility::callsharedfunc(#"ai", #"spawnnewaitype_sharedfunc", aitype, position, angles, team, characterlistname, gender);
}

function animscripted_sharedfunc(anime, anim_string, org, animangles, anim_flag, dont_clear) {
  return utility::callsharedfunc(#"ai", #"Animscripted_SharedFunc", anime, anim_string, org, animangles, anim_flag, dont_clear);
}

function get_aitype_by_subclass_sharedfunc(subclass) {
  return utility::callsharedfunc(#"ai", #"get_aitype_by_subclass_sharedfunc", subclass);
}

function get_aitype_default_spawn_team_SharedFunc() {
  return utility::callsharedfunc(#"ai", #"get_aitype_default_spawn_team_SharedFunc");
}

function displaydamagenumber_sharedfunc(eattacker, etargethit, shitloc, smeansofdeath, sweapon, idamage, vpoint, isimmnue, selement, biscritical, var_4f9d5587bf9a2b1e) {
  return utility::callsharedfunc(#"ai", #"displaydamagenumber_sharedfunc", eattacker, etargethit, shitloc, smeansofdeath, sweapon, idamage, vpoint, isimmnue, selement, biscritical, var_4f9d5587bf9a2b1e);
}

function giveaiweapon_sharedfunc(weapname) {
  return utility::callsharedfunc(#"ai", #"giveAIWeapon", weapname);
}

function getfreeaicount_sharedfunc() {
  return utility::callsharedfunc(#"ai", #"getfreeaicount");
}

function showpoweruphudsharedfunc(powerupname, lifetime) {
  if(utility::issharedfuncdefined(#"powerups", #"showPowerupHud")) {
    self[[utility::getsharedfunc(#"powerups", #"showPowerupHud")]](powerupname, lifetime);
  }
}

function dopowerupscoreeventsharedfunc() {
  if(utility::issharedfuncdefined(#"powerups", #"doPowerupScoreEvent")) {
    self[[utility::getsharedfunc(#"powerups", #"doPowerupScoreEvent")]]();
  }
}

function droppowerupsharedfunc(powerupname, spawnpos, lifetimeOverride) {
  if(utility::issharedfuncdefined(#"powerups", #"dropPowerup")) {
    return self[[utility::getsharedfunc(#"powerups", #"dropPowerup")]](powerupname, spawnpos, lifetimeOverride);
  }
}

function function_9cce6b480d1d501a() {
  return utility::callsharedfunc(#"points", #"get_points");
}

function function_95e6efa0e69ace16(points) {
  return utility::callsharedfunc(#"points", #"set_points", points);
}

function function_c46160a261771d5d(points) {
  return utility::callsharedfunc(#"points", #"add_points", points);
}

function function_6ea1ac037efdef01(points) {
  return utility::callsharedfunc(#"points", #"take_points", points);
}

function function_95538e4344ab0bfb(dvar_value, func) {
  return utility::callsharedfunc(#"dev", #"register_dev_console_callback", dvar_value, func);
}