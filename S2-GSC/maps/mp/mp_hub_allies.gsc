/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_hub_allies.gsc
*********************************************/

func_00F9() {
  level.var_A1FE = getdvarint("4476", 0) != 0;
  level.var_A220 = level.var_A1FE;
  maps\mp\gametypes\_hub_stats::func_4F3E();
  lib_04AC::func_00F9();
  lib_0414::func_00F9();
  lib_04AB::func_00F9();
  maps\mp\_load::func_00F9();
  maps\mp\mp_hub_allies_lighting::func_00F9();
  maps\mp\mp_hub_allies_aud::func_00F9();
  maps\mp\_compass::func_8A2F("");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_A4B5["lerpDuration"] = 0.1;
  level.var_A4BE["intensity"] = 0.5;
  level.var_A4BE["falloff"] = 1.2;
  level.var_A4BE["scaleX"] = 1;
  level.var_A4BE["scaleY"] = 1;
  level.var_A4BE["squareAspectRatio"] = 0;
  level.var_A4BE["lerpDuration"] = 0.4;
  level.var_6465["velocityscaler"] = 0;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0;
  setDvar("4135", "allies");
  level.var_ACBC = undefined;
  level.var_ACBA = undefined;
  level.var_ACC0 = undefined;
  level.var_ACBD = undefined;
  level.var_ACBB = undefined;
  level.var_ACBF = undefined;
  level.devicesbegintrigger = getent("resistance_discoverable_begin", "targetname");
  level.devicestructs = [];
  level.deviceinteract = getent("device_interact", "targetname");
  thread func_529F();
  thread func_8A3A();
  setDvar("4712", "2");
  setDvar("3286", 0);
  setDvar("3220", "3");
}

func_8A3A() {
  maps\mp\gametypes\_hub_unk1::func_4F45("mp_hub_range_2_tr");
  func_897E();
  if(getdvarint("986", 0) == 0) {
    maps\mp\gametypes\_hub_unk1::func_4F45("mp_hub_spawn_5_tr");
    func_897F();
    maps\mp\gametypes\_hub_unk1::func_4F45("mp_hub_main_2_tr");
    func_8980();
  }
}

func_897E() {}

func_897F() {
  thread func_530F();
  thread func_5311();
  thread func_5376();
  thread handlespecialeventents();
  thread theaterscreenswap();
}

func_8980() {
  thread func_5318();
}

func_529F() {
  level endon("game_ended");
  setdvarifuninitialized("hub_reveal_remove_nametags_on_kit", "");
  setdvarifuninitialized("hub_reveal_add_nametags_on_kit", "");
  level.var_7E3B = ["SHG-DKendall"];
  level thread func_63D6();
  level thread func_6364();
}

func_6363() {
  level endon("game_ended");
  while(getDvar("hub_reveal_add_capture_kit") == "") {
    wait(1);
  }

  var_00 = tolower(getDvar("hub_reveal_add_capture_kit"));
  if(!common_scripts\utility::func_0F79(level.var_7E3B, var_00)) {
    level.var_7E3B[level.var_7E3B.size] = var_00;
  }

  setDvar("hub_reveal_add_capture_kit", "");
  thread func_6363();
}

func_63D5() {
  level endon("game_ended");
  while(getDvar("hub_reveal_remove_capture_kit") == "") {
    wait(1);
  }

  var_00 = tolower(getDvar("hub_reveal_remove_capture_kit"));
  level.var_7E3B = common_scripts\utility::func_0F93(level.var_7E3B, var_00);
  setDvar("hub_reveal_remove_capture_kit", "");
  thread func_63D5();
}

func_63D6() {
  level endon("game_ended");
  while(getDvar("hub_reveal_remove_nametags_on_kit") == "") {
    wait(1);
  }

  var_00 = tolower(getDvar("hub_reveal_remove_nametags_on_kit"));
  foreach(var_02 in level.var_744A) {
    if(tolower(var_02.var_0109) == var_00) {
      var_02 maps\mp\gametypes\_hub_unk1::func_4D02();
      break;
    }
  }

  setDvar("hub_reveal_remove_nametags_on_kit", "");
  thread func_63D6();
}

