/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\disco_mpq.gsc
**************************************************/

skq() {
  init_skq_flags();
  scripts\engine\utility::flag_wait("interactions_initialized");
  thread phase_1();
  thread phase_2();
  thread phase_3();
}

init_skq_flags() {
  scripts\engine\utility::flag_init("eye_picked");
  scripts\engine\utility::flag_init("heart_picked");
  scripts\engine\utility::flag_init("brain_picked");
  scripts\engine\utility::flag_init("skq_phase_1");
  scripts\engine\utility::flag_init("skq_phase_3");
  scripts\engine\utility::flag_init("disco_roof power_on");
  scripts\engine\utility::flag_init("skq_p2t1_0");
  scripts\engine\utility::flag_init("skq_p2t1_1");
  scripts\engine\utility::flag_init("skq_p2t1_2");
  scripts\engine\utility::flag_init("skq_p2t1_3");
  scripts\engine\utility::flag_init("skq_p2t1_4");
  scripts\engine\utility::flag_init("skq_p2t1_5");
  scripts\engine\utility::flag_init("skq_p2t2_0");
  scripts\engine\utility::flag_init("skq_p2t2_1");
  scripts\engine\utility::flag_init("skq_p2t2_2");
  scripts\engine\utility::flag_init("skq_p2t2_3");
  scripts\engine\utility::flag_init("skq_p2t2_4");
  scripts\engine\utility::flag_init("skq_p2t2_5");
  scripts\engine\utility::flag_init("skq_p2t2_6");
  scripts\engine\utility::flag_init("skq_p2t2_7");
  scripts\engine\utility::flag_init("skq_p2t3_0");
  scripts\engine\utility::flag_init("skq_p2t3_1");
  scripts\engine\utility::flag_init("skq_p2t3_2");
  scripts\engine\utility::flag_init("skq_p2t3_3");
  scripts\engine\utility::flag_init("skq_p2t3_4");
  scripts\engine\utility::flag_init("skq_p2t3_5");
  scripts\engine\utility::flag_init("skq_p2t3_6");
  scripts\engine\utility::flag_init("morse_code_heard");
  scripts\engine\utility::flag_init("turnstile_done");
  scripts\engine\utility::flag_init("turnstyle_glyph_hit");
  scripts\engine\utility::flag_init("reel_zoms_beaten");
  scripts\engine\utility::flag_init("cleanup_reel_assets");
  scripts\engine\utility::flag_init("fever_started");
  scripts\engine\utility::flag_init("savage_treasure");
  scripts\engine\utility::flag_init("first_cipher_seen");
  scripts\engine\utility::flag_init("second_cipher_seen");
  scripts\engine\utility::flag_init("third_cipher_seen");
  scripts\engine\utility::flag_init("correct_poster_got");
  scripts\engine\utility::flag_init("skq_phase_1dbg");
  scripts\engine\utility::flag_init("skq_phase_3dbg");
  scripts\engine\utility::flag_init("skq_p2t1_0dbg");
  scripts\engine\utility::flag_init("skq_p2t1_1dbg");
  scripts\engine\utility::flag_init("skq_p2t1_2dbg");
  scripts\engine\utility::flag_init("skq_p2t1_3dbg");
  scripts\engine\utility::flag_init("skq_p2t1_4dbg");
  scripts\engine\utility::flag_init("skq_p2t1_5dbg");
  scripts\engine\utility::flag_init("skq_p2t2_0dbg");
  scripts\engine\utility::flag_init("skq_p2t2_1dbg");
  scripts\engine\utility::flag_init("skq_p2t2_2dbg");
  scripts\engine\utility::flag_init("skq_p2t2_3dbg");
  scripts\engine\utility::flag_init("skq_p2t2_4dbg");
  scripts\engine\utility::flag_init("skq_p2t2_5dbg");
  scripts\engine\utility::flag_init("skq_p2t2_6dbg");
  scripts\engine\utility::flag_init("skq_p2t2_7dbg");
  scripts\engine\utility::flag_init("skq_p2t3_0dbg");
  scripts\engine\utility::flag_init("skq_p2t3_1dbg");
  scripts\engine\utility::flag_init("skq_p2t3_2dbg");
  scripts\engine\utility::flag_init("skq_p2t3_3dbg");
  scripts\engine\utility::flag_init("skq_p2t3_4dbg");
  scripts\engine\utility::flag_init("skq_p2t3_5dbg");
  scripts\engine\utility::flag_init("skq_p2t3_6dbg");
}

phase_1() {
  var_0 = scripts\engine\utility::flag_wait_any_return("skq_phase_1", "skq_phase_1dbg");
  if(isDefined(level.spoke_to_pam_first_after_wave_five) && !scripts\engine\utility::istrue(level.played_first_pam_dialogue)) {
    switch (level.spoke_to_pam_first_after_wave_five.vo_prefix) {
      case "p1_":
        level.spoke_to_pam_first_after_wave_five thread scripts\cp\cp_vo::try_to_play_vo("sally_pam_first_1", "pam_dialogue_vo", "highest", 20, 1);
        break;

      case "p2_":
        level.spoke_to_pam_first_after_wave_five thread scripts\cp\cp_vo::try_to_play_vo("pdex_pam_first_1", "pam_dialogue_vo", "highest", 20, 1);
        break;

      case "p3_":
        level.spoke_to_pam_first_after_wave_five thread scripts\cp\cp_vo::try_to_play_vo("andre_pam_first_1", "pam_dialogue_vo", "highest", 20, 1);
        break;

      case "p4_":
        level.spoke_to_pam_first_after_wave_five thread scripts\cp\cp_vo::try_to_play_vo("aj_pam_first_1", "pam_dialogue_vo", "highest", 20, 1);
        break;

      case "p5_":
        level.spoke_to_pam_first_after_wave_five thread scripts\cp\cp_vo::try_to_play_vo("pam_generic_response", "pam_dialogue_vo", "highest", 20, 1);
        break;

      default:
        break;
    }

    level.played_first_pam_dialogue = 1;
  } else {
    foreach(var_2 in level.players) {
      var_3 = ["pam_generic_response", "pam_return_nothing"];
      var_2 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_3), "pam_dialogue_vo", "highest", 100, 1);
    }
  }

  if(isDefined(level.trainer)) {
    level.trainer notify("play_idle");
  }

  foreach(var_6 in level.all_animal_structs) {
    thread scripts\cp\cp_interaction::add_to_current_interaction_list(var_6);
  }

  scripts\cp\maps\cp_disco\kung_fu_mode::disable_trainer_interactions();
}

phase_2() {
  thread phase_2_task_1();
  thread phase_2_task_2();
  thread phase_2_task_3();
}

phase_2_task_1() {
  thread p2t1_0_receive_quest();
  thread p2t1_1_destroy_cages();
  thread p2t1_2_subway_locker();
  thread p2t1_3_decal_puzzle();
  thread p2t1_4_rat_king_fight();
  thread p2t1_5_complete_task();
}

p2t1_0_receive_quest() {
  var_0 = scripts\engine\utility::flag_wait_any_return("skq_p2t1_0", "skq_p2t1_0dbg");
  scripts\cp\maps\cp_disco\kung_fu_mode::disable_trainer_interactions();
  foreach(var_2 in level.players) {
    var_2 thread scripts\cp\cp_vo::try_to_play_vo("pam_quest_ratking_eye", "pam_dialogue_vo", "highest", 100, 1);
    if(var_2.vo_prefix == "p5_") {
      var_2 thread play_pam_reaction_vo("pam_quest_ratking_eye", 1, 0, 0);
    }
  }

  scripts\cp\cp_vo::remove_from_nag_vo("pam_quest_return");
  level.trainer notify("play_sit_idle");
  scripts\engine\utility::flag_set("skq_p2t1_1");
}

p2t1_1_destroy_cages() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::flag_wait_any_return("skq_p2t1_1", "skq_p2t1_1dbg");
  var_1 = scripts\engine\utility::getStructArray("mpq_rat_cage", "targetname");
  foreach(var_3 in var_1) {
    var_3 thread monitor_cage_visibility();
  }

  for(;;) {
    var_5 = monitor_cage_destruction();
    if(var_5) {
      break;
    } else {
      reset_cage_puzzle();
    }
  }

  remove_cage_quest();
  if(!isDefined(level.next_cage)) {
    var_1 = scripts\engine\utility::getStructArray("mpq_rat_cage", "targetname");
    var_1 = sortbydistance(var_1, level.players[0].origin);
    level.next_cage = var_1[0];
  }

  var_3 = undefined;
  var_1 = scripts\engine\utility::getStructArray("cage_challenge_ring", "targetname");
  foreach(var_7 in var_1) {
    if(var_7.script_noteworthy == level.next_cage.script_noteworthy) {
      var_3 = var_7;
      break;
    }
  }

  zombie_challenge_ring(15, var_3);
  wait(10);
  var_3 rat_cage_kung_fu_zombies();
  var_9 = spawnfx(level._effect["locker_key"], var_3.origin + (0, 0, 32), anglesToForward(var_3.angles), anglestoup(var_3.angles));
  var_10 = scripts\engine\utility::spawn_tag_origin(var_3.origin + (0, 0, 32), var_3.angles);
  wait(0.2);
  triggerfx(var_9);
  var_10 makeusable(1);
  var_10 setusefov(60);
  var_10 setuserange(50);
  var_10 waittill("trigger", var_11);
  if(isDefined(var_11) && isPlayer(var_11)) {
    var_11 thread scripts\cp\cp_vo::try_to_play_vo("pam_collect_lockerkey", "disco_comment_vo");
    var_11 thread scripts\cp\cp_vo::add_to_nag_vo("missing_item_misc", "disco_comment_vo", 240, 120, 4, 1);
  }

  level scripts\cp\utility::set_quest_icon(14);
  var_10 delete();
  var_9 delete();
  scripts\engine\utility::flag_set("skq_p2t1_2");
}

zombie_challenge_ring(var_0, var_1) {
  level endon("game_ended");
  var_2 = scripts\engine\utility::drop_to_ground(var_1.origin, 30, -100);
  var_3 = spawnfx(level._effect["challenge_ring"], var_2, anglesToForward(var_1.angles));
  wait(1);
  level thread zombie_challenge_ring_sfx(var_2);
  triggerfx(var_3);
  var_4 = var_0;
  while(var_4 > 0) {
    level waittill("zombie_killed", var_5, var_6, var_6, var_7);
    if(distancesquared(var_2, var_5) <= 22500) {
      var_4--;
    }

    wait(0.05);
  }

  level notify("stop_this_challenge_ring_sfx");
  var_3 delete();
}

zombie_challenge_ring_sfx(var_0) {
  level endon("game_ended");
  var_1 = scripts\engine\utility::play_loopsound_in_space("kill_zone_circle_lr_lp", var_0);
  level waittill("stop_this_challenge_ring_sfx");
  wait(0.15);
  var_1 stoploopsound();
  var_1 delete();
}

rat_cage_kung_fu_zombies() {
  level.rat_cage_zoms = 0;
  mpq_spawn_special_wave(level.rat_cage_zoms, 8);
}

remove_cage_quest() {
  var_0 = scripts\engine\utility::getStructArray("mpq_rat_cage", "targetname");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.cage_model)) {
      var_2.cage_model delete();
    }

    if(isDefined(var_2.cage_rat)) {
      if(var_2.cage_rat.model == "tag_origin_templeton") {
        var_2.cage_rat setscriptablepartstate("templeton", 1);
        var_2.cage_rat delete();
        continue;
      }

      var_2.cage_rat delete();
    }
  }

  level notify("cage_win");
}

