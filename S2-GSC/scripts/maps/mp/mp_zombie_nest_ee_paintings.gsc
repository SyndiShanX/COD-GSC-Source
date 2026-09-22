/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_paintings.gsc
***********************************************************/

main() {
  level._id_3589 = 3000;
  level._id_3582 = 4;
  level._id_3583 = 5;
  level._id_3588 = 0;
  level._id_357E = 30;
  level._id_3585 = 0;
  level._id_358A = [];
  level._id_3581 = [];
  level._id_3584 = [];
  level._id_357F = undefined;
  level._id_3580 = [];
  level._id_3587 = undefined;
  level._id_3586 = "tumbler_";
  level._id_9333 = [];
  level.scragentgetmaxturnspeed = 0;
  common_scripts\utility::flag_init("flag_head_picked_up");
  common_scripts\utility::flag_init("flag_head_hint_seen");
  common_scripts\utility::flag_init("flag_painting_hint_seen");
  common_scripts\utility::flag_init("flag_both_hints_seen");
  common_scripts\utility::flag_init("flag_all_paintings_revealed");
  common_scripts\utility::flag_init("flag_correct_code_entered");
  common_scripts\utility::flag_init("flag_one_painting_checked");
  common_scripts\utility::flag_init("flag_player_has_head");

  for(var_0 = 1; var_0 <= level._id_3582; var_0++) {
    common_scripts\utility::flag_init("ee_painting_reveal_" + var_0);
  }

  _id_0557::_id_7846("7 Voice paintings", ::_id_6DF3, ["6B Left Hand overcharge"], &"ZOMBIE_NEST_HINT_QUEST_PAINTINGS", "ZOMBIE_NEST_HINT_QUEST_PAINTINGS");
  _id_0557::_id_781E("7 Voice paintings", "find code pieces", ::_id_7879, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_FIND_CODE");
  _id_0557::_id_781E("7 Voice paintings", "enter code pieces", ::_id_7877, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_ENTER_CODE");
  _id_0557::_id_7848("7 Voice paintings");
  _id_5328();
}

_id_5328() {
  waitframe();
  _id_8A39();
  thread _id_8A46();
  thread _id_8A24();
  thread _id_8A25();
  thread _id_8A22();
  thread mainpathcompletionlistener();
}

_id_7879() {
  _id_3664(0);
  _id_3666();

  if(!common_scripts\utility::_id_3C77("flag_all_paintings_revealed")) {
    if(common_scripts\utility::_id_3C77("ee_painting_reveal_1") || common_scripts\utility::_id_3C77("ee_painting_reveal_2") || common_scripts\utility::_id_3C77("ee_painting_reveal_3") || common_scripts\utility::_id_3C77("ee_painting_reveal_4")) {
      _id_0557::_id_7822("7 Voice paintings", &"ZOMBIE_NEST_HINT_STEP_FIND_CODE_2");
    } else {
      if(!common_scripts\utility::_id_3C77("flag_both_hints_seen") && !common_scripts\utility::_id_3C77("flag_player_has_head")) {
        if(1) {
          var_0 = _getEnt("paintings_hint_head_jar", "targetname");
          var_1 = _id_0557::_id_782F(undefined, var_0);
          _id_0557::_id_781D("7 Voice paintings", var_1, 0);
        }

        common_scripts\utility::_id_3CA2("flag_both_hints_seen", "flag_player_has_head");
      }

      if(common_scripts\utility::_id_3C77("flag_player_has_head")) {
        _id_0557::_id_7822("7 Voice paintings", &"ZOMBIE_NEST_HINT_STEP_USE_HEAD");
      } else {
        _id_0557::_id_7822("7 Voice paintings", &"ZOMBIE_NEST_HINT_STEP_FIND_HEAD");
        common_scripts\utility::_id_3C9F("flag_player_has_head");
        _id_0557::_id_7822("7 Voice paintings", &"ZOMBIE_NEST_HINT_STEP_USE_HEAD");
      }

      common_scripts\utility::_id_3CA2("ee_painting_reveal_1", "ee_painting_reveal_2", "ee_painting_reveal_3", "ee_painting_reveal_4", "flag_correct_code_entered");
      _id_0557::_id_7822("7 Voice paintings", &"ZOMBIE_NEST_HINT_STEP_FIND_CODE_2");
    }

    if(1) {
      var_2 = getEntArray("painting_boxes", "targetname");

      if(isDefined(var_2)) {
        var_3 = _id_0557::_id_782F(undefined, var_2);
        _id_0557::_id_781D("7 Voice paintings", var_3, 0);
      }
    }
  }

  common_scripts\utility::_id_3CA2("flag_all_paintings_revealed", "flag_correct_code_entered");

  if(!_id_0557::_id_783E("7 Voice paintings", "find code pieces")) {
    _id_0557::_id_782D("7 Voice paintings", "find code pieces");
  }
}

_id_787A() {}

_id_787E() {}

_id_7877() {
  if(1) {
    var_0 = getEntArray("voice_of_god_model", "targetname");
    var_1 = _id_0557::_id_782F(undefined, var_0);
    _id_0557::_id_781D("7 Voice paintings", var_1);
  }

  common_scripts\utility::_id_3C9F("flag_correct_code_entered");
  thread maps\mp\mp_zombie_nest_ee_util::_id_4D78(3);
  level._id_357F common_scripts\utility::_id_9D9F();

  if(!_id_0557::_id_783E("7 Voice paintings", "find code pieces")) {
    _id_0557::_id_782D("7 Voice paintings", "find code pieces");
  }

  _id_0557::_id_782D("7 Voice paintings", "enter code pieces");
}

_id_6DF3() {
  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("voiceofgod");
    var_1 _id_0378::_id_8D74("objective_complete", "voiceofgod");
  }
}

mainpathcompletionlistener() {
  common_scripts\utility::_id_3C9F("flag_correct_code_entered");
  common_scripts\utility::_id_3CA2("flag_nest_hc_ee_true_voice_entered", _id_0557::_id_7838("8B final boss", "final boss battle part 1"));
  level notify("vog_disabled");
  disabletumblertriggers();
  disabletheconfirmtrigger();
}

_id_8A24() {
  level endon("flag_both_hints_seen");
  var_0 = _getEnt("head_hint_trig", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0._id_5877 = _getEnt("paintings_hint_head_jar", "targetname");
  var_0._id_5877 setModel("zmb_med_jar_04_nodecals");
  var_0 useTriggerRequireLookAt(1);

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!common_scripts\utility::_id_562E(var_1._id_306F)) {
      var_1 thread _id_0367::_id_8E3C("paintingsuv");
      var_1._id_306F = 1;
    }

    var_2 = 1;

    foreach(var_4 in level.players) {
      if(!common_scripts\utility::_id_562E(var_4._id_306F)) {
        var_2 = 0;
        break;
      }
    }

    if(var_2) {
      common_scripts\utility::flag_set("flag_head_hint_seen");
      var_0 delete();

      if(common_scripts\utility::_id_3C77("flag_painting_hint_seen")) {
        common_scripts\utility::flag_set("flag_both_hints_seen");
      }

      break;
    }
  }
}

