/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2846.gsc
**************************************/

func_11620(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = [level.var_5A23[var_0].var_5A25, level.var_5A23[var_0].var_5A2A];

  foreach(var_6 in var_4) {
    var_6 giveweaponpassives(var_1, var_2);
  }

  if(var_3) {
    _teleportscene();
  }

  level.var_5A23[var_0].var_5A24 = level.var_5A23[var_0].var_5A25.angles;
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

func_794D(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  var_2 = func_12A6(var_1, "door_peek_door");
  return var_2;
}

func_118F() {
  var_0 = scripts\engine\utility::getstructarray("door_peek_struct", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.spawnflags) && var_2.spawnflags & 1) {
      var_3 = getEntArray(var_2.targetname, "targetname");
      var_4 = scripts\engine\utility::getstructarray(var_2.targetname, "targetname");
      var_3 = scripts\engine\utility::array_combine(var_3, var_4);

      if(var_2.spawnflags & 2) {
        thread func_59BE(var_2.targetname);
      }

      if(var_2.spawnflags & 4) {
        thread func_59BE(var_2.targetname, 1);
      }

      continue;
    }

    func_59D5(var_2.targetname, 0);
    var_5 = getEntArray(var_2.targetname, "targetname");
    var_5 = scripts\engine\utility::array_combine(var_5, scripts\engine\utility::getstructarray(var_2.targetname, "targetname"));
    var_6 = func_12A6(var_5, "door_peek_door");
    var_7 = var_6.var_EE52;

    if(var_7 == "airlock" || var_7 == "airlockcombat") {
      var_6 func_0B1F::func_1AB5(0);
    }
  }
}

func_118E() {
  var_0 = scripts\engine\utility::getstructarray("door_peek_struct", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.targetname) && var_2.targetname == "door_peek_armory") {
      thread func_59BE(var_2.targetname);
    }
  }
}

func_11FA() {
  self give_mp_super_weapon(self.origin);
  scripts\sp\utility::func_F3E0(1);
  scripts\sp\utility::func_F415(1);
}

func_13B2(var_0, var_1) {
  level.player endon("death");

  if(!var_1) {
    level endon(var_0 + "door_peek_main_side_used");
    level waittill(var_0 + "door_peek_reverse_side_used");
  } else {
    level endon(var_0 + "door_peek_reverse_side_used");
    level waittill(var_0 + "door_peek_main_side_used");
  }

  func_0E46::func_DFE3();
  self.origin = self.ogorigin;
}

func_1207(var_0, var_1, var_2, var_3) {
  level endon(var_0 + "door_peek_deleted");
  level endon(var_0 + "door_peek_disabled");

  if(!isDefined(var_3) || var_3 == 0) {
    level endon(var_0 + "door_peek_kick");
  }

  level endon(var_0 + "door_peek_back_off");
  level endon(var_0 + "door_peek_sprint");
  level endon(var_0 + "door_peek_pop_open");
  level endon(var_0 + "door_kick_newdoor_think");
  level.player.var_5818 = 1;
  thread func_1208(var_0, var_1, var_2, var_3);
  level.player waittill("death");
  func_11D6(var_0, var_1);
}

func_1208(var_0, var_1, var_2, var_3) {
  level.player endon("death");
  var_4 = [var_0 + "door_peek_deleted", var_0 + "door_peek_disabled", var_0 + "door_peek_back_off", var_0 + "door_peek_sprint", var_0 + "door_peek_pop_open", var_0 + "door_kick_newdoor_think"];

  if(!isDefined(var_3) || var_3 == 0) {
    var_4[var_4.size] = var_0 + "door_peek_kick";
  }

  level scripts\engine\utility::waittill_any_in_array_return(var_4);
  level.player.var_5818 = undefined;
}

func_1211(var_0, var_1, var_2, var_3) {
  level.player endon("death");
  level endon(var_0 + "door_peek_deleted");
  level endon(var_0 + "door_peek_disabled");

  if(!isDefined(var_3) || var_3 == 0) {
    level endon(var_0 + "door_peek_kick");
  }

  level endon(var_0 + "door_peek_back_off");
  level endon(var_0 + "door_peek_sprint");
  level endon(var_0 + "door_peek_pop_open");

  if(!var_1) {
    level endon(var_0 + "door_peek_reverse_side_used");
  } else {
    level endon(var_0 + "door_peek_main_side_used");
  }

  if(!isDefined(level.var_5A23[var_0])) {
    level.var_5A23[var_0] = spawnStruct();
  }

  var_4 = getEntArray(var_0, "targetname");
  var_4 = scripts\engine\utility::array_combine(var_4, scripts\engine\utility::getstructarray(var_0, "targetname"));
  level.var_5A23[var_0].var_5978 = func_12A6(var_4, "door_peek_door");
  level.var_5A23[var_0].var_5A57 = level.var_5A23[var_0].var_5978.var_EE52;
  level.var_5A23[var_0].var_5978 scripts\sp\utility::func_23B7("doorpeek_door");
  var_5 = func_12A6(var_4, "door_peek_struct");

  if(!var_1) {
    var_6 = 1.0;
    var_7 = func_12A6(var_4, "door_peek_animstruct");
    level.var_5A23[var_0].var_5A25 = var_5 scripts\engine\utility::spawn_tag_origin();
    level.var_5A23[var_0].var_59FF = var_7 scripts\engine\utility::spawn_tag_origin();
    level.var_5A23[var_0].var_59FF.angles = var_7.angles + (0, 180, 0);
    level.var_5A23[var_0].var_59FF linkto(level.var_5A23[var_0].var_5978);
    level.var_5A23[var_0].var_5A58 = distance2d(level.var_5A23[var_0].var_5A25.origin, level.var_5A23[var_0].var_59FF.origin);
    var_8 = func_12A6(var_4, "door_kick_animstruct");
    level.var_5A23[var_0].var_A5A9 = var_8 scripts\engine\utility::spawn_tag_origin();
    level.var_5A23[var_0].var_A5A9 linkto(level.var_5A23[var_0].var_5A25);
    var_9 = -140.0;

    if(isDefined(var_5.var_EE0E)) {
      var_9 = var_5.var_EE0E * -1.0;
    }

    level.var_5A23[var_0].var_74C0 = var_9;
  } else {
    var_6 = -1.0;
    var_7 = func_12A6(var_4, "door_peek_animstruct_b");
    level.var_5A23[var_0].var_5A26 = var_5 scripts\engine\utility::spawn_tag_origin();
    level.var_5A23[var_0].var_5A26.angles = level.var_5A23[var_0].var_5A26.angles + (0, 180, 0);
    level.var_5A23[var_0].var_5A00 = var_7 scripts\engine\utility::spawn_tag_origin();
    level.var_5A23[var_0].var_5A00 linkto(level.var_5A23[var_0].var_5978);
    level.var_5A23[var_0].var_5A58 = distance2d(level.var_5A23[var_0].var_5A26.origin, level.var_5A23[var_0].var_5A00.origin);
    var_10 = func_12A6(var_4, "door_kick_animstruct_b");
    level.var_5A23[var_0].var_A5AA = var_10 scripts\engine\utility::spawn_tag_origin();
    level.var_5A23[var_0].var_A5AA linkto(level.var_5A23[var_0].var_5A26);
    var_9 = 140.0;

    if(isDefined(var_5.var_EE0D)) {
      var_9 = var_5.var_EE0D;
    }

    level.var_5A23[var_0].var_74C1 = var_9;
  }

  level.var_5A23[var_0].var_5A2A = var_5 scripts\engine\utility::spawn_tag_origin();
  level.var_5A23[var_0].var_5978 linkto(level.var_5A23[var_0].var_5A2A);
  level.var_5A23[var_0].var_5A24 = level.var_5A23[var_0].var_5A2A.angles;
  level.var_5A23[var_0].var_5A03 = func_12A6(var_4, "door_peek_clip");
  level.var_5A23[var_0].var_5A03 linkto(level.var_5A23[var_0].var_5978);
  level.var_5A23[var_0].var_5A56 = func_12A6(var_4, "door_peek_static_clip");

  if(!var_1) {
    var_11 = func_12A6(var_4, "door_kick_interact");
    level.var_5A23[var_0].var_4C26 = spawn("script_origin", var_11.origin);
    level.var_5A23[var_0].var_4C26.origin = var_11.origin;
    level.var_5A23[var_0].var_4C26.angles = var_11.angles;
    level.var_5A23[var_0].var_4C26 linkto(level.var_5A23[var_0].var_5978);
  } else {
    var_11 = func_12A6(var_4, "door_kick_interact_b");
    level.var_5A23[var_0].var_4C27 = spawn("script_origin", var_11.origin);
    level.var_5A23[var_0].var_4C27.origin = var_11.origin;
    level.var_5A23[var_0].var_4C27.angles = var_11.angles;
    level.var_5A23[var_0].var_4C27 linkto(level.var_5A23[var_0].var_5978);
  }

  level.var_5A23[var_0].var_C9D4 = 0;
  level.var_5A23[var_0].var_5A21 = 0;

  if(!var_1) {
    level.var_5A23[var_0].var_C9FE = func_1298(level.var_5A23[var_0].var_5A57, var_1);
  } else {
    level.var_5A23[var_0].var_C9FF = func_1298(level.var_5A23[var_0].var_5A57, var_1);
  }

  level.var_5A23[var_0].var_1B12 = 0;

  if(isDefined(level.var_5A23[var_0].var_5978.script_threshold)) {
    level.var_5A23[var_0].var_1B12 = level.var_5A23[var_0].var_5978.script_threshold;

    if(!var_1) {
      level.var_5A23[var_0].var_5A2A.angles = level.var_5A23[var_0].var_5A2A.angles - (0, level.var_5A23[var_0].var_1B12, 0);
    } else {
      level.var_5A23[var_0].var_5A2A.angles = level.var_5A23[var_0].var_5A2A.angles + (0, level.var_5A23[var_0].var_1B12, 0);
    }
  }

  wait 0.05;

  if(isDefined(level.var_5A23[var_0].var_4C1C)) {
    scripts\engine\utility::flag_wait(level.var_5A23[var_0].var_4C1C);
  }

  if(!isDefined(level.var_5A23[var_0].var_5978)) {
    level notify(var_0 + "door_peek_deleted");
  }

  func_11F8(var_0, var_1);
  thread func_1207(var_0, var_1, var_2, var_3);

  if(var_1) {
    level.var_5A23[var_0].var_5978 unlink();
    var_12 = level.var_5A23[var_0].var_C9FF.var_11782;
    level.var_5A23[var_0].var_5A2A.origin = level.var_5A23[var_0].var_5A2A.origin + var_12 * anglesToForward(level.var_5A23[var_0].var_5A26.angles);
    level.var_5A23[var_0].var_5978 linkto(level.var_5A23[var_0].var_5A2A);
  }

  thread func_120D(var_0, level.var_5A23[var_0].var_5978, level.var_5A23[var_0].var_5A03);
  childthread func_120E(var_0);

  if(!isDefined(var_2)) {
    if(level.var_5A23[var_0].var_5A57 != "airlock") {
      thread func_1209(var_0, level.var_5A23[var_0].var_5978, var_1, level.var_5A23[var_0].var_5A03);

      if(!var_1) {
        thread func_11EA(var_0, level.var_5A23[var_0].var_5978, var_1, level.var_5A23[var_0].var_5A03, level.var_5A23[var_0].var_5A25);
      } else {
        thread func_11EA(var_0, level.var_5A23[var_0].var_5978, var_1, level.var_5A23[var_0].var_5A03, level.var_5A23[var_0].var_5A26);
      }
    }
  }

  level.player.dontmelee = 1;
  level notify(var_0 + "door_peek_start");
  level notify("door_peek_start");
  thread scripts\engine\utility::flag_set_delayed(var_0 + "door_peek_can_kick", level.var_5A23[var_0].var_C9FE.var_119D5);

  if(var_1) {
    level notify(var_0 + "door_peek_reverse_side_used");
    level notify("door_peek_reverse_side_used");
  } else {
    level notify(var_0 + "door_peek_main_side_used");
    level notify("door_peek_main_side_used");
  }

  func_1201();
  func_1205();
  thread func_59CF(var_0, var_3);
  func_1202(var_0, var_1);
  thread func_1466(var_0);
  func_1204();
  thread func_11FE(var_0, var_1);
  thread func_120A(var_0, var_1);
  func_11F5(var_0, var_1, var_2);
  func_1210(var_0, var_1);
  level notify(var_0 + "door_kick_newdoor_think");
}

