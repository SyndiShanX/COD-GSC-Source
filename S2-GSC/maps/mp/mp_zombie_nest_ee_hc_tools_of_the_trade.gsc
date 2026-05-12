/***************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_hc_tools_of_the_trade.gsc
***************************************************************/

func_00F9() {
  common_scripts\utility::func_3C87("flag_nest_hc_ee_sword_acquired");
  level.var_9A93 = 1;
  var_00 = func_52EC();
  var_00 thread func_9A92();
  lib_0557::func_4BC9("r.medal A get");
  lib_0557::func_4BC9("r.medal B get");
  lib_0557::func_4BC9("r.sword get", "obtaining sword", "CONST_HC_ANALYTICS_R_SWORD_GET");
  lib_0557::func_4BC9("circuit found");
  lib_0557::func_4BC9("circuit shot by tesla", "finding and shooting circuit", "CONST_HC_ANALYTICS_CIRCUIT_SHOT");
}

func_52EC() {
  var_00 = common_scripts\utility::func_46B5("nest_ee_hc_com_fuse_struct", "targetname");
  var_01 = getent(var_00.var_01A2, "targetname");
  var_02 = getent("nest_ee_hc_com_door_trig", "targetname");
  level.var_6874 = 0;
  var_03 = common_scripts\utility::func_46B7("nest_ee_hc_safe_struct", "targetname");
  foreach(var_05 in var_03) {
    var_06 = common_scripts\utility::func_44BE(var_05.var_01A2, "targetname");
    var_07 = function_021F(var_05.var_01A2, "targetname");
    var_05.var_801E = var_07[0];
    var_05.var_3B9C = [];
    for(var_08 = 0; var_08 < 5; var_08++) {
      var_05.var_3B9C[var_08] = undefined;
    }

    foreach(var_0A in var_06) {
      switch (var_0A.var_0165) {
        case "nest_ee_hc_safe_fingerprint":
          var_05.var_3B9C[lib_0547::func_9470(var_0A.var_819A) - 1] = var_0A;
          break;

        case "nest_ee_hc_safe_trigger":
          var_05.var_9D65 = var_0A;
          var_05.var_9D65 common_scripts\utility::func_9D9F();
          break;

        case "nest_ee_hc_safe_sentry_trig_offset":
          var_05.var_9DA2 = var_0A;
          break;

        case "nest_ee_hc_safe_door":
          var_05.var_8021 = var_0A;
          break;

        case "nest_ee_hc_safe_blood_message":
          var_05.var_17F7 = var_0A;
          var_05.var_17F7 method_805C();
          break;

        case "nest_ee_hc_safe_raven_key":
          var_05.var_7A79 = var_0A;
          var_05.var_7A79 method_805C();
          break;

        default:
          break;
      }
    }
  }

  var_0D = getEntArray("zmb_bloodraven_key_inserts", "targetname");
  foreach(var_0F in var_0D) {
    var_0F method_805C();
  }

  var_11 = common_scripts\utility::func_46B5("nest_ee_hc_com_power_struct", "targetname");
  var_12 = getent(var_11.var_01A2, "targetname");
  var_13 = common_scripts\utility::func_46B5("nest_ee_hc_com_power_door_struct", "targetname");
  var_14 = getent(var_13.var_01A2, "targetname");
  var_15["original_objective_trigs"] = level.var_358E;
  var_15["fuse_trigger"] = var_02;
  var_15["secret_door"] = var_01;
  var_15["power_box"] = var_12;
  var_15["power_box_door"] = var_14;
  var_15["sentry_safes"] = var_03;
  var_15["secret_door"] func_857F();
  return var_15;
}

func_8B98() {
  return 1;
}

func_9A92() {
  self["fuse_trigger"] common_scripts\utility::func_9D9F();
  common_scripts\utility::func_3C9F(lib_0557::func_7838("5 Right Hand fuses", "tower confirm hand"));
  func_A64A(self["original_objective_trigs"]);
  thread func_7EFB();
}

