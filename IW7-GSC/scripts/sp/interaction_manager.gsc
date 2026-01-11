/**********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\interaction_manager.gsc
**********************************************/

func_9A2F() {
  level.var_9A2E = spawnStruct();
  level.var_9A2E.var_4D94 = [];
  level.var_9A2E.var_4D94["actors"] = [];
  level.var_9A2E.var_4D94["registered_interactions"] = [];
  level.var_9A2E.var_4D94["registered_state_interactions"] = [];
  reminder_queue_cleanup();
  level.var_9A2E.var_1C4D = 1;
  level.var_9A2E.var_3840 = 1;
  level.var_9A2E.var_C9C3 = 0;
  level.var_9A2E.var_4D94["reminder_queue"] = [];
}

func_1100A() {
  func_DDE1();
  foreach(var_01 in level.var_9A2E.var_4D94["actors"]) {
    var_01.var_1C4D = 0;
    var_01.var_1C48 = 0;
  }
}

func_11009() {
  if(scripts\engine\utility::array_contains(level.var_9A2E.var_4D94["actors"], self)) {
    self.var_1C4D = 0;
    self.var_1C48 = 0;
  }
}

func_45A7() {
  func_DDE1();
  foreach(var_01 in level.var_9A2E.var_4D94["actors"]) {
    var_01.var_1C4D = 1;
    var_01.var_1C48 = 1;
  }
}

func_45A6() {
  if(scripts\engine\utility::array_contains(level.var_9A2E.var_4D94["actors"], self)) {
    self.var_1C4D = 1;
    self.var_1C48 = 1;
  }
}

func_12753() {
  self endon("death");
  if(isDefined(self.var_B004)) {
    self.var_B004["interaction_trigger_override"] = 1;
  }
}

func_12755(param_00) {
  self endon("death");
  foreach(var_02 in param_00) {
    if(isDefined(var_02.var_B004)) {
      var_02.var_B004["interaction_trigger_override"] = 1;
    }
  }
}

func_12754() {
  self endon("death");
  var_00 = self.var_B004["common_name"];
  var_01 = level.var_9A2E.var_4D94["actors"];
  foreach(var_03 in var_01) {
    if(isDefined(var_03.var_B004["common_name"])) {
      if(var_03.var_B004["common_name"] == var_00) {
        var_03.var_B004["interaction_trigger_override"] = 1;
      }
    }
  }
}

func_DDE1() {
  foreach(var_01 in level.var_9A2E.var_4D94["actors"]) {
    if(!isDefined(var_01)) {
      level.var_9A2E.var_4D94["actors"] = ::scripts\engine\utility::array_remove(level.var_9A2E.var_4D94["actors"], var_01);
    }
  }
}

func_168F() {
  if(isDefined(level.var_9A2E)) {
    if(!scripts\engine\utility::array_contains(level.var_9A2E.var_4D94["actors"], self)) {
      level.var_9A2E.var_4D94["actors"] = ::scripts\engine\utility::array_add(level.var_9A2E.var_4D94["actors"], self);
    }
  }
}

func_DFB5() {
  if(isDefined(level.var_9A2E)) {
    level.var_9A2E.var_4D94["actors"] = ::scripts\engine\utility::array_remove(level.var_9A2E.var_4D94["actors"], self);
  }
}

func_3839(param_00) {
  var_01 = level.player.origin;
  if(isDefined(param_00)) {
    var_02 = param_00;
  } else {
    var_02 = 140;
  }

  if(!isDefined(level.var_9A2E)) {
    return 1;
  }

  if(isDefined(self.var_1C4D) && !self.var_1C4D) {
    return 0;
  }

  func_DDE1();
  foreach(var_04 in level.var_9A2E.var_4D94["actors"]) {
    if(isDefined(var_04) && isDefined(self)) {
      if(distance(self.origin, var_04.origin) < var_02) {
        if(scripts\sp\utility::hastag(var_04.model, "j_spine4") && level.player scripts\sp\utility::func_D637(var_04 gettagorigin("j_spine4"))) {
          if(isDefined(var_04.var_9C84) && var_04.var_9C84) {
            return 0;
          }
        }
      }
    }
  }

  return 1;
}

func_3838(param_00) {
  var_01 = level.player.origin;
  if(isDefined(param_00)) {
    var_02 = param_00;
  } else {
    var_02 = 140;
  }

  if(!isDefined(level.var_9A2E)) {
    return 1;
  }

  func_DDE1();
  foreach(var_04 in level.var_9A2E.var_4D94["actors"]) {
    if(isDefined(var_04) && isDefined(self)) {
      if(self != var_04) {
        if(distance(self.origin, var_04.origin) < var_02) {
          if(scripts\engine\utility::within_fov(level.player getEye(), level.player.angles, var_04 gettagorigin("j_spine4"), cos(45))) {
            if((isDefined(var_04.var_D4A4) && var_04.var_D4A4) || isDefined(var_04.var_9CE2) && var_04.var_9CE2) {
              return 0;
            }

            if(isDefined(var_04.var_1C48) && !var_04.var_1C48) {
              return 0;
            }
          }
        }
      }
    }
  }

  return 1;
}

