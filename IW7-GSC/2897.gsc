/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2897.gsc
**************************************/

func_B8CB() {
  if(!isDefined(level.var_FD6E)) {
    level.var_FD6E = spawnStruct();
  }

  return level.var_FD6E;
}

func_E3C6(var_0, var_1, var_2, var_3, var_4) {
  level notify("stop jackal landing");
  level endon("stop jackal landing");

  if(getdvarint("skip_nextmission", 0)) {
    var_0 = 0;
  } else if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  func_0BDC::func_137CF();
  level.var_FD6E.var_E35D thread func_0BDB::func_A2F2(undefined, var_4);
  level waittill("player_jackal_drone_dock");

  if(var_1) {
    if(isDefined(var_2)) {
      if(isDefined(level.var_B8D2.var_ABFA[scripts\sp\endmission::func_7F6B(var_2)].var_D845)) {
        var_5 = scripts\engine\utility::array_add(level.var_B8D2.var_ABFA[scripts\sp\endmission::func_7F6B(var_2)].var_D845, var_2);
        _preloadzones(var_5);
      } else {
        _preloadzones(var_2);
      }
    } else {
      level thread scripts\sp\utility::func_BF97();
    }
  }

  level waittill("jackal_taxi_complete");

  if(var_0) {
    if(isDefined(var_2)) {
      _setsaveddvar("bg_cinematicAboveUI", "0");
      _setsaveddvar("bg_cinematicFullScreen", "1");
      _setsaveddvar("bg_cinematicCanPause", "1");
      var_6 = level.var_B8D2.var_ABFA[scripts\sp\endmission::func_7F6B(var_2)].var_2AD3;
      setdvar("last_transition_movie", var_6);
      _cinematicingame(var_6, 0, 1);
      _changelevel(var_2);
    } else {
      scripts\sp\utility::func_BF95();
    }
  }
}

func_E3C7(var_0) {
  level.player endon("death");
  var_1 = level.var_FD6E.var_E35D.unique_id;

  if(!isDefined(level.var_FD6E.var_E35D.unique_id)) {
    var_1 = "_ignore_last_sparam";
  }

  var_2 = func_0EFB::func_7994("ret_jackal_spawner_1", "targetname", var_1);

  if(var_2.size != 1) {
    return;
  }
  switch (var_0) {
    case "player":
      var_3 = func_0EFB::func_798E("ret_jackal_spawner_1", "targetname", var_1);
      var_4 = var_3 scripts\sp\utility::func_10808();
      var_4 vehicle_teleport(level.var_FD6E.var_E35D.var_A0C9.origin + (0, 0, -138), level.var_FD6E.var_E35D.var_A0C9.angles);
      var_4 func_0BDC::func_6B4C("none");
      var_4 func_0BDC::func_F43D("player");
      var_4 scripts\engine\utility::delaythread(0.0, func_0BDC::func_A167);
      level thread func_0BDC::func_10CD1(var_4, undefined, "retribution");
      break;
    case "jackal_bay_1":
      break;
    case "jackal_bay_2":
      break;
    case "jackal_bay_3":
      break;
    case "jackal_bay_4":
      break;
  }
}

func_B8CA(var_0) {
  func_B8CB();
  level.var_FD6E.var_E35D = func_973A("retribution", var_0);
  level.var_FD6E.var_E35D.unique_id = var_0;
}

func_ACE8() {
  while(!isDefined(level.var_D127)) {
    wait 0.05;
  }
}

#using_animtree("script_model");

