/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1930.gsc
*************************************************/

_id_2F98() {
  level thread _id_2FBA();
}

_id_2F83(var_0, var_1) {
  var_2 = self;
  var_2 _id_2FA7(var_0);
  var_3 = getdvarint("#x354377bb6aae920b0", 82);
  var_4 = var_1.origin + (0, 0, var_3);
  var_5 = 1;
  var_6 = var_2 _meth_87A5(1);
  var_7 = var_2 _meth_87A5(2);

  if(var_7 < var_6) {
    var_6 = var_7;
    var_5 = 2;
  }

  var_2 _meth_8716(var_5, var_4, 0);
  var_2 thread _id_0B8E(var_5);
  _id_0B8D("Enemy switched to danger");
}

_id_0B8D(var_0) {}

_id_0B91() {
  return 1;
}

_id_0B8A(var_0) {
  return var_0 == 7 || var_0 == 8;
}

_id_0B89(var_0) {
  return var_0 == 3 || var_0 == 4;
}

_id_0B88(var_0) {
  return var_0 == 1 || var_0 == 2;
}

_id_0B8E(var_0, var_1) {
  var_2 = self;
  level endon("game_ended");
  var_2 endon("disconnect");
  var_2 notify("predictiveCalloutClear_" + var_0);
  var_2 endon("predictiveCalloutClear_" + var_0);
  var_3 = 2;
  var_4 = undefined;

  if(_id_0B89(var_0)) {
    var_5 = var_2 _meth_8791(var_0);

    if(isDefined(var_5)) {
      var_6 = getdvarint("#x3dd367002f05f6996", 1);

      if(var_6 && _id_0B83(var_5, var_2)) {
        var_3 = getdvarfloat("#x34de790309250f161", 3.0);
        var_4 = var_5;
        _id_0B8D("Enemy tracked!");
      }

      var_2 thread _id_2FB2(var_0, var_5);
    }
  } else if(var_0 == 0) {
    if(getdvarint("#x3236d9ef6c1394a6d", 0)) {
      var_2 thread _id_2F9F();
    }
  } else if(var_0 == 5)
    var_2 thread _id_2FB5(var_0);
  else if(_id_0B8A(var_0)) {
    var_7 = var_2 _meth_8791(var_0);
    var_2 thread _id_2FB4(var_0, var_7);
  } else if(var_0 == 6) {
    var_7 = var_2 _meth_8791(var_0);
    var_2 thread _id_2FB2(var_0, var_7);
    var_2 thread _id_2FA9(var_0, var_7);
  } else if(!_id_0B91()) {
    if(var_0 == -1) {
      var_2 thread _id_2FB3(-1, var_1);
    }
  }

  if(!isDefined(var_4)) {
    var_3 = var_2 _id_2F92(var_0);
  }

  _id_0B8D("Timeout value before wait: " + var_3 + " | poolID: " + var_0);
  wait(var_3);

  if(isDefined(var_4) && isDefined(var_2)) {
    var_2 thread _id_2F83(var_0, var_4);
  } else {
    _id_0B8D("Pool timed out: " + var_0);
    var_2 _id_2FA7(var_0);
  }
}

_id_0B8B() {
  var_0 = self;

  for(var_1 = 0; var_1 < 9; var_1++) {
    if(var_0 _meth_8790(var_1)) {
      return var_1;
    }
  }

  return -1;
}

_id_0B8C() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("luinotifyserver", var_1, var_2, var_3);

    if(!isDefined(var_1) || !isDefined(var_2)) {
      continue;
    }
    _id_0B8D("Notification " + var_1 + " on pool " + var_2);

    switch (var_1) {
      case "calloutmarkerping_added":
        var_0 _id_0B7D(var_2);
        break;
      case "calloutmarkerping_cleared":
        var_0 _id_0B7F(var_2);
        break;
      case "calloutmarkerping_acknowledged":
        var_0 _id_0B7B(var_2, var_3);
        break;
      case "calloutmarkerping_acknowledged_cancel":
        var_0 _id_0B7C(var_2);
        break;
      case "calloutmarkerping_enemy_repinged":
        var_0 _id_0B80(var_2);
        break;
      case "map_ping_delete_marker":
        var_0 _id_0B81();
        break;
      case "br_inventory_slot_request":
        var_0 _id_0B7E(var_2);
        break;
      default:
        break;
    }
  }
}

