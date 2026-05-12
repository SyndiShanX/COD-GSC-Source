/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1376.gsc
*********************************************/

lib_0560::func_00D5() {
  lib_0560::func_52F0();
}

lib_0560::func_AB82() {
  self notify("set_new_zepplin_behavior", "zepplin_leave_village");
}

lib_0560::func_AB81() {
  self notify("set_new_zepplin_behavior", "zepplin_brt_cinematic");
}

lib_0560::func_AB85() {
  self notify("set_new_zepplin_behavior", "zepplin_brt_exit_cinematic");
}

lib_0560::func_AB84() {
  self notify("set_new_zepplin_behavior", "zepplin_return_village");
}

lib_0560::func_AB83() {
  self notify("set_new_zepplin_behavior", "zepplin_new_objective");
}

lib_0560::func_7F59(param_00) {
  level endon("zeppelin_destroyed");
  thread lib_0560::func_6F17(param_00);
  thread lib_0560::func_8641(0);
  if(!isDefined(self.var_0F1D)) {
    self.var_0F1D = 1;
  }

  if(common_scripts\utility::func_562E(param_00)) {
    thread lib_0560::func_7204(0, 0);
  }

  for(;;) {
    var_01 = lib_0560::func_A6AD();
    switch (var_01) {
      case "zepplin_brt_cinematic":
        lib_0560::func_85FD();
        break;

      case "zepplin_brt_exit_cinematic":
        lib_0560::func_85FE();
        break;

      case "zepplin_new_objective":
        thread lib_0560::func_7204(self.var_0F1D, 0);
        lib_0560::func_7D43();
        lib_0560::func_8408();
        common_scripts\utility::func_3C8F("sky_rush");
        break;

      case "zepplin_leave_village":
        thread lib_0560::func_7204(self.var_0F1D, 1);
        self.var_0F1D++;
        lib_0560::func_8409();
        lib_0560::func_85FF();
        break;

      case "zepplin_return_village":
        thread lib_0560::func_7204(self.var_0F1D, 0);
        lib_0560::func_8408();
        lib_0560::func_8600();
        break;
    }
  }
}

lib_0560::func_7D52(param_00) {
  if(common_scripts\utility::func_562E(param_00)) {
    level.var_6658 = 0;
  }

  lib_0560::func_53C9();
  common_scripts\utility::func_3C8F("sky_rush");
  lib_0560::func_1F46();
}

lib_0560::func_7D43() {
  self.var_4B8B = 0;
  lib_0560::func_AB80(3);
  self.var_5704 = 0;
  lib_0560::func_53C9();
}

lib_0560::func_6BFA(param_00) {
  var_01 = [];
  var_01["zom_zeppelin_panels_01_open"] = % zom_zeppelin_panels_01_open;
  var_01["zom_zeppelin_panels_01_open_idle"] = % zom_zeppelin_panels_01_open_idle;
  if(isDefined(param_00)) {
    var_02 = [param_00];
  } else {
    var_02 = self.var_AAF7;
  }

  foreach(var_04 in var_02) {
    var_04.var_65D8 scriptmodelclearanim();
  }

  foreach(var_04 in var_02) {
    var_04.var_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_open");
  }

  wait(getanimlength(var_01["zom_zeppelin_panels_01_open"]));
  foreach(var_04 in var_02) {
    var_04.var_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_open_idle");
  }
}

lib_0560::func_243F(param_00) {
  var_01 = [];
  var_01["zom_zeppelin_panels_01_close"] = % zom_zeppelin_panels_01_close;
  var_01["zom_zeppelin_panels_01_closed_idle"] = % zom_zeppelin_panels_01_closed_idle;
  if(isDefined(param_00)) {
    var_02 = [param_00];
  } else {
    var_02 = self.var_AAF7;
  }

  foreach(var_04 in var_02) {
    var_04.var_65D8 scriptmodelclearanim();
  }

  foreach(var_04 in var_02) {
    var_04.var_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_close");
  }

  wait(getanimlength(var_01["zom_zeppelin_panels_01_close"]));
  foreach(var_04 in var_02) {
    var_04.var_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_closed_idle");
  }
}

lib_0560::func_8409() {
  lib_0560::func_85FC(0);
  lib_0560::func_85FB(0);
}

lib_0560::func_8408() {
  lib_0560::func_7EB8();
  lib_0560::func_85FC(1);
  if(self.var_1F5D.var_5DDA < 3) {
    lib_0560::func_85FB(1);
  }
}

lib_0560::func_85FF() {
  if(!isDefined(level.var_179A.var_1F5D.var_5DDA)) {
    lib_0560::func_AB80(0);
  } else {
    lib_0560::func_AB80(self.var_1F5D.var_5DDA - 1);
  }

  self.var_5704 = 1;
}

lib_0560::func_85FD() {
  common_scripts\utility::func_3799("blimp_cinematic_done");
  self.var_571C = 1;
  var_00 = common_scripts\utility::func_46B5("final_boss_anim_intro_scripted_node", "targetname");
  level.var_179A lib_0560::func_71F6("s2_zom_brt_blimp_intro", var_00);
}

lib_0560::func_85FE() {
  level.var_179A common_scripts\utility::func_379A("blimp_cinematic_done");
}

lib_0560::func_5606() {
  return common_scripts\utility::func_562E(self.var_5704);
}

lib_0560::func_8600() {
  level thread maps\mp\mp_zombie_nest_ee_overcharge::func_86A7(self.var_6655);
  lib_0560::func_7D52();
  self.var_5704 = 0;
}

lib_0560::func_85FC(param_00) {
  self.var_1F8D = param_00;
}

lib_0560::func_85FB(param_00) {
  self.var_1F1F = param_00;
}

lib_0560::func_AB80(param_00) {
  self.var_1F5D.var_5DDA = param_00;
}

lib_0560::func_AB7F(param_00, param_01) {
  var_02 = getent("overcharge_trig", "targetname");
  var_03 = 0;
  if(isDefined(var_02)) {
    var_03 = var_02.var_17A9;
  }

  lib_0560::func_863A("s2_zmb_zeppelin_flight_exit_0" + param_00);
  if(common_scripts\utility::func_562E(level.var_1CBA)) {
    self waittill("cancel blimp wait");
    return;
  }

  if(!common_scripts\utility::func_562E(param_01)) {
    lib_0560::func_A649(level.var_A980, var_02, var_03);
  }
}

lib_0560::func_3002(param_00) {}

