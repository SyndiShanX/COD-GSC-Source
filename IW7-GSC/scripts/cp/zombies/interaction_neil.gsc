/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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
  var_00 = getvehiclenode("neil_spawn", "targetname");
  func_F999(var_00);
  level thread func_BED2();
  level thread func_1077A();
  wait(5);
  var_01 = 0;
  func_9696(var_01);
  func_9697(var_01);
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
  var_00 = getvehiclenode("neil_start_node", "targetname");
  level.neil startpath(var_00);
  level.neil thread func_BED0(var_00);
  scripts\engine\utility::flag_clear("transformation_complete");
  func_BECC(level.neil);
  func_BEB6(level.neil);
}

func_BED4() {
  func_BED6();
  func_10778();
  func_BEBD(level.neil, & "CP_ZMB_INTERACTIONS_MISSING_BATTERY");
  for(;;) {
    level.neil.var_13084 waittill("trigger", var_00);
    if(!var_00 scripts\cp\utility::is_valid_player() || !isDefined(level.var_BEB0)) {
      continue;
    }

    break;
  }

  var_01 = scripts\engine\utility::getstruct("neil_repair", "script_noteworthy");
  add_part_to_neil(var_01, var_00);
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
  func_BEBD(level.neil, & "CP_ZMB_INTERACTIONS_MISSING_FLOPPY");
  for(;;) {
    level.neil.var_13084 waittill("trigger", var_00);
    if(!var_00 scripts\cp\utility::is_valid_player() || !isDefined(level.var_BEC3)) {
      continue;
    }

    break;
  }

  var_01 = scripts\engine\utility::getstruct("neil_repair", "script_noteworthy");
  add_part_to_neil(var_01, var_00);
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

func_BEDB(param_00) {
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

func_BEBD(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    level notify("neil_enabled_changed");
    level.var_1C3F = undefined;
  }

  param_00.var_13084 makeusable();
  if(!isDefined(param_01)) {
    param_01 = & "CP_ZMB_CHALLENGES_USE_NEIL";
  }

  param_00.var_13084 sethintstring(param_01);
  param_00.var_13084 setuserange(90);
  param_00.var_13084 setusefov(180);
  if(!scripts\engine\utility::istrue(level.var_A6E1)) {
    param_00 setscriptablepartstate("light", "on");
  } else {
    param_00 setscriptablepartstate("light", "on_red");
    param_00.upper_body setscriptablepartstate("facefx", "kitt");
    param_00.upper_body func_BEDF("kitt");
  }

  param_00.var_6265 = 1;
  if(!isDefined(param_00.var_13084)) {}
}

func_BEBC(param_00) {
  param_00 setscriptablepartstate("light", "off");
  param_00.var_6265 = 0;
  if(!isDefined(param_00.var_13084)) {
    return;
  }

  param_00.var_13084 makeunusable();
}

func_BEE2(param_00) {
  foreach(var_02 in level.players) {
    var_02 playlocalsound("mp_intel_received");
  }

  level notify("challenge_started");
  var_04 = level.var_C1E1;
  var_05 = func_7895(var_04, param_00);
  level thread scripts\cp\cp_challenge::activate_new_challenge(var_05);
  return var_05;
}

func_BEB7(param_00, param_01, param_02, param_03) {
  if(param_01 == "challenge_force_complete") {
    level.challenge_data[param_00].success = 1;
  } else if(param_01 == "challenge_force_fail") {
    level.challenge_data[param_00].success = 0;
  }

  scripts\cp\cp_challenge::deactivate_current_challenge();
  if(param_01 == "challenge_deactivated" || param_01 == "challenge_force_complete" || param_01 == "challenge_force_fail") {
    if(param_03 != level.var_C1E1) {
      param_03 = level.var_C1E1;
      level thread setperk();
      level.var_6ACC = 0;
      level.neil.upper_body func_BEDF("happy");
      scripts\cp\cp_vo::remove_from_nag_vo("nag_no_challenge");
      return;
    }

    level.var_6ACD[level.var_6ACD.size] = param_00;
    level.var_6ACC++;
    if(level.var_6ACC >= 2) {
      foreach(var_05 in level.players) {
        var_05 thread scripts\cp\cp_vo::add_to_nag_vo("nag_no_challenge", "zmb_comment_vo", 60, 10, 6, 1);
      }
    }

    if(level.var_6ACC > 3) {
      level thread func_BEC0();
    }

    level.neil.upper_body func_BEDF("sad");
    return;
  }

  if(param_03 != level.var_C1E1) {
    param_03 = level.var_C1E1;
    level thread setperk();
    level.neil.upper_body func_BEDF("happy");
  }
}

func_BED1() {
  wait(5);
  level thread scripts\cp\cp_challenge::activate_new_challenge("next_challenge");
  var_00 = int(gettime() + 30000);
  foreach(var_02 in level.players) {
    var_02 setclientomnvar("ui_intel_timer", var_00);
  }

  wait(1);
  var_04 = 5;
  setomnvar("zm_neil_progress", level.var_C1E1 / var_04);
  level.neil.upper_body func_BEDF("happy");
  if(getdvar("challenge_prep_time") != "") {
    wait(3);
  } else {
    wait(28);
  }

  level notify("next_challenge_starting");
  wait(1);
  if(scripts\engine\utility::flag("pause_challenges")) {
    foreach(var_02 in level.players) {
      var_02 setclientomnvar("zm_show_challenge", 10);
    }

    scripts\engine\utility::flag_waitopen("pause_challenges");
  }

  scripts\cp\cp_challenge::func_62C6();
  wait(5);
  if(scripts\engine\utility::flag("pause_challenges")) {
    foreach(var_02 in level.players) {
      var_02 setclientomnvar("zm_show_challenge", 10);
    }

    scripts\engine\utility::flag_waitopen("pause_challenges");
  }
}

func_BEB6(param_00) {
  level endon("game_ended");
  level.var_C1E1 = 0;
  var_01 = 5;
  setomnvar("zm_neil_progress", level.var_C1E1 / var_01);
  level.var_6ACD = [];
  level.var_3C12 = undefined;
  var_02 = [];
  switch (level.var_3C16) {
    case 0:
      var_02 = level.tier_1_challenges;
      break;

    case 1:
      var_02 = level.tier_2_challenges;
      break;

    case 2:
      var_02 = level.tier_3_challenges;
      break;
  }

  level.neil playSound("n31l_challenge_start");
  if(!isDefined(level.var_1C3F)) {
    level.neil thread func_1C5F();
  }

  for(;;) {
    var_03 = level.var_C1E1;
    var_04 = func_BEE2(var_02);
    var_05 = level scripts\engine\utility::waittill_any_return("challenge_deactivated", "challenge_timed_out", "challenge_force_complete", "challenge_force_fail");
    func_BEB7(var_04, var_05, param_00, var_03);
    level.var_3C12 = scripts\engine\utility::array_remove(level.var_3C12, var_04);
    var_01 = 5;
    if(level.var_C1E1 * level.var_3C16 + 1 >= var_01 * level.var_3C16 + 1) {
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
  func_BEB5(param_00);
}

func_BEB5(param_00) {
  level endon("game_ended");
  wait(5);
  var_01 = "iw7_erad_zm";
  var_02 = "cp_fullbody_synaptic_";
  foreach(var_04 in level.players) {
    var_04 setclientomnvar("zm_show_challenge", 5);
    level.current_zm_show_challenge = 5;
  }

  switch (level.var_3C16) {
    case 1:
      level thread func_BEB8(param_00, var_01, & "CP_ZMB_CHALLENGES_NEIL_3");
      break;

    case 2:
      level thread func_BEB8(param_00, "iw7_erad_zm+eradpap1", & "CP_ZMB_CHALLENGES_NEIL_3");
      break;

    case 3:
      level thread func_BEB8(param_00, "iw7_erad_zm+eradpap2", & "CP_ZMB_CHALLENGES_NEIL_3");
      break;
  }

  wait(3);
  level.neil.upper_body thread func_BECD("n31l_challenge_special_complete");
  foreach(var_04 in level.players) {
    var_04 setclientomnvar("zm_show_challenge", -1);
  }
}

func_BEB8(param_00, param_01, param_02) {
  func_BEBD(param_00, param_02);
  for(;;) {
    param_00.var_13084 waittill("trigger", var_03);
    if(!var_03 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    break;
  }

  func_BEBC(param_00);
  level.neil.upper_body thread func_BECD("n31l_challenge_success_generic_dj");
  level thread play_dj_vo_kitt_arrival(var_03);
  wait(5);
  if(isDefined(var_03)) {
    var_03 thread scripts\cp\cp_vo::try_to_play_vo("challenge_n31l_complete", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
  }

  level thread func_12636(param_00, param_01);
  level thread setspectatedefaults(100);
}

play_dj_vo_kitt_arrival(param_00) {
  level endon("game_ended");
  if(!isDefined(param_00)) {
    return;
  }

  if(isDefined(param_00.vo_system.vo_currently_playing)) {
    if(isDefined(param_00.vo_system.vo_currently_playing.alias)) {
      var_01 = strtok(param_00.vo_system.vo_currently_playing.alias, "_");
      if(var_01[0] == "dj") {
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

func_5559(param_00) {
  func_BEBC(level.neil);
  scripts\engine\utility::flag_clear("transformation_complete");
  level.var_1C3F = undefined;
  level.neil vehicle_setspeedimmediate(0);
  level.neil stoploopsound();
  level.neil playSound("neil_mvmt_stop");
  scripts\engine\utility::flag_set("transform");
  scripts\engine\utility::flag_set("halt_neil");
  level.neil notify("neil_quiet");
  if(!scripts\engine\utility::istrue(param_00)) {
    return;
  }

  level.neil.upper_body setModel("robot_kevin_upper_invisi");
  level.neil setModel("robot_kevin_lower_invisi");
}

func_106EF(param_00) {
  if(!isDefined(param_00)) {
    param_00 = level.neil;
  }

  var_01 = spawn("script_model", param_00.origin);
  var_01.angles = param_00.angles;
  var_01.upper_body = spawn("script_model", param_00.origin);
  var_01.upper_body.angles = var_01.angles;
  var_01 setModel(level.var_BEB1);
  var_01.upper_body setModel(level.var_BEB2);
  var_01.upper_body linkto(var_01);
  var_01 setnonstick(1);
  var_01.upper_body setnonstick(1);
  var_01 setscriptablepartstate("thrusters", "liftoff");
  if(scripts\engine\utility::istrue(level.var_A6E1)) {
    var_01.upper_body func_BEDF("kitt");
    var_01.upper_body setscriptablepartstate("facefx", "kitt");
  } else {
    var_01.upper_body func_BEDF("happy");
  }

  return var_01;
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
  var_00 = scripts\engine\utility::getstructarray("dj_quest_door", "script_noteworthy");
  foreach(var_02 in var_00) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_02);
  }

  level.disable_broadcast = 1;
}

func_61CF() {
  var_00 = scripts\engine\utility::getstructarray("dj_quest_door", "script_noteworthy");
  foreach(var_02 in var_00) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_02);
  }
}

func_12636(param_00, param_01) {
  func_54FB();
  func_5559(1);
  level.neil vehicle_teleport(level.neil.origin, level.neil.angles);
  if(scripts\engine\utility::istrue(level.var_A6E1)) {
    level.neil.upper_body setscriptablepartstate("facefx", "off");
  }

  var_02 = func_106EF(level.neil);
  scripts\engine\utility::flag_set("landing_zone_active");
  var_02 playSound("neil_upgrade_rocket_launch_takeoff");
  level thread func_A82C();
  var_02 movez(2000, 3, 2, 1);
  var_02 waittill("movedone");
  playFX(level._effect["neil_flash"], var_02.origin);
  if(!scripts\engine\utility::istrue(level.var_A6E1)) {
    var_02 setModel("robot_kevin_black_lower");
    var_02.upper_body setModel("robot_kevin_black_upper");
    var_02.upper_body func_BEDF("kitt");
    var_02.upper_body setscriptablepartstate("facefx", "kitt");
  }

  var_02 notsolid();
  var_02.upper_body notsolid();
  var_03 = var_02.origin;
  var_02 hide();
  var_02.upper_body hide();
  func_13631();
  if(isDefined(level.force_song_func)) {
    if(!isDefined(level.forced_songs["knight_rider"])) {
      level thread[[level.force_song_func]](undefined, "mus_pa_sp_knightrider", undefined, undefined, undefined, "knight_rider");
    }
  }

  scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(1);
  level.the_hoff = func_107F0(param_01, var_02);
  level.the_hoff setorigin(var_02.origin, 0);
  level.the_hoff.angles = var_02.angles;
  level.the_hoff hide(1);
  wait(0.5);
  level.the_hoff linkto(var_02);
  level.the_hoff playerlinkedoffsetenable();
  var_02.upper_body thread func_A6E2();
  var_02 playSound("neil_upgrade_rocket_launch_land");
  playFX(level._effect["neil_flash"], var_03);
  wait(0.75);
  var_02 show();
  var_02.upper_body show();
  var_02.upper_body func_BEDF("kitt");
  var_02.upper_body setscriptablepartstate("facefx", "kitt");
  var_02 setscriptablepartstate("thrusters", "liftoff");
  level.the_hoff show();
  level.the_hoff takeallweapons();
  level.the_hoff_revive = 1;
  func_1176C(var_02);
  level.the_hoff.precacheleaderboards = 0;
  level.the_hoff.scripted_mode = 0;
  level.the_hoff thread func_1176D();
  var_04 = 120 + 60 * level.var_3C16;
  level.the_hoff scripts\engine\utility::waittill_any_timeout_1(var_04, "death");
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
    var_05 = getclosestpointonnavmesh(level.neil.origin + scripts\cp\utility::vec_multiply(anglesToForward(level.neil.angles), 52) + scripts\cp\utility::vec_multiply(anglestoleft(level.neil.angles), 11));
    level.the_hoff.scripted_mode = 1;
    level.the_hoff scripts\mp\agents\c6\c6_agent::func_F835(var_05, 6);
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
    var_02 = func_106EF(level.neil);
    var_02.upper_body thread func_A6E2();
    level.the_hoff linkto(var_02);
    level.the_hoff playerlinkedoffsetenable();
    scripts\engine\utility::flag_set("landing_zone_active");
    level thread func_A82C();
    var_02 playSound("neil_upgrade_rocket_launch_takeoff_hoff_exit");
    level.the_hoff playSound("dj_kitt_departure");
    wait(3);
    var_02 notsolid();
    var_02.upper_body notsolid();
    var_02 movez(2000, 3, 2, 1);
    var_02 waittill("movedone");
    var_02.upper_body setscriptablepartstate("facefx", "kitt");
    playFX(level._effect["neil_flash"], var_02.origin);
    level.the_hoff.nocorpse = 1;
    level.the_hoff unlink();
    level.the_hoff suicide();
    var_02 playSound("neil_upgrade_rocket_launch_land");
    var_06 = level.neil.origin;
    var_02 movez(-2000, 6, 4, 2);
    wait(3);
    createnavrepulsor("neil", 0, level.neil, 20, 1);
    level.neil setscriptablepartstate("landing", "on");
    wait(3);
    scripts\engine\utility::flag_clear("landing_zone_active");
    level.neil setModel(level.var_BEB1);
    level.neil.upper_body setModel(level.var_BEB2);
    level.neil.upper_body func_BEDF("kitt");
    level.neil.upper_body setscriptablepartstate("facefx", "kitt");
    var_02.upper_body delete();
    var_02 delete();
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

func_1176C(param_00) {
  var_01 = param_00.origin + (0, 0, -2000);
  param_00 movez(-2000, 6, 4, 2);
  wait(3);
  level.neil setscriptablepartstate("landing", "on");
  wait(2);
  level.the_hoff.var_FFEF = undefined;
  level.the_hoff scripts\asm\asm::asm_fireevent("introloop", "introdone");
  wait(1);
  level.the_hoff scripts\mp\mp_agent::func_FAFA("iw7_erad_zm");
  stopFXOnTag(level._effect["neil_trail"], param_00, "tag_origin");
  scripts\engine\utility::flag_clear("landing_zone_active");
  level.the_hoff unlink();
  level.neil setModel(level.var_BEB1);
  level.neil.upper_body setModel(level.var_BEB2);
  level.neil.upper_body func_BEDF("kitt");
  level.neil.upper_body thread func_A6E2();
  param_00.upper_body delete();
  param_00 delete();
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

func_107F0(param_00, param_01) {
  func_F447();
  level.var_A6E1 = 1;
  var_02 = undefined;
  while(!isDefined(var_02)) {
    var_02 = scripts\cp\zombies\zombies_spawning::func_33B1("the_hoff", param_01.origin, param_01.angles, "allies", undefined, param_00);
    if(!isDefined(var_02)) {
      wait(0.2);
      continue;
    }
  }

  var_02.a.rockets = 5;
  var_02.health = 1000 * level.var_3C16;
  var_02.maxhealth = 1000 * level.var_3C16;
  var_02.allowpain = 0;
  var_02.ignoreme = 1;
  var_02.precacheleaderboards = 1;
  var_02.scripted_mode = 1;
  var_02.can_revive = 1;
  var_02.var_FFEF = 1;
  foreach(var_04 in level.players) {
    var_04 notify("hoff_spawned");
  }

  return var_02;
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
    _meth_83FF();
    return;
  }

  if(self getpersstat(self.isnodeoccupied)) {
    self.scripted_mode = 0;
    return;
  }

  _meth_83FF();
}

func_1176B() {
  var_00 = func_78C4();
  if(isDefined(var_00)) {
    physics_getbodyid(var_00);
    self.scripted_mode = 0;
    if(isalive(self)) {
      self.precacheleaderboards = 0;
      scripts\mp\agents\c6\c6_agent::func_41D9();
      self.disablearrivals = 0;
    }
  }
}

physics_getbodyid(param_00) {
  param_00 endon("death");
  param_00 endon("reviving");
  param_00 endon("revive");
  param_00 endon("disconnect");
  self endon("death");
  self endon("timetogo");
  scripts\mp\agents\c6\c6_agent::func_41D9();
  if(distancesquared(self.origin, param_00.origin) > 16000000) {
    return;
  }

  self.scripted_mode = 1;
  scripts\mp\agents\c6\c6_agent::func_F832(param_00, 48, 0);
  self.disablearrivals = 1;
  self.precacheleaderboards = 1;
  self waittill("scriptedGoal_reached");
  self.disablearrivals = 0;
  self.precacheleaderboards = 0;
  if(!isDefined(param_00.reviveent)) {
    return;
  }

  param_00.reviveent notify("trigger", self);
  wait(4);
}

_meth_83FF() {
  var_00 = scripts\cp\utility::get_array_of_valid_players(1, self.origin);
  var_01 = scripts\engine\utility::getclosest(self.origin, var_00);
  if(!isDefined(var_01)) {
    return;
  }

  var_02 = var_01.origin - self.origin;
  var_03 = length2dsquared(var_02);
  if(var_03 < -3036) {
    return;
  }

  var_04 = gettime();
  if(isDefined(self.var_A8EF) && var_04 - self.var_A8EF < 500) {
    return;
  }

  self.var_A8EF = var_04;
  var_05 = vectornormalize(var_02);
  var_06 = var_01.origin - var_05 * 128;
  var_07 = getclosestpointonnavmesh(var_06, self);
  scripts\mp\agents\c6\c6_agent::func_F834(1, 120);
  scripts\mp\agents\c6\c6_agent::func_F835(var_07, 2);
  self.var_3320 = 1;
}

func_78C4() {
  var_00 = sortbydistance(level.players, self.origin);
  foreach(var_02 in var_00) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_02) && !scripts\engine\utility::istrue(var_02.is_being_revived) && !scripts\engine\utility::istrue(var_02.in_afterlife_arcade)) {
      return var_02;
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

func_A56E(param_00) {
  var_01 = spawn("trigger_radius", param_00, 0, 40, 72);
  level thread func_51CE(var_01);
  while(scripts\engine\utility::flag("landing_zone_active")) {
    var_01 waittill("trigger", var_02);
    if(isDefined(level.the_hoff) && var_02 == level.the_hoff) {
      continue;
    }

    if(isDefined(var_02.padding_damage)) {
      continue;
    }

    if(!scripts\engine\utility::flag("landing_zone_active")) {
      continue;
    }

    if(isplayer(var_02)) {
      var_02 dodamage(5, param_00);
      var_02.padding_damage = 1;
      var_02 setvelocity(vectornormalize(var_02.origin - param_00) * 100);
      var_02 thread remove_padding_damage();
      continue;
    }

    if(scripts\cp\utility::should_be_affected_by_trap(var_02)) {
      var_02.nocorpse = 1;
      var_02.full_gib = 1;
      var_02 dodamage(var_02.health + 100, param_00);
    }
  }

  var_01 delete();
}

func_51CE(param_00) {
  param_00 endon("death");
  while(isDefined(param_00)) {
    var_01 = getEntArray("placed_transponder", "script_noteworthy");
    foreach(var_03 in var_01) {
      if(!isDefined(param_00)) {
        break;
      }

      if(var_03 istouching(param_00)) {
        if(isDefined(var_03.triggerportableradarping) && var_03.triggerportableradarping scripts\cp\utility::is_valid_player(1)) {
          var_03.triggerportableradarping playlocalsound("ww_magicbox_laughter");
        }

        var_03 notify("detonateExplosive");
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

func_7895(param_00, param_01) {
  if(!isDefined(level.var_3C12)) {
    level.var_3C12 = param_01;
  }

  var_02 = undefined;
  if(level.players.size > 1) {
    var_02 = scripts\engine\utility::random(level.var_3C12);
  } else {
    for(;;) {
      if(level.var_3C12.size == 0) {
        level.var_3C12 = level.var_6ACD;
      }

      var_02 = scripts\engine\utility::random(level.var_3C12);
      if(!level.challenge_data[var_02].var_1C8C) {
        level.var_3C12 = scripts\engine\utility::array_remove(level.var_3C12, var_02);
        wait(0.05);
        continue;
      } else {
        break;
      }
    }
  }

  return var_02;
}

setperk() {
  wait(3);
  foreach(var_01 in level.players) {
    scripts\engine\utility::waitframe();
  }

  wait(1);
  level thread setspeakermapmonotostereo(25 + level.wave_num * 5);
  level thread setspectatedefaults(100);
}

func_BEE1(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_01)) {
    param_01 = (0, 0, 0);
  }

  var_04 = (0, 0, 0);
  if(isDefined(param_00.angles)) {
    var_04 = param_00.angles;
  }

  var_05 = spawnvehicle(param_02, "neil", "cp_kevin", param_00.origin + param_01, var_04);
  var_05.var_13084 = getent("neil_usetrig", "targetname");
  var_05.var_13084.origin = var_05.origin + (0, 0, 60);
  var_05.var_13084 linkto(var_05);
  var_05 setCanDamage(0);
  if(scripts\engine\utility::istrue(param_03)) {
    var_05.is_neil = 1;
    var_05.upper_body = spawn("script_model", var_05.origin);
    var_05.upper_body.angles = var_05.angles;
    var_05.upper_body setModel(level.var_BEB2);
    var_05.upper_body linkto(var_05);
  }

  return var_05;
}

func_F999(param_00) {
  level.neil = func_BEE1(param_00, undefined, level.var_8C89);
  level.neil attachpath(param_00);
  level.var_BEDC = spawnfx(level._effect["neil_repair_sparks"], level.neil gettagorigin("tag_fx"));
  wait(1);
  triggerfx(level.var_BEDC);
  level.neil setvehicleteam("allies");
  level.neil.var_13084 makeunusable();
  level thread func_BEDE(level.neil);
}

func_BEDE(param_00) {
  level endon("stop_repair_sounds");
  wait(1);
}

func_BECC(param_00) {
  wait(1);
  func_BEC4();
}

func_BECD(param_00) {
  if(!isDefined(param_00) || isDefined(level.var_BEE3)) {
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
  var_01 = lookupsoundlength(param_00);
  if(soundexists(param_00)) {
    self playSound(param_00);
  }

  thread func_BEBF(var_01);
  wait(var_01 / 1000);
  level.var_BEE3 = undefined;
}

func_11025() {
  self endon("death");
  wait(3);
  var_00 = 6400;
  for(;;) {
    if(!func_203C(self.origin, var_00) || isDefined(self.var_1E8F) || scripts\engine\utility::flag("transform")) {
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

    while(func_203C(self.origin, var_00) || scripts\engine\utility::flag("transform")) {
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

func_BEBF(param_00) {
  self endon("neil_quiet");
  self endon("death");
  var_01 = gettime();
  var_02 = var_01 + param_00;
  var_03 = gettime();
  while(var_03 <= var_02) {
    if(isDefined(self.var_1E8F)) {
      wait(0.5);
      continue;
    }

    var_03 = gettime();
    func_BEDF(scripts\engine\utility::random(["oface", "happy_line", "happy"]));
    wait(0.75);
  }
}

func_BEDF(param_00) {
  if(isDefined(level.var_A6E1)) {
    param_00 = "kitt";
  }

  switch (param_00) {
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

func_203C(param_00, param_01) {
  var_02 = 0;
  foreach(var_04 in level.players) {
    if(var_04 scripts\cp\utility::is_valid_player() && distancesquared(var_04.origin, param_00) < param_01) {
      return 1;
    }
  }

  return 0;
}

pickup_head(param_00, param_01) {
  param_01 playlocalsound("neil_part_pickup");
  playFX(level._effect["souvenir_pickup"], param_00.var_BEC5.origin);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  param_00.var_BEC5 delete();
  level.var_BEC7 = 1;
  level scripts\cp\utility::set_quest_icon(7);
  level.var_13BD1 = level.wave_num;
  if(randomint(100) > 90) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("collect_n31l", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
  } else {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_n31l_find_head", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
  }

  level thread func_CDA9(param_01);
}

func_CDA9(param_00) {
  param_00 endon("disconnect");
  level endon("game_ended");
  param_00 thread scripts\cp\cp_vo::add_to_nag_vo("nag_return_n31lpart", "zmb_comment_vo", 60, 60, 3, 1);
  wait(4);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_N3il_construction", "zmb_ww_vo", "highest", 60, 0, 0, 1);
  wait(1);
  level thread scripts\cp\cp_vo::add_to_nag_vo("dj_n3il_part_recovered_nag", "zmb_dj_vo", 60, 120, 3, 1);
}

pickup_battery(param_00, param_01) {
  param_01 playlocalsound("neil_part_pickup");
  playFX(level._effect["souvenir_pickup"], param_00.part.origin);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  param_00.part delete();
  level.var_13BCD = level.wave_num;
  if(randomint(100) > 90) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("collect_n31l", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
  } else {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_n31l_find_battery", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
  }

  level.var_BEB0 = 1;
  level scripts\cp\utility::set_quest_icon(8);
  level.neil.var_13084 sethintstring( & "CP_ZMB_INTERACTIONS_LOAD_BATTERY");
}

pickup_firmware(param_00, param_01) {
  param_01 playlocalsound("neil_part_pickup");
  playFX(level._effect["souvenir_pickup"], param_00.part.origin);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  param_00.part delete();
  level.var_13BCF = level.wave_num;
  if(randomint(100) > 90) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("collect_n31l", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
  } else {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_n31l_find_disc", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
  }

  level.var_BEC3 = 1;
  level scripts\cp\utility::set_quest_icon(9);
  level.neil.var_13084 sethintstring( & "CP_ZMB_INTERACTIONS_LOAD_FLOPPY");
}

func_9696(param_00) {
  var_01 = scripts\engine\utility::getstructarray("neil_battery", "script_noteworthy");
  foreach(var_03 in var_01) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_03);
  }
}

func_10778(param_00) {
  var_01 = func_1077B("neil_battery", "space_interior_power_adapter");
  level.var_BEAE = var_01.var_9A3E;
}

func_9697(param_00) {
  var_01 = scripts\engine\utility::getstructarray("neil_firmware", "script_noteworthy");
  foreach(var_03 in var_01) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_03);
  }
}

func_10779() {
  var_00 = func_1077B("neil_firmware", "zmb_n31l_robot_minifloppy");
  level.var_BEC1 = var_00.var_9A3E;
}

func_1077B(param_00, param_01) {
  var_02 = scripts\engine\utility::getstructarray(param_00, "script_noteworthy");
  var_03 = scripts\engine\utility::random(var_02);
  foreach(var_05 in var_02) {
    if(var_05 == var_03) {
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_05);
      break;
    }
  }

  var_07 = scripts\engine\utility::getstruct(var_03.target, "targetname");
  var_08 = spawn("script_model", var_07.origin);
  if(isDefined(var_07.angles)) {
    var_08.angles = var_07.angles;
  }

  var_03.part = var_08;
  var_08.var_9A3E = var_03;
  var_08 setModel(param_01);
  var_08 notsolid();
  return var_08;
}

func_1077A() {
  var_00 = scripts\engine\utility::getstruct("neil_head", "script_noteworthy");
  var_01 = scripts\engine\utility::getstruct(var_00.target, "targetname");
  var_02 = spawn("script_model", var_01.origin);
  var_02.angles = var_01.angles;
  var_02 setModel(level.var_BEC8);
  var_02 notsolid();
  scripts\engine\utility::waitframe();
  var_00.var_BEC5 = var_02;
  wait(1);
  level.var_BEC5 = var_00;
}

func_BE86() {
  self endon("disconnect");
  self forceusehinton( & "COOP_INTERACTIONS_NEED_MONEY");
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
      level.neil.var_13084 waittill("trigger", var_00);
      if(!var_00 scripts\cp\utility::is_valid_player() || isDefined(level.neil.cooldown)) {
        continue;
      }

      if(!var_00 scripts\cp\cp_persistence::player_has_enough_currency(5000)) {
        if(soundexists("purchase_deny")) {
          var_00 playlocalsound("purchase_deny");
        }

        var_00 thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 3, 0, 0, 1);
        var_00 thread func_BE86();
        continue;
      } else {
        var_00 scripts\cp\cp_persistence::take_player_currency(5000, 1, "trap");
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
  level.neil.var_13084 sethintstring( & "CP_ZMB_CHALLENGES_REBOOTING");
  var_00 = 120;
  wait(var_00);
  level.neil.var_13084 setuserange(90);
  level.neil.var_13084 setusefov(180);
  func_BEBD(level.neil, & "CP_ZMB_CHALLENGES_BUY_NEIL");
  level.neil.cooldown = undefined;
}

func_DB29(param_00) {
  self startpath();
  self vehicle_setspeed(2, 1, 1);
  thread func_BED0(param_00);
}

func_BED0(param_00) {
  self endon("death");
  thread func_BEE4();
  thread func_BEBA();
  thread func_BECE();
  thread func_11025();
  self setscriptablepartstate("smoketrail", "on");
  for(;;) {
    self waittill("reached_end_node");
    self startpath(param_00);
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
    for(var_00 = 0; scripts\engine\utility::flag("transform") || scripts\engine\utility::flag("halt_neil"); var_00 = 0) {
      wait(0.1);
    }

    while(isDefined(self.unloadalltransients)) {
      wait(0.1);
      var_00 = 0;
    }

    if(var_00 == 0) {
      self.upper_body scriptmodelclearanim();
      self.upper_body scriptmodelplayanim("IW7_cp_zom_n31l_walk", 1);
    }

    wait(0.1);
    var_00 = var_00 + 1;
    if(var_00 >= 70) {
      var_00 = 0;
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

    self.upper_body waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
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
  var_00 = scripts\engine\utility::getstruct("neil_repair", "script_noteworthy");
  if(isDefined(level.var_BEC5.var_BEC5)) {
    pickup_head(level.var_BEC5, level.players[0]);
    wait(1);
    add_part_to_neil(var_00, level.players[0]);
    return;
  } else if(isDefined(level.var_BEAE) && isDefined(level.var_BEAE.part)) {
    pickup_battery(level.var_BEAE, level.players[0]);
  } else if(isDefined(level.var_BEC1) && isDefined(level.var_BEC1.part)) {
    pickup_firmware(level.var_BEC1, level.players[0]);
  }

  wait(0.5);
  level.neil.var_13084 notify("trigger", level.players[0]);
  wait(1);
  add_part_to_neil(var_00, level.players[0]);
}

neil_repair_hintstring_logic(param_00, param_01) {
  if(isDefined(level.var_BEC7)) {
    return & "CP_ZMB_INTERACTIONS_ATTACH_HEAD";
  }

  if(isDefined(level.var_BEB0)) {
    return & "CP_ZMB_INTERACTIONS_LOAD_BATTERY";
  }

  if(isDefined(level.var_BEC3)) {
    return & "CP_ZMB_INTERACTIONS_LOAD_FLOPPY";
  }

  if(!isDefined(level.var_BEC7)) {
    return & "CP_ZMB_INTERACTIONS_MISSING_HEAD";
  }

  return & "CP_ZMB_INTERACTIONS_REPAR_NEIL";
}

add_part_to_neil(param_00, param_01) {
  if(isDefined(level.var_BEC7)) {
    param_01 playlocalsound("neil_part_place");
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("challenge_n31l_head", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("part_assemble_n31l", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
    level thread scripts\cp\cp_vo::remove_from_nag_vo("dj_n3il_part_recovered_nag");
    level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_return_n31lpart");
    level.var_BEDC delete();
    level notify("stop_repair_sounds");
    level.neil setModel(level.var_74B8);
    level.neil_head_added = 1;
    level.var_BEC7 = undefined;
    param_01 thread scripts\cp\cp_hud_message::tutorial_lookup_func("quest_neil");
    scripts\engine\utility::flag_set("neil_head_attached");
    var_02 = getent("neil_repair_clip", "targetname");
    var_02 connectpaths();
    var_02 delete();
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  } else if(isDefined(level.var_BEB0)) {
    param_01 playlocalsound("neil_part_place");
    level.var_BEAF = 1;
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("challenge_n31l_battery", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
    scripts\engine\utility::flag_set("neil_battery_attached");
    level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_return_n31lpart");
    level.var_BEB0 = undefined;
  } else if(isDefined(level.var_BEC3)) {
    param_01 playlocalsound("neil_part_place");
    level.var_BEC2 = 1;
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("challenge_n31l_disk", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
    level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_return_n31lpart");
    scripts\engine\utility::flag_set("neil_firmware_attached");
    level.var_BEC3 = undefined;
  }

  if(isDefined(param_01)) {
    param_01 scripts\cp\cp_interaction::refresh_interaction();
  }
}

setspectatedefaults(param_00) {
  foreach(var_02 in level.players) {
    var_02 scripts\cp\cp_persistence::give_player_xp(param_00, 1);
    wait(0.05);
  }
}

func_BEC4() {
  wait(0.5);
  level thread setspeakermapmonotostereo(25);
}

setspeakermapmonotostereo(param_00) {
  foreach(var_02 in level.players) {
    var_02 scripts\cp\zombies\arcade_game_utility::give_player_tickets(var_02, param_00);
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
    func_BEBD(level.neil, & "CP_ZMB_INTERACTIONS_PAUSE_CHALLENGES", 1);
    for(;;) {
      level.neil.var_13084 waittill("trigger", var_00);
      if(!var_00 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      break;
    }

    func_BEBC(level.neil);
    scripts\engine\utility::flag_set("pause_challenges");
    level thread scripts\cp\cp_challenge::func_C9B9();
    level.neil.upper_body thread func_BECD("n31l_spawn_assembly");
    wait(5);
    func_BEBD(level.neil, & "CP_ZMB_CHALLENGES_RESUME_CHALLENGE", 1);
    for(;;) {
      level.neil.var_13084 waittill("trigger", var_00);
      if(!var_00 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      break;
    }

    func_BEBC(level.neil);
    level.neil.upper_body thread func_BECD("n31l_challenge_reactivate");
    scripts\engine\utility::flag_clear("pause_challenges");
    foreach(var_00 in level.players) {
      var_00 setclientomnvar("zm_show_challenge", 11);
    }

    wait(5);
  }
}

func_BEC0() {
  level notify("failed_too_many_times");
  scripts\engine\utility::flag_set("pause_challenges");
  level waittill("next_challenge_starting");
  level.var_1C3F = undefined;
  func_BEBD(level.neil, & "CP_ZMB_CHALLENGES_RESUME_CHALLENGE");
  for(;;) {
    level.neil.var_13084 waittill("trigger", var_00);
    if(!var_00 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    break;
  }

  func_BEBC(level.neil);
  scripts\engine\utility::flag_clear("pause_challenges");
  level.var_6ACC = 0;
  level.neil.upper_body thread func_BECD("n31l_spawn_assembly");
  wait(6);
  func_BEBD(level.neil, & "CP_ZMB_INTERACTIONS_PAUSE_CHALLENGES");
  if(!isDefined(level.var_1C3F)) {
    level.neil thread func_1C5F();
  }
}

func_BECE() {
  self endon("death");
  var_00 = 1225;
  var_01 = 4096;
  for(;;) {
    while(scripts\engine\utility::flag("transform")) {
      wait(1);
    }

    var_02 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_02 = sortbydistance(var_02, self.origin);
    var_03 = var_02[0];
    var_04 = getEntArray("placed_transponder", "script_noteworthy");
    if(!isDefined(var_03) && var_04.size == 0) {
      wait(0.1);
      continue;
    }

    if(isDefined(var_03)) {
      if(distance2dsquared(self.origin, var_03.origin) < var_00 && scripts\engine\utility::istrue(var_03.is_dancing) || scripts\engine\utility::istrue(var_03.isfrozen)) {
        var_03 dodamage(var_03.health + 100, self.origin);
      }
    }

    foreach(var_06 in var_04) {
      if(distance2dsquared(self.origin, var_06.origin) < var_01) {
        if(isDefined(var_06.triggerportableradarping) && var_06.triggerportableradarping scripts\cp\utility::is_valid_player(1)) {
          var_06.triggerportableradarping playlocalsound("ww_magicbox_laughter");
        }

        var_06 notify("detonateExplosive");
      }
    }

    wait(1);
  }
}