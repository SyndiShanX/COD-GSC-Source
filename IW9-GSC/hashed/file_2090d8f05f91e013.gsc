/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2090d8f05f91e013.gsc
***********************************************/

_id_B04F37F19C6631E0() {
  level.map_interaction_func = ::register_interactions;
  level.player_interaction_monitor = ::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = ::_id_FE7243424D42CD4B;
  level.interaction_trigger_properties_func = ::interaction_trigger_properties;
}

register_interactions() {
  if(scripts\engine\utility::flag_exist("interactions_initialized"))
    scripts\engine\utility::flag_set("interactions_initialized");
}

_id_FE7243424D42CD4B(_id_DF071553D0996FF9) {
  self notify("interaction_logic_started");
  self endon("interaction_logic_started");
  self endon("stop_interaction_logic");
  self endon("disconnect");

  for(;;) {
    _id_DF071553D0996FF9.triggered = undefined;
    self.interaction_trigger waittill("trigger", player);

    if(!_id_71332A5B74214116::interaction_is_valid(_id_DF071553D0996FF9, player)) {
      continue;
    }
    _id_DF071553D0996FF9.triggered = 1;
    cost = _id_DF071553D0996FF9 _id_71332A5B74214116::interaction_get_cost();

    if(!isDefined(level.interactions[_id_DF071553D0996FF9.script_noteworthy].spend_type))
      level.interactions[_id_DF071553D0996FF9.script_noteworthy].spend_type = "null";

    if(!_id_71332A5B74214116::can_purchase_interaction(_id_DF071553D0996FF9, cost, level.interactions[_id_DF071553D0996FF9.script_noteworthy].spend_type)) {
      level notify("interaction", "purchase_denied", level.interactions[_id_DF071553D0996FF9.script_noteworthy], self);
      thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
      _id_71332A5B74214116::interaction_show_fail_reason(_id_DF071553D0996FF9, &"COOP_INTERACTIONS/NEED_MONEY");
      continue;
    }

    thread _id_71332A5B74214116::interaction_post_activate_delay(_id_DF071553D0996FF9);
    level notify("interaction", "purchase", level.interactions[_id_DF071553D0996FF9.script_noteworthy], self);
    _id_E42F7EB456B932F2 = level.interactions[_id_DF071553D0996FF9.script_noteworthy].spend_type;
    thread _id_71332A5B74214116::take_player_money(cost, _id_E42F7EB456B932F2);
    level thread[[level.interactions[_id_DF071553D0996FF9.script_noteworthy].activation_func]](_id_DF071553D0996FF9, self);
    _id_71332A5B74214116::interaction_post_activate_update(_id_DF071553D0996FF9);
    return;
  }
}

