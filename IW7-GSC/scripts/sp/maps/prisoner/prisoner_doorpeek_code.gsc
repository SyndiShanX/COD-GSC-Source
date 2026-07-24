/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\prisoner\prisoner_doorpeek_code.gsc
***************************************************************/

_id_D5F9(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon(var_0 + "door_peek_finished");
  level endon(var_0 + "door_peek_restarted");

  if(!scripts\engine\utility::flag_exist(var_0 + "door_peek_handle_down")) {
    scripts\engine\utility::flag_init(var_0 + "door_peek_handle_down");
  }

  if(!scripts\engine\utility::flag_exist(var_0 + "did_kick_interrupt_input")) {
    scripts\engine\utility::flag_init(var_0 + "did_kick_interrupt_input");
  }

  thread _id_D5FB(var_0, var_1, var_2, var_3, var_4, var_5);
  level waittill(var_0 + "door_peek_start");

  while(level.player useButtonPressed()) {
    wait 0.05;
  }

  thread _id_59A1(var_0);
  level._id_CA00 = scripts\sp\hud_util::createfontstring("objective", 0.7);
  level._id_CA00 scripts\sp\hud_util::setpoint("CENTER", "CENTER", 0, -80);
  level._id_CA00 settext("L-Stick Peek");
  level._id_C9FA = scripts\sp\hud_util::createfontstring("objective", 0.7);
  level._id_C9FA scripts\sp\hud_util::setpoint("CENTER", "CENTER", 0, -60);
  level._id_C9FA settext("^3[{+activate}]^7 Kick");
  thread _id_59D1(var_0);
  scripts\engine\utility::flag_wait(var_0 + "did_kick_interrupt_input");
  scripts\engine\utility::flag_wait(var_0 + "door_peek_handle_down");
  level notify(var_0 + "door_peek_kick");
  scripts\engine\utility::waitframe();

  if(isDefined(var_1)) {
    thread _id_D5F6(var_0, 1);
  } else {
    thread _id_D5F6(var_0);
  }
}

_id_D5F7(var_0) {
  level endon(var_0 + "door_peek_finished");
  level endon(var_0 + "door_peek_restarted");
  level endon(var_0 + "door_peek_kick");
  level endon(var_0 + "door_peek_back_off");
  level endon(var_0 + "door_peek_sprint");
  var_1 = scripts\engine\utility::getStruct("hvr_finale_anim_origin", "targetname");
  var_2 = angleclamp180(self.angles[1]);

  for(;;) {
    scripts\engine\utility::waitframe();
  }
}

