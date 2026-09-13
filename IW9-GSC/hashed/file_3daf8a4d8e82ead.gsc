/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3daf8a4d8e82ead.gsc
***********************************************/

init() {
  scripts\engine\utility::flag_wait("cp_raid1_maze_create_script_completed");
  wait 2;
  level thread _id_1FDB885090FA3875::_id_66E614363F4AAB26();
  _id_1FDB885090FA3875::_id_3AA305CAB5BF65C5();
  level._id_A482AE70A62B5FB7.puzzle_mark_complete = ::_id_7033B0E641EB8F1D;
  level._id_A482AE70A62B5FB7.increase_sequence_tier = ::increase_sequence_tier;
  level._id_A482AE70A62B5FB7._id_A3B356F2158A1EB3 = ::_id_A3B356F2158A1EB3;
  level._id_39BC47CBD32AD77E._id_1EDCD0185B996C10 = 5;
  level._id_39BC47CBD32AD77E._id_0E7D8F530D432967 = 3;
  level._id_39BC47CBD32AD77E._id_585A623B71645E3E = 3;
  level.seq3_tier = 1;
  level thread reset_button_handler();
  level thread _id_510DCDCBF4FC993C();
  level thread _id_9CC753943CF104C7();
  level thread _id_88405BE410C26985();
}

_id_AC02C3D6EF0F7FA2() {
  struct = scripts\engine\utility::getStruct("intro_tutorialpuzzle_cypher_location", "targetname");
  button = scripts\cp\utility::createhintobject(struct.origin, "HINT_BUTTON", undefined, undefined, undefined, undefined, "show", 200, 100, 60, 50);
  button thread _id_26006D6955F78888::_id_AF594BDB5B8E4FEB();
}