level_specific_player_interaction_monitor() {
  self notify("player_interaction_monitor");
  self endon("player_interaction_monitor");
  self endon("disconnect");
  self endon("death");
  _id_B755813C92F9BD4A = 5184;
  _id_925AB147F36BB977 = 9216;

  for(;;) {
    if(isDefined(level.interactions_disabled)) {
      level waittill("interactions_disabled_toggled");
      continue;
    }

    _id_A00884ED3A6D8B4B = self.origin;
    _id_AC3DC6CF8564E576 = undefined;
    _id_717FB99ADD9A6834 = sortbydistancecullbyradius(level.current_interaction_structs, _id_A00884ED3A6D8B4B, 512);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.disabled_interactions.size; _id_AC0E594AC96AA3A8++)
      _id_717FB99ADD9A6834 = scripts\engine\utility::array_remove(_id_717FB99ADD9A6834, self.disabled_interactions[_id_AC0E594AC96AA3A8]);

    if(_id_717FB99ADD9A6834.size == 0 || istrue(self.delay_hint)) {
      self notify("starting_interaction_search");
      waitframe();
      continue;
    }

    _id_4403360414478511 = _id_717FB99ADD9A6834[0];
    _id_581AED15F31BBE01 = distancesquared(_id_4403360414478511.origin, _id_A00884ED3A6D8B4B);

    if(!isDefined(_id_AC3DC6CF8564E576) && _id_581AED15F31BBE01 <= _id_B755813C92F9BD4A)
      _id_AC3DC6CF8564E576 = _id_4403360414478511;
    else if(!isDefined(_id_AC3DC6CF8564E576) && isDefined(level.should_allow_far_search_dist_func)) {
      if(_id_581AED15F31BBE01 <= _id_925AB147F36BB977)
        _id_AC3DC6CF8564E576 = _id_4403360414478511;

      if(isDefined(_id_AC3DC6CF8564E576) && ![[level.should_allow_far_search_dist_func]](_id_AC3DC6CF8564E576))
        _id_AC3DC6CF8564E576 = undefined;
    } else if(!isDefined(_id_AC3DC6CF8564E576) && isDefined(_id_4403360414478511.custom_search_dist)) {
      if(_id_581AED15F31BBE01 <= _id_4403360414478511.custom_search_dist)
        _id_AC3DC6CF8564E576 = _id_4403360414478511;
    }

    if(!isDefined(_id_AC3DC6CF8564E576) || !scripts\engine\utility::array_contains(level.current_interaction_structs, _id_AC3DC6CF8564E576) || !_id_71332A5B74214116::can_use_interaction(_id_AC3DC6CF8564E576)) {
      _id_71332A5B74214116::reset_interaction();
      continue;
    }

    if(!_id_71332A5B74214116::no_previous_interaction_point() || !_id_71332A5B74214116::interaction_point_has_changed(_id_AC3DC6CF8564E576) && _id_71332A5B74214116::interaction_is_button_mash(_id_AC3DC6CF8564E576) || _id_71332A5B74214116::interaction_point_has_changed(_id_AC3DC6CF8564E576))
      _id_71332A5B74214116::set_interaction_point(_id_AC3DC6CF8564E576);

    waitframe();
  }
}

interaction_trigger_properties(interaction_trigger, _id_DF071553D0996FF9, hintstring) {
  switch (_id_DF071553D0996FF9.script_noteworthy) {
    default:
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);

      if(isDefined(_id_DF071553D0996FF9.useduration))
        self.interaction_trigger setuseholdduration(_id_DF071553D0996FF9.useduration);

      break;
  }
}

_id_7592F5D90FEBE3C0() {
  level endon("game_ended");
  origin = (8300, 11064, 1860);
  model = spawn("script_model", origin);
  model setModel("tag_origin");
  model.angles = (0, 0, 0);
  model makeusable();
  model sethintdisplayrange(70);
  model sethintdisplayfov(60);
  model setuserange(50);
  model setusefov(40);
  model setuseholdduration("duration_short");
  model setCursorHint("HINT_BUTTON");
  model sethintonobstruction("hide");
  model _meth_DFB78B3E724AD620(1);

  for(;;) {
    model waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_RAID1_NUMSPUZZLE/EE_LOCATION", 3);
    wait 3;
    _id_A9706ADAF7C52E27 = (8380, 13400, 2016);
    player setOrigin(_id_A9706ADAF7C52E27);
  }
}

intel_init() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("scriptables_ready");
  wait 5;
  level thread _id_EA458F894D02A6C6();
  level thread _id_6EB471368C10B9B8();
  level thread _id_7592F5D90FEBE3C0();
}