lib_0560::func_6F17(param_00) {
  level endon("zeppelin_destroyed");
  lib_0560::func_17AC();
  lib_0560::func_17A6();
  var_01 = 0;
  var_02 = 0;
  var_03 = 4;
  for(;;) {
    while(lib_0547::func_585E()) {
      wait 0.05;
    }

    var_01 = common_scripts\utility::func_98E7(var_01 + 1 > var_03, 1, var_01 + 1);
    var_02 = common_scripts\utility::func_98E7(var_01 + 1 > var_03, 1, var_01 + 1);
    if(common_scripts\utility::func_562E(self.var_571C)) {
      common_scripts\utility::func_379C("blimp_cinematic_done");
      common_scripts\utility::func_3796("blimp_cinematic_done");
      self.var_571C = 0;
    }

    lib_0560::func_863A("s2_zmb_zeppelin_flightpath_idle_circle_0" + var_01);
    if(param_00 || lib_0560::func_5606()) {
      lib_0560::func_83DA(var_02, param_00);
      if(common_scripts\utility::func_562E(param_00)) {
        param_00 = 0;
      }
    }
  }
}

lib_0560::func_83DA(param_00, param_01) {
  lib_0560::func_AB7F(param_00, param_01);
  if(!common_scripts\utility::func_562E(param_01) && self.var_1F5D.var_5DDA > 0) {
    lib_0560::func_AB84();
    lib_0560::func_863A("s2_zmb_zeppelin_flight_entrance_0" + param_00);
    var_02 = common_scripts\utility::func_7A33(level.var_744A);
    if(isDefined(var_02)) {
      var_02 thread lib_0367::func_8EA3("zepreturns");
      return;
    }

    return;
  }

  var_03 = "";
  while(var_03 != "zepplin_new_objective") {
    self waittill("set_new_zepplin_behavior", var_03);
  }

  lib_0560::func_863A("s2_zmb_zeppelin_flight_entrance_0" + param_00);
}

lib_0560::func_A6AD() {
  self waittill("set_new_zepplin_behavior", var_00);
  return var_00;
}

lib_0560::func_9009(param_00) {
  if(!isDefined(level.var_179A)) {
    return;
  }

  if(common_scripts\utility::func_562E(level.var_6657)) {
    return;
  } else {
    level.var_6657 = 1;
  }

  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  var_01 = common_scripts\utility::func_46B7("zmb_blimp_pieces_struct", "targetname");
  foreach(var_03 in var_01) {
    var_03.var_57F7 = 0;
  }

  level.var_179A lib_0560::func_8BFF();
  level.var_179A lib_0560::func_71FF();
  level.var_179A thread lib_0560::func_AAEE();
  level.var_179A thread lib_0560::func_7EB9();
  level.var_179A thread lib_0560::func_7F59(param_00);
  level.var_179A lib_0378::func_8D74("blimp_start");
}

lib_0560::func_52F0() {
  level.var_179A = getent("nest_ee_blimp", "targetname");
  level.var_179A lib_0560::func_89D3();
  common_scripts\utility::func_2CB4(5, ::lib_0560::func_516A);
}

lib_0560::func_89D3() {
  self.var_9255 = self.var_0116;
  self.var_9189 = self.var_001D;
  self method_805C();
  lib_0560::func_113A("blimp_door_damage_trigger");
  lib_0560::func_113E("nest_ee_blimp_attack_gun", "turretweapon_zeppelin_gun_zm");
  lib_0560::func_113D("blimp_attack_gun_battery");
  self.var_1F5D method_805C();
}

lib_0560::func_113A(param_00) {
  var_01 = getEntArray(param_00, "targetname");
  foreach(var_03 in var_01) {
    var_03.var_65D8 = getent(var_03.var_01A2, "targetname");
    var_04 = common_scripts\utility::func_46B5(var_03.var_65D8.var_01A2, "targetname");
    var_05 = spawn("script_model", var_04.var_0116);
    var_05 setModel("tag_origin");
    var_03.var_65D9 = var_05;
  }

  foreach(var_08 in var_01) {
    var_08 enablelinkto();
    var_08 method_8449(self);
    var_08.var_65D8 method_8449(self);
    var_08.var_65D9 method_8449(self);
    var_08.var_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_closed_idle");
  }

  self.var_AAF7 = var_01;
}

lib_0560::func_113E(param_00, param_01) {
  var_02 = common_scripts\utility::func_46B5(param_00, "targetname");
  self.var_6655 = var_02 lib_0560::func_1D62(param_01, var_02.var_0165, ::lib_0560::func_17B0, ::lib_0560::func_17B1);
  self.var_6655 method_8449(self);
  self.var_6655 method_805C();
}

lib_0560::func_113D(param_00) {
  self.var_1F5D = getent(param_00, "targetname");
  self.var_1F5D method_8449(self);
}

lib_0560::func_8641(param_00) {
  level.var_179A.var_1F8D = param_00;
}

lib_0560::func_53C9() {
  thread lib_0560::func_AAF5();
}

lib_0560::func_AAF5() {
  self notify("new_battery_primed");
  self endon("new_battery_primed");
  var_00 = undefined;
  foreach(var_02 in self.var_AAF7) {
    var_02 childthread lib_0560::func_95CA(self);
  }

  self waittill("blimp_weakpoint_destroyed", var_00, var_02);
  playFX(level.var_0611["zmb_zeppelin_battery_explosion"], var_02.var_0116);
  self.var_327A = undefined;
  if(!isDefined(level.var_6658)) {
    level.var_6658 = 1;
  } else {
    level.var_6658++;
  }

  maps\mp\mp_zombie_nest_ee_overcharge::func_86A6();
  if(level.var_179A.var_1F5D.var_5DDA > 1 || common_scripts\utility::func_562E(level.var_179A.var_4B8B)) {
    level.var_179A lib_0560::func_AB82();
  }

  lib_0560::func_9025(var_00);
}

lib_0560::func_95CA(param_00) {
  level endon("zeppelin_destroyed");
  param_00 endon("blimp_weakpoint_destroyed");
  if(maps\mp\mp_zombie_nest_ee_hc_true_voice::func_744B()) {
    self.var_A996 = 6500;
  } else {
    self.var_A996 = 4500;
  }

  self.var_A996 = self.var_A996 + 1000 * level.var_744A.size - 1;
  var_01 = 3375;
  var_02 = 2250;
  var_03 = 1125;
  var_04 = [var_01, var_02, var_03];
  self.var_4C13 = 0;
  for(var_05 = undefined; self.var_A996 > 0; var_05 = var_07) {
    self waittill("damage", var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F);
    if(common_scripts\utility::func_562E(self.var_565B)) {
      continue;
    }

    var_06 = maps\mp\mp_zombie_nest_ee_util::func_98ED(var_0F, var_06);
    self.var_A996 = self.var_A996 - var_06;
    if(self.var_A996 < 0) {
      self.var_A996 = 0;
    }

    var_10 = 0;
    while(self.var_4C13 < 2 && self.var_A996 < var_04[self.var_4C13]) {
      var_10 = 1;
      self.var_4C13++;
    }

    if(var_10) {
      lib_0560::func_2FF3();
    }

    if(randomint(100) < 30) {
      playFX(level.var_0611["zmb_zeppelin_battery_damage"], self.var_0116);
    }

    var_07 maps\mp\gametypes\_damagefeedback::func_A102("standard");
  }

  lib_0560::func_23D4();
  param_00 notify("blimp_weakpoint_destroyed", var_05, self);
}

