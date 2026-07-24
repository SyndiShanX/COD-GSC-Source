/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3140.gsc
**************************************/

_id_35BF(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.melee._id_312F = 1;
  var_4 = "far";
  var_5 = scripts\asm\asm_bb::bb_getmeleetarget();

  if(isDefined(var_5)) {
    var_6 = var_5.origin - self.origin;

    if(lengthsquared(var_6) < 7744) {
      var_4 = "near";
    }

    self orientmode("face angle", vectortoyaw(var_6));
  }

  var_7 = _id_0A1E::_id_2356(var_1, var_4);
  var_8 = 0.8;
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_7, 1.0, var_2, var_8);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  thread _id_8482(var_1);
  _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
}

_id_35C0(var_0, var_1, var_2) {
  if(_id_35C2() || !isDefined(self.melee._id_2AAE)) {
    _id_35BB();
  }
}

_id_3616(var_0, var_1, var_2, var_3) {
  if(_id_0C64::melee_shouldabort(var_0, var_1, var_2, var_3)) {
    return 0;
  }

  return isDefined(self.melee._id_2AAE);
}

_id_35C3(var_0, var_1, var_2, var_3) {
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1.0, var_2, 0.5);
  _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
}

_id_35C4(var_0, var_1, var_2) {
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "end");
  _id_35BB();
}

_id_35BB() {
  if(isDefined(self.melee) && isDefined(self.melee.target)) {
    self.melee.target.melee = undefined;
  }

  if(isDefined(self.melee) && isDefined(self.melee.temp_ent)) {
    self.melee.temp_ent delete();
  }

  _id_0C64::_id_B58E();
}

_id_35C1(var_0) {
  switch (var_0) {
    case "grab":
      break;
    case "lookat":
      if(isPlayer(self.melee.target)) {
        thread _id_B010();
      }

      break;
    case "throw":
      thread _id_11831();
      break;
  }
}

_id_3584(var_0, var_1, var_2) {
  var_3 = _id_0A1E::_id_2356(var_1, self.melee._id_1180D);
  return var_3;
}

_id_35C2() {
  if(!isalive(self)) {
    return 1;
  }

  if(!isDefined(self.melee)) {
    return 1;
  }

  if(isDefined(self.melee._id_2720)) {
    return 1;
  }

  if(!isDefined(self.melee.target)) {
    return 1;
  }

  if(!isalive(self.melee.target)) {
    return 1;
  }

  if(!isDefined(self.melee.target.melee)) {
    return 1;
  }

  return 0;
}

_id_8482(var_0) {
  self endon(var_0 + "_finished");

  for(;;) {
    if(_id_35C2()) {
      break;
    }

    if(isDefined(self.melee._id_2720)) {
      break;
    }

    var_1 = self gettagorigin("j_wrist_z_ri");
    var_2 = self.melee.target.origin + rotatevector((34, 3.4, 43.752), self.melee.target.angles);

    if(distancesquared(var_2, var_1) <= 1600) {
      _id_8481();
      break;
    }

    wait 0.05;
  }
}

_id_8481() {
  self.melee._id_2AAE = 1;
  var_0 = self gettagorigin("j_wrist_z_ri");
  var_1 = self gettagangles("j_wrist_z_ri");
  var_2 = spawn("script_model", var_0);
  var_2 setModel("tag_origin");
  self.melee.temp_ent = var_2;
  var_3 = ["left", "right", "forward"];
  self.melee._id_1180D = var_3[randomint(var_3.size)];
  var_4 = (0, 229, 180);

  if(isPlayer(self.melee.target)) {
    switch (self.melee._id_1180D) {
      case "left":
        var_4 = (15, 229, 180);
        break;
      case "right":
        var_4 = (30, 229, 180);
        break;
      case "forward":
        var_4 = (-5, 290, 180);
        break;
    }
  }

  var_2 linkTo(self, "j_wrist_z_ri", (34, 3.4, 43.752), var_4);

  if(isPlayer(self.melee.target)) {
    _id_35DC();
    level.player dodamage(level.player.health * 0.6, self.origin, self);
    level.player.ignoreme = 1;
    var_5 = 0.15;
    level.player _meth_823C(var_2, "tag_origin", var_5);
    level.player _meth_8291(5, 0, 0, var_5);
    wait(var_5);
    level.player playerlinktodelta(var_2, "tag_origin", 1, 0, 0, 0, 0, 1);
    level.player lerpviewangleclamp(0.4, 0, 0, 60, 60, 80, 15);
  } else
    self.melee.target _meth_81E1(var_2, "tag_origin");
}

_id_35DC() {
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
}

_id_35DD() {
  level.player allowstand(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
}

_id_B010() {
  var_0 = _id_0A1E::_id_2356("melee_throw", self.melee._id_1180D);
  var_1 = self _meth_8104(var_0);
  self _meth_82B1(var_0, 0);
  wait 0.5;
  self _meth_82B1(var_0, var_1);
}

_id_11831() {
  self endon("death");
  var_0 = self gettagorigin("j_wrist_z_ri");
  wait 0.05;
  var_1 = self gettagorigin("j_wrist_z_ri") + (0, 0, 7) - var_0;
  var_2 = length(var_1);
  var_3 = vectorNormalize(var_1);
  var_4 = var_2 * 30 * var_3;
  var_5 = self.melee.target;

  if(!isalive(var_5)) {
    return;
  }
  if(isPlayer(var_5)) {
    var_6 = var_5;
    var_7 = vectortoangles(-1 * var_3);

    switch (self.melee._id_1180D) {
      case "left":
        var_7 = var_7 + (0, -30, 0);
        break;
      case "right":
        var_7 = var_7 + (45, 60, 0);
        break;
      case "forward":
        var_7 = var_7 + (-10, 190, 0);
        break;
    }

    self.melee.temp_ent unlink();
    var_7 = var_7 - self gettagangles("j_wrist_z_ri");
    self.melee.temp_ent linkTo(self, "j_wrist_z_ri", (34, 3.4, 43.752), var_7);
    var_8 = 0.15;
    var_5 lerpviewangleclamp(var_8, 0, 0, 0, 0, 0, 0);
    var_5 _meth_8291(5, 0, 0, var_8);
    wait(var_8);
    _id_35DD();
    var_5 unlink();
    var_5 setvelocity(var_4);
    var_5.ignoreme = 0;
  } else {
    var_5.asm._id_DC21 = var_4;
    var_5.asm._id_4E40 = ::_id_1A3D;
    var_5 animmode("nogravity");
    var_5 _meth_81D0(self gettagorigin("j_wrist_z_ri"));
  }
}

_id_1A3D() {
  self _meth_839B("torso_upper", self.asm._id_DC21 * 7, 0);
  wait 0.05;
  self unlink();
}