_id_EA458F894D02A6C6() {
  level endon("game_ended");
  _id_F90FD66D8E1FB000 = undefined;

  foreach(_id_104A0214A4EEC589 in level._id_7BED7FD13ABBBC9C) {
    if(_id_104A0214A4EEC589._id_96477DA1695E035B.info == "r1_15") {
      _id_F90FD66D8E1FB000 = _id_104A0214A4EEC589;
      break;
    }
  }

  wait 1;

  for(;;) {
    foreach(player in level.players) {
      if(!istrue(level._id_B640E3525916BD06) && _id_E51798B13C7AFF96() && distance(player.origin, _id_F90FD66D8E1FB000.origin) < 500 && !player scripts\cp\intel\cp_intel::_id_6FB0C700A7AAF634(_id_F90FD66D8E1FB000)) {
        _id_F90FD66D8E1FB000._id_96477DA1695E035B enablescriptablepartplayeruse("intel_interaction", player);
        _id_F90FD66D8E1FB000._id_96477DA1695E035B showtoplayer(player);
      } else {
        _id_F90FD66D8E1FB000._id_96477DA1695E035B disablescriptablepartplayeruse("intel_interaction", player);
        _id_F90FD66D8E1FB000._id_96477DA1695E035B hidefromplayer(player);
      }

      wait 0.05;
    }

    wait 1;
  }
}

_id_E51798B13C7AFF96() {
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint == "")
    return 1;

  return 0;
}

_id_6EB471368C10B9B8() {
  level thread _id_3190DB68A190E478();
  level thread _id_6A54B89678A8F5E5();
  level thread _id_6A54B59678A8EF4C();
}

_id_3190DB68A190E478() {
  level endon("game_ended");
  _id_3369600C42051B24 = undefined;

  foreach(_id_104A0214A4EEC589 in level._id_7BED7FD13ABBBC9C) {
    if(_id_104A0214A4EEC589._id_96477DA1695E035B.info == "r1_16") {
      _id_3369600C42051B24 = _id_104A0214A4EEC589;
      break;
    }
  }

  wait 1;

  for(;;) {
    foreach(player in level.players) {
      if(istrue(level._id_A36A2441915F01DA) && distance(player.origin, _id_3369600C42051B24.origin) < 500 && !player scripts\cp\intel\cp_intel::_id_6FB0C700A7AAF634(_id_3369600C42051B24)) {
        _id_3369600C42051B24._id_96477DA1695E035B enablescriptablepartplayeruse("intel_interaction", player);
        _id_3369600C42051B24._id_96477DA1695E035B showtoplayer(player);
      } else {
        _id_3369600C42051B24._id_96477DA1695E035B disablescriptablepartplayeruse("intel_interaction", player);
        _id_3369600C42051B24._id_96477DA1695E035B hidefromplayer(player);
      }

      wait 0.05;
    }

    wait 1;
  }
}

_id_6A54B89678A8F5E5() {
  struct = scripts\engine\utility::getStruct("intel_race_paper_1", "targetname");
  model = spawn("script_model", struct.origin);
  model setModel("vfx_debris_paper_torn_a_04");
  model.angles = struct.angles;
  model makeusable();
  model sethintdisplayrange(70);
  model sethintdisplayfov(60);
  model setuserange(50);
  model setusefov(40);
  model setuseholdduration("duration_short");
  model setCursorHint("HINT_BUTTON");
  model sethintonobstruction("hide");
  model setHintString(&"CP_RAID1_NUMSPUZZLE/COLLECT_PAPER_1");
  model _meth_DFB78B3E724AD620(1);

  for(;;) {
    model waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    level notify("intel_race_pickup_paper_1");
    player thread scripts\cp\utility::playerplaypickupanim("iw9_ges_pickup");
    wait 0.35;

    if(isPlayer(player))
      player playlocalsound("iw9_br_pickup_key");

    model hide();
    break;
  }

  wait 1;
  model delete();
}

_id_6A54B59678A8EF4C() {
  level endon("game_ended");
  struct = scripts\engine\utility::getStruct("intel_race_paper_2", "targetname");
  model = spawn("script_model", struct.origin + (0, 0, 1));
  model setModel("vfx_debris_paper_torn_a_04");
  model.angles = struct.angles;
  level waittill("intel_race_pickup_paper_1");
  model makeusable();
  model sethintdisplayrange(60);
  model sethintdisplayfov(80);
  model setuserange(50);
  model setusefov(40);
  model setuseholdduration("duration_short");
  model setCursorHint("HINT_BUTTON");
  model sethintonobstruction("hide");
  model setHintString(&"CP_RAID1_NUMSPUZZLE/COLLECT_PAPER_2");
  model _meth_DFB78B3E724AD620(1);
  model thread _id_CF5DB255D2FECE54();
}

