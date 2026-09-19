/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1343.gsc
**************************************/

init() {
  common_scripts\utility::flag_init("door_opened");

  if(!isDefined(level._id_328C))
    level._id_328C = [];

  if(!isDefined(level._id_5E6E))
    level._id_5E6E = [];

  level._id_AC1D = common_scripts\utility::_id_46B7("door", "targetname");
  common_scripts\utility::_id_0FB2(level._id_AC1D, ::_id_51BE);
}

_id_51BE() {
  self._id_3280 = self._id_0165;

  if(!isDefined(self._id_3280))
    self._id_3280 = "normal";

  if(isDefined(self._id_0164) && issubstr(self._id_0164, "final_brute_closable")) {
    self._id_3280 = "closeable";
    self._id_0165 = "closeable";
  }

  if(isDefined(self.getnegotiationnextnode) && !common_scripts\utility::_id_3C83(self.getnegotiationnextnode))
    common_scripts\utility::flag_init(self.getnegotiationnextnode);

  if(isDefined(self.setgoalnode) && !common_scripts\utility::_id_3C83(self.setgoalnode))
    common_scripts\utility::flag_init(self.setgoalnode);

  waittillframeend;

  switch (self._id_3280) {
    case "normal":
      thread _id_51C1();
      break;
    case "closeable":
      thread _id_51BF();
      break;
    case "safe_haven":
      thread _id_51C2();
    default:
      break;
  }
}

_id_327B(var_0) {
  if(!isDefined(var_0))
    var_0 = 500;

  self._id_267B = var_0;
}

_id_51BF() {
  self._id_56AE = 1;
  _id_51C1();
}

_id_51C2() {
  self._id_57B4 = 1;
  self._id_56AE = 1;
  _id_51C1();
}

_id_51C1() {
  self._id_9DC2 = [];
  self._id_64C5 = [];
  self._id_17F0 = 0;

  if(!isDefined(self.target))
    _id_325C("Door struct without any targets at " + self.origin + ".");
  else {
    self.setclientdvars = _getscriptablearray(self.target, "targetname");
    var_0 = getEntArray(self.target, "targetname");

    foreach(var_2 in var_0) {
      var_3 = var_2._id_0165;

      if(!isDefined(var_3) && isDefined(var_2.classname)) {
        switch (var_2.classname) {
          case "script_brushmodel":
          case "script_model":
            var_3 = "mover";
            break;
          case "trigger_use":
          case "trigger_use_touch":
            var_3 = "trigger";
            break;
        }
      }

      if(!isDefined(var_3)) {
        continue;
      }
      switch (var_3) {
        case "trigger":
          if(_id_51C3(var_2))
            self._id_9DC2[self._id_9DC2.size] = var_2;

          break;
        case "mover":
          if(_id_51C0(var_2))
            self._id_64C5[self._id_64C5.size] = var_2;

          break;
        case "trap":
          self._id_9CFE = var_2;
          break;
        default:
          _id_325C("Unknown ent type '" + var_3 + "' on entity at " + var_2.origin + ".");
          break;
      }
    }

    if(isDefined(self.setclientdvars) && isDefined(self.setclientdvars[0])) {
      var_5 = self.setclientdvars[0] _meth_85CE();

      if(_id_0547::_id_5565(var_5, "animated_zmb_door_bunker_entrance_2")) {
        foreach(var_7 in self._id_64C5) {
          if(var_7.setlookatent == "door_r") {
            var_7 linkto(self.setclientdvars[0], "door_R");
            continue;
          }

          if(var_7.setlookatent == "door_l")
            var_7 linkto(self.setclientdvars[0], "door_L");
        }
      }
    }

    if((self._id_9DC2.size || common_scripts\utility::_id_562E(self._id_57B4)) && (self._id_64C5.size || self.setclientdvars.size))
      _id_7F5C();
  }
}

_id_51C3(var_0) {
  var_0._id_3276 = self;
  return 1;
}

