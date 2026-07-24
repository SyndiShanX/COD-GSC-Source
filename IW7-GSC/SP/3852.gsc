/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3852.gsc
**************************************/

_id_E9BF(var_0, var_1) {
  if(!isDefined(level._id_E977)) {
    level._id_E977 = scripts\engine\utility::spawn_tag_origin();
    level._id_E977._id_E6E2 = [];
    level._id_E977._id_10EBF = 2;
    level._id_E977._id_C9A4 = 1;
    level._id_E977._id_1352F = 99;
    level._id_E977._id_191B = 200;
    level scripts\engine\utility::flag_init("ship_in_lockdown");
    level._id_E977._id_E6D5 = [];
    level._id_E977._id_D0F2 = "none";
    level._id_E977._id_E6D6 = [];
  }

  if(isDefined(var_1))
    level._id_E977.spawners = var_1;
  else {
    level._id_E977.spawners = [];
    level._id_E977.spawners["ar"] = getspawnerarray("sa_ar_spawner");
    level._id_E977.spawners["smg"] = getspawnerarray("sa_smg_spawner");
    level._id_E977.spawners["lmg"] = getspawnerarray("sa_lmg_spawner");
    level._id_E977.spawners["sg"] = getspawnerarray("sa_sg_spawner");
    level._id_E977.spawners["crew"] = getspawnerarray("sa_crew_spawner");
    level._id_E977.spawners["c6"] = getspawnerarray("sa_c6_ar_spawner");
    level._id_E977.spawners["c6_rss"] = getspawnerarray("sa_c6_rss_spawner");
    level._id_E977.spawners["c8"] = getspawnerarray("sa_c8_ar_spawner");
    level._id_E977.spawners["UN_ar"] = getspawnerarray("sa_ar_spawner_un");
    level._id_E977.spawners["UN_smg"] = getspawnerarray("sa_smg_spawner_un");
    level._id_E977.spawners["UN_sg"] = getspawnerarray("sa_sg_spawner_un");
    level._id_E977.spawners["ar_nogrenades"] = getspawnerarray("sa_ar_nogrenades_spawner");
    level._id_E977.spawners["smg_nogrenades"] = getspawnerarray("sa_smg_nogrenades_spawner");
    level._id_E977.spawners["lmg_nogrenades"] = getspawnerarray("sa_lmg_nogrenades_spawner");
    level._id_E977.spawners["sg_nogrenades"] = getspawnerarray("sa_sg_nogrenades_spawner");
  }

  level._id_E9CC = 40000;
  level._id_E977._id_C1DA = 0;
  level._id_E9B6 = [];
  level._id_E9B6[level._id_E9B6.size] = "death";
  level._id_E9B6[level._id_E9B6.size] = "stealth_spotted";
  level._id_E9CD = [];
  level._id_E9CD[level._id_E9CD.size] = "death";
  level._id_E9CD[level._id_E9CD.size] = "reached_path_end";
  level._id_E9CD[level._id_E9CD.size] = "stealth_spotted";
  level._id_E9BB = [];
  level._id_E9BB[level._id_E9B6.size] = "death";
  level._id_E9BB[level._id_E9B6.size] = "stealth_spotted";
  level._id_E9BB[level._id_E9B6.size] = "enemy";
  level._id_E9BC = [];
  level._id_E9BC[level._id_E9CD.size] = "death";
  level._id_E9BC[level._id_E9CD.size] = "reached_path_end";
  level._id_E9BC[level._id_E9CD.size] = "stealth_spotted";
  level._id_E9BC[level._id_E9CD.size] = "enemy";
  var_2 = getEntArray("remove_my_targetname", "script_noteworthy");

  foreach(var_4 in var_2)
  var_4.targetname = undefined;

  _id_971C();
  _id_0F13::_id_971E();
  thread _id_E9E1();

  if(!isDefined(var_0))
    _id_F936();
  else {
    switch (var_0) {
      case "destroyer":
        _id_F936();
        break;
      case "cruiser":
        _id_F92C();
        break;
      case "carrier":
        _id_F90A();
        break;
      default:
        [[var_0]]();
        break;
    }
  }

  _id_0F00::_id_DED4();
}

#using_animtree("generic_human");

_id_971C() {
  if(!isDefined(level._id_E977))
    level._id_E977 = spawnStruct();

  level._id_E977._id_12ACC = [];
  level._id_EC85["generic"]["sa_alert_twitch1"] = % cqb_stand_reload_knee;
  level._id_EC85["generic"]["sa_alert_twitch2"] = % hm_grnd_yel_patrol_seekclear_idle_radio01_ar;
  level._id_EC85["generic"]["sa_alert_twitch3"] = % cqb_stand_twitch;
  level._id_EC85["generic"]["sa_console_enter"] = % hm_grnd_yel_patrol_creepwalk_console_enter;
  level._id_EC85["generic"]["sa_console_loop"] = % hm_grnd_yel_patrol_creepwalk_console_loop;
  level._id_EC85["generic"]["sa_console_exit"] = % hm_grnd_yel_patrol_creepwalk_console_exit;
  level._id_EC85["generic"]["sa_console_twitch_1"] = % hm_grnd_yel_patrol_creepwalk_console_twitch_adjustgun;
  level._id_EC85["generic"]["sa_console_twitch_2"] = % hm_grnd_yel_patrol_creepwalk_console_twitch_stepback;
  level._id_EC85["generic"]["sa_console_twitch_3"] = % hm_grnd_yel_patrol_creepwalk_console_twitch_touchscreen;
  level._id_EC85["generic"]["sa_console_twitch_4"] = % hm_grnd_yel_patrol_creepwalk_console_twitch_radio;
  level._id_EC85["generic"]["sa_console_twitch_5"] = % hm_grnd_yel_patrol_creepwalk_console_twitch_type1;
  level._id_EC85["generic"]["sa_console_twitch_6"] = % hm_grnd_yel_patrol_creepwalk_console_twitch_type2;
  level._id_E977._id_12ACC["sa_console"] = 6;
  level._id_EC85["generic"]["sa_wall_panel_enter"] = % hm_grnd_yel_patrol_repairwallunit_enter;
  level._id_EC85["generic"]["sa_wall_panel_loop"] = % hm_grnd_yel_patrol_repairwallunit_loop;
  level._id_EC85["generic"]["sa_wall_panel_exit"] = % hm_grnd_yel_patrol_repairwallunit_exit;
  level._id_EC85["generic"]["sa_wall_panel_enter_unaware"] = % hm_grnd_yel_patrol_repairwallunit_enter;
  level._id_EC85["generic"]["sa_wall_panel_exit_unaware"] = % hm_grnd_yel_patrol_repairwallunit_exit;
  level._id_EC85["generic"]["sa_wall_panel_twitch_1"] = % hm_grnd_yel_patrol_repairwallunit_twitch_switchtool;
  level._id_EC85["generic"]["sa_wall_panel_twitch_2"] = % hm_grnd_yel_patrol_repairwallunit_twitch_sparkreact_sm;
  level._id_EC85["generic"]["sa_wall_panel_twitch_3"] = % hm_grnd_yel_patrol_repairwallunit_twitch_sparkreact_md;
  level._id_EC85["generic"]["sa_wall_panel_twitch_4"] = % hm_grnd_yel_patrol_repairwallunit_twitch_sparkreact_lg;
  level._id_EC85["generic"]["sa_wall_panel_twitch_5"] = % hm_grnd_yel_patrol_repairwallunit_twitch_reachin;
  level._id_E977._id_12ACC["sa_wall_panel"] = 5;
  level._id_EC85["generic"]["sa_floor_panel_enter"] = % hm_grnd_yel_patrol_repairfloorunit_enter;
  level._id_EC85["generic"]["sa_floor_panel_loop"] = % hm_grnd_yel_patrol_repairfloorunit_loop;
  level._id_EC85["generic"]["sa_floor_panel_exit"] = % hm_grnd_yel_patrol_repairfloorunit_exit;
  level._id_EC85["generic"]["sa_floor_panel_twitch_1"] = % hm_grnd_yel_patrol_repairfloorunit_twitch_switchtool;
  level._id_EC85["generic"]["sa_floor_panel_twitch_2"] = % hm_grnd_yel_patrol_repairfloorunit_twitch_sparkreact_sm;
  level._id_EC85["generic"]["sa_floor_panel_twitch_3"] = % hm_grnd_yel_patrol_repairfloorunit_twitch_sparkreact_md;
  level._id_EC85["generic"]["sa_floor_panel_twitch_4"] = % hm_grnd_yel_patrol_repairfloorunit_twitch_reachin;
  level._id_E977._id_12ACC["sa_floor_panel"] = 4;
  level._id_EC85["generic"]["sa_flashlight_left"] = % hm_grnd_yel_flashlightsearch_left;
  level._id_EC85["generic"]["sa_flashlight_right"] = % hm_grnd_yel_flashlightsearch_right;
  level._id_EC85["generic"]["sa_flashlight_active_left"] = % hm_grnd_yel_patrol_creepwalk_flashlightsearch_left;
  level._id_EC85["generic"]["sa_flashlight_active_right"] = % hm_grnd_yel_patrol_creepwalk_flashlightsearch_right;
  scripts\sp\anim::_id_17F6("generic", "flashlight_on", ::_id_E9A9, "sa_flashlight_left");
  scripts\sp\anim::_id_17F6("generic", "flashlight_off", ::_id_E9A8, "sa_flashlight_left");
  scripts\sp\anim::_id_17F6("generic", "flashlight_on", ::_id_E9A9, "sa_flashlight_right");
  scripts\sp\anim::_id_17F6("generic", "flashlight_off", ::_id_E9A8, "sa_flashlight_right");
  scripts\sp\anim::_id_17F6("generic", "flashlight_on", ::_id_E9A9, "sa_flashlight_active_left");
  scripts\sp\anim::_id_17F6("generic", "flashlight_off", ::_id_E9A8, "sa_flashlight_active_left");
  scripts\sp\anim::_id_17F6("generic", "flashlight_on", ::_id_E9A9, "sa_flashlight_active_right");
  scripts\sp\anim::_id_17F6("generic", "flashlight_off", ::_id_E9A8, "sa_flashlight_active_right");
}

