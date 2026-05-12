/******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_tower_battle.gsc
******************************************************/

func_00F9() {
  level.var_7AC8 = ["clear_tower_behavior", "is_tower_battle_distracted"];
  thread maps\mp\mp_zombie_nest_ee_tower_battle_zombie_states::func_528A();
  common_scripts\utility::func_3C87("flag_fuse_entered_correct");
  common_scripts\utility::func_3C87("aud_stop_rod_movement_sounds");
  func_52ED();
}

func_170D() {
  var_00 = 1;
  level thread func_27CD("inner_spire", "nest_ee_fuse_piece_lift", ["tower_outter_attack_point_center"], "inner objective success", "inner objective fail", var_00, ["inner_spire_lever"], "5 Right Hand fuses", ::func_6B47);
}

func_1715() {
  var_00 = 2;
  level thread func_27CD("outter_spire", "nest_ee_fuse_outter_objectives", ["tower_outter_attack_point_left", "tower_outter_attack_point_right"], "outter objective success", "outter objective fail", var_00, ["outter_spire_left_lever", "outter_spire_right_lever"], "5 Right Hand fuses", ::func_6B60);
}

func_6B47() {
  level thread func_2E7C();
  lib_0557::func_782D("5 Right Hand fuses", "lift center rod");
}

func_6B60() {
  lib_0557::func_782D("5 Right Hand fuses", "lift outter rods");
}

func_27CD(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = func_46ED(param_00, param_01, param_02);
  var_0A = func_86D9(param_03, param_04, param_05, param_06);
  func_8A37("5 Right Hand fuses", var_0A["machine_targetnames"]);
  var_09["main_trigger"] func_52FA(var_0A["machine_targetnames"]);
  var_0B = common_scripts\utility::func_46B5("tower_attack_on_deck_positions_struct", "targetname");
  var_0C = spawnStruct();
  var_0C.var_7B8C = var_0C;
  var_0C.var_38C3 = "zombie_tower_rumble_" + var_0A["battleID"];
  var_0C.var_38C4 = func_46EE(var_0A["battleID"]);
  maps\mp\mp_zombie_nest_special_event_creator::func_3135(::func_A69B, var_09["main_trigger"], var_09["attack_positions"], var_0A["battleID"], var_0A["notifications"], var_09["activation_triggers"], "zone1_4_bridge_tower", var_0B.var_0116, ::func_6A77, ::func_6A76, ::func_6A78, var_0C, ::func_6A7D, "tower_attack_on_deck_positions_struct");
  [[param_08]]();
}

func_6A77(param_00, param_01, param_02) {
  var_03 = common_scripts\utility::func_46B5("tower_battle_sfx_top", "targetname");
  var_03 thread lib_0378::func_8D74("aud_tower_alarm");
  foreach(var_05 in param_00) {
    var_05.var_08BC = level.var_A980;
  }

  if(!param_01) {
    if(param_02 == 1) {
      lib_0557::func_7822("5 Right Hand fuses", &"ZOMBIE_NEST_HINT_STEP_FIRST_LIGHTNING_ROD");
      return;
    }

    if(param_02 == 2) {
      lib_0557::func_7822("5 Right Hand fuses", &"ZOMBIE_NEST_HINT_STEP_TWO_LIGHTNING_RODS");
      return;
    }
  }
}

func_6A78(param_00, param_01, param_02) {
  var_03 = common_scripts\utility::func_46B5("tower_battle_sfx_top", "targetname");
  var_03 thread lib_0378::func_8D74("aud_tower_alarm_stop");
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("mp_zombie_nest_01_tower_battle", get_lowest_attack_spot_health(param_01));
  foreach(var_05 in param_00.var_65E8) {
    var_05 func_A180(5, 1, 0);
    var_05 func_A180(5, 1, 2);
  }

  foreach(var_08 in param_00.var_65E8) {
    if(isDefined(var_08.var_65DE) && isDefined(var_08.var_65DE.var_299D)) {
      var_08.var_65DE.var_299D delete();
    }
  }

  param_00.var_65E8[0] thread lib_0378::func_8D74("aud_tower_machine_move_stop");
  foreach(var_0B in param_02) {
    if(isDefined(var_0B.var_4D91)) {
      lib_0559::func_2D8E(var_0B.var_4D91);
    }
  }
}