func_6364() {
  level endon("game_ended");
  while(getDvar("hub_reveal_add_nametags_on_kit") == "") {
    wait(1);
  }

  var_00 = tolower(getDvar("hub_reveal_add_nametags_on_kit"));
  foreach(var_02 in level.var_744A) {
    if(tolower(var_02.var_0109) == var_00) {
      var_02 maps\mp\gametypes\_hub_unk1::func_8BEB();
      break;
    }
  }

  setDvar("hub_reveal_add_nametags_on_kit", "");
  thread func_6364();
}

func_530F() {
  var_00 = getEntArray("animated_soldier", "targetname");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_0165)) {
      var_02.var_00B9 = var_02.var_0165;
    }

    if(isDefined(var_02.var_0106)) {
      var_02.var_18A8 = var_02.var_0106;
    }

    var_02 maps\mp\gametypes\_hub_unk1::func_8627();
    if(isDefined(var_02.var_0EA4)) {
      if(var_02.var_0EA4 == "mp_hub_reading_a_guy01") {
        var_02 attach("cob_book_01", "tag_weapon_right");
      }

      if(var_02.var_0EA4 == "mp_hub_conversation_c_guy02") {
        var_02 attach("npc_usa_m1garand_base", "tag_weapon_right");
      }

      if(var_02.var_0EA4 == "mp_hub_cleaning_rifle_guy01") {
        var_03 = spawn("script_model", (0, 0, 0));
        var_03 setModel("npc_usa_m1garand_base");
        var_03 hidepart("tag_clip_extmag");
        var_03 linkto(var_02, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
      }

      var_02 thread func_71FE();
    }

    wait 0.05;
  }
}

func_772F(param_00, param_01) {}

