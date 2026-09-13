/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_63325153465f8869.gsc
***********************************************/

_id_738AB4672A044A90() {
  level endon("game_ended");
  animnode = scripts\engine\utility::getStruct("fil_console_animnode", "targetname");
  button = spawn("script_model", animnode.origin);
  button endon("death");
  button setModel("tag_origin");
  button makeusable();
  button setHintString(&"CP_RAID1_BOSS1/NO_POWER");
  button sethintdisplayrange(256);
  button setCursorHint("HINT_BUTTON");
  button sethintdisplayfov(65);
  button sethintonobstruction("show");
  button setuseholdduration("duration_short");
  button makeusable();
  level._id_7035A968BB8BC644 = button;
  _id_558A9A418B2D3405::_id_A858510E43065956();
  button _id_382959D7794736CC::_id_66344994F6CA11D6(&"CP_RAID1_BOSS1/NO_POWER", "fil_power_on", &"CP_RAID1_BOSS1/GENERATE_SECURITY_KEY");
  ent = undefined;

  for(;;) {
    button waittill("trigger", ent);
    button _meth_DFB78B3E724AD620(0);
    ent playSound("cp_raid3_code_computer_fly");
    level notify("securitykeygeneration_start", ent);
    _id_558A9A418B2D3405::_id_ED19FACE30051E39(animnode, ent);
    break;
  }

  level thread _id_9948CD4AC37C976C(button.origin);
  level._id_5DB2316C81D8B407 = 1;
  scripts\engine\utility::flag_set("securitykeygenerated", ent);
  _id_A3F9B63AE9189D57();
  level thread _id_2FF7FA97BAEA21AA();
  wait 5;

  if(scripts\engine\utility::flag("ee_usb_drive_inserted"))
    scripts\engine\utility::flag_waitopen("ee_usb_drive_inserted");

  button _meth_DFB78B3E724AD620(1);
  button setHintString(&"CP_RAID1_BOSS1/SECURITYKEY_NEW");
  level._id_DD6737D8A32C4546 = button;

  for(;;) {
    button waittill("trigger", ent);
    button _meth_DFB78B3E724AD620(0);
    ent playSound("cp_raid3_code_computer_fly");
    _id_558A9A418B2D3405::_id_ED19FACE30051E39(animnode, ent);
    level thread _id_9948CD4AC37C976C(button.origin);
    _id_20C28607B442E940();
    wait 5;
    button _meth_DFB78B3E724AD620(1);
  }
}

_id_9948CD4AC37C976C(position) {
  wait 0.05;
  playsoundatpos(position, "cp_raid3_code_computer_newcode");
}

_id_20C28607B442E940() {
  _id_F60869D706D0891D();
  _id_8F4E225CF2264E02();
  _id_0A67C97EB982F346 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  level._id_0A67C97EB982F346 = scripts\engine\utility::array_randomize(_id_0A67C97EB982F346);
  _id_BFC65A378A6D8EFE = scripts\engine\utility::array_randomize(_id_0A67C97EB982F346);
  _id_619875E4F15D87D0 = 15;

  foreach(item in _id_BFC65A378A6D8EFE) {
    if(item == level._id_0A67C97EB982F346[level._id_0A67C97EB982F346.size - 1]) {
      continue;
    }
    level._id_0A67C97EB982F346[level._id_0A67C97EB982F346.size] = item;

    if(level._id_0A67C97EB982F346.size >= _id_619875E4F15D87D0) {
      break;
    }
  }

  wait 1;
  _id_A3F9B63AE9189D57();
}

_id_68D137712CA50204(state) {
  scripts\engine\utility::flag_wait("scriptables_ready");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 8; _id_AC0E594AC96AA3A8++) {
    lights = getentitylessscriptablearray("zone_0" + _id_AC0E594AC96AA3A8, "targetname");

    foreach(light in lights)
    light setscriptablepartstate("controller", state);

    if(state == "off") {
      waitframe();
      continue;
    }

    wait(randomfloatrange(1, 2));
  }
}

_id_AB6A36F0CB210A12(objectivestruct) {
  scripts\engine\utility::flag_init("b1fildone");
  scripts\engine\utility::flag_init("securitykeygenerated");
  scripts\engine\utility::flag_init("fil_boss_died");
  scripts\engine\utility::flag_init("flashlight_high");
  level thread _id_01B1A46EFB26E5A9::_id_45BF1B26E346026D();

  if(!istrue(level._id_B9E06F3785D1AC04)) {
    level thread _id_382959D7794736CC::_id_BF11D3FD19E18ABE();
    level._id_B9E06F3785D1AC04 = 1;
  }

  if(!scripts\engine\utility::flag("goto_fil_power")) {
    scripts\cp\cp_checkpoint::checkpoint_set("boss1_fil");
    scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("fil");
    _id_FFEC324BD5085987();
    thread _id_07F6C60E532F11BD();
    scripts\cp\cp_spawning_util::_id_5EBBD91D2F142DBC();
    level thread _id_382959D7794736CC::_id_0C735D60735EDA5F();
    level thread _id_382959D7794736CC::_id_BA5E5C5EBE8BF57B();
    level thread scripts\cp\killstreaks\airdrop_cp::_id_20C12AA7546FCAA5();
    level thread _id_382959D7794736CC::_id_92233BCD56EA95C5("fil_intro_door", 1, 300);
    level thread _id_DC521AFA9762AB73();
    level thread _id_1B03D43527313999();
    level thread _id_3F6116A32C86B949();
    level thread _id_50FB2E14278AB2E2();
    level thread _id_095E4E73CC6E660C();
    level._id_CC86627703B86AF5["floor_is_lava"] = getEnt("area5_elec_trigger", "targetname");
    level._id_51FBA2BBD80629D9["floor_is_lava"] = scripts\engine\utility::getStructArray("electic_fx_area5", "targetname");
    level thread _id_365A17A79D0B20E2();
  } else {
    thread _id_CB0BF566D166218B();
    scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("fil", undefined, "fil_p started");
    scripts\cp\cp_checkpoint::checkpoint_set("boss1_fil_p");
    level._id_CC86627703B86AF5["floor_is_lava"] = getEnt("area5_elec_trigger", "targetname");
    level._id_51FBA2BBD80629D9["floor_is_lava"] = scripts\engine\utility::getStructArray("electic_fx_area5", "targetname");
    thread _id_323248A3057C390F::_id_9168E4D97136F379("floor_is_lava");
    level thread _id_E077D93404FE7C0D();
    level thread _id_4900EE6258CDEAD3();
  }

  level thread _id_24D3D5C5A0521C72::_id_8CE8975F5D76A5CF();
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:0 / Level / Security Key First Digit Only\" \"set scr_keyhack 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread _id_738AB4672A044A90();
  _id_CD860C803B124CCE();
  _id_0A67C97EB982F346 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  level._id_0A67C97EB982F346 = scripts\engine\utility::array_randomize(_id_0A67C97EB982F346);
  _id_BFC65A378A6D8EFE = scripts\engine\utility::array_randomize(_id_0A67C97EB982F346);
  level._id_F19C237F80D770E5 = 0;
  _id_619875E4F15D87D0 = 15;

  foreach(item in _id_BFC65A378A6D8EFE) {
    if(item == level._id_0A67C97EB982F346[level._id_0A67C97EB982F346.size - 1]) {
      continue;
    }
    level._id_0A67C97EB982F346[level._id_0A67C97EB982F346.size] = item;

    if(level._id_0A67C97EB982F346.size >= _id_619875E4F15D87D0) {
      break;
    }
  }

  if(!isDefined(level._id_C0440805DA76ABB8)) {
    level._id_C0440805DA76ABB8 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 15; _id_AC0E594AC96AA3A8++) {
      _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("fil_key_" + _id_AC0E594AC96AA3A8, "targetname");

      foreach(struct in _id_9E4E1482CB40C9C5) {
        struct.model = spawn("script_model", struct.origin);
        struct.model.angles = struct.angles;

        if(!isDefined(struct.script_noteworthy) || struct.script_noteworthy != "noflash")
          struct.model.origin = struct.model.origin + (0, 0, 2) + anglesToForward(struct.angles) * 0.5 + anglestoleft(struct.angles) * 1.2;

        struct.model setModel("electronics_elevator_security_lock_console_a_digits");
      }

      waitframe();
      level._id_C0440805DA76ABB8[_id_AC0E594AC96AA3A8] = spawnStruct();
      level._id_C0440805DA76ABB8[_id_AC0E594AC96AA3A8]._id_E9A3362A072A0053 = _id_9E4E1482CB40C9C5;
      level._id_C0440805DA76ABB8[_id_AC0E594AC96AA3A8].value = undefined;
    }
  }

  _id_F60869D706D0891D();
  _id_8F4E225CF2264E02();
  level thread _id_286B021F1DF637D2();
  level thread _id_2691730E459328E5();
  level thread _id_E2F7A251F300090B();
  scripts\engine\utility::flag_wait("b1fildone");
  scripts\cp\cp_checkpoint::checkpoint_set("boss1_fil_end");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("fil");

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_2E9261330FBCEC80 = scripts\engine\utility::getStructArray("b1_fil_end_players", "targetname");
    _id_0AFB7E332AEE4BF2::_id_79DDAC0EF09B8D0F(_id_2E9261330FBCEC80, 0);
  }
}