_id_51C0(var_0) {
  if(!isDefined(var_0.target))
    return 1;

  var_0._id_2444 = var_0.origin;
  var_0._id_17F0 = [];
  var_0._id_64A9 = [];
  var_0._id_5DBD = [];
  var_1 = common_scripts\utility::_id_46B7(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_3._id_0165;

    if(!isDefined(var_4))
      var_4 = "goal";

    switch (var_4) {
      case "goal":
        var_0._id_64A9[var_0._id_64A9.size] = var_3;
        break;
      default:
        _id_325C("Unknown door target struct type '" + var_4 + "' on struct at " + var_3.origin + ".");
        break;
    }
  }

  var_6 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_6) {
    var_4 = var_3._id_0165;

    if(!isDefined(var_4))
      var_4 = "link";

    switch (var_4) {
      case "link_blood":
        var_0._id_17F0[var_0._id_17F0.size] = var_3;
        var_3 ghost();
        var_3 linkto(var_0);
        break;
      case "link":
        var_3 linkto(var_0);
        var_0._id_5DBD[var_0._id_5DBD.size] = var_3;
        break;
      default:
        _id_325C("Unknown door target ent type '" + var_4 + "' on ent at " + var_3.origin + ".");
        break;
    }
  }

  if(var_0._id_64A9.size > 0)
    return 1;
  else {
    _id_325C("Door mover at " + var_0.origin + "doesn't have a goal stuct.");
    return 0;
  }
}

_id_0BCB() {
  foreach(var_1 in level._id_AC1D) {
    if(!(isDefined(var_1._id_6BE1) && var_1._id_6BE1))
      return 0;
  }

  return 1;
}

_id_7F5C() {
  if(1) {
    foreach(var_1 in self._id_9DC2) {
      if(!isDefined(var_1._id_7778))
        var_1._id_7778 = _id_0552::_id_7BDD(var_1);

      var_1._id_7778._id_2F74 = 0;
    }
  }

  if(!common_scripts\utility::_id_562E(self._id_57B4)) {
    foreach(var_1 in self._id_9DC2)
    thread _id_7F61(var_1);
  }

  var_5 = _id_3278() && _id_4B39();

  if(var_5) {
    foreach(var_7 in self.setclientdvars)
    var_7 setscriptablepartstate("power_light", "power_off", 0);

    thread _id_9E96();
  }

  self waittill("open", var_9);

  foreach(var_1 in self._id_9DC2)
  thread _id_3677(var_1);

  foreach(var_13 in self._id_64C5)
  thread _id_7F5E(var_13);

  getplayerssightingme();
  self._id_6BE1 = 1;
  common_scripts\utility::flag_set("door_opened");

  if(level._id_A980 <= 20) {
    level._id_400E[level._id_400E.size] = ["mountain_man_set 0 -1", "all"];
    level._id_400E[level._id_400E.size] = ["mountain_man_set 1 -1", "all"];
  }

  if(isDefined(self.getnegotiationnextnode)) {
    common_scripts\utility::flag_set(self.getnegotiationnextnode, var_9);

    if(isDefined(level._id_3283[self.getnegotiationnextnode]))
      level._id_3294 = level._id_3294 | level._id_3283[self.getnegotiationnextnode];
  }

  var_15 = _id_0547::_id_AC4B(self.origin, "door");
  var_15 _id_0547::_id_AC47(var_9);
  var_15 _id_0547::_id_AC48("script_flag", self.getnegotiationnextnode);
  var_15 _id_0547::_id_AC44("cost", self._id_267B);
  var_15 _id_0547::_id_AC4D();

  if(isDefined(var_9)) {
    var_9 _id_054C::_id_AC23("gate");
    var_9._id_3295++;
    var_16 = "none";

    if(isDefined(self.getnegotiationnextnode))
      var_16 = self.getnegotiationnextnode;

    _id_0547::_id_4AE4(var_9, "doors", self._id_267B, "none", var_16);
  }

  if(!common_scripts\utility::_id_562E(self._id_56AE))
    thread _id_7F5F();
  else {
    self waittill("close");
    thread _id_82F1();
    self._id_6BE1 = 0;

    if(isDefined(self.getnegotiationnextnode))
      common_scripts\utility::_id_3C7B(self.getnegotiationnextnode, var_9);

    _id_7F5C();
  }
}