func_92B9() {
  var_00 = common_scripts\utility::func_46B5("baseball_scripted_node", "targetname");
  func_772F("baseball_scripted_node", var_00);
  var_01 = spawn("script_model", var_00.var_0116);
  var_01 maps\mp\gametypes\_hub_unk1::func_8627();
  var_02 = spawn("script_model", var_00.var_0116);
  var_02 maps\mp\gametypes\_hub_unk1::func_8627();
  var_03 = spawn("script_model", var_00.var_0116);
  var_03 setModel("mp_hub_baseball_glove_01");
  var_03 linkto(var_01, "tag_weapon_left", (0, 0, 0), (0, 0, 0));
  var_04 = spawn("script_model", var_00.var_0116);
  var_04 setModel("mp_hub_baseball_glove_01");
  var_04 linkto(var_02, "tag_weapon_left", (0, 0, 0), (0, 0, 0));
  var_05 = spawn("script_model", (0, 0, 0));
  var_05 setModel("mp_hub_baseball_01");
  var_05 linkto(var_01, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  var_03 scriptmodelplayanim("mp_hub_baseball_guy1_glove");
  var_04 scriptmodelplayanim("mp_hub_baseball_guy2_glove");
  var_05 scriptmodelplayanim("mp_hub_baseball");
  var_01 method_8495("mp_hub_baseball_guy1", var_00.var_0116, var_00.var_001D);
  var_02 method_8495("mp_hub_baseball_guy2", var_00.var_0116, var_00.var_001D);
}

func_92E3() {
  var_00 = common_scripts\utility::func_46B5("knife_thrower_scripted_node", "targetname");
  func_772F("knife_thrower_scripted_node", var_00);
  var_01 = spawn("script_model", var_00.var_0116);
  var_01 setModel("usa_hubd_org1");
  var_01 maps\mp\gametypes\_hub_unk1::func_8627();
  var_02 = spawn("script_model", var_00.var_0116);
  var_02 setModel("npc_usa_combat_knife");
  var_02 linkto(var_01, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  var_01 method_8495("mp_hub_knife_throw_idle", var_00.var_0116, var_00.var_001D);
  var_02 scriptmodelplayanim("mp_hub_knife");
}

func_92FE() {
  var_00 = common_scripts\utility::func_46B5("scripted_node_requisitions_background", "targetname");
  func_772F("scripted_node_requisitions_background", var_00);
  var_01 = spawn("script_model", var_00.var_0116);
  var_01 maps\mp\gametypes\_hub_unk1::func_8627();
  var_02 = spawn("script_model", var_00.var_0116);
  var_02 maps\mp\gametypes\_hub_unk1::func_8627();
  var_03 = spawn("script_model", var_00.var_0116);
  var_03 maps\mp\gametypes\_hub_unk1::func_8627();
  var_04 = spawn("script_model", var_00.var_0116);
  var_04 maps\mp\gametypes\_hub_unk1::func_8627();
  var_05 = spawn("script_model", var_00.var_0116);
  var_05 maps\mp\gametypes\_hub_unk1::func_8627();
  var_06 = spawn("script_model", var_00.var_0116);
  var_06 setModel("usa_phone_ee8");
  var_07 = spawn("script_model", var_00.var_0116);
  var_07 setModel("usa_phone_ee8");
  var_08 = spawn("script_model", var_00.var_0116);
  var_08 setModel("usa_phone_ee8");
  var_09 = spawn("script_model", var_00.var_0116);
  var_09 maps\mp\gametypes\_hub_unk1::func_8627();
  var_0A = spawn("script_model", var_00.var_0116);
  var_0A maps\mp\gametypes\_hub_unk1::func_8627();
  var_01 method_8495("mp_hub_ro_radio_guy_01_idle", var_00.var_0116, var_00.var_001D);
  var_02 method_8495("mp_hub_ro_radio_guy_02_idle", var_00.var_0116, var_00.var_001D);
  var_03 method_8495("mp_hub_ro_radio_guy_03_idle", var_00.var_0116, var_00.var_001D);
  var_04 method_8495("mp_hub_ro_phone_guy_01_idle", var_00.var_0116, var_00.var_001D);
  var_05 method_8495("mp_hub_ro_phone_guy_02_idle", var_00.var_0116, var_00.var_001D);
  var_06 method_8495("mp_hub_ro_phone_guy_01_idle_phone", var_00.var_0116, var_00.var_001D);
  var_07 method_8495("mp_hub_ro_phone_guy_02_idle_phone", var_00.var_0116, var_00.var_001D);
  var_08 method_8495("mp_hub_ro_phone_guy_03_idle_phone", var_00.var_0116, var_00.var_001D);
  var_09 method_8495("mp_hub_ro_teletype_guy_01_idle", var_00.var_0116, var_00.var_001D);
  var_0A method_8495("mp_hub_ro_teletype_guy_02_idle", var_00.var_0116, var_00.var_001D);
}

func_64A6() {
  var_00 = getent("firing_range_wall", "targetname");
  var_01 = getent("firing_range_wall_clip", "targetname");
  var_02 = common_scripts\utility::func_46B5("firing_range_wall_position", "targetname");
  var_03 = common_scripts\utility::func_46B5("firing_range_wall_door_position", "targetname");
  var_04 = spawn("script_model", var_02.var_0116);
  var_04 clonebrushmodeltoscriptmodel(var_00);
  var_05 = spawn("script_model", var_02.var_0116);
  var_05 clonebrushmodeltoscriptmodel(var_01);
  var_06 = spawn("script_model", var_03.var_0116);
  var_06 setModel("ndy_door_bunker_01");
  var_06.var_001D = (0, 180, 0);
  level.var_3C41 = 1;
  level thread func_6397(var_04, var_05, var_06);
}

func_6397(param_00, param_01, param_02) {
  level waittill("delete_fr_wall");
  param_00 delete();
  param_01 delete();
  param_02 delete();
  level.var_3C41 = 0;
}

func_5311() {
  level endon("game_ended");
}

func_749F() {
  playFXOnTag(common_scripts\utility::func_44F5("npc_footstep_spawner"), self, "J_Ankle_LE");
  playFXOnTag(common_scripts\utility::func_44F5("npc_footstep_spawner"), self, "J_Ankle_RI");
}

func_71FE() {
  wait(randomfloatrange(0.01, 3));
  self scriptmodelplayanim(self.var_0EA4);
}

func_5319() {
  level endon("game_ended");
  wait(5);
  var_00 = common_scripts\utility::func_46B5("animated_truck_scripted_node", "targetname");
  var_01 = common_scripts\utility::func_46B7("animated_truck_spawner", "targetname");
  foreach(var_03 in var_01) {
    if(isDefined(var_03.var_0EA4)) {
      var_03 thread func_9151(var_00);
    }

    wait 0.05;
  }
}

func_9151(param_00) {
  level endon("game_ended");
  if(!isDefined(param_00)) {
    return;
  }

  for(;;) {
    var_01 = spawn("script_model", self.var_0116);
    var_01 setModel("vehicle_usa_trans_cckw_base_hub");
    var_01.var_001D = self.var_001D;
    var_01.var_01A5 = "truck";
    var_01 method_8495(self.var_0EA4, param_00.var_0116, param_00.var_001D, "animEnded");
    var_01 lib_0378::func_8D74("truck_grp_a_moving");
    var_02 = spawn("script_model", (0, 0, 0));
    var_02.var_001D = self.var_001D;
    var_02 maps\mp\gametypes\_hub_unk1::func_8627();
    switch (self.var_0EA4) {
      case "mp_hub_beach_road_truck_a":
        var_03 = "mp_hub_beach_road_truck_driver_a";
        break;

      case "mp_hub_beach_road_truck_b":
        var_03 = "mp_hub_beach_road_truck_driver_b";
        break;

      case "mp_hub_beach_road_truck_c":
        var_03 = "mp_hub_beach_road_truck_driver_c";
        break;

      case "mp_hub_beach_road_truck_d":
        var_03 = "mp_hub_beach_road_truck_driver_d";
        break;

      default:
        var_03 = "";
        break;
    }

    var_02 method_8495(var_03, param_00.var_0116, param_00.var_001D, "animEnded");
    var_02.var_01A5 = "truckDriver";
    var_01 thread maps\mp\gametypes\_hub_unk1::func_2DD4("animEnded");
    var_02 thread maps\mp\gametypes\_hub_unk1::func_2DD4("animEnded");
    wait(47.5);
  }
}

func_9152() {
  level endon("game_ended");
  var_00 = 2;
  var_01 = 0;
  while(var_01 < var_00) {
    var_02 = spawn("script_model", self.var_0116);
    var_02 setModel("vehicle_usa_trans_cckw_base_hub");
    var_02.var_001D = self.var_001D;
    var_02.var_01A5 = "truck";
    var_02 method_8278(self.var_0EA4);
    playFXOnTag(common_scripts\utility::func_44F5("ambient_truck_tread_sand"), var_02, "tag_origin");
    var_03 = spawn("script_model", var_02.var_0116);
    var_03 maps\mp\gametypes\_hub_unk1::func_8627();
    var_03.var_001D = var_02.var_001D;
    var_03 method_8278("generic_land_driver_idle");
    var_03.var_01A5 = "truckDriver";
    var_03 method_8449(var_02, "tag_origin", (38, 10, 42), (0, 0, 0));
    var_01++;
    wait(95);
  }
}

func_4AF6() {
  level waittill("connected");
  wait 0.05;
  if(level.var_4F50) {
    return;
  }

  wait(1);
  while(!isDefined(level.var_781C)) {
    wait(1);
  }

  var_00 = common_scripts\utility::func_46B5("animated_truck_spawner_spawn_1", "targetname");
  var_01 = common_scripts\utility::func_46B5("animated_truck_spawner_spawn_2", "targetname");
  var_02 = spawn("script_model", var_00.var_0116);
  var_02 setModel("vehicle_usa_trans_cckw_base_hub");
  var_02.var_001D = var_00.var_001D;
  playFXOnTag(common_scripts\utility::func_44F5("ambient_truck_tread_sand"), var_02, "tag_origin");
  var_03 = spawn("script_model", var_00.var_0116);
  var_03 maps\mp\gametypes\_hub_unk1::func_8627();
  var_03.var_001D = var_00.var_001D;
  var_03 method_8278("generic_land_driver_idle");
  var_03 method_8449(var_02, "tag_origin", (38, 10, 42), (0, 0, 0));
  var_04 = spawn("script_model", var_01.var_0116);
  var_04 setModel("vehicle_usa_trans_cckw_base_hub");
  var_04.var_001D = var_01.var_001D;
  playFXOnTag(common_scripts\utility::func_44F5("ambient_truck_tread_sand"), var_04, "tag_origin");
  var_05 = spawn("script_model", var_01.var_0116);
  var_05 maps\mp\gametypes\_hub_unk1::func_8627();
  var_05.var_001D = var_01.var_001D;
  var_05 method_8278("generic_land_driver_idle");
  var_05 method_8449(var_04, "tag_origin", (38, 10, 42), (0, 0, 0));
  var_02 thread func_4AF5("mp_hub_beach_road_truck_f", var_00);
  var_04 thread func_4AF5("mp_hub_beach_road_truck_e", var_01);
  lib_0378::func_8D74("truck_grp_b_moving", var_02, var_04);
  level.var_781C.var_0EAC["mp_hub_quarter_master_twitch_a"] = spawnStruct();
  level.var_781C.var_0EAC["mp_hub_quarter_master_twitch_a"].var_3F02 = ::maps\mp\gametypes\_hub_unk1::func_83DE;
  level.var_781C.var_0EAC["mp_hub_quarter_master_twitch_a"].var_0F5D = [var_02, "truckDrive", var_04, "truckDrive"];
  level.var_781C.var_0EAC["mp_hub_quarter_master_coffee_twitch_a"] = spawnStruct();
  level.var_781C.var_0EAC["mp_hub_quarter_master_coffee_twitch_a"].var_3F02 = ::maps\mp\gametypes\_hub_unk1::func_83DE;
  level.var_781C.var_0EAC["mp_hub_quarter_master_coffee_twitch_a"].var_0F5D = [var_02, "truckDrive", var_04, "truckDrive"];
}

func_4AF5(param_00, param_01) {
  level endon("game_ended");
  for(;;) {
    self waittill("truckDrive");
    self scriptmodelclearanim();
    self.var_0116 = param_01.var_0116;
    self.var_001D = param_01.var_001D;
    self method_8278(param_00, "animEnded");
  }
}

func_5337() {
  var_00 = common_scripts\utility::func_46B5("qmAnimEvent", "targetname");
  var_01 = spawn("script_model", (0, 0, 0));
  var_01 setModel("usa_hube_org1");
  var_01 method_8495("mp_hub_qm_load_box_qm_private_idle", var_00.var_0116, var_00.var_001D);
  wait(20);
  var_02 = spawn("script_model", (0, 0, 0));
  var_02 setModel("hub_lootcrate_a");
  var_02 method_8495("mp_hub_qm_load_box_crate", var_00.var_0116, var_00.var_001D);
  var_01 method_8495("mp_hub_qm_load_box_private", var_00.var_0116, var_00.var_001D);
  var_03 = spawn("script_model", (0, 0, 0));
  var_03 setModel("usa_huba_org1");
  var_03 method_8495("mp_hub_qm_load_box_truck_guy", var_00.var_0116, var_00.var_001D);
  var_03 = spawn("script_model", (0, 0, 0));
  var_03 setModel("vehicle_usa_trans_cckw_base_hub");
  var_03 method_8495("mp_hub_qm_load_box_truck", var_00.var_0116, var_00.var_001D);
  var_03 lib_0378::func_8D74("truck_load");
}

func_5318() {
  var_00 = getEntArray("animated_blimp", "targetname");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_0EA4)) {
      var_02 thread func_71FE();
    }

    wait 0.05;
  }
}

