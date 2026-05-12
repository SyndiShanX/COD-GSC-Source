/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_final_boss.gsc
****************************************************/

func_00F9() {
  common_scripts\utility::func_3C87("flag_all_players_in_hilt");
  common_scripts\utility::func_3C87("flag_hilt_collected");
  var_00 = getEntArray("nest_brute_uber_inserts", "targetname");
  foreach(var_02 in var_00) {
    var_02 method_805C();
  }

  var_04 = getEntArray("brute_final_barrier", "targetname");
  foreach(var_02 in var_04) {
    var_02 method_805C();
  }

  func_51EB();
  func_AA0B();
  lib_0557::func_7846("8A The Hilt", ::lib_0557::func_30D8, ["6B Left Hand overcharge", "7 Voice paintings", "6A Left Hand blimp parts", "5 Right Hand fuses"], &"ZOMBIE_NEST_HINT_QUEST_HILT", "ZOMBIE_NEST_HINT_QUEST_HILT");
  lib_0557::func_781E("8A The Hilt", "Use Hilt", ::func_785A, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_OBTAIN_HILT");
  lib_0557::func_781E("8A The Hilt", "Shoot Hilt", ::func_785B, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_SHOOT_HILT");
  lib_0557::func_7848("8A The Hilt");
  lib_0557::func_7846("8B final boss", ::func_3AE7, ["8A The Hilt"], &"ZOMBIE_NEST_HINT_QUEST_BOSS", "ZOMBIE_NEST_HINT_QUEST_BOSS");
  lib_0557::func_781E("8B final boss", "final boss battle part 1", ::func_7853, ::lib_0557::func_30D8, &"ZOMBIE_NEST_DEFEAT_FINAL_BOSS");
  lib_0557::func_7848("8B final boss");
  level thread func_5177();
}

func_5177() {
  wait(1);
  func_1CB7();
}

func_785A() {
  var_00 = 0;
  foreach(var_02 in level.var_744A) {
    if(var_02 maps\mp\mp_zombie_nest_ee_util::func_7403()) {
      var_00++;
    }
  }

  if(var_00 >= level.var_744A.size) {
    common_scripts\utility::func_3C8F("flag_all_players_in_hilt");
  } else {
    thread func_0C34();
    if(1) {
      var_04 = getent("hilt_altar_model", "targetname");
      if(isDefined(var_04)) {
        var_05 = lib_0557::func_782F(undefined, var_04);
        lib_0557::func_781D("8A The Hilt", var_05);
      }
    }
  }

  common_scripts\utility::func_3C9F("flag_all_players_in_hilt");
  lib_0557::func_782D("8A The Hilt", "Use Hilt");
}

func_785B() {
  foreach(var_01 in level.var_744A) {
    maps\mp\_utility::func_2CED(2, ::lib_0555::func_83DD, "nest_no_return", var_01);
  }

  var_03 = getent("hilt_altar_model", "targetname");
  if(isDefined(var_03)) {
    var_04 = lib_0557::func_782F(undefined, var_03);
    lib_0557::func_781D("8A The Hilt", var_04);
  }

  func_A68E();
  lib_0557::func_782D("8A The Hilt", "Shoot Hilt");
}

func_7853() {
  func_A68E();
  level.var_6F1E = 1;
  level.pause_treasure_zombie_reason = "players are fighting the brute";
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8608();
  maps\mp\gametypes\zombies::func_08B2((0, 0, 0), 1);
  func_310A();
  var_00 = func_9008();
  var_00 func_8FF5();
  func_83DF();
  thread func_7432(0.25, 0);
  foreach(var_02 in level.var_744A) {
    if(lib_0547::func_5565(lib_0378::func_307B(var_02.var_20D8), "mari")) {
      var_02 lib_0367::func_8E3D("klausnononono", level.var_744A);
    }
  }

  level thread common_scripts\_exploder::func_2A6D(238, undefined, 0);
  level thread func_76A1();
  level thread func_92B5(3);
  level.var_179A lib_0560::func_AB83();
  if(maps\mp\mp_zombie_nest_ee_hc_true_voice::func_744B()) {
    var_00.var_52D0 = 17500;
    var_00.var_7B44 = 7500;
    var_00.var_5C61 = 120;
  } else {
    var_00.var_52D0 = 12500;
    var_00.var_7B44 = 5000;
    var_00.var_5C61 = 60;
  }

  lib_0557::func_7822("8B final boss", &"ZOMBIE_NEST_DEFEAT_FINAL_BOSS");
  maps\mp\_events_z::start_boss_battle_tracking();
  level func_9308(var_00);
  maps\mp\_events_z::end_boss_battle_tracking();
  thread func_3BEB();
  thread func_3BE5();
  thread maps\mp\mp_zombie_nest_ee_util::func_9EC4();
  level thread func_93F5();
  level func_310B(var_00);
  level func_238D();
  thread maps\mp\mp_zombie_nest_ee_util::func_9EC5();
  level.var_6F1E = 0;
  foreach(var_02 in level.var_744A) {
    var_02 setlocalplayerprofiledata("specialUnlocks", 1, "1");
  }

  maps\mp\gametypes\zombies::func_47A8("ZM_BRUTE");
  if(maps\mp\mp_zombie_nest_ee_hc_true_voice::func_744B()) {
    maps\mp\gametypes\zombies::func_47A8("ZM_KLAUS");
    level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("mp_zombie_nest_01_final_boss", 1);
  } else {
    level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("mp_zombie_nest_01_final_boss", 0);
  }

  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("any_boss_completed");
  thread maps\mp\mp_zombie_nest_ee_fire_well::func_AA07();
  level thread func_4AD1();
}

func_7432(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(!isDefined(param_02)) {
    param_02 = "white";
  }

  foreach(var_04 in level.var_744A) {
    if(param_01 >= 1) {
      if(isDefined(var_04.var_1781)) {
        var_04.var_1781 destroy();
      }

      var_04.var_1781 = func_2787("black", 0, var_04, (1, 1, 1));
      var_04.var_1781 setshader(param_02, 640, 480);
    }

    if(isDefined(var_04.var_1781)) {
      var_04.var_1781 fadeovertime(param_00);
      var_04.var_1781.var_0018 = param_01;
    }
  }

  wait(param_00);
}

func_3BEB() {
  var_00 = function_021F("fire_on", "targetname");
  foreach(var_02 in var_00) {
    wait(0.1);
    var_02 setscriptablepartstate("fire", "die");
  }
}

func_3BE5() {
  var_00 = function_021F("fill_on", "targetname");
  foreach(var_02 in var_00) {
    wait(0.1);
    var_02 setscriptablepartstate("fire_fill", "die");
  }
}

func_92B5(param_00) {
  level endon("stop_start_zombie_minimum");
  for(;;) {
    var_01 = lib_0547::func_408F();
    var_02 = var_01.size;
    if(var_02 < 3) {
      for(var_03 = 0; var_03 < 3 - var_02; var_03++) {
        var_04 = lib_054D::func_90BA("zombie_generic", undefined, "wave system", 1, 0, 1, undefined);
      }
    }

    wait(3);
  }
}

func_93F5() {
  level notify("stop_start_zombie_minimum");
}

func_0C34() {
  for(;;) {
    var_00 = 0;
    foreach(var_02 in level.var_744A) {
      if(var_02 maps\mp\mp_zombie_nest_ee_util::func_7403()) {
        var_00++;
      }
    }

    if(var_00 >= level.var_744A.size) {
      common_scripts\utility::func_3C8F("flag_all_players_in_hilt");
      break;
    } else {
      wait(1);
    }
  }
}

func_38D9(param_00) {
  maps\mp\mp_zombie_nest_ee_fire_well::func_848C();
  param_00 func_A695();
  param_00 func_1C88();
  param_00.var_3ACE delete();
  maps\mp\mp_zombie_nest_ee_fire_well::func_848D(1);
}

func_9008() {
  var_00 = common_scripts\utility::func_46B5("final_brute_boss", "targetname");
  var_01 = lib_054D::func_90BA("zombie_boss_village", var_00, "fire well", 0, 0, 0);
  var_01.var_1CBD = var_00;
  var_01 lib_0547::func_84CB();
  return var_01;
}

func_1C88() {
  level notify("brute battle complete");
  level.var_1CBA = 0;
}

func_A695() {
  level endon("brute battle complete");
  level.var_1CBA = 1;
  func_8A0A();
  thread lib_055F::func_1CC6();
  var_00 = func_8A09();
  var_01 = var_00["brute_sequences_completed"];
  var_02 = var_00["brute_health_checkpoints"];
  var_03 = "";
  var_04 = -15536;
  for(var_05 = 0; var_05 < var_02.size; var_05++) {
    var_06 = func_A697(-15536, -15536 - self.var_52D0);
    func_6AC8();
    if(var_05 == var_02.size - 1) {
      function_028E("mp/zombie_outro");
    }

    if(var_05 < var_02.size - 1) {
      if(isDefined(var_06)) {
        var_06 thread func_2E81();
      }

      func_92E2();
      continue;
    }

    level notify("brute battle complete");
  }
}

func_A697(param_00, param_01) {
  var_02 = param_00;
  var_03 = 0;
  var_04 = undefined;
  while(!var_03) {
    func_A6CA(var_02, param_01);
    if(self.var_0BA4 == "traverse") {
      while(self.var_0BA4 == "traverse") {
        wait(1);
      }
    }

    var_05 = lib_055F::func_AB7B();
    var_03 = var_05[0];
    var_04 = var_05[1];
    if(!var_03) {
      var_02 = param_01 + self.var_7B44;
      lib_055F::func_AB75();
    }
  }

  return var_04;
}

func_6AC8() {
  thread func_1CCE();
}

func_92E2() {
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8606();
  self.var_99E6 = self.var_5C61;
  while(self.var_99E6 > 0) {
    self.var_99E6 = self.var_99E6 - 1;
    wait(1);
  }

  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8608();
  lib_0560::func_1F46();
  lib_055F::func_AB72();
}

func_A6CA(param_00, param_01) {
  for(var_02 = param_00; var_02 > param_01; var_02 = var_02 - var_03) {
    self waittill("brute_boss_damage", var_03, var_04);
    if(common_scripts\utility::func_562E(self.var_55A6)) {
      continue;
    }

    var_03 = maps\mp\mp_zombie_nest_ee_util::func_98ED(var_04, var_03);
    var_03 = var_03 / level.var_744A.size;
  }
}

func_1CCE() {
  playFX(common_scripts\utility::func_44F5("nuke_blast"), self.var_0116, anglesToForward(self.var_001D), anglestoup(self.var_001D));
  lib_0378::func_8D74("aud_nuke_explo");
  maps\mp\gametypes\zombies::func_281C("ammo", self.var_0116, "random", 0, 0);
  level thread maps\mp\gametypes\zombies::func_08B2(self.var_0116);
  lib_055F::func_AB79();
}

func_8A09() {
  var_00 = [];
  var_01 = [];
  var_02 = "";
  for(var_03 = 0; var_03 < 3; var_03++) {
    var_00[var_03] = 0;
    var_01[var_03] = -15536 * 1 - var_03 * 0.3333333 + 0.1666667;
    var_02 = var_02 + var_01[var_03] + " ";
  }

  var_04 = [];
  var_04["brute_sequences_completed"] = var_00;
  var_04["brute_health_checkpoints"] = var_01;
  return var_04;
}

func_8A0A() {
  self.var_3ACE = getent("brute_boss_agent_interact", "targetname");
  self.var_3ACE enablelinkto();
  self.var_3ACE method_8449(self);
  self.var_3ACE sethintstring(&"ZOMBIES_EMPTY_STRING");
}

func_2E81() {
  wait(3);
  lib_0367::func_8E3D("uberbossinsertion");
}

func_3AE7() {
  var_00 = level.var_744A;
  foreach(var_02 in var_00) {
    if(common_scripts\utility::func_562E(var_02.var_596A)) {
      var_02.besttimetrialtimes[4] = int(gettime() / 1000);
    }

    if(maps\mp\mp_zombie_nest_ee_hc_true_voice::func_744B()) {
      var_02 maps\mp\zombies\_zombies_rank::func_AC23("brutefinalehc");
      level.var_400E[level.var_400E.size] = ["survivalist_set 1 -1", "all"];
      var_02 lib_056A::func_4772(1);
    } else {
      var_02 maps\mp\zombies\_zombies_rank::func_AC23("brutefinale");
    }

    var_02 lib_0378::func_8D74("objective_complete", "brutefinale");
    var_02 lib_0468::func_0A2B("killBoss");
    level.var_400E[level.var_400E.size] = ["raven_set 1 1", "all"];
    if(level.var_A980 <= 12) {
      level.var_400E[level.var_400E.size] = ["assassin_set 0 1", "all"];
    }

    level.var_400E[level.var_400E.size] = ["assassin_set 1 1", "all"];
    level.var_400E[level.var_400E.size] = ["assassin_set 2 1", "all"];
    level.var_400E[level.var_400E.size] = ["assassin_set 3 1", "all"];
    level.var_400E[level.var_400E.size] = ["assassin_set 4 1", "all"];
  }
}

func_238D() {
  level.var_1CBA = 0;
  level thread func_5F28();
  func_7E33();
  lib_0557::func_782D("8B final boss", "final boss battle part 1");
}

func_51EB() {
  var_00 = common_scripts\utility::func_44BD("klaus_revive_spawn_point", "targetname");
}

func_4AD1() {
  var_00 = common_scripts\utility::func_44BD("klaus_revive_spawn_point", "targetname");
  var_01 = maps\mp\mp_zombie_nest_ee_hc_true_voice::func_744B();
  var_02 = 0;
  if(var_01) {
    var_02 = 6.7;
  } else {
    var_02 = 7.4;
  }

  if(var_01) {
    thread func_8FEE(var_00);
    if(level.var_744A.size < 2) {
      level.var_400E[level.var_400E.size] = ["bat_elite_set 0 1", "all"];
    }

    if(level.var_A980 <= 16) {
      level.var_400E[level.var_400E.size] = ["bat_elite_set 1 1", "all"];
    }

    if(gettime() - level.var_9309 <= 4500000) {
      level.var_400E[level.var_400E.size] = ["bat_elite_set 2 1", "all"];
    }

    level.var_400E[level.var_400E.size] = ["bat_elite_set 3 1", "all"];
    level.var_400E[level.var_400E.size] = ["bat_elite_set 4 1", "all"];
    level.var_400E[level.var_400E.size] = ["wicht_set 0 1", "all"];
  } else {
    thread func_8F93(var_00);
  }

  var_03 = maps\mp\agents\_agent_utility::func_43FD("all");
  foreach(var_05 in var_03) {
    if(var_05.var_000A == level.var_746E) {
      continue;
    }

    if(isalive(var_05)) {
      var_05.var_1DEB = 1;
      var_05 suicide();
    }
  }

  lib_056D::func_8A6E(1);
  func_83E0(var_00);
  var_07 = 1;
  func_7432(var_07, 0);
  foreach(var_09 in level.var_744A) {
    var_09 method_8004();
    var_09 setstance("stand");
    var_09 unlink();
    if(isDefined(var_09.var_1781)) {
      var_09.var_1781 destroy();
    }

    var_09.var_324E = 0;
  }

  var_0B = common_scripts\utility::func_46B7("klaus_player_pos", "targetname");
  var_0C = maps\mp\mp_zombie_nest_ee_util::func_440D();
  for(var_0D = 0; var_0D < var_0C.size; var_0D++) {
    var_0C[var_0D] thread func_74BE(var_00, var_0B[var_0D], var_01, var_02);
    var_0C[var_0D] thread lib_0367::func_8E3C("klauscorpseview");
  }

  if(var_01) {
    wait(4.666);
    common_scripts\utility::func_3C87("flag_dlg_klaus_reached_pnt_1");
    common_scripts\utility::func_3C87("flag_dlg_klaus_reached_pnt_2");
    common_scripts\utility::func_3C87("flag_dlg_klaus_reached_pnt_3");
    common_scripts\utility::func_3C87("flag_dlg_klaus_reached_pnt_4");
    common_scripts\utility::func_3C87("flag_klaus_reached_well");
    maps\mp\mp_zombie_nest_ee_fire_well::func_AA07();
    maps\mp\mp_zombie_nest_ee_fire_well::func_848C();
    level notify("klaus_getup");
    thread func_2E92();
    level.var_5A89 waittill("klaus_getup_finished");
    level.var_5A89 method_80B1();
    level.var_5A89 thread lib_0568::func_5A98();
    foreach(var_09 in level.var_744A) {
      var_09 lib_0547::func_8A6D(0);
    }

    lib_056D::func_8A6E(0);
    wait(1);
    var_10 = common_scripts\utility::func_46B5("klaus_mid_point", "targetname");
    var_11 = common_scripts\utility::func_46B5("klaus_mid_point_2", "targetname");
    var_12 = common_scripts\utility::func_46B5("klaus_mid_point_3", "targetname");
    var_13 = common_scripts\utility::func_46B5("klaus_ent_point", "targetname");
    thread func_5A9D();
    level.var_5A89 lib_0568::func_5A90(var_10);
    common_scripts\utility::func_3C8F("flag_dlg_klaus_reached_pnt_1");
    level.var_5A89 lib_0568::func_5A90(var_11);
    common_scripts\utility::func_3C8F("flag_dlg_klaus_reached_pnt_2");
    level.var_5A89 lib_0568::func_5A90(var_12);
    common_scripts\utility::func_3C8F("flag_dlg_klaus_reached_pnt_3");
    level.var_5A89 lib_0568::func_5A90(var_13);
    common_scripts\utility::func_3C8F("flag_dlg_klaus_reached_pnt_4");
    func_647E();
  } else {
    wait(7.3);
    foreach(var_09 in level.var_744A) {
      var_09 lib_0547::func_8A6D(0);
    }

    lib_056D::func_8A6E(0);
    func_AA0A();
  }

  var_16 = &"ZOMBIE_NEST_HINT_STEP_EPILOGUE_FAIL";
  if(var_01) {
    var_16 = &"ZOMBIE_NEST_HINT_STEP_EPILOGUE_SUCCESS";
  }

  lib_0557::func_7846("9 Epilogue", ::lib_0557::func_30D8, undefined, &"ZOMBIE_NEST_HINT_QUEST_EPILOGUE", "ZOMBIE_NEST_HINT_QUEST_EPILOGUE");
  lib_0557::func_781E("9 Epilogue", "Epilogue Step", undefined, ::lib_0557::func_30D8, var_16);
  lib_0557::func_7848("9 Epilogue");
}

func_2E92() {
  level.var_5A89 endon("klaus_exploit_warp");
  wait(8);
  foreach(var_01 in level.var_744A) {
    if(lib_0547::func_5565(lib_0378::func_307B(var_01.var_20D8), "mari")) {
      var_01 lib_0367::func_8E3D("holdstillbrotherifollowed", level.var_744A);
    }
  }

  level.var_5A89 waittill("klaus_getup_finished");
  wait(1);
  foreach(var_01 in level.var_744A) {
    if(lib_0547::func_5565(lib_0378::func_307B(var_01.var_20D8), "mari")) {
      var_01 lib_0367::func_8E3D("klaus", level.var_744A);
    }
  }

  common_scripts\utility::func_3C9F("flag_dlg_klaus_reached_pnt_1");
  lib_0378::func_8D74("aud_revived_klaus_speak", level.var_5A89, 3);
  common_scripts\utility::func_3C9F("flag_dlg_klaus_reached_pnt_2");
  lib_0378::func_8D74("aud_revived_klaus_speak", level.var_5A89, 4);
  common_scripts\utility::func_3C9F("flag_dlg_klaus_reached_pnt_3");
  lib_0378::func_8D74("aud_revived_klaus_speak", level.var_5A89, 5);
  common_scripts\utility::func_3C9F("flag_dlg_klaus_reached_pnt_4");
  lib_0378::func_8D74("aud_revived_klaus_speak", level.var_5A89, 6);
}

func_5A9D() {
  level.var_5A89 endon("death");
  level endon("flag_klaus_reached_well");
  wait(180);
  level.var_5A89 notify("klaus_exploit_warp");
  level.var_5A89 method_855C();
  func_5A8D();
}

func_8FEE(param_00) {
  level.var_5A89 = lib_0568::func_5A97(param_00);
}

func_647E() {
  level.var_5A89 endon("death");
  level.var_5A89 endon("klaus_exploit_warp");
  var_00 = common_scripts\utility::func_46B5("klaus_revive_death_point", "targetname");
  level.var_5A89 lib_0568::func_5A90(var_00);
  common_scripts\utility::func_3C8F("flag_klaus_reached_well");
  func_5A8D();
}

func_5A8D() {
  level.var_5A89 thread lib_0568::func_5A96();
  wait(0.6666667);
  lib_0378::func_8D74("aud_revived_klaus_speak", level.var_5A89, 7);
  thread func_35A7();
  wait(3.066667);
  thread maps\mp\mp_zombie_nest_ee_fire_well::func_7854();
  thread maps\mp\gametypes\zombies::func_08B2(level.var_5A89.var_0116, 1);
  wait(0.65);
  func_AA0A();
  wait(2);
  maps\mp\mp_zombie_nest_ee_fire_well::func_848D();
}

func_35A7() {
  wait(3.5);
  playFXOnTag(level.var_0611["zmb_klaus_fire_hide"], level.var_5A89, "TAG_ORIGIN");
}

func_8F93(param_00) {
  var_01 = spawn("script_model", param_00.var_0116);
  var_01 setModel("zom_klaus_wholebody");
  var_01 scriptmodelplayanim("s2_zom_kls_lay_idle", "klaus_revival");
}

func_74BE(param_00, param_01, param_02, param_03) {
  var_04 = "hilt_inspect_zm";
  if(param_02) {
    var_04 = "hilt_inspect_hc_zm";
  }

  common_scripts\utility::func_0603();
  common_scripts\utility::func_0600();
  wait 0.05;
  lib_0586::func_078C(var_04);
  self method_8323();
  self switchtoweapon(var_04);
  wait 0.05;
  wait(param_03);
  self switchtoweapon(lib_0547::func_AB2B());
  common_scripts\utility::func_0617();
  common_scripts\utility::func_0614();
  if(self hasweapon(var_04)) {
    lib_0586::func_0790(var_04);
  }

  maps\mp\_utility::func_3E8E(0);
  self allowmovement(1);
  self allowjump(1);
  self method_8113(1);
  self allowads(1);
  self method_812B(1);
  self method_8308(1);
  self method_812A(1);
  self method_8114(1);
  self method_85BF(1);
  self method_8309(1);
}

func_9308(param_00) {
  level thread func_38D9(param_00);
  level thread func_5CCA(param_00);
  level thread func_6CC3();
  level thread func_6C00();
  level waittill("brute battle complete");
  level thread common_scripts\_exploder::func_088E(238);
  lib_0378::func_8D74("brute_battle_complete_notification");
  wait 0.05;
  var_01 = getEntArray("nest_brute_uber_inserts", "targetname");
  foreach(var_03 in var_01) {
    var_03 delete();
  }
}

func_8FF5() {
  var_00 = common_scripts\utility::func_46B7(self.var_1CBD.var_01A2, "targetname");
  var_01 = [];
  foreach(var_03 in var_00) {
    var_04 = lib_054D::func_90BA("zombie_generic", var_03, "brute introduction", 1, 1, 1);
    var_01 = common_scripts\utility::func_0F6F(var_01, var_04);
  }

  wait 0.05;
  foreach(var_07 in var_01) {
    var_07 lib_0547::func_84CB();
    var_07 thread func_ABE1();
  }
}

func_ABE1() {
  self endon("death");
  self.var_4B9F = 1;
  var_00 = "board_taunt";
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_00, undefined, 1);
  if(isDefined(var_01)) {
    var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
    self method_839C("anim deltas");
    self scragentsetorientmode("face angle abs", self.var_001D);
    self scragentsetscripted(1);
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "taunt_anim");
    self scragentsetscripted(0);
  }
}

