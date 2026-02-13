/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1895.gsc
*************************************************/

_id_F4C5() {
  if(!istrue(level.teambased)) {
    return;
  }
  level._id_FEAC = getdvarint("#x3b8f9dafe9ae42eb", 1) == 1;
  level._id_BE19 = getdvarint("#x388be9220de8b50e8", 1) == 1;
  level._id_F4CD = [];
  level._id_F4CE = 3;

  if(getdvarint("#x343049bb050928f48", 1) == 0) {
    return;
  }
  _id_1066();
  _id_0FAC();

  if(getdvarint("#x3e121ded662f7017a", 0) == 1) {
    thread _id_445F();
  }
}

#using_animtree("script_model");

_id_3F5D(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0._id_B5A4)) {
    return;
  }
  var_0._id_18AF = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  if(getdvarint("#x3e0f9b894ae62ec9e", 2) != 0) {
    if(isDefined(self._id_ADBB._id_109C2)) {
      self._id_81F1.origin = self._id_ADBB._id_109C2;
      self._id_81F1.angles = self._id_ADBB._id_109C1;
    }

    var_0 setorigin(self._id_81F1.origin);
    var_0 setplayerangles(self._id_81F1.angles);
  }

  var_0 _meth_8282(self._id_81F1.origin);
  var_3 = spawn("script_arms", self._id_81F1.origin, 0, 0, var_0);
  var_3.player = var_0;
  var_0._id_B5A4 = var_3;
  var_0._id_B5A4 hide();
  var_0._id_B5A4._id_18AF = var_1;
  var_0._id_B5A4 useanimtree(#animtree);
  var_0 playerlinktodelta(var_0._id_B5A4, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  var_0 _id_10A7E(self);
  _id_C436(var_0);
}

_id_C436(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_B5A4)) {
    return;
  }
  var_0 unlink();
  var_0._id_B5A4 delete();
  var_0._id_B5A4 = undefined;
}

_id_10A7E(var_0) {
  thread _id_0E87(var_0);
  thread _id_B66D();
  self waittill("can_remove_rig");
}

_id_0E87(var_0) {
  var_0 waittill("traverseassist_cancelled");
  self notify("can_remove_rig");
}

_id_B66D() {
  scripts\engine\utility::waittill_any_3("remove_rig", "death", "disconnect");
  self notify("can_remove_rig");
}

_id_1066() {
  var_0 = getEntArray("traversalassist", "targetname");

  foreach(var_2 in var_0) {
    var_3 = spawnStruct();
    _id_1065(var_3, var_2);
    var_3 thread _id_D830();
    level._id_F4CD[level._id_F4CD.size] = var_3;
  }
}

_id_4A5E() {
  foreach(var_1 in level._id_F4CD) {
    var_1._id_81F8 makeunusable();
    var_1._id_26BC makeunusable();
    var_1._id_F34C makeunusable();
    var_1._id_BE1D makeunusable();

    if(isDefined(var_1._id_F34F)) {
      var_1._id_F34F makeunusable();
    }
  }
}

_id_1065(var_0, var_1) {
  if(!isDefined(var_0._id_5526)) {
    var_0._id_5526 = [];
  }

  switch (var_1.classname) {
    case "trigger_use_touch":
      var_0._id_FE16 = var_1;
      break;
  }

  if(isDefined(var_1._id_039B)) {
    switch (var_1._id_039B) {
      case "initialOrg":
        var_0._id_81F1 = var_1;
        break;
      case "finalOrg":
        var_0._id_5AA8 = var_1;
        break;
    }
  }

  var_0._id_5526[var_0._id_5526.size] = var_1;

  if(isDefined(var_1.target)) {
    var_2 = getEntArray(var_1.target, "targetname");

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_4 in var_2) {
        _id_1065(var_0, var_4);
      }
    }
  }
}

_id_D830(var_0) {
  _id_E2FD(var_0);
  self._id_B032 = 0;
  _id_D648(0);
  thread _id_747F();
}

