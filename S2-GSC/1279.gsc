/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1279.gsc
*********************************************/

func_5321() {
  level.var_79AE = spawnStruct();
  level.var_79AE.var_6948 = [];
  level.var_79AE.var_6E58 = [];
  level.var_695E = [];
  level.var_8D4 = [];
  level.var_8D1 = [];
  level.var_79AE.var_8DB = [];
  level.var_79AE.completedobjectives = [];
  level.var_79EE = [];
  level.var_79ED = [];
  level.var_7929 = [];
  level.var_79BE = [];
  level.raidhostageobjectivetrigger = [];
  level.var_79AF = [];
  level.var_3FCF = ::func_73E7;
  level.var_3FD0 = ::func_73E8;
  func_533E();
  func_5323();
}

func_5323() {
  var_00 = lib_0502::func_2548("captureObjective", ::func_1FBB);
  var_01 = var_00 lib_0502::func_2548("trigger", ::func_1FC2);
  var_01 lib_0502::func_2548("objective_icon");
  var_02 = var_00 lib_0502::func_2548("BorderVisualization_unoccupied", ::func_1FB4);
  var_03 = var_00 lib_0502::func_2548("BorderVisualization_blue", ::func_1FB4);
  var_04 = var_00 lib_0502::func_2548("BorderVisualization_enemy", ::func_1FB4);
  var_05 = var_00 lib_0502::func_2548("BorderVisualization_contested", ::func_1FB4);
  var_06 = var_00 lib_0502::func_2548("WorldVisualization_unoccupied", ::captureworldsetup);
  var_07 = var_00 lib_0502::func_2548("WorldVisualization_blue", ::captureworldsetup);
  var_08 = var_00 lib_0502::func_2548("WorldVisualization_enemy", ::captureworldsetup);
  var_09 = var_00 lib_0502::func_2548("WorldVisualization_contested", ::captureworldsetup);
  var_0A = var_00 lib_0502::func_2548("progress_mover", ::func_6955);
  var_0A lib_0502::func_2548("end", ::func_6954);
  var_0B = var_00 lib_0502::func_2548("zone_center_node", ::capturezonecenternodesetup);
  var_0C = lib_0502::func_2548("useHoldObjective", ::func_A211);
  var_01 = var_0C lib_0502::func_2548("trigger", ::func_A216);
  var_01 lib_0502::func_2548("objective_icon");
  var_02 = var_0C lib_0502::func_2548("visuals");
  var_0A = var_0C lib_0502::func_2548("progress_mover", ::func_6955);
  var_0A lib_0502::func_2548("end", ::func_6954);
  var_0D = var_0C lib_0502::func_2548("progress_animation", ::func_692E);
  var_0E = var_0D lib_0502::func_2548("show_ent", ::func_692F);
  var_0F = lib_0502::func_2548("useHoldBuildObjective", ::func_A210);
  var_01 = var_0F lib_0502::func_2548("build_trigger", ::func_1D5D);
  var_01 lib_0502::func_2548("objective_icon");
  var_10 = var_0F lib_0502::func_2548("build_object", ::func_1D4F);
  var_11 = var_0F lib_0502::func_2548("build_object_remove", ::func_1D55);
  var_12 = var_0F lib_0502::func_2548("objective_model", ::func_1D52);
  var_13 = var_0F lib_0502::func_2548("nonobjective_model", ::func_1D4E);
  var_14 = var_0F lib_0502::func_2548("remove_piece", ::func_1D59);
  var_0D = var_0F lib_0502::func_2548("progress_animation", ::func_692E);
  var_0E = var_0D lib_0502::func_2548("show_ent", ::func_692F);
  var_15 = lib_0502::func_2548("escortObjective", ::func_3859);
  var_16 = var_15 lib_0502::func_2548("vehicle", ::func_386F);
  var_01 = var_16 lib_0502::func_2548("escort_trigger", ::func_3872);
  var_01 lib_0502::func_2548("objective_icon");
  var_17 = var_16 lib_0502::func_2548("repair_trigger", ::func_3869);
  var_18 = var_16 lib_0502::func_2548("turret_trigger", ::func_3873);
  var_19 = var_16 lib_0502::func_2548("linkToVehicle", ::func_385B);
  var_15 = lib_0502::func_2548("escortContinueObjective", ::func_3855);
  var_1A = lib_0502::func_2548("bombObjective", ::func_18F7);
  var_01 = var_1A lib_0502::func_2548("trigger", ::func_190C);
  var_01 lib_0502::func_2548("bomb_model", ::func_18F3);
  var_01 lib_0502::func_2548("objective_icon");
  var_01 lib_0502::func_2548("objective_model", ::func_1902);
  var_01 lib_0502::func_2548("nonobjective_model", ::func_1901);
  var_01 lib_0502::func_2548("killcam_ent", ::func_1900);
  var_1B = lib_0502::func_2548("multiBombObjective", ::func_18F7);
  var_01 = var_1B lib_0502::func_2548("trigger", ::multibombtrigger);
  var_01 lib_0502::func_2548("bomb_model", ::func_18F3);
  var_01 lib_0502::func_2548("objective_icon");
  var_01 lib_0502::func_2548("objective_model", ::func_1902);
  var_01 lib_0502::func_2548("objective_model_destroyed", ::bombsiteobjectivemodeldestroyed);
  var_01 lib_0502::func_2548("nonobjective_model", ::func_1901);
  var_01 lib_0502::func_2548("killcam_ent", ::func_1900);
  var_1C = lib_0502::func_2548("defuseClusterObjective", ::func_2C9D);
  var_1D = lib_0502::func_2548("flagsObjective", ::lib_04FD::flagsobjectiveinit);
  var_1E = lib_0502::func_2548("dominationObjective", ::lib_04FC::func_3213);
  var_1F = lib_0502::func_2548("blitzObjective", ::func_17C5);
  var_01 = var_1F lib_0502::func_2548("trigger", ::func_17CF);
  var_01 lib_0502::func_2548("objective_icon");
  var_02 = var_1F lib_0502::func_2548("visuals");
  var_20 = lib_0502::func_2548("resupplyObjective", ::func_7E08);
  var_21 = var_20 lib_0502::func_2548("source", ::func_7E0F);
  var_21 lib_0502::func_2548("objective_icon");
  var_22 = var_21 lib_0502::func_2548("source_alt", ::func_7E09);
  var_23 = var_21 lib_0502::func_2548("drop", ::func_7E0B);
  var_24 = var_23 lib_0502::func_2548("visuals");
  var_25 = var_20 lib_0502::func_2548("source_pickup", ::func_7E0D);
  var_26 = var_25 lib_0502::func_2548("icon", ::func_7E0E);
  var_02 = var_25 lib_0502::func_2548("visuals");
  var_27 = var_20 lib_0502::func_2548("destination", ::func_7E05);
  var_27 lib_0502::func_2548("objective_icon");
  var_28 = var_27 lib_0502::func_2548("destination_alt", ::func_7E03);
  var_29 = lib_0502::func_2548("hostageObjective", ::hostageobjectiveinit);
  var_01 = var_29 lib_0502::func_2548("hostage_rescue_trigger", ::hostageobjectivetrigger);
  var_02 = var_01 lib_0502::func_2548("visuals");
  var_2A = var_01 lib_0502::func_2548("objective_icon");
  var_2B = var_29 lib_0502::func_2548("door_clip", ::hostagedoorclip);
  var_2B lib_0502::func_2548("door_trigger", ::hostagedoortriggeronce);
  var_2B lib_0502::func_2548("objective_icon");
  var_2B lib_0502::func_2548("open_pos", ::lib_0502::func_2080);
  var_2B lib_0502::func_2548("close_pos", ::lib_0502::func_2081);
  var_01 = var_29 lib_0502::func_2548("hostage_building_trigger", ::hostagebuildingtrigger);
  var_01 = var_29 lib_0502::func_2548("hostage_room_trigger");
  var_2C = lib_0502::func_2548("hotPotatoObjective", ::maps\mp\gametypes\_raid_objective_hot_potato::hotpotatoobjectiveinit);
  var_2D = var_2C lib_0502::func_2548("hotPotatoPickupZone", ::maps\mp\gametypes\_raid_objective_hot_potato::hotpotatopickupzonetrigger);
  var_2E = var_2C lib_0502::func_2548("hotPotatoCatchZone", ::maps\mp\gametypes\_raid_objective_hot_potato::hotpotatocatchtrigger);
  var_2F = var_2E lib_0502::func_2548("hotPotatoDeliverZone", ::maps\mp\gametypes\_raid_objective_hot_potato::hotpotatodelivertrigger);
  var_30 = lib_0502::func_2548("secureDropsObjective", ::maps\mp\gametypes\_raid_objective_securedrops::securedropsobjectiveinit);
  var_30 lib_0502::func_2548("drop_site", ::maps\mp\gametypes\_raid_objective_securedrops::securedropssite);
  initobjectivetypescont();
}

initobjectivetypescont() {
  var_00 = lib_0502::func_2548("relayObjective", ::lib_04FB::func_28AD);
  var_01 = var_00 lib_0502::func_2548("relayDeliveryZone", ::lib_04FB::func_289E);
  var_02 = var_01 lib_0502::func_2548("relayPickupZone", ::lib_04FB::func_28B5);
  var_03 = var_02 lib_0502::func_2548("relayItem_Model", ::lib_04FB::func_28B6);
  var_04 = var_02 lib_0502::func_2548("objective_model", ::lib_04FB::func_7C19);
  var_05 = var_02 lib_0502::func_2548("nonobjective_model", ::lib_04FB::func_7C18);
  var_06 = lib_0502::func_2548("safeObjective", ::maps\mp\gametypes\_raid_objective_opensafe::safeobjectiveinit);
  var_07 = var_06 lib_0502::func_2548("safeDeliveryZone", ::maps\mp\gametypes\_raid_objective_opensafe::safedelivertrigger);
  var_08 = var_07 lib_0502::func_2548("safeContainerTrigger", ::maps\mp\gametypes\_raid_objective_opensafe::safecontainertrigger);
  var_09 = var_08 lib_0502::func_2548("safePickupZone", ::maps\mp\gametypes\_raid_objective_opensafe::safepickupzonetrigger);
  var_0A = var_09 lib_0502::func_2548("safeItem_Model", ::maps\mp\gametypes\_raid_objective_opensafe::saferelayitem);
  var_0B = var_09 lib_0502::func_2548("objective_model", ::maps\mp\gametypes\_raid_objective_opensafe::safe_relayobjectivemodel);
  var_0C = var_09 lib_0502::func_2548("nonobjective_model", ::maps\mp\gametypes\_raid_objective_opensafe::safe_relaynonobjectivemodel);
  var_0D = lib_0502::func_2548("defuseObjective", ::func_2CA1);
  var_0E = var_0D lib_0502::func_2548("trigger", ::func_2CAA);
  var_0E lib_0502::func_2548("bomb_model", ::func_2C94);
  var_0E lib_0502::func_2548("objective_icon");
  var_0E lib_0502::func_2548("objective_model", ::func_2C97);
  var_0E lib_0502::func_2548("nonobjective_model", ::func_2C96);
  var_0F = maps\mp\_utility::func_4571();
  if(var_0F == "mp_raid_d_day" || var_0F == "mp_raid_dlc2" || var_0F == "mp_raid_dlc3") {
    lib_04F5::func_533B();
  } else {
    maps\mp\gametypes\_raid_damageobjective_raven::func_533B();
  }

  maps\mp\gametypes\_raid_objective_deathmatch::initraiddeathmatchobjectives();
  var_10 = lib_0502::func_2548("multipleObjective", ::func_651D);
  var_11 = lib_0502::func_2548("airdrop_target", ::func_692B);
  var_12 = lib_0502::func_2548("objective_zone", ::func_6985);
}

func_6972(param_00) {
  level notify("objectiveStart", param_00);
  var_01 = common_scripts\utility::func_46B5(param_00, "targetname");
  level.var_79AE.var_8DB = common_scripts\utility::func_F6F(level.var_79AE.var_8DB, var_01);
  var_01.var_6974 = gettime();
  common_scripts\utility::func_3C8F(func_6973(param_00));
  lib_0502::func_697F(param_00);
}

func_6935(param_00) {
  level notify("objectiveComplete", param_00);
  var_01 = common_scripts\utility::func_46B5(param_00, "targetname");
  level.var_79AE.var_8DB = common_scripts\utility::func_F93(level.var_79AE.var_8DB, var_01);
  level.var_79AE.completedobjectives = common_scripts\utility::func_F6F(level.var_79AE.completedobjectives, var_01);
  var_01.var_693F = gettime();
  lib_0502::func_697A(param_00);
  common_scripts\utility::func_3C8F(func_6937(param_00));
  level.var_A239 = 0;
}

func_5761(param_00) {
  return common_scripts\utility::func_3C77(func_6937(param_00));
}

func_6983(param_00) {
  if(!common_scripts\utility::func_3C77(func_6973(param_00))) {
    level waittillmatch(param_00, "objectiveStart");
  }
}

func_6982(param_00) {
  if(!common_scripts\utility::func_3C77(func_6937(param_00))) {
    level waittillmatch(param_00, "objectiveComplete");
  }
}

func_6973(param_00) {
  return "raid_obj_start_" + param_00;
}

func_6937(param_00) {
  return "raid_obj_complete_" + param_00;
}

func_6934(param_00) {
  self.var_695A = self.var_1A5;
  self.var_6956 = [];
  self.var_692D = [];
  self.var_6967 = [];
  self.var_6940 = ::func_2BCF;
  var_01 = [5, 4, 3, 2, 1];
  func_6961("OvertimeDurationArray", var_01);
  common_scripts\utility::func_3C87(func_6973(self.var_695A));
  common_scripts\utility::func_3C87(func_6937(self.var_695A));
  level.var_79AF[self.var_165] = 1;
  lib_0502::func_697C(self.var_695A);
}

func_2BCF() {
  var_00 = lib_0502::func_207C("objective_icon");
  return var_00[0];
}

func_6942(param_00) {
  param_00.var_695A = self.var_1A5;
  param_00.var_79AD = self;
}

func_6955(param_00) {
  param_00.var_9255 = param_00.var_116;
  param_00.var_9189 = param_00.var_1D;
  self.var_6956[self.var_6956.size] = param_00;
}

func_6954(param_00) {
  if(!isDefined(param_00.var_1D)) {
    param_00.var_1D = (0, 0, 0);
  }

  param_00.var_982E.var_4800 = param_00;
}

func_6B5D(param_00, param_01, param_02) {
  if(param_02 == 0) {
    func_6957();
    return;
  }

  func_6958();
}

func_6958() {
  if(self.var_A22B < 0) {
    var_00 = self.var_28D5 / abs(self.var_A22B);
  } else {
    var_00 = self.var_A23F - self.var_28D5 / self.var_A22B;
  }

  var_01 = gettime() + var_00;
  foreach(var_03 in self.var_79AD.var_6956) {
    if(isDefined(var_03.var_480D) && var_03.var_480D == var_01) {
      continue;
    }

    if(self.var_A22B < 0) {
      var_04 = var_03.var_9255;
      var_05 = var_03.var_9189;
    } else {
      var_04 = var_03.var_4800.var_116;
      var_05 = var_03.var_4800.var_1D;
    }

    var_03.var_480D = var_01;
    if(var_03.var_116 != var_04) {
      var_03 moveto(var_04, var_00 / 1000);
    }

    if(anglesdelta(var_03.var_1D, var_05) > 1) {
      var_03 rotateto(var_05, var_00 / 1000);
    }
  }
}

func_6957() {
  foreach(var_01 in self.var_79AD.var_6956) {
    if(!isDefined(var_01.var_480D)) {
      continue;
    }

    var_01.var_480D = undefined;
    var_01 moveto(var_01.var_116, 0.05);
    var_01 rotateto(var_01.var_1D, 0.05);
  }
}

func_692E(param_00) {
  var_01["mp_raid_breakable_wall"] = "mp_raids_wall_full_repair";
  var_01["mp_raid_bridge_01_a"] = "mp_raids_bridge_assemble_a";
  var_01["mp_raid_bridge_01_b"] = "mp_raids_bridge_assemble_b";
  var_02["mp_raid_breakable_wall"] = % mp_raids_wall_full_repair;
  if(isDefined(level.modeltoanimrefmapfunc)) {
    var_02 = [[level.modeltoanimrefmapfunc]](var_02);
  }

  var_03["mp_raid_bridge_01_a"] = "mp_raids_bridge_idle_a";
  var_03["mp_raid_bridge_01_b"] = "mp_raids_bridge_idle_b";
  var_04 = [];
  var_04["mp_raid_bridge_01_a"] = 1;
  var_04["mp_raid_bridge_01_b"] = 1;
  var_05 = func_45D1(self.var_695A, "modelNotetrackFuncs", []);
  param_00.var_67B3 = var_05[param_00.var_106];
  param_00.var_8BF7 = [];
  param_00.var_9222 = common_scripts\utility::func_562E(var_04[param_00.var_106]);
  if(param_00.var_9222) {
    param_00 hideallparts();
  }

  param_00.var_692C = var_01[param_00.var_106];
  param_00.var_6932 = var_02[param_00.var_106];
  param_00.var_6969 = var_03[param_00.var_106];
  precachempanim(param_00.var_692C);
  if(isDefined(param_00.var_6969)) {
    precachempanim(param_00.var_6969);
  }

  self.var_692D[self.var_692D.size] = param_00;
}

func_692F(param_00) {
  var_01 = param_00.var_982E;
  if(var_01.var_9222) {
    param_00 lib_0502::func_7997();
  }

  var_02 = tolower(param_00.var_8260);
  if(!isDefined(var_01.var_8BF7[var_02])) {
    var_01.var_8BF7[var_02] = [];
  }

  var_03 = var_01.var_8BF7[var_02].size;
  var_01.var_8BF7[var_02][var_03] = param_00;
}

func_694D(param_00) {
  thread func_694E(param_00);
}

func_694E(param_00) {
  param_00 endon("stop_objectiveModelsAnimateOnBeginUse");
  param_00 endon("disconnect");
  while(isDefined(self.var_A248) && param_00 getcurrentweapon() != self.var_A248) {
    wait 0.05;
    waittillframeend;
  }

  waittillframeend;
  func_6951();
}

func_694F(param_00, param_01, param_02) {
  if(isDefined(param_01)) {
    param_01 notify("stop_objectiveModelsAnimateOnBeginUse");
  }

  if(maps\mp\gametypes\_gameobjects::func_45D4(self) == 0) {
    func_6950();
    return;
  }

  func_6951();
}

func_6951() {
  var_00 = self.var_28D5 / self.var_A23F;
  var_00 = var_00 * 0.9999;
  foreach(var_02 in self.var_79AD.var_692D) {
    var_03 = getanimlength(var_02.var_6932);
    var_04 = getanimlength(var_02.var_6932) * 1000;
    var_05 = var_04 / self.var_A23F * maps\mp\gametypes\_gameobjects::func_45D4(self);
    var_02 func_6952(var_02.var_692C, var_00 * var_03, var_05);
  }
}

func_6950() {
  foreach(var_01 in self.var_79AD.var_692D) {
    if(isDefined(var_01.var_6969)) {
      var_01 func_6952(var_01.var_6969);
      continue;
    }

    var_01 scriptmodelpauseanim(1);
  }
}

func_6952(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  self scriptmodelplayanim(param_00, "objective_anim", param_01, param_02);
  thread func_6930();
}

func_6930() {
  self notify("objectiveAnimNotetracks");
  self endon("objectiveAnimNotetracks");
  for(;;) {
    self waittill("objective_anim", var_00);
    thread func_6931(var_00);
    if(var_00 == "end") {
      break;
    }
  }
}

func_6931(param_00) {
  var_01 = self;
  var_02 = 0;
  var_03 = strtok(param_00, " ");
  while(var_02 < var_03.size) {
    var_04 = var_03[var_02];
    if(isDefined(var_01.var_67B3)) {
      var_05 = [[var_01.var_67B3]](var_02, var_03);
      if(var_05 > 0) {
        var_02 = var_02 + var_05;
        continue;
      }
    }

    switch (var_04) {
      case "hide_part":
        var_02++;
        var_04 = var_03[var_02];
        var_01 hidepart(var_04);
        var_06 = var_01.var_8BF7[var_04];
        if(isDefined(var_06)) {
          foreach(var_08 in var_06) {
            var_08 lib_0502::func_7997();
          }
        }
        break;

      case "show_part":
        var_02++;
        var_04 = var_03[var_02];
        var_01 showpart(var_04);
        var_06 = var_01.var_8BF7[var_04];
        if(isDefined(var_06)) {
          foreach(var_08 in var_06) {
            var_08 lib_0502::func_79C6();
          }
        }
        break;

      case "end":
        break;

      default:
        break;
    }

    var_02++;
  }
}

func_6981(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_01)) {
    param_01 = "active";
  }

  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(!isDefined(param_03)) {
    param_03 = 1;
  }

  if(param_03 && isDefined(level.var_7919)) {
    thread[[level.var_7919]](param_00, param_01, param_04);
  }

  if(param_02) {
    func_79B1(param_00);
    level.var_A239 = 0;
  }
}

func_692B(param_00) {
  if(!isDefined(self.var_B82)) {
    self.var_B82 = [];
  }

  if(!isDefined(self.var_982E)) {
    return;
  }

  self.var_B82[self.var_B82.size] = param_00;
  lib_0502::func_697D(self.var_982E.var_1A5, param_00);
}

func_6985(param_00) {
  if(!isDefined(self.var_982E)) {
    return;
  }

  lib_0502::func_697E(self.var_982E.var_1A5, param_00);
}

func_6965(param_00, param_01, param_02) {
  func_6960(param_00, param_01, 0, param_02);
}

func_6963(param_00, param_01, param_02) {
  func_6960(param_00, param_01, 1, param_02);
}

func_6966(param_00, param_01, param_02) {
  func_6960(param_00, param_01, 2, param_02);
}

func_6962(param_00, param_01) {
  func_6960(param_00, !!param_01, 3, [0, 1]);
}

func_6961(param_00, param_01) {
  func_6960(param_00, param_01, 4);
}

func_6964(param_00, param_01) {
  func_6960(param_00, param_01, 5);
}

func_6960(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.var_109 = param_00;
  var_04.var_1B9 = param_02;
  if(!isDefined(param_03)) {
    param_03 = [param_01];
  } else if(!isarray(param_03)) {
    param_03 = [param_03];
  }

  if(param_02 != 4) {
    if(!isDefined(common_scripts\utility::func_F7E(param_03, param_01))) {
      param_03[param_03.size] = param_01;
    }
  }

  var_04.var_7597 = param_03;
  var_04.var_A281 = func_45D1(self.var_695A, param_00, param_01);
  var_04.var_2BD8 = var_04.var_A281;
  self.var_6967[param_00] = var_04;
}

func_45D0(param_00) {
  var_01 = self.var_6967[param_00];
  var_02 = var_01.var_A281;
  return var_02;
}

func_45D1(param_00, param_01, param_02) {
  var_03 = level.var_79AE.var_6E58[param_00];
  if(!isDefined(var_03)) {
    return param_02;
  }

  var_04 = var_03[param_01];
  if(!isDefined(var_04)) {
    return param_02;
  }

  return var_04;
}

func_86DA(param_00, param_01, param_02) {
  if(!isDefined(level.var_79AE.var_6E58[param_00])) {
    level.var_79AE.var_6E58[param_00] = [];
  }

  level.var_79AE.var_6E58[param_00][param_01] = param_02;
}