_id_D5FB(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon(var_0 + "door_peek_kick");
  level endon(var_0 + "door_peek_back_off");
  level endon(var_0 + "door_peek_sprint");
  var_6 = getEntArray(var_0, "targetname");
  var_6 = scripts\engine\utility::array_combine(var_6, scripts\engine\utility::getStructArray(var_0, "targetname"));
  var_7 = _id_7C3A(var_6, "door_kick_door");
  var_8 = var_7._id_EE52;
  var_7 scripts\sp\utility::_id_23B7("doorpeek_01_door");
  var_9 = _id_7C3A(var_6, "door_kick_animstruct");
  level._id_5A25 = var_9 scripts\engine\utility::spawn_tag_origin();
  level.player._id_59FF = var_7 scripts\engine\utility::spawn_tag_origin();
  level.player._id_59FF.angles = var_9.angles + (0, 180, 0);
  var_7 linkTo(level.player._id_59FF);
  var_10 = var_7.angles;
  level._id_5A24 = var_7.angles;
  var_11 = _id_7C3A(var_6, "door_kick_clip");
  var_11 linkTo(var_7);
  var_12 = _id_7C3A(var_6, "door_kick_interact");
  var_12 _id_0E46::_id_48C5(undefined, (0, 0, 0), 0, undefined, 1024);
  var_12 _id_0E46::_id_9016();
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  thread _id_59D6(var_0, var_7, var_10, var_11);
  thread _id_59CA(var_0);

  if(!isDefined(var_1)) {
    thread _id_D5FA(var_0, var_7, var_10, var_11);
    thread _id_D5F5(var_0, var_7, var_10, var_11, level._id_5A25);
  }

  level notify(var_0 + "door_peek_start");
  _id_59CE();

  if(!scripts\engine\utility::flag_exist(var_0 + "door_peek_handle_down")) {
    scripts\engine\utility::flag_init(var_0 + "door_peek_handle_down");
  }

  if(!scripts\engine\utility::flag(var_0 + "door_peek_handle_down")) {
    level.player._id_C9FD = scripts\sp\utility::_id_10639("player_rig", level.player._id_59FF.origin, level.player._id_59FF.angles);
    level.player._id_C9FD hide();
    level.player._id_C9FD scripts\engine\utility::delaycall(0.4, ::show);
    level.player._id_C9FD linkTo(level.player._id_59FF);
    level.player forceplaygestureviewmodel("ges_doorpeek_bulkhead");
    var_7 thread scripts\sp\anim::_id_1F35(var_7, "doorpeek_in");
    level.player._id_59FF thread scripts\sp\anim::_id_1F35(level.player._id_C9FD, "doorpeek_01_in");
    level.player scripts\engine\utility::delaycall(0.15, ::_meth_823C, level.player._id_C9FD, "tag_player", 0.4, 0.0, 0.1);
    wait 0.9;
    scripts\engine\utility::flag_set(var_0 + "door_peek_handle_down");
    level notify(var_0 + "door_handle_down");
    level notify("door_handle_down");
  }

  var_13 = 0.7;
  level.player playerlinktodelta(level.player._id_C9FD, "tag_player", 1, 13, 0, 20, 20, 0);
  level.player._id_59FF rotateby((0, -12, 0), var_13, 0.05, 0.05);
  var_7 playSound("doorpeek_bulkhead_crack_open");
  wait(var_13);
  level notify(var_0 + "door_peek_start_peek_control");
  level.player scripts\engine\utility::allow_offhand_weapons(1);
  level._id_5A21 = 0;
  var_14 = 0;
  var_15 = 0;
  var_16 = 1;
  var_17 = level.player._id_59FF.angles;
  var_18 = 0;
  var_19 = 0;

  while(level._id_5A21 < 80.0) {
    var_19 = 0;
    var_20 = _id_794E(var_7, level._id_5A25);
    var_21 = var_20 * 1.2;

    if(var_15 == 1.0 && var_20 == 1.0) {
      var_21 = var_21 * 1.01 * scripts\sp\utility::_id_E753(var_16, 0, 1);
      var_16 = var_16 + 0.5;
    } else
      var_16 = 1;

    var_21 = clamp(var_21, -4.0, 4.0);
    level._id_5A21 = max(level._id_5A21 + var_21, 0.0);
    level._id_5A21 = scripts\sp\utility::_id_E753(level._id_5A21, 1);

    if(isDefined(var_1)) {
      level._id_5A21 = min(level._id_5A21 + var_21, var_1);
    }

    if(level._id_5A21 != var_14) {
      var_19 = 1;

      if(var_18 == 0) {
        var_7 playSound("doorpeek_bulkhead_move_start");
        var_7 playLoopSound("doorpeek_bulkhead_move_loop");
      }

      level.player._id_59FF rotateTo(var_17 + (0, 0.0 - level._id_5A21, 0), 0.1, 0.0, 0.0);
      var_22 = 0;
      var_23 = 140;
      var_24 = level._id_5A21 / 80.0 * (var_23 - var_22) + var_22;
      level.player playerlinktodelta(level.player._id_C9FD, "tag_player", 1, 13, var_24, 20, 20, 0);

      if(isDefined(var_1) && level._id_5A21 == var_1) {
        wait 0.1;
        var_7 playSound("doorpeek_bulkhead_blocked");
        level notify(var_0 + "door_peek_blocked");
        level notify("door_peek_blocked");
      }
    } else if(var_18) {
      var_7 stoploopsound("doorpeek_bulkhead_move_loop");
      var_7 playSound("doorpeek_bulkhead_move_stop");
    }

    var_14 = level._id_5A21;
    var_15 = var_20;
    var_18 = var_19;
    wait 0.05;
  }

  if(isDefined(var_5) && var_5) {
    level notify(var_0 + "door_peek_finished");
    level.player._id_C9FD delete();
    level.player._id_59FF delete();
  } else {
    var_25 = 0.15;
    var_7 unlink();
    level.player._id_59FF linkTo(var_7);
    var_7 rotateTo(var_10 + (0, -140, 0), var_25, 0.0, 0.0);
    var_11 connectpaths();
    var_11 scripts\engine\utility::delaycall(var_25 + 0.05, ::disconnectpaths);
    var_7 playSound("doorpeek_bulkhead_swing_open");
    var_7 scripts\engine\utility::delaycall(var_25, ::playsound, "doorpeek_bulkhead_hit_wall");
    thread _id_D5F8(var_0, var_7);
  }

  level notify(var_0 + "door_peek_opened_fully");
  level notify(var_0 + "door_kick_newdoor_think");
  level notify(var_0 + "door_peek_finished");
}

