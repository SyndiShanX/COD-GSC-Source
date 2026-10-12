/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_bunker_loot_vaults.gsc
**********************************************************/

#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_bunker_alt;
#using scripts\mp\gametypes\br_bunker_utility;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\lower_message;
#namespace br_bunker_loot_vaults;

function init() {
  level.lootbunkersactive = getdvarint(@ "hash_48fd1e2273274091", 1);
  level.maxaccesscardspawns_red = getdvarint(@ "hash_bba96189687d4ae7", 5);
  level.accesscardsspawned_red = 0;
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_keypad", &keypadscriptableused);
  var_56224d01d10ea4d1 = [1, 2, 3, 7, 10];

  if(getdvarint(@ "hash_dbf8b77ea6cffc8d", 0) == 1) {
    var_752def01b8bfd717 = [0, 1, 2, 3, 4, 5, 6, 7, 9, 10];
  } else {
    var_752def01b8bfd717 = [0, 4, 5, 6, 9];
  }

  level.bunker_loot_vaults = spawnStruct();
  level.bunker_loot_vaults.doors = [];
  level.bunker_loot_vaults.hints = [];

  for(i = 0; i <= 10; i++) {
    var_ac7a80eca239ede7 = "bunker_door_" + i;
    var_4ea0a8f8e7fb6273 = getaltbunkerindexforname(var_ac7a80eca239ede7);

    if(var_4ea0a8f8e7fb6273 >= 0) {
      continue;
    }

    [level.bunker_loot_vaults.doors[i]] = getEntArray(var_ac7a80eca239ede7, "targetname");

    if(!isDefined(level.bunker_loot_vaults.doors[i])) {
      continue;
    }

    var_a0636bd2191a4bbc = scripts\engine\utility::array_contains(var_752def01b8bfd717, i) && level.lootbunkersactive;
    level thread scripts\mp\gametypes\br_bunker_utility::initbunkerdoor(level.bunker_loot_vaults.doors[i], var_a0636bd2191a4bbc);
    initlootvaultkeypad(var_a0636bd2191a4bbc, i, scripts\engine\utility::array_contains(var_56224d01d10ea4d1, i));
  }
}

function initlootvaultkeypad(var_a0636bd2191a4bbc, bunkerindex, var_2d0e7ac083ad5250, var_b0bd841cacf6d96d) {
  if(istrue(var_b0bd841cacf6d96d)) {
    door = level.br_bunker_alt.bunkervaults.doors[bunkerindex];
  } else {
    door = level.bunker_loot_vaults.doors[bunkerindex];
  }

  forward = anglesToForward(door.angles);
  left = anglestoleft(door.angles);
  hintorigin = undefined;

  if(istrue(var_2d0e7ac083ad5250)) {
    hintorigin = door.origin + (0, 0, 45) + forward * 50 + left * 97;
  } else {
    hintorigin = door.origin + (0, 0, 45) + forward * 37 + left * 80;
  }

  if(istrue(var_b0bd841cacf6d96d)) {
    level.br_bunker_alt.bunkervaults.hints[bunkerindex] = spawnscriptable("maphint_keypad_bunker_alt", hintorigin);
    level.br_bunker_alt.bunkervaults.hints[bunkerindex].isopenable = var_a0636bd2191a4bbc;
    level.br_bunker_alt.bunkervaults.hints[bunkerindex].door = door;
    return;
  }

  level.bunker_loot_vaults.hints[bunkerindex] = spawnscriptable("maphint_keypad", hintorigin);
  level.bunker_loot_vaults.hints[bunkerindex].isopenable = var_a0636bd2191a4bbc;
  level.bunker_loot_vaults.hints[bunkerindex].door = door;
}

function keypadscriptableused(instance, part, state, player, bautouse, usestring) {
  level thread _keypadscriptableused(instance, part, state, player, bautouse);
}

function _keypadscriptableused(instance, part, state, player, bautouse) {
  assert(part == "<dev string:x1c>");
  var_b0bd841cacf6d96d = scripts\mp\gametypes\br_bunker_alt::isaltbunkerscriptable(instance);
  assert(!var_b0bd841cacf6d96d);

  if(istrue(instance.backwallkeypad)) {
    if(soundexists("br_keypad_deny")) {
      playsoundatpos(player.origin, "br_keypad_deny");
    }

    instance setscriptablepartstate("maphint_keypad", "off");
    wait 3;
    instance setscriptablepartstate("maphint_keypad", "on");
    return;
  }

  if(getdvarint(@ "hash_8c6e1c43e3d41dd3", 0) == 1 || istrue(instance.isopenable) && player scripts\mp\gametypes\br_public::hasaccesscard()) {
    level thread scripts\mp\gametypes\br_bunker_utility::openbunkerdoor(instance.door, 1, "bunker_loot_shared", "door_open");
    instance setscriptablepartstate("maphint_keypad", "off");
    player scripts\mp\gametypes\br_pickups::removeaccesscard();
    return;
  }

  if(soundexists("br_keypad_deny")) {
    playsoundatpos(player.origin, "br_keypad_deny");
  }

  instance setscriptablepartstate("maphint_keypad", "off");
  wait 3;
  instance setscriptablepartstate("maphint_keypad", "on");
}