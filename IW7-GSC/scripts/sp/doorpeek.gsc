/***********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\doorpeek.gsc
***********************************/

func_11620(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_04 = [level.var_5A23[param_00].var_5A25, level.var_5A23[param_00].var_5A2A];
  foreach(var_06 in var_04) {
    var_06 giveweaponpassives(param_01, param_02);
  }

  if(param_03) {
    teleportscene();
  }

  level.var_5A23[param_00].var_5A24 = level.var_5A23[param_00].var_5A25.angles;
}

func_59CB() {
  func_1206();
  func_11FB();
  func_120C();
  level.var_5A23 = [];
  scripts\sp\utility::func_D6D9(::func_59CC);
  scripts\engine\utility::flag_init("show_peek_hint");
  scripts\engine\utility::flag_init("stopping_doorpeek_gesture");
  scripts\engine\utility::flag_init("doorpeek_hand_on_door");
  scripts\sp\utility::func_16EB("peek_hint", &"SCRIPT_DOORPEEK_HINT", ::func_C9F7);
  scripts\sp\utility::func_16EB("peek_hint_pc", &"SCRIPT_DOORPEEK_HINT_PC", ::func_C9F7);
  scripts\sp\utility::func_16EB("peek_hint_shove", &"SCRIPT_DOORPEEK_HINT_SHOVE", ::func_C9F7);
  scripts\sp\utility::func_16EB("peek_hint_shove_pc", &"SCRIPT_DOORPEEK_HINT_SHOVE_PC", ::func_C9F7);
  scripts\sp\utility::func_16EB("peek_only_hint", &"SCRIPT_DOORPEEK_HINT_PEEK_ONLY", ::func_C9F7);
  scripts\sp\utility::func_16EB("peek_only_hint_pc", &"SCRIPT_DOORPEEK_HINT_PEEK_ONLY_PC", ::func_C9F7);
}

func_C9F7() {
  return !scripts\engine\utility::flag("show_peek_hint");
}

func_59CC() {
  func_118F();
  func_118E();
  level.player notifyonplayercommand("kick_pressed", "+stance");
  level.player notifyonplayercommand("kick_pressed_pc", "+activate");
}

func_794D(param_00) {
  var_01 = getEntArray(param_00, "targetname");
  var_02 = func_12A6(var_01, "door_peek_door");
  return var_02;
}

func_118F() {
  var_00 = scripts\engine\utility::getstructarray("door_peek_struct", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.spawnimpulsefield) && var_02.spawnimpulsefield & 1) {
      var_03 = getEntArray(var_02.var_336, "targetname");
      var_04 = scripts\engine\utility::getstructarray(var_02.var_336, "targetname");
      var_03 = scripts\engine\utility::array_combine(var_03, var_04);
      if(var_02.spawnimpulsefield & 2) {
        thread func_59BE(var_02.var_336);
      }

      if(var_02.spawnimpulsefield & 4) {
        thread func_59BE(var_02.var_336, 1);
      }

      continue;
    }

    func_59D5(var_02.var_336, 0);
    var_05 = getEntArray(var_02.var_336, "targetname");
    var_05 = scripts\engine\utility::array_combine(var_05, scripts\engine\utility::getstructarray(var_02.var_336, "targetname"));
    var_06 = func_12A6(var_05, "door_peek_door");
    var_07 = var_06.var_EE52;
    if(var_07 == "airlock" || var_07 == "airlockcombat") {
      var_06 scripts\sp\dooruse::func_1AB5(0);
    }
  }
}

func_118E() {
  var_00 = scripts\engine\utility::getstructarray("door_peek_struct", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_336) && var_02.var_336 == "door_peek_armory") {
      thread func_59BE(var_02.var_336);
    }
  }
}

func_11FA() {
  self give_mp_super_weapon(self.origin);
  scripts\sp\utility::func_F3E0(1);
  scripts\sp\utility::func_F415(1);
}

func_13B2(param_00, param_01) {
  level.player endon("death");
  if(!param_01) {
    level endon(param_00 + "door_peek_main_side_used");
    level waittill(param_00 + "door_peek_reverse_side_used");
  } else {
    level endon(param_00 + "door_peek_reverse_side_used");
    level waittill(param_00 + "door_peek_main_side_used");
  }

  lib_0E46::func_DFE3();
  self.origin = self.ogorigin;
}

func_1207(param_00, param_01, param_02, param_03) {
  level endon(param_00 + "door_peek_deleted");
  level endon(param_00 + "door_peek_disabled");
  if(!isDefined(param_03) || param_03 == 0) {
    level endon(param_00 + "door_peek_kick");
  }

  level endon(param_00 + "door_peek_back_off");
  level endon(param_00 + "door_peek_sprint");
  level endon(param_00 + "door_peek_pop_open");
  level endon(param_00 + "door_kick_newdoor_think");
  level.player.var_5818 = 1;
  thread func_1208(param_00, param_01, param_02, param_03);
  level.player waittill("death");
  func_11D6(param_00, param_01);
}

func_1208(param_00, param_01, param_02, param_03) {
  level.player endon("death");
  var_04 = [param_00 + "door_peek_deleted", param_00 + "door_peek_disabled", param_00 + "door_peek_back_off", param_00 + "door_peek_sprint", param_00 + "door_peek_pop_open", param_00 + "door_kick_newdoor_think"];
  if(!isDefined(param_03) || param_03 == 0) {
    var_04[var_04.size] = param_00 + "door_peek_kick";
  }

  level scripts\engine\utility::waittill_any_in_array_return(var_04);
  level.player.var_5818 = undefined;
}

func_1211(param_00, param_01, param_02, param_03) {
  level.player endon("death");
  level endon(param_00 + "door_peek_deleted");
  level endon(param_00 + "door_peek_disabled");
  if(!isDefined(param_03) || param_03 == 0) {
    level endon(param_00 + "door_peek_kick");
  }

  level endon(param_00 + "door_peek_back_off");
  level endon(param_00 + "door_peek_sprint");
  level endon(param_00 + "door_peek_pop_open");
  if(!param_01) {
    level endon(param_00 + "door_peek_reverse_side_used");
  } else {
    level endon(param_00 + "door_peek_main_side_used");
  }

  if(!isDefined(level.var_5A23[param_00])) {
    level.var_5A23[param_00] = spawnStruct();
  }

  var_04 = getEntArray(param_00, "targetname");
  var_04 = scripts\engine\utility::array_combine(var_04, scripts\engine\utility::getstructarray(param_00, "targetname"));
  level.var_5A23[param_00].var_5978 = func_12A6(var_04, "door_peek_door");
  level.var_5A23[param_00].var_5A57 = level.var_5A23[param_00].var_5978.var_EE52;
  level.var_5A23[param_00].var_5978 scripts\sp\utility::func_23B7("doorpeek_door");
  var_05 = func_12A6(var_04, "door_peek_struct");
  if(!param_01) {
    var_06 = 1;
    var_07 = func_12A6(var_04, "door_peek_animstruct");
    level.var_5A23[param_00].var_5A25 = var_05 scripts\engine\utility::spawn_tag_origin();
    level.var_5A23[param_00].var_59FF = var_07 scripts\engine\utility::spawn_tag_origin();
    level.var_5A23[param_00].var_59FF.angles = var_07.angles + (0, 180, 0);
    level.var_5A23[param_00].var_59FF linkto(level.var_5A23[param_00].var_5978);
    level.var_5A23[param_00].var_5A58 = distance2d(level.var_5A23[param_00].var_5A25.origin, level.var_5A23[param_00].var_59FF.origin);
    var_08 = func_12A6(var_04, "door_kick_animstruct");
    level.var_5A23[param_00].var_A5A9 = var_08 scripts\engine\utility::spawn_tag_origin();
    level.var_5A23[param_00].var_A5A9 linkto(level.var_5A23[param_00].var_5A25);
    var_09 = -140;
    if(isDefined(var_05.var_EE0E)) {
      var_09 = var_05.var_EE0E * -1;
    }

    level.var_5A23[param_00].var_74C0 = var_09;
  } else {
    var_06 = -1;
    var_07 = func_12A6(var_06, "door_peek_animstruct_b");
    level.var_5A23[param_01].var_5A26 = var_06 scripts\engine\utility::spawn_tag_origin();
    level.var_5A23[param_01].var_5A26.angles = level.var_5A23[param_01].var_5A26.angles + (0, 180, 0);
    level.var_5A23[param_01].var_5A00 = var_09 scripts\engine\utility::spawn_tag_origin();
    level.var_5A23[param_01].var_5A00 linkto(level.var_5A23[param_01].var_5978);
    level.var_5A23[param_01].var_5A58 = distance2d(level.var_5A23[param_01].var_5A26.origin, level.var_5A23[param_01].var_5A00.origin);
    var_0A = func_12A6(var_05, "door_kick_animstruct_b");
    level.var_5A23[param_00].var_A5AA = var_0A scripts\engine\utility::spawn_tag_origin();
    level.var_5A23[param_00].var_A5AA linkto(level.var_5A23[param_00].var_5A26);
    var_09 = 140;
    if(isDefined(var_05.var_EE0D)) {
      var_09 = var_05.var_EE0D;
    }

    level.var_5A23[param_00].var_74C1 = var_09;
  }

  level.var_5A23[param_00].var_5A2A = var_05 scripts\engine\utility::spawn_tag_origin();
  level.var_5A23[param_00].var_5978 linkto(level.var_5A23[param_00].var_5A2A);
  level.var_5A23[param_00].var_5A24 = level.var_5A23[param_00].var_5A2A.angles;
  level.var_5A23[param_00].var_5A03 = func_12A6(var_04, "door_peek_clip");
  level.var_5A23[param_00].var_5A03 linkto(level.var_5A23[param_00].var_5978);
  level.var_5A23[param_00].var_5A56 = func_12A6(var_04, "door_peek_static_clip");
  if(!param_01) {
    var_0B = func_12A6(var_04, "door_kick_interact");
    level.var_5A23[param_00].var_4C26 = spawn("script_origin", var_0B.origin);
    level.var_5A23[param_00].var_4C26.origin = var_0B.origin;
    level.var_5A23[param_00].var_4C26.angles = var_0B.angles;
    level.var_5A23[param_00].var_4C26 linkto(level.var_5A23[param_00].var_5978);
  } else {
    var_0B = func_12A6(var_05, "door_kick_interact_b");
    level.var_5A23[param_00].var_4C27 = spawn("script_origin", var_0B.origin);
    level.var_5A23[param_00].var_4C27.origin = var_0B.origin;
    level.var_5A23[param_00].var_4C27.angles = var_0B.angles;
    level.var_5A23[param_00].var_4C27 linkto(level.var_5A23[param_00].var_5978);
  }

  level.var_5A23[param_00].var_C9D4 = 0;
  level.var_5A23[param_00].var_5A21 = 0;
  if(!param_01) {
    level.var_5A23[param_00].var_C9FE = func_1298(level.var_5A23[param_00].var_5A57, param_01);
  } else {
    level.var_5A23[param_00].var_C9FF = func_1298(level.var_5A23[param_00].var_5A57, param_01);
  }

  level.var_5A23[param_00].var_1B12 = 0;
  if(isDefined(level.var_5A23[param_00].var_5978.script_threshold)) {
    level.var_5A23[param_00].var_1B12 = level.var_5A23[param_00].var_5978.script_threshold;
    if(!param_01) {
      level.var_5A23[param_00].var_5A2A.angles = level.var_5A23[param_00].var_5A2A.angles - (0, level.var_5A23[param_00].var_1B12, 0);
    } else {
      level.var_5A23[param_00].var_5A2A.angles = level.var_5A23[param_00].var_5A2A.angles + (0, level.var_5A23[param_00].var_1B12, 0);
    }
  }

  wait(0.05);
  if(isDefined(level.var_5A23[param_00].var_4C1C)) {
    scripts\engine\utility::flag_wait(level.var_5A23[param_00].var_4C1C);
  }

  if(!isDefined(level.var_5A23[param_00].var_5978)) {
    level notify(param_00 + "door_peek_deleted");
  }

  func_11F8(param_00, param_01);
  thread func_1207(param_00, param_01, param_02, param_03);
  if(param_01) {
    level.var_5A23[param_00].var_5978 unlink();
    var_0C = level.var_5A23[param_00].var_C9FF.var_11782;
    level.var_5A23[param_00].var_5A2A.origin = level.var_5A23[param_00].var_5A2A.origin + var_0C * anglesToForward(level.var_5A23[param_00].var_5A26.angles);
    level.var_5A23[param_00].var_5978 linkto(level.var_5A23[param_00].var_5A2A);
  }

  thread func_120D(param_00, level.var_5A23[param_00].var_5978, level.var_5A23[param_00].var_5A03);
  childthread func_120E(param_00);
  if(!isDefined(param_02)) {
    if(level.var_5A23[param_00].var_5A57 != "airlock") {
      thread func_1209(param_00, level.var_5A23[param_00].var_5978, param_01, level.var_5A23[param_00].var_5A03);
      if(!param_01) {
        thread func_11EA(param_00, level.var_5A23[param_00].var_5978, param_01, level.var_5A23[param_00].var_5A03, level.var_5A23[param_00].var_5A25);
      } else {
        thread func_11EA(param_00, level.var_5A23[param_00].var_5978, param_01, level.var_5A23[param_00].var_5A03, level.var_5A23[param_00].var_5A26);
      }
    }
  }

  level.player.dontmelee = 1;
  level notify(param_00 + "door_peek_start");
  level notify("door_peek_start");
  thread scripts\engine\utility::flag_set_delayed(param_00 + "door_peek_can_kick", level.var_5A23[param_00].var_C9FE.var_119D5);
  if(param_01) {
    level notify(param_00 + "door_peek_reverse_side_used");
    level notify("door_peek_reverse_side_used");
  } else {
    level notify(param_00 + "door_peek_main_side_used");
    level notify("door_peek_main_side_used");
  }

  func_1201();
  func_1205();
  thread func_59CF(param_00, param_03);
  func_1202(param_00, param_01);
  thread func_1466(param_00);
  func_1204();
  thread func_11FE(param_00, param_01);
  thread func_120A(param_00, param_01);
  func_11F5(param_00, param_01, param_02);
  func_1210(param_00, param_01);
  level notify(param_00 + "door_kick_newdoor_think");
}

