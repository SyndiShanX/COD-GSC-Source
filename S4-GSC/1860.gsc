/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1860.gsc
*************************************************/

main() {
  if(getDvar("#x3a8fb0620196c6263") == "1") {
    return;
  }
  level._id_CDD0 = [];
  level._id_CDD0["move_time"] = 5;
  level._id_CDD0["accel_time"] = 0;
  level._id_CDD0["decel_time"] = 0;
  level._id_CDD0["wait_time"] = 0;
  level._id_CDD0["delay_time"] = 0;
  level._id_CDD0["usable"] = 0;
  level._id_CDD0["hintstring"] = "activate";
  _id_CDC8("activate", &"MP/ACTIVATE_MOVER");
  _id_CDC9("none", "");
  level._id_CDDB = [];
  waitframe();
  var_0 = [];
  var_1 = _id_CDCE();

  foreach(var_3 in var_1) {
    var_0 = scripts\engine\utility::array_combine(var_0, getEntArray(var_3, "classname"));
  }

  scripts\engine\utility::_id_1BE2(var_0, ::_id_CDD6);
}

_id_CDCE() {
  return ["script_model_mover", "script_brushmodel_mover"];
}

_id_CDD7() {
  if(isDefined(self._id_CDC7)) {
    return self._id_CDC7;
  }

  var_0 = _id_CDCE();

  foreach(var_2 in var_0) {
    if(self.classname == var_2) {
      self._id_CDC7 = 1;
      return 1;
    }
  }

  return 0;
}

_id_CDC8(var_0, var_1) {
  if(!isDefined(level._id_CDD4)) {
    level._id_CDD4 = [];
  }

  level._id_CDD4[var_0] = var_1;
}

_id_CDC9(var_0, var_1) {
  if(!isDefined(level._id_CDDC)) {
    level._id_CDDC = [];
  }

  level._id_CDDC[var_0] = var_1;
}

_id_CDD6() {
  if(!isDefined(self.target)) {
    return;
  }
  self._id_CDC7 = 1;
  self._id_A280 = 0;
  self._id_AC78 = self;
  self._id_FE17 = [];
  self._id_94FD = [];
  var_0 = scripts\engine\utility::getstructarray(self.target, "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_039B)) {
      continue;
    }
    switch (var_2._id_039B) {
      case "origin":
        if(!isDefined(var_2.angles)) {
          var_2.angles = (0, 0, 0);
        }

        self._id_AC78 = spawn("script_model", var_2.origin);
        self._id_AC78.angles = var_2.angles;
        self._id_AC78 setModel("tag_origin");
        self._id_AC78 linkto(self);
        break;
      default:
        break;
    }
  }

  var_4 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_4) {
    if(!isDefined(var_2._id_039B)) {
      continue;
    }
    switch (var_2._id_039B) {
      case "use_trigger_link":
        var_2 _meth_80DB();
        var_2 linkto(self);
      case "use_trigger":
        var_2 _id_CDDF();
        thread _id_CDE9(var_2);
        self._id_FE17[self._id_FE17.size] = var_2;
        break;
      case "link":
        var_2 linkto(self);
        self._id_94FD[self._id_94FD.size] = var_2;
        break;
      default:
        break;
    }
  }

  thread _id_CDDF();
  thread _id_CDD5();
  thread _id_CDE1();
  thread _id_CDCC(self);
  thread _id_CDDA();

  foreach(var_8 in self._id_FE17) {
    _id_CDE4(var_8, 1);
  }
}

_id_CDE9(var_0) {
  self endon("death");

  for(;;) {
    var_0 waittill("trigger");

    if(var_0._id_708D.size > 0) {
      self notify("new_path");
      thread _id_CDDA(var_0);
      continue;
    }

    self notify("trigger");
  }
}

_id_CDD9(var_0) {
  if(isDefined(level._id_CDDB[var_0])) {
    self notify("new_path");
    self._id_708D = [level._id_CDDB[var_0]];
    thread _id_CDDA();
  }
}

