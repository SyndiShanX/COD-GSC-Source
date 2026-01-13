/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2847.gsc
**************************************/

#using_animtree("script_model");

func_95B6() {
  level.doors = [];
  func_5983();
  func_1AC1();
  var_0 = getEntArray("generic_door", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.targetname) && isDefined(level.doors[var_2.targetname])) {
      if(!isDefined(level.var_FCD6) || level.var_FCD6 != 1) {
        continue;
      }
    }

    if(var_2.classname == "script_origin") {
      var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
      var_3.targetname = var_2.targetname;
      var_3.script_parameters = var_2.script_parameters;
      var_3.var_EDA0 = var_2.var_EDA0;
      var_2 = var_3;
    }

    if(isDefined(var_2.targetname)) {
      level.doors[var_2.targetname] = var_2;
      var_4 = getEntArray(var_2.targetname, "targetname");

      foreach(var_6 in var_4) {
        if(var_6.classname == "script_brushmodel") {
          var_2.collision = var_6;
        }
      }
    }

    var_2.var_5A18 = var_2.targetname;
    var_2.var_5A57 = var_2.script_parameters;
    var_2.var_1FBB = "door";
    var_2 glinton(#animtree);
    var_2 scripts\sp\utility::func_65E0("player_used_door");
    var_2 scripts\sp\utility::func_65E0("player_at_door");
    var_2 scripts\sp\utility::func_65E0("actor_at_door");
    var_2 scripts\sp\utility::func_65E0("begin_opening");
    var_2 scripts\sp\utility::func_65E0("door_opened");
    var_2 scripts\sp\utility::func_65E0("door_sequence_complete");
    var_2 scripts\sp\utility::func_65E0("no_anim_reach");
    var_2 scripts\sp\utility::func_65E0("skip_reach_on_use");

    if(isDefined(var_2.var_EDA0)) {
      var_2 scripts\sp\utility::func_65E0(var_2.var_EDA0);
    }

    var_2 scripts\sp\utility::func_65E0("locked");
    var_2 thread door_think();
  }

  thread func_9530("door_peek_armory");
}

door_think() {
  if(self.var_5A57 == "airlock" && self.model == "sdf_door_airlock_01") {
    scripts\sp\anim::func_1EC3(self, "airlock_open_player");
  }

  if(isDefined(self.var_EDA0)) {
    scripts\sp\utility::func_65E3(self.var_EDA0);
  }

  switch (self.var_5A57) {
    case "no_power":
      thread buddy_down_skip_post_clear();
      break;
    case "large_buddy":
      thread func_A852();
      break;
    case "armory":
      self.position = "closed";
      thread func_21E0();
      break;
    case "armory_door_peek":
      self.position = "closed";
      thread func_21E0();
      break;
    case "airlock":
      thread func_1AB0();
      break;
    case "bulkhead_door":
      thread func_3232();
  }
}

func_168A(var_0) {
  self.var_1684 = var_0;

  switch (self.var_5A57) {
    case "no_power":
      buddy_down_gunner_damage_thread(var_0);
      break;
    case "airlock":
      break;
  }
}

func_AED6() {
  if(!scripts\sp\utility::func_65DB("locked")) {
    scripts\sp\utility::func_65E1("locked");
    func_0E46::func_DFE3();
  }
}

func_12BD3() {
  if(scripts\sp\utility::func_65DB("locked")) {
    scripts\sp\utility::func_65DD("locked");
    func_0E46::func_48C4("tag_ui_front", (0, 0, -2));
  }
}

func_599E() {
  return scripts\sp\utility::func_65DB("locked");
}

func_1AB0() {
  var_0 = scripts\sp\utility::func_7A8F();
  scripts\engine\utility::array_call(var_0, ::linkto, self, "door_jnt");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "player_clip") {
      continue;
    }
    self.var_C969 = var_2;
  }

  if(isDefined(self.var_EF20) && self.var_EF20 == "notplayer") {
    return;
  }
  self.var_DF3A = 1;
  func_0E46::func_48C4("tag_ui_front");
  self waittill("trigger", var_4);
  scripts\sp\utility::func_65E1("player_at_door");
  var_5 = func_D0A6("airlock_open_player");
  scripts\sp\utility::func_65E1("begin_opening");
  var_6 = [self, var_5];

  if(soundexists("airlock_exit_door_open")) {
    level.player thread scripts\sp\utility::play_sound_on_entity("airlock_exit_door_open");
  }

  scripts\sp\anim::func_1F2C(var_6, "airlock_open_player");

  if(scripts\engine\utility::is_true(self.var_DF3A)) {
    level.player func_5990();
    level.player unlink();
    var_5 delete();
  }

  self.var_C969 connectpaths();
  self.var_C969 disconnectpaths();
  scripts\sp\utility::func_65E1("door_sequence_complete");
}

func_1AC1() {
  level.var_1AE3 = [];
  scripts\engine\utility::flag_init("airlocks_setup");
  level._effect["vfx_airlock_light_green"] = loadfx("vfx\iw7\_requests\airlock\vfx_light_green.vfx");
  level._effect["vfx_airlock_light_orange"] = loadfx("vfx\iw7\_requests\airlock\vfx_light_orange.vfx");
  level._effect["vfx_airlock_light_red"] = loadfx("vfx\iw7\_requests\airlock\vfx_light_red.vfx");
  level._effect["vfx_airlock_vent_xtrlrg_press"] = loadfx("vfx\iw7\core\mechanics\airlock\vfx_airlock_vent_xtrlrg_press.vfx");
  level._effect["vfx_airlock_vents_air"] = loadfx("vfx\iw7\core\mechanics\airlock\vfx_airlock_vent_lrg_press.vfx");
  level._effect["vfx_airlock_air_fill"] = loadfx("vfx\iw7\core\mechanics\airlock\vfx_airlock_roomcenter_press.vfx");
  level._effect["vfx_airlock_camcentr_depress"] = loadfx("vfx\iw7\core\mechanics\airlock\vfx_airlock_camcentr_depress.vfx");
  level._effect["vfx_airlock_vent_lrg_depress"] = loadfx("vfx\iw7\core\mechanics\airlock\vfx_airlock_vent_lrg_depress.vfx");
  func_1ACF();
  func_1AAF();
  thread func_1AD9();
}

