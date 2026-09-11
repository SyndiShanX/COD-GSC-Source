/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\captive\captive_vo.gsc
**************************************************/

function captive_vo_flags() {
  scripts\engine\utility::flag_init("hadir_speaking");
  scripts\engine\utility::flag_init("corner_dialog_started");
  scripts\engine\utility::flag_init("interrupt_dialog");
  scripts\engine\utility::flag_init("dialog_line_finished");
  scripts\engine\utility::flag_init("corner_dialog_interrupted");
  scripts\engine\utility::flag_init("done_face_after_move_reminder");
  scripts\engine\utility::flag_init("done_rock_hint");
  scripts\engine\utility::flag_init("has_seen_button");
  scripts\engine\utility::flag_init("looking_at_button");
  scripts\engine\utility::flag_init("hit_near_celldoor_button");
  scripts\engine\utility::flag_init("looking_at_stairs");
  scripts\engine\utility::flag_init("has_calledout_drain_room");
  scripts\engine\utility::flag_init("has_calledout_drain_room_pickup");
  scripts\engine\utility::flag_init("played_fenced_area_vo");
  scripts\engine\utility::flag_init("at_drain_fence");
  scripts\engine\utility::flag_init("made_rock_comment");
  scripts\engine\utility::flag_init("made_dig_comment");
  scripts\engine\utility::flag_init("ignore_efforts");
  scripts\engine\utility::flag_init("barkov_speaking");
  scripts\engine\utility::flag_init("player_speaking");
  scripts\engine\utility::flag_init("near_secure_door");
  scripts\engine\utility::flag_init("low_breath_cooldown");
  scripts\engine\utility::flag_init("ayah_near_meet_sas_door");
  scripts\engine\utility::flag_init("done_bu_breach_vo");
  scripts\engine\utility::flag_init("done_breach_callout");
  scripts\engine\utility::flag_init("finished_sniper_callout");
  scripts\engine\utility::flag_init("started_bs_radio_conversation");
  scripts\engine\utility::flag_init("did_hadir_callout");
  level.druggedwomanresponsecount = 0;
}

function vo_death_callout(var_0, var_1) {
  self waittill("death", var_2);

  if(var_2 == level.player) {
    return;
  }

  wait 0.3;
  scripts\sp\maps\captive\captive_util::wait_combat_cooldown(0.3, 0.6);

  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  foreach(var_4 in var_0) {
    if(scripts\engine\sp\utility::is_deck(var_4)) {
      for(var_5 = var_4 scripts\engine\sp\utility::deck_draw(); !isalive(var_1[strtok(var_5, "_")[2]]); var_5 = var_4 scripts\engine\sp\utility::deck_draw()) {}

      var_4 = var_5;
    }

    var_6 = var_1[strtok(var_4, "_")[2]];
    var_6 scripts\sp\maps\captive\captive_util::say_as_chatter(var_4, 1, 0.8);
  }
}

function barkov_dialog_interrupt() {
  scripts\engine\utility::flag_set("interrupt_dialog");

  if(scripts\engine\utility::flag("corner_dialog_started")) {
    scripts\engine\utility::flag_set("corner_dialog_interrupted");
  }

  if(!scripts\engine\utility::flag("barkov_began_order_turn_to_face")) {
    level.barkov stopsounds();
    wait 0.25;
    scripts\engine\utility::flag_clear("interrupt_dialog");
    return;
  }
}

function play_effort_sound(var_0) {
  level notify("end_looping_effort");

  if(!scripts\engine\utility::flag("ignore_efforts")) {
    scripts\engine\sp\utility::smart_player_dialogue_interrupt(var_0);
    return;
  }
}

function play_looping_breath_sound() {
  level endon("end_looping_effort");

  if(!isDefined(level.player.breathloopdeck)) {
    var_0 = ["dx_vom_far_break_waterboard_efforts_10", "dx_vom_far_break_waterboard_interrogate_243", "dx_vom_far_break_waterboard_efforts_20"];
    level.player.breathloopdeck = scripts\engine\sp\utility::create_deck(var_0);
  }

  while(!scripts\engine\utility::flag("ignore_efforts")) {
    level.player.breathloopdeck scripts\engine\sp\utility::refill_if_empty();

    if(scripts\engine\utility::flag("started_passout_countdown")) {
      scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_break_waterboard_efforts_30");
      continue;
    }

    scripts\engine\sp\utility::smart_player_dialogue_interrupt(level.player.breathloopdeck scripts\engine\sp\utility::deck_draw());
  }
}

function clear_effort_sound() {
  level notify("end_looping_effort");
}

function vo_break_intro_hadir_calls_out() {
  level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_break_intro_wakeup_10");
  wait 1;
  level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_break_intro_wakeup_20");
}

function vo_break_intro_hadir_beckon_from_bed(var_0) {
  scripts\engine\utility::flag_set("hadir_speaking");

  switch (var_0) {
    case 0:
      level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_break_intro_wakeup_30");
      break;
    case 1:
      level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_break_intro_wakeup_50");
      break;
    case 2:
      level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_break_intro_wakeup_40");
      break;
    default:
      var_1 = 0;
      break;
  }

  scripts\engine\utility::flag_clear("hadir_speaking");
}

function vo_break_intro_hadir_beckon_to_bars(var_0) {
  scripts\engine\utility::flag_set("hadir_speaking");

  switch (var_0) {
    case 0:
      level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_break_intro_solitary_50");
      break;
    case 1:
      level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_break_intro_solitary_40");
      break;
    default:
      break;
  }

  scripts\engine\utility::flag_clear("hadir_speaking");
}

function vo_break_intro_hadir_key_beckon(var_0) {
  scripts\engine\utility::flag_set("hadir_speaking");

  switch (var_0) {
    case 0:
      level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_break_intro_solitary_141");
      break;
    case 1:
      level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_break_intro_solitary_142");
      break;
    default:
      var_1 = 0;
      break;
  }

  scripts\engine\utility::flag_clear("hadir_speaking");
}

function vo_break_exercise_goto_corner_nag() {
  if(!isDefined(level.barkov.gotocornernagindex)) {
    level.barkov.gotocornernagindex = 0;
  }

  switch (level.barkov.gotocornernagindex) {
    case 0:
      level.barkov thread scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_22");
      break;
    case 1:
      level.barkov thread scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_21");
      break;
    default:
      scripts\sp\maps\captive\captive_break::barkov_kills_player();
      break;
  }

  level.barkov.gotocornernagindex++;
}

