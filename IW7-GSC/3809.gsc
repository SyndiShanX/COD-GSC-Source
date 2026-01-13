/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3809.gsc
***************************************/

#using_animtree("script_model");

func_47DA() {
  level.var_EC85["crane"]["shipcrib_crane_clamp_90_ccw_1"] = % shipcrib_crane_clamp_90_ccw_1;
  level.var_EC85["crane"]["shipcrib_crane_clamp_90_ccw_2"] = % shipcrib_crane_clamp_90_ccw_2;
  level.var_EC85["crane"]["shipcrib_crane_clamp_90_cw_1"] = % shipcrib_crane_clamp_90_cw_1;
  level.var_EC85["crane"]["shipcrib_crane_clamp_90_cw_2"] = % shipcrib_crane_clamp_90_cw_2;
  level.var_EC85["crane"]["shipcrib_crane_clamp_f_72"] = % shipcrib_crane_clamp_f_72;
  level.var_EC85["crane"]["shipcrib_crane_clamp_b_72"] = % shipcrib_crane_clamp_b_72;
  level.var_EC85["crane"]["shipcrib_crane_clamp_up"] = % shipcrib_crane_clamp_up;
  level.var_EC85["crane"]["shipcrib_crane_clamp_down"] = % shipcrib_crane_clamp_down;
}