_id_CD860C803B124CCE() {
  level._id_E5505AF18939A834 = [];
  _id_AC0E594AC96AA3A8 = 0;

  for(;;) {
    button = getEnt("fil_btn_" + _id_AC0E594AC96AA3A8, "targetname");

    if(!isDefined(button)) {
      break;
    }

    level._id_E5505AF18939A834[level._id_E5505AF18939A834.size] = button;
    button setModel("tag_origin");
    button makeusable();
    button setHintString(&"CP_RAID1_BOSS1/FIL_ACTIVATE_BUTTON");
    button sethintdisplayrange(256);
    button setCursorHint("HINT_BUTTON");
    button sethintdisplayfov(65);
    button setusefov(60);
    button sethintonobstruction("show");
    button setuseholdduration("duration_none");
    button thread _id_F1D2306CBF75AE31();
    button._id_1E1ACCA53AE06826 = _id_AC0E594AC96AA3A8;
    _id_AC0E594AC96AA3A8++;
  }
}

_id_4900EE6258CDEAD3() {
  _id_F187C08E92EEF5A0 = [];
  _id_F187C08E92EEF5A0 = getEntArray("fil_triggers", "script_noteworthy");

  foreach(trigger in _id_F187C08E92EEF5A0) {
    if(isDefined(_id_F187C08E92EEF5A0))
      trigger scripts\engine\utility::trigger_off();
  }
}

_id_50FB2E14278AB2E2() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("fil_power_on");
  button = getEnt("fil_power_switch", "targetname");
  button thread _id_5F0772056EDA430D();
  _id_C103BFC366A53063 = &"CP_RAID1_BOSS1/POWER_ON";
  ent = _id_558A9A418B2D3405::_id_F9020783100CB7B2(button, _id_C103BFC366A53063);
  scripts\engine\utility::flag_set("fil_power_on", ent);

  if(!istrue(level._id_394B92D9305D486E)) {
    level._id_394B92D9305D486E = 1;
    level thread _id_68D137712CA50204("on");
    level thread _id_323248A3057C390F::_id_1609D9F10A1663F4("floor_is_lava", "stop_tripwire_wipes");
  }
}

_id_5F0772056EDA430D() {
  button = undefined;

  while(!scripts\engine\utility::is_equal(button, self))
    level waittill("player_interaction_success", ent, button);

  animlength = getanimlength(level.scr_anim["player_rig"]["power_switch"]);
  wait(animlength - 0.5);
  level._id_20A3C60BA9434F71 = 1;
  _id_382959D7794736CC::_id_E97CB398476590D1();
}

_id_3F6116A32C86B949() {
  triggers = getEntArray("fil_jugg_spawner", "targetname");
  scripts\engine\utility::array_thread(triggers, ::_id_489D219E70842FC8);
}

_id_489D219E70842FC8() {
  level endon("fil_jugspawn");

  for(;;) {
    self waittill("trigger", ent);

    if(!isPlayer(ent)) {
      continue;
    }
    break;
  }

  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray(self.target, "targetname");
  thread scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(_id_BFE291B401A9BF2A, 1);
  waitframe();
  level thread _id_D13939902BCE7A55();
  level notify("fil_jugspawn");
}

_id_1B03D43527313999() {
  level endon("game_ended");
  level endon("stealthBroken");
  scripts\cp\coop_stealth::_id_53C55A0C7AF36050();
  scripts\cp\coop_stealth::_id_18CD746FF947FF3C("fil_intro");

  for(;;) {
    if(_func_EAC0CD99C9C6D8EE() != "spotted") {
      waitframe();
      continue;
    }

    _id_D70CC7130F025A51 = scripts\cp\coop_stealth::_id_BA975873CB8E4618();

    if(istrue(_id_D70CC7130F025A51)) {
      break;
    } else
      waitframe();
  }

  level.stealth.bstayincombatoncealerted = 1;
  _func_AA9FA9C5A97D0F6E(1);
  level notify("stealth_broken");
  wait 3;
  thread _id_CFAE11843C33250B((9784, 12389, 403));
  wait 15;
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("fil_reinforcements", "targetname");
  scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(_id_BFE291B401A9BF2A, 1);
}

_id_CFAE11843C33250B(org) {
  if(!isDefined(level._id_DD7DE82CB1C47A2B))
    level._id_DD7DE82CB1C47A2B = spawn("script_origin", org);

  level._id_DD7DE82CB1C47A2B.origin = org;
  level._id_DD7DE82CB1C47A2B playLoopSound("milbase_alarm");
  wait 11;
  level._id_DD7DE82CB1C47A2B stoploopsound();
}

_id_F60869D706D0891D() {
  level._id_F19C237F80D770E5 = 0;
  level._id_7EB96032B6AE1388 = 0;
}

_id_8F4E225CF2264E02() {
  foreach(struct in level._id_C0440805DA76ABB8) {
    foreach(_id_A166868464F52912 in struct._id_E9A3362A072A0053) {
      if(!isDefined(_id_A166868464F52912) || !isDefined(_id_A166868464F52912.model)) {
        continue;
      }
      _id_A166868464F52912.model hideallparts();
      _id_A166868464F52912.model showpart("joint_console_a_digit_off");
    }
  }
}

_id_F5DF646D1DFD24DC(val) {
  self.value = val;

  foreach(_id_A166868464F52912 in self._id_E9A3362A072A0053) {
    if(!isDefined(_id_A166868464F52912) || !isDefined(_id_A166868464F52912.model)) {
      continue;
    }
    _id_A166868464F52912.model hideallparts();
    _id_A166868464F52912.model showpart("joint_console_a_digit_" + val);
  }
}

_id_A3F9B63AE9189D57() {
  foreach(index, item in level._id_0A67C97EB982F346)
  level._id_C0440805DA76ABB8[index] _id_F5DF646D1DFD24DC(level._id_0A67C97EB982F346[index]);
}

_id_2FF7FA97BAEA21AA() {
  level endon("fil_exit_granted");

  for(;;) {
    foreach(index, item in level._id_0A67C97EB982F346) {
      if(level._id_F19C237F80D770E5 <= index) {
        level._id_C0440805DA76ABB8[index] _id_F5DF646D1DFD24DC(level._id_0A67C97EB982F346[index]);
        continue;
      }

      level._id_C0440805DA76ABB8[index] thread _id_3887682F4F878030();
      waitframe();
    }

    wait 1;
  }
}

