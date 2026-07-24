/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3805.gsc
**************************************/

#using_animtree("player");

_id_CF6C() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
}

_id_B0B5() {
  level thread _id_F56B();
  _id_9877();
  scripts\engine\utility::flag_init("viewer_on");
}

_id_9877() {
  _id_7D4A();
  _id_13394();
  _id_13397();
  _id_13398();
  _id_144C();
  level thread _id_13396();
}

_id_7D4A() {
  level._id_B0C0 = spawnStruct();
  level._id_B0C0._id_99FC = scripts\engine\utility::getStruct("lounger_viewer_remote_struct", "targetname");
  level._id_B0C0._id_99FB = getEnt("lounge_viewer_tablet", "targetname");
  level._id_B0C0._id_6F1D = scripts\engine\utility::getStruct("lounge_flight_record_interact", "targetname");
  level._id_B0C0._id_30E3 = getEnt("lounge_brdcst_still", "targetname");
  level._id_B0C0._id_2AE5 = getEnt("lounge_brdcst_bink", "targetname");
  level._id_B0C0._id_9C81 = 0;
  level._id_B0C1 = getEntArray("lounge_view_image", "script_noteworthy");
  level._id_B0B3 = getEntArray("lounge_flight_record_image", "script_noteworthy");

  foreach(var_1 in level._id_B0C1) {
    var_1 delete();
  }

  setomnvar("ui_inworld_viewer_ent", level._id_B0C0._id_99FB);
}

_id_8EB2() {
  level._id_B0C0._id_30E3 hide();
  level._id_B0C0._id_2AE5 hide();
  scripts\engine\utility::array_call(level._id_B0B3, ::hide);
}

_id_13398() {
  level._id_B0C0._id_30E3 show();
  level._id_B0C0._id_2AE5 hide();
}

#using_animtree("script_model");

_id_13394() {
  level._id_EC87["remote"] = #animtree;
  level._id_EC8C["remote"] = "p7_desk_metal_military_03_tablet";
  level._id_EC85["remote"]["viewer_enter"] = % lounge_remote_prop_pickup;
  level._id_EC85["remote"]["viewer_exit"] = % lounge_remote_prop_putdown;
}

#using_animtree("player");

_id_13397() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["viewer_enter"] = % lounge_remote_plyr_pickup;
  level._id_EC85["player_rig"]["viewer_exit"] = % lounge_remote_plyr_putdown;
}

_id_13396() {
  wait 1.0;
  var_0 = level._id_B0C0._id_99FC;

  if(!isDefined(var_0)) {
    return;
  }
  var_0.enabled = 1;
  var_1 = level._id_B0C0._id_99FB;
  level._id_B0A5 scripts\sp\anim::_id_1EC3(level._id_D1E1, "viewer_enter");
  var_0 _id_0E46::_id_48C4(undefined, undefined, var_0.hint_string, 30, 250, 70, 1);
  var_0 waittill("trigger");
  level._id_D1E1 _id_0EFB::_id_FDD7(1);
  wait 0.05;
  level.player playerlinkTo(level._id_D1E1);
  level.player _meth_823C(level._id_D1E1, "tag_player", 0.75, 0.25, 0.25);
  wait 0.8;
  level.player playerlinktodelta(level._id_D1E1, "tag_player", 0, 0, 0, 0, 0, 1);
  var_0.enabled = undefined;
  level._id_D1E1 show();
  level._id_B0A5 scripts\sp\anim::_id_1F2C([level._id_D1E1, var_1], "viewer_enter");
  _id_C60C();
}

_id_144C() {
  var_0 = level._id_B0C0._id_99FC;

  if(!isDefined(var_0)) {
    return;
  }
  var_0.enabled = 1;
  var_1 = level._id_B0C0._id_99FB;
  var_1._id_1FBB = "remote";
  var_1 scripts\sp\anim::_id_F64A();
  level._id_B0A5 = var_0 scripts\engine\utility::spawn_tag_origin();
  level._id_D1E1 = _id_0EFB::_id_FE02("player_rig", level.player.origin, level.player.angles);
  level._id_D1E1 hide();
}

_id_C60C() {
  setomnvar("ui_lounge_invoke", 1);
  level._id_B0C0._id_30E3 hide();
  level._id_B0C0 thread _id_3C4E();
  level._id_B0C0 thread _id_CCB1();

  for(;;) {
    level.player waittill("luinotifyserver", var_0);

    if(var_0 == "lounge_viewer_exit") {
      break;
    }
  }

  level._id_B0C0 notify("closed_menu");
  setomnvar("ui_lounge_invoke", 0);
  var_1 = level._id_B0C0._id_99FB;
  level._id_B0A5 scripts\sp\anim::_id_1F2C([level._id_D1E1, var_1], "viewer_exit");
  level.player unlink();
  level._id_D1E1 hide();
  level thread _id_13396();
}