_id_2F99() {
  var_0 = self;

  if(!isDefined(var_0._id_2FCA)) {
    var_0._id_2FCA = [];
  }

  var_0 thread _id_0B8C();
}

_id_0B8F(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = var_0 _meth_8721(0);

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = var_0 _meth_8575(var_1, 1);

  if(!isDefined(var_2)) {
    return 0;
  }

  var_3 = var_0 _meth_867C(var_1, var_2, "type");

  if(!isDefined(var_3)) {
    return 0;
  }

  if(var_3 != "useable") {
    return 0;
  }

  return 1;
}

_id_0B83(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isPlayer(var_0)) {
    return 0;
  }

  if(!isDefined(var_0.team)) {
    return 0;
  }

  if(var_0.team == "neutral") {
    return 0;
  }

  return var_0.team != var_1.team;
}

_id_0B85(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isent(var_0)) {
    return issubstr(var_0.type, "brloot_plunder_extraction");
  }

  if(!isDefined(var_0.model)) {
    return 0;
  }

  return var_0.model == "military_skyhook_far";
}

_id_0B82(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isent(var_0)) {
    return 0;
  }

  if(!isDefined(var_0.cratetype)) {
    return 0;
  }

  return var_0.cratetype == "battle_royale_loadout" || var_0.cratetype == "killstreak" || var_0.cratetype == "juggernaut" || var_0.cratetype == "manual_turret";
}

_id_2F9E(var_0) {
  return isDefined(var_0._id_5562) && var_0._id_5562 == "equip_supportBox";
}

_id_0B84(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!var_0 _meth_86FA()) {
    return 0;
  }

  if(var_0.type != "br_plunder_box") {
    return 0;
  }

  return 1;
}

_id_2F9A(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isent(var_0)) {
    return 0;
  }

  return issubstr(var_0.classname, "grenade") || issubstr(var_0.classname, "c4_") || issubstr(var_0.classname, "proximity_explosive_") || issubstr(var_0.classname, "claymore_");
}

_id_2F7E(var_0, var_1) {
  if(var_0 _meth_81D3() || var_0 _meth_8605()) {
    return 0;
  }

  if(!isalive(var_0)) {
    return 0;
  }

  if(istrue(var_0._id_9ABD) && !isDefined(var_1)) {
    return 0;
  }

  if(istrue(var_0._id_7262)) {
    return 0;
  }

  if(var_0 scripts\cp_mp\utility\player_utility::_id_8ACE()) {
    return 0;
  }

  return 1;
}

_id_6ACB(var_0) {
  switch (var_0) {
    case 0:
      return undefined;
    case 1:
      return undefined;
    case 8:
      return undefined;
    case 2:
      return "ping_need_armor";
    case 3:
      return "ping_need_midcal";
    case 4:
      return "ping_need_shells";
    case 5:
      return "ping_need_smallcal";
    case 6:
      return "ping_need_launcher";
    case 7:
      return "ping_need_highcal";
    default:
      break;
  }

  return undefined;
}

_id_6ACA(var_0) {
  switch (var_0) {
    case 0:
      return "plunder";
    case 2:
      return "brloot_armor_plate";
    case 3:
      return "brloot_ammo_762";
    case 4:
      return "brloot_ammo_12g";
    case 5:
      return "brloot_ammo_919";
    case 6:
      return "brloot_ammo_rocket";
    case 7:
      return "brloot_ammo_50cal";
    case 8:
    case 1:
    default:
      break;
  }

  return "";
}

_id_2FAA(var_0) {
  var_1 = self;

  if(!_id_2F7E(var_1) || !_id_0B91()) {
    return;
  }
  var_2 = var_1 _meth_8790(-1);

  if(var_2) {
    var_3 = var_1 _meth_87A4(-1);
    var_1 _id_2FA7(-1);

    if(var_3 == var_0) {
      var_1 _id_2FA1("br_ping_cancel", -1);
      return;
    }
  }

  var_4 = getdvarint("#x355749103dd79c293", 82);
  var_5 = (0, 0, var_4);
  var_1 _meth_8716(-1, var_5, var_0);
  var_1 thread _id_0B8E(-1, var_0);
  var_1 thread _id_2FC9(var_0);
}

