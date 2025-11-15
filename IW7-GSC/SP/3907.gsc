/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3907.gsc
************************/

func_1000F() {
  return isDefined(self.isnodeoccupied) && isplayer(self.isnodeoccupied) && self getpersstat(self.isnodeoccupied);
}

func_6A70(param_00) {
  self endon(param_00 + "_finished");
  var_01 = self.setthermalbodymaterial * self.setthermalbodymaterial;
  for(;;) {
    scripts\engine\utility::waitframe();
    if(func_1000F()) {
      var_02 = distancesquared(self.origin, self.isnodeoccupied.origin);
      if(var_02 < var_01) {
        self orientmode("face enemy");
      } else {
        self orientmode("face current");
      }

      continue;
    }

    self orientmode("face current");
  }
}

func_116F5(param_00, param_01, param_02) {}

func_D46C(param_00, param_01, param_02, param_03) {
  func_D46D(param_00, param_01, param_02, param_03);
}

func_D46D(param_00, param_01, param_02, param_03) {
  scripts\anim\combat::func_F296();
  var_04 = self.var_164D[param_00];
  if(isDefined(var_04.var_10E23) && var_04.var_10E23 == "stand_run_loop" || var_04.var_10E23 == "move_walk_loop") {
    childthread scripts\asm\shared_utility::setuseanimgoalweight(param_01, param_02);
  }

  if(isDefined(self.target_getindexoftarget)) {
    self.var_1198.var_AA3D = self.target_getindexoftarget;
  }

  if(self.team != "allies") {
    thread func_6A70(param_01);
  }

  lib_0A1E::func_235F(param_00, param_01, param_02, 1);
}

reload(param_00, param_01, param_02, param_03) {
  self endon("reload_terminate");
  self endon(param_01 + "_finished");
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  if(weaponclass(self.var_394) == "pistol") {
    self orientmode("face enemy");
  }

  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_04, 1, param_02, 1);
  lib_0A1E::func_2369(param_00, param_01, var_04);
  lib_0A1E::func_231F(param_00, param_01);
  scripts\anim\weaponlist::refillclip();
}

func_CECB(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_bb::bb_getrequestedweapon();
  var_05 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  self _meth_82E4(param_01, var_05, lib_0A1E::asm_getbodyknob(), 1, param_02, scripts\anim\combat_utility::func_6B9A());
  lib_0A1E::func_2369(param_00, param_01, var_05);
  lib_0A1E::func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
  self notify("switched_to_sidearm");
  scripts\sp\gameskill::func_54C4();
}

func_D56A(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  scripts\sp\gameskill::func_54C4();
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  if(scripts\engine\utility::actor_is3d() && isDefined(self.isnodeoccupied)) {
    self orientmode("face enemy");
  } else {
    self orientmode("face angle 3d", self.angles);
  }

  if(isDefined(self.target_getindexoftarget)) {
    self animmode("angle deltas");
  } else {
    self animmode("zonly_physics");
  }

  lib_0A1E::func_2369(param_00, param_01, var_04);
  self.var_10F8C = angleclamp180(getangledelta(var_04, 0, 1) + self.angles[1]);
  self.var_36A = 1;
  self _meth_82E7(param_01, var_04, 1, param_02, 1);
  if(func_1000F()) {
    thread func_D56D(var_04, param_01);
  }

  var_05 = lib_0A1E::func_231F(param_00, param_01);
  if(var_05 == "end") {
    thread scripts\asm\asm::func_2310(param_00, param_01, 0);
  }
}

func_D56D(param_00, param_01) {
  self endon("death");
  self endon(param_01 + "_finished");
  var_02 = self.isnodeoccupied;
  var_02 endon("death");
  var_03 = getanimlength(param_00);
  var_04 = int(var_03 * 20);
  var_05 = var_04;
  while(var_05 > 0) {
    var_06 = 1 / var_05;
    var_07 = scripts\engine\utility::getyawtospot(var_02.origin);
    self.var_10F8C = angleclamp180(self.angles[1] + var_07);
    var_08 = self getscoreinfocategory(param_00);
    var_09 = getangledelta(param_00, var_08, 1);
    var_0A = angleclamp180(var_07 - var_09);
    self orientmode("face angle", angleclamp(self.angles[1] + var_0A * var_06));
    var_05--;
    wait(0.05);
  }
}

func_D56B(param_00, param_01, param_02) {
  self.var_36A = 0;
  self.var_10F8C = undefined;
}

func_9EB9(param_00, param_01, param_02, param_03) {
  return !scripts\asm\shared_utility::isatcovernode();
}

func_1007E(param_00, param_01, param_02, param_03) {
  if(scripts\asm\asm_bb::bb_moverequested()) {
    return 0;
  }

  if(!scripts\asm\shared_utility::isatcovernode()) {
    return 0;
  }

  if(!isDefined(self.target_getindexoftarget)) {
    return 0;
  }

  if(isDefined(self.primaryweapon) && scripts\anim\utility_common::isusingsidearm() && weaponclass(self.primaryweapon) != "mg") {
    return 0;
  }

  if(!isDefined(param_03)) {
    return 1;
  }

  return lib_0F3D::func_9D4C(param_00, param_01, param_02, param_03);
}

func_1007F(param_00, param_01, param_02, param_03) {
  var_04 = self.target_getindexoftarget;
  var_05 = angleclamp180(scripts\asm\shared_utility::gethighestnodestance(var_04) - self.angles[1]);
  return abs(angleclamp180(var_05)) > self.var_129AF;
}

func_4C03(param_00, param_01, param_02, param_03) {
  var_04 = param_03;
  if(!isDefined(self.target_getindexoftarget)) {
    return var_04 == "Exposed Crouch";
  }

  if(distance2dsquared(self.origin, self.target_getindexoftarget.origin) > 225) {
    if(scripts\asm\asm_bb::func_292C() == "stand") {
      return var_04 == "Exposed";
    } else {
      return var_04 == "Exposed Crouch";
    }
  }

  return lib_0F3D::func_9D4C(param_00, param_01, param_02, param_03);
}