_id_1D29(var_0) {
  self.parent._id_ADBB = var_0;
  self.parent thread _id_D648(1);
}

_id_1D2A(var_0, var_1, var_2) {
  if(!var_2 && (self.parent._id_B032 == 1 || self.parent._id_B032 == 2)) {
    self.parent notify("traverseassist_cancelled");
  }
}

_id_10AC2(var_0) {
  self endon("traverseassist_cancelled");
  var_1 = var_0.name;
  var_0 waittill("death");
  self notify("traverseassist_cancelled");
}

_id_10ACB(var_0) {
  self endon("traverseassist_cancelled");
  var_1 = var_0.name;
  var_0 waittill("disconnect");
  self notify("traverseassist_cancelled");
}

_id_D648(var_0) {
  var_1 = self._id_B032;
  self._id_B032 = var_0;

  switch (var_1) {
    case 0:
      break;
    case 1:
      break;
    case 2:
      break;
    case 3:
      break;
    case 4:
      break;
    case 5:
      break;
    case 6:
      break;
    case 7:
      break;
  }

  switch (var_0) {
    case 0:
      self notify("traverseassist_cancelled");

      if(isDefined(self._id_ADBB)) {
        self._id_ADBB thread _id_0736::_id_EDC4();
        self._id_ADBB._id_25A6 = 0;

        if(var_1 != 4) {
          self._id_ADBB setorigin(self._id_ADBB _meth_812D(self._id_ADBB.origin));
        }
      }

      if(isDefined(self._id_ADBE)) {
        self._id_ADBE thread _id_0736::_id_EDC4();
        self._id_ADBE._id_25A6 = 0;
      }

      _id_C436(self._id_ADBB);
      _id_C436(self._id_ADBE);

      if(!istrue(self._id_BEE1)) {
        self._id_81F8 _id_5270();
      }

      self._id_26BC _id_4AF8();
      self._id_F34C _id_4AF8();
      self._id_BE1D _id_4AF8();

      if(isDefined(self._id_F34F)) {
        self._id_F34F delete();
        self._id_F34F = undefined;
      }

      break;
    case 1:
      if(var_1 == 0) {
        if(istrue(self._id_ADBB._id_75B3) || level.players.size == 1) {
          thread _id_4E7B();
        } else {
          thread _id_BBBF();
        }
      } else if(var_1 == 2)
        _id_C436(self._id_ADBE);

      break;
    case 2:
      break;
    case 3:
      self._id_26BC _id_4AF8();
      _id_6F85(self._id_ADBB);
      self notify("SetPhase3");
      thread _id_4CF3();
      break;
    case 4:
      self._id_F34C _id_4AF8();
      self._id_BE1D _id_4AF8();

      if(isDefined(self._id_F34F)) {
        self._id_F34F delete();
        self._id_F34F = undefined;
      }

      _id_C436(self._id_ADBB);
      _id_C436(self._id_ADBE);
      thread _id_4068();
      thread _id_F34E();
      break;
    case 5:
      thread _id_BBBE();
      break;
    case 6:
      break;
    case 7:
      self notify("SetPhase7");
      _id_6F85(self._id_ADBE);
      _id_4CCE();
      break;
  }
}

