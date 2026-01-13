/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_neil.gsc
***************************************************/

init_neil_quest() {
  level.var_4EFB = ::func_4EFA;
  level.var_3C10 = 0;
  level.var_6ACD = [];
  level.var_3C16 = 0;
  level.var_6ACC = 0;
  level.var_BEB2 = "robot_kevin_upper";
  level.var_BEB1 = "robot_kevin_lower";
  level.var_74B8 = "robot_park_kevin";
  level.var_8C89 = "robot_park_kevin_headless";
  level.var_BEC8 = "robot_park_kevin_head";
  level.var_BECF = level._effect["neil_light_on"];
  scripts\engine\utility::flag_init("neil_head_attached");
  scripts\engine\utility::flag_init("neil_battery_attached");
  scripts\engine\utility::flag_init("neil_firmware_attached");
  scripts\engine\utility::flag_init("quest_step_1_complete");
  scripts\engine\utility::flag_init("quest_step_2_complete");
  scripts\engine\utility::flag_init("quest_step_3_complete");
  scripts\engine\utility::flag_init("transformation_complete");
  scripts\engine\utility::flag_init("transform");
  scripts\engine\utility::flag_init("halt_neil");
  scripts\engine\utility::flag_init("landing_zone_active");
  getent("neil_usetrig", "targetname") enablelinkto();
  var_0 = getvehiclenode("neil_spawn", "targetname");
  func_F999(var_0);
  level thread func_BED2();
  level thread func_1077A();
  wait(5);
  var_1 = 0;
  func_9696(var_1);
  func_9697(var_1);
}

func_F447() {
  level.var_BEB2 = "robot_kevin_black_upper";
  level.var_BEB1 = "robot_kevin_black_lower";
  level.var_74B8 = "robot_park_kevin_02";
  level.var_8C89 = "robot_park_kevin_headless_black";
  level.var_BEC8 = "robot_park_kevin_head_black";
  level.var_BECF = level._effect["neil_light_on_red"];
}

func_BED2() {
  func_BED3();
  func_BED4();
  func_BED8();
  level thread func_1176E();
}

func_BED3() {
  scripts\engine\utility::flag_wait("neil_head_attached");
  level.var_13BD2 = level.wave_num;
  wait(0.5);
  level.neil setModel(level.var_BEB1);
  level.neil.is_neil = 1;
  createnavrepulsor("neil", 0, level.neil, 20, 1);
  level.neil.upper_body = spawn("script_model", level.neil.origin);
  level.neil.upper_body.angles = level.neil.angles;
  level.neil.upper_body setModel(level.var_BEB2);
  level.neil.upper_body func_BEDF("happy");
  level.neil.upper_body linkto(level.neil);
  level.neil.upper_body playSound("neil_startup");
  level.neil.upper_body scriptmodelplayanim("IW7_cp_zom_n31l_head_on", 1);
  level.neil setnonstick(1);
  level.neil.upper_body setnonstick(1);
  level.neil setvehicleteam("allies");
  level.neil setvehiclelookattext("N31L");
  wait(0.5);
  scripts\cp\zombies\zombie_analytics::func_AF7D(level.var_13BD1, level.var_13BD2);
  wait(2);
  level.neil.upper_body thread func_BECD("n31l_spawn_assembly");
  level thread setspectatedefaults(100);
  level.neil startpath();
  level.neil vehicle_setspeed(2, 1, 1);
  level.neil waittill("reached_end_node");
  var_0 = getvehiclenode("neil_start_node", "targetname");
  level.neil startpath(var_0);
  level.neil thread func_BED0(var_0);
  scripts\engine\utility::flag_clear("transformation_complete");
  func_BECC(level.neil);
  func_BEB6(level.neil);
}

func_BED4() {
  func_BED6();
  func_10778();
  func_BEBD(level.neil, &"CP_ZMB_INTERACTIONS_MISSING_BATTERY");
  for(;;) {
    level.neil.var_13084 waittill("trigger", var_0);
    if(!var_0 scripts\cp\utility::is_valid_player() || !isDefined(level.var_BEB0)) {
      continue;
    }

    break;
  }

  var_1 = scripts\engine\utility::getstruct("neil_repair", "script_noteworthy");
  add_part_to_neil(var_1, var_0);
  func_BEBC(level.neil);
  level func_BED7();
  level.var_13BCE = level.wave_num;
  scripts\cp\zombies\zombie_analytics::func_AF7B(level.var_13BCD, level.var_13BCE);
  level thread setspectatedefaults(100);
  scripts\engine\utility::flag_clear("halt_neil");
  scripts\engine\utility::flag_clear("transform");
  level.neil vehicle_setspeed(2, 1, 1);
  wait(1.5);
  scripts\engine\utility::flag_clear("transformation_complete");
  func_BEB6(level.neil);
}

func_BED6() {
  scripts\engine\utility::flag_wait("transformation_complete");
  level.neil vehicle_setspeedimmediate(0);
  level.neil stoploopsound();
  level.neil playSound("neil_mvmt_stop");
  scripts\engine\utility::flag_set("halt_neil");
  scripts\engine\utility::flag_set("transform");
  level.neil.upper_body playSound("n31l_challenge_pause");
}

func_BED7() {
  func_BEC4();
  wait(1);
  level.neil.upper_body playSound("n31l_challenge_reactivate");
  wait(4);
}

func_BED8() {
  func_BEDA();
  func_10779();
  func_BEBD(level.neil, &"CP_ZMB_INTERACTIONS_MISSING_FLOPPY");
  for(;;) {
    level.neil.var_13084 waittill("trigger", var_0);
    if(!var_0 scripts\cp\utility::is_valid_player() || !isDefined(level.var_BEC3)) {
      continue;
    }

    break;
  }

  var_1 = scripts\engine\utility::getstruct("neil_repair", "script_noteworthy");
  add_part_to_neil(var_1, var_0);
  level.var_13BD0 = level.wave_num;
  func_BEBC(level.neil);
  level func_BED9();
  scripts\cp\zombies\zombie_analytics::func_AF7C(level.var_13BCF, level.var_13BD0);
  level thread setspectatedefaults(100);
  scripts\engine\utility::flag_clear("halt_neil");
  scripts\engine\utility::flag_clear("transform");
  level.neil vehicle_setspeed(2, 1, 1);
  wait(1.5);
  scripts\engine\utility::flag_clear("transformation_complete");
  func_BEB6(level.neil);
}

func_BEDA() {
  scripts\engine\utility::flag_wait("transformation_complete");
  wait(2);
  func_BEDB(level.neil);
}