func_11F8(param_00, param_01) {
  level.player endon("death");
  level endon(param_00 + "door_peek_disabled");
  if(!param_01) {
    var_02 = level.var_5A23[param_00].var_4C26;
  } else {
    var_02 = level.var_5A23[param_01].var_4C27;
  }

  var_02.ogorigin = var_02.origin;
  var_02 lib_0E46::func_48C4(undefined, (0, 0, 0), &"SCRIPT_DOORPEEK_OPEN", undefined, 512);
  var_02 thread func_13B2(param_00, param_01);
  var_02 thread func_11F6(param_00);
  var_03 = 0;
  if(level.var_5A23[param_00].var_5A57 == "armory" || level.var_5A23[param_00].var_5A57 == "armoryajar") {
    var_03 = 1;
  }

  var_02 thread func_11F7(level.var_5A23[param_00].var_5978, param_01, level.var_5A23[param_00].var_1B12, var_03);
  var_02 waittill("trigger", var_04);
  var_02.origin = var_02.ogorigin;
  level.var_5A23[param_00].var_5A56 hide();
}

func_11F6(param_00) {
  level.player endon("death");
  self endon("trigger");
  level waittill(param_00 + "door_peek_disabled");
  lib_0E46::func_DFE3();
  self.origin = self.ogorigin;
}

func_1202(param_00, param_01) {
  if(!param_01) {
    var_02 = level.var_5A23[param_00].var_C9FE;
    var_03 = "ges_doorpeek_" + func_1297(level.var_5A23[param_00].var_5A57);
    var_04 = level.var_5A23[param_00].var_59FF;
    var_05 = "doorpeek_" + func_1297(level.var_5A23[param_00].var_5A57) + "_in";
  } else {
    var_02 = level.var_5A23[var_04].var_C9FF;
    var_03 = "ges_doorpeek_" + func_1297(level.var_5A23[var_03].var_5A57) + "_r";
    var_04 = level.var_5A23[var_02].var_5A00;
    var_05 = "doorpeek_" + func_1297(level.var_5A23[param_01].var_5A57) + "_r_in";
  }

  var_06 = func_12AC(param_00, param_01);
  if(isDefined(var_06)) {
    var_03 = var_06;
  }

  if(!scripts\engine\utility::flag(param_00 + "door_peek_handle_down")) {
    var_07 = 0.4;
    level.var_5A23[param_00].var_C9FD = scripts\sp\utility::func_10639("player_rig");
    var_08 = level.player _meth_84C6("currentViewModel");
    if(isDefined(var_08)) {
      level.var_5A23[param_00].var_C9FD setModel(var_08);
    }

    level.var_5A23[param_00].var_C9FD hide();
    childthread func_11CE(0.2, level.var_5A23[param_00].var_C9FD);
    var_04 thread scripts\sp\anim::func_1EC3(level.var_5A23[param_00].var_C9FD, var_05);
    var_09 = level.var_5A23[param_00].var_C9FD gettagorigin("tag_player");
    var_0A = level.player getplayerangles(1);
    var_0B = var_04.origin - var_09;
    var_0C = level.player.origin - var_09;
    var_0D = var_0A - var_04.angles + (0, 180, 0);
    var_0E = var_04.origin;
    var_0F = var_04.angles;
    var_04 unlink();
    var_04.origin = var_04.origin + var_0C;
    var_10 = vectornormalize(var_04.origin - level.player.origin);
    var_11 = distance(var_04.origin, level.player.origin);
    var_10 = rotatevector(var_10, var_0D);
    var_04.origin = level.player.origin + var_10 * var_11;
    var_04.angles = var_04.angles + var_0D;
    var_12 = 0.6 - var_07;
    var_13 = distance(level.player.origin, var_09);
    var_14 = 20;
    var_15 = 40;
    var_16 = 0;
    if(var_13 > var_14) {
      var_16 = min(var_13 - var_14 / var_15 - var_14, 1) * var_12;
    }

    var_17 = abs(var_0D[1]);
    var_18 = 30;
    var_19 = 75;
    var_1A = 0;
    if(var_17 > var_18) {
      var_1A = min(var_17 - var_18 / var_19 - var_18, 1) * var_12;
    }

    var_1B = max(var_16, var_1A);
    var_1C = var_07 + var_1B;
    scripts\engine\utility::flag_set("doorpeek_hand_on_door");
    if(var_1B > 0) {
      level.player scripts\engine\utility::delaycall(var_1B, ::forceplaygestureviewmodel, var_03);
      var_04 thread scripts\sp\anim::func_1EC3(level.var_5A23[param_00].var_C9FD, var_05);
      var_04 scripts\engine\utility::delaythread(var_1B, ::scripts\sp\anim::func_1F35, level.var_5A23[param_00].var_C9FD, var_05);
      if(level.var_5A23[param_00].var_5A57 != "civlever" && level.var_5A23[param_00].var_5A57 != "armoryajar") {
        level.var_5A23[param_00].var_5978 scripts\engine\utility::delaythread(var_1B, ::scripts\sp\anim::func_1F35, level.var_5A23[param_00].var_5978, "doorpeek_" + func_1297(level.var_5A23[param_00].var_5A57) + "_in");
      }
    } else {
      level.player forceplaygestureviewmodel(var_03);
      var_04 thread scripts\sp\anim::func_1F35(level.var_5A23[param_00].var_C9FD, var_05);
      if(level.var_5A23[param_00].var_5A57 != "civlever" && level.var_5A23[param_00].var_5A57 != "armoryajar") {
        level.var_5A23[param_00].var_5978 thread scripts\sp\anim::func_1F35(level.var_5A23[param_00].var_5978, "doorpeek_" + func_1297(level.var_5A23[param_00].var_5A57) + "_in");
      }
    }

    level.player playerlinktoblend(level.var_5A23[param_00].var_C9FD, "tag_player", 0.2, 0, 0);
    wait(0.05);
    level.var_5A23[param_00].var_C9FD linkto(var_04);
    var_04 moveto(var_0E, var_1C);
    var_04 rotateto(var_0F, var_1C);
    level thread scripts\sp\utility::func_C12D(param_00 + "door_peek_blend_complete", var_1C + 0.1);
    level thread scripts\sp\utility::func_C12D("door_peek_blend_complete", var_1C + 0.1);
    var_04 scripts\engine\utility::delaycall(var_1C + 0.05, ::linkto, level.var_5A23[param_00].var_5978);
    if(var_1B > 0) {
      wait(var_1B);
    }

    wait(var_02.var_119AB);
    scripts\engine\utility::flag_set(param_00 + "door_peek_handle_down");
    level notify(param_00 + "door_handle_down");
    level notify("door_handle_down");
  }

  if(!param_01) {
    level.player playerlinktodelta(level.var_5A23[param_00].var_C9FD, "tag_player", 1, var_02.setdevdvarifuninitialized, var_02.var_B7C1, 80, 20, 0);
  } else {
    level.player playerlinktodelta(level.var_5A23[param_00].var_C9FD, "tag_player", 1, var_02.var_B7C9, var_02.setmatchdataid, 80, 20, 0);
  }

  if((!isDefined(level.var_5A23[param_00].var_A5AB) || level.var_5A23[param_00].var_A5AB == 0) && level.var_5A23[param_00].var_1B12 == 0) {
    thread func_1203(param_00, param_01);
  }

  wait(var_02.var_47A4);
  level notify(param_00 + "door_intro_done");
  level notify("door_intro_done");
}

func_11CE(param_00, param_01) {
  level.player endon("death");
  wait(param_00);
  param_01 show();
}

func_1203(param_00, param_01) {
  if(!param_01) {
    var_02 = level.var_5A23[param_00].var_C9FE;
  } else {
    var_02 = level.var_5A23[param_01].var_C9FF;
  }

  level.var_5A23[param_00].var_5A2A ghost_killed_update_func((0, 0 - var_02.var_47A3, 0), var_02.var_47A4, 0, var_02.var_47A4 / 2);
  level.var_5A23[param_00].var_5978 playSound("doorpeek_" + func_1299(level.var_5A23[param_00].var_5A57) + "_crack_open");
}

func_11F5(param_00, param_01, param_02) {
  level endon(param_00 + "door_script_disabled");
  if(!param_01) {
    var_03 = 1;
    var_04 = level.var_5A23[param_00].var_C9FE;
    var_05 = level.var_5A23[param_00].var_5A25;
  } else {
    var_03 = -1;
    var_04 = level.var_5A23[param_02].var_C9FF;
    var_05 = level.var_5A23[param_01].var_5A26;
  }

  level notify(param_00 + "door_peek_start_peek_control");
  level notify("door_peek_start_peek_control");
  var_06 = func_12AE(param_00);
  var_07 = 0;
  var_08 = 0;
  var_09 = 1;
  var_0A = level.var_5A23[param_00].var_5A2A.angles;
  var_0B = 0;
  var_0C = 0;
  var_0D = 0;
  var_0E = 80;
  if(level.var_5A23[param_00].var_5A57 == "airlock") {
    var_0E = 90;
  }

  for(;;) {
    if(!param_01 && level.var_5A23[param_00].var_5A21 >= var_0E && !level.var_5A23[param_00].var_C9D4) {
      break;
    } else if(param_01 && level.var_5A23[param_00].var_5A21 <= 0 - var_0E && !level.var_5A23[param_00].var_C9D4) {
      break;
    }

    var_0C = 0;
    var_0F = func_1296(param_00, param_01);
    if(isDefined(level.var_5A23[param_00].var_72C6) && level.var_5A23[param_00].var_72C6 == 1) {
      var_0F = 1;
    }

    var_10 = var_0F * 1.2 * var_03;
    if(var_08 == 1 && var_0F == 1) {
      var_10 = var_10 * 1.01 * scripts\sp\utility::func_E753(var_09, 0, 1);
      var_09 = var_09 + 0.5;
    } else {
      var_09 = 1;
    }

    var_10 = clamp(var_10, 0 - var_04.var_B4B9, var_04.var_B4B9);
    if(!level.var_5A23[param_00].var_C9D4) {
      var_11 = 0;
      if(isDefined(level.var_5A23[param_00].var_B7C6)) {
        var_11 = level.var_5A23[param_00].var_B7C6 - var_06;
      }

      if(!param_01) {
        level.var_5A23[param_00].var_5A21 = max(level.var_5A23[param_00].var_5A21 + var_10, var_11);
      } else {
        level.var_5A23[param_00].var_5A21 = min(level.var_5A23[param_00].var_5A21 + var_10, 0 - var_11);
      }

      level.var_5A23[param_00].var_5A21 = scripts\sp\utility::func_E753(level.var_5A23[param_00].var_5A21, 1);
      if(isDefined(param_02)) {
        level.var_5A23[param_00].var_5A21 = min(level.var_5A23[param_00].var_5A21 + var_10, param_02);
      }
    }

    if(level.var_5A23[param_00].var_5A21 != var_07) {
      var_0C = 1;
      if(var_0B == 0) {
        level.var_5A23[param_00].var_5978 playSound("doorpeek_" + func_1299(level.var_5A23[param_00].var_5A57) + "_move_start");
        level.var_5A23[param_00].var_5978 playLoopSound("doorpeek_" + func_1299(level.var_5A23[param_00].var_5A57) + "_move_loop");
      }

      level.var_5A23[param_00].var_5A2A rotateto(var_0A + (0, 0 - level.var_5A23[param_00].var_5A21, 0), 0.1, 0, 0);
      if(!param_01) {
        var_12 = clamp(level.var_5A23[param_00].var_5A21 / var_04.var_B481, 0, 1) * var_04.var_B4AA - var_04.var_B7C1 + var_04.var_B7C1;
        level.player playerlinktodelta(level.var_5A23[param_00].var_C9FD, "tag_player", 1, var_04.setdevdvarifuninitialized, var_12, 80, 20, 0);
      } else {
        var_13 = clamp(-1 * level.var_5A23[param_00].var_5A21 / var_04.var_B481, 0, 1) * var_04.var_B4C1 - var_04.var_B7C9 + var_04.var_B7C9;
        level.player playerlinktodelta(level.var_5A23[param_00].var_C9FD, "tag_player", 1, var_13, var_04.setmatchdataid, 80, 20, 0);
      }

      if(isDefined(param_02) && level.var_5A23[param_00].var_5A21 == param_02) {
        wait(0.1);
        level.var_5A23[param_00].var_5978 playSound("doorpeek_" + func_1299(level.var_5A23[param_00].var_5A57) + "_blocked");
        level notify(param_00 + "door_peek_blocked");
        level notify("door_peek_blocked");
      }

      if(level.var_5A23[param_00].var_5A57 == "airlock" && var_0D == 0 && level.var_5A23[param_00].var_5A21 >= 64) {
        var_0D = 1;
        level notify(param_00 + "door_peek_airlock_ally_move");
        level notify("door_peek_airlock_ally_move");
      }
    } else if(var_0B) {
      level.var_5A23[param_00].var_5978 stoploopsound("doorpeek_" + func_1299(level.var_5A23[param_00].var_5A57) + "_move_loop");
      level.var_5A23[param_00].var_5978 playSound("doorpeek_" + func_1299(level.var_5A23[param_00].var_5A57) + "_move_stop");
    }

    var_07 = level.var_5A23[param_00].var_5A21;
    var_08 = var_0F;
    var_0B = var_0C;
    wait(0.05);
  }
}