reset_cage_puzzle() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getStructArray("mpq_rat_cage", "targetname");
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_quest_failure", "rave_announcer_vo", "highest", 70, 0, 0, 1);
  level notify("cage_fail");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.claimed_cage)) {
      var_2.claimed_cage = undefined;
    }

    if(isDefined(var_2.cage_model)) {
      var_2.cage_model delete();
    }

    if(isDefined(var_2.cage_rat)) {
      if(var_2.cage_rat.model == "tag_origin_templeton") {
        var_2.cage_rat setscriptablepartstate("templeton", 1);
        var_2.cage_rat delete();
        continue;
      }

      var_2.cage_rat delete();
    }
  }

  wait(4);
  foreach(var_2 in var_0) {
    var_2 thread monitor_cage_visibility();
  }
}

spawn_rat_cage() {
  level endon("game_ended");
  level endon("cage_fail");
  level endon("cage_win");
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  self.cage_model = spawn("script_model", self.origin);
  self.cage_model.angles = self.angles;
  self.cage_model setModel("cp_disco_rat_cage");
  var_0 = scripts\engine\utility::getstruct(self.target, "targetname");
  self.cage_rat = spawn("script_model", var_0.origin);
  self.cage_rat.angles = var_0.angles;
  self.cage_rat setModel("zmb_rat");
  thread cage_logic();
}

cage_logic() {
  level endon("game_ended");
  self endon("not_visible");
  level endon("cage_fail");
  level endon("cage_win");
  self.cage_model setCanDamage(1);
  for(;;) {
    self.cage_model waittill("damage", var_0, var_1, var_0, var_0, var_0, var_0, var_0, var_0, var_0, var_2);
    if(isDefined(var_2) && issubstr(var_2, "shuriken")) {
      break;
    } else {
      wait(0.2);
    }
  }

  level notify("cage_hit", self, var_1);
}

monitor_cage_destruction() {
  level endon("game_ended");
  level endon("cage_fail");
  level endon("cage_win");
  level waittill("cage_hit", var_0, var_1);
  playsoundatpos(var_0.origin, "ninja_zombie_poof_in");
  playFX(level._effect["rat_cage_poof"], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  var_0 thread send_rat_wandering(var_1);
  while(!isDefined(level.next_cage)) {
    wait(0.1);
  }

  for(var_2 = 0; var_2 < 4; var_2++) {
    level waittill("cage_hit", var_0, var_1);
    playsoundatpos(var_0.origin, "ninja_zombie_poof_in");
    playsoundatpos(var_0.origin, "rat_cage_open");
    playFX(level._effect["rat_cage_poof"], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
    if(var_0 == level.next_cage) {
      var_0 thread send_rat_wandering(var_1);
      continue;
    }

    return 0;
  }

  level waittill("cage_hit", var_0, var_1);
  if(var_0 == level.next_cage) {
    return 1;
  }

  return 0;
}

send_rat_wandering(var_0) {
  level endon("game_ended");
  level endon("cage_fail");
  level endon("cage_win");
  self.claimed_cage = 1;
  self notify("cage_destroyed");
  var_1 = select_next_cage();
  self.cage_model delete();
  var_2 = build_path_network(self.cage_rat, var_1, var_0);
  self.cage_rat thread rat_follow_path(var_2, var_1);
  self.cage_rat playLoopSound("rat_scurry_follow_lp");
}

build_path_network(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("cage_fail");
  level endon("cage_win");
  var_3 = [];
  var_4 = 0;
  var_5 = scripts\engine\utility::getStructArray("mpq_rat_traversal", "targetname");
  var_6 = undefined;
  for(;;) {
    if(var_3.size == 0) {
      var_3 = var_2 findpath(var_0.origin, var_1.origin, 1, 1);
    } else {
      var_7 = var_2 findpath(var_3[var_3.size - 1], var_1.origin, 1, 1);
      var_3 = scripts\engine\utility::array_combine(var_3, var_7);
    }

    if(distance2dsquared(var_1.origin, var_3[var_3.size - 1]) <= 4096) {
      return var_3;
    }

    var_5 = sortbydistance(var_5, var_3[var_3.size - 1]);
    var_8 = [];
    var_9 = undefined;
    foreach(var_11 in var_5) {
      if(var_4 && var_11 == var_5[0] || var_11 == var_6) {
        continue;
      }

      var_8 = var_2 findpath(var_3[var_3.size - 1], var_11.origin, 1, 1);
      if(distance2dsquared(var_11.origin, var_8[var_8.size - 1]) <= 4096) {
        var_9 = var_11;
        break;
      }
    }

    if(!var_4) {
      var_4 = 1;
    }

    if(!isDefined(var_9)) {
      return var_3;
    } else {
      var_6 = var_9;
    }

    var_8 = [];
    var_8[var_8.size] = var_9.origin;
    var_13 = scripts\engine\utility::getstruct(var_9.target, "targetname");
    var_8[var_8.size] = var_13.origin;
    var_3 = scripts\engine\utility::array_combine(var_3, var_8);
    wait(0.05);
  }
}

rat_follow_path(var_0, var_1) {
  level endon("game_ended");
  level endon("cage_fail");
  level endon("cage_win");
  var_2 = 120;
  self setModel("tag_origin_templeton");
  foreach(var_4 in var_0) {
    var_5 = distance(self.origin, var_4);
    var_6 = 16;
    if(var_5 >= var_6 * 2) {
      var_7 = floor(var_5 / var_6);
      for(var_8 = 0; var_8 < var_7; var_8++) {
        var_9 = vectortoangles(var_4 - self.origin);
        var_10 = self.origin + anglesToForward(var_9) * var_6;
        var_10 = scripts\engine\utility::drop_to_ground(var_10, 50, -100);
        var_5 = distance(self.origin, var_10);
        var_11 = var_5 / var_2;
        if(var_11 <= 0.05) {
          var_11 = 0.05;
        }

        var_9 = (var_9[0], var_9[1] + 90, var_9[2]);
        self rotateto(var_9, 0.05);
        self moveto(var_10, var_11);
        wait(var_11);
      }
    }

    var_5 = distance(self.origin, var_4);
    var_12 = self.origin - var_4;
    var_13 = vectortoangles(var_12);
    var_11 = var_5 / var_2;
    if(var_11 <= 0) {
      var_11 = 0.1;
    }

    var_13 = (var_13[0], var_13[1] - 90, var_13[2]);
    self rotateto(var_13, 0.1);
    self moveto(var_4, var_11);
    wait(var_11);
  }

  self stoploopsound("rat_scurry_follow_lp");
  playsoundatpos(self.origin, "rat_cage_close");
  if(self.model == "tag_origin_templeton") {
    self setscriptablepartstate("templeton", 1);
    self delete();
    return;
  }

  self delete();
}

select_next_cage() {
  level endon("game_ended");
  level endon("cage_fail");
  level endon("cage_win");
  var_0 = scripts\engine\utility::getStructArray("mpq_rat_cage", "targetname");
  var_0 = scripts\engine\utility::array_randomize_objects(var_0);
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(!isDefined(var_0[var_1].claimed_cage)) {
      level.next_cage = var_0[var_1];
      return var_0[var_1];
    }
  }
}

monitor_cage_visibility() {
  level endon("game_ended");
  self endon("cage_destroyed");
  level endon("cage_fail");
  level endon("cage_win");
  var_0 = 0;
  foreach(var_2 in level.players) {
    if(distance2dsquared(var_2.origin, self.origin) <= 1048576) {
      playsoundatpos(self.origin, "ninja_zombie_poof_in");
      playFX(level._effect["rat_cage_poof"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
      break;
    }
  }

  for(;;) {
    if(!isDefined(self.cage_model)) {
      var_4 = 0;
      while(!var_4) {
        foreach(var_2 in level.players) {
          if(distance2dsquared(var_2.origin, self.origin) <= 1048576) {
            var_4 = 1;
            break;
          }
        }

        wait(0.1);
      }

      spawn_rat_cage();
    } else {
      var_4 = 0;
      while(!var_4) {
        var_7 = 0;
        foreach(var_2 in level.players) {
          if(distance2dsquared(var_2.origin, self.origin) <= 1048576) {
            var_7 = 1;
            break;
          }
        }

        if(!var_7) {
          var_4 = 1;
        }

        wait(0.2);
      }

      self notify("not_visible");
      self.cage_rat delete();
      self.cage_model delete();
      self.cage_rat = undefined;
      self.cage_model = undefined;
    }

    wait(0.2);
  }
}

p2t1_2_subway_locker() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::flag_wait_any_return("skq_p2t1_2", "skq_p2t1_2dbg");
  var_1 = getent("subway_locker_door", "targetname");
  var_2 = scripts\engine\utility::getstruct(var_1.target, "targetname");
  var_3 = spawn("script_model", var_2.origin);
  var_3 setModel("tag_origin");
  var_3 makeusable();
  var_3 waittill("trigger", var_4);
  if(isDefined(var_4) && isPlayer(var_4)) {
    var_4 thread scripts\cp\cp_vo::try_to_play_vo("pam_open_locker", "disco_comment_vo");
    level thread scripts\cp\cp_vo::remove_from_nag_vo("missing_item_misc");
  }

  var_5 = scripts\engine\utility::getstruct("locker_rortator_mpq", "targetname");
  if(isDefined(var_5)) {
    var_6 = scripts\engine\utility::spawn_tag_origin(var_5.origin, var_5.angles);
    var_1 linkto(var_6);
    playsoundatpos(var_6.origin, "disco_locker_open");
    var_6 rotateyaw(120, 2, 1, 0.5);
    wait(2);
    var_6 delete();
  } else {
    var_1 delete();
  }

  scripts\engine\utility::flag_set("skq_p2t1_3");
}

p2t1_3_decal_puzzle() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::flag_wait_any_return("skq_p2t1_3", "skq_p2t1_3dbg");
  var_1 = getent("graffiti_quest_clip", "targetname");
  var_2 = getent("graffiti_quest_fail_clip", "targetname");
  var_3 = getent("graffiti_quest_clip_alt", "targetname");
  var_1 thread setup_chinese_targ_clip();
  var_2 thread setup_chinese_fail_clip();
  var_3 thread setup_chinese_alt_clip();
  var_4 = "start";
  var_5 = 0;
  while(!var_5) {
    level waittill("update_graffiti", var_6, var_7);
    if(!isDefined(var_7) || !isPlayer(var_7)) {
      continue;
    }

    switch (var_6) {
      case "chinese_symbol_0":
        if(var_4 == "start") {
          var_4 = "chinese_symbol_0";
          var_7 playsoundtoplayer("chinese_symbol_hit", var_7);
        } else {
          failmpqstep();
          var_4 = "start";
        }
        break;

      case "chinese_symbol_1":
        if(var_4 == "chinese_symbol_0") {
          var_4 = "chinese_symbol_1";
          var_7 playsoundtoplayer("chinese_symbol_hit", var_7);
        } else {
          failmpqstep();
          var_4 = "start";
        }
        break;

      case "chinese_symbol_2":
        if(var_4 == "chinese_symbol_1") {
          var_4 = "chinese_symbol_2";
          var_7 playsoundtoplayer("chinese_symbol_hit", var_7);
        } else {
          failmpqstep();
          var_4 = "start";
        }
        break;

      case "chinese_symbol_3":
        if(var_4 == "chinese_symbol_2") {
          var_5 = 1;
          var_7 playsoundtoplayer("chinese_symbol_hit", var_7);
        } else if(var_4 == "chinese_symbol_1") {
          var_4 = "chinese_symbol_3";
          var_7 playsoundtoplayer("chinese_symbol_hit", var_7);
        } else {
          failmpqstep();
          var_4 = "start";
        }
        break;

      case "fail":
        failmpqstep();
        var_4 = "start";
        break;

      case "alt":
        if(var_4 == "chinese_symbol_3") {
          var_5 = 1;
          var_7 playsoundtoplayer("chinese_symbol_hit", var_7);
        } else {
          failmpqstep();
          var_4 = "start";
        }
        break;

      default:
        break;
    }
  }

  level notify("active_word_done");
  thread rk_symbol_handler("rk_symbol_punk_streets", "skq_p2t1_4");
  scripts\cp\utility::deactivatebrushmodel(var_1, 1);
  scripts\cp\utility::deactivatebrushmodel(var_2, 1);
  scripts\cp\utility::deactivatebrushmodel(var_3, 1);
}

setup_chinese_targ_clip() {
  level endon("game_ended");
  level endon("active_word_done");
  var_0 = scripts\engine\utility::getStructArray("graffiti_check_struct", "targetname");
  for(;;) {
    self setCanDamage(1);
    self.health = 9999;
    self waittill("damage", var_1, var_2, var_1, var_3);
    var_0 = sortbydistance(var_0, var_3);
    level notify("update_graffiti", var_0[0].script_noteworthy, var_2);
    self setCanDamage(0);
    wait(0.1);
  }
}

setup_chinese_fail_clip() {
  level endon("game_ended");
  level endon("active_word_done");
  for(;;) {
    self setCanDamage(1);
    self.health = 9999;
    self waittill("damage", var_0, var_1, var_0, var_2);
    level notify("update_graffiti", "fail", var_1);
    self setCanDamage(0);
    wait(0.1);
  }
}

setup_chinese_alt_clip() {
  level endon("game_ended");
  level endon("active_word_done");
  for(;;) {
    self setCanDamage(1);
    self.health = 9999;
    self waittill("damage", var_0, var_1, var_0, var_2);
    level notify("update_graffiti", "alt", var_1);
    self setCanDamage(0);
    wait(0.1);
  }
}

p2t1_4_rat_king_fight() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getstruct("p2t1_4", "script_noteworthy");
  var_1 = scripts\engine\utility::flag_wait_any_return("skq_p2t1_4", "skq_p2t1_4dbg");
  level thread play_rat_king_vo_discussion(1);
  scripts\cp\maps\cp_disco\rat_king::spawn_rat_king(var_0.origin, var_0.angles, 1);
  level thread scripts\cp\maps\cp_disco\cp_disco::enableratkingpas();
  foreach(var_3 in level.players) {
    var_3 playsoundtoplayer("quest_stage_completed_gong_lr", var_3);
  }

  setrkabilities_p2t1_4();
  level watchrkretreat(1000);
  thread createrelicinteraction("eye");
  scripts\cp\maps\cp_disco\kung_fu_mode::increase_trainer_interaction_progression();
  foreach(var_3 in level.players) {
    var_3 thread play_corresponding_vo(1);
  }
}