_id_1796(var_0) {
  return (_func_000B(var_0[0]), _func_000B(var_0[1]), _func_000B(var_0[2]));
}

_id_CDDF() {
  if(isDefined(self._id_AE6D) && self._id_AE6D) {
    return;
  }
  self._id_AE6D = 1;
  self._id_708D = [];
  self._id_A258 = [];
  self._id_9301 = [];
  var_0 = [];
  var_1 = [];

  if(isDefined(self.target)) {
    var_0 = scripts\engine\utility::getstructarray(self.target, "targetname");
    var_1 = getEntArray(self.target, "targetname");
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isDefined(var_3._id_039B)) {
      var_3._id_039B = "goal";
    }

    switch (var_3._id_039B) {
      case "ignore":
        if(isDefined(var_3.target)) {
          var_4 = scripts\engine\utility::getstructarray(var_3.target, "targetname");

          foreach(var_6 in var_4) {
            var_0[var_0.size] = var_6;
          }
        }

        break;
      case "goal":
        var_3 _id_CDD5();
        var_3 _id_CDDF();
        self._id_708D[self._id_708D.size] = var_3;

        if(isDefined(var_3._id_AE4A["name"])) {
          level._id_CDDB[var_3._id_AE4A["name"]] = var_3;
        }

        break;
      case "level_notify":
        if(isDefined(var_3._id_CE18)) {
          self._id_9301[self._id_9301.size] = var_3;
        }

        break;
      default:
        break;
    }
  }

  foreach(var_9 in var_1) {
    if(var_9 _id_CDD7()) {
      self._id_A258[self._id_A258.size] = var_9;
      continue;
    }

    if(!isDefined(var_9._id_039B)) {
      continue;
    }
    var_10 = strtok(var_9._id_039B, "_");

    if(var_10.size != 3 || var_10[1] != "on") {
      continue;
    }
    switch (var_10[0]) {
      case "delete":
        thread _id_CDCD(var_9, ::delete, var_10[2]);
        break;
      case "hide":
        thread _id_CDCD(var_9, ::hide, var_10[2]);
        break;
      case "show":
        var_9 hide();
        thread _id_CDCD(var_9, ::show, var_10[2]);
        break;
      case "triggerhide":
      case "triggerHide":
        thread _id_CDD1(var_9, scripts\engine\utility::_id_F5E0, var_10[2]);
        break;
      case "triggershow":
      case "triggerShow":
        var_9 scripts\engine\utility::_id_F5E0();
        thread _id_CDD1(var_9, scripts\engine\utility::_id_F5E2, var_10[2]);
        break;
      default:
        break;
    }
  }
}

_id_CDD1(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    self waittill(var_2);
    var_0[[var_1]]();
  }
}

_id_CDCD(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    self waittill(var_2);
    var_0 call[[var_1]]();
  }
}

_id_CDE6() {
  scripts\engine\utility::_id_F5E2();
}