_id_3887682F4F878030() {
  foreach(_id_A166868464F52912 in self._id_E9A3362A072A0053) {
    if(!isDefined(_id_A166868464F52912) || !isDefined(_id_A166868464F52912.model)) {
      continue;
    }
    if(isDefined(_id_A166868464F52912.script_noteworthy) && _id_A166868464F52912.script_noteworthy == "noflash") {
      continue;
    }
    _id_A166868464F52912.model hideallparts();
  }

  wait 0.5;

  foreach(_id_A166868464F52912 in self._id_E9A3362A072A0053) {
    if(!isDefined(_id_A166868464F52912) || !isDefined(_id_A166868464F52912.model)) {
      continue;
    }
    if(isDefined(_id_A166868464F52912.script_noteworthy) && _id_A166868464F52912.script_noteworthy == "noflash") {
      continue;
    }
    _id_A166868464F52912.model showpart("joint_console_a_digit_" + self.value);
  }
}

_id_286B021F1DF637D2() {
  level endon("fil_exit_granted");
  level endon("ee_usb_drive_inserted_event");
  _id_9EE85D3589299411 = 0;
  _id_14FE526C93E41B99 = 0;
  _id_F6E2DB9AE0F6BC7B = undefined;
  level._id_0B0FF425F62007EF = gettime() + 60000;

  for(;;) {
    player = undefined;
    button = undefined;

    if(!_id_9EE85D3589299411) {
      level waittill("securitykey", button, player);
      _id_9EE85D3589299411 = 1;
    } else
      button = _id_0F220799DA8B1476();

    if(!isDefined(player)) {
      if(isDefined(button) && isDefined(button._id_B0DFD912BE32D040))
        player = button._id_B0DFD912BE32D040;
    }

    if(!isDefined(button)) {
      thread _id_382959D7794736CC::_id_AC901BAA09661D94(&"CP_RAID1_BOSS1/FAIL_KEY_TIMEOUT");
      _id_9EE85D3589299411 = 0;
      _id_14FE526C93E41B99++;
      level thread _id_F2A76B3603A649D9((9600, 12680, 400));

      if(level._id_F19C237F80D770E5 > 1) {}

      if(scripts\engine\utility::flag("ee_usb_drive_inserted")) {
        scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_RAID1_BOSS1/USB_DESTROYED", "allies", 3);
        wait 3;
        scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_RAID1_BOSS1/NORMAL_INPUT_RESUMING", "allies", 3);
        _id_20C28607B442E940();
        scripts\engine\utility::flag_clear("ee_usb_drive_inserted");
        level._id_7035A968BB8BC644 _meth_DFB78B3E724AD620(1);
        continue;
      } else if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
        _id_20C28607B442E940();

      _id_1B465BA0AC19079A();
      continue;
    }

    if(level._id_0A67C97EB982F346[level._id_F19C237F80D770E5] != button._id_1E1ACCA53AE06826) {
      level notify("securitykeyinput", "incorrect", button, player);
      wait 0.25;
      thread _id_382959D7794736CC::_id_AC901BAA09661D94(&"CP_RAID1_BOSS1/FAIL_KEY_WRONGBUTTON");
      _id_14FE526C93E41B99++;
      _id_9EE85D3589299411 = 0;
      thread _id_1D3BBBDA8321D492(button);

      if(level._id_F19C237F80D770E5 > 1) {}

      if(scripts\engine\utility::flag("ee_usb_drive_inserted")) {
        scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_RAID1_BOSS1/USB_DESTROYED", "allies", 3);
        wait 3;
        scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_RAID1_BOSS1/NORMAL_INPUT_RESUMING", "allies", 3);
        _id_20C28607B442E940();
        scripts\engine\utility::flag_clear("ee_usb_drive_inserted");
        level._id_7035A968BB8BC644 _meth_DFB78B3E724AD620(1);
        continue;
      } else if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
        _id_20C28607B442E940();

      _id_1B465BA0AC19079A();
      continue;
    }

    level notify("securitykeyinput", "correct", button, player);
    level._id_F19C237F80D770E5++;

    if(level._id_F19C237F80D770E5 % 3 == 0)
      level._id_7EB96032B6AE1388 = level._id_F19C237F80D770E5;

    if(isDefined(_id_F6E2DB9AE0F6BC7B))
      _id_F6E2DB9AE0F6BC7B _meth_DFB78B3E724AD620(1);

    _id_F6E2DB9AE0F6BC7B = button;
    thread _id_2D2E1C8C0FCE51CD(button);

    if(level._id_F19C237F80D770E5 == level._id_0A67C97EB982F346.size || getdvarint("dvar_45936D2E9E61231B", 0) > 0) {
      level thread _id_27C34D802A788648((9600, 12680, 400));

      if(scripts\engine\utility::flag("ee_usb_drive_inserted")) {
        scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_RAID1_BOSS1/USB_COMPLETED", "allies", 3);
        wait 3;
        scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_RAID1_BOSS1/NORMAL_INPUT_RESUMING", "allies", 3);
        _id_20C28607B442E940();
        scripts\engine\utility::flag_clear("ee_usb_drive_inserted");
        scripts\engine\utility::flag_set("fil_ee_code_complete");
        level notify("fil_ee_code_complete");
        level._id_7035A968BB8BC644 _meth_DFB78B3E724AD620(1);
        _id_309D9845CA6A6EE8();
        _id_A3F9B63AE9189D57();
        level thread _id_286B021F1DF637D2();
        return;
      } else {
        if(isDefined(level._id_DD6737D8A32C4546))
          level._id_DD6737D8A32C4546 delete();

        _id_9D4B5B34DDF71038();
      }

      _id_C0A89D82374F5D65 = getEnt("fil_exit_button", "targetname");
      _id_C0A89D82374F5D65 setModel("electrical_cell_door_button_green");
      scripts\engine\utility::flag_set("fil_exit_granted", button._id_B0DFD912BE32D040);
      return;
    }
  }
}

_id_61B37A01BDC641D5() {
  if(gettime() < level._id_0B0FF425F62007EF) {
    return;
  }
  level._id_0B0FF425F62007EF = gettime() + 60000;
  thread _id_CFAE11843C33250B((9784, 12389, 403));
  wait 15;
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("fil_reinforcements", "targetname");
  scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(_id_BFE291B401A9BF2A, 1);
}

_id_E2F7A251F300090B() {
  scripts\engine\utility::flag_init("fil_exit_granted");
  wait 2;
  button = getEnt("fil_exit_button", "targetname");
  button makeusable();
  button sethintdisplayrange(256);
  button setCursorHint("HINT_BUTTON");
  button sethintdisplayfov(65);
  button sethintonobstruction("hide");
  button setuseholdduration("duration_none");
  button thread _id_F3233501F30943F1();
}

_id_F3233501F30943F1() {
  level endon("game_ended");
  self setHintString(&"CP_RAID1_BOSS1/NO_POWER");
  _id_382959D7794736CC::_id_64FCFB5CB3654CBD(1);
  scripts\engine\utility::flag_wait("fil_power_on");
  self setHintString(&"CP_RAID1_BOSS1/ACCESS_DENIED");
  scripts\engine\utility::flag_wait("fil_exit_granted");
  _id_382959D7794736CC::_id_64FCFB5CB3654CBD(0);
  ent = _id_558A9A418B2D3405::_id_1A3A5E66BF63BEB5(self, &"CP_RAID1_BOSS1/OPEN_CUSTODIAL_AREA");
  self _meth_DFB78B3E724AD620(0);
  scripts\engine\utility::flag_set("b1fildone", ent);
  wait 0.5;
  door = getEnt("fil_exit_door", "targetname");
  clip = getEnt("fil_exit_clip", "targetname");
  clip linkTo(door);
  playsoundatpos(door.origin, "evt_raid3_floorislava_end_door");
  door movez(100, 1);
  wait 3;
  clip delete();
  door delete();
}

_id_1D3BBBDA8321D492(button) {
  wait 0.05;
  playsoundatpos(button.origin, "cp_raid3_code_computer_error");
  playsoundatpos((9600, 12680, 400), "cp_raid3_code_computer_error_buzzer");
}

_id_2D2E1C8C0FCE51CD(button) {
  wait 0.05;
  playsoundatpos(button.origin, "cp_raid3_code_computer_success_console");
  playsoundatpos((9600, 12680, 400), "cp_raid3_code_computer_success_alert");
}