func_17C5(param_00) {
  func_6934(self);
  func_6965("numCapturesTotal", 15, [5, 10, 15, 20, 25, 30]);
  func_6965("numCapturesCurrent", 0, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
  func_6963("captureTimeSec", 0, undefined);
  func_6962("allowReversal", 0);
  func_6962("restockAfterCap", 1);
  func_6963("captureDelay", 1.5, [0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5]);
  func_6965("captureCooldown", 0, [1, 2, 3, 4, 5]);
}

func_17CF(param_00) {
  var_01 = func_45CE(param_00);
  var_02 = maps\mp\gametypes\_gameobjects::func_2837(game["attackers"], param_00, self.var_982D["visuals"], var_01, 0, 1);
  func_6942(var_02);
  var_02 maps\mp\gametypes\_gameobjects::func_2F93();
  var_02.var_931A = "";
  var_02 func_17C7("enemyOwns");
  var_02 maps\mp\gametypes\_gameobjects::func_86CD(0);
  var_02.var_6BBF = undefined;
  func_6983(self.var_1A5);
  var_03 = func_45D0("captureTimeSec");
  var_02 maps\mp\gametypes\_gameobjects::func_365D();
  var_02 maps\mp\gametypes\_gameobjects::func_8A5A(var_03);
  var_02 maps\mp\gametypes\_gameobjects::func_8A59(&"MP_CAPTURING_OBJECTIVE");
  var_02.var_59DD = 1;
  var_02.var_502A = "raidZoneProxBlitz";
  var_02.var_681A = 1;
  var_02.var_7765 = 0;
  var_02 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_02 maps\mp\gametypes\_gameobjects::func_86CD(1);
  var_02 maps\mp\gametypes\_gameobjects::func_1F49(0);
  var_02.var_76EB = 0;
  var_02.var_76E3 = 0;
  var_02.var_76E4 = 0;
  var_02.var_2652 = 0;
  self.var_17C3 = var_02;
  level.var_8D1 = var_02;
  level.var_695E[level.var_695E.size] = ::func_1FBC;
  var_02 func_0990(var_02.var_28D4 + var_02.var_6A1D, undefined, undefined, 1000, 1, 0, 1);
  var_02 thread func_17C9();
  thread func_17C1(var_02);
  func_6982(self.var_1A5);
  self notify("end_hud");
  foreach(var_05 in self.var_982D["visuals"]) {
    var_05 delete();
  }

  var_02 func_7CCA();
  var_02 maps\mp\gametypes\_gameobjects::func_2D58();
}

func_17C9() {
  self endon("deleted");
  level endon("game_ended");
  for(;;) {
    self.var_9D65 waittill("trigger", var_00);
    if(!isalive(var_00)) {
      continue;
    }

    if(function_01EF(var_00)) {
      continue;
    }

    if(var_00.var_12C["team"] != game["attackers"]) {
      continue;
    }

    if(self.var_2652 == 1) {
      continue;
    }

    if(!isDefined(var_00.var_1FC5)) {
      var_00.var_1FC5 = 0;
    }

    if(var_00.var_1FC5 == 1) {
      continue;
    }

    thread func_17CA(var_00, self.var_79AD func_45D0("captureDelay"));
  }
}

func_17CA(param_00, param_01) {
  self endon("deleted");
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 endon("joined_team");
  param_00 endon("joined_spectators");
  level endon("game_ended");
  level endon("blitz_objective_cooldown_start");
  var_02 = 0;
  var_03 = 0.05;
  param_00 thread func_17CB();
  param_00.var_1FC5 = 1;
  for(;;) {
    if(!param_00 istouching(self.var_9D65)) {
      param_00 notify("raid_blitz_left_trigger");
      break;
    }

    if(!isDefined(param_00.var_17CC)) {
      param_00 thread func_17CD();
    }

    if(param_01 == 0) {
      var_02 = 1;
      break;
    }

    param_01 = param_01 - var_03;
    wait 0.05;
  }

  if(var_02) {
    level thread maps\mp\_utility::func_9863("raids_callout_capture", param_00);
    param_00 notify("raid_blitz_score");
    thread func_17CE(param_00, 0, self.var_79AD func_45D0("restockAfterCap"));
    self.var_79AD.var_6967["numCapturesCurrent"].var_A281++;
    if(self.var_79AD func_45D0("numCapturesCurrent") >= self.var_79AD func_45D0("numCapturesTotal")) {
      func_6935(self.var_695A);
    } else {
      lib_04F3::raidmusiconteam("attackers", "stinger_pos", "stinger_neg");
    }

    if(self.var_79AD func_45D0("captureCooldown") != 0) {
      thread func_17C4(self.var_79AD func_45D0("captureCooldown"));
    }
  }

  param_00.var_1FC5 = 0;
}

func_17CB() {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("raid_blitz_score");
  if(!isDefined(self.var_1FC5)) {
    self.var_1FC5 = 0;
  }

  self waittill("death");
  self.var_1FC5 = 0;
}

func_17C4(param_00) {
  self endon("deleted");
  level endon("game_ended");
  self.var_2652 = 1;
  level notify("blitz_objective_cooldown_start");
  wait(param_00);
  level notify("blitz_objective_cooldown_end");
  self.var_2652 = 0;
}

func_17C7(param_00) {
  if(self.var_931A == param_00) {
    return;
  }

  self.var_931A = param_00;
  switch (self.var_931A) {
    case "enemyOwns":
      maps\mp\gametypes\_gameobjects::func_C30("friendly");
      func_860B("waypoint_hardpoint_neutral_map", "waypoint_hardpoint_ally_map");
      break;

    case "unoccupied":
      func_6957();
      maps\mp\gametypes\_gameobjects::func_C30("any");
      func_860B("waypoint_hardpoint_neutral_map", "waypoint_hardpoint_ally_map");
      break;

    case "taking":
      maps\mp\gametypes\_gameobjects::func_C30("any");
      func_860B("waypoint_hardpoint_ally_map", "waypoint_hardpoint_enemy_map");
      break;

    case "contested":
      func_6957();
      maps\mp\gametypes\_gameobjects::func_C30("any");
      func_860B("waypoint_hardpoint_contested_map", "waypoint_hardpoint_contested_map");
      break;

    case "losing":
      maps\mp\gametypes\_gameobjects::func_C30("any");
      func_860B("waypoint_hardpoint_enemy_map", "waypoint_hardpoint_ally_map");
      break;

    default:
      break;
  }
}

func_17CE(param_00, param_01, param_02) {
  var_03 = lib_050D::func_44F9(game["attackers"]);
  foreach(var_05 in var_03) {
    if(var_05.var_165 == "axis_override") {
      var_03 = common_scripts\utility::func_F93(var_03, var_05);
    }
  }

  var_07 = common_scripts\utility::func_7A33(var_03);
  wait(param_01);
  thread[[level.var_17C8]](param_00.var_116, param_00.var_1D, param_00 getstance(), game["attackers"], param_00.var_267E);
  param_00 func_17C6(var_07.var_116, var_07.var_1D);
}

func_17C6(param_00, param_01) {
  self endon("disconnect");
  var_02 = (0, 0, self getviewheight());
  var_03 = spawn("script_model", self.var_116 + var_02);
  var_03.var_1D = self.var_1D;
  var_03.var_116 = self.var_116 + var_02;
  var_03 setModel("tag_player");
  self method_81E2(var_03, "tag_player");
  self setorigin(param_00);
  self setangles(param_01);
  self setstance("stand");
  self method_8003();
  self method_8322();
  playfxontagforclients(common_scripts\utility::func_44F5("divisions_bayonet_charge"), self, "j_head", self);
  var_03 moveto(param_00 + var_02, 3, 0, 1.5);
  var_03 rotateto(param_01, 3, 0, 1.5);
  var_03 waittill("movedone");
  self method_81E3();
  function_0294(common_scripts\utility::func_44F5("divisions_bayonet_charge"), self, "j_head", self);
  self method_8004();
  self method_8323();
  var_03 delete();
}

func_17CD() {
  self endon("disconnect");
  var_00 = 0.2;
  if(isDefined(self.var_17CC)) {
    self notify("cancelBlitzOverlayHide");
  } else {
    self.var_17CC = newclienthudelem(self);
    self.var_17CC.maxsightdistsqrd = 0;
    self.var_17CC.var_1D7 = 0;
    self.var_17CC.ignoreme = -5;
    self.var_17CC.var_C6 = "fullscreen";
    self.var_17CC.var_1CA = "fullscreen";
    self.var_17CC setshader("overlay_raid_officer_orders", 640, 480);
    self.var_17CC.var_C2 = 1;
    self.var_17CC.var_180 = 0;
    self.var_17CC.var_18 = 0;
  }

  self.var_17CC fadeovertime(var_00);
  self.var_17CC.var_18 = 1;
  common_scripts\utility::knock_off_battery("death", "raid_blitz_score", "raid_blitz_left_trigger");
  func_17C0();
}

func_17C0() {
  self endon("death");
  self endon("disconnect");
  self endon("cancelBlitzOverlayHide");
  var_00 = 0.2;
  if(!isDefined(self.var_17CC)) {
    return;
  }

  self.var_17CC fadeovertime(var_00);
  self.var_17CC.var_18 = 0;
  wait(var_00);
  if(!isDefined(self.var_17CC)) {
    return;
  }

  self.var_17CC destroy();
}

func_4F5E(param_00) {
  self endon("death");
  wait(param_00);
  self destroy();
}

func_17C1(param_00) {
  var_01 = func_6939();
  var_01.var_E5 = &"RAIDS_CAPTURE_BAR";
  var_02 = func_6938();
  var_03 = undefined;
  var_04 = undefined;
  var_05 = func_45D0("allowReversal");
  if(var_05) {
    var_03 = maps\mp\gametypes\_hud_util::func_282A("white", 3, 15);
    var_03 maps\mp\gametypes\_hud_util::func_8707("LEFTTOP", undefined, 65, 190);
    var_04 = maps\mp\gametypes\_hud_util::func_282A("white", 3, 15);
    var_04 maps\mp\gametypes\_hud_util::func_8707("LEFTTOP", undefined, 115, 190);
  }

  func_17C2(var_02, var_01);
  param_00 func_7CCA();
  var_02 maps\mp\gametypes\_hud_util::func_2DCC();
  var_01 maps\mp\gametypes\_hud_util::func_2DCC();
  if(var_05) {
    var_03 maps\mp\gametypes\_hud_util::func_2DCC();
    var_04 maps\mp\gametypes\_hud_util::func_2DCC();
  }
}

func_17C2(param_00, param_01) {
  self endon("end_hud");
  for(;;) {
    var_02 = clamp(func_45D0("numCapturesCurrent") / func_45D0("numCapturesTotal"), 0, 1);
    func_A177(param_01, var_02);
    func_A0E4(param_00, var_02);
    wait 0.05;
  }
}

func_7E08(param_00) {
  if(!func_694B()) {
    level.var_611["objective_resupply_death"] = loadfx("vfx/test/raid/objective_resupply_death");
  }

  func_6934(self);
  self.var_8F50 = [];
  self.var_2DAA = [];
  self.var_2DAB = [];
  func_6963("sourceUseTimeSec", 1, [0, 1, 2, 3, 4, 5]);
  func_6963("destUseTimeSec", 2, [0, 1, 2, 3, 4, 5]);
  func_6963("useCount", 10, [1, 2, 3, 4, 5, 10, 15, 20]);
  func_6963("pickUpResetTime", 20, [5, 10, 15, 20, 25, 30]);
  func_6963("pickUpHealth", 30, [0, 10, 20, 30, 40, 50]);
  func_6962("expendPickups", 0);
  thread func_7E07();
}

func_7E07() {
  func_6983(self.var_695A);
  foreach(var_01 in self.var_2DAB) {
    var_02 = func_6939();
    switch (var_01.var_E5) {
      case "_a":
        var_02.var_E5 = &"RAIDS_RESUPPLY_BAR_FUEL_A";
        break;

      case "_b":
        var_02.var_E5 = &"RAIDS_RESUPPLY_BAR_FUEL_B";
        break;

      case "_c":
        var_02.var_E5 = &"RAIDS_RESUPPLY_BAR_FUEL_C";
        break;

      default:
        var_02.var_E5 = &"RAIDS_RESUPPLY_BAR_FUEL";
        break;
    }

    func_A177(var_02, 0);
    var_03 = func_6938();
    var_01.var_4F78 = var_02;
    var_01.var_4F68 = var_03;
  }

  func_6982(self.var_695A);
  wait(1);
  foreach(var_01 in self.var_2DAB) {
    var_01.var_4F78 maps\mp\gametypes\_hud_util::func_2DCC();
    var_01.var_4F68 maps\mp\gametypes\_hud_util::func_2DCC();
  }
}

func_7E0C(param_00) {
  param_00 maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_take");
  param_00 maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_take");
  param_00 maps\mp\gametypes\_gameobjects::func_860A("enemy", "waypoint_defend");
  param_00 maps\mp\gametypes\_gameobjects::func_860E("enemy", "waypoint_defend");
}

func_7E0F(param_00) {
  param_00.var_8F4F = [];
  var_01 = func_45CE(param_00);
  var_02 = func_7E0A(param_00, var_01);
  var_02.var_7703 = var_02;
  param_00.var_7703 = var_02;
  var_02 func_7E0C(var_02);
  thread func_7E10(var_02);
}

func_7E09(param_00) {
  var_01 = func_7E0A(param_00);
  var_01.var_7703 = param_00.var_982E.var_7703;
  thread func_7E10(var_01);
}

func_7E0A(param_00, param_01) {
  var_02 = [];
  var_03 = !func_4B7C(param_00);
  var_04 = maps\mp\gametypes\_gameobjects::func_2837(game["attackers"], param_00, var_02, param_01, !isDefined(param_01), 1);
  self.var_8F50[self.var_8F50.size] = var_04;
  func_6942(var_04);
  var_05 = func_45D0("sourceUseTimeSec");
  var_04 maps\mp\gametypes\_gameobjects::func_365D();
  var_04 maps\mp\gametypes\_gameobjects::func_8A5A(var_05);
  var_04 maps\mp\gametypes\_gameobjects::func_8A57(&"RAIDS_RESUPPLY_USE_SOURCE");
  var_04 maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_RESUPPLY_USING_SOURCE");
  var_04 maps\mp\gametypes\_gameobjects::func_C30("friendly");
  var_04.var_A23E = 14;
  var_04.var_6BBF = ::func_6BCA;
  var_04 maps\mp\gametypes\_gameobjects::func_2F93();
  return var_04;
}

func_7E10(param_00) {
  func_6983(self.var_695A);
  param_00 maps\mp\gametypes\_gameobjects::func_365D();
  func_6982(self.var_695A);
  param_00.var_9D65 delete();
  param_00 maps\mp\gametypes\_gameobjects::func_2D58();
}

func_7E0B(param_00) {
  var_01 = param_00.var_982E;
  var_02 = func_7E01(param_00, param_00.var_982D["visuals"]);
  var_02.var_8F54 = var_01;
  var_01.var_8F4F[var_01.var_8F4F.size] = var_02;
  thread func_7E02(var_02);
}

func_7E02(param_00) {
  waittillframeend;
  foreach(var_02 in self.var_2DAA) {
    var_02 func_09C2(var_02, param_00);
  }

  param_00 maps\mp\gametypes\_gameobjects::func_2F93();
  func_6983(self.var_695A);
  param_00 maps\mp\gametypes\_gameobjects::func_365D();
  func_6982(self.var_695A);
  if(!isDefined(param_00.var_695A)) {
    param_00 maps\mp\gametypes\_gameobjects::func_2F93();
  }
}

func_7E01(param_00, param_01) {
  var_02 = maps\mp\gametypes\_gameobjects::func_27D6(game["attackers"], param_00, param_01, (0, 0, 0), 0, 1);
  func_6942(var_02);
  var_02.var_C33 = 1;
  var_02.var_6B62 = ::func_6B65;
  var_02.var_6AEF = ::func_6AF1;
  var_02.var_6B63 = ::func_7E00;
  var_02.var_6BC2 = ::maps\mp\gametypes\_gameobjects::func_7E30;
  var_02.var_6B93 = ::func_6B95;
  var_02.var_138A = func_45D0("pickUpResetTime");
  var_02 maps\mp\gametypes\_gameobjects::func_8A57(&"RAIDS_RESUPPLY_USE_SOURCE");
  var_02 maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_RESUPPLY_USING_SOURCE_PICKUP");
  var_02 maps\mp\gametypes\_gameobjects::func_C30("friendly");
  var_02 func_6B95();
  foreach(var_04 in var_02.var_A582) {
    var_04 setCanDamage(1);
    var_04 setdamagecallbackon(1);
    var_04.var_29B5 = ::func_7E12;
    var_04.var_3FCA = var_02;
  }

  return var_02;
}

func_7E0D(param_00) {
  var_01 = func_7E01(param_00, param_00.var_982D["visuals"]);
  thread func_7E02(var_01);
}

func_7E0E(param_00) {
  var_01 = func_27DE(param_00.var_982E getentitynumber(), game["attackers"], param_00.var_116, (0, 0, 0));
  var_01 maps\mp\gametypes\_gameobjects::func_8A60("none");
  var_01 maps\mp\gametypes\_gameobjects::func_C30("friendly");
  func_7E0C(var_01);
  func_6983(self.var_695A);
  var_01 maps\mp\gametypes\_gameobjects::func_8A60("any");
  func_6982(self.var_695A);
  var_01 maps\mp\gametypes\_gameobjects::func_2D58();
}

func_6B65(param_00) {
  func_7DFD(param_00);
  param_00 iclientprintlnbold(&"RAIDS_RESUPPLY_USED_SOURCE");
}

func_6AF1(param_00) {
  func_7DFE(param_00);
  self.var_10F5 = 0;
}

func_6B95() {
  self.var_10F5 = 1;
  foreach(var_01 in self.var_A582) {
    var_01.var_FB = self.var_79AD func_45D0("pickUpHealth");
    var_01.var_6A = 0;
  }
}

func_7E13(param_00) {
  self endon("reset");
  self endon("pickup_object");
  param_00 setdamagecallbackon(1);
  param_00.var_29B5 = ::func_7E12;
}

func_7E12(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(self.var_3FCA.var_10F5) {
    return;
  }

  if(isDefined(param_01)) {
    param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard");
  }

  self.var_6A = self.var_6A + param_02;
  if(self.var_6A >= self.var_FB) {
    var_0C = self.var_116;
    self.var_3FCA maps\mp\gametypes\_gameobjects::func_7E30();
    playFX(common_scripts\utility::func_44F5("objective_resupply_death"), var_0C);
    var_0C = var_0C + (0, 0, 5);
    radiusdamage(var_0C, 200, 150, 50, param_01);
    physicsexplosionsphere(var_0C, 300, 50, 2);
  }
}

func_7DFD(param_00) {
  param_00.var_2015 = param_00 maps\mp\gametypes\_hud_util::func_280B("icon_raid_objective_resupply_carry", 50, 50);
  param_00.var_2015 maps\mp\gametypes\_hud_util::func_8707("BOTTOM LEFT", "BOTTOM LEFT", 0, -90);
}

func_7DFE(param_00) {
  if(isDefined(param_00.var_2015)) {
    param_00.var_2015 maps\mp\gametypes\_hud_util::func_2DCC();
  }
}

func_866E() {
  func_2DD1();
  return 1;
}

func_7E00(param_00) {
  param_00 iclientprintlnbold(&"RAIDS_RESUPPLY_CANT_USE_SOURCE");
}

func_7E11(param_00) {
  param_00 iclientprintlnbold(&"RAIDS_RESUPPLY_SOURCE_USED_UP");
}

func_6BCA(param_00) {
  if(isDefined(param_00.var_2016)) {
    func_7E00(param_00);
    return;
  }

  var_01 = self.var_7703;
  if(var_01.var_9D65.var_8F4F.size) {
    var_02 = undefined;
    foreach(var_04 in var_01.var_9D65.var_8F4F) {
      if(!isDefined(var_04.var_2006)) {
        var_02 = var_04;
        break;
      }
    }

    if(isDefined(var_02)) {
      var_02 maps\mp\gametypes\_gameobjects::func_86F9(param_00);
    } else {
      func_7E11(param_00);
      return;
    }
  } else {
    func_7E11(var_04);
    return;
  }

  param_00 iclientprintlnbold(&"RAIDS_RESUPPLY_USED_SOURCE");
}

func_7E05(param_00) {
  if(!isDefined(param_00.var_81E8)) {
    param_00.var_81E8 = "";
  }

  var_01 = func_45CE(param_00);
  var_02 = func_7E04(param_00, var_01);
  var_02.var_7703 = var_02;
  var_02.var_E5 = param_00.var_81E8;
  param_00.var_7703 = var_02;
  var_03 = 0;
  foreach(var_05 in self.var_2DAB) {
    if(common_scripts\utility::func_55AF(var_05.var_E5, var_02.var_E5)) {
      break;
    }

    var_03++;
  }

  self.var_2DAB = common_scripts\utility::func_F86(self.var_2DAB, var_02, var_03);
  var_02 maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_deliver" + var_02.var_E5);
  var_02 maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_deliver" + var_02.var_E5);
  var_02 maps\mp\gametypes\_gameobjects::func_860A("enemy", "waypoint_defend" + var_02.var_E5);
  var_02 maps\mp\gametypes\_gameobjects::func_860E("enemy", "waypoint_defend" + var_02.var_E5);
  var_02.var_A202 = 0;
  thread func_7E06(var_02);
}

func_7E03(param_00) {
  var_01 = func_7E04(param_00);
  var_01.var_7703 = param_00.var_982E.var_7703;
  thread func_7E06(var_01);
}

func_7E04(param_00, param_01) {
  var_02 = [];
  var_03 = maps\mp\gametypes\_gameobjects::func_2837(game["attackers"], param_00, var_02, param_01, !isDefined(param_01), 1);
  self.var_2DAA[self.var_2DAA.size] = var_03;
  func_6942(var_03);
  var_04 = func_45D0("destUseTimeSec");
  var_03 maps\mp\gametypes\_gameobjects::func_365D();
  var_03 maps\mp\gametypes\_gameobjects::func_8A5A(var_04);
  var_03 maps\mp\gametypes\_gameobjects::func_8A57(&"RAIDS_RESUPPLY_USE_DEST");
  var_03 maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_RESUPPLY_USING_DEST");
  var_03 maps\mp\gametypes\_gameobjects::func_86B5([]);
  var_03 maps\mp\gametypes\_gameobjects::func_C30("friendly");
  var_03.var_A23E = 15;
  var_03.var_6AC9 = ::func_6ACA;
  var_03.var_6BBF = ::func_6BC9;
  var_03 maps\mp\gametypes\_gameobjects::func_2F93();
  return var_03;
}

func_7E06(param_00) {
  func_6983(self.var_695A);
  param_00 maps\mp\gametypes\_gameobjects::func_365D();
  func_6982(self.var_695A);
  param_00.var_9D65 delete();
  param_00 maps\mp\gametypes\_gameobjects::func_2D58();
}

func_6ACA(param_00) {
  param_00 iclientprintlnbold(&"RAIDS_RESUPPLY_CANT_USE_DEST");
}

func_6BC9(param_00) {
  param_00 iclientprintlnbold(&"RAIDS_RESUPPLY_USED_DEST");
  var_01 = self.var_7703;
  var_02 = var_01.var_79AD func_45D0("useCount");
  var_03 = param_00.var_2016;
  param_00.var_2016[[param_00.var_2016.var_6BC2]]();
  if(var_01.var_79AD func_45D0("expendPickups")) {
    var_03.var_8F54.var_8F4F = common_scripts\utility::func_F93(var_03.var_8F54.var_8F4F, var_03);
    var_03 maps\mp\gametypes\_gameobjects::func_2D2F();
    maps\mp\_utility::func_2D4F(var_03);
    if(var_03.var_8F54.var_8F4F.size <= 0) {
      var_03.var_8F54.var_7703 maps\mp\gametypes\_gameobjects::func_2F93();
    }
  }

  var_01.var_A202++;
  var_04 = clamp(var_01.var_A202 / var_02, 0, 1);
  func_A177(var_01.var_4F78, var_04);
  func_A0E4(var_01.var_4F68, var_04);
  if(var_04 >= 1) {
    func_6935(var_01.var_695A);
    level.var_256A = var_01;
  }
}

func_1FBB(param_00) {
  func_6934(self);
  func_6963("captureTimeSec", lib_0501::func_4647("capture_time"), [10, 15, 20, 30, 45, 60]);
  func_6965("allowReversal", lib_0501::func_4648("capture_reversable"), [0, 1]);
  func_6962("isSkirmishPoint", 0);
  func_6965("captureContestable", lib_0501::func_4648("capture_contestable"), [1, 0]);
  func_6962("isProtectPoint", 0);
}

func_1FC2(param_00) {
  func_6983(self.var_1A5);
  var_01 = undefined;
  if(common_scripts\utility::func_562E(self.var_651B)) {
    var_01 = self.var_81E1;
  }

  self.var_57AA = 0;
  var_02 = lib_0502::func_4518("capture_defend", var_01);
  var_03 = game["attackers"];
  if(isDefined(self.var_8260) && self.var_8260 == "reverse_capture") {
    self.var_57AA = 1;
    var_03 = game["defenders"];
    var_02 = 100;
  }

  var_04 = func_45CE(param_00);
  var_05 = [];
  var_06 = maps\mp\gametypes\_gameobjects::func_2837(var_03, param_00, var_05, var_04, 0, 1);
  func_6942(var_06);
  if(isDefined(var_01)) {
    var_06.var_6515 = var_01;
  }

  var_06.var_57AA = self.var_57AA;
  var_06 maps\mp\gametypes\_gameobjects::func_2F93();
  var_06.var_931A = "";
  var_06 func_1FBD("unoccupied");
  var_06 maps\mp\gametypes\_gameobjects::func_86CD(0);
  var_06.var_6BBF = undefined;
  var_07 = func_45D0("captureTimeSec");
  var_06.var_57D2 = func_45D0("isSkirmishPoint");
  var_06.isprotectpoint = func_45D0("isProtectPoint");
  var_06 maps\mp\gametypes\_gameobjects::func_365D();
  var_06 maps\mp\gametypes\_gameobjects::func_8A5A(var_07);
  var_06 maps\mp\gametypes\_gameobjects::func_8A59(&"MP_CAPTURING_OBJECTIVE");
  var_06.var_59DD = 1;
  var_06.var_502A = "raidZoneCaptureHP";
  var_06.var_681A = 1;
  var_06.var_7765 = 0;
  var_06 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_06 maps\mp\gametypes\_gameobjects::func_86CD(1);
  var_06 maps\mp\gametypes\_gameobjects::func_1F49(1);
  var_06.var_6BBF = ::func_6ACC;
  if(var_06.var_57D2) {
    var_06.var_6BCB = ::func_6BA3;
    var_06.var_6BBE = ::func_8C94;
  } else if(var_06.isprotectpoint) {
    var_06.var_6BCB = ::onprotectpointobjectiveuseupdate;
    var_06.var_6BBE = ::onprotectpointobjectiveupdateuserate;
    var_06.var_6AFA = ::onprotectpointenduse;
    var_06 maps\mp\gametypes\_gameobjects::cancapwithoutclaim(1);
    if(isDefined(level.commsguy)) {
      var_06.agenttoprotect = level.commsguy;
    }
  } else {
    var_06.var_6BCB = ::func_6ACD;
    var_06.var_6BBE = ::func_6ACB;
  }

  var_06.var_76EB = 0;
  var_06.var_76E3 = 0;
  var_06.var_76E4 = 0;
  self.var_1FBA = var_06;
  param_00.var_1FBA = var_06;
  level.var_8D1[level.var_8D1.size] = var_06;
  if(!common_scripts\utility::func_F79(level.var_695E, ::func_1FBC)) {
    level.var_695E[level.var_695E.size] = ::func_1FBC;
  }

  if(var_06.isprotectpoint && isDefined(var_06.agenttoprotect)) {
    var_06 func_0990(var_06.agenttoprotect, undefined, (0, 0, 100), var_07 * 1000, var_02, 0, 1);
  } else {
    var_06 func_0990(var_06.var_28D4 + var_06.var_6A1D, undefined, undefined, var_07 * 1000, var_02, 0, 1);
  }

  var_06 thread func_1FBE();
  func_6982(self.var_1A5);
  level.var_8D1 = common_scripts\utility::func_F93(level.var_8D1, var_06);
  if(level.var_8D1.size == 0) {
    level.var_695E = common_scripts\utility::func_F93(level.var_695E, ::func_1FBC);
  }

  lib_04F7::func_5A4F(param_00.var_116, 750);
  lib_04F7::func_2F99(param_00.var_116, 750);
  self notify("end_hud");
  if(isDefined(self.var_1921)) {
    foreach(var_09 in self.var_1921) {
      var_09 delete();
    }
  }

  var_06 func_7CCA();
  var_06 maps\mp\gametypes\_gameobjects::func_2F93();
  var_06 maps\mp\gametypes\_gameobjects::deleteuseobjectobjectives();
  waittillframeend;
  var_06 maps\mp\gametypes\_gameobjects::func_2D58();
  param_00 delete();
}

func_1FBC(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = self;
  foreach(var_0C in level.var_8D1) {
    if(param_01 istouching(var_0C.var_9D65)) {
      if(param_01.var_1A7 == game["attackers"]) {
        param_01 thread maps\mp\_events::func_5A82(var_0A, param_09, param_04);
        param_01.var_62A1["assaultObjective"] = var_0C;
      }

      if(param_01.var_1A7 == game["defenders"]) {
        param_01 thread maps\mp\_events::func_2C80(var_0A, param_09, param_04);
        param_01.var_62A1["defendObjective"] = var_0C;
      }

      continue;
    }

    if(var_0A istouching(var_0C.var_9D65)) {
      param_01 thread maps\mp\gametypes\_missions::func_80BB(param_04, param_03);
      if(var_0A.var_1A7 == game["attackers"]) {
        param_01 thread maps\mp\_events::func_2C80(var_0A, param_09, param_04);
        param_01.var_62A1["defendObjective"] = var_0C;
      }

      if(var_0A.var_1A7 == game["defenders"]) {
        param_01 thread maps\mp\_events::func_10BA(var_0A, param_09, param_04);
        param_01.var_62A1["assaultObjective"] = var_0C;
      }
    }
  }
}

func_6ACC(param_00) {
  var_01 = param_00;
  var_02 = undefined;
  foreach(var_04 in self.var_9AC3[game["attackers"]]) {
    var_04.var_721C thread func_7935();
    param_00 notify("ch_capture", self);
    if(!isDefined(var_02) || var_04.var_9309 < var_02) {
      var_01 = var_04.var_721C;
      var_02 = var_04.var_9309;
    }
  }

  level thread maps\mp\_utility::func_9863("raids_callout_capture", var_01);
  func_6935(self.var_695A);
}

func_7935() {
  maps\mp\_utility::func_50EA("pointscaptured", 1);
  maps\mp\_utility::func_50E9("captures", 1);
  maps\mp\gametypes\_persistence::func_933A("round", "captures", self.var_12C["captures"]);
  level thread maps\mp\gametypes\_rank::func_1457("capture", self);
  maps\mp\gametypes\_missions::func_7750("ch_heroics_destroyer");
}

func_6ACB() {
  var_00 = game["attackers"];
  var_01 = game["defenders"];
  var_02 = self.var_79AD func_45D0("captureContestable");
  var_03 = self.var_79AD func_45D0("allowReversal");
  if(isDefined(self.var_57AA) && self.var_57AA) {
    var_00 = game["defenders"];
    var_01 = game["attackers"];
  }

  var_04 = self.var_689F[var_00];
  var_05 = self.var_689F[var_01];
  var_06[0] = 0;
  var_06[1] = 1;
  var_06[2] = 1.5;
  var_06[3] = 1.75;
  var_06[4] = 2;
  var_06[5] = 2.1;
  var_06[6] = 2.2;
  var_06[7] = 2.3;
  var_06[8] = 2.4;
  var_06[9] = 2.5;
  var_07[0] = 0;
  var_07[1] = -0.25;
  var_07[2] = -0.5;
  var_07[3] = -0.75;
  var_07[4] = -1;
  if(!var_02 && var_04) {
    var_05 = 0;
  }

  self.var_A22B = 0;
  self.var_915C = var_04 && var_05;
  if(var_04 && !var_05) {
    self.var_A22B = var_06[int(min(int(var_04), var_06.size - 1))];
  }

  if(!var_04 && var_05) {
    if((isDefined(self.var_7766) && self.var_28D5 == self.var_7766) || self.var_28D5 == 0) {
      self.var_A22B = 0;
    } else {
      self.var_A22B = var_07[int(min(int(var_05), var_07.size - 1))];
    }
  }

  func_1FBF(var_04, var_05);
  self.var_76EB = self.var_A22B;
  self.var_76E3 = var_04;
  self.var_76E4 = var_05;
}

func_1FBF(param_00, param_01) {
  var_02 = self.var_A23F - self.var_28D5;
  if(var_02 <= 0) {
    return;
  }

  var_03 = game["attackers"];
  var_04 = game["defenders"];
  if(isDefined(self.var_57AA) && self.var_57AA) {
    var_03 = game["defenders"];
    var_04 = game["attackers"];
  }

  if(self.var_A22B != self.var_76EB || self.var_76E3 != param_00 || self.var_76E4 != param_01) {
    if(self.var_A22B <= 0) {
      if(param_00 > 0 && param_01 > 0) {
        func_1FBD("contested");
        return;
      }

      if(param_01 > 0) {
        func_1FBD("losing");
        return;
      }

      func_1FBD("unoccupied");
      return;
    }

    func_1FBD("taking");
  }
}

func_8C94() {
  var_00[0] = 0;
  var_00[1] = 1;
  var_00[2] = 1.5;
  var_00[3] = 1.75;
  var_00[4] = 2;
  var_00[5] = 2.1;
  var_00[6] = 2.2;
  var_00[7] = 2.3;
  var_00[8] = 2.4;
  var_00[9] = 2.5;
  var_01[0] = 0;
  var_01[1] = 0.25;
  var_01[2] = 0.5;
  var_01[3] = 0.75;
  var_01[4] = 1;
  var_01[5] = 1.1;
  var_01[6] = 1.2;
  var_01[7] = 1.3;
  var_01[8] = 1.4;
  var_01[9] = 1.5;
  var_02 = game["attackers"];
  var_03 = maps\mp\_utility::func_45DE(var_02);
  var_04 = self.var_689F[var_02];
  var_05 = self.var_689F[var_03];
  if(level.var_3F9D) {
    self.var_A22B = 0;
  }

  if(var_05 > 0 && var_04 > 0) {
    if(var_04 >= var_05) {
      self.var_A22B = var_04 - var_05 / var_05 * 1 + 0.25;
    } else {
      self.var_A22B = var_05 - var_04 / var_04 * -0.5;
    }
  } else if(var_05 == 0) {
    self.var_A22B = var_00[var_04];
  } else if(var_04 == 0) {
    self.var_A22B = -1 * var_01[var_05];
  }

  func_8C93();
  self.var_76EB = self.var_A22B;
  self.var_76E3 = var_04;
  self.var_76E4 = var_05;
}

func_8C93() {
  var_00 = self.var_A23F - self.var_28D5;
  if(var_00 <= 0) {
    return;
  }

  if(self.var_A22B == 0) {
    func_1FBD("unoccupied");
    return;
  }

  if(self.var_A22B > 0) {
    func_1FBD("taking");
    return;
  }

  func_1FBD("losing");
}

func_6BA3(param_00, param_01, param_02) {
  self.var_4D04 = 0;
  if(self.var_230F != self.var_6DB2 && self.var_5B82 == self.var_230F) {
    self.var_28D5 = 0;
    func_6957();
    return;
  }

  func_6B5D(param_00, param_01, param_02);
}

func_6ACD(param_00, param_01, param_02) {
  self.var_4D04 = 0;
  var_03 = undefined;
  var_04 = self.var_79AD func_45D0("allowReversal");
  if(var_04) {
    if(self.var_7765 == 0 && param_01 >= 0.33) {
      self.var_7765 = 0.33;
      self.var_7766 = self.var_28D5;
    } else if(self.var_7765 == 0.33 && param_01 >= 0.66) {
      self.var_7765 = 0.66;
      self.var_7766 = self.var_28D5;
    }

    if(self.var_7765 == 0.33 && param_01 < 0.33) {
      self.var_28D5 = self.var_7766;
      self.var_4D04 = 1;
      param_02 = 0;
      var_03 = 1;
    } else if(self.var_7765 == 0.66 && param_01 < 0.66) {
      self.var_28D5 = self.var_7766;
      self.var_4D04 = 1;
      param_02 = 0;
      var_03 = 1;
    }
  } else if(self.var_7765 < self.var_28D5) {
    self.var_7765 = self.var_28D5;
  } else {
    self.var_28D5 = self.var_7765;
    self.var_4D04 = 1;
    param_02 = 0;
  }

  if(self.var_28D5 + param_02 <= 0) {
    self.var_28D5 = 0;
    func_6957();
    return;
  }

  if(param_02 <= 0) {
    func_6957();
    if(common_scripts\utility::func_562E(var_03)) {
      maps\mp\gametypes\_gameobjects::func_A18F();
      return;
    }

    return;
  }

  func_6B5D(param_00, param_01, param_02);
}

onprotectpointobjectiveupdateuserate() {
  var_00 = game["attackers"];
  var_01 = game["defenders"];
  if(!common_scripts\utility::func_3C77("commAgentDamaged") && self.var_76EB == 0 && self.var_230F == var_00) {
    self notify("hostilesNeutralized");
  }

  if(level.cappointagentactive && common_scripts\utility::func_3C77("capturePointShouldProgress")) {
    self.var_A22B = 1;
    func_1FBF(1, 0);
  } else {
    self.var_A22B = 0;
    func_1FBF(0, 0);
  }

  self.var_76EB = self.var_A22B;
}

onprotectpointobjectiveuseupdate(param_00, param_01, param_02) {
  var_03 = game["attackers"];
  var_04 = game["defenders"];
  self.var_4D04 = 0;
  var_05 = undefined;
  if(self.var_7765 < self.var_28D5) {
    self.var_7765 = self.var_28D5;
  } else {
    self.var_28D5 = self.var_7765;
    self.var_4D04 = 1;
    param_02 = 0;
  }

  if(self.var_28D5 + param_02 <= 0) {
    self.var_28D5 = 0;
    func_6957();
    return;
  }

  if(param_02 <= 0) {
    func_6957();
    if(self.var_689F[var_03] == 0 || self.var_689F[var_04] == 0) {
      maps\mp\gametypes\_gameobjects::func_A18F();
      return;
    }

    return;
  }

  func_6B5D(param_00, param_01, param_02);
}

onprotectpointenduse(param_00, param_01, param_02) {
  if(level.cappointagentactive && common_scripts\utility::func_3C77("capturePointShouldProgress")) {
    thread maintainprotectpointprogress();
  }
}

maintainprotectpointprogress() {
  self.var_28D5 = self.var_28D5 + 50 * self.var_A22B;
  if(self.var_28D5 <= 0) {
    self.var_28D5 = self.var_28D5 * -1;
    self.var_5B82 = self.var_230F;
    onprotectpointobjectiveupdateuserate();
  }

  if(isDefined(self.var_6BCB)) {
    onprotectpointobjectiveuseupdate(self.var_230F, self.var_28D5 / self.var_A23F, 50 * self.var_A22B / self.var_A23F);
  }

  wait 0.05;
  while(level.cappointagentactive && common_scripts\utility::func_3C77("capturePointShouldProgress") && self.var_230F == "none") {
    self.var_28D5 = self.var_28D5 + 50 * self.var_A22B;
    if(self.var_28D5 <= 0) {
      self.var_28D5 = self.var_28D5 * -1;
      self.var_5B82 = self.var_230F;
      onprotectpointobjectiveupdateuserate();
    }

    if(isDefined(self.var_6BCB)) {
      onprotectpointobjectiveuseupdate(self.var_230F, self.var_28D5 / self.var_A23F, 50 * self.var_A22B / self.var_A23F);
    }

    wait 0.05;
  }
}

func_1FBE() {
  self endon("deleted");
  var_00 = 0;
  var_01 = 0;
  var_02 = game["attackers"];
  var_03 = game["defenders"];
  if(isDefined(self.var_57AA) && self.var_57AA) {
    var_02 = game["defenders"];
    var_03 = game["attackers"];
  }

  var_04 = 4;
  var_05 = gettime();
  var_06 = [];
  for(;;) {
    var_07 = self.var_689F[var_02];
    var_08 = self.var_689F[var_03];
    if(var_07 && var_08 && self.var_79AD func_45D0("captureContestable")) {
      func_6981(self.var_695A);
      var_06 = [];
    } else if(var_07) {
      var_09 = "capturing";
      if(var_00 == 0 || var_01 != 0) {
        var_09 = "start_capture";
      }

      func_6981(self.var_695A, var_09);
      var_0A = [];
      foreach(var_0C in self.var_9AC3[game["attackers"]]) {
        var_0D = var_0C.var_721C;
        if(isDefined(var_06) && var_06.size > 0 && common_scripts\utility::func_F79(var_06, var_0D)) {
          if(!isDefined(var_0D.capturing_objective_time)) {
            var_0D.capturing_objective_time = 0;
          }

          var_0D.capturing_objective_time = var_0D.capturing_objective_time + gettime() - var_05;
          if(var_0D.capturing_objective_time >= var_04 * 1000) {
            if(var_0D maps\mp\_utility::func_649("specialty_improvedobjectives")) {
              lib_0502::raidawardsecuringobjectiveevent(var_0D);
            }

            var_0D.capturing_objective_time = 0;
          }
        }

        var_0A[var_0A.size] = var_0D;
      }

      var_06 = var_0A;
    } else {
      var_06 = [];
    }

    var_05 = gettime();
    var_00 = var_07;
    var_01 = var_08;
    wait 0.05;
  }
}

func_1FBD(param_00) {
  self.var_931A = param_00;
  var_01 = undefined;
  if(isDefined(self.var_6515)) {
    var_01 = self.var_6515;
  }

  switch (self.var_931A) {
    case "enemyOwns":
      maps\mp\gametypes\_gameobjects::func_C30("friendly");
      var_02 = lib_0502::func_4518("capture_defend_enemy", var_01);
      func_860A(var_02, var_01);
      func_8614(var_02);
      break;

    case "unoccupied":
      func_6957();
      maps\mp\gametypes\_gameobjects::func_C30("any");
      var_02 = lib_0502::func_4518("capture_defend", var_01);
      func_860A(var_02, var_01);
      func_8614(var_02);
      break;

    case "taking":
      maps\mp\gametypes\_gameobjects::func_C30("any");
      var_02 = lib_0502::func_4518("taking_losing", var_01);
      func_860A(var_02, var_01);
      func_8617("taking", var_02);
      break;

    case "contested":
      func_6957();
      maps\mp\gametypes\_gameobjects::func_C30("any");
      var_02 = lib_0502::func_4518("contested_contested_hp", var_01);
      func_860A(var_02, var_01);
      func_8614(var_02);
      break;

    case "losing":
      maps\mp\gametypes\_gameobjects::func_C30("any");
      var_02 = lib_0502::func_4518("capture_defend_enemy", var_01);
      func_860A(var_02, var_01);
      if(common_scripts\utility::func_562E(self.var_57D2) || self.var_79AD func_45D0("allowReversal") && self.var_A22B) {
        func_8617("losing", var_02);
      } else {
        func_8614(var_02);
      }
      break;

    default:
      break;
  }

  func_1FB5(param_00);
  captureworldvisualization(param_00);
}

func_73E7(param_00) {
  if(param_00 func_4B4D() && (isDefined(param_00.var_502A) && param_00.var_502A == "raidZoneCaptureHP" || param_00.var_502A == "raidEscortTrigger" || param_00.var_502A == "raidZoneCaptureTwar") || common_scripts\utility::func_562E(param_00.snapicon)) {
    param_00 func_8CFD(self);
  }
}

func_73E8(param_00) {
  if(!isDefined(self)) {
    return;
  }

  if(param_00 func_4B4D() && (isDefined(param_00.var_502A) && param_00.var_502A == "raidZoneCaptureHP" || param_00.var_502A == "raidEscortTrigger" || param_00.var_502A == "raidZoneCaptureTwar") || common_scripts\utility::func_562E(param_00.snapicon)) {
    param_00 func_A088(self);
  }
}

capturezonecenternodesetup(param_00) {
  self.zonecenternode = param_00;
}

func_1FB4(param_00) {
  lib_0502::func_2548(param_00.var_165);
  if(!isDefined(self.var_1921)) {
    self.var_1921 = [];
  }

  if(getdvarint("trailer_disable_borders", 0) > 0) {
    param_00.var_116 = param_00.var_116 + (0, 0, -1000);
    param_00 method_805C();
    return;
  }

  var_01 = game["attackers"];
  var_02 = game["defenders"];
  switch (param_00.var_165) {
    case "BorderVisualization_unoccupied":
      self.var_1921["unoccupied"] = param_00;
      self.var_1921["unoccupied"] thread lib_0502::func_8C21(var_01);
      break;

    case "BorderVisualization_blue":
      self.var_1921["friendly"] = param_00;
      self.var_1921["friendly"] thread lib_0502::func_8C21(var_02);
      break;

    case "BorderVisualization_enemy":
      self.var_1921["enemy"] = param_00;
      param_00 method_805C();
      break;

    case "BorderVisualization_contested":
      self.var_1921["contested"] = param_00;
      param_00 method_805C();
      break;
  }
}

func_1FB5(param_00) {
  if(!isDefined(self.var_79AD.var_1921)) {
    return;
  }

  foreach(var_02 in self.var_79AD.var_1921) {
    var_02 method_805C();
    var_02 notify("clear");
  }

  var_04 = game["attackers"];
  var_05 = game["defenders"];
  switch (param_00) {
    case "enemyOwns":
      self.var_79AD.var_1921["enemy"] thread lib_0502::func_8C21(var_04);
      self.var_79AD.var_1921["friendly"] thread lib_0502::func_8C21(var_05);
      break;

    case "unoccupied":
      self.var_79AD.var_1921["unoccupied"] thread lib_0502::func_8C21(var_04);
      self.var_79AD.var_1921["friendly"] thread lib_0502::func_8C21(var_05);
      break;

    case "taking":
      self.var_79AD.var_1921["friendly"] thread lib_0502::func_8C21(var_04);
      self.var_79AD.var_1921["enemy"] thread lib_0502::func_8C21(var_05);
      break;

    case "contested":
      self.var_79AD.var_1921["contested"] method_805B();
      break;

    case "losing":
      self.var_79AD.var_1921["enemy"] thread lib_0502::func_8C21(var_04);
      self.var_79AD.var_1921["friendly"] thread lib_0502::func_8C21(var_05);
      break;

    default:
      break;
  }
}

captureworldsetup(param_00) {
  lib_0502::func_2548(param_00.var_165);
  if(!isDefined(self.worldvisualizations)) {
    self.worldvisualizations = [];
  }

  if(!isDefined(self.worldvisualizationsunoccupied)) {
    self.worldvisualizationsunoccupied = [];
  }

  if(!isDefined(self.worldvisualizationsfriendly)) {
    self.worldvisualizationsfriendly = [];
  }

  if(!isDefined(self.worldvisualizationsenemy)) {
    self.worldvisualizationsenemy = [];
  }

  if(!isDefined(self.worldvisualizationscontested)) {
    self.worldvisualizationscontested = [];
  }

  if(getdvarint("trailer_disable_borders", 0) > 0) {
    param_00.var_116 = param_00.var_116 + (0, 0, -1000);
    param_00 method_805C();
    return;
  }

  var_01 = game["attackers"];
  var_02 = game["defenders"];
  switch (param_00.var_165) {
    case "WorldVisualization_unoccupied":
      self.worldvisualizationsunoccupied = common_scripts\utility::func_F6F(self.worldvisualizationsunoccupied, param_00);
      self.worldvisualizations["unoccupied"] = self.worldvisualizationsunoccupied;
      common_scripts\utility::func_FB2(self.worldvisualizations["unoccupied"], ::lib_0502::func_8C21, var_01);
      break;

    case "WorldVisualization_blue":
      self.worldvisualizationsfriendly = common_scripts\utility::func_F6F(self.worldvisualizationsfriendly, param_00);
      self.worldvisualizations["friendly"] = self.worldvisualizationsfriendly;
      common_scripts\utility::func_FB2(self.worldvisualizations["friendly"], ::lib_0502::func_8C21, var_02);
      break;

    case "WorldVisualization_enemy":
      self.worldvisualizationsenemy = common_scripts\utility::func_F6F(self.worldvisualizationsenemy, param_00);
      self.worldvisualizations["enemy"] = self.worldvisualizationsenemy;
      common_scripts\utility::func_F71(self.worldvisualizations["enemy"], ::method_805C);
      break;

    case "WorldVisualization_contested":
      self.worldvisualizationscontested = common_scripts\utility::func_F6F(self.worldvisualizationscontested, param_00);
      self.worldvisualizations["contested"] = self.worldvisualizationscontested;
      common_scripts\utility::func_F71(self.worldvisualizations["contested"], ::method_805C);
      break;
  }
}

captureworldvisualization(param_00) {
  if(!isDefined(self.var_79AD.worldvisualizations)) {
    return;
  }

  foreach(var_02 in self.var_79AD.worldvisualizations) {
    foreach(var_04 in var_02) {
      var_04 method_805C();
      var_04 notify("clear");
    }
  }

  var_07 = game["attackers"];
  var_08 = game["defenders"];
  switch (param_00) {
    case "enemyOwns":
      common_scripts\utility::func_FB2(self.var_79AD.worldvisualizations["enemy"], ::lib_0502::func_8C21, var_07);
      common_scripts\utility::func_FB2(self.var_79AD.worldvisualizations["friendly"], ::lib_0502::func_8C21, var_08);
      break;

    case "unoccupied":
      common_scripts\utility::func_FB2(self.var_79AD.worldvisualizations["unoccupied"], ::lib_0502::func_8C21, var_07);
      common_scripts\utility::func_FB2(self.var_79AD.worldvisualizations["friendly"], ::lib_0502::func_8C21, var_08);
      break;

    case "taking":
      common_scripts\utility::func_FB2(self.var_79AD.worldvisualizations["friendly"], ::lib_0502::func_8C21, var_07);
      common_scripts\utility::func_FB2(self.var_79AD.worldvisualizations["enemy"], ::lib_0502::func_8C21, var_08);
      break;

    case "contested":
      common_scripts\utility::func_F71(self.var_79AD.worldvisualizations["contested"], ::method_805B);
      break;

    case "losing":
      common_scripts\utility::func_FB2(self.var_79AD.worldvisualizations["enemy"], ::lib_0502::func_8C21, var_07);
      common_scripts\utility::func_FB2(self.var_79AD.worldvisualizations["friendly"], ::lib_0502::func_8C21, var_08);
      break;

    default:
      break;
  }
}

func_A211(param_00) {
  func_6934(param_00);
  func_6963("useTime", 10, [3, 5, 10, 15, 20]);
}

func_A216(param_00) {
  level.var_79EE[level.var_79EE.size] = param_00;
  var_01 = func_45CE(param_00);
  var_02 = maps\mp\gametypes\_gameobjects::func_2837(game["attackers"], param_00, self.var_982D["visuals"], var_01, 0, 1);
  func_6942(var_02);
  var_02 maps\mp\gametypes\_gameobjects::func_2F93();
  var_02 maps\mp\gametypes\_gameobjects::func_86CD(0);
  func_6983(self.var_1A5);
  var_02 maps\mp\gametypes\_gameobjects::func_365D();
  var_02 maps\mp\gametypes\_gameobjects::func_C30("friendly");
  var_02 maps\mp\gametypes\_gameobjects::func_8A5A(func_45D0("useTime"));
  var_02 maps\mp\gametypes\_gameobjects::func_8A59(&"MP_CAPTURING_OBJECTIVE");
  var_02.var_5F95 = 1;
  var_02 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_02 maps\mp\gametypes\_gameobjects::func_86CD(1);
  var_02 func_860B("waypoint_capture", "waypoint_defend");
  var_02.var_A23E = 7;
  var_02.var_6BBF = ::func_6BC7;
  var_02.var_6ABC = ::func_6BC5;
  var_02.var_6AFA = ::func_6BC6;
  func_6982(self.var_1A5);
  foreach(var_04 in self.var_982D["visuals"]) {
    var_04 delete();
  }

  var_02 maps\mp\gametypes\_gameobjects::func_2F93();
  var_02 maps\mp\gametypes\_gameobjects::deleteuseobjectobjectives();
  waittillframeend;
  var_02 maps\mp\gametypes\_gameobjects::func_2D58();
}

func_6BC7(param_00) {
  func_6935(self.var_695A);
}

func_6BC5(param_00) {
  func_6958();
  func_694D(param_00);
  func_79B2(self.var_79AD.var_695A);
}

func_6BC6(param_00, param_01, param_02) {
  if(!param_02) {
    func_6957();
  }

  func_694F(param_00, param_01, param_02);
  func_79B3(self.var_79AD.var_695A);
}

func_A210(param_00) {
  func_6934(param_00);
  func_6963("useTime", lib_0501::func_4647("useHoldBuild_useTime"), [5, 10, 15, 20]);
  self.var_982D["build_trigger"][0].var_3C65 = 1;
}

func_1D5D(param_00) {
  level.var_79ED[level.var_79ED.size] = param_00;
  param_00 common_scripts\utility::func_9D9F();
  func_6983(self.var_1A5);
  waittillframeend;
  var_01 = 0;
  var_02 = 1;
  if(self.var_1A5 == "bridge_1") {
    var_02 = 0.5;
  } else if(self.var_1A5 == "bridge_2") {
    var_01 = 0.5;
  }

  self.var_5B3A = 0;
  var_03 = func_45CE(param_00);
  var_04 = (0, 0, 60);
  param_00 common_scripts\utility::func_9DA3();
  var_05 = "war_hammer_assemble_mp";
  var_06 = maps\mp\gametypes\_gameobjects::func_2837(game["attackers"], param_00, [], var_04, !common_scripts\utility::func_562E(param_00.var_3C65), 1);
  var_06 maps\mp\gametypes\_gameobjects::func_8A57(&"RAIDS_REPAIR_USE");
  var_06.var_5F95 = 1;
  var_06 maps\mp\gametypes\_gameobjects::func_C30("friendly");
  var_06 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_06.var_A248 = var_05;
  var_06.var_A23C = 0;
  var_06.var_A23E = 7;
  var_06.var_681A = 1;
  var_06.var_113F = 0;
  var_06.var_7894 = 1;
  param_00.var_1D4F = var_06;
  var_07 = [];
  var_08 = 1;
  var_09 = self.var_982D["build_trigger"];
  foreach(var_0B in var_09) {
    if(!isDefined(var_0B.var_1D4F)) {
      var_08 = 0;
      break;
    }

    var_07[var_07.size] = var_0B.var_1D4F;
  }

  var_0D = undefined;
  if(var_08) {
    var_0E = func_45D0("useTime");
    var_0D = maps\mp\gametypes\_gameobjects::func_A226(var_07);
    var_0D.var_5F95 = 1;
    var_0D maps\mp\gametypes\_gameobjects::func_8A5A(var_0E);
    var_0D maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_REPAIR_USE_BAR");
    var_0D.var_6ABC = ::func_1D5F;
    var_0D.var_6AFA = ::func_1D60;
    var_0D.var_6BBF = ::func_1D5E;
    var_0D.var_A22C = ::func_1D64;
    var_0D.var_A212 = ::func_1D63;
    var_0D.var_1D58 = self;
    var_0D.var_502A = "raidConstruct";
    var_0D.var_A23E = 7;
    var_0D.var_681A = 1;
    var_0D.var_A248 = var_05;
    var_0D.var_A23C = 0;
    func_6942(var_0D);
    var_0F = (0, 0, 0);
    foreach(var_11 in var_07) {
      var_0F = var_0F + var_11.var_28D4;
    }

    var_0F = var_0F * 1 / var_07.size + var_04;
    var_0D func_1D53("not_building");
    var_0D func_0990(var_0F, undefined, undefined, var_0E * 1000, 11, 0, 1, var_01, var_02, 0, [0.5]);
    var_0D thread func_1D54();
    self.elemtype = var_0D;
    thread func_2384(var_0D);
  }

  func_6982(self.var_1A5);
  foreach(var_14 in self.var_692D) {
    var_14 showallparts();
    foreach(var_16 in var_14.var_8BF7) {
      foreach(var_18 in var_16) {
        var_18 lib_0502::func_79C6();
      }
    }
  }

  self notify("end_hud");
  var_06 maps\mp\gametypes\_gameobjects::func_2F93();
  var_06 maps\mp\gametypes\_gameobjects::deleteuseobjectobjectives();
  waittillframeend;
  var_06 maps\mp\gametypes\_gameobjects::func_2D58();
  param_00 delete();
}

func_1D54() {
  level endon("game_ended");
  self endon("disabled");
  var_00 = maps\mp\gametypes\_gameobjects::func_45D4(self);
  for(;;) {
    waittillframeend;
    var_01 = maps\mp\gametypes\_gameobjects::func_45D4(self);
    if(var_01 != var_00) {
      if(var_01 > 0) {
        func_1D53("building");
      } else {
        func_1D53("not_building");
      }

      var_00 = var_01;
    }

    wait 0.05;
  }
}

func_2384(param_00) {
  level endon("game_ended");
  self waittill("end_hud");
  waittillframeend;
  param_00 func_7CCA();
}

func_1D63(param_00) {
  func_8CFD(param_00);
}

func_1D5F(param_00) {
  param_00.var_581C = 1;
  param_00.var_1D5B = gettime();
  param_00 thread lib_0502::raidawardbuildxpevent();
  func_694D(param_00);
  thread func_1D61(param_00);
}

func_1D61(param_00) {
  if(self.var_54F6.size > 0) {
    return;
  }

  self endon("stop_percent_update");
  var_01 = self.var_1D58;
  for(;;) {
    func_6981(var_01.var_695A);
    wait 0.05;
    var_02 = int(self.var_28D5 / self.var_A23F * 100);
    if(var_02 >= var_01.var_5B3A + 5) {
      var_01.var_5B3A = var_01.var_5B3A + 5;
      var_01 notify("trigger", var_01.var_5B3A + "_percent", param_00);
    }

    if(self.var_28D5 / self.var_A23F >= 1) {
      break;
    }
  }
}

func_1D60(param_00, param_01, param_02) {
  if(isDefined(param_01)) {
    param_01.var_581C = 0;
    func_A088(param_01);
  }

  func_694F(param_00, param_01, param_02);
  if(self.var_54F6.size > 0) {
    return;
  }

  if(self.var_28D5 / self.var_A23F < 1) {
    self notify("stop_percent_update");
  }
}

func_1D64(param_00) {
  var_01[0] = 0;
  var_01[1] = 1;
  var_01[2] = 1.25;
  var_01[3] = 1.5;
  var_01[4] = 1.75;
  var_01[5] = 2;
  var_01[6] = 2.1;
  var_01[7] = 2.2;
  var_01[8] = 2.3;
  var_01[9] = 2.4;
  var_02 = 0;
  foreach(var_04 in self.var_6E79.var_A22B) {
    if(var_04 > 0) {
      var_02++;
    }
  }

  if(!var_02) {
    return 1;
  }

  var_04 = var_01[int(min(int(var_02), var_01.size - 1))];
  return var_04 / var_02;
}

func_1D5E(param_00) {
  self.var_1D58 notify("built");
  lib_0502::func_7921(param_00);
  func_6935(self.var_1D58.var_1A5);
  var_01 = param_00;
  var_02 = param_00.var_1D5B;
  foreach(var_04 in level.var_744A) {
    if(common_scripts\utility::func_562E(var_04.var_581C)) {
      lib_0502::func_7921(var_04);
      if(!isDefined(var_02) || var_04.var_1D5B < var_02) {
        var_01 = var_04;
        var_02 = var_04.var_1D5B;
      }
    }
  }

  level thread maps\mp\_utility::func_9863("raids_callout_capture", var_01);
}

func_1D4F(param_00) {
  param_00 lib_0502::func_7997();
  func_6983(self.var_1A5);
  param_00 lib_0502::func_79C6();
  func_6982(self.var_1A5);
  param_00 delete();
}

func_1D55(param_00) {
  param_00 lib_0502::func_7997();
  func_6983(self.var_1A5);
  param_00 lib_0502::func_79C6();
  thread func_1D51(param_00);
  thread func_1D50(param_00);
  param_00 waittill("objectFinished");
  param_00 delete();
}

func_1D51(param_00) {
  param_00 endon("objectFinished");
  for(;;) {
    self waittill("trigger", var_01, var_02);
    if(var_01 == param_00.var_8260 || var_01 == "100_percent") {
      param_00 lib_0502::func_7997();
      break;
    }
  }

  param_00 notify("objectFinished");
}

func_1D50(param_00) {
  param_00 endon("objectFinished");
  func_6982(self.var_1A5);
  param_00 notify("objectFinished");
}

func_1D59(param_00) {
  var_01 = param_00.var_3B == "script_brushmodel";
  if(var_01) {
    param_00 method_805F();
  }

  thread func_1D51(param_00);
  thread func_1D50(param_00);
  param_00 waittill("objectFinished");
  param_00 delete();
}

func_1D53(param_00) {
  self.var_931A = param_00;
  switch (self.var_931A) {
    case "not_building":
      func_8614(11);
      foreach(var_02 in self.var_21F7) {
        if(common_scripts\utility::func_562E(var_02.var_9D65.var_3C65)) {
          var_02 func_860D(11);
        }
      }
      break;

    case "building":
      func_8617("build", 12);
      foreach(var_02 in self.var_21F7) {
        if(common_scripts\utility::func_562E(var_02.var_9D65.var_3C65)) {
          var_02 func_860D(12);
        }
      }
      break;

    default:
      break;
  }
}

func_1D52(param_00) {
  param_00 method_805C();
  func_6983(self.var_695A);
  param_00 thread lib_0502::func_8C21(game["attackers"]);
  func_6982(self.var_695A);
  param_00 delete();
}

func_1D4E(param_00) {
  param_00 method_805C();
  func_6983(self.var_695A);
  param_00 thread lib_0502::func_8C21(game["defenders"]);
  func_6982(self.var_695A);
  param_00 delete();
}

func_3859(param_00) {
  self.var_664C = 0;
  self.var_3DEB = 0;
  self.var_17D9 = 0;
  self.var_17DD = 1;
  self.var_17DE = undefined;
  self.var_17DB = 0;
  self.var_17DA = undefined;
  self.var_6921 = 1;
  self.var_6920 = 0;
  self.var_6911 = 0;
  self.var_6906 = 0;
  self.var_1197 = 0;
  self.var_2C7E = 0;
  self.var_9263 = 1;
  self.var_931A = "";
  self.var_932E = 0;
  self.var_4B70 = 0;
  self.var_4C32 = [];
  self.var_21DB = [];
  self.currentcheckpoint = 0;
  func_6934(param_00);
  self.var_6940 = ::func_3863;
  var_01 = [1, 2, 3, 4, 5, 10, 20];
  func_6963("speed", lib_0501::func_4647("escort_forwardSpeed"), var_01);
  func_6963("speedReverse", lib_0501::func_4647("escort_rollbackSpeed"), var_01);
  func_6963("accel", 3, var_01);
  func_6963("decel", 3, var_01);
  func_6963("accelPreObjective", 5, var_01);
  func_6963("decelPreObjective", 20, var_01);
  func_6963("repairTime", 15);
  func_6965("escort_contestable", lib_0501::func_4648("escort_contestable"), [1, 0]);
  func_6965("escort_turretActive", lib_0501::func_4648("escort_turretActive"), [1, 0]);
  thread func_3847();
}

func_3863() {
  var_00 = lib_0502::func_207C("escort_trigger");
  return var_00[0];
}

func_3855(param_00) {
  self.var_664C = 0;
  self.var_3DEB = 1;
  self.var_17D9 = 0;
  self.var_17DD = 1;
  self.var_17DE = undefined;
  self.var_17DB = 0;
  self.var_17DA = undefined;
  self.var_6921 = 1;
  self.var_6920 = 0;
  self.var_6911 = 0;
  self.var_6906 = 0;
  self.var_1196 = 0;
  self.var_1197 = 0;
  self.var_2C7D = 0;
  self.var_2C7E = 0;
  self.var_9263 = 1;
  self.var_931A = "";
  self.var_932E = 0;
  self.var_4B70 = 0;
  self.var_4C32 = [];
  self.var_21DB = [];
  self.currentcheckpoint = 0;
  func_6934(param_00);
  self.var_6940 = ::func_3856;
  var_01 = [1, 2, 3, 4, 5, 10, 20];
  func_6963("speed", lib_0501::func_4647("escort_forwardSpeed"), var_01);
  func_6963("speedReverse", lib_0501::func_4647("escort_rollbackSpeed"), var_01);
  func_6963("accel", 3, var_01);
  func_6963("decel", 3, var_01);
  func_6963("accelPreObjective", 5, var_01);
  func_6963("decelPreObjective", 20, var_01);
  func_6963("repairTime", 15);
  func_6965("escort_contestable", lib_0501::func_4648("escort_contestable"), [1, 0]);
  func_6965("escort_turretActive", lib_0501::func_4648("escort_turretActive"), [1, 0]);
  while(!isDefined(level.var_3836)) {
    wait 0.05;
  }

  self.var_A2C8 = level.var_3836;
  self.var_A2C8.var_1A2 = self.var_1A2;
  self.var_A2C8.var_693E = undefined;
  func_385A(self.var_A2C8);
  func_6983(self.var_695A);
  self.var_A2C8.var_1C7 = "forward";
  self.var_A2C8.var_1C1 = "forward";
  self.var_A2C8 startpath(self.var_A2C8.var_92ED);
  thread func_3847();
  wait 0.05;
  thread func_3872(self.var_A2C8.var_3850);
}

func_3856() {
  var_00 = lib_0502::func_207C("objective_zone");
  return var_00[0];
}

func_3848() {
  self endon("teleportToObjectiveStart");
  func_6983(self.var_695A);
}

tanknotify(param_00) {
  level.var_79C2.var_97C0[param_00] = 1;
  self notify(param_00);
}

func_383B() {
  self endon("teleportToObjectiveStart");
  var_00 = 1;
  if(isDefined(level.var_79C2.var_97C0) && common_scripts\utility::func_562E(level.var_79C2.var_97C0[self.var_5CB6])) {
    var_00 = 0;
  }

  if(var_00) {
    level waittill(self.var_5CB6);
  }
}

func_383D(param_00) {
  func_6935(self.var_695A);
  if(!common_scripts\utility::func_562E(param_00)) {
    var_01 = undefined;
    var_02 = undefined;
    foreach(var_04 in self.var_383C.var_9AC3[game["attackers"]]) {
      if(!isDefined(var_04.var_721C)) {
        continue;
      }

      lib_0502::func_7924(var_04.var_721C);
      if(!isDefined(var_02) || var_04.var_9309 < var_02) {
        var_01 = var_04.var_721C;
        var_02 = var_04.var_9309;
      }
    }

    level thread maps\mp\_utility::func_9863("raids_callout_capture", var_01);
  }
}

func_3844(param_00) {
  if(!isDefined(self.var_383C)) {
    return 0;
  }

  if(param_00 == game["attackers"] && !maps\mp\_utility::func_3FA0("finished_intro_vignette_" + game["attackers"])) {
    return 0;
  }

  return self.var_383C.var_689F[param_00];
}

func_3843(param_00) {
  if(!isDefined(self.var_73B6)) {
    self.var_73B6["attackers"] = spawnStruct();
    self.var_73B6["attackers"].var_99DA = -1;
    self.var_73B6["defenders"] = spawnStruct();
    self.var_73B6["defenders"].var_99DA = -1;
  }

  var_01 = self.var_73B6[param_00];
  if(var_01.var_99DA == gettime()) {
    return var_01.var_7DF9;
  }

  self.var_73B6[param_00].var_99DA = gettime();
  var_02 = game[param_00];
  var_03 = anglesToForward(self.var_A2C8.var_1D);
  if(param_00 == "defenders") {
    var_03 = var_03 * -1;
  }

  foreach(var_05 in self.var_4C32) {
    if(!var_05.var_2599) {
      continue;
    }

    if(!isDefined(var_05.var_9D65)) {
      continue;
    }

    var_06 = var_05.var_9D65.var_116 - self.var_A2C8.var_116;
    if(vectordot(var_03, var_06) < 0) {
      continue;
    }

    foreach(var_08 in self.var_383C.var_9AC3[var_02]) {
      if(!isDefined(var_08.var_721C)) {
        continue;
      }

      if(var_08.var_721C istouching(var_05.var_9D65)) {
        self.var_73B6[param_00].var_7DF9 = 1;
        return 1;
      }
    }
  }

  self.var_73B6[param_00].var_7DF9 = 0;
  return 0;
}

func_3841() {
  if(self.var_17DD || isDefined(self.var_17DE)) {
    return 1;
  }

  if(func_3842()) {
    return 1;
  }

  return 0;
}

func_3842() {
  if(isDefined(self.var_17DE) && common_scripts\utility::func_562E(self.var_17DE.var_17DF)) {
    return 1;
  }

  if(func_3843("defenders")) {
    return 1;
  }

  return 0;
}

func_383F() {
  if(self.var_17DB || isDefined(self.var_17DA)) {
    return 1;
  }

  if(func_3840()) {
    return 1;
  }

  return 0;
}

func_3840(param_00) {
  if(isDefined(self.var_17DA) && common_scripts\utility::func_562E(self.var_17DA.var_17DF)) {
    return 1;
  }

  if(!common_scripts\utility::func_562E(param_00) && func_3843("attackers")) {
    return 1;
  }

  return 0;
}

func_3847() {
  waittillframeend;
  self.var_A2C8.var_92ED notify("trigger", self.var_A2C8);
  thread func_3846();
  var_00 = 1;
  var_01 = 4;
  var_02 = 1;
  var_03 = undefined;
  var_04 = gettime();
  var_05 = [];
  while(var_02) {
    wait 0.05;
    var_06 = func_3844(game["attackers"]);
    var_07 = func_3844(game["defenders"]);
    if(var_06) {
      self.var_1197 = gettime();
    }

    if(var_07) {
      self.var_2C7E = gettime();
    }

    var_08 = self.var_6920 && common_scripts\utility::func_3C77(func_6973(self.var_695A));
    if(func_5761(self.var_695A)) {
      func_3845("stop");
      return;
    }

    if(level.var_3F9D) {
      func_3845("stop");
      return;
    }

    if(self.var_6921) {
      func_3845("stop");
      func_3848();
      self.var_6921 = 0;
      continue;
    }

    if(isDefined(self.var_5CB6)) {
      func_3845("stop");
      func_383B();
      self.var_5CB6 = undefined;
      continue;
    }

    if(self.var_664C) {
      func_3845("needs_repair");
      continue;
    }

    if(self.var_3DEB) {
      func_3845("forward");
      if(var_08 && var_06) {
        func_6981(self.var_695A, "forward", 1, 0);
      }

      continue;
    }

    if(self.var_6906) {
      var_02 = 0;
      func_3845("stop");
      func_383D(1);
      continue;
    }

    if(isDefined(level.var_4E09)) {
      func_3845("stop");
      if(var_08 && var_06) {
        func_6981(self.var_695A, undefined, 1, 0);
      }

      continue;
    }

    if(!var_08) {
      continue;
    }

    var_09 = undefined;
    var_0A = undefined;
    var_0B = 0;
    var_0C = func_45D0("speedReverse") > 0 || !maps\mp\_utility::func_3FA0("finished_intro_vignette_" + game["attackers"]);
    if(!var_06 && !var_07) {
      if(func_3841() && var_0C) {
        var_09 = "blocked_reverse";
      } else if(gettime() - self.var_1197 > var_00 * 1000 && var_0C) {
        var_09 = "reverse";
      } else {
        var_09 = "stop";
      }
    } else if(var_06 && var_07 && func_45D0("escort_contestable")) {
      var_09 = "stop";
      var_0A = "contest";
      var_0B = 1;
    } else if(var_07 && !var_06) {
      if(func_3841() && var_0C) {
        var_09 = "blocked_reverse";
      } else if(gettime() - self.var_1197 > var_00 * 1000 && var_0C) {
        var_09 = "reverse";
      } else {
        var_09 = "stop";
      }
    } else {
      if(self.var_6911) {
        var_02 = 0;
        var_09 = "stop";
        func_383D();
        self.var_383C func_8619(self.var_A2C8.var_693E);
      } else if(func_383F()) {
        var_09 = "blocked_forward";
        if(func_3840(1)) {
          var_0A = "blocked_forward_scripted";
        }
      } else if(self.var_A2C8.var_1C7 == "reverse" && self.var_A2C8 method_8283() > 0) {
        var_09 = "stop";
      } else {
        var_09 = "forward";
        if(isDefined(var_03) && var_03 == "blocked_forward_scripted") {
          var_0A = "unblocked_scripted";
        }
      }

      var_0B = 1;
    }

    if(!isDefined(var_0A)) {
      var_0A = var_09;
    }

    func_3845(var_09);
    func_6981(self.var_695A, var_0A, var_0B, 1, self.var_383C.var_2947);
    if(var_09 == "forward") {
      var_0D = [];
      foreach(var_0F in self.var_383C.var_9AC3[game["attackers"]]) {
        var_10 = var_0F.var_721C;
        var_11 = var_0F.var_9309;
        if(isDefined(var_05) && var_05.size > 0 && common_scripts\utility::func_F79(var_05, var_10)) {
          if(!isDefined(var_10.escorting_tank_time)) {
            var_10.escorting_tank_time = 0;
          }

          var_10.escorting_tank_time = var_10.escorting_tank_time + gettime() - var_04;
          if(var_10.escorting_tank_time >= var_01 * 1000) {
            if(var_10 maps\mp\_utility::func_649("specialty_improvedobjectives")) {
              lib_0502::raidawardtankescortevent(var_10);
            }

            var_10.escorting_tank_time = 0;
          }
        }

        var_0D[var_0D.size] = var_10;
      }

      var_05 = var_0D;
    } else {
      var_05 = [];
    }

    var_04 = gettime();
    var_03 = var_0A;
  }
}

func_3846() {
  func_6983(self.var_695A);
  if(isDefined(self.var_A2C8) && common_scripts\utility::func_562E(self.var_A2C8.dontteleport)) {
    return;
  }

  if(!self.var_6920) {
    self notify("teleportToObjectiveStart");
    level notify("escortVehicleTeleportToObjectiveStart");
    self.var_A2C8.var_6975 notify("trigger", self.var_A2C8);
    wait 0.05;
    wait 0.05;
    self.var_A2C8 attachpath(self.var_A2C8.var_6975);
  }
}

func_3845(param_00) {
  if(self.var_931A == param_00) {
    return;
  }

  var_01 = self.var_931A;
  switch (var_01) {
    case "needs_repair":
      if(isDefined(self.var_7D0B)) {
        self.var_7D0B delete();
      }
      break;

    default:
      break;
  }

  self.var_931A = param_00;
  self.var_932E = gettime();
  switch (param_00) {
    case "needs_repair":
      self.var_7D0B = spawnfx(common_scripts\utility::func_44F5("needs_repair"), self.var_A2C8.var_116 + (0, 0, 120));
      triggerfx(self.var_7D0B);
      func_3870(self.var_A2C8);
      break;

    case "blocked_reverse":
    case "stop":
    case "blocked_forward":
      func_3870(self.var_A2C8);
      break;

    case "reverse":
      func_386A(self.var_A2C8);
      break;

    case "forward":
      if(self.var_9263) {
        self.var_A2C8.var_1C7 = "forward";
        self.var_A2C8.var_1C1 = "forward";
        self.var_A2C8 startpath();
        self.var_9263 = 0;
      }

      func_3857(self.var_A2C8);
      break;

    default:
      break;
  }
}

func_386F(param_00) {
  var_01 = function_01E0(param_00.var_106, param_00.var_1A5, param_00.var_1C8, param_00.var_116, param_00.var_1D);
  var_01.var_1C8 = param_00.var_1C8;
  var_01 makeunusable();
  var_01 setCanDamage(0);
  var_01.var_1A2 = param_00.var_1A2;
  var_01.var_A045 = ::lib_0504::func_A3FE;
  var_01.var_A3EF = 1;
  var_01 method_867B(1);
  var_01 thread lib_0502::func_2FC4();
  var_01.var_4881 = 1;
  var_01.var_37D8 = var_01 getentitynumber();
  var_01.var_112 = self;
  var_01.var_1A7 = param_00.var_82B2;
  lib_0502::func_9FF(var_01);
  lib_0504::func_794B(var_01);
  self.var_A2C8 = var_01;
  self.var_5DC0 = self.var_A2C8;
  func_385A(var_01);
  waittillframeend;
  var_01 attachpath(var_01.var_92ED);
  thread func_3871(var_01);
  func_6983(self.var_695A);
  if(isDefined(var_01.var_9EDD) && var_01 method_8221()) {
    var_01 thread lib_0504::func_795E(0);
  }
}

func_3872(param_00) {
  param_00 method_83EF();
  if(!param_00 islinked()) {
    param_00 enablelinkto();
    param_00 linkto(self.var_A2C8);
  }

  self.var_A2C8.var_3850 = param_00;
  var_01 = func_45CE(param_00);
  if(isDefined(param_00.var_501D)) {
    var_01 = param_00.var_501D;
  }

  param_00.var_501D = var_01;
  func_6983(self.var_695A);
  var_02 = maps\mp\gametypes\_gameobjects::func_2837(game["attackers"], param_00, [], var_01, 0, 1);
  var_02.var_502A = "raidEscortTrigger";
  func_6942(var_02);
  var_02.var_681A = 1;
  var_02 maps\mp\gametypes\_gameobjects::func_C30("any");
  var_02 maps\mp\gametypes\_gameobjects::func_8A60("any");
  self.var_383C = var_02;
  self.var_A2C8.var_383C = var_02;
  thread func_3849(var_02);
  level.var_8D4[level.var_8D4.size] = var_02;
  if(!common_scripts\utility::func_F79(level.var_695E, ::func_384A)) {
    level.var_695E[level.var_695E.size] = ::func_384A;
  }

  func_6982(self.var_695A);
  level.var_8D4 = common_scripts\utility::func_F93(level.var_8D4, var_02);
  if(level.var_8D4.size == 0) {
    level.var_695E = common_scripts\utility::func_F93(level.var_695E, ::func_384A);
  }

  waittillframeend;
  self notify("end_hud");
}

func_384A(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = self;
  foreach(var_0C in level.var_8D4) {
    if(param_01 istouching(var_0C.var_9D65) || var_0A istouching(var_0C.var_9D65)) {
      param_01 thread maps\mp\_events::func_2C80(var_0A, param_09, param_04);
      param_01.var_62A1["defendObjective"] = var_0C;
      if(var_0A istouching(var_0C.var_9D65)) {
        param_01 thread maps\mp\gametypes\_missions::func_80BB(param_04, param_03);
      }
    }
  }
}

func_3849(param_00) {
  var_01 = self.var_A2C8.var_36DA;
  var_02 = 0;
  var_03 = 0;
  var_04 = self.var_21DB[var_02];
  var_05 = 0;
  var_06 = undefined;
  if(common_scripts\utility::func_562E(self.var_651B)) {
    var_06 = self.var_81E1;
  }

  while(!var_05) {
    if(common_scripts\utility::func_562E(self.var_1809)) {
      break;
    }

    if(self.var_664C) {
      if(param_00 func_4B4D()) {
        param_00 func_7CCA();
      }

      param_00 maps\mp\gametypes\_gameobjects::func_C30("none");
      param_00 maps\mp\gametypes\_gameobjects::func_8A60("none");
      self waittill("repaired");
      continue;
    }

    if(!param_00 func_4B4D()) {
      func_27E6(param_00, self.var_A2C8);
    }

    param_00 maps\mp\gametypes\_gameobjects::func_C30("friendly");
    param_00 maps\mp\gametypes\_gameobjects::func_8A60("any");
    param_00 func_3FCD(self.var_A2C8);
    var_07 = 0;
    if(param_00.var_21DE.size) {
      var_08 = param_00.var_21DE[0];
    } else {
      var_05 = var_02;
      var_08 = 1;
    }

    var_09 = 0;
    var_0A = undefined;
    self.var_5024 = "";
    while(!self.var_664C) {
      if(common_scripts\utility::func_562E(self.var_1809)) {
        break;
      }

      var_0B = self.var_A2C8.var_291C;
      if(var_0B == var_04) {
        var_03 = var_04.var_6EDA;
        var_07 = param_00.var_21DE[var_02];
        var_02++;
        if(var_02 < param_00.var_21DE.size) {
          var_04 = self.var_21DB[var_02];
          var_08 = param_00.var_21DE[var_02];
        } else {
          var_04 = var_01;
          var_08 = 1;
        }

        var_0A = self.var_A2C8.var_291C;
        var_09 = 1;
      }

      var_0C = var_0B.var_6EDA - var_03;
      if(var_0B.var_6968) {
        var_0D = func_3851(var_0B);
        var_0C = var_0C + distance2d(self.var_A2C8.var_116, var_0D);
      }

      var_0E = var_04.var_6EDA - var_03;
      var_05 = common_scripts\utility::func_3C77(func_6937(self.var_695A));
      var_0F = common_scripts\utility::func_98E7(var_05, 1, 0.99);
      var_10 = self.var_6EDA;
      var_11 = var_0C + var_03 / var_10;
      param_00.var_2947 = clamp(var_11, 0, var_0F);
      var_12 = func_3844(game["attackers"]);
      var_13 = func_3844(game["defenders"]);
      if(var_12 && var_13 && func_45D0("escort_contestable")) {
        var_14 = "contested";
      } else if(self.var_931A == "blocked_forward" && func_3840()) {
        var_14 = "blocked";
      } else if(self.var_931A == "blocked_reverse" && func_3842()) {
        var_14 = "blocked";
      } else if(var_12 && !var_13 || !func_45D0("escort_contestable")) {
        var_14 = "forward";
      } else if(var_13) {
        var_14 = "enemy";
      } else {
        var_14 = "normal";
      }

      func_9542(self, var_11, 250);
      if(var_14 != self.var_5024 || var_09) {
        switch (var_14) {
          case "normal":
          default:
            var_15 = lib_0502::func_4518("escort_halt", var_06);
            param_00 func_860A(var_15, var_06);
            param_00 func_3FCD(self.var_A2C8);
            param_00 func_8617("escort", var_15, var_07, var_08, var_0A);
            break;

          case "forward":
            var_15 = lib_0502::func_4518("escorting_halt", var_07);
            param_00 func_860A(var_15, var_06);
            param_00 func_3FCD(self.var_A2C8);
            param_00 func_8617("escort", var_15, var_07, var_08, var_0A);
            break;

          case "contested":
            var_15 = lib_0502::func_4518("contested_contested", var_07);
            param_00 func_860A(var_15, var_06);
            param_00 func_3FCD(self.var_A2C8);
            param_00 func_8617("escort", var_15, var_07, var_08, var_0A);
            break;

          case "enemy":
            var_15 = lib_0502::func_4518("escort_defenders_touch", var_07);
            param_00 func_860A(var_15, var_06);
            param_00 func_3FCD(self.var_A2C8);
            param_00 func_8617("escort", var_15, var_07, var_08, var_0A);
            break;

          case "blocked":
            var_15 = lib_0502::func_4518("escort_blocked", var_07);
            param_00 func_860A(var_15, var_06);
            param_00 func_3FCD(self.var_A2C8);
            param_00 func_8617("escort", var_15, var_07, var_08, var_0A);
            break;
        }

        self.var_5024 = var_14;
      }

      var_09 = 0;
      var_0A = undefined;
      if(var_05) {
        break;
      }

      maps\mp\gametypes\_hostmigration::func_A782();
      wait 0.05;
      waittillframeend;
    }
  }

  param_00 maps\mp\gametypes\_gameobjects::func_2D58();
}

func_9542(param_00, param_01, param_02) {
  if(!isDefined(param_00.var_5C02)) {
    param_00.var_5C02 = gettime();
  }

  if(!isDefined(param_00.var_6F3C)) {
    param_00.var_6F3C = 0;
  }

  if(gettime() < param_00.var_5C02 + param_02) {
    return;
  }

  lib_0502::func_2D53("dropped_weapon", param_00.var_A2C8.var_116, 220);
  lib_0502::func_2D53("care_package", param_00.var_A2C8.var_116, 210);
  if(param_01 == param_00.var_6F3C) {
    return;
  }

  param_00.var_6F3C = param_01;
  var_03 = ["bouncingbetty", "bouncingbetty_mp", "bouncingbetty_sp"];
  lib_0502::func_9541(param_00.var_A2C8, var_03);
  param_00.var_5C02 = gettime();
}

func_27E6(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in self.var_21DB) {
    var_02[var_02.size] = var_04.var_6EDA / self.var_6EDA;
  }

  var_06 = param_00.var_9D65.var_116 + param_00.var_6A1D;
  var_07 = var_06 - param_01.var_116;
  param_00 func_0990(param_01, undefined, var_07, 30000, 5, 0, 0, 0, var_02[0], 0, var_02, self.var_A2C8, self.var_A2C8.var_92ED, self.var_A2C8.var_291C);
  param_00.var_21DE = var_02;
  waittillframeend;
  foreach(var_0A, var_09 in self.var_4C32) {
    thread func_A111(var_09, var_0A + var_02.size, param_00.var_50A9);
  }

  thread func_237F(param_00);
}

