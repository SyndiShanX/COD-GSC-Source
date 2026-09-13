/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_bunker_numberstation.gsc
************************************************************/

init() {
  level.bunker11puzzleactive = getdvarint("scr_bunker_numberstation", 1);
  scripts\mp\flags::gameflaginit("stop_phone_code_ringing", 0);
  level.bunker_numberstation = spawnStruct();
  doors = getEntArray("bunker_door_11", "targetname");
  level.bunker_numberstation.door = doors[0];
  level.bunker_numberstation.hints["keypad"] = [];
  initbunker11keypad();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_keypad_bunker_11", ::keypadscriptableused);

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
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_0", ::phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_1", ::phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_2", ::phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_3", ::phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_4", ::phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_5", ::phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_6", ::phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_7", ::phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_8", ::phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_morse_9", ::phonemorsesinglescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_phone_code", ::codephonescriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_computer_reboot", ::computerrebootused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_red_button", ::redbuttonused);
  }

  level thread initpostmain();
}

initpostmain() {
  waittillframeend;
  level thread _id_7D625073C6379D53::initbunkerdoor(level.bunker_numberstation.door, 0);

  if(!level.bunker11puzzleactive) {
    return;
  }
  if(level.mapname == "mp_bm_bunker01")
    initlocs_bunkertest();
  else
    initlocs_donetsk();

  scripts\mp\flags::gameflagwait("prematch_done");
  _id_885780D268327BA4 = getdvarint("dvar_4BB3DD5AF7368F36", 3);
  generatenumbercode(_id_885780D268327BA4, level.bunker_numberstation);
  level thread phonesringing_singlemorse();
  level thread phonesringing_code();
  level thread _id_7E52B56769FA7774::registeruniquelootcallback(1, ::awardbunker11blueprint);
}

initvo() {
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

initbunker11keypad() {
  door = level.bunker_numberstation.door;
  forward = anglesToForward(door.angles);
  left = anglestoleft(door.angles);
  _id_A10AE505A570D67E = door.origin + (0, 0, 45) + forward * 37 + left * 80;
  level.bunker_numberstation.hints["keypad"][0] = spawnscriptable("maphint_keypad_bunker_11", _id_A10AE505A570D67E);
}

initlocs_donetsk() {
  initlocs_morsephones();
  initlocs_codeprovidingphones();
}

initlocs_morsephones() {
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

    if(isDefined(hint.sound))
      hint.scriptable.sound = hint.sound;
  }
}

initlocs_codeprovidingphones() {
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

    if(isDefined(hint.sound))
      hint.scriptable.sound = hint.sound;
  }
}

awardbunker11blueprint(player) {
  foreach(_id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata(player.team, "players")) {
    if(!isDefined(_id_F0EA4030349A33D5)) {
      continue;
    }
    _id_F0EA4030349A33D5 scripts\cp_mp\challenges::onunlockitem("blueprint_unlock_584");
    _id_F0EA4030349A33D5 scripts\mp\analyticslog::logevent_challengeitemunlocked(_id_F0EA4030349A33D5, "blueprint_unlock_584", "blueprint", 584);
    optionalnumber = 0;

    if(optionalnumber > 0)
      _id_F0EA4030349A33D5 thread scripts\mp\hud_message::showsplash("br_unlockable_weapon_splash", optionalnumber);
  }

  return 1;
}

codephonescriptableused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level thread _codephonescriptableused(instance, part, state, player, _id_A5B2C541413AA895);
}