get_lowest_attack_spot_health(param_00) {
  var_01 = 999;
  foreach(var_03 in param_00) {
    if(var_03.var_28FF < var_01) {
      var_01 = var_03.var_28FF;
    }
  }

  return var_01;
}

func_6A76(param_00, param_01) {
  var_02 = common_scripts\utility::func_46B5("tower_battle_sfx_top", "targetname");
  var_02 thread lib_0378::func_8D74("aud_tower_alarm_stop");
  foreach(var_04 in param_00.var_65E8) {
    var_04 func_A180(5, 0, 0);
    var_04 func_A180(5, 0, 2);
  }

  param_00.var_65E8[0] thread lib_0378::func_8D74("aud_tower_machine_destroyed");
  foreach(var_07 in level.var_744A) {
    if(distance(var_07.var_0116, param_01[0].var_0116) < 300) {
      var_07 maps\mp\_utility::func_2CED(4, ::lib_0367::func_8E3C, "lightningrodbroke");
    }
  }

  lib_0557::func_7822("5 Right Hand fuses", &"ZOMBIE_NEST_HINT_STEP_LIGHTNING_RESET");
}

func_6A7D(param_00, param_01, param_02) {
  if(!isDefined(level.var_9B19)) {
    level.var_9B19 = 0;
  }

  if(param_02 && !level.var_9B19) {
    foreach(var_04 in level.var_744A) {
      if(lib_0547::func_577E(var_04)) {
        continue;
      }

      if(distance(var_04.var_0116, param_00.var_0116) < 300) {
        var_04 thread lib_0367::func_8E3C("rodmachineassault");
        level.var_9B19 = 1;
      }
    }
  }

  param_00 thread func_A0E2(param_00.var_28FF, param_01);
  param_00 thread lib_0378::func_8D74("aud_tower_machine_dmg_state", param_00.var_28FF, param_01);
}

func_46EE(param_00) {
  param_00 = param_00 - 1;
  var_01 = param_00 * 5;
  var_02 = [];
  var_03 = "mp/zombieSpecialEnemyWaves.csv";
  var_02["respawnExclusionRadius"] = lib_0547::func_9470(tablelookupbyrow(var_03, var_01, 4));
  var_02["objectiveTime"] = lib_0547::func_9470(tablelookupbyrow(var_03, var_01, 5));
  var_02["objectiveHealth"] = lib_0547::func_9470(tablelookupbyrow(var_03, var_01, 6));
  var_02["zombieObjectiveMax"] = lib_0547::func_9470(tablelookupbyrow(var_03, var_01, 7));
  var_02["objectiveHealthSolo"] = lib_0547::func_9470(tablelookupbyrow(var_03, var_01, 9));
  return var_02;
}

func_A0E2(param_00, param_01) {
  if(param_00 <= param_01 && param_00 > param_01 * 0.75) {
    return;
  }

  if(param_00 <= param_01 * 0.75 && param_00 > param_01 * 0.5) {
    if(self.var_28FC != 1) {
      if(isDefined(self.var_299D)) {
        self.var_299D delete();
      }

      var_02 = anglesToForward(self.var_001D);
      self.var_299D = spawnfx(level.var_0611["zmb_ee_fuse_dmg_lt"], self.var_0116, var_02);
      triggerfx(self.var_299D);
      self.var_28FC = 1;
      return;
    }

    return;
  }

  if(param_00 <= param_01 * 0.5 && param_00 > param_01 * 0.25) {
    if(self.var_28FC != 2) {
      if(isDefined(self.var_299D)) {
        self.var_299D delete();
      }

      var_02 = anglesToForward(self.var_001D);
      self.var_299D = spawnfx(level.var_0611["zmb_ee_fuse_dmg_med"], self.var_0116, var_02);
      triggerfx(self.var_299D);
      self.var_28FC = 2;
      return;
    }

    return;
  }

  if(param_00 <= param_01 * 0.25 && param_00 > 0) {
    if(self.var_28FC != 3) {
      if(isDefined(self.var_299D)) {
        self.var_299D delete();
      }

      var_02 = anglesToForward(self.var_001D);
      self.var_299D = spawnfx(level.var_0611["zmb_ee_fuse_dmg_hvy"], self.var_0116, var_02);
      triggerfx(self.var_299D);
      self.var_28FC = 3;
      return;
    }

    return;
  }

  if(param_00 <= 0) {
    if(self.var_28FC != 4) {
      if(isDefined(self.var_299D)) {
        self.var_299D delete();
      }

      var_02 = anglesToForward(self.var_001D);
      self.var_299D = spawnfx(common_scripts\utility::func_44F5("ee_fuse_blowout"), self.var_0116, var_02);
      triggerfx(self.var_299D);
      self.var_28FC = 4;
      return;
    }

    return;
  }
}