lib_0560::func_1D62(param_00, param_01, param_02, param_03) {
  var_04 = spawnturret("misc_turret", self.var_0116, param_00);
  var_04.var_001D = self.var_001D;
  var_04 setModel(param_01);
  var_04 setdefaultdroppitchyaw(0);
  var_04 setmode("auto_nonai");
  var_04 method_80F9(undefined);
  var_04 method_80FB(0);
  var_04 method_8131();
  var_04 makeunusable();
  var_04 method_8130("axis");
  var_04 setentityowner(var_04);
  var_04 turretdontresetanglesonexitornotarget(1);
  if(isDefined(param_02)) {
    var_04.var_62AD = param_02;
  }

  if(isDefined(param_03)) {
    var_04.var_6B73 = param_03;
  }

  return var_04;
}

lib_0560::func_516A() {
  var_00 = common_scripts\utility::func_46B7("zmb_blimp_pieces_struct", "targetname");
  foreach(var_02 in var_00) {
    var_03 = common_scripts\utility::func_44BE(var_02.var_01A2, "targetname");
    foreach(var_05 in var_03) {
      switch (var_05.var_0165) {
        case "zmb_blimp_pieces_holder":
          var_02.var_4DEA = var_05;
          break;

        case "zmb_blimp_pieces_uber":
          var_02.var_9FE1 = var_05;
          break;

        case "zmb_blimp_pieces_rubble":
          var_02.var_7F40 = var_05;
          break;

        case "zmb_blimp_pieces_clip":
          var_02.var_241F = var_05;
          var_02.var_241F notsolid();
          var_02.var_241F method_8060();
          var_02.var_241F method_805C();
          break;
      }
    }
  }
}

lib_0560::func_A649(param_00, param_01, param_02) {
  level endon("zeppelin_destroyed");
  self endon("cancel blimp wait");
  if(isDefined(param_01)) {
    while(param_02 == param_01.var_17A9) {
      wait(0.1);
    }
  }

  while(level.var_A980 <= param_00) {
    wait(0.1);
  }

  if(!common_scripts\utility::func_562E(level.var_1CBA)) {
    common_scripts\utility::func_7A33(level.var_744A) lib_0378::func_8D74("dialogue_queue", "zmb_jeff_thezeppelinitsbackmaybeic");
  }
}

lib_0560::func_8BFF() {
  self method_805B();
  self.var_1F5D method_805B();
  level.var_179A.var_6655 method_805B();
}

lib_0560::func_17B2(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  if(isDefined(param_00) && isPlayer(param_00)) {
    var_01 = (0, 0, 0);
  } else {
    var_01 = (0, 0, 0);
  }

  level.var_179A.var_6655 setturrettargetentity(param_00, var_01, 1);
}

lib_0560::func_17AE() {
  return level.var_179A.var_6655 getturrettargetent();
}

lib_0560::func_17AD() {
  level.var_179A.var_6655 clearturrettargetentity();
}

lib_0560::func_5688(param_00) {
  var_01 = lib_0560::func_17AE();
  return isDefined(var_01) && var_01 == param_00;
}

lib_0560::func_17B3() {
  level.var_179A.var_6655 method_80D5();
  level.var_179A.var_6655 lib_0378::func_8D74("blimp_projectile");
}

lib_0560::func_17B4() {
  level.var_179A.var_6655 method_80D6();
}

lib_0560::func_17AF() {
  level.var_179A.var_6655 method_80D7();
}

lib_0560::func_17B0(param_00) {
  if(!isPlayer(self)) {
    return param_00;
  }

  param_00 = self.var_00FB * 0.95;
  return param_00;
}

lib_0560::func_17B1(param_00) {
  var_01 = self;
  var_02 = getweaponexplosionradius("turretweapon_zeppelin_gun_zm");
  var_03 = 1 - distance(param_00.var_0116, var_01.var_0116) / var_02;
  if(var_03 < 0) {
    var_03 = 0;
  }

  var_01 lib_0547::func_7419(param_00.var_0116, var_03 * var_02 + 100);
  lib_0560::func_2E76(param_00.var_0116);
  var_01 lib_0378::func_8D74("blimp_hit_plr");
}

lib_0560::func_29D3() {
  self endon("death");
  var_00 = self.var_00BC;
  for(;;) {
    self dodamage(var_00 / 3, (0, 0, 0));
    wait(0.5);
  }
}

