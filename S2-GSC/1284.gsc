/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1284.gsc
*********************************************/

func_5341() {
  var_00 = lib_0502::func_2548("raid_escort_vehicle_gate", ::func_7943);
  var_01 = var_00 lib_0502::func_2548("model", ::func_7944);
  var_01 lib_0502::func_2548("close_pos", ::lib_0502::func_2081);
  var_01 lib_0502::func_2548("open_pos", ::lib_0502::func_2080);
  var_02 = var_00 lib_0502::func_2548("trigger", ::func_7946);
  var_03 = lib_0502::func_2548("raid_escort_vehicle_wall", ::func_795F);
  var_04 = var_03 lib_0502::func_2548("explosive_trigger", ::lib_04F7::func_7968);
  var_04 lib_0502::func_2548("explosive_model", ::lib_04F7::func_7964);
  var_04 lib_0502::func_2548("explosive_model_cant_use", ::lib_04F7::func_7965);
  var_04 lib_0502::func_2548("delete_on_trigger", ::lib_0502::func_207A);
  var_04 lib_0502::func_2548("physics_launch_on_trigger", ::lib_0502::func_2087);
  var_04 lib_0502::func_2548("show_on_trigger", ::lib_0502::func_2088);
  var_04 lib_0502::func_2548("fx_on_trigger", ::lib_0502::func_207B);
  var_03 lib_0502::func_2548("cant_use_trigger", ::lib_04F7::func_7962);
  var_05 = lib_0502::func_2548("raid_bridge", ::func_792B);
  var_05 lib_0502::func_2548("engineer_crate", ::func_79C5);
  var_05 lib_0502::func_2548("destroyed", ::func_7932);
  var_05 lib_0502::func_2548("build", ::func_7933);
  var_05 lib_0502::func_2548("remove", ::func_7934);
  var_02 = var_05 lib_0502::func_2548("cant_build_trigger", ::func_7931);
  var_06 = lib_0502::func_2548("raid_hedgehog", ::func_797D);
  var_06 lib_0502::func_2548("trigger", ::func_7990);
  var_06 lib_0502::func_2548("model", ::func_798C);
  var_06 lib_0502::func_2548("ghost_model", ::func_798A);
  var_06 lib_0502::func_2548("explosive_model", ::func_7988);
  var_06 lib_0502::func_2548("collision", ::func_7980);
  var_06 lib_0502::func_2548("animated_model", ::func_797E);
  var_07 = lib_0502::func_2548("raid_blocker_vehicle", ::func_7928);
  var_08 = var_07 lib_0502::func_2548("repair_trigger", ::func_7927);
  var_09 = var_08 lib_0502::func_2548("part_pick_up_trigger", ::func_79F5);
  var_0A = var_08 lib_0502::func_2548("missing_part_model");
  var_0B = lib_0502::func_2548("move_gravity_on_trigger", ::lib_0502::func_2085);
  var_0C = lib_0502::func_2548("move_on_trigger", ::lib_0502::func_2086);
  var_0D = lib_0502::func_2548("fx_on_trigger", ::lib_0502::func_207B);
  var_0E = lib_0502::func_2548("delete_on_trigger", ::lib_0502::func_207A);
  var_0F = lib_0502::func_2548("link_to_on_trigger", ::lib_0502::func_2083);
  var_10 = lib_0502::func_2548("sound_on_trigger", ::lib_0502::func_2089);
}

raiddrivablevehiclespawn(param_00, param_01) {
  waittillframeend;
  var_02 = lib_0503::func_2838(param_00, param_01, 1, 0, 0);
  var_02.var_1A2 = param_00.var_1A2;
  var_02 setCanDamage(1);
  var_02.var_BC = 2000;
  var_02.var_FB = 2000;
  var_02 method_867B(1);
  var_02 thread lib_0502::func_2FC4();
  var_02.isdrivable = 1;
  lib_0502::func_9FF(var_02);
  thread func_7954(var_02);
  func_794B(var_02, undefined, undefined, undefined, param_01);
  var_02.var_835F notify("end_watchForSecondPlayerUsage");
  var_02.var_9EDD thread lib_0503::last_stand_player_down_slide();
  var_02.secondplayerturret_prev = var_02.var_835F;
  var_02.var_835F = var_02.var_9EDD;
  var_02 thread vehiclesetusablebyteam(param_01);
  return var_02;
}

func_795B(param_00) {
  waittillframeend;
  var_01 = lib_0503::func_2838(param_00, game["attackers"], 1, 0, 0);
  var_01.var_1A2 = param_00.var_1A2;
  var_01 makeunusable();
  var_01 setCanDamage(1);
  var_01.var_29B5 = ::func_7941;
  var_01.var_BC = 2000;
  var_01.var_FB = 2000;
  var_01.var_A3EF = 1;
  var_01 method_867B(1);
  var_01 thread lib_0502::func_2FC4();
  var_01 thread func_7947();
  func_7949(var_01);
  var_01 startpath(var_01.var_92ED);
  thread func_7954(var_01);
  var_01.var_384F = 4;
  var_01.var_3835 = 5;
  var_01.var_3837 = 5;
  var_01.var_931A = "";
  var_01.var_17D9 = 0;
  var_01.var_17DC = 0;
  var_01.var_664C = 0;
  var_01.var_6EA0 = 0;
  var_01.var_A045 = ::func_A3FE;
  func_794B(var_01);
  func_795C(var_01);
  if(isDefined(var_01.var_9EDD) && var_01 method_8221()) {
    var_01 thread func_795E();
  }

  self.var_A2C8 = var_01;
}

func_7947() {
  var_00 = 4000000;
  var_01 = 0.85;
  for(;;) {
    var_02 = self.var_BC - self.var_6A;
    var_03 = var_02 / self.var_BC;
    foreach(var_05 in level.var_744A) {
      if(!maps\mp\_utility::func_57A0(var_05) || common_scripts\utility::func_562E(self.var_664C)) {
        var_05 func_73D1();
        continue;
      }

      var_06 = distancesquared(var_05.var_116, self.var_116);
      var_07 = 0;
      if(var_06 < var_00) {
        var_08 = anglesToForward(var_05 getangles());
        var_09 = vectornormalize(self.var_116 - var_05 getvieworigin());
        var_0A = vectordot(var_08, var_09);
        if(var_0A >= var_01) {
          var_07 = 1;
        }
      }

      if(var_07 && bullettracepassed(var_05 getvieworigin(), self.var_116 + (0, 0, 30), 0, self)) {
        if(!isDefined(var_05.var_97BC)) {
          var_05.var_97BC = var_05 maps\mp\gametypes\_hud_util::func_27CF((1, 1, 1), 200, 10);
          var_05.var_97BC maps\mp\gametypes\_hud_util::func_8707("CENTER", undefined, 0, -200);
        }

        var_0B = 1;
        if(var_03 > 0.5) {
          var_0B = 1 - 2 * var_03 - 0.5;
        }

        var_0C = 1;
        if(var_03 < 0.5) {
          var_0C = var_03 / 0.5;
        }

        var_0D = 0;
        var_05.var_97BC maps\mp\gametypes\_hud_util::func_A0E3(var_03);
        var_05.var_97BC.var_1586.var_56 = (var_0B, var_0C, var_0D);
        continue;
      }

      var_05 func_73D1();
    }

    wait 0.05;
  }
}