func_1210(param_00, param_01) {
  func_13C9("open");
  if(!param_01) {
    var_02 = level.var_5A23[param_00].var_74C0;
  } else {
    var_02 = level.var_5A23[param_01].var_74C1;
  }

  var_03 = 0.15;
  level.var_5A23[param_00].var_5A2A rotateto(level.var_5A23[param_00].var_5A24 + (0, var_02, 0), var_03, 0, 0);
  level.var_5A23[param_00].var_5A2A scripts\engine\utility::delaycall(var_03 + 0.05, ::delete);
  level.var_5A23[param_00].var_5A03 connectpaths();
  level.var_5A23[param_00].var_5A03 scripts\engine\utility::delaycall(var_03 + 0.05, ::disconnectpaths);
  level.var_5A23[param_00].var_5978 playSound("doorpeek_" + func_1299(level.var_5A23[param_00].var_5A57) + "_swing_open");
  level.var_5A23[param_00].var_5978 scripts\engine\utility::delaycall(var_03, ::playsound, "doorpeek_" + func_1299(level.var_5A23[param_00].var_5A57) + "_hit_wall");
  level thread scripts\sp\utility::func_C12D(param_00 + "door_peek_finished", var_03 + 0.05);
  level thread scripts\sp\utility::func_C12D("door_peek_finished", var_03 + 0.05);
  level notify(param_00 + "door_peek_opened_fully");
  if(isDefined(level.var_5A1C)) {
    level.var_5A23[param_00].var_C9FD delete();
    level.var_5A23[param_00].var_59FF delete();
    level.var_5A23[param_00].var_5A2A delete();
    return;
  }

  thread func_11F9(param_00, level.var_5A23[param_00].var_5978, param_01, 0, 1);
}

func_11F7(param_00, param_01, param_02, param_03) {
  level.player endon("death");
  level endon(param_00.var_336 + "door_peek_start");
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(!param_01) {
    var_04 = level.var_5A23[param_00.var_336].var_5A25;
  } else {
    var_04 = level.var_5A23[param_01.var_336].var_5A26;
  }

  var_05 = var_04.angles;
  if(!param_01) {
    var_05 = var_05 - (0, param_02, 0);
  } else {
    var_05 = var_05 + (0, param_02, 0);
  }

  var_06 = anglesToForward(var_05);
  var_07 = anglestoright(var_05);
  var_08 = anglestoup(var_05);
  var_09 = self.ogorigin + var_07 * level.var_5A23[param_00.var_336].var_5A58 * 0.5;
  self unlink();
  for(;;) {
    wait(0.05);
    var_0A = distance2d(level.player.origin, var_09);
    var_0B = abs(clamp(var_0A / 100, 0, 1) - 1);
    if(var_0B > 0) {
      var_0C = level.player getEye();
      var_0D = level.player getplayerangles();
      var_0E = anglesToForward(var_0D);
      if(vectordot(var_0E, var_06) < 0) {
        continue;
      }

      var_0F = scripts\sp\math::func_ACE9(var_0C, var_0C + var_0E * 64, self.ogorigin, var_06);
      var_10 = vectornormalize(var_0F - self.ogorigin);
      var_0F = self.ogorigin + var_10 * distance(var_0F, self.ogorigin) * 0.75 * var_0B;
      if(distance(var_0F, self.ogorigin) > 32) {
        var_0F = self.ogorigin + var_10 * 32;
      }

      var_11 = vectorcross(var_06, var_10);
      var_12 = 0;
      if(!param_01 && vectordot(var_11, var_08) > 0 && !param_03) {
        var_12 = 1;
      } else if(param_01 && vectordot(var_11, var_08) < 0 && !param_03) {
        var_12 = 1;
      }

      if(var_12) {
        var_13 = vectordot(var_10, var_08);
        var_14 = distance(var_0F, self.ogorigin) * var_13;
        var_0F = self.ogorigin + var_08 * var_14;
      }

      self.origin = var_0F;
      continue;
    }

    if(self.origin != self.ogorigin) {
      self.origin = self.ogorigin;
    }
  }
}

func_11FE(param_00, param_01) {
  level.player endon("death");
  level endon(param_00 + "door_peek_kick");
  level endon(param_00 + "door_peek_detach");
  for(;;) {
    level.player waittill("grenade_pullback");
    func_13C9("grenade");
    func_116C(param_00, param_01, 0);
    level.player waittill("grenade_fire");
    wait(0.3);
    func_116C(param_00, param_01, 1);
    wait(0.05);
  }
}

func_120A(param_00, param_01) {
  level.player endon("death");
  level endon(param_00 + "door_peek_kick");
  level endon(param_00 + "door_peek_detach");
  var_02 = 0;
  for(;;) {
    if(level.player getteamsize() && !var_02 && !level.player isdualwielding()) {
      func_116C(param_00, param_01, 0);
      var_02 = 1;
    } else if(!level.player getteamsize() && var_02) {
      func_116C(param_00, param_01, 1);
      var_02 = 0;
    }

    wait(0.05);
  }
}

func_116C(param_00, param_01, param_02) {
  if(!isDefined(level.var_5A23[param_00].var_C9FD)) {
    return;
  }

  if(param_02) {
    if(!isDefined(level.var_5A23[param_00].var_5A22)) {
      level.var_5A23[param_00].var_5A22 = 0;
    }

    level.var_5A23[param_00].var_5A22--;
    if(!level.var_5A23[param_00].var_5A22) {
      thread func_C9E8(param_00, param_01, param_02);
      return;
    }

    return;
  }

  if(!isDefined(level.var_5A23[param_00].var_5A22)) {
    level.var_5A23[param_00].var_5A22 = 0;
  }

  level.var_5A23[param_00].var_5A22++;
  if(level.var_5A23[param_00].var_5A22 == 1) {
    thread func_C9E7(param_00, param_01, param_02);
  }
}

func_C9E8(param_00, param_01, param_02) {
  level endon(param_00 + "door_peek_kick");
  level endon(param_00 + "door_peek_detach");
  level notify("peek_arm_on");
  level endon("peek_arm_on");
  scripts\engine\utility::flag_waitopen("stopping_doorpeek_gesture");
  level.player forceplaygestureviewmodel("ges_drophand");
  if(!param_01) {
    var_03 = level.var_5A23[param_00].var_59FF;
    var_04 = "doorpeek_" + func_1297(level.var_5A23[param_00].var_5A57) + "_backon";
  } else {
    var_03 = level.var_5A23[param_02].var_5A00;
    var_04 = "doorpeek_" + func_1297(level.var_5A23[param_01].var_5A57) + "_r_backon";
  }

  childthread func_136C(var_03, param_00, var_04);
}

func_C9E7(param_00, param_01, param_02) {
  level endon(param_00 + "door_peek_kick");
  level endon(param_00 + "door_peek_detach");
  level notify("peek_arm_off");
  level endon("peek_arm_off");
  level.player notify("door_peek_hand_off");
  scripts\engine\utility::flag_clear("doorpeek_hand_on_door");
  level.var_5A23[param_00].var_C9FD hide();
  childthread func_1415();
}

func_136C(param_00, param_01, param_02) {
  level.player endon("door_peek_hand_off");
  wait(0.3);
  scripts\engine\utility::flag_set("doorpeek_hand_on_door");
  level.var_5A23[param_01].var_C9FD show();
  param_00 scripts\sp\anim::func_1F35(level.var_5A23[param_01].var_C9FD, param_02);
}

func_1415() {
  scripts\engine\utility::flag_set("stopping_doorpeek_gesture");
  var_00 = 0.1;
  level.player stopgestureviewmodel("ges_doorpeek_bulkhead", var_00);
  level.player stopgestureviewmodel("ges_doorpeek_airlock", var_00);
  level.player stopgestureviewmodel("ges_doorpeek_civlever", var_00);
  level.player stopgestureviewmodel("ges_doorpeek_civlever_r", var_00);
  level.player stopgestureviewmodel("ges_drophand", var_00);
  wait(var_00 + 0.25);
  scripts\engine\utility::flag_clear("stopping_doorpeek_gesture");
}