func_A111(param_00, param_01, param_02) {
  param_02 endon("image_timer_removed");
  param_02 endon("death");
  var_03 = param_00.var_17E3.var_6EDA + param_00.var_17E6.var_6EDA / 2;
  var_04 = var_03 / self.var_6EDA;
  if(param_01 == 0) {
    param_02.var_30 = var_04;
  } else if(param_01 == 1) {
    param_02.var_31 = var_04;
  } else if(param_01 == 2) {
    param_02.var_32 = var_04;
  } else if(param_01 == 3) {
    param_02.allowpain = var_04;
  } else if(param_01 == 4) {
    param_02.var_34 = var_04;
  }

  var_05 = !param_00.var_2599;
  for(;;) {
    if(var_05 != param_00.var_2599) {
      var_06 = common_scripts\utility::func_98E7(param_00.var_2599, 1, 2);
      if(param_01 == 0) {
        param_02.var_35 = var_06;
      } else if(param_01 == 1) {
        param_02.alpha = var_06;
      } else if(param_01 == 2) {
        param_02.var_37 = var_06;
      } else if(param_01 == 3) {
        param_02.var_38 = var_06;
      } else if(param_01 == 4) {
        param_02.var_39 = var_06;
      }

      param_02.var_61 = gettime();
      var_05 = param_00.var_2599;
    }

    wait 0.05;
  }
}