func_BEDB(var_0) {
  wait(1);
  level.neil vehicle_setspeedimmediate(0);
  level.neil stoploopsound();
  level.neil playSound("neil_mvmt_stop");
  scripts\engine\utility::flag_set("halt_neil");
  scripts\engine\utility::flag_set("transform");
  level.neil.upper_body playSound("n31l_challenge_pause");
}

func_BED9() {
  func_BEC4();
  wait(1);
  level.neil.upper_body playSound("n31l_upgrade");
  wait(3);
  level.neil.upper_body playSound("kitt_challenge_restart");
  wait(4);
}

func_BEBD(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    level notify("neil_enabled_changed");
    level.var_1C3F = undefined;
  }

  var_0.var_13084 makeusable();
  if(!isDefined(var_1)) {
    var_1 = &"CP_ZMB_CHALLENGES_USE_NEIL";
  }

  var_0.var_13084 sethintstring(var_1);
  var_0.var_13084 setuserange(90);
  var_0.var_13084 setusefov(180);
  if(!scripts\engine\utility::istrue(level.var_A6E1)) {
    var_0 setscriptablepartstate("light", "on");
  } else {
    var_0 setscriptablepartstate("light", "on_red");
    var_0.upper_body setscriptablepartstate("facefx", "kitt");
    var_0.upper_body func_BEDF("kitt");
  }

  var_0.var_6265 = 1;
  if(!isDefined(var_0.var_13084)) {}
}

func_BEBC(var_0) {
  var_0 setscriptablepartstate("light", "off");
  var_0.var_6265 = 0;
  if(!isDefined(var_0.var_13084)) {
    return;
  }

  var_0.var_13084 makeunusable();
}

func_BEE2(var_0) {
  foreach(var_2 in level.players) {
    var_2 playlocalsound("mp_intel_received");
  }

  level notify("challenge_started");
  var_4 = level.var_C1E1;
  var_5 = func_7895(var_4, var_0);
  level thread scripts\cp\cp_challenge::activate_new_challenge(var_5);
  return var_5;
}

func_BEB7(var_0, var_1, var_2, var_3) {
  if(var_1 == "challenge_force_complete") {
    level.challenge_data[var_0].success = 1;
  } else if(var_1 == "challenge_force_fail") {
    level.challenge_data[var_0].success = 0;
  }

  scripts\cp\cp_challenge::deactivate_current_challenge();
  if(var_1 == "challenge_deactivated" || var_1 == "challenge_force_complete" || var_1 == "challenge_force_fail") {
    if(var_3 != level.var_C1E1) {
      var_3 = level.var_C1E1;
      level thread setperk();
      level.var_6ACC = 0;
      level.neil.upper_body func_BEDF("happy");
      scripts\cp\cp_vo::remove_from_nag_vo("nag_no_challenge");
      return;
    }

    level.var_6ACD[level.var_6ACD.size] = var_0;
    level.var_6ACC++;
    if(level.var_6ACC >= 2) {
      foreach(var_5 in level.players) {
        var_5 thread scripts\cp\cp_vo::add_to_nag_vo("nag_no_challenge", "zmb_comment_vo", 60, 10, 6, 1);
      }
    }

    if(level.var_6ACC > 3) {
      level thread func_BEC0();
    }

    level.neil.upper_body func_BEDF("sad");
    return;
  }

  if(var_3 != level.var_C1E1) {
    var_3 = level.var_C1E1;
    level thread setperk();
    level.neil.upper_body func_BEDF("happy");
  }
}

func_BED1() {
  wait(5);
  level thread scripts\cp\cp_challenge::activate_new_challenge("next_challenge");
  var_0 = int(gettime() + 30000);
  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_intel_timer", var_0);
  }

  wait(1);
  var_4 = 5;
  setomnvar("zm_neil_progress", level.var_C1E1 / var_4);
  level.neil.upper_body func_BEDF("happy");
  if(getdvar("challenge_prep_time") != "") {
    wait(3);
  } else {
    wait(28);
  }

  level notify("next_challenge_starting");
  wait(1);
  if(scripts\engine\utility::flag("pause_challenges")) {
    foreach(var_2 in level.players) {
      var_2 setclientomnvar("zm_show_challenge", 10);
    }

    scripts\engine\utility::flag_waitopen("pause_challenges");
  }

  scripts\cp\cp_challenge::func_62C6();
  wait(5);
  if(scripts\engine\utility::flag("pause_challenges")) {
    foreach(var_2 in level.players) {
      var_2 setclientomnvar("zm_show_challenge", 10);
    }

    scripts\engine\utility::flag_waitopen("pause_challenges");
  }
}

func_BEB6(var_0) {
  level endon("game_ended");
  level.var_C1E1 = 0;
  var_1 = 5;
  setomnvar("zm_neil_progress", level.var_C1E1 / var_1);
  level.var_6ACD = [];
  level.var_3C12 = undefined;
  var_2 = [];
  switch (level.var_3C16) {
    case 0:
      var_2 = level.tier_1_challenges;
      break;

    case 1:
      var_2 = level.tier_2_challenges;
      break;

    case 2:
      var_2 = level.tier_3_challenges;
      break;
  }

  level.neil playSound("n31l_challenge_start");
  if(!isDefined(level.var_1C3F)) {
    level.neil thread func_1C5F();
  }

  for(;;) {
    var_3 = level.var_C1E1;
    var_4 = func_BEE2(var_2);
    var_5 = level scripts\engine\utility::waittill_any_return("challenge_deactivated", "challenge_timed_out", "challenge_force_complete", "challenge_force_fail");
    func_BEB7(var_4, var_5, var_0, var_3);
    level.var_3C12 = scripts\engine\utility::array_remove(level.var_3C12, var_4);
    var_1 = 5;
    if(level.var_C1E1 * level.var_3C16 + 1 >= var_1 * level.var_3C16 + 1) {
      break;
    }

    if(level.var_3C12.size <= 0) {
      if(isDefined(level.var_6ACD) && level.var_6ACD.size > 0) {
        level.var_3C12 = level.var_6ACD;
        level.var_6ACD = [];
      } else {
        break;
      }
    }

    func_BED1();
  }

  level.var_3C16++;
  setomnvar("zm_neil_progress", 1);
  func_BEB5(var_0);
}

func_BEB5(var_0) {
  level endon("game_ended");
  wait(5);
  var_1 = "iw7_erad_zm";
  var_2 = "cp_fullbody_synaptic_";
  foreach(var_4 in level.players) {
    var_4 setclientomnvar("zm_show_challenge", 5);
    level.current_zm_show_challenge = 5;
  }

  switch (level.var_3C16) {
    case 1:
      level thread func_BEB8(var_0, var_1, &"CP_ZMB_CHALLENGES_NEIL_3");
      break;

    case 2:
      level thread func_BEB8(var_0, "iw7_erad_zm+eradpap1", &"CP_ZMB_CHALLENGES_NEIL_3");
      break;

    case 3:
      level thread func_BEB8(var_0, "iw7_erad_zm+eradpap2", &"CP_ZMB_CHALLENGES_NEIL_3");
      break;
  }

  wait(3);
  level.neil.upper_body thread func_BECD("n31l_challenge_special_complete");
  foreach(var_4 in level.players) {
    var_4 setclientomnvar("zm_show_challenge", -1);
  }
}