_id_CDDA(var_0) {
  self endon("death");
  self endon("new_path");

  if(!isDefined(var_0)) {
    var_0 = self;
  }

  while(var_0._id_708D.size != 0) {
    var_1 = scripts\engine\utility::random(var_0._id_708D);
    var_2 = self;
    var_2 _id_CDCC(var_1);

    if(isDefined(var_2._id_AE4A["delay_till"])) {
      level waittill(var_2._id_AE4A["delay_till"]);
    }

    if(isDefined(var_2._id_AE4A["delay_till_trigger"]) && var_2._id_AE4A["delay_till_trigger"]) {
      self waittill("trigger");
    }

    if(var_2._id_AE4A["delay_time"] > 0) {
      wait(var_2._id_AE4A["delay_time"]);
    }

    var_3 = var_2._id_AE4A["move_time"];
    var_4 = var_2._id_AE4A["accel_time"];
    var_5 = var_2._id_AE4A["decel_time"];
    var_6 = 0;
    var_7 = 0;
    var_8 = _func_024F(var_1.origin, var_1.angles, self._id_AC78.origin, self._id_AC78.angles, self.origin, self.angles);

    if(var_2.origin != var_1.origin) {
      if(isDefined(var_2._id_AE4A["move_speed"])) {
        var_9 = distance(var_2.origin, var_1.origin);
        var_3 = var_9 / var_2._id_AE4A["move_speed"];
      }

      if(isDefined(var_2._id_AE4A["accel_frac"])) {
        var_4 = var_2._id_AE4A["accel_frac"] * var_3;
      }

      if(isDefined(var_2._id_AE4A["decel_frac"])) {
        var_5 = var_2._id_AE4A["decel_frac"] * var_3;
      }

      var_2 moveto(var_8["origin"], var_3, var_4, var_5);

      foreach(var_11 in var_1._id_9301) {
        thread _id_CDE0(var_11.origin, var_11._id_CE18, self.origin, var_1.origin);
      }

      var_6 = 1;
    }

    if(_id_1796(var_8["angles"]) != _id_1796(var_2.angles)) {
      var_2 rotateto(var_8["angles"], var_3, var_4, var_5);
      var_7 = 1;
    }

    foreach(var_14 in var_2._id_A258) {
      var_14 notify("trigger");
    }

    var_0 notify("depart");
    var_2 _id_CDCB(0);
    self._id_A280 = 1;

    if(isDefined(var_2._id_AE4A["move_time_offset"]) && var_2._id_AE4A["move_time_offset"] + var_3 > 0) {
      wait(var_2._id_AE4A["move_time_offset"] + var_3);
    } else if(var_6) {
      self waittill("movedone");
    } else if(var_7) {
      self waittill("rotatedone");
    } else {
      wait(var_3);
    }

    self._id_A280 = 0;
    self notify("move_end");
    var_1 notify("arrive");

    if(isDefined(var_2._id_AE4A["solid"])) {
      if(var_2._id_AE4A["solid"]) {
        var_2 solid();
      } else {
        var_2 notsolid();
      }
    }

    foreach(var_14 in var_1._id_A258) {
      var_14 notify("trigger");
    }

    if(isDefined(var_2._id_AE4A["wait_till"])) {
      level waittill(var_2._id_AE4A["wait_till"]);
    }

    if(var_2._id_AE4A["wait_time"] > 0) {
      wait(var_2._id_AE4A["wait_time"]);
    }

    var_2 _id_CDCB(1);
    var_0 = var_1;
  }
}

_id_CDE0(var_0, var_1, var_2, var_3) {
  self endon("move_end");
  var_4 = self;
  var_5 = vectornormalize(var_3 - var_2);

  for(;;) {
    var_6 = vectornormalize(var_0 - var_4.origin);

    if(vectordot(var_5, var_6) <= 0) {
      break;
    }

    wait 0.05;
  }

  level notify(var_1);
}

_id_CDD5() {
  self._id_AE4A = [];

  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  self.angles = _id_1796(self.angles);
  _id_CDDD(self._id_CE18);
}

_id_CDDD(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "";
  }

  var_1 = strtok(var_0, ";");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "=");

    if(var_4.size != 2) {
      continue;
    }
    if(var_4[1] == "undefined" || var_4[1] == "default") {
      self._id_AE4A[var_4[0]] = undefined;
      continue;
    }

    switch (var_4[0]) {
      case "wait_time":
      case "decel_time":
      case "accel_time":
      case "move_speed":
      case "move_time_offset":
      case "decel_frac":
      case "move_time":
      case "accel_frac":
      case "delay_time":
        self._id_AE4A[var_4[0]] = _id_CDDE(var_4[1]);
        break;
      case "wait_till":
      case "delay_till":
      case "hintstring":
      case "name":
        self._id_AE4A[var_4[0]] = var_4[1];
        break;
      case "delay_till_trigger":
      case "usable":
      case "solid":
        self._id_AE4A[var_4[0]] = int(var_4[1]);
        break;
      case "script_params":
        var_5 = var_4[1];
        var_6 = level._id_CDDC[var_5];

        if(isDefined(var_6)) {
          _id_CDDD(var_6);
        }

        break;
      default:
        break;
    }
  }
}