func_237F(param_00) {
  func_6982(self.var_695A);
  if(isDefined(self.var_651B)) {
    param_00 func_860F();
    func_6982(self.var_6E78);
  }

  param_00 func_7CCA();
}

func_3869(param_00) {
  level.var_79BE[level.var_79BE.size] = param_00;
  param_00 method_83EF();
  param_00 enablelinkto();
  var_01 = 0;
  if(!isDefined(self.var_7D0E)) {
    var_01 = 1;
    self.var_7D0E = [];
  }

  func_6983(self.var_695A);
  var_02 = maps\mp\gametypes\_gameobjects::func_2837(game["attackers"], param_00, [], undefined, 0, 1);
  func_6942(var_02);
  var_02.var_A23E = 7;
  if(var_01) {
    var_02 func_860B("waypoint_repair_neutral_map", "waypoint_repair_enemy_map");
    self.var_6211 = var_02;
  }

  var_02.var_A248 = "war_wrench_assemble_mp";
  var_02.var_681A = 1;
  var_02.var_113F = 0;
  var_02.var_7894 = 1;
  self.var_7D0E[self.var_7D0E.size] = var_02;
  param_00 linkto(self.var_A2C8);
  if(var_01) {
    thread func_3868();
  }

  thread func_384E(var_02);
  func_6982(self.var_695A);
  self.var_7D0F func_7CCA();
  var_02 maps\mp\gametypes\_gameobjects::func_2D58();
}

