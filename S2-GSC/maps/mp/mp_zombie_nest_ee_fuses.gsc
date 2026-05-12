/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_fuses.gsc
***********************************************/

func_00F9() {
  common_scripts\utility::func_3C87("flag_fuse_entered_correct");
  common_scripts\utility::func_3C87("flag_player_inspected_right_hand");
  common_scripts\utility::func_3C87("flag_cycle_started_once");
  common_scripts\utility::func_3C87("flag_fuses_highlighted");
  common_scripts\utility::func_3C87("flag_map_highlighted");
  lib_0557::func_7846("5 Right Hand fuses", ::lib_0557::func_30D8, ["4 cart"], &"ZOMBIE_NEST_HINT_QUEST_FUSE", "ZOMBIE_NEST_HINT_QUEST_FUSE");
  lib_0557::func_781E("5 Right Hand fuses", "fuse matching start", ::func_785D, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_EXAMINE_RIGHT_HAND");
  lib_0557::func_781E("5 Right Hand fuses", "lift center rod", ::func_784D, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_FIRST_LIGHTNING_ROD");
  lib_0557::func_781E("5 Right Hand fuses", "lift outter rods", ::func_7860, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_TWO_LIGHTNING_RODS");
  lib_0557::func_781E("5 Right Hand fuses", "tower confirm hand", ::func_785C, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_INTERACT_RIGHT_HAND");
  lib_0557::func_7848("5 Right Hand fuses");
  func_52E4();
  if(0) {
    func_6BFF();
  }
}

func_784D() {
  level thread lib_0560::func_9009(1);
  thread func_2E9D();
  maps\mp\mp_zombie_nest_ee_tower_battle::func_170D();
}

func_7860() {
  maps\mp\mp_zombie_nest_ee_tower_battle::func_1715();
}

func_785C() {
  var_00 = getent("right_hand_of_god_trig", "targetname");
  var_00 sethintstring(&"ZOMBIE_NEST_ENABLE_RIGHT_HAND");
  var_01 = common_scripts\utility::func_46B5("tower_battle_sfx_top", "targetname");
  var_02 = getEntArray("inner_spire", "targetname");
  var_01 thread lib_0378::func_8D74("aud_tower_shockwave", var_02);
  wait(2.75);
  level thread maps\mp\gametypes\zombies::func_08B2(var_01.var_0116);
  var_03 = common_scripts\utility::func_40B0(var_01.var_0116, level.var_744A, undefined, undefined, 3000);
  foreach(var_05 in var_03) {
    var_05 thread func_9B68(var_01.var_0116);
  }

  var_01 thread func_9B69();
  thread func_9B72();
  func_7E91(1);
  level thread func_2E9A();
  func_A689();
  var_07 = getent("rhog_control", "targetname");
  if(isDefined(var_07)) {
    var_07 thread maps\mp\mp_zombie_nest_ee_util::func_4D76();
    var_07 thread maps\mp\mp_zombie_nest_ee_util::func_4D77("green");
  }

  thread maps\mp\mp_zombie_nest_ee_util::func_4D78(1);
  lib_0557::func_782D("5 Right Hand fuses", "tower confirm hand");
}

func_9B69(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = 0.45;
  }

  if(!isDefined(param_01)) {
    param_01 = 0.1;
  }

  playFX(common_scripts\utility::func_44F5("lightning_burst"), self.var_0116);
  level thread func_9B71();
  level thread common_scripts\_exploder::func_088E(213);
  wait(0.1);
  thread lib_0378::func_8D74("aud_tower_strike");
  level thread func_9DC1("tower_lightning_chain_A_1", param_00, param_01);
  level thread func_9DC1("tower_lightning_chain_B_1", param_00, param_01);
  level thread func_9DC1("tower_lightning_chain_C_1", param_00, param_01);
  level thread func_9DC1("tower_lightning_chain_F_1", param_00, param_01);
}

func_9B71() {
  var_00 = function_021F("lightning", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("light", "Lightning_Flash_1");
    wait(0.4);
    var_02 setscriptablepartstate("light", "Lightning_Flash_1");
  }
}

func_9B72() {
  var_00 = function_021F("tower_light", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "flickerfast");
    wait(5);
    var_02 setscriptablepartstate("lightpart", "on");
  }

  level thread common_scripts\_exploder::func_088E(254);
}

func_9B68(param_00) {
  wait(0.25);
  thread func_9B71();
  earthquake(0.5, 5, param_00, 3000, self);
  self shellshock("ear_ring_mp", 5, 0);
  self playrumbleonentity("artillery_rumble");
  level notify("zone1EarthquakeBegin");
  var_01 = randomfloatrange(1, 2);
  var_02 = randomfloatrange(1, 2);
  var_03 = randomfloatrange(1, 2);
  var_04 = randomfloatrange(4, 8);
  lib_0378::func_8D74("zone1Earthquake", "rumble1", var_01);
  wait(var_01);
  lib_0378::func_8D74("zone1Earthquake", "rumble2", var_02);
  wait(var_02);
  lib_0378::func_8D74("zone1Earthquake", "rumble3", var_03);
  wait(var_03);
  lib_0378::func_8D74("zone1Earthquake", "earthquake", var_04);
  if(!common_scripts\utility::func_3C77("flag_bunker_lights_off")) {
    thread maps\mp\mp_zombie_nest_01::func_3541(var_04);
  }

  level thread common_scripts\_exploder::func_088E(207);
  earthquake(0.3, var_04, param_00, 6000, self);
  function_01BC("tank_rumble", self.var_0116);
  wait(var_04);
  thread func_9B71();
  function_01BD();
  level notify("zone1EarthquakeEnd");
}

func_9DC1(param_00, param_01, param_02) {
  var_03 = maps\mp\mp_zombie_nest_ee_util::func_44C8(param_00, 1);
  for(var_04 = 0; var_04 < var_03.size - 4; var_04++) {
    thread func_7203("zmb_electricity_reg_beam_lrg", var_03[var_04], var_03[var_04 + 1], param_01);
    wait(param_02);
  }

  for(var_04 = var_03.size - 4; var_04 < var_03.size - 1; var_04++) {
    thread func_7203("zmb_electricity_reg_beam_med", var_03[var_04], var_03[var_04 + 1], param_01);
    wait(param_02);
  }

  if(param_00 == "tower_lightning_chain_F_1") {
    level thread func_9DBC("electricity_chain_A_1", 0.1);
  }
}

func_9DBC(param_00, param_01) {
  var_02 = maps\mp\mp_zombie_nest_ee_util::func_44C8(param_00, 1);
  for(var_03 = 0; var_03 < var_02.size - 1; var_03++) {
    thread func_7218(var_02[var_03], var_02[var_03 + 1], param_01);
    wait(param_01);
  }

  level thread common_scripts\_exploder::func_088E(214);
  var_04 = getent("right_hand_of_god_model", "targetname");
  playFXOnTag(level.var_0611["zmb_rhog_on"], var_04, "Tag_Origin");
  var_04 lib_0378::func_8D74("aud_right_hand_of_god_ready");
}

func_7203(param_00, param_01, param_02, param_03) {
  var_04 = spawn("script_model", param_01.var_0116);
  var_04 setModel("tag_origin");
  var_05 = spawn("script_model", param_02.var_0116);
  var_05 setModel("tag_origin");
  var_04.var_001D = param_01.var_001D;
  var_06 = anglesToForward(param_02.var_001D);
  var_07 = vectortoangles(var_06 * -1);
  var_05.var_001D = var_07;
  var_08 = launchbeam(param_00, var_04, "tag_origin", var_05, "tag_origin");
  thread func_16FD(var_04, lib_0547::func_9470(param_01.var_0165), param_03);
  thread func_16FD(var_05, lib_0547::func_9470(param_02.var_0165), param_03);
  var_09 = 30;
  for(var_0A = 0; var_0A < var_09 / 2; var_0A++) {
    wait(param_03 / var_09);
    var_08 method_805C();
    wait(param_03 / var_09);
    var_08 method_805B();
  }

  wait(param_03);
  var_08 delete();
  var_04 delete();
  var_05 delete();
}

func_7218(param_00, param_01, param_02) {
  var_03 = spawn("script_model", param_00.var_0116);
  var_03 setModel("tag_origin");
  var_04 = anglesToForward(param_00.var_001D);
  var_05 = anglestoup(param_00.var_001D);
  if(param_00.var_0165 == "wire") {
    playFX(level.var_0611["zmb_fuse_chain_wire"], var_03.var_0116, var_04, var_05);
  }

  if(param_00.var_0165 == "fusebox") {
    playFX(level.var_0611["zmb_fuse_chain_box"], var_03.var_0116, var_04, var_05);
  }

  var_03 moveto(param_01.var_0116, param_02);
  wait(param_02);
  var_03 delete();
}

func_16FD(param_00, param_01, param_02) {
  param_00 movez(param_01, param_02);
}

func_A689() {
  var_00 = getent("right_hand_of_god_trig", "targetname");
  var_00 notify("right hand ready");
  var_00 waittill("trigger", var_01);
  var_00 lib_0378::func_8D74("aud_activate_right_hand_of_god");
  var_01 maps\mp\_utility::func_2CED(2, ::lib_0367::func_8E3C, "righthandgodtouch");
  var_00 common_scripts\utility::func_9D9F();
  var_02 = getent("right_hand_of_god_model", "targetname");
  playFXOnTag(level.var_0611["zmb_rhog_init"], var_02, "Tag_Origin");
}

func_785D() {
  var_00 = getent("rhog_control", "targetname");
  if(isDefined(var_00)) {
    var_00 thread maps\mp\mp_zombie_nest_ee_util::func_4D77("red");
  }

  func_7E91(1);
  func_52E3();
  level thread func_5413();
  level thread func_3F26();
  if(1) {
    if(!1 || 1 && level.var_744A.size == 1) {
      level thread quest_step_match_fuses_helper();
    }
  }
}

quest_step_match_fuses_helper() {
  level endon(lib_0557::func_7838("5 Right Hand fuses", "fuse matching start"));
  if(!0) {
    var_00 = level.var_A980;
    var_01 = var_00 + 2;
    if(1) {
      wait(200);
    }

    if(1) {
      if(level.var_A980 <= var_01) {
        for(;;) {
          level waittill("zombie_wave_started");
          if(level.var_A980 > var_01) {
            break;
          }
        }
      }
    }

    level.fuse_objective_helper_tripped = 1;
  }
}

func_7E91(param_00) {
  if(1) {
    if(!isDefined(level.var_7E68)) {
      var_01 = getent("right_hand_of_god_model", "targetname");
      level.var_7E68 = lib_0557::func_782F(undefined, var_01);
    }

    if(param_00) {
      lib_0557::func_781D("5 Right Hand fuses", level.var_7E68);
      return;
    }

    lib_0557::func_7847("5 Right Hand fuses", level.var_7E68);
  }
}

func_3F2B(param_00) {
  if(0 || common_scripts\utility::func_562E(level.fuse_objective_helper_tripped)) {
    var_01 = [];
    foreach(var_03 in level.var_665B) {
      var_01[var_01.size] = var_03.var_5F58;
    }

    if(!isDefined(level.var_3F27)) {
      level.var_3F27 = lib_0557::func_782F(undefined, var_01);
    }

    if(param_00) {
      if(!common_scripts\utility::func_3C77("flag_fuses_highlighted")) {
        if(0) {
          foreach(var_06 in var_01) {
            foreach(var_08 in level.var_744A) {
              var_06 hudoutlineenableforclient(var_08, 0, 0);
            }
          }
        } else {
          lib_0557::func_781D("5 Right Hand fuses", level.var_3F27);
        }

        common_scripts\utility::func_3C8F("flag_fuses_highlighted");
        return;
      }

      return;
    }

    if(common_scripts\utility::func_3C77("flag_fuses_highlighted")) {
      if(0) {
        foreach(var_06 in var_01) {
          foreach(var_08 in level.var_744A) {
            var_06 hudoutlinedisableforclient(var_08);
          }
        }
      } else {
        lib_0557::func_7847("5 Right Hand fuses", level.var_3F27);
      }

      common_scripts\utility::func_3C7B("flag_fuses_highlighted");
      return;
    }
  }
}

func_4873(param_00) {
  if(1) {
    if(!isDefined(level.var_7D2C)) {
      var_01 = getent("com_map_frame", "targetname");
      var_02 = function_021F("fuses_com_map", "targetname");
      level.var_7D2C = lib_0557::func_782F(undefined, [level.var_22F5, var_02[0], var_01]);
    }

    if(common_scripts\utility::func_562E(param_00)) {
      if(!common_scripts\utility::func_3C77("flag_map_highlighted")) {
        lib_0557::func_781D("5 Right Hand fuses", level.var_7D2C);
        common_scripts\utility::func_3C8F("flag_map_highlighted");
        return;
      }

      return;
    }

    if(common_scripts\utility::func_3C77("flag_map_highlighted")) {
      lib_0557::func_7847("5 Right Hand fuses", level.var_7D2C);
      common_scripts\utility::func_3C7B("flag_map_highlighted");
      return;
    }
  }
}

func_4874() {
  var_00 = getent("fuse_quest_start_trigger", "targetname");
  if(!common_scripts\utility::func_562E(var_00.var_4DAE)) {
    var_00 sethintstring(&"ZOMBIE_NEST_TURN_FUSE_OBJECTIVE_ON");
    var_00.var_4DAE = 1;
  }

  var_00 common_scripts\utility::func_9DA3();
  var_00 waittill("trigger", var_01);
  thread func_2EB6(var_01);
  common_scripts\utility::func_3C8F("flag_cycle_started_once");
  var_00 common_scripts\utility::func_9D9F();
}

func_3F26() {
  func_8A1E();
  level endon("nest_ee_fuses_complete");
  level thread func_21C8();
  var_00 = 0;
  var_01 = 1;
  while(!var_00) {
    if(!var_01) {
      func_6B34();
    }

    func_8624();
    if(!var_01) {
      func_4874();
      func_4873(0);
      lib_0557::func_7822("5 Right Hand fuses", &"ZOMBIE_NEST_HINT_STEP_MATCH_FUSES");
      func_3F2B(1);
    } else {
      var_01 = 0;
    }

    func_9ED3();
    func_9ED6();
    var_02 = func_9E1F();
    var_00 = common_scripts\utility::func_562E(var_02);
  }

  foreach(var_04 in level.var_665B) {
    var_04.var_1F20 = 0;
  }
}

func_9ED6() {
  level.var_22F5 func_856A(level.var_24A2);
  var_00 = function_021F("fuses_com_map", "targetname");
  var_00[0] func_851D(level.var_24A2);
}

func_4303() {
  return lib_0557::func_7838("5 Right Hand fuses", "tower confirm hand", 1);
}

func_8A1E() {
  func_4874();
  func_4873(0);
  lib_0557::func_7822("5 Right Hand fuses", &"ZOMBIE_NEST_HINT_STEP_MATCH_FUSES");
  foreach(var_01 in level.var_665B) {
    var_02 = function_021F(var_01.var_01A2, "targetname");
    if(var_02.size > 0) {
      var_01.var_5F58 = var_02[0];
    }

    var_03 = common_scripts\utility::func_44BE(var_01.var_01A2, "targetname");
    foreach(var_05 in var_03) {
      if(!isDefined(var_05.var_8260)) {
        continue;
      }

      var_06 = var_05.var_8260;
      switch (var_06) {
        case "needle":
          var_01.var_6643 = var_05;
          break;

        case "needle_empty":
          var_01.var_6646 = var_05;
          break;

        case "needle_full":
          var_01.var_6647 = var_05;
          break;
      }
    }

    var_01 thread func_4AC4();
  }

  func_3F2B(1);
  foreach(var_01 in level.var_665B) {
    if(lib_0547::func_9470(var_01.var_0165) != 1) {
      var_01 thread func_2E9E();
    }
  }

  func_3875();
  func_8A58();
}

func_9E1F() {
  level endon("nest_ee_fuses_complete");
  level endon("flag_fuse_entered_correct");
  if(level.var_744A.size > 1) {
    var_00 = 65;
  } else {
    var_00 = 75;
  }

  foreach(var_02 in level.var_665B) {
    var_02 thread func_92D6(var_00);
  }

  for(var_04 = 0; var_04 < var_00; var_04++) {
    wait(1);
  }

  level notify("nest_ee_fuse_off");
  return 0;
}

func_92D6(param_00) {
  level endon("nest_ee_fuses_complete");
  if(!isDefined(self.var_6643) || !isDefined(self.var_6646) || !isDefined(self.var_6647)) {
    return;
  }

  self.var_6643 moveto(self.var_6647.var_0116, 0.1, 0, 0);
  wait(0.1);
  self.var_6643 moveto(self.var_6646.var_0116, param_00 - 0.1, 0, 0);
}

func_868D() {
  if(!isDefined(self.var_6643) || !isDefined(self.var_6647)) {
    return;
  }

  self.var_6643 moveto(self.var_6647.var_0116, 0.5, 0, 0);
}

func_868C() {
  if(!isDefined(self.var_6643) || !isDefined(self.var_6646)) {
    return;
  }

  self.var_6643 moveto(self.var_6646.var_0116, 0.5, 0, 0);
}

func_9ED3() {
  level.var_665B[0] thread func_868E("open", "blinking");
  level.var_665B[0] func_9ED4();
}

func_6B34() {
  common_scripts\utility::func_0FB2(level.var_665B, ::func_868C);
  lib_0557::func_7822("5 Right Hand fuses", &"ZOMBIE_NEST_HINT_STEP_RESET_FUSES");
  func_3F2B(0);
  func_4873(1);
  thread func_2EA4();
  foreach(var_01 in level.var_665B) {
    var_01.var_1F20 = 1;
  }
}

func_2EA4() {
  var_00 = common_scripts\utility::func_7A33(level.var_744A);
  var_00 thread lib_0367::func_8E3C("circuitmapfail");
}

func_2E9A() {
  wait(2);
  var_00 = getent("inner_spire", "targetname");
  if(isDefined(var_00)) {
    foreach(var_02 in level.var_744A) {
      if(distance2d(var_02.var_0116, var_00.var_0116) < 750) {
        var_02 thread lib_0367::func_8E3C("lightningrodscomplete");
      }
    }
  }

  wait(9);
  if(isDefined(var_00)) {
    foreach(var_02 in level.var_744A) {
      if(distance2d(var_02.var_0116, var_00.var_0116) < 750) {
        var_02 thread lib_0367::func_8E3C("lightningflow");
      }
    }
  }

  var_02 = maps\mp\mp_zombie_nest_ee_util::func_4649();
  var_02 thread lib_0367::func_8E3B("conv_righthandaltarfinish");
}

func_8624() {
  foreach(var_01 in level.var_665B) {
    var_01 thread func_868E("close", "off");
    var_01 func_9ECC();
  }

  level.var_22F5 func_856A(undefined, 1);
  var_03 = getent("fuses_com_map", "targetname");
  var_03 func_851D(undefined, 1);
}

func_868E(param_00, param_01) {
  if(!isDefined(self.var_5F58.var_2916)) {
    self.var_5F58.var_2916 = "off";
  }

  switch (param_00) {
    case "blue":
    case "green":
    case "red":
      self.var_5F58 func_864C(param_00);
      self.var_5F58 thread func_864A(param_00);
      break;

    case "open":
      if(!common_scripts\utility::func_562E(self.var_5F58.var_3297)) {
        self.var_5F58 func_864C(undefined);
        self.var_5F58 thread func_864A(undefined);
        self.var_5F58.var_3297 = 1;
        self.var_5F58 thread func_864B(param_00);
      }
      break;

    case "close":
      if(common_scripts\utility::func_562E(self.var_5F58.var_3297)) {
        self.var_5F58.var_3297 = 0;
        self.var_5F58 thread func_864B(param_00);
      }
      break;

    default:
      break;
  }

  lib_0547::func_A6F6();
  if(isDefined(param_01)) {
    self.var_5F58 thread func_864D(param_01);
  }
}

func_864D(param_00) {
  self setscriptablepartstate("power_light", param_00);
}

func_864A(param_00) {
  var_01 = [];
  var_01["off_to_red"] = % zmb_circuit_breaker_01_dial_red;
  var_01["red"] = % zmb_circuit_breaker_01_dial_blue_to_red;
  var_01["green"] = % zmb_circuit_breaker_01_dial_green;
  var_01["blue"] = % zmb_circuit_breaker_01_dial_blue;
  if(isDefined(param_00)) {
    if(self.var_2916 == "off" && param_00 == "red") {
      self setscriptablepartstate("dial", "off_to_red");
      wait(getanimlength(var_01["off_to_red"]));
    } else {
      self setscriptablepartstate("dial", "to_" + param_00);
      wait(getanimlength(var_01[param_00]));
    }

    self setscriptablepartstate("dial", "on_" + param_00);
    self.var_2916 = param_00;
    return;
  }

  self setscriptablepartstate("dial", "on_off");
  self.var_2916 = "off";
}

func_864B(param_00) {
  self notify("door_state_change");
  self endon("door_state_change");
  if(param_00 == "close") {
    lib_0378::func_8D74("fuse_color_switch_door_close");
    self setscriptablepartstate("door", "up");
    wait(getanimlength(%zmb_circuit_breaker_01_cover_up));
    self setscriptablepartstate("door", "up_idle");
    return;
  }

  if(param_00 == "open") {
    lib_0378::func_8D74("fuse_color_switch_door_open");
    self setscriptablepartstate("door", "down");
    wait(getanimlength(%zmb_circuit_breaker_01_cover_down));
    self setscriptablepartstate("door", "down_idle");
  }
}

func_864C(param_00) {
  self setscriptablepartstate("light_blue", "off");
  self setscriptablepartstate("light_green", "off");
  self setscriptablepartstate("light_red", "off");
  if(isDefined(param_00)) {
    self setscriptablepartstate("light_" + param_00, "on");
  }

  thread func_3D63();
}

func_3D63() {
  self setscriptablepartstate("graph", "off");
  wait(0.15);
  self setscriptablepartstate("graph", "on");
}

func_98A3() {
  wait(1.5);
  level.var_744A[0] setorigin((954.139, -3445.2, 1502.04));
  level.var_744A[0] setangles((0, -152.705, 0));
}

func_3F29() {
  foreach(var_01 in level.var_744A) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("righthandofgod");
    var_01 lib_0378::func_8D74("objective_complete", "righthandofgod");
  }
}

func_6BFF() {
  while(!isDefined(level.var_AC1D) && !isDefined(level.var_744A)) {
    wait 0.05;
  }

  foreach(var_01 in level.var_AC1D) {
    if(var_01.var_819A == "safe_haven_to_bridge") {
      var_01 notify("open", level.var_744A[0]);
    }
  }
}

func_5413() {
  var_00 = getent("right_hand_of_god_trig", "targetname");
  var_00.var_4D91 = lib_0559::func_7BE3(var_00, "rhog");
  var_00 endon("right hand ready");
  var_00 sethintstring(&"ZOMBIES_SWITCH_HINT_GENERIC_EXAMINE");
  var_00 waittill("trigger", var_01);
  var_00 sethintstring(&"ZOMBIES_EMPTY_STRING");
  if(common_scripts\utility::func_24A6()) {
    var_01 thread lib_0367::func_8E3C("righthandaltar");
  } else {
    var_01 thread lib_0367::func_8E3B("conv_righthandaltarclue");
  }

  common_scripts\utility::func_3C8F("flag_player_inspected_right_hand");
  if(!common_scripts\utility::func_3C77("flag_cycle_started_once")) {
    lib_0557::func_7822("5 Right Hand fuses", &"ZOMBIE_NEST_HINT_STEP_ROUTE_TO_TOWER");
    func_4873(1);
    func_7E91(0);
    thread func_3F28();
  }
}

func_3F28() {
  var_00 = getent("power_grid_hint_trig", "targetname");
  if(isDefined(var_00)) {
    for(;;) {
      var_00 waittill("trigger", var_01);
      if(isPlayer(var_01)) {
        break;
      }
    }
  }

  if(!common_scripts\utility::func_3C77("flag_cycle_started_once")) {
    lib_0557::func_7822("5 Right Hand fuses", &"ZOMBIE_NEST_HINT_STEP_RESET_FUSES");
  }
}

func_2E9E() {
  level endon("nest_ee_fuses_complete");
  foreach(var_01 in level.var_744A) {
    if(!isDefined(var_01.var_306C)) {
      var_01.var_306C = 0;
    }
  }

  for(;;) {
    foreach(var_01 in level.var_744A) {
      if(!var_01.var_306C) {
        if(distance(self.var_0116, var_01.var_0116) < 128) {
          var_04 = var_01 lib_0367::func_8E3D("circuitclue");
          if(isDefined(var_04)) {
            var_01.var_306C = 1;
          }
        }
      }
    }

    wait(1);
  }
}

func_2E9D() {
  wait(13);
  var_00 = undefined;
  foreach(var_02 in level.var_744A) {
    if(var_02 maps\mp\mp_zombie_nest_ee_util::func_740A()) {
      var_00 = var_02;
      break;
    }
  }

  if(isDefined(var_00)) {
    var_00 lib_0367::func_8E3B("conv_lightningtower");
  }
}

func_4AC4() {
  level endon("nest_ee_fuses_complete");
  for(;;) {
    self waittill("trigger", var_00);
    if(self.var_3F2A && isDefined(level.var_24A2)) {
      func_9A82(var_00);
      continue;
    }

    if(common_scripts\utility::func_562E(self.var_1F20)) {
      var_00 thread lib_0367::func_8E3C("circuitlocked");
    }
  }
}

func_2EB6(param_00) {
  var_01 = "";
  if(!isDefined(param_00.var_3071)) {
    if(common_scripts\utility::func_24A6()) {
      var_01 = "circuitmap";
    } else {
      var_01 = "mapinteract";
    }

    var_02 = param_00 lib_0367::func_8E3D(var_01);
    if(isDefined(var_02)) {
      param_00.var_3071 = 1;
    }
  }
}

func_8A58() {
  var_00 = func_689E(-1);
  level.var_292A = [var_00, var_00, var_00, var_00];
}

func_3875() {
  level.var_24A2 = [];
  var_00 = [];
  var_00 = [];
  var_01 = "";
  var_02 = getent("fuses_reset_button", "targetname");
  for(var_03 = 0; var_03 < 4; var_03++) {
    var_04 = randomint(3);
    if(var_00.size != 0) {
      var_04 = func_A274(var_04, var_00);
    }

    var_00[var_00.size] = var_04;
    var_05 = func_689E(var_04);
    var_01 = var_01 + var_05 + " ";
    level.var_24A2[var_03] = var_05;
    level.var_292A[var_03] = func_689E(-1);
  }
}

func_856A(param_00, param_01) {
  var_02 = ["red", "green", "blue"];
  if(common_scripts\utility::func_562E(param_01)) {
    param_00 = ["black", "black", "black", "black"];
    self setscriptablepartstate("dial", "off");
    for(var_03 = 0; var_03 < 4; var_03++) {
      thread func_9ED5(var_03);
    }

    thread func_310F();
  } else {
    self setscriptablepartstate("dial", "on");
    for(var_03 = 0; var_03 < 4; var_03++) {
      thread func_9ECD(var_03);
    }

    thread func_320B();
  }

  var_04 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    for(var_05 = 0; var_05 < var_02.size; var_05++) {
      var_06 = var_02[var_05] + "_" + var_03 + 1;
      if(var_02[var_05] != param_00[var_03]) {
        self setscriptablepartstate(var_06, "off");
        continue;
      }

      self setscriptablepartstate(var_06, "on");
      var_04[var_03] = var_02[var_05];
    }
  }

  lib_0378::func_8D74("circuit_map_reveal_machine_lights", var_04);
}