_id_9E96() {
  common_scripts\utility::_id_3C9F(self.setgoalnode);

  foreach(var_1 in self.setclientdvars)
  var_1 setscriptablepartstate("power_light", "power_on", 0);
}

_id_4B39() {
  return isDefined(self.pushplayer) && self.pushplayer == "has_power_light";
}

#using_animtree("destructibles");

getplayerssightingme() {
  self endon("scriptable_door_close");
  self notify("scriptable_door_open");

  foreach(var_1 in self.setclientdvars)
  var_1 setscriptablepartstate("gate", "opening", 0);

  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = self.setclientdvars[0] _meth_85CE();
  var_7 = 0;

  switch (var_6) {
    case "animated_zmb_door_bunker":
      var_3 = _getanimlength(%salt_mine_door_02_open);
      var_4 = 1.2;
      break;
    case "animated_zmb_salt_mine_door":
      var_3 = _getanimlength(%salt_mine_door_01_open);
      var_4 = 3.23333;
      break;
    case "animated_zmb_gate_electric_01_snow":
    case "animated_zmb_gate_electric_01":
      var_3 = _getanimlength(%s2_zmb_electric_gate_open);
      var_4 = 0.8;
      break;
    case "animated_zmb_elec_gate_barn_01":
      var_3 = _getanimlength(%s2_zmb_elec_gate_barn_01_open);
      var_4 = 0.8;
      break;
    case "animated_zmb_gate_01":
      var_3 = _getanimlength(%zmb_gate_01_open);
      var_4 = 0.9;
      break;
    case "animated_zmb_door_bunker_entrance":
      var_3 = 14.6667;
      var_4 = 7.0;
      break;
    case "animated_zmb_door_bunker_entrance_2":
      var_3 = _getanimlength(%s2_zmb_bumker_gate_open);
      var_4 = 14.0;
      var_5 = 7.5;
      break;
    case "animated_zmi_bar_gate_01_powered":
    case "animated_zmi_bar_gate_01":
      var_3 = 1.53333;
      var_4 = 1.0;
      break;
    case "animated_zbr_drop_pod":
      self.setclientdvars[0] setscriptablepartstate("light", "green", 0);
      var_3 = _getanimlength(%s2_zom_drop_pod_open);
      var_4 = 0.5;
      break;
    case "animated_zbr_ger_mil_door":
      self.setclientdvars[0] setscriptablepartstate("light", "green", 0);
      var_3 = _getanimlength(%s2_zom_ger_mil_door_open);
      var_4 = 0.5;
      break;
    case "animated_zbr_zep_interior_bar_gate_01":
      self.setclientdvars[0] setscriptablepartstate("light", "green", 0);
      var_3 = _getanimlength(%s2_zom_zep_bar_gate_open);
      var_4 = 0.5;
      break;
    case "animated_zmf_basalt_door":
      var_3 = _getanimlength(%s2_zmf_basalt_door_open);
      var_4 = 0.9;
      break;
    case "animated_zmf_basalt_door_single_first":
    case "animated_zmf_basalt_door_single":
      var_3 = _getanimlength(%s2_zmf_basalt_door_blockers_open);
      var_4 = 0.9;
      break;
    default:
  }

  if(var_5 > 0) {
    wait(var_5);

    foreach(var_9 in self._id_64C5) {
      if(isDefined(var_9.target)) {
        continue;
      }
      var_9 connectpaths();
    }

    var_4 = var_4 - var_5;
  }

  wait(var_4);

  if(var_7)
    self.setclientdvars[0] hide();

  foreach(var_9 in self._id_64C5) {
    if(isDefined(var_9.target)) {
      continue;
    }
    var_9 notsolid();

    if(var_5 == 0)
      var_9 connectpaths();

    var_9 hide();
    self._id_1F73 = 0;
  }

  thread getviewmodel(var_3 - var_4);
}

getviewmodel(var_0) {
  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  foreach(var_2 in self.setclientdvars)
  var_2 setscriptablepartstate("gate", "opened", 0);
}