func_9A0E(param_00) {
  if(isDefined(level.var_9A2E)) {
    if(isDefined(param_00.var_1C4D) && !param_00.var_1C4D) {
      return;
    }

    func_DDE1();
    foreach(var_02 in level.var_9A2E.var_4D94["actors"]) {
      if(isDefined(var_02)) {
        var_02.var_1C4D = 0;
      }
    }

    for(;;) {
      var_04 = length(level.player.origin - level.player getEye());
      var_05 = param_00.origin + anglestoup(param_00.angles) * var_04;
      if(!level.player scripts\sp\utility::func_D1DF(var_05, 0.7, 1)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    func_DDE1();
    param_00.var_1C4D = 1;
    foreach(var_02 in level.var_9A2E.var_4D94["actors"]) {
      if(isDefined(var_02)) {
        var_02.var_1C4D = 1;
      }
    }
  }
}

func_9A39() {
  self endon("death");
  if(isDefined(level.var_9A2E)) {
    if(isDefined(self.var_1C4D) && !self.var_1C4D) {
      return;
    }

    self.var_1C4D = 0;
    wait(20);
    for(;;) {
      if(isDefined(self.var_DD49) && self.var_DD49 != "nag" && self.var_DD49 != "busy") {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    for(;;) {
      var_00 = length(level.player.origin - level.player getEye());
      var_01 = self.origin + anglestoup(self.angles) * var_00;
      if(!level.player scripts\sp\utility::func_D1DF(var_01, 0.7, 1)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    self.var_1C4D = 1;
  }
}

remind_calltrain_sethot(param_00) {
  level endon("stop_reminders");
  level endon("reboot_timer");
  level.var_9A2E.var_3840 = 0;
  wait(param_00);
  level.var_9A2E.var_3840 = 1;
}

func_DB7B(param_00, param_01, param_02) {
  if(!isDefined(param_00) && isDefined(param_01)) {
    param_00 = "none";
  }

  if(isDefined(param_01)) {
    param_00 = param_00 + "+" + param_01;
  }

  level.var_9A2E.var_4D94["reminder_queue"][param_00] = self;
  if(isDefined(param_02)) {
    self.remind_calltrain = param_02;
  }
}

func_DB7C(param_00, param_01, param_02, param_03) {
  if(isDefined(param_00)) {
    param_00 = param_00 + "+" + param_01;
  } else {
    param_00 = param_01;
  }

  level.var_9A2E.var_4D94["reminder_queue"][param_00] = self;
  if(isDefined(param_02)) {
    self.remind_calltrain = param_02;
  }

  self.var_13007 = 1;
  if(isDefined(param_03)) {
    self.var_E40E = param_03;
  }
}

func_DB7D(param_00, param_01, param_02, param_03) {
  func_DB7B(param_00);
  self.var_13008 = 1;
  self.var_DEED = param_02;
  self.var_D6E3 = param_03;
  self.reminder_cooldown_timer = param_01;
}

func_E815(param_00) {
  level endon("stop_reminders");
  level thread reminder_animnode();
  var_01 = getarraykeys(level.var_9A2E.var_4D94["reminder_queue"]);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_03 = var_01[var_02];
    var_04 = level.var_9A2E.var_4D94["reminder_queue"][var_03];
    if(isDefined(var_04)) {
      var_05 = strtok(var_03, "+");
      var_06 = var_05[0];
      if(isDefined(var_04.var_13008) && var_04.var_13008) {
        if(isDefined(var_04.var_DEED) && isDefined(var_04.var_D6E3)) {
          var_04 thread scripts\sp\interaction::func_CE18(var_04.var_DEED, var_06, var_04.var_D6E3);
        } else if(isDefined(self.var_D6E0) && isDefined(self.var_D6E2)) {
          self thread[[self.var_D6E0]](undefined, undefined, self.var_D6E2);
        } else {
          var_04 thread func_CD24(85, 50, var_06, 1, var_04.reminder_cooldown_timer);
        }
      } else if(isDefined(var_04.var_13007) && var_04.var_13007) {
        var_07 = undefined;
        var_08 = undefined;
        if(var_05.size > 1) {
          var_07 = var_05[1];
          var_08 = var_06;
        } else {
          var_07 = var_05[0];
        }

        if(isDefined(var_04.remind_calltrain)) {
          var_04.remind_calltrain thread func_CDDB(var_04, 85, 50, var_07, undefined, 1);
        } else {
          var_04 thread func_CDDB(var_04, 85, 50, var_07, undefined, 1);
        }
      }
    }
  }

  wait(param_00);
  while(level.var_9A2E.var_C9C3) {
    scripts\engine\utility::waitframe();
  }

  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_03 = var_01[var_02];
    var_04 = level.var_9A2E.var_4D94["reminder_queue"][var_03];
    if(isDefined(var_04)) {
      var_05 = strtok(var_03, "+");
      var_06 = var_05[0];
      if(var_05.size > 1) {
        if(isDefined(var_04.remind_calltrain)) {
          var_04.remind_calltrain notify("stop_loop");
          var_04.remind_calltrain thread scripts\sp\anim::func_1F35(var_04, var_05[1]);
          var_09 = getanimlength(var_04 scripts\sp\utility::func_7DC1(var_05[1]));
          var_04 thread scripts\sp\utility::func_C12D("reminder_anim_done", var_09);
          if(isDefined(var_04.var_E40E)) {
            var_04.remind_calltrain scripts\engine\utility::delaythread(var_09, ::scripts\sp\anim::func_1EEA, var_04, var_04.var_E40E, "stop_loop");
          }
        } else {
          var_05 notify("stop_loop");
          var_05 thread scripts\sp\anim::func_1F35(var_05, var_06[1]);
          var_09 = getanimlength(var_05 scripts\sp\utility::func_7DC1(var_06[1]));
          var_04 thread scripts\sp\utility::func_C12D("reminder_anim_done", var_09);
          if(isDefined(var_04.var_E40E)) {
            var_04 scripts\engine\utility::delaythread(var_09, ::scripts\sp\anim::func_1EEA, var_04, var_04.var_E40E, "stop_loop");
          }
        }

        if(var_06 != "none") {
          if(!soundexists(var_06)) {
            var_04 lib_0B6A::func_EC0E(var_06);
          } else {
            var_04 scripts\sp\utility::func_10346(var_06);
          }
        }
      } else if(!soundexists(var_03)) {} else {
        var_04 scripts\sp\utility::func_10346(var_03);
      }

      var_04 notify("reminder_done");
      var_04.remind_calltrain = undefined;
      level.var_9A2E.var_4D94["reminder_queue"][var_03] = undefined;
      level.var_9A2E.var_3840 = 0;
      wait(param_00);
      level.var_9A2E.var_3840 = 1;
    }

    while(level.var_9A2E.var_C9C3) {
      scripts\engine\utility::waitframe();
    }
  }

  level notify("reminders_done");
}

reminder_animnode() {
  level scripts\engine\utility::waittill_any_3("stop_reminders", "reminders_done");
  level.var_9A2E.var_4D94["reminder_queue"] = [];
}

func_11037() {
  level notify("stop_reminders");
  level notify("reminders_done");
  level.var_9A2E.var_4D94["reminder_queue"] = [];
  func_DDE1();
  foreach(var_01 in level.var_9A2E.var_4D94["actors"]) {
    if(isDefined(var_01)) {
      var_01.var_13008 = undefined;
      var_01.var_DEED = undefined;
      var_01.var_D6E3 = undefined;
      var_01.reminder_cooldown_timer = undefined;
      var_01.remind_calltrain = undefined;
      var_01.var_13007 = undefined;
    }
  }
}

func_C9C4() {
  level.var_9A2E.var_C9C3 = 1;
}

func_45A9() {
  level.var_9A2E.var_C9C3 = 0;
}

func_CE40(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = "casual";
  }

  if(isDefined(self.gender) && issubstr(self.gender, "female")) {
    param_02 = "busy";
  }

  var_04 = param_00 + "_" + "casual";
  if(param_02 == "casual" || param_02 == "nag") {
    var_04 = param_00 + "_" + param_02;
  }

  self.var_DD4A = param_00;
  self.var_DD49 = param_02;
  if(param_02 == "nag") {
    thread scripts\sp\interaction::func_CD53(var_04, param_01);
    self.var_1C4D = 0;
    self.var_DD49 = param_02;
    thread scripts\sp\utility::func_77B9(0.7);
    thread func_DD45();
    thread func_DD4B(param_03, 1);
    return;
  } else if(param_02 == "busy") {
    thread scripts\sp\interaction::func_CD53(var_04, param_01);
    self.var_1C4D = 0;
    self.var_DD49 = param_02;
    thread scripts\sp\utility::func_77B9(0.7);
    thread func_DD45();
    thread func_DD4B(param_03);
    return;
  }

  thread scripts\sp\interaction::func_CD53(var_04, param_01);
}

func_11048() {
  if(!isDefined(self.var_9B89)) {
    thread scripts\sp\interaction::func_9A0F();
  } else {
    self notify("reaction_end");
  }

  self notify("change_reaction_state");
  self.var_DD49 = undefined;
  self.var_1C4D = undefined;
  self.var_DD4A = undefined;
  thread scripts\sp\utility::func_77B9(0.7);
}

func_F566(param_00, param_01) {
  if(!isDefined(self.var_DD49)) {
    return;
  }

  if(!isDefined(param_00)) {
    return;
  }

  if(!isDefined(self.var_DD4A)) {
    return;
  }

  self notify("change_reaction_state");
  self notify("stop_reaction_look");
  if(param_00 != "nag" && param_00 != "busy") {
    self.var_1C4D = 1;
    thread scripts\sp\utility::func_77B9(0.7);
    self.var_9A30 = self.var_DD4A + "_" + param_00;
    self.var_DD49 = param_00;
    return;
  }

  if(param_00 == "nag") {
    self.var_1C4D = 0;
    self.var_DD49 = param_00;
    thread scripts\sp\utility::func_77B9(0.7);
    thread func_DD45();
    thread func_DD4B(param_01, 1);
    return;
  }

  self.var_1C4D = 0;
  self.var_DD49 = param_00;
  thread scripts\sp\utility::func_77B9(0.7);
  thread func_DD45();
  thread func_DD4B(param_01);
}

func_DD4B(param_00, param_01) {
  self endon("change_reaction_state");
  for(;;) {
    thread func_77B1(param_00, param_01);
    self waittill("end_gesture_reaction_distance_based");
    for(;;) {
      if(distance2d(self.origin, level.player.origin) >= level.var_10E1C[self.var_9A30].var_EBEA["trigger_radius"] + 50) {
        break;
      }

      scripts\engine\utility::waitframe();
    }
  }
}

func_F2A7(param_00, param_01) {
  switch (param_00) {
    case "busy":
    case "alert":
    case "nag":
    case "casual":
      foreach(var_03 in level.var_9A2E.var_4D94["actors"]) {
        var_03 thread func_F566(param_00, param_01);
      }
      break;
  }
}

func_DD45(param_00, param_01, param_02, param_03) {
  self endon("death");
  self notify("stop_reaction_look");
  self endon("stop_reaction_look");
  self endon("stop_smart_reaction");
  var_04 = 85;
  if(isDefined(param_00)) {
    var_04 = param_00;
  }

  if(!isDefined(param_01)) {
    param_01 = level.player;
  }

  if(!isDefined(param_02)) {
    param_02 = 0.7;
  }

  wait(param_02);
  if(isDefined(self.var_DD4A)) {
    if(isDefined(level.var_10E1C[self.var_9A30].var_EBEA["trigger_radius"])) {
      var_04 = level.var_10E1C[self.var_9A30].var_EBEA["trigger_radius"] * 1.2;
    }
  }

  scripts\engine\utility::waitframe();
  if(isDefined(param_03) && param_03) {
    thread scripts\sp\utility::func_7799(param_01, 0.5, 0.5);
  } else {
    thread scripts\sp\utility::func_779A(param_01, 0.5, 0.5, var_04);
  }

  while(!isDefined(self.var_9BFC)) {
    wait(0.05);
  }

  thread scripts\sp\utility::func_7798(param_01);
  wait(randomfloatrange(4, 6));
  var_05 = 1;
  var_06 = 1;
  for(;;) {
    if(distance2d(self.origin, param_01.origin) <= var_04) {
      if(!var_06) {
        thread lib_0C4C::func_195B(0.5);
        thread scripts\sp\utility::func_7798(param_01);
        var_06 = 1;
      }
    } else if(distance2d(self.origin, param_01.origin) >= var_04) {
      if(var_06) {
        thread lib_0C4C::func_195A(1);
        thread scripts\sp\utility::func_7793(0.7);
        var_06 = 0;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_77B1(param_00, param_01) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_reaction_look");
  var_02 = 50;
  if(isDefined(self.var_DD4A)) {
    if(isDefined(level.var_10E1C[self.var_9A30].var_EBEA["trigger_radius"])) {
      var_02 = level.var_10E1C[self.var_9A30].var_EBEA["trigger_radius"];
    }
  }

  func_13775(var_02);
  thread scripts\sp\utility::func_77B7("salute");
  var_03 = undefined;
  if(isDefined(param_01) && param_01) {
    switch (param_00) {
      case "dropship":
      case "bridge_elev":
      case "bridge_elev_doors":
      case "cic":
      case "ftl":
      case "opsmap":
      case "captains":
      case "lounge":
      case "bridge":
      case "jackal":
        var_04 = level.var_9A2E.var_4D94["reminder_vo"][param_00][self.gender];
        var_05 = level.var_9A2E.var_4D94["reminder_vo"][param_00]["spent_" + self.gender];
        if(var_04.size < 1 && var_05.size > 0) {
          level.var_9A2E.var_4D94["reminder_vo"][param_00][self.gender] = var_05;
          level.var_9A2E.var_4D94["reminder_vo"][param_00]["spent_" + self.gender] = [];
          var_04 = level.var_9A2E.var_4D94["reminder_vo"][param_00][self.gender];
          var_05 = level.var_9A2E.var_4D94["reminder_vo"][param_00]["spent_" + self.gender];
        }

        if(var_04.size < 1 && var_05.size < 1) {
          var_03 = undefined;
        } else {
          var_03 = var_04[randomint(var_04.size)];
          level.var_9A2E.var_4D94["reminder_vo"][param_00]["spent_" + self.gender] = ::scripts\engine\utility::array_add(level.var_9A2E.var_4D94["reminder_vo"][param_00]["spent_" + self.gender], var_03);
          level.var_9A2E.var_4D94["reminder_vo"][param_00][self.gender] = ::scripts\engine\utility::array_remove(level.var_9A2E.var_4D94["reminder_vo"][param_00][self.gender], var_03);
        }
        break;
    }
  } else {
    var_04 = level.var_9A2E.var_4D94["busy_vo"][self.gender];
    var_05 = level.var_9A2E.var_4D94["busy_vo"]["spent_" + self.gender];
    if(var_04.size < 1 && var_05.size > 0) {
      level.var_9A2E.var_4D94["busy_vo"][self.gender] = var_05;
      level.var_9A2E.var_4D94["busy_vo"]["spent_" + self.gender] = [];
      var_04 = level.var_9A2E.var_4D94["busy_vo"][self.gender];
      var_05 = level.var_9A2E.var_4D94["busy_vo"]["spent_" + self.gender];
    }

    if(var_04.size < 1 && var_05.size < 1) {
      var_03 = undefined;
    } else {
      var_03 = var_04[randomint(var_04.size)];
      level.var_9A2E.var_4D94["busy_vo"]["spent_" + self.gender] = ::scripts\engine\utility::array_add(level.var_9A2E.var_4D94["busy_vo"]["spent_" + self.gender], var_03);
      level.var_9A2E.var_4D94["busy_vo"][self.gender] = ::scripts\engine\utility::array_remove(level.var_9A2E.var_4D94["busy_vo"][self.gender], var_03);
    }
  }

  if(isDefined(var_03)) {
    scripts\sp\utility::func_10346(var_03);
    if(isDefined(param_01) && param_01) {
      level thread remind_calltrain_sethot(90);
    }
  }

  self.var_D4A4 = 1;
  self notify("end_gesture_reaction_distance_based");
  wait(15);
  self.var_D4A4 = 0;
}

func_D903() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  for(;;) {
    if(isDefined(self.var_1C48)) {}

    if(isDefined(self.gender)) {}

    if(isDefined(self.var_1FBB)) {}

    scripts\engine\utility::waitframe();
  }
}

func_CD24(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_gesture_reaction");
  self endon("stop_smart_reaction");
  thread func_168F();
  if(isDefined(self.var_1C48) && !self.var_1C48) {
    self.var_1C48 = 1;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(!isDefined(param_00)) {
    param_00 = 150;
  }

  if(!isDefined(param_01)) {
    param_01 = param_00 * 0.5;
  }

  if(!isDefined(self.var_9BFC) || isDefined(self.var_9BFC) && !self.var_9BFC) {
    thread func_DD45(param_00);
  }

  func_13775(param_01);
  func_CD25(param_04);
  func_CD52(param_02, param_03);
}

func_13775(param_00) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_gesture_reaction");
  self endon("stop_smart_reaction");
  var_01 = 1;
  for(;;) {
    if(func_9EED(param_00) && func_38F2(param_00)) {
      var_02 = scripts\engine\utility::flatten_vector(anglestoright(self gettagangles("j_head")));
      var_03 = scripts\engine\utility::flatten_vector(vectornormalize(level.player getEye() - self gettagorigin("j_head")));
      var_04 = vectordot(var_02, var_03);
      if(var_04 >= 0.8) {
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_9EED(param_00) {
  self endon("death");
  if(isDefined(self.var_9B89)) {
    var_01 = self gettagorigin("j_head");
  } else if(isai(self)) {
    var_01 = self getEye();
  } else if(isDefined(self.origin)) {
    var_01 = self.origin;
  } else {
    return 0;
  }

  var_02 = level.player getEye();
  var_03 = level.player getplayerangles();
  if(distance2d(self.origin, level.player.origin) <= param_00) {
    if(scripts\engine\utility::within_fov(var_02, var_03, var_01, cos(25))) {
      return 1;
    }
  }

  return 0;
}

func_38F2(param_00) {
  if(!isDefined(self.var_1C48) || isDefined(self.var_1C48) && self.var_1C48) {
    if(!isDefined(self.var_77B2)) {
      if(func_3838(param_00)) {
        return 1;
      }
    }
  }

  return 0;
}

func_CD25(param_00) {
  self.var_D4A4 = 1;
  if(!isDefined(self.var_9B89)) {
    if(isDefined(param_00)) {
      thread scripts\sp\utility::func_77A9(param_00);
    } else {
      thread scripts\sp\utility::func_77B7("salute");
    }
  } else {
    scripts\sp\utility::func_7790( % shipcrib_gst_head_salute_01);
  }

  self.var_D4A4 = undefined;
}

func_CD52(param_00, param_01) {
  if(isDefined(param_00)) {
    if(isDefined(param_01) && param_01) {
      func_7286(30);
      func_4177(param_00);
    }

    func_509C(param_00);
    self.var_9CE2 = 1;
    func_CE17(param_00);
    self.var_9CE2 = undefined;
  }
}

func_509C(param_00) {
  if(!isDefined(self.var_1FBB)) {
    self.var_1FBB = "generic";
  }

  if(!isDefined(level.var_EC88[self.var_1FBB])) {
    level.var_EC88[self.var_1FBB] = [];
  }

  if(isarray(param_00)) {
    foreach(var_02 in param_00) {
      if(!isDefined(level.var_EC88[self.var_1FBB][var_02])) {
        if(isDefined(level.var_FDBF) && isDefined(self.gender)) {
          if(isDefined(level.var_FDBF[self.gender]) && isDefined(level.var_FDBF[self.gender][var_02])) {
            level.var_EC88[self.var_1FBB][var_02] = level.var_FDBF[self.gender][var_02];
          }
        }
      }
    }

    return;
  }

  if(!isDefined(level.var_EC88[self.var_1FBB][param_00])) {
    if(isDefined(level.var_FDBF) && isDefined(self.gender)) {
      if(isDefined(level.var_FDBF[self.gender]) && isDefined(level.var_FDBF[self.gender][param_00])) {
        level.var_EC88[self.var_1FBB][param_00] = level.var_FDBF[self.gender][param_00];
        return;
      }

      return;
    }
  }
}

func_CE17(param_00) {
  var_01 = undefined;
  if(isarray(param_00)) {
    for(var_02 = 0; var_02 < param_00.size; var_02++) {
      var_03 = param_00[var_02];
      if(isstring(var_03)) {
        func_509C(var_03);
        if(!soundexists(var_03)) {
          if(!scripts\engine\utility::flag_exist("e3_europa_demo")) {
            lib_0B6A::func_EC0E(var_03);
          }
        } else if(issubstr(var_03, "plr")) {
          level.player scripts\sp\utility::func_1034D(var_03);
        } else {
          var_01 = func_B19B(var_03);
          if(isDefined(var_01)) {
            var_01 scripts\sp\utility::func_10346(var_03);
          } else {
            scripts\sp\utility::func_10346(var_03);
          }
        }

        continue;
      }

      if(isnumber(var_03)) {
        wait(var_03);
      }
    }

    return;
  }

  var_03 = var_01;
  if(isstring(var_03)) {
    func_509C(var_03);
    if(!soundexists(var_03)) {
      if(!scripts\engine\utility::flag_exist("e3_europa_demo")) {
        lib_0B6A::func_EC0E(var_03);
        return;
      }

      return;
    }

    if(issubstr(var_03, "plr")) {
      level.player scripts\sp\utility::func_1034D(var_03);
      return;
    }

    var_01 = func_B19B(var_03);
    if(isDefined(var_01)) {
      var_01 scripts\sp\utility::func_10346(var_03);
      return;
    }

    scripts\sp\utility::func_10346(var_03);
    return;
  }
}

func_7286(param_00) {
  level notify("reboot_timer");
  scripts\engine\utility::waitframe();
  level thread remind_calltrain_sethot(param_00);
}

func_4177(param_00) {
  if(isDefined(level.var_9A2E)) {
    if(isDefined(level.var_9A2E.var_4D94["reminder_queue"])) {
      if(scripts\engine\utility::array_contains(level.var_9A2E.var_4D94["reminder_queue"], self)) {
        level.var_9A2E.var_4D94["reminder_queue"][param_00] = undefined;
        return;
      }
    }
  }
}

func_CD37(param_00, param_01, param_02, param_03) {
  foreach(var_05 in param_00) {
    var_05 endon("death");
    var_05 endon("stop_reaction");
    var_05 endon("reaction_end");
    var_05 endon("stop_gesture_reaction");
    var_05 endon("stop_smart_reaction");
  }

  foreach(var_05 in param_00) {
    var_05 thread func_168F();
  }

  thread func_DD43(param_00, param_01);
  func_1377E(param_00, param_02);
  func_CD36(param_00, param_03, param_02);
  foreach(var_05 in param_00) {
    var_0A = randomfloatrange(0, 1);
    var_0B = randomfloatrange(0.5, 1.5);
    var_05 scripts\engine\utility::delaythread(var_0A, ::scripts\sp\utility::func_77B9, var_0B);
  }
}

func_1377E(param_00, param_01) {
  var_02 = 1;
  var_03 = func_491D(param_00);
  param_00 = scripts\engine\utility::array_add(param_00, var_03);
  while(var_02) {
    foreach(var_05 in param_00) {
      if(var_05 func_9EED(param_01)) {
        var_02 = 0;
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_491D(param_00) {
  var_01 = 0;
  var_02 = (0, 0, 0);
  foreach(var_04 in param_00) {
    var_02 = var_02 + var_04.origin;
    var_01++;
  }

  var_06 = var_02 / var_01;
  var_07 = scripts\engine\utility::spawn_tag_origin(var_06, (0, 0, 0));
  return var_07;
}

func_CD36(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    if(isDefined(param_00[var_03]) && isDefined(param_01[var_03])) {
      param_00[var_03] func_CD25();
      param_00[var_03] func_CD52(param_01[var_03]);
    }

    if(!func_8694(param_02, param_00)) {
      break;
    }
  }
}

func_8694(param_00, param_01) {
  foreach(var_03 in param_01) {
    if(var_03 func_9EED(param_00)) {
      return 1;
    }
  }

  return 0;
}

func_DD43(param_00, param_01, param_02) {
  foreach(var_04 in param_00) {
    var_04 endon("death");
    var_04 endon("stop_reaction");
    var_04 endon("reaction_end");
    var_04 endon("stop_reaction_look");
    var_04 endon("stop_smart_reaction");
  }

  var_06 = 85;
  if(isDefined(param_01)) {
    var_06 = param_01;
  }

  if(!isDefined(param_02)) {
    param_02 = level.player;
  }

  func_9856(param_00, param_02);
  var_07 = func_491D(param_00);
  for(;;) {
    func_12DE3(param_00, var_07, param_02, param_01);
    func_12DE4(param_00);
    func_12DE2(param_00);
    scripts\engine\utility::waitframe();
  }
}

func_9856(param_00, param_01) {
  foreach(var_03 in param_00) {
    var_03 scripts\sp\utility::func_7799(param_01, 0.15, 0.7);
    var_03.var_B009 = 0;
    var_03.var_B008 = 0;
  }

  scripts\engine\utility::waitframe();
  foreach(var_03 in param_00) {
    var_03 thread scripts\sp\utility::func_7792(param_01);
  }
}

func_12DE3(param_00, param_01, param_02, param_03) {
  if(distance2d(param_01.origin, param_02.origin) <= param_03) {
    func_6216(param_00);
    return;
  }

  func_5551(param_00);
}

func_6216(param_00) {
  foreach(var_02 in param_00) {
    if(!var_02.var_B009) {
      var_02 func_4915();
    }

    var_02.var_B009 = 1;
  }
}

func_5551(param_00) {
  foreach(var_02 in param_00) {
    if(var_02.var_B009) {
      var_02 func_4915();
    }

    var_02.var_B009 = 0;
  }
}

func_12DE4(param_00) {
  foreach(var_02 in param_00) {
    if(var_02.var_B008 <= 0) {
      if(var_02.var_B009) {
        var_02 func_93EA();
        continue;
      }

      var_02 func_4FB7();
    }
  }
}

func_12DE2(param_00) {
  foreach(var_02 in param_00) {
    if(var_02.var_B008 > 0) {
      var_02.var_B008 = var_02.var_B008 - 0.05;
    }
  }
}

func_4915() {
  self.var_B008 = randomfloatrange(0, 1);
}

func_4168() {
  self.var_B008 = 0;
}

func_93EA() {
  thread lib_0C4C::func_195B(0.7);
}

func_4FB7() {
  thread lib_0C4C::func_195A(0.7);
}

func_45FB(param_00) {
  if(!isarray(param_00)) {
    return [param_00];
  }

  return param_00;
}

func_CD26(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  var_05 = [];
  var_06 = param_02;
  for(;;) {
    if(var_06.size <= 0) {
      var_05 = [];
      var_06 = param_02;
    }

    var_07 = var_06[randomint(var_06.size)];
    func_CD24(param_00, param_01, var_07, param_03, param_04);
    for(;;) {
      if(distance2d(self.origin, level.player.origin) >= param_00) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    scripts\engine\utility::waitframe();
    var_05 = scripts\engine\utility::array_add(var_05, var_07);
    var_06 = scripts\engine\utility::array_remove(var_06, var_07);
  }
}

func_10FF9() {
  self notify("stop_gesture_reaction");
  self notify("stop_reaction_look");
  self notify("stop_gesture_reaction_set");
  self.var_77B2 = undefined;
  scripts\sp\utility::func_77B9(0.7);
}

func_11035() {
  self notify("stop_smart_reaction");
  thread scripts\sp\interaction::func_9A0F();
}

func_DB71(param_00) {
  if(!isDefined(self.var_77B2)) {
    self.var_77B2 = [];
  }

  var_01 = param_00;
  if(isarray(param_00)) {
    var_01 = param_00[0];
  }

  self.var_77B2[var_01] = param_00;
}

func_CD27(param_00, param_01) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_gesture_reaction_set");
  self notify("stop_reaction_look");
  scripts\sp\utility::func_77B9(0.7);
  thread func_168F();
  self.var_1C48 = 1;
  if(!isDefined(param_00)) {
    param_00 = 150;
  }

  if(!isDefined(param_01)) {
    param_01 = param_00 * 0.5;
  }

  thread func_DD45(param_00);
  var_02 = getarraykeys(self.var_77B2);
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_04 = var_02[var_03];
    var_05 = self.var_77B2[var_04];
    for(;;) {
      if(!isDefined(self)) {
        return;
      }

      var_06 = length(level.player.origin - level.player getEye());
      var_07 = self.origin + anglestoup(self.angles) * var_06;
      if(level.player scripts\sp\utility::func_D1DF(var_07, 0.75, 1)) {
        if(distance2d(self.origin, level.player.origin) <= param_01 && func_3838(param_01)) {
          break;
        }
      }

      scripts\engine\utility::waitframe();
    }

    thread scripts\sp\utility::func_77B7("salute");
    self.var_1C48 = 0;
    if(isarray(var_05)) {
      for(var_08 = 0; var_08 < var_05.size; var_08++) {
        var_09 = var_05[var_08];
        if(isstring(var_09)) {
          func_509C(var_09);
          if(!soundexists(var_09)) {
            lib_0B6A::func_EC0E(var_09);
          } else if(issubstr(var_09, "plr")) {
            level.player scripts\sp\utility::func_1034D(var_09);
          } else {
            var_0A = func_B19B(var_09);
            if(isDefined(var_0A)) {
              var_0A scripts\sp\utility::func_10346(var_09);
            } else {
              scripts\sp\utility::func_10346(var_09);
            }
          }

          continue;
        }

        if(isnumber(var_09)) {
          wait(var_09);
        }
      }
    } else if(!soundexists(var_05)) {
      lib_0B6A::func_EC0E(var_05);
    } else {
      func_509C(var_05);
      var_0A = func_B19B(var_05);
      if(isDefined(var_0A)) {
        var_0A scripts\sp\utility::func_10346(var_05);
      } else {
        scripts\sp\utility::func_10346(var_05);
      }
    }

    self.var_77B2[var_04] = undefined;
    wait(5);
    self.var_1C48 = 1;
  }

  self.var_77B2 = undefined;
  if(isDefined(self.var_D6E0) && isDefined(self.var_D6E2)) {
    self thread[[self.var_D6E0]](undefined, undefined, self.var_D6E2);
  }
}

func_B19B(param_00) {
  var_01 = strtok(param_00, "_");
  if(scripts\engine\utility::array_contains(var_01, "nav") || scripts\engine\utility::array_contains(var_01, "gtr")) {
    return level.var_76FB;
  } else if(scripts\engine\utility::array_contains(var_01, "slt") || scripts\engine\utility::array_contains(var_01, "xo")) {
    return level.var_EA2C;
  } else if(scripts\engine\utility::array_contains(var_01, "bsw")) {
    if(level.script == "shipcrib_rogue" || level.script == "shipcrib_prisoner") {
      return level.var_10214;
    } else {
      return level.var_1044B;
    }
  } else if(scripts\engine\utility::array_contains(var_01, "cmo")) {
    return level.var_4451;
  } else if(scripts\engine\utility::array_contains(var_01, "dpo")) {
    return level.var_5CFC;
  }

  return undefined;
}

func_CDDB(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 endon("death");
  if(isDefined(param_00.var_D7D9)) {
    if(isDefined(param_00.var_D7DA)) {
      if(param_00.var_D7DA.size == 1) {
        param_00[[param_00.var_D7D9]](param_00.var_D7DA[0]);
      } else if(param_00.var_D7DA.size == 2) {
        param_00[[param_00.var_D7D9]](param_00.var_D7DA[0], param_00.var_D7DA[1]);
      } else if(param_00.var_D7DA.size == 3) {
        param_00[[param_00.var_D7D9]](param_00.var_D7DA[0], param_00.var_D7DA[1], param_00.var_D7DA[2]);
      }
    }
  }

  level endon("stop_reminders");
  level endon("reminders_done");
  param_00 thread func_168F();
  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  if(!isDefined(param_01)) {
    param_01 = 150;
  }

  if(!isDefined(param_02)) {
    param_02 = param_01 * 0.5;
  }

  if(!isDefined(param_00.var_9BFC) || isDefined(param_00.var_9BFC) && !param_00.var_9BFC) {
    param_00 thread func_DD45(param_01);
  }

  while(distance2d(param_00.origin, level.player.origin) <= param_01 + 25) {
    scripts\engine\utility::waitframe();
  }

  for(;;) {
    if(!isDefined(param_00)) {
      return;
    }

    var_06 = length(level.player.origin - level.player getEye());
    var_07 = param_00.origin + anglestoup(param_00.angles) * var_06;
    if(level.player scripts\sp\utility::func_D1DF(var_07, 0.75, 1)) {
      if(distance2d(param_00.origin, level.player.origin) <= param_02) {
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }

  self notify("stop_loop");
  thread scripts\sp\anim::func_1F35(param_00, param_03);
  var_08 = getanimlength(param_00 scripts\sp\utility::func_7DC1(param_03));
  thread scripts\sp\utility::func_C12D("reminder_anim_done", var_08);
  if(isDefined(param_00.var_E40E)) {
    scripts\engine\utility::delaythread(var_08, ::scripts\sp\anim::func_1EEA, param_00, param_00.var_E40E, "stop_loop");
  }

  if(isDefined(param_04)) {
    if(param_05) {
      level notify("reboot_timer");
      scripts\engine\utility::waitframe();
      level thread remind_calltrain_sethot(90);
      if(isDefined(level.var_9A2E)) {
        if(isDefined(level.var_9A2E.var_4D94["reminder_queue"])) {
          if(scripts\engine\utility::array_contains(level.var_9A2E.var_4D94["reminder_queue"], param_00)) {
            level.var_9A2E.var_4D94["reminder_queue"][param_04] = undefined;
          }
        }
      }
    }

    param_00 func_CE17(param_04);
  }

  if(isDefined(param_00.var_D6E0) && !isDefined(param_00.var_D6E2)) {
    if(isDefined(param_00.var_D6E1)) {
      if(param_00.var_D7DA.size == 1) {
        param_00[[param_00.var_D6E0]](param_00.var_D6E1[0]);
        return;
      }

      if(param_00.var_D7DA.size == 2) {
        param_00[[param_00.var_D6E0]](param_00.var_D6E1[0], param_00.var_D6E1[1]);
        return;
      }

      if(param_00.var_D7DA.size == 3) {
        param_00[[param_00.var_D6E0]](param_00.var_D6E1[0], param_00.var_D6E1[1], param_00.var_D6E1[2]);
        return;
      }

      return;
    }

    return;
  }

  if(isDefined(param_00.var_D6E0) && isDefined(param_00.var_D6E2)) {
    param_00 thread[[param_00.var_D6E0]](undefined, undefined, param_00.var_D6E2);
  }
}

reminder_queue_cleanup() {
  level.var_9A2E.var_4D94["reminder_vo"]["bridge"]["male_1"] = ["shipcrib_us1_wantedonbridge"];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge"]["male_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge"]["male_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge"]["spent_male_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge"]["spent_male_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge"]["spent_male_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge"]["female_1"] = ["shipcrib_us1_wantedonbridge"];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge"]["female_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge"]["female_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge"]["spent_female_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge"]["spent_female_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge"]["spent_female_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["lounge"]["male_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["lounge"]["male_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["lounge"]["male_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["lounge"]["spent_male_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["lounge"]["spent_male_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["lounge"]["spent_male_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["lounge"]["female_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["lounge"]["female_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["lounge"]["female_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["lounge"]["spent_female_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["lounge"]["spent_female_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["lounge"]["spent_female_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["captains"]["male_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["captains"]["male_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["captains"]["male_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["captains"]["spent_male_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["captains"]["spent_male_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["captains"]["spent_male_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["captains"]["female_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["captains"]["female_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["captains"]["female"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["captains"]["spent_female_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["captains"]["spent_female_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["captains"]["spent_female_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["opsmap"]["male_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["opsmap"]["male_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["opsmap"]["male_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["opsmap"]["spent_male_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["opsmap"]["spent_male_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["opsmap"]["spent_male_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["opsmap"]["female_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["opsmap"]["female_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["opsmap"]["female_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["opsmap"]["spent_female_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["opsmap"]["spent_female_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["opsmap"]["spent_female_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["ftl"]["male_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["ftl"]["male_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["ftl"]["male_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["ftl"]["spent_male_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["ftl"]["spent_male_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["ftl"]["spent_male_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["ftl"]["female_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["ftl"]["female_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["ftl"]["female_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["ftl"]["spent_female_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["ftl"]["spent_female_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["ftl"]["spent_female_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["cic"]["male_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["cic"]["male_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["cic"]["male_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["cic"]["spent_male_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["cic"]["spent_male_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["cic"]["spent_male_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["cic"]["female_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["cic"]["female_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["cic"]["female_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["cic"]["spent_female_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["cic"]["spent_female_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["cic"]["spent_female_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev_doors"]["male_1"] = ["shipcrib_un1_theyrewaitingfo", "shipcrib_un1_theyreattheelev"];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev_doors"]["male_2"] = ["shipcrib_un2_theyreneartheel", "shipcrib_un2_theyrenearthee"];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev_doors"]["male_3"] = ["shipcrib_un3_youreneededby", "shipcrib_un3_elevatordoorsa"];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev_doors"]["spent_male_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev_doors"]["spent_male_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev_doors"]["spent_male_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev_doors"]["female_1"] = ["shipcrib_unf1_theyrebythedoo", "shipcrib_unf1_theyrewaitingatt"];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev_doors"]["female_2"] = ["shipcrib_unf2_ithinktheyrewaitin", "shipcrib_unf2_gettotheelevatord"];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev_doors"]["female_3"] = ["shipcrib_unf3_theyrelookingfory", "shipcrib_unf3_elevatordoorsarea"];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev_doors"]["spent_female_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev_doors"]["spent_female_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev_doors"]["spent_female_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev"]["male_1"] = ["shipcrib_un1_youreneededbythe", "shipcrib_un1_youreneededbythee"];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev"]["male_2"] = ["shipcrib_un2_theyrewaitingforyo", "shipcrib_un2_theyneedyoubyt"];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev"]["male_3"] = ["shipcrib_un3_elevatorswaitinfo", "shipcrib_un3_elevatorswaitinfor"];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev"]["spent_male_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev"]["spent_male_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev"]["spent_male_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev"]["female_1"] = ["shipcrib_unf1_elevatorsreadytot", "shipcrib_unf1_elevatorsreadyfo"];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev"]["female_2"] = ["shipcrib_unf2_theyrereadyforyo", "shipcrib_unf2_theyrebytheelev"];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev"]["female_3"] = ["shipcrib_unf3_elevatorsreadya", "shipcrib_unf3_elevatorsaroundt"];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev"]["spent_female_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev"]["spent_female_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["bridge_elev"]["spent_female_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["dropship"]["male_1"] = ["shipcrib_un1_dropshipsfueled"];
  level.var_9A2E.var_4D94["reminder_vo"]["dropship"]["male_2"] = ["shipcrib_un2_yourdropshipisr"];
  level.var_9A2E.var_4D94["reminder_vo"]["dropship"]["male_3"] = ["shipcrib_un3_dropshipswaitingf"];
  level.var_9A2E.var_4D94["reminder_vo"]["dropship"]["spent_male_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["dropship"]["spent_male_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["dropship"]["spent_male_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["dropship"]["female_1"] = ["shipcrib_unf1_bossgibsonhasad"];
  level.var_9A2E.var_4D94["reminder_vo"]["dropship"]["female_2"] = ["shipcrib_unf2_dropshipsreadyto"];
  level.var_9A2E.var_4D94["reminder_vo"]["dropship"]["female_3"] = ["shipcrib_unf3_reportfromtheflight"];
  level.var_9A2E.var_4D94["reminder_vo"]["dropship"]["spent_female_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["dropship"]["spent_female_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["dropship"]["spent_female_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["jackal"]["male_1"] = ["shipcrib_un1_yourjackalisread"];
  level.var_9A2E.var_4D94["reminder_vo"]["jackal"]["male_2"] = ["shipcrib_un2_gibsonhasyourja"];
  level.var_9A2E.var_4D94["reminder_vo"]["jackal"]["male_3"] = ["shipcrib_un3_flightdeckreports"];
  level.var_9A2E.var_4D94["reminder_vo"]["jackal"]["spent_male_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["jackal"]["spent_male_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["jackal"]["spent_male_3"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["jackal"]["female_1"] = ["shipcrib_unf1_yourjackalsreadyin"];
  level.var_9A2E.var_4D94["reminder_vo"]["jackal"]["female_2"] = ["shipcrib_unf2_bossgibsonsaysc"];
  level.var_9A2E.var_4D94["reminder_vo"]["jackal"]["female_3"] = ["shipcrib_unf3_jackalsreadyandw"];
  level.var_9A2E.var_4D94["reminder_vo"]["jackal"]["spent_female_1"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["jackal"]["spent_female_2"] = [];
  level.var_9A2E.var_4D94["reminder_vo"]["jackal"]["spent_female_3"] = [];
  level.var_9A2E.var_4D94["busy_vo"]["male_1"] = ["shipcrib_un1_captain2", "shipcrib_un1_sir2"];
  level.var_9A2E.var_4D94["busy_vo"]["male_2"] = ["shipcrib_un2_weregoodheresi", "shipcrib_un2_sorrysirgotalottok"];
  level.var_9A2E.var_4D94["busy_vo"]["male_3"] = ["shipcrib_un3_gotthingsundercon", "shipcrib_un3_captain"];
  level.var_9A2E.var_4D94["busy_vo"]["spent_male_1"] = [];
  level.var_9A2E.var_4D94["busy_vo"]["spent_male_2"] = [];
  level.var_9A2E.var_4D94["busy_vo"]["spent_male_3"] = [];
  level.var_9A2E.var_4D94["busy_vo"]["female_1"] = ["shipcrib_unf2_captain", "shipcrib_unf2_youllhavetoexcus"];
  level.var_9A2E.var_4D94["busy_vo"]["female_2"] = ["shipcrib_unf2_captain", "shipcrib_unf2_youllhavetoexcus"];
  level.var_9A2E.var_4D94["busy_vo"]["female_3"] = ["shipcrib_unf3_captainreyes", "shipcrib_unf3_sir"];
  level.var_9A2E.var_4D94["busy_vo"]["spent_female_1"] = [];
  level.var_9A2E.var_4D94["busy_vo"]["spent_female_2"] = [];
  level.var_9A2E.var_4D94["busy_vo"]["spent_female_3"] = [];
}