/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_78547fbb6c0083e0.gsc
***********************************************/

#using_animtree("script_model");

_id_27120F8531805439() {
  level.scr_animtree["trap_platform"] = #animtree;
  level.scr_anim["trap_platform"]["bounce"] = % iw9_cp_raid2_platform_bounce;
  level.scr_anim["trap_platform"]["close"] = % iw9_cp_raid2_platform_close;
  level.scr_anim["trap_platform"]["open"] = % iw9_cp_raid2_platform_open;
  level.scr_animname["trap_platform"]["bounce"] = "iw9_cp_raid2_platform_bounce";
  level.scr_animname["trap_platform"]["close"] = "iw9_cp_raid2_platform_close";
  level.scr_animname["trap_platform"]["open"] = "iw9_cp_raid2_platform_open";
  level.scr_animtree["plyr_platforms"] = #animtree;
  level.scr_anim["plyr_platforms"]["button_press"] = % iw9_cp_raid2_platform_console_press;
  level.scr_animname["plyr_platforms"]["button_press"] = "iw9_cp_raid2_platform_console_press";
  level.scr_eventanim["plyr_platforms"]["button_press"] = "iw9_cp_raid2_platform_console_press";
  level.scr_animtree["platforms_button"] = #animtree;
  level.scr_anim["platforms_button"]["button_press"] = % iw9_cp_raid2_platform_console_press_button;
  level.scr_animname["platforms_button"]["button_press"] = "iw9_cp_raid2_platform_console_press_button";
}

_id_76AC855BC82866DF() {
  level._effect["plat_valve_steam"] = loadfx("vfx/iw8/level/estate/vfx_engine_steam.vfx");
  level._effect["plat_steam_burst"] = loadfx("vfx/iw9/cp/raid/vfx_cp_raid_platform_steam.vfx");
}

_id_E7098BD047B3A491(_id_E4EEE193EE1E0BCB, _id_DC80351380691946, _id_75366546B0A70949) {
  if(!isDefined(level._id_DFADBCCC7AFBB0ED))
    level._id_DFADBCCC7AFBB0ED = [];

  _id_91554E96494CE0A9 = scripts\engine\utility::getStructArray(_id_E4EEE193EE1E0BCB, "script_noteworthy");
  _id_05872FA88974FDAB = [];

  if(!isDefined(_id_DC80351380691946))
    _id_DC80351380691946 = 0;

  if(!isDefined(_id_75366546B0A70949))
    _id_75366546B0A70949 = 0;

  if(getdvarint("dvar_A1E186A8C781EA0F", 0) > 0)
    _id_05872FA88974FDAB[_id_05872FA88974FDAB.size] = _id_18AF78602B67B70C::_id_683F024F53CEE760(_id_91554E96494CE0A9[0], &"CP_TRAP_ROOM/PLATFORM_BTTN_LABEL", "tag_origin", undefined, 64, undefined, "hide");
  else {
    foreach(struct in _id_91554E96494CE0A9)
    _id_05872FA88974FDAB[_id_05872FA88974FDAB.size] = _id_18AF78602B67B70C::_id_683F024F53CEE760(struct, &"CP_TRAP_ROOM/PLATFORM_BTTN_LABEL", "tag_origin", undefined, 64, undefined, "hide");
  }

  if(!isDefined(level._id_DED00690C1DE9E4F))
    level._id_DED00690C1DE9E4F = [];

  level._id_DED00690C1DE9E4F = scripts\engine\utility::array_combine(level._id_DED00690C1DE9E4F, _id_05872FA88974FDAB);
  _id_1D6379293E7DF8A7 = scripts\engine\utility::getStructArray(_id_91554E96494CE0A9[0].target, "targetname");
  _id_6FE700A86C9CD21B = undefined;
  _id_78A2001DD27AA2E0 = undefined;

  foreach(struct in _id_1D6379293E7DF8A7) {
    if(isDefined(struct.script_flag)) {
      _id_78A2001DD27AA2E0 = struct;
      continue;
    }

    _id_6FE700A86C9CD21B = struct;
  }

  if(isDefined(_id_6FE700A86C9CD21B))
    _id_0EEB55724B26A29C(_id_6FE700A86C9CD21B);

  if(isDefined(_id_78A2001DD27AA2E0))
    _id_0EEB55724B26A29C(_id_78A2001DD27AA2E0);

  _id_8A14103FBB7343CE = _id_6FE700A86C9CD21B;

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8() && isDefined(_id_78A2001DD27AA2E0))
    _id_8A14103FBB7343CE = _id_78A2001DD27AA2E0;

  level thread _id_127B4A6D3E18301F(_id_05872FA88974FDAB, _id_8A14103FBB7343CE, _id_DC80351380691946, _id_75366546B0A70949);

  if(getdvarint("dvar_26258AFDDB59CB39", 1) > 0) {
    if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
      level thread _id_BBC5E95CD93A2264();
  }
}

_id_F22A4B8623AEE659(_id_904CDFF7F0F603FC, _id_568CE48C6640891E, _id_DC80351380691946, _id_75366546B0A70949) {
  if(!isDefined(_id_DC80351380691946))
    _id_DC80351380691946 = 0;

  if(!isDefined(_id_75366546B0A70949))
    _id_75366546B0A70949 = 0;

  _id_8A14103FBB7343CE = scripts\engine\utility::getStruct(_id_904CDFF7F0F603FC, "targetname");
  trigger = getEnt(_id_568CE48C6640891E, "script_noteworthy");
  _id_0EEB55724B26A29C(_id_8A14103FBB7343CE);
}

_id_15DE54CD8BAC80B4() {
  level endon("game_ended");
  _id_F8D5F9729E497E4D = getEnt("seq5_start_trigger", "targetname");

  if(!isDefined(_id_F8D5F9729E497E4D)) {
    return;
  }
  _id_484F5447591913C5(_id_F8D5F9729E497E4D);
  _id_16591A48F7D6F223::_id_D3CB8E66A665F324();
  scripts\cp\cp_checkpoint::checkpoint_set("trap_rappel");
  level notify("reached_rappel_checkpoint");

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_2E9261330FBCEC80 = scripts\engine\utility::getStructArray("trap_rappel_spawners", "targetname");
    _id_0AFB7E332AEE4BF2::_id_79DDAC0EF09B8D0F(_id_2E9261330FBCEC80, 0);
  }

  level notify("set_combat_respawning");
  wait 1;
  level._id_CF829458F676A8EF = 1;
}

_id_E16C201CE8526768() {
  level endon("game_ended");
  trigger = getEnt("platform_start_traversal", "targetname");

  if(!isDefined(trigger)) {
    return;
  }
  _id_484F5447591913C5(trigger);
  level notify("set_traversal_respawning");
}

_id_DF73C5B842B650FE() {
  level endon("game_ended");
  _id_F4602F48207975DE = getEnt("seq5_end_trigger", "targetname");

  if(!isDefined(_id_F4602F48207975DE)) {
    return;
  }
  _id_484F5447591913C5(_id_F4602F48207975DE);
  _id_16591A48F7D6F223::_id_D3CB8E66A665F324();
  scripts\cp\cp_checkpoint::checkpoint_set("trap_doubleback");

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_2E9261330FBCEC80 = scripts\engine\utility::getStructArray("trap_platforms_seq4_start", "targetname");
    _id_0AFB7E332AEE4BF2::_id_79DDAC0EF09B8D0F(_id_2E9261330FBCEC80, 0);
  }

  scripts\cp\cp_analytics::_id_B6283AC45A607764("trap_rappel");
  level notify("set_traversal_respawning");
}

_id_CDA921070628E761() {
  level endon("game_ended");
  level endon("trap_platforms_done");
  _id_DE4B23FA21436068 = getEnt("dropdown_rooms_start", "targetname");

  if(!isDefined(_id_DE4B23FA21436068)) {
    return;
  }
  _id_484F5447591913C5(_id_DE4B23FA21436068);
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Platform_3");
  scripts\cp\cp_checkpoint::checkpoint_set("trap_oldrooms");
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("trap_oldrooms");

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_2E9261330FBCEC80 = scripts\engine\utility::getStructArray("dropdown_rooms_spawners", "targetname");
    _id_0AFB7E332AEE4BF2::_id_79DDAC0EF09B8D0F(_id_2E9261330FBCEC80, 0);
  }

  level notify("set_combat_respawning");
  level thread _id_A67F832AEA8E6202();
}

