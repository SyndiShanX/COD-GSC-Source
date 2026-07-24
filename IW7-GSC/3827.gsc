/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3827.gsc
**************************************/

_id_FDCE(var_0, var_1, var_2, var_3) {
  level _id_0EFB::_id_FE05();

  if(isDefined(level._id_FD6E._id_CBBE) && !isDefined(var_1)) {}

  if(isDefined(self) && isDefined(self._id_FDD3)) {
    self._id_FDD3 delete();
  }

  var_4 = undefined;
  var_5 = undefined;
  level._id_FD6E._id_CBBE = var_0;

  switch (var_0) {
    case "admiral_main":
      if(!isDefined(level._id_188A)) {
        _id_0EF8::_id_FDFC("spawner_admiral", "admirals_office");
      }

      if(!isDefined(var_1)) {
        var_6 = scripts\engine\utility::getStruct("admirals_office", "targetname");
        var_6 notify("stop_loop");
      }

      if(isDefined(var_2) && var_2) {
        setsaveddvar("bg_cinematicFullScreen", "0");
        setsaveddvar("bg_cinematicCanPause", "1");
        cinematicingame(var_3);
        level thread _id_E361("main", "pip_on", 1);

        while(!iscinematicplaying()) {
          wait 0.05;
        }

        while(iscinematicplaying()) {
          wait 0.05;
        }

        stopcinematicingame();
        setsaveddvar("bg_cinematicFullScreen", "1");
        setsaveddvar("bg_cinematicCanPause", "1");
        break;
      }

      var_4 = level._id_188A;
      var_5 = getEnt("admirals_office_cam", "targetname");
      level._id_188A._id_FDD3 = var_5 scripts\engine\utility::spawn_tag_origin();
      scripts\sp\pip_util::_id_CBB5(level._id_188A._id_FDD3, "tag_origin", 20);
      setomnvar("ui_show_pip", 0);
      level._id_CB9C.aspectratio = 0.75;
      level._id_CB9C.height = 1024;
      level thread _id_E361("main", "pip_on", 1);
      break;
    case "admiral_captains":
      if(!isDefined(level._id_188A)) {
        _id_0EF8::_id_FDFC("spawner_admiral", "admirals_office");
      }

      if(!isDefined(var_1)) {
        var_6 = scripts\engine\utility::getStruct("admirals_office", "targetname");
        var_6 notify("stop_loop");
      }

      if(isDefined(var_2) && var_2) {
        setsaveddvar("bg_cinematicFullScreen", "0");
        setsaveddvar("bg_cinematicCanPause", "1");
        cinematicingame(var_3);
        level thread _id_E361("captains", "pip_on", 1);

        while(!iscinematicplaying()) {
          wait 0.05;
        }

        while(iscinematicplaying()) {
          wait 0.05;
        }

        stopcinematicingame();
        setsaveddvar("bg_cinematicFullScreen", "1");
        setsaveddvar("bg_cinematicCanPause", "1");
        break;
      }

      var_4 = level._id_188A;
      var_5 = getEnt("admirals_office_cam", "targetname");
      level._id_188A._id_FDD3 = var_5 scripts\engine\utility::spawn_tag_origin();
      scripts\sp\pip_util::_id_CBB5(level._id_188A._id_FDD3, "tag_origin", 20);
      setomnvar("ui_show_pip", 0);
      level._id_CB9C.aspectratio = 0.75;
      level._id_CB9C.height = 1024;
      level thread _id_E361("captains", "pip_on", 1);
      break;
    case "admiral_cic":
      if(!isDefined(level._id_188A)) {
        _id_0EF8::_id_FDFC("spawner_admiral", "admirals_office");
      }

      if(!isDefined(var_1)) {
        var_6 = scripts\engine\utility::getStruct("admirals_office", "targetname");
        var_6 notify("stop_loop");
        var_6 thread scripts\sp\anim::_id_1ECC(level._id_188A, "stand_hands_tied_idle", "stop_loop");
      }

      var_4 = level._id_188A;
      var_5 = getEnt("admirals_office_cam_face", "targetname");
      level._id_188A._id_FDD3 = var_5 scripts\engine\utility::spawn_tag_origin();
      scripts\sp\pip_util::_id_CBB5(level._id_188A._id_FDD3, "tag_origin", 20);
      setomnvar("ui_show_pip", 0);
      level._id_CB9C.aspectratio = 1.2;
      break;
    case "gator_opsmap":
      if(!isDefined(level._id_76FB)) {
        _id_0EF8::_id_FDFC("spawner_gator", level._id_C6AA["retribution"]._id_10E52["nav"]);
        level._id_76FB._id_FDD2 = 1;
      } else {
        level._id_76FB._id_FDD1 = level._id_76FB.origin;
        level._id_76FB._id_FDD0 = level._id_76FB.angles;
      }

      var_4 = level._id_76FB;
      level._id_76FB _meth_80F1(level._id_C6AA["retribution"]._id_10E52["nav"].origin, level._id_C6AA["retribution"]._id_10E52["nav"].angles);
      var_5 = _id_0EFB::_id_7CBD("opsmap", "script_noteworthy", "nav_cam", "retribution");
      level._id_76FB._id_FDD3 = var_5 scripts\engine\utility::spawn_tag_origin();
      scripts\sp\pip_util::_id_CBB5(level._id_76FB._id_FDD3, "tag_origin", 20);
      break;
    case "gator_opsmap_captain":
      if(!isDefined(level._id_76FB)) {
        _id_0EF8::_id_FDFC("spawner_gator", level._id_C6AA["retribution"]._id_10E52["captain"]);
        level._id_76FB._id_FDD2 = 1;
      } else {
        level._id_76FB._id_FDD1 = level._id_76FB.origin;
        level._id_76FB._id_FDD0 = level._id_76FB.angles;
      }

      level._id_76FB _meth_80F1(level._id_C6AA["retribution"]._id_10E52["captain"].origin, level._id_C6AA["retribution"]._id_10E52["captain"].angles);
      var_5 = _id_0EFB::_id_7CBD("opsmap", "script_noteworthy", "captain_cam", "retribution");
      level._id_76FB._id_FDD3 = var_5 scripts\engine\utility::spawn_tag_origin();
      scripts\sp\pip_util::_id_CBB5(level._id_76FB._id_FDD3, "tag_origin", 20);
      break;
    case "gator_opsmap_captain_mission":
      var_7 = _id_0EFB::_id_7CBE("opsmap_station_captain", "targetname", "retribution_bridge_pip");
      self _meth_80F1(var_7.origin, var_7.angles);
      self setgoalpos(self.origin);
      var_8 = _id_0EFB::_id_7CBD("opsmap_bridge_pip", "script_noteworthy", "captain_cam", "retribution_bridge_pip");
      self._id_FDD3 = var_8 scripts\engine\utility::spawn_tag_origin();
      scripts\sp\pip_util::_id_CBB5(self._id_FDD3, "tag_origin", 20);
      break;
    case "jackal_pilot":
      self._id_FDD3 = scripts\engine\utility::spawn_tag_origin();
      self._id_FDD3.origin = self gettagorigin("tag_pip");
      self._id_FDD3.angles = self gettagangles("tag_pip");
      scripts\sp\pip_util::_id_CBB5(self._id_FDD3, "tag_origin", 60);
      break;
    case "jackal_copilot":
      self._id_FDD3 = scripts\engine\utility::spawn_tag_origin();
      self._id_FDD3.origin = self gettagorigin("tag_pip_copilot");
      self._id_FDD3.angles = self gettagangles("tag_pip_copilot");
      scripts\sp\pip_util::_id_CBB5(self._id_FDD3, "tag_origin", 60);
      break;
    case "salter_jackal_launch":
      if(!isDefined(level._id_FD6E.jackals["jackal_bay_2"])) {}

      var_5 = level._id_FD6E.jackals["jackal_bay_2"];
      scripts\sp\pip_util::_id_CBB5(var_5, "tag_cockpit_light_top", 65);
      break;
    case "salter_jackal_land":
      if(!isDefined(level._id_E35D._id_A2E8["b"]._id_A056)) {}

      var_5 = level._id_E35D._id_A2E8["b"]._id_A056;
      scripts\sp\pip_util::_id_CBB5(var_5, "tag_cockpit_light_top", 65, undefined, undefined, 0);
      break;
    case "salter_jackal_test":
      var_9 = getEnt("jackal", "targetname");

      if(!isDefined(level._id_EA2C)) {
        _id_0EF8::_id_FDFC("spawner_salter", var_9);
      }

      var_5 = getEnt("jackal_pip", "targetname") scripts\engine\utility::spawn_tag_origin();
      scripts\sp\pip_util::_id_CBB5(var_5, "tag_origin", 60);
      break;
    case "copilot_jackal_test":
      var_5 = getEnt("jackal_pip_copilot", "targetname") scripts\engine\utility::spawn_tag_origin();
      scripts\sp\pip_util::_id_CBB5(var_5, "tag_origin", 90);
      break;
    case "salter_jackal_test_low":
      var_9 = getEnt("jackal", "targetname");

      if(!isDefined(level._id_EA2C)) {
        _id_0EF8::_id_FDFC("spawner_salter", var_9);
      }

      var_5 = getEnt("jackal_pip_taylor", "targetname") scripts\engine\utility::spawn_tag_origin();
      scripts\sp\pip_util::_id_CBB5(var_5, "tag_origin", 60);
      break;
    case "copilot_jackal_test_low":
      var_5 = getEnt("jackal_pip_copilot_taylor_ethan", "targetname") scripts\engine\utility::spawn_tag_origin();
      scripts\sp\pip_util::_id_CBB5(var_5, "tag_origin", 60);
      break;
    case "ethan_workshop":
      var_5 = _id_0EFB::_id_7CBD("opsmap", "script_noteworthy", "nav_cam", "retribution");
      scripts\sp\pip_util::_id_CBB5(var_5, "tag_origin", 65);
      break;
    case "ferran_opsmap":
      if(isDefined(var_2) && var_2) {
        scripts\sp\utility::_id_9131(var_3);

        if(scripts\engine\utility::flag_exist("pip_hold")) {
          scripts\engine\utility::flag_clear("pip_hold");
        }

        break;
      }

      if(!isDefined(level._id_6BD5)) {
        _id_0EF8::_id_FDFC("spawner_ferran", level._id_C6AA["tigris"]._id_10E52["captain"]);
      }

      var_5 = _id_0EFB::_id_7CBD("opsmap", "script_noteworthy", "captain_cam_ferran", "tigris");
      level._id_6BD5._id_FDD3 = var_5 scripts\engine\utility::spawn_tag_origin();
      scripts\sp\pip_util::_id_CBB5(level._id_6BD5._id_FDD3, "tag_origin", 20);
      break;
    default:
      level._id_FD6E._id_CBBE = undefined;
      break;
  }

  if(getdvarint("pip_aspect_test", 0) == 1) {
    if(isDefined(var_4)) {
      var_4 hide();
      level._id_1BDF = spawn("script_model", var_4 gettagorigin("j_head") + (0, 0, 3));
      level._id_1BDF.angles = var_5.angles;
      level._id_1BDF setModel("test_pip_aspect_ratio_01");
    }
  }
}