func_11F8(var_0, var_1) {
  level.player endon("death");
  level endon(var_0 + "door_peek_disabled");

  if(!var_1) {
    var_2 = level.var_5A23[var_0].var_4C26;
  } else {
    var_2 = level.var_5A23[var_0].var_4C27;
  }

  var_2.ogorigin = var_2.origin;
  var_2 func_0E46::func_48C4(undefined, (0, 0, 0), &"SCRIPT_DOORPEEK_OPEN", undefined, 512);
  var_2 thread func_13B2(var_0, var_1);
  var_2 thread func_11F6(var_0);
  var_3 = 0;

  if(level.var_5A23[var_0].var_5A57 == "armory" || level.var_5A23[var_0].var_5A57 == "armoryajar") {
    var_3 = 1;
  }

  var_2 thread func_11F7(level.var_5A23[var_0].var_5978, var_1, level.var_5A23[var_0].var_1B12, var_3);
  var_2 waittill("trigger", var_4);
  var_2.origin = var_2.ogorigin;
  level.var_5A23[var_0].var_5A56 hide();
}

func_11F6(var_0) {
  level.player endon("death");
  self endon("trigger");
  level waittill(var_0 + "door_peek_disabled");
  func_0E46::func_DFE3();
  self.origin = self.ogorigin;
}

func_1202(var_0, var_1) {
  if(!var_1) {
    var_2 = level.var_5A23[var_0].var_C9FE;
    var_3 = "ges_doorpeek_" + func_1297(level.var_5A23[var_0].var_5A57);
    var_4 = level.var_5A23[var_0].var_59FF;
    var_5 = "doorpeek_" + func_1297(level.var_5A23[var_0].var_5A57) + "_in";
  } else {
    var_2 = level.var_5A23[var_0].var_C9FF;
    var_3 = "ges_doorpeek_" + func_1297(level.var_5A23[var_0].var_5A57) + "_r";
    var_4 = level.var_5A23[var_0].var_5A00;
    var_5 = "doorpeek_" + func_1297(level.var_5A23[var_0].var_5A57) + "_r_in";
  }

  var_6 = func_12AC(var_0, var_1);

  if(isDefined(var_6)) {
    var_3 = var_6;
  }

  if(!scripts\engine\utility::flag(var_0 + "door_peek_handle_down")) {
    var_7 = 0.4;
    level.var_5A23[var_0].var_C9FD = scripts\sp\utility::func_10639("player_rig");
    var_8 = level.player _meth_84C6("currentViewModel");

    if(isDefined(var_8)) {
      level.var_5A23[var_0].var_C9FD setModel(var_8);
    }

    level.var_5A23[var_0].var_C9FD hide();
    childthread func_11CE(0.2, level.var_5A23[var_0].var_C9FD);
    var_4 thread scripts\sp\anim::func_1EC3(level.var_5A23[var_0].var_C9FD, var_5);
    var_9 = level.var_5A23[var_0].var_C9FD gettagorigin("tag_player");
    var_10 = level.player getplayerangles(1);
    var_11 = var_4.origin - var_9;
    var_12 = level.player.origin - var_9;
    var_13 = var_10 - var_4.angles + (0, 180, 0);
    var_14 = var_4.origin;
    var_15 = var_4.angles;
    var_4 unlink();
    var_4.origin = var_4.origin + var_12;
    var_16 = vectornormalize(var_4.origin - level.player.origin);
    var_17 = distance(var_4.origin, level.player.origin);
    var_16 = rotatevector(var_16, var_13);
    var_4.origin = level.player.origin + var_16 * var_17;
    var_4.angles = var_4.angles + var_13;
    var_18 = 0.6 - var_7;
    var_19 = distance(level.player.origin, var_9);
    var_20 = 20;
    var_21 = 40;
    var_22 = 0.0;

    if(var_19 > var_20) {
      var_22 = min((var_19 - var_20) / (var_21 - var_20), 1.0) * var_18;
    }

    var_23 = abs(var_13[1]);
    var_24 = 30;
    var_25 = 75;
    var_26 = 0.0;

    if(var_23 > var_24) {
      var_26 = min((var_23 - var_24) / (var_25 - var_24), 1.0) * var_18;
    }

    var_27 = max(var_22, var_26);
    var_28 = var_7 + var_27;
    scripts\engine\utility::flag_set("doorpeek_hand_on_door");

    if(var_27 > 0.0) {
      level.player scripts\engine\utility::delaycall(var_27, ::forceplaygestureviewmodel, var_3);
      var_4 thread scripts\sp\anim::func_1EC3(level.var_5A23[var_0].var_C9FD, var_5);
      var_4 scripts\engine\utility::delaythread(var_27, scripts\sp\anim::func_1F35, level.var_5A23[var_0].var_C9FD, var_5);

      if(level.var_5A23[var_0].var_5A57 != "civlever" && level.var_5A23[var_0].var_5A57 != "armoryajar") {
        level.var_5A23[var_0].var_5978 scripts\engine\utility::delaythread(var_27, scripts\sp\anim::func_1F35, level.var_5A23[var_0].var_5978, "doorpeek_" + func_1297(level.var_5A23[var_0].var_5A57) + "_in");
      }
    } else {
      level.player forceplaygestureviewmodel(var_3);
      var_4 thread scripts\sp\anim::func_1F35(level.var_5A23[var_0].var_C9FD, var_5);

      if(level.var_5A23[var_0].var_5A57 != "civlever" && level.var_5A23[var_0].var_5A57 != "armoryajar") {
        level.var_5A23[var_0].var_5978 thread scripts\sp\anim::func_1F35(level.var_5A23[var_0].var_5978, "doorpeek_" + func_1297(level.var_5A23[var_0].var_5A57) + "_in");
      }
    }

    level.player getweaponweight(level.var_5A23[var_0].var_C9FD, "tag_player", 0.2, 0.0, 0.0);
    wait 0.05;
    level.var_5A23[var_0].var_C9FD linkto(var_4);
    var_4 moveto(var_14, var_28);
    var_4 rotateto(var_15, var_28);
    level thread scripts\sp\utility::func_C12D(var_0 + "door_peek_blend_complete", var_28 + 0.1);
    level thread scripts\sp\utility::func_C12D("door_peek_blend_complete", var_28 + 0.1);
    var_4 scripts\engine\utility::delaycall(var_28 + 0.05, ::linkto, level.var_5A23[var_0].var_5978);

    if(var_27 > 0.0) {
      wait(var_27);
    }

    wait(var_2.var_119AB);
    scripts\engine\utility::flag_set(var_0 + "door_peek_handle_down");
    level notify(var_0 + "door_handle_down");
    level notify("door_handle_down");
  }

  if(!var_1) {
    level.player getweightedchanceroll(level.var_5A23[var_0].var_C9FD, "tag_player", 1, var_2.rightarc, var_2.var_B7C1, 80, 20, 0);
  } else {
    level.player getweightedchanceroll(level.var_5A23[var_0].var_C9FD, "tag_player", 1, var_2.var_B7C9, var_2.var_01B8, 80, 20, 0);
  }

  if((!isDefined(level.var_5A23[var_0].var_A5AB) || level.var_5A23[var_0].var_A5AB == 0) && level.var_5A23[var_0].var_1B12 == 0.0) {
    thread func_1203(var_0, var_1);
  }

  wait(var_2.var_47A4);
  level notify(var_0 + "door_intro_done");
  level notify("door_intro_done");
}

func_11CE(var_0, var_1) {
  level.player endon("death");
  wait(var_0);
  var_1 show();
}

func_1203(var_0, var_1) {
  if(!var_1) {
    var_2 = level.var_5A23[var_0].var_C9FE;
  } else {
    var_2 = level.var_5A23[var_0].var_C9FF;
  }

  level.var_5A23[var_0].var_5A2A rotateby((0, 0 - var_2.var_47A3, 0), var_2.var_47A4, 0, var_2.var_47A4 / 2);
  level.var_5A23[var_0].var_5978 playSound("doorpeek_" + func_1299(level.var_5A23[var_0].var_5A57) + "_crack_open");
}

func_11F5(var_0, var_1, var_2) {
  level endon(var_0 + "door_script_disabled");

  if(!var_1) {
    var_3 = 1.0;
    var_4 = level.var_5A23[var_0].var_C9FE;
    var_5 = level.var_5A23[var_0].var_5A25;
  } else {
    var_3 = -1.0;
    var_4 = level.var_5A23[var_0].var_C9FF;
    var_5 = level.var_5A23[var_0].var_5A26;
  }

  level notify(var_0 + "door_peek_start_peek_control");
  level notify("door_peek_start_peek_control");
  var_6 = func_12AE(var_0);
  var_7 = 0;
  var_8 = 0;
  var_9 = 1;
  var_10 = level.var_5A23[var_0].var_5A2A.angles;
  var_11 = 0;
  var_12 = 0;
  var_13 = 0;
  var_14 = 80;

  if(level.var_5A23[var_0].var_5A57 == "airlock") {
    var_14 = 90;
  }

  for(;;) {
    if(!var_1 && level.var_5A23[var_0].var_5A21 >= var_14 && !level.var_5A23[var_0].var_C9D4) {
      break;
    } else if(var_1 && level.var_5A23[var_0].var_5A21 <= 0 - var_14 && !level.var_5A23[var_0].var_C9D4) {
      break;
    }
    var_12 = 0;
    var_15 = func_1296(var_0, var_1);

    if(isDefined(level.var_5A23[var_0].var_72C6) && level.var_5A23[var_0].var_72C6 == 1) {
      var_15 = 1.0;
    }

    var_16 = var_15 * 1.2 * var_3;

    if(var_8 == 1.0 && var_15 == 1.0) {
      var_16 = var_16 * 1.01 * scripts\sp\utility::func_E753(var_9, 0, 1);
      var_9 = var_9 + 0.5;
    } else
      var_9 = 1;

    var_16 = clamp(var_16, 0 - var_4.var_B4B9, var_4.var_B4B9);

    if(!level.var_5A23[var_0].var_C9D4) {
      var_17 = 0;

      if(isDefined(level.var_5A23[var_0].var_B7C6)) {
        var_17 = level.var_5A23[var_0].var_B7C6 - var_6;
      }

      if(!var_1) {
        level.var_5A23[var_0].var_5A21 = max(level.var_5A23[var_0].var_5A21 + var_16, var_17);
      } else {
        level.var_5A23[var_0].var_5A21 = min(level.var_5A23[var_0].var_5A21 + var_16, 0.0 - var_17);
      }

      level.var_5A23[var_0].var_5A21 = scripts\sp\utility::func_E753(level.var_5A23[var_0].var_5A21, 1);

      if(isDefined(var_2)) {
        level.var_5A23[var_0].var_5A21 = min(level.var_5A23[var_0].var_5A21 + var_16, var_2);
      }
    }

    if(level.var_5A23[var_0].var_5A21 != var_7) {
      var_12 = 1;

      if(var_11 == 0) {
        level.var_5A23[var_0].var_5978 playSound("doorpeek_" + func_1299(level.var_5A23[var_0].var_5A57) + "_move_start");
        level.var_5A23[var_0].var_5978 playLoopSound("doorpeek_" + func_1299(level.var_5A23[var_0].var_5A57) + "_move_loop");
      }

      level.var_5A23[var_0].var_5A2A rotateto(var_10 + (0, 0.0 - level.var_5A23[var_0].var_5A21, 0), 0.1, 0.0, 0.0);

      if(!var_1) {
        var_18 = clamp(level.var_5A23[var_0].var_5A21 / var_4.var_B481, 0.0, 1.0) * (var_4.var_B4AA - var_4.var_B7C1) + var_4.var_B7C1;
        level.player getweightedchanceroll(level.var_5A23[var_0].var_C9FD, "tag_player", 1, var_4.rightarc, var_18, 80, 20, 0);
      } else {
        var_19 = clamp(-1.0 * level.var_5A23[var_0].var_5A21 / var_4.var_B481, 0.0, 1.0) * (var_4.var_B4C1 - var_4.var_B7C9) + var_4.var_B7C9;
        level.player getweightedchanceroll(level.var_5A23[var_0].var_C9FD, "tag_player", 1, var_19, var_4.var_01B8, 80, 20, 0);
      }

      if(isDefined(var_2) && level.var_5A23[var_0].var_5A21 == var_2) {
        wait 0.1;
        level.var_5A23[var_0].var_5978 playSound("doorpeek_" + func_1299(level.var_5A23[var_0].var_5A57) + "_blocked");
        level notify(var_0 + "door_peek_blocked");
        level notify("door_peek_blocked");
      }

      if(level.var_5A23[var_0].var_5A57 == "airlock" && var_13 == 0 && level.var_5A23[var_0].var_5A21 >= 64.0) {
        var_13 = 1;
        level notify(var_0 + "door_peek_airlock_ally_move");
        level notify("door_peek_airlock_ally_move");
      }
    } else if(var_11) {
      level.var_5A23[var_0].var_5978 stoploopsound("doorpeek_" + func_1299(level.var_5A23[var_0].var_5A57) + "_move_loop");
      level.var_5A23[var_0].var_5978 playSound("doorpeek_" + func_1299(level.var_5A23[var_0].var_5A57) + "_move_stop");
    }

    var_7 = level.var_5A23[var_0].var_5A21;
    var_8 = var_15;
    var_11 = var_12;
    wait 0.05;
  }
}

