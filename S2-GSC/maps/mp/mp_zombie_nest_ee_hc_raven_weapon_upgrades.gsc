/******************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades.gsc
******************************************************************/

func_00F9() {
  common_scripts\utility::func_3C87("flag_nest_hc_ee_death_assembled");
  common_scripts\utility::func_3C87("flag_nest_hc_ee_moon_assembled");
  common_scripts\utility::func_3C87("flag_nest_hc_ee_blood_assembled");
  common_scripts\utility::func_3C87("flag_nest_hc_ee_storm_assembled");
  lib_0557::func_4BC9("tesla gun upgraded", "upgrading tesla gun", "CONST_HC_ANALYTICS_TESLA_GUNS_UPGRADED");
  var_04 = [];
  var_04 = maps\mp\mp_zombie_nest_ee_workbench::func_536D();
  var_04["death weapon trig"] thread func_7B96("death_raven_hc_ee", ::func_7A87, "trap_catacombs", "zombie_exploder", "teslagun_zm_death", "uber_reciever_gate_1", "flag_nest_hc_ee_death_assembled", "r.death uber get", "r.death uber fill", "r.death tesla built");
  var_04["moon weapon trig"] thread func_7B96("moon_raven_hc_ee", ::func_7A8B, "trap_roof", "zombie_generic", "teslagun_zm_moon", "uber_reciever_gate_3", "flag_nest_hc_ee_moon_assembled", "r.moon uber get", "r.moon uber fill", "r.moon tesla built");
  var_04["blood weapon trig"] thread func_7B96("blood_raven_hc_ee", ::func_7A89, "trap_med", "zombie_berserker", "teslagun_zm_blood", "uber_reciever_gate_2", "flag_nest_hc_ee_blood_assembled", "r.blood uber get", "r.blood uber fill", "r.blood tesla built");
  var_04["storm weapon trig"] thread func_7B96("storm_raven_hc_ee", ::func_7A8A, "trap_rnd", "zombie_heavy", "teslagun_zm_storm", "uber_reciever_gate_4", "flag_nest_hc_ee_storm_assembled", "r.storm uber get", "r.storm uber fill", "r.storm tesla built");
  thread func_7A8E();
  thread completedeathreward();
  thread completestormreward();
  thread completebloodreward();
  thread completemoonreward();
}