_id_7861D97D45065917() {
  level endon("game_ended");
  _id_71717E6C4597A196::_id_15FE9620D04DBB58();
  _id_71717E6C4597A196::_id_23417F0A11657091("cctv_interact_1", "stop_cctv");
  _id_71717E6C4597A196::_id_23417F0A11657091("cctv_interact_2", "stop_cctv");
  spawnfunc = _id_18A73A64992DD07D::registerambientgroup;
  [[spawnfunc]]("seq1_spawners_intro_cctv", 9, 9, 9, 0.1, 0, "seq1_spawners_intro_cctv", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq1_spawners_intro_cctv", ::_id_D167EA229487CDB4);
  [[spawnfunc]]("maze_spawners_intro_jugg", 1, 1, 1, 0.1, 0, "maze_spawners_intro_jugg", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("maze_spawners_intro_jugg", _id_1E9BF201EA44567C::run_stealth_funcs);
  scripts\engine\utility::flag_wait("cp_raid1_maze_cctv_cs_completed");
  trigger = getEnt("trigger_load_cctv", "targetname");

  for(;;) {
    trigger waittill("trigger", player);

    if(isPlayer(player)) {
      break;
    }
  }

  level thread _id_F469A040B9B2D8D4();
  level thread _id_67673120F043631E::_id_D686043AA5DC16BB();
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "") {
    level _id_26006D6955F78888::_id_6024AE62A775BA86();
    level thread _id_26006D6955F78888::_id_561517D90F73C662();
    return;
  }

  level thread init();
  level thread _id_F6AFBFEE0AC2D9DA();
  level thread _id_400357CDAFBE6619();
  level thread _id_8EDBFCBA72A5A37A();
}

_id_8EDBFCBA72A5A37A() {
  level endon("game_ended");
  level endon("maze_numstutorial_complete");
  scripts\engine\utility::flag_init("nums_tutorial_started");
  scripts\engine\utility::flag_wait("nums_tutorial_started");
  struct = scripts\engine\utility::getStruct("cctv_hint_security", "targetname");
  _id_CDC5DD6C28C9709D = squared(800);

  while(!scripts\cp\utility::are_all_players_nearby(struct.origin, _id_CDC5DD6C28C9709D))
    wait 0.5;

  level childthread _id_C9E4AB1D5085BFF9();
  timer = 120;
  hints = 0;
  _id_AD2D5DE3EB5BA153 = undefined;

  for(;;) {
    level scripts\engine\utility::waittill_any_timeout_1(timer, "cctv_force_hint");

    if(isDefined(_id_AD2D5DE3EB5BA153)) {
      if(gettime() < _id_AD2D5DE3EB5BA153 + 30000)
        wait 30;
    }

    _id_669C0F6CB0B7F0CD::_id_279630B251D193C2(hints);
    _id_AD2D5DE3EB5BA153 = gettime();
    hints++;
  }
}

_id_7F65D85CBD1303CC(number) {
  alias = undefined;

  switch (number) {
    case 1:
      alias = "dx_guid34552d73cc1d456fa66278b551633b19";
      break;
    case 2:
      alias = "dx_guid69357dc39afb4a679d1dc6fa48136dae";
      break;
    case 3:
      alias = "dx_guid225f03f7c10e449c899fd662d541ba57";
      break;
    case 4:
      alias = "dx_guidaf690fe990d245f3b37f906805556134";
      break;
    case 5:
      alias = "dx_guidb043c02d1f554834b07bfa20f8f9e70a";
      break;
    case 6:
      alias = "dx_guid7581a4bfe0b9467ca149ec3b95367504";
      break;
  }

  return alias;
}

_id_C9E4AB1D5085BFF9() {
  struct = scripts\engine\utility::getStruct("cctv_hint_spawn", "targetname");
  _id_CDC5DD6C28C9709D = squared(2000);

  while(!scripts\cp\utility::any_player_nearby(struct.origin, _id_CDC5DD6C28C9709D))
    wait 0.5;

  level notify("cctv_force_hint");
}

_id_F6AFBFEE0AC2D9DA() {
  level._id_6BC4B7D7CB30911D = _id_18A73A64992DD07D::run_spawn_module("seq1_spawners_intro_cctv");
  level waittill("nums_intro_door_open");

  foreach(ai in level._id_6BC4B7D7CB30911D.ai_spawned)
  ai _id_18A73A64992DD07D::script_kill_ai(0);

  level thread _id_A321097C2A987D00();
}

_id_D167EA229487CDB4(group_name, func) {
  self.sightmaxdistance = 2200;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  thread _id_DA51384BA3687D3C();
}

_id_DA51384BA3687D3C() {
  self endon("death");

  for(;;) {
    self.ignoreall = 1;
    wait 1;
  }
}

_id_400357CDAFBE6619() {
  startstruct = scripts\engine\utility::getStruct("cctv_droneswarm_start", "targetname");
  level._id_7AE7CCFF11823A4B = 1;
  level._id_43D6260EC0484E29 = "cctv_droneswarm_start";
  level._id_9A478B5F4F67D5CD = 3;
  _id_4AA198AF4457349E::_id_78B690F869D12A6B();
  _id_43C8CCE084D817D2 = 3;
  max_drones = 3;
  spawnpoint = scripts\engine\utility::getStruct("cctv_droneswarm_start", "targetname");
  spawnfunc = _id_6E2CD47141F9745B::_id_CB2C1DF00BD5E191;

  if(level.drone_turrets.size > max_drones) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_43C8CCE084D817D2; _id_AC0E594AC96AA3A8++) {
    drone = level thread[[spawnfunc]](spawnpoint, undefined, "cctv");
    wait 0.1;
  }
}

_id_A321097C2A987D00() {
  level thread _id_6E2CD47141F9745B::_id_18871F933340B91B();
  wait 0.5;
  level._id_44A584EDFEB159A2 = undefined;
  level._id_43D6260EC0484E29 = undefined;
}

reset_button_handler() {
  _id_1E4C761B386C2D1B = scripts\engine\utility::getStruct("intro_tutorialpuzzle_resetbutton", "targetname");
  level.seq3_reset_switch = spawn("script_model", _id_1E4C761B386C2D1B.origin);
  level.seq3_reset_switch setModel("tag_origin");
  level.seq3_reset_switch.targetname = "seq3_resetbutton";
  waitframe();
  level.seq3_reset_switch makeusable();
  hintstring = &"CP_RAID1_NUMSPUZZLE/RESET_BUTTON";
  level.seq3_reset_switch setHintString(hintstring);
  level.seq3_reset_switch setCursorHint("HINT_BUTTON");
  level.seq3_reset_switch sethintdisplayrange(265);
  level.seq3_reset_switch sethintdisplayfov(140);
  level.seq3_reset_switch setuserange(65);
  level.seq3_reset_switch setusefov(50);
  level.seq3_reset_switch sethintonobstruction("show");
  level.seq3_reset_switch setuseholdduration("duration_short");
  level.seq3_reset_switch sethinticon("icon_electrical_box");
  level.seq3_reset_switch thread reset_use_think();
}