_id_E9A9(var_0) {
  if(!isDefined(level._id_E9AA)) {
    level._id_E9AA = var_0 scripts\engine\utility::spawn_tag_origin();
    level._id_E9AA linkTo(var_0, "tag_flash", (0, 0, 0), (0, 0, 0));
    playFXOnTag(scripts\engine\utility::getfx("sa_flashlight"), level._id_E9AA, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("sa_flashlight_flare"), level._id_E9AA, "tag_origin");
    var_0 thread _id_E9A7();
  }
}

_id_E9A8(var_0) {
  if(isDefined(level._id_E9AA)) {
    var_0 notify("stop_sa_flashlight_monitor");
    killfxontag(scripts\engine\utility::getfx("sa_flashlight"), level._id_E9AA, "tag_origin");
    killfxontag(scripts\engine\utility::getfx("sa_flashlight_flare"), level._id_E9AA, "tag_origin");
    wait 0.05;

    if(isDefined(level._id_E9AA)) {
      level._id_E9AA delete();
      level._id_E9AA = undefined;
    }
  }
}

_id_E9A7() {
  self endon("stop_sa_flashlight_monitor");
  scripts\engine\utility::waittill_either("stealth_alertlevel_change", "death");

  if(isDefined(level._id_E9AA)) {
    killfxontag(scripts\engine\utility::getfx("sa_flashlight"), level._id_E9AA, "tag_origin");
    killfxontag(scripts\engine\utility::getfx("sa_flashlight_flare"), level._id_E9AA, "tag_origin");
    wait 0.05;

    if(isDefined(level._id_E9AA)) {
      level._id_E9AA delete();
      level._id_E9AA = undefined;
    }
  }
}

_id_E995() {
  if(!isDefined(self._id_EED1)) {}

  self._id_10E6D._id_24CB = 800;
}

_id_E9E4(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("sa_stop_rooms_listener");

  if(!isDefined(var_3))
    var_3 = ::_id_E9AF;

  if(!isDefined(var_4))
    var_4 = ::_id_E9B1;

  if(!isDefined(var_5))
    var_5 = ::_id_E9AE;

  foreach(var_8 in getarraykeys(var_0)) {
    if(!scripts\engine\utility::flag_exist(var_8 + "_cleared"))
      scripts\engine\utility::flag_init(var_8 + "_cleared");

    if(!scripts\engine\utility::flag_exist(var_0[var_8]))
      scripts\engine\utility::flag_init(var_0[var_8]);
  }

  level._id_E977._id_E6E2 = [];
  var_10 = undefined;
  level._id_1640 = [];
  var_11 = 0;
  var_12 = 2;
  wait 0.2;
  thread _id_E9C6();

  if(isDefined(level._id_E977._id_7287))
    var_13 = level._id_E977._id_7287;
  else if(isDefined(var_6))
    var_13 = var_6;
  else
    var_13 = _id_E9F3(var_0);

  var_14 = var_13;
  level._id_1640[var_11] = var_13;
  var_15 = 0;

  for(;;) {
    if(!isDefined(level._id_E977._id_E6E2[var_13])) {
      if(isDefined(level._id_E977._id_E6D5[var_13])) {
        var_1[var_13] = level._id_E977._id_E6D5[var_13];
        level._id_E977._id_E6D5[var_13] = undefined;
      }

      level._id_E977._id_E6E2[var_13] = _id_E9E0(var_13, [[var_3]](var_13), [[var_4]](var_13), [[var_5]](var_13), var_1[var_13]);
      _id_E9D8(var_2[var_13], "targetname", level._id_E977._id_E6E2[var_13]);

      if(!isDefined(level._id_E977._id_E6E2[var_13]._id_A8FC) || level._id_E977._id_E6E2[var_13]._id_A8FC + 120000 < gettime()) {
        level._id_E977._id_E6E2[var_13]._id_A8FC = gettime();
        scripts\sp\utility::_id_2679();
      }
    } else if(!var_15) {
      _id_E9D2(level._id_E977._id_E6E2[var_13]);
      _id_E9D8(var_2[var_13], "targetname", level._id_E977._id_E6E2[var_13]);

      if(!isDefined(level._id_E977._id_E6E2[var_13]._id_A8FC) || level._id_E977._id_E6E2[var_13]._id_A8FC + 120000 < gettime()) {
        level._id_E977._id_E6E2[var_13]._id_A8FC = gettime();
        scripts\sp\utility::_id_2679();
      }
    }

    var_15 = 0;
    var_14 = var_13;

    while(var_13 == var_14 || scripts\engine\utility::flag("ship_in_lockdown")) {
      var_13 = _id_E9F3(var_0, level._id_1640[var_11]);

      if(var_13 == var_14)
        wait 0.1;
    }

    var_16 = -1;
    var_17 = -1;

    foreach(var_8 in getarraykeys(level._id_1640)) {
      if(level._id_1640[var_8] == var_13) {
        var_16 = var_8;
        var_15 = 1;
        break;
      }

      if(isDefined(level._id_E977._id_D0F2)) {
        if(level._id_E977._id_D0F2 == level._id_1640[var_8]) {
          var_17 = var_8;

          if(level._id_E977._id_D0F2 == var_13)
            var_15 = 1;
        }
      }
    }

    if(var_16 >= 0)
      var_11 = var_16;
    else if(var_17 >= 0)
      var_11 = var_17;

    if(scripts\engine\utility::flag("ship_in_lockdown"))
      var_15 = 1;

    if(var_15) {
      continue;
    }
    var_11++;

    if(var_11 >= var_12)
      var_11 = 0;

    if(isDefined(level._id_1640[var_11]))
      _id_E9E5(level._id_E977._id_E6E2[level._id_1640[var_11]]);

    level._id_1640[var_11] = var_13;
  }
}

