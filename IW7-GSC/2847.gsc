/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2847.gsc
***************************************/

#using_animtree("script_model");

func_95B6() {
  level.doors = [];
  func_5983();
  func_1AC1();
  var_00 = getEntArray("generic_door", "script_noteworthy");

  foreach(var_02 in var_00) {
    if(isDefined(var_2.targetname) && isDefined(level.doors[var_2.targetname])) {
      if(!isDefined(level.func_FCD6) || level.func_FCD6 != 1) {
        continue;
      }
    }

    if(var_2.classname == "script_origin") {
      var_03 = var_02 scripts\engine\utility::spawn_tag_origin();
      var_3.targetname = var_2.targetname;
      var_3.script_parameters = var_2.script_parameters;
      var_3.func_EDA0 = var_2.func_EDA0;
      var_02 = var_03;
    }

    if(isDefined(var_2.targetname)) {
      level.doors[var_2.targetname] = var_02;
      var_04 = getEntArray(var_2.targetname, "targetname");

      foreach(var_06 in var_04) {
        if(var_6.classname == "script_brushmodel") {
          var_2.collision = var_06;
        }
      }
    }

    var_2.func_5A18 = var_2.targetname;
    var_2.func_5A57 = var_2.script_parameters;
    var_2.func_1FBB = "door";
    var_02 glinton(#animtree);
    var_02 scripts\sp\utility::func_65E0("player_used_door");
    var_02 scripts\sp\utility::func_65E0("player_at_door");
    var_02 scripts\sp\utility::func_65E0("actor_at_door");
    var_02 scripts\sp\utility::func_65E0("begin_opening");
    var_02 scripts\sp\utility::func_65E0("door_opened");
    var_02 scripts\sp\utility::func_65E0("door_sequence_complete");
    var_02 scripts\sp\utility::func_65E0("no_anim_reach");
    var_02 scripts\sp\utility::func_65E0("skip_reach_on_use");

    if(isDefined(var_2.func_EDA0)) {
      var_02 scripts\sp\utility::func_65E0(var_2.func_EDA0);
    }

    var_02 scripts\sp\utility::func_65E0("locked");
    var_02 thread door_think();
  }

  thread func_9530("door_peek_armory");
}

door_think() {
  if(self.func_5A57 == "airlock" && self.model == "sdf_door_airlock_01") {
    scripts\sp\anim::func_1EC3(self, "airlock_open_player");
  }

  if(isDefined(self.func_EDA0)) {
    scripts\sp\utility::func_65E3(self.func_EDA0);
  }

  switch (self.func_5A57) {
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

func_168A(var_00) {
  self.func_1684 = var_00;

  switch (self.func_5A57) {
    case "no_power":
      buddy_down_gunner_damage_thread(var_00);
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
  var_00 = scripts\sp\utility::func_7A8F();
  scripts\engine\utility::array_call(var_00, ::linkto, self, "door_jnt");

  foreach(var_02 in var_00) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "player_clip") {
      continue;
    }
    self.func_C969 = var_02;
  }

  if(isDefined(self.func_EF20) && self.func_EF20 == "notplayer") {
    return;
  }
  self.func_DF3A = 1;
  func_0E46::func_48C4("tag_ui_front");
  self waittill("trigger", var_04);
  scripts\sp\utility::func_65E1("player_at_door");
  var_05 = func_D0A6("airlock_open_player");
  scripts\sp\utility::func_65E1("begin_opening");
  var_06 = [self, var_05];

  if(soundexists("airlock_exit_door_open")) {
    level.player thread scripts\sp\utility::play_sound_on_entity("airlock_exit_door_open");
  }

  scripts\sp\anim::func_1F2C(var_06, "airlock_open_player");

  if(scripts\engine\utility::is_true(self.func_DF3A)) {
    level.player func_5990();
    level.player unlink();
    var_05 delete();
  }

  self.func_C969 connectpaths();
  self.func_C969 disconnectpaths();
  scripts\sp\utility::func_65E1("door_sequence_complete");
}

func_1AC1() {
  level.func_1AE3 = [];
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
  var_00 = scripts\engine\utility::getstructarray("generic_airlock_assets", "script_noteworthy");

  foreach(var_02 in var_00) {
    if(!isDefined(var_2.targetname)) {
      continue;
    }
    var_2.func_ECCE = [];
    var_2.func_ECCE["front"] = [];
    var_2.func_ECCE["back"] = [];
    var_03 = getentitylessscriptablearrayinradius(var_2.targetname, "targetname");

    foreach(var_05 in var_03) {
      var_06 = "back";

      if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "forward") {
        var_06 = "front";
      }

      var_2.func_ECCE[var_06] = ::scripts\engine\utility::array_add(var_2.func_ECCE[var_06], var_05);

      if(var_06 == "front") {
        var_05 setscriptablepartstate("root", "0");
        continue;
      }

      var_05 setscriptablepartstate("root", "12");
    }

    var_02 func_1AAE();
    var_02 scripts\sp\utility::func_65E0("cycling");
    var_02 scripts\sp\utility::func_65E0("cycling_complete");
    thread scripts\engine\utility::play_loopsound_in_space("airlock_light_hum", var_2.origin);

    if(isDefined(var_2.targetname)) {
      level.func_1AE3[var_2.targetname] = var_02;
    }
  }

  scripts\engine\utility::flag_set("airlocks_setup");
}

func_1AAE() {
  var_00 = "airlock_cycling_pressurize";
  var_01 = "airlock_cycling_depressurize";
  var_02 = [];
  var_2["pressurize"] = [];
  var_2["depressurize"] = [];

  foreach(var_04 in level.createfxent) {
    if(isDefined(var_4.v["exploder"])) {
      if(var_4.v["exploder"] == var_00) {
        var_2["pressurize"] = ::scripts\engine\utility::array_add(var_2["pressurize"], var_04);
        continue;
      }

      if(var_4.v["exploder"] == var_01) {
        var_2["depressurize"] = ::scripts\engine\utility::array_add(var_2["depressurize"], var_04);
      }
    }
  }

  self.func_4CD3["pressurize"] = [];
  self.func_4CD3["depressurize"] = [];
  var_06 = ["pressurize", "depressurize"];

  foreach(var_08 in var_06) {
    foreach(var_04 in var_2[var_08]) {
      var_10 = var_4.v["fxid"];
      var_11 = var_4.v["origin"];
      var_12 = var_4.v["angles"];
      var_13 = var_4.v["delay"];
      var_14 = spawnStruct();
      var_14.func_762C = var_4.v["fxid"];
      var_14.origin = var_4.v["origin"];
      var_14.angles = var_4.v["angles"];
      var_14.delay = var_4.v["delay"];
      self.func_4CD3[var_08] = ::scripts\engine\utility::array_add(self.func_4CD3[var_08], var_14);
    }
  }
}

func_1ACF() {
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_air_fill", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-2.34019, -5.35077, 10.1119), (270, 0, 0));
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_xtrlrg_press", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((71.5714, 90.1929, 22.4209), (327.999, 271.999, 0));
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling");
  var_00 scripts\common\createfx::set_origin_and_angles((71.7566, -88.0884, 130.896), (30.9999, 89.9989, 0));
  var_0.v["delay"] = 0.1;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((23.7468, -91.7748, 133.02), (30.9999, 89.9989, 0));
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-24.1032, -92.3938, 133.065), (30.9999, 89.9989, 0));
  var_0.v["delay"] = 0.9;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-67.9505, -94.0097, 132.632), (30.9999, 89.9989, 0));
  var_0.v["delay"] = 0.15;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-72.8097, 87.5459, 131.168), (34.9998, 273.999, 0));
  var_0.v["delay"] = 0.1;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-25.4342, 86.8056, 129.173), (34.9998, 273.999, 0));
  var_0.v["delay"] = 0.75;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((25.3645, 88.4423, 130.479), (34.9998, 273.999, 0));
  var_0.v["delay"] = 0.05;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((73.602, 88.8602, 130.599), (34.9998, 273.999, 0));
  var_0.v["delay"] = 0.1;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_xtrlrg_press", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((23.2354, 93.3036, 20.1975), (327.999, 271.999, 0));
  var_0.v["delay"] = 0.4;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_xtrlrg_press", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-21.9721, 93.4224, 21.0276), (327.999, 271.999, 0));
  var_0.v["delay"] = 1;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_xtrlrg_press", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-72.7803, 94.2712, 19.7878), (327.999, 271.999, 0));
}