play_rat_king_vo_discussion(var_0) {
  level endon("game_ended");
  if(!isDefined(var_0)) {
    return;
  }

  if(!scripts\cp\cp_music_and_dialog::can_play_dialogue_system()) {
    return;
  }

  switch (var_0) {
    case 1:
      level thread scripts\cp\cp_vo::try_to_play_vo("ww_ratking_firstspawn", "rave_announcer_vo", "highest", 70, 0, 0, 1);
      wait(scripts\cp\cp_vo::get_sound_length("ww_ratking_firstspawn"));
      play_vo_based_on_player(var_0);
      break;

    case 2:
      wait(scripts\cp\cp_vo::get_sound_length("ww_ratking_spawn"));
      play_vo_based_on_player(var_0);
      break;

    case 3:
      wait(scripts\cp\cp_vo::get_sound_length("ww_ratking_spawn"));
      play_vo_based_on_player(var_0);
      break;
  }
}

play_vo_based_on_player(var_0) {
  level endon("game_ended");
  var_1 = scripts\engine\utility::random(level.players);
  switch (var_1.vo_prefix) {
    case "p1_":
      if(var_0 == 1) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("sally_rat_king_1_1", "rave_dialogue_vo");
      } else if(var_0 == 2) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("sally_rat_king_2_1", "rave_dialogue_vo");
      } else if(var_0 == 3) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("sally_rat_king_3_1", "rave_dialogue_vo");
      }
      break;

    case "p2_":
      if(var_0 == 1) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("pdex_rat_king_1_1", "rave_dialogue_vo");
      } else if(var_0 == 2) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("pdex_rat_king_2_1", "rave_dialogue_vo");
      } else if(var_0 == 3) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("pdex_rat_king_3_1", "rave_dialogue_vo");
      }
      break;

    case "p3_":
      if(var_0 == 1) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("andre_rat_king_1_1", "rave_dialogue_vo");
      } else if(var_0 == 2) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("andre_rat_king_2_1", "rave_dialogue_vo");
      } else if(var_0 == 3) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("andre_rat_king_3_1", "rave_dialogue_vo");
      }
      break;

    case "p4_":
      if(var_0 == 1) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("aj_rat_king_1_1", "rave_dialogue_vo");
      } else if(var_0 == 2) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("aj_rat_king_2_1", "rave_dialogue_vo");
      } else if(var_0 == 3) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("aj_rat_king_3_1", "rave_dialogue_vo");
      }
      break;
  }
}

watchrkretreat(var_0) {
  level endon("game_ended");
  level.rat_king.health = var_0;
  level.rat_king waittill("fake_death");
}

setrkabilities_p2t1_4() {
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("teleport", 1);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("block", 1);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("melee_attack", 1);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("summon", 1);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("staff_stomp", 0);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("staff_projectile", 0);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("shield_attack", 0);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("shield_attack_spot", 0);
  level.rat_king_attack_priorities = [];
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "melee_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "block";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "teleport";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "summon";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_stomp";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_projectile";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack_spot";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "attack_zombies";
  level.rk_tuning_override = ::setrkblocktuning;
  level.rk_solo_tuning_override = ::setrkblocktuning;
  setrkblocktuning(level.agenttunedata["ratking"]);
}

setrkblocktuning(var_0) {
  var_0.need_to_block_damage_threshold = 20;
  var_0.max_time_after_last_damage_to_block = 1000;
  var_0.block_chance = 100;
  var_0.min_block_time = 3000;
  var_0.max_block_time = 7000;
  var_0.quit_block_if_no_damage_time = 2000;
  var_0.min_block_interval = 7000;
  var_0.max_block_interval = 10000;
}

p2t1_5_complete_task() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::flag_wait_any_return("skq_p2t1_5", "skq_p2t1_5dbg");
  scripts\cp\maps\cp_disco\kung_fu_mode::disable_trainer_interactions();
  foreach(var_2 in level.players) {
    var_2 thread scripts\cp\cp_vo::try_to_play_vo("pam_quest_ratking_brain", "pam_dialogue_vo", "highest", 100, 1);
    if(var_2.vo_prefix == "p5_") {
      var_2 thread play_pam_reaction_vo("pam_quest_ratking_brain", 0, 0, 1);
    }
  }

  level.trainer notify("play_sit_idle");
  scripts\engine\utility::flag_set("skq_p2t2_0");
}

phase_2_task_2() {
  thread p2t2_0_symbol_hunt();
  thread p2t2_1_phone_puzzle();
  thread p2t2_3_poster_puzzle();
  thread p2t2_4_kung_fu_fight();
  thread p2t2_5_rat_king_puzzle();
  thread p2t2_6_rat_king_fight();
  thread p2t2_7_complete_task();
}

p2t2_0_symbol_hunt(var_0) {
  level endon("game_ended");
  var_1 = scripts\engine\utility::flag_wait_any_return("skq_p2t2_0", "skq_p2t2_0dbg");
  var_2 = scripts\engine\utility::getStructArray("phonebooth", "script_noteworthy");
  var_3 = scripts\engine\utility::getStructArray("symbol_point", "targetname");
  var_2 = scripts\engine\utility::array_randomize_objects(var_2);
  var_3 = scripts\engine\utility::array_randomize_objects(var_3);
  var_4 = 0;
  var_5 = var_2[var_2.size - 1];
  level.active_hunt_symbol = var_3[var_4];
  for(;;) {
    if(var_2[var_4] == var_5) {
      break;
    } else {
      wait(0.1);
    }

    active_symbol_logic();
    turn_off_phone_light(var_2[var_4]);
    var_4++;
    cleanup_previous_symbol();
    level.active_hunt_symbol = var_3[var_4];
  }

  cleanup_previous_symbol();
  level.phone_puzzle_phone = var_5;
  thread payphone_ringing(level.phone_puzzle_phone);
  scripts\engine\utility::flag_set("skq_p2t2_1");
}

turn_off_phone_light(var_0) {
  var_0.quest_state = 1;
  scripts\cp\maps\cp_disco\phonebooth::update_all_phonebooth_scriptable_states();
}

active_symbol_logic() {
  if(!isDefined(level.active_hunt_symbol)) {
    return;
  }

  level endon("game_ended");
  thread toggle_symbols_for_players();
  var_0 = getent("symbol_point_clip", "targetname");
  var_1 = getent(var_0.target, "targetname");
  var_1 linkto(var_0);
  var_0.origin = level.active_hunt_symbol.origin;
  var_0.angles = level.active_hunt_symbol.angles;
  wait(0.1);
  var_1 setCanDamage(1);
  var_1.health = 9999;
  for(;;) {
    var_1 waittill("damage", var_2, var_3);
    if(scripts\engine\utility::istrue(var_3.wearing_rat_king_eye)) {
      break;
    } else {
      wait(0.1);
    }
  }

  playFX(level._effect["glyph_death"], level.active_hunt_symbol.origin, anglesToForward(level.active_hunt_symbol.angles), anglestoup(level.active_hunt_symbol.angles));
  var_1 setCanDamage(0);
  wait(0.1);
}

cleanup_previous_symbol() {
  if(!isDefined(level.active_hunt_symbol)) {
    return;
  }

  level notify("symbol_updated");
  foreach(var_1 in level.players) {
    if(isDefined(var_1.symbol_hunt_fx)) {
      var_1.symbol_hunt_fx delete();
    }
  }
}

toggle_symbols_for_players() {
  level endon("game_ended");
  level endon("symbol_updated");
  for(;;) {
    foreach(var_1 in level.players) {
      var_1 thread determine_symbol_visibility();
    }

    level scripts\engine\utility::waittill_any("rat_king_eye_activated", "rat_king_eye_deactivated", "connected");
  }
}