_id_13395(var_0) {
  var_1 = getEnt("bridge_lounge_tv", "script_noteworthy");

  if(isDefined(var_1)) {
    switch (var_0) {
      case "sc_world_lounge_drops":
        var_1._id_438F = (0.87451, 0.87451, 0.917647);
        var_1._id_4390 = (0.87451, 0.87451, 0.917647);
        break;
      case "sc_world_lounge_europaloop":
        var_1._id_438F = (0.862745, 0.92549, 0.643137);
        var_1._id_4390 = (0.705882, 0.862745, 0.74902);
        break;
      case "sc_world_lounge_sunloop":
        var_1._id_99E6 = 14;
        var_1._id_99E7 = 10;
        var_1._id_438F = (0.988235, 0.752941, 0.321569);
        var_1._id_4390 = (0.992157, 0.823529, 0.317647);
        break;
      case "sc_world_lounge_woundedloop":
      case "sc_world_lounge_titanloop":
        var_1._id_438F = (0.992157, 0.945098, 0.858824);
        var_1._id_4390 = (0.992157, 0.945098, 0.858824);
        break;
      default:
        var_1._id_4390 = (0.752941, 0.819608, 0.996078);
        break;
    }
  }
}

_id_3C4E() {
  var_0 = 0;
  var_1 = ["sc_world_lounge_woundedloop", "sc_world_lounge_sunloop", "sc_world_lounge_europaloop", "sc_world_lounge_titanloop"];
  var_2 = [];
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");

  for(;;) {
    level.player waittill("luinotifyserver", var_3);

    if(var_3 == "lounge_viewer_exit") {
      break;
    }

    if(var_3 == "change_view") {
      if(isDefined(level._id_B0C0._id_30E5)) {
        level._id_B0C0._id_30E5 notify("trigger");
      }

      self notify("change_view");
      level._id_B0C0._id_30E3 hide();
      level._id_B0C0._id_2AE5 show();
      stopcinematicingame();

      if(var_1.size < 1) {
        var_1 = var_2;
        var_2 = [];
      }

      var_4 = randomint(var_1.size);
      var_5 = var_1[var_4];
      var_2 = scripts\engine\utility::array_add(var_2, var_5);
      var_1 = scripts\sp\utility::array_remove_index(var_1, var_4);
      _id_13395(var_5);
      cinematicingameloopresident(var_5);
    }

    scripts\engine\utility::waitframe();
  }
}

