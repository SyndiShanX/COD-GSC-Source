/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_24d3d5c5a0521c72.gsc
***********************************************/

_id_8CE8975F5D76A5CF() {
  level endon("game_ended");

  if(istrue(level._id_DD7415D4BB76964A)) {
    return;
  }
  level._id_DD7415D4BB76964A = 1;
  scripts\engine\utility::flag_init("ee_usb_drive_inserted");
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Level EE:0 / display ee code\" \"set scr_ee_display 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_F547EE7AFB4BC5B4 = scripts\engine\utility::getStructArray("water_ee_note", "script_noteworthy");
  _id_9C8A55EC26B7D944 = scripts\engine\utility::getStruct("valve_ee_note", "script_noteworthy");
  _id_EC236602E10C3AD3 = scripts\engine\utility::getStruct("fil_ee_note", "script_noteworthy");
  _id_16A9716EC84CB177 = scripts\engine\utility::random(_id_F547EE7AFB4BC5B4);

  if(!isDefined(level._id_78CF3866D1DC6721))
    level._id_78CF3866D1DC6721 = [];

  if(!isDefined(level._id_8959BD13ADDA41A2))
    level._id_8959BD13ADDA41A2 = [];

  level._id_8959BD13ADDA41A2[0] = randomint(10);
  waitframe();
  level._id_8959BD13ADDA41A2[1] = randomint(10);
  waitframe();
  level._id_8959BD13ADDA41A2[2] = randomint(10);
  waitframe();
  level thread _id_D21400C08D1FEC70(level._id_8959BD13ADDA41A2[0], _id_9C8A55EC26B7D944, "silo_valve_ee_puzzle_completed", "silo_valve");
  level thread _id_D21400C08D1FEC70(level._id_8959BD13ADDA41A2[1], _id_EC236602E10C3AD3, "fil_ee_code_complete", "fil_code");
  level thread _id_D21400C08D1FEC70(level._id_8959BD13ADDA41A2[2], _id_16A9716EC84CB177, undefined, "water_tunnels");
  level thread _id_DE633863A6C92416();
  level thread _id_785A97944731F5D4();
  level thread _id_BB347634974B086A();
  _id_B53A1C085C4BC72F();
}

_id_DE633863A6C92416() {
  level endon("game_ended");
  _id_3592F13489B849B8 = scripts\engine\utility::getStruct("ee_usb_stick", "script_noteworthy");

  if(getdvarint("dvar_F25528453DD5A896", 0) > 0)
    _id_3592F13489B849B8 = scripts\engine\utility::getStruct("ee_test_usb_spawn", "script_noteworthy");

  level thread _id_354E2A07A41A8D67();
  scripts\cp\utility::any_player_nearby(_id_3592F13489B849B8.origin, 262144);
  _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(0, _id_3592F13489B849B8.origin, (0, 0, 0));
  _id_CB4FAD49263E20C4.origin = _id_3592F13489B849B8.origin;
  _id_CB4FAD49263E20C4.angles = _id_3592F13489B849B8.angles;
  _id_CB4FAD49263E20C4.payload = 0;
  item = _id_66122A002AFF5D57::spawnpickup("interactable_note_ee_usb", _id_CB4FAD49263E20C4, 1, 0, undefined, 0);
  item thread _id_1C06BEDD9980B7AF::_id_03E986A5BBE1C73B("usb_stick");
  level thread _id_A87BD6C334C137BA();
}

_id_A87BD6C334C137BA() {
  level endon("game_ended");

  for(;;) {
    level waittill("pickedup_loot_success", _id_5BA045294C1D4D1B, player);

    if(!isPlayer(player) || "interactable_note_ee_usb" != _id_5BA045294C1D4D1B) {
      waitframe();
      continue;
    }

    player thread _id_4C38DF7525BC0D53();
    player thread _id_43CFCD18463CB9B2();
  }
}

_id_4C38DF7525BC0D53() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("dropped_backpack_item", _id_76F4143215683892);

  if(_id_76F4143215683892.type == "interactable_note_ee_usb") {
    self notify("dropped_usb");
    level thread _id_A87BD6C334C137BA();
  }
}