reset_use_think() {
  self endon("death");
  level thread reset_use_trigger(self);

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player)) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      level thread reset_use_trigger(self, player);
    }
  }
}

reset_use_trigger(model, player) {
  model endon("death");
  model _meth_DFB78B3E724AD620(0);
  level._id_A4D87E220508D745 = player;
  level notify("puzzle_code_reset");

  if(isDefined(player))
    _id_1FDB885090FA3875::_id_B0CE90035E6B64D0(player);

  _id_1FDB885090FA3875::clear_keypad_currentdisplay_models();
  level.f14_current_inputseq = "";
  level.f14_current_inputamt = 0;
  level.seq3_sequences_correct = 0;
  setomnvar("ui_raid_number_retries", 3);
  level.seq3_puzzle_attempts = undefined;
  level thread _id_1FDB885090FA3875::clear_cypher_icon();
  level notify("radio_power_on");
  level notify("computer_power_on");
  level notify("seq3_reset_trigger");
  level thread _id_1D96771C16913CF2();
  level thread start_puzzle();
}

start_puzzle() {
  level endon("game_ended");
  level endon("maze_numstutorial_complete");
  _id_88A5B6AAD8A3BF4C = scripts\engine\utility::getStruct("intro_tutorialpuzzle_interaction_computer", "targetname");
  level thread _id_1FDB885090FA3875::computer_listener_all(_id_88A5B6AAD8A3BF4C);
  level thread keyboard_monitor_disable(level.seq3_computer_interaction);
  level _id_1FDB885090FA3875::clear_three_room_screens();
  level thread _id_1FDB885090FA3875::code_generation_init(9);
  level._id_C7CE28D1FB1348C3 = 60;
  level.seq3_tier = 1;
  level thread _id_997AD81DADDDA3A9();
  _id_79AFE3DE97F7463A = scripts\engine\utility::getStruct("intro_tutorialpuzzle_cypher_location", "targetname");
  level thread _id_1FDB885090FA3875::init_keypad_display_digits(_id_79AFE3DE97F7463A);
  level.seq3_cypher_tagorigin = scripts\engine\utility::spawn_tag_origin(_id_79AFE3DE97F7463A.origin, _id_79AFE3DE97F7463A.angles);
  level.seq3_cypher_tagorigin show();
  _id_984357ECC006A19C = "intro_tutorialpuzzle_code_locations";
  level thread _id_1FDB885090FA3875::_id_A0B2561CEDE911A2(_id_88A5B6AAD8A3BF4C.origin);
  level thread _id_1FDB885090FA3875::_id_CCCB426B669C407C(_id_79AFE3DE97F7463A.origin);

  for(;;) {
    level thread _id_1FDB885090FA3875::spawn_new_digits(level.seq3_tier, _id_984357ECC006A19C);
    level waittill("seq3_tier_increase");
  }
}

_id_1D96771C16913CF2() {
  if(istrue(level._id_2F820CAC1AC04F39)) {
    return;
  }
  scripts\engine\utility::flag_set("nums_tutorial_started");
  level notify("nums_tutorial_started");
  level thread _id_21928006927D8163();
  scripts\cp\cp_analytics::_id_B6283AC45A607764("raid1_intro");
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Numbers-Puzzle Tutorial");
}

_id_21928006927D8163() {
  level endon("game_ended");

  if(level.players.size == 0) {
    wait 1;
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  }

  wait 1;
  setomnvar("ui_raid_number_retries", 0);
  wait 0.1;
  setomnvar("ui_raid_number_retries", 3);
}

_id_997AD81DADDDA3A9() {
  struct = scripts\engine\utility::getStruct("intro_tutorialpuzzle_cypher_location", "targetname");
  struct thread _id_18AF78602B67B70C::_id_26198B4BB49A3DF5(700);
}