_id_2FC9(var_0) {
  var_1 = self;

  if(_id_0B91()) {
    return;
  }
  wait(getdvarfloat("#x346cbe57c73575abe", 0.5));
  var_2 = _id_6ACB(var_0);

  if(isDefined(var_2) && isDefined(var_1)) {
    var_1 _id_2FC4(var_2, -1);
  }
}

_id_0B7A(var_0) {
  var_1 = self;

  if(isalive(var_1)) {
    return;
  }
  if(!_id_0B8A(var_0)) {
    return;
  }
  var_2 = var_1 _meth_8791(var_0);

  if(!_id_0B84(var_2)) {
    return;
  }
  var_1 notify("buybackRequested");
}

_id_2FAB() {}

_id_2FB9(var_0) {}

_id_0B87(var_0) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onPing")) {
    return;
  }
  if(_id_0B8A(var_0)) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onPing")]]("object");
  } else if(_id_0B89(var_0)) {
    var_1 = self _meth_8791(var_0);

    if(isDefined(var_1)) {
      if(_id_0B83(var_1, self)) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onPing")]]("enemy");
        return;
      }

      if(!isPlayer(var_1)) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onPing")]]("object");
        return;
      }

      return;
      return;
    }
  } else if(_id_0B88(var_0))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onPing")]]("danger");
  else if(var_0 == 6 || var_0 == -1) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onPing")]]("object");
  }
}

_id_2FBB(var_0, var_1) {}

_id_2FBD(var_0, var_1) {}

_id_2FBE(var_0) {
  return "ping_location_generic";
}

_id_2FBC(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_1) && isDefined(var_1.type)) {
    var_3 = var_1.type;
  } else {
    return "";
  }

  var_4 = 0;
  var_5 = tablelookupgetnumrows(level._id_2BEB);
  var_6 = undefined;

  for(var_7 = var_4; var_7 < var_5; var_7++) {
    var_8 = tablelookupbyrow(level._id_2BEB, var_7, 1);

    if(var_8 == var_3) {
      var_6 = tablelookupbyrow(level._id_2BEB, var_7, 12);

      if(var_6 == "") {}

      break;
    }
  }

  if(!isDefined(var_6)) {
    if(var_3 == "brloot_plunder_extraction_site_01" || var_3 == "brloot_plunder_extraction_site_02" || var_3 == "equip_fulton_mp") {
      return "ping_plunder_bank";
    } else if(var_3 == "ks_airdrop_crate_br") {
      return "ping_plunder_cache";
    }

    return "";
  }

  var_9 = "";

  if(issubstr(var_6, "_PLUNDER_CASH")) {
    var_9 = "ping_plunder_loot";
  } else if(issubstr(var_6, "ARMORY_KIOSK")) {
    if(!isalive(var_2)) {
      var_9 = "ping_response_helpme";
    } else {
      var_9 = "ping_plunder_vendor";
    }
  } else if(issubstr(var_6, "_SHOTGUN"))
    var_9 = "ping_ammo_shotgun";
  else if(issubstr(var_6, "_AMMO_LAUNCHER")) {
    var_9 = "ping_ammo_launcher";
  } else if(issubstr(var_6, "_SNIPER")) {
    var_9 = "ping_ammo_highcal";
  } else if(issubstr(var_6, "_AR_LMG")) {
    var_9 = "ping_ammo_midcaliber";
  } else if(issubstr(var_6, "_PISTOL_SMG")) {
    var_9 = "ping_ammo_smallcal";
  } else if(issubstr(var_6, "ARMOR")) {
    var_9 = "ping_pickup_armor";
  } else if(issubstr(var_6, "_AR")) {
    var_9 = "ping_weapon_assaultrifle";
  } else if(issubstr(var_6, "_SM")) {
    var_9 = "ping_weapon_smg";
  } else if(issubstr(var_6, "_SH")) {
    var_9 = "ping_weapon_shotgun";
  } else if(issubstr(var_6, "_PI")) {
    var_9 = "ping_weapon_pistol";
  } else if(issubstr(var_6, "_SN")) {
    var_9 = "ping_weapon_sniper";
  } else if(issubstr(var_6, "_LM")) {
    var_9 = "ping_weapon_lmg";
  } else if(issubstr(var_6, "_LA")) {
    var_9 = "ping_weapon_launcher";
  } else if(var_6 == "MP/BR_TYPE_GENERIC_ME") {
    var_9 = "ping_pickup_riotshield";
  } else if(issubstr(var_6, "CONCUSSION") || issubstr(var_6, "DECOY") || issubstr(var_6, "FLASH") || issubstr(var_6, "GAS_BR") || issubstr(var_6, "HEARTBEAT") || issubstr(var_6, "SMOKE") || issubstr(var_6, "SNAPSHOT")) {
    var_9 = "ping_ammo_grenadetactical";
  } else if(issubstr(var_6, "ATMINE") || issubstr(var_6, "CLAYMORE") || issubstr(var_6, "C4") || issubstr(var_6, "FRAG") || issubstr(var_6, "SEMTEX") || issubstr(var_6, "THERMITE") || issubstr(var_6, "THROWING") || issubstr(var_6, "MOLOTOV")) {
    var_9 = "ping_ammo_grenadelethal";
  } else if(issubstr(var_6, "TACTICAL_COVER") || issubstr(var_6, "TROPHY") || issubstr(var_6, "RECONDRONE") || issubstr(var_6, "EMPDRONE") || issubstr(var_6, "DEADSILENCE") || issubstr(var_6, "AMMO_DROP") || issubstr(var_6, "SUPPORT_BOX") || issubstr(var_6, "TAC_INSERT") || issubstr(var_6, "ADVANCED_SUPPLY_DROP")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "RESPAWN_TOKEN") || issubstr(var_6, "LOOT_CACHE") || issubstr(var_6, "CONTRACT") || issubstr(var_6, "GASMASK")) {
    var_9 = "ping_pickup_generic";
  } else if(var_6 == "EQUIPMENT/ADRENALINE_BR" || var_6 == "MP_BR_INGAME/KIOSK_ITEM_SELF_REVIVE") {
    var_9 = "ping_pickup_health";
  } else if(var_6 == "KILLSTREAKS/MANUAL_TURRET") {
    var_9 = "ping_killstreaks_shieldturret_open";
  } else if(issubstr(var_6, "KILLSTREAK")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "_PLUNDER_EXTRACT")) {
    var_9 = "ping_plunder_bank";
  } else {}

  return var_9;
}