_id_43CFCD18463CB9B2() {
  level endon("game_ended");
  level endon("ee_usb_drive_inserted");
  self endon("dropped_usb");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_2("death", "entered_spectate");
  _id_55C80BAE27E47104 = _id_66122A002AFF5D57::_id_F8D85C542911E3A9(self, "interactable_note_ee_usb");

  if(!isDefined(_id_55C80BAE27E47104)) {
    return;
  }
  _id_531CB1BE084314F7::_id_DB1DD76061352E5B(_id_55C80BAE27E47104, 1);
  thread scripts\cp\cp_hud_message::tutorialprint(&"CP_TRAP_ROOM/USB_DESTROYED", 2);
}

_id_354E2A07A41A8D67() {
  level endon("game_ended");
  _id_C013AC629085BF18 = _id_18AF78602B67B70C::_id_050326CC21187D35("ee_usb_socket", &"CP_RAID1_BOSS1/INSERT_USB", "tag_origin");
  _id_C013AC629085BF18 _id_382959D7794736CC::_id_64FCFB5CB3654CBD(1);
  _id_C013AC629085BF18 setHintString(&"CP_RAID1_BOSS1/FAIL_NEED_KEY");
  _id_C013AC629085BF18 sethintdisplayrange(50);

  while(!scripts\engine\utility::flag_exist("securitykeygenerated"))
    wait 1;

  scripts\engine\utility::flag_wait("securitykeygenerated");
  _id_C013AC629085BF18 _id_382959D7794736CC::_id_64FCFB5CB3654CBD(0);
  _id_C013AC629085BF18 setHintString(&"CP_RAID1_BOSS1/INSERT_USB");

  for(;;) {
    _id_C013AC629085BF18 waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(!_id_58DF022E22FD37B1(player)) {
      player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_RAID1_BOSS1/NO_USB", 2);
      wait 2;
      continue;
    }

    if(getdvarint("dvar_B19A2447A9D3F2BA", 0) <= 0) {
      _id_3B5DDEA9B264BDC9 = _id_66122A002AFF5D57::_id_F8D85C542911E3A9(player, "interactable_note_ee_usb");
      player _id_531CB1BE084314F7::_id_DB1DD76061352E5B(_id_3B5DDEA9B264BDC9, 1);
    }

    scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_RAID1_BOSS1/USB_INSERTED", "allies", 3);
    scripts\engine\utility::flag_set("ee_usb_drive_inserted");
    level notify("ee_usb_drive_inserted_event");

    if(getdvarint("dvar_B19A2447A9D3F2BA", 0) <= 0)
      _id_C013AC629085BF18 _meth_DFB78B3E724AD620(0);

    return;
  }
}

_id_58DF022E22FD37B1(player) {
  _id_9BE70D6D4FF253A1 = _id_66122A002AFF5D57::_id_C01EB7D2911F26E1(player, "interactable_note_ee_usb");

  if(_id_9BE70D6D4FF253A1 > 0)
    return 1;

  return 0;
}

_id_D21400C08D1FEC70(_id_A166868464F52912, _id_B572C59B4A46082F, _id_AC3C804F26AA1413, name) {
  level endon("game_ended");
  scripts\cp\utility::any_player_nearby(_id_B572C59B4A46082F.origin, 262144);

  if(isDefined(_id_AC3C804F26AA1413) && getdvarint("dvar_F25528453DD5A896", 0) <= 0)
    scripts\engine\utility::flag_wait(_id_AC3C804F26AA1413);

  _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(0, _id_B572C59B4A46082F.origin, _id_B572C59B4A46082F.angles);
  _id_CB4FAD49263E20C4.origin = _id_B572C59B4A46082F.origin;
  _id_CB4FAD49263E20C4.angles = _id_B572C59B4A46082F.angles;
  _id_CB4FAD49263E20C4.payload = 0;
  item = _id_66122A002AFF5D57::spawnpickup("interactable_note_raid_" + _id_A166868464F52912, _id_CB4FAD49263E20C4, 1, 0, undefined, 0);
  item thread _id_1C06BEDD9980B7AF::_id_03E986A5BBE1C73B(name);
}