_id_8A25() {
  level endon("flag_both_hints_seen");
  var_0 = _getEnt("painting_hint_trig", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0._id_6DEE = _getEnt("paintings_hint_painting", "targetname");
  var_0 useTriggerRequireLookAt(1);

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!common_scripts\utility::_id_562E(var_1._id_3070)) {
      var_1 thread _id_0367::_id_8E3C("paintingssecret");
      var_1._id_3070 = 1;
    }

    var_2 = 1;

    foreach(var_4 in level.players) {
      if(!common_scripts\utility::_id_562E(var_4._id_3070)) {
        var_2 = 0;
        break;
      }
    }

    if(var_2) {
      common_scripts\utility::flag_set("flag_painting_hint_seen");
      var_0 delete();

      if(common_scripts\utility::_id_3C77("flag_head_hint_seen")) {
        common_scripts\utility::flag_set("flag_both_hints_seen");
      }

      break;
    }
  }
}

_id_8A46() {
  level._id_357F = _getEnt("sonic_amp_confirm_code_trig", "targetname");
  level._id_357F common_scripts\utility::_id_9D9F();
  level._id_357F._id_0CAB = _getEnt("sonic_amp_control", "targetname");

  if(isDefined(level._id_357F._id_0CAB)) {
    level._id_357F._id_0CAB thread maps\mp\mp_zombie_nest_ee_util::_id_4D77("off");
  }

  var_0 = common_scripts\utility::_id_46B7("sonic_amp_tumbler", "targetname");
  var_1 = level._id_3586;

  foreach(var_3 in var_0) {
    var_4 = var_3.setlookatent;
    var_5 = getsubstr(var_4, var_1.size, var_4.size);
    var_5 = int(common_scripts\utility::stringtofloat(var_5)) - 1;
    var_6 = common_scripts\utility::_id_44BE(var_3.target, "targetname");

    foreach(var_8 in var_6) {
      if(!isDefined(var_8._id_0165)) {
        continue;
      }
      var_9 = var_8._id_0165;

      switch (var_9) {
        case "amp_trig":
          var_3._id_9E46 = var_8;
          break;
        case "amp_model":
          var_3._id_0DBE = var_8;
          break;
        default:
          break;
      }
    }

    var_3._id_28F1 = 0;
    var_3._id_9E46 common_scripts\utility::_id_9D9F();
    var_3._id_9E45 = var_5;
    level._id_3580[var_5] = var_3;
  }

  _id_7A56();
  _id_5308();
}