func_40E2() {
  return "flag_hilt_collected";
}

func_A68E() {
  while(!common_scripts\utility::func_562E(level.var_6654)) {
    wait(0.5);
  }
}

func_A696() {
  var_00 = common_scripts\utility::func_46B5("put_brute_out_of_misery", "targetname");
  while(distance(self.var_0116, var_00.var_0116) > var_00.var_014F) {
    wait(0.5);
  }
}

func_44C9(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in param_00) {
    foreach(var_06 in level.var_744A) {
      if(distance(var_04.var_0116, var_06.var_0116) < param_01) {
        var_02 = common_scripts\utility::func_0F6F(var_02, var_04);
      }
    }
  }

  return var_02;
}

func_7E33() {
  level.var_1CBF = undefined;
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8607();
  level.var_1CBA = 0;
}

func_3204() {
  self scriptmodelplayanim("s2_zom_brt_klaus_intro");
}

func_310A() {
  var_00 = "cam_note_notify";
  var_01 = [0.6615, 0.4461, 0.2153, 0.9846, 1];
  if(getdvarint("scr_bruteIntroSkip", 0) == 1) {
    return;
  }

  var_02 = % s2_zom_brt_cam_intro;
  var_03 = % s2_zom_brt_intro;
  var_04 = 0.25;
  wait(3 - var_04);
  setDvar("4712", 2);
  thread maps\mp\mp_zombie_nest_ee_util::func_9EC4();
  thread maps\mp\mp_zombie_nest_ee_util::func_3BE6();
  thread maps\mp\mp_zombie_nest_ee_util::func_3BEC();
  level.var_22F0 = 1;
  level thread maps\mp\mp_zombie_nest_straub_appearances::func_93F6();
  level thread common_scripts\_exploder::func_088E(221);
  func_7432(var_04, 1);
  var_05 = common_scripts\utility::func_46B5("final_boss_anim_intro_scripted_node", "targetname");
  level.var_7317 = spawn("script_model", (0, 0, 0));
  level.var_7317 setModel("player_generic_world_body");
  level.var_7317 method_8511();
  var_06 = spawn("script_model", (0, 0, 0));
  var_06 setModel("zom_brute_b_base");
  var_07 = spawn("script_model", (0, 0, 0));
  var_07 setModel("zom_klaus_wholebody");
  var_07 linkto(var_06, "tag_origin");
  var_08 = spawn("script_model", (0, 0, 0));
  var_08 setModel("zmb_rock_intro_02");
  foreach(var_0A in level.var_744A) {
    if(lib_0547::func_577E(var_0A)) {
      var_0A notify("revive_trigger");
    }

    if(var_0A getstance() != "stand") {
      var_0B = var_0A setstance("stand", 0);
      waittillframeend;
      var_0C = var_0A getstance();
      while(var_0C != "stand") {
        var_0C = var_0A getstance();
        wait 0.05;
      }
    }

    var_0A method_8114(0);
    var_0A method_8113(0);
    var_0A allowjump(0);
    var_0A allowmovement(0);
  }

  wait(0.5);
  foreach(var_0A in level.var_744A) {
    var_0A maps\mp\_utility::func_3E8E(1);
    var_0A.var_324E = 1;
    var_0A method_8483("mp_zombie_nest_01");
    var_0A setclientomnvar("ui_hide_hud", 1);
    var_0A method_848D();
    var_0A method_8003();
    var_0A method_8322();
    var_0A setorigin(level.var_7317 gettagorigin("tag_player"));
    var_0A setangles(level.var_7317 gettagangles("tag_player"));
    var_0A playerlinktoabsolute(level.var_7317, "tag_player");
    var_0A lib_0547::func_8A6D(1);
  }

  wait(var_04);
  lib_0378::func_8D74("brute_intro_begin");
  level.var_7317 method_8495("s2_zom_brt_cam_intro", var_05.var_0116, var_05.var_001D, var_00);
  var_06 method_8495("s2_zom_brt_intro", var_05.var_0116, var_05.var_001D);
  var_08 method_8495("s2_zom_brt_rock_intro", var_05.var_0116, var_05.var_001D);
  if(isDefined(level.var_179A)) {
    level.var_179A lib_0560::func_AB81();
  }

  level.var_7317 childthread func_20B6(var_02, var_00, var_01);
  var_07 func_3204();
  var_10 = getanimlength(var_03);
  wait 0.05;
  func_7432(var_04, 0);
  foreach(var_0A in level.var_744A) {
    var_0A method_84B4();
    var_0A method_84B7(3, 80, 20);
  }

  wait(15.8);
  foreach(var_0A in level.var_744A) {
    var_0A method_84B7(8, 140, 20);
  }

  wait(18.5);
  lib_0380::func_6842("zmb_nst01_mari_klauswhathavetheydonetoyo", level.var_744A, level.var_7317.var_0116);
  wait(13.7);
  foreach(var_0A in level.var_744A) {
    var_0A method_84B7(10, 4000, 20);
  }

  wait(7);
  foreach(var_0A in level.var_744A) {
    var_0A method_84B7(18, 64, 20);
  }

  wait(var_10 - 55 + var_04 + var_04);
  foreach(var_0A in level.var_744A) {
    var_0A method_84B5();
  }

  func_7432(var_04, 1);
  var_06 delete();
  var_07 delete();
  level.var_22F0 = 0;
  if(isDefined(level.var_179A)) {
    level.var_179A lib_0560::func_AB85();
  }

  level.var_7317 scriptmodelclearanim();
  level.var_7317.var_0116 = level.var_7317.var_0116 + (0, 0, 32);
  thread maps\mp\mp_zombie_nest_ee_util::func_1CC9();
  thread maps\mp\mp_zombie_nest_ee_util::func_1CCB();
  setDvar("4712", 1);
  level thread common_scripts\_exploder::func_2A6D(221, undefined, 0);
  foreach(var_0A in level.var_744A) {
    var_0A unlink();
    var_0A method_8004();
    var_0A method_848C();
    var_0A method_8323();
    var_0A maps\mp\_utility::func_3E8E(0);
    var_0A method_8114(1);
    var_0A method_8113(1);
    var_0A allowjump(1);
    var_0A allowmovement(1);
    var_0A lib_0547::func_8A6D(0);
    var_0A setclientomnvar("ui_hide_hud", 0);
    var_0A.var_324E = 0;
  }

  level.var_7317 delete();
  var_08 delete();
  lib_0378::func_8D74("brute_intro_end");
}