determine_symbol_visibility() {
  level endon("game_ended");
  if(!isDefined(level.active_hunt_symbol)) {
    return;
  } else {
    var_0 = level.active_hunt_symbol;
  }

  if(scripts\engine\utility::istrue(self.wearing_rat_king_eye)) {
    if(isDefined(self.symbol_hunt_fx)) {
      return;
    }

    var_1 = spawnfxforclient(level._effect["test_glyph_mpq"], var_0.origin, self, anglesToForward(var_0.angles), anglestoup(var_0.angles));
    self.symbol_hunt_fx = var_1;
    wait(0.05);
    triggerfx(var_1);
    return;
  }

  if(isDefined(self.symbol_hunt_fx)) {
    self.symbol_hunt_fx delete();
  }
}

reset_phone_puzzle() {
  level.phone_puzzle_phone = undefined;
  scripts\engine\utility::flag_clear("morse_code_heard");
  level notify("puzzle_phone_reset");
  scripts\engine\utility::flag_clear("skq_p2t2_1");
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_magicbox_laughter", "rave_announcer_vo", "highest", 70, 0, 0, 1);
  var_0 = scripts\engine\utility::getStructArray("phonebooth", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.quest_state = 0;
  }

  scripts\cp\maps\cp_disco\phonebooth::update_all_phonebooth_scriptable_states();
  init_poster_nums(1);
  thread p2t2_1_phone_puzzle();
  thread p2t2_0_symbol_hunt(1);
  if(!scripts\engine\utility::flag("skq_p2t2_0")) {
    scripts\engine\utility::flag_set("skq_p2t2_0");
  }
}

p2t2_1_phone_puzzle() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::flag_wait_any_return("skq_p2t2_1", "skq_p2t2_1dbg");
  if(!isDefined(level.phone_puzzle_phone)) {
    var_1 = scripts\engine\utility::getStructArray("phonebooth", "script_noteworthy");
    var_1 = scripts\engine\utility::array_randomize_objects(var_1);
    level.phone_puzzle_phone = var_1[0];
    thread payphone_ringing(level.phone_puzzle_phone);
    foreach(var_3 in var_1) {
      if(var_3 != var_1[0]) {
        var_3.quest_state = 1;
        continue;
      }

      var_3.quest_state = 0;
    }

    scripts\cp\maps\cp_disco\phonebooth::update_all_phonebooth_scriptable_states();
  }

  level notify("puzzle_phone_answered");
  scripts\engine\utility::flag_wait("morse_code_heard");
  scripts\engine\utility::flag_set("skq_p2t2_3");
}

play_phone_vo() {
  self endon("disconnect");
  level endon("game_ended");
  wait(0.5);
  thread scripts\cp\cp_vo::try_to_play_vo("pam_answer_phone", "disco_comment_vo");
}

payphone_ringing(var_0) {
  level endon("game_ended");
  var_1 = spawn("script_model", var_0.origin + (0, 0, 50));
  var_1 setModel("tag_origin");
  var_1 playLoopSound("payphone_npc_ring");
  var_0 waittill("phone_answered", var_2);
  level.player_answered_phone = var_2;
  var_1 delete();
}

p2t2_3_poster_puzzle() {
  level endon("game_ended");
  var_0 = init_poster_nums(0);
  var_1 = spawnStruct();
  var_1.setminimap = getent("spotlight_light", "targetname");
  var_1.poster = getent(var_1.setminimap.target, "targetname");
  var_1.fx_struct = scripts\engine\utility::getstruct(var_1.poster.target, "targetname");
  var_1.poster hide();
  thread watch_for_spotlight_power(var_1);
  var_2 = scripts\engine\utility::flag_wait_any_return("skq_p2t2_3", "skq_p2t2_3dbg");
  foreach(var_4 in var_0) {
    if(var_4 == var_0[0]) {
      var_4 thread use_poster_logic(1);
      continue;
    }

    var_4 thread use_poster_logic(0);
  }

  scripts\engine\utility::flag_wait("correct_poster_got");
  foreach(var_7 in level.players) {
    var_7 thread scripts\cp\cp_vo::add_to_nag_vo("missing_item_misc", "disco_comment_vo", 200, 120, 4, 1);
  }

  var_9 = scripts\engine\utility::getStructArray("phonebooth", "script_noteworthy");
  foreach(var_11 in var_9) {
    var_11.quest_state = 0;
  }

  scripts\cp\maps\cp_disco\phonebooth::update_all_phonebooth_scriptable_states();
  scripts\engine\utility::flag_wait("disco_roof power_on");
  var_1.poster makeusable();
  var_1.poster waittill("trigger");
  level thread scripts\cp\cp_vo::remove_from_nag_vo("missing_item_misc");
  var_1.poster setModel("cp_disco_poster_nightmare_summer_torn");
  var_1.poster show();
  var_13 = scripts\engine\utility::getstruct("nade_toss_point", "targetname");
  var_14 = spawn("script_model", var_13.origin);
  var_14 setModel("zmb_rat");
  var_14 setCanDamage(1);
  var_14 waittill("damage", var_15, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18);
  var_14 delete();
  scripts\engine\utility::flag_set("skq_p2t2_4");
}

watch_for_spotlight_power(var_0) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("disco_roof power_on");
  playsoundatpos((-1638, 2988, 1305), "power_buy_powerup_lr");
  playsoundatpos(var_0.setminimap.origin, "power_buy_rooftop_spotlight_turn_on");
  var_1 = var_0.setminimap.model;
  var_0.setminimap setModel("cp_disco_searchlight_swivel_on");
  var_2 = getEntArray("quest_light_fx", "targetname");
  foreach(var_4 in var_2) {
    if(isDefined(var_4)) {
      var_4 setlightintensity(150);
    }
  }

  var_6 = var_0.fx_struct;
  var_7 = spawnfx(level._effect["spotlight_flare"], var_6.origin + anglesToForward(var_6.angles) * -15, anglesToForward(var_6.angles), anglestoup(var_6.angles));
  wait(0.1);
  triggerfx(var_7);
  var_0.poster waittill("trigger");
  foreach(var_4 in var_2) {
    if(isDefined(var_4)) {
      var_4 setlightintensity(0);
    }
  }

  var_6 = scripts\engine\utility::getstruct("spotlight_x_marker", "targetname");
  var_10 = undefined;
  if(isDefined(var_6)) {
    playsoundatpos((-1096, 3287, 1222), "place_flyer_on_spotlight");
    var_10 = spawnfx(level._effect["spotlight_x"], var_6.origin, anglesToForward(var_6.angles), anglestoup(var_6.angles));
    wait(0.1);
    triggerfx(var_10);
  }

  scripts\engine\utility::flag_wait("skq_p2t2_4");
  if(isDefined(var_10)) {
    var_10 delete();
  }

  var_0.setminimap setModel(var_1);
  var_7 delete();
}

init_poster_nums(var_0) {
  level endon("game_ended");
  level endon("reset_posters");
  level endon("correct_poster_got");
  var_1 = getEntArray("mpq_poster_model", "targetname");
  if(!var_0) {
    foreach(var_3 in var_1) {
      var_3.number = getent(var_3.target, "targetname");
    }
  } else {
    foreach(var_3 in var_3) {
      var_3 notify("reset_posters");
    }
  }

  var_1 = scripts\engine\utility::array_randomize_objects(var_1);
  var_7 = ["281", "407", "420", "596", "713", "818"];
  var_7 = scripts\engine\utility::array_randomize_objects(var_7);
  level.morse_number = var_7[0];
  var_8 = 0;
  foreach(var_3 in var_1) {
    if(var_3 == var_1[0]) {
      var_3.model_num = level.morse_number;
      if(var_0) {
        var_3 thread use_poster_logic(1);
      }

      var_8++;
    } else {
      var_3.model_num = var_7[var_8];
      if(var_8 + 1 >= var_7.size) {
        var_8 = 1;
      } else {
        var_8++;
      }

      if(var_0) {
        var_3 thread use_poster_logic(0);
      }
    }

    var_3.number setModel("cp_disco_film_registration_decal_" + var_3.model_num);
  }

  if(!var_0) {
    return var_1;
  }
}

use_poster_logic(var_0) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("skq_p2t2_1");
  self makeusable(1);
  self setusefov(45);
  self setuserange(96);
  var_1 = scripts\engine\utility::waittill_any_return("trigger", "correct_poster_got", "reset_posters");
  if(var_1 == "correct_poster_got" || var_1 == "reset_posters") {
    return;
  }

  if(var_0) {
    var_2 = getEntArray("mpq_poster_model", "targetname");
    foreach(var_4 in var_2) {
      var_4 notify("correct_poster_got");
    }

    self.number delete();
    self delete();
    level scripts\cp\utility::set_quest_icon(16);
    scripts\engine\utility::flag_set("correct_poster_got");
    level.phone_puzzle_phone = undefined;
    return;
  }

  level thread reset_phone_puzzle();
}

empty_hint(var_0, var_1) {
  return "";
}

p2t2_4_kung_fu_fight() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::flag_wait_any_return("skq_p2t2_4", "skq_p2t2_4dbg");
  var_1 = scripts\engine\utility::getstruct("kf_zombies_disco_roof", "targetname");
  level.spotlight_roof_zoms = 0;
  var_1 mpq_spawn_special_wave(level.spotlight_roof_zoms, 10);
  scripts\engine\utility::flag_set("skq_p2t2_5");
}

p2t2_5_rat_king_puzzle() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::flag_wait_any_return("skq_p2t2_5", "skq_p2t2_5dbg");
  var_1 = build_word_codex_list();
  solve_word_logic(var_1);
}

solve_word_logic(var_0) {
  level endon("game_ended");
  var_1 = [];
  var_1[0] = ::scripts\engine\utility::getstruct("letter_puzzle_solve_struct", "targetname");
  level.bchartoggle = 0;
  level.cur_puzzle_letter = undefined;
  level.rooftopcypherglyphs = [];
  while(isDefined(var_1[var_1.size - 1].target)) {
    var_1[var_1.size] = ::scripts\engine\utility::getstruct(var_1[var_1.size - 1].target, "targetname");
    wait(0.05);
  }

  var_2 = 0;
  var_3 = thread setup_cipher_glyphs();
  var_4 = 0;
  wait(1);
  var_5 = determine_puzzle_wordlist(var_0);
  var_6 = 0;
  var_7 = 0;
  while(!var_2) {
    if(var_4 >= var_5.size) {
      var_4 = 0;
      var_5 = determine_puzzle_wordlist(var_0);
      var_6 = 0;
      foreach(var_9 in level.players) {
        var_9 playlocalsound("ww_magicbox_laughter");
      }

      wait_for_wave_change(1);
    }

    var_11 = 0;
    var_2 = 0;
    var_12 = undefined;
    var_13 = [];
    var_3 = [];
    var_14 = var_5[var_6];
    if(!var_7 && randomint(101) == 100) {
      var_7 = 1;
      var_14 = "savagemadethis";
    }

    for(;;) {
      var_15 = getsubstr(var_14, var_11, var_11 + 1);
      if(!isDefined(var_15) || var_15 == "") {
        var_2 = 1;
        break;
      } else {
        if(var_11 != 0) {
          level.cur_puzzle_letter = var_15;
          level.bchartoggle = 1;
          level waittill("puzzle_letter_shot", var_12);
          if(var_12 != var_15) {
            playsoundatpos(var_1[var_11].origin, "mpq_fail_buzzer");
            var_4++;
            var_6++;
            foreach(var_11 in var_13) {
              var_11 delete();
            }

            wait(0.2);
            break;
          }
        }

        var_13[var_11] = spawnfx(level._effect["magnet_alphabet_" + var_15], var_1[var_11].origin, anglesToForward(var_1[var_11].angles), anglestoup(var_1[var_11].angles));
        wait(0.1);
        triggerfx(var_13[var_11]);
      }

      var_11++;
    }

    if(var_2) {
      level thread delaydeleteletters(var_13);
    }
  }

  foreach(var_11 in level.rooftopcypherglyphs) {
    if(isDefined(var_11)) {
      var_11 delete();
    }
  }

  level.rooftopcypherglyphs = undefined;
  thread rk_symbol_handler("rk_symbol_punk_rooftops", "skq_p2t2_6");
}