_id_309D9845CA6A6EE8() {
  foreach(button in level._id_E5505AF18939A834)
  button _meth_DFB78B3E724AD620(1);
}

_id_9D4B5B34DDF71038() {
  foreach(button in level._id_E5505AF18939A834)
  button _meth_DFB78B3E724AD620(0);
}

_id_0F220799DA8B1476() {
  level endon("securityKeyTimeout");
  level thread _id_65757BDE5461045B();
  level waittill("securitykey", button, player);
  button._id_B0DFD912BE32D040 = player;
  return button;
}

_id_65757BDE5461045B() {
  level endon("securitykey");
  _id_8C4EACE0295E0991 = 9;
  _id_65880D27F2E9614D = 6;
  _id_8C4EACE0295E0991 = getdvarint("dvar_20D179BD46B1B8EB", 9);
  _id_65880D27F2E9614D = getdvarint("dvar_F76A3CC9035E2D06", 6);
  time = gettime() + _id_8C4EACE0295E0991 * 1000;
  count = -1;

  while(gettime() < time) {
    wait 1;
    count++;

    if(_id_8C4EACE0295E0991 - count > 1) {
      alias = _id_017BE105A66CFF99(_id_8C4EACE0295E0991 - count, _id_65880D27F2E9614D);

      if(alias != "")
        playsoundatpos((9600, 12680, 400), alias);
    }
  }

  level notify("securityKeyTimeout");
}

_id_017BE105A66CFF99(_id_8DD9F2EB8215A139, _id_65880D27F2E9614D) {
  alias = "cp_raid3_puzzle_timer_beep_single";

  if(_id_8DD9F2EB8215A139 < _id_65880D27F2E9614D / 1.5)
    alias = "cp_raid3_puzzle_timer_beep_almostout";
  else if(_id_8DD9F2EB8215A139 <= _id_65880D27F2E9614D)
    alias = "cp_raid3_puzzle_timer_beep_lowtime";

  return alias;
}

_id_F2A76B3603A649D9(position) {
  playsoundatpos(position, "cp_raid3_puzzle_timer_elapsed");
}

_id_27C34D802A788648(position) {
  wait 0.8;
  playsoundatpos(position, "cp_raid3_code_puzzle_cleared");
}

_id_1BE4F70E2CF74453(sfx) {
  if(soundexists(sfx)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
      level.players[_id_AC0E594AC96AA3A8] playlocalsound(sfx);
  }
}

_id_F1D2306CBF75AE31() {
  self endon("success");
  self setHintString(&"CP_RAID1_BOSS1/NO_POWER");
  _id_382959D7794736CC::_id_64FCFB5CB3654CBD(1);
  scripts\engine\utility::flag_wait("fil_power_on");
  self setHintString(&"CP_RAID1_BOSS1/FAIL_NEED_KEY");
  scripts\engine\utility::flag_wait("securitykeygenerated");
  self setHintString(&"CP_RAID1_BOSS1/FIL_ACTIVATE_BUTTON");
  _id_382959D7794736CC::_id_64FCFB5CB3654CBD(0);

  for(;;) {
    self waittill("trigger", ent);

    if(!ent scripts\cp\utility::is_valid_player()) {
      continue;
    }
    self _meth_DFB78B3E724AD620(0);
    success = ent forceplaygestureviewmodel("iw9_ges_cp_button", self);
    ent playSound("cp_raid3_laptop_interaction_fly");

    if(success) {
      _id_32C6AA3068E68ED7 = ent getgestureanimlength("iw9_ges_cp_button") * ent _meth_B009DD5CAEC7B9DD("iw9_ges_cp_button", "interruptible")[0];
      ent _id_3B64EB40368C1450::set("fil_button", "reload", 0);
      ent scripts\engine\utility::delaythread(_id_32C6AA3068E68ED7, _id_3B64EB40368C1450::set, "fil_button", "reload", 1);
    }

    wait 0.2;
    level notify("securitykey", self, ent);
  }
}

_id_92CA8A9FEFF16CC4(objectivestruct) {
  scripts\cp\cp_checkpoint::checkpoint_set("boss1_fil_end");
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("fil_end");

  if(scripts\engine\utility::flag_exist("flashlight_high"))
    scripts\engine\utility::flag_clear("flashlight_high");

  if(!istrue(level._id_394B92D9305D486E)) {
    level._id_CC86627703B86AF5["floor_is_lava"] = getEnt("area5_elec_trigger", "targetname");
    level._id_51FBA2BBD80629D9["floor_is_lava"] = scripts\engine\utility::getStructArray("electic_fx_area5", "targetname");
    thread _id_323248A3057C390F::_id_9168E4D97136F379("floor_is_lava");
  }

  if(!istrue(level._id_B9E06F3785D1AC04)) {
    level thread _id_382959D7794736CC::_id_BF11D3FD19E18ABE();
    level._id_B9E06F3785D1AC04 = 1;
  }

  level thread _id_382959D7794736CC::_id_9D291774C6674A30();

  if(!isDefined(level._id_20A3C60BA9434F71)) {
    level._id_20A3C60BA9434F71 = 1;
    level thread _id_382959D7794736CC::_id_0C735D60735EDA5F();
    waitframe();
    _id_382959D7794736CC::_id_E97CB398476590D1();
  }

  level thread _id_4900EE6258CDEAD3();

  if(!scripts\engine\utility::flag_exist("fil_exit_granted"))
    level thread _id_E2F7A251F300090B();

  level thread _id_E077D93404FE7C0D();
  waitframe();

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_2E9261330FBCEC80 = scripts\engine\utility::getStructArray("b1_fil_end_players", "targetname");
    _id_0AFB7E332AEE4BF2::_id_79DDAC0EF09B8D0F(_id_2E9261330FBCEC80, 0);
  }

  level thread _id_24D3D5C5A0521C72::_id_8CE8975F5D76A5CF();
  scripts\engine\utility::flag_set("fil_exit_granted");
  scripts\engine\utility::flag_wait("b1fildone");
  level scripts\engine\utility::delaythread(1, ::_id_6D5BA4D2272F0BAF);
  level thread _id_01B1A46EFB26E5A9::_id_291B7337A2A203C3();
  level thread _id_A75BB17560B4BD23();
  level waittill("kitchen_trigger");
  level thread kitchen_ambush();
  level._id_20A3C60BA9434F71 = 0;
  _id_DFAA1AC3B35C67D1 = getEnt("ventroom_start_trigger", "targetname");

  for(;;) {
    _id_DFAA1AC3B35C67D1 waittill("trigger", ent);

    if(isPlayer(ent)) {
      break;
    } else
      continue;
  }

  scripts\cp\cp_analytics::_id_B6283AC45A607764("fil_end");
  scripts\cp\cp_checkpoint::checkpoint_set("boss1_fil_vent");
}

_id_6C8CBF370BE19AD0(objectivestruct) {
  setdvarifuninitialized("dvar_59AA26D7EFCD0F8E", 1);
  scripts\cp\cp_checkpoint::checkpoint_set("boss1_fil_vent");
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("fil_vent");

  if(scripts\engine\utility::flag_exist("flashlight_high"))
    scripts\engine\utility::flag_clear("flashlight_high");

  level thread _id_24D3D5C5A0521C72::_id_8CE8975F5D76A5CF();
  level thread scripts\cp_mp\tripwire::init();
  _id_594132FAB60AA90D::_id_246582E2CB860BCD();
  level thread _id_382959D7794736CC::_id_9D291774C6674A30();

  if(!isDefined(level._id_20A3C60BA9434F71))
    level thread _id_382959D7794736CC::_id_0C735D60735EDA5F();

  _id_59A718FC942B23BD();
  level thread _id_382959D7794736CC::_id_A0E2527CF709959D();
  level thread _id_A7EE2B398A72B8D6();
  level thread _id_5F3527D8152EE0A0();
  level thread _id_382959D7794736CC::_id_A5A34903B136C045("vent_exit_struct", 1);
  level thread _id_A4E9F1B2383CA65A();
  _id_B8FF749D7F3F25C1 = getEnt("fil_end_trigger", "targetname");
  _id_B8FF749D7F3F25C1 waittill("trigger");
  level.stealth.bstayincombatoncealerted = 0;
  _func_AA9FA9C5A97D0F6E(0);
  scripts\cp\cp_analytics::_id_B6283AC45A607764("fil_vent");
  level notify("stop_tripwire_wipes");
}