func_73D1() {
  if(isDefined(self.var_97BC)) {
    if(isDefined(self.var_97BC.var_1586)) {
      self.var_97BC.var_1586 destroy();
    }

    self.var_97BC destroy();
  }
}

func_7941(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(!isDefined(param_01) || param_01.var_3A == "worldspawn" || !isPlayer(param_01)) {
    return;
  }

  if(!isexplosivedamagemod(param_04)) {
    return;
  }

  if(isDefined(param_01.var_1A7)) {
    if(self.var_1A7 == param_01.var_1A7) {
      return;
    }
  } else if(isDefined(param_01.var_117) && isDefined(param_01.var_117.var_1A7)) {
    if(self.var_1A7 == param_01.var_117.var_1A7) {
      return;
    }
  }

  var_0C = param_02;
  if(isDefined(param_05)) {
    var_0D = param_05;
    if(function_030D(param_05)) {
      var_0D = maps\mp\_utility::func_452B(param_05);
    }

    if(maps\mp\_utility::func_5856(var_0D)) {
      var_0D = maps\mp\gametypes\_class::func_4432(var_0D);
    }

    switch (var_0D) {
      case "panzerschreck_mp":
      case "bazooka_mp":
      case "bouncingbetty_mp":
      case "c4_mp":
        var_0C = self.var_BC * 0.25;
        break;
    }
  }

  param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard");
  self.var_6A = self.var_6A + var_0C;
  if(self.var_6A >= self.var_FB) {
    self setCanDamage(0);
    self notify("break_down");
  }
}

func_7954(param_00) {
  param_00 endon("death");
  level endon("game_ended");
  for(;;) {
    var_01 = [];
    var_02 = [];
    foreach(var_04 in level.var_744A) {
      if(var_04.var_1A7 == param_00.var_1A7) {
        var_01[var_01.size] = var_04;
        continue;
      }

      var_02[var_02.size] = var_04;
    }

    if(var_01.size > 0) {
      param_00 hudoutlineenableforclients(var_01, 2, 1);
    }

    if(var_02.size > 0) {
      param_00 hudoutlineenableforclients(var_02, 1, 1);
    }

    level waittill("joined_team");
  }
}

func_A3FE(param_00) {
  if(param_00 playerisweaponplantenabled()) {
    param_00 common_scripts\_plant_weapon::forcedismountweapon();
    return;
  }

  if(common_scripts\utility::func_562E(param_00.var_5A4C)) {
    param_00 maps\mp\_utility::func_728();
    return;
  }

  if(!isDefined(self.var_9EDD) || !param_00 isusingturret() || !isDefined(param_00 method_85E3()) || param_00 method_85E3() != self.var_9EDD) {
    maps\mp\_movers::func_A047(param_00);
    return;
  }
}

func_794B(param_00, param_01, param_02, param_03, param_04) {
  param_01 = undefined;
  param_02 = undefined;
  param_03 = undefined;
  if(!isDefined(param_04)) {
    param_04 = game["attackers"];
  }

  switch (param_00.var_1C8) {
    case "ger_tank_king_tiger_mp":
      param_01 = "TAG_TURRET_4";
      param_02 = "npc_ger_mg42_tigerii_bucket_mp";
      param_03 = "turretweapon_mg42_bucket_mp";
      break;

    case "ger_tank_panzer_4_player_mp":
      param_01 = "TAG_TURRET_4";
      param_02 = "npc_ger_mg42_tigerii_bucket_mp";
      param_03 = "turretweapon_mg42_bucket_mp";
      break;

    case "ger_tank_king_tiger_mp_snow":
      param_01 = "TAG_TURRET_4";
      param_02 = "npc_ger_mg42_tigerii_bucket_mp_snow";
      param_03 = "turretweapon_mg42_bucket_mp";
      break;

    default:
      param_01 = "TAG_TURRET_ATTACH2";
      param_02 = "usa_tank_sherman_m1919_bucket_turret_mp";
      param_03 = "turretweapon_usa_m1919_tank_sherman_bucket_mp";
      break;
  }

  param_00.var_1A7 = param_04;
  param_00.var_9EDD = param_00 lib_0503::func_1D62(param_03, param_02, param_01, 1);
  param_00.var_9EDD thread maps\mp\_load::func_A8E7();
  if(!isDefined(self.var_6967) || lib_04FF::func_45D0("escort_turretActive")) {
    param_00.var_9EDD thread func_9F9B(param_04);
  }
}

vehiclesetusablebyteam(param_00) {
  thread turretorvehiclesetusablebyteam(param_00);
}

func_9F9B(param_00) {
  thread turretorvehiclesetusablebyteam(param_00);
}

turretorvehiclesetusablebyteam(param_00) {
  self endon("death");
  foreach(var_02 in level.var_744A) {
    thread vehicleorturretsetplayerteamusability(var_02, param_00);
    var_02 thread playersetvehicleorturretteamusabilityonspawn(self, param_00);
  }

  for(;;) {
    level waittill("connected", var_02);
    var_02 thread playersetvehicleorturretteamusabilityonspawn(self, param_00);
  }
}

playersetvehicleorturretteamusabilityonspawn(param_00, param_01) {
  self endon("disconnect");
  param_00 endon("death");
  for(;;) {
    self waittill("spawned_player");
    param_00 thread vehicleorturretsetplayerteamusability(self, param_01);
  }
}

vehicleorturretsetplayerteamusability(param_00, param_01) {
  param_00 endon("disconnect");
  param_00 endon("death");
  self endon("death");
  var_02 = 4;
  if(isDefined(param_01) && param_01 != param_00.var_1A7) {
    self disableplayeruse(param_00);
    return;
  }

  for(;;) {
    self enableplayeruse(param_00);
    if(func_5812(self)) {
      func_A78D(param_00, self);
      param_00.hideshieldmodels = 1;
      param_00 notify("weapon_change", self.maxhealth);
      waittillframeend;
      self waittill("turretownerchange");
      param_00.hideshieldmodels = 0;
      param_00 notify("weapon_change", param_00 getcurrentweapon());
    } else if(lib_0502::func_5845(self)) {
      waittillplayerusestank(param_00, self);
      waittillframeend;
    } else {
      func_A78C(param_00, self);
      self.var_9EDD waittill("turretownerchange");
      waittillframeend;
      self.var_9EDD waittill("turretownerchange");
      var_03 = 0;
    }

    self disableplayeruse(param_00);
    maps\mp\gametypes\_hostmigration::func_A6F5(var_02);
  }
}

func_5812(param_00) {
  return isDefined(param_00.var_3A) && issubstr(param_00.var_3A, "misc_turret");
}

func_A78D(param_00, param_01) {
  for(;;) {
    param_00 waittill("turretownerchange", var_02);
    if(param_01 == var_02) {
      break;
    }
  }
}

waittillplayerusestank(param_00, param_01) {
  for(;;) {
    param_01 waittill("vehicle_mount", var_02);
    if(isDefined(var_02) && param_00 == var_02) {
      break;
    }
  }
}

func_A78C(param_00, param_01) {
  for(;;) {
    param_01 waittill("trigger", var_02);
    if(param_00 == var_02) {
      break;
    }
  }
}