func_1AAF() {
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((73.2631, -85.4638, 129.046), (34.9998, 93.9989, 0));
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((23.5765, -91.5693, 131.861), (34.9998, 93.9989, 0));
  var_0.v["delay"] = 0.2;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-24.8883, -89.9546, 130.099), (34.9998, 93.9989, 0));
  var_0.v["delay"] = 0.3;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-71.6661, -90.0395, 132.764), (34.9998, 93.9989, 0));
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-21.3988, 84.8157, 127.166), (35.9998, 267.999, 0));
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-72.5438, 88.4987, 130.708), (39.9702, 273.609, 1.67727));
  var_0.v["delay"] = 0.2;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((73.4549, 86.6092, 129.863), (39.8823, 264.784, -3.34982));
  var_0.v["delay"] = 0.1;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((25.3469, 86.5301, 129.677), (39.9457, 271.876, 2.07295));
  var_0.v["delay"] = 0.3;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-23.1415, 99.9688, 14.9828), (317.999, 267.999, 0));
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((24.8086, -96.6052, 16.5775), (323.999, 90.9985, 0));
  var_0.v["delay"] = 0.3;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_camcentr_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((7.92258, -4.8918, 18.4052), (270, 0, 0));
}

func_1AB7(var_00, var_01, var_02) {
  var_03 = "back";

  if(var_00) {
    var_03 = "front";
  }

  if(var_03 == "front") {
    if(isDefined(var_01)) {
      var_01 func_1AB5(1);
    }

    if(isDefined(var_02)) {
      var_02 func_1AB5(0);
    }
  } else {
    if(isDefined(var_01)) {
      var_01 func_1AB5(0);
    }

    if(isDefined(var_02)) {
      var_02 func_1AB5(1);
    }
  }
}

func_1AB5(var_00) {
  if(self.model != "sdf_door_airlock_01") {
    if(!isDefined(self.func_ACD5)) {
      self.func_ACD5 = [];
      var_01 = [15, -7];

      foreach(var_03 in var_01) {
        var_04 = scripts\engine\utility::spawn_tag_origin();
        var_04 linkto(self, "door_jnt", (38.5, var_03, 16), (0, 0, 0));
        self.func_ACD5[self.func_ACD5.size] = var_04;
      }
    }
  }

  if(var_00) {
    func_1AB6("unlocked");
  } else {
    func_1AB6("locked");
  }
}

func_1AB2(var_00) {
  if(isDefined(var_0.func_ACD5)) {
    foreach(var_02 in var_0.func_ACD5) {
      var_02 delete();
    }
  }

  var_00 delete();
}