func_E3D8(var_0) {
  level func_47DA();

  if(!isDefined(level.var_E35D)) {
    level.var_E35D = spawnStruct();
  }

  if(!isDefined(var_0)) {
    var_0 = "_ignore_last_sparam";
    var_1 = level.var_FD6E.var_E35D;
  } else
    var_1 = level.var_FD6E.var_E35D;

  var_2 = func_0EFB::func_7CC1("return_crane_a_airlockstart", "script_noteworthy", var_0);

  if(var_2.size != 1) {
    return;
  }
  level.var_E35D.var_A2E8["a"] = func_0EFB::func_798B("return_crane_a_top", "script_noteworthy", "arm_origin", var_0);
  level.var_E35D.var_A2E8["b"] = func_0EFB::func_798B("return_crane_b_top", "script_noteworthy", "arm_origin", var_0);
  level.var_E35D.var_A2E8["a"].var_10CC9 = level.var_E35D.var_A2E8["a"].origin;
  level.var_E35D.var_A2E8["b"].var_10CC9 = level.var_E35D.var_A2E8["b"].origin;
  level.var_E35D.var_A2E8["a"].var_3FFD = func_0EFB::func_798B("return_crane_a_top", "script_noteworthy", "clamp", var_0);
  level.var_E35D.var_A2E8["b"].var_3FFD = func_0EFB::func_798B("return_crane_b_top", "script_noteworthy", "clamp", var_0);
  level.var_E35D.var_A2E8["a"].var_3FFB = func_0EFB::func_798B("return_crane_a_top", "script_noteworthy", "clamp_origin", var_0);
  level.var_E35D.var_A2E8["b"].var_3FFB = func_0EFB::func_798B("return_crane_b_top", "script_noteworthy", "clamp_origin", var_0);
  level.var_E35D.var_A2E8["b"].var_3FFB.var_EACA = -72;
  level.var_E35D.var_A2E8["a"].var_3FFD glinton(#animtree);
  level.var_E35D.var_A2E8["b"].var_3FFD glinton(#animtree);
  level.var_E35D.var_A2E8["a"].var_1ACA = func_0EFB::func_7CBE("return_crane_a_airlockstart", "script_noteworthy", var_0).origin;
  level.var_E35D.var_A2E8["b"].var_1ACA = func_0EFB::func_7CBE("return_crane_b_airlockstart", "script_noteworthy", var_0).origin;
  level.var_E35D.var_A2E8["a"].var_1AE0 = func_0EFB::func_7CBE("return_crane_a_airlockend", "script_noteworthy", var_0).origin;
  level.var_E35D.var_A2E8["b"].var_1AE0 = func_0EFB::func_7CBE("return_crane_b_airlockend", "script_noteworthy", var_0).origin;
  level.var_E35D.var_A2E8["a"].var_62EB = func_0EFB::func_7CBE("return_crane_a_end", "script_noteworthy", var_0).origin;
  level.var_E35D.var_A2E8["b"].var_62EB = func_0EFB::func_7CBE("return_crane_b_end", "script_noteworthy", var_0).origin;
  level.var_E35D.var_A2E8["a"].var_11A05 = func_0EFB::func_7CBE("return_crane_a_topmove", "script_noteworthy", var_0).origin;
  level.var_E35D.var_A2E8["b"].var_11A05 = func_0EFB::func_7CBE("return_crane_b_topmove", "script_noteworthy", var_0).origin;
  level.var_E35D.var_A2E8["a"].var_3FFB linkto(level.var_E35D.var_A2E8["a"]);
  level.var_E35D.var_A2E8["b"].var_3FFB linkto(level.var_E35D.var_A2E8["b"]);
  level.var_E35D.var_A2E8["a"].var_3FFD linkto(level.var_E35D.var_A2E8["a"]);
  level.var_E35D.var_A2E8["b"].var_3FFD linkto(level.var_E35D.var_A2E8["b"]);
  level.var_E35D.var_A2EA = func_0EFB::func_798B("jackal_return_door_top", "script_noteworthy", "origin", var_0);
  var_3 = getEntArray(level.var_E35D.var_A2EA.target, "targetname");
  scripts\engine\utility::array_call(var_3, ::linkto, level.var_E35D.var_A2EA);
  level.var_E35D.var_A2E9 = func_0EFB::func_798B("jackal_return_door_mid", "script_noteworthy", "origin", var_0);
  var_3 = getEntArray(level.var_E35D.var_A2E9.target, "targetname");
  scripts\engine\utility::array_call(var_3, ::linkto, level.var_E35D.var_A2E9);
  level.var_E35D.var_1D05 = level.var_E35D.var_A2E8["b"].targetname;
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
  level.var_A2E5 = spawn("script_origin", (-1404, 1623, -285));
  level.var_A2E6 = spawn("script_origin", (-817, 904, -302));
  wait 0.8;
  level.var_A2E5 playLoopSound("scn_jackal_crane_alarm_high");
  level.var_A2E6 playLoopSound("scn_jackal_crane_alarm_low");
  level.player playSound("jackal_airlock_pressurize_lr");
}

func_25C7() {
  wait 0.8;
  level.var_A2E5 scripts\sp\utility::func_10460(0.2, 1);
  level.var_A2E6 scripts\sp\utility::func_10460(0.2, 1);
}

func_6C94() {
  self endon("death");

  for(;;) {
    wait 1000;
  }
}

func_E3DA(var_0) {
  level.player endon("death");

  switch (var_0) {
    case "top":
      level.var_E35D.var_A2E8["a"].origin = level.var_E35D.var_A2E8["a"].var_10CC9;
      level.var_E35D.var_A2E8["b"].origin = level.var_E35D.var_A2E8["b"].var_10CC9;
      level.var_E35D.var_A2E8["a"].var_3FFB unlink();
      level.var_E35D.var_A2E8["a"].var_3FFB.angles = level.var_E35D.var_A2E8["a"].var_3FFB.angles + (0, 180, 0);
      level.var_E35D.var_A2E8["a"].var_3FFB linkto(level.var_E35D.var_A2E8["a"]);
      level.var_E35D.var_A2E8["b"].var_3FFB unlink();
      level.var_E35D.var_A2E8["b"].var_3FFB.angles = level.var_E35D.var_A2E8["b"].var_3FFB.angles + (0, 180, 0);
      level.var_E35D.var_A2E8["b"].var_3FFB linkto(level.var_E35D.var_A2E8["b"]);
      break;
    case "airlock":
      level.var_E35D.var_A2E8["a"].var_3FFD setanimknob( % shipcrib_crane_clamp_extended_rotate_cc, 10, 0, 0);
      level.var_E35D.var_A2E8["b"].var_3FFD setanimknob( % shipcrib_crane_clamp_extended_rotate_c, 10, 0, 0);
      level.var_E35D.var_A2E8["a"].var_3FFB unlink();
      level.var_E35D.var_A2E8["a"].var_3FFB.angles = level.var_E35D.var_A2E8["a"].var_3FFB.angles + (0, -90, 0);
      level.var_E35D.var_A2E8["a"].var_3FFB linkto(level.var_E35D.var_A2E8["a"]);
      level.var_E35D.var_A2E8["b"].var_3FFB unlink();
      level.var_E35D.var_A2E8["b"].var_3FFB.origin = level.var_E35D.var_A2E8["b"].var_3FFB.origin + anglesToForward(level.var_E35D.var_A2E8["b"].var_3FFB.angles) * level.var_E35D.var_A2E8["b"].var_3FFB.var_EACA;
      level.var_E35D.var_A2E8["b"].var_3FFB.angles = level.var_E35D.var_A2E8["b"].var_3FFB.angles + (0, 90, 0);
      level.var_E35D.var_A2E8["b"].var_3FFB linkto(level.var_E35D.var_A2E8["b"]);
      level.var_E35D.var_A2E8["a"].origin = level.var_E35D.var_A2E8["a"].var_1ACA;
      level.var_E35D.var_A2E8["b"].origin = level.var_E35D.var_A2E8["b"].var_1ACA;
      scripts\engine\utility::waitframe();
      break;
  }
}

func_E3D9(var_0, var_1, var_2, var_3, var_4) {
  var_1 = level.var_E35D.var_A2E8[var_1];
  var_1.var_A056 = var_0;
  var_0 vehicle_teleport(var_1.var_3FFD gettagorigin("j_cranebase"), var_1.var_3FFD gettagangles("j_cranebase"));

  if(isDefined(var_2)) {
    if(!isDefined(var_3)) {
      var_3 = "crib_craneride";
    }

    var_0 func_0BDC::func_A07D();
    var_0 thread func_0BDC::func_F43D("player");
    var_0 func_0BDC::func_F358(var_3);
    func_0BDC::func_10CD2(var_0);
  }

  var_5 = length(var_1.var_3FFB.origin - var_1.var_3FFD gettagorigin("j_cranebase"));

  if(isDefined(var_4)) {
    var_0 linkto(var_1.var_3FFD, "j_cranebase", (0, 0, -39.3664), (0, 180, 0));
  } else {
    var_0 linkto(var_1.var_3FFD, "j_cranebase", (0, 0, -39.3664), (0, 0, 0));
  }
}

func_E3CB() {
  var_0 = 1.3;
  func_0BDC::func_A38E(0.0, undefined, undefined, var_0);
  wait(var_0);
}

func_E3D1(var_0, var_1, var_2, var_3, var_4) {
  level endon("stop_jackal_return_do");
  var_5 = 7;
  var_6 = 4.25;
  var_7 = 5;
  var_8 = 8;
  var_9 = 1;
  var_10 = undefined;

  switch (var_1) {
    case "land":
      var_10 = 1;
    case "full":
      var_11 = var_5 - var_9;
      level.var_E35D.var_A2E8[var_0] moveto(level.var_E35D.var_A2E8[var_0].var_11A05, var_11);

      if(var_0 == "a") {
        level.var_E35D.var_A2E8[var_0] thread func_E3CC(var_11, 1);
        level.var_E35D thread func_E3CE(var_0, var_11, 1, "shipcrib_crane_clamp_90_cw_1");
      } else {
        level.var_E35D.var_A2E8["b"].var_3FFD give_attacker_kill_rewards(level.var_EC85["crane"]["shipcrib_crane_clamp_f_72"], 10, 0, 1 / var_11 * 1.15);
        level.var_E35D thread func_E3CE(var_0, var_11, 1, "shipcrib_crane_clamp_90_ccw_1");
      }

      level.var_E35D.var_A2EA thread func_E3D4(var_5);
      level.var_E35D.var_A2EA moveto(level.var_E35D.var_A2EA.origin + anglestoright(level.var_E35D.var_A2EA.angles) * 816, var_5);
      wait(var_5 - 0.25);

      if(var_0 == "a") {
        level.var_E35D.var_A2E8[var_0] thread func_E3CC(var_4);
      }

      level.var_E35D.var_A2E8[var_0] moveto(level.var_E35D.var_A2E8[var_0].var_1ACA, var_4);
      level.var_E35D.var_A2EA thread func_E3D2(var_6, var_0);
      level waittill("return_door_closed");
    case "pressurize":
      if(isDefined(var_10)) {
        break;
      }
      func_E3CB();
      level scripts\sp\endmission::func_CCA8("sc_assault_maptrans_jackal_return", 15);
    case "airlock":
      level.var_E35D.var_A2E8[var_0] thread func_E3CC(var_2, 1);
      level.var_E35D.var_A2E8[var_0] moveto(level.var_E35D.var_A2E8[var_0].var_1AE0, var_2);
      level.var_E35D thread func_E3CE(var_0, var_2, undefined);
      wait(var_2 + var_9);
      level notify("light_jackal_middoor");
      level.var_E35D.var_A2E9 thread func_E3D4(var_7);
      level.var_E35D.var_A2E9 moveto(level.var_E35D.var_A2E9.origin + anglestoright(level.var_E35D.var_A2E9.angles) * 816, var_7);
      wait(var_7);

      if(var_0 == "a") {
        level.var_E35D.var_A2E8[var_0] thread func_E3CC(var_3);
      } else {
        level.var_E35D.var_A2E8[var_0] thread func_E3CC(var_3, 1);
      }

      level.var_E35D.var_A2E8[var_0] moveto(level.var_E35D.var_A2E8[var_0].var_62EB, var_3);
      wait(var_3);

      if(var_0 == "a") {
        level scripts\engine\utility::flag_set_delayed("jackal_elevator_finished", 1);
        level scripts\sp\utility::func_C12D("jackal_elevator_finished", 1);
        level.var_E35D.var_A2E8[var_0].var_A056 scripts\sp\utility::func_C12D("player_dismount", 1);

        if(level.script == "shipcrib_rogue" || level.script == "shipcrib_prisoner") {
          if(isDefined(scripts\engine\utility::getstruct("jackal_return_a_exit", "targetname"))) {
            level.player scripts\engine\utility::delaycall(4.5, ::unlink);
            level scripts\engine\utility::delaythread(4.5, scripts\sp\utility::func_11633, scripts\engine\utility::getstruct("jackal_return_a_exit", "targetname"));
          }
        }
      }

      level.var_E35D.var_A2E9 thread func_E3D2(var_8);
      wait 0.5;
      break;
    case "returned":
      var_12 = 90;

      if(var_0 == "a") {
        var_12 = -90;
      }

      level.var_E35D.var_A2E8[var_0].var_3FFB unlink();
      level.var_E35D.var_A2E8[var_0].var_3FFB rotateby((0, var_12, 0), 0.05);
      scripts\engine\utility::waitframe();
      scripts\engine\utility::waitframe();

      if(var_0 == "b") {
        level.var_E35D.var_A2E8[var_0].var_3FFB.origin = level.var_E35D.var_A2E8[var_0].var_3FFB.origin + anglesToForward(level.var_E35D.var_A2E8["b"].var_3FFB.angles) * level.var_E35D.var_A2E8[var_0].var_3FFB.var_EACA;
      }

      level.var_E35D.var_A2E8[var_0].var_3FFB linkto(level.var_E35D.var_A2E8[var_0]);
      level.var_E35D.var_A2E8[var_0] moveto(level.var_E35D.var_A2E8[var_0].var_62EB, 0.05);
      break;
  }
}

func_E3D2(var_0, var_1) {
  self endon("death");

  if(isDefined(self.var_9B94)) {
    return;
  }
  self.var_9B94 = 1;

  if(isDefined(var_1)) {
    while(level.var_E35D.var_A2E8[var_1].origin[2] + 20 > self.origin[2]) {
      scripts\engine\utility::waitframe();
    }
  }

  thread func_E3D4(var_0);
  self moveto(self.origin + anglestoright(self.angles) * -816, var_0);
  wait(var_0);
  self.var_9B94 = undefined;
  level notify("return_door_closed");
}

func_E3CE(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    level.var_E35D.var_A2E8[var_0].var_3FFD give_attacker_kill_rewards(level.var_EC85["crane"][var_3], 10, 0, 1 / var_1);
  } else if(var_0 == "a") {
    var_1 = getanimlength( % shipcrib_crane_clamp_extended_rotate_cc) / 0.45;
    level.var_E35D.var_A2E8[var_0].var_3FFD playSound("scn_ship_titan_jackal_lower_plr_start_lr");
    level.var_E35D.var_A2E8[var_0].var_3FFD playLoopSound("scn_ship_titan_jackal_lower_plr_lp_lr");
    level.var_E35D.var_A2E8[var_0].var_3FFD setanimknob( % shipcrib_crane_clamp_extended_rotate_cc, 10, 0, 0.45);
    level.var_E35D.var_A2E8[var_0].var_3FFD scripts\engine\utility::delaycall(var_1, ::stoploopsound);
    level.var_E35D.var_A2E8[var_0].var_3FFD scripts\engine\utility::delaycall(var_1, ::playsound, "scn_ship_titan_jackal_lower_plr_stop_lr");
  } else
    level.var_E35D.var_A2E8[var_0].var_3FFD setanimknob( % shipcrib_crane_clamp_extended_rotate_c, 10, 0, 0.45);
}

func_E3CD(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.var_E35D.var_A2E8[var_0].var_3FFB.var_8BA3)) {
    level.var_E35D.var_A2E8[var_0].var_3FFB.var_8BA3 = 1;
  } else {
    level.var_E35D.var_A2E8[var_0].var_3FFB.var_8BA3 = level.var_E35D.var_A2E8[var_0].var_3FFB.var_8BA3 + 1;
  }

  var_3 = 1;

  if(isDefined(var_3)) {
    var_3 = 1;
  }

  var_4 = 90 * var_3;

  if(var_0 == "a") {
    var_4 = -90 * var_3;
  }

  var_4 = var_4 * level.var_E35D.var_A2E8[var_0].var_3FFB.var_8BA3;
  var_5 = undefined;

  if(var_0 == "b") {
    var_5 = var_1;
    var_1 = var_1 * 0.7;
  }

  if(!isDefined(var_2)) {
    var_6 = 1;
  } else {
    var_6 = -1;
  }

  var_7 = var_1 / 0.05;
  var_8 = var_4 / var_7;
  var_9 = undefined;

  if(var_0 == "b") {
    var_9 = level.var_E35D.var_A2E8[var_0].var_3FFB.var_EACA / var_7;
  }

  level.var_E35D.var_A2E8[var_0].var_3FFB _meth_826F((0, var_4, 0), var_1);

  for(var_10 = 0; var_10 < var_7; var_10++) {
    if(var_0 == "b") {
      level.var_E35D.var_A2E8[var_0].var_3FFB unlink();
      level.var_E35D.var_A2E8[var_0].var_3FFB.angles = level.var_E35D.var_A2E8[var_0].var_3FFB.angles + (0, var_8, 0);
      level.var_E35D.var_A2E8[var_0].var_3FFB.origin = level.var_E35D.var_A2E8[var_0].var_3FFB.origin + anglesToForward(level.var_E35D.var_A2E8["b"].angles) * var_9 * var_6;
      level.var_E35D.var_A2E8[var_0].var_3FFB linkto(level.var_E35D.var_A2E8[var_0]);
    }

    scripts\engine\utility::waitframe();
  }

  if(var_0 == "b") {
    wait(var_5 - var_1);
  }

  level.var_E35D.var_A2E8[var_0] thread func_E3D0();
}

