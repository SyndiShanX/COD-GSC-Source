/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_bunker_loot_vaults.gsc
**********************************************************/

init() {
  level.lootbunkersactive = getdvarint("dvar_48FD1E2273274091", 1);
  level.maxaccesscardspawns_red = getdvarint("dvar_BBA96189687D4AE7", 5);
  level.accesscardsspawned_red = 0;
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_keypad", ::keypadscriptableused);
  _id_56224D01D10EA4D1 = [1, 2, 3, 7, 10];

  if(getdvarint("dvar_DBF8B77EA6CFFC8D", 0) == 1)
    _id_752DEF01B8BFD717 = [0, 1, 2, 3, 4, 5, 6, 7, 9, 10];
  else
    _id_752DEF01B8BFD717 = [0, 4, 5, 6, 9];

  level.bunker_loot_vaults = spawnStruct();
  level.bunker_loot_vaults.doors = [];
  level.bunker_loot_vaults.hints = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= 10; _id_AC0E594AC96AA3A8++) {
    _id_AC7A80ECA239EDE7 = "bunker_door_" + _id_AC0E594AC96AA3A8;
    _id_4EA0A8F8E7FB6273 = getaltbunkerindexforname(_id_AC7A80ECA239EDE7);

    if(_id_4EA0A8F8E7FB6273 >= 0) {
      continue;
    }
    doors = getEntArray(_id_AC7A80ECA239EDE7, "targetname");
    level.bunker_loot_vaults.doors[_id_AC0E594AC96AA3A8] = doors[0];

    if(!isDefined(level.bunker_loot_vaults.doors[_id_AC0E594AC96AA3A8])) {
      continue;
    }
    _id_A0636BD2191A4BBC = scripts\engine\utility::array_contains(_id_752DEF01B8BFD717, _id_AC0E594AC96AA3A8) && level.lootbunkersactive;
    level thread _id_7D625073C6379D53::initbunkerdoor(level.bunker_loot_vaults.doors[_id_AC0E594AC96AA3A8], _id_A0636BD2191A4BBC);
    initlootvaultkeypad(_id_A0636BD2191A4BBC, _id_AC0E594AC96AA3A8, scripts\engine\utility::array_contains(_id_56224D01D10EA4D1, _id_AC0E594AC96AA3A8));
  }
}

initlootvaultkeypad(_id_A0636BD2191A4BBC, _id_C0560EA98EA1FC50, _id_2D0E7AC083AD5250, _id_B0BD841CACF6D96D) {
  if(istrue(_id_B0BD841CACF6D96D))
    door = level.br_bunker_alt.bunkervaults.doors[_id_C0560EA98EA1FC50];
  else
    door = level.bunker_loot_vaults.doors[_id_C0560EA98EA1FC50];

  forward = anglesToForward(door.angles);
  left = anglestoleft(door.angles);
  _id_A10AE505A570D67E = undefined;

  if(istrue(_id_2D0E7AC083AD5250))
    _id_A10AE505A570D67E = door.origin + (0, 0, 45) + forward * 50 + left * 97;
  else
    _id_A10AE505A570D67E = door.origin + (0, 0, 45) + forward * 37 + left * 80;

  if(istrue(_id_B0BD841CACF6D96D)) {
    level.br_bunker_alt.bunkervaults.hints[_id_C0560EA98EA1FC50] = spawnscriptable("maphint_keypad_bunker_alt", _id_A10AE505A570D67E);
    level.br_bunker_alt.bunkervaults.hints[_id_C0560EA98EA1FC50].isopenable = _id_A0636BD2191A4BBC;
    level.br_bunker_alt.bunkervaults.hints[_id_C0560EA98EA1FC50].door = door;
  } else {
    level.bunker_loot_vaults.hints[_id_C0560EA98EA1FC50] = spawnscriptable("maphint_keypad", _id_A10AE505A570D67E);
    level.bunker_loot_vaults.hints[_id_C0560EA98EA1FC50].isopenable = _id_A0636BD2191A4BBC;
    level.bunker_loot_vaults.hints[_id_C0560EA98EA1FC50].door = door;
  }
}

keypadscriptableused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level thread _keypadscriptableused(instance, part, state, player, _id_A5B2C541413AA895);
}

_keypadscriptableused(instance, part, state, player, _id_A5B2C541413AA895) {
  _id_B0BD841CACF6D96D = _id_5619B47BC99C8F44::isaltbunkerscriptable(instance);

  if(istrue(instance.backwallkeypad)) {
    if(soundexists("br_keypad_deny"))
      playsoundatpos(player.origin, "br_keypad_deny");

    instance setscriptablepartstate("maphint_keypad", "off");
    wait 3;
    instance setscriptablepartstate("maphint_keypad", "on");
  } else if(getdvarint("dvar_8C6E1C43E3D41DD3", 0) == 1 || istrue(instance.isopenable) && player _id_2CEDCC356F1B9FC8::hasaccesscard()) {
    level thread _id_7D625073C6379D53::openbunkerdoor(instance.door, 1, "bunker_loot_shared", "door_open");
    instance setscriptablepartstate("maphint_keypad", "off");
    player _id_7E52B56769FA7774::removeaccesscard();
  } else {
    if(soundexists("br_keypad_deny"))
      playsoundatpos(player.origin, "br_keypad_deny");

    instance setscriptablepartstate("maphint_keypad", "off");
    wait 3;
    instance setscriptablepartstate("maphint_keypad", "on");
  }
}