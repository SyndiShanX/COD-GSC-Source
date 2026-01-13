/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\2859.gsc
*********************************************/

func_6B44() {
  setdvarifuninitialized("debug_fakeactor", 0);
  setdvarifuninitialized("debug_fakeactor_accuracy", 0);
  level._effect["fakeactor_muzflash"] = loadfx("vfx\core\muzflash\ak47_flash_wv");
  if(!isDefined(level.var_B438)) {
    level.var_B438 = [];
  }

  if(!isDefined(level.var_B438["allies"])) {
    level.var_B438["allies"] = 9999;
  }

  if(!isDefined(level.var_B438["axis"])) {
    level.var_B438["axis"] = 9999;
  }

  if(!isDefined(level.var_B438["team3"])) {
    level.var_B438["team3"] = 9999;
  }

  if(!isDefined(level.var_B438["neutral"])) {
    level.var_B438["neutral"] = 9999;
  }

  if(!isDefined(level.var_6B46)) {
    level.var_6B46 = [];
  }

  if(!isDefined(level.var_6B46["allies"])) {
    level.var_6B46["allies"] = scripts\sp\utility::func_1115A();
  }

  if(!isDefined(level.var_6B46["axis"])) {
    level.var_6B46["axis"] = scripts\sp\utility::func_1115A();
  }

  if(!isDefined(level.var_6B46["team3"])) {
    level.var_6B46["team3"] = scripts\sp\utility::func_1115A();
  }

  if(!isDefined(level.var_6B46["neutral"])) {
    level.var_6B46["neutral"] = scripts\sp\utility::func_1115A();
  }

  if(!isDefined(level.var_6A65)) {
    func_174C("default", "anim", ::func_CC8A, ::func_CC86, 30);
    func_174C("default", "move", ::func_BC82, ::func_BC1C, 10);
    func_174C("default", "traverse", ::func_126D9, ::func_126D0, 20);
    func_174C("default", "idle", ::func_92EE, ::func_92D9, 40);
  }

  level.var_6B43 = ::func_6B16;
  if(!isDefined(level.var_6A64)) {
    var_0 = [];
    var_0["Cover Left"] = 0;
    var_0["Cover Right"] = -90;
    var_0["Cover Crouch"] = -90;
    var_0["Cover Stand"] = -90;
    var_0["Cover Stand 3D"] = -90;
    anim.var_6A64 = var_0;
    var_0 = [];
    var_0["Cover Left"] = 180;
    var_0["Cover Left Crouch"] = 0;
    var_0["Cover Right"] = 180;
    var_0["Cover Crouch"] = 180;
    var_0["Cover Stand"] = 180;
    anim.var_6A63 = var_0;
  }
}

func_79AF(var_0) {
  return level.var_6B46[var_0].var_2274;
}

func_9BDF() {
  return isDefined(self.var_ED8A) && self.var_ED8A;
}

func_6B16() {
  if(level.var_6B46[self.team].var_2274.size >= level.var_B438[self.team]) {
    self delete();
    return;
  }

  thread func_2294(self);
  level notify("new_fakeactor");
  self.var_EDB3 = undefined;
  self.magicbullet = 0;
  self.var_368 = -45;
  self.isbot = 45;
  self.setdevdvar = -45;
  self.setmatchdatadef = 45;
  self.var_2894 = 1;
  self.var_AFED = 200;
  self.var_B04E = 0.5;
  func_F2C3(["exposed"]);
  if(isDefined(self.var_ED56)) {
    if(self.var_ED56 == "frantic") {
      func_F3BE(1);
    }

    self.var_ED56 = undefined;
  }

  if(isDefined(self.var_ED61)) {
    func_F35C(self.var_ED61);
    self.var_ED61 = undefined;
  }

  if(isDefined(self.var_ED62)) {
    func_F35D(self.var_ED62);
    self.var_ED62 = undefined;
  }

  if(isDefined(self.var_EDE1)) {
    func_F410(self.var_EDE1);
    self.var_EDE1 = undefined;
  }

  if(isDefined(self.var_ECF9)) {
    func_F2C6(self.var_ECF9);
    self.var_ECF9 = undefined;
  }

  if(isDefined(self.var_EEFF)) {
    func_F568(self.var_EEFF);
    self.var_EEFF = undefined;
  }

  if(isDefined(self.var_EEFE)) {
    func_F5F9(self.var_EEFE);
    self.var_EEFE = undefined;
  }

  func_6B15();
  self hide();
  scripts\engine\utility::delaycall(0.05, ::show);
  if(self.team == "axis") {
    self getrandomweaponfromcategory();
  }

  self setCanDamage(1);
  self.health = 150;
  thread func_6B45();
}

func_495A(var_0) {
  if(!isDefined(level.var_6A65)) {
    level.var_6A65 = [];
  }

  level.var_6A65[var_0] = [];
}

func_7CA8(var_0) {
  return level.var_6A65[var_0];
}

func_174C(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.var_6A65)) {
    level.var_6A65 = [];
  }

  if(!isDefined(level.var_6A65[var_0])) {
    func_495A(var_0);
  }

  var_5 = level.var_6A65[var_0].size;
  level.var_6A65[var_0][var_5] = [];
  level.var_6A65[var_0][var_5]["priority"] = var_4;
  level.var_6A65[var_0][var_5]["stateName"] = var_1;
  level.var_6A65[var_0][var_5]["thinkFunc"] = var_2;
  level.var_6A65[var_0][var_5]["changeFunc"] = var_3;
  level.var_6A65[var_0] = scripts\engine\utility::array_sort_with_func(level.var_6A65[var_0], ::is_higher_priority);
}

func_E092(var_0, var_1) {
  if(!isDefined(level.var_6A65[var_0])) {
    return;
  }

  var_2 = [];
  foreach(var_4 in level.var_6A65[var_0]) {
    if(var_4["stateName"] != var_1) {
      var_2[var_2.size] = var_4;
    }
  }

  level.var_6A65[var_0] = var_2;
}

func_6B15() {
  func_F8BE();
  if(self.team == "allies" && isDefined(self.name)) {
    scripts\sp\names::func_7B05();
    self func_8307(self.name, &"");
  } else if(self.team == "axis") {
    self func_8307("enemy", &"");
  }

  if(isDefined(self.var_EE2C)) {
    self.moveplaybackrate = self.var_EE2C;
  } else {
    self.moveplaybackrate = 1;
  }

  if(!isDefined(self.var_EDB7) || !self.var_EDB7) {
    level thread scripts\sp\friendlyfire::func_73B1(self);
  }

  self func_839E();
  if(isDefined(self.target)) {
    var_0 = scripts\engine\utility::getstruct(self.target, "targetname");
    if(isDefined(var_0) && var_0 scripts\sp\fakeactor_node_MAYBE::func_9BE0()) {
      if(func_9B69()) {
        func_1164B(var_0);
        return;
      }

      func_F31D(var_0);
      return;
    }
  }
}

func_6B45() {
  waittillframeend;
  thread func_12E30();
  thread func_BC42();
  thread func_13924();
  thread func_B282();
  thread func_4E22();
}

func_B282() {
  self endon("death");
  thread func_DD7E();
  self waittill("make_real_ai");
  scripts\sp\utility::func_1101B();
  var_0 = self.var_394;
  var_1 = "";
  if(isDefined(self.var_4B94) && isDefined(self.var_4B94.target)) {
    var_1 = self.var_4B94.target;
  }

  var_2 = lib_0B77::func_10869(self, var_1);
  var_2 scripts\anim\shared::placeweaponon(var_0, "right");
  if(isDefined(self)) {
    self delete();
  }
}

