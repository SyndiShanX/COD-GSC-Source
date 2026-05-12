/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_windmill_util.gsc
***********************************************/

map_start_utilities() {
  thread windmill_think();
  thread vo_master_handler();
}

ambient_lightning_strikes() {
  while(!isDefined(level.var_744A) || level.var_744A.size < 1) {
    wait 0.05;
  }

  wait(5);
  var_00 = spawn("script_model", level.var_744A[0].var_116 + (0, 0, 4900));
  var_00 setModel("tag_origin");
  var_00.var_1D = var_00.var_1D + (90, 0, 0);
  var_01 = spawn("script_model", level.var_744A[0].var_116 - (0, 0, 100));
  var_01 setModel("tag_origin");
  var_01.var_1D = var_01.var_1D + (-90, 0, 0);
  var_01 method_8449(var_00);
  var_02 = getEntArray("lightning_strike_vol", "targetname");
  var_03 = 4900;
  for(;;) {
    wait(randomfloatrange(0.5, 1.25));
    var_04 = common_scripts\utility::func_7A33(var_02);
    var_05 = var_04 method_8216(randomfloatrange(-0.99, 0.99), randomfloatrange(-0.99, 0.99), randomfloatrange(-0.99, 0.99));
    var_05 = var_05 + (0, 0, 1500);
    var_05 = common_scripts\utility::func_348B(var_05);
    if(var_05[2] < -1500) {
      continue;
    }

    var_00.var_116 = var_05 + (0, 0, var_03);
    var_00.var_1D = (var_00.var_1D[0], var_00.var_1D[1] + randomintrange(45, 315), var_00.var_1D[2]);
    wait 0.05;
    var_06 = launchbeam("zmb_wm_lightning_beam", var_00, "tag_origin", var_01, "tag_origin");
    var_06 common_scripts\utility::func_2CBE(randomfloatrange(0.15, 0.25), ::delete);
  }
}

ambient_lightning_strikes_forvfx() {
  while(!isDefined(level.var_744A) || level.var_744A.size < 1) {
    wait 0.05;
  }

  wait(5);
  var_00 = spawn("script_model", level.var_744A[0].var_116 + (0, 0, 4900));
  var_00 setModel("tag_origin");
  var_00.var_1D = var_00.var_1D + (90, 0, 0);
  var_01 = spawn("script_model", level.var_744A[0].var_116 - (0, 0, 0));
  var_01 setModel("tag_origin");
  var_01.var_1D = var_01.var_1D + (-90, 0, 0);
  wait 0.05;
  wait 0.05;
  var_01 method_8449(var_00);
  var_02 = getent("lightning_strike_vol_test", "targetname");
  var_03 = 4900;
  for(;;) {
    if(getdvarint("snd_zmb_debug_lighting_strike")) {
      wait(randomfloatrange(10, 20));
    } else {
      wait(randomfloatrange(0.5, 1.25));
    }

    var_04 = var_02 method_8216(randomfloatrange(-0.99, 0.99), randomfloatrange(-0.99, 0.99), randomfloatrange(-0.99, 0.99));
    var_04 = var_04 + (0, 0, 1500);
    var_04 = common_scripts\utility::func_348B(var_04);
    if(var_04[2] < -1500) {
      continue;
    }

    var_00.var_116 = var_04 + (0, 0, var_03);
    var_00.var_1D = (var_00.var_1D[0], var_00.var_1D[1] + randomintrange(45, 315), var_00.var_1D[2]);
    wait 0.05;
    var_05 = launchbeam("zmb_wm_lightning_beam", var_00, "tag_origin", var_01, "tag_origin");
    playFXOnTag(level.var_611["zmb_wm_lightning_impact_base_rnr"], var_01, "tag_origin");
    if(getdvarint("snd_zmb_debug_lighting_strike")) {
      lib_0378::func_8D74("lightning_strike", var_00.var_116, var_04);
    }

    var_05 common_scripts\utility::func_2CBE(randomfloatrange(0.15, 0.25), ::delete);
  }
}