func_4ABF() {
  level endon("game_ended");
  setdvarifuninitialized("hub_fr_wall", 0);
  level.var_3C41 = 0;
  if(getdvarint("986", 0) == 1) {
    thread func_64A6();
  }
}

handlespecialeventents() {
  wait 0.05;
  if(getdvarint("spv_hub_zombie_siege_event_enabled", 0) == 1) {
    var_00 = function_021F("scriptable pigeons", "targetname");
    if(isDefined(var_00)) {
      foreach(var_02 in var_00) {
        var_02 delete();
      }
    }

    var_04 = function_021F("scriptable vista flag", "targetname");
    if(isDefined(var_04)) {
      foreach(var_02 in var_04) {
        var_02 delete();
      }
    }
  }
}

inithubholidayspawns() {
  var_00 = spawn("script_model", (-182, 827.5, -23.5));
  var_00.var_001D = (0, 0, 0);
  var_00 setModel("foliage_s2_nor_spruce_tree_med_02");
}

initresistancedevices() {
  level endon("game_ended");
  if(getdvarint("spv_hub_resistance_event_enabled") == 1 && isDefined(level.devicesbegintrigger) && isDefined(level.deviceinteract)) {
    level.devicesbegintrigger sethintstring(&"HUB_DEVICES_01");
    level.deviceinteract sethintstring(&"HUB_DEVICES_02");
    for(;;) {
      level.devicesbegintrigger waittill("trigger", var_00);
      if(isPlayer(var_00)) {
        thread begindevicesequence();
        common_scripts\utility::func_9D9F("resistance_discoverable_begin", "targetname");
      }

      level.devicesbegintrigger waittill("event_complete");
      common_scripts\utility::func_9DA3("resistance_discoverable_begin", "targetname");
    }
  }
}