func_120B(param_00, param_01, param_02) {
  var_03 = param_00.var_EE52;
  var_04 = undefined;
  var_05 = undefined;
  for(;;) {
    var_04 = var_05;
    var_06 = func_11FC(param_00);
    var_05 = func_11FD(param_00);
    var_07 = 0;
    var_08 = 0;
    if(!isDefined(var_05) && isDefined(var_04)) {
      if(!param_01 && var_04) {
        var_07 = 1;
      }
    }

    if(isDefined(var_05) && isDefined(var_04) && var_05 != var_04) {
      if((!param_01 && var_05) || param_01 && !var_05) {
        var_07 = 1;
      }
    }

    if(!var_07 && isDefined(var_06)) {
      var_08 = 1;
      if(!param_01 && var_06 && !isDefined(level.var_5A23[param_00.var_336].var_C9FF)) {
        wait(0.05);
        continue;
      }

      var_09 = 50;
      var_0A = level.player getnormalizedmovement();
      var_0B = vectornormalize((var_0A[0], 0 - var_0A[1], 0));
      var_0C = vectortoangles(var_0B);
      var_0D = level.player getplayerangles(1);
      var_0E = combineangles(var_0D, var_0C);
      var_0F = anglesToForward(var_0E);
      if(!var_06) {
        var_10 = anglesToForward(level.var_5A23[param_00.var_336].var_5A25.angles);
        if(acos(clamp(vectordot(var_10, var_0F), -1, 1)) > var_09) {
          var_08 = 0;
        }
      } else {
        var_10 = anglesToForward(level.var_5A23[param_01.var_336].var_5A25.angles + (0, 180, 0));
        if(acos(clamp(vectordot(var_10, var_0F), -1, 1)) > var_09) {
          var_08 = 0;
        }
      }
    }

    if(var_07 || var_08) {
      if(var_07) {
        var_06 = 0;
      }

      var_11 = 360;
      if(!var_06) {
        var_12 = level.var_5A23[param_00.var_336].var_74C0;
      } else {
        var_12 = level.var_5A23[param_00.var_336].var_74C1;
      }

      var_13 = anglesToForward(level.var_5A23[param_00.var_336].var_5A2A.angles);
      var_14 = anglesToForward(level.var_5A23[param_00.var_336].var_5A24 + (0, var_12, 0));
      param_02 connectpaths();
      var_15 = "ges_doorpeek_bash";
      var_16 = func_12AB(param_00.var_336, var_06);
      if(isDefined(var_16)) {
        var_15 = var_16;
      }

      level.player playgestureviewmodel(var_15);
      param_00 playSound("doorpeek_" + func_1299(var_03) + "_bash");
      level notify(param_00.var_336 + "door_peek_bash_open");
      level notify("door_peek_bash_open");
      if(param_01 != var_06) {
        var_17 = anglesToForward(level.var_5A23[param_00.var_336].var_5A24);
        var_18 = acos(clamp(vectordot(var_13, var_17), -1, 1));
        var_19 = acos(clamp(vectordot(var_14, var_17), -1, 1));
        var_1A = var_18 / var_11;
        var_1B = var_19 / var_11;
        level.var_5A23[param_00.var_336].var_5A2A rotateto(level.var_5A23[param_00.var_336].var_5A24, var_1A, 0, 0);
        wait(var_1A);
        level.var_5A23[param_00.var_336].var_5A2A rotateto(level.var_5A23[param_00.var_336].var_5A24 + (0, var_12, 0), var_1B, 0, 0);
        wait(var_1B);
      } else {
        var_1C = acos(clamp(vectordot(var_13, var_14), -1, 1));
        var_1D = var_1C / var_11;
        level.var_5A23[param_00.var_336].var_5A2A rotateto(level.var_5A23[param_00.var_336].var_5A24 + (0, var_12, 0), var_1D, 0, 0);
        wait(var_1D);
      }

      wait(0.05);
      param_02 disconnectpaths();
      level.var_5A23[param_00.var_336].var_5A2A delete();
      level notify(param_00.var_336 + "door_peek_finished");
      level notify("door_peek_finished");
      break;
    }

    wait(0.05);
  }
}

func_11FC(param_00) {
  var_01 = level.var_5A23[param_00.var_336].var_5A25;
  var_02 = anglesToForward(level.var_5A23[param_00.var_336].var_5A2A.angles);
  var_03 = -1 * anglestoright(level.var_5A23[param_00.var_336].var_5A2A.angles);
  var_04 = level.player.origin - var_01.origin;
  var_05 = vectornormalize(var_04);
  var_06 = level.var_5A23[param_00.var_336].var_5A58 + 8;
  var_07 = 48;
  if(distance(level.player.origin, var_01.origin) > var_06 + var_07) {
    return undefined;
  }

  if(vectordot(var_04, var_02) < 0) {
    var_08 = 0;
  } else {
    var_08 = 1;
  }

  if(!var_08) {
    var_09 = vectordot(var_05, var_03);
    if(var_09 <= 0) {
      return undefined;
    }

    var_0A = abs(length(var_04) * var_09);
    if(var_0A > var_06) {
      return undefined;
    }

    var_0B = -1 * var_02;
    var_09 = vectordot(var_05, var_0B);
    var_0A = abs(length(var_04) * var_09);
    if(var_0A > var_07) {
      return undefined;
    }
  } else {
    var_09 = vectordot(var_07, var_05);
    if(var_0A <= 0) {
      return undefined;
    }

    var_0A = abs(length(var_05) * var_0A);
    if(var_0A > var_06) {
      return undefined;
    }

    var_09 = vectordot(var_05, var_02);
    var_0A = abs(length(var_04) * var_09);
    if(var_0A > var_07) {
      return undefined;
    }
  }

  return var_08;
}

func_12F4(param_00) {
  var_01 = scripts\engine\utility::getstructarray("door_peek_struct", "script_noteworthy");
  var_02 = [];
  foreach(var_04 in var_01) {
    var_02[var_02.size] = var_04.var_336;
  }

  var_06 = undefined;
  var_07 = undefined;
  foreach(var_09 in var_02) {
    if(!isDefined(level.var_5A23[var_09]) || !isDefined(level.var_5A23[var_09].var_5A25)) {
      continue;
    }

    var_0A = distance(level.player.origin, level.var_5A23[var_09].var_5A25.origin);
    if(!isDefined(var_06) || var_0A < var_06) {
      var_06 = var_0A;
      var_07 = var_09;
    }
  }

  if(var_07 == param_00) {
    return 1;
  }

  return 0;
}

func_11FD(param_00) {
  var_01 = undefined;
  foreach(var_03 in scripts\engine\utility::getstructarray("door_peek_struct", "script_noteworthy")) {
    if(var_03.var_336 == param_00.var_336) {
      var_01 = var_03;
      break;
    }
  }

  var_05 = param_00.var_336;
  var_06 = level.var_5A23[var_05].var_C9FE;
  var_07 = anglesToForward(level.var_5A23[param_00.var_336].var_5A25.angles);
  var_08 = -1 * anglestoright(level.var_5A23[param_00.var_336].var_5A25.angles);
  var_09 = level.var_5A23[param_00.var_336].var_5A25.origin + var_07 * var_06.var_11782 * -0.5;
  var_0A = level.player.origin - var_09;
  var_0B = vectornormalize(var_0A);
  var_0C = level.var_5A23[var_05].var_5A58 + 8;
  var_0D = 48;
  if(distance(level.player.origin, var_09) > var_0C + var_0D) {
    return undefined;
  }

  if(vectordot(var_0A, var_07) < 0) {
    var_0E = 0;
  } else {
    var_0E = 1;
  }

  if(!var_0E) {
    var_0F = vectordot(var_0B, var_08);
    if(var_0F <= 0) {
      return undefined;
    }

    var_10 = abs(length(var_0A) * var_0F);
    if(var_10 > var_0C) {
      return undefined;
    }

    var_11 = -1 * var_07;
    var_0F = vectordot(var_0B, var_11);
    var_10 = abs(length(var_0A) * var_0F);
    if(var_10 > var_0D) {
      return undefined;
    }
  } else {
    var_0F = vectordot(var_0D, var_0A);
    if(var_10 <= 0) {
      return undefined;
    }

    var_10 = abs(length(var_0B) * var_10);
    if(var_10 > var_0C) {
      return undefined;
    }

    var_0F = vectordot(var_0B, var_07);
    var_10 = abs(length(var_0A) * var_0F);
    if(var_10 > var_0D) {
      return undefined;
    }
  }

  return var_0E;
}

func_11F9(param_00, param_01, param_02, param_03, param_04, param_05) {
  level.player endon("death");
  var_06 = param_01.var_EE52;
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_07 = 0.2;
  if(!param_02) {
    level.player scripts\engine\utility::delaycall(var_07, ::stopgestureviewmodel, "ges_doorpeek_" + func_1297(var_06));
  } else {
    level.player scripts\engine\utility::delaycall(var_07, ::stopgestureviewmodel, "ges_doorpeek_" + func_1297(var_06) + "_r");
  }

  level.player scripts\engine\utility::delaycall(var_07, ::stopgestureviewmodel, "ges_drophand");
  level.player scripts\engine\utility::delaycall(var_07, ::stopgestureviewmodel, "ges_doorpeek_civlever_r");
  param_01 stoploopsound("doorpeek_" + func_1299(var_06) + "_move_loop");
  level notify(param_00 + "door_peek_start_detach");
  level notify("door_peek_start_detach");
  var_08 = undefined;
  if(!param_03) {
    var_08 = level.player scripts\engine\utility::spawn_tag_origin();
    level.player playerlinktodelta(var_08, "tag_origin", 1, 90, 90, 90, 90, 0);
  }

  func_1200();
  var_09 = level.var_5A23[param_00].var_C9FD gettagangles("tag_player");
  var_0A = level.player getplayerangles();
  level.var_5A23[param_00].var_C9FD delete();
  level notify(param_00 + "door_peek_detach");
  if(!param_03) {
    if(scripts\engine\utility::flag("doorpeek_hand_on_door")) {
      var_0B = level.player getplayerangles(1);
      var_0C = scripts\sp\utility::func_10639("player_rig", level.player.origin, var_0B);
      var_0D = level.player _meth_84C6("currentViewModel");
      if(isDefined(var_0D)) {
        var_0C setModel(var_0D);
      }

      var_0E = (0, 0, 0);
      var_0F = (var_09[0] - var_0A[0], var_09[1] - var_0A[1], 0);
      var_0C _meth_81E2(level.player, "tag_origin", (0, 0, 0) + var_0E, var_0F, 0);
      if(!param_02) {
        var_0C thread scripts\sp\anim::func_1F35(var_0C, "doorpeek_" + func_1297(var_06) + "_out");
      } else {
        var_0C thread scripts\sp\anim::func_1F35(var_0C, "doorpeek_" + func_1297(var_06) + "_r_out");
      }

      var_0C scripts\engine\utility::delaycall(0.2, ::delete);
    }

    var_10 = func_12A1(param_00, param_02);
    var_11 = 0.2;
    var_08 moveto(var_10, var_11, var_11 / 2, 0);
    if(param_01.var_EE52 == "airlock") {
      level.player scripts\sp\utility::func_2B76(0);
    }

    level.player getrawbaseweaponname(0.4, 0.4);
    wait(var_11);
    wait(0.05);
    level.player unlink();
    if(param_01.var_EE52 == "airlock") {
      level.player scripts\sp\utility::func_2B76(0.25, 0.5);
      level.player scripts\engine\utility::delaythread(0.5, ::scripts\sp\utility::func_2B76, 1, 0.7);
    }

    level.player getrawbaseweaponname(0.6, 0.6);
    level.player scripts\engine\utility::delaycall(0.5, ::_meth_80A6);
  }

  if(!isDefined(param_04) || param_04 == 0) {
    level.var_5A23[param_00].var_5A2A delete();
  }

  if(!isDefined(param_05) || param_05 == 0) {
    level.var_5A23[param_00].var_59FF delete();
    if(isDefined(level.var_5A23[param_00].var_A5A9)) {
      level.var_5A23[param_00].var_A5A9 delete();
    }

    if(isDefined(level.var_5A23[param_00].var_A5AA)) {
      level.var_5A23[param_00].var_A5AA delete();
    }
  }

  level.player.dontmelee = undefined;
}

func_11D6(param_00, param_01, param_02) {
  var_03 = level.player scripts\engine\utility::spawn_tag_origin();
  level.player playerlinktodelta(var_03, "tag_origin", 1, 90, 90, 90, 90, 0);
  var_04 = level.player getplayerangles();
  if(!isDefined(param_02) || !param_02) {
    if(isDefined(level.var_5A23[param_00].var_C9FD)) {
      level.var_5A23[param_00].var_C9FD delete();
    }
  } else if(isDefined(level.var_5A23[param_00].var_A5AE)) {
    level.var_5A23[param_00].var_A5AE delete();
  }

  var_05 = func_12A1(param_00, param_01);
  var_03.origin = var_05;
  wait(0.05);
  level.player unlink();
  var_03 delete();
}

func_12A1(param_00, param_01) {
  var_02 = level.var_5A23[param_00].var_5978;
  var_03 = 12;
  var_04 = 17;
  if(!param_01) {
    var_05 = anglesToForward(level.var_5A23[param_00].var_5A25.angles);
    var_06 = anglesToForward(level.var_5A23[param_00].var_59FF.angles) * -1;
    var_07 = func_794C(param_00);
    var_08 = level.var_5A23[param_00].var_59FF.origin - level.var_5A23[param_00].var_5A25.origin;
    var_09 = rotatevector(var_08, (0, var_07, 0));
    var_0A = level.var_5A23[param_00].var_5A25.origin + var_09;
    var_0B = anglestoright(level.var_5A23[param_00].var_5A25.angles);
    var_0C = anglestoright(level.var_5A23[param_00].var_59FF.angles) * -1;
  } else {
    var_0D = -1;
    var_05 = anglesToForward(level.var_5A23[param_00].var_5A26.angles);
    var_06 = anglesToForward(level.var_5A23[param_00].var_5A00.angles) * -1;
    var_07 = func_794C(param_00) * -1;
    var_08 = level.var_5A23[param_00].var_5A00.origin - level.var_5A23[param_00].var_5A26.origin;
    var_09 = rotatevector(var_08, (0, var_07, 0));
    var_0A = level.var_5A23[param_00].var_5A26.origin + var_09;
    var_0B = anglestoright(level.var_5A23[param_00].var_5A26.angles) * -1;
    var_0C = anglestoright(level.var_5A23[param_00].var_5A00.angles) * -1;
  }

  var_0E = 0.2;
  var_0F = level.player.origin + var_06 * var_03 * -1;
  var_10 = var_0F - var_0A;
  var_10 = scripts\engine\utility::flatten_vector(var_10) * length2d(var_10);
  var_11 = vectordot(var_0B, var_10);
  if(var_11 < var_04) {
    var_12 = var_04 - var_11;
    var_13 = vectordot(var_0B, var_0C);
    var_14 = var_12 / var_13;
    var_0F = var_0F + var_0C * var_14;
  }

  var_15 = scripts\common\trace::ray_trace(var_0F + (0, 0, 32), var_0F + (0, 0, -100), undefined, scripts\common\trace::create_solid_ai_contents(1));
  var_16 = max(level.var_5A23[param_00].var_5A25.origin[2], var_15["position"][2]);
  var_0F = (var_0F[0], var_0F[1], var_16);
  return var_0F;
}