_id_3664(var_0) {
  if(isDefined(level._id_357F._id_0CAB) && !var_0) {
    level._id_357F._id_4D91 = _id_0559::_id_7BE3(level._id_357F, "vog");
    level._id_357F._id_0CAB thread maps\mp\mp_zombie_nest_ee_util::_id_4D77("red");
  }

  level._id_357F common_scripts\utility::_id_9DA3();
  level._id_357F thread _id_2580(var_0);
}

disabletheconfirmtrigger() {
  level._id_357F common_scripts\utility::_id_9D9F();
}

_id_3666() {
  foreach(var_1 in level._id_3580) {
    var_1._id_9E46 common_scripts\utility::_id_9DA3();
  }
}

disabletumblertriggers() {
  foreach(var_1 in level._id_3580) {
    var_1._id_9E46 common_scripts\utility::_id_9D9F();
  }
}

_id_43CC() {
  return "flag_correct_code_entered";
}

_id_5308() {
  for(var_0 = 0; var_0 < level._id_3580.size; var_0++) {
    level._id_3580[var_0] _id_A185(level._id_3584[var_0]);

    if(isDefined(level._id_3580[var_0]._id_9E46)) {
      level._id_3580[var_0]._id_9E46 setHintString(&"ZOMBIE_NEST_AMP_CHANGE_CODE");
      level._id_3580[var_0]._id_9E46._id_4D91 = _id_0559::_id_7BE3(level._id_3580[var_0]._id_9E46, "vog");
      level._id_3580[var_0] thread _id_8B29(var_0);
    }

    if(isDefined(level._id_3580[var_0]._id_0DBE)) {
      level._id_3580[var_0] thread _id_8C28();
    }
  }
}

_id_7A56() {
  for(var_0 = 0; var_0 < level._id_3582; var_0++) {
    var_1 = 0;

    while(!var_1) {
      if(0) {
        level._id_3584[var_0] = randomint(level._id_3583);

        if(level._id_3584[var_0] != level._id_3581[var_0]) {
          var_1 = 1;
        }
      } else {
        level._id_3584[var_0] = 0;
        var_1 = 1;
      }

      waitframe();
    }
  }
}

