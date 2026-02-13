/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1891.gsc
*************************************************/

_id_4055(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_E4A3 = var_0;
  anim._id_E4A8[var_0] = var_2;
  var_2.team = _id_6D79(var_1);
  var_2._id_DD3C = 0;
  var_2.origin = undefined;
  var_2._id_01D7 = undefined;
  var_2._id_0192 = undefined;
  var_2._id_88BB = 0;
  var_2._id_9DB1 = 0;
  var_2._id_9DB5 = [];
  var_2._id_A95D = [];
  var_2._id_A95C = 0;
  var_2._id_E49D = [];
  var_2._id_9DAF = [];
  var_2._id_9DB0 = [];
  var_2._id_9DB3 = [];
  var_2._id_9DB4 = [];
  var_2._id_E4B3 = [];
  var_2._id_E4B4 = [];
  var_2._id_E495 = anim._id_E496.size;
  anim._id_E496[anim._id_E496.size] = var_2;
  var_2 _id_FD3D();
  level notify("squad created " + var_0);
  anim notify("squad created " + var_0);

  for(var_3 = 0; var_3 < anim._id_E48C.size; var_3++) {
    var_4 = anim._id_E48C[var_3];
    var_2 thread[[var_4]]();
  }

  for(var_5 = 0; var_5 < anim._id_E496.size; var_5++) {
    anim._id_E496[var_5] _id_FD3D();
  }

  return var_2;
}

_id_4791(var_0) {
  if(var_0 == "axis" || var_0 == "team3" || var_0 == "allies" || var_0 == "jackal_allies" || var_0 == "jackal_axis") {
    return;
  }
  var_1 = anim._id_E4A8[var_0]._id_E495;
  var_2 = anim._id_E4A8[var_0];
  var_2 notify("squad_deleting");

  while(var_2._id_9DB5.size) {
    var_2._id_9DB5[0] _id_1170(var_2._id_9DB5[0].team);
  }

  anim._id_E496[var_1] = anim._id_E496[anim._id_E496.size - 1];
  anim._id_E496[var_1]._id_E495 = var_1;
  anim._id_E496[anim._id_E496.size - 1] = undefined;
  anim._id_E4A8[var_0] = undefined;
  anim notify("squad deleted " + var_0);

  for(var_3 = 0; var_3 < anim._id_E496.size; var_3++) {
    anim._id_E496[var_3] _id_FD3D();
  }
}

_id_1113(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(self._id_CE5D)) {
      var_0 = self._id_CE5D;
    } else {
      var_0 = self.team;
    }
  }

  if(!isDefined(anim._id_E4A8[var_0])) {
    anim _id_4055(var_0, self);
  }

  var_1 = anim._id_E4A8[var_0];
  var_2 = 0;

  if(isDefined(var_1._id_9DB5)) {
    for(var_3 = 0; var_3 < var_1._id_9DB5.size; var_3++) {
      var_4 = var_1._id_9DB5[var_3];

      if(var_4 != anim.player) {
        continue;
      } else {
        var_2 = 1;
        break;
      }
    }

    if(!var_2) {
      var_1._id_9DB5[var_1._id_9DB5.size] = self;
    }
  }

  self._id_E478 = var_1;
}