func_120D(param_00, param_01, param_02) {
  level.player endon("death");
  level endon(param_00 + "door_peek_kick");
  level endon(param_00 + "door_peek_detach");
  for(;;) {
    if(level.player _meth_819F()) {
      break;
    }

    wait(0.05);
  }

  level notify(param_00 + "door_peek_alert_enemies");
  level notify("door_peek_alert_enemies");
  level notify(param_00 + "door_peek_shoot");
}

func_11EA(param_00, param_01, param_02, param_03, param_04) {
  level.player endon("death");
  level endon(param_00 + "door_peek_kick");
  level endon(param_00 + "door_peek_opened_fully");
  level endon(param_00 + "door_peek_sprint");
  level endon(param_00 + "door_peek_pop_open");
  if(isDefined(level.var_5A23[param_00].var_55B2) && level.var_5A23[param_00].var_55B2) {
    return;
  }

  level waittill(param_00 + "door_peek_start_peek_control");
  var_05 = 0;
  var_06 = 0;
  for(;;) {
    var_07 = func_1296(param_00, param_02);
    if(var_05 < -0.5 && var_07 < -0.5) {
      var_06++;
    } else {
      var_06 = 0;
    }

    if(var_06 >= 2) {
      break;
    }

    var_05 = var_07;
    wait(0.05);
  }

  level notify(param_00 + "door_peek_back_off");
  level notify("door_peek_back_off");
  var_08 = 70;
  var_09 = level.var_5A23[param_00].var_5A57;
  if(var_09 == "airlock" || var_09 == "airlocksdf" || var_09 == "airlockcombat" || var_09 == "airlockcombatsdf") {
    var_08 = 60;
  }

  if(func_794C(param_00) < var_08) {
    thread func_11F9(param_00, param_01, param_02, 0, 1);
    thread func_120B(param_01, param_02, param_03);
    return;
  }

  thread func_1210(param_00, param_02);
}

func_1209(param_00, param_01, param_02, param_03) {
  level.player endon("death");
  level endon(param_00 + "door_peek_kick");
  level endon(param_00 + "door_peek_opened_fully");
  level endon(param_00 + "door_peek_back_off");
  if(isDefined(level.var_5A23[param_00].var_560A) && level.var_5A23[param_00].var_560A) {
    return;
  }

  level waittill(param_00 + "door_peek_start_peek_control");
  for(;;) {
    if(!param_02 && level.var_5A23[param_00].var_5A21 >= 28) {
      break;
    } else if(param_02 && level.var_5A23[param_00].var_5A21 <= -28) {
      break;
    }

    wait(0.05);
  }

  var_04 = 112;
  var_05 = 100;
  var_06 = 0;
  for(;;) {
    var_07 = 0;
    var_08 = level.player getnormalizedmovement();
    if(var_08[0] <= 0.5 && var_08[1] <= 0.5) {
      wait(0.05);
      continue;
    }

    var_09 = vectornormalize((var_08[0], 0 - var_08[1], 0));
    var_0A = vectortoangles(var_09);
    var_0B = level.player getplayerangles(1);
    var_0C = combineangles(var_0B, var_0A);
    var_0D = anglesToForward(var_0C);
    var_0E = level.player getplayerangles(1);
    var_0F = anglesToForward(var_0E);
    if(!param_02) {
      var_10 = anglesToForward(level.var_5A23[param_00].var_59FF.angles + (0, 180, 0));
    } else {
      var_10 = anglesToForward(level.var_5A23[param_00].var_5A00.angles + (0, 180, 0));
    }

    var_11 = acos(clamp(vectordot(var_10, var_0F), -1, 1));
    if(var_11 >= var_04) {
      var_12 = acos(clamp(vectordot(var_10, var_0D), -1, 1));
      if(var_11 >= var_05) {
        var_06++;
      }
    } else {
      var_06 = 0;
    }

    if(var_06 >= 1) {
      break;
    }

    wait(0.05);
  }

  if(isDefined(level.var_5A23[param_00].var_560A) && level.var_5A23[param_00].var_560A) {
    return;
  }

  level notify(param_00 + "door_peek_pop_open");
  thread func_1210(param_00, param_02);
}

func_120F(param_00, param_01, param_02, param_03) {
  level endon(param_00 + "door_peek_kick");
  level endon(param_00 + "door_peek_opened_fully");
  level endon(param_00 + "door_peek_back_off");
  level waittill(param_00 + "door_peek_start_peek_control");
  for(;;) {
    if(level.player issprinting()) {
      break;
    }

    wait(0.05);
  }

  level notify(param_00 + "door_peek_sprint");
  thread func_1210(param_00, param_02);
}

func_1296(param_00, param_01) {
  var_02 = level.player getnormalizedmovement();
  var_03 = level.var_5A23[param_00].var_5978;
  if(!param_01) {
    var_04 = anglesToForward(level.var_5A23[param_00].var_5A25.angles);
    var_05 = anglesToForward(level.var_5A23[param_00].var_59FF.angles) * -1;
  } else {
    var_04 = anglesToForward(level.var_5A23[var_02].var_5A26.angles);
    var_05 = anglesToForward(level.var_5A23[param_01].var_5A00.angles) * -1;
  }

  var_06 = 0;
  var_07 = vectornormalize((var_02[0], 0 - var_02[1], 0));
  var_08 = vectortoangles(var_07);
  var_09 = level.player getplayerangles(1);
  var_0A = combineangles(var_09, var_08);
  var_0B = anglesToForward(var_0A);
  var_0C = level.player getplayerangles(1);
  var_0D = anglesToForward(var_0C);
  var_0E = level.player getEye() + (0, 0, -6) + 16 * anglesToForward(level.player.angles);
  var_0F = min(1, sqrt(squared(var_02[0]) + squared(var_02[1])));
  if(var_0F <= 0.1) {
    return 0;
  }

  if(var_0F >= 0.95) {
    var_0F = 1;
  }

  var_10 = acos(clamp(vectordot(var_0B, var_04), -1, 1));
  var_11 = acos(clamp(vectordot(var_0B, var_0D), -1, 1));
  var_12 = acos(clamp(vectordot(var_0B, var_05), -1, 1));
  var_13 = func_54E3(var_0B, var_05, var_0D);
  var_14 = 0.25;
  var_15 = 20;
  var_16 = 90;
  if(var_10 < 90 || var_13 || var_12 < 90) {
    var_17 = 1;
    if(var_13) {} else {
      var_18 = min(var_10, var_11);
      var_18 = min(var_18, var_12);
      if(var_18 > var_15) {
        if(var_18 <= var_16) {
          var_19 = var_18 - var_15;
          var_17 = 1 - 1 - var_14 * var_19 / var_16 - var_15;
        } else {
          var_17 = 0;
        }
      }
    }

    var_1A = min(var_0F, var_17);
    return var_1A;
  }

  var_17 = 1;
  var_1A = min(var_10, var_1A) * -1;
  return var_1A;
}

func_54E3(param_00, param_01, param_02) {
  var_03 = acos(clamp(vectordot(param_01, param_02), -1, 1));
  var_04 = acos(clamp(vectordot(param_00, param_01), -1, 1));
  var_05 = acos(clamp(vectordot(param_00, param_02), -1, 1));
  var_06 = 1;
  if(abs(var_04 + var_05 - var_03) <= var_06) {
    return 1;
  }

  return 0;
}

func_59BE(param_00, param_01, param_02, param_03) {
  level.player endon("death");
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(param_01) {
    level endon(param_00 + "door_peek_main_side_used");
  } else {
    level endon(param_00 + "door_peek_reverse_side_used");
  }

  level endon(param_00 + "door_peek_deleted");
  level endon(param_00 + "door_peek_start_detach");
  level endon(param_00 + "door_peek_restarted");
  if(!scripts\engine\utility::flag_exist(param_00 + "door_peek_can_kick")) {
    scripts\engine\utility::flag_init(param_00 + "door_peek_can_kick");
  }

  if(!scripts\engine\utility::flag_exist(param_00 + "door_peek_handle_down")) {
    scripts\engine\utility::flag_init(param_00 + "door_peek_handle_down");
  }

  if(!scripts\engine\utility::flag_exist(param_00 + "did_kick_interrupt_input")) {
    scripts\engine\utility::flag_init(param_00 + "did_kick_interrupt_input");
  }

  var_04 = getEntArray(param_00, "targetname");
  var_04 = scripts\engine\utility::array_combine(var_04, scripts\engine\utility::getstructarray(param_00, "targetname"));
  var_05 = func_12A6(var_04, "door_peek_door");
  var_06 = var_05.var_EE52;
  var_07 = 0;
  if(var_06 == "airlock") {
    var_07 = 1;
  }

  func_59D5(param_00, 1);
  if(var_06 == "airlock" || var_06 == "airlockcombat") {
    var_05 scripts\sp\dooruse::func_1AB6("unlocked");
  }

  thread func_1211(param_00, param_01, param_02, var_07);
  var_08 = 1;
  if(isDefined(param_03) && param_03 == 1) {
    var_08 = 0;
  }

  level waittill(param_00 + "door_peek_start");
  while(level.player usebuttonpressed()) {
    wait(0.05);
  }

  if(var_06 == "airlock") {
    func_1159(1, param_00);
  } else {
    func_1159(0, param_00);
  }

  thread func_1414(param_00);
  if(var_08) {
    for(;;) {
      scripts\engine\utility::flag_clear(param_00 + "did_kick_interrupt_input");
      thread func_11F1(param_00);
      scripts\engine\utility::flag_wait(param_00 + "did_kick_interrupt_input");
      if(isDefined(level.var_5A23[param_00].var_55F5) && level.var_5A23[param_00].var_55F5) {
        return;
      }

      level notify(param_00 + "remove_hint_text");
      level.var_5A23[param_00].var_A5AB = 1;
      scripts\engine\utility::flag_wait(param_00 + "door_peek_can_kick");
      level notify(param_00 + "door_peek_kick");
      level notify("door_peek_kick");
      thread func_59A4();
      scripts\engine\utility::waitframe();
      if(var_06 != "airlock") {
        thread func_11F0(param_00, param_01);
      } else {
        thread func_11ED(param_00);
      }

      if(var_07) {
        level waittill(param_00 + "door_kick_multi_kick_ready");
        func_1159(1, param_00);
        thread func_1414(param_00);
        continue;
      }

      break;
    }
  }
}

func_59D5(param_00, param_01) {
  var_02 = func_794D(param_00);
  var_03 = var_02.model;
  if(param_01) {
    if(scripts\sp\utility::hastag(var_03, "tag_locked")) {
      var_02 hidepart("tag_locked", var_03);
    }

    if(scripts\sp\utility::hastag(var_03, "tag_unlocked")) {
      var_02 giveperk("tag_unlocked", var_03);
    }

    if(scripts\sp\utility::hastag(var_03, "door_locked")) {
      var_02 hidepart("door_locked", var_03);
    }

    if(scripts\sp\utility::hastag(var_03, "door_unlocked")) {
      var_02 giveperk("door_unlocked", var_03);
    }

    if(scripts\sp\utility::hastag(var_03, "door_inactive")) {
      var_02 hidepart("door_inactive", var_03);
      return;
    }

    return;
  }

  if(scripts\sp\utility::hastag(var_03, "tag_locked")) {
    var_02 giveperk("tag_locked", var_03);
  }

  if(scripts\sp\utility::hastag(var_03, "tag_unlocked")) {
    var_02 hidepart("tag_unlocked", var_03);
  }

  if(scripts\sp\utility::hastag(var_03, "door_locked")) {
    var_02 giveperk("door_locked", var_03);
  }

  if(scripts\sp\utility::hastag(var_03, "door_unlocked")) {
    var_02 hidepart("door_unlocked", var_03);
  }

  if(scripts\sp\utility::hastag(var_03, "door_inactive")) {
    var_02 hidepart("door_inactive", var_03);
  }
}