_id_747F() {
  for(;;) {
    self waittill("traverseassist_cancelled");

    switch (self._id_B032) {
      case 0:
        break;
      case 1:
        thread _id_D648(0);
        break;
      case 2:
        if(isDefined(self._id_ADBB) && self._id_ADBB scripts\cp_mp\utility\player_utility::_isalive()) {
          thread _id_D648(1);
        } else {
          thread _id_D648(0);
        }

        break;
      case 3:
        if(isDefined(self._id_ADBB) && self._id_ADBB scripts\cp_mp\utility\player_utility::_isalive()) {
          thread _id_D648(1);
        } else {
          thread _id_D648(0);
        }

        break;
      case 4:
        if(isDefined(self._id_ADBE) && self._id_ADBE scripts\cp_mp\utility\player_utility::_isalive() && isDefined(self._id_F34F) && self._id_ADBE istouching(self._id_F34F)) {
          thread _id_D648(4);
        } else {
          thread _id_D648(0);
        }

        break;
      case 5:
        if(isDefined(self._id_ADBE) && self._id_ADBE scripts\cp_mp\utility\player_utility::_isalive() && isDefined(self._id_F34F) && self._id_ADBE istouching(self._id_F34F)) {
          thread _id_D648(4);
        } else {
          thread _id_D648(0);
        }

        break;
      case 6:
        if(isDefined(self._id_ADBE) && self._id_ADBE scripts\cp_mp\utility\player_utility::_isalive() && isDefined(self._id_F34F) && self._id_ADBE istouching(self._id_F34F)) {
          thread _id_D648(4);
        } else {
          thread _id_D648(0);
        }

        break;
      case 7:
        if(isDefined(self._id_ADBE) && self._id_ADBE scripts\cp_mp\utility\player_utility::_isalive() && isDefined(self._id_F34F) && self._id_ADBE istouching(self._id_F34F)) {
          thread _id_D648(4);
        } else {
          thread _id_D648(0);
        }

        break;
    }
  }
}

_id_FEEA(var_0, var_1) {
  while(_id_FEE0(var_0, var_1)) {
    var_0._id_4143 = var_0._id_4143 + 50 * var_0._id_FEB1;

    if(var_0._id_4143 >= var_0._id_FEE7) {
      return var_1 scripts\cp_mp\utility\player_utility::_isalive();
    }

    waitframe();
  }

  return 0;
}

_id_FEE0(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(!var_1 usebuttonpressed()) {
    return 0;
  }

  if(var_1 scripts\cp\cp_weapon::_id_7169()) {
    return 0;
  }

  if(var_1 meleebuttonpressed()) {
    return 0;
  }

  if(var_0._id_4143 >= var_0._id_FEE7) {
    return 0;
  }

  return 1;
}

_id_BBBF() {
  self._id_81F8 _id_4AF8();
  self endon("traverseassist_cancelled");
  thread _id_10BE8(self._id_ADBB);
  thread _id_3162(self._id_ADBB, "SetPhase3");
  thread _id_3F5D(self._id_ADBB, "hoister");
  var_0 = thread _id_B65D(self._id_ADBB, "hoist_ready");
  wait(var_0);
  _id_3F9B();
  thread _id_10AC2(self._id_ADBB);
  thread _id_10ACB(self._id_ADBB);
  thread _id_B65A(self._id_ADBB, "hoist_ready_idle", "SetPhase3");
}

_id_4E7B() {
  self endon("traverseassist_cancelled");
  thread _id_3F5D(self._id_ADBB, "climber");
  var_0 = thread _id_B65D(self._id_ADBB, "hoist");
  wait(var_0);
  var_0 = _id_B65D(self._id_ADBB, "hoist_n_go");
  wait(var_0);

  if(level._id_FEAC == 1) {
    thread _id_BEFC();
  }

  thread _id_D648(0);
}

_id_4CF3() {
  self._id_ADBE._id_25A6 = 1;
  self endon("traverseassist_cancelled");
  thread _id_B65D(self._id_ADBB, "hoist");
  thread _id_10BE8(self._id_ADBB, 2.0);
  thread _id_3F5D(self._id_ADBE, "climber");
  var_0 = thread _id_B65D(self._id_ADBE, "hoist");
  thread _id_10BE8(self._id_ADBE, 2.0);
  wait(var_0);

  if(!level._id_BE19) {
    var_1 = thread _id_B65D(self._id_ADBB, "hoist_n_go");
    var_2 = thread _id_B65D(self._id_ADBE, "hoist_n_go");
    wait(var_1);
    self._id_ADBB thread _id_0736::_id_EDC4();
    self._id_ADBE thread _id_0736::_id_EDC4();
    self._id_ADBB._id_25A6 = 0;
    self._id_ADBE._id_25A6 = 0;
    thread _id_D648(4);
  } else {
    var_1 = thread _id_B65D(self._id_ADBB, "hoist_n_grab");
    var_2 = thread _id_B65D(self._id_ADBE, "hoist_n_grab");
    wait(var_1);
    self._id_ADBB thread _id_0736::_id_EDC4();
    self._id_ADBE thread _id_0736::_id_EDC4();
    self._id_ADBB._id_25A6 = 0;
    self._id_ADBE._id_25A6 = 0;
    thread _id_D648(4);
  }

  if(level._id_FEAC == 1) {
    thread _id_BEFC();
  }
}