func_13949() {
  self endon("death");
  self endon("goal");
  var_0 = squared(128);
  for(;;) {
    if(distancesquared(level.player getorigin(), self.origin) < var_0) {
      func_C2C9(1);
    } else {
      func_C2C9(0);
    }

    wait(0.05);
  }
}

func_DD7E() {
  self endon("death");
  self endon("make_real_ai");
  if(!isDefined(self.fgetarg) || self.fgetarg <= 0) {
    return;
  }

  for(;;) {
    if(distancesquared(level.player getEye(), self.origin) < squared(self.fgetarg)) {
      self notify("make_real_ai");
      return;
    }

    wait(0.05);
  }
}

func_3DBA() {
  if(func_9C0B()) {
    return 0;
  }

  return self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B2B(self);
}

func_3C4D(var_0) {
  self.var_D8A6 = self.current_state;
  self notify("change_state");
  func_40C8();
  self.current_state = var_0["stateName"];
  self thread[[var_0["thinkFunc"]]]();
}

func_174D(var_0) {
  if(!isDefined(self.var_4BBF)) {
    self.var_4BBF = [];
  }

  self.var_4BBF[self.var_4BBF.size] = var_0;
}

func_40C8() {
  if(isDefined(self.var_4BBF)) {
    foreach(var_1 in self.var_4BBF) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }
  }
}

func_12E30() {
  self endon("death");
  self endon("make_real_ai");
  self.var_D8A6 = "";
  var_0 = "default";
  if(isDefined(self.var_10E1D)) {
    var_0 = self.var_10E1D;
  }

  for(;;) {
    wait(0.05);
    if(func_9BA1()) {
      continue;
    }

    foreach(var_2 in func_7CA8(var_0)) {
      if(isDefined(self.current_state) && self.current_state == var_2["stateName"]) {
        continue;
      }

      if([[var_2["changeFunc"]]]()) {
        func_3C4D(var_2);
        break;
      }
    }
  }
}

func_92D9() {
  if(!isDefined(self.current_state)) {
    return 1;
  }

  if(self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B2B(self)) {
    return 1;
  }

  return 0;
}

func_92EE() {
  self endon("death");
  self endon("change_state");
  func_6B11();
  self notify("goal");
  while(isDefined(self)) {
    if(isDefined(self.var_92D2)) {
      func_CE00(func_7A2A());
      continue;
    }

    childthread func_6BDE();
    self waittill("start_next_fight");
  }
}

func_6BDE() {
  self endon("death");
  self endon("change_state");
  if(!isDefined(self.precacheleaderboards)) {
    if(isDefined(self.var_4B94)) {
      var_0 = self.var_4B94 scripts\sp\utility::func_7A8F();
      var_0 = scripts\engine\utility::array_combine(var_0, self.var_4B94 scripts\sp\utility::func_7A97());
      if(var_0.size) {
        var_1 = scripts\engine\utility::random(var_0);
        var_2 = (0, 0, 0);
        if(isDefined(var_1.fgetarg)) {
          var_3 = randomfloatrange(var_1.fgetarg * -1, var_1.fgetarg);
          var_4 = randomfloatrange(var_1.fgetarg * -1, var_1.fgetarg);
          var_2 = (var_3, var_4, 0);
        }

        func_F297(var_1, var_2);
      }
    }

    var_5 = func_7A04();
    var_6 = func_77E9();
    var_7 = self.origin;
    if(isDefined(var_5) && isDefined(var_6)) {
      func_CE00(var_5);
    }

    self notify("start_aim");
    func_6D53(func_7C63());
    self notify("end_aim");
    if(isDefined(var_5) && isDefined(var_6)) {
      func_CE00(var_6);
    }

    if(func_FF45()) {
      var_8 = func_7C03();
      if(isDefined(var_8)) {
        func_CE00(var_8);
      }
    }

    if(scripts\engine\utility::cointoss()) {
      var_9 = self.var_1FD0;
      func_CB1F();
      if(self.var_1FD0 != var_9) {
        func_CE00(func_7C9F());
      }
    }
  }

  func_CE00(func_7A2A());
  func_F613(1);
  self notify("start_next_fight");
}

func_126D0() {
  if(isDefined(self.var_4B94) && self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B2B(self) && self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B32()) {
    return 1;
  }

  return 0;
}

func_126D9() {
  self endon("death");
  func_F30A(1);
  var_0 = func_57D2(self.var_4B94.var_126CD);
  func_F30A(0);
  func_F613(1);
}

func_12944() {
  if(self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B2B(self) && self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B33()) {
    return 1;
  }

  return 0;
}

func_12999() {
  self endon("death");
  func_F30A(1);
  var_0 = self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B20();
  func_CE00(func_7D21(self.angles, self.origin, var_0.origin));
  func_F30A(0);
  func_F613(1);
}

func_CC86() {
  if(isDefined(self.var_4B94) && self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B2B(self) && self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B2A()) {
    if(!isDefined(self.var_4B94.var_A880) || self.var_4B94.var_A880 != self) {
      return 1;
    }
  }

  return 0;
}

func_CC8A() {
  self endon("death");
  func_F30A(1);
  self.var_4B94.var_1EEF scripts\sp\anim::func_1ED1(self, self.var_4B94.animation);
  self.var_4B94.var_A880 = self;
  func_F30A(0);
  func_F613(1);
  self notify("played_anim");
}

func_57D2(var_0) {
  var_1 = func_7D19(var_0);
  func_CE00(var_1, undefined, scripts\anim\traverse\shared::func_89F8, "traverseAnim", self.var_4B94);
}

func_BC42() {
  self endon("death");
  self endon("make_real_ai");
  for(;;) {
    self waittill("move");
    func_F613(1);
  }
}

func_BC1C() {
  if(isDefined(self.var_72A9)) {
    self.var_C039 = self.var_72A9;
    self.var_72A9 = undefined;
    return 1;
  }

  if(!isDefined(self.var_4B94)) {
    return 0;
  }

  var_0 = func_582B();
  var_1 = undefined;
  if(!isDefined(self.current_state) && isDefined(self.var_4B94)) {
    var_1 = scripts\sp\fakeactor_node_MAYBE::func_6B21(self.var_4B94, self.origin, func_9BE8(), var_0);
  }

  if(self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B2B(self) && !self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B2D(var_0)) {
    var_2 = self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B20();
    var_1 = scripts\sp\fakeactor_node_MAYBE::func_6B21(var_2, self.origin, func_9BE8(), var_0);
  }

  if(isDefined(var_1)) {
    foreach(var_4 in var_1) {
      if(var_4["dist"] > 0) {
        self.var_C039 = var_1;
        return 1;
      }
    }
  }

  return 0;
}

func_CDEB() {
  self endon("death");
  self endon("change_state");
  self notify("stop_running_anim");
  self endon("stop_running_anim");
  var_0 = 1;
  if(isDefined(self.var_E812) && isDefined(self.var_E811)) {
    var_0 = randomfloatrange(self.var_E812, self.var_E811);
  }

  for(;;) {
    var_1 = func_7AFA();
    var_2 = func_7816(var_1);
    var_3 = var_2.var_E81C;
    var_4 = var_2.var_1F1D;
    play_looping_breath_sound(var_1, var_0);
    wait(getanimlength(var_1));
  }
}