func_59A4() {
  wait(0.75);
  level.player playrumbleonentity("grenade_rumble");
  earthquake(0.35, 0.75, level.player.origin, 200);
  lib_0F18::func_10E8A("broadcast", "attack", level.player getEye(), 800);
}

func_1159(param_00, param_01) {
  if(isDefined(level.var_5A23[param_01].var_C067)) {
    return;
  }

  scripts\engine\utility::flag_set("show_peek_hint");
  if(isDefined(level.var_5A23[param_01].var_C9F9)) {
    if(level.console || level.player usinggamepad()) {
      scripts\sp\utility::func_56BA("peek_only_hint");
      return;
    }

    scripts\sp\utility::func_56BA("peek_only_hint_pc");
    return;
  }

  if(!isDefined(param_00) || param_00 == 0) {
    if(level.console || level.player usinggamepad()) {
      scripts\sp\utility::func_56BA("peek_hint");
      return;
    }

    scripts\sp\utility::func_56BA("peek_hint_pc");
    return;
  }

  if(level.console || level.player usinggamepad()) {
    scripts\sp\utility::func_56BA("peek_hint_shove");
    return;
  }

  scripts\sp\utility::func_56BA("peek_hint_shove_pc");
}

func_1414(param_00) {
  level scripts\engine\utility::waittill_any_3(param_00 + "door_peek_start_detach", param_00 + "remove_hint_text");
  scripts\engine\utility::flag_clear("show_peek_hint");
}

func_794C(param_00) {
  if(!isDefined(level.var_5A23[param_00])) {
    return 0;
  } else if(!isDefined(level.var_5A23[param_00].var_5A2A)) {
    return 180;
  }

  var_01 = func_12AE(param_00);
  return var_01;
}

func_59C9(param_00) {
  level.var_5A23[param_00].var_72C6 = 1;
}

func_F366(param_00, param_01) {
  level.var_5A23[param_00].var_B7C6 = param_01;
}

func_551D(param_00) {
  level notify(param_00 + "door_peek_disabled");
}

func_12AE(param_00) {
  var_01 = abs(level.var_5A23[param_00].var_5A2A.angles[1] - level.var_5A23[param_00].var_5A24[1]);
  if(var_01 > 180) {
    var_01 = 360 - var_01;
  }

  return var_01;
}

func_11F1(param_00) {
  level endon(param_00 + "door_peek_start_detach");
  level endon(param_00 + "door_peek_restarted");
  if(level.console || level.player usinggamepad()) {
    level.player waittill("kick_pressed");
  } else {
    level.player waittill("kick_pressed_pc");
  }

  scripts\engine\utility::flag_set(param_00 + "did_kick_interrupt_input");
}

func_1201() {
  level.player scripts\sp\utility::func_1C49(0);
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_melee(0);
  level.player scripts\engine\utility::allow_jump(0);
  level.player scripts\engine\utility::allow_usability(0);
  level.player disableweaponpickup();
  level.player scripts\sp\utility::func_1C72(0);
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(0);
}

