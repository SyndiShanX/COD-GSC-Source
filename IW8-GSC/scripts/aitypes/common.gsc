/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\common.gsc
***********************************************/

function returnsuccessiftrue(var0, var1) {
  if(var1 == 1) {
    return anim.success;
  }

  return anim.failure;
}

function isvariabledefined(var0, var1) {
  if(isDefined(var1)) {
    return anim.success;
  }

  return anim.failure;
}

function setupwait(var0) {
  self.bt.instancedata[var0] = [];
  self.bt.instancedata[var0]["waitStartTime"] = gettime();
}

function dowait(var0, var1) {
  var2 = self.bt.instancedata[var0]["waitStartTime"];

  if(gettime() - var2 < var1) {
    return anim.running;
  }

  return anim.success;
}

function haslos(var0, var1) {
  var2 = var1;

  if(self cansee(var2)) {
    return anim.success;
  }

  return anim.failure;
}

function valuewithinrange(var0, var1) {
  var2 = var1[0];
  var3 = var1[1];
  var4 = var1[2];

  if(var3 <= var2 && var2 <= var4) {
    return anim.success;
  }

  return anim.failure;
}

function randchance(var0, var1) {
  var2 = var1[0];
  var3 = var1[1];

  if(randomint(var2) < var3) {
    return anim.success;
  }

  return anim.failure;
}

function cointoss(var0) {
  if(randomint(100) < 50) {
    return anim.success;
  }

  return anim.failure;
}

function ifisalive(var0, var1) {
  if(isDefined(var1)) {
    var2 = var1;
  } else {
    var2 = self;
  }

  return isalive(var2);
}

function ifselfdestruct(var0) {
  if(scripts\asm\asm_bb::bb_isselfdestruct()) {
    return anim.success;
  }

  return anim.failure;
}

function updateeveryframe_magicdoorchecks() {
  var0 = 110;

  if(self aigettargetspeed() > 90) {
    var0 = 180;
  }

  var1 = self getmodifierlocationonpath("door", var0);

  if(isDefined(var1)) {
    var2 = getentitylessscriptablearrayinradius(undefined, undefined, var1, 64);

    if(var2.size > 0) {
      var3 = undefined;

      if(var2.size == 1) {
        if(var2[0] scriptableisdoor()) {
          var3 = var2[0];
        }
      } else {
        var4 = var2.size;
        var5 = 9999999;

        for(var6 = 0; var6 < var4; var6++) {
          if(var2[var6] scriptableisdoor()) {
            var7 = distancesquared(var2[var6].origin, var1);

            if(var7 < var5) {
              var5 = var7;
              var3 = var2[var6];
            }
          }
        }
      }

      if(isDefined(var3)) {
        var8 = anglesToForward(self.angles);
        var9 = var3.origin - self.origin;
        var9 = (var9[0], var9[1], 0);

        if(vectordot(var9, var8) > 0) {
          var10 = var3 scriptabledoorangle();

          if(abs(var10) <= 60) {
            self._blackboard.doortoopen = var3;
            self._blackboard.doorpos = var1;
            return;
          }
        }
      }
    }
  }

  self._blackboard.doortoopen = undefined;
  self._blackboard.doorpos = undefined;
}