func_BC82() {
  self endon("death");
  self endon("change_state");
  self notify("exit_node");
  var_0 = self.origin;
  var_1 = func_582B();
  if(self.var_C039.size == 0) {}

  self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B36(self);
  var_2 = func_7AFA();
  var_3 = func_7816(var_2);
  var_4 = var_3.var_E81C;
  var_5 = var_3.var_1F1D;
  if(!var_5) {
    childthread func_AEE8(var_4);
  }

  var_6 = self.var_C039[self.var_C039.size - 1];
  if(self.var_C039[0]["total_dist"] < 64) {
    thread func_CE00(func_7A2A());
    var_7 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
    func_174D(var_7);
    self linkto(var_7);
    var_8 = 0.2;
    var_7 moveto(var_6["origin"], var_8);
    var_7 rotateto(var_6["angles"], var_8);
    scripts\engine\utility::waittill_notify_or_timeout("death", var_8);
    self unlink();
    var_7 delete();
    if(self.var_4B94 != var_6["node"]) {
      self.var_4B94 = var_6["node"];
    }

    self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B37(self);
    func_6B12(self.var_4B94);
    func_F613(0);
    self notify("arrive_node");
    return;
  }

  var_9 = 0;
  var_0A = undefined;
  if(func_FF2F()) {
    var_0B = 0;
    foreach(var_0D in self.var_C039) {
      if(var_0B) {
        var_0A = var_0D["origin"];
        break;
      }

      if(var_0D["dist"] > 0) {
        var_0B = 1;
      }
    }

    if(isDefined(var_0A)) {
      var_0F = func_79A4(var_0A);
      func_CE00(var_0F);
    }
  }

  var_10 = undefined;
  var_11 = scripts\engine\utility::random(var_8["node"] scripts\sp\fakeactor_node_MAYBE::func_6B1F());
  if(func_FF2C() && !var_8["node"] scripts\sp\fakeactor_node_MAYBE::func_6B32() && !var_8["node"] scripts\sp\fakeactor_node_MAYBE::func_6B33() && var_8["node"] scripts\sp\fakeactor_node_MAYBE::func_6B18()) {
    var_12 = self;
    if(isDefined(self.var_C039[self.var_C039.size - 2]["node"])) {
      var_12 = self.var_C039[self.var_C039.size - 2]["node"];
    }

    var_10 = func_7836(var_8["node"], var_12, var_11);
    if(isDefined(var_10)) {
      var_13 = getmovedelta(var_10, 0, 1);
      var_14 = getangledelta3d(var_10, 0, 1);
      var_15 = invertangles(var_14);
      var_16 = combineangles(var_8["angles"], var_15);
      var_17 = var_8["origin"] - rotatevector(var_13, var_16);
      var_8["anim_node"] = scripts\engine\utility::spawn_script_origin(var_17, var_16);
      func_174D(var_8["anim_node"]);
      var_8["origin"] = var_17;
      var_8["angles"] = var_16;
    }
  }

  thread func_CDEB();
  thread func_13949();
  self.var_4B94 = self.var_C039[var_9 + 1]["node"];
  var_18 = 1;
  if(isDefined(self.var_BC68)) {
    var_18 = self.var_BC68;
  }

  for(;;) {
    var_19 = self.var_C039[var_9]["to_next_node"];
    var_1A = self.origin - self.var_C039[var_9]["origin"];
    var_1B = vectordot(var_19, var_1A);
    if(var_9 == self.var_C039.size) {
      break;
    }

    var_1C = var_1B + self.var_AFED;
    while(var_1C > self.var_C039[var_9]["dist"]) {
      var_1C = var_1C - self.var_C039[var_9]["dist"];
      var_9++;
      if(var_9 == self.var_C039.size) {
        if(self.var_4B94 != var_8["node"]) {
          self.var_4B94 = var_8["node"];
        }

        var_8 = 0;
        var_1D = (0, 0, 0);
        var_1E = (0, 0, 0);
        var_1F = (0, 0, 0);
        if(func_9B69()) {
          var_20 = self.var_C039[self.var_C039.size - 1]["origin"] - self.origin;
          var_21 = length(var_20);
          var_1E = anglestoup(self.angles);
          var_1D = vectornormalize(var_20);
          var_1F = vectorcross(var_1D, var_1E);
          var_1D = vectorcross(var_1E, var_1F);
          if(var_21 > 0) {
            var_23 = var_21 / var_5 * var_11;
          }
        } else {
          var_20 = var_9["origin"] - self.origin;
          var_1E = vectortoangles(var_21);
          var_21 = length(var_21);
          var_23 = var_21 / var_5 * var_11;
        }

        if(var_23 > 0) {
          if(var_6) {
            self moveto(var_7["origin"], var_23);
            if(func_9B69()) {
              self rotateto(axistoangles(var_1D, var_1F, var_1E), var_23);
            } else {
              self rotateto(var_1D, var_23 * 0.25);
            }

            wait(var_23);
          } else {
            var_7 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
            func_174D(var_21);
            self linkto(var_21);
            var_21 moveto(var_6["origin"], var_22);
            if(func_9B69()) {
              var_21 rotateto(axistoangles(var_23, var_1E, var_1D), var_22);
            } else {
              var_21 rotateto(var_23, var_22 * 0.25);
            }

            scripts\engine\utility::waittill_notify_or_timeout("death", var_22);
            self unlink();
            var_21 delete();
          }
        }

        if(isDefined(var_9)) {
          self notify("stop_running_anim");
          func_CE00(var_9, undefined, undefined, undefined, var_6["anim_node"], 0);
          var_6["anim_node"] delete();
          func_F2C3([var_0A]);
        } else {
          self.angles = var_6["angles"];
          func_F2C3(self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B1F());
        }

        self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B37(self);
        func_6B12(self.var_4B94);
        self notify("stop_running_anim");
        func_F613(0);
        self notify("arrive_node");
        self notify("reached_path_end");
        self notify("goal");
        return;
      } else if(self.var_4B94 != self.var_C039[var_18]["node"]) {
        self.var_4B94 = self.var_C039[var_18]["node"];
        func_F2C3(self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B1F());
        func_6B12(self.var_4B94);
      }
    }

    var_1F = self.var_C039[var_18]["to_next_node"] * var_1E;
    var_1F = var_1F + self.var_C039[var_18]["origin"];
    var_20 = var_1F;
    if(!var_10) {
      self.var_AFEC = var_20;
    }

    if(func_9B69()) {
      var_1E = anglestoup(self.angles);
      var_1D = vectornormalize(var_1F - self.origin);
      var_1F = vectorcross(var_20, var_1F);
      var_1F = vectorcross(var_1E, var_20);
      self rotateto(axistoangles(var_1F, var_20, var_1E), self.var_B04E);
    } else {
      var_16 = vectortoangles(var_1D - self.origin);
      childthread func_6B40(var_16, self.var_B04E);
    }

    if(var_8) {
      var_24 = var_7 * self.var_B04E * self.var_BC68;
      var_25 = vectornormalize(var_1D - self.origin);
      var_23 = var_25 * var_24;
      var_23 = var_23 + self.origin;
      self moveto(var_23, self.var_B04E);
    }

    if(getdvar("debug_fakeactor") == "1") {}

    wait(self.var_B04E);
  }

  self.var_C039 = undefined;
  func_F613(0);
  self notify("arrive_node");
  self notify("reached_path_end");
  self notify("goal");
}

func_6B40(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = anglesToForward(var_0);
  var_4 = 0;
  var_5 = 1 / var_1;
  for(;;) {
    var_6 = var_4 * var_5;
    var_7 = vectorlerp(var_2, var_3, var_6);
    self.angles = vectortoangles(var_7);
    var_4 = var_4 + 0.05;
    wait(0.05);
    if(var_4 >= var_1) {
      break;
    }
  }

  self.angles = var_0;
}

func_6B11() {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.script_noteworthy)) {
    return;
  }

  switch (self.script_noteworthy) {
    case "delete_on_goal":
      if(isDefined(self.var_B14F)) {
        scripts\sp\utility::func_1101B();
      }

      self delete();
      break;

    case "die_on_goal":
      self func_81D0();
      break;
  }
}