keyboard_monitor_disable(_id_287CC7482806C9F7) {
  level waittill("maze_numstutorial_complete");
  _id_1FDB885090FA3875::computer_force_player_to_exit();
  _id_287CC7482806C9F7.disable_playeruse = 1;
  _id_287CC7482806C9F7 makeunusable();
}

_id_7033B0E641EB8F1D() {
  level notify("maze_numstutorial_complete");
  level thread _id_1FDB885090FA3875::clear_cypher_icon();
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Numbers-Puzzle Tutorial");
  level thread scripts\cp\utility::playsoundatpos_safe(level.seq3_computer_interaction.origin, "dx_cp_cpr1_intr_cmpv_authenticationconfir_01");
  _id_79AFE3DE97F7463A = scripts\engine\utility::getStruct("intro_tutorialpuzzle_cypher_location", "targetname");
  _id_A7B23DAE3BCFE5F8 = spawnStruct();
  _id_A7B23DAE3BCFE5F8.origin = _id_79AFE3DE97F7463A.origin;
  _id_A7B23DAE3BCFE5F8.angles = invertangles(_id_79AFE3DE97F7463A.angles);
  _id_A7B23DAE3BCFE5F8 thread _id_26006D6955F78888::_id_561517D90F73C662();
  level thread _id_EF819257CEE0D4E5();
}

_id_EF819257CEE0D4E5() {
  _id_17C023924A0B353D = _id_71717E6C4597A196::_id_20D4410924E4363C("cctv_interact_1");
  _id_42C3C0904E734978 = scripts\engine\utility::getStruct("cctv_forced_cam_1", "targetname");
  _id_17C023924A0B353D thread _id_71717E6C4597A196::_id_A9BBD2B317E2FEC9(_id_42C3C0904E734978);
  _id_17C020924A0B2EA4 = _id_71717E6C4597A196::_id_20D4410924E4363C("cctv_interact_2");
  _id_42C3C3904E735011 = scripts\engine\utility::getStruct("cctv_forced_cam_2", "targetname");
  _id_17C020924A0B2EA4 thread _id_71717E6C4597A196::_id_A9BBD2B317E2FEC9(_id_42C3C3904E735011);
}

_id_1B426E14552128FA() {
  door = getEnt("maze_tutorialpuzzle_door", "script_noteworthy");
  _id_F7397F9DA0636653 = getEnt("maze_tutorialpuzzle_door_model", "script_noteworthy");
  _id_F7397F9DA0636653 linkTo(door);
  movetime = 4;
  level thread scripts\cp\utility::playsoundatpos_safe(door.origin, "cp_puzzledoor_open");
  door moveTo(door.origin + (0, 0, 150), movetime, 0.1, 0.1);
  wait(movetime);
  level thread scripts\cp\utility::playsoundatpos_safe(door.origin, "cp_puzzledoor_open");
  wait 0.05;
  door delete();
  _id_F7397F9DA0636653 delete();
}

increase_sequence_tier(_id_DF071553D0996FF9) {
  level.seq3_tier++;
  level notify("seq3_tier_increase");
  level thread _id_1FDB885090FA3875::set_tier_lights(level.seq3_tier, _id_DF071553D0996FF9);

  if(level.seq3_tier == 2)
    level._id_39BC47CBD32AD77E._id_585A623B71645E3E = 4;
  else if(level.seq3_tier == 3)
    level._id_39BC47CBD32AD77E._id_585A623B71645E3E = 5;

  if(level.seq3_tier < level._id_39BC47CBD32AD77E._id_0E7D8F530D432967) {
    _id_9677E461912FA0EC = _id_71717E6C4597A196::_id_20D4410924E4363C("cctv_interact_1");
    _id_9677E761912FA785 = _id_71717E6C4597A196::_id_20D4410924E4363C("cctv_interact_2");
    level thread _id_71717E6C4597A196::_id_44F128FB3327A0D1(_id_9677E461912FA0EC);
    level thread _id_71717E6C4597A196::_id_44F128FB3327A0D1(_id_9677E761912FA785);
  }
}

_id_A3B356F2158A1EB3() {
  hintstring = &"CP_RAID1_NUMSPUZZLE/RESET_BUTTON";
  level.seq3_reset_switch setHintString(hintstring);
  level.seq3_reset_switch setuseholdduration("duration_short");
  level._id_39BC47CBD32AD77E._id_585A623B71645E3E = 3;
}

