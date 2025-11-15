/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\dooruse.gsc
**********************************/

func_95B6() {
  level.doors = [];
  func_5983();
  func_1AC1();
  var_00 = getEntArray("generic_door", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_336) && isDefined(level.doors[var_02.var_336])) {
      if(!isDefined(level.var_FCD6) || level.var_FCD6 != 1) {
        continue;
      }
    }

    if(var_02.classname == "script_origin") {
      var_03 = var_02 scripts\engine\utility::spawn_tag_origin();
      var_03.var_336 = var_02.var_336;
      var_03.script_parameters = var_02.script_parameters;
      var_03.var_EDA0 = var_02.var_EDA0;
      var_02 = var_03;
    }

    if(isDefined(var_02.var_336)) {
      level.doors[var_02.var_336] = var_02;
      var_04 = getEntArray(var_02.var_336, "targetname");
      foreach(var_06 in var_04) {
        if(var_06.classname == "script_brushmodel") {
          var_02.collision = var_06;
        }
      }
    }

    var_02.var_5A18 = var_02.var_336;
    var_02.var_5A57 = var_02.script_parameters;
    var_02.var_1FBB = "door";
    var_02 glinton(#animtree);
    var_02 scripts\sp\utility::func_65E0("player_used_door");
    var_02 scripts\sp\utility::func_65E0("player_at_door");
    var_02 scripts\sp\utility::func_65E0("actor_at_door");
    var_02 scripts\sp\utility::func_65E0("begin_opening");
    var_02 scripts\sp\utility::func_65E0("door_opened");
    var_02 scripts\sp\utility::func_65E0("door_sequence_complete");
    var_02 scripts\sp\utility::func_65E0("no_anim_reach");
    var_02 scripts\sp\utility::func_65E0("skip_reach_on_use");
    if(isDefined(var_02.var_EDA0)) {
      var_02 scripts\sp\utility::func_65E0(var_02.var_EDA0);
    }

    var_02 scripts\sp\utility::func_65E0("locked");
    var_02 thread door_think();
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
      self.weaponisauto = "closed";
      thread func_21E0();
      break;

    case "armory_door_peek":
      self.weaponisauto = "closed";
      thread func_21E0();
      break;

    case "airlock":
      thread func_1AB0();
      break;

    case "bulkhead_door":
      thread func_3232();
      break;
  }
}

func_168A(param_00) {
  self.var_1684 = param_00;
  switch (self.var_5A57) {
    case "no_power":
      buddy_down_gunner_damage_thread(param_00);
      break;

    case "airlock":
      break;
  }
}

func_AED6() {
  if(!scripts\sp\utility::func_65DB("locked")) {
    scripts\sp\utility::func_65E1("locked");
    lib_0E46::func_DFE3();
  }
}

func_12BD3() {
  if(scripts\sp\utility::func_65DB("locked")) {
    scripts\sp\utility::func_65DD("locked");
    lib_0E46::func_48C4("tag_ui_front", (0, 0, -2));
  }
}

func_599E() {
  return scripts\sp\utility::func_65DB("locked");
}

func_1AB0() {
  var_00 = scripts\sp\utility::func_7A8F();
  scripts\engine\utility::array_call(var_00, ::linkto, self, "door_jnt");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.script_noteworthy) && var_02.script_noteworthy == "player_clip") {
      continue;
    }

    self.var_C969 = var_02;
  }

  if(isDefined(self.var_EF20) && self.var_EF20 == "notplayer") {
    return;
  }

  self.var_DF3A = 1;
  lib_0E46::func_48C4("tag_ui_front");
  self waittill("trigger", var_04);
  scripts\sp\utility::func_65E1("player_at_door");
  var_05 = func_D0A6("airlock_open_player");
  scripts\sp\utility::func_65E1("begin_opening");
  var_06 = [self, var_05];
  if(soundexists("airlock_exit_door_open")) {
    level.player thread scripts\sp\utility::play_sound_on_entity("airlock_exit_door_open");
  }

  scripts\sp\anim::func_1F2C(var_06, "airlock_open_player");
  if(scripts\engine\utility::istrue(self.var_DF3A)) {
    level.player func_5990();
    level.player unlink();
    var_05 delete();
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
  var_00 = scripts\engine\utility::getstructarray("generic_airlock_assets", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(!isDefined(var_02.var_336)) {
      continue;
    }

    var_02.var_ECCE = [];
    var_02.var_ECCE["front"] = [];
    var_02.var_ECCE["back"] = [];
    var_03 = getscriptablearray(var_02.var_336, "targetname");
    foreach(var_05 in var_03) {
      var_06 = "back";
      if(isDefined(var_05.script_noteworthy) && var_05.script_noteworthy == "forward") {
        var_06 = "front";
      }

      var_02.var_ECCE[var_06] = scripts\engine\utility::array_add(var_02.var_ECCE[var_06], var_05);
      if(var_06 == "front") {
        var_05 setscriptablepartstate("root", "0");
        continue;
      }

      var_05 setscriptablepartstate("root", "12");
    }

    var_02 func_1AAE();
    var_02 scripts\sp\utility::func_65E0("cycling");
    var_02 scripts\sp\utility::func_65E0("cycling_complete");
    thread scripts\engine\utility::play_loopsound_in_space("airlock_light_hum", var_02.origin);
    if(isDefined(var_02.var_336)) {
      level.var_1AE3[var_02.var_336] = var_02;
    }
  }

  scripts\engine\utility::flag_set("airlocks_setup");
}