func_851D(param_00, param_01) {
  var_02 = ["red", "green", "blue"];
  if(common_scripts\utility::func_562E(param_01)) {
    param_00 = ["off", "off", "off", "off"];
  }

  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    var_04 = "indicator_0" + common_scripts\utility::func_9AAD(var_03 + 1);
    self setscriptablepartstate(var_04, param_00[var_03]);
  }
}

func_320B() {
  self setscriptablepartstate("button", "on");
  wait(getanimlength(%zmb_circuit_map_machine_button_press_on));
  self setscriptablepartstate("button", "on_idle");
}

func_310F() {
  self setscriptablepartstate("button", "off");
  wait(getanimlength(%zmb_circuit_map_machine_button_reverse));
  self setscriptablepartstate("button", "off_idle");
}

func_9ED5(param_00) {
  param_00 = param_00 + 1;
  var_01 = [];
  var_01[0] = % zmb_circuit_map_machine_needle_01_dial_on;
  var_01[1] = % zmb_circuit_map_machine_needle_02_dial_on;
  var_01[2] = % zmb_circuit_map_machine_needle_03_dial_on;
  var_01[3] = % zmb_circuit_map_machine_needle_04_dial_on;
  self setscriptablepartstate("needle_0" + param_00, "on");
  wait(getanimlength(var_01[param_00 - 1]));
  self setscriptablepartstate("needle_0" + param_00, "on_idle");
}