_id_FDCF() {
  scripts\sp\pip_util::_id_CBA3();

  if(isDefined(self._id_FDD3)) {
    self._id_FDD3 delete();
  }

  if(!isDefined(level._id_FD6E._id_CBBE)) {
    return;
  }
  switch (level._id_FD6E._id_CBBE) {
    case "admiral_full":
    case "admiral_main":
      if(isDefined(level._id_188A._id_FDD3)) {
        level._id_188A._id_FDD3 delete();
      }

      _id_0EFB::_id_FDBA(level._id_188A);
      level thread _id_E361("main", "pip_off");
      break;
    case "admiral_captains":
      if(isDefined(level._id_188A._id_FDD3)) {
        level._id_188A._id_FDD3 delete();
      }

      _id_0EFB::_id_FDBA(level._id_188A);
      level thread _id_E361("captains", "pip_off");
      break;
    case "admiral_cic":
      level._id_188A._id_FDD3 delete();
      _id_0EFB::_id_FDBA(level._id_188A);
      level thread _id_E361("cic", "pip_off");
      break;
    case "gator_opsmap_captain":
    case "gator_opsmap":
      level._id_76FB._id_FDD3 delete();
      level._id_76FB _meth_80F1(level._id_76FB._id_FDD1, level._id_76FB._id_FDD0);

      if(isDefined(level._id_76FB._id_FDD2)) {
        level._id_76FB._id_FDD2 = undefined;
        _id_0EFB::_id_FDBA(level._id_76FB);
      }

      break;
    case "salter_jackal":
      level._id_EA2C._id_FDD3 delete();
      break;
    case "ethan_workshop":
      break;
    case "ferran_opsmap":
      if(isDefined(level._id_6BD5._id_FDD3)) {
        level._id_6BD5._id_FDD3 delete();
      }

      _id_0EFB::_id_FDBA(level._id_6BD5);
      break;
  }

  if(isDefined(level._id_1BDF)) {
    level._id_1BDF delete();
  }

  level._id_FD6E._id_CBBE = undefined;
}