spawn_frank() {
  if(!isDefined(level.frank_dudebroman)) {
    var_00 = common_scripts\utility::func_46B5("frank_spawner", "targetname");
    var_01 = level.var_1CC0;
    level.var_1CC0 = ["zombie_generic"];
    level.frank_dudebroman = lib_054D::func_90BA("zombie_generic", var_00, "frank guy", 0, 1, 0);
    level.var_1CC0 = var_01;
    level.frank_dudebroman.var_57E8 = 1;
    level.frank_dudebroman.var_55AB = 1;
    level.frank_dudebroman.waypoints = var_00 maps\mp\zombies\sg_events_v1\very_important_zombie::basic_vip_get_waypoints(level.frank_dudebroman);
    level.frank_dudebroman.var_1928 = level.frank_dudebroman.waypoints[0];
    level.frank_dudebroman.var_6701 = 1;
    level.frank_dudebroman.var_55AB = 1;
    level.frank_dudebroman.var_562B = 1;
    level.frank_dudebroman.ispassiveexempt = 1;
    level.frank_dudebroman.shouldnotpreventlaststand = 1;
    level.frank_dudebroman.var_6816 = 1;
    level.frank_dudebroman.var_C29 = 0;
    level.frank_dudebroman.var_297D = ::maps\mp\zombies\sg_events_v1\very_important_zombie::basic_vip_custom_movemode_walk;
    level.frank_dudebroman.failsafe_exempt = 1;
    level.frank_dudebroman.var_CF = 1;
    level.frank_dudebroman.var_480F = 1;
    level.frank_dudebroman.var_CE = 1;
    level.frank_dudebroman.var_509A = 1;
    level.frank_dudebroman.var_5748 = 1;
    level.frank_dudebroman.nomutilate = 1;
    level.frank_dudebroman maps\mp\agents\_agent_utility::func_83FE(level.var_746E);
    level.frank_dudebroman maps\mp\agents\_agent_common::func_83FD(level.frank_escort_health);
  }
}

windmill_think() {
  var_00 = getEntArray("windmill_gear", "targetname");
  var_01 = common_scripts\utility::func_46B5("windmill_anim_org", "targetname");
  foreach(var_03 in var_00) {
    var_03 thread windmill_play_anim_on_gear();
  }

  windmill_idle_with_speed(1);
}

windmill_idle_with_speed(param_00) {
  thread windmill_rotateby_speed(1);
  var_01 = getEntArray("windmill_gear", "targetname");
  lib_0378::func_8D74("start_gears", var_01);
  foreach(var_03 in var_01) {
    var_03 thread windmill_part_speed_up_from_stop();
  }
}

windmill_stop_idle() {
  thread windmill_rotateby_speed(0);
  var_00 = getEntArray("windmill_gear", "targetname");
  lib_0378::func_8D74("stop_gears", var_00);
  foreach(var_02 in var_00) {
    var_02 thread windmill_part_slow_to_stop();
  }
}

windmill_part_speed_up_from_stop() {
  var_00 = 0.05;
  while(var_00 <= 1) {
    self.anim_rate = var_00;
    wait 0.05;
    var_00 = var_00 + 0.05;
  }

  self.anim_rate = 1;
}

windmill_part_slow_to_stop() {
  var_00 = 0.95;
  while(var_00 >= 0) {
    self.anim_rate = var_00;
    wait 0.05;
    var_00 = var_00 - 0.05;
  }

  self.anim_rate = 0;
}