_id_06A45861DDC5FDD4() {
  if(isDefined(level._id_C0440805DA76ABB8)) {
    foreach(_id_9A01675C5F6B90A1 in level._id_C0440805DA76ABB8) {
      if(isDefined(_id_9A01675C5F6B90A1) && isDefined(_id_9A01675C5F6B90A1._id_E9A3362A072A0053)) {
        foreach(_id_A166868464F52912 in _id_9A01675C5F6B90A1._id_E9A3362A072A0053) {
          if(isDefined(_id_A166868464F52912.model))
            _id_A166868464F52912.model delete();

          waitframe();
        }
      }
    }
  }
}

_id_B3A0535FD431BC68() {
  enemies = getEntArray("fil_exit_spawners", "targetname");

  for(;;) {
    foreach(guy in enemies) {
      if(!isalive(guy))
        enemies = scripts\engine\utility::array_remove(enemies, guy);
    }

    if(enemies.size > 4)
      continue;
    else {
      _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("fil_exit_extra", "targetname");
      scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(_id_BFE291B401A9BF2A, 1);
      break;
    }
  }
}

_id_DC521AFA9762AB73() {
  level endon("game_ended");
  _id_1D902281891585F9 = scripts\engine\utility::getStruct("player_near_fil", "targetname");
  _id_830905E5C2645826 = "player_near_fil";
  _id_382959D7794736CC::_id_AB240E7CFE63075D(_id_1D902281891585F9, _id_830905E5C2645826, 300);
}

_id_E077D93404FE7C0D() {
  level endon("game_ended");
  button = getEnt("fil_power_switch", "targetname");
  scripts\engine\utility::flag_set("fil_power_on");

  if(!istrue(level._id_394B92D9305D486E)) {
    level._id_394B92D9305D486E = 1;
    level thread _id_68D137712CA50204("on");
    level thread _id_323248A3057C390F::_id_1609D9F10A1663F4("floor_is_lava", "stop_tripwire_wipes");
  }
}

kitchen_ambush() {
  foreach(_id_1FE90B84D9AB9DB6 in level._id_3561E381EFD3D581)
  _id_1FE90B84D9AB9DB6 movez(-150, 0.1);

  _id_FE923A1BE9F2065A = scripts\engine\utility::getStruct("kitchen_alarm", "targetname");
  thread _id_CFAE11843C33250B(_id_FE923A1BE9F2065A.origin);
  wait 1.5;
  level._id_18F50466239BE9DC = scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(scripts\engine\utility::getStructArray("kitchen_ambush_1", "targetname"), 1);
  waitframe();
  thread _id_1A9567F94912596D();
  thread _id_78A90861AE81F6BD();
  thread _id_E08911EEDB2F54DC();
  level scripts\engine\utility::waittill_any_2("kitchen_time_up", "kitchen_enemy_kill");
  level._id_18F50766239BF075 = scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(scripts\engine\utility::getStructArray("kitchen_ambush_2", "targetname"), 1);
  wait 0.5;
  thread _id_A143F7320FA44ACD();
  wait 0.1;
  _id_1690F34A5749E44F = scripts\engine\utility::getStructArray("smoke_target", "targetname");

  foreach(_id_0C3EA9B1A20FF199 in _id_1690F34A5749E44F) {
    magicgrenademanual("smoke_grenade_mp", _id_0C3EA9B1A20FF199.origin, (0, 0, 10), 0.5);
    wait 0.5;
  }

  thread _id_66B4FACEDCAD922E();
  wait 6;

  foreach(guy in level._id_18F50466239BE9DC) {
    if(isalive(guy))
      guy.goalradius = 2048;
  }
}

_id_1A9567F94912596D() {
  _id_2A5E47F85E6A22A5 = getEntArray("roll_up", "targetname");
  playsoundatpos((11021, 7467, 381), "evt_raid3_window_shutters_open");
  playsoundatpos((10190, 7482, 381), "evt_raid3_window_shutters_open");

  foreach(_id_4B37C1DF960B78D1 in _id_2A5E47F85E6A22A5)
  _id_4B37C1DF960B78D1 movez(100, 0.5);
}

_id_78A90861AE81F6BD() {
  self endon("game_ended");
  self endon("kitchen_enemy_kill");
  wait 9;
  level notify("kitchen_time_up");
}

_id_E08911EEDB2F54DC() {
  for(;;) {
    foreach(guy in level._id_18F50466239BE9DC) {
      if(!isalive(guy))
        level._id_18F50466239BE9DC = scripts\engine\utility::array_remove(level._id_18F50466239BE9DC, guy);
    }

    if(level._id_18F50466239BE9DC.size < 4) {
      break;
    }

    wait 1;
  }

  level notify("kitchen_enemy_kill");
}

_id_6D5BA4D2272F0BAF() {
  _id_DEC5C63823FD000C = scripts\engine\utility::getStruct("kitchen_double_door", "targetname");
  _id_BFB160E6FD61C205 = scripts\engine\utility::getStruct("kitchen_single_door", "targetname");
  thread _id_382959D7794736CC::_id_887438C3B4B194B6(1, _id_DEC5C63823FD000C.origin);
  thread _id_382959D7794736CC::_id_887438C3B4B194B6(1, _id_BFB160E6FD61C205.origin);
}

_id_A143F7320FA44ACD() {
  _id_DEC5C63823FD000C = scripts\engine\utility::getStruct("kitchen_double_door", "targetname");
  _id_BFB160E6FD61C205 = scripts\engine\utility::getStruct("kitchen_single_door", "targetname");
  _id_382959D7794736CC::_id_887438C3B4B194B6(0, _id_BFB160E6FD61C205.origin);
  wait 0.5;
  _id_382959D7794736CC::_id_887438C3B4B194B6(0, _id_DEC5C63823FD000C.origin);
}

_id_A75BB17560B4BD23() {
  _id_A494000914327C5B = getEnt("kitchen_gate_front", "targetname");
  _id_8DD3608B8A80022A = getEnt("kitchen_gate_front_clip", "targetname");
  _id_A494000914327C5B linkTo(_id_8DD3608B8A80022A);
  _id_34A4A83F95364C3C = getEnt("kitchen_gate_exit", "targetname");
  _id_CB154CBCEDC6FC17 = getEnt("kitchen_gate_exit_clip", "targetname");
  _id_34A4A83F95364C3C linkTo(_id_CB154CBCEDC6FC17);
  level._id_3561E381EFD3D581 = [_id_8DD3608B8A80022A, _id_CB154CBCEDC6FC17];

  foreach(_id_1FE90B84D9AB9DB6 in level._id_3561E381EFD3D581)
  _id_1FE90B84D9AB9DB6 movez(150, 0.1);

  _id_B40FD955D93BB440 = getEnt("kitchen_event_trigger", "targetname");

  for(;;) {
    touching = 0;

    foreach(player in level.players) {
      if(player istouching(_id_B40FD955D93BB440))
        touching++;
    }

    if(touching == level.players.size) {
      break;
    }

    wait 0.1;
  }

  level notify("kitchen_trigger");
}

_id_66B4FACEDCAD922E() {
  _id_D6324EDEF6272D90 = scripts\engine\utility::array_combine(level._id_18F50466239BE9DC, level._id_18F50766239BF075);

  for(;;) {
    _id_3EC2847B0DA47D81 = 0;

    foreach(guy in _id_D6324EDEF6272D90) {
      if(isalive(guy))
        _id_3EC2847B0DA47D81 = _id_3EC2847B0DA47D81 + 1;
    }

    if(_id_3EC2847B0DA47D81 <= 4) {
      break;
    }

    wait 1;
  }

  level._id_3561E381EFD3D581[1] connectpaths();
  level._id_18F50666239BEE42 = scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(scripts\engine\utility::getStructArray("kitchen_ambush_3", "targetname"), 1);
  level._id_3561E381EFD3D581[1] movez(150, 0.1);
}