_id_7476C41BA9781C78() {
  level endon("game_ended");
  _id_904FAD8D093CB9DE = getEnt("jjee_trigger", "targetname");
  _id_0EA4DFDF20CF04AD = scripts\engine\utility::getStruct("jjee_left", "script_noteworthy");
  _id_1BF23593924FCF1C = scripts\engine\utility::getStruct("jjee_mid", "script_noteworthy");
  _id_3CBEAF54C466DB8C = scripts\engine\utility::getStruct("jjee_right", "script_noteworthy");
  targets = getEntArray("jjee_fanclip", "script_noteworthy");
  _id_81EEA7693B6D8115 = _id_0EA4DFDF20CF04AD scripts\engine\utility::spawn_tag_origin();
  _id_E572C3457C1807FE = _id_1BF23593924FCF1C scripts\engine\utility::spawn_tag_origin();
  _id_C3E9B9C6BEE06D2E = _id_3CBEAF54C466DB8C scripts\engine\utility::spawn_tag_origin();
  waitframe();
  _id_81EEA7693B6D8115 setModel("mx_decor_ceramic_skull_02");
  _id_E572C3457C1807FE setModel("p7_skulls_bones_head_01");
  _id_C3E9B9C6BEE06D2E setModel("mx_decor_ceramic_skull_01");
  waitframe();
  _id_81EEA7693B6D8115 hide();
  _id_E572C3457C1807FE hide();
  _id_C3E9B9C6BEE06D2E hide();
  level thread _id_FD0B278414232175(_id_81EEA7693B6D8115, _id_E572C3457C1807FE, _id_C3E9B9C6BEE06D2E, targets, _id_904FAD8D093CB9DE);
  level thread _id_4932FC5F529CDA20(_id_81EEA7693B6D8115, _id_E572C3457C1807FE, _id_C3E9B9C6BEE06D2E, targets, _id_904FAD8D093CB9DE);
}

_id_FD0B278414232175(_id_81EEA7693B6D8115, _id_E572C3457C1807FE, _id_C3E9B9C6BEE06D2E, targets, trigger) {
  level endon("game_ended");
  level endon("cleanup_skull_ee");

  foreach(target in targets)
  target thread _id_9A21749B02528685(trigger);

  while(targets.size) {
    foreach(_id_E9B06E032AC9E578 in targets) {
      if(istrue(_id_E9B06E032AC9E578._id_15B76464BF29AD22))
        targets = targets scripts\engine\utility::array_remove(targets, _id_E9B06E032AC9E578);
    }

    waitframe();
  }

  wait 1;
  level thread _id_95EA6223EBF23115(_id_81EEA7693B6D8115, _id_E572C3457C1807FE, _id_C3E9B9C6BEE06D2E);
}

_id_95EA6223EBF23115(_id_81EEA7693B6D8115, _id_E572C3457C1807FE, _id_C3E9B9C6BEE06D2E) {
  level endon("game_ended");
  level endon("cleanup_skull_ee");
  _id_81EEA7693B6D8115 show();
  _id_E572C3457C1807FE show();
  _id_C3E9B9C6BEE06D2E show();
  models = ["p7_skulls_bones_head_01", "p7_skulls_bones_head_02"];
  _id_448456F634611AAF = 0;

  for(;;) {
    _id_E572C3457C1807FE setModel(models[_id_448456F634611AAF]);
    _id_448456F634611AAF = scripts\engine\utility::ter_op(_id_448456F634611AAF == 0, 1, 0);
    wait 0.5;
  }
}

_id_4932FC5F529CDA20(_id_81EEA7693B6D8115, _id_E572C3457C1807FE, _id_C3E9B9C6BEE06D2E, targets, trigger) {
  level endon("game_ended");
  level scripts\engine\utility::waittill_any_2("trap_platforms_done", "reached_rappel_checkpoint");
  level notify("cleanup_skull_ee");
  wait 1;

  foreach(_id_E9B06E032AC9E578 in targets)
  _id_E9B06E032AC9E578 delete();

  trigger delete();
  _id_81EEA7693B6D8115 delete();
  _id_E572C3457C1807FE delete();
  _id_C3E9B9C6BEE06D2E delete();
}

_id_9A21749B02528685(trigger) {
  level endon("game_ended");
  level endon("cleanup_skull_ee");
  self endon("death");
  self._id_15B76464BF29AD22 = 0;
  self setCanDamage(1);
  self.health = 1000;

  for(;;) {
    self waittill("damage", idamage, attacker);

    if(isPlayer(attacker) && attacker istouching(trigger)) {
      self._id_15B76464BF29AD22 = 1;
      return;
    }
  }
}

_id_2BA5B97B6AA3DCCC() {
  _id_11A06898445637E9 = scripts\engine\utility::getStruct("topdoor_marker", "script_noteworthy");
  _id_869D699197F920A2 = "scriptable_scriptable_door_industrial_metal_mp_01";
  _id_11A06898445637E9._id_98FA2809E21FF34F = getentitylessscriptablearray(_id_869D699197F920A2, "classname", _id_11A06898445637E9.origin, 256);
  _id_3CD37A3CC963DCB5 = scripts\engine\utility::getStruct(_id_11A06898445637E9.target, "targetname");
  _id_11A06898445637E9._id_6D1A5CCE364B4DA4 = spawn("script_model", _id_3CD37A3CC963DCB5.origin);
  _id_11A06898445637E9._id_6D1A5CCE364B4DA4.angles = _id_3CD37A3CC963DCB5.angles;
  _id_11A06898445637E9._id_6D1A5CCE364B4DA4 setModel("electronics_punch_card_slot");
  _id_11A06898445637E9._id_154B94C141D829C8 = [];
  _id_11A06898445637E9._id_4B5C333569939235 = ["interactable_note_keycard_a", "interactable_note_keycard_b", "interactable_note_keycard_c"];

  if(!isDefined(level._id_1D5D2BEFAB232D94))
    level._id_1D5D2BEFAB232D94 = _id_11A06898445637E9;

  foreach(_id_CED0426E7E729ED5 in scripts\engine\utility::getStructArray(_id_3CD37A3CC963DCB5.target, "targetname")) {
    light = spawn("script_model", _id_CED0426E7E729ED5.origin);
    light setModel("flk_computer_light_01_off");
    light.angles = _id_CED0426E7E729ED5.angles;
    light._id_1E92D8D3755A9FF8 = _id_11A06898445637E9;
    _id_11A06898445637E9._id_154B94C141D829C8[_id_11A06898445637E9._id_154B94C141D829C8.size] = light;
  }

  _id_11A06898445637E9 thread _id_D7788A399098B5D8(_id_11A06898445637E9, _id_11A06898445637E9._id_6D1A5CCE364B4DA4);

  foreach(door in _id_11A06898445637E9._id_98FA2809E21FF34F)
  door scriptabledoorfreeze(1);

  _id_11A06898445637E9 thread _id_103A6FD0ADFBEFD7(_id_11A06898445637E9);
}

