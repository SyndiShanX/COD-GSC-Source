/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2d400da2610fe542.gsc
*************************************************/

#using script_2d9d24f7c63ac143;
#using script_744cad313ed0a87e;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\scriptable;
#using scripts\engine\scriptable_door;
#using scripts\engine\utility;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\hud_message;
#using scripts\mp\locksandkeys;
#using scripts\mp\pmc_missions;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\points;
#namespace namespace_9e69d66f68c38a10;

function init() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  precachestring(&"MP_DMZ_LOCKS/LOCKED_FORTRESS");
  precachestring(&"MP_DMZ_LOCKS/STUCK");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_TESTUNIQUEDOOR");
  precachestring(&"MP_DMZ_LOCKS/LOCKED");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_FORT_BARRACK1");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_ANTIQUITIES_OFFICE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_MUNITIONS_STORAGE");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_OFFICEQUARTERS1");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_OFFICEQUARTERS2");
  precachestring(&"MP_DMZ_LOCKS/LOCKED_QUIET_BEDROOM");
  precachestring(&"JUP_OB_ITEM_GENERICS/HUMAN_FORTRESS_LOCKED_ALLFORONE");
  precachestring(&"JUP_OB_ITEM_GENERICS/HUMAN_FORTRESS_LOCKED_CHEMIST");
  precachestring(&"JUP_OB_ITEM_GENERICS/HUMAN_FORTRESS_LOCKED_MAESTRO");
  precachestring(&"JUP_OB_ITEM_GENERICS/HUMAN_FORTRESS_LOCKED_RAINMAKER");
  precachestring(&"JUP_OB_ITEM_GENERICS/HUMAN_STRONGHOLD_LOCKED");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_FORTRESS");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_TESTUNIQUEDOOR");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_DOOR");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_DEADBOLT");
  precachestring(&"MP_DMZ_MISSIONS/TRAP_DOOR_UNLOCK");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_FORT_BARRACK1");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_ANTIQUITIES_OFFICE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_MUNITIONS_STORAGE");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_OFFICE_QUARTERS1");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_OFFICE_QUARTERS2");
  precachestring(&"MP_DMZ_LOCKS/UNLOCK_QUIET_BEDROOM");
  precachestring(&"JUP_OB_ITEM_GENERICS/UNLOCK_HUMAN_FORTRESS_ALLFORONE");
  precachestring(&"JUP_OB_ITEM_GENERICS/UNLOCK_HUMAN_FORTRESS_CHEMIST");
  precachestring(&"JUP_OB_ITEM_GENERICS/UNLOCK_HUMAN_FORTRESS_MAESTRO");
  precachestring(&"JUP_OB_ITEM_GENERICS/UNLOCK_HUMAN_FORTRESS_RAINMAKER");
  precachestring(&"JUP_OB_ITEM_GENERICS/UNLOCK_HUMAN_STRONGHOLD");
  precachestring(&"MP_DMZ_LOCKS/OB_S5_RIFT_RUN_TOWER_ROOF_LOCKED");
  precachestring(&"MP_DMZ_LOCKS/OB_S5_RIFT_RUN_TOWER_ROOF_UNLOCKED");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_lock", &function_2166c547b0d38235);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_lock_interior", &function_ee4e77bc15da5eae);
  scripts\engine\scriptable_door::function_29ba88e5ce21f3fd(&function_6416fb9a24d278b4);
  scripts\engine\scriptable_door::function_e37078f3d00ef312(&function_504f19b32802cb8d);
  scripts\engine\scriptable_door::function_87d7be37d61cbae3(&doorunlocked);
  function_20466dfc92ecf1a9();
  function_fad5181703a528ee();
  function_b35796a7c0a71079();

  if(getdvarint(@ "scr_disable_unique_doors", 0) != 1) {
    function_3e0f1ceeb525c408();
  }

  function_e6df49dda3f9a00e();
  function_af0108718cddff00();
  level.var_ab18903aa481fff2 = getnoentvolumearray("locked_space_volume", "script_noteworthy");

  level thread function_af458cfdaf8d86e4();
}

function function_fad5181703a528ee() {
  level.var_b33c035c483c2893 = [];
  level.var_b33c035c483c2893["onPickup"] = [];
  level.var_b33c035c483c2893["onDrop"] = [];
  level.var_b33c035c483c2893["onMatchStart"] = [];
  level.var_b33c035c483c2893["onExtract"] = [];
}

function function_36b1968bfe78916b(targetlootid) {
  backpacksize = scripts\cp_mp\loot\common_inventory::function_1b35b10884bd8d67();

  for(i = 0; i < backpacksize; i++) {
    currentlootid = scripts\cp_mp\loot\common_inventory::function_d870b2c45335bd88(i);

    if(currentlootid == targetlootid) {
      return true;
    }
  }

  return false;
}

function function_6416fb9a24d278b4(scriptable, player) {
  if(isDefined(scriptable.interiororigin) && isDefined(scriptable.node)) {
    if(distance2dsquared(scriptable.interiororigin, player.origin) < distance2dsquared(scriptable.node.origin, player.origin) && !isDefined(scriptable.var_707cd84a8924ef55)) {
      return &"MP_DMZ_LOCKS/UNLOCK_DEADBOLT";
    }
  }

  if(isDefined(scriptable.keyname) && isstring(scriptable.keyname)) {
    if(isDefined(level.var_a9e2544b9283299b)) {
      return &"MP_DMZ_LOCKS/LOCKED";
    }

    keylootid = scripts\cp_mp\utility\loot::getlootidfromref("loot_key_" + scriptable.keyname);

    if(isDefined(scriptable.activitykey) && isDefined(player.activitykey) && scriptable.activitykey == player.activitykey) {
      if(isDefined(scriptable.activitytype)) {
        return function_54f0ba9ac5666aba(scriptable.activitytype);
      } else {
        return function_54f0ba9ac5666aba(scriptable.keyname);
      }
    } else if(isDefined(keylootid) && player function_36b1968bfe78916b(keylootid)) {
      return function_54f0ba9ac5666aba(scriptable.keyname);
    } else {
      return function_94f5e3929619c3d1(scriptable.keyname);
    }
  }

  return &"MP_DMZ_LOCKS/LOCKED";
}

function function_e0e50ef00477deeb(scriptablename, player) {
  defaultlootid = scripts\cp_mp\utility\loot::getlootidfromref(scriptablename);

  if(isDefined(defaultlootid) && player function_36b1968bfe78916b(defaultlootid) && defaultlootid != 0) {
    return true;
  }

  usedlootid = scripts\cp_mp\utility\loot::getlootidfromref(scriptablename + "_used");

  if(isDefined(usedlootid) && player function_36b1968bfe78916b(usedlootid) && usedlootid != 0) {
    return true;
  }

  wornlootid = scripts\cp_mp\utility\loot::getlootidfromref(scriptablename + "_worn");

  if(isDefined(wornlootid) && player function_36b1968bfe78916b(wornlootid) && wornlootid != 0) {
    return true;
  }

  var_86d89d15a9c45615 = scripts\cp_mp\utility\loot::getlootidfromref(scriptablename + "_worn_jup");

  if(isDefined(var_86d89d15a9c45615) && player function_36b1968bfe78916b(var_86d89d15a9c45615) && var_86d89d15a9c45615 != 0) {
    return true;
  }

  return false;
}

function function_504f19b32802cb8d(scriptable, player, var_85e3240d30e184e7) {
  success = 0;
  deadbolt = 0;
  isvalidnode = isDefined(scriptable) && isDefined(scriptable.node);

  if(!istrue(isvalidnode)) {
    return 0;
  }

  if(distance2dsquared(scriptable.interiororigin, player.origin) < distance2dsquared(scriptable.node.origin, player.origin)) {
    success = 1;
    deadbolt = 1;
  }

  if(isDefined(scriptable.var_707cd84a8924ef55)) {
    success = 0;
    deadbolt = 0;
  }

  if(isDefined(scriptable.keyname) && isstring(scriptable.keyname)) {
    if(scriptable.keyname == "TESTUNIQUEDOOR") {
      success = 1;
    }

    keyname = scriptable.keyname;
    var_6f3309b71ae22d94 = isDefined(scriptable.node.script_noteworthy) && (scriptable.node.script_noteworthy == "lockMe_interior" || scriptable.node.script_noteworthy == "lockme_interior");

    if(istrue(var_6f3309b71ae22d94)) {
      keyname = scriptable.keyname + "_interior";
    }

    if(function_e0e50ef00477deeb("loot_key_" + keyname, player)) {
      success = 1;
    } else if(isDefined(scriptable.fortress) && scripts\mp\gametypes\activity_manager::function_a2dcdcd112310e33(player.team, scriptable.fortress) && scriptable.keyname == "fortress") {
      success = 1;
    }

    var_6dd4fa9f46b16ce = isDefined(scriptable.fortress) && isDefined(scriptable.fortress.name) && istrue(level.var_be265257b0c58303);

    if(!istrue(deadbolt) && !istrue(var_6f3309b71ae22d94) && var_6dd4fa9f46b16ce) {
      tier = scriptable.fortress namespace_bd614c3c2275579a::function_b7a9796c95aa8e8d();

      if(isDefined(tier) && tier == "black") {
        success = function_ed2cf116dda82611(player, scriptable.fortress.tierkeys, "loot_multi_key_fortress", level.var_ccbb1eb445b88cc0);
      }
    }
  }

  if(isDefined(scriptable.activitykey) && isDefined(player.activitykey) && scriptable.activitykey == player.activitykey) {
    success = 1;
  }

  if(istrue(var_85e3240d30e184e7)) {
    if(!success) {
      playsoundatpos(scriptable.node.origin, "mp_door_locked");
    } else if(istrue(deadbolt)) {
      playsoundatpos(scriptable.node.origin, "mp_door_unlock_deadbolt");
    } else {
      unlocksoundalias = "mp_door_unlock_key";

      if(isDefined(scriptable.var_1166203281bb91a5)) {
        unlocksoundalias = scriptable.var_1166203281bb91a5;
      }

      playsoundatpos(scriptable.node.origin, unlocksoundalias);
    }
  }

  return success;
}