func_1AAE() {
  var_00 = "airlock_cycling_pressurize";
  var_01 = "airlock_cycling_depressurize";
  var_02 = [];
  var_02["pressurize"] = [];
  var_02["depressurize"] = [];
  foreach(var_04 in level.createfxent) {
    if(isDefined(var_04.v["exploder"])) {
      if(var_04.v["exploder"] == var_00) {
        var_02["pressurize"] = scripts\engine\utility::array_add(var_02["pressurize"], var_04);
        continue;
      }

      if(var_04.v["exploder"] == var_01) {
        var_02["depressurize"] = scripts\engine\utility::array_add(var_02["depressurize"], var_04);
      }
    }
  }

  self.var_4CD3["pressurize"] = [];
  self.var_4CD3["depressurize"] = [];
  var_06 = ["pressurize", "depressurize"];
  foreach(var_08 in var_06) {
    foreach(var_04 in var_02[var_08]) {
      var_0A = var_04.v["fxid"];
      var_0B = var_04.v["origin"];
      var_0C = var_04.v["angles"];
      var_0D = var_04.v["delay"];
      var_0E = spawnStruct();
      var_0E.var_762C = var_04.v["fxid"];
      var_0E.origin = var_04.v["origin"];
      var_0E.angles = var_04.v["angles"];
      var_0E.delay = var_04.v["delay"];
      self.var_4CD3[var_08] = scripts\engine\utility::array_add(self.var_4CD3[var_08], var_0E);
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
  var_00.v["delay"] = 0.1;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((23.7468, -91.7748, 133.02), (30.9999, 89.9989, 0));
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-24.1032, -92.3938, 133.065), (30.9999, 89.9989, 0));
  var_00.v["delay"] = 0.9;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-67.9505, -94.0097, 132.632), (30.9999, 89.9989, 0));
  var_00.v["delay"] = 0.15;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-72.8097, 87.5459, 131.168), (34.9998, 273.999, 0));
  var_00.v["delay"] = 0.1;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-25.4342, 86.8056, 129.173), (34.9998, 273.999, 0));
  var_00.v["delay"] = 0.75;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((25.3645, 88.4423, 130.479), (34.9998, 273.999, 0));
  var_00.v["delay"] = 0.05;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vents_air", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((73.602, 88.8602, 130.599), (34.9998, 273.999, 0));
  var_00.v["delay"] = 0.1;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_xtrlrg_press", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((23.2354, 93.3036, 20.1975), (327.999, 271.999, 0));
  var_00.v["delay"] = 0.4;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_xtrlrg_press", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-21.9721, 93.4224, 21.0276), (327.999, 271.999, 0));
  var_00.v["delay"] = 1;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_xtrlrg_press", "airlock_cycling_pressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-72.7803, 94.2712, 19.7878), (327.999, 271.999, 0));
}

func_1AAF() {
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((73.2631, -85.4638, 129.046), (34.9998, 93.9989, 0));
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((23.5765, -91.5693, 131.861), (34.9998, 93.9989, 0));
  var_00.v["delay"] = 0.2;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-24.8883, -89.9546, 130.099), (34.9998, 93.9989, 0));
  var_00.v["delay"] = 0.3;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-71.6661, -90.0395, 132.764), (34.9998, 93.9989, 0));
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-21.3988, 84.8157, 127.166), (35.9998, 267.999, 0));
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-72.5438, 88.4987, 130.708), (39.9702, 273.609, 1.67727));
  var_00.v["delay"] = 0.2;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((73.4549, 86.6092, 129.863), (39.8823, 264.784, -3.34982));
  var_00.v["delay"] = 0.1;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((25.3469, 86.5301, 129.677), (39.9457, 271.876, 2.07295));
  var_00.v["delay"] = 0.3;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((-23.1415, 99.9688, 14.9828), (317.999, 267.999, 0));
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_vent_lrg_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((24.8086, -96.6052, 16.5775), (323.999, 90.9985, 0));
  var_00.v["delay"] = 0.3;
  var_00 = scripts\common\createfx::createexploderex("vfx_airlock_camcentr_depress", "airlock_cycling_depressurize");
  var_00 scripts\common\createfx::set_origin_and_angles((7.92258, -4.8918, 18.4052), (270, 0, 0));
}

func_1AB7(param_00, param_01, param_02) {
  var_03 = "back";
  if(param_00) {
    var_03 = "front";
  }

  if(var_03 == "front") {
    if(isDefined(param_01)) {
      param_01 func_1AB5(1);
    }

    if(isDefined(param_02)) {
      param_02 func_1AB5(0);
      return;
    }

    return;
  }

  if(isDefined(param_01)) {
    param_01 func_1AB5(0);
  }

  if(isDefined(param_02)) {
    param_02 func_1AB5(1);
  }
}

func_1AB5(param_00) {
  if(self.model != "sdf_door_airlock_01") {
    if(!isDefined(self.var_ACD5)) {
      self.var_ACD5 = [];
      var_01 = [15, -7];
      foreach(var_03 in var_01) {
        var_04 = scripts\engine\utility::spawn_tag_origin();
        var_04 linkto(self, "door_jnt", (38.5, var_03, 16), (0, 0, 0));
        self.var_ACD5[self.var_ACD5.size] = var_04;
      }
    }
  }

  if(param_00) {
    func_1AB6("unlocked");
    return;
  }

  func_1AB6("locked");
}