windmill_play_anim_on_gear() {
  var_00 = self;
  var_01 = "dun_windmill_combat_windmill_gear_0" + var_00.var_165;
  var_00.anim_rate = 0.05;
  var_00.previous_anim_rate = 0.05;
  var_00.total_anim_time = 10.36667;
  var_00.initial_seconds = 0;
  var_02 = common_scripts\utility::func_46B5("windmill_anim_org", "targetname");
  var_00 scriptmodelplayanim(var_01, undefined, var_00.initial_seconds, var_00.anim_rate);
  wait(0.15);
  var_00.initial_seconds = 0.15;
  for(;;) {
    if(var_00.anim_rate != var_00.previous_anim_rate) {
      var_00.previous_anim_rate = var_00.anim_rate;
      if(var_00.anim_rate > 0) {
        var_00 scriptmodelplayanim(var_01, undefined, var_00.initial_seconds, var_00.anim_rate);
      } else {
        var_00 scriptmodelpauseanim(1);
      }
    }

    var_03 = gettime();
    wait 0.05;
    var_04 = gettime();
    var_05 = var_04 - var_03;
    var_05 = var_05 * var_00.anim_rate;
    var_00.initial_seconds = var_00.initial_seconds + var_05 / 1000;
    if(var_00.initial_seconds >= var_00.total_anim_time) {
      var_00.initial_seconds = var_00.initial_seconds - var_00.total_anim_time;
    }
  }
}

windmill_rotateby_speed(param_00) {
  level notify("windmill_starting_rotation");
  level endon("windmill_starting_rotation");
  var_01 = getent("windmill_fan", "targetname");
  if(!isDefined(var_01.current_speed)) {
    var_01.current_speed = 0;
  }

  var_02 = 0.5;
  var_03 = -5;
  var_01 windmill_rotateby_accelerate_to_speed(param_00, var_02, var_03);
  var_01 lib_0378::func_8D74("start_windmill_rotate", param_00);
  if(var_01.current_speed > 0) {
    for(;;) {
      var_01 rotatepitch(-1 * var_01.current_speed * var_03, var_02, 0, 0);
      wait(var_02);
    }
  }
}

windmill_rotateby_accelerate_to_speed(param_00, param_01, param_02) {
  var_03 = self;
  var_04 = common_scripts\utility::func_562E(param_00 > var_03.current_speed) * 2 - 1;
  if(var_04 > 0) {
    for(var_05 = var_03.current_speed; var_05 != param_00; var_05 = var_05 + var_04) {
      self rotatepitch(-1 * var_05 * param_02, param_01, 0, 0);
      wait(param_01);
    }
  }

  if(var_04 < 0) {
    var_06 = 10;
    var_07 = var_06 / abs(param_02) * param_01;
    var_08 = var_07 / 2;
    self rotatepitch(var_06, var_07, 0, var_08);
    lib_0378::func_8D74("stop_windmill", var_07);
    wait(var_07);
    var_09 = var_06 / 2;
    var_0A = self.var_1D[0];
    var_0B = abs(var_03.var_1D[0] % var_09);
    if(var_0B < var_09 / 2) {
      var_0B = var_0B + var_09;
    }

    var_0C = var_0B * 0.3;
    self rotatepitch(-1 * var_0B + var_09 / 4, var_0C, var_0C / 2, var_0C / 8);
    wait(var_0C);
    self rotatepitch(var_09 / 4, var_0C / 2, var_0C / 4, var_0C / 16);
    wait(var_0C / 2);
    var_0D = var_0A - var_0B;
    var_0D = var_0D % 360;
    self.var_1D = (var_0D, self.var_1D[1], self.var_1D[2]);
  }

  var_03.current_speed = param_00;
  level notify("done_accelerating");
}

func_8C92() {
  if(isDefined(level.var_66D6)) {
    level.var_A981 = level.var_66D6 - 1;
  }

  level.var_ABEC maps\mp\_utility::func_5DC7();
  level.var_ABED maps\mp\_utility::func_5DC7();
  level.var_AC12 maps\mp\_utility::func_5DC7();
  var_00 = maps\mp\agents\_agent_utility::func_43FD("all");
  foreach(var_02 in var_00) {
    if(lib_0547::func_5565(var_02.var_A4B, "zombie_boss_village")) {
      continue;
    }

    var_02 suicide();
  }

  level notify("skipWave");
}

