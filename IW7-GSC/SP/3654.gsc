/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3654.gsc
*********************************************/

func_959B() {
  setdvarifuninitialized("cursor_hint_debug", 0);
  precacheshader("cursor_hint_circle");
  precacheshader("cursor_hint_x");
  precacheshader("cursor_hint_square");
  precacheshader("alien_dpad_none");
  precacheshader("hud_arrow_up");
  precacheshader("hud_interaction_prompt_center_ammo");
  precacheshader("hud_scrap_medium_icon_test");
  precacheshader("hud_interaction_prompt_center_heavy");
  precacheshader("hud_interaction_prompt_center_steel_dragon");
  level.var_4C21 = [];
  level.var_4C22 = 1;
}

func_48C4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D, var_0E) {
  var_0F = self;
  if(isstruct(var_0F) || var_0F.classname == "script_origin" || isDefined(var_1)) {
    var_0F = spawn("script_origin", self.origin);
    self.var_4C1F = var_0F;
    thread func_8FF7();
  }

  if(isDefined(var_1)) {
    var_10 = "tag_origin";
    if(isDefined(var_0)) {
      var_10 = var_0;
      var_0F.origin = self gettagorigin(var_10);
    }

    if(isDefined(self.model) && self.classname == "script_model" && scripts\sp\utility::hastag(self.model, var_10)) {
      var_0F linkto(self, var_10, var_1, (0, 0, 0));
    } else if(isDefined(var_0)) {
      var_0F linkto(self, var_10, var_1, (0, 0, 0));
    } else if(isDefined(self.angles)) {
      var_0F.origin = var_0F.origin + rotatevector(var_1, self.angles);
      if(isent(self)) {
        var_0F linkto(self);
      }
    } else {
      var_0F.origin = var_0F.origin + var_1;
      if(isent(self)) {
        var_0F linkto(self);
      }
    }
  } else if(isDefined(var_0)) {
    var_0F func_84A7(var_0);
  }

  if(isDefined(var_8) && var_8) {
    var_0F setcursorhint("HINT_NOICON");
  } else {
    var_0F setcursorhint("HINT_BUTTON");
  }

  if(isDefined(var_2)) {
    var_0F sethintstring(var_2);
  }

  var_11 = 360;
  if(isDefined(var_3)) {
    var_11 = var_3;
  }

  var_0F func_84A6(var_11);
  var_12 = 65;
  if(isDefined(var_0E)) {
    var_12 = var_0E;
  }

  var_0F setusefov(var_12);
  var_13 = 500;
  if(isDefined(var_4)) {
    var_13 = var_4;
  }

  var_0F func_84A4(var_13);
  var_14 = 80;
  if(isDefined(var_5)) {
    var_14 = var_5;
  }

  var_0F setuserange(var_14);
  if(isDefined(var_6) && var_6) {
    var_0F func_84A9("show");
  } else {
    var_0F func_84A9("hide");
  }

  if(isDefined(var_0A) && var_0A) {
    var_0F func_84A9("disable");
  }

  if(isDefined(var_7) && var_7) {
    var_0F func_84B8(var_7);
  } else if(isDefined(var_0B) && var_0B) {
    var_0F func_8560(var_0B);
  } else {
    thread func_8FF0();
  }

  if(isDefined(var_9)) {
    var_0F sethintstringparams(var_9);
  }

  if(isDefined(var_0C)) {
    var_0F func_84A3(var_0C);
  }

  if(isDefined(var_0D)) {
    var_0F func_8561(1);
  } else {
    var_0F func_8561(0);
  }

  var_0F makeusable();
}

func_8FF7() {
  self endon("death");
  self endon("hint_destroyed");
  self.var_4C1F waittill("trigger", var_0);
  self notify("trigger", var_0);
}

func_8FF0() {
  self endon("hint_destroyed");
  var_0 = self;
  if(isDefined(self.var_4C1F)) {
    var_0 = self.var_4C1F;
  }

  hint_delete_on_trigger_waittill(var_0);
  thread func_DFE3();
}

hint_delete_on_trigger_waittill(var_0) {
  self endon("entitydeleted");
  var_0 waittill("trigger");
}

func_DFE3() {
  var_0 = self;
  if(isDefined(self.var_4C1F)) {
    var_0 = self.var_4C1F;
    var_0 scripts\engine\utility::delaycall(0.5, ::delete);
  }

  if(isDefined(var_0) && !isstruct(var_0)) {
    var_0 makeunusable();
  }

  if(isDefined(self)) {
    scripts\sp\utility::func_C12D("hint_destroyed", 0.05);
  }
}

func_9016() {
  var_0 = scripts\sp\utility::func_B979(self, "stand");
  return var_0;
}

func_48C5(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  func_48C4(var_0, var_1, var_2, var_7, var_5, var_6, var_4, var_3);
}