_id_B65B() {
  var_0 = getEntArray("player", "classname")[0];
  _id_0751::_id_B618();
  anim.player = var_0;

  if(!isDefined(anim.player.team)) {
    anim.player.team = "allies";
  }

  _id_0751::_id_B618();
  anim._id_56B2["threat"]["self"] = 9000;
  anim._id_56B2["threat"]["squad"] = 5000;
  level._id_244A = _func_0219(5000);
  level._id_2449 = _func_0219(3000);
  level._id_2448 = _func_0219(1500);
  anim._id_EFB4 = 120000;
  anim._id_59EE = 620;
  anim._id_59F4 = 12;
  anim._id_59F3 = 24;
  anim._id_59F2 = 2;
  anim._id_59F1 = 5;
  anim.player _id_1113("allies");

  for(var_1 = 0; var_1 < anim._id_E496.size; var_1++) {
    anim._id_E496[var_1]._id_9DB5 = scripts\engine\utility::_id_1BD1(anim._id_E496[var_1]._id_9DB5);
    anim._id_E496[var_1] _id_FD3D();
  }

  _id_0751::_id_8069();

  for(;;) {
    var_2 = [];

    for(var_3 = 0; var_3 < anim._id_E4A8["allies"]._id_9DB5.size; var_3++) {
      var_4 = anim._id_E4A8["allies"]._id_9DB5[var_3];

      if(!isDefined(level._id_B528) || isDefined(level._id_B528) && var_4 != level._id_B528) {
        var_2[var_2.size] = var_4;
      }
    }

    anim._id_E4A8["allies"]._id_9DB5 = var_2;
    anim.player = var_0;

    if(!isDefined(anim.player.team)) {
      anim.player.team = "allies";
    }

    _id_0751::_id_B618();
    anim._id_56B2["threat"]["self"] = 9000;
    anim._id_56B2["threat"]["squad"] = 5000;
    level._id_244A = _func_0219(5000);
    level._id_2449 = _func_0219(3000);
    level._id_2448 = _func_0219(1500);
    anim._id_EFB4 = 120000;
    anim._id_59EE = 620;
    anim._id_59F4 = 12;
    anim._id_59F3 = 24;
    anim._id_59F2 = 2;
    anim._id_59F1 = 5;
    anim.player _id_1113("allies");

    for(var_5 = 0; var_5 < anim._id_E496.size; var_5++) {
      anim._id_E496[var_5]._id_9DB5 = scripts\engine\utility::_id_1BD1(anim._id_E496[var_5]._id_9DB5);
      anim._id_E496[var_5] _id_FD3D();
    }

    _id_0751::_id_8069();
    wait 0.5;
  }
}

_id_6D79(var_0) {
  var_1 = "allies";

  if(isDefined(level._id_F077) && level._id_F077 == "phparade") {
    var_0.team = "allies";
  }

  if(var_0.team == "axis" || var_0.team == "neutral" || var_0.team == "team3") {
    var_1 = var_0.team;
  }

  return var_1;
}

_id_1170(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(self._id_CE5D)) {
      var_0 = self._id_CE5D;
    } else {
      var_0 = self.team;
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(anim._id_E4A8[var_0])) {
    anim _id_4055(var_0, self);
  }

  var_1 = anim._id_E4A8[var_0];

  if(isDefined(self._id_E478)) {
    if(self._id_E478 == var_1) {
      return;
    } else {
      _id_C4B8(self._id_E478);
    }
  }

  self._id_8FCD = 0;
  self._id_3ACB = 0;
  self._id_E72D = gettime();
  self._id_E478 = var_1;
  var_1._id_9DB5[var_1._id_9DB5.size] = self;
  var_1._id_9DB1 = var_1._id_9DB5.size;

  if(isDefined(self._id_E478._id_9DAF)) {
    for(var_2 = 0; var_2 < self._id_E478._id_9DAF.size; var_2++) {
      var_3 = self._id_E478._id_9DAF[var_2];
      self thread[[var_3]](self._id_E478._id_E4A3);
    }
  }

  thread _id_9DB2();
}

_id_C4B8(var_0) {
  if(!isDefined(var_0) && !isDefined(self._id_E478)) {
    return;
  }
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, self._id_E478);
  var_0._id_9DB5 = scripts\engine\utility::_id_1BD1(var_0._id_9DB5);

  if(isDefined(self)) {
    var_0._id_9DB5 = scripts\engine\utility::array_remove(var_0._id_9DB5, self);
    self._id_E478 = var_0;
  }

  var_0._id_9DB1 = var_0._id_9DB5.size;

  for(var_1 = 0; var_1 < var_0._id_9DB3.size; var_1++) {
    var_2 = var_0._id_9DB3[var_1];
    self thread[[var_2]](var_0._id_E4A3);
  }

  if(var_0._id_9DB5.size == 0) {
    _id_4791(var_0._id_E4A3);
  }

  if(isDefined(self)) {
    self._id_E478 = undefined;
    self notify("removed from squad");
  }
}

_id_1103() {
  var_0 = self._id_E478;

  if(isDefined(self._id_E4A5)) {
    return;
  }
  self._id_E4A5 = var_0._id_A95D.size;
  var_0._id_A95D[self._id_E4A5] = self;
  var_0._id_A95C = var_0._id_A95D.size;
}

_id_C4F4() {
  var_0 = self._id_E478;
  var_1 = -1;

  if(isDefined(self)) {
    var_1 = self._id_E4A5;
  } else {
    for(var_2 = 0; var_2 < var_0._id_A95D.size; var_2++) {
      if(var_0._id_A95D[var_2] == self) {
        var_1 = var_2;
      }
    }
  }

  if(var_1 != var_0._id_A95D.size - 1) {
    var_3 = var_0._id_A95D[var_0._id_A95D.size - 1];
    var_0._id_A95D[var_1] = var_3;

    if(isDefined(var_3)) {
      var_3._id_E4A5 = var_1;
    }
  }

  var_0._id_A95D[var_0._id_A95D.size - 1] = undefined;
  var_0._id_A95C = var_0._id_A95D.size;

  if(isDefined(self)) {
    self._id_E4A5 = undefined;
  }
}