func_BEB8(var_0, var_1, var_2) {
  func_BEBD(var_0, var_2);
  for(;;) {
    var_0.var_13084 waittill("trigger", var_3);
    if(!var_3 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    break;
  }

  func_BEBC(var_0);
  level.neil.upper_body thread func_BECD("n31l_challenge_success_generic_dj");
  level thread play_dj_vo_kitt_arrival(var_3);
  wait(5);
  if(isDefined(var_3)) {
    var_3 thread scripts\cp\cp_vo::try_to_play_vo("challenge_n31l_complete", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
  }

  level thread func_12636(var_0, var_1);
  level thread setspectatedefaults(100);
}

play_dj_vo_kitt_arrival(var_0) {
  level endon("game_ended");
  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_0.vo_system.vo_currently_playing)) {
    if(isDefined(var_0.vo_system.vo_currently_playing.alias)) {
      var_1 = strtok(var_0.vo_system.vo_currently_playing.alias, "_");
      if(var_1[0] == "dj") {
        level thread scripts\cp\cp_vo::try_to_play_vo("dj_sign_off_kitt", "zmb_dj_vo", "highest", 10, 1, 0, 0);
        return;
      }

      level thread scripts\cp\cp_vo::try_to_play_vo("dj_sign_off_kitt", "zmb_dj_vo", "highest", 10, 0, 0, 0);
      return;
    }

    level thread scripts\cp\cp_vo::try_to_play_vo("dj_sign_off_kitt", "zmb_dj_vo", "highest", 10, 0, 0, 0);
    return;
  }

  level thread scripts\cp\cp_vo::try_to_play_vo("dj_sign_off_kitt", "zmb_dj_vo", "highest", 10, 0, 0, 0);
}

func_5559(var_0) {
  func_BEBC(level.neil);
  scripts\engine\utility::flag_clear("transformation_complete");
  level.var_1C3F = undefined;
  level.neil vehicle_setspeedimmediate(0);
  level.neil stoploopsound();
  level.neil playSound("neil_mvmt_stop");
  scripts\engine\utility::flag_set("transform");
  scripts\engine\utility::flag_set("halt_neil");
  level.neil notify("neil_quiet");
  if(!scripts\engine\utility::istrue(var_0)) {
    return;
  }

  level.neil.upper_body setModel("robot_kevin_upper_invisi");
  level.neil setModel("robot_kevin_lower_invisi");
}

func_106EF(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level.neil;
  }

  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1.upper_body = spawn("script_model", var_0.origin);
  var_1.upper_body.angles = var_1.angles;
  var_1 setModel(level.var_BEB1);
  var_1.upper_body setModel(level.var_BEB2);
  var_1.upper_body linkto(var_1);
  var_1 setnonstick(1);
  var_1.upper_body setnonstick(1);
  var_1 setscriptablepartstate("thrusters", "liftoff");
  if(scripts\engine\utility::istrue(level.var_A6E1)) {
    var_1.upper_body func_BEDF("kitt");
    var_1.upper_body setscriptablepartstate("facefx", "kitt");
  } else {
    var_1.upper_body func_BEDF("happy");
  }

  return var_1;
}

func_13631() {
  while(level.dj.current_state != "idle") {
    wait(1);
  }

  level.the_hoff = spawnStruct();
  level.the_hoff.origin = (0, 0, 0);
  for(;;) {
    if(level.dj.current_state != "close_window") {
      scripts\cp\maps\cp_zmb\cp_zmb_dj::set_dj_state("close_window");
    }

    wait(1);
    if(level.dj.current_state == "close_window") {
      break;
    }
  }

  level.dj waittill("window_closed");
  level notify("stop_dj_manager");
  scripts\cp\maps\cp_zmb\cp_zmb_dj::setup_dj_doors();
  level.dj hide();
}

func_54FB() {
  var_0 = scripts\engine\utility::getstructarray("dj_quest_door", "script_noteworthy");
  foreach(var_2 in var_0) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
  }

  level.disable_broadcast = 1;
}

func_61CF() {
  var_0 = scripts\engine\utility::getstructarray("dj_quest_door", "script_noteworthy");
  foreach(var_2 in var_0) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_2);
  }
}

