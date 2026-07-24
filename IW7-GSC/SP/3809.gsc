/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3809.gsc
**************************************/

#using_animtree("script_model");

_id_47DA() {
  level._id_EC85["crane"]["shipcrib_crane_clamp_90_ccw_1"] = % shipcrib_crane_clamp_90_ccw_1;
  level._id_EC85["crane"]["shipcrib_crane_clamp_90_ccw_2"] = % shipcrib_crane_clamp_90_ccw_2;
  level._id_EC85["crane"]["shipcrib_crane_clamp_90_cw_1"] = % shipcrib_crane_clamp_90_cw_1;
  level._id_EC85["crane"]["shipcrib_crane_clamp_90_cw_2"] = % shipcrib_crane_clamp_90_cw_2;
  level._id_EC85["crane"]["shipcrib_crane_clamp_f_72"] = % shipcrib_crane_clamp_f_72;
  level._id_EC85["crane"]["shipcrib_crane_clamp_b_72"] = % shipcrib_crane_clamp_b_72;
  level._id_EC85["crane"]["shipcrib_crane_clamp_up"] = % shipcrib_crane_clamp_up;
  level._id_EC85["crane"]["shipcrib_crane_clamp_down"] = % shipcrib_crane_clamp_down;
}

_id_E3D8(var_0) {
  level _id_47DA();

  if(!isDefined(level._id_E35D))
    level._id_E35D = spawnStruct();

  if(!isDefined(var_0)) {
    var_0 = "_ignore_last_sparam";
    var_1 = level._id_FD6E._id_E35D;
  } else
    var_1 = level._id_FD6E._id_E35D;

  var_2 = _id_0EFB::_id_7CC1("return_crane_a_airlockstart", "script_noteworthy", var_0);

  if(var_2.size != 1) {
    return;
  }
  level._id_E35D._id_A2E8["a"] = _id_0EFB::_id_798B("return_crane_a_top", "script_noteworthy", "arm_origin", var_0);
  level._id_E35D._id_A2E8["b"] = _id_0EFB::_id_798B("return_crane_b_top", "script_noteworthy", "arm_origin", var_0);
  level._id_E35D._id_A2E8["a"]._id_10CC9 = level._id_E35D._id_A2E8["a"].origin;
  level._id_E35D._id_A2E8["b"]._id_10CC9 = level._id_E35D._id_A2E8["b"].origin;
  level._id_E35D._id_A2E8["a"]._id_3FFD = _id_0EFB::_id_798B("return_crane_a_top", "script_noteworthy", "clamp", var_0);
  level._id_E35D._id_A2E8["b"]._id_3FFD = _id_0EFB::_id_798B("return_crane_b_top", "script_noteworthy", "clamp", var_0);
  level._id_E35D._id_A2E8["a"]._id_3FFB = _id_0EFB::_id_798B("return_crane_a_top", "script_noteworthy", "clamp_origin", var_0);
  level._id_E35D._id_A2E8["b"]._id_3FFB = _id_0EFB::_id_798B("return_crane_b_top", "script_noteworthy", "clamp_origin", var_0);
  level._id_E35D._id_A2E8["b"]._id_3FFB._id_EACA = -72;
  level._id_E35D._id_A2E8["a"]._id_3FFD _meth_83D0(#animtree);
  level._id_E35D._id_A2E8["b"]._id_3FFD _meth_83D0(#animtree);
  level._id_E35D._id_A2E8["a"]._id_1ACA = _id_0EFB::_id_7CBE("return_crane_a_airlockstart", "script_noteworthy", var_0).origin;
  level._id_E35D._id_A2E8["b"]._id_1ACA = _id_0EFB::_id_7CBE("return_crane_b_airlockstart", "script_noteworthy", var_0).origin;
  level._id_E35D._id_A2E8["a"]._id_1AE0 = _id_0EFB::_id_7CBE("return_crane_a_airlockend", "script_noteworthy", var_0).origin;
  level._id_E35D._id_A2E8["b"]._id_1AE0 = _id_0EFB::_id_7CBE("return_crane_b_airlockend", "script_noteworthy", var_0).origin;
  level._id_E35D._id_A2E8["a"]._id_62EB = _id_0EFB::_id_7CBE("return_crane_a_end", "script_noteworthy", var_0).origin;
  level._id_E35D._id_A2E8["b"]._id_62EB = _id_0EFB::_id_7CBE("return_crane_b_end", "script_noteworthy", var_0).origin;
  level._id_E35D._id_A2E8["a"]._id_11A05 = _id_0EFB::_id_7CBE("return_crane_a_topmove", "script_noteworthy", var_0).origin;
  level._id_E35D._id_A2E8["b"]._id_11A05 = _id_0EFB::_id_7CBE("return_crane_b_topmove", "script_noteworthy", var_0).origin;
  level._id_E35D._id_A2E8["a"]._id_3FFB linkTo(level._id_E35D._id_A2E8["a"]);
  level._id_E35D._id_A2E8["b"]._id_3FFB linkTo(level._id_E35D._id_A2E8["b"]);
  level._id_E35D._id_A2E8["a"]._id_3FFD linkTo(level._id_E35D._id_A2E8["a"]);
  level._id_E35D._id_A2E8["b"]._id_3FFD linkTo(level._id_E35D._id_A2E8["b"]);
  level._id_E35D._id_A2EA = _id_0EFB::_id_798B("jackal_return_door_top", "script_noteworthy", "origin", var_0);
  var_3 = getEntArray(level._id_E35D._id_A2EA.target, "targetname");
  scripts\engine\utility::array_call(var_3, ::linkto, level._id_E35D._id_A2EA);
  level._id_E35D._id_A2E9 = _id_0EFB::_id_798B("jackal_return_door_mid", "script_noteworthy", "origin", var_0);
  var_3 = getEntArray(level._id_E35D._id_A2E9.target, "targetname");
  scripts\engine\utility::array_call(var_3, ::linkto, level._id_E35D._id_A2E9);
  level._id_E35D._id_1D05 = level._id_E35D._id_A2E8["b"].targetname;
}

_id_F2CE() {
  level.player _meth_82C0("shipcrib_crane_in_jackal_canopy_closed_airlock_has_no_air", 0.5);
  thread _id_25C6();
}

_id_F2CD() {
  level.player _meth_82C0("shipcrib_crane_in_jackal_canopy_closed_airlock_has_air", 12.0);
}

_id_F2CF() {
  level.player _meth_82C0("shipcrib_crane_in_jackal_canopy_closed_hangar_has_air", 7.0);
  thread _id_25C7();
}

_id_F2D0() {
  level.player clearclienttriggeraudiozone(0.2);
}

_id_F2D1() {
  level.player clearclienttriggeraudiozone(5.0);
}

_id_25C6() {
  level._id_A2E5 = spawn("script_origin", (-1404, 1623, -285));
  level._id_A2E6 = spawn("script_origin", (-817, 904, -302));
  wait 0.8;
  level._id_A2E5 playLoopSound("scn_jackal_crane_alarm_high");
  level._id_A2E6 playLoopSound("scn_jackal_crane_alarm_low");
  level.player playSound("jackal_airlock_pressurize_lr");
}

_id_25C7() {
  wait 0.8;
  level._id_A2E5 scripts\sp\utility::_id_10460(0.2, 1);
  level._id_A2E6 scripts\sp\utility::_id_10460(0.2, 1);
}

_id_6C94() {
  self endon("death");

  for(;;)
    wait 1000;
}

_id_E3DA(var_0) {
  level.player endon("death");

  switch (var_0) {
    case "top":
      level._id_E35D._id_A2E8["a"].origin = level._id_E35D._id_A2E8["a"]._id_10CC9;
      level._id_E35D._id_A2E8["b"].origin = level._id_E35D._id_A2E8["b"]._id_10CC9;
      level._id_E35D._id_A2E8["a"]._id_3FFB unlink();
      level._id_E35D._id_A2E8["a"]._id_3FFB.angles = level._id_E35D._id_A2E8["a"]._id_3FFB.angles + (0, 180, 0);
      level._id_E35D._id_A2E8["a"]._id_3FFB linkTo(level._id_E35D._id_A2E8["a"]);
      level._id_E35D._id_A2E8["b"]._id_3FFB unlink();
      level._id_E35D._id_A2E8["b"]._id_3FFB.angles = level._id_E35D._id_A2E8["b"]._id_3FFB.angles + (0, 180, 0);
      level._id_E35D._id_A2E8["b"]._id_3FFB linkTo(level._id_E35D._id_A2E8["b"]);
      break;
    case "airlock":
      level._id_E35D._id_A2E8["a"]._id_3FFD setanimknob(%shipcrib_crane_clamp_extended_rotate_cc, 10, 0, 0);
      level._id_E35D._id_A2E8["b"]._id_3FFD setanimknob(%shipcrib_crane_clamp_extended_rotate_c, 10, 0, 0);
      level._id_E35D._id_A2E8["a"]._id_3FFB unlink();
      level._id_E35D._id_A2E8["a"]._id_3FFB.angles = level._id_E35D._id_A2E8["a"]._id_3FFB.angles + (0, -90, 0);
      level._id_E35D._id_A2E8["a"]._id_3FFB linkTo(level._id_E35D._id_A2E8["a"]);
      level._id_E35D._id_A2E8["b"]._id_3FFB unlink();
      level._id_E35D._id_A2E8["b"]._id_3FFB.origin = level._id_E35D._id_A2E8["b"]._id_3FFB.origin + anglesToForward(level._id_E35D._id_A2E8["b"]._id_3FFB.angles) * level._id_E35D._id_A2E8["b"]._id_3FFB._id_EACA;
      level._id_E35D._id_A2E8["b"]._id_3FFB.angles = level._id_E35D._id_A2E8["b"]._id_3FFB.angles + (0, 90, 0);
      level._id_E35D._id_A2E8["b"]._id_3FFB linkTo(level._id_E35D._id_A2E8["b"]);
      level._id_E35D._id_A2E8["a"].origin = level._id_E35D._id_A2E8["a"]._id_1ACA;
      level._id_E35D._id_A2E8["b"].origin = level._id_E35D._id_A2E8["b"]._id_1ACA;
      scripts\engine\utility::waitframe();
      break;
  }
}

_id_E3D9(var_0, var_1, var_2, var_3, var_4) {
  var_1 = level._id_E35D._id_A2E8[var_1];
  var_1._id_A056 = var_0;
  var_0 vehicle_teleport(var_1._id_3FFD gettagorigin("j_cranebase"), var_1._id_3FFD gettagangles("j_cranebase"));

  if(isDefined(var_2)) {
    if(!isDefined(var_3))
      var_3 = "crib_craneride";

    var_0 _id_0BDC::_id_A07D();
    var_0 thread _id_0BDC::_id_F43D("player");
    var_0 _id_0BDC::_id_F358(var_3);
    _id_0BDC::_id_10CD2(var_0);
  }

  var_5 = length(var_1._id_3FFB.origin - var_1._id_3FFD gettagorigin("j_cranebase"));

  if(isDefined(var_4))
    var_0 linkTo(var_1._id_3FFD, "j_cranebase", (0, 0, -39.3664), (0, 180, 0));
  else
    var_0 linkTo(var_1._id_3FFD, "j_cranebase", (0, 0, -39.3664), (0, 0, 0));
}

_id_E3CB() {
  var_0 = 1.3;
  _id_0BDC::_id_A38E(0.0, undefined, undefined, var_0);
  wait(var_0);
}

_id_E3D1(var_0, var_1, var_2, var_3, var_4) {
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
      level._id_E35D._id_A2E8[var_0] moveTo(level._id_E35D._id_A2E8[var_0]._id_11A05, var_11);

      if(var_0 == "a") {
        level._id_E35D._id_A2E8[var_0] thread _id_E3CC(var_11, 1);
        level._id_E35D thread _id_E3CE(var_0, var_11, 1, "shipcrib_crane_clamp_90_cw_1");
      } else {
        level._id_E35D._id_A2E8["b"]._id_3FFD _meth_82A2(level._id_EC85["crane"]["shipcrib_crane_clamp_f_72"], 10, 0, 1 / var_11 * 1.15);
        level._id_E35D thread _id_E3CE(var_0, var_11, 1, "shipcrib_crane_clamp_90_ccw_1");
      }

      level._id_E35D._id_A2EA thread _id_E3D4(var_5);
      level._id_E35D._id_A2EA moveTo(level._id_E35D._id_A2EA.origin + anglestoright(level._id_E35D._id_A2EA.angles) * 816, var_5);
      wait(var_5 - 0.25);

      if(var_0 == "a")
        level._id_E35D._id_A2E8[var_0] thread _id_E3CC(var_4);

      level._id_E35D._id_A2E8[var_0] moveTo(level._id_E35D._id_A2E8[var_0]._id_1ACA, var_4);
      level._id_E35D._id_A2EA thread _id_E3D2(var_6, var_0);
      level waittill("return_door_closed");
    case "pressurize":
      if(isDefined(var_10)) {
        break;
      }

      _id_E3CB();
      level scripts\sp\endmission::_id_CCA8("sc_assault_maptrans_jackal_return", 15);
    case "airlock":
      level._id_E35D._id_A2E8[var_0] thread _id_E3CC(var_2, 1);
      level._id_E35D._id_A2E8[var_0] moveTo(level._id_E35D._id_A2E8[var_0]._id_1AE0, var_2);
      level._id_E35D thread _id_E3CE(var_0, var_2, undefined);
      wait(var_2 + var_9);
      level notify("light_jackal_middoor");
      level._id_E35D._id_A2E9 thread _id_E3D4(var_7);
      level._id_E35D._id_A2E9 moveTo(level._id_E35D._id_A2E9.origin + anglestoright(level._id_E35D._id_A2E9.angles) * 816, var_7);
      wait(var_7);

      if(var_0 == "a")
        level._id_E35D._id_A2E8[var_0] thread _id_E3CC(var_3);
      else
        level._id_E35D._id_A2E8[var_0] thread _id_E3CC(var_3, 1);

      level._id_E35D._id_A2E8[var_0] moveTo(level._id_E35D._id_A2E8[var_0]._id_62EB, var_3);
      wait(var_3);

      if(var_0 == "a") {
        level scripts\engine\utility::flag_set_delayed("jackal_elevator_finished", 1);
        level scripts\sp\utility::_id_C12D("jackal_elevator_finished", 1);
        level._id_E35D._id_A2E8[var_0]._id_A056 scripts\sp\utility::_id_C12D("player_dismount", 1);

        if(level.script == "shipcrib_rogue" || level.script == "shipcrib_prisoner") {
          if(isDefined(scripts\engine\utility::getStruct("jackal_return_a_exit", "targetname"))) {
            level.player scripts\engine\utility::delaycall(4.5, ::unlink);
            level scripts\engine\utility::delaythread(4.5, scripts\sp\utility::_id_11633, scripts\engine\utility::getStruct("jackal_return_a_exit", "targetname"));
          }
        }
      }

      level._id_E35D._id_A2E9 thread _id_E3D2(var_8);
      wait 0.5;
      break;
    case "returned":
      var_12 = 90;

      if(var_0 == "a")
        var_12 = -90;

      level._id_E35D._id_A2E8[var_0]._id_3FFB unlink();
      level._id_E35D._id_A2E8[var_0]._id_3FFB rotateby((0, var_12, 0), 0.05);
      scripts\engine\utility::waitframe();
      scripts\engine\utility::waitframe();

      if(var_0 == "b")
        level._id_E35D._id_A2E8[var_0]._id_3FFB.origin = level._id_E35D._id_A2E8[var_0]._id_3FFB.origin + anglesToForward(level._id_E35D._id_A2E8["b"]._id_3FFB.angles) * level._id_E35D._id_A2E8[var_0]._id_3FFB._id_EACA;

      level._id_E35D._id_A2E8[var_0]._id_3FFB linkTo(level._id_E35D._id_A2E8[var_0]);
      level._id_E35D._id_A2E8[var_0] moveTo(level._id_E35D._id_A2E8[var_0]._id_62EB, 0.05);
      break;
  }
}

_id_E3D2(var_0, var_1) {
  self endon("death");

  if(isDefined(self._id_9B94)) {
    return;
  }
  self._id_9B94 = 1;

  if(isDefined(var_1)) {
    while(level._id_E35D._id_A2E8[var_1].origin[2] + 20 > self.origin[2])
      scripts\engine\utility::waitframe();
  }

  thread _id_E3D4(var_0);
  self moveTo(self.origin + anglestoright(self.angles) * -816, var_0);
  wait(var_0);
  self._id_9B94 = undefined;
  level notify("return_door_closed");
}

_id_E3CE(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    level._id_E35D._id_A2E8[var_0]._id_3FFD _meth_82A2(level._id_EC85["crane"][var_3], 10, 0, 1 / var_1);
  else if(var_0 == "a") {
    var_1 = getanimlength(%shipcrib_crane_clamp_extended_rotate_cc) / 0.45;
    level._id_E35D._id_A2E8[var_0]._id_3FFD playSound("scn_ship_titan_jackal_lower_plr_start_lr");
    level._id_E35D._id_A2E8[var_0]._id_3FFD playLoopSound("scn_ship_titan_jackal_lower_plr_lp_lr");
    level._id_E35D._id_A2E8[var_0]._id_3FFD setanimknob(%shipcrib_crane_clamp_extended_rotate_cc, 10, 0, 0.45);
    level._id_E35D._id_A2E8[var_0]._id_3FFD scripts\engine\utility::delaycall(var_1, ::stoploopsound);
    level._id_E35D._id_A2E8[var_0]._id_3FFD scripts\engine\utility::delaycall(var_1, ::playsound, "scn_ship_titan_jackal_lower_plr_stop_lr");
  } else
    level._id_E35D._id_A2E8[var_0]._id_3FFD setanimknob(%shipcrib_crane_clamp_extended_rotate_c, 10, 0, 0.45);
}

_id_E3CD(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_E35D._id_A2E8[var_0]._id_3FFB._id_8BA3))
    level._id_E35D._id_A2E8[var_0]._id_3FFB._id_8BA3 = 1;
  else
    level._id_E35D._id_A2E8[var_0]._id_3FFB._id_8BA3 = level._id_E35D._id_A2E8[var_0]._id_3FFB._id_8BA3 + 1;

  var_3 = 1;

  if(isDefined(var_3))
    var_3 = 1;

  var_4 = 90 * var_3;

  if(var_0 == "a")
    var_4 = -90 * var_3;

  var_4 = var_4 * level._id_E35D._id_A2E8[var_0]._id_3FFB._id_8BA3;
  var_5 = undefined;

  if(var_0 == "b") {
    var_5 = var_1;
    var_1 = var_1 * 0.7;
  }

  if(!isDefined(var_2))
    var_6 = 1;
  else
    var_6 = -1;

  var_7 = var_1 / 0.05;
  var_8 = var_4 / var_7;
  var_9 = undefined;

  if(var_0 == "b")
    var_9 = level._id_E35D._id_A2E8[var_0]._id_3FFB._id_EACA / var_7;

  level._id_E35D._id_A2E8[var_0]._id_3FFB _meth_826F((0, var_4, 0), var_1);

  for(var_10 = 0; var_10 < var_7; var_10++) {
    if(var_0 == "b") {
      level._id_E35D._id_A2E8[var_0]._id_3FFB unlink();
      level._id_E35D._id_A2E8[var_0]._id_3FFB.angles = level._id_E35D._id_A2E8[var_0]._id_3FFB.angles + (0, var_8, 0);
      level._id_E35D._id_A2E8[var_0]._id_3FFB.origin = level._id_E35D._id_A2E8[var_0]._id_3FFB.origin + anglesToForward(level._id_E35D._id_A2E8["b"].angles) * var_9 * var_6;
      level._id_E35D._id_A2E8[var_0]._id_3FFB linkTo(level._id_E35D._id_A2E8[var_0]);
    }

    scripts\engine\utility::waitframe();
  }

  if(var_0 == "b")
    wait(var_5 - var_1);

  level._id_E35D._id_A2E8[var_0] thread _id_E3D0();
}