func_7B96(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  lib_0557::func_4BC9(param_07);
  lib_0557::func_4BC9(param_08);
  lib_0557::func_4BC9(param_09);
  maps\mp\mp_zombie_nest_ee_workbench::func_AA75();
  var_0A = undefined;
  var_0B = undefined;
  var_0C = common_scripts\utility::func_46B5(param_00, "targetname");
  var_0C.var_9C92 = common_scripts\utility::func_46B5(param_02, "script_noteworthy");
  var_0C.var_9CD6 = common_scripts\utility::func_44BE(param_02 + "_uber_collector", "targetname");
  var_0D = common_scripts\utility::func_44BE(var_0C.var_01A2, "targetname");
  var_0E = function_021F(param_02 + "_uber_collector", "targetname");
  var_0F = var_0E[0];
  var_10 = [];
  var_10["raven_uber_trap_deposit_alter"] = var_0F;
  var_10["raven_uber_trap_deposit_alter"] maps\mp\mp_zombie_nest_hilt_altar_reciever::func_84DB();
  var_11 = common_scripts\utility::func_46B5(var_0C.var_01A2 + "_trap_reciever", "targetname");
  var_0D = common_scripts\utility::func_0F6F(var_0D, var_11);
  var_0D = common_scripts\utility::func_0F73(var_0D, var_0C.var_9CD6);
  foreach(var_13 in var_0D) {
    if(!isDefined(var_13.var_0165)) {
      continue;
    }

    switch (var_13.var_0165) {
      case "cover_model":
        var_10[var_13.var_0165] = var_13;
        break;

      case "tesla_fuse_box":
        var_10[var_13.var_0165] = var_13;
        break;

      case "fuse_pickup":
        var_10[var_13.var_0165] = var_13;
        var_10[var_13.var_0165] method_805C();
        break;

      case "fuse_pickup_offset":
        var_10[var_13.var_0165] = var_13;
        break;

      case "raven_uber_trap_deposit":
        var_10[var_13.var_0165] = var_13;
        var_10[var_13.var_0165].var_3E3C = common_scripts\utility::func_46B5(var_10[var_13.var_0165].var_01A5 + "_forge", "targetname");
        var_10[var_13.var_0165].var_65D5 = param_00;
        break;

      case "raven_uber_trap_deposit_trig":
        var_10[var_13.var_0165] = var_13;
        break;

      case "raven_trap_pickup_trig_offset":
        var_10[var_13.var_0165] = var_13;
        break;

      case "hint_light":
        var_10[var_13.var_0165] = var_13;
        break;

      case "success_light_1":
        var_10[var_13.var_0165] = var_13;
        break;

      case "success_light_2":
        var_10[var_13.var_0165] = var_13;
        break;

      case "success_light_3":
        var_10[var_13.var_0165] = var_13;
        break;

      case "zombie_spawner":
        var_10[var_13.var_0165] = var_13;
        break;

      default:
        break;
    }
  }

  var_15 = [];
  var_15[0] = var_10["success_light_1"];
  var_15[1] = var_10["success_light_2"];
  var_15[2] = var_10["success_light_3"];
  var_10["hint_light"] thread func_9870(param_02, param_03, var_0C.var_9CD6);
  var_16 = getent(var_10["raven_uber_trap_deposit"].var_3E3C.var_01A2, "targetname");
  var_17 = getent(var_10["raven_uber_trap_deposit"].var_3E3C.var_01A2, "targetname");
  var_18 = getent(param_05, "targetname");
  var_19 = getent(var_17.var_01A2, "targetname");
  var_19 method_805C();
  if(!isDefined(level.var_7A86)) {
    level.var_7A86 = [];
  }

  level.var_7A86 = common_scripts\utility::func_0F6F(level.var_7A86, var_17);
  var_0C.var_9C92.var_579D = 0;
  var_0C.var_9C92 thread func_A6C1(param_03, param_02, var_10["raven_uber_trap_deposit"], var_10["raven_uber_trap_deposit_alter"], var_15, param_00);
  if(!isDefined(level.var_7A85)) {
    level.var_7A85 = [];
  }

  level.var_7A85 = common_scripts\utility::func_0F6F(level.var_7A85, var_18);
  var_18 thread func_3622(var_17, "5 Right Hand fuses", "lift outter rods");
  if(0) {
    common_scripts\utility::func_3C9F(lib_0557::func_7838("4 cart", "head to com"));
  }

  var_1A = var_0C[[param_01]](var_10);
  var_1B = var_1A[0];
  var_1C = var_1A[1];
  var_10["raven_uber_trap_deposit_alter"] thread maps\mp\mp_zombie_nest_hilt_altar_reciever::func_84DC();
  func_8F6E(var_1B, var_1C, func_4703(param_00), func_4702(param_00), param_00);
  var_0C.var_9C92.var_9FE5 = func_9FE9(var_0C, var_10["raven_uber_trap_deposit"], var_10["raven_uber_trap_deposit_trig"], func_4702(param_00), param_00);
  lib_0557::func_4BC8(param_07);
  var_0C.var_9C92.var_579D = 1;
  var_0C.var_9C92 waittill("raven_trap_complete");
  lib_0557::func_4BC8(param_08);
  var_0C.var_9C92.var_9FE5 method_805C();
  var_1D = lib_0585::func_8F7E(var_0C.var_9C92.var_9FE5.var_0116, func_4703(param_00), func_4702(param_00), var_10["raven_trap_pickup_trig_offset"].var_0116, param_00);
  var_10["raven_uber_trap_deposit_trig"] common_scripts\utility::func_9D9F();
  var_17 sethintstring(&"ZOMBIE_NEST_PLACE_UBER");
  var_17 usetouchtriggerrequirefacingposition(1, var_10["raven_uber_trap_deposit"].var_3E3C.var_0116);
  var_0C.var_9C92.var_9FE5.var_65E3 delete();
  var_0C.var_9C92.var_9FE5.var_0116 = var_10["raven_uber_trap_deposit"].var_3E3C.var_0116;
  var_0B = undefined;
  while(!isDefined(var_0B) || !var_0B lib_0585::func_9E12(param_00)) {
    var_17 waittill("trigger", var_0B);
  }

  var_0C.var_9C92.var_9FE5 method_805B();
  var_17 sethintstring(&"ZOMBIE_NEST_UBER_TRANSFER");
  var_10["main_trigger"] = var_17;
  var_1E["battleID"] = 3;
  var_1E["event_origin"] = var_10["main_trigger"].var_0116;
  var_1E["notifications"] = spawnStruct();
  var_1E["notifications"].var_94D4 = "hc_raven_" + param_00 + "_success";
  var_1E["notifications"].var_39D1 = "hc_raven_" + param_00 + "_fail";
  var_10["activation_triggers"] = [var_17];
  var_10["attack_positions"] = getent(var_19.var_01A2, "targetname");
  var_1F = spawnStruct();
  var_1F.var_7B8C = var_10["main_trigger"];
  var_1F.var_38C3 = "zombie_" + param_00 + "_rumble";
  var_1F.var_38C4 = [];
  var_1F.var_38C4["respawnExclusionRadius"] = 5000;
  var_1F.var_38C4["objectiveTime"] = 70;
  var_1F.var_38C4["objectiveHealth"] = 100;
  var_1F.var_38C4["zombieObjectiveMax"] = 3;
  var_1F.var_38C4["objectiveHealthSolo"] = 125;
  var_10["main_trigger"].var_1170 = var_10["attack_positions"];
  var_20 = getent("rnd_forge_machine_parts", "targetname");
  var_10["main_trigger"].var_65E8 = [var_20];
  if(param_00 == "moon_raven_hc_ee" || param_00 == "storm_raven_hc_ee") {
    var_21 = "rnd_attack_on_deck_positions_struct";
  } else {
    var_21 = "med_attack_on_deck_positions_struct";
  }

  if(!isDefined(level.raven_forge_active)) {
    level.raven_forge_active = 0;
  }

  maps\mp\mp_zombie_nest_special_event_creator::func_3135(::func_A6A4, var_10["main_trigger"], [var_10["attack_positions"]], var_1E["battleID"], var_1E["notifications"], var_10["activation_triggers"], var_10["main_trigger"].var_0165, var_1E["event_origin"], ::func_6A77, ::func_6A76, ::func_6A78, var_1F, ::func_6A7D, var_21);
  var_17 delete();
  if(!isDefined(level.var_3E3B) || !isDefined(level.var_5981)) {
    maps\mp\mp_zombie_nest_ee_util::func_8A53();
  }

  var_22 = level.var_3E3B;
  if(param_00 == "death_raven_hc_ee" || param_00 == "blood_raven_hc_ee") {
    var_22 = level.var_5981;
    thread maps\mp\mp_zombie_nest_ee_util::func_08B0();
    level waittill("med_create_ww_part");
  } else if(param_00 == "moon_raven_hc_ee" || param_00 == "storm_raven_hc_ee") {
    var_22 = level.var_3E3B;
    thread maps\mp\mp_zombie_nest_ee_util::func_08B6();
    level waittill("rnd_show_ww_part");
    var_22.var_6FC2 method_805B();
    level waittill("rnd_create_ww_part");
  }

  var_0B = var_22 maps\mp\mp_zombie_nest_ee_util::func_8BEC();
  if(!isDefined(level.var_AACA[param_04])) {
    level.var_AACA[param_04] = maps\mp\mp_zombie_nest_ee_workbench::func_AA7D(param_04, self);
  }

  var_23 = [0, undefined];
  while(!var_23[0]) {
    var_23 = maps\mp\mp_zombie_nest_ee_util::func_745D(level.var_AACA[param_04].var_48F2.var_0116, 250, 128);
    wait(1);
  }

  maps\mp\mp_zombie_nest_ee_workbench::func_AA7A(level.var_AACA[param_04]);
  common_scripts\utility::func_9DA3();
  self sethintstring(maps\mp\mp_zombie_nest_ee_workbench::func_AA71(param_04));
  var_24 = "";
  var_0B = undefined;
  while(!issubstr(var_24, "teslagun_zm")) {
    self waittill("trigger", var_0B);
    var_24 = var_0B getcurrentweapon();
    if(!issubstr(var_24, "teslagun_zm")) {
      var_0B iclientprintlnbold(&"ZOMBIE_NEST_ASSEMBLE_WW_REQUIRES");
    }
  }

  var_0B lib_0586::func_0790(var_0B getcurrentweapon());
  var_25 = var_0B getweaponslistprimaries();
  if(var_25.size > 0) {
    var_0B switchtoweapon(var_25[0]);
  }

  self sethintstring(&"ZOMBIE_NEST_ASSEMBLING_WW");
  level.var_AACA[param_04] maps\mp\mp_zombie_nest_ee_workbench::func_AA73();
  self sethintstring(maps\mp\mp_zombie_nest_ee_workbench::func_AA72(param_04));
  level.var_AACA[param_04] thread maps\mp\mp_zombie_nest_ee_workbench::func_AA76();
  lib_0557::func_4BC8(param_09);
  lib_0557::func_4BC8("tesla gun upgraded");
  if(isDefined(param_06) && common_scripts\utility::func_3C83(param_06)) {
    common_scripts\utility::func_3C8F(param_06);
  }
}