_id_BBBE() {
  thread _id_3F5D(self._id_ADBE, "climber");
  var_0 = thread _id_B65D(self._id_ADBE, "grab_ready");
  wait(var_0);
  thread _id_4037();
  thread _id_B65A(self._id_ADBE, "grab_ready_idle", "SetPhase7");
}

_id_4CCE() {
  self endon("traverseassist_cancelled");
  thread _id_3F5D(self._id_ADBB, "hoister");
  thread _id_B65D(self._id_ADBB, "grab");
  var_0 = thread _id_B65D(self._id_ADBE, "grab");
  wait(var_0);
  _id_C436(self._id_ADBB);
  _id_C436(self._id_ADBE);
  thread _id_D648(4);
}

_id_81F9() {
  while(isDefined(self._id_81F8)) {
    self._id_81F8 waittill("trigger", var_0);

    if(istrue(var_0._id_EDE2)) {
      continue;
    }
    self._id_81F8 _id_4AF8();

    if(var_0 _id_0736::_id_6FA1()) {
      self._id_ADBB = var_0;
      thread _id_D648(1);
      continue;
    }

    self._id_81F8 _id_5270();
  }
}

_id_3162(var_0, var_1) {
  self endon("traverseassist_cancelled");

  if(isDefined(var_1)) {
    self endon(var_1);
  }

  while(!var_0._id_C2FE) {
    waitframe();
  }

  thread _id_D648(0);
}

_id_3F9B() {
  self._id_26BC _id_5270();
  var_0 = self._id_ADBB gettagorigin("J_Wrist_RI");
  self._id_26BC.origin = var_0;
  self._id_26BC linkto(self._id_ADBB, "J_Wrist_RI", (0, 0, 10), (0, 0, 0));

  foreach(var_2 in level.players) {
    if(var_2 == self._id_ADBB) {
      self._id_26BC disableplayeruse(var_2);
      continue;
    }

    self._id_26BC _meth_80E0(var_2);
  }
}

_id_26BD() {
  while(isDefined(self._id_26BC)) {
    self._id_26BC waittill("trigger", var_0);

    if(istrue(var_0._id_EDE2)) {
      continue;
    }
    if(var_0 == self._id_ADBB) {
      continue;
    }
    self._id_26BC _id_4AF8();

    if(var_0 _id_0736::_id_6FA1()) {
      self._id_ADBE = var_0;
      thread _id_D648(3);
      continue;
    }

    self._id_26BC _id_5270();
  }
}

_id_6F85(var_0) {
  var_1 = "buddy_boost";
}

_id_4068() {
  self._id_F34C _id_5270();
  var_0 = self._id_ADBE gettagorigin("J_Wrist_RI");
  self._id_F34C.origin = var_0;
  self._id_F34C linkto(self._id_ADBE, "J_Wrist_RI", (0, 0, 0), (0, 0, 0));

  foreach(var_2 in level.players) {
    if(var_2 != self._id_ADBE) {
      self._id_F34C disableplayeruse(var_2);
      continue;
    }

    self._id_F34C _meth_80E0(var_2);
  }

  thread _id_10AC2(self._id_ADBE);
  thread _id_10ACB(self._id_ADBE);
}