func_973A(var_0, var_1) {
  var_2 = getEntArray(var_0 + "_shipcrib", "script_noteworthy");

  if(isDefined(var_1)) {
    var_2 = func_0EFB::func_7994(var_0 + "_shipcrib", "script_noteworthy", var_1);
  } else {
    var_1 = "_ignore_last_sparam";
  }

  var_3 = var_2;
  var_4 = undefined;

  foreach(var_6 in var_2) {
    if(isDefined(var_6.var_EE52) && var_6.var_EE52 == "root") {
      var_4 = var_6;
      var_2 = scripts\engine\utility::array_remove(var_2, var_6);
      break;
    }
  }

  foreach(var_6 in var_2) {
    if(isDefined(var_6.var_EE52)) {
      switch (var_6.var_EE52) {
        case "jackal_runway":
          var_4.var_E8AD = var_6;
          var_4.var_E8AD linkto(var_4);
          break;
        case "jackal_runway_r":
          var_4.var_E8CB = var_6;
          var_4.var_E8CB linkto(var_4);
          break;
        case "refl_probe":
          var_6 linkto(var_4);
          break;
      }
    }
  }

  var_10 = [];
  var_11 = [];
  var_12 = [];
  var_13 = [];
  var_14 = [];
  var_15 = undefined;
  var_16 = undefined;

  foreach(var_6 in var_2) {
    if(isDefined(var_6.var_EE52)) {
      switch (var_6.var_EE52) {
        case "bink_klaxon":
          var_10 = scripts\engine\utility::array_add(var_10, var_6);
          break;
        case "bink_fill_lights":
          var_11 = scripts\engine\utility::array_add(var_11, var_6);
          break;
        case "bink_flashing_lights":
          var_12 = scripts\engine\utility::array_add(var_12, var_6);
          break;
        case "jackal_runway_final_dest":
          var_4.var_E8AD.var_6C1E = var_6;
          var_4.var_E8AD.var_6C1E linkto(var_4);
          var_4.var_E8CB.var_6C1E = var_6;
          break;
        case "runway_hangar_light":
          var_13 = scripts\engine\utility::array_add(var_13, var_6);
          var_6 linkto(var_4);
          break;
        case "trigger_flag_on_runway":
          var_6 getrankxp();
          var_6 linkto(var_4);
          var_4.var_E8AD.var_12713 = var_6;
          break;
        case "runway_light":
          if(!scripts\engine\utility::fxexists("vfx_glow_red_light_400_strobe")) {
            scripts\engine\utility::add_fx("vfx_glow_red_light_400_strobe", "vfx\misc\lights\vfx_glow_red_light_400_strobe.vfx");
          }

          playFXOnTag(scripts\engine\utility::getfx("vfx_glow_red_light_400_strobe"), var_6, "light_on_LOD0");
          break;
        case "drone_receiver":
          var_14 = scripts\engine\utility::array_add(var_14, var_6);
          var_6 glinton(#animtree);
          var_6 give_attacker_kill_rewards(%machinery_landing_drone_recovery, 1, 0, 0);
          var_6 linkto(var_4);
          break;
        case "ret_hangar_door":
          var_16 = var_6;
          var_6 linkto(var_4);
          break;
        case "ret_hangar_door_end":
          var_15 = var_6;
          var_6 notsolid();
          var_6 hide();
          var_6 linkto(var_4);
          break;
      }
    }
  }

  foreach(var_20 in var_10) {
    var_20 glinton(#animtree);
    var_20.lights = [];
    var_21 = getEntArray(var_20.target, "targetname");

    foreach(var_23 in var_21) {
      if(var_23.code_classname == "light") {
        var_23 linkto(var_20, "j_spin");
        var_23.var_9C2E = 1;
        var_20.lights[var_20.lights.size] = var_23;
      }

      if(var_23.code_classname == "script_model") {
        var_20.var_A6EC = var_23;
        var_23.var_9C2E = 1;
        var_23 linkto(var_20);
      }
    }

    var_20 hide();
    var_20.var_A6EC show();
  }

  if(isDefined(var_16)) {
    var_16.start = scripts\engine\utility::spawn_tag_origin();
    var_16.start.origin = var_16.origin;
    var_16.start.angles = var_16.angles;
    var_16.start linkto(var_4);
    var_16.end = var_15;
  }

  var_4.var_E8AD.var_2ADB = var_10;
  var_4.var_E8CB.var_2ADB = var_10;
  var_4.var_E8AD.var_2AD8 = var_11;
  var_4.var_E8CB.var_2AD8 = var_11;
  var_4.var_E8AD.var_2ADA = var_12;
  var_4.var_E8CB.var_2ADA = var_12;
  var_4.var_E8AD.var_8A9D = var_13;
  var_4.var_E8CB.var_8A9D = var_13;
  var_4.var_E8AD.var_5C6C = var_14;
  var_4.var_E8CB.var_5C6C = var_14;
  var_4.var_E8AD.var_E311 = var_16;
  var_4.var_E8CB.var_E311 = var_16;

  foreach(var_6 in var_2) {
    switch (var_6.code_classname) {
      case "trigger_multiple":
      case "script_vehicle":
        break;
      case "light":
      case "script_model":
      case "script_brushmodel":
      default:
        if(isDefined(var_6.var_9C2E)) {
          break;
        }
        var_6 linkto(var_4);
        break;
    }
  }

  var_28 = func_0EFB::func_7CC1("ret_jackal_bay_1", "script_noteworthy", var_1);
  var_29 = func_0EFB::func_7994("ret_jackal_bay_1", "script_noteworthy", var_1);
  var_30 = scripts\sp\utility::func_22A2(var_28, var_29);

  foreach(var_32 in var_30) {
    if(isDefined(var_32.var_EE52)) {
      switch (var_32.var_EE52) {
        case "clamp_pos1":
          var_4.var_A0C9 = var_32;
          break;
        case "clamp_pos2":
          var_4.var_A0CC = var_32;
          break;
        case "door_end_top":
          var_33 = getent(var_32.target, "targetname");
          var_33 linkto(var_32);
          var_32 rotateto(var_32.angles + (110, 0, 0), 0.05);
          var_4.var_A0CB = var_32;
          break;
        case "door_end_bottom":
          var_33 = getent(var_32.target, "targetname");
          var_33 linkto(var_32);
          var_32 rotateto(var_32.angles + (-110, 0, 0), 0.05);
          var_4.var_A0CA = var_32;
          break;
      }
    }
  }

  var_4 attach("veh_mil_air_un_retribution_rig");
  var_4.var_E505 = "veh_mil_air_un_retribution_rig";
  var_4 thread func_10635();
  var_4.partnerheli = var_3;
  return var_4;
}

func_B8C9() {
  func_5192(level.var_FD6E.var_BA43);
  func_5192(level.var_FD6E.var_118A8);
  func_5192(level.var_FD6E.var_E35D);
}

func_5192() {
  var_0 = getEntArray(self.script_noteworthy, "script_noteworthy");
  scripts\engine\utility::array_call(var_0, ::delete);
}

func_494F(var_0) {}

func_FDCB(var_0) {
  var_1 = [];
  var_2 = ["trigger_multiple", "reflection_probe", "locator_volume"];

  foreach(var_4 in self.partnerheli) {
    if(!scripts\engine\utility::array_contains(var_2, var_4.code_classname)) {
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
    }
  }

  switch (var_0) {
    case "hide":
      scripts\engine\utility::array_call(var_1, ::hide);
      scripts\engine\utility::array_call(self.var_747F, ::hide);
      break;
    case "show":
      scripts\engine\utility::array_call(var_1, ::show);
      scripts\engine\utility::array_call(self.var_747F, ::show);
      break;
    case "solid":
      scripts\engine\utility::array_call(var_1, ::solid);
      break;
    case "notsolid":
      scripts\engine\utility::array_call(var_1, ::notsolid);
      break;
  }
}

func_10635() {
  if(isDefined(level.var_E3FB)) {
    scripts\engine\utility::flag_wait(level.var_E3FB);
  }

  self.var_74A1 = scripts\engine\utility::spawn_tag_origin();
  self.var_74A1.origin = self.var_74A1.origin + anglesToForward(self.angles) * 13000;
  self.var_74A1.origin = self.var_74A1.origin + anglestoup(self.angles) * 1500;
  self.var_74A1 linkto(self);

  if(isDefined(self.var_E505)) {
    var_0 = self.var_E505;
  } else {
    var_0 = self.model;
  }

  var_1 = _getnumparts(var_0);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = _getpartname(var_0, var_2);

    if(getsubstr(var_3, 0, 4) == "mdl_") {
      var_4 = getsubstr(var_3, 4, var_3.size - 3);
      var_5 = spawn("script_model", self gettagorigin(var_3));
      var_5 glinton(#animtree);
      var_5.angles = self gettagangles(var_3);
      var_5 linkto(self, var_3);
      var_6 = getsubstr(var_3, var_3.size - 4, var_3.size);
      self.var_747F[var_6] = var_5;

      if(var_3[var_3.size - 1] == "r") {
        var_7 = "_r";
        var_8 = 1;
        self.var_747F[var_6].var_101AD = "_r";
      } else {
        var_7 = "";
        var_8 = -1;
        self.var_747F[var_6].var_101AD = "_l";
      }

      switch (var_4) {
        case "ftl_a":
          var_5 setModel("veh_mil_air_un_retribution_ftl_a" + var_7);
          self.var_747F[var_6].var_7601 = scripts\engine\utility::spawn_tag_origin(var_5.origin + anglestoright(var_5.angles) * 700, var_5.angles);
          self.var_747F[var_6].var_7601.origin = self.var_747F[var_6].var_7601.origin + anglesToForward(var_5.angles) * 90 * var_8;
          self.var_747F[var_6].var_7601.origin = self.var_747F[var_6].var_7601.origin + anglestoup(var_5.angles) * -50;
          break;
        case "ftl_b":
          var_5 setModel("veh_mil_air_un_retribution_ftl_b" + var_7);
          self.var_747F[var_6].var_7601 = scripts\engine\utility::spawn_tag_origin(var_5.origin + anglestoright(var_5.angles) * 480, var_5.angles);
          self.var_747F[var_6].var_7601.origin = self.var_747F[var_6].var_7601.origin + anglesToForward(var_5.angles) * 65 * var_8;
          self.var_747F[var_6].var_7601.origin = self.var_747F[var_6].var_7601.origin + anglestoup(var_5.angles) * -40;
          break;
      }

      self.var_747F[var_6].var_7601.angles = self.var_747F[var_6].var_7601.angles + (90, 0, 90);
      self.var_747F[var_6].var_7601 linkto(var_5, "bone_door_hinge_main");
    }
  }

  self.var_747E = [];
  var_9 = getarraykeys(self.var_747F);

  foreach(var_11 in var_9) {
    var_12 = getsubstr(var_11, 0, 3);
    var_13 = getarraykeys(self.var_747E);

    if(isDefined(scripts\engine\utility::array_find(var_13, var_12))) {
      if(getsubstr(var_12, 0, 1) == "a") {
        self.var_747F[var_11].var_EB9C = "_small";
      } else {
        self.var_747F[var_11].var_EB9C = "_large";
      }

      self.var_747E[var_12] = ::scripts\engine\utility::array_add(self.var_747E[var_12], self.var_747F[var_11]);
      continue;
    }

    if(getsubstr(var_12, 0, 1) == "a") {
      self.var_747F[var_11].var_EB9C = "_small";
    } else {
      self.var_747F[var_11].var_EB9C = "_large";
    }

    self.var_747E[var_12] = [self.var_747F[var_11]];
  }
}

func_E403() {
  self endon("death");

  for(;;) {
    scripts\engine\utility::flag_waitopen(level.script + "_prime_tr");
  }
}

func_C5FE(var_0) {
  foreach(var_2 in self.var_747E[var_0]) {
    var_2 setanimknob(%vh_mil_air_un_retribution_ftl_open);
    playFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_00_panel_aggregate_a_startup" + var_2.var_101AD), var_2.var_7601, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_02_panel_cool_charge_a_startup" + var_2.var_EB9C), var_2.var_7601, "tag_origin");
  }

  var_4 = getanimlength(%vh_mil_air_un_retribution_ftl_open);
  wait(var_4);
}