_id_D5F6(var_0, var_1) {
  level endon(var_0 + "door_kick_newdoor_think");
  var_2 = getEntArray(var_0, "targetname");
  var_2 = scripts\engine\utility::array_combine(var_2, scripts\engine\utility::getStructArray(var_0, "targetname"));
  var_3 = _id_7C3A(var_2, "door_kick_door");
  var_4 = _id_7C3A(var_2, "door_kick_clip");
  var_4 linkTo(var_3);
  var_5 = _id_7C3A(var_2, "door_kick_animstruct");
  var_6 = var_5 scripts\engine\utility::spawn_tag_origin();
  var_7 = var_3 scripts\engine\utility::spawn_tag_origin();
  var_7.angles = var_6.angles;
  level notify(var_0 + "door_kick_start");
  _id_59CE();
  thread _id_D5F8(var_0, var_3, 1);
  var_8 = var_6 _id_12A0(-60, -20, 0);
  var_9 = level.player scripts\engine\utility::spawn_tag_origin();
  level.player playerlinktodelta(var_9, "tag_origin", 1, 10, 10, 10, 10, 0);
  var_9 moveTo(var_8, 0.25);
  var_9 rotateTo((var_9.angles[0], var_5.angles[1], var_9.angles[2]), 0.3);
  wait 0.3;
  var_10 = 0.5;
  var_11 = 0.35;
  var_3 scripts\engine\utility::delaycall(var_10, ::rotateto, level._id_5A24 + (0, -140, 0), var_11, 0.0, 0.05);
  var_4 scripts\engine\utility::delaycall(var_10, ::connectpaths);
  var_4 scripts\engine\utility::delaycall(var_10 + var_11 + 0.05, ::disconnectpaths);
  var_3 scripts\engine\utility::delaycall(var_10, ::playsound, "doorpeek_bulkhead_kick");
  level thread scripts\sp\utility::_id_C12D(var_0 + "door_kick_open", var_10);
  level thread scripts\sp\utility::_id_C12D("door_kick_open", var_10);
  var_12 = var_6 _id_12A0(-40, -20, -10);
  var_13 = var_6 _id_12A0(-20, -20, 0);
  var_9 moveTo(var_12, 0.4);
  wait 0.4;
  var_9 moveTo(var_13, 0.2);
  wait 0.2;

  if(isDefined(var_1)) {
    var_14 = var_6 _id_12A0(-120, -20, 0);
    var_9 moveTo(var_14, 0.7);
    wait 0.7;
  }

  level notify(var_0 + "stop_fake_origin_link");
  level notify(var_0 + "door_kick_finished");
  var_9.origin = getgroundposition(var_9.origin, 10, 30, 30);
  wait 0.05;
  var_9 delete();
  level.player unlink();
  _id_59CD();
  level notify(var_0 + "door_kick_newdoor_think");
}

_id_D5F5(var_0, var_1, var_2, var_3, var_4) {
  level endon(var_0 + "door_peek_kick");
  level endon(var_0 + "door_peek_opened_fully");
  level endon(var_0 + "door_peek_sprint");
  level waittill(var_0 + "door_peek_start_peek_control");
  var_5 = 0;
  var_6 = 0;

  for(;;) {
    var_7 = _id_794E(var_1, var_4);

    if(var_5 < -0.5 && var_7 < -0.5) {
      var_6++;
    } else {
      var_6 = 0;
    }

    if(var_6 >= 5) {
      break;
    }

    var_5 = var_7;
    wait 0.05;
  }

  level notify(var_0 + "door_peek_back_off");
  thread _id_D5F8(var_0, var_1);
  thread _id_59D3(var_1, var_2, var_3);
}

_id_D5FA(var_0, var_1, var_2, var_3) {
  level endon(var_0 + "door_peek_kick");
  level endon(var_0 + "door_peek_opened_fully");
  level endon(var_0 + "door_peek_back_off");
  level waittill(var_0 + "door_peek_start_peek_control");

  for(;;) {
    if(level.player issprinting()) {
      break;
    }

    wait 0.05;
  }

  level notify(var_0 + "door_peek_sprint");
  thread _id_D5F8(var_0, var_1);
  var_4 = 0.6;
  var_1 rotateTo(var_2 + (0, -140, 0), var_4, 0.0, 0.0);
  var_3 connectpaths();
  var_3 scripts\engine\utility::delaycall(var_4 + 0.05, ::disconnectpaths);
}

_id_D5F8(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  level.player stopgestureviewmodel("ges_doorpeek_bulkhead");
  level notify(var_0 + "door_peek_finished");
  level notify("door_peek_finished");
  level.player unlink();
  var_3 = undefined;

  if(!var_2) {
    var_3 = level.player scripts\engine\utility::spawn_tag_origin();
    level.player playerlinktodelta(var_3, "tag_origin", 1, 90, 90, 90, 90, 0);
  }

  _id_59CD();
  level.player._id_C9FD delete();
  level.player._id_59FF delete();
  var_4 = scripts\sp\utility::_id_10639("player_rig", level.player.origin, level.player.angles);
  var_5 = (0, 0, 0);
  var_6 = (0, 0, 0);
  var_4 _meth_81E2(level.player, "tag_origin", (0, 0, 0) + var_5, var_6, 0);
  var_4 thread scripts\sp\anim::_id_1F35(var_4, "doorpeek_01_out_b");
  level notify(var_0 + "door_peek_detach");
  var_4 delete();
  level.player unlink();
}

