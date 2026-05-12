/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_pneumos.gsc
**********************************************/

func_00F9() {
  common_scripts\utility::func_3C87("flag_all_tubes_ridden");
  common_scripts\utility::func_3C87("flag_pap_available");
  common_scripts\utility::func_3C87("flag_cage_not_moving");
  common_scripts\utility::func_3C87("flag_cage_power_outage_triggered");
  common_scripts\utility::func_3C87("flag_pneumos_activated");
  level.var_7532[0] = common_scripts\utility::func_46B5("pneumo_start_1", "targetname");
  level thread func_6C09();
  if(!isDefined(level.var_7532[0])) {
    return;
  }

  level.var_7532[1] = common_scripts\utility::func_46B5("pneumo_start_2", "targetname");
  level.var_7532[2] = common_scripts\utility::func_46B5("pneumo_start_3", "targetname");
  var_00 = getent("pneumo_box_origin", "targetname");
  var_01 = getEntArray("pneumo_tubes_geo", "targetname");
  if(level.var_7532.size > 0) {
    foreach(var_03 in level.var_7532) {
      var_03.var_9E42 = 0;
      var_03.var_3A6A = 0;
      var_03.var_3A6B = 0;
      var_04 = common_scripts\utility::func_44BE(var_03.var_01A2, "targetname");
      foreach(var_06 in var_04) {
        if(!isDefined(var_06.var_0165)) {
          continue;
        }

        var_07 = var_06.var_0165;
        switch (var_07) {
          case "tube_trig":
            var_03.var_A1F7 = var_06;
            break;

          case "tube_fence":
            var_03.var_3A68 = var_06;
            break;

          case "tube_fence_blocker":
            var_03.var_3A69 = var_06;
            break;

          default:
            break;
        }
      }

      var_09 = common_scripts\utility::func_46B5(var_03.var_3A68.var_01A2, "targetname");
      var_0A = maps\mp\mp_zombie_nest_ee_util::func_44C8("pnuemo_tube_node_begin", 1);
      var_0A = common_scripts\utility::func_0F6F(var_0A, var_09);
      var_03.var_6EB7 = var_0A;
      var_03 thread func_8A3B(var_00);
    }
  }

  thread func_9E43();
  common_scripts\utility::func_3C8F("flag_cage_not_moving");
  level.var_6E33 = func_8A0B();
  var_0C = common_scripts\utility::func_46B7("cage_button", "targetname");
  foreach(var_0E in var_0C) {
    var_0F = common_scripts\utility::func_44BE(var_0E.var_01A2, "targetname");
    foreach(var_06 in var_0F) {
      if(!isDefined(var_06.var_0165)) {
        continue;
      }

      var_07 = var_06.var_0165;
      switch (var_07) {
        case "cage_button_trig":
          var_0E.var_1E2C = var_06;
          if(lib_0547::func_5565(var_0E.var_0165, "first_button")) {
            var_0E.var_1E2C sethintstring(&"ZOMBIE_NEST_PNEUMO_TUBE_ACTIVATE");
          } else {
            var_0E.var_1E2C sethintstring(&"ZOMBIES_SWITCH_HINT_GENERIC_BUTTON");
          }
          break;

        case "cage_button_model":
          var_0E.var_1E2B = var_06;
          break;

        case "cage_button_light":
          var_0E.var_1E2A = var_06;
          break;

        case "cage_light":
          var_0E.var_1E2F = var_06;
          break;
      }
    }

    var_0E thread func_1DE0();
  }

  level.var_1E2E = 0;
  level.var_1E30 = level.var_7532.size + 1;
  thread func_203D();
  level.var_6E33 thread func_1E34();
}

func_6C09() {
  var_00 = function_021F("scriptable_pnuemo_tube", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("tube_model", "closing");
  }

  wait(getanimlength(%zmb_pn_tube_01_door_close));
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("tube_model", "closed");
  }

  common_scripts\utility::func_3C9F("flag_pneumos_activated");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("tube_model", "opening");
  }

  wait(getanimlength(%zmb_pn_tube_01_door_open));
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("tube_model", "opened");
  }
}

