/**************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_hc_restore_pub_power.gsc
**************************************************************/

func_00F9() {
  lib_0557::func_4BC9("pub powered", "powering pub", "CONST_HC_ANALYTICS_PUB_POWERED");
  common_scripts\utility::func_3C87("flag_nest_hc_ee_record_player_active");
  common_scripts\utility::func_3C87("flag_nest_hc_ee_weathervane_switch_shot");
  level.var_A9FC = 3;
  var_00 = func_52E7();
  var_00 thread func_7EF1();
}

func_8B28(param_00, param_01) {
  var_02 = common_scripts\utility::func_7A33(self["switch_scriptables"]);
  var_03 = getanimlength(%zmb_obj_glass_fuse_open);
  while(!func_3B8F(self["weather_vane"], var_02, 30, 1)) {
    self["weather_vane"] rotateyaw(15, 0.1);
    lib_0378::func_8D74("aud_weathervane_rotate", "short");
    wait(0.3);
  }

  var_04 = vectortoangles(var_02.var_0116 - self["weather_vane"].var_0116);
  var_05 = common_scripts\utility::func_98E7(var_04[1] + 180 > 360, var_04[1] - 180, var_04[1] + 180);
  self["weather_vane"] rotateto((self["weather_vane"].var_001D[0], var_05, self["weather_vane"].var_001D[2]), 0.15);
  lib_0378::func_8D74("aud_weathervane_rotate", "short");
  wait(0.15);
  var_02 setscriptablepartstate("fuse", "open");
  wait(var_03);
  var_02 setscriptablepartstate("fuse", "open_idle");
  var_02 waittill("damage");
  playFXOnTag(level.var_0611["zmb_ee_switch_sparks"], var_02, "tag_origin");
  var_02 lib_0378::func_8D74("aud_switch_damaged");
  common_scripts\utility::func_3C8F("flag_nest_hc_ee_weathervane_switch_shot");
  thread func_8B1C();
}

func_3B8F(param_00, param_01, param_02, param_03) {
  var_04 = cos(param_02);
  var_05 = (param_01.var_0116[0], param_01.var_0116[1], param_00.var_0116[2]);
  var_06 = anglesToForward(param_00.var_001D);
  var_07 = var_05 - param_00.var_0116;
  if(isDefined(param_03)) {
    var_07 = param_00.var_0116 - var_05;
  }

  var_06 = var_06 * (1, 1, 0);
  var_07 = var_07 * (1, 1, 0);
  var_07 = vectornormalize(var_07);
  var_06 = vectornormalize(var_06);
  var_08 = vectordot(var_07, var_06);
  if(var_08 >= var_04) {
    return 1;
  }

  return 0;
}

func_8B1C() {
  self["electric_panel"] method_8449(self["waterwheel"]);
  level thread common_scripts\_exploder::func_088E(223);
  self["waterwheel"] rotateroll(155, 12, 1, 1);
  thread func_9419();
  self["waterwheel"] lib_0378::func_8D74("aud_waterwheel");
  common_scripts\utility::func_3C9F(lib_0557::func_7838("5 Right Hand fuses", "lift outter rods"));
  self["electric_panel"] setCanDamage(1);
  self["electric_panel"] thread maps\mp\gametypes\_damage::func_8676(1, "head_gibs", ::maps\mp\mp_zombie_nest_ee_util::func_9902, ::maps\mp\mp_zombie_nest_ee_util::func_9903);
  self["electric_panel"] waittill("death", var_00, var_01, var_02);
  thread func_77AB();
  playFX(level.var_0611["zmb_elec_coil_charge"], self["electric_panel"].var_0116, anglesToForward(self["electric_panel"].var_001D));
  self["electric_panel"] lib_0378::func_8D74("aud_wonder_weapon_elec_coil_charge");
  thread func_08B4();
}

func_9419() {
  wait(12);
  level thread common_scripts\_exploder::func_2A6D(223, undefined, 0);
}

func_77AB() {
  var_00 = function_021F("hc_publights", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "flicker");
    wait(0.2);
    var_02 setscriptablepartstate("lightpart", "on");
  }
}

func_08B4() {
  common_scripts\utility::func_3C8F("nest_ee_hc_radio_available");
  common_scripts\utility::func_3C8F("flag_nest_hc_ee_record_player_active");
  lib_0557::func_4BC8("pub powered");
}

func_7EF1() {
  switch (level.var_A9FC) {
    case 1:
      self["weather_vane"] thread func_9485();
      break;

    case 2:
      level waittill("power_on");
      self["weather_vane"] thread func_9485();
      self["weather_vane"] func_A787(256);
      break;

    case 3:
      level waittill("power_on");
      self["weather_vane"] thread func_9485();
      self["weather_vane"] lib_0547::func_AC41(&"ZOMBIES_EMPTY_STRING");
      self["weather_vane"] waittill("player_used", var_00);
      break;
  }

  self["weather_vane"] notify("stop struggling");
  self["weather_vane"] rotateyaw(360, 0.7);
  lib_0378::func_8D74("aud_weathervane_rotate", "long");
  wait(0.75);
  thread func_8B28();
}

func_9485() {
  self endon("stop struggling");
  for(;;) {
    self rotateyaw(-15, 0.6);
    lib_0378::func_8D74("aud_weathervane_rotate", "struggle");
    wait(0.65);
    self rotateyaw(15, 0.1);
    lib_0378::func_8D74("aud_weathervane_rotate", "struggle");
    wait(0.155);
  }
}

func_A787(param_00) {
  var_01 = 0;
  while(!var_01) {
    foreach(var_03 in level.var_744A) {
      if(distance(var_03.var_0116, self.var_0116) < param_00) {
        var_01 = 1;
        break;
      }
    }

    wait(0.5);
  }
}

func_52E7() {
  var_00 = common_scripts\utility::func_46B5("hc_objective_weather_vane_hint_struct", "targetname");
  var_01 = getent(var_00.var_01A2, "targetname");
  var_01.var_693D = common_scripts\utility::func_46B5(var_01.var_01A2, "targetname");
  var_02 = common_scripts\utility::func_46B5("objective_2_possible_locations_struct", "targetname");
  var_03 = function_021F(var_02.var_01A2, "targetname");
  var_04 = common_scripts\utility::func_44BD("objective_2_waterwheel_struct", "targetname");
  var_05 = common_scripts\utility::func_44BD(var_04.var_01A2, "targetname");
  var_06 = common_scripts\utility::func_46B5("objective_2_pub_panel", "targetname");
  var_07 = getent(var_06.var_01A2, "targetname");
  var_08 = common_scripts\utility::func_46B5("objective_2_pub_record_player", "targetname");
  var_09 = function_021F("zmb_phonograph_model", "targetname");
  var_0A = var_09[0];
  var_0B["weather_vane"] = var_01;
  var_0B["switch_scriptables"] = var_03;
  var_0B["waterwheel"] = var_05;
  var_0B["electric_panel"] = var_07;
  var_0B["record_player"] = var_0A;
  return var_0B;
}