func_1AD9() {
  scripts\engine\utility::waitframe();
  var_0 = scripts\engine\utility::getstructarray("generic_airlock_assets", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.targetname)) {
      continue;
    }
    var_2.var_ECCE = [];
    var_2.var_ECCE["front"] = [];
    var_2.var_ECCE["back"] = [];
    var_3 = getentitylessscriptablearrayinradius(var_2.targetname, "targetname");

    foreach(var_5 in var_3) {
      var_6 = "back";

      if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "forward") {
        var_6 = "front";
      }

      var_2.var_ECCE[var_6] = ::scripts\engine\utility::array_add(var_2.var_ECCE[var_6], var_5);

      if(var_6 == "front") {
        var_5 setscriptablepartstate("root", "0");
        continue;
      }

      var_5 setscriptablepartstate("root", "12");
    }

    var_2 func_1AAE();
    var_2 scripts\sp\utility::func_65E0("cycling");
    var_2 scripts\sp\utility::func_65E0("cycling_complete");
    thread scripts\engine\utility::play_loopsound_in_space("airlock_light_hum", var_2.origin);

    if(isDefined(var_2.targetname)) {
      level.var_1AE3[var_2.targetname] = var_2;
    }
  }

  scripts\engine\utility::flag_set("airlocks_setup");
}

func_1AAE() {
  var_0 = "airlock_cycling_pressurize";
  var_1 = "airlock_cycling_depressurize";
  var_2 = [];
  var_2["pressurize"] = [];
  var_2["depressurize"] = [];

  foreach(var_4 in level.createfxent) {
    if(isDefined(var_4.v["exploder"])) {
      if(var_4.v["exploder"] == var_0) {
        var_2["pressurize"] = ::scripts\engine\utility::array_add(var_2["pressurize"], var_4);
        continue;
      }

      if(var_4.v["exploder"] == var_1) {
        var_2["depressurize"] = ::scripts\engine\utility::array_add(var_2["depressurize"], var_4);
      }
    }
  }

  self.var_4CD3["pressurize"] = [];
  self.var_4CD3["depressurize"] = [];
  var_6 = ["pressurize", "depressurize"];

  foreach(var_8 in var_6) {
    foreach(var_4 in var_2[var_8]) {
      var_10 = var_4.v["fxid"];
      var_11 = var_4.v["origin"];
      var_12 = var_4.v["angles"];
      var_13 = var_4.v["delay"];
      var_14 = spawnStruct();
      var_14.var_762C = var_4.v["fxid"];
      var_14.origin = var_4.v["origin"];
      var_14.angles = var_4.v["angles"];
      var_14.delay = var_4.v["delay"];
      self.var_4CD3[var_8] = ::scripts\engine\utility::array_add(self.var_4CD3[var_8], var_14);
    }
  }
}

func_1ACF() {
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_air_fill", "airlock_cycling_pressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((-2.34019, -5.35077, 10.1119), (270, 0, 0));
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vent_xtrlrg_press", "airlock_cycling_pressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((71.5714, 90.1929, 22.4209), (327.999, 271.999, 0));
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling");
  var_0 scripts\common\createfx::set_origin_and_angles((71.7566, -88.0884, 130.896), (30.9999, 89.9989, 0));
  var_0.v["delay"] = 0.1;
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((23.7468, -91.7748, 133.02), (30.9999, 89.9989, 0));
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((-24.1032, -92.3938, 133.065), (30.9999, 89.9989, 0));
  var_0.v["delay"] = 0.9;
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((-67.9505, -94.0097, 132.632), (30.9999, 89.9989, 0));
  var_0.v["delay"] = 0.15;
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((-72.8097, 87.5459, 131.168), (34.9998, 273.999, 0));
  var_0.v["delay"] = 0.1;
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((-25.4342, 86.8056, 129.173), (34.9998, 273.999, 0));
  var_0.v["delay"] = 0.75;
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((25.3645, 88.4423, 130.479), (34.9998, 273.999, 0));
  var_0.v["delay"] = 0.05;
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((73.602, 88.8602, 130.599), (34.9998, 273.999, 0));
  var_0.v["delay"] = 0.1;
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vent_xtrlrg_press", "airlock_cycling_pressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((23.2354, 93.3036, 20.1975), (327.999, 271.999, 0));
  var_0.v["delay"] = 0.4;
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vent_xtrlrg_press", "airlock_cycling_pressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((-21.9721, 93.4224, 21.0276), (327.999, 271.999, 0));
  var_0.v["delay"] = 1;
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vent_xtrlrg_press", "airlock_cycling_pressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((-72.7803, 94.2712, 19.7878), (327.999, 271.999, 0));
}

func_1AAF() {
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((73.2631, -85.4638, 129.046), (34.9998, 93.9989, 0));
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((23.5765, -91.5693, 131.861), (34.9998, 93.9989, 0));
  var_0.v["delay"] = 0.2;
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((-24.8883, -89.9546, 130.099), (34.9998, 93.9989, 0));
  var_0.v["delay"] = 0.3;
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((-71.6661, -90.0395, 132.764), (34.9998, 93.9989, 0));
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((-21.3988, 84.8157, 127.166), (35.9998, 267.999, 0));
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((-72.5438, 88.4987, 130.708), (39.9702, 273.609, 1.67727));
  var_0.v["delay"] = 0.2;
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((73.4549, 86.6092, 129.863), (39.8823, 264.784, -3.34982));
  var_0.v["delay"] = 0.1;
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((25.3469, 86.5301, 129.677), (39.9457, 271.876, 2.07295));
  var_0.v["delay"] = 0.3;
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((-23.1415, 99.9688, 14.9828), (317.999, 267.999, 0));
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((24.8086, -96.6052, 16.5775), (323.999, 90.9985, 0));
  var_0.v["delay"] = 0.3;
  var_0 = scripts\common\createfx::createexploderex("vfx_airlock_camcentr_depress", "airlock_cycling_depressurize");
  var_0 scripts\common\createfx::set_origin_and_angles((7.92258, -4.8918, 18.4052), (270, 0, 0));
}

func_1AB7(var_0, var_1, var_2) {
  var_3 = "back";

  if(var_0) {
    var_3 = "front";
  }

  if(var_3 == "front") {
    if(isDefined(var_1)) {
      var_1 func_1AB5(1);
    }

    if(isDefined(var_2)) {
      var_2 func_1AB5(0);
    }
  } else {
    if(isDefined(var_1)) {
      var_1 func_1AB5(0);
    }

    if(isDefined(var_2)) {
      var_2 func_1AB5(1);
    }
  }
}