func_760C() {
  var_00 = maps\mp\mp_zombie_nest_ee_cart::func_8A2B("light_zm_objective", "light_zm_puzzle", "on", "lightoff", "puzzlelight");
  var_01 = maps\mp\mp_zombie_nest_ee_cart::func_8A2B("beam_zm_objective", "light_zm_lgtbeam", "lightbeam", "lightbeamoff", "glow");
  self["power_box_door"] thread maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::func_6C01();
  playFX(common_scripts\utility::func_44F5("zmb_ee_switch_sparks"), self["power_box"].var_0116, anglesToForward(self["power_box"].var_001D), anglestoup(self["power_box"].var_001D));
  self["power_box"].var_0A33 = common_scripts\utility::func_0F73(var_00, var_01);
  self["power_box"] setCanDamage(1);
  self["power_box"].var_8259 = self;
  self["power_box"] thread maps\mp\gametypes\_damage::func_8676(1, "head_gibs", ::maps\mp\mp_zombie_nest_ee_util::func_9902, ::func_2575);
}

func_2575(param_00, param_01, param_02, param_03) {
  var_04 = common_scripts\utility::func_46B5("nest_ee_hc_com_power_struct", "targetname");
  var_05 = getent(var_04.var_01A2, "targetname");
  var_06 = anglesToForward(var_05.var_001D);
  if(common_scripts\utility::func_562E(level.var_665E)) {
    return 1;
  }

  if(issubstr(param_01, "teslagun")) {
    lib_0557::func_4BC8("circuit shot by tesla");
    if(!isDefined(self.var_177E) || level.var_A980 > self.var_177E) {
      if(!isDefined(self.var_177E)) {
        self.var_177E = level.var_A980;
      }

      playFX(level.var_0611["zmb_elec_coil_charge"], var_05.var_0116, var_06);
      var_05 lib_0378::func_8D74("aud_wonder_weapon_elec_coil_charge");
      thread func_4BD0();
    } else if(!self.var_177E > level.var_A980) {}
  }

  return 0;
}

func_4BD0() {
  if(isDefined(self.var_0A33)) {
    level thread maps\mp\mp_zombie_nest_ee_cart::func_A0EF(self.var_0A33, 0);
  }

  level thread func_7E3E();
  common_scripts\utility::func_3C8F("flag_bunker_lights_off");
  common_scripts\utility::func_3C8F("flag_bunker_lights_off");
  lib_0378::func_8D74("aud_bunker_lights", "off");
  level.var_9A93 = 1;
  wait(30);
  common_scripts\utility::func_3C7B("flag_bunker_lights_off");
  lib_0378::func_8D74("aud_bunker_lights", "on");
  level.var_9A93 = 0;
  level thread func_4D0A();
  if(isDefined(self.var_0A33)) {
    level thread maps\mp\mp_zombie_nest_ee_cart::func_A0EF(self.var_0A33, 1);
  }

  self.var_177E = level.var_A980;
}

func_4D0A() {
  level notify("com lights on");
  wait 0.05;
  var_00 = common_scripts\utility::func_46B7("nest_ee_hc_safe_struct", "targetname");
  foreach(var_02 in var_00) {
    if(!common_scripts\utility::func_562E(var_02.var_8026)) {
      var_02.var_8021 thread maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::func_2441();
    }
  }
}

func_7E3E() {
  var_00 = common_scripts\utility::func_46B7("nest_ee_hc_safe_struct", "targetname");
  foreach(var_02 in var_00) {
    if(!common_scripts\utility::func_562E(var_02.var_8026)) {
      var_02.var_8021 thread maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::func_6C01();
      var_02 thread func_11C0();
    }
  }
}

func_11C0() {
  thread func_8027();
  lib_057E::func_0984(self, self.var_9DA2, ::func_6BA1);
}

func_8027() {
  level waittill("com lights on");
  lib_057E::func_7CC2(self);
}

func_6BA1(param_00, param_01) {
  param_00.var_8026 = 1;
  param_00.var_8026 = 1;
  param_00.var_2E71 = [];
  var_02 = param_00 func_80D6();
  param_00.var_8026 = 1;
  param_00.var_17F7 method_805B();
  param_00.var_9D65 common_scripts\utility::func_9DA3();
  lib_057E::func_7CC2(self);
  param_00 func_A680(var_02, param_00.var_9D65, param_00.var_2E71);
  param_00.var_7A79 method_805B();
  param_00.var_801E setscriptablepartstate("machine_main", "opening");
  wait(getanimlength(%zmb_ob_safe_open));
  param_00.var_801E setscriptablepartstate("machine_main", "opened");
  param_00.var_9D65 waittill("trigger", var_03);
  var_03 lib_0378::func_8D74("zmb_ravens_key_pickup");
  param_00.var_7A79 method_805C();
  func_7E67();
}

