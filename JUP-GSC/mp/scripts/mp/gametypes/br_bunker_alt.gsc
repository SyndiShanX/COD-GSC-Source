/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_bunker_alt.gsc
*****************************************************/

#using script_64acb6ce534155b7;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_bunker_alt;
#using scripts\mp\gametypes\br_bunker_loot_vaults;
#using scripts\mp\gametypes\br_bunker_utility;
#using scripts\mp\gametypes\br_keypad_util;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\teams;
#namespace br_bunker_alt;

function isbunkeraltenabled() {
  return getdvarint(@ "scr_br_bunker_alt_enabled", 1);
}

function initnonbunkerdoors() {
  if(!isDefined(level.br_bunker_alt)) {
    level.br_bunker_alt = spawnStruct();
  }

  level.br_bunker_alt.nonbunkerdoors = [];
  level.br_bunker_alt.nonbunkerdoors["barn"] = getentitylessscriptablearray("br_bunker_alt_barn", "script_noteworthy");
  level.br_bunker_alt.nonbunkerdoors["outhouse"] = getentitylessscriptablearray("br_bunker_alt_outhouse", "script_noteworthy");
  level.br_bunker_alt.nonbunkerdoors["shed_01"] = getentitylessscriptablearray("br_bunker_alt_shed_01", "script_noteworthy");
  level.br_bunker_alt.nonbunkerdoors["shed_02"] = getentitylessscriptablearray("br_bunker_alt_shed_02", "script_noteworthy");
}

function init() {
  if(!isbunkeraltenabled()) {
    return;
  }

  level.br_bunker_alt = spawnStruct();
  initnonbunkerdoors();
  level.br_bunker_alt.bunkervaults = spawnStruct();
  level.br_bunker_alt.bunkervaults.doors = [];
  level.br_bunker_alt.bunkervaults.hints = [];
  [level.br_bunker_alt.bunkervaults.doors[1]] = getEntArray("bunker_door_" + 1, "targetname");
  [level.br_bunker_alt.bunkervaults.doors[3]] = getEntArray("bunker_door_" + 3, "targetname");
  [level.br_bunker_alt.bunkervaults.doors[10]] = getEntArray("bunker_door_" + 10, "targetname");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_keypad_bunker_alt", &keypadscriptableused_altbunker);
  level thread initpostmain();
}

function initnonbr() {
  initnonbunkerdoors();
  level thread locknonbunkerdoors();
}

function initbrmechanics() {
  initnonbunkerdoors();
  level initnonbunkerdoorkeypad();
  level scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_keypad_bunker_alt", &keypadscriptableused_altbunker);
  level thread locknonbunkerdoors();
}

function initpostmain() {
  waittillframeend();
  openable = 1;
  ignorelightfx = 1;
  level thread scripts\mp\gametypes\br_bunker_utility::initbunkerdoor(level.br_bunker_alt.bunkervaults.doors[1], openable, ignorelightfx);
  level thread scripts\mp\gametypes\br_bunker_utility::initbunkerdoor(level.br_bunker_alt.bunkervaults.doors[3], openable, ignorelightfx);
  level thread scripts\mp\gametypes\br_bunker_utility::initbunkerdoor(level.br_bunker_alt.bunkervaults.doors[10], openable, ignorelightfx);

  if(getdvarint(@ "scr_br_bunker_alt_keypad_enable", 0)) {
    forwardfacing = 1;
    altbunker = 1;
    level scripts\mp\gametypes\br_bunker_loot_vaults::initlootvaultkeypad(openable, 1, forwardfacing, altbunker);
    level scripts\mp\gametypes\br_bunker_loot_vaults::initlootvaultkeypad(openable, 3, forwardfacing, altbunker);
    level scripts\mp\gametypes\br_bunker_loot_vaults::initlootvaultkeypad(openable, 10, forwardfacing, altbunker);
  }

  if(getdvarint(@ "scr_br_bunker_alt_keypad_enable", 0)) {
    level initnonbunkerdoorkeypad();
  }

  level thread locknonbunkerdoors();
}