lib_0560::func_9025(param_00) {
  if(level.var_179A.var_1F5D.var_5DDA == 1 && !common_scripts\utility::func_562E(level.var_179A.var_4B8B)) {
    var_01 = level.var_179A.var_6655 lib_0560::func_180A(param_00, 1);
    level.var_179A lib_0560::func_AB80(1);
    level.var_179A.var_4B8B = 1;
    level.var_179A lib_0560::func_8409();
    var_02 = 0;
    var_03 = undefined;
    while(!var_02) {
      foreach(var_05 in level.var_744A) {
        if(distance(var_01.var_0116, var_05.var_0116) < 512) {
          var_02 = 1;
          var_03 = var_05;
        }
      }

      wait(0.125);
    }

    var_03 lib_0367::func_8E3D("uberfly");
    var_01.var_78C5 = spawnlinkedfx(common_scripts\utility::func_44F5("temp_klaus_radius"), var_01, "tag_origin");
    triggerfx(var_01.var_78C5);
    var_01 rotateby((720, 720, 720), 8, 2);
    var_01 lib_0378::func_8D74("aud_battery_retract");
    var_07 = 1;
    while(var_07 < 5) {
      var_01 movez(32, 0.1);
      var_08 = launchbeam("zmb_electricity_reg_beam_med", var_01, "tag_origin", level.var_179A, "tag_origin");
      wait(0.1);
      var_08 delete();
      var_07 = var_07 + 0.1;
    }

    var_07 = 1;
    while(var_07 < 11) {
      var_09 = vectorlerp(var_01.var_0116, level.var_179A.var_0116, var_07 / 10);
      var_0A = distance(var_01.var_0116, var_09) / 125 + 25 * var_07;
      var_01 moveto(var_09, var_0A);
      var_08 = launchbeam("zmb_electricity_reg_beam_med", var_01, "tag_origin", level.var_179A, "tag_origin");
      wait(0.1);
      var_08 delete();
      var_07 = var_07 + 0.1;
    }

    var_01.var_9FE6 delete();
    var_01.var_78C5 delete();
    var_01 delete();
    level thread maps\mp\mp_zombie_nest_ee_overcharge::func_86A7(level.var_179A.var_6655);
    level.var_179A lib_0560::func_8408();
    level.var_179A lib_0560::func_53C9();
    return;
  } else {
    var_01 = level.var_179A.var_6655 lib_0560::func_180A(var_0A);
  }

  var_0B = "zombie_battery_death_" + self.var_01A5 + "_" + lib_0560::func_45C4();
  if(common_scripts\utility::func_562E(level.var_1CBA)) {
    maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8606();
  }

  if(lib_0560::func_8B88()) {
    level thread maps\mp\mp_zombie_nest_ee_overcharge::func_A788(var_0B, var_0A);
    if(1) {
      playFXOnTag(level.var_0611["zmb_geistkraft_radius_400"], var_0A, "TAG_ORIGIN");
    }

    var_0C = 20;
    thread lib_0560::func_8C16(var_0A);
    var_0A maps\mp\mp_zombie_nest_special_event_creator::func_170B(var_0C, 400, 100, var_0B, undefined, "tag_fx", "zmb_zep_receiver_charge_pnt", "tag_origin", undefined, var_0A.var_34A5.var_7F41, (0, 0, 48));
    level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("geistcraft_device_powered");
    if(1) {
      stopFXOnTag(level.var_0611["zmb_geistkraft_radius_400"], var_0A, "TAG_ORIGIN");
    }
  }

  if(common_scripts\utility::func_562E(level.var_1CBA)) {
    maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8608();
    lib_0557::func_7822("8B final boss", &"ZOMBIE_NEST_HINT_STEP_BOSS_UBER_HIT");
  } else {
    maps\mp\mp_zombie_nest_ee_overcharge::func_86A3();
  }

  thread lib_0560::func_2EB4(var_0A.var_0116);
  lib_0585::func_8F7E(var_0A.var_0116, undefined, undefined, undefined, "Blimp Battery Hunt");
  var_0A.var_9FE6 delete();
  var_0A.var_34A5 lib_0560::func_8428();
  playFX(loadfx("vfx/explosion/zmb_zeppelin_battery_hide_explosion"), var_0A.var_0116);
  var_0A delete();
}

lib_0560::func_8C16(param_00) {
  var_01 = [7, 14, 20];
  var_02 = 0;
  var_03 = undefined;
  while(!isDefined(param_00.var_695B)) {
    wait 0.05;
  }

  for(;;) {
    while(isDefined(param_00) && isDefined(param_00.var_AC2C) && param_00.var_AC2C < var_01[var_02]) {
      level waittill(param_00.var_695B);
      waittillframeend;
    }

    if(var_02 == var_01.size - 1) {
      var_03 delete();
      break;
    }

    if(isDefined(var_03)) {
      var_03 delete();
      wait 0.05;
    }

    var_03 = spawnfx(level.var_0611["gk_raven_hc_ee_uber_stg_" + var_02 + 1], param_00.var_9FE6.var_0116, anglesToForward(param_00.var_9FE6.var_001D), anglestoup(param_00.var_9FE6.var_001D));
    triggerfx(var_03);
    var_02++;
  }
}

lib_0560::func_2EB4(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = common_scripts\utility::func_4461(param_00, level.var_744A);
  var_01 thread lib_0367::func_8E3C("zepuberunlocked");
}

lib_0560::func_8B88() {
  return 1;
}

lib_0560::func_45C4() {
  if(!isDefined(level.var_6658)) {
    level.var_6658 = 0;
  }

  return level.var_6658;
}

lib_0560::func_17AA(param_00, param_01, param_02, param_03) {
  maps\mp\mp_zombie_nest_ee_overcharge::func_8C89();
  param_03 = maps\mp\mp_zombie_nest_ee_util::func_98ED(param_01, param_03);
  if(randomint(100) < 30) {
    playFX(level.var_0611["zmb_zeppelin_battery_damage"], self.var_0116);
  }

  var_04 = param_03;
  return var_04;
}

lib_0560::func_17AB(param_00, param_01, param_02, param_03) {
  self notify("death", param_00, param_02, param_01);
  self.var_57B1 = 1;
  self method_805C();
}

lib_0560::func_17A7(param_00, param_01, param_02, param_03) {
  maps\mp\mp_zombie_nest_ee_overcharge::func_8C89();
  param_03 = maps\mp\mp_zombie_nest_ee_util::func_98ED(param_01, param_03);
  if(randomint(100) < 30) {
    playFX(level.var_0611["zmb_zeppelin_battery_damage"], self.var_0116);
  }

  var_04 = param_03;
  return var_04;
}

lib_0560::func_17A8(param_00, param_01, param_02, param_03) {
  self notify("death", param_00, param_02, param_01);
}

lib_0560::func_7EB9() {
  level endon("zeppelin_destroyed");
  var_00 = common_scripts\utility::func_46B5("blimp_rocket_barrage_struct", "targetname");
  var_01 = getEntArray(var_00.var_01A2, "targetname");
  var_02 = ["J_searchlight_A_LE_2", "J_searchlight_A_RI_2", "J_searchlight_B_LE_2", "J_searchlight_B_RI_2", "J_searchlight_C_LE_2", "J_searchlight_C_RI_2"];
  foreach(var_04 in var_01) {
    var_04 method_8449(self);
    var_04 thread lib_0560::func_4A52();
  }

  for(;;) {
    wait(5);
    while(lib_0547::func_585E()) {
      wait 0.05;
    }

    if(common_scripts\utility::func_562E(self.var_1F1F)) {
      foreach(var_04 in var_01) {
        if(common_scripts\utility::func_562E(var_04.var_57B1)) {
          continue;
        }

        var_07 = common_scripts\utility::func_7A33(level.var_744A);
        var_08 = getclosestpointonnavmesh(var_07.var_0116 + (randomint(512) - 256, randomint(512) - 256, 0), var_07);
        var_09 = var_04.var_0116 + var_04 lib_0560::func_4306();
        var_0A = bullettracepassed(var_09, var_08, 0, var_04);
        var_0B = bullettracepassed(var_08, var_09, 0, var_04);
        if(!var_0A || !var_0B || common_scripts\utility::func_562E(var_04.var_56EF)) {
          continue;
        }

        var_04 thread lib_0560::func_3BAE(var_07.var_0116);
        wait(0.25);
      }
    }
  }
}