func_1AB5(var_0) {
  if(self.model != "sdf_door_airlock_01") {
    if(!isDefined(self.var_ACD5)) {
      self.var_ACD5 = [];
      var_1 = [15, -7];

      foreach(var_3 in var_1) {
        var_4 = scripts\engine\utility::spawn_tag_origin();
        var_4 linkto(self, "door_jnt", (38.5, var_3, 16), (0, 0, 0));
        self.var_ACD5[self.var_ACD5.size] = var_4;
      }
    }
  }

  if(var_0) {
    func_1AB6("unlocked");
  } else {
    func_1AB6("locked");
  }
}

func_1AB2(var_0) {
  if(isDefined(var_0.var_ACD5)) {
    foreach(var_2 in var_0.var_ACD5) {
      var_2 delete();
    }
  }

  var_0 delete();
}

func_1AA9(var_0, var_1, var_2, var_3, var_4) {
  scripts\engine\utility::flag_wait("airlocks_setup");
  var_5 = scripts\engine\utility::getstruct(var_0, "targetname");
  var_5 scripts\sp\utility::func_65DD("cycling_complete");
  var_5 scripts\sp\utility::func_65E1("cycling");
  var_6 = [];

  if(isDefined(var_2)) {
    var_6 = scripts\engine\utility::array_add(var_6, var_2);
  }

  if(isDefined(var_3)) {
    var_6 = scripts\engine\utility::array_add(var_6, var_3);
  }

  foreach(var_8 in var_6) {
    if(isDefined(var_8) && !isDefined(var_8.var_ACD5)) {
      var_8.var_ACD5 = [];
      var_9 = [15, -7];

      foreach(var_11 in var_9) {
        var_12 = var_8 scripts\engine\utility::spawn_tag_origin();
        var_12 linkto(var_8, "door_jnt", (38.5, var_11, 16), (0, 0, 0));
        var_8.var_ACD5[var_8.var_ACD5.size] = var_12;
      }
    }
  }

  var_15 = "airlock_pressurize_lr";

  if(!isDefined(var_4) || var_4) {
    setglobalsoundcontext("atmosphere", "", 2);
  } else {
    var_15 = "airlock_depressurize_lr";
    setglobalsoundcontext("atmosphere", "space", 2);
  }

  var_16 = lookupsoundlength(var_15);
  var_5.var_4CD5 = 1;
  var_5 thread func_1AD7(var_16, var_4);
  scripts\engine\utility::array_thread(var_6, ::func_1AB1, var_5, "cycling");

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  var_5 thread func_1AAD(var_4);
  level.player scripts\sp\utility::play_sound_on_entity(var_15);
  var_5.var_4CD5 = 0;
  var_17 = "back";

  if(var_1) {
    var_17 = "front";
  }

  var_18 = ["front", "back"];

  foreach(var_20 in var_18) {
    if(var_20 == var_17) {
      foreach(var_22 in var_5.var_ECCE[var_20]) {
        var_22 setscriptablepartstate("root", 12);
      }

      continue;
    }

    foreach(var_22 in var_5.var_ECCE[var_20]) {
      var_22 setscriptablepartstate("root", 0);
    }
  }

  if(var_17 == "front") {
    if(isDefined(var_2)) {
      var_2 func_1AB6("locked");
    }

    if(isDefined(var_3)) {
      var_3 func_1AB6("unlocked");
      var_3 playSound("airlock_light_on");
    }
  } else {
    if(isDefined(var_2)) {
      var_2 func_1AB6("unlocked");
      var_2 playSound("airlock_light_on");
    }

    if(isDefined(var_3)) {
      var_3 func_1AB6("locked");
    }
  }

  var_5 scripts\sp\utility::func_65E1("cycling_complete");
  var_5 scripts\sp\utility::func_65DD("cycling");
}

func_1AAB(var_0, var_1, var_2, var_3) {
  var_4 = level.var_1AE3[var_0];
  var_4 scripts\sp\utility::func_65DD("cycling_complete");
  var_4 scripts\sp\utility::func_65E1("cycling");
  var_5 = [];

  if(isDefined(var_2)) {
    var_5 = scripts\engine\utility::array_add(var_5, var_2);
  }

  if(isDefined(var_3)) {
    var_5 = scripts\engine\utility::array_add(var_5, var_3);
  }

  var_4.var_4CD5 = 1;
  scripts\engine\utility::array_thread(var_5, ::func_1AB1, var_4, "cycling");
  scripts\engine\utility::play_sound_in_space("airlock_ext", var_4.origin);
  wait 8.408;
  var_4.var_4CD5 = 0;
  func_1AD8(var_0, 0, var_2, var_3);
  var_4 scripts\sp\utility::func_65E1("cycling_complete");
  var_4 scripts\sp\utility::func_65DD("cycling");
}

func_1374E(var_0) {
  scripts\engine\utility::flag_wait("airlocks_setup");
  var_1 = level.var_1AE3[var_0];
  var_1 scripts\sp\utility::func_65E3("cycling_complete");
}

func_1AAD(var_0) {
  var_1 = "pressurize";

  if(!var_0) {
    var_1 = "depressurize";
  }

  foreach(var_3 in self.var_4CD3[var_1]) {
    var_4 = var_3.var_762C;
    var_5 = 0;

    if(isDefined(var_3.delay)) {
      var_5 = var_3.delay;
    }

    var_6 = var_3.origin;
    var_7 = rotatepointaroundvector(anglestoup(self.angles), var_6, self.angles[1]);
    var_6 = var_7 + self.origin;
    var_8 = _combineangles(var_3.angles, self.angles);
    var_9 = spawnStruct();
    var_9.origin = var_6;
    var_9.angles = var_8;
    scripts\engine\utility::noself_delaycall(var_5, ::playfx, scripts\engine\utility::getfx(var_4), var_6, anglesToForward(var_8), anglestoup(var_8));
  }
}

func_1AAA(var_0) {
  scripts\engine\utility::flag_wait("airlocks_setup");
  var_1 = level.var_1AE3[var_0];
  var_2 = ["front", "back"];

  foreach(var_4 in var_2) {
    foreach(var_6 in var_1.var_ECCE[var_4]) {
      var_6 setscriptablepartstate("root", 13);
    }
  }
}