_id_2FA7(var_0) {
  var_1 = self;

  if(!isDefined(var_1)) {
    return;
  }
  _id_0B8D("Remove Callout ID Start: " + var_0);

  if(isDefined(var_0)) {
    if(var_0 == 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("ping", "calloutMarkerPing_squadLeaderBeaconKillForPlayer")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("ping", "calloutMarkerPing_squadLeaderBeaconKillForPlayer")]](var_1);
      }
    }

    var_1 _meth_8718(var_0);
    _id_0B8D("Remove Callout ID Notify: " + var_0);
    var_1 notify("predictiveCalloutClear_" + var_0);
  }
}

_id_2FB5(var_0) {
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + var_0);
  _id_0B8D("watchWhenMissionCompletes: " + var_0);
  self waittill("calloutmarkerping_warzoneKillQuestIcon");
  _id_2FA7(var_0);
}

_id_2FB2(var_0, var_1) {
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + var_0);
  _id_0B8D("Watch Entity Death or Enemy Disconnect: " + var_0);

  if(!isDefined(var_1)) {} else if(isPlayer(var_1))
    var_1 waittill("disconnect");
  else {
    var_1 waittill("death");
  }

  _id_2FA7(var_0);
}

_id_2FB3(var_0, var_1) {
  self endon("predictiveCalloutClear_" + var_0);
  _id_0B8D("watchPlayerDeathOrDisconnect: " + var_0);
  var_2 = _id_6ACA(var_1);
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "self_pickedupitem_" + var_2);
  _id_2FA7(var_0);
}