func_1AB2(param_00) {
  if(isDefined(param_00.var_ACD5)) {
    foreach(var_02 in param_00.var_ACD5) {
      var_02 delete();
    }
  }

  param_00 delete();
}

func_1AA9(param_00, param_01, param_02, param_03, param_04) {
  scripts\engine\utility::flag_wait("airlocks_setup");
  var_05 = scripts\engine\utility::getstruct(param_00, "targetname");
  var_05 scripts\sp\utility::func_65DD("cycling_complete");
  var_05 scripts\sp\utility::func_65E1("cycling");
  var_06 = [];
  if(isDefined(param_02)) {
    var_06 = scripts\engine\utility::array_add(var_06, param_02);
  }

  if(isDefined(param_03)) {
    var_06 = scripts\engine\utility::array_add(var_06, param_03);
  }

  foreach(var_08 in var_06) {
    if(isDefined(var_08) && !isDefined(var_08.var_ACD5)) {
      var_08.var_ACD5 = [];
      var_09 = [15, -7];
      foreach(var_0B in var_09) {
        var_0C = var_08 scripts\engine\utility::spawn_tag_origin();
        var_0C linkto(var_08, "door_jnt", (38.5, var_0B, 16), (0, 0, 0));
        var_08.var_ACD5[var_08.var_ACD5.size] = var_0C;
      }
    }
  }

  var_0F = "airlock_pressurize_lr";
  if(!isDefined(param_04) || param_04) {
    setglobalsoundcontext("atmosphere", "", 2);
  } else {
    var_0F = "airlock_depressurize_lr";
    setglobalsoundcontext("atmosphere", "space", 2);
  }

  var_10 = lookupsoundlength(var_0F);
  var_05.var_4CD5 = 1;
  var_05 thread func_1AD7(var_10, param_04);
  scripts\engine\utility::array_thread(var_06, ::func_1AB1, var_05, "cycling");
  if(!isDefined(param_04)) {
    param_04 = 1;
  }

  var_05 thread func_1AAD(param_04);
  level.player scripts\sp\utility::play_sound_on_entity(var_0F);
  var_05.var_4CD5 = 0;
  var_11 = "back";
  if(param_01) {
    var_11 = "front";
  }

  var_12 = ["front", "back"];
  foreach(var_14 in var_12) {
    if(var_14 == var_11) {
      foreach(var_16 in var_05.var_ECCE[var_14]) {
        var_16 setscriptablepartstate("root", 12);
      }

      continue;
    }

    foreach(var_16 in var_05.var_ECCE[var_14]) {
      var_16 setscriptablepartstate("root", 0);
    }
  }

  if(var_11 == "front") {
    if(isDefined(param_02)) {
      param_02 func_1AB6("locked");
    }

    if(isDefined(param_03)) {
      param_03 func_1AB6("unlocked");
      param_03 playSound("airlock_light_on");
    }
  } else {
    if(isDefined(param_02)) {
      param_02 func_1AB6("unlocked");
      param_02 playSound("airlock_light_on");
    }

    if(isDefined(param_03)) {
      param_03 func_1AB6("locked");
    }
  }

  var_05 scripts\sp\utility::func_65E1("cycling_complete");
  var_05 scripts\sp\utility::func_65DD("cycling");
}

func_1AAB(param_00, param_01, param_02, param_03) {
  var_04 = level.var_1AE3[param_00];
  var_04 scripts\sp\utility::func_65DD("cycling_complete");
  var_04 scripts\sp\utility::func_65E1("cycling");
  var_05 = [];
  if(isDefined(param_02)) {
    var_05 = scripts\engine\utility::array_add(var_05, param_02);
  }

  if(isDefined(param_03)) {
    var_05 = scripts\engine\utility::array_add(var_05, param_03);
  }

  var_04.var_4CD5 = 1;
  scripts\engine\utility::array_thread(var_05, ::func_1AB1, var_04, "cycling");
  scripts\engine\utility::play_sound_in_space("airlock_ext", var_04.origin);
  wait(8.408);
  var_04.var_4CD5 = 0;
  func_1AD8(param_00, 0, param_02, param_03);
  var_04 scripts\sp\utility::func_65E1("cycling_complete");
  var_04 scripts\sp\utility::func_65DD("cycling");
}

func_1374E(param_00) {
  scripts\engine\utility::flag_wait("airlocks_setup");
  var_01 = level.var_1AE3[param_00];
  var_01 scripts\sp\utility::func_65E3("cycling_complete");
}

func_1AAD(param_00) {
  var_01 = "pressurize";
  if(!param_00) {
    var_01 = "depressurize";
  }

  foreach(var_03 in self.var_4CD3[var_01]) {
    var_04 = var_03.var_762C;
    var_05 = 0;
    if(isDefined(var_03.delay)) {
      var_05 = var_03.delay;
    }

    var_06 = var_03.origin;
    var_07 = rotatepointaroundvector(anglestoup(self.angles), var_06, self.angles[1]);
    var_06 = var_07 + self.origin;
    var_08 = combineangles(var_03.angles, self.angles);
    var_09 = spawnStruct();
    var_09.origin = var_06;
    var_09.angles = var_08;
    scripts\engine\utility::noself_delaycall(var_05, ::playfx, scripts\engine\utility::getfx(var_04), var_06, anglesToForward(var_08), anglestoup(var_08));
  }
}