delaydeleteletters(var_0) {
  level endon("game_ended");
  wait(5);
  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

waittill_character_change() {
  level endon("game_ended");
  while(!level.bchartoggle) {
    wait(0.1);
  }

  level.bchartoggle = 0;
  return level.cur_puzzle_letter;
}

setup_cipher_glyphs() {
  level endon("game_ended");
  level endon("skq_p2t2_6");
  var_0 = scripts\engine\utility::getStructArray("letter_puzzle_struct", "script_noteworthy");
  var_1 = getent("letter_puzzle_clip", "targetname");
  var_2 = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
  foreach(var_4 in var_0) {
    var_4.current_letter = undefined;
  }

  var_6 = undefined;
  for(;;) {
    var_7 = [];
    var_8 = waittill_character_change();
    var_0 = scripts\engine\utility::array_randomize_objects(var_0);
    var_2 = scripts\engine\utility::array_randomize_objects(var_2);
    var_9 = 0;
    if(isDefined(var_6)) {
      while(var_0[0] == var_6) {
        var_0 = scripts\engine\utility::array_randomize_objects(var_0);
        wait(0.1);
      }
    }

    foreach(var_4 in var_0) {
      if(!isDefined(var_4.angles)) {
        var_4.angles = (0, 0, 0);
      }

      if(var_4 == var_0[0]) {
        var_6 = var_4;
        var_4.current_letter = var_8;
      } else {
        for(var_11 = var_9; var_11 < 26; var_11++) {
          if(var_2[var_11] != var_8) {
            var_4.current_letter = var_2[var_11];
            var_9++;
            break;
          } else {
            var_9++;
          }
        }
      }

      var_12 = spawnfx(level._effect["cipher_alphabet_" + var_4.current_letter], var_4.origin + anglesToForward(var_4.angles + (0, 90, 0)) * -1, anglesToForward(var_4.angles), anglestoup(var_4.angles));
      var_7[var_7.size] = var_12;
    }

    level.rooftopcypherglyphs = var_7;
    wait(0.1);
    foreach(var_12 in var_7) {
      triggerfx(var_12);
    }

    var_4 = undefined;
    var_1 setCanDamage(1);
    var_1.health = 999999;
    while(!isDefined(var_4)) {
      var_1 waittill("damage", var_10, var_11, var_10, var_4);
      if(!isPlayer(var_11)) {
        var_4 = undefined;
        var_1.health = 999999;
        continue;
      }
    }

    var_1 setCanDamage(0);
    var_0 = sortbydistance(var_0, var_4);
    var_12 = var_0[0].current_letter;
    level notify("puzzle_letter_shot", var_12);
    foreach(var_12 in var_7) {
      var_12 delete();
    }
  }
}

p2t2_6_rat_king_fight() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getstruct("p2t2_6", "script_noteworthy");
  var_1 = scripts\engine\utility::flag_wait_any_return("skq_p2t2_6", "skq_p2t2_6dbg");
  scripts\cp\maps\cp_disco\rat_king::spawn_rat_king(var_0.origin, var_0.angles, 1);
  level thread scripts\cp\maps\cp_disco\cp_disco::enableratkingpas();
  setrkabilities_p2t2_6();
  foreach(var_3 in level.players) {
    var_3 playsoundtoplayer("quest_stage_completed_gong_lr", var_3);
    if(var_3.vo_prefix == "p5_") {
      var_3 thread scripts\cp\cp_vo::try_to_play_vo("ww_ratking_spawn_p5", "rave_ww_vo", "highest", 70, 0, 0, 1);
      continue;
    }

    var_3 thread scripts\cp\cp_vo::try_to_play_vo("ww_ratking_spawn", "rave_ww_vo", "highest", 70, 0, 0, 1);
  }

  if(level.players.size == 4) {
    level thread play_rat_king_vo_discussion(2);
  }

  level watchrkretreat(1000);
  thread createrelicinteraction("brain");
  scripts\cp\maps\cp_disco\kung_fu_mode::increase_trainer_interaction_progression();
  foreach(var_3 in level.players) {
    var_3 thread play_corresponding_vo(2);
  }
}

play_corresponding_vo(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  if(!isPlayer(self) && !isDefined(self.vo_prefix)) {
    return;
  }

  var_1 = "";
  switch (var_0) {
    case 1:
      var_1 = "defeat_ratking_1";
      break;

    case 2:
      var_1 = "defeat_ratking_2";
      break;

    case 3:
      var_1 = "defeat_ratking_3";
      break;
  }

  thread scripts\cp\cp_vo::try_to_play_vo(var_1, "disco_comment_vo", "highest", 30, 1);
  wait(scripts\cp\cp_vo::get_sound_length(self.vo_prefix + var_1) + 5);
  thread scripts\cp\cp_vo::try_to_play_vo("pam_quest_complete", "disco_comment_vo", "highest", 30, 1);
}

createrelicinteraction(var_0) {
  level endon("game_ended");
  while(isDefined(level.rat_king)) {
    scripts\engine\utility::waitframe();
  }

  var_1 = spawnStruct();
  var_1.origin = getrelicspawnpos();
  var_1.script_noteworthy = "mpq_relics";
  var_1.name = "mpq_relics";
  var_1.script_parameters = "default";
  var_1.requires_power = 0;
  var_1.powered_on = 1;
  var_1.spend_type = undefined;
  var_2 = spawn("script_model", var_1.origin + (0, 0, 4));
  var_2 setModel("tag_origin_rk_relics");
  if(isDefined(var_1.angles)) {
    var_2.angles = var_1.angles;
  }

  var_1.model = var_2;
  var_1.relic = var_0;
  var_3 = scripts\engine\utility::drop_to_ground(var_1.origin, 32, -100);
  var_4 = spawnfx(level._effect["relic_active"], var_3 + (0, 0, 1));
  var_1.fx = var_4;
  triggerfx(var_4);
  var_1.model setscriptablepartstate("rk_models", "active_" + var_1.relic);
  var_1 thread startrelicmoveloop(var_1, var_1.model);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
  var_1 thread hiderkrelicsduringrkfight(var_1);
}

hiderkrelicsduringrkfight(var_0) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("rk_fight_started");
  var_0.model hide();
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  scripts\engine\utility::flag_waitopen("rk_fight_started");
  var_0.model show();
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

startrelicmoveloop(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  for(;;) {
    var_2 = 3;
    var_1 moveto(var_0.origin + (0, 0, 32), var_2);
    wait(var_2);
    var_1 moveto(var_0.origin, var_2);
    wait(var_2);
  }
}

getrelicspawnpos() {
  if(isDefined(level.rat_king_death_pos)) {
    var_0 = level.rat_king_death_pos;
  } else {
    var_0 = level.players[0].origin;
  }

  if(!isinactivevolume(var_0)) {
    var_0 = getpositionnearclosestplayer(var_0);
  }

  var_1 = getclosestpointonnavmesh(var_0) + (0, 0, 4);
  return var_1;
}

isinactivevolume(var_0) {
  if(!isDefined(level.active_spawn_volumes)) {
    return 1;
  }

  var_1 = sortbydistance(level.active_spawn_volumes, var_0);
  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0, var_3)) {
      return 1;
    }
  }

  return 0;
}

getpositionnearclosestplayer(var_0) {
  var_1 = scripts\engine\utility::getclosest(var_0, level.players);
  return getclosestpointonnavmesh(scripts\engine\utility::drop_to_ground(var_1.origin, 32, -100));
}

mpqrelichintfunc(var_0, var_1) {
  return "";
}

mpqrelicusefunc(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.inlaststand)) {
    return;
  }

  switch (var_0.relic) {
    case "brain":
      if(!scripts\engine\utility::flag("brain_picked")) {
        scripts\engine\utility::flag_set("brain_picked");
        if(var_1.vo_prefix == "p5_") {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("ratking_brain", "disco_comment_vo");
        } else {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("pam_collect_brain", "disco_comment_vo");
        }

        var_1 thread scripts\cp\cp_vo::add_to_nag_vo("pam_quest_return", "disco_comment_vo", 120, 120, 4, 1);
        level scripts\cp\utility::set_quest_icon(17);
        level scripts\cp\utility::set_completed_quest_mark(2);
        var_0.model thread cleanupmpqbrain(var_0, var_1);
      }
      break;

    case "heart":
      if(!scripts\engine\utility::flag("heart_picked")) {
        scripts\engine\utility::flag_set("heart_picked");
        if(var_1.vo_prefix == "p5_") {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("ratking_heart", "disco_comment_vo");
        } else {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("pam_collect_heart", "disco_comment_vo");
        }

        var_1 thread scripts\cp\cp_vo::add_to_nag_vo("pam_quest_return", "disco_comment_vo", 120, 120, 4, 1);
        level scripts\cp\utility::set_quest_icon(7);
        level scripts\cp\utility::set_completed_quest_mark(1);
      }

      if(!scripts\engine\utility::istrue(var_1.has_heart)) {
        var_1 scripts\cp\powers\coop_powers::givepower("power_heart", "primary", undefined, undefined, undefined, undefined, 1);
        var_0.model thread cleanupmpqrelic(var_0, var_1);
      }
      break;

    case "eye":
      if(!scripts\engine\utility::flag("eye_picked")) {
        scripts\engine\utility::flag_set("eye_picked");
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("pam_collect_eye", "disco_comment_vo");
        var_1 thread scripts\cp\cp_vo::add_to_nag_vo("pam_quest_return", "disco_comment_vo", 120, 120, 4, 1);
        level scripts\cp\utility::set_quest_icon(13);
        level scripts\cp\utility::set_completed_quest_mark(4);
      }

      if(!scripts\engine\utility::istrue(var_1.has_eye)) {
        var_1 scripts\cp\powers\coop_powers::givepower("power_rat_king_eye", "secondary", undefined, undefined, undefined, 1, 1);
        var_0.model thread cleanupmpqrelic(var_0, var_1);
      }
      break;
  }
}

cleanupmpqbrain(var_0, var_1) {
  var_0 notify("clean_up_relic");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_0.model setscriptablepartstate("interactions", "pickup");
  wait(0.5);
  if(isDefined(var_0.fx)) {
    var_0.fx delete(var_1);
  }

  if(isDefined(var_0.model)) {
    var_0.model delete(var_1);
  }
}

cleanupmpqrelic(var_0, var_1) {
  var_0 notify("clean_up_relic");
  var_0.model setscriptablepartstate("interactions", "pickup_" + var_0.relic);
}

setrkabilities_p2t2_6() {
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("teleport", 1);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("melee_attack", 1);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("shield_attack", 1);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("summon", 1);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("block", 0);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("staff_stomp", 0);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("staff_projectile", 0);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("shield_attack_spot", 0);
  level.rat_king_attack_priorities = [];
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "melee_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "teleport";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "summon";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_stomp";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_projectile";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "block";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack_spot";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "attack_zombies";
}