_id_2FB4(var_0, var_1) {
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + var_0);
  _id_0B8D("Watch scriptable death ID: " + var_0);

  if(!isDefined(var_1)) {} else if(var_1.type == "equip_fulton_mp") {
    var_2 = var_1._id_019B;

    if(!isDefined(var_2)) {
      return;
    }
    var_2 scripts\engine\utility::waittill_any_2("death", "fulton_takeoff");
  } else
    level scripts\engine\utility::waittill_any_3("pickedupweapon_kill_callout_" + var_1.type + var_1.origin, "lootcache_opened_kill_callout" + var_1.origin, "dropbag_kill_callout_" + var_1.origin);

  _id_0B8D("Watch scriptable death Remove ID: " + var_0);
  _id_2FA7(var_0);
}

_id_2F92(var_0) {
  var_1 = self;

  if(_id_0B8A(var_0)) {
    var_2 = var_1 _id_2F9D(var_0);

    if(istrue(var_2)) {
      var_3 = getdvarfloat("#x3363b9fe86c61b554", 120.0);
    } else {
      var_3 = getdvarfloat("#x3ad2116a1b5b89f9b", 30.0);
    }
  } else if(_id_0B89(var_0))
    var_3 = getdvarfloat("#x3bfdd10cba8248d7e", 60.0);
  else if(_id_0B88(var_0)) {
    var_3 = getdvarfloat("#x332c31a8f44b8c132", 15.0);
  } else if(var_0 == 6) {
    var_3 = getdvarfloat("#x3fdcd5007d38944cb", 60.0);
  } else if(!_id_0B91() && var_0 == -1) {
    var_3 = getdvarfloat("#x3c2464ee44125eb4e", 30.0);
  } else {
    switch (var_0) {
      case 0:
        var_3 = getdvarfloat("#x38c22e9a0fe5eb2d7", 120.0);
        break;
      case 5:
        var_3 = getdvarfloat("#x3d7a165abbeb703af", 120.0);
        break;
      default:
        var_3 = 2;
    }
  }

  return var_3;
}

_id_2FA0(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 _id_2FA6();
}

_id_2FB7(var_0, var_1) {
  var_2 = self;

  if(_id_0B8A(var_0)) {
    return var_1 + 500;
  } else if(_id_0B89(var_0)) {
    return var_1 + 500;
  } else if(_id_0B88(var_0)) {
    return var_1 + 500;
  } else if(var_0 == 6) {
    return var_1 + 500;
  } else if(!_id_0B91() && var_0 == -1) {
    return var_1 + 500;
  } else {
    switch (var_0) {
      case 0:
        return var_1 + 500;
      case 5:
        return var_1 + 500;
      default:
        break;
    }
  }
}

_id_2FC3(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_2FCA[var_0])) {
    return 0;
  }

  return 1;
}

_id_2FC2(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_5 = var_4._id_2FCA.size;

  if(var_5 > 10) {
    return 0;
  }

  var_6 = var_4 _id_2FB7(var_0, var_3);
  var_7 = var_6 + var_1;
  var_8 = spawnStruct();
  var_8._id_E060 = var_7;
  var_8._id_B9DA = var_0;
  var_8._id_315F = 0;
  var_4._id_2FCA[var_2] = var_8;
  return 1;
}

_id_2FB8(var_0, var_1, var_2) {
  var_3 = self;

  if(!isDefined(var_3) || !isPlayer(var_3)) {
    return 0;
  }

  var_4 = gettime();
  var_5 = "pool" + var_0;
  var_6 = var_3 _id_2FC3(var_5);

  if(var_6) {
    var_7 = var_3._id_2FCA[var_5]._id_E060;

    if(var_4 >= var_7) {
      var_8 = var_3 _id_2FC2(var_0, var_4, var_5, var_2);
      return istrue(var_8);
    }

    if(var_1 == "ping_response_cancel" && var_3._id_2FCA[var_5]._id_315F == 0) {
      var_3._id_2FCA[var_5]._id_315F = 1;
      return 1;
    }

    return 0;
  } else if(var_1 == "ping_response_cancel")
    return 0;
  else {
    var_8 = var_3 _id_2FC2(var_0, var_4, var_5, var_2);
    return istrue(var_8);
  }
}

_id_2FBA() {
  level endon("game_ended");

  for(;;) {
    wait 10;
    var_0 = gettime();

    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      var_2 = level.players[var_1];

      if(!isDefined(var_2) || !isDefined(var_2._id_2FCA)) {
        continue;
      }
      foreach(var_5, var_4 in var_2._id_2FCA) {
        if(var_0 > var_4._id_E060) {
          var_2._id_2FCA[var_5] = undefined;
        }
      }
    }
  }
}