func_9E43() {
  var_00 = [];
  while(!common_scripts\utility::func_3C77("flag_all_tubes_ridden")) {
    var_01 = 1;
    level waittill("pneumo_tube_ridden", var_02);
    if(!common_scripts\utility::func_0F79(var_00, var_02)) {
      var_02.var_9E42 = 1;
      var_00[var_00.size] = var_02;
    }

    foreach(var_04 in level.var_7532) {
      if(var_04.var_9E42 == 0) {
        var_01 = 0;
      }
    }

    if(var_01) {
      common_scripts\utility::func_3C8F("flag_all_tubes_ridden");
      break;
    }

    wait 0.05;
  }
}

func_64E1() {
  if(self.var_3A6B || self.var_3A6A) {
    return;
  }

  self.var_3A6B = 1;
  self.var_3A68 scriptmodelplayanim(self.var_3A68.var_8109);
  wait(1.133333);
  self.var_3A69 notsolid();
  self.var_3A69 method_8060();
  self.var_3A69 delete();
  self.var_3A6A = 1;
}

func_63B8(param_00) {
  level endon("flag_pneumos_activated");
  for(;;) {
    param_00 waittill("trigger", var_01);
    lib_0555::func_83DD("pneumo_closed", var_01);
  }
}

func_8A3B(param_00) {
  wait(1);
  self.var_A1F7 sethintstring(&"ZOMBIE_NEST_OBJECTIVE_OFFLINE");
  var_01 = function_021F("scriptable_pnuemo_tube", "targetname");
  var_02 = undefined;
  if(isDefined(var_01) && var_01.size > 0) {
    var_02 = common_scripts\utility::func_4461(self.var_A1F7.var_0116, var_01);
  }

  if(isDefined(var_02)) {
    self.var_A1F7 usetouchtriggerrequirefacingposition(1, var_02.var_0116);
  }

  level thread func_63B8(self.var_A1F7);
  var_03 = undefined;
  if(isDefined(var_02)) {
    var_03 = lib_0552::func_7BE1(undefined, self.var_A1F7, 1, var_02.var_0116);
  } else {
    var_03 = lib_0552::func_7BE1(undefined, self.var_A1F7);
  }

  var_03.var_4028 = lib_0552::func_44FF("pneumo");
  var_03.var_401E = 250;
  var_03.var_2F74 = 1;
  while(!lib_055A::func_586A("zone2_2_catacombs")) {
    wait(1);
  }

  common_scripts\utility::func_3C9F("flag_pneumos_activated");
  if(isDefined(var_03)) {
    var_03.var_2F74 = 0;
    var_03.var_6642 = 1;
  }

  self.var_A1F7 sethintstring(&"ZOMBIES_EMPTY_STRING");
  lib_0559::func_7BE3(self.var_A1F7, "pneumo");
  for(;;) {
    if(isDefined(self.var_A1F7)) {
      var_04 = self.var_A1F7 lib_0547::func_A795();
      var_05 = var_04[0];
      var_06 = var_04[1];
      if(!isPlayer(var_05)) {
        continue;
      }

      if(lib_0547::func_577E(var_05)) {
        continue;
      }

      if(lib_055A::func_586A(self.var_0165)) {
        if(var_05 maps\mp\gametypes\zombies::func_11C2(250)) {
          if(lib_057E::func_314D(var_05)) {
            var_05 lib_057E::func_95CB();
          }

          var_05 thread func_86E5(self);
          lib_0547::func_4AE4(var_05, "escape_tubes", 250, "none", "none");
        }
      } else {
        wait(1);
      }
    } else {
      break;
    }

    wait(0.01);
  }
}

func_86E5(param_00) {
  lib_0378::func_8D74("aud_start_pneumo_tube");
  var_01 = param_00.var_6EB7;
  self.var_53F0 = 1;
  var_02 = maps\mp\mp_zombie_nest_ee_util::func_90A9(self.var_0116);
  var_02.var_0116 = var_01[0].var_0116;
  var_02.var_001D = var_01[0].var_001D;
  self.var_0116 = var_02.var_0116;
  thread func_7533();
  self setangles(var_02.var_001D);
  self playerlinktoblend(var_02, "tag_origin", 0.8);
  self method_8003();
  maps\mp\mp_zombie_nest_ee_util::func_3E23();
  var_03 = [];
  for(var_04 = 0; var_04 < var_01.size - 1; var_04++) {
    var_03[var_04] = var_01[var_04];
  }

  var_02 thread maps\mp\mp_zombie_nest_ee_util::func_649B(var_03, 450, 0);
  func_38F5();
  var_02 waittill("path complete");
  func_A072(var_02, param_00);
}