_codephonescriptableused(instance, part, state, player, _id_A5B2C541413AA895) {
  if(state == "on") {
    if((!scripts\mp\flags::gameflag("prematch_done") || !istrue(instance.startingcodephone)) && level.bunker_numberstation.successfulteams.size == 0) {
      playsoundatpos(instance.origin, "br_phone_deny");
      instance setscriptablepartstate("maphint_phone_code", "off");
      wait 3;
      instance setscriptablepartstate("maphint_phone_code", "on");
    } else {
      player scripts\mp\playerlogic::_id_E636E108DFFE6AB7();
      instance setscriptablepartstate("maphint_phone_code", "off");

      while(istrue(instance.ringing))
        waitframe();

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
}

phonemorsesinglescriptableused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  switch (part) {
    case "maphint_phone_morse_0":
      instance.morsenumber = 0;
      break;
    case "maphint_phone_morse_1":
      instance.morsenumber = 1;
      break;
    case "maphint_phone_morse_2":
      instance.morsenumber = 2;
      break;
    case "maphint_phone_morse_3":
      instance.morsenumber = 3;
      break;
    case "maphint_phone_morse_4":
      instance.morsenumber = 4;
      break;
    case "maphint_phone_morse_5":
      instance.morsenumber = 5;
      break;
    case "maphint_phone_morse_6":
      instance.morsenumber = 6;
      break;
    case "maphint_phone_morse_7":
      instance.morsenumber = 7;
      break;
    case "maphint_phone_morse_8":
      instance.morsenumber = 8;
      break;
    case "maphint_phone_morse_9":
      instance.morsenumber = 9;
      break;
    default:
  }

  level thread _phonemorsesinglescriptableused(instance, part, state, player, _id_A5B2C541413AA895);
}

_phonemorsesinglescriptableused(instance, part, state, player, _id_A5B2C541413AA895) {
  if(state == "on") {
    team = player.team;

    if(!scripts\mp\flags::gameflag("prematch_done")) {
      playsoundatpos(instance.origin, "br_morse_" + instance.morsenumber);
      instance setscriptablepartstate("maphint_phone_morse_" + instance.morsenumber, "off");
      wait 3;
      instance setscriptablepartstate("maphint_phone_morse_" + instance.morsenumber, "on");
    } else {
      player scripts\mp\playerlogic::_id_E636E108DFFE6AB7();
      instance setscriptablepartstate("maphint_phone_morse_" + instance.morsenumber, "off");

      while(istrue(instance.ringing))
        waitframe();

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

      if(!scripts\engine\utility::array_contains(level.bunker_numberstation.successfulteams, team)) {
        playsoundatpos(instance.origin, "br_morse_" + instance.morsenumber);
        wait 2;

        if(!scripts\engine\utility::array_contains(level.bunker_numberstation.successfulteams, team)) {
          entercodenumber(level.bunker_numberstation, instance.morsenumber, team);
          _id_B50F7CB6D7639B3A = checkcodeentered(level.bunker_numberstation, team);

          if(_id_B50F7CB6D7639B3A == 1)
            level thread correctcodeentered(instance, level.bunker_numberstation, team);
          else if(_id_B50F7CB6D7639B3A == 0)
            level thread incorrectcodeentered(instance, level.bunker_numberstation, team);
        }
      }

      wait 3;
      instance setscriptablepartstate("maphint_phone_morse_" + instance.morsenumber, "on");
      instance thread ringphoneoccasionally();
    }
  }
}

keypadscriptableused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level thread _keypadscriptableused(instance, part, state, player, _id_A5B2C541413AA895);
}

_keypadscriptableused(instance, part, state, player, _id_A5B2C541413AA895) {
  if(level.bunker11puzzleactive && (getdvarint("dvar_2B47E76D55A2B0B2", 0) == 1 || scripts\engine\utility::array_contains(level.bunker_numberstation.successfulteams, player.team))) {
    playsoundatpos(instance.origin, "br_keypad_confirm");
    instance setscriptablepartstate("maphint_keypad_bunker_11", "off");
    wait 2.5;
    level thread _id_7D625073C6379D53::openbunkerdoor(level.bunker_numberstation.door, 1, "bunker_loot_11", "door_open_puzzle");
    level.bunker_numberstation.bunkeropened = 1;
    level thread activatemusictrigger();

    if(!0) {
      computerrebootsequence_init();
      redbutton_init();
    }
  } else {
    playsoundatpos(instance.origin, "br_keypad_deny");
    instance setscriptablepartstate("maphint_keypad_bunker_11", "off");
    wait 3;
    instance setscriptablepartstate("maphint_keypad_bunker_11", "on");
  }
}

activatemusictrigger() {
  forward = anglesToForward(level.bunker_numberstation.door.angles);
  trigger = spawn("trigger_radius", level.bunker_numberstation.door.origin + forward * -128, 0, 128, 128);
  level thread musictriggerthink(trigger);
  wait 120;
  trigger notify("endMusicTrigger");
  trigger delete();
}