setupdevicestructs() {
  if(!isDefined(level.device01)) {
    level.device01 = spawnStruct();
  }

  level.device01.var_0116 = (-1518, 3728, -349.5);
  level.device01.var_001D = (0, 333.8, 0);
  level.devicestructs[0] = level.device01;
  if(!isDefined(level.device02)) {
    level.device02 = spawnStruct();
  }

  level.device02.var_0116 = (-1554, 3407.5, -304.8);
  level.device02.var_001D = (0, 77.6, 0);
  level.devicestructs[1] = level.device02;
  if(!isDefined(level.device03)) {
    level.device03 = spawnStruct();
  }

  level.device03.var_0116 = (-994.5, 3355.5, -309.5);
  level.device03.var_001D = (0, 139.3, 0);
  level.devicestructs[2] = level.device03;
  if(!isDefined(level.device04)) {
    level.device04 = spawnStruct();
  }

  level.device04.var_0116 = (-822, 2697, -390);
  level.device04.var_001D = (0, 125, 0);
  level.devicestructs[3] = level.device04;
  if(!isDefined(level.device05)) {
    level.device05 = spawnStruct();
  }

  level.device05.var_0116 = (-105.5, 3531, -321);
  level.device05.var_001D = (0, 180, 0);
  level.devicestructs[4] = level.device05;
  if(!isDefined(level.device06)) {
    level.device06 = spawnStruct();
  }

  level.device06.var_0116 = (738.5, 3073.5, -182);
  level.device06.var_001D = (0, 345, 0);
  level.devicestructs[5] = level.device06;
  if(!isDefined(level.device07)) {
    level.device07 = spawnStruct();
  }

  level.device07.var_0116 = (183, 3224, -252);
  level.device07.var_001D = (0, 281, 0);
  level.devicestructs[6] = level.device07;
  if(!isDefined(level.device08)) {
    level.device08 = spawnStruct();
  }

  level.device08.var_0116 = (-463.5, 3611, -311);
  level.device08.var_001D = (0, 308, 0);
  level.devicestructs[7] = level.device08;
  if(!isDefined(level.device09)) {
    level.device09 = spawnStruct();
  }

  level.device09.var_0116 = (-692.5, 3808.5, -341.3);
  level.device09.var_001D = (0, 170, 0);
  level.devicestructs[8] = level.device09;
  if(!isDefined(level.device10)) {
    level.device10 = spawnStruct();
  }

  level.device10.var_0116 = (-660, 3373.5, -313.3);
  level.device10.var_001D = (0, 36, 0);
  level.devicestructs[9] = level.device10;
  if(!isDefined(level.device11)) {
    level.device11 = spawnStruct();
  }

  level.device11.var_0116 = (-1556, 2323.5, -103);
  level.device11.var_001D = (0, 155, 0);
  level.devicestructs[10] = level.device11;
  if(!isDefined(level.device12)) {
    level.device12 = spawnStruct();
  }

  level.device12.var_0116 = (-511, 2332.5, -118);
  level.device12.var_001D = (1.23696, 172.769, 2.94067);
  level.devicestructs[11] = level.device12;
  if(!isDefined(level.device13)) {
    level.device13 = spawnStruct();
  }

  level.device13.var_0116 = (-1085.5, 2346, -1);
  level.device13.var_001D = (353.859, 359.145, 7.94397);
  level.devicestructs[12] = level.device13;
  if(!isDefined(level.device14)) {
    level.device14 = spawnStruct();
  }

  level.device14.var_0116 = (-174.5, 2578, -144);
  level.device14.var_001D = (341.999, 290.738, -18.5732);
  level.devicestructs[13] = level.device14;
  if(!isDefined(level.device15)) {
    level.device15 = spawnStruct();
  }

  level.device15.var_0116 = (-1183.5, 3884.5, -321);
  level.device15.var_001D = (0, 226, 0);
  level.devicestructs[14] = level.device15;
  if(!isDefined(level.device16)) {
    level.device16 = spawnStruct();
  }

  level.device16.var_0116 = (-1603.5, 1874.5, -104);
  level.device16.var_001D = (0, 132, 0);
  level.devicestructs[15] = level.device16;
  if(!isDefined(level.device17)) {
    level.device17 = spawnStruct();
  }

  level.device17.var_0116 = (-626, 1594.5, 59.8);
  level.device17.var_001D = (0, 322, 0);
  level.devicestructs[16] = level.device17;
  if(!isDefined(level.device18)) {
    level.device18 = spawnStruct();
  }

  level.device18.var_0116 = (265.5, 1718, 3.9);
  level.device18.var_001D = (0, 253.7, 0);
  level.devicestructs[17] = level.device18;
  if(!isDefined(level.device19)) {
    level.device19 = spawnStruct();
  }

  level.device19.var_0116 = (-531, 793.5, 7.7);
  level.device19.var_001D = (0, 127, 0);
  level.devicestructs[18] = level.device19;
  if(!isDefined(level.device20)) {
    level.device20 = spawnStruct();
  }

  level.device20.var_0116 = (416.5, 597.5, 7.2);
  level.device20.var_001D = (0, 215.9, 0);
  level.devicestructs[19] = level.device20;
}