lib_0560::func_4306() {
  if(!isDefined(self) || !isDefined(self.var_001D)) {
    return (0, 0, 0);
  }

  return 64 * vectornormalize(anglesToForward(self.var_001D)) + (0, 0, 16);
}

lib_0560::func_3BAE(param_00) {
  level endon("zeppelin_destroyed");
  self.var_56EF = 1;
  self scriptmodelclearanim();
  self scriptmodelplayanim("zmb_zeppelin_rocket_pod_open");
  wait(getanimlength(%zmb_zeppelin_rocket_pod_open));
  self scriptmodelplayanim("zmb_zeppelin_rocket_pod_open_idle");
  var_01 = spawn("script_model", self.var_0116 + lib_0560::func_4306());
  var_01 setModel("npc_usa_bazooka_rocket_base");
  playFXOnTag(level.var_0611["zmb_zep_rocket_smoketrail"], var_01, "tag_origin");
  var_01 thread lib_0560::func_3A12(param_00);
  wait(0.5);
  self scriptmodelplayanim("zmb_zeppelin_rocket_pod_close");
  wait(getanimlength(%zmb_zeppelin_rocket_pod_close));
  self scriptmodelplayanim("zmb_zeppelin_rocket_pod_close_idle");
  self.var_56EF = 0;
}

lib_0560::func_7EB8() {
  var_00 = common_scripts\utility::func_46B5("blimp_rocket_barrage_struct", "targetname");
  var_01 = getEntArray(var_00.var_01A2, "targetname");
  foreach(var_03 in var_01) {
    var_03 notify("damage", 100000);
    var_03.var_57B1 = 0;
    var_03 method_805B();
  }

  wait 0.05;
  foreach(var_03 in var_01) {
    var_03 thread lib_0560::func_4A52();
  }
}

lib_0560::func_4A52() {
  var_00 = 1000;
  self.var_00BC = var_00;
  self.var_93FD = 0;
  self setCanDamage(1);
  self.var_57B1 = 0;
  thread maps\mp\gametypes\_damage::func_8676(var_00, undefined, ::lib_0560::func_17AB, ::lib_0560::func_17AA);
}

lib_0560::func_3A12(param_00) {
  playsoundatpos(self.var_0116, "zmb_blimp_mortar_inc");
  var_01 = param_00 - self.var_0116;
  var_02 = sqrt(abs(var_01[2] * 2 / 800));
  var_03 = 1 / var_02;
  var_04 = var_01 * (var_03, var_03, 0);
  self gravitymove(var_04, var_02);
  thread lib_0560::func_7EE7();
  wait(var_02);
  self.var_0116 = param_00;
  playFX(loadfx("vfx/explosion/zmb_zep_rocket_impact"), param_00);
  self notify("zepplin detonate");
  playsoundatpos(param_00, "zmb_blimp_mortar_exp");
  earthquake(0.55, 0.6, param_00, 200);
  wait 0.05;
  var_05 = lib_0547::func_408F();
  var_06 = common_scripts\utility::func_0F73(var_05, level.var_744A);
  foreach(var_08 in var_06) {
    if(distance(param_00, var_08.var_0116) < 128) {
      if(isPlayer(var_08)) {
        var_08 setblurforplayer(3, 0.8);
      } else if(common_scripts\utility::func_562E(var_08.var_A87C)) {
        continue;
      } else {
        var_08.var_A87C = 1;
      }

      if(isPlayer(var_08)) {
        var_08 dodamage(15, param_00, self, self, "MOD_EXPLOSIVE");
        continue;
      }

      var_08 dodamage(15, param_00, self, self, "MOD_RIFLE_BULLET");
    }
  }

  self delete();
}

lib_0560::func_7EE7() {
  var_00 = self.var_0116;
  level endon("zeppelin_destroyed");
  self endon("zepplin detonate");
  for(;;) {
    wait 0.05;
    var_01 = vectortoangles(var_00 - self.var_0116);
    self.var_001D = var_01;
    var_00 = self.var_0116;
  }
}

lib_0560::func_2DC3() {
  level notify("zeppelin_destroyed");
  if(isDefined(level.var_179A)) {
    level.var_179A.var_6655 delete();
    level.var_179A.var_1F5D delete();
    foreach(var_01 in level.var_179A.var_AAF7) {
      var_01 delete();
      var_01.var_65D8 delete();
    }

    var_03 = common_scripts\utility::func_46B5("blimp_rocket_barrage_struct", "targetname");
    var_04 = getEntArray(var_03.var_01A2, "targetname");
    foreach(var_06 in var_04) {
      var_06 delete();
    }

    level.var_179A delete();
  }
}

