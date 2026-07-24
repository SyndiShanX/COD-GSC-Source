/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2884.gsc
**************************************/

_id_9A2F() {
  level._id_9A2E = spawnStruct();
  level._id_9A2E._id_4D94 = [];
  level._id_9A2E._id_4D94["actors"] = [];
  level._id_9A2E._id_4D94["registered_interactions"] = [];
  level._id_9A2E._id_4D94["registered_state_interactions"] = [];
  reminder_queue_cleanup();
  level._id_9A2E._id_1C4D = 1;
  level._id_9A2E._id_3840 = 1;
  level._id_9A2E._id_C9C3 = 0;
  level._id_9A2E._id_4D94["reminder_queue"] = [];
}

_id_1100A() {
  _id_DDE1();

  foreach(var_1 in level._id_9A2E._id_4D94["actors"]) {
    var_1._id_1C4D = 0;
    var_1._id_1C48 = 0;
  }
}

_id_11009() {
  if(scripts\engine\utility::array_contains(level._id_9A2E._id_4D94["actors"], self)) {
    self._id_1C4D = 0;
    self._id_1C48 = 0;
  }
}

_id_45A7() {
  _id_DDE1();

  foreach(var_1 in level._id_9A2E._id_4D94["actors"]) {
    var_1._id_1C4D = 1;
    var_1._id_1C48 = 1;
  }
}

_id_45A6() {
  if(scripts\engine\utility::array_contains(level._id_9A2E._id_4D94["actors"], self)) {
    self._id_1C4D = 1;
    self._id_1C48 = 1;
  }
}

_id_12753() {
  self endon("death");

  if(isDefined(self._id_B004)) {
    self._id_B004["interaction_trigger_override"] = 1;
  }
}

_id_12755(var_0) {
  self endon("death");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_B004)) {
      var_2._id_B004["interaction_trigger_override"] = 1;
    }
  }
}

_id_12754() {
  self endon("death");
  var_0 = self._id_B004["common_name"];
  var_1 = level._id_9A2E._id_4D94["actors"];

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_B004["common_name"])) {
      if(var_3._id_B004["common_name"] == var_0) {
        var_3._id_B004["interaction_trigger_override"] = 1;
      }
    }
  }
}

_id_DDE1() {
  foreach(var_1 in level._id_9A2E._id_4D94["actors"]) {
    if(!isDefined(var_1)) {
      level._id_9A2E._id_4D94["actors"] = ::scripts\engine\utility::array_remove(level._id_9A2E._id_4D94["actors"], var_1);
    }
  }
}

_id_168F() {
  if(isDefined(level._id_9A2E)) {
    if(!scripts\engine\utility::array_contains(level._id_9A2E._id_4D94["actors"], self)) {
      level._id_9A2E._id_4D94["actors"] = ::scripts\engine\utility::array_add(level._id_9A2E._id_4D94["actors"], self);
    }
  }
}

_id_DFB5() {
  if(isDefined(level._id_9A2E)) {
    level._id_9A2E._id_4D94["actors"] = ::scripts\engine\utility::array_remove(level._id_9A2E._id_4D94["actors"], self);
  }
}

_id_3839(var_0) {
  var_1 = level.player.origin;

  if(isDefined(var_0)) {
    var_2 = var_0;
  } else {
    var_2 = 140.0;
  }

  if(!isDefined(level._id_9A2E)) {
    return 1;
  }

  if(isDefined(self._id_1C4D) && !self._id_1C4D) {
    return 0;
  }

  _id_DDE1();

  foreach(var_4 in level._id_9A2E._id_4D94["actors"]) {
    if(isDefined(var_4) && isDefined(self)) {
      if(distance(self.origin, var_4.origin) < var_2) {
        if(scripts\sp\utility::hastag(var_4.model, "j_spine4") && level.player scripts\sp\utility::_id_D637(var_4 gettagorigin("j_spine4"))) {
          if(isDefined(var_4._id_9C84) && var_4._id_9C84) {
            return 0;
          }
        }
      }
    }
  }

  return 1;
}

_id_3838(var_0) {
  var_1 = level.player.origin;

  if(isDefined(var_0)) {
    var_2 = var_0;
  } else {
    var_2 = 140.0;
  }

  if(!isDefined(level._id_9A2E)) {
    return 1;
  }

  _id_DDE1();

  foreach(var_4 in level._id_9A2E._id_4D94["actors"]) {
    if(isDefined(var_4) && isDefined(self)) {
      if(self != var_4) {
        if(distance(self.origin, var_4.origin) < var_2) {
          if(scripts\engine\utility::within_fov(level.player getEye(), level.player.angles, var_4 gettagorigin("j_spine4"), cos(45))) {
            if(isDefined(var_4._id_D4A4) && var_4._id_D4A4 || isDefined(var_4._id_9CE2) && var_4._id_9CE2) {
              return 0;
            }

            if(isDefined(var_4._id_1C48) && !var_4._id_1C48) {
              return 0;
            }
          }
        }
      }
    }
  }

  return 1;
}