func_1AAA(param_00) {
  scripts\engine\utility::flag_wait("airlocks_setup");
  var_01 = level.var_1AE3[param_00];
  var_02 = ["front", "back"];
  foreach(var_04 in var_02) {
    foreach(var_06 in var_01.var_ECCE[var_04]) {
      var_06 setscriptablepartstate("root", 13);
    }
  }
}

func_1AD6(param_00) {
  var_01 = ["front", "back"];
  var_02 = 0.75;
  while(self.var_4CD5) {
    foreach(var_04 in var_01) {
      foreach(var_06 in self.var_ECCE[var_04][param_00]) {
        var_06 show();
      }
    }

    wait(var_02);
    foreach(var_04 in var_01) {
      foreach(var_06 in self.var_ECCE[var_04][param_00]) {
        var_06 hide();
      }
    }

    wait(var_02);
  }

  self notify("blinking_complete");
}

func_1AD7(param_00, param_01) {
  var_02 = param_00 / 1000 / 10;
  var_03 = 1;
  var_04 = 12;
  if(isDefined(param_01) && !param_01) {
    var_03 = 11;
    var_04 = 1;
  }

  var_05 = var_03;
  var_06 = ["front", "back"];
  while(var_05 != var_04) {
    foreach(var_08 in var_06) {
      foreach(var_0A in self.var_ECCE[var_08]) {
        var_0A setscriptablepartstate("root", var_05);
      }
    }

    if(isDefined(param_01) && !param_01) {
      var_05 = var_05 - 1;
      continue;
    }

    var_05++;
    wait(var_02);
  }
}

func_1AB1(param_00, param_01) {
  self endon("death");
  func_1AB6("off");
  var_02 = 0.75;
  while(param_00.var_4CD5) {
    func_1AB6(param_01);
    wait(var_02);
    func_1AB6("off");
    wait(var_02);
  }
}

func_1AD8(param_00, param_01, param_02, param_03) {
  scripts\engine\utility::flag_wait("airlocks_setup");
  var_04 = level.var_1AE3[param_00];
  var_05 = "back";
  if(param_01) {
    var_05 = "front";
  }

  var_06 = ["front", "back"];
  foreach(var_08 in var_06) {
    if(var_08 == var_05) {
      foreach(var_0A in var_04.var_ECCE[var_08]) {
        var_0A setscriptablepartstate("root", 12);
      }

      continue;
    }

    foreach(var_0A in var_04.var_ECCE[var_08]) {
      var_0A setscriptablepartstate("root", 0);
    }
  }

  if(isDefined(param_02)) {
    param_02 func_1AB6("unlocked");
  }

  if(isDefined(param_03)) {
    param_03 func_1AB6("locked");
  }
}