lib_0560::func_AAEE() {
  level endon("zeppelin_destroyed");
  level.var_17A4 = ["zone1_1_start", "zone1_2_gallows", "zone1_4_bridge", "zone1_4_bridge_tower", "zone1_3_riverside", "zone1_5_rooftops"];
  level.var_17A5 = [];
  for(var_00 = 0; var_00 < level.var_17A4.size; var_00++) {
    var_01 = getEntArray(level.var_17A4[var_00], "targetname");
    level.var_17A5 = common_scripts\utility::func_0F73(level.var_17A5, var_01);
  }

  if(!isDefined(level.var_179A.var_982A)) {
    level.var_179A.var_982A = spawn("script_model", level.var_179A gettagorigin("J_searchlight_A_RI_2"));
    level.var_179A.var_982A setModel("tag_origin");
    level.var_179A.var_982A method_8449(level.var_179A);
  }

  for(;;) {
    wait(3);
    while(lib_0547::func_585E()) {
      wait 0.05;
    }

    if(common_scripts\utility::func_562E(level.var_179A.var_1F8D)) {
      var_02 = undefined;
      while(!isDefined(var_02) || !isalive(var_02)) {
        var_02 = common_scripts\utility::func_4461(self.var_0116, level.var_744A);
        var_03 = 0;
        if(!common_scripts\utility::func_562E(var_02.var_5378)) {
          for(var_00 = 0; var_00 < level.var_17A5.size; var_00++) {
            if(var_02 istouching(level.var_17A5[var_00])) {
              var_03 = 1;
            }
          }
        }

        if(!var_03) {
          var_02 = undefined;
        }

        wait(0.25);
      }

      lib_0560::func_17B2(var_02);
      var_04 = level.var_179A.var_6655 gettagorigin("TAG_PITCH");
      var_05 = spawn("script_model", var_04);
      var_05 setModel("Tag_Origin");
      var_05 method_8449(level.var_179A.var_6655);
      var_05 lib_0378::func_8D74("blimp_charge");
      var_06 = 0;
      while(isalive(var_02)) {
        var_07 = level.var_179A.var_6655 gettagorigin("TAG_AIM");
        var_08 = level.var_179A.var_6655 gettagangles("TAG_AIM");
        var_09 = anglesToForward(var_08);
        var_0A = vectornormalize(var_02.var_0116 - var_07);
        var_0B = vectordot(var_09, var_0A);
        level.var_8C4C = level.var_179A.var_6655 gettagorigin("TAG_AIM");
        var_0C = (var_02.var_001D[0], var_02.var_001D[1], var_02.var_001D[0]);
        var_0D = 128 + randomint(128) * vectornormalize(anglesToForward(var_0C));
        level.var_8C46 = var_02.var_0116 + var_0D;
        level.var_8C4B = spawnsighttrace(level.var_8C4C, level.var_8C4C, level.var_8C46, 0);
        var_0E = bulletTrace(level.var_179A.var_6655 gettagorigin("TAG_AIM"), level.var_8C46, 0, level.var_179A.var_6655);
        var_0F = abs(var_0E["position"][2] - var_02.var_0116[2]);
        if(var_0F > 64) {
          level.var_8C46 = var_02.var_0116;
          level.var_8C4B = spawnsighttrace(level.var_8C4C, level.var_8C4C, level.var_8C46, 0);
          if(level.var_8C4B >= 0.99 &var_0B >= 0.99) {
            break;
          }

          continue;
        }

        break;
        wait 0.05;
      }

      var_10 = maps\mp\mp_zombie_nest_ee_util::func_90A9(level.var_8C46 + (0, 0, -12));
      var_0E = bulletTrace(level.var_179A.var_6655 gettagorigin("TAG_AIM"), var_10.var_0116, 0, level.var_179A.var_6655);
      var_10.var_0116 = var_0E["position"];
      var_10.var_001D = vectortoangles(var_05.var_0116 - var_10.var_0116);
      lib_0560::func_17B2(var_10);
      var_11 = lib_0560::func_7E3A();
      playFXOnTag(common_scripts\utility::func_44F5("zmb_zeppelin_shot_charge"), level.var_179A.var_6655, "TAG_YAW");
      playFXOnTag(common_scripts\utility::func_44F5("zmb_zeppelin_shot_charge_barrel"), level.var_179A.var_6655, "TAG_AIM");
      var_12 = level.var_179A.var_6655 gettagorigin("TAG_LIGHT");
      var_13 = level.var_179A.var_6655 gettagangles("TAG_LIGHT");
      var_14 = spawn("script_model", var_12);
      var_14 setModel("tag_origin");
      var_14.var_001D = var_13;
      var_14 method_8449(level.var_179A.var_6655);
      playFXOnTag(level.var_0611["zmb_zeppelin_spotlight_assault"], var_14, "tag_origin");
      playFXOnTag(level.var_0611["zmb_zeppelin_shot"], var_10, "tag_origin");
      wait(1);
      stopFXOnTag(level.var_0611["zmb_zeppelin_spotlight_assault"], var_14, "tag_origin");
      lib_0560::func_17B3();
      var_15 = launchbeam("zmb_tesla_zep_beam", level.var_179A.var_6655, "tag_flash", var_10, "tag_origin");
      wait(1);
      lib_0560::func_17B4();
      lib_0560::func_17AD();
      var_14 delete();
      var_05 delete();
      wait(0.15);
      var_15 delete();
      var_10 delete();
      lib_0560::func_4CFC(var_11);
      continue;
    }

    wait(0.5);
  }
}

lib_0560::func_7E3A() {
  self notify("door_anim_change");
  self endon("door_anim_change");
  if(maps\mp\mp_zombie_nest_ee_hc_true_voice::func_744B()) {
    var_00 = common_scripts\utility::func_7A33(self.var_AAF7);
    lib_0560::func_6BFA(var_00);
    var_00.var_65D8 method_805B();
    var_00.var_565B = 0;
    var_00 thread lib_0560::func_2FF3();
    return var_00;
  }

  lib_0560::func_6BFA();
  foreach(var_02 in self.var_AAF7) {
    var_02.var_65D8 method_805B();
    var_02.var_565B = 0;
    var_02 thread lib_0560::func_2FF3();
  }
}

lib_0560::func_2FF3() {
  lib_0560::func_23D4();
  wait 0.05;
  if(!isDefined(self.var_4C13)) {
    self.var_4C13 = 0;
  }

  var_00 = "zmb_zeppelin_shot_charge_weak_spot" + self.var_4C13 + 1;
  var_01 = common_scripts\utility::func_44F5(var_00);
  self.var_3F44 = var_01;
  playFXOnTag(var_01, self.var_65D8, "tag_origin");
}

lib_0560::func_23D4() {
  var_00 = self.var_3F44;
  if(!isDefined(var_00)) {
    return;
  }

  stopFXOnTag(var_00, self.var_65D8, "tag_origin");
  self.var_3F44 = undefined;
}

lib_0560::func_4CFC(param_00) {
  self notify("door_anim_change");
  self endon("door_anim_change");
  foreach(var_02 in self.var_AAF7) {
    var_02.var_565B = 1;
    var_02 lib_0560::func_23D4();
  }

  lib_0560::func_243F(param_00);
}

lib_0560::func_2E76(param_00) {
  var_01 = common_scripts\utility::func_4461(param_00, level.var_744A, 400);
  if(isDefined(var_01) && !common_scripts\utility::func_562E(var_01.var_5096)) {
    var_01 thread lib_0560::func_2E96(6);
    var_01 thread lib_0560::func_2E8E(30);
    if(!common_scripts\utility::func_562E(level.var_6656)) {
      level.var_6656 = 1;
      var_01 thread lib_0367::func_8E3B("conv_zepreaction");
      return;
    }

    return;
  }

  if(isDefined(var_01) && level.var_744A.size > 1) {
    var_02 = common_scripts\utility::func_0F93(level.var_744A, var_01);
    var_01 = common_scripts\utility::func_4461(param_00, var_02);
    if(isDefined(var_01) && !common_scripts\utility::func_562E(var_01.var_5096)) {
      var_01 thread lib_0560::func_2E96(6);
      var_01 thread lib_0560::func_2E8E(30);
    }

    if(isDefined(var_01) && !common_scripts\utility::func_562E(level.var_6656)) {
      level.var_6656 = 1;
      var_01 thread lib_0367::func_8E3B("conv_zepreaction");
      return;
    }
  }
}

lib_0560::func_2E8E(param_00) {
  self.var_5096 = 1;
  wait(param_00);
  self.var_5096 = 0;
}

