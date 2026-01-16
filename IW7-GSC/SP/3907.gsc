/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3907.gsc
*********************************************/

func_1000F() {
  return isDefined(self.enemy) && isplayer(self.enemy) && self cansee(self.enemy);
}

func_6A70(var_0) {
  self endon(var_0 + "_finished");
  var_1 = self.setthermalbodymaterial * self.setthermalbodymaterial;
  for(;;) {
    scripts\engine\utility::waitframe();
    if(func_1000F()) {
      var_2 = distancesquared(self.origin, self.enemy.origin);
      if(var_2 < var_1) {
        self orientmode("face enemy");
      } else {
        self orientmode("face current");
      }

      continue;
    }

    self orientmode("face current");
  }
}

func_116F5(var_0, var_1, var_2) {}

func_D46C(var_0, var_1, var_2, var_3) {
  func_D46D(var_0, var_1, var_2, var_3);
}

func_D46D(var_0, var_1, var_2, var_3) {
  scripts\anim\combat::func_F296();
  var_4 = self.var_164D[var_0];
  if(isDefined(var_4.var_10E23) && var_4.var_10E23 == "stand_run_loop" || var_4.var_10E23 == "move_walk_loop") {
    childthread scripts\asm\shared_utility::setuseanimgoalweight(var_1, var_2);
  }

  if(isDefined(self.node)) {
    self._blackboard.var_AA3D = self.node;
  }

  if(self.team != "allies") {
    thread func_6A70(var_1);
  }

  lib_0A1E::func_235F(var_0, var_1, var_2, 1);
}

reload(var_0, var_1, var_2, var_3) {
  self endon("reload_terminate");
  self endon(var_1 + "_finished");
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  if(weaponclass(self.weapon) == "pistol") {
    self orientmode("face enemy");
  }

  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82EA(var_1, var_4, 1, var_2, 1);
  lib_0A1E::func_2369(var_0, var_1, var_4);
  lib_0A1E::func_231F(var_0, var_1);
  scripts\anim\weaponlist::refillclip();
}

func_CECB(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_bb::bb_getrequestedweapon();
  var_5 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self func_82E4(var_1, var_5, lib_0A1E::asm_getbodyknob(), 1, var_2, scripts\anim\combat_utility::func_6B9A());
  lib_0A1E::func_2369(var_0, var_1, var_5);
  lib_0A1E::func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
  self notify("switched_to_sidearm");
  scripts\sp\gameskill::func_54C4();
}

func_D56A(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\sp\gameskill::func_54C4();
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  if(scripts\engine\utility::actor_is3d() && isDefined(self.enemy)) {
    self orientmode("face enemy");
  } else {
    self orientmode("face angle 3d", self.angles);
  }

  if(isDefined(self.node)) {
    self animmode("angle deltas");
  } else {
    self animmode("zonly_physics");
  }

  lib_0A1E::func_2369(var_0, var_1, var_4);
  self.var_10F8C = angleclamp180(getangledelta(var_4, 0, 1) + self.angles[1]);
  self.var_36A = 1;
  self func_82E7(var_1, var_4, 1, var_2, 1);
  if(func_1000F()) {
    thread func_D56D(var_4, var_1);
  }

  var_5 = lib_0A1E::func_231F(var_0, var_1);
  if(var_5 == "end") {
    thread scripts\asm\asm::func_2310(var_0, var_1, 0);
  }
}

func_D56D(var_0, var_1) {
  self endon("death");
  self endon(var_1 + "_finished");
  var_2 = self.enemy;
  var_2 endon("death");
  var_3 = getanimlength(var_0);
  var_4 = int(var_3 * 20);
  var_5 = var_4;
  while(var_5 > 0) {
    var_6 = 1 / var_5;
    var_7 = scripts\engine\utility::getyawtospot(var_2.origin);
    self.var_10F8C = angleclamp180(self.angles[1] + var_7);
    var_8 = self getscoreinfocategory(var_0);
    var_9 = getangledelta(var_0, var_8, 1);
    var_10 = angleclamp180(var_7 - var_9);
    self orientmode("face angle", angleclamp(self.angles[1] + var_10 * var_6));
    var_5--;
    wait(0.05);
  }
}

func_D56B(var_0, var_1, var_2) {
  self.var_36A = 0;
  self.var_10F8C = undefined;
}

func_9EB9(var_0, var_1, var_2, var_3) {
  return !scripts\asm\shared_utility::isatcovernode();
}

func_1007E(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::bb_moverequested()) {
    return 0;
  }

  if(!scripts\asm\shared_utility::isatcovernode()) {
    return 0;
  }

  if(!isDefined(self.node)) {
    return 0;
  }

  if(isDefined(self.primaryweapon) && scripts\anim\utility_common::isusingsidearm() && weaponclass(self.primaryweapon) != "mg") {
    return 0;
  }

  if(!isDefined(var_3)) {
    return 1;
  }

  return lib_0F3D::func_9D4C(var_0, var_1, var_2, var_3);
}

func_1007F(var_0, var_1, var_2, var_3) {
  var_4 = self.node;
  var_5 = angleclamp180(scripts\asm\shared_utility::gethighestnodestance(var_4) - self.angles[1]);
  return abs(angleclamp180(var_5)) > self.var_129AF;
}

func_4C03(var_0, var_1, var_2, var_3) {
  var_4 = var_3;
  if(!isDefined(self.node)) {
    return var_4 == "Exposed Crouch";
  }

  if(distance2dsquared(self.origin, self.node.origin) > 225) {
    if(scripts\asm\asm_bb::func_292C() == "stand") {
      return var_4 == "Exposed";
    } else {
      return var_4 == "Exposed Crouch";
    }
  }

  return lib_0F3D::func_9D4C(var_0, var_1, var_2, var_3);
}