_id_E9AB(var_0) {
  level._id_E977._id_7287 = var_0;
}

_id_E9AF(var_0) {
  var_1["ar"] = randomintrange(2, 5);
  return var_1;
}

_id_E9B1(var_0) {
  var_1["ar"] = randomintrange(2, 5);
  return var_1;
}

_id_E9AE(var_0) {
  var_1 = [];
  return var_1;
}

_id_E9F3(var_0, var_1) {
  foreach(var_3 in getarraykeys(var_0)) {
    if(isDefined(var_1) && var_3 == var_1) {
      continue;
    }
    level thread _id_1365F(var_0[var_3], var_3);
  }

  level waittill("player_near_room", var_5);
  level notify("stop_all_room_waits");
  return var_5;
}

_id_1365F(var_0, var_1) {
  level endon("stop_all_room_waits");
  scripts\engine\utility::flag_clear(var_0);
  scripts\engine\utility::flag_wait(var_0);
  level notify("player_near_room", var_1);
}

_id_E9E0(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEnt(var_0, "targetname");
  var_6 = scripts\engine\utility::spawn_tag_origin();
  var_6._id_1352E = var_5;
  _id_E9B0(var_6);
  var_6._id_86BA = var_1;
  var_6._id_C9B3 = var_2;
  var_6._id_4C56 = var_3;

  if(!isDefined(var_4))
    var_6._id_500C = "alert";
  else
    var_6._id_500C = var_4;

  _id_E9DE(var_6);
  _id_0F13::_id_E9DD(var_6, var_5);
  return var_6;
}

_id_E9D1(var_0, var_1, var_2) {
  if(isDefined(level._id_E977._id_E6E2[var_0]) && (!isDefined(level._id_E977._id_E6E2[var_0]._id_E9E7) || !level._id_E977._id_E6E2[var_0]._id_E9E7)) {
    return;
  }
  if(isDefined(level._id_E977._id_E6E2[var_0]))
    level._id_E977._id_E6E2[var_0] = undefined;

  if(isDefined(var_1))
    level._id_E977._id_E6D5[var_0] = var_1;
}

_id_E9B0(var_0) {
  var_1 = [];
  var_0._id_C990 = [];
  var_0._id_86B5 = [];

  if(isDefined(var_0._id_1352E.target))
    var_1 = scripts\engine\utility::getStructArray(var_0._id_1352E.target, "targetname");

  var_1 = scripts\engine\utility::array_combine(var_1, scripts\engine\utility::getStructArray(var_0._id_1352E.targetname, "targetname"));

  if(!isDefined(var_0._id_1352E._id_C51B)) {
    var_0._id_1352E._id_C51B = 1;

    foreach(var_3 in var_1) {
      var_4 = [];
      var_5 = var_3;

      for(;;) {
        var_4[var_4.size] = var_5.targetname;

        if(isDefined(var_5.animation) && isDefined(var_5.script_noteworthy)) {
          if(isDefined(level._id_EC85["generic"][var_5.script_noteworthy + "_enter"]))
            var_5.radius = 1024;
        }

        if(!isDefined(var_5.target) || scripts\engine\utility::array_contains(var_4, var_5.target)) {
          break;
        }

        var_5 = scripts\engine\utility::getStruct(var_5.target, "targetname");

        if(!isDefined(var_5)) {
          break;
        }
      }
    }

    if(isDefined(var_0._id_1352E._id_7283)) {
      foreach(var_9 in var_0._id_1352E._id_7283) {
        foreach(var_3 in var_1) {
          if(distancesquared(var_9.origin, var_3.origin) < 576) {
            var_3.script_parameters = "force_patrol";
            break;
          }
        }
      }

      var_0._id_1352E._id_7285 = undefined;
    }
  }

  foreach(var_3 in var_1) {
    if(isDefined(var_3.target)) {
      var_0._id_C990[var_0._id_C990.size] = var_3;
      continue;
    }

    var_0._id_86B5[var_0._id_86B5.size] = var_3;
  }
}

_id_E9DE(var_0, var_1) {
  if(!isDefined(level._id_E977))
    _id_E9BF();

  if(!isDefined(var_0._id_500C))
    var_0._id_500C = "alert";

  var_0._id_939C = 0;
  var_0._id_43FD = 0;
  var_0._id_41A9 = 0;
  scripts\engine\utility::waitframe();
  var_0._id_10F48 = var_0._id_1352E.targetname + "_sg";
  var_0._id_C203 = 0;

  if(var_0._id_500C != "cleared") {
    _id_E9DA(var_0);
    _id_E9DC(var_0, var_1);
    scripts\engine\utility::waitframe();
    _id_E9DB(var_0, var_1);
    _id_E9D9(var_0);
    level notify(var_0._id_1352E.targetname + "_spawned");
  } else
    var_0._id_41A9 = 1;

  level._id_E977._id_10EBF++;
}

_id_13970(var_0) {
  if(var_0._id_1352E scripts\sp\utility::_id_77E3("axis").size == 0) {
    return;
  }
  var_0 endon("suspending_room");
  var_0._id_1352E scripts\sp\utility::_id_13822();
  wait 0.05;
  scripts\engine\utility::flag_set(var_0._id_1352E.targetname + "_cleared");
  var_0._id_41A9 = 1;
}

_id_E9E5(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 notify("suspending_room");

  if(var_0._id_500C == "hot") {
    level._id_E977._id_E6D5[var_0._id_1352E.targetname] = "cleared";
    return;
  }

  var_1 = var_0._id_1352E scripts\sp\utility::_id_77E3("axis");
  var_1 = scripts\sp\utility::array_removedeadvehicles(var_1);
  var_0._id_E2AA = [];
  var_0._id_C990 = undefined;
  var_0._id_86B5 = undefined;
  var_0._id_E9E7 = 1;
  var_0._id_43FD = 0;
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(var_0._id_500C != "cleared") {
      if(!isDefined(var_4._id_1074F)) {
        continue;
      }
      var_0._id_E2AA[var_2] = scripts\engine\utility::spawn_tag_origin();
      var_0._id_E2AA[var_2].origin = var_4.origin;
      var_0._id_E2AA[var_2].angles = var_4.angles;
      var_0._id_E2AA[var_2]._id_1074F = var_4._id_1074F;

      if(isDefined(var_4._id_86B7))
        var_0._id_E2AA[var_2]._id_86B7 = var_4._id_86B7;

      if(isDefined(var_4._id_10E6D._id_C9A8))
        var_0._id_E2AA[var_2]._id_C9A8 = var_4._id_10E6D._id_C9A8;

      if(isDefined(var_4._id_C9A6))
        var_0._id_E2AA[var_2]._id_C9A6 = var_4._id_C9A6;

      var_2 = var_0._id_E2AA.size;
    }

    if(isDefined(var_4._id_1074F))
      var_4 delete();
  }

  _id_0F13::_id_E9E6(var_0);
}

