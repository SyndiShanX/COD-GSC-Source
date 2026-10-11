/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_bunker_numberstation.gsc
***************************************************************/

#using script_64acb6ce534155b7;
#using scripts\cp_mp\challenges;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_bunker_utility;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\hud_message;
#using scripts\mp\playerlogic;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\teams;
#namespace br_bunker_numberstation;

function init() {
  level.bunker11puzzleactive = getdvarint(@ "hash_2b4e25fd276456be", 1);
  scripts\mp\flags::gameflaginit("stop_phone_code_ringing", 0);
  level.bunker_numberstation = spawnStruct();
  [level.bunker_numberstation.door] = getEntArray("bunker_door_11", "targetname");
  level.bunker_numberstation.hints["keypad"] = [];
  initbunker11keypad();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_keypad_bunker_11", &keypadscriptableused);

  if(level.bunker11puzzleactive) {
    level.bunker_numberstation.hints = [];
    level.bunker_numberstation.hints["phones_code"] = [];
    level.bunker_numberstation.hints["phones_morse"] = [];
    initvo();
    level.bunker_numberstation.code = [];
    level.bunker_numberstation.codeentered = [];
    level.bunker_numberstation.successfulteams = [];
    level.bunker_numberstation.teamcodeprogress = [];
    level.bunker_numberstation.codecorrectlyenteredbyanyone = 0;
    level.bunker_numberstation.bunkeropened = 0;
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_0", &phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_1", &phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_2", &phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_3", &phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_4", &phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_5", &phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_6", &phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_7", &phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_8", &phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_9", &phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_code", &codephonescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_computer_reboot", &computerrebootused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_red_button", &redbuttonused);
  }

  level thread initpostmain();
}

function initpostmain() {
  waittillframeend();
  level thread scripts\mp\gametypes\br_bunker_utility::initbunkerdoor(level.bunker_numberstation.door, 0);

  if(!level.bunker11puzzleactive) {
    return;
  }

  if(level.mapname == "mp_bm_bunker01") {
    initlocs_bunkertest();
  } else {
    initlocs_donetsk();
  }

  if(false) {
    level thread debug_hintadjustmentthink();
  }

  if(getdvarint(@ "hash_664ec58759f1617", 0)) {
    level thread debug_bunkerpuzzledebugdraw();
  }

  level thread function_138da425d10b4a04();

  scripts\mp\flags::gameflagwait("prematch_done");
  codelength = getdvarint(@ "hash_4bb3dd5af7368f36", 3);
  generatenumbercode(codelength, level.bunker_numberstation);
  level thread phonesringing_singlemorse();
  level thread phonesringing_code();
  level thread scripts\mp\gametypes\br_pickups::registeruniquelootcallback(1, &awardbunker11blueprint);

  if(false) {
    computerrebootsequence_init();
    redbutton_init();
  }
}

function initvo() {
  level.bunker11vo = [];
  level.bunker11vo["VO_MORSE_0"] = "dx_bra_rubc_bunker_keypad_0_10";
  level.bunker11vo["VO_MORSE_1"] = "dx_bra_rubc_bunker_keypad_1_10";
  level.bunker11vo["VO_MORSE_2"] = "dx_bra_rubc_bunker_keypad_2_10";
  level.bunker11vo["VO_MORSE_3"] = "dx_bra_rubc_bunker_keypad_3_10";
  level.bunker11vo["VO_MORSE_4"] = "dx_bra_rubc_bunker_keypad_4_10";
  level.bunker11vo["VO_MORSE_5"] = "dx_bra_rubc_bunker_keypad_5_10";
  level.bunker11vo["VO_MORSE_6"] = "dx_bra_rubc_bunker_keypad_6_10";
  level.bunker11vo["VO_MORSE_7"] = "dx_bra_rubc_bunker_keypad_7_10";
  level.bunker11vo["VO_MORSE_8"] = "dx_bra_rubc_bunker_keypad_8_10";
  level.bunker11vo["VO_MORSE_9"] = "dx_bra_rubc_bunker_keypad_9_10";
  level.bunker11vo["VO_OK_THATS_GOOD"] = "dx_bra_rubc_bunker_code_correct_10";
  level.bunker11vo["VO_NORTH_SECURE"] = "dx_bra_rubc_bunker_code_correct_20";
  level.bunker11vo["VO_BURN_TEAM_INBOUND"] = "dx_bra_rubc_bunker_code_correct_30";
  level.bunker11vo["VO_BASE_OVERRUN"] = "dx_bra_rubc_bunker_code_phone_10";
  level.bunker11vo["VO_STAND_BY"] = "dx_bra_rubc_bunker_code_phone_20";
  level.bunker11vo["VO_HEAR_THAT"] = "dx_bra_rubc_bunker_code_phone_30";
  level.bunker11vo["VO_LOCK_DOOR"] = "dx_bra_rubc_bunker_code_phone_40";
  level.bunker11vo["VO_NEGATIVE"] = "dx_bra_rubc_bunker_code_incorrect_10";
  level.bunker11vo["VO_WILL_COMPLY"] = "dx_bra_rubc_bunker_code_incorrect_20";
}

