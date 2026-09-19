/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_windmill_util.gsc
*******************************************************/

map_start_utilities() {
  thread windmill_think();
  thread vo_master_handler();
}

ambient_lightning_strikes() {
  while(!isDefined(level.players) || level.players.size < 1)
    waitframe();

  wait 5;
  var_0 = spawn("script_model", level.players[0].origin + (0, 0, 4900));
  var_0 setModel("tag_origin");
  var_0.angles = var_0.angles + (90, 0, 0);
  var_1 = spawn("script_model", level.players[0].origin - (0, 0, 100));
  var_1 setModel("tag_origin");
  var_1.angles = var_1.angles + (-90, 0, 0);
  var_1 linktosynchronizedparent(var_0);
  var_2 = getEntArray("lightning_strike_vol", "targetname");
  var_3 = 4900;

  for(;;) {
    wait(_randomfloatrange(0.5, 1.25));
    var_4 = common_scripts\utility::random(var_2);
    var_5 = var_4 getpointinbounds(_randomfloatrange(-0.99, 0.99), _randomfloatrange(-0.99, 0.99), _randomfloatrange(-0.99, 0.99));
    var_5 = var_5 + (0, 0, 1500);
    var_5 = common_scripts\utility::_id_348B(var_5);

    if(var_5[2] < -1500) {
      continue;
    }
    var_0.origin = var_5 + (0, 0, var_3);
    var_0.angles = (var_0.angles[0], var_0.angles[1] + _randomintrange(45, 315), var_0.angles[2]);
    waitframe();
    var_6 = _func_382("zmb_wm_lightning_beam", var_0, "tag_origin", var_1, "tag_origin");
    var_6 common_scripts\utility::_id_2CBE(_randomfloatrange(0.15, 0.25), ::delete);
  }
}

ambient_lightning_strikes_forvfx() {
  while(!isDefined(level.players) || level.players.size < 1)
    waitframe();

  wait 5;
  var_0 = spawn("script_model", level.players[0].origin + (0, 0, 4900));
  var_0 setModel("tag_origin");
  var_0.angles = var_0.angles + (90, 0, 0);
  var_1 = spawn("script_model", level.players[0].origin - (0, 0, 0));
  var_1 setModel("tag_origin");
  var_1.angles = var_1.angles + (-90, 0, 0);
  waitframe();
  waitframe();
  var_1 linktosynchronizedparent(var_0);
  var_2 = _getent("lightning_strike_vol_test", "targetname");
  var_3 = 4900;

  for(;;) {
    if(getdvarint("snd_zmb_debug_lighting_strike"))
      wait(_randomfloatrange(10, 20));
    else
      wait(_randomfloatrange(0.5, 1.25));

    var_4 = var_2 getpointinbounds(_randomfloatrange(-0.99, 0.99), _randomfloatrange(-0.99, 0.99), _randomfloatrange(-0.99, 0.99));
    var_4 = var_4 + (0, 0, 1500);
    var_4 = common_scripts\utility::_id_348B(var_4);

    if(var_4[2] < -1500) {
      continue;
    }
    var_0.origin = var_4 + (0, 0, var_3);
    var_0.angles = (var_0.angles[0], var_0.angles[1] + _randomintrange(45, 315), var_0.angles[2]);
    waitframe();
    var_5 = _func_382("zmb_wm_lightning_beam", var_0, "tag_origin", var_1, "tag_origin");
    _playfxontag(level._effect["zmb_wm_lightning_impact_base_rnr"], var_1, "tag_origin");

    if(getdvarint("snd_zmb_debug_lighting_strike"))
      _id_0378::_id_8D74("lightning_strike", var_0.origin, var_4);

    var_5 common_scripts\utility::_id_2CBE(_randomfloatrange(0.15, 0.25), ::delete);
  }
}