func_48C6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\engine\utility::spawn_tag_origin();
  var_8.origin = self.origin;
  var_8.angles = (0, 0, 0);
  if(isDefined(self.angles)) {
    var_8.angles = self.angles;
  }

  var_8.var_13084 = self;
  self.var_4C1D = var_8;
  var_8 scripts\sp\utility::func_65E0("hint_showing");
  var_8 scripts\sp\utility::func_65E0("hint_usable");
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  if(isent(self)) {
    self makeunusable();
  }

  if(isDefined(var_0)) {
    var_8 linkto(self, var_0, var_1, (0, 0, 0));
  } else if(isDefined(var_1)) {
    if(isDefined(self.model) && self.classname == "script_model" && scripts\sp\utility::hastag(self.model, "tag_origin")) {
      var_8 linkto(self, "tag_origin", var_1, (0, 0, 0));
    } else if(isDefined(self.angles)) {
      var_8.origin = var_8.origin + rotatevector(var_1, self.angles);
    } else {
      var_8.origin = var_8.origin + var_1;
    }
  } else if(isent(self)) {
    var_8 linkto(self);
  }

  var_8.icon = [];
  var_9 = newhudelem();
  var_9.alpha = 0;
  var_9 setshader("cursor_hint_circle", 1, 1);
  var_9 setwaypoint(1, 0, 1);
  var_9 settargetent(var_8);
  var_9.sort = -1;
  var_9.var_1012F = 0;
  var_8.icon["circle"] = var_9;
  var_0A = newhudelem();
  var_0A.alpha = 0;
  if(level.var_DADC) {
    var_0A setshader("cursor_hint_square", 1, 1);
  } else {
    var_0A setshader("cursor_hint_x", 1, 1);
  }

  var_0A setwaypoint(0, 0, 1);
  var_0A settargetent(var_8);
  var_0A.sort = 1;
  var_0A.var_1012F = 0;
  var_8.icon["button"] = var_0A;
  var_8.hidden = 0;
  var_8.var_369 = 0;
  if(isDefined(var_2)) {
    var_8.var_9075 = var_2 * 1000;
  }

  var_8.var_7345 = 0.85;
  if(isDefined(var_3)) {
    var_8.var_7345 = cos(var_3);
  }

  var_8.var_13393 = 500;
  if(isDefined(var_4)) {
    var_8.var_13393 = var_4;
  }

  var_8.var_13078 = 80;
  if(isDefined(var_5)) {
    var_8.var_13078 = var_5;
  }

  var_8.var_11A8F = 1;
  if(isDefined(var_6)) {
    var_8.var_11A8F = var_6;
  }

  var_8.var_8C4F = 0;
  if(isDefined(var_7)) {
    if(isstring(var_7) || var_7 != 0) {
      var_8.var_C362 = "hud_arrow_up";
      if(isstring(var_7)) {
        var_8.var_C362 = var_7;
      }

      var_8.var_8C4F = 1;
    }
  }

  var_8.priority = 0;
  if(isDefined(self.var_900A)) {
    var_8.priority = self.var_900A;
  }

  var_0B = 0;
  if(level.var_4C21.size == 0) {
    var_0B = 1;
  }

  level.var_4C21 = scripts\engine\utility::array_add(level.var_4C21, var_8);
  if(var_0B) {
    thread func_4C20();
  }
}

func_DFE4() {
  if(!isDefined(self.var_4C1D)) {
    return;
  }

  var_0 = self.var_4C1D;
  level.var_4C21 = scripts\engine\utility::array_remove(level.var_4C21, var_0);
  var_0.icon["circle"] destroy();
  var_0.icon["button"] destroy();
  if(var_0.var_8C4F) {
    var_0 func_8E9B();
  }

  var_0 delete();
  self.var_4C1D = undefined;
  self notify("hint_destroyed");
}