_id_CF5DB255D2FECE54() {
  level endon("game_ended");
  level endon("intel_race_win");
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    player playlocalsound("iw9_br_pickup_key");
    break;
  }

  self _meth_DFB78B3E724AD620(0);
  struct = scripts\engine\utility::getStruct("intel_race_paper_3", "targetname");
  _id_A712A5B20BD11ED4 = spawn("script_model", struct.origin + (0, 0, 1));
  _id_A712A5B20BD11ED4 setModel("vfx_debris_paper_torn_a_04");
  _id_A712A5B20BD11ED4.angles = struct.angles;
  wait 1.5;
  model = spawn("script_model", struct.origin + (0, 0, 3));
  model setModel("tag_origin");
  model makeusable();
  model sethintdisplayrange(120);
  model sethintdisplayfov(85);
  model setuserange(50);
  model setusefov(50);
  model setuseholdduration("duration_none");
  model setCursorHint("HINT_BUTTON");
  model sethintonobstruction("hide");
  model setHintString(&"CP_RAID1_NUMSPUZZLE/COLLECT_PAPER_3_0");
  model thread _id_5F405B0504C371EC();

  for(;;) {
    level._id_21C14B8700100B4F = [];
    _id_1256D713C259459F = 3;

    while(level._id_21C14B8700100B4F.size < _id_1256D713C259459F) {
      model waittill("trigger", player);

      if(!isPlayer(player)) {
        continue;
      }
      if(!isDefined(scripts\engine\utility::array_find(level._id_21C14B8700100B4F, player))) {
        player playlocalsound("iw9_br_pickup_key");
        level._id_21C14B8700100B4F = scripts\engine\utility::array_add(level._id_21C14B8700100B4F, player);

        if(level._id_21C14B8700100B4F.size == 1)
          model setHintString(&"CP_RAID1_NUMSPUZZLE/COLLECT_PAPER_3_1");
        else if(level._id_21C14B8700100B4F.size == 2)
          model setHintString(&"CP_RAID1_NUMSPUZZLE/COLLECT_PAPER_3_2");
        else if(level._id_21C14B8700100B4F.size == 3)
          model setHintString(&"CP_RAID1_NUMSPUZZLE/COLLECT_PAPER_3_3");

        level thread _id_55104D392CB06692(model);
      }

      if(level._id_21C14B8700100B4F.size >= _id_1256D713C259459F) {
        break;
      }
    }

    model _meth_DFB78B3E724AD620(0);
    timeout = 120;
    model thread _id_8E8C4C34203E3953(timeout, self, _id_A712A5B20BD11ED4);
    wait(timeout);
    level notify("intel_race_timeout");
    model setHintString(&"CP_RAID1_NUMSPUZZLE/COLLECT_PAPER_3_0");
    model _meth_DFB78B3E724AD620(1);
  }
}

_id_5F405B0504C371EC() {
  level endon("game_ended");
  level endon("intel_race_win");

  for(;;) {
    foreach(player in level.players) {
      if(isDefined(player._id_72F72F6558F6A22A)) {
        if(distance2d(player.origin, self.origin) < 100)
          level thread _id_64DAEE0F8FB17768();
      }
    }

    wait 0.5;
  }
}

_id_64DAEE0F8FB17768() {
  level notify("oxygenmask_pickupEnableTinyFOVForTime");
  level endon("oxygenmask_pickupEnableTinyFOVForTime");

  foreach(player in level.players) {
    if(isDefined(player._id_72F72F6558F6A22A))
      player._id_72F72F6558F6A22A thread _id_AA683253FA1DD4E3(1);
  }

  wait 1;

  foreach(player in level.players) {
    if(isDefined(player._id_72F72F6558F6A22A))
      player._id_72F72F6558F6A22A thread _id_AA683253FA1DD4E3(0);
  }
}