func_1210(var_0, var_1) {
  func_13C9("open");

  if(!var_1) {
    var_2 = level.var_5A23[var_0].var_74C0;
  } else {
    var_2 = level.var_5A23[var_0].var_74C1;
  }

  var_3 = 0.15;
  level.var_5A23[var_0].var_5A2A rotateto(level.var_5A23[var_0].var_5A24 + (0, var_2, 0), var_3, 0.0, 0.0);
  level.var_5A23[var_0].var_5A2A scripts\engine\utility::delaycall(var_3 + 0.05, ::delete);
  level.var_5A23[var_0].var_5A03 connectpaths();
  level.var_5A23[var_0].var_5A03 scripts\engine\utility::delaycall(var_3 + 0.05, ::disconnectpaths);
  level.var_5A23[var_0].var_5978 playSound("doorpeek_" + func_1299(level.var_5A23[var_0].var_5A57) + "_swing_open");
  level.var_5A23[var_0].var_5978 scripts\engine\utility::delaycall(var_3, ::playsound, "doorpeek_" + func_1299(level.var_5A23[var_0].var_5A57) + "_hit_wall");
  level thread scripts\sp\utility::func_C12D(var_0 + "door_peek_finished", var_3 + 0.05);
  level thread scripts\sp\utility::func_C12D("door_peek_finished", var_3 + 0.05);
  level notify(var_0 + "door_peek_opened_fully");

  if(isDefined(level.var_5A1C)) {
    level.var_5A23[var_0].var_C9FD delete();
    level.var_5A23[var_0].var_59FF delete();
    level.var_5A23[var_0].var_5A2A delete();
    return;
  }

  thread func_11F9(var_0, level.var_5A23[var_0].var_5978, var_1, 0, 1);
}

func_11F7(var_0, var_1, var_2, var_3) {
  level.player endon("death");
  level endon(var_0.targetname + "door_peek_start");

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!var_1) {
    var_4 = level.var_5A23[var_0.targetname].var_5A25;
  } else {
    var_4 = level.var_5A23[var_0.targetname].var_5A26;
  }

  var_5 = var_4.angles;

  if(!var_1) {
    var_5 = var_5 - (0, var_2, 0);
  } else {
    var_5 = var_5 + (0, var_2, 0);
  }

  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = anglestoup(var_5);
  var_9 = self.ogorigin + var_7 * level.var_5A23[var_0.targetname].var_5A58 * 0.5;
  self unlink();

  for(;;) {
    wait 0.05;
    var_10 = distance2d(level.player.origin, var_9);
    var_11 = abs(clamp(var_10 / 100.0, 0.0, 1.0) - 1.0);

    if(var_11 > 0.0) {
      var_12 = level.player getEye();
      var_13 = level.player getplayerangles();
      var_14 = anglesToForward(var_13);

      if(vectordot(var_14, var_6) < 0) {
        continue;
      }
      var_15 = scripts\sp\math::func_ACE9(var_12, var_12 + var_14 * 64, self.ogorigin, var_6);
      var_16 = vectornormalize(var_15 - self.ogorigin);
      var_15 = self.ogorigin + var_16 * distance(var_15, self.ogorigin) * 0.75 * var_11;

      if(distance(var_15, self.ogorigin) > 32.0) {
        var_15 = self.ogorigin + var_16 * 32.0;
      }

      var_17 = vectorcross(var_6, var_16);
      var_18 = 0;

      if(!var_1 && vectordot(var_17, var_8) > 0 && !var_3) {
        var_18 = 1;
      } else if(var_1 && vectordot(var_17, var_8) < 0 && !var_3) {
        var_18 = 1;
      }

      if(var_18) {
        var_19 = vectordot(var_16, var_8);
        var_20 = distance(var_15, self.ogorigin) * var_19;
        var_15 = self.ogorigin + var_8 * var_20;
      }

      self.origin = var_15;
      continue;
    }

    if(self.origin != self.ogorigin) {
      self.origin = self.ogorigin;
    }
  }
}

func_11FE(var_0, var_1) {
  level.player endon("death");
  level endon(var_0 + "door_peek_kick");
  level endon(var_0 + "door_peek_detach");

  for(;;) {
    level.player waittill("grenade_pullback");
    func_13C9("grenade");
    func_116C(var_0, var_1, 0);
    level.player waittill("grenade_fire");
    wait 0.3;
    func_116C(var_0, var_1, 1);
    wait 0.05;
  }
}

func_120A(var_0, var_1) {
  level.player endon("death");
  level endon(var_0 + "door_peek_kick");
  level endon(var_0 + "door_peek_detach");
  var_2 = 0;

  for(;;) {
    if(level.player getteamsize() && !var_2 && !level.player isdualwielding()) {
      func_116C(var_0, var_1, 0);
      var_2 = 1;
    } else if(!level.player getteamsize() && var_2) {
      func_116C(var_0, var_1, 1);
      var_2 = 0;
    }

    wait 0.05;
  }
}

func_116C(var_0, var_1, var_2) {
  if(!isDefined(level.var_5A23[var_0].var_C9FD)) {
    return;
  }
  if(var_2) {
    if(!isDefined(level.var_5A23[var_0].var_5A22)) {
      level.var_5A23[var_0].var_5A22 = 0;
    }

    level.var_5A23[var_0].var_5A22--;

    if(!level.var_5A23[var_0].var_5A22) {
      thread func_C9E8(var_0, var_1, var_2);
    }
  } else {
    if(!isDefined(level.var_5A23[var_0].var_5A22)) {
      level.var_5A23[var_0].var_5A22 = 0;
    }

    level.var_5A23[var_0].var_5A22++;

    if(level.var_5A23[var_0].var_5A22 == 1) {
      thread func_C9E7(var_0, var_1, var_2);
    }
  }
}

func_C9E8(var_0, var_1, var_2) {
  level endon(var_0 + "door_peek_kick");
  level endon(var_0 + "door_peek_detach");
  level notify("peek_arm_on");
  level endon("peek_arm_on");
  scripts\engine\utility::flag_waitopen("stopping_doorpeek_gesture");
  level.player forceplaygestureviewmodel("ges_drophand");

  if(!var_1) {
    var_3 = level.var_5A23[var_0].var_59FF;
    var_4 = "doorpeek_" + func_1297(level.var_5A23[var_0].var_5A57) + "_backon";
  } else {
    var_3 = level.var_5A23[var_0].var_5A00;
    var_4 = "doorpeek_" + func_1297(level.var_5A23[var_0].var_5A57) + "_r_backon";
  }

  childthread func_136C(var_3, var_0, var_4);
}

func_C9E7(var_0, var_1, var_2) {
  level endon(var_0 + "door_peek_kick");
  level endon(var_0 + "door_peek_detach");
  level notify("peek_arm_off");
  level endon("peek_arm_off");
  level.player notify("door_peek_hand_off");
  scripts\engine\utility::flag_clear("doorpeek_hand_on_door");
  level.var_5A23[var_0].var_C9FD hide();
  childthread func_1415();
}

func_136C(var_0, var_1, var_2) {
  level.player endon("door_peek_hand_off");
  wait 0.3;
  scripts\engine\utility::flag_set("doorpeek_hand_on_door");
  level.var_5A23[var_1].var_C9FD show();
  var_0 scripts\sp\anim::func_1F35(level.var_5A23[var_1].var_C9FD, var_2);
}

func_1415() {
  scripts\engine\utility::flag_set("stopping_doorpeek_gesture");
  var_0 = 0.1;
  level.player stopgestureviewmodel("ges_doorpeek_bulkhead", var_0);
  level.player stopgestureviewmodel("ges_doorpeek_airlock", var_0);
  level.player stopgestureviewmodel("ges_doorpeek_civlever", var_0);
  level.player stopgestureviewmodel("ges_doorpeek_civlever_r", var_0);
  level.player stopgestureviewmodel("ges_drophand", var_0);
  wait(var_0 + 0.25);
  scripts\engine\utility::flag_clear("stopping_doorpeek_gesture");
}

