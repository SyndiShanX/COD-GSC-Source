/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: 3126.gsc
***********************************************/

func_98C6(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.var_E873)) {
    self notify("stop_move_anim_update");
    self.var_12DEF = undefined;
    self.var_E879 = 0;
    self.var_E873 = 1;
  }
}

func_11088(var_0, var_1, var_2) {
  return 0;
}

func_D50D(var_0, var_1, var_2, var_3) {
  func_98C6(var_0, var_1, var_2, var_3);
  func_E877(var_0, var_1, var_2, var_3);
}

func_E875() {
  if(isalive(self.enemy)) {
    return self.enemy;
  }
}

func_1006E() {
  if(!self.facemotion) {
    return 0;
  }

  if(!scripts\asm\asm_bb::func_298D()) {
    return 0;
  }

  if(!func_B4EC()) {
    return 0;
  }

  if(!scripts\asm\asm_bb::bb_movetyperequested("combat")) {
    return 0;
  }

  if(self pathdisttogoal() < 200) {
    return 0;
  }

  var_0 = func_E875();

  if(!isDefined(var_0)) {
    return 0;
  }

  return 1;
}

func_10070(var_0, var_1, var_2, var_3) {
  return func_1006E() && canshoottargetfrompos();
}

func_1006F(var_0, var_1, var_2, var_3) {
  return 0;
}

func_1009F(var_0, var_1, var_2, var_3) {
  return !func_10070(var_0, var_1, var_3);
}

func_1009E(var_0, var_1, var_2, var_3) {
  return !func_1006F(var_0, var_1, var_3);
}

canshoottargetfrompos() {
  return 1;
}

canshoottarget() {
  return 1;
}

func_B4EC() {
  if(!isDefined(self.weapon)) {
    return 0;
  }

  if(self.weapon == "none") {
    return 0;
  }

  var_0 = weaponclass(self.weapon);

  if(!scripts\anim\utility_common::usingriflelikeweapon()) {
    return 0;
  }

  if(isDefined(self.var_596C)) {
    return 0;
  }

  return 1;
}

canshootinvehicle() {
  if(isDefined(self.enemy) && (canshoottargetfrompos() || canshoottarget())) {
    return 1;
  }

  return 0;
}

detach(var_0) {
  var_1 = self.origin;
  var_2 = self.angles[1] + self getspawnpoint_searchandrescue();
  var_1 = var_1 + (cos(var_2), sin(var_2), 0) * length(self getvelocity()) * var_0;
  var_3 = self.angles[1] - vectortoyaw(self.enemy.origin - var_1);
  var_3 = angleclamp180(var_3);
  return var_3;
}

func_E877(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread lib_0F3C::func_136B4(var_0, var_1, var_3);
  thread lib_0F3C::func_136E7(var_0, var_1, var_3);
  thread lib_0F3C::func_136CC(var_0, var_1, var_3);
  var_4 = self.var_B4C3;
  var_5 = self.var_E878;
  var_6 = self.var_E876;
  var_7 = 0;
  var_8 = 1;
  var_9 = 2;
  var_10 = 3;
  var_11 = 4;
  var_4 = self.var_B4C3;
  var_5 = self.var_E878;
  var_6 = self.var_E876;
  self scragentsetorientmode("face motion");

  for(;;) {
    var_12 = func_E875();

    if(isDefined(var_12)) {
      var_13 = detach(0.2);
      var_14 = var_13 < 0;
    } else {
      var_13 = 0;
      var_14 = self.var_E879 < 0;
    }

    var_15 = var_7;
    var_16 = "f_anim;";
    var_17 = abs(var_13);

    if(var_17 < 130) {
      if(var_17 > 100) {
        if(var_14 == 1) {
          var_15 = var_10;
          var_16 = "lb_anim;";
        } else {
          var_15 = var_11;
          var_16 = "rb_anim;";
        }
      } else if(var_17 > 45) {
        if(var_14 == 1) {
          var_15 = var_8;
          var_16 = "l_anim;";
        } else {
          var_15 = var_9;
          var_16 = "r_anim;";
        }
      }
    }

    self setanimstate(var_1, var_15);

    if(isDefined(var_12) && isplayer(var_12)) {
      self _meth_83CE();
    }

    wait 0.2;
  }
}

func_D50E(var_0, var_1, var_2, var_3) {
  func_98C6(var_0, var_1, var_2, var_3);
  func_E874(var_0, var_1, var_2, var_3);
}

func_E874(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");

  for(;;) {
    if(isplayer(self.enemy)) {
      self _meth_83CE();
    }

    var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
    self setanimstate(var_1, var_4);
    wait 0.2;
  }
}

func_3EFF(var_0, var_1, var_2) {
  return 0;
}

func_FFF5(var_0, var_1, var_2, var_3) {
  if(isDefined(self.disablebulletwhizbyreaction)) {
    return 0;
  }

  var_4 = scripts\asm\asm_bb::bb_getrequestedwhizby();

  if(!isDefined(var_4)) {
    return 0;
  }

  if(!isDefined(self.pathgoalpos) || distancesquared(self.pathgoalpos, self.origin) < 160000) {
    return 0;
  }

  return 1;
}

func_D477(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  self setanimstate(var_1, var_4, self.fastcrawlanimscale);
  scripts\anim\notetracks_mp::func_1384C(var_1, "end", var_1, var_4);
}