func_7533() {
  self.var_1782 = func_2787("black", 1, self, (1, 1, 1));
  self.var_1782 fadeovertime(0.75);
  self.var_1782.var_0018 = 0;
  wait(0.75);
  if(isDefined(self) && isDefined(self.var_1782)) {
    self.var_1782 destroy();
  }
}

func_2787(param_00, param_01, param_02, param_03) {
  if(isDefined(param_02)) {
    var_04 = newclienthudelem(param_02);
  } else {
    var_04 = newhudelem();
  }

  var_04.var_01D3 = 0;
  var_04.var_01D7 = 0;
  var_04 setshader(param_00, 640, 480);
  var_04.var_0010 = "left";
  var_04.var_0011 = "top";
  var_04.var_0184 = 1;
  var_04.var_00C6 = "fullscreen";
  var_04.var_01CA = "fullscreen";
  var_04.var_0018 = param_01;
  var_04.var_00A0 = 1;
  if(isDefined(param_03)) {
    var_04.var_0056 = param_03;
  }

  return var_04;
}

func_A072(param_00, param_01) {
  var_02 = param_01.var_6EB7;
  self unlink();
  self setangles(var_02[var_02.size - 1].var_001D);
  self setorigin(var_02[var_02.size - 1].var_0116);
  self method_8004();
  maps\mp\mp_zombie_nest_ee_util::func_1F3D();
  var_03 = 150 * lib_055F::func_A01F(var_02[var_02.size - 1].var_001D);
  self setvelocity(var_03);
  param_00 delete();
  level notify("pneumo_tube_ridden", param_01);
  if(!param_01.var_3A6A && !param_01.var_3A6B) {
    param_01 thread func_64E1();
  }

  for(;;) {
    if(self isonground()) {
      playFX(level.var_0611["zmb_pneumo_exit_splash"], self.var_0116 + (0, 0, 20));
    }

    break;
  }

  wait(3);
  self.var_53F0 = 0;
}

func_38F5() {
  wait(2);
  if(self.var_53F0 == 1) {
    playfxontagforclients(level.var_0611["zmb_pneumo_tube_exit_cam"], self, "TAG_ORIGIN", self);
  }
}

func_1DE0() {
  if(lib_0547::func_5565(self.var_0165, "first_button")) {
    thread func_17BF();
  }

  self.var_1E2C waittill("trigger", var_00);
  if(lib_0547::func_5565(self.var_0165, "first_button")) {
    common_scripts\utility::func_3C8F("flag_pneumos_activated");
  }

  self.var_1E2B lib_0378::func_8D74("zmb_pap_button");
  self.var_1E2B scriptmodelplayanim("zmb_undg_cage_switch_activate");
  self.var_1E2C sethintstring(&"ZOMBIES_EMPTY_STRING");
  self.var_1E2C common_scripts\utility::func_9D9F();
  if(!common_scripts\utility::func_3C77("flag_pap_available")) {
    var_01 = 0;
    while(!var_01) {
      if(common_scripts\utility::func_3C77("flag_cage_not_moving")) {
        common_scripts\utility::func_3C7B("flag_cage_not_moving");
        func_7A2D();
        func_9ED1();
        var_01 = 1;
        common_scripts\utility::func_3C8F("flag_cage_not_moving");
        continue;
      }

      common_scripts\utility::func_3C9F("flag_cage_not_moving");
    }
  }

  self.var_1E2C delete();
}

func_203D() {
  var_00 = getent("cage_dialogue", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(!isDefined(var_01.var_6E34) && isPlayer(var_01)) {
      var_01 thread lib_0378::func_307E("ame_ihavetoliftthisc");
      var_01.var_6E34 = 1;
    }
  }
}

