/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3125.gsc
************************/

func_D4D9(param_00, param_01, param_02, param_03) {
  var_04 = scripts\asm\asm_bb::func_2923();
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02);
}

func_B644(param_00, param_01, param_02) {
  var_03 = scripts\asm\asm_bb::func_2924();
  return distancesquared(self.origin, var_03) <= param_02 * param_02;
}

func_B643(param_00, param_01, param_02) {
  var_03 = 50;
  var_04 = scripts\asm\asm_bb::func_2924();
  return distancesquared(self.origin, var_04) <= var_03;
}

func_D4D7(param_00, param_01, param_02, param_03) {
  var_04 = scripts\asm\asm_bb::bb_getmeleetarget();
  if(!isDefined(var_04)) {
    self orientmode("face angle abs", self.angles);
  } else if(isplayer(var_04) && var_04 == self.isnodeoccupied) {
    self orientmode("face enemy");
  } else {
    var_05 = var_04.origin - self.origin;
    var_06 = vectornormalize(var_05);
    var_07 = vectortoangles(var_06);
    self orientmode("face angle abs", var_07);
  }

  self setanimstate(param_01);
  self endon(param_01 + "_finished");
  donotetracks_vsplayer(param_00, param_01);
  scripts\asm\asm::asm_fireevent(param_01, "end");
}

donotetracks_vsplayer(param_00, param_01) {
  for(;;) {
    self waittill(param_01, var_02);
    if(!isarray(var_02)) {
      var_02 = [var_02];
    }

    foreach(var_04 in var_02) {
      switch (var_04) {
        case "end":
          break;

        case "stop":
          var_05 = scripts\asm\asm_bb::bb_getmeleetarget();
          if(!isDefined(var_05)) {
            return;
          }

          if(!isalive(var_05)) {
            return;
          }

          var_06 = distancesquared(var_05.origin, self.origin);
          if(var_06 > 4096) {
            return;
          }
          break;

        case "start_melee":
        case "fire":
          var_05 = scripts\asm\asm_bb::bb_getmeleetarget();
          if(!isDefined(var_05)) {
            return;
          }

          if(isalive(var_05)) {
            func_CA1F(var_05);
          }
          break;

        default:
          scripts\asm\asm_mp::func_2345(var_04, param_01);
          break;
      }
    }
  }
}

func_7FAC() {
  var_00 = randomfloatrange(self.meleemindamage, self.meleemaxdamage);
  return var_00;
}

func_CA1F(param_00) {
  if(!isalive(param_00)) {
    return;
  }

  self.var_B5C7 = 1;
  var_01 = func_7FAC();
  var_02 = 1;
  var_03 = distancesquared(self.origin, param_00.origin);
  if(var_03 > self.meleerangesq) {
    return;
  }

  if(isplayer(param_00)) {
    var_04 = func_3D76(param_00);
    var_05 = func_3D95(param_00);
    if(var_04 || var_05) {
      return;
    } else {
      if(isDefined(param_00.isjuggernaut) && param_00.isjuggernaut) {
        var_01 = var_01 * 0.65;
        earthquake(0.25, 0.25, param_00.origin, 100);
      }

      var_02 = param_00 getviewkickscale();
      param_00 func_F329(var_01);
    }
  }

  if(isDefined(self.var_B62B)) {
    [[self.var_B62B]](self, param_00);
  }

  param_00 dodamage(var_01, self.origin, self, self);
  param_00 thread func_F5FE(var_02);
}

func_F5FE(param_00) {
  scripts\engine\utility::waitframe();
  self setviewkickscale(param_00);
}

func_3D95(param_00) {
  var_01 = anglesToForward(param_00.angles);
  var_02 = vectornormalize(self.origin - param_00.origin);
  var_03 = vectordot(var_02, var_01);
  if(param_00 meleebuttonpressed() && isDefined(param_00.meleestrength) && param_00.meleestrength == 1 && var_03 > 0.5) {
    return 1;
  }

  return 0;
}

func_3D76(param_00) {
  return 0;
}

func_F329(param_00) {
  var_01 = 10;
  var_02 = 2;
  var_03 = 50;
  var_04 = min(1, param_00 / var_03);
  var_05 = var_01 - var_02 * var_04;
  var_06 = var_02 + var_05;
  self setviewkickscale(var_06);
}