_id_2580(var_0) {
  level endon("game_ended");
  level endon("vog_disabled");

  for(;;) {
    self setHintString(&"ZOMBIE_NEST_AMP_CONFIRM_CODE");
    self waittill("trigger", var_1);
    var_2 = common_scripts\utility::_id_46B5("VOG_effects_attach", "targetname");
    var_3 = 1;

    for(var_4 = 0; var_4 < level._id_3584.size; var_4++) {
      if(level._id_3584[var_4] != level._id_3581[var_4]) {
        var_3 = 0;
      }
    }

    if(isDefined(level._id_357F._id_0CAB)) {
      level._id_357F._id_0CAB thread maps\mp\mp_zombie_nest_ee_util::_id_4D76();
    }

    if(var_3) {
      if(isDefined(level._id_357F._id_0CAB)) {
        level._id_357F._id_0CAB thread maps\mp\mp_zombie_nest_ee_util::_id_4D77("green");
      }

      if(!var_0) {
        level._id_357F._id_0CAB _id_0378::_id_8D74("voice_of_god_start", level._id_3580, level._id_3581);
      }

      var_5 = common_scripts\utility::_id_46B7("sonic_amp_tumbler", "targetname");

      foreach(var_7 in var_5) {
        var_8 = getEntArray(var_7.target, "targetname");

        foreach(var_10 in var_8) {
          if(var_10.classname == "script_model") {
            _playFXOnTag(level._effect["zmb_vog_code_correct"], var_10, "Flute");
          }
        }
      }

      if(!common_scripts\utility::_id_3C77("flag_correct_code_entered")) {
        thread _id_2EBA(1, var_1);
        common_scripts\utility::flag_set("flag_correct_code_entered");
      }

      break;
    } else {
      level._id_357F._id_0CAB _id_0378::_id_8D74("voice_of_god_fail");
      var_5 = common_scripts\utility::_id_46B7("sonic_amp_tumbler", "targetname");

      foreach(var_7 in var_5) {
        var_8 = getEntArray(var_7.target, "targetname");

        foreach(var_10 in var_8) {
          if(var_10.classname == "script_model") {
            _playFXOnTag(level._effect["zmb_vog_code_incorrect"], var_10, "Flute");
          }
        }
      }

      if(!common_scripts\utility::_id_3C77("flag_correct_code_entered")) {
        thread _id_2EBA(0, var_1);
      }

      self setHintString(&"ZOMBIE_NEST_AMP_RESETTING");
      wait(level._id_357E);
    }
  }
}

_id_8B29(var_0) {
  level endon("game_ended");
  level endon("vog_disabled");
  var_1 = common_scripts\utility::_id_46B5(self._id_9E46.target, "targetname");

  if(isDefined(var_1)) {
    self._id_9E46 _meth_8660(1, var_1.origin);
  }

  for(;;) {
    self._id_9E46 waittill("trigger", var_2);
    self._id_9E46 makeunusable();

    if(self._id_28F1 + 1 < level._id_3583) {
      level._id_3584[var_0] = self._id_28F1 + 1;
      _id_A185(self._id_28F1 + 1);
    } else {
      level._id_3584[var_0] = 0;
      _id_A185(0);
    }

    self._id_9E46 makeusable();
    wait 0.5;
  }
}

_id_2EBA(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    return;
  }
  if(var_0) {
    wait 6;
    var_1 thread _id_0367::_id_8E3C("voiceofgodcomplete");
  } else if(!isDefined(var_1._id_3075) && isPlayer(var_1)) {
    wait 0.5;
    var_2 = var_1 _id_0367::_id_8E3D("voiceofgoderror");

    if(isDefined(var_2)) {
      var_1._id_3075 = 1;
    }
  }
}

_id_8C28() {
  self._id_0DBE hidepart("TAG_BLOOD");
  self._id_0DBE hidepart("TAG_DEATH");
  self._id_0DBE hidepart("TAG_MOON");
  self._id_0DBE hidepart("TAG_STORM");

  switch (self._id_9E45) {
    case 0:
      self._id_0DBE showpart("TAG_BLOOD");
      break;
    case 1:
      self._id_0DBE showpart("TAG_MOON");
      break;
    case 2:
      self._id_0DBE showpart("TAG_DEATH");
      break;
    case 3:
      self._id_0DBE showpart("TAG_STORM");
      break;
  }
}