func_1AD6(var_0) {
  var_1 = ["front", "back"];
  var_2 = 0.75;

  while(self.var_4CD5) {
    foreach(var_4 in var_1) {
      foreach(var_6 in self.var_ECCE[var_4][var_0]) {
        var_6 show();
      }
    }

    wait(var_2);

    foreach(var_4 in var_1) {
      foreach(var_6 in self.var_ECCE[var_4][var_0]) {
        var_6 hide();
      }
    }

    wait(var_2);
  }

  self notify("blinking_complete");
}

func_1AD7(var_0, var_1) {
  var_2 = var_0 / 1000 / 10;
  var_3 = 1;
  var_4 = 12;

  if(isDefined(var_1) && !var_1) {
    var_3 = 11;
    var_4 = 1;
  }

  var_5 = var_3;
  var_6 = ["front", "back"];

  while(var_5 != var_4) {
    foreach(var_8 in var_6) {
      foreach(var_10 in self.var_ECCE[var_8]) {
        var_10 setscriptablepartstate("root", var_5);
      }
    }

    if(isDefined(var_1) && !var_1) {
      var_5 = var_5 - 1;
    } else {
      var_5++;
    }

    wait(var_2);
  }
}

func_1AB1(var_0, var_1) {
  self endon("death");
  func_1AB6("off");
  var_2 = 0.75;

  while(var_0.var_4CD5) {
    func_1AB6(var_1);
    wait(var_2);
    func_1AB6("off");
    wait(var_2);
  }
}

func_1AD8(var_0, var_1, var_2, var_3) {
  scripts\engine\utility::flag_wait("airlocks_setup");
  var_4 = level.var_1AE3[var_0];
  var_5 = "back";

  if(var_1) {
    var_5 = "front";
  }

  var_6 = ["front", "back"];

  foreach(var_8 in var_6) {
    if(var_8 == var_5) {
      foreach(var_10 in var_4.var_ECCE[var_8]) {
        var_10 setscriptablepartstate("root", 12);
      }

      continue;
    }

    foreach(var_10 in var_4.var_ECCE[var_8]) {
      var_10 setscriptablepartstate("root", 0);
    }
  }

  if(isDefined(var_2)) {
    var_2 func_1AB6("unlocked");
  }

  if(isDefined(var_3)) {
    var_3 func_1AB6("locked");
  }
}

func_1AB6(var_0) {
  if(self.model != "sdf_door_airlock_01") {
    if(isDefined(self.currentstate)) {
      foreach(var_2 in self.var_ACD5) {
        var_3 = func_1AB4(self.currentstate);

        if(isDefined(var_3)) {
          _killfxontag(scripts\engine\utility::getfx(var_3), var_2, "tag_origin");
        }
      }
    }

    foreach(var_2 in self.var_ACD5) {
      var_3 = func_1AB4(var_0);

      if(isDefined(var_3)) {
        playFXOnTag(scripts\engine\utility::getfx(var_3), var_2, "tag_origin");
      }
    }
  } else if(var_0 != "unlocked") {
    if(scripts\sp\utility::hastag(self.model, "tag_screen_locked")) {
      self giveperk("tag_screen_locked", self.model);
    }

    if(scripts\sp\utility::hastag(self.model, "tag_screen_open")) {
      self hidepart("tag_screen_open", self.model);
    }
  } else {
    if(scripts\sp\utility::hastag(self.model, "tag_screen_locked")) {
      self hidepart("tag_screen_locked", self.model);
    }

    if(scripts\sp\utility::hastag(self.model, "tag_screen_open")) {
      self giveperk("tag_screen_open", self.model);
    }
  }

  self.currentstate = var_0;
}

func_1AB4(var_0) {
  if(var_0 == "unlocked") {
    return "vfx_airlock_light_green";
  } else if(var_0 == "locked") {
    return "vfx_airlock_light_red";
  } else if(var_0 == "cycling") {
    return "vfx_airlock_light_orange";
  } else if(var_0 == "error") {
    return undefined;
  } else if(var_0 == "off") {
    return undefined;
  }
}

func_A852() {
  var_0 = undefined;
  var_1 = [];
  var_2 = scripts\sp\utility::func_7A8F();

  foreach(var_4 in var_2) {
    if(var_4.classname == "script_model") {
      if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "player") {
        self.var_D45A = 1;
        var_1["player"] = var_4;
      } else {
        if(!isDefined(var_1["ai"])) {
          var_1["ai"] = [];
        }

        var_1["ai"] = ::scripts\engine\utility::array_add(var_1["ai"], var_4);
      }

      var_4 glinton(#animtree);
      continue;
    }

    var_0 = var_4;
  }

  self.var_454F = var_1;

  if(isDefined(var_0)) {
    var_0 waittill("trigger");
  }

  if(isDefined(var_1["player"])) {
    thread func_A855();
  }

  scripts\sp\utility::func_65E3("door_sequence_complete");
}

func_A855() {
  var_0 = self.var_454F;
  var_0["player"].var_1FBB = "console_plr";
  var_0["player"] func_0E46::func_48C4("override_box_jt", undefined, undefined, undefined, 5000, undefined, 0);
  var_0["player"] waittill("trigger", var_1);
  var_2 = var_0["player"] func_D0A6("large_door_open_arrive");
  var_3 = [var_0["player"], var_2];
  var_0["player"] scripts\sp\anim::func_1F2C(var_3, "large_door_open_arrive");
  scripts\sp\utility::func_65E1("player_at_door");
  var_0["player"] thread scripts\sp\anim::func_1EE7(var_3, "large_door_open_idle");
  scripts\sp\utility::func_65E3("begin_opening");
  var_0["player"] notify("stop_loop");
  var_0["player"] scripts\sp\anim::func_1F2C(var_3, "large_door_open");
  var_1 func_5990();
  var_1 unlink();
  var_2 delete();
}