func_9ECD(param_00) {
  param_00 = param_00 + 1;
  var_01 = [];
  var_01[0] = % zmb_circuit_map_machine_needle_01_dial_off;
  var_01[1] = % zmb_circuit_map_machine_needle_02_dial_off;
  var_01[2] = % zmb_circuit_map_machine_needle_03_dial_off;
  var_01[3] = % zmb_circuit_map_machine_needle_04_dial_off;
  self setscriptablepartstate("needle_0" + param_00, "off");
  wait(getanimlength(var_01[param_00 - 1]));
  self setscriptablepartstate("needle_0" + param_00, "off_idle");
}

func_310E() {
  self setscriptablepartstate("button", "press");
}

func_9A82(param_00) {
  if(!isDefined(self.var_2904)) {
    self.var_2904 = -1;
  }

  self.var_2904 = common_scripts\utility::func_98E7(self.var_2904 == 2, 0, self.var_2904 + 1);
  level.var_292A[self.var_65E5] = func_689E(self.var_2904);
  thread func_868E(level.var_292A[self.var_65E5]);
  thread func_1C89(param_00);
  lib_0378::func_8D74("circuit_set_fuse_color_switch", self.var_65E5, level.var_292A[self.var_65E5]);
}

func_1C89(param_00) {
  self notify("broadcasted change");
  self endon("broadcasted change");
  wait(2.5);
  level notify("fuse code changed", param_00, self.var_65E5);
}