begindevicesequence() {
  level endon("game_ended");
  setupdevicestructs();
  iprintln(&"HUB_DEVICES_03");
  var_00 = [];
  var_01 = 0;
  var_02 = 10;
  for(var_03 = 0; var_03 < var_02; var_03++) {
    var_04 = common_scripts\utility::func_7A33(level.devicestructs);
    var_00[var_03] = var_04;
    level.devicestructs = common_scripts\utility::func_0F93(level.devicestructs, var_04);
  }

  foreach(var_06 in var_00) {
    level.deviceinteract thread devicetimeout();
    level.deviceinteract.var_0116 = var_06.var_0116;
    var_07 = spawn("script_model", var_06.var_0116);
    var_07.var_001D = var_06.var_001D;
    var_07 setModel("hub_resistance_device_radio");
    var_07 method_8617("mp_hammerhead_morse_lp");
    playFXOnTag(common_scripts\utility::func_44F5("hub_resistance_radio_ping"), var_07, "tag_origin");
    var_08 = level.deviceinteract common_scripts\utility::func_A715("timed_out", "trigger");
    if(var_08 == "timed_out") {
      playsoundatpos(var_07.var_0116, "mp_ui_resistance_decoder_shutoff");
      var_07 delete();
      var_01 = 0;
      break;
    } else {
      var_01++;
      if(var_01 != var_02) {
        iprintln(&"HUB_DEVICES_04");
      }

      level.deviceinteract notify("decoded");
      playFX(common_scripts\utility::func_44F5("hub_resistance_radio_ping"), var_07.var_0116);
      playsoundatpos(var_07.var_0116, "mp_ui_resistance_decoder_shutoff");
      var_07 delete();
    }
  }

  if(var_01 == var_02) {
    iprintln(&"HUB_DEVICES_05");
    level.deviceinteract.var_0116 = (-936, 4228, -544);
    thread spawnresistancebomber();
    wait(120);
  } else {
    iprintln(&"HUB_DEVICES_06");
  }

  level.deviceinteract.var_0116 = (-936, 4228, -544);
  level.devicesbegintrigger notify("event_complete");
}