func_A854(var_0, var_1) {
  var_2 = [var_0];

  if(isDefined(var_1)) {
    if(var_1.size > 1) {} else
      var_1 = var_1[0];

    var_2 = scripts\engine\utility::array_add(var_2, var_1);
  }

  foreach(var_6, var_4 in var_2) {
    var_5 = self.var_454F["ai"][var_6];
    var_5.var_1FBB = "console_ai";
    var_4.var_A93B = var_4.var_1FBB;
    var_4.var_1FBB = "main";
    var_4 scripts\sp\utility::func_178D(scripts\sp\utility::func_137AA, "actor_at_door");
    thread func_A853(var_4, var_5);
  }

  if(isDefined(self.var_454F["player"])) {
    scripts\sp\utility::func_178D(scripts\sp\utility::func_65E3, "player_at_door");
  }

  scripts\sp\utility::func_57D5();
  scripts\sp\utility::func_65E1("actor_at_door");

  if(isDefined(self.var_D45A)) {
    scripts\sp\utility::func_65E3("player_at_door");
  }

  scripts\sp\utility::func_65E1("begin_opening");
  wait(getanimlength(var_0 scripts\sp\utility::func_7DC1("large_door_open")));

  foreach(var_4 in var_2) {
    var_4.var_1FBB = var_4.var_A93B;
  }

  scripts\sp\utility::func_65E1("door_sequence_complete");
}

func_A853(var_0, var_1) {
  var_2 = [var_0, var_1];
  var_1 scripts\sp\anim::func_1F17(var_0, "large_door_open_arrive");
  var_1 scripts\sp\anim::func_1F2C(var_2, "large_door_open_arrive");
  var_1 thread scripts\sp\anim::func_1EE7(var_2, "large_door_open_idle");
  var_0 notify("actor_at_door");
  scripts\sp\utility::func_65E3("begin_opening");
  var_1 notify("stop_loop");
  var_0 func_0A1E::func_2386();
  var_1 thread scripts\sp\anim::func_1F2C(var_2, "large_door_open");
}

buddy_down_skip_post_clear() {
  scripts\sp\utility::func_65E0("secondary_actors_going_through");
  scripts\sp\utility::func_65E0("player_prying_open_door");
  thread buddy_down_trigger_damage_onflashbang();
}

buddy_down_trigger_damage_onflashbang() {
  var_0 = "tag_ui_back";

  if(isDefined(self.var_9027)) {
    var_0 = self.var_9027;
  }

  self.var_9027 = var_0;
  var_1 = undefined;

  if(isDefined(self.var_901E)) {
    var_1 = self.var_901E;
  }

  self.var_10247 = isDefined(self.var_10247);
  var_2 = undefined;

  if(isDefined(self.var_9333)) {
    var_2 = self.var_9333;
  }

  func_0E46::func_48C4(var_0, var_1, undefined, undefined, undefined, undefined, var_2);
  self setusefov(180);
  func_0E46::func_9016();
  scripts\sp\utility::func_65E1("player_used_door");
  var_3 = func_D0A6(func_5997("intro"));

  if(isDefined(self.var_9AEF)) {
    level.player thread scripts\sp\utility::play_sound_on_entity(self.var_9AEF);
  }

  level notify("buddydoor_player_intro");
  func_59DE([self, var_3], func_5997("intro"));
  level notify("buddydoor_player_idle");
  thread func_59DE([self, var_3], func_5997("idle"), 1);
  scripts\sp\utility::func_65E1("player_at_door");
  scripts\sp\utility::func_65E3("actor_at_door");
  scripts\sp\utility::func_65E1("begin_opening");
  var_4 = [self, var_3];

  foreach(var_6 in self.var_1684) {
    if(!var_6 func_1FA3(func_5997("pull"))) {
      continue;
    }
    var_4 = scripts\engine\utility::array_add(var_4, var_6);
  }

  level notify("buddydoor_player_pry_open");
  buddy_down_two_enemy_dead_thread(var_4);
  scripts\sp\utility::func_65E1("door_opened");
  level notify("buddydoor_player_outro");
  self notify("buddydoor_outro");

  if(isDefined(self.var_427C)) {
    level.player thread scripts\sp\utility::play_sound_on_entity(self.var_427C);
  }

  var_4 = [self, var_3];
  func_59DE(var_4, func_5997("outro"));
  level.player func_5990();
  level.player unlink();
  var_3 delete();
  scripts\sp\utility::func_65E1("door_sequence_complete");
  level notify("buddydoor_player_done");
}

buddy_down_two_enemy_dead_thread(var_0) {
  level.player notifyonplayercommand("bash_pressed", "+usereload");
  level.player notifyonplayercommand("bash_pressed", "+activate");
  thread buddy_down_remove_playerclip();

  if(!isDefined(self.var_C633)) {
    self.var_C633 = 1;
  }

  var_1 = getanimlength(var_0[0] scripts\sp\utility::func_7DC1(func_5997("pull")));
  var_2 = var_1 / self.var_C633;

  if(self.var_10247) {
    thread func_2643();
  }

  for(;;) {
    level.player waittill("bash_pressed");
    level notify("buddydoor_pry_open_start");
    scripts\sp\utility::func_65E1("player_prying_open_door");
    level.player.var_2704 = 1;
    thread buddyspawn();
    var_3 = buddy_down_price_anim(0.5, 1);

    if(isDefined(var_3)) {
      continue;
    }
    scripts\engine\utility::array_thread(var_0, ::func_59F3, self);

    foreach(var_5 in var_0) {
      var_5 givescorefortrophyblocks();
    }

    scripts\sp\anim::func_1EC1(var_0, func_5997("pull"));

    foreach(var_5 in var_0) {
      if(isai(var_5)) {
        var_5 func_0A1E::func_2307(::buddyplayerid, func_0A1E::func_2385);
        continue;
      }

      var_8 = var_5 scripts\sp\utility::func_7DC1(func_5997("pull"));
      var_5 give_attacker_kill_rewards(var_8, 1, 0.2, self.var_C633);
    }

    thread buddy_down_player_engaging_early(var_2);
    var_3 = buddy_down_price_anim(var_2);

    if(!isDefined(var_3)) {
      level notify("buddydoor_pry_open_success");
      break;
    }

    level notify("buddydoor_pry_open_failed");

    if(isDefined(self.var_C62B)) {
      level.player thread scripts\sp\utility::play_sound_on_entity(self.var_C62B);
    }

    var_10 = 5;
    var_11 = var_0[0] islegacyagent(var_0[0] scripts\sp\utility::func_7DC1(func_5997("pull")));
    var_12 = var_1 * var_11;
    var_12 = var_12 / var_10;

    foreach(var_5 in var_0) {
      var_5 _meth_82B1(var_5 scripts\sp\utility::func_7DC1(func_5997("pull")), var_10 * -1);
    }

    wait(var_12);
    level.player playrumbleonentity("damage_heavy");
    self notify("stop_pry_anim");
    scripts\sp\utility::func_65DD("player_prying_open_door");
    level.player.var_2704 = 0;
    thread func_59DE(var_0, func_5997("idle"), 1);
  }

  if(isDefined(self.var_C62F)) {
    scripts\engine\utility::stop_loop_sound_on_entity(self.var_C62F);
  }

  if(isDefined(self.var_C634)) {
    thread scripts\sp\utility::play_sound_on_entity(self.var_C634);
  }
}