function initbunker11keypad() {
  door = level.bunker_numberstation.door;
  forward = anglesToForward(door.angles);
  left = anglestoleft(door.angles);
  hintorigin = door.origin + (0, 0, 45) + forward * 37 + left * 80;
  level.bunker_numberstation.hints["keypad"][0] = spawnscriptable("maphint_keypad_bunker_11", hintorigin);
}

function initlocs_donetsk() {
  initlocs_morsephones();
  initlocs_codeprovidingphones();
}

function initlocs_morsephones() {
  level.bunker_numberstation.hints["phones_morse"] = [];
  level.bunker_numberstation.hints["phones_morse"][0] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][0].origin = (3953, 46915, 1332);
  level.bunker_numberstation.hints["phones_morse"][1] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][1].origin = (23155, -18208, -22);
  level.bunker_numberstation.hints["phones_morse"][2] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][2].origin = (13949, 33510, 1665);
  level.bunker_numberstation.hints["phones_morse"][3] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][3].origin = (35858, 46586, 775);
  level.bunker_numberstation.hints["phones_morse"][3].sound = "br_phone_ring_1";
  level.bunker_numberstation.hints["phones_morse"][4] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][4].origin = (47165, 19980, -160);
  level.bunker_numberstation.hints["phones_morse"][5] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][5].origin = (15038, 16890, 195);
  level.bunker_numberstation.hints["phones_morse"][6] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][6].origin = (-22115, 27122, 1170);
  level.bunker_numberstation.hints["phones_morse"][6].sound = "br_phone_ring_2";
  level.bunker_numberstation.hints["phones_morse"][7] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][7].origin = (-21992, 18882, -330);
  level.bunker_numberstation.hints["phones_morse"][8] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][8].origin = (9911, -12258, -236);
  level.bunker_numberstation.hints["phones_morse"][9] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][9].origin = (-25179, 45438, 155);
  level.bunker_numberstation.hints["phones_morse"][9].sound = "br_phone_ring_2";

  foreach(index, hint in level.bunker_numberstation.hints["phones_morse"]) {
    hint.scriptable = spawnscriptable("maphint_phone_morse_" + index, hint.origin);
    hint.scriptable.ringing = 0;

    if(isDefined(hint.sound)) {
      hint.scriptable.sound = hint.sound;
    }
  }
}

function initlocs_codeprovidingphones() {
  level.bunker_numberstation.hints["phones_code"] = [];
  level.bunker_numberstation.hints["phones_code"][0] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][0].origin = (-12202, -26944, 20);
  level.bunker_numberstation.hints["phones_code"][1] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][1].origin = (-16380, -19702, -257);
  level.bunker_numberstation.hints["phones_code"][2] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][2].origin = (-28148, -18152, -165);
  level.bunker_numberstation.hints["phones_code"][3] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][3].origin = (19472, -21677, 28);
  level.bunker_numberstation.hints["phones_code"][4] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][4].origin = (21075, -15890, 1690);
  level.bunker_numberstation.hints["phones_code"][5] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][5].origin = (-6430, 1817, -250);
  level.bunker_numberstation.hints["phones_code"][6] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][6].origin = (2448, 29023, 80);
  level.bunker_numberstation.hints["phones_code"][7] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][7].origin = (15510, 18142, 193);
  level.bunker_numberstation.hints["phones_code"][8] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][8].origin = (45105, 16910, -312);
  level.bunker_numberstation.hints["phones_code"][9] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][9].origin = (14565, 36646, 1500);
  level.bunker_numberstation.hints["phones_code"][10] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][10].origin = (-24445, 43755, -118);
  level.bunker_numberstation.hints["phones_code"][10].sound = "br_phone_ring_2";
  level.bunker_numberstation.hints["phones_code"][11] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][11].origin = (-15246, 14332, -25);
  level.bunker_numberstation.hints["phones_code"][12] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][12].origin = (34305, 28940, 838);
  level.bunker_numberstation.hints["phones_code"][13] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][13].origin = (-2836, 57277, 661);
  level.bunker_numberstation.hints["phones_code"][14] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][14].origin = (36572, -29087, -462);
  level.bunker_numberstation.hints["phones_code"][15] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][15].origin = (16505, 2990, -530);
  level.bunker_numberstation.hints["phones_code"][16] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][16].origin = (45714, 1250, 80);

  foreach(hint in level.bunker_numberstation.hints["phones_code"]) {
    hint.scriptable = spawnscriptable("maphint_phone_code", hint.origin);
    hint.scriptable.ringing = 0;

    if(isDefined(hint.sound)) {
      hint.scriptable.sound = hint.sound;
    }
  }
}