function vo_break_exercise_left_corner_nag(var_0) {
  if(!isDefined(level.barkov.leftcornernagindex)) {
    level.barkov.leftcornernagindex = 0;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  switch (level.barkov.leftcornernagindex) {
    case 0:
      level.barkov thread scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_150");
      break;
    case 1:
      level.barkov thread scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_160");
      break;
    case 2:
      level.barkov thread scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_170");
      break;
    case 3:
      level.barkov thread scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_180");
      break;
    default:
      if(!var_0) {
        scripts\sp\maps\captive\captive_break::barkov_kills_player(1);
      } else {
        level.barkov thread scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_150");
      }

      break;
  }

  level.barkov.leftcornernagindex++;
}

function vo_break_exercise_not_that_corner(var_0) {
  switch (var_0) {
    case 0:
      level.barkov thread scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_31");
      break;
    case 1:
      level.barkov thread scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_32");
      break;
    case 2:
      level.barkov thread scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_33");
      break;
    default:
      scripts\sp\maps\captive\captive_break::barkov_kills_player();
      break;
  }
}

function vo_break_exercise_facewall_nag(var_0) {
  switch (var_0) {
    case 0:
      level.barkov thread scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_60");
      break;
    case 1:
      level.barkov thread scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_80");
      break;
    case 2:
      level.barkov thread scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_60");
      break;
    default:
      scripts\sp\maps\captive\captive_break::barkov_kills_player();
      break;
  }
}

function vo_break_remind_dont_face_after_move() {
  level.barkov thread scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_80");
  scripts\engine\utility::flag_set("done_face_after_move_reminder");
}

function vo_break_exercise_facewall_moving() {
  level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_70");
}

function vo_break_exercise_play_corner_dialog() {
  level endon("barkov_killing_player");
  scripts\engine\utility::flag_wait("facing_wall");
  scripts\engine\utility::flag_set("corner_vo_started");

  while(!scripts\engine\utility::flag("dialog_line_finished")) {
    if(scripts\engine\utility::flag("facing_wall") && !scripts\engine\utility::flag("barkov_killing_player")) {
      if(scripts\engine\utility::flag("corner_dialog_interrupted")) {
        vo_resume_interrupted_dialog();
      }

      if(scripts\engine\utility::flag("facing_wall") && !scripts\engine\utility::flag("barkov_killing_player")) {
        vo_break_exercise_plans_to_escape();
      }
    }

    waitframe();
  }

  wait 1;
  scripts\engine\utility::flag_set("corner_vo_done");
}

function vo_break_exercise_plans_to_escape() {
  var_0 = gettime();
  var_1 = 1.5;

  if(scripts\engine\utility::flag("corner_dialog_interrupted")) {
    var_1 = 0.5;
  }

  while(!scripts\engine\utility::time_has_passed(var_0, var_1)) {
    if(!scripts\engine\utility::flag("facing_wall")) {
      return;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("corner_dialog_started");
  var_2 = "dx_vom_bkv_break_exercise_corner_50";

  if(scripts\engine\utility::flag("corner_dialog_interrupted")) {
    var_2 = "dx_vom_bkv_break_exercise_corner_51";
  }

  if(!scripts\engine\utility::flag("facing_wall") || scripts\engine\utility::flag("barkov_killing_player")) {
    return;
  }

  level.barkov thread scripts\sp\anim::play_sound_at_viewheight(var_2);
  var_1 = lookupsoundlength(var_2) / 1000;
  var_0 = gettime();

  while(!scripts\engine\utility::time_has_passed(var_0, var_1)) {
    if(!scripts\engine\utility::flag("facing_wall") || scripts\engine\utility::flag("barkov_killing_player")) {
      return;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("dialog_line_finished");
}

function vo_resume_interrupted_dialog() {
  if(!isDefined(level.barkov.interruptrepeatcount)) {
    level.barkov.interruptrepeatcount = 0;
  }

  switch (level.barkov.interruptrepeatcount) {
    case 0:
      level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_interrupt_11");
      break;
    case 1:
      level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_interrupt_90");
      break;
    case 2:
      level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_interrupt_100");
      break;
    case 3:
      level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_interrupt_170");
      break;
    case 4:
      level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_interrupt_120");
      break;
    case 5:
      level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_interrupt_110");
      break;
  }

  level.barkov.interruptrepeatcount++;
}

function vo_break_exercise_face_me_nag(var_0) {
  switch (var_0) {
    case 0:
      level.barkov thread scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_120");
      break;
    case 1:
      level.barkov thread scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_140");
      break;
    default:
      scripts\sp\maps\captive\captive_break::barkov_kills_player();
      break;
  }
}

function vo_break_enough_of_this() {
  level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_corner_25");
}

function vo_break_cough() {
  play_effort_sound(level.player, "dx_vom_far_efforts_run_20");
}

function vo_break_exercise_shock_effort() {
  var_0 = ["dx_vom_far_break_exercise_corner_27", "dx_vom_far_break_exercise_corner_85", "dx_vom_far_efforts_shock_10", "dx_vom_far_efforts_shock_20", "dx_vom_far_efforts_shock_30"];
  var_1 = var_0;
  var_2 = scripts\engine\utility::random(var_1);
  play_effort_sound(level.player, var_2);
  var_1 = scripts\engine\utility::array_remove(var_1, var_2);

  if(var_1.size == 0) {
    var_1 = var_0;
    return;
  }
}

function vo_break_wboard_obstructing_exit() {
  level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_exercise_thirsty_50");
}

function vo_break_wboard_azadeh_torture() {
  level endon("used_chair");
  var_0 = spawn("script_origin", (6085, 432, -112));
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_aza_break_waterboard_hallway_10");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_cg1_break_waterboard_hallway_20");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_aza_break_waterboard_hallway_30");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_cg1_break_waterboard_hallway_40");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_aza_break_waterboard_hallway_50");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_cg1_break_waterboard_hallway_60");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_aza_break_waterboard_hallway_70");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_cg1_break_waterboard_hallway_80");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_cg1_break_waterboard_hallway_90");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_aza_break_waterboard_hallway_100");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_cg1_break_waterboard_hallway_110");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_aza_break_waterboard_hallway_120");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_cg1_break_waterboard_hallway_130");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_aza_break_waterboard_hallway_140");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_cg1_break_waterboard_hallway_150");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_aza_break_waterboard_hallway_160");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_cg1_break_waterboard_hallway_170");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_aza_break_waterboard_hallway_180");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_aza_break_waterboard_hallway_190");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_cg1_break_waterboard_hallway_200");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_aza_break_waterboard_hallway_210");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_cg1_break_waterboard_hallway_220");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_aza_break_waterboard_hallway_230");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_cg1_break_waterboard_hallway_240");
  var_0 scripts\sp\maps\captive\captive_util::say("dx_vom_aza_break_waterboard_hallway_250");
}

function vo_break_tougher() {
  wait 1.5;
  level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_10");
}