func_6B12(var_0) {
  if(isDefined(var_0.script_noteworthy)) {
    switch (var_0.script_noteworthy) {
      case "delete_on_goal":
        if(isDefined(self.var_B14F)) {
          scripts\sp\utility::func_1101B();
        }

        self delete();
        break;

      case "die_on_goal":
        self func_81D0();
        break;
    }
  }

  if(isDefined(var_0.var_ED9E)) {
    scripts\engine\utility::flag_set(var_0.var_ED9E);
  }

  if(isDefined(var_0.var_ED9B)) {
    scripts\engine\utility::flag_clear(var_0.var_ED9B);
  }

  if(isDefined(var_0.var_ED80)) {
    scripts\sp\utility::func_65E1(var_0.var_ED80);
  }

  if(isDefined(self.var_ED7F)) {
    scripts\sp\utility::func_65E1(var_0.var_ED7F);
  }

  if(isDefined(var_0.var_ED56)) {
    if(var_0.var_ED56 == "frantic") {
      func_F3BE(1);
    }
  }

  if(isDefined(var_0.var_ED60)) {
    func_F35C(var_0.var_ED60);
  }

  if(isDefined(var_0.var_ED62)) {
    func_F35D(var_0.var_ED62);
  }

  if(isDefined(var_0.var_ECF9)) {
    func_F2C6(var_0.var_ECF9);
  }

  if(isDefined(var_0.var_EEFF)) {
    func_F568(var_0.var_EEFF);
  }

  if(isDefined(var_0.var_EEFE)) {
    func_F5F9(var_0.var_EEFE);
  }
}

func_AEE8(var_0) {
  self endon("death");
  self endon("change_state");
  self notify("drone_move_z");
  self endon("drone_move_z");
  var_1 = 0.05;
  for(;;) {
    if(isDefined(self.var_AFEC) && var_0 > 0) {
      if(func_9B69()) {
        var_2 = anglestoup(self.angles);
        var_3 = scripts\common\trace::ray_trace(self.origin + var_2 * 40, self.origin + var_2 * -40, self, scripts\common\trace::create_solid_ai_contents(1));
        if(var_3["hittype"] != "hittype_none") {
          self.origin = var_3["position"];
        }
      } else {
        var_4 = self.var_AFEC[2] - self.origin[2];
        var_5 = distance2d(self.var_AFEC, self.origin);
        var_6 = var_5 / var_0;
        if(var_6 > 0 && var_4 != 0) {
          var_7 = abs(var_4) / var_6;
          var_8 = var_7 * var_1;
          if(var_4 >= var_7) {
            self.origin = (self.origin[0], self.origin[1], self.origin[2] + var_8);
          } else if(var_4 <= var_7 * -1) {
            self.origin = (self.origin[0], self.origin[1], self.origin[2] - var_8);
          }
        }
      }
    }

    wait(var_1);
  }
}

func_F31D(var_0) {
  if(isDefined(self.var_4B94)) {
    self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B36(self);
  }

  self.var_72A9 = undefined;
  self.var_4B94 = var_0;
  func_F2C3(self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B1F());
}

func_1164B(var_0) {
  func_F31D(var_0);
  self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B37(self);
  func_6B12(self.var_4B94);
  self dontinterpolate();
  self.origin = self.var_4B94.origin;
  self.angles = self.var_4B94 scripts\sp\fakeactor_node_MAYBE::func_6B1E(func_9BE8());
}

func_416B() {
  if(isDefined(self.var_C039)) {
    foreach(var_1 in self.var_C039) {
      if(isDefined(var_1["node"])) {
        var_1["node"] scripts\sp\fakeactor_node_MAYBE::func_6B36(self);
      }
    }
  }
}

func_FF45() {
  if(self.var_1FD0 == "exposed") {
    return 0;
  }

  if(isDefined(self.var_1A2C)) {
    return func_9CE3();
  }

  return 1;
}

func_6D53(var_0) {
  self endon("death");
  childthread func_1A2E();
  wait(0.25);
  var_1 = weaponclipsize(self.var_394);
  var_2 = weaponfiretime(self.var_394);
  var_3 = weaponburstcount(self.var_394);
  var_4 = weaponclass(self.var_394);
  var_5 = var_1;
  if(var_4 == "sniper") {
    var_5 = 5;
  } else if(var_3 > 0) {
    var_5 = var_3;
  }

  while(var_5 > 0) {
    if(func_FF45()) {
      var_6 = self gettagorigin("tag_flash");
      var_7 = self gettagangles("tag_flash");
      var_8 = anglesToForward(var_7);
      var_9 = var_6 + var_8 * 1000;
      if(isDefined(self.var_1A2C)) {
        var_0A = scripts\common\trace::ray_trace(var_6, var_9, self);
        if(isDefined(var_0A["entity"]) && var_0A["entity"] == self.var_1A2C) {
          var_0B = func_77C8();
          if(randomfloat(1) > var_0B) {
            var_0C = self.var_1A2C physics_getcharactercollisioncapsule();
            var_0D = anglestoup(self.var_1A2C.angles);
            var_0E = randomfloatrange(0, var_0C["half_height"] * 2);
            var_0F = anglestoright(self.var_1A2C.angles);
            var_10 = var_0C["radius"] * randomfloatrange(1, 2);
            if(scripts\engine\utility::cointoss()) {
              var_10 = var_10 * -1;
            }

            var_11 = self.var_1A2C.origin + var_0D * var_0E + var_0F * var_10;
            var_8 = vectornormalize(var_11 - var_6);
            var_9 = var_6 + var_8 * 1000;
          }
        }
      }

      if(func_FF81()) {
        magicbullet(self.var_394, var_6, var_9);
      } else {
        func_6ADC(self.var_394, var_6, var_9, self.var_C01E);
      }

      self func_82AB(var_0, 1, 0.2, 1);
      scripts\engine\utility::delaycall(0.15, ::clearanim, var_0, 0);
    }

    var_5--;
    wait(max(var_2, 0.1));
  }
}

func_77C8(var_0) {
  var_1 = self.var_2894;
  var_2 = 1;
  if(isDefined(self.var_1A2C) && isDefined(self.var_1A2C.var_50)) {
    var_2 = self.var_1A2C.var_50;
  }

  var_3 = distance(self.origin, self.var_1A2C.origin);
  var_4 = getaccuracyfraction(self.var_394, var_3, isplayer(self.var_1A2C));
  var_5 = "stand";
  if(isplayer(self.var_1A2C)) {
    var_5 = self.var_1A2C getstance();
  } else if(isai(self.var_1A2C)) {
    var_5 = self.var_1A2C.a.pose;
  }

  var_6 = 1;
  if(var_5 == "crouch") {
    var_6 = 0.75;
  } else if(var_5 == "prone") {
    var_6 = 0.5;
  }

  var_7 = 1;
  if(isplayer(self.var_1A2C)) {
    var_8 = level.player getnormalizedmovement();
    var_7 = 1 - length(var_8) * 0.3;
  } else if(isai(self.var_1A2C)) {}

  var_9 = 0.75;
  var_0A = var_1 * var_2 * var_4 * var_6 * var_7 * var_9;
  return var_0A;
}

func_6ADC(var_0, var_1, var_2, var_3) {
  bullettracer(var_1, var_2, var_0);
  playFXOnTag(scripts\engine\utility::getfx("fakeactor_muzflash"), self, "tag_flash");
  if(!isDefined(var_3) || !var_3) {}
}

