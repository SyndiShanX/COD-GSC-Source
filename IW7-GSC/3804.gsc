/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3804.gsc
**************************************/

#using_animtree("player");

_id_D249() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["computer_enter"] = % shipcrib_captains_chair_enter;
  level._id_EC85["player_rig"]["computer_idle"][0] = % shipcrib_captains_chair_idle;
  level._id_EC85["player_rig"]["computer_exit"] = % shipcrib_captains_chair_exit;
}

#using_animtree("script_model");

_id_C2B0() {
  level._id_EC87["captains_monitor"] = #animtree;
  level._id_EC8C["captains_monitor"] = "equipment_desktop_monitor_anim_01";
  level._id_EC85["captains_monitor"]["computer_enter"] = % shipcrib_captains_chair_monitor_enter;
  level._id_EC85["captains_monitor"]["computer_idle"][0] = % shipcrib_captains_chair_monitor_idle;
  level._id_EC85["captains_monitor"]["computer_exit"] = % shipcrib_captains_chair_monitor_exit;
}

_id_54FA() {
  level notify("captains_quarters_disable_cursor_hints");
  level._id_448C._id_99FC _id_0E46::_id_DFE3();
  level._id_BBA5._id_99FD _id_0E46::_id_DFE3();

  if(isDefined(level._id_3A24) && isDefined(level._id_3A24._id_99F4)) {
    level._id_3A24._id_99F4 _id_0E46::_id_DFE3();
  }
}

_id_61CE() {
  level thread _id_448C();
  level thread _id_BBA6();

  if(isDefined(level._id_3A24)) {
    level._id_3A24._id_99F4 thread _id_0E46::_id_48C4(undefined, undefined, &"SHIPCRIB_LISTEN", 180, 240, 70, 0, undefined, undefined, undefined, 0);
  }
}

_id_622E(var_0) {
  switch (var_0) {
    case "computer":
      level thread _id_448C();
      break;
    case "viewer":
      break;
    case "wanted_board":
      level thread _id_BBA6();
      break;
    case "pickups":
      break;
  }
}

_id_448B(var_0) {
  setdvarifuninitialized("query_music_play", 0);
  setdvarifuninitialized("query_video_play", 0);
  setdvarifuninitialized("leave_menu", 0);
  setomnvar("ui_terminal_invoke", 0);
  scripts\engine\utility::flag_init("computer_started");
  level.player notifyonplayercommand("escape_video", "togglecrouch");
  level thread _id_D249();
  level thread _id_C2B0();
  level._id_448C = spawnStruct();
  level._id_448C._id_99FC = scripts\engine\utility::getStruct("captains_computer_int", "targetname");
  level._id_448C._id_6735 = 0;
  level._id_448C._id_BC0E = undefined;
  level._id_EB94 = undefined;
  _id_39FE();

  if(!isDefined(var_0) || !var_0) {
    level thread _id_448C();
  }

  level thread _id_F91C(var_0);
  level thread _id_448A();
}