function vo_break_wboard_success_breath(var_0) {
  if(!isDefined(level.barkov.wboardvosuccessbreathcount)) {
    level.barkov.wboardvosuccessbreathcount = 0;
  }

  if(!isDefined(level.barkov.wboardvofailbreathcount)) {
    level.barkov.wboardvofailbreathcount = 0;
  }

  if(!scripts\engine\utility::flag("barkov_speaking")) {
    scripts\engine\utility::flag_set("barkov_speaking");

    if(!scripts\engine\utility::flag("waterboard_complete")) {
      wait 0.5;

      if(level.barkov.waterboardindex == 0) {
        switch (level.barkov.wboardvosuccessbreathcount) {
          case 0:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_pass_20");
            break;
          case 1:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_pass_30");
            break;
        }

        if(level.barkov.wboardvosuccessbreathcount == 4 && level.barkov.wboardvofailbreathcount == 0) {
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_pass_60");
        } else if(level.barkov.wboardvosuccessbreathcount == 4 && level.barkov.wboardvofailbreathcount > 0) {
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_pass_40");
        } else if(level.barkov.wboardvosuccessbreathcount == 6 && level.barkov.wboardvofailbreathcount == 0) {
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_pass_70");
        } else if(level.barkov.wboardvosuccessbreathcount == 6 && level.barkov.wboardvofailbreathcount > 0) {
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_pass_50");
        }
      } else {
        switch (level.barkov.wboardvosuccessbreathcount) {
          case 0:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_90");
            break;
          case 2:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_100");
            break;
          case 3:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_180");
            break;
          case 4:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_120");
            break;
          case 5:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_190");
            break;
        }
      }

      level.barkov.wboardvosuccessbreathcount++;
      wait 0.5;
    }

    scripts\engine\utility::flag_clear("barkov_speaking");
    return;
  }
}

function vo_break_wboard_fail_breath(var_0) {
  if(!isDefined(level.barkov.wboardvofailbreathcount)) {
    level.barkov.wboardvofailbreathcount = 0;
  }

  if(!scripts\engine\utility::flag("barkov_speaking")) {
    scripts\engine\utility::flag_set("barkov_speaking");

    if(!scripts\engine\utility::flag("waterboard_complete")) {
      wait 0.5;

      if(level.barkov.waterboardindex == 0) {
        switch (level.barkov.wboardvofailbreathcount) {
          case 0:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_fail_50");
            break;
          case 1:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_fail_30");
            break;
          case 2:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_fail_130");
            break;
          case 3:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_fail_90");
            break;
          case 4:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_fail_150");
            break;
          case 5:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_fail_80");
            break;
          case 6:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_fail_70");
            break;
          case 7:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_fail_140");
            break;
          case 8:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_fail_141");
            break;
          case 9:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_fail_120");
            break;
          case 10:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_fail_110");
            break;
        }
      } else {
        switch (level.barkov.wboardvofailbreathcount) {
          case 0:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_140");
            break;
          case 1:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_150");
            break;
          case 2:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_220");
            break;
          case 3:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_200");
            break;
          case 4:
            level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_220");
            break;
        }
      }

      level.barkov.wboardvofailbreathcount++;
      wait 0.5;
    }

    scripts\engine\utility::flag_clear("barkov_speaking");
    return;
  }
}

function vo_break_wboard_hold_still() {
  if(!isDefined(level.barkov.wboardvoholdstillcount)) {
    level.barkov.wboardvoholdstillcount = 0;
  }

  if(!scripts\engine\utility::flag("waterboard_complete")) {
    scripts\engine\utility::flag_set("barkov_speaking");

    switch (level.barkov.wboardvoholdstillcount) {
      case 0:
        level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_130");
        break;
      case 1:
        level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_20");
        break;
      case 2:
        level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_30");
        break;
      case 3:
        level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_60");
        break;
      case 4:
        level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_160");
        break;
    }

    scripts\engine\utility::flag_clear("barkov_speaking");
  }

  level.barkov.wboardvoholdstillcount++;
}

function vo_break_wboard_not_moving() {
  if(!isDefined(level.barkov.wboardvonotmovingcount)) {
    level.barkov.wboardvonotmovingcount = 0;
  }

  if(!scripts\engine\utility::flag("barkov_speaking") && level.barkov.waterboardindex == 0 && !scripts\engine\utility::flag("waterboard_complete")) {
    scripts\engine\utility::flag_set("barkov_speaking");

    if(level.barkov.waterboardindex == 0) {
      switch (level.barkov.wboardvonotmovingcount) {
        case 0:
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_fail_60");
          break;
        case 1:
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_fail_100");
          break;
        case 2:
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_fail_160");
          break;
      }
    } else {
      switch (level.barkov.wboardvonotmovingcount) {
        case 0:
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_70");
          break;
      }
    }

    level.barkov.wboardvonotmovingcount++;
    wait 0.5;
    scripts\engine\utility::flag_clear("barkov_speaking");
    return;
  }
}

function vo_break_wboard_breath_low() {
  if(!isDefined(level.barkov.wboardvobreathlowcount)) {
    level.barkov.wboardvobreathlowcount = 0;
  }

  if(!scripts\engine\utility::flag("barkov_speaking") && !scripts\engine\utility::flag("low_breath_cooldown")) {
    scripts\engine\utility::flag_set("low_breath_cooldown");
    scripts\engine\utility::flag_set("barkov_speaking");

    if(level.barkov.waterboardindex == 0) {
      switch (level.barkov.wboardvobreathlowcount) {
        case 0:
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_pass_10");
          break;
        case 1:
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_fail_40");
          break;
        case 2:
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_fail_10");
        case 3:
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_fail_20");
          break;
        default:
          level.barkov.wboardvobreathlowcount = 1;
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_pass_10");
          break;
      }
    } else {
      switch (level.barkov.wboardvobreathlowcount) {
        case 0:
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_40");
          break;
        case 1:
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_50");
          break;
        case 2:
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_230");
          break;
        case 3:
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_240");
          break;
        case 4:
          level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_210");
          break;
      }
    }

    level.barkov.wboardvobreathlowcount++;
    wait 0.5;
    scripts\engine\utility::flag_clear("barkov_speaking");
    wait 3;
    scripts\engine\utility::flag_clear("low_breath_cooldown");
    return;
  }
}

function vo_break_chair_tipped_back(var_0) {
  if(var_0 == 0) {
    level.player scripts\engine\sp\utility::play_sound_on_entity("dx_vom_far_break_waterboard_interrogate_150");
    return;
  }

  level.player scripts\engine\sp\utility::play_sound_on_entity("dx_vom_far_break_waterboard_interrogate_240");
}

function vo_break_wboard_passed() {
  scripts\engine\utility::flag_waitopen("barkov_speaking");

  if(level.barkov.waterboardindex == 0) {
    level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_pass_80");
    return;
  }

  level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate2_250");
}

function vo_break_shoved() {
  wait 0.2;
  scripts\engine\sp\utility::smart_player_dialogue(scripts\engine\utility::random(["dx_vom_far_break_waterboard_interrogate_150", "dx_vom_far_break_waterboard_interrogate_240"]));
}

function vo_break_wboard_shove_remark() {
  level.henchman scripts\engine\sp\utility::smart_dialogue("dx_vom_rug1_break_waterboard_walk_30");
  wait 0.5;

  if(!scripts\engine\utility::flag("barkov_speaking")) {
    scripts\engine\utility::flag_set("barkov_speaking");
    level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_walk_40");
    scripts\engine\utility::flag_clear("barkov_speaking");
    return;
  }
}

function vo_break_nag_out_of_cell() {
  level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_walk_20");
}