_id_D7788A399098B5D8(_id_11A06898445637E9, _id_6D1A5CCE364B4DA4) {
  level endon("game_ended");
  level endon("cleanup_platform_ents_started");
  _id_6D1A5CCE364B4DA4 makeusable();
  _id_6D1A5CCE364B4DA4 setHintString(&"CP_TRAP_ROOM/SLIDE_KEY");
  _id_6D1A5CCE364B4DA4 setCursorHint("HINT_BUTTON");
  _id_6D1A5CCE364B4DA4 sethintdisplayrange(90);
  _id_6D1A5CCE364B4DA4 sethintdisplayfov(60);
  _id_6D1A5CCE364B4DA4 setuserange(72);
  _id_6D1A5CCE364B4DA4 setusefov(60);
  _id_6D1A5CCE364B4DA4 sethintonobstruction("show");
  _id_6D1A5CCE364B4DA4 setuseholdduration("duration_short");

  for(;;) {
    _id_6D1A5CCE364B4DA4 _meth_DFB78B3E724AD620(1);
    _id_6D1A5CCE364B4DA4 waittill("trigger", player);
    _id_6D1A5CCE364B4DA4 _meth_DFB78B3E724AD620(0);

    if(!isPlayer(player)) {
      waitframe();
      continue;
    }

    keycard = _id_1378F1533E0BCFB9(player);
    level notify("tried_insert_keycard", _id_11A06898445637E9, player, keycard);

    if(!isDefined(keycard) || !scripts\engine\utility::array_contains(_id_11A06898445637E9._id_4B5C333569939235, keycard)) {
      player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_TRAP_ROOM/NO_KEYCARD", 2);
      continue;
    }

    if(scripts\engine\utility::array_contains(_id_11A06898445637E9._id_4B5C333569939235, keycard)) {
      _id_74388EE4E616B80B = _id_66122A002AFF5D57::_id_F8D85C542911E3A9(player, keycard);
      player _id_531CB1BE084314F7::_id_DB1DD76061352E5B(_id_74388EE4E616B80B, 1);
      _id_11A06898445637E9._id_4B5C333569939235 = scripts\engine\utility::array_remove(_id_11A06898445637E9._id_4B5C333569939235, keycard);
      player thread scripts\cp\utility::playerplaypickupanim("iw9_ges_pickup");
      player playlocalsound("cp_raid2_keycard_swipe");
      playsoundatpos((-4988, 2849, 208), "cp_raid2_keycard_swipe_beep");

      foreach(light in _id_11A06898445637E9._id_154B94C141D829C8) {
        if(!istrue(light._id_AD6DDF92F633C1AA)) {
          light setModel("flk_computer_light_01");
          light._id_AD6DDF92F633C1AA = 1;
          break;
        }
      }

      if(_id_11A06898445637E9._id_4B5C333569939235.size <= 0)
        return;
    }
  }
}

_id_1378F1533E0BCFB9(player) {
  _id_4D56A5BE03B9585F = ["interactable_note_keycard_a", "interactable_note_keycard_b", "interactable_note_keycard_c"];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4D56A5BE03B9585F.size; _id_AC0E594AC96AA3A8++) {
    _id_0906B7B454F9A66D = _id_66122A002AFF5D57::_id_C01EB7D2911F26E1(player, _id_4D56A5BE03B9585F[_id_AC0E594AC96AA3A8]);

    if(_id_0906B7B454F9A66D > 0)
      return _id_4D56A5BE03B9585F[_id_AC0E594AC96AA3A8];
  }

  return undefined;
}

_id_103A6FD0ADFBEFD7(_id_11A06898445637E9) {
  level endon("game_ended");
  level endon("cleanup_platform_ents_started");
  _id_11A06898445637E9 endon("key_destroyed");

  while(_id_11A06898445637E9._id_4B5C333569939235.size > 0)
    wait 1;

  level thread _id_16591A48F7D6F223::_id_B53A1C085C4BC72F();

  foreach(door in _id_11A06898445637E9._id_98FA2809E21FF34F) {
    door scriptabledoorfreeze(0);
    playsoundatpos((-4988, 2849, 208), "cp_raid2_keycard_door_unlocked_beep");
    wait 1.0;
    door scriptabledooropen("away", _id_11A06898445637E9.origin);
    playsoundatpos((-5023, 2850, 208), "cp_raid2_keycard_door_unlocked");
  }

  level notify("top_door_opened");
}

_id_CA921D0DC407EAE1() {
  _id_03C979AE13961613 = scripts\engine\utility::getStructArray("platform_seq_1", "script_noteworthy")[0];
  _id_03C97AAE13961846 = scripts\engine\utility::getStructArray("platform_seq_2", "script_noteworthy")[0];
  _id_03C97BAE13961A79 = scripts\engine\utility::getStructArray("platform_seq_4", "script_noteworthy")[0];
  _id_53A7D294EED8DF9D = [_id_03C979AE13961613, _id_03C97AAE13961846, _id_03C97BAE13961A79];

  foreach(button in _id_53A7D294EED8DF9D) {
    _id_706EC6FDF0F00BF4 = scripts\engine\utility::getStructArray(button.target, "targetname");

    foreach(_id_D0DE0DB1760B9C5B in _id_706EC6FDF0F00BF4) {
      _id_FE5C6FBAA476EE63 = _id_D0DE0DB1760B9C5B;

      while(isDefined(_id_FE5C6FBAA476EE63)) {
        _id_9F47A62C5355EDDF = getEntArray(_id_FE5C6FBAA476EE63.script_parameters, "script_noteworthy");

        foreach(_id_36C12D04A03471D6 in _id_9F47A62C5355EDDF) {
          prop = getEnt(_id_36C12D04A03471D6.script_noteworthy + "_prop", "script_noteworthy");

          if(isDefined(prop))
            prop delete();

          _id_36C12D04A03471D6 delete();
        }

        if(!isDefined(_id_FE5C6FBAA476EE63.target)) {
          _id_FE5C6FBAA476EE63 = undefined;
          continue;
        }

        _id_FE5C6FBAA476EE63 = scripts\engine\utility::getStruct(_id_FE5C6FBAA476EE63.target, "targetname");
      }
    }
  }
}

_id_0EEB55724B26A29C(_id_8A14103FBB7343CE) {
  _id_72A9BA770FBEA73B = [];

  for(_id_FE5C6FBAA476EE63 = _id_8A14103FBB7343CE; isDefined(_id_FE5C6FBAA476EE63); _id_FE5C6FBAA476EE63 = scripts\engine\utility::getStruct(_id_FE5C6FBAA476EE63.target, "targetname")) {
    _id_FE5C6FBAA476EE63._id_8A14103FBB7343CE = _id_8A14103FBB7343CE;
    _id_9F47A62C5355EDDF = getEntArray(_id_FE5C6FBAA476EE63.script_parameters, "script_noteworthy");

    foreach(_id_36C12D04A03471D6 in _id_9F47A62C5355EDDF) {
      _id_36C12D04A03471D6.originalpos = _id_36C12D04A03471D6.origin;
      _id_36C12D04A03471D6._id_3627F3C8C6351D4D = _id_36C12D04A03471D6.origin - (0, 530, 0);
      _id_36C12D04A03471D6._id_1F0FBE7770E2E902 = _id_FE5C6FBAA476EE63;
      _id_36C12D04A03471D6 _meth_3E71A76B50A93E05("movingplatform_noairtrack");
      _id_36C12D04A03471D6.prop = getEnt(_id_36C12D04A03471D6.script_noteworthy + "_prop", "script_noteworthy");

      if(isDefined(_id_36C12D04A03471D6.prop)) {
        _id_36C12D04A03471D6.prop.actor = scripts\cp_mp\anim_scene::anim_scene_create_actor(_id_36C12D04A03471D6.prop, "trap_platform");
        _id_36C12D04A03471D6.prop.actor scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
        _id_36C12D04A03471D6.animnode = spawnStruct();
        _id_36C12D04A03471D6.animnode.origin = _id_36C12D04A03471D6.prop.origin;
        _id_36C12D04A03471D6.animnode.angles = _id_36C12D04A03471D6.prop.angles;
      }

      level thread drop_platform(_id_36C12D04A03471D6);
      _id_4E0CA54DF792B59D = 2637;
      _id_36C12D04A03471D6.fxent = undefined;

      if(_id_36C12D04A03471D6.origin[1] > _id_4E0CA54DF792B59D)
        _id_36C12D04A03471D6.fxent = scripts\engine\utility::spawn_tag_origin(_id_36C12D04A03471D6.origin - anglestoright(_id_36C12D04A03471D6.angles) * 85 - (0, 0, 50), combineangles(_id_36C12D04A03471D6.angles, (0, 0, 90)));
      else
        _id_36C12D04A03471D6.fxent = scripts\engine\utility::spawn_tag_origin(_id_36C12D04A03471D6.origin - anglestoleft(_id_36C12D04A03471D6.angles) * 85 - (0, 0, 50), combineangles(_id_36C12D04A03471D6.angles, (0, 0, 270)));

      _id_36C12D04A03471D6.fxent show();
    }

    if(!isDefined(level._id_DED00690C1DE9E4F))
      level._id_DED00690C1DE9E4F = [];

    level._id_DED00690C1DE9E4F = scripts\engine\utility::array_combine(level._id_DED00690C1DE9E4F, _id_9F47A62C5355EDDF);

    if(!isDefined(_id_FE5C6FBAA476EE63.target))
      return;
  }
}