#using_animtree("destructibles");

_id_A185(var_0) {
  var_1 = self._id_28F1;
  var_2 = var_0;
  self._id_28F1 = var_0;
  var_3 = undefined;
  var_4 = undefined;

  switch (var_2) {
    case 0:
      var_3 = % zmb_hilt_altar_voice_reverse_5_to_1;
      break;
    case 1:
      var_3 = % zmb_hilt_altar_voice_activate_01;
      break;
    case 2:
      var_3 = % zmb_hilt_altar_voice_activate_02;
      break;
    case 3:
      var_3 = % zmb_hilt_altar_voice_activate_03;
      break;
    case 4:
      var_3 = % zmb_hilt_altar_voice_activate_04;
      break;
  }

  if(!isDefined(var_3)) {
    return;
  }
  self._id_0DBE _id_0378::_id_8D74("voice_of_god_update_tumbler", var_2);
  var_4 = _getanimlength(var_3);
  self._id_0DBE scriptmodelplayanim(_debuggetanimname(var_3));
  wait(var_4);
}

_id_8A39() {
  level._id_3581 = _id_7A54();
  level._id_358A = common_scripts\utility::_id_46B7("code_painting", "targetname");
  level._id_358A common_scripts\utility::array_randomize(level._id_358A);

  for(var_0 = 0; var_0 < level._id_358A.size; var_0++) {
    level._id_358A[var_0]._id_248B = undefined;
    level._id_358A[var_0]._id_8CA4 = undefined;
    level._id_358A[var_0]._id_9DC2 = [];
    var_1 = common_scripts\utility::_id_44BE(level._id_358A[var_0].target, "targetname");

    foreach(var_3 in var_1) {
      var_4 = var_3._id_0165;

      if(!isDefined(var_4)) {
        continue;
      }
      switch (var_4) {
        case "painting_slot_pos":
          level._id_358A[var_0]._id_8CA5 = var_3;
          break;
        case "painting_code_pos":
          level._id_358A[var_0]._id_248C = var_3;
          break;
        case "painting_model":
          level._id_358A[var_0]._id_6DF1 = var_3;
          break;
        case "painting_center":
          level._id_358A[var_0]._id_6DEF = var_3;
          break;
        case "painting_trig":
          level._id_358A[var_0]._id_9DC2[level._id_358A[var_0]._id_9DC2.size] = var_3;
          break;
        default:
          break;
      }
    }

    for(var_6 = 0; var_6 < level._id_3581.size; var_6++) {
      if(var_0 == var_6) {
        level._id_358A[var_0]._id_8CA4 = _id_45FA(var_6);
        level._id_358A[var_0]._id_248B = _id_45F9(level._id_3581[var_6]);
      }
    }

    if(var_0 > level._id_3582) {}

    for(var_7 = 0; var_7 < 4; var_7++) {
      level._id_358A[var_0]._id_9DC2[var_7]._id_6DF0 = level._id_358A[var_0]._id_0165;
      thread _id_0547::_id_8A4F(level._id_358A[var_0]._id_9DC2[var_7], ::_id_10E0);
    }

    _id_057E::_id_0984(level._id_358A[var_0], level._id_358A[var_0]._id_6DEF, ::_id_6DF2);
  }
}

_id_7A54() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = [];

  while(!var_0) {
    for(var_4 = 0; var_4 < level._id_3582; var_4++) {
      var_3[var_4] = randomint(level._id_3583);

      if(var_4 != 0 && var_3[var_4] == var_3[var_4 - 1]) {
        var_1++;
      }
    }

    if(var_1 < level._id_3582 || var_2 >= 5) {
      var_0 = 1;
      continue;
    }

    var_2++;
    var_1 = 0;
    wait 0.25;
  }

  return var_3;
}