_id_CDDE(var_0) {
  var_1 = 0;
  var_2 = strtok(var_0, ",");

  if(var_2.size == 1) {
    var_1 = float(var_2[0]);
  } else if(var_2.size == 2) {
    var_3 = float(var_2[0]);
    var_4 = float(var_2[1]);

    if(var_3 >= var_4) {
      var_1 = var_3;
    } else {
      var_1 = randomfloatrange(var_3, var_4);
    }
  }

  return var_1;
}

_id_CDCC(var_0) {
  foreach(var_3, var_2 in var_0._id_AE4A) {
    _id_CDE3(var_3, var_2);
  }

  _id_CDE2();
}

_id_CDE3(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 == "usable" && isDefined(var_1)) {
    _id_CDE4(self, var_1);
  }

  self._id_AE4A[var_0] = var_1;
}

_id_CDCB(var_0) {
  if(self._id_AE4A["usable"]) {
    _id_CDE4(self, var_0);
  }

  foreach(var_2 in self._id_FE17) {
    _id_CDE4(var_2, var_0);
  }
}

_id_CDE4(var_0, var_1) {
  if(var_1) {
    var_0 makeuseable();
    var_0 setcursorhint("HINT_NOICON");
    var_0 sethintstring(level._id_CDD4[self._id_AE4A["hintstring"]]);
  } else
    var_0 makeunusable();
}

_id_CDE1() {
  self._id_AE4B = [];

  foreach(var_2, var_1 in self._id_AE4A) {
    self._id_AE4B[var_2] = var_1;
  }
}

_id_CDE2() {
  foreach(var_2, var_1 in level._id_CDD0) {
    if(!isDefined(self._id_AE4A[var_2])) {
      _id_CDE3(var_2, var_1);
    }
  }

  if(isDefined(self._id_AE4B)) {
    foreach(var_2, var_1 in self._id_AE4B) {
      if(!isDefined(self._id_AE4A[var_2])) {
        _id_CDE3(var_2, var_1);
      }
    }
  }
}

init() {
  level thread _id_CDCA();
}

_id_CDCA() {
  for(;;) {
    level waittill("spawned_agent", var_0);
    var_0 thread _id_B617();
  }
}

_id_B617() {
  self endon("disconnect");

  if(isagent(self)) {
    self endon("death");
  }

  self._id_F9A5 = 0;

  for(;;) {
    self waittill("unresolved_collision", var_0);
    self._id_F9A5++;
    thread _id_3911();
    var_1 = 3;

    if(isDefined(var_0) && isDefined(var_0._id_F9AC)) {
      var_1 = var_0._id_F9AC;
    }

    if(self._id_F9A5 >= var_1) {
      if(isDefined(var_0)) {
        if(isDefined(var_0._id_F9A7)) {
          var_0[[var_0._id_F9A7]](self);
        } else if(isDefined(var_0._id_F9A8) && var_0._id_F9A8) {
          var_0 _id_F9AD(self);
        } else if(var_0 scripts\cp_mp\vehicles\vehicle::_id_8AF5()) {
          if(!scripts\cp_mp\vehicles\vehicle::_id_1009E(var_0, self)) {
            var_0 _id_F9AA(self);
          }
        } else
          var_0 _id_F9AA(self);
      } else
        _id_F9AA(self);

      self._id_F9A5 = 0;
    }
  }
}

_id_3911() {
  self endon("unresolved_collision");
  waitframe();

  if(isDefined(self)) {
    self._id_F9A5 = 0;
  }
}