_id_E9D2(var_0) {
  if(var_0._id_500C == "hot") {
    return;
  }
  var_0._id_E9E7 = 0;
  _id_E9B0(var_0);

  foreach(var_2 in var_0._id_E2AA) {
    var_3 = var_2._id_1074F;
    level._id_E977.spawners[var_3][0].origin = var_2.origin;
    level._id_E977.spawners[var_3][0].angles = var_2.angles;
    var_4 = level._id_E977.spawners[var_3][0] scripts\sp\utility::_id_10619(1);
    waittillframeend;
    var_4.goalheight = 72;
    var_4.goalradius = 32;
    var_4._id_1074F = var_3;

    if(isDefined(var_2._id_C9A8))
      var_4 _id_0F27::_id_F4C8(var_2._id_C9A8, 1);

    if(isDefined(var_2._id_86B7))
      _id_F3EE(var_2._id_86B7, var_4, var_0);
    else if(isDefined(var_2._id_C9A6)) {
      var_4 _meth_80F1(var_2._id_C9A6.origin, var_2._id_C9A6.angles, 999999);
      _id_F9FB(var_2._id_C9A6, var_4, var_0);
    }

    wait 0.05;
  }

  level notify(var_0._id_1352E.targetname + "_respawned");
  scripts\sp\utility::_id_228A(var_0._id_E2AA);
  var_0._id_E2AA = undefined;

  if(isDefined(var_0._id_E5A8)) {
    foreach(var_7 in getarraykeys(var_0._id_E5A8))
    var_0._id_E5A8[var_7] _id_0F13::_id_8952(var_0);
  }
}

_id_E98A(var_0) {
  var_1 = var_0._id_1352E scripts\sp\utility::_id_77E3("axis");
  scripts\sp\utility::_id_228A(var_1);
  var_0 delete();
}

_id_3DBD(var_0) {
  if(scripts\engine\utility::flag("ship_in_lockdown") || level._id_E977._id_D0F2 != var_0._id_1352E.targetname) {
    scripts\engine\utility::flag_set("ship_in_lockdown");
    _id_0F05::_id_F5B5();
    return;
  }

  scripts\engine\utility::flag_set("ship_in_lockdown");
  var_1 = 0;
  var_2 = 1;

  if(isDefined(level._id_1640) && level._id_1640.size > 1) {
    var_3 = level._id_E977._id_E6E2[level._id_1640[0]];
    var_4 = level._id_E977._id_E6E2[level._id_1640[1]];

    if(isDefined(var_3._id_1352E) && isDefined(var_4._id_1352E) && isDefined(var_3._id_1352E.doors) && isDefined(var_4._id_1352E.doors)) {
      while(!var_1 && scripts\engine\utility::flag("ship_in_lockdown") && !(var_3._id_939C && var_4._id_939C)) {
        wait 0.1;
        var_1 = 1;

        foreach(var_6 in var_3._id_1352E.doors) {
          if(scripts\engine\utility::array_contains(var_3._id_1352E.doors, var_6) && scripts\engine\utility::array_contains(var_4._id_1352E.doors, var_6)) {
            if(var_2 && distancesquared(level.player.origin, var_6.origin) < 5184) {
              _id_0F05::_id_F5B5();
              return;
            }

            if(!isDefined(var_6._id_4284) || isDefined(var_6._id_428A) && gettime() - var_6._id_428A < 4000) {
              var_1 = 0;
              break;
            }
          }
        }

        var_2 = 0;
      }
    }

    if(var_3._id_939C && var_4._id_939C)
      _id_0F05::_id_F5B5();
    else {
      var_8 = var_3;

      if(var_3._id_939C)
        var_8 = var_4;

      thread _id_E9E5(var_8);
    }
  }
}

_id_E9B9(var_0) {
  level endon("force_exit_lockdown");
  var_0._id_939C = 1;
  thread _id_3DBD(var_0);
  level notify("update_door_obj", "hide");
  var_1 = var_0._id_1352E scripts\sp\utility::_id_13822();
  var_0._id_939C = 0;

  if(isDefined(level._id_1640)) {
    foreach(var_0 in level._id_1640) {
      if(isDefined(level._id_E977._id_E6E2[var_0]) && (isDefined(level._id_E977._id_E6E2[var_0]._id_939C) && level._id_E977._id_E6E2[var_0]._id_939C))
        return;
    }
  }

  scripts\engine\utility::flag_clear("ship_in_lockdown");
  level notify("update_door_obj", "show");
}

_id_E9DA(var_0) {
  var_1 = undefined;

  if(isDefined(var_0._id_1352E.doors)) {
    foreach(var_3 in var_0._id_1352E.doors) {
      if(isDefined(var_3._id_C983) && isDefined(var_3._id_C983[var_0._id_1352E.targetname])) {
        var_4 = distance(level.player.origin, var_3.origin);

        if(var_4 < 256) {
          var_1 = var_3._id_C983[var_0._id_1352E.targetname];
          break;
        }
      }
    }
  }

  var_0._id_7282 = [];
  var_0._id_7273 = [];
  var_6 = scripts\engine\utility::array_combine(var_0._id_C990, var_0._id_86B5);

  foreach(var_8 in var_6) {
    var_8._id_BE0C = undefined;
    var_8.last_used_time = 0;

    if(isDefined(var_1) && ispointinvolume(var_8.origin, var_1)) {
      thread _id_E996(var_0, var_8, 5);
      continue;
    }

    if(isDefined(var_8.script_parameters)) {
      if(var_8.script_parameters == "force_patrol") {
        if(isDefined(var_8.target))
          var_0._id_7282[var_0._id_7282.size] = var_8;
        else
          var_0._id_7273[var_0._id_7273.size] = var_8;

        continue;
      }

      var_9 = float(var_8.script_parameters);

      if(isDefined(var_9) && var_9 > 0.1)
        thread _id_E996(var_0, var_8, var_9);
    }
  }

  level notify("echo_current_player_room");
}

_id_13936() {
  for(;;) {
    level waittill("echo_current_player_room");
    level._id_E977._id_5FDC = 1;
  }
}

_id_E9C6() {
  level._id_E977._id_D0F2 = "none";
  wait 1;
  level._id_E977._id_5FDC = 0;
  thread _id_13936();
  var_0 = 0;
  var_1 = "none";
  var_2 = undefined;
  var_3 = 0;

  for(;;) {
    if(level._id_E977._id_5FDC) {
      var_0 = 1;
      level._id_E977._id_5FDC = 0;
    }

    if(!isDefined(var_2) || !ispointinvolume(level.player.origin, var_2)) {
      foreach(var_5 in level._id_1640) {
        var_6 = level._id_E977._id_E6E2[var_5];

        if(!isDefined(var_6)) {
          continue;
        }
        if(!isDefined(var_2) || var_6._id_1352E != var_2) {
          if(ispointinvolume(level.player.origin, var_6._id_1352E)) {
            var_2 = var_6._id_1352E;
            var_1 = var_6._id_1352E.targetname;
            var_0 = 1;
            break;
          }
        }
      }
    }

    if(var_0) {
      level notify("player_in_room", var_1);
      level._id_E977._id_D0F2 = var_1;
      var_0 = 0;
    }

    wait 0.05;
  }
}

_id_E996(var_0, var_1, var_2) {
  var_0 endon("death");
  var_1._id_BE0C = var_0;
  level waittillmatch("player_in_room", var_0._id_1352E.targetname);
  wait(var_2);
  var_1._id_BE0C = undefined;
}