devicetimeout() {
  level endon("game_ended");
  self endon("decoded");
  wait(20);
  self notify("timed_out");
}

spawnresistancebomber() {
  var_00 = getent("resistance_plane_spawn", "targetname");
  var_01 = spawn("script_model", var_00.var_0116);
  var_01.var_001D = (0, 90, 0);
  var_01 setModel("usa_bomber_commando_vista");
  var_01 method_8278("mp_hub_resistance_bomber");
  var_01 lib_0378::func_8D74("res_bomber_flyby_start");
  wait(20);
  if(isDefined(var_01)) {
    var_01 delete();
  }
}

monitorresistancebomber() {
  level endon("game_ended");
  while(getdvarint("hub_complete_device_sequence", 0) == 0) {
    wait(1);
  }

  spawnresistancebomber();
  setDvar("hub_complete_device_sequence", 0);
  thread monitorresistancebomber();
}

theaterscreenswap() {
  var_00 = getdvarint("spv_hub_cwl_theater_screen", 0);
  if(var_00 == 0) {
    return;
  }

  if(!level.var_0148 && !level.var_0149) {
    return;
  }

  var_01 = "hub_theatre_screen_card_foreground";
  switch (var_00) {
    case 1:
      var_01 = "hub_theatre_screen_foreground_cwl";
      break;

    case 2:
      var_01 = "hub_theatre_screen_foreground_cwl_championship";
      break;

    case 3:
      var_01 = "hub_theatre_screen_foreground_cwl_atlanta";
      break;

    case 4:
      var_01 = "hub_theatre_screen_foreground_cwl_birmingham";
      break;

    case 5:
      var_01 = "hub_theatre_screen_foreground_cwl_seattle";
      break;

    case 6:
      var_01 = "hub_theatre_screen_foreground_cwl_anaheim";
      break;

    default:
      break;
  }

  var_02 = getent("theater_screen_foreground", "targetname");
  var_02 delete();
  var_03 = spawn("script_model", (-1516.1, 2098.48, -21));
  var_03 setModel(var_01);
  var_03.var_001D = (0, 85.4998, 0);
}