______________________vo_stuff_________________________() {}

vo_master_handler() {
  level.hunter = undefined;
  level.hunterindexes = [4, 10, 11, 12, 28, 32];
  level.mountaineer = undefined;
  level.mountaineerindexes = [5, 13, 14, 15, 29, 33];
  level.agent = undefined;
  level.agentindexes = [7];
  level.slayer = undefined;
  level.slayerindexes = [9, 19, 20, 21, 31, 35];
  level.rideau = undefined;
  level.rideauindexes = [8, 40];
  level.objective_round_intermission = 30;
  level.regular_round_intermission = 20;
  thread vo_character_connected_to_game_handler();
  while(!isDefined(level.var_721C) || level.var_744A.size <= 0) {
    wait 0.05;
  }

  wait(1);
  level.rideau_radio = spawn("script_origin", (0, 0, -10000));
  level.rideau_radio.var_20D8 = level.rideauindexes[0];
  while(!common_scripts\utility::func_562E(level.var_3FA6)) {
    wait 0.05;
  }

  thread vo_round01_start();
  thread vo_round01_end();
  thread vo_round04_end();
  thread vo_round07_end();
  thread vo_round09_end();
  thread vo_round10_end();
  thread vo_round11_end();
}

vo_can_character_speak(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(lib_0547::func_5565(param_00.var_178, "spectator") || lib_0547::func_5565(param_00.var_178, "dead")) {
    return 0;
  }

  return 1;
}

vo_play_line_safe(param_00, param_01) {
  if(!vo_can_character_speak(param_00)) {
    return 0;
  }

  param_00 lib_0378::func_307E(param_01, level.var_744A, undefined, 0);
  return 1;
}

vo_round01_start() {
  wait(5);
  level vo_verify_characters();
  var_00 = vo_get_character_if_present("ride");
  var_01 = vo_get_character_if_present("mount");
  var_02 = vo_get_character_if_present("bata");
  var_03 = vo_get_character_if_present("hunt");
  var_04 = vo_get_character_if_present("slay");
  if(vo_characters_are_defined([var_00])) {
    if(vo_characters_are_defined([var_02, var_04])) {
      var_05 = vo_play_line_safe(var_02, "zmb_bp_wind_bata_idontthinkthiswasanaccide");
      if(var_05) {
        var_05 = vo_play_line_safe(var_00, "zmb_bp_wind_ride_yeahwellthanksfornotrubbi");
      }

      if(var_05) {
        var_05 = vo_play_line_safe(var_04, "zmb_bp_wind_slay_thestormsheisrisingwemost");
      }

      if(var_05) {
        var_05 = vo_play_line_safe(var_00, "zmb_bp_wind_ride_ateaseharrislieutenantoma");
      }

      if(var_05) {
        var_05 = vo_play_line_safe(var_04, "zmb_bp_wind_slay_yescomequickly");
      }

      if(var_05) {
        var_05 = vo_play_line_safe(var_00, "zmb_bp_wind_ride_youdontunderstandwedontne");
      }

      if(var_05) {
        var_05 = vo_play_line_safe(var_04, "zmb_bp_wind_slay_itcanbedone");
        return;
      }

      return;
    }

    if(vo_characters_are_defined([var_04])) {
      var_05 = vo_play_line_safe(var_04, "zmb_bp_wind_slay_thestormsheisrisingwemost");
      if(var_05) {
        var_05 = vo_play_line_safe(var_00, "zmb_bp_wind_ride_youdontunderstandwedontne");
      }

      if(var_05) {
        var_05 = vo_play_line_safe(var_04, "zmb_bp_wind_slay_itcanbedone");
        return;
      }

      return;
    }

    if(level.var_744A.size > 1) {
      var_00 lib_0378::func_307E("zmb_bp_wind_ride_alrightlistenuprecruitsye", level.var_744A, undefined, 0);
      return;
    }

    return;
  }

  level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::play_global_vo("zmb_bp_wind_ride_alrightlistenuprecruitsye", 1, 1);
}