_id_F9AD(var_0) {
  var_1 = self;

  if(!isDefined(var_1.owner)) {
    var_0 _id_A251();
    return;
  }

  var_2 = 0;

  if(level.teambased) {
    if(isDefined(var_1.owner.team) && var_1.owner.team != var_0.team) {
      var_2 = 1;
    }
  } else if(var_0 != var_1.owner)
    var_2 = 1;

  if(!var_2) {
    var_0 _id_A251();
    return;
  }

  var_3 = 1000;

  if(isDefined(var_1._id_F9A6)) {
    var_3 = var_1._id_F9A6;
  }

  var_0 dodamage(var_3, var_1.origin, var_1.owner, var_1, "MOD_CRUSH");
}

_id_F9AA(var_0, var_1) {
  if(isDefined(level._id_AD44)) {
    self[[level._id_AD44]](var_0, var_1);
    return;
  }

  if(scripts\cp_mp\utility\game_utility::_id_88FE() || scripts\cp\utility::_id_86C9()) {
    var_1 = 1;

    if(scripts\cp_mp\vehicles\vehicle::_id_8AF5()) {
      var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10195(self, 1);

      if(isDefined(var_2)) {
        var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1019E(self, var_0, var_2, 1);

        if(isDefined(var_3)) {
          var_0 setorigin(var_3[0]);
          return;
        }
      }
    }
  } else {
    var_4 = self._id_F9AB;

    if(isDefined(var_4)) {
      var_4 = _func_0204(var_4, var_0.origin);
    } else {
      var_4 = _func_00B4(var_0.origin, 300, 0, 200);
      var_4 = _func_0204(var_4, var_0.origin);
    }

    var_5 = (0, 0, -100);
    var_0 _meth_8063();
    var_0 dontinterpolate();
    var_0 setorigin(var_0.origin + var_5);

    for(var_6 = 0; var_6 < var_4.size; var_6++) {
      var_7 = var_4[var_6];
      var_8 = var_7.origin;

      if(!_func_0034(var_8)) {
        continue;
      }
      if(_func_01A5(var_8)) {
        continue;
      }
      if(var_0 getstance() == "prone") {
        var_0 setstance("crouch");
      }

      var_0 setorigin(var_8);
      return;
    }

    var_0 setorigin(var_0.origin - var_5);
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1) {
    var_0 _id_A251();
  }
}

_id_F9AE(var_0) {}

_id_A251() {
  if(isDefined(level._id_88AA) && !isagent(self)) {
    return;
  }
  scripts\cp\utility::_id_0D8A();
}

_id_B58C(var_0) {
  self endon("death");
  self endon("stop_player_pushed_kill");

  for(;;) {
    self waittill("player_pushed", var_1, var_2);

    if(isPlayer(var_1) || isagent(var_1)) {
      var_3 = length(var_2);

      if(var_3 >= var_0) {
        _id_F9AD(var_1);
      }
    }
  }
}

_id_E8CC() {
  self notify("stop_player_pushed_kill");
}

_id_CDD2() {
  var_0 = self _meth_8151();

  for(var_1 = var_0; isDefined(var_1); var_1 = var_1 _meth_8151()) {
    var_0 = var_1;
  }

  return var_0;
}

_id_CDE5(var_0) {
  var_1 = var_0 _id_CDD2();

  if(isDefined(var_1)) {
    var_1._id_E737 = var_1.origin;
  }

  self._id_E736 = self _meth_815A();

  if(isDefined(self._id_E736)) {
    var_2 = self._id_E736 _id_CDD2();

    if(isDefined(var_2)) {
      self._id_E736 = var_2;
    }

    self._id_E736._id_E737 = self._id_E736.origin;
  }
}

_id_CDD3(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return _func_0135(var_0.origin - var_0._id_E737) > 0.001;
}