_id_82F1() {
  self endon("scriptable_door_open");
  self notify("scriptable_door_close");

  foreach(var_1 in self.setclientdvars)
  var_1 setscriptablepartstate("gate", "closing", 0);

  wait 2;

  foreach(var_1 in self.setclientdvars)
  var_1 setscriptablepartstate("gate", "closed", 0);

  foreach(var_6 in self._id_64C5) {
    if(isDefined(var_6.target)) {
      continue;
    }
    var_6 show();
    var_6 solid();
    var_6 disconnectpaths();
  }
}

_id_7F61(var_0) {
  self endon("open");
  _id_327B(self.setanimknobrestart);
  thread _id_7F5D(var_0);

  for(;;) {
    [var_2, var_3] = var_0 _id_0547::_id_A795();

    if(!_id_3262()) {
      continue;
    }
    if(var_3 == "token") {
      var_2 maps\mp\gametypes\zombies::_id_90F6(var_0._id_9A84);
      break;
    } else {
      var_4 = self._id_267B;
      var_5 = var_2 _id_0577::_id_4687();
      var_4 = int(var_4 * var_5);
      var_6 = undefined;

      if(var_2 maps\mp\gametypes\zombies::_id_11C2(var_4)) {
        break;
      }
    }

    var_2 thread _id_054E::_id_0695("needmoney");
  }

  var_2 _id_0577::_id_A236();
  self notify("open", var_2);
}

_id_7F5F() {
  if(!isDefined(self._id_9CFE)) {
    return;
  }
  if(isDefined(self._id_9CFE.target)) {
    var_0 = common_scripts\utility::_id_46B5(self._id_9CFE.target, "targetname");

    if(isDefined(var_0))
      self._id_9CF7 = anglesToForward(var_0.angles);
  }

  foreach(var_2 in self._id_64C5) {
    var_2._id_A049 = 1;
    var_2._id_A045 = ::_id_327F;
    var_2._id_6E74 = self;
  }

  self._id_9CF5 = 0;
  thread _id_7F60();

  for(;;) {
    self waittill("trap_trigger", var_4, var_5);
    self._id_9CFA = var_4;
    self._id_9CF5 = 1;
    thread _id_327E(var_5);
  }
}

_id_327E(var_0) {
  self notify("door_trap_end");
  self endon("door_trap_end");
  wait(var_0);
  self._id_9CF5 = 0;
}

_id_7F60() {
  var_0 = 0.1;

  for(;;) {
    self._id_9CFE waittill("trigger", var_1);

    if(!self._id_9CF5) {
      continue;
    }
    if(isPlayer(var_1)) {
      continue;
    }
    if(var_1 _id_0547::_id_56CF()) {
      continue;
    }
    if(_id_5532(self._id_9CFE)) {
      continue;
    }
    if(isDefined(self._id_9CF7)) {
      var_2 = var_1 getvelocity();
      var_3 = var_1.origin - self._id_9CFE.origin;
      var_4 = var_1.origin + var_2 * var_0 - self._id_9CFE.origin;
      var_3 = (var_3[0], var_3[1], 0);
      var_4 = (var_4[0], var_4[1], 0);
      var_5 = vectordot(self._id_9CF7, var_3);
      var_6 = vectordot(self._id_9CF7, var_4);

      if(var_5 * var_6 > 0)
        continue;
    }

    foreach(var_8 in self._id_64C5) {
      var_8 moveto(var_8._id_2444, var_0, var_0);
      var_8 playSound("trap_security_door_slam");
    }

    wait(var_0);
    _earthquake(0.2, 0.5, self._id_9CFE.origin, 500);
    wait 0.1;
    var_10 = 1.0;

    foreach(var_8 in self._id_64C5) {
      var_8 moveto(var_8._id_6BF0, var_10);
      var_8 playSound("trap_security_door_reset");
    }

    wait(var_10);
    wait 0.5;
  }
}