init_keypad_display_digits(_id_EF5F42DC3BAE2A88) {
  _id_FBF0806DC15ED786 = associate_digit_display_model("seq3_puzzle_digits_01", _id_EF5F42DC3BAE2A88);
  _id_FBF07F6DC15ED553 = associate_digit_display_model("seq3_puzzle_digits_02", _id_EF5F42DC3BAE2A88);
  _id_FBF07E6DC15ED320 = associate_digit_display_model("seq3_puzzle_digits_03", _id_EF5F42DC3BAE2A88);
  _id_FBF0856DC15EE285 = associate_digit_display_model("seq3_puzzle_digits_04", _id_EF5F42DC3BAE2A88);
  _id_FBF0846DC15EE052 = associate_digit_display_model("seq3_puzzle_digits_05", _id_EF5F42DC3BAE2A88);
  _id_FBF0836DC15EDE1F = associate_digit_display_model("seq3_puzzle_digits_06", _id_EF5F42DC3BAE2A88);
  _id_FBF0826DC15EDBEC = associate_digit_display_model("seq3_puzzle_digits_07", _id_EF5F42DC3BAE2A88);
  _id_FBF0896DC15EEB51 = associate_digit_display_model("seq3_puzzle_digits_08", _id_EF5F42DC3BAE2A88);
  _id_FBF0886DC15EE91E = associate_digit_display_model("seq3_puzzle_digits_09", _id_EF5F42DC3BAE2A88);
  _id_70C2276043946542 = associate_digit_display_model("seq3_puzzle_digits_10", _id_EF5F42DC3BAE2A88);
  _id_70C2286043946775 = associate_digit_display_model("seq3_puzzle_digits_11", _id_EF5F42DC3BAE2A88);
  _id_70C22560439460DC = associate_digit_display_model("seq3_puzzle_digits_12", _id_EF5F42DC3BAE2A88);
  level._id_4EF331864DA4EA97 = [_id_FBF0806DC15ED786, _id_FBF07F6DC15ED553, _id_FBF07E6DC15ED320, _id_FBF0856DC15EE285, _id_FBF0846DC15EE052, _id_FBF0836DC15EDE1F, _id_FBF0826DC15EDBEC, _id_FBF0896DC15EEB51, _id_FBF0886DC15EE91E, _id_70C2276043946542, _id_70C2286043946775, _id_70C22560439460DC];

  foreach(_id_A166868464F52912 in level._id_4EF331864DA4EA97)
  _id_A166868464F52912 hideallparts();
}

associate_digit_display_model(targetname, _id_EF5F42DC3BAE2A88) {
  _id_5936FEB0DE2C53C5 = getEntArray(targetname, "targetname");
  _id_3C6005D6EF920A54 = scripts\engine\utility::getclosest(_id_EF5F42DC3BAE2A88.origin, _id_5936FEB0DE2C53C5);

  if(!isent(_id_3C6005D6EF920A54)) {
    _id_D9FFBEADC818E0AC = scripts\engine\utility::getStructArray(targetname, "targetname");
    _id_D3EF549F74C2A8D7 = scripts\engine\utility::getclosest(_id_EF5F42DC3BAE2A88.origin, _id_D9FFBEADC818E0AC);
    _id_3C6005D6EF920A54 = spawn("script_model", _id_D3EF549F74C2A8D7.origin);
    _id_3C6005D6EF920A54 setModel("electronics_elevator_security_lock_console_a_digits");
    _id_3C6005D6EF920A54.angles = _id_D3EF549F74C2A8D7.angles;
    _id_3C6005D6EF920A54.targetname = targetname;
  }

  return _id_3C6005D6EF920A54;
}