_id_FFEC324BD5085987() {
  level notify("elevatorSway");
  waitframe();
  level notify("elevator_stopturn");
  _id_51E791B4D5448C42 = getEntArray("silo_ee_valve", "targetname");
  _id_637839EE4AE18CD8 = getEntArray("silo_ee_needle_1", "targetname");
  _id_63783CEE4AE19371 = getEntArray("silo_ee_needle_2", "targetname");
  _id_63783BEE4AE1913E = getEntArray("silo_ee_needle_3", "targetname");
  _id_63783EEE4AE197D7 = getEntArray("silo_ee_needle_4", "targetname");
  _id_1D2BE7531AAF82AF = scripts\engine\utility::array_combine(_id_51E791B4D5448C42, _id_637839EE4AE18CD8, _id_63783CEE4AE19371, _id_63783BEE4AE1913E, _id_63783EEE4AE197D7);

  foreach(ent in _id_1D2BE7531AAF82AF) {
    if(isDefined(ent))
      ent delete();
  }

  if(isDefined(level._id_10C35EC751227DA5))
    level._id_10C35EC751227DA5 delete();

  _id_EEC55FABA21F3653 = getEnt("silo_elevator", "targetname");

  if(isDefined(_id_EEC55FABA21F3653))
    _id_EEC55FABA21F3653 delete();

  _id_BD901692981B143A = getEnt("silo_elevator_rope", "targetname");

  if(isDefined(_id_BD901692981B143A))
    _id_BD901692981B143A delete();

  clip = getEnt("silo_elevator_clip", "targetname");

  if(isDefined(clip))
    clip delete();

  _id_1CA72225D98F7DD6 = getEntArray("silo_elevator_panels", "targetname");

  foreach(_id_9A01675C5F6B90A1 in _id_1CA72225D98F7DD6) {
    if(isDefined(_id_9A01675C5F6B90A1))
      _id_9A01675C5F6B90A1 delete();
  }
}

_id_59A718FC942B23BD() {
  door = getEnt("ventroom_door", "targetname");
  doorclip = getEnt("ventroom_door_clip", "targetname");
  doorclip linkTo(door);
  _id_5AC49E018B46B2CD = scripts\engine\utility::getStruct("ventroom_button", "targetname");
  _id_20F3271DC43A6012 = scripts\engine\utility::getStruct(_id_5AC49E018B46B2CD.target, "targetname");
  _id_5AC49E018B46B2CD _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(&"CP_HARRIER_BOSS/HOLD_TO_OPEN", "electrical_cell_door_button_red", 72, 256, "duration_none", "hide", undefined, "electrical_cell_door_button_green");
  _id_20F3271DC43A6012 _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(&"CP_HARRIER_BOSS/HOLD_TO_OPEN", "electrical_cell_door_button_red", 72, 256, "duration_none", "hide", undefined, "electrical_cell_door_button_green");
  door._id_CDFF6CE3D4D73F68 = 1;
  door._id_F14FE08CFB8BEE65 = _id_382959D7794736CC::_id_07DF365D859CDC1E;
  _id_5AC49E018B46B2CD _id_05F7C6BF2110C0FE(door, 1, 1, 1);
  level thread _id_719FDC466D2D5E49(door._id_590D3F80EE9B48CB, door._id_7432D0D0FA70617C);
}

_id_719FDC466D2D5E49(_id_F60F53F75958341C, _id_F60F56F759583AB5) {
  level endon("game_ended");
  _id_F60F53F75958341C setHintString(&"CP_HARRIER_BOSS/HOLD_TO_OPEN_0_2");
  _id_F60F56F759583AB5 setHintString(&"CP_HARRIER_BOSS/HOLD_TO_OPEN_0_2");

  for(;;) {
    wait 0.5;

    if(!isent(_id_F60F53F75958341C) || !isent(_id_F60F56F759583AB5)) {
      return;
    }
    _id_C7DA6006852F4582 = 0;

    if(istrue(_id_F60F53F75958341C._id_48EE2E092B24BD8B))
      _id_C7DA6006852F4582 = _id_C7DA6006852F4582 + 1;

    if(istrue(_id_F60F56F759583AB5._id_48EE2E092B24BD8B))
      _id_C7DA6006852F4582 = _id_C7DA6006852F4582 + 1;

    if(_id_C7DA6006852F4582 == 0) {
      _id_F60F53F75958341C setHintString(&"CP_HARRIER_BOSS/HOLD_TO_OPEN_0_2");
      _id_F60F56F759583AB5 setHintString(&"CP_HARRIER_BOSS/HOLD_TO_OPEN_0_2");
      continue;
    }

    if(_id_C7DA6006852F4582 == 1) {
      _id_F60F53F75958341C setHintString(&"CP_HARRIER_BOSS/HOLD_TO_OPEN_1_2");
      _id_F60F56F759583AB5 setHintString(&"CP_HARRIER_BOSS/HOLD_TO_OPEN_1_2");
      continue;
    }

    if(_id_C7DA6006852F4582 == 2) {
      _id_F60F53F75958341C setHintString(&"CP_HARRIER_BOSS/HOLD_TO_OPEN_2_2");
      _id_F60F56F759583AB5 setHintString(&"CP_HARRIER_BOSS/HOLD_TO_OPEN_2_2");
    }
  }
}

_id_A7EE2B398A72B8D6() {
  level endon("game_ended");
  level endon("stop_tripwire_wipes");
  level waittill("tripwire_detonated");
  thread _id_FC8CCF8AA489C8DA();

  foreach(trap in level._id_724904B6525E2D4D) {
    if(isDefined(trap.trap))
      trap.trap dodamage(100, level.players[0].origin, level.players[0], undefined, "MOD_PISTOL_BULLET", "iw9_ar_mike4_mp");

    wait 0.5;
  }
}

_id_FC8CCF8AA489C8DA() {
  wait 2;
  kill_trigger = getEnt("ventroom_kill_trigger", "targetname");

  foreach(player in level.players) {
    if(player istouching(kill_trigger))
      player dodamage(300, player.origin, player, undefined, "MOD_EXPLOSIVE", "frag_grenade_mp");
  }

  wait 1;

  foreach(player in level.players) {
    if(player istouching(kill_trigger))
      player dodamage(300, player.origin, player, undefined, "MOD_EXPLOSIVE", "frag_grenade_mp");
  }
}

_id_5F3527D8152EE0A0() {
  level endon("game_ended");
  _id_2E3C207F7651DDEC::_id_6A2FB36704651FC8();
  _id_66B44D5E369CE46A = scripts\engine\utility::getStruct("fire_spout", "targetname");
  _id_66B44D5E369CE46A._id_13EE6EFB16352697 = (12056.5, 7486.3, 559.893);
  _id_66B44D5E369CE46A._id_E4CA48B886F78652 = "evt_raid3_fire_pipe_on";
  _id_66B44D5E369CE46A._id_08204D487A1F9ED8 = "evt_raid3_fire_pipe_off";
  _id_66B44D5E369CE46A._id_F952D839211EF876 = "evt_raid3_fire_pipe_lp";
  _id_66B44D5E369CE46A thread _id_2E3C207F7651DDEC::steam_point_think();
}