spawn_frank() {
  if(!isDefined(level.frank_dudebroman)) {
    var_0 = common_scripts\utility::_id_46B5("frank_spawner", "targetname");
    var_1 = level._id_1CC0;
    level._id_1CC0 = ["zombie_generic"];
    level.frank_dudebroman = _id_054D::_id_90BA("zombie_generic", var_0, "frank guy", 0, 1, 0);
    level._id_1CC0 = var_1;
    level.frank_dudebroman._id_57E8 = 1;
    level.frank_dudebroman._id_55AB = 1;
    level.frank_dudebroman.waypoints = var_0 maps\mp\zombies\sg_events_v1\very_important_zombie::basic_vip_get_waypoints(level.frank_dudebroman);
    level.frank_dudebroman._id_1928 = level.frank_dudebroman.waypoints[0];
    level.frank_dudebroman._id_6701 = 1;
    level.frank_dudebroman._id_55AB = 1;
    level.frank_dudebroman._id_562B = 1;
    level.frank_dudebroman.ispassiveexempt = 1;
    level.frank_dudebroman.shouldnotpreventlaststand = 1;
    level.frank_dudebroman._id_6816 = 1;
    level.frank_dudebroman._id_0C29 = 0;
    level.frank_dudebroman._id_297D = maps\mp\zombies\sg_events_v1\very_important_zombie::basic_vip_custom_movemode_walk;
    level.frank_dudebroman.failsafe_exempt = 1;
    level.frank_dudebroman._id_00CF = 1;
    level.frank_dudebroman._id_480F = 1;
    level.frank_dudebroman._id_00CE = 1;
    level.frank_dudebroman._id_509A = 1;
    level.frank_dudebroman._id_5748 = 1;
    level.frank_dudebroman.nomutilate = 1;
    level.frank_dudebroman maps\mp\agents\_agent_utility::hudoutlineenable(level._id_746E);
    level.frank_dudebroman maps\mp\agents\_agent_common::_id_83FD(level.frank_escort_health);
  }
}

windmill_think() {
  var_0 = getEntArray("windmill_gear", "targetname");
  var_1 = common_scripts\utility::_id_46B5("windmill_anim_org", "targetname");

  foreach(var_3 in var_0)
  var_3 thread windmill_play_anim_on_gear();

  windmill_idle_with_speed(1);
}

windmill_idle_with_speed(var_0) {
  thread windmill_rotateby_speed(1);
  var_1 = getEntArray("windmill_gear", "targetname");
  _id_0378::_id_8D74("start_gears", var_1);

  foreach(var_3 in var_1)
  var_3 thread windmill_part_speed_up_from_stop();
}

windmill_stop_idle() {
  thread windmill_rotateby_speed(0);
  var_0 = getEntArray("windmill_gear", "targetname");
  _id_0378::_id_8D74("stop_gears", var_0);

  foreach(var_2 in var_0)
  var_2 thread windmill_part_slow_to_stop();
}

windmill_part_speed_up_from_stop() {
  for(var_0 = 0.05; var_0 <= 1; var_0 = var_0 + 0.05) {
    self.anim_rate = var_0;
    waitframe();
  }

  self.anim_rate = 1;
}

windmill_part_slow_to_stop() {
  for(var_0 = 0.95; var_0 >= 0; var_0 = var_0 - 0.05) {
    self.anim_rate = var_0;
    waitframe();
  }

  self.anim_rate = 0;
}

windmill_play_anim_on_gear() {
  var_0 = self;
  var_1 = "dun_windmill_combat_windmill_gear_0" + var_0._id_0165;
  var_0.anim_rate = 0.05;
  var_0.previous_anim_rate = 0.05;
  var_0.total_anim_time = 10.3667;
  var_0.initial_seconds = 0;
  var_2 = common_scripts\utility::_id_46B5("windmill_anim_org", "targetname");
  var_0 scriptmodelplayanim(var_1, undefined, var_0.initial_seconds, var_0.anim_rate);
  wait 0.15;
  var_0.initial_seconds = 0.15;

  for(;;) {
    if(var_0.anim_rate != var_0.previous_anim_rate) {
      var_0.previous_anim_rate = var_0.anim_rate;

      if(var_0.anim_rate > 0)
        var_0 scriptmodelplayanim(var_1, undefined, var_0.initial_seconds, var_0.anim_rate);
      else
        var_0 setshadowrendering(1);
    }

    var_3 = gettime();
    waitframe();
    var_4 = gettime();
    var_5 = var_4 - var_3;
    var_5 = var_5 * var_0.anim_rate;
    var_0.initial_seconds = var_0.initial_seconds + var_5 / 1000;

    if(var_0.initial_seconds >= var_0.total_anim_time)
      var_0.initial_seconds = var_0.initial_seconds - var_0.total_anim_time;
  }
}