func_20B6(param_00, param_01, param_02) {
  var_03 = getnotetracks(param_00);
  var_04 = 1;
  foreach(var_06 in level.var_744A) {
    var_06 method_8036(param_02[0], 0);
  }

  for(var_08 = 0; var_08 < var_03.size; var_08++) {
    maps\mp\agents\_scripted_agent_anim_util::func_A79E(param_01, var_03[var_08]["name"]);
    switch (var_03[var_08]["name"]) {
      case "fov end":
        foreach(var_06 in level.var_744A) {
          var_06 thread func_9C7A(param_00, param_02[var_04], var_08, var_03);
        }

        var_04++;
        break;

      case "fov default":
        foreach(var_06 in level.var_744A) {
          var_06 method_8036(1, 0);
        }
        break;
    }
  }

  var_0D = "";
}

func_9C7A(param_00, param_01, param_02, param_03) {
  self notify("new_fov_trans");
  self endon("new_fov_trans");
  var_04 = getanimlength(param_00) * param_03[param_02 + 1]["time"] - param_03[param_02]["time"];
  var_04 = int(var_04 * 10) / 10;
  self method_8036(param_01, var_04);
}

func_310B(param_00) {
  var_01 = 1;
  foreach(var_03 in level.var_744A) {
    var_03 method_8322();
    var_03 method_8003();
    var_03 maps\mp\_utility::func_3E8E(1);
    var_03 lib_0547::func_8A6D(1);
    var_03 setclientomnvar("ui_hide_hud", 1);
    var_03.var_324E = 1;
  }

  func_7432(var_01, 1);
  param_00.var_5A9C delete();
  param_00 suicide();
  function_028D("mp/zombie_outro", 1);
  foreach(var_03 in level.var_744A) {
    var_03 setrankedplayerdata(common_scripts\utility::func_46A8(), "cinematicUnlocked", 0, 1);
  }

  func_7432(0.01, 0);
  wait(47);
  func_7432(0.01, 1);
  function_028F("mp/zombie_outro");
  foreach(var_03 in level.var_744A) {
    var_03 setclientomnvar("ui_hide_hud", 0);
  }
}