func_4C20() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = scripts\common\trace::create_contents(1, 1, 1, 1, 1, 1);
  for(;;) {
    if(level.var_4C21.size == 0) {
      break;
    }

    var_5 = func_10424();
    scripts\engine\utility::array_thread(var_5["not_viewable"], ::func_8E8E);
    scripts\engine\utility::array_thread(var_5["not_viewable"], ::func_C360);
    var_6 = var_5["viewable"];
    if(var_6.size == 0) {
      var_0 = undefined;
      var_1 = undefined;
    } else {
      var_7 = func_10426(var_6, var_4);
      scripts\engine\utility::array_thread(var_7["remove"], ::func_8E8E);
      var_8 = func_10425(var_7["viewable"]);
      var_9 = func_10425(var_7["useable"]);
      var_0A = scripts\engine\utility::array_combine(var_9, var_8);
      var_0B = undefined;
      foreach(var_0E, var_0D in var_0A) {
        if(var_0E >= level.var_4C22) {
          var_0D func_8E8E();
          continue;
        }

        if(var_0D.var_369 && !isDefined(var_0B)) {
          var_0B = var_0D;
          var_0D func_100E9();
          continue;
        }

        var_0D func_8E8E();
        var_0D func_100E9("circle");
      }

      if(!isDefined(var_0B)) {} else if(level.player usebuttonpressed()) {
        if(isDefined(var_0B.var_9075)) {
          var_0F = 0;
          if(!isDefined(var_3)) {
            var_3 = func_D9DC();
          }

          if(!isDefined(var_0) || var_0B == var_0) {
            if(!isDefined(var_2)) {
              var_2 = gettime();
            }

            if(gettime() - var_2 >= 100) {
              var_1 = undefined;
            }

            var_2 = gettime();
            if(!isDefined(var_1)) {
              var_1 = gettime();
            }

            var_10 = gettime() - var_1;
            if(var_10 >= var_0B.var_9075) {
              var_1 = undefined;
              var_0F = 1;
              var_3 func_D9DB();
            } else {
              var_3 func_D9DE(var_10, var_0B.var_9075);
            }
          }

          var_0 = var_0B;
          if(!var_0F) {} else {
            var_0B notify("trigger", level.player);
            var_0B.var_13084 notify("trigger", level.player);
            var_0B func_408B();
            wait(0.4);
          }
        }
      }
    }

    wait(0.05);
  }
}

func_10424() {
  var_0 = [];
  var_0["viewable"] = [];
  var_0["not_viewable"] = [];
  foreach(var_2 in level.var_4C21) {
    if(level.player scripts\sp\utility::func_65DF("viper_initiated") && level.player scripts\sp\utility::func_65DB("viper_initiated")) {
      var_3 = combineangles(level.var_133EC.var_D267.angles, level.player getplayerangles());
      var_4 = func_79CE(level.player getEye(), var_3, var_2.origin);
    } else {
      var_4 = func_79CE(level.player getEye(), level.player getplayerangles(), var_2.origin);
    }

    var_2.var_4BEC = var_4;
    if(var_4 < var_2.var_7345) {
      var_0["not_viewable"] = scripts\engine\utility::array_add(var_0["not_viewable"], var_2);
      continue;
    } else {
      var_0["viewable"] = scripts\engine\utility::array_add(var_0["viewable"], var_2);
    }

    if(getdvarint("cursor_hint_debug")) {
      var_2 func_4C1E();
    }
  }

  return var_0;
}

func_10426(var_0, var_1) {
  var_2 = [];
  var_2["viewable"] = [];
  var_2["useable"] = [];
  var_2["remove"] = [];
  foreach(var_4 in var_0) {
    var_4.var_369 = 0;
    var_4.var_9035 = 0;
    var_5 = level.player;
    if(isDefined(var_4.var_13084.classname) && isent(var_4.var_13084)) {
      var_5 = [level.player, var_4.var_13084];
    }

    var_6 = scripts\common\trace::ray_trace(level.player getEye(), var_4.origin, var_5, var_1);
    if(var_4.var_11A8F && var_6["fraction"] < 1) {
      var_7 = 1;
      if(isDefined(var_6["entity"]) && isai(var_6["entity"])) {
        var_1 = scripts\common\trace::create_contents(0, 1, 1, 1, 1, 1);
        if(scripts\common\trace::ray_trace_passed(level.player getEye(), var_4.origin, var_5, var_1)) {
          var_4.var_9035 = 1;
          var_7 = 0;
        }
      }

      if(var_7) {
        var_2["remove"] = scripts\engine\utility::array_add(var_2["remove"], var_4);
        continue;
      }
    }

    var_8 = distancesquared(var_4.origin, level.player.origin);
    if(var_8 > squared(var_4.var_13393)) {
      var_2["remove"] = scripts\engine\utility::array_add(var_2["remove"], var_4);
      continue;
    }

    if(var_8 > squared(var_4.var_13078) || var_4.var_9035) {
      var_2["viewable"] = scripts\engine\utility::array_add(var_2["viewable"], var_4);
      continue;
    }

    var_2["useable"] = scripts\engine\utility::array_add(var_2["useable"], var_4);
    var_4.var_369 = 1;
  }

  return var_2;
}