func_12636(var_0, var_1) {
  func_54FB();
  func_5559(1);
  level.neil vehicle_teleport(level.neil.origin, level.neil.angles);
  if(scripts\engine\utility::istrue(level.var_A6E1)) {
    level.neil.upper_body setscriptablepartstate("facefx", "off");
  }

  var_2 = func_106EF(level.neil);
  scripts\engine\utility::flag_set("landing_zone_active");
  var_2 playSound("neil_upgrade_rocket_launch_takeoff");
  level thread func_A82C();
  var_2 movez(2000, 3, 2, 1);
  var_2 waittill("movedone");
  playFX(level._effect["neil_flash"], var_2.origin);
  if(!scripts\engine\utility::istrue(level.var_A6E1)) {
    var_2 setModel("robot_kevin_black_lower");
    var_2.upper_body setModel("robot_kevin_black_upper");
    var_2.upper_body func_BEDF("kitt");
    var_2.upper_body setscriptablepartstate("facefx", "kitt");
  }

  var_2 notsolid();
  var_2.upper_body notsolid();
  var_3 = var_2.origin;
  var_2 hide();
  var_2.upper_body hide();
  func_13631();
  if(isDefined(level.force_song_func)) {
    if(!isDefined(level.forced_songs["knight_rider"])) {
      level thread[[level.force_song_func]](undefined, "mus_pa_sp_knightrider", undefined, undefined, undefined, "knight_rider");
    }
  }

  scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(1);
  level.the_hoff = func_107F0(var_1, var_2);
  level.the_hoff setorigin(var_2.origin, 0);
  level.the_hoff.angles = var_2.angles;
  level.the_hoff hide(1);
  wait(0.5);
  level.the_hoff linkto(var_2);
  level.the_hoff playerlinkedoffsetenable();
  var_2.upper_body thread func_A6E2();
  var_2 playSound("neil_upgrade_rocket_launch_land");
  playFX(level._effect["neil_flash"], var_3);
  wait(0.75);
  var_2 show();
  var_2.upper_body show();
  var_2.upper_body func_BEDF("kitt");
  var_2.upper_body setscriptablepartstate("facefx", "kitt");
  var_2 setscriptablepartstate("thrusters", "liftoff");
  level.the_hoff show();
  level.the_hoff takeallweapons();
  level.the_hoff_revive = 1;
  func_1176C(var_2);
  level.the_hoff.precacheleaderboards = 0;
  level.the_hoff.scripted_mode = 0;
  level.the_hoff thread func_1176D();
  var_4 = 120 + 60 * level.var_3C16;
  level.the_hoff scripts\engine\utility::waittill_any_timeout_1(var_4, "death");
  level.the_hoff_revive = undefined;
  level notify("hoff_death");
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    if(!isalive(level.players[0]) || scripts\engine\utility::istrue(level.players[0].inlaststand)) {
      level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
    }
  }

  if(isDefined(level.the_hoff) && isalive(level.the_hoff)) {
    level.the_hoff playSound("dj_kitt_notify_departure");
    func_5559(0);
    level.the_hoff notify("timetogo");
    var_5 = getclosestpointonnavmesh(level.neil.origin + scripts\cp\utility::vec_multiply(anglesToForward(level.neil.angles), 52) + scripts\cp\utility::vec_multiply(anglestoleft(level.neil.angles), 11));
    level.the_hoff.scripted_mode = 1;
    level.the_hoff scripts\mp\agents\c6\c6_agent::func_F835(var_5, 6);
    level.the_hoff.disablearrivals = 1;
    level.the_hoff.precacheleaderboards = 1;
    level.the_hoff scripts\engine\utility::waittill_any_timeout_1(150, "scriptedGoal_reached");
    level.neil.upper_body scriptmodelplayanim("IW7_cp_zom_n31l_intro_enter", 1);
    wait(0.75);
    level.neil.upper_body thread func_A6E2();
    level.the_hoff.var_FFF3 = 1;
    level.the_hoff setorigin(level.neil.origin + scripts\cp\utility::vec_multiply(anglesToForward(level.neil.angles), 52) + scripts\cp\utility::vec_multiply(anglestoleft(level.neil.angles), 11), 0);
    wait(7);
    level.the_hoff takeallweapons();
    destroynavrepulsor("neil");
    level.neil.upper_body setModel("robot_kevin_upper_invisi");
    level.neil setModel("robot_kevin_lower_invisi");
    level.neil.upper_body setscriptablepartstate("facefx", "off");
    level.neil.upper_body notify("start_intro");
    level.neil.upper_body scriptmodelclearanim();
    var_2 = func_106EF(level.neil);
    var_2.upper_body thread func_A6E2();
    level.the_hoff linkto(var_2);
    level.the_hoff playerlinkedoffsetenable();
    scripts\engine\utility::flag_set("landing_zone_active");
    level thread func_A82C();
    var_2 playSound("neil_upgrade_rocket_launch_takeoff_hoff_exit");
    level.the_hoff playSound("dj_kitt_departure");
    wait(3);
    var_2 notsolid();
    var_2.upper_body notsolid();
    var_2 movez(2000, 3, 2, 1);
    var_2 waittill("movedone");
    var_2.upper_body setscriptablepartstate("facefx", "kitt");
    playFX(level._effect["neil_flash"], var_2.origin);
    level.the_hoff.nocorpse = 1;
    level.the_hoff unlink();
    level.the_hoff suicide();
    var_2 playSound("neil_upgrade_rocket_launch_land");
    var_6 = level.neil.origin;
    var_2 movez(-2000, 6, 4, 2);
    wait(3);
    createnavrepulsor("neil", 0, level.neil, 20, 1);
    level.neil setscriptablepartstate("landing", "on");
    wait(3);
    scripts\engine\utility::flag_clear("landing_zone_active");
    level.neil setModel(level.var_BEB1);
    level.neil.upper_body setModel(level.var_BEB2);
    level.neil.upper_body func_BEDF("kitt");
    level.neil.upper_body setscriptablepartstate("facefx", "kitt");
    var_2.upper_body delete();
    var_2 delete();
    scripts\engine\utility::flag_clear("halt_neil");
    scripts\engine\utility::flag_clear("transform");
  }

  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(1);
  level.the_hoff = undefined;
  wait(5);
  scripts\cp\maps\cp_zmb\cp_zmb_dj::setup_dj_doors();
  level.dj.current_state = undefined;
  level thread scripts\cp\maps\cp_zmb\cp_zmb_dj::dj_state_manager();
  level.dj show();
  level.disable_broadcast = undefined;
  scripts\cp\maps\cp_zmb\cp_zmb_dj::set_dj_state("open_window");
  scripts\engine\utility::flag_set("transformation_complete");
  func_61CF();
}

func_A6E2() {
  self endon("start_intro");
  self endon("death");
  for(;;) {
    self scriptmodelplayanim("IW7_cp_zom_n31l_intro_loop", 1);
    wait(1.3);
  }
}

func_1176C(var_0) {
  var_1 = var_0.origin + (0, 0, -2000);
  var_0 movez(-2000, 6, 4, 2);
  wait(3);
  level.neil setscriptablepartstate("landing", "on");
  wait(2);
  level.the_hoff.var_FFEF = undefined;
  level.the_hoff scripts\asm\asm::asm_fireevent("introloop", "introdone");
  wait(1);
  level.the_hoff scripts\mp\mp_agent::func_FAFA("iw7_erad_zm");
  stopFXOnTag(level._effect["neil_trail"], var_0, "tag_origin");
  scripts\engine\utility::flag_clear("landing_zone_active");
  level.the_hoff unlink();
  level.neil setModel(level.var_BEB1);
  level.neil.upper_body setModel(level.var_BEB2);
  level.neil.upper_body func_BEDF("kitt");
  level.neil.upper_body thread func_A6E2();
  var_0.upper_body delete();
  var_0 delete();
  level.neil vehicle_teleport(level.neil.origin, level.neil.angles);
  level.neil.upper_body setscriptablepartstate("facefx", "kitt");
  level.the_hoff.died_poorly = 1;
  wait(4);
  level.neil.upper_body notify("start_intro");
  level.neil.upper_body scriptmodelplayanim("IW7_cp_zom_n31l_intro_exit", 1);
  wait(1);
  level.the_hoff playSound("dj_kitt_arrival");
  wait(4);
  scripts\engine\utility::flag_clear("halt_neil");
  scripts\engine\utility::flag_clear("transform");
}