func_C5FF(var_0) {
  foreach(var_2 in self.var_747E[var_0]) {
    var_2 setanimknob(%vh_mil_air_un_retribution_ftl_open);
    var_2 func_82B0(%vh_mil_air_un_retribution_ftl_open, 1.0);
  }
}

func_747B(var_0) {
  foreach(var_2 in self.var_747E[var_0]) {}
}

func_4269(var_0) {
  foreach(var_2 in self.var_747E[var_0]) {
    var_2 setanimknob(%vh_mil_air_un_retribution_ftl_open, 1, 0.2, -1);
    stopFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_00_panel_aggregate_a_startup" + var_2.var_101AD), var_2.var_7601, "tag_origin");
    stopFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_02_panel_cool_charge_a_startup" + var_2.var_EB9C), var_2.var_7601, "tag_origin");
  }

  var_4 = getanimlength(%vh_mil_air_un_retribution_ftl_open);
  wait(var_4);
}

func_747A(var_0) {
  foreach(var_2 in self.var_747E[var_0]) {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_00_panel_aggregate_a_startup" + var_2.var_101AD), var_2.var_7601, "tag_origin");
    stopFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_02_panel_cool_charge_a_startup" + var_2.var_EB9C), var_2.var_7601, "tag_origin");
  }
}