_id_1712CB3601180C47(group) {
  group_name = group.group_name;
  return scripts\engine\utility::getStructArray(group_name, "targetname").size;
}

_id_4B739B17FDBBD005(group) {
  group_name = group.group_name;
  return scripts\engine\utility::getStructArray(group_name, "targetname");
}

_id_127B4A6D3E18301F(_id_0A67C97EB982F346, _id_8A14103FBB7343CE, _id_DC80351380691946, _id_75366546B0A70949) {
  level endon("game_ended");
  level endon("cleanup_platform_ents_started");

  foreach(button in _id_0A67C97EB982F346)
  button _id_A378250906B2A46F(button);

  wait 1;
  _id_8A14103FBB7343CE._id_1FD50ACFB5CC30E0 = 0;
  _id_8A14103FBB7343CE._id_7E2204E8F7DEB9B4 = 0;
  thread _id_7E10F22C3A31CA4F(_id_0A67C97EB982F346, _id_8A14103FBB7343CE);

  for(;;) {
    _id_8149B383CC1BCD52 = 1;

    foreach(button in _id_0A67C97EB982F346) {
      if(button.state != "on")
        _id_8149B383CC1BCD52 = 0;
    }

    if(!istrue(_id_8149B383CC1BCD52)) {
      waitframe();
      continue;
    } else {
      if(!istrue(_id_8A14103FBB7343CE._id_7E2204E8F7DEB9B4)) {
        foreach(button in _id_0A67C97EB982F346)
        _id_D69F9916F99BFCC4(button);

        _id_C27DCF8E233DD90D = scripts\cp\utility::get_average_origin(_id_0A67C97EB982F346);
        thread _id_DC4199935BBFE355(_id_C27DCF8E233DD90D);
        thread _id_C8E49BB94C6E35F5(_id_8A14103FBB7343CE, _id_DC80351380691946, _id_75366546B0A70949);
        thread _id_28B5DB6676F7D5E5(_id_C27DCF8E233DD90D, _id_8A14103FBB7343CE);
        wait 1;

        foreach(button in _id_0A67C97EB982F346)
        _id_A378250906B2A46F(button);
      } else {
        thread _id_75551B1A5F799D4F(_id_8A14103FBB7343CE);
        wait 1;
      }

      if(istrue(_id_75366546B0A70949)) {
        return;
      }
      wait 1;
    }

    wait 1;
  }
}

_id_28B5DB6676F7D5E5(location, _id_8A14103FBB7343CE) {
  level endon("game_ended");
  level waittill("begin_platform_reset_sounds");
  playsoundatpos(location, "cp_raid2_console_reset_beep");
  playsoundatpos((-4568, 2519, -1933), "cp_raid2_platform_console_relay");
}

_id_DC4199935BBFE355(location) {
  thread scripts\engine\utility::play_sound_in_space("cp_raid2_console_activated_beep", location);
}

_id_B6E934E86125D088(_id_8A14103FBB7343CE, trigger, _id_DC80351380691946, _id_75366546B0A70949) {
  level endon("game_ended");

  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    thread _id_C8E49BB94C6E35F5(_id_8A14103FBB7343CE, _id_DC80351380691946, _id_75366546B0A70949);

    if(istrue(_id_75366546B0A70949)) {
      return;
    }
    _id_8A14103FBB7343CE waittill("sequence_finished");
    wait 1;
  }
}

_id_A378250906B2A46F(button) {
  button thread _id_3BAEC3A9718C555A(button);
}

_id_D69F9916F99BFCC4(button) {
  button notify("disable_button");
  button.state = "off";
  button _meth_DFB78B3E724AD620(0);
}

_id_3BAEC3A9718C555A(button) {
  level endon("game_ended");
  button endon("disable_button");
  button endon("death");
  button.state = "off";

  for(;;) {
    button _meth_DFB78B3E724AD620(1);
    button waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    button _meth_DFB78B3E724AD620(0);
    thread _id_24704C8379CDA365(button, player);
    wait 1.5;
    button.state = "on";
    thread scripts\engine\utility::play_sound_in_space("cp_raid2_console_button_beep", button.origin);
    wait 1;
    button notify("stop_light");
    button.state = "off";
  }
}

_id_24704C8379CDA365(button, player) {
  model = scripts\engine\utility::getclosest(button.origin, getEntArray("trap_platforms_button", "script_noteworthy"));
  animnode = scripts\engine\utility::getStruct(model.target, "targetname");
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "plyr_platforms", 1);
  _id_54E38BC53ABC8A5E = scripts\cp_mp\anim_scene::anim_scene_create_actor(model, "platforms_button");
  player _id_3B64EB40368C1450::set("platforms_button", "damage", 0);
  playsoundatpos(player.origin, "cp_raid2_platform_console_fly");
  model playSound("cp_raid2_platform_console_button");
  animnode scripts\cp_mp\anim_scene::anim_scene([actorplayer, _id_54E38BC53ABC8A5E], "button_press", 1, 1);
  player _id_3B64EB40368C1450::_id_462E6336A0DC84A8("platforms_button", "damage");
}

_id_9A1D658CF210D131(button) {
  level endon("game_ended");
  _id_9AF72BBDFDEACE5D = spawn("script_model", button.origin + (0, 0, 5));
  _id_9AF72BBDFDEACE5D setModel("tag_origin");
  _id_9AF72BBDFDEACE5D.angles = scripts\engine\utility::ter_op(isDefined(button.angles), button.angles, (0, 0, 0));
  waitframe();
  waitframe();
  playFXOnTag(level._effect["red_light"], _id_9AF72BBDFDEACE5D, "tag_origin");
  button scripts\engine\utility::waittill_any_timeout_2(2, "stop_light", "disable_button");
  _id_9AF72BBDFDEACE5D delete();
}

_id_75F9350BF3E24D36(player, time) {
  level endon("game_ended");
  anchor = scripts\engine\utility::spawn_tag_origin(player.origin, player.angles);
  player playerlinktodelta(anchor);
  wait(time);
  player unlink();
  anchor delete();
}

_id_7E10F22C3A31CA4F(_id_0A67C97EB982F346, _id_8A14103FBB7343CE) {
  level endon("game_ended");

  for(;;) {
    _id_8A14103FBB7343CE waittill("sequence_started");

    foreach(button in _id_0A67C97EB982F346)
    button setHintString(&"CP_TRAP_ROOM/PLATFORM_BTTN_ABORT");

    _id_8A14103FBB7343CE waittill("sequence_finished");
    wait 1;

    foreach(button in _id_0A67C97EB982F346)
    button setHintString(&"CP_TRAP_ROOM/PLATFORM_BTTN_LABEL");
  }
}

_id_AFE0A4A5D5864B88(_id_05CE5B54E58D14C5, time) {
  level endon("game_ended");
  _id_05CE5B54E58D14C5 notify("single_turn_func");
  _id_05CE5B54E58D14C5 endon("single_turn_func");
  direction = 90;
  _id_8BA00A9961749D4E = 0;
  _id_D7AC0F922E33598E = undefined;

  if(_id_05CE5B54E58D14C5.state == "on") {
    _id_8BA00A9961749D4E = 1;
    direction = -90;
  }

  total_time = 0;
  _id_6E600E386787EE6A = time;
  _id_DB4E1E3F687838C8 = 10;
  direction = direction / _id_DB4E1E3F687838C8;
  _id_D6B998AD04A6225F = _id_6E600E386787EE6A / _id_DB4E1E3F687838C8;

  if(istrue(_id_8BA00A9961749D4E))
    _id_05CE5B54E58D14C5 thread _id_17B8A4904B5CF5C9(_id_05CE5B54E58D14C5);

  while(total_time < _id_6E600E386787EE6A) {
    _id_3798629785A66F97 = combineangles(_id_05CE5B54E58D14C5.angles, (0, direction, 0));
    self rotateTo(_id_3798629785A66F97, _id_D6B998AD04A6225F);
    self waittill("rotatedone");
    total_time = total_time + _id_D6B998AD04A6225F;
  }
}