lib_0560::func_2E96(param_00) {
  wait(param_00);
  thread lib_0367::func_8E3C("shootzepguns");
}

lib_0560::func_17AC() {
  var_00 = common_scripts\utility::func_46B5("boss_zepplin_scripted_node", "targetname");
  self.var_7B8B = var_00;
  self.var_7B8B.var_001D = self.var_7B8B.var_001D - (0, 90, 0);
}

lib_0560::func_17A6() {
  level.var_179A.var_57A9 = 1;
  lib_0560::func_863A("s2_zmb_zeppelin_flightpath_main_entrance");
}

lib_0560::func_863A(param_00) {
  level.var_179A lib_0560::func_71F6(param_00);
}

lib_0560::func_71F6(param_00, param_01) {
  self scriptmodelclearanim();
  if(isDefined(param_01)) {
    self method_8495(param_00, param_01.var_0116, param_01.var_001D);
  } else {
    self method_8495(param_00, self.var_7B8B.var_0116, self.var_7B8B.var_001D);
  }

  lib_0560::func_A690(param_00);
}

lib_0560::func_A690(param_00) {
  var_01 = getanimlength(lib_0560::func_946F(param_00));
  wait(var_01);
}

lib_0560::func_946F(param_00) {
  var_01 = % s2_zmb_zeppelin_flightpath_main_entrance;
  switch (param_00) {
    case "s2_zmb_zeppelin_flightpath_main_entrance":
      var_01 = % s2_zmb_zeppelin_flightpath_main_entrance;
      break;

    case "s2_zmb_zeppelin_flight_entrance_01":
      var_01 = % s2_zmb_zeppelin_flight_entrance_01;
      break;

    case "s2_zmb_zeppelin_flight_entrance_02":
      var_01 = % s2_zmb_zeppelin_flight_entrance_02;
      break;

    case "s2_zmb_zeppelin_flight_entrance_03":
      var_01 = % s2_zmb_zeppelin_flight_entrance_03;
      break;

    case "s2_zmb_zeppelin_flight_entrance_04":
      var_01 = % s2_zmb_zeppelin_flight_entrance_04;
      break;

    case "s2_zmb_zeppelin_flight_exit_01":
      var_01 = % s2_zmb_zeppelin_flight_exit_01;
      break;

    case "s2_zmb_zeppelin_flight_exit_02":
      var_01 = % s2_zmb_zeppelin_flight_exit_02;
      break;

    case "s2_zmb_zeppelin_flight_exit_03":
      var_01 = % s2_zmb_zeppelin_flight_exit_03;
      break;

    case "s2_zmb_zeppelin_flight_exit_04":
      var_01 = % s2_zmb_zeppelin_flight_exit_04;
      break;

    case "s2_zmb_zeppelin_flightpath_idle_circle_01":
      var_01 = % s2_zmb_zeppelin_flightpath_idle_circle_01;
      break;

    case "s2_zmb_zeppelin_flightpath_idle_circle_02":
      var_01 = % s2_zmb_zeppelin_flightpath_idle_circle_02;
      break;

    case "s2_zmb_zeppelin_flightpath_idle_circle_03":
      var_01 = % s2_zmb_zeppelin_flightpath_idle_circle_03;
      break;

    case "s2_zmb_zeppelin_flightpath_idle_circle_04":
      var_01 = % s2_zmb_zeppelin_flightpath_idle_circle_04;
      break;
  }

  return var_01;
}

lib_0560::func_863B() {
  level.var_179A.var_22F1 = 1;
}

lib_0560::func_90B9(param_00, param_01) {
  wait(param_01 / 2);
  var_02 = getent("nest_ee_blimp_attack_gun", "targetname");
  var_02 method_8449(level.var_179A);
  var_03 = spawn("script_model", var_02.var_0116);
  var_03 setModel("tag_origin");
  playFXOnTag(common_scripts\utility::func_44F5("zmb_zeppelin_projectile"), var_03, "tag_origin");
  var_03 lib_0378::func_8D74("blimp_projectile");
  var_03 moveto(param_00.var_0116, param_01 / 2);
  wait(param_01 / 2);
  var_03 delete();
}

lib_0560::func_1F46() {
  level.var_179A notify("cancel blimp wait");
}

lib_0560::func_2E75(param_00) {
  if(!common_scripts\utility::func_562E(level.var_1CBA)) {
    param_00 thread lib_0367::func_8E3C("zepuberdrop");
  }
}

lib_0560::func_180A(param_00, param_01) {
  thread lib_0560::func_2E75(param_00);
  var_02 = spawn("script_model", self.var_0116);
  var_02 setModel("zmb_uberschnalle_battery_chunk_01");
  playFXOnTag(level.var_0611["zmb_zep_battery_fire_trail"], var_02, "tag_origin");
  var_02 lib_0378::func_8D74("blimp_turret_explode");
  var_03 = common_scripts\utility::func_46B7("zmb_blimp_pieces_struct", "targetname");
  var_04 = (0, 0, -800);
  var_05 = 4;
  if(isDefined(level.var_1CBF)) {
    var_06 = lib_0560::func_4469(self.var_0116, level.var_1CBC);
  } else {
    var_06 = lib_0560::func_4469(self.var_0116, var_04);
  }

  var_07 = var_06;
  var_08 = var_07.var_4DEA.var_0116 - self.var_0116;
  var_05 = sqrt(abs(var_08[2] * 2 / 800));
  var_09 = 1 / var_05;
  var_0A = var_08 * (var_09, var_09, 0);
  var_02 gravitymove(var_0A, var_05);
  if(isDefined(var_07.var_4DEA.var_001D)) {
    var_02 rotateto(var_07.var_4DEA.var_001D, var_05);
  }

  wait(var_05);
  if(!common_scripts\utility::func_562E(param_01)) {
    var_07 lib_0560::func_8427();
  }

  var_02.var_0116 = var_07.var_4DEA.var_0116;
  var_02.var_9FE6 = spawn("script_model", var_07.var_9FE1.var_0116);
  var_02.var_9FE6 setModel("zmb_gp_uber_01");
  if(isDefined(var_07.var_9FE1.var_001D)) {
    var_02.var_9FE6.var_001D = var_07.var_9FE1.var_001D;
  }

  var_02.var_9FE6 method_8449(var_02);
  if(isDefined(level.var_1CBF)) {
    var_02.var_0116 = var_02.var_0116 + (0, 0, 4);
  }

  playFX(level.var_0611["zmb_zep_battery_land_explosion"], var_07.var_4DEA.var_0116 + (0, 0, -20));
  lib_0378::func_8D74("blimp_battery_land", var_07.var_4DEA);
  if(!common_scripts\utility::func_562E(level.var_1CBA)) {
    thread maps\mp\mp_zombie_nest_ee_util::func_7213("zepuberhint", var_02.var_0116, 450, 512);
  }

  var_02.var_34A5 = var_07;
  return var_02;
}