p2t2_7_complete_task() {
  var_0 = scripts\engine\utility::flag_wait_any_return("skq_p2t2_7", "skq_p2t2_7dbg");
  scripts\cp\maps\cp_disco\kung_fu_mode::disable_trainer_interactions();
  foreach(var_2 in level.players) {
    var_2 thread scripts\cp\cp_vo::try_to_play_vo("pam_quest_ratking_heart", "pam_dialogue_vo", "highest", 100, 1);
    if(var_2.vo_prefix == "p5_") {
      var_2 thread play_pam_reaction_vo("pam_quest_ratking_heart", 0, 1, 0);
    }
  }

  scripts\engine\utility::flag_set("skq_p2t3_0");
}

play_pam_reaction_vo(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  wait(scripts\cp\cp_vo::get_sound_length(var_0));
  if(scripts\engine\utility::istrue(var_1)) {
    thread scripts\cp\cp_vo::try_to_play_vo("pam_instuctions_rat_eye", "disco_comment_vo");
    return;
  }

  if(scripts\engine\utility::istrue(var_2)) {
    thread scripts\cp\cp_vo::try_to_play_vo("pam_instuctions_rat_heart", "disco_comment_vo");
    return;
  }

  thread scripts\cp\cp_vo::try_to_play_vo("pam_instuctions_rat_brain", "disco_comment_vo");
}

phase_2_task_3() {
  thread p2t3_0_missing_reel();
  thread p2t3_1_turnstile_puzzle();
  thread p2t3_2_chi_symbol();
  thread p2t3_3_disco_fever();
  thread p2t3_4_final_chi_door();
  thread p2t3_5_rat_king_fight();
  thread p2t3_6_complete_task();
}

p2t3_0_missing_reel() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::flag_wait_any_return("skq_p2t3_0", "skq_p2t3_0dbg");
  if(issubstr(var_0, "dbg")) {} else {
    wait_for_wave_change(3, 1);
  }

  wait(35);
  var_1 = 0;
  while(!var_1) {
    var_1 = 1;
    foreach(var_3 in level.players) {
      if(isDefined(level.clock_interaction) && isDefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner == var_3) {
        var_1 = 0;
      }

      if(isDefined(level.clock_interaction_q2) && isDefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner == var_3) {
        var_1 = 0;
      }

      if(isDefined(level.clock_interaction_q3) && isDefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner == var_3) {
        var_1 = 0;
      }

      if(scripts\engine\utility::istrue(var_3.isfasttravelling) || scripts\engine\utility::istrue(var_3.is_off_grid)) {
        var_1 = 0;
      }
    }

    if(scripts\engine\utility::istrue(level.gns_active)) {
      var_1 = 0;
    }

    wait(0.1);
  }

  var_5 = scripts\engine\utility::getStructArray("missing_reel_tp_struct", "targetname");
  var_6 = getent("missing_reel_fire_trig", "targetname");
  var_7 = scripts\engine\utility::getStructArray("missing_reel_fire_struct", "targetname");
  stop_spawn_wave();
  foreach(var_3 in level.players) {
    var_3 playlocalsound("bink_ducking_alias");
  }

  scripts\cp\utility::play_bink_video("MissingReel", 8, 1);
  clear_existing_enemies();
  var_10 = 0;
  foreach(var_3 in level.players) {
    if(var_3 scripts\cp\utility::isteleportenabled()) {
      var_3 scripts\cp\utility::allow_player_teleport(0);
    }

    thread missing_reel_pickup_players(var_5[var_10], var_3);
    var_10++;
  }

  thread missing_reel_fire_fx(var_7);
  var_6 thread missing_reel_trigger_damage(var_5);
  wait(7);
  level.wave_num = level.wave_num + randomintrange(2, 4);
  foreach(var_3 in level.players) {
    var_3 setclientomnvar("zombie_wave_number", level.wave_num);
  }

  thread spawn_missing_reel_wave(var_5);
  wait(1);
  scripts\engine\utility::flag_wait_or_timeout("reel_zoms_beaten", 60);
  scripts\engine\utility::flag_set("cleanup_reel_assets");
  foreach(var_10 in level.players) {
    if(!var_10 scripts\cp\utility::isteleportenabled()) {
      var_10 scripts\cp\utility::allow_player_teleport(1);
    }
  }

  scripts\engine\utility::flag_clear("pause_wave_progression");
  level.zombies_paused = 0;
  level.dont_resume_wave_after_solo_afterlife = 0;
  var_6.trigger_off = 1;
  var_6 notify("trigger_off");
  var_5 = scripts\engine\utility::array_randomize_objects(var_5);
  var_12 = scripts\engine\utility::drop_to_ground(var_5[0].origin, 30, -100);
  var_13 = spawn("script_model", var_12 + (0, 0, 32));
  var_14 = scripts\engine\utility::spawn_tag_origin(var_13.origin + anglesToForward(var_13.angles) * 2, (0, 0, 0));
  var_13 setModel("tag_origin");
  var_13 linkto(var_14);
  var_14 thread spin_linker_turnstile(var_13);
  wait(0.5);
  playFXOnTag(level._effect["turnstile_arm"], var_13, "tag_origin");
  var_13 makeusable();
  var_13 waittill("trigger", var_3);
  if(isDefined(var_3) && isPlayer(var_3)) {
    var_3 thread scripts\cp\cp_vo::try_to_play_vo("pam_collect_turnstile", "disco_comment_vo");
    var_3 thread scripts\cp\cp_vo::add_to_nag_vo("missing_item_misc", "disco_comment_vo", 200, 120, 4, 1);
  }

  level scripts\cp\utility::set_quest_icon(9);
  var_13 delete();
  var_14 delete();
  scripts\engine\utility::flag_set("skq_p2t3_1");
}

missing_reel_pickup_players(var_0, var_1) {
  wait(1);
  var_0.tp_active = 1;
  if(scripts\engine\utility::istrue(var_1.inlaststand) || scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    var_1 notify("arcade_special_interrupt");
    var_1.ignoreselfrevive = 1;
    scripts\cp\cp_laststand::clear_last_stand_timer(var_1);
    var_1 notify("revive_success");
    if(isDefined(var_1.reviveent)) {
      var_1.reviveent notify("revive_success");
    }

    wait(6);
    if(isDefined(var_1.lost_and_found_ent)) {
      scripts\cp\zombies\zombie_lost_and_found::restore_player_status(var_1);
    }
  }

  var_1 setorigin(var_0.origin);
  var_1 setplayerangles(var_0.angles);
  var_1.missing_reel = 1;
  var_1.ignoreselfrevive = undefined;
}

spin_linker_turnstile(var_0) {
  var_0 endon("trigger");
  for(;;) {
    self rotateyaw(360, 2, 0, 0);
    wait(2);
  }
}

spawn_missing_reel_wave(var_0) {
  level.reel_zombies = 0;
  var_1 = [];
  var_2 = 0;
  foreach(var_4 in var_0) {
    if(isDefined(var_4.tp_active)) {
      var_5 = scripts\engine\utility::getStructArray(var_4.target, "targetname");
      var_6 = 6;
      var_6 = var_6 - floor(level.players.size / 2);
      var_6 = int(var_6);
      foreach(var_8 in var_5) {
        if(var_6 <= 0) {
          break;
        }

        var_9 = scripts\engine\utility::drop_to_ground(var_8.origin, 30, -100);
        var_10 = spawnStruct();
        var_10.origin = var_9;
        var_11 = var_10 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("generic_zombie", 1);
        var_1[var_1.size] = var_11;
        scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(1);
        var_2++;
        var_6--;
      }
    }
  }

  for(;;) {
    var_14 = 1;
    foreach(var_11 in var_1) {
      if(isDefined(var_11) && isalive(var_11)) {
        var_14 = 0;
        break;
      }
    }

    if(var_14) {
      break;
    }

    wait(0.1);
  }

  scripts\engine\utility::flag_set("reel_zoms_beaten");
  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(var_2);
}

teleport_zoms(var_0) {
  var_1 = scripts\engine\utility::getStructArray(self.target, "targetname");
  var_2 = 0;
  foreach(var_4 in var_0) {
    var_4 scripts\cp\zombies\cp_disco_spawning::move_to_spot(var_1[var_2]);
    if(var_2 + 1 == var_1.size) {
      var_2 = 0;
      continue;
    }

    var_2++;
  }
}

missing_reel_fire_fx(var_0) {
  level endon("game_ended");
  var_1 = [];
  foreach(var_3 in var_0) {
    var_1[var_1.size] = spawnfx(level._effect["vfx_zb_carfire_b"], var_3.origin, anglesToForward(var_3.angles), anglestoup(var_3.angles));
  }

  wait(0.1);
  foreach(var_6 in var_1) {
    triggerfx(var_6);
  }

  scripts\engine\utility::flag_wait("cleanup_reel_assets");
  foreach(var_6 in var_1) {
    var_6 delete();
  }
}

missing_reel_trigger_damage(var_0) {
  level endon("game_ended");
  level endon("cleanup_reel_assets");
  var_1 = 0;
  thread damage_reel_trigger_solo();
  for(;;) {
    level waittill("connected", var_2);
    var_2 setorigin(var_0[var_1].origin);
    var_2 setplayerangles(var_0[var_1].angles);
    var_2 thread damage_reel_trigger_solo(self);
    if(var_1 == 3) {
      var_1 = 0;
      continue;
    }

    var_1++;
  }
}

damage_reel_trigger_solo() {
  level endon("game_ended");
  level endon("cleanup_reel_assets");
  for(;;) {
    self waittill("trigger", var_0);
    var_0 dodamage(var_0.health * 2, self.origin);
  }
}

p2t3_1_turnstile_puzzle() {
  var_0 = scripts\engine\utility::flag_wait_any_return("skq_p2t3_1", "skq_p2t3_1dbg");
  var_1 = getent("window_cover", "targetname");
  var_1.ogpos = var_1.origin;
  var_2 = getent("window_cover_struct_clip", "targetname");
  var_3 = 25;
  thread turnstile_glyph_logic();
  scripts\engine\utility::flag_wait("turnstile_done");
  level thread scripts\cp\cp_vo::remove_from_nag_vo("missing_item_misc");
  var_1 movez(60, 8, 3, 3);
  scripts\engine\utility::flag_wait("turnstyle_glyph_hit");
  var_4 = var_1.ogpos[2] - var_1.origin[2];
  var_1 movez(var_4, 1, 0, 0);
  scripts\engine\utility::flag_set("skq_p2t3_2");
}

turnstile_glyph_logic() {
  var_0 = scripts\engine\utility::getstruct("window_cover_struct", "targetname");
  var_1 = getent("window_cover_struct_clip", "targetname");
  var_2 = spawnfx(level._effect["test_glyph_mpq"], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  scripts\engine\utility::flag_wait("turnstile_done");
  triggerfx(var_2);
  var_1 setCanDamage(1);
  var_1.health = 9999;
  var_1 waittill("damage");
  var_2 delete();
  scripts\engine\utility::flag_set("turnstyle_glyph_hit");
  wait(2);
  scripts\cp\utility::deactivatebrushmodel(var_1, 1);
}

init_turnstile() {
  var_0 = scripts\engine\utility::getstruct("turnstile", "script_noteworthy");
  var_0.groupname = "locoverride";
  scripts\cp\maps\cp_disco\cp_disco::addtopersonalinteractionlist(var_0);
  level.special_mode_activation_funcs["turnstile"] = ::setup_turnstile;
  level.normal_mode_activation_funcs["turnstile"] = ::setup_turnstile;
}

setup_turnstile(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::flag("skq_p2t3_2") || scripts\engine\utility::flag("turnstile_done")) {
    var_0 setModel("cp_disco_subway_turnstyle_animated");
    return;
  }

  var_0 setModel("cp_disco_subway_turnstyle_missing_arm");
}