func_120B(var_0, var_1, var_2) {
  var_3 = var_0.var_EE52;
  var_4 = undefined;
  var_5 = undefined;

  for(;;) {
    var_4 = var_5;
    var_6 = func_11FC(var_0);
    var_5 = func_11FD(var_0);
    var_7 = 0;
    var_8 = 0;

    if(!isDefined(var_5) && isDefined(var_4)) {
      if(!var_1 && var_4) {
        var_7 = 1;
      }
    }

    if(isDefined(var_5) && isDefined(var_4) && var_5 != var_4) {
      if(!var_1 && var_5 || var_1 && !var_5) {
        var_7 = 1;
      }
    }

    if(!var_7 && isDefined(var_6)) {
      var_8 = 1;

      if(!var_1 && var_6 && !isDefined(level.var_5A23[var_0.targetname].var_C9FF)) {
        wait 0.05;
        continue;
      }

      var_9 = 50;
      var_10 = level.player getnormalizedmovement();
      var_11 = vectornormalize((var_10[0], 0 - var_10[1], 0));
      var_12 = vectortoangles(var_11);
      var_13 = level.player getplayerangles(1);
      var_14 = _combineangles(var_13, var_12);
      var_15 = anglesToForward(var_14);

      if(!var_6) {
        var_16 = anglesToForward(level.var_5A23[var_0.targetname].var_5A25.angles);

        if(acos(clamp(vectordot(var_16, var_15), -1, 1)) > var_9) {
          var_8 = 0;
        }
      } else {
        var_16 = anglesToForward(level.var_5A23[var_0.targetname].var_5A25.angles + (0, 180, 0));

        if(acos(clamp(vectordot(var_16, var_15), -1, 1)) > var_9) {
          var_8 = 0;
        }
      }
    }

    if(var_7 || var_8) {
      if(var_7) {
        var_6 = 0;
      }

      var_17 = 360;

      if(!var_6) {
        var_18 = level.var_5A23[var_0.targetname].var_74C0;
      } else {
        var_18 = level.var_5A23[var_0.targetname].var_74C1;
      }

      var_19 = anglesToForward(level.var_5A23[var_0.targetname].var_5A2A.angles);
      var_20 = anglesToForward(level.var_5A23[var_0.targetname].var_5A24 + (0, var_18, 0));
      var_2 connectpaths();
      var_21 = "ges_doorpeek_bash";
      var_22 = func_12AB(var_0.targetname, var_6);

      if(isDefined(var_22)) {
        var_21 = var_22;
      }

      level.player playgestureviewmodel(var_21);
      var_0 playSound("doorpeek_" + func_1299(var_3) + "_bash");
      level notify(var_0.targetname + "door_peek_bash_open");
      level notify("door_peek_bash_open");

      if(var_1 != var_6) {
        var_23 = anglesToForward(level.var_5A23[var_0.targetname].var_5A24);
        var_24 = acos(clamp(vectordot(var_19, var_23), -1, 1));
        var_25 = acos(clamp(vectordot(var_20, var_23), -1, 1));
        var_26 = var_24 / var_17;
        var_27 = var_25 / var_17;
        level.var_5A23[var_0.targetname].var_5A2A rotateto(level.var_5A23[var_0.targetname].var_5A24, var_26, 0.0, 0.0);
        wait(var_26);
        level.var_5A23[var_0.targetname].var_5A2A rotateto(level.var_5A23[var_0.targetname].var_5A24 + (0, var_18, 0), var_27, 0.0, 0.0);
        wait(var_27);
      } else {
        var_28 = acos(clamp(vectordot(var_19, var_20), -1, 1));
        var_29 = var_28 / var_17;
        level.var_5A23[var_0.targetname].var_5A2A rotateto(level.var_5A23[var_0.targetname].var_5A24 + (0, var_18, 0), var_29, 0.0, 0.0);
        wait(var_29);
      }

      wait 0.05;
      var_2 disconnectpaths();
      level.var_5A23[var_0.targetname].var_5A2A delete();
      level notify(var_0.targetname + "door_peek_finished");
      level notify("door_peek_finished");
      break;
    }

    wait 0.05;
  }
}

func_11FC(var_0) {
  var_1 = level.var_5A23[var_0.targetname].var_5A25;
  var_2 = anglesToForward(level.var_5A23[var_0.targetname].var_5A2A.angles);
  var_3 = -1 * anglestoright(level.var_5A23[var_0.targetname].var_5A2A.angles);
  var_4 = level.player.origin - var_1.origin;
  var_5 = vectornormalize(var_4);
  var_6 = level.var_5A23[var_0.targetname].var_5A58 + 8;
  var_7 = 48;

  if(distance(level.player.origin, var_1.origin) > var_6 + var_7) {
    return undefined;
  }

  if(vectordot(var_4, var_2) < 0) {
    var_8 = 0;
  } else {
    var_8 = 1;
  }

  if(!var_8) {
    var_9 = vectordot(var_5, var_3);

    if(var_9 <= 0) {
      return undefined;
    }

    var_10 = abs(length(var_4) * var_9);

    if(var_10 > var_6) {
      return undefined;
    }

    var_11 = -1 * var_2;
    var_9 = vectordot(var_5, var_11);
    var_10 = abs(length(var_4) * var_9);

    if(var_10 > var_7) {
      return undefined;
    }
  } else {
    var_9 = vectordot(var_5, var_3);

    if(var_9 <= 0) {
      return undefined;
    }

    var_10 = abs(length(var_4) * var_9);

    if(var_10 > var_6) {
      return undefined;
    }

    var_9 = vectordot(var_5, var_2);
    var_10 = abs(length(var_4) * var_9);

    if(var_10 > var_7) {
      return undefined;
    }
  }

  return var_8;
}

func_12F4(var_0) {
  var_1 = scripts\engine\utility::getstructarray("door_peek_struct", "script_noteworthy");
  var_2 = [];

  foreach(var_4 in var_1) {
    var_2[var_2.size] = var_4.targetname;
  }

  var_6 = undefined;
  var_7 = undefined;

  foreach(var_9 in var_2) {
    if(!isDefined(level.var_5A23[var_9]) || !isDefined(level.var_5A23[var_9].var_5A25)) {
      continue;
    }
    var_10 = distance(level.player.origin, level.var_5A23[var_9].var_5A25.origin);

    if(!isDefined(var_6) || var_10 < var_6) {
      var_6 = var_10;
      var_7 = var_9;
    }
  }

  if(var_7 == var_0) {
    return 1;
  } else {
    return 0;
  }
}

func_11FD(var_0) {
  var_1 = undefined;

  foreach(var_3 in scripts\engine\utility::getstructarray("door_peek_struct", "script_noteworthy")) {
    if(var_3.targetname == var_0.targetname) {
      var_1 = var_3;
      break;
    }
  }

  var_5 = var_0.targetname;
  var_6 = level.var_5A23[var_5].var_C9FE;
  var_7 = anglesToForward(level.var_5A23[var_0.targetname].var_5A25.angles);
  var_8 = -1 * anglestoright(level.var_5A23[var_0.targetname].var_5A25.angles);
  var_9 = level.var_5A23[var_0.targetname].var_5A25.origin + var_7 * var_6.var_11782 * -0.5;
  var_10 = level.player.origin - var_9;
  var_11 = vectornormalize(var_10);
  var_12 = level.var_5A23[var_5].var_5A58 + 8;
  var_13 = 48;

  if(distance(level.player.origin, var_9) > var_12 + var_13) {
    return undefined;
  }

  if(vectordot(var_10, var_7) < 0) {
    var_14 = 0;
  } else {
    var_14 = 1;
  }

  if(!var_14) {
    var_15 = vectordot(var_11, var_8);

    if(var_15 <= 0) {
      return undefined;
    }

    var_16 = abs(length(var_10) * var_15);

    if(var_16 > var_12) {
      return undefined;
    }

    var_17 = -1 * var_7;
    var_15 = vectordot(var_11, var_17);
    var_16 = abs(length(var_10) * var_15);

    if(var_16 > var_13) {
      return undefined;
    }
  } else {
    var_15 = vectordot(var_11, var_8);

    if(var_15 <= 0) {
      return undefined;
    }

    var_16 = abs(length(var_10) * var_15);

    if(var_16 > var_12) {
      return undefined;
    }

    var_15 = vectordot(var_11, var_7);
    var_16 = abs(length(var_10) * var_15);

    if(var_16 > var_13) {
      return undefined;
    }
  }

  return var_14;
}

func_11F9(var_0, var_1, var_2, var_3, var_4, var_5) {
  level.player endon("death");
  var_6 = var_1.var_EE52;

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_7 = 0.2;

  if(!var_2) {
    level.player scripts\engine\utility::delaycall(var_7, ::stopgestureviewmodel, "ges_doorpeek_" + func_1297(var_6));
  } else {
    level.player scripts\engine\utility::delaycall(var_7, ::stopgestureviewmodel, "ges_doorpeek_" + func_1297(var_6) + "_r");
  }

  level.player scripts\engine\utility::delaycall(var_7, ::stopgestureviewmodel, "ges_drophand");
  level.player scripts\engine\utility::delaycall(var_7, ::stopgestureviewmodel, "ges_doorpeek_civlever_r");
  var_1 stoploopsound("doorpeek_" + func_1299(var_6) + "_move_loop");
  level notify(var_0 + "door_peek_start_detach");
  level notify("door_peek_start_detach");
  var_8 = undefined;

  if(!var_3) {
    var_8 = level.player scripts\engine\utility::spawn_tag_origin();
    level.player getweightedchanceroll(var_8, "tag_origin", 1, 90, 90, 90, 90, 0);
  }

  func_1200();
  var_9 = level.var_5A23[var_0].var_C9FD gettagangles("tag_player");
  var_10 = level.player getplayerangles();
  level.var_5A23[var_0].var_C9FD delete();
  level notify(var_0 + "door_peek_detach");

  if(!var_3) {
    if(scripts\engine\utility::flag("doorpeek_hand_on_door")) {
      var_11 = level.player getplayerangles(1);
      var_12 = scripts\sp\utility::func_10639("player_rig", level.player.origin, var_11);
      var_13 = level.player _meth_84C6("currentViewModel");

      if(isDefined(var_13)) {
        var_12 setModel(var_13);
      }

      var_14 = (0, 0, 0);
      var_15 = (var_9[0] - var_10[0], var_9[1] - var_10[1], 0);
      var_12 _meth_81E2(level.player, "tag_origin", (0, 0, 0) + var_14, var_15, 0);

      if(!var_2) {
        var_12 thread scripts\sp\anim::func_1F35(var_12, "doorpeek_" + func_1297(var_6) + "_out");
      } else {
        var_12 thread scripts\sp\anim::func_1F35(var_12, "doorpeek_" + func_1297(var_6) + "_r_out");
      }

      var_12 scripts\engine\utility::delaycall(0.2, ::delete);
    }

    var_16 = func_12A1(var_0, var_2);
    var_17 = 0.2;
    var_8 moveto(var_16, var_17, var_17 / 2.0, 0.0);

    if(var_1.var_EE52 == "airlock") {
      level.player scripts\sp\utility::func_2B76(0);
    }

    level.player getrawbaseweaponname(0.4, 0.4);
    wait(var_17);
    wait 0.05;
    level.player unlink();

    if(var_1.var_EE52 == "airlock") {
      level.player scripts\sp\utility::func_2B76(0.25, 0.5);
      level.player scripts\engine\utility::delaythread(0.5, scripts\sp\utility::func_2B76, 1, 0.7);
    }

    level.player getrawbaseweaponname(0.6, 0.6);
    level.player scripts\engine\utility::delaycall(0.5, ::_meth_80A6);
  }

  if(!isDefined(var_4) || var_4 == 0) {
    level.var_5A23[var_0].var_5A2A delete();
  }

  if(!isDefined(var_5) || var_5 == 0) {
    level.var_5A23[var_0].var_59FF delete();

    if(isDefined(level.var_5A23[var_0].var_A5A9)) {
      level.var_5A23[var_0].var_A5A9 delete();
    }

    if(isDefined(level.var_5A23[var_0].var_A5AA)) {
      level.var_5A23[var_0].var_A5AA delete();
    }
  }

  level.player.dontmelee = undefined;
}

func_11D6(var_0, var_1, var_2) {
  var_3 = level.player scripts\engine\utility::spawn_tag_origin();
  level.player getweightedchanceroll(var_3, "tag_origin", 1, 90, 90, 90, 90, 0);
  var_4 = level.player getplayerangles();

  if(!isDefined(var_2) || !var_2) {
    if(isDefined(level.var_5A23[var_0].var_C9FD)) {
      level.var_5A23[var_0].var_C9FD delete();
    }
  } else if(isDefined(level.var_5A23[var_0].var_A5AE))
    level.var_5A23[var_0].var_A5AE delete();

  var_5 = func_12A1(var_0, var_1);
  var_3.origin = var_5;
  wait 0.05;
  level.player unlink();
  var_3 delete();
}