function vo_break_wboard_all_day_nag(var_0) {
  level.barkov scripts\engine\sp\utility::smart_dialogue("dx_vom_bkv_break_waterboard_interrogate_35");
}

function vo_break_wboard_waterboard_take_breath() {
  if(!isDefined(level.player.breathdeck)) {
    var_0 = ["dx_vom_far_break_waterboard_efforts_70", "dx_vom_far_break_waterboard_interrogate_246", "dx_vom_far_break_waterboard_efforts_80"];
    level.player.breathdeck = scripts\engine\sp\utility::create_deck(var_0);
  }

  level.player.breathdeck scripts\engine\sp\utility::refill_if_empty();

  if(scripts\engine\utility::flag("started_passout_countdown")) {
    scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_break_waterboard_efforts_90");
    return;
  }

  scripts\engine\sp\utility::smart_player_dialogue_interrupt(level.player.breathdeck scripts\engine\sp\utility::deck_draw());
}

function vo_break_wboard_waterboard_choke() {
  if(!isDefined(level.player.chokedeck)) {
    var_0 = ["dx_vom_far_break_waterboard_efforts_40", "dx_vom_far_break_waterboard_efforts_60", "dx_vom_far_break_waterboard_interrogate_248"];
    level.player.chokedeck = scripts\engine\sp\utility::create_deck(var_0);
  }

  level.player.chokedeck scripts\engine\sp\utility::refill_if_empty();

  if(scripts\engine\utility::flag("started_passout_countdown")) {
    scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_break_waterboard_efforts_60");
    return;
  }

  scripts\engine\sp\utility::smart_player_dialogue_interrupt(level.player.chokedeck scripts\engine\sp\utility::deck_draw());
}

function vo_break_wboard_hold_breath_sound_loop() {
  scripts\engine\utility::flag_wait("jerrycan_reached_center");
  play_looping_breath_sound(level.player_rig);
}

function vo_break_wboard_fail_wake1() {
  play_effort_sound(level.player_rig, "dx_vom_far_break_waterboard_interrogate_228");
}

function vo_break_wboard_fail_wake2() {
  play_effort_sound(level.player_rig, "dx_vom_far_break_waterboard_interrogate_250");
}

function vo_break_wboard_fail_wake3() {
  play_effort_sound(level.player_rig, "dx_vom_far_break_waterboard_interrogate_255");
}

function vo_break_spit(var_0) {
  play_effort_sound(var_0);
}

function vo_break_wakeup() {
  wait 0.5;
  thread audio_notify_change_mix();
  play_effort_sound("dx_vom_far_break_intro_wakeup_25");
}

function audio_notify_change_mix() {
  wait 0.05;
  level notify("farahgetupchangeaudio");
}

function vo_break_exit_bed() {
  play_effort_sound("dx_vom_far_break_intro_solitary_05");
}

function vo_break_try_steal_stunstick() {
  wait 0.5;
  level.barkov stopsounds();
  level.stunstickattacker scripts\engine\sp\utility::smart_dialogue("dx_vom_ru2_break_exercise_thirsty_31");
}

function vo_ce_vent_open_fail() {
  wait 0.7;
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cell_escape_spoon_10");
  wait 1.5;
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cell_escape_spoon_20");
}

function vo_ce_pickup_spoon() {
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cell_escape_spoon_40");
}

function vo_ce_made_shiv() {
  wait 3;
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cell_escape_spoon_50");
}

function vo_ce_opened_first_vent() {
  wait 2.7;
  thread scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_cell_escape_spoon_100");
  wait 1.5;
  scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_cell_escape_spoon_90");
}

function vo_ce_pickedup_first_rock() {
  if(!scripts\engine\utility::flag("made_rock_comment")) {
    scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_cell_escape_rocks_10");
    scripts\engine\utility::flag_set("made_rock_comment");
    return;
  }
}

function vo_ce_dig_in_respawner() {
  if(!scripts\engine\utility::flag("made_dig_comment")) {
    scripts\engine\utility::flag_set("made_dig_comment");
    scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cell_escape_rocks_100");
    wait 1;
    vo_ce_pickedup_first_rock();
    return;
  }
}

function vo_ce_enter_cell() {
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cell_escape_spoon_110");
}

function vo_ce_rock_hints() {
  level endon("hit_celldoor_button");
  level endon("hit_near_celldoor_button");
  wait 30;
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cellblock_escape_chair_10");
  wait 20;
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cell_escape_rocks_20");
  scripts\engine\utility::flag_set("done_rock_hint");
  scripts\engine\utility::flag_wait("has_seen_button");
  wait 30;

  if(!scripts\engine\utility::flag("threw_noisemaker")) {
    scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cell_escape_rocks_40");
    wait 20;
  }

  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cell_escape_rocks_50");
  wait 15;
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cell_escape_rocks_60");
}

function vo_ce_button_hint() {
  level endon("hit_celldoor_button");
  level endon("hit_near_celldoor_button");
  scripts\engine\utility::flag_wait("done_rock_hint");
  wait 5;
  thread vo_ce_outside_cell_hint();
  var_0 = getEnt("look_at_button_check", "targetname");
  var_1 = getEnt("cell_door_button", "targetname");
  var_2 = 1;
  var_3 = cos(30);

  while(var_2) {
    if(level.player istouching(var_0)) {
      if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_1.origin, var_3)) {
        var_2 = 0;
      }
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("has_seen_button");
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cell_escape_rocks_30");
}

function vo_ce_outside_cell_hint() {
  level endon("hit_celldoor_button");
  level endon("looking_at_button");
  level endon("hit_near_celldoor_button");
  wait 30;
  var_0 = getEnt("look_at_button_check", "targetname");

  while(ispointinvolume(level.player.origin, var_0)) {
    waitframe();
  }

  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cell_escape_rocks_22");
  wait 5;
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cell_escape_rocks_24");
}

function vo_ce_check_rock_near_button() {
  level endon("hit_celldoor_button");
  var_0 = 0;

  for(var_1 = 0;; var_1 = 1) {
    level.player waittill("noisemaker_thrown", var_2);
    thread vo_ce_check_rock_in_volume();
    var_3 = level.player scripts\engine\utility::waittill_any_return("noisemaker_in_volume", "noisemaker_settled");

    if(var_3 == "noisemaker_in_volume") {
      scripts\engine\utility::flag_set("hit_near_celldoor_button");
      wait 1;

      if(!scripts\engine\utility::flag("hit_celldoor_button")) {
        thread vo_ce_nearly_hit_button(level);
        var_0++;
      }

      continue;
    }

    if(scripts\engine\utility::flag("has_seen_button") && !var_1) {
      scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_cell_escape_rocks_80");
    }
  }
}

function vo_ce_check_rock_in_volume() {
  level.player endon("noisemaker_settled");
  var_0 = getEnt("check_rock_near_button", "targetname");
  var_1 = 1;

  while(var_1) {
    if(isDefined(self)) {
      if(ispointinvolume(self.origin, var_0)) {
        level.player notify("noisemaker_in_volume");
        var_1 = 0;
      }
    } else {
      var_1 = 0;
    }

    waitframe();
  }
}