lib_0560::func_4469(param_00, param_01) {
  for(;;) {
    if(param_01.size == 0) {
      return undefined;
    }

    var_02 = common_scripts\utility::func_4461(param_00, param_01);
    if(!isDefined(var_02.var_57F7) || !var_02.var_57F7) {
      return var_02;
    } else {
      param_01 = common_scripts\utility::func_0F93(param_01, var_02);
    }
  }
}

lib_0560::func_8427() {
  var_00 = spawn("script_model", self.var_7F40.var_0116);
  if(isDefined(self.var_7F40.var_001D)) {
    var_00.var_001D = self.var_7F40.var_001D;
  }

  var_00 setModel("zmb_uberschnalle_battery_rubble_01");
  self.var_7F41 = var_00;
  self.var_241F solid();
  self.var_241F method_805B();
  self.var_241F method_805F();
  var_01 = common_scripts\utility::func_0F73(level.var_744A, lib_0547::func_408F());
  foreach(var_06, var_03 in var_01) {
    if(function_01EF(var_03)) {
      if(var_03.var_0A4B == "zombie_boss_village") {
        continue;
      }
    }

    if(var_03 istouching(self.var_241F)) {
      if(isPlayer(var_03)) {
        var_04 = self.var_0116;
        if(canspawn(var_04)) {
          var_03 setorigin(var_04);
        } else {
          var_05 = getclosestpointonnavmesh(var_04);
          if(canspawn(var_05)) {
            var_03 setorigin(var_05);
          } else {
            maps\mp\_movers::func_A047(var_03, 0);
          }
        }

        var_06 dodamage(var_06.var_00BC + 666, self.var_7F40.var_0116, undefined, undefined, "MOD_CRUSH");
        continue;
      }

      var_04 dodamage(var_04.var_00BC + 666, self.var_7F40.var_0116, undefined, undefined, "MOD_EXPLOSIVE");
    }
  }

  self.var_57F7 = 1;
  thread blimp_clip_exploit_listener();
}

lib_0560::func_8428() {
  if(isDefined(self.var_7F41)) {
    self.var_7F41 delete();
  }

  self.var_241F method_8060();
  self.var_241F notsolid();
  self.var_241F method_805C();
  self.var_57F7 = 0;
  self notify("stop_exploit_listener");
}

blimp_clip_exploit_listener() {
  self endon("stop_exploit_listener");
  if(!isDefined(self.var_241F)) {
    return;
  }

  for(;;) {
    foreach(var_01 in level.var_744A) {
      var_02 = var_01 method_8551();
      if(isDefined(var_02) && var_02 == self.var_241F) {
        var_03 = self.var_0116;
        if(canspawn(var_03)) {
          var_01 setorigin(var_03);
        } else {
          var_04 = getclosestpointonnavmesh(var_03);
          if(canspawn(var_04)) {
            var_01 setorigin(var_04);
          } else {
            maps\mp\_movers::func_A047(var_01, 0);
          }
        }

        var_02 dodamage(var_02.var_00BC + 666, self.var_7F40.var_0116, undefined, undefined, "MOD_CRUSH");
      }
    }

    wait(0.5);
  }
}

lib_0560::func_71FF() {
  if(common_scripts\utility::func_562E(self.var_3F78)) {
    return;
  }

  self.var_3F78 = 1;
  self scriptmodelplayanim("s2_zmb_zeppelin_idle");
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_zeppelin_gun_light"), level.var_179A.var_6655, "TAG_YAW");
  triggerfx(var_00);
  thread deletefxondeath(var_00);
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_zeppelin_underlight"), self, "TAG_ORIGIN");
  triggerfx(var_00);
  thread deletefxondeath(var_00);
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_zeppelin_spotlight_nolight"), self, "J_searchlight_A_LE_2");
  triggerfx(var_00);
  thread deletefxondeath(var_00);
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_zeppelin_spotlight"), self, "J_searchlight_B_LE_2");
  triggerfx(var_00);
  thread deletefxondeath(var_00);
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_zeppelin_spotlight_nolight"), self, "J_searchlight_C_LE_2");
  triggerfx(var_00);
  thread deletefxondeath(var_00);
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_zeppelin_spotlight_nolight"), self, "J_searchlight_A_RI_2");
  triggerfx(var_00);
  thread deletefxondeath(var_00);
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_zeppelin_spotlight"), self, "J_searchlight_B_RI_2");
  triggerfx(var_00);
  thread deletefxondeath(var_00);
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_zeppelin_spotlight_nolight"), self, "J_searchlight_C_RI_2");
  triggerfx(var_00);
  thread deletefxondeath(var_00);
}

deletefxondeath(param_00) {
  param_00 endon("death");
  self waittill("death");
  param_00 delete();
}

lib_0560::func_7204(param_00, param_01) {
  var_02 = undefined;
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_03 = 10;
  switch (param_00) {
    case 0:
      if(common_scripts\utility::func_562E(param_01)) {
        var_02 = undefined;
      } else {
        var_02 = "zmb_nst01_rich_youfoolshavenoideawhatyou";
      }
      break;

    case 1:
      if(common_scripts\utility::func_562E(param_01)) {
        var_02 = "zmb_nst01_rich_thisisjustaprototypestayp";
        var_03 = 3;
      } else {
        var_02 = "zmb_nst01_rich_weveunlockedthepowersofgo";
      }
      break;

    case 2:
      if(common_scripts\utility::func_562E(param_01)) {
        var_02 = "zmb_nst01_rich_imnotdonewithyouyetplaywi";
        var_03 = 3;
      } else {
        var_02 = "zmb_nst01_rich_burnbeneaththerighteousfu";
        var_03 = 15;
      }
      break;

    case 3:
      if(common_scripts\utility::func_562E(param_01)) {
        var_02 = "zmb_nst01_rich_illseeyouallinhelldamnyou";
        var_03 = 3;
      } else {
        var_02 = "zmb_nst01_rich_yourarrivalwaspoorlytimed";
      }
      break;

    default:
      var_02 = undefined;
      break;
  }

  if(isDefined(var_02)) {
    wait(var_03);
    thread blimpvospeaking();
    lib_0378::func_8D74("play_blimp_dialog", var_02, level.var_179A);
  }
}

blimpvospeaking() {
  level.blimpvoplaying = 1;
  wait(10);
  level.blimpvoplaying = 0;
}