_id_327F(var_0) {
  if(!isDefined(var_0) || isPlayer(var_0)) {
    return;
  }
  if(var_0 _id_0547::_id_56CF()) {
    return;
  }
  self._id_6E74 _id_3256();
  var_0 dodamage(var_0.health, var_0.origin, self._id_6E74._id_9CFA, self, "MOD_CRUSH", "trap_zm_mp", "torso_upper");
}

_id_3256() {
  if(self._id_17F0) {
    return;
  }
  self._id_17F0 = 1;

  foreach(var_1 in self._id_64C5) {
    foreach(var_3 in var_1._id_17F0)
    var_3 show();
  }
}

_id_5532(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 istouching(var_0))
      return 1;
  }

  return 0;
}

_id_415D(var_0) {
  var_1 = _id_0547::_id_4474(self._id_267B);
  return var_1;
}

_id_7F5D(var_0) {
  self endon("open");

  for(;;) {
    if(_id_3278()) {
      for(;;) {
        if(!_id_3262()) {
          if(0) {
            var_0 sethintstring(_id_4565(var_0));
            var_0 setsecondaryhintstring("");
            var_0 _id_0547::_id_9A85(0);
          }

          if(1) {
            var_0._id_7778._id_3264 = _id_4564(var_0);
            var_0._id_7778._id_3259 = 0;
            var_0._id_7778.interact_disabled = 1;
            var_0._id_7778._id_6642 = 1;
          }

          common_scripts\utility::_id_3C9F(self.setgoalnode);
        }

        if(0) {
          var_0 sethintstring(_id_450D(var_0));
          var_0 setsecondaryhintstring(_id_415D(self._id_267B));
          var_0 _id_0547::_id_9A85(1);
        }

        if(1) {
          var_0._id_7778._id_3264 = _id_450C(var_0);
          var_0._id_7778._id_3259 = self._id_267B;
          var_0._id_7778.interact_disabled = 0;
          var_0._id_7778._id_6642 = 1;
        }

        common_scripts\utility::flag_waitopen(self.setgoalnode);
      }
    } else {
      if(0) {
        var_0 sethintstring(_id_450D(var_0));
        var_0 setsecondaryhintstring(_id_415D(self._id_267B));
        var_0 _id_0547::_id_9A85(1);
      }

      if(1) {
        var_0._id_7778._id_3264 = _id_450C(var_0);
        var_0._id_7778._id_3259 = self._id_267B;
        var_0._id_7778.interact_disabled = 0;
        var_0._id_7778._id_6642 = 1;
      }
    }

    self waittill("cost_change");
  }
}

_id_8477(var_0) {
  self._id_267B = var_0;
  self notify("cost_change");
}

_id_3278() {
  return isDefined(self.setgoalnode);
}

_id_3262() {
  if(_id_3278())
    return common_scripts\utility::_id_3C77(self.setgoalnode);

  return 1;
}

_id_3677(var_0) {
  if(0) {
    var_0 sethintstring("");
    var_0 setsecondaryhintstring("");
    var_0 _id_0547::_id_9A85(0);
  }

  if(1) {
    var_0._id_7778._id_3264 = 0;
    var_0._id_7778._id_6642 = 1;
    var_0._id_7778._id_2F74 = 1;
  }
}

_id_7F5E(var_0) {
  if(!isDefined(var_0.target)) {
    return;
  }
  var_0._id_5B37 = var_0.origin;
  var_0._id_5B12 = var_0.angles;
  var_1 = common_scripts\utility::random(var_0._id_64A9);
  var_0 moveto(var_1.origin, 1.0);

  if(var_0.classname == "script_model")
    var_0 rotateto(var_1.angles, 1.0);

  var_0._id_6BF0 = var_1.origin;
  var_2 = "interact_door";

  if(isDefined(var_0.setlookatent)) {
    if(_soundexists(var_0.setlookatent))
      var_2 = var_0.setlookatent;
  }

  if(_soundexists(var_2))
    var_0 playSound(var_2);

  if(var_0 _id_0488::_id_8221())
    var_0 connectpaths();

  foreach(var_4 in var_0._id_5DBD) {
    if(var_4 _id_0488::_id_8221())
      var_4 connectpaths();
  }
}