func_7A8E() {
  common_scripts\utility::func_3CA0("flag_nest_hc_ee_storm_assembled", "flag_nest_hc_ee_moon_assembled", "flag_nest_hc_ee_death_assembled", "flag_nest_hc_ee_blood_assembled");
  maps\mp\gametypes\zombies::func_47A8("ZM_TESLA_CHALLENGE");
}

func_3622(param_00, param_01, param_02) {
  param_00 common_scripts\utility::func_9D9F();
  self scriptmodelplayanim("zmb_forge_electric_coil_shutter_idle");
  func_A64D(param_01, param_02);
  func_6C01();
  param_00 common_scripts\utility::func_9DA3();
}

func_8F6E(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_00.var_0116;
  param_00 method_805C();
  var_06 = lib_0585::func_8F7E(var_05, param_02, param_03, undefined, param_04);
  var_07 = param_01.var_0116 - param_00.var_0116;
  var_08 = sqrt(abs(var_07[2] * 2 / 800));
  var_09 = 1 / var_08;
  var_0A = var_07 * (var_09, var_09, 0);
  var_06 gravitymove(var_0A, var_08);
  var_06 rotateto(param_01.var_001D, var_08);
  wait(var_08);
  var_06.var_0116 = param_01.var_0116;
}

func_6A77(param_00, param_01, param_02) {
  foreach(var_04 in level.var_7A86) {
    if(!isDefined(var_04)) {
      continue;
    }

    var_04 common_scripts\utility::func_9D9F();
  }

  foreach(var_07 in level.var_7A85) {
    var_07 thread func_2441();
  }
}