func_795E(param_00) {
  self.var_9EDD endon("death");
  for(;;) {
    var_01 = self.var_9EDD method_80E2();
    if(common_scripts\utility::func_562E(self.var_9734)) {} else if(isDefined(var_01) && param_00) {
      var_02 = var_01 getangles();
      var_03 = (0, var_02[1], 0);
      var_04 = anglesToForward(var_03);
      var_05 = var_01 getvieworigin();
      var_06 = var_05 + var_04 * 1000;
      self method_825B(var_06);
    } else {
      var_03 = self.var_1D;
      var_04 = anglesToForward(var_06);
      var_05 = self.var_116 + (0, 0, 100);
      var_06 = var_06 + var_05 * 1000;
      self method_825B(var_06);
    }

    wait 0.05;
  }
}

func_9F82(param_00) {
  var_01 = self method_84C8();
  if(!isDefined(var_01)) {
    return undefined;
  }

  var_02 = var_01 method_864F();
  if(!isDefined(var_02)) {
    return undefined;
  }

  var_03 = 0;
  var_04 = 0;
  for(var_05 = self.var_116; isDefined(var_02); var_05 = var_05 method_864F()) {
    var_06 = var_02.var_116;
    var_03 = var_03 + distance2d(var_05, var_06);
    if(var_03 > param_00) {
      var_07 = param_00 - var_04;
      var_08 = vectornormalize(var_06 - var_05);
      var_09 = var_05 + var_08 * var_07;
      var_09 = (var_09[0], var_09[1], self.var_116[2] + 100);
      return var_09;
    }

    var_07 = var_06;
    var_08 = var_09;
  }

  return undefined;
}

func_794C(param_00) {
  waittillframeend;
  var_01 = self.var_A2C8;
  param_00 linkto(var_01);
}

func_795D(param_00) {
  waittillframeend;
  var_01 = self.var_A2C8;
  param_00 method_83EF();
  param_00 enablelinkto();
  param_00 linkto(var_01);
  for(;;) {
    if(0) {
      param_00 waittill("trigger");
    }

    var_02 = undefined;
    var_03 = undefined;
    for(;;) {
      if(var_01.var_664C) {
        func_795C(var_01);
        var_01 waittill("repaired");
      }

      if(0) {
        var_04 = isDefined(var_02) && var_02 istouching(param_00);
        var_05 = isDefined(var_03) && var_03 istouching(param_00);
        foreach(var_07 in level.var_744A) {
          var_08 = var_07.var_1A7 == var_01.var_1A7;
          if(var_08 && !var_04 && var_07 istouching(param_00)) {
            var_04 = 1;
            var_02 = var_07;
            continue;
          }

          if(!var_08 && !var_05 && var_07 istouching(param_00)) {
            var_05 = 1;
            var_03 = var_07;
          }
        }

        if(!var_04 && !var_05) {
          func_795C(var_01);
          break;
        } else if(var_04 && var_05) {
          func_795C(var_01);
        } else if(var_05) {
          if(var_01.var_17DC) {
            func_795C(var_01);
          } else {
            func_795A(var_01);
          }
        } else if(var_01.var_17D9) {
          func_795C(var_01);
        } else {
          func_7942(var_01);
        }
      } else if(var_01.var_17D9) {
        func_795C(var_01);
      } else {
        func_7942(var_01);
      }

      wait 0.05;
    }
  }
}

func_7942(param_00) {
  if(param_00.var_931A == "forward") {
    return;
  }

  param_00 notify("forward");
  param_00.var_931A = "forward";
  if(1) {
    param_00 method_8293(param_00.var_3835);
  } else {
    param_00 method_8280(param_00.var_384F, param_00.var_3835, param_00.var_3837);
  }

  param_00.var_1C7 = "forward";
  param_00.var_1C1 = "forward";
  param_00.var_17DC = 0;
}

func_795A(param_00) {
  if(param_00.var_931A == "reverse") {
    return;
  }

  param_00 notify("reverse");
  param_00.var_931A = "reverse";
  if(1) {
    param_00 method_8293(param_00.var_3835);
  } else {
    param_00 method_8280(param_00.var_384F, param_00.var_3835, param_00.var_3837);
  }

  param_00.var_1C7 = "reverse";
  param_00.var_1C1 = "reverse";
  param_00.var_17D9 = 0;
}

func_795C(param_00) {
  if(param_00.var_931A == "stop") {
    return;
  }

  param_00.var_931A = "stop";
  param_00 method_8280(0, param_00.var_3835, param_00.var_3837);
}

func_7943(param_00) {
  var_01 = param_00 common_scripts\utility::func_41F2();
  foreach(var_03 in var_01) {
    thread func_7945(var_03);
  }

  for(;;) {
    self waittill("trigger", var_05, var_06);
    switch (var_05) {
      case "opened":
        foreach(var_03 in var_01) {
          func_7950(var_03, 0);
        }
        break;

      case "close":
        foreach(var_03 in var_01) {
          func_7950(var_03, 1);
        }
        break;

      default:
        break;
    }
  }
}

func_7945(param_00) {
  func_7952(param_00);
  self.var_A3F6 = 0;
  for(;;) {
    param_00 waittill("trigger", var_01);
    switch (param_00.var_165) {
      case "blocker_forward":
      case "blocker_reverse":
        self.var_A3F6 = !self.var_A3F6;
        break;

      default:
        break;
    }
  }
}

func_7944(param_00) {
  for(;;) {
    self waittill("trigger", var_01, var_02);
    switch (var_01) {
      case "open":
        lib_0502::func_64D5(param_00, "open_pos", 1.5);
        break;

      case "close":
        lib_0502::func_64D5(param_00, "close_pos", 1.5);
        break;

      default:
        break;
    }
  }
}

func_7946(param_00) {
  for(;;) {
    lib_0502::func_79E1(param_00, "OPEN ME");
    param_00 waittill("used", var_01);
    param_00 sethintstring("");
    self notify("trigger", "open", var_01);
    self waittill("moveToPosDone");
    self notify("trigger", "opened", var_01);
    lib_0502::func_79E1(param_00, "CLOSE ME");
    for(;;) {
      param_00 waittill("used", var_01);
      if(!self.var_A3F6) {
        break;
      }
    }

    param_00 sethintstring("");
    self notify("trigger", "close", var_01);
    self waittill("moveToPosDone");
    self notify("trigger", "closed", var_01);
  }
}

func_7949(param_00) {
  param_00.var_92ED = getvehiclenode(param_00.var_1A2, "targetname");
  var_01 = param_00.var_92ED;
  while(!common_scripts\utility::func_562E(var_01.var_793E)) {
    var_01.var_793E = 1;
    if(isDefined(var_01.var_165)) {
      thread func_794D(param_00, var_01);
    }

    param_00.var_36DA = var_01;
    if(!isDefined(var_01.var_1A2)) {
      break;
    }

    var_01 = getvehiclenode(var_01.var_1A2, "targetname");
  }

  thread func_7951(param_00, param_00.var_92ED);
  thread func_794E(param_00, param_00.var_36DA);
}

func_7951(param_00, param_01) {
  param_01 waittill("trigger");
}

func_794E(param_00, param_01) {
  param_01 waittill("trigger");
}

func_7952(param_00) {
  if(!common_scripts\utility::func_562E(param_00.var_17E4)) {
    param_00 waittill("node_init");
  }
}