func_7CDD(var_0) {
  if(isplayer(var_0)) {
    if(func_9C07()) {
      var_1 = 50;
    } else {
      var_1 = 50;
    }

    var_2 = var_0 getplayerangles();
    var_3 = var_0 getorigin() + anglestoup(var_2) * var_1;
    return var_3;
  }

  if(isai(var_3)) {
    return var_3 gettagorigin("j_SpineUpper");
  }

  var_3 = var_3.origin;
  if(isDefined(self.var_1A2D)) {
    var_3 = var_3 + self.var_1A2D;
  }

  return var_3;
}

func_1A2E() {
  self endon("end_aim");
  var_0 = 0.2;
  var_1 = func_77E7("aim_5");
  if(isDefined(var_1)) {
    self func_82A5(var_1, self.var_1EA4["body"], 1, var_0);
  }

  self func_82AC(func_77E7("aim_2"), 1, var_0);
  self func_82AC(func_77E7("aim_4"), 1, var_0);
  self func_82AC(func_77E7("aim_6"), 1, var_0);
  self func_82AC(func_77E7("aim_8"), 1, var_0);
  var_2 = 10;
  var_3 = 0;
  var_4 = 0;
  var_5 = 1;
  while(isDefined(self.var_1A2C)) {
    var_6 = self gettagorigin("tag_flash");
    var_7 = func_7CDD(self.var_1A2C);
    var_8 = scripts\sp\utility::func_13DCC(var_7) - scripts\sp\utility::func_13DCC(var_6);
    var_9 = vectortoangles(var_8);
    var_0A = angleclamp180(var_9[0]);
    var_0B = angleclamp180(var_9[1]);
    if(var_0A < self.var_368 || var_0A > self.isbot || var_0B < self.setdevdvar || var_0B > self.setmatchdatadef) {
      func_F5BF(0);
      var_0A = 0;
      var_0B = 0;
    } else {
      func_F5BF(1);
    }

    if(getdvar("debug_fakeactor") == "1") {
      var_0C = self gettagangles("tag_origin");
      scripts\engine\utility::draw_angles(var_0C, self gettagorigin("tag_origin"));
    }

    if(!var_5) {
      var_0D = var_0B - var_3;
      if(abs(var_0D) > var_2) {
        var_0B = var_3 + clamp(var_0D, -1 * var_2, var_2);
      }

      var_0E = var_0A - var_4;
      if(abs(var_0E) > var_2) {
        var_0A = var_4 + clamp(var_0E, -1 * var_2, var_2);
      }
    }

    var_0A = clamp(var_0A, self.var_368, self.isbot);
    var_0B = clamp(var_0B, self.setdevdvar, self.setmatchdatadef);
    var_5 = 0;
    var_3 = var_0B;
    var_4 = var_0A;
    func_1A31(self.var_1EA4["aim_2"], self.var_1EA4["aim_4"], self.var_1EA4["aim_6"], self.var_1EA4["aim_8"], var_0A, var_0B);
    wait(0.05);
  }
}

func_7821(var_0, var_1, var_2, var_3) {
  var_4 = archetypegetalias(var_0, var_1, var_2, var_3);
  if(isDefined(var_4)) {
    if(isarray(var_4.var_47)) {
      if(isDefined(var_4.var_39E)) {
        var_5 = randomfloat(1);
        var_6 = 0;
        for(var_7 = 0; var_7 < var_4.var_47.size; var_7++) {
          var_6 = var_6 + var_4.var_39E[var_7];
          if(var_6 >= var_5) {
            return var_4.var_47[var_7];
          }
        }

        return;
      }

      var_5 = randomint(var_7.var_47.size);
      return var_6.var_47[var_7];
    }

    return var_7.var_47;
  }
}

func_7820(var_0, var_1) {
  var_2 = func_7821(self.var_1FA8, var_0, var_1, func_9BE8());
  if(isarray(var_2)) {
    var_2 = scripts\engine\utility::random(var_2);
  }

  return var_2;
}

func_7A2A() {
  if(isDefined(self.var_92D2)) {
    return self.var_92D2;
  }

  if(scripts\engine\utility::cointoss()) {
    if(self.var_1FD0 == "exposed") {
      if(self.var_1FA8 == "zero_gravity") {
        return func_7820("NonCombat_Stand_Idle", "noncombat_stand_idle");
      }

      return func_7820("noncombat_stand_idle", "noncombat_stand_idle");
    }

    return func_7820(self.var_1FD0, "hide_loop");
  }

  switch (self.var_1FD0) {
    case "cover_right_crouch":
    case "cover_left":
    case "cover_right":
      return func_7820(self.var_1FD0, "hide_loop");

    case "exposed":
      return func_7820("noncombat_stand_idle", "noncombat_stand_idle_twitch");

    case "cover_left_crouch":
    case "cover_stand":
    case "cover_crouch":
      return func_7820(self.var_1FD0 + "_peek", "peek");
  }
}

func_7AFA() {
  if(isDefined(self.var_E7DA)) {
    return self.var_E7DA;
  }

  return func_7820("stand_run_loop", "default");
}

func_7D21(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_1);
  var_4 = var_0[1] - var_3[1];
  var_4 = var_4 + 360;
  var_4 = int(var_4) % 360;
  var_5 = "";
  if(var_4 > 315 || var_4 < 45) {
    return undefined;
  } else if(var_4 >= 150 && var_4 <= 210) {
    var_5 = "2";
  } else if(var_4 < 90) {
    var_5 = "9";
  } else if(var_4 > 270) {
    var_5 = "7";
  } else if(var_4 < 135) {
    var_5 = "6";
  } else if(var_4 > 225) {
    var_5 = "4";
  } else if(var_4 < 150) {
    var_5 = "3";
  } else if(var_4 > 210) {
    var_5 = "1";
  }

  return func_7820("run_turn", "left" + var_5);
}

func_7C63() {
  switch (self.var_1FD0) {
    case "cover_left_crouch":
    case "cover_right_crouch":
    case "cover_crouch":
      return func_7820("crouch_shoot_full", "fire");

    case "cover_stand":
    case "cover_left":
    case "cover_right":
      return func_7820("shoot_full", "fire");

    case "exposed":
      return func_7820("shoot_full", "fire");
  }
}

func_77E7(var_0) {
  switch (self.var_1FD0) {
    case "cover_crouch":
      return func_7820("cover_crouch_aim", "rifle_" + var_0);

    case "cover_left_crouch":
      if(var_0 == "aim_5") {
        return undefined;
      }
      return func_7820("cover_crouch_exposed_left", "rifle_" + var_0);

    case "cover_right_crouch":
      if(var_0 == "aim_5") {
        return undefined;
      }
      return func_7820("cover_crouch_exposed_right", "rifle_" + var_0);

    case "cover_stand":
      return func_7820("cover_stand_exposed", "rifle_" + var_0);

    case "cover_left":
      if(var_0 == "aim_5") {
        return undefined;
      }
      return func_7820("cover_left_exposed_B", "rifle_" + var_0);

    case "cover_right":
      if(var_0 == "aim_5") {
        return undefined;
      }
      return func_7820("cover_right_exposed_B", "rifle_" + var_0);

    case "exposed":
      return func_7820("exposed_idle", "rifle_" + var_0);
  }
}

func_7A04() {
  switch (self.var_1FD0) {
    case "cover_crouch":
      return func_7820("cover_crouch_hide_to_aim", "hide_to_aim");

    case "cover_stand":
      return func_7820("cover_stand_hide_to_exposed", "hide_to_exposed");

    case "cover_left":
      return func_7820("cover_left_hide_to_B", "hide_to_exposed");

    case "cover_right":
      return func_7820("cover_right_hide_to_B", "hide_to_exposed");

    case "cover_left_crouch":
      return func_7820("cover_left_crouch_hide_to_B", "hide_to_B");

    case "cover_right_crouch":
      return func_7820("cover_right_crouch_hide_to_B", "hide_to_B");
  }

  return undefined;
}