func_76A1() {
  var_00 = common_scripts\utility::func_46B7("zmb_blimp_pieces_struct", "targetname");
  foreach(var_02 in var_00) {
    var_02.var_57F7 = 0;
  }

  level.var_179A lib_0560::func_7D52(1);
  level.var_179A lib_0560::func_85FB(1);
}

func_6CC3() {
  var_00 = common_scripts\utility::func_46B7("zombie_spawner", "script_noteworthy");
  level.var_1CBF = [];
  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_81A1) && var_02.var_81A1 == "zmb_brute_valid_spawner") {
      level.var_1CBF = common_scripts\utility::func_0F6F(level.var_1CBF, var_02);
    }
  }

  var_06 = common_scripts\utility::func_46B7("zmb_blimp_pieces_struct", "targetname");
  level.var_1CBC = [];
  foreach(var_02 in var_06) {
    if(var_02.var_819A == "zeppelin_part_drop_brute") {
      level.var_1CBC = common_scripts\utility::func_0F6F(level.var_1CBC, var_02);
    }
  }
}

func_5CCA(param_00) {
  level thread common_scripts\_exploder::func_088E(240);
  var_01 = getEntArray("brute_final_barrier", "targetname");
  var_02 = getEntArray("brute_exit_traversal_mantle", "targetname");
  var_01 = common_scripts\utility::func_0F73(var_01, var_02);
  func_AA09();
  var_03 = getEntArray("brute_exit_trucks", "targetname");
  foreach(var_05 in var_03) {
    var_05 method_805C();
  }

  foreach(var_08 in var_01) {
    if(var_08.var_003A != "script_model") {
      var_08.var_0116 = var_08.var_0116 + (0, 0, 1024);
    } else {
      var_08 method_805B();
      var_09 = common_scripts\utility::func_46B5(var_08.var_01A2, "targetname");
      var_08.var_0116 = var_09.var_0116;
      if(isDefined(var_09.var_001D)) {
        var_08.var_001D = var_09.var_001D;
      }
    }

    var_0A = anglesToForward(var_08.var_001D);
    if(var_08.var_0106 == "zmb_brute_debris_02") {
      var_08.var_3BBC = spawnfx(common_scripts\utility::func_44F5("zmb_brute_debris_fire_01"), var_08.var_0116, var_0A);
      triggerfx(var_08.var_3BBC);
    }
  }

  wait 0.05;
  foreach(var_08 in var_01) {
    if(var_08.var_003A != "script_model") {
      wait 0.05;
      var_08 method_805F();
    }
  }

  var_0E = getent("brute_debris_floor_clip", "targetname");
  var_0E solid();
  var_0E method_8060();
  var_0F = getEntArray("brute_exit_blocker_village_gallows", "targetname");
  foreach(var_08 in var_0F) {
    var_08 notsolid();
    var_08 method_8060();
  }

  var_12 = getent("brute_exit_blocker_tower_path", "targetname");
  var_12 method_805C();
  var_0E notsolid();
}