function locknonbunkerdoors() {
  var_b0d0a442c6392a74 = getdvarint(@ "hash_c9065088441a5ba4", 10);
  wait var_b0d0a442c6392a74;

  foreach(var_a8d50c407151b462 in level.br_bunker_alt.nonbunkerdoors) {
    foreach(nonbunkerdoor in var_a8d50c407151b462) {
      nonbunkerdoor scriptabledoorfreeze(1);
    }
  }
}

function initnonbunkerdoorkeypad() {
  if(!getdvarint(@ "scr_br_bunker_alt_keypad_enable", 0)) {
    return;
  }

  foreach(var_9d5e1298a954ed30, var_a8d50c407151b462 in level.br_bunker_alt.nonbunkerdoors) {
    if(!isDefined(var_a8d50c407151b462[0])) {
      continue;
    }

    firstdoor = var_a8d50c407151b462[0];
    seconddoor = var_a8d50c407151b462[1];
    forwardangles = anglesToForward(firstdoor.angles);
    var_a62cf356aa492c1c = anglestoleft(firstdoor.angles);

    switch (var_9d5e1298a954ed30) {
      case #"hash_51929d2eb8e4fbfc":
        forwardscale = 72;
        leftscale = -10;
        break;
      case #"hash_c38a833e41a93969":
        forwardscale = -28;
        leftscale = 10;
        break;
      case #"hash_ad3a177bd9ddb713":
        forwardscale = 62;
        leftscale = -10;
        break;
      case #"hash_ad3a187bd9ddb8a6":
        forwardscale = 62;
        leftscale = 10;
        break;
      default:
        forwardscale = 0;
        leftscale = 0;
        assertmsg("<dev string:x1c>");
        break;
    }

    hintorigin = firstdoor.origin + (0, 0, 45) + forwardangles * forwardscale + var_a62cf356aa492c1c * leftscale;
    var_f09ab32f4c0bf6e2 = spawnscriptable("maphint_keypad_bunker_alt", hintorigin);
    var_f09ab32f4c0bf6e2.door = firstdoor;

    if(isDefined(seconddoor)) {
      var_f09ab32f4c0bf6e2.door2 = seconddoor;
    }
  }
}

function isaltbunkerscriptable(keypadscriptableinstance) {
  bunkerindex = getaltbunkerkeypadindexforscriptable(keypadscriptableinstance);

  if(bunkerindex >= 0) {
    return true;
  }

  return false;
}

function getaltbunkerkeypadindexforscriptable(keypadscriptableinstance) {
  if(!isbunkeraltenabled()) {
    return -1;
  }

  bunkername = getbunkernamefromkeypadscriptableinstance(keypadscriptableinstance);

  if(!isstring(bunkername)) {
    return -1;
  }

  bunkerindex = getaltbunkerindexforname(bunkername);
  return bunkerindex;
}

function getbunkernamefromkeypadscriptableinstance(keypadscriptableinstance) {
  if(isDefined(keypadscriptableinstance) && isDefined(keypadscriptableinstance.door)) {
    if(isDefined(keypadscriptableinstance.door.targetname)) {
      return keypadscriptableinstance.door.targetname;
    } else if(isDefined(keypadscriptableinstance.door.script_noteworthy)) {
      return keypadscriptableinstance.door.script_noteworthy;
    }
  }

  return 0;
}

function keypadscriptableused_altbunker(instance, part, state, player, bautouse, usestring) {
  if(!isbunkeraltenabled()) {
    return;
  }

  if(!istrue(instance.inuse)) {
    player thread _keypadscriptableused_bunkeralt(instance, part, state, player, bautouse);
  }
}

function _keypadscriptableused_bunkeralt(instance, part, state, player, bautouse) {
  assert(part == "<dev string:x47>");
  var_b0bd841cacf6d96d = scripts\mp\gametypes\br_bunker_alt::isaltbunkerscriptable(instance);
  assertex(istrue(var_b0bd841cacf6d96d), "<dev string:x64>");
  player notify("_keypadScriptableUsed_bunkerAlt");
  player endon("_keypadScriptableUsed_bunkerAlt");

  if(!scripts\mp\flags::gameflag("prematch_done") && !getdvarint(@ "hash_af01339226d5da59", 0)) {
    return;
  }

  if(getdvarint(@ "hash_cb72ef230bf544ae", 1) && !istrue(self.br_infilstarted)) {
    return;
  }

  var_5f8d7d12c2c0f0fd = getaltbunkerkeypadindexforscriptable(instance);

  if(var_5f8d7d12c2c0f0fd == -1) {
    return;
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() && getdvarint(@ "hash_af01339226d5da59", 0)) {
    iprintlnbold("<dev string:xbc>");
    openaltbunker(instance);
    return;
  }

  if(istrue(instance.inuse)) {
    player iprintlnbold("<dev string:x107>");

    return;
  }

  instance.inuse = 1;

  if(istrue(instance.isdooropened)) {
    player iprintlnbold("<dev string:x12a>");

    return;
  }

  player bunkeralt_playerinteractwithkeypadloop(var_5f8d7d12c2c0f0fd, instance);

  if(isDefined(player)) {
    player playersetkeypadstateindex(0);
  }

  instance.inuse = undefined;
}