function awardbunker11blueprint(player) {
  foreach(teammate in getteamdata(player.team, "players")) {
    if(!isDefined(teammate)) {
      continue;
    }

    teammate scripts\cp_mp\challenges::onunlockitem("blueprint_unlock_584");
    teammate scripts\mp\analyticslog::logevent_challengeitemunlocked(teammate, "blueprint_unlock_584", "blueprint", 584);
    optionalnumber = 0;

    if(optionalnumber > 0) {
      teammate thread scripts\mp\hud_message::showsplash("br_unlockable_weapon_splash", optionalnumber);
    }
  }

  return true;
}

function codephonescriptableused(instance, part, state, player, bautouse, usestring) {
  assert(part == "<dev string:x1c>");
  level thread _codephonescriptableused(instance, part, state, player, bautouse);
}

function _codephonescriptableused(instance, part, state, player, bautouse) {
  if(state == "on") {
    if((!scripts\mp\flags::gameflag("prematch_done") || !istrue(instance.startingcodephone)) && level.bunker_numberstation.successfulteams.size == 0) {
      playsoundatpos(instance.origin, "br_phone_deny");
      instance setscriptablepartstate("maphint_phone_code", "off");
      wait 3;
      instance setscriptablepartstate("maphint_phone_code", "on");
      return;
    }

    player scripts\mp\playerlogic::playerhasmoved();
    instance setscriptablepartstate("maphint_phone_code", "off");

    while(istrue(instance.ringing)) {
      waitframe();
    }

    instance notify("phone_picked_up");

    if(level.bunker_numberstation.successfulteams.size > 0) {
      playsoundatpos(instance.origin, "br_phone_code_correct");
      wait 1;
      playsoundatpos(instance.origin, level.bunker11vo["VO_NORTH_SECURE"]);
      level thread debug_show2dvotext("North Secure", 1.24);
      wait 1.24;
      playsoundatpos(instance.origin, level.bunker11vo["VO_NORTH_SECURE"]);
      level thread debug_show2dvotext("North Secure", 2);
      wait 2;
      playsoundatpos(instance.origin, level.bunker11vo["VO_OK_THATS_GOOD"]);
      level thread debug_show2dvotext("Ok. That's good.", 2);
      wait 2;
      playsoundatpos(instance.origin, level.bunker11vo["VO_BURN_TEAM_INBOUND"]);
      level thread debug_show2dvotext("Copy. Burn team inbound.", 2);
      wait 2;
      playsoundatpos(instance.origin, "br_phone_code_correct");
      wait 1;

      foreach(number in level.bunker_numberstation.code) {
        playsoundatpos(instance.origin, level.bunker11vo["VO_MORSE_" + number]);
        wait 1.5;
      }

      playsoundatpos(instance.origin, "br_phone_code_correct");
    } else {
      wait 1;
      playsoundatpos(instance.origin, level.bunker11vo["VO_BASE_OVERRUN"]);
      level thread debug_show2dvotext("All teams. Base has been overun. Switch to cryptography.", 3);
      wait 3;
      playsoundatpos(instance.origin, level.bunker11vo["VO_STAND_BY"]);
      level thread debug_show2dvotext("Stand By", 2);
      wait 2;
      playsoundatpos(instance.origin, "br_phone_code_correct");
      wait 1;

      foreach(number in level.bunker_numberstation.code) {
        playsoundatpos(instance.origin, level.bunker11vo["VO_MORSE_" + number]);
        wait 1.5;
      }

      playsoundatpos(instance.origin, "br_phone_code_correct");
      wait 1;
      playsoundatpos(instance.origin, level.bunker11vo["VO_HEAR_THAT"]);
      level thread debug_show2dvotext("You hear that?", 2);
      wait 2;
      playsoundatpos(instance.origin, level.bunker11vo["VO_LOCK_DOOR"]);
      level thread debug_show2dvotext("Lock the door! They're coming!", 2);
    }

    wait 3;
    instance setscriptablepartstate("maphint_phone_code", "on");
    instance thread ringphoneoccasionally();
  }
}