_id_F34E() {
  if(isDefined(self._id_F34F)) {
    return;
  }
  self endon("traverseassist_cancelled");
  self._id_F34F = spawn("trigger_radius", self._id_ADBE.origin, 0, 48, 72);

  for(;;) {
    if(!self._id_ADBE istouching(self._id_F34F)) {
      break;
    }

    waitframe();
  }

  self notify("traverseassist_cancelled");
}

_id_F34D() {
  while(isDefined(self._id_F34C)) {
    self._id_F34C waittill("trigger", var_0);

    if(var_0 != self._id_ADBE) {
      continue;
    }
    thread _id_D648(5);
    self._id_F34C._id_4143 = 0;
    self._id_F34C._id_84EF = 1;
    self._id_F34C._id_FEB1 = 0;
    self._id_F34C._id_FEE7 = 9999;
    var_1 = _id_FEEA(self._id_F34C, var_0);
    self._id_F34C._id_84EF = 0;
    self._id_F34C._id_4143 = 0;

    if(!var_1 || !isDefined(var_0)) {
      self notify("traverseassist_cancelled");
      break;
    }
  }
}

_id_4037() {
  self._id_BE1D _id_5270();
  var_0 = self._id_ADBE gettagorigin("J_Wrist_RI");
  self._id_BE1D.origin = var_0;
  self._id_BE1D linkto(self._id_ADBE, "J_Wrist_RI", (0, 0, 0), (0, 0, 0));

  foreach(var_2 in level.players) {
    if(var_2 == self._id_ADBE) {
      self._id_BE1D disableplayeruse(var_2);
      continue;
    }

    self._id_BE1D _meth_80E0(var_2);
  }
}

_id_BE1E() {
  while(isDefined(self._id_BE1D)) {
    self._id_BE1D waittill("trigger", var_0);

    if(var_0 == self._id_ADBE) {
      continue;
    }
    self._id_ADBB = var_0;
    thread _id_D648(6);
    self._id_BE1D._id_4143 = 0;
    self._id_BE1D._id_84EF = 1;
    self._id_BE1D._id_FEB1 = 1;
    self._id_BE1D._id_FEE7 = 100;
    var_1 = _id_FEEA(self._id_BE1D, var_0);
    self._id_BE1D._id_84EF = 0;
    self._id_BE1D._id_4143 = 0;

    if(!var_1 || !isDefined(var_0)) {
      thread _id_D648(5);
      continue;
    }

    thread _id_D648(7);
    break;
  }
}

_id_B65D(var_0, var_1) {
  if(getdvarint("#x3e0f9b894ae62ec9e", 2) == 2) {
    var_0 setorigin(self._id_81F1.origin);
    var_0 setplayerangles(self._id_81F1.angles);
  }

  var_0 thread _id_0706::_id_17FD(var_0, var_0._id_B5A4, var_1);
  var_2 = _func_0079(level._id_CC31[var_0._id_18AF][var_1]);
  var_3 = getdvarfloat("#x3fee492cdab2927d6", 0.2);
  return var_2 - var_3;
}

_id_B65A(var_0, var_1, var_2) {
  self endon("traverseassist_cancelled");

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  for(;;) {
    var_3 = _id_B65D(var_0, var_1);
    wait(var_3);
  }
}