_id_2435(var_0) {
  var_0 moveto(var_0._id_5B37, 1.0);

  if(var_0.classname == "script_model")
    var_0 rotateto(var_0._id_5B12, 1.0);

  var_1 = "interact_door";

  if(isDefined(var_0.setlookatent)) {
    if(_soundexists(var_0.setlookatent))
      var_1 = var_0.setlookatent;
  }

  if(_soundexists(var_1))
    var_0 playSound(var_1);

  if(var_0 _id_0488::_id_8221())
    var_0 disconnectpaths();

  if(isDefined(var_0._id_5DBD)) {
    foreach(var_3 in var_0._id_5DBD) {
      if(var_3 _id_0488::_id_8221())
        var_3 disconnectpaths();
    }
  }
}

_id_325C(var_0) {}

_id_4485(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1))
    var_2 = tablelookup("mp/zombieCustomDoorInteract.csv", 1, var_1, 0);
  else {
    var_3 = _debuglocalizestring(var_0);
    var_2 = tablelookup("mp/zombieCustomDoorInteract.csv", 2, var_3, 0);
  }

  return int(var_2);
}

_id_7BE6(var_0, var_1, var_2, var_3) {
  if(0) {
    if(!isDefined(level._id_328C))
      level._id_328C = [];

    if(!isDefined(level._id_328C[var_1]))
      level._id_328C[var_1] = [];

    level._id_328C[var_1][var_2] = var_0;
  }

  if(1) {
    var_4 = _id_4485(var_0, var_3);

    if(!isDefined(level._id_328B))
      level._id_328B = [];

    if(!isDefined(level._id_328B[var_1]))
      level._id_328B[var_1] = [];

    level._id_328B[var_1][var_2] = var_4;
  }
}

_id_7BEB(var_0, var_1, var_2) {
  if(0)
    level._id_5E6E[var_1] = var_0;

  if(1) {
    var_3 = _id_4485(var_0, var_2);

    if(!isDefined(level._id_5E6D))
      level._id_5E6D = [];

    level._id_5E6D[var_1] = var_3;
  }
}

_id_450C(var_0) {
  if(isDefined(level._id_328B)) {
    if(isDefined(var_0.getnegotiationnextnode) && isDefined(var_0.setmovespeedscale)) {
      var_1 = level._id_328B[var_0.getnegotiationnextnode];

      if(isDefined(var_1) && isDefined(var_1[var_0.setmovespeedscale]))
        return var_1[var_0.setmovespeedscale];
    }
  }

  return _id_4485("", "locked");
}

_id_4564(var_0) {
  if(isDefined(var_0.setgoalnode)) {
    if(isDefined(level._id_5E6D)) {
      var_1 = level._id_5E6D[var_0.setgoalnode];

      if(isDefined(var_1))
        return var_1;
    }
  }

  return _id_4485("", "no_power");
}

_id_450D(var_0) {
  if(isDefined(var_0.getnegotiationnextnode) && isDefined(var_0.setmovespeedscale)) {
    var_1 = level._id_328C[var_0.getnegotiationnextnode];

    if(isDefined(var_1) && isDefined(var_1[var_0.setmovespeedscale]))
      return var_1[var_0.setmovespeedscale];
  }

  return &"ZOMBIES_DOOR_BUY";
}

_id_4565(var_0) {
  if(isDefined(var_0.setgoalnode)) {
    var_1 = level._id_5E6E[var_0.setgoalnode];

    if(isDefined(var_1))
      return var_1;
  }

  return &"ZOMBIES_REQUIRES_POWER";
}

_id_328A() {
  return common_scripts\utility::_id_3C83("door_opened") && common_scripts\utility::_id_3C77("door_opened");
}

_id_44A6(var_0) {
  var_1 = undefined;

  if(isDefined(level._id_AC1D) && isDefined(var_0)) {
    foreach(var_3 in level._id_AC1D) {
      if(_id_0547::_id_5565(var_3.getnegotiationnextnode, var_0))
        var_1 = var_3;
    }
  }

  return var_1;
}