function bunkeralt_playerinteractwithkeypadloop(var_5f8d7d12c2c0f0fd, instance) {
  level endon("game_ended");
  self endon("bunkerAlt_kickPlayerFromKeypadMSG");
  thread bunkeralt_damagedeathdisconnectwatch();
  thread bunkeralt_playeridlewatch();
  playersetkeypadstateindex(1);
  playersetkeypadcodelengthindex(8);

  while(isDefined(self) && getkeypadstatefromomnvar() != 0) {
    self waittill("luinotifyserver", message, value);

    if(isDefined(message)) {
      if(message == "submit_br_keypad") {
        if(getdvarint(@ "scr_br_bunker_alt_refresh_idle_timer_on_try", 0)) {
          thread bunkeralt_playeridlewatch();
        }

        if(verifybunkercode(var_5f8d7d12c2c0f0fd, value) && getdvarint(hashcat(@ "hash_7b8e27e53a0ff743", var_5f8d7d12c2c0f0fd), 0)) {
          playersetkeypadstateindex(2);
          level thread waittoopenaltbunker(instance);
          break;
        } else {
          if(soundexists("br_keypad_deny")) {
            playsoundatpos(self.origin, "br_keypad_deny");
          }

          playersetkeypadstateindex(3);
          waitframe();

          if(isDefined(self)) {
            playersetkeypadstateindex(1);
          }
        }

        continue;
      }

      if(message == "exit_br_keypad") {
        break;
      }
    }
  }
}

function bunkeralt_damagedeathdisconnectwatch() {
  self endon("bunkerAlt_kickPlayerFromKeypadMSG");
  level endon("game_ended");
  waittill_any_3("death", "disconnect", "damage");
  self notify("bunkerAlt_kickPlayerFromKeypadMSG");
}

function bunkeralt_playeridlewatch() {
  self endon("bunkerAlt_kickPlayerFromKeypadMSG");
  self notify("bunkerAlt_playerIdleWatch");
  self endon("bunkerAlt_playerIdleWatch");
  wait getdvarint(@ "hash_a7f55bd602c77336", 30);
  self notify("bunkerAlt_kickPlayerFromKeypadMSG");
}

function waittoopenaltbunker(var_9ddc5b150db39159) {
  level endon("game_ended");
  var_9ddc5b150db39159.isdooropened = 1;
  wait getdvarint(@ "hash_487f91ad6699c497", 2);
  level openaltbunker(var_9ddc5b150db39159);
}

function openaltbunker(var_9ddc5b150db39159) {
  if(isbunkeraltenabled()) {
    if(isDefined(var_9ddc5b150db39159.door.targetname)) {
      level thread scripts\mp\gametypes\br_bunker_utility::openbunkerdoor(var_9ddc5b150db39159.door, 0, "bunker_loot_shared", "door_open");
      var_9ddc5b150db39159 setscriptablepartstate("maphint_keypad_bunker_alt", "off");
      return;
    }

    if(isDefined(var_9ddc5b150db39159.door.script_noteworthy)) {
      var_9ddc5b150db39159.door scriptabledooropen("away", var_9ddc5b150db39159.origin);

      if(isDefined(var_9ddc5b150db39159.door2)) {
        var_9ddc5b150db39159.door2 scriptabledooropen("away", var_9ddc5b150db39159.origin);
      }

      var_9ddc5b150db39159 setscriptablepartstate("maphint_keypad_bunker_alt", "off");
      return;
    }

    assertmsg("<dev string:x151>");
  }
}