func_AA0B() {
  var_00 = getEntArray("well_debris_brute", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 method_805C();
  }
}

func_AA09() {
  maps\mp\mp_zombie_nest_ee_fire_well::func_AA04();
  var_00 = getEntArray("well_debris_brute", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_03 = common_scripts\utility::func_46B5(var_02.var_01A2, "targetname");
    var_02.var_0116 = var_03.var_0116;
    if(isDefined(var_03.var_001D)) {
      var_02.var_001D = var_03.var_001D;
    }

    var_02 method_805B();
    if(var_02.var_0106 == "zmb_brute_debris_01") {
      var_04 = anglesToForward(var_00[0].var_001D);
      var_02.var_3BBC = spawnfx(common_scripts\utility::func_44F5("zmb_brute_debris_fire_02"), var_02.var_0116, var_04);
      triggerfx(var_02.var_3BBC);
    }
  }
}

func_AA0A() {
  var_00 = getEntArray("well_debris_brute", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.var_0116 = var_02.var_0116 + (0, 0, -128);
    if(isDefined(var_02.var_3BBC)) {
      var_02.var_3BBC delete();
    }

    var_02 delete();
  }

  maps\mp\mp_zombie_nest_ee_fire_well::func_AA08();
}

func_5F28() {
  var_00 = getEntArray("brute_final_barrier", "targetname");
  var_01 = getEntArray("brute_exit_traversal_mantle", "targetname");
  var_00 = common_scripts\utility::func_0F73(var_00, var_01);
  func_1CB7();
  var_02 = getEntArray("brute_exit_trucks", "targetname");
  foreach(var_04 in var_02) {
    var_04 method_805B();
  }

  foreach(var_07 in var_00) {
    if(var_07.var_003A != "script_model") {
      var_07 method_8060();
    }

    if(isDefined(var_07.var_3BBC)) {
      var_07.var_3BBC delete();
    }

    var_07 delete();
  }

  stopclientexploder(240, level.var_744A, 1);
  var_09 = getEntArray("brute_exit_blocker_village_gallows", "targetname");
  foreach(var_07 in var_09) {
    var_07 solid();
    if(var_07.var_003A != "script_model") {
      var_07 method_805F();
    }
  }

  var_0C = getent("brute_exit_blocker_tower_path", "targetname");
  var_0C method_805B();
}