function vo_ce_nearly_hit_button(var_0) {
  switch (var_0) {
    case 0:
      scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_cell_escape_rocks_70");
      break;
    case 1:
      scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_cell_escape_rocks_72");
      break;
    default:
      scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_cell_escape_rocks_74");
      break;
  }
}

function vo_cb_check_see_chair() {
  if(scripts\engine\utility::flag("found_chair")) {
    return;
  }

  level endon("found_chair");
  var_0 = ["dx_vom_far_cellblock_escape_chair_12", "dx_vom_far_cellblock_escape_chair_13", "dx_vom_far_cellblock_escape_chair_14"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  vo_cb_wait_see_chair();

  for(;;) {
    wait randomfloatrange(14, 26);
    vo_cb_wait_see_chair();
    wait randomfloatrange(0.3, 0.8);
    level.last_chair_nag_time = gettime();
    scripts\engine\sp\utility::smart_player_dialogue(var_1 scripts\engine\sp\utility::deck_draw());
  }
}

function vo_cb_wait_see_chair(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_0 = level.cellchair.origin + (0, 0, 30);

  while(!var_1 || !var_2) {
    var_3 = cos(getdvarint("MRNKTKLLKP") / 1.65);
    var_1 = level.player scripts\engine\math::point_in_fov(var_0, var_3, 1);
    var_2 = sighttracepassed(level.player getEye(), var_0, 0, undefined);
    waitframe();
  }
}

function vo_ce_hit_button() {
  wait 1;
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cell_escape_rocks_110");
}

function vo_cb_window_view(var_0) {
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_ru1_cellblock_escape_chair_30");
}

function vo_cb_looking_at_stairs() {
  level endon("finished_drain_room");
  var_0 = 1;
  var_1 = cos(30);

  while(var_0) {
    scripts\engine\utility::flag_wait("looking_at_stairs");

    if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), scripts\engine\utility::getStruct("stair_look_target", "targetname").origin, var_1)) {
      wait 0.25;

      if(scripts\engine\utility::flag("looking_at_stairs") && scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), scripts\engine\utility::getStruct("stair_look_target", "targetname").origin, var_1)) {
        var_0 = 0;
      }
    }

    waitframe();
  }

  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cellblock_escape_chair_11");
}

function vo_cb_look_at_drain() {
  level endon("finished_drain_room");
  var_0 = scripts\engine\utility::getStruct("drain_lookat", "targetname");

  while(!scripts\engine\utility::flag("has_calledout_drain_room")) {
    scripts\engine\utility::flag_wait("at_drain_fence");

    if(!scripts\engine\utility::flag("player_speaking") && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin, 0.996195)) {
      scripts\engine\utility::flag_set("player_speaking");
      scripts\engine\utility::flag_set("has_calledout_drain_room");
      scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cellblock_escape_chair_90");

      if(!scripts\engine\utility::flag("played_fenced_area_vo")) {
        scripts\engine\utility::flag_set("played_fenced_area_vo");
        wait 0.5;
        scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cellblock_escape_chair_70");
      }

      scripts\engine\utility::flag_clear("player_speaking");
    }

    waitframe();
  }
}

function vo_cb_linger_no_chair() {
  level endon("end_linger_vo");
  scripts\engine\utility::flag_wait("found_chair");
  wait 30;
  scripts\engine\utility::flag_waitopen("player_speaking");
  scripts\engine\utility::flag_set("player_speaking");
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cellblock_escape_chair_50");
  scripts\engine\utility::flag_clear("player_speaking");
  wait 30;
  scripts\engine\utility::flag_waitopen("player_speaking");
  scripts\engine\utility::flag_set("player_speaking");
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cellblock_escape_chair_40");
  scripts\engine\utility::flag_clear("player_speaking");
  wait 30;
  scripts\engine\utility::flag_waitopen("player_speaking");
  scripts\engine\utility::flag_set("player_speaking");
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cellblock_escape_chair_140");
  scripts\engine\utility::flag_clear("player_speaking");
  wait 60;
  scripts\engine\utility::flag_wait("looking_at_drain_room");
  scripts\engine\utility::flag_waitopen("player_speaking");
  scripts\engine\utility::flag_set("player_speaking");
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cellblock_escape_chair_110");
  scripts\engine\utility::flag_clear("player_speaking");
}

function vo_cb_door_locked() {
  wait 1;
  scripts\engine\utility::flag_waitopen("player_speaking");
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_basement_stealth_grate_42");

  if(!scripts\engine\utility::flag("played_fenced_area_vo")) {
    scripts\engine\utility::flag_set("player_speaking");
    scripts\engine\utility::flag_set("played_fenced_area_vo");
    wait 0.5;
    scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cellblock_escape_chair_70");
    scripts\engine\utility::flag_clear("player_speaking");
    return;
  }
}

function vo_cb_chair_carry(var_0) {
  if(var_0 == 1 && (!isDefined(level.last_chair_nag_time) || scripts\engine\utility::time_has_passed(level.last_chair_nag_time, 5))) {
    scripts\engine\utility::flag_waitopen("player_speaking");
    scripts\engine\utility::flag_set("player_speaking");
    scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cellblock_escape_chair_60");
    scripts\engine\utility::flag_clear("player_speaking");
    return;
  }

  if(var_0 > 3) {
    if(scripts\engine\utility::flag("has_calledout_drain_room") && !scripts\engine\utility::flag("has_calledout_drain_room_pickup")) {
      scripts\engine\utility::flag_set("player_speaking");
      scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cellblock_escape_chair_120");
      scripts\engine\utility::flag_clear("player_speaking");
      scripts\engine\utility::flag_set("has_calledout_drain_room_pickup");
      return;
    }

    return;
  }
}

function vo_cb_trying_to_climb_window() {
  level endon("used_vent");
  var_0 = cos(20);
  var_1 = scripts\engine\utility::getStruct(self.target, "targetname").origin;
  level.lastusedwindowalias = "";
  var_2 = level.cellchair.origin[2] + 20;

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      if(scripts\engine\utility::flag("on_chair") && level.player.origin[2] >= var_2 && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_1, var_0)) {
        if(level.lastusedwindowalias == "" || level.lastusedwindowalias == "dx_vom_far_cellblock_escape_chair_160") {
          scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cellblock_escape_chair_150");
          level.lastusedwindowalias = "dx_vom_far_cellblock_escape_chair_150";
        } else {
          scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cellblock_escape_chair_160");
          level.lastusedwindowalias = "dx_vom_far_cellblock_escape_chair_160";
        }

        wait 20;
      }

      waitframe();
    }

    waitframe();
  }
}