func_8A37(param_00, param_01) {
  if(1) {
    var_02 = [];
    for(var_03 = 0; var_03 < param_01.size; var_03++) {
      var_02[var_03] = getent(param_01[var_03], "targetname");
    }

    var_04 = lib_0557::func_782F(undefined, var_02);
    lib_0557::func_781D(param_00, var_04);
  }
}

func_8A36(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_94D4 = param_00;
  var_02.var_39D1 = param_01;
  return var_02;
}

func_A69B(param_00, param_01, param_02) {
  var_03 = undefined;
  var_04 = 0;
  foreach(var_06 in param_00) {
    if(!isDefined(var_06.var_57A4)) {
      var_04 = 0;
    }

    if(!isDefined(var_06.var_4D91)) {
      var_06.var_4D91 = lib_0559::func_7BE3(var_06, "lightning_rod");
    }

    var_06 sethintstring(&"ZOMBIE_NEST_LIFT_RODS");
    var_07 = common_scripts\utility::func_4461(var_06.var_0116, param_02);
    var_06 thread func_A6C0(var_04, var_07);
  }

  var_09 = 0;
  var_0A = undefined;
  while(var_09 < param_00.size) {
    level waittill("ee trigger was repaired", var_03, var_06);
    var_0A = var_03;
    if(common_scripts\utility::func_0F79(param_00, var_06)) {
      var_09++;
    }
  }

  foreach(var_06 in param_00) {
    var_06.var_65E7 func_A180(3);
  }
}

func_A6AE(param_00) {
  foreach(var_02 in param_00) {
    if(!isDefined(var_02.var_08BC)) {
      return;
    }
  }

  foreach(var_02 in param_00) {
    var_02 common_scripts\utility::func_9DA3();
    var_02 sethintstring(&"ZOMBIE_NEST_MACHINE_COOLING");
    var_02 setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
  }

  while(param_00[0].var_08BC == level.var_A980) {
    wait(1);
  }
}

func_2EA5(param_00) {
  param_00 thread lib_0367::func_8E3C("lightningrodmachine");
}

func_46EF(param_00) {
  param_00 = param_00 - 1;
  var_01 = param_00 * 5;
  var_02 = "mp/zombieSpecialEnemyWaves.csv";
  var_03 = lib_0547::func_9470(tablelookupbyrow(var_02, var_01, 8));
  return var_03;
}

func_8A05() {
  self.var_1170 = getent(self.var_01A2, "targetname");
  self.var_1170.var_834D = getEntArray(self.var_1170.var_01A2, "targetname");
  self.var_1170.var_65F7 = self;
}

func_4ADA(param_00) {
  foreach(var_02 in param_00) {
    var_02 func_A180(0);
  }
}

func_A6C0(param_00, param_01) {
  common_scripts\utility::func_9DA3();
  self.var_57A4 = 0;
  self.var_65E7 func_A180(0);
  var_02 = undefined;
  while(!self.var_57A4) {
    self waittill("trigger", var_02);
    self.var_65E7 thread lib_0378::func_8D74("aud_tower_machine_use");
    if(isDefined(param_01.var_299D)) {
      param_01.var_299D delete();
    }

    if(param_00 == 0 || var_02 maps\mp\gametypes\zombies::func_11C2(param_00)) {
      self.var_28D5 = 0;
      self.var_57A4 = 1;
    }
  }

  self.var_65E7 func_A180(1);
  common_scripts\utility::func_9D9F();
  level notify("ee trigger was repaired", var_02, self);
}

func_A181(param_00) {
  switch (param_00) {
    case 0:
      thread func_64AA(0);
      func_9EC7();
      break;

    case 1:
      thread func_64AA(1);
      thread func_9EC6();
      break;

    case 2:
      thread func_64AC(0);
      break;

    case 3:
      thread func_64AC(1);
      thread lib_0378::func_8D74("aud_tower_machine_move_strt");
      break;

    case 4:
      thread func_64AC(2);
      break;

    case 5:
      break;
  }
}