func_5376() {
  wait 0.05;
  thread func_52C5();
  thread func_5355();
  thread func_5298();
  thread func_5324();
  thread func_535F();
  thread func_52BA();
}

func_52C5() {
  var_00 = getent("hq_zone_trigger", "targetname");
  level.var_ACBC = var_00;
  level.var_ACBC thread maps\mp\_dynamic_world::func_9DC3(::func_4F46, ::func_4F47);
}

func_5298() {
  var_00 = getent("beach_zone_trigger", "targetname");
  level.var_ACBA = var_00;
  level.var_ACBA thread maps\mp\_dynamic_world::func_9DC3(::func_4F46, ::func_4F47);
}

func_5355() {
  var_00 = getent("spawn_zone_trigger", "targetname");
  level.var_ACBF = var_00;
  level.var_ACBF thread maps\mp\_dynamic_world::func_9DC3(::func_4F46, ::func_4F47);
}

func_5324() {
  var_00 = getent("offTower_zone_trigger", "targetname");
  level.var_ACBE = var_00;
  level.var_ACBE thread maps\mp\_dynamic_world::func_9DC3(::func_4F46, ::func_4F47);
}

func_535F() {
  var_00 = getent("theatre_zone_trigger", "targetname");
  level.var_ACC0 = var_00;
  level.var_ACC0 thread maps\mp\_dynamic_world::func_9DC3(::func_4F46, ::func_4F47);
}

func_52BA() {
  var_00 = getent("firingrange_zone_trigger", "targetname");
  level.var_ACBB = var_00;
  level.var_ACBB thread maps\mp\_dynamic_world::func_9DC3(::func_4F46, ::func_4F47);
}

func_4F46(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(isDefined(self.var_295A) && self.var_295A == param_00.var_01A5) {
    return;
  }

  if(!isDefined(self.var_56C8)) {
    self.var_56C8 = 0;
  }

  if(self.var_56C8) {
    wait(2.5);
    if(!param_00 method_858B(self.var_0116)) {
      return;
    }
  }

  self.var_295A = param_00.var_01A5;
  if(!self.var_572F) {
    maps\mp\gametypes\_hub_unk1::func_4F44(self.var_295A);
  }
}

func_4F47(param_00) {}