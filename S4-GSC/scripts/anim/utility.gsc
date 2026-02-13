/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\anim\utility.gsc
*************************************************/

#using_animtree("generic_human");

_id_8136(var_0) {
  self _meth_8077(%body, 0.3);
  self _meth_82D9(%body, 1, 0);

  if(var_0 != "pain" && var_0 != "death") {
    self._id_0DDF._id_E3B7 = "none";
  }

  self._id_0DDF._id_1357 = 1.0;
  self._id_0DDF._id_1359 = 1.0;
  self._id_0DDF._id_1358 = 1.0;
  self._id_0DDF._id_135B = 0;
  self._id_0DDF._id_135A = 0;
  _id_FC96();
}

_id_FC00() {
  if(isDefined(self._id_4812) && self._id_4812 != self._id_0131) {
    if(self._id_0131 == "prone") {
      _id_578C(0.5);
    }

    if(self._id_4812 == "prone") {
      self _meth_836D(-45, 45, %prone_legs_down, %exposed_aiming, %prone_legs_up);
      _id_54DF(0.5);
      self _meth_82DC(_id_9815("default_prone", "straight_level"), %body, 1, 0.1, 1);
    }
  }

  self._id_4812 = undefined;
}

_id_81C4(var_0) {
  self endon("killanimscript");
  self waittill("Hellfreezesover");
}

_id_BD13() {
  self endon("death");
  self notify("displaceprint");
  self endon("displaceprint");

  for(;;) {
    wait 0.05;
  }
}

_id_88BB(var_0) {
  if((!isDefined(var_0) || var_0) && self._id_0039 > 1) {
    return 1;
  }

  if(isDefined(self._id_0192)) {
    return 1;
  }

  return self._id_0DDF._id_3AAE > gettime();
}

_id_FC96() {
  if(isDefined(self._id_0192)) {
    self._id_0DDF._id_3AAE = gettime() + anim._id_3AB5 + randomint(anim._id_3AB6);
  }
}

_id_A696(var_0, var_1, var_2) {
  self endon("death");
  self endon(var_1);
  wait(var_2);
  self notify(var_0);
}

_id_4F49(var_0) {
  self endon("killanimscript");
  self endon("enddrawstring");

  for(;;) {
    wait 0.05;
  }
}

_id_4F4A(var_0, var_1, var_2, var_3) {
  var_4 = var_3 * 20;

  for(var_5 = 0; var_5 < var_4; var_5++) {
    wait 0.05;
  }
}

_id_DCBE(var_0) {
  self notify("got known enemy2");
  self endon("got known enemy2");
  self endon("death");

  if(!isDefined(self._id_0192)) {
    return;
  }
  if(self._id_0192.team == "allies") {
    var_1 = (0.4, 0.7, 1);
  } else {
    var_1 = (1, 0.7, 0.4);
  }

  for(;;) {
    wait 0.05;

    if(!isDefined(self._id_0270)) {
      continue;
    }
  }
}

_id_755A() {
  if(isDefined(self._id_02ED)) {
    return scripts\anim\utility_common::_id_31CD() || scripts\anim\utility_common::_id_31EB();
  } else {
    return scripts\anim\utility_common::_id_31CC() || scripts\anim\utility_common::_id_31EA();
  }
}

_id_69FE() {
  return self._id_70E0;
}

_id_4505() {
  wait 5;
  self notify("timeout");
}

_id_44EC(var_0, var_1, var_2) {
  self endon("death");
  self notify("stop debug " + var_0);
  self endon("stop debug " + var_0);
  var_3 = spawnStruct();
  var_3 thread _id_4505();
  var_3 endon("timeout");

  if(self._id_0192.team == "allies") {
    var_4 = (0.4, 0.7, 1);
  } else {
    var_4 = (1, 0.7, 0.4);
  }

  for(;;) {
    wait 0.05;
  }
}

_id_44EB(var_0, var_1) {
  thread _id_44EC(var_0, var_1, 2.15);
}

_id_44ED(var_0, var_1, var_2) {
  thread _id_44EC(var_0, var_1, var_2);
}

_id_44BD(var_0, var_1) {
  var_2 = var_0 / var_1;
  var_3 = undefined;

  if(var_0 == self._id_00CC) {
    var_3 = "all rounds";
  } else if(var_2 < 0.25) {
    var_3 = "small burst";
  } else if(var_2 < 0.5) {
    var_3 = "med burst";
  } else {
    var_3 = "long burst";
  }

  thread _id_44ED(self.origin + (0, 0, 42), var_3, 1.5);
  thread _id_44EB(self.origin + (0, 0, 60), "Suppressing");
}

