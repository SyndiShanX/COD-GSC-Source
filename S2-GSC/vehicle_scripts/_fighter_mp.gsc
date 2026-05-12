/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: vehicle_scripts\_fighter_mp.gsc
*********************************************/

func_00F9(param_00, param_01, param_02) {
  func_764D();
}

func_764D() {
  level.var_0611["p47_dmg_impact"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_impacts_lrg");
  level.var_0611["p47_dmg_impact_notrail"] = loadfx("vfx/vehicle/fighter_dmg_impact_notrail");
  level.var_0611["p47_dmg_light"] = loadfx("vfx/vehicle/p47_dmg_light");
  level.var_0611["p47_dmg_heavy"] = loadfx("vfx/vehicle/p47_dmg_heavy");
  level.var_0611["p47_contrail"] = loadfx("vfx/vehicle/p47_contrail");
  level.var_0611["p47_wing_evap"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_p47_wing_evap");
  level.var_0611["p47_exhaust"] = loadfx("vfx/vehicle/p47_exhaust");
  level.var_0611["bf109_wing_evap"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_wing_evap");
  level.var_0611["bf109_exhaust"] = loadfx("vfx/vehicle/p47_exhaust");
  level.var_0611["bf109_contrail_ext_vel"] = loadfx("vfx/vehicle/p47_contrail_ext_vel");
  if(getdvarint("fighter_firing_mode") == 1) {
    level.var_0611["p47_muzzle01"] = loadfx("vfx/vehicle/p47_muzzle01");
    level.var_0611["p47_muzzle02"] = loadfx("vfx/vehicle/p47_muzzle02");
  }

  level.var_0611["p47_death"] = loadfx("vfx/scorestreaks/ss_fighter_plane_death");
  level.var_0611["20mm_metal_impact_1"] = loadfx("vfx/weaponimpact/20mm_metal_impact_1");
  level.var_0611["p47_dmg_impact_ext_vel"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_spark_impact_rnr");
  level.var_0611["p47_contrail_ext_vel"] = loadfx("vfx/vehicle/p47_contrail_ext_vel");
  if(getdvarint("fighter_firing_mode") == 1) {
    level.var_0611["p47_muzzle01_ext_vel"] = loadfx("vfx/vehicle/p47_muzzle01_ext_vel");
    level.var_0611["p47_muzzle02_ext_vel"] = loadfx("vfx/vehicle/p47_muzzle02_ext_vel");
  }
}

fighterinitmg(param_00) {
  var_01 = 0;
  if(isDefined(self.var_81FD)) {
    var_01 = self.var_81FD;
  }

  self.var_615C = [];
  foreach(var_03 in param_00) {
    var_04 = self gettagangles(var_03.var_95A6);
    var_05 = self gettagorigin(var_03.var_95A6);
    var_06 = combineangles(var_04, (0, -1 * var_01, 0));
    var_07 = undefined;
    if(isDefined(var_03.var_6A1B)) {
      var_07 = var_05 + rotatevector(var_03.var_6A1B, var_04);
    } else {
      var_07 = var_05;
    }

    var_08 = spawnturret(var_03.var_231A, var_07, var_03.var_5135);
    var_08.var_01D1 = var_03.var_5135;
    var_08.var_001D = var_06;
    var_08 method_808C();
    if(isDefined(var_03.var_6A1B)) {
      var_08 linkto(self, var_03.var_95A6, var_03.var_6A1B, (0, -1 * var_01, 0));
    } else {
      var_08 linkto(self, var_03.var_95A6, (0, 0, 0), (0, -1 * var_01, 0));
    }

    var_08 setModel(var_03.var_0106);
    var_08.var_5847 = 1;
    var_08.var_6DB3 = self;
    var_08 makeusable();
    if(isDefined(var_03.var_00FC)) {
      var_08.var_00FC = var_03.var_00FC;
    }

    self.var_615C[self.var_615C.size] = var_08;
  }
}

buildfighterturret(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(level.var_A372)) {
    level.var_A372 = [];
  }

  var_05 = level.var_A635;
  var_06 = spawnStruct();
  var_06.var_231A = param_00;
  var_06.var_5135 = param_01;
  var_06.var_95A6 = param_02;
  var_06.var_0106 = param_03;
  if(isDefined(param_04) && param_04 == 1) {
    var_06.var_9B81 = 1;
  } else {
    var_06.var_9B81 = 0;
  }

  return var_06;
}

func_8A4D(param_00) {
  var_01 = [];
  var_02 = buildfighterturret("misc_turret", param_00, "TAG_TURRET_ATTACH_LEFT", "usa_fighter_thunderbolt_turret", 1);
  var_01[var_01.size] = var_02;
  var_02 = buildfighterturret("misc_turret", param_00, "TAG_TURRET_ATTACH_RIGHT", "usa_fighter_thunderbolt_turret", 1);
  var_01[var_01.size] = var_02;
  fighterinitmg(var_01);
}

destroyturrets() {
  foreach(var_01 in self.var_615C) {
    var_01 makeunusable();
    var_01 delete();
  }

  self.var_615C = undefined;
}

deathcleanup() {
  func_36B3();
  func_941A();
  if(0) {
    func_93FF();
  }
}

func_51FB(param_00) {
  func_8A4D(param_00);
  self.var_2A89 = "tag_trail_fx";
  self.var_9BDD = "tag_trail_fx";
  if(self method_8445("tag_trail_fx") < 0) {
    self.var_2A89 = "tag_origin";
  }

  if(self method_8445("tag_trail_fx") < 0) {
    self.var_9BDD = "tag_origin";
  }

  if(0) {
    thread func_721B();
  }

  thread func_3F3B();
  thread func_3F5D();
  thread fx_speed_handler();
  thread func_6DB8();
}

spawn_tag_origin_internal() {
  if(isDefined(level.var_5FEB)) {
    var_00 = spawn("script_model", level.var_5FEB);
  } else {
    var_00 = spawn("script_model", (0, 0, 0));
  }

  var_00 setModel("tag_origin");
  if(isDefined(self.var_0116)) {
    var_00.var_0116 = self.var_0116;
  }

  if(isDefined(self.var_001D)) {
    var_00.var_001D = self.var_001D;
  }

  return var_00;
}

func_6DB8() {
  self endon("death");
  var_00 = self method_8251();
  if(!isDefined(var_00)) {
    return;
  }

  if(!isDefined(self.var_29B1)) {
    self.var_29B1 = [];
    thread func_6DB7();
  }

  var_01 = 0;
  var_02 = common_scripts\utility::func_44F5("20mm_metal_impact_1");
  var_03 = -1;
  var_04 = 3;
  for(;;) {
    self waittill("damage", var_05, var_06, var_07, var_08, var_09);
    if(!isDefined(var_08)) {
      continue;
    }

    if(isDefined(var_06) && var_06 == self) {
      continue;
    }

    maps\mp\_audio_submixes::func_7FFA("raid_hit_air_dmg_plr", var_08, undefined, undefined, undefined, undefined, [var_00]);
    var_0A = level.var_744A;
    var_0A = common_scripts\utility::func_0F93(var_0A, var_00);
    if(var_0A.size > 0) {
      maps\mp\_audio_submixes::func_7FFA("raid_hit_air_dmg_npc", var_08, undefined, undefined, undefined, undefined, var_0A);
    }

    var_01 = 1;
    var_02 = common_scripts\utility::func_44F5("20mm_metal_impact_1");
    var_03 = 1.5;
    var_04 = 9;
    if(self.var_29B1.size < var_04) {
      var_0B = spawn_tag_origin_internal();
      var_0B.var_3F2F = var_02;
      var_0B.var_0116 = var_08;
      var_0B.var_001D = self gettagangles(self.var_9BDD);
      var_0B linkto(self, self.var_9BDD);
      self.var_29B1[self.var_29B1.size] = var_0B;
      playFXOnTag(var_0B.var_3F2F, var_0B, "tag_origin");
      if(var_03 > 0) {
        thread func_6DB9(var_03, var_0B);
      }
    }
  }
}

func_6DB7() {
  self waittill("death");
  if(isDefined(self.var_29B1)) {
    foreach(var_01 in self.var_29B1) {
      if(isDefined(var_01)) {
        stopFXOnTag(var_01.var_3F2F, var_01, "tag_origin");
        var_01 delete();
      }
    }

    self.var_29B1 = undefined;
  }
}

func_6DB9(param_00, param_01) {
  wait(param_00);
  if(isDefined(param_01) && isDefined(self) && isDefined(self.var_29B1)) {
    stopFXOnTag(param_01.var_3F2F, param_01, "tag_origin");
    self.var_29B1 = common_scripts\utility::func_0F93(self.var_29B1, param_01);
  }

  if(isDefined(param_01)) {
    param_01 delete();
  }
}

func_721B() {
  self endon("death");
  self endon("stop_engineeffects");
  common_scripts\utility::func_3799("engineeffects");
  common_scripts\utility::func_379A("engineeffects");
  var_00 = undefined;
  if(self.var_01C8 == "usa_fighter_thunderbolt_player_mp") {
    var_00 = common_scripts\utility::func_44F5("p47_exhaust");
  } else if(self.var_01C8 == "ger_fighter_bf109_player_mp") {
    var_00 = common_scripts\utility::func_44F5("bf109_exhaust");
  }

  if(isDefined(var_00)) {
    for(;;) {
      common_scripts\utility::func_379C("engineeffects");
      playFXOnTag(var_00, self, self.var_9BDD);
      common_scripts\utility::func_37A1("engineeffects");
      stopFXOnTag(var_00, self, self.var_9BDD);
    }
  }
}

func_93FF() {
  common_scripts\utility::func_3796("engineeffects");
}

func_720A() {
  var_00 = undefined;
  if(self.var_01C8 == "usa_fighter_thunderbolt_player_mp") {
    var_00 = common_scripts\utility::func_44F5("p47_contrail_ext_vel");
  } else if(self.var_01C8 == "ger_fighter_bf109_player_mp") {
    var_00 = common_scripts\utility::func_44F5("bf109_contrail_ext_vel");
  }

  if(isDefined(var_00)) {
    playFXOnTag(var_00, self, self.var_9BDD);
  }
}

func_93FB() {
  var_00 = undefined;
  if(self.var_01C8 == "usa_fighter_thunderbolt_player_mp") {
    var_00 = common_scripts\utility::func_44F5("p47_contrail_ext_vel");
  } else if(self.var_01C8 == "ger_fighter_bf109_player_mp") {
    var_00 = common_scripts\utility::func_44F5("bf109_contrail_ext_vel");
  }

  if(isDefined(var_00)) {
    stopFXOnTag(var_00, self, self.var_9BDD);
  }
}

func_36B3() {
  self notify("end_contrails");
  self endon("death");
  func_93FB();
}

func_74EE() {
  var_00 = undefined;
  if(self.var_01C8 == "usa_fighter_thunderbolt_player_mp") {
    var_00 = common_scripts\utility::func_44F5("p47_wing_evap");
  } else if(self.var_01C8 == "ger_fighter_bf109_player_mp") {
    var_00 = common_scripts\utility::func_44F5("bf109_wing_evap");
  }

  if(isDefined(var_00)) {
    playFXOnTag(var_00, self, self.var_9BDD);
  }
}

func_941A() {
  var_00 = undefined;
  if(self.var_01C8 == "usa_fighter_thunderbolt_player_mp") {
    var_00 = common_scripts\utility::func_44F5("p47_wing_evap");
  } else if(self.var_01C8 == "ger_fighter_bf109_player_mp") {
    var_00 = common_scripts\utility::func_44F5("bf109_wing_evap");
  }

  if(isDefined(var_00)) {
    stopFXOnTag(var_00, self, self.var_9BDD);
  }
}

func_36EF() {
  self notify("end_wing_evap");
  self endon("death");
  wait 0.05;
  func_941A();
}

func_3F3B() {
  level endon("death");
  self endon("end_contrails");
  self endon("death");
  var_00 = 0;
  var_01 = 15;
  var_02 = 25;
  while(isDefined(self)) {
    var_03 = self.var_001D;
    var_04 = var_03[0];
    var_05 = var_03[2];
    var_06 = 0;
    if((var_05 > var_01 && var_05 < 360 - var_01) || var_05 < -1 * var_01 && var_05 > -1 * 360 - var_01) {
      var_06 = 1;
    }

    if((var_04 > var_02 && var_04 < 360 - var_02) || var_04 < -1 * var_02 && var_04 > -1 * 360 - var_02) {
      var_06 = 1;
    }

    if(var_06 && !var_00) {
      func_720A();
      var_00 = 1;
      continue;
    }

    if(!var_06 && var_00) {
      func_93FB();
      var_00 = 0;
    }

    wait 0.05;
  }
}

fx_speed_handler() {
  level endon("death");
  self endon("death");
  var_00 = self method_8251();
  if(!isDefined(var_00)) {
    return;
  }

  if(isbot(var_00) || function_01EF(var_00)) {
    return;
  }

  var_01 = 0;
  while(isDefined(self)) {
    var_02 = var_00 getnormalizedmovement()[0];
    if(var_02 >= 0.5) {
      if(!var_01) {
        playfxontagforclients(level.var_0611["mp_raid_bomber_speedup"], self, self.var_9BDD, var_00);
        var_01 = 1;
      }

      continue;
    }

    if(var_01) {
      function_0294(level.var_0611["mp_raid_bomber_speedup"], self, self.var_9BDD, var_00);
      var_01 = 0;
    }

    wait 0.05;
  }
}

func_3F5D() {
  level endon("death");
  self endon("end_wing_evap");
  self endon("death");
  var_00 = 0;
  var_01 = 30;
  var_02 = 40;
  while(isDefined(self)) {
    var_03 = self.var_001D;
    var_04 = var_03[2];
    var_05 = 0;
    if((var_04 > var_01 && var_04 < 360 - var_01) || var_04 < -1 * var_01 && var_04 > -1 * 360 - var_01) {
      var_05 = 1;
    }

    if(var_05 && !var_00) {
      func_74EE();
      var_00 = 1;
      continue;
    }

    if(!var_05 && var_00) {
      func_941A();
      var_00 = 0;
    }

    wait 0.05;
  }
}

func_996C() {
  self endon("death");
  for(;;) {
    self waittill("veh_collision", var_00, var_01, var_02);
    if(!isDefined(var_02) || !isPlayer(var_02)) {
      if(isDefined(self.var_6703) && !self.var_6703) {
        self notify("veh_collision_except_player");
      }

      continue;
    }

    var_03 = 0;
  }
}