_id_AA683253FA1DD4E3(_id_48B9B837954AE4C4) {
  if(istrue(_id_48B9B837954AE4C4)) {
    self sethintdisplayfov(20);
    self setusefov(19);
  } else {
    self sethintdisplayfov(200);
    self setusefov(190);
  }
}

_id_55104D392CB06692(model) {
  level endon("game_ended");
  level endon("intel_race_dogtags_start");
  level notify("intel_race_dogtags_read_timeout");
  level endon("intel_race_dogtags_read_timeout");
  wait 2;
  level._id_21C14B8700100B4F = [];
  model setHintString(&"CP_RAID1_NUMSPUZZLE/COLLECT_PAPER_3_0");
}

_id_8E8C4C34203E3953(timeout, _id_A712A8B20BD1256D, _id_A712A5B20BD11ED4) {
  level notify("intel_race_dogtags_start");

  foreach(player in level.players)
  player scripts\cp\utility::playsoundtoplayer_safe("ui_iw9_cp_defender_wave_start", player);

  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("intel_race_dogtag", "targetname");
  level._id_93765619E76302EF = [];

  foreach(struct in _id_9E4E1482CB40C9C5)
  level._id_93765619E76302EF[level._id_93765619E76302EF.size] = _id_68390A8CBFD48570(struct);

  level thread _id_45DB56C0C71A4A85(timeout);

  while(level._id_93765619E76302EF.size > 0) {
    level waittill("intel_race_dogtag_touch");

    foreach(dogtag in level._id_93765619E76302EF) {
      if(!isDefined(dogtag))
        level._id_93765619E76302EF = scripts\engine\utility::array_remove(level._id_93765619E76302EF, dogtag);
    }
  }

  level thread _id_A3850441917D1784();
  self delete();
  _id_A712A8B20BD1256D delete();
  _id_A712A5B20BD11ED4 delete();
}

_id_A3850441917D1784() {
  level notify("intel_race_win");
  wait 1;

  foreach(player in level.players) {
    player scripts\cp\utility::playsoundtoplayer_safe("ui_iw9_cp_defender_wave_end", player);
    player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_RAID1_NUMSPUZZLE/INTEL_RACE_WIN", 10);
  }

  level._id_A36A2441915F01DA = 1;
}

_id_45DB56C0C71A4A85(timeout) {
  level endon("game_ended");
  level endon("intel_race_win");

  for(_id_AC0E594AC96AA3A8 = timeout; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
    label = _id_10E6C51B6920DFE7(_id_AC0E594AC96AA3A8);

    foreach(dogtag in level._id_93765619E76302EF) {
      if(isDefined(label))
        objective_setlabel(dogtag.objindex, label);

      foreach(player in level.players) {
        if(_id_AC0E594AC96AA3A8 < 15) {
          player playlocalsound("cp_ui_bomb_timer_urgent");
          continue;
        }

        player playlocalsound("cp_ui_bomb_timer");
      }
    }

    wait 1;
  }

  foreach(dogtag in level._id_93765619E76302EF) {
    _id_DA39E3C415EB014D(dogtag.objindex);
    dogtag.trigger delete();
    dogtag delete();
  }

  foreach(player in level.players)
  player scripts\cp\utility::playsoundtoplayer_safe("ui_iw9_cp_defender_wave_end", player);
}

_id_68390A8CBFD48570(struct) {
  model = spawn("script_model", struct.origin);
  model setModel("military_dogtags_iw9");
  model.angles = struct.angles;
  model hudoutlineenable("outline_depth_white");
  _id_FD610EF5C8A6E2AC = squared(16);
  model thread _id_E3F454371DD85EC0();
  model scriptmodelplayanim("mp_dogtag_spin");
  model.objindex = _id_962234B605DE10D5(struct.origin);
  return model;
}