_id_88405BE410C26985() {
  level endon("game_ended");
  dist = 250000;
  _id_ECFA2BCE704CA3E3 = scripts\engine\utility::getStruct("maze_weapons_offset_test", "targetname");

  for(;;) {
    _id_1FFE17EE4F09C733 = scripts\cp\utility::are_all_players_nearby(_id_ECFA2BCE704CA3E3.origin, dist);

    if(_id_1FFE17EE4F09C733) {
      if(isDefined(level._id_AB681BAC7287696B))
        level thread[[level._id_AB681BAC7287696B]]();

      return;
    }

    wait 0.5;
  }
}

_id_F469A040B9B2D8D4() {
  data = spawnStruct();
  door_ent = getEnt("cctv_puzzle_door", "script_noteworthy");
  _id_FEF7FF29C1843069 = getEnt("cctv_puzzle_door_model", "script_noteworthy");
  door_ent linkTo(_id_FEF7FF29C1843069);

  if(!isDefined(_id_FEF7FF29C1843069.script_offset))
    _id_FEF7FF29C1843069.script_offset = (0, 0, 60);

  _id_5AC49E018B46B2CD = scripts\engine\utility::getStruct(_id_FEF7FF29C1843069.target, "targetname");
  _id_20F3271DC43A6012 = scripts\engine\utility::getStruct(_id_5AC49E018B46B2CD.target, "targetname");
  _id_5AC49E018B46B2CD.origin = _id_5AC49E018B46B2CD.origin + rotatevector((0, 0, 4), _id_5AC49E018B46B2CD.angles);
  _id_20F3271DC43A6012.origin = _id_20F3271DC43A6012.origin + rotatevector((0, 0, 4), _id_20F3271DC43A6012.angles);
  hintstring = &"CP_RAID_WATERMAZE/DOOR_OPEN";
  model = "tag_origin";
  _id_5AC49E018B46B2CD _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(hintstring, model, 64, 256, "duration_none", "hide");
  _id_20F3271DC43A6012 _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(hintstring, model, 64, 256, "duration_none", "hide");
  thread _id_669C0F6CB0B7F0CD::_id_72A0C69D4DF855E5(_id_FEF7FF29C1843069);
  _id_34D2771929BD6022::_id_05F7C6BF2110C0FE(_id_FEF7FF29C1843069);
}