_id_45F9(var_0) {
  switch (var_0) {
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

_id_45FA(var_0) {
  switch (var_0) {
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

_id_8A22() {
  maps\mp\mp_zombie_nest_ee_util::_id_A6BB();
  var_0 = 0;

  while(!var_0) {
    foreach(var_2 in level.players) {
      if(_id_057E::_id_314D(var_2)) {
        var_0 = 1;
      }
    }

    wait 1;
  }

  common_scripts\utility::flag_set("flag_player_has_head");
}

_id_2E7D(var_0) {
  self endon("player_checked_a_painting");

  for(;;) {
    self waittill("trigger", var_1);

    if(!common_scripts\utility::_id_562E(var_1._id_3061)) {
      if(common_scripts\utility::_id_24A6()) {
        var_2 = "paintingtouch";
      } else {
        var_2 = "loreart";
      }

      var_3 = var_1 _id_0367::_id_8E3D(var_2);

      if(isDefined(var_3)) {
        var_1._id_3061 = 1;
      }

      break;
    }
  }

  foreach(var_5 in level._id_358A) {
    foreach(var_7 in var_5._id_9DC2) {
      if(var_1 _id_0547::_id_0696(var_7)) {
        var_7 disableplayeruse(var_1);
        var_7 setHintString(&"ZOMBIES_EMPTY_STRING");
        var_7 notify("player_checked_a_painting");
      }
    }
  }
}

_id_2EA3(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_1)) {
    return;
  }
  if(var_0 == 1) {
    if(common_scripts\utility::_id_24A6()) {
      var_1 thread _id_0367::_id_8E3C("paintingreveal");
    } else {
      var_1 thread _id_0367::_id_8E3C("paintingcodereveal");
    }
  } else if(var_0 == 2 || var_0 == 3) {
    if(common_scripts\utility::_id_24A6()) {
      var_1 thread _id_0367::_id_8E3C("paintingclue");
    }
  } else if(var_0 == 4)
    var_1 thread _id_0367::_id_8E3C("voiceofgodcodes");
}

_id_10E0(var_0) {
  var_0 endon("disconnect");

  if(isDefined(self._id_6DF0)) {
    var_1 = "painting_" + self._id_6DF0;
  } else {
    var_1 = "painting_1";
  }

  self._id_4D91 = _id_0559::_id_7BE2(var_0, self, var_1);
  thread _id_2E7D(var_0);
}

_id_6DF2(var_0, var_1) {
  var_2 = _id_0547::_id_8FBA(var_0._id_8CA5, var_0._id_8CA4);
  var_3 = _id_0547::_id_8FBA(var_0._id_248C, var_0._id_248B);
  _triggerfx(var_2);
  _triggerfx(var_3);
  level._id_3585++;
  var_4 = "ee_painting_reveal_" + level._id_3585;

  if(common_scripts\utility::_id_3C83(var_4)) {
    common_scripts\utility::flag_set(var_4);
  }

  if(level._id_3585 == 1) {
    thread _id_2EA3(level._id_3585, var_1);

    if(_id_0557::_id_783E("6B Left Hand overcharge", "activate left hand")) {
      _id_0557::_id_7822("7 Voice paintings", &"ZOMBIE_NEST_HINT_STEP_FIND_CODE_2");
    }
  } else if(level._id_3585 > 1 && level._id_3585 < level._id_3582)
    thread _id_2EA3(level._id_3585, var_1);
  else if(level._id_3585 >= level._id_3582) {
    common_scripts\utility::flag_set("flag_all_paintings_revealed");
    thread _id_2EA3(level._id_3585, var_1);
  }
}

_id_455A() {
  var_0 = [];
  var_1 = self.target;

  for(;;) {
    var_2 = _getEnt(var_1, "targetname");

    if(common_scripts\utility::_id_0F79(var_0, var_2)) {
      break;
    } else {
      var_0[var_0.size] = var_2;

      if(isDefined(var_0[var_0.size - 1].target)) {
        var_1 = var_0[var_0.size - 1].target;
        continue;
      }

      break;
    }
  }

  return var_0;
}