_id_BB347634974B086A() {
  level endon("game_ended");

  if(istrue(level._id_FD4415E0745A89B1)) {
    return;
  }
  level._id_FD4415E0745A89B1 = 1;
  scripts\engine\utility::flag_init("ee_sequence_done");
  _id_08E4470B1060CFFF = (14012.3, 8311.76, 461);
  _id_3E09E78EA881F4A9 = spawnStruct();
  _id_3E09E78EA881F4A9.origin = (14008.4, 8308.93, 417);
  _id_3E09E78EA881F4A9.script_noteworthy = "cpu_use_spot";
  _id_3E09E78EA881F4A9.animation = "cp_scripted_computerinterface_enter";
  _id_3E09E78EA881F4A9.model = "fullbody_civ_london_male_2";
  _id_421681406E479DAF = scripts\engine\utility::getStruct("ee_door_marker", "script_noteworthy");
  _id_18AF78602B67B70C::_id_887438C3B4B194B6(1, _id_421681406E479DAF.origin, 100);
  init_keypad_display_digits(_id_3E09E78EA881F4A9);
  scripts\cp\cp_computerscreen::init_computer_anims();
  level._id_90C298C1DE3E2006 = scripts\cp\cp_computerscreen::create_computer_interaction(_id_08E4470B1060CFFF, int(1));
  setomnvar("ui_raid_lua_render_stage", 2);
  level thread computer_event_listener();
}

computer_event_listener() {
  level endon("game_ended");
  level endon("ee_sequence_over");

  for(;;) {
    level waittill("manifest_computer_used", player);
    level thread _id_32C56913DE682E0C(player);
    computer_player_listener(player);
  }
}

_id_32C56913DE682E0C(player) {
  level endon("game_ended");
  player waittill("exit_computer");

  if(!scripts\engine\utility::flag("ee_sequence_done")) {
    foreach(_id_A166868464F52912 in level._id_4EF331864DA4EA97)
    _id_A166868464F52912 hideallparts();
  } else {
    wait 1;
    level._id_90C298C1DE3E2006 _meth_DFB78B3E724AD620(0);
  }
}

computer_player_listener(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("exit_computer");
  _id_26350EF8608F7F96 = (14008, 8308, 417);
  _id_448456F634611AAF = 0;

  for(;;) {
    player waittill("luinotifyserver", _id_7148C1A6F25491F8, index);

    if(isDefined(_id_7148C1A6F25491F8) && _id_7148C1A6F25491F8 == "number_pad_digit") {
      if(index == 12) {
        if(_id_448456F634611AAF == 0) {
          waitframe();
          continue;
        }

        playsoundatpos(_id_26350EF8608F7F96, "cp_raid_codemachine_clear_digit");
        _id_448456F634611AAF--;
        _id_8F4DD5D3EF03B168(_id_448456F634611AAF);
        level._id_78CF3866D1DC6721[_id_448456F634611AAF] = undefined;
        continue;
      }

      if(index == 11) {
        waitframe();
        continue;
      }

      index = clamp(index, 0, 9);
      playsoundatpos(_id_26350EF8608F7F96, "cp_raid_codemachine_enter_digit");
      level._id_78CF3866D1DC6721[_id_448456F634611AAF] = index;
      change_keypad_display_digit(_id_448456F634611AAF, index);
      _id_448456F634611AAF++;

      if(_id_448456F634611AAF > 2) {
        if(_id_77C60278E9152C5D()) {
          playsoundatpos(_id_26350EF8608F7F96, "cp_raid_codemachine_good_code");
          _id_421681406E479DAF = scripts\engine\utility::getStruct("ee_door_marker", "script_noteworthy");
          _id_18AF78602B67B70C::_id_887438C3B4B194B6(0, _id_421681406E479DAF.origin, 250);
        } else
          playsoundatpos(_id_26350EF8608F7F96, "cp_raid_codemachine_invalid_input");

        scripts\engine\utility::flag_set("ee_sequence_done");
        player notify("exit_computer");
        waitframe();
        level notify("ee_sequence_over");
        return;
      }
    }
  }
}

change_keypad_display_digit(slot, num) {
  _id_A166868464F52912 = level._id_4EF331864DA4EA97[slot];
  _id_A166868464F52912 show();
  _id_A166868464F52912 hideallparts();

  if(num >= 0) {
    waitframe();
    _id_A166868464F52912 showpart("joint_console_a_digit_" + num);
  }
}

_id_8F4DD5D3EF03B168(slot) {
  _id_A166868464F52912 = level._id_4EF331864DA4EA97[slot];
  _id_A166868464F52912 show();
  _id_A166868464F52912 hideallparts();
}