windmill_rotateby_speed(var_0) {
  level notify("windmill_starting_rotation");
  level endon("windmill_starting_rotation");
  var_1 = _getent("windmill_fan", "targetname");

  if(!isDefined(var_1.current_speed))
    var_1.current_speed = 0;

  var_2 = 0.5;
  var_3 = -5;
  var_1 windmill_rotateby_accelerate_to_speed(var_0, var_2, var_3);
  var_1 _id_0378::_id_8D74("start_windmill_rotate", var_0);

  if(var_1.current_speed > 0) {
    for(;;) {
      var_1 rotatepitch(-1 * var_1.current_speed * var_3, var_2, 0, 0);
      wait(var_2);
    }
  }
}

windmill_rotateby_accelerate_to_speed(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = common_scripts\utility::_id_562E(var_0 > var_3.current_speed) * 2 - 1;

  if(var_4 > 0) {
    for(var_5 = var_3.current_speed; var_5 != var_0; var_5 = var_5 + var_4) {
      self rotatepitch(-1 * var_5 * var_2, var_1, 0, 0);
      wait(var_1);
    }
  }

  if(var_4 < 0) {
    var_6 = 10;
    var_7 = var_6 / _abs(var_2) * var_1;
    var_8 = var_7 / 2;
    self rotatepitch(var_6, var_7, 0, var_8);
    _id_0378::_id_8D74("stop_windmill", var_7);
    wait(var_7);
    var_9 = var_6 / 2;
    var_10 = self.angles[0];
    var_11 = _abs(var_3.angles[0] % var_9);

    if(var_11 < var_9 / 2)
      var_11 = var_11 + var_9;

    var_12 = var_11 * 0.3;
    self rotatepitch(-1 * (var_11 + var_9 / 4), var_12, var_12 / 2, var_12 / 8);
    wait(var_12);
    self rotatepitch(var_9 / 4, var_12 / 2, var_12 / 4, var_12 / 16);
    wait(var_12 / 2);
    var_13 = var_10 - var_11;
    var_13 = var_13 % 360;
    self.angles = (var_13, self.angles[1], self.angles[2]);
  }

  var_3.current_speed = var_0;
  level notify("done_accelerating");
}