_id_17B8A4904B5CF5C9(_id_05CE5B54E58D14C5) {
  level endon("game_ended");
  _id_9C6AA07AF2BF7BEC = spawnfx(level._effect["plat_valve_steam"], _id_05CE5B54E58D14C5.origin, anglesToForward(_id_05CE5B54E58D14C5.angles + (0, 270, 0)), anglestoup(_id_05CE5B54E58D14C5.angles) + (0, 270, 0));
  _id_05CE5B54E58D14C5 scripts\engine\utility::waittill_any_timeout_1(5, "stop_steam_vfx");
  _id_9C6AA07AF2BF7BEC delete();
}

_id_75551B1A5F799D4F(_id_8A14103FBB7343CE) {
  level endon("game_ended");
  _id_8A14103FBB7343CE._id_1FD50ACFB5CC30E0 = 1;
  _id_FE5C6FBAA476EE63 = _id_8A14103FBB7343CE;
  _id_8A14103FBB7343CE notify("cancel_plat_seq");
  level notify("cancel_plat_seq");
  wait 1;

  while(isDefined(_id_FE5C6FBAA476EE63)) {
    _id_9F47A62C5355EDDF = getEntArray(_id_FE5C6FBAA476EE63.script_parameters, "script_noteworthy");

    foreach(_id_36C12D04A03471D6 in _id_9F47A62C5355EDDF)
    level thread drop_platform(_id_36C12D04A03471D6);

    if(!isDefined(_id_FE5C6FBAA476EE63.target)) {
      break;
    }

    _id_FE5C6FBAA476EE63 = scripts\engine\utility::getStruct(_id_FE5C6FBAA476EE63.target, "targetname");
  }
}

_id_C8E49BB94C6E35F5(_id_8A14103FBB7343CE, _id_DC80351380691946, _id_75366546B0A70949) {
  level endon("game_ended");
  _id_2AFA6DE9C444E2AD = "";
  _id_7B274E1EE9F56DAB = -1;

  if(isDefined(_id_8A14103FBB7343CE.script_parameters)) {
    if(!isDefined(level._id_BF8CEEF754A1829B)) {
      scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Platforms");
      level._id_BF8CEEF754A1829B = 1;
    }

    _id_F077ADF688122C36 = strtok(_id_8A14103FBB7343CE.script_parameters, "_");

    if(scripts\engine\utility::string_starts_with(_id_F077ADF688122C36[0], "seq") && !isDefined(_id_8A14103FBB7343CE._id_21E140B4AAAF4563)) {
      switch (_id_F077ADF688122C36[0]) {
        case "seq1":
          _id_8A14103FBB7343CE._id_21E140B4AAAF4563 = "Platform_1";
          break;
        case "seq2":
          scripts\cp\cp_analytics::_id_B6283AC45A607764("Platform_1");
          _id_8A14103FBB7343CE._id_21E140B4AAAF4563 = "Platform_2";
          break;
        case "seq4":
          scripts\cp\cp_analytics::_id_B6283AC45A607764("Platform_2");
          _id_8A14103FBB7343CE._id_21E140B4AAAF4563 = "Platform_3";
          break;
      }
    }

    if(scripts\engine\utility::string_starts_with(_id_F077ADF688122C36[0], "seq") && _id_7B274E1EE9F56DAB == -1) {
      switch (_id_F077ADF688122C36[0]) {
        case "seq1":
          _id_7B274E1EE9F56DAB = 0;
          break;
        case "seq2":
          _id_7B274E1EE9F56DAB = 1;
          break;
        case "seq4":
          _id_7B274E1EE9F56DAB = 2;
          break;
      }
    }

    if(!isDefined(level._id_DFADBCCC7AFBB0ED[_id_8A14103FBB7343CE.script_parameters])) {
      level._id_DFADBCCC7AFBB0ED[_id_8A14103FBB7343CE.script_parameters] = 1;
      _id_2AFA6DE9C444E2AD = level._id_DFADBCCC7AFBB0ED[_id_8A14103FBB7343CE.script_parameters];
      scripts\cp\cp_analytics::_id_0AE955CCDEF747B0(_id_8A14103FBB7343CE._id_21E140B4AAAF4563);
      scripts\cp\cp_analytics::_id_0AE955CCDEF747B0(_id_8A14103FBB7343CE._id_21E140B4AAAF4563 + " | Attempt #" + _id_2AFA6DE9C444E2AD);
    } else {
      _id_2AFA6DE9C444E2AD = level._id_DFADBCCC7AFBB0ED[_id_8A14103FBB7343CE.script_parameters];

      if(_id_2AFA6DE9C444E2AD > 0)
        scripts\cp\cp_analytics::_id_B6283AC45A607764(_id_8A14103FBB7343CE._id_21E140B4AAAF4563 + " | Attempt #" + _id_2AFA6DE9C444E2AD, "Failed");

      level._id_DFADBCCC7AFBB0ED[_id_8A14103FBB7343CE.script_parameters]++;
      _id_2AFA6DE9C444E2AD = level._id_DFADBCCC7AFBB0ED[_id_8A14103FBB7343CE.script_parameters];
      scripts\cp\cp_analytics::_id_0AE955CCDEF747B0(_id_8A14103FBB7343CE._id_21E140B4AAAF4563 + " | Attempt #" + _id_2AFA6DE9C444E2AD);
    }
  }

  _id_8A14103FBB7343CE._id_7E2204E8F7DEB9B4 = 1;
  _id_72A9BA770FBEA73B = [];
  _id_FE5C6FBAA476EE63 = _id_8A14103FBB7343CE;
  _id_72A9BA770FBEA73B[0] = _id_8A14103FBB7343CE;
  _id_8A14103FBB7343CE notify("sequence_started");
  scripts\engine\utility::flag_set("platform_sequence_active");

  if(_id_7B274E1EE9F56DAB >= 0 && _id_7B274E1EE9F56DAB < 3)
    _id_4259EF11E5397D26::_id_EA1AB6036EC27A06(2, _id_7B274E1EE9F56DAB);

  while(isDefined(_id_FE5C6FBAA476EE63.target)) {
    _id_FE5C6FBAA476EE63 = scripts\engine\utility::getStruct(_id_FE5C6FBAA476EE63.target, "targetname");
    _id_72A9BA770FBEA73B[_id_72A9BA770FBEA73B.size] = _id_FE5C6FBAA476EE63;
  }

  endtime = 0;

  foreach(_id_D0DE0DB1760B9C5B in _id_72A9BA770FBEA73B) {
    _id_CD0365396136B83A = strtok(_id_D0DE0DB1760B9C5B.script_noteworthy, ",");
    starttime = gettime() + float(_id_CD0365396136B83A[0]) * 1000;
    endtime = gettime() + float(_id_CD0365396136B83A[1]) * 1000;
    _id_D0DE0DB1760B9C5B thread _id_2437F4494AB26369(_id_D0DE0DB1760B9C5B, starttime, endtime, _id_DC80351380691946, _id_75366546B0A70949);
  }

  while(gettime() < endtime && !istrue(_id_8A14103FBB7343CE._id_1FD50ACFB5CC30E0))
    waitframe();

  if(istrue(_id_8A14103FBB7343CE._id_1FD50ACFB5CC30E0))
    wait 2;

  level notify("begin_platform_reset_sounds");
  wait 2.5;
  _id_8A14103FBB7343CE._id_7E2204E8F7DEB9B4 = 0;
  _id_8A14103FBB7343CE._id_1FD50ACFB5CC30E0 = 0;
  _id_8A14103FBB7343CE notify("sequence_finished");
  scripts\engine\utility::flag_clear("platform_sequence_active");

  if(_id_7B274E1EE9F56DAB >= 0 && _id_7B274E1EE9F56DAB < 3) {
    _id_4259EF11E5397D26::_id_EA1AB6036EC27A06(1, _id_7B274E1EE9F56DAB);
    _id_7B274E1EE9F56DAB = -1;
  }
}