_id_E9D9(var_0) {
  if(!isDefined(var_0._id_4C56)) {
    return;
  }
  if(isarray(var_0._id_4C56)) {
    foreach(var_2 in getarraykeys(var_0._id_4C56)) {
      if(isDefined(level._id_E977.spawners[var_2][0]._id_EED1))
        level._id_E977.spawners[var_2][0]._id_EED1 = var_0._id_10F48;

      for(var_3 = 0; var_3 < var_0._id_4C56[var_2]; var_3++) {
        var_4 = level._id_E977.spawners[var_2][0] scripts\sp\utility::_id_10619(1);

        if(var_3 > 0)
          scripts\engine\utility::waitframe();
      }
    }
  } else if(isstring(var_0._id_4C56)) {
    var_6 = getEntArray(var_0._id_4C56, "targetname");

    foreach(var_8 in var_6)
    var_4 = var_8 scripts\sp\utility::_id_10619(1);
  }
}

_id_F57F(var_0) {
  if(isDefined(var_0) && var_0 == "hot") {
    return;
  }
  _id_0F27::_id_F341(var_0);

  if(isDefined(var_0)) {
    wait 0.05;
    _id_0F1B::_id_10E1B();
  }
}

_id_F3EE(var_0, var_1, var_2) {
  var_1 thread _id_F57F(var_2._id_500C);
  var_0._id_BE0C = var_1;
  var_1._id_86B7 = var_0;
  var_1 scripts\sp\utility::_id_F3DC(var_0.origin);

  if(isDefined(var_1._id_10E6D))
    var_1._id_10E6D._id_24CB = 800;

  var_1 thread _id_E9B5(var_2);
}

_id_E9B5(var_0) {
  var_1 = self._id_86B7;
  self._id_BE0D = var_0;

  if(var_0._id_500C != "hot")
    thread _id_E9F4(var_0);

  if(isDefined(var_1.animation))
    thread _id_E9B8(var_1, 1);

  for(;;) {
    if(var_0._id_500C != "hot")
      var_2 = scripts\engine\utility::waittill_any_in_array_return_no_endon_death(level._id_E9B6);
    else
      var_2 = scripts\engine\utility::waittill_any_in_array_return_no_endon_death(level._id_E9BB);

    self notify("guard_stop_ambient_anims");

    if(isDefined(var_1.script_noteworthy) && !scripts\engine\utility::is_true(self._id_939E) && var_2 != "death")
      scripts\sp\utility::anim_stopanimScripted();

    if(isDefined(var_1) && isDefined(var_1._id_BE0C))
      var_1._id_BE0C = undefined;

    if(var_2 != "death")
      self._id_86B7 = undefined;

    if(var_2 == "death" || var_2 == "enemy" || self.alertlevel == "combat" || var_2 == "stealth_spotted") {
      if(var_0._id_43FD == 1 && var_2 != "death") {
        thread _id_896B(var_0);

        if(_id_E6DD(var_0))
          level thread _id_E9B9(var_0);
      }

      return;
    }
  }
}

_id_E9DB(var_0, var_1) {
  if(!isDefined(var_0._id_86BA) || var_0._id_86B5.size == 0) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_3 in getarraykeys(var_0._id_86BA))
  _id_E9E2(var_0, var_3, var_0._id_86BA, ::_id_E9B2, ::_id_F3EE, "guard");

  scripts\engine\utility::waitframe();
}

_id_E9E2(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_0._id_500C != "hot") {
    foreach(var_7 in level._id_E977.spawners[var_1]) {
      var_7._id_EED1 = var_0._id_10F48;

      if(var_5 != "guard") {
        var_7._id_EE7E = 1;
        continue;
      }

      var_7._id_EE7E = undefined;
    }
  } else {
    foreach(var_7 in level._id_E977.spawners[var_1]) {
      var_7._id_EED1 = undefined;
      var_7._id_EE7E = undefined;
    }
  }

  var_11 = 0;

  for(var_12 = 0; var_12 < var_2[var_1]; var_12++) {
    level._id_E977.spawners[var_1][var_11].count = 99;
    var_13 = [[var_3]](var_0, 0, 1);

    if(isDefined(var_13)) {
      level._id_E977.spawners[var_1][var_11].origin = var_13.origin;

      if(isDefined(var_13.angles))
        level._id_E977.spawners[var_1][var_11].angles = var_13.angles;

      var_14 = level._id_E977.spawners[var_1][var_11] scripts\sp\utility::_id_10619(1);
      var_14._id_1074F = var_1;
      var_14.goalradius = 32;
      var_0._id_C203++;
      [[var_4]](var_13, var_14, var_0);
    } else {}

    var_11++;

    if(var_11 >= level._id_E977.spawners[var_1].size && var_12 + 1 < var_2[var_1]) {
      var_11 = 0;
      scripts\engine\utility::waitframe();
    }
  }
}

_id_E9DC(var_0, var_1) {
  if(!isDefined(var_0._id_C9B3) || var_0._id_C990.size == 0) {
    return;
  }
  foreach(var_3 in getarraykeys(var_0._id_C9B3))
  _id_E9E2(var_0, var_3, var_0._id_C9B3, ::_id_E9B3, ::_id_F9FB, "patrol");

  scripts\engine\utility::waitframe();
}

_id_F9FB(var_0, var_1, var_2) {
  var_0._id_BE0C = var_1;
  var_1._id_C9A6 = var_0;
  var_1 thread _id_F57F(var_2._id_500C);

  if(isDefined(var_1._id_10E6D))
    var_1._id_10E6D._id_24CB = 800;

  var_1 thread _id_E9CE(var_2);
}

_id_E9B8(var_0, var_1) {
  self endon("death");
  self endon("stop_loop");
  level endon("ship_in_lockdown");

  if(!isDefined(var_1))
    var_1 = 0;
  else
    self endon("guard_stop_ambient_anims");

  var_2 = var_0.script_noteworthy;

  if(!isDefined(var_2))
    var_2 = "sa_console";

  self.allowdeath = 1;
  self._id_BE09 = var_2 + "_exit";

  if(isDefined(level._id_EC85["generic"][var_2 + "_enter"])) {
    var_0 scripts\sp\anim::_id_1ECE(self, var_2 + "_enter");
    var_0 scripts\sp\anim::_id_1EC7(self, var_2 + "_enter");
  }

  if(self.goalradius == 1024)
    self.goalradius = 32;

  var_3 = 1;
  var_4 = var_2;

  if(!isDefined(level._id_EC85["generic"][var_4])) {
    var_4 = var_2 + "_loop";

    if(!isDefined(level._id_EC85["generic"][var_4])) {
      return;
    }
    var_3 = randomintrange(2, 5);
  }

  if(isDefined(var_0._id_EF20) && isDefined(level._id_74D5[var_0._id_EF20]))
    level thread[[level._id_74D5[var_0._id_EF20]]](self, var_0);

  var_5 = self;

  if(isDefined(var_0._id_EE59) && var_0._id_EE59 == "scripted")
    var_5 = var_0;

  while(var_3 > 0 && !scripts\engine\utility::is_true(self._id_E014) && !_id_0F27::_id_10E82()) {
    var_5 scripts\sp\anim::_id_1EC7(self, var_4);

    if(isDefined(level._id_E977._id_12ACC[var_2]) && !scripts\engine\utility::is_true(self._id_E014) && !_id_0F27::_id_10E82()) {
      var_6 = var_2 + "_twitch_" + randomintrange(1, level._id_E977._id_12ACC[var_2] + 1);
      var_5 scripts\sp\anim::_id_1EC7(self, var_6);
    }

    if(!var_1)
      var_3--;
  }

  if(!scripts\engine\utility::is_true(self._id_E014) && !_id_0F27::_id_10E82() && isDefined(level._id_EC85["generic"][self._id_BE09]))
    scripts\sp\anim::_id_1EC7(self, self._id_BE09);
}