func_107F0(var_0, var_1) {
  func_F447();
  level.var_A6E1 = 1;
  var_2 = undefined;
  while(!isDefined(var_2)) {
    var_2 = scripts\cp\zombies\zombies_spawning::func_33B1("the_hoff", var_1.origin, var_1.angles, "allies", undefined, var_0);
    if(!isDefined(var_2)) {
      wait(0.2);
      continue;
    }
  }

  var_2.a.rockets = 5;
  var_2.health = 1000 * level.var_3C16;
  var_2.maxhealth = 1000 * level.var_3C16;
  var_2.allowpain = 0;
  var_2.ignoreme = 1;
  var_2.precacheleaderboards = 1;
  var_2.scripted_mode = 1;
  var_2.can_revive = 1;
  var_2.var_FFEF = 1;
  foreach(var_4 in level.players) {
    var_4 notify("hoff_spawned");
  }

  return var_2;
}

func_1176D() {
  self endon("death");
  self endon("timetogo");
  self ghostskulls_total_waves(48);
  self.footstepdetectdist = 1500;
  for(;;) {
    func_1176B();
    func_1176F();
    wait(1);
  }
}

func_1176F() {
  if(!isDefined(self.isnodeoccupied)) {
    func_83FF();
    return;
  }

  if(self getpersstat(self.isnodeoccupied)) {
    self.scripted_mode = 0;
    return;
  }

  func_83FF();
}

func_1176B() {
  var_0 = func_78C4();
  if(isDefined(var_0)) {
    physics_getbodyid(var_0);
    self.scripted_mode = 0;
    if(isalive(self)) {
      self.precacheleaderboards = 0;
      scripts\mp\agents\c6\c6_agent::func_41D9();
      self.disablearrivals = 0;
    }
  }
}

physics_getbodyid(var_0) {
  var_0 endon("death");
  var_0 endon("reviving");
  var_0 endon("revive");
  var_0 endon("disconnect");
  self endon("death");
  self endon("timetogo");
  scripts\mp\agents\c6\c6_agent::func_41D9();
  if(distancesquared(self.origin, var_0.origin) > 16000000) {
    return;
  }

  self.scripted_mode = 1;
  scripts\mp\agents\c6\c6_agent::func_F832(var_0, 48, 0);
  self.disablearrivals = 1;
  self.precacheleaderboards = 1;
  self waittill("scriptedGoal_reached");
  self.disablearrivals = 0;
  self.precacheleaderboards = 0;
  if(!isDefined(var_0.reviveent)) {
    return;
  }

  var_0.reviveent notify("trigger", self);
  wait(4);
}

func_83FF() {
  var_0 = scripts\cp\utility::get_array_of_valid_players(1, self.origin);
  var_1 = scripts\engine\utility::getclosest(self.origin, var_0);
  if(!isDefined(var_1)) {
    return;
  }

  var_2 = var_1.origin - self.origin;
  var_3 = length2dsquared(var_2);
  if(var_3 < -3036) {
    return;
  }

  var_4 = gettime();
  if(isDefined(self.var_A8EF) && var_4 - self.var_A8EF < 500) {
    return;
  }

  self.var_A8EF = var_4;
  var_5 = vectornormalize(var_2);
  var_6 = var_1.origin - var_5 * 128;
  var_7 = getclosestpointonnavmesh(var_6, self);
  scripts\mp\agents\c6\c6_agent::func_F834(1, 120);
  scripts\mp\agents\c6\c6_agent::func_F835(var_7, 2);
  self.var_3320 = 1;
}

func_78C4() {
  var_0 = sortbydistance(level.players, self.origin);
  foreach(var_2 in var_0) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2) && !scripts\engine\utility::istrue(var_2.is_being_revived) && !scripts\engine\utility::istrue(var_2.in_afterlife_arcade)) {
      return var_2;
    }
  }

  return undefined;
}

func_A82C() {
  wait(0.1);
  level.neil setscriptablepartstate("lingerfx", "on");
  level thread func_A56E(level.neil.origin);
  while(scripts\engine\utility::flag("landing_zone_active")) {
    wait(0.1);
  }

  level.neil setscriptablepartstate("landing", "off");
  level.neil setscriptablepartstate("lingerfx", "off");
}

func_A56E(var_0) {
  var_1 = spawn("trigger_radius", var_0, 0, 40, 72);
  level thread func_51CE(var_1);
  while(scripts\engine\utility::flag("landing_zone_active")) {
    var_1 waittill("trigger", var_2);
    if(isDefined(level.the_hoff) && var_2 == level.the_hoff) {
      continue;
    }

    if(isDefined(var_2.padding_damage)) {
      continue;
    }

    if(!scripts\engine\utility::flag("landing_zone_active")) {
      continue;
    }

    if(isplayer(var_2)) {
      var_2 dodamage(5, var_0);
      var_2.padding_damage = 1;
      var_2 setvelocity(vectornormalize(var_2.origin - var_0) * 100);
      var_2 thread remove_padding_damage();
      continue;
    }

    if(scripts\cp\utility::should_be_affected_by_trap(var_2)) {
      var_2.nocorpse = 1;
      var_2.full_gib = 1;
      var_2 dodamage(var_2.health + 100, var_0);
    }
  }

  var_1 delete();
}

func_51CE(var_0) {
  var_0 endon("death");
  while(isDefined(var_0)) {
    var_1 = getEntArray("placed_transponder", "script_noteworthy");
    foreach(var_3 in var_1) {
      if(!isDefined(var_0)) {
        break;
      }

      if(var_3 istouching(var_0)) {
        if(isDefined(var_3.triggerportableradarping) && var_3.triggerportableradarping scripts\cp\utility::is_valid_player(1)) {
          var_3.triggerportableradarping playlocalsound("ww_magicbox_laughter");
        }

        var_3 notify("detonateExplosive");
      }
    }

    wait(0.25);
  }
}

remove_padding_damage() {
  self endon("disconnect");
  wait(0.25);
  self.padding_damage = undefined;
}

func_7895(var_0, var_1) {
  if(!isDefined(level.var_3C12)) {
    level.var_3C12 = var_1;
  }

  var_2 = undefined;
  if(level.players.size > 1) {
    var_2 = scripts\engine\utility::random(level.var_3C12);
  } else {
    for(;;) {
      if(level.var_3C12.size == 0) {
        level.var_3C12 = level.var_6ACD;
      }

      var_2 = scripts\engine\utility::random(level.var_3C12);
      if(!level.challenge_data[var_2].var_1C8C) {
        level.var_3C12 = scripts\engine\utility::array_remove(level.var_3C12, var_2);
        wait(0.05);
        continue;
      } else {
        break;
      }
    }
  }

  return var_2;
}

setperk() {
  wait(3);
  foreach(var_1 in level.players) {
    scripts\engine\utility::waitframe();
  }

  wait(1);
  level thread setspeakermapmonotostereo(25 + level.wave_num * 5);
  level thread setspectatedefaults(100);
}