func_7D5F() {
  self.var_2904 = -1;
}

func_9ED4() {
  self.var_3F2A = 1;
  self.var_65DC.var_4028 = lib_0552::func_44FF("fuse_change_state");
  self.var_65DC.var_2F74 = 0;
  self.var_65DC.var_6642 = 1;
  self.var_65DC.interact_disabled = 0;
}

func_9ECC() {
  self.var_3F2A = 0;
  self.var_65DC.var_4028 = lib_0552::func_44FF("fuse_not_active");
  self.var_65DC.var_2F74 = 0;
  self.var_65DC.var_6642 = 1;
  self.var_65DC.interact_disabled = 1;
  level.var_292A[self.var_65E5] = func_689E(-1);
  func_7D5F();
  lib_0378::func_8D74("circuit_clear_fuse_color_switch", self.var_65E5);
}

func_36B8() {
  common_scripts\utility::func_3C8F("flag_fuse_entered_correct");
  func_8624();
  common_scripts\utility::func_0FB2(level.var_665B, ::func_868D);
  lib_0557::func_782D("5 Right Hand fuses", "fuse matching start");
  level notify("nest_ee_fuses_complete");
}

func_A274(param_00, param_01) {
  for(var_02 = 0; !var_02; var_02 = 1) {
    if(!func_582F(param_00, param_01)) {
      param_00 = common_scripts\utility::func_98E7(param_00 == 2, 0, param_00 + 1);
      continue;
    }
  }

  return param_00;
}