_id_CCB1(var_0, var_1) {
  var_0 = _id_0EE9::_id_7C5D();
  var_1 = "bink3d_broadcast_news";

  if(!isDefined(level.broadcast_counter)) {
    level.broadcast_counter = 0;
  }

  if(!isDefined(level.viewer_broadcasts)) {
    level.viewer_broadcasts = [];
  }

  var_2 = _id_0EE9::_id_7BDD();
  var_3 = getarraykeys(var_2);

  foreach(var_6, var_5 in var_2) {
    if(var_5 == "watched") {
      level.viewer_broadcasts = scripts\engine\utility::array_add(level.viewer_broadcasts, var_6);
    }
  }

  level.viewer_broadcasts = scripts\engine\utility::array_remove_duplicates(level.viewer_broadcasts);

  for(;;) {
    level.player waittill("luinotifyserver", var_7);

    if(var_7 == "lounge_viewer_exit") {
      break;
    }

    if(var_7 == "play_broadcast") {
      stopcinematicingame();

      if(var_0 == "none") {
        level._id_B0C0._id_30E3 show();
      } else {
        _id_62C5();
        level.broadcast_counter++;

        if(level.broadcast_counter > level.viewer_broadcasts.size - 1) {
          level.broadcast_counter = 0;
        }

        var_0 = _id_0EE9::_id_7C5D(level.viewer_broadcasts[level.broadcast_counter]);
        _id_2A5C(var_0, var_1);
        thread _id_E271();
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_62C5() {
  self notify("reset_broadcast");

  if(isDefined(self._id_10928)) {
    self._id_10928 stopsounds();
    scripts\engine\utility::waitframe();
    self._id_10928 delete();
  }

  self._id_9C81 = 0;
  stopcinematicingame();
  level._id_B0C0._id_30E3 show();
  level._id_B0C0._id_2AE5 hide();
  wait 0.5;
}

_id_2A5C(var_0, var_1) {
  level._id_B0C0._id_30E3 hide();
  level._id_B0C0._id_2AE5 show();

  if(isDefined(var_1) && var_1 != "none") {
    level._id_B0C0._id_10928 = scripts\engine\utility::getStruct("broadcast_speaker", "targetname");
    level._id_B0C0._id_10928 = spawn("script_origin", level._id_B0C0._id_10928.origin);
    level._id_B0C0._id_10928 playSound(var_1);
  }

  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame(var_0);
  scripts\sp\utility::_id_834F("NEWSCAST");
  self._id_9C81 = 1;
}

_id_E271() {
  self endon("reset_broadcast");

  while(!iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  while(iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  self._id_2AE5 hide();
  self._id_30E3 show();
  self._id_9C81 = 0;

  if(isDefined(self._id_10928)) {
    self._id_10928 stopsounds();
    self._id_10928 scripts\engine\utility::delaycall(0.05, ::delete);
  }
}

_id_30DE() {
  self endon("reset_broadcast");
  level._id_B0C0._id_30E5 = getEnt("lounge_broadcast_stop", "targetname");
  level._id_B0C0._id_30E5 waittill("trigger");

  if(self._id_9C81) {
    stopcinematicingame();
    self._id_2AE5 hide();
    self._id_30E3 hide();

    if(isDefined(self._id_10928)) {
      self._id_10928 stopsounds();
      scripts\engine\utility::waitframe();
      self._id_10928 delete();
    }

    self._id_9C81 = 0;
  }
}

_id_F56B() {
  setdvarifuninitialized("recent_broadcast", "none");
  setdvarifuninitialized("recent_broadcast_audio", "none");
  var_0 = level.script;

  switch (var_0) {
    case "shipcrib_titan":
      setDvar("recent_broadcast", "sc_titan_world_newscast");
      setDvar("recent_broadcast_audio", "bink3d_broadcast_news_shipcrib_titan");
      break;
    case "shipcrib_europa":
      setDvar("recent_broadcast", "sc_europa_world_newscast");
      setDvar("recent_broadcast_audio", "bink3d_broadcast_news_shipcrib_europa");
      break;
    case "shipcrib_gravity":
      setDvar("recent_broadcast", "none");
      setDvar("recent_broadcast_audio", "bink3d_broadcast_news_shipcrib_titan");
      break;
    case "shipcrib_rogue":
      setDvar("recent_broadcast", "sc_world_lounge_titanloop");
      setDvar("recent_broadcast_audio", "none");
      break;
    case "shipcrib_prisoner":
      setDvar("recent_broadcast", "none");
      setDvar("recent_broadcast_audio", "bink3d_broadcast_news_shipcrib_titan");
      break;
  }
}

_id_986B() {
  level thread _id_6F1C();
}

_id_6F1C() {
  wait 1.0;
  var_0 = level._id_B0C0._id_6F1D;
  var_0.enabled = 1;
  var_0 waittill("trigger");
  var_0.enabled = undefined;
  level._id_B0C0._id_BC0E = scripts\engine\utility::spawn_tag_origin(level.player.origin, level.player.angles);
  var_1 = scripts\engine\utility::getStruct("player_flight_record_moveto", "targetname");
  _id_13654(var_1, 1, 1.0, -20.0);
  level thread _id_C615();
}

_id_5552(var_0) {
  var_1 = level._id_B0C0._id_99FC;

  if(isDefined(var_1)) {
    var_1.enabled = 0;
    var_1.hint_string = &"SHIPCRIB_USEVIEWER";
    var_1 thread _id_0E46::_id_DFE3();
  }
}

_id_5553() {
  var_0 = _id_0EE8::_id_7CF3("lounge_terminal");
  var_0 thread _id_0E46::_id_DFE3();
}

_id_6217(var_0) {
  var_1 = level._id_B0C0._id_99FC;

  if(isDefined(var_1.enabled) && var_1.enabled) {
    return;
  }
  var_1.hint_string = &"SHIPCRIB_USEVIEWER";
  var_1 thread _id_0E46::_id_48C4(undefined, undefined, var_1.hint_string, 30, 250, 70);
}

_id_6218() {}

_id_C615() {
  setomnvar("ui_lounge_record_invoke", 1);

  for(;;) {
    level.player waittill("luinotifyserver", var_0);

    if(var_0 == "exit_lounge_menu") {
      break;
    }
  }

  level._id_B0C0 notify("closed_menu");
  setomnvar("ui_lounge_record_invoke", 0);
  level.player unlink();

  if(isDefined(level._id_B0C0._id_BC0E)) {
    level._id_B0C0._id_BC0E delete();
  }

  level thread _id_6F1C();
}

_id_13654(var_0, var_1, var_2, var_3) {
  var_4 = _id_0EFB::_id_FE02("player_rig");
  var_4 hide();
  var_5 = 1.0;

  if(isDefined(var_3)) {
    var_5 = var_3;
  }

  var_6 = undefined;

  if(isDefined(var_0)) {
    var_7 = var_0;
    var_6 = var_7 scripts\engine\utility::spawn_tag_origin();
    var_6.origin = var_6.origin + anglesToForward(var_6.angles) * var_5;
    var_6.angles = var_6.angles + anglesToForward(var_6.angles) * 1.0;
    var_6.angles = var_6.angles + anglestoright(var_6.angles) * 1.0;
  } else
    var_6 = level._id_B0C0._id_BC0E;

  var_4.origin = var_6.origin;
  var_4.angles = var_6.angles;

  if(var_1) {
    level.player freezecontrols(1);
  } else {
    level.player freezecontrols(0);
  }

  level.player _meth_823C(var_4, "tag_player", var_2);
  wait(var_2);

  if(var_1) {
    level.player playerlinktodelta(var_4, "tag_player", 0.0, 30.0, 30.0, 30.0, 30.0);
  } else {
    level.player unlink();
  }

  var_6 delete();
  level._id_EFED = "inside";
}