_id_2FC1(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(var_0) {
    var_5 = _func_0142(var_1, 1);

    if(var_5 > var_4) {
      var_4 = var_5;
    }
  }

  if(var_2) {
    var_5 = _func_0142(var_3, 1);

    if(var_5 > var_4) {
      var_4 = var_5;
    }
  }

  return var_4;
}

_id_2F91() {
  return 0;
}

_id_2FA1(var_0, var_1) {
  return;
}

_id_2FBF(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_AC3D) || !isDefined(var_1._id_AC3D._id_10691)) {
    return;
  }
  var_2 = "mp_glob_" + var_1._id_AC3D._id_10691 + "_" + var_0;
  return var_2;
}

_id_2FC0(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_AC3D) || !isDefined(var_1._id_AC3D._id_10691)) {
    return;
  }
  var_2 = "mp_glob3d_" + var_1._id_AC3D._id_10691 + "_" + var_0;
  return var_2;
}

_id_2FC4(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(!isDefined(var_4) || !isPlayer(var_4)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_0) || var_0 == "") {
    return;
  }
  if(isPlayer(var_2)) {
    var_5 = var_2;
  } else {
    var_5 = var_4;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](var_5, var_0, undefined, undefined, var_3);
  }
}

_id_2F9F() {
  self endon("disconnect");
  self endon("predictiveCalloutClear_0");
  self notify("calloutMarkerPing_navigationCancelProximity");
  self endon("calloutMarkerPing_navigationCancelProximity");
  var_0 = getdvarfloat("#x38c22e9a0fe5eb2d7", 120.0);
  var_1 = getdvarint("#x333fc9e2b95d440d3", 10);
  wait(var_1);

  if(!self _meth_8790(0)) {
    return;
  }
  var_2 = self _meth_87A1(0);
  var_3 = getdvarint("#x3d38626629e2b8c7f", 47089);
  var_4 = getdvarint("#x34fc79f20535bc886", 1);
  var_5 = getdvarint("#x31f4ff28af3bfe83e", 1.0);

  for(;;) {
    if(var_4 == 1) {
      var_6 = distancesquared(self.origin, var_2);
    } else {
      var_6 = var_3;
      var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](self.team, 1);

      foreach(var_9 in var_7) {
        var_10 = distancesquared(var_9.origin, var_2);

        if(var_10 < var_6) {
          var_6 = var_10;
        }
      }
    }

    if(var_6 < var_3) {
      _id_2FA1("br_ping_cancel", 0);
      _id_2FA7(0);
      return;
    }

    wait(var_5);
  }
}

_id_2FA6() {
  var_0 = self;

  if(isDefined(var_0)) {
    for(var_1 = 0; var_1 < 9; var_1++) {
      var_0 _id_2FA7(var_1);
    }
  }
}

_id_2FA5(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    var_3 _id_2FA6();

    if(istrue(var_0)) {
      var_1++;

      if(var_1 % 10 == 0) {
        waitframe();
      }
    }
  }
}

_id_2FC8(var_0) {
  var_1 = self;
  var_1 notify("calloutMarkerPingVO_playPredictivePingCleared");
  var_1 endon("calloutMarkerPingVO_playPredictivePingCleared");
  var_1 _id_2FA1("br_ping_cancel", var_0);
  wait(getdvarfloat("#x39983b039063687f2", 0.5));

  if(isDefined(var_1)) {
    var_1 _id_2FC4("ping_response_cancel", var_0);
  }
}

_id_2FC6(var_0) {
  var_1 = self;
  var_1 _id_2FC8(var_0);
}