_id_59A6() {
  level endon("door_kick_newdoor_think");
  var_0 = getEnt("door_kick_door", "targetname");
  var_1 = getEnt("door_kick_clip", "targetname");
  var_1 linkTo(var_0);
  var_2 = scripts\engine\utility::getStruct("door_kick_animstruct", "targetname");
  var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
  var_4 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_4.angles = var_3.angles;
  var_5 = scripts\engine\utility::getStruct("door_kick_interact", "targetname");
  var_5 _id_0E46::_id_48C4(undefined, (0, 0, 0), 0, undefined, 1024);
  var_5 waittill("trigger");
  level notify("door_kick_start");
  _id_BF1E();
  var_6 = scripts\sp\utility::_id_10639("player_rig", level.player.origin, level.player.angles);
  var_6 hide();
  var_6 scripts\engine\utility::delaycall(0.4, ::show);
  var_4 thread scripts\sp\anim::_id_1F35(var_6, "door_left_push");
  level.player _meth_823C(var_6, "tag_player", 0.5, 0.0, 0.1);
  wait 1.2;
  level.player unlink();
  var_6 delete();
  var_7 = scripts\sp\utility::_id_10639("headless_fullbody_rig", var_3.origin, var_3.angles);
  var_7 hide();
  var_3 thread scripts\sp\anim::_id_1EC3(var_7, "door_kick_in");
  var_8 = level.player scripts\engine\utility::spawn_tag_origin();
  level.player _meth_823B(var_8);
  var_9 = 1.2;
  var_10 = 0.3;
  var_11 = 0.5;
  var_12 = 0.4;
  var_8 moveTo(var_7 gettagorigin("j_head") - (0, 0, 60), var_9);
  var_13 = var_3.angles + (0, 90, 0);
  var_8 rotateTo(var_13, var_10, 0.0, 0.15);
  var_8 scripts\engine\utility::delaycall(var_10 + var_11, ::rotateto, var_3.angles, var_12, 0.0, 0.1);
  level.player scripts\sp\utility::_id_F526("relaxed");
  level.player scripts\sp\utility::_id_D090("ges_on_me_this_way", var_0);
  wait(var_9);
  var_8 thread _id_6B50(var_7, "j_head", (0, 0, -60));
  var_14 = 2.0;
  var_15 = 0.35;
  var_0 scripts\engine\utility::delaycall(var_14, ::rotateby, (0, -180, 0), var_15, 0.0, 0.05);
  var_1 scripts\engine\utility::delaycall(var_14, ::connectpaths);
  var_1 scripts\engine\utility::delaycall(var_14 + var_15, ::disconnectpaths);
  var_0 scripts\engine\utility::delaycall(var_14, ::playsound, "int_metal_door_kick");
  var_3 scripts\engine\utility::delaycall(var_14, ::moveto, var_3.origin - anglesToForward(var_3.angles) * 100, 0.7, 0.2, 0.2);
  level.player scripts\engine\utility::delaythread(2.5, scripts\sp\utility::_id_F526, "normal");
  level thread scripts\sp\utility::_id_C12D("door_kick_open", 2.0);
  var_7 linkTo(var_3);
  var_3 scripts\sp\anim::_id_1F35(var_7, "door_kick_in");
  level notify("stop_fake_origin_link");
  level notify("door_kick_finished");
  var_7 delete();
  var_8.origin = getgroundposition(var_8.origin, 10, 30, 30);
  wait 0.05;
  var_8 delete();
  level.player unlink();
  _id_BF1D();
  level notify("door_kick_newdoor_think");
}

_id_59A0(var_0, var_1) {
  level endon(var_0 + "door_kick_newdoor_think");
  var_2 = getEntArray(var_0, "targetname");
  var_2 = scripts\engine\utility::array_combine(var_2, scripts\engine\utility::getStructArray(var_0, "targetname"));
  var_3 = _id_7C3A(var_2, "door_kick_door");
  var_4 = _id_7C3A(var_2, "door_kick_clip");
  var_4 linkTo(var_3);
  var_5 = _id_7C3A(var_2, "door_kick_animstruct");
  var_6 = var_5 scripts\engine\utility::spawn_tag_origin();
  var_7 = var_3 scripts\engine\utility::spawn_tag_origin();
  var_7.angles = var_6.angles;
  level notify(var_0 + "door_kick_start");
  _id_59CE();
  thread _id_59C5(var_0, var_3, 1);
  var_8 = var_6 _id_12A0(-60, -20, 0);
  var_9 = level.player scripts\engine\utility::spawn_tag_origin();
  level.player playerlinktodelta(var_9, "tag_origin", 1, 10, 10, 10, 10, 0);
  var_9 moveTo(var_8, 0.25);
  var_9 rotateTo((var_9.angles[0], var_5.angles[1], var_9.angles[2]), 0.3);
  wait 0.3;
  var_10 = 0.5;
  var_11 = 0.35;
  var_3 scripts\engine\utility::delaycall(var_10, ::rotateto, level._id_5A24 + (0, -140, 0), var_11, 0.0, 0.05);
  var_4 scripts\engine\utility::delaycall(var_10, ::connectpaths);
  var_4 scripts\engine\utility::delaycall(var_10 + var_11 + 0.05, ::disconnectpaths);
  var_3 scripts\engine\utility::delaycall(var_10, ::playsound, "doorpeek_bulkhead_kick");
  level thread scripts\sp\utility::_id_C12D(var_0 + "door_kick_open", var_10);
  level thread scripts\sp\utility::_id_C12D("door_kick_open", var_10);
  var_12 = var_6 _id_12A0(-40, -20, -10);
  var_13 = var_6 _id_12A0(-20, -20, 0);
  var_9 moveTo(var_12, 0.4);
  wait 0.4;
  var_9 moveTo(var_13, 0.2);
  wait 0.2;

  if(isDefined(var_1)) {
    var_14 = var_6 _id_12A0(-120, -20, 0);
    var_9 moveTo(var_14, 0.7);
    wait 0.7;
  }

  level notify(var_0 + "stop_fake_origin_link");
  level notify(var_0 + "door_kick_finished");
  var_9.origin = getgroundposition(var_9.origin, 10, 30, 30);
  wait 0.05;
  var_9 delete();
  level.player unlink();
  _id_59CD();
  level notify(var_0 + "door_kick_newdoor_think");
}