func_582F(param_00, param_01) {
  var_02 = 2;
  var_03 = 0;
  for(var_04 = 0; var_04 < param_01.size; var_04++) {
    if(param_01[var_04] == param_00) {
      var_03++;
    }
  }

  return var_03 < var_02;
}

func_8749() {
  self[0] func_8C06();
  self[1] func_4D0F();
  self[2] func_4D0F();
}

func_874E() {
  self[0] func_4D0F();
  self[1] func_4D0F();
  self[2] func_4D0F();
}

func_8BF2() {
  for(;;) {
    level waittill("fuse code changed", var_00, var_01);
    if(isDefined(level.var_24A2)) {
      for(var_02 = 0; var_02 < level.var_24A2.size; var_02++) {
        if(level.var_292A[var_02] == level.var_24A2[var_02]) {
          if(var_02 == var_01) {
            playclientsound("zm_ctcms_fuse", undefined, var_00.var_0116);
          }
        }
      }
    }
  }
}

func_21C8() {
  var_00 = 0;
  while(!var_00) {
    level waittill("fuse code changed", var_01, var_02);
    var_00 = func_44F4(var_01);
    if(var_00) {
      func_36B8();
      continue;
    }
  }
}

func_44F4(param_00) {
  if(!common_scripts\utility::func_562E(level.var_665C)) {
    level.var_665C = 0;
  }

  if(!isDefined(level.var_24A2)) {
    return 0;
  }

  var_01 = 1;
  var_02 = "";
  var_03 = 1;
  var_04 = 1;
  for(var_05 = 0; var_05 < level.var_24A2.size; var_05++) {
    if(level.var_292A[var_05] != level.var_24A2[var_05]) {
      var_02 = var_02 + "0";
      var_04 = 0;
      var_01 = 0;
      continue;
    }

    if(var_04) {
      if(var_05 == 0 && !level.var_665C) {
        param_00 thread lib_0367::func_8E3C("circuit1");
        level.var_665C = 1;
      }

      var_02 = var_02 + "1";
      var_03++;
    }
  }

  for(var_05 = 0; var_05 < level.var_665B.size; var_05++) {
    if(var_05 < var_03) {
      level.var_665B[var_05] func_9ED4();
      if(var_05 == var_03 - 1) {
        level.var_665B[var_05] thread func_868E("open", "blinking");
      } else {
        level.var_665B[var_05] thread func_868E("open", "on");
      }

      level notify("open fuse doors " + var_05);
      continue;
    }

    level.var_665B[var_05] func_9ECC();
    level.var_665B[var_05] thread func_868E("close", "off");
  }

  return var_01;
}