_id_2437F4494AB26369(_id_1F0FBE7770E2E902, starttime, endtime, _id_DC80351380691946, _id_75366546B0A70949) {
  level endon("game_ended");
  _id_1F0FBE7770E2E902._id_8A14103FBB7343CE endon("cancel_plat_seq");
  _id_9F47A62C5355EDDF = getEntArray(_id_1F0FBE7770E2E902.script_parameters, "script_noteworthy");

  while(gettime() < starttime)
    wait 0.1;

  foreach(_id_36C12D04A03471D6 in _id_9F47A62C5355EDDF)
  level thread _id_243382DDAB95A22B(_id_36C12D04A03471D6, _id_DC80351380691946);

  if(istrue(_id_75366546B0A70949)) {
    return;
  }
  while(gettime() < endtime)
    wait 0.1;

  foreach(_id_36C12D04A03471D6 in _id_9F47A62C5355EDDF)
  level thread drop_platform(_id_36C12D04A03471D6);
}

drop_platform(_id_36C12D04A03471D6) {
  level endon("game_ended");
  _id_36C12D04A03471D6 endon("death");

  if(istrue(_id_36C12D04A03471D6._id_6F310A8311844B69)) {
    return;
  }
  if(isDefined(_id_36C12D04A03471D6.fxent)) {
    stopFXOnTag(level._effect["plat_steam_burst"], _id_36C12D04A03471D6.fxent, "tag_origin");
    _id_36C12D04A03471D6.fxent stoploopsound(_id_36C12D04A03471D6.fxent.soundalias);
    _id_36C12D04A03471D6.fxent playSound("evt_raid2_steam_pipe_off");
  }

  if(isDefined(_id_36C12D04A03471D6.prop))
    _id_36C12D04A03471D6.animnode thread scripts\cp_mp\anim_scene::anim_scene([_id_36C12D04A03471D6.prop.actor], "close", 0, 0);

  _id_36C12D04A03471D6 notify("dropped");
  _id_36C12D04A03471D6 _id_E27F37A5C0088418(_id_36C12D04A03471D6);
  wait 0.1;
  _id_36C12D04A03471D6 notsolid();

  if(!isDefined(_id_36C12D04A03471D6.pivot)) {
    if(isDefined(_id_36C12D04A03471D6._id_1F0FBE7770E2E902)) {
      pivot = scripts\engine\utility::spawn_tag_origin(_id_36C12D04A03471D6._id_1F0FBE7770E2E902.origin, _id_36C12D04A03471D6._id_1F0FBE7770E2E902.angles);
      _id_36C12D04A03471D6.pivot = pivot;
      _id_36C12D04A03471D6 linkTo(pivot);
      _id_36C12D04A03471D6.pivot rotateby((90, 0, 0), 0.2, 0, 0);
    } else
      _id_36C12D04A03471D6 rotateby((90, 0, 0), 0.2, 0, 0);
  } else
    _id_36C12D04A03471D6.pivot rotateby((90, 0, 0), 0.2, 0, 0);

  playsoundatpos(_id_36C12D04A03471D6._id_1F0FBE7770E2E902.origin, "evt_raid2_vent_platform_latch_drop");
  wait 0.2;
  level notify("platform_dropped", _id_36C12D04A03471D6);
  _id_36C12D04A03471D6._id_6F310A8311844B69 = 1;
}

_id_243382DDAB95A22B(_id_36C12D04A03471D6, _id_DC80351380691946) {
  level endon("game_ended");
  _id_36C12D04A03471D6 endon("death");
  _id_36C12D04A03471D6 solid();
  waitframe();

  if(!isDefined(_id_36C12D04A03471D6.pivot)) {
    if(isDefined(_id_36C12D04A03471D6._id_1F0FBE7770E2E902)) {
      pivot = scripts\engine\utility::spawn_tag_origin(_id_36C12D04A03471D6._id_1F0FBE7770E2E902.origin, _id_36C12D04A03471D6._id_1F0FBE7770E2E902.angles);
      _id_36C12D04A03471D6.pivot = pivot;
      _id_36C12D04A03471D6 linkTo(pivot);
      _id_36C12D04A03471D6.pivot rotateby((-90, 0, 0), 1, 0, 0);
    } else
      _id_36C12D04A03471D6 rotateby((-90, 0, 0), 1, 0, 0);
  } else
    _id_36C12D04A03471D6.pivot rotateby((-90, 0, 0), 1, 0, 0);

  playFXOnTag(level._effect["plat_steam_burst"], _id_36C12D04A03471D6.fxent, "tag_origin");

  if(isDefined(_id_36C12D04A03471D6.prop))
    _id_36C12D04A03471D6.animnode thread scripts\cp_mp\anim_scene::anim_scene([_id_36C12D04A03471D6.prop.actor], "open", 0, 0);

  playsoundatpos(_id_36C12D04A03471D6._id_1F0FBE7770E2E902.origin, "evt_raid2_vent_platform_latch_raise");
  wait 1;
  _id_36C12D04A03471D6 notify("raised");
  level notify("platform_raised", _id_36C12D04A03471D6);
  _id_36C12D04A03471D6._id_6F310A8311844B69 = 0;

  if(!istrue(_id_DC80351380691946))
    _id_36C12D04A03471D6 thread _id_3A98AC86B6DC6536(_id_36C12D04A03471D6, 2);
}

_id_3A98AC86B6DC6536(_id_36C12D04A03471D6, _id_50109AF25B2B0AF2) {
  level endon("game_ended");
  _id_36C12D04A03471D6 endon("dropped");

  if(getdvarint("dvar_BDC926A7875D9A88", 0) > 0)
    _id_50109AF25B2B0AF2 = 1;

  _id_CCB2815936684EBD = 0;

  for(;;) {
    _id_59DB5D0F4E3000A7 = [];

    foreach(player in level.players) {
      if(player istouching(_id_36C12D04A03471D6))
        _id_59DB5D0F4E3000A7[_id_59DB5D0F4E3000A7.size] = player;
    }

    if(_id_59DB5D0F4E3000A7.size >= _id_50109AF25B2B0AF2) {
      _id_36C12D04A03471D6 thread drop_platform(_id_36C12D04A03471D6);
      return;
    } else if(_id_59DB5D0F4E3000A7.size) {
      level notify("player_touching_platform", _id_59DB5D0F4E3000A7[0], _id_36C12D04A03471D6);

      if(!_id_CCB2815936684EBD && isDefined(_id_36C12D04A03471D6.prop)) {
        level notify("player_landed_on_platform", _id_59DB5D0F4E3000A7[0], _id_36C12D04A03471D6);
        _id_36C12D04A03471D6.animnode thread scripts\cp_mp\anim_scene::anim_scene([_id_36C12D04A03471D6.prop.actor], "bounce", 0, 0);
        scripts\engine\utility::playsoundonentity("evt_raid2_vent_platform_bounce");
        _id_CCB2815936684EBD = 1;
      }
    } else
      _id_CCB2815936684EBD = 0;

    wait 0.1;
  }
}

_id_34EF69848132E17C() {
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_TRAP_ROOM/PLAT_TUTORIAL", "allies", 2);
}

_id_624AD9AE593E728B(trigger) {
  level endon("game_ended");
  trigger notify("single_kill_trigger_watch");
  trigger endon("single_kill_trigger_watch");

  for(;;) {
    trigger waittill("trigger", player);

    if(isalive(player) && isPlayer(player) && !istrue(player._id_E8B1EF5C0DD25704))
      level thread _id_93C6491FFC9E2C95(player, trigger);

    waitframe();
  }
}

_id_93C6491FFC9E2C95(player, trigger) {
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");
  player thread _id_7D31A4D427AA0986(player);
  waitframe();

  while(player istouching(trigger) && isalive(player)) {
    player.shouldskipdeathsshield = 1;
    player dodamage(player.maxhealth, trigger.origin, trigger, trigger, "MOD_TRIGGER_HURT");
    waitframe();
  }
}

_id_7D31A4D427AA0986(player) {
  level endon("game_ended");
  player endon("disconnect");
  player._id_E8B1EF5C0DD25704 = 1;

  while(isalive(player))
    waitframe();

  if(isDefined(player))
    player._id_E8B1EF5C0DD25704 = 0;
}

_id_484F5447591913C5(trigger) {
  level endon("game_ended");
  level endon("trap_platforms_done");

  for(;;) {
    trigger waittill("trigger", player);

    if(isPlayer(player)) {
      return;
    }
    waitframe();
  }
}