_id_E9CF(var_0) {
  _id_3DBB(var_0);
  self._id_A889 = var_0;

  if(isDefined(var_0.script_type) && isDefined(level._id_74D5[var_0.script_type]))
    level thread[[level._id_74D5[var_0.script_type]]](self, var_0);

  if(isDefined(var_0.animation)) {
    if(!isDefined(var_0.script_count_min) || randomint(100) < var_0.script_count_min)
      _id_E9B8(var_0, !isDefined(var_0.target));
  }
}

_id_3DBB(var_0) {
  if(isDefined(var_0.script_label) && var_0.script_label == "wounded")
    _id_0F27::_id_F4C5(level._id_EC85["generic"]["injured_walk"]);
}

_id_E9CE(var_0) {
  var_1 = self._id_C9A6;
  self._id_BE0D = var_0;
  wait 0.05;

  if(var_0._id_500C != "hot")
    thread _id_E9F4(var_0);

  self._id_3DC1 = 1;

  for(;;) {
    while(!isDefined(var_1)) {
      var_1 = _id_E9B3(var_0, self._id_3DC1);

      if(isDefined(var_1)) {
        self._id_3DC1 = 1;
        var_1._id_BE0C = self;
        self._id_C9A6 = var_1;
        break;
      }

      self._id_3DC1 = 0;
      wait 0.5;

      if(!isalive(self))
        return;
    }

    self.goalheight = 72;
    _id_3DBB(self._id_C9A6);
    thread _id_0B77::_id_8409(self._id_C9A6, undefined, ::_id_E9CF, undefined, undefined);

    for(;;) {
      if(var_0._id_500C != "hot")
        var_2 = scripts\engine\utility::waittill_any_in_array_return_no_endon_death(level._id_E9CD);
      else
        var_2 = scripts\engine\utility::waittill_any_in_array_return_no_endon_death(level._id_E9BC);

      if(isDefined(var_1) && isDefined(var_1._id_BE0C)) {
        var_1._id_BE0C = undefined;
        var_1.last_used_time = gettime();
      }

      if(var_2 != "death")
        self._id_C9A6 = undefined;

      if(var_2 == "death" || var_2 == "enemy" || self.alertlevel == "combat" || var_2 == "stealth_spotted") {
        if(var_0._id_43FD == 1 && var_2 != "death") {
          scripts\sp\utility::anim_stopanimScripted();
          thread _id_896B(var_0);

          if(_id_E6DD(var_0))
            level thread _id_E9B9(var_0);
        }

        return;
      }

      break;
    }

    var_1 = undefined;

    if(!isalive(self))
      return;
  }
}

_id_E9F4(var_0) {
  self endon("death");
  _id_0F27::_id_868D("stealth_spotted");
  self notify("stealth_spotted");

  if(isDefined(var_0))
    var_0 notify("room_stealth_broken");
}

_id_E9B2(var_0, var_1, var_2) {
  if(var_0._id_7273.size > 0) {
    var_3 = var_0._id_7273[var_0._id_7273.size - 1];
    var_0._id_7273[var_0._id_7273.size - 1] = undefined;
    return var_3;
  }

  var_4 = 0.0;
  var_3 = undefined;

  foreach(var_6 in var_0._id_86B5) {
    if(_id_E9C1(var_6)) {
      var_4 = var_4 + 1.0;

      if(randomfloatrange(0, 1) <= 1.0 / var_4)
        var_3 = var_6;
    }
  }

  return var_3;
}

_id_E9C1(var_0) {
  return !isDefined(var_0._id_BE0C);
}

_id_E9B3(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2 && var_0._id_7282.size > 0) {
    var_3 = var_0._id_7282[var_0._id_7282.size - 1];
    var_0._id_7282[var_0._id_7282.size - 1] = undefined;
    return var_3;
  }

  if(!isDefined(var_1))
    var_1 = 0;

  var_4 = 0.0;
  var_3 = undefined;
  var_5 = undefined;

  foreach(var_7 in var_0._id_C990) {
    if(_id_E9C2(var_7, var_1)) {
      var_8 = 0.5 - clamp((gettime() - var_7.last_used_time) / 16000, 0.0, 0.5);
      var_4 = var_4 + 1.0;

      if(randomfloatrange(0, 1) <= (1.0 - var_8) / var_4)
        var_3 = var_7;

      if(!isDefined(var_3) && !isDefined(var_5))
        var_5 = var_7;
    }
  }

  if(!isDefined(var_3))
    var_3 = var_5;

  return var_3;
}

_id_E9C2(var_0, var_1) {
  if(isDefined(var_0._id_BE0C))
    return 0;

  if(var_1) {
    if(abs(self.origin[2] - var_0.origin[2]) > 72.0)
      return 0;

    if(distancesquared(self.origin, var_0.origin) > level._id_E9CC)
      return 0;
  }

  return 1;
}

_id_E9D8(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, var_1);
  var_2._id_8431 = [];
  var_2._id_D0F3 = level._id_E977._id_1352F;

  foreach(var_5 in var_3) {
    var_5._id_A596 = level._id_E977._id_1352F;
    var_5._id_191A = 0;
    var_2._id_8431[var_5._id_A596] = var_5;
    level._id_E977._id_1352F++;
  }

  if(!var_2._id_8431.size > 0) {
    thread _id_11AB6(var_2);
    return;
  }

  thread _id_13970(var_2);
  var_2._id_43FD = 1;
  _id_F8CD(var_2);
  thread _id_11AB5(var_2);
}

_id_F8CD(var_0) {
  var_1 = [];

  foreach(var_3 in getarraykeys(var_0._id_8431)) {
    if(isDefined(var_0._id_8431[var_3].script_linkto))
      var_1[var_3] = strtok(var_0._id_8431[var_3].script_linkto, " ");
    else
      var_1[var_3] = [];

    var_0._id_8431[var_3]._id_E2A0 = [];
  }

  foreach(var_3 in getarraykeys(var_0._id_8431)) {
    for(var_6 = 0; var_6 < var_1[var_3].size; var_6++) {
      var_7 = getEnt(var_1[var_3][var_6], "script_linkname");

      if(!isDefined(var_7)) {
        continue;
      }
      var_7._id_E2A0[var_7._id_E2A0.size] = var_0._id_8431[var_3];
      var_0._id_8431[var_3]._id_E2A0[var_0._id_8431[var_3]._id_E2A0.size] = var_7;
    }
  }
}

_id_E240(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0._id_8431)
  var_3._id_191A = 0;

  var_5 = getaiarray("axis");

  foreach(var_7 in var_5) {
    var_8 = var_7 _meth_812A();

    if(isDefined(var_7._id_BE0D) && var_7._id_BE0D == var_0) {
      var_1++;

      if(isDefined(var_8))
        var_0._id_8431[var_8._id_A596]._id_191A++;
    }
  }

  if(_id_E9C0(var_0) && !isDefined(var_0._id_54DC)) {
    if(var_0._id_C203 >= 3 && (var_1 <= 2 || var_1 / var_0._id_C203 < 0.3))
      var_0._id_54DC = 1;
    else if(var_0._id_C203 >= 2 && var_1 == 1)
      var_0._id_54DC = 1;

    if(isDefined(var_0._id_54DC)) {
      foreach(var_7 in var_5) {
        if(!isDefined(var_7._id_BE0D)) {
          if(var_7 istouching(var_0._id_1352E))
            var_7 thread _id_4276();
        }
      }
    }
  }
}