_id_12A0(var_0, var_1, var_2) {
  var_3 = self.origin + anglesToForward(self.angles) * var_0 + anglestoright(self.angles) * var_1 + anglestoup(self.angles) * var_2;
  return var_3;
}

_id_BF1E() {
  level.player allowfire(0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowmelee(0);
  level.player allowjump(0);
  level.player allowreload(0);
  level.player allowads(0);
  level.player disableoffhandweapons();
  level.player disableweaponpickup();
}

_id_BF1D() {
  level.player allowfire(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowmelee(1);
  level.player allowjump(1);
  level.player allowreload(1);
  level.player allowads(1);
  level.player enableoffhandweapons();
  level.player _meth_80DB();
}

_id_6B50(var_0, var_1, var_2) {
  level endon("stop_fake_origin_link");

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  var_3 = (0, 0, 0);
  var_4 = (0, 0, 0);
  var_5 = scripts\engine\utility::spawn_tag_origin();
  var_5.origin = self.origin + anglestoright(var_0.angles) * var_2[0] + anglesToForward(var_0.angles) * var_2[1] + anglestoup(var_0.angles) * var_2[2];
  var_5 linkTo(var_0);
  thread _id_127F(var_5);

  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }

    var_4 = var_3;
    var_3 = var_5.origin;

    if(var_3 != var_4) {
      self moveTo(var_3, 0.06);
    }

    wait 0.05;
  }
}

_id_127F(var_0) {
  level waittill("stop_fake_origin_link");
  var_0 delete();
}