func_3868() {
  waittillframeend;
  var_00 = maps\mp\gametypes\_gameobjects::func_A226(self.var_7D0E);
  var_00.var_5F95 = 1;
  var_00 maps\mp\gametypes\_gameobjects::func_8A5A(func_45D0("repairTime"));
  var_00 maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_REPAIR_USE_BAR");
  var_00.var_6BBF = ::func_3865;
  var_00.var_6ABC = ::func_6B06;
  var_00.var_6AFA = ::func_6B07;
  var_00.var_502A = "raidRepair";
  var_00.var_A23E = 7;
  var_00.var_79AD = self;
  var_00.var_681A = 1;
  self.var_7D0F = var_00;
  self.var_7D0E[0] endon("deleted");
  for(;;) {
    if(self.var_664C) {
      self waittill("repaired");
      continue;
    }

    self waittill("break_down");
    var_00.var_28D5 = 0;
  }
}

func_6B06(param_00) {
  func_79B2(self.var_79AD.var_695A);
  self.var_79AD.var_6211 func_860B("waypoint_repair_ally_map", "waypoint_repair_enemy_map");
  func_8CFD(param_00);
}

func_6B07(param_00, param_01, param_02) {
  func_79B3(self.var_79AD.var_695A);
  self.var_79AD.var_6211 func_860B("waypoint_repair_neutral_map", "waypoint_repair_enemy_map");
  if(self.var_54F6.size == 0 && self.var_28D5 / self.var_A23F < 1) {
    func_8614(6);
    func_A088(param_01);
  }
}

func_384C() {
  var_00 = func_6939(10);
  var_00.var_E5 = &"RAIDS_REPAIR_BAR";
  var_01 = func_6938(10);
  var_02 = func_45D0("repairTime");
  self.var_7D0F func_0990(self.var_7D0E[0].var_9D65, undefined, undefined, var_02 * 1000, 71, 0, 1);
  func_384D(var_01, var_00);
  self.var_7D0F func_7CCA();
  var_01 maps\mp\gametypes\_hud_util::func_2DCC();
  var_00 maps\mp\gametypes\_hud_util::func_2DCC();
}

func_384D(param_00, param_01) {
  self endon("end_hud");
  self endon("repaired");
  var_02 = maps\mp\gametypes\_gameobjects::func_45D4(self.var_7D0F);
  for(;;) {
    var_03 = maps\mp\gametypes\_gameobjects::func_45D4(self.var_7D0F);
    if(var_03 == 0) {
      self.var_7D0F func_8614(6);
    } else if(var_03 != var_02) {
      self.var_7D0F func_8617("build", 12);
    }

    var_04 = clamp(self.var_7D0F.var_28D5 / self.var_7D0F.var_A23F, 0, 1);
    func_A177(param_01, var_04);
    func_A0E4(param_00, var_04);
    wait 0.05;
  }
}

func_384E(param_00) {
  param_00 endon("deleted");
  var_01 = param_00.var_9D65;
  for(;;) {
    if(self.var_664C) {
      param_00 maps\mp\gametypes\_gameobjects::func_C30("friendly");
      param_00 maps\mp\gametypes\_gameobjects::func_8A60("any");
      param_00 maps\mp\gametypes\_gameobjects::func_8A57(&"RAIDS_REPAIR_USE");
      param_00.var_9D65 setcursorhint("HINT_NOICON");
      param_00 func_3FCD(self.var_A2C8);
      var_01 makeusable();
      self waittill("repaired");
      continue;
    }

    param_00 maps\mp\gametypes\_gameobjects::func_C30("none");
    param_00 maps\mp\gametypes\_gameobjects::func_8A60("none");
    param_00 maps\mp\gametypes\_gameobjects::func_8A57("");
    var_01 makeunusable();
    self waittill("break_down");
  }
}

func_3865(param_00) {
  self.var_79AD func_3867();
}

func_3867() {
  self.var_664C = 0;
  self notify("repaired");
}

func_3852() {
  self.var_3DEB = 0;
  self.var_664C = 1;
  self notify("break_down");
}

func_385B(param_00) {
  var_01 = self.var_A2C8;
  param_00 linkto(var_01);
  param_00 thread lib_0502::func_2D1D();
}

func_385A(param_00) {
  var_01 = 0;
  var_02 = 0;
  param_00.var_92ED = getvehiclenode(param_00.var_1A2, "targetname");
  param_00.var_6975 = param_00.var_92ED;
  param_00.var_291C = param_00.var_92ED;
  var_03 = param_00.var_92ED;
  var_04 = undefined;
  while(isDefined(var_03)) {
    var_03.var_112 = self;
    thread func_385E(param_00, var_03, ::func_385F);
    if(!isDefined(var_03.var_1A2)) {
      break;
    }

    var_04 = var_03;
    var_03 = getvehiclenode(var_03.var_1A2, "targetname");
  }

  self.var_6920 = param_00.var_6975 == param_00.var_92ED;
  var_05 = 0;
  var_03 = param_00.var_92ED;
  var_04 = undefined;
  while(isDefined(var_03)) {
    if(!var_05) {
      var_05 = var_03 == param_00.var_6975;
    }

    var_03.var_A3E = var_05;
    if(func_575D(var_03)) {
      var_03.var_6C42 = func_3858(var_03);
    }

    if(isDefined(var_04)) {
      var_03.var_139 = var_04;
      var_04.var_6EDB = distance2d(func_3851(var_04), func_3851(var_03));
      var_01 = var_01 + var_04.var_6EDB;
      if(var_04.var_6968) {
        var_02 = var_02 + var_04.var_6EDB;
      }

      var_03.var_6968 = var_04.var_6968;
    } else {
      var_03.var_6968 = var_05;
    }

    var_03.var_17E5 = 0;
    thread func_3862(param_00, var_03);
    thread func_385E(param_00, var_03, ::func_3860);
    var_03.var_6EDC = var_01;
    var_03.var_6EDA = var_02;
    var_06 = lib_0502::func_4713(var_03);
    var_03.vehiclenodenum = var_06;
    if(isDefined(var_04)) {
      var_07 = lib_0502::func_4713(var_04);
    }

    if(var_03.var_17E5 && var_03.var_6EDA > 0) {
      self.var_21DB[self.var_21DB.size] = var_03;
    }

    var_04 = var_03;
    if(!isDefined(var_03.var_1A2)) {
      break;
    }

    var_03 = getvehiclenode(var_03.var_1A2, "targetname");
    var_04.var_66C9 = var_03;
  }

  param_00.var_36DA = var_04;
  param_00.var_21DB = self.var_21DB;
  if(!isDefined(param_00.var_693E)) {
    param_00.var_693E = param_00.var_36DA;
  }

  self.var_6EDC = var_01;
  self.var_6EDA = var_02;
  thread func_3861(param_00, param_00.var_92ED);
  thread func_385D(param_00, param_00.var_36DA);
  thread func_3864(param_00, param_00.var_693E);
}

func_3851(param_00) {
  if(isDefined(param_00.var_6C42)) {
    return param_00.var_6C42;
  }

  return param_00.var_116;
}

func_3858(param_00) {
  var_01 = getvehiclenode(param_00.var_1A5, "target");
  var_02 = getvehiclenode(param_00.var_1A2, "targetname");
  var_03 = lib_0502::func_7771(param_00.var_116, func_3851(var_01), func_3851(var_02));
  var_04 = var_03[0];
  var_05 = var_03[1];
  return var_04;
}

func_385E(param_00, param_01, param_02) {
  var_03 = [];
  if(isDefined(param_01.var_165)) {
    var_03 = strtok(param_01.var_165, " ");
  }

  foreach(var_05 in var_03) {
    self thread[[param_02]](param_00, param_01, var_05);
  }
}

func_3862(param_00, param_01) {
  for(;;) {
    param_01 waittill("trigger", var_02);
    if(var_02 != param_00) {
      continue;
    }

    var_03 = param_00.var_291C;
    if(isDefined(param_01.var_139) && param_00.var_1C1 == "reverse") {
      param_00.var_291C = param_01.var_139;
    } else {
      param_00.var_291C = param_01;
    }

    thread escortvehiclenodeupdateprogressbar(param_00, param_01, var_03);
  }
}

escortvehiclenodeupdateprogressbar(param_00, param_01, param_02) {
  self notify("escortVehicleNodeUpdateCurrentNode");
  self endon("escortVehicleNodeUpdateCurrentNode");
  wait 0.05;
  var_03 = isDefined(common_scripts\utility::func_F7E(param_00.var_21DB, param_00.var_291C)) && param_00.var_1C1 != "reverse";
  var_04 = isDefined(self.var_17DE) && isDefined(common_scripts\utility::func_F7E(param_00.var_21DB, self.var_17DE));
  var_05 = param_02 != param_00.var_291C;
  var_06 = param_01 == param_00.var_693E;
  var_07 = common_scripts\utility::func_3C77(func_6937(self.var_695A));
  if(isDefined(param_00.var_383C) && var_05 && !var_03 && !var_04 && !var_06 || var_07) {
    param_00.var_383C func_8619(param_00.var_291C);
  }
}

func_385F(param_00, param_01, param_02) {
  switch (param_02) {
    case "objective_start_wait":
      param_00.var_6975 = param_01;
      self.var_6921 = param_00.var_92ED == param_01;
      break;

    case "objective_end":
      param_00.var_693E = param_01;
      break;

    case "force_drive_start_once":
    case "force_drive_start":
      param_01.var_3DEB = 1;
      break;

    case "force_drive_end":
      param_01.var_3DEB = 0;
      break;

    case "blocker_reverse":
      if(!isDefined(param_01.var_164) || param_01.var_164 == "") {
        param_01.var_17E5 = 1;
      }
      break;

    default:
      break;
  }
}

func_385C(param_00, param_01, param_02) {
  self endon("death");
  param_01 waittill("disabled");
  if(param_02 == "blocker_forward") {
    if(isDefined(self.var_17DA) && self.var_17DA == param_01) {
      self.var_17DA = undefined;
      return;
    }

    return;
  }

  if(param_02 == "blocker_reverse") {
    if(isDefined(self.var_17DE) && self.var_17DE == param_01) {
      self.var_17DE = undefined;
      return;
    }
  }
}

func_3866(param_00, param_01) {
  param_00.var_21DD = 1;
  self.currentcheckpoint++;
  foreach(var_03 in self.var_383C.var_9AC3[game["attackers"]]) {
    var_04 = var_03.var_721C;
    if(var_04 maps\mp\_utility::func_649("specialty_improvedobjectives")) {
      lib_0502::raidawardtankescortcheckpointevent(var_04);
    }
  }

  lib_04F3::raidmusiconteam("attackers", "vehicle_checkpoint_pos", "vehicle_checkpoint_neg");
  level notify("escortVehicleReachedCheckpoint", self, param_01);
}

escortvehiclereachedfinalcheckpoint() {
  if(!game["switchedsides"]) {
    return;
  }

  if(!isDefined(level.var_696E)) {
    return;
  }

  if(level.var_696E.size < 1) {
    return;
  }

  var_00 = level.var_696E[level.var_696E.size - 1];
  if(level.var_696E.size > 1 && var_00 == "end") {
    var_00 = level.var_696E[level.var_696E.size - 2];
  }

  if(!common_scripts\utility::func_3C77(func_6973(var_00))) {
    return;
  }

  setnojipscore(1);
}

func_3860(param_00, param_01, param_02) {
  switch (param_02) {
    case "repair":
    case "repair_once":
    case "objective_start_wait":
      param_01.var_6968 = param_01.var_A3E;
      break;

    case "force_drive_start":
    case "objective_end":
      param_01.var_6968 = 0;
      break;

    case "force_drive_end":
      param_01.var_6968 = param_01.var_A3E;
      break;

    case "blocker_reverse":
      if(!isDefined(param_01.var_164) || param_01.var_164 == "") {
        param_01.var_17E5 = param_01.var_A3E;
      }
      break;

    default:
      break;
  }

  escortvehiclenodeprocesswait(param_00, param_01, param_02);
}

escortvehiclenodeprocesswait(param_00, param_01, param_02) {
  for(;;) {
    param_01 waittill("trigger", var_03);
    if(var_03 != param_00) {
      continue;
    }

    switch (param_02) {
      case "repair_once":
        func_3852();
        break;

      case "repair":
        func_3852();
        break;

      case "force_drive_start":
        self.var_3DEB = 1;
        break;

      case "force_drive_start_once":
        self.var_3DEB = 1;
        break;

      case "force_drive_end":
        self.var_3DEB = 0;
        break;

      case "blocker_forward":
        waittillframeend;
        if(common_scripts\utility::func_562E(param_01.var_2F74)) {
          break;
        }

        var_04 = param_00 method_8283();
        if(var_04 == 0) {
          self.var_17DB = 1;
          self.var_17DA = undefined;
        } else if(param_00.var_1C1 == "forward") {
          self.var_17DA = param_01;
          thread func_385C(param_00, param_01, param_02);
        } else {
          self.var_17DA = undefined;
        }
        break;

      case "blocker_reverse":
        waittillframeend;
        if(common_scripts\utility::func_562E(param_01.var_2F74)) {
          break;
        }

        var_04 = param_00 method_8283();
        if(var_04 == 0) {
          self.var_17DD = self.var_931A != "forward";
          self.var_17DE = undefined;
        } else if(param_00.var_1C1 == "reverse") {
          self.var_17DE = param_01;
          thread func_385C(param_00, param_01, param_02);
        } else {
          if(!isDefined(self.var_17DE) || !common_scripts\utility::func_562E(self.var_17DE.var_17DF)) {
            self.var_17DD = self.var_931A != "forward";
          }

          self.var_17DE = undefined;
          if(!common_scripts\utility::func_562E(param_01.var_21DD) && isDefined(common_scripts\utility::func_F7E(self.var_21DB, param_01))) {
            func_3866(param_01, self.var_A2C8);
            var_05 = self.var_21DB.size > 0 && self.var_21DB[self.var_21DB.size - 1] == param_01;
            if(var_05) {
              escortvehiclereachedfinalcheckpoint();
            }
          }
        }
        break;

      case "level_notify":
        level notify(param_01.var_8260);
        break;

      case "trigger_targets":
        var_06 = getEntArray(param_01.var_1A2, "targetname");
        var_07 = common_scripts\utility::func_46B7(param_01.var_1A2, "targetname");
        var_08 = common_scripts\utility::func_F73(var_06, var_07);
        foreach(var_0A in var_08) {
          if(isDefined(param_01.var_8260)) {
            var_0A notify("trigger", param_01.var_8260);
            continue;
          }

          var_0A notify("trigger");
        }
        break;

      case "objective_start_wait":
        self.var_6921 = !common_scripts\utility::func_3C77(func_6973(self.var_695A));
        self.var_6920 = 1;
        break;

      case "level_notify_wait":
        self.var_5CB6 = param_01.var_8260;
        break;

      case "break_objects":
        level thread func_3853(param_01.var_8260);
        break;

      case "tank_push":
        level notify("tank_push");
        break;

      default:
        break;
    }

    if(common_scripts\utility::func_9467(param_02, "vehicleScriptedFunc")) {
      var_0C = strtok(param_02, "_");
      var_0D = var_0C[1];
      if(isDefined(level.var_A3FB) && isDefined(level.var_A3FB[var_0D])) {
        param_00 thread[[level.var_A3FB[var_0D]]](param_01.var_8260, param_01.var_81EF);
      }
    }
  }
}

func_3861(param_00, param_01) {
  for(;;) {
    param_01 waittill("trigger", var_02);
    if(var_02 != param_00) {
      continue;
    }

    func_3857(param_00);
    self.var_17DC = 1;
    self.var_9263 = 1;
  }
}

func_3864(param_00, param_01) {
  for(;;) {
    param_01 waittill("trigger", var_02);
    if(var_02 != param_00) {
      continue;
    }

    self.var_6911 = !self.var_6911;
  }
}

func_385D(param_00, param_01) {
  for(;;) {
    param_01 waittill("trigger", var_02);
    if(var_02 != param_00) {
      continue;
    }

    break;
  }
}

func_3857(param_00) {
  if(self.var_6920) {
    param_00 method_8280(func_45D0("speed"), func_45D0("accel"), func_45D0("decel"));
  } else {
    param_00 method_8293(func_45D0("accel"));
  }

  param_00.var_1C7 = "forward";
  param_00.var_1C1 = "forward";
  self.var_17DD = 0;
}

func_386A(param_00) {
  if(self.var_6920) {
    param_00 method_8280(func_45D0("speedReverse"), func_45D0("accel"), func_45D0("decel"));
  } else {
    param_00 method_8293(func_45D0("accelPreObjective"));
  }

  param_00.var_1C7 = "reverse";
  param_00.var_1C1 = "reverse";
  self.var_17DB = 0;
}

func_3870(param_00) {
  if(!maps\mp\_utility::func_3FA0("finished_intro_vignette_" + game["attackers"])) {
    param_00 method_8280(0, func_45D0("accelPreObjective"), func_45D0("decelPreObjective"));
    return;
  }

  if(self.var_6920) {
    param_00 method_8280(0, func_45D0("accel"), func_45D0("decel"));
    return;
  }

  param_00 method_8280(0, func_45D0("accelPreObjective"), func_45D0("decelPreObjective"));
}

func_3871(param_00) {
  var_01 = common_scripts\utility::func_46B7("tank_target", "script_noteworthy");
  if(!var_01.size) {
    return;
  }

  foreach(var_03 in var_01) {
    var_03.var_4D3B = isDefined(var_03.var_8260) && var_03.var_8260 == "high_priority";
  }

  func_6983(self.var_695A);
  while(var_01.size > 0) {
    if(!common_scripts\utility::func_562E(param_00.var_9734)) {
      var_01 = common_scripts\utility::func_F92(var_01);
      var_05 = undefined;
      var_06 = 0;
      foreach(var_03 in var_01) {
        if(func_583D(var_03, param_00)) {
          var_05 = var_03;
          if(var_03.var_4D3B) {
            break;
          }
        }
      }

      if(isDefined(var_05)) {
        func_386C(var_05, param_00);
        wait(2);
      }
    }

    wait(1);
  }
}

func_386C(param_00, param_01) {
  self endon("stopRandomTankTargeting");
  param_01.var_9734 = 1;
  param_01 method_825B(param_00.var_116);
  for(;;) {
    if(!func_583D(param_00, param_01)) {
      param_01 method_825D();
      param_01.var_9734 = 0;
      return;
    }

    if(param_01 lib_0503::func_57FA(param_00.var_116)) {
      break;
    }

    wait(0.1);
  }

  wait(0.5);
  lib_0503::func_3C22(param_01);
  func_386D(param_00, param_01);
  wait(1);
  param_01 method_825D();
  param_01.var_9734 = 0;
}

func_386D(param_00, param_01) {
  param_00.var_2DC4 = 1;
  var_02 = getEntArray(param_00.var_1A2, "targetname");
  var_03 = common_scripts\utility::func_46B7(param_00.var_1A2, "targetname");
  var_04 = common_scripts\utility::func_F73(var_02, var_03);
  foreach(var_06 in var_04) {
    if(!isDefined(var_06.var_165)) {
      continue;
    }

    thread func_386E(param_00, param_01, var_06, var_06.var_165);
  }
}

func_386E(param_00, param_01, param_02, param_03) {
  switch (param_02.var_165) {
    case "fx":
      var_04["concrete"] = "concrete_impact_large_chunks";
      var_04["car_explode"] = "veh_opel_blitz_explo_1_rnr";
      playFX(common_scripts\utility::func_44F5(var_04[param_02.var_8260]), param_02.var_116, anglesToForward(param_02.var_1D));
      break;

    case "model_destroy":
      var_05 = [];
      var_05["ger_trans_opel_blitz_cannon_static"] = "ger_trans_opel_blitz_static_exploded";
      var_05["ger_trans_opel_blitz_static"] = "ger_trans_opel_blitz_static_exploded";
      var_06["ger_trans_opel_blitz_cannon_static"] = (0, -90, 0);
      var_06["ger_trans_opel_blitz_static"] = (0, -90, 0);
      var_07 = var_06[param_02.var_106];
      param_02 setModel(var_05[param_02.var_106]);
      if(isDefined(var_07)) {
        param_02.var_1D = param_02.var_1D + var_07;
      }
      break;

    case "delete":
      param_02 delete();
      break;

    case "physics_launch":
      var_08 = param_00.var_116 - param_01.var_116;
      var_08 = (var_08[0], var_08[1], 0);
      var_08 = vectornormalize(var_08);
      var_08 = (var_08[0], var_08[1], 1);
      var_09 = (randomfloat(1), randomfloat(1), randomfloat(1));
      var_09 = vectornormalize(var_08);
      param_02 method_83C9(var_08 * 1000, var_09 * 10000);
      break;

    case "move_gravity":
      var_0A = common_scripts\utility::func_46B5(param_02.var_1A2, "targetname");
      var_0B = param_02.var_817A;
      if(!isDefined(var_0B)) {
        var_0B = 1;
      }

      var_0C = trajectorycalculateinitialvelocity(param_02.var_116, var_0A.var_116, (0, 0, -800), var_0B);
      param_02 gravitymove(var_0C, var_0B);
      param_02 rotateto(var_0A.var_1D, var_0B, 0, var_0B);
      break;

    default:
      break;
  }
}