_id_A95E() {
  for(var_0 = 0; var_0 < self._id_9DB5.size; var_0++) {
    if(self._id_9DB5[var_0] _id_070A::_id_895C()) {
      self._id_9DB5[var_0] _id_1103();
    }
  }
}

_id_9DB2() {
  self endon("removed from squad");
  var_0 = self._id_E478;
  self waittill("death", var_1);

  if(isDefined(self)) {
    self.attacker = var_1;
  }

  _id_C4B8(var_0);
}

_id_FC36() {}

_id_FD3D() {
  for(var_0 = 0; var_0 < anim._id_E496.size; var_0++) {
    if(!isDefined(self._id_E49D[anim._id_E496[var_0]._id_E4A3])) {
      self._id_E49D[anim._id_E496[var_0]._id_E4A3] = spawnStruct();
      self._id_E49D[anim._id_E496[var_0]._id_E4A3]._id_88BC = 0;
    }

    for(var_1 = 0; var_1 < self._id_E4B3.size; var_1++) {
      var_2 = self._id_E4B3[var_1];
      self thread[[var_2]](anim._id_E496[var_0]._id_E4A3);
    }
  }
}

_id_BD0A(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = (1, 0, 0);
  }

  for(var_4 = 0; var_4 < var_1 * 2; var_4++) {
    if(!isalive(self)) {
      return;
    }
    var_5 = self _meth_8176() + (0, 0, 10) + var_2;
    wait 0.05;
  }
}

_id_13F8(var_0) {
  switch (var_0) {
    case "stop":
    case "move":
    case "combat":
    case "death":
      self._id_0DDF._id_E747 = var_0;
      break;
    case "grenadecower":
    case "pain":
      break;
    case "concealment_stand":
    case "concealment_prone":
    case "concealment_crouch":
    case "cover_prone":
    case "stalingrad_cover_crouch":
    case "cover_wide_right":
    case "cover_wide_left":
    case "cover_right":
    case "cover_left":
    case "cover_stand":
    case "cover_crouch":
      self._id_0DDF._id_E747 = "cover";
      break;
    case "l33t truckride combat":
    case "aim":
      self._id_0DDF._id_E747 = "combat";
      break;
  }
}

_id_FCC6() {
  anim endon("squad deleted " + self._id_E4A3);
  var_0 = 0.05;

  for(;;) {
    for(var_1 = 0; var_1 < self._id_9DB5.size; var_1++) {
      var_2 = self._id_9DB5[var_1];

      if(!isalive(var_2) || isDefined(anim.player) && var_2 == anim.player) {
        continue;
      }
      var_2 _id_13F9(var_0);
      var_2 _id_13FA(var_0);
    }

    wait(var_0);
  }
}

_id_13F9(var_0) {
  if(!isDefined(self._id_3ACB)) {
    return;
  }
  if(isDefined(self._id_0270)) {
    if(self._id_3ACB < 0) {
      self._id_3ACB = var_0;
    } else {
      self._id_3ACB = self._id_3ACB + var_0;
    }

    self._id_8FCD = gettime();
    return;
  } else if(isDefined(self._id_2C5F) && self._id_2C5F || isDefined(self._id_1CB8) && self._id_1CB8 != "jackal" && self _meth_81E9()) {
    self._id_3ACB = self._id_3ACB + var_0;
    return;
  }

  if(self._id_3ACB > 0) {
    self._id_3ACB = 0 - var_0;
  } else {
    self._id_3ACB = self._id_3ACB - var_0;
  }
}

_id_13FA(var_0) {
  if(!isDefined(self._id_EBAD)) {
    return;
  }
  if(isDefined(self._id_2C5F) && self._id_2C5F || isDefined(self._id_1CB8) && self._id_1CB8 != "jackal" && self _meth_81E9()) {
    if(self._id_EBAD < 0) {
      self._id_EBAD = var_0;
    } else {
      self._id_EBAD = self._id_EBAD + var_0;
    }
  } else {
    if(self._id_EBAD > 0) {
      self._id_EBAD = 0 - var_0;
      return;
    }

    self._id_EBAD = self._id_EBAD - var_0;
  }
}