func_77E9() {
  switch (self.var_1FD0) {
    case "cover_crouch":
      return func_7820("cover_crouch_aim_to_hide", "aim_to_hide");

    case "cover_stand":
      return func_7820("cover_stand_exposed_to_hide", "exposed_to_hide");

    case "cover_left":
      return func_7820("cover_left_B_to_hide", "exposed_to_hide");

    case "cover_right":
      return func_7820("cover_right_B_to_hide", "exposed_to_hide");

    case "cover_left_crouch":
      return func_7820("cover_left_crouch_B_to_hide", "B_to_hide");

    case "cover_right_crouch":
      return func_7820("cover_right_crouch_B_to_hide", "B_to_hide");
  }

  return undefined;
}

func_7836(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = self.var_1FD0;
  }

  if(!isDefined(var_1)) {
    var_1 = self;
  }

  var_3 = var_2 + "_arrival";
  var_4 = scripts\sp\utility::func_793C(var_0.angles, var_0.origin, var_1.origin);
  switch (var_2) {
    case "cover_crouch":
      if(var_4 == "9") {
        var_4 = "6";
      } else if(var_4 == "7" || var_4 == "8") {
        var_4 = "4";
      }
      break;

    case "cover_stand":
      if(var_4 == "9") {
        var_4 = "6";
      } else if(var_4 == "7" || var_4 == "8") {
        var_4 = "4";
      }
      break;

    case "cover_left":
      if(var_4 == "9") {
        var_4 = "8";
      }
      break;

    case "cover_right":
      if(var_4 == "7") {
        var_4 = "8";
      }
      break;

    case "cover_left_crouch":
      if(var_4 == "9") {
        var_4 = "8";
      }
      break;

    case "cover_right_crouch":
      if(var_4 == "7") {
        var_4 = "8";
      }
      break;

    case "exposed":
      break;

    default:
      return undefined;
  }

  if(func_9C07()) {
    var_5 = "left" + var_4;
  } else {
    var_5 = var_5;
  }

  return func_7820(var_3, var_5);
}

func_79A4(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  if(!isDefined(var_2)) {
    var_2 = self.angles;
  }

  if(!isDefined(var_3)) {
    var_3 = self.var_1FD0;
  }

  var_4 = var_3 + "_exit";
  var_5 = scripts\sp\utility::func_793C(var_2, var_1, var_0);
  switch (var_3) {
    case "cover_crouch":
      if(var_5 == "9") {
        var_5 = "6";
      } else if(var_5 == "7" || var_5 == "8") {
        var_5 = "4";
      }
      return func_7820(var_4, var_5);

    case "cover_stand":
      if(var_5 == "9") {
        var_5 = "6";
      } else if(var_5 == "7" || var_5 == "8") {
        var_5 = "4";
      }
      return func_7820(var_4, var_5);

    case "cover_left":
      if(var_5 == "9") {
        var_5 = "8";
      }
      return func_7820(var_4, var_5);

    case "cover_right":
      if(var_5 == "7") {
        var_5 = "8";
      }
      return func_7820(var_4, var_5);

    case "cover_left_crouch":
      if(var_5 == "9") {
        var_5 = "8";
      }
      return func_7820(var_4, var_5);

    case "cover_right_crouch":
      if(var_5 == "7") {
        var_5 = "8";
      }
      return func_7820(var_4, var_5);

    case "exposed":
      return func_7820(var_4, var_5);

    default:
      return undefined;
  }
}

func_7C03() {
  if(self.var_1FD0 == "exposed") {
    return func_7820("Exposed_Reload", "rifle");
  }

  var_0 = self.var_1FD0 + "_reload";
  return func_7820(var_0, "reload");
}

func_7C9F() {
  switch (self.var_1FD0) {
    case "cover_crouch":
      return func_7820("exposed_stand_to_crouch", "stand_to_crouch");

    case "cover_stand":
      return func_7820("exposed_crouch_to_stand", "crouch_to_stand");

    case "cover_left":
      return func_7820("cover_left_crouch_to_stand", "crouch_to_stand");

    case "cover_left_crouch":
      return func_7820("cover_left_stand_to_crouch", "stand_to_crouch");

    case "cover_right":
      return func_7820("cover_right_crouch_to_stand", "crouch_to_stand");

    case "cover_right_crouch":
      return func_7820("cover_right_stand_to_crouch", "stand_to_crouch");
  }

  return undefined;
}

func_7B62() {
  if(func_9C44()) {
    var_0 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "short", "medium");
    return func_7820("pain_run_default", var_0);
  }

  switch (self.var_1FD0) {
    case "cover_crouch":
      return func_7820("pain_cover_crouch_default", "crouch");

    case "cover_stand":
      return func_7820("pain_cover_stand_default", "stand");

    case "cover_left":
      return func_7820("pain_cover_left_default", "stand");

    case "cover_right":
      return func_7820("pain_cover_right_default", "stand");

    case "cover_left_crouch":
      return func_7820("pain_cover_left_default", "crouch");

    case "cover_right_crouch":
      return func_7820("pain_cover_right_default", "crouch");

    default:
      return func_7820("pain_stand_torso", "default");
  }
}

func_7927() {
  if(isDefined(self.var_A8A3) && self.var_A8A3 == "MOD_EXPLOSIVE") {
    var_0 = scripts\engine\utility::random(["explosive_f", "explosive_l", "explosive_r"]);
    if(func_9C44()) {
      return func_7820("death_moving_explosive", var_0);
    }

    return func_7820("death_explosive", var_0);
  }

  if(func_9C44()) {
    if(scripts\engine\utility::cointoss()) {
      var_0 = scripts\engine\utility::random(["death_pain_stand_head", "death_pain_stand_l_arm", "death_pain_stand_r_arm", "death_pain_stand_torso"]);
      return func_7820(var_0, "default");
    }

    var_1 = scripts\engine\utility::random(["running_forward_2", "running_forward_4", "running_forward_6", "running_forward_8"]);
    return func_7820("death_moving_default", var_1);
  }

  switch (self.var_1FD0) {
    case "cover_crouch":
      return func_7820("death_cover_default", "crouch_default");

    case "cover_stand":
      return func_7820("death_cover_default", "stand");

    case "cover_left":
      return func_7820("death_cover_default", "left_stand");

    case "cover_right":
      return func_7820("death_cover_default", "right_stand");

    case "cover_left_crouch":
      return func_7820("death_cover_default", "left_crouch");

    case "cover_right_crouch":
      return func_7820("death_cover_default", "right_crouch_default");

    default:
      var_0 = scripts\engine\utility::random(["death_pain_stand_head", "death_pain_stand_l_arm", "death_pain_stand_r_arm", "death_pain_stand_torso"]);
      return func_7820(var_1, "default");
  }
}

func_7D19(var_0) {
  if(issubstr(var_0, "jumpdown")) {
    return func_7820(var_0, "jumpdown");
  }

  if(issubstr(var_0, "jumpover")) {
    return func_7820(var_0, "jumpover");
  }

  if(issubstr(var_0, "jumpup")) {
    return func_7820(var_0, "jumpup");
  }

  return func_7820(var_0, var_0);
}