_id_FD78(var_0, var_1) {
  switch (var_0) {
    case "admiral_main":
      setsaveddvar("bg_cinematicFullScreen", "0");
      setsaveddvar("bg_cinematicCanPause", "1");
      var_2 = level._id_E35D._id_188C["main"];
      var_3 = spawn("script_origin", var_2["model"].origin);
      var_3 playSound("bink3d_shipcrib_briefing");
      cinematicingame(var_1);
      level thread _id_E361("main", "pip_on", 1);

      while(!iscinematicplaying()) {
        wait 0.05;
      }

      while(iscinematicplaying()) {
        wait 0.05;
      }

      stopcinematicingame();
      var_3 stopsounds();
      scripts\engine\utility::waitframe();
      var_3 delete();
      setsaveddvar("bg_cinematicFullScreen", "1");
      setsaveddvar("bg_cinematicCanPause", "1");
      level thread _id_E361("main", "pip_off");
      break;
    case "admiral_captains":
      setsaveddvar("bg_cinematicFullScreen", "0");
      setsaveddvar("bg_cinematicCanPause", "1");
      var_2 = level._id_E35D._id_188C["captains"];
      var_3 = spawn("script_origin", var_2["model"].origin);
      var_3 playSound("bink3d_shipcrib_briefing");
      cinematicingame(var_1);
      level thread _id_E361("captains", "pip_on", 1);

      while(!iscinematicplaying()) {
        wait 0.05;
      }

      while(iscinematicplaying()) {
        wait 0.05;
      }

      stopcinematicingame();
      var_3 stopsounds();
      scripts\engine\utility::waitframe();
      var_3 delete();
      setsaveddvar("bg_cinematicFullScreen", "1");
      setsaveddvar("bg_cinematicCanPause", "1");
      level thread _id_E361("captains", "pip_off");
      break;
    case "pip":
      level.player playSound("ui_pip_on_hud_right");
      setomnvar("ui_pip_message_text_top", "script_pip_default_top");
      setomnvar("ui_pip_message_text_bottom", "script_pip_default_bottom");
      setsaveddvar("bg_cinematicFullScreen", "0");
      setsaveddvar("bg_cinematicCanPause", "1");
      setomnvar("ui_show_pip", 1);
      wait 0.05;
      setomnvar("ui_show_pip", 0);
      wait 0.05;
      setomnvar("ui_show_pip", 1);
      cinematicingame(var_1);

      while(!iscinematicplaying()) {
        wait 0.05;
      }

      while(iscinematicplaying()) {
        wait 0.05;
      }

      stopcinematicingame();
      setomnvar("ui_show_pip", 0);
      setsaveddvar("bg_cinematicFullScreen", "1");
      setsaveddvar("bg_cinematicCanPause", "1");

      if(scripts\engine\utility::flag_exist("pip_hold")) {
        scripts\engine\utility::flag_clear("pip_hold");
      }

      level.player playSound("ui_pip_off_hud_right");
      break;
    default:
      break;
  }
}