func_2643() {
  while(!scripts\sp\utility::func_65DB("door_opened")) {
    level.player notify("bash_pressed");
    wait 0.05;
  }
}

buddyplayerid() {
  self endon("stop_pry_anim");
  self endon("buddydoor_pull_complete");
  var_0 = scripts\sp\utility::func_7DC1(self.var_130FF func_5997("pull"));
  var_1 = func_0A1E::func_2356("Knobs", "body");
  self clearanim(var_1, 0);
  self animmode("noclip");
  self give_attacker_kill_rewards(var_0, 1, 0.2, self.var_130FF.var_C633);
  level waittill("ever");
}

buddyspawn() {
  self endon("buddydoor_pull_complete");

  if(isDefined(self.var_C625)) {
    self playSound(self.var_C625);
  }

  wait 0.3;

  if(isDefined(self.var_C62F)) {
    thread scripts\engine\utility::play_loop_sound_on_entity(self.var_C62F);
  }

  self waittill("buddydoor_pull_failed");

  if(isDefined(self.var_C62F)) {
    thread scripts\engine\utility::stop_loop_sound_on_entity(self.var_C62F);
  }

  if(isDefined(self.var_C625)) {
    self stopsounds();
  }
}

buddy_down_price_anim(var_0, var_1) {
  self endon("buddydoor_pull_complete");

  if(!isDefined(var_1)) {
    thread buddy_down_skip_move();
  }

  var_0 = var_0 * 1000;
  var_2 = gettime();

  for(;;) {
    if(gettime() - var_2 > var_0) {
      return;
    }
    var_3 = level.player scripts\engine\utility::waittill_notify_or_timeout_return("bash_pressed", 0.4);

    if(isDefined(var_3)) {
      break;
    }
  }

  self notify("buddydoor_pull_failed");
  return 1;
}

buddy_down_skip_move() {
  self endon("buddydoor_pull_complete");
  self endon("buddydoor_pull_failed");

  for(;;) {
    level.player playrumbleonentity("damage_light");
    earthquake(0.15, 0.1, level.player.origin, 5000);
    wait 0.05;
  }
}

buddy_down_remove_playerclip() {
  if(self.var_10247) {
    return;
  }
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_1 = "left_door_01";

  if(isDefined(self.var_28B6)) {
    var_1 = self.var_28B6;
  }

  var_0.origin = self gettagorigin(var_1);
  var_0 linkto(self, var_1);
  var_0 func_0E46::func_48C4(undefined, undefined, "", undefined, 1000, 1000, 1, 1);
  self waittill("buddydoor_pull_complete");
  var_0 func_0E46::func_DFE3();
}

buddy_down_player_engaging_early(var_0) {
  self endon("buddydoor_pull_failed");
  wait(var_0);
  self notify("buddydoor_pull_complete");
}

buddy_down_gunner_damage_thread(var_0) {
  foreach(var_2 in var_0) {
    var_2.var_130FF = self;
    var_3 = var_2.var_1FBB + "_door_sequence_complete";
    var_4 = var_2.var_1FBB + "_at_door";
    scripts\sp\utility::func_65E0(var_4);
    scripts\sp\utility::func_65E0(var_3);
  }

  scripts\engine\utility::array_thread(var_0, ::func_598C);
  var_6 = [];

  foreach(var_2 in var_0) {
    if(!var_2 func_1FA3(func_5997("intro"))) {
      continue;
    }
    var_6 = scripts\engine\utility::array_add(var_6, var_2);
  }

  scripts\engine\utility::array_thread(var_6, ::buddy_down_gunner_death, self, var_6);
  self waittill("buddydoor_outro");
  scripts\engine\utility::array_thread(var_0, ::func_59F3, self);

  foreach(var_2 in var_0) {
    thread buddy_down_gunner_flashed_thread(var_2);
  }
}

buddy_down_gunner_death(var_0, var_1) {
  level notify("buddydoor_actors_intro");
  var_0 thread func_1162A(self);

  if(var_0 scripts\sp\utility::func_65DB("skip_reach_on_use")) {
    func_E9FF(var_0);
  } else if(!var_0 scripts\sp\utility::func_65DB("no_anim_reach")) {
    var_0 scripts\sp\anim::func_1F17(self, var_0 func_5997("intro"));
  }

  if(var_0 scripts\sp\utility::func_65DB("skip_reach_on_use")) {
    func_E9FE(var_0);
    var_0 thread func_59DE(self, var_0 func_5997("idle"), 1);
  } else {
    var_0 func_59DE(self, var_0 func_5997("intro"));
    var_0 thread func_59DE(self, var_0 func_5997("idle"), 1);
  }

  self.var_2412 = 1;
  var_0 scripts\sp\utility::func_65E1(self.var_1FBB + "_at_door");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.var_2412)) {
      return;
    }
  }

  var_0 scripts\sp\utility::func_65E1("actor_at_door");
}

func_E9FF(var_0) {
  level.player endon("player_attached_to_door");
  var_0 scripts\sp\anim::func_1F17(self, var_0 func_5997("intro"));
}

func_E9FE(var_0) {
  level.player endon("player_attached_to_door");
  var_0 func_59DE(self, var_0 func_5997("intro"));
}

buddy_down_gunner_flashed_thread(var_0) {
  var_0 endon("death");
  self endon("death");
  level notify("buddydoor_actors_outro");
  thread func_59DE(var_0, func_5997("outro"));
  var_0 waittill(func_5997("outro"));
  var_0.var_130FF = undefined;
  var_0.var_2412 = undefined;
  var_0 func_598F();
  var_1 = var_0.var_1FBB + "_door_sequence_complete";
  scripts\sp\utility::func_65E1(var_1);
  level notify("buddydoor_actors_outro_done");
}