_id_BD20() {
  self endon("death");
  self notify("stop shoot " + self._id_57EE);
  self endon("stop shoot " + self._id_57EE);
  var_0 = 0.25;
  var_1 = var_0 * 20;

  for(var_2 = 0; var_2 < var_1; var_2 = var_2 + 1) {
    wait 0.05;
  }
}

_id_BD1F() {}

_id_DC97(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = var_3 * 20;

  for(var_5 = 0; var_5 < var_4; var_5 = var_5 + 1) {
    wait 0.05;
  }
}

_id_DC96(var_0, var_1, var_2, var_3) {
  thread _id_DC97(var_0, var_1 + (0, 0, -5), var_2, var_3);
}

_id_DA28(var_0) {
  self._id_0DDF._id_9041 = gettime();
  _id_06D7::_id_D12E();
  self notify("shooting");

  if(scripts\anim\utility_common::_id_8766() && istrue(self._id_0B67._id_03CE) && isDefined(self._id_0B67._id_03C8)) {
    self _meth_83BE(1, self._id_0B67._id_03C8, 1, 0, 1);
  } else {
    if(isagent(self)) {
      var_0 = 1;
    }

    self _meth_83BE(1, undefined, var_0);
  }
}

_id_DA29(var_0) {
  level notify("an_enemy_shot", self);
  _id_DA28(var_0);
}

_id_DA33(var_0, var_1) {
  self._id_0DDF._id_9041 = gettime();

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  self notify("shooting");

  if(scripts\anim\utility_common::_id_8766()) {
    self _meth_83BE(1, var_0, 1, 1, 1);
  } else {
    var_2 = 0;

    if(isDefined(self._id_0192) && istrue(self._id_0192._id_F940)) {
      var_2 = 1;
    }

    var_3 = _func_002D(self _meth_815C(), var_0, 4);
    self _meth_83BE(1, var_3, var_1, var_2);
  }
}

_id_F194() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("temp");
  var_0.origin = self gettagorigin("tag_weapon_right") + (50, 50, 0);
  var_0.angles = self gettagangles("tag_weapon_right");
  var_1 = anglestoright(var_0.angles);
  var_1 = var_1 * 15;
  var_2 = anglesToForward(var_0.angles);
  var_2 = var_2 * 15;
  var_0 movegravity((0, 50, 150), 100);
  var_3 = "weapon_" + getcompleteweaponname(self._id_04F6);
  var_4 = spawn(var_3, var_0.origin);
  var_4.angles = self gettagangles("tag_weapon_right");
  var_4 linkto(var_0);
  var_5 = var_0.origin;

  while(isDefined(var_4) && isDefined(var_4.origin)) {
    var_6 = var_5;
    var_7 = var_0.origin;
    var_8 = vectortoangles(var_7 - var_6);
    var_2 = anglesToForward(var_8);
    var_2 = var_2 * 4;
    var_9 = scripts\engine\trace::_bullet_trace(var_7, var_7 + var_2, 1, var_4);

    if(isalive(var_9["entity"]) && var_9["entity"] == self) {
      wait 0.05;
      continue;
    }

    if(var_9["fraction"] < 1.0) {
      break;
    }

    var_5 = var_0.origin;
    wait 0.05;
  }

  if(isDefined(var_4) && isDefined(var_4.origin)) {
    var_4 unlink();
  }

  var_0 delete();
}

_id_B01E() {
  var_0 = "TAG_EYE";
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");

  while(isDefined(self)) {
    wait 0.05;

    if(!isDefined(self)) {
      break;
    }

    if(isDefined(self._id_0DDF._id_A235) && self._id_0DDF._id_A235 == "stop") {
      if(isDefined(self._id_88BF) && self._id_88BF == 1) {
        continue;
      }
      playFXOnTag(level._effect["cold_breath"], self, var_0);
      wait(2.5 + randomfloat(3));
      continue;
    }

    wait 0.5;
  }
}

_id_8972() {
  if(self._id_041F <= self._id_EBC0 * 0.25) {
    return 0;
  }

  return self _meth_81E9();
}

_id_DCBF(var_0, var_1, var_2) {
  for(;;) {
    wait 0.05;
    wait 0.05;
  }
}

_id_17A1(var_0, var_1) {
  var_2 = var_0.size;
  var_3 = randomint(var_2);

  if(var_2 == 1) {
    return var_0[0];
  }

  var_4 = 0;
  var_5 = 0;

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_5 = var_5 + var_1[var_6];
  }

  var_7 = randomfloat(var_5);
  var_8 = 0;

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_8 = var_8 + var_1[var_6];

    if(var_7 >= var_8) {
      continue;
    }
    var_3 = var_6;
    break;
  }

  return var_0[var_3];
}