func_12A1(var_0, var_1) {
  var_2 = level.var_5A23[var_0].var_5978;
  var_3 = 12.0;
  var_4 = 17.0;

  if(!var_1) {
    var_5 = anglesToForward(level.var_5A23[var_0].var_5A25.angles);
    var_6 = anglesToForward(level.var_5A23[var_0].var_59FF.angles) * -1.0;
    var_7 = func_794C(var_0);
    var_8 = level.var_5A23[var_0].var_59FF.origin - level.var_5A23[var_0].var_5A25.origin;
    var_9 = rotatevector(var_8, (0, var_7, 0));
    var_10 = level.var_5A23[var_0].var_5A25.origin + var_9;
    var_11 = anglestoright(level.var_5A23[var_0].var_5A25.angles);
    var_12 = anglestoright(level.var_5A23[var_0].var_59FF.angles) * -1.0;
  } else {
    var_13 = -1;
    var_5 = anglesToForward(level.var_5A23[var_0].var_5A26.angles);
    var_6 = anglesToForward(level.var_5A23[var_0].var_5A00.angles) * -1.0;
    var_7 = func_794C(var_0) * -1;
    var_8 = level.var_5A23[var_0].var_5A00.origin - level.var_5A23[var_0].var_5A26.origin;
    var_9 = rotatevector(var_8, (0, var_7, 0));
    var_10 = level.var_5A23[var_0].var_5A26.origin + var_9;
    var_11 = anglestoright(level.var_5A23[var_0].var_5A26.angles) * -1.0;
    var_12 = anglestoright(level.var_5A23[var_0].var_5A00.angles) * -1.0;
  }

  var_14 = 0.2;
  var_15 = level.player.origin + var_6 * var_3 * -1.0;
  var_16 = var_15 - var_10;
  var_16 = scripts\engine\utility::flatten_vector(var_16) * length2d(var_16);
  var_17 = vectordot(var_11, var_16);

  if(var_17 < var_4) {
    var_18 = var_4 - var_17;
    var_19 = vectordot(var_11, var_12);
    var_20 = var_18 / var_19;
    var_15 = var_15 + var_12 * var_20;
  }

  var_21 = scripts\engine\trace::ray_trace(var_15 + (0, 0, 32), var_15 + (0, 0, -100), undefined, scripts\engine\trace::create_solid_ai_contents(1));
  var_22 = max(level.var_5A23[var_0].var_5A25.origin[2], var_21["position"][2]);
  var_15 = (var_15[0], var_15[1], var_22);
  return var_15;
}

func_120D(var_0, var_1, var_2) {
  level.player endon("death");
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

func_11EA(var_0, var_1, var_2, var_3, var_4) {
  level.player endon("death");
  level endon(var_0 + "door_peek_kick");
  level endon(var_0 + "door_peek_opened_fully");
  level endon(var_0 + "door_peek_sprint");
  level endon(var_0 + "door_peek_pop_open");

  if(isDefined(level.var_5A23[var_0].var_55B2) && level.var_5A23[var_0].var_55B2) {
    return;
  }
  level waittill(var_0 + "door_peek_start_peek_control");
  var_5 = 0;
  var_6 = 0;

  for(;;) {
    var_7 = func_1296(var_0, var_2);

    if(var_5 < -0.5 && var_7 < -0.5) {
      var_6++;
    } else {
      var_6 = 0;
    }

    if(var_6 >= 2) {
      break;
    }
    var_5 = var_7;
    wait 0.05;
  }

  level notify(var_0 + "door_peek_back_off");
  level notify("door_peek_back_off");
  var_8 = 70;
  var_9 = level.var_5A23[var_0].var_5A57;

  if(var_9 == "airlock" || var_9 == "airlocksdf" || var_9 == "airlockcombat" || var_9 == "airlockcombatsdf") {
    var_8 = 60;
  }

  if(func_794C(var_0) < var_8) {
    thread func_11F9(var_0, var_1, var_2, 0, 1);
    thread func_120B(var_1, var_2, var_3);
  } else
    thread func_1210(var_0, var_2);
}

func_1209(var_0, var_1, var_2, var_3) {
  level.player endon("death");
  level endon(var_0 + "door_peek_kick");
  level endon(var_0 + "door_peek_opened_fully");
  level endon(var_0 + "door_peek_back_off");

  if(isDefined(level.var_5A23[var_0].var_560A) && level.var_5A23[var_0].var_560A) {
    return;
  }
  level waittill(var_0 + "door_peek_start_peek_control");

  for(;;) {
    if(!var_2 && level.var_5A23[var_0].var_5A21 >= 28.0) {
      break;
    } else if(var_2 && level.var_5A23[var_0].var_5A21 <= -28.0) {
      break;
    }
    wait 0.05;
  }

  var_4 = 112.0;
  var_5 = 100.0;
  var_6 = 0;

  for(;;) {
    var_7 = 0;
    var_8 = level.player getnormalizedmovement();

    if(var_8[0] <= 0.5 && var_8[1] <= 0.5) {
      wait 0.05;
      continue;
    }

    var_9 = vectornormalize((var_8[0], 0 - var_8[1], 0));
    var_10 = vectortoangles(var_9);
    var_11 = level.player getplayerangles(1);
    var_12 = _combineangles(var_11, var_10);
    var_13 = anglesToForward(var_12);
    var_14 = level.player getplayerangles(1);
    var_15 = anglesToForward(var_14);

    if(!var_2) {
      var_16 = anglesToForward(level.var_5A23[var_0].var_59FF.angles + (0, 180, 0));
    } else {
      var_16 = anglesToForward(level.var_5A23[var_0].var_5A00.angles + (0, 180, 0));
    }

    var_17 = acos(clamp(vectordot(var_16, var_15), -1, 1));

    if(var_17 >= var_4) {
      var_18 = acos(clamp(vectordot(var_16, var_13), -1, 1));

      if(var_17 >= var_5) {
        var_6++;
      }
    } else
      var_6 = 0;

    if(var_6 >= 1) {
      break;
    }
    wait 0.05;
  }

  if(isDefined(level.var_5A23[var_0].var_560A) && level.var_5A23[var_0].var_560A) {
    return;
  }
  level notify(var_0 + "door_peek_pop_open");
  thread func_1210(var_0, var_2);
}

func_120F(var_0, var_1, var_2, var_3) {
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
  thread func_1210(var_0, var_2);
}

func_1296(var_0, var_1) {
  var_2 = level.player getnormalizedmovement();
  var_3 = level.var_5A23[var_0].var_5978;

  if(!var_1) {
    var_4 = anglesToForward(level.var_5A23[var_0].var_5A25.angles);
    var_5 = anglesToForward(level.var_5A23[var_0].var_59FF.angles) * -1.0;
  } else {
    var_4 = anglesToForward(level.var_5A23[var_0].var_5A26.angles);
    var_5 = anglesToForward(level.var_5A23[var_0].var_5A00.angles) * -1.0;
  }

  var_6 = 0;
  var_7 = vectornormalize((var_2[0], 0 - var_2[1], 0));
  var_8 = vectortoangles(var_7);
  var_9 = level.player getplayerangles(1);
  var_10 = _combineangles(var_9, var_8);
  var_11 = anglesToForward(var_10);
  var_12 = level.player getplayerangles(1);
  var_13 = anglesToForward(var_12);
  var_14 = level.player getEye() + (0, 0, -6) + 16 * anglesToForward(level.player.angles);
  var_15 = min(1.0, sqrt(squared(var_2[0]) + squared(var_2[1])));

  if(var_15 <= 0.1) {
    return 0;
  }

  if(var_15 >= 0.95) {
    var_15 = 1.0;
  }

  var_16 = acos(clamp(vectordot(var_11, var_4), -1, 1));
  var_17 = acos(clamp(vectordot(var_11, var_13), -1, 1));
  var_18 = acos(clamp(vectordot(var_11, var_5), -1, 1));
  var_19 = func_54E3(var_11, var_5, var_13);
  var_20 = 0.25;
  var_21 = 20;
  var_22 = 90;

  if(var_16 < 90 || var_19 || var_18 < 90) {
    var_23 = 1.0;

    if(var_19) {} else {
      var_24 = min(var_16, var_17);
      var_24 = min(var_24, var_18);

      if(var_24 > var_21) {
        if(var_24 <= var_22) {
          var_25 = var_24 - var_21;
          var_23 = 1.0 - (1.0 - var_20) * (var_25 / (var_22 - var_21));
        } else
          var_23 = 0;
      }
    }

    var_26 = min(var_15, var_23);
    return var_26;
  } else {
    var_23 = 1.0;
    var_26 = min(var_15, var_23) * -1;
    return var_26;
  }
}

func_54E3(var_0, var_1, var_2) {
  var_3 = acos(clamp(vectordot(var_1, var_2), -1, 1));
  var_4 = acos(clamp(vectordot(var_0, var_1), -1, 1));
  var_5 = acos(clamp(vectordot(var_0, var_2), -1, 1));
  var_6 = 1.0;

  if(abs(var_4 + var_5 - var_3) <= var_6) {
    return 1;
  }

  return 0;
}

func_59BE(var_0, var_1, var_2, var_3) {
  level.player endon("death");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    level endon(var_0 + "door_peek_main_side_used");
  } else {
    level endon(var_0 + "door_peek_reverse_side_used");
  }

  level endon(var_0 + "door_peek_deleted");
  level endon(var_0 + "door_peek_start_detach");
  level endon(var_0 + "door_peek_restarted");

  if(!scripts\engine\utility::flag_exist(var_0 + "door_peek_can_kick")) {
    scripts\engine\utility::flag_init(var_0 + "door_peek_can_kick");
  }

  if(!scripts\engine\utility::flag_exist(var_0 + "door_peek_handle_down")) {
    scripts\engine\utility::flag_init(var_0 + "door_peek_handle_down");
  }

  if(!scripts\engine\utility::flag_exist(var_0 + "did_kick_interrupt_input")) {
    scripts\engine\utility::flag_init(var_0 + "did_kick_interrupt_input");
  }

  var_4 = getEntArray(var_0, "targetname");
  var_4 = scripts\engine\utility::array_combine(var_4, scripts\engine\utility::getstructarray(var_0, "targetname"));
  var_5 = func_12A6(var_4, "door_peek_door");
  var_6 = var_5.var_EE52;
  var_7 = 0;

  if(var_6 == "airlock") {
    var_7 = 1;
  }

  func_59D5(var_0, 1);

  if(var_6 == "airlock" || var_6 == "airlockcombat") {
    var_5 func_0B1F::func_1AB6("unlocked");
  }

  thread func_1211(var_0, var_1, var_2, var_7);
  var_8 = 1;

  if(isDefined(var_3) && var_3 == 1) {
    var_8 = 0;
  }

  level waittill(var_0 + "door_peek_start");

  while(level.player usebuttonpressed()) {
    wait 0.05;
  }

  if(var_6 == "airlock") {
    func_1159(1, var_0);
  } else {
    func_1159(0, var_0);
  }

  thread func_1414(var_0);

  if(var_8) {
    for(;;) {
      scripts\engine\utility::flag_clear(var_0 + "did_kick_interrupt_input");
      thread func_11F1(var_0);
      scripts\engine\utility::flag_wait(var_0 + "did_kick_interrupt_input");

      if(isDefined(level.var_5A23[var_0].var_55F5) && level.var_5A23[var_0].var_55F5) {
        return;
      }
      level notify(var_0 + "remove_hint_text");
      level.var_5A23[var_0].var_A5AB = 1;
      scripts\engine\utility::flag_wait(var_0 + "door_peek_can_kick");
      level notify(var_0 + "door_peek_kick");
      level notify("door_peek_kick");
      thread func_59A4();
      scripts\engine\utility::waitframe();

      if(var_6 != "airlock") {
        thread func_11F0(var_0, var_1);
      } else {
        thread func_11ED(var_0);
      }

      if(var_7) {
        level waittill(var_0 + "door_kick_multi_kick_ready");
        func_1159(1, var_0);
        thread func_1414(var_0);
        continue;
      }

      break;
    }
  }
}