function vo_bs_guards_enter() {
  level.player setsoundsubmix("sp_npc_steps_up", 3, 1);
  level.guard1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cg1_cellblock_escape_chair_170");
  wait randomfloatrange(0.15, 0.25);
  level.guard2 scripts\engine\sp\utility::smart_dialogue("dx_vom_cg2_cellblock_escape_chair_180");
  wait 1.5;

  if(length(level.player getvelocity()) > 10) {
    level.guard1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cg1_cellblock_escape_chair_190");
    wait randomfloatrange(0.25, 0.35);
    level.guard2 scripts\engine\sp\utility::smart_dialogue("dx_vom_cg2_cellblock_escape_chair_200");
    wait 0.9;
    level.guard1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cg1_cellblock_escape_chair_202");
    var_0 = !istrue(vo_bs_wait_reach_grate_or_timeout(3));

    if(var_0 || length(level.player getvelocity()) < 10) {
      wait randomfloatrange(0.15, 0.25);
      level.guard2 scripts\engine\sp\utility::smart_dialogue("dx_vom_cg2_cellblock_escape_chair_210");
      wait 1;
      level.guard1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cg1_cellblock_escape_chair_220");
    }
  }

  level.player scripts\engine\utility::delaycall(8, &clearsoundsubmix, "sp_npc_steps_up", 8);
}

function vo_bs_wait_reach_grate_or_timeout(var_0) {
  if(scripts\engine\utility::flag("near_grate")) {
    return;
  }

  level endon("near_grate");
  wait var_0;
  return 1;
}

function vo_bs_guards_sounds_alert() {
  if(scripts\engine\utility::flag("spotted_player")) {
    return;
  }

  level endon("spotted_player");
  level.guard1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cg2_cellblock_escape_chair_250");
  vo_bs_guards_discuss_punishment();
  scripts\engine\utility::flag_set("vo_alert_done");
}

function vo_bs_guards_discuss_punishment() {
  if(!isalive(level.guard2) || istrue(level.guard2.in_melee_death)) {
    return;
  }

  level scripts\engine\sp\utility::battlechatter_off();
  wait randomfloatrange(0.15, 0.25);
  level.guard2 scripts\engine\sp\utility::smart_dialogue("dx_vom_cg1_cellblock_escape_chair_260");
  wait randomfloatrange(0.15, 0.25);
  level.guard1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cg2_cellblock_escape_chair_270");

  if(!isalive(level.guard2) || istrue(level.guard2.in_melee_death)) {
    return;
  }

  wait randomfloatrange(0.15, 0.25);
  level.guard2 scripts\engine\sp\utility::smart_dialogue("dx_vom_cg1_cellblock_escape_chair_280");
  wait randomfloatrange(0.15, 0.25);
  level.guard1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cg2_cellblock_escape_chair_290");
  level scripts\engine\sp\utility::battlechatter_on();
  wait 2;
  thread vo_bs_idle_lines();
}

function vo_bs_idle_lines() {
  if(!isalive(level.guard1) || !isalive(level.guard2)) {
    return;
  }

  level endon("stop_vo_bs_idle_lines");
  level endon("stealth_event");
  GscBinSkip4(0x6e, level.guard1);
}

function stop_vo_bs_idle() {
  scripts\engine\utility::waittill_any("damage", "death", "start_context_melee");
  level notify("stop_vo_bs_idle_lines");
}

function vo_bs_callout_to_guard_2() {
  level endon("spotted_player");
  self endon("death");
  level scripts\engine\sp\utility::battlechatter_off();
  level.guard1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cg1_basement_stealth_combat_320");
  wait 3;
  level.guard1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cg1_basement_stealth_combat_330");
  wait 2;
  level.guard1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cg1_basement_stealth_combat_340");
  wait 2;
  level.guard1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cg1_basement_stealth_combat_350");
  wait 1;
  level.guard1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cg1_basement_stealth_combat_360");
  level scripts\engine\sp\utility::battlechatter_on();

  if(!scripts\engine\utility::flag("reached_upstairs")) {
    thread vo_bs_radio_convo();
    return;
  }
}

function vo_bs_radio_convo() {
  level endon("reached_upstairs");
  scripts\engine\utility::flag_set("started_bs_radio_conversation");
  wait 2;
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "dx_vom_cg3_basement_stealth_combat_210");
}

function vo_bs_spotted() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "dx_vom_cg1_basement_stealth_guards_10");
}

function vo_bs_stab_guard() {
  if(self.script_noteworthy != "basement_guard_2") {
    return;
  }

  self waittill("start_context_melee");
  wait 1;
  thread scripts\sp\maps\captive\captive_util::say("dx_vom_cg2_basement_stealth_guards_470", 1);
}

function vo_bs_climbing_stairs() {
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_factory_floor_jailbreak_10");
}

function vo_ff_guards_at_door() {}

function vo_ff_exit_cellblock() {
  level.player endon("death");
  level.player scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_far_factory_floor_exit_10");
  level.player scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_far_factory_floor_exit_20");
  level.ayah thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_ayah_factory_floor_exit_90");
  level.darine thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_drn_factory_floor_exit_110");
  level.ghalia thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_gha_factory_floor_exit_112");
}

function vo_ff_weaponlocker_nag() {
  level.darine scripts\engine\sp\utility::smart_dialogue("dx_vom_drn_factory_floor_locker_92");
}

function vo_ff_ambush() {
  wait 0.6;
  level.darine scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_drn_factory_floor_locker_205");
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_factory_floor_locker_210");
}

function vo_ff_combat() {
  level.player endon("death");
  level endon("");

  if(!scripts\engine\utility::flag("reached_exterior_start")) {
    level scripts\engine\utility::waittill_either("ai_killed", "reached_exterior_start");
  }

  scripts\sp\maps\captive\captive_util::wait_combat_cooldown(0.4, 1.5);

  if(isalive(level.darine)) {
    level.darine scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_drn_factory_floor_combat_10");

    if(!scripts\engine\utility::flag("reached_exterior_start")) {
      level scripts\engine\utility::waittill_either("ai_killed", "reached_exterior_start");
    }

    scripts\sp\maps\captive\captive_util::wait_combat_cooldown(0.4, 1.5);
  }

  if(isalive(level.darine)) {
    level.ayah scripts\engine\sp\utility::smart_dialogue("dx_vom_ayah_factory_floor_combat_20");

    if(!scripts\engine\utility::flag("reached_exterior_start")) {
      level scripts\engine\utility::waittill_either("ai_killed", "reached_exterior_start");
    }

    scripts\sp\maps\captive\captive_util::wait_combat_cooldown(0.4, 1.5);
  }

  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_factory_floor_combat_30");

  if(isalive(level.ghalia)) {
    level.ghalia scripts\engine\sp\utility::smart_dialogue("dx_vom_gha_factory_floor_combat_50");
  }

  if(isalive(level.darine)) {
    level.darine scripts\engine\sp\utility::smart_dialogue("dx_vom_drn_factory_floor_combat_40");
  }

  if(isalive(level.nadia)) {
    level.nadia scripts\engine\sp\utility::smart_dialogue("dx_vom_nad_factory_floor_combat_60");
    return;
  }
}