func_6A76(param_00, param_01) {
  var_02 = level.var_A980;
  while(level.var_A980 <= var_02) {
    wait(5);
  }

  foreach(var_04 in level.var_7A86) {
    if(!isDefined(var_04)) {
      continue;
    }

    var_04 common_scripts\utility::func_9DA3();
  }

  level.raven_forge_active = 0;
  foreach(var_07 in level.var_7A85) {
    var_07 thread func_6C01();
  }
}

func_6A78(param_00, param_01, param_02) {
  var_03 = level.var_A980;
  while(level.var_A980 <= var_03) {
    wait(5);
  }

  level.raven_forge_active = 0;
  foreach(var_05 in level.var_7A86) {
    var_05 common_scripts\utility::func_9DA3();
  }

  foreach(var_08 in level.var_7A85) {
    var_08 thread func_6C01();
  }
}

func_6A7D(param_00, param_01, param_02) {}

func_A6A4(param_00, param_01, param_02) {
  var_03 = undefined;
  var_04 = 0;
  foreach(var_06 in param_00) {
    if(!isDefined(var_06.var_57A4)) {
      var_04 = 0;
    }

    var_06.var_57A4 = 0;
    var_06 thread func_A6C0(var_04);
  }

  var_08 = 0;
  var_09 = undefined;
  while(var_08 < param_00.size) {
    level waittill("ee trigger was repaired", var_03, var_06);
    var_09 = var_03;
    if(common_scripts\utility::func_0F79(param_00, var_06)) {
      var_08++;
    }
  }
}

func_A6C0(param_00) {
  common_scripts\utility::func_9DA3();
  var_01 = undefined;
  while(!self.var_57A4) {
    self waittill("trigger", var_01);
    if(common_scripts\utility::func_562E(level.raven_forge_active)) {
      continue;
    } else {
      level.raven_forge_active = 1;
    }

    if(param_00 == 0 || var_01 maps\mp\gametypes\zombies::func_11C2(param_00)) {
      self.var_28D5 = 0;
      self.var_57A4 = 1;
    }
  }

  common_scripts\utility::func_9D9F();
  level notify("ee trigger was repaired", var_01, self);
}