function phonemorsesinglescriptableused(instance, part, state, player, bautouse, usestring) {
  assert(part == "<dev string:x32>" || part == "<dev string:x4b>" || part == "<dev string:x64>" || part == "<dev string:x7d>" || part == "<dev string:x96>" || part == "<dev string:xaf>" || part == "<dev string:xc8>" || part == "<dev string:xe1>" || part == "<dev string:xfa>" || part == "<dev string:x113>");

  switch (part) {
    case #"hash_a45da4772fdfaea5":
      instance.morsenumber = 0;
      break;
    case #"hash_a45da3772fdfad12":
      instance.morsenumber = 1;
      break;
    case #"hash_a45da2772fdfab7f":
      instance.morsenumber = 2;
      break;
    case #"hash_a45da1772fdfa9ec":
      instance.morsenumber = 3;
      break;
    case #"hash_a45da0772fdfa859":
      instance.morsenumber = 4;
      break;
    case #"hash_a45d9f772fdfa6c6":
      instance.morsenumber = 5;
      break;
    case #"hash_a45d9e772fdfa533":
      instance.morsenumber = 6;
      break;
    case #"hash_a45d9d772fdfa3a0":
      instance.morsenumber = 7;
      break;
    case #"hash_a45dac772fdfbb3d":
      instance.morsenumber = 8;
      break;
    case #"hash_a45dab772fdfb9aa":
      instance.morsenumber = 9;
      break;
    default:
      assertmsg("<dev string:x12c>");
      break;
  }

  level thread _phonemorsesinglescriptableused(instance, part, state, player, bautouse);
}

function _phonemorsesinglescriptableused(instance, part, state, player, bautouse) {
  if(state == "on") {
    team = player.team;

    if(!scripts\mp\flags::gameflag("prematch_done")) {
      playsoundatpos(instance.origin, "br_morse_" + instance.morsenumber);
      instance setscriptablepartstate("maphint_phone_morse_" + instance.morsenumber, "off");
      wait 3;
      instance setscriptablepartstate("maphint_phone_morse_" + instance.morsenumber, "on");
      return;
    }

    player scripts\mp\playerlogic::playerhasmoved();
    instance setscriptablepartstate("maphint_phone_morse_" + instance.morsenumber, "off");

    while(istrue(instance.ringing)) {
      waitframe();
    }

    instance notify("phone_picked_up");

    if(level.bunker_numberstation.successfulteams.size > 0) {
      playsoundatpos(instance.origin, "br_phone_code_correct");
      wait 1;
      playsoundatpos(instance.origin, level.bunker11vo["VO_NORTH_SECURE"]);
      level thread debug_show2dvotext("North Secure", 1.24);
      wait 1.24;
      playsoundatpos(instance.origin, level.bunker11vo["VO_NORTH_SECURE"]);
      level thread debug_show2dvotext("North Secure", 2);
      wait 2;
      playsoundatpos(instance.origin, level.bunker11vo["VO_BURN_TEAM_INBOUND"]);
      level thread debug_show2dvotext("Copy. Burn team inbound.", 2);
      wait 2;
    }

    if(!array_contains(level.bunker_numberstation.successfulteams, team)) {
      playsoundatpos(instance.origin, "br_morse_" + instance.morsenumber);
      wait 2;

      if(!array_contains(level.bunker_numberstation.successfulteams, team)) {
        entercodenumber(level.bunker_numberstation, instance.morsenumber, team);
        codestatus = checkcodeentered(level.bunker_numberstation, team);

        if(codestatus == 1) {
          level thread correctcodeentered(instance, level.bunker_numberstation, team);
        } else if(codestatus == 0) {
          level thread incorrectcodeentered(instance, level.bunker_numberstation, team);
        }
      }
    }

    wait 3;
    instance setscriptablepartstate("maphint_phone_morse_" + instance.morsenumber, "on");
    instance thread ringphoneoccasionally();
  }
}

function keypadscriptableused(instance, part, state, player, bautouse, usestring) {
  level thread _keypadscriptableused(instance, part, state, player, bautouse);
}