func_BEE1(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  var_4 = (0, 0, 0);
  if(isDefined(var_0.angles)) {
    var_4 = var_0.angles;
  }

  var_5 = spawnvehicle(var_2, "neil", "cp_kevin", var_0.origin + var_1, var_4);
  var_5.var_13084 = getent("neil_usetrig", "targetname");
  var_5.var_13084.origin = var_5.origin + (0, 0, 60);
  var_5.var_13084 linkto(var_5);
  var_5 setCanDamage(0);
  if(scripts\engine\utility::istrue(var_3)) {
    var_5.is_neil = 1;
    var_5.upper_body = spawn("script_model", var_5.origin);
    var_5.upper_body.angles = var_5.angles;
    var_5.upper_body setModel(level.var_BEB2);
    var_5.upper_body linkto(var_5);
  }

  return var_5;
}

func_F999(var_0) {
  level.neil = func_BEE1(var_0, undefined, level.var_8C89);
  level.neil attachpath(var_0);
  level.var_BEDC = spawnfx(level._effect["neil_repair_sparks"], level.neil gettagorigin("tag_fx"));
  wait(1);
  triggerfx(level.var_BEDC);
  level.neil setvehicleteam("allies");
  level.neil.var_13084 makeunusable();
  level thread func_BEDE(level.neil);
}

func_BEDE(var_0) {
  level endon("stop_repair_sounds");
  wait(1);
}

func_BECC(var_0) {
  wait(1);
  func_BEC4();
}

func_BECD(var_0) {
  if(!isDefined(var_0) || isDefined(level.var_BEE3)) {
    return;
  }

  level.var_BEE3 = 1;
  if(!isDefined(level.neil.var_101F6)) {
    level.neil.var_101F6 = gettime() + 5000;
  } else if(level.neil.var_101F6 >= gettime()) {
    level.var_BEE3 = undefined;
    return;
  }

  level.neil.var_101F6 = gettime() + 5000;
  var_1 = lookupsoundlength(var_0);
  if(soundexists(var_0)) {
    self playSound(var_0);
  }

  thread func_BEBF(var_1);
  wait(var_1 / 1000);
  level.var_BEE3 = undefined;
}

func_11025() {
  self endon("death");
  wait(3);
  var_0 = 6400;
  for(;;) {
    if(!func_203C(self.origin, var_0) || isDefined(self.var_1E8F) || scripts\engine\utility::flag("transform")) {
      wait(0.25);
      continue;
    }

    self stoploopsound();
    self playSound("neil_mvmt_stop");
    self vehicle_setspeedimmediate(0);
    scripts\engine\utility::flag_set("halt_neil");
    self setscriptablepartstate("smoketrail", "off");
    self.upper_body scriptmodelclearanim();
    self.upper_body scriptmodelplayanim("IW7_cp_zom_n31l_halt", 1);
    if(!isDefined(self.var_118E0)) {
      self.var_118E0 = gettime() + 30000;
      self.upper_body thread func_BECD("n31l_spawn_assembly");
    } else if(self.var_118E0 <= gettime()) {
      self.var_118E0 = gettime() + 30000;
      self.upper_body thread func_BECD("n31l_spawn_assembly");
    }

    while(func_203C(self.origin, var_0) || scripts\engine\utility::flag("transform")) {
      wait(0.5);
    }

    self playSound("neil_mvmt_start");
    self playLoopSound("neil_mvmt_lp");
    self vehicle_setspeed(2, 1, 1);
    scripts\engine\utility::flag_clear("halt_neil");
    self.upper_body func_BEDF("happy_line");
    self setscriptablepartstate("smoketrail", "on");
  }
}

func_BEBF(var_0) {
  self endon("neil_quiet");
  self endon("death");
  var_1 = gettime();
  var_2 = var_1 + var_0;
  var_3 = gettime();
  while(var_3 <= var_2) {
    if(isDefined(self.var_1E8F)) {
      wait(0.5);
      continue;
    }

    var_3 = gettime();
    func_BEDF(scripts\engine\utility::random(["oface", "happy_line", "happy"]));
    wait(0.75);
  }
}

func_BEDF(var_0) {
  if(isDefined(level.var_A6E1)) {
    var_0 = "kitt";
  }

  switch (var_0) {
    case "happy":
      self setscriptablepartstate("happy", "show");
      break;

    case "sad":
      self setscriptablepartstate("sad", "show");
      break;

    case "angry":
      self setscriptablepartstate("angry", "show");
      break;

    case "oface":
      self setscriptablepartstate("oface", "show");
      break;

    case "happy_line":
      self setscriptablepartstate("happy_line", "show");
      break;

    case "angry_line":
      self setscriptablepartstate("angry_line", "show");
      break;

    case "kitt":
      self setscriptablepartstate("kitt", "show");
      break;
  }
}

func_203C(var_0, var_1) {
  var_2 = 0;
  foreach(var_4 in level.players) {
    if(var_4 scripts\cp\utility::is_valid_player() && distancesquared(var_4.origin, var_0) < var_1) {
      return 1;
    }
  }

  return 0;
}

pickup_head(var_0, var_1) {
  var_1 playlocalsound("neil_part_pickup");
  playFX(level._effect["souvenir_pickup"], var_0.var_BEC5.origin);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_0.var_BEC5 delete();
  level.var_BEC7 = 1;
  level scripts\cp\utility::set_quest_icon(7);
  level.var_13BD1 = level.wave_num;
  if(randomint(100) > 90) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("collect_n31l", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
  } else {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_n31l_find_head", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
  }

  level thread func_CDA9(var_1);
}

func_CDA9(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  var_0 thread scripts\cp\cp_vo::add_to_nag_vo("nag_return_n31lpart", "zmb_comment_vo", 60, 60, 3, 1);
  wait(4);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_N3il_construction", "zmb_ww_vo", "highest", 60, 0, 0, 1);
  wait(1);
  level thread scripts\cp\cp_vo::add_to_nag_vo("dj_n3il_part_recovered_nag", "zmb_dj_vo", 60, 120, 3, 1);
}

pickup_battery(var_0, var_1) {
  var_1 playlocalsound("neil_part_pickup");
  playFX(level._effect["souvenir_pickup"], var_0.part.origin);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_0.part delete();
  level.var_13BCD = level.wave_num;
  if(randomint(100) > 90) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("collect_n31l", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
  } else {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_n31l_find_battery", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
  }

  level.var_BEB0 = 1;
  level scripts\cp\utility::set_quest_icon(8);
  level.neil.var_13084 sethintstring(&"CP_ZMB_INTERACTIONS_LOAD_BATTERY");
}