use_turnstile(var_0, var_1) {
  if(scripts\engine\utility::flag("skq_p2t3_1") && !scripts\engine\utility::flag("turnstile_done")) {
    var_2 = var_0.currentlyownedby[var_1.name];
    var_2 setModel("cp_disco_subway_turnstyle_animated");
    playsoundatpos(var_2.origin, "disco_turnstile");
    var_2 scriptmodelplayanim("IW7_cp_turnstyle_rotate");
    scripts\engine\utility::flag_set("turnstile_done");
    foreach(var_1 in level.players) {
      var_1 scripts\cp\zombies\achievement::update_achievement("MESSAGE_RECEIVED", 1);
    }

    wait(2);
    var_2 scriptmodelclearanim();
  }
}

p2t3_2_chi_symbol() {
  var_0 = scripts\engine\utility::flag_wait_any_return("skq_p2t3_2", "skq_p2t3_2dbg");
  level.task3ring_fxstruct = scripts\engine\utility::getstruct("task_3_ring_struct", "targetname");
  var_1 = randomintrange(6, 10);
  zombie_challenge_ring(var_1, level.task3ring_fxstruct);
  var_2 = 5;
  for(var_3 = 0; var_3 < var_2; var_3++) {
    next_ring_struct();
    var_1 = randomintrange(6, 10);
    zombie_challenge_ring(var_1, level.task3ring_fxstruct);
  }

  level notify("task3RingDone");
  foreach(var_5 in level.players) {
    var_5 playsoundtoplayer("quest_stage_completed_gong_lr", var_5);
  }

  wait(1);
  scripts\engine\utility::flag_set("skq_p2t3_3");
}

next_ring_struct() {
  var_0 = scripts\engine\utility::getStructArray("task_3_ring_struct_rand", "targetname");
  var_0 = scripts\engine\utility::array_randomize_objects(var_0);
  foreach(var_2 in var_0) {
    if(level.task3ring_fxstruct != var_2) {
      level.task3ring_fxstruct = var_2;
      return;
    }
  }
}

ring_explode_zombies() {
  level endon("task3RingDone");
  self endon("death");
  var_0 = 1.5;
  var_1 = 0.3;
  var_2 = var_0 / var_1;
  for(;;) {
    var_3 = 1;
    if(distancesquared(level.task3ring_fxstruct.origin, self.origin) <= 30625) {
      for(var_4 = 0; var_4 < var_2; var_4++) {
        wait(var_1);
        if(distancesquared(level.task3ring_fxstruct.origin, self.origin) > 30625) {
          var_3 = 0;
          break;
        }
      }

      if(var_3) {
        break;
      }
    }

    wait(0.1);
  }

  level notify("ring_kill");
  self.atomize_me = 1;
  self dodamage(self.health * 2, level.task3ring_fxstruct.origin);
}

p2t3_3_disco_fever() {
  var_0 = scripts\engine\utility::flag_wait_any_return("skq_p2t3_3", "skq_p2t3_3dbg");
  scripts\engine\utility::flag_wait("fever_started");
  var_1 = 10;
  var_2 = undefined;
  var_3 = 1;
  var_4 = scripts\engine\utility::getstruct("disco_fever_spawn_struct", "targetname");
  for(;;) {
    if(isDefined(var_2)) {
      var_1--;
      if(var_1 <= 0) {
        break;
      }

      var_5 = var_2;
      if(isDefined(var_5)) {
        var_5.precacheleaderboards = 1;
        var_5.desired_dance_angles = (0, 0, 0);
        var_5.bhasdiscofever = 1;
        var_5.dontmutilate = 1;
        var_5 clearpath();
        var_5 thread handle_fx_for_fever();
        var_5 waittill("death");
        var_2 = find_near_disco_zombie(var_4.origin);
      } else {
        var_2 = undefined;
      }

      continue;
    }

    if(var_3) {
      var_3 = 0;
    } else {
      level notify("update_fx");
      wait(10);
    }

    var_1 = 10;
    for(var_5 = undefined; !isDefined(var_5); var_5 = spawn_fever_zombie()) {
      wait(0.05);
    }

    var_5 clearpath();
    var_5 thread handle_fx_for_fever();
    var_5 waittill("death");
    var_2 = find_near_disco_zombie(var_4.origin);
  }

  scripts\engine\utility::flag_set("skq_p2t3_4");
}

handle_fx_for_fever() {
  self endon("death");
  wait(0.15);
  playFXOnTag(level._effect["disco_fever"], self, "tag_origin");
  thread setfevereffectsonhostmigration();
}

setfevereffectsonhostmigration() {
  self endon("death");
  self endon("disconnect");
  level waittill("host_migration_begin");
  level waittill("host_migration_end");
  if(!scripts\engine\utility::flag("skq_p2t3_4")) {
    playFXOnTag(level._effect["disco_fever"], self, "tag_origin");
  }
}

find_near_disco_zombie(var_0) {
  var_1 = getent("disco_fever_vol", "targetname");
  var_2 = [];
  foreach(var_4 in level.spawned_enemies) {
    if(isDefined(var_4.dismember_crawl) && var_4.dismember_crawl) {
      continue;
    }

    if((isDefined(var_4.agent_type) && var_4.agent_type == "karatemaster") || var_4.agent_type == "skater") {
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  var_6 = sortbydistance(var_2, var_0);
  if(isDefined(var_6[0]) && var_6[0] istouching(var_1)) {
    return var_6[0];
  }

  return undefined;
}

spawn_fever_zombie() {
  var_0 = scripts\engine\utility::getstruct("disco_fever_spawn_struct", "targetname");
  var_1 = scripts\engine\utility::drop_to_ground(var_0.origin, 30, -100);
  var_2 = spawnStruct();
  var_2.origin = var_1;
  var_2.script_animation = undefined;
  var_2.script_parameters = undefined;
  var_3 = var_2 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("generic_zombie", 1);
  if(!isDefined(var_3)) {
    return undefined;
  }

  var_3.dontmutilate = 1;
  var_3.precacheleaderboards = 1;
  var_3.desired_dance_angles = (0, 0, 0);
  var_3.bhasdiscofever = 1;
  return var_3;
}

init_turntable() {
  var_0 = scripts\engine\utility::getstruct("disco_fever_interact", "script_noteworthy");
  var_0.groupname = "locoverride";
  scripts\cp\maps\cp_disco\cp_disco::addtopersonalinteractionlist(var_0);
  level.special_mode_activation_funcs["disco_fever_interact"] = ::setup_turntable;
  level.normal_mode_activation_funcs["disco_fever_interact"] = ::setup_turntable;
}

setup_turntable(var_0, var_1, var_2, var_3) {
  var_0 setModel("cp_disco_record_02");
  if(scripts\engine\utility::flag("skq_p2t3_3") || scripts\engine\utility::flag("skq_p2t3_3dbg")) {
    var_0 thread rotate_platter(var_3);
  }
}

rotate_platter(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("p_ent_reset");
  while(self.model == "cp_disco_record_02") {
    self rotateyaw(360, 1.5, 0, 0);
    wait(1.5);
  }
}

discofeverhintfunc(var_0, var_1) {
  var_1.interaction_trigger usetriggerrequirelookat(0);
  var_1.interaction_trigger setusefov(360);
  return "";
}

use_turntable(var_0, var_1) {
  if(scripts\engine\utility::flag("skq_p2t3_3") && !scripts\engine\utility::flag("fever_started")) {
    scripts\engine\utility::flag_set("fever_started");
  }
}

p2t3_4_final_chi_door() {
  var_0 = scripts\engine\utility::flag_wait_any_return("skq_p2t3_4", "skq_p2t3_4dbg");
  thread rk_symbol_handler("rk_symbol_disco_streets", "skq_p2t3_5");
}

p2t3_5_rat_king_fight() {
  var_0 = scripts\engine\utility::getstruct("p2t3_5", "script_noteworthy");
  var_1 = scripts\engine\utility::flag_wait_any_return("skq_p2t3_5", "skq_p2t3_5dbg");
  scripts\cp\maps\cp_disco\rat_king::spawn_rat_king(var_0.origin, var_0.angles, 1);
  level thread scripts\cp\maps\cp_disco\cp_disco::enableratkingpas();
  setrkabilities_p2t3_5();
  foreach(var_3 in level.players) {
    var_3 playsoundtoplayer("quest_stage_completed_gong_lr", var_3);
    if(var_3.vo_prefix == "p5_") {
      var_3 thread scripts\cp\cp_vo::try_to_play_vo("ww_ratking_spawn_p5", "rave_ww_vo", "highest", 70, 0, 0, 1);
      continue;
    }

    var_3 thread scripts\cp\cp_vo::try_to_play_vo("ww_ratking_spawn", "rave_ww_vo", "highest", 70, 0, 0, 1);
  }

  if(level.players.size == 4) {
    level thread play_rat_king_vo_discussion(3);
  }

  level watchrkretreat(2500);
  thread createrelicinteraction("heart");
  scripts\cp\maps\cp_disco\kung_fu_mode::increase_trainer_interaction_progression();
  foreach(var_3 in level.players) {
    var_3 thread play_corresponding_vo(3);
  }
}

setrkabilities_p2t3_5() {
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("teleport", 1);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("melee_attack", 1);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("staff_stomp", 1);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("staff_projectile", 1);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("summon", 1);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("block", 0);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("shield_attack", 0);
  scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("shield_attack_spot", 0);
  level.rat_king_attack_priorities = [];
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_projectile";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_stomp";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "melee_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "summon";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "teleport";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack_spot";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "attack_zombies";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "block";
}

p2t3_6_complete_task() {
  var_0 = scripts\engine\utility::flag_wait_any_return("skq_p2t3_6", "skq_p2t3_6dbg");
  level thread watchforallplayersinroom();
}

watchforallplayersinroom() {
  level endon("game_Ended");
  var_0 = getent("slime_pool", "targetname");
  for(;;) {
    wait(0.1);
    var_0 waittill("trigger", var_1);
    if(!isPlayer(var_1)) {
      continue;
    }

    var_2 = 1;
    if(isDefined(level.clock_interaction) && scripts\engine\utility::istrue(level.clock_interaction.clock_active)) {
      continue;
    }

    if(isDefined(level.clock_interaction_q2) && scripts\engine\utility::istrue(level.clock_interaction_q2.clock_active)) {
      continue;
    }

    if(isDefined(level.clock_interaction_q3) && scripts\engine\utility::istrue(level.clock_interaction_q3.clock_active)) {
      continue;
    }

    foreach(var_4 in level.players) {
      if(scripts\engine\utility::istrue(var_4.isrewinding)) {
        var_2 = 0;
        break;
      }

      if(scripts\engine\utility::istrue(var_4.isfasttravelling)) {
        var_2 = 0;
        break;
      }

      if(scripts\engine\utility::istrue(var_4.is_off_grid)) {
        var_2 = 0;
        break;
      }
    }

    if(var_2) {
      break;
    }
  }

  scripts\engine\utility::flag_set("skq_phase_3");
}

phase_3() {
  var_0 = scripts\engine\utility::flag_wait_any_return("skq_phase_3", "skq_phase_3dbg");
  level scripts\cp\maps\cp_disco\rat_king_fight::start_rk_fight();
}

mpq_spawn_special_wave(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  var_0 = var_1;
  var_5 = 0;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  if(scripts\cp\zombies\zombies_spawning::num_zombies_available_to_spawn() < var_1) {
    var_6 = level.current_enemy_deaths;
    var_7 = level.max_static_spawned_enemies;
    var_8 = level.desired_enemy_deaths_this_wave;
    var_9 = level.wave_num;
    while(level.current_enemy_deaths == level.desired_enemy_deaths_this_wave) {
      wait(0.05);
    }

    level.current_enemy_deaths = 0;
    level.desired_enemy_deaths_this_wave = 24;
    level.special_event = 1;
    scripts\engine\utility::flag_set("pause_wave_progression");
    level.zombies_paused = 1;
    var_5 = 1;
  }

  if(isDefined(var_2)) {
    playsoundatpos(self.origin, var_2);
  }

  if(isDefined(var_3)) {
    playFX(level._effect[var_3], self.origin);
  }

  var_10 = getrandomnavpoints(self.origin, 1024, var_1);
  scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(var_1);
  wait(2);
  var_11 = skeleton_spawner(var_10, var_0, var_4);
  if(isDefined(var_4)) {
    return var_11;
  }

  wait_for_skeleton_death_or_timeout(var_11, 300);
  self.finished_final_part = 1;
  if(var_5) {
    level.spawndelayoverride = undefined;
    level.wave_num_override = undefined;
    level.special_event = undefined;
    level.zombies_paused = 0;
    scripts\engine\utility::flag_clear("pause_wave_progression");
    if(level.wave_num == var_9) {
      level.current_enemy_deaths = var_6;
      level.max_static_spawned_enemies = var_7;
      level.desired_enemy_deaths_this_wave = var_8;
    } else {
      level.current_enemy_deaths = 0;
      level.max_static_spawned_enemies = scripts\cp\zombies\zombies_spawning::get_max_static_enemies(level.wave_num);
      level.desired_enemy_deaths_this_wave = scripts\cp\zombies\zombies_spawning::get_total_spawned_enemies(level.wave_num);
    }
  }

  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(var_1);
  return 1;
}

wait_for_skeleton_death_or_timeout(var_0, var_1) {
  level endon("skeleton_timeout");
  level thread notify_after_time("skeleton_timeout", var_1);
  for(;;) {
    var_2 = 1;
    var_3 = 0;
    foreach(var_5 in var_0) {
      if(isDefined(var_5) && isalive(var_5) && isDefined(var_5.agent_type) && var_5.agent_type == "karatemaster") {
        var_2 = 0;
        var_3++;
      }
    }

    if(var_2) {
      break;
    }

    wait(0.5);
  }
}

notify_after_time(var_0, var_1) {
  wait(var_1);
  self notify(var_0);
}

determine_best_shovel_spawns(var_0, var_1) {
  var_2 = [];
  var_3 = scripts\engine\utility::getStructArray("camper_to_lake_spawner", "targetname");
  var_3 = sortbydistance(var_3, var_0);
  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_2[var_4] = var_3[var_4];
  }

  var_5 = scripts\engine\utility::array_randomize_objects(var_2);
  return var_2;
}

get_rand_point(var_0) {
  while(![[level.active_volume_check]](var_0)) {
    var_0 = getrandomnavpoint(var_0, 64);
    scripts\engine\utility::waitframe();
  }

  return var_0;
}

skeleton_spawner(var_0, var_1, var_2) {
  var_3 = [];
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_0[var_4] = get_rand_point(var_0[var_4]);
    var_5 = spawn_skeleton_solo(var_0[var_4], var_2);
    if(isDefined(var_5)) {
      var_5 thread skeleton_death_watcher(var_1);
      var_3[var_3.size] = var_5;
      var_5 thread set_skeleton_attributes();
      wait(1);
      continue;
    }

    var_1--;
  }

  return var_3;
}