_id_CDE8(var_0) {
  if(!isPlayer(self)) {
    return 1;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = var_0 _id_CDD2();
  var_2 = self._id_E736;

  if(!isDefined(var_1) && !isDefined(var_2)) {
    return 1;
  }

  if(isDefined(var_1) && isDefined(var_2) && var_1 == var_2) {
    return 1;
  }

  if(_id_CDD3(var_1)) {
    return 0;
  }

  if(_id_CDD3(var_2)) {
    return 0;
  }

  return 1;
}

_id_CDD8(var_0) {
  if(isPlayer(var_0)) {
    var_0 _id_CDE5(self);
    var_1 = var_0 _meth_815A();
    var_2 = undefined;

    if(isDefined(var_1)) {
      var_2 = var_1;
    } else if(!isDefined(_id_CDD2())) {
      var_2 = self;
    } else {
      var_2 = spawn("script_model", var_0.origin);
      var_2 setModel("tag_origin");
      var_0._id_CF91 = var_2;
      var_0 thread _id_CBD4(var_2);
    }

    var_0 playerlinkto(var_2);
  } else
    var_0 linkto(self);

  var_0 _meth_8263();
}

_id_CDE7(var_0) {
  var_0 unlink();

  if(isDefined(var_0._id_CF91)) {
    var_0 notify("removeMoverLinkDummy");
    var_0._id_CF91 delete();
    var_0._id_CF91 = undefined;
  }
}

_id_CBD4(var_0) {
  self endon("removeMoverLinkDummy");
  scripts\engine\utility::waittill_any_2("death", "disconnect");
  self._id_CF91 delete();
  self._id_CF91 = undefined;
}

_id_A672() {
  var_0 = self _meth_8150(0);

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_A51C) && var_2._id_A51C) {
      continue;
    }
    var_2 unlink();
    var_2 notify("invalid_parent", self);
  }
}

_id_BD56(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1._id_A51B) && var_1._id_A51B) {
    return;
  }
  if(isDefined(var_0._id_B385)) {
    playFX(scripts\engine\utility::getfx("airdrop_crate_destroy"), self.origin);
  }

  if(isDefined(var_0._id_43F7)) {
    var_0._id_90AD = var_1;
    self thread[[var_0._id_43F7]](var_0);
  } else
    self delete();
}

_id_7402(var_0) {
  self notify("handle_moving_platform_touch");
  self endon("handle_moving_platform_touch");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");

  if(isDefined(var_0._id_5338)) {
    self endon(var_0._id_5338);
  }

  for(;;) {
    self waittill("touching_platform", var_1);

    if(isDefined(var_0._id_FF41) && var_0._id_FF41) {
      if(!self istouching(var_1)) {
        wait 0.05;
        continue;
      }
    }

    thread _id_BD56(var_0, var_1);
    break;
  }
}

_id_7401(var_0) {
  self notify("handle_moving_platform_invalid");
  self endon("handle_moving_platform_invalid");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");

  if(isDefined(var_0._id_5338)) {
    self endon(var_0._id_5338);
  }

  self waittill("invalid_parent", var_1);

  if(isDefined(var_0._id_84FB)) {
    self thread[[var_0._id_84FB]](var_0);
  } else {
    thread _id_BD56(var_0, var_1);
  }
}

_id_7403(var_0) {
  self notify("handle_moving_platforms");
  self endon("handle_moving_platforms");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
  }

  if(isDefined(var_0._id_5338)) {
    self endon(var_0._id_5338);
  }

  if(isDefined(var_0._id_950E)) {
    var_1 = self _meth_8151();

    if(!isDefined(var_1) || var_1 != var_0._id_950E) {
      self linkto(var_0._id_950E);
    }
  }

  if(isDefined(var_0._id_950F)) {
    if(_func_0107(var_0._id_950F)) {
      foreach(var_3 in var_0._id_950F) {
        var_1 = self _meth_8151();

        if(!isDefined(var_1) || var_1 != var_3) {
          self linkto(var_3);
        }
      }
    }
  }

  thread _id_7402(var_0);
  thread _id_7401(var_0);
}

_id_E8A3() {
  self notify("stop_handling_moving_platforms");
}

_id_A284(var_0) {}