function vo_ex_barkov_escapes() {
  level.player endon("death");
  wait 3;
  level.ayah thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_ayah_factory_floor_helo_10");
  level.player thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_far_exterior_fight_helo_20");
  level.darine thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_drn_factory_floor_helo_30");
  level.player thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_far_factory_floor_helo_40");
  level.player thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_far_factory_floor_helo_80");
  thread vo_ex_pa_russian_announcements();
}

function vo_ex_pa_russian_announcements() {
  var_0 = scripts\engine\utility::getStructArray("pa_loudspeaker", "targetname");
  wait 2;

  foreach(var_2 in var_0) {
    scripts\engine\utility::play_sound_in_space("dx_vom_rcom_cell_escape_pa_10", var_2.origin);
  }

  wait 5;

  foreach(var_2 in var_0) {
    scripts\engine\utility::play_sound_in_space("dx_vom_rcom_cell_escape_pa_20", var_2.origin);
  }

  wait 5;

  foreach(var_2 in var_0) {
    scripts\engine\utility::play_sound_in_space("dx_vom_rcom_cell_escape_pa_30", var_2.origin);
  }

  wait 3;

  foreach(var_2 in var_0) {
    scripts\engine\utility::play_sound_in_space("dx_vom_rcom_cell_escape_pa_40", var_2.origin);
  }
}

function vo_ex_spot_sniper() {
  level.player endon("death");
  level.ayah thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_ayah_exterior_fight_combat_10");
  level.darine thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_drn_exterior_fight_combat_12");
  level.player thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_far_exterior_fight_combat_20");

  if(isalive(level.ayah)) {
    level.ayah thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_ayah_exterior_fight_combat_30");
  }

  if(isalive(level.ghalia)) {
    level.ghalia thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_gha_exterior_fight_combat_40");
  }

  if(isalive(level.nadia)) {
    level.nadia thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_nad_exterior_fight_combat_50");
  }

  scripts\sp\maps\captive\captive_util::wait_for_break_in_chatter();
  scripts\engine\utility::flag_set("finished_sniper_callout");
}

function vo_ex_spotted_by_sniper() {
  level.player endon("death");

  if(!isDefined(level.fakesniper)) {
    level waittill("scripted_sniper_spawned");
  }

  level endon("sniper_killed");
  level endon("start_meet_sas_scene");
  var_0 = [];
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, [level.darine, "dx_vom_drn_exterior_fight_combat_60"]);
}

function vo_ex_ally_deaths() {
  level.player endon("death");
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "dx_vom_far_factory_floor_death_60");
}

function vo_ex_reinforcements() {
  level.player endon("death");
  level endon("start_meet_sas_scene");
  scripts\engine\utility::flag_wait("finished_sniper_callout");
  scripts\sp\maps\captive\captive_util::wait_combat_cooldown(0.4, 1.2);
  level.darine scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_drn_exterior_fight_combat_230");
  scripts\sp\maps\captive\captive_util::wait_combat_cooldown(0.4, 1.2);
  level.player scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_far_exterior_fight_combat_240");
  scripts\engine\utility::flag_wait("spawn_construction_reinforcements");
  scripts\sp\maps\captive\captive_util::wait_combat_cooldown(0.4, 1.2);
  level.darine scripts\engine\sp\utility::smart_dialogue("dx_vom_drn_exterior_fight_combat_200");
  scripts\sp\maps\captive\captive_util::wait_combat_cooldown(0.4, 1.2);
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_exterior_fight_combat_210");
  scripts\sp\maps\captive\captive_util::wait_combat_cooldown(0.4, 1.2);
  scripts\sp\maps\captive\captive_util::wait_enemy_deaths_or_clear(3);
  level.ayah scripts\engine\sp\utility::smart_dialogue("dx_vom_ayah_exterior_fight_combat_220");
  scripts\sp\maps\captive\captive_util::wait_combat_cooldown(0.4, 1.2);

  if(isalive(level.ghalia)) {
    level.ghalia scripts\engine\sp\utility::smart_dialogue("dx_vom_gha_exterior_fight_combat_250");
  }

  if(isalive(level.nadia)) {
    level.nadia scripts\engine\sp\utility::smart_dialogue("dx_vom_nad_exterior_fight_combat_260");
    return;
  }
}

function vo_ex_rpg_guy_fired() {
  scripts\engine\utility::flag_wait("sniper_intro_done");
  self endon("death");
  level endon("start_meet_sas_scene");
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, [level.ayah, "dx_vom_ayah_exterior_fight_combat_150"]);
}

function vo_ex_killed_sniper(var_0) {
  scripts\sp\maps\captive\captive_util::wait_combat_cooldown(0.4, 1);

  if(!isDefined(var_0)) {
    level.darine thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_drn_exterior_fight_warehouse_90");
    level.ayah thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_ayah_exterior_fight_warehouse_100");
    return;
  }

  if(scripts\engine\utility::is_equal(var_0, level.ayah)) {
    level.ayah thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_ayah_exterior_fight_warehouse_70");
    level.darine thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_drn_exterior_fight_warehouse_80");
    return;
  }

  level.ayah thread scripts\sp\maps\captive\captive_util::say_as_chatter("dx_vom_ayah_exterior_fight_combat_190");
}

function vo_ex_all_dead_warehouse_nag() {
  if(scripts\engine\utility::flag("reached_building")) {
    return;
  }

  level endon("reached_building");
  var_0 = ["dx_vom_ayah_exterior_fight_warehouse_10", "dx_vom_drn_exterior_fight_warehouse_20", "dx_vom_ayah_exterior_fight_warehouse_30"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  wait 10;

  for(;;) {
    while(getaiarray("axis").size > 0) {
      level waittill("ai_killed");
    }

    wait randomfloatrange(5, 12);

    if(getaiarray("axis").size > 0) {
      continue;
    }

    var_2 = var_1 scripts\engine\sp\utility::deck_draw();

    if(strtok(var_2, "_")[2] == "drn") {
      level.darine scripts\sp\maps\captive\captive_util::say_as_chatter(var_2);
      continue;
    }

    level.ayah scripts\sp\maps\captive\captive_util::say_as_chatter(var_2);
  }
}

function vo_ms_sniper_alive() {
  level.ayah scripts\engine\sp\utility::smart_dialogue("dx_vom_ayah_exterior_fight_warehouse_40");
  level.darine scripts\engine\sp\utility::smart_dialogue("dx_vom_drn_exterior_fight_warehouse_50");
  level.ayah scripts\engine\sp\utility::smart_dialogue("dx_vom_ayah_exterior_fight_warehouse_60");
}

function vo_ms_nag_sas_door() {
  level endon("start_meet_sas_scene");
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "dx_vom_ayah_exterior_fight_storage_10");
}