skeleton_death_watcher(var_0) {
  level endon("game_ended");
  self waittill("death");
  var_0--;
}

spawn_skeleton_solo(var_0, var_1) {
  var_0 = scripts\engine\utility::drop_to_ground(var_0, 30, -100);
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.script_parameters = "ground_spawn_no_boards";
  var_2.script_animation = "spawn_ground";
  var_3 = 4;
  var_4 = 0.3;
  for(var_5 = 0; var_5 < var_3; var_5++) {
    if(isDefined(var_1)) {
      var_2.script_animation = undefined;
      var_2.script_parameters = undefined;
      var_6 = var_2 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy(var_1, 1);
    } else {
      var_6 = var_2 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("karatemaster", 1);
    }

    wait(var_4);
    if(isDefined(var_6)) {
      return var_6;
    }
  }

  return undefined;
}

set_skeleton_attributes() {
  level endon("game_ended");
  self endon("death");
  self.dont_cleanup = 1;
  self.synctransients = "sprint";
  self.is_skeleton = 1;
  self.health = 800;
  self.maxhealth = 800;
  self waittill("intro_vignette_done");
  self.health = scripts\cp\zombies\cp_disco_spawning::calculatezombiehealth("karatemaster");
}

skeleton_arrival_cowbell(var_0) {
  var_1 = (0, 0, -11);
  var_2 = spawnfx(level._effect["superslasher_summon_zombie_portal"], var_0 + var_1, (0, 0, 1), (1, 0, 0));
  triggerfx(var_2);
  scripts\engine\utility::waittill_any("death", "intro_vignette_done");
  var_2 delete();
}

build_word_codex_list() {
  var_0 = [];
  var_0["rave"] = [];
  var_0["spaceland"] = [];
  var_0["disco"] = [];
  var_0["disco2"] = [];
  var_0["extinction"] = [];
  var_0["willard"] = [];
  var_0["characters"] = [];
  var_0["rave"] = ["harpoon", "trees", "dance", "basement", "slasher", "memories", "charms", "boat", "kevinsmith", "fairies"];
  var_0["spaceland"] = ["brute", "octonian", "rollercoaster", "arcade", "slide", "geyser", "zapper", "forgefreeze", "bumpercars", "yetieyes"];
  var_0["disco"] = ["rollerskates", "katana", "kungfu", "nunchucks", "dragon", "crane", "snake", "tiger", "pamgrier", "arthur"];
  var_0["disco2"] = ["disco", "ratking", "subway", "punks", "blackcat", "pinkcat", "inferno", "mcintosh", "staff", "shield"];
  var_0["extinction"] = ["cryptid", "drcross", "hives", "ancestor", "breeder", "kraken", "obelisk", "davidarcher", "nightfall", "samantha"];
  var_0["willard"] = ["shuffle", "winonawyler", "director", "death", "redwoods", "mephistopheles", "sixtymillion", "afterlife", "spaceland", "shaolin"];
  var_0["characters"] = ["werewolfpoets", "losangeles", "realitytv", "beverlyhills", "ghetto", "broadway", "comicbooks", "newyork", "actors", "audition"];
  return var_0;
}

determine_puzzle_wordlist(var_0) {
  var_1 = [];
  var_2 = randomintrange(0, 101);
  var_3 = scripts\engine\utility::array_randomize_objects(getarraykeys(var_0));
  if(!isDefined(level.current_active_word_list) || var_3[0] == level.current_active_word_list) {
    level.current_active_word_list = var_3[1];
    var_1 = scripts\engine\utility::array_randomize_objects(var_0[var_3[1]]);
    return var_1;
  }

  level.current_active_word_list = var_3[0];
  var_1 = scripts\engine\utility::array_randomize_objects(var_0[var_3[0]]);
  return var_1;
}

clear_existing_enemies() {
  foreach(var_1 in level.spawned_enemies) {
    if(isalive(var_1) && var_1.health >= 1) {
      var_1.died_poorly = 1;
      var_1.nocorpse = 1;
      var_1 suicide();
    }
  }

  scripts\engine\utility::waitframe();
}

stop_spawn_wave() {
  scripts\engine\utility::flag_set("pause_wave_progression");
  level.zombies_paused = 1;
  level.dont_resume_wave_after_solo_afterlife = 1;
}

wait_for_wave_change(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_2 = 4;
  if(isDefined(var_1)) {
    foreach(var_4 in level.players) {
      var_4 setclientomnvar("zom_escape_gate_score", var_2);
    }
  }

  for(var_6 = 0; var_6 < var_0; var_6++) {
    var_2--;
    var_7 = level.wave_num;
    while(var_7 == level.wave_num) {
      wait(1);
    }

    if(isDefined(var_1)) {
      foreach(var_4 in level.players) {
        var_4 setclientomnvar("zom_escape_gate_score", var_2);
      }
    }
  }
}

show_effects_for_eye_only(var_0, var_1, var_2) {
  level endon("game_ended");
  for(;;) {
    foreach(var_4 in level.players) {
      var_4 thread determine_effect_visibility(var_0, var_2);
    }

    var_6 = level scripts\engine\utility::waittill_any_return("rat_king_eye_activated", "rat_king_eye_deactivated", "connected", var_1);
    if(var_6 == var_1) {
      break;
    }
  }

  foreach(var_4 in level.players) {
    var_4 thread determine_effect_visibility();
  }
}

determine_effect_visibility(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    if(isDefined(self.active_effect)) {
      self.active_effect delete();
    }

    return;
  }

  var_2 = var_1;
  if(scripts\engine\utility::istrue(self.wearing_rat_king_eye)) {
    var_3 = spawnfxforclient(level._effect[var_0], var_2.origin, self, anglesToForward(var_2.angles), anglestoup(var_2.angles));
    self.active_effect = var_3;
    wait(1);
    triggerfx(var_3);
    return;
  }

  if(isDefined(self.active_effect)) {
    self.active_effect delete();
  }
}

monitor_spawning_agents(var_0, var_1) {
  level endon(var_1);
  level endon("game_ended");
  for(;;) {
    level waittill("agent_spawned", var_2);
    var_2 scripts\engine\utility::delaythread(0.05, var_0);
  }
}

rk_symbol_handler(var_0, var_1) {
  level endon("game_ended");
  var_2 = scripts\engine\utility::getstruct(var_0, "targetname");
  var_3 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
  var_3 makeusable();
  var_3 setusefov(45);
  var_3 setuserange(96);
  var_4 = scripts\engine\utility::drop_to_ground(var_2.origin, 30, -100);
  var_4 = var_4 + (0, 0, 1);
  var_5 = spawnfx(level._effect["test_glyph_mpq"], var_4, anglesToForward(var_2.angles), anglestoup(var_2.angles));
  triggerfx(var_5);
  foreach(var_7 in level.players) {
    var_7 playsoundtoplayer("quest_stage_completed_gong_lr", var_7);
  }

  var_3 setusefov(180);
  var_3 waittill("trigger");
  var_3 delete();
  var_5 delete();
  scripts\engine\utility::flag_set(var_1);
}

failmpqstep() {
  foreach(var_1 in level.players) {
    var_1 playsoundtoplayer("mpq_fail_buzzer", var_1);
  }
}