func_21E0() {
  var_0 = scripts\sp\utility::func_7A97();

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      if(isDefined(var_2.targetname) && var_2.targetname == "loot_hint_struct") {
        self.var_9026 = var_2;
      }
    }
  }

  self.collision = scripts\sp\utility::func_7A8E();

  if(!isDefined(level.var_21E2)) {
    level.var_21E2 = 0;
  }

  thread func_21E9(level.var_21E2);
  level.var_21E2++;
}

func_21E9(var_0) {
  self endon("stop_door");

  if(isDefined(level.var_21E4)) {
    self[[level.var_21E4]]();
  }

  self.var_9026 func_0E46::func_48C4();
  self.var_9026 func_0E46::func_9016();
  level notify("armory_door_start_open");
  scripts\sp\utility::func_65E1("player_at_door");
  scripts\sp\utility::func_65E1("begin_opening");
  self notify("stop_loop");
  thread func_21E5();
  wait 0.7;
  thread scripts\sp\utility::play_sound_on_entity("armory_door_open");
  func_0B09::func_489F(var_0);

  if(!func_0A2F::func_D9ED(var_0)) {
    func_0A2F::func_DA49(var_0, 1);
    scripts\sp\utility::func_9145("fluff_messages_loot_room");
  }
}

func_21E5() {
  var_0 = self;
  var_0.var_1FBB = "loot_door";

  if(isDefined(self.var_4386)) {
    self.collision linkto(self, self.var_4386);
  } else {
    self.collision linkto(self, "j_handle");
  }

  if(scripts\engine\utility::is_true(self.var_72D1)) {
    self notify("stop_door");
    func_0E46::func_DFE3();
    self notify("stop_loop");
    var_0 scripts\sp\anim::func_1EE0(var_0, "open_loot_door");
    self.collision connectpaths();
    self.position = "open";

    if(scripts\sp\utility::hastag(self.model, "tag_locked")) {
      self hidepart("tag_locked", self.model);
    }

    if(scripts\sp\utility::hastag(self.model, "tag_unlocked")) {
      self giveperk("tag_unlocked", self.model);
    }
  } else {
    var_1 = var_0 func_FA17("open_loot_door");
    var_0 thread scripts\sp\anim::func_1F35(var_1, "open_loot_door", "tag_origin");
    var_0 scripts\sp\anim::func_1F35(var_0, "open_loot_door", "tag_origin");
    self.collision connectpaths();
    var_1 delete();
    level.player func_5990();
    level.player unlink();
    self.position = "open";
  }

  level notify("armory_door_open");

  if(isDefined(self.var_21E6)) {
    self thread[[self.var_21E6]]();
  }
}

func_9530(var_0) {
  var_1 = scripts\engine\utility::getstructarray("door_peek_struct", "script_noteworthy");

  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      if(var_3.targetname == var_0) {
        var_3 thread func_13684(var_3.targetname);
      }
    }
  }
}

func_13684(var_0) {
  var_1 = self;
  level waittill(var_0 + "door_peek_start");
  var_1 thread func_0B09::func_489F(0);
}

func_FA17(var_0) {
  if(isDefined(level.var_E982) && level.var_E982 == 1) {
    var_1 = scripts\sp\utility::func_10639("player_rig_disguise");
  } else {
    var_1 = scripts\sp\utility::func_10639("player_arms");
    var_2 = level.player _meth_84C6("currentViewModel");

    if(isDefined(var_2)) {
      var_1 setModel(var_2);
    }
  }

  var_1 hide();
  level.player getradiuspathsighttestnodes();
  level.player func_598D();
  var_3 = [var_1, self];
  thread scripts\sp\anim::func_1EC3(var_1, var_0);
  var_4 = 0.4;
  level.player getweaponweight(var_1, "tag_player", var_4, 0.15, 0.15);
  wait(var_4);
  var_1 show();
  return var_1;
}

func_3232() {
  var_0 = scripts\sp\utility::func_7A8F();
  scripts\engine\utility::array_call(var_0, ::linkto, self, "j_hinge2");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "player_clip") {
      continue;
    }
    self.var_C969 = var_2;
  }

  if(isDefined(self.var_EF20) && self.var_EF20 == "notplayer") {
    return;
  }
  func_0E46::func_48C4(undefined, (20, -50, 55));
  self waittill("trigger", var_4);
  scripts\sp\utility::func_65E1("player_at_door");
  self.var_C969 connectpaths();
  var_5 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles + (0, 180, 0));
  var_6 = var_5 func_D0A6("bulkhead_open");
  scripts\sp\utility::func_65E1("begin_opening");
  var_7 = [self, var_6];

  if(soundexists("airlock_exit_door_open")) {
    level.player thread scripts\sp\utility::play_sound_on_entity("airlock_exit_door_open");
  }

  var_5 scripts\sp\anim::func_1F2C(var_7, "bulkhead_open");
  var_5 thread scripts\sp\anim::func_1F35(self, "bulkhead_open");
  var_5 scripts\sp\anim::func_1F2A([self], "bulkhead_open", 0.99);
  var_5 scripts\sp\anim::func_1F27([self], "bulkhead_open", 0);
  level.player func_5990();
  level.player unlink();
  var_6 delete();
  scripts\sp\utility::func_65E1("door_sequence_complete");
}

func_5982(var_0, var_1, var_2) {
  var_3 = self.var_5A18 + "_";
  var_4 = [[var_0]]();
  var_5 = [[var_1]]();
  var_6 = [[var_2]]();
  var_7 = [var_4, var_5, var_6];

  foreach(var_19, var_9 in var_7) {
    foreach(var_18, var_11 in var_9) {
      var_12 = 0;

      foreach(var_17, var_14 in var_11) {
        var_15 = getarraykeys(var_11)[var_12];
        var_16 = var_3 + var_15;

        if(var_15 == "idle") {
          level.var_EC85[var_18][var_16][0] = var_11[var_15];
        } else {
          level.var_EC85[var_18][var_16] = var_11[var_15];
        }

        var_12++;
      }
    }
  }
}

func_59EB(var_0, var_1, var_2, var_3, var_4) {
  self.var_9AEF = var_0;
  self.var_C625 = var_1;
  self.var_C62F = var_2;
  self.var_C62B = var_3;
  self.var_C634 = var_4;
}

func_598C() {
  if(isDefined(self.var_598E)) {
    scripts\sp\utility::func_61C7();
    self.var_598E = undefined;
  }
}

func_598F() {
  if(isDefined(self.var_EDAD)) {
    self.var_598E = 1;
  }
}