vo_round01_end() {
  level endon("round04_end_vo_think");
  level endon("round07_end_vo_think");
  level endon("round09_end_vo_think");
  level endon("round10_end_vo_think");
  level endon("round11_end_vo_think");
  vo_waitfor_end_of_round_number(1);
  level notify("round01_end_vo_think");
  level vo_verify_characters();
  var_00 = vo_get_character_if_present("ride");
  var_01 = vo_get_character_if_present("mount");
  var_02 = vo_get_character_if_present("bata");
  var_03 = vo_get_character_if_present("hunt");
  if(vo_characters_are_defined([var_00])) {
    if(vo_characters_are_defined([var_02]) || vo_characters_are_defined([var_01])) {
      if(vo_characters_are_defined([var_02])) {
        var_04 = vo_play_line_safe(var_00, "zmb_bp_wind_ride_idontknowifthiswasanambus");
        if(var_04) {
          var_04 = vo_play_line_safe(var_02, "zmb_bp_wind_bata_sirimnotseeinganycoordina");
        }

        if(var_04) {
          var_04 = vo_play_line_safe(var_00, "zmb_bp_wind_ride_theyneverlookcoordinateda");
        }
      }

      if(vo_characters_are_defined([var_01])) {
        var_04 = vo_play_line_safe(var_01, "zmb_bp_wind_mount_theyhaveransackedthecarav");
        if(var_04) {
          var_04 = vo_play_line_safe(var_00, "zmb_bp_wind_ride_whatareyousuggestingcapta");
        }

        if(var_04) {
          var_04 = vo_play_line_safe(var_01, "zmb_bp_wind_mount_thisishowsnipersaretraine");
          return;
        }

        return;
      }

      return;
    }

    if(level.var_744A.size > 1) {
      var_01 lib_0378::func_307E("zmb_bp_wind_ride_idontknowifthiswasanambus", level.var_744A, undefined, 0);
      return;
    }

    return;
  }

  level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::play_global_vo("zmb_bp_wind_ride_idontknowifthiswasanambus", 1, 1);
}

vo_round04_end() {
  level endon("round07_end_vo_think");
  level endon("round09_end_vo_think");
  level endon("round10_end_vo_think");
  level endon("round11_end_vo_think");
  vo_waitfor_end_of_round_number(4);
  level notify("round04_end_vo_think");
  level vo_verify_characters();
  var_00 = vo_get_character_if_present("ride");
  var_01 = vo_get_character_if_present("bata");
  var_02 = vo_get_character_if_present("hunt");
  if(vo_characters_are_defined([var_00])) {
    if(vo_characters_are_defined([var_02])) {
      var_03 = vo_play_line_safe(var_00, "zmb_bp_wind_ride_deltorothisstormisthisnor");
      if(var_03) {
        var_03 = vo_play_line_safe(var_02, "zmb_bp_wind_hunt_myhomeisitisfurthersouthg");
      }

      if(var_03) {
        var_03 = vo_play_line_safe(var_00, "zmb_bp_wind_ride_yeahididntthinkso");
      }
    }

    if(vo_characters_are_defined([var_01])) {
      wait(3);
      var_03 = vo_play_line_safe(var_01, "zmb_bp_wind_bata_thestormhasfriedthewiring");
      if(var_03) {
        var_03 = vo_play_line_safe(var_00, "zmb_bp_wind_ride_frieditgothitbylightning");
      }
    }

    if(vo_characters_are_defined([var_02])) {
      vo_waitfor_start_of_round_number(5);
      wait(2);
      var_03 = vo_play_line_safe(var_02, "zmb_bp_wind_hunt_cuidadowevegotincoming");
    }
  }
}