_id_510DCDCBF4FC993C() {
  level endon("game_ended");

  if(istrue(level._id_792D13A9A5502320)) {
    return;
  }
  level._id_792D13A9A5502320 = 1;
  scripts\engine\utility::flag_wait("cp_raid1_maze_create_script_completed");
  weapons = [];
  _id_CDE2EC78F52F00F9 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike4");
  _id_CDE2EC78F52F00F9 = _id_CDE2EC78F52F00F9 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "ub_"]);
  _id_CDE2E978F52EFA60 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("sbeta");
  _id_CDE2E978F52EFA60 = _id_CDE2E978F52EFA60 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["fourx", "tactical"]);
  _id_CDE2EA78F52EFC93 = makeweaponfromstring("iw9_dm_scromeo_mp+ammo_65cm+bar_sn_long_p05+arscope_therm01+grip_angled01+mag_sn_p05+pgrip_aim_p05+rec_scromeo+stock_sn_light_p05");
  _id_CDE2EF78F52F0792 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("limax");
  _id_CDE2F078F52F09C5 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("akilo");
  _id_CDE2F078F52F09C5 = _id_CDE2F078F52F09C5 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["bar_ar_light", "stock_ar_light", "reddot"]);
  _id_CDE2ED78F52F032C = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("papa220");
  _id_CDE2ED78F52F032C = _id_CDE2ED78F52F032C _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["silencer", "reddot"]);
  _id_CDE2EE78F52F055F = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("kilo21");
  _id_CDE2EE78F52F055F = _id_CDE2EE78F52F055F _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00("belt_lm_large");
  _id_CDE2F378F52F105E = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("aviktor");
  _id_CDE2F378F52F105E = _id_CDE2F378F52F105E _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "mag_sm_large", "stock_sm_light"]);
  _id_CDE2F478F52F1291 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("beta");
  _id_CDE2F478F52F1291 = _id_CDE2F478F52F1291 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "stockno"]);
  _id_F90ED703365EBA0B = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mbravo");
  _id_F90ED603365EB7D8 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mpapa7");
  _id_F90ED603365EB7D8 = _id_F90ED603365EB7D8 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "mag_sm_xlarge", "stock_sm_heavy"]);
  _id_F90ED903365EBE71 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("akilo105");
  _id_F90ED903365EBE71 = _id_F90ED903365EBE71 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "ub_"]);
  _id_F90ED803365EBC3E = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("rpapa7");
  _id_F90EDB03365EC2D7 = makeweapon("iw9_me_riotshield_mp");
  weapons = [_id_CDE2EC78F52F00F9, _id_CDE2E978F52EFA60, _id_CDE2EA78F52EFC93, _id_CDE2EF78F52F0792, _id_CDE2F078F52F09C5, _id_CDE2ED78F52F032C, _id_CDE2EE78F52F055F, _id_CDE2F378F52F105E, _id_CDE2F478F52F1291, _id_F90ED703365EBA0B, _id_F90ED603365EB7D8, _id_F90ED903365EBE71, _id_F90ED803365EBC3E, _id_F90EDB03365EC2D7];
  _id_A13FD508CAD5931C = scripts\engine\utility::getStructArray("start_weapon", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A13FD508CAD5931C.size; _id_AC0E594AC96AA3A8++) {
    _id_A13FD508CAD5931C[_id_AC0E594AC96AA3A8].angles = _id_A13FD508CAD5931C[_id_AC0E594AC96AA3A8].angles + (0, 90, 0);
    _id_28A6B68460F4FD6B = _id_A13FD508CAD5931C[_id_AC0E594AC96AA3A8];
    weapon_object = undefined;

    if(!isDefined(_id_28A6B68460F4FD6B.weaponinfo)) {
      continue;
    }
    switch (_id_28A6B68460F4FD6B.weaponinfo) {
      case "weapon_wm_ar_mike4_brprop":
        weapon_object = _id_CDE2EC78F52F00F9;
        break;
      case "weapon_wm_sn_sbeta_brprop":
        weapon_object = _id_CDE2F478F52F1291;
        break;
      case "weapon_wm_sn_mike14_brprop":
        weapon_object = _id_CDE2EA78F52EFC93;
        break;
      case "weapon_wm_sn_alpha50_brprop":
        weapon_object = _id_CDE2EF78F52F0792;
        break;
      case "weapon_wm_ar_akilo47_brprop":
        weapon_object = _id_CDE2F078F52F09C5;
        break;
      case "weapon_wm_pi_mike1911_brprop":
        weapon_object = _id_CDE2ED78F52F032C;
        break;
      case "weapon_wm_lm_kilo121_brprop":
        weapon_object = _id_CDE2EE78F52F055F;
        break;
      case "weapon_wm_sm_mpapa5_brprop":
        weapon_object = _id_CDE2F378F52F105E;
        break;
      case "weapon_wm_sm_beta_brprop":
        weapon_object = _id_CDE2F478F52F1291;
        break;
      case "weapon_wm_sh_charlie725_brprop":
        weapon_object = _id_F90ED703365EBA0B;
        break;
      case "weapon_wm_sm_mpapa7_brprop":
        weapon_object = _id_F90ED603365EB7D8;
        break;
      case "weapon_wm_ar_kilo433_brprop":
        weapon_object = _id_F90ED903365EBE71;
        break;
      case "weapon_wm_la_rpapa7":
        weapon_object = _id_F90ED803365EBC3E;
        break;
      case "riotshield":
        weapon_object = _id_F90EDB03365EC2D7;
        break;
    }

    if(isDefined(weapon_object)) {
      _id_28A6B68460F4FD6B _id_9655BF427A5ABDB8(undefined, weapon_object);
      continue;
    }
  }
}