function function_87997fcee4a6e14c(scriptable, unlocker) {
  var_7ecbd4f07f6882d0 = getdvarint(@ "hash_291ad74097993a0a", 1) == 1;
  var_ba03253452037335 = 0;
  isstronghold = 0;
  var_f2075bd612ae5ab7 = 0;
  players = [];
  players[players.size] = unlocker;

  if(issharedfuncdefined("squad_utility", "getSquadMembers")) {
    players = unlocker[[getsharedfunc("squad_utility", "getSquadMembers")]]();
  }

  if(isDefined(scriptable.fortress)) {
    isstronghold = !istrue(scriptable.fortress.ishero);
    var_f2075bd612ae5ab7 = istrue(scriptable.fortress.ishero);

    if(isDefined(scriptable.fortress.unlockedby)) {
      if(!var_7ecbd4f07f6882d0) {
        var_243d9ea347100ef1 = 0;

        foreach(player in players) {
          if(array_contains(scriptable.fortress.unlockedby, player)) {
            var_243d9ea347100ef1 = 1;
            break;
          }
        }

        if(!var_243d9ea347100ef1) {
          scriptable.fortress.unlockedby = array_combine_unique(scriptable.fortress.unlockedby, players);
          var_ba03253452037335 = 1;
        }
      }
    } else {
      scriptable.fortress.unlockedby = [];
      scriptable.fortress.unlockedby = array_combine_unique(scriptable.fortress.unlockedby, players);
      var_ba03253452037335 = 1;
    }
  } else {
    var_ba03253452037335 = 1;
  }

  if(!var_ba03253452037335) {
    return;
  }

  foreach(player in players) {
    if(!isDefined(player.doorsunlocked)) {
      player.doorsunlocked = 0;
    }

    player.doorsunlocked++;

    if(var_f2075bd612ae5ab7) {
      player scripts\mp\utility\points::doscoreevent(#"hash_f3613beae4483db1");
      continue;
    }

    if(isstronghold) {
      player scripts\mp\utility\points::doscoreevent(#"hash_584786512b068a29");
      continue;
    }

    player scripts\mp\utility\points::doscoreevent(#"hash_6c63c18261a7af97");
  }
}

function function_7d321a63bc56c65c(rootkeyname, player) {
  var_86d89d15a9c45615 = scripts\cp_mp\utility\loot::getlootidfromref(rootkeyname + "_worn_jup");

  if(isDefined(var_86d89d15a9c45615) && player function_36b1968bfe78916b(var_86d89d15a9c45615) && var_86d89d15a9c45615 != 0) {
    return [rootkeyname + "_worn_jup", 2];
  }

  wornlootid = scripts\cp_mp\utility\loot::getlootidfromref(rootkeyname + "_worn");

  if(isDefined(wornlootid) && player function_36b1968bfe78916b(wornlootid) && wornlootid != 0) {
    return [rootkeyname + "_worn", 2];
  }

  usedlootid = scripts\cp_mp\utility\loot::getlootidfromref(rootkeyname + "_used");

  if(isDefined(usedlootid) && player function_36b1968bfe78916b(usedlootid) && usedlootid != 0) {
    return [rootkeyname + "_used", 1];
  }

  defaultlootid = scripts\cp_mp\utility\loot::getlootidfromref(rootkeyname);

  if(isDefined(defaultlootid) && player function_36b1968bfe78916b(defaultlootid) && defaultlootid != 0) {
    return [rootkeyname, 0];
  }

  return [undefined, undefined];
}

function doorunlocked(scriptable, player) {
  if(isDefined(scriptable.connecteddoor)) {
    scriptable.connecteddoor scriptabledoorfreeze(0);
  }

  if(isDefined(scriptable.var_def557e8fd5c6763)) {
    scriptable thread[[scriptable.var_def557e8fd5c6763]](scriptable, player);
  }

  if(distance2dsquared(scriptable.interiororigin, player.origin) > distance2dsquared(scriptable.node.origin, player.origin) || isDefined(scriptable.var_707cd84a8924ef55)) {
    player thread function_83f5cdc3d883507e(scriptable, player);
  }
}

function function_83f5cdc3d883507e(scriptable, player) {
  player endon("death_or_disconnect");

  if(function_9ad38344b87727f4(scriptable)) {
    [scriptablename, keylevel] = function_7d321a63bc56c65c("loot_key_" + scriptable.keyname, player);

    if(isDefined(scriptablename) && isDefined(keylevel)) {
      keylootid = scripts\cp_mp\utility\loot::getlootidfromref(scriptablename);
      var_cf5bc3d609317cc3 = function_ed1aea6648bcdc28("loot_key_" + scriptable.keyname, keylevel);

      if(!isDefined(var_cf5bc3d609317cc3)) {
        soundorigin = scriptable.origin;
        wait 1;
        playsoundatpos(soundorigin, "mp_door_key_break");
        player scripts\cp_mp\loot\common_inventory::function_181a584e4a68d5d6(keylootid);
      } else {
        index = player scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a(keylootid);
        player scripts\cp_mp\loot\common_inventory::function_ca3bbb1070436540(index, var_cf5bc3d609317cc3, 1);
      }

      function_87997fcee4a6e14c(scriptable, player);
    }
  }

  if(!function_9ad38344b87727f4(scriptable)) {
    function_87997fcee4a6e14c(scriptable, player);
  }
}

function private function_9ad38344b87727f4(scriptable) {
  if(isDefined(scriptable.keyname) && isstring(scriptable.keyname)) {
    return (!issubstr(scriptable.keyname, "fortress") && !issubstr(scriptable.keyname, "human_stronghold"));
  }

  return false;
}

function function_ed2cf116dda82611(player, numkeys, keyname, teamkeys) {
  keylootid = scripts\cp_mp\utility\loot::getlootidfromref(keyname);
  keycount = 0;

  if(!isDefined(numkeys)) {
    return false;
  }

  if(istrue(teamkeys)) {
    keycount = player namespace_aead94004cf4c147::function_ef5c7ec55e0e20ee(keylootid);
  } else {
    keycount = player namespace_aead94004cf4c147::getbackpackitemcount(keylootid);
  }

  if(!isDefined(keycount)) {
    return false;
  }

  if(keycount >= numkeys) {
    return true;
  }

  return false;
}

function function_830809e6920e8bed(category, keyname, callback) {
  level.var_b33c035c483c2893[category][keyname] = callback;
}

function function_1a037d5cd64dc892() {
  if(isDefined(level.uniquedoors)) {
    return;
  }

  level.uniquedoors = [];
  keys = getarraykeys(level.struct_class_names["script_noteworthy"]);

  foreach(key in keys) {
    if(issubstr(tolower(key), "uniquedoor")) {
      foreach(node in level.struct_class_names["script_noteworthy"][key]) {
        level.uniquedoors = scripts\mp\locksandkeys::function_ad1b6accbaab404e(node, level.uniquedoors, getsubstr(key, 11), 1);
      }
    }
  }
}

function private function_3e0f1ceeb525c408() {
  function_1a037d5cd64dc892();

  foreach(door in level.uniquedoors) {
    if(istrue(door.doubledoor)) {
      door scriptabledoorfreeze(1);
      continue;
    }

    function_fbbfe6f05eda5eb1(door);
  }
}

function function_fbbfe6f05eda5eb1(door) {
  door function_9af4c9b2cc1bf989(1);
}

function function_b092780f9ec4496e(door) {
  door function_80902296b05be00a();

  if(isDefined(door.connecteddoor)) {
    door.connecteddoor function_80902296b05be00a();
  }
}

function function_4327a2c68eef5db9(struct) {
  if(isDefined(struct.target)) {
    doors = getentitylessscriptablearray(struct.target, "targetname");
    return doors;
  }
}

function function_2166c547b0d38235(instance, part, state, player, bautouse, usestring) {
  level thread function_a95d35e420c6a968(instance, part, state, player, bautouse);
}

function function_a95d35e420c6a968(instance, part, state, player, bautouse) {
  instance setscriptablepartstate("maphint_lock", "off");
  playsoundatpos(instance.origin, "emt_bunk_red_button_press");

  if(getdvarint(@ "hash_5556498dffa596fb", 0) == 1 || player function_36b1968bfe78916b(instance.keylootid)) {
    playsoundatpos(instance.origin, "br_keypad_confirm");
    function_b092780f9ec4496e(instance.door);
    instance.interiorhint setscriptablepartstate("maphint_lock_interior", "off");

    if(isDefined(instance.door.var_def557e8fd5c6763)) {
      [[instance.door.var_def557e8fd5c6763]](instance.door, player);
    }

    return;
  }

  wait 1;
  instance setscriptablepartstate("maphint_lock", instance.keyname);
}

function function_ee4e77bc15da5eae(instance, part, state, player, bautouse, usestring) {
  level thread function_44017cc8b84b87ad(instance, part, state, player, bautouse);
}

function function_44017cc8b84b87ad(instance, part, state, player, bautouse) {
  instance setscriptablepartstate("maphint_lock_interior", "off");
  playsoundatpos(instance.origin, "emt_bunk_red_button_press");
  wait 1;
  playsoundatpos(instance.origin, "br_keypad_confirm");
  function_b092780f9ec4496e(instance.door);
  instance.exteriorhint setscriptablepartstate("maphint_lock", "off");

  if(isDefined(instance.door.var_def557e8fd5c6763)) {
    [[instance.door.var_def557e8fd5c6763]](instance.door, player);
  }
}

function function_ad1b6accbaab404e(node, var_fa9e859ca98dcdbf, keyname, highpriority, var_901235f450b4cb24, var_d23fa479e1b4cae, overridesearchradius, var_46f10c379a78132a) {
  index = var_fa9e859ca98dcdbf.size;
  var_aa298d1ea65e8d98 = 75;
  var_6656dfa185b09b6f = 75;

  if(isDefined(overridesearchradius)) {
    var_aa298d1ea65e8d98 = overridesearchradius;
  }

  if(isDefined(var_46f10c379a78132a)) {
    var_6656dfa185b09b6f = var_46f10c379a78132a;
  }

  doors = function_c8805ad506766965(node.origin, var_aa298d1ea65e8d98, var_6656dfa185b09b6f, var_d23fa479e1b4cae);
  var_ce94cc5fd99b7443 = 0;
  var_ae34753d57919512 = 0;
  var_c9d7eee1305250e8 = isDefined(var_901235f450b4cb24);

  foreach(door in doors) {
    if(isDefined(door.type) && issubstr(door.type, "invisible")) {
      var_ce94cc5fd99b7443 = 1;

      if(istrue(var_c9d7eee1305250e8)) {
        if(issubstr(door.type, var_901235f450b4cb24)) {
          var_ae34753d57919512 = 1;
        }

        continue;
      }

      break;
    }
  }

  if(var_ce94cc5fd99b7443) {
    var_be7b958fdbf091c0 = [];

    foreach(door in doors) {
      if(isDefined(door.type) && issubstr(door.type, "invisible")) {
        if(istrue(var_c9d7eee1305250e8) && !istrue(var_ae34753d57919512)) {
          continue;
        } else if(istrue(var_ae34753d57919512) && issubstr(door.type, var_901235f450b4cb24)) {
          door.var_413588fb9a3b4c94 = 1;
          door setscriptablepartstate("door", "closed");
          var_be7b958fdbf091c0[var_be7b958fdbf091c0.size] = door;
        } else if(!istrue(var_c9d7eee1305250e8)) {
          door setscriptablepartstate("door", "closed");
          var_be7b958fdbf091c0[var_be7b958fdbf091c0.size] = door;
        }

        continue;
      }

      if(istrue(var_c9d7eee1305250e8) && !istrue(var_ae34753d57919512)) {
        var_be7b958fdbf091c0[var_be7b958fdbf091c0.size] = door;
        continue;
      }

      door setscriptablepartstate("door", "invisible");
    }

    doors = var_be7b958fdbf091c0;
  }

  if(doors.size == 2) {
    doors[0].connecteddoor = doors[1];
    doors[1].doubledoor = 1;

    if(getdvarint(@ "hash_9c3d7b7ac76a359c", 0) == 1) {
      thread scripts\mp\utility\debug::drawsphere(node.origin, var_aa298d1ea65e8d98, 900, (0, 1, 0));
      thread scripts\mp\utility\debug::drawline(node.origin, doors[0].origin, 900, (0, 1, 0));
      thread scripts\mp\utility\debug::drawline(node.origin, doors[1].origin, 900, (0, 0, 1));
    }
  }

  if(doors.size > 2) {
    println("<dev string:x1c>" + node.origin + "<dev string:x7a>" + doors.size + "<dev string:x8d>" + var_aa298d1ea65e8d98 + "<dev string:xa1>" + var_6656dfa185b09b6f);
  }

  if(isDefined(doors)) {
    foreach(door in doors) {
      if(isDefined(door)) {
        if(getdvarint(@ "hash_9c3d7b7ac76a359c", 0) == 1) {
          thread scripts\mp\utility\debug::drawsphere(door.origin, 2.5, 900, (0, 0, 0));
        }

        if(istrue(door.var_67535222a761bdc5) && !istrue(highpriority)) {
          println("<dev string:xb5>" + door.origin);
          continue;
        }

        var_fa9e859ca98dcdbf[index] = door;
        var_fa9e859ca98dcdbf[index].keyname = keyname;
        var_fa9e859ca98dcdbf[index].var_9ccea499f9e1b693 = node.origin;
        var_fa9e859ca98dcdbf[index].node = node;

        if(istrue(highpriority)) {
          var_fa9e859ca98dcdbf[index].var_67535222a761bdc5 = 1;
        }

        forward = anglesToForward(default_to(node.angles, (0, 0, 0)));
        var_fa9e859ca98dcdbf[index].interiororigin = door.var_9ccea499f9e1b693 - forward * 25;
        var_fa9e859ca98dcdbf[index].outerorigin = door.var_9ccea499f9e1b693 + forward * 60;

        if(getdvarint(@ "hash_9c3d7b7ac76a359c", 0) == 1) {
          thread scripts\mp\utility\debug::drawline(node.origin, var_fa9e859ca98dcdbf[index].interiororigin, 300, (1, 0, 0));
        }
      }

      index++;
    }
  }

  return var_fa9e859ca98dcdbf;
}

function function_c8805ad506766965(position, radius, maxheightdiff, doors) {
  if(!isDefined(doors)) {
    doors = getentitylessscriptablearray(undefined, undefined, position, radius, "door");
  }

  filtereddoors = [];

  foreach(door in doors) {
    if(!door scriptableisdoor()) {
      continue;
    }

    if(distance2dsquared(door.origin, position) < radius * radius) {
      if(isDefined(maxheightdiff)) {
        heightdiff = abs(door.origin[2] - position[2]);

        if(heightdiff <= maxheightdiff) {
          filtereddoors[filtereddoors.size] = door;
        }

        continue;
      }

      filtereddoors[filtereddoors.size] = door;
    }
  }

  return filtereddoors;
}

function function_e6df49dda3f9a00e() {
  level.uniqueblockers = [];
  keys = getarraykeys(level.struct_class_names["targetname"]);

  foreach(key in keys) {
    if(issubstr(key, "uniqueBlocker")) {
      foreach(node in level.struct_class_names["targetname"][key]) {
        if(isDefined(node.script_noteworthy)) {
          level.uniqueblockers[level.uniqueblockers.size] = node;
        }
      }
    }
  }
}

function function_af0108718cddff00() {
  foreach(node in level.uniqueblockers) {
    scriptable = spawnscriptable("fortress_scriptable_props", node.origin, node.angles);
    scriptable setscriptablepartstate("scriptable_prop", node.script_noteworthy);
  }
}

function function_20466dfc92ecf1a9() {
  level.doorstrings = [];
  level.doorstrings["locked_no_key"] = [];
  level.doorstrings["locked_has_key"] = [];
  level.doorstrings["open"] = [];
  level.doorstrings["locked_no_key"]["fortress"] = &"MP_DMZ_LOCKS/LOCKED_FORTRESS";
  level.doorstrings["locked_no_key"]["stuck"] = &"MP_DMZ_LOCKS/STUCK";
  level.doorstrings["locked_no_key"]["testuniquedoor"] = &"MP_DMZ_LOCKS/LOCKED_TESTUNIQUEDOOR";
  level.doorstrings["locked_no_key"]["quarry_storage"] = &"MP_DMZ_LOCKS/LOCKED_QUARRY_STORAGE";
  level.doorstrings["locked_no_key"]["quarry_control"] = &"MP_DMZ_LOCKS/LOCKED_QUARRY_CONTROL";
  level.doorstrings["locked_no_key"]["quarry_office"] = &"MP_DMZ_LOCKS/LOCKED_QUARRY_OFFICE";
  level.doorstrings["locked_no_key"]["hydro_storage"] = &"MP_DMZ_LOCKS/LOCKED_HYDRO_STORAGE";
  level.doorstrings["locked_no_key"]["hydro_apt"] = &"MP_DMZ_LOCKS/LOCKED_HYDRO_APT";
  level.doorstrings["locked_no_key"]["hydro_weapondrop"] = &"MP_DMZ_LOCKS/LOCKED_HYDRO_WEAPONDROP";
  level.doorstrings["locked_no_key"]["hostage_door"] = &"MP_DMZ_MISSIONS/LOCKED_HOSTAGE_DOOR";
  level.doorstrings["locked_no_key"]["trap"] = &"MP_DMZ_LOCKS/LOCKED_FORTRESS";
  level.doorstrings["locked_no_key"]["trapper_door"] = &"MP_DMZ_LOCKS/LOCKED_TRAPPER_DOOR";
  level.doorstrings["locked_no_key"]["resort_entrance"] = &"MP_DMZ_LOCKS/LOCKED_RESORT_ENTRANCE";
  level.doorstrings["locked_no_key"]["firefighttest01"] = &"MP_DMZ_LOCKS/LOCKED_FIREFIGHTTEST01";
  level.doorstrings["locked_no_key"]["biolab_door"] = &"MP_DMZ_LOCKS/LOCKED";
  level.doorstrings["locked_no_key"]["high_security"] = &"MP_BIO_LAB/CACHE_LOCKED_SECURITY_ROOM";
  level.doorstrings["locked_no_key"]["third_floor"] = &"MP_BIO_LAB/CACHE_LOCKED_SECURITY_ROOM";
  level.doorstrings["locked_no_key"]["red_door"] = &"MP_BIO_LAB/CACHE_LOCKED_RED_DOOR";
  level.doorstrings["locked_no_key"]["blue_door"] = &"MP_BIO_LAB/CACHE_LOCKED_BLUE_DOOR";
  level.doorstrings["locked_no_key"]["green_door"] = &"MP_BIO_LAB/CACHE_LOCKED_GREEN_DOOR";
  level.doorstrings["locked_no_key"]["black_door"] = &"MP_BIO_LAB/CACHE_LOCKED_BLACK_DOOR";
  level.doorstrings["locked_no_key"]["gold_door"] = &"MP_BIO_LAB/CACHE_LOCKED_GOLD_DOOR";
  level.doorstrings["locked_no_key"]["armory_room"] = &"MP_BIO_LAB/CACHE_LOCKED_ARMORY_ROOM";
  level.doorstrings["locked_no_key"]["conference_room"] = &"MP_DMZ_LOCKS/LOCKED_CONFERENCE_ROOM";
  level.doorstrings["locked_no_key"]["maintenance"] = &"MP_DMZ_LOCKS/LOCKED_AIRPORT_MAINTENANCE";
  level.doorstrings["locked_no_key"]["undershack"] = &"MP_DMZ_LOCKS/LOCKED_UNDERGROUND_SHACK";
  level.doorstrings["locked_no_key"]["cliffroom"] = &"MP_DMZ_LOCKS/LOCKED_CLIFF_ROOM";
  level.doorstrings["locked_no_key"]["gravehouse"] = &"MP_DMZ_LOCKS/LOCKED_GRAVEYARD_HOUSE";
  level.doorstrings["locked_no_key"]["poppyhome"] = &"MP_DMZ_LOCKS/LOCKED_POPPY_HOME";
  level.doorstrings["locked_no_key"]["western_storage"] = &"MP_DMZ_LOCKS/LOCKED_WESTERN_STORAGE";
  level.doorstrings["locked_no_key"]["mobile_office"] = &"MP_DMZ_LOCKS/LOCKED_MOBILE_OFFICE";
  level.doorstrings["locked_no_key"]["crane_building"] = &"MP_DMZ_LOCKS/LOCKED_CRANE_BUILDING";
  level.doorstrings["locked_no_key"]["policestation"] = &"MP_DMZ_LOCKS/LOCKED_POLICE_LOCKERROOM";
  level.doorstrings["locked_no_key"]["smugglers_warehouse"] = &"MP_DMZ_LOCKS/LOCKED_SMUGGLERS_WAREHOUSE";
  level.doorstrings["locked_no_key"]["power_substation"] = &"MP_DMZ_LOCKS/LOCKED_POWER_SUBSTATION";
  level.doorstrings["locked_no_key"]["cell_phone_shop"] = &"MP_DMZ_LOCKS/LOCKED_CELL_PHONE_SHOP";
  level.doorstrings["locked_no_key"]["police_academy_barracks"] = &"MP_DMZ_LOCKS/LOCKED_POLICE_ACADEMY_BARRACKS";
  level.doorstrings["locked_no_key"]["police_lockerroom"] = &"MP_DMZ_LOCKS/LOCKED_POLICE_ACADEMY_LOCKERROOM";
  level.doorstrings["locked_no_key"]["post_office"] = &"MP_DMZ_LOCKS/LOCKED_POST_OFFICE";
  level.doorstrings["locked_no_key"]["tv_station"] = &"MP_DMZ_LOCKS/LOCKED_TV_STATION";
  level.doorstrings["locked_no_key"]["shopping_booth"] = &"MP_DMZ_LOCKS/LOCKED_SHOPPING_BOOTH";
  level.doorstrings["locked_no_key"]["apartment_closet"] = &"MP_DMZ_LOCKS/LOCKED_APARTMENT_CLOSET";
  level.doorstrings["locked_no_key"]["north_guard_shack"] = &"MP_DMZ_LOCKS/LOCKED_NORTH_GUARD_SHACK";
  level.doorstrings["locked_no_key"]["south_guard_shack"] = &"MP_DMZ_LOCKS/LOCKED_SOUTH_GUARD_SHACK";
  level.doorstrings["locked_no_key"]["fortbarrack1_rr"] = &"MP_DMZ_LOCKS/LOCKED_FORT_BARRACK1";
  level.doorstrings["locked_no_key"]["antiquities_office_rr"] = &"MP_DMZ_LOCKS/LOCKED_ANTIQUITIES_OFFICE";
  level.doorstrings["locked_no_key"]["munitions_storage_rr"] = &"MP_DMZ_LOCKS/LOCKED_MUNITIONS_STORAGE";
  level.doorstrings["locked_no_key"]["office_quarters1_rr"] = &"MP_DMZ_LOCKS/LOCKED_OFFICEQUARTERS1";
  level.doorstrings["locked_no_key"]["office_quarters2"] = &"MP_DMZ_LOCKS/LOCKED_OFFICEQUARTERS2";
  level.doorstrings["locked_no_key"]["quiet_bedroom_rr"] = &"MP_DMZ_LOCKS/LOCKED_QUIET_BEDROOM";
  level.doorstrings["locked_no_key"]["car_shop"] = &"MP_DMZ_LOCKS/LOCKED_AUTO_SHOP_SUNKEN";
  level.doorstrings["locked_no_key"]["server_room"] = &"MP_DMZ_LOCKS/LOCKED_SERVER_ROOM";
  level.doorstrings["locked_no_key"]["sunken_top_office"] = &"MP_DMZ_LOCKS/LOCKED_SUNKEN_OFFICE";
  level.doorstrings["locked_no_key"]["sunken_2nd_office"] = &"MP_DMZ_LOCKS/LOCKED_SUNKEN_SECOND_OFFICE";
  level.doorstrings["locked_no_key"]["hotel_room1"] = &"MP_DMZ_LOCKS/LOCKED_HOTEL_ROOM1";
  level.doorstrings["locked_no_key"]["hotel_room2"] = &"MP_DMZ_LOCKS/LOCKED_HOTEL_ROOM2";
  level.doorstrings["locked_no_key"]["dressing_room"] = &"MP_DMZ_LOCKS/LOCKED_DRESSING_ROOM";
  level.doorstrings["locked_no_key"]["sec_camera_room"] = &"MP_DMZ_LOCKS/LOCKED_SEC_CAMERA_ROOM";
  level.doorstrings["locked_no_key"]["gaming_room"] = &"MP_DMZ_LOCKS/LOCKED_GAMING_ROOM";
  level.doorstrings["locked_no_key"]["fishing_shack"] = &"MP_DMZ_LOCKS/LOCKED_FISH_SHACK";
  level.doorstrings["locked_no_key"]["mountain_top"] = &"MP_DMZ_LOCKS/LOCKED_MOUNTAIN_TOP_ROOM";
  level.doorstrings["locked_no_key"]["spotters_view"] = &"MP_DMZ_LOCKS/LOCKED_SPOTTERS_VIEW";
  level.doorstrings["locked_no_key"]["grocery_office"] = &"MP_DMZ_LOCKS/LOCKED_GROCERY_OFFICE";
  level.doorstrings["locked_no_key"]["neigh_storage_room"] = &"MP_DMZ_LOCKS/LOCKED_NEIGH_STORAGE_ROOM";
  level.doorstrings["locked_no_key"]["apartment_closet"] = &"MP_DMZ_LOCKS/LOCKED_APARTMENT_CLOSET";
  level.doorstrings["locked_no_key"]["apartment_snipernest"] = &"MP_DMZ_LOCKS/LOCKED_APARTMENT_SNIPERNEST";
  level.doorstrings["locked_no_key"]["destroyed_telescope"] = &"MP_DMZ_LOCKS/LOCKED_DESTROYED_TELESCOPE";
  level.doorstrings["locked_no_key"]["groundskeepers"] = &"MP_DMZ_LOCKS/LOCKED_GROUNDSKEEPERS";
  level.doorstrings["locked_no_key"]["lighthouse_room"] = &"MP_DMZ_LOCKS/LOCKED_LIGHTHOUSE_ROOM";
  level.doorstrings["locked_no_key"]["safe_house"] = &"MP_DMZ_LOCKS/LOCKED_SAFE_ROOM";
  level.doorstrings["locked_no_key"]["scientist_apartment"] = &"MP_DMZ_LOCKS/LOCKED_SCIENTIST_APARTMENT";
  level.doorstrings["locked_no_key"]["secret_comms"] = &"MP_DMZ_LOCKS/LOCKED_SECRET_COMMS";
  level.doorstrings["locked_no_key"]["shopping_booth"] = &"MP_DMZ_LOCKS/LOCKED_SHOPPING_BOOTH";
  level.doorstrings["locked_no_key"]["sira_apartment"] = &"MP_DMZ_LOCKS/LOCKED_SIRA_APARTMENT";
  level.doorstrings["locked_no_key"]["small_confer_room"] = &"MP_DMZ_LOCKS/LOCKED_SMALL_CONFER_ROOM";
  level.doorstrings["locked_no_key"]["supply_rooms"] = &"MP_DMZ_LOCKS/LOCKED_SUPPLY_ROOM";
  level.doorstrings["locked_no_key"]["tv_computer_room"] = &"MP_DMZ_LOCKS/LOCKED_TV_COMPUTER_ROOM";
  level.doorstrings["locked_no_key"]["yumyum_burger"] = &"MP_DMZ_LOCKS/LOCKED_YUM_BURGER";
  level.doorstrings["locked_no_key"]["interrogation_room"] = &"MP_DMZ_LOCKS/LOCKED_INTERROGATION_ROOM";
  level.doorstrings["locked_no_key"]["control_tower"] = &"MP_DMZ_LOCKS/LOCKED_CONTROL_TOWER";
  level.doorstrings["locked_no_key"]["civic_center"] = &"MP_DMZ_LOCKS/LOCKED_CIVIC_CENTER";
  level.doorstrings["locked_no_key"]["sira_mall"] = &"MP_DMZ_LOCKS/LOCKED_SIRA_MALL";
  level.doorstrings["locked_no_key"]["fort"] = &"MP_DMZ_LOCKS/LOCKED_FORT";
  level.doorstrings["locked_no_key"]["exhume_warehouse"] = &"MP_DMZ_LOCKS/LOCKED_EXHUME_WAREHOUSE";
  level.doorstrings["locked_no_key"]["post_office_stronghold"] = &"MP_DMZ_LOCKS/LOCKED_POST_OFFICE_STRONGHOLD";
  level.doorstrings["locked_no_key"]["police_academy"] = &"MP_DMZ_LOCKS/LOCKED_POLICE_ACADEMY";
  level.doorstrings["locked_no_key"]["embassy"] = &"MP_DMZ_LOCKS/LOCKED_EMBASSY";
  level.doorstrings["locked_no_key"]["blacksite"] = &"MP_DMZ_LOCKS/LOCKED_BLACKSITE";
  level.doorstrings["locked_no_key"]["br_fortress"] = &"MP_DMZ_LOCKS/LOCKED_BR_FORTRESS";
  level.doorstrings["locked_no_key"]["human_fortress_rainmaker"] = &"JUP_OB_ITEM_GENERICS/HUMAN_FORTRESS_LOCKED_RAINMAKER";
  level.doorstrings["locked_no_key"]["human_fortress_maestro"] = &"JUP_OB_ITEM_GENERICS/HUMAN_FORTRESS_LOCKED_MAESTRO";
  level.doorstrings["locked_no_key"]["human_fortress_chemist"] = &"JUP_OB_ITEM_GENERICS/HUMAN_FORTRESS_LOCKED_CHEMIST";
  level.doorstrings["locked_no_key"]["human_fortress_allforone"] = &"JUP_OB_ITEM_GENERICS/HUMAN_FORTRESS_LOCKED_ALLFORONE";
  level.doorstrings["locked_no_key"]["human_stronghold"] = &"JUP_OB_ITEM_GENERICS/HUMAN_STRONGHOLD_LOCKED";
  level.doorstrings["locked_no_key"]["vault"] = &"JUP_OB_OBJECTIVES/VAULT_LOCKED";
  level.doorstrings["locked_no_key"]["military_fob"] = &"MP_JUP_BIGMAP_LOCKS/MILITARY_FOB_LOCKED";
  level.doorstrings["locked_no_key"]["tower_roof"] = &"MP_DMZ_LOCKS/OB_S5_RIFT_RUN_TOWER_ROOF_LOCKED";
  level.doorstrings["locked_no_key"]["tower_breakroom"] = &"MP_DMZ_LOCKS/OB_S5_RIFT_RUN_TOWER_ROOF_LOCKED";
  level.doorstrings["locked_has_key"]["stuck"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level.doorstrings["locked_has_key"]["fortress"] = &"MP_DMZ_LOCKS/UNLOCK_FORTRESS";
  level.doorstrings["locked_has_key"]["testuniquedoor"] = &"MP_DMZ_LOCKS/UNLOCK_TESTUNIQUEDOOR";
  level.doorstrings["locked_has_key"]["quarry_storage"] = &"MP_DMZ_LOCKS/UNLOCK_QUARRY_STORAGE";
  level.doorstrings["locked_has_key"]["quarry_control"] = &"MP_DMZ_LOCKS/UNLOCK_QUARRY_CONTROL";
  level.doorstrings["locked_has_key"]["quarry_office"] = &"MP_DMZ_LOCKS/UNLOCK_QUARRY_OFFICE";
  level.doorstrings["locked_has_key"]["hydro_storage"] = &"MP_DMZ_LOCKS/UNLOCK_HYDRO_STORAGE";
  level.doorstrings["locked_has_key"]["hydro_apt"] = &"MP_DMZ_LOCKS/UNLOCK_HYDRO_APT";
  level.doorstrings["locked_has_key"]["hydro_weapondrop"] = &"MP_DMZ_LOCKS/UNLOCK_HYDRO_WEAPONDROP";
  level.doorstrings["locked_has_key"]["hostage_door"] = &"MP_DMZ_MISSIONS/UNLOCK_HOSTAGE_DOOR";
  level.doorstrings["locked_has_key"]["trap"] = &"MP_DMZ_MISSIONS/TRAP_DOOR_UNLOCK";
  level.doorstrings["locked_has_key"]["trapper_door"] = &"MP_DMZ_LOCKS/UNLOCK_TRAPPER_DOOR";
  level.doorstrings["locked_has_key"]["resort_entrance"] = &"MP_DMZ_LOCKS/UNLOCK_RESORT_ENTRANCE";
  level.doorstrings["locked_has_key"]["firefighttest01"] = &"MP_DMZ_LOCKS/UNLOCK_FIREFIGHTTEST01";
  level.doorstrings["locked_has_key"]["biolab_door"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level.doorstrings["locked_has_key"]["red_door"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level.doorstrings["locked_has_key"]["blue_door"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level.doorstrings["locked_has_key"]["green_door"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level.doorstrings["locked_has_key"]["black_door"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level.doorstrings["locked_has_key"]["gold_door"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level.doorstrings["locked_has_key"]["armory_room"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level.doorstrings["locked_has_key"]["third_floor"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level.doorstrings["locked_has_key"]["high_security"] = &"MP_DMZ_LOCKS/UNLOCK_DOOR";
  level.doorstrings["locked_has_key"]["conference_room"] = &"MP_DMZ_LOCKS/UNLOCK_CONFERENCE_ROOM";
  level.doorstrings["locked_has_key"]["maintenance"] = &"MP_DMZ_LOCKS/UNLOCK_AIRPORT_MAINTENANCE";
  level.doorstrings["locked_has_key"]["undershack"] = &"MP_DMZ_LOCKS/UNLOCK_UNDERGROUND_SHACK";
  level.doorstrings["locked_has_key"]["cliffroom"] = &"MP_DMZ_LOCKS/UNLOCK_CLIFF_ROOM";
  level.doorstrings["locked_has_key"]["gravehouse"] = &"MP_DMZ_LOCKS/UNLOCK_GRAVEYARD_HOUSE";
  level.doorstrings["locked_has_key"]["poppyhome"] = &"MP_DMZ_LOCKS/UNLOCK_POPPY_HOME";
  level.doorstrings["locked_has_key"]["western_storage"] = &"MP_DMZ_LOCKS/UNLOCK_WESTERN_STORAGE";
  level.doorstrings["locked_has_key"]["mobile_office"] = &"MP_DMZ_LOCKS/UNLOCK_MOBILE_OFFICE";
  level.doorstrings["locked_has_key"]["crane_building"] = &"MP_DMZ_LOCKS/UNLOCK_CRANE_BUILDING";
  level.doorstrings["locked_has_key"]["policestation"] = &"MP_DMZ_LOCKS/UNLOCK_POLICE_LOCKERROOM";
  level.doorstrings["locked_has_key"]["smugglers_warehouse"] = &"MP_DMZ_LOCKS/UNLOCK_SMUGGLERS_WAREHOUSE";
  level.doorstrings["locked_has_key"]["power_substation"] = &"MP_DMZ_LOCKS/UNLOCK_POWER_SUBSTATION";
  level.doorstrings["locked_has_key"]["cell_phone_shop"] = &"MP_DMZ_LOCKS/UNLOCK_CELL_PHONE_SHOP";
  level.doorstrings["locked_has_key"]["police_academy_barracks"] = &"MP_DMZ_LOCKS/UNLOCK_POLICE_ACADEMY_BARRACKS";
  level.doorstrings["locked_has_key"]["police_lockerroom"] = &"MP_DMZ_LOCKS/UNLOCK_POLICE_ACADEMY_LOCKERROOM";
  level.doorstrings["locked_has_key"]["post_office"] = &"MP_DMZ_LOCKS/UNLOCK_POST_OFFICE";
  level.doorstrings["locked_has_key"]["tv_station"] = &"MP_DMZ_LOCKS/UNLOCK_TV_STATION";
  level.doorstrings["locked_has_key"]["shopping_booth"] = &"MP_DMZ_LOCKS/UNLOCK_SHOPPING_BOOTH";
  level.doorstrings["locked_has_key"]["apartment_closet"] = &"MP_DMZ_LOCKS/UNLOCK_APARTMENT_CLOSET";
  level.doorstrings["locked_has_key"]["control_room"] = &"MP_DMZ_LOCKS/UNLOCK_CONTROL_ROOM";
  level.doorstrings["locked_has_key"]["north_guard_shack"] = &"MP_DMZ_LOCKS/UNLOCK_NORTH_GUARD_SHACK";
  level.doorstrings["locked_has_key"]["south_guard_shack"] = &"MP_DMZ_LOCKS/UNLOCK_SOUTH_GUARD_SHACK1";
  level.doorstrings["locked_has_key"]["fortbarrack1_rr"] = &"MP_DMZ_LOCKS/UNLOCK_FORT_BARRACK1";
  level.doorstrings["locked_has_key"]["antiquities_office_rr"] = &"MP_DMZ_LOCKS/UNLOCK_ANTIQUITIES_OFFICE";
  level.doorstrings["locked_has_key"]["munitions_storage_rr"] = &"MP_DMZ_LOCKS/UNLOCK_MUNITIONS_STORAGE";
  level.doorstrings["locked_has_key"]["office_quarters1_rr"] = &"MP_DMZ_LOCKS/UNLOCK_OFFICE_QUARTERS1";
  level.doorstrings["locked_has_key"]["office_quarters2"] = &"MP_DMZ_LOCKS/UNLOCK_OFFICE_QUARTERS2";
  level.doorstrings["locked_has_key"]["quiet_bedroom_rr"] = &"MP_DMZ_LOCKS/UNLOCK_QUIET_BEDROOM";
  level.doorstrings["locked_has_key"]["car_shop"] = &"MP_DMZ_LOCKS/UNLOCK_AUTO_SHOP_SUNKEN";
  level.doorstrings["locked_has_key"]["server_room"] = &"MP_DMZ_LOCKS/UNLOCK_SERVER_ROOM";
  level.doorstrings["locked_has_key"]["sunken_top_office"] = &"MP_DMZ_LOCKS/UNLOCK_SUNKEN_OFFICE";
  level.doorstrings["locked_has_key"]["sunken_2nd_office"] = &"MP_DMZ_LOCKS/UNLOCK_SUNKEN_SECOND_OFFICE";
  level.doorstrings["locked_has_key"]["hotel_room1"] = &"MP_DMZ_LOCKS/UNLOCK_HOTEL_ROOM1";
  level.doorstrings["locked_has_key"]["hotel_room2"] = &"MP_DMZ_LOCKS/UNLOCK_HOTEL_ROOM2";
  level.doorstrings["locked_has_key"]["dressing_room"] = &"MP_DMZ_LOCKS/UNLOCK_DRESSING_ROOM";
  level.doorstrings["locked_has_key"]["sec_camera_room"] = &"MP_DMZ_LOCKS/UNLOCK_SEC_CAMERA_ROOM";
  level.doorstrings["locked_has_key"]["gaming_room"] = &"MP_DMZ_LOCKS/UNLOCK_GAMING_ROOM";
  level.doorstrings["locked_has_key"]["fishing_shack"] = &"MP_DMZ_LOCKS/UNLOCK_FISH_SHACK";
  level.doorstrings["locked_has_key"]["mountain_top"] = &"MP_DMZ_LOCKS/UNLOCK_MOUNTAIN_TOP_ROOM";
  level.doorstrings["locked_has_key"]["spotters_view"] = &"MP_DMZ_LOCKS/UNLOCK_SPOTTERS_VIEW";
  level.doorstrings["locked_has_key"]["grocery_office"] = &"MP_DMZ_LOCKS/UNLOCK_GROCERY_OFFICE";
  level.doorstrings["locked_has_key"]["neigh_storage_room"] = &"MP_DMZ_LOCKS/UNLOCK_NEIGH_STORAGE_ROOM";
  level.doorstrings["locked_has_key"]["apartment_closet"] = &"MP_DMZ_LOCKS/UNLOCK_APARTMENT_CLOSET";
  level.doorstrings["locked_has_key"]["apartment_snipernest"] = &"MP_DMZ_LOCKS/UNLOCK_APARTMENT_SNIPERNEST";
  level.doorstrings["locked_has_key"]["destroyed_telescope"] = &"MP_DMZ_LOCKS/UNLOCK_DESTROYED_TELESCOPE";
  level.doorstrings["locked_has_key"]["groundskeepers"] = &"MP_DMZ_LOCKS/UNLOCK_GROUNDSKEEPERS";
  level.doorstrings["locked_has_key"]["lighthouse_room"] = &"MP_DMZ_LOCKS/UNLOCK_LIGHTHOUSE_ROOM";
  level.doorstrings["locked_has_key"]["safe_house"] = &"MP_DMZ_LOCKS/UNLOCK_SAFE_HOUSE";
  level.doorstrings["locked_has_key"]["scientist_apartment"] = &"MP_DMZ_LOCKS/UNLOCK_SCIENTIST_APARTMENT";
  level.doorstrings["locked_has_key"]["secret_comms"] = &"MP_DMZ_LOCKS/UNLOCK_SECRET_COMMS";
  level.doorstrings["locked_has_key"]["shopping_booth"] = &"MP_DMZ_LOCKS/UNLOCK_SHOPPING_BOOTH";
  level.doorstrings["locked_has_key"]["sira_apartment"] = &"MP_DMZ_LOCKS/UNLOCK_SIRA_APARTMENT";
  level.doorstrings["locked_has_key"]["small_confer_room"] = &"MP_DMZ_LOCKS/UNLOCK_SMALL_CONFER_ROOM";
  level.doorstrings["locked_has_key"]["supply_rooms"] = &"MP_DMZ_LOCKS/UNLOCK_SUPPLY_ROOM";
  level.doorstrings["locked_has_key"]["tv_computer_room"] = &"MP_DMZ_LOCKS/UNLOCK_TV_COMPUTER_ROOM";
  level.doorstrings["locked_has_key"]["yumyum_burger"] = &"MP_DMZ_LOCKS/UNLOCK_YUM_BURGER";
  level.doorstrings["locked_has_key"]["interrogation_room"] = &"MP_DMZ_LOCKS/UNLOCK_INTERROGATION_ROOM";
  level.doorstrings["locked_has_key"]["control_tower"] = &"MP_DMZ_LOCKS/UNLOCK_CONTROL_TOWER";
  level.doorstrings["locked_has_key"]["civic_center"] = &"MP_DMZ_LOCKS/UNLOCK_CIVIC_CENTER";
  level.doorstrings["locked_has_key"]["sira_mall"] = &"MP_DMZ_LOCKS/UNLOCK_SIRA_MALL";
  level.doorstrings["locked_has_key"]["fort"] = &"MP_DMZ_LOCKS/UNLOCK_FORT";
  level.doorstrings["locked_has_key"]["exhume_warehouse"] = &"MP_DMZ_LOCKS/UNLOCK_EXHUME_WAREHOUSE";
  level.doorstrings["locked_has_key"]["post_office_stronghold"] = &"MP_DMZ_LOCKS/UNLOCK_POST_OFFICE_STRONGHOLD";
  level.doorstrings["locked_has_key"]["police_academy"] = &"MP_DMZ_LOCKS/UNLOCK_POLICE_ACADEMY";
  level.doorstrings["locked_has_key"]["embassy"] = &"MP_DMZ_LOCKS/UNLOCK_EMBASSY";
  level.doorstrings["locked_has_key"]["blacksite"] = &"MP_DMZ_LOCKS/UNLOCK_BLACKSITE";
  level.doorstrings["locked_has_key"]["human_fortress_rainmaker"] = &"JUP_OB_ITEM_GENERICS/UNLOCK_HUMAN_FORTRESS_RAINMAKER";
  level.doorstrings["locked_has_key"]["human_fortress_maestro"] = &"JUP_OB_ITEM_GENERICS/UNLOCK_HUMAN_FORTRESS_MAESTRO";
  level.doorstrings["locked_has_key"]["human_fortress_chemist"] = &"JUP_OB_ITEM_GENERICS/UNLOCK_HUMAN_FORTRESS_CHEMIST";
  level.doorstrings["locked_has_key"]["human_fortress_allforone"] = &"JUP_OB_ITEM_GENERICS/UNLOCK_HUMAN_FORTRESS_ALLFORONE";
  level.doorstrings["locked_has_key"]["human_stronghold"] = &"JUP_OB_ITEM_GENERICS/UNLOCK_HUMAN_STRONGHOLD";
  level.doorstrings["locked_has_key"]["vault"] = &"JUP_OB_OBJECTIVES/VAULT_LOCKED";
  level.doorstrings["locked_has_key"]["tower_roof"] = &"MP_DMZ_LOCKS/OB_S5_RIFT_RUN_TOWER_ROOF_UNLOCKED";
  level.doorstrings["locked_has_key"]["tower_breakroom"] = &"MP_DMZ_LOCKS/OB_S5_RIFT_RUN_TOWER_ROOF_UNLOCKED";
}

function function_94f5e3929619c3d1(doorname) {
  string = level.doorstrings["locked_no_key"][tolower(doorname)];

  if(!isDefined(string)) {
    string = level.doorstrings["locked_no_key"]["stuck"];
  }

  return string;
}

function function_54f0ba9ac5666aba(doorname) {
  string = level.doorstrings["locked_has_key"][tolower(doorname)];

  if(!isDefined(string)) {
    string = level.doorstrings["locked_has_key"]["stuck"];
  }

  return string;
}

function function_2a56c656879dbf63() {
  if(getdvarint(@ "hash_5cb759b2fdb8657a", 1) == 0) {
    return;
  }

  utility::flag_wait("lockedspaces_create_script_initialized");
  function_8e1cbe18678d7fff();
  function_29e046251bdc472c();

  level thread function_ed06a4c85b7994a0();
}

function function_29e046251bdc472c() {
  level.lockedspaces = [];
  var_4c7bfe49f37e4faf = level.struct_class_names["script_noteworthy"]["lockedSpace"];

  if(!isDefined(var_4c7bfe49f37e4faf)) {
    return;
  }

  foreach(mainnode in var_4c7bfe49f37e4faf) {
    function_2039418022567d47(mainnode);
    function_dcec5158a800e39d(mainnode);
    level.lockedspaces[level.lockedspaces.size] = mainnode;
  }
}

function function_2039418022567d47(var_809fdff7726141bb) {
  nodes = array_combine(getStructArray(var_809fdff7726141bb.target, "targetname"), getEntArray(var_809fdff7726141bb.target, "targetname"));
  var_809fdff7726141bb.lockeddoors = [];
  var_809fdff7726141bb.var_84b0ef6bddd2907a = [];
  var_809fdff7726141bb.var_3da7559f232a2ca9 = [];

  foreach(node in nodes) {
    if(!isDefined(node.angles)) {
      node.angles = (0, 0, 0);
    }

    if(!isDefined(node.script_noteworthy)) {
      continue;
    }

    switch (tolower(node.script_noteworthy)) {
      case #"hash_cd0ffa281c8e3a8":
        var_809fdff7726141bb.lockeddoors = function_ad1b6accbaab404e(node, var_809fdff7726141bb.lockeddoors, tolower(var_809fdff7726141bb.targetname), 0);
        break;
      case #"hash_a0a74a8a22d1d16":
        var_809fdff7726141bb.var_84b0ef6bddd2907a = function_ad1b6accbaab404e(node, var_809fdff7726141bb.var_84b0ef6bddd2907a, "stuck", 0);
        break;
      case #"hash_df8921e339df1f80":
        node.var_86740fa764ee2fdc = 1;
        var_809fdff7726141bb.var_3da7559f232a2ca9[var_809fdff7726141bb.var_3da7559f232a2ca9.size] = node;
        break;
      case #"hash_db521e4972a48a9d":
        node.isnote = 1;
        var_809fdff7726141bb.var_3da7559f232a2ca9[var_809fdff7726141bb.var_3da7559f232a2ca9.size] = node;
        break;
      case #"hash_55425b6c36803a4c":
        node.iskey = 1;
        var_809fdff7726141bb.var_3da7559f232a2ca9[var_809fdff7726141bb.var_3da7559f232a2ca9.size] = node;
        break;
    }
  }
}

function function_dcec5158a800e39d(var_7be3a4ca79d6d8e6, var_14dcea3d745e5b2b) {
  foreach(door in var_7be3a4ca79d6d8e6.lockeddoors) {
    function_fbbfe6f05eda5eb1(door);

    if(isDefined(var_14dcea3d745e5b2b)) {
      door.var_def557e8fd5c6763 = var_14dcea3d745e5b2b;
      continue;
    }

    door.var_def557e8fd5c6763 = &function_bf5ad2061b782c3c;
  }

  foreach(door in var_7be3a4ca79d6d8e6.var_84b0ef6bddd2907a) {
    function_fbbfe6f05eda5eb1(door);
  }

  scriptables = getentitylessscriptablearray(var_7be3a4ca79d6d8e6.target, "targetname", var_7be3a4ca79d6d8e6.origin, 3000);

  foreach(scriptable in scriptables) {
    if(isDefined(scriptable.classname) && issubstr(scriptable.classname, "scriptable_blocker")) {
      scriptable setscriptablepartstate("state", "visible");
    }
  }

  foreach(node in var_7be3a4ca79d6d8e6.var_3da7559f232a2ca9) {
    function_4c877fc54e2e6854(node, var_7be3a4ca79d6d8e6.targetname);
  }
}

function function_64332f29e2409e55(origin) {
  foreach(volume in level.var_ab18903aa481fff2) {
    if(ispointinvolume(origin, volume)) {
      return true;
    }
  }

  return false;
}

function function_bf5ad2061b782c3c(scriptable, player) {
  params = spawnStruct();
  params.scriptable = scriptable;
  player scripts\common\callbacks::callback("ob_locked_space_unlocked", params);
  scripts\mp\pmc_missions::function_1d1df26df05a6c8(scriptable, player);
}

function function_ed1aea6648bcdc28(scriptablename, keylevel) {
  assertex(isDefined(keylevel), "<dev string:x123>");
  assertex(isDefined(scriptablename), "<dev string:x16a>");

  if(!isDefined(scriptablename) || !isDefined(keylevel)) {
    return undefined;
  }

  switch (keylevel) {
    case 0:
      var_f48a1fa8eddf2b4a = scripts\cp_mp\utility\loot::getlootidfromref(scriptablename + "_used");
      assertex(isDefined(var_f48a1fa8eddf2b4a), "<dev string:x1b7>" + scriptablename);

      if(!isDefined(var_f48a1fa8eddf2b4a)) {
        return undefined;
      }

      return var_f48a1fa8eddf2b4a;
    case 1:
      var_f48a1fa8eddf2b4a = scripts\cp_mp\utility\loot::getlootidfromref(scriptablename + "_worn");
      assertex(isDefined(var_f48a1fa8eddf2b4a), "<dev string:x1b7>" + scriptablename + "<dev string:x1e1>");

      if(!isDefined(var_f48a1fa8eddf2b4a)) {
        return undefined;
      }

      return var_f48a1fa8eddf2b4a;
    case 2:
      return undefined;
    default:
      return undefined;
  }
}

function function_ed06a4c85b7994a0() {
  level endon("<dev string:x1ea>");

  while(true) {
    if(getdvarint(@ "hash_34766c6f7cda260e", 0) == 1) {
      foreach(var_809fdff7726141bb in level.lockedspaces) {
        sphere(var_809fdff7726141bb.origin, 128, (0, 0, 1));
        print3d(var_809fdff7726141bb.origin + (0, 0, 550), var_809fdff7726141bb.targetname, (1, 1, 1), 1, 2, 20);
      }
    }

    waitframe();
  }
}

function function_8e1cbe18678d7fff() {
  if(getdvarint(@ "hash_1e9f946374cb994b", 0)) {
    return;
  }

  var_5374a9df4582df00 = getDvar(@ "hash_64ddcf029687ca8b", "mp/loot/br/dmz/lootset_custom_nodes.csv");
  level.var_3da7559f232a2ca9 = [];
  numrows = tablelookupgetnumrows(var_5374a9df4582df00);

  for(i = 0; istrue(i < numrows); i++) {
    var_49710df804bea4d0 = tablelookupbyrow(var_5374a9df4582df00, i, 0);

    if(!isDefined(level.var_3da7559f232a2ca9[var_49710df804bea4d0])) {
      level.var_3da7559f232a2ca9[var_49710df804bea4d0] = [];
    }

    lootitemtype = tablelookupbyrow(var_5374a9df4582df00, i, 1);
    dropchance = int(tablelookupbyrow(var_5374a9df4582df00, i, 2));
    var_dcb6e2b7467a12fc = tablelookupbyrow(var_5374a9df4582df00, i, 3);
    var_b99b2114134fe248 = tablelookupbyrow(var_5374a9df4582df00, i, 4);
    level.var_3da7559f232a2ca9[var_49710df804bea4d0][lootitemtype] = spawnStruct();
    level.var_3da7559f232a2ca9[var_49710df804bea4d0][lootitemtype].dropchance = dropchance;
    level.var_3da7559f232a2ca9[var_49710df804bea4d0][lootitemtype].var_dcb6e2b7467a12fc = var_dcb6e2b7467a12fc;
    level.var_3da7559f232a2ca9[var_49710df804bea4d0][lootitemtype].var_b99b2114134fe248 = var_b99b2114134fe248;
  }
}

function function_799a9ee634da2160(node) {
  if(!isDefined(node.classname) || !isent(node)) {
    return false;
  }

  var_9f1cae7f3799988a = node isscriptable();
  isnote = issubstr(node.classname, "note");

  if(istrue(isnote)) {
    node.isnote = isnote;
  }

  iskey = issubstr(node.classname, "key");

  if(istrue(iskey)) {
    node.iskey = isnote;
  }

  return var_9f1cae7f3799988a && (isnote || iskey);
}

function function_4c877fc54e2e6854(node, var_49710df804bea4d0) {
  if(getdvarint(@ "hash_1e9f946374cb994b", 0)) {
    return;
  }

  var_49710df804bea4d0 = tolower(var_49710df804bea4d0);

  if(istrue(node.iskey)) {
    if(!function_e05f1f84bb69a4d2(var_49710df804bea4d0, "key")) {
      percentagespawn = -1;
    } else {
      percentagespawn = level.var_3da7559f232a2ca9[var_49710df804bea4d0]["key"].dropchance;
    }

    if(percentagespawn == 0) {
      return;
    }

    roll = randomint(100);

    if(roll < percentagespawn) {
      dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo(node.origin, node.angles);
      iscritical = 0;
      keyname = "loot_key_fortress";
      var_dcb6e2b7467a12fc = level.var_3da7559f232a2ca9[var_49710df804bea4d0]["key"].var_dcb6e2b7467a12fc;

      if(isDefined(var_dcb6e2b7467a12fc) && var_dcb6e2b7467a12fc != "") {
        keyname = var_dcb6e2b7467a12fc;

        if(issubstr(keyname, "loot_key")) {
          iscritical = 1;
        }
      }

      if(keyname == "tier1Key") {
        keyname = scripts\mp\locksandkeys::function_23326c8ac97c60c7(1, 0, 0, 0, 1, 0, 0, 0, 20, 60, 20);
      } else if(keyname == "tier2Key") {
        keyname = scripts\mp\locksandkeys::function_23326c8ac97c60c7(0, 1, 0, 0, 0, 1, 0, 0, 20, 60, 20);
      } else if(keyname == "tier3Key") {
        keyname = scripts\mp\locksandkeys::function_23326c8ac97c60c7(0, 0, 1, 0, 0, 0, 1, 0, 20, 60, 20);
      } else if(keyname == "heroKey") {
        keyname = scripts\mp\locksandkeys::function_23326c8ac97c60c7(0, 0, 0, 1, 0, 0, 0, 1, 20, 60, 20);
      }

      scriptable = scripts\mp\gametypes\br_pickups::spawnpickup(keyname, dropinfo, 1, 0);

      if(istrue(iscritical)) {
        scriptable.criticalitem = 1;
      }
    }

    return;
  }

  if(istrue(node.isnote) || istrue(node.var_86740fa764ee2fdc)) {
    if(!isDefined(level.var_3da7559f232a2ca9[var_49710df804bea4d0]) || isDefined(level.var_3da7559f232a2ca9[var_49710df804bea4d0]["noteAlreadyPlaced"])) {
      return;
    } else {
      level.var_3da7559f232a2ca9[var_49710df804bea4d0]["noteAlreadyPlaced"] = 1;
    }

    if(!function_e05f1f84bb69a4d2(var_49710df804bea4d0, "note")) {
      percentagespawn = -1;
    } else {
      percentagespawn = level.var_3da7559f232a2ca9[var_49710df804bea4d0]["note"].dropchance;
    }

    if(percentagespawn == 0) {
      return;
    }

    roll = randomint(100);

    if(roll < percentagespawn) {
      notename = level.var_3da7559f232a2ca9[var_49710df804bea4d0]["note"].var_dcb6e2b7467a12fc;

      if(!isDefined(notename) || notename == "") {
        return;
      }

      offset = (0, 0, 0);

      if(istrue(node.var_86740fa764ee2fdc)) {
        if(issubstr(notename, "_note_")) {
          offset = (-90, 0, 0);
        }
      } else if(istrue(node.isnote)) {
        if(issubstr(notename, "_notebook_")) {
          offset = (90, 0, 0);
        }
      }

      dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo(node.origin, node.angles + offset);
      scriptable = scripts\mp\gametypes\br_pickups::spawnpickup(notename, dropinfo, 1, 0);
      scriptable.criticalitem = 1;
    }
  }
}

function function_e05f1f84bb69a4d2(var_49710df804bea4d0, itemtype) {
  if(!isDefined(var_49710df804bea4d0) || !isDefined(itemtype)) {
    return false;
  }

  if(!isDefined(level.var_3da7559f232a2ca9[var_49710df804bea4d0])) {
    return false;
  }

  if(!isDefined(level.var_3da7559f232a2ca9[var_49710df804bea4d0]["key"])) {
    return false;
  }

  if(!isDefined(level.var_3da7559f232a2ca9[var_49710df804bea4d0]["key"].dropchance)) {
    return false;
  }

  if(!isint(level.var_3da7559f232a2ca9[var_49710df804bea4d0]["key"].dropchance)) {
    return false;
  }

  return true;
}

function function_a894d6041798cc06() {
  function_a9d72a6ee70123e5();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("locked_cache_prompt", &function_38904bc3a49af40c);
  cachenodes = getStructArray("lockedCache", "targetname");

  foreach(cachenode in cachenodes) {
    cachearray = getentitylessscriptablearray(undefined, undefined, cachenode.origin, 64, "body");

    if(!isDefined(cachearray)) {
      continue;
    }

    cache = cachearray[0];

    if(!isDefined(cache)) {
      continue;
    }

    cache setscriptablepartstate("body", "closed_locked");
    forward = anglesToForward(cache.angles);
    scriptable = spawnscriptable("locked_cache_prompt", cachenode.origin);
    scriptable setscriptablepartstate("locked_cache_prompt", "on");

    if(isDefined(cachenode.script_noteworthy)) {
      scriptable.keyname = cachenode.script_noteworthy;
    } else {
      scriptable.keyname = "generic";
    }

    scriptable.cache = cache;
    scriptable.canplaysound = 1;
    cache.islockedcache = 1;
  }
}

function function_38904bc3a49af40c(instance, part, state, player, bautouse, usestring) {
  backpackkeyname = instance.keyname;

  if(instance.keyname == "firefightTestContainer") {
    backpackkeyname = "gravesite_container";
  }

  if(!function_e0e50ef00477deeb("loot_key_" + backpackkeyname, player)) {
    player scripts\mp\hud_message::showerrormessage(function_bd958525be466cd7(backpackkeyname));

    if(istrue(instance.canplaysound)) {
      instance.canplaysound = 0;
      playsoundatpos(instance.origin, "mp_door_locked");
      return 0;
    }

    wait 3;
    instance.canplaysound = 1;
    return 0;
  }

  cache = instance.cache;
  player thread function_83f5cdc3d883507e(instance, player);
  playsoundatpos(instance.origin, "mp_door_unlock_key");
  savedkeyname = instance.keyname;
  instance freescriptable();
  wait 1;
  cache setscriptablepartstate("body", "closed_usable");
  items = getscriptablelootcachecontents(cache);
  cache.containertype = 3;
  cache.contents = scripts\mp\gametypes\br_lootcache::function_ec87b214cd429e96(items, undefined);
  itemarray = function_b98c91e5697edb49(savedkeyname);

  foreach(index, item in itemarray) {
    itemtable = item.var_b99b2114134fe248;

    if(!isDefined(itemtable)) {
      continue;
    }

    if(array_contains(level.br_plunder.names, item.var_dcb6e2b7467a12fc)) {
      lootid = scripts\cp_mp\utility\loot::getlootidfromref("cash");
      var_7baf6f0eafe87a8 = 0;

      foreach(var_f90d0e006a1f717b, var_3466c10973e9c476 in level.br_plunder.names) {
        if(var_3466c10973e9c476 == item.var_dcb6e2b7467a12fc) {
          var_7baf6f0eafe87a8 = var_f90d0e006a1f717b;
          break;
        }
      }

      count = level.br_plunder.quantity[var_7baf6f0eafe87a8];
    } else {
      lootid = scripts\cp_mp\utility\loot::getlootidfromref(item.var_dcb6e2b7467a12fc);

      if(istrue(level.var_a9350d89a2e4d752)) {
        count = "";

        if(isDefined(level.br_pickups.counts[item.var_dcb6e2b7467a12fc])) {
          count = level.br_pickups.counts[item.var_dcb6e2b7467a12fc];
        }
      } else {
        count = tablelookup(level.brloottablename, 1, item.var_dcb6e2b7467a12fc, 4);

        if(count == "") {
          count = tablelookup(level.brloottablename, 1, "brloot_" + item.var_dcb6e2b7467a12fc, 4);
        }
      }
    }

    cache.contents = scripts\mp\gametypes\br_lootcache::function_848e20cf1d6cab8f(cache.contents, count, lootid, undefined, index);
  }
}

function function_a9d72a6ee70123e5() {
  level.var_409396d5620deae8 = [];
  level.var_409396d5620deae8["fortress"] = "MP_DMZ_LOCKS/CACHE_LOCKED_FORTRESS";
  level.var_409396d5620deae8["airport_lounge"] = "MP_DMZ_LOCKS/CACHE_LOCKED_AIRPORT_LOUNGE";
  level.var_409396d5620deae8["baggage_handling"] = "MP_DMZ_LOCKS/CACHE_LOCKED_BAGGAGE_HANDLING";
  level.var_409396d5620deae8["end_runway"] = "MP_DMZ_LOCKS/CACHE_LOCKED_END_RUNWAY";
  level.var_409396d5620deae8["caves_bench_container"] = "MP_DMZ_LOCKS/CACHE_LOCKED_CAVES_BENCH_CONTAINER";
  level.var_409396d5620deae8["powerstation_container"] = "MP_DMZ_LOCKS/CACHE_LOCKED_POWERSUBSTATION_CONTAINER";
  level.var_409396d5620deae8["gravesite_container"] = "MP_DMZ_LOCKS/CACHE_LOCKED_GRAVESITE_CONTAINER";
  level.var_409396d5620deae8["waterpit_container"] = "MP_DMZ_LOCKS/CACHE_LOCKED_WATERPIT_CONTAINER";
  level.var_409396d5620deae8["underwater_ship"] = "MP_DMZ_LOCKS/CACHE_LOCKED_UNDERWATER_SHIP";
  level.var_409396d5620deae8["clocktower_container"] = "MP_DMZ_LOCKS/CACHE_LOCKED_CLOCKTOWER_CONTAINER";
  level.var_409396d5620deae8["hydro_island_room"] = "MP_DMZ_LOCKS/CACHE_LOCKED_HYDRO_ISLAND_ROOM";
  level.var_409396d5620deae8["ship_bridge"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SHIP_BRIDGE";
  level.var_409396d5620deae8["ship_center"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SHIP_CENTER";
  level.var_409396d5620deae8["fishing_box_dock"] = "MP_DMZ_LOCKS/CACHE_LOCKED_FISHING_BOX_DOCK";
  level.var_409396d5620deae8["underthebridge"] = "MP_DMZ_LOCKS/CACHE_LOCKED_UNDERBRIDGE";
  level.var_409396d5620deae8["tower_hill"] = "MP_DMZ_LOCKS/CACHE_LOCKED_TOWER_HILL";
  level.var_409396d5620deae8["canal_uw_container"] = "MP_DMZ_LOCKS/CACHE_LOCKED_CANAL_UW_CONTAINER";
  level.var_409396d5620deae8["hallway_locker"] = "MP_DMZ_LOCKS/CACHE_LOCKED_HALLWAY_LOCKER";
  level.var_409396d5620deae8["control_room"] = "MP_DMZ_LOCKS/CACHE_LOCKED_CONTROL_ROOM";
  level.var_409396d5620deae8["ship_above_water"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SHIP_ABOVE_WATER";
  level.var_409396d5620deae8["sunken_ship"] = "MP_DMZ_LOCKS/CACHE_LOCKED_SUNKEN_SHIP";
  level.var_409396d5620deae8["underground_passage"] = "MP_DMZ_LOCKS/CACHE_LOCKED_UNDERGROUND_PASSAGE";
  level.var_409396d5620deae8["police_locker"] = "MP_DMZ_LOCKS/CACHE_LOCKED_POLICE_LOCKER";
}

function function_bd958525be466cd7(keyname) {
  errorstring = level.var_409396d5620deae8[keyname];

  if(!isDefined(errorstring)) {
    errorstring = level.var_409396d5620deae8["fortress"];
  }

  return errorstring;
}

function function_b98c91e5697edb49(var_49710df804bea4d0) {
  itemarray = [];

  if(isDefined(level.var_3da7559f232a2ca9[var_49710df804bea4d0])) {
    foreach(potentialitem in level.var_3da7559f232a2ca9[var_49710df804bea4d0]) {
      if(potentialitem.var_dcb6e2b7467a12fc == "tier1Key") {
        potentialitem.var_dcb6e2b7467a12fc = scripts\mp\locksandkeys::function_23326c8ac97c60c7(1, 0, 0, 0, 1, 0, 0, 0, 20, 60, 20);
        itemarray[itemarray.size] = potentialitem;
        continue;
      }

      if(potentialitem.var_dcb6e2b7467a12fc == "tier2Key") {
        potentialitem.var_dcb6e2b7467a12fc = scripts\mp\locksandkeys::function_23326c8ac97c60c7(0, 1, 0, 0, 0, 1, 0, 0, 20, 60, 20);
        itemarray[itemarray.size] = potentialitem;
        continue;
      }

      if(potentialitem.var_dcb6e2b7467a12fc == "tier3Key") {
        potentialitem.var_dcb6e2b7467a12fc = scripts\mp\locksandkeys::function_23326c8ac97c60c7(0, 0, 1, 0, 0, 0, 1, 0, 20, 60, 20);
        itemarray[itemarray.size] = potentialitem;
        continue;
      }

      if(potentialitem.var_dcb6e2b7467a12fc == "heroKey") {
        potentialitem.var_dcb6e2b7467a12fc = scripts\mp\locksandkeys::function_23326c8ac97c60c7(0, 0, 0, 1, 0, 0, 0, 1, 20, 60, 20);
        itemarray[itemarray.size] = potentialitem;
        continue;
      }

      roll = randomint(100);

      if(roll < potentialitem.dropchance) {
        itemarray[itemarray.size] = potentialitem;
      }
    }
  }

  return itemarray;
}

function function_b35796a7c0a71079() {
  level.var_f2e2b5ed406a7d94 = [];
  level.var_f2e2b5ed406a7d94[1] = [];
  level.var_f2e2b5ed406a7d94[2] = [];
  level.var_f2e2b5ed406a7d94[3] = [];
  level.var_f2e2b5ed406a7d94[4] = [];
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "hydro_storage";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "airport_lounge";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "baggage_handling";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "caves_bench_container";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "undershack";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "gravehouse";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "powerstation_container";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "gravesite_container";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "mobile_office";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "groundskeepers";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "clocktower_container";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "hydro_island_room";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "fishing_box_dock";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "supply_rooms";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "power_substation";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "cell_phone_shop";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "underthebridge";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "police_academy_barracks";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "tv_station";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "shopping_booth";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "yumyum_burger";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "tower_hill";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "canal_uw_container";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "small_confer_room";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "hallway_locker";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "north_guard_shack";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "south_guard_shack";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "fortbarrack1";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "office_quarters1";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "sunken_2nd_office";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "sira_apartment";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "gaming_room";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "fishing_shack";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "spotters_view";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "grocery_office";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "neigh_storage_room";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "crane_building";
  level.var_f2e2b5ed406a7d94[1][level.var_f2e2b5ed406a7d94[1].size] = "underwater_ship";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "hydro_apt";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "conference_room";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "end_runway";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "cliffroom";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "poppyhome";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "waterpit_container";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "lighthouse_room";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "ship_bridge";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "ship_center";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "policestation";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "smugglers_warehouse";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "interrogation_room";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "police_lockerroom";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "apartment_closet";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "tv_computer_room";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "destroyed_telescope";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "scientist_apartment";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "control_room";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "end_pyro_tunnel";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "munitions_storage";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "car_shop";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "sunken_top_office";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "hotel_room1";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "ship_above_water";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "dressing_room";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "apartment_snipernest";
  level.var_f2e2b5ed406a7d94[2][level.var_f2e2b5ed406a7d94[2].size] = "underground_passage";
  level.var_f2e2b5ed406a7d94[3][level.var_f2e2b5ed406a7d94[3].size] = "maintenance";
  level.var_f2e2b5ed406a7d94[3][level.var_f2e2b5ed406a7d94[3].size] = "safe_house";
  level.var_f2e2b5ed406a7d94[3][level.var_f2e2b5ed406a7d94[3].size] = "western_storage";
  level.var_f2e2b5ed406a7d94[3][level.var_f2e2b5ed406a7d94[3].size] = "secret_comms";
  level.var_f2e2b5ed406a7d94[3][level.var_f2e2b5ed406a7d94[3].size] = "post_office";
  level.var_f2e2b5ed406a7d94[3][level.var_f2e2b5ed406a7d94[3].size] = "antiquities_office";
  level.var_f2e2b5ed406a7d94[3][level.var_f2e2b5ed406a7d94[3].size] = "quiet_bedroom";
  level.var_f2e2b5ed406a7d94[3][level.var_f2e2b5ed406a7d94[3].size] = "server_room";
  level.var_f2e2b5ed406a7d94[3][level.var_f2e2b5ed406a7d94[3].size] = "hotel_room2";
  level.var_f2e2b5ed406a7d94[3][level.var_f2e2b5ed406a7d94[3].size] = "sunken_ship";
  level.var_f2e2b5ed406a7d94[3][level.var_f2e2b5ed406a7d94[3].size] = "sec_camera_room";
  level.var_f2e2b5ed406a7d94[3][level.var_f2e2b5ed406a7d94[3].size] = "mountain_top";
  level.var_f2e2b5ed406a7d94[4][level.var_f2e2b5ed406a7d94[4].size] = "civic_center";
  level.var_f2e2b5ed406a7d94[4][level.var_f2e2b5ed406a7d94[4].size] = "embassy";
  level.var_f2e2b5ed406a7d94[4][level.var_f2e2b5ed406a7d94[4].size] = "fort";
  level.var_f2e2b5ed406a7d94[4][level.var_f2e2b5ed406a7d94[4].size] = "sira_mall";
  level.var_f2e2b5ed406a7d94[4][level.var_f2e2b5ed406a7d94[4].size] = "resort_entrance";
  level.var_f2e2b5ed406a7d94[4][level.var_f2e2b5ed406a7d94[4].size] = "police_academy";
  level.var_f2e2b5ed406a7d94[4][level.var_f2e2b5ed406a7d94[4].size] = "post_office_stronghold";
  level.var_f2e2b5ed406a7d94[4][level.var_f2e2b5ed406a7d94[4].size] = "control_tower";
  level.var_f2e2b5ed406a7d94[4][level.var_f2e2b5ed406a7d94[4].size] = "exhume_warehouse";
}

function function_23326c8ac97c60c7(tier1ok, tier2ok, tier3ok, herook, tier1chance, tier2chance, tier3chance, herochance, pristinechance, usedchance, wornchance) {
  possibletiers = [];
  totaltickets = 0;

  if(istrue(tier1ok)) {
    if(isDefined(tier1chance)) {
      totaltickets += tier1chance;
      possibletiers[1] = tier1chance;
    } else {
      totaltickets += 1;
      possibletiers[1] = 1;
    }
  }

  if(istrue(tier2ok)) {
    if(isDefined(tier2chance)) {
      totaltickets += tier2chance;
      possibletiers[2] = tier2chance;
    } else {
      totaltickets += 1;
      possibletiers[2] = 1;
    }
  }

  if(istrue(tier3ok)) {
    if(isDefined(tier2chance)) {
      totaltickets += tier3chance;
      possibletiers[3] = tier3chance;
    } else {
      totaltickets += 1;
      possibletiers[3] = 1;
    }
  }

  if(istrue(herook)) {
    if(isDefined(herochance)) {
      totaltickets += herochance;
      possibletiers[4] = herochance;
    } else {
      totaltickets += 1;
      possibletiers[4] = 1;
    }
  }

  roll = randomint(totaltickets);
  chancetotal = 0;
  var_390ae2320a151006 = undefined;

  foreach(tier, tierchance in possibletiers) {
    chancetotal += tierchance;

    if(roll < chancetotal) {
      var_390ae2320a151006 = tier;
      break;
    }
  }

  var_bf3d63e39c071fab = [];
  var_d73cb1f45b5418a1 = 0;

  if(isDefined(pristinechance)) {
    var_d73cb1f45b5418a1 += pristinechance;
    var_bf3d63e39c071fab[""] = pristinechance;
  }

  if(isDefined(usedchance)) {
    var_d73cb1f45b5418a1 += usedchance;
    var_bf3d63e39c071fab["_used"] = usedchance;
  }

  if(isDefined(wornchance)) {
    var_d73cb1f45b5418a1 += wornchance;
    var_bf3d63e39c071fab["_worn"] = wornchance;
  }

  if(var_bf3d63e39c071fab.size == 0) {
    var_f97b516eeab99cbb = random(["", "_worn", "_used"]);
  } else {
    roll = randomint(var_d73cb1f45b5418a1);
    chancetotal = 0;
    var_f97b516eeab99cbb = undefined;

    foreach(quality, var_d4846ec86821410a in var_bf3d63e39c071fab) {
      chancetotal += var_d4846ec86821410a;

      if(roll < chancetotal) {
        var_f97b516eeab99cbb = quality;
        break;
      }
    }
  }

  keyname = random(level.var_f2e2b5ed406a7d94[var_390ae2320a151006]);
  lootkeyname = "loot_key_" + keyname + var_f97b516eeab99cbb;
  return lootkeyname;
}

function function_ffc077d5175e066a() {
  while(true) {
    randomkey = scripts\mp\locksandkeys::function_23326c8ac97c60c7(1, 0, 0, 0, 1, 0, 0, 0, 10, 70, 20);
    println(randomkey);
    waitframe();
  }
}

function function_af458cfdaf8d86e4() {
  while(true) {
    if(getdvarint(@ "hash_add2748481956623", 0) == 1) {
      lootitems = getentitylessscriptablearray();
      var_e98075a1f0dfce41 = [];
      var_e75ae897f63866b7 = [];
      cachelocs = [];

      foreach(item in lootitems) {
        switch (item.type) {
          case #"hash_8709a7ef11ecdbea":
            var_e98075a1f0dfce41[var_e98075a1f0dfce41.size] = item.origin;
            continue;
          case #"hash_183cb58bad34bd86":
          case #"hash_19ba8d41970911ad":
          case #"hash_33a1ab3969e0b64e":
          case #"hash_417c605750c7baa5":
          case #"hash_b1814c3921b5bcf2":
          case #"hash_b5b4216883bf84b8":
            cachelocs[cachelocs.size] = item;
            continue;
        }

        if(isDefined(item.type) && (issubstr(item.type, "<dev string:x2a8>") || issubstr(item.type, "<dev string:x2b4>"))) {
          var_e75ae897f63866b7[var_e75ae897f63866b7.size] = item.origin;
        }
      }

      foreach(cache in cachelocs) {
        cacheitems = getscriptablelootcachecontents(cache);

        foreach(item in cacheitems) {
          if(item == "<dev string:x1f8>") {
            var_e98075a1f0dfce41[var_e98075a1f0dfce41.size] = cache.origin;
            continue;
          }

          if(issubstr(item, "<dev string:x2a8>") || issubstr(item, "<dev string:x2b4>")) {
            var_e75ae897f63866b7[var_e75ae897f63866b7.size] = cache.origin;
          }
        }
      }

      color = (0, 1, 0);

      foreach(loc in var_e98075a1f0dfce41) {
        thread scripts\mp\utility\debug::drawsphere(loc, 32, 1, color);
      }

      color = (0, 0, 1);

      foreach(loc in var_e75ae897f63866b7) {
        thread scripts\mp\utility\debug::drawsphere(loc, 32, 1, color);
      }
    }

    wait 1;
  }
}

# /