_id_31F5() {
  if(!self._id_0206) {
    return 0;
  }

  if(self._id_CD57) {
    return 1;
  }

  return isPlayer(self._id_0192);
}

_id_FF08() {
  return _func_0278(self._id_04F6);
}

_id_BFF1(var_0) {
  var_1 = randomint(var_0.size);

  if(var_0.size > 1) {
    var_2 = 0;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_2 = var_2 + var_0[var_3];
    }

    var_4 = randomfloat(var_2);
    var_2 = 0;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_2 = var_2 + var_0[var_3];

      if(var_4 < var_2) {
        var_1 = var_3;
        break;
      }
    }
  }

  return var_1;
}

_id_D568(var_0, var_1, var_2) {
  if(!isDefined(anim._id_AC55)) {
    anim._id_AC55 = [];
  }

  anim._id_AC55[var_1] = 1;
  level._effect["step_" + var_1][var_0] = var_2;
}

_id_D569(var_0, var_1, var_2) {
  if(!isDefined(anim._id_AC57)) {
    anim._id_AC57 = [];
  }

  anim._id_AC57[var_1] = 1;
  level._effect["step_small_" + var_1][var_0] = var_2;
}

_id_D567(var_0, var_1, var_2) {
  if(!isDefined(anim._id_AC52)) {
    anim._id_AC52 = [];
  }

  if(!isDefined(anim._id_5D00)) {
    anim._id_5D00 = 0;
  }

  anim._id_AC52[var_1] = 1;
  level._effect["footprint_" + var_1][var_0] = var_2;
}

_id_FA94(var_0) {
  if(isDefined(anim._id_AC55)) {
    anim._id_AC55[var_0] = undefined;
  }

  level._effect["step_" + var_0] = undefined;
}

_id_FA95(var_0) {
  if(isDefined(anim._id_AC57)) {
    anim._id_AC57[var_0] = undefined;
  }

  level._effect["step_small_" + var_0] = undefined;
}

_id_FA93(var_0) {
  if(isDefined(anim._id_AC52)) {
    anim._id_AC52[var_0] = undefined;
  }

  level._effect["footprint_" + var_0] = undefined;
}

_id_D610(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2)) {
    var_2 = "all";
  }

  if(!isDefined(level._id_0C6E)) {
    level._id_0C6E = [];
  }

  level._id_0C6E[var_0][var_2] = spawnStruct();
  level._id_0C6E[var_0][var_2]._id_0427 = var_1;
  level._id_0C6E[var_0][var_2]._id_605B = var_3;
  _id_D611(var_0, var_2, var_4, var_5);
}

_id_D611(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = "all";
  }

  if(!isDefined(level._id_0C6E)) {
    level._id_0C6E = [];
  }

  if(isDefined(level._id_0C6E[var_0][var_1])) {
    var_4 = level._id_0C6E[var_0][var_1];
  } else {
    var_4 = spawnStruct();
    level._id_0C6E[var_0][var_1] = var_4;
  }

  if(isDefined(var_2)) {
    var_4._id_E05A = var_2;
  }

  if(isDefined(var_3)) {
    var_4._id_E05B = var_3;
  }
}

_id_54DF(var_0) {
  thread _id_54E0(var_0);
}

_id_54E0(var_0) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self _meth_80E8(var_0, isDefined(self._id_0DDF._id_AA76));
  self waittill("killanimscript");

  if(self._id_0131 != "prone" && !isDefined(self._id_0DDF._id_AA76)) {
    self._id_0131 = "prone";
  }
}

_id_E917() {
  _id_578C(1.0);
  self._id_0DDF._id_AA76 = undefined;
}

_id_578C(var_0) {
  thread _id_578D(var_0);
}

_id_578D(var_0) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self _meth_80E9(var_0);
  self waittill("killanimscript");

  if(self._id_0131 == "prone") {
    self._id_0131 = "crouch";
  }
}

_id_1872(var_0) {
  return self._id_0DDF._id_1B8A[var_0];
}

_id_1873(var_0) {
  return isDefined(self._id_0DDF._id_1B8A[var_0]) && self._id_0DDF._id_1B8A[var_0].size > 0;
}

_id_1874(var_0) {
  var_1 = randomint(self._id_0DDF._id_1B8A[var_0].size);
  return self._id_0DDF._id_1B8A[var_0][var_1];
}

