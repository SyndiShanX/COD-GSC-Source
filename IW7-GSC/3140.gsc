/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3140.gsc
************************/

func_35BF(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.melee.var_312F = 1;
  var_04 = "far";
  var_05 = scripts\asm\asm_bb::bb_getmeleetarget();
  if(isDefined(var_05)) {
    var_06 = var_05.origin - self.origin;
    if(lengthsquared(var_06) < 7744) {
      var_04 = "near";
    }

    self orientmode("face angle", vectortoyaw(var_06));
  }

  var_07 = lib_0A1E::func_2356(param_01, var_04);
  var_08 = 0.8;
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_07, 1, param_02, var_08);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  thread _meth_8482(param_01);
  lib_0A1E::func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
}

func_35C0(param_00, param_01, param_02) {
  if(func_35C2() || !isDefined(self.melee.var_2AAE)) {
    func_35BB();
  }
}

func_3616(param_00, param_01, param_02, param_03) {
  if(lib_0C64::melee_shouldabort(param_00, param_01, param_02, param_03)) {
    return 0;
  }

  return isDefined(self.melee.var_2AAE);
}

func_35C3(param_00, param_01, param_02, param_03) {
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_04, 1, param_02, 0.5);
  lib_0A1E::func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
}

func_35C4(param_00, param_01, param_02) {
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "end");
  func_35BB();
}

func_35BB() {
  if(isDefined(self.melee) && isDefined(self.melee.target)) {
    self.melee.target.melee = undefined;
  }

  if(isDefined(self.melee) && isDefined(self.melee.temp_ent)) {
    self.melee.temp_ent delete();
  }

  lib_0C64::func_B58E();
}

func_35C1(param_00) {
  switch (param_00) {
    case "grab":
      break;

    case "lookat":
      if(isplayer(self.melee.target)) {
        thread func_B010();
      }
      break;

    case "throw":
      thread func_11831();
      break;
  }
}

func_3584(param_00, param_01, param_02) {
  var_03 = lib_0A1E::func_2356(param_01, self.melee.var_1180D);
  return var_03;
}

func_35C2() {
  if(!isalive(self)) {
    return 1;
  }

  if(!isDefined(self.melee)) {
    return 1;
  }

  if(isDefined(self.melee.var_2720)) {
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

_meth_8482(param_00) {
  self endon(param_00 + "_finished");
  for(;;) {
    if(func_35C2()) {
      break;
    }

    if(isDefined(self.melee.var_2720)) {
      break;
    }

    var_01 = self gettagorigin("j_wrist_z_ri");
    var_02 = self.melee.target.origin + rotatevector((34, 3.4, 43.752), self.melee.target.angles);
    if(distancesquared(var_02, var_01) <= 1600) {
      _meth_8481();
      break;
    }

    wait(0.05);
  }
}

_meth_8481() {
  self.melee.var_2AAE = 1;
  var_00 = self gettagorigin("j_wrist_z_ri");
  var_01 = self gettagangles("j_wrist_z_ri");
  var_02 = spawn("script_model", var_00);
  var_02 setModel("tag_origin");
  self.melee.temp_ent = var_02;
  var_03 = ["left", "right", "forward"];
  self.melee.var_1180D = var_03[randomint(var_03.size)];
  var_04 = (0, 229, 180);
  if(isplayer(self.melee.target)) {
    switch (self.melee.var_1180D) {
      case "left":
        var_04 = (15, 229, 180);
        break;

      case "right":
        var_04 = (30, 229, 180);
        break;

      case "forward":
        var_04 = (-5, 290, 180);
        break;
    }
  }

  var_02 linkto(self, "j_wrist_z_ri", (34, 3.4, 43.752), var_04);
  if(isplayer(self.melee.target)) {
    func_35DC();
    level.player dodamage(level.player.health * 0.6, self.origin, self);
    level.player.ignoreme = 1;
    var_05 = 0.15;
    level.player playerlinktoblend(var_02, "tag_origin", var_05);
    level.player _meth_8291(5, 0, 0, var_05);
    wait(var_05);
    level.player playerlinktodelta(var_02, "tag_origin", 1, 0, 0, 0, 0, 1);
    level.player lerpviewangleclamp(0.4, 0, 0, 60, 60, 80, 15);
    return;
  }

  self.melee.target linktoblendtotag(var_02, "tag_origin");
}

func_35DC() {
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
}

func_35DD() {
  level.player allowstand(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
}

func_B010() {
  var_00 = lib_0A1E::func_2356("melee_throw", self.melee.var_1180D);
  var_01 = self getscoreinfovalue(var_00);
  self _meth_82B1(var_00, 0);
  wait(0.5);
  self _meth_82B1(var_00, var_01);
}

func_11831() {
  self endon("death");
  var_00 = self gettagorigin("j_wrist_z_ri");
  wait(0.05);
  var_01 = self gettagorigin("j_wrist_z_ri") + (0, 0, 7) - var_00;
  var_02 = length(var_01);
  var_03 = vectornormalize(var_01);
  var_04 = var_02 * 30 * var_03;
  var_05 = self.melee.target;
  if(!isalive(var_05)) {
    return;
  }

  if(isplayer(var_05)) {
    var_06 = var_05;
    var_07 = vectortoangles(-1 * var_03);
    switch (self.melee.var_1180D) {
      case "left":
        var_07 = var_07 + (0, -30, 0);
        break;

      case "right":
        var_07 = var_07 + (45, 60, 0);
        break;

      case "forward":
        var_07 = var_07 + (-10, 190, 0);
        break;
    }

    self.melee.temp_ent unlink();
    var_07 = var_07 - self gettagangles("j_wrist_z_ri");
    self.melee.temp_ent linkto(self, "j_wrist_z_ri", (34, 3.4, 43.752), var_07);
    var_08 = 0.15;
    var_05 lerpviewangleclamp(var_08, 0, 0, 0, 0, 0, 0);
    var_05 _meth_8291(5, 0, 0, var_08);
    wait(var_08);
    func_35DD();
    var_05 unlink();
    var_05 setvelocity(var_04);
    var_05.ignoreme = 0;
    return;
  }

  var_05.asm.var_DC21 = var_04;
  var_05.asm.var_4E40 = ::func_1A3D;
  var_05 animmode("nogravity");
  var_05 _meth_81D0(self gettagorigin("j_wrist_z_ri"));
}

func_1A3D() {
  self giverankxp_regularmp("torso_upper", self.asm.var_DC21 * 7, 0);
  wait(0.05);
  self unlink();
}