func_794F(param_00) {
  if(common_scripts\utility::func_562E(param_00.var_17E4)) {
    return;
  }

  switch (param_00.var_165) {
    case "blocker":
    case "blocker_forward":
    case "blocker_reverse":
      func_7950(param_00, 1);
      break;

    default:
      break;
  }

  param_00.var_17E4 = 1;
  param_00 notify("node_init");
}

func_794D(param_00, param_01) {
  func_794F(param_01);
  for(;;) {
    param_01 waittill("trigger", var_02);
    if(var_02 != param_00) {
      continue;
    }

    switch (param_01.var_165) {
      case "blocker_forward":
        if(param_00.var_931A == "forward") {
          thread func_793F(param_00, param_01);
        }
        break;

      case "blocker_reverse":
        if(param_00.var_931A == "reverse") {
          thread func_793F(param_00, param_01);
        }
        break;

      case "blocker":
        thread func_793F(param_00, param_01);
        break;

      case "notify_level":
        level notify(param_01.var_8260);
        break;

      case "notify_object_nearby":
        func_7953(param_00.var_116, param_01.var_8260);
        break;

      case "trigger_targets":
        var_03 = getEntArray(param_01.var_1A2, "targetname");
        var_04 = common_scripts\utility::func_46B7(param_01.var_1A2, "targetname");
        var_05 = common_scripts\utility::func_F73(var_03, var_04);
        foreach(var_07 in var_05) {
          if(isDefined(param_01.var_8260)) {
            var_07 notify("trigger", param_01.var_8260);
            continue;
          }

          var_07 notify("trigger");
        }
        break;

      case "start_push":
        break;

      default:
        break;
    }
  }
}

func_7953(param_00, param_01) {
  var_02 = getEntArray(param_01, "targetname");
  var_03 = 100000;
  var_04 = undefined;
  foreach(var_06 in var_02) {
    if(!isDefined(var_06.var_67EB)) {
      var_06.var_67EB = 0;
    }

    var_07 = distance2d(param_00, var_06.var_116);
    if(var_07 < var_03 && var_06.var_67EB == 0) {
      var_03 = var_07;
      var_04 = var_06;
    }
  }

  if(isDefined(var_04)) {
    var_04 notify(param_01);
    var_04.var_67EB = 1;
  }
}

func_793F(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("forward");
  param_00 endon("reverse");
  for(;;) {
    param_00.var_17D9 = param_01.var_17D9;
    param_00.var_17DC = param_01.var_17DC;
    var_02 = (param_00.var_17D9 && param_00.var_931A == "forward") || param_00.var_17DC && param_00.var_931A == "reverse";
    if(!var_02) {
      break;
    }

    param_01 waittill("blocked_update");
  }
}

func_7950(param_00, param_01) {
  switch (param_00.var_165) {
    case "blocker_forward":
      param_00.var_17D9 = param_01;
      param_00.var_17DC = 0;
      break;

    case "blocker_reverse":
      param_00.var_17D9 = 0;
      param_00.var_17DC = param_01;
      break;

    case "blocker":
    default:
      param_00.var_17D9 = param_01;
      param_00.var_17DC = param_01;
      break;
  }

  param_00 notify("blocked_update");
}

func_79F8(param_00) {
  waittillframeend;
  var_01 = self.var_A2C8;
  param_00 enablelinkto();
  param_00 linkto(var_01);
  self.var_6EA0 = param_00.var_982D["part_pick_up_trigger"].size;
  for(;;) {
    var_02 = undefined;
    var_01.var_664C = 1;
    if(self.var_6EA0 > 0) {
      var_03 = [];
      var_04 = maps\mp\gametypes\_gameobjects::func_2837(game["attackers"], param_00, var_03, (0, 0, 30), 0, 1);
      var_04 maps\mp\gametypes\_gameobjects::func_C30("friendly");
      var_04 maps\mp\gametypes\_gameobjects::func_8A5A(0);
      var_04 maps\mp\gametypes\_gameobjects::func_86B5(param_00.var_6E9E);
      var_04.var_6BBF = ::func_6B8D;
      var_04.var_6AC9 = ::func_6B8E;
      thread func_7956();
      param_00 sethintstring(&"RAIDS_PART_INSTALL");
      while(self.var_6EA0 > 0) {
        self waittill("part_installed");
      }
    } else {
      lib_0502::func_79E1(param_00, &"RAIDS_REPAIR_USE", 10, 7);
      thread func_7958(param_00.var_A240);
      param_00.var_A240.var_5F95 = 1;
      param_00.var_A240.var_502A = "raidRepair";
      param_00.var_A240.var_681A = 1;
      param_00.var_A240.var_A248 = "war_wrench_assemble_mp";
      param_00.var_A240.var_113F = 0;
      param_00.var_A240.var_7894 = 1;
      param_00 setteamfortrigger(game["attackers"]);
      var_02 = spawnfx(common_scripts\utility::func_44F5("needs_repair"), var_01.var_116 + (0, 0, 120));
      triggerfx(var_02);
      param_00 waittill("used", var_05);
    }

    var_01 notify("repaired");
    var_01 setCanDamage(1);
    var_01.var_6A = 0;
    if(isDefined(var_02)) {
      var_02 delete();
    }

    var_01.var_664C = 0;
    param_00 sethintstring("");
    var_01 waittill("break_down");
  }
}

func_79EF(param_00) {
  param_00 delete();
}

func_794A(param_00) {
  waittillframeend;
  param_00 enablelinkto();
  param_00 linkto(self.var_A2C8);
  for(;;) {
    var_01 = self.var_A2C8 method_8289();
    var_02 = length(var_01);
    if(var_02 > 10) {
      var_03 = param_00 getistouchingentities(level.var_6E97);
      foreach(var_05 in var_03) {
        if(isalive(var_05)) {
          var_05 dodamage(var_05.var_FB * 10, var_05.var_116);
        }
      }
    }

    wait 0.05;
  }
}

func_7956() {
  if(!0) {
    return;
  }

  var_00 = maps\mp\gametypes\_hud_util::func_2830(undefined);
  var_01 = maps\mp\gametypes\_hud_util::func_2831(undefined);
  var_01 settext("Parts Installed");
  func_7955(var_00);
  wait(0.25);
  if(isDefined(var_00)) {
    var_00 maps\mp\gametypes\_hud_util::func_2DCC();
  }

  if(isDefined(var_01)) {
    var_01 maps\mp\gametypes\_hud_util::func_2DCC();
  }
}

func_7955(param_00) {
  self.var_A2C8 endon("repaired");
  var_01 = self.var_6EA0;
  for(;;) {
    var_02 = var_01 - self.var_6EA0 / var_01;
    var_03 = int(param_00.var_1D2 * var_02 + 0.5);
    param_00.var_1586 scaleovertime(0.2, var_03, param_00.var_BD);
    self waittill("part_installed");
  }
}

func_7958(param_00) {
  if(!0) {
    return;
  }

  var_01 = maps\mp\gametypes\_hud_util::func_2830(undefined);
  var_02 = maps\mp\gametypes\_hud_util::func_2831(undefined);
  var_02 settext("Tank Repairing...");
  func_7959(param_00, var_01);
  if(isDefined(var_01)) {
    var_01 maps\mp\gametypes\_hud_util::func_2DCC();
  }

  if(isDefined(var_02)) {
    var_02 maps\mp\gametypes\_hud_util::func_2DCC();
  }
}