_id_77C60278E9152C5D() {
  if(!isDefined(level._id_8959BD13ADDA41A2) || !isDefined(level._id_78CF3866D1DC6721))
    return 0;

  if(level._id_8959BD13ADDA41A2.size != level._id_78CF3866D1DC6721.size)
    return 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_78CF3866D1DC6721.size; _id_AC0E594AC96AA3A8++) {
    if(level._id_78CF3866D1DC6721[_id_AC0E594AC96AA3A8] != level._id_8959BD13ADDA41A2[_id_AC0E594AC96AA3A8])
      return 0;
  }

  return 1;
}

_id_785A97944731F5D4() {
  level endon("game_ended");
  setDvar("dvar_50DC8700FC9537BC", 0);

  for(;;) {
    if(getdvarint("dvar_50DC8700FC9537BC", 0) <= 0) {
      wait 0.5;
      continue;
    }

    if(isDefined(level._id_8959BD13ADDA41A2)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_8959BD13ADDA41A2.size; _id_AC0E594AC96AA3A8++) {
        iprintlnbold("EE code is " + level._id_8959BD13ADDA41A2[0] + " " + level._id_8959BD13ADDA41A2[1] + " " + level._id_8959BD13ADDA41A2[2]);
        wait 2;
      }
    } else {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
        iprintlnbold("random numbers were not generated");
        wait 1;
      }
    }

    setDvar("dvar_50DC8700FC9537BC", 0);
  }
}

_id_B53A1C085C4BC72F() {
  level endon("game_ended");
  level endon("trap_platforms_done");
  _id_733EBEE6FC41E4E6 = makeweaponfromstring("iw9_ar_mike4_mp+ammo_556n+bar_ar_p01+iw9_ironsdefault_mike4+iw9_rec_mike4+mag_ar_p01+pgrip_p01+selectsemi_mike4+stock_ar_p01_mike4+camo|camo_q_02");
  _id_F5E11FC2E4B8FBB9 = scripts\engine\utility::getStructArray("secretwpn", "targetname");

  foreach(_id_6A56A4079F195610 in _id_F5E11FC2E4B8FBB9) {
    sweapon = getcompleteweaponname(_id_733EBEE6FC41E4E6);
    _id_B8F5AC23CE0DFDE3 = spawn("weapon_" + sweapon, _id_6A56A4079F195610.origin, 17);
    _id_B8F5AC23CE0DFDE3.angles = _id_6A56A4079F195610.angles;
    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(_id_733EBEE6FC41E4E6), weaponstartammo(_id_733EBEE6FC41E4E6));
    _id_B8F5AC23CE0DFDE3 thread _id_74502A9E0EF1F19C::watchweaponpickup(weaponclipsize(_id_733EBEE6FC41E4E6), weaponstartammo(_id_733EBEE6FC41E4E6));
    _id_B8F5AC23CE0DFDE3 thread _id_7BED63E134C9AE06(_id_733EBEE6FC41E4E6);
    level thread _id_FD123FFC502AB603(_id_B8F5AC23CE0DFDE3);
  }
}

_id_FD123FFC502AB603(weapon) {
  level endon("game_ended");
  _id_0788A9C187362ABE = 0;

  while(!istrue(_id_0788A9C187362ABE)) {
    weapon waittill("trigger", player);

    if(isPlayer(player))
      _id_0788A9C187362ABE = 1;
  }

  foreach(player in level.players) {
    typeid = _func_96B7FC7E35353254("raids3_reward_camo_collect");
    scripts\cp\challenges_cp::_id_7D7322BF935AB06A(player, typeid);
    player setplayerdata("cp", "lastRaidClassifiedReward", "raids3_reward_camo_collect");
  }

  thread _id_CBAB17DA47218978();
}

_id_CBAB17DA47218978() {
  if(istrue(level._id_BE62B5BD7C6ECF0B)) {
    return;
  }
  level._id_BE62B5BD7C6ECF0B = 1;
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"COOP_GAME_PLAY/CAMO_UNLOCKED", "allies", 4);
}

_id_7BED63E134C9AE06(weaponobj) {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player) && isPlayer(player) && !istestclient(player))
      player _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(weaponobj);
  }
}