func_C5FC(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  thread func_C5FE("b_a");
  wait(var_0);
  thread func_C5FE("b_b");
  wait(var_0);
  thread func_C5FE("b_c");
  wait(var_0);
  thread func_C5FE("b_d");
  wait(var_0);
  thread func_C5FE("b_e");
  wait(var_0);
  thread func_C5FE("b_f");
  wait(var_0);
  thread func_C5FE("b_g");
  wait(var_0);
  thread func_C5FE("b_h");
  wait(var_0);
  thread func_C5FE("b_i");
  wait(var_0);
  thread func_C5FE("b_j");
  wait(var_0);
  thread func_C5FE("a_a");
  wait(var_0);
  thread func_C5FE("a_b");
  wait(var_0);
  thread func_C5FE("a_c");
  wait(var_0);
  func_C5FE("a_d");
}

func_C5FD() {
  thread func_C5FF("b_a");
  thread func_C5FF("b_b");
  thread func_C5FF("b_c");
  thread func_C5FF("b_d");
  thread func_C5FF("b_e");
  thread func_C5FF("b_f");
  thread func_C5FF("b_g");
  thread func_C5FF("b_h");
  thread func_C5FF("b_i");
  thread func_C5FF("b_j");
  thread func_C5FF("a_a");
  thread func_C5FF("a_b");
  thread func_C5FF("a_c");
  thread func_C5FF("a_d");
}