function _keypadscriptableused(instance, part, state, player, bautouse) {
  assert(part == "<dev string:x17c>");

  if(level.bunker11puzzleactive && (getdvarint(@ "hash_2b47e76d55a2b0b2", 0) == 1 || array_contains(level.bunker_numberstation.successfulteams, player.team))) {
    playsoundatpos(instance.origin, "br_keypad_confirm");
    instance setscriptablepartstate("maphint_keypad_bunker_11", "off");
    wait 2.5;
    level thread scripts\mp\gametypes\br_bunker_utility::openbunkerdoor(level.bunker_numberstation.door, 1, "bunker_loot_11", "door_open_puzzle");
    level.bunker_numberstation.bunkeropened = 1;
    level thread activatemusictrigger();

    if(true) {
      computerrebootsequence_init();
      redbutton_init();
    }

    return;
  }

  playsoundatpos(instance.origin, "br_keypad_deny");
  instance setscriptablepartstate("maphint_keypad_bunker_11", "off");
  wait 3;
  instance setscriptablepartstate("maphint_keypad_bunker_11", "on");
}

function activatemusictrigger() {
  forward = anglesToForward(level.bunker_numberstation.door.angles);
  trigger = spawn("trigger_radius", level.bunker_numberstation.door.origin + forward * -128, 0, 128, 128);
  level thread musictriggerthink(trigger);
  wait 120;
  trigger notify("endMusicTrigger");
  trigger delete();
}

function musictriggerthink(trigger) {
  trigger endon("endMusicTrigger");

  while(true) {
    trigger waittill("trigger", player);
    waitframe();

    if(!isDefined(player)) {
      continue;
    }

    if(!isPlayer(player)) {
      continue;
    }

    if(!isalive(player)) {
      continue;
    }

    if(istrue(player.bunkermusicstarted)) {
      continue;
    }

    player.bunkermusicstarted = 1;
    player setplayermusicstate("br_bunker_reveal");
  }
}

function phonesringing_code() {
  var_e2c22b9bab4c4908 = getdvarint(@ "hash_9f70d8030533cf20", 50);
  var_e40f74266c39d166 = max(1, level.bunker_numberstation.hints["phones_code"].size * var_e2c22b9bab4c4908 * 0.01);
  level.bunker_numberstation.hints["phones_code"] = array_randomize(level.bunker_numberstation.hints["phones_code"]);
  var_f557519e38cbe212 = [];

  for(i = 0; i < int(var_e40f74266c39d166); i++) {
    var_f557519e38cbe212[var_f557519e38cbe212.size] = level.bunker_numberstation.hints["phones_code"][i];
  }

  foreach(phonelocation in var_f557519e38cbe212) {
    phonelocation.scriptable.startingcodephone = 1;
    phonelocation.scriptable thread ringcodephoneconstantly();
    phonelocation.scriptable setscriptablepartstate("maphint_phone_code", "on");
  }

  level.bunker_numberstation.chosencodephones = var_f557519e38cbe212;
}

function phonesringing_singlemorse() {
  foreach(phonelocation in level.bunker_numberstation.hints["phones_morse"]) {
    phonelocation.scriptable thread ringphoneoccasionally();
  }
}

function codephonescodeenteredringingfrenzy() {
  level thread tracktimeringingfrenzy();

  foreach(phonelocation in level.bunker_numberstation.hints["phones_code"]) {
    if(!istrue(phonelocation.scriptable.startingcodephone)) {
      phonelocation.scriptable thread ringcodephoneconstantly();
      phonelocation.scriptable setscriptablepartstate("maphint_phone_code", "on");
    }
  }
}

function ringphoneoccasionally() {
  self endon("phone_picked_up");
  wait randomintrange(30, 55);

  while(!istrue(level.bunker_numberstation.bunkeropened)) {
    for(i = 0; i < 4; i++) {
      self.ringing = 1;

      if(true) {
        if(isDefined(self.sound)) {
          playsoundatpos(self.origin, self.sound);
        } else {
          playsoundatpos(self.origin, "br_phone_ring");
        }
      }

      if(false) {
        thread scripts\mp\utility\debug::drawsphere(self.origin, 32, 3, (0, 1, 0));
      }

      wait 3;
      self.ringing = 0;
      wait 3;
    }

    wait randomintrange(30, 55);
  }
}