func_7959(param_00, param_01) {
  self.var_A2C8 endon("repaired");
  for(;;) {
    var_02 = param_00.var_A22B;
    var_03 = isDefined(level.var_4E09);
    var_04 = param_00.var_54F5;
    wait 0.05;
    if(common_scripts\utility::func_562E(var_04) != common_scripts\utility::func_562E(param_00.var_54F5) || var_02 != param_00.var_A22B || var_03 != isDefined(level.var_4E09)) {
      if(param_00.var_28D5 > param_00.var_A23F) {
        param_00.var_28D5 = param_00.var_A23F;
      }

      var_05 = param_00.var_28D5 / param_00.var_A23F;
      var_06 = 1000 / param_00.var_A23F * param_00.var_A22B;
      if(isDefined(level.var_4E09) || !common_scripts\utility::func_562E(param_00.var_54F5)) {
        var_06 = 0;
      }

      param_01 maps\mp\gametypes\_hud_util::func_A0E3(var_05, var_06);
    }
  }
}

func_6B8D(param_00) {
  var_01 = self.var_9D65.var_982E;
  var_01.var_6EA0--;
  var_01 notify("part_installed");
  if(isDefined(param_00.var_6E96)) {
    param_00.var_6E96 destroy();
  }

  param_00.var_2016 maps\mp\gametypes\_gameobjects::func_2F93();
}

func_6B8E(param_00) {
  param_00 iclientprintlnbold("Find Missing Part");
}

func_79F5(param_00) {
  var_01 = param_00.var_982D["missing_part_model"];
  var_02 = maps\mp\gametypes\_gameobjects::func_27D6(game["attackers"], param_00, var_01, (0, 0, 30));
  var_02 maps\mp\gametypes\_gameobjects::func_C30("friendly");
  var_02 maps\mp\gametypes\_gameobjects::func_8A57(&"RAIDS_PART_PICKUP");
  var_02.var_6B62 = ::func_6B8A;
  var_02.var_6AEF = ::func_6B89;
  var_02.var_6B63 = ::func_6B8B;
  var_02.var_C33 = 1;
  var_03 = param_00.var_982E;
  if(!isDefined(var_03.var_6E9E)) {
    var_03.var_6E9E = [];
  }

  var_03.var_6E9E[var_03.var_6E9E.size] = var_02;
}

func_6B8A(param_00) {
  param_00.var_6E96 = param_00 maps\mp\gametypes\_hud_util::func_27ED("default", 1);
  param_00.var_6E96 maps\mp\gametypes\_hud_util::func_8707("BOTTOM", undefined, 0, -50);
}

func_6B89(param_00) {
  if(isDefined(param_00.var_6E96)) {
    param_00.var_6E96 destroy();
  }
}

func_6B8B(param_00) {
  param_00 iclientprintlnbold("Can only carry one part at a time.");
}

func_7957(param_00) {
  var_01 = getvehiclenode(param_00.var_81EF, "script_linkname");
  var_01 waittill("trigger", var_02);
  level notify("raidEscortVehiclePushObject");
  var_03 = var_02 method_8289();
  var_04 = length(var_03);
  var_05 = param_00.var_116;
  var_06 = param_00.var_64DB["end_pos"].var_116;
  var_07 = var_06 - var_05;
  var_08 = vectordot(var_07, var_03) / var_04;
  var_09 = abs(var_08 / var_04);
  lib_0502::func_64D5(param_00, "end_pos", var_09);
}

func_795F(param_00) {
  var_01 = getvehiclenode(param_00.var_81EF, "script_linkname");
  thread func_7960(var_01);
  waittillframeend;
  var_02 = self.var_982D["explosive_trigger"][0].var_A240;
  var_02 maps\mp\gametypes\_gameobjects::func_8A60("none");
  var_03 = 0;
  while(!var_03) {
    self waittill("trigger", var_04);
    switch (var_04) {
      case "explode":
        func_7950(var_01, 0);
        self notify("wall_explode");
        var_03 = 1;
        break;

      case "vehicle_arrive":
        var_02 maps\mp\gametypes\_gameobjects::func_8A60("any");
        break;

      default:
        break;
    }
  }
}

func_7960(param_00) {
  self endon("wall_explode");
  param_00 waittill("trigger");
  self notify("trigger", "vehicle_arrive");
}

func_79C5(param_00) {
  param_00 hudoutlineenable(0, 1);
  param_00.var_982E waittill("built");
  param_00 delete();
}

func_792B(param_00) {
  var_01 = getEntArray(param_00.var_1A2, "targetname");
  var_02 = [];
  foreach(var_04 in var_01) {
    if(var_04.var_165 == "build_trigger") {
      var_02[var_02.size] = var_04;
    }
  }

  param_00.var_5B3A = 0;
  param_00 thread func_7930(var_02);
  if(isDefined(param_00.var_81EF)) {
    var_06 = getvehiclenode(param_00.var_81EF, "script_linkname");
    if(isDefined(var_06)) {
      thread func_7940(var_06);
      var_07 = 0;
      while(!var_07) {
        self waittill("trigger", var_08);
        switch (var_08) {
          case "100_percent":
            func_7950(var_06, 0);
            var_07 = 1;
            break;

          case "vehicle_arrive":
            break;

          default:
            break;
        }
      }
    }
  }
}

func_7940(param_00) {
  self endon("100_percent");
  param_00 waittill("trigger");
  self notify("trigger", "vehicle_arrive");
}

func_7930(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    lib_0502::func_79E1(var_03, &"RAIDS_REPAIR_USE", 15, 7);
    var_03 setteamfortrigger(game["attackers"]);
    var_03.var_A240.var_A248 = "war_hammer_assemble_mp";
    var_03.var_A240.var_113F = 0;
    var_03.var_A240.var_7894 = 1;
    var_01[var_01.size] = var_03.var_A240;
  }

  self.allow_weapon = var_01;
  var_05 = maps\mp\gametypes\_gameobjects::func_A226(var_01);
  var_05.var_5F95 = 1;
  var_05 maps\mp\gametypes\_gameobjects::func_8A5A(15);
  var_05 maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_REPAIR_USE_BAR");
  var_05.var_6ABC = ::func_792D;
  var_05.var_6AFA = ::func_792E;
  var_05.var_6BBF = ::func_792C;
  var_05.var_1C6E = self;
  var_05.var_502A = "raidConstruct";
  var_05.var_681A = 1;
}

func_792C(param_00) {
  self.var_1C6E notify("built");
  level notify("raidBridgeFinishedBuilding");
  foreach(var_02 in self.var_21F7) {
    var_02.var_9D65 sethintstring("");
  }
}

func_7931(param_00) {
  param_00 delete();
}

func_792D(param_00) {
  thread func_792F(param_00);
}

