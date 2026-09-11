/***********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_trl_create_a_script_race_euphrates.gsc
***********************************************************************/

function ref_134ac(var0, var1, var2) {
  var3 = self._blackboard.throwdata;
  self.ispreppinggrenade = 1;
  var4 = ref_134c2(var0, var1, var3);

  if(!var4) {
    self endon(var1 + "_finished");
    wait 0.2;
    scripts\asm\asm::asm_fireevent(var0, "end");
    return;
  }
}

function ref_134c2(var0, var1, var2, var3) {
  var4 = var2.destination;
  var5 = var2.target;
  var6 = var2.withbounce;

  if(!isDefined(var6)) {
    var6 = 1;
  }

  if(isDefined(var4)) {
    var7 = scripts\asm\soldier\throwgrenade::getgrenadethrowoffset(var1, var2.xanim);

    if(!isDefined(var2.fastthrow)) {
      var8 = self checkgrenadethrowpos(var7, var4, var6, "min energy", "min time", "max time");
    } else {
      var8 = self checkgrenadethrowpos(var7, var4, var6, "min time", "min energy");
    }
  } else {
    var8 = var3.vel;
  }

  var6 = var3.target;

  if(isDefined(var8)) {
    if(!isDefined(self.oldgrenawareness)) {
      self.oldgrenawareness = self.grenadeawareness;
    }

    self.grenadeawareness = 0;
    var9 = reset_progress();
    scripts\asm\soldier\throwgrenade::setgrenadetimer(self.activegrenadetimer, min(gettime() + 3000, var9));
    var10 = 0;

    if(scripts\asm\soldier\throwgrenade::usingplayergrenadetimer()) {
      var6.numgrenadesinprogresstowardsplayer++;
      thread scripts\asm\soldier\throwgrenade::reducegiptponkillanimscript(var2, var6);

      if(var6.numgrenadesinprogresstowardsplayer > 1) {
        var10 = 1;
      }

      if(self.activegrenadetimer.timername == "fraggrenade") {
        if(var6.numgrenadesinprogresstowardsplayer <= 1) {
          var6.lastfraggrenadetoplayerstart = gettime();
        }
      }
    }

    if(isDefined(var4)) {
      thread scripts\asm\soldier\throwgrenade::dogrenadethrow(var1, var2, var3.xanim, var8, var9, var10);
    } else {
      scripts\asm\soldier\throwgrenade::dogrenadethrow(var1, var2, var3.xanim, var8, var9, var10);
    }

    return true;
  }

  return false;
}

function reset_progress() {
  var0 = undefined;

  if(scripts\asm\soldier\throwgrenade::usingplayergrenadetimer()) {
    var1 = self.activegrenadetimer.player;
    var0 = gettime() + var1.gs.playergrenadebasetime + randomint(var1.gs.playergrenaderangetime);
  } else if(isDefined(self.set_disable_leave_truck) && isDefined(self.set_disable_leave_truck[self.activegrenadetimer.timername])) {
    var0 = gettime() + 3000 + self.set_disable_leave_truck[self.activegrenadetimer.timername];
  } else {
    var0 = gettime() + 30000 + randomint(30000);
  }

  return var0;
}