func_1AB6(param_00) {
  if(self.model != "sdf_door_airlock_01") {
    if(isDefined(self.currentstate)) {
      foreach(var_02 in self.var_ACD5) {
        var_03 = func_1AB4(self.currentstate);
        if(isDefined(var_03)) {
          killfxontag(scripts\engine\utility::getfx(var_03), var_02, "tag_origin");
        }
      }
    }

    foreach(var_02 in self.var_ACD5) {
      var_03 = func_1AB4(param_00);
      if(isDefined(var_03)) {
        playFXOnTag(scripts\engine\utility::getfx(var_03), var_02, "tag_origin");
      }
    }
  } else if(param_00 != "unlocked") {
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

  self.currentstate = param_00;
}

func_1AB4(param_00) {
  if(param_00 == "unlocked") {
    return "vfx_airlock_light_green";
  } else if(param_00 == "locked") {
    return "vfx_airlock_light_red";
  } else if(param_00 == "cycling") {
    return "vfx_airlock_light_orange";
  } else if(param_00 == "error") {
    return undefined;
  } else if(param_00 == "off") {
    return undefined;
  }
}

func_A852() {
  var_00 = undefined;
  var_01 = [];
  var_02 = scripts\sp\utility::func_7A8F();
  foreach(var_04 in var_02) {
    if(var_04.classname == "script_model") {
      if(isDefined(var_04.script_noteworthy) && var_04.script_noteworthy == "player") {
        self.var_D45A = 1;
        var_01["player"] = var_04;
      } else {
        if(!isDefined(var_01["ai"])) {
          var_01["ai"] = [];
        }

        var_01["ai"] = scripts\engine\utility::array_add(var_01["ai"], var_04);
      }

      var_04 glinton(#animtree);
      continue;
    }

    var_00 = var_04;
  }

  self.var_454F = var_01;
  if(isDefined(var_00)) {
    var_00 waittill("trigger");
  }

  if(isDefined(var_01["player"])) {
    thread func_A855();
  }

  scripts\sp\utility::func_65E3("door_sequence_complete");
}

func_A855() {
  var_00 = self.var_454F;
  var_00["player"].var_1FBB = "console_plr";
  var_00["player"] lib_0E46::func_48C4("override_box_jt", undefined, undefined, undefined, 5000, undefined, 0);
  var_00["player"] waittill("trigger", var_01);
  var_02 = var_00["player"] func_D0A6("large_door_open_arrive");
  var_03 = [var_00["player"], var_02];
  var_00["player"] scripts\sp\anim::func_1F2C(var_03, "large_door_open_arrive");
  scripts\sp\utility::func_65E1("player_at_door");
  var_00["player"] thread scripts\sp\anim::func_1EE7(var_03, "large_door_open_idle");
  scripts\sp\utility::func_65E3("begin_opening");
  var_00["player"] notify("stop_loop");
  var_00["player"] scripts\sp\anim::func_1F2C(var_03, "large_door_open");
  var_01 func_5990();
  var_01 unlink();
  var_02 delete();
}

func_A854(param_00, param_01) {
  var_02 = [param_00];
  if(isDefined(param_01)) {
    if(param_01.size > 1) {} else {
      param_01 = param_01[0];
    }

    var_02 = scripts\engine\utility::array_add(var_02, param_01);
  }

  foreach(var_06, var_04 in var_02) {
    var_05 = self.var_454F["ai"][var_06];
    var_05.var_1FBB = "console_ai";
    var_04.var_A93B = var_04.var_1FBB;
    var_04.var_1FBB = "main";
    var_04 scripts\sp\utility::func_178D(::scripts\sp\utility::func_137AA, "actor_at_door");
    thread func_A853(var_04, var_05);
  }

  if(isDefined(self.var_454F["player"])) {
    scripts\sp\utility::func_178D(::scripts\sp\utility::func_65E3, "player_at_door");
  }

  scripts\sp\utility::func_57D5();
  scripts\sp\utility::func_65E1("actor_at_door");
  if(isDefined(self.var_D45A)) {
    scripts\sp\utility::func_65E3("player_at_door");
  }

  scripts\sp\utility::func_65E1("begin_opening");
  wait(getanimlength(param_00 scripts\sp\utility::func_7DC1("large_door_open")));
  foreach(var_04 in var_02) {
    var_04.var_1FBB = var_04.var_A93B;
  }

  scripts\sp\utility::func_65E1("door_sequence_complete");
}

func_A853(param_00, param_01) {
  var_02 = [param_00, param_01];
  param_01 scripts\sp\anim::func_1F17(param_00, "large_door_open_arrive");
  param_01 scripts\sp\anim::func_1F2C(var_02, "large_door_open_arrive");
  param_01 thread scripts\sp\anim::func_1EE7(var_02, "large_door_open_idle");
  param_00 notify("actor_at_door");
  scripts\sp\utility::func_65E3("begin_opening");
  param_01 notify("stop_loop");
  param_00 lib_0A1E::func_2386();
  param_01 thread scripts\sp\anim::func_1F2C(var_02, "large_door_open");
}

buddy_down_skip_post_clear() {
  scripts\sp\utility::func_65E0("secondary_actors_going_through");
  scripts\sp\utility::func_65E0("player_prying_open_door");
  thread buddy_down_trigger_damage_onflashbang();
}

buddy_down_trigger_damage_onflashbang() {
  var_00 = "tag_ui_back";
  if(isDefined(self.var_9027)) {
    var_00 = self.var_9027;
  }

  self.var_9027 = var_00;
  var_01 = undefined;
  if(isDefined(self.var_901E)) {
    var_01 = self.var_901E;
  }

  self.var_10247 = isDefined(self.var_10247);
  var_02 = undefined;
  if(isDefined(self.var_9333)) {
    var_02 = self.var_9333;
  }

  lib_0E46::func_48C4(var_00, var_01, undefined, undefined, undefined, undefined, var_02);
  self setusefov(180);
  lib_0E46::func_9016();
  scripts\sp\utility::func_65E1("player_used_door");
  var_03 = func_D0A6(func_5997("intro"));
  if(isDefined(self.var_9AEF)) {
    level.player thread scripts\sp\utility::play_sound_on_entity(self.var_9AEF);
  }

  level notify("buddydoor_player_intro");
  func_59DE([self, var_03], func_5997("intro"));
  level notify("buddydoor_player_idle");
  thread func_59DE([self, var_03], func_5997("idle"), 1);
  scripts\sp\utility::func_65E1("player_at_door");
  scripts\sp\utility::func_65E3("actor_at_door");
  scripts\sp\utility::func_65E1("begin_opening");
  var_04 = [self, var_03];
  foreach(var_06 in self.var_1684) {
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
  if(isDefined(self.var_427C)) {
    level.player thread scripts\sp\utility::play_sound_on_entity(self.var_427C);
  }

  var_04 = [self, var_03];
  func_59DE(var_04, func_5997("outro"));
  level.player func_5990();
  level.player unlink();
  var_03 delete();
  scripts\sp\utility::func_65E1("door_sequence_complete");
  level notify("buddydoor_player_done");
}

buddy_down_two_enemy_dead_thread(param_00) {
  level.player notifyonplayercommand("bash_pressed", "+usereload");
  level.player notifyonplayercommand("bash_pressed", "+activate");
  thread buddy_down_remove_playerclip();
  if(!isDefined(self.var_C633)) {
    self.var_C633 = 1;
  }

  var_01 = getanimlength(param_00[0] scripts\sp\utility::func_7DC1(func_5997("pull")));
  var_02 = var_01 / self.var_C633;
  if(self.var_10247) {
    thread func_2643();
  }

  for(;;) {
    level.player waittill("bash_pressed");
    level notify("buddydoor_pry_open_start");
    scripts\sp\utility::func_65E1("player_prying_open_door");
    level.player.var_2704 = 1;
    thread buddyspawn();
    var_03 = buddy_down_price_anim(0.5, 1);
    if(isDefined(var_03)) {
      continue;
    }

    scripts\engine\utility::array_thread(param_00, ::func_59F3, self);
    foreach(var_05 in param_00) {
      var_05 givescorefortrophyblocks();
    }

    scripts\sp\anim::func_1EC1(param_00, func_5997("pull"));
    foreach(var_05 in param_00) {
      if(isai(var_05)) {
        var_05 lib_0A1E::func_2307(::buddyplayerid, ::lib_0A1E::func_2385);
        continue;
      }

      var_08 = var_05 scripts\sp\utility::func_7DC1(func_5997("pull"));
      var_05 give_attacker_kill_rewards(var_08, 1, 0.2, self.var_C633);
    }

    thread buddy_down_player_engaging_early(var_02);
    var_03 = buddy_down_price_anim(var_02);
    if(!isDefined(var_03)) {
      level notify("buddydoor_pry_open_success");
      break;
    }

    level notify("buddydoor_pry_open_failed");
    if(isDefined(self.var_C62B)) {
      level.player thread scripts\sp\utility::play_sound_on_entity(self.var_C62B);
    }

    var_0A = 5;
    var_0B = param_00[0] getscoreinfocategory(param_00[0] scripts\sp\utility::func_7DC1(func_5997("pull")));
    var_0C = var_01 * var_0B;
    var_0C = var_0C / var_0A;
    foreach(var_05 in param_00) {
      var_05 _meth_82B1(var_05 scripts\sp\utility::func_7DC1(func_5997("pull")), var_0A * -1);
    }

    wait(var_0C);
    level.player playrumbleonentity("damage_heavy");
    self notify("stop_pry_anim");
    scripts\sp\utility::func_65DD("player_prying_open_door");
    level.player.var_2704 = 0;
    thread func_59DE(param_00, func_5997("idle"), 1);
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
    wait(0.05);
  }
}

buddyplayerid() {
  self endon("stop_pry_anim");
  self endon("buddydoor_pull_complete");
  var_00 = scripts\sp\utility::func_7DC1(self.var_130FF func_5997("pull"));
  var_01 = lib_0A1E::func_2356("Knobs", "body");
  self clearanim(var_01, 0);
  self animmode("noclip");
  self give_attacker_kill_rewards(var_00, 1, 0.2, self.var_130FF.var_C633);
  level waittill("ever");
}

buddyspawn() {
  self endon("buddydoor_pull_complete");
  if(isDefined(self.var_C625)) {
    self playSound(self.var_C625);
  }

  wait(0.3);
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

buddy_down_price_anim(param_00, param_01) {
  self endon("buddydoor_pull_complete");
  if(!isDefined(param_01)) {
    thread buddy_down_skip_move();
  }

  param_00 = param_00 * 1000;
  var_02 = gettime();
  for(;;) {
    if(gettime() - var_02 > param_00) {
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
    wait(0.05);
  }
}

buddy_down_remove_playerclip() {
  if(self.var_10247) {
    return;
  }

  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_01 = "left_door_01";
  if(isDefined(self.var_28B6)) {
    var_01 = self.var_28B6;
  }

  var_00.origin = self gettagorigin(var_01);
  var_00 linkto(self, var_01);
  var_00 lib_0E46::func_48C4(undefined, undefined, "", undefined, 1000, 1000, 1, 1);
  self waittill("buddydoor_pull_complete");
  var_00 lib_0E46::func_DFE3();
}

buddy_down_player_engaging_early(param_00) {
  self endon("buddydoor_pull_failed");
  wait(param_00);
  self notify("buddydoor_pull_complete");
}

buddy_down_gunner_damage_thread(param_00) {
  foreach(var_02 in param_00) {
    var_02.var_130FF = self;
    var_03 = var_02.var_1FBB + "_door_sequence_complete";
    var_04 = var_02.var_1FBB + "_at_door";
    scripts\sp\utility::func_65E0(var_04);
    scripts\sp\utility::func_65E0(var_03);
  }

  scripts\engine\utility::array_thread(param_00, ::func_598C);
  var_06 = [];
  foreach(var_02 in param_00) {
    if(!var_02 func_1FA3(func_5997("intro"))) {
      continue;
    }

    var_06 = scripts\engine\utility::array_add(var_06, var_02);
  }

  scripts\engine\utility::array_thread(var_06, ::buddy_down_gunner_death, self, var_06);
  self waittill("buddydoor_outro");
  scripts\engine\utility::array_thread(param_00, ::func_59F3, self);
  foreach(var_02 in param_00) {
    thread buddy_down_gunner_flashed_thread(var_02);
  }
}

buddy_down_gunner_death(param_00, param_01) {
  level notify("buddydoor_actors_intro");
  param_00 thread func_1162A(self);
  if(param_00 scripts\sp\utility::func_65DB("skip_reach_on_use")) {
    func_E9FF(param_00);
  } else if(!param_00 scripts\sp\utility::func_65DB("no_anim_reach")) {
    param_00 scripts\sp\anim::func_1F17(self, param_00 func_5997("intro"));
  }

  if(param_00 scripts\sp\utility::func_65DB("skip_reach_on_use")) {
    func_E9FE(param_00);
    param_00 thread func_59DE(self, param_00 func_5997("idle"), 1);
  } else {
    param_00 func_59DE(self, param_00 func_5997("intro"));
    param_00 thread func_59DE(self, param_00 func_5997("idle"), 1);
  }

  self.var_2412 = 1;
  param_00 scripts\sp\utility::func_65E1(self.var_1FBB + "_at_door");
  foreach(var_03 in param_01) {
    if(!isDefined(var_03.var_2412)) {
      return;
    }
  }

  param_00 scripts\sp\utility::func_65E1("actor_at_door");
}

func_E9FF(param_00) {
  level.player endon("player_attached_to_door");
  param_00 scripts\sp\anim::func_1F17(self, param_00 func_5997("intro"));
}

func_E9FE(param_00) {
  level.player endon("player_attached_to_door");
  param_00 func_59DE(self, param_00 func_5997("intro"));
}

buddy_down_gunner_flashed_thread(param_00) {
  param_00 endon("death");
  self endon("death");
  level notify("buddydoor_actors_outro");
  thread func_59DE(param_00, func_5997("outro"));
  param_00 waittill(func_5997("outro"));
  param_00.var_130FF = undefined;
  param_00.var_2412 = undefined;
  param_00 func_598F();
  var_01 = param_00.var_1FBB + "_door_sequence_complete";
  scripts\sp\utility::func_65E1(var_01);
  level notify("buddydoor_actors_outro_done");
}

func_21E0() {
  var_00 = scripts\sp\utility::func_7A97();
  if(isDefined(var_00)) {
    foreach(var_02 in var_00) {
      if(isDefined(var_02.var_336) && var_02.var_336 == "loot_hint_struct") {
        self.var_9026 = var_02;
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

func_21E9(param_00) {
  self endon("stop_door");
  if(isDefined(level.var_21E4)) {
    self[[level.var_21E4]]();
  }

  self.var_9026 lib_0E46::func_48C4();
  self.var_9026 lib_0E46::func_9016();
  level notify("armory_door_start_open");
  scripts\sp\utility::func_65E1("player_at_door");
  scripts\sp\utility::func_65E1("begin_opening");
  self notify("stop_loop");
  thread func_21E5();
  wait(0.7);
  thread scripts\sp\utility::play_sound_on_entity("armory_door_open");
  scripts\sp\armoury::func_489F(param_00);
  if(!lib_0A2F::func_D9ED(param_00)) {
    lib_0A2F::func_DA49(param_00, 1);
    scripts\sp\utility::func_9145("fluff_messages_loot_room");
  }
}

func_21E5() {
  var_00 = self;
  var_00.var_1FBB = "loot_door";
  if(isDefined(self.var_4386)) {
    self.collision linkto(self, self.var_4386);
  } else {
    self.collision linkto(self, "j_handle");
  }

  if(scripts\engine\utility::istrue(self.var_72D1)) {
    self notify("stop_door");
    lib_0E46::func_DFE3();
    self notify("stop_loop");
    var_00 scripts\sp\anim::func_1EE0(var_00, "open_loot_door");
    self.collision connectpaths();
    self.weaponisauto = "open";
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
    self.weaponisauto = "open";
  }

  level notify("armory_door_open");
  if(isDefined(self.var_21E6)) {
    self thread[[self.var_21E6]]();
  }
}

func_9530(param_00) {
  var_01 = scripts\engine\utility::getstructarray("door_peek_struct", "script_noteworthy");
  if(var_01.size > 0) {
    foreach(var_03 in var_01) {
      if(var_03.var_336 == param_00) {
        var_03 thread func_13684(var_03.var_336);
      }
    }
  }
}

func_13684(param_00) {
  var_01 = self;
  level waittill(param_00 + "door_peek_start");
  var_01 thread scripts\sp\armoury::func_489F(0);
}

func_FA17(param_00) {
  if(isDefined(level.var_E982) && level.var_E982 == 1) {
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
  thread scripts\sp\anim::func_1EC3(var_01, param_00);
  var_04 = 0.4;
  level.player playerlinktoblend(var_01, "tag_player", var_04, 0.15, 0.15);
  wait(var_04);
  var_01 show();
  return var_01;
}

func_3232() {
  var_00 = scripts\sp\utility::func_7A8F();
  scripts\engine\utility::array_call(var_00, ::linkto, self, "j_hinge2");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.script_noteworthy) && var_02.script_noteworthy == "player_clip") {
      continue;
    }

    self.var_C969 = var_02;
  }

  if(isDefined(self.var_EF20) && self.var_EF20 == "notplayer") {
    return;
  }

  lib_0E46::func_48C4(undefined, (20, -50, 55));
  self waittill("trigger", var_04);
  scripts\sp\utility::func_65E1("player_at_door");
  self.var_C969 connectpaths();
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

func_5982(param_00, param_01, param_02) {
  var_03 = self.var_5A18 + "_";
  var_04 = [
    [param_00]
  ]();
  var_05 = [
    [param_01]
  ]();
  var_06 = [
    [param_02]
  ]();
  var_07 = [var_04, var_05, var_06];
  foreach(var_09 in var_07) {
    foreach(var_12, var_0B in var_09) {
      var_0C = 0;
      foreach(var_0E in var_0B) {
        var_0F = getarraykeys(var_0B)[var_0C];
        var_10 = var_03 + var_0F;
        if(var_0F == "idle") {
          level.var_EC85[var_12][var_10][0] = var_0B[var_0F];
        } else {
          level.var_EC85[var_12][var_10] = var_0B[var_0F];
        }

        var_0C++;
      }
    }
  }
}

func_59EB(param_00, param_01, param_02, param_03, param_04) {
  self.var_9AEF = param_00;
  self.var_C625 = param_01;
  self.var_C62F = param_02;
  self.var_C62B = param_03;
  self.var_C634 = param_04;
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

func_D0A6(param_00) {
  var_01 = scripts\sp\utility::func_10639("door_player_rig");
  if(var_01.model == "viewmodel_base_viewhands_iw7") {
    var_02 = level.player _meth_84C6("currentViewModel");
    if(isDefined(var_02)) {
      var_01 setModel(var_02);
    }
  }

  var_01 hide();
  level.player.var_59E1 = var_01;
  var_03 = [var_01, self];
  foreach(var_05 in var_03) {
    if(!isDefined(var_05.var_1FBB)) {
      continue;
    }

    if(!var_05 func_1FA3(param_00)) {
      continue;
    }

    thread scripts\sp\anim::func_1EC3(var_05, param_00);
  }

  var_07 = level.player scripts\engine\utility::spawn_tag_origin();
  var_07.origin = level.player.origin;
  var_07.angles = level.player getplayerangles();
  level.player playerlinkto(var_07, "tag_origin", 1, 0, 0, 0, 0, 0);
  var_08 = 0.45;
  if(isDefined(self._meth_8483)) {
    var_08 = self._meth_8483;
  }

  if(length(level.player getvelocity()) > 200) {
    var_08 = 0.25;
  }

  var_09 = var_08 / 4;
  var_0A = var_09;
  level.player func_598D();
  wait(0.3);
  level.player playerlinktoblend(var_01, "tag_player", var_08, var_09, var_0A);
  wait(var_08);
  level.player notify("player_attached_to_door");
  level.player playerlinktodelta(var_01, "tag_player", 1, 5, 5, 5, 5, 1);
  level.player givefriendlyperks(30, 30, 30, 30);
  var_01 show();
  var_07 delete();
  return var_01;
}

func_1162A(param_00) {
  param_00 endon("anim_reach_complete");
  scripts\sp\utility::func_65E3("player_at_door");
  if(isDefined(self.var_D83A)) {
    var_01 = self.var_D83A;
  } else {
    var_01 = 200;
  }

  if(distance(param_00.origin, self.origin) >= 200) {
    var_02 = undefined;
    if(isDefined(self.var_D83B)) {
      var_02 = self.var_D83B;
    } else {
      var_03 = anglesToForward(self.angles);
      var_03 = var_03 * -1;
      var_02 = self.origin + var_03 * var_01;
    }

    param_00 _meth_80F1(var_02, self.angles, 10000);
  }
}

func_598D() {
  level.player _meth_84FE();
  level.player getradiuspathsighttestnodes();
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_crouch(0);
  level.player getnumownedagentsonteambytype(0);
  level.player getrankinfoxpamt();
}

func_5990() {
  level.player enableweapons();
  level.player getnumownedagentsonteambytype(1);
  level.player freezecontrols(0);
  level.player scripts\engine\utility::allow_prone(1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player _meth_80A1();
  level.player _meth_84FD();
}

func_5997(param_00) {
  return self.var_5A18 + "_" + param_00;
}

func_59DE(param_00, param_01, param_02) {
  if(!isarray(param_00)) {
    param_00 = [param_00];
  }

  var_03 = [];
  foreach(var_05 in param_00) {
    if(!var_05 func_1FA3(param_01)) {
      continue;
    }

    if(isDefined(param_02)) {
      thread scripts\sp\anim::func_1EEA(var_05, param_01, "stop_loop_" + var_05.var_1FBB);
    } else {
      thread func_5981(var_05, param_01);
    }

    var_03[var_03.size] = var_05;
  }

  if(!isDefined(param_02) && var_03.size > 0) {
    foreach(var_05 in var_03) {
      var_05 scripts\sp\utility::func_178D(::scripts\sp\utility::func_137AA, param_01);
    }

    scripts\sp\utility::func_57D5();
  }
}

func_5981(param_00, param_01) {
  scripts\sp\anim::func_1F35(param_00, param_01);
  param_00 notify(param_01);
}

func_59F3(param_00) {
  param_00 notify("stop_loop_" + self.var_1FBB);
}

func_1FA3(param_00) {
  var_01 = level.var_EC85[self.var_1FBB][param_00];
  if(isDefined(var_01)) {
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

func_599C() {
  level.var_EC85["main"]["large_door_open_arrive"] = % europa_armory_str_override_r_intro;
  level.var_EC85["main"]["large_door_open_idle"][0] = % europa_armory_str_override_r_idle;
  level.var_EC85["main"]["large_door_open"] = % europa_armory_str_override_r_pull_handle;
}

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