func_59D5(var_0, var_1) {
  var_2 = func_794D(var_0);
  var_3 = var_2.model;

  if(var_1) {
    if(scripts\sp\utility::hastag(var_3, "tag_locked")) {
      var_2 hidepart("tag_locked", var_3);
    }

    if(scripts\sp\utility::hastag(var_3, "tag_unlocked")) {
      var_2 giveperk("tag_unlocked", var_3);
    }

    if(scripts\sp\utility::hastag(var_3, "door_locked")) {
      var_2 hidepart("door_locked", var_3);
    }

    if(scripts\sp\utility::hastag(var_3, "door_unlocked")) {
      var_2 giveperk("door_unlocked", var_3);
    }

    if(scripts\sp\utility::hastag(var_3, "door_inactive")) {
      var_2 hidepart("door_inactive", var_3);
    }
  } else {
    if(scripts\sp\utility::hastag(var_3, "tag_locked")) {
      var_2 giveperk("tag_locked", var_3);
    }

    if(scripts\sp\utility::hastag(var_3, "tag_unlocked")) {
      var_2 hidepart("tag_unlocked", var_3);
    }

    if(scripts\sp\utility::hastag(var_3, "door_locked")) {
      var_2 giveperk("door_locked", var_3);
    }

    if(scripts\sp\utility::hastag(var_3, "door_unlocked")) {
      var_2 hidepart("door_unlocked", var_3);
    }

    if(scripts\sp\utility::hastag(var_3, "door_inactive")) {
      var_2 hidepart("door_inactive", var_3);
    }
  }
}

func_59A4() {
  wait 0.75;
  level.player playrumbleonentity("grenade_rumble");
  earthquake(0.35, 0.75, level.player.origin, 200);
  func_0F18::func_10E8A("broadcast", "attack", level.player getEye(), 800);
}

func_1159(var_0, var_1) {
  if(isDefined(level.var_5A23[var_1].var_C067)) {
    return;
  }
  scripts\engine\utility::flag_set("show_peek_hint");

  if(isDefined(level.var_5A23[var_1].var_C9F9)) {
    if(level.console || level.player global_fx()) {
      scripts\sp\utility::func_56BA("peek_only_hint");
    } else {
      scripts\sp\utility::func_56BA("peek_only_hint_pc");
    }
  } else if(!isDefined(var_0) || var_0 == 0) {
    if(level.console || level.player global_fx()) {
      scripts\sp\utility::func_56BA("peek_hint");
    } else {
      scripts\sp\utility::func_56BA("peek_hint_pc");
    }
  } else if(level.console || level.player global_fx())
    scripts\sp\utility::func_56BA("peek_hint_shove");
  else {
    scripts\sp\utility::func_56BA("peek_hint_shove_pc");
  }
}

func_1414(var_0) {
  level scripts\engine\utility::waittill_any(var_0 + "door_peek_start_detach", var_0 + "remove_hint_text");
  scripts\engine\utility::flag_clear("show_peek_hint");
}

func_794C(var_0) {
  if(!isDefined(level.var_5A23[var_0])) {
    return 0.0;
  } else if(!isDefined(level.var_5A23[var_0].var_5A2A)) {
    return 180.0;
  }

  var_1 = func_12AE(var_0);
  return var_1;
}

func_59C9(var_0) {
  level.var_5A23[var_0].var_72C6 = 1;
}

func_F366(var_0, var_1) {
  level.var_5A23[var_0].var_B7C6 = var_1;
}

func_551D(var_0) {
  level notify(var_0 + "door_peek_disabled");
}

func_12AE(var_0) {
  var_1 = abs(level.var_5A23[var_0].var_5A2A.angles[1] - level.var_5A23[var_0].var_5A24[1]);

  if(var_1 > 180.0) {
    var_1 = 360.0 - var_1;
  }

  return var_1;
}

func_11F1(var_0) {
  level endon(var_0 + "door_peek_start_detach");
  level endon(var_0 + "door_peek_restarted");

  if(level.console || level.player global_fx()) {
    level.player waittill("kick_pressed");
  } else {
    level.player waittill("kick_pressed_pc");
  }

  scripts\engine\utility::flag_set(var_0 + "did_kick_interrupt_input");
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
  level.player _meth_80DB();
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

func_11EC(var_0) {
  level endon(var_0 + "door_kick_newdoor_think");
  level endon(var_0 + "door_peek_opened_fully");
  var_1 = getEntArray(var_0, "targetname");
  var_1 = scripts\engine\utility::array_combine(var_1, scripts\engine\utility::getstructarray(var_0, "targetname"));
  var_2 = func_12A6(var_1, "door_peek_door");
  var_3 = func_12A6(var_1, "door_peek_clip");
  var_4 = var_2.var_EE52;
  var_3 linkto(var_2);
  var_5 = func_12A6(var_1, "door_kick_animstruct");
  var_6 = func_12A6(var_1, "door_kick_animstruct2");
  var_7 = var_5 scripts\engine\utility::spawn_tag_origin();
  var_8 = var_6 scripts\engine\utility::spawn_tag_origin();
  var_9 = var_2 scripts\engine\utility::spawn_tag_origin();
  var_9.angles = var_7.angles;
  var_10 = 90.0;
  var_11 = level.var_5A23[var_0].var_C9FE;
  var_12 = 120.0;
  var_13 = level.var_5A23[var_0].var_5A24 + (0, 0 - var_11.var_47A3, 0);
  level notify(var_0 + "door_kick_start");
  func_11EF();
  level.var_5A23[var_0].var_59FF thread scripts\sp\anim::func_1F35(level.var_5A23[var_0].var_C9FD, "doorpeek_airlock_bash");
  var_14 = 0.2;
  var_15 = 2.4;
  var_16 = 1.1;
  var_17 = 140.0;
  var_18 = 140.0;
  var_19 = 0.8;
  wait(var_14);
  level.var_5A23[var_0].var_C9D4 = 1;
  var_20 = level.var_5A23[var_0].var_5A21;
  var_21 = var_20 + var_17;
  var_21 = clamp(var_21, 0.0, var_18);
  var_22 = var_13 + (0, 0 - var_21, 0);
  level.var_5A23[var_0].var_5A2A rotateto(var_22, var_15, 0.0, 0.2);
  var_2 thread scripts\engine\utility::play_sound_in_space("doorpeek_" + func_1299(var_4) + "_kick", var_2.origin);
  thread func_1351(var_0);
  wait(var_16);
  level thread scripts\sp\utility::func_C12D(var_0 + "door_kick_multi_kick_ready", 0.5);
  func_11F9(var_0, var_2, 0, 1, 1);
  func_1201();
  level notify(var_0 + "door_kick_open");
  level notify("door_kick_open");
  var_23 = var_7 func_12A0(0, 30, 0);
  var_24 = level.player scripts\engine\utility::spawn_tag_origin();
  level.player getweightedchanceroll(var_24, "tag_origin", 1, 10, 10, 10, 10, 0);
  var_24 moveto(var_23, var_19, 0.0, 0.2);
  var_24 rotateto((var_24.angles[0], var_5.angles[1], var_24.angles[2]), 0.5, 0.0, 0.2);
  wait(var_19);
  func_11EE();
  level notify(var_0 + "stop_fake_origin_link");
  level notify(var_0 + "door_kick_finished");
  var_24.origin = getgroundposition(var_24.origin, 10, 30, 30);
  wait 0.05;
  var_24 delete();
  level.player unlink();
  func_1200();
}

func_11ED(var_0) {
  level endon(var_0 + "door_kick_newdoor_think");
  level endon(var_0 + "door_peek_opened_fully");
  var_1 = getEntArray(var_0, "targetname");
  var_1 = scripts\engine\utility::array_combine(var_1, scripts\engine\utility::getstructarray(var_0, "targetname"));
  var_2 = func_12A6(var_1, "door_peek_door");
  var_3 = func_12A6(var_1, "door_peek_clip");
  var_4 = var_2.var_EE52;
  var_3 linkto(var_2);
  var_5 = func_12A6(var_1, "door_kick_animstruct");
  var_6 = func_12A6(var_1, "door_kick_animstruct2");
  var_7 = var_5 scripts\engine\utility::spawn_tag_origin();
  var_8 = var_6 scripts\engine\utility::spawn_tag_origin();
  var_9 = var_2 scripts\engine\utility::spawn_tag_origin();
  var_9.angles = var_7.angles;
  var_10 = 90.0;
  var_11 = level.var_5A23[var_0].var_C9FE;
  var_12 = 120.0;
  var_13 = level.var_5A23[var_0].var_5A24 + (0, 0 - var_11.var_47A3, 0);
  level notify(var_0 + "door_kick_start");
  func_11EF();
  level.var_5A23[var_0].var_59FF thread scripts\sp\anim::func_1F35(level.var_5A23[var_0].var_C9FD, "doorpeek_airlock_bash");
  level.player playgestureviewmodel("ges_doorpeek_airlock_bash", undefined, 1);
  var_14 = 0.2;
  var_15 = 1.75;
  var_16 = 0.75;
  var_17 = 90.0;
  var_18 = 90.0;
  var_19 = 0.5;
  var_20 = 0.5;
  wait(var_14);
  level.var_5A23[var_0].var_C9D4 = 1;
  var_21 = level.var_5A23[var_0].var_5A21;
  var_22 = var_21 + var_17;
  var_22 = clamp(var_22, 0.0, var_18);
  var_23 = (var_21 - var_22) * -1 / var_22;
  var_24 = clamp(var_23 * var_15, var_16, var_15);
  var_25 = clamp(var_24 - var_19, var_20, var_24);
  var_26 = var_13 + (0, 0 - var_22, 0);
  level.var_5A23[var_0].var_5A2A rotateto(var_26, var_24, var_24 * 0.4, 0);
  var_2 playSound("doorpeek_" + func_1299(var_4) + "_shove");
  thread func_1351(var_0);
  scripts\engine\utility::delaythread(var_25, ::func_11EE);
  level.player scripts\engine\utility::delaycall(var_25, ::stopgestureviewmodel, "ges_doorpeek_airlock_bash", 0.2);
  wait(var_24);
  level.var_5A23[var_0].var_5A21 = var_22;
  level.var_5A23[var_0].var_C9D4 = 0;
  level notify(var_0 + "door_kick_finished");
  level notify("door_kick_finished");
  level thread scripts\sp\utility::func_C12D(var_0 + "door_kick_multi_kick_ready", 0.5);
}

func_1351(var_0) {
  level.player endon("death");
  level endon(var_0 + "door_kick_finished");
  var_1 = level.var_5A23[var_0].var_C9FE;
  var_2 = level.var_5A23[var_0].var_5A24 + (0, 0 - var_1.var_47A3, 0);
  var_3 = 40;

  for(;;) {
    var_4 = func_12AE(var_0) - var_1.var_47A3;
    var_5 = clamp(var_4 / var_1.var_B481, 0.0, 1.0) * (var_1.var_B4AA - var_1.var_B7C1) + var_1.var_B7C1;
    level.player lerpviewangleclamp(0.0, 0.0, 0.0, var_1.rightarc, var_5, 20, 20);

    if(var_4 >= var_3) {
      var_6 = 1;
      level notify(var_0 + "door_peek_airlock_ally_move");
      level notify("door_peek_airlock_ally_move");
    }

    wait 0.05;
  }
}

func_11F2(var_0, var_1, var_2) {
  level endon(var_0 + "door_kick_newdoor_think");
  level.player.var_5818 = 1;
  thread func_11F3(var_0, var_1);
  level.player waittill("death");

  if(!isDefined(level.player.var_5A12) || !level.player.var_5A12) {
    func_11D6(var_0, var_1, 1);
  } else {
    level.player unlink();

    if(isDefined(level.var_5A23[var_0].var_A5AE)) {
      level.var_5A23[var_0].var_A5AE delete();
    }
  }
}

func_11F3(var_0, var_1) {
  level.player endon("death");
  var_2 = [var_0 + "door_kick_newdoor_think"];
  level scripts\engine\utility::waittill_any_in_array_return(var_2);
  level.player.var_5818 = undefined;
}

func_11F0(var_0, var_1, var_2) {
  level.player endon("death");
  level endon(var_0 + "door_kick_newdoor_think");
  thread func_11F2(var_0, var_1, var_2);
  var_3 = getEntArray(var_0, "targetname");
  var_3 = scripts\engine\utility::array_combine(var_3, scripts\engine\utility::getstructarray(var_0, "targetname"));
  var_4 = func_12A6(var_3, "door_peek_door");
  var_5 = func_12A6(var_3, "door_peek_clip");
  var_6 = var_4.var_EE52;
  var_5 linkto(var_4);

  if(!var_1) {
    var_7 = level.var_5A23[var_0].var_A5A9;
  } else {
    var_7 = level.var_5A23[var_0].var_A5AA;
  }

  var_7.origin = var_7.origin + anglesToForward(var_7.angles) * -30;
  level notify(var_0 + "door_kick_start");
  level notify("door_kick_start");
  func_11F9(var_0, var_4, var_1, 1, 1, 1);
  func_1201();
  level.player.dontmelee = 1;

  if(!var_1) {
    var_8 = level.var_5A23[var_4.targetname].var_74C0;
  } else {
    var_8 = level.var_5A23[var_4.targetname].var_74C1;
  }

  var_9 = 0.65;
  var_10 = 0.3;
  var_11 = 0.0;
  var_12 = 0.05;
  var_13 = 0.2;
  var_14 = 1.0;

  if(func_1297(level.var_5A23[var_0].var_5A57) == "airlock") {
    var_9 = 0.65;
    var_10 = 0.7;
    var_11 = 0.05;
    var_12 = var_10 - 0.05;
    var_13 = 0.5;
  }

  var_15 = level.var_5A23[var_0].var_5A21;
  var_16 = (var_15 - abs(var_8)) * -1 / var_8;
  var_17 = clamp(var_16 * var_10, var_13, var_10);
  var_18 = var_17 / var_10;
  var_19 = var_11 * var_18;
  var_20 = var_12 * var_18;
  level.var_5A23[var_0].var_5A2A scripts\engine\utility::delaycall(var_9, ::rotateto, level.var_5A23[var_0].var_5A24 + (0, var_8, 0), var_17, var_19, var_20);
  level.var_5A23[var_0].var_5A2A scripts\engine\utility::delaycall(var_9 + var_17 + 0.05, ::delete);
  thread func_59A5(var_9 - 0.05);
  var_5 scripts\engine\utility::delaycall(var_9, ::connectpaths);
  var_5 scripts\engine\utility::delaycall(var_9 + var_10 + 0.05, ::disconnectpaths);
  var_4 scripts\engine\utility::delaythread(var_9, scripts\engine\utility::play_sound_in_space, "doorpeek_" + func_1299(var_6) + "_kick", var_4.origin);
  level thread scripts\sp\utility::func_C12D(var_0 + "door_kick_open", var_9);
  level thread scripts\sp\utility::func_C12D("door_kick_open", var_9);
  var_21 = "doorpeek_kick";
  var_22 = "ges_doorpeek_kick";
  var_23 = func_12AD(var_0, var_1);

  if(isDefined(var_23)) {
    var_22 = var_23;
  }

  func_11EF();
  scripts\engine\utility::delaythread(var_14, ::func_11EE);
  var_24 = level.player getplayerangles(1);
  level.var_5A23[var_4.targetname].var_A5AE = scripts\sp\utility::func_10639("player_rig", level.player.origin, var_24);
  var_25 = level.player _meth_84C6("currentViewModel");

  if(isDefined(var_25)) {
    level.var_5A23[var_4.targetname].var_A5AE setModel(var_25);
  }

  var_7 thread scripts\sp\anim::func_1EC3(level.var_5A23[var_4.targetname].var_A5AE, var_21);
  var_26 = level.var_5A23[var_4.targetname].var_A5AE gettagorigin("tag_player");
  var_27 = var_7.origin - var_26;
  var_28 = level.player.origin - var_26;
  var_29 = var_24 - var_7.angles;
  var_30 = var_7.origin;
  var_31 = var_7.angles;
  var_7 unlink();
  var_7.origin = var_7.origin + var_28;
  var_32 = vectornormalize(var_7.origin - level.player.origin);
  var_33 = distance(var_7.origin, level.player.origin);
  var_32 = rotatevector(var_32, var_29);
  var_7.origin = level.player.origin + var_32 * var_33;
  var_7.angles = var_7.angles + var_29;
  level.player playgestureviewmodel(var_22, undefined, 1, 0.2);
  var_7 thread scripts\sp\anim::func_1F35(level.var_5A23[var_4.targetname].var_A5AE, var_21);
  var_34 = getanimlength(level.var_5A23[var_4.targetname].var_A5AE scripts\sp\utility::func_7DC1(var_21));
  var_35 = 0.4;
  var_36 = 1.1;
  var_37 = 0.3;
  var_38 = 0.35;
  var_39 = 0.3;
  var_40 = 0.3;

  if(func_1297(level.var_5A23[var_0].var_5A57) == "airlock") {}

  level.player getweaponweight(level.var_5A23[var_4.targetname].var_A5AE, "tag_player", var_37, 0.0, 0.0);
  level.player scripts\engine\utility::delaycall(var_37, ::getweightedchanceroll, level.var_5A23[var_4.targetname].var_A5AE, "tag_player", 1, 0, 0, 0, 0, 0);
  level.player scripts\engine\utility::delaycall(var_38, ::lerpviewangleclamp, var_39, 0, 0, 40, 40, 60, 10);
  wait 0.05;
  level.var_5A23[var_4.targetname].var_A5AE linkto(var_7);
  var_7 moveto(var_30, var_35);
  var_7 rotateto(var_31, var_35);
  wait(var_35);
  level.player scripts\sp\utility::func_2B76(0.2, 0.05);

  if(isDefined(var_2)) {
    var_41 = 0.7;
    wait(var_36 - var_35 - var_41);
    var_42 = var_7 func_12A0(-60, 0, 0);
    var_7 moveto(var_42, var_41, 0.2, 0.1);
    wait(var_41);
  } else if(isDefined(level.var_5A1C)) {
    if(level.var_5A1C > 0) {
      wait(var_36 * level.var_5A1C);
    }

    var_7 scripts\sp\utility::anim_stopanimscripted();
  } else
    wait(var_36 - var_35);

  level notify(var_0 + "door_kick_finished");
  level notify("door_kick_finished");
  level notify(var_0 + "door_peek_finished");
  level notify("door_peek_finished");
  func_13C9("kick");
  level.player unlink();
  var_7 delete();
  level.var_5A23[var_4.targetname].var_A5AE delete();
  level.var_5A23[var_4.targetname].var_59FF delete();
  level.player scripts\sp\utility::func_2B76(1.0, var_40);
  func_1200();
  level.player.dontmelee = undefined;
  level notify(var_0 + "door_kick_newdoor_think");
  level.player.var_5A12 = undefined;
}

func_59A5(var_0) {
  level.player endon("death");
  wait(var_0);
  level.player.var_5A12 = 1;
}

func_59A2(var_0, var_1, var_2) {}

func_120E(var_0) {
  level endon(var_0 + "door_kick_newdoor_think");
  level waittill("doorpeek_handle");

  if(soundexists("doorpeek_" + func_1299(level.var_5A23[var_0].var_5A57) + "_handle")) {
    level.var_5A23[var_0].var_5978 playSound("doorpeek_" + func_1299(level.var_5A23[var_0].var_5A57) + "_handle");
  } else {
    var_1 = "doorpeek_" + func_1299(level.var_5A23[var_0].var_5A57) + "_handle";
  }
}

func_12A6(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_noteworthy)) {
      if(var_3.script_noteworthy == var_1) {
        return var_3;
      }
    }
  }
}