_id_39FE() {
  level._effect["vfx_ui_capops_screensaver"] = loadfx("vfx/iw7/core/ui/vfx_ui_capops_screensaver.vfx");
  level._effect["vfx_ui_capops_monitor_message"] = loadfx("vfx/iw7/core/ui/vfx_ui_capops_monitor_message.vfx");
  level._effect["vfx_ui_capops_flicker"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_ui_capops_flicker.vfx");
  level._effect["vfx_soundbar"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_soundbar.vfx");
}

_id_9A06() {
  if(level.script == "gravity") {
    return;
  }
  scripts\engine\utility::waitframe();
}

_id_DBF8() {
  if(level.script == "shipcrib_moon") {
    return;
  }
  level._id_3A24 = getEnt("captain_quarters_radio", "targetname");

  if(!isDefined(level._id_3A24)) {
    return;
  }
  level._id_3A24 thread _id_DBF9();
}

_id_DBF9() {
  self._id_10468 = scripts\engine\utility::spawn_tag_origin();
  self._id_4BB2 = 0;
  self._id_4BB1 = undefined;
  self._id_99F4 = scripts\engine\utility::spawn_tag_origin();
  self._id_99F4.origin = self.origin + anglesToForward(self._id_99F4.angles) * 15 + anglestoup(self._id_99F4.angles) * 10;
  scripts\engine\utility::waitframe();

  for(;;) {
    self._id_99F4 thread _id_0E46::_id_48C4(undefined, undefined, &"SHIPCRIB_LISTEN", 180, 240, 50, 0, undefined, undefined, undefined, 0);
    self._id_99F4 waittill("trigger");
    self._id_10468 stopsounds();
    self._id_10468 notify("stop_sound");
    scripts\engine\utility::waitframe();

    if(self._id_4BB2 >= 4) {
      self._id_4BB2 = 0;
      self._id_10468 stopsounds();
      self._id_4BB1 = undefined;
    } else
      self._id_4BB2++;

    switch (self._id_4BB2) {
      case 1:
        self._id_4BB1 = "mus_shipcrib_titan_old_captain";
        break;
      case 2:
        self._id_4BB1 = "mus_shipcrib_titan_old_captain";
        break;
      case 3:
        self._id_4BB1 = "mus_shipcrib_titan_old_captain";
        break;
      case 4:
        self._id_4BB1 = "mus_shipcrib_titan_old_captain";
        break;
    }

    wait 2.0;
  }
}

_id_DBFB() {
  self._id_4BB2 = 0;

  if(isDefined(self._id_4BB1)) {
    self._id_10468 scripts\engine\utility::stop_loop_sound_on_entity(self._id_4BB1);
  }

  self._id_4BB1 = undefined;
}

_id_448C() {
  level endon("captains_quarters_disable_cursor_hints");
  wait 1.0;
  var_0 = scripts\engine\utility::getStruct("captains_computer_moveto", "targetname");

  if(!isDefined(level._id_1FBD)) {
    level._id_1FBD = var_0 scripts\engine\utility::spawn_tag_origin();
  }

  var_1 = level._id_448C._id_99FC;
  var_1 thread _id_0E46::_id_48C4(undefined, undefined, &"SHIPCRIB_COMPUTER", 180, 240, 70, 0, undefined, undefined, undefined, 0);
  var_1 waittill("trigger");
  level thread _id_448A();
  scripts\sp\utility::_id_834F("CAPT_COMPUTER");
  level._id_CFB9 = _id_0EFB::_id_FE02("player_rig", level.player.origin, level.player.angles);
  level._id_CFB9 hide();
  level._id_1FBD scripts\sp\anim::_id_1EC3(level._id_CFB9, "computer_enter", "tag_player");
  scripts\engine\utility::waitframe();
  level.player _meth_823C(level._id_CFB9, "tag_player", 0.5, 0.1, 0.1);
  level._id_CFB9 scripts\engine\utility::delaycall(0.55, ::show);
  level.player scripts\sp\utility::_id_F526("normal");
  wait 0.55;
  level.player _meth_823B(level._id_CFB9, "tag_player");
  level thread _id_39FB();
  level._id_1FBD thread scripts\sp\anim::_id_1F35(level._id_3A2C, "computer_enter");
  level._id_1FBD scripts\sp\anim::_id_1F35(level._id_CFB9, "computer_enter", "tag_player");
  var_2 = getsticksconfig();

  if(isDefined(level.console) && level.console && !issubstr(var_2, "southpaw")) {
    level.player playerlinktodelta(level._id_CFB9, "tag_player", 0.3, 45, 45, 45, 45, 1);
    level.player _meth_8392(1, 2.2, 0.6);
  }

  level._id_1FBD thread scripts\sp\anim::_id_1EEA(level._id_CFB9, "computer_idle", "stop_loop", "tag_player");
  level._id_1FBD thread scripts\sp\anim::_id_1EEA(level._id_3A2C, "computer_idle", "stop_loop");
  scripts\engine\utility::waitframe();
  _id_C60C();
}

_id_39FB() {
  setsaveddvar("scr_dof_enable", "1");
  setsaveddvar("r_dof_hq", "0");
  thread _id_0B0A::_id_583F(0, 0, 0, 0, 70, 2, 2.5);
}

_id_39FC() {
  thread _id_0B0A::_id_583F(0, 0, 0, 0, 70, 0, 1);
  thread _id_0B0A::_id_583D(1);
  setsaveddvar("r_dof_hq", "0");
}

_id_448D(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "on";
  }

  level notify("capops_stop_message");

  switch (var_0) {
    case "on":
      playFXOnTag(scripts\engine\utility::getfx("vfx_ui_capops_screensaver"), level._id_907A, "tag_origin");
      killfxontag(scripts\engine\utility::getfx("vfx_ui_capops_monitor_message"), level._id_907A, "tag_origin");
      break;
    case "off":
      killfxontag(scripts\engine\utility::getfx("vfx_ui_capops_screensaver"), level._id_907A, "tag_origin");
      killfxontag(scripts\engine\utility::getfx("vfx_ui_capops_monitor_message"), level._id_907A, "tag_origin");
      break;
    case "message":
      killfxontag(scripts\engine\utility::getfx("vfx_ui_capops_screensaver"), level._id_907A, "tag_origin");
      playFXOnTag(scripts\engine\utility::getfx("vfx_ui_capops_monitor_message"), level._id_907A, "tag_origin");
      level thread _id_134B();
      break;
    case "flicker":
      killfxontag(scripts\engine\utility::getfx("vfx_ui_capops_screensaver"), level._id_907A, "tag_origin");
      killfxontag(scripts\engine\utility::getfx("vfx_ui_capops_monitor_message"), level._id_907A, "tag_origin");
      playFXOnTag(scripts\engine\utility::getfx("vfx_ui_capops_flicker"), level._id_907A, "tag_origin");
      level thread _id_134B();
      break;
  }
}

_id_134B() {
  var_0 = spawn("script_origin", (169, 309, 249));
  var_1 = spawn("script_origin", level._id_907A.origin);
  var_0 thread scripts\engine\utility::play_loop_sound_on_entity("ship_incoming_call_pa");
  var_1 thread scripts\engine\utility::play_loop_sound_on_entity("ship_incoming_call");
  scripts\engine\utility::flag_wait("computer_started");
  var_1 scripts\sp\utility::_id_10460(2, 1);
  var_0 scripts\sp\utility::_id_10460(2, 1);
}

_id_F91C(var_0) {
  level._id_3A2C = getEnt("captains_computer_monitor", "targetname");
  level._id_3A2C._id_1FBB = "captains_monitor";
  level._id_3A2C scripts\sp\anim::_id_F64A();
  var_1 = level._id_3A2C gettagorigin("j_monitor_screen");
  var_2 = level._id_3A2C gettagangles("j_monitor_screen");
  level._id_3A2D = getEntArray("captains_computer_bink_screen", "targetname")[0];
  level._id_3A2D linkTo(level._id_3A2C, "j_monitor_screen");
  level._id_3A2D hide();
  level._id_3A2E = getEnt("captains_computer_bink_screen_mini", "targetname");

  if(isDefined(level._id_3A2E)) {
    level._id_3A2F = getEnt("captains_computer_bink_screen_wide", "targetname");
    var_3 = level._id_3A2E.origin + anglesToForward(level._id_3A2C gettagangles("j_monitor_screen")) * 0.25;
    var_3 = var_3 + anglestoright(level._id_3A2C gettagangles("j_monitor_screen")) * 0.9;
    var_4 = level._id_3A2F.origin + anglesToForward(level._id_3A2C gettagangles("j_monitor_screen")) * 0.25;
    var_4 = var_4 + anglestoright(level._id_3A2C gettagangles("j_monitor_screen")) * 0.9;
    level._id_3A2E.origin = var_3;
    level._id_3A2F.origin = var_4;
    wait 0.05;
    var_5 = var_3 + anglestoright(level._id_3A2E.angles) * -4;
    var_5 = var_5 + anglestoup(level._id_3A2E.angles) * -0.35;
    level._id_3A30 = scripts\engine\utility::spawn_tag_origin(var_5, level._id_3A2E.angles + (0, 180, 0));
    level._id_3A2E linkTo(level._id_3A2C, "j_monitor_screen");
    level._id_3A2F linkTo(level._id_3A2C, "j_monitor_screen");
    level._id_3A30 linkTo(level._id_3A2C, "j_monitor_screen");
    level._id_3A2F hide();
    level._id_3A2E hide();
  }

  level._id_907A = scripts\engine\utility::spawn_tag_origin(var_1, var_2);
  level._id_907A.origin = level._id_907A.origin + anglesToForward(level._id_907A.angles) * 5;
  level._id_907A linkTo(level._id_3A2C, "j_monitor_screen");
  wait 1.0;
  playFXOnTag(scripts\engine\utility::getfx("vfx_ui_capops_flicker"), level._id_907A, "tag_origin");
  setomnvar("ui_inworld_menu_ent", level._id_907A);

  if(isDefined(var_0) && var_0) {
    return;
  }
  while(!isDefined(level._id_1FBD)) {
    wait 0.05;
  }

  _id_448D("on");
  level._id_1FBD scripts\sp\anim::_id_1EC3(level._id_3A2C, "computer_enter");
}

_id_BBAC() {
  _id_BBB1();
  _id_986F();
  scripts\engine\utility::flag_init("most_wanted_tutorial_shown");
  scripts\sp\utility::_id_16EB("most_wanted_tutorial", &"SHIPCRIB_MOST_WANTED_TUTORIAL", ::_id_BBB3);
  scripts\sp\utility::_id_16EB("most_wanted_tutorial_pc", &"SHIPCRIB_MOST_WANTED_TUTORIAL_PC", ::_id_BBB3);
  scripts\sp\utility::_id_9187("mostWantedBoard", 50, ::_id_BBAB);
  level._id_BBA5 = getEnt("link_analysis_board", "targetname");
  level._id_BBA5._id_99FD = scripts\engine\utility::getStruct("most_wanted_board_int", "targetname");
  level._id_BBA5._id_6964 = scripts\engine\utility::getStruct("most_wanted_board_player_exit", "targetname");
  level._id_BBA5._id_37B6 = scripts\engine\utility::getStruct("most_wanted_board_camera", "targetname");
  level._id_BBA5._id_37B6._id_D6AD = [];
  setomnvar("ui_most_wanted_board_ent", level._id_BBA5);
  _id_BBB0();
  var_0 = level._id_BBA5._id_37B6;
  var_1 = anglesToForward(var_0.angles) * -4;
  var_2 = anglestoright(var_0.angles) * -10;
  var_3 = anglestoup(var_0.angles) * -58;
  var_0._id_D6AD["top"] = var_0.origin + var_1 + var_2 + var_3;
  var_4 = anglestoup(var_0.angles) * -70;
  var_0._id_D6AD["bottom"] = var_0.origin + var_1 + var_2 + var_4;
  setdvarifuninitialized("ui_most_wanted_selection", "");
  _id_BBA6();
}

_id_BBB3() {
  return scripts\engine\utility::flag("most_wanted_tutorial_shown");
}

_id_986F() {
  level._id_EFF5 = level.player _meth_84C6("scTaughtWantedBoard");
}

_id_BBB1() {
  if(level.script == "shipcrib_epilogue") {
    level.player _meth_84C7("wantedBoardDataState", "salenKoch", "obtained");
    level._id_D9E5["wanted_cards"]["salenKoch"] = "obtained";
    level.player _meth_84C7("wantedBoardDataState", "riah", "obtained");
    level._id_D9E5["wanted_cards"]["riah"] = "obtained";
  }
}

_id_BBB0() {
  level._id_BBA5._id_3A55 = [];
  var_0 = scripts\sp\utility::_id_7CCC(level._id_BBA5.model);

  foreach(var_2 in var_0) {
    if(var_2 == "tag_origin") {
      continue;
    }
    var_3 = strtok(var_2, "_")[1];
    level._id_BBA5._id_3A55[var_3] = spawn("script_model", level._id_BBA5 gettagorigin(var_2));
    level._id_BBA5._id_3A55[var_3].angles = level._id_BBA5 gettagangles(var_2);
    level._id_BBA5._id_3A55[var_3].tag = var_2;
    level._id_BBA5._id_3A55[var_3].index = var_3;
    level._id_BBA5._id_3A55[var_3] dontcastshadows();
    level._id_BBA5._id_3A55[var_3] _id_BBAF(var_3);

    switch (var_3) {
      case "acepilot7":
      case "acepilot6":
      case "acepilot5":
      case "acepilot4":
      case "acepilot3":
      case "acepilot2":
      case "acepilot1":
      case "acepilot0":
      case "riah":
      case "salenkoch":
      case "captain1":
      case "captain0":
        level._id_BBA5._id_3A55[var_3]._id_A534 = "top";
        break;
      default:
        level._id_BBA5._id_3A55[var_3]._id_A534 = "bottom";
        break;
    }
  }

  level._id_BBA5._id_BF09 = undefined;
  var_5 = _id_0A2F::_id_DA15();

  foreach(var_7 in var_5) {
    var_8 = level._id_D9E5["wanted_cards"][var_7];

    if(isDefined(var_8)) {
      if(var_8 == "obtained") {
        level._id_BBA5._id_BF09 = 1;
        break;
      }
    }
  }
}

_id_BBAF(var_0) {
  if(var_0 == "salenkoch") {
    var_1 = "salenKoch";
  } else {
    var_1 = var_0;
  }

  var_2 = level._id_D9E5["wanted_cards"][var_1];

  if(isDefined(var_2)) {
    if(var_2 == "locked") {
      var_3 = "most_wanted_cards_" + var_0 + "_locked";
    } else {
      var_3 = "most_wanted_cards_" + var_0;
    }
  } else
    var_3 = undefined;

  if(isDefined(var_3)) {
    precachemodel(var_3);
    self setModel(var_3);
  }
}

_id_BBA6() {
  level endon("captains_quarters_disable_cursor_hints");
  wait 1.0;
  var_0 = level._id_BBA5._id_99FD;
  var_1 = level._id_BBA5._id_37B6;
  level._id_BBA5._id_1624 = level._id_BBA5._id_3A55["salenkoch"];
  var_0 _id_0E46::_id_48C4(undefined, undefined, &"MOSTWANTED_USEBOARD", 60, 150, 75, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  var_0 waittill("trigger");
  level.player _meth_8497(1);
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_1._id_D6AD["top"];
  var_2.angles = var_1.angles;
  level.player _meth_823C(var_2, "tag_origin", 0.5, 0.125, 0.125);
  scripts\sp\utility::_id_9199("mostWantedBoard", 1);
  level._id_BBA5._id_1624 scripts\sp\utility::_id_9196(1, 0, 1, "mostWantedBoard");
  wait 0.55;
  level.player _meth_823B(var_2, "tag_player");
  level.player thread _id_BBAD(var_2, var_1);
  _id_BBAA(var_2);
}

update_currently_selected_card(var_0) {
  var_1 = "";
  var_2 = "top";
  var_3 = level._id_BBA5._id_37B6;
  level endon("most_wanted_board_exit");

  for(;;) {
    var_4 = getDvar("ui_most_wanted_selection");

    if(var_1 != var_4) {
      var_1 = var_4;
      level._id_BBA5._id_1624 scripts\sp\utility::_id_9193("mostWantedBoard");
      level._id_BBA5._id_1624 = level._id_BBA5._id_3A55[var_4];
      level._id_BBA5._id_1624 scripts\sp\utility::_id_9196(1, 0, 1, "mostWantedBoard");
      setomnvar("ui_most_wanted_board_current_tag", level._id_BBA5._id_3A55[var_4].tag);

      if(level._id_BBA5.is_zoomed_in) {
        var_5 = level._id_BBA5._id_1624;
        var_6 = var_5.origin + anglesToForward(var_3.angles) * -16 + anglestoright(var_3.angles) * 7 + anglestoup(var_3.angles) * -64;
        var_0 moveTo(var_6, 0.35, 0.125, 0.125);
      } else if(level._id_BBA5._id_1624._id_A534 != var_2) {
        var_2 = level._id_BBA5._id_1624._id_A534;
        var_0 moveTo(var_3._id_D6AD[var_2], 0.35, 0.125, 0.125);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_BBAD(var_0, var_1) {
  level endon("most_wanted_board_exit");
  setomnvar("ui_most_wanted_board", 1);
  level._id_BBA5.is_zoomed_in = 0;
  var_1 = level._id_BBA5._id_37B6;
  level thread update_currently_selected_card(var_0);

  if(!isDefined(level._id_EFF5) || !level._id_EFF5) {
    scripts\sp\utility::_id_56BA("most_wanted_tutorial");
    level thread scripts\engine\utility::flag_set_delayed("most_wanted_tutorial_shown", 8);
    level._id_EFF5 = 1;
    level.player _meth_84C7("scTaughtWantedBoard", 1);
  }

  for(;;) {
    level.player waittill("luinotifyserver", var_2);

    if(var_2 == "activate") {
      scripts\engine\utility::flag_set("most_wanted_tutorial_shown");
      level._id_BBA5.is_zoomed_in = 1;
      var_3 = level._id_BBA5._id_1624;
      var_4 = var_3.origin + anglesToForward(var_1.angles) * -16 + anglestoright(var_1.angles) * 7 + anglestoup(var_1.angles) * -64;
      var_0 moveTo(var_4, 0.35, 0.125, 0.125);
      continue;
    }

    if(var_2 == "deactivate") {
      level._id_BBA5.is_zoomed_in = 0;
      var_3 = level._id_BBA5._id_1624;
      var_0 moveTo(var_1._id_D6AD[var_3._id_A534], 0.35, 0.125, 0.125);
    }
  }
}

_id_BBAA(var_0) {
  for(;;) {
    level.player waittill("luinotifyserver", var_1);

    if(var_1 == "most_wanted_board_exit") {
      level notify(var_1);
      break;
    }
  }

  scripts\engine\utility::flag_set("most_wanted_tutorial_shown");
  setomnvar("ui_most_wanted_board", 0);
  scripts\sp\utility::_id_9199("mostWantedBoard", 0);
  level._id_BBA5._id_1624 scripts\sp\utility::_id_9193("mostWantedBoard");
  var_2 = level._id_BBA5._id_6964;
  var_0 moveTo(var_2.origin, 0.75, 0.25, 0.25);
  wait 0.9;
  level.player unlink();
  var_0 delete();
  level thread _id_BBA6();
}

_id_BBAE(var_0) {
  var_1 = level._id_D9E5["wanted_cards"][var_0];

  switch (var_1) {
    case "obtained":
      level._id_D9E5["wanted_cards"][var_0] = "viewed";
      return 1;
    case "intelObtained_1":
      level._id_D9E5["wanted_cards"][var_0] = "intelViewed_1";
      return 1;
    case "intelObtained_2":
      level._id_D9E5["wanted_cards"][var_0] = "intelViewed_2";
      return 1;
    case "intelObtained_3":
      level._id_D9E5["wanted_cards"][var_0] = "intelViewed_3";
      return 1;
    case "intelObtained_4":
      level._id_D9E5["wanted_cards"][var_0] = "intelViewed_4";
      return 1;
  }

  return 0;
}

_id_BBAB() {
  var_0 = [];
  var_0["r_hudoutlineWidth"] = 4;
  var_0["cg_hud_outline_colors_2"] = "0.86 0.043 0.043 0.650";
  return var_0;
}

_id_C60C() {
  scripts\engine\utility::flag_set("computer_started");
  setomnvar("ui_loadouts_menu_disabled", 1);
  setDvar("leave_menu", 0);
  _id_448D("off");
  level thread _id_1365B();

  if(isDefined(level._id_3A2D)) {
    setsaveddvar("bg_cinematicAboveUI", "1");
    setsaveddvar("bg_cinematicFullScreen", "0");
    setsaveddvar("bg_cinematicCanPause", "0");
    level._id_3A2D show();
    cinematicingame("sc_world_capops_boot");

    while(!iscinematicplaying()) {
      wait 0.05;
    }

    wait 1.75;
    setomnvar("ui_terminal_invoke", 1);

    while(iscinematicplaying()) {
      wait 0.05;
    }

    stopcinematicingame();
    level._id_3A2D hide();
  } else
    setomnvar("ui_terminal_invoke", 1);

  if(isDefined(level._id_3A2E)) {
    childthread _id_9962();
  }

  for(;;) {
    if(getdvarint("leave_menu") == 1) {
      break;
    }

    wait 0.05;
  }

  setDvar("leave_menu", 0);
  level thread _id_39FC();
  level notify("stop_capops_intel");
  _id_4273();
  level._id_448C notify("closed_menu");
  level thread _id_4489();
  setDvar("query_music_play", 0);
  setDvar("query_video_play", 0);
  _id_10FB4();
  level._id_1FBD notify("stop_loop");
  level.player scripts\sp\utility::_id_F526("safe");
  level._id_EFED = "inside";
  setsaveddvar("bg_cinematicAboveUI", "0");
  var_0 = getsticksconfig();

  if(isDefined(level.console) && level.console && !issubstr(var_0, "southpaw")) {
    level.player lerpviewangleclamp(1.0, 0.5, 0.5, 0, 0, 0, 0);
    level.player _meth_8391(1.0);
  }

  level._id_1FBD thread scripts\sp\anim::_id_1F35(level._id_3A2C, "computer_exit");
  level._id_1FBD scripts\sp\anim::_id_1F35(level._id_CFB9, "computer_exit", "tag_player");
  level.player unlink();
  level._id_CFB9 delete();

  for(;;) {
    var_1 = scripts\sp\utility::_id_D1DF(level._id_448C._id_99FC.origin, 0.5, 1);

    if(!var_1) {
      break;
    }

    wait 0.05;
  }

  level thread _id_448C();
}

_id_4489() {
  if(isDefined(level._id_3A2D)) {
    setomnvar("ui_terminal_invoke", 0);
    stopcinematicingame();
    wait 0.05;
    setsaveddvar("bg_cinematicFullScreen", "0");
    setsaveddvar("bg_cinematicCanPause", "0");
    level._id_3A2D show();
    cinematicingame("sc_world_capops_boot");

    while(!iscinematicplaying()) {
      wait 0.05;
    }

    while(iscinematicplaying()) {
      wait 0.05;
    }

    stopcinematicingame();
    level._id_3A2D hide();
  } else
    setomnvar("ui_terminal_invoke", 0);

  _id_448D("on");
}

_id_1365B() {
  wait 1.0;
  setomnvar("ui_loadouts_menu_disabled", 0);
}

_id_9962() {
  level endon("stop_capops_intel");
  var_0 = undefined;
  var_1 = undefined;
  var_2 = "";

  for(;;) {
    level.player waittill("luinotifyserver", var_3, var_4);
    var_1 = undefined;
    _id_4273();
    var_5 = undefined;
    var_0 = var_3;

    if(issubstr(var_3, "news")) {
      var_1 = 1;
    }

    if(!issubstr(var_3, "tab")) {
      if(var_3 != var_2) {
        thread _id_CD49(var_1, var_0, var_4);
        var_2 = var_3;
      } else
        var_2 = "";
    }

    if(issubstr(var_3, "tab")) {
      var_2 = "";
    }

    wait 0.05;
  }
}

_id_CD49(var_0, var_1, var_2) {
  level notify("stop_intel_bink");
  level endon("stop_intel_bink");
  setomnvar("ui_capops_playback_bar", 0.0);
  thread _id_994F(var_1, var_2);
  var_3 = undefined;
  setomnvar("ui_capops_is_audio", 0);

  if(isDefined(var_0) && var_0) {
    var_3 = level._id_3A2F;
  } else {
    var_3 = level._id_3A2E;
  }

  if(issubstr(var_1, "news") || issubstr(var_1, "kotch") || issubstr(var_1, "hvt")) {
    var_3 show();
    setomnvar("ui_capops_is_audio", 0);
  } else
    setomnvar("ui_capops_is_audio", 1);

  stopcinematicingame();
  wait 0.05;
  setsaveddvar("bg_cinematicAboveUI", "1");
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  wait 0.05;
  cinematicingame(var_1);

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  while(iscinematicplaying()) {
    wait 0.05;
  }

  var_3 hide();
  setomnvar("ui_capops_is_audio", 0);
}

_id_994F(var_0, var_1) {
  level endon("stop_intel_bink");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  setomnvar("ui_capops_playback_bar", 0.0);
  wait 0.05;

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  var_2 = tablelookupbyrow("sp/capcomp_intel.csv", var_1, 8);
  var_2 = float(var_2);
  var_3 = 0.0;

  while(iscinematicplaying()) {
    var_4 = cinematicgettimeinmsec() / 1000;
    var_5 = var_4 / var_2;
    setomnvar("ui_capops_playback_bar", var_5);
    wait 0.05;
  }

  setomnvar("ui_capops_playback_bar", 1.0);
}

_id_4273() {
  stopcinematicingame();
  wait 0.05;
  setsaveddvar("bg_cinematicAboveUI", "0");
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "0");

  if(isDefined(level._id_3A2F)) {
    level._id_3A2F hide();
    level._id_3A2E hide();
    stopFXOnTag(scripts\engine\utility::getfx("vfx_soundbar"), level._id_3A30, "tag_origin");
  }
}

_id_6736() {
  self endon("closed_menu");
  level.player waittill("escape_video");
  level._id_448C._id_6735 = 1;
}

_id_CDA5() {
  self endon("closed_menu");
  var_0 = undefined;

  for(;;) {
    level.player waittill("luinotifyserver", var_0);

    if(var_0 == "play_music") {
      _id_10FB4();
      var_1 = spawn("script_origin", level._id_448C._id_99FC.origin);
      var_1 playSound("mus_shipcrib_titan_old_captain");
      setDvar("query_music_play", 0);
    }

    scripts\engine\utility::waitframe();
  }
}

_id_10FB4() {
  level.player stoplocalsound("mus_shipcrib_titan_old_captain");
  stopcinematicingame();
  level._id_448C._id_6735 = 0;
}

_id_448A() {
  var_0 = ["yardReport", "marsReport", "heistReport", "prisonerReport", "rogueReport", "titanReport", "europaReport", "moon_portReport", "pearlharborReport", "sa_assassinationReport", "sa_empambushReport", "sa_vipsReport", "sa_woundedReport", "sa_moonReport", "ja_spacestationReport", "ja_asteroidReport", "ja_miningReport", "ja_titanReport", "ja_wreckageReport"];
  var_1 = ["audiologOmar", "audiologBrooks", "audiologKash", "audiologSalter", "audiologBoats", "audiologGator", "audiologGator2", "audiologDrops", "audiologMac", "audiologAlders", "audiologRaines", "audiologReyes", "audiologEthan", "audiologFerran", "audiologGibson", "audiologGriff", "audiologGriff2", "kotchVideo", "hvtUpdate1", "hvtUpdate2", "hvtUpdate3", "hvtUpdate4"];
  var_2 = ["personnelEthan1", "personnelMac1", "personnelGator1", "personnelOmar1", "personnelFerran1", "personnelAirboss1", "personnelGriff1", "personnelBrooks1", "personnelKashima1", "personnelBoats", "personnelDO1", "personnelKloos", "personnelBoggs1", "personnelComms1", "personnelAlder", "personnelJack1", "personnelChaplain1"];
  var_3 = ["personnelEthan2", "personnelMac2", "personnelGator2", "personnelGriff2", "personnelBrooks2", "personnelAirboss2", "personnelKashima2", "personnelDO2", "personnelBoggs2", "personnelComms2", "personnelJack2", "personnelAlder", "personnelChaplain1", "personnelKotch2"];
  var_4 = ["personnelKotch1", "personnelKotch2", "personnelHVT1", "personnelHVT2", "personnelHVT3", "personnelHVT4", "personnelReyes2", "personnelSalter2", "personnelOmar1", "personnelOmar2", "personnelFerran2", "personnelReyes1", "personnelSalter1", "personnelBoggs2", "personnelEthan2", "personnelMac2", "personnelDO2", "personnelAirboss2", "personnelGriff2", "personnelBrooks2", "personnelKashima2", "personnelBoggs2", "personnelComms2", "personnelJack2", "personnelGator2"];
  level._id_448C._id_BF09 = undefined;
  var_5 = [];
  var_6 = [];
  var_7 = [];

  switch (level.script) {
    case "shipcrib_moon":
      var_5 = ["audiologAlders", "audiologRaines", "audiologSalter", "audiologGriff2", "audiologGator"];
      var_6 = var_2;
      var_7 = ["pearlharborReport", "europaReport"];
      var_0 = _id_12BD2(var_7, var_0, "captainComputerMissionState");
      var_1 = _id_12BD2(var_5, var_1, "captainComputerAudioState");
      var_2 = _id_12BD2(var_6, var_2, "captainComputerPersonnelState");
      _id_F576(var_0, "captainComputerMissionState");
      _id_F576(var_1, "captainComputerAudioState");
      _id_F576(var_2, "captainComputerPersonnelState");
      _id_39FA("personnelHVT1", undefined, "captainComputerPersonnelState");
      _id_39FA("personnelKotch1", undefined, "captainComputerPersonnelState");
      _id_39FA("personnelReyes1", undefined, "captainComputerPersonnelState");
      _id_39FA("personnelSalter1", undefined, "captainComputerPersonnelState");
      level.player _meth_84C7("captainComputerAudioState", "audiologOmar", "locked");
      level.player _meth_84C7("captainComputerAudioState", "audiologFerran2", "locked");
      break;
    case "shipcrib_europa":
      var_5 = ["audiologAlders", "audiologRaines", "kotchVideo", "hvtUpdate1", "audiologSalter", "audiologGriff2", "audiologGator"];
      var_6 = var_2;
      var_7 = ["moon_portReport", "sa_moonReport", "pearlharborReport", "europaReport"];
      var_0 = _id_12BD2(var_7, var_0, "captainComputerMissionState");
      var_1 = _id_12BD2(var_5, var_1, "captainComputerAudioState");
      var_2 = _id_12BD2(var_6, var_2, "captainComputerPersonnelState");
      _id_F576(var_0, "captainComputerMissionState");
      _id_F576(var_1, "captainComputerAudioState");
      _id_F576(var_2, "captainComputerPersonnelState");
      _id_39FA("personnelHVT1", undefined, "captainComputerPersonnelState");
      _id_39FA("personnelKotch1", undefined, "captainComputerPersonnelState");
      _id_39FA("personnelReyes1", undefined, "captainComputerPersonnelState");
      _id_39FA("personnelSalter1", undefined, "captainComputerPersonnelState");
      level.player _meth_84C7("captainComputerAudioState", "audiologOmar", "locked");
      level.player _meth_84C7("captainComputerAudioState", "audiologFerran2", "locked");
      _id_12BD9("moon_port");
      break;
    case "shipcrib_titan":
      var_5 = ["audiologAlders", "audiologRaines", "kotchVideo", "hvtUpdate1", "audiologSalter", "audiologGriff2", "audiologGator"];
      var_6 = var_2;
      var_7 = ["moon_portReport", "sa_moonReport", "pearlharborReport", "europaReport"];
      var_0 = _id_12BD2(var_7, var_0, "captainComputerMissionState");
      var_1 = _id_12BD2(var_5, var_1, "captainComputerAudioState");
      var_2 = _id_12BD2(var_6, var_2, "captainComputerPersonnelState");
      _id_F576(var_0, "captainComputerMissionState");
      _id_F576(var_1, "captainComputerAudioState");
      _id_F576(var_2, "captainComputerPersonnelState");
      _id_39FA("personnelHVT2", undefined, "captainComputerPersonnelState");
      _id_39FA("personnelKotch1", undefined, "captainComputerPersonnelState");
      _id_39FA("personnelReyes1", undefined, "captainComputerPersonnelState");
      _id_39FA("personnelSalter1", undefined, "captainComputerPersonnelState");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelHVT1", "locked");
      level.player _meth_84C7("captainComputerAudioState", "audiologOmar", "locked");
      level.player _meth_84C7("captainComputerAudioState", "audiologFerran2", "locked");
      _id_12BD9("moon_port");
      _id_12BD9("sa_moon");
      break;
    case "shipcrib_rogue":
      var_5 = ["audiologAlders", "audiologRaines", "kotchVideo", "hvtUpdate1", "audiologSalter", "audiologGriff2", "audiologGator", "audiologFerran"];
      var_6 = var_2;
      var_7 = ["moon_portReport", "sa_moonReport", "titanReport", "pearlharborReport", "europaReport"];
      var_0 = _id_12BD2(var_7, var_0, "captainComputerMissionState");
      var_1 = _id_12BD2(var_5, var_1, "captainComputerAudioState");
      var_2 = _id_12BD2(var_6, var_2, "captainComputerPersonnelState");
      _id_F576(var_0, "captainComputerMissionState");
      _id_F576(var_1, "captainComputerAudioState");
      _id_F576(var_2, "captainComputerPersonnelState");
      _id_39FA("personnelHVT3", undefined, "captainComputerPersonnelState");
      _id_39FA("personnelKotch1", undefined, "captainComputerPersonnelState");
      _id_39FA("personnelReyes1", undefined, "captainComputerPersonnelState");
      _id_39FA("personnelSalter1", undefined, "captainComputerPersonnelState");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelHVT1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelHVT2", "locked");
      level.player _meth_84C7("captainComputerAudioState", "audiologOmar", "locked");
      level.player _meth_84C7("captainComputerAudioState", "audiologFerran2", "locked");
      _id_12BD9("moon_port");
      _id_12BD9("sa_moon");
      _id_12BD9("titan");
      break;
    case "shipcrib_prisoner":
      var_5 = ["audiologAlders", "audiologRaines", "kotchVideo", "hvtUpdate1", "audiologSalter", "audiologGriff2", "audiologGator", "audiologFerran", "hvtUpdate4"];
      var_6 = var_2;
      var_7 = ["moon_portReport", "sa_moonReport", "titanReport", "rogueReport", "pearlharborReport", "europaReport"];
      var_0 = _id_12BD2(var_7, var_0, "captainComputerMissionState");
      var_1 = _id_12BD2(var_5, var_1, "captainComputerAudioState");
      var_2 = _id_12BD2(var_6, var_2, "captainComputerPersonnelState");
      _id_F576(var_0, "captainComputerMissionState");
      _id_F576(var_1, "captainComputerAudioState");
      _id_F576(var_2, "captainComputerPersonnelState");
      _id_39FA("personnelHVT3", undefined, "captainComputerPersonnelState");
      _id_39FA("personnelKotch1", undefined, "captainComputerPersonnelState");
      _id_39FA("personnelReyes1", undefined, "captainComputerPersonnelState");
      _id_39FA("personnelSalter1", undefined, "captainComputerPersonnelState");
      _id_39FA("personnelOmar2", undefined, "captainComputerPersonnelState");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelHVT1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelHVT2", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelKotch2", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelOmar1", "locked");
      level.player _meth_84C7("captainComputerAudioState", "audiologOmar", "open");
      _id_12BD9("moon_port");
      _id_12BD9("sa_moon");
      _id_12BD9("titan");
      break;
    case "shipcrib_epilogue":
      foreach(var_9 in var_0) {
        var_10 = strtok(var_9, "_");

        if(var_9 != "sa_moon" && var_10[0] != "sa" && var_10[0] != "ja") {
          level.player _meth_84C7("captainComputerMissionState", var_9, "open");
        }
      }

      foreach(var_9 in var_1) {
        level.player _meth_84C7("captainComputerAudioState", var_9, "open");
      }

      foreach(var_9 in var_3) {
        level.player _meth_84C7("captainComputerPersonnelState", var_9, "open");
      }

      level.player _meth_84C7("captainComputerPersonnelState", "personnelOmar1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelReyes1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelReyes1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelKashima1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelDO1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelGator1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelMac1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelGriff1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelEthan1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelBoggs1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelJack1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelBrooks1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelFerran1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelAirboss1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelComms1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelHVT1", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelHVT2", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelHVT3", "locked");
      level.player _meth_84C7("captainComputerPersonnelState", "personnelKotch1", "locked");
      _id_12BD9("moon_port");
      _id_12BD9("sa_moon");
      _id_12BD9("titan");
      break;
  }

  _id_12BDB();
  level._id_448C._id_BF09 = 1;
}

_id_12BD2(var_0, var_1, var_2) {
  var_3 = var_1;

  foreach(var_5 in var_0) {
    _id_39FA(var_5, var_3, var_2);
    var_3 = scripts\engine\utility::array_remove(var_3, var_5);
  }

  return var_3;
}

_id_12BDB() {
  var_0 = ["sa_assassination", "sa_empambush", "sa_vips", "sa_wounded", "sa_moon", "ja_spacestation", "ja_asteroid", "ja_mining", "ja_titan", "ja_wreckage"];

  foreach(var_2 in var_0) {
    var_3 = level.player _meth_84C6("missionStateData", var_2);

    if(isDefined(var_3) && var_3 == "complete") {
      var_4 = var_2 + "Report";
      var_5 = level.player _meth_84C6("captainComputerMissionState", var_4);

      if(isDefined(var_5) && var_5 == "locked") {
        level.player _meth_84C7("captainComputerMissionState", var_4, "open");
      }

      _id_12BD9(var_2);
    }
  }
}

_id_12BD9(var_0) {
  var_1 = ["newsVideo1", "newsVideo2", "newsVideo3", "newsVideo4", "newsVideo5", "newsVideo6", "newsVideo7"];
  var_2 = undefined;

  switch (var_0) {
    case "moon_port":
      var_2 = 0;
      break;
    case "sa_moon":
      var_2 = 1;
      break;
    case "titan":
      var_2 = 2;
      break;
    case "sa_assasination":
      var_2 = 3;
      break;
    case "sa_empambush":
      var_2 = 4;
      break;
    case "sa_vips":
      var_2 = 5;
      break;
    case "sa_wounded":
      var_2 = 6;
      break;
  }

  if(isDefined(var_2)) {
    var_3 = level.player _meth_84C6("captainComputerAudioState", var_1[var_2]);

    if(isDefined(var_3)) {
      var_4 = level.player _meth_84C6("scNewsReels", var_1[var_2]);

      if(isDefined(var_4) && var_4 == "watched") {
        level.player _meth_84C7("captainComputerAudioState", var_1[var_2], "open");
      }
    }
  }
}

_id_39FA(var_0, var_1, var_2) {
  var_3 = level.player _meth_84C6(var_2, var_0);

  if(!isDefined(var_3) || var_3 == "locked") {
    level.player _meth_84C7(var_2, var_0, "open");
  }
}

_id_F576(var_0, var_1) {
  foreach(var_3 in var_0) {
    level.player _meth_84C7(var_1, var_3, "locked");
  }
}

_id_2FF7() {
  if(isDefined(level._id_BBA5._id_BF09)) {
    level scripts\sp\utility::_id_914C("fluff_messages_sdf1", "fluff_messages_sdf1_body", "sdf_intel_1", level._id_BBA5._id_99FD.origin);
    level._id_BBA5._id_BF09 = undefined;
  } else if(isDefined(level._id_448C._id_BF09)) {
    level scripts\sp\utility::_id_914C("fluff_messages_capops", "fluff_messages_capops_body", "capops_intel", level._id_448C._id_99FC.origin);
    level._id_448C._id_BF09 = undefined;
  }
}