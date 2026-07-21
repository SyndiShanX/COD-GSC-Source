/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\common.gsc
***********************************************/

returnsuccessiftrue(var_0, var_1) {
  if(var_1 == 1)
    return anim.success;

  return anim.failure;
}

isvariabledefined(var_0, var_1) {
  if(isDefined(var_1))
    return anim.success;

  return anim.failure;
}

setupwait(var_0) {
  self.bt.instancedata[var_0] = [];
  self.bt.instancedata[var_0]["waitStartTime"] = gettime();
}

dowait(var_0, var_1) {
  var_2 = self.bt.instancedata[var_0]["waitStartTime"];

  if(gettime() - var_2 < var_1)
    return anim.running;

  return anim.success;
}

haslos(var_0, var_1) {
  var_2 = var_1;

  if(self cansee(var_2))
    return anim.success;

  return anim.failure;
}

valuewithinrange(var_0, var_1) {
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_4 = var_1[2];

  if(var_3 <= var_2 && var_2 <= var_4)
    return anim.success;

  return anim.failure;
}

randchance(var_0, var_1) {
  var_2 = var_1[0];
  var_3 = var_1[1];

  if(randomint(var_2) < var_3)
    return anim.success;

  return anim.failure;
}

cointoss(var_0) {
  if(randomint(100) < 50)
    return anim.success;

  return anim.failure;
}

ifisalive(var_0, var_1) {
  if(isDefined(var_1))
    var_2 = var_1;
  else
    var_2 = self;

  return isalive(var_2);
}

ifselfdestruct(var_0) {
  if(scripts\asm\asm_bb::bb_isselfdestruct())
    return anim.success;

  return anim.failure;
}

updateeveryframe_magicdoorchecks() {
  var_0 = 110;

  if(self aigettargetspeed() > 90)
    var_0 = 180;

  var_1 = self getmodifierlocationonpath("door", var_0);

  if(isDefined(var_1)) {
    var_2 = getentitylessscriptablearrayinradius(undefined, undefined, var_1, 64);

    if(var_2.size > 0) {
      var_3 = undefined;

      if(var_2.size == 1) {
        if(var_2[0] scriptableisdoor())
          var_3 = var_2[0];
      } else {
        var_4 = var_2.size;
        var_5 = 9999999;

        for(var_6 = 0; var_6 < var_4; var_6++) {
          if(var_2[var_6] scriptableisdoor()) {
            var_7 = distancesquared(var_2[var_6].origin, var_1);

            if(var_7 < var_5) {
              var_5 = var_7;
              var_3 = var_2[var_6];
            }
          }
        }
      }

      if(isDefined(var_3)) {
        var_8 = anglesToForward(self.angles);
        var_9 = var_3.origin - self.origin;
        var_9 = (var_9[0], var_9[1], 0);

        if(vectordot(var_9, var_8) > 0) {
          var_10 = var_3 scriptabledoorangle();

          if(abs(var_10) <= 60) {
            self._blackboard.doortoopen = var_3;
            self._blackboard.doorpos = var_1;
            return;
          }
        }
      }
    }
  }

  self._blackboard.doortoopen = undefined;
  self._blackboard.doorpos = undefined;
}