pickup_firmware(var_0, var_1) {
  var_1 playlocalsound("neil_part_pickup");
  playFX(level._effect["souvenir_pickup"], var_0.part.origin);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_0.part delete();
  level.var_13BCF = level.wave_num;
  if(randomint(100) > 90) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("collect_n31l", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
  } else {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_n31l_find_disc", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
  }

  level.var_BEC3 = 1;
  level scripts\cp\utility::set_quest_icon(9);
  level.neil.var_13084 sethintstring(&"CP_ZMB_INTERACTIONS_LOAD_FLOPPY");
}

func_9696(var_0) {
  var_1 = scripts\engine\utility::getstructarray("neil_battery", "script_noteworthy");
  foreach(var_3 in var_1) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_3);
  }
}

func_10778(var_0) {
  var_1 = func_1077B("neil_battery", "space_interior_power_adapter");
  level.var_BEAE = var_1.var_9A3E;
}

func_9697(var_0) {
  var_1 = scripts\engine\utility::getstructarray("neil_firmware", "script_noteworthy");
  foreach(var_3 in var_1) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_3);
  }
}

func_10779() {
  var_0 = func_1077B("neil_firmware", "zmb_n31l_robot_minifloppy");
  level.var_BEC1 = var_0.var_9A3E;
}

func_1077B(var_0, var_1) {
  var_2 = scripts\engine\utility::getstructarray(var_0, "script_noteworthy");
  var_3 = scripts\engine\utility::random(var_2);
  foreach(var_5 in var_2) {
    if(var_5 == var_3) {
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_5);
      break;
    }
  }

  var_7 = scripts\engine\utility::getstruct(var_3.target, "targetname");
  var_8 = spawn("script_model", var_7.origin);
  if(isDefined(var_7.angles)) {
    var_8.angles = var_7.angles;
  }

  var_3.part = var_8;
  var_8.var_9A3E = var_3;
  var_8 setModel(var_1);
  var_8 notsolid();
  return var_8;
}

func_1077A() {
  var_0 = scripts\engine\utility::getstruct("neil_head", "script_noteworthy");
  var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_2 = spawn("script_model", var_1.origin);
  var_2.angles = var_1.angles;
  var_2 setModel(level.var_BEC8);
  var_2 notsolid();
  scripts\engine\utility::waitframe();
  var_0.var_BEC5 = var_2;
  wait(1);
  level.var_BEC5 = var_0;
}

func_BE86() {
  self endon("disconnect");
  self forceusehinton(&"COOP_INTERACTIONS_NEED_MONEY");
  wait(1);
  self getrigindexfromarchetyperef();
}

func_1176E() {
  for(;;) {
    scripts\engine\utility::flag_wait("transformation_complete");
    func_BEAC();
    level.neil vehicle_teleport(level.neil.origin, level.neil.angles);
    level.neil vehicle_setspeed(2, 1, 1);
    for(;;) {
      level.neil.var_13084 waittill("trigger", var_0);
      if(!var_0 scripts\cp\utility::is_valid_player() || isDefined(level.neil.cooldown)) {
        continue;
      }

      if(!var_0 scripts\cp\cp_persistence::player_has_enough_currency(5000)) {
        if(soundexists("purchase_deny")) {
          var_0 playlocalsound("purchase_deny");
        }

        var_0 thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 3, 0, 0, 1);
        var_0 thread func_BE86();
        continue;
      } else {
        var_0 scripts\cp\cp_persistence::take_player_currency(5000, 1, "trap");
      }

      break;
    }

    level.neil.var_13084 makeunusable();
    level.neil.upper_body thread func_BECD("n31l_challenge_success_generic_dj");
    wait(3);
    level.neil notify("neil_quiet");
    func_12636(level.neil, "iw7_erad_zm+eradpap2");
  }
}

func_BEAC() {
  stopFXOnTag(level.var_BECF, level.neil, "tag_fx");
  level.neil.var_6265 = 0;
  level.neil.cooldown = 1;
  level.neil.var_13084 makeusable();
  level.neil.var_13084 sethintstring(&"CP_ZMB_CHALLENGES_REBOOTING");
  var_0 = 120;
  wait(var_0);
  level.neil.var_13084 setuserange(90);
  level.neil.var_13084 setusefov(180);
  func_BEBD(level.neil, &"CP_ZMB_CHALLENGES_BUY_NEIL");
  level.neil.cooldown = undefined;
}

func_DB29(var_0) {
  self startpath();
  self vehicle_setspeed(2, 1, 1);
  thread func_BED0(var_0);
}

func_BED0(var_0) {
  self endon("death");
  thread func_BEE4();
  thread func_BEBA();
  thread func_BECE();
  thread func_11025();
  self setscriptablepartstate("smoketrail", "on");
  for(;;) {
    self waittill("reached_end_node");
    self startpath(var_0);
    while(scripts\engine\utility::flag("transform")) {
      wait(1);
    }
  }
}

func_BEE4() {
  self endon("death");
  self stoploopsound();
  self playSound("neil_mvmt_start");
  self playLoopSound("neil_mvmt_lp");
  for(;;) {
    for(var_0 = 0; scripts\engine\utility::flag("transform") || scripts\engine\utility::flag("halt_neil"); var_0 = 0) {
      wait(0.1);
    }

    while(isDefined(self.unloadalltransients)) {
      wait(0.1);
      var_0 = 0;
    }

    if(var_0 == 0) {
      self.upper_body scriptmodelclearanim();
      self.upper_body scriptmodelplayanim("IW7_cp_zom_n31l_walk", 1);
    }

    wait(0.1);
    var_0 = var_0 + 1;
    if(var_0 >= 70) {
      var_0 = 0;
    }
  }
}

func_BEBA() {
  self endon("death");
  self.upper_body setCanDamage(1);
  self.upper_body.health = 1000000;
  for(;;) {
    while(scripts\engine\utility::flag("transform")) {
      wait(1);
    }

    self.upper_body waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    self.upper_body playSound("neil_impact");
    self.upper_body scriptmodelclearanim();
    self.upper_body scriptmodelplayanim("IW7_cp_zom_n31l_hit", 1);
    self.upper_body.health = 1000000;
    scripts\engine\utility::waitframe();
    self.upper_body playSound("neil_emote_angry_face");
    self.upper_body func_BEDF(scripts\engine\utility::random(["angry", "angry_line"]));
    self.upper_body thread func_E493();
    self.unloadalltransients = 1;
    wait(0.5);
    self.unloadalltransients = undefined;
  }
}

func_E493() {
  self endon("death");
  self endon("transform");
  self endon("damage");
  self.var_1E8F = 1;
  wait(2);
  self.var_1E8F = undefined;
  func_BEDF("happy_line");
}