vo_round07_end() {
  level endon("round09_end_vo_think");
  level endon("round10_end_vo_think");
  level endon("round11_end_vo_think");
  vo_waitfor_end_of_round_number(7);
  level notify("round07_end_vo_think");
  level vo_verify_characters();
  var_00 = vo_get_character_if_present("ride");
  var_01 = vo_get_character_if_present("bata");
  var_02 = vo_get_character_if_present("hunt");
  if(vo_characters_are_defined([var_00, var_02])) {
    var_03 = vo_play_line_safe(var_02, "zmb_bp_wind_hunt_thestormgrowsworseitfeels");
    if(var_03) {
      var_03 = vo_play_line_safe(var_00, "zmb_bp_wind_ride_youmaybemorerightthanyouk");
    }

    if(var_03) {
      var_03 = vo_play_line_safe(var_02, "zmb_bp_wind_hunt_weapons");
    }

    if(var_03) {
      var_03 = vo_play_line_safe(var_00, "zmb_bp_wind_ride_wellinamannerofspeakingho");
    }
  }
}

vo_round09_end() {
  level endon("round10_end_vo_think");
  level endon("round11_end_vo_think");
  vo_waitfor_end_of_round_number(9);
  level notify("round09_end_vo_think");
  level vo_verify_characters();
  var_00 = vo_get_character_if_present("ride");
  var_01 = vo_get_character_if_present("mount");
  var_02 = vo_get_character_if_present("bata");
  var_03 = vo_get_character_if_present("hunt");
  wait(10);
  if(vo_characters_are_defined([var_01])) {
    if(level.var_744A.size > 1) {
      var_04 = vo_play_line_safe(var_01, "zmb_bp_wind_mount_idonotthinkwearedonehere");
      if(vo_characters_are_defined([var_00])) {
        if(var_04) {
          var_04 = vo_play_line_safe(var_00, "zmb_bp_wind_ride_seemsquiettomeyouseeingso");
        }
      }
    }
  }

  vo_waitfor_start_of_round_number(10);
  wait(4);
  if(vo_characters_are_defined([var_02]) && level.var_744A.size > 1) {
    var_02 lib_0378::func_307E("zmb_bp_wind_bata_itmusthaveanuberschnalleb", level.var_744A, undefined, 0);
  }

  if(vo_characters_are_defined([var_03]) && level.var_744A.size > 1) {
    var_03 lib_0378::func_307E("zmb_bp_wind_hunt_carajooursmallarmscantbre", level.var_744A, undefined, 0);
  }
}

vo_round10_end() {
  level endon("round11_end_vo_think");
  common_scripts\utility::func_3C9F("zmb_players_gamemode_boss_defeated");
  wait(1.5);
  level notify("round10_end_vo_think");
  level vo_verify_characters();
  var_00 = vo_get_character_if_present("ride");
  var_01 = vo_get_character_if_present("bata");
  var_02 = vo_get_character_if_present("slay");
  if(vo_characters_are_defined([var_00])) {
    if(vo_characters_are_defined([var_01])) {
      var_03 = vo_play_line_safe(var_01, "zmb_bp_wind_bata_okitlookslikewevegotwhatw");
      if(var_03) {
        var_03 = vo_play_line_safe(var_00, "zmb_bp_wind_ride_strongworkharrishavedelto");
      }
    } else if(level.var_744A.size > 1) {
      var_00 lib_0378::func_307E("zmb_bp_wind_ride_welldonehurrynowletsgetlo", level.var_744A, undefined, 0);
    }
  }

  vo_waitfor_start_of_round_number(11);
  wait(3);
  if(vo_characters_are_defined([var_02]) && level.var_744A.size > 1) {
    var_02 lib_0378::func_307E("zmb_bp_wind_slay_itwouldappearwearenotleav", level.var_744A, undefined, 0);
  }
}