func_80D6() {
  var_00 = [];
  for(var_01 = 0; var_01 < 5; var_01++) {
    var_00[var_01] = randomint(10);
  }

  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    self.var_801E setscriptablepartstate("dial_0" + var_01 + 1, "idle_" + var_00[var_01]);
  }

  wait(0.15);
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    self.var_2E71[var_01] = self.var_3B9C[var_01].var_0116;
    self.var_3B9C[var_01].var_65DB = spawn("script_model", self.var_2E71[var_01]);
    self.var_3B9C[var_01].var_65DB.var_001D = self.var_3B9C[var_01].var_001D;
    self.var_3B9C[var_01].var_65DB setModel("zmb_finger_print_0" + randomint(4) + 1);
  }

  var_02 = [];
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_03 = self.var_801E gettagangles("dial_0" + var_01 + 1);
    var_04 = self.var_801E gettagorigin("dial_0" + var_01 + 1);
    var_05 = self.var_3B9C[var_01].var_65DB.var_0116;
    var_06 = distance(var_04, var_05);
    self.var_3B9C[var_01].var_65DB linkto(self.var_801E, "dial_0" + var_01 + 1);
  }

  return var_00;
}

func_A680(param_00, param_01, param_02) {
  var_03 = [];
  for(var_04 = 0; var_04 < param_00.size; var_04++) {
    var_03[var_04] = randomint(10);
    self.var_801E setscriptablepartstate("dial_0" + var_04 + 1, "idle_" + var_03[var_04]);
  }

  var_05 = 0;
  while(!var_05) {
    param_01 waittill("trigger", var_06);
    var_07 = func_3B8A(var_06, param_02, 5);
    var_03[var_07] = common_scripts\utility::func_98E7(var_03[var_07] < 9, var_03[var_07] + 1, 0);
    self.var_801E setscriptablepartstate("dial_0" + var_07 + 1, "idle_" + var_03[var_07]);
    wait(0.15);
    var_08 = 0;
    for(var_04 = 0; var_04 < param_00.size; var_04++) {
      if(param_00[var_04] == var_03[var_04]) {
        var_08++;
      }
    }

    if(var_08 == param_00.size) {
      return;
    }
  }
}

func_3B8A(param_00, param_01, param_02) {
  var_03 = -1;
  var_04 = 0;
  for(var_05 = 0; var_05 < param_01.size; var_05++) {
    var_06 = cos(param_02);
    var_07 = anglesToForward(param_00.var_001D);
    var_08 = param_01[var_05] - param_00.var_0116;
    var_07 = var_07 * (1, 1, 0);
    var_08 = var_08 * (1, 1, 0);
    var_08 = vectornormalize(var_08);
    var_07 = vectornormalize(var_07);
    var_09 = vectordot(var_08, var_07);
    if(var_09 > var_03) {
      var_03 = var_09;
      var_04 = var_05;
    }
  }

  return var_04;
}

func_7E67() {
  level.var_6874++;
  var_00 = getEntArray("zmb_bloodraven_key_inserts", "targetname");
  var_00[level.var_6874 - 1] method_805B();
  switch (level.var_6874) {
    case 1:
      lib_0557::func_4BC8("r.medal A get");
      break;

    case 2:
      lib_0557::func_4BC8("r.medal B get");
      break;
  }

  if(level.var_6874 < 2) {
    return;
  }

  var_01 = getent("nest_hc_sword_door_trig", "targetname");
  var_02 = getent(var_01.var_01A2, "targetname");
  var_02.var_6C02 = 0;
  level.var_665E = 1;
  for(;;) {
    var_01 waittill("trigger", var_03);
    if(!var_02.var_6C02) {
      var_02 lib_0378::func_8D74("aud_open_raven_door");
      foreach(var_05 in var_00) {
        var_05 rotatepitch(90, 2);
      }

      wait(2);
      foreach(var_05 in var_00) {
        var_05 movez(-128, 4);
      }

      var_02 movez(-128, 4);
      var_02.var_6C02 = 1;
    }

    var_03 func_6FDA();
    lib_0378::func_8D74("aud_pickup_raven_sword");
  }
}