func_4E22() {
  self endon("entitydeleted");
  func_4D23();
  if(!isDefined(self)) {
    return;
  }

  func_416B();
  if(isDefined(self.var_4E46)) {
    var_0 = self[[self.var_4E46]]();
    if(!isDefined(var_0) || var_0) {
      return;
    }
  }

  var_1 = self.var_4E2A;
  if(!isDefined(var_1)) {
    var_1 = func_7927();
  }

  self notify("death");
  func_40C8();
  func_5D16();
  scripts\anim\face::saygenericdialogue("death");
  if(isDefined(self.noragdoll) && self.noragdoll) {
    if(!isDefined(self.var_10265) || !self.var_10265) {
      func_CE00(var_1, "deathplant");
    }
  } else if(isDefined(self.var_10265) && self.var_10265) {
    self giverankxp();
  } else {
    func_CE00(var_1, "deathplant");
    self giverankxp();
  }

  self notsolid();
  if(isDefined(self) && isDefined(self.nocorpsedelete)) {
    return;
  }

  wait(10);
  while(isDefined(self)) {
    self delete();
    wait(5);
  }
}

func_5D16() {
  var_0 = getweaponmodel(self.var_394);
  if(isDefined(var_0) && var_0 != "") {
    self detach(var_0, "tag_weapon_right");
    if(!isDefined(self.var_C05C)) {
      var_1 = spawn("weapon_" + self.var_394, self gettagorigin("tag_weapon_right"));
      var_1.angles = self gettagangles("tag_weapon_right");
      func_ACDC(var_1);
    }
  }
}

func_ACDC(var_0) {
  if(!isDefined(level.var_6B13)) {
    level.var_6B13 = [];
  }

  var_1 = scripts\engine\utility::array_removeundefined(level.var_6B13);
  var_2 = var_1.size;
  if(var_1.size >= 4) {
    var_1 = sortbydistance(var_1, level.player.origin);
    var_2 = var_2 - 1;
    var_1[var_2] delete();
  }

  var_1[var_2] = var_0;
  level.var_6B13 = var_1;
}

func_4D23() {
  self endon("entitydeleted");
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);
    self.var_A8A3 = var_4;
    if(isDefined(var_1) && isplayer(var_1)) {
      var_1 setclientomnvar("damage_feedback_notify", gettime());
    }

    if(isDefined(self.var_E0) && self.var_E0) {
      self.health = 100000;
      continue;
    }

    if(self.health <= 0) {
      break;
    }

    scripts\anim\face::saygenericdialogue("pain");
    if(!func_13903() && func_FF35()) {
      thread func_57AD();
    }
  }
}

func_57AD() {
  self notify("change_state");
  self notify("stop_damage_pain_anim");
  self endon("stop_damage_pain_anim");
  self endon("death");
  func_F56C(1);
  scripts\engine\utility::delaythread(1.5, ::func_F56C, 0);
  func_416B();
  func_CE00(func_7B62());
  self.current_state = "";
  self.var_72A9 = scripts\sp\fakeactor_node_MAYBE::func_6B21(self.var_4B94, self.origin, func_9BE8(), 1);
}

func_4EC6() {}

func_2294(var_0) {
  var_1 = var_0.team;
  scripts\sp\utility::func_11161(level.var_6B46[var_1], var_0);
  var_0 waittill("death");
  var_0 func_40C8();
  if(isDefined(var_0) && isDefined(var_0.var_11159)) {
    scripts\sp\utility::func_11163(level.var_6B46[var_1], var_0.var_11159);
    return;
  }

  scripts\sp\utility::func_11164(level.var_6B46[var_1]);
}

play_looping_breath_sound(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(isDefined(self.var_6B17)) {
    self[[self.var_6B17]](var_0, var_1);
    return;
  }

  self clearanim(self.var_1EA4["body"], 0.2);
  self givescorefortrophyblocks();
  self func_82E4("fakeactor_anim", var_0, self.var_1EA4["body"], 1, 0.2, var_1);
}

func_CE00(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(self.var_6B41)) {
    self[[self.var_6B41]](var_0, var_1);
    return;
  }

  self clearanim(self.var_1EA4["body"], 0.2);
  self givescorefortrophyblocks();
  var_6 = "normal";
  if(isDefined(var_1)) {
    var_6 = "deathplant";
  }

  var_7 = self.origin;
  var_8 = self.angles;
  if(isDefined(var_4)) {
    var_7 = var_4.origin;
    var_8 = var_4.angles;
  }

  if(!isDefined(var_5)) {
    var_5 = 0.2;
  }

  self animscripted("fakeactor_anim", var_7, var_8, var_0, var_6);
  if(isDefined(var_2)) {
    thread scripts\anim\shared::donotetracks(var_3, var_2);
  }

  var_9 = "end";
  if(animhasnotetrack(var_0, "finish")) {
    var_9 = "finish";
  } else if(animhasnotetrack(var_0, "stop anim")) {
    var_9 = "stop anim";
  }

  var_0A = getanimlength(var_0) - var_5;
  if(var_5 > 0 && var_0A > 0) {
    scripts\sp\utility::func_137A3("fakeactor_anim", var_9, var_0A);
    return;
  }

  self waittillmatch(var_9, "fakeactor_anim");
}

func_7816(var_0) {
  var_1 = spawnStruct();
  var_1.var_1F5A = getanimlength(var_0);
  var_2 = getmovedelta(var_0, 0, 1);
  var_3 = length(var_2);
  if(var_1.var_1F5A > 0 && var_3 > 0) {
    var_1.var_E81C = var_3 / var_1.var_1F5A;
    var_1.var_1F1D = 0;
  } else {
    var_1.var_E81C = 170;
    var_1.var_1F1D = 1;
  }

  return var_1;
}

func_F297(var_0, var_1) {
  self.var_1A2C = var_0;
  self.var_1A2D = var_1;
}

func_77E8() {
  return self.var_1A2C;
}

func_13924() {
  self endon("death");
  for(;;) {
    if(isai(self.var_1A2C) && !isalive(self.var_1A2C)) {
      func_F297(undefined);
    }

    wait(0.05);
  }
}

func_9C07() {
  return self.unittype == "C6i" || self.unittype == "soldier" || self.unittype == "civilian";
}

func_F8BE() {
  scripts\sp\utility::func_23B9();
  switch (self.unittype) {
    case "C6":
      func_F8EE();
      break;

    case "C8":
      func_F8F1();
      break;

    case "C6i":
    case "soldier":
    case "civilian":
      func_F98E();
      break;

    case "C12":
      break;

    default:
      break;
  }
}

func_F98E() {
  self.var_1EA4["root"] = % root;
  self.var_1EA4["body"] = % body;
  self.var_1EA4["aim_2"] = % aim_2;
  self.var_1EA4["aim_4"] = % aim_4;
  self.var_1EA4["aim_6"] = % aim_6;
  self.var_1EA4["aim_8"] = % aim_8;
}

func_F8EE() {
  self.var_1EA4["root"] = % root;
  self.var_1EA4["body"] = % body;
  self.var_1EA4["aim_2"] = % aim_2;
  self.var_1EA4["aim_4"] = % aim_4;
  self.var_1EA4["aim_6"] = % aim_6;
  self.var_1EA4["aim_8"] = % aim_8;
}

func_F8F1() {
  self.var_1EA4["root"] = % root;
  self.var_1EA4["body"] = % body;
  self.var_1EA4["aim_2"] = % aim_2;
  self.var_1EA4["aim_4"] = % aim_4;
  self.var_1EA4["aim_6"] = % aim_6;
  self.var_1EA4["aim_8"] = % aim_8;
}