_id_E3D6() {}

_id_E3D7() {
  self.moving = undefined;
}

_id_E3D4(var_0) {
  self endon("middoors_thinking");

  if(isDefined(self.moving)) {
    return;
  }
  self.moving = 1;
  thread _id_E3D6();
  self playSound("scn_ship_titan_blast_door_start_lr");
  self playLoopSound("scn_ship_titan_blast_door_lp_lr");
  scripts\engine\utility::delaycall(var_0, ::stoploopsound);
  scripts\engine\utility::delaycall(var_0, ::playsound, "scn_ship_titan_blast_door_stop_lr");
  scripts\engine\utility::delaythread(var_0, ::_id_E3D7);
}

_id_E3CF(var_0) {
  if(!isDefined(var_0))
    self playSound("scn_ship_titan_jackal_lower_plr_start2_lr");

  screenshake(level.player.origin, 0.35, 0.35, 0.35, 0.3, 0, 0, 1024, 9, 9, 9);
}

_id_E3D0(var_0) {
  if(!isDefined(var_0))
    self playSound("scn_ship_titan_jackal_lower_plr_stop2_lr");

  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.35, 0, 0, 1024, 9, 9, 9);
}

_id_E3CC(var_0, var_1) {
  thread _id_E3CF(var_1);

  if(!isDefined(var_1)) {
    self playLoopSound("scn_ship_titan_jackal_lower_plr_lp2_lr");
    scripts\engine\utility::delaycall(var_0, ::stoploopsound);
  }

  scripts\engine\utility::delaythread(var_0, ::_id_E3D0, var_1);
  screenshake(level.player.origin, 0.07, 0.07, 0.07, var_0, 0, 0, 1024, 9, 9, 9);
}

_id_7C10(var_0) {
  return level._id_E35D._id_A2E8[var_0];
}