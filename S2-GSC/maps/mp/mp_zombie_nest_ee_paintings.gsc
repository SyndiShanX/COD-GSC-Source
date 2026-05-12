/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_paintings.gsc
***************************************************/

func_00F9() {
  level.var_3589 = 3000;
  level.var_3582 = 4;
  level.var_3583 = 5;
  level.var_3588 = 0;
  level.var_357E = 30;
  level.var_3585 = 0;
  level.var_358A = [];
  level.var_3581 = [];
  level.var_3584 = [];
  level.var_357F = undefined;
  level.var_3580 = [];
  level.var_3587 = undefined;
  level.var_3586 = "tumbler_";
  level.var_9333 = [];
  level.var_83A0 = 0;
  common_scripts\utility::func_3C87("flag_head_picked_up");
  common_scripts\utility::func_3C87("flag_head_hint_seen");
  common_scripts\utility::func_3C87("flag_painting_hint_seen");
  common_scripts\utility::func_3C87("flag_both_hints_seen");
  common_scripts\utility::func_3C87("flag_all_paintings_revealed");
  common_scripts\utility::func_3C87("flag_correct_code_entered");
  common_scripts\utility::func_3C87("flag_one_painting_checked");
  common_scripts\utility::func_3C87("flag_player_has_head");
  for(var_00 = 1; var_00 <= level.var_3582; var_00++) {
    common_scripts\utility::func_3C87("ee_painting_reveal_" + var_00);
  }

  lib_0557::func_7846("7 Voice paintings", ::func_6DF3, ["6B Left Hand overcharge"], &"ZOMBIE_NEST_HINT_QUEST_PAINTINGS", "ZOMBIE_NEST_HINT_QUEST_PAINTINGS");
  lib_0557::func_781E("7 Voice paintings", "find code pieces", ::func_7879, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_FIND_CODE");
  lib_0557::func_781E("7 Voice paintings", "enter code pieces", ::func_7877, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_ENTER_CODE");
  lib_0557::func_7848("7 Voice paintings");
  func_5328();
}

func_5328() {
  wait 0.05;
  func_8A39();
  thread func_8A46();
  thread func_8A24();
  thread func_8A25();
  thread func_8A22();
  thread mainpathcompletionlistener();
}

func_7879() {
  func_3664(0);
  func_3666();
  if(!common_scripts\utility::func_3C77("flag_all_paintings_revealed")) {
    if(common_scripts\utility::func_3C77("ee_painting_reveal_1") || common_scripts\utility::func_3C77("ee_painting_reveal_2") || common_scripts\utility::func_3C77("ee_painting_reveal_3") || common_scripts\utility::func_3C77("ee_painting_reveal_4")) {
      lib_0557::func_7822("7 Voice paintings", &"ZOMBIE_NEST_HINT_STEP_FIND_CODE_2");
    } else {
      if(!common_scripts\utility::func_3C77("flag_both_hints_seen") && !common_scripts\utility::func_3C77("flag_player_has_head")) {
        if(1) {
          var_00 = getent("paintings_hint_head_jar", "targetname");
          var_01 = lib_0557::func_782F(undefined, var_00);
          lib_0557::func_781D("7 Voice paintings", var_01, 0);
        }

        common_scripts\utility::func_3CA2("flag_both_hints_seen", "flag_player_has_head");
      }

      if(common_scripts\utility::func_3C77("flag_player_has_head")) {
        lib_0557::func_7822("7 Voice paintings", &"ZOMBIE_NEST_HINT_STEP_USE_HEAD");
      } else {
        lib_0557::func_7822("7 Voice paintings", &"ZOMBIE_NEST_HINT_STEP_FIND_HEAD");
        common_scripts\utility::func_3C9F("flag_player_has_head");
        lib_0557::func_7822("7 Voice paintings", &"ZOMBIE_NEST_HINT_STEP_USE_HEAD");
      }

      common_scripts\utility::func_3CA2("ee_painting_reveal_1", "ee_painting_reveal_2", "ee_painting_reveal_3", "ee_painting_reveal_4", "flag_correct_code_entered");
      lib_0557::func_7822("7 Voice paintings", &"ZOMBIE_NEST_HINT_STEP_FIND_CODE_2");
    }

    if(1) {
      var_02 = getEntArray("painting_boxes", "targetname");
      if(isDefined(var_02)) {
        var_03 = lib_0557::func_782F(undefined, var_02);
        lib_0557::func_781D("7 Voice paintings", var_03, 0);
      }
    }
  }

  common_scripts\utility::func_3CA2("flag_all_paintings_revealed", "flag_correct_code_entered");
  if(!lib_0557::func_783E("7 Voice paintings", "find code pieces")) {
    lib_0557::func_782D("7 Voice paintings", "find code pieces");
  }
}

func_787A() {}

func_787E() {}

func_7877() {
  if(1) {
    var_00 = getEntArray("voice_of_god_model", "targetname");
    var_01 = lib_0557::func_782F(undefined, var_00);
    lib_0557::func_781D("7 Voice paintings", var_01);
  }

  common_scripts\utility::func_3C9F("flag_correct_code_entered");
  thread maps\mp\mp_zombie_nest_ee_util::func_4D78(3);
  level.var_357F common_scripts\utility::func_9D9F();
  if(!lib_0557::func_783E("7 Voice paintings", "find code pieces")) {
    lib_0557::func_782D("7 Voice paintings", "find code pieces");
  }

  lib_0557::func_782D("7 Voice paintings", "enter code pieces");
}

func_6DF3() {
  foreach(var_01 in level.var_744A) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("voiceofgod");
    var_01 lib_0378::func_8D74("objective_complete", "voiceofgod");
  }
}

mainpathcompletionlistener() {
  common_scripts\utility::func_3C9F("flag_correct_code_entered");
  common_scripts\utility::func_3CA2("flag_nest_hc_ee_true_voice_entered", lib_0557::func_7838("8B final boss", "final boss battle part 1"));
  level notify("vog_disabled");
  disabletumblertriggers();
  disabletheconfirmtrigger();
}

func_8A24() {
  level endon("flag_both_hints_seen");
  var_00 = getent("head_hint_trig", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  var_00.var_5877 = getent("paintings_hint_head_jar", "targetname");
  var_00.var_5877 setModel("zmb_med_jar_04_nodecals");
  var_00 usetriggerrequirelookat(1);
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(!common_scripts\utility::func_562E(var_01.var_306F)) {
      var_01 thread lib_0367::func_8E3C("paintingsuv");
      var_01.var_306F = 1;
    }

    var_02 = 1;
    foreach(var_04 in level.var_744A) {
      if(!common_scripts\utility::func_562E(var_04.var_306F)) {
        var_02 = 0;
        break;
      }
    }

    if(var_02) {
      common_scripts\utility::func_3C8F("flag_head_hint_seen");
      var_00 delete();
      if(common_scripts\utility::func_3C77("flag_painting_hint_seen")) {
        common_scripts\utility::func_3C8F("flag_both_hints_seen");
      }

      break;
    }
  }
}

func_8A25() {
  level endon("flag_both_hints_seen");
  var_00 = getent("painting_hint_trig", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  var_00.var_6DEE = getent("paintings_hint_painting", "targetname");
  var_00 usetriggerrequirelookat(1);
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(!common_scripts\utility::func_562E(var_01.var_3070)) {
      var_01 thread lib_0367::func_8E3C("paintingssecret");
      var_01.var_3070 = 1;
    }

    var_02 = 1;
    foreach(var_04 in level.var_744A) {
      if(!common_scripts\utility::func_562E(var_04.var_3070)) {
        var_02 = 0;
        break;
      }
    }

    if(var_02) {
      common_scripts\utility::func_3C8F("flag_painting_hint_seen");
      var_00 delete();
      if(common_scripts\utility::func_3C77("flag_head_hint_seen")) {
        common_scripts\utility::func_3C8F("flag_both_hints_seen");
      }

      break;
    }
  }
}

func_8A46() {
  level.var_357F = getent("sonic_amp_confirm_code_trig", "targetname");
  level.var_357F common_scripts\utility::func_9D9F();
  level.var_357F.var_0CAB = getent("sonic_amp_control", "targetname");
  if(isDefined(level.var_357F.var_0CAB)) {
    level.var_357F.var_0CAB thread maps\mp\mp_zombie_nest_ee_util::func_4D77("off");
  }

  var_00 = common_scripts\utility::func_46B7("sonic_amp_tumbler", "targetname");
  var_01 = level.var_3586;
  foreach(var_03 in var_00) {
    var_04 = var_03.var_8260;
    var_05 = getsubstr(var_04, var_01.size, var_04.size);
    var_05 = int(common_scripts\utility::func_9468(var_05)) - 1;
    var_06 = common_scripts\utility::func_44BE(var_03.var_01A2, "targetname");
    foreach(var_08 in var_06) {
      if(!isDefined(var_08.var_0165)) {
        continue;
      }

      var_09 = var_08.var_0165;
      switch (var_09) {
        case "amp_trig":
          var_03.var_9E46 = var_08;
          break;

        case "amp_model":
          var_03.var_0DBE = var_08;
          break;

        default:
          break;
      }
    }

    var_03.var_28F1 = 0;
    var_03.var_9E46 common_scripts\utility::func_9D9F();
    var_03.var_9E45 = var_05;
    level.var_3580[var_05] = var_03;
  }

  func_7A56();
  func_5308();
}

func_3664(param_00) {
  if(isDefined(level.var_357F.var_0CAB) && !param_00) {
    level.var_357F.var_4D91 = lib_0559::func_7BE3(level.var_357F, "vog");
    level.var_357F.var_0CAB thread maps\mp\mp_zombie_nest_ee_util::func_4D77("red");
  }

  level.var_357F common_scripts\utility::func_9DA3();
  level.var_357F thread func_2580(param_00);
}

disabletheconfirmtrigger() {
  level.var_357F common_scripts\utility::func_9D9F();
}

func_3666() {
  foreach(var_01 in level.var_3580) {
    var_01.var_9E46 common_scripts\utility::func_9DA3();
  }
}

disabletumblertriggers() {
  foreach(var_01 in level.var_3580) {
    var_01.var_9E46 common_scripts\utility::func_9D9F();
  }
}

func_43CC() {
  return "flag_correct_code_entered";
}

func_5308() {
  for(var_00 = 0; var_00 < level.var_3580.size; var_00++) {
    level.var_3580[var_00] func_A185(level.var_3584[var_00]);
    if(isDefined(level.var_3580[var_00].var_9E46)) {
      level.var_3580[var_00].var_9E46 sethintstring(&"ZOMBIE_NEST_AMP_CHANGE_CODE");
      level.var_3580[var_00].var_9E46.var_4D91 = lib_0559::func_7BE3(level.var_3580[var_00].var_9E46, "vog");
      level.var_3580[var_00] thread func_8B29(var_00);
    }

    if(isDefined(level.var_3580[var_00].var_0DBE)) {
      level.var_3580[var_00] thread func_8C28();
    }
  }
}

func_7A56() {
  for(var_00 = 0; var_00 < level.var_3582; var_00++) {
    var_01 = 0;
    while(!var_01) {
      if(0) {
        level.var_3584[var_00] = randomint(level.var_3583);
        if(level.var_3584[var_00] != level.var_3581[var_00]) {
          var_01 = 1;
        }

        continue;
      }

      level.var_3584[var_00] = 0;
      var_01 = 1;
      wait 0.05;
    }
  }
}

func_2580(param_00) {
  level endon("game_ended");
  level endon("vog_disabled");
  for(;;) {
    self sethintstring(&"ZOMBIE_NEST_AMP_CONFIRM_CODE");
    self waittill("trigger", var_01);
    var_02 = common_scripts\utility::func_46B5("VOG_effects_attach", "targetname");
    var_03 = 1;
    for(var_04 = 0; var_04 < level.var_3584.size; var_04++) {
      if(level.var_3584[var_04] != level.var_3581[var_04]) {
        var_03 = 0;
      }
    }

    if(isDefined(level.var_357F.var_0CAB)) {
      level.var_357F.var_0CAB thread maps\mp\mp_zombie_nest_ee_util::func_4D76();
    }

    if(var_03) {
      if(isDefined(level.var_357F.var_0CAB)) {
        level.var_357F.var_0CAB thread maps\mp\mp_zombie_nest_ee_util::func_4D77("green");
      }

      if(!param_00) {
        level.var_357F.var_0CAB lib_0378::func_8D74("voice_of_god_start", level.var_3580, level.var_3581);
      }

      var_05 = common_scripts\utility::func_46B7("sonic_amp_tumbler", "targetname");
      foreach(var_07 in var_05) {
        var_08 = getEntArray(var_07.var_01A2, "targetname");
        foreach(var_0A in var_08) {
          if(var_0A.var_003A == "script_model") {
            playFXOnTag(level.var_0611["zmb_vog_code_correct"], var_0A, "Flute");
          }
        }
      }

      if(!common_scripts\utility::func_3C77("flag_correct_code_entered")) {
        thread func_2EBA(1, var_01);
        common_scripts\utility::func_3C8F("flag_correct_code_entered");
      }

      break;
    } else {
      level.var_357F.var_0CAB lib_0378::func_8D74("voice_of_god_fail");
      var_05 = common_scripts\utility::func_46B7("sonic_amp_tumbler", "targetname");
      foreach(var_07 in var_05) {
        var_08 = getEntArray(var_07.var_01A2, "targetname");
        foreach(var_0A in var_08) {
          if(var_0A.var_003A == "script_model") {
            playFXOnTag(level.var_0611["zmb_vog_code_incorrect"], var_0A, "Flute");
          }
        }
      }

      if(!common_scripts\utility::func_3C77("flag_correct_code_entered")) {
        thread func_2EBA(0, var_01);
      }

      self sethintstring(&"ZOMBIE_NEST_AMP_RESETTING");
      wait(level.var_357E);
    }
  }
}

func_8B29(param_00) {
  level endon("game_ended");
  level endon("vog_disabled");
  var_01 = common_scripts\utility::func_46B5(self.var_9E46.var_01A2, "targetname");
  if(isDefined(var_01)) {
    self.var_9E46 usetouchtriggerrequirefacingposition(1, var_01.var_0116);
  }

  for(;;) {
    self.var_9E46 waittill("trigger", var_02);
    self.var_9E46 makeunusable();
    if(self.var_28F1 + 1 < level.var_3583) {
      level.var_3584[param_00] = self.var_28F1 + 1;
      func_A185(self.var_28F1 + 1);
    } else {
      level.var_3584[param_00] = 0;
      func_A185(0);
    }

    self.var_9E46 makeusable();
    wait(0.5);
  }
}

func_2EBA(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(!isDefined(param_01)) {
    return;
  }

  if(param_00) {
    wait(6);
    param_01 thread lib_0367::func_8E3C("voiceofgodcomplete");
    return;
  }

  if(!isDefined(param_01.var_3075) && isPlayer(param_01)) {
    wait(0.5);
    var_02 = param_01 lib_0367::func_8E3D("voiceofgoderror");
    if(isDefined(var_02)) {
      param_01.var_3075 = 1;
      return;
    }
  }
}

func_8C28() {
  self.var_0DBE hidepart("TAG_BLOOD");
  self.var_0DBE hidepart("TAG_DEATH");
  self.var_0DBE hidepart("TAG_MOON");
  self.var_0DBE hidepart("TAG_STORM");
  switch (self.var_9E45) {
    case 0:
      self.var_0DBE showpart("TAG_BLOOD");
      break;

    case 1:
      self.var_0DBE showpart("TAG_MOON");
      break;

    case 2:
      self.var_0DBE showpart("TAG_DEATH");
      break;

    case 3:
      self.var_0DBE showpart("TAG_STORM");
      break;
  }
}

func_A185(param_00) {
  var_01 = self.var_28F1;
  var_02 = param_00;
  self.var_28F1 = param_00;
  var_03 = undefined;
  var_04 = undefined;
  switch (var_02) {
    case 0:
      var_03 = % zmb_hilt_altar_voice_reverse_5_to_1;
      break;

    case 1:
      var_03 = % zmb_hilt_altar_voice_activate_01;
      break;

    case 2:
      var_03 = % zmb_hilt_altar_voice_activate_02;
      break;

    case 3:
      var_03 = % zmb_hilt_altar_voice_activate_03;
      break;

    case 4:
      var_03 = % zmb_hilt_altar_voice_activate_04;
      break;
  }

  if(!isDefined(var_03)) {
    return;
  }

  self.var_0DBE lib_0378::func_8D74("voice_of_god_update_tumbler", var_02);
  var_04 = getanimlength(var_03);
  self.var_0DBE scriptmodelplayanim(getanimname(var_03));
  wait(var_04);
}

func_8A39() {
  level.var_3581 = func_7A54();
  level.var_358A = common_scripts\utility::func_46B7("code_painting", "targetname");
  level.var_358A common_scripts\utility::func_0F92(level.var_358A);
  for(var_00 = 0; var_00 < level.var_358A.size; var_00++) {
    level.var_358A[var_00].var_248B = undefined;
    level.var_358A[var_00].var_8CA4 = undefined;
    level.var_358A[var_00].var_9DC2 = [];
    var_01 = common_scripts\utility::func_44BE(level.var_358A[var_00].var_01A2, "targetname");
    foreach(var_03 in var_01) {
      var_04 = var_03.var_0165;
      if(!isDefined(var_04)) {
        continue;
      }

      switch (var_04) {
        case "painting_slot_pos":
          level.var_358A[var_00].var_8CA5 = var_03;
          break;

        case "painting_code_pos":
          level.var_358A[var_00].var_248C = var_03;
          break;

        case "painting_model":
          level.var_358A[var_00].var_6DF1 = var_03;
          break;

        case "painting_center":
          level.var_358A[var_00].var_6DEF = var_03;
          break;

        case "painting_trig":
          level.var_358A[var_00].var_9DC2[level.var_358A[var_00].var_9DC2.size] = var_03;
          break;

        default:
          break;
      }
    }

    for(var_06 = 0; var_06 < level.var_3581.size; var_06++) {
      if(var_00 == var_06) {
        level.var_358A[var_00].var_8CA4 = func_45FA(var_06);
        level.var_358A[var_00].var_248B = func_45F9(level.var_3581[var_06]);
      }
    }

    if(var_00 > level.var_3582) {}

    for(var_07 = 0; var_07 < 4; var_07++) {
      level.var_358A[var_00].var_9DC2[var_07].var_6DF0 = level.var_358A[var_00].var_0165;
      thread lib_0547::func_8A4F(level.var_358A[var_00].var_9DC2[var_07], ::func_10E0);
    }

    lib_057E::func_0984(level.var_358A[var_00], level.var_358A[var_00].var_6DEF, ::func_6DF2);
  }
}

func_7A54() {
  var_00 = 0;
  var_01 = 0;
  var_02 = 0;
  var_03 = [];
  while(!var_00) {
    for(var_04 = 0; var_04 < level.var_3582; var_04++) {
      var_03[var_04] = randomint(level.var_3583);
      if(var_04 != 0 && var_03[var_04] == var_03[var_04 - 1]) {
        var_01++;
      }
    }

    if(var_01 < level.var_3582 || var_02 >= 5) {
      var_00 = 1;
      continue;
    }

    var_02++;
    var_01 = 0;
    wait(0.25);
  }

  return var_03;
}

func_45F9(param_00) {
  switch (param_00) {
    case 0:
      return "zmb_paint_code_one";

    case 1:
      return "zmb_paint_code_two";

    case 2:
      return "zmb_paint_code_three";

    case 3:
      return "zmb_paint_code_four";

    case 4:
      return "zmb_paint_code_five";

    default:
      return undefined;
  }
}

func_45FA(param_00) {
  switch (param_00) {
    case 0:
      return "zmb_paint_code_blood";

    case 1:
      return "zmb_paint_code_moon";

    case 2:
      return "zmb_paint_code_death";

    case 3:
      return "zmb_paint_code_storm";

    default:
      return undefined;
  }
}

func_8A22() {
  maps\mp\mp_zombie_nest_ee_util::func_A6BB();
  var_00 = 0;
  while(!var_00) {
    foreach(var_02 in level.var_744A) {
      if(lib_057E::func_314D(var_02)) {
        var_00 = 1;
      }
    }

    wait(1);
  }

  common_scripts\utility::func_3C8F("flag_player_has_head");
}

func_2E7D(param_00) {
  self endon("player_checked_a_painting");
  for(;;) {
    self waittill("trigger", var_01);
    if(!common_scripts\utility::func_562E(var_01.var_3061)) {
      if(common_scripts\utility::func_24A6()) {
        var_02 = "paintingtouch";
      } else {
        var_02 = "loreart";
      }

      var_03 = var_01 lib_0367::func_8E3D(var_02);
      if(isDefined(var_03)) {
        var_01.var_3061 = 1;
      }

      break;
    }
  }

  foreach(var_05 in level.var_358A) {
    foreach(var_07 in var_05.var_9DC2) {
      if(var_01 lib_0547::func_0696(var_07)) {
        var_07 disableplayeruse(var_01);
        var_07 sethintstring(&"ZOMBIES_EMPTY_STRING");
        var_07 notify("player_checked_a_painting");
      }
    }
  }
}

func_2EA3(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  if(!isDefined(param_01)) {
    return;
  }

  if(param_00 == 1) {
    if(common_scripts\utility::func_24A6()) {
      param_01 thread lib_0367::func_8E3C("paintingreveal");
      return;
    }

    param_01 thread lib_0367::func_8E3C("paintingcodereveal");
    return;
  }

  if(param_00 == 2 || param_00 == 3) {
    if(common_scripts\utility::func_24A6()) {
      param_01 thread lib_0367::func_8E3C("paintingclue");
      return;
    }

    return;
  }

  if(param_00 == 4) {
    param_01 thread lib_0367::func_8E3C("voiceofgodcodes");
    return;
  }
}

func_10E0(param_00) {
  param_00 endon("disconnect");
  if(isDefined(self.var_6DF0)) {
    var_01 = "painting_" + self.var_6DF0;
  } else {
    var_01 = "painting_1";
  }

  self.var_4D91 = lib_0559::func_7BE2(param_00, self, var_01);
  thread func_2E7D(param_00);
}

func_6DF2(param_00, param_01) {
  var_02 = lib_0547::func_8FBA(param_00.var_8CA5, param_00.var_8CA4);
  var_03 = lib_0547::func_8FBA(param_00.var_248C, param_00.var_248B);
  triggerfx(var_02);
  triggerfx(var_03);
  level.var_3585++;
  var_04 = "ee_painting_reveal_" + level.var_3585;
  if(common_scripts\utility::func_3C83(var_04)) {
    common_scripts\utility::func_3C8F(var_04);
  }

  if(level.var_3585 == 1) {
    thread func_2EA3(level.var_3585, param_01);
    if(lib_0557::func_783E("6B Left Hand overcharge", "activate left hand")) {
      lib_0557::func_7822("7 Voice paintings", &"ZOMBIE_NEST_HINT_STEP_FIND_CODE_2");
      return;
    }

    return;
  }

  if(level.var_3585 > 1 && level.var_3585 < level.var_3582) {
    thread func_2EA3(level.var_3585, param_01);
    return;
  }

  if(level.var_3585 >= level.var_3582) {
    common_scripts\utility::func_3C8F("flag_all_paintings_revealed");
    thread func_2EA3(level.var_3585, param_01);
    return;
  }
}

func_455A() {
  var_00 = [];
  var_01 = self.var_01A2;
  for(;;) {
    var_02 = getent(var_01, "targetname");
    if(common_scripts\utility::func_0F79(var_00, var_02)) {
      break;
    } else {
      var_00[var_00.size] = var_02;
      if(isDefined(var_00[var_00.size - 1].var_01A2)) {
        var_01 = var_00[var_00.size - 1].var_01A2;
        continue;
      }

      break;
    }
  }

  return var_00;
}