func_792F(param_00) {
  if(self.var_54F6.size > 0) {
    return;
  }

  self endon("stop_percent_update");
  var_01 = self.var_1C6E;
  for(;;) {
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

func_792E(param_00, param_01, param_02) {
  if(self.var_54F6.size > 0) {
    return;
  }

  if(self.var_28D5 / self.var_A23F < 1) {
    self notify("stop_percent_update");
  }
}

func_7932(param_00) {
  var_01 = param_00.var_3B == "script_brushmodel";
  param_00 lib_0502::func_7997();
  for(;;) {
    self waittill("trigger", var_02, var_03);
    if(var_02 == "explode") {
      param_00 lib_0502::func_79C6();
      continue;
    }

    if(var_02 == "5_percent") {
      param_00 lib_0502::func_7997();
    }
  }
}

func_7933(param_00) {
  param_00 lib_0502::func_7997();
  for(;;) {
    self waittill("trigger", var_01, var_02);
    if(var_01 == "explode") {
      param_00 lib_0502::func_7997();
      continue;
    }

    if(var_01 == param_00.var_8260 || var_01 == "100_percent") {
      param_00 lib_0502::func_79C6();
    }
  }
}

func_7934(param_00) {
  for(;;) {
    self waittill("trigger", var_01, var_02);
    if(var_01 == param_00.var_8260 || var_01 == "100_percent") {
      param_00 lib_0502::func_7997();
    }
  }
}

func_7948(param_00) {
  param_00.var_2F74 = 1;
  param_00.var_17DF = 1;
  param_00 notify("disabled");
  param_00.var_4C28 = self;
  self.var_A3F6 = 0;
  waittillframeend;
  if(param_00.var_165 == "blocker_forward") {
    if(isDefined(param_00.var_112)) {
      param_00.var_112.var_4C32[param_00.var_112.var_4C32.size] = self;
    }

    self.var_17E3 = param_00;
  } else {
    self.var_17E6 = param_00;
  }

  for(;;) {
    param_00 waittill("trigger", var_01);
    switch (param_00.var_165) {
      case "blocker_forward":
      case "blocker_reverse":
        self.var_A3F6 = !self.var_A3F6;
        if(self.var_A3F6) {
          self notify("trigger", "vehicle_block");
        } else {
          self notify("trigger", "vehicle_unblock");
        }

        if(!self.var_A3F6) {
          if(param_00.var_165 == "blocker_forward") {
            func_797F(game["defenders"]);
          } else {
            func_797F(game["attackers"]);
          }
        }
        break;

      default:
        break;
    }
  }
}

func_797D(param_00) {
  var_01 = param_00 common_scripts\utility::func_41F2();
  foreach(var_03 in var_01) {
    thread func_7948(var_03);
  }

  lib_0502::func_1D39(param_00);
  if(!isDefined(level.var_79C2.var_4C32)) {
    level.var_79C2.var_4C32 = [];
  }

  level.var_79C2.var_4C32[level.var_79C2.var_4C32.size] = param_00;
  self.var_172D = "";
  func_797F(game["defenders"]);
  self.var_2599 = 0;
  for(;;) {
    self waittill("trigger", var_05, var_06);
    switch (var_05) {
      case "constructed":
        foreach(var_03 in var_01) {
          var_03.var_2F74 = undefined;
          var_03 notify("enabled");
        }
        break;

      case "bomb_planted":
        self.var_18C6 = 1;
        break;

      case "bomb_exploded":
      case "destroyed":
        self.var_18C6 = 0;
        foreach(var_03 in var_01) {
          var_03.var_2F74 = 1;
          var_03 notify("disabled");
        }
        break;

      default:
        break;
    }
  }
}

func_797F(param_00) {
  if(self.var_172D == param_00) {
    return;
  }

  self.var_172D = param_00;
}

func_798F() {
  var_00 = common_scripts\utility::func_46B7("raid_hedgehog", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 func_798E();
  }
}

func_7986() {
  var_00 = common_scripts\utility::func_46B7("raid_hedgehog", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 thread func_7985();
  }
}

func_7983(param_00) {
  self waittillmatch("remove", "trigger");
  param_00 delete();
}

func_798E() {
  if(isDefined(self.var_9D65)) {
    self.var_9D65 delete();
  }

  self notify("trigger", "remove");
}

func_7985() {
  if(common_scripts\utility::func_562E(self.var_18C6)) {
    self waittillmatch("bomb_exploded", "trigger");
    waittillframeend;
  }

  self notify("trigger", "disable");
  if(isDefined(self.var_9D65)) {
    if(isDefined(self.var_9D65.var_A240)) {
      self.var_9D65.var_A240 thread func_2F6E();
    }

    waittillframeend;
    self.var_9D65 delete();
  }
}

func_7994(param_00) {
  self notify("raidHedgehogWaittillBombPlanted");
  self endon("raidHedgehogWaittillBombPlanted");
  param_00 waittill("used", var_01);
  self notify("trigger", "bomb_planted", var_01);
}

func_7996(param_00) {
  self notify("hedgehogWatchForVehicleInterrupt");
  self endon("hedgehogWatchForVehicleInterrupt");
  param_00 endon("death");
  if(common_scripts\utility::func_562E(self.var_A3F6)) {
    param_00 common_scripts\utility::func_9D9F();
  }

  for(;;) {
    self waittill("trigger", var_01);
    if(var_01 == "constructed") {
      return;
    } else {
      if(var_01 == "vehicle_block") {
        param_00 common_scripts\utility::func_9D9F();
        continue;
      }

      if(var_01 == "vehicle_unblock") {
        param_00 common_scripts\utility::func_9DA3();
      }
    }
  }
}

func_7992(param_00) {
  lib_0502::func_79E3(param_00);
  param_00 allowjump(0);
}

func_7993(param_00, param_01, param_02) {
  lib_0502::func_79E4(param_00, param_01, param_02);
  if(isDefined(param_01)) {
    param_01 allowjump(1);
  }
}

func_7991(param_00, param_01) {
  param_00.var_A240.var_4C28 = self;
  param_00.var_A240.var_2F90 = 1;
  param_00.var_A240.var_6ABC = ::func_7992;
  param_00.var_A240.var_6AFA = ::func_7993;
  param_00.var_A240.var_A248 = param_01;
  param_00.var_A240.var_A23C = 0;
  param_00.var_A240.var_7894 = 1;
}

func_7990(param_00) {
  param_00 endon("death");
  self.var_9D65 = param_00;
  lib_0502::func_1D3A(param_00, self.var_2599);
  for(;;) {
    lib_0502::func_79E1(param_00, &"RAIDS_USE_CONSTRUCT", 3, 6);
    func_7991(param_00, "war_wrench_assemble_mp");
    lib_0502::func_1D3B(self.var_2599);
    thread func_7996(param_00);
    param_00 waittill("used", var_01);
    param_00 sethintstring("");
    self.var_2599 = 1;
    lib_0502::func_1D3B(self.var_2599);
    self notify("trigger", "constructed", var_01);
    if(lib_0502::func_21AC(self, var_01)) {
      lib_0502::func_7922(var_01);
    }

    for(;;) {
      var_02 = undefined;
      var_03 = undefined;
      lib_0502::func_79E1(param_00, &"RAIDS_USE_PLACE_EXPLOSIVE", 3, 8);
      func_7991(param_00, "war_dynamite_mp");
      thread func_7994(param_00);
      for(;;) {
        self waittill("trigger", var_02, var_03);
        if(var_02 == "bomb_planted" || var_02 == "destroyed") {
          break;
        }
      }

      param_00 sethintstring("");
      if(var_02 == "destroyed") {
        break;
      }

      thread func_7989(param_00, var_03);
      param_00 sethintstring("");
      for(;;) {
        self waittill("trigger", var_02, var_03);
        if(var_02 == "bomb_exploded" || var_02 == "destroyed") {
          break;
        }
      }

      param_00 sethintstring("");
      self notify("stop_timer");
      if(var_02 == "bomb_exploded" || var_02 == "destroyed") {
        break;
      }
    }
  }
}

func_7989(param_00, param_01) {
  self endon("stop_timer");
  var_02 = 5;
  if(isDefined(param_01) && param_01 maps\mp\_utility::func_649("specialty_improvedobjectives")) {
    var_02 = 2.5;
  }

  var_03 = gettime() + var_02 * 1000;
  var_04 = 0;
  while(var_03 > gettime()) {
    if(var_04 != 0) {
      lib_04F3::func_79CB("dynamite_timer_tick", param_00.var_116);
    } else {
      lib_04F3::func_79CB("dynamite_timer_tock", param_00.var_116);
    }

    var_04 = var_04 + 1 % 2;
    var_05 = var_03 - gettime() / 1000;
    var_06 = 0.05;
    if(var_05 > 2) {
      var_06 = 0.5;
    } else if(var_05 > 1) {
      var_06 = 0.25;
    }

    maps\mp\gametypes\_hostmigration::func_A783(var_06);
    if(isDefined(level.var_4E09)) {
      var_07 = maps\mp\gametypes\_hostmigration::func_A782();
      var_03 = var_03 + var_07;
    }
  }

  maps\mp\gametypes\_hostmigration::func_A782();
  thread func_7987(param_00, param_01, 0);
}

func_7987(param_00, param_01, param_02) {
  var_03 = param_00 lib_0502::func_207F();
  var_04 = var_03.var_982D["explosive_model"][0];
  self.var_2599 = 0;
  if(!common_scripts\utility::func_562E(param_02)) {
    param_00 entityradiusdamage(var_04.var_116, 256, 150, 20, param_01, "MOD_EXPLOSIVE", "bomb_site_mp");
  }

  self notify("stop_timer");
  if(isDefined(param_00) && isDefined(param_00.var_A240)) {
    param_00.var_A240 thread func_2F6E();
  }

  self notify("trigger", "bomb_exploded", param_01, param_02);
  if(lib_0502::func_21AC(self, param_01)) {
    lib_0502::func_7923(param_01);
  }
}

func_2F6E() {
  self notify("disabled");
  waittillframeend;
  maps\mp\gametypes\_gameobjects::func_2D58();
}

func_798C(param_00) {
  param_00.var_79AD = self;
  param_00 lib_0502::func_7997();
  for(;;) {
    self waittill("trigger", var_01, var_02);
    if(var_01 == "constructed") {
      param_00 lib_0502::func_79C6();
      thread func_798B(param_00);
      continue;
    }

    if(var_01 == "bomb_exploded" || var_01 == "destroyed") {
      param_00 lib_0502::func_7997();
      continue;
    }

    if(var_01 == "remove" || var_01 == "disable") {
      param_00 delete();
      return;
    }
  }
}

func_797E(param_00) {
  param_00 endon("death");
  thread func_7983(param_00);
  thread func_798B(param_00);
  var_01 = 1;
  waittillframeend;
  for(;;) {
    param_00.var_93FD = 1;
    if(var_01) {
      param_00 method_8278("mp_raids_hedgehog_inactive_idle", "hedgehog");
    }

    self.var_9D65 waittill("beginUse", var_02);
    if(!self.var_9D65.var_A240.var_54F5) {
      continue;
    }

    if(isDefined(var_02) && var_02 maps\mp\_utility::func_649("specialty_improvedobjectives")) {
      param_00 method_8278("mp_raids_hedgehog_assemble_fast", "hedgehog");
    } else {
      param_00 method_8278("mp_raids_hedgehog_assemble", "hedgehog");
    }

    self.var_9D65 waittill("endUse", var_02, var_03);
    if(var_03) {
      param_00 method_8278("mp_raids_hedgehog_idle", "hedgehog");
      lib_0502::func_7D5C(param_00);
      for(;;) {
        self waittill("trigger", var_04, var_02);
        if(var_04 == "bomb_exploded" || var_04 == "destroyed") {
          break;
        }
      }

      param_00 method_8278("mp_raids_hedgehog_destroy", "hedgehog");
    }

    var_01 = !var_03;
  }
}

func_798A(param_00) {
  var_01 = 1;
  for(;;) {
    self waittill("trigger", var_02, var_03);
    if(var_02 == "constructed") {
      param_00 lib_0502::func_7997();
      var_01 = 0;
      continue;
    }

    if(var_02 == "bomb_exploded" || var_02 == "destroyed") {
      if(!common_scripts\utility::func_562E(self.var_A3F6)) {
        param_00 lib_0502::func_79C6();
      }

      var_01 = 1;
      continue;
    }

    if(var_02 == "vehicle_block") {
      if(var_01) {
        param_00 lib_0502::func_7997();
      }

      continue;
    }

    if(var_02 == "vehicle_unblock") {
      if(var_01) {
        param_00 lib_0502::func_79C6();
      }

      continue;
    }

    if(var_02 == "remove" || var_02 == "disable") {
      param_00 delete();
      return;
    }
  }
}

func_7988(param_00, param_01) {
  level.var_611["raid_door_explode"] = loadfx("vfx/map/mp_raid_cobra/raid_wall_breach_mp");
  var_02 = param_00.var_982E;
  param_00.var_6A55 = param_00 method_85A0();
  param_00 lib_0502::func_7997();
  param_00 thread maps\mp\gametypes\_damage::func_8676(10, "normal", ::func_7981, ::lib_0502::func_1D37, 0);
  param_00 setCanDamage(0);
  param_00.var_C2E = 1;
  var_03 = undefined;
  for(;;) {
    self waittill("trigger", var_04, var_05, var_06);
    switch (var_04) {
      case "bomb_exploded":
        if(!common_scripts\utility::func_562E(var_06)) {
          lib_04F3::func_79CB("mp_war_bomb_explo", param_00.var_116);
          playFX(common_scripts\utility::func_44F5("raid_door_explode"), param_00.var_116, param_00.var_1D + (0, -90, 0));
        }

        param_00 lib_0502::func_7997();
        param_00 setCanDamage(0);
        if(isDefined(var_03)) {
          var_03 delete();
        }
        break;

      case "bomb_planted":
        var_03 = magicgrenademanual("war_dynamite_mp", param_00.var_116, (0, 0, 0), 6);
        var_03 method_8449(param_00);
        param_00 setModel("par_dynamite_01");
        param_00 setCanDamage(1);
        param_00.var_706B = var_05.var_1A7;
        badplace_cylinder("war_dynamite_mp", 6, param_00.var_116, 300, 128, "allies", "axis");
        lib_0502::func_7D5C(param_00);
        self.var_9D65 thread lib_0502::func_8A18(param_00);
        break;

      case "constructed":
        param_00 setModel("par_dynamite_01_sheen");
        param_00 lib_0502::func_79C6();
        param_00 setCanDamage(0);
        if(isDefined(var_03)) {
          var_03 delete();
        }
        break;

      case "destroyed":
        param_00 lib_0502::func_7997();
        param_00 setCanDamage(0);
        if(isDefined(var_03)) {
          var_03 delete();
        }
        break;

      case "disable":
      case "remove":
        param_00 delete();
        break;

      default:
        break;
    }
  }
}

func_7981(param_00, param_01, param_02, param_03, param_04) {
  var_05 = lib_0502::func_207F();
  var_06 = var_05.var_982D["trigger"][0];
  var_05 func_7987(var_06, param_00, param_04);
}

func_6B8C(param_00, param_01, param_02, param_03) {
  var_04 = lib_0502::func_207F();
  if(!var_04.var_2599) {
    return 0;
  }

  if(isPlayer(param_00) && isDefined(self.var_706B) && param_00.var_1A7 != self.var_706B) {
    return 0;
  }

  if(maps\mp\_utility::func_5694(param_02) || isexplosivedamagemod(param_02)) {
    return param_03;
  }

  return 0;
}

func_7980(param_00) {
  param_00 notsolid();
  for(;;) {
    self waittill("trigger", var_01, var_02);
    if(var_01 == "constructed") {
      param_00 lib_0502::func_79C6();
      continue;
    }

    if(var_01 == "bomb_exploded" || var_01 == "destroyed") {
      param_00 lib_0502::func_7997();
      continue;
    }

    if(var_01 == "remove") {
      param_00 delete();
      return;
    }
  }
}

func_798B(param_00) {
  var_01 = 6;
  param_00.var_93FD = undefined;
  param_00 thread maps\mp\gametypes\_damage::func_8676(var_01, "raid_buildable", ::func_7982, ::lib_0502::func_1D38);
}

func_7982(param_00, param_01, param_02, param_03) {
  var_04 = self.var_982E;
  if(!var_04.var_2599) {
    return;
  }

  var_04.var_2599 = 0;
  var_04 notify("trigger", "destroyed", param_00);
  if(isDefined(var_04.var_9D65) && isDefined(var_04.var_9D65.var_A240)) {
    var_04.var_9D65.var_A240 notify("disabled");
  }

  if(lib_0502::func_21AC(var_04, param_00)) {
    lib_0502::func_7923(param_00);
  }
}

func_798D(param_00, param_01, param_02, param_03) {
  var_04 = lib_04F7::func_7A02(param_01, param_02);
  return var_04;
}

func_7995() {
  if(!self.var_2599) {
    return;
  }

  for(;;) {
    self waittill("trigger", var_00, var_01);
    if(var_00 == "bomb_exploded" || var_00 == "destroyed") {
      break;
    }
  }
}

func_7984(param_00) {
  param_00 endon("death");
  func_7995();
  param_00 delete();
}

func_79D3(param_00) {
  self.var_565F = 0;
  self.var_7433 = undefined;
  thread func_79DD();
}

func_79D5() {
  foreach(var_05, var_01 in self.var_982D) {
    if(var_05 != "script_struct") {
      foreach(var_03 in var_01) {
        if(isDefined(var_03)) {
          var_03 delete();
        }
      }
    }
  }
}

func_79DD() {
  var_00 = getent("raid_escort_vehicle", "script_noteworthy");
  var_01 = 120;
  for(;;) {
    var_02 = var_00.var_116;
    if(isDefined(var_00.var_A2C8)) {
      var_02 = var_00.var_A2C8.var_116;
    }

    var_03 = self.var_116;
    var_04 = distance2d(var_02, var_03);
    if(var_04 <= var_01) {
      if(self.var_565F) {
        radiusdamage(var_03, 256, 150, 20, self.var_7433, "MOD_EXPLOSIVE", "bomb_site_mp");
        lib_04F3::func_79CB("mp_war_bomb_explo", var_03);
        playFX(common_scripts\utility::func_44F5("hedgehog_explode"), var_03);
      }

      func_79D5();
      return;
    }

    wait 0.05;
  }
}

func_79DC(param_00) {
  param_00 endon("death");
  param_00 endon("defuse_over");
  self notify("raidTankMineWaittillDefused");
  self endon("raidTankMineWaittillDefused");
  param_00 waittill("used", var_01);
  self notify("trigger", "defused", var_01);
}

func_79DA(param_00) {
  param_00 endon("death");
  for(;;) {
    var_01 = undefined;
    var_02 = undefined;
    lib_0502::func_79E1(param_00, &"RAIDS_PLACE_MINE", 3, &"RAIDS_PLACING_MINE");
    param_00 setteamfortrigger(game["defenders"]);
    param_00 waittill("used", var_03);
    param_00 sethintstring("");
    self notify("trigger", "placed", var_03);
    self.var_565F = 1;
    self.var_7433 = var_03;
    lib_0502::func_79E1(param_00, &"RAIDS_USE_DEFUSE", 3, 11);
    param_00 setteamfortrigger(game["attackers"]);
    thread func_79DC(param_00);
    for(;;) {
      self waittill("trigger", var_01, var_02);
      if(var_01 == "defused" || var_01 == "destroyed") {
        param_00 notify("defuse_over");
        break;
      }
    }

    param_00 sethintstring("");
    self.var_565F = 0;
    self.var_7433 = undefined;
  }
}

func_79DB(param_00) {
  param_00 delete();
}

func_79D7(param_00) {
  var_01 = 1;
  param_00.var_93FD = undefined;
  param_00 thread maps\mp\gametypes\_damage::func_8676(var_01, undefined, ::func_79D4, ::func_79D9);
}

func_79D4(param_00, param_01, param_02, param_03) {
  var_04 = self.var_982E;
  var_04 notify("trigger", "destroyed", param_00);
}

func_79D9(param_00, param_01, param_02, param_03) {
  var_04 = -1;
  return var_04;
}

func_79D8(param_00) {
  param_00 endon("death");
  param_00 lib_0502::func_7997();
  for(;;) {
    self waittill("trigger", var_01, var_02);
    if(var_01 == "placed") {
      param_00 lib_0502::func_79C6();
      thread func_79D7(param_00);
      continue;
    }

    if(var_01 == "defused" || var_01 == "destroyed") {
      param_00 lib_0502::func_7997();
    }
  }
}

func_79D6(param_00) {
  param_00 endon("death");
  for(;;) {
    self waittill("trigger", var_01, var_02);
    if(var_01 == "placed") {
      param_00 lib_0502::func_7997();
      continue;
    }

    if(var_01 == "defused" || var_01 == "destroyed") {
      param_00 lib_0502::func_79C6();
    }
  }
}

func_7928(param_00) {
  waittillframeend;
  var_01 = lib_0503::func_2838(param_00, game["attackers"], 1, 0, 0);
  param_00.var_1A5 = param_00.var_1A5 + "_spawner";
  var_01.var_1A2 = param_00.var_1A2;
  var_01 makeunusable();
  var_01 setCanDamage(0);
  var_01.var_384F = 4;
  var_01.var_3835 = 5;
  var_01.var_3837 = 5;
  var_01.var_931A = "";
  var_01.var_17D9 = 0;
  var_01.var_17DC = 0;
  self.var_A2C8 = var_01;
  func_7949(var_01);
  self waittillmatch(var_01.var_1A5, "unblock");
  var_01 startpath(var_01.var_92ED);
}

func_7927(param_00) {
  thread func_79F8(param_00);
  wait 0.05;
  self.var_A2C8 waittill("repaired");
  func_79FA(self.var_A2C8.var_1A5);
}

func_79FA(param_00) {
  self notify("unblock", param_00);
}

func_79F3(param_00, param_01, param_02) {
  foreach(var_04 in param_01) {
    if(isDefined(var_04.var_165)) {
      var_05 = strtok(var_04.var_165, " ");
      foreach(var_07 in var_05) {
        self thread[[param_02]](param_00, var_04, var_07);
      }
    }
  }
}