func_42ED(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "blood":
      var_01 = "flag_nest_hc_ee_blood_assembled";
      break;

    case "death":
      var_01 = "flag_nest_hc_ee_death_assembled";
      break;

    case "storm":
      var_01 = "flag_nest_hc_ee_storm_assembled";
      break;

    case "moon":
      var_01 = "flag_nest_hc_ee_moon_assembled";
      break;

    default:
      break;
  }

  return var_01;
}

func_9870(param_00, param_01, param_02) {
  var_03 = func_45CA(param_01);
  var_04 = var_03[0];
  var_05 = var_03[1];
  var_06 = spawn("script_model", self.var_0116);
  var_06 setModel("tag_origin");
  var_07 = spawnStruct();
  var_07.var_5764 = 0;
  var_08 = self.var_0116;
  for(;;) {
    var_09 = func_440B();
    var_0A = 0;
    for(var_0B = 0; var_0B < var_09.size; var_0B++) {
      if(distance(self.var_0116, var_09[var_0B].var_0116) < 256 && isDefined(var_09[var_0B].var_0A4B) && var_09[var_0B].var_0A4B == param_01) {
        var_0A = common_scripts\utility::func_98E7(var_0A < var_04, var_0A + 1, var_04);
      }
    }

    if(var_0A == var_04 && !common_scripts\utility::func_562E(var_07.var_5764)) {
      var_07.var_5764 = 1;
      maps\mp\mp_zombie_nest_hilt_altar_reciever::func_84D6();
    } else if(common_scripts\utility::func_562E(var_07.var_5764)) {
      var_07.var_5764 = 0;
      maps\mp\mp_zombie_nest_hilt_altar_reciever::func_84D5();
    }

    wait(0.5);
  }
}

func_440B() {
  var_00 = maps\mp\agents\_agent_utility::func_43FD("all");
  var_01 = [];
  foreach(var_03 in var_00) {
    if(var_03.var_000A == level.var_746E) {
      continue;
    }

    if(isalive(var_03)) {
      var_01 = common_scripts\utility::func_0F6F(var_01, var_03);
    }
  }

  return var_01;
}

func_4703(param_00) {
  var_01 = &"ZOMBIE_NEST_PICKUP_UBER_DEATH";
  switch (param_00) {
    case "moon_raven_hc_ee":
      var_01 = &"ZOMBIE_NEST_PICKUP_UBER_MOON";
      break;

    case "death_raven_hc_ee":
      var_01 = &"ZOMBIE_NEST_PICKUP_UBER_DEATH";
      break;

    case "blood_raven_hc_ee":
      var_01 = &"ZOMBIE_NEST_PICKUP_UBER_BLOOD";
      break;

    case "storm_raven_hc_ee":
      var_01 = &"ZOMBIE_NEST_PICKUP_UBER_STORM";
      break;
  }

  return var_01;
}

func_4702(param_00) {
  var_01 = "zmb_gp_uber_01";
  switch (param_00) {
    case "moon_raven_hc_ee":
      var_01 = "zmb_gp_uber_01_moon";
      break;

    case "death_raven_hc_ee":
      var_01 = "zmb_gp_uber_01_death";
      break;

    case "blood_raven_hc_ee":
      var_01 = "zmb_gp_uber_01_blood";
      break;

    case "storm_raven_hc_ee":
      var_01 = "zmb_gp_uber_01_storm";
      break;
  }

  return var_01;
}

func_A6B0(param_00) {
  for(var_01 = undefined; !isDefined(var_01) || var_01 != param_00; var_01 = var_02) {
    self waittill("player_used", var_02);
  }
}

func_902C(param_00, param_01) {
  var_02 = spawn("script_model", param_00.var_0116);
  var_02.var_01A5 = param_01 + "_uber_receiver";
  if(isDefined(param_00.var_001D)) {
    var_02.var_001D = param_00.var_001D;
  }

  var_02 setModel("zmb_gp_uber_01");
  playFXOnTag(level.var_0611[param_01 + "_uber"], var_02, "tag_origin");
  return var_02;
}

func_44EB(param_00) {
  var_01 = "";
  switch (param_00) {
    case "forge_rnd":
      var_01 = "ww_part_01_pickup";
      break;

    case "forge_med":
      var_01 = "ww_part_02_pickup";
      break;

    default:
      break;
  }

  var_02 = getent(var_01, "targetname");
  return var_02.var_7AC4;
}