func_1E34() {
  common_scripts\utility::func_3C9F("flag_pap_available");
  func_6E42();
  foreach(var_01 in level.var_744A) {
    var_01.var_6E34 = 1;
  }
}

func_6E42() {
  foreach(var_01 in level.var_744A) {}

  level.var_400E[level.var_400E.size] = ["raven_set 3 1", "all"];
  level.var_400E[level.var_400E.size] = ["assassin_set 1 -1", "all"];
}

func_7A2D() {
  var_00 = % zmb_catacombs_cage_up_01;
  var_01 = % zmb_catacombs_cage_up_02;
  var_02 = % zmb_catacombs_cage_up_03;
  var_03 = % zmb_catacombs_cage_up_04;
  var_04 = getanimlength(var_00);
  var_05 = getanimlength(var_01);
  var_06 = getanimlength(var_02);
  var_07 = getanimlength(var_03);
  var_08 = 0;
  var_09 = undefined;
  var_0A = "idle_0";
  switch (level.var_1E2E) {
    case 0:
      level.var_6E33.var_1E31 lib_0378::func_8D74("pap_powerup", 1);
      thread func_203A();
      wait(1);
      level.var_6E33.var_1E31 lib_0378::func_8D74("zmb_pap_cage_up_1");
      var_08 = var_04;
      var_0A = "up_1";
      break;

    case 1:
      var_08 = var_05;
      func_1E33();
      level.var_6E33.var_1E31 lib_0378::func_8D74("zmb_pap_cage_up_2");
      var_0A = "up_2";
      break;

    case 2:
      var_08 = var_06;
      func_1E33();
      level.var_6E33.var_1E31 lib_0378::func_8D74("zmb_pap_cage_up_3");
      var_0A = "up_3";
      break;

    case 3:
      var_08 = var_07;
      func_1E33();
      level.var_6E33.var_1E31 lib_0378::func_8D74("zmb_pap_cage_up_4");
      var_0A = "up_4";
      break;

    default:
      break;
  }

  wait(0.2);
  level.var_6E33.var_1E31 setscriptablepartstate("cage", var_0A);
  wait(var_08);
  if(level.var_1E2E + 1 >= level.var_1E30) {
    func_3299();
  } else {
    level.var_6E33.var_1E31 lib_0378::func_8D74("catacombs_scare", "power_down_main");
  }

  level.var_1E2E++;
}

func_3299(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  level.var_6E33.var_1E2D method_8060();
  level.var_6E33.var_1E2D notsolid();
  level.var_6E33.var_1E2D delete();
  if(param_00) {
    level.var_6E33.var_1E31 setscriptablepartstate("cage", "up_4");
  }

  common_scripts\utility::func_3C8F("flag_pap_available");
}

func_8A0B() {
  var_00 = spawnStruct();
  var_01 = function_021F("cage", "targetname");
  var_00.var_1E31 = var_01[0];
  var_00.var_1E2D = getent("cage_clip", "targetname");
  return var_00;
}

func_46BA(param_00, param_01) {
  var_02 = "";
  if(!issubstr(param_01, param_00)) {} else {
    var_02 = getsubstr(param_01, param_00.size, param_01.size);
    var_02 = int(common_scripts\utility::func_9468(var_02)) - 1;
  }

  return var_02;
}

func_9ED1() {
  if(isDefined(self.var_1E2F)) {
    self.var_1E2F setModel("zmb_light_cage_standalone_green_01");
  }

  self notify("cage light enabled");
  if(isDefined(self.var_1E2A)) {
    self.var_1E2A setModel("zmb_light_cage_standalone_green_01");
  }
}

func_17BF() {
  self endon("cage light enabled");
  for(;;) {
    self.var_1E2A setModel("zmb_light_cage_standalone_red_01");
    wait(0.5);
    self.var_1E2A setModel("zmb_light_cage_standalone_green_01");
    wait(0.5);
  }
}

