/********************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_tower_battle_zombie_states.gsc
********************************************************************/

func_528A() {
  lib_0547::func_7BD0("zombie_attack_tower_lever", ::func_767A, ::func_767B, 3.75);
  lib_0547::func_7BD0("zombie_idle_at_tower", ::func_767C, ::func_767D, 3.25);
}

func_8601(param_00) {
  func_85A9();
  self.var_9ACD = "attacking point";
  thread lib_0547::func_7D1A("zombie_attack_tower_lever", [param_00]);
}

func_85A9() {
  if(common_scripts\utility::func_562E(self.var_0C29) || !isDefined(self.var_0C29)) {
    self.var_0C2A = 1;
    self.var_0C29 = 0;
  }
}

func_85AA() {
  if(common_scripts\utility::func_562E(self.var_0C2A)) {
    self.var_0C2A = undefined;
    self.var_0C29 = 1;
  }
}

func_767A(param_00) {
  func_7679(param_00, "zombie_attack_tower_lever");
}

func_767B(param_00) {
  func_85AA();
  self notify("clear_tower_behavior");
}

func_8602(param_00) {
  self.var_9ACD = "idling at tower";
  thread lib_0547::func_7D1A("zombie_idle_at_tower", [param_00]);
}

func_767C(param_00) {
  thread func_7679(param_00, "idle_noncombat");
}

func_767D() {
  self notify("clear_tower_behavior");
}

func_8603(param_00) {
  func_85A9();
  self.var_9ACD = "travel to attack";
  self.var_6941 = 1;
  thread func_84E7(param_00);
}

func_8604(param_00) {
  self.var_9ACD = "travel to idle";
  self.var_6941 = 1;
  thread func_84E8(param_00);
}

func_23A0() {
  var_00 = lib_0547::func_408F();
  foreach(var_02 in var_00) {
    if(isDefined(var_02) && isalive(var_02)) {
      var_02 func_8605();
    }
  }

  foreach(var_05 in level.var_08CB) {
    maps\mp\mp_zombie_nest_special_event_creator_interface::func_23C4(var_05);
  }
}

func_8605(param_00) {
  func_85AA();
  self.var_6941 = 0;
  self.var_9B61 = undefined;
  self.var_60D0 = undefined;
  self notify("clear_tower_behavior");
  if(!common_scripts\utility::func_562E(param_00)) {
    self.var_9ACD = "not interested";
    return;
  }

  self.var_9ACD = "ignore the tower";
}

func_9BCF(param_00, param_01, param_02) {
  var_03 = 0;
  if(isDefined(param_00.var_9B61)) {
    var_04 = param_00.var_9B61;
    var_04.var_65FB = param_01;
    param_00 func_8605();
    param_01 func_8603(var_04);
    var_03 = 1;
  }

  return var_03;
}

func_84E7(param_00) {
  self endon("death");
  self endon("clear_tower_behavior");
  self.var_9B61 = param_00;
  func_A658(param_00, 32, 0);
  func_8601(param_00);
}

func_84E8(param_00) {
  self endon("death");
  self endon("clear_tower_behavior");
  func_A658(param_00, 32, 0);
  func_8602(param_00);
}

func_24E4() {
  var_00 = lib_0547::func_408F();
  var_01 = getdvarint("scr_zombieactivatehudoutline_tower", 0);
  foreach(var_03 in var_00) {
    if(common_scripts\utility::func_562E(var_03.var_5539)) {
      continue;
    }

    if(!isDefined(var_03.var_9ACD)) {
      var_04 = "";
    } else {
      var_04 = var_03.var_9ACD;
    }

    var_03 hudoutlinedisable();
    switch (var_04) {
      case "not interested":
        if(var_01 == 3) {
          var_03 hudoutlineenable(0, 0);
        }
        break;

      case "travel to idle":
        if(var_01 == 3) {
          var_03 hudoutlineenable(0, 0);
        }
        break;

      case "travel to attack":
        if(var_01 >= 2) {
          var_03 hudoutlineenable(2, 0);
        }
        break;

      case "idling at tower":
        if(var_01 == 3) {
          var_03 hudoutlineenable(0, 0);
        }
        break;

      case "attacking point":
        if(var_01 >= 1) {
          var_03 hudoutlineenable(1, 0);
        }
        break;

      case "ignore the tower":
        if(var_01 == 3) {
          var_03 hudoutlineenable(1, 0);
        }
        break;
    }
  }
}

func_250A(param_00) {}

func_7714() {}

func_A7F2() {
  return isDefined(self.var_9ACD) && self.var_9ACD == "travel to attack" || self.var_9ACD == "attacking point";
}

func_A7F4() {
  return isDefined(self.var_9ACD) && self.var_9ACD == "travel to idle" || self.var_9ACD == "idling at tower";
}