_id_445F() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;

  while(level.players.size < 5) {
    waitframe();
  }

  wait 5.0;
  var_3 = undefined;
  var_4 = level.players[0].origin;

  if(getdvarint("#x31f16ba4467c5dc27", 0) == 1) {
    var_4 = (700, -1600, 70);
  }

  for(var_5 = 0; var_5 < level._id_F4CD.size; var_5++) {
    var_6 = distance2d(var_4, level._id_F4CD[var_5]._id_81F1.origin);

    if(!isDefined(var_3) || var_6 < var_3) {
      var_3 = var_6;
      var_0 = level._id_F4CD[var_5];
    }
  }

  for(;;) {
    _id_442C(var_0);
    var_0 thread _id_3F5D(var_0._id_79C5, "hoister");
    var_0 thread _id_3F5D(var_0._id_39A6, "climber");
    var_7 = gettime();
    iprintlnbold("Anim: hoist_ready");
    var_8 = var_0 thread _id_B65D(var_0._id_79C5, "hoist_ready");
    wait(var_8);
    iprintlnbold("Anim: hoist");
    var_8 = var_0 thread _id_B65D(var_0._id_79C5, "hoist");
    var_9 = var_0 thread _id_B65D(var_0._id_39A6, "hoist");
    wait(var_9);

    switch (getdvarint("#x3c9e1fc82e3598a6f", 0)) {
      case 0:
        iprintlnbold("Anim: hoist_n_grab");
        var_8 = var_0 thread _id_B65D(var_0._id_79C5, "hoist_n_grab");
        var_9 = var_0 thread _id_B65D(var_0._id_39A6, "hoist_n_grab");
        wait(var_9);
        break;
      case 1:
        iprintlnbold("Anim: hoist_n_go");
        var_8 = var_0 thread _id_B65D(var_0._id_79C5, "hoist_n_go");
        var_9 = var_0 thread _id_B65D(var_0._id_39A6, "hoist_n_go");
        wait(var_9);
        iprintlnbold("Anim: grab_ready");
        var_9 = var_0 thread _id_B65D(var_0._id_39A6, "grab_ready");
        wait(var_9);
        iprintlnbold("Anim: Grab");
        var_8 = var_0 thread _id_B65D(var_0._id_79C5, "grab");
        var_9 = var_0 thread _id_B65D(var_0._id_39A6, "grab");
        wait(var_8);
        break;
    }

    var_10 = gettime();
    _id_C436(var_0._id_79C5);
    _id_C436(var_0._id_39A6);
    iprintlnbold("Anim Duration: " + (var_10 - var_7) / 1000);
    wait 3.0;
  }
}

_id_442C(var_0) {
  var_0._id_79C5 = undefined;
  var_0._id_39A6 = undefined;

  for(var_1 = 1; var_1 < level.players.size; var_1++) {
    if(level.players[var_1].team == level.players[0].team) {
      if(!isDefined(var_0._id_79C5)) {
        var_0._id_79C5 = level.players[var_1];
        continue;
      }

      if(!isDefined(var_0._id_39A6)) {
        var_0._id_39A6 = level.players[var_1];
        break;
      }
    }
  }

  if(getdvarint("#x3fba00b9c451914a9", 0) != 0) {
    var_0._id_79C5 = level.players[0];
  }

  if(getdvarint("#x39353bdfbb3c3e3a3", 0) != 0) {
    var_0._id_39A6 = level.players[0];
  }
}

_id_10BE8(var_0, var_1) {
  var_0 notify("watchPlayerUseButtonPressed");
  var_0 endon("watchPlayerUseButtonPressed");
  var_0._id_C2FE = 0;
  var_2 = gettime();

  if(!isDefined(var_1)) {
    var_3 = undefined;
  } else {
    var_3 = var_2 + var_1 * 1000;
  }

  while(!isDefined(var_3) || gettime() < var_3) {
    if(!var_0 usebuttonpressed()) {
      var_0._id_C2FE = 1;
      break;
    }

    waitframe();
  }
}

_id_BEFB() {
  self._id_BEFA _id_4AF8();

  while(isDefined(self._id_BEFA)) {
    self._id_BEFA waittill("trigger", var_0);

    if(istrue(var_0._id_EDE2)) {
      continue;
    }
    self._id_BEFA _id_4AF8();

    if(var_0 _id_0736::_id_6FA1()) {
      thread _id_3F5D(var_0, "hoister");
      var_1 = thread _id_B65D(var_0, "grab");
      wait(var_1);
      var_0 thread _id_0736::_id_EDC4();
      _id_C436(var_0);
    }

    thread _id_BEFC();
  }
}