func_9FE9(param_00, param_01, param_02, param_03, param_04) {
  param_02 sethintstring(&"ZOMBIE_NEST_PLACE_UBER");
  var_05 = undefined;
  while(!isDefined(var_05) || !var_05 lib_0585::func_9E12(param_04)) {
    param_02 waittill("trigger", var_05);
  }

  var_06 = spawn("script_model", param_01.var_0116);
  var_06 setModel(param_03);
  var_06.var_65E4 = param_01;
  param_02 common_scripts\utility::func_9D9F();
  return var_06;
}

func_A64D(param_00, param_01) {
  level endon("open all forge uber doors");
  common_scripts\utility::func_3C9F(lib_0557::func_7838(param_00, param_01));
}

func_6C01() {
  self scriptmodelplayanim("zmb_forge_electric_coil_shutter_up");
  lib_0378::func_8D74("aud_compartment_door_open");
  wait(getanimlength(%zmb_forge_electric_coil_shutter_up));
  self scriptmodelplayanim("zmb_forge_electric_coil_shutter_up_idle", "shutter_up");
}

func_2441() {
  self scriptmodelplayanim("zmb_forge_electric_coil_shutter_down");
  lib_0378::func_8D74("aud_compartment_door_close");
  wait(getanimlength(%zmb_forge_electric_coil_shutter_down));
  self scriptmodelplayanim("zmb_forge_electric_coil_shutter_idle", "shutter_down");
}

func_7A8A(param_00) {
  if(!0) {
    if(0) {
      while(!isDefined(level.var_744A) || distance(level.var_744A[0].var_0116, param_00["tesla_fuse_box"].var_0116) > 256) {
        wait(0.1);
      }

      param_00["zombie_spawner"] thread func_902D();
    }

    param_00["cover_model"] setCanDamage(1);
    var_01 = 0;
    while(!var_01) {
      level waittill("objective_zombie_exploder_detonation", var_02, var_03);
      var_04 = getent(param_00["fuse_pickup"].var_01A2, "targetname");
      if(distance(var_04.var_0116, var_02) <= 150) {
        var_01 = 1;
      }
    }
  }

  param_00["cover_model"] thread func_1806();
  var_05 = getent(param_00["fuse_pickup"].var_01A2, "targetname");
  var_06 = param_00["fuse_pickup"];
  return [var_05, var_06];
}

func_7A87(param_00) {
  if(0) {
    while(!isDefined(level.var_744A) || distance(level.var_744A[0].var_0116, param_00["cover_model"].var_0116) > 256) {
      wait(0.1);
    }

    param_00["zombie_spawner"] thread func_9064();
  }

  param_00["fuse_pickup"] method_805C();
  func_A6A2(param_00["cover_model"]);
  param_00["cover_model"] thread func_1806();
  var_01 = getent(param_00["fuse_pickup"].var_01A2, "targetname");
  var_02 = param_00["fuse_pickup"];
  return [var_01, var_02];
}

func_1806() {
  lib_0378::func_8D74("blow_open_uber_concealment_door");
  level thread common_scripts\_exploder::func_088E(239);
  self setModel("zmb_objective_panel_door_dmg_01");
  self.var_0116 = self.var_0116 + (0, 0, 64);
  self gravitymove(-200 * vectornormalize(common_scripts\utility::func_3D5C(anglesToForward(self.var_001D))) + (0, 0, 50), 1);
  self rotateby((360, 360, 360), 1);
}

func_7A8B(param_00) {
  param_00["fuse_pickup"] method_805C();
  func_A6C3(param_00);
  param_00["cover_model"] scriptmodelplayanim("zmb_breakable_statue_bursting", "statue_burst");
  playFX(level.var_0611["zmb_hc_statue"], param_00["cover_model"].var_0116);
  param_00["cover_model"] lib_0378::func_8D74("aud_break_statue");
  param_00["fuse_pickup"] method_805B();
  param_00["fuse_pickup"] maps\mp\mp_zombie_nest_ee_util::func_A725("teslagun_zm");
  var_01 = common_scripts\utility::func_46B5(param_00["fuse_pickup"].var_01A2, "targetname");
  var_02 = param_00["fuse_pickup"];
  var_03 = var_01;
  var_02 method_805C();
  return [var_02, var_03];
}

func_7A88(param_00) {
  level endon("raven up skip");
  func_A6A3(param_00["cover_model"]);
  param_00["cover_model"] method_805C();
  if(!1) {
    maps\mp\mp_zombie_nest_ee_util::func_A6CE(param_00["tesla_fuse_box"]);
  }

  var_01 = param_00["fuse_pickup"] func_A6B9(&"ZOMBIE_NEST_PICKUP_UBER", (0, 0, 32));
  return var_01;
}