func_689E(param_00) {
  if(param_00 == 0) {
    return "red";
  }

  if(param_00 == 1) {
    return "green";
  }

  if(param_00 == 2) {
    return "blue";
  }

  return "no color";
}

func_250B(param_00) {
  if(param_00 == "red") {
    return 0;
  }

  if(param_00 == "green") {
    return 1;
  }

  if(param_00 == "blue") {
    return 2;
  }

  return 3;
}

func_8C06() {
  self method_805B();
}

func_4D0F() {
  self method_805C();
}

func_52E4() {
  level thread func_8BF2();
  var_00 = getEntArray("nest_ee_fuse_trigger", "targetname");
  var_00 = common_scripts\utility::func_0FA5(var_00, ::func_8323);
  var_01 = getent("rhog_control", "targetname");
  if(isDefined(var_01)) {
    var_01 thread maps\mp\mp_zombie_nest_ee_util::func_4D77("off");
  }

  level.var_665B = var_00;
  for(var_02 = 0; var_02 < level.var_665B.size; var_02++) {
    level.var_665B[var_02].var_65E5 = var_02;
  }

  var_03 = getent("fuse_quest_start_trigger", "targetname");
  var_03 sethintstring(&"ZOMBIE_NEST_OBJECTIVE_OFFLINE");
  level.var_22F5 = getent("fuses_reset_button", "targetname");
  level.var_22F5 func_856A(undefined, 1);
  var_04 = getent("fuses_com_map", "targetname");
  var_04 func_851D(undefined, 1);
}

func_52E3() {
  for(var_00 = 0; var_00 < level.var_665B.size; var_00++) {
    level.var_665B[var_00].var_65E5 = var_00;
    level.var_665B[var_00].var_65DC = lib_0552::func_7BE1(undefined, level.var_665B[var_00]);
    level.var_665B[var_00].var_65DC.var_2F74 = 1;
  }
}

func_8323(param_00, param_01) {
  return lib_0547::func_9470(param_00.var_0165) < lib_0547::func_9470(param_01.var_0165);
}