func_1A31(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0.1;
  var_7 = 1;
  if(var_5 < 0) {
    var_8 = var_5 / self.setdevdvar * var_7;
    self func_82AC(var_1, 0, var_6, 1, 1);
    self func_82AC(var_2, var_8, var_6, 1, 1);
  } else if(var_5 > 0) {
    var_8 = var_5 / self.setmatchdatadef * var_7;
    self func_82AC(var_1, var_8, var_6, 1, 1);
    self func_82AC(var_2, 0, var_6, 1, 1);
  }

  if(var_4 < 0) {
    var_8 = var_4 / self.var_368 * var_7;
    self func_82AC(var_0, 0, var_6, 1, 1);
    self func_82AC(var_3, var_8, var_6, 1, 1);
    return;
  }

  if(var_4 > 0) {
    var_8 = var_4 / self.isbot * var_7;
    self func_82AC(var_0, var_8, var_6, 1, 1);
    self func_82AC(var_3, 0, var_6, 1, 1);
  }
}

func_F2C3(var_0) {
  self.var_1FD1 = var_0;
  func_CB1F();
}

func_CB1F() {
  var_0 = randomint(self.var_1FD1.size);
  self.var_1FD0 = self.var_1FD1[var_0];
}

func_F584(var_0) {
  self.var_E7DA = var_0;
}

func_417B() {
  self.var_E7DA = undefined;
}

func_F40F(var_0) {
  self.var_92D2 = var_0;
}

func_415E() {
  self.var_92D2 = undefined;
}

func_9C08() {
  return self.current_state == "idle";
}

func_9C44() {
  return self.current_state == "move";
}

func_9BA1() {
  return self.magicbullet & 256;
}

func_F30A(var_0) {
  if(var_0) {
    self.magicbullet = self.magicbullet | 256;
    return;
  }

  self.magicbullet = self.magicbullet &~256;
}

func_1142F() {
  self notify("change_state");
  self.var_D88C = self.var_4B94;
  func_416B();
  self.var_C039 = undefined;
  func_F30A(1);
}

func_DF38(var_0) {
  func_F30A(0);
  if(isDefined(var_0)) {
    func_F31D(var_0);
    func_F613(1);
  } else if(isDefined(self.var_D88C)) {
    func_F31D(self.var_D88C);
    func_F613(1);
    self.var_D88C = undefined;
  }

  self.current_state = undefined;
}

func_F35C(var_0) {
  if(var_0) {
    self.magicbullet = self.magicbullet | 8;
    return;
  }

  self.magicbullet = self.magicbullet &~8;
}

func_FF2C() {
  return self.magicbullet & 8;
}

func_F35D(var_0) {
  if(var_0) {
    self.magicbullet = self.magicbullet | 16;
    return;
  }

  self.magicbullet = self.magicbullet &~16;
}

func_FF2F() {
  if(isDefined(self.var_D8A6)) {
    if(self.var_D8A6 == "traverse" || self.var_D8A6 == "turn") {
      return 0;
    }
  }

  return self.magicbullet & 16;
}

func_F2C6(var_0) {
  if(var_0) {
    self.magicbullet = self.magicbullet | 4;
    return;
  }

  self.magicbullet = self.magicbullet &~4;
}

func_9B69() {
  return self.magicbullet & 4;
}

func_F613(var_0) {
  if(var_0) {
    self.magicbullet = self.magicbullet | 2;
    return;
  }

  self.magicbullet = self.magicbullet &~2;
}

func_582B() {
  return self.magicbullet & 2;
}

func_F5BF(var_0) {
  if(var_0) {
    self.magicbullet = self.magicbullet | 1;
    return;
  }

  self.magicbullet = self.magicbullet &~1;
}

func_9CE3() {
  return self.magicbullet & 1;
}

func_F568(var_0) {
  if(var_0) {
    self.magicbullet = self.magicbullet | 32;
    return;
  }

  self.magicbullet = self.magicbullet &~32;
}

func_FF81() {
  return self.magicbullet & 32;
}

func_F410(var_0) {
  if(var_0) {
    self.magicbullet = self.magicbullet | 64;
    return;
  }

  self.magicbullet = self.magicbullet &~64;
}

func_9C0B() {
  return self.magicbullet & 64;
}

func_C2C9(var_0) {
  if(var_0) {
    self.magicbullet = self.magicbullet | 128;
    return;
  }

  self.magicbullet = self.magicbullet &~128;
}

func_9C53() {
  return self.magicbullet & 128;
}

func_FF35() {
  return self.magicbullet & 512;
}

func_F5F9(var_0) {
  if(var_0) {
    self.magicbullet = self.magicbullet | 512;
    return;
  }

  self.magicbullet = self.magicbullet &~512;
}

func_13903() {
  return self.magicbullet & 2048;
}

func_F56C(var_0) {
  if(var_0) {
    self.magicbullet = self.magicbullet | 2048;
    return;
  }

  self.magicbullet = self.magicbullet &~2048;
}

func_9BE8() {
  return self.magicbullet & 1024;
}

func_F3BE(var_0) {
  if(var_0) {
    self.magicbullet = self.magicbullet | 1024;
    return;
  }

  self.magicbullet = self.magicbullet &~1024;
}

func_12735(var_0) {
  if(!isDefined(self.var_336)) {
    return;
  }

  var_1 = getent("target", self.var_336);
  for(;;) {
    var_0 waittill("trigger", var_2);
    var_1 func_F613(1);
  }
}

func_12736(var_0) {
  if(!isDefined(var_0.var_336)) {
    return;
  }

  var_1 = scripts\engine\utility::getstructarray(var_0.var_336, "target");
  if(var_1.size == 0) {
    return;
  }

  for(;;) {
    var_0 waittill("trigger", var_2);
    foreach(var_4 in var_1) {
      var_4 scripts\sp\fakeactor_node_MAYBE::func_6B38(1);
    }
  }
}

func_12738(var_0) {
  if(!isDefined(var_0.var_336)) {
    return;
  }

  var_1 = scripts\engine\utility::getstructarray(var_0.var_336, "target");
  if(var_1.size == 0) {
    return;
  }

  for(;;) {
    var_0 waittill("trigger", var_2);
    foreach(var_4 in var_1) {
      var_4 scripts\sp\fakeactor_node_MAYBE::func_6B38(0);
    }
  }
}

func_12739(var_0) {
  if(!isDefined(var_0.script_parameters)) {
    return;
  }

  for(;;) {
    var_0 waittill("trigger", var_1);
    scripts\sp\fakeactor_node_MAYBE::func_6B24(var_0.script_parameters, 0);
  }
}

func_12737(var_0) {
  if(!isDefined(var_0.script_parameters)) {
    return;
  }

  for(;;) {
    var_0 waittill("trigger", var_1);
    scripts\sp\fakeactor_node_MAYBE::func_6B24(var_0.script_parameters, 1);
  }
}

func_1273B(var_0) {
  if(!isDefined(var_0.var_336)) {
    return;
  }

  var_1 = scripts\engine\utility::getstructarray(var_0.var_336, "target");
  if(var_1.size == 0) {
    return;
  }

  for(;;) {
    var_0 waittill("trigger", var_2);
    foreach(var_4 in var_1) {
      var_4 scripts\sp\fakeactor_node_MAYBE::func_6B3A();
    }
  }
}

func_1273A(var_0) {
  if(!isDefined(var_0.var_336)) {
    return;
  }

  var_1 = scripts\engine\utility::getstructarray(var_0.var_336, "target");
  if(var_1.size == 0) {
    return;
  }

  for(;;) {
    var_0 waittill("trigger", var_2);
    foreach(var_4 in var_1) {
      var_4 scripts\sp\fakeactor_node_MAYBE::func_6B39();
    }
  }
}

is_higher_priority(var_0, var_1) {
  return var_0["priority"] < var_1["priority"];
}