func_7679(param_00, param_01) {
  self endon("death");
  self endon("clear_tower_behavior_handled");
  thread func_49A2(level.var_7AC8);
  self.var_001D = param_00.var_001D;
  self setorigin(param_00.var_0116);
  maps\mp\mp_zombie_nest_ee_util::func_8579(param_00.var_001D);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "tower_objective");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_434D(param_01, undefined, 1);
  for(;;) {
    if(common_scripts\utility::func_562E(self.var_2FDA)) {
      func_8605(1);
      break;
    }

    var_03 = maps\mp\mp_zombie_nest_ee_util::func_7AC3(var_02);
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_02, var_03, 1, "scripted_anim");
  }
}

func_3E77() {
  return !lib_053C::func_AB86() || lib_053C::func_5686();
}

func_561E() {
  return common_scripts\utility::func_562E(self.var_561D);
}

func_5629() {
  return common_scripts\utility::func_562E(self.var_98EF) || common_scripts\utility::func_562E(self.var_AC06);
}

func_9E0E(param_00, param_01, param_02, param_03, param_04) {
  var_05 = maps\mp\mp_zombie_nest_special_event_creator_interface::func_9959();
  for(var_06 = 0; var_06 < param_00.size; var_06++) {
    var_07 = common_scripts\utility::func_7A33(param_01);
    if(maps\mp\mp_zombie_nest_special_event_creator_interface::func_ABD2(param_00[var_06])) {
      continue;
    }

    if(param_00[var_06] func_A7F2()) {
      continue;
    }

    if(common_scripts\utility::func_562E(param_00[var_06].var_60D0)) {
      continue;
    }

    if(!param_00[var_06] lib_0547::func_4B2C()) {
      continue;
    }

    if(!param_00[var_06] func_5552(param_03)) {
      continue;
    }

    if(param_00[var_06] func_561C()) {
      continue;
    }

    if(isDefined(var_07)) {
      var_08 = func_412A(var_07);
      var_09 = func_AB87(param_00[var_06], var_08, var_07);
      var_0A = 0;
      if(isDefined(var_09)) {
        var_0A = func_9BCF(var_09, param_00[var_06], var_07);
      }

      if(!var_0A && func_1172(param_01) && !func_AC05(var_08, param_04)) {
        func_9E10(param_00[var_06], var_07);
      }
    }
  }

  if(var_05) {
    param_00 = lib_0547::func_408F();
    foreach(var_0C in param_00) {
      if(!var_0C func_A7F2()) {
        var_0C func_8605();
      }
    }
  }
}

func_5552(param_00) {
  for(var_01 = 0; var_01 < param_00.size; var_01++) {
    if(isDefined(self.var_0A4B) && self.var_0A4B == param_00[var_01]) {
      return 1;
    }
  }

  return 0;
}

func_7C0F(param_00, param_01) {
  var_02 = 0;
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    for(var_04 = 0; var_04 < param_00[var_03].var_AB4E.size; var_04++) {
      var_05 = param_00[var_03].var_AB4E[var_04].var_65FB;
      if(isDefined(var_05) && isalive(var_05)) {
        if(var_05 func_3E77()) {
          if(var_05 func_561C() || common_scripts\utility::func_562E(var_05.var_2FDA) || !var_05 func_5552(param_01)) {
            if(common_scripts\utility::func_562E(var_05.var_2FDA) || !var_05 func_5552(param_01)) {
              var_05 func_8605(1);
            } else if(var_05 func_561C()) {
              var_05 func_8605();
            }

            var_05 notify("is_tower_battle_distracted");
            param_00[var_03].var_AB4E[var_04] func_23D5();
          } else {
            var_05 notify("is_tower_battle_focused");
            var_05 func_8419(param_00[var_03].var_AB4E[var_04]);
          }

          continue;
        }

        var_05 notify("is_tower_battle_distracted");
        var_02 = 1;
      }
    }
  }

  return var_02;
}

func_561C() {
  return func_5629() || func_561E();
}

func_A658(param_00, param_01, param_02) {
  while(distance(param_00.var_0116, self.var_0116) > param_01) {
    wait(0.1);
  }
}

func_49A2(param_00) {
  self endon("death");
  for(var_01 = 0; var_01 < param_00.size; var_01++) {
    thread func_A645(param_00[var_01]);
  }

  self waittill("tower_behavior_cancel_reason_found");
  self notify("clear_tower_behavior_handled");
  func_8605();
  wait 0.05;
  maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "tower_objective");
  self scragentsetscripted(0);
  self method_839D("gravity");
}

func_A645(param_00) {
  self endon("tower_behavior_cancel_reason_found");
  self endon("death");
  self waittill(param_00);
  self notify("tower_behavior_cancel_reason_found");
}

func_AB87(param_00, param_01, param_02) {
  var_03 = [];
  for(var_04 = 0; var_04 < param_01.size; var_04++) {
    if(isDefined(param_01[var_04].var_9ACD) && common_scripts\utility::func_562E(param_01[var_04].var_9ACD != "attacking point") && distance(param_00.var_0116, param_02.var_0116) < distance(param_01[var_04].var_0116, param_02.var_0116)) {
      return param_01[var_04];
    }
  }

  return undefined;
}