_id_05F7C6BF2110C0FE(doors, allowweapons, _id_1C9B02E3E36CC88F, _id_DD00509DA4ADCBBA) {
  door = doors;

  if(!isDefined(allowweapons))
    allowweapons = 1;

  _id_5AC49E018B46B2CD = self;

  if(isDefined(door.target))
    _id_5AC49E018B46B2CD = scripts\engine\utility::getStruct(door.target, "targetname");

  _id_5AC49E018B46B2CD _id_34D2771929BD6022::_id_0C48BF42FE488B71();
  door._id_7432D0D0FA70617C = _id_18AF78602B67B70C::_id_683F024F53CEE760(_id_5AC49E018B46B2CD, _id_5AC49E018B46B2CD.hintstring, _id_5AC49E018B46B2CD.buttonmodel, _id_5AC49E018B46B2CD.duration, _id_5AC49E018B46B2CD.usedist, _id_5AC49E018B46B2CD.hintdist, _id_5AC49E018B46B2CD.onobstruction, _id_5AC49E018B46B2CD.usefov);
  door._id_7432D0D0FA70617C thread _id_D61F0E1B1E3E6A20(door, 0, allowweapons, _id_1C9B02E3E36CC88F);
  door._id_5AC49E018B46B2CD = _id_5AC49E018B46B2CD;

  if(isDefined(_id_5AC49E018B46B2CD.target)) {
    _id_20F3271DC43A6012 = scripts\engine\utility::getStruct(_id_5AC49E018B46B2CD.target, "targetname");
    _id_20F3271DC43A6012 _id_34D2771929BD6022::_id_0C48BF42FE488B71();
    door._id_590D3F80EE9B48CB = _id_18AF78602B67B70C::_id_683F024F53CEE760(_id_20F3271DC43A6012, _id_20F3271DC43A6012.hintstring, _id_20F3271DC43A6012.buttonmodel, _id_20F3271DC43A6012.duration, _id_20F3271DC43A6012.usedist, _id_20F3271DC43A6012.hintdist, _id_20F3271DC43A6012.onobstruction, _id_20F3271DC43A6012.usefov);
    door._id_590D3F80EE9B48CB thread _id_D61F0E1B1E3E6A20(door, 1, allowweapons);
  }

  door._id_18D12C4028C20617 = 0;
  door._id_2E523BBC651A297A = 0;
  door.open = 0;
  door.closedpos = door.origin;
  door.openpos = door.origin + door.script_offset;

  if(istrue(_id_DD00509DA4ADCBBA))
    door._id_BA5410B92C5C60BB = door.closedpos + (0, 0, 55);

  level thread _id_593DA22F293BA95C(door);
}

_id_593DA22F293BA95C(door) {
  for(;;) {
    if(getdvarint("dvar_59AA26D7EFCD0F8E", 1)) {
      while(!istrue(door._id_18D12C4028C20617) || !istrue(door._id_2E523BBC651A297A)) {
        wait 0.05;
        continue;
      }
    } else {
      while(!istrue(door._id_18D12C4028C20617) && !istrue(door._id_2E523BBC651A297A)) {
        wait 0.05;
        continue;
      }
    }

    level notify("multiPersonDoor_startOpen", door);
    frac = 0.1;
    door playSound("cp_buddy_door_open");

    if(getdvarint("dvar_59AA26D7EFCD0F8E", 1)) {
      while(istrue(door._id_18D12C4028C20617) && istrue(door._id_2E523BBC651A297A)) {
        if(istrue(door.open)) {
          wait 0.05;
          continue;
        }

        _id_D0DE0DB1760B9C5B = vectorlerp(door.origin, door.openpos, frac);
        door moveTo(_id_D0DE0DB1760B9C5B, 0.1);
        frac = frac + 0.1;

        if(frac >= 1) {
          door.open = 1;
          door notify("door_open");
        }

        wait 0.1;
      }
    } else {
      while(istrue(door._id_18D12C4028C20617) || istrue(door._id_2E523BBC651A297A)) {
        if(istrue(door.open)) {
          wait 0.05;
          continue;
        }

        _id_D0DE0DB1760B9C5B = vectorlerp(door.origin, door.openpos, frac);
        door moveTo(_id_D0DE0DB1760B9C5B, 0.1);
        frac = frac + 0.1;

        if(frac >= 1) {
          door.open = 1;
          door notify("door_open");
        }

        wait 0.1;
      }
    }

    if(isDefined(door._id_F14FE08CFB8BEE65)) {
      if(istrue(door[[door._id_F14FE08CFB8BEE65]]())) {
        while(istrue(door[[door._id_F14FE08CFB8BEE65]]()))
          wait 0.05;
      }
    }

    door playSound("cp_buddy_door_close");
    door moveTo(door.closedpos, 0.5);
    door thread _id_34D2771929BD6022::_id_76E36F6406D4F382(0.5);
    wait 1;
    door.open = 0;
    door notify("door_close");
  }
}

_id_D61F0E1B1E3E6A20(door, _id_B322230DFCCF2433, _id_C74648864D9160C6, _id_1C9B02E3E36CC88F) {
  for(;;) {
    self waittill("trigger", ent);
    self _meth_DFB78B3E724AD620(0);

    if(!ent scripts\cp\utility::is_valid_player() || istrue(self.disabled)) {
      self _meth_DFB78B3E724AD620(1);
      continue;
    }

    if(isDefined(self._id_785C56130FCDBC47))
      self playSound(self._id_785C56130FCDBC47);

    level notify("multiPersonDoor_buttonPressed", ent);

    if(!istrue(ent._id_EB8EE2C6D463E28F)) {
      ent._id_EB8EE2C6D463E28F = 1;
      ent thread _id_2098BF9F4DE12403(self, door, _id_B322230DFCCF2433, _id_C74648864D9160C6, _id_1C9B02E3E36CC88F);
    }
  }
}

_id_2098BF9F4DE12403(button, door, _id_B322230DFCCF2433, _id_C74648864D9160C6, _id_1C9B02E3E36CC88F) {
  self endon("death_or_disconnect");
  _id_42C39BE9231F929F = !istrue(_id_B322230DFCCF2433);

  if(isDefined(_id_1C9B02E3E36CC88F))
    _id_42C39BE9231F929F = _id_1C9B02E3E36CC88F;

  button thread _id_34D2771929BD6022::_id_3287D082EC56C521(self, _id_42C39BE9231F929F, door);
  _id_3B64EB40368C1450::set("opening", "usability", 0);
  _id_3B64EB40368C1450::set("opening", "allow_movement", 0);

  if(!istrue(_id_C74648864D9160C6)) {
    _id_3B64EB40368C1450::set("opening", "weapon", 0);
    wait 0.5;
  }

  self waittill("button_pressed_anim");

  if(_id_B322230DFCCF2433)
    door._id_18D12C4028C20617 = 1;
  else
    door._id_2E523BBC651A297A = 1;

  self waittill("button_pressed_done");
  door notify("opening");

  while(self useButtonPressed() && distance2d(self.origin, button.origin) < 64 && !istrue(self.inlaststand) && !istrue(button.disabled) || istrue(door._id_BCBE2E310C02E89B)) {
    if(_id_B322230DFCCF2433)
      door._id_18D12C4028C20617 = 1;
    else
      door._id_2E523BBC651A297A = 1;

    wait 0.05;
  }

  level notify("multiPersonDoor_buttonReleased", self);
  self._id_EB8EE2C6D463E28F = undefined;

  if(!istrue(door._id_CDFF6CE3D4D73F68))
    self waittill("button_released_anim");

  if(!istrue(door.open)) {
    if(!istrue(door._id_A85B0AF305EEDD88)) {
      if(_id_B322230DFCCF2433)
        door._id_18D12C4028C20617 = 0;
      else
        door._id_2E523BBC651A297A = 0;
    }
  }

  self waittill("buddy_door_unlinked");

  if(!istrue(_id_C74648864D9160C6)) {
    _id_3B64EB40368C1450::set("opening", "weapon", 1);
    wait 0.5;
  }

  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("opening");

  if(door.open) {
    if(_id_B322230DFCCF2433)
      door._id_18D12C4028C20617 = 0;
    else
      door._id_2E523BBC651A297A = 0;
  }

  wait 0.5;
  door._id_7432D0D0FA70617C _meth_DFB78B3E724AD620(1);

  if(isDefined(door._id_590D3F80EE9B48CB))
    door._id_590D3F80EE9B48CB _meth_DFB78B3E724AD620(1);
}

_id_095E4E73CC6E660C() {
  for(;;) {
    if(scripts\engine\utility::flag("fil_power_on") && scripts\engine\utility::flag("fil_boss_died")) {
      scripts\cp\cp_checkpoint::checkpoint_set("boss1_fil_p");
      break;
    }

    wait 1;
  }
}