musictriggerthink(trigger) {
  trigger endon("endMusicTrigger");

  for(;;) {
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

phonesringing_code() {
  _id_E2C22B9BAB4C4908 = getdvarint("dvar_9F70D8030533CF20", 50);
  _id_E40F74266C39D166 = max(1.0, level.bunker_numberstation.hints["phones_code"].size * (_id_E2C22B9BAB4C4908 * 0.01));
  level.bunker_numberstation.hints["phones_code"] = scripts\engine\utility::array_randomize(level.bunker_numberstation.hints["phones_code"]);
  _id_F557519E38CBE212 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < int(_id_E40F74266C39D166); _id_AC0E594AC96AA3A8++)
    _id_F557519E38CBE212[_id_F557519E38CBE212.size] = level.bunker_numberstation.hints["phones_code"][_id_AC0E594AC96AA3A8];

  foreach(_id_CA8BA7C130852FCC in _id_F557519E38CBE212) {
    _id_CA8BA7C130852FCC.scriptable.startingcodephone = 1;
    _id_CA8BA7C130852FCC.scriptable thread ringcodephoneconstantly();
    _id_CA8BA7C130852FCC.scriptable setscriptablepartstate("maphint_phone_code", "on");
  }

  level.bunker_numberstation.chosencodephones = _id_F557519E38CBE212;
}

phonesringing_singlemorse() {
  foreach(_id_CA8BA7C130852FCC in level.bunker_numberstation.hints["phones_morse"])
  _id_CA8BA7C130852FCC.scriptable thread ringphoneoccasionally();
}

codephonescodeenteredringingfrenzy() {
  level thread tracktimeringingfrenzy();

  foreach(_id_CA8BA7C130852FCC in level.bunker_numberstation.hints["phones_code"]) {
    if(!istrue(_id_CA8BA7C130852FCC.scriptable.startingcodephone)) {
      _id_CA8BA7C130852FCC.scriptable thread ringcodephoneconstantly();
      _id_CA8BA7C130852FCC.scriptable setscriptablepartstate("maphint_phone_code", "on");
    }
  }
}

ringphoneoccasionally() {
  self endon("phone_picked_up");
  wait(randomintrange(30, 55));

  while(!istrue(level.bunker_numberstation.bunkeropened)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
      self.ringing = 1;

      if(!0) {
        if(isDefined(self.sound))
          playsoundatpos(self.origin, self.sound);
        else
          playsoundatpos(self.origin, "br_phone_ring");
      }

      if(0)
        thread scripts\mp\utility\debug::drawsphere(self.origin, 32, 3, (0, 1, 0));

      wait 3;
      self.ringing = 0;
      wait 3;
    }

    wait(randomintrange(30, 55));
  }
}

ringcodephoneconstantly() {
  self endon("phone_picked_up");

  while(!scripts\mp\flags::gameflag("stop_phone_code_ringing")) {
    self.ringing = 1;

    if(!0) {
      if(isDefined(self.sound))
        playsoundatpos(self.origin, self.sound);
      else
        playsoundatpos(self.origin, "br_phone_ring");
    }

    if(0)
      thread scripts\mp\utility\debug::drawsphere(self.origin, 32, 3, (1, 0, 0));

    wait 3;
    self.ringing = 0;
    wait 3;
  }
}

tracktimeringingfrenzy() {
  wait 120;
  scripts\mp\flags::gameflagset("stop_phone_code_ringing");
}

computerrebootsequence_init() {
  level.serverroomtvs = scripts\engine\utility::getStructArray("bunker11_serverTV", "targetname");
  level.warroomtvs = scripts\engine\utility::getStructArray("bunker11_warroomTV", "targetname");
  _id_15E3F6188A142829 = scripts\engine\utility::getStructArray("bunker11_serverroom_computer", "targetname");
  spawnscriptable("maphint_computer_reboot", _id_15E3F6188A142829[0].origin);

  foreach(index, _id_CDDE3F78F5298EAB in level.serverroomtvs)
  level.serverroomtvs[index].scriptable = spawnscriptable("bunker11_serverroom_monitor", _id_CDDE3F78F5298EAB.origin, _id_CDDE3F78F5298EAB.angles);

  foreach(index, _id_CDDE3F78F5298EAB in level.warroomtvs)
  level.warroomtvs[index].scriptable = spawnscriptable("bunker11_warroom_monitor", _id_CDDE3F78F5298EAB.origin, _id_CDDE3F78F5298EAB.angles);
}