func_12A0(var_0, var_1, var_2) {
  var_3 = self.origin + anglesToForward(self.angles) * var_0 + anglestoright(self.angles) * var_1 + anglestoup(self.angles) * var_2;
  return var_3;
}

func_59CF(var_0, var_1) {
  level.player endon("death");
  level endon(var_0 + "door_intro_done");

  if(!isDefined(var_1) || var_1 == 0) {
    level scripts\engine\utility::waittill_any(var_0 + "door_peek_kick", var_0 + "door_peek_back_off", var_0 + "door_peek_sprint");
  } else {
    level scripts\engine\utility::waittill_any(var_0 + "door_peek_back_off", var_0 + "door_peek_sprint");
  }

  func_1204();
}

func_13C9(var_0) {
  if(!isDefined(level.var_D9E5)) {
    return;
  }
  if(!isDefined(level.var_D9E5["achievementDoorPeek"])) {
    return;
  }
  if(var_0 == "open") {
    level.var_D9E5["achievementDoorPeek"]["achievementDoorPeekOpen"] = 1;
  } else if(var_0 == "kick") {
    level.var_D9E5["achievementDoorPeek"]["achievementDoorPeekKick"] = 1;
  } else if(var_0 == "grenade") {
    level.var_D9E5["achievementDoorPeek"]["achievementDoorPeekGrenade"] = 1;
  }

  func_0A2F::func_3D6A(1);
}

func_12AC(var_0, var_1) {
  var_2 = level.player getcurrentweapon();

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = strtok(var_2, "+");
  var_2 = var_3[0];

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(var_2 == "alt_iw7_erad") {
    var_4 = func_1297(level.var_5A23[var_0].var_5A57);

    if(var_4 == "bulkhead" || var_4 == "airlock" || var_4 == "civlever" && !var_1) {
      return "ges_doorpeek_civlever_r";
      return;
    }
  } else if(var_2 == "iw7_mauler") {
    var_4 = func_1297(level.var_5A23[var_0].var_5A57);

    if(var_4 == "bulkhead" || var_4 == "airlock") {
      return "ges_doorpeek_civlever_r";
      return;
    }
  } else if(var_2 == "iw7_steeldragon") {
    var_4 = func_1297(level.var_5A23[var_0].var_5A57);

    if(var_4 == "bulkhead" || var_4 == "airlock") {
      return "ges_doorpeek_civlever_r";
    }
  }
}

func_12AD(var_0, var_1) {
  var_2 = level.player getcurrentweapon();

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = strtok(var_2, "+");
  var_2 = var_3[0];

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(var_2 == "alt_iw7_erad") {
    return "ges_doorpeek_kick_eradshotty";
  }
}

func_12AB(var_0, var_1) {
  var_2 = level.player getcurrentweapon();

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = strtok(var_2, "+");
  var_2 = var_3[0];

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(var_2 == "alt_iw7_erad") {
    return "ges_doorpeek_bash_eradshotty";
  }
}

func_1466(var_0) {
  level.player endon("death");
  level endon(var_0 + "door_peek_kick");
  level endon(var_0 + "door_peek_detach");
  thread func_1465(var_0);
  level.var_5A23[var_0].var_13C81 = 0;
  var_1 = ["iw7_fmg", "alt_iw7_fmg"];
  var_2 = level.player getcurrentweapon();

  if(isDefined(var_2)) {
    var_3 = strtok(var_2, "+");
    var_2 = var_3[0];

    foreach(var_5 in var_1) {
      if(var_2 == var_5) {
        level.var_5A23[var_0].var_13C81 = 1;
        break;
      }
    }
  }

  if(level.var_5A23[var_0].var_13C81) {
    level.player scripts\engine\utility::allow_weapon_switch(0);
  }

  for(;;) {
    level.player waittill("weapon_change");
    var_7 = level.var_5A23[var_0].var_13C81;
    var_2 = level.player getcurrentweapon();

    if(isDefined(var_2)) {
      var_3 = strtok(var_2, "+");
      var_2 = var_3[0];

      foreach(var_5 in var_1) {
        if(var_2 == var_5) {
          level.var_5A23[var_0].var_13C81 = 1;
          break;
        }
      }
    }

    if(!var_7 && level.var_5A23[var_0].var_13C81) {
      level.player scripts\engine\utility::allow_weapon_switch(0);
      continue;
    }

    if(var_7 && !level.var_5A23[var_0].var_13C81) {
      level.player scripts\engine\utility::allow_weapon_switch(1);
    }
  }
}