func_64AA(param_00) {
  self notify("lever state change");
  self endon("lever state change");
  self scriptmodelclearanim();
  switch (param_00) {
    case 0:
      self scriptmodelplayanim("zmb_tower_elec_lever_reverse");
      wait(getanimlength(%zmb_tower_elec_lever_reverse));
      self scriptmodelplayanim("zmb_tower_elec_lever_idle");
      break;

    case 1:
      self scriptmodelplayanim("zmb_tower_elec_lever_pull");
      wait(getanimlength(%zmb_tower_elec_lever_pull));
      self scriptmodelplayanim("zmb_tower_elec_lever_pull_idle");
      break;
  }
}

func_64AC(param_00) {
  self notify("lightning rod state change");
  self.var_65E6 notify("lightning rod state change");
  self endon("lightning rod state change");
  var_01 = self.var_65E6;
  if(!isDefined(var_01.var_7EC4)) {
    var_01.var_7EC4 = undefined;
    var_01.var_7EC2 = undefined;
    var_01.var_7EC7 = undefined;
    var_01.var_7EC6 = 0;
    var_01.var_7EC3 = 0;
    var_01.var_7EBE = 0;
    var_01.var_7EC0 = "zmb_tower_rod_idle_bottom";
    if(self.var_01A5 == "inner_spire_lever") {
      var_01.var_7EC4 = "zmb_tower_rod_mid_up";
      var_01.var_7EC2 = "zmb_tower_rod_mid_down";
      var_01.var_7EC7 = "zmb_tower_rod_mid_idle_top";
      var_01.var_7EC6 = getanimlength(%zmb_tower_rod_mid_up);
      var_01.var_7EC3 = getanimlength(%zmb_tower_rod_mid_down);
    } else {
      var_01.var_7EC4 = "zmb_tower_rod_up";
      var_01.var_7EC2 = "zmb_tower_rod_down";
      var_01.var_7EC7 = "zmb_tower_rod_idle_top";
      var_01.var_7EC6 = getanimlength(%zmb_tower_rod_up);
      var_01.var_7EC3 = getanimlength(%zmb_tower_rod_down);
    }
  }

  var_01 scriptmodelclearanim();
  switch (param_00) {
    case 0:
      if(isDefined(var_01.var_7EC5)) {
        var_01.var_7EBF = var_01.var_7EC5 * var_01.var_7EC3;
      } else {
        var_01.var_7EBF = var_01.var_7EC3;
      }

      var_01.var_7EBE = var_01.var_7EC3 - var_01.var_7EBF;
      var_01 scriptmodelplayanim(var_01.var_7EC2, "", var_01.var_7EBE, 1, 1);
      wait(var_01.var_7EC3 - var_01.var_7EBE - 0.3333333);
      var_01 thread lib_0378::func_8D74("aud_tower_machine_crash");
      wait(0.3333333);
      var_01 scriptmodelplayanim(var_01.var_7EC0);
      var_01 notify("lightning rod state change complete");
      func_9EC7();
      break;

    case 1:
      var_01 scriptmodelplayanim(var_01.var_7EC4);
      var_01.var_7EBE = 0;
      var_01 thread func_7EC8();
      wait(var_01.var_7EC6);
      var_01 scriptmodelplayanim(var_01.var_7EC7);
      var_01 notify("lightning rod state change complete");
      func_9EC8();
      break;

    case 2:
      var_01 scriptmodelplayanim(var_01.var_7EC0);
      var_01 notify("lightning rod state change complete");
      break;
  }
}

func_7EC8() {
  self endon("lightning rod state change complete");
  self endon("lightning rod state change");
  var_00 = gettime();
  for(;;) {
    var_01 = gettime() - var_00 / 1000;
    self.var_7EC5 = self.var_7EBE + var_01 / self.var_7EC6;
    wait(0.1);
  }
}

func_9EC7() {
  self hidepart("TAG_LIGHT_ON", self.var_0106);
  self showpart("TAG_LIGHT_OFF", self.var_0106);
}

func_9EC6() {
  self.var_65E6 endon("lightning rod state change complete");
  for(;;) {
    self hidepart("TAG_LIGHT_ON", self.var_0106);
    self showpart("TAG_LIGHT_OFF", self.var_0106);
    wait(0.75);
    self hidepart("TAG_LIGHT_OFF", self.var_0106);
    self showpart("TAG_LIGHT_ON", self.var_0106);
    wait(0.75);
  }
}