computerrebootused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level thread _computerrebootsequence_start(instance, player);
}

_computerrebootsequence_start(instance, player) {
  instance setscriptablepartstate("maphint_computer_reboot", "off");
  playsoundatpos(instance.origin, "emt_bunk_pc_keyboard_typing");
  wait 3;
  playsoundatpos(instance.origin, "emt_bunk_pc_reboot");

  foreach(_id_CDDE3F78F5298EAB in level.serverroomtvs)
  _id_CDDE3F78F5298EAB.scriptable setscriptablepartstate("bunker11_serverroom_monitor", "rebooting");

  foreach(_id_CDDE3F78F5298EAB in level.warroomtvs) {
    _id_CDDE3F78F5298EAB.scriptable setscriptablepartstate("bunker11_warroom_monitor", "rebooting");
    wait(randomfloatrange(0.3, 0.6));
  }

  wait 3;

  foreach(_id_CDDE3F78F5298EAB in level.serverroomtvs) {
    _id_CDDE3F78F5298EAB.scriptable setscriptablepartstate("bunker11_serverroom_monitor", "ready");
    wait(randomfloatrange(0.3, 0.6));
  }

  foreach(_id_CDDE3F78F5298EAB in level.warroomtvs)
  _id_CDDE3F78F5298EAB.scriptable setscriptablepartstate("bunker11_warroom_monitor", "countdown");

  instance setscriptablepartstate("maphint_computer_reboot", "on");
}

redbutton_init() {
  _id_07538C6A3C6D4044 = scripts\engine\utility::getStructArray("bunker11_red_button", "targetname");
  level.bunker11_mistswindow = scripts\engine\utility::getStructArray("bunker11_cleanroom_window", "targetname");
  level.bunker11_mistsdoors = scripts\engine\utility::getStructArray("bunker11_cleanroom_door", "targetname");
  spawnscriptable("maphint_red_button", _id_07538C6A3C6D4044[0].origin);

  foreach(index, _id_4B37C1DF960B78D1 in level.bunker11_mistswindow) {
    angles = (0, 0, 0);

    if(isDefined(_id_4B37C1DF960B78D1.angles))
      angles = _id_4B37C1DF960B78D1.angles;

    level.bunker11_mistswindow[index].scriptable = spawnscriptable("bunker11_cleanroom_mist", _id_4B37C1DF960B78D1.origin, angles);
  }

  foreach(index, door in level.bunker11_mistsdoors) {
    angles = (0, 0, 0);

    if(isDefined(door.angles))
      angles = door.angles;

    level.bunker11_mistsdoors[index].scriptable = spawnscriptable("bunker11_cleanroom_mist_door", door.origin, angles);
  }
}

redbuttonused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level thread _redbuttonused_internal(instance, player);
}

_redbuttonused_internal(instance, player) {
  instance setscriptablepartstate("maphint_red_button", "off");
  playsoundatpos(instance.origin, "emt_bunk_red_button_press");

  foreach(_id_4B37C1DF960B78D1 in level.bunker11_mistswindow)
  _id_4B37C1DF960B78D1.scriptable setscriptablepartstate("bunker11_cleanroom_mist", "off");

  foreach(door in level.bunker11_mistsdoors)
  door.scriptable setscriptablepartstate("bunker11_cleanroom_mist_door", "off");

  wait 5;
  instance setscriptablepartstate("maphint_red_button", "on");
}

generatenumbercode(_id_885780D268327BA4, _id_48B11326257052F1) {
  _id_7D625073C6379D53::generatenumbercode_array(_id_885780D268327BA4, _id_48B11326257052F1);

  if(0) {
    level thread printcodechosen(_id_48B11326257052F1);
    level thread printcodeentered(_id_48B11326257052F1);
  }
}

entercodenumber(_id_48B11326257052F1, number, team) {
  if(!isDefined(_id_48B11326257052F1.codeentered[team]))
    _id_48B11326257052F1.codeentered[team] = [];

  _id_48B11326257052F1.codeentered[team][_id_48B11326257052F1.codeentered[team].size] = number;
}