func_1AA9(var_00, var_01, var_02, var_03, var_04) {
  scripts\engine\utility::flag_wait("airlocks_setup");
  var_05 = scripts\engine\utility::getstruct(var_00, "targetname");
  var_05 scripts\sp\utility::func_65DD("cycling_complete");
  var_05 scripts\sp\utility::func_65E1("cycling");
  var_06 = [];

  if(isDefined(var_02)) {
    var_06 = scripts\engine\utility::array_add(var_06, var_02);
  }

  if(isDefined(var_03)) {
    var_06 = scripts\engine\utility::array_add(var_06, var_03);
  }

  foreach(var_08 in var_06) {
    if(isDefined(var_08) && !isDefined(var_8.func_ACD5)) {
      var_8.func_ACD5 = [];
      var_09 = [15, -7];

      foreach(var_11 in var_09) {
        var_12 = var_08 scripts\engine\utility::spawn_tag_origin();
        var_12 linkto(var_08, "door_jnt", (38.5, var_11, 16), (0, 0, 0));
        var_8.func_ACD5[var_8.func_ACD5.size] = var_12;
      }
    }
  }

  var_15 = "airlock_pressurize_lr";

  if(!isDefined(var_04) || var_04) {
    setglobalsoundcontext("atmosphere", "", 2);
  } else {
    var_15 = "airlock_depressurize_lr";
    setglobalsoundcontext("atmosphere", "space", 2);
  }

  var_16 = lookupsoundlength(var_15);
  var_5.func_4CD5 = 1;
  var_05 thread func_1AD7(var_16, var_04);
  scripts\engine\utility::array_thread(var_06, ::func_1AB1, var_05, "cycling");

  if(!isDefined(var_04)) {
    var_04 = 1;
  }

  var_05 thread func_1AAD(var_04);
  level.player scripts\sp\utility::play_sound_on_entity(var_15);
  var_5.func_4CD5 = 0;
  var_17 = "back";

  if(var_01) {
    var_17 = "front";
  }

  var_18 = ["front", "back"];

  foreach(var_20 in var_18) {
    if(var_20 == var_17) {
      foreach(var_22 in var_5.func_ECCE[var_20]) {
        var_22 setscriptablepartstate("root", 12);
      }

      continue;
    }

    foreach(var_22 in var_5.func_ECCE[var_20]) {
      var_22 setscriptablepartstate("root", 0);
    }
  }

  if(var_17 == "front") {
    if(isDefined(var_02)) {
      var_02 func_1AB6("locked");
    }

    if(isDefined(var_03)) {
      var_03 func_1AB6("unlocked");
      var_03 playSound("airlock_light_on");
    }
  } else {
    if(isDefined(var_02)) {
      var_02 func_1AB6("unlocked");
      var_02 playSound("airlock_light_on");
    }

    if(isDefined(var_03)) {
      var_03 func_1AB6("locked");
    }
  }

  var_05 scripts\sp\utility::func_65E1("cycling_complete");
  var_05 scripts\sp\utility::func_65DD("cycling");
}

func_1AAB(var_00, var_01, var_02, var_03) {
  var_04 = level.func_1AE3[var_00];
  var_04 scripts\sp\utility::func_65DD("cycling_complete");
  var_04 scripts\sp\utility::func_65E1("cycling");
  var_05 = [];

  if(isDefined(var_02)) {
    var_05 = scripts\engine\utility::array_add(var_05, var_02);
  }

  if(isDefined(var_03)) {
    var_05 = scripts\engine\utility::array_add(var_05, var_03);
  }

  var_4.func_4CD5 = 1;
  scripts\engine\utility::array_thread(var_05, ::func_1AB1, var_04, "cycling");
  scripts\engine\utility::play_sound_in_space("airlock_ext", var_4.origin);
  wait 8.408;
  var_4.func_4CD5 = 0;
  func_1AD8(var_00, 0, var_02, var_03);
  var_04 scripts\sp\utility::func_65E1("cycling_complete");
  var_04 scripts\sp\utility::func_65DD("cycling");
}

func_1374E(var_00) {
  scripts\engine\utility::flag_wait("airlocks_setup");
  var_01 = level.func_1AE3[var_00];
  var_01 scripts\sp\utility::func_65E3("cycling_complete");
}

func_1AAD(var_00) {
  var_01 = "pressurize";

  if(!var_00) {
    var_01 = "depressurize";
  }

  foreach(var_03 in self.func_4CD3[var_01]) {
    var_04 = var_3.func_762C;
    var_05 = 0;

    if(isDefined(var_3.delay)) {
      var_05 = var_3.delay;
    }

    var_06 = var_3.origin;
    var_07 = rotatepointaroundvector(anglestoup(self.angles), var_06, self.angles[1]);
    var_06 = var_07 + self.origin;
    var_08 = _combineangles(var_3.angles, self.angles);
    var_09 = spawnStruct();
    var_9.origin = var_06;
    var_9.angles = var_08;
    scripts\engine\utility::noself_delaycall(var_05, ::playfx, scripts\engine\utility::getfx(var_04), var_06, anglesToForward(var_08), anglestoup(var_08));
  }
}

func_1AAA(var_00) {
  scripts\engine\utility::flag_wait("airlocks_setup");
  var_01 = level.func_1AE3[var_00];
  var_02 = ["front", "back"];

  foreach(var_04 in var_02) {
    foreach(var_06 in var_1.func_ECCE[var_04]) {
      var_06 setscriptablepartstate("root", 13);
    }
  }
}

func_1AD6(var_00) {
  var_01 = ["front", "back"];
  var_02 = 0.75;

  while(self.func_4CD5) {
    foreach(var_04 in var_01) {
      foreach(var_06 in self.func_ECCE[var_04][var_00]) {
        var_06 show();
      }
    }

    wait(var_02);

    foreach(var_04 in var_01) {
      foreach(var_06 in self.func_ECCE[var_04][var_00]) {
        var_06 hide();
      }
    }

    wait(var_02);
  }

  self notify("blinking_complete");
}

func_1AD7(var_00, var_01) {
  var_02 = var_00 / 1000 / 10;
  var_03 = 1;
  var_04 = 12;

  if(isDefined(var_01) && !var_01) {
    var_03 = 11;
    var_04 = 1;
  }

  var_05 = var_03;
  var_06 = ["front", "back"];

  while(var_05 != var_04) {
    foreach(var_08 in var_06) {
      foreach(var_10 in self.func_ECCE[var_08]) {
        var_10 setscriptablepartstate("root", var_05);
      }
    }

    if(isDefined(var_01) && !var_01) {
      var_05 = var_05 - 1;
    } else {
      var_5++;
    }

    wait(var_02);
  }
}