_id_8C92() {
  if(isDefined(level._id_66D6))
    level._id_A981 = level._id_66D6 - 1;

  level._id_ABEC maps\mp\_utility::_id_5DC7();
  level._id_ABED maps\mp\_utility::_id_5DC7();
  level._id_AC12 maps\mp\_utility::_id_5DC7();
  var_0 = maps\mp\agents\_agent_utility::_id_43FD("all");

  foreach(var_2 in var_0) {
    if(_id_0547::_id_5565(var_2._id_0A4B, "zombie_boss_village")) {
      continue;
    }
    var_2 suicide();
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

  while(!isDefined(level.player) || level.players.size <= 0)
    waitframe();

  wait 1;
  level.rideau_radio = spawn("script_origin", (0, 0, -10000));
  level.rideau_radio._id_20D8 = level.rideauindexes[0];

  while(!common_scripts\utility::_id_562E(level.gamehasstarted))
    waitframe();

  thread vo_round01_start();
  thread vo_round01_end();
  thread vo_round04_end();
  thread vo_round07_end();
  thread vo_round09_end();
  thread vo_round10_end();
  thread vo_round11_end();
}

vo_can_character_speak(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(_id_0547::_id_5565(var_0.sessionstate, "spectator") || _id_0547::_id_5565(var_0.sessionstate, "dead"))
    return 0;

  return 1;
}

vo_play_line_safe(var_0, var_1) {
  if(!vo_can_character_speak(var_0))
    return 0;
  else {
    var_0 _id_0378::_id_307E(var_1, level.players, undefined, 0);
    return 1;
  }
}

vo_round01_start() {
  wait 5;
  level vo_verify_characters();
  var_0 = vo_get_character_if_present("ride");
  var_1 = vo_get_character_if_present("mount");
  var_2 = vo_get_character_if_present("bata");
  var_3 = vo_get_character_if_present("hunt");
  var_4 = vo_get_character_if_present("slay");

  if(vo_characters_are_defined([var_0])) {
    if(vo_characters_are_defined([var_2, var_4])) {
      var_5 = vo_play_line_safe(var_2, "zmb_bp_wind_bata_idontthinkthiswasanaccide");

      if(var_5)
        var_5 = vo_play_line_safe(var_0, "zmb_bp_wind_ride_yeahwellthanksfornotrubbi");

      if(var_5)
        var_5 = vo_play_line_safe(var_4, "zmb_bp_wind_slay_thestormsheisrisingwemost");

      if(var_5)
        var_5 = vo_play_line_safe(var_0, "zmb_bp_wind_ride_ateaseharrislieutenantoma");

      if(var_5)
        var_5 = vo_play_line_safe(var_4, "zmb_bp_wind_slay_yescomequickly");

      if(var_5)
        var_5 = vo_play_line_safe(var_0, "zmb_bp_wind_ride_youdontunderstandwedontne");

      if(var_5) {
        var_5 = vo_play_line_safe(var_4, "zmb_bp_wind_slay_itcanbedone");
        return;
      }
    } else if(vo_characters_are_defined([var_4])) {
      var_5 = vo_play_line_safe(var_4, "zmb_bp_wind_slay_thestormsheisrisingwemost");

      if(var_5)
        var_5 = vo_play_line_safe(var_0, "zmb_bp_wind_ride_youdontunderstandwedontne");

      if(var_5) {
        var_5 = vo_play_line_safe(var_4, "zmb_bp_wind_slay_itcanbedone");
        return;
      }
    } else if(level.players.size > 1)
      var_0 _id_0378::_id_307E("zmb_bp_wind_ride_alrightlistenuprecruitsye", level.players, undefined, 0);
    else {}
  } else
    level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::play_global_vo("zmb_bp_wind_ride_alrightlistenuprecruitsye", 1.0, 1);
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
  var_0 = vo_get_character_if_present("ride");
  var_1 = vo_get_character_if_present("mount");
  var_2 = vo_get_character_if_present("bata");
  var_3 = vo_get_character_if_present("hunt");

  if(vo_characters_are_defined([var_0])) {
    if(vo_characters_are_defined([var_2]) || vo_characters_are_defined([var_1])) {
      if(vo_characters_are_defined([var_2])) {
        var_4 = vo_play_line_safe(var_0, "zmb_bp_wind_ride_idontknowifthiswasanambus");

        if(var_4)
          var_4 = vo_play_line_safe(var_2, "zmb_bp_wind_bata_sirimnotseeinganycoordina");

        if(var_4)
          var_4 = vo_play_line_safe(var_0, "zmb_bp_wind_ride_theyneverlookcoordinateda");
      }

      if(vo_characters_are_defined([var_1])) {
        var_4 = vo_play_line_safe(var_1, "zmb_bp_wind_mount_theyhaveransackedthecarav");

        if(var_4)
          var_4 = vo_play_line_safe(var_0, "zmb_bp_wind_ride_whatareyousuggestingcapta");

        if(var_4)
          var_4 = vo_play_line_safe(var_1, "zmb_bp_wind_mount_thisishowsnipersaretraine");
      }
    } else if(level.players.size > 1)
      var_0 _id_0378::_id_307E("zmb_bp_wind_ride_idontknowifthiswasanambus", level.players, undefined, 0);
  } else
    level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::play_global_vo("zmb_bp_wind_ride_idontknowifthiswasanambus", 1.0, 1);
}

vo_round04_end() {
  level endon("round07_end_vo_think");
  level endon("round09_end_vo_think");
  level endon("round10_end_vo_think");
  level endon("round11_end_vo_think");
  vo_waitfor_end_of_round_number(4);
  level notify("round04_end_vo_think");
  level vo_verify_characters();
  var_0 = vo_get_character_if_present("ride");
  var_1 = vo_get_character_if_present("bata");
  var_2 = vo_get_character_if_present("hunt");

  if(vo_characters_are_defined([var_0])) {
    if(vo_characters_are_defined([var_2])) {
      var_3 = vo_play_line_safe(var_0, "zmb_bp_wind_ride_deltorothisstormisthisnor");

      if(var_3)
        var_3 = vo_play_line_safe(var_2, "zmb_bp_wind_hunt_myhomeisitisfurthersouthg");

      if(var_3)
        var_3 = vo_play_line_safe(var_0, "zmb_bp_wind_ride_yeahididntthinkso");
    }

    if(vo_characters_are_defined([var_1])) {
      wait 3;
      var_3 = vo_play_line_safe(var_1, "zmb_bp_wind_bata_thestormhasfriedthewiring");

      if(var_3)
        var_3 = vo_play_line_safe(var_0, "zmb_bp_wind_ride_frieditgothitbylightning");
    }

    if(vo_characters_are_defined([var_2])) {
      vo_waitfor_start_of_round_number(5);
      wait 2;
      var_3 = vo_play_line_safe(var_2, "zmb_bp_wind_hunt_cuidadowevegotincoming");
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
  var_0 = vo_get_character_if_present("ride");
  var_1 = vo_get_character_if_present("bata");
  var_2 = vo_get_character_if_present("hunt");

  if(vo_characters_are_defined([var_0, var_2])) {
    var_3 = vo_play_line_safe(var_2, "zmb_bp_wind_hunt_thestormgrowsworseitfeels");

    if(var_3)
      var_3 = vo_play_line_safe(var_0, "zmb_bp_wind_ride_youmaybemorerightthanyouk");

    if(var_3)
      var_3 = vo_play_line_safe(var_2, "zmb_bp_wind_hunt_weapons");

    if(var_3)
      var_3 = vo_play_line_safe(var_0, "zmb_bp_wind_ride_wellinamannerofspeakingho");
  }
}

vo_round09_end() {
  level endon("round10_end_vo_think");
  level endon("round11_end_vo_think");
  vo_waitfor_end_of_round_number(9);
  level notify("round09_end_vo_think");
  level vo_verify_characters();
  var_0 = vo_get_character_if_present("ride");
  var_1 = vo_get_character_if_present("mount");
  var_2 = vo_get_character_if_present("bata");
  var_3 = vo_get_character_if_present("hunt");
  wait 10;

  if(vo_characters_are_defined([var_1])) {
    if(level.players.size > 1) {
      var_4 = vo_play_line_safe(var_1, "zmb_bp_wind_mount_idonotthinkwearedonehere");

      if(vo_characters_are_defined([var_0])) {
        if(var_4)
          var_4 = vo_play_line_safe(var_0, "zmb_bp_wind_ride_seemsquiettomeyouseeingso");
      }
    }
  }

  vo_waitfor_start_of_round_number(10);
  wait 4;

  if(vo_characters_are_defined([var_2]) && level.players.size > 1)
    var_2 _id_0378::_id_307E("zmb_bp_wind_bata_itmusthaveanuberschnalleb", level.players, undefined, 0);

  if(vo_characters_are_defined([var_3]) && level.players.size > 1)
    var_3 _id_0378::_id_307E("zmb_bp_wind_hunt_carajooursmallarmscantbre", level.players, undefined, 0);
}

vo_round10_end() {
  level endon("round11_end_vo_think");
  common_scripts\utility::_id_3C9F("zmb_players_gamemode_boss_defeated");
  wait 1.5;
  level notify("round10_end_vo_think");
  level vo_verify_characters();
  var_0 = vo_get_character_if_present("ride");
  var_1 = vo_get_character_if_present("bata");
  var_2 = vo_get_character_if_present("slay");

  if(vo_characters_are_defined([var_0])) {
    if(vo_characters_are_defined([var_1])) {
      var_3 = vo_play_line_safe(var_1, "zmb_bp_wind_bata_okitlookslikewevegotwhatw");

      if(var_3)
        var_3 = vo_play_line_safe(var_0, "zmb_bp_wind_ride_strongworkharrishavedelto");
    } else if(level.players.size > 1)
      var_0 _id_0378::_id_307E("zmb_bp_wind_ride_welldonehurrynowletsgetlo", level.players, undefined, 0);
  }

  vo_waitfor_start_of_round_number(11);
  wait 3;

  if(vo_characters_are_defined([var_2]) && level.players.size > 1)
    var_2 _id_0378::_id_307E("zmb_bp_wind_slay_itwouldappearwearenotleav", level.players, undefined, 0);
}

vo_round11_end() {
  common_scripts\utility::_id_3C9F("zmb_players_gamemode_escaped");
  wait 0.35;
  level notify("round11_end_vo_think");
  level vo_verify_characters();
  var_0 = vo_get_character_if_present("ride");
  var_1 = vo_get_character_if_present("bata");

  if(vo_characters_are_defined([var_0])) {
    if(level.players.size > 1) {
      var_2 = vo_play_line_safe(var_0, "zmb_bp_wind_ride_alrightletsgetontheroadim");

      if(vo_characters_are_defined([var_1])) {
        if(var_2)
          var_2 = vo_play_line_safe(var_1, "zmb_bp_wind_bata_sir");

        wait 0.5;

        if(var_2) {
          var_2 = vo_play_line_safe(var_0, "zmb_bp_wind_ride_nevermindharris");
          return;
        }

        return;
      }
    } else {}
  } else
    level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::play_global_vo("zmb_bp_wind_ride_alrightletsgetontheroadim", 1.0, 1);
}

vo_character_connected_to_game_handler() {
  for(;;)
    level waittill("connected", var_0);
}

vo_verify_characters() {}

vo_get_character_if_present(var_0) {
  if(!isDefined(var_0))
    return undefined;

  var_1 = [];

  switch (var_0) {
    case "ride":
      var_1 = level.rideauindexes;
      break;
    case "bata":
      var_1 = level.agentindexes;
      break;
    case "hunt":
      var_1 = level.hunterindexes;
      break;
    case "mount":
      var_1 = level.mountaineerindexes;
      break;
    case "slay":
      var_1 = level.slayerindexes;
      break;
  }

  foreach(var_3 in level.players) {
    if(vo_check_index_against_character(var_3._id_20D8, var_1))
      return var_3;
  }

  return undefined;
}

vo_character_think(var_0) {
  var_0 notify("monitoring_VO_character");
  var_0 endon("monitoring_VO_character");

  while(!isDefined(var_0._id_20D8))
    waittillframeend;

  var_1 = 0;
  var_1 = var_0 vo_set_character();

  if(isDefined(var_1) && var_1) {
    var_2 = var_0._id_20D8;
    var_0 waittill("disconnect");
    vo_unset_character(var_2);
  }
}

vo_set_character() {
  var_0 = 1;

  if(vo_check_index_against_character(self._id_20D8, level.rideauindexes))
    level.rideau = self;
  else if(vo_check_index_against_character(self._id_20D8, level.agentindexes))
    level.agent = self;
  else if(vo_check_index_against_character(self._id_20D8, level.mountaineerindexes))
    level.mountaineer = self;
  else if(vo_check_index_against_character(self._id_20D8, level.hunterindexes))
    level.hunter = self;
  else if(vo_check_index_against_character(self._id_20D8, level.slayerindexes))
    level.slayer = self;
  else
    var_0 = 0;

  return var_0;
}

vo_unset_character(var_0) {
  if(vo_check_index_against_character(var_0, level.rideauindexes))
    level.rideau = undefined;
  else if(vo_check_index_against_character(var_0, level.agentindexes))
    level.agent = undefined;
  else if(vo_check_index_against_character(var_0, level.mountaineerindexes))
    level.mountaineer = undefined;
  else if(vo_check_index_against_character(var_0, level.hunterindexes))
    level.hunter = undefined;
  else if(vo_check_index_against_character(var_0, level.slayerindexes))
    level.slayer = undefined;
}

vo_check_index_against_character(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(var_0 == var_3)
      return 1;
  }

  return 0;
}

vo_characters_are_defined(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2))
      return 0;

    if(var_2.sessionstate == "spectator" || var_2.sessionstate == "dead")
      return 0;
  }

  return 1;
}

vo_waitfor_end_of_round_number(var_0) {
  level waittill("zmb_shattered_play_dlg_" + var_0);
  wait 1.5;
}

vo_waitfor_start_of_round_number(var_0) {
  while(level._id_A980 != var_0)
    wait 0.25;
}