_id_59DA(var_0, var_1) {
  level endon(var_0 + "door_peek_kick");
  level endon(var_0 + "door_peek_back_off");
  level endon(var_0 + "door_peek_sprint");
  var_2 = getEntArray(var_0, "targetname");
  var_2 = scripts\engine\utility::array_combine(var_2, scripts\engine\utility::getStructArray(var_0, "targetname"));
  var_3 = _id_7C3A(var_2, "door_kick_door");
  var_4 = var_3._id_EE52;
  var_3 scripts\sp\utility::_id_23B7("doorpeek_01_door");
  var_5 = _id_7C3A(var_2, "door_kick_animstruct2");
  level._id_5A25 = var_5 scripts\engine\utility::spawn_tag_origin();
  level.player._id_59FF = var_3 scripts\engine\utility::spawn_tag_origin();
  level.player._id_59FF.angles = var_5.angles + (0, 180, 0);
  var_3 linkTo(level.player._id_59FF);
  var_6 = var_3.angles;
  level._id_5A24 = var_3.angles;
  var_7 = _id_7C3A(var_2, "door_kick_clip");
  var_7 linkTo(var_3);
  var_8 = _id_7C3A(var_2, "door_kick_interact");
  var_8 _id_0E46::_id_48C5(undefined, (0, 0, 0), 0, undefined, 1024);
  var_8 _id_0E46::_id_9016();
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  thread _id_59D6(var_0, var_3, var_6, var_7);
  thread _id_59CA(var_0);

  if(!isDefined(var_1)) {
    thread _id_59D8(var_0, var_3, var_6, var_7);
    thread _id_5984(var_0, var_3, var_6, var_7, level._id_5A25);
  }

  level notify(var_0 + "door_peek_start");
  _id_59CE();

  if(!scripts\engine\utility::flag_exist(var_0 + "door_peek_handle_down")) {
    scripts\engine\utility::flag_init(var_0 + "door_peek_handle_down");
  }

  if(!scripts\engine\utility::flag(var_0 + "door_peek_handle_down")) {
    level.player._id_C9FD = scripts\sp\utility::_id_10639("player_rig", level.player._id_59FF.origin, level.player._id_59FF.angles);
    level.player._id_C9FD hide();
    level.player._id_C9FD scripts\engine\utility::delaycall(0.4, ::show);
    level.player._id_C9FD linkTo(level.player._id_59FF);
    level.player forceplaygestureviewmodel("ges_doorpeek_bulkhead");
    var_3 thread scripts\sp\anim::_id_1F35(var_3, "doorpeek_in");
    level.player._id_59FF thread scripts\sp\anim::_id_1F35(level.player._id_C9FD, "doorpeek_01_in");
    level.player scripts\engine\utility::delaycall(0.15, ::_meth_823C, level.player._id_C9FD, "tag_player", 0.4, 0.0, 0.1);
    wait 0.9;
    scripts\engine\utility::flag_set(var_0 + "door_peek_handle_down");
    level notify(var_0 + "door_handle_down");
    level notify("door_handle_down");
  }

  var_9 = 0.7;
  level.player playerlinktodelta(level.player._id_C9FD, "tag_player", 1, 13, 0, 20, 20, 0);
  level.player._id_59FF rotateby((0, -12, 0), var_9, 0.05, 0.05);
  var_3 playSound("doorpeek_bulkhead_crack_open");
  wait(var_9);
  level notify(var_0 + "door_peek_start_peek_control");
  level.player scripts\engine\utility::allow_offhand_weapons(1);
  level._id_5A21 = 0;
  var_10 = 0;
  var_11 = 0;
  var_12 = 1;
  var_13 = level.player._id_59FF.angles;
  var_14 = 0;
  var_15 = 0;

  while(level._id_5A21 < 80.0) {
    var_15 = 0;
    var_16 = _id_794E(var_3, level._id_5A25);
    var_17 = var_16 * 1.2;

    if(var_11 == 1.0 && var_16 == 1.0) {
      var_17 = var_17 * 1.01 * scripts\sp\utility::_id_E753(var_12, 0, 1);
      var_12 = var_12 + 0.5;
    } else
      var_12 = 1;

    var_17 = clamp(var_17, -4.0, 4.0);
    level._id_5A21 = max(level._id_5A21 + var_17, 0.0);
    level._id_5A21 = scripts\sp\utility::_id_E753(level._id_5A21, 1);

    if(isDefined(var_1)) {
      level._id_5A21 = min(level._id_5A21 + var_17, var_1);
    }

    if(level._id_5A21 != var_10) {
      var_15 = 1;

      if(var_14 == 0) {
        var_3 playSound("doorpeek_bulkhead_move_start");
        var_3 playLoopSound("doorpeek_bulkhead_move_loop");
      }

      level.player._id_59FF rotateTo(var_13 + (0, 0.0 - level._id_5A21, 0), 0.1, 0.0, 0.0);
      var_18 = 0;
      var_19 = 140;
      var_20 = level._id_5A21 / 80.0 * (var_19 - var_18) + var_18;
      level.player playerlinktodelta(level.player._id_C9FD, "tag_player", 1, 13, var_20, 20, 20, 0);

      if(isDefined(var_1) && level._id_5A21 == var_1) {
        wait 0.1;
        var_3 playSound("doorpeek_bulkhead_blocked");
        level notify(var_0 + "door_peek_blocked");
        level notify("door_peek_blocked");
      }
    } else if(var_14) {
      var_3 stoploopsound("doorpeek_bulkhead_move_loop");
      var_3 playSound("doorpeek_bulkhead_move_stop");
    }

    var_10 = level._id_5A21;
    var_11 = var_16;
    var_14 = var_15;
    wait 0.05;
  }

  var_21 = 0.15;
  var_3 unlink();
  level.player._id_59FF linkTo(var_3);
  var_3 rotateTo(var_6 + (0, -140, 0), var_21, 0.0, 0.0);
  var_7 connectpaths();
  var_7 scripts\engine\utility::delaycall(var_21 + 0.05, ::disconnectpaths);
  var_3 playSound("doorpeek_bulkhead_swing_open");
  var_3 scripts\engine\utility::delaycall(var_21, ::playsound, "doorpeek_bulkhead_hit_wall");
  level notify(var_0 + "door_peek_opened_fully");
  thread _id_59C5(var_0, var_3);
  level notify(var_0 + "door_kick_newdoor_think");
}

_id_59CA(var_0) {
  level endon(var_0 + "door_peek_kick");
  level endon(var_0 + "door_peek_detach");

  for(;;) {
    level.player waittill("grenade_pullback");
    level.player._id_C9FD hide();
    level.player waittill("grenade_fire");
    wait 0.3;
    wait 0.05;
  }
}

_id_59D3(var_0, var_1, var_2) {
  for(;;) {
    var_3 = level.player getnormalizedmovement();

    if(scripts\engine\utility::flag("door_peek_at_door") && var_3[0] > 0) {
      var_4 = 0.6;
      var_0 rotateTo(var_1 + (0, -140, 0), var_4, 0.0, 0.0);
      var_2 connectpaths();
      var_2 scripts\engine\utility::delaycall(var_4 + 0.05, ::disconnectpaths);
      level.player playgestureviewmodel("ges_point_gun");
      var_0 playSound("doorpeek_bulkhead_bash");
      break;
    }

    wait 0.05;
  }
}

