/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_cart.gsc
**********************************************/

func_00F9() {
  level.var_2DA8 = 0;
  level.var_2DA9 = 0;
  level.var_305F = 0;
  common_scripts\utility::func_3C87("flag_ww_part_01_picked_up");
  common_scripts\utility::func_3C87("flag_ww_part_02_picked_up");
  common_scripts\utility::func_3C87("flag_ww_part_01_placed");
  common_scripts\utility::func_3C87("flag_ww_part_02_placed");
  common_scripts\utility::func_3C87("flag_ww_forged");
  common_scripts\utility::func_3C87("flag_workbench_found");
  common_scripts\utility::func_3C87("flag_cart_reached_end");
  common_scripts\utility::func_3C87("flag_cart_req_1_met");
  common_scripts\utility::func_3C87("flag_cart_req_2_met");
  common_scripts\utility::func_3C87("flag_cart_req_3_met");
  lib_0557::func_7846("4 cart", ::func_2020, ["3 shard"], &"ZOMBIE_NEST_HINT_QUEST_CART", "ZOMBIE_NEST_HINT_QUEST_CART");
  lib_0557::func_781E("4 cart", "press button", ::func_7865, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_START_ASSEMBLY");
  lib_0557::func_781E("4 cart", "head to rnd", ::func_7859, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_ESCORT_CLAW");
  lib_0557::func_781E("4 cart", "pickup ww frame", ::func_7863, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_PICKUP_WW_PART_1");
  lib_0557::func_781E("4 cart", "rewind from rnd", ::func_7869, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_ESCORT_CLAW");
  lib_0557::func_781E("4 cart", "head to med", ::func_7858, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_ESCORT_CLAW");
  lib_0557::func_781E("4 cart", "pickup ww core", ::func_7864, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_PICKUP_WW_PART_2");
  lib_0557::func_781E("4 cart", "rewind from med", ::func_7868, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_ESCORT_CLAW");
  lib_0557::func_781E("4 cart", "head to com", ::func_7857, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_ESCORT_CLAW");
  lib_0557::func_781E("4 cart", "assemble ww", ::func_784A, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_ENERGIZE_WW");
  lib_0557::func_7848("4 cart");
  func_52DE();
}

func_7865() {
  level.var_3571.var_692A = 1;
  level.var_3571.var_5787 = 0;
  var_00 = common_scripts\utility::func_46B5("cart_align_node", "targetname");
  level.var_3571.var_0BBE = var_00;
  thread func_9033();
  thread lib_0378::func_8D74("aud_cart_lights_off");
  level thread func_A0EF(level.var_3573, 0);
  common_scripts\utility::func_3C8F("flag_bunker_lights_off");
  lib_0378::func_8D74("aud_bunker_lights", "off");
  wait(4);
  var_01 = level.var_64C7;
  var_02 = undefined;
  if(1) {
    if(isDefined(var_01.var_2590)) {
      var_02 = lib_0557::func_782F(undefined, var_01.var_2590);
    } else {
      var_02 = lib_0557::func_782F(undefined, var_01.var_1DD3);
    }

    lib_0557::func_781D("4 cart", var_02);
  }

  var_01.var_92A1 common_scripts\utility::func_9DA3();
  var_01.var_92A1 sethintstring(&"ZOMBIE_NEST_MOVE_SHROUD");
  var_01.var_1DD3 showpart("TAG_LIGHT_GREEN");
  var_01.var_1DD3 hidepart("TAG_LIGHT_RED");
  foreach(var_04 in var_01.var_5D20) {
    var_04 setscriptablepartstate("light", "green");
  }

  var_01.var_92A1 waittill("trigger", var_06);
  var_01 thread func_64A0();
  if(1) {
    lib_0557::func_7847("4 cart", var_02);
  }

  var_01.var_92A1 common_scripts\utility::func_9D9F();
  lib_0557::func_782D("4 cart", "press button");
}

func_7859() {
  if(1) {
    var_00 = lib_0557::func_782F(undefined, level.var_3571);
    level.var_3571.var_68C1 = var_00;
    lib_0557::func_781D("4 cart", var_00, 0);
  }

  thread func_2E7B();
  func_2023("rnd");
  lib_0557::func_782D("4 cart", "head to rnd");
}

func_7863() {
  if(1) {
    var_00 = getent("ww_part_01_model", "targetname");
    var_01 = lib_0557::func_782F(undefined, var_00);
    lib_0557::func_781D("4 cart", var_01);
  }

  level.var_3E3B.var_4D91 = lib_0559::func_7BE3(level.var_3E3B.var_6FC5, "tesla_barrel");
  var_02 = level.var_3E3B maps\mp\mp_zombie_nest_ee_util::func_8BEC();
  level.var_3E3B.var_4D91.var_2F74 = 1;
  common_scripts\utility::func_3C8F("flag_ww_part_01_picked_up");
  var_02 func_2EBE(1);
  lib_0557::func_782D("4 cart", "pickup ww frame");
}

func_7869() {
  lib_0378::func_8D74("aud_claw_move_start", level.var_3571);
  level.var_3571 func_202D("rnd_5");
  lib_0557::func_782D("4 cart", "rewind from rnd");
}

func_7858() {
  func_2023("med");
  lib_0557::func_782D("4 cart", "head to med");
}

func_7864() {
  if(1) {
    var_00 = getent("ww_part_02_model", "targetname");
    var_01 = lib_0557::func_782F(undefined, var_00);
    lib_0557::func_781D("4 cart", var_01);
  }

  level.var_5981.var_4D91 = lib_0559::func_7BE3(level.var_5981.var_6FC5, "tesla_core");
  var_02 = level.var_5981 maps\mp\mp_zombie_nest_ee_util::func_8BEC();
  level.var_5981.var_4D91.var_2F74 = 1;
  common_scripts\utility::func_3C8F("flag_ww_part_02_picked_up");
  var_02 func_2EBE(2);
  lib_0557::func_782D("4 cart", "pickup ww core");
}

func_7868() {
  lib_0378::func_8D74("aud_claw_move_start", level.var_3571);
  level.var_3571 func_202D("med_5");
  lib_0557::func_782D("4 cart", "rewind from med");
}

func_7857() {
  level.var_3571 func_202D("com_1");
  lib_0378::func_8D74("aud_claw_move_stop", level.var_3571);
  common_scripts\utility::func_3C8F("flag_cart_reached_end");
  level thread func_A0EF(level.var_3573, 1);
  common_scripts\utility::func_3C7B("flag_bunker_lights_off");
  level.var_6F18 = 0;
  lib_0378::func_8D74("aud_bunker_lights", "on");
  if(1) {
    lib_0557::func_7847("4 cart", level.var_3571.var_68C1);
  }

  lib_0557::func_782D("4 cart", "head to com");
}

func_784A() {
  if(0) {
    var_00 = lib_0557::func_782F(undefined, level.var_AA67.var_48F2);
    lib_0557::func_781D("4 cart", var_00);
  }

  common_scripts\utility::func_3C9F("flag_ww_forged");
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("geistcraft_device_powered");
  foreach(var_02 in level.var_744A) {
    var_02 thread func_2EB1();
  }

  lib_0557::func_782D("4 cart", "assemble ww");
}

func_2020() {
  foreach(var_01 in level.var_744A) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("escortclaw");
  }
}

func_52DE() {
  maps\mp\mp_zombie_nest_ee_util::func_8A53();
  maps\mp\mp_zombie_nest_ee_workbench::func_536B();
  thread func_2EAD();
  level.var_3571 = getent("ee_shard", "targetname");
  level.var_3571.var_9B8C = [];
  level.var_3571.var_9B8C["rnd_1"] = % s2_zom_shroud_rd_track_1;
  level.var_3571.var_9B8C["rnd_2"] = % s2_zom_shroud_rd_track_2;
  level.var_3571.var_9B8C["rnd_3"] = % s2_zom_shroud_rd_track_3;
  level.var_3571.var_9B8C["rnd_4"] = % s2_zom_shroud_rd_track_4;
  level.var_3571.var_9B8C["rnd_5"] = % s2_zom_shroud_rd_track_5;
  level.var_3571.var_9B8C["med_1"] = % s2_zom_shroud_med_track_1;
  level.var_3571.var_9B8C["med_2"] = % s2_zom_shroud_med_track_2;
  level.var_3571.var_9B8C["med_3"] = % s2_zom_shroud_med_track_3;
  level.var_3571.var_9B8C["med_4"] = % s2_zom_shroud_med_track_4;
  level.var_3571.var_9B8C["med_5"] = % s2_zom_shroud_med_track_5;
  level.var_3571.var_9B8C["com_1"] = % s2_zom_shroud_control_track_1;
  level.var_3571.var_9B8C["com_2"] = % s2_zom_shroud_workbench_activate;
  level.var_3573 = [];
  var_00 = func_8A2B("light_zm_objective", "light_zm_puzzle", "cycle1b", "cycle1a", "puzzlelight");
  var_00 = func_8A2B("light_zm_objective", "light_zm_puzzle_test", "cycle1b", "cycle1a", "puzzlelight");
  var_01 = func_8A2B("beam_zm_objective", "light_zm_lgtbeam", "lightbeam", "lightbeamoff", "glow");
  level.var_3574 = func_8A2B("light_zm_objective_med", "light_zm_puzzl_med", "flicker", "cycle1a", "puzzlelight");
  level.var_3575 = func_8A2B("light_zm_objective_rnd", "light_zm_puzzle_test", "flicker", "lightoff", "puzzlelight");
  level.var_3573 = common_scripts\utility::func_0F73(var_00, var_01);
  level.var_3573 = common_scripts\utility::func_0F73(level.var_3573, level.var_3575);
  level.var_3573 = common_scripts\utility::func_0F73(level.var_3573, level.var_3574);
  foreach(var_03 in level.var_3573) {
    var_03.var_760E = [];
    func_A12E(var_03, "facility", 1, 0);
  }

  var_05 = spawnStruct();
  var_05.var_1DD3 = getent("move_cart_button_model", "targetname");
  var_05.var_2590 = getent("move_cart_button_console", "targetname");
  var_05.var_92A1 = getent("move_shroud_trig", "targetname");
  var_05.var_92A1 sethintstring(&"ZOMBIE_NEST_OBJECTIVE_OFFLINE");
  var_05.var_1DD3 showpart("TAG_LIGHT_RED");
  var_05.var_1DD3 hidepart("TAG_LIGHT_GREEN");
  var_05.var_5D20 = function_021F("move_cart_button_light", "targetname");
  foreach(var_07 in var_05.var_5D20) {
    var_07 setscriptablepartstate("light", "red");
  }

  level.var_64C7 = var_05;
}

func_64A0() {
  var_00 = % zmb_objective_button_02_push;
  var_01 = % zmb_objective_button_02_reverse;
  var_02 = getanimlength(var_00);
  var_03 = getanimlength(var_01);
  self.var_1DD3 scriptmodelplayanim("zmb_objective_button_02_push");
  self.var_1DD3 lib_0378::func_8D74("aud_start_claw_button_press");
  wait(var_02);
  self.var_1DD3 showpart("TAG_LIGHT_RED");
  self.var_1DD3 hidepart("TAG_LIGHT_GREEN");
  foreach(var_05 in self.var_5D20) {
    var_05 setscriptablepartstate("light", "red");
  }

  wait(0.5);
  self.var_1DD3 scriptmodelplayanim("zmb_objective_button_02_reverse");
  wait(var_03);
}

func_2023(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "rnd";
  }

  level.var_3571.var_7E93 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_geistkraft_radius_256"), level.var_3571, "TAG_FX");
  triggerfx(level.var_3571.var_7E93);
  level.var_3571.var_2DA8 = 1;
  level.var_3571 thread func_201F(param_00);
  if(param_00 == "rnd") {
    lib_0378::func_8D74("aud_claw_move_start", level.var_3571);
  }

  level.var_3571 func_202D(param_00 + "_1");
  lib_0378::func_8D74("aud_claw_move_stop", level.var_3571);
  common_scripts\utility::func_3C9F("flag_cart_req_1_met");
  func_6AA2();
  lib_0378::func_8D74("aud_claw_move_start", level.var_3571);
  level.var_3571 func_202D(param_00 + "_2");
  lib_0378::func_8D74("aud_claw_move_stop", level.var_3571);
  common_scripts\utility::func_3C9F("flag_cart_req_2_met");
  lib_0378::func_8D74("aud_claw_move_start", level.var_3571);
  level.var_3571 func_202D(param_00 + "_3");
  lib_0378::func_8D74("aud_claw_move_stop", level.var_3571);
  common_scripts\utility::func_3C9F("flag_cart_req_3_met");
  func_6A9F();
  lib_0378::func_8D74("aud_claw_move_start", level.var_3571);
  level.var_3571 func_202D(param_00 + "_4");
  lib_0378::func_8D74("aud_claw_move_stop", level.var_3571);
  thread func_08B9(param_00);
  if(param_00 == "rnd") {
    level waittill(param_00 + "_show_ww_part");
    level.var_3E3B.var_6FC2 method_805B();
  }

  level waittill(param_00 + "_create_ww_part");
  if(param_00 == "rnd") {
    level thread func_A0EF(level.var_3575, 1, 0.04, 0.8);
    return;
  }

  if(param_00 == "med") {
    level thread func_A0EF(level.var_3574, 1, 0.05, 0.6);
  }
}

func_201F(param_00) {
  common_scripts\utility::func_3C7B("flag_cart_req_1_met");
  common_scripts\utility::func_3C7B("flag_cart_req_2_met");
  common_scripts\utility::func_3C7B("flag_cart_req_3_met");
  level.var_3571 thread func_91C5(5, "flag_cart_req_1_met");
  common_scripts\utility::func_3C9F("flag_cart_req_1_met");
  level.var_3571 thread func_91C5(5, "flag_cart_req_2_met");
  common_scripts\utility::func_3C9F("flag_cart_req_2_met");
  level.var_3571 thread func_91C5(5, "flag_cart_req_3_met");
}

func_6AA2() {
  if(!common_scripts\utility::func_562E(level.var_305F)) {
    thread func_2E84();
  }
}

func_6A9F() {
  level.var_3571.var_2959 = 0;
  level.var_3571.var_2DA8 = 0;
  level.var_3571.var_7E93 delete();
}

func_91C5(param_00, param_01) {
  maps\mp\mp_zombie_nest_special_event_creator::func_170B(param_00, 250, undefined, "zmb_cart_zombie_killed", undefined, "tag_fx");
  common_scripts\utility::func_3C8F(param_01);
}

func_202D(param_00) {
  switch (param_00) {
    case "med_5":
    case "rnd_5":
      break;

    case "med_4":
    case "rnd_4":
      lib_0378::func_8D74("aud_claw_connection_forge");
      break;

    case "med_3":
    case "med_2":
    case "rnd_3":
    case "rnd_2":
      playFXOnTag(level.var_0611["zmb_gk_claw_full"], self, "TAG_FX");
      playFXOnTag(level.var_0611["zmb_gk_claw_battery_full_1"], self, "flap1_shroud");
      playFXOnTag(level.var_0611["zmb_gk_claw_battery_full_2"], self, "flap2_shroud");
      playFXOnTag(level.var_0611["zmb_gk_claw_battery_full_3"], self, "flap3_shroud");
      break;

    case "med_1":
    case "rnd_1":
      break;
  }

  var_01 = self.var_9B8C[param_00];
  var_02 = getanimlength(var_01);
  var_03 = getanimname(var_01);
  self method_8495(var_03, self.var_0BBE.var_0116, self.var_0BBE.var_001D);
  wait(var_02);
}

func_43E8() {
  return "flag_ww_part_02_picked_up";
}

func_43E9() {
  return "flag_ww_part_01_picked_up";
}

func_43E7() {
  return "flag_ww_forged";
}

func_08B9(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "rnd":
      var_01 = ::maps\mp\mp_zombie_nest_ee_util::func_08B6;
      break;

    case "med":
      var_01 = ::maps\mp\mp_zombie_nest_ee_util::func_08B0;
      break;

    case "com":
      var_01 = ::maps\mp\mp_zombie_nest_ee_util::func_08A8;
      break;

    default:
      break;
  }

  if(isDefined(var_01)) {
    [[var_01]]();
  }
}

func_2EBE(param_00) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(param_00)) {
    return;
  }

  if(param_00 == 1) {
    thread lib_0367::func_8E3C("workbenchpart3");
    return;
  }

  if(param_00 == 2) {
    thread lib_0367::func_8E3C("forgepart");
  }
}

func_2EAD() {
  level endon("flag_ww_forged");
  var_00 = getent("ww_creation_station_dialogue", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(!isPlayer(var_01)) {
      wait(0.5);
      continue;
    }

    common_scripts\utility::func_3C8F("flag_workbench_found");
    if(!isDefined(var_01.var_3077) && isPlayer(var_01)) {
      var_02 = var_01 lib_0367::func_8E3D("workbench");
      if(isDefined(var_02)) {
        var_01.var_3077 = 1;
      }
    }
  }
}

func_2E7B() {
  level endon("flag_ww_part_01_picked_up");
  var_00 = lib_0557::func_7838("4 cart", "head to rnd");
  var_01 = getent("cart_dialog_trig", "targetname");
  var_01.var_0CA5 = 0;
  var_02 = level.var_3571;
  if(isDefined(var_02)) {
    var_01.var_5ED1 = var_02.var_0116;
  } else {
    var_01.var_5ED1 = var_01.var_0116;
  }

  while(!common_scripts\utility::func_3C77(var_00)) {
    var_01 waittill("trigger", var_03);
    if(!isPlayer(var_03)) {
      continue;
    }

    if(isDefined(var_02)) {
      var_01.var_5ED1 = var_02.var_0116;
    } else {
      var_01.var_5ED1 = var_01.var_0116;
    }

    var_04 = var_01 func_2025(var_03);
    if(var_04 && !isDefined(var_03.var_3060) && level.var_2DA8) {
      var_05 = var_03 lib_0367::func_8E3D("clawmove");
      if(isDefined(var_05)) {
        var_03.var_3060 = 1;
      }

      continue;
    }

    wait(0.5);
  }
}

func_2E84() {
  foreach(var_01 in level.var_744A) {
    if(lib_0547::func_577E(var_01)) {
      continue;
    }

    if(distance(var_01.var_0116, level.var_3571.var_0116) < 500) {
      var_01 thread lib_0367::func_8E3C("clawmove2");
    }
  }

  level.var_305F = 1;
}

func_2EB1() {
  self endon("disconnect");
  for(;;) {
    self waittill("weapon_fired", var_00);
    if(var_00 == "teslagun_zm") {
      if(!isDefined(self.var_3066)) {
        wait(1);
        var_01 = lib_0367::func_8E3D("teslafired");
        if(isDefined(var_01)) {
          self.var_3066 = 1;
          break;
        }
      }
    }

    wait(0.5);
  }
}

func_9033() {
  wait(6);
  var_00 = "zmb_uberschnalle_light";
  var_01 = level.var_3571 gettagorigin("TAG_FX");
  maps\mp\mp_zombie_nest_ee_util::func_9066(level.var_3571, "TAG_FX", var_01, var_00, "flag_cart_reached_end");
}

func_2025(param_00) {
  var_01 = self.var_5ED1 - param_00 getEye();
  var_02 = vectornormalize((var_01[0], var_01[1], 0));
  var_03 = anglesToForward(param_00.var_001D);
  var_04 = vectornormalize((var_03[0], var_03[1], 0));
  var_05 = vectordot(var_02, var_04);
  var_05 = clamp(var_05, -1, 1);
  var_06 = acos(var_05);
  var_07 = var_06 < 60;
  return var_07;
}

func_A0EF(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = 0.05;
  }

  if(!isDefined(param_03)) {
    param_03 = 0.1;
  }

  foreach(var_05 in param_00) {
    wait(randomfloatrange(param_02, param_03));
    func_A12E(var_05, "facility", param_01);
  }
}

func_8A2B(param_00, param_01, param_02, param_03, param_04) {
  var_05 = function_021F(param_00, "targetname");
  foreach(var_07 in var_05) {
    var_07.var_760A = param_03;
    var_07.var_760B = param_02;
    var_07.var_760D = param_04;
    var_07.var_8300 = param_01;
  }

  return var_05;
}

func_5D7B(param_00, param_01) {
  var_02 = param_00.var_760A;
  if(param_01) {
    var_02 = param_00.var_760B;
  }

  param_00 setscriptablepartstate(param_00.var_760D, var_02, 0);
}

func_A12E(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 1;
  }

  if(param_02 == common_scripts\utility::func_0F79(param_00.var_760E, param_01)) {
    return;
  }

  if(param_02) {
    param_00.var_760E = common_scripts\utility::func_0F6F(param_00.var_760E, param_01);
    if(param_00.var_760E.size == 1 && param_03) {
      func_5D7B(param_00, 1);
      return;
    }

    return;
  }

  param_00.var_760E = common_scripts\utility::func_0F93(param_00.var_760E, param_01);
  if(param_00.var_760E.size == 0 && param_03) {
    func_5D7B(param_00, 0);
  }
}