func_10425(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    foreach(var_6, var_5 in var_1) {
      if(var_3.priority == var_5.priority) {
        var_6++;
      } else if(var_3.priority < var_5.priority) {
        continue;
      }

      break;
    }

    if(!isDefined(var_6)) {
      var_6 = 0;
    }

    var_1 = scripts\engine\utility::array_insert(var_1, var_3, var_6);
  }

  if(var_1.size <= 1) {
    return var_1;
  }

  var_8 = [];
  foreach(var_3 in var_1) {
    if(var_3.var_4BEC >= 0.95) {
      var_0A = 0;
      foreach(var_6, var_0C in var_8) {
        if(var_3.var_4BEC > var_0C.var_4BEC) {
          var_0A = 1;
          var_8 = scripts\engine\utility::array_insert(var_8, var_3, var_6);
          break;
        }
      }

      if(!var_0A) {
        var_8 = scripts\engine\utility::array_add(var_8, var_3);
      }

      continue;
    }

    var_8 = scripts\engine\utility::array_add(var_8, var_3);
  }

  return var_8;
}

func_100E9(var_0) {
  if(!isDefined(var_0)) {
    foreach(var_2 in self.icon) {
      if(var_2.var_1012F) {
        continue;
      }

      var_3 = 1;
      if(var_2 != self.icon["button"]) {
        var_2 fadeovertime(0.2);
        var_3 = 0.7;
        if(self.var_9035) {
          var_3 = 0.2;
        }
      }

      var_2.alpha = var_3;
      var_2.var_1012F = 1;
    }

    scripts\sp\utility::func_65E1("hint_showing");
    scripts\sp\utility::func_65E1("hint_usable");
    return;
  }

  if(!self.icon[var_0].var_1012F) {
    var_3 = 1;
    if(var_0 != "button") {
      self.icon[var_0] fadeovertime(0.2);
      var_3 = 0.7;
      if(self.var_9035) {
        var_3 = 0.2;
      }

      scripts\sp\utility::func_65E1("hint_usable");
    } else {
      scripts\sp\utility::func_65E1("hint_showing");
    }

    self.icon[var_0].alpha = var_3;
    self.icon[var_0].var_1012F = 1;
  }
}

func_8E8E(var_0) {
  if(!isDefined(var_0)) {
    foreach(var_2 in self.icon) {
      if(!var_2.var_1012F) {
        continue;
      }

      if(var_2 != self.icon["button"]) {
        var_2 fadeovertime(0.2);
      }

      var_2.alpha = 0;
      var_2.var_1012F = 0;
    }

    scripts\sp\utility::func_65DD("hint_showing");
    scripts\sp\utility::func_65DD("hint_usable");
    return;
  }

  if(self.icon[var_0].var_1012F) {
    if(var_0 != "button") {
      self.icon[var_0] fadeovertime(0.2);
      scripts\sp\utility::func_65DD("hint_usable");
    } else {
      scripts\sp\utility::func_65DD("hint_showing");
    }

    self.icon[var_0].alpha = 0;
    self.icon[var_0].var_1012F = 0;
  }
}

func_C360() {
  if(!self.var_8C4F) {
    return;
  }

  var_0 = distancesquared(self.origin, level.player.origin);
  if(var_0 > squared(self.var_13393)) {
    func_8E9B();
    return;
  }

  func_100F1();
}

func_100F1() {
  if(target_istarget(self)) {
    return;
  }

  target_set(self);
  target_setshader(self, "alien_dpad_none");
  target_setoffscreenshader(self, self.var_C362);
}

func_8E9B() {
  if(!target_istarget(self)) {
    return;
  }

  target_remove(self);
}

func_408B() {
  foreach(var_1 in self.icon) {
    var_1 destroy();
  }

  level.var_4C21 = scripts\engine\utility::array_remove(level.var_4C21, self);
  self delete();
}

func_D9DC() {
  var_0 = level.player scripts\sp\hud_util::func_4997("white", "black", 100, 12);
  var_0 scripts\sp\hud_util::setpoint("CENTER", undefined, 0, 150);
  var_0 scripts\sp\hud_util::updatebar(0);
  var_0.sort = 2;
  var_0.bar.sort = 2.1;
  return var_0;
}

func_D9DE(var_0, var_1) {
  var_2 = var_0 / var_1;
  scripts\sp\hud_util::updatebar(var_2);
  thread func_D9DD();
}

func_D9DD() {
  self notify("timeout_check");
  self endon("timeout_check");
  self endon("death");
  wait(0.1);
  func_D9DB();
}

func_D9DB() {
  self.bar destroy();
  self destroy();
}

func_79CE(var_0, var_1, var_2) {
  var_3 = vectornormalize(var_2 - var_0);
  var_4 = anglesToForward(var_1);
  var_5 = vectordot(var_4, var_3);
  return var_5;
}

func_4C1E() {
  var_0 = anglestoup(self.angles);
  var_1 = self.origin + var_0 * 5;
  var_2 = self.origin;
  thread scripts\sp\utility::draw_circle(self.origin, self.var_13393, (0, 1, 0), 1, 0, 1);
  thread scripts\sp\utility::draw_circle(self.origin, self.var_13078, (1, 0, 0), 1, 0, 1);
}