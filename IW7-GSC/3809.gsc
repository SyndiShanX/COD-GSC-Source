/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3809.gsc
***************************************/

#using_animtree("script_model");

func_47DA() {
  level.func_EC85["crane"]["shipcrib_crane_clamp_90_ccw_1"] = % shipcrib_crane_clamp_90_ccw_1;
  level.func_EC85["crane"]["shipcrib_crane_clamp_90_ccw_2"] = % shipcrib_crane_clamp_90_ccw_2;
  level.func_EC85["crane"]["shipcrib_crane_clamp_90_cw_1"] = % shipcrib_crane_clamp_90_cw_1;
  level.func_EC85["crane"]["shipcrib_crane_clamp_90_cw_2"] = % shipcrib_crane_clamp_90_cw_2;
  level.func_EC85["crane"]["shipcrib_crane_clamp_f_72"] = % shipcrib_crane_clamp_f_72;
  level.func_EC85["crane"]["shipcrib_crane_clamp_b_72"] = % shipcrib_crane_clamp_b_72;
  level.func_EC85["crane"]["shipcrib_crane_clamp_up"] = % shipcrib_crane_clamp_up;
  level.func_EC85["crane"]["shipcrib_crane_clamp_down"] = % shipcrib_crane_clamp_down;
}

func_E3D8(var_00) {
  level func_47DA();

  if(!isDefined(level.func_E35D)) {
    level.func_E35D = spawnStruct();
  }

  if(!isDefined(var_00)) {
    var_00 = "_ignore_last_sparam";
    var_01 = level.func_FD6E.func_E35D;
  } else
    var_01 = level.func_FD6E.func_E35D;

  var_02 = func_0EFB::func_7CC1("return_crane_a_airlockstart", "script_noteworthy", var_00);

  if(var_2.size != 1) {
    return;
  }
  level.func_E35D.func_A2E8["a"] = func_0EFB::func_798B("return_crane_a_top", "script_noteworthy", "arm_origin", var_00);
  level.func_E35D.func_A2E8["b"] = func_0EFB::func_798B("return_crane_b_top", "script_noteworthy", "arm_origin", var_00);
  level.func_E35D.func_A2E8["a"].func_10CC9 = level.func_E35D.func_A2E8["a"].origin;
  level.func_E35D.func_A2E8["b"].func_10CC9 = level.func_E35D.func_A2E8["b"].origin;
  level.func_E35D.func_A2E8["a"].func_3FFD = func_0EFB::func_798B("return_crane_a_top", "script_noteworthy", "clamp", var_00);
  level.func_E35D.func_A2E8["b"].func_3FFD = func_0EFB::func_798B("return_crane_b_top", "script_noteworthy", "clamp", var_00);
  level.func_E35D.func_A2E8["a"].func_3FFB = func_0EFB::func_798B("return_crane_a_top", "script_noteworthy", "clamp_origin", var_00);
  level.func_E35D.func_A2E8["b"].func_3FFB = func_0EFB::func_798B("return_crane_b_top", "script_noteworthy", "clamp_origin", var_00);
  level.func_E35D.func_A2E8["b"].func_3FFB.func_EACA = -72;
  level.func_E35D.func_A2E8["a"].func_3FFD glinton(#animtree);
  level.func_E35D.func_A2E8["b"].func_3FFD glinton(#animtree);
  level.func_E35D.func_A2E8["a"].func_1ACA = func_0EFB::func_7CBE("return_crane_a_airlockstart", "script_noteworthy", var_00).origin;
  level.func_E35D.func_A2E8["b"].func_1ACA = func_0EFB::func_7CBE("return_crane_b_airlockstart", "script_noteworthy", var_00).origin;
  level.func_E35D.func_A2E8["a"].func_1AE0 = func_0EFB::func_7CBE("return_crane_a_airlockend", "script_noteworthy", var_00).origin;
  level.func_E35D.func_A2E8["b"].func_1AE0 = func_0EFB::func_7CBE("return_crane_b_airlockend", "script_noteworthy", var_00).origin;
  level.func_E35D.func_A2E8["a"].func_62EB = func_0EFB::func_7CBE("return_crane_a_end", "script_noteworthy", var_00).origin;
  level.func_E35D.func_A2E8["b"].func_62EB = func_0EFB::func_7CBE("return_crane_b_end", "script_noteworthy", var_00).origin;
  level.func_E35D.func_A2E8["a"].func_11A05 = func_0EFB::func_7CBE("return_crane_a_topmove", "script_noteworthy", var_00).origin;
  level.func_E35D.func_A2E8["b"].func_11A05 = func_0EFB::func_7CBE("return_crane_b_topmove", "script_noteworthy", var_00).origin;
  level.func_E35D.func_A2E8["a"].func_3FFB linkto(level.func_E35D.func_A2E8["a"]);
  level.func_E35D.func_A2E8["b"].func_3FFB linkto(level.func_E35D.func_A2E8["b"]);
  level.func_E35D.func_A2E8["a"].func_3FFD linkto(level.func_E35D.func_A2E8["a"]);
  level.func_E35D.func_A2E8["b"].func_3FFD linkto(level.func_E35D.func_A2E8["b"]);
  level.func_E35D.func_A2EA = func_0EFB::func_798B("jackal_return_door_top", "script_noteworthy", "origin", var_00);
  var_03 = getEntArray(level.func_E35D.func_A2EA.target, "targetname");
  scripts\engine\utility::array_call(var_03, ::linkto, level.func_E35D.func_A2EA);
  level.func_E35D.func_A2E9 = func_0EFB::func_798B("jackal_return_door_mid", "script_noteworthy", "origin", var_00);
  var_03 = getEntArray(level.func_E35D.func_A2E9.target, "targetname");
  scripts\engine\utility::array_call(var_03, ::linkto, level.func_E35D.func_A2E9);
  level.func_E35D.func_1D05 = level.func_E35D.func_A2E8["b"].targetname;
}

func_F2CE() {
  level.player _meth_82C0("shipcrib_crane_in_jackal_canopy_closed_airlock_has_no_air", 0.5);
  thread func_25C6();
}

func_F2CD() {
  level.player _meth_82C0("shipcrib_crane_in_jackal_canopy_closed_airlock_has_air", 12.0);
}

func_F2CF() {
  level.player _meth_82C0("shipcrib_crane_in_jackal_canopy_closed_hangar_has_air", 7.0);
  thread func_25C7();
}

func_F2D0() {
  level.player clearclienttriggeraudiozone(0.2);
}

func_F2D1() {
  level.player clearclienttriggeraudiozone(5.0);
}

func_25C6() {
  level.func_A2E5 = spawn("script_origin", (-1404, 1623, -285));
  level.func_A2E6 = spawn("script_origin", (-817, 904, -302));
  wait 0.8;
  level.func_A2E5 playLoopSound("scn_jackal_crane_alarm_high");
  level.func_A2E6 playLoopSound("scn_jackal_crane_alarm_low");
  level.player playSound("jackal_airlock_pressurize_lr");
}

func_25C7() {
  wait 0.8;
  level.func_A2E5 scripts\sp\utility::func_10460(0.2, 1);
  level.func_A2E6 scripts\sp\utility::func_10460(0.2, 1);
}

func_6C94() {
  self endon("death");

  for(;;) {
    wait 1000;
  }
}

func_E3DA(var_00) {
  level.player endon("death");

  switch (var_00) {
    case "top":
      level.func_E35D.func_A2E8["a"].origin = level.func_E35D.func_A2E8["a"].func_10CC9;
      level.func_E35D.func_A2E8["b"].origin = level.func_E35D.func_A2E8["b"].func_10CC9;
      level.func_E35D.func_A2E8["a"].func_3FFB unlink();
      level.func_E35D.func_A2E8["a"].func_3FFB.angles = level.func_E35D.func_A2E8["a"].func_3FFB.angles + (0, 180, 0);
      level.func_E35D.func_A2E8["a"].func_3FFB linkto(level.func_E35D.func_A2E8["a"]);
      level.func_E35D.func_A2E8["b"].func_3FFB unlink();
      level.func_E35D.func_A2E8["b"].func_3FFB.angles = level.func_E35D.func_A2E8["b"].func_3FFB.angles + (0, 180, 0);
      level.func_E35D.func_A2E8["b"].func_3FFB linkto(level.func_E35D.func_A2E8["b"]);
      break;
    case "airlock":
      level.func_E35D.func_A2E8["a"].func_3FFD setanimknob( % shipcrib_crane_clamp_extended_rotate_cc, 10, 0, 0);
      level.func_E35D.func_A2E8["b"].func_3FFD setanimknob( % shipcrib_crane_clamp_extended_rotate_c, 10, 0, 0);
      level.func_E35D.func_A2E8["a"].func_3FFB unlink();
      level.func_E35D.func_A2E8["a"].func_3FFB.angles = level.func_E35D.func_A2E8["a"].func_3FFB.angles + (0, -90, 0);
      level.func_E35D.func_A2E8["a"].func_3FFB linkto(level.func_E35D.func_A2E8["a"]);
      level.func_E35D.func_A2E8["b"].func_3FFB unlink();
      level.func_E35D.func_A2E8["b"].func_3FFB.origin = level.func_E35D.func_A2E8["b"].func_3FFB.origin + anglesToForward(level.func_E35D.func_A2E8["b"].func_3FFB.angles) * level.func_E35D.func_A2E8["b"].func_3FFB.func_EACA;
      level.func_E35D.func_A2E8["b"].func_3FFB.angles = level.func_E35D.func_A2E8["b"].func_3FFB.angles + (0, 90, 0);
      level.func_E35D.func_A2E8["b"].func_3FFB linkto(level.func_E35D.func_A2E8["b"]);
      level.func_E35D.func_A2E8["a"].origin = level.func_E35D.func_A2E8["a"].func_1ACA;
      level.func_E35D.func_A2E8["b"].origin = level.func_E35D.func_A2E8["b"].func_1ACA;
      scripts\engine\utility::waitframe();
      break;
  }
}

func_E3D9(var_00, var_01, var_02, var_03, var_04) {
  var_01 = level.func_E35D.func_A2E8[var_01];
  var_1.func_A056 = var_00;
  var_00 vehicle_teleport(var_1.func_3FFD gettagorigin("j_cranebase"), var_1.func_3FFD gettagangles("j_cranebase"));

  if(isDefined(var_02)) {
    if(!isDefined(var_03)) {
      var_03 = "crib_craneride";
    }

    var_00 func_0BDC::func_A07D();
    var_00 thread func_0BDC::func_F43D("player");
    var_00 func_0BDC::func_F358(var_03);
    func_0BDC::func_10CD2(var_00);
  }

  var_05 = length(var_1.func_3FFB.origin - var_1.func_3FFD gettagorigin("j_cranebase"));

  if(isDefined(var_04)) {
    var_00 linkto(var_1.func_3FFD, "j_cranebase", (0, 0, -39.3664), (0, 180, 0));
  } else {
    var_00 linkto(var_1.func_3FFD, "j_cranebase", (0, 0, -39.3664), (0, 0, 0));
  }
}

func_E3CB() {
  var_00 = 1.3;
  func_0BDC::func_A38E(0.0, undefined, undefined, var_00);
  wait(var_00);
}

func_E3D1(var_00, var_01, var_02, var_03, var_04) {
  level endon("stop_jackal_return_do");
  var_05 = 7;
  var_06 = 4.25;
  var_07 = 5;
  var_08 = 8;
  var_09 = 1;
  var_10 = undefined;

  switch (var_01) {
    case "land":
      var_10 = 1;
    case "full":
      var_11 = var_05 - var_09;
      level.func_E35D.func_A2E8[var_00] moveto(level.func_E35D.func_A2E8[var_00].func_11A05, var_11);

      if(var_00 == "a") {
        level.func_E35D.func_A2E8[var_00] thread func_E3CC(var_11, 1);
        level.func_E35D thread func_E3CE(var_00, var_11, 1, "shipcrib_crane_clamp_90_cw_1");
      } else {
        level.func_E35D.func_A2E8["b"].func_3FFD give_attacker_kill_rewards(level.func_EC85["crane"]["shipcrib_crane_clamp_f_72"], 10, 0, 1 / var_11 * 1.15);
        level.func_E35D thread func_E3CE(var_00, var_11, 1, "shipcrib_crane_clamp_90_ccw_1");
      }

      level.func_E35D.func_A2EA thread func_E3D4(var_05);
      level.func_E35D.func_A2EA moveto(level.func_E35D.func_A2EA.origin + anglestoright(level.func_E35D.func_A2EA.angles) * 816, var_05);
      wait(var_05 - 0.25);

      if(var_00 == "a") {
        level.func_E35D.func_A2E8[var_00] thread func_E3CC(var_04);
      }

      level.func_E35D.func_A2E8[var_00] moveto(level.func_E35D.func_A2E8[var_00].func_1ACA, var_04);
      level.func_E35D.func_A2EA thread func_E3D2(var_06, var_00);
      level waittill("return_door_closed");
    case "pressurize":
      if(isDefined(var_10)) {
        break;
      }
      func_E3CB();
      level scripts\sp\endmission::func_CCA8("sc_assault_maptrans_jackal_return", 15);
    case "airlock":
      level.func_E35D.func_A2E8[var_00] thread func_E3CC(var_02, 1);
      level.func_E35D.func_A2E8[var_00] moveto(level.func_E35D.func_A2E8[var_00].func_1AE0, var_02);
      level.func_E35D thread func_E3CE(var_00, var_02, undefined);
      wait(var_02 + var_09);
      level notify("light_jackal_middoor");
      level.func_E35D.func_A2E9 thread func_E3D4(var_07);
      level.func_E35D.func_A2E9 moveto(level.func_E35D.func_A2E9.origin + anglestoright(level.func_E35D.func_A2E9.angles) * 816, var_07);
      wait(var_07);

      if(var_00 == "a") {
        level.func_E35D.func_A2E8[var_00] thread func_E3CC(var_03);
      } else {
        level.func_E35D.func_A2E8[var_00] thread func_E3CC(var_03, 1);
      }

      level.func_E35D.func_A2E8[var_00] moveto(level.func_E35D.func_A2E8[var_00].func_62EB, var_03);
      wait(var_03);

      if(var_00 == "a") {
        level scripts\engine\utility::flag_set_delayed("jackal_elevator_finished", 1);
        level scripts\sp\utility::func_C12D("jackal_elevator_finished", 1);
        level.func_E35D.func_A2E8[var_00].func_A056 scripts\sp\utility::func_C12D("player_dismount", 1);

        if(level.script == "shipcrib_rogue" || level.script == "shipcrib_prisoner") {
          if(isDefined(scripts\engine\utility::getstruct("jackal_return_a_exit", "targetname"))) {
            level.player scripts\engine\utility::delaycall(4.5, ::unlink);
            level scripts\engine\utility::delaythread(4.5, scripts\sp\utility::func_11633, scripts\engine\utility::getstruct("jackal_return_a_exit", "targetname"));
          }
        }
      }

      level.func_E35D.func_A2E9 thread func_E3D2(var_08);
      wait 0.5;
      break;
    case "returned":
      var_12 = 90;

      if(var_00 == "a") {
        var_12 = -90;
      }

      level.func_E35D.func_A2E8[var_00].func_3FFB unlink();
      level.func_E35D.func_A2E8[var_00].func_3FFB rotateby((0, var_12, 0), 0.05);
      scripts\engine\utility::waitframe();
      scripts\engine\utility::waitframe();

      if(var_00 == "b") {
        level.func_E35D.func_A2E8[var_00].func_3FFB.origin = level.func_E35D.func_A2E8[var_00].func_3FFB.origin + anglesToForward(level.func_E35D.func_A2E8["b"].func_3FFB.angles) * level.func_E35D.func_A2E8[var_00].func_3FFB.func_EACA;
      }

      level.func_E35D.func_A2E8[var_00].func_3FFB linkto(level.func_E35D.func_A2E8[var_00]);
      level.func_E35D.func_A2E8[var_00] moveto(level.func_E35D.func_A2E8[var_00].func_62EB, 0.05);
      break;
  }
}

func_E3D2(var_00, var_01) {
  self endon("death");

  if(isDefined(self.func_9B94)) {
    return;
  }
  self.func_9B94 = 1;

  if(isDefined(var_01)) {
    while(level.func_E35D.func_A2E8[var_01].origin[2] + 20 > self.origin[2]) {
      scripts\engine\utility::waitframe();
    }
  }

  thread func_E3D4(var_00);
  self moveto(self.origin + anglestoright(self.angles) * -816, var_00);
  wait(var_00);
  self.func_9B94 = undefined;
  level notify("return_door_closed");
}

func_E3CE(var_00, var_01, var_02, var_03) {
  if(isDefined(var_03)) {
    level.func_E35D.func_A2E8[var_00].func_3FFD give_attacker_kill_rewards(level.func_EC85["crane"][var_03], 10, 0, 1 / var_01);
  } else if(var_00 == "a") {
    var_01 = getanimlength( % shipcrib_crane_clamp_extended_rotate_cc) / 0.45;
    level.func_E35D.func_A2E8[var_00].func_3FFD playSound("scn_ship_titan_jackal_lower_plr_start_lr");
    level.func_E35D.func_A2E8[var_00].func_3FFD playLoopSound("scn_ship_titan_jackal_lower_plr_lp_lr");
    level.func_E35D.func_A2E8[var_00].func_3FFD setanimknob( % shipcrib_crane_clamp_extended_rotate_cc, 10, 0, 0.45);
    level.func_E35D.func_A2E8[var_00].func_3FFD scripts\engine\utility::delaycall(var_01, ::stoploopsound);
    level.func_E35D.func_A2E8[var_00].func_3FFD scripts\engine\utility::delaycall(var_01, ::playsound, "scn_ship_titan_jackal_lower_plr_stop_lr");
  } else
    level.func_E35D.func_A2E8[var_00].func_3FFD setanimknob( % shipcrib_crane_clamp_extended_rotate_c, 10, 0, 0.45);
}

func_E3CD(var_00, var_01, var_02, var_03) {
  if(!isDefined(level.func_E35D.func_A2E8[var_00].func_3FFB.func_8BA3)) {
    level.func_E35D.func_A2E8[var_00].func_3FFB.func_8BA3 = 1;
  } else {
    level.func_E35D.func_A2E8[var_00].func_3FFB.func_8BA3 = level.func_E35D.func_A2E8[var_00].func_3FFB.func_8BA3 + 1;
  }

  var_03 = 1;

  if(isDefined(var_03)) {
    var_03 = 1;
  }

  var_04 = 90 * var_03;

  if(var_00 == "a") {
    var_04 = -90 * var_03;
  }

  var_04 = var_04 * level.func_E35D.func_A2E8[var_00].func_3FFB.func_8BA3;
  var_05 = undefined;

  if(var_00 == "b") {
    var_05 = var_01;
    var_01 = var_01 * 0.7;
  }

  if(!isDefined(var_02)) {
    var_06 = 1;
  } else {
    var_06 = -1;
  }

  var_07 = var_01 / 0.05;
  var_08 = var_04 / var_07;
  var_09 = undefined;

  if(var_00 == "b") {
    var_09 = level.func_E35D.func_A2E8[var_00].func_3FFB.func_EACA / var_07;
  }

  level.func_E35D.func_A2E8[var_00].func_3FFB _meth_826F((0, var_04, 0), var_01);

  for(var_10 = 0; var_10 < var_07; var_10++) {
    if(var_00 == "b") {
      level.func_E35D.func_A2E8[var_00].func_3FFB unlink();
      level.func_E35D.func_A2E8[var_00].func_3FFB.angles = level.func_E35D.func_A2E8[var_00].func_3FFB.angles + (0, var_08, 0);
      level.func_E35D.func_A2E8[var_00].func_3FFB.origin = level.func_E35D.func_A2E8[var_00].func_3FFB.origin + anglesToForward(level.func_E35D.func_A2E8["b"].angles) * var_09 * var_06;
      level.func_E35D.func_A2E8[var_00].func_3FFB linkto(level.func_E35D.func_A2E8[var_00]);
    }

    scripts\engine\utility::waitframe();
  }

  if(var_00 == "b") {
    wait(var_05 - var_01);
  }

  level.func_E35D.func_A2E8[var_00] thread func_E3D0();
}

func_E3D6() {}

func_E3D7() {
  self.moving = undefined;
}

func_E3D4(var_00) {
  self endon("middoors_thinking");

  if(isDefined(self.moving)) {
    return;
  }
  self.moving = 1;
  thread func_E3D6();
  self playSound("scn_ship_titan_blast_door_start_lr");
  self playLoopSound("scn_ship_titan_blast_door_lp_lr");
  scripts\engine\utility::delaycall(var_00, ::stoploopsound);
  scripts\engine\utility::delaycall(var_00, ::playsound, "scn_ship_titan_blast_door_stop_lr");
  scripts\engine\utility::delaythread(var_00, ::func_E3D7);
}

func_E3CF(var_00) {
  if(!isDefined(var_00)) {
    self playSound("scn_ship_titan_jackal_lower_plr_start2_lr");
  }

  _screenshake(level.player.origin, 0.35, 0.35, 0.35, 0.3, 0, 0, 1024, 9, 9, 9);
}

func_E3D0(var_00) {
  if(!isDefined(var_00)) {
    self playSound("scn_ship_titan_jackal_lower_plr_stop2_lr");
  }

  _screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.35, 0, 0, 1024, 9, 9, 9);
}

func_E3CC(var_00, var_01) {
  thread func_E3CF(var_01);

  if(!isDefined(var_01)) {
    self playLoopSound("scn_ship_titan_jackal_lower_plr_lp2_lr");
    scripts\engine\utility::delaycall(var_00, ::stoploopsound);
  }

  scripts\engine\utility::delaythread(var_00, ::func_E3D0, var_01);
  _screenshake(level.player.origin, 0.07, 0.07, 0.07, var_00, 0, 0, 1024, 9, 9, 9);
}

func_7C10(var_00) {
  return level.func_E35D.func_A2E8[var_00];
}