func_1AB1(var_00, var_01) {
  self endon("death");
  func_1AB6("off");
  var_02 = 0.75;

  while(var_0.func_4CD5) {
    func_1AB6(var_01);
    wait(var_02);
    func_1AB6("off");
    wait(var_02);
  }
}

func_1AD8(var_00, var_01, var_02, var_03) {
  scripts\engine\utility::flag_wait("airlocks_setup");
  var_04 = level.func_1AE3[var_00];
  var_05 = "back";

  if(var_01) {
    var_05 = "front";
  }

  var_06 = ["front", "back"];

  foreach(var_08 in var_06) {
    if(var_08 == var_05) {
      foreach(var_10 in var_4.func_ECCE[var_08]) {
        var_10 setscriptablepartstate("root", 12);
      }

      continue;
    }

    foreach(var_10 in var_4.func_ECCE[var_08]) {
      var_10 setscriptablepartstate("root", 0);
    }
  }

  if(isDefined(var_02)) {
    var_02 func_1AB6("unlocked");
  }

  if(isDefined(var_03)) {
    var_03 func_1AB6("locked");
  }
}

func_1AB6(var_00) {
  if(self.model != "sdf_door_airlock_01") {
    if(isDefined(self.currentstate)) {
      foreach(var_02 in self.func_ACD5) {
        var_03 = func_1AB4(self.currentstate);

        if(isDefined(var_03)) {
          _killfxontag(scripts\engine\utility::getfx(var_03), var_02, "tag_origin");
        }
      }
    }

    foreach(var_02 in self.func_ACD5) {
      var_03 = func_1AB4(var_00);

      if(isDefined(var_03)) {
        playFXOnTag(scripts\engine\utility::getfx(var_03), var_02, "tag_origin");
      }
    }
  } else if(var_00 != "unlocked") {
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

  self.currentstate = var_00;
}

func_1AB4(var_00) {
  if(var_00 == "unlocked") {
    return "vfx_airlock_light_green";
  } else if(var_00 == "locked") {
    return "vfx_airlock_light_red";
  } else if(var_00 == "cycling") {
    return "vfx_airlock_light_orange";
  } else if(var_00 == "error") {
    return undefined;
  } else if(var_00 == "off") {
    return undefined;
  }
}

func_A852() {
  var_00 = undefined;
  var_01 = [];
  var_02 = scripts\sp\utility::func_7A8F();

  foreach(var_04 in var_02) {
    if(var_4.classname == "script_model") {
      if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "player") {
        self.func_D45A = 1;
        var_1["player"] = var_04;
      } else {
        if(!isDefined(var_1["ai"])) {
          var_1["ai"] = [];
        }

        var_1["ai"] = ::scripts\engine\utility::array_add(var_1["ai"], var_04);
      }

      var_04 glinton(#animtree);
      continue;
    }

    var_00 = var_04;
  }

  self.func_454F = var_01;

  if(isDefined(var_00)) {
    var_00 waittill("trigger");
  }

  if(isDefined(var_1["player"])) {
    thread func_A855();
  }

  scripts\sp\utility::func_65E3("door_sequence_complete");
}

func_A855() {
  var_00 = self.func_454F;
  var_0["player"].func_1FBB = "console_plr";
  var_0["player"] func_0E46::func_48C4("override_box_jt", undefined, undefined, undefined, 5000, undefined, 0);
  var_0["player"] waittill("trigger", var_01);
  var_02 = var_0["player"] func_D0A6("large_door_open_arrive");
  var_03 = [var_0["player"], var_02];
  var_0["player"] scripts\sp\anim::func_1F2C(var_03, "large_door_open_arrive");
  scripts\sp\utility::func_65E1("player_at_door");
  var_0["player"] thread scripts\sp\anim::func_1EE7(var_03, "large_door_open_idle");
  scripts\sp\utility::func_65E3("begin_opening");
  var_0["player"] notify("stop_loop");
  var_0["player"] scripts\sp\anim::func_1F2C(var_03, "large_door_open");
  var_01 func_5990();
  var_01 unlink();
  var_02 delete();
}

func_A854(var_00, var_01) {
  var_02 = [var_00];

  if(isDefined(var_01)) {
    if(var_1.size > 1) {} else
      var_01 = var_1[0];

    var_02 = scripts\engine\utility::array_add(var_02, var_01);
  }

  foreach(var_06, var_04 in var_02) {
    var_05 = self.func_454F["ai"][var_06];
    var_5.func_1FBB = "console_ai";
    var_4.func_A93B = var_4.func_1FBB;
    var_4.func_1FBB = "main";
    var_04 scripts\sp\utility::func_178D(scripts\sp\utility::func_137AA, "actor_at_door");
    thread func_A853(var_04, var_05);
  }

  if(isDefined(self.func_454F["player"])) {
    scripts\sp\utility::func_178D(scripts\sp\utility::func_65E3, "player_at_door");
  }

  scripts\sp\utility::func_57D5();
  scripts\sp\utility::func_65E1("actor_at_door");

  if(isDefined(self.func_D45A)) {
    scripts\sp\utility::func_65E3("player_at_door");
  }

  scripts\sp\utility::func_65E1("begin_opening");
  wait(getanimlength(var_00 scripts\sp\utility::func_7DC1("large_door_open")));

  foreach(var_04 in var_02) {
    var_4.func_1FBB = var_4.func_A93B;
  }

  scripts\sp\utility::func_65E1("door_sequence_complete");
}

func_A853(var_00, var_01) {
  var_02 = [var_00, var_01];
  var_01 scripts\sp\anim::func_1F17(var_00, "large_door_open_arrive");
  var_01 scripts\sp\anim::func_1F2C(var_02, "large_door_open_arrive");
  var_01 thread scripts\sp\anim::func_1EE7(var_02, "large_door_open_idle");
  var_00 notify("actor_at_door");
  scripts\sp\utility::func_65E3("begin_opening");
  var_01 notify("stop_loop");
  var_00 func_0A1E::func_2386();
  var_01 thread scripts\sp\anim::func_1F2C(var_02, "large_door_open");
}

buddy_down_skip_post_clear() {
  scripts\sp\utility::func_65E0("secondary_actors_going_through");
  scripts\sp\utility::func_65E0("player_prying_open_door");
  thread buddy_down_trigger_damage_onflashbang();
}

buddy_down_trigger_damage_onflashbang() {
  var_00 = "tag_ui_back";

  if(isDefined(self.func_9027)) {
    var_00 = self.func_9027;
  }

  self.func_9027 = var_00;
  var_01 = undefined;

  if(isDefined(self.func_901E)) {
    var_01 = self.func_901E;
  }

  self.func_10247 = isDefined(self.func_10247);
  var_02 = undefined;

  if(isDefined(self.func_9333)) {
    var_02 = self.func_9333;
  }

  func_0E46::func_48C4(var_00, var_01, undefined, undefined, undefined, undefined, var_02);
  self setusefov(180);
  func_0E46::func_9016();
  scripts\sp\utility::func_65E1("player_used_door");
  var_03 = func_D0A6(func_5997("intro"));

  if(isDefined(self.func_9AEF)) {
    level.player thread scripts\sp\utility::play_sound_on_entity(self.func_9AEF);
  }

  level notify("buddydoor_player_intro");
  func_59DE([self, var_03], func_5997("intro"));
  level notify("buddydoor_player_idle");
  thread func_59DE([self, var_03], func_5997("idle"), 1);
  scripts\sp\utility::func_65E1("player_at_door");
  scripts\sp\utility::func_65E3("actor_at_door");
  scripts\sp\utility::func_65E1("begin_opening");
  var_04 = [self, var_03];

  foreach(var_06 in self.func_1684) {
    if(!var_06 func_1FA3(func_5997("pull"))) {
      continue;
    }
    var_04 = scripts\engine\utility::array_add(var_04, var_06);
  }

  level notify("buddydoor_player_pry_open");
  buddy_down_two_enemy_dead_thread(var_04);
  scripts\sp\utility::func_65E1("door_opened");
  level notify("buddydoor_player_outro");
  self notify("buddydoor_outro");

  if(isDefined(self.func_427C)) {
    level.player thread scripts\sp\utility::play_sound_on_entity(self.func_427C);
  }

  var_04 = [self, var_03];
  func_59DE(var_04, func_5997("outro"));
  level.player func_5990();
  level.player unlink();
  var_03 delete();
  scripts\sp\utility::func_65E1("door_sequence_complete");
  level notify("buddydoor_player_done");
}

buddy_down_two_enemy_dead_thread(var_00) {
  level.player notifyonplayercommand("bash_pressed", "+usereload");
  level.player notifyonplayercommand("bash_pressed", "+activate");
  thread buddy_down_remove_playerclip();

  if(!isDefined(self.func_C633)) {
    self.func_C633 = 1;
  }

  var_01 = getanimlength(var_0[0] scripts\sp\utility::func_7DC1(func_5997("pull")));
  var_02 = var_01 / self.func_C633;

  if(self.func_10247) {
    thread func_2643();
  }

  for(;;) {
    level.player waittill("bash_pressed");
    level notify("buddydoor_pry_open_start");
    scripts\sp\utility::func_65E1("player_prying_open_door");
    level.player.func_2704 = 1;
    thread buddyspawn();
    var_03 = buddy_down_price_anim(0.5, 1);

    if(isDefined(var_03)) {
      continue;
    }
    scripts\engine\utility::array_thread(var_00, ::func_59F3, self);

    foreach(var_05 in var_00) {
      var_05 givescorefortrophyblocks();
    }

    scripts\sp\anim::func_1EC1(var_00, func_5997("pull"));

    foreach(var_05 in var_00) {
      if(isai(var_05)) {
        var_05 func_0A1E::func_2307(::buddyplayerid, func_0A1E::func_2385);
        continue;
      }

      var_08 = var_05 scripts\sp\utility::func_7DC1(func_5997("pull"));
      var_05 give_attacker_kill_rewards(var_08, 1, 0.2, self.func_C633);
    }

    thread buddy_down_player_engaging_early(var_02);
    var_03 = buddy_down_price_anim(var_02);

    if(!isDefined(var_03)) {
      level notify("buddydoor_pry_open_success");
      break;
    }

    level notify("buddydoor_pry_open_failed");

    if(isDefined(self.func_C62B)) {
      level.player thread scripts\sp\utility::play_sound_on_entity(self.func_C62B);
    }

    var_10 = 5;
    var_11 = var_0[0] islegacyagent(var_0[0] scripts\sp\utility::func_7DC1(func_5997("pull")));
    var_12 = var_01 * var_11;
    var_12 = var_12 / var_10;

    foreach(var_05 in var_00) {
      var_05 _meth_82B1(var_05 scripts\sp\utility::func_7DC1(func_5997("pull")), var_10 * -1);
    }

    wait(var_12);
    level.player playrumbleonentity("damage_heavy");
    self notify("stop_pry_anim");
    scripts\sp\utility::func_65DD("player_prying_open_door");
    level.player.func_2704 = 0;
    thread func_59DE(var_00, func_5997("idle"), 1);
  }

  if(isDefined(self.func_C62F)) {
    scripts\engine\utility::stop_loop_sound_on_entity(self.func_C62F);
  }

  if(isDefined(self.func_C634)) {
    thread scripts\sp\utility::play_sound_on_entity(self.func_C634);
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
  var_00 = scripts\sp\utility::func_7DC1(self.func_130FF func_5997("pull"));
  var_01 = func_0A1E::func_2356("Knobs", "body");
  self clearanim(var_01, 0);
  self animmode("noclip");
  self give_attacker_kill_rewards(var_00, 1, 0.2, self.func_130FF.func_C633);
  level waittill("ever");
}

buddyspawn() {
  self endon("buddydoor_pull_complete");

  if(isDefined(self.func_C625)) {
    self playSound(self.func_C625);
  }

  wait 0.3;

  if(isDefined(self.func_C62F)) {
    thread scripts\engine\utility::play_loop_sound_on_entity(self.func_C62F);
  }

  self waittill("buddydoor_pull_failed");

  if(isDefined(self.func_C62F)) {
    thread scripts\engine\utility::stop_loop_sound_on_entity(self.func_C62F);
  }

  if(isDefined(self.func_C625)) {
    self stopsounds();
  }
}

buddy_down_price_anim(var_00, var_01) {
  self endon("buddydoor_pull_complete");

  if(!isDefined(var_01)) {
    thread buddy_down_skip_move();
  }

  var_00 = var_00 * 1000;
  var_02 = gettime();

  for(;;) {
    if(gettime() - var_02 > var_00) {
      return;
    }
    var_03 = level.player scripts\engine\utility::waittill_notify_or_timeout_return("bash_pressed", 0.4);

    if(isDefined(var_03)) {
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
  if(self.func_10247) {
    return;
  }
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_01 = "left_door_01";

  if(isDefined(self.func_28B6)) {
    var_01 = self.func_28B6;
  }

  var_0.origin = self gettagorigin(var_01);
  var_00 linkto(self, var_01);
  var_00 func_0E46::func_48C4(undefined, undefined, "", undefined, 1000, 1000, 1, 1);
  self waittill("buddydoor_pull_complete");
  var_00 func_0E46::func_DFE3();
}

buddy_down_player_engaging_early(var_00) {
  self endon("buddydoor_pull_failed");
  wait(var_00);
  self notify("buddydoor_pull_complete");
}

buddy_down_gunner_damage_thread(var_00) {
  foreach(var_02 in var_00) {
    var_2.func_130FF = self;
    var_03 = var_2.func_1FBB + "_door_sequence_complete";
    var_04 = var_2.func_1FBB + "_at_door";
    scripts\sp\utility::func_65E0(var_04);
    scripts\sp\utility::func_65E0(var_03);
  }

  scripts\engine\utility::array_thread(var_00, ::func_598C);
  var_06 = [];

  foreach(var_02 in var_00) {
    if(!var_02 func_1FA3(func_5997("intro"))) {
      continue;
    }
    var_06 = scripts\engine\utility::array_add(var_06, var_02);
  }

  scripts\engine\utility::array_thread(var_06, ::buddy_down_gunner_death, self, var_06);
  self waittill("buddydoor_outro");
  scripts\engine\utility::array_thread(var_00, ::func_59F3, self);

  foreach(var_02 in var_00) {
    thread buddy_down_gunner_flashed_thread(var_02);
  }
}

buddy_down_gunner_death(var_00, var_01) {
  level notify("buddydoor_actors_intro");
  var_00 thread func_1162A(self);

  if(var_00 scripts\sp\utility::func_65DB("skip_reach_on_use")) {
    func_E9FF(var_00);
  } else if(!var_00 scripts\sp\utility::func_65DB("no_anim_reach")) {
    var_00 scripts\sp\anim::func_1F17(self, var_00 func_5997("intro"));
  }

  if(var_00 scripts\sp\utility::func_65DB("skip_reach_on_use")) {
    func_E9FE(var_00);
    var_00 thread func_59DE(self, var_00 func_5997("idle"), 1);
  } else {
    var_00 func_59DE(self, var_00 func_5997("intro"));
    var_00 thread func_59DE(self, var_00 func_5997("idle"), 1);
  }

  self.func_2412 = 1;
  var_00 scripts\sp\utility::func_65E1(self.func_1FBB + "_at_door");

  foreach(var_03 in var_01) {
    if(!isDefined(var_3.func_2412)) {
      return;
    }
  }

  var_00 scripts\sp\utility::func_65E1("actor_at_door");
}

func_E9FF(var_00) {
  level.player endon("player_attached_to_door");
  var_00 scripts\sp\anim::func_1F17(self, var_00 func_5997("intro"));
}

func_E9FE(var_00) {
  level.player endon("player_attached_to_door");
  var_00 func_59DE(self, var_00 func_5997("intro"));
}

buddy_down_gunner_flashed_thread(var_00) {
  var_00 endon("death");
  self endon("death");
  level notify("buddydoor_actors_outro");
  thread func_59DE(var_00, func_5997("outro"));
  var_00 waittill(func_5997("outro"));
  var_0.func_130FF = undefined;
  var_0.func_2412 = undefined;
  var_00 func_598F();
  var_01 = var_0.func_1FBB + "_door_sequence_complete";
  scripts\sp\utility::func_65E1(var_01);
  level notify("buddydoor_actors_outro_done");
}

func_21E0() {
  var_00 = scripts\sp\utility::func_7A97();

  if(isDefined(var_00)) {
    foreach(var_02 in var_00) {
      if(isDefined(var_2.targetname) && var_2.targetname == "loot_hint_struct") {
        self.func_9026 = var_02;
      }
    }
  }

  self.collision = scripts\sp\utility::func_7A8E();

  if(!isDefined(level.func_21E2)) {
    level.func_21E2 = 0;
  }

  thread func_21E9(level.func_21E2);
  level.func_21E2++;
}

func_21E9(var_00) {
  self endon("stop_door");

  if(isDefined(level.func_21E4)) {
    self[[level.func_21E4]]();
  }

  self.func_9026 func_0E46::func_48C4();
  self.func_9026 func_0E46::func_9016();
  level notify("armory_door_start_open");
  scripts\sp\utility::func_65E1("player_at_door");
  scripts\sp\utility::func_65E1("begin_opening");
  self notify("stop_loop");
  thread func_21E5();
  wait 0.7;
  thread scripts\sp\utility::play_sound_on_entity("armory_door_open");
  func_0B09::func_489F(var_00);

  if(!func_0A2F::func_D9ED(var_00)) {
    func_0A2F::func_DA49(var_00, 1);
    scripts\sp\utility::func_9145("fluff_messages_loot_room");
  }
}

func_21E5() {
  var_00 = self;
  var_0.func_1FBB = "loot_door";

  if(isDefined(self.func_4386)) {
    self.collision linkto(self, self.func_4386);
  } else {
    self.collision linkto(self, "j_handle");
  }

  if(scripts\engine\utility::is_true(self.func_72D1)) {
    self notify("stop_door");
    func_0E46::func_DFE3();
    self notify("stop_loop");
    var_00 scripts\sp\anim::func_1EE0(var_00, "open_loot_door");
    self.collision connectpaths();
    self.position = "open";

    if(scripts\sp\utility::hastag(self.model, "tag_locked")) {
      self hidepart("tag_locked", self.model);
    }

    if(scripts\sp\utility::hastag(self.model, "tag_unlocked")) {
      self giveperk("tag_unlocked", self.model);
    }
  } else {
    var_01 = var_00 func_FA17("open_loot_door");
    var_00 thread scripts\sp\anim::func_1F35(var_01, "open_loot_door", "tag_origin");
    var_00 scripts\sp\anim::func_1F35(var_00, "open_loot_door", "tag_origin");
    self.collision connectpaths();
    var_01 delete();
    level.player func_5990();
    level.player unlink();
    self.position = "open";
  }

  level notify("armory_door_open");

  if(isDefined(self.func_21E6)) {
    self thread[[self.func_21E6]]();
  }
}

func_9530(var_00) {
  var_01 = scripts\engine\utility::getstructarray("door_peek_struct", "script_noteworthy");

  if(var_1.size > 0) {
    foreach(var_03 in var_01) {
      if(var_3.targetname == var_00) {
        var_03 thread func_13684(var_3.targetname);
      }
    }
  }
}

func_13684(var_00) {
  var_01 = self;
  level waittill(var_00 + "door_peek_start");
  var_01 thread func_0B09::func_489F(0);
}

func_FA17(var_00) {
  if(isDefined(level.func_E982) && level.func_E982 == 1) {
    var_01 = scripts\sp\utility::func_10639("player_rig_disguise");
  } else {
    var_01 = scripts\sp\utility::func_10639("player_arms");
    var_02 = level.player _meth_84C6("currentViewModel");

    if(isDefined(var_02)) {
      var_01 setModel(var_02);
    }
  }

  var_01 hide();
  level.player getradiuspathsighttestnodes();
  level.player func_598D();
  var_03 = [var_01, self];
  thread scripts\sp\anim::func_1EC3(var_01, var_00);
  var_04 = 0.4;
  level.player getweaponweight(var_01, "tag_player", var_04, 0.15, 0.15);
  wait(var_04);
  var_01 show();
  return var_01;
}

func_3232() {
  var_00 = scripts\sp\utility::func_7A8F();
  scripts\engine\utility::array_call(var_00, ::linkto, self, "j_hinge2");

  foreach(var_02 in var_00) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "player_clip") {
      continue;
    }
    self.func_C969 = var_02;
  }

  if(isDefined(self.func_EF20) && self.func_EF20 == "notplayer") {
    return;
  }
  func_0E46::func_48C4(undefined, (20, -50, 55));
  self waittill("trigger", var_04);
  scripts\sp\utility::func_65E1("player_at_door");
  self.func_C969 connectpaths();
  var_05 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles + (0, 180, 0));
  var_06 = var_05 func_D0A6("bulkhead_open");
  scripts\sp\utility::func_65E1("begin_opening");
  var_07 = [self, var_06];

  if(soundexists("airlock_exit_door_open")) {
    level.player thread scripts\sp\utility::play_sound_on_entity("airlock_exit_door_open");
  }

  var_05 scripts\sp\anim::func_1F2C(var_07, "bulkhead_open");
  var_05 thread scripts\sp\anim::func_1F35(self, "bulkhead_open");
  var_05 scripts\sp\anim::func_1F2A([self], "bulkhead_open", 0.99);
  var_05 scripts\sp\anim::func_1F27([self], "bulkhead_open", 0);
  level.player func_5990();
  level.player unlink();
  var_06 delete();
  scripts\sp\utility::func_65E1("door_sequence_complete");
}

func_5982(var_00, var_01, var_02) {
  var_03 = self.func_5A18 + "_";
  var_04 = [[var_00]]();
  var_05 = [[var_01]]();
  var_06 = [[var_02]]();
  var_07 = [var_04, var_05, var_06];

  foreach(var_19, var_09 in var_07) {
    foreach(var_18, var_11 in var_09) {
      var_12 = 0;

      foreach(var_17, var_14 in var_11) {
        var_15 = getarraykeys(var_11)[var_12];
        var_16 = var_03 + var_15;

        if(var_15 == "idle") {
          level.func_EC85[var_18][var_16][0] = var_11[var_15];
        } else {
          level.func_EC85[var_18][var_16] = var_11[var_15];
        }

        var_12++;
      }
    }
  }
}

func_59EB(var_00, var_01, var_02, var_03, var_04) {
  self.func_9AEF = var_00;
  self.func_C625 = var_01;
  self.func_C62F = var_02;
  self.func_C62B = var_03;
  self.func_C634 = var_04;
}

func_598C() {
  if(isDefined(self.func_598E)) {
    scripts\sp\utility::func_61C7();
    self.func_598E = undefined;
  }
}

func_598F() {
  if(isDefined(self.func_EDAD)) {
    self.func_598E = 1;
  }
}

func_D0A6(var_00) {
  var_01 = scripts\sp\utility::func_10639("door_player_rig");

  if(var_1.model == "viewmodel_base_viewhands_iw7") {
    var_02 = level.player _meth_84C6("currentViewModel");

    if(isDefined(var_02)) {
      var_01 setModel(var_02);
    }
  }

  var_01 hide();
  level.player.func_59E1 = var_01;
  var_03 = [var_01, self];

  foreach(var_05 in var_03) {
    if(!isDefined(var_5.func_1FBB)) {
      continue;
    }
    if(!var_05 func_1FA3(var_00)) {
      continue;
    }
    thread scripts\sp\anim::func_1EC3(var_05, var_00);
  }

  var_07 = level.player scripts\engine\utility::spawn_tag_origin();
  var_7.origin = level.player.origin;
  var_7.angles = level.player getplayerangles();
  level.player getweaponvariantattachments(var_07, "tag_origin", 1, 0, 0, 0, 0, 0);
  var_08 = 0.45;

  if(isDefined(self._meth_8483)) {
    var_08 = self._meth_8483;
  }

  if(length(level.player getvelocity()) > 200) {
    var_08 = 0.25;
  }

  var_09 = var_08 / 4;
  var_10 = var_09;
  level.player func_598D();
  wait 0.3;
  level.player getweaponweight(var_01, "tag_player", var_08, var_09, var_10);
  wait(var_08);
  level.player notify("player_attached_to_door");
  level.player getweightedchanceroll(var_01, "tag_player", 1, 5, 5, 5, 5, 1);
  level.player givefriendlyperks(30, 30, 30, 30);
  var_01 show();
  var_07 delete();
  return var_01;
}

func_1162A(var_00) {
  var_00 endon("anim_reach_complete");
  scripts\sp\utility::func_65E3("player_at_door");

  if(isDefined(self.func_D83A)) {
    var_01 = self.func_D83A;
  } else {
    var_01 = 200;
  }

  if(distance(var_0.origin, self.origin) >= 200) {
    var_02 = undefined;

    if(isDefined(self.func_D83B)) {
      var_02 = self.func_D83B;
    } else {
      var_03 = anglesToForward(self.angles);
      var_03 = var_03 * -1;
      var_02 = self.origin + var_03 * var_01;
    }

    var_00 _meth_80F1(var_02, self.angles, 10000);
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

func_5997(var_00) {
  return self.func_5A18 + "_" + var_00;
}

func_59DE(var_00, var_01, var_02) {
  if(!isarray(var_00)) {
    var_00 = [var_00];
  }

  var_03 = [];

  foreach(var_05 in var_00) {
    if(!var_05 func_1FA3(var_01)) {
      continue;
    }
    if(isDefined(var_02)) {
      thread scripts\sp\anim::func_1EEA(var_05, var_01, "stop_loop_" + var_5.func_1FBB);
    } else {
      thread func_5981(var_05, var_01);
    }

    var_3[var_3.size] = var_05;
  }

  if(!isDefined(var_02) && var_3.size > 0) {
    foreach(var_05 in var_03) {
      var_05 scripts\sp\utility::func_178D(scripts\sp\utility::func_137AA, var_01);
    }

    scripts\sp\utility::func_57D5();
  }
}

func_5981(var_00, var_01) {
  scripts\sp\anim::func_1F35(var_00, var_01);
  var_00 notify(var_01);
}

func_59F3(var_00) {
  var_00 notify("stop_loop_" + self.func_1FBB);
}

func_1FA3(var_00) {
  var_01 = level.func_EC85[self.func_1FBB][var_00];

  if(isDefined(var_01)) {
    return 1;
  }

  return 0;
}

func_5983() {
  level.func_EC85["door"]["airlock_open_player"] = % airlock_open_door;
  level.func_EC85["door"]["bulkhead_open"] = % moon_2_31_secure_hangar_door;
  level.func_EC85["door"]["large_ally_door"] = % europa_armory_door_metal_bulkhead_double_01_open;
  level.func_EC85["console_plr"]["large_door_open_arrive"] = % europa_armory_override_l_plr_intro;
  level.func_EC85["console_plr"]["large_door_open_idle"][0] = % europa_armory_override_l_plr_idle;
  level.func_EC85["console_plr"]["large_door_open"] = % europa_armory_override_l_plr_pull_handle;
  level.func_EC85["console_ai"]["large_door_open_arrive"] = % europa_armory_override_r_str_intro;
  level.func_EC85["console_ai"]["large_door_open_idle"][0] = % europa_armory_override_r_str_idle;
  level.func_EC85["console_ai"]["large_door_open"] = % europa_armory_override_r_str_pull_handle;
  func_599C();
  func_59DF();
}

#using_animtree("generic_human");

func_599C() {
  level.func_EC85["main"]["large_door_open_arrive"] = % europa_armory_str_override_r_intro;
  level.func_EC85["main"]["large_door_open_idle"][0] = % europa_armory_str_override_r_idle;
  level.func_EC85["main"]["large_door_open"] = % europa_armory_str_override_r_pull_handle;
}

#using_animtree("player");

func_59DF() {
  level.func_EC87["door_player_rig"] = #animtree;
  level.func_EC8C["door_player_rig"] = "viewmodel_base_viewhands_iw7";
  level.func_EC85["door_player_rig"]["airlock_open_player"] = % airlock_open_player;
  level.func_EC85["door_player_rig"]["large_door_open_arrive"] = % europa_armory_plr_override_l_intro;
  level.func_EC85["door_player_rig"]["large_door_open_idle"][0] = % europa_armory_plr_override_l_idle;
  level.func_EC85["door_player_rig"]["large_door_open"] = % europa_armory_plr_override_l_pull_handle;
  level.func_EC85["door_player_rig"]["bulkhead_open"] = % moon_2_31_secure_hangar_plr;
}

func_5A4B() {
  if(!isDefined(level.doors)) {
    level.doors = spawnStruct();
  }

  return level.doors;
}