func_1E33() {
  var_00 = randomint(level.var_7532.size);
  if(var_00 == 0 && !common_scripts\utility::func_3C77("flag_cage_power_outage_triggered")) {
    common_scripts\utility::func_3C8F("flag_cage_power_outage_triggered");
    level.var_6E33.var_1E31 lib_0378::func_8D74("zmb_pap_fuse");
    thread func_203B();
    level thread common_scripts\_exploder::func_088E(207);
    wait(1);
    level.var_6E33.var_1E31 lib_0378::func_8D74("catacombs_scare", "power_down_main");
    level.var_1E32 = [];
    var_01 = common_scripts\utility::func_46B7("cage_scare_spawner", "script_noteworthy");
    foreach(var_03 in var_01) {
      var_04 = lib_054D::func_90BA("zombie_berserker", var_03, "cage zombie", 0, 1, 1);
      thread func_1E35(var_04);
      level.var_1E32[level.var_1E32.size] = var_04;
    }

    wait(0.5);
    func_2035();
    level.var_6E33.var_1E31 lib_0378::func_8D74("catacombs_scare", "power_up_secondary");
    wait(0.5);
    func_2039();
    level maps\mp\_utility::func_A6D1(30, "cage_zombies_dead");
    level.var_6E33.var_1E31 lib_0378::func_8D74("catacombs_scare", "power_up_main");
    func_2037();
    return;
  }

  level.var_6E33.var_1E31 lib_0378::func_8D74("catacombs_scare", "cage_move");
  thread func_203C();
}

func_1E35(param_00) {
  param_00 waittill("death");
  level.var_1E32 = common_scripts\utility::func_0F93(level.var_1E32, param_00);
  if(level.var_1E32.size == 0) {
    level notify("cage_zombies_dead");
  }
}

func_2037() {
  var_00 = function_021F("switch", "targetname");
  foreach(var_02 in var_00) {
    wait(0.1);
    var_02 setscriptablepartstate("switchlights", "on");
  }

  var_04 = function_021F("fill", "targetname");
  foreach(var_06 in var_04) {
    wait(0.1);
    var_06 setscriptablepartstate("switchlights2", "on");
  }

  var_08 = function_021F("switchmid", "targetname");
  foreach(var_0A in var_08) {
    wait(0.1);
    var_0A setscriptablepartstate("switchlightsmid", "on");
  }

  var_0C = function_021F("charswitch", "targetname");
  foreach(var_0E in var_0C) {
    wait(0.01);
    var_0E setscriptablepartstate("switchlights2", "off");
  }
}

func_2035() {
  var_00 = function_021F("fill", "targetname");
  foreach(var_02 in var_00) {
    wait(0.04);
    var_02 setscriptablepartstate("switchlights2", "off");
  }

  var_04 = function_021F("switchmid", "targetname");
  foreach(var_06 in var_04) {
    wait(0.1);
    var_06 setscriptablepartstate("switchlightsmid", "off");
    wait(0.08);
  }

  var_08 = function_021F("switch", "targetname");
  foreach(var_0A in var_08) {
    wait(0.1);
    var_0A lib_0378::func_8D74("catacombs_scare", "switch_lights_off");
    var_0A setscriptablepartstate("switchlights", "off");
    wait(0.1);
  }
}

func_2039() {
  var_00 = function_021F("charswitch", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("switchlights2", "on");
  }

  var_04 = function_021F("switchmid", "targetname");
  foreach(var_06 in var_04) {
    var_06 setscriptablepartstate("switchlightsmid", "red");
  }

  var_08 = function_021F("switch", "targetname");
  foreach(var_0A in var_08) {
    var_0A setscriptablepartstate("switchlights", "red");
  }
}

func_2038() {
  var_00 = function_021F("switchmid", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("switchlightsmid", "shortout");
    wait(0.1);
    var_02 setscriptablepartstate("switchlightsmid", "on");
  }
}

func_2036() {
  func_2035();
  wait(0.5);
  func_2039();
}

func_203A() {
  func_2038();
  wait(0.03);
  func_2038();
  wait(0.02);
  func_2038();
  wait(0.01);
  func_2038();
  wait(0.02);
  func_2038();
  wait(0.01);
  func_2038();
}