func_583D(param_00, param_01) {
  if(common_scripts\utility::func_562E(param_00.var_2DC4)) {
    return 0;
  }

  if(!common_scripts\utility::func_562E(param_00.var_4D3B) && isDefined(param_01.var_9EDD) && param_01 method_8221() && isDefined(param_01.var_9EDD method_80E2())) {
    return 0;
  }

  if(isDefined(param_00.var_8172)) {
    var_02 = anglesToForward(param_00.var_1D);
    var_03 = param_01.var_116 - param_00.var_116;
    var_03 = vectornormalize(var_03);
    if(vectordot(var_02, var_03) < param_00.var_8172) {
      return 0;
    }
  }

  if(isDefined(param_00.var_8276)) {
    var_04 = distance(param_01.var_116, param_00.var_116);
    if(var_04 > param_00.var_8276) {
      return 0;
    }
  }

  return 1;
}

func_3854(param_00) {
  var_01 = strtok(param_00.var_8260, " ");
  var_02 = float(var_01[0]);
  var_03 = float(var_01[1]);
  var_04 = float(param_00.var_165);
  var_05 = getEntArray(param_00.var_1A2, "targetname");
  foreach(var_07 in var_05) {
    if(var_07.var_3A == "script_model") {
      continue;
    }

    if(var_07.var_3A == "script_brushmodel") {
      var_07 delete();
    }
  }
}

func_3853(param_00) {
  if(isDefined(level.var_1BB7)) {
    level thread[[level.var_1BB7]](param_00);
    return;
  }

  var_01 = common_scripts\utility::func_46B7(param_00, "targetname");
  foreach(var_03 in var_01) {
    level thread func_3854(var_03);
  }
}

func_3873(param_00) {
  if(func_45D0("escort_turretActive")) {
    func_3874(param_00, game["attackers"]);
  }
}

func_3874(param_00, param_01) {
  if(param_00.var_3A != "script_model") {
    param_00 enablelinkto();
    param_00 method_83EF();
  }

  self.var_4B70 = 1;
  if(!isDefined(self.var_A2C8) || !isDefined(self.var_A2C8.var_9EDD)) {
    return;
  }

  param_00 linkto(self.var_A2C8);
  self.var_A2C8.var_9FA1 = param_00;
  func_386B(param_00);
  lib_0502::isteleportenabled(param_00, param_01, self.var_A2C8.var_9EDD);
}

func_575D(param_00) {
  return param_00.var_18A < 0;
}

func_386B(param_00) {
  self.var_7798 = param_00;
}

func_18F7(param_00) {
  func_6934(param_00);
  func_6963("plantTime", lib_0501::func_4647("bomb_plantTime"), [1, 2, 3, 5, 7.5, 10]);
  func_6963("fuseTime", lib_0501::func_4647("bomb_timer"), [15, 30, 45, 60]);
  func_6963("defuseTime", lib_0501::func_4647("bomb_defuseTime"), [1, 2, 3, 5, 7.5, 10]);
  func_6964("onBombExplodeFunc", undefined);
  func_6964("onMultiBombExplodeFunc", undefined);
  func_6964("disableMultipleScoreEvents", 0);
}

multibombtrigger(param_00) {
  func_190C(param_00, 1);
}

func_190C(param_00, param_01) {
  if(isDefined(param_01) && param_01) {
    self.ismultibomb = 1;
    self.numbombsplanted = 0;
    if(isDefined(param_00.var_8140)) {
      self.numbombsrequired = param_00.var_8140;
    } else {
      self.numbombsrequired = 3;
    }
  } else {
    self.ismultibomb = 0;
  }

  level.var_7929[level.var_7929.size] = param_00;
  param_00 lib_0502::func_7997();
  func_6983(self.var_695A);
  waittillframeend;
  param_00 lib_0502::func_79C6();
  var_02 = undefined;
  if(common_scripts\utility::func_562E(self.var_651B)) {
    var_02 = self.var_81E1;
  }

  self.var_18F9 = 0;
  var_03 = lib_0502::func_4518("target_defend", var_02);
  var_04 = func_45CE(param_00);
  var_05 = maps\mp\gametypes\_gameobjects::func_2837(game["attackers"], param_00, [], var_04, 0, 1);
  func_6942(var_05);
  if(isDefined(var_02)) {
    var_05.var_6515 = var_02;
  }

  var_06 = func_45D0("fuseTime");
  var_05 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_05 func_0990(var_05.var_28D4 + var_05.var_6A1D, undefined, undefined, var_06 * 1000, var_03, 0, 1);
  if(isDefined(level.bomb_entries)) {
    level.bomb_entries = common_scripts\utility::func_972(level.bomb_entries, var_05);
  }

  thread func_190D(param_00, var_05);
  func_6982(self.var_695A);
  self.var_18F9 = 0;
  self notify("end_think");
  self notify("end_hud");
  var_05 maps\mp\gametypes\_gameobjects::func_2F93();
  if(isDefined(level.bomb_entries)) {
    var_05 func_8614();
    var_05 func_860F();
  } else {
    var_05 func_7CCA();
  }

  var_05 maps\mp\gametypes\_gameobjects::deleteuseobjectobjectives();
  waittillframeend;
  var_05 maps\mp\gametypes\_gameobjects::func_2D58();
}

func_190D(param_00, param_01) {
  self endon("end_think");
  var_02 = undefined;
  if(isDefined(param_01.var_6515)) {
    var_02 = param_01.var_6515;
  }

  for(;;) {
    param_01 maps\mp\gametypes\_gameobjects::func_C30("friendly");
    param_01 maps\mp\gametypes\_gameobjects::func_8A57(&"RAIDS_USE_PLACE_EXPLOSIVE");
    param_01 maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_USING_PLACE_EXPLOSIVE");
    param_01 maps\mp\gametypes\_gameobjects::func_8A5A(func_45D0("plantTime"));
    var_03 = lib_0502::func_4518("target_defend", var_02);
    param_01 func_860A(var_03, var_02);
    param_01 func_8616(var_03);
    param_01.var_502A = "raidPlantExplosive";
    param_01.var_6BBF = ::func_18F9;
    param_01.var_6ABC = ::func_6AC6;
    param_01.var_6AFA = ::func_6AC7;
    param_01.var_A248 = "search_dstry_bomb_mp";
    param_01.var_A23C = 0;
    param_01.var_A23E = 9;
    param_01.var_113F = 0;
    param_01.var_7894 = 1;
    param_00.var_18F6 = param_01;
    self waittill("bomb_planted", var_04);
    level notify("bomb_planted");
    self.var_18F9 = 1;
    func_79B2(self.var_695A);
    thread func_1909(param_00, var_04);
    param_01 maps\mp\gametypes\_gameobjects::func_C30("enemy");
    param_01 maps\mp\gametypes\_gameobjects::func_8A57(&"RAIDS_USE_DEFUSE");
    param_01 maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_USING_DEFUSE");
    param_01 maps\mp\gametypes\_gameobjects::func_8A5A(func_45D0("defuseTime"));
    var_03 = lib_0502::func_4518("defend_defuse", var_02);
    param_01 func_860A(var_03, var_02);
    param_01 func_8617("bomb", var_03);
    param_01.var_502A = "raidDefuseExplosive";
    param_01.var_6BBF = ::func_18D3;
    param_01.var_6ABC = ::func_6AC4;
    param_01.var_6AFA = ::func_6AC5;
    param_01.var_A248 = "search_dstry_bomb_defuse_mp";
    param_01.var_A23C = 0;
    param_01.var_A23E = 10;
    param_01.var_113F = 0;
    param_01.var_7894 = 1;
    param_00.var_18F6 = param_01;
    var_05 = common_scripts\utility::func_A717("bomb_defused", "multi_bomb_explode");
    var_06 = var_05[0];
    if(var_06 == "bomb_defused") {
      level notify("bomb_defused");
    }

    self.var_18F9 = 0;
    func_79B3(self.var_695A);
  }
}

func_6AC6(param_00) {
  func_79B2(self.var_695A);
  param_00.var_581C = 1;
  var_01 = undefined;
  if(isDefined(self.var_6515)) {
    var_01 = self.var_6515;
  }

  var_02 = lib_0502::func_4518("planting_defend", var_01);
  func_860A(var_02, var_01);
  func_8613(var_02);
  func_8CFD(param_00);
}

func_6AC7(param_00, param_01, param_02) {
  self.var_79AD notify("bomb_planting_end", param_01);
  func_79B3(self.var_79AD.var_695A);
  if(isDefined(param_01)) {
    param_01.var_581C = 0;
  }

  if(!param_02) {
    var_03 = undefined;
    if(isDefined(self.var_6515)) {
      var_03 = self.var_6515;
    }

    var_04 = lib_0502::func_4518("target_defend", var_03);
    func_860A(var_04, var_03);
    func_8613(var_04);
  }

  if(isDefined(param_01)) {
    func_A088(param_01);
  }
}

func_6AC4(param_00) {
  self.var_79AD notify("bomb_defusing", param_00);
  param_00.var_581C = 1;
  var_01 = undefined;
  if(isDefined(self.var_6515)) {
    var_01 = self.var_6515;
  }

  var_02 = lib_0502::func_4518("defend_defusing", var_01);
  func_860A(var_02, var_01);
  func_8613(var_02);
  func_8CFD(param_00);
}

func_6AC5(param_00, param_01, param_02) {
  param_01.var_581C = 0;
  if(func_5761(self.var_695A)) {
    return;
  }

  if(!param_02) {
    var_03 = undefined;
    if(isDefined(self.var_6515)) {
      var_03 = self.var_6515;
    }

    var_04 = lib_0502::func_4518("defend_defuse", var_03);
    func_860A(var_04, var_03);
    func_8613(var_04);
    self.var_79AD notify("bomb_defuse_fail", param_01);
  }

  func_A088(param_01);
}

func_18F9(param_00) {
  self.var_79AD notify("bomb_planted", param_00);
  if(isDefined(self.var_79AD.ismultibomb) && self.var_79AD.ismultibomb) {
    var_01 = 1;
  } else {
    var_01 = 0;
  }

  param_00 thread maps\mp\_events::func_18FC(undefined, var_01);
}

func_18D3(param_00) {
  self.var_79AD notify("bomb_defused", param_00);
  param_00 thread maps\mp\_events::func_18D4("defuse");
}

func_1909(param_00, param_01) {
  func_190A(func_45D0("fuseTime"), param_00, param_01);
}

func_190A(param_00, param_01, param_02) {
  self endon("bomb_defused");
  self endon("end_think");
  self.var_2CA0 = gettime() + param_00 * 1000;
  var_03 = param_01.var_982D["bomb_model"][0];
  if(isDefined(var_03)) {
    var_04 = var_03.var_116;
  } else {
    var_04 = param_02.var_116;
  }

  var_05 = 0;
  while(self.var_2CA0 > gettime()) {
    if(var_05 != 0) {
      lib_04F3::func_79CB("dynamite_timer_tick", var_04);
    } else {
      lib_04F3::func_79CB("dynamite_timer_tock", var_04);
    }

    var_05 = var_05 + 1 % 2;
    var_06 = self.var_2CA0 - gettime() / 1000;
    var_07 = 0.05;
    if(var_06 > 5) {
      var_07 = 1;
    } else if(var_06 > 3.5) {
      var_07 = 0.5;
    } else if(var_06 > 1.25) {
      var_07 = 0.25;
    }

    maps\mp\gametypes\_hostmigration::func_A783(var_07);
    if(isDefined(level.var_4E09)) {
      var_08 = maps\mp\gametypes\_hostmigration::func_A782();
      self.var_2CA0 = self.var_2CA0 + var_08;
    }
  }

  maps\mp\gametypes\_hostmigration::func_A782();
  if(self.ismultibomb) {
    self.numbombsplanted++;
    if(self.numbombsplanted >= self.numbombsrequired) {
      func_18ED(param_01, param_02, 1);
    } else {
      func_18ED(param_01, param_02, 0);
      self notify("multi_bomb_explode");
    }

    if(!isDefined(level.bomb_entries)) {
      param_01.var_18F6 lib_04FA::set_image_timer_num_sections(self.numbombsplanted);
    }
  } else {
    func_18ED(param_01, param_02, 1);
  }

  func_79B3(self.var_695A);
  if((self.ismultibomb && self.numbombsplanted >= self.numbombsrequired) || !self.ismultibomb) {
    func_6935(self.var_695A);
  }
}

func_18F3(param_00) {
  var_01 = lib_0502::func_207E("trigger");
  if(var_01 lib_0502::func_207D("killcam_ent").size < 1) {
    var_01 thread func_1904(param_00);
  }

  param_00 lib_0502::func_7997();
  func_6983(self.var_695A);
  thread func_18F4(param_00);
  func_6982(self.var_695A);
  param_00 delete();
}

func_1900(param_00) {
  var_01 = lib_0502::func_207E("trigger");
  var_01.var_5A2C = spawn("script_model", param_00.var_116);
  var_01.var_5A2C setscriptmoverkillcam("explosive");
}

func_1904(param_00) {
  var_01 = spawn("script_origin", param_00.var_116);
  var_01.var_1D = param_00.var_1D;
  var_01 rotateyaw(-45, 0.05);
  wait 0.05;
  var_02 = param_00.var_116 + (0, 0, 5);
  var_03 = param_00.var_116 + anglesToForward(var_01.var_1D) * 100 + (0, 0, 96);
  var_04 = bulletTrace(var_02, var_03, 0, param_00);
  self.var_5A2C = spawn("script_model", var_04["position"]);
  self.var_5A2C setscriptmoverkillcam("explosive");
  var_01 delete();
}

func_18F4(param_00) {
  self endon("end_think");
  for(;;) {
    param_00 lib_0502::func_7997();
    self waittill("bomb_planted");
    func_6981(self.var_695A, "bomb_planted", 0);
    param_00 lib_0502::func_79C6();
    var_01 = "";
    for(;;) {
      var_02 = common_scripts\utility::func_A717("bomb_explode", "bomb_defused", "bomb_defusing", "bomb_defuse_fail");
      var_01 = var_02[0];
      var_03 = var_02[1];
      if(var_01 == "bomb_defusing" && isDefined(var_03)) {
        param_00 hidefromclient(var_03);
      }

      if(var_01 == "bomb_defuse_fail" && isDefined(var_03)) {
        param_00 showtoclient(var_03);
      }

      if(var_01 == "bomb_explode" || var_01 == "bomb_defused") {
        break;
      }
    }

    if(var_01 == "bomb_defused") {
      continue;
    }

    break;
  }
}

func_1902(param_00) {
  param_00 method_805C();
  func_6983(self.var_695A);
  param_00 thread lib_0502::func_8C21(game["attackers"]);
  thread func_A0E6(param_00, game["defenders"], game["attackers"]);
  func_6982(self.var_695A);
  param_00 delete();
}

bombsiteobjectivemodeldestroyed(param_00) {
  param_00 method_805C();
  func_6983(self.var_695A);
  param_00 method_805C();
  func_6982(self.var_695A);
  playFXOnTag(level.var_611["objective_exposion"], param_00, "TAG_ORIGIN");
  param_00 method_805B();
}

func_1901(param_00) {
  func_6983(self.var_695A);
  param_00 thread lib_0502::func_8C21(game["defenders"]);
  thread func_A0E6(param_00, game["attackers"], game["defenders"]);
  func_6982(self.var_695A);
  param_00 delete();
}

func_A0E6(param_00, param_01, param_02) {
  param_00 endon("death");
  for(;;) {
    self waittill("bomb_planted");
    param_00 thread lib_0502::func_8C21(param_01);
    self waittill("bomb_defused");
    param_00 thread lib_0502::func_8C21(param_02);
  }
}

func_18ED(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(isDefined(self.ismultibomb) && self.ismultibomb) {
    var_03 = func_45D0("onMultiBombExplodeFunc");
    if(isDefined(var_03)) {
      [[var_03]](self);
    }
  }

  var_04 = func_45D0("onBombExplodeFunc");
  if(isDefined(var_04)) {
    [[var_04]](param_00, param_01);
  }

  var_05 = 400;
  var_06 = 200;
  var_07 = 40;
  param_00 thread func_2CDE(0.5, param_00.var_116, var_05, var_06, var_07, param_01, "MOD_EXPLOSIVE", "bomb_site_mp");
  var_08 = param_00.var_982D["bomb_model"][0];
  if(isDefined(var_08)) {
    var_09 = var_08.var_116;
  } else {
    var_09 = param_01.var_116;
  }

  lib_04F3::func_79CB("mp_war_bomb_explo", var_09);
  var_0A = randomfloat(360);
  var_0B = var_09 + (0, 0, 50);
  thread func_2CD7(0.2, var_0B, var_09);
  thread func_2CDA(1, var_0B);
  if(isDefined(param_01)) {
    thread func_2CD8(1.5, param_01);
  }

  if(param_02) {
    level.agent_definition = 1;
    self notify("bomb_explode");
    return;
  }

  level.anybombexploded = 1;
}

func_2CD8(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("disconnect");
  wait(param_00);
  if(!func_45D0("disableMultipleScoreEvents") || !common_scripts\utility::func_562E(level.firstbombexploded)) {
    param_01 maps\mp\_events::func_18D6();
    if(func_45D0("disableMultipleScoreEvents")) {
      level.firstbombexploded = 1;
    }
  }

  level thread maps\mp\_utility::func_9863("raids_callout_capture", param_01);
}

func_2CD7(param_00, param_01, param_02) {
  level endon("game_ended");
  wait(param_00);
  physicsexplosionsphere(param_01, 200, 100, 3);
  function_01BB("grenade_rumble", param_02);
  if(isDefined(level.custom_earthquake_scale)) {
    earthquake(level.custom_earthquake_scale, level.custom_earthquake_duration, param_02, 2000);
    return;
  }

  earthquake(0.75, 2, param_02, 2000);
}

func_2CDE(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  level endon("game_ended");
  if(maps\mp\_utility::func_4571() != "mp_raid_dlc3") {
    wait(param_00);
  }

  if(isDefined(param_05)) {
    self entityradiusdamage(param_01, param_02, param_03, param_04, param_05, param_06, param_07);
    return;
  }

  self entityradiusdamage(param_01, param_02, param_03, param_04, undefined, param_06, param_07);
}

func_2CDA(param_00, param_01) {
  level endon("game_ended");
  wait(param_00);
  lib_04F7::func_5A4F(param_01, 750);
  lib_04F7::func_2F99(param_01, 750);
  if(level.var_79AE.var_8DB.size > 0) {
    lib_0502::func_8628(level.var_79AE.var_8DB[0].var_695A);
  }
}

func_2C9D(param_00) {
  func_6934(param_00);
  func_6963("plantTime", 3, [1, 2, 3, 5, 7.5, 10]);
  func_6963("defuseTime", 3, [1, 2, 3, 5, 7.5, 10]);
  func_6964("onBombExplodeFunc", undefined);
  self.var_1903 = [];
  var_01 = common_scripts\utility::func_46B7(self.var_1A2, "targetname");
  var_02 = getEntArray(self.var_1A2, "targetname");
  self.var_1903 = common_scripts\utility::func_F73(var_01, var_02);
  foreach(var_04 in self.var_1903) {
    var_04 thread func_2CA7(self);
  }

  thread func_2C9E();
}

func_2C9E() {
  self endon("end_think");
  func_6983(self.var_695A);
  foreach(var_01 in self.var_1903) {
    var_01 notify("objStart");
  }

  var_03 = func_6939();
  var_03.var_E5 = &"RAIDS_RESUPPLY_BAR_FUEL_A";
  var_04 = func_6938();
  func_A177(var_03, 0);
  var_05 = 0;
  for(;;) {
    common_scripts\utility::knock_off_battery("bomb_defused", "bomb_planted");
    var_06 = 0;
    foreach(var_01 in self.var_1903) {
      if(common_scripts\utility::func_562E(var_01.var_56C1)) {
        var_06++;
      }
    }

    var_09 = clamp(var_06 / self.var_1903.size, 0, 1);
    func_A177(var_03, var_09);
    func_A0E4(var_04, var_09);
    if(var_06 == self.var_1903.size) {
      func_6935(self.var_695A);
      wait(1);
      var_03 maps\mp\gametypes\_hud_util::func_2DCC();
      var_04 maps\mp\gametypes\_hud_util::func_2DCC();
      return;
    }
  }
}

func_2CA7(param_00) {
  self.var_2459 = param_00;
  var_01 = common_scripts\utility::func_46B7(self.var_1A2, "targetname");
  var_02 = getEntArray(self.var_1A2, "targetname");
  self.var_982D = common_scripts\utility::func_F73(var_01, var_02);
  foreach(var_04 in self.var_982D) {
    switch (var_04.var_165) {
      case "bomb_model":
        break;

      case "objective_icon":
        break;

      case "objective_model":
        break;

      case "nonobjective_model":
        break;
    }
  }

  func_6983(self.var_2459.var_695A);
  var_06 = func_45CE(self);
  var_07 = maps\mp\gametypes\_gameobjects::func_2837(game["attackers"], self, [], var_06, 0, 1);
  var_07.var_79AD = self;
  var_07 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_07 func_0990(var_07.var_28D4 + var_07.var_6A1D, undefined, undefined, 1000, 8, 0, 1);
  thread func_2CA8(self, var_07);
  func_6982(self.var_2459.var_695A);
  self notify("end_think");
  self notify("end_hud");
  var_07 maps\mp\gametypes\_gameobjects::func_2F93();
  var_07 func_7CCA();
  var_07 maps\mp\gametypes\_gameobjects::deleteuseobjectobjectives();
  waittillframeend;
  var_07 maps\mp\gametypes\_gameobjects::func_2D58();
}

func_2CA8(param_00, param_01) {
  self endon("end_think");
  param_00.var_56C1 = 0;
  for(;;) {
    param_01 maps\mp\gametypes\_gameobjects::func_C30("friendly");
    param_01 maps\mp\gametypes\_gameobjects::func_8A57(&"RAIDS_USE_DEFUSE");
    param_01 maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_USING_DEFUSE");
    param_01 maps\mp\gametypes\_gameobjects::func_8A5A(self.var_2459 func_45D0("defuseTime"));
    param_01 func_860D(19);
    param_01 func_8614(19);
    param_01.var_502A = "raidDefuseExplosive";
    param_01.var_6BBF = ::func_18D3;
    param_01.var_6ABC = ::func_2C99;
    param_01.var_6AFA = ::func_2C9A;
    param_01.var_A248 = "war_dynamite_disarm_mp";
    param_01.var_A23E = 10;
    param_01.var_113F = 0;
    param_00.var_18F6 = param_01;
    self waittill("bomb_defused");
    param_00.var_56C1 = 1;
    self.var_2459 notify("bomb_defused");
    param_01 maps\mp\gametypes\_gameobjects::func_C30("enemy");
    param_01 maps\mp\gametypes\_gameobjects::func_8A57(&"RAIDS_USE_PLACE_EXPLOSIVE");
    param_01 maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_USING_PLACE_EXPLOSIVE");
    param_01 maps\mp\gametypes\_gameobjects::func_8A5A(self.var_2459 func_45D0("plantTime"));
    param_01 func_860D(18);
    param_01 func_8614(18);
    param_01.var_502A = "raidPlantExplosive";
    param_01.var_6BBF = ::func_18F9;
    param_01.var_6ABC = ::func_2C9B;
    param_01.var_6AFA = ::func_2C9C;
    param_01.var_A248 = "war_dynamite_mp";
    param_01.var_A23E = 9;
    param_01.var_113F = 0;
    param_01.var_7894 = 1;
    param_00.var_18F6 = param_01;
    self waittill("bomb_planted", var_02);
    param_00.var_56C1 = 0;
    self.var_2459 notify("bomb_planted");
  }
}

func_2C9B(param_00) {
  func_79B2(self.var_695A);
  param_00.var_581C = 1;
  func_860D(20);
  func_8616(20);
  func_8CFD(param_00);
}

func_2C9C(param_00, param_01, param_02) {
  self.var_79AD notify("bomb_planting_end", param_01);
  func_79B3(self.var_79AD.var_695A);
  param_01.var_581C = 0;
  if(!param_02) {
    func_860D(18);
    func_8616(18);
  }

  func_A088(param_01);
}

func_2C99(param_00) {
  self.var_79AD notify("bomb_defusing", param_00);
  param_00.var_581C = 1;
  func_860D(21);
  func_8617("bomb", 21);
  func_8CFD(param_00);
}

func_2C9A(param_00, param_01, param_02) {
  param_01.var_581C = 0;
  if(!param_02) {
    func_860D(19);
    func_8617("bomb", 19);
  }

  func_A088(param_01);
}

func_2CA1(param_00) {
  func_6934(param_00);
  func_6963("defuseTime", 3, [1, 2, 3, 5, 7.5, 10]);
  if(!isDefined(level.var_693C)) {
    level.var_693C = spawnStruct();
    level.var_693C.var_9AB2 = 1;
    level.var_693C.var_6888 = 0;
    level.var_693C.var_7767 = func_6939();
    level.var_693C.var_7767.var_E5 = &"RAIDS_DEFUSES";
    level.var_693C.var_7767 setvalue(level.var_693C.var_6888);
    level.var_693C.var_7764 = func_6938();
    level.var_693C.var_7767.var_18 = 0;
    level.var_693C.var_7764.var_18 = 0;
    level.var_693C.var_7764.var_1586.var_18 = 0;
    return;
  }

  level.var_693C.var_9AB2++;
}