func_1465(var_0) {
  level.player endon("death");
  level scripts\engine\utility::waittill_any(var_0 + "door_peek_kick", var_0 + "door_peek_detach");

  if(level.var_5A23[var_0].var_13C81) {
    level.player scripts\engine\utility::allow_weapon_switch(1);
  }
}

func_1298(var_0, var_1) {
  var_2 = spawnStruct();

  if(var_0 == "bulkhead" && !var_1) {
    var_2.var_119AB = 0.9;
    var_2.var_47A4 = 0.7;
    var_2.var_47A3 = 12.0;
    var_2.var_119D5 = 0.9;
    var_2.var_B7C1 = 0;
    var_2.var_B4AA = 70;
    var_2.rightarc = 8;
    var_2.var_B481 = 30.0;
    var_2.var_B4B9 = 4.0;
    var_2.var_11782 = 16.0;
  } else if((var_0 == "airlock" || var_0 == "airlocksdf") && !var_1) {
    var_2.var_119AB = 1.0;
    var_2.var_47A4 = 0.7;
    var_2.var_47A3 = 14.0;
    var_2.var_119D5 = 1.2;
    var_2.var_B7C1 = 2;
    var_2.var_B4AA = 90;
    var_2.rightarc = 8;
    var_2.var_B481 = 60.0;
    var_2.var_B4B9 = 1.5;
    var_2.var_11782 = 18.0;
  }

  if((var_0 == "airlockcombat" || var_0 == "airlockcombatsdf") && !var_1) {
    var_2.var_119AB = 1.2;
    var_2.var_47A4 = 0.7;
    var_2.var_47A3 = 22.0;
    var_2.var_119D5 = 1.2;
    var_2.var_B7C1 = 2;
    var_2.var_B4AA = 90;
    var_2.rightarc = 8;
    var_2.var_B481 = 60.0;
    var_2.var_B4B9 = 2.0;
    var_2.var_11782 = 18.0;
  } else if(var_0 == "armory" && !var_1) {
    var_2.var_119AB = 0.9;
    var_2.var_47A4 = 0.7;
    var_2.var_47A3 = 12.0;
    var_2.var_119D5 = 0.9;
    var_2.var_B7C1 = 0;
    var_2.var_B4AA = 140;
    var_2.rightarc = 13;
    var_2.var_B481 = 80.0;
    var_2.var_B4B9 = 4.0;
    var_2.var_11782 = 10.0;
  } else if(var_0 == "armoryajar" && !var_1) {
    var_2.var_119AB = 0.9;
    var_2.var_47A4 = 0.2;
    var_2.var_47A3 = 0.0;
    var_2.var_119D5 = 0.9;
    var_2.var_B7C1 = 0;
    var_2.var_B4AA = 140;
    var_2.rightarc = 13;
    var_2.var_B481 = 80.0;
    var_2.var_B4B9 = 4.0;
    var_2.var_11782 = 10.0;
  } else if(var_0 == "civlever" && !var_1) {
    var_2.var_119AB = 0.6;
    var_2.var_47A4 = 0.5;
    var_2.var_47A3 = 12.0;
    var_2.var_119D5 = 0.9;
    var_2.var_B7C1 = 9.5;
    var_2.var_B4AA = 70;
    var_2.rightarc = 5;
    var_2.var_B481 = 29.0;
    var_2.var_B4B9 = 4.0;
    var_2.var_11782 = 3.0;
  } else if(var_0 == "civlever" && var_1) {
    var_2.var_119AB = 0.6;
    var_2.var_47A4 = 0.5;
    var_2.var_47A3 = -12.0;
    var_2.var_119D5 = 0.9;
    var_2.var_B7C9 = 22;
    var_2.var_B4C1 = 70;
    var_2.var_01B8 = 0;
    var_2.var_B481 = 40.0;
    var_2.var_B4B9 = 4.0;
    var_2.var_11782 = 3.0;
  } else if(var_0 == "civchurch1" && !var_1) {
    var_2.var_119AB = 0.6;
    var_2.var_47A4 = 0.5;
    var_2.var_47A3 = 12.0;
    var_2.var_119D5 = 0.9;
    var_2.var_B7C1 = 9.5;
    var_2.var_B4AA = 70;
    var_2.rightarc = 5;
    var_2.var_B481 = 29.0;
    var_2.var_B4B9 = 4.0;
    var_2.var_11782 = 3.0;
  } else if(var_0 == "civchurch1" && var_1) {
    var_2.var_119AB = 0.6;
    var_2.var_47A4 = 0.5;
    var_2.var_47A3 = -12.0;
    var_2.var_119D5 = 0.9;
    var_2.var_B7C9 = 22;
    var_2.var_B4C1 = 70;
    var_2.var_01B8 = 0;
    var_2.var_B481 = 40.0;
    var_2.var_B4B9 = 4.0;
    var_2.var_11782 = 3.0;
  }

  return var_2;
}

func_1299(var_0) {
  if(var_0 == "bulkhead") {
    return "bulkhead";
  } else if(var_0 == "airlock" || var_0 == "airlocksdf" || var_0 == "airlockcombat" || var_0 == "airlockcombatsdf") {
    return "airlock";
  } else if(var_0 == "armory" || var_0 == "armoryajar") {
    return "armory";
  } else if(var_0 == "civlever") {
    return "civleverwood";
  } else if(var_0 == "civchurch1") {
    return "civhandlewood";
  }
}

func_1297(var_0) {
  if(var_0 == "bulkhead") {
    return "bulkhead";
  } else if(var_0 == "airlock" || var_0 == "airlocksdf" || var_0 == "airlockcombat" || var_0 == "airlockcombatsdf") {
    return "airlock";
  } else if(var_0 == "armory") {
    return "armory";
  } else if(var_0 == "armoryajar") {
    return "armoryajar";
  } else if(var_0 == "civlever" || var_0 == "civchurch1") {
    return "civlever";
  }
}

#using_animtree("player");

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
  level.var_EC89["player_rig"]["doorpeek_civlever_backon"] = 0.0;
  level.var_EC85["player_rig"]["doorpeek_civlever_r_in"] = % wm_doorpeek_civlever_r_in;
  scripts\sp\anim::func_17F6("player_rig", "doorpeek_handle", ::func_5A1B, "doorpeek_civlever_r_in");
  level.var_EC85["player_rig"]["doorpeek_civlever_r_loop"][0] = % wm_doorpeek_civlever_r_loop;
  level.var_EC85["player_rig"]["doorpeek_civlever_r_out"] = % wm_doorpeek_civlever_r_out;
  level.var_EC85["player_rig"]["doorpeek_civlever_r_backon"] = % wm_doorpeek_civlever_r_backon;
  level.var_EC89["player_rig"]["doorpeek_civlever_r_backon"] = 0.0;
  level.var_EC85["player_rig"]["doorpeek_bulkhead_in"] = % wm_doorpeek_bulkhead_in;
  scripts\sp\anim::func_17F6("player_rig", "doorpeek_handle", ::func_5A1B, "doorpeek_bulkhead_in");
  level.var_EC85["player_rig"]["doorpeek_bulkhead_loop"][0] = % wm_doorpeek_bulkhead_loop;
  level.var_EC85["player_rig"]["doorpeek_bulkhead_out"] = % wm_doorpeek_bulkhead_out_b;
  level.var_EC85["player_rig"]["doorpeek_bulkhead_backon"] = % wm_doorpeek_bulkhead_backon;
  level.var_EC89["player_rig"]["doorpeek_bulkhead_backon"] = 0.0;
  level.var_EC85["player_rig"]["doorpeek_airlock_in"] = % wm_doorpeek_airlock_in;
  scripts\sp\anim::func_17F6("player_rig", "doorpeek_handle", ::func_5A1B, "doorpeek_airlock_in");
  level.var_EC85["player_rig"]["doorpeek_airlock_loop"][0] = % wm_doorpeek_airlock_loop;
  level.var_EC85["player_rig"]["doorpeek_airlock_out"] = % wm_doorpeek_airlock_out;
  level.var_EC85["player_rig"]["doorpeek_airlock_bash"] = % wm_doorpeek_airlock_bash;
  level.var_EC85["player_rig"]["doorpeek_airlock_backon"] = % wm_doorpeek_airlock_backon;
  level.var_EC89["player_rig"]["doorpeek_airlock_backon"] = 0.0;
  level.var_EC85["player_rig"]["doorpeek_armory_in"] = % wm_doorpeek_armory_in;
  scripts\sp\anim::func_17F6("player_rig", "doorpeek_handle", ::func_5A1B, "doorpeek_armory_in");
  level.var_EC85["player_rig"]["doorpeek_armory_loop"][0] = % wm_doorpeek_armory_loop;
  level.var_EC85["player_rig"]["doorpeek_armory_out"] = % wm_doorpeek_armory_out;
  level.var_EC85["player_rig"]["doorpeek_armory_backon"] = % wm_doorpeek_armory_backon;
  level.var_EC89["player_rig"]["doorpeek_armory_backon"] = 0.0;
  level.var_EC85["player_rig"]["doorpeek_armoryajar_in"] = % wm_doorpeek_armory_ajar_in;
  level.var_EC85["player_rig"]["doorpeek_armoryajar_loop"][0] = % wm_doorpeek_armory_ajar_loop;
  level.var_EC85["player_rig"]["doorpeek_armoryajar_out"] = % wm_doorpeek_armory_ajar_out;
  level.var_EC85["player_rig"]["doorpeek_armoryajar_backon"] = % wm_doorpeek_armory_ajar_backon;
  level.var_EC89["player_rig"]["doorpeek_armoryajar_backon"] = 0.0;
}

#using_animtree("generic_human");

func_11FB() {
  level.var_EC85["generic"]["walk_cqb_f"][0] = % walk_cqb_f;
  level.var_EC85["generic"]["cqb_stand_idle"][0] = % cqb_stand_idle;
}

#using_animtree("script_model");

func_120C() {
  level.var_EC87["doorpeek_door"] = #animtree;
  level.var_EC85["doorpeek_door"]["doorpeek_civlever_in"] = % wm_doorpeek_bulkhead_in_door;
  level.var_EC85["doorpeek_door"]["doorpeek_bulkhead_in"] = % wm_doorpeek_bulkhead_in_door;
  level.var_EC85["doorpeek_door"]["doorpeek_airlock_in"] = % wm_doorpeek_airlock_in_door;
  level.var_EC85["doorpeek_door"]["doorpeek_armory_in"] = % wm_doorpeek_armory_in_door;
  level.var_EC85["doorpeek_door"]["doorpeek_armoryajar_in"] = % wm_doorpeek_armory_ajar_in_door;
}

func_5A1B(var_0) {
  level notify("doorpeek_handle");
}

func_59D9(var_0, var_1) {
  level.var_5A23[var_0].var_5A2A rotateto(level.var_5A23[var_0].var_5A24 + (0, -140, 0), var_1, 0.0, 0.0);
  level.var_5A23[var_0].var_5A2A scripts\engine\utility::delaycall(var_1 + 0.05, ::delete);
  level.var_5A23[var_0].var_5A03 connectpaths();
  level.var_5A23[var_0].var_5A03 scripts\engine\utility::delaycall(var_1 + 0.05, ::disconnectpaths);
  level.var_5A23[var_0].var_5978 playSound("doorpeek_" + func_1299(level.var_5A23[var_0].var_5A57) + "_swing_open");
  level.var_5A23[var_0].var_5978 scripts\engine\utility::delaycall(var_1, ::playsound, "doorpeek_" + func_1299(level.var_5A23[var_0].var_5A57) + "_hit_wall");
  level.var_5A23[var_0].var_5A56 hide();
  func_551D(var_0);
}