function ringcodephoneconstantly() {
  self endon("phone_picked_up");

  while(!scripts\mp\flags::gameflag("stop_phone_code_ringing")) {
    self.ringing = 1;

    if(true) {
      if(isDefined(self.sound)) {
        playsoundatpos(self.origin, self.sound);
      } else {
        playsoundatpos(self.origin, "br_phone_ring");
      }
    }

    if(false) {
      thread scripts\mp\utility\debug::drawsphere(self.origin, 32, 3, (1, 0, 0));
    }

    wait 3;
    self.ringing = 0;
    wait 3;
  }
}

function tracktimeringingfrenzy() {
  wait 120;
  scripts\mp\flags::gameflagset("stop_phone_code_ringing");
}

function computerrebootsequence_init() {
  level.serverroomtvs = getStructArray("bunker11_serverTV", "targetname");
  level.warroomtvs = getStructArray("bunker11_warroomTV", "targetname");
  var_15e3f6188a142829 = getStructArray("bunker11_serverroom_computer", "targetname");
  spawnscriptable("maphint_computer_reboot", var_15e3f6188a142829[0].origin);

  foreach(index, tv in level.serverroomtvs) {
    level.serverroomtvs[index].scriptable = spawnscriptable("bunker11_serverroom_monitor", tv.origin, tv.angles);
  }

  foreach(index, tv in level.warroomtvs) {
    level.warroomtvs[index].scriptable = spawnscriptable("bunker11_warroom_monitor", tv.origin, tv.angles);
  }
}

function computerrebootused(instance, part, state, player, bautouse, usestring) {
  level thread _computerrebootsequence_start(instance, player);
}

function _computerrebootsequence_start(instance, player) {
  instance setscriptablepartstate("maphint_computer_reboot", "off");
  playsoundatpos(instance.origin, "emt_bunk_pc_keyboard_typing");
  wait 3;
  playsoundatpos(instance.origin, "emt_bunk_pc_reboot");

  foreach(tv in level.serverroomtvs) {
    tv.scriptable setscriptablepartstate("bunker11_serverroom_monitor", "rebooting");
  }

  foreach(tv in level.warroomtvs) {
    tv.scriptable setscriptablepartstate("bunker11_warroom_monitor", "rebooting");
    wait randomfloatrange(0.3, 0.6);
  }

  wait 3;

  foreach(tv in level.serverroomtvs) {
    tv.scriptable setscriptablepartstate("bunker11_serverroom_monitor", "ready");
    wait randomfloatrange(0.3, 0.6);
  }

  foreach(tv in level.warroomtvs) {
    tv.scriptable setscriptablepartstate("bunker11_warroom_monitor", "countdown");
  }

  instance setscriptablepartstate("maphint_computer_reboot", "on");
}

function redbutton_init() {
  redbutton = getStructArray("bunker11_red_button", "targetname");
  level.bunker11_mistswindow = getStructArray("bunker11_cleanroom_window", "targetname");
  level.bunker11_mistsdoors = getStructArray("bunker11_cleanroom_door", "targetname");
  spawnscriptable("maphint_red_button", redbutton[0].origin);

  foreach(index, window in level.bunker11_mistswindow) {
    angles = (0, 0, 0);

    if(isDefined(window.angles)) {
      angles = window.angles;
    }

    level.bunker11_mistswindow[index].scriptable = spawnscriptable("bunker11_cleanroom_mist", window.origin, angles);
  }

  foreach(index, door in level.bunker11_mistsdoors) {
    angles = (0, 0, 0);

    if(isDefined(door.angles)) {
      angles = door.angles;
    }

    level.bunker11_mistsdoors[index].scriptable = spawnscriptable("bunker11_cleanroom_mist_door", door.origin, angles);
  }
}

function redbuttonused(instance, part, state, player, bautouse, usestring) {
  level thread _redbuttonused_internal(instance, player);
}

function _redbuttonused_internal(instance, player) {
  instance setscriptablepartstate("maphint_red_button", "off");
  playsoundatpos(instance.origin, "emt_bunk_red_button_press");

  foreach(window in level.bunker11_mistswindow) {
    window.scriptable setscriptablepartstate("bunker11_cleanroom_mist", "off");
  }

  foreach(door in level.bunker11_mistsdoors) {
    door.scriptable setscriptablepartstate("bunker11_cleanroom_mist_door", "off");
  }

  wait 5;
  instance setscriptablepartstate("maphint_red_button", "on");
}

function generatenumbercode(codelength, codestruct) {
  scripts\mp\gametypes\br_bunker_utility::generatenumbercode_array(codelength, codestruct);

  if(false) {
    level thread printcodechosen(codestruct);
    level thread printcodeentered(codestruct);
  }
}