#using_animtree("script_model");

_id_E362() {
  _id_0EFB::_id_E3F7();
  level._id_E35D._id_188C["main"] = [];
  level._id_E35D._id_188C["main"]["pip"] = _id_0EFB::_id_798A("retribution_admiral_monitor_main", "script_noteworthy", "pip");
  level._id_E35D._id_188C["main"]["bink"] = _id_0EFB::_id_798A("retribution_admiral_monitor_main", "script_noteworthy", "bink");
  level._id_E35D._id_188C["main"]["lines"] = _id_0EFB::_id_798A("retribution_admiral_monitor_main", "script_noteworthy", "lines");
  level._id_E35D._id_188C["main"]["static"] = _id_0EFB::_id_798A("retribution_admiral_monitor_main", "script_noteworthy", "static");
  level._id_E35D._id_188C["main"]["transition_1"] = _id_0EFB::_id_798B("shipcrib_screen", "script_noteworthy", "transition_1", "admiral_main");
  level._id_E35D._id_188C["main"]["transition_1"] _meth_83D0(#animtree);
  level._id_E35D._id_188C["main"]["transition_2"] = _id_0EFB::_id_798B("shipcrib_screen", "script_noteworthy", "transition_2", "admiral_main");
  level._id_E35D._id_188C["main"]["transition_2"] _meth_83D0(#animtree);
  level._id_E35D._id_188C["main"]["transition_3"] = _id_0EFB::_id_798B("shipcrib_screen", "script_noteworthy", "transition_3", "admiral_main");
  level._id_E35D._id_188C["main"]["transition_3"] _meth_83D0(#animtree);
  level._id_E35D._id_188C["main"]["transition_4"] = _id_0EFB::_id_798B("shipcrib_screen", "script_noteworthy", "transition_4", "admiral_main");
  level._id_E35D._id_188C["main"]["transition_4"] _meth_83D0(#animtree);

  if(isDefined(level._id_FD6E) && isDefined(level._id_FD6E._id_ECCE) && isDefined(level._id_FD6E._id_ECCE["admiral_monitor"])) {
    level._id_E35D._id_188C["main"]["model"] = level._id_FD6E._id_ECCE["admiral_monitor"].ent;
  }

  level._id_E35D._id_188C["captains"] = [];
  level._id_E35D._id_188C["captains"]["pip"] = _id_0EFB::_id_798A("retribution_admiral_monitor_captains", "script_noteworthy", "pip");
  level._id_E35D._id_188C["captains"]["bink"] = _id_0EFB::_id_798A("retribution_admiral_monitor_captains", "script_noteworthy", "bink");
  level._id_E35D._id_188C["captains"]["lines"] = _id_0EFB::_id_798A("retribution_admiral_monitor_captains", "script_noteworthy", "lines");
  level._id_E35D._id_188C["captains"]["static"] = _id_0EFB::_id_798A("retribution_admiral_monitor_captains", "script_noteworthy", "static");
  level._id_E35D._id_188C["captains"]["transition_1"] = _id_0EFB::_id_798B("shipcrib_screen", "script_noteworthy", "transition_1", "admiral_captains");
  level._id_E35D._id_188C["captains"]["transition_1"] _meth_83D0(#animtree);
  level._id_E35D._id_188C["captains"]["transition_2"] = _id_0EFB::_id_798B("shipcrib_screen", "script_noteworthy", "transition_2", "admiral_captains");
  level._id_E35D._id_188C["captains"]["transition_2"] _meth_83D0(#animtree);
  level._id_E35D._id_188C["captains"]["transition_3"] = _id_0EFB::_id_798B("shipcrib_screen", "script_noteworthy", "transition_3", "admiral_captains");
  level._id_E35D._id_188C["captains"]["transition_3"] _meth_83D0(#animtree);
  level._id_E35D._id_188C["captains"]["transition_4"] = _id_0EFB::_id_798B("shipcrib_screen", "script_noteworthy", "transition_4", "admiral_captains");
  level._id_E35D._id_188C["captains"]["transition_4"] _meth_83D0(#animtree);

  if(isDefined(level._id_FD6E) && isDefined(level._id_FD6E._id_ECCE) && isDefined(level._id_FD6E._id_ECCE["admiral_monitor_captains"])) {
    level._id_E35D._id_188C["captains"]["model"] = level._id_FD6E._id_ECCE["admiral_monitor_captains"].ent;
  }

  level._id_E35D._id_188C["cic"] = [];
  level._id_E35D._id_188C["cic"]["pip"] = _id_0EFB::_id_798A("retribution_admiral_monitor_cic", "script_noteworthy", "pip");
  level._id_E35D._id_188C["cic"]["bink"] = _id_0EFB::_id_798A("retribution_admiral_monitor_cic", "script_noteworthy", "bink");
  level._id_E35D._id_188C["cic"]["lines"] = _id_0EFB::_id_798A("retribution_admiral_monitor_cic", "script_noteworthy", "lines");
  level._id_E35D._id_188C["cic"]["static"] = _id_0EFB::_id_798A("retribution_admiral_monitor_cic", "script_noteworthy", "static");

  if(isDefined(level._id_FD6E) && isDefined(level._id_FD6E._id_ECCE) && isDefined(level._id_FD6E._id_ECCE["admiral_monitor_cic"])) {
    level._id_E35D._id_188C["cic"]["model"] = level._id_FD6E._id_ECCE["admiral_monitor_cic"].ent;
  }

  _id_E360();
}

_id_E361(var_0, var_1, var_2) {
  var_3 = level._id_E35D._id_188C[var_0];

  if(isDefined(var_2)) {
    _id_E360();
  }

  var_4 = getEnt("bridge_" + var_0 + "_tv", "script_noteworthy");

  switch (var_1) {
    case "pip_on":
      if(isDefined(var_3["pip"])) {
        var_3["model"] playSound("shipcrib_briefing_bink_on");
        level thread _id_E364(var_3);
        var_3["model"] _meth_8189(var_3["model"]._id_CBB7);
        var_3["static"] show();
        wait 0.35;
        var_3["static"] hide();
        var_3["lines"] show();
        var_3["pip"] show();

        if(isDefined(var_4) && isDefined(var_4._id_ED32)) {
          var_4 _meth_82FC(var_4._id_ED32);
          var_4 scripts\sp\lights::_id_AB83(3, 0.5);
        }
      }

      break;
    case "pip_off":
      if(isDefined(var_3["pip"])) {
        var_3["model"] playSound("shipcrib_briefing_bink_off");
        level thread _id_E363(var_3);
        var_3["static"] show();
        var_3["lines"] hide();
        var_3["pip"] hide();
        wait 0.35;
        var_3["model"] showallparts(var_3["model"]._id_CBB7);
        var_3["model"] hidepart(var_3["model"]._id_ECDD);
        var_3["static"] hide();

        if(isDefined(var_4)) {
          var_4 _meth_82FC((0.8, 0.8, 1));
          var_4 scripts\sp\lights::_id_AB83(0.5, 0.5);
        }
      }

      break;
  }
}

_id_E363(var_0) {
  var_0["transition_1"] clearanim(%root, 0);
  var_0["transition_2"] clearanim(%root, 0);
  var_0["transition_3"] clearanim(%root, 0);
  var_0["transition_4"] clearanim(%root, 0);
  var_0["transition_1"] _meth_82A2(%shipcrib_admiral_monitor_transition_in_1, 1, 0, 1.5);
  var_0["transition_2"] _meth_82A2(%shipcrib_admiral_monitor_transition_in_2, 1, 0, 1.5);
  var_0["transition_3"] _meth_82A2(%shipcrib_admiral_monitor_transition_in_3, 1, 0, 1.5);
  var_0["transition_4"] _meth_82A2(%shipcrib_admiral_monitor_transition_in_4, 1, 0, 1.5);
  var_0["transition_4"] scripts\engine\utility::delaycall(0.0, ::showallparts);
  var_0["transition_2"] scripts\engine\utility::delaycall(0.15, ::showallparts);
  var_0["transition_3"] scripts\engine\utility::delaycall(0.3, ::showallparts);
  var_0["transition_1"] scripts\engine\utility::delaycall(0.45, ::showallparts);
}

_id_E364(var_0) {
  var_0["transition_1"] clearanim(%root, 0);
  var_0["transition_2"] clearanim(%root, 0);
  var_0["transition_3"] clearanim(%root, 0);
  var_0["transition_4"] clearanim(%root, 0);
  var_0["transition_1"] _meth_82A2(%shipcrib_admiral_monitor_transition_out_1, 1, 0, 1.5);
  var_0["transition_2"] _meth_82A2(%shipcrib_admiral_monitor_transition_out_2, 1, 0, 1.5);
  var_0["transition_3"] _meth_82A2(%shipcrib_admiral_monitor_transition_out_3, 1, 0, 1.5);
  var_0["transition_4"] _meth_82A2(%shipcrib_admiral_monitor_transition_out_4, 1, 0, 1.5);
  var_0["transition_1"] scripts\engine\utility::delaycall(0.15, ::_meth_8184);
  var_0["transition_2"] scripts\engine\utility::delaycall(0.3, ::_meth_8184);
  var_0["transition_3"] scripts\engine\utility::delaycall(0.45, ::_meth_8184);
  var_0["transition_4"] scripts\engine\utility::delaycall(0.6, ::_meth_8184);
}

_id_E360() {
  foreach(var_1 in level._id_E35D._id_188C["main"]) {
    if(issubstr(var_1.model, "shipcrib_screen_admiral_monitor_transition")) {
      continue;
    }
    if(!isDefined(var_1._id_CBB7)) {
      var_1 hide();
      continue;
    }

    var_1 hidepart(var_1._id_ECDD);
  }

  foreach(var_1 in level._id_E35D._id_188C["captains"]) {
    if(issubstr(var_1.model, "shipcrib_screen_admiral_monitor_transition")) {
      continue;
    }
    if(!isDefined(var_1._id_CBB7)) {
      var_1 hide();
      continue;
    }

    var_1 hidepart(var_1._id_ECDD);
  }

  foreach(var_1 in level._id_E35D._id_188C["cic"]) {
    if(!isDefined(var_1._id_CBB7)) {
      var_1 hide();
      continue;
    }

    var_1 hidepart(var_1._id_ECDD);
  }
}