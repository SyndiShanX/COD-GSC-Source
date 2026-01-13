/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3125.gsc
************************/

func_D4D9(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm_bb::func_2923();
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2);
}

func_B644(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm_bb::func_2924();
  return distancesquared(self.origin, var_3) <= var_2 * var_2;
}

func_B643(var_0, var_1, var_2) {
  var_3 = 50;
  var_4 = scripts\asm\asm_bb::func_2924();
  return distancesquared(self.origin, var_4) <= var_3;
}

func_D4D7(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm_bb::bb_getmeleetarget();
  if(!isDefined(var_4)) {
    self orientmode("face angle abs", self.angles);
  } else if(isplayer(var_4) && var_4 == self.isnodeoccupied) {
    self orientmode("face enemy");
  } else {
    var_5 = var_4.origin - self.origin;
    var_6 = vectornormalize(var_5);
    var_7 = vectortoangles(var_6);
    self orientmode("face angle abs", var_7);
  }

  self setanimstate(var_1);
  self endon(var_1 + "_finished");
  donotetracks_vsplayer(var_0, var_1);
  scripts\asm\asm::asm_fireevent(var_1, "end");
}

donotetracks_vsplayer(var_0, var_1) {
  for(;;) {
    self waittill(var_1, var_2);
    if(!isarray(var_2)) {
      var_2 = [var_2];
    }

    foreach(var_4 in var_2) {
      switch (var_4) {
        case "end":
          break;

        case "stop":
          var_5 = scripts\asm\asm_bb::bb_getmeleetarget();
          if(!isDefined(var_5)) {
            return;
          }

          if(!isalive(var_5)) {
            return;
          }

          var_6 = distancesquared(var_5.origin, self.origin);
          if(var_6 > 4096) {
            return;
          }
          break;

        case "start_melee":
        case "fire":
          var_5 = scripts\asm\asm_bb::bb_getmeleetarget();
          if(!isDefined(var_5)) {
            return;
          }

          if(isalive(var_5)) {
            func_CA1F(var_5);
          }
          break;

        default:
          scripts\asm\asm_mp::func_2345(var_4, var_1);
          break;
      }
    }
  }
}

func_7FAC() {
  var_0 = randomfloatrange(self.meleemindamage, self.meleemaxdamage);
  return var_0;
}

func_CA1F(var_0) {
  if(!isalive(var_0)) {
    return;
  }

  self.var_B5C7 = 1;
  var_1 = func_7FAC();
  var_2 = 1;
  var_3 = distancesquared(self.origin, var_0.origin);
  if(var_3 > self.meleerangesq) {
    return;
  }

  if(isplayer(var_0)) {
    var_4 = func_3D76(var_0);
    var_5 = func_3D95(var_0);
    if(var_4 || var_5) {
      return;
    } else {
      if(isDefined(var_0.isjuggernaut) && var_0.isjuggernaut) {
        var_1 = var_1 * 0.65;
        earthquake(0.25, 0.25, var_0.origin, 100);
      }

      var_2 = var_0 getviewkickscale();
      var_0 func_F329(var_1);
    }
  }

  if(isDefined(self.var_B62B)) {
    [[self.var_B62B]](self, var_0);
  }

  var_0 dodamage(var_1, self.origin, self, self);
  var_0 thread func_F5FE(var_2);
}

func_F5FE(var_0) {
  scripts\engine\utility::waitframe();
  self setviewkickscale(var_0);
}

func_3D95(var_0) {
  var_1 = anglesToForward(var_0.angles);
  var_2 = vectornormalize(self.origin - var_0.origin);
  var_3 = vectordot(var_2, var_1);
  if(var_0 meleebuttonpressed() && isDefined(var_0.meleestrength) && var_0.meleestrength == 1 && var_3 > 0.5) {
    return 1;
  }

  return 0;
}

func_3D76(var_0) {
  return 0;
}

func_F329(var_0) {
  var_1 = 10;
  var_2 = 2;
  var_3 = 50;
  var_4 = min(1, var_0 / var_3);
  var_5 = var_1 - var_2 * var_4;
  var_6 = var_2 + var_5;
  self setviewkickscale(var_6);
}