_id_59C5(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  level.player stopgestureviewmodel("ges_doorpeek_bulkhead");
  level notify(var_0 + "door_peek_finished");
  level notify("door_peek_finished");
  level.player unlink();
  var_3 = undefined;

  if(!var_2) {
    var_3 = level.player scripts\engine\utility::spawn_tag_origin();
    level.player playerlinktodelta(var_3, "tag_origin", 1, 90, 90, 90, 90, 0);
  }

  _id_59CD();
  level.player._id_C9FD delete();
  level.player._id_59FF delete();
  var_4 = scripts\sp\utility::_id_10639("player_rig", level.player.origin, level.player.angles);
  var_5 = (0, 0, 0);
  var_6 = (0, 0, 0);
  var_4 _meth_81E2(level.player, "tag_origin", (0, 0, 0) + var_5, var_6, 0);
  var_4 thread scripts\sp\anim::_id_1F35(var_4, "doorpeek_01_out_b");
  level notify(var_0 + "door_peek_detach");

  if(!var_2) {
    var_7 = 0.2;
    var_8 = var_3.origin + anglesToForward(level._id_5A25.angles) * -12.0;
    var_3 moveTo(var_8, var_7, var_7 / 2.0, 0.0);
    wait(var_7);
    level.player unlink();
  }
}

_id_59D6(var_0, var_1, var_2, var_3) {
  level endon(var_0 + "door_peek_kick");
  level endon(var_0 + "door_peek_detach");

  for(;;) {
    if(level.player _meth_819F()) {
      break;
    }

    wait 0.05;
  }

  level notify(var_0 + "door_peek_alert_enemies");
  level notify("door_peek_alert_enemies");
  level notify(var_0 + "door_peek_shoot");
}

_id_5984(var_0, var_1, var_2, var_3, var_4) {
  level endon(var_0 + "door_peek_kick");
  level endon(var_0 + "door_peek_opened_fully");
  level endon(var_0 + "door_peek_sprint");
  level waittill(var_0 + "door_peek_start_peek_control");
  var_5 = 0;
  var_6 = 0;

  for(;;) {
    var_7 = _id_794E(var_1, var_4);

    if(var_5 < -0.5 && var_7 < -0.5) {
      var_6++;
    } else {
      var_6 = 0;
    }

    if(var_6 >= 5) {
      break;
    }

    var_5 = var_7;
    wait 0.05;
  }

  level notify(var_0 + "door_peek_back_off");
  thread _id_59C5(var_0, var_1);
  thread _id_59D3(var_1, var_2, var_3);
}

_id_59D8(var_0, var_1, var_2, var_3) {
  level endon(var_0 + "door_peek_kick");
  level endon(var_0 + "door_peek_opened_fully");
  level endon(var_0 + "door_peek_back_off");
  level waittill(var_0 + "door_peek_start_peek_control");

  for(;;) {
    if(level.player issprinting()) {
      break;
    }

    wait 0.05;
  }

  level notify(var_0 + "door_peek_sprint");
  thread _id_59C5(var_0, var_1);
  var_4 = 0.6;
  var_1 rotateTo(var_2 + (0, -140, 0), var_4, 0.0, 0.0);
  var_3 connectpaths();
  var_3 scripts\engine\utility::delaycall(var_4 + 0.05, ::disconnectpaths);
}

_id_59C4(var_0, var_1, var_2, var_3, var_4) {
  level endon(var_0 + "door_peek_kick");
  level endon(var_0 + "door_peek_detach");
  level waittill(var_0 + "door_peek_start_peek_control");
  var_5 = 0;
  var_6 = 0;

  for(;;) {
    var_7 = _id_794E(var_1, var_3);

    if(level._id_5A21 <= 0 && var_5 < -0.5 && var_7 < -0.5) {
      var_6++;
    } else {
      var_6 = 0;
    }

    if(var_6 >= 6) {
      break;
    }

    var_5 = var_7;
    wait 0.05;
  }

  level.player._id_59FF rotateTo(var_2, 0.4, 0.0, 0.0);
  scripts\engine\utility::delaythread(0.4, ::_id_59D2, var_0, var_4);
  level notify(var_0 + "door_peek_restarted");
}

_id_794E(var_0, var_1) {
  var_2 = level.player getnormalizedmovement();
  var_3 = 0;
  var_4 = anglesToForward(var_1.angles);
  var_5 = vectorNormalize((var_2[0], 0 - var_2[1], 0));
  var_6 = vectortoangles(var_5);
  var_7 = level.player getplayerangles(1);
  var_8 = combineangles(var_7, var_6);
  var_9 = anglesToForward(var_8);
  var_10 = min(1.0, sqrt(squared(var_2[0]) + squared(var_2[1])));

  if(var_10 <= 0.1) {
    return 0;
  }

  if(var_10 >= 0.95) {
    var_10 = 1.0;
  }

  var_11 = acos(vectordot(var_4, var_9));
  var_12 = 0.25;
  var_13 = 30;

  if(var_11 <= 90) {
    var_14 = 1.0;

    if(var_11 > var_13) {
      var_15 = var_11 - var_13;
      var_14 = 1.0 - (1.0 - var_12) * (var_15 / (90.0 - var_13));
    }

    var_16 = min(var_10, var_14);
    return var_16;
  } else {
    var_14 = 1.0;
    var_15 = 0;

    if(var_11 < 180 - var_13) {
      var_15 = (var_11 - 180) * -1.0 - var_13;
      var_14 = 1.0 - (1.0 - var_12) * (var_15 / (90.0 - var_13));
    }

    var_16 = min(var_10, var_14) * -1;
    return var_16;
  }
}