function entercodenumber(codestruct, number, team) {
  if(!isDefined(codestruct.codeentered[team])) {
    codestruct.codeentered[team] = [];
  }

  codestruct.codeentered[team][codestruct.codeentered[team].size] = number;
}

function checkcodeentered(codestruct, team) {
  if(codestruct.codeentered[team].size < codestruct.code.size) {
    return -1;
  }

  for(i = 0; i < codestruct.code.size; i++) {
    if(codestruct.code[i] != codestruct.codeentered[team][i]) {
      return 0;
    }
  }

  return 1;
}

function correctcodeentered(instance, codestruct, team) {
  if(false) {
    level thread showdebugresult("Correct Code Entered!");
  }

  if(codestruct.successfulteams.size == 0) {
    level.bunker_numberstation.door.lightscriptable setscriptablepartstate("bunker_active_indicator_light", "active");
  }

  codestruct.successfulteams[codestruct.successfulteams.size] = team;
  playsoundatpos(instance.origin, "br_phone_code_correct");
  wait 1;
  playsoundatpos(instance.origin, level.bunker11vo["VO_OK_THATS_GOOD"]);
  level thread debug_show2dvotext("Ok. That's good.", 2);
  wait 2;
  playsoundatpos(instance.origin, level.bunker11vo["VO_NORTH_SECURE"]);
  level thread debug_show2dvotext("North Secure", 1.1);
  wait 1.1;
  playsoundatpos(instance.origin, level.bunker11vo["VO_NORTH_SECURE"]);
  level thread debug_show2dvotext("North Secure", 2);
  wait 2;
  playsoundatpos(instance.origin, "br_phone_code_correct");
  wait 1;
  playsoundatpos(instance.origin, level.bunker11vo["VO_BURN_TEAM_INBOUND"]);
  level thread debug_show2dvotext("Copy. Burn team inbound.", 2);
  wait 2;

  if(!level.bunker_numberstation.codecorrectlyenteredbyanyone) {
    codephonescodeenteredringingfrenzy();
    return;
  }

  level.bunker_numberstation.codecorrectlyenteredbyanyone = 1;
}

function incorrectcodeentered(instance, codestruct, team) {
  codestruct.codeentered[team] = undefined;

  if(false) {
    level thread showdebugresult("ERROR: Wrong Code Entered!");
  }

  playsoundatpos(instance.origin, "br_phone_code_incorrect");
  wait 1;
  playsoundatpos(instance.origin, level.bunker11vo["VO_NEGATIVE"]);
  level thread debug_show2dvotext("Negative", 1.24);
  wait 1.24;
  playsoundatpos(instance.origin, level.bunker11vo["VO_NEGATIVE"]);
  level thread debug_show2dvotext("Negative", 1.5);
  wait 1.5;
  playsoundatpos(instance.origin, level.bunker11vo["VO_WILL_COMPLY"]);
  level thread debug_show2dvotext("Copy. Will comply.", 2);
}

function showdebugresult(resulttext) {
  timeshown = 0;

  while(timeshown < 5) {
    printtoscreen2d(500, 500, resulttext, (1, 1, 1), 1);

    waitframe();
    timeshown += 0.05;
  }
}

function printcodechosen(codestruct) {
  level notify("endChosenCodeDebugPrint");
  level endon("endChosenCodeDebugPrint");
  numberspacing = 10;

  while(true) {
    printtoscreen2d(500, 400, "<dev string:x198>", (1, 1, 1), 1);

    if(!scripts\mp\flags::gameflag("prematch_done")) {
      printtoscreen2d(600, 400, "<dev string:x1a9>", (1, 1, 1), 1);
    } else {
      foreach(i, number in codestruct.code) {
        printtoscreen2d(600 + numberspacing * i, 400, codestruct.code[i], (1, 1, 1), 1);
      }
    }

    waitframe();
  }
}

function printcodeentered(codestruct) {
  level notify("endEnterdCodeDebugPrint");
  level endon("endEnterdCodeDebugPrint");
  numberspacing = 10;
  teamspacing = 30;

  while(true) {
    teamindex = 0;

    foreach(team, codegroup in codestruct.codeentered) {
      printtoscreen2d(500, 430 + teamindex * teamspacing, team + "<dev string:x1c5>", (1, 1, 1), 1);

      if(!array_contains(codestruct.successfulteams, team)) {
        foreach(i, number in codestruct.codeentered[team]) {
          printtoscreen2d(700 + numberspacing * i, 430 + teamindex * teamspacing, codestruct.codeentered[team][i], (1, 1, 1), 1);
        }
      } else {
        printtoscreen2d(700, 430 + teamindex * teamspacing, "<dev string:x1f3>", (1, 1, 1), 1);
      }

      teamindex++;
    }

    waitframe();
  }
}