_id_365A17A79D0B20E2() {
  level endon("game_ended");
  level endon("fil_power_on");
  level endon("fil_boss_died");

  for(;;) {
    _id_01D4621C77C9108F = getaiarray("axis");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_01D4621C77C9108F.size; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(_id_01D4621C77C9108F[_id_AC0E594AC96AA3A8]) || !isalive(_id_01D4621C77C9108F[_id_AC0E594AC96AA3A8])) {
        continue;
      }
      if(_id_01D4621C77C9108F[_id_AC0E594AC96AA3A8].aitype == "boss_velikan") {
        continue;
      }
      if(!isDefined(_id_01D4621C77C9108F[_id_AC0E594AC96AA3A8]._id_36A94AB3A7471FF2)) {
        _id_F0FFAFCA5D927A12 = _id_01D4621C77C9108F[_id_AC0E594AC96AA3A8].weapon;
        _id_EFFB4AE1788A8B10 = "";

        switch (_id_F0FFAFCA5D927A12.classname) {
          case "rifle":
          case "sniper":
            _id_EFFB4AE1788A8B10 = "laserbox_hip04";
            break;
          case "mg":
            _id_EFFB4AE1788A8B10 = "laserbox_hip04";
            break;
          case "pistol":
            _id_EFFB4AE1788A8B10 = "laserpstl_hip04";
            break;
          case "smg":
            _id_EFFB4AE1788A8B10 = "laserbox_hip04";
            break;
          case "spread":
            _id_EFFB4AE1788A8B10 = "lasercyl_hip04";
            break;
          default:
            break;
        }

        if(!_id_F0FFAFCA5D927A12 canuseattachment(_id_EFFB4AE1788A8B10)) {
          continue;
        }
        _id_DD515FCF025B2E79 = _id_F0FFAFCA5D927A12 withattachment(_id_EFFB4AE1788A8B10);

        if(isDefined(_id_01D4621C77C9108F[_id_AC0E594AC96AA3A8].weapon))
          _id_01D4621C77C9108F[_id_AC0E594AC96AA3A8] takeweapon(_id_01D4621C77C9108F[_id_AC0E594AC96AA3A8].weapon);

        _id_01D4621C77C9108F[_id_AC0E594AC96AA3A8].weapon = _id_DD515FCF025B2E79;
        _id_01D4621C77C9108F[_id_AC0E594AC96AA3A8] scripts\common\utility::initweapon(_id_01D4621C77C9108F[_id_AC0E594AC96AA3A8].weapon);
        _id_01D4621C77C9108F[_id_AC0E594AC96AA3A8] giveweapon(_id_01D4621C77C9108F[_id_AC0E594AC96AA3A8].weapon);
        _id_01D4621C77C9108F[_id_AC0E594AC96AA3A8] setspawnweapon(_id_01D4621C77C9108F[_id_AC0E594AC96AA3A8].weapon);
        _id_01D4621C77C9108F[_id_AC0E594AC96AA3A8].bulletsinclip = weaponclipsize(_id_01D4621C77C9108F[_id_AC0E594AC96AA3A8].weapon);
        _id_01D4621C77C9108F[_id_AC0E594AC96AA3A8].primaryweapon = _id_01D4621C77C9108F[_id_AC0E594AC96AA3A8].weapon;
        waitframe();
        _id_01D4621C77C9108F[_id_AC0E594AC96AA3A8] laseron();
        _id_01D4621C77C9108F[_id_AC0E594AC96AA3A8]._id_36A94AB3A7471FF2 = 1;
      }

      wait 0.05;
    }

    wait 5;
  }
}

_id_D13939902BCE7A55() {
  wait 1.5;
  _id_01D4621C77C9108F = getaiarray("axis");

  foreach(guy in _id_01D4621C77C9108F) {
    if(guy.aitype == "boss_velikan") {
      level._id_1C9F8C821C0F25BC = guy;
      break;
    }
  }

  if(isDefined(level._id_1C9F8C821C0F25BC)) {
    while(isalive(level._id_1C9F8C821C0F25BC)) {
      wait 0.5;
      continue;
    }
  }

  scripts\engine\utility::flag_set("fil_boss_died");
}

_id_2691730E459328E5() {
  level endon("game_ended");
  level endon("fil_exit_granted");
  scripts\engine\utility::flag_wait("ee_usb_drive_inserted");
  level._id_7035A968BB8BC644 _meth_DFB78B3E724AD620(0);
  wait 0.5;

  for(_id_AC0E594AC96AA3A8 = 8; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
    lights = getentitylessscriptablearray("zone_0" + _id_AC0E594AC96AA3A8, "targetname");

    foreach(light in lights) {
      light setscriptablepartstate("controller", "off");
      waitframe();
    }
  }

  wait 0.5;

  for(_id_AC0E594AC96AA3A8 = 8; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
    lights = getentitylessscriptablearray("zone_0" + _id_AC0E594AC96AA3A8, "targetname");

    foreach(light in lights) {
      light setscriptablepartstate("controller", "on");
      wait(randomfloatrange(0.1, 0.25));
    }
  }

  playsoundatpos(level._id_7035A968BB8BC644.origin, "cp_raid3_code_computer_newcode");
  _id_F60869D706D0891D();
  _id_8F4E225CF2264E02();
  _id_0A67C97EB982F346 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  _id_BFC65A378A6D8EFE = scripts\engine\utility::array_randomize(_id_0A67C97EB982F346);
  _id_619875E4F15D87D0 = 6;
  level._id_0A67C97EB982F346 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_619875E4F15D87D0; _id_AC0E594AC96AA3A8++) {
    level._id_0A67C97EB982F346[_id_AC0E594AC96AA3A8] = _id_BFC65A378A6D8EFE[_id_AC0E594AC96AA3A8];

    if(level._id_0A67C97EB982F346.size >= _id_619875E4F15D87D0) {
      break;
    }
  }

  wait 1;
  _id_A3F9B63AE9189D57();
  level thread _id_286B021F1DF637D2();
  level thread _id_65AB8D19A9271F6A();
}

_id_65AB8D19A9271F6A() {
  level endon("securitykey");
  level endon("fil_ee_code_complete");
  _id_8C4EACE0295E0991 = 120;
  _id_65880D27F2E9614D = 45;
  time = gettime() + _id_8C4EACE0295E0991 * 1000;
  count = -1;

  while(gettime() < time) {
    wait 1;
    count++;

    if(_id_8C4EACE0295E0991 - count > 1) {
      alias = _id_017BE105A66CFF99(_id_8C4EACE0295E0991 - count, _id_65880D27F2E9614D);

      if(alias != "")
        playsoundatpos((9600, 12680, 400), alias);
    }
  }

  if(scripts\engine\utility::flag("ee_usb_drive_inserted")) {
    scripts\engine\utility::flag_clear("ee_usb_drive_inserted");
    scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_RAID1_BOSS1/USB_DESTROYED", "allies", 3);
    wait 3;
    scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_RAID1_BOSS1/NORMAL_INPUT_RESUMING", "allies", 3);
    _id_20C28607B442E940();
    level._id_7035A968BB8BC644 _meth_DFB78B3E724AD620(1);
  }
}

_id_A4E9F1B2383CA65A() {
  level endon("game_ended");
  level._id_C1A86F5185A4424F = scripts\engine\utility::getclosest((7222, 14614, 342), level._id_DB7BB73A753C01D7);

  for(;;) {
    if(level._id_C1A86F5185A4424F.origin[1] > 7360) {
      scripts\cp\cp_checkpoint::checkpoint_set("boss1_fil_tripwire");
      return;
    }

    wait 1;
  }
}

_id_CB0BF566D166218B() {
  clip = spawn("script_model", (7337.5, 14256.5, 428.5));
  clip.angles = (0, 0, 90);
  clip setModel("player128x128x8");
}

_id_07F6C60E532F11BD() {
  level endon("game_ended");
  level waittill("player_near_fil");
  _id_CB0BF566D166218B();
}

_id_1B465BA0AC19079A() {
  _id_9D4B5B34DDF71038();
  wait 3;
  _id_309D9845CA6A6EE8();
  _id_F60869D706D0891D();
}