_id_0E12022EA41CB33D(trigger) {
  level endon("game_ended");
  level endon("trap_platforms_done");
  _id_FF58B9504E8E13EE = 0;

  while(!istrue(_id_FF58B9504E8E13EE)) {
    _id_FF58B9504E8E13EE = 1;

    foreach(player in level.players) {
      if(!istrue(player istouching(trigger))) {
        _id_FF58B9504E8E13EE = 0;
        break;
      }
    }

    waitframe();
  }
}

_id_1C8CDFD35FDDBA98() {
  level endon("game_ended");
  level endon("trap_platforms_done");
  wait 3;
  trigger = getEnt("trap_room_start_trigger", "targetname");
  _id_484F5447591913C5(trigger);
  wait 0.5;
  scripts\cp\cp_analytics::_id_B6283AC45A607764("trap_oldrooms");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Platforms");
  level notify("trap_platforms_done");
}

_id_96759DD993A14C8E() {
  level endon("game_ended");
  level endon("trap_platforms_done");
  _id_61C6121347BDB742 = getEnt("trap_platforms_death", "targetname");

  for(;;) {
    _id_61C6121347BDB742 waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    player playlocalsound("cp_raid2_platform_land_death_plr");
    playsoundatpos(player.origin, "cp_raid2_platform_land_death_npc");
    wait(lookupsoundlength("cp_raid2_platform_land_death_npc") / 1000);
  }
}

_id_D1D6DBDCAAC5E94B(_id_16E6F6D462356C04) {
  _id_16E6F6D462356C04 = scripts\engine\utility::_id_53C4C53197386572(_id_16E6F6D462356C04, "platform_player_start");
  _id_89770FE705541944 = scripts\engine\utility::getStructArray(_id_16E6F6D462356C04, "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];

    if(!isDefined(level.player_respawn[_id_AC0E594AC96AA3A8]) || !isDefined(player.respawn_index)) {
      player.respawn_index = _id_AC0E594AC96AA3A8;
      player.shouldskiplaststand = 1;
      level.player_respawn[_id_AC0E594AC96AA3A8] = _id_89770FE705541944[_id_AC0E594AC96AA3A8];
    }
  }
}

_id_04658A84663ABD3E(_id_16E6F6D462356C04) {
  _id_16E6F6D462356C04 = scripts\engine\utility::_id_53C4C53197386572(_id_16E6F6D462356C04, "platform_player_start");
  _id_89770FE705541944 = scripts\engine\utility::getStructArray(_id_16E6F6D462356C04, "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(self == level.players[_id_AC0E594AC96AA3A8]) {
      if(!isDefined(level.player_respawn[_id_AC0E594AC96AA3A8])) {
        self.respawn_index = _id_AC0E594AC96AA3A8;
        self.shouldskiplaststand = 1;
        level.player_respawn[_id_AC0E594AC96AA3A8] = _id_89770FE705541944[_id_AC0E594AC96AA3A8];
      }

      return level.player_respawn[_id_AC0E594AC96AA3A8];
    }
  }
}

_id_F750B6D6971731BD() {
  _id_F42869166D50FBE9 = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(!isDefined(_id_F42869166D50FBE9) || _id_F42869166D50FBE9 == "")
    _id_F42869166D50FBE9 = getDvar("start");

  switch (_id_F42869166D50FBE9) {
    case "trap_platforms":
    default:
      _id_D1D6DBDCAAC5E94B("platform_player_start");
      break;
    case "trap_rappel":
      _id_D1D6DBDCAAC5E94B("trap_rappel_spawners");
      break;
    case "trap_doubleback":
      _id_D1D6DBDCAAC5E94B("trap_doubleback_spawners");
      break;
    case "trap_oldrooms":
      _id_D1D6DBDCAAC5E94B("dropdown_rooms_spawners");
      break;
  }
}

_id_B3E9DBF35E59E979(downed_player) {
  downed_player scripts\cp\utility::store_weapons_status([]);
  downed_player _id_12E2FB553EC1605E::_id_7DA7BD24B280D295(1);

  if(!isDefined(level.player_respawn) || !isDefined(downed_player.respawn_index) || !isDefined(level.player_respawn[downed_player.respawn_index]))
    _id_F750B6D6971731BD();

  _id_E0CBA2B0A5510D09 = level.player_respawn[downed_player.respawn_index];
  downed_player.respawn_forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
  downed_player.respawn_forcespawnangles = downed_player getplayerangles(1);
  downed_player.forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
  downed_player.forcespawnangles = downed_player getplayerangles(1);
  downed_player notify("entered_spectate");
  timer = 5;
  _id_19F0135BD917C05D = getdvarint("dvar_B4B6597A66C1EC75", 0);

  if(_id_19F0135BD917C05D != 0)
    timer = _id_19F0135BD917C05D;

  wait(timer);

  if(isDefined(downed_player.br_ammo)) {
    foreach(key, value in downed_player.br_ammo)
    downed_player.br_ammo[key] = 0;
  }

  downed_player.respawn_forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
  downed_player.respawn_forcespawnangles = downed_player getplayerangles(1);
  downed_player.forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
  downed_player.forcespawnangles = downed_player getplayerangles(1);
  downed_player _id_0AFB7E332AEE4BF2::instant_revive(downed_player);
  downed_player notify("last_stand_finished");
  downed_player thread _id_68F310AD1A6BDB32();
}

_id_68F310AD1A6BDB32() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  wait 1;
  scripts\cp\utility::allow_player_basejumping(0, "post_traversal_respawn");
}

_id_A67F832AEA8E6202() {
  level endon("game_ended");
  wait 5;
  _id_545F22C5072AA991 = level.enter_spectator_func;
  level.enter_spectator_func = ::_id_BD58BEADD511DBC7;
}

_id_BD58BEADD511DBC7(downed_player) {
  downed_player endon("disconnect");
  kill_trigger = getEnt("trap_platforms_death", "targetname");
  _id_4C2A5BC6ECA4173A = downed_player.origin;

  if(ispointinvolume(downed_player.origin, kill_trigger))
    _id_4C2A5BC6ECA4173A = scripts\engine\utility::getStruct("oldrooms_intro_dogtag", "script_noteworthy").origin;

  dogtag = spawn("script_model", _id_4C2A5BC6ECA4173A + (0, 0, 40));
  dogtag _id_0AFB7E332AEE4BF2::_id_C919AFEBF9FE06C4();
  downed_player.respawn_forcespawnorigin = _id_4C2A5BC6ECA4173A;

  if(isDefined(downed_player.angles))
    downed_player.respawn_forcespawnangles = downed_player.angles;
  else
    downed_player.respawn_forcespawnangles = (0, 0, 0);

  downed_player.dogtag = dogtag;
  downed_player.dogtag.owner = downed_player;
  _id_0AFB7E332AEE4BF2::makereviveicon(dogtag, downed_player, (1, 0, 0));
  dogtag thread _id_0AFB7E332AEE4BF2::revivetriggerthink(downed_player.team);
  dogtag thread _id_0AFB7E332AEE4BF2::endreviveonownerdeathordisconnect();
}

_id_71454DEA4D88A38C(_id_642470E1ABC1BBF9) {
  return 0;
}

_id_2E8DF8E07F8231BF(player, damage_data) {
  return 0;
}

_id_1B674D5590FD9605() {
  level._id_7B098327E305F16D = ::_id_2E8DF8E07F8231BF;
  level.modeplayerkilledspawn = ::_id_71454DEA4D88A38C;
  level._id_C121AA6DC74CCE91 = _id_0AFB7E332AEE4BF2::_id_2F75743C7FE59CFC;
  level._id_CAADFDA74F61A3CA = 1;
  _id_89770FE705541944 = scripts\engine\utility::getStructArray("platform_player_start", "script_noteworthy");

  foreach(player in level.players) {
    if(!isDefined(player.respawn_index)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
        if(player == level.players[_id_AC0E594AC96AA3A8]) {
          player.respawn_index = _id_AC0E594AC96AA3A8;
          player.shouldskiplaststand = 1;
          level.player_respawn[_id_AC0E594AC96AA3A8] = _id_89770FE705541944[_id_AC0E594AC96AA3A8];
        }
      }
    }
  }
}