func_1200() {
  level.player scripts\sp\utility::func_1C49(1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_prone(1);
  level.player scripts\engine\utility::allow_melee(1);
  level.player scripts\engine\utility::allow_jump(1);
  level.player scripts\engine\utility::allow_usability(1);
  level.player enableweaponpickup();
  level.player scripts\sp\utility::func_1C72(1);
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(1);
}

func_1205() {
  level.player scripts\engine\utility::allow_fire(0);
  level.player scripts\engine\utility::allow_reload(0);
  level.player scripts\engine\utility::allow_ads(0);
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  level.player scripts\engine\utility::allow_weapon_switch(0);
}

func_1204() {
  level.player scripts\engine\utility::allow_fire(1);
  level.player scripts\engine\utility::allow_reload(1);
  level.player scripts\engine\utility::allow_ads(1);
  level.player scripts\engine\utility::allow_offhand_weapons(1);
  level.player scripts\engine\utility::allow_weapon_switch(1);
}

func_11EF() {
  level.player scripts\engine\utility::allow_fire(0);
  level.player scripts\engine\utility::allow_reload(0);
  level.player scripts\engine\utility::allow_ads(0);
  level.player scripts\engine\utility::allow_offhand_weapons(0);
}

func_11EE() {
  level.player scripts\engine\utility::allow_fire(1);
  level.player scripts\engine\utility::allow_reload(1);
  level.player scripts\engine\utility::allow_ads(1);
  level.player scripts\engine\utility::allow_offhand_weapons(1);
}

func_11EC(param_00) {
  level endon(param_00 + "door_kick_newdoor_think");
  level endon(param_00 + "door_peek_opened_fully");
  var_01 = getEntArray(param_00, "targetname");
  var_01 = scripts\engine\utility::array_combine(var_01, scripts\engine\utility::getstructarray(param_00, "targetname"));
  var_02 = func_12A6(var_01, "door_peek_door");
  var_03 = func_12A6(var_01, "door_peek_clip");
  var_04 = var_02.var_EE52;
  var_03 linkto(var_02);
  var_05 = func_12A6(var_01, "door_kick_animstruct");
  var_06 = func_12A6(var_01, "door_kick_animstruct2");
  var_07 = var_05 scripts\engine\utility::spawn_tag_origin();
  var_08 = var_06 scripts\engine\utility::spawn_tag_origin();
  var_09 = var_02 scripts\engine\utility::spawn_tag_origin();
  var_09.angles = var_07.angles;
  var_0A = 90;
  var_0B = level.var_5A23[param_00].var_C9FE;
  var_0C = 120;
  var_0D = level.var_5A23[param_00].var_5A24 + (0, 0 - var_0B.var_47A3, 0);
  level notify(param_00 + "door_kick_start");
  func_11EF();
  level.var_5A23[param_00].var_59FF thread scripts\sp\anim::func_1F35(level.var_5A23[param_00].var_C9FD, "doorpeek_airlock_bash");
  var_0E = 0.2;
  var_0F = 2.4;
  var_10 = 1.1;
  var_11 = 140;
  var_12 = 140;
  var_13 = 0.8;
  wait(var_0E);
  level.var_5A23[param_00].var_C9D4 = 1;
  var_14 = level.var_5A23[param_00].var_5A21;
  var_15 = var_14 + var_11;
  var_15 = clamp(var_15, 0, var_12);
  var_16 = var_0D + (0, 0 - var_15, 0);
  level.var_5A23[param_00].var_5A2A rotateto(var_16, var_0F, 0, 0.2);
  var_02 thread scripts\engine\utility::play_sound_in_space("doorpeek_" + func_1299(var_04) + "_kick", var_02.origin);
  thread func_1351(param_00);
  wait(var_10);
  level thread scripts\sp\utility::func_C12D(param_00 + "door_kick_multi_kick_ready", 0.5);
  func_11F9(param_00, var_02, 0, 1, 1);
  func_1201();
  level notify(param_00 + "door_kick_open");
  level notify("door_kick_open");
  var_17 = var_07 func_12A0(0, 30, 0);
  var_18 = level.player scripts\engine\utility::spawn_tag_origin();
  level.player playerlinktodelta(var_18, "tag_origin", 1, 10, 10, 10, 10, 0);
  var_18 moveto(var_17, var_13, 0, 0.2);
  var_18 rotateto((var_18.angles[0], var_05.angles[1], var_18.angles[2]), 0.5, 0, 0.2);
  wait(var_13);
  func_11EE();
  level notify(param_00 + "stop_fake_origin_link");
  level notify(param_00 + "door_kick_finished");
  var_18.origin = getgroundposition(var_18.origin, 10, 30, 30);
  wait(0.05);
  var_18 delete();
  level.player unlink();
  func_1200();
}

func_11ED(param_00) {
  level endon(param_00 + "door_kick_newdoor_think");
  level endon(param_00 + "door_peek_opened_fully");
  var_01 = getEntArray(param_00, "targetname");
  var_01 = scripts\engine\utility::array_combine(var_01, scripts\engine\utility::getstructarray(param_00, "targetname"));
  var_02 = func_12A6(var_01, "door_peek_door");
  var_03 = func_12A6(var_01, "door_peek_clip");
  var_04 = var_02.var_EE52;
  var_03 linkto(var_02);
  var_05 = func_12A6(var_01, "door_kick_animstruct");
  var_06 = func_12A6(var_01, "door_kick_animstruct2");
  var_07 = var_05 scripts\engine\utility::spawn_tag_origin();
  var_08 = var_06 scripts\engine\utility::spawn_tag_origin();
  var_09 = var_02 scripts\engine\utility::spawn_tag_origin();
  var_09.angles = var_07.angles;
  var_0A = 90;
  var_0B = level.var_5A23[param_00].var_C9FE;
  var_0C = 120;
  var_0D = level.var_5A23[param_00].var_5A24 + (0, 0 - var_0B.var_47A3, 0);
  level notify(param_00 + "door_kick_start");
  func_11EF();
  level.var_5A23[param_00].var_59FF thread scripts\sp\anim::func_1F35(level.var_5A23[param_00].var_C9FD, "doorpeek_airlock_bash");
  level.player playgestureviewmodel("ges_doorpeek_airlock_bash", undefined, 1);
  var_0E = 0.2;
  var_0F = 1.75;
  var_10 = 0.75;
  var_11 = 90;
  var_12 = 90;
  var_13 = 0.5;
  var_14 = 0.5;
  wait(var_0E);
  level.var_5A23[param_00].var_C9D4 = 1;
  var_15 = level.var_5A23[param_00].var_5A21;
  var_16 = var_15 + var_11;
  var_16 = clamp(var_16, 0, var_12);
  var_17 = var_15 - var_16 * -1 / var_16;
  var_18 = clamp(var_17 * var_0F, var_10, var_0F);
  var_19 = clamp(var_18 - var_13, var_14, var_18);
  var_1A = var_0D + (0, 0 - var_16, 0);
  level.var_5A23[param_00].var_5A2A rotateto(var_1A, var_18, var_18 * 0.4, 0);
  var_02 playSound("doorpeek_" + func_1299(var_04) + "_shove");
  thread func_1351(param_00);
  scripts\engine\utility::delaythread(var_19, ::func_11EE);
  level.player scripts\engine\utility::delaycall(var_19, ::stopgestureviewmodel, "ges_doorpeek_airlock_bash", 0.2);
  wait(var_18);
  level.var_5A23[param_00].var_5A21 = var_16;
  level.var_5A23[param_00].var_C9D4 = 0;
  level notify(param_00 + "door_kick_finished");
  level notify("door_kick_finished");
  level thread scripts\sp\utility::func_C12D(param_00 + "door_kick_multi_kick_ready", 0.5);
}

func_1351(param_00) {
  level.player endon("death");
  level endon(param_00 + "door_kick_finished");
  var_01 = level.var_5A23[param_00].var_C9FE;
  var_02 = level.var_5A23[param_00].var_5A24 + (0, 0 - var_01.var_47A3, 0);
  var_03 = 40;
  for(;;) {
    var_04 = func_12AE(param_00) - var_01.var_47A3;
    var_05 = clamp(var_04 / var_01.var_B481, 0, 1) * var_01.var_B4AA - var_01.var_B7C1 + var_01.var_B7C1;
    level.player lerpviewangleclamp(0, 0, 0, var_01.setdevdvarifuninitialized, var_05, 20, 20);
    if(var_04 >= var_03) {
      var_06 = 1;
      level notify(param_00 + "door_peek_airlock_ally_move");
      level notify("door_peek_airlock_ally_move");
    }

    wait(0.05);
  }
}

func_11F2(param_00, param_01, param_02) {
  level endon(param_00 + "door_kick_newdoor_think");
  level.player.var_5818 = 1;
  thread func_11F3(param_00, param_01);
  level.player waittill("death");
  if(!isDefined(level.player.var_5A12) || !level.player.var_5A12) {
    func_11D6(param_00, param_01, 1);
    return;
  }

  level.player unlink();
  if(isDefined(level.var_5A23[param_00].var_A5AE)) {
    level.var_5A23[param_00].var_A5AE delete();
  }
}

func_11F3(param_00, param_01) {
  level.player endon("death");
  var_02 = [param_00 + "door_kick_newdoor_think"];
  level scripts\engine\utility::waittill_any_in_array_return(var_02);
  level.player.var_5818 = undefined;
}

func_11F0(param_00, param_01, param_02) {
  level.player endon("death");
  level endon(param_00 + "door_kick_newdoor_think");
  thread func_11F2(param_00, param_01, param_02);
  var_03 = getEntArray(param_00, "targetname");
  var_03 = scripts\engine\utility::array_combine(var_03, scripts\engine\utility::getstructarray(param_00, "targetname"));
  var_04 = func_12A6(var_03, "door_peek_door");
  var_05 = func_12A6(var_03, "door_peek_clip");
  var_06 = var_04.var_EE52;
  var_05 linkto(var_04);
  if(!param_01) {
    var_07 = level.var_5A23[param_00].var_A5A9;
  } else {
    var_07 = level.var_5A23[param_01].var_A5AA;
  }

  var_07.origin = var_07.origin + anglesToForward(var_07.angles) * -30;
  level notify(param_00 + "door_kick_start");
  level notify("door_kick_start");
  func_11F9(param_00, var_04, param_01, 1, 1, 1);
  func_1201();
  level.player.dontmelee = 1;
  if(!param_01) {
    var_08 = level.var_5A23[var_04.var_336].var_74C0;
  } else {
    var_08 = level.var_5A23[var_05.var_336].var_74C1;
  }

  var_09 = 0.65;
  var_0A = 0.3;
  var_0B = 0;
  var_0C = 0.05;
  var_0D = 0.2;
  var_0E = 1;
  if(func_1297(level.var_5A23[param_00].var_5A57) == "airlock") {
    var_09 = 0.65;
    var_0A = 0.7;
    var_0B = 0.05;
    var_0C = var_0A - 0.05;
    var_0D = 0.5;
  }

  var_0F = level.var_5A23[param_00].var_5A21;
  var_10 = var_0F - abs(var_08) * -1 / var_08;
  var_11 = clamp(var_10 * var_0A, var_0D, var_0A);
  var_12 = var_11 / var_0A;
  var_13 = var_0B * var_12;
  var_14 = var_0C * var_12;
  level.var_5A23[param_00].var_5A2A scripts\engine\utility::delaycall(var_09, ::rotateto, level.var_5A23[param_00].var_5A24 + (0, var_08, 0), var_11, var_13, var_14);
  level.var_5A23[param_00].var_5A2A scripts\engine\utility::delaycall(var_09 + var_11 + 0.05, ::delete);
  thread func_59A5(var_09 - 0.05);
  var_05 scripts\engine\utility::delaycall(var_09, ::connectpaths);
  var_05 scripts\engine\utility::delaycall(var_09 + var_0A + 0.05, ::disconnectpaths);
  var_04 scripts\engine\utility::delaythread(var_09, ::scripts\engine\utility::play_sound_in_space, "doorpeek_" + func_1299(var_06) + "_kick", var_04.origin);
  level thread scripts\sp\utility::func_C12D(param_00 + "door_kick_open", var_09);
  level thread scripts\sp\utility::func_C12D("door_kick_open", var_09);
  var_15 = "doorpeek_kick";
  var_16 = "ges_doorpeek_kick";
  var_17 = func_12AD(param_00, param_01);
  if(isDefined(var_17)) {
    var_16 = var_17;
  }

  func_11EF();
  scripts\engine\utility::delaythread(var_0E, ::func_11EE);
  var_18 = level.player getplayerangles(1);
  level.var_5A23[var_04.var_336].var_A5AE = scripts\sp\utility::func_10639("player_rig", level.player.origin, var_18);
  var_19 = level.player _meth_84C6("currentViewModel");
  if(isDefined(var_19)) {
    level.var_5A23[var_04.var_336].var_A5AE setModel(var_19);
  }

  var_07 thread scripts\sp\anim::func_1EC3(level.var_5A23[var_04.var_336].var_A5AE, var_15);
  var_1A = level.var_5A23[var_04.var_336].var_A5AE gettagorigin("tag_player");
  var_1B = var_07.origin - var_1A;
  var_1C = level.player.origin - var_1A;
  var_1D = var_18 - var_07.angles;
  var_1E = var_07.origin;
  var_1F = var_07.angles;
  var_07 unlink();
  var_07.origin = var_07.origin + var_1C;
  var_20 = vectornormalize(var_07.origin - level.player.origin);
  var_21 = distance(var_07.origin, level.player.origin);
  var_20 = rotatevector(var_20, var_1D);
  var_07.origin = level.player.origin + var_20 * var_21;
  var_07.angles = var_07.angles + var_1D;
  level.player playgestureviewmodel(var_16, undefined, 1, 0.2);
  var_07 thread scripts\sp\anim::func_1F35(level.var_5A23[var_04.var_336].var_A5AE, var_15);
  var_22 = getanimlength(level.var_5A23[var_04.var_336].var_A5AE scripts\sp\utility::func_7DC1(var_15));
  var_23 = 0.4;
  var_24 = 1.1;
  var_25 = 0.3;
  var_26 = 0.35;
  var_27 = 0.3;
  var_28 = 0.3;
  if(func_1297(level.var_5A23[param_00].var_5A57) == "airlock") {}

  level.player playerlinktoblend(level.var_5A23[var_04.var_336].var_A5AE, "tag_player", var_25, 0, 0);
  level.player scripts\engine\utility::delaycall(var_25, ::playerlinktodelta, level.var_5A23[var_04.var_336].var_A5AE, "tag_player", 1, 0, 0, 0, 0, 0);
  level.player scripts\engine\utility::delaycall(var_26, ::lerpviewangleclamp, var_27, 0, 0, 40, 40, 60, 10);
  wait(0.05);
  level.var_5A23[var_04.var_336].var_A5AE linkto(var_07);
  var_07 moveto(var_1E, var_23);
  var_07 rotateto(var_1F, var_23);
  wait(var_23);
  level.player scripts\sp\utility::func_2B76(0.2, 0.05);
  if(isDefined(param_02)) {
    var_29 = 0.7;
    wait(var_24 - var_23 - var_29);
    var_2A = var_07 func_12A0(-60, 0, 0);
    var_07 moveto(var_2A, var_29, 0.2, 0.1);
    wait(var_29);
  } else if(isDefined(level.var_5A1C)) {
    if(level.var_5A1C > 0) {
      wait(var_24 * level.var_5A1C);
    }

    var_07 scripts\sp\utility::anim_stopanimscripted();
  } else {
    wait(var_24 - var_23);
  }

  level notify(param_00 + "door_kick_finished");
  level notify("door_kick_finished");
  level notify(param_00 + "door_peek_finished");
  level notify("door_peek_finished");
  func_13C9("kick");
  level.player unlink();
  var_07 delete();
  level.var_5A23[var_04.var_336].var_A5AE delete();
  level.var_5A23[var_04.var_336].var_59FF delete();
  level.player scripts\sp\utility::func_2B76(1, var_28);
  func_1200();
  level.player.dontmelee = undefined;
  level notify(param_00 + "door_kick_newdoor_think");
  level.player.var_5A12 = undefined;
}

func_59A5(param_00) {
  level.player endon("death");
  wait(param_00);
  level.player.var_5A12 = 1;
}

func_59A2(param_00, param_01, param_02) {}

func_120E(param_00) {
  level endon(param_00 + "door_kick_newdoor_think");
  level waittill("doorpeek_handle");
  if(soundexists("doorpeek_" + func_1299(level.var_5A23[param_00].var_5A57) + "_handle")) {
    level.var_5A23[param_00].var_5978 playSound("doorpeek_" + func_1299(level.var_5A23[param_00].var_5A57) + "_handle");
    return;
  }

  var_01 = "doorpeek_" + func_1299(level.var_5A23[param_00].var_5A57) + "_handle";
}

func_12A6(param_00, param_01) {
  foreach(var_03 in param_00) {
    if(isDefined(var_03.script_noteworthy)) {
      if(var_03.script_noteworthy == param_01) {
        return var_03;
      }
    }
  }
}

func_12A0(param_00, param_01, param_02) {
  var_03 = self.origin + anglesToForward(self.angles) * param_00 + anglestoright(self.angles) * param_01 + anglestoup(self.angles) * param_02;
  return var_03;
}

func_59CF(param_00, param_01) {
  level.player endon("death");
  level endon(param_00 + "door_intro_done");
  if(!isDefined(param_01) || param_01 == 0) {
    level scripts\engine\utility::waittill_any_3(param_00 + "door_peek_kick", param_00 + "door_peek_back_off", param_00 + "door_peek_sprint");
  } else {
    level scripts\engine\utility::waittill_any_3(param_00 + "door_peek_back_off", param_00 + "door_peek_sprint");
  }

  func_1204();
}

func_13C9(param_00) {
  if(!isDefined(level.var_D9E5)) {
    return;
  }

  if(!isDefined(level.var_D9E5["achievementDoorPeek"])) {
    return;
  }

  if(param_00 == "open") {
    level.var_D9E5["achievementDoorPeek"]["achievementDoorPeekOpen"] = 1;
  } else if(param_00 == "kick") {
    level.var_D9E5["achievementDoorPeek"]["achievementDoorPeekKick"] = 1;
  } else if(param_00 == "grenade") {
    level.var_D9E5["achievementDoorPeek"]["achievementDoorPeekGrenade"] = 1;
  }

  lib_0A2F::func_3D6A(1);
}

func_12AC(param_00, param_01) {
  var_02 = level.player getcurrentweapon();
  if(!isDefined(var_02)) {
    return undefined;
  }

  var_03 = strtok(var_02, "+");
  var_02 = var_03[0];
  if(!isDefined(var_02)) {
    return undefined;
  }

  if(var_02 == "alt_iw7_erad") {
    var_04 = func_1297(level.var_5A23[param_00].var_5A57);
    if(var_04 == "bulkhead" || var_04 == "airlock" || var_04 == "civlever" && !param_01) {
      return "ges_doorpeek_civlever_r";
    }

    return;
  }

  if(var_02 == "iw7_mauler") {
    var_04 = func_1297(level.var_5A23[param_00].var_5A57);
    if(var_04 == "bulkhead" || var_04 == "airlock") {
      return "ges_doorpeek_civlever_r";
    }

    return;
  }

  if(var_02 == "iw7_steeldragon") {
    var_04 = func_1297(level.var_5A23[param_00].var_5A57);
    if(var_04 == "bulkhead" || var_04 == "airlock") {
      return "ges_doorpeek_civlever_r";
    }

    return;
  }
}

func_12AD(param_00, param_01) {
  var_02 = level.player getcurrentweapon();
  if(!isDefined(var_02)) {
    return undefined;
  }

  var_03 = strtok(var_02, "+");
  var_02 = var_03[0];
  if(!isDefined(var_02)) {
    return undefined;
  }

  if(var_02 == "alt_iw7_erad") {
    return "ges_doorpeek_kick_eradshotty";
  }
}

func_12AB(param_00, param_01) {
  var_02 = level.player getcurrentweapon();
  if(!isDefined(var_02)) {
    return undefined;
  }

  var_03 = strtok(var_02, "+");
  var_02 = var_03[0];
  if(!isDefined(var_02)) {
    return undefined;
  }

  if(var_02 == "alt_iw7_erad") {
    return "ges_doorpeek_bash_eradshotty";
  }
}

func_1466(param_00) {
  level.player endon("death");
  level endon(param_00 + "door_peek_kick");
  level endon(param_00 + "door_peek_detach");
  thread func_1465(param_00);
  level.var_5A23[param_00].var_13C81 = 0;
  var_01 = ["iw7_fmg", "alt_iw7_fmg"];
  var_02 = level.player getcurrentweapon();
  if(isDefined(var_02)) {
    var_03 = strtok(var_02, "+");
    var_02 = var_03[0];
    foreach(var_05 in var_01) {
      if(var_02 == var_05) {
        level.var_5A23[param_00].var_13C81 = 1;
        break;
      }
    }
  }

  if(level.var_5A23[param_00].var_13C81) {
    level.player scripts\engine\utility::allow_weapon_switch(0);
  }

  for(;;) {
    level.player waittill("weapon_change");
    var_07 = level.var_5A23[param_00].var_13C81;
    var_02 = level.player getcurrentweapon();
    if(isDefined(var_02)) {
      var_03 = strtok(var_02, "+");
      var_02 = var_03[0];
      foreach(var_05 in var_01) {
        if(var_02 == var_05) {
          level.var_5A23[param_00].var_13C81 = 1;
          break;
        }
      }
    }

    if(!var_07 && level.var_5A23[param_00].var_13C81) {
      level.player scripts\engine\utility::allow_weapon_switch(0);
      continue;
    }

    if(var_07 && !level.var_5A23[param_00].var_13C81) {
      level.player scripts\engine\utility::allow_weapon_switch(1);
    }
  }
}

func_1465(param_00) {
  level.player endon("death");
  level scripts\engine\utility::waittill_any_3(param_00 + "door_peek_kick", param_00 + "door_peek_detach");
  if(level.var_5A23[param_00].var_13C81) {
    level.player scripts\engine\utility::allow_weapon_switch(1);
  }
}

func_1298(param_00, param_01) {
  var_02 = spawnStruct();
  if(param_00 == "bulkhead" && !param_01) {
    var_02.var_119AB = 0.9;
    var_02.var_47A4 = 0.7;
    var_02.var_47A3 = 12;
    var_02.var_119D5 = 0.9;
    var_02.var_B7C1 = 0;
    var_02.var_B4AA = 70;
    var_02.setdevdvarifuninitialized = 8;
    var_02.var_B481 = 30;
    var_02.var_B4B9 = 4;
    var_02.var_11782 = 16;
  } else if((param_00 == "airlock" || param_00 == "airlocksdf") && !param_01) {
    var_02.var_119AB = 1;
    var_02.var_47A4 = 0.7;
    var_02.var_47A3 = 14;
    var_02.var_119D5 = 1.2;
    var_02.var_B7C1 = 2;
    var_02.var_B4AA = 90;
    var_02.setdevdvarifuninitialized = 8;
    var_02.var_B481 = 60;
    var_02.var_B4B9 = 1.5;
    var_02.var_11782 = 18;
  }

  if((param_00 == "airlockcombat" || param_00 == "airlockcombatsdf") && !param_01) {
    var_02.var_119AB = 1.2;
    var_02.var_47A4 = 0.7;
    var_02.var_47A3 = 22;
    var_02.var_119D5 = 1.2;
    var_02.var_B7C1 = 2;
    var_02.var_B4AA = 90;
    var_02.setdevdvarifuninitialized = 8;
    var_02.var_B481 = 60;
    var_02.var_B4B9 = 2;
    var_02.var_11782 = 18;
  } else if(param_00 == "armory" && !param_01) {
    var_02.var_119AB = 0.9;
    var_02.var_47A4 = 0.7;
    var_02.var_47A3 = 12;
    var_02.var_119D5 = 0.9;
    var_02.var_B7C1 = 0;
    var_02.var_B4AA = 140;
    var_02.setdevdvarifuninitialized = 13;
    var_02.var_B481 = 80;
    var_02.var_B4B9 = 4;
    var_02.var_11782 = 10;
  } else if(param_00 == "armoryajar" && !param_01) {
    var_02.var_119AB = 0.9;
    var_02.var_47A4 = 0.2;
    var_02.var_47A3 = 0;
    var_02.var_119D5 = 0.9;
    var_02.var_B7C1 = 0;
    var_02.var_B4AA = 140;
    var_02.setdevdvarifuninitialized = 13;
    var_02.var_B481 = 80;
    var_02.var_B4B9 = 4;
    var_02.var_11782 = 10;
  } else if(param_00 == "civlever" && !param_01) {
    var_02.var_119AB = 0.6;
    var_02.var_47A4 = 0.5;
    var_02.var_47A3 = 12;
    var_02.var_119D5 = 0.9;
    var_02.var_B7C1 = 9.5;
    var_02.var_B4AA = 70;
    var_02.setdevdvarifuninitialized = 5;
    var_02.var_B481 = 29;
    var_02.var_B4B9 = 4;
    var_02.var_11782 = 3;
  } else if(param_00 == "civlever" && param_01) {
    var_02.var_119AB = 0.6;
    var_02.var_47A4 = 0.5;
    var_02.var_47A3 = -12;
    var_02.var_119D5 = 0.9;
    var_02.var_B7C9 = 22;
    var_02.var_B4C1 = 70;
    var_02.setmatchdataid = 0;
    var_02.var_B481 = 40;
    var_02.var_B4B9 = 4;
    var_02.var_11782 = 3;
  } else if(param_00 == "civchurch1" && !param_01) {
    var_02.var_119AB = 0.6;
    var_02.var_47A4 = 0.5;
    var_02.var_47A3 = 12;
    var_02.var_119D5 = 0.9;
    var_02.var_B7C1 = 9.5;
    var_02.var_B4AA = 70;
    var_02.setdevdvarifuninitialized = 5;
    var_02.var_B481 = 29;
    var_02.var_B4B9 = 4;
    var_02.var_11782 = 3;
  } else if(param_00 == "civchurch1" && param_01) {
    var_02.var_119AB = 0.6;
    var_02.var_47A4 = 0.5;
    var_02.var_47A3 = -12;
    var_02.var_119D5 = 0.9;
    var_02.var_B7C9 = 22;
    var_02.var_B4C1 = 70;
    var_02.setmatchdataid = 0;
    var_02.var_B481 = 40;
    var_02.var_B4B9 = 4;
    var_02.var_11782 = 3;
  }

  return var_02;
}

func_1299(param_00) {
  if(param_00 == "bulkhead") {
    return "bulkhead";
  }

  if(param_00 == "airlock" || param_00 == "airlocksdf" || param_00 == "airlockcombat" || param_00 == "airlockcombatsdf") {
    return "airlock";
  }

  if(param_00 == "armory" || param_00 == "armoryajar") {
    return "armory";
  }

  if(param_00 == "civlever") {
    return "civleverwood";
  }

  if(param_00 == "civchurch1") {
    return "civhandlewood";
  }
}

func_1297(param_00) {
  if(param_00 == "bulkhead") {
    return "bulkhead";
  }

  if(param_00 == "airlock" || param_00 == "airlocksdf" || param_00 == "airlockcombat" || param_00 == "airlockcombatsdf") {
    return "airlock";
  }

  if(param_00 == "armory") {
    return "armory";
  }

  if(param_00 == "armoryajar") {
    return "armoryajar";
  }

  if(param_00 == "civlever" || param_00 == "civchurch1") {
    return "civlever";
  }
}

func_1206() {
  level.var_EC87["player_rig"] = #animtree;
  level.var_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level.var_EC85["player_rig"]["doorpeek_kick"] = % vm_doorpeek_kick;
  level.var_EC85["player_rig"]["doorpeek_airlock_kick"] = % wm_doorpeek_airlock_kick;
  level.var_EC85["player_rig"]["doorpeek_civlever_in"] = % wm_doorpeek_civlever_in;
  scripts\sp\anim::func_17F6("player_rig", "doorpeek_handle", ::func_5A1B, "doorpeek_civlever_in");
  level.var_EC85["player_rig"]["doorpeek_civlever_loop"][0] = % wm_doorpeek_civlever_loop;
  level.var_EC85["player_rig"]["doorpeek_civlever_out"] = % wm_doorpeek_civlever_out;
  level.var_EC85["player_rig"]["doorpeek_civlever_backon"] = % wm_doorpeek_civlever_backon;
  level.var_EC89["player_rig"]["doorpeek_civlever_backon"] = 0;
  level.var_EC85["player_rig"]["doorpeek_civlever_r_in"] = % wm_doorpeek_civlever_r_in;
  scripts\sp\anim::func_17F6("player_rig", "doorpeek_handle", ::func_5A1B, "doorpeek_civlever_r_in");
  level.var_EC85["player_rig"]["doorpeek_civlever_r_loop"][0] = % wm_doorpeek_civlever_r_loop;
  level.var_EC85["player_rig"]["doorpeek_civlever_r_out"] = % wm_doorpeek_civlever_r_out;
  level.var_EC85["player_rig"]["doorpeek_civlever_r_backon"] = % wm_doorpeek_civlever_r_backon;
  level.var_EC89["player_rig"]["doorpeek_civlever_r_backon"] = 0;
  level.var_EC85["player_rig"]["doorpeek_bulkhead_in"] = % wm_doorpeek_bulkhead_in;
  scripts\sp\anim::func_17F6("player_rig", "doorpeek_handle", ::func_5A1B, "doorpeek_bulkhead_in");
  level.var_EC85["player_rig"]["doorpeek_bulkhead_loop"][0] = % wm_doorpeek_bulkhead_loop;
  level.var_EC85["player_rig"]["doorpeek_bulkhead_out"] = % wm_doorpeek_bulkhead_out_b;
  level.var_EC85["player_rig"]["doorpeek_bulkhead_backon"] = % wm_doorpeek_bulkhead_backon;
  level.var_EC89["player_rig"]["doorpeek_bulkhead_backon"] = 0;
  level.var_EC85["player_rig"]["doorpeek_airlock_in"] = % wm_doorpeek_airlock_in;
  scripts\sp\anim::func_17F6("player_rig", "doorpeek_handle", ::func_5A1B, "doorpeek_airlock_in");
  level.var_EC85["player_rig"]["doorpeek_airlock_loop"][0] = % wm_doorpeek_airlock_loop;
  level.var_EC85["player_rig"]["doorpeek_airlock_out"] = % wm_doorpeek_airlock_out;
  level.var_EC85["player_rig"]["doorpeek_airlock_bash"] = % wm_doorpeek_airlock_bash;
  level.var_EC85["player_rig"]["doorpeek_airlock_backon"] = % wm_doorpeek_airlock_backon;
  level.var_EC89["player_rig"]["doorpeek_airlock_backon"] = 0;
  level.var_EC85["player_rig"]["doorpeek_armory_in"] = % wm_doorpeek_armory_in;
  scripts\sp\anim::func_17F6("player_rig", "doorpeek_handle", ::func_5A1B, "doorpeek_armory_in");
  level.var_EC85["player_rig"]["doorpeek_armory_loop"][0] = % wm_doorpeek_armory_loop;
  level.var_EC85["player_rig"]["doorpeek_armory_out"] = % wm_doorpeek_armory_out;
  level.var_EC85["player_rig"]["doorpeek_armory_backon"] = % wm_doorpeek_armory_backon;
  level.var_EC89["player_rig"]["doorpeek_armory_backon"] = 0;
  level.var_EC85["player_rig"]["doorpeek_armoryajar_in"] = % wm_doorpeek_armory_ajar_in;
  level.var_EC85["player_rig"]["doorpeek_armoryajar_loop"][0] = % wm_doorpeek_armory_ajar_loop;
  level.var_EC85["player_rig"]["doorpeek_armoryajar_out"] = % wm_doorpeek_armory_ajar_out;
  level.var_EC85["player_rig"]["doorpeek_armoryajar_backon"] = % wm_doorpeek_armory_ajar_backon;
  level.var_EC89["player_rig"]["doorpeek_armoryajar_backon"] = 0;
}

func_11FB() {
  level.var_EC85["generic"]["walk_cqb_f"][0] = % walk_cqb_f;
  level.var_EC85["generic"]["cqb_stand_idle"][0] = % cqb_stand_idle;
}

func_120C() {
  level.var_EC87["doorpeek_door"] = #animtree;
  level.var_EC85["doorpeek_door"]["doorpeek_civlever_in"] = % wm_doorpeek_bulkhead_in_door;
  level.var_EC85["doorpeek_door"]["doorpeek_bulkhead_in"] = % wm_doorpeek_bulkhead_in_door;
  level.var_EC85["doorpeek_door"]["doorpeek_airlock_in"] = % wm_doorpeek_airlock_in_door;
  level.var_EC85["doorpeek_door"]["doorpeek_armory_in"] = % wm_doorpeek_armory_in_door;
  level.var_EC85["doorpeek_door"]["doorpeek_armoryajar_in"] = % wm_doorpeek_armory_ajar_in_door;
}

func_5A1B(param_00) {
  level notify("doorpeek_handle");
}

func_59D9(param_00, param_01) {
  level.var_5A23[param_00].var_5A2A rotateto(level.var_5A23[param_00].var_5A24 + (0, -140, 0), param_01, 0, 0);
  level.var_5A23[param_00].var_5A2A scripts\engine\utility::delaycall(param_01 + 0.05, ::delete);
  level.var_5A23[param_00].var_5A03 connectpaths();
  level.var_5A23[param_00].var_5A03 scripts\engine\utility::delaycall(param_01 + 0.05, ::disconnectpaths);
  level.var_5A23[param_00].var_5978 playSound("doorpeek_" + func_1299(level.var_5A23[param_00].var_5A57) + "_swing_open");
  level.var_5A23[param_00].var_5978 scripts\engine\utility::delaycall(param_01, ::playsound, "doorpeek_" + func_1299(level.var_5A23[param_00].var_5A57) + "_hit_wall");
  level.var_5A23[param_00].var_5A56 hide();
  func_551D(param_00);
}