func_2CAA(param_00) {
  level.var_7929[level.var_7929.size] = param_00;
  func_6983(self.var_695A);
  waittillframeend;
  if(level.var_693C.var_7764.var_18 == 0) {
    level.var_693C.var_7767.var_18 = 1;
    level.var_693C.var_7764.var_18 = 1;
    level.var_693C.var_7764.var_1586.var_18 = 1;
  }

  var_01 = func_45CE(param_00);
  var_02 = maps\mp\gametypes\_gameobjects::func_2837(game["attackers"], param_00, [], var_01, 0, 1);
  func_6942(var_02);
  var_03 = func_45D0("defuseTime");
  var_02 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_02 func_0990(var_02.var_28D4 + var_02.var_6A1D, undefined, undefined, var_03 * 1000, 19, 0, 1, undefined, undefined, 1);
  thread func_2CAB(param_00, var_02);
  func_6982(self.var_695A);
  self notify("end_think");
  self notify("end_hud");
  var_02 maps\mp\gametypes\_gameobjects::func_2F93();
  var_02 func_7CCA();
  var_02 maps\mp\gametypes\_gameobjects::deleteuseobjectobjectives();
  waittillframeend;
  var_02 maps\mp\gametypes\_gameobjects::func_2D58();
}

func_2CAB(param_00, param_01) {
  self endon("end_think");
  for(;;) {
    self.var_18F9 = 1;
    thread func_2C98(param_00);
    param_01 maps\mp\gametypes\_gameobjects::func_C30("friendly");
    param_01 maps\mp\gametypes\_gameobjects::func_8A57(&"RAIDS_USE_DEFUSE");
    param_01 maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_USING_DEFUSE");
    param_01 maps\mp\gametypes\_gameobjects::func_8A5A(func_45D0("defuseTime"));
    param_01 func_860D(19);
    param_01 func_8614(19);
    param_01.var_502A = "raidDefuseExplosive";
    param_01.var_6BBF = ::func_2CA4;
    param_01.var_6ABC = ::func_2CA2;
    param_01.var_6AFA = ::func_2CA3;
    param_01.var_A248 = "war_dynamite_disarm_mp";
    param_01.var_A23E = 10;
    param_01.var_113F = 0;
    param_00.var_18F6 = param_01;
    self waittill("bomb_defused");
    level.var_693C.var_6888++;
    var_02 = clamp(level.var_693C.var_6888 / level.var_693C.var_9AB2, 0, 1);
    func_A0E4(level.var_693C.var_7764, var_02);
    level.var_693C.var_7767 setvalue(level.var_693C.var_6888);
    if(level.var_693C.var_6888 >= level.var_693C.var_9AB2) {
      thread func_2C93();
    } else {
      func_6981(self.var_695A, "defuse", 0);
    }

    self.var_18F9 = 0;
    break;
  }

  func_6935(self.var_695A);
}

func_2C93() {
  wait(1);
  level.var_693C.var_7767 maps\mp\gametypes\_hud_util::func_2DCC();
  level.var_693C.var_7764 maps\mp\gametypes\_hud_util::func_2DCC();
  level.var_693C = undefined;
}

func_2CA2(param_00) {
  self.var_79AD notify("bomb_defusing", param_00);
  param_00.var_581C = 1;
  func_79B2(self.var_79AD.var_695A);
  func_860D(21);
  func_8614(21);
  func_8CFD(param_00);
}

func_2CA3(param_00, param_01, param_02) {
  param_01.var_581C = 0;
  func_79B3(self.var_79AD.var_695A);
  if(!param_02) {
    func_860D(19);
    func_8614(19);
  }

  func_A088(param_01);
}

func_2CA4(param_00) {
  self.var_79AD notify("bomb_defused", param_00);
  param_00 thread maps\mp\_events::func_18D4("defuse");
}

func_2C98(param_00) {
  self endon("bomb_defused");
  self endon("end_think");
  var_01 = param_00.var_982D["bomb_model"][0];
  if(isDefined(var_01)) {
    var_02 = var_01.var_116;
  } else {
    var_02 = var_01.var_116;
  }

  var_03 = 0;
  for(;;) {
    if(var_03 != 0) {
      lib_04F3::func_79CB("dynamite_timer_tick", var_02);
    } else {
      lib_04F3::func_79CB("dynamite_timer_tock", var_02);
    }

    var_03 = var_03 + 1 % 2;
    var_04 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
    var_05 = 0.15;
    if(var_04 > 60) {
      var_05 = 1;
    } else if(var_04 > 30) {
      var_05 = 0.5;
    } else if(var_04 > 10) {
      var_05 = 0.3;
    }

    wait(var_05);
  }
}

func_2C94(param_00) {
  param_00 lib_0502::func_7997();
  func_6983(self.var_695A);
  param_00 lib_0502::func_79C6();
  thread func_18F4(param_00);
  func_6982(self.var_695A);
  param_00 delete();
}

func_2C95(param_00) {
  self endon("end_think");
  for(;;) {
    param_00 setModel("par_dynamite_01");
    self waittill("bomb_defused");
    break;
  }
}

func_2C97(param_00) {
  param_00 method_805C();
  func_6983(self.var_695A);
  param_00 thread lib_0502::func_8C21(game["attackers"]);
  func_6982(self.var_695A);
  param_00 delete();
}

func_2C96(param_00) {
  func_6983(self.var_695A);
  param_00 thread lib_0502::func_8C21(game["defenders"]);
  func_6982(self.var_695A);
  param_00 notify("clear");
  param_00 method_805B();
}

hostageobjectiveinit(param_00) {
  func_6934(param_00);
  var_01 = [0.5, 1, 2, 3, 5, 10, 15, 20];
  func_6963("hostageRescueTime", lib_0501::func_4647("hostage_untieUseTime"), var_01);
  func_6963("firstDoorUseOpenTime", lib_0501::func_4647("hostage_doorUseTime"), var_01);
  func_6963("doorUseOpenTime", 0.25, var_01);
  func_6963("doorUseCloseTime", 0.25, var_01);
  func_6963("doorMoveTime", 0.4, [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]);
  func_6965("hostageAnimationSet", 2);
  if(isDefined(level.raidhostagecount) == 0) {
    level.raidhostagecount = 0;
  }

  self.numhostages = 0;
  self.hostageinuse = 0;
  self.hostageoriginarray = [];
  self.var_3290 = [];
  self.doorunlocked = 0;
  self.numhostagesstart = self.var_982D["hostage_rescue_trigger"].size;
  func_6983(self.var_695A);
  var_02 = undefined;
  if(common_scripts\utility::func_562E(self.var_651B)) {
    var_02 = self.var_81E1;
  }

  var_03 = self.var_982D["door_clip"][0].var_982D["objective_icon"][0].var_116;
  var_04 = lib_0502::func_4518("rescue_hostage", var_02);
  self.var_A23F = 1000 * self.numhostagesstart + 1;
  var_05 = var_03 - self.var_116;
  func_0990(self.var_116, undefined, var_05, self.var_A23F, var_04, 0, 1, 0, 1, 0, undefined, undefined, undefined, undefined, 3);
  func_8615(0);
  var_06 = func_27DE(self.var_81E8, game["attackers"], var_03);
  var_06 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_06 func_860D(var_04);
  self.var_2563 = var_06;
  thread handlehostageicon();
  hostageluabarcleanup();
}

hostageluabarcleanup() {
  func_6982(self.var_695A);
  if(isDefined(self.var_651B)) {
    func_6982(self.var_6E78);
  }

  func_7CCA();
}

hostageobjectivetrigger(param_00) {
  var_01 = [];
  var_02 = maps\mp\gametypes\_gameobjects::func_2837(game["attackers"], param_00, var_01, undefined, 1);
  func_6942(var_02);
  var_02 maps\mp\gametypes\_gameobjects::func_2F93();
  var_02 maps\mp\gametypes\_gameobjects::func_86CD(0);
  param_00.var_3290 = [];
  level.raidhostagecount++;
  self.numhostages++;
  var_03 = param_00.var_982D["objective_icon"][0].var_116;
  self.hostageoriginarray[self.hostageoriginarray.size] = var_03;
  func_6983(self.var_695A);
  var_02 maps\mp\gametypes\_gameobjects::func_365D();
  var_02 maps\mp\gametypes\_gameobjects::func_C30("friendly");
  var_02 maps\mp\gametypes\_gameobjects::func_8A5A(func_45D0("hostageRescueTime"));
  var_02 maps\mp\gametypes\_gameobjects::func_8A59(&"MP_CAPTURING_OBJECTIVE");
  var_02 maps\mp\gametypes\_gameobjects::func_8A57(&"RAIDS_USE_HOSTAGE");
  var_02 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_02 maps\mp\gametypes\_gameobjects::func_86CD(1);
  var_02.var_A23E = 18;
  var_02.var_6BBF = ::onusehostageobjectiveuse;
  var_02.var_6ABC = ::onusehostagebeginuse;
  var_02.var_6AFA = ::onusehostageenduse;
  var_02.var_113F = 0;
  var_02.var_A248 = "war_rope_untie_mp";
  var_04 = var_02.var_9D65.var_982D["visuals"][0];
  var_02.hostagevisual = spawnanimatedhostage(var_04.var_116, var_04.var_1D, self);
  hostageobjectivetriggerusewait(var_02);
  self.hostageoriginarray = common_scripts\utility::func_F93(self.hostageoriginarray, var_03);
  self notify("hostage_use");
  var_02 maps\mp\gametypes\_gameobjects::func_2F93();
  var_02 maps\mp\gametypes\_gameobjects::deleteuseobjectobjectives();
  waittillframeend;
  var_02 maps\mp\gametypes\_gameobjects::func_2D58();
  param_00 delete();
}

hostagebuildingtrigger(param_00) {
  level.raidhostageobjectivetrigger[level.raidhostageobjectivetrigger.size] = param_00;
  if(isDefined(self.var_651B)) {
    func_6982(self.var_6E78);
  } else {
    func_6982(self.var_695A);
  }

  lib_04F7::func_5A4F(param_00.var_116, 750);
  lib_04F7::func_2F99(param_00.var_116, 750);
}

watchhostagetrigger(param_00) {
  for(;;) {
    param_00.touchingattacker = undefined;
    foreach(var_02 in level.var_744A) {
      if(var_02.var_1A7 == game["attackers"]) {
        if(!isalive(var_02)) {
          continue;
        }

        if(var_02 istouching(param_00)) {
          param_00.touchingattacker = var_02;
          break;
        }
      }
    }

    wait 0.05;
  }
}

handlehostagecontesticon(param_00) {
  self endon("hostage_icon_death");
  var_01 = self.var_982D["hostage_building_trigger"][0];
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;
  var_05 = undefined;
  if(common_scripts\utility::func_562E(self.var_651B)) {
    var_05 = self.var_81E1;
  }

  childthread watchhostagetrigger(var_01);
  for(;;) {
    if(isDefined(var_01.touchingattacker) && !var_02 && !var_03) {
      if(!self.doorunlocked) {
        var_06 = lib_0502::func_4518("rescue_contest", var_05);
        func_8613(var_06);
        self.var_2563 func_860A(var_06);
      } else {
        var_06 = lib_0502::func_4518("rescue_contest", var_06);
        func_8613(var_06);
        self.var_2563 func_860A(var_06);
      }

      var_02 = 1;
    } else if(!isDefined(var_01.touchingattacker) && var_02 && !var_03) {
      if(!self.doorunlocked) {
        var_06 = lib_0502::func_4518("rescue_hostage", var_05);
        func_8613(var_06);
        self.var_2563 func_860A(var_06);
      } else {
        var_06 = lib_0502::func_4518("rescue_hostage", var_06);
        func_8613(var_06);
        self.var_2563 func_860A(var_06);
      }

      var_02 = 0;
    }

    if(common_scripts\utility::func_562E(self.doorinuse) || common_scripts\utility::func_562E(self.hostageinuse)) {
      if(!var_03) {
        var_06 = lib_0502::func_4518("rescuing_contest", var_05);
        func_8613(var_06);
        self.var_2563 func_860A(var_06);
        var_03 = 1;
      }
    } else if(var_03 && !var_02 && !common_scripts\utility::func_562E(self.doorinuse)) {
      var_06 = lib_0502::func_4518("rescue_hostage", var_05);
      func_8613(var_06);
      self.var_2563 func_860A(var_06);
      var_03 = 0;
    } else if(var_03) {
      var_03 = 0;
      var_02 = 0;
    }

    if(var_03) {
      self.var_5024 = "inUse";
    } else if(var_02) {
      self.var_5024 = "contested";
    } else {
      self.var_5024 = "none";
      if(gettime() - var_04 < 150) {
        var_06 = lib_0502::func_4518("rescue_hostage", var_05);
        func_8613(var_06);
        self.var_2563 func_860A(var_06);
      }
    }

    if(isDefined(var_01.touchingattacker)) {
      var_04 = gettime();
    }

    wait 0.05;
  }
}

handlehostageicon() {
  self endon("hostage_icon_death");
  func_6983(self.var_695A);
  var_00 = undefined;
  var_01 = undefined;
  if(common_scripts\utility::func_562E(self.var_651B)) {
    var_01 = self.var_81E1;
  }

  foreach(var_03 in self.var_3290) {
    if(var_03.var_6BE1) {
      continue;
    }

    if(!isDefined(var_00)) {
      var_00 = var_03;
      continue;
    }

    if(var_03.var_81E1 < var_00.var_81E1) {
      var_00 = var_03;
    }
  }

  thread handlehostagecontesticon();
  thread watchhostagedeleteicon();
  while(!self.doorunlocked) {
    self waittill("door_use");
  }

  hostageobjectiveseticonlocation(self.var_2563, hostageiconloc());
  self.var_50A9.var_500F.var_116 = hostageiconloc();
  self waittill("hostage_use");
}

watchhostagedeleteicon() {
  self endon("game_ended");
  func_6982(self.var_695A);
  self notify("hostage_icon_death");
  var_00 = undefined;
  if(common_scripts\utility::func_562E(self.var_651B)) {
    var_00 = self.var_81E1;
  }

  var_01 = lib_0502::func_4518("rescue_hostage", var_00);
  func_8613(var_01);
  self.var_2563 maps\mp\gametypes\_gameobjects::func_2D58();
}

hostageiconloc() {
  var_00 = undefined;
  foreach(var_02 in self.hostageoriginarray) {
    if(!isDefined(var_00)) {
      var_00 = var_02;
    }

    if(var_00 != var_02) {
      var_00 = var_02 + var_00 / 2;
    }
  }

  return var_00;
}

hostageobjectiveseticon(param_00, param_01, param_02) {
  var_03 = self.var_81E8;
  param_00 maps\mp\gametypes\_gameobjects::func_860A("friendly", param_01 + var_03);
  param_00 maps\mp\gametypes\_gameobjects::func_860A("enemy", param_02 + var_03);
  param_00 maps\mp\gametypes\_gameobjects::func_860E("friendly", param_01 + var_03);
  param_00 maps\mp\gametypes\_gameobjects::func_860E("enemy", param_02 + var_03);
}

hostageobjectiveseticonlocation(param_00, param_01) {
  if(isDefined(param_00.var_698A)) {
    objective_position(param_00.var_698A, param_01);
  }

  if(isDefined(param_00.var_698B)) {
    objective_position(param_00.var_698B, param_01);
  }

  if(isDefined(param_00.var_698C)) {
    objective_position(param_00.var_698C, param_01);
  }

  if(isDefined(param_00.var_6996)) {
    foreach(var_03 in param_00.var_6996) {
      var_03 maps\mp\gametypes\_objpoints::func_A145(param_01);
    }
  }
}

hostageobjectivetriggerusewait(param_00) {
  param_00 endon("used");
  func_6982(self.var_695A);
}

onusehostageobjectiveuse(param_00) {
  self notify("used");
  level.raidhostagecount--;
  self.var_79AD.numhostages--;
  var_01 = self.var_79AD.var_81E8;
  level notify("hostage" + var_01 + "_rescued");
  lib_0502::raidawardhostagereleasedevent(param_00);
  self.hostagevisual notify("hostage_update", "RELEASE");
  self.hostageused = 1;
  self.var_79AD func_8615(self.var_79AD.numhostagesstart - self.var_79AD.numhostages + 1 * 1000);
  var_02 = "rescue" + var_01;
  if(self.var_79AD.numhostages <= 0) {
    var_02 = "both" + var_01;
  }

  if(level.raidhostagecount <= 0) {
    func_6981(self.var_695A, var_02, 0, 0);
  } else {
    func_6981(self.var_695A, var_02, 0);
  }

  if(self.var_79AD.numhostages <= 0) {
    level notify("hostage" + var_01 + "_complete");
    self.var_79AD func_860F();
    func_6935(self.var_79AD.var_695A);
  }
}

onusehostagebeginuse(param_00) {
  self.var_79AD.hostageinuse++;
  self.var_79AD notify("hostage_use");
  func_79B2(self.var_79AD.var_695A);
  self.hostagevisual notify("hostage_update", "INTERACT");
  if(isDefined(level.onhostagebeginuse)) {
    self thread[[level.onhostagebeginuse]](param_00);
  }
}

onusehostageenduse(param_00, param_01, param_02) {
  self.var_79AD.hostageinuse--;
  if(!param_02) {
    self.hostagevisual notify("hostage_update", "IDLE");
  }

  self.var_79AD notify("hostage_use");
  func_79B3(self.var_79AD.var_695A);
  if(isDefined(level.onhostageenduse)) {
    self thread[[level.onhostageenduse]](param_01, param_02);
  }
}

hostagedoorclip(param_00) {
  var_01 = param_00 lib_0502::func_207C("visuals");
  self.var_3290[self.var_3290.size] = param_00;
  param_00.var_9DC2 = [];
  var_02 = func_45CE(param_00);
  param_00.iconorigin = var_02 + param_00.var_116;
  if(!isDefined(param_00.var_81E1)) {
    param_00.var_81E1 = 0;
  }

  thread hostagedoorshutdown(param_00);
  param_00.var_6BE1 = 0;
  for(;;) {
    param_00 waittill("trigger", var_03, var_04);
    switch (var_03) {
      case "open":
        var_05 = func_45D0("doorMoveTime");
        if(isDefined(var_01[0].var_8260) && var_01[0].var_8260 != "") {
          var_01[0] method_8278(var_01[0].var_8260, "OPEN_DOOR");
        }

        lib_0502::func_64D5(param_00, "open_pos", var_05);
        hostagedoorconnectpathsforvisuals(var_01);
        wait(var_05);
        hostagedoordisconnectpathsforvisuals(var_01);
        break;

      case "close":
        var_05 = func_45D0("doorMoveTime");
        lib_0502::func_64D5(param_00, "close_pos", var_05);
        hostagedoorconnectpathsforvisuals(var_01);
        wait(var_05);
        hostagedoordisconnectpathsforvisuals(var_01);
        break;

      default:
        break;
    }
  }
}

hostagedoorconnectpathsforvisuals(param_00) {
  if(isDefined(param_00)) {
    foreach(var_02 in param_00) {
      if(var_02 lib_0502::func_56D3()) {
        var_02 method_8060();
      }
    }
  }
}

hostagedoordisconnectpathsforvisuals(param_00) {
  if(isDefined(param_00)) {
    foreach(var_02 in param_00) {
      if(var_02 lib_0502::func_56D3()) {
        var_02 method_805F();
      }
    }
  }
}

hostagedoortriggeronce(param_00) {
  hostagedoortrigger(param_00, 1);
}

hostagedoortriggermulti(param_00) {
  hostagedoortrigger(param_00, 0);
}

hostagedoortrigger(param_00, param_01) {
  param_00 endon("death");
  var_02 = param_00.var_982E;
  var_02.var_9DC2[var_02.var_9DC2.size] = param_00;
  if(param_01) {
    param_00 enablelinkto();
    lib_0502::func_2084(param_00);
  }

  func_6983(self.var_695A);
  thread hostagedoorbeginuse(var_02, param_00);
  thread hostagedoorenduse(var_02, param_00);
  var_03 = func_45D0("firstDoorUseOpenTime");
  var_04 = 1;
  for(;;) {
    var_05 = func_45D0("doorUseOpenTime");
    if(common_scripts\utility::func_562E(var_04)) {
      lib_0502::func_79E1(param_00, &"RAIDS_USE_OPEN", var_03, 16);
      param_00.var_A240 maps\mp\gametypes\_gameobjects::func_86EC(game["attackers"]);
      param_00.var_A240 maps\mp\gametypes\_gameobjects::func_C30("friendly");
      param_00.var_A240.var_113F = 0;
      param_00.var_A240.var_A248 = "war_generic_open_mp";
    } else {
      lib_0502::func_79E1(param_00, &"RAIDS_USE_OPEN", var_05, 16);
      param_00.var_A240 maps\mp\gametypes\_gameobjects::func_86EC(game["attackers"]);
      param_00.var_A240 maps\mp\gametypes\_gameobjects::func_C30("any");
      param_00.var_A240.var_113F = 0;
      param_00.var_A240.var_A248 = "war_generic_open_mp";
    }

    param_00 waittill("used", var_06);
    if(common_scripts\utility::func_562E(var_04)) {
      var_04 = 0;
      lib_0502::raidawardhostagedoorbreachevent(var_06);
      self.doorunlocked = 1;
      var_07 = self.var_81E8;
      var_08 = "opened" + var_07;
      func_8615(self.numhostagesstart - self.numhostages + 1 * 1000);
      func_6981(self.var_695A, var_08, 0);
    }

    var_02 notify("trigger", "open", var_06);
    var_02.var_6BE1 = 1;
    var_02 notify("open");
    if(param_01) {
      self notify("end_doors");
      return;
    }

    param_00 sethintstring("");
    var_09 = func_45D0("doorMoveTime");
    wait(var_09);
    var_0A = func_45D0("doorUseCloseTime");
    lib_0502::func_79E1(param_00, &"RAIDS_USE_CLOSE", var_0A, 17);
    param_00.var_A240 maps\mp\gametypes\_gameobjects::func_86EC(game["attackers"]);
    param_00.var_A240 maps\mp\gametypes\_gameobjects::func_C30("any");
    param_00 waittill("used", var_06);
    var_02 notify("trigger", "close", var_06);
    var_02.var_6BE1 = 0;
    var_02 notify("close");
    param_00 sethintstring("");
    var_09 = func_45D0("doorMoveTime");
    wait(var_09);
  }
}

hostagedoorbeginuse(param_00, param_01) {
  param_01 endon("death");
  for(;;) {
    param_01 waittill("beginUse", var_02);
    self.doorinuse = 1;
    self notify("door_use");
    func_79B2(self.var_695A);
    if(isDefined(level.onhostagedoorbeginuse)) {
      self thread[[level.onhostagedoorbeginuse]](param_00, param_01);
    }
  }
}

hostagedoorenduse(param_00, param_01) {
  param_01 endon("death");
  for(;;) {
    param_01 waittill("endUse", var_02, var_03);
    self.doorinuse = 0;
    self notify("door_use");
    func_79B3(self.var_695A);
    if(isDefined(level.onhostagedoorenduse)) {
      self thread[[level.onhostagedoorenduse]](param_00, param_01);
    }
  }
}

hostagedoorshutdown(param_00) {
  param_00 endon("death");
  self waittill("end_doors");
  param_00 notify("trigger", "open");
  foreach(var_02 in param_00.var_9DC2) {
    if(!isDefined(var_02)) {
      continue;
    }

    hostagedoorgameobjectshutdown(var_02.var_A240);
  }
}

hostagedoorgameobjectshutdown(param_00) {
  var_01 = param_00.var_9D65;
  param_00 maps\mp\gametypes\_gameobjects::func_2F93();
  param_00 maps\mp\gametypes\_gameobjects::deleteuseobjectobjectives();
  waittillframeend;
  param_00 maps\mp\gametypes\_gameobjects::func_2D58();
  var_01 delete();
}

spawnanimatedhostage(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    param_01 = (0, 0, 0);
  }

  var_03 = ["mp_raids_pow_stand_idle01", "mp_raids_pow_stand_interact01", "mp_raids_pow_stand_release01"];
  var_04 = ["mp_raids_pow_sit_idle01", "mp_raids_pow_sit_interact01", "mp_raids_pow_sit_release01"];
  var_05 = ["mp_raids_pow_kneel_idle01", "mp_raids_pow_kneel_interact01", "mp_raids_pow_kneel_release01"];
  var_06 = [];
  var_06[0] = var_03;
  var_06[1] = var_04;
  var_06[2] = var_05;
  var_07 = spawnStruct();
  var_08 = ["mp_raid_aachen_hostage_m_01", "mp_raid_aachen_hostage_f_01"];
  var_09 = ["mp_raid_aachen_hostage_m_01_fade", "mp_raid_aachen_hostage_f_01_fade"];
  var_0A = ["mp_raids_pow_rope_idle01", "mp_raids_pow_rope_interact01", "mp_raids_pow_rope_release01"];
  var_0B = ["mp_raids_pow_frope_idle01", "mp_raids_pow_frope_interact01", "mp_raids_pow_frope_release01"];
  var_0C = [var_0A, var_0B];
  var_0D = randomint(2);
  var_07.bodymodel = spawn("script_model", param_00);
  var_07.bodymodel.bodymodelnormal = var_08[var_0D];
  var_07.bodymodel.bodymodelfade = var_09[var_0D];
  var_07.bodymodel setModel(var_07.bodymodel.bodymodelnormal);
  var_07.bodymodel.var_1D = param_01;
  var_07.ropemodel = spawn("script_model", param_00);
  var_07.ropemodel setModel("npc_gen_tarp_rope");
  var_07.ropemodel.var_1D = param_01;
  var_07.ropeanims = var_0C[var_0D];
  switch (param_02 func_45D0("hostageAnimationSet")) {
    case 0:
      var_07.var_EAB = var_03;
      break;

    case 1:
      var_07.var_EAB = var_04;
      break;

    case 2:
      var_07.var_EAB = var_05;
      break;

    case 3:
      var_07.var_EAB = common_scripts\utility::func_7A33(var_06);
      break;

    default:
      var_07.var_EAB = var_03;
      break;
  }

  var_07.bodymodel scriptmodelplayanim(var_07.var_EAB[0]);
  var_07.ropemodel scriptmodelplayanim(var_07.ropeanims[0]);
  var_07.gamestate = "IDLE";
  var_07 thread animatedhostageupdate();
  var_07.bodymodel thread hostagenotetracks();
  var_07.bodymodel thread hostagehidedurringvignette();
  var_07 thread syncanimationdelay();
  return var_07;
}

syncanimationdelay() {
  wait(5);
  self notify("hostage_update", "IDLE");
}