function vo_bu_two_enemies() {
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_meet_sas_reveal_110");
  scripts\engine\utility::waittill_any_ents(level.sas1, "enemy", level.sas2, "enemy", level.price, "enemy", level, "ai_killed");
  level.sas1 scripts\engine\sp\utility::smart_dialogue("dx_vom_sas1_bunker_interior_30");
  wait 0.3;

  if(getaiarray("axis").size > 1) {
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_bunker_interior_40");
  }

  while(getaiarray("axis").size > 0) {
    level waittill("ai_killed");
  }

  wait 0.5;
  scripts\sp\maps\captive\captive_util::wait_combat_cooldown(0.4, 1.2);
  level.sas1 scripts\engine\sp\utility::smart_dialogue("dx_vom_sas1_bunker_interior_50");
  scripts\engine\utility::flag_wait("reached_gas_factory_end");
  wait 0.3;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_bunker_interior_60");
  thread vo_bu_spot_pow();
}

function vo_bu_spot_pow() {
  level endon("gas_lab_open");
  var_0 = vo_bu_spot_hadir(4);
  scripts\engine\utility::flag_wait("price_in_view_room");
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_bunker_interior_10");
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_bunker_interior_20");
  scripts\engine\utility::flag_wait("started_breach");
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_bunker_pows_110");
  scripts\engine\utility::flag_set("done_breach_callout");
  scripts\engine\utility::flag_wait("has_entered_control_room");
  wait 3;
  level.ayah scripts\engine\sp\utility::smart_dialogue("dx_vom_ayah_bunker_pows_60");

  if(isalive(level.ghalia)) {
    level.ghalia scripts\engine\sp\utility::smart_dialogue("dx_vom_gha_bunker_pows_70");
  }

  if(isalive(level.azadeh)) {
    level.azadeh scripts\engine\sp\utility::smart_dialogue("dx_vom_aza_bunker_pows_80");
  }

  level.darine scripts\engine\sp\utility::smart_dialogue("dx_vom_drn_bunker_pows_90");

  if(isalive(level.nadia)) {
    level.nadia scripts\engine\sp\utility::smart_dialogue("dx_vom_nad_bunker_pows_100");
    return;
  }
}

function vo_bu_spot_hadir(var_0) {
  while(!isDefined(level.hadir)) {
    waitframe();
  }

  var_1 = scripts\sp\maps\captive\captive_util::wait_lookat_or_timeout(level.hadir, 180, var_0, "j_head", 0.5, 350);

  if(istrue(var_1)) {
    level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_bunker_pows_50");
    return true;
  }

  return false;
}

function vo_bu_step_back() {
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_bunker_doors_30");
}

function vo_bu_post_breach() {
  level endon("gas_lab_open");
  level endon("rescue_failed");
  vo_bu_farah_screams();
  scripts\engine\utility::flag_wait("done_bu_breach_vo");
  level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_bunker_gas_112");

  if(!scripts\engine\utility::flag("did_hadir_callout")) {
    level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_bunker_gas_111");
  }

  wait 1;
  level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_bunker_gas_113");

  if(!scripts\engine\utility::flag("started_pull_sequence")) {
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_bunker_gas_120");
  }

  wait 1;
  level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_bunker_gas_114");
}

function vo_bu_smoke_fail() {
  level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_bunker_doors_120");
}

function vo_bu_farah_screams() {
  level endon("reached_gas_lab_access");
  scripts\sp\maps\captive\captive_util::wait_lookat(level.hadir, 180, "j_head", 0.1, 200);
  scripts\engine\utility::flag_set("did_hadir_callout");
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_bunker_gas_111");
}

function vo_bu_try_open_gas_lab(var_0) {
  switch (var_0) {
    case 1:
      level.price stopsounds();
      waitframe();
      level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_bunker_rescue_40");
      break;
    case 2:
      level.price stopsounds();
      waitframe();
      level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_bunker_rescue_50");
      break;
    default:
      break;
  }
}

function vo_bu_try_open_gas_door_nag(var_0) {
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_bunker_rescue_60");
}

function vo_walla_expl_react() {
  wait 0.2;
  thread scripts\engine\utility::play_sound_in_space("cap_walla_russ_expl_reaction", (6288, 1017, -98));
}

function vo_walla_guards_alert() {
  var_0 = spawn("script_origin", (6218, 1380, -36));
  var_1 = spawn("script_origin", (6261, 586, 38));
  var_2 = spawn("script_origin", (5714, 1402, -45));
  var_3 = spawn("script_origin", (6616, 991, 40));
  var_4 = spawn("script_origin", (5390, 1093, 50));
  var_5 = [];
  GscBinSkip0(0x2e, var_5.size, "cap_walla_russ_alert_01");
}

function vo_walla_play_guard_alert() {
  level.player endon("death");
  level endon("vo_stop_guard_walla");
  var_0 = undefined;
  wait randomintrange(1, 6);

  for(;;) {
    if(level.walla_deck scripts\engine\sp\utility::deck_is_empty()) {
      level.walla_deck scripts\sp\maps\captive\captive_util::array_deck_shuffle();
    }

    var_0 = level.walla_deck scripts\engine\sp\utility::deck_draw();
    self playSound(var_0, "sounddone");
    self waittill("sounddone");
    wait randomintrange(5, 12);
  }
}

function mus_barkov_intro() {
  wait 7;
  setmusicstate("mx_cap_barkov_infil");
}

function mus_waterboard_int() {
  scripts\engine\utility::flag_wait("exited_cell");
  wait 0.1;
  setmusicstate("mx_cap_waterboard");
}

function mus_barkov_shoot_prisoner() {
  wait 0.2;
  setmusicstate("mx_cap_hostage");
}

function mus_barkov_spare_prisoner() {
  setmusicstate("mx_cap_hostage_spare");
}

function mus_barkov_intel() {
  setmusicstate("mx_cap_intel");
  level waittill("start_choking");
  setmusicstate("mx_cap_escapecell");
}

function mus_far_open_vent() {
  scripts\engine\utility::flag_wait("reached_second_cell");
  setmusicstate("");
}

function mus_far_sewer_crawl() {
  scripts\engine\utility::flag_wait("used_vent");
  setmusicstate("mx_cap_sewer");
  scripts\engine\utility::flag_wait("opened_grate");
  setmusicstate("");
}

function mus_far_sister_infil() {
  wait 0.1;
  setmusicstate("mx_cap_sister_infil");
}

function mus_far_free_sisters() {
  scripts\engine\utility::flag_wait("pressed_cell_door_button");
  wait 1.5;
  setmusicstate("mx_cap_sister_save");
}

function mus_factory_exit_battle() {
  wait 1;
  setmusicstate("mx_cap_escape_battle");
}

function mus_exterior_battle_stop() {
  scripts\engine\utility::flag_wait("approaching_building");
  setmusicstate("");
}

function mus_meet_sas() {
  scripts\engine\utility::flag_wait("at_secure_door_threshold");
  wait 0.1;
  setmusicstate("mx_cap_price_save");
}

function mus_factory_rescue() {
  scripts\engine\utility::flag_wait("reached_gas_factory_start");
  wait 2;
  setmusicstate("mx_cap_urgent_travel");
  scripts\engine\utility::flag_wait("started_pull_sequence");
  setmusicstate("");
}

function mus_save_hadir() {
  wait 4;
  setmusicstate("mx_cap_hadir_saved");
}