_id_9CC753943CF104C7() {
  level endon("game_ended");
  dist = 250000;
  _id_ECFA2BCE704CA3E3 = scripts\engine\utility::getStruct("maze_weapons_offset_test", "targetname");

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      if(distancesquared(level.players[_id_AC0E594AC96AA3A8].origin, _id_ECFA2BCE704CA3E3.origin) <= dist) {
        if(isalive(level.players[_id_AC0E594AC96AA3A8])) {
          removed = level.players[_id_AC0E594AC96AA3A8] _id_4D5D872A7BD5C0C3::_id_8FC85383E9F1B6E6();

          if(removed) {
            if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
              _id_4D5D872A7BD5C0C3::_id_7EF73B70806A15CD();

            return;
          }
        }
      }
    }

    wait 1;
  }
}

_id_9655BF427A5ABDB8(sweapon, _id_E6C13F566F945346) {
  if(!isDefined(_id_E6C13F566F945346))
    objweapon = makeweaponfromstring(sweapon);
  else
    objweapon = _id_E6C13F566F945346;

  _id_A88537B73E05F02A = scripts\engine\utility::getStruct("maze_weapons_offset_test", "targetname");
  offset = (0, 0, 0);

  if(isDefined(_id_A88537B73E05F02A))
    offset = rotatevector(offset, _id_A88537B73E05F02A.angles);

  _id_A2D8571E188FEF37 = 1;
  _id_B8F5AC23CE0DFDE3 = _id_66122A002AFF5D57::createspawnweaponatpos(self.origin + offset, self.angles, objweapon, _id_A2D8571E188FEF37);
  _id_B8F5AC23CE0DFDE3 _id_66122A002AFF5D57::_id_86321FC8F45C2A9B(1);
  _id_B8F5AC23CE0DFDE3 _id_66122A002AFF5D57::_id_B10EE40ED82D45C9(1);
  return _id_B8F5AC23CE0DFDE3;
}

_id_7BED63E134C9AE06() {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player) && isPlayer(player) && !istestclient(player))
      player _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(self);
  }
}

_id_C13975C405CE8CFC(origin, angles, type, _id_F38C82C3A771999C) {
  if(!isDefined(type)) {
    return;
  }
  icon = undefined;

  if(type == "sentry") {
    if(!isDefined(_id_F38C82C3A771999C))
      _id_F38C82C3A771999C = 0;

    _id_B23E13281A551465 = origin + (0, 0, _id_F38C82C3A771999C);
    _id_CB04D051801DB715 = spawn("script_model", _id_B23E13281A551465);
    _id_CB04D051801DB715.angles = angles;
    _id_CB04D051801DB715 setModel("wpn_wm_p45_mg_auto_sentry_held_v0");
    _id_CB04D051801DB715.targetname = "ks_model_" + type;
    _id_9A257FA33F18D244 = spawn("script_model", origin);
    _id_9A257FA33F18D244.angles = angles;
    _id_9A257FA33F18D244 setModel("tag_origin");
    _id_9A257FA33F18D244.targetname = "ks_usable_" + type;
    _id_9A257FA33F18D244 endon("death");
    _id_9A257FA33F18D244 makeusable();
    _id_9A257FA33F18D244 setHintString(level.sentrysettings["sentry_turret"].ownerusehintstring);
    _id_9A257FA33F18D244 setCursorHint("HINT_BUTTON");
    _id_9A257FA33F18D244 sethintdisplayrange(150);
    _id_9A257FA33F18D244 sethintdisplayfov(70);
    _id_9A257FA33F18D244 setuserange(95);
    _id_9A257FA33F18D244 setusefov(50);
    _id_9A257FA33F18D244 sethintonobstruction("show");
    _id_9A257FA33F18D244 setuseholdduration("duration_medium");
    icon = _id_9A257FA33F18D244 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage("allies", "hud_icon_killstreak_sentry", 12, 1, 150);

    for(;;) {
      _id_9A257FA33F18D244 waittill("trigger", player);

      if(isDefined(player)) {
        if(!player scripts\cp\utility::is_valid_player()) {
          continue;
        }
        if(!scripts\cp\killstreaks\sentry_gun_cp::_id_42FD6416C3355566(player)) {
          continue;
        }
        player playlocalsound("grenade_pickup");

        if(isDefined(icon))
          scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);

        _id_CB04D051801DB715 delete();
        _id_9A257FA33F18D244 delete();
        return;
      }
    }
  }
}