func_4EFA() {
  var_0 = scripts\engine\utility::getstruct("neil_repair", "script_noteworthy");
  if(isDefined(level.var_BEC5.var_BEC5)) {
    pickup_head(level.var_BEC5, level.players[0]);
    wait(1);
    add_part_to_neil(var_0, level.players[0]);
    return;
  } else if(isDefined(level.var_BEAE) && isDefined(level.var_BEAE.part)) {
    pickup_battery(level.var_BEAE, level.players[0]);
  } else if(isDefined(level.var_BEC1) && isDefined(level.var_BEC1.part)) {
    pickup_firmware(level.var_BEC1, level.players[0]);
  }

  wait(0.5);
  level.neil.var_13084 notify("trigger", level.players[0]);
  wait(1);
  add_part_to_neil(var_0, level.players[0]);
}

neil_repair_hintstring_logic(var_0, var_1) {
  if(isDefined(level.var_BEC7)) {
    return &"CP_ZMB_INTERACTIONS_ATTACH_HEAD";
  }

  if(isDefined(level.var_BEB0)) {
    return &"CP_ZMB_INTERACTIONS_LOAD_BATTERY";
  }

  if(isDefined(level.var_BEC3)) {
    return &"CP_ZMB_INTERACTIONS_LOAD_FLOPPY";
  }

  if(!isDefined(level.var_BEC7)) {
    return &"CP_ZMB_INTERACTIONS_MISSING_HEAD";
  }

  return &"CP_ZMB_INTERACTIONS_REPAR_NEIL";
}

add_part_to_neil(var_0, var_1) {
  if(isDefined(level.var_BEC7)) {
    var_1 playlocalsound("neil_part_place");
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("challenge_n31l_head", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("part_assemble_n31l", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
    level thread scripts\cp\cp_vo::remove_from_nag_vo("dj_n3il_part_recovered_nag");
    level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_return_n31lpart");
    level.var_BEDC delete();
    level notify("stop_repair_sounds");
    level.neil setModel(level.var_74B8);
    level.neil_head_added = 1;
    level.var_BEC7 = undefined;
    var_1 thread scripts\cp\cp_hud_message::tutorial_lookup_func("quest_neil");
    scripts\engine\utility::flag_set("neil_head_attached");
    var_2 = getent("neil_repair_clip", "targetname");
    var_2 connectpaths();
    var_2 delete();
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  } else if(isDefined(level.var_BEB0)) {
    var_1 playlocalsound("neil_part_place");
    level.var_BEAF = 1;
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("challenge_n31l_battery", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
    scripts\engine\utility::flag_set("neil_battery_attached");
    level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_return_n31lpart");
    level.var_BEB0 = undefined;
  } else if(isDefined(level.var_BEC3)) {
    var_1 playlocalsound("neil_part_place");
    level.var_BEC2 = 1;
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("challenge_n31l_disk", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
    level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_return_n31lpart");
    scripts\engine\utility::flag_set("neil_firmware_attached");
    level.var_BEC3 = undefined;
  }

  if(isDefined(var_1)) {
    var_1 scripts\cp\cp_interaction::refresh_interaction();
  }
}

setspectatedefaults(var_0) {
  foreach(var_2 in level.players) {
    var_2 scripts\cp\cp_persistence::give_player_xp(var_0, 1);
    wait(0.05);
  }
}

func_BEC4() {
  wait(0.5);
  level thread setspeakermapmonotostereo(25);
}

setspeakermapmonotostereo(var_0) {
  foreach(var_2 in level.players) {
    var_2 scripts\cp\zombies\arcade_game_utility::give_player_tickets(var_2, var_0);
    wait(0.05);
  }
}

func_1C5F() {
  level.neil endon("death");
  level.neil endon("transform");
  level endon("failed_too_many_times");
  level endon("neil_enabled_changed");
  level.var_1C3F = 1;
  for(;;) {
    func_BEBD(level.neil, &"CP_ZMB_INTERACTIONS_PAUSE_CHALLENGES", 1);
    for(;;) {
      level.neil.var_13084 waittill("trigger", var_0);
      if(!var_0 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      break;
    }

    func_BEBC(level.neil);
    scripts\engine\utility::flag_set("pause_challenges");
    level thread scripts\cp\cp_challenge::func_C9B9();
    level.neil.upper_body thread func_BECD("n31l_spawn_assembly");
    wait(5);
    func_BEBD(level.neil, &"CP_ZMB_CHALLENGES_RESUME_CHALLENGE", 1);
    for(;;) {
      level.neil.var_13084 waittill("trigger", var_0);
      if(!var_0 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      break;
    }

    func_BEBC(level.neil);
    level.neil.upper_body thread func_BECD("n31l_challenge_reactivate");
    scripts\engine\utility::flag_clear("pause_challenges");
    foreach(var_0 in level.players) {
      var_0 setclientomnvar("zm_show_challenge", 11);
    }

    wait(5);
  }
}

func_BEC0() {
  level notify("failed_too_many_times");
  scripts\engine\utility::flag_set("pause_challenges");
  level waittill("next_challenge_starting");
  level.var_1C3F = undefined;
  func_BEBD(level.neil, &"CP_ZMB_CHALLENGES_RESUME_CHALLENGE");
  for(;;) {
    level.neil.var_13084 waittill("trigger", var_0);
    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    break;
  }

  func_BEBC(level.neil);
  scripts\engine\utility::flag_clear("pause_challenges");
  level.var_6ACC = 0;
  level.neil.upper_body thread func_BECD("n31l_spawn_assembly");
  wait(6);
  func_BEBD(level.neil, &"CP_ZMB_INTERACTIONS_PAUSE_CHALLENGES");
  if(!isDefined(level.var_1C3F)) {
    level.neil thread func_1C5F();
  }
}

func_BECE() {
  self endon("death");
  var_0 = 1225;
  var_1 = 4096;
  for(;;) {
    while(scripts\engine\utility::flag("transform")) {
      wait(1);
    }

    var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_2 = sortbydistance(var_2, self.origin);
    var_3 = var_2[0];
    var_4 = getEntArray("placed_transponder", "script_noteworthy");
    if(!isDefined(var_3) && var_4.size == 0) {
      wait(0.1);
      continue;
    }

    if(isDefined(var_3)) {
      if(distance2dsquared(self.origin, var_3.origin) < var_0 && scripts\engine\utility::istrue(var_3.is_dancing) || scripts\engine\utility::istrue(var_3.isfrozen)) {
        var_3 dodamage(var_3.health + 100, self.origin);
      }
    }

    foreach(var_6 in var_4) {
      if(distance2dsquared(self.origin, var_6.origin) < var_1) {
        if(isDefined(var_6.triggerportableradarping) && var_6.triggerportableradarping scripts\cp\utility::is_valid_player(1)) {
          var_6.triggerportableradarping playlocalsound("ww_magicbox_laughter");
        }

        var_6 notify("detonateExplosive");
      }
    }

    wait(1);
  }
}