_id_E3F454371DD85EC0() {
  level endon("game_ended");
  self endon("death");
  self.trigger = spawn("trigger_radius", self.origin, 0, 32, 32);
  self.trigger enablelinkTo();
  self.trigger linkTo(self, "tag_origin");

  for(;;) {
    self.trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    player playlocalsound("iw9_br_pickup_key");
    player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_RAID1_NUMSPUZZLE/LOOT_GET", 3);
    break;
  }

  _id_DA39E3C415EB014D(self.objindex);
  self playSound("mp_killconfirm_tags_pickup");
  _id_18C057F630A76C65 = scripts\engine\utility::array_find(level._id_93765619E76302EF, self);
  scripts\engine\utility::array_remove_index(level._id_93765619E76302EF, _id_18C057F630A76C65);
  level notify("intel_race_dogtag_touch");
  self.trigger delete();
  self delete();
}

_id_962234B605DE10D5(_id_49ECE3D0608350F7) {
  objindex = scripts\cp\cp_objectives::requestworldid("intel_race", 25);
  objective_state(objindex, "current");
  objective_position(objindex, _id_49ECE3D0608350F7);
  objective_icon(objindex, "icon_waypoint_objective_general");
  objective_setminimapiconsize(objindex, "icon_small");
  objective_setshowdistance(objindex, 1);
  objective_setplayintro(objindex, 1);
  objective_sethot(objindex, 0);
  objective_setownerteam(objindex, "axis");
  objective_setlabel(objindex, &"CP_RAID1_NUMSPUZZLE/8");
  return objindex;
}

_id_DA39E3C415EB014D(objindex) {
  objective_delete(objindex);
  scripts\cp\cp_objectives::freeworldidbyobjid(objindex);
}

_id_10E6C51B6920DFE7(number) {
  label = undefined;

  switch (number) {
    case 120:
      label = &"CP_RAID1_NUMSPUZZLE/INTEL_RACE_TIME_120";
      break;
    case 90:
      label = &"CP_RAID1_NUMSPUZZLE/INTEL_RACE_TIME_90";
      break;
    case 60:
      label = &"CP_RAID1_NUMSPUZZLE/INTEL_RACE_TIME_60";
      break;
    case 45:
      label = &"CP_RAID1_NUMSPUZZLE/INTEL_RACE_TIME_45";
      break;
    case 30:
      label = &"CP_RAID1_NUMSPUZZLE/INTEL_RACE_TIME_30";
      break;
    case 15:
      label = &"CP_RAID1_NUMSPUZZLE/INTEL_RACE_TIME_15";
      break;
    case 10:
      label = &"CP_RAID1_NUMSPUZZLE/INTEL_RACE_TIME_10";
      break;
    case 9:
      label = &"CP_RAID1_NUMSPUZZLE/INTEL_RACE_TIME_9";
      break;
    case 8:
      label = &"CP_RAID1_NUMSPUZZLE/INTEL_RACE_TIME_8";
      break;
    case 7:
      label = &"CP_RAID1_NUMSPUZZLE/INTEL_RACE_TIME_7";
      break;
    case 6:
      label = &"CP_RAID1_NUMSPUZZLE/INTEL_RACE_TIME_6";
      break;
    case 5:
      label = &"CP_RAID1_NUMSPUZZLE/INTEL_RACE_TIME_5";
      break;
    case 4:
      label = &"CP_RAID1_NUMSPUZZLE/INTEL_RACE_TIME_4";
      break;
    case 3:
      label = &"CP_RAID1_NUMSPUZZLE/INTEL_RACE_TIME_3";
      break;
    case 2:
      label = &"CP_RAID1_NUMSPUZZLE/INTEL_RACE_TIME_2";
      break;
    case 1:
      label = &"CP_RAID1_NUMSPUZZLE/INTEL_RACE_TIME_1";
      break;
  }

  return label;
}