func_E3D6() {}

func_E3D7() {
  self.moving = undefined;
}

func_E3D4(var_0) {
  self endon("middoors_thinking");

  if(isDefined(self.moving)) {
    return;
  }
  self.moving = 1;
  thread func_E3D6();
  self playSound("scn_ship_titan_blast_door_start_lr");
  self playLoopSound("scn_ship_titan_blast_door_lp_lr");
  scripts\engine\utility::delaycall(var_0, ::stoploopsound);
  scripts\engine\utility::delaycall(var_0, ::playsound, "scn_ship_titan_blast_door_stop_lr");
  scripts\engine\utility::delaythread(var_0, ::func_E3D7);
}

func_E3CF(var_0) {
  if(!isDefined(var_0)) {
    self playSound("scn_ship_titan_jackal_lower_plr_start2_lr");
  }

  _screenshake(level.player.origin, 0.35, 0.35, 0.35, 0.3, 0, 0, 1024, 9, 9, 9);
}

func_E3D0(var_0) {
  if(!isDefined(var_0)) {
    self playSound("scn_ship_titan_jackal_lower_plr_stop2_lr");
  }

  _screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.35, 0, 0, 1024, 9, 9, 9);
}

func_E3CC(var_0, var_1) {
  thread func_E3CF(var_1);

  if(!isDefined(var_1)) {
    self playLoopSound("scn_ship_titan_jackal_lower_plr_lp2_lr");
    scripts\engine\utility::delaycall(var_0, ::stoploopsound);
  }

  scripts\engine\utility::delaythread(var_0, ::func_E3D0, var_1);
  _screenshake(level.player.origin, 0.07, 0.07, 0.07, var_0, 0, 0, 1024, 9, 9, 9);
}

func_7C10(var_0) {
  return level.var_E35D.var_A2E8[var_0];
}