_id_78621CB99BCDFD8A() {
  level._id_CAADFDA74F61A3CA = undefined;
  level.enter_spectator_func = _id_0AFB7E332AEE4BF2::enable_dogtag_revive;
  level.getspawnpoint = _id_0598E0C00C8151F7::getspawnpoint;
  level._id_C121AA6DC74CCE91 = undefined;
  level._id_7B098327E305F16D = undefined;
  level.modeplayerkilledspawn = _id_0AFB7E332AEE4BF2::playerkilledspawn;
  level.all_players_skip_last_stand = 0;
  level.player_respawn = undefined;
  level.coop_gameshouldendfunc = undefined;

  foreach(player in level.players) {
    player.respawn_index = undefined;
    player.shouldskiplaststand = 0;
  }
}

_id_554172C4A78D1389() {
  level endon("game_ended");
  level waittill("breakout_wall_oldrooms_wall_blown");
  _id_16591A48F7D6F223::_id_D3CB8E66A665F324();
}

_id_1D1AB26375E861C0() {
  level notify("cleanup_platform_ents_started");
  level thread _id_554172C4A78D1389();

  if(isDefined(level._id_DED00690C1DE9E4F)) {
    foreach(ent in level._id_DED00690C1DE9E4F) {
      if(isDefined(ent)) {
        if(isDefined(ent.prop))
          ent.prop delete();

        if(isDefined(ent.fxent))
          ent.fxent delete();

        ent delete();
      }
    }
  }

  if(isDefined(level._id_14D12EBE579F0DF8)) {
    foreach(_id_05CE5B54E58D14C5 in level._id_14D12EBE579F0DF8) {
      if(isDefined(_id_05CE5B54E58D14C5._id_3AD974EE99198ECC)) {
        foreach(_id_0C3EA9B1A20FF199 in _id_05CE5B54E58D14C5._id_3AD974EE99198ECC) {
          if(isDefined(_id_0C3EA9B1A20FF199.soundent))
            _id_0C3EA9B1A20FF199.soundent delete();
        }
      }

      if(isDefined(_id_05CE5B54E58D14C5.steam_trigger))
        _id_05CE5B54E58D14C5.steam_trigger delete();

      if(isDefined(_id_05CE5B54E58D14C5.steam_fx_on))
        _id_05CE5B54E58D14C5.steam_fx_on delete();

      if(isDefined(_id_05CE5B54E58D14C5.steam_fx_off))
        _id_05CE5B54E58D14C5.steam_fx_off delete();
    }
  }

  if(isDefined(level._id_1D5D2BEFAB232D94)) {
    if(isDefined(level._id_1D5D2BEFAB232D94._id_154B94C141D829C8)) {
      foreach(light in level._id_1D5D2BEFAB232D94._id_154B94C141D829C8)
      light delete();
    }

    level._id_1D5D2BEFAB232D94._id_6D1A5CCE364B4DA4 delete();
  }

  if(!scripts\engine\utility::flag_exist("any_player_in_trap_room"))
    scripts\engine\utility::flag_init("any_player_in_trap_room");

  scripts\engine\utility::flag_wait("any_player_in_trap_room");

  if(isDefined(level._id_ED9613A1460DC261)) {
    foreach(weapon in level._id_ED9613A1460DC261) {
      if(isDefined(weapon) && !isDefined(weapon.owner))
        weapon delete();
    }
  }
}

_id_70197F8D0EA6E56A() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    scripts\cp\tripwire_cp::init();
    scripts\cp_mp\tripwire::precachetrap("tripwire_trap_frag", "offhand_wm_grenade_mike67", 1);
    wait 0.05;
    scripts\cp_mp\tripwire::init();
    wait 1;

    foreach(_id_801C53C0ED06495B in level.tripwires.tripwires) {
      _id_D5685B7BAEE6505E = _id_801C53C0ED06495B.origin;
      end_pos = _id_801C53C0ED06495B.endpoint;
      _id_265706100D1E0891 = (_id_D5685B7BAEE6505E + end_pos) / 2;
      _id_9AB19B1AD46A040D = length(_id_265706100D1E0891 - _id_D5685B7BAEE6505E);
      _id_DBE4316E115900D3 = createnavbadplacebybounds(_id_265706100D1E0891, (_id_9AB19B1AD46A040D, _id_9AB19B1AD46A040D, 150), _id_801C53C0ED06495B.angles);
      _id_801C53C0ED06495B childthread _id_BE74CB6CB8F7F24A(_id_DBE4316E115900D3);
    }
  }
}

_id_BE74CB6CB8F7F24A(_id_DBE4316E115900D3) {
  self waittill("tripwire_trigger");
  destroynavobstacle(_id_DBE4316E115900D3);
}

_id_67DB0E8A3AABE16E() {
  triggers = getEntArray("steam_trigger", "targetname");

  foreach(trigger in triggers) {
    _id_5D99A225CB875DDA = scripts\engine\utility::getStructArray(trigger.target, "targetname");

    foreach(struct in _id_5D99A225CB875DDA)
    struct thread _id_2E3C207F7651DDEC::steam_point_think();
  }
}

_id_E27F37A5C0088418(_id_36C12D04A03471D6) {
  foreach(player in level.players) {
    if(distance(_id_36C12D04A03471D6.origin, player.origin) <= 100 && player _meth_415FE9EECA7B2E2B())
      player _meth_8CA38A054F432FF2();
  }
}

_id_4653583B764007E6(_id_36C12D04A03471D6) {
  level endon("game_ended");

  foreach(player in level.players) {
    if(isalive(player) && player istouching(_id_36C12D04A03471D6))
      player scripts\engine\utility::delaythread(0.2, ::_id_84D27CD210EA1255);
  }
}

_id_84D27CD210EA1255() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self skydive_interrupt();
  self skydive_setdeploymentstatus(0);
  self skydive_beginfreefall();
}

_id_BBC5E95CD93A2264() {
  level endon("game_ended");

  if(istrue(level._id_BBC5E95CD93A2264)) {
    return;
  }
  level._id_BBC5E95CD93A2264 = 1;
  level thread _id_AAB9318680B8FB4E();
  level thread _id_AAB9328680B8FD81();
  level waittill("trap_platforms_done");
  level thread _id_746B6A89A2EA92F5::_id_8D5E27863A5831E9();
}

_id_AAB9318680B8FB4E() {
  level endon("game_ended");
  level endon("trap_platforms_done");
  level endon("grenade_drone_seq2_stop");

  while(!isDefined(level._id_DFADBCCC7AFBB0ED) || !isDefined(level._id_DFADBCCC7AFBB0ED["seq2_a"]) || level._id_DFADBCCC7AFBB0ED["seq2_a"] == 0)
    wait 1;

  thread _id_79823539CA298145::_id_058CF809FE66F659();
  childthread _id_1725618C5EFB4D8B();

  for(;;) {
    _id_07132F053DB6712D = scripts\engine\utility::getStructArray("drone_grenade_spawn_p1", "targetname");
    _id_60F7CB484EC61F6C = scripts\engine\utility::random(_id_07132F053DB6712D);
    drone = _id_746B6A89A2EA92F5::_id_AE2FF42BCA6D6DCC(_id_60F7CB484EC61F6C);
    drone waittill("death");
    wait 30;
  }
}

_id_1725618C5EFB4D8B() {
  origin = (-5171, 2738, -888);
  dist = 21025;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(origin, dist)) {
      level thread _id_746B6A89A2EA92F5::_id_8D5E27863A5831E9();
      level notify("grenade_drone_seq2_stop");
      return;
    }

    wait 0.5;
  }
}

_id_AAB9328680B8FD81() {
  level endon("game_ended");
  level endon("trap_platforms_done");

  while(!isDefined(level._id_DFADBCCC7AFBB0ED) || !isDefined(level._id_DFADBCCC7AFBB0ED["seq4_a"]) || level._id_DFADBCCC7AFBB0ED["seq4_a"] == 0)
    wait 1;

  thread _id_79823539CA298145::_id_058CF809FE66F659();

  for(;;) {
    _id_07132F053DB6712D = scripts\engine\utility::getStructArray("drone_grenade_spawn_p2", "targetname");
    _id_60F7CB484EC61F6C = scripts\engine\utility::random(_id_07132F053DB6712D);
    drone = _id_746B6A89A2EA92F5::_id_AE2FF42BCA6D6DCC(_id_60F7CB484EC61F6C);
    drone waittill("death");
    wait 30;
  }
}