_id_BEFC() {
  self._id_BEFA _id_5270();
  self._id_81F8 _id_4AF8();
  self._id_BEE1 = 1;
  self notify("quickTriggerTimeout");
  self endon("quickTriggerTimeout");
  self._id_BEFA setscriptablepartstate("marker", "contested");
  self._id_BEFA playLoopSound("mp_flare_burn_lp");
  wait 20.0;
  self._id_BEFA _id_4AF8();
  self._id_81F8 _id_5270();
  self._id_BEE1 = 0;
  self._id_BEFA setscriptablepartstate("marker", "off");
  self._id_BEFA stoploopsound();
}

_id_E2FD(var_0) {
  if(isDefined(var_0)) {
    self._id_81F1 = spawnStruct();
    self._id_81F1.origin = var_0._id_109C2;
    self._id_81F1.angles = var_0._id_109C1;
  }

  var_1 = anglesToForward(self._id_81F1.angles);
  var_2 = anglestoright(self._id_81F1.angles);
  var_3 = anglestoup(self._id_81F1.angles);

  if(isDefined(var_0)) {
    self._id_81F8 = var_0._id_109BC;
  } else {
    var_4 = self._id_81F1.origin + var_1 * -22 + var_3 * 48;
    self._id_81F8 = scripts\cp\utility::_id_3FF0(var_4, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_PRE_BOOST", -10000, undefined, undefined, 400, 160, 100, 120);
  }

  thread _id_81F9();
  var_4 = self._id_81F1.origin + var_1 * -10 + var_2 * -50 + var_3 * 120;
  self._id_26BC = scripts\cp\utility::_id_3FF0(var_4, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_BOOST", -10000, undefined, undefined, 400, 160, 100, 120);
  thread _id_26BD();
  var_4 = self._id_81F1.origin + var_1 * -10 + var_2 * 50 + var_3 * 120;
  self._id_F34C = scripts\cp\utility::_id_3FF0(var_4, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_PRE_PULL_UP", -10000, undefined, undefined, 400, 160, 100, 120);
  thread _id_F34D();
  var_4 = self._id_81F1.origin + var_1 * -10 + var_2 * -50 + var_3 * 150;
  self._id_BE1D = scripts\cp\utility::_id_3FF0(var_4, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_PULL_UP", -10000, undefined, undefined, 400, 160, 100, 120);
  thread _id_BE1E();
  var_4 = self._id_81F1.origin + var_1 * -3 + var_3 * 70;
  self._id_BEFA = scripts\cp\utility::_id_3FF0(var_4, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_PULL_UP", -10000, undefined, undefined, 400, 160, 100, 120);
  self._id_BEFA setModel("cop_marker_scriptable");
  thread _id_BEFB();
}

_id_5270() {
  self show();
  self makeuseable();
}

_id_4AF8() {
  self hide();
  self makeunusable();

  if(self _meth_81CC()) {
    self unlink();
  }
}

_id_0FAC() {
  level._id_3C56 = [];
  var_0 = scripts\engine\utility::getstructarray("contextualwalltraversal", "targetname");

  foreach(var_2 in var_0) {
    var_3 = spawnStruct();
    var_3._id_B9A4 = var_2.origin;
    var_3.angles = var_2.angles;

    if(isDefined(var_2.target)) {
      var_4 = scripts\engine\utility::getstruct(var_2.target, "targetname");

      if(isDefined(var_4)) {
        var_3._id_B9A5 = var_4.origin;
        var_3._id_94E6 = var_3._id_B9A5 - var_3._id_B9A4;
        var_3._id_94E4 = vectordot(var_3._id_94E6, var_3._id_94E6);
      }
    }

    var_3._id_02F7 = vectornormalize(anglesToForward(var_2.angles) * -1);
    var_5 = var_3._id_B9A4 + var_3._id_02F7 * 23.5;
    var_6 = scripts\engine\utility::_id_5000(var_5, 50.0, -200.0);
    var_3._id_FE7A = var_5[2] - var_6[2] > 150;
    var_3.index = level._id_3C56.size;
    level._id_3C56[level._id_3C56.size] = var_3;
  }

  level thread _id_FC3E();
}

_id_FC3E() {
  var_0 = level._id_5F3A;

  for(;;) {
    foreach(var_2 in level.players) {
      if(istrue(var_2._id_25A6)) {
        continue;
      }
      var_3 = undefined;

      foreach(var_5 in level._id_3C56) {
        if(isDefined(var_2._id_8E96) && istrue(var_2._id_8E96[var_5.index])) {
          continue;
        }
        var_6 = _id_39F3(var_2, var_5);

        if(!isDefined(var_3) || var_6._id_4BB6 < var_3._id_4BB6) {
          var_3 = var_6;
        }
      }

      var_8 = var_2 scripts\cp\utility::_hasperk("specialty_breacher");

      if(!isDefined(var_3) || var_3._id_4BB6 > 490000) {
        if(isDefined(var_2._id_109BC)) {
          var_2._id_109BC hidefromplayer(var_2);
        }

        if(var_8 && isDefined(var_2._id_8E95)) {
          var_2._id_8E95 hidefromplayer(var_2);
        }

        continue;
      }

      var_9 = var_3._id_39F2 + var_3._id_1099D._id_02F7 * 23.5;
      var_10 = scripts\engine\utility::_id_5000(var_9, 50.0, -200.0);
      var_11 = var_9[2] - var_10[2] > 150;
      var_9 = var_10 + (0, 0, 48);

      if(!var_8) {
        var_10 = var_10 + var_3._id_1099D._id_02F7 * -23.5;
      }

      var_2._id_109C2 = var_10;
      var_2._id_109C1 = var_3._id_1099D.angles;
      var_2._id_24D6 = var_3;
    }

    waitframe();
  }
}

_id_39F3(var_0, var_1) {
  if(!isDefined(var_1._id_B9A5)) {
    var_2 = var_1._id_B9A4;
  } else {
    var_3 = var_0.origin - var_1._id_B9A4;
    var_4 = vectordot(var_3, var_1._id_94E6) / var_1._id_94E4;
    var_4 = clamp(var_4, 0.0, 1.0);
    var_2 = var_1._id_B9A4 + var_4 * var_1._id_94E6;
  }

  var_5 = var_0.origin - var_2;
  var_6 = vectordot(var_5, var_5);
  var_7 = spawnStruct();
  var_7._id_39F2 = var_2;
  var_7._id_4BB6 = var_6;
  var_7._id_1099D = var_1;
  return var_7;
}

_id_E3A6(var_0, var_1, var_2) {
  if(var_2) {
    var_3 = scripts\cp\utility::_id_3FF0(var_1, "HINT_BUDDY_BOOST", undefined, &"MP/PLACE_LADDER", -10000, "duration_none", undefined, 400, 160, 100, 120);
  } else {
    var_3 = scripts\cp\utility::_id_3FF0(var_1, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_PRE_BOOST", -10000, undefined, undefined, 400, 160, 100, 120);
  }

  var_3 dontinterpolate();
  var_3.owner = var_0;
  var_3 hide();
  return var_3;
}

_id_3F96(var_0, var_1) {
  if(!isDefined(level._id_0F3B)) {
    level._id_0F3B = [];
  }

  var_2 = spawnStruct();
  var_2.type = var_1;
  var_2.player = var_0;

  if(var_1 == "buddyBoost") {
    var_2 _id_D830(var_0);
  } else if(var_1 == "ladder") {
    var_2 _id_073A::_id_D867();
  }

  level._id_0F3B[level._id_0F3B.size] = var_2;
}

_id_FC3D(var_0) {
  if(!isDefined(var_0._id_109BC)) {
    return;
  }
  var_0._id_109BC delete();
  var_0._id_109BC = undefined;

  foreach(var_2 in level._id_0F3B) {
    if(var_2.player == var_0) {
      var_2 = undefined;
      break;
    }
  }

  var_4 = var_0 scripts\cp\utility::_hasperk("specialty_breacher");
  level _id_3F96(var_0, scripts\engine\utility::ter_op(var_4, "ladder", "buddyBoost"));
}