animatedhostageupdate() {
  level endon("game_ended");
  self endon("death");
  self endon("deleted");
  for(;;) {
    self waittill("hostage_update", var_00);
    if(isDefined(var_00) && var_00 != self.gamestate) {
      self.gamestate = var_00;
    }

    self.bodymodel scriptmodelpauseanim(1);
    switch (self.gamestate) {
      case "IDLE":
        self.bodymodel scriptmodelplayanim(self.var_EAB[0]);
        self.ropemodel scriptmodelplayanim(self.ropeanims[0]);
        break;

      case "INTERACT":
        self.bodymodel scriptmodelplayanim(self.var_EAB[1], "hostage_notetrack");
        self.ropemodel scriptmodelplayanim(self.ropeanims[1]);
        break;

      case "RELEASE":
        self.bodymodel notify("stop_notetracks");
        self.bodymodel scriptmodelplayanim(self.var_EAB[2]);
        self.ropemodel scriptmodelplayanim(self.ropeanims[2]);
        wait(4);
        self.bodymodel setModel(self.bodymodel.bodymodelfade);
        self.bodymodel setmaterialscriptparam(1, 0, 0.5);
        wait(1);
        self.bodymodel delete();
        break;
    }
  }
}

hostagenotetracks() {
  level endon("game_ended");
  self endon("death");
  self endon("deleted");
  self endon("stop_notetracks");
  for(;;) {
    self waittill("hostage_notetrack", var_00);
    var_01 = getsubstr(self.var_106, 23, 24);
    if(var_00 == "struggle") {
      switch (var_01) {
        case "f":
          lib_04F3::func_79CF("ob1_struggle_female", self, "j_head");
          break;

        case "m":
          lib_04F3::func_79CF("ob1_struggle_male", self, "j_head");
          break;
      }
    }
  }
}

hostagehidedurringvignette() {
  level endon("game_ended");
  self endon("death");
  self endon("deleted");
  for(;;) {
    level waittill("axis_vingnette_start");
    lib_0502::func_7997();
    level waittill("axis_vingnette_end");
    lib_0502::func_79C6();
  }
}

func_651D(param_00) {
  var_01 = 10;
  func_6934(param_00);
  self.var_6940 = ::func_651C;
  var_02 = common_scripts\utility::func_46B7(param_00.var_81EF, "script_linkname");
  var_03 = [];
  foreach(var_05 in var_02) {
    var_05.var_651B = 1;
    var_06 = int(var_05.var_81E1);
    var_03[var_06] = var_05;
  }

  var_08 = [];
  for(var_09 = 0; var_09 < var_01; var_09++) {
    if(isDefined(var_03[var_09])) {
      var_08[var_08.size] = var_03[var_09];
    }
  }

  var_0B = [];
  for(var_0C = 1; var_0C <= var_08.size; var_0C++) {
    var_0B[var_0B.size] = var_0C;
  }

  if(isDefined(param_00.var_8140)) {
    var_0D = int(min(param_00.var_8140, var_08.size));
  } else {
    var_0D = 1;
  }

  func_6965("completionQuota", var_0D, var_0B);
  func_6966("centerObjectiveName", "");
  self.var_94CE = var_08;
  thread func_651E(var_08);
}

func_651C() {
  if(!isDefined(self.var_94CE)) {
    return undefined;
  }

  var_00 = func_45D0("centerObjectiveName");
  var_01 = undefined;
  if(var_00 != "") {
    foreach(var_03 in self.var_94CE) {
      if(var_03.var_1A5 == var_00) {
        var_01 = var_03;
        break;
      }
    }

    if(!isDefined(var_01)) {
      var_01 = common_scripts\utility::func_7A33(self.var_94CE);
    }
  } else {
    var_01 = common_scripts\utility::func_7A33(self.var_94CE);
  }

  return var_01[[var_01.var_6940]]();
}

func_651E(param_00) {
  func_6983(self.var_1A5);
  for(var_01 = param_00.size - 1; var_01 >= 0; var_01--) {
    var_02 = param_00[var_01];
    var_02.var_6E78 = self.var_695A;
    func_6972(var_02.var_695A);
  }

  func_651F(param_00);
  wait 0.05;
  func_6935(self.var_695A);
  wait 0.05;
  for(var_01 = param_00.size - 1; var_01 >= 0; var_01--) {
    var_02 = param_00[var_01];
    if(!func_5761(var_02.var_695A)) {
      func_6935(var_02.var_695A);
    }
  }
}

func_651F(param_00) {
  level endon(func_6937(self.var_695A));
  for(;;) {
    level waittill("objectiveComplete");
    var_01 = 0;
    foreach(var_03 in param_00) {
      if(func_5761(var_03.var_695A)) {
        var_01++;
      }
    }

    if(var_01 >= func_45D0("completionQuota")) {
      break;
    }
  }
}

func_3FCD(param_00) {
  objective_onentity(self.var_698A, param_00);
  objective_onentity(self.var_698B, param_00);
  objective_onentity(self.var_698C, param_00);
  if(isDefined(self.var_6996)) {
    self.var_6996["allies"] settargetent(param_00);
    self.var_6996["axis"] settargetent(param_00);
    self.var_6996["broadcaster"] settargetent(param_00);
  }
}

func_860A(param_00, param_01) {
  func_860D(param_00);
}

func_860B(param_00, param_01) {
  func_860C(param_00, param_01);
}

func_860C(param_00, param_01) {
  maps\mp\gametypes\_gameobjects::func_860A("friendly", param_00);
  maps\mp\gametypes\_gameobjects::func_860A("enemy", param_01);
}

func_860D(param_00) {
  maps\mp\gametypes\_gameobjects::func_860A("friendly", param_00, 1);
  maps\mp\gametypes\_gameobjects::func_860A("enemy", param_00, 1);
}

func_0990(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D, param_0E) {
  if(isDefined(param_0C) && isDefined(param_0D)) {
    lib_04FA::func_986(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D, param_0E);
    return;
  }

  lib_04FA::func_934(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0E);
}

func_7CCA() {
  lib_04FA::func_7C95();
}

func_8614(param_00, param_01) {
  lib_04FA::func_6F1A(param_00, param_01);
}

func_4B4D() {
  return lib_04FA::func_50AC();
}

func_8615(param_00, param_01, param_02, param_03) {
  lib_04FA::func_6F1C(param_00, param_01, param_02, param_03);
}

func_8617(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  lib_04FA::func_7DFB(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
}

func_8613(param_00) {
  lib_04FA::func_84E6(param_00);
}

func_8616(param_00) {
  lib_04FA::func_7D38(param_00);
}

func_8619(param_00) {
  lib_04FA::func_50AD(param_00);
}

func_8618(param_00, param_01, param_02) {
  lib_04FA::func_5DC1(param_00, param_01, param_02);
}

func_064D(param_00, param_01) {
  self notify("_hide3DIcons");
  self endon("_hide3DIcons");
  self endon("image_timer_removed");
  foreach(var_03 in level.var_744A) {
    if(!isDefined(param_01) || var_03.var_1A7 == param_01) {
      param_00 luaseticonvisibility(var_03, 0);
      continue;
    }

    param_00 luaseticonvisibility(var_03, 1);
  }

  for(;;) {
    level waittill("connected", var_03);
    if(!isDefined(param_01) || isDefined(var_03.var_1A7) && var_03.var_1A7 == param_01) {
      param_00 luaseticonvisibility(var_03, 0);
    }
  }
}

func_071A(param_00) {
  self notify("_hide3DIcons");
  foreach(var_02 in level.var_744A) {
    param_00 luaseticonvisibility(var_02, 1);
  }
}

func_860F(param_00) {
  if(!lib_04FA::func_50AC()) {
    return;
  }

  thread func_064D(self.var_50A9);
  if(common_scripts\utility::func_562E(param_00)) {
    self.var_50A9.var_500F lib_0502::func_8C20();
    self.var_50A9.var_500F method_805C();
  }
}

func_8610(param_00, param_01) {
  if(!lib_04FA::func_50AC()) {
    return;
  }

  self.var_50A9 luaseticonvisibility(param_00, 0);
  if(common_scripts\utility::func_562E(param_01)) {
    self.var_50A9.var_500F hidefromclient(param_00);
  }
}

set3diconsshowtoplayer(param_00, param_01) {
  if(!lib_04FA::func_50AC()) {
    return;
  }

  self.var_50A9 luaseticonvisibility(param_00, 1);
  if(common_scripts\utility::func_562E(param_01)) {
    self.var_50A9.var_500F showtoclient(param_00);
  }
}

func_8612(param_00, param_01) {
  if(!lib_04FA::func_50AC()) {
    return;
  }

  thread func_064D(self.var_50A9, maps\mp\_utility::func_45DE(param_00));
  if(common_scripts\utility::func_562E(param_01)) {
    self.var_50A9.var_500F thread lib_0502::func_8C21(param_00);
  }
}

func_8611(param_00) {
  if(!lib_04FA::func_50AC()) {
    return;
  }

  func_071A(self.var_50A9);
  if(common_scripts\utility::func_562E(param_00)) {
    self.var_50A9.var_500F lib_0502::func_8C20();
  }
}

func_8CFD(param_00) {
  lib_04FA::func_1130(param_00, 1);
}

func_A088(param_00) {
  lib_04FA::func_1130(param_00, 0);
}

func_27DE(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.var_1B9 = "compassObject";
  var_04.var_28D4 = param_02;
  var_04.var_6DB2 = param_01;
  var_04.var_9DC4 = "none";
  var_04.var_37D8 = param_00;
  if(!isDefined(param_03)) {
    param_03 = (0, 0, 0);
  }

  var_04.var_6A1D = param_03;
  var_04.var_2562 = [];
  var_04.var_698A = maps\mp\gametypes\_gameobjects::func_45A9();
  var_04.var_698B = maps\mp\gametypes\_gameobjects::func_45A9();
  var_04.var_698C = maps\mp\gametypes\_gameobjects::func_45A9();
  objective_add(var_04.var_698A, "invisible", var_04.var_28D4);
  objective_add(var_04.var_698B, "invisible", var_04.var_28D4);
  objective_add(var_04.var_698C, "invisible", var_04.var_28D4);
  objective_team(var_04.var_698A, "allies");
  objective_team(var_04.var_698B, "axis");
  objective_playermask_hidefromall(var_04.var_698C);
  var_04.var_5412 = "none";
  var_04.var_59DD = 0;
  var_04.var_AA8A = [];
  var_04.var_AA89 = [];
  var_04.var_A560 = "none";
  return var_04;
}

func_4B7C(param_00) {
  return isDefined(param_00.var_982D["objective_icon"]) && param_00.var_982D["objective_icon"].size;
}

func_45CE(param_00) {
  if(!func_4B7C(param_00)) {
    return (0, 0, 0);
  }

  return param_00.var_982D["objective_icon"][0].var_116 - param_00.var_116;
}

func_6939(param_00) {
  var_01 = maps\mp\gametypes\_hud_util::func_2829("default", 1);
  var_01 func_6970(15, param_00);
  return var_01;
}

func_6938(param_00) {
  var_01 = maps\mp\gametypes\_hud_util::func_2828((1, 1, 1), 150, 15);
  var_01 func_6970(20, param_00);
  return var_01;
}

func_6970(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  self.var_6944 = param_00;
  level.var_79AE.var_6948[level.var_79AE.var_6948.size] = self;
  level.var_79AE thread func_068D(self, param_00, param_01);
  level.var_79AE thread func_068C(self);
}

func_068D(param_00, param_01, param_02) {
  param_00 endon("death");
  for(;;) {
    var_03 = 175;
    for(var_04 = 0; var_04 < self.var_6948.size; var_04++) {
      var_05 = self.var_6948[var_04];
      if(var_05 == param_00) {
        break;
      }

      var_03 = var_03 + var_05.var_6944;
    }

    param_00 maps\mp\gametypes\_hud_util::func_8707("LEFTTOP", undefined, 15 + param_02, var_03);
    param_00 waittill("updateSetPoint");
  }
}

func_068C(param_00) {
  param_00 waittill("death");
  var_01 = [];
  var_02 = 0;
  for(var_03 = 0; var_03 < self.var_6948.size; var_03++) {
    var_04 = self.var_6948[var_03];
    if(var_04 == param_00) {
      var_02 = 1;
      continue;
    }

    if(var_02) {
      var_04 notify("updateSetPoint");
    }

    var_01[var_01.size] = var_04;
  }

  self.var_6948 = var_01;
}

func_A0E4(param_00, param_01) {
  var_02 = 1;
  if(param_01 > 0.5) {
    var_02 = 1 - 2 * param_01 - 0.5;
  }

  var_03 = 1;
  if(param_01 < 0.5) {
    var_03 = param_01 / 0.5;
  }

  var_04 = 0;
  param_00 maps\mp\gametypes\_hud_util::func_A0E3(param_01);
  param_00.var_1586.var_56 = (var_02, var_03, var_04);
}

func_A177(param_00, param_01) {
  var_02 = int(param_01 * 100);
  param_00 setvalue(var_02);
}

func_694B() {
  return common_scripts\utility::func_562E(level.var_79AF[self.var_165]);
}

func_09C2(param_00, param_01) {
  param_00.var_59E8[param_00.var_59E8.size] = param_01;
}

func_7CE4(param_00, param_01) {
  param_00.var_59E8 = common_scripts\utility::func_F93(param_00.var_59E8, param_01);
}

func_2810(param_00) {
  var_01 = spawnStruct();
  var_01.var_2006 = param_00;
  var_01.var_866E = ::func_866E;
  var_01.var_6BC2 = ::func_2DD1;
  func_7DFD(param_00);
  param_00.var_2011 = 1;
  param_00.var_2012 = "objective_resupply_death";
  var_01.var_79AD = self;
  return var_01;
}

func_2DD1() {
  if(isDefined(self.var_2006)) {
    var_00 = self.var_2006;
    var_00.var_2016 = undefined;
    var_00.var_2011 = 0;
    var_00.var_2012 = undefined;
    func_7DFE(var_00);
  }

  foreach(var_02 in self.var_79AD.var_2DAA) {
    self.var_79AD func_7CE4(var_02, self);
  }
}

func_533E() {
  level.var_79AE.var_6CCF = [];
  func_79BB();
}

func_79B1(param_00) {
  func_79BB();
  if(func_79B7()) {
    level.var_79AE.var_6CCF[param_00] = level.var_79AE.var_6CD2 + func_79BA();
  } else {
    level.var_79AE.var_6CCF[param_00] = gettime();
  }

  level.var_79AE.var_6CCF[param_00] = level.var_79AE.var_6CCF[param_00] + func_4642() * 1000;
}

func_79B2(param_00) {
  thread func_79B4(param_00);
}

func_79B4(param_00) {
  self endon("raidOvertimeEnableHoldEnd_" + param_00);
  level endon("raidOvertimeEnableHoldEnd_" + param_00);
  for(;;) {
    func_6981(param_00);
    wait 0.05;
  }
}

func_79B3(param_00) {
  self notify("raidOvertimeEnableHoldEnd_" + param_00);
}

func_79B7() {
  var_00 = func_79B8();
  return var_00 >= func_79BA();
}

func_79B8() {
  if(isDefined(level.var_79AE.var_6CD2)) {
    return gettime() - level.var_79AE.var_6CD2;
  }

  return 0;
}

func_79B9() {
  return 180;
}

func_79BA() {
  return int(func_79B9() * 1000);
}

func_79BB() {
  var_00 = func_79B8();
  var_01 = var_00 / 1000;
  var_02 = [5, 4, 3, 2, 1];
  if(isDefined(self.var_6967) && isDefined(self.var_6967["OvertimeDurationArray"])) {
    var_02 = func_45D0("OvertimeDurationArray");
    if(!isarray(var_02) && var_02.size != 5) {
      var_02 = [5, 4, 3, 2, 1];
    }
  }

  if(var_01 < 60 || func_79B7()) {
    var_03 = var_02[0];
  } else if(var_02 < 70) {
    var_03 = var_03[1];
  } else if(var_02 < 80) {
    var_03 = var_03[2];
  } else if(var_02 < 90) {
    var_03 = var_03[3];
  } else {
    var_03 = var_03[4];
  }

  level.var_79AE.var_6CD0 = var_03;
}

func_4642() {
  return level.var_79AE.var_6CD0;
}

func_4645() {
  var_00 = gettime();
  foreach(var_02 in level.var_79AE.var_6CCF) {
    if(var_02 > var_00) {
      var_00 = var_02;
    }
  }

  return int(var_00);
}

func_4644() {
  var_00 = func_4645();
  var_00 = var_00 - gettime() / 1000;
  if(var_00 <= 0) {
    var_00 = 0;
  }

  return var_00;
}

func_4643() {
  var_00 = func_4645();
  var_00 = var_00 - gettime();
  if(var_00 <= 0) {
    var_00 = 0;
  }

  return var_00;
}

func_79B0() {
  var_00 = func_4644();
  if(var_00 <= 0) {
    return 0;
  }

  func_79B1("minOvertime");
  level.var_99F5 = 1;
  level.var_79AE.var_6CD2 = gettime();
  level notify("start_overtime");
  level thread func_79B5();
  while(maps\mp\gametypes\_gamelogic::func_46E5() <= 0 && func_4644() > 0) {
    wait 0.05;
  }

  level notify("stop_overtime");
  setomnvar("ui_war_overtime_starttime", 0);
  setomnvar("ui_war_overtime_endtime", 0);
  setomnvar("ui_war_overtime_maxed", 0);
  level.var_99F5 = 0;
  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() > 0;
  if(var_01 && level.var_79C2.var_9DE) {
    var_02 = gettime() - level.var_79AE.var_6CD2;
    var_02 = var_02 / 1000;
    var_02 = var_02 / 60;
    maps\mp\gametypes\raid::func_9DB(var_02);
  }

  level.var_79AE.var_6CD2 = undefined;
  func_79BB();
  return maps\mp\gametypes\_gamelogic::func_46E5() > 0;
}

func_79B5() {
  func_79B6();
}

func_79B6() {
  level endon("stop_overtime");
  for(;;) {
    waittillframeend;
    var_00 = func_4644();
    var_01 = func_4645();
    var_02 = clamp(var_00 / func_4642(), 0, 1);
    if(var_02 != 1) {
      var_03 = func_4643();
      setomnvar("ui_war_overtime_starttime", var_01 - int(func_4642() * 1000));
      setomnvar("ui_war_overtime_endtime", var_01);
      setomnvar("ui_war_overtime_maxed", func_79B7());
    } else {
      setomnvar("ui_war_overtime_starttime", 1);
      setomnvar("ui_war_overtime_endtime", 0);
      setomnvar("ui_war_overtime_maxed", 0);
    }

    wait 0.05;
  }
}

raidovertimeisactive() {
  return maps\mp\gametypes\_gamelogic::func_46E5() <= 0 && func_4644() > 0;
}

func_3838() {
  var_00 = func_6939();
  var_00.var_E5 = &"RAIDS_ESCORT_BAR";
  var_01 = func_6938();
  var_02 = [];
  foreach(var_04 in self.var_21DB) {
    var_05 = maps\mp\gametypes\_hud_util::func_282A("white", 1, 15);
    var_05 maps\mp\gametypes\_hud_util::func_86EF(var_01);
    var_06 = var_04.var_6EDA / self.var_6EDA;
    var_07 = var_01.var_1D2 * var_06;
    var_05 maps\mp\gametypes\_hud_util::func_8707("CENTER", "LEFT", var_07, 0);
    thread func_3839(var_05, var_04);
    var_02[var_02.size] = var_05;
  }

  func_383A(var_01, var_00);
  wait(1);
  var_01 maps\mp\gametypes\_hud_util::func_2DCC();
  var_00 maps\mp\gametypes\_hud_util::func_2DCC();
  foreach(var_0A in var_02) {
    var_0A maps\mp\gametypes\_hud_util::func_2DCC();
  }
}

func_3839(param_00, param_01) {
  param_00 endon("death");
  for(;;) {
    param_01 waittill("trigger", var_02);
    if(var_02 != self.var_A2C8) {
      continue;
    }

    var_03 = 0.1;
    var_04 = param_00.var_1D2;
    var_05 = param_00.var_BD;
    param_00 scaleovertime(var_03, int(3 * var_04), int(3 * var_05));
    wait(var_03);
    param_00 scaleovertime(var_03, int(2 * var_04), var_05);
    break;
  }
}

func_383A(param_00, param_01) {
  self endon("end_hud");
  var_02 = param_00.var_1586.var_18;
  var_03 = param_00.var_18;
  var_04 = param_01.var_18;
  var_05 = 0.25;
  for(;;) {
    if(self.var_664C) {
      param_00.var_18 = var_05;
      param_00.var_1586.var_18 = var_05;
      param_01.var_18 = var_05;
    } else {
      param_00.var_18 = var_03;
      param_00.var_1586.var_18 = var_02;
      param_01.var_18 = var_04;
      param_01.var_E5 = &"RAIDS_ESCORT_BAR";
      var_06 = self.var_A2C8.var_36DA;
      var_07 = var_06.var_6EDA;
      var_08 = self.var_A2C8.var_291C;
      var_09 = var_08.var_6EDA;
      if(var_08.var_6968) {
        var_0A = func_3851(var_08);
        var_09 = var_09 + distance2d(self.var_A2C8.var_116, var_0A);
      }

      var_0B = clamp(var_09 / var_07, 0, 1);
      func_A177(param_01, var_0B);
      func_A0E4(param_00, var_0B);
    }

    wait 0.05;
  }
}

func_1FB7(param_00) {
  var_01 = func_6939();
  var_01.var_E5 = &"RAIDS_CAPTURE_BAR";
  var_02 = func_6938();
  var_03 = undefined;
  var_04 = undefined;
  var_05 = func_45D0("allowReversal");
  if(var_05) {
    var_03 = maps\mp\gametypes\_hud_util::func_282A("white", 3, 15);
    var_03 maps\mp\gametypes\_hud_util::func_8707("LEFTTOP", undefined, 65, 190);
    var_04 = maps\mp\gametypes\_hud_util::func_282A("white", 3, 15);
    var_04 maps\mp\gametypes\_hud_util::func_8707("LEFTTOP", undefined, 115, 190);
  }

  func_1FB8(var_02, var_01);
  param_00 lib_04FA::func_7C95();
  var_02 maps\mp\gametypes\_hud_util::func_2DCC();
  var_01 maps\mp\gametypes\_hud_util::func_2DCC();
  if(var_05) {
    var_03 maps\mp\gametypes\_hud_util::func_2DCC();
    var_04 maps\mp\gametypes\_hud_util::func_2DCC();
  }
}

func_1FB8(param_00, param_01) {
  self endon("end_hud");
  for(;;) {
    var_02 = clamp(self.var_1FBA.var_28D5 / self.var_1FBA.var_A23F, 0, 1);
    func_A177(param_01, var_02);
    func_A0E4(param_00, var_02);
    wait 0.05;
  }
}

mode_weapons_allowed(param_00, param_01) {
  var_02 = func_6939();
  var_02.var_E5 = &"RAIDS_BUILD_BAR";
  var_03 = func_6938();
  var_04 = undefined;
  var_05 = undefined;
  if(param_00 > 0) {
    var_04 = maps\mp\gametypes\_hud_util::func_282A("white", 1, 15);
    var_04.maxsightdistsqrd = var_03.var_1D2 * param_00 + var_03.maxsightdistsqrd;
    var_04.var_1D7 = var_03.var_1D7;
  }

  if(param_01 < 1) {
    var_05 = maps\mp\gametypes\_hud_util::func_282A("white", 1, 15);
    var_05.maxsightdistsqrd = var_03.var_1D2 * param_01 + var_03.maxsightdistsqrd;
    var_05.var_1D7 = var_03.var_1D7;
  }

  func_1D4A(var_03, var_02, param_00, param_01);
  if(isDefined(var_05)) {
    var_05 thread func_1D49();
  }

  var_03 maps\mp\gametypes\_hud_util::func_2DCC();
  var_02 maps\mp\gametypes\_hud_util::func_2DCC();
  if(isDefined(var_04)) {
    var_04 maps\mp\gametypes\_hud_util::func_2DCC();
  }

  waittillframeend;
  self.elemtype lib_04FA::func_7C95();
}

func_1D49() {
  var_00 = 0.5;
  var_01 = self.var_1D2;
  var_02 = self.var_BD;
  self fadeovertime(var_00);
  self.var_18 = 0;
  self scaleovertime(var_00, int(3 * var_01), int(3 * var_02));
  self moveovertime(var_00);
  self.maxsightdistsqrd = self.maxsightdistsqrd - self.var_1D2;
  self.var_1D7 = self.var_1D7 - self.var_BD;
  wait(var_00);
  maps\mp\gametypes\_hud_util::func_2DCC();
}

func_1D4A(param_00, param_01, param_02, param_03) {
  self endon("end_hud");
  for(;;) {
    var_04 = clamp(self.elemtype.var_28D5 / self.elemtype.var_A23F, 0, 1);
    var_04 = param_02 + param_03 - param_02 * var_04;
    func_A177(param_01, var_04);
    func_A0E4(param_00, var_04);
    wait 0.05;
  }
}

agent_definition_override(param_00) {
  var_01 = func_6939();
  var_02 = func_6938();
  var_03 = func_45D0("fuseTime");
  param_00 lib_04FA::func_934(param_00.var_28D4 + param_00.var_6A1D, undefined, undefined, var_03 * 1000, 8, 0, undefined, undefined, undefined, 1);
  agent_funcs(var_02, var_01, param_00);
  var_01 maps\mp\gametypes\_hud_util::func_2DCC();
  var_02 maps\mp\gametypes\_hud_util::func_2DCC();
  param_00 lib_04FA::func_7C95();
}

agent_funcs(param_00, param_01, param_02) {
  self endon("end_hud");
  for(;;) {
    param_01.var_E5 = &"RAIDS_BOMB_NOT_PLANTED_BAR";
    param_01 settext("");
    func_A0E4(param_00, 0);
    self waittill("bomb_planted");
    param_02 lib_04FA::func_7DFB("bomb", 9);
    func_18F0(param_00, param_01);
    param_02 lib_04FA::func_7D38(8);
  }
}

func_18F0(param_00, param_01) {
  self endon("bomb_defused");
  self endon("bomb_explode");
  var_02 = func_45D0("fuseTime");
  param_01.var_E5 = &"RAIDS_BOMB_PLANTED_BAR";
  param_01 settimer(var_02);
  var_03 = var_02 * 1000;
  var_04 = gettime() + var_03;
  for(;;) {
    var_05 = clamp(1 - var_04 - gettime() / var_03, 0, 1);
    func_A0E4(param_00, var_05);
    wait 0.05;
  }
}