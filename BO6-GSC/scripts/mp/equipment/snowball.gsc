/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\equipment\snowball.gsc
*********************************************/

#using script_b7a9ce0a2282b79;
#using scripts\br\ammorestock;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\structspawnconfig;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\pickups_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\equipment\gas_grenade;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\weapons;
#namespace snowball;

function autoexec init() {
  var_49173d4160dc5e29 = getdvarint(@ "hash_f6d5f41c90d7886c", 0);
  var_394fed7c922e1a79 = getdvarint(@ "hash_f0056cf75f3c0553", 0);
  var_a7be83c8f2cb0531 = getdvarint(@ "scr_snowball_pile_enabled", 0);
  var_758b3026143175eb = getdvarint(@ "hash_a5e38d38fc82b1a", 0);

  if(!isDefined(level.var_ef6fc50ff40f47a8)) {
    level.var_ef6fc50ff40f47a8 = [];
  }

  level.var_ef6fc50ff40f47a8[level.var_ef6fc50ff40f47a8.size] = "snowball";

  if(getdvarint(@ "ob_codmas", -1) != 0 && getdvarint(@ "hash_7b01bc465fe20ef", 0)) {
    level.var_36f39959994992f9 = &snowball_init;
  }

  if(!var_49173d4160dc5e29 && !var_394fed7c922e1a79 && !var_a7be83c8f2cb0531) {
    return;
  }

  if(!isDefined(level.var_c02b36c6525a0d19)) {
    level.var_c02b36c6525a0d19 = [];
  }

  if(var_49173d4160dc5e29) {
    level.var_5a2fc0b77a98b634 = "equip_snowball";
    level.var_d97c6bf21a62db0d = "zmloot_offhand_snowball";
  }

  if(isbrgamemode()) {
    level.var_21d53146c0bc43a3 = "equip_snowball";
    level.var_3f65bcaf222637f0 = "brloot_snowball";
  } else {
    level.var_21d53146c0bc43a3 = "equip_snowball";
    level.var_3f65bcaf222637f0 = "zmloot_offhand_snowball";
  }

  level.var_c02b36c6525a0d19["snowball"] = &function_fa3ea6a75a3d374b;
  weapons::registerusedcallback("snowball", &snowball_used);

  if(getdvarint(@ "hash_a85ab31ef13b2a3b", 0)) {
    weapons::registerusedcallback("pball", &function_5006a6118f7cba69);
    utility::registersharedfunc(#"game", #"hash_f6616377f8919cc4", &function_f38a66b01ff221c1);
    level.var_c02b36c6525a0d19["pball"] = &function_fa3ea6a75a3d374b;
  }

  if(var_394fed7c922e1a79) {
    if(!isDefined(level.var_d4e1d6e51b37f60b)) {
      level.var_d4e1d6e51b37f60b = [];
    }

    level.var_d4e1d6e51b37f60b[level.var_d4e1d6e51b37f60b.size] = &lootCacheAdjustItems;

    if(!level callback::exists(#"lootCacheAddAdditionalLoot", &function_1a4c55db412346f)) {
      level callback::add(#"lootCacheAddAdditionalLoot", &function_1a4c55db412346f);
    }
  }

  if(var_758b3026143175eb) {
    level thread function_26b3b4edfc78a5ec();
  }

  thread delayedinit(var_a7be83c8f2cb0531);
}

function function_f38a66b01ff221c1(currentequipment, newequipment) {
  if(currentequipment == "equip_pball" && newequipment == "equip_snowball") {
    return true;
  }

  return false;
}

function delayedinit(var_a7be83c8f2cb0531) {
  utility::flag_wait("scriptables_ready");

  if(var_a7be83c8f2cb0531) {
    if(isbrgamemode()) {
      level.var_74fecfead7293f71 = &function_321099bf2e0809e2;
    } else {
      level.var_74fecfead7293f71 = &function_a0d7caaae0449d18;
    }

    [[level.var_74fecfead7293f71]]();
  }

  var_fb748d2062bfae5d = getdvarint(@ "hash_15e692eda234df47", 0);

  if(var_fb748d2062bfae5d) {
    level.equipment.callbacks["equip_snowball"]["onGive"] = &function_136147417ca96d4;
    level.equipment.callbacks["equip_snowball"]["onTake"] = &function_ac9adc6261068313;

    if(getdvarint(@ "hash_a85ab31ef13b2a3b", 0)) {
      level.equipment.callbacks["equip_pball"]["onGive"] = &function_136147417ca96d4;
      level.equipment.callbacks["equip_pball"]["onTake"] = &function_ac9adc6261068313;
    }
  }
}

function snowball_init() {
  bundle = level.equipment.table["equip_snowball"].bundle;
  snowball_ref = bundle.useweapon;

  level thread snowball_debug();

  level.var_2b05c4318f5819d4 = [];
  level callback::add("ob_content_process_create_script", &function_3cba17a916423c77);
}

function function_3cba17a916423c77(params) {
  level endon("game_ended");

  if(isDefined(level.var_37ee95c5464d47be)) {
    level.var_2b05c4318f5819d4 = function_be19f9c0ab503485();
    level.var_457a9490df43d5e4 = [];

    if(isDefined(level.var_37ee95c5464d47be)) {
      level.var_2b05c4318f5819d4 = [[level.var_37ee95c5464d47be]]("snowball_pile", level.var_2b05c4318f5819d4);
    }

    shouldshowicon = getdvarint(@ "hash_e1806d78ca2e43d4", 0);
    targetstate = shouldshowicon ? "useable_on" : "useable_on_no_icon";

    if(level.var_2b05c4318f5819d4.size != 0) {
      scriptable::scriptable_addusedcallbackbypart("zm_t10_snowball_pile", &function_7aa45db786825c28);

      foreach(instance in level.var_2b05c4318f5819d4) {
        instance setscriptablepartstate("zm_t10_snowball_pile", targetstate);
      }
    }
  }
}

function snowball_used(grenade) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(getdvarint(@ "hash_a85ab31ef13b2a3b", 0)) {
    if(randomint(100) < getdvarint(@ "hash_776e4da7cd78a60", 40)) {
      wait 0.5;
      ammocount = equipment_mp::getequipmentammo("equip_snowball");
      equipment_mp::giveequipment("equip_pball", "primary");
      equipment_mp::setequipmentammo("equip_pball", ammocount);
    }
  }
}

function function_5006a6118f7cba69(grenade) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  thread gas_grenade::gas_used(grenade);
  wait 1.5;
  ammocount = equipment_mp::getequipmentammo("equip_pball");
  equipment_mp::giveequipment("equip_snowball", "primary");
  equipment_mp::setequipmentammo("equip_snowball", ammocount);
}

function function_fa3ea6a75a3d374b(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2) {
  if(!isDefined(victim) || !isPlayer(victim)) {
    return idamage;
  }

  if(isbrgamemode()) {
    shouldstun = getdvarint(@ "hash_f208d87abfff9c9a", 0);
    idamage = getdvarint(@ "hash_35df4921065c4923", 50);
    var_54bd730d7b410567 = getdvarint(@ "hash_cd93f963f11a63ab", 0);

    if(player::isinlaststand(victim)) {
      idamage = 9999;
      shouldstun = 0;

      if(isDefined(eattacker)) {
        challenges::function_37e945722d6497f3(eattacker, "br_codmas_2023_snow_day", 1);
      }
    } else if(victim br_public::isplayeringulag()) {
      if(victim.health <= 1) {
        idamage = 0;
      } else {
        idamage = 1;
      }

      shouldstun = 0;
    }

    if(!var_54bd730d7b410567 && eattacker == victim) {
      shouldstun = 0;
      idamage = 0;
    }

    if(shouldstun) {
      victim thread applystun(eattacker);
    }
  }

  return idamage;
}

function lootCacheAdjustItems(items, instance) {
  if(!isDefined(instance.type) || !isstartstr(instance.type, "br")) {
    return items;
  }

  if(randomint(100) < getdvarint(@ "hash_d682622db30f1dde", 40)) {
    items[items.size] = "brloot_snowball";
  }

  return items;
}

function function_1a4c55db412346f(params) {
  instance = params.cache;

  if(randomint(100) < getdvarint(@ "hash_d682622db30f1dde", 40)) {
    snowballbundlename = utility::callsharedfunc(#"game", #"getItemBundleNameFromRef", "equip_snowball");
    common_cache::function_b626b689c2097b7f(instance, snowballbundlename, undefined, 1);
  }
}

function function_26b3b4edfc78a5ec() {
  level endon("game_ended");
  utility::flag_wait("StartGameTypeCallbackFinished");
  level.brgametype.var_5fb8191225e04e8e = 1;
  level.brgametype.var_3adc929a6263fb67 = getdvarint(@ "hash_a1dfc09b1b832937", 6);
}

function applystun(eattacker) {
  if(utility::isusingremote()) {
    return;
  }

  if(self.concussionimmune) {
    return;
  }

  stunduration = getdvarfloat(@ "hash_17741844c6f8fd0f", 3);

  if(utility::issharedfuncdefined(#"specialty_stun_resistance", #"applystunresistence")) {
    stunduration = [[utility::getsharedfunc(#"specialty_stun_resistance", #"applystunresistence")]](eattacker, self, stunduration);
  }

  self notify("concussed", eattacker);
  self notify("flashbang", self.origin, 1, 1, eattacker, "axis");
  utility::setplayerstunned();
  thread weapon_utility::cleanupconcussionstun(stunduration);
  shellshock_utility_cpmp::_shellshock(%"concussion_grenade_mp", #"stun", stunduration, 1);
  player::codcastersetplayerstatuseffect("stun", stunduration);
}

function function_136147417ca96d4(ref, slot, variantid, attachments) {
  self endon("death_or_disconnect");
  self endon("equipment_taken_" + ref);
  level endon("game_ended");

  while(true) {
    self waittill("grenade_pullback", objweapon);
    weapstring = getweaponrootstring(objweapon);
    issnowball = weapstring == "snowball" || weapstring == "pball";
    playerhasperk = isDefined(self.perks["specialty_grenade_expert"]);

    if(issnowball && !playerhasperk) {
      perk::giveperk("specialty_grenade_expert");
      self.var_126459d855566cb3 = 1;
    }

    self waittill("grenade_fire", grenade, objweapon);

    if(issnowball && !playerhasperk) {
      perk::removeperk("specialty_grenade_expert");
      self.var_126459d855566cb3 = undefined;
    }
  }
}

function function_ac9adc6261068313(ref, slot, variantid) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(self.var_126459d855566cb3) {
    perk::removeperk("specialty_grenade_expert");
    self.var_126459d855566cb3 = undefined;
  }
}

function function_321099bf2e0809e2() {
  if(getdvarint(@ "hash_6dd0d0ecaa656aa2", 0) && getdvarint(@ "scr_ssc_enabled", 1)) {
    function_34ba2d9a2e228917();
    return;
  } else {
    instances = function_be19f9c0ab503485();
  }

  var_62edb275325d6fc8 = getdvarint(@ "hash_b8bbdda19268f4b2", 0);

  if(var_62edb275325d6fc8) {
    debuginstances = level function_d87cdcabccd8f677();
    instances = arraycombine(instances, debuginstances);
  }

  if(instances.size > 0) {
    snowballsetup(instances);
  }
}

function function_34ba2d9a2e228917() {
  level endon("game_ended");
  assert(isDefined(level.ssc), "<dev string:x24>");
  utility::flag_wait("ssc_initialized");
  structspawnconfig::function_7418a260adaec05("br_codmas_coolers", &function_aaf0bb2220bb1f33);
  structspawnconfig::function_8c0a09968efe9138("br_codmas_coolers", &function_9ca700ec2a4651b9);
  structspawnconfig::function_36050499b5f48983("br_codmas_coolers", &function_f8ca7832c078b2b2);
}

function function_aaf0bb2220bb1f33(structname) {
  var_4ca7d233c50bffd8 = getentitylessscriptablearray("scriptable_br_snowball_pile", #classname);
  return var_4ca7d233c50bffd8;
}

function function_9ca700ec2a4651b9(structname, instance) {
  if(!isDefined(level.var_92690b43d8ff84aa)) {
    level.var_92690b43d8ff84aa = [];
  }

  level.var_92690b43d8ff84aa[level.var_92690b43d8ff84aa.size] = instance;
  return instance;
}

function function_f8ca7832c078b2b2(structname) {
  var_e1b50cd4c17841d = [];

  foreach(var_ba2a4550ca47c483 in level.var_92690b43d8ff84aa) {
    newpile = spawnscriptable("br_snowball_pile", var_ba2a4550ca47c483.origin);
    var_e1b50cd4c17841d[var_e1b50cd4c17841d.size] = newpile;
  }

  snowballsetup(var_e1b50cd4c17841d);
}

function snowballsetup(var_d9908ba6be176985) {
  level.var_457a9490df43d5e4 = [];
  level.var_e0a5f4b306fd0519 = var_d9908ba6be176985;
  scriptable::scriptable_addusedcallbackbypart("br_snowball_pile", &function_f8b1275714dcb845);
  level thread function_adab024e1d611b42();
}

function function_be19f9c0ab503485() {
  allspawninstances = getentitylessscriptablearray("scriptable_br_snowball_pile", #classname);
  return allspawninstances;
}

function function_a0d7caaae0449d18() {
  if(isDefined(level.var_eb2bab12355222ee)) {
    utility::flag_wait("create_script_initialized");
    [[level.var_eb2bab12355222ee]]();
  }

  instances = function_48478e3fd2f1a83f();

  if(instances.size > 0) {
    level.var_457a9490df43d5e4 = [];
    level.var_e0a5f4b306fd0519 = instances;
    scriptable::scriptable_addusedcallbackbypart("zm_t10_snowball_pile", &function_7aa45db786825c28);
    level thread function_adab024e1d611b42(0);
  }
}

function function_ec1a548253a84fc7(usable, player) {
  if(isDefined(level.var_43f317b13b746709)) {
    if(!player[[level.var_43f317b13b746709]]()) {
      return {
        #string: &"", #type: "HINT_NOICON"};
    }
  }

  if(!isPlayer(player)) {
    obj = {
      #icon: "jup_ui_icons_elementaldamage_cold", #description: &"t10_equipment/snowballpile_desc", #title: &"t10_equipment/snowballpile_title", #buttoncallout: &"t10_equipment/snowballpile_hint", #string: &"t10_equipment/snowballpile_hint", #type: "HINT_BUTTON"};
    return obj;
  }

  guid = player player::getuniqueid();

  if(isDefined(level.var_457a9490df43d5e4[guid][usable.index])) {
    obj = {
      #icon: "jup_ui_icons_elementaldamage_cold", #description: &"t10_equipment/snowballpile_desc", #title: &"t10_equipment/snowballpile_title", #buttoncallout: &"mp_ingame_only/snowball_pile_cool_down", #type: "HINT_BUTTON"};
    return obj;
  }

  slot = "primary";
  equipmentref = player equipment_mp::getcurrentequipment(slot);
  var_4c48fad50fa1fc28 = [];
  currentammo = 0;
  var_c8655d1420e4c7ec = player equipment_mp::getequipmentmaxammo("equip_snowball");

  if(isDefined(equipmentref) && equipmentref == "equip_snowball") {
    currentammo = player equipment_mp::getequipmentammo(equipmentref);

    if(currentammo >= var_c8655d1420e4c7ec) {
      obj = {
        #icon: "jup_ui_icons_elementaldamage_cold", #description: &"t10_equipment/snowballpile_desc", #title: &"t10_equipment/snowballpile_title", #buttoncallout: &"mp_ingame_only/snowball_pile_stock_full", #type: "HINT_BUTTON"};
      return obj;
    }
  }

  obj = {
    #icon: "jup_ui_icons_elementaldamage_cold", #description: &"t10_equipment/snowballpile_desc", #title: &"t10_equipment/snowballpile_title", #buttoncallout: &"t10_equipment/snowballpile_hint", #type: "HINT_BUTTON"};
  return obj;
}

function function_48478e3fd2f1a83f() {
  a_structs = utility::getStructArray("zm_snowball_pile", "targetname");
  var_708a6a41056fd1ae = [];

  foreach(struct in a_structs) {
    var_c75603814b061bbd = spawnscriptable("zm_t10_snowball_pile", struct.origin);
    var_c75603814b061bbd.interact_hint_callback = &function_ec1a548253a84fc7;
    var_708a6a41056fd1ae[var_708a6a41056fd1ae.size] = var_c75603814b061bbd;
  }

  return var_708a6a41056fd1ae;
}

function function_f8b1275714dcb845(instance, part, state, player, bautouse, usestring) {
  assert(part == "<dev string:x41>");
  assert(isbrgamemode() || getdvarint(@ "hash_7b01bc465fe20ef", 0));
  result = thread function_7536f18415a72772(player, instance);

  if(result == 1) {
    thread function_f302b8f9bb3b7bd0(instance, player, 0.1);
    var_b014e3477b10b681 = getdvarint(@ "hash_4c359bab18336dde", 0);

    if(var_b014e3477b10b681 > 0) {
      thread function_6f80135fe82ffe4c(player, instance, var_b014e3477b10b681);
    }

    return;
  }

  if(result == 0) {
    thread function_f302b8f9bb3b7bd0(instance, player, 0.1);
    return;
  }

  thread function_f302b8f9bb3b7bd0(instance, player, 0.1);
}

function function_7aa45db786825c28(instance, part, state, player, bautouse, usestring) {
  assert(part == "<dev string:x55>");

  if(isDefined(level.var_43f317b13b746709)) {
    if(!player[[level.var_43f317b13b746709]]()) {
      return;
    }
  }

  var_398f67faabe5e244 = &function_f302b8f9bb3b7bd0;

  if(level.var_ef2c66ea0f63ad4c) {
    var_398f67faabe5e244 = &function_31079ec35a3e2724;
  }

  result = thread function_7536f18415a72772(player, instance);

  if(result == 1) {
    foreach(pingplayer in level.players) {
      if(pingplayer function_333d9cb29c9abb4f(instance.index)) {
        instance calloutmarkerping::function_608710c894185549(pingplayer);
      }
    }

    thread[[var_398f67faabe5e244]](instance, player, 30);
    return;
  }

  if(result == 0) {
    thread function_f302b8f9bb3b7bd0(instance, player, 0.1);
    return;
  }

  thread function_f302b8f9bb3b7bd0(instance, player, 0.1);
}

function function_adab024e1d611b42(var_76b1258cff4feff0 = 1) {
  level endon("game_ended");

  if(var_76b1258cff4feff0) {
    if(getdvarint(@ "hash_6dd0d0ecaa656aa2", 0)) {
      flags::gameflagwait("POIs_spawned");
    } else {
      level waittill("spawning_POIs");
    }

    flags::gameflagwait("prematch_fade_done");
  }

  targetstate = undefined;
  shouldshowicon = getdvarint(@ "hash_e1806d78ca2e43d4", 0);

  if(shouldshowicon) {
    targetstate = "useable_on";
  } else {
    targetstate = "useable_on_no_icon";
  }

  foreach(snowballpile in level.var_e0a5f4b306fd0519) {
    if(snowballpile.var_235ba94ea91bdd9c) {
      targetstate = "useable_on_no_icon";
    }

    var_971fbbc3bc942c93 = "zm_t10_snowball_pile";

    if(isbrgamemode()) {
      var_971fbbc3bc942c93 = "br_snowball_pile";
    }

    snowballpile setscriptablepartstate(var_971fbbc3bc942c93, targetstate);
  }
}

function function_7536f18415a72772(player, instance) {
  player endon("death_or_disconnect");
  guid = player player::getuniqueid();

  if(!isDefined(level.var_457a9490df43d5e4[guid])) {
    level.var_457a9490df43d5e4[guid] = [];
  }

  if(isDefined(level.var_457a9490df43d5e4[guid][instance.index])) {
    player hud_message::showerrormessage("MP_INGAME_ONLY/SNOWBALL_PILE_COOL_DOWN", int((level.var_457a9490df43d5e4[guid][instance.index] - gettime()) / 1000));
    player playlocalsound("fly_pickup_deny");
    return 2;
  }

  slot = "primary";
  equipmentref = player equipment_mp::getcurrentequipment(slot);
  var_4c48fad50fa1fc28 = [];
  currentammo = 0;
  var_c8655d1420e4c7ec = player equipment_mp::getequipmentmaxammo("equip_snowball");

  if(isDefined(equipmentref) && equipmentref == "equip_snowball") {
    currentammo = player equipment_mp::getequipmentammo(equipmentref);

    if(currentammo >= var_c8655d1420e4c7ec) {
      player hud_message::showerrormessage("MP_INGAME_ONLY/SNOWBALL_PILE_STOCK_FULL");
      player playlocalsound("fly_pickup_deny");
      return 0;
    }

    player equipment_mp::incrementequipmentammo(equipmentref, var_c8655d1420e4c7ec);
  } else {
    if(!level.var_90a1a8facd325374 && isDefined(equipmentref)) {
      if(utility::callsharedfunc(#"game", #"isCommonItemEnabled")) {
        player utility::callsharedfunc(#"game", #"dropItem_equipment_lethal");
      } else {
        dropstruct = pickups::function_f71dd588dc4f6288();
        player br_pickups::dropequipmentinslot(dropstruct, "primary");
      }
    }

    player equipment_mp::giveequipment("equip_snowball", slot);
    player equipment_mp::setequipmentammo("equip_snowball", var_c8655d1420e4c7ec);

    if(!utility::callsharedfunc(#"game", #"isCommonItemEnabled")) {
      lootid = loot::function_d3e3bcaea591a6a2("zmloot_offhand_snowball");
      namespace_947907a9df1b18c7::function_b1116f6c1b474c9c(player, slot, lootid);
    }
  }

  fakepickup = spawnStruct();
  fakepickup.count = var_c8655d1420e4c7ec - currentammo;
  fakepickup.scriptablename = "zmloot_offhand_snowball";
  fakepickup.stackable = fakepickup.count;
  var_4c48fad50fa1fc28["zmloot_offhand_snowball"] = fakepickup;
  player damagefeedback::hudicontype("br_ammo");

  if(isbrgamemode()) {
    level thread namespace_3c86b55665f25eea::function_76eb7bbebf08bde6(player, var_4c48fad50fa1fc28);
  } else if(utility::issharedfuncdefined(#"game", #"showStockLootFeed")) {
    level thread[[utility::getsharedfunc(#"game", #"showStockLootFeed")]](player, var_4c48fad50fa1fc28);
  }

  player playlocalsound("fly_pickup_ammo_gen");
  return 1;
}

function function_f302b8f9bb3b7bd0(scriptable, player, time) {
  player endon("disconnect");
  scriptable disablescriptableplayeruse(player);
  wait time;
  scriptable enablescriptableplayeruse(player);
}

function function_31079ec35a3e2724(scriptable, player, time) {
  scriptable setscriptablepartstate("zm_t10_snowball_pile", "unusable_hidden");
  wait time;
  scriptable setscriptablepartstate("zm_t10_snowball_pile", "useable_on");
}

function function_6f80135fe82ffe4c(player, instance, time) {
  guid = player player::getuniqueid();
  level.var_457a9490df43d5e4[guid][instance.index] = gettime() + time * 1000;
  player utility::waittill_notify_or_timeout("death", time);

  if(!isDefined(player) || !player::isreallyalive(player)) {
    level.var_457a9490df43d5e4[guid] = undefined;
    return;
  }

  level.var_457a9490df43d5e4[guid][instance.index] = undefined;
}

function function_d87cdcabccd8f677() {
  if(level.mapname == "mp_t10_area99") {
    var_b8d5a7b92ad0c7a1 = [(-5328, -4592, -304), (-176, -4376, -120), (-1616, -1072, 192), (-5848, 160, 72), (-6576, 2888, -432), (-6648, -2496, 488), (24, -8, 1456), (3424, 5872, -96), (3272, 1688, 144), (7776, 1656, -160), (7368, -200, 144), (-2976, 3184, 456), (-2552, 1296, 144)];
    var_a86a497c3d2d09cf = [(0, 180, 0), (25, 90, 0), (0, 270, 0), (0, 90, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 230, 0), (0, 90, 0), (0, 90, 0), (0, 150, 0)];
  } else {
    var_b8d5a7b92ad0c7a1 = [(-15898, 25487, 3121), (-21173, 7983, 2447), (-14007, -16982, 1743), (15701, -35062, 2789), (11419, -1012, 1818), (32663, 15229, 3243), (37319, -6805, 3045)];
  }

  newpiles = [];
  var_971fbbc3bc942c93 = "zm_t10_snowball_pile";

  if(isbrgamemode()) {
    var_971fbbc3bc942c93 = "br_snowball_pile";
  }

  if(isDefined(var_a86a497c3d2d09cf)) {
    for(snowpileindex = 0; snowpileindex < var_b8d5a7b92ad0c7a1.size; snowpileindex++) {
      pilelocation = var_b8d5a7b92ad0c7a1[snowpileindex];
      pileangle = var_a86a497c3d2d09cf[snowpileindex];
      groundpos = br_public::droptogroundmultitrace(pilelocation);
      newpile = spawnscriptable(var_971fbbc3bc942c93, groundpos, pileangle);
      newpiles[newpiles.size] = newpile;
    }
  } else {
    foreach(pilelocation in var_b8d5a7b92ad0c7a1) {
      groundpos = br_public::droptogroundmultitrace(pilelocation);
      newpile = spawnscriptable(var_971fbbc3bc942c93, groundpos);
      newpiles[newpiles.size] = newpile;
    }
  }

  return newpiles;
}

function snowball_debug() {
  thread function_8835dca1b6d98bb2();
  waitframe();
  devgui::function_9082edeb5db93280("<dev string:x6d>");
  devgui::function_eaac4ba4b3caf621("<dev string:x7d>", @ "hash_1d70cb5e7577f771");
  devgui::function_eaac4ba4b3caf621("<dev string:x94>", @ "hash_e5b6d89da0b2af75");
  devgui::function_eaac4ba4b3caf621("<dev string:xac>", @ "hash_149d18b74f867967");
  devgui::function_77df7fe7dd273e10();
}

function private function_8835dca1b6d98bb2() {
  level endon("<dev string:xce>");

  while(true) {
    if(getdvarint(@ "hash_1d70cb5e7577f771", 0)) {
      setDvar(@ "hash_1d70cb5e7577f771", 0);

      foreach(player in level.players) {
        if(!(isDefined(player) && isDefined(player.origin))) {
          continue;
        }

        forward = anglesToForward(player getplayerangles());
        pos = player.origin + forward * 300;
        pos = br_public::droptogroundmultitrace(pos, 100);
        snowball_pile = spawnscriptable("<dev string:x55>", pos);
        snowball_pile setscriptablepartstate("<dev string:x41>", "<dev string:xdc>");
      }
    }

    if(getdvarint(@ "hash_e5b6d89da0b2af75", 0)) {
      setDvar(@ "hash_e5b6d89da0b2af75", 0);

      foreach(snowballpile in level.var_2b05c4318f5819d4) {
        snowballpile setscriptablepartstate("<dev string:x55>", "<dev string:xdc>");
      }
    }

    if(getdvarint(@ "hash_149d18b74f867967", 0)) {
      setDvar(@ "hash_149d18b74f867967", 0);

      foreach(snowballpile in level.var_2b05c4318f5819d4) {
        snowballpile setscriptablepartstate("<dev string:x55>", "<dev string:xea>");
      }
    }

    waitframe();
  }
}

# /