func_7A89(param_00) {
  level endon("raven up skip");
  var_01 = 0;
  var_02 = getent("raven_blood_challenge_lights_start", "targetname");
  var_03 = spawn("script_model", var_02.var_0116);
  var_03 setModel("tag_origin");
  var_02 setCanDamage(1);
  var_02 maps\mp\mp_zombie_nest_ee_util::func_A725("teslagun_zm");
  playFXOnTag(common_scripts\utility::func_44F5("temp_hc_challenge_indicator_lights"), var_03, "tag_origin");
  var_03 method_8449(var_02);
  var_04 = maps\mp\mp_zombie_nest_ee_util::func_44C8(var_02.var_01A2, 1);
  var_02.var_775E = 0;
  lib_0378::func_8D74("tesla_hc_energy_lamp_loop_on", var_02.var_0116);
  wait 0.05;
  while(var_02.var_775E < var_04.size) {
    var_02.var_0116 = var_04[var_02.var_775E].var_0116;
    var_02 thread func_39EA(6);
    var_02 waittill("trigger");
    if(var_02.var_775E >= 0) {
      lib_0378::func_8D74("tesla_hc_energy_lamp_destruct", var_02.var_0116);
    }

    var_02.var_775E++;
    wait(0.15);
  }

  lib_0378::func_8D74("tesla_hc_energy_lamp_loop_off", var_02.var_0116);
  stopFXOnTag(common_scripts\utility::func_44F5("temp_hc_challenge_indicator_lights"), var_03, "tag_origin");
  var_06 = getent(param_00["fuse_pickup"].var_01A2, "targetname");
  var_02.var_0116 = var_06.var_0116;
  var_07 = getent(param_00["fuse_pickup"].var_01A2, "targetname");
  var_08 = param_00["fuse_pickup"];
  return [var_07, var_08];
}

func_39EA(param_00) {
  self endon("trigger");
  wait(param_00);
  self.var_775E = -1;
  self notify("trigger");
}

func_A6A3(param_00) {
  level endon("raven up skip");
  param_00 setCanDamage(1);
  for(var_01 = ""; var_01 != "MOD_GRENADE_SPLASH" && var_01 != "MOD_IMPACT" && var_01 != "MOD_EXPLOSIVE"; var_01 = var_06) {
    param_00 waittill("damage", var_02, var_03, var_04, var_05, var_06);
  }
}

func_45CA(param_00) {
  var_01 = 5;
  var_02 = 3;
  switch (param_00) {
    case "zombie_berserker":
      var_01 = 5;
      var_02 = 3;
      break;

    case "zombie_heavy":
      var_01 = 2;
      var_02 = 2;
      break;

    case "zombie_exploder":
      var_01 = 2;
      var_02 = 2;
      break;

    case "zombie_fireman":
      var_01 = 1;
      var_02 = 1;
      break;

    default:
      break;
  }

  return [var_01, var_02];
}

func_6FEE(param_00) {
  if(!common_scripts\utility::func_562E(param_00.var_2EE3)) {
    param_00.var_2EE3 = 1;
    self notify("zombie trap killed", param_00.var_0A4B, param_00.var_0116);
    wait 0.05;
  }
}