_id_9A0E(var_0) {
  if(isDefined(level._id_9A2E)) {
    if(isDefined(var_0._id_1C4D) && !var_0._id_1C4D) {
      return;
    }
    _id_DDE1();

    foreach(var_2 in level._id_9A2E._id_4D94["actors"]) {
      if(isDefined(var_2)) {
        var_2._id_1C4D = 0;
      }
    }

    for(;;) {
      var_4 = length(level.player.origin - level.player getEye());
      var_5 = var_0.origin + anglestoup(var_0.angles) * var_4;

      if(!level.player scripts\sp\utility::_id_D1DF(var_5, 0.7, 1)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    _id_DDE1();
    var_0._id_1C4D = 1;

    foreach(var_2 in level._id_9A2E._id_4D94["actors"]) {
      if(isDefined(var_2)) {
        var_2._id_1C4D = 1;
      }
    }
  }
}

_id_9A39() {
  self endon("death");

  if(isDefined(level._id_9A2E)) {
    if(isDefined(self._id_1C4D) && !self._id_1C4D) {
      return;
    }
    self._id_1C4D = 0;
    wait 20.0;

    for(;;) {
      if(isDefined(self._id_DD49) && self._id_DD49 != "nag" && self._id_DD49 != "busy") {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    for(;;) {
      var_0 = length(level.player.origin - level.player getEye());
      var_1 = self.origin + anglestoup(self.angles) * var_0;

      if(!level.player scripts\sp\utility::_id_D1DF(var_1, 0.7, 1)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    self._id_1C4D = 1;
  }
}

remind_calltrain_sethot(var_0) {
  level endon("stop_reminders");
  level endon("reboot_timer");
  level._id_9A2E._id_3840 = 0;
  wait(var_0);
  level._id_9A2E._id_3840 = 1;
}

_id_DB7B(var_0, var_1, var_2) {
  if(!isDefined(var_0) && isDefined(var_1)) {
    var_0 = "none";
  }

  if(isDefined(var_1)) {
    var_0 = var_0 + "+" + var_1;
  }

  level._id_9A2E._id_4D94["reminder_queue"][var_0] = self;

  if(isDefined(var_2)) {
    self.remind_calltrain = var_2;
  }
}

_id_DB7C(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    var_0 = var_0 + "+" + var_1;
  } else {
    var_0 = var_1;
  }

  level._id_9A2E._id_4D94["reminder_queue"][var_0] = self;

  if(isDefined(var_2)) {
    self.remind_calltrain = var_2;
  }

  self._id_13007 = 1;

  if(isDefined(var_3)) {
    self._id_E40E = var_3;
  }
}

_id_DB7D(var_0, var_1, var_2, var_3) {
  _id_DB7B(var_0);
  self._id_13008 = 1;
  self._id_DEED = var_2;
  self._id_D6E3 = var_3;
  self.reminder_cooldown_timer = var_1;
}

_id_E815(var_0) {
  level endon("stop_reminders");
  level thread reminder_animnode();
  var_1 = getarraykeys(level._id_9A2E._id_4D94["reminder_queue"]);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = level._id_9A2E._id_4D94["reminder_queue"][var_3];

    if(isDefined(var_4)) {
      var_5 = strtok(var_3, "+");
      var_6 = var_5[0];

      if(isDefined(var_4._id_13008) && var_4._id_13008) {
        if(isDefined(var_4._id_DEED) && isDefined(var_4._id_D6E3)) {
          var_4 thread scripts\sp\interaction::_id_CE18(var_4._id_DEED, var_6, var_4._id_D6E3);
        } else if(isDefined(self._id_D6E0) && isDefined(self._id_D6E2)) {
          self thread[[self._id_D6E0]](undefined, undefined, self._id_D6E2);
        } else {
          var_4 thread _id_CD24(85.0, 50.0, var_6, 1, var_4.reminder_cooldown_timer);
        }
      } else if(isDefined(var_4._id_13007) && var_4._id_13007) {
        var_7 = undefined;
        var_8 = undefined;

        if(var_5.size > 1) {
          var_7 = var_5[1];
          var_8 = var_6;
        } else
          var_7 = var_5[0];

        if(isDefined(var_4.remind_calltrain)) {
          var_4.remind_calltrain thread _id_CDDB(var_4, 85.0, 50.0, var_7, undefined, 1);
        } else {
          var_4 thread _id_CDDB(var_4, 85.0, 50.0, var_7, undefined, 1);
        }
      }
    }
  }

  wait(var_0);

  while(level._id_9A2E._id_C9C3) {
    scripts\engine\utility::waitframe();
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = level._id_9A2E._id_4D94["reminder_queue"][var_3];

    if(isDefined(var_4)) {
      var_5 = strtok(var_3, "+");
      var_6 = var_5[0];

      if(var_5.size > 1) {
        if(isDefined(var_4.remind_calltrain)) {
          var_4.remind_calltrain notify("stop_loop");
          var_4.remind_calltrain thread scripts\sp\anim::_id_1F35(var_4, var_5[1]);
          var_9 = getanimlength(var_4 scripts\sp\utility::_id_7DC1(var_5[1]));
          var_4 thread scripts\sp\utility::_id_C12D("reminder_anim_done", var_9);

          if(isDefined(var_4._id_E40E)) {
            var_4.remind_calltrain scripts\engine\utility::delaythread(var_9, scripts\sp\anim::_id_1EEA, var_4, var_4._id_E40E, "stop_loop");
          }
        } else {
          var_4 notify("stop_loop");
          var_4 thread scripts\sp\anim::_id_1F35(var_4, var_5[1]);
          var_9 = getanimlength(var_4 scripts\sp\utility::_id_7DC1(var_5[1]));
          var_4 thread scripts\sp\utility::_id_C12D("reminder_anim_done", var_9);

          if(isDefined(var_4._id_E40E)) {
            var_4 scripts\engine\utility::delaythread(var_9, scripts\sp\anim::_id_1EEA, var_4, var_4._id_E40E, "stop_loop");
          }
        }

        if(var_6 != "none") {
          if(!soundexists(var_6)) {
            var_4 _id_0B6A::_id_EC0E(var_6);
          } else {
            var_4 scripts\sp\utility::_id_10346(var_6);
          }
        }
      } else if(!soundexists(var_3)) {} else
        var_4 scripts\sp\utility::_id_10346(var_3);

      var_4 notify("reminder_done");
      var_4.remind_calltrain = undefined;
      level._id_9A2E._id_4D94["reminder_queue"][var_3] = undefined;
      level._id_9A2E._id_3840 = 0;
      wait(var_0);
      level._id_9A2E._id_3840 = 1;
    }

    while(level._id_9A2E._id_C9C3) {
      scripts\engine\utility::waitframe();
    }
  }

  level notify("reminders_done");
}

reminder_animnode() {
  level scripts\engine\utility::waittill_any("stop_reminders", "reminders_done");
  level._id_9A2E._id_4D94["reminder_queue"] = [];
}

_id_11037() {
  level notify("stop_reminders");
  level notify("reminders_done");
  level._id_9A2E._id_4D94["reminder_queue"] = [];
  _id_DDE1();

  foreach(var_1 in level._id_9A2E._id_4D94["actors"]) {
    if(isDefined(var_1)) {
      var_1._id_13008 = undefined;
      var_1._id_DEED = undefined;
      var_1._id_D6E3 = undefined;
      var_1.reminder_cooldown_timer = undefined;
      var_1.remind_calltrain = undefined;
      var_1._id_13007 = undefined;
    }
  }
}

_id_C9C4() {
  level._id_9A2E._id_C9C3 = 1;
}

_id_45A9() {
  level._id_9A2E._id_C9C3 = 0;
}

_id_CE40(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = "casual";
  }

  if(isDefined(self.gender) && issubstr(self.gender, "female")) {
    var_2 = "busy";
  }

  var_4 = var_0 + "_" + "casual";

  if(var_2 == "casual" || var_2 == "nag") {
    var_4 = var_0 + "_" + var_2;
  }

  self._id_DD4A = var_0;
  self._id_DD49 = var_2;

  if(var_2 == "nag") {
    thread scripts\sp\interaction::_id_CD53(var_4, var_1);
    self._id_1C4D = 0;
    self._id_DD49 = var_2;
    thread scripts\sp\utility::_id_77B9(0.7);
    thread _id_DD45();
    thread _id_DD4B(var_3, 1);
    return;
  } else if(var_2 == "busy") {
    thread scripts\sp\interaction::_id_CD53(var_4, var_1);
    self._id_1C4D = 0;
    self._id_DD49 = var_2;
    thread scripts\sp\utility::_id_77B9(0.7);
    thread _id_DD45();
    thread _id_DD4B(var_3);
    return;
  }

  thread scripts\sp\interaction::_id_CD53(var_4, var_1);
}

_id_11048() {
  if(!isDefined(self._id_9B89)) {
    thread scripts\sp\interaction::_id_9A0F();
  } else {
    self notify("reaction_end");
  }

  self notify("change_reaction_state");
  self._id_DD49 = undefined;
  self._id_1C4D = undefined;
  self._id_DD4A = undefined;
  thread scripts\sp\utility::_id_77B9(0.7);
}

_id_F566(var_0, var_1) {
  if(!isDefined(self._id_DD49)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self._id_DD4A)) {
    return;
  }
  self notify("change_reaction_state");
  self notify("stop_reaction_look");

  if(var_0 != "nag" && var_0 != "busy") {
    self._id_1C4D = 1;
    thread scripts\sp\utility::_id_77B9(0.7);
    self._id_9A30 = self._id_DD4A + "_" + var_0;
    self._id_DD49 = var_0;
  } else if(var_0 == "nag") {
    self._id_1C4D = 0;
    self._id_DD49 = var_0;
    thread scripts\sp\utility::_id_77B9(0.7);
    thread _id_DD45();
    thread _id_DD4B(var_1, 1);
  } else {
    self._id_1C4D = 0;
    self._id_DD49 = var_0;
    thread scripts\sp\utility::_id_77B9(0.7);
    thread _id_DD45();
    thread _id_DD4B(var_1);
  }
}

_id_DD4B(var_0, var_1) {
  self endon("change_reaction_state");

  for(;;) {
    thread _id_77B1(var_0, var_1);
    self waittill("end_gesture_reaction_distance_based");

    for(;;) {
      if(distance2d(self.origin, level.player.origin) >= level._id_10E1C[self._id_9A30]._id_EBEA["trigger_radius"] + 50.0) {
        break;
      }

      scripts\engine\utility::waitframe();
    }
  }
}

_id_F2A7(var_0, var_1) {
  switch (var_0) {
    case "busy":
    case "alert":
    case "nag":
    case "casual":
      foreach(var_3 in level._id_9A2E._id_4D94["actors"]) {
        var_3 thread _id_F566(var_0, var_1);
      }

      break;
  }
}

_id_DD45(var_0, var_1, var_2, var_3) {
  self endon("death");
  self notify("stop_reaction_look");
  self endon("stop_reaction_look");
  self endon("stop_smart_reaction");
  var_4 = 85.0;

  if(isDefined(var_0)) {
    var_4 = var_0;
  }

  if(!isDefined(var_1)) {
    var_1 = level.player;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.7;
  }

  wait(var_2);

  if(isDefined(self._id_DD4A)) {
    if(isDefined(level._id_10E1C[self._id_9A30]._id_EBEA["trigger_radius"])) {
      var_4 = level._id_10E1C[self._id_9A30]._id_EBEA["trigger_radius"] * 1.2;
    }
  }

  scripts\engine\utility::waitframe();

  if(isDefined(var_3) && var_3) {
    thread scripts\sp\utility::_id_7799(var_1, 0.5, 0.5);
  } else {
    thread scripts\sp\utility::_id_779A(var_1, 0.5, 0.5, var_4);
  }

  while(!isDefined(self._id_9BFC)) {
    wait 0.05;
  }

  thread scripts\sp\utility::_id_7798(var_1);
  wait(randomfloatrange(4.0, 6.0));
  var_5 = 1;
  var_6 = 1;

  for(;;) {
    if(distance2d(self.origin, var_1.origin) <= var_4) {
      if(!var_6) {
        thread _id_0C4C::_id_195B(0.5);
        thread scripts\sp\utility::_id_7798(var_1);
        var_6 = 1;
      }
    } else if(distance2d(self.origin, var_1.origin) >= var_4) {
      if(var_6) {
        thread _id_0C4C::_id_195A(1.0);
        thread scripts\sp\utility::_id_7793(0.7);
        var_6 = 0;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_77B1(var_0, var_1) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_reaction_look");
  var_2 = 50.0;

  if(isDefined(self._id_DD4A)) {
    if(isDefined(level._id_10E1C[self._id_9A30]._id_EBEA["trigger_radius"])) {
      var_2 = level._id_10E1C[self._id_9A30]._id_EBEA["trigger_radius"];
    }
  }

  _id_13775(var_2);
  thread scripts\sp\utility::_id_77B7("salute");
  var_3 = undefined;

  if(isDefined(var_1) && var_1) {
    switch (var_0) {
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
        var_4 = level._id_9A2E._id_4D94["reminder_vo"][var_0][self.gender];
        var_5 = level._id_9A2E._id_4D94["reminder_vo"][var_0]["spent_" + self.gender];

        if(var_4.size < 1 && var_5.size > 0) {
          level._id_9A2E._id_4D94["reminder_vo"][var_0][self.gender] = var_5;
          level._id_9A2E._id_4D94["reminder_vo"][var_0]["spent_" + self.gender] = [];
          var_4 = level._id_9A2E._id_4D94["reminder_vo"][var_0][self.gender];
          var_5 = level._id_9A2E._id_4D94["reminder_vo"][var_0]["spent_" + self.gender];
        }

        if(var_4.size < 1 && var_5.size < 1) {
          var_3 = undefined;
        } else {
          var_3 = var_4[randomint(var_4.size)];
          level._id_9A2E._id_4D94["reminder_vo"][var_0]["spent_" + self.gender] = ::scripts\engine\utility::array_add(level._id_9A2E._id_4D94["reminder_vo"][var_0]["spent_" + self.gender], var_3);
          level._id_9A2E._id_4D94["reminder_vo"][var_0][self.gender] = ::scripts\engine\utility::array_remove(level._id_9A2E._id_4D94["reminder_vo"][var_0][self.gender], var_3);
        }

        break;
    }
  } else {
    var_4 = level._id_9A2E._id_4D94["busy_vo"][self.gender];
    var_5 = level._id_9A2E._id_4D94["busy_vo"]["spent_" + self.gender];

    if(var_4.size < 1 && var_5.size > 0) {
      level._id_9A2E._id_4D94["busy_vo"][self.gender] = var_5;
      level._id_9A2E._id_4D94["busy_vo"]["spent_" + self.gender] = [];
      var_4 = level._id_9A2E._id_4D94["busy_vo"][self.gender];
      var_5 = level._id_9A2E._id_4D94["busy_vo"]["spent_" + self.gender];
    }

    if(var_4.size < 1 && var_5.size < 1) {
      var_3 = undefined;
    } else {
      var_3 = var_4[randomint(var_4.size)];
      level._id_9A2E._id_4D94["busy_vo"]["spent_" + self.gender] = ::scripts\engine\utility::array_add(level._id_9A2E._id_4D94["busy_vo"]["spent_" + self.gender], var_3);
      level._id_9A2E._id_4D94["busy_vo"][self.gender] = ::scripts\engine\utility::array_remove(level._id_9A2E._id_4D94["busy_vo"][self.gender], var_3);
    }
  }

  if(isDefined(var_3)) {
    scripts\sp\utility::_id_10346(var_3);

    if(isDefined(var_1) && var_1) {
      level thread remind_calltrain_sethot(90.0);
    }
  }

  self._id_D4A4 = 1;
  self notify("end_gesture_reaction_distance_based");
  wait 15.0;
  self._id_D4A4 = 0;
}

_id_D903() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");

  for(;;) {
    if(isDefined(self._id_1C48)) {}

    if(isDefined(self.gender)) {}

    if(isDefined(self._id_1FBB)) {}

    scripts\engine\utility::waitframe();
  }
}

_id_CD24(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_gesture_reaction");
  self endon("stop_smart_reaction");
  thread _id_168F();

  if(isDefined(self._id_1C48) && !self._id_1C48) {
    self._id_1C48 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_0)) {
    var_0 = 150.0;
  }

  if(!isDefined(var_1)) {
    var_1 = var_0 * 0.5;
  }

  if(!isDefined(self._id_9BFC) || isDefined(self._id_9BFC) && !self._id_9BFC) {
    thread _id_DD45(var_0);
  }

  _id_13775(var_1);
  _id_CD25(var_4);
  _id_CD52(var_2, var_3);
}

_id_13775(var_0) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_gesture_reaction");
  self endon("stop_smart_reaction");
  var_1 = 1;

  for(;;) {
    if(_id_9EED(var_0) && _id_38F2(var_0)) {
      var_2 = scripts\engine\utility::flatten_vector(anglestoright(self gettagangles("j_head")));
      var_3 = scripts\engine\utility::flatten_vector(vectorNormalize(level.player getEye() - self gettagorigin("j_head")));
      var_4 = vectordot(var_2, var_3);

      if(var_4 >= 0.8) {
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_9EED(var_0) {
  self endon("death");

  if(isDefined(self._id_9B89)) {
    var_1 = self gettagorigin("j_head");
  } else if(isai(self)) {
    var_1 = self getEye();
  } else if(isDefined(self.origin)) {
    var_1 = self.origin;
  } else {
    return 0;
  }

  var_2 = level.player getEye();
  var_3 = level.player getplayerangles();

  if(distance2d(self.origin, level.player.origin) <= var_0) {
    if(scripts\engine\utility::within_fov(var_2, var_3, var_1, cos(25))) {
      return 1;
    }
  }

  return 0;
}

_id_38F2(var_0) {
  if(!isDefined(self._id_1C48) || isDefined(self._id_1C48) && self._id_1C48) {
    if(!isDefined(self._id_77B2)) {
      if(_id_3838(var_0)) {
        return 1;
      }
    }
  }

  return 0;
}

#using_animtree("generic_human");

_id_CD25(var_0) {
  self._id_D4A4 = 1;

  if(!isDefined(self._id_9B89)) {
    if(isDefined(var_0)) {
      thread scripts\sp\utility::_id_77A9(var_0);
    } else {
      thread scripts\sp\utility::_id_77B7("salute");
    }
  } else
    scripts\sp\utility::_id_7790(%shipcrib_gst_head_salute_01);

  self._id_D4A4 = undefined;
}

_id_CD52(var_0, var_1) {
  if(isDefined(var_0)) {
    if(isDefined(var_1) && var_1) {
      _id_7286(30);
      _id_4177(var_0);
    }

    _id_509C(var_0);
    self._id_9CE2 = 1;
    _id_CE17(var_0);
    self._id_9CE2 = undefined;
  }
}

_id_509C(var_0) {
  if(!isDefined(self._id_1FBB)) {
    self._id_1FBB = "generic";
  }

  if(!isDefined(level._id_EC88[self._id_1FBB])) {
    level._id_EC88[self._id_1FBB] = [];
  }

  if(isarray(var_0)) {
    foreach(var_2 in var_0) {
      if(!isDefined(level._id_EC88[self._id_1FBB][var_2])) {
        if(isDefined(level._id_FDBF) && isDefined(self.gender)) {
          if(isDefined(level._id_FDBF[self.gender]) && isDefined(level._id_FDBF[self.gender][var_2])) {
            level._id_EC88[self._id_1FBB][var_2] = level._id_FDBF[self.gender][var_2];
          }
        }
      }
    }
  } else if(!isDefined(level._id_EC88[self._id_1FBB][var_0])) {
    if(isDefined(level._id_FDBF) && isDefined(self.gender)) {
      if(isDefined(level._id_FDBF[self.gender]) && isDefined(level._id_FDBF[self.gender][var_0])) {
        level._id_EC88[self._id_1FBB][var_0] = level._id_FDBF[self.gender][var_0];
      }
    }
  }
}

_id_CE17(var_0) {
  var_1 = undefined;

  if(isarray(var_0)) {
    for(var_2 = 0; var_2 < var_0.size; var_2++) {
      var_3 = var_0[var_2];

      if(isstring(var_3)) {
        _id_509C(var_3);

        if(!soundexists(var_3)) {
          if(!scripts\engine\utility::flag_exist("e3_europa_demo")) {
            _id_0B6A::_id_EC0E(var_3);
          }
        } else if(issubstr(var_3, "plr"))
          level.player scripts\sp\utility::_id_1034D(var_3);
        else {
          var_1 = _id_B19B(var_3);

          if(isDefined(var_1)) {
            var_1 scripts\sp\utility::_id_10346(var_3);
          } else {
            scripts\sp\utility::_id_10346(var_3);
          }
        }

        continue;
      }

      if(isnumber(var_3)) {
        wait(var_3);
      }
    }
  } else {
    var_3 = var_0;

    if(isstring(var_3)) {
      _id_509C(var_3);

      if(!soundexists(var_3)) {
        if(!scripts\engine\utility::flag_exist("e3_europa_demo")) {
          _id_0B6A::_id_EC0E(var_3);
        }
      } else if(issubstr(var_3, "plr"))
        level.player scripts\sp\utility::_id_1034D(var_3);
      else {
        var_1 = _id_B19B(var_3);

        if(isDefined(var_1)) {
          var_1 scripts\sp\utility::_id_10346(var_3);
        } else {
          scripts\sp\utility::_id_10346(var_3);
        }
      }
    }
  }
}

_id_7286(var_0) {
  level notify("reboot_timer");
  scripts\engine\utility::waitframe();
  level thread remind_calltrain_sethot(var_0);
}

_id_4177(var_0) {
  if(isDefined(level._id_9A2E)) {
    if(isDefined(level._id_9A2E._id_4D94["reminder_queue"])) {
      if(scripts\engine\utility::array_contains(level._id_9A2E._id_4D94["reminder_queue"], self)) {
        level._id_9A2E._id_4D94["reminder_queue"][var_0] = undefined;
      }
    }
  }
}

_id_CD37(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_5 endon("death");
    var_5 endon("stop_reaction");
    var_5 endon("reaction_end");
    var_5 endon("stop_gesture_reaction");
    var_5 endon("stop_smart_reaction");
  }

  foreach(var_5 in var_0) {
    var_5 thread _id_168F();
  }

  thread _id_DD43(var_0, var_1);
  _id_1377E(var_0, var_2);
  _id_CD36(var_0, var_3, var_2);

  foreach(var_5 in var_0) {
    var_10 = randomfloatrange(0, 1);
    var_11 = randomfloatrange(0.5, 1.5);
    var_5 scripts\engine\utility::delaythread(var_10, scripts\sp\utility::_id_77B9, var_11);
  }
}

_id_1377E(var_0, var_1) {
  var_2 = 1;
  var_3 = _id_491D(var_0);
  var_0 = scripts\engine\utility::array_add(var_0, var_3);

  while(var_2) {
    foreach(var_5 in var_0) {
      if(var_5 _id_9EED(var_1)) {
        var_2 = 0;
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_491D(var_0) {
  var_1 = 0;
  var_2 = (0, 0, 0);

  foreach(var_4 in var_0) {
    var_2 = var_2 + var_4.origin;
    var_1++;
  }

  var_6 = var_2 / var_1;
  var_7 = scripts\engine\utility::spawn_tag_origin(var_6, (0, 0, 0));
  return var_7;
}

_id_CD36(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(isDefined(var_0[var_3]) && isDefined(var_1[var_3])) {
      var_0[var_3] _id_CD25();
      var_0[var_3] _id_CD52(var_1[var_3]);
    }

    if(!_id_8694(var_2, var_0)) {
      break;
    }
  }
}

_id_8694(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(var_3 _id_9EED(var_0)) {
      return 1;
    }
  }

  return 0;
}

_id_DD43(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    var_4 endon("death");
    var_4 endon("stop_reaction");
    var_4 endon("reaction_end");
    var_4 endon("stop_reaction_look");
    var_4 endon("stop_smart_reaction");
  }

  var_6 = 85.0;

  if(isDefined(var_1)) {
    var_6 = var_1;
  }

  if(!isDefined(var_2)) {
    var_2 = level.player;
  }

  _id_9856(var_0, var_2);
  var_7 = _id_491D(var_0);

  for(;;) {
    _id_12DE3(var_0, var_7, var_2, var_1);
    _id_12DE4(var_0);
    _id_12DE2(var_0);
    scripts\engine\utility::waitframe();
  }
}

_id_9856(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_3 scripts\sp\utility::_id_7799(var_1, 0.15, 0.7);
    var_3._id_B009 = 0;
    var_3._id_B008 = 0;
  }

  scripts\engine\utility::waitframe();

  foreach(var_3 in var_0) {
    var_3 thread scripts\sp\utility::_id_7792(var_1);
  }
}

_id_12DE3(var_0, var_1, var_2, var_3) {
  if(distance2d(var_1.origin, var_2.origin) <= var_3) {
    _id_6216(var_0);
  } else {
    _id_5551(var_0);
  }
}

_id_6216(var_0) {
  foreach(var_2 in var_0) {
    if(!var_2._id_B009) {
      var_2 _id_4915();
    }

    var_2._id_B009 = 1;
  }
}

_id_5551(var_0) {
  foreach(var_2 in var_0) {
    if(var_2._id_B009) {
      var_2 _id_4915();
    }

    var_2._id_B009 = 0;
  }
}

_id_12DE4(var_0) {
  foreach(var_2 in var_0) {
    if(var_2._id_B008 <= 0) {
      if(var_2._id_B009) {
        var_2 _id_93EA();
        continue;
      }

      var_2 _id_4FB7();
    }
  }
}

_id_12DE2(var_0) {
  foreach(var_2 in var_0) {
    if(var_2._id_B008 > 0) {
      var_2._id_B008 = var_2._id_B008 - 0.05;
    }
  }
}

_id_4915() {
  self._id_B008 = randomfloatrange(0, 1);
}

_id_4168() {
  self._id_B008 = 0;
}

_id_93EA() {
  thread _id_0C4C::_id_195B(0.7);
}

_id_4FB7() {
  thread _id_0C4C::_id_195A(0.7);
}

_id_45FB(var_0) {
  if(!isarray(var_0)) {
    return [var_0];
  } else {
    return var_0;
  }
}

_id_CD26(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  var_5 = [];
  var_6 = var_2;

  for(;;) {
    if(var_6.size <= 0) {
      var_5 = [];
      var_6 = var_2;
    }

    var_7 = var_6[randomint(var_6.size)];
    _id_CD24(var_0, var_1, var_7, var_3, var_4);

    for(;;) {
      if(distance2d(self.origin, level.player.origin) >= var_0) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    scripts\engine\utility::waitframe();
    var_5 = scripts\engine\utility::array_add(var_5, var_7);
    var_6 = scripts\engine\utility::array_remove(var_6, var_7);
  }
}

_id_10FF9() {
  self notify("stop_gesture_reaction");
  self notify("stop_reaction_look");
  self notify("stop_gesture_reaction_set");
  self._id_77B2 = undefined;
  scripts\sp\utility::_id_77B9(0.7);
}

_id_11035() {
  self notify("stop_smart_reaction");
  thread scripts\sp\interaction::_id_9A0F();
}

_id_DB71(var_0) {
  if(!isDefined(self._id_77B2)) {
    self._id_77B2 = [];
  }

  var_1 = var_0;

  if(isarray(var_0)) {
    var_1 = var_0[0];
  }

  self._id_77B2[var_1] = var_0;
}

_id_CD27(var_0, var_1) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_gesture_reaction_set");
  self notify("stop_reaction_look");
  scripts\sp\utility::_id_77B9(0.7);
  thread _id_168F();
  self._id_1C48 = 1;

  if(!isDefined(var_0)) {
    var_0 = 150.0;
  }

  if(!isDefined(var_1)) {
    var_1 = var_0 * 0.5;
  }

  thread _id_DD45(var_0);
  var_2 = getarraykeys(self._id_77B2);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];
    var_5 = self._id_77B2[var_4];

    for(;;) {
      if(!isDefined(self)) {
        return;
      }
      var_6 = length(level.player.origin - level.player getEye());
      var_7 = self.origin + anglestoup(self.angles) * var_6;

      if(level.player scripts\sp\utility::_id_D1DF(var_7, 0.75, 1)) {
        if(distance2d(self.origin, level.player.origin) <= var_1 && _id_3838(var_1)) {
          break;
        }
      }

      scripts\engine\utility::waitframe();
    }

    thread scripts\sp\utility::_id_77B7("salute");
    self._id_1C48 = 0;

    if(isarray(var_5)) {
      for(var_8 = 0; var_8 < var_5.size; var_8++) {
        var_9 = var_5[var_8];

        if(isstring(var_9)) {
          _id_509C(var_9);

          if(!soundexists(var_9)) {
            _id_0B6A::_id_EC0E(var_9);
          } else if(issubstr(var_9, "plr")) {
            level.player scripts\sp\utility::_id_1034D(var_9);
          } else {
            var_10 = _id_B19B(var_9);

            if(isDefined(var_10)) {
              var_10 scripts\sp\utility::_id_10346(var_9);
            } else {
              scripts\sp\utility::_id_10346(var_9);
            }
          }

          continue;
        }

        if(isnumber(var_9)) {
          wait(var_9);
        }
      }
    } else if(!soundexists(var_5))
      _id_0B6A::_id_EC0E(var_5);
    else {
      _id_509C(var_5);
      var_10 = _id_B19B(var_5);

      if(isDefined(var_10)) {
        var_10 scripts\sp\utility::_id_10346(var_5);
      } else {
        scripts\sp\utility::_id_10346(var_5);
      }
    }

    self._id_77B2[var_4] = undefined;
    wait 5.0;
    self._id_1C48 = 1;
  }

  self._id_77B2 = undefined;

  if(isDefined(self._id_D6E0) && isDefined(self._id_D6E2)) {
    self thread[[self._id_D6E0]](undefined, undefined, self._id_D6E2);
  }
}

_id_B19B(var_0) {
  var_1 = strtok(var_0, "_");

  if(scripts\engine\utility::array_contains(var_1, "nav") || scripts\engine\utility::array_contains(var_1, "gtr")) {
    return level._id_76FB;
  } else if(scripts\engine\utility::array_contains(var_1, "slt") || scripts\engine\utility::array_contains(var_1, "xo")) {
    return level._id_EA2C;
  } else if(scripts\engine\utility::array_contains(var_1, "bsw")) {
    if(level.script == "shipcrib_rogue" || level.script == "shipcrib_prisoner") {
      return level._id_10214;
    } else {
      return level._id_1044B;
    }
  } else if(scripts\engine\utility::array_contains(var_1, "cmo"))
    return level._id_4451;
  else if(scripts\engine\utility::array_contains(var_1, "dpo")) {
    return level._id_5CFC;
  }

  return undefined;
}

_id_CDDB(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");

  if(isDefined(var_0._id_D7D9)) {
    if(isDefined(var_0._id_D7DA)) {
      if(var_0._id_D7DA.size == 1) {
        var_0[[var_0._id_D7D9]](var_0._id_D7DA[0]);
      } else if(var_0._id_D7DA.size == 2) {
        var_0[[var_0._id_D7D9]](var_0._id_D7DA[0], var_0._id_D7DA[1]);
      } else if(var_0._id_D7DA.size == 3) {
        var_0[[var_0._id_D7D9]](var_0._id_D7DA[0], var_0._id_D7DA[1], var_0._id_D7DA[2]);
      }
    }
  }

  level endon("stop_reminders");
  level endon("reminders_done");
  var_0 thread _id_168F();

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 150.0;
  }

  if(!isDefined(var_2)) {
    var_2 = var_1 * 0.5;
  }

  if(!isDefined(var_0._id_9BFC) || isDefined(var_0._id_9BFC) && !var_0._id_9BFC) {
    var_0 thread _id_DD45(var_1);
  }

  while(distance2d(var_0.origin, level.player.origin) <= var_1 + 25.0) {
    scripts\engine\utility::waitframe();
  }

  for(;;) {
    if(!isDefined(var_0)) {
      return;
    }
    var_6 = length(level.player.origin - level.player getEye());
    var_7 = var_0.origin + anglestoup(var_0.angles) * var_6;

    if(level.player scripts\sp\utility::_id_D1DF(var_7, 0.75, 1)) {
      if(distance2d(var_0.origin, level.player.origin) <= var_2) {
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }

  self notify("stop_loop");
  thread scripts\sp\anim::_id_1F35(var_0, var_3);
  var_8 = getanimlength(var_0 scripts\sp\utility::_id_7DC1(var_3));
  thread scripts\sp\utility::_id_C12D("reminder_anim_done", var_8);

  if(isDefined(var_0._id_E40E)) {
    scripts\engine\utility::delaythread(var_8, scripts\sp\anim::_id_1EEA, var_0, var_0._id_E40E, "stop_loop");
  }

  if(isDefined(var_4)) {
    if(var_5) {
      level notify("reboot_timer");
      scripts\engine\utility::waitframe();
      level thread remind_calltrain_sethot(90.0);

      if(isDefined(level._id_9A2E)) {
        if(isDefined(level._id_9A2E._id_4D94["reminder_queue"])) {
          if(scripts\engine\utility::array_contains(level._id_9A2E._id_4D94["reminder_queue"], var_0)) {
            level._id_9A2E._id_4D94["reminder_queue"][var_4] = undefined;
          }
        }
      }
    }

    var_0 _id_CE17(var_4);
  }

  if(isDefined(var_0._id_D6E0) && !isDefined(var_0._id_D6E2)) {
    if(isDefined(var_0._id_D6E1)) {
      if(var_0._id_D7DA.size == 1) {
        var_0[[var_0._id_D6E0]](var_0._id_D6E1[0]);
      } else if(var_0._id_D7DA.size == 2) {
        var_0[[var_0._id_D6E0]](var_0._id_D6E1[0], var_0._id_D6E1[1]);
      } else if(var_0._id_D7DA.size == 3) {
        var_0[[var_0._id_D6E0]](var_0._id_D6E1[0], var_0._id_D6E1[1], var_0._id_D6E1[2]);
      }
    }
  } else if(isDefined(var_0._id_D6E0) && isDefined(var_0._id_D6E2))
    var_0 thread[[var_0._id_D6E0]](undefined, undefined, var_0._id_D6E2);
}

reminder_queue_cleanup() {
  level._id_9A2E._id_4D94["reminder_vo"]["bridge"]["male_1"] = ["shipcrib_us1_wantedonbridge"];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge"]["male_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge"]["male_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge"]["spent_male_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge"]["spent_male_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge"]["spent_male_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge"]["female_1"] = ["shipcrib_us1_wantedonbridge"];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge"]["female_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge"]["female_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge"]["spent_female_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge"]["spent_female_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge"]["spent_female_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["lounge"]["male_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["lounge"]["male_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["lounge"]["male_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["lounge"]["spent_male_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["lounge"]["spent_male_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["lounge"]["spent_male_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["lounge"]["female_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["lounge"]["female_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["lounge"]["female_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["lounge"]["spent_female_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["lounge"]["spent_female_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["lounge"]["spent_female_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["captains"]["male_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["captains"]["male_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["captains"]["male_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["captains"]["spent_male_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["captains"]["spent_male_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["captains"]["spent_male_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["captains"]["female_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["captains"]["female_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["captains"]["female"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["captains"]["spent_female_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["captains"]["spent_female_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["captains"]["spent_female_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["opsmap"]["male_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["opsmap"]["male_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["opsmap"]["male_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["opsmap"]["spent_male_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["opsmap"]["spent_male_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["opsmap"]["spent_male_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["opsmap"]["female_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["opsmap"]["female_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["opsmap"]["female_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["opsmap"]["spent_female_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["opsmap"]["spent_female_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["opsmap"]["spent_female_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["ftl"]["male_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["ftl"]["male_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["ftl"]["male_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["ftl"]["spent_male_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["ftl"]["spent_male_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["ftl"]["spent_male_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["ftl"]["female_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["ftl"]["female_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["ftl"]["female_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["ftl"]["spent_female_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["ftl"]["spent_female_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["ftl"]["spent_female_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["cic"]["male_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["cic"]["male_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["cic"]["male_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["cic"]["spent_male_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["cic"]["spent_male_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["cic"]["spent_male_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["cic"]["female_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["cic"]["female_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["cic"]["female_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["cic"]["spent_female_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["cic"]["spent_female_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["cic"]["spent_female_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev_doors"]["male_1"] = ["shipcrib_un1_theyrewaitingfo", "shipcrib_un1_theyreattheelev"];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev_doors"]["male_2"] = ["shipcrib_un2_theyreneartheel", "shipcrib_un2_theyrenearthee"];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev_doors"]["male_3"] = ["shipcrib_un3_youreneededby", "shipcrib_un3_elevatordoorsa"];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev_doors"]["spent_male_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev_doors"]["spent_male_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev_doors"]["spent_male_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev_doors"]["female_1"] = ["shipcrib_unf1_theyrebythedoo", "shipcrib_unf1_theyrewaitingatt"];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev_doors"]["female_2"] = ["shipcrib_unf2_ithinktheyrewaitin", "shipcrib_unf2_gettotheelevatord"];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev_doors"]["female_3"] = ["shipcrib_unf3_theyrelookingfory", "shipcrib_unf3_elevatordoorsarea"];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev_doors"]["spent_female_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev_doors"]["spent_female_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev_doors"]["spent_female_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev"]["male_1"] = ["shipcrib_un1_youreneededbythe", "shipcrib_un1_youreneededbythee"];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev"]["male_2"] = ["shipcrib_un2_theyrewaitingforyo", "shipcrib_un2_theyneedyoubyt"];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev"]["male_3"] = ["shipcrib_un3_elevatorswaitinfo", "shipcrib_un3_elevatorswaitinfor"];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev"]["spent_male_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev"]["spent_male_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev"]["spent_male_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev"]["female_1"] = ["shipcrib_unf1_elevatorsreadytot", "shipcrib_unf1_elevatorsreadyfo"];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev"]["female_2"] = ["shipcrib_unf2_theyrereadyforyo", "shipcrib_unf2_theyrebytheelev"];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev"]["female_3"] = ["shipcrib_unf3_elevatorsreadya", "shipcrib_unf3_elevatorsaroundt"];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev"]["spent_female_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev"]["spent_female_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["bridge_elev"]["spent_female_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["dropship"]["male_1"] = ["shipcrib_un1_dropshipsfueled"];
  level._id_9A2E._id_4D94["reminder_vo"]["dropship"]["male_2"] = ["shipcrib_un2_yourdropshipisr"];
  level._id_9A2E._id_4D94["reminder_vo"]["dropship"]["male_3"] = ["shipcrib_un3_dropshipswaitingf"];
  level._id_9A2E._id_4D94["reminder_vo"]["dropship"]["spent_male_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["dropship"]["spent_male_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["dropship"]["spent_male_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["dropship"]["female_1"] = ["shipcrib_unf1_bossgibsonhasad"];
  level._id_9A2E._id_4D94["reminder_vo"]["dropship"]["female_2"] = ["shipcrib_unf2_dropshipsreadyto"];
  level._id_9A2E._id_4D94["reminder_vo"]["dropship"]["female_3"] = ["shipcrib_unf3_reportfromtheflight"];
  level._id_9A2E._id_4D94["reminder_vo"]["dropship"]["spent_female_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["dropship"]["spent_female_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["dropship"]["spent_female_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["jackal"]["male_1"] = ["shipcrib_un1_yourjackalisread"];
  level._id_9A2E._id_4D94["reminder_vo"]["jackal"]["male_2"] = ["shipcrib_un2_gibsonhasyourja"];
  level._id_9A2E._id_4D94["reminder_vo"]["jackal"]["male_3"] = ["shipcrib_un3_flightdeckreports"];
  level._id_9A2E._id_4D94["reminder_vo"]["jackal"]["spent_male_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["jackal"]["spent_male_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["jackal"]["spent_male_3"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["jackal"]["female_1"] = ["shipcrib_unf1_yourjackalsreadyin"];
  level._id_9A2E._id_4D94["reminder_vo"]["jackal"]["female_2"] = ["shipcrib_unf2_bossgibsonsaysc"];
  level._id_9A2E._id_4D94["reminder_vo"]["jackal"]["female_3"] = ["shipcrib_unf3_jackalsreadyandw"];
  level._id_9A2E._id_4D94["reminder_vo"]["jackal"]["spent_female_1"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["jackal"]["spent_female_2"] = [];
  level._id_9A2E._id_4D94["reminder_vo"]["jackal"]["spent_female_3"] = [];
  level._id_9A2E._id_4D94["busy_vo"]["male_1"] = ["shipcrib_un1_captain2", "shipcrib_un1_sir2"];
  level._id_9A2E._id_4D94["busy_vo"]["male_2"] = ["shipcrib_un2_weregoodheresi", "shipcrib_un2_sorrysirgotalottok"];
  level._id_9A2E._id_4D94["busy_vo"]["male_3"] = ["shipcrib_un3_gotthingsundercon", "shipcrib_un3_captain"];
  level._id_9A2E._id_4D94["busy_vo"]["spent_male_1"] = [];
  level._id_9A2E._id_4D94["busy_vo"]["spent_male_2"] = [];
  level._id_9A2E._id_4D94["busy_vo"]["spent_male_3"] = [];
  level._id_9A2E._id_4D94["busy_vo"]["female_1"] = ["shipcrib_unf2_captain", "shipcrib_unf2_youllhavetoexcus"];
  level._id_9A2E._id_4D94["busy_vo"]["female_2"] = ["shipcrib_unf2_captain", "shipcrib_unf2_youllhavetoexcus"];
  level._id_9A2E._id_4D94["busy_vo"]["female_3"] = ["shipcrib_unf3_captainreyes", "shipcrib_unf3_sir"];
  level._id_9A2E._id_4D94["busy_vo"]["spent_female_1"] = [];
  level._id_9A2E._id_4D94["busy_vo"]["spent_female_2"] = [];
  level._id_9A2E._id_4D94["busy_vo"]["spent_female_3"] = [];
}