func_D0A6(var_0) {
  var_1 = scripts\sp\utility::func_10639("door_player_rig");

  if(var_1.model == "viewmodel_base_viewhands_iw7") {
    var_2 = level.player _meth_84C6("currentViewModel");

    if(isDefined(var_2)) {
      var_1 setModel(var_2);
    }
  }

  var_1 hide();
  level.player.var_59E1 = var_1;
  var_3 = [var_1, self];

  foreach(var_5 in var_3) {
    if(!isDefined(var_5.var_1FBB)) {
      continue;
    }
    if(!var_5 func_1FA3(var_0)) {
      continue;
    }
    thread scripts\sp\anim::func_1EC3(var_5, var_0);
  }

  var_7 = level.player scripts\engine\utility::spawn_tag_origin();
  var_7.origin = level.player.origin;
  var_7.angles = level.player getplayerangles();
  level.player getweaponvariantattachments(var_7, "tag_origin", 1, 0, 0, 0, 0, 0);
  var_8 = 0.45;

  if(isDefined(self._meth_8483)) {
    var_8 = self._meth_8483;
  }

  if(length(level.player getvelocity()) > 200) {
    var_8 = 0.25;
  }

  var_9 = var_8 / 4;
  var_10 = var_9;
  level.player func_598D();
  wait 0.3;
  level.player getweaponweight(var_1, "tag_player", var_8, var_9, var_10);
  wait(var_8);
  level.player notify("player_attached_to_door");
  level.player getweightedchanceroll(var_1, "tag_player", 1, 5, 5, 5, 5, 1);
  level.player givefriendlyperks(30, 30, 30, 30);
  var_1 show();
  var_7 delete();
  return var_1;
}

func_1162A(var_0) {
  var_0 endon("anim_reach_complete");
  scripts\sp\utility::func_65E3("player_at_door");

  if(isDefined(self.var_D83A)) {
    var_1 = self.var_D83A;
  } else {
    var_1 = 200;
  }

  if(distance(var_0.origin, self.origin) >= 200) {
    var_2 = undefined;

    if(isDefined(self.var_D83B)) {
      var_2 = self.var_D83B;
    } else {
      var_3 = anglesToForward(self.angles);
      var_3 = var_3 * -1;
      var_2 = self.origin + var_3 * var_1;
    }

    var_0 _meth_80F1(var_2, self.angles, 10000);
  }
}

func_598D() {
  level.player _meth_84FE();
  level.player getradiuspathsighttestnodes();
  level.player getroundswon(1);
  level.player setstance("stand");
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_crouch(0);
  level.player getnumownedagentsonteambytype(0);
  level.player getrankinfoxpamt();
}

func_5990() {
  level.player enableweapons();
  level.player getnumownedagentsonteambytype(1);
  level.player getroundswon(0);
  level.player scripts\engine\utility::allow_prone(1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player _meth_80A1();
  level.player _meth_84FD();
}

func_5997(var_0) {
  return self.var_5A18 + "_" + var_0;
}

func_59DE(var_0, var_1, var_2) {
  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  var_3 = [];

  foreach(var_5 in var_0) {
    if(!var_5 func_1FA3(var_1)) {
      continue;
    }
    if(isDefined(var_2)) {
      thread scripts\sp\anim::func_1EEA(var_5, var_1, "stop_loop_" + var_5.var_1FBB);
    } else {
      thread func_5981(var_5, var_1);
    }

    var_3[var_3.size] = var_5;
  }

  if(!isDefined(var_2) && var_3.size > 0) {
    foreach(var_5 in var_3) {
      var_5 scripts\sp\utility::func_178D(scripts\sp\utility::func_137AA, var_1);
    }

    scripts\sp\utility::func_57D5();
  }
}

func_5981(var_0, var_1) {
  scripts\sp\anim::func_1F35(var_0, var_1);
  var_0 notify(var_1);
}

func_59F3(var_0) {
  var_0 notify("stop_loop_" + self.var_1FBB);
}

func_1FA3(var_0) {
  var_1 = level.var_EC85[self.var_1FBB][var_0];

  if(isDefined(var_1)) {
    return 1;
  }

  return 0;
}

func_5983() {
  level.var_EC85["door"]["airlock_open_player"] = % airlock_open_door;
  level.var_EC85["door"]["bulkhead_open"] = % moon_2_31_secure_hangar_door;
  level.var_EC85["door"]["large_ally_door"] = % europa_armory_door_metal_bulkhead_double_01_open;
  level.var_EC85["console_plr"]["large_door_open_arrive"] = % europa_armory_override_l_plr_intro;
  level.var_EC85["console_plr"]["large_door_open_idle"][0] = % europa_armory_override_l_plr_idle;
  level.var_EC85["console_plr"]["large_door_open"] = % europa_armory_override_l_plr_pull_handle;
  level.var_EC85["console_ai"]["large_door_open_arrive"] = % europa_armory_override_r_str_intro;
  level.var_EC85["console_ai"]["large_door_open_idle"][0] = % europa_armory_override_r_str_idle;
  level.var_EC85["console_ai"]["large_door_open"] = % europa_armory_override_r_str_pull_handle;
  func_599C();
  func_59DF();
}

#using_animtree("generic_human");

func_599C() {
  level.var_EC85["main"]["large_door_open_arrive"] = % europa_armory_str_override_r_intro;
  level.var_EC85["main"]["large_door_open_idle"][0] = % europa_armory_str_override_r_idle;
  level.var_EC85["main"]["large_door_open"] = % europa_armory_str_override_r_pull_handle;
}

#using_animtree("player");

func_59DF() {
  level.var_EC87["door_player_rig"] = #animtree;
  level.var_EC8C["door_player_rig"] = "viewmodel_base_viewhands_iw7";
  level.var_EC85["door_player_rig"]["airlock_open_player"] = % airlock_open_player;
  level.var_EC85["door_player_rig"]["large_door_open_arrive"] = % europa_armory_plr_override_l_intro;
  level.var_EC85["door_player_rig"]["large_door_open_idle"][0] = % europa_armory_plr_override_l_idle;
  level.var_EC85["door_player_rig"]["large_door_open"] = % europa_armory_plr_override_l_pull_handle;
  level.var_EC85["door_player_rig"]["bulkhead_open"] = % moon_2_31_secure_hangar_plr;
}

func_5A4B() {
  if(!isDefined(level.doors)) {
    level.doors = spawnStruct();
  }

  return level.doors;
}