func_A6C1(param_00, param_01, param_02, param_03, param_04, param_05) {
  level endon("raven hc skip trap collection for " + param_01);
  var_06 = 3;
  var_07 = 0;
  var_08 = func_45CA(param_00);
  var_09 = var_08[0];
  var_0A = var_08[1];
  var_0B = 0;
  var_0C = 0;
  self.var_9CB0 = 0;
  var_0D = undefined;
  param_03 thread maps\mp\mp_zombie_nest_hilt_altar_reciever::func_84D9(1);
  param_03 thread maps\mp\mp_zombie_nest_hilt_altar_reciever::func_84D9(2);
  param_03 thread maps\mp\mp_zombie_nest_hilt_altar_reciever::func_84D9(3);
  while(var_0C < var_0A) {
    self.var_9CB0 = 0;
    var_0D = func_A667();
    if(!isDefined(var_0D)) {
      var_0D = "not zombie";
    }

    if(var_0D == param_00 || param_00 == "zombie_any") {
      var_0B = func_9E1E(var_0D, var_09, var_06);
    }

    if(common_scripts\utility::func_562E(var_0B)) {
      if(!self.var_579D) {
        playFX(level.var_0611["zmb_receiver_charge_lost"], param_03.var_0116, anglesToForward(param_03.var_001D), anglestoup(param_03.var_001D));
        continue;
      }

      playFX(level.var_0611["zmb_receiver_charge_pnt"], param_03.var_0116, anglesToForward(param_03.var_001D), anglestoup(param_03.var_001D));
      lib_0378::func_8D74("aud_battery_electrocute");
      var_0B = undefined;
      var_0C++;
      if(isDefined(self.var_9FE5.var_65E3)) {
        self.var_9FE5.var_65E3 delete();
      }

      self.var_9FE5.var_65E3 = lib_0547::func_8FBA(self.var_9FE5.var_65E4, param_05 + "_uber_stg_" + var_0C);
      triggerfx(self.var_9FE5.var_65E3);
      param_04 thread maps\mp\mp_zombie_nest_hilt_altar_reciever::func_84DD(var_0C);
    }
  }

  self notify("raven_trap_complete");
  playFX(level.var_0611["zmb_receiver_full"], param_03.var_0116, anglesToForward(param_03.var_001D), anglestoup(param_03.var_001D));
}

func_A667() {
  self waittill("zombie trap killed", var_00, var_01);
  return var_00;
}

func_9E1E(param_00, param_01, param_02) {
  self endon("uber timeout");
  thread func_9FE8(param_02);
  self.var_9CB0 = 1;
  while(self.var_9CB0 < param_01) {
    var_03 = func_A667();
    if(!isDefined(var_03)) {
      var_03 = "not zombie";
    }

    if(var_03 == param_00 || param_00 == "zombie_any") {
      self.var_9CB0++;
    }
  }

  return 1;
}

func_9FE8(param_00) {
  wait(param_00);
  self notify("uber timeout");
}

func_A6C3(param_00) {
  var_01 = param_00["cover_model"];
  var_02 = param_00["fuse_pickup"];
  level endon("raven up skip");
  var_01.var_8C80 = 1;
  lib_057E::func_0984(var_01, var_01, ::func_6BA2);
  var_01 waittill("sentry_damage");
}

func_6BA2(param_00, param_01) {
  param_00 notify("sentry_damage");
}

func_902D() {
  for(;;) {
    var_00 = lib_054D::func_90BA("zombie_exploder", self, "storm raven test", 0, 1, 1);
    wait(5);
  }
}

func_9064() {
  for(;;) {
    var_00 = lib_054D::func_90BA("zombie_heavy", self, "storm raven test", 0, 1, 1);
    wait(5);
  }
}

func_A6A2(param_00) {
  self endon("follower striked");
  level endon("raven up skip");
  var_01 = 0;
  while(!var_01) {
    level waittill("follower swing", var_02, var_03);
    if(distance(param_00.var_0116, var_02) < var_03) {
      var_01 = 1;
    }
  }
}

func_A6B9(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_01)) {
    param_01 = (0, 0, 0);
  }

  self method_805B();
  if(isDefined(param_02)) {
    lib_0547::func_AC41(param_00, undefined, param_02);
  } else {
    lib_0547::func_AC41(param_00, param_01);
  }

  var_04 = "";
  var_05 = undefined;
  while((!isDefined(param_03) && var_04 == "") || isDefined(param_03) && var_04 != param_03) {
    self waittill("player_used", var_05);
    var_04 = var_05 getcurrentweapon();
    if(isDefined(param_03) && var_04 != param_03) {
      var_05 iclientprintln("need wonder weap to skip");
    }
  }

  lib_0547::func_AC40();
  self delete();
  return var_05;
}

completedeathreward() {
  common_scripts\utility::func_3C9F("flag_nest_hc_ee_death_assembled");
  foreach(var_01 in level.var_744A) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("deathraven");
  }
}

completebloodreward() {
  common_scripts\utility::func_3C9F("flag_nest_hc_ee_blood_assembled");
  foreach(var_01 in level.var_744A) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("bloodraven");
  }
}

completestormreward() {
  common_scripts\utility::func_3C9F("flag_nest_hc_ee_storm_assembled");
  foreach(var_01 in level.var_744A) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("stormraven");
  }
}

completemoonreward() {
  common_scripts\utility::func_3C9F("flag_nest_hc_ee_moon_assembled");
  foreach(var_01 in level.var_744A) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("moonraven");
  }
}