vo_round11_end() {
  common_scripts\utility::func_3C9F("zmb_players_gamemode_escaped");
  wait(0.35);
  level notify("round11_end_vo_think");
  level vo_verify_characters();
  var_00 = vo_get_character_if_present("ride");
  var_01 = vo_get_character_if_present("bata");
  if(vo_characters_are_defined([var_00])) {
    if(level.var_744A.size > 1) {
      var_02 = vo_play_line_safe(var_00, "zmb_bp_wind_ride_alrightletsgetontheroadim");
      if(vo_characters_are_defined([var_01])) {
        if(var_02) {
          var_02 = vo_play_line_safe(var_01, "zmb_bp_wind_bata_sir");
        }

        wait(0.5);
        if(var_02) {
          var_02 = vo_play_line_safe(var_00, "zmb_bp_wind_ride_nevermindharris");
          return;
        }

        return;
      }

      return;
    }

    return;
  }

  level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::play_global_vo("zmb_bp_wind_ride_alrightletsgetontheroadim", 1, 1);
}

vo_character_connected_to_game_handler() {
  level waittill("connected", var_00);
}

vo_verify_characters() {}

vo_get_character_if_present(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  var_01 = [];
  switch (param_00) {
    case "ride":
      var_01 = level.rideauindexes;
      break;

    case "bata":
      var_01 = level.agentindexes;
      break;

    case "hunt":
      var_01 = level.hunterindexes;
      break;

    case "mount":
      var_01 = level.mountaineerindexes;
      break;

    case "slay":
      var_01 = level.slayerindexes;
      break;
  }

  foreach(var_03 in level.var_744A) {
    if(vo_check_index_against_character(var_03.var_20D8, var_01)) {
      return var_03;
    }
  }

  return undefined;
}

vo_character_think(param_00) {
  param_00 notify("monitoring_VO_character");
  param_00 endon("monitoring_VO_character");
  while(!isDefined(param_00.var_20D8)) {
    waittillframeend;
  }

  var_01 = 0;
  var_01 = param_00 vo_set_character();
  if(isDefined(var_01) && var_01) {
    var_02 = param_00.var_20D8;
    param_00 waittill("disconnect");
    vo_unset_character(var_02);
  }
}

vo_set_character() {
  var_00 = 1;
  if(vo_check_index_against_character(self.var_20D8, level.rideauindexes)) {
    level.rideau = self;
  } else if(vo_check_index_against_character(self.var_20D8, level.agentindexes)) {
    level.agent = self;
  } else if(vo_check_index_against_character(self.var_20D8, level.mountaineerindexes)) {
    level.mountaineer = self;
  } else if(vo_check_index_against_character(self.var_20D8, level.hunterindexes)) {
    level.hunter = self;
  } else if(vo_check_index_against_character(self.var_20D8, level.slayerindexes)) {
    level.slayer = self;
  } else {
    var_00 = 0;
  }

  return var_00;
}

vo_unset_character(param_00) {
  if(vo_check_index_against_character(param_00, level.rideauindexes)) {
    level.rideau = undefined;
    return;
  }

  if(vo_check_index_against_character(param_00, level.agentindexes)) {
    level.agent = undefined;
    return;
  }

  if(vo_check_index_against_character(param_00, level.mountaineerindexes)) {
    level.mountaineer = undefined;
    return;
  }

  if(vo_check_index_against_character(param_00, level.hunterindexes)) {
    level.hunter = undefined;
    return;
  }

  if(vo_check_index_against_character(param_00, level.slayerindexes)) {
    level.slayer = undefined;
    return;
  }
}

vo_check_index_against_character(param_00, param_01) {
  foreach(var_03 in param_01) {
    if(param_00 == var_03) {
      return 1;
    }
  }

  return 0;
}

vo_characters_are_defined(param_00) {
  foreach(var_02 in param_00) {
    if(!isDefined(var_02)) {
      return 0;
    }

    if(var_02.var_178 == "spectator" || var_02.var_178 == "dead") {
      return 0;
    }
  }

  return 1;
}

vo_waitfor_end_of_round_number(param_00) {
  level waittill("zmb_shattered_play_dlg_" + param_00);
  wait(1.5);
}

vo_waitfor_start_of_round_number(param_00) {
  while(level.var_A980 != param_00) {
    wait(0.25);
  }
}