func_1CB7() {
  var_00 = getent("brute_debris_floor_clip", "targetname");
  var_00 solid();
  var_00 method_8060();
}

func_83DF() {
  var_00 = common_scripts\utility::func_46B7("nest_ee_brute_boss_player_spawns", "targetname");
  level.var_1CBB = var_00;
  for(var_01 = 0; var_01 < level.var_744A.size; var_01++) {
    level.var_744A[var_01].var_763C = level.var_744A[var_01].var_0116;
    level.var_744A[var_01] setorigin(var_00[var_01].var_0116);
    level.var_744A[var_01] setangles(var_00[var_01].var_001D);
    level.var_744A[var_01] unlink();
    level.var_744A[var_01] method_8323();
    level.var_744A[var_01] freezecontrols(0);
    level.var_744A[var_01].var_AC5B = 0;
    level.var_744A[var_01] method_8004();
  }
}

func_83E0(param_00) {
  maps\mp\gametypes\zombies::func_7E57();
  var_01 = common_scripts\utility::func_46B7("klaus_player_pos", "targetname");
  for(var_02 = 0; var_02 < level.var_744A.size; var_02++) {
    level.var_744A[var_02] setorigin(var_01[var_02].var_0116);
    var_03 = param_00.var_0116 - level.var_744A[var_02] getEye();
    level.var_744A[var_02] setangles(vectortoangles(var_03));
    level.var_744A[var_02] allowmovement(0);
    level.var_744A[var_02] allowjump(0);
    level.var_744A[var_02] method_8113(0);
    level.var_744A[var_02] allowads(0);
    level.var_744A[var_02] method_812B(0);
    level.var_744A[var_02] method_8308(0);
    level.var_744A[var_02] method_812A(0);
    level.var_744A[var_02] method_8114(0);
    level.var_744A[var_02] method_85BF(0);
    level.var_744A[var_02] method_8309(0);
  }
}

func_7CD1(param_00) {
  level endon("game cinematic started");
  wait(param_00);
}

func_2D3A(param_00) {
  wait(param_00);
  self delete();
}

func_6C00() {
  lib_0547::func_A6F6();
  foreach(var_01 in level.var_AC1D) {
    if(isDefined(var_01.var_3280) && var_01.var_3280 == "closeable") {
      var_01 notify("close");
    } else {
      var_01 notify("open");
    }

    foreach(var_03 in var_01.var_9DC2) {
      var_03 common_scripts\utility::func_9D9F();
    }
  }

  level waittill("brute battle complete");
  foreach(var_01 in level.var_AC1D) {
    if(isDefined(var_01.var_3280) && var_01.var_3280 == "closeable") {
      var_01 notify("open");
    }

    foreach(var_03 in var_01.var_9DC2) {
      var_03 common_scripts\utility::func_9DA3();
    }
  }
}

func_94BF(param_00, param_01) {
  self endon(param_01);
  lib_0555::func_83DD("brute_stun");
  while(param_00 > 0) {
    param_00--;
    wait(1);
  }

  lib_0555::func_83DD("brute_awake");
  self notify(param_01, 0);
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