_id_896B(var_0) {
  self endon("death");
  self endon("stop_handle_volume_combat");
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 0;

  for(;;) {
    if(isDefined(var_0._id_54DC) && var_0._id_54DC) {
      if(isDefined(var_1)) {
        self cleargoalvolume();
        thread _id_4276();
        self waittill("death");
      }
    }

    if(isDefined(var_1)) {
      var_4 = level scripts\engine\utility::waittill_any_return("player_changed_combat_volume", "room_direct_attack");

      if(var_4 == "room_direct_attack")
        continue;
    }

    var_1 = self _meth_812A();
    var_2 = undefined;

    if(isDefined(var_1) && var_3 > gettime()) {
      foreach(var_2 in var_0._id_8431[var_0._id_D0F3]._id_E2A0) {
        if(var_1 == var_2) {
          break;
        }
      }
    }

    if(isDefined(var_1) && isDefined(var_2) && var_1 == var_2) {
      continue;
    }
    var_7 = var_1;
    var_1 = undefined;
    var_8 = -9999999;
    var_9 = self.origin;
    var_10 = level.player.origin;
    var_11 = distance(var_9, var_10);

    if(var_0._id_8431.size == 1 || var_0._id_8431[var_0._id_D0F3]._id_E2A0.size == 0)
      var_1 = var_0._id_8431[var_0._id_D0F3];
    else {
      foreach(var_2 in var_0._id_8431[var_0._id_D0F3]._id_E2A0) {
        if(var_3 < gettime() && isDefined(var_7) && var_7 == var_2) {
          continue;
        }
        var_13 = 0;
        var_14 = var_2 getorigin();
        var_15 = distance(var_9, var_14);
        var_16 = distance(var_10, var_14);
        var_13 = abs(var_16 - 350) * 2;
        var_13 = var_13 + (var_16 - var_15);
        var_13 = var_13 + (512 - var_15);
        var_13 = var_13 - var_2._id_191A * var_2._id_191A * level._id_E977._id_191B;
        var_13 = var_13 * randomfloatrange(0.7, 1.3);

        if(var_13 > var_8 || !isDefined(var_1)) {
          var_1 = var_2;
          var_8 = var_13;
        }
      }
    }

    if(!isDefined(var_1))
      var_1 = var_0._id_8431[var_0._id_D0F3]._id_E2A0[randomint(var_0._id_8431[var_0._id_D0F3]._id_E2A0.size)];

    var_1._id_191A++;
    self _meth_82F1(var_1);

    if(scripts\engine\utility::cointoss()) {
      var_3 = gettime() + randomintrange(6000, 20000);
      continue;
    }

    var_3 = gettime() + randomintrange(16000, 46000);
  }
}

_id_4276(var_0) {
  self endon("death");

  if(!isDefined(var_0))
    var_0 = 350;

  var_1 = distance(self.origin, level.player.origin);

  for(;;) {
    wait(randomfloatrange(2, 4));
    self.goalradius = var_1;
    var_2 = level.player;
    self setgoalentity(var_2);
    var_1 = var_1 * 0.85;

    if(var_1 < var_0) {
      var_1 = var_0;
      self.goalradius = var_0;
      return;
    }
  }
}

_id_11AB6(var_0) {
  var_0._id_43FD = 1;

  while(var_0._id_43FD) {
    if(level.player istouching(var_0._id_1352E)) {
      level.player._id_4BAA = var_0._id_1352E;
      wait 0.4;
      continue;
    }

    wait 0.1;
  }
}

_id_11AB5(var_0) {
  var_0._id_CFBF = 0;

  while(var_0._id_43FD) {
    if(level.player istouching(var_0._id_8431[var_0._id_D0F3])) {
      level.player._id_4BAA = var_0._id_1352E;

      if(_id_E9C0(var_0) && gettime() - var_0._id_CFBF > 2000) {
        var_0._id_CFBF = gettime();
        _id_E240(var_0);
        level notify("player_changed_combat_volume");
      }

      wait 0.4;
      continue;
    }

    foreach(var_2 in getarraykeys(var_0._id_8431)) {
      if(var_2 == var_0._id_D0F3) {
        continue;
      }
      if(level.player istouching(var_0._id_8431[var_2])) {
        level.player._id_4BAA = var_0._id_1352E;
        var_0._id_D0F3 = var_2;
        var_0._id_CFBF = gettime();
        _id_E240(var_0);
        level notify("player_changed_combat_volume");
        wait 1;
        break;
      }
    }

    wait 0.2;
  }
}

_id_E9D7(var_0, var_1) {
  if(var_1)
    level._id_E977._id_E6D6[var_0] = 1;
  else if(isDefined(level._id_E977._id_E6D6[var_0]))
    level._id_E977._id_E6D6[var_0] = undefined;
}

_id_E9E1() {
  level._id_E977._id_E871 = getEntArray("sa_trigger_runners", "targetname");
  scripts\engine\utility::array_thread(level._id_E977._id_E871, ::_id_E9BA);
}

_id_E9BA() {
  self endon("death");

  if(!isDefined(self.script_noteworthy))
    self.script_noteworthy = "sa_runner";

  var_0 = -1;
  var_1 = undefined;

  if(!isDefined(self.script_count_min))
    self.script_count_min = 1;

  if(!isDefined(self.script_delay))
    self.script_delay = 10;

  if(isDefined(self._id_E867)) {
    var_0 = self._id_E867;
    var_1 = self._id_E86F;
  } else {
    var_2 = scripts\engine\utility::getStructArray(self.target, "targetname");

    foreach(var_4 in var_2) {
      if(!isDefined(var_4.target)) {
        if(isDefined(var_4._id_ED6D))
          var_0 = var_4._id_ED6D;
        else
          var_0 = 0.707;

        var_1 = var_4.origin;
        self._id_E867 = var_0;
        self._id_E86F = var_1;
        scripts\sp\utility::_id_51D4(var_4);
        continue;
      }

      var_5 = var_4;
      var_6 = [];

      for(;;) {
        var_6[var_6.size] = var_5.targetname;

        if(isDefined(var_5.animation) && isDefined(var_5.script_noteworthy)) {
          if(isDefined(level._id_EC85["generic"][var_5.script_noteworthy + "_enter"]))
            var_5.radius = 1024;
        }

        if(!isDefined(var_5.target) || scripts\engine\utility::array_contains(var_6, var_5.target)) {
          break;
        }

        var_5 = scripts\engine\utility::getStruct(var_5.target, "targetname");
      }
    }
  }

  for(;;) {
    self waittill("trigger");

    if(!isDefined(level._id_E977._id_E6D6[level._id_E977._id_D0F2])) {
      if(!isDefined(level._id_E977._id_E6E2[level._id_E977._id_D0F2]) || level._id_E977._id_E6E2[level._id_E977._id_D0F2]._id_41A9 || isDefined(level._id_E977._id_E6E2[level._id_E977._id_D0F2]._id_E9E7) && level._id_E977._id_E6E2[level._id_E977._id_D0F2]._id_E9E7 || scripts\engine\utility::is_true(level._id_112FC)) {
        wait 0.5;
        continue;
      }
    }

    if(var_0 >= 0) {
      var_8 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, var_1);

      if(var_8 < var_0) {
        wait 0.05;
        continue;
      }
    }

    if(!scripts\engine\utility::flag("ship_in_lockdown")) {
      _id_E999();

      if(self.script_count_min != -1) {
        self.script_count_min--;

        if(self.script_count_min == 0) {
          break;
        }
      }

      wait(self.script_delay);
      continue;
    }

    scripts\engine\utility::flag_waitopen("ship_in_lockdown");
  }
}