func_203B() {
  wait(2);
  func_2038();
  wait(3);
  func_2038();
  wait(0.2);
  func_2038();
  wait(0.2);
  func_2038();
  wait(0.1);
  func_2038();
  wait 0.05;
  func_2038();
  wait(0.03);
  func_2038();
  wait(0.02);
  func_2038();
  wait(1.1);
  func_2038();
  wait(0.5);
  func_2038();
  wait(0.2);
  func_2038();
  wait(0.11);
  func_2038();
  wait(0.02);
  func_2038();
  wait(0.01);
  func_2038();
}

func_203C() {
  wait(0.2);
  func_2038();
}

func_516B(param_00, param_01, param_02) {
  if(!isDefined(level.var_17BA)) {
    level.var_17BA = [];
  }

  if(isDefined(level.var_17BA[param_02])) {}

  var_03 = func_3B66(param_00, param_01);
  foreach(var_05 in var_03) {
    if(isDefined(var_05.var_1CB1)) {
      var_05.var_1CB1 method_8511();
    }

    var_05 common_scripts\utility::func_9D9F();
    var_05 thread maps\mp\_dynamic_world::func_9DC3(::func_72F3, ::func_72F4);
  }

  level.var_17BA[param_02] = var_03;
}

func_17B8(param_00) {
  if(!isDefined(param_00.var_17B7)) {
    param_00.var_17B7 = newclienthudelem(param_00);
    param_00.var_17B7 setshader("black", 640, 480);
    param_00.var_17B7.var_0010 = "left";
    param_00.var_17B7.var_0011 = "top";
    param_00.var_17B7.var_01D3 = 0;
    param_00.var_17B7.var_01D7 = 0;
    param_00.var_17B7.var_00C6 = "fullscreen";
    param_00.var_17B7.var_01CA = "fullscreen";
    param_00 method_8483("mp_zombie_nest_01_bunker_darkness");
  }

  param_00.var_17B7.var_0018 = 1;
}

func_7C76(param_00) {
  if(isDefined(param_00.var_17B7)) {
    param_00.var_17B7.var_0018 = 0;
    param_00 method_8483("", 1);
  }
}

func_3B66(param_00, param_01) {
  var_02 = getEntArray(param_00, param_01);
  var_03 = [];
  foreach(var_05 in var_02) {
    if(!isDefined(var_05.var_003A) || var_05.var_003A != "trigger_multiple") {
      continue;
    }

    if(isDefined(var_05.var_01A2)) {
      var_05.var_1CB1 = getent(var_05.var_01A2, "targetname");
    }

    var_03[var_03.size] = var_05;
  }

  return var_03;
}

func_2CFE(param_00, param_01) {
  var_02 = func_3B66(param_00, param_01);
  foreach(var_04 in var_02) {
    if(isDefined(var_04.var_1CB1)) {
      var_04.var_1CB1 delete();
      var_04.var_1CB1 = undefined;
    }
  }
}

func_088D(param_00) {
  if(!isDefined(level.var_17BA)) {
    return;
  }

  var_01 = level.var_17BA[param_00];
  if(!isDefined(var_01)) {
    return;
  }

  foreach(var_03 in var_01) {
    var_03 func_088C();
  }
}

func_2A6C(param_00) {
  if(!isDefined(level.var_17BA)) {
    return;
  }

  var_01 = level.var_17BA[param_00];
  if(!isDefined(var_01)) {
    return;
  }

  foreach(var_03 in var_01) {
    var_03 func_2A6B();
  }
}

func_088C() {
  common_scripts\utility::func_9DA3();
  if(isDefined(self.var_1CB1)) {
    self.var_1CB1 method_805B();
  }
}

func_2A6B() {
  common_scripts\utility::func_9D9F();
  if(isDefined(self.var_1CB1)) {
    self.var_1CB1 method_8511();
  }
}

func_72F3(param_00) {
  if(!isDefined(self.var_17B9)) {
    self.var_17B9 = 0;
  }

  self.var_17B9++;
  if(self.var_17B9 == 1) {
    func_17B8(self);
  }
}

func_72F4(param_00) {
  self.var_17B9--;
  if(self.var_17B9 == 0) {
    func_7C76(self);
  }
}