func_6FDA() {
  var_00 = 0;
  if(lib_057E::func_314D(self)) {
    var_00 = 1;
  }

  lib_0586::func_078C("raven_sword_zm");
  lib_0586::func_078E("raven_sword_zm");
  common_scripts\utility::func_3C8F("flag_nest_hc_ee_sword_acquired");
  lib_0557::func_4BC8("r.sword get");
  getswordreward();
}

func_42EF() {
  return "flag_nest_hc_ee_sword_acquired";
}

func_7EFB() {
  var_00 = 0;
  var_01 = undefined;
  var_02 = 0;
  while(!var_00) {
    self["secret_door"] func_8580();
    self["fuse_trigger"] common_scripts\utility::func_9DA3();
    var_00 = func_11C1(30);
    if(!var_00) {
      self["fuse_trigger"] common_scripts\utility::func_9D9F();
      self["secret_door"] func_857F();
      func_A64A(self["original_objective_trigs"]);
    }
  }

  self["secret_door"] func_857C();
  self["fuse_trigger"] common_scripts\utility::func_9D9F();
  lib_0557::func_4BC8("circuit found");
  thread func_760C();
}

func_857D() {
  self setscriptablepartstate("part_dial", "dial_to_on");
  wait(getanimlength(%zmb_circuit_puzzle_dial_off_to_on));
  self setscriptablepartstate("part_dial", "dial_on");
}

func_857E() {
  self setscriptablepartstate("part_dial", "dial_to_off");
  wait(getanimlength(%zmb_circuit_puzzle_dial_on_to_off));
  self setscriptablepartstate("part_dial", "dial_off");
}

func_8580() {
  self setscriptablepartstate("cbreaker", "opening");
  wait(getanimlength(%zmb_circuit_puzzle_open));
  self setscriptablepartstate("cbreaker", "opened_idle");
  thread func_8582();
}

func_857F() {
  thread func_8583();
  self setscriptablepartstate("cbreaker", "closing");
  wait(getanimlength(%zmb_circuit_puzzle_open));
  self setscriptablepartstate("cbreaker", "closed");
}

func_857C() {
  func_857D();
  thread func_8581();
}

func_8583() {
  self setscriptablepartstate("green_light", "off");
  self setscriptablepartstate("red_light", "off");
}

func_8581() {
  self setscriptablepartstate("green_light", "on");
  self setscriptablepartstate("red_light", "off");
}

func_8582() {
  self setscriptablepartstate("green_light", "off");
  self setscriptablepartstate("red_light", "on");
}

func_11C1(param_00) {
  self["fuse_trigger"] endon("time_out");
  thread func_9A01(param_00);
  self["fuse_trigger"] waittill("trigger", var_01);
  return isDefined(var_01);
}

func_9A01(param_00) {
  wait(param_00);
  self["fuse_trigger"] notify("trigger", undefined);
}

func_A64A(param_00) {
  var_01 = 0;
  maps\mp\mp_zombie_nest_ee_enigma::func_7D6C();
  maps\mp\mp_zombie_nest_ee_enigma::func_7AAC();
  while(!func_3789(param_00)) {
    var_03 = common_scripts\utility::func_A70B(param_00, "trigger");
    var_03 lib_0378::func_8D74("aud_enigma_switch_activate");
    var_03.var_5F59 thread maps\mp\mp_zombie_nest_ee_enigma::func_8717();
    var_03.var_08A9 = 1;
    common_scripts\utility::func_3C8F(var_03.var_8260);
    var_03 common_scripts\utility::func_9D9F();
  }
}

func_3789(param_00) {
  var_01 = 0;
  foreach(var_03 in param_00) {
    if(common_scripts\utility::func_562E(var_03.var_08A9)) {
      var_01++;
    }
  }

  return var_01 == param_00.size;
}

getswordreward() {
  if(!isDefined(level.players_have_aquired_hc_sword)) {
    level.players_have_aquired_hc_sword = 1;
  } else {
    return;
  }

  foreach(var_01 in level.var_744A) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("ravensword");
  }
}