_id_2FC5(var_0, var_1) {
  var_2 = self;
  var_2 notify("calloutMarkerPingVO_playPredictivePingAcknowledged");
  var_2 endon("calloutMarkerPingVO_playPredictivePingAcknowledged");

  if(_id_0B8A(var_0)) {
    var_3 = "ping_dibs";
  } else if(_id_0B89(var_0)) {
    var_3 = "ping_response_affirm";
  } else if(_id_0B88(var_0)) {
    var_3 = "ping_response_copy";
  } else if(var_0 == 6) {
    var_3 = "ping_response_affirm";
  } else if(!_id_0B91() && var_0 == -1) {
    var_3 = "ping_dibs";
  } else {
    switch (var_0) {
      case 0:
        var_3 = "ping_response_affirm";
        break;
      case 5:
        var_3 = "ping_response_copy";
        break;
      default:
        var_3 = "ping_response_affirm";
        break;
    }
  }

  wait(getdvarfloat("#x39c1927e51a3c6066", 0.5));

  if(isPlayer(var_1)) {
    var_2 _id_2FC4(var_3, var_0, var_1);
  } else if(isDefined(var_2)) {
    var_2 _id_2FC4(var_3, var_0);
  }
}

_id_2FC7(var_0) {
  var_1 = self;
  var_1 notify("calloutMarkerPingVO_playPredictivePingAdded");
  var_1 endon("calloutMarkerPingVO_playPredictivePingAdded");
  var_1 endon("calloutMarkerPingVO_playPredictivePingCleared");
  var_1 endon("predictiveCalloutClear_" + var_0);
  wait(getdvarfloat("#x3ffd4532829f4e8c8", 0.5));

  if(isDefined(var_1)) {
    var_1 _id_2FB9(var_0);
  }
}

_id_2F9D(var_0) {
  var_1 = self;
  var_2 = var_1 _meth_8791(var_0);

  if(isDefined(var_2) && isDefined(var_2._id_EC8D)) {
    return 1;
  }

  return 0;
}

_id_2FA9(var_0, var_1) {
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + var_0);
  var_2 = 0.25;
  var_3 = 0;
  var_4 = self.team;

  for(;;) {
    var_5 = _id_0B90(var_0, var_1, var_4);

    if(var_5) {
      _id_2FA7(var_0);
      return;
    }

    var_6 = _id_0B86(var_1, var_4);

    if(var_6) {
      var_3 = var_3 + var_2;

      if(var_3 >= 3) {
        var_7 = var_1 _meth_8188();

        if(isDefined(var_7)) {
          thread _id_2F83(var_0, var_7);
        } else {
          _id_2FA7(var_0);
        }

        return;
      }
    }

    wait(var_2);
  }
}

_id_0B90(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = 0;
  var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var_2, 1);

  foreach(var_7 in var_5) {
    if(var_7 scripts\cp_mp\utility\player_utility::isinvehicle() && var_7.vehicle == var_1) {
      var_3 _meth_8719(var_0, var_7);
      var_4++;
    }
  }

  if(var_4 == var_5.size) {
    return 1;
  }

  return 0;
}

_id_0B86(var_0, var_1) {
  var_2 = isDefined(var_0._id_ADAE) && var_0._id_ADAE != var_1;
  var_3 = isDefined(var_0._id_881C) && var_0._id_881C == 0;

  if(var_3 && var_2) {
    return 1;
  }

  return 0;
}

_id_0B7F(var_0) {
  var_1 = self;
  var_1 notify("predictiveCalloutClear_" + var_0);
  var_1 thread _id_2FC8(var_0);
}

_id_0B7B(var_0, var_1) {
  var_2 = self;
  var_2 thread _id_0B8E(var_0);
  var_2 thread _id_2FC5(var_0, var_1);
}

_id_0B7C(var_0) {
  var_1 = self;
  var_1 thread _id_2FC6(var_0);
}

_id_0B7D(var_0) {
  var_1 = self;
  var_1 thread _id_0B8E(var_0);
  var_1 _id_0B7A(var_0);
  var_1 thread _id_2FC7(var_0);
  var_1 _id_0B87(var_0);
}

_id_0B80(var_0) {
  var_1 = self;
  var_1 thread _id_0B8E(var_0);
  var_1 _id_2FA1("br_ping_enemy", var_0);
}

_id_0B81() {
  var_0 = self;
  var_1 = _id_0B8B();

  if(var_1 != -1) {
    var_0 _id_2FA1("br_ping_cancel", var_1);
    var_0 _id_2FC4("ping_response_cancel", var_1);
  }

  var_0 _id_2FA6();
}

_id_0B7E(var_0) {
  var_1 = self;
  var_1 thread _id_2FAA(var_0);
}