function initlocs_bunkertest() {
  wait 5;
  level.bunker_numberstation.hints["phones_code"] = [];
  level.bunker_numberstation.hints["phones_code"][0] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][0].origin = (2673, -2032, 322);
  level.bunker_numberstation.hints["phones_code"][1] = spawnStruct();
  level.bunker_numberstation.hints["phones_code"][1].origin = (1551, -2032, 322);

  foreach(hint in level.bunker_numberstation.hints["phones_code"]) {
    hint.scriptable = spawnscriptable("maphint_phone_code", hint.origin);
    hint.scriptable.ringing = 0;
  }

  level.bunker_numberstation.hints["phones_morse"] = [];
  level.bunker_numberstation.hints["phones_morse"][0] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][0].origin = (2740, -2239, 300);
  level.bunker_numberstation.hints["phones_morse"][1] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][1].origin = (2620, -2239, 300);
  level.bunker_numberstation.hints["phones_morse"][2] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][2].origin = (2500, -2239, 300);
  level.bunker_numberstation.hints["phones_morse"][3] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][3].origin = (2360, -2239, 300);
  level.bunker_numberstation.hints["phones_morse"][4] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][4].origin = (2244, -2239, 300);
  level.bunker_numberstation.hints["phones_morse"][5] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][5].origin = (2115, -2239, 300);
  level.bunker_numberstation.hints["phones_morse"][6] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][6].origin = (1980, -2239, 300);
  level.bunker_numberstation.hints["phones_morse"][7] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][7].origin = (1850, -2239, 300);
  level.bunker_numberstation.hints["phones_morse"][8] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][8].origin = (1724, -2239, 300);
  level.bunker_numberstation.hints["phones_morse"][9] = spawnStruct();
  level.bunker_numberstation.hints["phones_morse"][9].origin = (1600, -2239, 300);

  foreach(index, hint in level.bunker_numberstation.hints["phones_morse"]) {
    hint.scriptable = spawnscriptable("maphint_phone_morse_" + index, hint.origin);
    hint.scriptable.ringing = 0;
  }
}

function debug_hintadjustmentthink() {
  while(true) {
    foreach(hint in level.bunker_numberstation.hints["phones_code"]) {
      hint.scriptable freescriptable();
    }

    foreach(hint in level.bunker_numberstation.hints["phones_morse"]) {
      hint.scriptable freescriptable();
    }

    if(level.mapname == "mp_bm_bunker01") {
      initlocs_bunkertest();
    } else {
      initlocs_donetsk();
    }

    wait 1;
  }
}

function debug_bunkerpuzzledebugdraw() {
  level endon("endBunkerPhoneLocDraw");

  while(true) {
    foreach(hint in level.bunker_numberstation.hints["phones_code"]) {
      thread scripts\mp\utility\debug::drawsphere(hint.scriptable.origin, 256, 1, (0, 1, 0));
    }

    foreach(hint in level.bunker_numberstation.hints["phones_morse"]) {
      thread scripts\mp\utility\debug::drawsphere(hint.scriptable.origin, 256, 1, (1, 0, 0));
    }

    if(isDefined(level.bunker_numberstation.chosencodephones)) {
      foreach(hint in level.bunker_numberstation.chosencodephones) {
        thread scripts\mp\utility\debug::drawsphere(hint.scriptable.origin, 128, 1, (0, 0, 1));
      }
    }

    wait 1;
  }
}

function debug_show2dvotext(text, time) {
  if(true) {
    return;
  }

  curtime = 0;

  while(curtime < time) {
    printtoscreen2d(500, 350, "<dev string:x20b>" + text, (1, 1, 1), 1.5);

    waitframe();
    curtime += 0.05;
  }
}

function function_138da425d10b4a04() {
  while(true) {
    if(getdvarint(@ "hash_664ec58759f1617", 0) == 1) {
      level thread debug_bunkerpuzzledebugdraw();
    } else {
      level notify("<dev string:x216>");
    }

    if(getdvarint(@ "hash_4e1e0a899a9ac76c", 0) == 1) {
      level thread printcodechosen(level.bunker_numberstation);
      level thread printcodeentered(level.bunker_numberstation);
    } else {
      level notify("<dev string:x22f>");
      level notify("<dev string:x24a>");
    }

    wait 1;
  }
}

# /