checkcodeentered(_id_48B11326257052F1, team) {
  if(_id_48B11326257052F1.codeentered[team].size < _id_48B11326257052F1.code.size)
    return -1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_48B11326257052F1.code.size; _id_AC0E594AC96AA3A8++) {
    if(_id_48B11326257052F1.code[_id_AC0E594AC96AA3A8] != _id_48B11326257052F1.codeentered[team][_id_AC0E594AC96AA3A8])
      return 0;
  }

  return 1;
}

correctcodeentered(instance, _id_48B11326257052F1, team) {
  if(0)
    level thread showdebugresult("Correct Code Entered!");

  if(_id_48B11326257052F1.successfulteams.size == 0)
    level.bunker_numberstation.door.lightscriptable setscriptablepartstate("bunker_active_indicator_light", "active");

  _id_48B11326257052F1.successfulteams[_id_48B11326257052F1.successfulteams.size] = team;
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

  if(!level.bunker_numberstation.codecorrectlyenteredbyanyone)
    codephonescodeenteredringingfrenzy();
  else
    level.bunker_numberstation.codecorrectlyenteredbyanyone = 1;
}

incorrectcodeentered(instance, _id_48B11326257052F1, team) {
  _id_48B11326257052F1.codeentered[team] = undefined;

  if(0)
    level thread showdebugresult("ERROR: Wrong Code Entered!");

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

showdebugresult(_id_1B0D855F76756D57) {
  for(_id_018DA35A53F30FFD = 0; _id_018DA35A53F30FFD < 5; _id_018DA35A53F30FFD = _id_018DA35A53F30FFD + 0.05)
    waitframe();
}

printcodechosen(_id_48B11326257052F1) {
  level notify("endChosenCodeDebugPrint");
  level endon("endChosenCodeDebugPrint");
  _id_DD1003EA8B91BB85 = 10;

  for(;;) {
    if(!scripts\mp\flags::gameflag("prematch_done")) {} else {
      foreach(_id_AC0E594AC96AA3A8, number in _id_48B11326257052F1.code) {}
    }

    waitframe();
  }
}

printcodeentered(_id_48B11326257052F1) {
  level notify("endEnterdCodeDebugPrint");
  level endon("endEnterdCodeDebugPrint");
  _id_DD1003EA8B91BB85 = 10;
  _id_270767E7723EFD31 = 30;

  for(;;) {
    _id_3EDA0EF65C9478AC = 0;

    foreach(team, _id_B62477949575453B in _id_48B11326257052F1.codeentered) {
      if(!scripts\engine\utility::array_contains(_id_48B11326257052F1.successfulteams, team)) {
        foreach(_id_AC0E594AC96AA3A8, number in _id_48B11326257052F1.codeentered[team]) {}
      } else {}

      _id_3EDA0EF65C9478AC++;
    }

    waitframe();
  }
}

initlocs_bunkertest() {
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

debug_hintadjustmentthink() {
  for(;;) {
    foreach(hint in level.bunker_numberstation.hints["phones_code"])
    hint.scriptable freescriptable();

    foreach(hint in level.bunker_numberstation.hints["phones_morse"])
    hint.scriptable freescriptable();

    if(level.mapname == "mp_bm_bunker01")
      initlocs_bunkertest();
    else
      initlocs_donetsk();

    wait 1;
  }
}

debug_bunkerpuzzledebugdraw() {
  level endon("endBunkerPhoneLocDraw");

  for(;;) {
    foreach(hint in level.bunker_numberstation.hints["phones_code"])
    thread scripts\mp\utility\debug::drawsphere(hint.scriptable.origin, 256, 1, (0, 1, 0));

    foreach(hint in level.bunker_numberstation.hints["phones_morse"])
    thread scripts\mp\utility\debug::drawsphere(hint.scriptable.origin, 256, 1, (1, 0, 0));

    if(isDefined(level.bunker_numberstation.chosencodephones)) {
      foreach(hint in level.bunker_numberstation.chosencodephones)
      thread scripts\mp\utility\debug::drawsphere(hint.scriptable.origin, 128, 1, (0, 0, 1));
    }

    wait 1;
  }
}

debug_show2dvotext(text, time) {
  if(!0) {
    return;
  }
  for(_id_6B7BEE46F2C6DA28 = 0; _id_6B7BEE46F2C6DA28 < time; _id_6B7BEE46F2C6DA28 = _id_6B7BEE46F2C6DA28 + 0.05)
    waitframe();
}