_id_1B8A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = [];

  if(isDefined(var_0)) {
    var_14[0] = var_0;
  } else {
    return var_14;
  }

  if(isDefined(var_1)) {
    var_14[1] = var_1;
  } else {
    return var_14;
  }

  if(isDefined(var_2)) {
    var_14[2] = var_2;
  } else {
    return var_14;
  }

  if(isDefined(var_3)) {
    var_14[3] = var_3;
  } else {
    return var_14;
  }

  if(isDefined(var_4)) {
    var_14[4] = var_4;
  } else {
    return var_14;
  }

  if(isDefined(var_5)) {
    var_14[5] = var_5;
  } else {
    return var_14;
  }

  if(isDefined(var_6)) {
    var_14[6] = var_6;
  } else {
    return var_14;
  }

  if(isDefined(var_7)) {
    var_14[7] = var_7;
  } else {
    return var_14;
  }

  if(isDefined(var_8)) {
    var_14[8] = var_8;
  } else {
    return var_14;
  }

  if(isDefined(var_9)) {
    var_14[9] = var_9;
  } else {
    return var_14;
  }

  if(isDefined(var_10)) {
    var_14[10] = var_10;
  } else {
    return var_14;
  }

  if(isDefined(var_11)) {
    var_14[11] = var_11;
  } else {
    return var_14;
  }

  if(isDefined(var_12)) {
    var_14[12] = var_12;
  } else {
    return var_14;
  }

  if(isDefined(var_13)) {
    var_14[13] = var_13;
  }

  return var_14;
}

_id_6899() {
  return self._id_034C;
}

_id_689C() {
  return self._id_03B5;
}

_id_689D() {
  return self._id_03D6;
}

_id_6891() {
  return self._id_04F6;
}

_id_6892() {
  if(self._id_04F6 == self._id_034C) {
    return "primary";
  } else if(self._id_04F6 == self._id_03B5) {
    return "secondary";
  } else if(self._id_04F6 == self._id_03D6) {
    return "sidearm";
  } else {}
}

_id_1326(var_0) {
  var_1 = getcompleteweaponname(var_0);

  if(isDefined(self.weaponinfo[var_1])) {
    return 1;
  }

  return 0;
}

_id_68C4(var_0) {
  var_1 = _func_00B0(var_0, 0, 1);
  return self _meth_8216(var_1);
}

_id_BF51(var_0) {
  self endon("killanimscript");
  var_1 = self.origin;
  var_2 = (0, 0, 0);

  for(;;) {
    wait 0.05;
    var_3 = distance(self.origin, var_1);
    var_1 = self.origin;

    if(self.health == 1) {
      self._id_0DDF._id_A567 = 1;
      self startragdoll();
      self _meth_8077(var_0, 0.1);
      wait 0.05;
      physicsexplosionsphere(var_1, 600, 0, var_3 * 0.1);
      self notify("killanimscript");
      return;
    }
  }
}

_id_DB19() {
  return _id_87D5() && !isDefined(self._id_0203);
}

_id_87D5() {
  return self._id_015B == "cqb";
}

_id_87D6() {
  return !self._id_01B7 || _id_87D5();
}

_id_C00C() {
  self._id_0DDF._id_7CD1 = randomint(2);
}

_id_6CC1(var_0, var_1) {
  var_2 = var_0 % anim._id_BFFF;
  return anim._id_BFFE[var_2] % var_1;
}

_id_69B2() {
  if(scripts\anim\utility_common::_id_8AD2()) {
    return "secondary";
  }

  if(scripts\anim\utility_common::_id_8AD4()) {
    return "sidearm";
  }

  return "primary";
}

_id_9815(var_0, var_1) {
  if(isDefined(self._id_1870)) {
    if(isDefined(anim._id_1A3D[self._id_1870][var_0]) && isDefined(anim._id_1A3D[self._id_1870][var_0][var_1])) {
      return anim._id_1A3D[self._id_1870][var_0][var_1];
    }
  }

  return anim._id_1A3D["soldier"][var_0][var_1];
}

_id_9816(var_0) {
  if(isDefined(self._id_1870)) {
    if(isDefined(anim._id_1A3D[self._id_1870][var_0])) {
      var_1 = anim._id_1A3D["soldier"][var_0];

      foreach(var_4, var_3 in anim._id_1A3D[self._id_1870][var_0]) {
        var_1[var_4] = var_3;
      }

      return var_1;
    }
  }

  return anim._id_1A3D["soldier"][var_0];
}

_id_8824(var_0) {
  return _func_0307(var_0);
}