_id_59D2(var_0, var_1) {
  level endon(var_0 + "door_peek_finished");
  level endon(var_0 + "door_peek_restarted");

  if(!scripts\engine\utility::flag_exist(var_0 + "door_peek_handle_down")) {
    scripts\engine\utility::flag_init(var_0 + "door_peek_handle_down");
  }

  if(!scripts\engine\utility::flag_exist(var_0 + "did_kick_interrupt_input")) {
    scripts\engine\utility::flag_init(var_0 + "did_kick_interrupt_input");
  }

  thread _id_59DA(var_0, var_1);
  level waittill(var_0 + "door_peek_start");

  while(level.player useButtonPressed()) {
    wait 0.05;
  }

  thread _id_59A1(var_0);
  level._id_CA00 = scripts\sp\hud_util::createfontstring("objective", 0.7);
  level._id_CA00 scripts\sp\hud_util::setpoint("CENTER", "CENTER", 0, -80);
  level._id_CA00 settext("L-Stick Peek");
  level._id_C9FA = scripts\sp\hud_util::createfontstring("objective", 0.7);
  level._id_C9FA scripts\sp\hud_util::setpoint("CENTER", "CENTER", 0, -60);
  level._id_C9FA settext("^3[{+activate}]^7 Kick");
  thread _id_59D1(var_0);
  scripts\engine\utility::flag_wait(var_0 + "did_kick_interrupt_input");
  scripts\engine\utility::flag_wait(var_0 + "door_peek_handle_down");
  level notify(var_0 + "door_peek_kick");
  scripts\engine\utility::waitframe();

  if(isDefined(var_1)) {
    thread _id_59A0(var_0, 1);
  } else {
    thread _id_59A0(var_0);
  }
}

_id_59A1(var_0) {
  level endon(var_0 + "door_peek_finished");
  level endon(var_0 + "door_peek_restarted");

  for(;;) {
    if(level.player useButtonPressed()) {
      wait 0.25;

      if(level.player useButtonPressed()) {
        break;
      }
    }

    wait 0.05;
  }

  level notify(var_0 + "remove_hint_text");
  scripts\engine\utility::flag_set(var_0 + "did_kick_interrupt_input");
}

_id_59D1(var_0) {
  level scripts\engine\utility::waittill_any(var_0 + "door_peek_finished", var_0 + "remove_hint_text");
  level._id_CA00 destroy();
  level._id_C9FA destroy();
}

_id_59CE() {
  level.player scripts\sp\utility::_id_1C49(0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowmelee(0);
  level.player allowjump(0);
  level.player disableweaponpickup();
}

_id_59CD() {
  level.player scripts\sp\utility::_id_1C49(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowmelee(1);
  level.player allowjump(1);
  level.player _meth_80DB();
}

_id_7C3A(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_noteworthy)) {
      if(var_3.script_noteworthy == var_1) {
        return var_3;
      }
    }
  }
}

#using_animtree("player");

_id_CF55() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["door_left_push"] = % shipcrib_player_door_left_push;
  level._id_EC85["player_rig"]["doorpeek_01_in"] = % wm_doorpeek_bulkhead_in;
  level._id_EC85["player_rig"]["doorpeek_01_loop"][0] = % wm_doorpeek_bulkhead_loop;
  level._id_EC85["player_rig"]["doorpeek_01_out"] = % wm_doorpeek_bulkhead_out;
  level._id_EC85["player_rig"]["doorpeek_01_out_b"] = % wm_doorpeek_bulkhead_out_b;
}

#using_animtree("generic_human");

_id_775C() {
  level._id_EC85["generic"]["walk_cqb_f"][0] = % walk_cqb_f;
  level._id_EC85["generic"]["cqb_stand_idle"][0] = % cqb_stand_idle;
  level._id_EC87["headless_fullbody_rig"] = #animtree;
  level._id_EC8C["headless_fullbody_rig"] = "test_jackal_pilot";
  level._id_EC85["headless_fullbody_rig"]["door_kick_in"] = % door_kick_in;
}

#using_animtree("script_model");

_id_EE1C() {
  level._id_EC87["doorpeek_01_door"] = #animtree;
  level._id_EC85["doorpeek_01_door"]["doorpeek_in"] = % wm_doorpeek_bulkhead_in_door;
}