func_A63F() {
  var_00 = 1;
  while(var_00) {
    var_01 = lib_0547::func_408F();
    var_00 = 0;
    foreach(var_03 in var_01) {
      if(!var_03 func_3E77()) {
        var_00 = 1;
        break;
      }
    }

    wait(0.125);
  }
}

func_10DB(param_00, param_01) {
  var_02 = func_459C(param_01);
  var_02.var_65FB = param_00;
  param_00.var_9B61 = var_02;
  param_00 func_8604(var_02);
}

func_AC05(param_00, param_01) {
  return !param_00.size < param_01;
}

func_9E10(param_00, param_01) {
  var_02 = func_9E0B(param_01);
  if(isDefined(var_02)) {
    func_10CD(param_00, var_02, self);
  }
}

func_ABF5(param_00) {
  return !param_00 func_A7F4() || param_00 func_A7F2();
}

func_1172(param_00) {
  return param_00.size > 0;
}

func_50A4() {
  return isDefined(self.var_9ACD) && common_scripts\utility::func_562E(self.var_9ACD == "ignore the tower");
}

func_8419(param_00) {
  if(!isDefined(self.var_9ACD) || !self.var_9ACD == "travel to attack" || self.var_9ACD == "attacking point") {
    func_8603(param_00);
  }
}

func_23D5() {
  self.var_65FB = undefined;
}

func_412A(param_00) {
  var_01 = 0;
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.var_AB4E.size; var_03++) {
    var_04 = param_00.var_AB4E[var_03].var_65FB;
    if(isDefined(var_04) && isalive(var_04)) {
      var_02 = common_scripts\utility::func_0F6F(var_02, var_04);
    }
  }

  return var_02;
}

func_8F14(param_00, param_01) {
  foreach(var_03 in level.var_744A) {
    if(distance(param_00, var_03.var_0116) < param_01) {
      return 1;
    }
  }

  return 0;
}

func_425A(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    var_04 = lib_0547::func_4090(param_00[var_03]);
    var_02 = common_scripts\utility::func_0F73(var_02, var_04);
  }

  var_02 = common_scripts\utility::func_40B0(param_01, var_02);
  return var_02;
}

func_4082(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    var_03 = param_00[var_02] maps\mp\mp_zombie_nest_ee_util::func_442B();
    if(isDefined(var_03)) {
      var_01 = common_scripts\utility::func_0F6F(var_01, param_00[var_02]);
    }
  }

  return var_01;
}

func_10CD(param_00, param_01, param_02) {
  if(!func_7590(param_00, param_01.var_7588.var_AB4E)) {
    param_00.var_9B61 = param_01.var_9110;
    param_00.var_60D0 = 1;
    param_01.var_9110.var_65FB = param_00;
  }
}

func_52DD(param_00) {
  for(var_01 = 0; var_01 < self.size; var_01++) {
    var_02 = param_00.var_38C4["objectiveHealth"];
    self[var_01].var_AB4E = common_scripts\utility::func_46B7(self[var_01].var_01A2, "targetname");
    for(var_03 = 0; var_03 < self[var_01].var_AB4E.size; var_03++) {
      self[var_01].var_AB4E[var_03].var_38B2 = param_00.var_38C3;
      self[var_01].var_AB4E[var_03].var_69A5 = 0;
    }

    self[var_01].var_28FC = 0;
    self[var_01].var_28FF = var_02;
    self[var_01].var_6057 = var_02;
    if(isDefined(self[var_01].var_65E8)) {
      foreach(var_05 in self[var_01].var_65E8) {
        var_06 = common_scripts\utility::func_4461(var_05.var_0116, param_00.var_ABEA.var_1176, 250);
        if(isDefined(var_06)) {
          var_05.var_65DE = var_06;
        }
      }
    }
  }
}

func_459C(param_00) {
  for(var_01 = 0; var_01 < param_00.size; var_01++) {
    if(param_00[var_01] maps\mp\mp_zombie_nest_ee_util::func_996A()) {
      return param_00[var_01];
    }
  }

  return common_scripts\utility::func_7A33(param_00);
}

func_7590(param_00, param_01) {
  for(var_02 = 0; var_02 < param_01.size; var_02++) {
    if(param_01[var_02] func_7591(param_00)) {
      return 1;
    }
  }

  return 0;
}

func_7591(param_00) {
  return isDefined(self.var_65FB) && isalive(self.var_65FB) && self.var_65FB == param_00;
}

func_9E0B(param_00) {
  var_01 = spawnStruct();
  var_01.var_7588 = param_00;
  var_01.var_9110 = var_01.var_7588 maps\mp\mp_zombie_nest_ee_util::func_442B();
  if(isDefined(var_01.var_7588) && isDefined(var_01.var_9110)) {
    return var_01;
  }

  return undefined;
}