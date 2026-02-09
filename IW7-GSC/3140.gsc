/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3140.gsc
*********************************************/

func_35BF(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.melee.var_312F = 1;
  var_4 = "far";
  var_5 = scripts\asm\asm_bb::bb_getmeleetarget();
  if(isDefined(var_5)) {
    var_6 = var_5.origin - self.origin;
    if(lengthsquared(var_6) < 7744) {
      var_4 = "near";
    }

    self orientmode("face angle", vectortoyaw(var_6));
  }

  var_7 = lib_0A1E::func_2356(var_1, var_4);
  var_8 = 0.8;
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82EA(var_1, var_7, 1, var_2, var_8);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  thread func_8482(var_1);
  lib_0A1E::func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
}

func_35C0(var_0, var_1, var_2) {
  if(func_35C2() || !isDefined(self.melee.var_2AAE)) {
    func_35BB();
  }
}

func_3616(var_0, var_1, var_2, var_3) {
  if(lib_0C64::melee_shouldabort(var_0, var_1, var_2, var_3)) {
    return 0;
  }

  return isDefined(self.melee.var_2AAE);
}

func_35C3(var_0, var_1, var_2, var_3) {
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82EA(var_1, var_4, 1, var_2, 0.5);
  lib_0A1E::func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
}

func_35C4(var_0, var_1, var_2) {
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

func_35C1(var_0) {
  switch (var_0) {
    case "grab":
      break;

    case "lookat":
      if(isPlayer(self.melee.target)) {
        thread func_B010();
      }
      break;

    case "throw":
      thread func_11831();
      break;
  }
}

func_3584(var_0, var_1, var_2) {
  var_3 = lib_0A1E::func_2356(var_1, self.melee.var_1180D);
  return var_3;
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

func_8482(var_0) {
  self endon(var_0 + "_finished");
  for(;;) {
    if(func_35C2()) {
      break;
    }

    if(isDefined(self.melee.var_2720)) {
      break;
    }

    var_1 = self gettagorigin("j_wrist_z_ri");
    var_2 = self.melee.target.origin + rotatevector((34, 3.4, 43.752), self.melee.target.angles);
    if(distancesquared(var_2, var_1) <= 1600) {
      func_8481();
      break;
    }

    wait(0.05);
  }
}

func_8481() {
  self.melee.var_2AAE = 1;
  var_0 = self gettagorigin("j_wrist_z_ri");
  var_1 = self gettagangles("j_wrist_z_ri");
  var_2 = spawn("script_model", var_0);
  var_2 setModel("tag_origin");
  self.melee.temp_ent = var_2;
  var_3 = ["left", "right", "forward"];
  self.melee.var_1180D = var_3[randomint(var_3.size)];
  var_4 = (0, 229, 180);
  if(isPlayer(self.melee.target)) {
    switch (self.melee.var_1180D) {
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

  var_2 linkto(self, "j_wrist_z_ri", (34, 3.4, 43.752), var_4);
  if(isPlayer(self.melee.target)) {
    func_35DC();
    level.player dodamage(level.player.health * 0.6, self.origin, self);
    level.player.ignoreme = 1;
    var_5 = 0.15;
    level.player playerlinktoblend(var_2, "tag_origin", var_5);
    level.player func_8291(5, 0, 0, var_5);
    wait(var_5);
    level.player playerlinktodelta(var_2, "tag_origin", 1, 0, 0, 0, 0, 1);
    level.player lerpviewangleclamp(0.4, 0, 0, 60, 60, 80, 15);
    return;
  }

  self.melee.target linktoblendtotag(var_2, "tag_origin");
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
  var_0 = lib_0A1E::func_2356("melee_throw", self.melee.var_1180D);
  var_1 = self getscoreinfovalue(var_0);
  self func_82B1(var_0, 0);
  wait(0.5);
  self func_82B1(var_0, var_1);
}

func_11831() {
  self endon("death");
  var_0 = self gettagorigin("j_wrist_z_ri");
  wait(0.05);
  var_1 = self gettagorigin("j_wrist_z_ri") + (0, 0, 7) - var_0;
  var_2 = length(var_1);
  var_3 = vectornormalize(var_1);
  var_4 = var_2 * 30 * var_3;
  var_5 = self.melee.target;
  if(!isalive(var_5)) {
    return;
  }

  if(isPlayer(var_5)) {
    var_6 = var_5;
    var_7 = vectortoangles(-1 * var_3);
    switch (self.melee.var_1180D) {
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
    self.melee.temp_ent linkto(self, "j_wrist_z_ri", (34, 3.4, 43.752), var_7);
    var_8 = 0.15;
    var_5 lerpviewangleclamp(var_8, 0, 0, 0, 0, 0, 0);
    var_5 func_8291(5, 0, 0, var_8);
    wait(var_8);
    func_35DD();
    var_5 unlink();
    var_5 setvelocity(var_4);
    var_5.ignoreme = 0;
    return;
  }

  var_5.asm.var_DC21 = var_4;
  var_5.asm.var_4E40 = ::func_1A3D;
  var_5 animmode("nogravity");
  var_5 func_81D0(self gettagorigin("j_wrist_z_ri"));
}

func_1A3D() {
  self giverankxp_regularmp("torso_upper", self.asm.var_DC21 * 7, 0);
  wait(0.05);
  self unlink();
}