_id_E999() {
  var_0 = "ar";
  level._id_E977.spawners[var_0][0]._id_EE7E = 1;
  var_1 = scripts\engine\utility::getStructArray(self.target, "targetname");
  var_2 = var_1.size;
  var_3 = [];

  while(var_2 > 0) {
    level._id_E977.spawners[var_0][0].count = 99;
    var_4 = var_1[var_2 - 1];

    if(isDefined(var_4)) {
      level._id_E977.spawners[var_0][0].origin = var_4.origin;

      if(isDefined(var_4.angles))
        level._id_E977.spawners[var_0][0].angles = var_4.angles;

      var_5 = _id_E9AD(level._id_E977.spawners[var_0][0]);

      if(!isDefined(var_5)) {
        var_2--;
        continue;
      } else if(isDefined(var_5._id_41A9) && var_5._id_41A9 && !isDefined(level._id_E977._id_E6D6[var_5._id_1352E.targetname])) {
        var_2--;
        continue;
      }

      if(var_5._id_500C != "hot") {
        level._id_E977.spawners[var_0][0]._id_EED1 = var_5._id_10F48;
        level._id_E977.spawners[var_0][0]._id_EE7E = 1;
      } else {
        level._id_E977.spawners[var_0][0]._id_EED1 = undefined;
        level._id_E977.spawners[var_0][0]._id_EE7E = undefined;
      }

      var_6 = level._id_E977.spawners[var_0][0] scripts\sp\utility::_id_10619(1);
      waittillframeend;

      if(!isDefined(var_6)) {
        wait 0.05;
        continue;
      }

      var_6._id_1074F = var_0;
      var_6._id_C9A6 = var_4;
      var_6.goalradius = 32;
      var_6.script_noteworthy = self.script_noteworthy + "_guys";

      if(isDefined(var_6._id_10E6D))
        var_6._id_10E6D._id_24CB = 800;

      if(var_5._id_500C != "hot")
        var_6 thread _id_E9F4(var_5);

      var_6 thread _id_E9D5(var_5);
      var_3[var_3.size] = var_6;
      wait 0.05;
    }

    var_2--;
  }

  level notify(self.script_noteworthy);
  var_3 = scripts\sp\utility::array_removedeadvehicles(var_3);

  if(var_3.size >= 0)
    scripts\sp\utility::_id_13754(var_3);
}

_id_E9AD(var_0) {
  foreach(var_2 in level._id_1640) {
    if(isDefined(level._id_E977._id_E6E2[var_2])) {
      if(level._id_E977._id_E6E2[var_2]._id_1352E istouching(var_0))
        return level._id_E977._id_E6E2[var_2];
    }
  }

  return undefined;
}

_id_E9D5(var_0) {
  if(isDefined(self._id_10E6D)) {
    _id_0F27::_id_F341("run");
    self._id_10E6D._id_117EB = 0.5;
    self._id_10E6D._id_6896 = "combat";
    self._id_10E6D._id_117CA = 0;
    self._id_BFE4 = 1;
  }

  self._id_BE0D = var_0;
  self.goalheight = 72;
  _id_3DBB(self._id_C9A6);
  thread _id_0B77::_id_8409(self._id_C9A6, undefined, ::_id_E9CF, undefined, undefined);
  var_1 = self._id_C9A6;
  var_2 = 1;

  if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "no_delete_on_end" || var_0._id_500C == "hot")
    var_2 = 0;

  for(;;) {
    var_3 = scripts\engine\utility::waittill_any_in_array_return_no_endon_death(level._id_E9CD);

    if(isDefined(var_1) && isDefined(var_1._id_BE0C)) {
      var_1._id_BE0C = undefined;
      var_1.last_used_time = gettime();
    }

    if(var_3 != "death")
      self._id_C9A6 = undefined;

    if(var_3 == "death" || var_3 == "enemy" || self.alertlevel == "combat" || var_3 == "stealth_spotted") {
      self notify("stop_going_to_node");

      if(!isDefined(var_0))
        var_0 = _id_E9AD(self);

      if(!isDefined(var_0)) {
        return;
      }
      if(var_0._id_43FD == 1 && var_3 != "death") {
        self.disablearrivals = 0;
        thread _id_896B(var_0);

        if(_id_E6DD(var_0))
          level thread _id_E9B9(var_0);
      }

      return;
    }

    break;
  }

  self.disablearrivals = 0;

  if(var_2)
    self delete();

  if(var_0._id_500C == "hot")
    thread _id_896B(var_0);
}

_id_E9C0(var_0) {
  if(var_0._id_939C || var_0._id_500C == "hot")
    return 1;

  return 0;
}

_id_E6DD(var_0) {
  if(var_0._id_939C || var_0._id_500C == "hot" || scripts\engine\utility::is_true(var_0._id_41A9))
    return 0;

  return 1;
}

_id_F936() {
  level._id_E6DF = [];
  level._id_E6DF[level._id_E6DF.size] = "sa_hangar_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_armory_room_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_hubstern_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_hubbow_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_bridge_atrium_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_bridge_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_bridge_com_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_barracks_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_sternport_rooma_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_sternport_roomb_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_sternstarboard_rooma_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_sternstarboard_roomb_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_starboard_lower_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_starboard_lower_rooma_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_bowupper_rooma_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_bowupper_roomb_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_bowlower_rooma_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_bowlower_roomb_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_barracks_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_portjunction_rooma_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_midship_room_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_portmid_room_vol";
  level._id_E6DF[level._id_E6DF.size] = "sac_hubstern_port_vol";
  level._id_E6DF[level._id_E6DF.size] = "sac_portlower_vol";
  level._id_E6DF[level._id_E6DF.size] = "sac_bowupper_vol";
  level._id_E6DF[level._id_E6DF.size] = "sac_bowlower_vol";
  level._id_E6DF[level._id_E6DF.size] = "sac_sternstarboard_vol";
  _id_965B();
}

_id_F92C() {
  level._id_E6DF = [];
  level._id_E6DF[level._id_E6DF.size] = "sa_hubstern_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_bridge_atrium_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_bridge_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_barracks_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_processing_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_starboardjunction_rooma_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_port_elbow_rooma_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_portjunction_rooma_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_lab_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_waist_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_starboardjunction_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_starboardmain_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_portjunction_vol";
  level._id_E6DF[level._id_E6DF.size] = "sa_portelbow_vol";
  _id_965B();
}

_id_F90A() {
  level._id_E6DF = [];
  level._id_E6DF[0] = "sa_hangar_vol";
  _id_965B();
}

_id_965B() {
  level._id_E6E0 = [];

  foreach(var_1 in level._id_E6DF) {
    var_2 = getEnt(var_1, "targetname");

    if(isDefined(var_2)) {
      var_2._id_1AE3 = [];
      var_2._id_13D76 = [];
      var_2.path = [];
      var_2.path["forward"] = [];
      var_2.path["backward"] = [];
      level._id_E6E0[var_2.targetname] = var_2;
    }
  }

  var_4 = scripts\engine\utility::getStructArray("forcepatrol_spot", "targetname");

  foreach(var_6 in var_4) {
    if(isDefined(var_6.script_noteworthy) && isDefined(level._id_E6E0[var_6.script_noteworthy])) {
      var_2 = level._id_E6E0[var_6.script_noteworthy];

      if(!isDefined(level._id_E6E0[var_6.script_noteworthy]._id_7283))
        var_2._id_7283 = [];

      var_2._id_7283[var_2._id_7283.size] = var_6;
    }
  }
}