func_10C56() {
  var_0 = getarraykeys(self.var_747E);

  foreach(var_2 in var_0) {
    thread func_747B(var_2);
  }
}

func_4268(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  thread func_4269("a_d");
  wait(var_0);
  thread func_4269("a_c");
  wait(var_0);
  thread func_4269("a_b");
  wait(var_0);
  thread func_4269("a_a");
  wait(var_0);
  thread func_4269("b_j");
  wait(var_0);
  thread func_4269("b_i");
  wait(var_0);
  thread func_4269("b_h");
  wait(var_0);
  thread func_4269("b_g");
  wait(var_0);
  thread func_4269("b_f");
  wait(var_0);
  thread func_4269("b_e");
  wait(var_0);
  thread func_4269("b_d");
  wait(var_0);
  thread func_4269("b_c");
  wait(var_0);
  thread func_4269("b_b");
  wait(var_0);
  func_4269("b_a");
}

stop_func() {
  var_0 = getarraykeys(self.var_747E);

  foreach(var_2 in var_0) {
    thread func_747A(var_2);
  }
}

func_8E84() {
  while(!isDefined(self.var_747F)) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::array_call(self.var_747F, ::hide);
}

func_100DD() {
  while(!isDefined(self.var_747F)) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::array_call(self.var_747F, ::show);
}

func_5155() {
  while(!isDefined(self.var_747F)) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::array_call(self.var_747F, ::delete);
}