func_9EC8() {
  self hidepart("TAG_LIGHT_OFF", self.var_0106);
  self showpart("TAG_LIGHT_ON", self.var_0106);
}

func_8A4B() {
  var_00 = getent("nest_ee_fuse_piece_lift", "targetname");
  level notify("flag_fuse_entered_correct");
  var_00 func_8A05();
  return var_00;
}

func_2E7C() {
  wait(3);
  var_00 = getent("inner_spire", "targetname");
  if(isDefined(var_00)) {
    foreach(var_02 in level.var_744A) {
      if(distance2d(var_02.var_0116, var_00.var_0116) < 750) {
        var_02 thread lib_0367::func_8E3C("lightningrodpart2");
      }
    }
  }
}

func_A180(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    thread func_A181(param_00);
    return;
  }

  if(param_01) {
    thread func_A181(param_00);
    return;
  }

  thread func_A181(param_02);
}

func_52FA(param_00) {
  var_01 = [];
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    var_04 = getent(param_00[var_03], "targetname");
    var_04.var_65E6 = getent(var_04.var_01A2, "targetname");
    func_5DA3(var_04.var_65E6.var_01A2, var_04);
    var_01 = common_scripts\utility::func_0F6F(var_01, var_04);
  }

  self.var_65E8 = var_01;
  func_4ADA(var_01);
}

func_5DA3(param_00, param_01) {
  var_02 = getent(param_00, "targetname");
  var_02.var_65DA = param_01;
}

func_52ED() {
  var_00 = getent("nest_ee_fuse_piece_lift", "targetname");
  var_00 common_scripts\utility::func_9D9F();
  var_00 sethintstring(&"ZOMBIE_NEST_OBJECTIVE_OFFLINE");
  var_00 thread func_2EB2();
  var_00.var_65E7 = getent("inner_spire_lever", "targetname");
  var_00.var_65E7.var_65E6 = getent(var_00.var_65E7.var_01A2, "targetname");
  var_00.var_65E7 func_A180(0);
  var_00.var_65E7 func_A180(4);
  var_01 = getEntArray("nest_ee_fuse_outter_objectives", "targetname");
  foreach(var_03 in var_01) {
    var_03 sethintstring(&"ZOMBIE_NEST_OBJECTIVE_OFFLINE");
    var_03 thread func_2EB2();
    var_03.var_65E7 = getent(var_03.var_01A2, "targetname");
    var_03.var_65E7.var_65E6 = getent(var_03.var_65E7.var_01A2, "targetname");
    var_03.var_65E7 func_A180(0);
    var_03.var_65E7 func_A180(4);
  }
}

func_2EB2() {
  level endon("flag_fuse_entered_correct");
  level endon("nest_ee_fuses_complete");
  for(;;) {
    self waittill("trigger", var_00);
    if(lib_0557::func_783E("5 Right Hand fuses", "fuse matching start")) {
      break;
    }

    if(common_scripts\utility::func_562E(var_00.var_3072)) {
      continue;
    } else {
      var_01 = var_00 lib_0367::func_8E3D("lightningrodmachine");
      if(isDefined(var_01)) {
        var_00.var_3072 = 1;
      }
    }
  }
}

func_46ED(param_00, param_01, param_02) {
  var_03 = [];
  var_03["main_trigger"] = func_8A4B();
  var_03["activation_triggers"] = getEntArray(param_01, "targetname");
  var_03["lightning_rods"] = getEntArray(param_00, "targetname");
  var_03["attack_positions"] = [];
  for(var_04 = 0; var_04 < param_02.size; var_04++) {
    var_03["attack_positions"][var_04] = getent(param_02[var_04], "targetname");
    var_03["attack_positions"][var_04].var_AC6A = common_scripts\utility::func_46B7(var_03["attack_positions"][var_04].var_01A2, "targetname");
  }

  return var_03;
}

func_86D9(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_04["notifications"] = spawnStruct();
  var_04["notifications"].var_94D4 = param_00;
  var_04["notifications"].var_39D1 = param_01;
  var_04["battleID"] = param_02;
  var_04["machine_targetnames"] = param_03;
  return var_04;
}